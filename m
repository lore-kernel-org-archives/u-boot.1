Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C51CC79F85
	for <u-boot@archiver.kernel.org>; Sun,  6 Sep 2026 09:12:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DF47A4065C;
	Sun,  6 Sep 2026 09:12:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id A7uBoy6Eas15; Sun,  6 Sep 2026 09:12:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 6DAB7405FF
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788685921;
	b=ARsg9cjc/l+/dEr2/fdDKtfx1+yknzVjhk3t8gIOAfpPX59RlLeA011wM+b3Mer9eKIc
	 IVVMLaigr8wSOclqGy2dKfZK3pdqrdMZVzmlNMPCJA8LHJY+38jnSPZJ6Fwx4OFHyA97E
	 YSjlHZWkBZKZLAvVP5f1AqOsX5Ijj/DGMx7vVfbioy7lLetYFfa77nPPrlqfjXExSNPb6
	 2G6+sPvNpL+Oo4ANck0tH+hdS+vowIBtKHgj+iBx+MgVMexv2TmM4CEt77CvxSit5nlo7
	 XrITaSdVS7USqqe8jg7KxSuqKLQtKOcgonOHW4THFbSMSR+4NF/KjNG2to+jMwM54Rg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788685921;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=pb92asXeCbFivAkLJIRniCitbaHzqNimmCDsG5aalCE=;
	b=W9jgPDGkay+LZ2kZM8v1al64xDI3r427VUAmD53+d/7NyZ1aavgWrNdK4LM/j0Rcfd/U
	 KDv+02uS1aCNITShTZDVNCNNKBY++EAlQI1/+ueG/4Jj+/AmNFj+9rdGZKOiBYeDEXqN9
	 zlR+iurhMvcWEw10bP7Zb5X8I1YjzMbLc3TIPcMs6bfjOFnKPImk6Tq0Z4A/txKzj2vyE
	 ftsV+f6QR37gUyk81ZJuiQRcErS6oOyVKlgBnWUnQhFRCru5aa8m6/xWwRV7/hj/HmfDQ
	 s2UAFrtp9NOJ/9sIBpZZaNiQVzAhRKSKYfRiRZ2MhfSljAgwQl2KeYKYQvSddIJNTDw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788685921;
	bh=pb92asXeCbFivAkLJIRniCitbaHzqNimmCDsG5aalCE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ynctS5E7U7qpHUPQ6TMjc7MAAwBQN1w7hcpX0laHR3rTrTq755FZg+TBGwrjweiin
	 92gPRN0UpRAEbJfgNDIC/RCI2LIybSiPxPMznsK7FI4GnvIESE3SVocEoheDk8hrSa
	 enjOodkW0uDvxPov2nUvcr4P/iVqiU+ElfL0AcSzJedPpGepBTq1gEtj4yd2T/kweE
	 nAsfZoXEd7AiOOvgVg5YQqX28pXZiuw+pBrw801tgER0TAsH+B8/NwmkL71c8lW3YW
	 tcyXYZV5ii6mJ7HZBVihL04EmGzpVhBVIkV3Hf4JwHBtYpPpUyWu5PqtYVhBNNRM3X
	 ukOUkgIcpK6tg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6DAB7405FF;
	Sun,  6 Sep 2026 09:12:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2A275372
 for <u-boot@lists.u-boot-project.org>; Sun,  6 Sep 2026 09:12:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1C3A64008B
 for <u-boot@lists.u-boot-project.org>; Sun,  6 Sep 2026 09:12:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id i8wrX6sJBfqo for <u-boot@lists.u-boot-project.org>;
 Sun,  6 Sep 2026 09:11:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org A879E4007B
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::62a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788685915;
 b=Wgy189YkPVG5uf0/z1ueNz8sae65cC7R+ZBaDPx5XjDgnj0LFFCdOhfL2HptYV8ez41O
 jjcxXCJPd/aHX3fDY9S1HUZCUiLW4OkF1AwePvFpANQj84wFmZtWqdmsTh1ZArmehYH+b
 vQ+CbEDjiBg/gIDaltSsmbPIPHSbtBK02P2k/w7Xb+cKDxTX1DTZe852JHx0yrAvOupGS
 t5vwOMVA7fKtM/vY+EvxSPTh+6j0iydjX31AOSLWINhkjtg/bFlxbYzo9lufYvKTA1Azn
 FFifRWhZd7HJOROKB7wADBys8l0vF4PLGWxLcurd8uq+kiBKMMvKYdqYN7l2nFy20JA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788685915;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=pb92asXeCbFivAkLJIRniCitbaHzqNimmCDsG5aalCE=;
 b=oBUZRZQlJbc5Lj2WYmZnSmNn7cPttGZmBc13yrGubetPAk7Op+B0LOMdvg2tEpk5F+oC
 dZuswZl2qIieItZ/E+wPqujfdxlD1nf1TxfcsgViXSyMhpQspmP9MIO6tV2ykJqQ3XEwe
 ySx3ad/MlYddG9exJySonfze9IGWexjF0e9Rsnwa9WBgeTi/rQKD9WyY0xFULbk+JxIwB
 GhyO5ifAzDKzdPzz7G+tGmdEb2BG1Gpv5q+/tYTC+elpA69hnikW/SxBMwXE/TYGWixB3
 HTpjBbywXXrktyhl2+KHs6RyMAo1Le8iHc1L1kYRdIH4VW9AFQlv3t5w55oH+dE3r4Q==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=riscstar.com; 
 dkim=pass header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=CDpA0n2h; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::62a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::62a; helo=mail-pl1-x62a.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=CDpA0n2h
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A879E4007B
 for <u-boot@lists.u-boot-project.org>; Sun,  6 Sep 2026 09:11:55 +0000 (UTC)
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2d6fe26ef1cso25007515ad.2
 for <u-boot@lists.u-boot-project.org>; Sun, 06 Sep 2026 02:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1788685915; x=1789290715;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pb92asXeCbFivAkLJIRniCitbaHzqNimmCDsG5aalCE=;
 b=CDpA0n2hZOJAmlCUEwuoOJqKd+elmXr1iDMbhmK2j4/r5sOaAs3DjOLBJMolwCz/un
 3LyAZUzFCE0aG9Y06LdBthMsXJoHWWODnXkGbf58AqQScWET3s0lqX9VgnaYIhIN3CMl
 m9200CCi5zcDzJDS3WLHWJ358AWz+zOnH2wsTwFcm4oHo/IkHaC48FDRD4F6/Smkc2Xs
 Ly9u6pgrlRWn3PC5Px4rw26Pn/7GMLdvSCU2rFKDAathVdc706CoKdjdgpo+zwabPDky
 h50rs58bqQaBjBm/NCRdacHn0OtCfQvdohzumx9cDqMu6fuYWYuqmiiI54cJPSH2mA6W
 E3dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788685915; x=1789290715;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pb92asXeCbFivAkLJIRniCitbaHzqNimmCDsG5aalCE=;
 b=oCsjCeaGxf8F3G7JZIXD0g766iw12EOMEGzG1er5nolfFOneNvXGQZtH4B7rrEKI5O
 loEEzAUsAOuBkQcoMWplt5vopw7maUVEwttACUXNnWewM4BqyozmXLKT4T5ZtcBZPcMV
 ndAym5llvLvRq/PZMcU5+QpHWBRO0jRsYuW/has0skffKsBphctF+0mre415lii+dYUn
 maqYoPO3LD/qDIjAKWHesgomZNoeXgdQ6EZVdeqobjyIAWSrjhtZQxuDRJxj9TqPOsPP
 gHZ29yotvDLS/qQRzMR7NtRYU60szgqbRW+dNdqqjHluHmt88V1VdSHYDJahJffr4Mbb
 wKZA==
X-Forwarded-Encrypted: i=1;
 AKwUvBy7Gtvd8vphwiav3dJMpE7tXRMDdpAP8T4LqOkkgS6Ft5EhpKb/EdWs2jzM4vV7IqniWh4G6tI=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mmGdXxOOu1Gnr9hPH7XfE4JDfk9rYNLZ/+RBvrI+ww8EirQu7x
 WoH3CFJUPp6FvR67sY6DMqsjC8R1ZnZGx4VjQYc45ZrfTzU902YAMO0Rem1AXi9OBb8=
X-Gm-Gg: AYBFou07SeAdkjDjYYwsxBzrcCopu69U7mqEB5qa/q8toRj/3UzuIwF2H2fKKhrCuHh
 h4msoA0tiyeCfQ6nKSCBBRSfzWnvTCSuj9Bs/NDQKbZk0GPiGl0DPCGIrbcJjHZhjhuRmyJwbaa
 8o8Ljr6f/2aHgPa5AY8F5+qQfp/SZPAerp7Bg/vev3GZUW29qr1W0YPWKffR/qKNRr/9oHdftN2
 safrYMNgqCOB6KNJPDem+ehdHxYYJTFqy2+R8ZqdBeDtKdZhGcSUsCnUEBdm5B330RosF/gtIPF
 wPdJNqlyredvwPc1+PxVeNhWVe14scPyUZM8o9N7YFqZtwlCNWmIikpx0w2+TWLBl/HNJRh9cBb
 C33WU0qUjLfLpLWbkELD9LpmG9AgUJzuqBfJIdm7XMGO6KjLAaWOd2EN96vhWsMPOaWwcoBfkKM
 NirIbpx7712uOdUeojiqV2PdDLr/pO4QRdWRihn/EQazDWAVO9vKhf8d4bJ2r3P3NJ6HThRow4m
 Ya/fe7uzOTSPJ2cjS+Cdox3aXRN4KvT1dcxAK/qoKEfRKJPw3Xb8NLN8A/q5Qf1XWFrP8cX9GMI
 BJRG3A/K6h5pYBQ1119g2jh7yw==
X-Received: by 2002:a17:90b:2e0c:b0:38d:b36e:9813 with SMTP id
 98e67ed59e1d1-39b26169b1fmr25463286a91.11.1788685914533; 
 Sun, 06 Sep 2026 02:11:54 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3339b8f44d7sm18845384eec.22.2026.09.06.02.11.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Sep 2026 02:11:53 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Date: Sun, 06 Sep 2026 17:11:08 +0800
Subject: [PATCH v12 6/7] doc: spacemit: flash on K1 SoC based boards
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260906-m4-v12-6-89eb5a8f879d@riscstar.com>
References: <20260906-m4-v12-0-89eb5a8f879d@riscstar.com>
In-Reply-To: <20260906-m4-v12-0-89eb5a8f879d@riscstar.com>
To: u-boot-spacemit@groups.io, u-boot@lists.u-boot-project.org, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Yao Zi <me@ziyao.cc>, 
 Wei Fu <wefu@redhat.com>, Huan Zhou <pericycle.cc@gmail.com>, 
 Guodong Xu <guodong@riscstar.com>, Raymond Mao <raymond.mao@riscstar.com>, 
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Anshul Dalal <anshuld@ti.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Johan Jonker <jbx6244@gmail.com>, Sumit Garg <sumit.garg@kernel.org>, 
 Yixun Lan <dlan@kernel.org>, Iker Pedrosa <ikerpedrosam@gmail.com>, 
 Alex Elder <elder@riscstar.com>, Andre Heider <a.heider@gmail.com>, 
 Trevor Gamblin <tgamblin@baylibre.com>, 
 Eric Chung <eric.chung@riscstar.com>
X-Mailer: b4 0.15.2
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Add document on how to flash images into eMMC of K1 SoC based boards.

Signed-off-by: Eric Chung <eric.chung@riscstar.com>

---
v9:
- Add to generate the partition table of SD card.
v3:
- Add document on how to flash images into SD card.
---
 board/spacemit/k1/MAINTAINERS |   2 +-
 doc/board/spacemit/index.rst  |   1 +
 doc/board/spacemit/k1-mmc.rst | 271 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 273 insertions(+), 1 deletion(-)

diff --git a/board/spacemit/k1/MAINTAINERS b/board/spacemit/k1/MAINTAINERS
index 4b2bc4ecfc10..e12288a206e0 100644
--- a/board/spacemit/k1/MAINTAINERS
+++ b/board/spacemit/k1/MAINTAINERS
@@ -6,7 +6,7 @@ S:	Maintained
 F:	arch/riscv/dts/k1-*-u-boot.dtsi
 F:	board/spacemit/k1/
 F:	configs/spacemit_k1_defconfig
-F:	doc/board/spacemit/bananapi-f3.rst
+F:	doc/board/spacemit/
 F:	drivers/gpio/spacemit_gpio.c
 F:	drivers/i2c/k1_i2c.c
 F:	drivers/mmc/spacemit_sdhci.c
diff --git a/doc/board/spacemit/index.rst b/doc/board/spacemit/index.rst
index a5e35ee12ab6..71854e5735bd 100644
--- a/doc/board/spacemit/index.rst
+++ b/doc/board/spacemit/index.rst
@@ -6,5 +6,6 @@ SpacemiT
    :maxdepth: 1
 
    bananapi-f3
+   k1-mmc
    k1-spl
 
diff --git a/doc/board/spacemit/k1-mmc.rst b/doc/board/spacemit/k1-mmc.rst
new file mode 100644
index 000000000000..0be5d5fa1c39
--- /dev/null
+++ b/doc/board/spacemit/k1-mmc.rst
@@ -0,0 +1,271 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+SpacemiT K1 eMMC and SD Card Boot Guide
+=======================================
+
+This guide covers two separate methods for booting and flashing U-Boot on
+SpacemiT K1 based boards:
+
+1. **eMMC Flash**: Flashing U-Boot and SPL images to eMMC via USB fastboot.
+2. **SD Card Boot**: Creating a bootable Bianbu SD card and optionally
+   replacing U-Boot on the card.
+
+Tested boards: Banana Pi BPI-F3, MusePi Pro.
+
+
+Chapter 1: eMMC Flash (U-Boot via USB Fastboot)
+===============================================
+
+SpacemiT K1 U-Boot Flash Guide
+==============================
+
+This guide explains how to flash U-Boot on SpacemiT K1 based boards. It covers
+flashing images via USB fastboot.
+
+.. note::
+
+   This procedure flashes images to eMMC over USB fastboot. The fastboot
+   function is not enabled in our SPL yet, so the download stage runs the
+   SpacemiT released SPL; our built FSBL.bin and fit.itb are the images
+   written to eMMC and used on the next normal boot.
+
+Prerequisites
+~~~~~~~~~~~~~
+
+- A SpacemiT K1 board with USB Type-C and UART access
+- USB-to-UART adapter (3.3V TTL)
+- ``minicom`` or equivalent serial terminal, configured at 115200 8N1
+- ``fastboot`` and ``flashserver`` tool on the host
+
+Hardware Setup
+~~~~~~~~~~~~~~
+
+Refer to k1-spl.rst.
+
+Flash images on eMMC
+~~~~~~~~~~~~~~~~~~~~
+
+**1. Obtain the release images**
+
+Get the release package from Spacemit website. It contains SPL image, and so on.
+
+https://archive.spacemit.com/image/k1/version/bianbu/v2.3.3/Bianbu-Minimal-K1-V2.3.3-20260128183217.zip
+
+Unzip images and store them into a directory.
+
+**2. Obtain flashserver tool**
+
+Get ``flashserver`` from Spacemit website.
+
+.. code-block:: bash
+
+    $wget https://cdn-resource.spacemit.com/file/flash/flashserver
+    $chmod +x flashserver
+    $mv flashserver {flash image path}/
+
+**3. Copy built SPL and U-Boot images**
+
+Build U-Boot as mentioned in k1-spl.rst. Create a new directory to save.
+The official u-boot.itb is used to download images. So the built U-Boot should
+not replace the official one.
+
+.. code-block:: bash
+
+    $mkdir {flash image path}/build
+    $cd {flash image path}
+    $ln -sf {path to FSBL.bin} ./build/
+    $ln -sf {path to u-boot.itb} ./build/fit.itb
+
+``{path to FSBL.bin}`` is the signed FSBL produced by ``fsbl.sh`` in
+k1-spl.rst, e.g. ``~/uboot-2022.10/spl_bin/FSBL.bin``.
+``{path to u-boot.itb}`` is the U-Boot build output, e.g.
+``~/u-boot/u-boot.itb``.
+
+**4. Update configuration files**
+
+The ``partition_2M.json`` and ``partition_universal.json`` files come from
+the release package. Patch the ``fsbl`` and ``uboot`` entries to point at
+the images staged under ``build/`` (pick the layout that matches your eMMC):
+
+.. code-block:: diff
+
+   diff -puNr bianbu-25/partition_2M.json clean/partition_2M.json
+   --- bianbu-25/partition_2M.json	2026-03-02 11:55:58.631116807 +0800
+   +++ clean/partition_2M.json	2026-05-20 11:25:21.683801401 +0800
+   @@ -13,7 +13,7 @@
+          "name": "fsbl",
+          "offset": "128K",
+          "size": "256K",
+   -      "image": "factory/FSBL.bin"
+   +      "image": "build/FSBL.bin"
+        },
+        {
+          "name": "env",
+   @@ -31,7 +31,7 @@
+          "name": "uboot",
+          "offset": "640K",
+          "size": "-",
+   -      "image": "u-boot.itb"
+   +      "image": "build/fit.itb"
+        }
+      ]
+    }
+   diff -puNr bianbu-25/partition_universal.json clean/partition_universal.json
+   --- bianbu-25/partition_universal.json	2026-03-02 11:55:58.642116862 +0800
+   +++ clean/partition_universal.json	2026-05-20 11:26:23.932581853 +0800
+   @@ -14,7 +14,7 @@
+               "name": "fsbl",
+               "offset": "128K",
+               "size": "256K",
+   -            "image": "factory/FSBL.bin"
+   +            "image": "build/FSBL.bin"
+           },
+           {
+               "name": "env",
+   @@ -32,7 +32,7 @@
+               "name": "uboot",
+               "offset": "2M",
+               "size": "2M",
+   -            "image": "u-boot.itb"
+   +            "image": "build/fit.itb"
+           },
+           {
+               "name": "bootfs",
+
+Deploying via USB Fastboot
+~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+To enter BootROM fastboot mode:
+
+1. Power off the board by unplugging its power supply.
+2. **Press and hold** the FDL button (called "Boot Key" on some boards;
+   see the board layout above for the BPI-F3).
+3. While holding the button, use a USB cable to connect the OTG port to
+   your host. This cable is also used by fastboot to upload the firmware.
+4. Release the button.
+
+On the host, ``fastboot devices`` should list the board::
+
+    dfu-device     DFU download
+
+The serial console shows the BootROM's USB download handler trace,
+including a line like::
+
+    usb2d_initialize : enter
+
+This indicates the board is ready to accept an image via USB.
+
+.. tip::
+
+   If you are worried about insufficient USB power, you can first plug
+   in the power, then release the button, and then plug in the USB
+   cable.
+
+On the host:
+
+.. code-block:: console
+
+    $sudo ./flashserver
+
+When ``flashserver`` is running, it lists the detected fastboot devices.
+Enter the corresponding number to select one.
+
+
+Chapter 2: SD Card Boot
+=======================
+
+
+SpacemiT K1 Bianbu SD Card Image Flashing and U-Boot Update Guide
+==================================================================
+
+This guide explains how to prepare a bootable SD card with Bianbu OS for
+SpacemiT K1 based boards and how to replace the U-Boot binary on the SD
+card with a custom build.
+
+Prerequisites
+~~~~~~~~~~~~~
+
+- A SpacemiT K1 based development board
+- A microSD card (at least 4GB capacity recommended)
+- A card reader for your host computer
+- A Linux host system (for ``dd``, ``sgdisk``, ``lsblk`` commands)
+- The Bianbu release package from
+  <https://archive.spacemit.com/image/k1/version/bianbu/v2.3.3/Bianbu-Minimal-K1-V2.3.3-20260128183217.zip>
+- A custom ``FSBL.bin`` and ``u-boot.itb`` file to be written to the U-Boot
+  partition
+
+Prepare the SD Card & the image
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+**1. Obtain the release images**
+
+Unpack the release package to get the image files. Replace the ``FSBL.bin``
+and ``u-boot.itb`` with your custom builds.
+
+**2. Identify the SD card device**
+
+Insert the microSD card into your card reader, then run:
+
+.. code-block:: console
+
+   $ lsblk
+
+Compare the output before and after inserting the card to identify
+the new device. It will typically appear as ``/dev/sdb``, ``/dev/sdc``,
+or ``/dev/mmcblk0``.
+
+**3. Write the image to the SD card**
+
+Run ``sgdisk`` to generate the partition table, then use ``dd`` to write
+the images to the corresponding partitions.
+
+.. code-block:: console
+
+    $sudo sgdisk -o /dev/sdb
+    $sudo sgdisk -a 128 \
+        -n 1:256:767 -t 1:8300 \
+        -n 2:768:895 -t 2:8300 \
+        -n 3:2048:4095 -t 3:8300 \
+        -n 4:4096:8191 -t 4:8300 \
+        -n 5:8192:532479 -t 5:8300 \
+        -n 6:532480:4726783 -t 6:8300 \
+        /dev/sdb
+    $sudo dd if=FSBL.bin of=/dev/sdb1 bs=512 seek=0 status=progress
+    $sudo dd if=env.bin of=/dev/sdb2 bs=512 seek=0 status=progress
+    $sudo dd if=fw_dynamic.itb of=/dev/sdb3 bs=512 seek=0 status=progress
+    $sudo dd if=u-boot.itb of=/dev/sdb4 bs=512 seek=0 status=progress
+    $sudo dd if=bootfs.img of=/dev/sdb5 bs=1M status=progress
+    $sudo dd if=rootfs.ext4 of=/dev/sdb6 bs=1M status=progress
+
+The SD card is now ready as a bootable system disk.
+
+Understanding the SD Card Partition Layout
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The role of each partition:
+
++----------+----------+------------------------------------+
+| Partition| Size     | Purpose                            |
++==========+==========+====================================+
+| ``sdb1`` | 256 KB   | FSBL (First Stage Bootloader)      |
++----------+----------+------------------------------------+
+| ``sdb2`` | 64 KB    | ENV                                |
++----------+----------+------------------------------------+
+| ``sdb3`` | 1 MB     | OpenSBI                            |
++----------+----------+------------------------------------+
+| ``sdb4`` | 2 MB     | U-Boot binary (``u-boot.itb``)     |
++----------+----------+------------------------------------+
+| ``sdb5`` | 256 MB   | Boot partition (kernel)            |
++----------+----------+------------------------------------+
+| ``sdb6`` | 2 GB     | Root filesystem (ext4)             |
++----------+----------+------------------------------------+
+
+
+Booting and Testing
+~~~~~~~~~~~~~~~~~~~
+
+Insert the SD card into the development board, connect the serial
+console (115200 8N1), and power on the board.
+
+- If the board boots successfully, the new device tree or U-Boot image
+  is compatible with your hardware.

-- 
2.51.0

