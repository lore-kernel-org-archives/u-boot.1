Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA243606A325
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 13:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=OqAsYexH;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fhPkr4RD
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4419560744;
	Mon,  9 Nov 2026 13:28:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZSG-H2h6jleD; Mon,  9 Nov 2026 13:28:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 496C3605EA
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794230917;
	b=PK97EJCviUacPQjT6qTAGL/g2ZR+UxjnxVGZRK5xSD9QmWhchgVmimN3AWYvcU8/Mn7I
	 UrEOGiVY5lXCP+tPTebyVIUZm7dbGBQORIzcD8ma6X9facKpq4X+yy/x6sWxoF1eq8Bg/
	 ScTI7YTqJdl9MkxzvQv2OodhALHp1ZwGyIK7uXNFaGzjXatZJLdlrnwn8EGD1uQBgmd6T
	 nWEyUb6Mbf9/0Tb2ldDaTYcRj7N5z4eZQfVFAN93kVPy3tzQRhZV6eikkvtkmD/K11WV0
	 Szf3fWdyOGRS24YCzJbBLRnG9ituTnbTQQegPoonCsQ6mclqFUbCB2dFryvdK+RxRvw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794230917;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=j4cOi0FjlAEGNTtunZ9YjfIMNDradjU5+DoblHwVQdQ=;
	b=WQ+CjkAcrZoVyWjqCMzA9WVEoEt9KczPRnlziM1LEwmVGvYOnDExKdeklmZcNWKapdGX
	 jgyRjnEfmB0aub7mowUmYQmSDaaO17mJjtMBXJht7eyGtM6ErP2bHPaKv4tYq7AX6Z5/e
	 CyDemhxSAopxwPBXCA0u+D9wpeZ8dbHmEcQIUXJPP/ckvng5QZaqjngcqdxjjkpCJdOB8
	 DiCzJ2iny0Cx+FIsiFiWAPPAFMJBNg8dTFqivo1QBB+WVTt4IVxP3hDuDRJlFC4JHtrZf
	 yoV2il5BdrLs6IFHopfJ98JpmTS9On15Esqi2NrMBw52iTfzI3ztGGl0zFNeIn/1U7Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fhPkr4RD;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794230917;
	bh=j4cOi0FjlAEGNTtunZ9YjfIMNDradjU5+DoblHwVQdQ=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:From;
	b=OqAsYexHrTMJLAhyfjlTkNzYBdH9vei11iHpUeUVg26p3bnLEyYKKi7XkQTD6Xx6A
	 5H168HdlPW40EAPjV6p+mMAPbCRF0du610Y3GvC//VSCvl5tAdk/ESDzpGzqFLHg9n
	 T/YS0IzXQwedJFSj+REAj5v4467M6YETlBS/Zi8p/2wC4pJrDEczpHwdo57dN/N8gA
	 37GdUGcaNIqI4O7s2VjdG5SP/Tfxp4TVtAvH0dwyYy8BbENisR9/BHCdGtCCmOrID+
	 4q5dTqEDqaFpU9q2QVW0c1dxJi6ksjrSNVqklneXNSzl0FfbixXC5dQfoKncSRtgYM
	 vM9gtdrVpjDGQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 496C3605EA;
	Mon,  9 Nov 2026 13:28:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id BBDD4235
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 09:39:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AD43F605F0
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 09:39:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id S-Jrb06JXRi3 for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 09:39:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A1970605EF
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org;
 envelope-from=devnull+takahiro.kuwano.infineon.com@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=fhPkr4RD
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A1970605EF
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 09:39:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2B024404DF;
 Mon,  9 Nov 2026 09:39:55 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 5F39D1F0089F;
 Mon,  9 Nov 2026 09:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794217195;
 bh=j4cOi0FjlAEGNTtunZ9YjfIMNDradjU5+DoblHwVQdQ=;
 h=From:Subject:Date:To:Cc:Reply-To;
 b=fhPkr4RDBT6wlA7bSlwZ0nPmu7uWZCq57t/a8B1mQY1Tbkvz/CJno+JgP1ruvrI9U
 CifIlxCUKH3Yr2KWZYVQmtKb55awpgJw6f2UOYlR3khQ0gf7LN6Xnmnsccbm4Bs1Lx
 GSdctShnrfJpnXgFmw76mQL8Bq77TiKszVJ17nVI1aYXLtBPxEDIVmIid2ljBaDAfQ
 KVJ+AE67RcHE50jVvBI8IVdByZYs4OqmUGZHbuOjc9BDcKrGVqUS4VeKMGIsOGCarP
 zLRmOd/qSDyTNSnXmsfRykBmJy+beLMLGpFiAcSwc4nPWaxpIeycXAtgHtpXdBSQJd
 Bn8MBuUfe4/Ag==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id B5241483AA;
 Mon,  9 Nov 2026 09:39:53 +0000 (UTC)
From: Takahiro Kuwano via B4 Relay
 <devnull+takahiro.kuwano.infineon.com@kernel.org>
Subject: [PATCH v4 0/5] mtd: spi-nor: split SFDP, ID database, and fixups
Date: Mon, 09 Nov 2026 18:39:40 +0900
Message-Id: <20261109-split-sfdp-id-v3-v4-0-7270c9d82fd3@infineon.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NQQ7CIBREr9L8tRhKAbUr72G6QAr2JwqE3xBNw
 93FHsBkNm8mM7MBuYyOYOw2yK4gYQwN5KEDu5jwcAznxiC40D3vNaP0xJWRn1NLWBmYV5oLOSi
 jJIdWS9l5fO+Tt6nxgrTG/NkfyvBz/4w1cSaNPN3P3l6kMlcMHoOL4WjjC6Za6xeBChAEswAAA
 A==
X-Change-ID: 20261016-split-sfdp-id-v3-f5602435a540
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Vignesh R <vigneshr@ti.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, Vincent Jardin <vjardin@free.fr>, 
 Fabio Estevam <festevam@nabladev.com>, Eugen Hristev <ehristev@kernel.org>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Takahiro Kuwano <takahiro.kuwano@infineon.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794217192; l=3697;
 i=takahiro.kuwano@infineon.com; s=20261016-2; h=from:subject:message-id;
 bh=bIq6ZaahP+3kiESB3cK50by3HMWQLrcf+ZaQXKb08Rk=;
 b=gWD6B+n9Y1l1Fh+OYX6jT13TlQzIsfvysApFyWbFeLGRzorOtdKtwTfrTaKyNwGtlE1OH1z6E
 NOKasGkSo1VCO8jPFJ5R3RdVO09ql4gkMm0k9/dVP8DyDKJzZzex7aP
X-Developer-Key: i=takahiro.kuwano@infineon.com; a=ed25519;
 pk=pp4mpJAHIqhV2MvdSGbIzKRk3ujhk+tSlGjyTursr4E=
X-Endpoint-Received: by B4 Relay for
 takahiro.kuwano@infineon.com/20261016-2 with auth_id=1202
X-Original-From: Takahiro Kuwano <takahiro.kuwano@infineon.com>
X-Mailman-Approved-At: Mon, 09 Nov 2026 13:28:36 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Reply-To: takahiro.kuwano@infineon.com
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The spi-nor-core.c contains optional logics like SFDP and manufcaturer
specific fixups. The spi-nor-ids.c has single large ID database. There
are many #ifdef directives in those files and that negatively affects
readability and maintainability.

This series, as the first step of cleanup, move SFDP logic, IDs, and
fixups to newly source files. Reworking, renaming, and reformating
existing code is not a scope of this series and further cleanup will be
taken place in follow-up patches.

To mitigate the size increase due to these changes, drop one of the
page size parameter from struct flash_info. The resulting size is
smaller than it was before the patch was applied (see below).

Here is the code size impact when applying this series.
Measured by my AMD Zynq-7000 (ARM32) environment with SFDP and all
manufcaturers are enabled.

SPI-NOR:
            text    data     bss     dec     hex filename
BEFORE    722344   14100       0  736444   b3cbc u-boot
AFTER     722196   14188       0  736384   b3c80 u-boot
DELTA       -148     +88             -60

TINY:
            text    data     bss     dec     hex filename
BEFORE     77490    3128     248   80866   13be2 spl/u-boot-spl
AFTER      76342    3200     248   79790   137ae spl/u-boot-spl
DELTA      -1148     +72           -1076

Changes in v4:
- Rebase to v2027.01-rc1
- Add patch 5 to reduce the size of device ID database
- Link to v3: https://lore.kernel.org/r/20261016-split-sfdp-id-v3-v3-0-4a47b8fc945a@infineon.com
Changes in v3:
- Expose manufacturers table so that sandbox can look up
- Update sandbox to handle manufacturers table
- Link to v2: https://lore.kernel.org/u-boot/20260924-split-sfdp-id-v2-0-aafc70e0b657@infineon.com/
Changes in v2:
- Rebase on top of next
- Link to v1: https://lore.kernel.org/u-boot/20260612-split-id-table-into-vendor-files-v1-0-dfaaa82cc6f0@infineon.com/

Signed-off-by: Takahiro Kuwano <takahiro.kuwano@infineon.com>
---
Takahiro Kuwano (5):
      mtd: spi-nor: move SFDP logic out of the core
      mtd: spi-nor: import manufacturer driver concept from Linux
      mtd: spi-nor: move flash info entries to manufacturer drivers
      mtd: spi-nor: move fixups to manufacturer drivers
      mtd: spi-nor: remove page_size from struct flash_info

 drivers/mtd/spi/Makefile        |   18 +
 drivers/mtd/spi/atmel.c         |   28 +
 drivers/mtd/spi/dosilicon.c     |   27 +
 drivers/mtd/spi/eon.c           |   23 +
 drivers/mtd/spi/fujitsu.c       |   47 +
 drivers/mtd/spi/gigadevice.c    |  141 ++
 drivers/mtd/spi/issi.c          |   84 ++
 drivers/mtd/spi/macronix.c      |  154 +++
 drivers/mtd/spi/micron-st.c     |  169 +++
 drivers/mtd/spi/puya.c          |   56 +
 drivers/mtd/spi/sandbox.c       |   33 +-
 drivers/mtd/spi/sf_internal.h   |  137 +-
 drivers/mtd/spi/sfdp.c          |  720 ++++++++++
 drivers/mtd/spi/sfdp.h          |  152 +++
 drivers/mtd/spi/siliconkaiser.c |   18 +
 drivers/mtd/spi/spansion.c      |  700 ++++++++++
 drivers/mtd/spi/spi-nor-core.c  | 2753 +++++++--------------------------------
 drivers/mtd/spi/spi-nor-ids.c   |  756 +----------
 drivers/mtd/spi/spi-nor-tiny.c  |   11 +-
 drivers/mtd/spi/sst.c           |   34 +
 drivers/mtd/spi/winbond.c       |  250 ++++
 drivers/mtd/spi/xmc.c           |   27 +
 drivers/mtd/spi/xtx.c           |   54 +
 drivers/mtd/spi/zbit.c          |   19 +
 include/linux/mtd/spi-nor.h     |    2 +
 25 files changed, 3428 insertions(+), 2985 deletions(-)
---
base-commit: 709a97a05df66e394f40d249105d0baade46f107
change-id: 20261016-split-sfdp-id-v3-f5602435a540

Best regards,
-- 
Takahiro Kuwano <takahiro.kuwano@infineon.com>


