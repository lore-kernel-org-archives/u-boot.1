Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31CF5CCF9EE
	for <u-boot@archiver.kernel.org>; Wed, 29 Oct 2025 18:08:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 92E9A8331F;
	Wed, 29 Oct 2025 19:08:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="AQ8pDngG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E387482A9E; Wed, 29 Oct 2025 19:08:04 +0100 (CET)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5371E82A9E
 for <u-boot@lists.denx.de>; Wed, 29 Oct 2025 19:08:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-44f76e8d10bso124359b6e.1
 for <u-boot@lists.denx.de>; Wed, 29 Oct 2025 11:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1761761281; x=1762366081; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yBhcZ1yi+L1ha9yXEv0qbXtbspwYtut6JQ27ZxEiriE=;
 b=AQ8pDngGu/OkNy74062goQFytA3rFuJLpBfYkat7dSnYX1FfG0rFXBYEYFF1g22PNe
 h8xa2dcOAk01LePrhsQLlv8wo+bgmdyqNsV31RFut0xLLvoQKcWYaSq2adp0Zoa9ZDa8
 EH9wz8+IAnDiuJAATtDWu+gK8NrIdoqUuY3ZA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761761281; x=1762366081;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yBhcZ1yi+L1ha9yXEv0qbXtbspwYtut6JQ27ZxEiriE=;
 b=AecRPbegOA9RCV6MRm6i/JBmhMNVNFUfEVmdIN/4o88piJ2wLLdkk7tMqsC095MH1D
 jGr6ttQjxxet0SrMITIhCT/AogiPzyoZY4a3nn7Fp9JgCMWF5wwoq5S4NeMXAf34YFK/
 xtuDoyl7y9bVJuYxz0SOjcrBLcxX/iCsKmjYEg1gnGIB4cFY/KhKWIFA6aSg0FNa+dGy
 SFKbITwQ2NT/ylPyjZ2OIB4wDrhmTaZ/wXclWRgpn5yGhcIn+O++DBKXL86z7q12IR34
 aTnOBNkHWNGaFnGluKorSMen2VZnUyzUHqjOh78KMsFSxix1ao9liaqU9z/ioSxj2KlD
 yI9A==
X-Gm-Message-State: AOJu0YzkQ5YNx+LVab4G7D85BrkRBhlwlwXwTuA/sxD+nEGAgeYTVgx1
 vbGuhpymIb8XBO7JgJyH3wiKofMt88GZPp+go0CUdmGNPxvJ3IPU26aGjf47Sy+AosJeMOeVnYF
 uNOYizkrPCg==
X-Gm-Gg: ASbGncssmXsYazkNl4uRKWCX4OCBvb2Z0KOmfyXCgDQ3LeI0ootS+yPj1mKYimfqU/D
 oR6xOIQSQ7spmW2YgeUoWbuTsKZMk+NnmraD6FxJAq61bvDzuBcRqLBk6NwtyTCYGizKt3jK+vk
 rwgg2O0v0cOl4GGOA4LQZ5Lkbo9r569Js9yfCtnTXdaJyv7fVja5mE42d/2WuDEkcbPtysJE3AX
 txxhUZ/yU/x8zjnGFy9dDDhfUdYs1qq0pjEnk92tTH1cDH2ajWiyGXP4UzDMxvC4MSQlFv8GS/4
 pBSNfYlu/3EOtD00oWeU8+m6fdg6B3Q7Z6Z0iC6ueLfULwJdMUFIjp958ZlcomaaNTLVXYw5bCm
 o7YlnWUkVvDhMXUhHMQnK1mi5AEJEzjcXBhoAz4NWkEllO9iH3X5kkgRdhfPWvpIXjpIIzhWtMJ
 s3SieSd3tAipVQtbPuw73S//DQvYxsp2sb8MzLaw==
X-Google-Smtp-Source: AGHT+IHk/SPxGQQXqG1Fv6kbKmaxH4CB6RdepCHk8KOT0bLbRibsPl4I/LU7S6xO879ZuOSAIb/miA==
X-Received: by 2002:a05:6808:c173:b0:438:27af:3ff8 with SMTP id
 5614622812f47-44f89d3bfe4mr76364b6e.7.1761761280873; 
 Wed, 29 Oct 2025 11:08:00 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-44da3e93e0esm3555356b6e.17.2025.10.29.11.07.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Oct 2025 11:08:00 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Leo Liang <ycliang@andestech.com>
Cc: u-boot@lists.denx.de, rick@andestech.com, e@freeshell.de, 
 jimmy.ho@sifive.com
In-Reply-To: <aQHEYtIGJ9sab_Ai@swlinux02>
References: <aQHEYtIGJ9sab_Ai@swlinux02>
Subject: Re: [PULL] u-boot-riscv/master
Message-Id: <176176127995.2497692.6569306743037421733.b4-ty@konsulko.com>
Date: Wed, 29 Oct 2025 12:07:59 -0600
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

On Wed, 29 Oct 2025 15:38:10 +0800, Leo Liang wrote:

> The following changes since commit 23987e10905146def3ab61e55ec912c6e742efdc:
> 
>   Prepare v2026.01-rc1 (2025-10-27 16:10:23 -0600)
> 
> are available in the Git repository at:
> 
>   https://source.denx.de/u-boot/custodians/u-boot-riscv.git
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


