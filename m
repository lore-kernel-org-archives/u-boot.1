Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C58AFCA5FA2
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 13:42:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8D9F3809F5;
	Mon, 28 Sep 2026 13:42:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XwHJmFbQARQP; Mon, 28 Sep 2026 13:42:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org CD4E880EC9
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790602932;
	b=XFRxKc20ozbYxkoY/1+7D1vDBgnIUS/7c80AE54U4/LPs4QK1sp0xL1fH+rOYD178s7k
	 jBAhXqiFtLWlPuj1PjsHMBXWBEzECDjl1ZkA8C8KIXjWUmRyOu3FoJGqeQ3FZkCpArw83
	 mnrquH2tTkmQeDmPduhS5OdQd0Qp7kg5z1dArnWCI2hPj0FSkCReta4PkuHvNJzpt6bzE
	 oSVN10ZpHYOcS2RYTo7QLnkmngM+Y/OLqG4XsW515Bo7LZSV3kpmvPTO67WLoqeXS1r8X
	 6fgEmaUEqBcf44qKafLyPpThtNH57YKnXRzLnaPQwz2dzv+7oqHjuQ81znGq+bmT2ag==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790602932;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=GK4e7B3SSK/xUvOEaxKl690Hm1WbcUBX4wWx0aCmY3s=;
	b=EDH71EIFQAnVasMhz4LP/FVZZ8C0e/WToThqBW48OLOKpzwSNAy5mlHWFXrTQ/XnHJs0
	 C3PJwOhhsFLEo/rYsKR+sgPQPhOvup85SfjJWUmxAslP8RF1ZoQxZ5w85VCx/1cBamZh3
	 1A5YUIzCq6DynGluhN6kd9d9GWh97Yrr6uF7IMmyeO3tDSXYf0gluHwMu3m6gBs2UsY6S
	 VxXx3QXgx7Hp2VTq4/pBvdRNE6qegzuqnRKO6mS3XfK5ZdWEVO6Do6vLpOxAK4847I6FJ
	 2v8tx/IVNP58krgMqNVV8h8XVwC6qDMslk1+H4jrxT686UcQ/o1J4AHi8JlLYP8pY2A==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790602932;
	bh=GK4e7B3SSK/xUvOEaxKl690Hm1WbcUBX4wWx0aCmY3s=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=GmrA1PwB0GNSlldVXSBvwvBSW1G9s8mAThbYEAS3fBomiYUrKzTnkjhi3kQnSh97C
	 DNmnjakhimT0ZFX92Y5Zda/itRhd+s5P29ydoztBixskkHIfT+1Nk2inHECUHoMMbL
	 /MZIzsjrmzWYosT7JJfx16G8cIXPFKu5E/lektKMzftE6VceEM+R9ibcy38kt2h4JU
	 rMPAqbZ1I8pJ6JYon57N9EGwLpeOUyRvag8rMVkR7Ca5g7X+wasSiS6L8hWd7ORRvW
	 w/kmLG3Qj30wvDHBHzgbHxo3xlKEuoeZ4HkmZqM0f38S9HC0bhScaOreBCFyaousAN
	 Os8kMCgvTc4EQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CD4E880EC9;
	Mon, 28 Sep 2026 13:42:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id C53333D8
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 11:04:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B687A60601
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 11:04:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id igp8f7GRjQSH for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 11:04:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 6C74F605E4
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790593483;
 b=ZgE491Tky6E3W+DMATyczkpYR4D22lj4QTbC/ZbLuC4XMNcXacZMCBtWcavd024qizI/
 /vYWRDHp3U4Y06a9UbOunmvTA2rhCRp2KIHGVQI3w0zmk63YSuacmEQMnMXA1592RI/he
 3GtPZqvHKLxs8okYgKsygEr3cG7PwdX+Lxy8Ncqd2kX4ScbsIZljjc2Mn36Ex/8OpiQe5
 qKe0ZX9PX9a5hNDkimbOGYonQG/TrkYcYlTa9ccYZzzkiZUk+5sHW4ij8586Q7oORyIga
 atiCswN12KpfoQdZQSf87bsNlVOQCm27gpu2ZA9gfWhMufY57M7j2ucJN/DEvJ5LpTg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790593483;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
 Content-Transfer-Encoding;
 bh=GK4e7B3SSK/xUvOEaxKl690Hm1WbcUBX4wWx0aCmY3s=;
 b=CYMwXBz0QciT9NR5c9ChMGNVKCOn/V13PIp7j7Bll+lvoTtoQ3yFDc2cMu4tAgmO6+gA
 PwhmvJ5pJfsj5NyqvlPdx0J/+52OA8eROGZorqT/UIZh04yYAMEl3bUMZGFdY8OHuhcEN
 nPaRxAoJ4xXk7LhI3euhtuj51wlu2u6lUaD3sjKTy1tbamvaT4xca9ZzNtyZPwnNI9yUm
 lXYansKkg+o8LhesW5f1Y2B0M5FpFgpOnjMVo61vDFZIH+jERmqIFTtnOxIT4w4FbIeNp
 RW9cSqp2xa8f1TA+oUX8rv4Fb5drWyubVXB9RoqsvEVCB2g8UsdD/A19Ne3z/lC+dPQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=nCqjW03q; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com;
 envelope-from=pepe.schlehofer@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=nCqjW03q
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6C74F605E4
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 11:04:42 +0000 (UTC)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49ffe281cb1so9970315e9.1
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 04:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790593481; x=1791198281;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=GK4e7B3SSK/xUvOEaxKl690Hm1WbcUBX4wWx0aCmY3s=;
 b=nCqjW03q/FGGMNHQMLUqpzXSSMgeJVm/fECeskHclM2xelTfgGcLi4FuBYZYeBwMCH
 b1YjkpQv+75ytqVF76kN6d5Ij45lFDtnwdwB4YCrBxKx0gPfE23d0ZKFTAdhmR4HPc6w
 55jCPVPn8FOmcuOaQ23hBqBnCmLtYGHURO88aurbGeOAgfBBxxrSKbPrWglp/wm9hfDk
 mC3zqLuZpRZ+i5nQKBOgruAPxGq5uQehdtdMKYWNt6P38YSqFyqaC+Su0Y0gwTC1dBo3
 aVwsvK+Y59zUBECere+B9R6MYFegn+R96f4er1q2r+mNHCT6n7J2khZNXS7ASNVGs9A7
 jdqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790593481; x=1791198281;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=GK4e7B3SSK/xUvOEaxKl690Hm1WbcUBX4wWx0aCmY3s=;
 b=LGogrVOweu+rlAb+dkolzLVCYUsdd/fU8IHt/c12DA0YcWNkJ4lUYkFlqzxMywWpZc
 ftGifjmOvD6d7bafDGlWlNqCQtp/FdcuhqAfyhmHbJb+PRQ1nw06dDP1XeFlFe9uo66o
 8oXhrR6iioXcGbG7VQdP6Ju/8lUdNV1uW+wc5EXV/7G820B11S/nX3nufmr5FznPJXR0
 c61FjMBIFPtO8oD14AJrYXmqu9YQ0RpDuiQIkWtoO343MSgjRJdGUzo6ufd89tZvvVcR
 3Rvpu+CrKQfEhU2aPHVGq/1wDcYor5BMuX1nQCbZ+qJTOWGmWt21NdO4rKO2Dhtjzjnr
 mn+w==
X-Gm-Message-State: AFuF++l7TnHZWIVqiNEo/U2UxZjdOPpxxVG+ggFxg2GlZ5S8bO2Qo0yL
 r0US/KdCNXTZqwd5U+/d8wIC410TFTAub1IWIlB6iJIF+v2mHZbH/5th8OC/6Q4IOf4=
X-Gm-Gg: AYBFou0Ho8l7hf2l8cDFiqUzgGBMJatGWBrJKXLl5UlsU8Nya/PrYJlWOvW3iM2uyRV
 rNDmhanVWcoOLQJdMuI4y9Rk5FAsE3Eef6pG9aX1VpTFJcP4AfywTYSrCRsEt6mzjAqbyXj17Sh
 WKyDQR5/CjeAwEB2gjo6SMyRs0MMNsLzGCPYBM7HC4LBEGIVrtp5aHBphbws916cuDr+7XTcVDM
 WqC4pLW0h4kf/lBtmbQd7mQtzE4fZ/JdmM2C21jGJbEppwN7PiG2Wr2NzXR1DdAmd5+/pfTbczN
 cxtZINu4ortgvyV2BqE3niJ8NDYLZTVDQSTLBdFnTycoH778O5ImIo7y2ys1A60eVVjHaqP4dnh
 fR3mi86za9xoK6BEkBAg+SzoljejxnvUDu5McVB4vG3i6tWLoM/4mSGU/KsXuHrnVGS6NCfOqsP
 5mr+7CW1g7o9cUH4TGftqiTI+G8K/BaiE2IrPZh3glDWjWOtwf3xInlBAE29bUHXr8fSDOHcDCE
 gE0TBuEK2PC/NTZGODx+tIfHrsmPgkPyIdHG71iQm6WvwTnYg4TjXf1IC1FdvgfdKxsZ2vB8oV0
 ZMsIM9fkQRE6Z43h1bCx8hBRuBp9JxoHUWh3+XAE
X-Received: by 2002:a05:600c:3550:b0:49f:fd40:80fa with SMTP id
 5b1f17b1804b1-49ffd408357mr87871865e9.34.1790593480453; 
 Mon, 28 Sep 2026 04:04:40 -0700 (PDT)
Received: from localhost.localdomain (37-188-186-98.red.o2.cz. [37.188.186.98])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a0017816efsm131458075e9.9.2026.09.28.04.04.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 28 Sep 2026 04:04:39 -0700 (PDT)
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
Subject: [PATCH next 00/13] powerpc: Enable LTO on mpc85xx
Date: Mon, 28 Sep 2026 13:04:21 +0200
Message-ID: <20260928110434.70686-1-pepe.schlehofer@gmail.com>
X-Mailer: git-send-email 2.54.0
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

This series allows LTO on mpc85xx and enables it for the CZ.NIC
Turris 1.x, whose NOR image has a 768 KiB limit. LTO, together with
dropping NVMe and SCSI from the NOR build, makes room for the ubi
command and the BCH ECC code that the Turris NAND needs.

The series consists of:

1-3. Generic LTO link fixes:
- skip undefined symbols in the generated keep-syms file;
- keep a toolchain libgcc out of --whole-archive;
- avoid the implicit -pie added by default-PIE toolchains.

4-5. PowerPC global data:
- drop an unused SPL copy of gd;
- make the global data pointer usable with LTO. This also converts
  the remaining direct PowerPC gd assignments to set_gd().

6-8. mpc85xx LTO support:
- discard the LTO keep-syms section and its fixups from the image;
- allow CONFIG_LTO=y on mpc85xx;
- pass the make jobserver to the SPL/TPL link, as GCC 12's
  lto-wrapper requires.

9-13. Turris 1.x:
- enable LTO;
- select the BCH ECC code that the NAND needs;
- make the NVMe and SCSI boot targets conditional;
- add the ubi command to the NOR build;
- put the OTP MAC addresses and serial number into the kernel device
  tree also when the environment was reset.

Patch 13 adds a weak hook to the P1/P2 RDB board code that Turris 1.x
shares, since an EVT_FT_FIXUP spy is never called for the kernel device
tree on this board.

Why next: patches 1-3 change the link of the existing LTO boards and
are therefore meant for next, although they carry Fixes: tags. Patch 10
is a fix too: without it, U-Boot hits BUG() at the NAND probe. On main
it helps only turris_1x_nor, as the turris_1x_sdcard u-boot.bin with the
BCH code exceeds the 1 MiB its SPL loads from the card, which the build
does not catch; with LTO (patch 9) both fit. Patch 13 is of no use
without patch 10.

With Debian's GCC 14.2, turris_1x_nor u-boot-nodtb.bin goes from 757072
to 754920 bytes while gaining LTO, the BCH code and the ubi command and
dropping NVMe and SCSI, and turris_1x_sdcard u-boot.bin from 1047795 to
996899 bytes. Both images fit their size limits.

All 83 PowerPC boards build with the series, and all 71 mpc85xx boards
link with CONFIG_LTO=y. The 39 ARM defconfigs that set CONFIG_LTO=y and
sandbox were also built before and after patches 1-3. No .discard*
section and no zero fixup entry is left in the LTO images. test.py on
qemu-ppce500 gives the same results before and after the series, also
with CONFIG_LTO=y; the one failing timing test fails on next as well.
With the kernel.org GCC 14.2 that CI uses, both Turris 1.x LTO builds
fit. With Debian's GCC 12.2 and make 4.3, the Turris SD card SPL links
at -j8 only with patch 8.

A Turris 1.x also needs two patches of the fixes series for main, the
SPD read and the mpc85xx alignment padding:
https://lore.kernel.org/u-boot/20260928083820.62352-1-pepe.schlehofer@gmail.com/

Boot tested on a Turris 1.1 together with the fixes series, from NOR
and from the SD card. The NOR build also booted OpenWrt from the kernel
UBI volume on the NAND. Linux got the OTP MAC addresses and serial
number also after "env default -a", and with the SD card build, an
ethaddr and a serial# set in the environment were kept. The other
boards are build tested only.

Josef Schlehofer (13):
  Makefile: Skip undefined symbols in keep-syms-lto.c
  Makefile: Link a toolchain libgcc outside --whole-archive with LTO
  Makefile: Pass -static to the LTO link
  board: nxp: p1_p2_rdb_pc, p1010rdb: Drop unused SPL gd copy
  powerpc: Make the global data pointer LTO safe
  powerpc: mpc85xx: Discard LTO keep-syms sections
  powerpc: mpc85xx: Allow LTO
  xpl: Pass the make jobserver to the xPL link
  configs: turris_1x: Enable LTO
  mtd: rawnand: fsl_elbc: Select NAND_ECC_BCH
  board: CZ.NIC: turris_1x: Make NVMe and SCSI boot targets conditional
  configs: turris_1x_nor: Enable CMD_UBI, drop NVMe and SCSI
  board: CZ.NIC: turris_1x: Fix up MACs and serial number from OTP

 Makefile                                  | 12 +++++++--
 arch/powerpc/Kconfig                      |  1 +
 arch/powerpc/cpu/mpc83xx/cpu_init.c       |  3 +--
 arch/powerpc/cpu/mpc83xx/spl_minimal.c    |  3 +--
 arch/powerpc/cpu/mpc85xx/cpu_init_early.c |  3 +--
 arch/powerpc/cpu/mpc85xx/u-boot-spl.lds   | 11 ++++++++-
 arch/powerpc/cpu/mpc85xx/u-boot.lds       | 11 ++++++++-
 arch/powerpc/include/asm/global_data.h    | 30 +++++++++++++++++++++++
 arch/powerpc/lib/Makefile                 |  1 +
 arch/powerpc/lib/gd.c                     | 14 +++++++++++
 board/CZ.NIC/turris_1x/turris_1x.c        | 20 +++++++++++++++
 board/nxp/p1010rdb/spl.c                  |  9 +------
 board/nxp/p1010rdb/spl_minimal.c          |  2 +-
 board/nxp/p1_p2_rdb_pc/p1_p2_rdb_pc.c     |  3 +++
 board/nxp/p1_p2_rdb_pc/spl.c              |  9 +------
 board/nxp/p1_p2_rdb_pc/spl_minimal.c      |  2 +-
 board/nxp/t102xrdb/spl.c                  |  4 +--
 board/nxp/t104xrdb/spl.c                  |  4 +--
 board/nxp/t208xqds/spl.c                  |  4 +--
 board/nxp/t208xrdb/spl.c                  |  4 +--
 board/nxp/t4rdb/spl.c                     |  4 +--
 common/board_r.c                          |  2 +-
 common/init/board_init.c                  |  9 ++++---
 common/spl/spl.c                          |  4 ++-
 configs/kmcoge5ne_defconfig               |  1 -
 configs/turris_1x_nor_defconfig           | 10 +++-----
 configs/turris_1x_sdcard_defconfig        |  2 +-
 doc/build/gcc.rst                         |  6 ++---
 drivers/mtd/nand/raw/Kconfig              |  2 ++
 include/configs/turris_1x.h               | 20 ++++++++++++---
 scripts/Makefile.xpl                      | 12 ++++++---
 31 files changed, 159 insertions(+), 63 deletions(-)
 create mode 100644 arch/powerpc/lib/gd.c


base-commit: 951132236b9adc592c2e49faadd103c6a355cac3
prerequisite-patch-id: c2cc988027a3f33da10e9d5e1f437c590fa32ad8
prerequisite-patch-id: a4fac862dc6152c7663a15e01be1307613627ca5
prerequisite-patch-id: 8208f6e784698a3a3e04a308f23ebdb7cc431156
-- 
2.54.0 (Apple Git-157)

