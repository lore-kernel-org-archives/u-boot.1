Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79F9FCCA463
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 02:15:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B743560ADA;
	Fri, 16 Oct 2026 02:15:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JUFf2GWvPlGK; Fri, 16 Oct 2026 02:15:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org AF90760AC5
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792116916;
	b=i4/2mOrwbwK5lZa8CEKgUMCiHdskYFbj9K6RGnZTPKQe03/46Ctk+TskVPppxVrYbc81
	 PqgFUxTq+ciPA/Qrh+y1JCD+WebxehNnzCtoq95Y9g6HLO1XLiIYjbo4oF8UG+p/ylyY0
	 WKpxxOV3Q9bYfDVrEQIRLBlwReZtmQeXYbLGL3PvgnxCATxc05kqBTW5WhX4bhF6/24nH
	 rGJ8SlSrRFNPx2OwcVGk6dusQakYC7orjQmQu3sywPnkfek+5Y4/hpAgoo73V/JFk6ZJB
	 50uzz31wUQIRIRayDoHCRrMbga2Ufj3CsFoFoMDH0UGeaRybrgxSovtmLKc5ma9G/kw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792116916;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=stpn8+kdVaYQLfFCcRbsh/w2mETmrhbg6oq7mrrDufo=;
	b=TMWHNh6xLAqH2Nn6L/xyc8hvq/oDFHPoIk6d3AQOdJ18bGhKIqmewAOMPZ6bfLu2lXPG
	 j85uh6EGGtsoJpZcAwiiRwc2DJ1CQfmO2jKCvj+OWrRlgxOY5UvqzXGwuSR2yIymREZv3
	 GuAmPn4aUfiP7uAs/ceiJGoWJv9phRQ6/nvwH/bGcwEMUC6jOqhJdH4i9eMI/QO40eX46
	 lkW1C10w8pCQmuH9Aj5MxWpbJolW9I2UHoPzpCRM2BKIRU2DgVLboTWzThK7+gQDOo5Nn
	 Pw8tDSxgLX7cGzvzV9OOa9Yb9t47cxiaV11uoJivreZf+HaKGWLpHvgxCK3i58kzN4g==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792116916;
	bh=stpn8+kdVaYQLfFCcRbsh/w2mETmrhbg6oq7mrrDufo=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:From;
	b=i9NJh/qSrnjuzMGcttv6HNSelThYzSkcVVCqS18qi4U3wOOhYuHM/JVEjEZ3Ncks6
	 P6e725g6C98DoyriAM99pAtF9DLqYIqBbFA7FoiA6MM/+8PFmCjtSE7Jd3p4eFOwwu
	 u3anT+vi35Ltbo2J0FSSwsficQkGcDncfjvw3jmOpsry2UFQHvpZARkvsAWTC+PSuJ
	 No3CJVeC/X2x+C4drNGmyclLq2dr9vn7YY9E9ZUifYNPE+UR/KNK2vjY+nuDrChpNu
	 WqfGJDA2hYcddKSyFjOyaihe5ZAS3jNEtvbp8eVy58sLmvY0bnrHQpYpY8JHmPqoGe
	 ds9B/rZ2IzeJQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id AF90760AC5;
	Fri, 16 Oct 2026 02:15:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 91D8779D
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 01:43:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7834480F8C
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 01:43:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IVnjdP_M_keE for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 01:43:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8A3D180F84
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792115036;
 b=ezyfPhE+O73IOg2J1BmZqzoS5sSL/YYZB6CIagTmfFEMTnNpY1GvERgd4OkG+7wePd0Q
 Q4MgeDgykOPKZqRqLFMfz/B2AuY0l4Pj8uhVH3PKHjFrGA08m3ZmEy9h70iwyt0+BsSxW
 /iHTmVBMerOxDlDGVOWSVXG091+wpXQg7WdErTRkMO+e06o9LioZraVgdXoXhhWw4JuWz
 2oXKdlQxp0GBmtEI/RzN5/7VfB0a2fqjjGVsQ39CuQHkWx7AiFpk//nupqqgu8TUHpW4l
 OhP3wchke62RkuPpux8e4XgN4IQGOMotx++PeKzVSr4aPuivjjZSVKJ3f3c2elsXrZw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792115036;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Subject:
 Date:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key:X-Endpoint-Received:X-Original-From:Reply-To;
 bh=stpn8+kdVaYQLfFCcRbsh/w2mETmrhbg6oq7mrrDufo=;
 b=Pjjc18hxkoMvlk2sKmtb4iquDvrVrsiOW2+819mr1cwmle/AqaLEFhu8RlSEqgeVf1ve
 /oOmfPIKKhjYBi/OV94iCUUMbvbhLmCiC+kow/FvOjq4GDmjAz1FrIZE8k+8WD+BqUpb9
 LNHMm7pUeBwQ7kdoeD91udypT885vTaiPEx/JS1B6+Q3A3G1Mr/skC8L3lWDW1BlYxNZI
 6Zg2pLBrzKaHXEhZkGUyA4ZCTz7S4dcav34Z5yvXk7Ki1kg9mdSgY7hhQl6OzUYlujurT
 uxTQuqs5UhDFh8RpHc0hSo7ti1uw5iRj44X6s7c/iOS1YIdjU5FrWdp9MgS5Mq8mZqw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=ITp9mJPC; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=devnull+takahiro.kuwano.infineon.com@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=ITp9mJPC
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8A3D180F84
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 01:43:56 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 0C91660A74;
 Fri, 16 Oct 2026 01:43:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id ACC41C2BCC7;
 Fri, 16 Oct 2026 01:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1792115033;
 bh=Mc9K5sN8LF0Gr1yCEXpX7+PZDSAqlIBYhE3AMNF6W98=;
 h=From:Subject:Date:To:Cc:Reply-To:From;
 b=ITp9mJPCWTBg5uyX9cv+aRSr/63Ykk7/vmsMhkBGZbnaC10pPmeNlZk4lHwy+SOeY
 sBC8IAHvcWKDeY4eY9qmFQ1/fD8oGdrarMMEAsqjMoDZZ8+urhtxsiJ6RxZ3I3v4Qk
 bAcK97j7xFz/Asl1zm7HH+RDB7cko5w/4iQWAm7JzEwaBDcO2gr9L90K3r9KoxsCsh
 W9bRVL9vUZvWQVbf49LXb/Daqxd2yDg4vNoehZXyBF07SVW01bfbYFzJ0GjJ6K3Oet
 XTAkxsdUeyr2K8Igzuou5RrRo8eCWZGNdzl5dSt4sz55VuyRuCYFmv/TpVzitz0Y4F
 pL+hfjc0eO0dw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 8A635CCA462;
 Fri, 16 Oct 2026 01:43:53 +0000 (UTC)
From: Takahiro Kuwano via B4 Relay
 <devnull+takahiro.kuwano.infineon.com@kernel.org>
Subject: [PATCH v3 0/4] mtd: spi-nor: split SFDP, ID database, and fixups
Date: Fri, 16 Oct 2026 10:43:41 +0900
Message-Id: <20261016-split-sfdp-id-v3-v3-0-4a47b8fc945a@infineon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MQQqAIBAAvyJ7bsE0PfSV6BC51kKUuCGB9Pek4
 zDMVBDKTAKjqpCpsPB1NrCdgnVfzo2QQ2Mw2vhe9x4lHXyjxJCawWIxOq/NYN3iBg0tS5kiP/9
 ymt/3Axt59hliAAAA
X-Change-ID: 20261016-split-sfdp-id-v3-f5602435a540
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Vignesh R <vigneshr@ti.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, Vincent Jardin <vjardin@free.fr>, 
 Fabio Estevam <festevam@nabladev.com>, Eugen Hristev <ehristev@kernel.org>, 
 Takahiro Kuwano <takahiro.kuwano@infineon.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792115031; l=3207;
 i=takahiro.kuwano@infineon.com; s=20261016-2; h=from:subject:message-id;
 bh=Mc9K5sN8LF0Gr1yCEXpX7+PZDSAqlIBYhE3AMNF6W98=;
 b=FQplaQowf4AIwyYIs9h3il1g3atVaQcbhPkZ9h5cygSyQweHA6T9FKi3hNqM0qw3CVfr1Lhrb
 2esorlLR9CBBSa///w/GgWtG59jAIg5bhwmzDSODvg30u0vcQ0yoG7h
X-Developer-Key: i=takahiro.kuwano@infineon.com; a=ed25519;
 pk=pp4mpJAHIqhV2MvdSGbIzKRk3ujhk+tSlGjyTursr4E=
X-Endpoint-Received: by B4 Relay for
 takahiro.kuwano@infineon.com/20261016-2 with auth_id=1202
X-Original-From: Takahiro Kuwano <takahiro.kuwano@infineon.com>
X-Mailman-Approved-At: Fri, 16 Oct 2026 02:15:13 +0000
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
Reply-To: takahiro.kuwano@infineon.com
Errors-To: u-boot-bounces@lists.u-boot-project.org

The spi-nor-core.c contains optional logics like SFDP and manufcaturer
specific fixups. The spi-nor-ids.c has single large ID database. There
are many #ifdef directives in those files and that negatively affects
readability and maintainability.

This series, as the first step of cleanup, move SFDP logic, IDs, and
fixups to newly source files. Reworking, renaming, and reformating
existing code is not a scope of this series and further cleanup will be
taken place in follow-up patches.

Here is the code size impact when applying this series.
Measured by my AMD Zynq-7000 (ARM32) environment with SFDP and all
manufcaturers are enabled.

SPI-NOR:
            text    data     bss     dec     hex filename
BEFORE    720685   14084       0  734769   b3631 u-boot
AFTER     721827   14156       0  735983   b3aef u-boot
DELTA      +1142     +72

TINY:
            text    data     bss     dec     hex filename
BEFORE     77399    3128     248   80775   13b87 spl/u-boot-spl
AFTER      77589    3200     248   81037   13c8d spl/u-boot-spl
DELTA       +190     +72

Changes in v3:
- Expose manufacturers table so that sandbox can look up
- Update sandbox to handle manufacturers table
- Link to v2: https://lore.kernel.org/u-boot/20260924-split-sfdp-id-v2-0-aafc70e0b657@infineon.com/
Changes in v2:
- Rebase on top of next
- Link to v1: https://lore.kernel.org/u-boot/20260612-split-id-table-into-vendor-files-v1-0-dfaaa82cc6f0@infineon.com/

Signed-off-by: Takahiro Kuwano <takahiro.kuwano@infineon.com>
---
Takahiro Kuwano (4):
      mtd: spi-nor: move SFDP logic out of the core
      mtd: spi-nor: import manufacturer driver concept from Linux
      mtd: spi-nor: move flash info entries to manufacturer drivers
      mtd: spi-nor: move fixups to manufacturer drivers

 drivers/mtd/spi/Makefile        |   18 +
 drivers/mtd/spi/atmel.c         |   28 +
 drivers/mtd/spi/dosilicon.c     |   25 +
 drivers/mtd/spi/eon.c           |   23 +
 drivers/mtd/spi/fujitsu.c       |   27 +
 drivers/mtd/spi/gigadevice.c    |  140 ++
 drivers/mtd/spi/issi.c          |   84 ++
 drivers/mtd/spi/macronix.c      |  154 +++
 drivers/mtd/spi/micron-st.c     |  169 +++
 drivers/mtd/spi/puya.c          |   56 +
 drivers/mtd/spi/sandbox.c       |   33 +-
 drivers/mtd/spi/sf_internal.h   |  136 +-
 drivers/mtd/spi/sfdp.c          |  720 ++++++++++
 drivers/mtd/spi/sfdp.h          |  152 +++
 drivers/mtd/spi/siliconkaiser.c |   18 +
 drivers/mtd/spi/spansion.c      |  700 ++++++++++
 drivers/mtd/spi/spi-nor-core.c  | 2751 +++++++--------------------------------
 drivers/mtd/spi/spi-nor-ids.c   |  753 +----------
 drivers/mtd/spi/spi-nor-tiny.c  |   11 +-
 drivers/mtd/spi/sst.c           |   34 +
 drivers/mtd/spi/winbond.c       |  250 ++++
 drivers/mtd/spi/xmc.c           |   27 +
 drivers/mtd/spi/xtx.c           |   54 +
 drivers/mtd/spi/zbit.c          |   19 +
 include/linux/mtd/spi-nor.h     |    2 +
 25 files changed, 3404 insertions(+), 2980 deletions(-)
---
base-commit: ed869863c7e2aca50d57a05d843830dd843138c4
change-id: 20261016-split-sfdp-id-v3-f5602435a540

Best regards,
-- 
Takahiro Kuwano <takahiro.kuwano@infineon.com>


