Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03539C369C2
	for <u-boot@archiver.kernel.org>; Thu, 24 Apr 2025 16:44:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B4F5782076;
	Thu, 24 Apr 2025 18:43:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="EXtX/w/n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B03CB8082A; Thu, 24 Apr 2025 18:43:47 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82D6880BA8
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 18:43:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7303d9d5edeso442870a34.1
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 09:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1745513024; x=1746117824; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LWy2RoVTr730FiDveiY8nP0NguLcbP8xQSqHRYmw7Ow=;
 b=EXtX/w/n6Ub3i1gjGVkTKAwN8EjJ29uJ1djCwJZL981jo2Dq0CwoH+JCAsvT0XcX9M
 fdnYzr8XzligpCXaxJN1qvXGHNUaGanSBQNttHj5BKp/+Dx4rNOwkn5nyq0Me5eTxjvX
 IGnvTA6Qm/MqwVAj+y/hXqU6RbVy5nTE6JmFs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745513024; x=1746117824;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LWy2RoVTr730FiDveiY8nP0NguLcbP8xQSqHRYmw7Ow=;
 b=XOkZy31GixyH32QjxsJ2VmzBd4Jy6D/3QlXtEqWTbMcSczN8r4FI3ENOJiLL4AOEsQ
 WiR3R2NNiSy9hi7Iom8qibEMMBmEqWfmWMoudeYyKlkeN2+nPuURawImx5CItmmLLUFU
 iJaRMCqf+ntqOvobWxRTT7tD+Ad/eWjt3r7Cvu0v4HwqWOVLebLf6tO2EoCoT+UIo9GE
 zQjPCtngcOXhH+R7fj8+QouFMg8oLzsdf1tbEaxYASAuWDuQsKsc93h0NWd/FAYNtI9C
 GBY/YRX9SyKeN2jep3iYuT8IyTHYVZqTUHpDP1ZGQoZRGg/oN8rR9TNQg0NXTqvj9+Rn
 lNDg==
X-Gm-Message-State: AOJu0YxUNosbse9ocNcinx4/0hXZIHxuIXN5iAlWK8JkOJevAzgtzCIQ
 uk9KSShJxxn2pE6BN/RZfVvnOdQ2hWxKNYFEVqBFBCuJHZvpLpQrMwEh7GVaUPA=
X-Gm-Gg: ASbGncvWUTQfxRYr+jpejPlXWf0qkLAEWMhbwBAMhZxxIsS4cMNM/BCWpkeaK/JbmlW
 RJBZAAqTyUoeF+CRarMzHiuxMUbSxi3xJguS5xN01XbMksxXWGStu3HSckQx5sTGjK7abXSjczS
 2pgr8d7Of3B/tAIRI3a71E6wDSjATKU4QgfLsluTRI/v+XwNSljzuKr6bhkL23qrwUJDMlhVt1B
 Y5mnzTc5Rdl4Sc4+Ni5xgX6UcZEVCEyc3PePtwvY7nScFqNyGauj2MSBA2NHI050vzhXxiFAxyf
 6BINkzNBpvbgjNLaWoLIkZLulgGXcOBF6wQbl0S8+lJDmTAurR3rAIPznZxWaPFvvt2icjiINdx
 FFlalYbW9hgo=
X-Google-Smtp-Source: AGHT+IG+ottCX3SzCbk3NNbyjRzmWhrBQdsIx3Ak5nmFKpMTOLcYG7SFU37S59V2k+6lV6OOiB2p6g==
X-Received: by 2002:a05:6830:6181:b0:72b:992b:e41 with SMTP id
 46e09a7af769-7304dbc0994mr1925706a34.23.1745513024265; 
 Thu, 24 Apr 2025 09:43:44 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7304f2af97esm297869a34.41.2025.04.24.09.43.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Apr 2025 09:43:43 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Anshul Dalal <anshuld@ti.com>
Cc: vigneshr@ti.com
In-Reply-To: <20250415095225.448077-1-anshuld@ti.com>
References: <20250415095225.448077-1-anshuld@ti.com>
Subject: Re: [PATCH v1] mach-k3: add eMMC FS boot support for am62[ap]
Message-Id: <174551302359.4069373.9248985756748854973.b4-ty@konsulko.com>
Date: Thu, 24 Apr 2025 10:43:43 -0600
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

On Tue, 15 Apr 2025 15:22:24 +0530, Anshul Dalal wrote:

> This makes spl_mmc_boot_mode consistent across am62x, 62a and 62p.
> 
> If MMCSD_MODE_EMMCBOOT is returned, FS boot fails since it checks for FS
> on the hardware partitions, not the UDA. So to allow FS boot from EMMC,
> the function should return MMCSD_MODE_FS instead which allows us to read
> from FS on the UDA.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] mach-k3: add eMMC FS boot support for am62[ap]
      commit: 3b7893145e3621574f01e0bfde1277ec730dc5b6
-- 
Tom


