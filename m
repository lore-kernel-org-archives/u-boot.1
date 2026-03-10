Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 428C2FD4F16
	for <u-boot@archiver.kernel.org>; Tue, 10 Mar 2026 19:11:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8F52840DF;
	Tue, 10 Mar 2026 20:11:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VKvNBr3z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 44E4084113; Tue, 10 Mar 2026 20:11:01 +0100 (CET)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C72D840CB
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 20:10:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7d7473bed74so2619776a34.0
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 12:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773169858; x=1773774658; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=orTLFQ8BlmKfAtvB3wOBeMA4zvaJS/zImBsMJkdKzOo=;
 b=VKvNBr3zTWBtBgHUvIdpNKkofALl+CLln5BB6zkRKOHGF3xnL8i8X2Ug4fh/iknSY6
 1qDb9QVfvWf+pLlQ43gYwvxqnmgcVaOE5lqJZxCJNv6q6UMCPfnIy8KHsB0WomuwNxHE
 TCnQLp0Viu8/CMjjs1MYnyHES9HmDlI87PWjw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773169858; x=1773774658;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=orTLFQ8BlmKfAtvB3wOBeMA4zvaJS/zImBsMJkdKzOo=;
 b=b47tikbd0DN5RLlkeELP5jvCsDLmGidJTvLTqSnpzx26j603q9Rtiw2KxEjhgC2z65
 +YzS6ll0Nj4ZGd4yX32py/JgBZbj651OPS/2NzIs4icjADPHbruYA/MyS/MENZIl18Cd
 cG5mkKAk3NkmeSqEn+gT90cjo08qunD0b6Oq0umC3RjsP9qkVZ5JJNqlomQleet8E1Ew
 T+B+vn+rPuy7Ox0Snuwi8vaN1erJpWA0DsqCywvojRgiicTsPn5QpJ0YE4Jg1F9CFRCv
 SaS9dClKjKvEgKtfVOwteIEVwTFunpybfAaXzRbwXo5chUXQY5qIYyjDQa0DY1+k8mjK
 E2sA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTmvBlnksjEdaPHaWhVPcyFTrQmOFfeABLokaSUwJkRkNHtfW1aakIGy0qdL06k1dJE7uWb+M=@lists.denx.de
X-Gm-Message-State: AOJu0YyH/FBTZSuelt1RLXB0VJqHK4zU1Qu9FYC1ZY1zkiMtAUV03DiP
 W8NWEGQpoRNhUUncDhY6ZpKJWFQEMjcTlTImCp20X3C/iPyVs9PVcJnRAAEfVr8POH9VUyAgiLv
 Cv4csCwE=
X-Gm-Gg: ATEYQzy9V/APXRPI2oL34IhVcab5PPSu2MMvFNiFGRSLCMW9jRpZs17psjpmWfrKDBy
 Yt3QoQ1eQY8jQ4xFXgPlVPZmBfzH0IS/rXbkXFMpJV+p05FSjPDhsf1JxIZRwr4brNYEoPVBI7g
 gDToZ/ihJTZHWrfzq12med5oCXbm4b3luNM51ST0iht6X0TYpziagFKvQEeG6gDB96Jfwe+KkoS
 onrWnkl9jwHfvw78eUQauOetjFYGuguDX/xwXa/RicpnafX90yahPUDq4jA4oMiO1oNy03X92St
 /IwW/rhqvkQ7MarQRnoNEOLvlUXUcBaHc8ChPwPoN52Ut8/7FzKCwTdxHKNOFlAA8ByE6WfXPAL
 nK7hFbJn3ZMJjRvTgNlwY8F4rMFZvo4bwKxkkMsjPJHmHyQo0PFfxb1r6FP/cgnTnEB7hiNqxpQ
 qETVrWrQWXGjkI2AAm4skuclXwyTNurpJTwRCpYelLZRGjA1aiKoUg1njx3ykYVUplFD4fWapOr
 HtldNIwVCkjApnhhRABVRTA58OtNO0xNjDxUsNg0MY3
X-Received: by 2002:a05:6830:6688:b0:7d7:5d69:819f with SMTP id
 46e09a7af769-7d76a61b58cmr24808a34.13.1773169857766; 
 Tue, 10 Mar 2026 12:10:57 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-191-8-235.totalplay.net. [187.191.8.235])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d745cac199sm5626620a34.9.2026.03.10.12.10.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 12:10:57 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, ilias.apalodimas@linaro.org, 
 aswin.murugan@oss.qualcomm.com, christopher.obbard@linaro.org, 
 marek.vasut+renesas@mailbox.org, me@samcday.com, 
 gabriel.dalimonte@gmail.com, u-boot-qcom@groups.io, u-boot@lists.denx.de, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Cc: balaji.selvanathan@oss.qualcomm.com, 
 Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260224035000.1617869-1-varadarajan.narayanan@oss.qualcomm.com>
References: <20260224035000.1617869-1-varadarajan.narayanan@oss.qualcomm.com>
Subject: Re: [PATCH v6 1/2] fs: fat: Handle 'FAT sector size mismatch'
Message-Id: <177316985656.4188500.7620852698022807750.b4-ty@konsulko.com>
Date: Tue, 10 Mar 2026 13:10:56 -0600
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

On Tue, 24 Feb 2026 09:19:58 +0530, Varadarajan Narayanan wrote:

> The disk_read() and disk_write() functions of the FAT driver use the
> blk_dread() and blk_dwrite() respectively. The blk_* APIs read and write
> to the devices in terms of the device block size. However, the FAT
> driver reads in terms of the device block size (from fat_set_blk_dev and
> read_bootsectandvi) and sector size in the rest of the places.
> 
> This causes buffer overflows or partial reads when the FAT sector size
> is not equal to device block size. Fix this by using blk_dread in
> fat_set_blk_dev and read_bootsectandvi instead of disk_read. And update
> disk_read/disk_write to handle FAT sector size and block size mismatch.
> 
> [...]

Applied to u-boot/next, thanks!

[1/2] fs: fat: Handle 'FAT sector size mismatch'
      commit: 5e7b1384902d67f4c9c405e72ae92b172e9f1974
[2/2] configs: qcom: Enable FS_FAT_HANDLE_SECTOR_SIZE_MISMATCH
      commit: 1a935da84d16716d0974be2d8802017379035a01
-- 
Tom


