Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28D8EC43602
	for <u-boot@archiver.kernel.org>; Fri,  3 Jul 2026 20:50:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9621884A3A;
	Fri,  3 Jul 2026 22:50:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Da6RcgIh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5CB3584A75; Fri,  3 Jul 2026 22:50:54 +0200 (CEST)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2703849F0
 for <u-boot@lists.denx.de>; Fri,  3 Jul 2026 22:50:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-6a145935764so358251eaf.3
 for <u-boot@lists.denx.de>; Fri, 03 Jul 2026 13:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1783111850; x=1783716650; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sqNoDCFVXJbWd/lqXJupgSUlQGur79EA7tAt9F3hvNE=;
 b=Da6RcgIhs4z5Hdq3WlAUbbXFhQhtHOVE8Kdb5G5bWUUaxpuJLeh4YDi2AqoKPnQSiE
 KkYDZPR2zW3KmVRInssk8hNqcaw0S/eYzGQYAOa/onT4dDlRisSUbFrqOEWyht0rG/Lj
 w2vWqRDA3/EomDSQCWPLJkYh8sh+1hF0Db+34=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783111850; x=1783716650;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sqNoDCFVXJbWd/lqXJupgSUlQGur79EA7tAt9F3hvNE=;
 b=dRX15Ur+KONv7NXAiFO18BSPF18JC+ezLdyLUIRzPVnFmwkAjZ3xoImFA2TFIMsKPx
 PBv/NocNCgKr5i7uCo2F0ljoerVRZuY1AA0EtGRNvNdRTO5f7dwOnG+kZYDHuXrh8QxT
 g/lzGffNpKrSzgYH4fJ/dj07ab+HHvwGGXbQrDmRm+KsR8+uhA+6L3wIrVt/N0+xyhAZ
 d9RTl9AssYCBIVFCXYWc7mimhe8lK5s++MDv2KRZdojtVxsV1Au5bRWjpwZsIIzwnmq1
 qsFfJiGd+ys6d0jZ52KY197Vcc8SKGogJ21vBVS3xolHYSfKvEYHPS1aUx70JIF4O35l
 By5g==
X-Forwarded-Encrypted: i=1;
 AFNElJ8kVQ2smWFxXApL6GuUhSl9p0iC8Rtfj87RXslRp237mFbQKNawkDJ466U5c5BSQF1ZgGAqdYs=@lists.denx.de
X-Gm-Message-State: AOJu0Ywzfs4U84CLgPeB32khEUgvM+UrQNZylOoDCMly8NQVbkW8+BcX
 8mSBQ86SlGy7hTuH6adbvOs3giDEFKGa3IGtFo3hbGXR/1cFL3kCzzJxHG4OcXpZLY0e8HZZnIy
 noMcxeKY=
X-Gm-Gg: AfdE7clBwkcgMMOZj6KajnEDfSgTOTUexbcy9OlLmNM7xiPh4iFCevAxOyIHNxEldvz
 LdaCo3rNLd1+/y2GwfU+oBZAV/eBenM4B2+WWk+ICLklaiwmfHQeq5FYlZBlA/FRghaWPRtWXD2
 m6t/Qy8hRNqzRQDVsJlihPom4l+/v0BbylZnDNMtB4x65pFFVEXmZ7IAAsGcLRkE2mX5RxLAzH4
 UITi2UJS7Fjz97RJOZnNFcnixaamJW498f7Loa7UsefoFVYOLRAB2ltLSRE5igjBUFD16r5USUk
 BFI7N+KSsPm0D5sJWc3oLeZGI4NTxu+8839YiK0KlpcHPcX4QSmDZW1E1WJUPzOrDHohKDCMfxQ
 ZaTKE9+ZCVDUYfvCQ0VgO35ZVDliprDALcufVkN2d78twnxW5JAakmS/1mD2zg3DtFQyT759//4
 BIuaw58PkbcYfgybD3JNGsZOOnAtaziDYUd8zemQh5tDl53aOQhMIfqLIqcuQwZcfpU3CnUWGgv
 RrtzVnCJlt0222dQhr9389fRvSecw2JBpRu
X-Received: by 2002:a05:6820:2907:b0:69d:281c:27aa with SMTP id
 006d021491bc7-6a32f5182aemr400036eaf.29.1783111850389; 
 Fri, 03 Jul 2026 13:50:50 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-44cfb6691d1sm3088491fac.17.2026.07.03.13.50.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2026 13:50:49 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.denx.de, 
 u-boot-qcom@groups.io, Quentin Schulz <foss+uboot@0leil.net>
Cc: Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Luca Weiss <luca.weiss@fairphone.com>, Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260703-revert-sysreset-v2-1-ac999d2ff82f@cherry.de>
References: <20260703-revert-sysreset-v2-1-ac999d2ff82f@cherry.de>
Subject: Re: [PATCH v2] drivers: sysreset: revert support for args in request
Message-Id: <178311184869.3143424.6773163437297829555.b4-ty@konsulko.com>
Date: Fri, 03 Jul 2026 14:50:48 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Fri, 03 Jul 2026 18:43:32 +0200, Quentin Schulz wrote:

> This reverts:
> - commit e49c84f7bb7b ("doc: usage: cmd: reset: specify when the -edl
>   option is available")
> - commit 1076feb8a3f9 ("cmd: boot: fix edl being shown when not
>   supported")
> - commit 63c806ba0e12 ("qcom_defconfig: enable psci based sysreset")
> - commit ef06c5d76ff4 ("cmd: boot: Add '-edl' option to reset command
>   documentation")
> - commit 32825eaddc37 ("sysreset: Implement PSCI based reset to EDL mode
>   for QCOM SoCs")
> - commit fcb48b89813b ("drivers: sysreset: Add sysreset op that can take
>   arguments")
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] drivers: sysreset: revert support for args in request
      commit: c480bbd92b3273ecff5396da9221e7bcb08774ba
-- 
Tom


