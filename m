Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ECF6E95A77
	for <u-boot@archiver.kernel.org>; Sat,  7 Oct 2023 23:18:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9CCA86EE0;
	Sun,  8 Oct 2023 01:12:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="R4wSbj+d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23B7786D3F; Sun,  8 Oct 2023 01:12:18 +0200 (CEST)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C50986E22
 for <u-boot@lists.denx.de>; Sun,  8 Oct 2023 01:12:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-5a1f00b75aaso39199337b3.2
 for <u-boot@lists.denx.de>; Sat, 07 Oct 2023 16:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1696720295; x=1697325095; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LyW6FcVZ4UIBoP4cIPv71u7vNFU7O/P/kcLnYKvg0LU=;
 b=R4wSbj+dSqKDxOKqP1VhOJ9Xr9I+ega0i9Rf60mg+ooHuHXGdJxKE7dd8BjdiRvCII
 6W53PgR16gCyi24VmMuAP4l48rftkkWJAgvFcFhA7RSX0lMY7CPHM6tRc3QzDWTfi+zA
 OdWSCMAI0JbBugN6B8kz2ABIWtwJsgHzZLTEBqPyEqzpdEvtwV2sJOCQ5CcnP87qsCrf
 sKxweUcZKvVfT5ih5amwAsqEbm+8ddW+l/bZ3UW1IRkBgdUAHKAiHSy6eIjb5lvl44SK
 sDhROrnqZElFa77c6C+oZgSMvC+P2/ZZPDMgHUrmAxu/BoTebz6ep0or4EK9I8hUrNTR
 WV3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696720295; x=1697325095;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LyW6FcVZ4UIBoP4cIPv71u7vNFU7O/P/kcLnYKvg0LU=;
 b=lXJQ/pgco7Mk05a6jTxYD9ph1L/LBwlxDDLFUKjeYN576TSKR03qBhyaUKyFf1IOLM
 TOwLnq1WrvNDg8Hd73b72KID4n8FWnjOvsHSx8C1RaAsftyE4/uWczd5CncfE4aFK4e/
 KwibiXwOtRJv3iHKfbw7JQfuWsECADrqluTXUFMLgUHL/d9vTIq55XBhfTNf8ZhcR0vY
 Exb8wwB0leqVeVXweM3eNQGad61DYmRvLs7jE8cTPdyTHpFMUW5pU2LTtrM8wWT4PHv7
 LPtOR2j7tkqUnmOHbxzk/+15uPO29kNnEqoQR59LHgjJBSBYQct94SDu9kSLI4qc/tdQ
 6fPQ==
X-Gm-Message-State: AOJu0Yyzomhsx5yhmp0nH0+fDg00bq4hob8Jt2PIeMmotHBSPG6NlI2w
 ZSKRfxKa25VhH+D73azvbRMvXh2Yf7PDL6oUamBYFg==
X-Google-Smtp-Source: AGHT+IHoCscVg32WhtMn9RwjkIC/JOB2QfgD5x15k3oVFraL210o/huQFKusT6+5vCBwUsMz9Ivv4i1uZb3KimiAnzA=
X-Received: by 2002:a05:690c:3693:b0:5a7:3cc8:f206 with SMTP id
 fu19-20020a05690c369300b005a73cc8f206mr6234734ywb.40.1696720294606; Sat, 07
 Oct 2023 16:11:34 -0700 (PDT)
MIME-Version: 1.0
References: <20231006112351.2275090-1-randolph@andestech.com>
 <20231006112351.2275090-4-randolph@andestech.com>
In-Reply-To: <20231006112351.2275090-4-randolph@andestech.com>
From: Simon Glass <sjg@google.com>
Date: Sat, 7 Oct 2023 17:09:55 -0600
Message-ID: <CAPnjgZ2aJMScxYzW=2YUpvNk_gRZNysX8EMSCvs5x7Q-O5gn-Q@mail.gmail.com>
Subject: Re: [PATCH RESEND 3/7] spl: riscv: opensbi: change the default
 os_type as varible
To: randolph@andestech.com
Cc: u-boot@lists.denx.de, randolph.sklin@gmail.com, dylan@andestech.com, 
 tim609@andestech.com, peterlin@andestech.com
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

On Fri, 6 Oct 2023 at 05:26, Randolph <randolph@andestech.com> wrote:
>
> In order to introduce the Opensbi OS boot mode, the next stage boot
> image of OpenSBI should be configurable.
>
> Signed-off-by: Randolph <randolph@andestech.com>
> ---
>  common/spl/spl_opensbi.c | 26 ++++++++++++++++----------
>  1 file changed, 16 insertions(+), 10 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
