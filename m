Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474A2606A31A
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 23:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=sS6qbPVS;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=AGywwr5Q
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 244AE40572;
	Mon, 26 Oct 2026 23:46:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xlKyhwSxo_3U; Mon, 26 Oct 2026 23:46:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 502E040575
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793058418;
	b=YNkvzCWYM+mI67BovRNuvi3H6hkPEetEZIJ5FfRgDkKnUC0UuVkgozuHd713HnYs7KtV
	 ZI2d5KiHr3Z24g/mxho1DkJLJpWhB4PxDmObYnkjrqo6WXS3bqRcw2c5BZXa+hM437X89
	 jDw2CGmRgFwUVGWEke2vmt1zIarzgy2GzlmvWhKfDVlFoc2lThknB6fD0gk2OF4DoXW2e
	 nxVgFa0ezJQ0d/N9FVprfQzpi4N1JGwjElS4cvTntNSG7pjWlNVVI2Z1IwuhuAec/gmPE
	 +X4F2qSICMjzYtRixsd60iGcDMdoQypZwbO7bJ8WJXSQee1gxKjivN4H6hYfOHUrN3Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793058418;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=klI3T6jTJUfAGIKljAVcCzvk5mYgkUuhd1tjAlBdb8E=;
	b=lIXDHjCV/gIwcSrXczYsztwX3mQ1jxuG5SOQpA4UwPYJjvGZv8NOVKUAT21KZ2NwvPGc
	 fcnhRJbSF0uojET899xbr+AqjGLdDBgTJB6kG4RpDjBroiCjSKCQvisE/Ddon0kZmBZra
	 5Ty2tJ4KJZR9iQ1RttO6LqKSkBwYEC5MUYMMcaMkOLa7H4slpb/Og2TMM6ssyRPqfay3p
	 80dc3jPsomthjJ5fVDWbA5xTCRV/hgFsMuQIIcGF/lkHpaP0lQgOqGln/PZD+WDrvdF+J
	 6/mXsYGcKFgSrFNTbCOfr9ipGWDxx3BXe6yRdWLqgX5eIbhD23wuFPeWMrCQ8iuejQw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793058418;
	bh=klI3T6jTJUfAGIKljAVcCzvk5mYgkUuhd1tjAlBdb8E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sS6qbPVSUfK6peR2+qMIiwgNFjVTG8J3hnkmEEVHvrYizEcU8OSk7S72jXp7uzVa2
	 o1msV9vZiPsztO0qGC+KZwP3NxkmR7b4Bm7BRpunajzTAYyRBmmrlZJubXDdXaEGY2
	 vQCRHPUyJm7RZsS+HRw3VIQ5hdVfVy93fd8K/S5aAScR0x9kn7iyMNpC607QtdRT3O
	 XLt30MA2cFJW931NTNyaJv9dbVUEjGbS3ALNdPgWJTc5dVhYdjQoXAsnPy4pJfBwHz
	 ZGsN80/5jf+yFDf/mg4CrQ69+kIctAczAGQegle/NH/1IZEo1uZEmqQlfqEZxj1SXL
	 lggOGLduMQqHQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 502E040575;
	Mon, 26 Oct 2026 23:46:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 547D93421
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 23:46:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4644040205
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 23:46:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KWsJwqNDCAmU for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 23:46:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 7584B40062
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::334"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793058409;
 b=Wox88/1exqpJr9oWf7aBgkxVwkdLapWjLxCkT+znusikGzuK9j9Qegw2ESgxkjf9kMfF
 dfPijouIaeIlW2REUzVXQWGZz0NII9Gbj+CrAG5f6U2mR8dHxF1BJClHp2vA0FZKU23oG
 NDybn3+SWKzHot30pu4oYFy7znrwVOqMwjwgfKePKSpWbXo/eEWgCj4tdGdc+TbObXsJV
 3GqOTbFN8dBpW+2xmjwrnluh+4Jis3H0Z6OO5NTNv+cht4ZJGLlyAtjhIyKP3jMp+IEyN
 uE3D1zSOgHlkx25hnfoykLUOjL5NPiJ0+OgelJYRoqp5hay03FCb+88d5NhwF0lEiMQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793058409;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=klI3T6jTJUfAGIKljAVcCzvk5mYgkUuhd1tjAlBdb8E=;
 b=IZij2AyZZi+CcooArjNV3tngcw+gpbPTAk87enH3Lf5N0nODzcmuZmklebiO5pZW9epF
 MNgBtmaZ54XMLQuTzox93l5GKcjYJc1etN7H6rn8JpJaWkVaWMVqKaWsYeD0h8DZ1JxMI
 FthVWJAHVXxA/qI9lg3Vodk/KW3mjrv01ziHcBZPaMzAPJieJiQae0BYNa1Vtq2VM6GPJ
 6FajfT+uLklELZGoXDLpGWnz2NvRIAxLaE2JpHmU0ScUtDtGWNPHFtYgsqx+5L0ghKLGa
 lmOtdWd1VzvKH1iVGCz5ZNcqxH0chiXstivZfkG7/Bz63Isi3s0FzqwMHWdtVlDpfJA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=AGywwr5Q; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::334"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::334; helo=mail-ot1-x334.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=AGywwr5Q
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7584B40062
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 23:46:48 +0000 (UTC)
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-8451a619da7so2098291a34.1
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 16:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793058408; x=1793663208;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=klI3T6jTJUfAGIKljAVcCzvk5mYgkUuhd1tjAlBdb8E=;
 b=AGywwr5QyPt+N70L/ziKwuqHPdcwdKHA2OQBJxAtmX8R068DKFq8JHdSCZPjmkK4vu
 HOhXYQFeYMXE+Xnz083YcV/K/zhN9ZbomRdivQxfjQOf7PRunYqMUDmjzgGT9q5b6Da/
 VJwDE0Rxn+B65KZ26MYqoToLsgePT+A7c64JiB0GslfWSL545zPoBb6DdcCt5yb3pz4W
 fKAHDY3GlP4x2Rqf2gLKMkaqe7teaXPpezJhgt+ashBpqk0E3RT8U9flQIm84EoL88SG
 pr0SxrbbCIbzaIzJoO3fb+d7m74fF/iSFd5OTYXUJUk4kHqCPSywbhw1xOhEf4yWPrhs
 yn/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793058408; x=1793663208;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=klI3T6jTJUfAGIKljAVcCzvk5mYgkUuhd1tjAlBdb8E=;
 b=SlxVWWvqgdrfqRdlh0y4ezB58mztTKTaP166GI9HAC1WRekY4Tq0p34hLkGW+0ADlA
 A5pnB16IFh/cSRBIzkJ9ukdue1wo5uZVAohFH5yGq1V/AHsVdy4ALstuBq8q6/XR8YeA
 O2vxzHknr/2HqHhC5pNCxAxzo6A90RS6aKjFT/v7vURkS9/BcOqriSAh6/VivxziOR/K
 rlszueY3gPvFS9j4HsMjdEjtpDrtHG9ubuSOVIs37YM5ARl9smX9tY8r9VqSaTpX8dqe
 MwNGVgK8XWgOQcyoa+zfgJniLGrlUlrfyfQf37WGk/5aIThTSYI3XY0OawYnhOgC1NrP
 PvAw==
X-Gm-Message-State: AFq9FYKGTNKt/yNWW1cYf+jPPNbppJ9knEDknO6XTphIJALsol0zlwCV
 E0W+syKEc1PiX4wU8sDq7ESezX5ppOq1xSfXLQePLJs+f3MLaY1lBTYH
X-Gm-Gg: AYBFou2ij6goNgLLjKVMN6iGoY728O1/iuWnmTM6LmxfZN9EIcHsjJ51ksdQNH0EsE1
 vJZvXa57vajPfd8ukjAqfcfYXLm9Wyc1gt1gv3Qe5Wg3BISDhXexvkenXKDjehAtX4fBLrIwxf7
 G5yfRnrqX8W1bM6iCp7Zi4/qdki+WfkTF0TwPjw1qbg2tvmh1H+GGYQJXWcZM5kVDEz6cbmusfN
 BfgdPMQ2jOFTbY5MM54hm8ygwlHdx8RcWe0NB4F7g2B6SkWQc7H6+5Z17jhjwbKxgz8+q/xXGJx
 OIjnVuS4FJQ23+svaoUCahY+OVArrBQddiF/mhkarFH1xs1iE92abfanP7jtoky7I4Ei/9kgkqX
 yWWtqa84aNeXEz9ksnRtamuKc7IguHIoC+nW5NOKn8iLoAALaJgxTOPz1M59x8fH8L4DsMIUa3B
 yIpUo2bfNZijmIZiiXXXuaZap09U1uc7XouoHkgwaaACSdsgUrbZwdvWzdgGMTNJIvT5SBznN0G
 DOB2ynYe6xCHrQm8WDXzJmMZGDG11zxEosp0Z/TbjPPTN9TW6U6v9I1i3LDbUJ/+lsblERiZHzT
 tgwiUP1yrFc+8A2O9oM2Zx4qZlm4KFtmsi8Uo4NTA761mIZ7+lYqOAjQAhhKW3NqDshUVeM8Xc+
 OSkuT7Y13Zy9LsaNXjahBzpc1/iR6pdSNd5esvlAWfyNWdHXxx9AImZdHgNx2VjNRIARZ0M0Ln8
 SO30KCkAybQH9zRPpweKsXaWMG
X-Received: by 2002:a05:6830:43a2:b0:806:ab05:c1dd with SMTP id
 46e09a7af769-850fbd152cdmr7121487a34.4.1793058407945; 
 Mon, 26 Oct 2026 16:46:47 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-850fc005bd7sm9509137a34.24.2026.10.26.16.46.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 16:46:47 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 26 Oct 2026 17:46:39 -0600
Subject: [PATCH 7/9] misc: add Allwinner SID NVMEM provider
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261026-submit-xpowers-acx00-ephy-mainline-v1-v1-7-e22389e4076b@gmail.com>
References: <20261026-submit-xpowers-acx00-ephy-mainline-v1-v1-0-e22389e4076b@gmail.com>
In-Reply-To: <20261026-submit-xpowers-acx00-ephy-mainline-v1-v1-0-e22389e4076b@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Jerome Forissier <jerome.forissier@arm.com>, 
 Tom Rini <trini@konsulko.com>, Pranav Tilak <pranav.vinaytilak@amd.com>, 
 Sean Anderson <seanga2@gmail.com>, Andre Przywara <andre.przywara@arm.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Marek Vasut <marex@nabladev.com>, 
 Michal Simek <michal.simek@amd.com>, Simon Glass <sjg@chromium.org>, 
 Johan Jonker <jbx6244@gmail.com>, 
 =?utf-8?q?Jo=C3=A3o_Loureiro?= <joaofl@gmail.com>, 
 Anshul Dalal <anshuld@ti.com>, kongchen <3305708832@qq.com>, 
 Chris Chen <chris-qj.chen@mediatek.com>, 
 Alexey Charkov <alchark@flipper.net>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Daniel Golle <daniel@makrotopia.org>, Peter Robinson <pbrobinson@gmail.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 David Lechner <dlechner@baylibre.com>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, 
 Lukas Schmid <lukas.schmid@netcube.li>, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Linux device trees describe calibration and configuration values as
cells in the Allwinner Security ID block. U-Boot has an NVMEM consumer
API but no provider for the direct-read SID variants.

Add a read-only misc driver for the A10, A20, A83T, D1, A64, H5
and H6 register layouts so firmware consumers can use those standard
nvmem-cells descriptions.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 MAINTAINERS              |   1 +
 drivers/misc/Kconfig     |  10 ++++
 drivers/misc/Makefile    |   1 +
 drivers/misc/sunxi_sid.c | 118 +++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 130 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 95b1f3b5ab3..e724357419b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -702,6 +702,7 @@ F:	arch/arm/include/asm/arch-sunxi/
 F:	arch/arm/mach-sunxi/
 F:	board/sunxi/
 F:	drivers/clk/sunxi/
+F:	drivers/misc/sunxi_sid.c
 F:	drivers/phy/allwinner/
 F:	drivers/pinctrl/sunxi/
 F:	drivers/video/sunxi/
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 681d5f28ea4..6f6456120d0 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -51,6 +51,16 @@ config NVMEM
 	  up hardware configuration data such as MAC addresses and calibration
 	  settings.
 
+config SUNXI_SID
+	bool "Allwinner Security ID NVMEM support"
+	depends on ARCH_SUNXI
+	depends on MISC
+	select NVMEM
+	help
+	  Enable read-only access to the Security ID efuse area found in
+	  Allwinner SoCs. This allows consumers to use the standard nvmem-cells
+	  properties from Linux-compatible device trees.
+
 config SPL_NVMEM
 	bool "NVMEM support in SPL"
 	help
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index f20c989ffc6..3ec2bc2b201 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -78,6 +78,7 @@ obj-$(CONFIG_SMSC_LPC47M) += smsc_lpc47m.o
 obj-$(CONFIG_SMSC_SIO1007) += smsc_sio1007.o
 obj-$(CONFIG_STM32MP_FUSE) += stm32mp_fuse.o
 obj-$(CONFIG_STM32_RCC) += stm32_rcc.o
+obj-$(CONFIG_SUNXI_SID) += sunxi_sid.o
 obj-$(CONFIG_SYS_DPAA_QBMAN) += fsl_portals.o
 obj-$(CONFIG_TEGRA186_BPMP) += tegra186_bpmp.o
 obj-$(CONFIG_TEGRA_CAR) += tegra_car.o
diff --git a/drivers/misc/sunxi_sid.c b/drivers/misc/sunxi_sid.c
new file mode 100644
index 00000000000..86a1379d07e
--- /dev/null
+++ b/drivers/misc/sunxi_sid.c
@@ -0,0 +1,118 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Allwinner Security ID NVMEM provider
+ *
+ * Copyright (C) 2026 James Hilliard <james.hilliard1@gmail.com>
+ */
+
+#include <dm.h>
+#include <dm/read.h>
+#include <misc.h>
+#include <asm/io.h>
+
+struct sunxi_sid_data {
+	unsigned int value_offset;
+	unsigned int size;
+};
+
+struct sunxi_sid_priv {
+	const struct sunxi_sid_data *data;
+	u8 __iomem *base;
+};
+
+static int sunxi_sid_read(struct udevice *dev, int offset, void *buf, int size)
+{
+	struct sunxi_sid_priv *priv = dev_get_priv(dev);
+	u8 *out = buf;
+	int i;
+
+	if (offset < 0 || !buf || size < 0 || offset > priv->data->size ||
+	    size > priv->data->size - offset)
+		return -EINVAL;
+
+	for (i = 0; i < size; i++) {
+		unsigned int byte_offset = offset + i;
+		u32 value;
+
+		value = readl(priv->base + priv->data->value_offset +
+			      (byte_offset & ~3));
+		out[i] = value >> (8 * (byte_offset & 3));
+	}
+
+	return size;
+}
+
+static int sunxi_sid_probe(struct udevice *dev)
+{
+	struct sunxi_sid_priv *priv = dev_get_priv(dev);
+
+	priv->data = (const void *)dev_get_driver_data(dev);
+	priv->base = dev_read_addr_ptr(dev);
+	if (!priv->base)
+		return -EINVAL;
+
+	return 0;
+}
+
+static const struct misc_ops sunxi_sid_ops = {
+	.read = sunxi_sid_read,
+};
+
+static const struct sunxi_sid_data sun4i_a10_sid_data = {
+	.size = 0x10,
+};
+
+static const struct sunxi_sid_data sun7i_a20_sid_data = {
+	.size = 0x200,
+};
+
+static const struct sunxi_sid_data sun50i_a64_sid_data = {
+	.value_offset = 0x200,
+	.size = 0x100,
+};
+
+static const struct sunxi_sid_data sun50i_h6_sid_data = {
+	.value_offset = 0x200,
+	.size = 0x200,
+};
+
+static const struct udevice_id sunxi_sid_ids[] = {
+	{
+		.compatible = "allwinner,sun4i-a10-sid",
+		.data = (ulong)&sun4i_a10_sid_data,
+	},
+	{
+		.compatible = "allwinner,sun7i-a20-sid",
+		.data = (ulong)&sun7i_a20_sid_data,
+	},
+	{
+		.compatible = "allwinner,sun8i-a83t-sid",
+		.data = (ulong)&sun50i_a64_sid_data,
+	},
+	{
+		.compatible = "allwinner,sun20i-d1-sid",
+		.data = (ulong)&sun50i_a64_sid_data,
+	},
+	{
+		.compatible = "allwinner,sun50i-a64-sid",
+		.data = (ulong)&sun50i_a64_sid_data,
+	},
+	{
+		.compatible = "allwinner,sun50i-h5-sid",
+		.data = (ulong)&sun50i_a64_sid_data,
+	},
+	{
+		.compatible = "allwinner,sun50i-h6-sid",
+		.data = (ulong)&sun50i_h6_sid_data,
+	},
+	{ }
+};
+
+U_BOOT_DRIVER(sunxi_sid) = {
+	.name = "sunxi_sid",
+	.id = UCLASS_MISC,
+	.of_match = sunxi_sid_ids,
+	.probe = sunxi_sid_probe,
+	.ops = &sunxi_sid_ops,
+	.priv_auto = sizeof(struct sunxi_sid_priv),
+};

-- 
2.53.0

