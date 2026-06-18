Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08196CD98F6
	for <u-boot@archiver.kernel.org>; Thu, 18 Jun 2026 15:53:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66EF3849C5;
	Thu, 18 Jun 2026 17:53:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JzlWjExe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE935849AE; Thu, 18 Jun 2026 17:53:52 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B59C849C5
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 17:53:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-68c19f1f3ceso1822894a12.2
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 08:53:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781798029; cv=none;
 d=google.com; s=arc-20240605;
 b=A0gHkjQFre+V0tMf8cpReL6phYcO9pN7u8RAmVOWPvxYmFj8qjMQEtP9AY1v7gHEWs
 47UL0V5lN5veQaHPGxw8ek4gGpZMcjgncL99pDVoQnQjGsfXWv/BYN2nDssJCPL4NCSj
 L9YyQ+v5ChJ11rasC35jUclHPSdqbiyXeihgQhbxVrZU+3Yl5GfNjg+nnFbbhXwfu4NE
 d7IaX+b2b7Nm3R/FI0QUMDvR4VaZQplNIVp/GfEDUoD8Lyv3KPtv8mQFOBFvEdTkMrhw
 vCveqGBNkddhMf2VMIvAzJK2PiQ4FmwF0MtnTFcPyPRvLBB8IZ3TWCcFxmOBIkaCsfdo
 ptHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=LQ0rbuoRcAn4bZwBStMoYa+pfsH1qsw6Ho4j01QWxHs=;
 fh=DYMU3dRED0rmVKTDqXRHxrZw93vonVJHh6vC8tHyRiY=;
 b=Wl6LJONkd6ThqhyIXVf010I0oCeBgfLkQufG5S8e+ipW+4pCf9EXcjVOSJciswdBIA
 tMKVP5LJYs2XVgFjqjmtuVbu5g3A659lhTdwovzns4LpIQDOW/8XVneXlg4cP9J+693N
 eVcClPxFek7NqS4hSP6WHOpMwHdbFEDTNM4u+BcS308IDmtVUuxXJNWGloejDOilFcag
 vcFDwyrmrS6t2RFTiK+AWKCF1yEVJCgHgpTxVVaDu7kAYQ+RFUnxKOWgwZWauYA+N5MN
 OMETKMo68IMuev98LUxLwK5VuQheEWTUKj3vx6rb9nME+XNGwz43Jecb9O51LlZDHTO2
 5VFg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1781798029; x=1782402829; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LQ0rbuoRcAn4bZwBStMoYa+pfsH1qsw6Ho4j01QWxHs=;
 b=JzlWjExeSjppT1eGdMIt0QqiWl8UB+/gVm27XowC3/4BeerACiAl0HcgVxKhrtGzQn
 FEMYx8L57sMy3txvvb1y768ROZfBgc7LndbqOPAV8IyfNcWBPq+3H4CcliHpoeTZDN8p
 kg30fwFpGvaXozwj1DyA1rBFnkkq4EPwnTacA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781798029; x=1782402829;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LQ0rbuoRcAn4bZwBStMoYa+pfsH1qsw6Ho4j01QWxHs=;
 b=LSvAbuHgasPyjo/H4yC0CSY6zo+FomL2u7+76Plb25iOqgHt1rkZmH92jI9rcg82N3
 3DJkzqT5yRqYKrfZNA8Fj+juUjGCmn2t+3Dk1Vi+p3YDjrrTl0eIyJWEneHNwk+gBK1W
 oTnPC7FG8fl33Bm9z0wLS2fMfo83q/oIjysoSIWhTHGCpJmpInylvdwAhSqbJGEABVbI
 x5vJRe/HkTsxvpOa+vMRptZZzGrA3kdjSCFR/omLc6SDc1n1fSYajd7MbxDDwlEdwmhl
 O4O942uvtxbuE4R1kyqDLqXlgy7UCO0/YXt2Q/H6CdCBYCRa7aSlBUYNb+/eHsdFvqGD
 vF1g==
X-Gm-Message-State: AOJu0Yw/VGusdupXPNe3AghZeBqr7e7zuTHJH6aKVGISb1I+wqFqW7qk
 lQiqGpWHEIqnGIjDhYEmmyZV2sHQcIFrQM6cJlnyuihIWleAJ+Pp0cnJSJXS0fYZhBF+D/rrB3V
 lexKffys58CDhgMKVX/UMORkdxBVSRUwOgFkyHvBV
X-Gm-Gg: AfdE7ckYn5UXndB6kS+6XicyhbgnYnS/Nc1aOK3ZAWNOjH7WHuNG3U9hUr+lDDtOyMi
 rSUlLJ9Q7w0EOBQU/LBNR8JAMv7PZ66svArk6qis3UXlm0WrcHrqnGQIi7GDmvogcsWmez0RCSA
 Ey3gjhox+7RjiAw3HR3Wlg114u5RA6r/gTdiJfNcvNCoMgmjdqKgHq3t2Wp1+vcoFkbDzzGiEvr
 urUrpoQODuTSCqt/MEMf5B8qkf5u+K6630FdpD+Lq9XFUi1qkRFx5FOkWVRABzBYVxMNtTVxw==
X-Received: by 2002:a05:6402:5211:b0:68d:d511:4a9f with SMTP id
 4fb4d7f45d1cf-6954747e6d6mr5436182a12.18.1781798029590; Thu, 18 Jun 2026
 08:53:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260605033907.1909319-1-dmukhin@ford.com>
 <20260605033907.1909319-8-dmukhin@ford.com>
In-Reply-To: <20260605033907.1909319-8-dmukhin@ford.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 18 Jun 2026 16:53:36 +0100
X-Gm-Features: AVVi8CfB58xDrDeRYgGyYWww8xEOSl3uxwh_4mb1ULjk5air286nlVfbRokP2ag
Message-ID: <CAFLszTg-BjAbdfGtOKt02u+cxS8nq=_jiwggHXFr5p1v0y7wQw@mail.gmail.com>
Subject: Re: [PATCH v1 7/8] bootcount: gpt: ensure coreboot payload enables
 DM_BOOTCOUNT
To: dmukhin@ford.com
Cc: u-boot@lists.denx.de, sjg@chromium.org, trini@konsulko.com
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

Hi Denis,

On 2026-06-05T03:38:59, None <dmukhin@ford.com> wrote:
> bootcount: gpt: ensure coreboot payload enables DM_BOOTCOUNT
>
> Ensure that bootcount-gpt device is enabled in U-Boot when running
> as a coreboot payload.
>
> Signed-off-by: Denis Mukhin <dmukhin@ford.com>
>
> drivers/bootcount/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

> diff --git a/drivers/bootcount/Kconfig b/drivers/bootcount/Kconfig
> @@ -13,7 +13,8 @@ if BOOTCOUNT_LIMIT
>  choice
>       prompt "Boot count device"
>       default BOOTCOUNT_AM33XX if AM33XX || SOC_DA8XX
> -     default BOOTCOUNT_GENERIC
> +     default BOOTCOUNT_GENERIC if !VENDOR_COREBOOT
> +     default DM_BOOTCOUNT if VENDOR_COREBOOT

The subject says 'ensure bootcount-gpt is enabled' but this hunk
selects DM_BOOTCOUNT, the generic DM choice - not DM_BOOTCOUNT_GPT.
Please reconcile the two and spell out in the message what actually
happens...the user still has to turn on DM_BOOTCOUNT_GPT under the
DM_BOOTCOUNT menu.

The motivation is also missing. Why should every VENDOR_COREBOOT build
silently switch its default from BOOTCOUNT_GENERIC to DM_BOOTCOUNT?
Coreboot runs on many platforms with no GPT disk and no use for a DM
bootcount, and changing a choice default will move existing configs on
the next defconfig refresh. That seems heavy-handed for what is really
'a Ford/Chromium platform wants GPT bootcount' - wouldn't it be
cleaner to set this in the relevant board defconfig rather than taking
over the global default for all coreboot payloads? What do you think?

Regards,
Simon
