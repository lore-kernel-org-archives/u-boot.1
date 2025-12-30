Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07D83EE49B4
	for <u-boot@archiver.kernel.org>; Tue, 30 Dec 2025 23:20:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FF1183FE9;
	Wed, 31 Dec 2025 00:19:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="CzgOjAfb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2D3183FA4; Wed, 31 Dec 2025 00:19:45 +0100 (CET)
Received: from mail-oa1-x43.google.com (mail-oa1-x43.google.com
 [IPv6:2001:4860:4864:20::43])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1BE3E83FD3
 for <u-boot@lists.denx.de>; Wed, 31 Dec 2025 00:19:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x43.google.com with SMTP id
 586e51a60fabf-3fe9d6179efso1643347fac.1
 for <u-boot@lists.denx.de>; Tue, 30 Dec 2025 15:19:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1767136780; x=1767741580; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R12nO1jQTXsC4tfVK/fviZ5g1N9OVPn36WU0t5BTYVk=;
 b=CzgOjAfbridgyeXcY7WvCGqx4mPoYnfbd1BAeZV+TcqrGB9VxmIpWNoDgMuwGeTUPa
 ITmzvN9tGuNIbpvckyhG1c0p9bcXNQkkb184Pro1qoljv3BofucKV8KzpY+jZZ2BUY15
 XO5DwbLn9B5b6QVCEXlZMhzuN3AM6Ui5TF5Aw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767136780; x=1767741580;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=R12nO1jQTXsC4tfVK/fviZ5g1N9OVPn36WU0t5BTYVk=;
 b=iViRdMDi91IWFHOFsdUI2wHF5r6NqnpkBSerEo0ka6R2mIqD2BbfMJbn2iGyQScoyz
 5orsKZavfWU8W6Sizea8GUbK6nXEEzURKKX7j9Y6hEGpGXqVhGLF/pG8K8ohgj/opllJ
 k2575dXIkKfOS4BADIq0oBhDlDy7yhWJLwgNHHlWGPff26Z5mFj9Cuz1ISMx4Nb4wp5d
 8rFdvx807tYicK0Q/Y7IxH/BFl7XcwJNrxUeqZ0nRwM+XBDISFGnautg7LILIBvZPbNL
 0/ccHd/NUHwjvp+N0ywQNJuw2TrmvsELOBX/Sn3Tv6MyUx/2BNPqa9W4aGxbNrKlpz2l
 qa9w==
X-Gm-Message-State: AOJu0YzZaz2J2QcLWHo6R+5UayF1NpjiPjrzTJ8IOpLIiJ9MQuipPfBF
 wMG53kRkPVyKDmrrUn3mlBtouiS9kUDOkCwtK4DIU1IKVTHSF8k9GY8uOyEdBnYzZus=
X-Gm-Gg: AY/fxX4WILKu94P44hqTr9q6M93XL7OLqVaL0uc/x1zNmxmQfQQ0UIrsTDluBmM7qEn
 FXk5J3bzmq5ktTFz641wPn15rSV6o6lxonviL6VGAblB09Pl6JmvYsbe2IluuynWrcVedpBDLKd
 5sPeqrB+6xBYd/Ek/w5wtV01IajJ6X5lMbDUijGH/3P7BaDsUJ3y4PISnYLSDWQJNhNZybnB+5Q
 GvTu2fiaPK8yRK8Nl4iKY1T1pWIc7Dd5w8DP/mGkmC/dGy9GKp04F31dUrN46SWaLJByeUCnT8l
 Ral68r6RBfJPJvHzLjQbsbpCHuU/g7p+n8PIrvDe1UjxxbbBEo+Cgb2PmiQ2BU5EajOYok+rB0u
 XcHiWo3jXu8LQmYkwJzDYDFxcADiFUiMvDYHdpSvueHL2V9SaWjistmJ47KKLDXhBUWD4ccKdaA
 qeKVqwtdMxcywbbMAw8MkVCF1lTxBhE+x8F7Tle50oIW0b+8mva8j21LB//c92V/N4tJvPzBU3k
 HfZv3gZRnxW1v5T16rpEE4sGnGuoGwea8bKCw==
X-Google-Smtp-Source: AGHT+IGGosUmVH7cJ3/W4RRDRB9c/BN+FVPbGKl1nnLVcFWuuxsR44iNtFP0jBqdMO+XVm+wzbKlrQ==
X-Received: by 2002:a05:6820:8307:b0:657:59a8:5611 with SMTP id
 006d021491bc7-65d0e01ecbemr10890074eaf.0.1767136779820; 
 Tue, 30 Dec 2025 15:19:39 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3fdaa8d4521sm21172083fac.4.2025.12.30.15.19.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Dec 2025 15:19:39 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Anatolij Gustschin <ag.dev.uboot@gmail.com>
In-Reply-To: <20251112200315.1111980-1-trini@konsulko.com>
References: <20251112200315.1111980-1-trini@konsulko.com>
Subject: Re: [PATCHv2 0/7] video: Remove unused drivers, clean up dependencies
Message-Id: <176713677906.315706.15360754947965448640.b4-ty@konsulko.com>
Date: Tue, 30 Dec 2025 17:19:39 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Wed, 12 Nov 2025 14:00:01 -0600, Tom Rini wrote:

> This is v2 of the series I originally posted back in August[1]. The
> changes here are that I've dropped the first patch as TI has recently
> posted their rework of the driver in question, and I added Svyatoslav's
> Reviewed-by tag. The end goal here is that "allyesconfig" will be able
> to build (on sandbox).
> 
> [1]: https://patchwork.ozlabs.org/project/uboot/list/?series=468123&state=*
> 
> [...]

Applied to u-boot/next, thanks!

[1/7] video: mali_dp: Remove unused driver
      commit: c2ef9e1b0cb7e32a8046e4714a219fd21b9a0daf
[2/7] video: tegra: Rework some of the driver dependencies
      commit: 68735fd33427ff1576f37391f24b5d8912afe45e
[3/7] video: Tighten some video driver dependencies
      commit: 96d1e8b29b4fc3aa150bce520f33966955efa456
[4/7] video: anx9804: Only build when needed
      commit: e1bcce1dbbb13a7ec1e8f02e8ce27fad8c550f23
[5/7] video: ihs_video_out: Add missing <asm/io.h> to ihs_video_out.c
      commit: 082e5118dab3a23c3d61ed429ad03195efe57653
[6/7] video: sharp-lq101r1sx01: Do not make use of 'z' for printing non-size_t
      commit: 5d3af86ae16f1207e1b38b00fccb5d01965cc778
[7/7] video: stm32: stm32_ltdc: Add missing <linux/sizes.h> to stm32_ltdc.c
      commit: b6f78b815af652cf7ce47db48f93d6283cad4c5b
-- 
Tom


