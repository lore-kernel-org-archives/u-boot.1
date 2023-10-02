Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61DB2E784A7
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 01:43:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA403874A3;
	Mon,  2 Oct 2023 03:23:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="P5z/fwWu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C4EA874B8; Mon,  2 Oct 2023 03:23:01 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F0B1874A6
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 03:22:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-9b275afb6abso568215266b.1
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 18:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696209764; x=1696814564; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8JPNaTPbOH2no71aJjBoQflBT9o+NfCawljeohwSyts=;
 b=P5z/fwWuqpFVP4ohx7BKiayG6ZJfLKR08pZ4dNmFK210oRzXeUlIRcc0f0GUAoi4Z9
 4O7qH9LX5hUzR/DDUD1F3diIsaHZ4GbiF6JZspOO44KJMt/O7T5teiuFxBQeJC47TvpW
 Ukmq8OCpeW1suQpiHciSZyLj3awrB3rtA4bF4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696209764; x=1696814564;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8JPNaTPbOH2no71aJjBoQflBT9o+NfCawljeohwSyts=;
 b=RK6ICvYK9ZIuh6vhSHqOgfgQGv4Vj6c8vqwZzaNLFhIM0Eld4DirBZSpOtRWvn2Kkk
 aSddkf9mBFJZ57OR1B6nn3scZVrO0nFj5NxzRdz6OKi0QbOQuI3PYt3Q97Z0KM8gaFaO
 C036L+BzRIycXQz/A0TNaehE58UX3aw9HjXfWD2jPrFX8G4270+EDbFlnUyCYlJTUj7Q
 yzAniXkTRjhrQR9BG76jfcVR4/1Tn9/xedoVJcMiNdiOH7bJsp2CDwFR/9tld+dQNZaX
 u40k65hFAkl71OCKpOfP1CnA5dh2OELZix3WJkyeAZZG8knBHuO+Uo5Scw8QB6QtM4qV
 PJjg==
X-Gm-Message-State: AOJu0YznytBSfC97hYBEg1A7mutKVRibAxSR8H7hk1goHmgin7FU/0WH
 UECvkiOY5ArIkQYAqi6cW5i0mv91P9K7CgrgDAB/O4cMDwCVtRPQTvU=
X-Google-Smtp-Source: AGHT+IEN1s13XZDz5XzOga1t5qfiBhfq5xBJ+inv4lnLPZ/Y3Bq+4zRBHJnLeWxhFaFW/CVeoj6PQNtRHd5pHPrWYdM=
X-Received: by 2002:a17:906:7695:b0:9b2:b15b:383d with SMTP id
 o21-20020a170906769500b009b2b15b383dmr10971756ejm.11.1696209763894; Sun, 01
 Oct 2023 18:22:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230926084346.2237483-1-bmeng@tinylab.org>
 <20230926084346.2237483-7-bmeng@tinylab.org>
In-Reply-To: <20230926084346.2237483-7-bmeng@tinylab.org>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 1 Oct 2023 19:17:00 -0600
Message-ID: <CAPnjgZ3y4HCiyKMwxzr72n-VBLkoy_Dz2DwQGcHLCWO6enuRfA@mail.gmail.com>
Subject: Re: [PATCH 06/15] cmd: host: Print out the block size of the host
 device
To: Bin Meng <bmeng@tinylab.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
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

On Tue, 26 Sept 2023 at 02:53, Bin Meng <bmeng@tinylab.org> wrote:
>
> It's useful if we can print out the block size of the host device
> in the "host info" command.
>
> Signed-off-by: Bin Meng <bmeng@tinylab.org>
> ---
>
>  cmd/host.c     |  7 ++++---
>  test/dm/host.c | 20 ++++++++++----------
>  2 files changed, 14 insertions(+), 13 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
