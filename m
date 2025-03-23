Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D43AC28B30
	for <u-boot@archiver.kernel.org>; Sun, 23 Mar 2025 12:25:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1126B82051;
	Sun, 23 Mar 2025 13:25:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lznR8V4e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 51E6082051; Sun, 23 Mar 2025 13:25:18 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 54F0881D5D
 for <u-boot@lists.denx.de>; Sun, 23 Mar 2025 13:25:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jernej.skrabec@gmail.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43cfe574976so19502135e9.1
 for <u-boot@lists.denx.de>; Sun, 23 Mar 2025 05:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742732716; x=1743337516; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ee+sGWgGTK7JKIeN/br5tXXgdVIdA7ECbLey1lC1x3Y=;
 b=lznR8V4eaHTd/zzTWkWQ70F0GzkZpQ9zlkTXfoq3TTWPhpAugJJZIPrS2Lt8+3bpSB
 fGAaoGd9GFugw/hU5vWEIND90rX4OLhtjJNpMnTWmeIPuzaTJuLf3jrKUHnxbpr6QpW1
 TkmXmNhxqRvV6xKSkOSvBwJQAtYmPIOH0bSdzdcvZ3/7GB5RWmOWjuWDUIt3xoWlE4GG
 6LeVw9EXNZddbh3pDTUXf1URCSc7uMFMQVdO0H4LWrLcSxMeyl+vykNHw0lRoaJDzMZ8
 vluYlZllIjHV56p5lWqbt4KvUWYBL3FYhfKAE6waC9xjEfPDlb5XVUDxzPz/dGXVrX2x
 d3FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742732716; x=1743337516;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ee+sGWgGTK7JKIeN/br5tXXgdVIdA7ECbLey1lC1x3Y=;
 b=VPhuAmKGRXLPmCDZprLZ7QVVECLkwrunZn9rcvJw5ns1ovoUukXPinEFa5diq+eGsi
 s+xXnsPJmRDyASidkqhpmD9/zlmjCaO7gTqh48KchsnFaJHvIWa543SyZKeRwP1oBMlp
 pi22UKDrK7h7dA4dBU45VNZVMJbDvWs5GXZ8GXA4IRUVFXImCI0ILNr2OzC9pxVa8Omg
 n/eD3sxpg78fEq6gSkEzhem9syfmBKhxhjKqyRe+6UGUtr6Rx5HqEwEfncuQh7gjiWy4
 2aqwVQ5dOZooL+SLqrDQDl4JE5X+BZnNwVq/rLxXI46nndaW+jvycs73DLLWIR5IVkzG
 C7Xg==
X-Forwarded-Encrypted: i=1;
 AJvYcCULe2l87rqjnI9e/97693jH8sJDhtk3UBZzJdapLxMXG8JAKtPNiW/yr/y0i0f5bbEwld30nFA=@lists.denx.de
X-Gm-Message-State: AOJu0YznawniYQ3JKL72LcI4s1b0KSBPusXgi0XwZXFtkyKfN1/UqBLC
 zeQy6O2Gd2x50fPB+c3DJQM5tJLK5bn/bKaEaR6Ev5gc2X9vztic
X-Gm-Gg: ASbGnctrZS4Om/kCo0jhy2V8w5VtBfh8Qun3yKCMm1q5esWs6x7nT2SqR3iUxxgxzl1
 ORjeYJh0rZQXDM2Kwas9sgPkya893j2y0grXuoW0SjQ6b2HR6ngpGgIOldXZgEn/e2nTigdFIzk
 8z54PfnZodlBBLy10x+8OV/bCw1ydZ5xjiSNjpv3brfnBd4aOlAX2hKtk884EK5AU6RmhofnH2R
 /vfsgoZ2+KRk882anSpUolxVi1ZSK4MlOIUBMrm2A4MMmMqOGeddvefrHbLSSkyOhAHj8yYVelV
 j4ofw+xDqMZRw4cH6NAMws/0af4PY9Ncaf+4Asy5G6Um9kstpP9aJSn8Bmxw3Yyd3Y7Fp939gH7
 s+5URA7c2U6TL5xicKiDj
X-Google-Smtp-Source: AGHT+IE8uyJWuvj8ibJEaxSDHGEIIeq1BaxjiAW9tr5cjvFVuAror1tC1awnTH/fVMkGKUYtHSzqbQ==
X-Received: by 2002:a05:600c:4584:b0:43b:cc42:c54f with SMTP id
 5b1f17b1804b1-43d509f433amr82317005e9.14.1742732715641; 
 Sun, 23 Mar 2025 05:25:15 -0700 (PDT)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net.
 [86.58.6.171]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d43f3328bsm135495875e9.1.2025.03.23.05.25.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Mar 2025 05:25:15 -0700 (PDT)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Tom Rini <trini@konsulko.com>, Andre Przywara <andre.przywara@arm.com>
Cc: Simon Glass <sjg@chromium.org>, Mikhail Kalashnikov <iuncuim@gmail.com>,
 u-boot@lists.denx.de, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 27/34] sunxi: armv8: FEL: save and restore GICv3 registers
Date: Sun, 23 Mar 2025 13:25:14 +0100
Message-ID: <6031809.MhkbZ0Pkbq@jernej-laptop>
In-Reply-To: <20250323113544.7933-28-andre.przywara@arm.com>
References: <20250323113544.7933-1-andre.przywara@arm.com>
 <20250323113544.7933-28-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

Dne nedelja, 23. marec 2025 ob 12:35:37 Srednjeevropski standardni =C4=8Das=
 je Andre Przywara napisal(a):
> To be able to return to the BootROM FEL USB debug code, we must restore
> the core's state as accurately as possible after the SPL has been run.
> Since the BootROM runs in AArch32, but the SPL uses AArch64, this requires
> a core reset, which clears the core's state.
> So far we were saving and restoring the required registers like SCTLR
> and VBAR, but could ignore the interrupt controller's state (GICC), since
> that lives in MMIO registers, unaffected by a core reset.
> Newer Allwinner SoCs now feature a GICv3 interrupt controller, which keeps
> some GIC state in architected system registers, and those are cleared
> when we switch back to AArch32.
>=20
> To enable FEL operation on the Allwinner A523 SoC,
> Add AArch32 assembly code to save and restore the ICC_PMR and ICC_IGRPEN1
> system registers. The other GICv3 sysregs are either not relevant for the
> BROM operation, or haven't been changed from their reset defaults by the
> BROM anyway.
>=20
> This enables FEL operation on the Allwinner A523 family of SoCs.
>=20
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


