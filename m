Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E32FFE784A7
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 01:44:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CC9687504;
	Mon,  2 Oct 2023 03:23:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="j8vz9+3M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22396874CE; Mon,  2 Oct 2023 03:23:21 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58531874CD
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 03:23:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-52fe27898e9so21890981a12.0
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 18:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696209790; x=1696814590; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xIt7zv7jinr4bZpVQcptWsxe5for+ai+29i9t1zi5EA=;
 b=j8vz9+3MmzF2ASiT8g6XqplEAeQA9Ft4epQm+CPeE+zihcPVLTxhg4zvD+io5pxrCn
 J2O3NfPtAzd9Rx/eCB8/hCXjYVq6BUEo1hXNThDlL0581RrdFfUONMkLEYzUEe5jZtN6
 ZW+k68Df3wzcikyGRV4eDeT1SQLfgzP96NeEQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696209790; x=1696814590;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xIt7zv7jinr4bZpVQcptWsxe5for+ai+29i9t1zi5EA=;
 b=gYxpOYcpLd+zaOrZTCOTkj/2+19Jjeqe9KJo52NxFrensO81UUtLqKGo1mwdDDA74U
 BNf2jK/yKEMRofVI4bGEwuIHVK5ounkJG0l3GfQCPDLqjBpcWOF23LKDBKX8BVlvbaXD
 3AkCkmUfRDGQtosvH4a7VnwzWSuc1cJBJYpkStu6BhDf1sP9ZIs8fkKD5mryX/3Z5yFy
 HVwXFTC37Hq1fRpMem1rWUvuAsr2TieC6GL0An6b2awdbg1yYBx8rlClwjv8CZ5p9qkj
 gvCdXyNEiT6BMTDE5TYQwUQ3Ebc/67MYpCB0c7eaxYvIN6+h+4J4NOWIRCOqj3FHfKka
 mZtQ==
X-Gm-Message-State: AOJu0Yz6DjYDd9jttjD+W98v01XC4RtUGxuj8RSY68NqoXqTTDLkMV/x
 XDAT7XmMW6NFE51BqxTYS+WTkDtNUG3ImkL4xsBhRma944pPX06ghBg=
X-Google-Smtp-Source: AGHT+IFfCt7Cs6IdyWZCgLPsj9dUHPJVXZ9Mcg+/NwkRIwyuoRGos4s/UUvbNgaatdJ44JwL7GIANdn+EO3iyaTHIts=
X-Received: by 2002:a05:6402:b57:b0:522:4dd0:de72 with SMTP id
 bx23-20020a0564020b5700b005224dd0de72mr8013356edb.27.1696209790271; Sun, 01
 Oct 2023 18:23:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230926084346.2237483-1-bmeng@tinylab.org>
 <20230926084346.2237483-3-bmeng@tinylab.org>
In-Reply-To: <20230926084346.2237483-3-bmeng@tinylab.org>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 1 Oct 2023 19:17:23 -0600
Message-ID: <CAPnjgZ3NvXP9+LHBupt1V2T+NLHH6FOnBtmvJkY_2Q7XfLkgHw@mail.gmail.com>
Subject: Re: [PATCH 02/15] cmd: host: Mandate the filename parameter in the
 'bind' command
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

On Tue, 26 Sept 2023 at 02:46, Bin Meng <bmeng@tinylab.org> wrote:
>
> At present the host bind command does not require filename to be
> provided. When it is not given NULL is passed to the host device
> driver, which ends up failure afterwards.
>
> Change to mandate the filename so that it is useful.
>
> Signed-off-by: Bin Meng <bmeng@tinylab.org>
> ---
>
>  cmd/host.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
