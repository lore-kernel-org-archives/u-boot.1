Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBB78C5AC67
	for <u-boot@archiver.kernel.org>; Thu,  6 Aug 2026 21:05:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A9CF640820;
	Thu,  6 Aug 2026 21:05:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id C-zDqo9FEyzB; Thu,  6 Aug 2026 21:05:03 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6850740812
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786050303;
	bh=2jpwAGhENQvyLvaJ2dAczmwnLxEuI9ZJkiSlpTpi8Fg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fGAEHsAWsMxACRueOQll+sigamGGfANaajBhkqSo04hfOY4JJ9/9KrOoiUBc0dY7j
	 EYX36UqCUVoaQ2h3IkNnpeFmFu+cuDSKkjJlVG97yiX6pACustGeGMNOaHCfP881HW
	 ET9bx5uz7T0pw5vEbHQbEofPpPrIgTqvq1r6NnNXQBTH5Pd8nkIdbIZhLa3A/gg+cI
	 QUzvF+k2+9kE6Rwa3IiIqCrop+QTJq8hQ5HogDE+7xhg8e4QPm+kPIS6rJYZ8UwcZS
	 seau9AxW+v8TA/qjuEnJ0AVf7LtoWquWT8eoCx1gQt49oYglRTTVjxtzWewizwPa1m
	 toiBofxctJRog==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6850740812;
	Thu,  6 Aug 2026 21:05:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id C2918218
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 21:05:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C036160836
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 21:05:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id u6QJRf2XglAL for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 21:05:01 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52a; helo=mail-ed1-x52a.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 047A260835
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 047A260835
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 047A260835
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 21:05:00 +0000 (UTC)
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-6a10b20634fso4787960a12.3
 for <u-boot@lists.u-boot-project.org>; Thu, 06 Aug 2026 14:05:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786050299; cv=none;
 d=google.com; s=arc-20260327;
 b=UULnJVbs2x50yIGwlQMnfIsbnAfgWerP8aTU2RfqkApCQaxVJNh1r8PCsvjAIBgbnK
 pyqYOGxW4IESRDCQoO8a07bz5928ksJ/MtCNy0NS1g/Za/0HXuny+PRP58iXQPLXutqv
 8Rw5+CPrmJZrL7Rqr438H/3BuV9TEW3zwY4qWw/LoCCKqLxFUQumvD6lAbz0PAWDprbi
 O2y9sgdBmrbpC+AAweDeNadgdqCxaDQE1G9wcfkw/043ymN+USiB9hwKKSHCcmwcgTOd
 46CZGcEcqqSE1E3dNP0n3XtqOb/IxOCCsplSYkKQ1IYAoBHyVvffmR8UmfLzOFLQkn5f
 NnLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=2jpwAGhENQvyLvaJ2dAczmwnLxEuI9ZJkiSlpTpi8Fg=;
 fh=Ye9d8c9UuIgjdEYE5AmpFdHtipkFyQbZju95WIBagdg=;
 b=f0lTdTAtXO3UcTeTa/Y5Ux8tvq8YJVwutOUXNa/zegJlHCwxUcBva9DOAv7w/0Hkv0
 mDRcvr+dOkr0axNKBwJPkZBteq0Wl+8yI48kE6tIpFuIMWqIucbuP9rSZDID3kvbJbNL
 EXnWDeID90KL3SZpf2+ExKLpFCBtPJyLSCfdiPGHW6QB+aMoSwKbzlZx3pa80ckJm1uW
 XxeA7FedJQniVUXjntvB0Ps5YMwyojVbIagp1eowmi5ntIwegVNfMvmGCCrCo89Mo3/U
 UiRZmWQRrn2YzwO1pS/veTySpk0QwoMwbGN2HslV/ZCSWGZ9m8p/498/B6KIP9zMOi6L
 Jqog==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786050299; x=1786655099;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=2jpwAGhENQvyLvaJ2dAczmwnLxEuI9ZJkiSlpTpi8Fg=;
 b=mp4XMHYgqHIBWCfsjrruuGVfGJUdj9d34/1PJ65LSB95o/5n8FoPxnnZ8pt9tOuOeW
 fmKpPuG6lGqtICo0TDljsk0F5capfgMGZCPpqnPngzP/1zJ2nVHPmKDp99NC2PJr0uNW
 Owm5agQvDqSnE/X0yzMEd3TN0E3pVdH3FmK8Gcc4Ce/a2gU58obpRs9srpam4o3JTHgj
 e0wroUBL4Dy6yo84x4K4XeYTitQCPGLnyS6RvHdziWNBSxpRI2xJjv5ryKJB9qpAZ0Cq
 BZrOAEYOfVoZ1MMcYPx/w95FMprY5ChEZBbxwJDXAWQQ1WG8FwraEMHYvfbq7VVqODvH
 4Sgw==
X-Gm-Message-State: AOJu0YyQpzYu+hHGLSifJPFw4TduqBfyn3odFtJodrbeSy/NLZtQgTbc
 Aih7yJsck+4tLwtGf9y4gvryjkQu7I7oJ6pcWZ1CCc1d3bp5hWgL6ZLwndZH4pXuPaA3H213tHW
 8lRqjh4vwEG2ACkH/odMqH62mezWuL7xuC5lJu7D5lBWVFRB4zpE=
X-Gm-Gg: AR+sD10g0P6HBbWp6znBt2J/RyPtuvEdI64JzUzDfRhbpsb3KMXdRW+u8JxHgKi3EQp
 EN6vw1DHfPYk6Z44gp4h+dXcqhjIF9agYhfjr+3XiN6CkxA5gGkoJ+z9E7kgrZpAHt08heVLtO3
 pbDyWHo7YNourYKdjiaZ7Ohn4mc2PijXWcz9yzcc9GqUk+rBf5isWZznNIiQSXMyqBkzkdIF1ZN
 p/pMn87nGdYtAI9ZCSpavDaDJEsO71Pxvj564nOnWlII2sPS7qaE2GTRvrzsvUFCAbevtfGq6OB
 pY17joirB6rTNYhd5NINhTRSJWSG9rwQISh0CCR9R3w=
X-Received: by 2002:a05:6402:5d5:b0:6a1:c4f:3153 with SMTP id
 4fb4d7f45d1cf-6a14f07cdf6mr10266455a12.2.1786050298996; Thu, 06 Aug 2026
 14:04:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260804-am62lx-v4-0-01746157643d@ti.com>
 <20260804-am62lx-v4-4-01746157643d@ti.com>
In-Reply-To: <20260804-am62lx-v4-4-01746157643d@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 6 Aug 2026 15:04:47 -0600
X-Gm-Features: AUfX_my3TpafqyM2V13o1qD9wq50pr-vK_ROTtxWDHsSchAkOCprnXaFGIt0L9w
Message-ID: <CAFLszTjhkoG8Yff=us8ByCGA1cDR3hcyTPSopa2gWGj2gfFOOw@mail.gmail.com>
Subject: Re: [PATCH v4 04/11] boot/Kconfig: disable fit post processing for
 AM62L
To: bb@ti.com
Cc: u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1786050299; x=1786655099;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2jpwAGhENQvyLvaJ2dAczmwnLxEuI9ZJkiSlpTpi8Fg=;
 b=ZRtbZDrGWVXeW5BuY/ixKxIMLbG79n/ZrLe1oDJTgY16uptY5cod+ckeJaHo8yD37Q
 Naq9pnMxVU1QsuvMWM6HkllCY60Mfx/qXaHca0Y9epz257aC33pbOs79i1+LpAh15IBI
 HkvpkdPgqdkbrRdlf2AKRdtsiZCXPzk9wfTsA=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=ZRtbZDrG
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Bryan,

On 2026-08-04T21:55:02, Bryan Brattlof <bb@ti.com> wrote:
> boot/Kconfig: disable fit post processing for AM62L
>
> The AM62L family of SoCs utilize a 2 stage ROM boot which uses x509
> certificates for booting securely. There is no need for processing of a
> fitImage. Disable it for the AM62L SoC family.

Just to check - the AM62L defconfig added later in this series does
not enable TI_SECURE_DEVICE, so this change has no effect on the
boards being added here. Presumably it is aimed at a future HS
variant. Please say that in the commit message so it is clear why the
change is needed now.

>
> Tested-by: Anshul Dalal <anshuld@ti.com>
> Reviewed-by: Anshul Dalal <anshuld@ti.com>
> Signed-off-by: Bryan Brattlof <bb@ti.com>
>
> boot/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

> diff --git a/boot/Kconfig b/boot/Kconfig
> @@ -333,7 +333,7 @@ config SPL_LOAD_FIT_FULL
>  config SPL_FIT_IMAGE_POST_PROCESS
>       bool "Enable post-processing of FIT artifacts after loading by the SPL"
>       depends on SPL_LOAD_FIT
> -     default y if TI_SECURE_DEVICE
> +     default y if (TI_SECURE_DEVICE && !SOC_K3_AM62L3)

Adding an SoC-specific negation to a generic boot/Kconfig option does
not scale - the next K3 SoC with the same boot flow will need another
'&& !SOC_K3_xxx' term. I think this would be better decided in the SoC
layer, e.g. by adding a 'default n if SOC_K3_AM62L3' override in
arch/arm/mach-k3/Kconfig alongside the other K3-specific defaults, or
by having the AM62L Kconfig not select whatever pulls TI_SECURE_DEVICE
in. That keeps boot/Kconfig free of per-SoC knowledge.

Regards,
Simon
