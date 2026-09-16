Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8070C982C9
	for <u-boot@archiver.kernel.org>; Wed, 16 Sep 2026 17:36:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0BC9560822;
	Wed, 16 Sep 2026 17:36:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MF31FNbgYrYn; Wed, 16 Sep 2026 17:36:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 5BFF060820
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789580181;
	b=R58aniB0oVLRjdeoK2t4KIPmFlP2Mxah5+50PROLCkAxAEAG0RHRz0Rb7ThnCL6I6LnG
	 VDTxO6krMEq4QsSxOeWTD1LJ3IjBQs/PNz4pOsjHQzfzYJ8ScKT3xaysg2aSBh6Arm/nA
	 barKE6IgudesWZyVToAdh4jV3uF1SzDvED/pwaLa/TwKK21AJrcznfddKpfOTn2cCPKxB
	 eKVrnLwH8zf1Vnh8s1ooyPUUsEyzLRnmVqxwdp/x5lyOkxTXdsZVe6NNK9R9UhnN/H4vY
	 hTTA28C7M4r27A0Bkm8KDAVF52IKGBNBxE+TETQHNRQPQKuB76yQzmdXg2E+36pmqNw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789580181;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=I+2jdP1BANppoaC45xfoCBjAJ681zkcPeDk6F+4/E/E=;
	b=BBPNkr6PCtxFzHxncncPfIGBJ+D3r7RkQuxcZzDYAMfwamBTCSGaBlpGXaRumKnw4MpK
	 1+V7pareGS1K9w4nsqmPvcxb+g5cKfsyZetKeo8jPzcy8i9sOoxMKUFmM5c5lObr1DPsa
	 +oFkI3DbvLrvQIL5ewPtwRcYeQMHxYts4MBft6U9AirdqmDzwwewSHe+eQA6hH9Ggba6g
	 Qqkw1YuJuFjAvN+/9lS4XkVT/HgZsbfSYJEKNXHEHAjbrLUPnf//0kgaiIBQtwG+1qo/X
	 OHPihnFSrbE+NUICtSx9OTiErrRfa+Vlyu2uFQhqOn/pDi0xe/7ewf7jLviGXmKwYyw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789580181;
	bh=I+2jdP1BANppoaC45xfoCBjAJ681zkcPeDk6F+4/E/E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BJP1PXZVdHCmBB6iJs+2fBtm1DesKbfD47ilu5Ty+Ze2DKHgl4R/yhzjw+fShuOz2
	 72kMrNKCoZJJHxGGplLF7tG4I/U6zdKHtL2xW4MlN8cWVW/0FHN3nvdBJ1xC1T3Shf
	 e+23z5Ri8SplVw+Dz0K8XgcMALGY0YmJbwVkc5n/UrV8+QjcbvNDiYdbWULMKHvvtG
	 Cc0EHlmt0wPM3NXC1HBBvXZtPuZlxwRUjtHhP6uSCsQHedAesCI3s7bto2h0bm/dsr
	 cKQVdDIgBHOxe9rWsFsVhuEwZ4/d/OuFxtW9qWtEd+j2WYMSgdVnNyX5DDt44T/0WO
	 GdWG7sM6dQOaA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5BFF060820;
	Wed, 16 Sep 2026 17:36:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2EF08422
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 17:36:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1425640308
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 17:36:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GE-_3FXdiiCC for <u-boot@lists.u-boot-project.org>;
 Wed, 16 Sep 2026 17:36:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 6153D400B8
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789580177;
 b=cR8EV88NyINWpRwmRKR8ws3XTS5ftu1EFvXGPJwHlPXzsaVZM8RSFBPDm3IvuwkfkeHr
 WcYnXQUzf29ApaMlQntyKPqRNelAEO2TQAhsBvAp2Zk+y5VJJmI7ke3l89eS+IcEpQiHf
 za7Ek3BN9Tfn9lEMvHP/Gqxby0eeW3OnZd0bIpIxYcAryTf+GtS/CKaEAbVoJ2s1SxfWP
 OfNdELBcFzYMXmOGotwyANKQgX2X7FQx38LjVFRLqPrVG7U5BSTL4xN9+dLnEZxRXXIMY
 YzJN6BYw4Xo+skOwe2mMRZrR5BXAsirHw1+G31XhP2epeQg90iCBThaK1yKH9VEqtHg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789580177;
 h=Received-SPF:Received:DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Spam-Status:X-Spam-Checker-Version;
 bh=I+2jdP1BANppoaC45xfoCBjAJ681zkcPeDk6F+4/E/E=;
 b=GAIwDTXc7xxKx/+RXgEHBQWHNwnBPImkSaTCF1iMEMbYNAaRpeA9Uy3xYcFexjqKeqZc
 g4ULqQrkZz9Pg7FRrHI3FMV3g9HXv7OPASeqbhK6qmP34ThuXpayJY6egZes5SVAx6f/a
 oDJk2psKUDrWPeHFBhIKlfBL9I+nvOwGrgrngnQzKQMq6ZC5lAFpujIHZKetyp+ZpO0KS
 BiY6ySs2e6xGrjxWzjf6ImNYOpdIQ12jpJyiT1jetme3qUUw2sJ/JGTgKV0wYnSg/Kt05
 BBwLhnu1dbLqbJGHTMqky6G+LlN6urJgJbGeK+Y+Xf1fLCOpoDTG2SctTs2VTIga7UQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=linux.microsoft.com; 
 dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com
 header.a=rsa-sha256 header.s=default header.b=TRm9Zown; 
 arc=none smtp.remote-ip=13.77.154.182
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=13.77.154.182;
 helo=linux.microsoft.com; envelope-from=sriramsriram@linux.microsoft.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=linux.microsoft.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com
 header.a=rsa-sha256 header.s=default header.b=TRm9Zown
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6153D400B8
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 17:36:16 +0000 (UTC)
Received: from srirambuild.corp.microsoft.com (unknown [167.220.26.49])
 by linux.microsoft.com (Postfix) with ESMTPSA id A3A1C20B716C;
 Wed, 16 Sep 2026 10:35:31 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A3A1C20B716C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1789580131;
 bh=I+2jdP1BANppoaC45xfoCBjAJ681zkcPeDk6F+4/E/E=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=TRm9ZownG1JtMRNP41w71TtyZ8kCUqed0SS5vM0iktEp0yGuHR2if5+ftYS94pJSR
 RM1xzVj2BwRQIcd/Ep8ZHp9+g54InfnWQB8dhyKdP/KmcskamDZHmapvEeVOFetqYq
 F1hRwo6ewsqoJsWVN7qZZ0segbwsGybNcVEao1Rc=
From: Sriram Sriram <sriramsriram@linux.microsoft.com>
To: u-boot@lists.u-boot-project.org
Cc: Michal Simek <michal.simek@amd.com>, Michal Simek <monstr@monstr.eu>,
 Maarten Brock <Maarten.Brock@sttls.nl>, Tom Rini <trini@konsulko.com>,
 Drew Kluemke <ankluemk@microsoft.com>,
 Sriram Sriram <sriramsriram@linux.microsoft.com>
Subject: [PATCH v2 1/2] board: xilinx: Check calloc() result in
 board_name_decode()
Date: Wed, 16 Sep 2026 10:36:10 -0700
Message-ID: <20260916173611.29425-2-sriramsriram@linux.microsoft.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260916173611.29425-1-sriramsriram@linux.microsoft.com>
References: <20260909192047.217421-1-sriramsriram@linux.microsoft.com>
 <20260916173611.29425-1-sriramsriram@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The allocation of board_local_name is followed by a test on board_info
instead of on the newly allocated pointer, so an allocation failure is
never detected and the first strcat() writes through a NULL pointer.

The same test is also placed after the allocation, so returning early
because board_info is NULL leaks the buffer, while every other exit from
the function goes through the error: label and frees it.

Test board_info before allocating anything and check the calloc() result
on its own.

Fixes: 52ff1626cf4c ("xilinx: common: Enabling generic function for DT reselection")
Signed-off-by: Sriram Sriram <sriramsriram@linux.microsoft.com>
---

Changes in v2:
- New patch. Replaces v1 1/2 ("board: xilinx: Use strlcat() in
  board_name_decode()"), which is dropped in favour of Pranav Tilak's
  patch for the same heap overflow.

 board/xilinx/common/board.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/board/xilinx/common/board.c b/board/xilinx/common/board.c
index f45b879736e..9ea5f46c9a8 100644
--- a/board/xilinx/common/board.c
+++ b/board/xilinx/common/board.c
@@ -573,10 +573,13 @@ char * __maybe_unused __weak board_name_decode(void)
 	struct xilinx_board_description *desc;
 	int i, id;
 
-	board_local_name = calloc(1, MAX_NAME_LENGTH);
 	if (!board_info)
 		return NULL;
 
+	board_local_name = calloc(1, MAX_NAME_LENGTH);
+	if (!board_local_name)
+		return NULL;
+
 	for (id = 0; id <= highest_id; id++) {
 		desc = &board_info[id];
 
-- 
2.49.0

