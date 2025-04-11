Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0EA1C369A2
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 19:17:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B161D8423A;
	Fri, 11 Apr 2025 21:16:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="e1UKvvmX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5DC6884239; Fri, 11 Apr 2025 21:16:52 +0200 (CEST)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DEAD484233
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 21:16:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3ff0df81fdbso899704b6e.3
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 12:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744399007; x=1745003807; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NiWImqx90kWaAIW3GH92W+a3cirTq+jDtEJjv8XbrKU=;
 b=e1UKvvmXLmzl1ivVRDOQdU6WOgdxoJyB6R4p03cPnWUB+azxmiowZ6MFmdF8BYIan2
 3psRdWVLpfaSg0wvpwz87KLdABvGjSNN6HH83sWSjcCxII6o9aFLawMEDxAl+PEh14e1
 zUW1VPzJEq4FlVtbH+BDgt8beEJxEZwYgA/+k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744399007; x=1745003807;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NiWImqx90kWaAIW3GH92W+a3cirTq+jDtEJjv8XbrKU=;
 b=hOo3ZcyvVPk87nmJMLyIT320N7v7Ys1XDMHuxXB897Ov0JsoLat63NZsBLjYvKKNth
 qmIVC0BOj+czXUoKYG8PdWCrCXI2tFOrZ+aqSBaXZEo0oCMVESGkLZpnQ+nZFc8P+NBD
 B7j6IIUiOGtvBnHQNm6OSBjw+txFCwgoDOqheiNHC5gyQ2WqSnC5Su8MRi97zhpij1QN
 B2b69tPsJLfkZBknHx61S6QIVI+IzJKiy74fdXPWCIgSKnmwFbxg+/uPw2Y4oi4x7aUx
 ziKivJwVayDrE44fCNzGtc3dVBu4mZfNK9EOJFx8rGz1zvgv3LXuUTqXBRnyGL1eVB08
 fmRA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGSH7irYd7lMiYavBbRsq/crjZoK1XqjM4DUa6TOJk/gwkLjQTB+sOoWeUuHKEuXfqP0Qad2A=@lists.denx.de
X-Gm-Message-State: AOJu0YysL0XwveHTW0FMoNe17ZHPQ7cScXRwVftVnGRbmNx2dHviGKb8
 8HJVBQLJI2FOklUMy+hSnsOChzFL8E4RAxALOc2geHmfGknBIm5grzJeLLZXMvk=
X-Gm-Gg: ASbGncvlhjlWRdhXMSNkJkHJr2LUTAS3PJoUYjLCvlII8cwjD/NEiZZ28TMkoL1ClAn
 Dcki6lvuYpi4mLwnpn/BPZROYUrWwwIsL3a91lnIaZzIuyG/4nwmSkiiAZ4NMeI6ieKtqBADOV5
 St1klgZVcfvCZe6EVuT3G85xPJ++j0jzGX59P58d6vZOG/13pOdwJs65uubHt07Qgh7dxZ8bjoo
 2nWOTj2qq9ujUSBsjRYzId+jXFK2GiQ2tZlYBG7IlUhfessO27k4iZuZ79BjkR9TvyHVDBr6dXh
 eXIbVO7+D8/Ix5WFiUG4aJncdAa7Q1ZEGqKK/drYedy7jP43yHcJ3Ra3ySeWmGyZphuC8kWYVhC
 v
X-Google-Smtp-Source: AGHT+IFGrlePKHvlsfCCCP0ZoRdmdeb1BbKtaJGh3LfsCR4gdBoE0ibeYFVE0NaVJ6G7FOjlDJFfUQ==
X-Received: by 2002:a05:6808:1201:b0:3fa:8bfd:7747 with SMTP id
 5614622812f47-40085039d5cmr2467560b6e.13.1744399007648; 
 Fri, 11 Apr 2025 12:16:47 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-400762cc752sm1043970b6e.20.2025.04.11.12.16.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Apr 2025 12:16:46 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: w.egorov@phytec.de, u-boot@lists.denx.de, 
 Daniel Schultz <d.schultz@phytec.de>
Cc: B.Hahn@phytec.de, upstream@lists.phytec.de, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
In-Reply-To: <20250328055824.3849523-1-d.schultz@phytec.de>
References: <20250328055824.3849523-1-d.schultz@phytec.de>
Subject: Re: [PATCH 1/3] configs: phycore_am64x_a53_defconfig: Enable
 remoteproc cmd
Message-Id: <174439900647.3262324.7994448350592897481.b4-ty@konsulko.com>
Date: Fri, 11 Apr 2025 13:16:46 -0600
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

On Thu, 27 Mar 2025 22:58:22 -0700, Daniel Schultz wrote:

> This enables the 'rproc' command, allowing users to
> start, stop, and manage co-processors as well as load firmware
> images.
> 
> Useful for systems with auxiliary cores, such as M4 or R5 cores
> in the AM64x soc.
> 
> [...]

Applied to u-boot/master, thanks!

[1/3] configs: phycore_am64x_a53_defconfig: Enable remoteproc cmd
      commit: 0819316de97ed57cb094f2ac50a5b4ab138f6e7a
[2/3] configs: phycore_am62x_a53_defconfig: Enable remoteproc cmd
      commit: a8ec1f11322286263d24e7cf931728557ccbe4ea
[3/3] configs: phycore_am62x_a53_defconfig: Enable gpio
      commit: 6d4d4ee519f4dfc799c1851f13e8be0634ec7911
-- 
Tom


