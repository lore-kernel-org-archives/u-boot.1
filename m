Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D00C6C54E65
	for <u-boot@archiver.kernel.org>; Thu, 22 May 2025 22:48:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D602B8310F;
	Fri, 23 May 2025 00:48:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hazl4ru4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B36148319C; Fri, 23 May 2025 00:48:35 +0200 (CEST)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9250C830EB
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 00:48:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-2cc89c59cc0so240890fac.0
 for <u-boot@lists.denx.de>; Thu, 22 May 2025 15:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1747954112; x=1748558912; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/ePLenvdE2qAta1P+cCdSSqrnKG1CpJQo5d++gjJhww=;
 b=hazl4ru4TNt0AdkKgh8jSTGxlOyhIT7mrsh1ozRRT2rLRBDSk2m30gIcegU5T6gxc8
 h14CJgofO10iazjHfIAjAsp4dRlF84HNiYfwifWb55ycK21TzmSPxKG65xlm5vCbmk4p
 n9vQrn/MHLtrGZAhOwrju4vVNeMbiv2Lf1tDU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747954112; x=1748558912;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/ePLenvdE2qAta1P+cCdSSqrnKG1CpJQo5d++gjJhww=;
 b=wOvDAYVPOiPJFc28li4ayGEq+0BBSIu/VHyw+jELqWyb8dsdCBasi83y5GfipuZFIu
 TLBHM87rHbblM+PSsJDQUaCoXDkG+SAe4nSnbsVFyIgAxmapIAJ4qWdPt4qKr/ZnC3dc
 +w2IR8I+jljh5RqPUKWc/eO4wlcc3ZD23AMZE6A8fTVRBLMJiWMkHBiMH4HvahK9yy/h
 8mzeMxZasy778cPfSp9F6d2GxxWgk0engTioC+ugOaR3o9UAdkCL3qggH4ImPDk8yzq/
 BnF1JkSkwWs6zTP0E4kbqFnioHXADk96DtTWNpz5m/F06VcZgXxDtXFVBk7Yle9xAG/e
 JqqQ==
X-Gm-Message-State: AOJu0Yyfya/hYQLrkpapYStoILd+Cmi61cvs61q2ak49WyCqiG4+3JwC
 E5l74Bn1YkVQ4TSW1RxUNA5lN2H6OxCG7a7ubD1KifFJ/HRJsXHcIHHJx3C+Vj58p0o=
X-Gm-Gg: ASbGncsgoUKVMSlCp0ew+G6cbGMDmecXQZ24yzDbH/CEAk5AsUocgA7qGcoWkJ4Edzv
 cleShIEYNlJLIxUG0bo454iSo4umqYARfrWg0ct63F/uZbhTh1x39aSOElipjpWhckUMoGEt9h4
 NzqcbD5KKqOkZyW4M2RQFYWMFw86RosusC1R5w774Qt2nVLU8CVZLZx3V2Fp5T2TegAMsbQuCUW
 B/bfBSnzKNJmOHjMmSqrsY7oig26NiWxvx6DP0X5WRBvKIuCBrtBG5JpHkNXv1h0JxV6gtVcc80
 wojo8N+G6vXbop/RUWbYxSdMygzbOL6BVTPt5OfikKxosoaiCeyIKnEb/bVNfwScciY22xITrp6
 XlvLD7IvJCp8=
X-Google-Smtp-Source: AGHT+IFMnbf69I+cIcCe/GkxYGKzrSAq5/4IECS7VVQqqNZo/ksRuSPYhmWCSkDcYw7JMXjaBS3bzQ==
X-Received: by 2002:a05:6870:dc4b:b0:2b8:608d:5dd1 with SMTP id
 586e51a60fabf-2e83e915d02mr1037637fac.18.1747954112246; 
 Thu, 22 May 2025 15:48:32 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2e3c060af78sm3258534fac.5.2025.05.22.15.48.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 May 2025 15:48:31 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, upstream@lists.phytec.de, 
 Wadim Egorov <w.egorov@phytec.de>
Cc: ggiordano@phytec.com, d.schultz@phytec.de, n-francis@ti.com, 
 nmorrisson@phytec.com
In-Reply-To: <20250508151548.162122-1-w.egorov@phytec.de>
References: <20250508151548.162122-1-w.egorov@phytec.de>
Subject: Re: [PATCH v2 1/7] board: phytec: phycore_am62x: Update
 environment for fitboot
Message-Id: <174795411057.2210140.15935064972993395044.b4-ty@konsulko.com>
Date: Thu, 22 May 2025 16:48:30 -0600
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

On Thu, 08 May 2025 17:15:42 +0200, Wadim Egorov wrote:

> Add fit_addr_r to the environment to allow us to boot from a FIT image.
> 
> 

Applied to u-boot/next, thanks!

[1/7] board: phytec: phycore_am62x: Update environment for fitboot
      commit: fdd2af2c13848dbec1210a3361c667476c328263
[2/7] board: phytec: phycore_am64x: Update environment for fitboot
      commit: 04c1a5b0d6029dd21f17fe649f9f11dd05f9e5b4
[3/7] board: phytec: phycore_am6xx: Set bootmeths & boot_targets environment
      commit: e423e35d0d0ee2871f87f5f00ecf80997feba7df
[4/7] configs: phycore_am6xx: Default BOOTCOMMAND to standard boot
      commit: 7fbadff8a7d62118896fe19881a9c744b9aa3a77
[5/7] board: phytec: common: k3: Update boot_targets at runtime
      commit: 5900a2db4b7688586dc4605f4bdccba16a2b103d
[6/7] board: phytec: common: k3: Factor out mac address setup
      commit: cd48860fec92b4373e2cf6c942df7b6290fb9acd
[7/7] configs: phycore_am6xx_a53_defconfig: Enable BOOTDEV_SPI_FLASH
      commit: 1385e4be42d913dea97fc4939c745a29f274766e
-- 
Tom


