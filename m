Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E291FE9A02C
	for <u-boot@archiver.kernel.org>; Thu, 19 Feb 2026 00:15:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB3B883A47;
	Thu, 19 Feb 2026 01:15:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="T8ClX04E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C52583AC5; Thu, 19 Feb 2026 01:15:31 +0100 (CET)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 332B683936
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 01:15:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-45f015a3259so139856b6e.2
 for <u-boot@lists.denx.de>; Wed, 18 Feb 2026 16:15:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1771460128; x=1772064928; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ZSM3xLgzzQrRV4hFpTymlt4fUpwKFlRI5MMsXAY+vfM=;
 b=T8ClX04ETxPeNPAynqwHRfmf/g/WhnMzb84LAZHyMhE1WNDUY7+y8zXgwblEuHbQTu
 P0SMM9tnZUA/bnZvgPxx4qAnZ9wO3tCGoAeAj5s7JHwVi9Ww7+BMhs+IuAWaWkw1quJN
 S0PXnrjUp0be72dFylACMnRilqx7nr2kMkUUY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771460128; x=1772064928;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ZSM3xLgzzQrRV4hFpTymlt4fUpwKFlRI5MMsXAY+vfM=;
 b=VqD4Qw+H214lP5mtP8P5rrrzqsIWBSio/rY/72L8h2OV2g7qPdjL05yQ7jqhK8Nkj6
 2KuwmJssSP8GDju0SuU8OHZizKaqZeE0La+goEZcMum2wEetNpYWmT338goYRxHNYtxl
 VJ8/UbWphf4pDzR9l64J64nHPf2z4V0JfW2y6EobvZkOb5jdhfQoBgTWJzY2VjpGl/zs
 APgv2JtxVEIvmmlnTJ0jQekYxBL5B6nYPEBA7rBHJ+I8cGUhGVBMig9jin4MUnRRviAK
 v51TuE4mA4Yq9uuPAChX/+VdCbQmYju/4K35dFIjBsApTufT1PiOgd6qqBh409uPwM2q
 Aw8A==
X-Gm-Message-State: AOJu0YzyrKpQIaWMB98dc+VpR3yEl8PD/zdLjwG+/7YSiIwGhHyRVbhd
 ziVPDuTdCkgySwI0dHWcI2oOUZHHGnwBBelPyiKdhcznkTounlr8cW+LEJiw9iWbZ1v5kQnApnO
 zmYlLKS8=
X-Gm-Gg: AZuq6aLfV934vkHIHJdkkGiePiW07AGa7B1X+fa8H6sAgaYV3Q1fe73g4daaFJVN7XK
 0/wzrbt63CSxMEPs8BSlDjaWfvu0P6NvEOeUCFQjC8PpA/ucQMgCvBD791yKsOtaMaQt/w1trSA
 AC6iePQOWjyGNirsFWFlVm9YlFwtEohuXIULzLLuinVFTkKeLYWzdke1+rmu+lEJ/aHrQwJcOo1
 ge4dZHRt9ark3rZ4CVliCzS3NbfZwLjrezLVgwp7w6/C9fazPxbS0csG/0MyQgGV+vUNDnYuwZ4
 d9DgE0ss9tp7Yias6J7JMH6XxioFbT5FhtDWMN7feoQ73uWxLaY4sxVF/bXOdHn1PPhv1Zx+Iby
 bqiTEj3X+S7I05+W5kYn1cB6/7kDVA7hoK7rbMeh52sRWoSK6B/VTpc/AZJFFdKCBF8P5Cvj5j5
 Owmg2V9CgMJD/YKFjysiE+GKxzzT96tb+9OVBCFxYUG0/bY/XKJadNTR8oxsDXVHqmdFE+NUWjw
 xZ6tE+asYYNhdsQ/oSFyeutYOevp3Z6iNRqnxeg0Zg6Tt4q2A==
X-Received: by 2002:a05:6808:344b:b0:450:760b:cc9e with SMTP id
 5614622812f47-463b3ef6d34mr8017524b6e.27.1771460127852; 
 Wed, 18 Feb 2026 16:15:27 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4636ae8f86fsm15345640b6e.3.2026.02.18.16.15.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 16:15:27 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, niko.mauno@vaisala.com
In-Reply-To: <cover.1770197302.git.niko.mauno@vaisala.com>
References: <cover.1770197302.git.niko.mauno@vaisala.com>
Subject: Re: [PATCH v2 0/3] bootcount: Small clean-up and fix, and dm_i2c
 single-word support
Message-Id: <177146012713.3704617.9897605345152272576.b4-ty@konsulko.com>
Date: Wed, 18 Feb 2026 18:15:27 -0600
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

On Wed, 04 Feb 2026 15:17:34 +0200, niko.mauno@vaisala.com wrote:

> From: Niko Mauno <niko.mauno@vaisala.com>
> 
> In this series, we first introduce a clean-up where we switch to use
> predefined bit masks instead of hard-coded values for count and magic
> halves in the single-word (32-bit) boot count scheme.
> 
> Then we fix a case of missing boot count value masking in single-word
> scenario in bootcount.c, which allowed clobbering of the magic half
> when storing the value. With this change the clobbering preventing
> behavior becomes consistent with existing single word bootcount storing
> implementations in bootcount_at91.c and bootcount_davinci.c.
> 
> [...]

Applied to u-boot/next, thanks!

[1/3] bootcount: Use predefined count/magic bit masks
      commit: 27e1924ffaa9361542d4cf75a9b73613fa45d007
[2/3] bootcount: Fix potential clobbering issue
      commit: 05b56599b5b13a504d8ed66db27a4446f8b9acc5
[3/3] bootcount: dm_i2c: Support also single word mode
      commit: f97642853cd379ef69d00bca6c3928bce226dc5e
-- 
Tom


