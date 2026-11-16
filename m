Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24374606BE14
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 11:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=LarF8W2a;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=IgS7HTV/
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F1F52405CF;
	Mon, 16 Nov 2026 11:06:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MZHSJhf9BSro; Mon, 16 Nov 2026 11:06:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 466E1405DD
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794827201;
	b=aebSfnbYtO+u0LGVICnDyqwTbYepdzy1e10G0Y1D2t6IwoqXrKPkqeBQeHZoKIetOq8c
	 R89dPgb/tBGqjY6bLDAA7bK3En8xyHz42BG1NOkv6GUs1BERUCbFDvrev8GyNmXpKJo8g
	 v1XTK0EoBG8KT5o318t2GdSiS00Tz9dG4cmDkpa+01/XGwKyJY9pLJlNK83H6NtQzkmo/
	 nbWQDgmnkw4tpKAYh2A3N5RidLSj8aLj2aAKvLCKe09rAQmlB19KoZ8pJCVDvAmrGoPkQ
	 gGjpAE4kaXWQws+vsh5hcwvQarXhkhlI5Fdwt9kyI3q7STGeaDPHyv2EVXU9IUVVPkw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794827201;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-MBO-RS-ID:X-MBO-RS-META:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=EnSxiS4Qkbn0TQR4X4qhtOsbmggRBnilRuAn+xApt/0=;
	b=T87kjiK36gyaGwZ+sg5eA65BVCKoKxFz8gWJYDEzdaevzqRNtfChH4mr898UMA38KuJ/
	 KNecMv9I4XB70N98DKMMUcVF78h5MNjMIuPVJtP3Km6cZQKrMxqi0mJQVgEQL/gbVj6yS
	 zGCFzxl5jdHMNgbbkJ/R8SKaVf4nSXPOqNTkgmUAlELo4sCT38iYOUPbgpS3SQywgH4oL
	 if/kFlXG/IylISdTguvT9p2b7WTBOJUMpF7VTXApFplcQVP03KSt6sWib1tnChx5lhMTz
	 ory1Ndl37Ke6Q3OsV1DKhu7iZ1l72B/1mcgAHzPREsHKF0kNqO4fjmV0S9H1QQt4jXg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b="IgS7HTV/";
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794827201;
	bh=EnSxiS4Qkbn0TQR4X4qhtOsbmggRBnilRuAn+xApt/0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LarF8W2axUlE3rNBXlH00sJ/GreLHCH3cqvyNwvK00vn4IeBn9Izi81MfGy1J9bqd
	 F/LFz5MSccc+p1d+4Nz8ulIwFZShysQl0sYN5T1esrfi7jeypetfQlISk2WIVdyyaM
	 +FO8b3EhNoT8iUBe2QMiupBbiRoaQ8w77M4ia8l6SSMgR3guU6/MYuqzzYobzp4eCm
	 h6fgcO/nhcKu4TpcYZ8MyIT/LBBuoO+D0ep33eUZj5KvyJ1FsOlexsfKRwGidwG0/N
	 t8lncg1eN9id+BHhcfzhQSZRBZnpaVQsW72niX+AfdBJerGaQGrGGxmWtzRGobic3z
	 VKPEo8eEyZLjg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 466E1405DD;
	Mon, 16 Nov 2026 11:06:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id EA7172FB
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 11:06:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D0CA6405DD
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 11:06:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cuhnvH1h1V60 for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 11:06:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org EA914405CF
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::102"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::102; helo=mout-p-102.mailbox.org;
 envelope-from=marek.vasut+renesas@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=IgS7HTV/
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EA914405CF
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 11:06:34 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4jSlRW1KHmzKnBW;
 Mon, 16 Nov 2026 12:06:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1794827191;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EnSxiS4Qkbn0TQR4X4qhtOsbmggRBnilRuAn+xApt/0=;
 b=IgS7HTV/eT1CfkiaMc9InD9tCWxLldDG4GwEbbcVFbdZqtuPQxyOX/fqLqJzfoSWTOSGKn
 W4NQhudZ4fu2Ymc1x1e43B0K/fZYBldvRPm2abLnjnBxLxAHB3LvORTGC3kF5JA9ZXMH46
 Chi8cUoEPWasfHP5zYtz21c1YiXxKCJytLiolUipdomRp79xhDo9fBIdB1zOrPeaXjKtse
 OxAPRaaVL+WI/V+X7m62kam8ksWaDRm44mNatqtWayPspRg8EI9MyAu3fLLMAE+S/elk+N
 qH2AiSFKDgge/7mAZKBPUIA5dlbo+a8F4Msc7SSkw4Gs4RBthy1Huijj1VYPdg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Alexey Charkov <alchark@flipper.net>,
 Casey Connolly <casey.connolly@linaro.org>,
 Daniel Golle <daniel@makrotopia.org>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Lukasz Majewski <lukma@nabladev.com>,
 Mehmet Fide <mehmet.fide@screeningeagle.com>,
 Michal Simek <michal.simek@amd.com>, Peng Fan <peng.fan@nxp.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Udit Kumar <u-kumar1@ti.com>
Subject: [PATCH 2/9] firmware: scmi: sandbox: Add SCMI reset domain protocol
 attribute handling
Date: Mon, 16 Nov 2026 12:05:38 +0100
Message-ID: <20261116110615.3394324-2-marek.vasut+renesas@mailbox.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261116110615.3394324-1-marek.vasut+renesas@mailbox.org>
References: <20261116110615.3394324-1-marek.vasut+renesas@mailbox.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 9946ec90057216b626d
X-MBO-RS-META: jgjsunwkiem5oo5odkgsaq5fye916fpd
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

Add handling for the SCMI reset domain PROTOCOL_ATTRIBUTE command.
Report reset count.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Alexey Charkov <alchark@flipper.net>
Cc: Casey Connolly <casey.connolly@linaro.org>
Cc: Daniel Golle <daniel@makrotopia.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Lukasz Majewski <lukma@nabladev.com>
Cc: Mehmet Fide <mehmet.fide@screeningeagle.com>
Cc: Michal Simek <michal.simek@amd.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: Udit Kumar <u-kumar1@ti.com>
Cc: u-boot@lists.u-boot-project.org
---
 drivers/firmware/scmi/sandbox-scmi_agent.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/firmware/scmi/sandbox-scmi_agent.c b/drivers/firmware/scmi/sandbox-scmi_agent.c
index 1575e341a19..6f058d5c2aa 100644
--- a/drivers/firmware/scmi/sandbox-scmi_agent.c
+++ b/drivers/firmware/scmi/sandbox-scmi_agent.c
@@ -898,6 +898,21 @@ static int sandbox_scmi_rd_version(struct udevice *dev,
 	return 0;
 }
 
+static int sandbox_scmi_rd_protocol_attribs(struct udevice *dev,
+					    struct scmi_msg *msg)
+{
+	struct scmi_rd_protocol_attr_out *out = NULL;
+
+	if (!msg->out_msg || msg->out_msg_sz < sizeof(*out))
+		return -EINVAL;
+
+	out = (struct scmi_rd_protocol_attr_out *)msg->out_msg;
+	out->attributes = ARRAY_SIZE(scmi_reset);
+	out->status = SCMI_SUCCESS;
+
+	return 0;
+}
+
 static int sandbox_scmi_rd_attribs(struct udevice *dev, struct scmi_msg *msg)
 {
 	struct scmi_rd_attr_in *in = NULL;
@@ -1279,6 +1294,8 @@ static int sandbox_scmi_test_process_msg(struct udevice *dev,
 		switch (msg->message_id) {
 		case SCMI_RESET_DOMAIN_VERSION:
 			return sandbox_scmi_rd_version(dev, msg);
+		case SCMI_PROTOCOL_ATTRIBUTES:
+			return sandbox_scmi_rd_protocol_attribs(dev, msg);
 		case SCMI_RESET_DOMAIN_ATTRIBUTES:
 			return sandbox_scmi_rd_attribs(dev, msg);
 		case SCMI_RESET_DOMAIN_RESET:
-- 
2.53.0

