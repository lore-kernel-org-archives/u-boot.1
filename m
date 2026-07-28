Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E922FC53219
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 22:09:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 87ED88118D;
	Tue, 28 Jul 2026 22:09:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aD6yg2PdS_KF; Tue, 28 Jul 2026 22:09:43 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B32F981124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785276582;
	bh=t+eMD13UUA7kwjfOp6RItLWXXQoTcTDeVSqc2G195aQ=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ikM4Q380Kw19fd9hWXatOnBU1uYWk1Y3Aaixcsh71lAL4JEXhp0rxgl5srwa0Kbtk
	 J0m3S15B+PDfXd5+0Zb3A6Mujx7CnArgSkNqUZ2pLa/HAAxuQIy34UrRASdHHF+U6x
	 rzXLCCcPv5JbOCkRTtYd2rH+hhVY0sM4EWOtGJb4pGt7HxqMa9elxVE/JyKxnZA5ow
	 y0FK31H/3CDVREWgfpNHSrCfrv7PYjIZA3RrHZ4scqoZbYXHI9+WDo2j5ppQTsvBwm
	 r78dEdNvFAyzTWpF+xHiuy78ZEGW8SCQLpFJRpU8/45VOX6mVbZrgxi51Osky2TINC
	 UJVwxMz+b3MZw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B32F981124;
	Tue, 28 Jul 2026 22:09:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id CD50D42A
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 22:09:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B367460A6A
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 22:09:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YR6e8KCljg7k for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 22:09:40 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a07:2ec0:3002::65;
 helo=pidgin.makrotopia.org; envelope-from=daniel@makrotopia.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org A926C606D3
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A926C606D3
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A926C606D3
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 22:09:39 +0000 (UTC)
Received: from local
 by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.99) (envelope-from <daniel@makrotopia.org>)
 id 1wopzR-000000002D7-0A7k; Tue, 28 Jul 2026 22:09:33 +0000
Date: Tue, 28 Jul 2026 23:09:30 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Daniel Golle <daniel@makrotopia.org>,
 Ludwig Nussel <ludwig.nussel@siemens.com>,
 Randolph Sapp <rs@ti.com>, u-boot@lists.u-boot-project.org
Subject: [PATCH v4 0/3] boot: fit: authenticate the dm-verity roothash
Message-ID: <cover.1785276461.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
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

v4: fix the CI failure Tom Rini reported
 * test_fit_verity_roothash_signed() built a FIT with a dm-verity
   subnode, which makes mkimage shell out to veritysetup internally to
   compute the Merkle tree/roothash, but the test only declared dtc,
   fdtget, fdtput and openssl as required tools. On the CI image, which
   doesn't have veritysetup installed, mkimage's internal exec of it
   failed silently (the diagnostic goes to a private pipe mkimage uses
   to parse veritysetup's output, not to stderr) and the test hard
   failed with "Can't add verification data ... (Input/output error)"
   instead of skipping, the way test_fit_verity.py's veritysetup-using
   tests already do via the same marker.
 * add @pytest.mark.requiredtool('veritysetup') to
   test_fit_verity_roothash_signed(), matching test_fit_verity.py
 * collect Reviewed-by tags from Simon Glass on all three patches.
   Simon also asked, on this cover letter, whether the series should
   spell out the compatibility break explicitly (an image with a
   dm-verity subnode signed by an older mkimage stops verifying, and
   vice versa); resolved in-thread since there are no real-world
   deployments of this mechanism yet, only the upcoming OpenWrt bootstd
   use case -- no documentation change needed for this revision
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
 * kept Reviewed-by tags on patches 1 and 2: neither change invalidates
   what was reviewed, the diffs are mechanical/cosmetic
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
 test/py/tests/test_fit_verity_sign.py       | 203 ++++++++++++++++++++
 tools/image-host.c                          |  94 ++++++---
 8 files changed, 579 insertions(+), 66 deletions(-)
 create mode 100644 doc/develop/pytest/test_fit_verity_sign.rst
 create mode 100644 test/py/tests/test_fit_verity_sign.py


base-commit: b635d43bca429500cb8ef20aa151cb5773b9a8a5
-- 
2.55.0
