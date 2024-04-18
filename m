Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2778AC4345F
	for <u-boot@archiver.kernel.org>; Thu, 18 Apr 2024 03:41:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5025C88587;
	Thu, 18 Apr 2024 05:40:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KhRCCiw/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5F8A88562; Thu, 18 Apr 2024 05:40:20 +0200 (CEST)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9019288503
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 05:40:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-78f03917484so24371585a.3
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 20:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1713411617; x=1714016417; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RM6VekCrvyB9+9WOu2BfNVyxt8A+BHewODY3bmig/bQ=;
 b=KhRCCiw/4R2bILr85q/S7BgoYa1OYq4uILgdCUx/915F7iNX810dIlLmsKY0kweQTM
 lnKhF7q/jQ9BwighMh00mTn5b6gxu/QPy7OJnFR+lsYa9QMkHw1dj2C2h9hUA/Aloreo
 sfYt3CjsoPjH0Y+LVokndAs+zFvgp7JhXyF1Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713411617; x=1714016417;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RM6VekCrvyB9+9WOu2BfNVyxt8A+BHewODY3bmig/bQ=;
 b=szZ3ZuzdBFuOsCrW1AakH3b9OYpWFSvrgdDho4AaB+Le6iD3YD5Gp0Lbybyqcjyivg
 xFSHvhITIEoNrgFwV2+od0AxSu/BWpJmYGQWfC7AFaiv7G/gRmXiGMiu995TpIC0VZSl
 xqZbV+Y6Ky46O4N3TGic3VlSQlTFF7QtCLv481bL8cRcE6mn4m9YQ8uquseBMA670lpf
 KXYWdzUOAVpuQeSxFVbHeKK4gM8Ue6tmUpljl+VucVVOcJTVlKSS/HT9rkBE0iipYzSk
 e/dsQkMo3hH4VU/YOls2we7ZJWbXUcqudj9iZgo/ezcGwNzHsjg4LV/UivaUK5Ixz5ZD
 gCvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNZOiDcHt2CVej9M6lYroyNjgxrtqVQYxSVnsFwYWgPE9DWrXAubX6JaaeWrHnKbp8qwV3T0V/8RNigAvB5VvPMkN3yw==
X-Gm-Message-State: AOJu0YzPN7OlNUSqF/o71Dd0rjNTiQCIyIBLUB7FNHAaJkAHl+wPe1n0
 VJS3awIPLETKIlXeYyw7B4gznNuTpdFnF6yztTBH/I+ACyw0sJZu1E0+9O7s2AI=
X-Google-Smtp-Source: AGHT+IHMsf+k9stHVbzXK5rJ1SzH9rGICZPFFb6ocCbXs9GVg02CYrFf4h3P80CrUt90GSNoXnJ6Mw==
X-Received: by 2002:a05:620a:4411:b0:78e:bb13:d7d8 with SMTP id
 v17-20020a05620a441100b0078ebb13d7d8mr1850936qkp.13.1713411617141; 
 Wed, 17 Apr 2024 20:40:17 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.73.35]) by smtp.gmail.com with ESMTPSA id
 du33-20020a05620a47e100b0078d68b23254sm259041qkb.107.2024.04.17.20.40.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Apr 2024 20:40:16 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Vignesh Raghavendra <vigneshr@ti.com>, Judith Mendez <jm@ti.com>
Cc: Andrew Davis <afd@ti.com>, u-boot@lists.denx.de, 
 Simon Glass <sjg@chromium.org>
In-Reply-To: <20240410182016.1117085-1-jm@ti.com>
References: <20240410182016.1117085-1-jm@ti.com>
Subject: Re: [PATCH] configs: am64x_evm_*_defconfig: Increase offsets for
 eMMC raw boot
Message-Id: <171341161613.1250683.7294417954566240898.b4-ty@konsulko.com>
Date: Wed, 17 Apr 2024 21:40:16 -0600
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

On Wed, 10 Apr 2024 13:20:16 -0500, Judith Mendez wrote:

> EMMC boot can fail due to the size of R5 SPL image growing beyond the
> 500KB of memory allocated in eMMC. Update offsets for eMMMC raw boot
> to load each binary from the correct address in eMMC according to the
> following eMMC layout:
> 
>             boot0/1 partition
>     0x0+----------------------------------+
>        |     tiboot3.bin (1 MB)           |
>   0x800+----------------------------------+
>        |       tispl.bin (2 MB)           |
> 0x1800+-----------------------------------+
>        |       u-boot.img (4 MB)          |
> 0x3800+-----------------------------------+
>        |      environment (128 KB)        |
> 0x3900+-----------------------------------+
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


