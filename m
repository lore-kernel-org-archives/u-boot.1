Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7661BEE49A4
	for <u-boot@archiver.kernel.org>; Sun, 20 Aug 2023 21:58:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C965786BB2;
	Sun, 20 Aug 2023 23:57:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FlQ0JEMP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4383A87000; Sun, 20 Aug 2023 23:57:38 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5361B86EB7
 for <u-boot@lists.denx.de>; Sun, 20 Aug 2023 23:57:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5236b2b4cdbso3419189a12.3
 for <u-boot@lists.denx.de>; Sun, 20 Aug 2023 14:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692568655; x=1693173455;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=N4gzr1i36Vrf/DD/LzTV0Ayu6r8o7Ir2klbiCHF3Qpw=;
 b=FlQ0JEMPzhkjm3jWqXRs2MSVD4KfP8c/buEk8sxT2aAxSiGPRxQwm1c3sPhi9TabDt
 NRmrCjHNpQhES/XfXACthRho6Ol7D4SQKJYFF45w3yV+dggvrHK2Syp3DMlKy8/MZo4p
 n+8B0RN5NzKugpKWPdAhThLUGoYqfrG4kDGZ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692568655; x=1693173455;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=N4gzr1i36Vrf/DD/LzTV0Ayu6r8o7Ir2klbiCHF3Qpw=;
 b=cd2tL1JDeaTxPl2wk4iVHytmy0nqPEBtrgYWwgnIsCUnBTCRULBWpbAx6L1Khcavdv
 cmHhbqUjPwkRKWBK1c5Zqn3bTmEem9frlnZwElOpWVjAhjE08mCivstcjl83XbbNEPYc
 mGXeZptOB3ZCnDkXM2jd7acizUinX0SDKV93n68GuESi+f7X7K9FwWwSTwqDdUjbTjFD
 Z5Nf6lWrRdkCh6Z9J7dW2ASFZMc9AaH0XoHHNWj/YDFuIUJ2GpzQ6UDqJa/BC8F8ZVyS
 64jkTiCFZ+94zNcmgGe0iqGm8Of8EYb+7LTUEtmAJRh/EILFOu7VW2zg0Agw0gBwT8aA
 dkiQ==
X-Gm-Message-State: AOJu0Yw1Ki6UqVzeVoshJtxMtF4icu20Ld6J03Ag3AU6vpHqcDLXQdGx
 Oe0xQ4UrQryTb3GEPuhcRJny01s5BUnTk1KQJguJyc26RmcqA8/dWhE=
X-Google-Smtp-Source: AGHT+IGRrAoVfrRu7ZkNBmX1rtkKDtd5Ed6GNkzQn9O7uzLmJrA9O/1OujRpOGeyIY74kM5D6oIfuZDK8UEWFHQe2G8=
X-Received: by 2002:a05:6402:2025:b0:521:ae63:ee63 with SMTP id
 ay5-20020a056402202500b00521ae63ee63mr3759795edb.16.1692568654944; Sun, 20
 Aug 2023 14:57:34 -0700 (PDT)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 20 Aug 2023 14:57:34 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <CAPnjgZ0Ve72Ku-bZSfo4x=ZFsm-QY8iwV8u4B1eMVXsdQ0G9zA@mail.gmail.com>
References: <CAPnjgZ0Ve72Ku-bZSfo4x=ZFsm-QY8iwV8u4B1eMVXsdQ0G9zA@mail.gmail.com>
 <20230813051506.612351-1-marek.vasut+renesas@mailbox.org>
Date: Sun, 20 Aug 2023 14:57:34 -0700
X-Google-Sender-Auth: NQAkaSkm9fAVA6MXjduzVFI87IM
Message-ID: <CAPnjgZ3-rVtidDSXOh9mrLwKyq1=SyKVAu33=YPrd-ns=Ljztg@mail.gmail.com>
Subject: Re: [PATCH 1/2] configs: sandbox64: Enable video 16bpp and 24bpp
 support
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
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

On Sat, 12 Aug 2023 at 23:15, Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
>
> Align the sandbox64 defconfig with sandbox defconfig. Enable missing
> 16bpp and 24bpp video support. This fixes ut_dm_dm_test_video_bmp16
> and ut_dm_dm_test_video_bmp24 tests .
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Simon Glass <sjg@chromium.org>
> ---
>  configs/sandbox64_defconfig | 2 ++
>  1 file changed, 2 insertions(+)
>

Reviewed-by: Simon Glass <sjg@chromium.org>

Applied to u-boot-dm, thanks!
