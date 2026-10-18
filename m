Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D0D8CCF2C9
	for <u-boot@archiver.kernel.org>; Sun, 18 Oct 2026 08:35:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1AAC460600;
	Sun, 18 Oct 2026 08:35:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Cc6ogte2chPP; Sun, 18 Oct 2026 08:35:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0C6E060613
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792312528;
	b=CcQ0jpCSDZIQh7ULzRuqCby7i8de00zGra9UG99BWb8SClWISmZ6siHqSR0afuB6MXPm
	 sxBAwkU+g+sa90Om0YFj5zii+nU44GxUEt+lxTtmCZ8jyyeBzGCpXtL4qhDbSFVSnFO5p
	 9y9Wf6vHGxLzzS06++icvf0gVUbjjEi80XCwgNFw2W5Ja7Y6F6nuecU95RUFqU5cUoLYv
	 LK+eQhmTB8PH4mEaRWcQBsxKJ5+4EcXy4ev2zKRbSUk0adVwqe3TgbgSm70j3Q0edb9Qn
	 Ayuc7E8xVESxfXlJFASp9M+9rXdwYYawbzcBHLUP0q0LTqmRcBznATeKDOYVlwPmIag==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792312528;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=AE86frGH8Bk+nzLv47w8hkYv6zyCsiE5aemk9XjNi8Y=;
	b=sgK+OfZh/YrS7YOpR8ROyreeubN3hBwbHq8HeLOwWCYerzbkSjF50kfjbFQUZE0U3Q/t
	 6IEqc99LfcRwmn0uDUutpa0G60sv+X1vS4SKD/ifna0JJpdliv1WneNE8xPgytx0GSOuS
	 B/MbrL6bw9IXFK7+2tPg0WyDHZ1ubCm5ujiH9Hk2gSsm/cq5kEfSlRSo5ML7hrI3nqt8h
	 kdipam1KIvlQpJ0+oqfSLJ/AWXZUPbaT+BLSqUuTm7PvZCMJa/mumn9J3bd3swfina0H6
	 e8m0HxSkEUQZMCUyyv/fsH54CAr4dtXFh2GTyXNDHcUjEXIK1BeHyy671crTgk29nhw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792312528;
	bh=AE86frGH8Bk+nzLv47w8hkYv6zyCsiE5aemk9XjNi8Y=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=SoYNFSTu3s+YfyBcZV/MZrrv7vFpJyk5IOb+FuvRWfsKEPis9hTrTmPwhdmULgBzI
	 Oydylf03Qm3oeM+ZzwZfVDZXSbg+95KCMIN/4xkW1JTLCPhVi6UudP+DmVKZQgb4+V
	 n23Jg5QDF6+JMLPSANjQUP2oc2JspMtjffzRPTiiDI2PtNLS3MhV+P95yK+0SeO0Xb
	 LwCaJ9CycPYbJZkzfEBDUj7WbBgVEp6nLrrDLNtncwBbzbOxfV/VXQlxCo6nmjvK6z
	 gyQCAKmFermTqRw8cpIP6RvN9sXYENTCYCBYJn5OikG410XnlZg2p71p3YEvq1csZL
	 IXixbxsnOiHIA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0C6E060613;
	Sun, 18 Oct 2026 08:35:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5509575
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 08:35:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3AB734091C
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 08:35:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lmNU32tmqqBK for <u-boot@lists.u-boot-project.org>;
 Sun, 18 Oct 2026 08:35:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org BA42640856
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792312525;
 b=IKqeD0J1Z8DhDfaIr6sYitIO8P+eG6YrJf1YC2Ba+NNrbz7VUmlaz7RjEMfeSLD0c/Kp
 1ydSoy2PNWuj2hEoJmryCNprgO7LPTwEgmZxOYErwCGWDTQ3y+R81jiG1BlNd/kZLEX2p
 QUhM1PaBsGzJeZDkLQS1nDMtgFqGnZprDH6BXfkuXEL80Q4XMcate4Jbreib+jfhucSzR
 g00q2X0CZfs+63y2w4tbFgxZIQ23sHC6CRxY+FQ2Qva+ChFjg8igcaYjgD7dsyF2WWuwL
 4Em5o1xDFgYvRITkBmvLbvfUCwwQEBecFT6n6oZJXbXRk108VXVAPdAji5Ah4MPG5EA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792312525;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
 Content-Transfer-Encoding;
 bh=AE86frGH8Bk+nzLv47w8hkYv6zyCsiE5aemk9XjNi8Y=;
 b=BBAkhE0KcX1BZNmqfLe2wj4FtPmSzbCRaI42wbn2y85X3ToO6eSifMCQq9zpD1wwdIAO
 0o+amKY96YfcyQXeX0cJkLwraEBMsPeYJLsfhY5kOieGJnhneLs85bu1JVFhYx5VWRJzy
 TQA9DFBfdguqRMSp5E7uyG+s651MjtpIaWHmFAY/RINJwh2qaG2EtREDGSxo7NnQBM96N
 GiL7Ia9S39YhJZ8ANKlCUrAEuY38VXFzECB/COlIc9p56E8741kHKqyzOKR07u5VDC79Q
 GPXE2S5ZPrij6i2hbDzfikR7GGS+60Af8COvDJm/6fBCxzthlrOpoUh28jFOdaBqAhg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=RGRKRhXc; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32f; helo=mail-wm1-x32f.google.com;
 envelope-from=pepe.schlehofer@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=RGRKRhXc
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BA42640856
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 08:35:24 +0000 (UTC)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4a19cba5c14so12649175e9.3
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 01:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792312522; x=1792917322;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=AE86frGH8Bk+nzLv47w8hkYv6zyCsiE5aemk9XjNi8Y=;
 b=RGRKRhXclMemOAhG0PmEuB8mS+P9haJLfTeYx+05O85olK5INz65Q0PP6Xdws3WOCh
 n4bLOm5IFWekbjR6FLzPxT7GaXnFO+cVk6Nb27kksIKtRCmmpQeHpXDY+1YbxDyG4iBe
 9eSioHVZRTSJD1rOjzFbT867qwo+Sz0KAJLEncpDC4SP4SJIxNrEA0+Zzg/ISKJxUw0g
 Vkrbrv06yiLOFqUmllUVWNZ8BhINp1KBzM+PWj64/rP3k/RbrAJX7bOo8JXRgPGOWVrh
 kvOfft7JP81xM4P9pOkNf3NFVoALx9n2o8poTLTy5C/+pVyO/RoaenY8g9pGKwh4vHnO
 s4EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792312522; x=1792917322;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=AE86frGH8Bk+nzLv47w8hkYv6zyCsiE5aemk9XjNi8Y=;
 b=t0uVkDGOXPCAFAfRnWHcYs5ABJuiwQmcKXRDhjEQ26avtuijwzCDLww4bizJzlkWY5
 G1qShtZ1bxZpqwwAYafOHEt1Vv46YBB4WEvGBSA4X3RHdK1PZsRwSzqrd+Wlekxi+v6E
 qv2+aIeiKKddq8oV3kP9uzzMVpnB+FyhPOD97bKw4hUWMI9oyje1xnaWwIXBwMUmGA4E
 EgQBGrqSLXE6bYK/sQapky+jQUPyhJP05ueN2Cd0p7UUJDLY/iXTPiFhBXwxtWO6zAwq
 MfnDry04WssGYQ8c3l4POUYSJw0SACudAXyoEC3ZdBiVOZYNdIKXeXDqyPMG3N1NV9Ee
 0seg==
X-Gm-Message-State: AFq9FYJcksXp7W6NBkvB16fCO3E+K4BsPArYS2zZT4qy4ZI5LiPA+5g3
 VxWaBxywY7CREcWr40olyVyBtFhhCTKfpPZJIvvVK4GYe0rAxhhXbSSAfLE/R2su
X-Gm-Gg: AYBFou2aGNhgsU4SSt3dDljoJfvFkbndfnObiu9T65fNiGhUbAK1p4Z9EqCuk6iBYk0
 igCYsTwDHsN/vBWMd+rdq+QObl3isTz+qOkURdJbQifB4GJL5A2pcFrUIKbdo2zzjvrM5m0bmX3
 B4inZPPFyjbDQKMmPQhW4JEfwB+EoSNIvaqd0xiPsobWmHlrCnoXtvJhgx2/uge0ZNbWtzHkqvj
 xlQ0YTZKTAK2hbevWv/PE46Xd3uhcHtlfAM3fy7KyzcCxFFbbpkDEn3W/OhOnLHW4A34JfJbqnc
 nxb9NJaaqKWdFXuldS4XZUCYAsGv4LVH3zLcPyQA9nqSgIcHaJAsZKBEAodjLsjjaDULbou9P5i
 N2vqN7qkKtN3aZR97jQiPFDYB2SeQ1IVBD4JFl5fmM20IiDD/Xn2lV25Nf2kQRVWmrXETtMnrfD
 NtS8eva7iK4CV8DKhp7hcdB2foedFylFoxEjz/PeJxoye9s9KxFyXsV8GDVS3zk7HGOV3jpIbDZ
 9htFfmnyQMOtnkXsW+7/34khTiMILI/bZWAwoynu4Z0OGEKaRqTf23aPGgncA/7LqYa8YPwpD3X
 dCvTPWmIMh5UFqvSZLiDcpcWP2s/ZEjSTtxb6op9tR0FpdD/mvTmZHCRAuzNvjgmTDkdG2EASoD
 V6PpfIpVmNSfTYA7G8hzuAZY=
X-Received: by 2002:a05:600c:3555:b0:4a1:d52e:c2d9 with SMTP id
 5b1f17b1804b1-4a1d762c1bdmr88118055e9.23.1792312521901; 
 Sun, 18 Oct 2026 01:35:21 -0700 (PDT)
Received: from localhost.localdomain
 (dynamic-2a00-1028-8388-a84e-318a-f58b-5e43-a2b9.ipv6.o2.cz.
 [2a00:1028:8388:a84e:318a:f58b:5e43:a2b9])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1e3ebb3aasm43589595e9.0.2026.10.18.01.35.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 18 Oct 2026 01:35:21 -0700 (PDT)
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
Subject: [PATCH v2 00/14] powerpc: Enable LTO on mpc85xx
Date: Sun, 18 Oct 2026 10:35:02 +0200
Message-ID: <20261018083516.49229-1-pepe.schlehofer@gmail.com>
X-Mailer: git-send-email 2.54.0
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

This series allows LTO on mpc85xx and enables it for the CZ.NIC
Turris 1.x. The Turris NOR image is limited to 768 KiB. LTO, together
with dropping NVMe and SCSI from the NOR build, makes room for the ubi
command and the BCH ECC code required by the NAND.

The series depends on two generic LTO fixes sent separately, as
requested in the v1 review [1]:
- "Makefile: Pass -static to the LTO link" [2], which fixes the LTO
  link with default-PIE toolchains such as Debian's GCC.
- "Makefile: Set LTO_ENABLE before including config.mk" (2/2 of [3]),
  which makes patch 7 effective.

The series consists of:

1-2. PowerPC global data:
- Drop an unused SPL copy of gd.
- Make the global data pointer LTO-safe.

3-5. PowerPC private libgcc:
- Add GCC's out-of-line register save and restore routines from Linux.
- Add 64-bit division routines.
- Select the private libgcc for mpc85xx LTO builds, as the LTO link
  puts it inside --whole-archive, where a toolchain libgcc does not
  link.

6-9. mpc85xx LTO support:
- Discard the LTO keep-syms section and its fixups.
- Drop -ffunction-sections and -fdata-sections with LTO, as ARM does.
- Allow CONFIG_LTO=y on mpc85xx.
- Pass the make jobserver to xPL links, as GCC 12's lto-wrapper
  requires.

10-14. Turris 1.x:
- Enable LTO.
- Select the BCH ECC code required by the NAND.
- Make the NVMe and SCSI boot targets conditional.
- Add the ubi command to the NOR build.
- Put the OTP MAC addresses and serial number into the kernel device
  tree also after the environment has been reset.

Since v2026.10, main's turris_1x_sdcard u-boot.bin has grown from
1046491 to 1049419 bytes, exceeding the 1 MiB that its SPL loads
from the card. The build does not catch this. Patch 10 brings the
image back below the limit. Patch 11 fixes a separate problem:
without it, NAND probing hits BUG().

With Debian's GCC 14.2 and the two generic fixes, turris_1x_nor's
u-boot-nodtb.bin shrinks from 757336 to 752000 bytes while gaining
LTO, BCH ECC and the ubi command and dropping NVMe and SCSI. The
turris_1x_sdcard u-boot.bin shrinks from 1049419 to 997059 bytes.

All 83 PowerPC defconfigs build, and all 71 mpc85xx defconfigs link
with CONFIG_LTO=y. No .discard* section or zero fixup entry remains.
test.py on qemu-ppce500 gives the same results as on main, with and
without LTO. The single failing timing test also fails on main. With
the kernel.org GCC 14.2 used by CI, both Turris LTO builds fit. With
Debian's GCC 12.2 and make 4.3, the Turris SD card SPL links at -j8
only with patch 9.

Boot-tested on a Turris 1.1 from NOR and SD card. The NOR build also
booted OpenWrt from a kernel in a UBI volume on NAND. Linux received
the OTP MAC addresses and serial number even after "env default -a".
With the SD card build, ethaddr and serial# values set in the
environment were preserved. Other boards were build-tested only.

Changes in v2:
- Based on main.
- Replace "Makefile: Link a toolchain libgcc outside --whole-archive
  with LTO" with patches 3-5, which make the private libgcc work for
  mpc85xx LTO builds.
- Add patch 7 to drop -ffunction-sections and -fdata-sections with LTO.
- Send "Makefile: Skip undefined symbols in keep-syms-lto.c" [4] and
  "Makefile: Pass -static to the LTO link" separately.
- Explain in patch 10 that the SD card image already exceeds 1 MiB
  without BCH ECC.
- Shorten the commit messages of patches 6 and 9.
- Keep Marek Mojík's Reviewed-by from v1. His Tested-by is not carried
  over because the images have changed.

[1] https://lore.kernel.org/u-boot/20261012190720.GF3722450@bill-the-cat/
[2] https://lore.kernel.org/u-boot/20261013074336.85242-1-pepe.schlehofer@gmail.com/
[3] https://lore.kernel.org/u-boot/cover.1791877299.git.pepe.schlehofer@gmail.com/
[4] https://lore.kernel.org/u-boot/20261013074313.84961-1-pepe.schlehofer@gmail.com/
v1: https://lore.kernel.org/u-boot/20260928110434.70686-1-pepe.schlehofer@gmail.com/

Josef Schlehofer (14):
  board: nxp: p1_p2_rdb_pc, p1010rdb: Drop unused SPL gd copy
  powerpc: Make the global data pointer LTO safe
  powerpc: lib: Add GPR save and restore routines to the private libgcc
  powerpc: lib: Add 64-bit division to the private libgcc
  powerpc: mpc85xx: Use the private libgcc with LTO
  powerpc: mpc85xx: Discard LTO keep-syms sections
  powerpc: Drop -ffunction-sections and -fdata-sections with LTO
  powerpc: mpc85xx: Allow LTO
  xpl: Pass the make jobserver to the xPL link
  configs: turris_1x: Enable LTO
  mtd: rawnand: fsl_elbc: Select NAND_ECC_BCH
  board: CZ.NIC: turris_1x: Make NVMe and SCSI boot targets conditional
  configs: turris_1x_nor: Enable CMD_UBI, drop NVMe and SCSI
  board: CZ.NIC: turris_1x: Fix up MACs and serial number from OTP

 arch/powerpc/Kconfig                      |   2 +
 arch/powerpc/config.mk                    |   8 +-
 arch/powerpc/cpu/mpc83xx/cpu_init.c       |   3 +-
 arch/powerpc/cpu/mpc83xx/spl_minimal.c    |   3 +-
 arch/powerpc/cpu/mpc85xx/cpu_init_early.c |   3 +-
 arch/powerpc/cpu/mpc85xx/u-boot-spl.lds   |  11 +-
 arch/powerpc/cpu/mpc85xx/u-boot.lds       |  11 +-
 arch/powerpc/include/asm/global_data.h    |  30 +++
 arch/powerpc/lib/Makefile                 |   5 +-
 arch/powerpc/lib/crtsavres.S              | 213 ++++++++++++++++++++++
 arch/powerpc/lib/gd.c                     |  14 ++
 arch/powerpc/lib/udivdi3.c                |  82 +++++++++
 board/CZ.NIC/turris_1x/turris_1x.c        |  20 ++
 board/nxp/p1010rdb/spl.c                  |   9 +-
 board/nxp/p1010rdb/spl_minimal.c          |   2 +-
 board/nxp/p1_p2_rdb_pc/p1_p2_rdb_pc.c     |   3 +
 board/nxp/p1_p2_rdb_pc/spl.c              |   9 +-
 board/nxp/p1_p2_rdb_pc/spl_minimal.c      |   2 +-
 board/nxp/t102xrdb/spl.c                  |   4 +-
 board/nxp/t104xrdb/spl.c                  |   4 +-
 board/nxp/t208xqds/spl.c                  |   4 +-
 board/nxp/t208xrdb/spl.c                  |   4 +-
 board/nxp/t4rdb/spl.c                     |   4 +-
 common/board_r.c                          |   2 +-
 common/init/board_init.c                  |   9 +-
 common/spl/spl.c                          |   4 +-
 configs/kmcoge5ne_defconfig               |   1 -
 configs/turris_1x_nor_defconfig           |  10 +-
 configs/turris_1x_sdcard_defconfig        |   2 +-
 doc/build/gcc.rst                         |   6 +-
 drivers/mtd/nand/raw/Kconfig              |   2 +
 include/configs/turris_1x.h               |  20 +-
 scripts/Makefile.xpl                      |   2 +-
 33 files changed, 446 insertions(+), 62 deletions(-)
 create mode 100644 arch/powerpc/lib/crtsavres.S
 create mode 100644 arch/powerpc/lib/gd.c
 create mode 100644 arch/powerpc/lib/udivdi3.c


base-commit: 5e3b01c8466dbe45cd6a06299f8f4c7e8c1c2363
prerequisite-patch-id: dd05ac311e66ce2e58bee21495f7a8ec9deb09f8
prerequisite-patch-id: 272fe84ac4b6e21b07a782eeb57a58a4953afa1c
-- 
2.54.0 (Apple Git-157)

