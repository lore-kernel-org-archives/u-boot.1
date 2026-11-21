Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FB2606A320
	for <u-boot@archiver.kernel.org>; Sat, 21 Nov 2026 12:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=j54Fkj0x;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=KSVuWHRk
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 99213606FA;
	Sat, 21 Nov 2026 12:35:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jlMeBz8uymET; Sat, 21 Nov 2026 12:35:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org DA3CC606C9
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795264527;
	b=HoF/yGUPveScaE6xoBOr6YkthDJpGZsKeixeP8/bGs1xosl/Rnabxp3HWHkWjEplCJmf
	 w4lmOOEd8DaQIn9pH0XGyDJf2guWSx33sSHNYRLkNZBdAs3CAjvs+NE2rhBuQDR58Ajzc
	 ane6G1NIZ51G2da6tTegx44zp0ciddAoVnitiFdoigpVIq4sPBKRDByEpLtx5F32OAxn1
	 valJe8IAytZOVU6EezG9gnfNjo0Tb/OE6lwjk6YQ3Yc4mBdzTo0q/TbVcnJxyeShGEyKV
	 bblfH/SOC/6MfIbm0zJ3fFrQQf0jUL/aQacO71AQoE79/+PzNKTjjAyUl1Jcj7ykfqA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795264527;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=l/JrBhID4Buiq6eBE8F4EsCAeAZ7QVoclOXi2dBQNLM=;
	b=W9LB2a8tx2eIG88YHeUDgzK6v8s2WXVvcPdS2nPifiLPfYVT003x+DhdQ82dKLjhOBRx
	 HHExcecV+ThFq8bSbIEQf+fQzo1/4A+bWyNXjhubtKY2iHldtIWyMIbTCe2LiqlgOvUx0
	 rf+Bdd43VrUJtchZCEzRZzdiFcdal7LNPquEJySPYeCQL6nLfa9pnWOg0pZxrdjEl9Wkc
	 d3LLKfeunYG327JLXrffqO2xvx8JHPA0WTdRLgN9WxS6SU8KkW1jrWxnQMxsnOT69BqtZ
	 3rn9MZye7MVyPhKwE0VCFfE82I6z1UL9Y3i6HHc7FGp9VtOoCeaVpBO3COPubZdw7qQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795264527;
	bh=l/JrBhID4Buiq6eBE8F4EsCAeAZ7QVoclOXi2dBQNLM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=j54Fkj0x2wKDrOenGgSsZ4AJ1Nf8/aUVc23oO6tE7DkIEvw4iZEZP0YYGWgyo7Qn5
	 jie4AoQj48D4S2S8ZliGMKPvugBtguYrPNYbxlFTov/qEq55Yd5LnM6QmKJ/hCPNYV
	 eLbXhfNVODY3TV8YC6Bq1OrLYQUis3DkVoYk2E5PGV/bwVrTNNCw33i3MkbaOEP+DX
	 VDNvf0j+YhdsRzpZ7IPYc1/8t7v81DO8h5k2s4qjXCtJETixOKpTUjBNGLtPsLzlTH
	 BIdj4VWH1ZRh4pHPf9XDo5qDncKBdM7PlHNdYMh28Irc8d4EJFxQBZp3i9YlkU5e+U
	 wMnnweKxZbQiA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DA3CC606C9;
	Sat, 21 Nov 2026 12:35:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8BEE83A8
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 12:35:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 71F7040012
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 12:35:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NELW9aKLFUrU for <u-boot@lists.u-boot-project.org>;
 Sat, 21 Nov 2026 12:35:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 8F0A740070
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::335"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::335; helo=mail-wm1-x335.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=amarulasolutions.com
 header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google
 header.b=KSVuWHRk
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8F0A740070
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 12:35:19 +0000 (UTC)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4ba013938d7so16242245e9.2
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 04:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1795264517; x=1795869317;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=l/JrBhID4Buiq6eBE8F4EsCAeAZ7QVoclOXi2dBQNLM=;
 b=KSVuWHRk+oklVvcT5ImrQ7TxmFVmVq29jwQaOVwCYOzRO9JtLHTB5r9SU31B1/K6tL
 b6lJ/YRyo3d2BEIF/2Mvkl43r+MzZrLOi1hWTNou8ZlUM4Sz+BHdo4//LTpB8F0H23Yu
 oiPX2QtBZ7OPKrmpcnrNLZrlDkNvR4cRnrfi4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795264517; x=1795869317;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=l/JrBhID4Buiq6eBE8F4EsCAeAZ7QVoclOXi2dBQNLM=;
 b=aJAo94ewLWeLa5E7CC7gdJMGMB2X49+boNxwX2vq4gdHgeiujN+j+fSrPHiavIBRRS
 c+A44jyRMFIkN/QvyLAg5UJVtlO4/D7X0YiHWc252IHTVKHh003hM+h1BxsrO6oSkMS/
 4zHoqXElK4Y9P5S1ClmCxjjch+bZOdvmiCB4tn3oQzO9h2FSh913W30rX9+UgFDuQ//+
 7Msxv16STf76eXaAxWZ1L0B1UOuqcxRK+zdTW+0fPrl7R8az+cj+2n+nHGWceg3pLPe/
 +ACX3Cw7+WR7xqgWU828oiybE7i5MBBnVOITO4x3qO+yugr0UuJhvLJQfbYde+HtQbK9
 Q4Ag==
X-Gm-Message-State: APuU4Z84LnHXLKbPMJrB8yAi2wHAdz8Y1TCWKSeodgNYJCXcG7Y1mWUB
 eQ3awqvYXEe+DiTdYxF0b5orV7oRuZ9AOmWKDrxf6MhAM4h6WbU4S/mwNMneQ8hie5Z3J7udfO3
 PpX/s
X-Gm-Gg: AZFdTZfbkGuntSpQbvVhrtke/pkYSA1N4QkksftAuq3PAin+52HHuCaBM6KlxTk9+A6
 k4vOTRk6Hc7genMSsaCFEH2r2G1fUe7aGOHCEotYxJlCXIOw1Wy1WsGVu5+FKYI/qMZJBNtK80l
 Ob4hvL3JncqS2IfhV7F7uo63Ou5aP3sGNEsn+9jwZAi2skFkJaz1kWUXWnR23YjuXCzXlZ2idFZ
 xOqMCvhYD5XER/jTknkKPeq10VdiPQhNArhJpoyxyzj+FRcDfydBDE3jnx9UD89bZGthyzfEKA8
 zNJf2A3WBG9fIUooJR/z5ah/6myEf5jlpboTvGSkvJs+/xODpE7Urs3Av3mSWLfSvgYaF1WP0dV
 1M4DCCRj+9h4L0E0DzH8lH5hQchs1BaqtSACAifvpXoS8UMO9mdxBPcOQimP2I+PhSKSetLg92N
 pDyClr3F0os/4qEK8FPFh3wvQC/ioEM2dzWNTqgLdNhHKSyqjR1kFdNzHh815Hp8JeDbZjLOCvm
 c0oxn/TyLXJ/UDGYcCQYe8FrX8PMQQe70WYM/VM84p4cinH/pmaZSil6L9bj6Wu6p5MK6YxHWvd
 Q5wGj1Y6WhCIqJZjBkTXfiaS3oGJbwCIhYzanZk5hzidsi7l4qDQKTPugfzQbIjPTZZFmUR6krF
 6mqTo5IL0hSXL5I/Sujm7tdQGtp1jXSzPiKFJhjnlxnAIEeutiPiR5fmjzfhmRmRtMJN2pc5zo7
 59pYwGYY+10rzZCoHoUP0/J9YGzg==
X-Received: by 2002:a05:600c:3b8c:b0:4b7:6c16:7b43 with SMTP id
 5b1f17b1804b1-4bb8881d019mr132566395e9.10.1795264517323; 
 Sat, 21 Nov 2026 04:35:17 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab658e2d1bsm11720564f8f.8.2026.11.21.04.35.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Nov 2026 04:35:16 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Heiko Schocher <hs@nabladev.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 11/25] video: mxsfb: set the DE polarity from the display
 timings
Date: Sat, 21 Nov 2026 13:34:01 +0100
Message-ID: <20261121123451.2471185-12-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261121123451.2471185-1-dario.binacchi@amarulasolutions.com>
References: <20261121123451.2471185-1-dario.binacchi@amarulasolutions.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Michael Trimarchi <michael@amarulasolutions.com>

LCDIF_VDCTRL0_ENABLE_POL is always set, so the data enable signal is
active high even if the display timings don't ask for it, and the
DISPLAY_FLAGS_DE_HIGH check is pointless.

Set it only for DISPLAY_FLAGS_DE_HIGH, as Linux does for
DRM_BUS_FLAG_DE_HIGH. The in-tree boards using the LCDIF with display
timings all specify "de-active", so they are not affected.

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

Changes in v2:
- Add patch, split from "video: Update mxsfb video drivers for
  iMX8MM/iMX8MN display"

 drivers/video/mxsfb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/mxsfb.c b/drivers/video/mxsfb.c
index d7a6214e5a6f..bc082c334577 100644
--- a/drivers/video/mxsfb.c
+++ b/drivers/video/mxsfb.c
@@ -150,7 +150,7 @@ static void mxs_lcd_init(struct udevice *dev, u32 fb_addr,
 	writel((timings->vactive.typ << LCDIF_TRANSFER_COUNT_V_COUNT_OFFSET) |
 		timings->hactive.typ, &regs->hw_lcdif_transfer_count);
 
-	vdctrl0 = LCDIF_VDCTRL0_ENABLE_PRESENT | LCDIF_VDCTRL0_ENABLE_POL |
+	vdctrl0 = LCDIF_VDCTRL0_ENABLE_PRESENT |
 		  LCDIF_VDCTRL0_VSYNC_PERIOD_UNIT |
 		  LCDIF_VDCTRL0_VSYNC_PULSE_WIDTH_UNIT |
 		  timings->vsync_len.typ;
-- 
2.43.0

