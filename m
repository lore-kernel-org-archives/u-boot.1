Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77103C79FA1
	for <u-boot@archiver.kernel.org>; Mon,  7 Sep 2026 15:34:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DC00B6066F;
	Mon,  7 Sep 2026 15:34:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id c1KHMeP5WuLg; Mon,  7 Sep 2026 15:34:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org C05F16062B
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788795275;
	b=OGxKzEYLwk5Px0gJEb8V476IQZLHzbXiej4fFvhRbcivD8P5+80Y+xWmTmxQi1D3OHxs
	 djVmFrR2FzzZ4+QO72ON4EcufV167oOF/LoaJR4CrQXNlwzs8hV6EQV6lx/6tvELl3JDu
	 32KWmdIHOGcbsqsRU2w1UNU1F3+vj5cbX22hImjjsNjdVdJUnHhF8i+0GpeNRtY15xWsg
	 F3i961/oFK+ZFaUawhWqQ12FD8n9ZOBx20xTaFlrqjPpm9jQI7seblAgzFlPHEQ7GmlrB
	 JUBvMM1/OMNRDSCvq+w11GFEdS3vvklbGt+J0KiavDFCZicYjwXyVpa/LL6PxpHb+yA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788795275;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=4lABUe3cX76qJi8Jrh12u3Gg4z5eRnsZ1DlllDZTpc8=;
	b=mI5egxl53FBz/7lxqbwHStFsMDV/xxUsRGeof5lVA0luV+JrfttCBhw+oJAi3rUhfzN5
	 3WSVamji3mjTgjOvt5iiEYcdfQUYVmrLMnHvllwj1wyeuB7Sc1N5j7Aq5RwJpZkO0WxmS
	 15K/WdQ9qgK6PJFORnRAkmv9gAelXokasmMAUUe3ppJJC3J/v+ZY8KEZbBXXL19oZJX3Z
	 1Sq7PpjUsyQg+UA22o6FcEzKAP6XBo8S8ebNy+LxVOxW7lv/uOL4HgC5MBICdTKmGvvDf
	 n+073UjLAk56I50RywKrJUrNE4dwwm/mfoAUP/IpOycmAzJ4eTCYKXLOYn6TcZSLzsg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=free.fr;
	dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=m5xUg3tQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788795275;
	bh=4lABUe3cX76qJi8Jrh12u3Gg4z5eRnsZ1DlllDZTpc8=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=nzKKHV/biWU0gP7GinKxQXO+YMXM+BHPHAdUn1x7RyfSnJGmLPHhL7vp8uM+0E7br
	 VBqzJ/uJ4zSua56AuWqA8KuCxX+DljdwISda0qNX4gAW6xXHf9gGo5JfdfhKl7v9SI
	 CnZyjvfnAKupW5XLQye6GZJEMExJWJ70JQ/80JcAi2j4DSbDm7NPV9K4nu6sBL+mNe
	 SNQIt2jYFGGAL5Ry2mqw1gjKLV66G8JChwwFtn+mOi8NPRnYzhf/avKLR7kVVugrZ8
	 Od8b5aTq54btG91D+jZh5E4Khj4TsN3qs+ErZR2OInb8O9DASkurbIfAO+pXIJq4qu
	 8BK1DN/umLPfA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C05F16062B;
	Mon,  7 Sep 2026 15:34:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 07D02A48
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 15:34:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EDB716062B
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 15:34:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PI-8vB3TKnCc for <u-boot@lists.u-boot-project.org>;
 Mon,  7 Sep 2026 15:34:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 0C954600C4
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=212.27.42.1
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788795272;
 b=DqeL9ZnPXRAIvZ7hygtzr3KIK4xc7OiD0ZFlGf4rkHlRE5B2ycvhENiJ+h6P7UMR+xOk
 3HcldxXNNTlzx2iaczZaIPsnb6ZjryoF7BzNwfeZU68gxwV6RGaCSHn5Xz17UdncnTLNy
 3/nkJKHZRDVjDtpPsJT8/JKJSb2xMEsfSrLN74/ftCPN/oTEJ2TajMMRjIXolvMt2FE9t
 JqTJizZwjxoU70JWkyt1G44wFsNZNqCsPPVoDpIAznudVducsfCk/bslDyDy6DwYUMKFX
 f7EJHGADeCOuQsck7czDpzw49/J6x2qRoZQC6UU1Bryj+bjk6WmDwYm7SzUybIE9bZA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788795272;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=4lABUe3cX76qJi8Jrh12u3Gg4z5eRnsZ1DlllDZTpc8=;
 b=gYsJDTrHiPS4CwUR5oYgw2efE+wQeMVza7uVjUTFpwvGqZ5kUIn5udqNjGCmrBl00lDc
 trJCuoNOUo8WqY5ARSPnbBSKa55AtU3SqyjsCZbdARpCUmP/neAtd/Ke0ivQOHnNHPkRd
 vKdH3UbLyfEN3i/37c9cRUuxN0IvnTXx1/h50AZChIUQFr5NM5hHN/BFu5dCUYt5Aar9A
 cidlh3/SUDJuQuvh2vdiOas+vU7ll8qilntyAW+EAlQkG6yNiNzykYMmw3K1yaJ4fYG38
 sUdLrrOMT2BkXSYmyfokTXMWa1xlknyIui00ck49ZEicgTcjBWnCoznMlWceEidsW0A==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=free.fr; 
 dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=m5xUg3tQ; 
 arc=none smtp.remote-ip=212.27.42.1
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.27.42.1;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=m5xUg3tQ
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0C954600C4
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 15:34:31 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id 1120DB0057C;
 Mon,  7 Sep 2026 17:34:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1788795268;
 bh=BGxYunsbVGvaiwv5hsP9ey+1qiS+CIba6GtatZRo7qk=;
 h=From:To:Cc:Subject:Date:From;
 b=m5xUg3tQ5BFanzXEKVvyHw90g64FYcHBHF5p3vqwPjm/pRWbYJFL+0o3IN53vUt0I
 tWTtlIwr75Ez+wCa7nUchdHSJ6vxS2tTXQRAdqLDYq5ImNslJ/83yMuo6jHg2ORsZg
 5nX+Efl5lKSFkqvc77Nq42lDo920iPJ4oZXUxJxQjI40Yn3JW4f8xINO84GFHiwKNr
 ALM0T1VPbUx+6IwXp6urwILJylHq5tDuoAkd5e9pvzah3Yl2dh+jcPiMLQLdACW/rS
 H3hzIKnXNGyNjT+234F4xP8FGgf2sbDLJ7//09ksM0VE0ZZl/AQaHiUOKcH7jmgnAI
 Bs6Wizg4d0LKQ==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Simon Glass <sjg@chromium.org>, Priyanka Jain <priyanka.jain@nxp.com>,
 Wasim Khan <wasim.khan@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 Peter Robinson <pbrobinson@gmail.com>, Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v2 0/8] board: nxp: add the Free Mobile Nodebox v3 CPU Module
 (LX2160A)
Date: Mon,  7 Sep 2026 17:34:02 +0200
Message-ID: <20260907153411.2207773-1-vjardin@free.fr>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
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

This series adds the Free Mobile Nodebox v3 CPU Module, an NXP
LX2160A based board (16x Cortex-A72, DPAA2).

The port is modelled on the LX2160ARDB and QDS boards and lives next
to them under board/nxp/lx2160a/, reusing their SoC level code.

The board specific behaviour is using EVENT_SPY hooks.
The default-y Kconfig bools are under `if TARGET_NBXV3`.

The v1 review raised two device-tree points, both addressed here
(v1: https://lore.kernel.org/r/20260817153144.1951036-1-vjardin@free.fr):

 - The DTS is sent to the Linux kernel list
   https://lore.kernel.org/all/20260907-for-upstream-nbxv3-dts-v1-3-f43fd0028b78@free.fr/
   and U-Boot keeps its copy. Did I capture it right ?

 - The per-peripheral patches (v1 10-23) are folded into the base
   port

Boot is FIT only by default. The review also asked about UEFI.
CONFIG_EFI_LOADER is a defconfig option with no device-tree impact and
can be enabled, it is left off here for footprint that is critical on
this system.

The series is now:

 1. Base port and full device tree (this patch).
 2. Documentation.
 3-8. Board code: MPQ8785 PMBus core-rail readback, PMBus PSU
    telemetry, VID fuse driven core voltage, per-carrier selection,
    DPLL presence probe, +3V3_FAN rail hook.

Changes in v2:
- Device tree: the board DT fsl-lx2160a-nbxv3.dtsi is now shared
  with Linux too, sent in parallel to the kernel list for review
  https://lore.kernel.org/all/20260907-for-upstream-nbxv3-dts-v1-3-f43fd0028b78@free.fr/
- Squashed the former per-peripheral patches 10-23 into this base
  port to align with the new DT approach.
- FIT stays the default boot path; CONFIG_EFI_LOADER is left off for
  footprint
- checkpatch: IS_ENABLED() for the MC boot call in eth_nbxv3.c
- VID handoff: fix voltage table per the doc and avoid manual correction
  since the MPQ devices does it on its own.

Vincent Jardin (8):
  board: nxp: add Nodebox v3 CPU Module (LX2160A)
  doc: board: nxp: add the Nodebox v3 CPU Module
  board: nbxv3: add MPQ8785 PMBus core-rail readback
  board: nbxv3: add boot-time PMBus PSU traces
  board: nbxv3: add VID-fuse driven core voltage
  board: nbxv3: select carrier at boot
  board: nbxv3: add DPLL status (ZL30733, ZL30643)
  board: nbxv3: enable +3V3_FAN rail fixed regulator

 arch/arm/Kconfig                           |  12 +
 arch/arm/dts/Makefile                      |   1 +
 arch/arm/dts/fsl-lx2160a-nbxv3-u-boot.dtsi |  67 ++++
 arch/arm/dts/fsl-lx2160a-nbxv3.dts         |  16 +
 arch/arm/dts/fsl-lx2160a-nbxv3.dtsi        | 342 +++++++++++++++++++++
 board/nxp/lx2160a/Kconfig                  |  45 +++
 board/nxp/lx2160a/MAINTAINERS              |  11 +
 board/nxp/lx2160a/Makefile                 |   1 +
 board/nxp/lx2160a/nbxv3/Makefile           |  11 +
 board/nxp/lx2160a/nbxv3/carrier.c          |  64 ++++
 board/nxp/lx2160a/nbxv3/carrier.h          |  17 +
 board/nxp/lx2160a/nbxv3/dpll_zl30733.c     | 184 +++++++++++
 board/nxp/lx2160a/nbxv3/eth_nbxv3.c        |  63 ++++
 board/nxp/lx2160a/nbxv3/fan_power.c        |  33 ++
 board/nxp/lx2160a/nbxv3/mps_pmbus.c        |  99 ++++++
 board/nxp/lx2160a/nbxv3/psu_pmbus.c        |  72 +++++
 board/nxp/lx2160a/nbxv3/vid_handoff.c      | 144 +++++++++
 configs/nbxv3_tfa_defconfig                | 106 +++++++
 doc/board/nxp/index.rst                    |   1 +
 doc/board/nxp/nbxv3.rst                    | 212 +++++++++++++
 include/configs/nbxv3.h                    |  57 ++++
 21 files changed, 1558 insertions(+)
 create mode 100644 arch/arm/dts/fsl-lx2160a-nbxv3-u-boot.dtsi
 create mode 100644 arch/arm/dts/fsl-lx2160a-nbxv3.dts
 create mode 100644 arch/arm/dts/fsl-lx2160a-nbxv3.dtsi
 create mode 100644 board/nxp/lx2160a/nbxv3/Makefile
 create mode 100644 board/nxp/lx2160a/nbxv3/carrier.c
 create mode 100644 board/nxp/lx2160a/nbxv3/carrier.h
 create mode 100644 board/nxp/lx2160a/nbxv3/dpll_zl30733.c
 create mode 100644 board/nxp/lx2160a/nbxv3/eth_nbxv3.c
 create mode 100644 board/nxp/lx2160a/nbxv3/fan_power.c
 create mode 100644 board/nxp/lx2160a/nbxv3/mps_pmbus.c
 create mode 100644 board/nxp/lx2160a/nbxv3/psu_pmbus.c
 create mode 100644 board/nxp/lx2160a/nbxv3/vid_handoff.c
 create mode 100644 configs/nbxv3_tfa_defconfig
 create mode 100644 doc/board/nxp/nbxv3.rst
 create mode 100644 include/configs/nbxv3.h

---
base-commit: 509312dc5386ff4c5adabf53a573abca0aac4ce5
branch: for-upstream/nbxv3-v2

-- 
2.43.0

