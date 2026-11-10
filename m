Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD60F606A331
	for <u-boot@archiver.kernel.org>; Tue, 10 Nov 2026 13:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=CcO9khDY;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iWLJQyG0
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5BA27812C5;
	Tue, 10 Nov 2026 13:05:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KYuSJbhg-MNV; Tue, 10 Nov 2026 13:05:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 259D081352
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794315951;
	b=Ovwf1oyDvHbVdmsERpF+ptep3NsY2Gg5X+w0mjZPHsPhLtlCB+DTPgF83pJtnhMy3rwd
	 33Y1ghUp9siJpt85x6QSQOCEILJjI0w2MoUhRZ3l9c4wjnJYbzdP9L+yENLKxiI2+D/zA
	 wzA7kyqGivuH/HcXEDiV9CHefEImj+VSPjXZFBhq3aXdpUTxBL2JtnF20n6ZIYhTDibHw
	 qsiqYL+Udv3JD7VNTd84praHQUoC9iTwLxVR70rjQPaNOiaOchaT15CFJtYRPk20KrqBR
	 BTmA7yMDbwMUIaS0vSuN4bXvTPEMEBcO3Es9+PuiZimlVe74jOte3Zrdsn+7jhVxwXw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794315951;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=fKAolhhhgxAU0D2wnVPDPtwcfEGmdIisxvHiMlRJqGs=;
	b=tKTUtYVuiYWA0C46fT/AIUqKvw2aR8Ntulp0jD+qHOtAhHRAqCMFEHYtwFDkcmzDJ1cz
	 Y7BOFXUfRtMJFWbUV2RfLn4p3hCB3TMK2guGlkw57Lv1rughcbT/ZYI9kxeoD3c2SJbUF
	 L+3ORZkY4qjwR2rl/udvSGUI3MLQwl4GowAZ69zl3vPsDkYkJq7wfCog5ULNJh0UwA3G/
	 wJAokzeBf59BkQ/j5AlFDK2VT5xq6VQFIxK60khkjVVF85REoNBSPfLiCtRzuiz4xnsPx
	 5bIGdJVgXIoNozw0skGOb6MPJCsOicppqg/f0y7unMWhg7ct+6yIrJKnShuQQcYkZGg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794315951;
	bh=fKAolhhhgxAU0D2wnVPDPtwcfEGmdIisxvHiMlRJqGs=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:From;
	b=CcO9khDYJls0btje7r9cvVkQdo3EKvvWV/FRABqmPN/O1wFlLpsqwwGc1CnpkQBcs
	 oko7BSjM/ObKZ9IXbFGxb8bCQtsVw/NcBF2FBvABFjRBM+X3wA3B6SOyqZxeDBXveH
	 lkaUSbe9FRvAnAycPN9UQnMm9tMB2q5KGNrJjWxW3AbiOW48hAwNOnjL0Uha9/yF+u
	 EQsBVHSrty12FIWOC09jMLfOtYFNrUU0FUxe6oFLhxeBt+97KjtmI2Gi42nzMNW595
	 i98xadq5ATqM/LGDLEKB/CBpzK4eAF83m/l23mI+/TruEAoitGg05sutH1HUPMncIQ
	 q1sK/6eWfV2pg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 259D081352;
	Tue, 10 Nov 2026 13:05:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 13410335
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 06:20:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id ED95A60803
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 06:20:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AXHA6aUEPzGj for <u-boot@lists.u-boot-project.org>;
 Tue, 10 Nov 2026 06:20:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 227A160790
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org;
 envelope-from=devnull+aiyengar1990.gmail.com@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=iWLJQyG0
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 227A160790
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 06:20:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 868DE6375E;
 Tue, 10 Nov 2026 06:20:11 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id A8C951F0089F;
 Tue, 10 Nov 2026 06:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794291611;
 bh=fKAolhhhgxAU0D2wnVPDPtwcfEGmdIisxvHiMlRJqGs=;
 h=From:Subject:Date:To:Cc:Reply-To;
 b=iWLJQyG0GsSx7NxeaxoWUnA3pW5zqs8eyj54tuRZ80dg4kXpcbLu5KXT18Byu1GiN
 g22M9Dsq7V8dXyMRYmVZI7U/Dzvw5uYy+JHHr92c68gKSTMp14zsVeo9gW59J4JmFT
 atQ6bD58C9P4WnY5BpjQNEswCHc62fe4sHXqhYa9YE3veRC76/avJaqwFZm51Dl2Fs
 cjJT7/LsCWpoH+xM6riZMb3dhVI8MnsY4ZSlWxjeEJamPKPQPPigiOsvFaIDlk3pfc
 5sW/M5owC9v2ncAjPeR3hZg7+XHD5rybDBCzWDSEh9v1vyPrWu5sjNYaSPX5lvwYx8
 YBl4AmABMR9iA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 3AD24488ED;
 Tue, 10 Nov 2026 06:20:10 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Subject: [PATCH 0/2] sunxi: dram: H616 DDR3 init delays, retry transient
 training failures
Date: Tue, 10 Nov 2026 06:20:09 +0000
Message-Id: <20261110-h616-dram-retry-v1-0-ccaa6d7a6ef1@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqDMBBA0avIrDuQEYzaq5QuopnoCNoy0VIR7
 27U5Vv8v0FkFY7wzDZQ/kmUz5RAjwza3k0do/hkyE1uichgb8miVzei8qwrVsFVvqhDaYyHVH2
 Vg/yv4+t9Oy7NwO18bmDfDx8fKAlzAAAA
X-Change-ID: 20261110-h616-dram-retry-8fa8d59f700d
To: u-boot@lists.u-boot-project.org
Cc: Andre Przywara <andre.przywara@arm.com>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Arun Iyengar <aiyengar1990@gmail.com>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794291609; l=2503;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=QbVBUcLtTolOgmS2ZIiW8adEurzeeDNLLJm66LF81es=;
 b=fEO6n6g9+e3XT9y7P9BiN4kHKrOWJenKom4Kc+jawwTQ8CgOBHZBp8c4mSwkyPTKuSaJFxkYO
 twHItDBp+rkBknpi9rOm7o9N9PE8yIb9a+bnExCvlySYgR1XcDEe6+F
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
X-Mailman-Approved-At: Tue, 10 Nov 2026 13:05:19 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Reply-To: aiyengar1990@gmail.com
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On an OrangePi Zero2 (H616, 1 GiB DDR3, 720 MHz) a hardware watchdog
reset taken while the DRAM was busy (a system thrashing under OOM, or
stress-ng loading the memory at about 75 C) sometimes leaves the DRAM
untrainable for up to about three seconds. The SPL then either panics
with "This DRAM setup is currently not supported." or, after the reset
that the panic causes, settles for a 16-bit bus and boots with 512 MiB
until the next reboot. Idle reboots, cold boots and idle watchdog
resets never showed it.

Patch 1 makes the H616 DDR3 init use the JEDEC RESET#/CKE delays. It is
a compliance fix; on its own it did not measurably change the failure
rate.

Patch 2 makes the rank/width detection keep the best combination that
trained in any pass, retries with an exponential backoff (12 passes,
about 2.5 s) while nothing trains, and retries the size probe and the
final init the same way. A board that trains first time pays for a
couple of quickly failing attempts; a retry is reported in the DRAM line
of the SPL. The final init helper is shared, so H6 and A523 get the
retry for that step too.

Testing on the OrangePi Zero2 is in the commit messages: with both
patches, 60 hot watchdog resets came up with 1 GiB (21 of them needed a
retry, the longest 1.7 s), and the board has since done 316 logged boots
with 1 GiB and no retry. Build-tested for orangepi_zero2, orangepi_3
(H6) and orangepi_4a (A523) with no new warnings; H6 and A523 are not
run-tested.

These patches were developed with Claude (Anthropic) as a
coding assistant: it investigated the problems, wrote the code and the
commit messages. I reviewed them, and they were tested on an Orange Pi
Zero2 (H616) as described above.

---
Arun Iyengar (2):
      sunxi: H616: dram: DDR3: use the JEDEC reset and CKE init delays
      sunxi: dram: retry transient DRAM training failures

 arch/arm/include/asm/arch-sunxi/dram_dw_helpers.h |   2 +
 arch/arm/mach-sunxi/dram_dw_helpers.c             | 167 +++++++++++++++++-----
 arch/arm/mach-sunxi/dram_sun50i_h6.c              |   2 +-
 arch/arm/mach-sunxi/dram_sun50i_h616.c            |   2 +-
 arch/arm/mach-sunxi/dram_sun55i_a523.c            |   2 +-
 arch/arm/mach-sunxi/dram_timings/h616_ddr3_1333.c |  11 +-
 6 files changed, 147 insertions(+), 39 deletions(-)
---
base-commit: ecdcf9e365df6249a57cd8cc946e7026804ff4ae
change-id: 20261110-h616-dram-retry-8fa8d59f700d

Best regards,
--  
Arun Iyengar <aiyengar1990@gmail.com>


