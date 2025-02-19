Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D17E4C021AD
	for <u-boot@archiver.kernel.org>; Wed, 19 Feb 2025 02:05:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F14280F6F;
	Wed, 19 Feb 2025 03:05:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="AH3qF69A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D1D980F53; Wed, 19 Feb 2025 03:04:56 +0100 (CET)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70C8180646
 for <u-boot@lists.denx.de>; Wed, 19 Feb 2025 03:04:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-220c8eb195aso125959325ad.0
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 18:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739930692; x=1740535492; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0GDvFM9Vt5xRKyqPPqjTPw2Ph9MHsfpZGxX7oyARZoI=;
 b=AH3qF69AqngQePjW8rShlXjph8ZzmqM5tzRTR0RekBO6Zg81kML3/5ke6j/cyXJHh7
 ef8vx6dvc9RZrDDV5StI7JbQNuoonSO9LbkEaqQawhDvYR+tqZBvAn9qd4j0GToaDVgD
 HzYMuH3x1ONcrYaX/7H38vWi3H00PZVCzEnr8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739930692; x=1740535492;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0GDvFM9Vt5xRKyqPPqjTPw2Ph9MHsfpZGxX7oyARZoI=;
 b=k+EWSqKHpjpoydY56Qppgb++W9SDoW8qR3tM8CcGxTvRa1v9N/NacTIuK7AmHwI1TQ
 QehpJEcXsGWQRp0zaoUy1VlYJwAxzJj2+hqrt2kD2RuaG/l4ZLqn9wX2reyVVj+rI8OS
 JS63qQ3NriuQDxMGV+z6K9SstIU1zKFBO8m+/YvIa/uQff4ffz2npKfuVv6ggOXDYt/M
 b30tLBc/9LEOLg/rXzy+Zdw08ABsZ8B+65v+i6dhjUF2NpOkPusXSPE2pm/BVGGVj/ey
 hVEK/s0aaSDFhQYx8eqxzRyg5jhiuHQCkwXDzfASdbr2yPW9r9/EwV03dCmS4Yw/Jxrq
 6EBQ==
X-Gm-Message-State: AOJu0YwdghNFD57fdai8R3lw9PJAeq0Q7++uUd6SN+ahfsqf+v0Daj5W
 nU3clDiE1VETLZi9YqQIZmHKAgscRFB7Z++raSZxKlB3rd2lAYl9XZH8em6LJZ0=
X-Gm-Gg: ASbGncsZkMmBrjMfLShlhyjetSSik9ir1vuvIxRhIQuHpAXZhmA897h6evvnq4DTjES
 qG0pnsCf07hDBWZ6mbZKHDJ2VrpoSejvze6fZ4myPPRAurjhKrrKx5nOqsr20Ytpvx16NkVe9tQ
 Y4SprkwEA+TdyFbevrfjRt7AYyJt8Az2eCZf6Am6GGqGZ0WpOf2eMiSRxKO6t/EdiRoMwQ6Nv2C
 B+W4M4StNplVec22PNgASUg7oI2EJe423x+JMZYaNsDxz84x8Kw1MOuaHLUEbGCHKz6odtp8f42
 XSmfNMfhZDZm
X-Google-Smtp-Source: AGHT+IFZYSM7IIC+v/ZYh0nEnye7fAsd0SSjk2owpAt3O2eIFt4zE4XfpYPZNWd8gqEKjR8d5Bbv6w==
X-Received: by 2002:a17:902:ccc6:b0:220:ff3f:6cc9 with SMTP id
 d9443c01a7336-221711b98bbmr28015915ad.48.1739930692072; 
 Tue, 18 Feb 2025 18:04:52 -0800 (PST)
Received: from [127.0.1.1] ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ade1c7a675asm6365064a12.48.2025.02.18.18.04.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Feb 2025 18:04:51 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: JJLIU0@nuvoton.com, joe.hershberger@ni.com, rfried.dev@gmail.com, 
 Jim Liu <jim.t90615@gmail.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250211020201.238924-1-JJLIU0@nuvoton.com>
References: <20250211020201.238924-1-JJLIU0@nuvoton.com>
Subject: Re: [PATCH v1] net: designware: Add npcm8xx sgmii pcs support
Message-Id: <173993069107.1662848.1323509622436515901.b4-ty@konsulko.com>
Date: Tue, 18 Feb 2025 20:04:51 -0600
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

On Tue, 11 Feb 2025 10:02:01 +0800, Jim Liu wrote:

> The PCS exists only in GMAC1 and relates to SGMII interface and
> is used to control the SGMII PHY.
> 
> 

Applied to u-boot/next, thanks!

-- 
Tom


