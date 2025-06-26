Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18B72C7EE33
	for <u-boot@archiver.kernel.org>; Thu, 26 Jun 2025 22:17:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20D3482B34;
	Fri, 27 Jun 2025 00:16:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=marliere.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=marliere.net header.i=@marliere.net header.b="mv0fhGa9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E9FE82977; Thu, 26 Jun 2025 23:56:53 +0200 (CEST)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4090D80E9A;
 Thu, 26 Jun 2025 23:56:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=marliere.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rbmarliere@gmail.com
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-8731c3473c3so41948239f.1; 
 Thu, 26 Jun 2025 14:56:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750975007; x=1751579807;
 h=in-reply-to:references:to:cc:subject:message-id:date
 :content-transfer-encoding:mime-version:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SC20LiWWtz5KUGCUi3XhzR02YMG6updQi+P8j0cV62w=;
 b=kOcxpzNi/BPpqeJLKDVX0iKuQEwKTeVCAnSqtYnPrjrq5eZrSaO/f0AZxBn8RelVB6
 ZaeD6Zm6Sl35r359scguoR2IF3A0l6LoDzWk2FDXPaZyE6D8pgF4lGXwk/Opf41XPGT8
 Luva4ZT8l2DUX00SmaZs81Effegk00PdxrMbOwJpAdiKZH6rebSPN+8IukJg99565r5E
 m4b0Thjv2bLwcpKrljEeCcDp7SntUh7MUgPUkW6pj7zND72hHyKJM369L/9FUeQWUz9E
 WpQLxxLRcRRrEBARRMjQjHjP20Ke8cWhh51y1F4tT4QPILowLB/bcM8Wgs9elGBsVdf+
 cpvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUeGDjRm9DoXivh+PD3rEEaEvgZEyM1hZWADzJ4soZtcqEGB0skxPELfBAzcfiYnTtcvvlHmUJhLRZyiRomg==@lists.denx.de
X-Gm-Message-State: AOJu0YzoHRnnXMDA5EdlU4e10BdPtV3tuePZKfofx9xzm4UqAy+m1xQ8
 LC8kw23yhBNsKyB2arQ5TdPc6fibgwrVchLODAGG8HuPFtT4ku8BtKD2
X-Gm-Gg: ASbGnctdg/F+MfROFDAVHXBoOI81D1aFP0UqSZifB8sBbNKOG6W5vivboy1n6sZi00R
 s91AhYlueh0BAMO2ZMPQOag8wFKJpMoOZ7NM7qVdeLDuDbCtB5UaSaoh0hgAijPp8c3KWh/JFBN
 hlgRP3EEhvzemT/XTKDk32HihDuzYH/cuST1Y3rKPNLjeW+iYqV/m/DJT41jYwbtu0i9XdEh3IU
 Fk+vIiVvHmcyy+987+XbBKzOe72jSLBr6HHjs9QxdYq48pHSmXW9Wdh8FOgqvifQPm6z1KMh2Ko
 yX7YGQ3owYsKVBWwLpeM6jBl9WDtwHP6dnfsFXNgc4hSDT8WIzAXgqs8bK2IxXOGy/4KNizGLNB
 w9QYgBwbMm5awwL1V2/p1kR1Eb2PuMpVY
X-Google-Smtp-Source: AGHT+IEm4/8kp5fBz7ZPh9KiB9PNxtfgycndudgrDDv58Bv4OWmbRMlrfPGNJfV44UIjkrMZBa8hOg==
X-Received: by 2002:a05:6602:c88:b0:875:bc7c:5cf3 with SMTP id
 ca18e2360f4ac-876880f9d34mr185538939f.0.1750975006845; 
 Thu, 26 Jun 2025 14:56:46 -0700 (PDT)
Received: from mail.marliere.net (137.65.66.34.bc.googleusercontent.com.
 [34.66.65.137]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-502048c6ceesm186583173.47.2025.06.26.14.56.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Jun 2025 14:56:46 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id A0DB360754; Thu, 26 Jun 2025 21:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
 s=dkim; t=1750975004;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=SC20LiWWtz5KUGCUi3XhzR02YMG6updQi+P8j0cV62w=;
 b=mv0fhGa94wO/UQhp4OdAkxH5b89ZD3v2PPYpDJBy3JwJFOGIwx5TvAQDZYac5loeko4T/p
 ILDcAD2roEiXwGheobmYMFoznfRa8F4kO06gCR0Aj5fgrYyR7Kw8LifCplki86bMNgBnT3
 JrPCFSpXzxwP985C5bA7Z5kTtAXd9ISqLXb5+U1KVKIpEuYVlc0B0gLDwm8xLV6iHkG8+U
 bzfnP4hun+NzhmNwnd9M6ZzZOFHXdmIskJBn3DHEjGzT3DX/3Lc6yXPMdGNAS4TWFvlzl7
 UB0CLdjJfZIRJewMiMBLc0tOwrM2rL8Ht3pf2LAVc38jenA7+DXKtuIKCcTNkQ==
From: =?utf-8?B?UmljYXJkbyBCLiBNYXJsacOocmU=?= <ricardo@marliere.net>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 26 Jun 2025 18:56:34 -0300
Message-Id: <DAWSTZRJDZG2.3VCR6G95TP40K@marliere.net>
Subject: Re: [PATCH 0/5] Convert Lichee Pi 4A to use S-Mode proper U-Boot
Cc: <u-boot@lists.denx.de>, "Han Gao" <rabenda.cn@gmail.com>, "Han Gao"
 <gaohan@iscas.ac.cn>, "U-Boot" <u-boot-bounces@lists.denx.de>
To: "Yao Zi" <ziyao@disroot.org>, "Rick Chen" <rick@andestech.com>, "Leo"
 <ycliang@andestech.com>, "Tom Rini" <trini@konsulko.com>, "Wei Fu"
 <wefu@redhat.com>, "Yixun Lan" <dlan@gentoo.org>, "Ilias Apalodimas"
 <ilias.apalodimas@linaro.org>, "Maksim Kiselev" <bigunclemax@gmail.com>,
 "Jaehoon Chung" <jh80.chung@samsung.com>, "Jerome Forissier"
 <jerome.forissier@linaro.org>, "Sughosh Ganu" <sughosh.ganu@linaro.org>
X-Mailer: aerc 0.20.1-80-g1fe8ed687c05-dirty
References: <20250530094851.57198-1-ziyao@disroot.org>
In-Reply-To: <20250530094851.57198-1-ziyao@disroot.org>
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Fri, 27 Jun 2025 00:16:19 +0200
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

On Fri May 30, 2025 at 6:48 AM -03, Yao Zi wrote:
> RISC-V software usually expects that HARTs are running under S mode when
> leaving the firmware, for example, the UEFI specification explicitly
> states requirements for S mode.
>
> This series separates M-mode-only code for TH1520 port out, and
> configures binman to pack the OpenSBI firmware to initialize the S-mode
> environment. Then S-mode proper U-Boot is enabled on our Lichee Pi 4A
> port.
>
> Note that booting on Lichee Pi 4A is broken between PATCH 3 and 4,
> affecting bisectability. Considering TH1520 port is still in an early
> stage and separating the changes make the commit cleaner, I personally
> consider it's acceptable.
>
> Yao Zi (5):
>   riscv: cpu: th1520: Build spl.c for SPL only
>   riscv: cpu: th1520: Support cache enabling/disabling in M mode only
>   riscv: dts: th1520: Prepare binman configuration for loading OpenSBI
>   board: thead: licheepi4a: Run proper U-Boot in S-Mode
>   doc: thead: lpi4a: Update for S-Mode proper U-Boot support
>
>  arch/riscv/cpu/th1520/Makefile          |   2 +-
>  arch/riscv/cpu/th1520/cache.c           |   2 +
>  arch/riscv/dts/thead-th1520-binman.dtsi |  32 +++++-
>  configs/th1520_lpi4a_defconfig          |   1 +
>  doc/board/thead/lpi4a.rst               | 125 +++++++-----------------
>  5 files changed, 68 insertions(+), 94 deletions(-)

I also tested with OpenSBI 1.6 on a Lichee Pi 4A 8GB.

Tested-by: Ricardo B. Marli=C3=A8re <ricardo@marliere.net>
