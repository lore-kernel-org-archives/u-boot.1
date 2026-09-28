Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EACE3CA5FA5
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 13:42:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A7FD380E60;
	Mon, 28 Sep 2026 13:42:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LWofYiiHsRCB; Mon, 28 Sep 2026 13:42:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 1A06B80F89
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790602957;
	b=RI1SbTPf7pR2etjOpssbwarh7vxTT/X3RRsRWSi4EjLlSM/bVk9hPiiiFJL46w7XHRDj
	 BP0bKNpAzpDowi/6pUuS8QSb5w4PNBXKIYMFZg8PGoJHyOevDM5++PmaIEVd5Bt+7OVOL
	 9F008yOGyIVbKMzh/JihQNL5v3gzXhoI72UmH/jS06MRj3oRLI+3MiIYCOvAmtR00DYXV
	 sh3NAkCjtms2RuWQfj9DwTb9ps4RnOuvXyciAnpGiLtmML9svoCiiF5POQVUo3MCmMoos
	 MW02Zx82y8EiuymLLCAjqvaz/xrh8kZB60jqshQ2XFb/P2W7/BZUVRP0edbk0iAsFHg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790602957;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=4FBU7MjnPu8D8trIBjIvXLN/GZDwsgsyszMPS7uIuy8=;
	b=esssZe8xKjQglCD9tfIqIIfxkxt5n6M7y78hMbkgTTVPalWc1M/py/iyGu+QUcfNIF29
	 WhFiBcSVj/cXN+0KaqBggF/mdgzs1D3vcR5DED7gUZWyKb+1gt96gALZTS2NeHKDumxeX
	 g7XqcEXgBOrI0XCv3wvS0wg434CRQIgDtxEN3LPnI76GRtionrM7kT/Cy6jsoKnpJVysB
	 xsiw7oZVuWne7AjyN1CnlizH7SQkiqhulXu4/Yd4kgBV+5eqmYCp0S5OmKnWEUhq8XdSy
	 ts0siM+5ZUwe73ohcYnSJOnZvUkkk0/gpIJE4cnW03WX7JTDgMUAtRz/uk2LSFwqgAg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790602957;
	bh=4FBU7MjnPu8D8trIBjIvXLN/GZDwsgsyszMPS7uIuy8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yedLz7FJH6fvJ1Ii5uQuuwuvskw0qcTpafHgIXc+BTHuGu7A6qrZJEABN0zqqEN2N
	 h/Jsexj7mctAgfqLVLRBbTfHu4YQ8I75npXdm/4osYSAgtS8tq9Vws0CrM4qXYENzN
	 WVITKtXY359ikIfsWe0ECed44x8WUMvIeUy0oLJWvJRf58A91sWg4C4WSmPN6ZQE6E
	 SfpcR/cIIGOYlq8T5ALHJfibn1UtuLEWCt3KSCq7AWngZil9dwlfGGmxDoAEP/gsjr
	 P/9CtL/IrsXafDkm1KLKMrdjoG9I6O6rPtYMJ/k5jon7pn/qQ45j2mxL280pMXjeLT
	 0PqET46mWAd/w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1A06B80F89;
	Mon, 28 Sep 2026 13:42:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4B70672
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 11:05:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 318A44019A
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 11:05:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Yo0XfSh-Vf8T for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 11:05:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 540ED40063
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790593525;
 b=SW54oBfDhrGHGVG64rSPzsSgHjJfdck149HNU3AOmqGeOwcpbPhciPUSuyFrzH2HITXL
 k6khPJXxMXhwtiZ4EGOLyqieQetLu+ymj+UjwqhFNWZOPZqfZHgjuWvAoz0+Ydm3dqTlu
 V7M2TsJjNERUT4UgcgA7VdPow5rZESp2p8iLtrTpakuxT2HUn/r29VVUyG0i712+YiqtO
 MF7JKW1h3e6E+LO3IUwARHyRcIL0KOweIT3IpEES6XWefpFCcf61cq12V70WV15w45K/F
 kO47B5uYptTpIw+OP/ksH6XDGjRNPXwmmir0mnRaFpc4q7RSw6Sh/17ijyUf4NOkIHg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790593525;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Type:Content-Transfer-Encoding;
 bh=4FBU7MjnPu8D8trIBjIvXLN/GZDwsgsyszMPS7uIuy8=;
 b=FutwefbaNT0m55PFkAp348L6z3oMBO++x+TlUHCML8HYNriVOcFPzJXLA196kqPq7jU9
 9DnGV5BKC7c4MtLk2QZVqQ6QzIK9qejElnLBE1Tb4jkZQnc2Totl8y2NenFXUO3XrkpNj
 AEgNl13tAVsyGQpUL98RA5qsIqEYndHh04R3WoU8zOy4ra3S0kJZPlDGif7oIo3C4tjqr
 7PPmqreDDniW5TXpGQUUMaanZGjZ9fCrYPZqzuRBiN9cBSleahka8dh1ZJ/HahGeiCJ1S
 Wm9diFIjLt7qf+mVeIK9STbiYz7ARfuvkbFQExZqt9x3iyrOzH3GnK+FzMawo1LUXsA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=q59C4KRw; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::11; helo=mail-wm2-x11.google.com;
 envelope-from=pepe.schlehofer@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=q59C4KRw
Received: from mail-wm2-x11.google.com (mail-wm2-x11.google.com
 [IPv6:2a00:1450:4864:31::11])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 540ED40063
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 11:05:25 +0000 (UTC)
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49ffe817151so8653895e9.0
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 04:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790593523; x=1791198323;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4FBU7MjnPu8D8trIBjIvXLN/GZDwsgsyszMPS7uIuy8=;
 b=q59C4KRwAht6Zmo4UP7CvQW54XgBwhUc4OQWUittyYKNzBJf0qBbYCzm/uG3tSa/qr
 RvMmgF0iitP+wsllirkGEARcr+krj1ykkHNmPTF0fwrLQ73JSiICQIX252htj9DGvRCk
 TH7CAvPhmD+DCDPFlCBIXJdqMaht2IXtWkIY993NfyzMta1fvsZpMROHza/CTlHDCmGq
 pWaUkr+qQoTFYAzHW1RtNiw/lJvQrcKLZi+VPUQu1QJ7ee+Gt21jaedEb3AcaI7RK6GC
 7M3lGGe0tNvHsnXE/sgddMi24TBhPuoyBlbeeyDq1t9jhVNgLZWTARZKCZqHS/YfPvhl
 0/6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790593523; x=1791198323;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4FBU7MjnPu8D8trIBjIvXLN/GZDwsgsyszMPS7uIuy8=;
 b=k7ymkgNRn8H93GW8poWzHzd+joaKCVp/pXZ2QVORzEn4bW/d2cQCVk04EnyJa+sPWT
 HziIfFbAnyxLFKOiYaZxOULI4Did6xJ0Kn7Nf9zdDAgGTHy33tJSi32c5Lj7cjrvmJF2
 Jv9q7Vt6mBVzAAUoTEHeiEN6rfBs2Jjk7rn6S9CjB9hrGcxT5Naw6OtXBPIh3Z/mQWZK
 kuuZtOUURcdiCRjd1GNJxCylLAHig5nCoKObh04SgUqTAg06YvI+MimpjOtD9WLMFf3T
 ZU8FO9VTa2hIGPj1kSsApcuOu71hjG+/pHqu7UA8bT9TuuoIW0xBGu0ymiw+4BAtUyVD
 LhIA==
X-Gm-Message-State: AFuF++nLuWJHgfDaGX1T2cEJUgQit09DUg03Jb0DDNrTGh8p7rIMXJ1O
 2dg3XVlbbC5JeHZV3oWpJlywgtif5h+us5j3QOq/ghQn0YQLze8sKNQn5bYvHlrNuN8=
X-Gm-Gg: AYBFou1qIHznQ/Hu0zPTYdBxVPTbIZcFRHBOXy7I98HvUDuUqOTfn1442SZRuElMxCe
 720/zagHF26h/3q57Jya7r33yvZODE3SF1MLyL1DPDgTK26YCaRxgMx2VO+z4h4mrsBsWL+41ij
 p3hjBCD89i1zCFAh6hDW/9W+gZOnaPTbtdxN1xB1Wx2U8fo6jyNbjLGnNAPw8KbtUwng9l6Al/D
 71kw99YZr8dwniulSXLgm8D5vwG1lFf8zQYfSyPEoo8vSVDwEN5tLOR9VfnhiF4kMiMQErZRo9m
 erKuwMI1/iQUWzi8XUNnoBTTKTJU1icuwpyZebs7XNrPr7XoLwc73qQWQBv/XIP2t+1xDzd/3IG
 zKhDSqSm7scl0bjrk1vc/htilEa3c5RYUxdVi8APrnMhAzl0+wSoaTvQAT59en1tLV5cmgwVaWu
 kEAVNDWkts5Yf60O5P8nkPOe/V8XFejvLKSApVAGcUNDOUtbC4IKTsZg8dxmPIsi1SnpYhAQdLu
 9ZhbGZJDXvY7gVERHPy+VnKyDWNvDqAUBs1r5jOsvmk2GJxPAzZJw5tnw8yX2xj+QelkNPZXmmU
 IgWqc3ja7n23y7IPiEaPBWxvy4+H0SixOw+ixLmC
X-Received: by 2002:a05:600c:4ec7:b0:49f:ff6b:bc82 with SMTP id
 5b1f17b1804b1-49fff6bc143mr78077345e9.20.1790593523251; 
 Mon, 28 Sep 2026 04:05:23 -0700 (PDT)
Received: from localhost.localdomain (37-188-186-98.red.o2.cz. [37.188.186.98])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a0017816efsm131458075e9.9.2026.09.28.04.05.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 28 Sep 2026 04:05:22 -0700 (PDT)
From: Josef Schlehofer <pepe.schlehofer@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 =?UTF-8?q?Marek=20Moj=C3=ADk?= <marek.mojik@nic.cz>,
 Peng Fan <peng.fan@nxp.com>,
 =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
 Priyanka Jain <priyanka.jain@nxp.com>, Qiang Zhao <qiang.zhao@nxp.com>,
 Shengzhou Liu <Shengzhou.Liu@nxp.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Christophe Leroy <chleroy@kernel.org>, Mario Six <mario.six@gdsys.cc>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Heiko Schocher <hs@nabladev.com>,
 Holger Brunck <holger.brunck@hitachienergy.com>,
 Simon Glass <sjg@chromium.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Subject: [PATCH next 10/13] mtd: rawnand: fsl_elbc: Select NAND_ECC_BCH
Date: Mon, 28 Sep 2026 13:04:31 +0200
Message-ID: <20260928110434.70686-11-pepe.schlehofer@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260928110434.70686-1-pepe.schlehofer@gmail.com>
References: <20260928110434.70686-1-pepe.schlehofer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 28 Sep 2026 13:41:44 +0000
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

The CZ.NIC Turris 1.x device tree asks the eLBC FCM NAND driver for
software BCH. Without CONFIG_NAND_ECC_BCH, nand_scan_tail() reaches
BUG() while probing the NAND chip and the board resets:

  BUG at drivers/mtd/nand/raw/nand_base.c:5074/nand_scan_tail()!

This broke with commit b182816c1fb4 ("turris_1x: Normalize Kconfig
usage"), which moved the board Kconfig defaults to the defconfigs.
NAND_ECC_BCH has no prompt, so a defconfig cannot set it.

Make NAND_FSL_ELBC_DT select NAND_ECC_BCH and NAND_ECC_BCH select BCH,
and drop the now redundant CONFIG_BCH=y from the turris_1x and
kmcoge5ne defconfigs. This comes after enabling LTO on the Turris 1.x:
without LTO, the turris_1x_sdcard u-boot.bin with the BCH code would
exceed the 1 MiB its SPL loads from the card.

Tested on CZ.NIC Turris 1.1.

Fixes: b182816c1fb4 ("turris_1x: Normalize Kconfig usage")
Signed-off-by: Josef Schlehofer <pepe.schlehofer@gmail.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Heiko Schocher <hs@nabladev.com>
Cc: Michael Trimarchi <michael@amarulasolutions.com>
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: Holger Brunck <holger.brunck@hitachienergy.com>
Cc: Priyanka Jain <priyanka.jain@nxp.com>
Cc: Marek Mojík <marek.mojik@nic.cz>
---
Only the two Turris 1.x defconfigs enable NAND_FSL_ELBC_DT, so the ECC
of no other board changes. The build does not catch an SD card image
that is too large: here BOARD_SIZE_CHECK covers only u-boot-nodtb.bin,
while the SPL loads a fixed 1 MiB of u-boot.bin, device tree included.
That is left for a follow-up.
---
 configs/kmcoge5ne_defconfig        | 1 -
 configs/turris_1x_nor_defconfig    | 1 -
 configs/turris_1x_sdcard_defconfig | 1 -
 drivers/mtd/nand/raw/Kconfig       | 2 ++
 4 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/configs/kmcoge5ne_defconfig b/configs/kmcoge5ne_defconfig
index 69ef6cf3b9b..ef03f02d1e5 100644
--- a/configs/kmcoge5ne_defconfig
+++ b/configs/kmcoge5ne_defconfig
@@ -200,5 +200,4 @@ CONFIG_QE_UEC=y
 # CONFIG_PINCTRL_FULL is not set
 CONFIG_QE=y
 CONFIG_SYS_NS16550=y
-CONFIG_BCH=y
 CONFIG_POST=y
diff --git a/configs/turris_1x_nor_defconfig b/configs/turris_1x_nor_defconfig
index d8ce4aed4a7..35df37fbc70 100644
--- a/configs/turris_1x_nor_defconfig
+++ b/configs/turris_1x_nor_defconfig
@@ -119,5 +119,4 @@ CONFIG_USB_EHCI_FSL=y
 CONFIG_USB_STORAGE=y
 CONFIG_WDT=y
 CONFIG_WDT_MAX6370=y
-CONFIG_BCH=y
 # CONFIG_BINMAN_FDT is not set
diff --git a/configs/turris_1x_sdcard_defconfig b/configs/turris_1x_sdcard_defconfig
index 982a6cb0703..5e99d895b2f 100644
--- a/configs/turris_1x_sdcard_defconfig
+++ b/configs/turris_1x_sdcard_defconfig
@@ -151,4 +151,3 @@ CONFIG_USB_EHCI_FSL=y
 CONFIG_WDT=y
 CONFIG_WDT_MAX6370=y
 CONFIG_FAT_WRITE=y
-CONFIG_BCH=y
diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
index b5dfad7380f..52c6520bb2f 100644
--- a/drivers/mtd/nand/raw/Kconfig
+++ b/drivers/mtd/nand/raw/Kconfig
@@ -241,6 +241,7 @@ config NAND_FSL_ELBC
 config NAND_FSL_ELBC_DT
 	bool "Support Freescale Enhanced Local Bus Controller FCM NAND driver (DT mode)"
 	depends on NAND_FSL_ELBC
+	select NAND_ECC_BCH
 
 config NAND_FSL_IFC
 	bool "Support Freescale Integrated Flash Controller NAND driver"
@@ -260,6 +261,7 @@ config NAND_KIRKWOOD
 
 config NAND_ECC_BCH
 	bool
+	select BCH
 
 config NAND_KMETER1
 	bool "Support KMETER1 NAND controller"
-- 
2.54.0 (Apple Git-157)

