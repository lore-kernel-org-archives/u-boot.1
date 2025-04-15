Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64B9CC369AB
	for <u-boot@archiver.kernel.org>; Tue, 15 Apr 2025 17:09:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F3D8A82102;
	Tue, 15 Apr 2025 19:09:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bnKFp5ly";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 886498296B; Tue, 15 Apr 2025 19:09:46 +0200 (CEST)
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2024A820E8
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 19:09:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-601c469cce3so1650137eaf.2
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 10:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744736983; x=1745341783; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H2+R/nnrMnVA3HdEixhMlaZpuxEnWWHq4AdLCBqxhCQ=;
 b=bnKFp5lyXyEjVWSmnF/GXotnCTff67ktUfiCsoCnumtARpkG/Fm75osxbR9m7UcbbB
 o0FG6Zkkke9YpfXoW+C0rq7EEs4RpuR2ygHiKjNMx7AmRO2Q/BhqDnlENAlNMfoL4kyp
 XRDsmvwxWOUqgsxmnsHXnM55vbOw3827SAQFU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744736983; x=1745341783;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H2+R/nnrMnVA3HdEixhMlaZpuxEnWWHq4AdLCBqxhCQ=;
 b=fNLmq8g+19TOy3i0+0OdsSB++SIft7co1anE/4dsHFXolR11v9KzNfoPKjVPX+bRoH
 LZT3VZ7/AtiXYDSblK4QEGlR/Eu/0Rj8oLyvHU8sGy+5jpPxuvigxl9DsNiho9VuM2Yn
 Zi55MQ8y6Kn1Zz79prCIFhCutXEH6MdgbsqvgIRVYbRT26uGcx2RcO+Bz8j1mnzMutNs
 5UGcqTfqwcbETPDsLP/OemD/rbg7AlJ4+Ob9Nn25VkazzTm4S6iUKR4twBbJYkslA/XX
 yq7jUJpc7GWbqaKX4lXevi46ZiQv6vBWwWAKCwMlDXT+rYtEEwXa7zfczlNMTkzhHxTv
 c6KA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVaQvhyRXnPMw07hn+zOL4pNKhTOJtWTuoATSgU6KgJwm7g7rMUn21ljXVELI8XtIUbfghrhZo=@lists.denx.de
X-Gm-Message-State: AOJu0YwgcngwVWqCbOiJUWZfzClr25aUKvaVXQHfKAMkH1Xej6w6dTTj
 d5ZlH/Hz1BPHwyy+Ecv93k7poa+hVjq0mLIpUNn9jvjMskoD3cJoaGnRGqROlZk=
X-Gm-Gg: ASbGnct/2aDKQbuKS8WnZNwswNULyaf3qF5pZ/Xst53Yibga4jNs9h1mcgQki0S5/Lj
 qKzDDuAt3TBN1BfaDKaEG+HKYFrK2VFUT95hySeWZHfUZzZrfg83CVG46+tidkKmeufc2CAQAfU
 dNqZZwGHXteyNTWDQFfLnx34ZLsH+ZhySPMsehAvEzfPi45lSrwTum5xUbxSLpMzb+TWzYz1WD5
 0w9C5cC4QBAvjmddn/yr0MsVg0JsmaMAITs9nnTczptJSdLvitD1XmB6C0uoqgDUUwnuTDFyMFu
 /GGZ91BiNOgLq6zt3CjbfcqQovJMtnOL2DzQ5iOtvxa1/Fup0UsDktiKPgcXTQV27hRaUh1Yz07
 R
X-Google-Smtp-Source: AGHT+IEIBqxOjh4cj7MADPb/AyYGDrGwP+hnIs+maqfeogaO+WCgJYCwnKax22NX7TqONnLYdeWDaQ==
X-Received: by 2002:a05:6820:1606:b0:603:fd3b:aef6 with SMTP id
 006d021491bc7-6046f5cc933mr9154045eaf.8.1744736982681; 
 Tue, 15 Apr 2025 10:09:42 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6045f5bdbf0sm2474209eaf.40.2025.04.15.10.09.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 10:09:42 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Neha Malcom Francis <n-francis@ti.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Nishanth Menon <nm@ti.com>
Cc: Andrew Davis <afd@ti.com>, 
 Alexander Sverdlin <alexander.sverdlin@siemens.com>, 
 Manorit Chawdhry <m-chawdhry@ti.com>, Jonas Wood <jw@ti.com>, 
 praneeth@ti.com, u-kumar1@ti.com, u-boot@lists.denx.de, 
 Dhruva Gole <d-gole@ti.com>
In-Reply-To: <20250407121554.1010490-1-nm@ti.com>
References: <20250407121554.1010490-1-nm@ti.com>
Subject: Re: [PATCH V2] firmware: ti_sci: Scan all device instances when
 releasing exclusive devices
Message-Id: <174473698167.645182.3071033333400755833.b4-ty@konsulko.com>
Date: Tue, 15 Apr 2025 11:09:41 -0600
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

On Mon, 07 Apr 2025 07:15:54 -0500, Nishanth Menon wrote:

> When FIT image with multiple dtbs are involved for R5 boot process,
> R5 SPL starts off with the first instance of dtb to probe the
> eeprom, then once we have identified the type of board, invocation
> of setup_multi_dtb_fit will replace the gd->fdt_blob with the proper
> board dtb match. However, when we do this, two things happen:
> 
> a) Prior to the invocation of setup_multi_dtb_fit, as part of the eeprom
>    discovery process, i2c controller device is already probed and marked
>    as exclusive with the match of the very first tisci match (from the
>    original boot dtb). This list is stored in the info->dev_list of the
>    first probe.
> b) When the second dtb is loaded, tisci is probed again (since this is a
>    new node) and the new info->dev_list is empty.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] firmware: ti_sci: Scan all device instances when releasing exclusive devices
      commit: cce329426f61ad9c42775128d2c995ccd2ebdcfc
-- 
Tom


