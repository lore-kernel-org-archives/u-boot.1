Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B74C9C4452F
	for <u-boot@archiver.kernel.org>; Tue, 21 Jul 2026 02:59:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5EE51607AA;
	Tue, 21 Jul 2026 02:59:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NW7eChE3vlmf; Tue, 21 Jul 2026 02:59:24 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A652F607A2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784602764;
	bh=NhzRjV65UXvNY2mp3boZgdGxnJ+zFhdJlKDezoxWjyM=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=KGOoNCWuArh9DO09evg7hqmj1qWHwk/GkbfOT4KumjWxzeKww0hVlAhk6HQcWWDYB
	 idhhy2YKOoB4MwQqrHO3ONmqo9DDcx7UH4dbHU+QKyrV5NgzN/9ZeWqfRe55iwRw8z
	 +cfksRE/+JO2I2NWaQubLo+85UdrNGIp2RvCDcyOONU9uRlVBJN2x4jVkg8d5ZHOEB
	 8kEjCznwWWTSTwOjz6t6UGitqRjcybMl/hucKCRpUBEono1DkbDOOqU/NsXUP6pM99
	 fxVVV98CP05liYT+GJhAAuNs9eIkkyktSzg2ucpgDcWUv2uzTes64izVWGtsF8BK+j
	 lQNESBVxcgPgg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A652F607A2;
	Tue, 21 Jul 2026 02:59:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id BE77E1331
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 02:59:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A4DF440257
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 02:59:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kB1YLv_gFxTj for <u-boot@lists.u-boot-project.org>;
 Tue, 21 Jul 2026 02:59:23 +0000 (UTC)
X-Greylist: delayed 1466 seconds by postgrey-1.37 at util1.osuosl.org;
 Tue, 21 Jul 2026 02:59:22 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 9CAC5401D0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9CAC5401D0
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a07:2ec0:3002::65;
 helo=pidgin.makrotopia.org; envelope-from=daniel@makrotopia.org;
 receiver=<UNKNOWN> 
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9CAC5401D0
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 02:59:22 +0000 (UTC)
Received: from local
 by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.99) (envelope-from <daniel@makrotopia.org>)
 id 1wm0Jm-000000000KS-0Xlk; Tue, 21 Jul 2026 02:34:50 +0000
Date: Tue, 21 Jul 2026 03:34:47 +0100
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Daniel Golle <daniel@makrotopia.org>,
 Ludwig Nussel <ludwig.nussel@siemens.com>,
 Randolph Sapp <rs@ti.com>, Francois Berder <fberder@outlook.fr>,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v3 0/3] boot: fit: authenticate the dm-verity roothash
Message-ID: <cover.1784601041.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=makrotopia.org
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
From: Daniel Golle via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Daniel Golle <daniel@makrotopia.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

A signed FIT configuration can delegate the integrity of a (potentially
large) root filesystem image to the kernel's dm-verity instead of having
U-Boot hash the whole payload at boot: the FIT carries a "dm-verity"
subnode with the roothash, salt and block parameters, U-Boot passes the
roothash to Linux through the dm-mod.create bootargs, and dm-verity then
validates the filesystem block by block against it.

For that to be safe the roothash has to be trusted, and in a signed
configuration the only thing that establishes trust is the configuration
signature. The roothash was not covered by it. fit_config_add_hash()
collected the image node, its hash subnodes and its cipher subnode into
the signed region, but not the dm-verity subnode, so the roothash, the
sole integrity anchor for the filesystem, was left unsigned.

The result is a verified-boot bypass for the root filesystem: an
attacker who can rewrite the boot medium can replace the filesystem,
recompute a matching dm-verity tree, write the new roothash into the
unsigned dm-verity subnode, and the configuration signature still
verifies. dm-verity then faithfully validates the malicious filesystem
against the attacker's roothash.

This series closes the gap.

v3: address comments by Simon Glass
 * factor tools/image-host.c's node-path collection into patch 1 too,
   mirroring the boot-side helper, so both the sign side and the verify
   side share the same shape and stay easy to compare
 * use present tense for the pre-patch code description in patch 2;
   document the dm-verity subnode in the rebuilt node list in
   doc/usage/fit/signature.rst and note the signature coverage in
   doc/usage/fit/dm-verity.rst
 * in the unit test, bound-check fdt_find_regions()'s returned count
   the same way fit_config_check_sig() does, tamper the digest through
   the buffer instead of casting away const, and note in a comment that
   the digest check stands in for the whole dm-verity node
 * fix test_fit_verity_roothash_signed(), which never actually ran: its
   ITS baked the tmpdir prefix into the /incbin/() paths while dtc also
   resolves incbin paths relative to the .its file's own directory, so
   the path was searched doubled and mkimage always failed

v2: address comments by Tom Rini
 * drop the VISIBLE_IF_UT visibility macro; fit_config_get_signed_nodes()
   is now simply non-static (previously the function would end up being
   inlined, so there *is* a real cost to this)
 * document test_fit_verity_sign.py with pydoc docstrings including an
   ITS example, and add a page under doc/develop/pytest/ so the module
   is rendered in the generated documentation
 * collect Reviewed-by tags on patches 1 and 2

Daniel Golle (3):
  boot: fit: factor out node-path collection in fit_config_add_hash()
  boot: fit: cover the dm-verity roothash with the config signature
  test: fit: verify dm-verity roothash is covered by the config
    signature

 boot/image-fit-sig.c                        | 108 +++++++----
 doc/develop/pytest/test_fit_verity_sign.rst |  10 +
 doc/usage/fit/dm-verity.rst                 |   5 +
 doc/usage/fit/signature.rst                 |   2 +-
 include/image.h                             |  23 +++
 test/boot/fit_verity.c                      | 200 +++++++++++++++++++
 test/py/tests/test_fit_verity_sign.py       | 202 ++++++++++++++++++++
 tools/image-host.c                          |  94 ++++++---
 8 files changed, 578 insertions(+), 66 deletions(-)
 create mode 100644 doc/develop/pytest/test_fit_verity_sign.rst
 create mode 100644 test/py/tests/test_fit_verity_sign.py


base-commit: 042e45e026c77227319a426940577856ffe62e7b
-- 
2.55.0
