Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EAE9CCD195
	for <u-boot@archiver.kernel.org>; Sat, 18 Oct 2025 14:07:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CEA283849;
	Sat, 18 Oct 2025 16:07:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KjAjvq86";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92D27837B6; Sat, 18 Oct 2025 16:07:31 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E68983768
 for <u-boot@lists.denx.de>; Sat, 18 Oct 2025 16:07:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7a8e7ece907so1974966a34.0
 for <u-boot@lists.denx.de>; Sat, 18 Oct 2025 07:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760796448; x=1761401248; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=c/uYkTbcXgRbyHgirV5NZ4ntNTufp70oHx+9pM511As=;
 b=KjAjvq86gPCO6t49SLpdEdFvTx7B6+axDbRYWJ7s8HlUEp6ge/IAfFaxbCV3H5DS76
 61agxfjIemI35EbPMn5LKuQSGA4Rpe/w96qEJZ5yLfVoGAXEJTUVK3TT0rdl+iExDgJB
 3T0IafvMr/yxQz4vH+350INanbp2w5ShoZem8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760796448; x=1761401248;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c/uYkTbcXgRbyHgirV5NZ4ntNTufp70oHx+9pM511As=;
 b=NP5QVo5gQaKvZhOwgLy+V0abSLaMdo9GBFxo0u3UlE6eKOIcA1LZGaX3ehAgMZojmz
 WRaZINP03T/CIIxMKYc992F4SiKuYQ5XYfVYsj16jvj09TfAqGz51/SnAHYPH7ddqBgz
 hOs08CgfONqgM3+jOdUjRIUbaPQWPKXroIKAEGE+4iHsWd/5hKJVLA7G/BRWT7rOQoR/
 PEeW0QpzxSrj8NnABlIBt9Zk3Fff+i2QnoAQ6xrxFTiV4dsGFK6HKZEByq+2XocZDpJO
 EaskCFc+c45ejT933H0ZnLYTzoP3qCU1Xvd7zd4wPbio7HN4SWXX3cUYEnnKy0gOsS4o
 wYPQ==
X-Gm-Message-State: AOJu0YyeZkVqdxMbvblqi0NhGwhWD6CObLbaYtc5Nj/vv8milEAIN37S
 39k77M6sqU02G1dIotU3aMrS/Yi3pK8qaVOL47p7i9i350RZoVbwbq2FXz7GSTPtUGU=
X-Gm-Gg: ASbGnctcxI5lsM9A7NfBAp/M7iVvo9iuEVkkBIS6hpRNHBYamdtIizi0fEglOWvwD5d
 cG4kFw/p/9CgbLImGknLaPIjq6/zyMB1Kkk8Y6sSAs3EbTMG87c2zv9kdKvhgYBGXTU945EezKH
 t1dYzKw3rZnz28tsjgvY24FKn9GVhTe481pXB/P8tIiqOgUG13/VDis1QJ7ICclWPdsKducsKl1
 dIdVfccQRexbmq4I03BwZRfzM6/y7BFC+vAZlsy3gEEg+PSsNBtHlfr+iP/Fu3AfYYwnMwW3PjL
 K7hKGJ/Inh5eCQ8AIAoxFkpBThi3KxxY0bmVXghRuwvFgTZd3J18MQ+n/u4hkZmAAp01yCGhAWx
 qX0N+MsqSYVJh7K2WViGvVe6lQ9VqtbRXRo0csWJEmivVz00xfXwCyZzioawNW/bUnaWgtw/QPu
 6NsXPAknc/wkdPHRJv8RrgyFCBFZVbzgIkJb+NZw==
X-Google-Smtp-Source: AGHT+IE4V6NNQ1Fy9jCMxA12PgJJSb1I2AZ4YutKS+7Vg6dOLIahJzwqAJIbOkgTMT1OxTi3pim4LA==
X-Received: by 2002:a05:6808:250c:b0:43f:77d6:aeb9 with SMTP id
 5614622812f47-443a30dd426mr2888536b6e.42.1760796448225; 
 Sat, 18 Oct 2025 07:07:28 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-651d3f2fa57sm618972eaf.14.2025.10.18.07.07.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Oct 2025 07:07:27 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, yegorslists@googlemail.com
In-Reply-To: <20251014091717.309468-1-yegorslists@googlemail.com>
References: <20251014091717.309468-1-yegorslists@googlemail.com>
Subject: Re: [PATCH] .gitignore: ignore more image files
Message-Id: <176079644692.1878470.3549809091226424403.b4-ty@konsulko.com>
Date: Sat, 18 Oct 2025 08:07:26 -0600
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

On Tue, 14 Oct 2025 11:17:17 +0200, yegorslists@googlemail.com wrote:

> This expression covers various images files like, for example:
> 
> mkimage-out.spl-stm32.mkimage
> mkimage.spl-stm32.mkimage
> 
> 

Applied to u-boot/master, thanks!

[1/1] .gitignore: ignore more image files
      commit: 5340dc6fe75b5ffde3afe91c01bd8551b3cb8182
-- 
Tom


