Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E2B7FD9E22
	for <u-boot@archiver.kernel.org>; Thu, 26 Feb 2026 23:45:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7BDD583EDF;
	Fri, 27 Feb 2026 00:45:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="I6TnJLKb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD8B683D1A; Fri, 27 Feb 2026 00:45:20 +0100 (CET)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89E1883E96
 for <u-boot@lists.denx.de>; Fri, 27 Feb 2026 00:45:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-b90bc00578cso216381566b.0
 for <u-boot@lists.denx.de>; Thu, 26 Feb 2026 15:45:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772149516; cv=none;
 d=google.com; s=arc-20240605;
 b=c7pkR6Bv8khuyiygzF9elNotYg1tq4MKCUxb34JIP78AKIJt8uKqJqiHbNf1z9NxDS
 D2vK0mHyhIVgx3naebdO5dnO6p/+TnY3bH+FpdXnVHeWecEUaXWj5DvRScPptWAnLmj8
 pX5yzEXSvVN3YGjsNIFq1vXCHf4JAUD7gHeySqGIelYBvIVNo1NPi0EJQVvha4l+iGfg
 /fOa21ZSRs9ZFHxyw+rYxy3CIu4iHYOldlPlSgk55/LNNLw4zHg/NFCIwn1lRmKwfl5f
 ErAkiI0uGHxBXiXkFYTWk88hAkttOM2S3IXEJW17hxtbHUdx2HeVjuKtQCwervZSF/74
 uSHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=xtxulF8U1JxZghy+56MvkPSqIJxSkt90cwA8ovzGAJk=;
 fh=tTrm+NDWZ+bKYNPm5ycZeumOFFfXWCXTLR/O1kyndk4=;
 b=jFx3gwqSf0xPLLG1lVPCJdhldUc1Klr8RUFFGERhUBwYZ5AzQCaf+x9Jk2YhINXdit
 /1GHVPGWKnQxNyiiNKPPofodlpuyyqbInf3mMGm55j4rVYFtHnNtnFH6ep7rPo9YGkKV
 s14H9EHIKki3CXlOpOAdDfi+fgRomV4VOLp4ogcS78/RYqPEkAlo9dFkzNo/gCFcnRGe
 a0K5ruDloIZqh1h5sK+L1B/TEJ/y6o1V22zsXZ8Kkdskf+mk7MBN3HQ0YUVStcI/MBnb
 9tvHHZpHgtSi4TW4P18ThoGd4f/3asY+LfI25A14qinDfi8BTRrW++2sWVKCyiF9nt5O
 t+kA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1772149516; x=1772754316; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xtxulF8U1JxZghy+56MvkPSqIJxSkt90cwA8ovzGAJk=;
 b=I6TnJLKbJR3loO4ayPqeakwtnKTXZqLbS6PHXeRv3LnDAMvmz2VPCV682mYrt0cFrG
 shqAYta3ZEuEOrkswKs1hlsVwc5nA/NIwOxMkOLiUzGdAGqPiNbbZzjl/QEF0DzOF4ou
 PxnPzspHJLCiTT6UYeAP9YkkEk+UMT4b2tzwI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772149516; x=1772754316;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xtxulF8U1JxZghy+56MvkPSqIJxSkt90cwA8ovzGAJk=;
 b=MCTKokhdEMhGyqimmFFNkbnrzsZ9qhtPk//oSF2npAcKFXtiPcfhstkGUc3AwTcYM7
 m6sbZdyxSs1tnkpDlQX+Fm177h/m6pHqDuRdTNN8t3dxFA71DEj89kJUXc4U/1T7GVTd
 r6KKQeKIj5bHNiWbbiO9z9ZoGz27HARY/D/uiIGraz6UgaApA/An2D4w3DhYX+iH9qqK
 YWBdAaP8JbkZN6Sl5lsDVLZOTZpzEEy0lW8HwqupltZVbmo5m6PXsyQ2hdCTW54DHdXa
 yMWR+iFcWsSiskPGaTORviGlV1lVwerMlP3D47AmBrJzKv5k4N9P7hNEjulfY5SYrPRe
 16Fw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZgHTbbombyQXKIZ7lBnAjEqGUTEDYo48mWTspsvP92hvGmiJXS+zZh1W8rm4Dd7cBnrz9XtA=@lists.denx.de
X-Gm-Message-State: AOJu0YwPHURMcYJQSBn1EJUvUkIwd+BEBFivUln4QZ6PxsStTvi7ErDo
 rSgl3O0PbGNuRoHJSf3g5An22zottet4KhwaxaV8eig/4JLOtxMdXa2CY+X9XwE+fM3QHIQUx95
 Jr3C5rAIofsZvU1vXcOtmSr+yLYJ8/74CQytfNxxy
X-Gm-Gg: ATEYQzxHDtp/o/F4FhG3v6Yuu3Ai2rN6OaTOdW5GV4lvIv3QTGNPirB0pDwdyh/jhFi
 GtgweBifRAWhI5mu9LKFWQIRBB7CwLnCuc3MrbV5HKbR9RH1tuZfzfVjf+pg5xxMAUcJ+mxy2BX
 3ZZw6N2Zfv2JIvkOTwDr9OgDQBNxQtZVHD18uMOu7uivDS9eucnKrFL1JHTKNd0JBYR9fkwWrJR
 hK5DwPyK5Ukc2ui6fRFHqW9FJ6dIUqSY5oKHz0aVtocpLB8HQ0GBgdypniRXsEPoyCzE+oI4iRw
 FZuvHw==
X-Received: by 2002:a17:906:e0f:b0:b87:c92:25bf with SMTP id
 a640c23a62f3a-b9376511177mr30979266b.33.1772149515945; Thu, 26 Feb 2026
 15:45:15 -0800 (PST)
MIME-Version: 1.0
References: <20260225073711.51688-1-heinrich.schuchardt@canonical.com>
 <ee169196-69a3-4003-8531-0ffa4e76bf6b@cherry.de>
 <e9d98d0b-578a-41ef-9440-00ea615d224d@canonical.com>
 <d00103df-8188-4039-b618-dc48ab1c1a39@canonical.com>
 <8f18322a-e269-4839-a178-6cd2bf4aa488@cherry.de>
In-Reply-To: <8f18322a-e269-4839-a178-6cd2bf4aa488@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 26 Feb 2026 16:44:52 -0700
X-Gm-Features: AaiRm51cyk_Y4-c3mJ60TTVHAoUyFkf9hrG-MuLLNXmIi7rEuxJj872IrYkr1Rw
Message-ID: <CAFLszTgmgfwLtoS9hACwd9BS+L6Gm91j6i+QCvOGvweY7SchzA@mail.gmail.com>
Subject: Re: [PATCH 1/1] boot: don't select non-existent CONFIG_VPL_CRYPTO
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Tom Rini <trini@konsulko.com>, Kory Maincent <kory.maincent@bootlin.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Peng Fan <peng.fan@nxp.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Martin Schwan <m.schwan@phytec.de>, Anshul Dalal <anshuld@ti.com>,
 George Chan <gchan9527@gmail.com>, u-boot@lists.denx.de
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

Hi Quentin,

On Thu, 26 Feb 2026 at 07:54, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>
> Hi Heinrich,
>
> On 2/25/26 1:21 PM, Heinrich Schuchardt wrote:
> > On 2/25/26 10:06, Heinrich Schuchardt wrote:
> >> On 2/25/26 09:37, Quentin Schulz wrote:
> >>> Hi Heinrich,
> >>>
> >>> On 2/25/26 8:37 AM, Heinrich Schuchardt wrote:
> >>>> Symbol CONFIG_VPL_CRYPTO does not exist.
> >>>
> >>> Correct but I have a hunch this was based off of SPL_FIT_SIGNATURE
> >>> which does require crypto support, so I'm assuming VPL would too.
> >>>
> >>> But this symbol indeed never existed, and even if it did, it wouldn't
> >>> compile anything else as far as I can tell since drivers/crypto is
> >>> enabled by default in proper and only if CONFIG_SPL_CRYPTO is set for
> >>> SPL, and only SPL (checking for !TPL and !VPL)... so something feels
> >>> unfinished with VPL here to me.
> >>>
> >>> I'm not sure we're improving anything there but I don't think it
> >>> makes things worse, as such
> >>>
> >>> Fixes: 4218456b3fac ("vbe: Add Kconfig options for VPL")
> >>>
> >>> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
> >>>
> >>> Thanks!
> >>> Quentin
> >>
> >> Thank you for reviewing.
> >>
> >> There is a symbol CONFIG_VPL_MBEDTLS_LIB_CRYPTO that might be used but
> >> then VPL_FIT_SIGNATURE support would have to depend on MBEDTLS.
> >>
> >> Maybe Simon can inform us what his design intention was. Adding a
> >> defconfig actually testing VPL_FIT_SIGNATURE would be helpful.
> >>
> >> Best regards
> >>
> >> Heinrich
> >
> > There are more non-existent symbols implied by VPL_FIT_SIGNATURE
> >
> >          imply VPL_RSA
> >          imply VPL_RSA_VERIFY
> >
> > @Tom
> > I wonder why the VPL feature was suggested if it was never tested or
> > used. Should we remove all of VPL?
> >
>
> As far as I remember, VPL was a necessary step to add support for VBE
> (Verified Boot for Embedded) that Simon was working on. I don't think it
> got realized entirely (upstream I mean) which may explain the current
> state of VPL symbols.

Heinrich asked me the same thing this morning. From my understanding,
the penultimate series was applied but later reverted. The final
series was never applied. It's in the Concept tree for now and is
running fine on an rk3399 board:

https://concept.u-boot.org/u-boot/u-boot/-/jobs/300379

If there is any interest in getting these two series in I could resend.

Regards,
Simon
