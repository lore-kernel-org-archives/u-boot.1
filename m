Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E627606A32A
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 20:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Y63YW+uw;
	dkim=temperror header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=KheVPuwz
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3E33480E33;
	Mon,  9 Nov 2026 20:23:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1GU6yHYkGdht; Mon,  9 Nov 2026 20:23:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 41F3E80E22
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794255829;
	b=fEv0CInX3RHeBTW0wcKhoCDSt7c72CtVFq1Q6ElBX9zjgVG9RYxV4RXYz0wr5bme+bSi
	 obvBuwMqGUZzHfGlSQUhtZv5tdfOFUHVAvG6uN3Ronij/VXgu99YagKeP0FHzscpKOsjP
	 AUQd+xjIyxc1QRFY9IIcOx0654Tws4bgd0BQzLBMurxL1BK9zKMRCf8whZTArK3gaMmxf
	 /8Y6seiJ9yQfEgRpGdoxeuJX7hJJgxj3gcFqyC861CBFsthbIs0hg8u4Ek+azSOwW8yWJ
	 sDLkzsQxinV001RRlz4zwjWEJItXhNPOYJAKVUjGCQOwvXWOHgoTbPBLmx3c0S0ktvg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794255829;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=DFJE9dSe3PvFP6rKSZ8gBEuUX1m1CzOXcJ5hyc0QjE0=;
	b=I8/J/14fVAy1wQfYpDNBuBnW7Q+Cjg0qarW+67QQDJbEdFDM9/ZixNyNjG11ROj3gZgA
	 spjRaxj/vavelr57icvA9A5MWvDpiWEHFaMvF81m7ly8Wcos1jwPqnZYHnkj/PpnN6Xzy
	 0Rtw415JwIMhERnlHjnA2RYEIx9nZSMsK6kMZm+hBrHMGXHD2lpkYUR1H9n0EqntRn/gj
	 8URhXOhMvLsWmH8k3RyEyPy9nfXi4ZcYVfO0wT7mtr8j5F2ozMUArp/8OALbTvqYG9z+y
	 gnWfdqjvjBOtHypBaDm8aTO6ZWMXkbJQ3whFI4wY/MNqbFBaJ3ZIamrzEoHE60/i+fA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794255829;
	bh=DFJE9dSe3PvFP6rKSZ8gBEuUX1m1CzOXcJ5hyc0QjE0=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Y63YW+uwaAY2n2wIful5avhlLWeR0wFsz4foQm0tm7yRWiX45QgSp+d6mxirAjUMA
	 E8Ie8VX1SZh63XMZkR1kZjSnil5DLemZ5wvgbWwqZBm/GoFTRMShZgA9/71/IrnPAm
	 VaeIjE97nyXJKaRvIGPgFWU3wB4B3JNySqMtFC49Rf7zbqcsTi5UPt3DAQbtA+AZd8
	 bVtOP2ecE3wlxpyjod0dMpZNf629qga5PyN7DVyzbN7pQ2mhRcfs5uyftOmY2TXbzv
	 W3ALmaSb1XAazit24wg8A9RTRgWybWXihGA7bz/ulckvLdjUACgO3eMOpaoVC4mmgI
	 Nf2O52QtBRH4g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 41F3E80E22;
	Mon,  9 Nov 2026 20:23:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 9699D28C
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 20:23:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7CA37406D8
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 20:23:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ua1S-1T_gU-u for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 20:23:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0EF2A406CC
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::201"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::201; helo=mout-p-201.mailbox.org;
 envelope-from=marek.vasut+renesas@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=KheVPuwz
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0EF2A406CC
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 20:23:45 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4jNh7c0tvKzMlCp;
 Mon, 09 Nov 2026 21:23:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1794255820;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=DFJE9dSe3PvFP6rKSZ8gBEuUX1m1CzOXcJ5hyc0QjE0=;
 b=KheVPuwzyX40oDjXJxgRBcw3dT/xnc2RsfyNRy6APYRl3fk3BTZKGXLzo3WcNo71Wb9fus
 Su05zPKiYL2fVmkcgbREH3MjPX8r58CxPOqPli3ykH9Y0bUTOrANBJ42BfyFy2ediG5Udg
 k3Qv+AKi5T7Ki98MY273QMMkqu1DE/Xd+xF2tkOR8HD1XviTuTcVQhEJ1Qe6MeiYHAzXrZ
 AZNLiT/uAS/9nHM7bJF7L4Tlep7KDlKqEQN/D0OYQHLIYuEffnKJyd1kSDC6vRHg2l5KBT
 vbaHkMiT0ffL+CEG0z1I1jWJI1NHiKgDU/5epszdDlH8QvD2x4xWysuUcWdijg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
To: u-boot@lists.u-boot-project.org,
	Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PULL] u-boot-sh/main
Date: Mon,  9 Nov 2026 21:23:04 +0100
Message-ID: <20261109202333.19229-1-marek.vasut+renesas@mailbox.org>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: f0a8e8c9d8e2ce5603d
X-MBO-RS-META: q8xb1pmdf9zbbr7fjqot4e7xfzprt8jh
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-23.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The following changes since commit 934995f642a21ca7f35fa9aed5f061394fcba243:

  Merge tag 'u-boot-imx-main-20261107' of https://git.u-boot-project.org/u-boot/custodians/u-boot-imx (2026-11-07 12:04:01 -0600)

are available in the Git repository at:

  https://git.u-boot-project.org/u-boot/custodians/u-boot-sh.git main

for you to fetch changes up to 57b87860d847a33a1425e0430abd665b9c088ee1:

  arm64: renesas: Reduce size on Renesas R-Car Gen3 Salvator-X(S) (2026-11-09 04:27:40 +0100)

----------------------------------------------------------------
Marek Vasut (5):
      clk: renesas: Add Kconfig symbol for conditional build of full clock tables
      clk: renesas: Minimize R8A77951 H3 clock tables
      clk: renesas: Minimize R8A77960 M3-W and R8A77961 M3-W+ clock tables
      clk: renesas: Minimize R8A77965 M3-N clock tables
      arm64: renesas: Reduce size on Renesas R-Car Gen3 Salvator-X(S)

 configs/rcar3_salvator-x_defconfig      |  6 ++++++
 drivers/clk/renesas/Kconfig             | 10 ++++++++++
 drivers/clk/renesas/r8a7795-cpg-mssr.c  | 18 ++++++++++++++++++
 drivers/clk/renesas/r8a7796-cpg-mssr.c  | 16 ++++++++++++++++
 drivers/clk/renesas/r8a77965-cpg-mssr.c | 16 ++++++++++++++++
 5 files changed, 66 insertions(+)
