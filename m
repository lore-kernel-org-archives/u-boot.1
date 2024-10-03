Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07358CF8555
	for <u-boot@archiver.kernel.org>; Thu,  3 Oct 2024 02:53:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 57328890E9;
	Thu,  3 Oct 2024 04:52:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="o9rWoTFI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA6DC88EE4; Thu,  3 Oct 2024 04:52:40 +0200 (CEST)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F60289017
 for <u-boot@lists.denx.de>; Thu,  3 Oct 2024 04:52:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-6cb321145easo4487976d6.1
 for <u-boot@lists.denx.de>; Wed, 02 Oct 2024 19:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1727923957; x=1728528757; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wPYxhxMrYcSTbzEYhUS4VxUwawhyPAJIviWgG7URpUA=;
 b=o9rWoTFIOaFxU2eEaYA3ZrHmMxaQms/PowOtR80++zW/BoE5VqovxxUZFJAwNQoZky
 ZhAF+1ecM867yW+Fvrymz7BZbMIcVbJDQYhIe2yyvBxvh1l6rn16a9M0+27qm4KphII9
 0RUnsx3QKe7MGdW6PuTIkCJY3tQ92NS1N6Odk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727923957; x=1728528757;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wPYxhxMrYcSTbzEYhUS4VxUwawhyPAJIviWgG7URpUA=;
 b=tdWd7xeAlaiEItS36khUuj48XBK+VN3o2plm5VjELhXizM3lqWcEmRQlt/SjKolgQv
 HHDwqU7pCKICxaIIpgi1r94WxgSMNECrraGU+9nS+byPbhz3wagFJDSu99dvVbXKqWLT
 baI/2yDiVa+QI9m75iopPwwbNW3RjV/akq8hRXk//Y8qbI/MU6Vlsk86BPDZ05N869cE
 jwITYdhSBXE7HaZSS5M7Agunj6Ahu89SV204xJqPtDScOHAdGjVfJXYXdW3830epoX9e
 ztmPCyZ44MXKmkHKcTUg8bKh3CxA1MzRZQULcYAmeVUcM0L42Y70wCovWzTrriKtS0tW
 UDlw==
X-Gm-Message-State: AOJu0YwLc2r9SO53a07vInTAbysiUsn1M+t9g14lIaIIPASxXQzgIT87
 goaBdLRDHngOzYhLSH4bxO7zqtzqfMb+aSTwZnCvzffi1cFCjQUBwsmFzasEdJOgcYtLD9/q5RM
 RMcE=
X-Google-Smtp-Source: AGHT+IGzsvYtz58XzWMeEp22hA4phsHKR98VHH27b4d2Csv2k1MEltX8KdxW8k1LjRSTduYJTkj6rg==
X-Received: by 2002:a05:6214:5983:b0:6cb:f46:2c53 with SMTP id
 6a1803df08f44-6cb900f65e8mr38305986d6.6.1727923957502; 
 Wed, 02 Oct 2024 19:52:37 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.65.244]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cb938211f0sm1606826d6.142.2024.10.02.19.52.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Oct 2024 19:52:36 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Francesco Dolcini <francesco@dolcini.it>
Cc: Hiago De Franco <hiago.franco@toradex.com>, Keerthy <j-keerthy@ti.com>, 
 Amjad Ouled-Ameur <aouledameur@baylibre.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>
In-Reply-To: <20240916130336.12472-1-francesco@dolcini.it>
References: <20240916130336.12472-1-francesco@dolcini.it>
Subject: Re: [PATCH v2] fs: Fix SPL build if SPL_FS_LOADER is enabled and
 FS_LOADER is disabled
Message-Id: <172792395531.1516896.4094366374847268672.b4-ty@konsulko.com>
Date: Wed, 02 Oct 2024 20:52:35 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Mon, 16 Sep 2024 15:03:36 +0200, Francesco Dolcini wrote:

> When SPL_FS_LOADER is set to y and FS_LOADER is not enabled, the SPL build
> fails with the following errors:
> 
>   AR      spl/boot/built-in.o
>   LD      spl/u-boot-spl
> arm-none-linux-gnueabihf-ld.bfd: drivers/misc/fs_loader.o: in function
> `fw_get_filesystem_firmware':
> /u-boot/drivers/misc/fs_loader.c:162: undefined reference to
> `fs_set_blk_dev'
> arm-none-linux-gnueabihf-ld.bfd: /home/frh/tdx/src/u-boot/drivers/misc/
> fs_loader.c:185: undefined reference to `fs_read'
> arm-none-linux-gnueabihf-ld.bfd: drivers/misc/fs_loader.o: in function
> `select_fs_dev':
> /u-boot/drivers/misc/fs_loader.c:89: undefined reference to
> `fs_set_blk_dev_with_part'
> make[1]: *** [scripts/Makefile.spl:527: spl/u-boot-spl] Error 1
> make: *** [Makefile:2055: spl/u-boot-spl] Error 2
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


