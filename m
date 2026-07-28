Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 621FBC531F9
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 11:58:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 57EE181331;
	Tue, 28 Jul 2026 11:58:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dtPHkUdLFqIg; Tue, 28 Jul 2026 11:58:20 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8691E81325
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785239900;
	bh=UQiqMpm7cF2v4mYEA33r5ZpvO3a3m7Gz8YIMKiPk9dg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IlzPu6iaheMx26nja051kzGkLeQPq0n+L2kTGuEQHDn+zrnl/5Kv5wjGYW3pUyzql
	 +arAIR8wdyZki7xHK6YOgcppNwpsHbgyBULrSAG0bCNYkRsHpyLPgowy9wAsExyZKJ
	 eU3qlO5cO0ZPQ07SiGbf+nYMxehhtQVUrOfTqmVvp9JyWK3KVNrHSslEFy+ZfyejDm
	 JAIX/mCC/qiKrcvy+dQw4/dNsRTC85EOQdrtFcC4u9j7HmxgTOcEcb9INsYu13bGCH
	 WD/oDtTvU1BDYwgtQuJt/yjtzXwqMm+6vJvQD0QbAA/zVCIQmhPXqAIzcy7jkxLjRW
	 5rF//1PhCsVsg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8691E81325;
	Tue, 28 Jul 2026 11:58:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 7367F45B
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:58:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 59DF8400B8
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:58:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id x08cQdLr4K8C for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 11:58:17 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::535; helo=mail-ed1-x535.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 4E22940085
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4E22940085
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4E22940085
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:58:17 +0000 (UTC)
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-69f7af97316so6016690a12.0
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 04:58:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785239895; cv=none;
 d=google.com; s=arc-20260327;
 b=ZgdIu7+Ldnl3UPwItZ8wgPlzOQp0yLutGZw0UWu1yp3/QjnmTbtvTZa3171/cZLUZS
 ERe1JeI2XSvFV7X/rGP0ZRLafUECASLQob/MgykOXv3SJx7fl11NK/i8nkzdjk/nwXH7
 NkzRDEOu92+ULOYmEzF0PycE/waYm4QUdt27BqBrMag9ZLomlViLOHueIOEV+jtw3DYI
 m9pMl83RzgjYFo36lN/5VWEKeHk4qWje5PrkbQHKBpPH9vkWIeRBenmOe+3GudfFrXjb
 55pV23en6dStKFNRJyxNsxno5HXjt4s5VL27cNThFvXM6gtsT15oQh1s1Q7SU3THwyOh
 BfFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=UQiqMpm7cF2v4mYEA33r5ZpvO3a3m7Gz8YIMKiPk9dg=;
 fh=YsOqrmLVmht63zxcDX/pvTK7+2dLBbyowfgIb7LrVa4=;
 b=UKkuV6TeHDEAPL6ufqfjhLhQkc2EE+d0HngT8s7z6GmBNisjxcKTKehx/ALZXiFZi8
 wadpOiUrYsA2dozi+xkAlJQ+q8zsIPX/swf2GqxxGZeGbf/QWY8sfK12GqlIzhXtH3t8
 VFnfLdQmXbXRXsDQfJeZnltZMVKWZN6yJRt30tAHQFTYydEIv5dbt9pP84dvfJg5jMV+
 YURXB0u4D0Vzi0ucmj6H7dleSvMUo9Jqh9wCMyhv1a0ep06SfYTtFMroF4eLg0ApcwGw
 yHZpcYmhOeLLiRRSioyabyCQ2R96U9C3I3fFORU0Y+dGEDVf8m/ILK5ejsw5/Wit/nYz
 m6/A==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785239895; x=1785844695;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=UQiqMpm7cF2v4mYEA33r5ZpvO3a3m7Gz8YIMKiPk9dg=;
 b=K/1DvK5HkWXMcowP+CiwprwVl8oxdPo/xRGpqv7hoMxVF/mZoOZ0rDuMFqcB5EHwLr
 QgyrcZ9YI4+mF4EkOimeDox75TKugX8vopHFl6laHJ6q/zkPotQYZ4VqqtpDkXZwugxv
 6oUdT7Ru6HGE1q0p1zpJ7GQcJC385DOOXmnY6Hr9YMf1RqkG0TFo3OQMj7pRZV9PXfDu
 j6NOZjDiG3m6e3CpFrHLJcWA/QL5HiVvCtAjM629QYr5r7NW+p4cUIKpleaaQ/lb1t2S
 F1mOpqfKMBMbocFJJmZ5AhnJnL/LiA61X2lfoGKsWjXWP7HRngTAms0ww18o9zzLG5Oq
 1GlQ==
X-Gm-Message-State: AOJu0Yz3MA34ziiTnyMknHcbL3rt5P3URsD9rDljaYKcFSkiVt4LY48b
 Z9WO1de/Wb2Vn1bu26HLFDWQAQe08iNTeJJKM9Iucgo25cURZpwKMlkg9fWIfZCH8MYJJYOaWHf
 /I1ZUzWQDXE6sq+U8YLvViO2bcWComkD5JrcyHCQ1
X-Gm-Gg: AR+sD10ntbsXs1pqF+Vg8wSjJeBOCZN0ES37lAjLuxukUHi0W679GKRiRDpuXmVEm32
 fbkrnz85m3M1bAmFlnBCnCjNQyZqjHxS+PaBbyiKpL7qdoen7pLh8XmvwsEudpEv4ACignp02y1
 dN3ORDBKJOyyVU4F1DRxpn4yzFvtVDmYDyHOZ3esybZCvN6zjoti7J2M8sC70uyCFVwO7nXkyXb
 ZBFd19GVt1GfRtjYcYJUPBycN3B43m7J2zRSDxACjHCSZpfxv3XoQUoPQVV
X-Received: by 2002:a05:6402:530d:b0:69f:ec6e:89b7 with SMTP id
 4fb4d7f45d1cf-6a034a8cf93mr1065617a12.40.1785239895215; Tue, 28 Jul 2026
 04:58:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260721025327.161856-1-marex@nabladev.com>
In-Reply-To: <20260721025327.161856-1-marex@nabladev.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 28 Jul 2026 05:58:03 -0600
X-Gm-Features: AUfX_mz5bzSQGTpcZTbwXkTz8qhhkFh1p7fyaY8w3BYN64ksygXqBBtNp4ranHk
Message-ID: <CAFLszTiwrXDyim2dTPo5=K1Fm82acJA6GKCiPWBdnRsFZjAQ0A@mail.gmail.com>
Subject: Re: [PATCH v5] binman: add CST backend selection for i.MX8M signing
To: Marek Vasut <marex@nabladev.com>
Cc: u-boot@lists.u-boot-project.org, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785239895; x=1785844695;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UQiqMpm7cF2v4mYEA33r5ZpvO3a3m7Gz8YIMKiPk9dg=;
 b=LCDbvQQTEAAfVaO/GMi9Phh0TQ8bLptVz/UVdS51xmphBBILK4U1hiGBcguBOFuQVp
 rx4QH6Unj/zEI8a+oj0cN1/WWV6JJHSqwVeqMqhGUV50e1mFTjQRh8Mv+rhOV/FLObL1
 lkQuPQWW1uwYj6fHjzikNFB/vxZ1vfhIJwGQc=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=LCDbvQQT
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

Hi Marek,

On 2026-07-21T02:52:37, Marek Vasut <marex@nabladev.com> wrote:
> binman: add CST backend selection for i.MX8M signing
>
> Add support for setting the CST backend, both via DT property and
> CST_BACKEND environment variable. The CST currently supports two
> backends, 'ssl' and 'pkcs11', with 'ssl' being the default when
> CST tool is invoked without any -b parameter. Keep 'ssl' backend
> as the default, but explicitly pass it via the '-b' parameter,
> unless the user selects 'pkcs11' via either method.
>
> Signed-off-by: Marek Vasut <marex@nabladev.com>
>
> doc/imx/habv4/guides/mx8m_spl_secure_boot.txt    | 30 +++++++++++++++---------
>  tools/binman/etype/nxp_imx8mcst.py               | 19 ++++++++++++++-
>  tools/binman/ftest.py                            | 15 ++++++++++++
>  tools/binman/test/vendor/nxp_imx8_csf_pkcs11.dts | 27 +++++++++++++++++++++
>  4 files changed, 79 insertions(+), 12 deletions(-)

Sorry I missed this earlier...

Reviewed-by: Simon Glass <sjg@chromium.org>

Thanks for adding the test!

Regards,
Simon
