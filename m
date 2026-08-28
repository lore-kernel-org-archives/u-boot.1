Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFDD9C61DB9
	for <u-boot@archiver.kernel.org>; Fri, 28 Aug 2026 20:29:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B444A40A33;
	Fri, 28 Aug 2026 20:29:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id go1gNpAM_64V; Fri, 28 Aug 2026 20:29:25 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787948965;
	bh=UWeIkx4bzSHD+axKual46I18lGEJ5H3mx8SLDNItjX8=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aMb2JD2QzZPSqov5NjzKEQr8aVsMSGtRJMmCnP+uQ4gM/N95qlnYcfStxLUphssoG
	 bbaXnvdjpLobVRDqCQvQLoFi4+hQu8vrLPebjV2GeHKDsClp05miciIg1thJarsk21
	 xmypj6X1my2to8e0ryXkYea4Hjv8DrQgLgzMfRrru+WiFWVHMp1losyAxSWeSVCZaA
	 VxVqQ5BwXWTFKHUJoo1xt0Y0ArJnWYhZjU0uwROzyqvknHShDniWGukZfz3It1+FAF
	 5yU83xa/jE+SS+zQcfiOyeB0b5ZX1s0cYDqpojurOtLMfOngwtjvV6OCkinvV9HZds
	 MWDp+XL8QeKCg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id EC80140A22;
	Fri, 28 Aug 2026 20:29:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0AB252FD
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 20:29:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F018040A20
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 20:29:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DUogTmAK1V3O for <u-boot@lists.u-boot-project.org>;
 Fri, 28 Aug 2026 20:29:18 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::232; helo=mail-oi1-x232.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=qBMUrW0/
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 522774086E
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 20:29:17 +0000 (UTC)
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-4af7283bf83so833948b6e.3
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 13:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1787948957; x=1788553757;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UWeIkx4bzSHD+axKual46I18lGEJ5H3mx8SLDNItjX8=;
 b=qBMUrW0/eebiI1nb6L9L9u3HABhL0WdUdNSylB+u2eFYqJbfYbiEuk0xKy9aJpJR/j
 de737C7VAwLb1MyrhsibfCBm7nCfhT2Rsn2f+brDDSXB9J5f5rkHVWV0WBnGUdppBaEU
 Mis/FhviQ624rXzIDnMJRUxPnyY8SdgTdVrO8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787948957; x=1788553757;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=UWeIkx4bzSHD+axKual46I18lGEJ5H3mx8SLDNItjX8=;
 b=jdoiRz/UYQor+Hf0jjp6qL6HlWTbUjjN4pynHwF37M4nxlXe5oImv2KwUftEAuiDgh
 Cm4dX0oda9JNxjR2HYb3nd8GxeQd1aek4Iz3C9Qc+bolS1DpAxJJuBpF0DrcDTsQqmOR
 At+OSou68YG0m4Rql3S7mLxsSF2sr5/rR5exaQHAqf3ATREMv1AtEHM+vWUyIIq4W7Mb
 AtZsJa9myTpUzrF5i5GSqm4QTFTkA+vf7GXuflzmcLY6ZWRuJK7bQOxHdYio8PxGN5ZK
 MtG7+GVEfOyaGZTVhixdB3FDxEJ9TOFaANVrpC2wrEVdbQVydb8y2QuE7wMP1VpTf+YV
 D5Jg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqzGgOCeb97uO4NttLTEjjwXSzRcJOAaFJELFeNkxkHmp8NjPbBej604jJ+QkCastZU/B60Cpw=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kHoyncBQa2fE6HzPvA6eeZaQaplD5QW9BG2NPI3QT2xNqTTkCx
 NCXUvrWoqzna39UgOJsPJvmhiU4OPqaGCdhMQYKl0m+QNfTIZSBWzE9lBffa99cdN1O+4OmaDCo
 1b58R0rwwENXp
X-Gm-Gg: AR+sD12Wy4fj7RbGystI2dGQQjdANjUZaxmwsf8DYBLi2/Uv7VhKLIX+r/C0c8Aavj0
 TbXsu9r4TLLz031U8nzdj2Z/eYkBSBAIAYLwgo6EtWzlODuu69iaRw3GtD3h/rox8ebCPyioo3r
 4ptXXTjgBbKEAOFQ5fb7OvslOsS5fnhQvH1obI052Lm7OlIwikAMiZJEWDHLXPpjgV0SCHoh3Wc
 oMmIq4QikMjMUQbMFYDAz3wK+YGFllSxuK78T0PBrqhQndeqE0XjQRIGTOVxZf7v5tztmRev0OG
 YgmC5IA0le37YDlBaPUvbOwIVUDIXThJ/9l9CJPJkXlwfFiNvFcX8Yg/N7xTi6xyTABOAb0DXJE
 uYD2tzNb/+iMBiW6uGfypgU10WtmzY+oll862nj4k9hmjq/rWscnjenCei7o6eJS+Xgwsn2J6Q8
 DIS7ryyV4R4li/q1HVhuvum5osiBC56YJjVPaHnJWFgbO4sZT65CDKG0ehKi/Md5EWO6zLbQNnZ
 CNaqzKVy09fIhlPxsecDT/mheXewdHeOSsboFB07gA0So6cvEh1I2kV1HlwXWwsvEyV0HLkgwut
 BbjrNShR
X-Received: by 2002:a05:6808:13c3:b0:4b2:e95f:37cf with SMTP id
 5614622812f47-4b39806c429mr10271512b6e.8.1787948956842; 
 Fri, 28 Aug 2026 13:29:16 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4b3a1995b83sm2100578b6e.12.2026.08.28.13.29.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 13:29:16 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org, 
 Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <b72cedaf-10f8-4494-a9c0-e20966aa4ff9@siemens.com>
References: <b72cedaf-10f8-4494-a9c0-e20966aa4ff9@siemens.com>
Subject: Re: [PATCH] test: boot: measurement: Fix compilation for
 non-sandbox builds
Message-Id: <178794895532.264202.566782229863271226.b4-ty@konsulko.com>
Date: Fri, 28 Aug 2026 14:29:15 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.3
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

On Thu, 20 Aug 2026 17:57:08 +0200, Jan Kiszka wrote:

> asm/io.h provides map_to_sysmem() only for the sandbox. Other targets
> fail the build with
> 
> ../test/boot/measurement.c: In function ‘measure’:
> ../test/boot/measurement.c:30:33: error: implicit declaration of function ‘map_to_sysmem’; did you mean ‘map_physmem’? [-Wimplicit-function-declaration]
>    30 |         images.os.image_start = map_to_sysmem(kernel);
>       |                                 ^~~~~~~~~~~~~
>       |                                 map_physmem
> 
> [...]

Applied to u-boot/main, thanks!

[1/1] test: boot: measurement: Fix compilation for non-sandbox builds
      commit: f92bd784f6ce15aac66e89ab4c17349af18d4ddd
-- 
Tom


