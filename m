Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D1C606A31E
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 20:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=p9/Fvb/7;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=RCIaQBBm
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 11D7940663;
	Mon, 26 Oct 2026 20:11:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YaCHN1_FCDig; Mon, 26 Oct 2026 20:11:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 47F3440647
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793045470;
	b=s+2dyqjJnNe8DWUVGIE8AI4U1YHWOTmFwJ8MZDPIyrjgJuVSlfUi3O83T2u+y7F5MZb4
	 Tn92eKYpPfD+bApC/BfFDAghpXcwScxQft+9Vvjtja1x56oZqCoodFXar60vAVg0hSsEy
	 Wr+4cLWLbKr9XTSe/y6JaleL2bW1KdOKmTkTWnc1+eValZbjGBV6KhasiPH5Id5PAbr8y
	 LAS2QZ1Eh5Q65wYmkjEt+JbBaLnnCK/IAxCK0aqRSy0gtvDtPsxiOUQiC2t3yBxoNQQ/f
	 GVlBK2hnZBE9KnzO9D7v5RG0uZo6OoiiVFKvEsntxGMK2HAu4JuOsYieymYZvUUeU8w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793045470;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=voyW0pT6UtS/8bws97Ezq98HSucwe88GSLeBdCuOs8Q=;
	b=Q/gvpV74J5GysUb9SuaPl3pXZd81cTTEUliM50C7IAXA0olrv4mZNoM8XvrRXFxret0r
	 i0P65O9UNPA0q10u8Fn99VHpp6BjMriCMfwMznSY/a4qYSnGyyLhIARaY3KfO3JZ6wfg2
	 pczgqAxnd9echDez1t7NE66N59vK/V6OkXdaEy0X8MpX0/vnS/PJ/Q8/H6J8n2O0buNrW
	 eHkjlEUi19ilKFM20NPVqMHBsIgOYGIaCbf8PV41Yvqc83bpQmFrBUkA0PLl6GHXs0dQ0
	 Q+Rxm3wZs46bd3qqrv1xQ7Ysdfww7k6kxfGQxs0T8xdqcDYBxqEaeEO9dsnGgun0+dw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793045470;
	bh=voyW0pT6UtS/8bws97Ezq98HSucwe88GSLeBdCuOs8Q=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=p9/Fvb/70CPLt4t7x8RaU5S6OxJ7+WA3+k5eWCSn6PSJeOjpluJZNAQhDgl5gLIcX
	 KYOeHnqN0YdbkZcIiPZJQTCa+yqL+dO9uFPcyE3zlaZoPdRtpoMqDVH+6NSdh14i2C
	 Ibqe28ru/HFzVHrjzkrkcq92//9aX0iOCSOHlrxFQWsubKOAtcrNPdalhteyAM5WFZ
	 y5L06fqVi7ilzcDICXzjxcN96zDtwqTd9VBXsSskpWs18OVthnziZSMWb89B75CiBt
	 39DBRXbqFLeoZiFCXAUICfb6ksszOpucGADs9fFdmYbMFaVlyhQjOynQsyRb2f56PB
	 hv6R7tOmQ7nUw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 47F3440647;
	Mon, 26 Oct 2026 20:11:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id D6BC54BC
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 20:11:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D40A380C27
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 20:11:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id E4mKAtUZRL0a for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 20:11:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1264B80C26
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::101"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793045468;
 b=RBCBSP9S+tzQCDfr/t9adG2MN8xluJ9fyrT2rm8KnaktVRZ2qkJlYmY8gx/HOnQd8+vP
 n2Kl5mR/ptuzW26oD2C137dK8kEF0lom1Ye/mbgm6s29zqHKBals24n2hnFCGwRBCF7jl
 NCY9+J1R5X+zsQOL2iNTuPUKDDwGcGi39zLY3q/v31ZdzZKQ9v7L0qS2oI9LVoVco4PfV
 /yQQhypbs+VbN0po0BVs/46unm2xHqnJs1cDGsqZEliBWb1Xq9T7KnHBOlRCCSMBQwZXW
 AiYdlNg/9bwxzLGbcm6LTpdunISVpGaHBsgpEEvJ5kqV5W9EDXvEUpeSTp0I+/ImTDQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793045468;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
 X-MBO-RS-META:X-MBO-RS-ID;
 bh=voyW0pT6UtS/8bws97Ezq98HSucwe88GSLeBdCuOs8Q=;
 b=EKCJYhVvYZ44dFB+9+3LQbUTCCXOEdiRpc43BeBf0R1d/+DxGs1OUMsWoHz1yH6paX2J
 04SoMq1vTLLjlozkqMxF4mSCVtXVj4kqRa/XKQ/9QsyO5rOjdLyB7KbRZMq2pyddSIeNl
 Z4Q3pQG0T5W4CJA1paf1NPhNDJuIAZ0yoDyW9G+ebjYLGIv31+i63eTdNycAiRY4AIBnn
 EMonSkl5YF4KJN0538N8SMkAeB/o7uWgUC96kRwZ2eUUXETSzF+c+/23AqJm1B2zgevB0
 wxAyp6PmSb0llkpPNX0gZUcmFFj+OwCRwlRQPOR/T+5SSFTPrXrP8Oc3XWfodqs1eTg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=mailbox.org;
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=RCIaQBBm; 
 arc=none smtp.remote-ip="2001:67c:2050:0:465::101"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::101; helo=mout-p-101.mailbox.org;
 envelope-from=marek.vasut+renesas@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=RCIaQBBm
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1264B80C26
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 20:11:07 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4jD4WX10tlz8v93;
 Mon, 26 Oct 2026 21:11:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1793045464;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=voyW0pT6UtS/8bws97Ezq98HSucwe88GSLeBdCuOs8Q=;
 b=RCIaQBBmT5WGvKfYXx7C6gUZ69oMBVgJgB409hhM8+BoSgtjnzHrCCmX693ohaFCjnDX8R
 lBkXkJDejD3qohzH2igAIgxvCzKZL/6c83hA1p7LAVmD0Vck+HusW9XwhwyMJouVM8jtt4
 MUlVbKUwhMrIdb96r+I+a1wke34kQTYZt4/p+krskKwkol/aHatbz8pXe5QbZnqLPA6aJZ
 4sOFY0Asvbt6GiZ/d+psH9g9CpTA18xZJLFlhWXyDI03QfTTj7BFule5mLt9ci9fy9fQWy
 NhiVyO3jA00k3q54wVrWnxFxidebzg+qXTkZ4svC9CvF7w+5bTX9myFLzTifgg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Daniel Golle <daniel@makrotopia.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] dm: blk: Fix blk_common_cmd() return code typo
Date: Mon, 26 Oct 2026 21:10:52 +0100
Message-ID: <20261026201101.400702-1-marek.vasut+renesas@mailbox.org>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: ioad6hm5jsqekgr4y7bu8xi34pgu7fkq
X-MBO-RS-ID: ad14b68e845a745a671
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The CMD_RET_ERROR does not exist, update it to CMD_RET_FAILURE
which does exist. No functional change, this is a typo fix.

Fixes: 4395f6673901 ("dm: blk: Add a generic function for block device commands")
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Daniel Golle <daniel@makrotopia.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
---
 include/blk.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/blk.h b/include/blk.h
index 2cb9cb31ac2..810b7dfb7d8 100644
--- a/include/blk.h
+++ b/include/blk.h
@@ -748,7 +748,7 @@ const char *blk_get_uclass_name(enum uclass_id uclass_id);
  * @argv: Command arguments
  * @uclass_id: Interface type
  * @cur_devnump: Current device number for this interface type
- * Return: 0 if OK, CMD_RET_ERROR on error
+ * Return: 0 if OK, CMD_RET_FAILURE on error
  */
 int blk_common_cmd(int argc, char *const argv[], enum uclass_id uclass_id,
 		   int *cur_devnump);
-- 
2.53.0

