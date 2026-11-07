Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6090606A32C
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 12:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=O0P4D6yI;
	dkim=pass (1024-bit key) header.d=student.uibk.ac.at header.i=@student.uibk.ac.at header.a=rsa-sha256 header.s=prod24a header.b=MbUpNWpJ
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 95B718175E;
	Sat,  7 Nov 2026 12:51:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id d8XAZj1HQ-w1; Sat,  7 Nov 2026 12:51:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9922A8174F
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794055867;
	b=PyUN4jGlmj1wW9IDBvPyxw7axogxqF0dnF0Zbj8dExdXCk1KEucZX90TA0ADfHBVQzOh
	 5rhoUvoV8ONDrkiMMui2RwkMHqwE59U9OWCAqeGdfTyKex/c8vU+QpyN8DPFOqo7NaaKw
	 4K8VNLKE6CFZWnA/ixKjL+BLhgdsa36xu4OvhTEEPABuXMeaIDI7aDusGSags35IHnWVN
	 vmFO1lbHwNmnpmrl4AgqthxakLdK444bw5WRSKjmhbALo8XwokxuDRx/CHsQtCJIySkze
	 ifRrIe2VTRa8qEEhgeSlJ8B/oLm47UFrfVqDKe5kuVBDHkRgmEHDB32MJiidKlKk1mA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794055867;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Scanned-By:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=oHxGkcu4DV4fl19+idP9HEr9ZPJwgCdM1Q5ghWWbUFc=;
	b=J0r9CDWDBUF/7RNT0JIcxQhYwTR1FZlYi5+T/e3gT4qzM+vSJmScibcI1zMlpEaUVED1
	 gamEdXs/t6EAan2gwIXzJTYPMWz6wwgLAF/+xGI6iuPyEpzikGvtabpTnu4Blvhz7OjcM
	 R30exzb6yZMqRcvdDcplvxnDVsn7YYQ669PhK5RDiLwTkuLgGTwBLEXJ/CNEnTmOyA0UW
	 Pozm9aCZIIvi5RglHKw5wW8UOaB8VUqPlSAab3QfvYe3tOXMOijtbmf4yGVWxfQ9mqVB1
	 i92LbqriJXg+TrhGrSRPvUUKAC/8cJ47977sSLF4Bfjl+VGO3DzqIytENarpR7diiIw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794055867;
	bh=oHxGkcu4DV4fl19+idP9HEr9ZPJwgCdM1Q5ghWWbUFc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=O0P4D6yInpuybpi/cnc8lVWwOGQh6s77fmnPYHaurC1rw59NMuXHJlfgp+NH7Rydt
	 YnqF0wVG7m6+J17mhQGnysmnK+Vv36VNjhpT4x4WIaqJsUlwleZ8+Wz7VDSUhUxaR+
	 1qL58H9naQBW637TuDVtDr3iuofNSxskCFtBXYlKoMtyRQZG+JdfgHZjHd7DnrFwxO
	 W5zYCL5Vl8LpLzx2+Xn8bruS0KC4AraIrPPpH7jhsR31t7cI3tHC0v0/DwnL6IIb5H
	 Bnj5NIo4zAZxhN/LiVfsl2lrJyMKErHKzI+1n6wYVn+moIhFc0Gp9kK+n9M+mkSlM9
	 TzPCtOAdrcvVA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9922A8174F;
	Sat,  7 Nov 2026 12:51:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8F0BD34D
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 11:54:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7592A4009B
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 11:54:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2Y8drdtjvMRf for <u-boot@lists.u-boot-project.org>;
 Sat,  7 Nov 2026 11:54:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 7BF4B400BB
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=138.232.1.142
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=138.232.1.142;
 helo=lmr1.uibk.ac.at; envelope-from=christian.koever-draxl@student.uibk.ac.at;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=student.uibk.ac.at
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=student.uibk.ac.at
 header.i=@student.uibk.ac.at header.a=rsa-sha256 header.s=prod24a
 header.b=MbUpNWpJ
Received: from lmr1.uibk.ac.at (lmr1.uibk.ac.at [138.232.1.142])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7BF4B400BB
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 11:54:29 +0000 (UTC)
Received: from surface-pro-5 (178.115.47.78.wireless.dyn.drei.com
 [178.115.47.78]) (authenticated bits=0)
 by smtp.uibk.ac.at (8.15.2/8.15.2/F1) with ESMTPSA id 6A7Bivmt711658
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Sat, 7 Nov 2026 12:45:10 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp.uibk.ac.at 6A7Bivmt711658
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=student.uibk.ac.at;
 s=prod24a; t=1794051910;
 bh=oHxGkcu4DV4fl19+idP9HEr9ZPJwgCdM1Q5ghWWbUFc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=MbUpNWpJvbTQkQO6j9hxsJCg0EqfDrLLHs590jFKVPKqE46kWjkOYkz82Tg0yPcCt
 5FjbYZGIecnzZjMp5zXqHK9x6s+dfqV6HaBVWWZv3R4eKOfJ8AcRuqV8p2JgIx+lax
 SrIeeT3Mg+aIG9CxSHMbALR+Iq04lGMbea35ggeU=
From: christian.koever-draxl@student.uibk.ac.at
To: u-boot@lists.u-boot-project.org
Cc: trini@konsulko.com, patrice.chotard@foss.st.com,
 patrick.delaunay@foss.st.com, uboot-stm32@st-md-mailman.stormreply.com,
 =?UTF-8?q?Christian=20Stefan=20K=C3=B6v=C3=A9r-Draxl?= <ckoever@outlook.de>,
 "Claude Opus 5.5" <noreply@anthropic.com>
Subject: [RFC PATCH 04/10] pinctrl: stm32: add STM32L4R5 compatible
Date: Sat,  7 Nov 2026 12:44:49 +0100
Message-ID: <20261107114455.304896-5-christian.koever-draxl@student.uibk.ac.at>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261107114455.304896-1-christian.koever-draxl@student.uibk.ac.at>
References: <20261107114455.304896-1-christian.koever-draxl@student.uibk.ac.at>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang_3.2_at_uibk.ac.at
X-Mailman-Approved-At: Sat, 07 Nov 2026 12:50:14 +0000
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

From: Christian Stefan Kövér-Draxl <ckoever@outlook.de>

The STM32L4+ GPIO block has the same register layout as the F4/F7/H7
one (MODER..AFRH at 0x00..0x24, BRR at 0x28, RM0432 section 8.4) and no
secure configuration register, so reuse the no_sec variant.

This patch was written with heavy use of an AI coding assistant
(Claude Code, model Claude Opus 5.5), reviewed by the submitter and
tested on a NUCLEO-L4R5ZI; see the cover letter for details.

Co-Authored-By: Claude Opus 5.5 <noreply@anthropic.com>
Signed-off-by: Christian Stefan Kövér-Draxl <ckoever@outlook.de>
---
 drivers/pinctrl/pinctrl_stm32.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/pinctrl_stm32.c b/drivers/pinctrl/pinctrl_stm32.c
index 1758f9a9..168d7c8c 100644
--- a/drivers/pinctrl/pinctrl_stm32.c
+++ b/drivers/pinctrl/pinctrl_stm32.c
@@ -560,6 +560,7 @@ static const struct udevice_id stm32_pinctrl_ids[] = {
 	{ .compatible = "st,stm32f746-pinctrl",    .data = (ulong)&stm32_pinctrl_no_sec },
 	{ .compatible = "st,stm32f769-pinctrl",    .data = (ulong)&stm32_pinctrl_no_sec },
 	{ .compatible = "st,stm32h743-pinctrl",    .data = (ulong)&stm32_pinctrl_no_sec },
+	{ .compatible = "st,stm32l4r5-pinctrl",    .data = (ulong)&stm32_pinctrl_no_sec },
 	{ .compatible = "st,stm32mp157-pinctrl",   .data = (ulong)&stm32_pinctrl_no_sec },
 	{ .compatible = "st,stm32mp157-z-pinctrl", .data = (ulong)&stm32_pinctrl_no_sec },
 	{ .compatible = "st,stm32mp135-pinctrl",   .data = (ulong)&stm32_pinctrl_with_sec },
-- 
2.56.0

