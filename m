Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FE17D1358B
	for <u-boot@archiver.kernel.org>; Sun, 27 Oct 2024 23:11:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DBD388EFB;
	Mon, 28 Oct 2024 00:11:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nRMCDyjj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D94988F0A; Mon, 28 Oct 2024 00:11:30 +0100 (CET)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 36C5C88EFB
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 00:11:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-6cbf347dc66so24826106d6.3
 for <u-boot@lists.denx.de>; Sun, 27 Oct 2024 16:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730070672; x=1730675472; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mXFvEVszwDosLsslW3pH0fEnaHHiqT7eAuGu5cTK46E=;
 b=nRMCDyjjMQOdekhikX2I05gYiqRfwAsQMiFZgF8PkR+aR9muyhNOVzVVEJFE1SfTCb
 ci7sUGeNza9gq5heHpFwQUH/oGJKLxYXZrMCgLN9+Msq1NN8smHH+ITj101A16AKwL+W
 seYJFRXULvNX3D9xJfA7DvVmGVaz/3hAJBkQI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730070672; x=1730675472;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mXFvEVszwDosLsslW3pH0fEnaHHiqT7eAuGu5cTK46E=;
 b=IBL+86ouCtUhpW/hgWCMkMRhS9VnVda3GECGjaT8eLkfkZMX/OOEWsBRIXFD6iHSx4
 WKIExVJO5keEXtyl7K33u1SCGqgwkV8LtQPHiMWA9qmXJImKwrLtQyx2EjhbBMVkpdgq
 3RnMqjprkHRcx+2IuJepOwm4x+OEEMtpYa5jXRjxNO346Lhj4M3Ao2+BGS2/7fwcNmih
 ezySKcMgZLuflKdNXZd0fvNLGCkOkeYnVJmjKzizJArQR4poNPE/CCst0POBMoayjXzd
 37UHANgCMmhr7dFy0gq4xqHMmTCJktdKzNDGyM7tZMIpKFgXXn+HBporJZDrkdZJgPbe
 QNOg==
X-Gm-Message-State: AOJu0YxwX4bID3CIJ4VgZJTWNc2ne0mKcr6tRmUSOvdgy737A8TsMo7Y
 dbniHc4ZpFoBHYkPbLQfJXbyGWxlf2EnmkF/qpr5ya20NQHgmPnyhos3wh7bkew=
X-Google-Smtp-Source: AGHT+IFT7iKyJWxon/gM+QF4kAHZ2VhF6kktHGmw5aOcB8VOMHXWPxYTT/55QjkoE/TOwoaM4W3H0Q==
X-Received: by 2002:a05:6214:398e:b0:6cb:faee:76bd with SMTP id
 6a1803df08f44-6d18583c4cfmr105167536d6.37.1730070672140; 
 Sun, 27 Oct 2024 16:11:12 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.104.2]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d17972f622sm27464976d6.9.2024.10.27.16.11.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Oct 2024 16:11:11 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Romain Naour <romain.naour@smile.fr>
In-Reply-To: <20241008075435.1572727-1-romain.naour@smile.fr>
References: <20241008075435.1572727-1-romain.naour@smile.fr>
Subject: Re: [PATCH 0/9] net: ksz9477: add support for KSZ GbE switches
 using SPI bus
Message-Id: <173007067048.2057421.2528163658496496788.b4-ty@konsulko.com>
Date: Sun, 27 Oct 2024 17:11:10 -0600
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

On Tue, 08 Oct 2024 09:54:23 +0200, Romain Naour wrote:

> We are using a custom board where an ethernet switch device KSZ9896 is
> available. This family of devices can use several types of serial bus
> as management interface: mdio, i2c or SPI. Due to board design
> constraints and because we initially planned to use this device only
> from Linux, the SPI bus was used.
> 
> Luckily we are using a recent enough u-boot release where KSZ9477
> driver is available... but only for the i2c interface. Indeed, unlike
> the kernel driver, the KSZ9477 driver doesn't use the regmap API to
> access the underlying bus since the regmap API is limited to direct
> memory access [1].
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


