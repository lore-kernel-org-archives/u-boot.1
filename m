Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E408E784A8
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 01:42:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B6D4874BE;
	Mon,  2 Oct 2023 03:23:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mfsPl0nl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA236874AE; Mon,  2 Oct 2023 03:22:56 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C177F871A1
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 03:22:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5334f9a56f6so21105548a12.3
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 18:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696209761; x=1696814561; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=99OGQEAs+fHxd32byTn0N4U6E/5MBn9IRkcPbQ0FrTg=;
 b=mfsPl0nlmHTK6xP05jDXoN2/2b6xfVQQXF6jquNqN85QTuqZo+6DIey81+J5bB4UI9
 a2EYUOI3wFwIpD36VyQ9r8oaUIBXBPpvAXRvCMBAkfh3C9GMmYBTSyyoq0yTZ0+8PGLi
 wTUvBrz2Jvz7OwiJlLWrLJbswRRCXnjGAdrtY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696209761; x=1696814561;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=99OGQEAs+fHxd32byTn0N4U6E/5MBn9IRkcPbQ0FrTg=;
 b=n4iWUzC4oh5xd9PnhjRGhqrRkS2t8IFNnw5Hk6H0jgRpI2IDttCFCo2ks6r64iAw9V
 pmPbz062UdWFsMjLAAGNRj7D+vbM942lw6oWmNXjEw9dYpr1IuC/n9Paok8GEpc8ABxV
 UxecTAd47UuXaLiodHvfwEaYbxJ09S93VHbGAncDPk4pheHKU4BZCNcZP0GfsZH/plWS
 C+9jfzY8zCm06oJOop2GLvNVk++CQPXaH4INBBwf+XTDYRCRYWZCZ6VWpAvA6L3klqRU
 AxnToDtPT+d4UQXmW9xx5IqcnLUHsP/AXDCV/fYKxute1B07TtOJ8ZNRTe9vH2MhWUmA
 D5Bw==
X-Gm-Message-State: AOJu0YwQoBJOAMJ8BAsqHYyJspCWzm5DwqtctBdboGa4kEvY8RWL2MTm
 fSyEb6hekWq46i0E4f5bDykXAxhbkE+3+CHBd8T+/g==
X-Google-Smtp-Source: AGHT+IGc21ErXnOHpqx7Xey20DzmBLbBDUazUHY/g7E8uNpgHQP3Hgdy+o9KeHY0I97+gjLZXAA/ATZkh15ZwdlmR3Q=
X-Received: by 2002:a17:906:8468:b0:9a1:cdf1:ba6 with SMTP id
 hx8-20020a170906846800b009a1cdf10ba6mr6916862ejc.12.1696209761083; Sun, 01
 Oct 2023 18:22:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230926084346.2237483-1-bmeng@tinylab.org>
 <20230926084346.2237483-5-bmeng@tinylab.org>
In-Reply-To: <20230926084346.2237483-5-bmeng@tinylab.org>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 1 Oct 2023 19:16:56 -0600
Message-ID: <CAPnjgZ2TJm7g9MX77XKJE0Y5D+ExwQKaVGT=CpyAjZft-W+TMQ@mail.gmail.com>
Subject: Re: [PATCH 04/15] blk: host_dev: Make host_sb_detach_file() and
 host_sb_ops static
To: Bin Meng <bmeng@tinylab.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On Tue, 26 Sept 2023 at 02:48, Bin Meng <bmeng@tinylab.org> wrote:
>
> They are only used in drivers/block/host_dev.c.
>
> Signed-off-by: Bin Meng <bmeng@tinylab.org>
> ---
>
>  drivers/block/host_dev.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
