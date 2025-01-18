Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6909C02185
	for <u-boot@archiver.kernel.org>; Sat, 18 Jan 2025 07:21:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3ED9A8063E;
	Sat, 18 Jan 2025 08:21:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="coRokQmh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 444708070C; Sat, 18 Jan 2025 08:21:36 +0100 (CET)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C58580312
 for <u-boot@lists.denx.de>; Sat, 18 Jan 2025 08:21:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jernej.skrabec@gmail.com
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-aa679ad4265so766091966b.0
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 23:21:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737184894; x=1737789694; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dOw3EjHeVdvVyFFnaXBnLqOVXi3XKNlO2cpC4OVs1PA=;
 b=coRokQmhjl/qPtBluF1zHa68YhI/vyy3HOoybgAyXd7yjD5Sn3Q5HLbkxQ0sWEQpcX
 Z6x7k0QcnJQJtAnb4ccV60+AeNzWtYTMrK7cyQNVl1L04eByqLjr/JB71cni9R5hY4yy
 zMGZ/j1VgcaZgLnShZLYRTZVqf88i7JEK0L74yC2ZyMeGq4AopZEzVWrzwKPTm8Ex4Z8
 b1mJZup8e9ot875jxqWu9j+W55lR59PglNBPgamY89DmtPcFzJCOAva2xfZW2ovb8t1b
 28ehoDket8yHqOkTfo66KwlU1lbDldx3oiDQKLec1EsUVweX7zsv/ovDlI5BF4leNloq
 AjcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737184894; x=1737789694;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dOw3EjHeVdvVyFFnaXBnLqOVXi3XKNlO2cpC4OVs1PA=;
 b=EnQ3Fjfv0J1POxfCvtOp3F9FZ+Lgo36NqfuIpbFSn6bvHnz/hqeRPLOJNravQhrCaC
 u0gaGVMA/6OKJU3HTWpDdMozzvivRfU14AM2UV7mjAqaEbmyBe9VVfwTEs+xQeYOjm16
 JW4wSd4IssQjpRaImb5n0v3OHgmtHzK1Q97JFWyadGR9iONATBVeh6Q42rfptaHDzXEl
 LPV03QA72MrWwML/w5Ph1R9TiuUluP5mtPHxWj74vAFy8W7QqBpi9ijymVZqo8cYNz10
 gc8onYWM02QX0Y3pS3BoxiH4WqgrCl3b1h3QtFd4sWTIcWReCvZEnlL7JTq2DEqcnn3k
 zBbQ==
X-Gm-Message-State: AOJu0YzB6bnEGjUrUOuPrbDmciC2S2Jkjt7yLM5NJCSF75LmEBFpCoa1
 ZQeEuzWAhFBc2xA1ErbNF5Ttc/kM8OoSV45kE7gBM8bk2QJ8pECHjS0m1Q==
X-Gm-Gg: ASbGnctpFAsC56Lrmw+lckc6iI+eDHQ2qGrnHDmSlvLJgR66Q+JG0NJN2qezsB98I0W
 cMvjL+d3OS/WkAHHUw5plJkVYdYC5t5XQSSZ+rNxQi8z+MdqhN7FkYPQgEe1YcosLco9V4XkpkS
 RFPpRtQEzLao/HL0UKcjv/Tx6cZZz0l3qhr1avL6GUwEztwDBg2Gq9IVY9P6SLy5HMcyAp7xGoV
 6LGV2K9q2Y9QaxM0MFKsAS0QrSQPJkQKCtfpUbBQRX3lQEhITBtUIUiYrEPZYyQVKsErpStvh+e
 n+DPYtpkeWA2SqE=
X-Google-Smtp-Source: AGHT+IFynQ2xDKfottgy4xeDwMKTu2nTX2pX5SOhP0DN69x7BrJDXGQPVgXPPBrMQNjY+9meDBPjvw==
X-Received: by 2002:a17:907:743:b0:aa6:75f4:20df with SMTP id
 a640c23a62f3a-ab36e241bc1mr804825266b.9.1737184893407; 
 Fri, 17 Jan 2025 23:21:33 -0800 (PST)
Received: from jernej-laptop.localnet ([188.159.248.16])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab3848b2047sm289390066b.0.2025.01.17.23.21.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 23:21:32 -0800 (PST)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: u-boot@lists.denx.de, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Andre Przywara <andre.przywara@arm.com>
Cc: Tom Rini <trini@konsulko.com>, Cody Eksal <masterr3c0rd@epochal.quest>,
 Simon Glass <sjg@chromium.org>, linux-sunxi@lists.linux.dev,
 Parthiban <parthiban@linumiz.com>
Subject: Re: [PATCH 2/8] sunxi: pmic_bus: support alternative I2C address
Date: Sat, 18 Jan 2025 08:21:31 +0100
Message-ID: <2352334.ElGaqSPkdT@jernej-laptop>
In-Reply-To: <20250117014537.22513-3-andre.przywara@arm.com>
References: <20250117014537.22513-1-andre.przywara@arm.com>
 <20250117014537.22513-3-andre.przywara@arm.com>
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

Dne petek, 17. januar 2025 ob 02:45:31 Srednjeevropski standardni =C4=8Das =
je Andre Przywara napisal(a):
> Some of the X-Power AXP PMICs can be ordered with an alternative I2C
> address, for instance an AXP717 could be shipped with address 0x34 or
> with address 0x35.
> The datasheets for the AXP717 and AXP803 list two possible addresses,
> and they are always consecutive. For DM (DT) based drivers this is no
> problem, but the Allwinner SPL code relies on a hardcoded address.
>=20
> Add a Kconfig variable that will add "1" to the existing address if it
> is set.
> This enables to use the AXP717 as used on boards with the new Allwinner
> A523 chip.
>=20
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

This works until some board vendor start mixing one or another address
PMIC. Note that BSP boot0 does address autodetection, so it's not entirely
out of the question. Anyway, let's hope we don't see anything like that.

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


