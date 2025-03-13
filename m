Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D5E9C282DE
	for <u-boot@archiver.kernel.org>; Thu, 13 Mar 2025 18:43:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 366308168B;
	Thu, 13 Mar 2025 19:43:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="CwUYFC63";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E9AC80540; Thu, 13 Mar 2025 19:43:40 +0100 (CET)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5809280FF7
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 19:43:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-6dd01781b56so16964086d6.0
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 11:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741891416; x=1742496216; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CuxOKp1cjkb60RLPupZlvUCEDHz0ooPKzz/mzbxVsy4=;
 b=CwUYFC63LOohgKwi2RVnDoNcNscB3Raiogbp0d4LPxJhJqEU9+kfG43MyrEJ/gx2QL
 bu6h6qEcYm2oPlvXy0fDtv1OAcfYcX969vMZINfglXOoR+5PNhXUmv1NX3yCYE2m622I
 dU8u7hWASdZD/iln6ylSAkV5C33Bo41Zy6S28=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741891416; x=1742496216;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CuxOKp1cjkb60RLPupZlvUCEDHz0ooPKzz/mzbxVsy4=;
 b=Ta2Ck00RHiQmn4ffy5v0kTjQkMUvh294Mgx6zGfrGc4NYLSe/9g4o3gDoKQylVkmBu
 TF2erYq0vxDDVOVw7nuYzU0E2WiYcGJ0jfCv5k98NLbwnQm3vK/OTmVo50x3ULn7S/s0
 LOD6kIi1HPj6aDRMenX0R44CQOj34UZmSXNI+epqV3+5qrg21hGU3L98TeRJLth4nHzf
 j8tivg75F7WV14ghheRnPpYzRclugBbj6GFKvF3EPHfNOtM2ZvtUo12VC/14dy48adUe
 jkmMxPAggx/MwMgo0bYxyaKWEg+LUF8YSxrR69R59sTPAW3lBpZkqQLRN6EFB0m115Id
 mLRA==
X-Gm-Message-State: AOJu0YyxfjU10rjC6lZJ35c7PM+/PNtyDhc/Lzo4H5is09wac39oKbkE
 o5RyikjVPsHRkFsoTCmNOGcI871TNOgYxh33YD/SyJiapGlJLWMf51st1HyfMfs=
X-Gm-Gg: ASbGnctsxE/FPXkxMmqqGl+jRx01qmj4ac7m0gqiaj/7w6NIqUGGq/81d1EATE9Nxmr
 PSPMtKt75XyE71fgtwMEyGBjVmFQ9xVnf7NfassG7gACg6iglVUzMon/NCFvfVw+IpOJvcjrIcg
 UXf6/LqO185RdjaF3ffofi0zFj25UCvE5U2Lb+pQ2VYJOFB6OqC3pkCpWl0KYwBq/UcmlSeZXSy
 eFUlMwIH1Ojirv5Ysc75u96CqEeeOE6iwVcl/Kg8Dcsm5aLC/CjHp9JyNgJTSXWDvLLHYpw6et8
 n5NYae0UtFX49ZRoiLP/kak6HcmLSZkWOXIk4UdwG5+t
X-Google-Smtp-Source: AGHT+IEIaR5c3GksFD0bPN6e4H3IhtixN/wFqEEJm4rALNYCH5OTBkfRZOnDLzsavJtz6TGxyNbugw==
X-Received: by 2002:a05:6214:d45:b0:6e4:4393:de7 with SMTP id
 6a1803df08f44-6eae79c0d3fmr11234126d6.2.1741891416095; 
 Thu, 13 Mar 2025 11:43:36 -0700 (PDT)
Received: from [127.0.1.1] ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6eade231261sm12640476d6.30.2025.03.13.11.43.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Mar 2025 11:43:35 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Greg Malysa <malysagreg@gmail.com>
Cc: Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Ian Roberts <ian.roberts@timesys.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 Oliver Gaskell <Oliver.Gaskell@analog.com>, 
 Utsav Agarwal <utsav.agarwal@analog.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, adsp-linux@analog.com
In-Reply-To: <20250228185837.25741-1-malysagreg@gmail.com>
References: <20250228185837.25741-1-malysagreg@gmail.com>
Subject: Re: [PATCH 1/2] arm: mach-sc5xx: Remove manual bss_clear
Message-Id: <174189141453.2132480.1030244808273445818.b4-ty@konsulko.com>
Date: Thu, 13 Mar 2025 12:43:34 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Fri, 28 Feb 2025 13:58:33 -0500, Greg Malysa wrote:

> The arm library includes an implementation of bss_clear that is already
> called from crt0.S. This re-clearing of BSS should not be performed in
> the machine code and should therefore be removed.
> 
> 

Applied to u-boot/next, thanks!

[1/2] arm: mach-sc5xx: Remove manual bss_clear
      commit: 3ce975ab888b583cb5816b1aa453136ea9549a3c
[2/2] arm: mach-sc5xx: Remove inappropriate board-specific functions
      commit: 74f4170a87a72438842ec7084741968dbc270702
-- 
Tom


