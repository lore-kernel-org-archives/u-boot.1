Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B09606A332
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 10:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=tmr4yeon;
	dkim=temperror header.d=siemens.com header.i=ludwig.nussel@siemens.com header.a=rsa-sha256 header.s=fm2 header.b=dGUOWqW2
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A0E364053D;
	Thu, 29 Oct 2026 10:05:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id m0CVMFDhyzkz; Thu, 29 Oct 2026 10:05:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C57F240543
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793268307;
	b=a4meb8hYdMZBcsuWZTdRPKx9He5crs0uE+TLtCz4K2o5EMLi+KcmJQsJflWiDwdbI5T3
	 yShrIlk4ojCYZFLFJDFJxTEBDS9uW+aWeh1hFgbYuakWrEXATPTENuRKmAOPLUzE0r3/K
	 PIJlDlfVSnUQOW6UzbhYdKrz+AStnbwYxC8tXvoN+4Qp1SvP0FoUQxME/4aRpdS0LGanx
	 oJfHHrtQKIzUX/9Fi/6sNwGhG4ZJSzoaA6nKxzROkBQjw6/d4VqsmZH5v0wmCR3vznwV5
	 ouNEEXSojv4jnDVBYk01Zjghyi47AbA8k+gaOBJ14uLii006s1bkv+jxxy6ZKCWdSRQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793268307;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:X-Flowmailer-Platform:Feedback-ID:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=q+N4SkT0W5c+4pZl8gwKMBq22A4PPKYhhqjmV46cBRE=;
	b=h7IV5WpxMxnhmgpEPNef5y+uAHLR36aM7TRmkEhq8R1t0bJzcdTDx3qSTKI46FUjzgyh
	 PjNF7ZWg6I1dud4t/YuaqMnVj+ryE1kTRnYboQvk+A4eZAB3J3cM/PZ5g5CaRzcFy6rxi
	 z82jXisyzQKo25bn1Nd3ybIFvzPpz12DquBvSGjIw/fqPuHo11sP8Klcgea7X6FHtLfaC
	 mX6NU8P+H6thuq5wx+9FlVpYAa5Y+8UY1JWtYHBXEozCkfVQWYY1UjU27Oh/J/EJ3QtSK
	 Ce8GgEmVLqOShiJ6iSKm5jjPPnuT5TTRFjlcPOYi2viKOMrAzGHKQY0W8oJM+qN6e9w==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793268307;
	bh=q+N4SkT0W5c+4pZl8gwKMBq22A4PPKYhhqjmV46cBRE=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=tmr4yeonY5xZqgRpsqCps41VZ1hcakC0tGPvmvSbcup7RYOLFvLLg55fFBxqxVaAD
	 34lhugWerdbcm+avAAVwgY55CLtiS/grBPgLeYP6g+XIT6wpcF+0AeLw1bBJrk1prs
	 cwhpvJPogJAcXo8fPJZSvxe2CmXeOuxVOnxctxVtpgWFIUfr2PwfIl1wdI0tSm5SLv
	 hGhc1mHRAdYI4qpEgk3EQ+t4l3Ka5C0EhR19JSTQLz9CrJ7POeVSYwEXPkmK09AhGb
	 3PKgGlyTUHjOgVo/MvlEVSY0YObnf9Xkzh3P19G32MMR/tuUul182+mMLwMqdH6wC9
	 mex/6qRwMWeiQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C57F240543;
	Thu, 29 Oct 2026 10:05:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8729A972
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 10:05:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 78A73606D9
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 10:05:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EE84Md5LKnIz for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 10:05:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5EB5860677
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=185.136.64.228
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793268305;
 b=beD4KE/Hnlam41MjCoqvY8rREa1XK4uTh9KB1e8RJzG8NlEE6mxaGdLx34BW8qLWg3Ip
 1mXkccB21xfho8GG4rn1EdOI9GWbF4F4zXQQbY5Dj0Kt9tIKgdJCXDX3NkmeY5o+NZVxX
 zr2Mme49rjgaxolgZV0ztuE3InCrXfUPE3TcduukqFT6qOzLewA6PtU4g3NPKLFqOysut
 w8jGqWr6kWfzabIaXdtzp/ZAxX1eQpdIoOrKkYd5md2JOrR4zZ9XHvNoTArECxGVINK00
 jFL8zxp/VuzgyXqoyQeiJr2GDWmXo65i3SoFVmf/g3SDjaGJPQXl3fPj7D/hJnfqoPQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793268305;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:MIME-Version:Content-Transfer-Encoding:
 X-Flowmailer-Platform:Feedback-ID;
 bh=q+N4SkT0W5c+4pZl8gwKMBq22A4PPKYhhqjmV46cBRE=;
 b=QLTAA2CrnwGg8LJ3bx2O0Xl3FS2c5rwEWZdb9JL2BYfXtZJ8JNBET9RyXkZOPSQH7n9n
 Z5CGbIOHqO29zqmIOkXqLAjM/yRUn3A2DivK5Xomo5PJAEgBNbruuulTYjVvYS/Gnv928
 s33UHVEDCgo6KdOHMRfc1Bm79bNqCVVYzABEt7oiq1oTPSc2e/dMQOElV27WW3QLbko6l
 Ov1CI7R9UKRgLNxcYGzDIQEwwuHt/ISObh6mKYnezX8R1KvG6ZdeyDJUkXEqO3BFcwDKq
 bleARMG5ZoUyi01LauFXuoEDhoQGfk0rdCs84JvbmPGxVtpBTDvXzCgxV3VxU++iviQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=siemens.com;
 dkim=pass header.d=siemens.com header.i=ludwig.nussel@siemens.com
 header.a=rsa-sha256 header.s=fm2 header.b=dGUOWqW2; 
 arc=none smtp.remote-ip=185.136.64.228
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.136.64.228;
 helo=mta-64-228.siemens.flowmailer.net;
 envelope-from=fm-1328817-20261029100459e97c7b378300020716-lhcxp5@rts-flowmailer.siemens.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=siemens.com header.i=ludwig.nussel@siemens.com
 header.a=rsa-sha256 header.s=fm2 header.b=dGUOWqW2
Received: from mta-64-228.siemens.flowmailer.net
 (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5EB5860677
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 10:05:02 +0000 (UTC)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id
 20261029100459e97c7b378300020716
 for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 11:04:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=ludwig.nussel@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=q+N4SkT0W5c+4pZl8gwKMBq22A4PPKYhhqjmV46cBRE=;
 b=dGUOWqW2Bp3aaDUmDr3N404q3ftjSuiBtP6Pa309xiM954oTiVDyE01eCzV80rst2p+95d
 BQEmcZSbkkloKtqyYV78xS5I81mcrXoKDofSkx+eQH8mNtzayElzRqwlvt+/VbApjK2f4MHj
 dQB1G/18qUM4kZFj9RCIl3+2K3WrrHCgWuMGoUvZzFeY/5JVXauzOoiesqH372Am577SLKSq
 jiMWIj0nkXDooiKDNNv+nJ5GBKHMDmXo2H34yoVgmanIkGhM9nOW3ARdh5DNHhqjo/PmIShS
 sk4U6F4qe+hm8Hb9swsWdpqYBc2idhpJ7lkeHlQPigRK6Mf9WPlSngiw==;
From: Ludwig Nussel <ludwig.nussel@siemens.com>
To: u-boot@lists.u-boot-project.org
Cc: Ludwig Nussel <ludwig.nussel@siemens.com>,
 Alexey Charkov <alchark@flipper.net>, Anton Ivanov <anton@binarly.io>,
 Aristo Chen <aristo.chen@canonical.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 James Hilliard <james.hilliard1@gmail.com>,
 Johan Jonker <jbx6244@gmail.com>,
 Mehmet Fide <mehmet.fide@screeningeagle.com>, Randolph Sapp <rs@ti.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v11 0/6] Improve FIT signature handling
Date: Thu, 29 Oct 2026 11:03:51 +0100
Message-ID: <20261029100455.31820-1-ludwig.nussel@siemens.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1328817:519-21489:flowmailer
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This patch series tries to improve dealing with FIT
(configuration-)signatures a bit:
  - (optionally) enforce signatures so we can't accidentally boot
    unsigned fit images. Quite an easy oversight, esp when qemu
    previously didn't even use the built in DT.
  - make iminfo verify configuration signatures, not just image hashes

- I've dropped the qemu dt merging code for now as it conflicts with the
  changes introduced in commit 68e65953400. Requires further discussion.

Verification run: https://github.com/u-boot/u-boot/pull/1054

Changes in v11:
- rebased on next (ed869863c7e)
- removed qemu signature merging code

Changes in v10:
- fix description referring to CONFIG_FIT_REQUIRE_CONFIG_SIGS
- rebased on next (0a61439db5e)

Changes in v9:
- restore debug message instead of errro

Changes in v7:
- mention CONFIG_FIT_REQUIRE_CONFIG_SIGS in documentation

Changes in v6:
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
- fix and reword comment
- reword Kconfig help text
- rename option to FIT_REQUIRE_CONFIG_SIGS
- introduce SPL_FIT_REQUIRE_CONFIG_SIGS
- test CONFIG_FIT_REQUIRE_CONFIG_SIGS in test_vboot
- set CONFIG_FIT_REQUIRE_CONFIG_SIGS in sandbox_defconfig
- fix documentation to use kdoc style
- test iminfo in test_vboot

Changes in v3:
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

Ludwig Nussel (6):
  mkimage: define log_err and log_info
  image-fit-sig: Optionally require signatures
  test: vboot: handle CONFIG_FIT_REQUIRE_CONFIG_SIGS in test_vboot
  iminfo: also verify signatures
  test: vboot: refactor run_bootm
  test: vboot: add iminfo checks

 boot/Kconfig                     |  22 ++++
 boot/image-fit-sig.c             |  19 ++--
 boot/image-fit.c                 |  55 +++++++++-
 boot/image-pre-load.c            |   3 -
 cmd/bootm.c                      |  10 ++
 configs/sandbox_noinst_defconfig |   2 +
 doc/usage/fit/signature.rst      |  13 ++-
 include/image.h                  |   8 ++
 test/py/tests/test_vboot.py      | 171 ++++++++++++++++++++++++-------
 tools/mkimage.h                  |   6 ++
 10 files changed, 259 insertions(+), 50 deletions(-)

-- 
2.43.0

base-commit: ed869863c7e2aca50d57a05d843830dd843138c4
branch: us-qemu-signatures11
