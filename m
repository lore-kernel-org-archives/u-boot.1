Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0123CA5FE7
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 21:31:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5C37160DB5;
	Fri,  2 Oct 2026 21:31:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id b8mMYR7aOwFq; Fri,  2 Oct 2026 21:31:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org A499060DB6
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790976675;
	b=tWBTHffJNzYXEfx3oGE5Qk6yXU8f5q4tyXOY/ploIoaj2lEBkdTDhpIvg6QuVpEa9oKR
	 f3bhX1k4S9QY4Ee54qxUK+fmT4+xYxltf4aDAJTzxGlWHODgZjPIlV9OIhtBkAHdVFut0
	 Qz1GOEP3CHAc47RrnOkl33SaTt/JURjlrrAXPdjV8JlKNmfSLb5wmzinEvfSctdp6s0YI
	 grFt/HVGNlyoYSYMQ5JsbArhYoFQleSdJiPZ0UQ5yEKU1N4DzlG8owcPxnj/Lw316lZik
	 uXgZ6nafD/XJQ/SbomqTglrvmKWDWM/owhsCDRPGsBhBBcBkxiUM0W05DuN2u92/MeA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790976675;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:Feedback-ID:
	 X-Pm-Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=LJw7EsStORdqBy35TEYoiJjWRd9vSJ/AqNoeVd3yD+c=;
	b=PnNlK0febo4eR/2p0aSubbQcuAGevyKWWv/NOz8gLjfyxawIe5u7Y9V4lhdsh5NVEMsY
	 +d2pSW+Kil2TadugN0pp+TsGG61IsX55dpzvJqmc0t0bUlDRBemX1jMF3K6GSf1v4nlMn
	 lPg+JMP9Lisoz+mTjuLg0MwMHQkhbNpHjm0u/HjwDnue74keVL7eXdRumfKV0cHkKebt1
	 OM4eD9DXGW73qw50fdqQVvXSx4mCuUrEzdTBtcDgnYj5d7X8Eeew5KQeMwQr6WU2EqyRQ
	 axTCEJak4cTnrg6o/K6NSv9sIf0JMa0x1q/iPt8vCAX33NT0HLT+njamINUXP2RUwpw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790976675;
	bh=LJw7EsStORdqBy35TEYoiJjWRd9vSJ/AqNoeVd3yD+c=;
	h=Date:To:From:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=uiHJNetdBTv6Yjm9gbyvkko/2DsLDCDnwRzsftix9ZiB+Jx+kPJ2lGQ9i3ugWkz65
	 HN7XA6suWWLTEqNO3fF0kyrqxiGRWi9seojg/RTJEPmWc6svHOOONw/OC3sdSEGOtC
	 d4vXdAqbUX7TDMK+XcPqoZIRHOeESt1a17OTvFSTFEKv6Lt7HKrsm2xqfcpNvxB/F4
	 sVDRIrOdUP2OpriuGDuDtKRwIDRtA92BVIXzThLQp8IuD15psw84YSahQPvVhHPNm/
	 DT2Utes5dsF4MoRC2w0mc7PbOTZvX1vebk500bPpuFMn8JZJTFwJJGY1KclgiamOb/
	 2QqYO+jlHPKhQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A499060DB6;
	Fri,  2 Oct 2026 21:31:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 10908282
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 21:30:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0239D40590
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 21:30:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VQWgU8sZDTtP for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 21:30:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org A6F3140585
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=85.9.210.45
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790976643;
 b=i4hv8kn/JXJ1SDJ4ka+mm2JTUK6PN2n297isXZ5SvkQDoUU+S1h3Q75l/ZZwaEOSFWxc
 6coO7HYbHHK4k/vDwAo8jwJ63zeyjsjil4xadR5Zz1Ue38tuchDJ3ryWkGQzpeZwWXc8w
 UGdoFOWYhek+tZGX4ykxPIyMnlISaX9mDp11l2hbZgMoyUN/4LfvQOtaW7CZ7T1aGoG4i
 wFfXfDkbFkzB/7O7ljRiFkZzOBwnmm49MmlblwWKKeEY8joDCwRDbfUSjYvLaPR5eke98
 haiz3362zvOQpJBHOYDAyLs5zpiKcZ3nlruHA7Y54ouC9Uk0WMU3i2s4kF8QvVLEHXA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790976643;
 h=Received-SPF:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding;
 bh=LJw7EsStORdqBy35TEYoiJjWRd9vSJ/AqNoeVd3yD+c=;
 b=pk4hmled3BQqTNj7J7F6RnSlChxsiX4OKR2qP2cvGRSYDqpEBhEbEWT+OG96G3oL3zo+
 JYx29rpM5mMhzAIxsrnZvgc18Cl5PXm/9S20c4vqNfY12JJiNUhMmH6SmJaLaQg73bZsu
 xehdWE95U7G05rErdUl4RVg7WtDmBz6YnVig6YdC/IhpZged5ZVbIb9Upkief6lwOHX8L
 R2zkZmVkNUGRBQ1XuG3SebLNC7TZUe7E3wiGwipTJx4/iZEPmb76NPO3cNo+9hGAXGjc0
 7kzNDlbKg0pqnyxRHuCaPMuy6Aki9wnU5hXxhzCxOv3kE+JqOBMPhp3D8/kGvkPzKZg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=protonmail.com; 
 dkim=pass header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256
 header.s=protonmail3 header.b=GO+iecbn; 
 arc=none smtp.remote-ip=85.9.210.45
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=85.9.210.45;
 helo=mail-06.mail-europe.com; envelope-from=davewk225@protonmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=protonmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com
 header.a=rsa-sha256 header.s=protonmail3 header.b=GO+iecbn
Received: from mail-06.mail-europe.com (mail-06.mail-europe.com [85.9.210.45])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A6F3140585
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 21:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1790976636; x=1791235836;
 bh=LJw7EsStORdqBy35TEYoiJjWRd9vSJ/AqNoeVd3yD+c=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=GO+iecbnnnRa4wghsnpcOEIICO+YO7CqpEjB2FtdiibCDUlonN8Ob1IAnT3Z0jk9Z
 g13c1R57JHbWDeSEhZZTWMQOp/JaJ2vQmJUCY0aGuXhYytZFIG53uoeMWB+7KZwfFr
 wE9tmYJIEk6mvCsibGAEgLdyiGKS6EDavamBvPgUKuJL+3ARRPT2MBvbhsBfaLnFjm
 5h3B68NexECqFllVWkroRs3URx58i6b7nZxm3qE1L3d7L2yCPPYGt0comXMc36UEHT
 iEtnZCK2gW3aGlgP6JVdVWFNOnh85TJ2kBXYe+X8hOazd87D0V4SmWXqLms4AkM0sf
 uizixDqzaD4NA==
Date: Fri, 02 Oct 2026 21:30:32 +0000
To: u-boot@lists.u-boot-project.org
From: Dave Klotz <DaveWK225@protonmail.com>
Cc: Huan Zhou <pericycle.cc@gmail.com>, Eric Chung <eric.chung@riscstar.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Yixun Lan <dlan@kernel.org>,
 Tom Rini <trini@konsulko.com>, u-boot-spacemit@groups.io
Subject: [PATCH 0/9] pci: spacemit: fixes for the K1 PCIe host driver
Message-ID: <cover.1790975598.git.DaveWK225@protonmail.com>
Feedback-ID: 100562830:user:proton
X-Pm-Message-ID: 4d02411929f2c87b4cf3cac8a1f757b105cb4058
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 02 Oct 2026 21:30:59 +0000
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

Fixes for "pci: spacemit: add DesignWare PCIe host controller driver",
following the Linux driver and the bring-up order that works on the
boards I have:

- power the slot from the root port's vpcie3v3-supply (the vendor
  k1x,pwr_on property is not in any upstream device tree);
- keep the PHY interface in reset until LTSSM enable, and soft-reset
  the controller before bring-up so a warm reset starts clean;
- check clock, reset and iATU setup errors;
- report link up from the SMLH/RDLH bits in the link window;
- leave the link speed alone unless max-link-speed is set, instead of
  writing Gen1 into LNKCAP and LNKCTL2, so the OS can still train the
  link at its full speed;
- drop ASPM L1 from LNKCAP as Linux does for NVMe drives;
- set the link width from num-lanes;
- keep the probe successful when the link is down (an empty slot), and
  answer config cycles behind a down link with all ones.

Tested on an OrangePi RV2: an NVMe drive on port B is found and
FreeBSD boots from it by EFI; FreeBSD then retrains the link to x2 at
5 GT/s (with the Gen1 cap in place it could not). Port C, empty, reports
"Link down" and nothing hangs. Under U-Boot this drive still trains x1
at 2.5 GT/s.

Two observations about the RV2 device tree, not addressed here:
pcie1_3_cfg and pcie2_4_cfg mux CLKREQ#, and with CLKREQ# muxed the
controller gates its DBI clock whenever the endpoint leaves CLKREQ# high,
so the next DBI access hangs; I run the board with PERST# only in those
groups. And port B needs num-lanes =3D <2>, which the tree does not set.

Dave Klotz (9):
  pci: spacemit: power the slot from vpcie3v3-supply
  pci: spacemit: hold the PHY interface in reset until link start
  pci: spacemit: soft reset the controller before bring-up
  pci: spacemit: check clock, reset and iATU setup results
  pci: spacemit: report link up from the link status register
  pci: spacemit: do not force the link to 2.5 GT/s
  pci: spacemit: do not advertise ASPM L1
  pci: spacemit: set the link width from num-lanes
  pci: spacemit: do not fail the probe when the link is down

 drivers/pci/pcie_dw_spacemit.c | 231 +++++++++++++++++++++++----------
 drivers/pci/pcie_dw_spacemit.h |  12 --
 2 files changed, 162 insertions(+), 81 deletions(-)


base-commit: a000f2af240eaa996cec92f8d44bad96fdf3f898
--=20
2.55.0


