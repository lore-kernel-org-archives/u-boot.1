Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D5C606BFEE
	for <u-boot@archiver.kernel.org>; Tue, 10 Nov 2026 13:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=YlPI+pZt;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=YoGL4xoH
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E7C5C816A3;
	Tue, 10 Nov 2026 13:07:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ak9lwZ-QRV2J; Tue, 10 Nov 2026 13:07:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C889B8174A
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794316023;
	b=MhQ4Hcr4IqhAk935daVb7tLQdRvD8rkvbA39ERgNswvb2d2WnEOsdDZsHv589kqP+WVk
	 H1nYSr4Ws5NTx7ljZjEk5194S9qq36id/Ahl6iPLWrbpR9l51Jb0FwNbh7p5ypyk51TcI
	 mskxpO8hj1BnVmUFkhYPXdaDkc45OeWcLk21eyliV87dOmUHuPfu9C5R3Q2J/GBRAtPpG
	 cCI28IQrZZDLFkSrnGHfxXgw5rIIomaiOxqIG0qLmKuiVBKh8v+EO6oSeyujE6BpRNaeF
	 QTxOO/w/QoYEYTpb8F67zKLfePb6QSIER+VBARV7czahh97lBRXR9KxQcXehJYk4jhg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794316023;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=btTUhLwln/4zKX2lrWWbk8rIbhFXOVvUIWzkmIb5flk=;
	b=Ete37/ehRu2PP8VW/hqNx5yD6eb65FdvbdKdkMGW535RZRNjzVdj5ViQLsye7gZYzNTJ
	 jIUH5oMdSVx+cRmMj1TYgVyq+yK3GGPRrGJq6iR+bPhwQF9VtDpbMFacC+WvOKZFb057M
	 TJxE94JuXiDCBbeatl/ZKo55tso5PJmSOMKMI/Lk9+GnX1f8ECgV1WnPdRWEvNbIX3ON/
	 aku/9CxUJfaKVgalvF6LFjDi4EG9n8PZ6p+srKuAVt3aR/loI2XH3NZiiqfBwRoD6lUoP
	 PzOJD8SmVd+T1Gi6NhoSHsbpETUkTA0LBLKqAdexPCqv37B3rdjyOBtvdmwbhx2QdpA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=YoGL4xoH;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794316022;
	bh=btTUhLwln/4zKX2lrWWbk8rIbhFXOVvUIWzkmIb5flk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YlPI+pZtKeuKlspY9vcuQqKX5GFE6/HYS2xtlnEKp2a3Q8VnGx2jA6ogUY7XNrlQp
	 1LffvhxrOAzWrTJxqIMS859xMtw5w7Pvjp8eNbVhS4if/IT097rSPqxrnU4lnGdbLC
	 yqttg6+6ABPSwD/WMVBPjKInfGCrd++RP8Ifb4+oyIwoXb25Bz909q8qpvsgIds324
	 jwvEs/6w4qGPcTA7/zGeLF8X0GrD/47se+w8UfRSn+j5dx0jk2ZCsS9lClwHi8NA6M
	 DTdJco72Ov4xgUJ5lXbzp1J4PnClzAIl1GIeKQwuoc2fJf4DsnV0HjrTRkvp2ErjD4
	 k6ZNpHrsl05Kg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C889B8174A;
	Tue, 10 Nov 2026 13:07:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 3AF561FC
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 09:58:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8820C8110D
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 09:58:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id y3qDud6JDcis for <u-boot@lists.u-boot-project.org>;
 Tue, 10 Nov 2026 09:58:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D005981113
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=harsimransingh.tungal@arm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=foss header.b=YoGL4xoH
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id D005981113
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 09:58:45 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AE9CB1EDB;
 Tue, 10 Nov 2026 01:58:41 -0800 (PST)
Received: from e142474.cambridge.arm.com (e142474.arm.com [10.2.203.50])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9325A3F632;
 Tue, 10 Nov 2026 01:58:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1794304724; bh=vy7VNz3kltnXB6YZ7TYYF+yazG6awjc1E4oTLoXXnmk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=YoGL4xoHpD/7tgIsa0oPpx97deIJ/QUcARWL+iBhna08uTDrkI47SakHJH1YvLdbp
 LwSjn0qjpph45jaIeRkikKv+YMKCw7AtBRaYp00M0ht+oVk8KHf+B388/sdkNSCZ7J
 DazfIXVwZwwSNKvbudROfMb9zknWuS/l21j2kX1E=
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: u-boot@lists.u-boot-project.org
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Subject: [PATCH v7 22/22] doc: bootefi: note two-phase runtime variables
 selftest
Date: Tue, 10 Nov 2026 09:58:03 +0000
Message-ID: <b907e9711b2e86b0283defd78fffce3e9f995f82.1794221712.git.harsimransingh.tungal@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1794221712.git.harsimransingh.tungal@arm.com>
References: <cover.1794221712.git.harsimransingh.tungal@arm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The bootefi documentation did not describe how to run the
runtime-variable selftest, so users had no guidance on its reboot
requirements or on which flow applies to their configuration.

Document the runtime-variable selftest flow in bootefi.rst. Describe
the non-volatile path, note the single-run
CONFIG_EFI_RT_VOLATILE_STORE=y case, and show how to select the
runtime-variable selftest with efi_selftest.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>

---
Changelog:
===============

v3:

Simon:

- Clarify the volatile-store runtime-variable test flow
- Note that the split-phase tests only run when selected through
  efi_selftest

v2:

Simon:

- Update the doc to match the v2 new efi selftest flow
- Document single-run behavior for volatile-store builds
---
 doc/usage/cmd/bootefi.rst | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/doc/usage/cmd/bootefi.rst b/doc/usage/cmd/bootefi.rst
index 7cbf28e8b07..60f60838205 100644
--- a/doc/usage/cmd/bootefi.rst
+++ b/doc/usage/cmd/bootefi.rst
@@ -177,6 +177,37 @@ environment variable to match one of the listed identifiers
 Some of the tests execute the ExitBootServices() UEFI boot service and will not
 return to the command line but require a board reset.
 
+When CONFIG_EFI_RT_VOLATILE_STORE is enabled, the test
+*variables at runtime* completes within one *bootefi selftest* run, so
+it does not depend on preserving state across multiple runs. It still
+executes ExitBootServices(), so a board reset is required afterwards
+before returning to the command line.
+
+::
+
+    => setenv efi_selftest 'variables at runtime'
+    => bootefi selftest
+
+When CONFIG_EFI_RT_VOLATILE_STORE is not enabled, the runtime-variable
+flow is split into *variables at runtime setup* and
+*variables at runtime verify*. Run the setup test once to create the
+runtime-accessible variable in non-volatile storage, reboot, then run
+the verify test to validate, append, and delete that variable.
+Both phases are on-request tests, so they only run when selected by
+``efi_selftest``.
+
+::
+
+    => setenv efi_selftest 'variables at runtime setup'
+    => bootefi selftest
+
+After reboot:
+
+::
+
+    => setenv efi_selftest 'variables at runtime verify'
+    => bootefi selftest
+
 Configuration
 -------------
 
-- 
2.43.0

