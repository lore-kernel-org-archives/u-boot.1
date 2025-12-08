Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2457D3B7E2
	for <u-boot@archiver.kernel.org>; Mon,  8 Dec 2025 22:09:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D391883946;
	Mon,  8 Dec 2025 23:09:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lcVjVmn4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E81F683AEE; Mon,  8 Dec 2025 23:09:40 +0100 (CET)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1CCC783935
 for <u-boot@lists.denx.de>; Mon,  8 Dec 2025 23:09:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-450823a7776so1973178b6e.2
 for <u-boot@lists.denx.de>; Mon, 08 Dec 2025 14:09:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1765231777; x=1765836577; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7nCdcol6a2sdturNAYKWaoAlwR+/EwFUNmjFS/3J86Q=;
 b=lcVjVmn4AHiNY3Cl8H+TvTi8fw+I9GtPy/xQysK7GShrvs/z8ZTY0zXKkTKtlgdTrR
 gANEbzuIxA78n9MnISTtB+jgSUMctue6/vyZshGVeunJ9x9HAJ6LHeVOxyedWvqTT3lC
 ubHr5OlINLrr6uRHJPyhKUApJSo1JKfZNxok4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765231777; x=1765836577;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7nCdcol6a2sdturNAYKWaoAlwR+/EwFUNmjFS/3J86Q=;
 b=eYjbWzuNAcmx3Zu+tFAn7OSsMrK8WP62TRdttrxmNMlXvXFoHhfHBElKHDw7M08TUH
 /F5XHbFhvFuGh91wHsMZYvrluUwhmd9zMb9RVca4GgpGxbK4KGFBhCjmfW1vZIgEp6zj
 YfzOFohBbGi3ZrbjCfmRfXkQrski0lv/KVozIDfAW8tqlpxv5RbQmPngLf7GjjNXAT56
 +SzZN4ooSIOT6835AM2EMj3ea1WjGGHrVqCk4+R//WicWLN1mi+RYOPWywzsiUkPEh8P
 YkAvIRLVDVtazEhA6sgLR07ISHvvKKwwsQsGSh8TKCuEC2xuRir00toHpYxvS9h4K/Fd
 5S/w==
X-Gm-Message-State: AOJu0YxTpcTO37l35ftygMj+eVqw94dM7JsllhpDvjJoGFb4Jo+kkAL+
 kll1QQc46qNVTgxPRGxQ6/zX602ZxR+dsT8OBgf/RpEBx8phZZLpVqbE32DCJ6kiTl4=
X-Gm-Gg: ASbGnct2d6TjpPoEAau03TJQAU3+Trhqn1GEL8OSfCNjS5EhRzcdWuDpRf1E71DrZtI
 SXGPmF4q82MSB27ogYpEqu/LwXHEXuVqoM9Oo+HNMmXIR7vqqcmDYZYHi/K5soFBthsqtajAysy
 nqf1+TL2iOlYKGK82xOziMpNflU7wYRHoStU5E+znXjI82FbNOmi2wIFzG4ALXzw5FZzCkI8jG3
 kwaa9nCMfkN94CHzQPIrIEbR2lvSe191ZCJ0dg3FD2MdzFgX8Dd4lPBPtSpSOMJz13HjTEVvGIM
 kLUFSyjYJHBwitOgaNcx76Dgt4Qcpe7K+0RtqD7dL24cZQ8kKeejClgBBT/2qkkMxIVdhptZRVP
 pv95lVlaIxLWWxGpYOelfC2yWIk9bmfn//QDr3ofDyshVY/Cm57u4VkMs9truCkt1Lvg0xJbB4Y
 CnYCBD1lF2EtTqFYdYozXjU1mPfDSEn3DYvXssPCPXvpMDCbEw
X-Google-Smtp-Source: AGHT+IHHBV4FgrqRQN035MMdtZYavqGmXlM2jpsfLJEeg+LE72p8m3gJvRgJ1nFr8ysKGzTc/pXBAQ==
X-Received: by 2002:a05:6808:1902:b0:450:794a:6d08 with SMTP id
 5614622812f47-4539e10bc49mr4075044b6e.49.1765231776781; 
 Mon, 08 Dec 2025 14:09:36 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c95a8f85e7sm10979778a34.4.2025.12.08.14.09.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Dec 2025 14:09:36 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Leo Liang <ycliang@andestech.com>
Cc: rick@andestech.com, conor@kernel.org, e@freeshell.de, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <aTZt7Xzv6W2M3H8v@swlinux02>
References: <aTZt7Xzv6W2M3H8v@swlinux02>
Subject: Re: [GIT PULL] u-boot-riscv/next
Message-Id: <176523177593.465338.6254582667327869362.b4-ty@konsulko.com>
Date: Mon, 08 Dec 2025 16:09:35 -0600
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

On Mon, 08 Dec 2025 14:19:25 +0800, Leo Liang wrote:

> The following changes since commit 8e12d6ccb3cfa84dd275a1b852b2a235de0162b0:
> 
>   Merge patch series "Azure: Rework world build to directly use the container" (2025-12-07 12:53:09 -0600)
> 
> are available in the Git repository at:
> 
>   https://source.denx.de/u-boot/custodians/u-boot-riscv.git next
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom


