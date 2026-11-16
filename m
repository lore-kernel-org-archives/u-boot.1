Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F056606A322
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 17:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=GTikNRu7;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=lu80+W+1
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2C13481165;
	Mon, 16 Nov 2026 17:36:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fPwkRqmf6OVH; Mon, 16 Nov 2026 17:36:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7C709810F5
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794850592;
	b=VImxoCC6XNUH36lMR2WG0Coero+1TzH7Oq1ECTVECgYPf8Bcdou7vNVmeg3s4K5Xk0qw
	 al5QdAJEpS8pFOJxfUG+lMC0P8IX1L3FH3z3y1whWAl3qNow1OjLgNaEAtFjWMOd5kcI4
	 +R4ksODd8/AtRIYOA/pDF2TbVZcgEzT3VK6dZ4hD5f7VcQsb2Xlfi4M+Qbm6HnGblg9rW
	 FWwJXg0JXaS1RS/yCLMiCTccUsuP32mjpqBvVWLNZ3flXvKJLT7Fgd7ufnT72PSQ04Wrj
	 r0mS2+O4721ox1Qi/10DIMGs1Qz/SSOrIab2tX9rhnSWB1UfAFUxWgFCZYy2aRB1EiQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794850592;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-MBO-RS-ID:X-MBO-RS-META:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=JTGy/RALs1Zp2TaNL3Qr+m3ZxhPvX01QEC+7KrbyZ0Q=;
	b=nNRgi8GTlMqfiIBP1XkpUTH5eJ2N9BGp1k3mNSNXGI/tC+4DhRar7DsUUe548D+yb1Bz
	 Jsvng7+dHg6DWHnNv09mH3PA8w64OUv9CkAjHwYVOPdGUCd9zbkZEAtgAsykItTTBAwMx
	 uqO6U4qCJqRQLx3FzLNHq+4hr8CIvB20zqNZox6alit0DqozOZ1cZE+DAhw/A6gpw1/FC
	 mes0wTDF/nDB1xg6SDtzbXtMzZ2SxvbkWfjxU6XDTPXLedq80es2z/x1ujKhQH4CHMZZa
	 2dabFwT/hVtW0GzHP0x3ggybVoga+5evQdcJiJUmujCFF55dVHLaU0j8E9YakkdLYwQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794850592;
	bh=JTGy/RALs1Zp2TaNL3Qr+m3ZxhPvX01QEC+7KrbyZ0Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GTikNRu7sYZ3aT+gYM911gVaRCSQ0WdbdXG90TSTylygacEiEDBuh8/mJI8nermYA
	 MB170yRnoRVz+OZZGukNjLkzOECC96t2WMvnPbI8L+r8aEsoXRj6CqScqIf2mwxJ4H
	 9lNnwoNIO7KSGYbTN1u7GrxRqkZMq30WDO5niCg+WBMXJZXIyMzDVwiZfg+1A5LlUU
	 1fLKY97B6WrVAwUS4BCSbDwGBa5bYUDPxcJi1KD0zlosHGc9pH8OshcWeIm2qZ5a5F
	 1yMVxfsCydwQcD3JzdwpobKOyw7rUXXlNqEvq3GF6EuMLYQeC0PPTLB03N7d7V7i5P
	 ZGxWinU/068Dw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7C709810F5;
	Mon, 16 Nov 2026 17:36:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1AA2B28C
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:36:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EFED140786
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:36:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8Ku-79351SeW for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 17:36:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E7F7740783
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::103"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::103; helo=mout-p-103.mailbox.org;
 envelope-from=marek.vasut+renesas@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=lu80+W+1
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E7F7740783
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:36:05 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4jSw4y6194zKmKJ;
 Mon, 16 Nov 2026 18:36:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1794850562;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JTGy/RALs1Zp2TaNL3Qr+m3ZxhPvX01QEC+7KrbyZ0Q=;
 b=lu80+W+1wgwM6xVbGmh2u13PF1hn41MlOf5RBRb+1N6b6KDtK1FvJPm5/O7y3q67pxcdi5
 EC6bpbHUKpTPROyD8u0ZwyAZ6afYe2pvf5brYCvkUAoIf8S8X+9KkxieDM30veJFTeUdD9
 HuJZSYRo1syNP6TPtLdVjDar3Q3G8ai1TLSehKDGIqBt25UwQJ8v73P7Zw43dfnbqS8wcV
 or2DMFKry1ANfHzPpEaaxY99GvDxC4bWZtq0MIH21EW1QXf2NFvlAPGb6ezfRwiNFfDRgm
 1TcxcXGL33ZZLQCUEnT5hLBCIxdNXoI7W8gwP/0z0R8Y+1vQxQyK6El34LdQPQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Lukasz Majewski <lukma@nabladev.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 19/20] clk: xlnx: Constify driver ops
Date: Mon, 16 Nov 2026 18:34:58 +0100
Message-ID: <20261116173546.3487841-19-marek.vasut+renesas@mailbox.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261116173546.3487841-1-marek.vasut+renesas@mailbox.org>
References: <20261116173546.3487841-1-marek.vasut+renesas@mailbox.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 4556e4c0a1a4ecb7c35
X-MBO-RS-META: ryednctngmzq7ape59fyt5jxfmnibzqw
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
Cc: Lukasz Majewski <lukma@nabladev.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
---
 drivers/clk/clk-xlnx-clock-wizard.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk-xlnx-clock-wizard.c b/drivers/clk/clk-xlnx-clock-wizard.c
index 4a3f50c638b..a40a5345c03 100644
--- a/drivers/clk/clk-xlnx-clock-wizard.c
+++ b/drivers/clk/clk-xlnx-clock-wizard.c
@@ -105,7 +105,7 @@ static unsigned long clk_wzrd_set_rate(struct clk *clk, ulong rate)
 	return 0;
 }
 
-static struct clk_ops clk_wzrd_ops = {
+static const struct clk_ops clk_wzrd_ops = {
 	.enable = clk_wzrd_enable,
 	.set_rate = clk_wzrd_set_rate,
 };
-- 
2.53.0

