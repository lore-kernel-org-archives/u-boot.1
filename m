Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256DB606F1FF
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 11:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=bIfYzJui;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=GDOrvnO2
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 03721405DD;
	Mon, 16 Nov 2026 11:06:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EXUYaaOh79jD; Mon, 16 Nov 2026 11:06:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4A32C406A3
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794827207;
	b=W4hfFTiZuLGDVa3RODNvMr8ilpMs1quvm3lW2q2jCUNA4JE5wuinUA7LGksqtocEphw4
	 fgqvbjGEUN9ACwxOJ8FljeAxxdSWvVofDzo95qgI3FtzVEFTlqijosxTyodInmWxOMu8c
	 2mVm7ZJNbD22z9icZKeOKeniibrOP8m7QEwIZhJU25BTKj2SFudz8WHOthxyBt7bKvy+t
	 cMIHzI+H8qrG2QyK0KBnLi6zjc7F1DTaZznlx5E4LwJ+pJLgkML45Y1LHq/dfGe5y1BM1
	 Ae1oSuMFTZ1M8PkWRKTYnqeq4fmWUuUxY3WFyoXNe/qZGYtN5rPtpc5rwUeB7IJmIPg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794827207;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-MBO-RS-META:X-MBO-RS-ID:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=FJhee7VNhMQsiFA/ODCzTfHuAsHKpT6h3aX9t7X5UqM=;
	b=E3cgzZ7A2DlregYNg+Z9F5GkWNK91jHU7ebXmKQqFjRbLTUv4/iQsP2/RvAwIG7+My92
	 k1hildtmmE+1M1eiZCiOEYlCkT29JieiXQKbOSewMVK9LKNNqfMz0e1QQFFTg5Z92GFGq
	 JRAVfA0gzrzdi2yRlq0qLjnrxVxdiMES3jjzgHYgUO8p2ZlIH7OK8Rx/pgV0KFMwPtuA8
	 m/k+5I48/UTUV2g7wkUmNx1o2PX9SvWKLyVXzALXl/tCLgmePeu1/nSbTQToiKfcyTlJq
	 KmDI8lY3aolPW5ftMachbtvP6BsYDadoE9Ybt/K9Jqme3io1FE23iNl8JbzHDP/1zxw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794827207;
	bh=FJhee7VNhMQsiFA/ODCzTfHuAsHKpT6h3aX9t7X5UqM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bIfYzJuit0/8HigQLwxbVShSpTNhd6xpHaU2hE4beAwriH0c5zPJwy1SwaUSrV43O
	 7HtZw0foTdyOCqnRI5oJquWYPHTof9WE3ih6B87BUMWnUUvUpD1L6rJrw/HChcctA+
	 cTvExotz6UKCtAelEMYzpaCU0b9f4hzetCLvwV3QZN1MY2FnO9WErhobU/H4bZ069X
	 mdvgNUVl8wFjcjowJ0Ohk4WKKxZPBXKvHzoQ75pOoUSz5Hb3HzxrdMUGV1jK9ageXP
	 FqIX56t4aA6Q0tWO9c5OBsNm9FXqm5sWWYuelspc2Hb3TTQc1DMKKvJnCagMNo/74y
	 ivaJSa2ObU0Dg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4A32C406A3;
	Mon, 16 Nov 2026 11:06:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id F28021A6
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 11:06:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E409640070
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 11:06:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eR7BoWYUfeZZ for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 11:06:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org D4B9140068
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=80.241.56.151
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.151;
 helo=mout-p-101.mailbox.org; envelope-from=marek.vasut+renesas@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=GDOrvnO2
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D4B9140068
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 11:06:40 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4jSlRc6t5Xz8sWd;
 Mon, 16 Nov 2026 12:06:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1794827197;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FJhee7VNhMQsiFA/ODCzTfHuAsHKpT6h3aX9t7X5UqM=;
 b=GDOrvnO2wyaUI1CoejBPNGsYMnutFfsYANbBnEZjHUbLUuvYk8t+rj883eZvWzUhwns/DR
 E9TiESi2VNu5CtPgsNZ1ysvauZVZIezh65iuGzyOdzrnYA/O4vfDbwv9QfLY3vx8+Dl7pj
 FuTVGCxBSwHDLy5kVleFhMZPfMc3Zg8tquj4b7pFnAoCNdgaICk9HAamZSKY2BhIjb8nnO
 kI5M5hy9yFMAzcpFEhvn8qxnJpUnd2qzXC1ogUjJLUV96Z4w51E5DO4Uy5O6HmRg7sPhIX
 sSJ4QXvA8iFUksXNlBzkzOu6TzsTBGbD2a9IvaHAdgm3PnuKa4I5ylTaHk/IYQ==
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
Subject: [PATCH 5/9] scmi: Add powercap and telemetry protocols
Date: Mon, 16 Nov 2026 12:05:41 +0100
Message-ID: <20261116110615.3394324-5-marek.vasut+renesas@mailbox.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261116110615.3394324-1-marek.vasut+renesas@mailbox.org>
References: <20261116110615.3394324-1-marek.vasut+renesas@mailbox.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: f8obksdhgqcxmosmhsj6dbiargubszb3
X-MBO-RS-ID: 174b5430f7be4e2f821
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

Add macros and names for SCMI powercap and telemetry protocols.

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
 cmd/scmi.c               | 2 ++
 include/scmi_protocols.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/cmd/scmi.c b/cmd/scmi.c
index 1aa20c7bd96..8ab4451cdbd 100644
--- a/cmd/scmi.c
+++ b/cmd/scmi.c
@@ -29,7 +29,9 @@ struct {
 	{SCMI_PROTOCOL_ID_SENSOR, "Sensor management"},
 	{SCMI_PROTOCOL_ID_RESET_DOMAIN, "Reset domain management"},
 	{SCMI_PROTOCOL_ID_VOLTAGE_DOMAIN, "Voltage domain management"},
+	{SCMI_PROTOCOL_ID_POWERCAP, "Power capping and monitoring"},
 	{SCMI_PROTOCOL_ID_PINCTRL, "Pin control management"},
+	{SCMI_PROTOCOL_ID_TELEMETRY, "System telemetry"},
 	{SCMI_PROTOCOL_ID_VENDOR_80, "Vendor specific (0x80)"},
 	{SCMI_PROTOCOL_ID_VENDOR_81, "Vendor specific (0x81)"},
 	{SCMI_PROTOCOL_ID_VENDOR_82, "Vendor specific (0x82)"},
diff --git a/include/scmi_protocols.h b/include/scmi_protocols.h
index ed64db4e4e9..1a58549555d 100644
--- a/include/scmi_protocols.h
+++ b/include/scmi_protocols.h
@@ -24,7 +24,9 @@ enum scmi_std_protocol {
 	SCMI_PROTOCOL_ID_SENSOR = 0x15,
 	SCMI_PROTOCOL_ID_RESET_DOMAIN = 0x16,
 	SCMI_PROTOCOL_ID_VOLTAGE_DOMAIN = 0x17,
+	SCMI_PROTOCOL_ID_POWERCAP = 0x18,
 	SCMI_PROTOCOL_ID_PINCTRL = 0x19,
+	SCMI_PROTOCOL_ID_TELEMETRY = 0x1b,
 	SCMI_PROTOCOL_ID_VENDOR_80 = 0x80,
 	SCMI_PROTOCOL_ID_VENDOR_81 = 0x81,
 	SCMI_PROTOCOL_ID_VENDOR_82 = 0x82,
-- 
2.53.0

