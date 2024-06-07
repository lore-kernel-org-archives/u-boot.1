Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7142C27C53
	for <u-boot@archiver.kernel.org>; Fri,  7 Jun 2024 22:04:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5BEE6884D5;
	Sat,  8 Jun 2024 00:03:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kANzxD7p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC45E884D7; Sat,  8 Jun 2024 00:03:47 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D45EB884C7
 for <u-boot@lists.denx.de>; Sat,  8 Jun 2024 00:03:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-6f9774a556cso776a34.0
 for <u-boot@lists.denx.de>; Fri, 07 Jun 2024 15:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1717797824; x=1718402624; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uDXzITJ8YcVetFMnkpY6TpTTKMBvYsEou2cTxEng9NI=;
 b=kANzxD7pjzxZ+X3/bwS/Ghk4aYEI0acFtPDx9NGozIa3oFfYBgq9Y6n6YfAeSMzWyl
 6IrYcMqK2XC87VHZa5yVD6aAcff7UD0T6/6ADktdhCmajVAsYKXFtrHKc0kbfvNjjCVn
 2N8SdnJcp5qN8xkGrjSNmRfGLhXDhkZgzlURA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717797824; x=1718402624;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uDXzITJ8YcVetFMnkpY6TpTTKMBvYsEou2cTxEng9NI=;
 b=IZMomnUN/RsBv9h10/W0Ts+TbJl1CzgmoNPr1E2IkORw2+ngKFUTFadWasZGA8bi/0
 QfZh5vybli522QEQZwT/L1FnFdPmCahGJtv6qv8jh8bHMGcGAr8rWMbCIYY4SiDwQMHE
 kSHD9WVquYWFrWKzdsMRQHpBDPG64xrFUGFPMCexZCOJL+joMNE+fQEx9Vvedux+T6+h
 L6UDO7bvKxGDgnCXvyOC6fraxwNI+CA0kQHSZYB3xWPizRaO1EG6UFr6xR8kAwQ0YO1+
 xnYfeq6cx4M7u2/mpygyIVAG3+v3GXLJ9AFSwSV0vtnskss/uKDj+36cbMK2O3M82arE
 t2pg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpGUm6y5KX/wwRqEivCP9hSGpDN/PGtRTmVzq8UmcbOi8mGhvmUDRt7iY25xpsAT9ezSwk3SIWVVMbvWiWgEdfUPOyTw==
X-Gm-Message-State: AOJu0Yz2HREc94saHZlRwWqPueovdh/JzgVw/TpQFhQDQYZRrXFt7BoY
 Zsad8OdQx7FtKe5w6by0lGYPIyQgyZJ54XuuMBRZIxhG+WtfyW9YzCpF6dXb/ZA=
X-Google-Smtp-Source: AGHT+IHPs6yjYsMiSQ4fQbES6GKB6gmLCGQakODNFMFLBrlzG7oz+xvMOnAvD3GhZkYt1BdM2zVNhw==
X-Received: by 2002:a05:6870:2312:b0:24f:d9de:3bed with SMTP id
 586e51a60fabf-25464624749mr4043248fac.41.1717797824473; 
 Fri, 07 Jun 2024 15:03:44 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-45.totalplay.net.
 [189.203.100.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-254951da4d4sm58415fac.47.2024.06.07.15.03.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jun 2024 15:03:44 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: nm@ti.com, Beleswar Padhi <b-padhi@ti.com>
Cc: m-chawdhry@ti.com, n-jain1@ti.com, mkorpershoek@baylibre.com, 
 rogerq@kernel.org, afd@ti.com, vigneshr@ti.com, kamlesh@ti.com, 
 clamor95@gmail.com, marcel.ziswiler@toradex.com, sjg@chromium.org, 
 u-boot@lists.denx.de, u-kumar1@ti.com, n-francis@ti.com
In-Reply-To: <20240522045331.503472-1-b-padhi@ti.com>
References: <20240522045331.503472-1-b-padhi@ti.com>
Subject: Re: [PATCH 0/2] Add remoteproc support for J784S4 SoCs
Message-Id: <171779782308.4156831.7279367437444498983.b4-ty@konsulko.com>
Date: Fri, 07 Jun 2024 16:03:43 -0600
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

On Wed, 22 May 2024 10:23:29 +0530, Beleswar Padhi wrote:

> This series adds remoteproc support for TI's J784S4 SoCs. The K3 J784S4
> SoCs have four dual-core R5F subsystems and four C71x DSP subsystems.
> Enable the remoteproc drivers in defconfig and set the rproc firmware
> names to add remoteproc support.
> 
> Note: No driver changes are required as J784S4 SoCs have the same data
> as J721S2 SoCs. Thus, utilize the existing compatible string for driver
> probe.
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


