Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7964606A324
	for <u-boot@archiver.kernel.org>; Sun,  1 Nov 2026 21:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=bUsjP0SG;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=i0D7N2Ne
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8509C405F1;
	Sun,  1 Nov 2026 21:05:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eb1enp57QWDz; Sun,  1 Nov 2026 21:05:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 76B21405DC
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793567140;
	b=BWuSgnGgYxZP3kRBQiqH07sXEwsJQ9jHNm2CdFkh2ysnLUuKCkY7unUpYlVOl3w4bt4N
	 QgwwVtKwPmFUbdXpvzByona0SIftro1ogAs97+bvffUIsj1VwvVj0KL2+DGBzqpleyHWW
	 yC5VeOx4mjtoJtjOrG052AHALNgzvCtcsLpolwPqtDW5V8pugwENkD9Ce4i67H8u5+R36
	 WrVn9IAgelxB6/J7SS6aOfJoakbTM0Y3/jgcwyDwgQeehC6rvQVsoAeOyP3DB02fnVRkW
	 3LSPtHEWMJEOCPmEAfqNQ6FQs4b8Q9vRqhaV52MrORBaVFMUuuc36ebhSigAfFTjZBg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793567140;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=04zKGySTpsJdL8EcXMvcqNDU1v7fNCU+wg8EicgpypM=;
	b=JTT+lGGNBNlKsZ1E5V8F1UHMLC8+lz9eFh0GJ2xq4thk1OsteHqiWjKdv04RAfg65sLp
	 BsH351EGMggVoX31JltgqLcpk4ZiyRyt0vGFN0u4n0e6RwLLD3UDIwBjrGaianurUrUrE
	 tOvSmr7Q3hZf3UCQOGm1lRdkqJ+FQL1sRvzXEz5eHSPMbSoeh25q9E79bJrfpSo+PyOrn
	 Ff+UbzRKJu0ovyzhshsE8P6oht0gQgfhYq0jrOd7kULr8GI7nmvP2YgippbjjJ75t1oj4
	 zuw9L2fDAofx5QBffebM4taPqLrASYohpfmG9o9NXaQZ1xOdj4mu7Anh4H7zf0wFcUQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793567140;
	bh=04zKGySTpsJdL8EcXMvcqNDU1v7fNCU+wg8EicgpypM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bUsjP0SGHkBBNJlGrOyvokdQQDgSSDwYfPB3K5XMS5iSpnpqGawsy040APBo1VRT/
	 pX2lQK3aQhpYCAoFEePnuDoShK+uP+HZkrTiCTRSXumj3hWUJq//V/NUv7SNDCvptm
	 u7XtlIEvWs4GZmJNW/pQIVKQAuuURu9cYE+pIaW2iy6gNQgayVRazsJ39AjjIxecu2
	 HHJn0LFV73st/tvcf+ZSyGpW5u2/iksele3Ea46kOUsQPIhv42HOfexzlTaXH3wt3+
	 w4rYt3KTu+k7gC44pMm6d120O+usx2fY0WFdzFbACq0T32eWmlJvsPTCmwTrIft4mQ
	 w1j47AGQiQhhA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 76B21405DC;
	Sun,  1 Nov 2026 21:05:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id F41B7435
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 21:05:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E62D280DB0
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 21:05:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pb8SD7-4BNhz for <u-boot@lists.u-boot-project.org>;
 Sun,  1 Nov 2026 21:05:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D0E8980DB2
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::22a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793567137;
 b=X/GLpfDN4uHUxB8ZnucTuBRmT+TRqlAtBZhX+1eI2jpydEYNp6zF+GOXh2Yn1mPTNi0I
 K2CtWgds9UzeaukDOiioW26kLfAxlr4jV09WZFHgyjHXts8efbjRntlMrEYeyjgC7qZT1
 bgN/+7Gk8gEf7FNPDKrA5HH2cHfHc9ZzKeKw4B3r291RDtYS0Rrvmkue+NhHb1srxRpPy
 cZTohyo9kf1d7MPlrL5JeEd4xUBnW2LZas2pHO7Cd6tUc7UTG+Lz+qKLouuz3ZaYIkHQc
 zQEPLKFYJQ1ttcQTd/MBptixy/nQFcEUomh1b29Ku/gBDKnQAH48JdeUCTu3K41ZF7w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793567137;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=04zKGySTpsJdL8EcXMvcqNDU1v7fNCU+wg8EicgpypM=;
 b=lOPVAYeQ+T1OIdxSl6OpR0YMU6WnaktBANPMZgpcw0aaAFU0dTqMQ4TBUVcDZuRVZvVM
 Ol9KXc2NDEE4Xu+pYCKPZrubD6CtsEaiq8q0fxunUbXOW3gUJZGyrLKFG4WBF5JGRG66E
 xxJDTA9Ves5+sWCyBy/fgQb06u+he7zscBC1JvDr/uUoinpJDGfujsFZfRiv/0O7yCGHQ
 prZIt7Q4RrBhO37jiZ0yDwE2GU3TthYeSDIGfPfAv+XRGAYiG+pAoc+R6LskZtX3aNOLa
 ydrUxEGvFUiAb4EJh81yU56fYnriRo7pmXZ7J4rLnoT3ZiadFrlksJDz3hzD51Jgbow==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=i0D7N2Ne; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::22a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::22a; helo=mail-lj1-x22a.google.com;
 envelope-from=indrek.kruusa@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=i0D7N2Ne
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com
 [IPv6:2a00:1450:4864:20::22a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D0E8980DB2
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 21:05:36 +0000 (UTC)
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-3ac99992373so18429431fa.3
 for <u-boot@lists.u-boot-project.org>; Sun, 01 Nov 2026 13:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793567134; x=1794171934;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=04zKGySTpsJdL8EcXMvcqNDU1v7fNCU+wg8EicgpypM=;
 b=i0D7N2Nedq45SrSVnMRTPgLJgkwWK01ANan5dqw8pSvLawN8yREaxN1iksoWKhhFRW
 MS5VNHLyJB81hIXVD7yLPvWXbi4K8vMTFwI4h2yblbgeZLRp6d4gjcItcycovqnQw1D1
 MCyC4DNSPqqMAr5VC1ar3MswYJ47ALivt2J/VIjTwfKSu3ghm43L3tS1ACJczcWrOaXP
 +ziC06POXQnfViM8j0O/44LgLopREy0T26FZEXzWTiEDgakHgw3ofGlwcNLGbF2PX4+5
 LuPZjiqwuOSbEPgKvSou4BHhTR//9CIafmqHxKzjtYFJ0X/DZicb8GYuZ4wXHuBKybJE
 rjjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793567134; x=1794171934;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=04zKGySTpsJdL8EcXMvcqNDU1v7fNCU+wg8EicgpypM=;
 b=Crf6MpA3dZqHrC0Fglm9ndaKicaF1k2msig/PtlGe4l2mAmVh5gEpH60WxoH72ZSS/
 CDhyntnrdCR8zH2OnF4bAYtwp5DJ9NaIpRt6EtPAKNjx2r2fBHIUTXEdfS5BVBI4EXcX
 xGLqpb6Vq7TZy+10HWtUY4GDMXGJzMJbvADTPbew5p+YVFr6n0HgKxUb3yy5Rq5TZreL
 DPw4nTjciFVzblJNXmkSMw/1X+MYcl8tbpMX1lQhzY9R/zQ90z3UfYg+R5s0od0P3gc6
 f/WSPbiTqF6HS1v7zWcdffxTTHbcl1rmiF7yOZyrq+lo2jGfU24pzzQc7QN2gID8ashu
 KLHA==
X-Gm-Message-State: APuU4Z/ISUMxzIiuC4C/aVaqs72s+xpBlMkQccHFG99e8pLpU21SI1bZ
 S1X78r+Qozr9p731e9Q3q0H3GWpechGOvSv6V2u8ZeFZaLJ5zlfkWtIosH9425HA
X-Gm-Gg: AYBFou0uORl1jKr7Pey6GJnzkdhg1cQ8rUR50mGpugj2dCKRG0V5MDSHaW43EpD21Mn
 evkihd/sID6mlzyfLU24L9LlmeUUhr3aiSckM3YW+bDISKKyKirDja2GGJJnAXr+VG7DxfA8NV4
 +VT3P1PGEi8rlZoX+oBGIKmQRIWWoMkNtu9uSvLqmuUDACqQTd8wS2ni4PPU/o3/csnwwB1Sz6S
 5R2eiEe+4nBhCP0xFIjOtnh/dWzFsvstrLmwPPhp/Pe3qhzSe789fFiFw7FL1Ps50o21ghZmsX7
 Tf2xhYIhL7Q8+yJxB02Q/JaM560wea1iV62ims0lwEtpIUa65THYTq9HCeJeUHkQGRruVY7GmwS
 lWRhFrLOeytwlhtIFG85qmWVfuZriaWOiJF6Iw/kb52zxKUEijLb+HthqoqQwVeXT+hY4Itl70u
 qgL/6b4HkV3cZ5tUMjSbiajp6pgex8BPIHHkVQwKEczh2pDJjVlk2AJb7ZTo/HPupac/qqUntyv
 6xY/gYOJjsnL2Rdi0v8YFrS0SprPHNkV+/oxao2ku9fnXIdwCn7XuHMawcHeO1Ay2KXkc2klooj
 WeB/ufgMRdi6PoE49i3FYp2Xlm89VqNA3Tg98DJBtMYB6bFHPRnpj6HfTto4s3LrB/c/ugJdY+9
 hLwCc90HdjhYD
X-Received: by 2002:a05:651c:43c7:20b0:3ac:d178:4f97 with SMTP id
 38308e7fff4ca-3acd178522dmr7641fa.14.1793567133579; 
 Sun, 01 Nov 2026 13:05:33 -0800 (PST)
Received: from ik5070.localdomain (82-131-69-225.ip.elisa.ee. [82.131.69.225])
 by smtp.googlemail.com with ESMTPSA id
 38308e7fff4ca-3acbbee0094sm19882441fa.20.2026.11.01.13.05.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 13:05:31 -0800 (PST)
From: Indrek Kruusa <indrek.kruusa@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Andre Przywara <andre.przywara@arm.com>, Tim Ouyang <tim609@andestech.com>,
 Leo Liang <leo.liang@sifive.com>, Yao Zi <me@ziyao.cc>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Lukasz Majewski <lukma@nabladev.com>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Samuel Holland <samuel@sholland.org>, Tom Rini <trini@konsulko.com>,
 Indrek Kruusa <indrek.kruusa@gmail.com>
Subject: [PATCH 03/10] board: sun20i: add common support for the D1/D1s boards
Date: Sun,  1 Nov 2026 23:04:42 +0200
Message-ID: <20261101210449.1235102-4-indrek.kruusa@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261101210449.1235102-1-indrek.kruusa@gmail.com>
References: <20261101210449.1235102-1-indrek.kruusa@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add the board code used by all D1/D1s(F133) boards:

- TARGET_SUN20I, board init and CPU probing
- sunxi eGON/TOC0 SPL header: boot source, FEL mode, SPL size
- SPL DRAM probing and the /memory fixup
- FIT DT name matching
- environment placement for MMC/SPI boot media
- the u-boot-sunxi-with-spl.bin image
- a MAINTAINERS section for the new board and CPU files

CONFIG_ARCH_SUNXI is never set on these RISC-V parts, so extend the SPL
image rule in scripts/Makefile.xpl to match TARGET_SUN20I as well.

The board code, the devicetree overlay and include/configs/sun20i.h come
from Samuel Holland's d1-wip tree [1]. The board code in turn derives from
the ARM sunxi board code, so its copyright notices are kept.

[1] https://github.com/smaeul/u-boot/tree/d1-wip

Signed-off-by: Indrek Kruusa <indrek.kruusa@gmail.com>
---
 MAINTAINERS                       |   8 +
 arch/riscv/Kconfig                |  13 ++
 arch/riscv/dts/sun20i-u-boot.dtsi |  86 +++++++++
 board/sun20i/Kconfig              | 173 +++++++++++++++++
 board/sun20i/Makefile             |   4 +
 board/sun20i/board.c              | 309 ++++++++++++++++++++++++++++++
 board/sun20i/spl.c                | 142 ++++++++++++++
 include/configs/sun20i.h          |  11 ++
 scripts/Makefile.xpl              |   2 +-
 9 files changed, 747 insertions(+), 1 deletion(-)
 create mode 100644 arch/riscv/dts/sun20i-u-boot.dtsi
 create mode 100644 board/sun20i/Kconfig
 create mode 100644 board/sun20i/Makefile
 create mode 100644 board/sun20i/board.c
 create mode 100644 board/sun20i/spl.c
 create mode 100644 include/configs/sun20i.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 95b1f3b5ab3..587d4a30377 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1543,6 +1543,14 @@ F:	drivers/net/dwmac_thead.c
 F:	drivers/pinctrl/pinctrl-th1520.c
 F:	drivers/ram/thead/th1520_ddr.c
 
+RISC-V ALLWINNER SUN20I (D1)
+M:	Indrek Kruusa <indrek.kruusa@gmail.com>
+S:	Maintained
+F:	arch/riscv/cpu/sun20i/
+F:	arch/riscv/include/asm/arch-sun20i/
+F:	board/sun20i/
+F:	include/configs/sun20i.h
+
 RNG
 M:	Sughosh Ganu <sughosh.ganu@arm.com>
 R:	Heinrich Schuchardt <xypron.glpk@gmx.de>
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 14c8ca817fb..02304d9f66c 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -60,6 +60,18 @@ config TARGET_STARFIVE_VISIONFIVE2
 	bool "Support StarFive VisionFive2 Board"
 	select BOARD_LATE_INIT
 
+config TARGET_SUN20I
+	bool "Support Allwinner D1/D1s(F133) boards"
+	select GENERIC_RISCV
+	select SPECIFY_CONSOLE_INDEX
+	select SUN20I
+	select PINCTRL_SUN20I_D1
+	select CLK_SUN20I_D1
+	select SUNXI_NEW_PINCTRL
+	help
+	  Selecting this option also enables the NCAT2 drivers, which are
+	  shared across several Allwinner RISC-V and ARM SoCs.
+
 config TARGET_TH1520_LPI4A
 	bool "Support Sipeed's TH1520 Lichee PI 4A Board"
 	select SYS_CACHE_SHIFT_6
@@ -129,6 +141,7 @@ source "board/sophgo/licheerv_nano/Kconfig"
 source "board/spacemit/k1/Kconfig"
 source "board/spacemit/k3/Kconfig"
 source "board/starfive/visionfive2/Kconfig"
+source "board/sun20i/Kconfig"
 source "board/thead/th1520_lpi4a/Kconfig"
 source "board/xilinx/mbv/Kconfig"
 
diff --git a/arch/riscv/dts/sun20i-u-boot.dtsi b/arch/riscv/dts/sun20i-u-boot.dtsi
new file mode 100644
index 00000000000..8f9959e6467
--- /dev/null
+++ b/arch/riscv/dts/sun20i-u-boot.dtsi
@@ -0,0 +1,86 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+#include "binman.dtsi"
+
+/ {
+	cpus {
+		bootph-all;
+	};
+
+	soc {
+		bootph-all;
+	};
+};
+
+&binman {
+	/*
+	 * "u-boot-sunxi-with-spl" is the shared Allwinner sunxi boot image
+	 * (eGON SPL + U-Boot FIT). It is common to the ARM sunxi and the
+	 * RISC-V sun20i SoCs, so it keeps the "sunxi" name even on RISC-V.
+	 */
+	u-boot-sunxi-with-spl {
+		filename = "u-boot-sunxi-with-spl.bin";
+		pad-byte = <0xff>;
+
+		blob@0 {
+			/*
+			 * This value matches SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR
+			 * and SYS_SPI_U_BOOT_OFFS if those are defined.
+			 */
+			min-size = <0x8000>;
+			filename = "spl/sunxi-spl.bin";
+		};
+
+		blob@1 {
+			filename = "u-boot.itb";
+		};
+	};
+};
+
+&ccu {
+	bootph-all;
+};
+
+&cpu0 {
+	bootph-all;
+};
+
+&dcxo {
+	bootph-all;
+};
+
+&mbus {
+	bootph-all;
+};
+
+&mmc0 {
+	bootph-all;
+};
+
+&mmc0_pins {
+	bootph-all;
+};
+
+&pio {
+	bootph-all;
+
+	uart0-pb8-pins {
+		bootph-all;
+	};
+
+	uart3-pb-pins {
+		bootph-all;
+	};
+};
+
+&rtc {
+	bootph-all;
+};
+
+&uart0 {
+	bootph-all;
+};
+
+&uart3 {
+	bootph-all;
+};
diff --git a/board/sun20i/Kconfig b/board/sun20i/Kconfig
new file mode 100644
index 00000000000..55eb50abf34
--- /dev/null
+++ b/board/sun20i/Kconfig
@@ -0,0 +1,173 @@
+# SPDX-License-Identifier: GPL-2.0+
+
+if TARGET_SUN20I
+
+config SYS_BOARD
+	default "sun20i"
+
+config SYS_CPU
+	default "sun20i"
+
+config SYS_SOC
+	default "sun20i"
+
+config SYS_CONFIG_NAME
+	default "sun20i"
+
+config IDENT_STRING
+	default " Allwinner D1"
+
+config SYS_CLK_FREQ
+	default 1008000000
+
+config SYS_LOAD_ADDR
+	default 0x42000000
+
+config TEXT_BASE
+	default 0x42e00000
+
+config HAS_CUSTOM_SYS_INIT_SP_ADDR
+	default y
+
+config CUSTOM_SYS_INIT_SP_ADDR
+	default 0x43e00000
+
+config SUNXI_SRAM_ADDRESS
+	hex
+	default 0x20000
+
+config SUNXI_MINIMUM_DRAM_MB
+	int
+	default 64
+	help
+	  Minimum DRAM size expected on the board.
+
+config DRAM_CLK
+	int "DRAM clock speed"
+	default 792
+
+config DRAM_ZQ
+	int "DRAM ZQ value"
+	default 8092667
+
+config PRE_CON_BUF_ADDR
+	default 0x43000000
+
+config MISC_INIT_R
+	default y
+
+config SPL_MAX_SIZE
+	default 0x27fa0
+
+config SPL_PAD_TO
+	default 0x0
+
+config SPL_BSS_START_ADDR
+	default 0x43f80000
+
+config SPL_TEXT_BASE
+	default 0x20060
+
+config SPL_SHARES_INIT_SP_ADDR
+	default n
+
+config SPL_HAVE_INIT_STACK
+	default y
+
+config SPL_STACK
+	default 0x48000
+
+config SPL_STACK_R_ADDR
+	default 0x43e00000
+
+config SPL_OPENSBI_LOAD_ADDR
+	default 0x40000000
+
+config SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR
+	default 0x40
+
+config SPL_SYS_MMCSD_RAW_MODE
+	default y
+
+config SYS_MMCSD_RAW_MODE_U_BOOT_DATA_PART_OFFSET
+	default 0x10
+
+config SYS_SPI_U_BOOT_OFFS
+	default 0x8000
+
+config MMC_SUNXI_SLOT_EXTRA
+	int "mmc extra slot number"
+	default -1
+	help
+	  D1 builds always enable mmc0. Some boards also have a second SD card
+	  slot or eMMC on mmc1 - mmc3. Setting this to 1, 2, or 3 enables
+	  support for this.
+
+config SPL_IMAGE_TYPE
+	string
+	default "sunxi_egon"
+
+config BOARD_SPECIFIC_OPTIONS
+	def_bool y
+	select BINMAN
+	select CLK
+	select CMD_GPIO if GPIO
+	select CMD_MMC if MMC
+	select CMD_USB if DISTRO_DEFAULTS && USB_HOST
+	select DM
+	select DM_GPIO if GPIO
+	select DM_I2C if I2C
+	select DM_MMC if MMC
+	select DM_SERIAL if SERIAL
+	select DM_SPI if SPI
+	select DM_SPI_FLASH if SPI && MTD
+	select ENV_RELOC_GD_ENV_ADDR
+	select OF_BOARD_SETUP
+	select OF_UPSTREAM
+	select PINCTRL
+	select RAM if SPL_DM
+	select SPL_CLK if SPL_DM
+	select SPL_DM if SPL
+	select SPL_DM_SPI if SPL_DM && SPL_SPI
+	select SPL_DM_SPI_FLASH if SPL_DM && SPL_SPI
+	select SPL_OF_CONTROL if SPL_DM
+	select SPL_PINCONF if SPL_DM
+	select SPL_PINCTRL if SPL_DM
+	select SPL_RAM if SPL_DM
+	select SPL_SEPARATE_BSS if SPL
+	select SUNXI_GPIO if GPIO
+	select SUPPORT_SPL
+	select SYS_NS16550 if SERIAL
+	select USB if DISTRO_DEFAULTS
+	select USB_KEYBOARD if DISTRO_DEFAULTS && USB_HOST
+	select USB_STORAGE if DISTRO_DEFAULTS && USB_HOST
+	select USE_PREBOOT
+	imply CMD_DM
+	imply CMD_GPT
+	imply DISTRO_DEFAULTS
+	imply DM_REGULATOR
+	imply DM_REGULATOR_FIXED
+	imply FAT_WRITE
+	imply FIT
+	imply MMC
+	imply OF_LIBFDT_OVERLAY
+	imply PRE_CONSOLE_BUFFER
+	imply SPL
+	imply SPL_GPIO
+	imply SPL_LIBCOMMON_SUPPORT
+	imply SPL_LIBGENERIC_SUPPORT
+	imply SPL_LOAD_FIT
+	imply SPL_MMC if MMC
+	imply SPL_POWER
+	imply SPL_SERIAL
+	imply SYSRESET
+	imply SYSRESET_SBI
+	imply SYSRESET_WATCHDOG
+	imply SYSRESET_WATCHDOG_AUTO
+	imply USB_EHCI_GENERIC
+	imply USB_EHCI_HCD
+	imply USB_OHCI_GENERIC
+	imply USB_OHCI_HCD
+	imply WDT
+
+endif
diff --git a/board/sun20i/Makefile b/board/sun20i/Makefile
new file mode 100644
index 00000000000..af4006368b2
--- /dev/null
+++ b/board/sun20i/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0+
+
+obj-y	+= board.o
+obj-$(CONFIG_SPL_BUILD) += spl.o
diff --git a/board/sun20i/board.c b/board/sun20i/board.c
new file mode 100644
index 00000000000..e32cc817838
--- /dev/null
+++ b/board/sun20i/board.c
@@ -0,0 +1,309 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * (C) Copyright 2012-2013 Henrik Nordstrom <henrik@henriknordstrom.net>
+ * (C) Copyright 2013 Luke Kenneth Casson Leighton <lkcl@lkcl.net>
+ *
+ * (C) Copyright 2007-2011
+ * Allwinner Technology Co., Ltd. <www.allwinnertech.com>
+ * Tom Cubie <tangliang@allwinnertech.com>
+ *
+ * (C) Copyright 2026 Indrek Kruusa <indrek.kruusa@gmail.com>
+ *
+ * Board initialization, environment and boot source detection for
+ * Allwinner D1(s) RISC-V SoC.
+ */
+
+#include <asm/csr.h>
+#include <asm/global_data.h>
+#include <asm/io.h>
+#include <asm/arch/thead_csr.h>
+#include <cpu.h>
+#include <dm.h>
+#include <env.h>
+#include <env_internal.h>
+#include <fdt_support.h>
+#include <init.h>
+#include <spl.h>
+#include <sunxi_image.h>
+
+int board_init(void)
+{
+	/* https://lore.kernel.org/u-boot/31587574-4cd1-02da-9761-0134ac82b94b@sholland.org/ */
+	return cpu_probe_all();
+}
+
+#define SPL_ADDR		CONFIG_SUNXI_SRAM_ADDRESS
+
+/* The low 8-bits of the 'boot_media' field in the SPL header */
+#define SUNXI_BOOTED_FROM_MMC0	0
+#define SUNXI_BOOTED_FROM_MMC2	2
+#define SUNXI_BOOTED_FROM_SPI	3
+#define SUNXI_BOOTED_FROM_MMC0_HIGH	0x10
+#define SUNXI_BOOTED_FROM_MMC2_HIGH	0x12
+
+#define SUNXI_INVALID_BOOT_SOURCE	-1
+
+static int sunxi_egon_valid(struct boot_file_head *egon_head)
+{
+	return !memcmp(egon_head->magic, BOOT0_MAGIC, 8); /* eGON.BT0 */
+}
+
+static int sunxi_toc0_valid(struct toc0_main_info *toc0_info)
+{
+	return !memcmp(toc0_info->name, TOC0_MAIN_INFO_NAME, 8); /* TOC0.GLH */
+}
+
+static int sunxi_get_boot_source(void)
+{
+	struct boot_file_head *egon_head = (void *)SPL_ADDR;
+	struct toc0_main_info *toc0_info = (void *)SPL_ADDR;
+
+	if (sunxi_egon_valid(egon_head))
+		return readb(&egon_head->boot_media);
+	if (sunxi_toc0_valid(toc0_info))
+		return readb(&toc0_info->platform[0]);
+
+	/* Not a valid image, so we must have been booted via FEL. */
+	return SUNXI_INVALID_BOOT_SOURCE;
+}
+
+/* The sunxi internal BROM will try to load an external bootloader
+ * from mmc0, mmc2, or SPI flash.
+ */
+uint32_t sunxi_get_boot_device(void)
+{
+	int boot_source = sunxi_get_boot_source();
+
+	/*
+	 * When booting from the SD card or NAND memory, the "eGON.BT0"
+	 * signature is expected to be found in memory at the address 0x0004
+	 * (see the "mksunxiboot" tool, which generates this header).
+	 *
+	 * When booting in the FEL mode over USB, this signature is patched in
+	 * memory and replaced with something else by the 'fel' tool. This other
+	 * signature is selected in such a way, that it can't be present in a
+	 * valid bootable SD card image (because the BROM would refuse to
+	 * execute the SPL in this case).
+	 *
+	 * This checks for the signature and if it is not found returns to
+	 * the FEL code in the BROM to wait and receive the main u-boot
+	 * binary over USB. If it is found, it determines where SPL was
+	 * read from.
+	 */
+	switch (boot_source) {
+	case SUNXI_INVALID_BOOT_SOURCE:
+		return BOOT_DEVICE_BOARD;
+	case SUNXI_BOOTED_FROM_MMC0:
+	case SUNXI_BOOTED_FROM_MMC0_HIGH:
+		return BOOT_DEVICE_MMC1;
+	case SUNXI_BOOTED_FROM_MMC2:
+	case SUNXI_BOOTED_FROM_MMC2_HIGH:
+		return BOOT_DEVICE_MMC2;
+	case SUNXI_BOOTED_FROM_SPI:
+		return BOOT_DEVICE_SPI;
+	}
+
+	panic("Unknown boot source %d\n", boot_source);
+	return -1;		/* Never reached */
+}
+
+uint32_t sunxi_get_spl_size(void)
+{
+	struct boot_file_head *egon_head = (void *)SPL_ADDR;
+	struct toc0_main_info *toc0_info = (void *)SPL_ADDR;
+
+	if (sunxi_egon_valid(egon_head))
+		return readl(&egon_head->length);
+	if (sunxi_toc0_valid(toc0_info))
+		return readl(&toc0_info->length);
+
+	/* Not a valid image, so use the default U-Boot offset. */
+	return 0;
+}
+
+/*
+ * The eGON SPL image can be located at 8KB or at 128KB into an SD card or
+ * an eMMC device. The boot source has bit 4 set in the latter case.
+ * By adding 120KB to the normal offset when booting from a "high" location
+ * we can support both cases.
+ * Also U-Boot proper is located at least 32KB after the SPL, but will
+ * immediately follow the SPL if that is bigger than that.
+ */
+unsigned long board_spl_mmc_get_uboot_raw_sector(struct mmc *mmc,
+						 unsigned long raw_sect)
+{
+	unsigned long spl_size = sunxi_get_spl_size();
+	unsigned long sector;
+
+	sector = max(raw_sect, spl_size / 512);
+
+	switch (sunxi_get_boot_source()) {
+	case SUNXI_BOOTED_FROM_MMC0_HIGH:
+	case SUNXI_BOOTED_FROM_MMC2_HIGH:
+		sector += (128 - 8) * 2;
+		break;
+	}
+
+	debug("SPL size = %lu, sector = %lu\n", spl_size, sector);
+
+	return sector;
+}
+
+u32 spl_boot_device(void)
+{
+	return sunxi_get_boot_device();
+}
+
+DECLARE_GLOBAL_DATA_PTR;
+
+/*
+ * Try to use the environment from the boot source first.
+ * For MMC, this means a FAT partition on the boot device (SD or eMMC).
+ * If the raw MMC environment is also enabled, this is tried next.
+ * SPI flash falls back to FAT (on SD card).
+ */
+enum env_location env_get_location(enum env_operation op, int prio)
+{
+	if (prio > 1)
+		return ENVL_UNKNOWN;
+
+	/* NOWHERE is exclusive, no other option can be defined. */
+	if (IS_ENABLED(CONFIG_ENV_IS_NOWHERE))
+		return ENVL_NOWHERE;
+
+	switch (sunxi_get_boot_device()) {
+	case BOOT_DEVICE_MMC1:
+	case BOOT_DEVICE_MMC2:
+		if (prio == 0 && IS_ENABLED(CONFIG_ENV_IS_IN_FAT))
+			return ENVL_FAT;
+		if (IS_ENABLED(CONFIG_ENV_IS_IN_MMC))
+			return ENVL_MMC;
+		break;
+	case BOOT_DEVICE_SPI:
+		if (prio == 0 && IS_ENABLED(CONFIG_ENV_IS_IN_SPI_FLASH))
+			return ENVL_SPI_FLASH;
+		if (IS_ENABLED(CONFIG_ENV_IS_IN_FAT))
+			return ENVL_FAT;
+		break;
+	case BOOT_DEVICE_BOARD:
+		break;
+	default:
+		break;
+	}
+
+	/*
+	 * If we come here for the first time, we *must* return a valid
+	 * environment location other than ENVL_UNKNOWN, or the setup sequence
+	 * in board_f() will silently hang. This is arguably a bug in
+	 * env_init(), but for now pick one environment for which we know for
+	 * sure to have a driver for. For all defconfigs this is either FAT
+	 * or UBI, or NOWHERE, which is already handled above.
+	 */
+	if (prio == 0) {
+		if (IS_ENABLED(CONFIG_ENV_IS_IN_FAT))
+			return ENVL_FAT;
+		if (IS_ENABLED(CONFIG_ENV_IS_IN_UBI))
+			return ENVL_UBI;
+	}
+
+	return ENVL_UNKNOWN;
+}
+
+static struct boot_file_head *get_spl_header(u8 req_version)
+{
+	struct boot_file_head *spl = (void *)(ulong)SPL_ADDR;
+	u8 spl_header_version = spl->spl_signature[3];
+
+	/* Is there really the SPL header (still) there? */
+	if (memcmp(spl->spl_signature, SPL_SIGNATURE, 3) != 0)
+		return NULL;
+
+	if (spl_header_version < req_version) {
+		printf("sunxi SPL version mismatch: expected %u, got %u\n",
+		       req_version, spl_header_version);
+		return NULL;
+	}
+
+	return spl;
+}
+
+const char *get_spl_dt_name(void)
+{
+	struct boot_file_head *spl = get_spl_header(SPL_DT_HEADER_VERSION);
+
+	/* Check if there is a DT name stored in the SPL header. */
+	if (spl && spl->dt_name_offset)
+		return (char *)spl + spl->dt_name_offset;
+
+	return NULL;
+}
+
+/*
+ * Check the SPL header for the "sunxi" variant. If found: parse values
+ * that might have been passed by the loader ("fel" utility), and update
+ * the environment accordingly.
+ */
+static void parse_spl_header(const uint32_t spl_addr)
+{
+	struct boot_file_head *spl = get_spl_header(SPL_ENV_HEADER_VERSION);
+
+	if (!spl)
+		return;
+
+	if (!spl->fel_script_address)
+		return;
+
+	if (spl->fel_uEnv_length != 0) {
+		/*
+		 * data is expected in uEnv.txt compatible format, so "env
+		 * import -t" the string(s) at fel_script_address right away.
+		 */
+		himport_r(&env_htab, (char *)(uintptr_t)spl->fel_script_address,
+			  spl->fel_uEnv_length, '\n', H_NOCLEAR, 0, 0, NULL);
+		return;
+	}
+	/* otherwise assume .scr format (mkimage-type script) */
+	env_set_hex("fel_scriptaddr", spl->fel_script_address);
+}
+
+int misc_init_r(void)
+{
+	const char *spl_dt_name;
+	uint boot;
+
+	env_set("fel_booted", NULL);
+	env_set("fel_scriptaddr", NULL);
+	env_set("mmc_bootdev", NULL);
+
+	boot = sunxi_get_boot_device();
+	/* determine if we are running in FEL mode */
+	if (boot == BOOT_DEVICE_BOARD) {
+		env_set("fel_booted", "1");
+		parse_spl_header(SPL_ADDR);
+	} else if (boot == BOOT_DEVICE_MMC1) {
+		env_set("mmc_bootdev", "0");
+	}
+
+	/* Set fdtfile to match the FIT configuration chosen in SPL. */
+	spl_dt_name = get_spl_dt_name();
+	if (spl_dt_name) {
+		char str[64];
+
+		snprintf(str, sizeof(str), "%s.dtb", spl_dt_name);
+		env_set("fdtfile", str);
+	}
+
+	return 0;
+}
+
+int ft_board_setup(void *blob, struct bd_info *bd)
+{
+	/*
+	 * The OS tree may be a different blob from the control tree the
+	 * SPL fixed up, and the DRAM size is only known at runtime.
+	 */
+	u64 start = gd->ram_base;
+	u64 size = gd->ram_size;
+
+	return fdt_fixup_memory_banks(blob, &start, &size, 1);
+}
diff --git a/board/sun20i/spl.c b/board/sun20i/spl.c
new file mode 100644
index 00000000000..7ca85f2c3f8
--- /dev/null
+++ b/board/sun20i/spl.c
@@ -0,0 +1,142 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * (C) Copyright 2007-2011
+ * Allwinner Technology Co., Ltd. <www.allwinnertech.com>
+ * Tom Cubie <tangliang@allwinnertech.com>
+ * (C) Copyright 2012-2013 Henrik Nordstrom <henrik@henriknordstrom.net>
+ * (C) Copyright 2013 Luke Kenneth Casson Leighton <lkcl@lkcl.net>
+ *
+ * (C) Copyright 2026 Indrek Kruusa <indrek.kruusa@gmail.com>
+ *
+ * SPL board initialization for Allwinner D1(s) RISC-V SoC.
+ */
+
+#include <fdt_support.h>
+#include <image.h>
+#include <ram.h>
+#include <spl.h>
+#include <sunxi_image.h>
+#include <asm/cache.h>
+#include <asm/csr.h>
+#include <asm/arch/thead_csr.h>
+#include <cpu.h>
+#include <cpu_func.h>
+#include <dm.h>
+#include <init.h>
+
+extern const char *get_spl_dt_name(void);
+
+int spl_board_init_f(void)
+{
+	int ret;
+	struct udevice *dev;
+
+	ret = cpu_probe_all();
+	if (ret)
+		debug("CPU init failed: %d\n", ret);
+
+	/* DDR init */
+	ret = uclass_get_device(UCLASS_RAM, 0, &dev);
+	if (ret) {
+		debug("DRAM init failed: %d\n", ret);
+		return ret;
+	}
+
+	/*
+	 * The C906 leaves reset with both caches disabled (MHCR.IE and
+	 * MHCR.DE are 0) and nothing else in the boot chain turns them on.
+	 * Enable them here, i.e. only once DRAM is usable: with the D-cache
+	 * on, the DRAM controller's training tests observe their own cached
+	 * writes and fail.
+	 *
+	 * The SYS_{I,D}CACHE_OFF options still win: the T-Head cache
+	 * maintenance library (SYS_CACHE_THEAD_CMO) is only built when the
+	 * D-cache may be on, so enabling the D-cache here regardless would
+	 * leave such a build without working range flushes.
+	 */
+	if (!CONFIG_IS_ENABLED(SYS_ICACHE_OFF))
+		icache_enable();
+	if (!CONFIG_IS_ENABLED(SYS_DCACHE_OFF))
+		dcache_enable();
+
+	/*
+	 * MXSTATUS.MAEE makes the MMU take the memory type from PTE[63:59]
+	 * instead of ignoring those bits.  With it clear every mapping is
+	 * cached, so the OS cannot mark its DMA memory non-cacheable, and this
+	 * SoC has no Zicbom to fall back on: drivers then read stale
+	 * descriptors (OHCI reports "frame counter not updating").  The C906
+	 * does not leave the bit set, so set it once DRAM is up, as the vendor
+	 * SPL does.
+	 */
+	csr_set(CSR_MXSTATUS, MXSTATUS_MAEE);
+
+	return 0;
+}
+
+void spl_perform_board_fixups(struct spl_image_info *spl_image)
+{
+	struct ram_info info;
+	struct udevice *dev;
+	int ret;
+
+	ret = uclass_get_device(UCLASS_RAM, 0, &dev);
+	if (ret)
+		panic("No RAM device");
+
+	ret = ram_get_info(dev, &info);
+	if (ret)
+		panic("No RAM info");
+
+	ret = fdt_fixup_memory(spl_image->fdt_addr, info.base, info.size);
+	if (ret)
+		panic("Failed to update DTB");
+
+	/*
+	 * The D-cache is enabled by now, so the image we just loaded and the
+	 * DTB we just patched may still be dirty in it. The next stage is
+	 * fetched through the I-cache, which does not see dirty D-cache
+	 * lines, so push everything out before handing over.
+	 */
+	flush_dcache_all();
+}
+
+#ifdef CONFIG_SPL_LOAD_FIT
+static void set_spl_dt_name(const char *name)
+{
+	struct boot_file_head *spl = (void *)(ulong)CONFIG_SUNXI_SRAM_ADDRESS;
+
+	/* Promote the header version for U-Boot proper, if needed. */
+	if (spl->spl_signature[3] < SPL_DT_HEADER_VERSION)
+		spl->spl_signature[3] = SPL_DT_HEADER_VERSION;
+
+	strcpy((char *)&spl->string_pool, name);
+	spl->dt_name_offset = offsetof(struct boot_file_head, string_pool);
+}
+
+int board_fit_config_name_match(const char *name)
+{
+	const char *best_dt_name = get_spl_dt_name();
+	int ret;
+
+#ifdef CONFIG_DEFAULT_DEVICE_TREE
+	if (!best_dt_name)
+		best_dt_name = CONFIG_DEFAULT_DEVICE_TREE;
+#endif
+
+	if (!best_dt_name) {
+		/* No DT name was provided, so accept the first config. */
+		return 0;
+	}
+
+	ret = strcmp(name, best_dt_name);
+
+	/*
+	 * If one of the FIT configurations matches the most accurate DT name,
+	 * update the SPL header to provide that DT name to U-Boot proper.
+	 */
+	if (ret == 0)
+		set_spl_dt_name(best_dt_name);
+
+	return ret;
+}
+#endif
diff --git a/include/configs/sun20i.h b/include/configs/sun20i.h
new file mode 100644
index 00000000000..e8ef1b6c4ac
--- /dev/null
+++ b/include/configs/sun20i.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Placeholder wrapper to allow addressing Allwinner D1 (and later) sun20i
+ * CPU based devices separately. Please do not add anything in here.
+ */
+#ifndef __CONFIG_H
+#define __CONFIG_H
+
+#include <configs/sunxi-common.h>
+
+#endif /* __CONFIG_H */
diff --git a/scripts/Makefile.xpl b/scripts/Makefile.xpl
index 77746ec07cd..33b7aac61b4 100644
--- a/scripts/Makefile.xpl
+++ b/scripts/Makefile.xpl
@@ -275,7 +275,7 @@ endif
 
 INPUTS-$(CONFIG_ARCH_SOCFPGA_SOC64) += $(obj)/u-boot-spl-dtb.hex
 
-ifdef CONFIG_ARCH_SUNXI
+ifneq ($(CONFIG_ARCH_SUNXI)$(CONFIG_TARGET_SUN20I),)
 INPUTS-y	+= $(obj)/sunxi-spl.bin
 
 ifdef CONFIG_NAND_SUNXI
-- 
2.43.0

