Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 545A2C5AD49
	for <u-boot@archiver.kernel.org>; Mon,  2 Jun 2025 22:37:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7BB718212B;
	Tue,  3 Jun 2025 00:36:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QT+LhXvb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F69582E35; Tue,  3 Jun 2025 00:36:49 +0200 (CEST)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6114882CA6
 for <u-boot@lists.denx.de>; Tue,  3 Jun 2025 00:36:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-408d7e2ad03so889004b6e.1
 for <u-boot@lists.denx.de>; Mon, 02 Jun 2025 15:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748903806; x=1749508606; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yYS+4ndt8epb1QhgpoOYxal3NHxZr/bidH83rOgo5KU=;
 b=QT+LhXvbuzfbzSGjoZSJPtCGEbhpQadL3VOH9vUXZw1UNBkUjC5YeKwFGJyvU8iY7J
 7ZmOQCEGpuvqKStMyQC49ixq2x/NEVFRZS7GXiLB+8UH9gatBkTVadZ5JAnZqv0aAjrQ
 D6yjY6FYce6HDE/hWhJmOa34+hoK2rP3hc+9I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748903806; x=1749508606;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yYS+4ndt8epb1QhgpoOYxal3NHxZr/bidH83rOgo5KU=;
 b=Xb9k9OovmQILHQgJSRnIHJ2Vx4s1CoAB63wMAfydEtGBEcNysM9hYigfAKCQQrf7dv
 O6KClCWncbLycBvdrTwjdewsGgQzh9kL7MVmFdb4T3hUesUmCPSDaKj8XtMBQR0TQG0W
 JCJkDh7k5eXqJu41+JAouOrfmIJ0CoSfZry+qA+JpcXukRlK9pU3B3t1a7hWyfD0ySzm
 WgDyCnMThfx2MyvY/NT+Lk88bj8b59Z2NJMbXNH9uV93hNyZfhZ456C5c5vNtLXmVfsr
 18IvDrJvwcOuCNZ3/5hjIemlw4XzbcaQmprmHhQEYI1rgfmGMFdRTzb6mJlfz1aZUT60
 kb7Q==
X-Gm-Message-State: AOJu0Ywp7Xnxl+pAKvpgjbEC+kMOh8zYXnv2z6saT8Tdpy+nDV27tD5n
 jvImQGXDRxq7+gXeSL+f0IEpaeDr+YEYANWCXfAAGIf24jRy3PNLI3XR3kFLobGxUBE=
X-Gm-Gg: ASbGncuYNDCFaym7LBOF+gn+rZrIICqHoltajABF+zBrAm+Fuvo7bq8ILnN7ln37Exy
 lysLmgYXkOZurFlxSQrLTkqmpbripwjGgGAgn4Z2BNHVMU4xfzySX+g1sxSV+sGFOPSYoqm/rxo
 /HRMhoM9DjLkBoi8G77VcxUPrFbcRc2dl8njNEa/l/cvRr9TPeSz+z6O5HQZ+ijq04B5/FCjKaS
 rzXu+L0G33VrKfqw0S5OLAGEMbnpENQ8lpsQ84yTTBW4j+KPAv/ix7ojHI4LtDSA2Hxm86mm8qH
 FtW7td7fdpMcda7xCv7Pb1myZxy8J04CAFWuwcfqtovZtW+WTDTXA1PyxCWu1I9hkfK8vQatDj4
 gdT5u/DLL26I=
X-Google-Smtp-Source: AGHT+IES5AMM51xh+yvIW6zRUV0Ms5UPfe/fENWB8CC9HG2tfhXOgcnvdsNJzCkPvYMlD4koZ1WgGg==
X-Received: by 2002:a05:6808:6f95:b0:3f6:abbf:bb88 with SMTP id
 5614622812f47-4067e6b2398mr9482820b6e.29.1748903806109; 
 Mon, 02 Jun 2025 15:36:46 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40678c1b622sm1584145b6e.11.2025.06.02.15.36.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Jun 2025 15:36:45 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250527093332.518931-1-patrick.rudolph@9elements.com>
References: <20250527093332.518931-1-patrick.rudolph@9elements.com>
Subject: Re: [PATCH] arm/dts/qemu-sbsa: Fix interrupt
Message-Id: <174890380494.1382323.14363152951948377894.b4-ty@konsulko.com>
Date: Mon, 02 Jun 2025 16:36:44 -0600
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

On Tue, 27 May 2025 11:33:31 +0200, Patrick Rudolph wrote:

> Change the vcpumntirq in the GICv3 node from SPI to PPI.
> 
> Prevents Linux from complaining:
> '[Firmware Bug]: CPU interface incapable of MMIO access'
> 
> Fixes: 6d722894fd48 "board: emulation: Add QEMU sbsa support"
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] arm/dts/qemu-sbsa: Fix interrupt
      commit: d1555de5fa21c06118540dcd4a627a1af29bbb40
-- 
Tom


