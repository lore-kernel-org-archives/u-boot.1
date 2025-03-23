Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32ACFC28B30
	for <u-boot@archiver.kernel.org>; Sun, 23 Mar 2025 12:24:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B701B82006;
	Sun, 23 Mar 2025 13:24:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Cc+IKVII";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3061582033; Sun, 23 Mar 2025 13:24:34 +0100 (CET)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31BB281F6B
 for <u-boot@lists.denx.de>; Sun, 23 Mar 2025 13:24:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jernej.skrabec@gmail.com
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43cf034d4abso38042275e9.3
 for <u-boot@lists.denx.de>; Sun, 23 Mar 2025 05:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742732672; x=1743337472; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7WKedpt+nbSJdiAUIIEItsLaY/TMOfqYHyNYzHlG8xw=;
 b=Cc+IKVIIC9uvRqm2GoZTR2Pe8rrvvgpk3mprepQuybf+lNjUn58hTZI70CthH1N6xD
 kv4+D8VeIni1/pHOveCezxrfr2anrxTlf38Qfh7WqxHfa8asVZpJIC+kQPsz0CWf822q
 iYmZWv/YG4FZsAo1p+yn1bM4ecFZUvJvdbjB5rEmWIfLAjblXbI9mRSHZj2x+kGBAZ1+
 AyM/lTvzOx+wCU/gC5DBGfjFw8KyQTLi+zoMsYM+bZpo7k90JqlyY7jNIHxPr2N8WZWP
 +R0j9KzfvPFzWdrOzwIXyzFYaPGkAFFoxVjczlhUZNFCCT/KasV3fP4jgbvdZZTQAVN8
 jQVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742732672; x=1743337472;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7WKedpt+nbSJdiAUIIEItsLaY/TMOfqYHyNYzHlG8xw=;
 b=cRaeVIrqS5DzQzzKj1Yr2lLQ0VfIDJA7ZT220KDlMi4tF55pgcmxNjYt3LwMr92C7p
 ueSMH6HsCajspv6qSUtfiW5c43gCFFKHvsQnqPsi7Q3Q0KZORRG6R08BqrcJkRS/AFIE
 FqzZYhzpm8MMjLp3EUMiultVXObCnHO+15tm9WQSr+SUjszb9eE37UawrrMTeVuSgkZq
 d2hxWgBDT6GGjubtB0eAiTwu2siddxrRY+tBtgASI14IYuKXEZHuLq6hwm3B8M+O2b5S
 evG55CbCJPyU7BD6TZWOOMvFL6KCAJP/nwAezMtO2oJbOkVi/7VO4e1xXfQ4yepXix/3
 f2qg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU7eFLg1ONyDDF+d6G8v5r6rVdqdx5N7xhDpadvIkmYXLjsVjTUawHBHJyIfhcpDv+hbwR22Nw=@lists.denx.de
X-Gm-Message-State: AOJu0Yyc8bUlTUE0CISCJxNwv+zC6c3rr1fx3MW3m2DL/BvHnTQefwuS
 oiLqggC+FL9TEe0jgM8mdePkVAzTTKfHt/CoBs322NxXCx5OdxAh
X-Gm-Gg: ASbGnctUYlmjO+vxL5f1pLle3gEMkwqWzfpiRpc3j52UiKGS8cicctr1swoH72q2EjU
 9QI71Sw4+/VBd4H3bqiHGmbwxhhtUWHhIpIpVKr8C4XPl/aJufRJsDyfq777nioK2NXidS/66RE
 YEVl1I8q52Lyn9qYIOvKxfmLExTVznTgP/DhHj3VbWgsBu1g37ji1B0ImWGOjVYGDt8xpfqtDlz
 Lb8ScJjqb3ITb3q1wHvJzV+5VkCF9S0Nk/NYQGHS95efd/zyEx0X76TozLHadEjEH83cc/pFL3b
 Ie7dI7m4Wu6yD183y93utV2SHbDPD/UH0cQ6PVZDaxZbX2JS2aCPYU78xodJbQKUQvthZPnGdKH
 eR0LI4IfkkaC/l+p5NiES
X-Google-Smtp-Source: AGHT+IHUeBCLlLJMZAjq3aT9ayZR4JRvWJHk95k8mdakfG6ANtmZvQ4VWGbUZQZ6UEoVwjXgloRp+w==
X-Received: by 2002:a5d:584b:0:b0:390:f9a5:bd79 with SMTP id
 ffacd0b85a97d-3997f90ab9emr8989878f8f.26.1742732671471; 
 Sun, 23 Mar 2025 05:24:31 -0700 (PDT)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net.
 [86.58.6.171]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9e65e0sm7774811f8f.61.2025.03.23.05.24.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Mar 2025 05:24:31 -0700 (PDT)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Tom Rini <trini@konsulko.com>, Andre Przywara <andre.przywara@arm.com>
Cc: Simon Glass <sjg@chromium.org>, Mikhail Kalashnikov <iuncuim@gmail.com>,
 u-boot@lists.denx.de, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 26/34] sunxi: update rmr_switch.S source code
Date: Sun, 23 Mar 2025 13:24:30 +0100
Message-ID: <9421768.CDJkKcVGEf@jernej-laptop>
In-Reply-To: <20250323113544.7933-27-andre.przywara@arm.com>
References: <20250323113544.7933-1-andre.przywara@arm.com>
 <20250323113544.7933-27-andre.przywara@arm.com>
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

Dne nedelja, 23. marec 2025 ob 12:35:36 Srednjeevropski standardni =C4=8Das=
 je Andre Przywara napisal(a):
> Because the Allwinner BootROM always runs in AArch32, even on ARMv8 SoCs,
> we need to switch to AArch64 first, but also need to save the CPU state,
> when we later may need to return to the BootROM, for continuing with the
> FEL USB protocol. This is done in 32-bit code, which we include into the
> AArch64 boot assembly file as a series of .word directives, containing
> the encoded AArch32 instructions. To be able to change and verify that
> code, we also kept an assembly file with the respective 32-bit code, but
> just for reference.
>=20
> As this code is never compiled or assembled - it's just for
> documentation - it became stale over time: we didn't really update this
> along with the changes we made to the boot code. In particular the FEL
> save code was completely missing.
>=20
> Update that 32-bit assembly file, to match the current version used in
> boot0.h, including the FEL save routine. Also update the build
> instructions in the comments, to give people an actual chance to
> assemble this code.
>=20
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


