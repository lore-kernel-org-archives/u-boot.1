Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DCB606A31C
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 17:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ivL5Nj//;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=g2RF6Kfu
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 800498110E;
	Mon, 16 Nov 2026 17:36:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jP-MqMtOlt-5; Mon, 16 Nov 2026 17:36:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5AE6A8111A
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794850583;
	b=Slx0owN6qOe6UP3gryjbecCvPnwI5RPh3Ug1L52jRVt9/aknjARVx1vbYsgH/XO8aTUJ
	 xWtu6CUeR3C/V7rGMsgM1eQLAbQfLfGYqKcZzWZaDf4BvR+dnH1hgIA4srws3zIWtWdXm
	 UJraDW4DmP8I5ZuuIhcwogKbbFZwj9ZW6th7A5Kq5vBJpasa7twwYfvGjO1VV5f2tgrAR
	 b5CgeYpUwN4EFefB/Ndc2QnargpO0Su5uVLp2QilrHI8syAfb1gQrjVcYBDalYBuzLCO2
	 DYusxkWKmE+vz0Hy3YRmeu6C/DYST5Fat1c/emYjNRu76Rtc+C6dv2xL+m3xgSnZjUw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794850583;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-MBO-RS-META:X-MBO-RS-ID:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=dRk695h3om15ueHaQ0djIVB24IVozEPio1eQZIt1KDg=;
	b=JkkXFCkxYBp/ZlPHl1S66BwA5qpqDR1/8YpeS0eOQhfsK3aslB75SXOMDVhFs8B1t22A
	 aCPyR9KfI8fPriIgmvrAyyKY+fypo8R97aX7HB7NFSygbf1S9WsWi+tonVYMYC+0x9X+T
	 sotGqSVJtFs5t/E/55L1onLADmb15e1Y1xAq19aEYbp0Ic2jv5ekjbG3BoQ2EIGGRZNIh
	 clVuPA2pbScznWIUNsQBZ0R3vHGLkDTWhisffnzMAbtpcS/3DGx/i7NhE/0y56++kb3qM
	 2PA21xpcuG0STpVZPiKuYP+/E/uGb4NpvGYDunreg0idkulm964KuBFn7Rtn09lJVoQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794850583;
	bh=dRk695h3om15ueHaQ0djIVB24IVozEPio1eQZIt1KDg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ivL5Nj//0J4QHOB/b2cZ+2lmRuMillyKRIQeAs14ieEc8FWSQ8FY4nCcNmEIyWJbs
	 DC6+n/opOjyRxwb8vgOonB326NCOXDJO/d/xX3RT1aNZeENq6Co/Uz6QF0IuGxW1ik
	 TWRztgFxgH/PQPwWjpZO4YIU9MxYNRDJid15w38z1CWSiUZYvtxJfYe63+zm6nQev0
	 p539LenSwCvKuioBPszYxtzllG5Dl5p/YYGMLBS/HyichGimb2Az9UsIPlSFkbaxHP
	 PhT6l6rPOXbBPshj1I1M/LlNEGOYWEFSwbRJWopIvFMJwVU/gIESSKMgWps8EDI1o4
	 MeHZB+zKLdpDg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5AE6A8111A;
	Mon, 16 Nov 2026 17:36:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6AC8928C
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:36:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 50FF8402CE
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:36:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id g2PGFPxgBQoC for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 17:36:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org AB558402CD
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::201"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::201; helo=mout-p-201.mailbox.org;
 envelope-from=marek.vasut+renesas@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=g2RF6Kfu
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AB558402CD
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:36:02 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4jSw4w074vzMllT;
 Mon, 16 Nov 2026 18:36:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1794850560;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dRk695h3om15ueHaQ0djIVB24IVozEPio1eQZIt1KDg=;
 b=g2RF6Kfu2gJDoQdZMqlqQMJvfS5EVF1JcDOBgrR6QG0E9/Pr1xQDx8q1Ob4GlF7bum04Ns
 JW757ljyruZ0JYSTGJFdJ4/9QH3cbT2FGNX6+DgTp40Ua9AMl8iOxyMC7ESwytiquyRkXg
 CgX1/JDZ+xhZZBZgb+rWLDn3+aHoAob/4ELnSZ7A3gG+XA/WHk49fIJ+jMjUUC+WBo7Hcj
 5eoiGma9jfMFFcrW+AhBeBr0qKPm8vSP7gd/vAzcpCeNo++UoYPHVgyb6dpOiKMEeITbFo
 sLNseNAa2N4LXOLWN8fiuocqM1B8kA4R8CgpxhV6U0s0a5gppjiTiKeI/Q4oxQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Lukasz Majewski <lukma@nabladev.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 14/20] clk: stub: Constify driver ops
Date: Mon, 16 Nov 2026 18:34:53 +0100
Message-ID: <20261116173546.3487841-14-marek.vasut+renesas@mailbox.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261116173546.3487841-1-marek.vasut+renesas@mailbox.org>
References: <20261116173546.3487841-1-marek.vasut+renesas@mailbox.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 5p1tf9iidnrsszmibhaccc18yifxcd9c
X-MBO-RS-ID: edc8ed9e2cb91e4d221
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

Set the ops structure as static const. The structure is not accessible
from outside of this driver and is not going to be modified at runtime.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: Casey Connolly <casey.connolly@linaro.org>
Cc: Lukasz Majewski <lukma@nabladev.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
---
 drivers/clk/clk-stub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk-stub.c b/drivers/clk/clk-stub.c
index 74825f87580..7c8547b3a60 100644
--- a/drivers/clk/clk-stub.c
+++ b/drivers/clk/clk-stub.c
@@ -41,7 +41,7 @@ static int stub_clk_nop(struct clk *clk)
 	return 0;
 }
 
-static struct clk_ops stub_clk_ops = {
+static const struct clk_ops stub_clk_ops = {
 	.set_rate = stub_clk_set_rate,
 	.get_rate = stub_clk_get_rate,
 	.enable = stub_clk_nop,
-- 
2.53.0

