Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E9F606A32A
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 14:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=zLji3czq;
	dkim=pass (2048-bit key, unprotected) header.d=dolcini.it header.i=@dolcini.it header.a=rsa-sha256 header.s=default header.b=Y6P6V111
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7736E60C26;
	Wed, 11 Nov 2026 14:21:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id d8F1Xt4ZUhEf; Wed, 11 Nov 2026 14:21:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org AE56960885
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794406883;
	b=jaiHX5GNhpWUD/rOAJahvYAsZKWDjXSJx+DDWmcmm/6kPg/3WRv0qIIrd3Fx38yOIZGQ
	 mEg/X02pIHdG4slWblFGDYnrsl4icu3CS8vE58tylm2TQGHzA2cwDHyI2aujDa+sbKFyd
	 COThpqdO0xxkurUlzvlBdG5fmYpMhGi/2sTbDLDMuV8mwGAW9aMLOT2XpuUt1egjL2HCQ
	 fmHvjNgF1fMaZP0Jq+VzPpLz2iw9sCP2THt47sS/nIiZV3vF3hIhe8ldKDb/+i4ryI2UN
	 gRsOhQJA4z5GoEQ8lKE+afAHMg6t4N4lBqxlOAkZiOu1xERQAe7OWvgc9gX0vt5x9hQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794406883;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=FBvXJZeNeYVkgtnEDmYkMGhV62tMRDo+YyoMpUpgxB4=;
	b=bxk5u0f35DG6wFzgA37Hi7/Y6zWvSDYAE6JIPajWZcI6JS9HkCxLJpZt0sQVzV8YV0tf
	 Z6EBJcna5P/bubtOEYFTUu6iYlW1lSLcmE05T4CvsR/j6PzGO+iYrQIMIZ4wCDL0j79dg
	 S071QK3s9i1dYHMkq7DIR4DySwAb/N+MGM5b+SxVUzUFJfI31WMZvy6g56iT9stFVsPeq
	 XOKKIYYLt3CsXNMXrswXt+GLcuoBcndl+Z/NhwvB8XZyCcuhR/i/uB3wQ7Ss8VOKlz28X
	 NbQJoLxIsi0hQzEzg5ex75HBI8jKnVreqPW+2x/OmA8KJyCrG0YvT1irddXniVoHrGg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794406883;
	bh=FBvXJZeNeYVkgtnEDmYkMGhV62tMRDo+YyoMpUpgxB4=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=zLji3czq8q0abCH5l+sbZ2BgHHmpkJUKjRevxqc57KgZE+xUIzvtF65Ar8M4ZWTZ9
	 PEY9TW1q9O39YkZ1TZ08FwSgOJ+eI1obfR3hSXOtnMZSCgRVRh6n8Y7YpLEpOR6cEo
	 edu8ke1+Xq1I/O3qM/LhoJZkYz4xMbRjAU9atT1KuHQLWHVLqgyiuBnijFtbAmkY9A
	 JTRnmI7F3rtMYTzD08bmCq00XT3TsP/oQcbtMZHhO4eDMiCEYEv9o7JeL9QHwWLYNc
	 /A3fRdKdn54gj4Bd4rRKBNDUY6jHHLclZrWDyI7Q6m+N+HgJzrylTvpeH+f/8U8SyO
	 FbMCHeTyWqLaA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id AE56960885;
	Wed, 11 Nov 2026 14:21:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id C60CC17CC
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 14:21:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A8B8A403C3
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 14:21:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bJkCJoh0l_2u for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 14:21:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 1395E403A8
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=217.194.8.81
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.194.8.81;
 helo=mail11.truemail.it; envelope-from=francesco@dolcini.it;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=dolcini.it header.i=@dolcini.it header.a=rsa-sha256
 header.s=default header.b=Y6P6V111
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1395E403A8
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 14:21:14 +0000 (UTC)
Received: from francesco-nb.. (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 0A0331FB32;
 Wed, 11 Nov 2026 15:21:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1794406871;
 bh=FBvXJZeNeYVkgtnEDmYkMGhV62tMRDo+YyoMpUpgxB4=; h=From:To:Subject;
 b=Y6P6V111Ok1gXn2+BeLS0OBBu6esISjA4gOxb6FiWk2NyoH8Ng3TFhw4dPiG7rs4C
 aA70JpCrHIZ09yqxCiL2t1I+FX435fbkhg/75cxHxeOz9x9rwXdNEbEFoGBd0756Qw
 JJtZ7NaYHO12mhteFBKsS+1ByReD71sI6uJpfr4dYyXiZ47FHnPFBXJ05lAS12CSOC
 7wapJ3pah7SyI07D5ssAe/5+NbVlgylYxv0R9VbDid/mJo+ou8ihico/1UqVaIjw98
 ME2hCNHKGYbZuX7PBaWtzllV58802DR7DzG1PSwNIo9IE5PLROWm9erzXBrV7xujwn
 A3dYvtFyAlSmQ==
From: Francesco Dolcini <francesco@dolcini.it>
To: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
Subject: [PATCH v1 00/15] board: toradex: misc cleanups
Date: Wed, 11 Nov 2026 15:20:48 +0100
Message-ID: <20261111142104.109139-1-francesco@dolcini.it>
X-Mailer: git-send-email 2.47.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Francesco Dolcini <francesco.dolcini@toradex.com>

A small series with small and misc cleanups on Toradex boards (based on next)

Francesco Dolcini (15):
  board: toradex: tdx-cfg-block: fix carrier config block buffer
    over-read
  board: toradex: smarc-imx8mp: fix always-false phandle check
  board: toradex: aquila-am69: initialize ret in spl_board_init()
  board: toradex: apalis_imx6: fix do_fuse argv[1] NULL deref
  board: toradex: colibri_imx6: fix do_fuse argv[1] NULL deref
  board: toradex: apalis-imx8: report detected SoC variant in board_name
  board: toradex: colibri-imx8x: report detected SoC variant in
    board_name
  board: toradex: colibri_imx7: un-nest board_late_init from
    CONFIG_USB_EHCI_MX7
  configs: verdin-imx8mm: remove empty #if/#endif block
  board: toradex: apalis_imx6: remove dead ldo_mode_set()
  board: toradex: colibri_imx6: remove dead ldo_mode_set()
  board: toradex: apalis_imx6: drop dead TDX_APALIS_IMX6_V1_0 Kconfig
    option
  board: toradex: common: fix stale #endif comments in tdx-common.c
  board: toradex: apalis_imx6: fix stale #endif comment in
    board_late_init()
  configs: colibri_imx7: add missing defined() in EMMC #elif

 board/toradex/apalis-imx8/apalis-imx8.c     |  2 +-
 board/toradex/apalis_imx6/Kconfig           | 10 ----------
 board/toradex/apalis_imx6/apalis_imx6.c     | 10 +---------
 board/toradex/apalis_imx6/do_fuse.c         |  4 ++--
 board/toradex/aquila-am69/aquila-am69.c     |  2 +-
 board/toradex/colibri-imx8x/colibri-imx8x.c |  2 +-
 board/toradex/colibri_imx6/colibri_imx6.c   |  8 --------
 board/toradex/colibri_imx6/do_fuse.c        |  4 ++--
 board/toradex/colibri_imx7/colibri_imx7.c   |  3 +--
 board/toradex/common/tdx-cfg-block.c        |  2 +-
 board/toradex/common/tdx-common.c           |  4 ++--
 board/toradex/smarc-imx8mp/smarc-imx8mp.c   |  2 +-
 include/configs/colibri_imx7.h              |  2 +-
 include/configs/verdin-imx8mm.h             |  4 ----
 14 files changed, 14 insertions(+), 45 deletions(-)

-- 
2.47.3

