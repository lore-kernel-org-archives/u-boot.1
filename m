Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2492FCCFA04
	for <u-boot@archiver.kernel.org>; Tue,  4 Nov 2025 16:39:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90912832AD;
	Tue,  4 Nov 2025 17:39:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TXlbknIG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 164C083623; Tue,  4 Nov 2025 17:39:48 +0100 (CET)
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com
 [IPv6:2607:f8b0:4864:20::c36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8CEC808AF
 for <u-boot@lists.denx.de>; Tue,  4 Nov 2025 17:39:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-654ecc2af8eso1541512eaf.1
 for <u-boot@lists.denx.de>; Tue, 04 Nov 2025 08:39:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762274384; x=1762879184; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+6Mr1auLiqIwqytW8eb/qsC6H8sjD3xHwnnAN9j+bjs=;
 b=TXlbknIGYxbFb/66kzefNYdteZrj5u9paez2//89F5P6Tjok/YlLi5ERMVgrt4dc8C
 8Doby8a6NS3b0G5gRb86ulHNLMhekfNPjSXQ2oErCyiyB6w1gCJyj3uYP16BxbXcyU+z
 tT37I3G5Wgka9b/t+wE7WOao+M+r+ugO18qPE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762274384; x=1762879184;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+6Mr1auLiqIwqytW8eb/qsC6H8sjD3xHwnnAN9j+bjs=;
 b=qoSyQBAjqjCtlmK4YAuwocLFv7h0Xfx3GZfHqDtOefPRE9uUohGkWPbmpr7f6s+83S
 ORNSf2hKonhwJyUtL8aE80UqUGYCmqp2ikXmbrZkoAs3YqHaBe9M47ln51nQX+ykSyQH
 D53bi30epzt6ScRCyYMo44ubEvzTX9+dLUMdsyw32qYg510wQ2Bv0n2mHU9BGwrWyEy3
 BccqGC+j3YuDkp+bROFk380yrhVfhYmKd4DB1kgeoRWk5dORoLU4p+pcr2KXWSUVTNTc
 Lks1ZBgJLaUOA1YDrZOXU4052Nb0/bCPrPHLFCRcAgQuqypybyBH45vhDM8cVpgAgVZF
 2YQA==
X-Gm-Message-State: AOJu0Yz2uMOrsAN79CoFmePvIWoxlil7t0Ph7BVOxtPVe3/OiJHROt7h
 IdsIKJS4jkf8UZstqLu1iZBL7a8Rgzy/hAOpmT2IkmHM2J4JcbZ+xA9vk3Qkff5RFKy8XKgZJ4T
 kPwZCntG2fA==
X-Gm-Gg: ASbGncvUVQpMOQB0ei8AU5AoReOmirtiCtqCMQJPzE7jAkCQcOeq72UDB/jD0ar58zP
 jHAbKNFHvtz/bSg1ahgnlXkOfaHgoNjmR0qGDIkYOqCLfEPYp6ttx7yhNXvh0ku6JOH/6ylg6m1
 2HI1+kIm9p3yPmCoXs7K4OVCAtQ5y2QlEm5HSWCb8SxHFG4rRXVa2Ze366XQUEXMMsLy6iMolhZ
 +3hBQS7EsmHAHTgBeZTamXBURUqOg0vTgti44zsUVDBEe7r+J3x2+Vb2/8i0S/dwsbGLLny2Ok2
 dv1G2M39VVomMHmPVvjEYd355pFYfwao6hAhX0JMTfBLk8l37dTDOJNFf5/4u6tT/84rJpGBY1b
 r/MQX8gaED356tVLyTBgBa3cqZEYR/fox5JYjbI3+Uj8LJR7LDy97/Mk9KqkT7/lBdRCJ4pMp/w
 JkAgTgI2EPg5fJmNryI9xf/GO8+X1mnmluLkDe/g==
X-Google-Smtp-Source: AGHT+IHlM0ZTk2Y3LgyycDDdz/Qsp+yRDt+4huJ+ulBGX1WqJO7fuUS8QDnRrjVKUbLm6YQ3jGJSCg==
X-Received: by 2002:a05:6808:1508:b0:44d:b8b7:fbcf with SMTP id
 5614622812f47-44fed1ea934mr32637b6e.21.1762274384432; 
 Tue, 04 Nov 2025 08:39:44 -0800 (PST)
Received: from [127.0.1.1] (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-656ad43a2b4sm936601eaf.18.2025.11.04.08.39.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Nov 2025 08:39:43 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20251104095339.7406-1-clamor95@gmail.com>
References: <20251104095339.7406-1-clamor95@gmail.com>
Subject: Re: Please pull u-boot-tegra staging
Message-Id: <176227438328.3616625.2994043185697538394.b4-ty@konsulko.com>
Date: Tue, 04 Nov 2025 10:39:43 -0600
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

On Tue, 04 Nov 2025 11:53:39 +0200, Svyatoslav Ryhel wrote:

> he following changes since commit 23987e10905146def3ab61e55ec912c6e742efdc:
> 
>   Prepare v2026.01-rc1 (2025-10-27 16:10:23 -0600)
> 
> are available in the Git repository at:
> 
>   https://source.denx.de/u-boot/custodians/u-boot-tegra.git staging
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


