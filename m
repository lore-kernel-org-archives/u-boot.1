Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFAFEC282C6
	for <u-boot@archiver.kernel.org>; Fri, 28 Feb 2025 20:23:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB66980AE1;
	Fri, 28 Feb 2025 21:23:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dBvBoMDH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E093809A5; Fri, 28 Feb 2025 21:23:32 +0100 (CET)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37664810EB
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 21:23:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-22328dca22fso42327905ad.1
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 12:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1740774209; x=1741379009; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+aZ9ENAQN0v5guYab/UUfuqSzNVqPJ86HcmK/+o7a5E=;
 b=dBvBoMDHJ5XCuZHgsFgMKsj7cViLEL66mLwyTrhLH85UoBcvxIy+xCS4WgjeERM26q
 agBKCEGf125UqX2FvMNhYhfP667QKemUn8FiIj7qiXVtqAu9C/f84/NDG6xoA/0FeCsv
 boB5ez0Z1gP2e8HWmnU6FVPGR8ck2LBRSL4EU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740774209; x=1741379009;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+aZ9ENAQN0v5guYab/UUfuqSzNVqPJ86HcmK/+o7a5E=;
 b=LGD6JC+oYGbRGhsoyXNekAvHlqGwSvtj0HLej70b30+kR3mttj3/xxg1JxC7p46xHr
 aKhE6PTce9BzkgOkMCo0k660ytw6/vBpn1Sc+t0jXedpFclxNOA7ga2d/8WrOTMR9o82
 elT0Rxv10vxTvBmP2bpNi8//FR0yt53vh8Q8n933n/vdFr7ix4/OoBgbExYjFytJ3see
 gdx6/M2lX5lLyJQq73GMCtlVUqTbl+LXoOWuz3uy1xlH9y6n4vkwGAllwV+TvurF/ZpP
 5n1LUTOGRpZ0SEWGD+DYBW07xk2jrAQNLkl692mOVK4qOpEhrWBTlVgxnfM4dpeRJXmL
 kN3Q==
X-Gm-Message-State: AOJu0Yys6Xhl9GrEavBbvXXVfzqv1HgLrMCd+QryjedXUaIWFR3fzy6m
 121FfEtpQukh9epPhRcD7pdRMSjGs8/y/w3xbFcv6BVSR2IWntuL6SKiNK2ce5ymJORLxCHV6s3
 h
X-Gm-Gg: ASbGncs92POWRYo/bkb9ZhWQbYbWgStc1lvlik99MPn1mQMmPCxGQqDUAE2AjN43MQI
 cldMHIwNfWaM80VF6qAdf96M5c/jpxtYPBuUeGXzoyyjpRMnnho4VqnJ9zNrbfUC96vZ5VR9O5s
 5BtorPo4fpQHRKM/ucXOJvNAs1CqeKqGAvy49PIEKhJu1ITwPLwZVnT3PXNiWuY7/g4NFI3izS5
 jTp7STY887LHTXa3l24ewPRJkN6h0qrpZkk/xmmzhjqmF/MAyZ/g69EQHYpDAjmSPZKkXAAdsYB
 6IxpoZggZPxrq2z5j8HTuxc=
X-Google-Smtp-Source: AGHT+IGLIS4Mzz3WLAlrVK/XUNp8ZSFahcPskgurTt0HNy/BnyHPCGRHwXiW7oQyJFbdgtbDbg3M5Q==
X-Received: by 2002:a17:902:d4c6:b0:215:7446:2151 with SMTP id
 d9443c01a7336-22368f61abbmr68478095ad.4.1740774208749; 
 Fri, 28 Feb 2025 12:23:28 -0800 (PST)
Received: from [127.0.1.1] ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-734a003dd19sm4288337b3a.131.2025.02.28.12.23.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 12:23:28 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Alexander Stein <alexander.stein@ew.tq-group.com>
In-Reply-To: <20250220145808.1911832-1-alexander.stein@ew.tq-group.com>
References: <20250220145808.1911832-1-alexander.stein@ew.tq-group.com>
Subject: Re: [PATCH 1/1] mtd: mtdpart: Support MTD_SIZE_REMAINING with
 unallocated memory area
Message-Id: <174077420799.1188562.10603573825755823625.b4-ty@konsulko.com>
Date: Fri, 28 Feb 2025 14:23:27 -0600
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

On Thu, 20 Feb 2025 15:58:07 +0100, Alexander Stein wrote:

> If there is an unallocated memory area before the last, filling parting
> the size calculation for MTD_SIZE_REMAINING does not take this hole
> into account.
> Fix this by calculating the remaining size just based on total size
> and partition offset.
> 
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


