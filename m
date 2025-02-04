Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09A39C02194
	for <u-boot@archiver.kernel.org>; Tue,  4 Feb 2025 19:44:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EEACE806DC;
	Tue,  4 Feb 2025 20:44:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="stLdM34t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A1CA805E7; Tue,  4 Feb 2025 20:44:19 +0100 (CET)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5381807E2
 for <u-boot@lists.denx.de>; Tue,  4 Feb 2025 20:44:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-3eba0f09c3aso1487068b6e.1
 for <u-boot@lists.denx.de>; Tue, 04 Feb 2025 11:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738698255; x=1739303055; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xYH/y1Ut66MypfhCAxfXQXbZ5Ptor6by8iKtPwtKoCA=;
 b=stLdM34titjQuCDqyo78uutoG7hWfM/EGISqOkTkraXToy/UnUV3DXLDDqxyaeTR1h
 deklScu7PyZvLb0SHlNI3WLrYXfnF2KGUVA5V9xQRfX+6MJxaIANm8q6NFr4JD1Hk4hR
 z0WS1K23iUn0vofp3K0Hf4l5sKFHepHDSDgqk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738698255; x=1739303055;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xYH/y1Ut66MypfhCAxfXQXbZ5Ptor6by8iKtPwtKoCA=;
 b=I1DC7lFDk9EifNZhb8/G4uagtQjnzkkVH+clh9hUmLE4Aqc2vhDje8Kdyife4liQdw
 5cWnTN/B6a9Q3YVOGPrGqrhMbGMKFIdvEkhvRzj3WCpnO+bHkRD+iNkGJjHFy29FrhxG
 6IlyBMYdFLghoGxx4dCSmXpQYGeX1twXxA9paNeMODQwDkq+etAID2buZBUsrzOB/irY
 CItItGDp6Gz29pOxusyODF2tw5ZxVnCl6Y1+z2rsE15496UYP+jKnFAxiXofekpNOvOD
 vfBNCXjjDEOjYo7j9rQs1y5z4x6/s+R+WA5BX8RDgTTy5kbyEP6VWFgnvv+p0ZBo8LPG
 z/3w==
X-Gm-Message-State: AOJu0YxgZ6P+1yCABGPeWUk5TrthyxY3hQL1hhhQU0jiZ8n0MbNdUlkZ
 bhZoJG76bZV/zSrWgadTlpq0kaAa1FWKly1Zg2bi0kGMVzAbwuDIso0ioVrp9yk=
X-Gm-Gg: ASbGncudD5gOUBpyuUvMPnD02+TPPxm5cD+Lra6Wyasj6m3qQ6OTWIcm3tARGx2AmTW
 +yUusuBsRSM7fXvEeOhCCAoDCQK42L+szaXD7iAvwJRY9t3N1ZCcC+PDUpcNq73k942w0vjTnN0
 om0iazF/OCqftRSNievEIQfyKpna6rtKsVFQxajfxDF2LtAcVH2rdzdQKTGhE8Fb2sKSXs7y40I
 ja6gyt/PEmUhDWTz8pINBPe27iZ/zx5QK0DOu74YgsvAy9bFJE76oz1ygHbU6XwnrG1X13RxLJX
 p+rs4ROD3va5Sw==
X-Google-Smtp-Source: AGHT+IH0zow7c9YUH4rKMUY+baU8+9lAIB8mayG3fP3eazBxrbUcYJ2gYbVl4KCB1uDk6tJ1cqAt6w==
X-Received: by 2002:a05:6808:1688:b0:3e7:bd97:759a with SMTP id
 5614622812f47-3f323b8e76bmr20514158b6e.39.1738698255520; 
 Tue, 04 Feb 2025 11:44:15 -0800 (PST)
Received: from [127.0.1.1] ([189.177.145.20]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3f33355947esm3250039b6e.25.2025.02.04.11.44.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2025 11:44:14 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20250204164556.448732-1-trini@konsulko.com>
References: <20250204164556.448732-1-trini@konsulko.com>
Subject: Re: [PATCH] py: Rename the rest of the boardenv files with "-" in
 their name
Message-Id: <173869825440.637310.8613373609955685529.b4-ty@konsulko.com>
Date: Tue, 04 Feb 2025 13:44:14 -0600
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

On Tue, 04 Feb 2025 10:45:56 -0600, Tom Rini wrote:

> The way that test/py/conftest.py has always worked is that it translates
> all "-" to "_" when looking for boardenv files. Rename the few
> incorrectly named ones that we had.
> 
> 

Applied to u-boot/u-boot-test-hooks.git/master, thanks!

-- 
Tom


