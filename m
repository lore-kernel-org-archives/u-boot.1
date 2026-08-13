Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0ED2C5B572
	for <u-boot@archiver.kernel.org>; Thu, 13 Aug 2026 14:18:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E9FC8812C8;
	Thu, 13 Aug 2026 14:18:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id n20-AgHo3l53; Thu, 13 Aug 2026 14:18:04 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C59358120E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786630684;
	bh=Z2+KLCUqI/5582vDdSucU6CNd5vDzKM4aQ9Ky6uejbw=;
	h=To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=qSkq+T9V/p4QX9nmU97FE64yTmRy3qh9DvgxCyRB/JsaFmHw5N93z0Ldjg3y/nE0K
	 gKBS6uPyH2GASY50eMeeON0/prI+f2gtC8Jj1qrVI32gShJtkBBag8tteCMQmXeoXy
	 skayZBLe8IVdfbQBgf1ZgT1Fesjn/oCCfxZFWgOYz3SM561t1N3ZV9NGhBqd8GqHNY
	 kqMl7nO3v+WZWctcb+sLP0OwvXgpTMBhmLUxBUzKxxAEfnTlogW2619IjNHpbL2Anr
	 uoYh1JY2IK+6lPOmsaqxxQ0IeU0WcFlkQK01LOWmaoqVq/IgUZNNR1yIto+lwYC0+V
	 z1x3+gzohl2Lg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C59358120E;
	Thu, 13 Aug 2026 14:18:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id AB033259
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 14:18:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9CD02409B4
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 14:18:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UzXNJkxbzpnu for <u-boot@lists.u-boot-project.org>;
 Thu, 13 Aug 2026 14:18:02 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.25.8;
 helo=smtp-1908.mail.infomaniak.ch; envelope-from=u-boot@0leil.net;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 951C8409AF
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 951C8409AF
Received: from smtp-1908.mail.infomaniak.ch (smtp-1908.mail.infomaniak.ch
 [185.125.25.8])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 951C8409AF
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 14:18:02 +0000 (UTC)
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch
 [10.4.36.108])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hLSBF1v7HzXjF;
 Thu, 13 Aug 2026 16:17:57 +0200 (CEST)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4hLSBD4z3Dz2cS; Thu, 13 Aug 2026 16:17:56 +0200 (CEST)
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
Subject: [GIT PULL] Please pull u-boot-rockchip-2026.10-20260813 into main
Date: Thu, 13 Aug 2026 16:16:48 +0200
Message-ID: <20260813141727.268273-1-u-boot@0leil.net>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=0leil.net; s=20231125; t=1786630677;
 bh=Z2+KLCUqI/5582vDdSucU6CNd5vDzKM4aQ9Ky6uejbw=;
 h=From:To:Cc:Subject:Date:From;
 b=F0yKiPMPeZBxHAJsOfnj5C1UFXqneKEDNZy4JMmjE7r9LCmaPb1izS4jUElgQQzZ/
 UMjXPnDS4mb6dEniOQevti6Nh/u24WyRxuyhmtgj8bu+tBPqSfcT/GnrL4lPnWN9dq
 S/9SsmVC3gch7G9g0I5QfPUuE033FdVu6nVc9/uCJWZfP4Ev89CZqhmtZ9ZXJrxxYb
 yAEbuGLyTR1Cn4MbA09cfqEAaWrNywPy/NNaH+/9lKnnkB2YIG3pfmLxjTJrMIl5cG
 M2T17kC4mu+abbbJWVP7lWOG4t+iAqYrhLcsMRdX32VBkT1GeJrg6qYOTPtBn/g2jH
 Zbo3mJVFpxuzg==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=0leil.net
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net
 header.a=rsa-sha256 header.s=20231125 header.b=F0yKiPMP
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
From: Quentin Schulz via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Quentin Schulz <u-boot@0leil.net>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Tom,

CI for this pull request is available here: https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/pipelines/972

The following changes since commit 36c377b9859ffb53eb1e39ea31e8d96d1e0fe1e5:

  Prepare v2026.10-rc2 (2026-08-10 16:43:34 -0600)

are available in the Git repository at:

  https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip.git tags/u-boot-rockchip-2026.10-20260813

for you to fetch changes up to c8cac405f29896362786c7ced1417fd15e7b8923:

  rockchip: rk3576: Disable force_jtag by default (2026-08-11 17:35:22 +0200)

----------------------------------------------------------------
- Disable JTAG for RK3576. Fix for boards potentially not being able to
  use SD card anymore due to automatic switch to JTAG based on level of
  one specific pin,

----------------------------------------------------------------
Jonas Karlman (2):
      include: linux: Import hw_bitfield.h from Linux v6.18
      rockchip: rk3576: Disable force_jtag by default

 arch/arm/mach-rockchip/rk3576/rk3576.c | 12 ++++++-
 include/linux/hw_bitfield.h            | 61 ++++++++++++++++++++++++++++++++++
 2 files changed, 72 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/hw_bitfield.h
