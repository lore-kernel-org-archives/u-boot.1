Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 265F4C3DA79
	for <u-boot@archiver.kernel.org>; Mon, 15 Jan 2024 10:12:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3CD2D87061;
	Mon, 15 Jan 2024 11:12:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="nWdglQe3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 40B3387061; Mon, 15 Jan 2024 11:12:55 +0100 (CET)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0C1485E44
 for <u-boot@lists.denx.de>; Mon, 15 Jan 2024 11:12:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-28bae84fc2eso1672471a91.1
 for <u-boot@lists.denx.de>; Mon, 15 Jan 2024 02:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705313571; x=1705918371; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
 :subject:date:message-id:reply-to;
 bh=19JjZTTgM/qTkuaYYT7sONjc7NuIzTzKJEz5gULSgO4=;
 b=nWdglQe3soBiJlSyFIDJqtwi3u/EMQQVLpfTPW7nlGbYVuwgA5Z/eTQc9gxDiYb3i8
 YstZC4uYVyA+U9NMcWaWOHJV3+woXPoD86uY5A1AWAoXA87vu4b9K9IXzvCqWh0yw0sG
 LRbSw7ToFkLdOoOckFVBfZiZ0i4NyqGd5FxtOyHy4hjZ7sInrR5dQBJBerLZCjroUDk6
 km3ythrsrs4sDzX/bVwquj7g9AwotllXugnz2swic602efTZ9lgVe0u+nWufwuzaZ0CW
 hJzHjdcTx8stHSLPdfGqCS5kF8479V8MHtRa+wn9apz27GsL5ogCkIBvQa54WDTO2L85
 yP+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705313571; x=1705918371;
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=19JjZTTgM/qTkuaYYT7sONjc7NuIzTzKJEz5gULSgO4=;
 b=RlRD+QCFPQOWxlmrhMxzRp0otOY1DcEFXnVBrCroOl1JYlVvBsJrNp6KKjMRjdtxxO
 p7Q+sdyxI9WhNnZupWcRlmTgo1fbez6u1i5KRcXZzrVORt9PRJuvTbyMqLFg8+wPAM+L
 dZmO9z1/CFYEL1K94+hYr4CYzYCrg8tswmPBL2QxheTwdv/FWfrMS9moBa83P2y/Un7Q
 eG0ENfkOVbOc7BmdBJk2CNUejZbn+f8H0Z3mKd0MS0u8PuhL5m/A3cFqT9v8ysuTYJLa
 4OFUAkbiZNrUgQf4aXeYCDocIHUq3wQX18fVwbgqfOUB1QXXMQyL1jOMmiaNpznzdQUK
 29wg==
X-Gm-Message-State: AOJu0YyEzdoDWqVqhPqkMMvSv+tXoNe3wMQj0YUJrcg91sKLi/rWrP3D
 us7AtRTqCzhGY41tPbCQTz2w0ZUHnUQkrw==
X-Google-Smtp-Source: AGHT+IGxd8a4VcgssHvTN8lU+PVMPgyAWvG8GnbSRVqgT0YVs/Xigz5UJBLG9gFvkVafVKBg05H6BA==
X-Received: by 2002:a17:90b:3b88:b0:28d:136c:8859 with SMTP id
 pc8-20020a17090b3b8800b0028d136c8859mr8777560pjb.3.1705313570919; 
 Mon, 15 Jan 2024 02:12:50 -0800 (PST)
Received: from octopus ([2400:4050:c3e1:100:4e3a:6682:78c7:6f45])
 by smtp.gmail.com with ESMTPSA id
 sc4-20020a17090b510400b0028cefda6fa2sm9386073pjb.24.2024.01.15.02.12.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jan 2024 02:12:50 -0800 (PST)
Date: Mon, 15 Jan 2024 19:12:47 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de, trini@konsulko.com, sjg@chromium.org,
 ilias.apalodimas@linaro.org
Subject: Re: [PATCH v4 2/4] efi_loader: rename BOOTEFI_BOOTMGR to EFI_BOOTMGR
Message-ID: <ZaUFH3r9MdW+tHTv@octopus>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de,
 trini@konsulko.com, sjg@chromium.org, ilias.apalodimas@linaro.org
References: <20240110011637.174710-1-takahiro.akashi@linaro.org>
 <20240110011637.174710-3-takahiro.akashi@linaro.org>
 <1c42a17d-1043-4449-93c2-9020c1ded71d@gmx.de>
 <ZaSDUrTQ2Z5N+gil@octopus>
 <d70d5134-1cc9-4d56-9aa3-499ed992584c@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d70d5134-1cc9-4d56-9aa3-499ed992584c@gmx.de>
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

On Mon, Jan 15, 2024 at 09:34:51AM +0100, Heinrich Schuchardt wrote:
> On 1/15/24 01:58, AKASHI Takahiro wrote:
> > On Sun, Jan 14, 2024 at 01:46:45PM +0100, Heinrich Schuchardt wrote:
> > > On 1/10/24 02:16, AKASHI Takahiro wrote:
> > > > At this point, EFI boot manager interfaces is fully independent from
> > > > bootefi command. So just rename the configuration parameter.
> > > > 
> > > > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > > > Reviewed-by: Simon Glass <sjg@chromium.org>
> > > 
> > > This patch breaks the 'bootefi hello' command in
> > > qemu-riscv64_smode_defconfig and other QEMU defconfigs.
> > 
> > What happened? Please elaborate details so that I can trace your issue.
> > 
> > On my side, I didn't see any problem with "bootefi hello" on qemu-arm64
> > and moreover CI check (github pull request) didn't complain anything.
> 
> The failures are logged in
> https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/19302

In the logs for qemu-arm64, qemu-risc64 and maybe others as well,
I see the same error:
--- ---
______________________________ test_efi_grub_net _______________________________
test/py/tests/test_efi_loader.py:188: in test_efi_grub_net
    addr = fetch_tftp_file(u_boot_console, 'env__efi_loader_grub_file')
test/py/tests/test_efi_loader.py:136: in fetch_tftp_file
    assert expected_text in output
E   assert 'Bytes transferred = 520192' in "*** ERROR: `serverip' not set"
--- ---

This seems to be the root cause and my commit will have nothing to do
with the problem.
Please check the test environment.

-Takahiro Akashi

> I have pushed the tag failed_20240114 to
> https://source.denx.de/u-boot/custodians/u-boot-efi.git for analysis.
> 
> Best regards
> 
> Heinrich
