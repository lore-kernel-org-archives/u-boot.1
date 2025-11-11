Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF651CCFA1A
	for <u-boot@archiver.kernel.org>; Tue, 11 Nov 2025 20:15:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA2D183BAD;
	Tue, 11 Nov 2025 21:15:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XMPlT4w1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E31E83B91; Tue, 11 Nov 2025 21:15:03 +0100 (CET)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A3ADE83B91
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 21:14:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7c6ce4f65f7so129951a34.0
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 12:14:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762892096; x=1763496896; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A3p0Ldemw9KUFNf1FaIvD+OD5CUgb7afNzx1nhMhK58=;
 b=XMPlT4w14BZ77yshDGhwb537lb+rqlLwxpVGxYtbA/YDruRHRC2MWDIF6vTcaLDIVp
 /CIxK3xUlap4lSaVaZ9dX6+V/Q7DHapo74kOlbpWZARtyYK2+shTg62iLdSejIVHf6Ht
 QFCugfpnE9WhNALkEMWhaR4HPdxINHTxsz6Bk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762892096; x=1763496896;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=A3p0Ldemw9KUFNf1FaIvD+OD5CUgb7afNzx1nhMhK58=;
 b=uHVYwSCQ91w8IJyPktH9tHFEVJsG8YRjSLmetdC3UDei44J/cTMXzOyFAqL9pKyx2s
 MKJXF+/f6fBh0zuSFdDRY7vY0tRIOzCm7lsSWGQ08vlmigm9PadOw1fRPZ2uYsjJJgxv
 0FoBcmKhNVq+B1Bk/9JtSziqhaTujC+hisp6ju4Cp0rIapeOnlZ+LS2fPCCBgA71SKiF
 btkxlSsoAtANyEx9GH0NaLWNxOy7Wm9e4m+mc9KW2cggP4cqDiugdcgXPhUAArDZ7kZH
 lyILhQIRDuaJkKkwFGOITKCQKJLJnpTz1QIWfye2GWtV/s4j0JgX3E1k+uu6JJUZsDyI
 UtWA==
X-Gm-Message-State: AOJu0YysjtGLJ0ZdUYyxCma/NnzumeJV/jD9hxojm1F/O12PgAW5AvLf
 PGoSYmlS0bSGY4BHHQohnELWslxSldNwPqzCKbYjRcusRHsCgOgknCz/YS0oN+4XPz8=
X-Gm-Gg: ASbGnctQvu4lrXVHo4g6O44xT0OgtBP/se+oGBl/Vfe+seYL7H8JUA6u1xOVgBWYoTA
 c/6UnHFDmMIHlltiQNGjhQllYyp0joPNTdxp7yEilQipNZFuZ7SMj3fNem8ThO5sq35APADeG7I
 f+OByczucrnraUwzoidklEOzVV0cqvGciYhrqyHuuBBLKT8HgRbRiSqTeE1xEmQjklpuwWDh2b2
 TfnVuEosXxAKjGnED424G2QYyDYTVtkMiQoXI618QYuvj5BGCgAn66k0FQqYhRumacK2kkyPWSE
 mVpJSn4JUcHsDz+1qGunBWdW31ItB32stLqQ3OPVBLgHbd8qirqmRkT+1bvrnZyua9UpDlF/1NZ
 6PZ8wPxZBN6SmuCn7X3XeXHO01J1Z8uvLa3a2mQJdvclL3oy1yhKlMZ6HTQQ7JB8kPIgvfgsx9f
 SygW2NorGieHjjMX6CHv8vTJmtqYgpP1HDtfBFPg==
X-Google-Smtp-Source: AGHT+IEHmXnt/7RMvP2oqv5Zqz2lfKEOMcnlw15IytovhcvJzFnzKuppcjIxV4zK/vmfrONAQdIWmQ==
X-Received: by 2002:a05:6808:191f:b0:437:f573:b175 with SMTP id
 5614622812f47-45074583a2cmr198053b6e.31.1762892096430; 
 Tue, 11 Nov 2025 12:14:56 -0800 (PST)
Received: from [127.0.1.1] (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-45031835261sm4197443b6e.16.2025.11.11.12.14.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Nov 2025 12:14:55 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Kory Maincent <kory.maincent@bootlin.com>
Cc: Bajjuri Praneeth <praneeth@ti.com>, thomas.petazzoni@bootlin.com
In-Reply-To: <20251104095802.1026096-1-kory.maincent@bootlin.com>
References: <20251104095802.1026096-1-kory.maincent@bootlin.com>
Subject: Re: [PATCH] qfw: Fix segfault from uninitialized variables in sandbox
Message-Id: <176289209514.737015.5833817211076795094.b4-ty@konsulko.com>
Date: Tue, 11 Nov 2025 14:14:55 -0600
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

On Tue, 04 Nov 2025 10:58:01 +0100, Kory Maincent wrote:

> There are cases where qfw_read_entry() does not set the output parameter
> passed by address. This occurs with qfw_sandbox_read_entry_dma, which
> leaves the size variables uninitialized and causes a segfault when running
> bootflow scan in U-Boot sandbox.
> 
> $ ./u-boot
> ...
> U-Boot 2026.01-rc1-00199-gc2637036b8f0 (Nov 04 2025 - 10:32:21 +0100)
> ...
> Hit any key to stop autoboot: 0
> => bootflow scan
>      efi_var_to_file() Cannot persist EFI variables without system partition
>    efi_tcg2_register() Missing TPMv2 device for EFI_TCG_PROTOCOL
>     efi_rng_register() Missing RNG device for EFI_RNG_PROTOCOL
> scanning bus for devices...
> [3]    1015761 segmentation fault (core dumped)  ./u-boot
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] qfw: Fix segfault from uninitialized variables in sandbox
      commit: 664cdc5fd524db0c09c1200e89e65207a3b772a4
-- 
Tom


