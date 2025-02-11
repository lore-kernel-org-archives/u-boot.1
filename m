Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55380C0219B
	for <u-boot@archiver.kernel.org>; Tue, 11 Feb 2025 14:18:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9210D80C77;
	Tue, 11 Feb 2025 15:18:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="G96mIsOj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C37E803CC; Tue, 11 Feb 2025 15:18:06 +0100 (CET)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 575FF8043C
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 15:18:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-21f3e2b4eceso106446235ad.2
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 06:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739283483; x=1739888283; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jy4gWXaKRZO+OB3yhISfZ3hBakDnGdV3z/C5eJnBFqU=;
 b=G96mIsOjSFaKOdtvUlsEqWrKC7Xa7t++NXSP5I/axorCc9U9pdnSrz78aEcEGbzTOO
 YeqCBPxDOIkAsenBjMOIWPXugzj8GXj33WkJIFwwpadQHtoOWUknUpVlGuuxsY8qtrEs
 X/GoQ5MmqkZeNjhBpaN0GDBdBzWf+Y8osMbIU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739283483; x=1739888283;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jy4gWXaKRZO+OB3yhISfZ3hBakDnGdV3z/C5eJnBFqU=;
 b=OUcs//jQidu8yq9iV4d44KF2f6jh8bi8cARcKs7/DjjbSYcYzuAZFiSyEccrcQBtNC
 edaKbXBzqTb7hG+WhovaRx+4/K0qjtLv1hzNEPmjyZD/ZpN+Z68DIvNrTkugaw8hs1I5
 BXFm++UussBMlEJkMSN18T3ltR3qF2y26XJyN0IoL3q00xO7cH9PjTOn+p0LLtQ7DByQ
 sxpaWDNXUx/Pxl+ftcdDznPZd9MtDto8yb0HzEGmVVS54XFfrwspxE6dnzH8no9kTdhU
 4VtfRe2erais0d3G5Gz+FYdmH8suTsUPEOvdfgq8Ekpy+dlIySPHVfUf/KRALaJbFju1
 CdZw==
X-Gm-Message-State: AOJu0Yx95rG+OaGrTZcR3RbKYeIsi4jGNFY9wFCv2gNePdbuxqEQ/szv
 KUDFT2rVmLquwNAvY5NsySpvCGmMnDfvzDvT5ZLt1AAOV0WZLGje7KuM4w6KQnEuhetQXVVpLeQ
 gmLbfbg==
X-Gm-Gg: ASbGncuEIr8p8RNNexofrlLiut0hE29quKzowu6fRyvMb5QvyAMcZYIXxRcPNqSioi2
 j7y8y/1TaSHQwaoVLHBhhMe4P8ZAlAZLuSB/ZfZTcKty2XDKo2QpULda/H23wOYMkKgLPByYgDU
 VeG29C31TTVrcxAxHVa5dMd/MteuUuTkZ+EXe6lRiOZRoP0AEIEpZusYnoWdbYnMSzsl0C53jWy
 L07FGpNtYymgdYxZLjSiD/Kp/u6KHLdxbHf7PD6UBd3ZFlESq+4+d/We8gSCC76udAOL89FLBXC
 kyW6HHZpHqBVRw==
X-Google-Smtp-Source: AGHT+IFuAYt3ED65hSxKlJciOCnJLVxaEp24nGAH+lG0DehqAnFSxLbH3tI+gbsRp06SFRry1gaJMQ==
X-Received: by 2002:a17:903:1c4:b0:216:4169:f9d7 with SMTP id
 d9443c01a7336-21f4e6a00f4mr344116125ad.2.1739283482797; 
 Tue, 11 Feb 2025 06:18:02 -0800 (PST)
Received: from [127.0.1.1] ([189.177.145.20]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21f3653cac5sm96957545ad.76.2025.02.11.06.18.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 06:18:02 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Anton Moryakov <ant.v.moryakov@gmail.com>
In-Reply-To: <20250206215521.354511-1-ant.v.moryakov@gmail.com>
References: <20250206215521.354511-1-ant.v.moryakov@gmail.com>
Subject: Re: [PATCH] common: fix: add NULL checks for malloc_cache_aligned in
Message-Id: <173928348212.3071479.815665355304490626.b4-ty@konsulko.com>
Date: Tue, 11 Feb 2025 08:18:02 -0600
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

On Fri, 07 Feb 2025 00:55:21 +0300, Anton Moryakov wrote:

> - Check return value of malloc_cache_aligned for presskey and sha.
> - Return -ENOMEM if memory allocation fails.
> - Free allocated memory in error paths."
> 
> Triggers found by static analyzer Svace.
> 
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


