Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AA34C982FA
	for <u-boot@archiver.kernel.org>; Wed, 23 Sep 2026 11:51:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A7B0D80E7B;
	Wed, 23 Sep 2026 11:51:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iGTzdN_DUBPG; Wed, 23 Sep 2026 11:51:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 0EA4580E0C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790164264;
	b=DiKG2HaABIf5mMP08pNQPb2zep4cLXeAyn8MVEPvgRG8oG8pUGVy2Cw4fow1Ad6TvjO5
	 pTPCMeYtwOd5Xs+buGog6aLmhYnVqHTRVjNpJ4jnRPmo0vvMvx6QxLnOalPoWl8wlxgIQ
	 ELjDUOB2ou4DPL7igNA7PgJIz1I7v/pC4xjwlXum8yoTI1TIXnFlqiQxOwz665KlduhVy
	 L8KpPpXb2cCsahk69FaTf75dIREJZAQsqcBAYRfy84tk/j2JBNT1xextn9kT/0yQ+22cA
	 UxeJFeHVRKyAT87ZQCUL2inDuSYX23R18nJCV9WPfWdkCZ7W5XIYqkxvwwWORkEXYjQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790164264;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:X-Flowmailer-Platform:
	 Feedback-ID:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=onuLGF9HNKSbBlWfRFNwj2FSxMtCnL9tUI5W9cwxPok=;
	b=geykBjaViAq+5ulbji69+74y8KhgC8zvTqHLTGwpeBVuscK7YhxdSrb9dPPyvmZZJw/2
	 r61TGUS2G8NnPbQicSjCL1gPvx6FZ7D3VL6SRv1ot/oxOMRqfTVBE111CCXlx6VcK4O3a
	 LpMbIzx+NpKlp3MfOemOb61MLT1Evtahqiu+AmpD4EDKZU8jNk/XsrCEI0XfPkaOgXGCf
	 RF/d0mA2W/7qmyn8ExKLqomuXmU2mXDRIoxzdy43+pKH/6RF5u7U5VJHnHKOjVRS2KNsp
	 1nFWEu5wOE6ISYR/qQ8cARQkAMOYlwSn9r+3lvBx9XNNBrD3ps7bMIN4JZVzphPAvcg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790164264;
	bh=onuLGF9HNKSbBlWfRFNwj2FSxMtCnL9tUI5W9cwxPok=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=DO2Lguz40Tq7gkE0I7wZpNSDGSX5VPGVROzo226Obo5e2jHXYbI7aBqNu6DKuB+5k
	 iw89JtDDWTZpFILVuW9ycrFjzYmo8gG8/OdhW+AlbgtMmXWa8Maerabs05POd73FH1
	 x6z+4C2Xv3FjnlTCDoa6KjByCVrdG5qiDNffVA8aF9mPesRlkIRU4AznQKFMBqjTYc
	 SB8w9u+ZzzMLCIokVcZZ8/NmJTd5xp0yJ7MveY2dMl2XCHfvC/uY/R51hWSZjYSupk
	 HaE2DRoQOCSAJMl9/X7e5T4+LLCYXuOVBUmM5IPnce2nt1ZtTNY8I5ZlWgaRIxCggV
	 yYA7nSPler5CA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0EA4580E0C;
	Wed, 23 Sep 2026 11:51:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id C3D3D35A
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 11:51:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B1E30406F2
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 11:51:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FCg5AKwKcg1j for <u-boot@lists.u-boot-project.org>;
 Wed, 23 Sep 2026 11:51:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org EE357406D7
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=185.136.65.228
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790164261;
 b=C4NL5GllHdVFuWTh0OTzGIugUaxVN0gS++pEMI76YUePSbtEs7gMVY8hPYtGGaO4xw+3
 nOUABJmV7jweosSwQtGfqUW2QO5E+SP1hchNYgXzScotCa311kFvEfTSS0VDxCc2cKVl2
 /c50shPvxSyNdOt4+8r16n+Iapp3/58KX1vaumZ8tcn42QzvbA1TlLiwXygdCqqAfJjtn
 1G4jiM6ohhlTyVVvJZ1gC6KQiX0+8OeZGzeI3VuXTxm2dkCnDkt06d+E4lVVJ8ZBOg4K1
 DD8ujIZt25kc1SeU6rGzmCKWlr4gkrcRr/7etrLI1UuFTryQEFzzKkzgI7c38aqKIpg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790164261;
 h=X-Greylist:Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:MIME-Version:Content-Transfer-Encoding:
 X-Flowmailer-Platform:Feedback-ID;
 bh=onuLGF9HNKSbBlWfRFNwj2FSxMtCnL9tUI5W9cwxPok=;
 b=GcFJRr7buA0pKnpanMWOZko+c5rCQDP4YzNJhCEwOJEs5J/NRuGbejRmQ+jgAwiUMHg2
 sbnHAlRnaS1qH+wFUZZHbDUxsJKEy95BbdTnTAGQRJ5nDPkN4x/7Mz0daBcvwrONmOKXh
 AVRpvOUCufl/2JUyW0ujYivJ4iFIzZAQ/dHqhpFRHYczbbDsQ+zolKnXUF/p5sYbcLOOY
 txEzUXaO9stWl5vnPqlxkh5xVFVXf/RM5SP/95hxCml3HWnQz0+0EBq3HnSalUngHdXSd
 51F7YU06jXaoqxO8V28ViANzKOgfUqS6SUWVTkR64FJo0L5lbZMtKUm3b2f6cMgAoHg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=siemens.com; 
 dkim=pass header.d=siemens.com header.i=ludwig.nussel@siemens.com
 header.a=rsa-sha256 header.s=fm1 header.b="r4C//JDq"; 
 arc=none smtp.remote-ip=185.136.65.228
X-Greylist: delayed 64 seconds by postgrey-1.37 at util1.osuosl.org;
 Wed, 23 Sep 2026 11:51:00 UTC
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=siemens.com header.i=ludwig.nussel@siemens.com
 header.a=rsa-sha256 header.s=fm1 header.b=r4C//JDq
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.136.65.228;
 helo=mta-65-228.siemens.flowmailer.net;
 envelope-from=fm-1328817-202609231149520f883f9083000207b3-2sfbvg@rts-flowmailer.siemens.com;
 receiver=<UNKNOWN> 
Received: from mta-65-228.siemens.flowmailer.net
 (mta-65-228.siemens.flowmailer.net [185.136.65.228])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EE357406D7
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 11:51:00 +0000 (UTC)
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id
 202609231149520f883f9083000207b3
 for <u-boot@lists.u-boot-project.org>;
 Wed, 23 Sep 2026 13:49:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=ludwig.nussel@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=onuLGF9HNKSbBlWfRFNwj2FSxMtCnL9tUI5W9cwxPok=;
 b=r4C//JDqq4/XapWm1krMOKTbn/q3zSog2o4ztR6+K+y3dcyQ+dQyCvzeeZo0WF9qeU2lpo
 P+2XA0WXxrKThYd9+di/s2eBdT9knzjJS+66VZOyhlcKigsO7zTN9la60FGhI3LLciVKJuQc
 qkv1u8NH6TMBFKn9JgG/68t+L0JfFJp+GFuE2reYH3j2EBKYjOaHXAZsTI96HJjqRwwJ97pm
 J0lyQSkMGHGUrs8KDHijbvhAxRij2sDZdv40kR2kDXFzbl7Qr4PgInHO8B1ZAqrBnAkxN1ex
 PJU9L9zAreL1MOB7AOa1N4xTAz9zErNAOkSnb3aN4+580zJ+ZCCuLbow==;
From: Ludwig Nussel <ludwig.nussel@siemens.com>
To: u-boot@lists.u-boot-project.org
Cc: Ludwig Nussel <ludwig.nussel@siemens.com>,
 Alexey Charkov <alchark@flipper.net>, Anton Ivanov <anton@binarly.io>,
 Aristo Chen <aristo.chen@canonical.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 James Hilliard <james.hilliard1@gmail.com>,
 Johan Jonker <jbx6244@gmail.com>,
 Mehmet Fide <mehmet.fide@screeningeagle.com>,
 Raymond Mao <raymondmaoca@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
Subject: [PATCH v10 0/7] Improve FIT signature handling
Date: Wed, 23 Sep 2026 13:49:27 +0200
Message-ID: <20260923114940.349985-1-ludwig.nussel@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1328817:519-21489:flowmailer
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

This patch series tries to improve dealing with FIT
(configuration-)signatures a bit:
  - make signatures work with QEMU. QEMU brings it's own device tree at
    a memory address. U-Boot expects public keys in it's own DT though.
    So merge both.
  - (optionally) enforce signatures so we can't accidentally boot
    unsigned fit images. Quite an easy oversight, esp when qemu
    previously didn't even use the built in DT.
  - make iminfo verify configuration signatures, not just image hashes

- Note: commit 68e65953400 introduced forcing OF_OMIT_DTB which is
  incompatible with the intent of the qemu DT merging feature, ie merge
  built-in signature nodes into qemu's DT. To be sorted out at some
  point.


Changes in v10:
- fix description referring to CONFIG_FIT_REQUIRE_CONFIG_SIGS
- rebased on next (0a61439db5e)

Changes in v9:
- restore debug message instead of errro

Changes in v8:
- fix smbios test

Changes in v7:
- add guard for OF_LIBFDT_OVERLAY
- mention CONFIG_FIT_REQUIRE_CONFIG_SIGS in documentation

Changes in v6:
- fix comment style and typos
- fix error message
- return error from board_fdt_blob_setup() if dt couldn't be resized or
  merged. Unfortunately fdtdec_ret_to_errno() is static elsewere so
  -EINVAL has to suffice
- mention CONFIG_OF_OMIT_DTB in commit message
- move 'ret' declaration to top of block
- Add missing return value documentation to run_fit_commands()
- use f-strings for the refactored code
- drop not needed length check for command list
- remove superfluous blank line

Changes in v5:
- refactor ubman.config.buildconfig access
- reword commit message to mention disabling of pre-load global
  signature test
- rely on inline dummy for fit_all_configurations_verify
- use CONFIG_IS_ENABLED(FIT_SIGNATURE) to guard fit_all_configurations_verify
- print warning if /configurations node is missing
- print "OK\n" in fit_all_image_verify()
- new patch
- use helper function shared with bootm
- introduce assert_fit()

Changes in v4:
- mention arm in subject
- correctly change defconfig
- fix and reword comment
- reword Kconfig help text
- rename option to FIT_REQUIRE_CONFIG_SIGS
- introduce SPL_FIT_REQUIRE_CONFIG_SIGS
- test CONFIG_FIT_REQUIRE_CONFIG_SIGS in test_vboot
- set CONFIG_FIT_REQUIRE_CONFIG_SIGS in sandbox_defconfig
- fix documentation to use kdoc style
- test iminfo in test_vboot

Changes in v3:
- enable CONFIG_OF_OMIT_DTB=n in defconfig
- add error returns
- document decission about dt merging direction
- make log_err use stdout too
- clarify error message when no keys were found
- change printfs to log_err
- reword Kconfig
- keep FIT_SIGNATURE_REQUIRED off by default
- use log_err instead of printf in fit_config_verify_required_keys()
- don't make iminfo fail unless FIT_SIGNATURE_REQUIRED is set
- update fit_all_configurations_verify documentation
- stub fit_all_configurations_verify unless FIT_SIGNATURES

Changes in v2:
- introduce FIT_SIGNATURE_REQUIRED
- document fit_all_configurations_verify()

Ludwig Nussel (7):
  qemu-arm64: merge built-in DT
  mkimage: define log_err and log_info
  image-fit-sig: Optionally require signatures
  test: vboot: handle CONFIG_FIT_REQUIRE_CONFIG_SIGS in test_vboot
  iminfo: also verify signatures
  test: vboot: refactor run_bootm
  test: vboot: add iminfo checks

 board/emulation/qemu-arm/qemu-arm.c |  51 ++++++++-
 boot/Kconfig                        |  22 ++++
 boot/image-fit-sig.c                |  19 +++-
 boot/image-fit.c                    |  55 ++++++++-
 boot/image-pre-load.c               |   3 -
 cmd/bootm.c                         |  10 ++
 configs/qemu_arm64_defconfig        |   1 +
 configs/sandbox_noinst_defconfig    |   2 +
 doc/usage/fit/signature.rst         |  13 ++-
 include/image.h                     |   8 ++
 test/py/tests/test_smbios.py        |   3 +-
 test/py/tests/test_vboot.py         | 171 ++++++++++++++++++++++------
 tools/mkimage.h                     |   6 +
 13 files changed, 311 insertions(+), 53 deletions(-)

-- 
2.43.0

base-commit: 9e002445cd0d47d3965312f12e97a18e1ed8bd53
branch: us-qemu-signatures10
