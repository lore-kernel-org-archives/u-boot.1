Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC4E606A31A
	for <u-boot@archiver.kernel.org>; Sun, 25 Oct 2026 19:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=DmX+YCVI;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=D4GCM3DV
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7336040600;
	Sun, 25 Oct 2026 19:37:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ukPIH4cSSXxy; Sun, 25 Oct 2026 19:37:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6D73C405F6
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792957069;
	b=akjmOlpVYXVhPHC/MasFIukvaFzZZcU517W0wMciKftR+qR3Ks5MgV58raXdfA0lepES
	 cI0fXnjcT5s5MZVIIMyUCyLWFw/AkRHQfp7bwNTZt5Azd53GhPZFBZF0SaQA5Z8jPHrYQ
	 /Th5Er6IGBduMrG+OaYmAkCmjnYrtaQkJJjZEQZq0oO4me5plqNV6gqivbY5JMNzHkbHV
	 NtNVo0JAkIo/bLYjY3QjJ18SpCElLRaPu+OiiIx4wv440BWEmB8aCK/VYHwpMx6OnWN24
	 DSGK1rulDNoOgBmCSIUw91shrukbM16Ne6i+2SnA30zqLjUPL1rtYczaSyVS0aCAIvw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792957069;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=IQlPWg+qZO9heX97RyZlbZJSxpEGQmwgFmCk/q5pI58=;
	b=Q5EGNbmsODi0o7Mk629etmFHL05m5snO7mqW1XcXKc0PKN/BD5JUOh4vw670TU2XF/cN
	 bsKsFEgyRQ+jplIxQG/BusAHndet/yQZpDor2M5gua2kh8T+1tThCFGJyKoLY5ZiV2smq
	 127kti9gEKd9Z8YvQ8PFzl5KQMCfd3yBEGjzVMswbs/tsUtTqD7IOzkpW9bgQawtRWgBZ
	 I4pMmBRmpzgnGJIZ/4pdHxmV6wnjVWBv80beDIOPPG7tvzKFozMGo9IKkR4nPqRDLc/mS
	 o8KC0irFheER4FH2W8iZ/bhMpZFTvPjorNuEajZGJ1CAjLs9mPbZsk1IxLFplE8p5ug==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792957069;
	bh=IQlPWg+qZO9heX97RyZlbZJSxpEGQmwgFmCk/q5pI58=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DmX+YCVIjS3iHICzCT8MM9VGL6z1RtWd+k8PF7SWWHlev7GyBfK9Ftc+gJTVlFp9h
	 AW5YKGIqIfhxrWWTh+qPl3LrEBZG1pMSx9o4Ak/hKcK+NEiDpaVzGS1SHnb5KPRnO4
	 3Cak7Ld18vRbIlt494houoAo6UJHRT2aXxuSVPBD8BW4Ok9FT1tLdH+rS/d765cZde
	 qoX6lFSoYuGH20j2bS+X+9ocSaHbvRAOn+GYiggn9p4nlgpUvLFqbtjTpa9l17c/d4
	 rvM/EPRMgG7kh/HokGNgRf1gG/PMAF5oAKe0SIvKhDmHEjX2T3wUzN0fx7IqbLEjJ9
	 duz8qKAOfT5Dg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6D73C405F6;
	Sun, 25 Oct 2026 19:37:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 470A33D9
 for <u-boot@lists.u-boot-project.org>; Sun, 25 Oct 2026 17:33:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2CC3240098
 for <u-boot@lists.u-boot-project.org>; Sun, 25 Oct 2026 17:33:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ot1a1KUTP1_n for <u-boot@lists.u-boot-project.org>;
 Sun, 25 Oct 2026 17:33:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org EEA8E40057
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792949609;
 b=OJxA9ago8hrq7aGfawlfVLbq/l2s9h7PtvIMt/xRxNmWx59bGkkcVjVv012/3tt5OQRf
 3XsbvCTP0TLnj/r/4le61bJh7soZSPYj56SB4jaW4HheSNJuqr8YAMoSH4cvH0NrEkmid
 UClNWa37BHUoxyhueFTmtfNCbCc8EQ6D8MmP80uyKdmT5R5ktffw993Ubv3UgIk19h/mx
 0Wdv4pZuM+ryhdiK/OpHlzCL7586Z/nkX7L2P6ghK9XCLwE7VAnnLF+qRX9spFGy/qMAc
 Sq2e6GyG6SdR9iwithS9AaUDooIFjsSm7EhWcxzWTlByCYF8ai9XC+DxW2p8EDrEgxw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792949609;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=IQlPWg+qZO9heX97RyZlbZJSxpEGQmwgFmCk/q5pI58=;
 b=tGJ92SYKgomKoUJGQEJKToWbp32hYbIJlDCxVQBoiv3KNS/xZFbhHLKm1n/sKIPstVFs
 a/hWDGx2sKKYzJ6TapDlnep5yP1ZvOL5kkgc3+G7a11H+IN7otiOK9DLloetkpP1OiEa0
 HoiFBHvq/0VVYen/7rAh7Q3nWMMG+PGHEM4VXwlKLGLbNb9O+uOIp9Db6BeX5UT10XUVB
 SdlzcjshieNWGFC5FBRGyye/+pq6t2xFS9XfXFxDmz6MT0C72UJg6Xkl4OiKGR2BUZ+ak
 FykoqyEqf5EpRBgmB9giTbfP7Q9f+fMZml12Ikv/fp/FfDDfawoSDJUvC/R4VBQqfUQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=D4GCM3DV; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32a; helo=mail-wm1-x32a.google.com;
 envelope-from=andrey.lalaev@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=D4GCM3DV
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EEA8E40057
 for <u-boot@lists.u-boot-project.org>; Sun, 25 Oct 2026 17:33:28 +0000 (UTC)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4a35db1f202so7435135e9.3
 for <u-boot@lists.u-boot-project.org>; Sun, 25 Oct 2026 10:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792949606; x=1793554406;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=IQlPWg+qZO9heX97RyZlbZJSxpEGQmwgFmCk/q5pI58=;
 b=D4GCM3DVxPOB4GQjuU3mQzHFGVmDuSuToyn7HGQXvmDv6AbxzBsEhzI6bZd3d32yES
 X9Pn3/cnlSxTUDt7USmYf+4uoz4LQ2XYHsu5H2LV+5KaHttZ+XLgA3NCWRcXlFfCnk2c
 zV6AMCRvqCMRt4k2FkrHNr568/hEGRhyZg49MOmqT3xi5GXcYCCwQrZ3LXcO4vqn/Zts
 poqAeXwcTiVzYzsnf6uJj7H40lI/runp0sPXV35LV1OWCit4NcWg1Ej5g71maSU7mM6J
 yShUxha6+jVMbMSFP6js1iBHpgnh7v0VeEcMEHdZVHdn1uTkyAksz7epktQdQCIrb/GU
 NtoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792949606; x=1793554406;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IQlPWg+qZO9heX97RyZlbZJSxpEGQmwgFmCk/q5pI58=;
 b=KtThP5EosyxRfBr435/tUhzKFaM7UDZ0yp0G+t9Id0tdwz+ySTJo1xsp0ZeLBtIMZe
 gvZQnP42l463asyYUnBpnXvdzvQvNv3DeYIe13rhwyNpjYdYqMVT/KprrfkVnEAxC7PY
 7cbDUKIBUeCByGgbkPAV4CdR/W+6zbLc3JhfaYo0SG1DlJM1EM4BMGEWZB2gJNLcXGuL
 P92YPWHEaBCEwSXdRr+kHzpA9tOrrPHVHb+d0LGeZgDJqb38wJgFe6ANHNhRSv1IY7PM
 Uub1FBQo2g7L7hFhvdK0Ox/CQw5TL9UBfKeAll+skBV7lhCDTr2DKWaAWBm8VxBf6Rex
 OxtA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwlKj0OkcVtdtnZUzdBzJyRTC169sAt+315pVxDyOHtuuPZlLfJmvF8RPcooZ/IRcdicp0YuAU=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLg2OFsGk4/cbkIuD2fHxD+HJPM2+ZsNfxiLcIHj/MjTtGlA2Ur
 mzQuItEBwL7jInr6K80OyN+w4pGZj1m/VRyNa/S5rmqfV8uf/HjMxCDu
X-Gm-Gg: AYBFou1KFjo1GQpZl+cs2oncVuVvIMActMtaWFyIgCw6qOybE0AdvkDSUadjgN/fgDb
 +BMWzk2eivXEqFXHXsxU99geQglVHAajKf+7Z7XfNpDFtIsY9/UorzH45nib3I+daE8eYIktvTC
 nCC1xD4MIjvchQnwBETKjHy3EY+xk3xjsDflARDkZudR9ey+mMdasBirI3hZbaUZK9azrBhC9Zc
 msQS89ECJhRgzcGN++FuLVQUXA2CLj82jtcNPaKp4CiWAO9xEAo1LiAa0QnYcAosU5chz1Zs0QQ
 T35HFDaLrtxHL+QtVmNR4Cu/wLWISSlaI0JDcqcVst9exB+xbitmA6KqQ0Y2LSrqin/X8skz4Ne
 lmd97gonouRA1rWIaq5hCJyYkyqVH5lic2OAylA/ahavqOswadG3a4+c59uZWIue6LWSzoNJiNr
 P0sLHezFAn8n+fmj/kefN8SypImT8lqe5e3oVCypqgk0ybVQKqGJS3RwiQyPJtSS24071F7XFuJ
 yCyssSk16q8rwRef0G5OPktuObFhYNjaXbBNHt9Sgo9aFwBLg3MT79u+lmRQ9r08wcbNH+Um2Vd
 se28JnZhKYV/vhGpQctcOHh3ljkc1aFA8CBh4ZNdycv+N5GInCCKFyk/9u6hbTcW1JO5PF960Z7
 3kHbsOoewdkc2YwZFOieMT8coo0nGBnRhxJcP+mV91+pVluzbLSqPMqMNYQ==
X-Received: by 2002:a05:600c:4e4d:b0:4a1:d459:db4b with SMTP id
 5b1f17b1804b1-4a35acba70dmr84884125e9.24.1792949606414; 
 Sun, 25 Oct 2026 10:33:26 -0700 (PDT)
Received: from ?IPV6:2a02:8388:e6ca:5780:c16d:3347:4cf:d093?
 (2a02-8388-e6ca-5780-c16d-3347-04cf-d093.cable.dynamic.v6.surfer.at.
 [2a02:8388:e6ca:5780:c16d:3347:4cf:d093])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a2c0458sm133841775e9.11.2026.10.25.10.33.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 25 Oct 2026 10:33:26 -0700 (PDT)
Message-ID: <c8c19841-ed29-42df-bb64-b9161b57df39@gmail.com>
Date: Sun, 25 Oct 2026 18:33:24 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] riscv: sophgo: add SPL support for the Milk-V Duo
To: Hiago De Franco <hfranco@baylibre.com>, u-boot@lists.u-boot-project.org,
 Yao Zi <me@ziyao.cc>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Marek Vasut
 <marex@nabladev.com>, Tim Ouyang <tim609@andestech.com>,
 Leo Liang <leo.liang@sifive.com>, Kongyang Liu <seashell11234455@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Bin Liu <b-liu@ti.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Zhuxu Ran
 <zhuxu_ran@zohomail.com>, Udit Kumar <u-kumar1@ti.com>
References: <20261021-milkv-duo-spl-v1-0-ee7618860237@baylibre.com>
Content-Language: en-GB
From: Andrei Lalaev <andrey.lalaev@gmail.com>
In-Reply-To: <20261021-milkv-duo-spl-v1-0-ee7618860237@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Sun, 25 Oct 2026 19:37:46 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Hiago,

On 21.10.26 14:54, Hiago De Franco wrote:
> This series adds SPL support for the Milk-V Duo (Sophgo CV1800B, 64 MiB
> DDR2), so the board no longer needs the vendor FSBL to bring up DDR,
> configure the PLLs and hand off to OpenSBI and U-Boot proper.
> 
> Currently this board only builds a bare u-boot.bin that depends on the
> vendor FSBL (and the vendor fiptool) to do all of the early hardware
> bring-up before U-Boot starts. With this series:
> 
> - The SPL is loaded directly by the BootROM from fip.bin, built by a new
>   binman entry type that reproduces the fiptool image layout (param1
>   header + BL2 header) without depending on the vendor tool.
> - SPL enables the C906 caches and T-HEAD ISA extensions, brings up and
>   trains the DDR2 controller/PHY, and initializes the PLLs, all ported
>   from the Sophgo FSBL sources [1] (plat/cv180x).
> - SPL also takes over the RTC power domain configuration for shutdown,
>   warm reset, power-cycle and watchdog reset, matching what the vendor
>   FSBL used to configure.
> - SPL then loads the FIT image (OpenSBI, U-Boot and the DT) placed at
>   offset 0x40000 of fip.bin via the BootROM ROMAPI, and hands off to
>   OpenSBI, which starts U-Boot in S-mode.
> - Board documentation is updated.
> 
> Tested by booting a Milk-V Duo board from an SD card (fip.bin on the FAT
> partition) built with this series (SPL -> OpenSBI -> U-Boot -> Linux).
> 
> This series used the help of Claude Opus 5.5 to read the FSBL and turn
> it into U-Boot SPL.
> 
> [1] https://github.com/sophgo/fsbl.git
> 
> Signed-off-by: Hiago De Franco <hfranco@baylibre.com>
> ---
> Hiago De Franco (8):
>       binman: add Sophgo CV18xx FIP entry type
>       riscv: cv1800b: add SPL support
>       ram: sophgo: add CV180x DDR2 driver
>       board: sophgo: milkv_duo: add SPL support
>       board: sophgo: milkv_duo: initialize PLLs in SPL
>       board: sophgo: milkv_duo: enable RTC power and reset
>       doc: board: sophgo: milkv_duo: update documentation
>       doc: board: sophgo: milkv_duo: document the SPL boot flow
> 
>  arch/riscv/cpu/cv1800b/Kconfig                     |   2 +
>  arch/riscv/cpu/cv1800b/Makefile                    |   4 +
>  arch/riscv/cpu/cv1800b/spl.c                       |  31 +
>  arch/riscv/dts/cv1800b-milkv-duo-u-boot.dtsi       |  92 +++
>  arch/riscv/include/asm/arch-cv1800b/rom_api.h      |  36 ++
>  board/sophgo/milkv_duo/Kconfig                     |   5 +
>  board/sophgo/milkv_duo/MAINTAINERS                 |   6 +-
>  board/sophgo/milkv_duo/Makefile                    |   1 +
>  board/sophgo/milkv_duo/spl.c                       | 250 ++++++++
>  configs/milkv_duo_defconfig                        |  18 +
>  doc/board/sophgo/milkv_duo.rst                     |  76 ++-
>  drivers/ram/Kconfig                                |   1 +
>  drivers/ram/Makefile                               |   1 +
>  drivers/ram/sophgo/Kconfig                         |   6 +
>  drivers/ram/sophgo/Makefile                        |   6 +
>  drivers/ram/sophgo/cv180x_ddr.c                    | 140 +++++
>  drivers/ram/sophgo/cvx16_pinmux.c                  |  54 ++
>  drivers/ram/sophgo/ddr_patch_regs.c                |  39 ++
>  drivers/ram/sophgo/ddr_pkg_info.c                  | 110 ++++
>  drivers/ram/sophgo/ddr_sys.c                       | 635 +++++++++++++++++++++
>  drivers/ram/sophgo/ddr_sys.h                       | 108 ++++
>  drivers/ram/sophgo/ddrc_init.c                     | 476 +++++++++++++++
>  drivers/ram/sophgo/phy_init.c                      | 193 +++++++
>  tools/binman/etype/sophgo_cv18xx_fip.py            |  89 +++
>  tools/binman/ftest.py                              |  54 ++
>  tools/binman/test/vendor/sophgo_cv18xx_fip.dts     |  18 +
>  .../test/vendor/sophgo_cv18xx_fip_bad_offset.dts   |  16 +
>  .../test/vendor/sophgo_cv18xx_fip_collection.dts   |  19 +
>  28 files changed, 2454 insertions(+), 32 deletions(-)
> ---
> base-commit: a58e2b7af42c179ace2c6210de0a219fa3f3cf3c
> change-id: 20261017-milkv-duo-spl-2e2fae6858f1
> prerequisite-change-id: 20260929-milkv-duo-bootstd-14de5e4e03ef:v2
> prerequisite-patch-id: 0aaa37872f2b82c2abfc84364f9256c7cb3394fe
> prerequisite-patch-id: 927c8bc825dd9897467da6b194ae8c7c411ec874
> prerequisite-patch-id: 7c0fedb64aabab799b72eef81efc8becec8f44cd
> 
> Best regards,
> --  
> Hiago
> 


Thank you for your work. Works as expected :)
For the whole series:

Tested-by: Andrei Lalaev <andrey.lalaev@gmail.com>

-- 
Best regards,
Andrei Lalaev
