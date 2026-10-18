Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CC23CCA490
	for <u-boot@archiver.kernel.org>; Sun, 18 Oct 2026 08:35:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EB69E6068A;
	Sun, 18 Oct 2026 08:35:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id m4CAzodUj6LL; Sun, 18 Oct 2026 08:35:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2CF3E6070A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792312542;
	b=N94Elt7gLq0dEYJ3IRyXINfV5641JHnJ7h3d3KG5zYQps/iRI4nZ0ZR7i6z99eaa1HNf
	 /FsQqfklzFxTiaZVEvdKogMsY924hQH8XD8IonnklmCWKH3U+rncbt0XKVzDXnlHpYgwP
	 j1nSkSKGSF9RrvzqjoTS/Fz06xNVVRO6Uhi4ZPURTT8x5pO36BdC1Yeghmh1omTcPlKSW
	 4oMS1OUrvaVhkdGqN8xatUtKC7fivohfAlEuisgWEOdHdpMH2awdhp6/8Nk/fTHhm0JLD
	 ovPN7BOXzTxzgmedCnOmue+upWI84MssFnq1TiVDpz+mIku2JvtfbbI4sdUNHaT1Kyw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792312542;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=r0bHxPI82IgBlDogux4DEQuS32PXBkgn4ejSmw2gt3c=;
	b=r+6YMU8tBfEL5uKadXO8syB3vKfxUxD+TCe9+lBJpDEKy2FVPCZHICi0//Lwf8xCf5Wr
	 4GCvt+X0ruWfd+lPcxOagxbjTrkIQFqZn3YcNWuebRvqbnsxkOobPhgv4aGwh2921oiqv
	 yJZAtb2YhFd+giRZoJVWFhcb5GpbpwV4cYVrR2XMoxlJ/xqz3G2RP6ZIazmCU9AVMis0A
	 Uc2c25TKdmcCFgyrzzkNaX1z4klIjc4toY8z4i9OTmGPWQm1I1d5VVmrwiudNrPquanJZ
	 goqJImVqxfn05lAKh6TRhHqI3nC9HQLBeTM3HTO0kmJo9Slqy0dHrnRvQRHUdERpXEA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792312542;
	bh=r0bHxPI82IgBlDogux4DEQuS32PXBkgn4ejSmw2gt3c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=f9MG0x3M6nSNktBa+9dfOJw80YIvonJnZKhYGXptpd8CnEAe6t3EmCI1TgQGH4JfY
	 o3blJ/IlijJ769vzCtoaq3kNkPqJPN7m3JWkf8TzclcSzYnL6HfuORwLBNig/vSZuj
	 pRSgmvQv2I/3MnbG03+L65swNhYsqDetm7fIxtREbJTiOel2ctqstWzLgRvgVuDVNS
	 lAjrrwnuzEZ4X8PejYOlCKUt/xwHs1dyiyBGlb464XkJlA93PV/Icn9rkr9aUe6afC
	 ujdPH/uc5EN1jIl2h3b4l875jE1/OywtDOUh7TIXS7K+lU7uoda6U+0pa9KG8gcH3Q
	 3br4a4RsH7Uhg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2CF3E6070A;
	Sun, 18 Oct 2026 08:35:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 510842A8
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 08:35:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 42FDB812F6
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 08:35:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id niJerNssAcWK for <u-boot@lists.u-boot-project.org>;
 Sun, 18 Oct 2026 08:35:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5A640812EC
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::335"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792312531;
 b=Nwtrfl1Jw++GL+M/7/NtmIj8I6qTmxGtwln7BKhZaFtyU9IWRTJkz5j5gD8VwdFBsjKx
 UN+jqmtdkVJ7N/L7LDsHFNwDi/HlsCvQIUg/1EzfP0wUNAZ1+UIQTFZV1vPRq3gXIOZB5
 2d42/mWiAymsPuAq2hX66f1VNJpwQEdtqrgUfWrK8MF/OE5H7R6vDePRYqYbwACNEcyCV
 Xf2rcFWvKb7s99OFrSUTxJDtsPp7MuKUNWGkQi+QgQRPS8/tjgOR6bIhvDFmuxfd64DwS
 InrV3PoVQ2koRtMeinrw6MIgDGfblY2tskCjXUK4A2iq65/wpKbhNYFDvVXqFcmW5HA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792312531;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Type:Content-Transfer-Encoding;
 bh=r0bHxPI82IgBlDogux4DEQuS32PXBkgn4ejSmw2gt3c=;
 b=FdkB8eo6+M5sW0z73FawqqC4a/uypDnOd4MtYiSbsX00ufCxelUYZ3ml6Jg2WbGPR4aM
 HcO2CBW2fHMIwWtDP51Uqg648IW+4rnXm5wUwgEuzWGWGNt41yyA9n9JLGvMBO5SSMGgP
 Iq6PPprr8B0rMTgV9aOPqNEDcRKPHRND5pYaEQfmQqyHJDam7G7JgcnGQWWLJ9ssaxdbJ
 6JS9oeASMiOABY/KQgDZcYOd+4sjkGuyDO/Ia3jheJWirNwGV5X7Wxq+vODXDLVTCog56
 qeVVkle5bLzGFo5FfvrF08etFl9V8bfq3MdlstPQ7fmys8UvBCxlthdObSsCgjFLUNg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=pRslMEOc; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::335"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::335; helo=mail-wm1-x335.google.com;
 envelope-from=pepe.schlehofer@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=pRslMEOc
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5A640812EC
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 08:35:30 +0000 (UTC)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4a16c1608faso14109155e9.0
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 01:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792312529; x=1792917329;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=r0bHxPI82IgBlDogux4DEQuS32PXBkgn4ejSmw2gt3c=;
 b=pRslMEOc4/tEPDtXSzTl+cyyC8Rh6JW/Sz9QFJ3lNvsF9SE4brvh1V+jW3tgX6BDi/
 E+jFQkXZiSDiugfUnVaTeCZaZmhwZCmkkO0JZByP8j/mWnsn8a2fSQe6g6YFQdUjmv4S
 s2RfCAIB+SOkKW5QY6Deii9VX94qv9zFHZAKgrmoreXEJ7WDHzeKXSpQ+8muBhCZxtXu
 TyxDki2rTaZf5rKLToMe7zPVaPT73TLFE5WxI6fGEwYqf0MaGgJj93C76FGuUeACTI5z
 NdQsXNDra5DporxPfBv/3XH+yzDIxR+zVUmRWFWaZDrcduZEiEFm7FfWYfB41gOujbJo
 UbhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792312529; x=1792917329;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=r0bHxPI82IgBlDogux4DEQuS32PXBkgn4ejSmw2gt3c=;
 b=evUEyQjPOGTVWSw0iBB4V0ioJ08vNtqis96IKQIZ/j2ohYrD8tWHiwN/vPc2UN+KmF
 46MgiAkN1XZYFAQgrJ8e5rWF7gmnmiOLnzFusg4aUtY33hAHFl1QK+cXJN8lEVhZnkj1
 7YUjTcdLmR8iHBilup6BDYcBniphYYqpOvWmGM5AYE/mlOmJbzx6q4bxS7gMiD42eHXV
 vdbq0/F2MRa7tfke092SRVMlyvDjEw1ZDEc5naCTthbVl4U8F3xdSOczHqUBGFZWX4TZ
 huc0Bi3btwDx57+KsRiad/NgzLldr2CifAthk+NvaYlxrj7Iza5Xrw5I+zxldxHHn+Li
 cioA==
X-Gm-Message-State: AFq9FYI/CQRDwDaZIPovhEDxmfjl+4CS/DXR2cyx1ZKJL2EU527Jw6TS
 YFGuYaocAMlQU6m9vLn7dM+xKuhCeMBOm5/YggGw4cvjBqQMM1PvKu52uN3Gtw6q
X-Gm-Gg: AYBFou1me7W8MeKNDI45UNSND7jyF7H0SI+0Th53l5pnM23/Wux04UYVzgad6U7BhMR
 xuykk7qvc0cMrNJdI+qfePELJ5wGLeq46sE9+X09F5w72HeF9Aw/fCyxzZCBFfMBvkJLgefXDaO
 Kb/yLDUYr5dKT2797qgh383Iq5EGF2of7D4SbEkFOaUO1hfu3tRswnvwLLiBqAM0hU2XBLB5ccX
 wG2yOOCP9Mc1j9b7eWVe0vPcT87aUlhb/G/NsGKusSlQ48LtPR9Wn6fBknYo3T0ZI4/t/ncyq6v
 yD/MPaksJD+4SfOlbhRQ/ottGdAtpjndjyTfsf24h+W9ps67ZB2WVzs7cqyCM4l5ZydJ/EyqLq6
 q096OzhLmGe4ZQgJkk/m1NnfIxNDjVJiDGyVZ3G8yfpn9smDyygr51NPivMoZi3r7tXiyT5r0fi
 kkgZ2ezdA2VnHDDs0sTtSPr7LJN4UsSsLsLjL6Wu7hcqFrzJcJ2s3cKc43hoXNDgQfsfvVF3fdC
 HFt1H9hVlWmUxOHlH9M3dHTyvNJPWZpJUI85G+ENH4KPWfuX8wFPEuJ5gCJUwPtW1F9GqxxJZ33
 ooDPa91FaRuPxKtZH3qZCsJ+SKjXahQehLszdHahGQSi+Xlut0DcaSH6PGW8GN/mji3DTXcAlGq
 Joy7eQJV0fgIinZLAXkCl4jA=
X-Received: by 2002:a05:600c:8b65:b0:49e:65f2:db64 with SMTP id
 5b1f17b1804b1-4a1d75f2574mr105773625e9.5.1792312528614; 
 Sun, 18 Oct 2026 01:35:28 -0700 (PDT)
Received: from localhost.localdomain
 (dynamic-2a00-1028-8388-a84e-318a-f58b-5e43-a2b9.ipv6.o2.cz.
 [2a00:1028:8388:a84e:318a:f58b:5e43:a2b9])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1e3ebb3aasm43589595e9.0.2026.10.18.01.35.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 18 Oct 2026 01:35:28 -0700 (PDT)
From: Josef Schlehofer <pepe.schlehofer@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 =?UTF-8?q?Marek=20Moj=C3=ADk?= <marek.mojik@nic.cz>,
 Peng Fan <peng.fan@nxp.com>, Priyanka Jain <priyanka.jain@nxp.com>,
 Qiang Zhao <qiang.zhao@nxp.com>, Shengzhou Liu <Shengzhou.Liu@nxp.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Christophe Leroy <chleroy@kernel.org>, Mario Six <mario.six@gdsys.cc>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Heiko Schocher <hs@nabladev.com>,
 Holger Brunck <holger.brunck@hitachienergy.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 06/14] powerpc: mpc85xx: Discard LTO keep-syms sections
Date: Sun, 18 Oct 2026 10:35:08 +0200
Message-ID: <20261018083516.49229-7-pepe.schlehofer@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261018083516.49229-1-pepe.schlehofer@gmail.com>
References: <20261018083516.49229-1-pepe.schlehofer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

With LTO, keep-syms-lto.o puts pointers to linker list entries in
.discard.addressable to prevent the entries from being removed. On
mpc85xx, -mrelocatable creates .fixup entries for these pointers, and
the linker scripts keep all .fixup input sections, leaving
.discard.addressable in the image.

Discard .discard* sections and the .fixup entries of keep-syms-lto.o,
which point into them. Otherwise, ld leaves zero words in the fixup
table, which start.S treats as addresses to relocate. With them, the
Turris NOR build with LTO hung after the DRAM message.

Signed-off-by: Josef Schlehofer <pepe.schlehofer@gmail.com>
Cc: Marek Behún <kabel@kernel.org>
---
Changes in v2:
- shorter commit message
---
 arch/powerpc/cpu/mpc85xx/u-boot-spl.lds | 11 ++++++++++-
 arch/powerpc/cpu/mpc85xx/u-boot.lds     | 11 ++++++++++-
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/cpu/mpc85xx/u-boot-spl.lds b/arch/powerpc/cpu/mpc85xx/u-boot-spl.lds
index d918b4395bf..dd4d18bc24b 100644
--- a/arch/powerpc/cpu/mpc85xx/u-boot-spl.lds
+++ b/arch/powerpc/cpu/mpc85xx/u-boot-spl.lds
@@ -35,7 +35,7 @@ SECTIONS
 		KEEP(*(.got2))
 		KEEP(*(.got))
 		_FIXUP_TABLE_ = .;
-		KEEP(*(.fixup))
+		KEEP(*(EXCLUDE_FILE(*keep-syms-lto.o) .fixup))
 	}
 	__got2_entries = ((_GLOBAL_OFFSET_TABLE_ - _GOT2_TABLE_) >> 2) - 1;
 	__fixup_entries = (. - _FIXUP_TABLE_) >> 2;
@@ -63,6 +63,15 @@ SECTIONS
 	__init_end = .;
 	_end = .;
 
+	/*
+	 * .discard.addressable of keep-syms-lto.o only keeps the linker lists
+	 * alive during an LTO link. Drop it, and its fixups with it.
+	 */
+	/DISCARD/ : {
+		*(.discard*)
+		*keep-syms-lto.o(.fixup)
+	}
+
 #if CONFIG_IS_ENABLED(SYS_MPC85XX_NO_RESETVEC)
 #if defined(CONFIG_SDCARD) && !defined(CFG_SYS_MMC_U_BOOT_OFFS)
 	mmc_u_boot_offs = .;
diff --git a/arch/powerpc/cpu/mpc85xx/u-boot.lds b/arch/powerpc/cpu/mpc85xx/u-boot.lds
index bedd2d47472..4bb9b4ecfb2 100644
--- a/arch/powerpc/cpu/mpc85xx/u-boot.lds
+++ b/arch/powerpc/cpu/mpc85xx/u-boot.lds
@@ -49,7 +49,7 @@ SECTIONS
     KEEP(*(.got2))
     KEEP(*(.got))
     _FIXUP_TABLE_ = .;
-    KEEP(*(.fixup))
+    KEEP(*(EXCLUDE_FILE(*keep-syms-lto.o) .fixup))
   }
   __got2_entries = ((_GLOBAL_OFFSET_TABLE_ - _GOT2_TABLE_) >> 2) - 1;
   __fixup_entries = (. - _FIXUP_TABLE_) >> 2;
@@ -107,6 +107,15 @@ SECTIONS
 #endif
 #endif
 
+  /*
+   * .discard.addressable of keep-syms-lto.o only keeps the linker lists
+   * alive during an LTO link. Drop it, and its fixups with it.
+   */
+  /DISCARD/ : {
+    *(.discard*)
+    *keep-syms-lto.o(.fixup)
+  }
+
   __bss_start = .;
   .bss (NOLOAD)       :
   {
-- 
2.54.0 (Apple Git-157)

