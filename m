Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0376AC531D0
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 12:06:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7E876606EE;
	Mon, 27 Jul 2026 12:06:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id D0DDQUrvB1Qw; Mon, 27 Jul 2026 12:06:25 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B317A606D9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785153985;
	bh=K9KkrQF/Hg9rzvet3yYzdkP20pN/j+s8Lsfo3BTsLF4=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=dcKX+fZDOZ2/q5jMWAj/3KC5rXooJtHiRuIhImkY30T2NIf9c4cI/Dlw3sHdduTxS
	 PTv4c6mJCVs9+SyKT2J1UABPq3bMboU+NXBBw7Iezr+F6BNMzg2bFY0iUWnUasdp+I
	 C/2nR+33mq0oktZ5VxPC75o4hVVfrQ+PLa5l2zXvTcjgdmeldr/QulS1AXYcI4iZKk
	 s693gcjkyCI+kMRbMD3MltZsPI1YUZ1gSsLvqLkkZ5zn91tU48bP38qYpgXR/5otfy
	 rA1Iu7XledmYwT1x9aNJGHrTvQWfhlhe2Hg9vy1r7fKAATx/zwATf6BN5O3NiIo330
	 bFMyTpKigBQ4Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B317A606D9;
	Mon, 27 Jul 2026 12:06:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id CAFF969
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 12:06:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BCF01606D9
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 12:06:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8OqVxZSyO9Cs for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 12:06:20 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=188.40.3.216;
 helo=www537.your-server.de; envelope-from=max.merchel@ew.tq-group.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 5B61960651
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5B61960651
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5B61960651
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 12:06:19 +0000 (UTC)
Received: from sslproxy03.your-server.de ([88.198.220.132])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1woK64-000JLI-2U; Mon, 27 Jul 2026 14:06:16 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy03.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1woK64-000I7f-1d; Mon, 27 Jul 2026 14:06:16 +0200
From: Max Merchel <Max.Merchel@ew.tq-group.com>
Subject: [PATCH RESEND 0/6] TQMa6: Prepares for the switch to using SPL
Date: Mon, 27 Jul 2026 14:06:14 +0200
Message-Id: <20260727-tqma6_bis_spl-v1-0-27673934830f@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALZJZ2oC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDcyNz3ZLC3ESz+KTM4vjighxdw1QDM0OLNDOTJEtDJaCegqLUtMwKsHn
 RSkGuwa5+LkqxtbUA81eQ0mcAAAA=
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@ew.tq-group.com, 
 u-boot@lists.u-boot-project.org
Cc: Max Merchel <max.merchel@ew.tq-group.com>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Markus Niebel <Markus.Niebel@ew.tq-group.com>, 
 Paul Gerber <Paul.Gerber@ew.tq-group.com>, 
 Paul Gerber <Paul.Gerber@tq-group.com>, 
 Max Merchel <Max.Merchel@ew.tq-group.com>
X-Mailer: b4 0.13.0
X-Virus-Scanned: Clear (ClamAV 1.4.3/28074/Mon Jul 27 08:25:14 2026)
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; 
 d=ew.tq-group.com; s=default2602; h=Cc:To:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Message-Id:Date:Subject:From:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References;
 bh=K9KkrQF/Hg9rzvet3yYzdkP20pN/j+s8Lsfo3BTsLF4=; b=ocK3n/W7QOTkU0Rfwq+Go7oXbq
 1AcT9K3ZeretqZne46UFRA6RBSFxZoDIWh/1Kd4hWbn4zcluC5StV7q2xcVl/lBYTQIckLGx2Zocj
 d/fp8Or+B3EsBT6/5fnj44W065xkMCypYWHGf0NukhH0jDWHGWgr06WOV4X74uZgmUo5PZYUDHHY6
 wxFjjZkH1OOL2OPBEhtI2lftAtD5cHmPVhJr4gBQA052uH5e1HAEacpq/CTOU1seRTacaDxChsx6e
 c2AEFPonyKllrGDDA2tK/1sLJ7PJsZfqT7kvVWLwgvl9JVTF3kT/JZhetVpx0tkeW+tk5vBpXiesy
 JwBoF3iQ==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com
 header.a=rsa-sha256 header.s=default2602 header.b=ocK3n/W7
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

This series prepares for the switch to using SPL on the TQMa6
in the subsequent series.

Resend to the new U-Boot mailing list after the project moved to
u-boot@lists.u-boot-project.org. The series has also been rebased
to branch onto main. No functional changes.

Link: https://lore.kernel.org/all/20260713130109.321862-1-Max.Merchel@ew.tq-group.com/

Signed-off-by: Max Merchel <Max.Merchel@ew.tq-group.com>
---
Markus Niebel (2):
      board: tqma6: change U-Boot device tree fragments
      board: tqma6: implement ENET errata workaround detection

Max Merchel (3):
      ARM: dts: tqma6: add boot phase properties
      dts: tqma6: mba6: remove old device trees
      board: tqma6: use runtime SoC detection in enet setup

Paul Gerber (1):
      board: tqma6: add kernel device tree handling for environment

 arch/arm/dts/imx6dl-mba6.dtsi           |  22 --
 arch/arm/dts/imx6dl-mba6a-u-boot.dtsi   |   8 +
 arch/arm/dts/imx6dl-mba6a.dts           |  21 --
 arch/arm/dts/imx6dl-mba6b-u-boot.dtsi   |   7 +-
 arch/arm/dts/imx6q-mba6.dtsi            |  44 ---
 arch/arm/dts/imx6q-mba6a-u-boot.dtsi    |   8 +
 arch/arm/dts/imx6q-mba6a.dts            |  20 --
 arch/arm/dts/imx6q-mba6b-u-boot.dtsi    |   7 +-
 arch/arm/dts/imx6qdl-mba6-u-boot.dtsi   |  37 ++-
 arch/arm/dts/imx6qdl-mba6.dtsi          | 535 --------------------------------
 arch/arm/dts/imx6qdl-mba6a.dtsi         |  30 --
 arch/arm/dts/imx6qdl-mba6b.dtsi         |  49 ---
 arch/arm/dts/imx6qdl-tqma6-u-boot.dtsi  |  54 ++++
 arch/arm/dts/imx6qdl-tqma6a-u-boot.dtsi |  14 +
 arch/arm/dts/imx6qdl-tqma6b-u-boot.dtsi |  18 ++
 board/tq/tqma6/tqma6.c                  |  86 ++++-
 board/tq/tqma6/tqma6.h                  |  14 +
 board/tq/tqma6/tqma6_mba6.c             |  33 +-
 18 files changed, 247 insertions(+), 760 deletions(-)
---
base-commit: b635d43bca429500cb8ef20aa151cb5773b9a8a5
change-id: 20260727-tqma6_bis_spl-1e0618f64b91

Best regards,
-- 
Max Merchel <Max.Merchel@ew.tq-group.com>

