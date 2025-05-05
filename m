Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D2FEC3ABB6
	for <u-boot@archiver.kernel.org>; Mon,  5 May 2025 12:37:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB1D18213D;
	Mon,  5 May 2025 14:37:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cPbnem2B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E55C581F7B; Mon,  5 May 2025 10:40:54 +0200 (CEST)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7587C80BAE
 for <u-boot@lists.denx.de>; Mon,  5 May 2025 10:40:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=brunosampaioleite@gmail.com
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-54e98f73850so4613966e87.1
 for <u-boot@lists.denx.de>; Mon, 05 May 2025 01:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746434452; x=1747039252; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xIrcZ8zeTUZ+h7AGVLuKxAogcONmEZuqFZTkIVVi8JU=;
 b=cPbnem2BRNfThoW3tscnKXuQaDxG+t+2AQ9bEvJI2gP5s/vKeKn9HYZjfhL0gXrBI9
 fsj851SPwr9gVWCscoF5ipsl6RKjJ91JkYDCo4YznUh94Iujk2HYWVPvZER+M9ZaWbEh
 fV8tOJsu8NjC4pC1e8R+I593uV94btl9Fbhbc+YzqBAK7f00fKrrnK3aEwXtvPvPLsrc
 lUhEWw1UruqH1Ls+LPKU0ys7qK62KKWcDPxY5fPwC8B00jp9YM9IqUeHff6qbnQ1ZXk1
 J0d3rQkTVUi/OVEr92a0rh3FNk35UcCSNxUqwcrLZ9bFlSldAHvbaWx4nAcnTQ72kiFV
 FOpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746434452; x=1747039252;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xIrcZ8zeTUZ+h7AGVLuKxAogcONmEZuqFZTkIVVi8JU=;
 b=sg0og3rZRzmBVvBU64pgJY0Xg+B/zSfnR0SKMR4vfPxmdpXvpJvjaVFuqAmU3K0pTZ
 5ggHb6Hrqadu5GP8O44hgS8qXhb5aPd+ivLv8kmxPjNN4wmL6+zgZTrQOeN5S1QLBpQK
 wkCpBUj4DQLgkb8hbySi78Cb02/E/l0m/ap0WktBEO2FXs9JP3k7LMc7AEfRuaESGTnr
 2yubqVP97VeEW1Cs+wER3VKNaG2aG7cG9YO5izk/WqbY9J76M0awE0xiLf/JroDIgbQ5
 V4cyErxn0pf2kk6x05GsnH0ptS9TOWBgWjC60XDq+2liT2LPZNopSP/qAVdCrPARFizG
 pZtg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtdAUBcRC4knsW1n3mXhU/Rk/Gwdp0H6Sm6qBwFe7CDd9ODIMS3664yXeo877+TPMuTvctw6g=@lists.denx.de
X-Gm-Message-State: AOJu0Yyf1oT15GYSiq5JFLJOtzUdUIECkTaz1lcye24hx25jC+YNAcwJ
 c7VEh/qqfk4DT8q0YxKwuVOEDt6aG1nYcSIpf8FoJmI6mBqjV0mS
X-Gm-Gg: ASbGncutyeJJiG1rPfXy0xQVefshINdpZBzjgt/jZYXQjvq327d9qCYc7Tx8o3oBcj7
 ELyzUzMi1dKK/+z2yf1xct1rt0rn0b5NrHTmpoPNqHIUIo9ZJ+R6hZYRz1OjPowlu/sVzLdZnL2
 ocarOGFoDcoXf4BwbgKLK3Z9CGoJahglezHcCp01mRJpLWx2oAXPH65z28xZxNUT2duQe2DWBlk
 Ephe3Dc1Y/Of6P4Weyid6XKh8igJGGQla+Cz/PKhmGVl4SN1KlxmSdhnCxd0hvmyfY1KzEXfM7J
 hn/7ARYXFy9Iu/LQnzvTVUOVNv92hyd/w9UVsUPXRGPPsYJTihi3jrQQgcfii8HGzFC/CN3XLA=
 =
X-Google-Smtp-Source: AGHT+IFtCBKgDa9jfup7r6YCzbq7OppUG+6jZhZPtYBXZH7GwpM0qdZ6wOErXcqaNpPMN+5NlpkPsQ==
X-Received: by 2002:a05:6512:39cf:b0:549:43f8:824 with SMTP id
 2adb3069b0e04-54fa141d476mr1313101e87.26.1746434451467; 
 Mon, 05 May 2025 01:40:51 -0700 (PDT)
Received: from brule-Precision-3590.prevas.se ([81.216.59.226])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-54ea938dbc6sm1670436e87.0.2025.05.05.01.40.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 01:40:50 -0700 (PDT)
From: Bruno Leite <brunosampaioleite@gmail.com>
To: trini@konsulko.com
Cc: brule@prevas.dk, brunosampaioleite@gmail.com, clast@prevas.dk,
 mbrugger@suse.com, pbrobinson@gmail.com, probinson@gmail.com,
 ravi@prevas.dk, u-boot@lists.denx.de
Subject: Re: [PATCH 0/2] Add rpi5 specific defconfig
Date: Mon,  5 May 2025 10:40:49 +0200
Message-ID: <20250505084049.1767884-1-brunosampaioleite@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250502144031.GT1261075@bill-the-cat>
References: <20250502144031.GT1261075@bill-the-cat>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 05 May 2025 14:37:34 +0200
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

> > From: Bruno Leite <brule@prevas.dk>
> > 
> > 
> > Currently rpi5 uses a generic rpi_arm64_defconfig file that builds rpi4
> > devicetree. Add a defconfig that is specific to the rpi5 building the
> > now available upstream dts for that board. The defconfig makes use of
> > defconfig including that is now available and only changes the DTS
> > related config.
> > 
> > It is also necessary to add a more specific u-boot.dtsi to rpi5, since
> > due to the ARCH_BCM283X config it will try to build the
> > bcm283x-u-boot.dtsi and break.
> 
> My question is, can we not adjust rpi_arm64_defconfig to be generic
> enough and not have a problem on Pi 5 due to the default device tree?

I'm not sure I quite understand the question, but in order to not build
bcm283x-u-boot.dtsi we would either need to:

1-) not set ARCH_BCM283X for rpi5
2-) provide a higher in hierarchy u-boot.dtsi file

The first one would require a rework of ARCH_BCM283X into some closer to
the machine config, but that would probably cause some duplication of
files and configs, as rpi5 shares lots of things from that ARCH with
other rpi machines. Maybe make bcm283x-u-boot.dtsi more machine-specific,
probably by duplicating the file to all the machines that need it (I think)?

The second option is what I proposed here. Maybe I'm missing some third option?

I believe it would be possible to make rpi_arm64_defconfig more generic by
removing configs such as DEVICE_TREE and ARCH_BCM283X from there, causing it
to be a "include-only file" of sorts that no machine should actually build and
boot, but that would not solve any of the issues that the rpi5 has, as it would
still need a defconfig of it's own defining both and the u-boot.dtsi in order to
not build bcm283x-u-boot.dtsi

------------

Regards,
Bruno
