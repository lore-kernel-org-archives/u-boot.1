Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3EAF606A333
	for <u-boot@archiver.kernel.org>; Sat, 14 Nov 2026 00:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Nt4KnHrl
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 88F4440945;
	Sat, 14 Nov 2026 00:09:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VUYNE1eJmnBz; Sat, 14 Nov 2026 00:09:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C00CC40E9E
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794614962;
	b=OWML4mbbPFFlYVnT2qPaPsR94mqOys8Q570f3hDSY8A3o7hEEj/kbv5NMfdXvE1IbHVX
	 sXXaKF+7l5mqgeKs07+7kyV0shdg8gsnAsJz/vIpJ/jw3N7g87l14A7bbVIDDgQbZw7/P
	 amR0ka8VKSeUqJLRd8Q1TsCQMFmYJlj1zFxy7K/wec7clpDCxvDwiFibGNtc2t/Isyy9+
	 E+nnZW9RO6iqUeijwl/OHLkvATNZM+vQEpOoyGVfO1ihnTdG3EJ4F1BOVeucRuYlnza/H
	 KyneJmk6gQKBIawLgYa8G30st3YhMRnEoEukzo0uPmfYJ6XdglsSNjJ/aIrY5HQ3+EQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794614962;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:Date:
	 From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=YbKOEsQ5GLUHxygw15xs3FVIN3TvpfDBUR9Q+V3fuzQ=;
	b=C/0SAbvcPsp94657dfn68IwnYtstYyxBO//R2AeSr+KZhtmw8iz1+Kab5ZDDDqCsjXPG
	 ylijujrmmJ/tSMraZ0PjU5PsgvAQJt1NdiTYhhGh/hOUT31YZhZB4D2VzQdRRCrEtrV3Y
	 lH6yEQu0tfRbcJO/+pKbpkoVx347iZi1x5i59IJrlvkS2AkiR/XQ041pVsGHOTk4iKa/l
	 bKAk+uA7yut07Ac/tMeducLREk6SaBkLFnmSJx7WmeFH66HXwn4Q3A7DeLoAoHeuWJZwh
	 7jSzDPa+WMleFBkm1OwlMnAv6/wFSM37yT63R9pkf29UE1Ntjhr2pGc/e/UEp2OIS8w==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=none header.from=makrotopia.org;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794614962;
	bh=YbKOEsQ5GLUHxygw15xs3FVIN3TvpfDBUR9Q+V3fuzQ=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Nt4KnHrlfk0FkElv5M5/z4mEpHF7A2M4TaJOOk9XmDh3m22OB9s4A4Pv/30/NTW8v
	 /C7/5qlij480lYnLYC4/Ln6vviQQAOdBQimFM2sTIR+U2C00os11SrHxUmJ5k5ZIgE
	 52rRiatjG1NuivbZPTxK49UoDkU3b8homxB6lyIggA2FIxpXBO+UntoX/yk7yhUOPL
	 7b/Dsv347JkJQB52bwkWDFPjDZS1I/iKbt98VkUzQ4HoQEa4EAAogjskjEMZc2PP0O
	 Bd5i8yKNoq0qHtCBDTOF3rkdu0KTbEnfRYiJY4nb6Pz14MiC/BPWl5sZkLraH5pfla
	 fk/4V+QUiD4Kw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C00CC40E9E;
	Sat, 14 Nov 2026 00:09:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4B0241E7
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 00:09:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2855340E9E
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 00:09:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id F59DtXyoC_2X for <u-boot@lists.u-boot-project.org>;
 Sat, 14 Nov 2026 00:09:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8D99540E9C
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a07:2ec0:3002::65"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a07:2ec0:3002::65;
 helo=pidgin.makrotopia.org; envelope-from=daniel@makrotopia.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8D99540E9C
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 00:09:19 +0000 (UTC)
Received: from local by pidgin.makrotopia.org with esmtpsa
 (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768) (Exim 4.100.1)
 (envelope-from <daniel@makrotopia.org>) id 1xS1KH-000000008TR-2ojH;
 Sat, 14 Nov 2026 00:09:01 +0000
Date: Sat, 14 Nov 2026 00:08:55 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Alexey Brodkin <alexey.brodkin@synopsys.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>,
 Yao Zi <me@ziyao.cc>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Daniel Golle <daniel@makrotopia.org>,
 Aristo Chen <aristo.chen@canonical.com>,
 =?iso-8859-1?Q?Jo=E3o?= Loureiro <joaofl@gmail.com>,
 uboot-snps-arc@synopsys.com, u-boot@lists.u-boot-project.org,
 openwrt-devel@lists.openwrt.org
Subject: [PATCH 0/9] imagemap: Fix boot errors and resource lifetimes
Message-ID: <cover.1794614777.git.daniel@makrotopia.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series fixes bootm error handling and resource lifetime issues
found while testing the imagemap boot path. It applies on top of main.

Ordinary allocation failures and unsupported bootm subcommands return
-1, which is also BOOTM_ERR_RESET. Return -ENOMEM and -ENOSYS for these
failures so they return to the shell. Sandbox gains the same subcommand
behaviour, with tests for unsupported subcommands and failed ramdisk
allocation.

A failed imagemap extension can leave the original mapping pointing at
unreserved memory, which cleanup may free after another user has
allocated it. Keep the original mapping and reservation until the larger
region has been read successfully. When the region moves, copy its
cached data and read only the added range. Document region replacement
and pointer lifetime, and add regression coverage for failed extensions
and relocation.

Removing and re-probing a SPI flash leaves its old mtd_blk device bound,
so each probe adds another block device. Unbind it and free its pointer
storage when deleting the MTD master, with a test for the block count
after re-probing.

Built for sandbox and qemu_arm64. The sandbox bootm and imagemap suites
pass all nine and 16 tests respectively. On QEMU, checked that
unsupported bdt and cmdline subcommands and a ramdisk allocation failure
return to the shell.

Daniel Golle (9):
  boot: Return distinct errors for ordinary bootm failures
  sandbox: bootm: Reject unsupported subcommands
  test: boot: bootm: Check ordinary failures
  boot: imagemap: Preserve mappings when an extend fails
  test: boot: imagemap: Check a failed extend
  boot: imagemap: Clarify region replacement
  mtd: Unbind the block device when removing a master
  test: dm: sf: Check the block count after re-probing
  boot: imagemap: Copy cached data when moving a region

 arch/arc/lib/bootm.c        |   5 +-
 arch/arm/lib/bootm.c        |   3 +-
 arch/microblaze/lib/bootm.c |   3 +-
 arch/mips/lib/bootm.c       |   3 +-
 arch/riscv/lib/bootm.c      |   3 +-
 arch/sandbox/lib/bootm.c    |   5 ++
 arch/x86/lib/bootm.c        |   2 +-
 boot/image-board.c          |  13 ++--
 boot/imagemap.c             | 151 ++++++++++++++++++++++--------------
 drivers/mtd/mtdcore.c       |  48 +++++++++++-
 include/imagemap.h          |  13 +++-
 test/boot/bootm.c           |  53 +++++++++++++
 test/boot/imagemap.c        |  85 ++++++++++++++++++++
 test/dm/sf.c                |  32 ++++++++
 14 files changed, 340 insertions(+), 79 deletions(-)


base-commit: 6487c50b8a40f2668ab98a892b9300ad5c181f38
-- 
2.56.0
