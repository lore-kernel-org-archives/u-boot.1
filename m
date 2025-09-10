Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23F8ECA0FED
	for <u-boot@archiver.kernel.org>; Wed, 10 Sep 2025 18:15:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 204DE833EC;
	Wed, 10 Sep 2025 20:14:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ur3qygjx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BEE53833D1; Wed, 10 Sep 2025 20:14:49 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CB8083280
 for <u-boot@lists.denx.de>; Wed, 10 Sep 2025 20:14:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-74542b1b2bcso6139089a34.3
 for <u-boot@lists.denx.de>; Wed, 10 Sep 2025 11:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1757528086; x=1758132886; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aX8tyHicKnz2m4jZUGYtoUHrSv7O0rHpjX9CF+W29r4=;
 b=ur3qygjxduZmikm6ZViBW4mLRi2G03qjojHYsfwNLGXAAd8lTeqjCqF7sGOub2D6RV
 7BzjlqFh8A5RB3AsCHI34BKGo3KgalKT+HRLLbUO+XoYtLp50Yv0ycmTqkvbfWlUlbUC
 wl3n/bcBa84w69nSVgtNd+iC1e81qpDLBu744=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757528086; x=1758132886;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aX8tyHicKnz2m4jZUGYtoUHrSv7O0rHpjX9CF+W29r4=;
 b=IhbgwUjacko/+VNDpd2+me5AhIUBEXB0KOoBUrZNUVF94YJD8s7L7+W7+wiY4T/z74
 frKjkb7lcuS9tiQ98pDBpHq3f2lgrPonEIp+dvdcq27x3fVd78Z5UNw/AFRUflb+IWY8
 e7uLKdHGulNiFGfHflBHjgQk+NYv9sT2RgyvoPQkBknA0KVGMMvBNjsytg+x0MK8wQrJ
 kTgvcIwb4ornowuCDaFfKouRCps2bq2fCaT8nE/pkZZWI0oiEmaO54NHyzjeXv0If6ps
 1ZQnjOGYCt7E2k40y0FYE2/VfOiRnZWqfdba2jqcHZJrLenJfnP4w52AwuQ3KE9J4npN
 TQzQ==
X-Gm-Message-State: AOJu0Yx5WrPSCglnnoegDGGs8DBvqtoLgaiBCNqeebzxg5uBY8RfjnLv
 gfDbZz+y4JvJYbh1oU4YQPlxXeQkTkgLvVwf7ueQFKKhqsGJ7tqe03o26bekxBKlIQg=
X-Gm-Gg: ASbGncuzLKk97+rZKtnOWckMiHWQ99o8FYzR5DFMdVnYz6rC306gswCwu4AQXfzilOd
 /ydFfamG1SSQyvedKOrOuNn7eKzl2hQQX124n6sV+bPYlTKCPU4a58w+kvjIAn+7tMPsQDnYVMv
 9jNPVSZk1d/LSUhb/SSpYAqv2bnLVXwRVsofWIhkI0EDrcifeZUdXLPjlgBjtZzoY6YA7Afa4vD
 HBB/3x8qJgBc4vYY3edncTYkcxh3fg69Uuy24Ecbo+GHd/AjnY33OZXpX20Lrv2S4IKQbOtGJKB
 SwC1pF4LRkHw8u/9BWReH1nopzF5fAwcHIxa1lp5VUTs67hoQGZ8sAwGmhpgGb9PCjploUw1L9I
 lBVcL4MDzNE6aSg95hO+QyX3IbGvZtyngo/cEABZRYc3xTeGh3oEbspxYATBpEodWew==
X-Google-Smtp-Source: AGHT+IGJAKQCU6eLWpfZZQn+fun2yQM5rbqumOXW2PYKWTcoliau1z1udwCYa37IZTb6SLq/YfjTXw==
X-Received: by 2002:a05:6830:2695:b0:745:a08d:cbc8 with SMTP id
 46e09a7af769-74c7641c6bbmr7750398a34.24.1757528085992; 
 Wed, 10 Sep 2025 11:14:45 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-75200e6a1casm18100a34.17.2025.09.10.11.14.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Sep 2025 11:14:45 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>, 
 Jan Kiszka <jan.kiszka@siemens.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>
In-Reply-To: <b18a4f45-77dd-4f78-ba6c-2e017abc98b9@siemens.com>
References: <b18a4f45-77dd-4f78-ba6c-2e017abc98b9@siemens.com>
Subject: Re: [PATCH v2] tools: Do not generate logo when cross-building
Message-Id: <175752808500.1959855.6085893942133582439.b4-ty@konsulko.com>
Date: Wed, 10 Sep 2025 12:14:45 -0600
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

On Sat, 23 Aug 2025 17:21:09 +0200, Jan Kiszka wrote:

> This cannot work (unless qemu-user is registered in binfmt_misc) as the
> tools will be for a different architecture.
> 
> Fixes "make cross_tools" in case CONFIG_VIDEO_LOGO is enabled.
> 
> 

Applied to u-boot/next, thanks!

[1/1] tools: Do not generate logo when cross-building
      commit: 371a76e845504c9ba7ca216b6edfb4ae4ec14e56
-- 
Tom


