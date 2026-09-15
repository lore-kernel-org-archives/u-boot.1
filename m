Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FA0EC88E75
	for <u-boot@archiver.kernel.org>; Tue, 15 Sep 2026 12:53:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 76D59809E7;
	Tue, 15 Sep 2026 12:53:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UCM39iB1buHH; Tue, 15 Sep 2026 12:53:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org CA19B8086E
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789476815;
	b=MPlVUzAl/Ug6ETwLESxEiMFl5Mu2JDnEoeIa+SK+W0GdjqjeJhro2oDBekXtrYkIUXK4
	 9hjxXvWfT4rsXCrvLGpsMRVY288FVLy27FAPn53MgQRBzGts2JSGR6EIoqxUAUWyvO6Fm
	 gur8aoyBkfdcqh1yU0vRBZDjdVvr94eJKnId6Qi9/u1tAwDqrEzO5KW9RrxQ1htlxdozV
	 wO2pyDhXNuMZ11YPC+vuH5NPsq1uGDcIKGBjOjoSpz1GHtH0hWdQtHzHrezF11szooVcc
	 /ShRLOrLesg/m/lCyhvEdvfd3JCVz2e7/B9+uWaJOTgA0os2qed/XhC4TbMKV0JDPYQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789476815;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Comment:Received:Received:
	 Received:Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:X-Flowmailer-Platform:
	 Feedback-ID:X-Virus-Scanned:X-Virus-Status:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=qFohI5mkXqDbkMzShGbV6pqrNeR/whVNMfm31VkM71s=;
	b=UnlqcyB62NunZ8pmPZYVf3DohB16GqiYDPesmFwCl1OssXf/eCiZpdethIb426gNZez9
	 cKLUJewgMctncKyjTP5j7mFyE6RjE8mLOBApYeabj2/CLzk8/9Osf5ZzK/nlUJ2kyr/k1
	 TWwqAmI1zgWLxbsxJe5aWcC8lO9dVwFHj5bJHuAbY1VRYB9GWjIOmGHM42jlLwHuqxEB2
	 6rM2ltYaIbDZRhb31K3xQBCApWC+qhmU9K9Jo4giZjqOCgyeVy7IR2sBiKLxHMq3FDHGf
	 FnnAOWXZ0fhlNm4sa35Nuxyzrg/twUcY7w/Q7XlarMI2AS08Wu8SOmYfXL6cJBDTqjQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789476814;
	bh=qFohI5mkXqDbkMzShGbV6pqrNeR/whVNMfm31VkM71s=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=olvR/qgBc+fWZLYZfDNP3in4JceIgeDzdB2nSsFtTRBhMxir9uu2uKiqFMZLBYByW
	 QimoXD+AjtoI3ympy2H3cE3gFKW4zO5zuS71MAoieyzssLhgdsKI+d4/3YBmSIihXx
	 WO5/VWiEla1caEUp/iYIXw2cFdUGB76R9Vkr2CTBtUTjS+F7QR7JfzAnnvOKvH21XY
	 /uAFwVH27kIHlqXTfjTMmN8rMSlyqozsO66PlRdbEUf/fGK8Q1Qg0o1oMsF+srhdDA
	 r+uDlbvD3qCzfM932yA7Gnn55l2dJ/71ubyS1bhL3Mm7M1AwE/wMXeaN7TXICZjN0E
	 eKb0slHRDVsoQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CA19B8086E;
	Tue, 15 Sep 2026 12:53:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8D95DDCF
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 12:53:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 739E360777
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 12:53:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cbEYZPh-hqC9 for <u-boot@lists.u-boot-project.org>;
 Tue, 15 Sep 2026 12:53:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 3DB1D6074D
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=85.214.62.61
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789476809;
 b=jUoWFH/5fX5raSkAEHh8eSF/4tHX4Minr8p5FBKhSk7FTYduQLxwaB2IOUdkchbvHW0p
 hwSyp3TA6lawdJHDvrNJ/s21ZM6ox9rLcsqxvyelByX3K0k2uJCnizb+eRVBlbkvV/V5i
 z5i1q+VwnEFVNv4DG+Am5gqSZNi1IhHN6MwOKWwdnT5N0frdghg+RZ8cTWQl7Oirz6XoU
 Ou68EuiTbtkpOKY6FbfYoUtzRmCF2PlFuAyFU5R7MMg+fIz+EyDWbq++/yVXi550iY3i2
 x2UceGHHStCxthbbpc7K6UJHBrBG8QxZEtpBP9Qncxj4+9vE5W7ParrCyoNfs8KfvAg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789476809;
 h=X-Comment:Received:X-Spam-Checker-Version:X-Spam-Level:X-Spam-Status:
 Received:Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
 MIME-Version:Content-Transfer-Encoding:X-Flowmailer-Platform:
 Feedback-ID:X-Virus-Scanned:X-Virus-Status;
 bh=qFohI5mkXqDbkMzShGbV6pqrNeR/whVNMfm31VkM71s=;
 b=oLu5/GxEP5hFCZjtP2K750JWUkXdnupaMiFQFGHdmo/1YQP6b05Jw+tYz03KAsy/7QHS
 FkKmoj3Tqe65q6V0vEYNGNZdT065wdJn0+DIgZ+l5OadwzDM4L/ZfDGVjipf7aYtheRcM
 IGyWJRWR5JJqC9DBkpjogNmQ2889hdHow2WJ8xFPSU+4LCzzcYNCfQiomTcZ3KSv2scxF
 u05m3IK0t/n3gDyb+Ym9cloJJW/k9nAmNUCzWy8g2ekky+NuOGsqG619Yi2xjuzEVCUBZ
 tGfdUSP/BSsURwfOpiQuJQ17oSQt7yMg6Kn4b8l68BcjGDR+PzsvB8kzs/3la8RFqxw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=siemens.com; 
 spf=fail smtp.mailfrom=siemens.com;
 dkim=pass header.d=siemens.com header.i=ludwig.nussel@siemens.com
 header.a=rsa-sha256 header.s=fm1 header.b=nTm56jGD; 
 arc=none smtp.remote-ip=85.214.62.61
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=ludwig.nussel@siemens.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp3.osuosl.org; spf=fail smtp.mailfrom=siemens.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=siemens.com header.i=ludwig.nussel@siemens.com
 header.a=rsa-sha256 header.s=fm1 header.b=nTm56jGD
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3DB1D6074D
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 12:53:26 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D5E28404D; Tue, 15 Sep 2026 14:53:24 +0200 (CEST)
Received: from mta-65-225.siemens.flowmailer.net
 (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1DCC980117
 for <u-boot@lists.denx.de>; Tue, 15 Sep 2026 14:53:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ludwig.nussel@siemens.com
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 secure) header.d=siemens.com header.i=ludwig.nussel@siemens.com
 header.b="nTm56jGD"; dkim-atps=neutral
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id
 20260915125321cb0c5c198d00020734 for <u-boot@lists.denx.de>;
 Tue, 15 Sep 2026 14:53:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=ludwig.nussel@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=qFohI5mkXqDbkMzShGbV6pqrNeR/whVNMfm31VkM71s=;
 b=nTm56jGDVmp/QaVPhFusPh03MYN9NB1FrD6/A3giv6vv6+kqRlPHKXqO9npMD/MlSRtFkO
 ex6Ny0UHzfm+09SBteh7QWuo+5HJskq2fkoWOcXs3HTkGaI99Aqed1A8ebQeiF0YoAQOqdbS
 ZoxL0kamQ/L8ioJDo0pm4+iFoxGF7p2ML2OosDCY8kcKtoCvX6dlek+ZUZX6g5NYbRkP5n5P
 XQV8H96nO8FY7U9HVsOPafkp2R8S5n8eG2b6lakU3bMtB1VKPqT2a3wb8OVN05PWncZwrYs3
 cXUyndlS+Ys6Krol18hLWwA/8a54aZWV4xhn9Zdj8GwcgxLWsvmBTR4g==;
From: Ludwig Nussel <ludwig.nussel@siemens.com>
To: u-boot@lists.u-boot-project.org
Cc: Ludwig Nussel <ludwig.nussel@siemens.com>, Anshul Dalal <anshuld@ti.com>,
 Frank Wunderlich <frank-w@public-files.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 James Hilliard <james.hilliard1@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Osama Abdelkader <osama.abdelkader@gmail.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <ravi@prevas.dk>, Raymond Mao <raymondmaoca@gmail.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>, Yao Zi <me@ziyao.cc>,
 u-boot@lists.denx.de
Subject: [PATCH v9 0/8] Improve FIT signature handling
Date: Tue, 15 Sep 2026 14:52:11 +0200
Message-ID: <20260915125317.180911-1-ludwig.nussel@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1328817:519-21489:flowmailer
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
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

Ludwig Nussel (8):
  test: include mapmem.h explicitly
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
 test/boot/measurement.c             |   1 +
 test/py/tests/test_smbios.py        |   3 +-
 test/py/tests/test_vboot.py         | 171 ++++++++++++++++++++++------
 tools/mkimage.h                     |   6 +
 14 files changed, 312 insertions(+), 53 deletions(-)

-- 
2.43.0

base-commit: ece349ade2973e220f524ce59e59711cc919263f
branch: us-qemu-signatures9
