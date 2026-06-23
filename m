Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0669FCDB466
	for <u-boot@archiver.kernel.org>; Tue, 23 Jun 2026 01:39:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D460A849BB;
	Tue, 23 Jun 2026 03:39:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="jxrFZpzx";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="XXwtC9D0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E897A849D2; Tue, 23 Jun 2026 03:39:39 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 27E3E848DC
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 03:39:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4gknmm477sz9v0L;
 Tue, 23 Jun 2026 03:39:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1782178776;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=dUp3Q2SQWzy7nB0rgydpk59Eg54C+qBcNrsAaAV5Cy0=;
 b=jxrFZpzxyysj4/BBlm6SJq+hSyDulQTFw6E9Ll5Ky/UhyCM5EQbRlzmahnGsrhjEIAGc8F
 GILaRvCrndVXnUWi+whCQU/zfSjz5JJEnjsHgaUWqhFgd8TwkAXwCJf2qdwYvjfpnLYnwo
 wVaHH5+JRSa2iN+pm5TnXwoIRL+udjclo6HZ6ygVYx9Q12fJzJEg+nTnYx442Us9PPIXJk
 T4cSUGtbXOgojIrdV+G6GkwgAT+LpkrJ7chTmW1KpwEqCgqKWwgO5slBl+zTzy9z67vur7
 icSQX2JPbPEG/QIFtj4vhFLF1Oqxj+vkSroU2KvHG8QJb0MCtiNdqj01I4Khzg==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=XXwtC9D0;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1782178775;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=dUp3Q2SQWzy7nB0rgydpk59Eg54C+qBcNrsAaAV5Cy0=;
 b=XXwtC9D0y1SoM8AjG0OrFnbBf60kdBCLW912wf4ZpKgR03bQ4O9lJKcGoOSbaakOz0SuMY
 JNjfZmo1QeCcYX2aD8CYmPoChVUY4Eb7azTZ5WbayBrbWhD+qPpzRgOXbPnseWG+jJ4Gx+
 IpZMXBBoAGNz0JZb05bTv+TGqfm58oCNyAZLIdhiB5gL52yrAvRCmhyCAbxrRfy9wZTsua
 2UYF8MYBS83ceiFtFsJB1mPCZfLS+x6gr+ziiaAHmRWDZnnQJy0E/PMpQpEtepHwkBx6YB
 rTgjZ5wycWoIdVghJaQ+ktcsx3iuIuFUvIahtbgXPhR2p93L2ig3n51ZjwOCBQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 00/11] doc: board: renesas: Update Renesas documentation
Date: Tue, 23 Jun 2026 03:38:26 +0200
Message-ID: <20260623013929.114641-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 0410bba6353f87d2d92
X-MBO-RS-META: 6pca61sxse6jh7hgy74hu87sfbxocybh
X-Rspamd-Queue-Id: 4gknmm477sz9v0L
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Update and expand the Renesas documentation. Fill in toolchain setup pages,
U-Boot build and installation pages for a subset of Gen3, Gen4, Gen5 SoCs,
rework the toplevel hardware table into grid layout to improve its readability.

Marek Vasut (11):
  doc: board: renesas: Document SH/Aarch32/Aarch64 toolchain setup
  doc: board: renesas: Document Aarch32 toolchain setup in RZ/N1
  doc: board: renesas: Document Renesas R-Car Gen3 H3/M3-W/M3-N
    Salvator-X(S) board
  doc: board: renesas: Document Renesas R-Car Gen3 H3/M3-W/M3-N ULCB
    board
  doc: board: renesas: Document Renesas R-Car Gen3 M3Le Geist board
  doc: board: renesas: Document Renesas R-Car Gen3 E3 Ebisu board
  doc: board: renesas: Document Renesas R-Car Gen3 D3 Draak board
  doc: board: renesas: Document Retronix R-Car Gen4 V4H Sparrow Hawk
    board
  doc: board: renesas: Document Renesas R-Car Gen5 X5H Ironhide board
  doc: board: renesas: Update Renesas generic build section
  doc: board: renesas: Convert Renesas board support table to grid table

 doc/board/renesas/build-env-aarch32.rst      |  25 ++
 doc/board/renesas/build-env-aarch64.rst      |  25 ++
 doc/board/renesas/build-env-sh.rst           |  25 ++
 doc/board/renesas/index.rst                  |  13 +
 doc/board/renesas/rcar-gen3-draak.rst        |  47 +++
 doc/board/renesas/rcar-gen3-ebisu.rst        |  47 +++
 doc/board/renesas/rcar-gen3-geist.rst        |  45 +++
 doc/board/renesas/rcar-gen3-install-hf.rst   |  76 ++++
 doc/board/renesas/rcar-gen3-install-sf.rst   |  29 ++
 doc/board/renesas/rcar-gen3-install.rst      |  34 ++
 doc/board/renesas/rcar-gen3-salvator-x.rst   |  48 +++
 doc/board/renesas/rcar-gen3-ulcb.rst         |  49 +++
 doc/board/renesas/rcar-gen4-sparrow-hawk.rst |  91 +++++
 doc/board/renesas/rcar-gen5-ironhide.rst     | 204 +++++++++++
 doc/board/renesas/renesas.rst                | 353 +++++--------------
 doc/board/renesas/rzn1.rst                   |   2 +
 16 files changed, 858 insertions(+), 255 deletions(-)
 create mode 100644 doc/board/renesas/build-env-aarch32.rst
 create mode 100644 doc/board/renesas/build-env-aarch64.rst
 create mode 100644 doc/board/renesas/build-env-sh.rst
 create mode 100644 doc/board/renesas/rcar-gen3-draak.rst
 create mode 100644 doc/board/renesas/rcar-gen3-ebisu.rst
 create mode 100644 doc/board/renesas/rcar-gen3-geist.rst
 create mode 100644 doc/board/renesas/rcar-gen3-install-hf.rst
 create mode 100644 doc/board/renesas/rcar-gen3-install-sf.rst
 create mode 100644 doc/board/renesas/rcar-gen3-install.rst
 create mode 100644 doc/board/renesas/rcar-gen3-salvator-x.rst
 create mode 100644 doc/board/renesas/rcar-gen3-ulcb.rst
 create mode 100644 doc/board/renesas/rcar-gen4-sparrow-hawk.rst
 create mode 100644 doc/board/renesas/rcar-gen5-ironhide.rst

---
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de

-- 
2.53.0

