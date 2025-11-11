Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AB7FCCFA1A
	for <u-boot@archiver.kernel.org>; Tue, 11 Nov 2025 20:15:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E6C483BBE;
	Tue, 11 Nov 2025 21:15:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="i6s4U43g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 461B483F97; Tue, 11 Nov 2025 21:15:08 +0100 (CET)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4508983BBE
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 21:14:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7c70fcc8561so67292a34.0
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 12:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762892098; x=1763496898; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hQW1mJQwyiU7E+b4jygQ7iwwZWpXyJpOMt+PKWHpYJI=;
 b=i6s4U43gNwuAQH6qqQwJqL1bpgOrEqZC7WwlVd2XgpBLdEyYfZRnusowXCo4TqGxRb
 E6FP/CeINnBoXNj9pNL8kVvUj7ravodB2rvi4sUSF9tKB3uBtu+/kggFFELRfZ0U3pCA
 Od7Khig8uRYqRnOQJVAdsk05H7JLUJ2O29Zmk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762892098; x=1763496898;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=hQW1mJQwyiU7E+b4jygQ7iwwZWpXyJpOMt+PKWHpYJI=;
 b=LXKMWDQc50xH6Su+XwvHsyimmYk/1HF9vG7/rS0+c+VFYFs06qYn6sxOT7GuT7+xpC
 iH5WNYFkE6EmkgWXc3klJO0In4EnnZol/a42lv80dS995+Vgnms4bl5uRZk8YFhoyHMd
 gVBcDFuhoqWwUxI3dSLyOdWk6KiRgm7JLl3dwvDwMzoE8rp86q+cbkWgbU5GoDQ3mmbQ
 aXGt9J0AC3aD9izdSfU6WNT0vQGygMd+jnH48366p2GWNS/fQad0ydqji7EynsdG4YFs
 z1hVNgRBFAjWThORrx4dp22khsw7NHB7qln9cx3xp5ZKI6vemYXEnS4JPFGrbrK+vSvB
 pXkQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqJNLzaW7rNAyd2NXIietRAnkpuSpXB8PI10EU1Sfytj9yZtkRPy1EH7K5UtR8H2Ls97bpsq4=@lists.denx.de
X-Gm-Message-State: AOJu0YxAPiKe6P43LNAkzSq4rOgtW7kcSqXdBs/HOWjsa3z06rUNzWC/
 WSNKa4RG8HlRmxoLUbYbEvX9D7L5ZRou6zjFKVNQmWbhwnuhcvi+ar/DgCSt0qkTrpVRsLTideO
 YJTNjrdKtJQ==
X-Gm-Gg: ASbGncsGIu+hxrpyVI8cWVIF4bLjSkjFMPmcud6VgRVnlRbrIdTYOVRtuqquu076Oi+
 1ppZgBVrL2TrQBKBqGBqQjIwtXuhcdIEfcAYNLd/18eNJeHIvD4xkLpRdhzy3XrlPiU6nkGg81j
 mkSb1kyjKHjQzZVwpt9LhHHgFxKHRcKogn8nBhOW0d9nzOOz7LFdfSJlqV+n/HJ5loYWJjd73Qh
 wWL407krraml00oDbjCmKueuhrOnkCxYe5Rjti1hNZ4XfZkALqlSnVFh8vBi1F8MIiR9u19aCTj
 gY18kx2il6ckLKedS0+CyU1YDCR97+ayrwxx2hz/oypU7N+D+INMi7oD/DCTdmTrCIkJbLKksEb
 FJAMECr7NXzwdD6nxPOvZsfuaqSn0bJp0cIMeqDea1646lZLE3aUCXrwXabMwuE22LX0r2Jyj57
 1boDVvIwv7WK18JFt8WV6sRWsSzyrIbVvi+7WldmIOVmikaNXgHAP4AoaL1XY=
X-Google-Smtp-Source: AGHT+IHVmnOybzS1GBlyvGXYLhLEnXj9/pUWZZcLs4PP01QCEvBQDZIgKQOrZ8WlG3m3tNN8/j90xA==
X-Received: by 2002:a05:6808:308d:b0:450:5bbe:642c with SMTP id
 5614622812f47-4507444e178mr254694b6e.12.1762892098026; 
 Tue, 11 Nov 2025 12:14:58 -0800 (PST)
Received: from [127.0.1.1] (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-45031835261sm4197443b6e.16.2025.11.11.12.14.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Nov 2025 12:14:57 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>, 
 U-Boot Mailing List <u-boot@lists.denx.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Bin Meng <bmeng.cn@gmail.com>
In-Reply-To: <20251105110724.634741-1-bmeng.cn@gmail.com>
References: <20251105110724.634741-1-bmeng.cn@gmail.com>
Subject: Re: [PATCH] scsi: Fix the name string memory leak during scsi scan
Message-Id: <176289209735.737015.4207981471427904584.b4-ty@konsulko.com>
Date: Tue, 11 Nov 2025 14:14:57 -0600
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

On Wed, 05 Nov 2025 19:07:24 +0800, Bin Meng wrote:

> There is a memory leak during the scsi scan process due to the
> strdup'ed name string is never freed. Actually it is unnecessary
> to pass a strdup'ed name string to blk_create_devicef() as we can
> use the name string on the stack directly.
> 
> 

Applied to u-boot/master, thanks!

[1/1] scsi: Fix the name string memory leak during scsi scan
      commit: c6e8befd4b8da4a99c779a0fddd92690e2f611fa
-- 
Tom


