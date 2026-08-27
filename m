Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA377C61DC4
	for <u-boot@archiver.kernel.org>; Thu, 27 Aug 2026 14:24:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5217440742;
	Thu, 27 Aug 2026 14:24:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id x_zdqTZqwgTs; Thu, 27 Aug 2026 14:24:27 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787840667;
	bh=2fHA9bPYM7tbZfA24HvC7UFlHp3+AZYr4ct/oC5sYQ4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ieYYzw/CVQAmSzLjHNbJDIlLZn0Z0HPUksHuoXu/Do5OrUhPAnV2gsGQhVpu8Nvf/
	 Fh5TJmjmvEg3oal4u4+1GkeasX+HH4pkusDW/1jhU5n3C+BdT9w5EMSAaQXJ8qtNjL
	 fDp+qUGNkyNuAYHMsJ6R8k209cfkKLEjS1caOq88rkAZjHA8WMBk4E1/haKvS57YYc
	 Hxx7Sz423zvN/MuJG4rOl3ro3X4phNejG+jppsrLrSKqn5S0DffK+fLqS/653e4JT/
	 CMx5sFSulftk3WwVqyJ6Sv6228CK79Mf96MCUoHJ9BDvF40bVoevxB12t/tzjVas8d
	 VYqE2kj+XKTng==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7D1F34073A;
	Thu, 27 Aug 2026 14:24:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5F2ED3A4
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 14:24:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 51178607A0
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 14:24:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id M2dbBTTerehm for <u-boot@lists.u-boot-project.org>;
 Thu, 27 Aug 2026 14:24:22 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42d; helo=mail-wr1-x42d.google.com;
 envelope-from=msp@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=Za3z2KNs
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5F22660781
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 14:24:21 +0000 (UTC)
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-482dd6ee390so2206973f8f.3
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 07:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1787840660; x=1788445460;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2fHA9bPYM7tbZfA24HvC7UFlHp3+AZYr4ct/oC5sYQ4=;
 b=Za3z2KNsAI1YOnFJaIpLv/I0NHlch2Du+xWFLsEd4J3Fe1mXDSk49zeH/6ajUrsPtr
 3X+uSPeSMBp60j1dGL37wJjBgYmiObuFRWk92BVjj9psaE6iWUX/I2zjO7UEaV2ImKHo
 cP5lgOXzS5xRhgCb96EcxREsqN5Ii0Ig6cqEOTCUcXKQ+KhSpicTlV0kuJLnFqOdtqLH
 xCuAzdGVQ18SZhyoX220upQa8EB/1yGYAAiPqBdmgmHdbYnU6xYx4++Sp2Pv/WiiQYbL
 M+GhhJbnPgA9+AMfIHT6hiLkDSYVGlgBEldM0Lgz6Q1xBjEZh1JkqLTgzD4GYLvsXmcI
 i9Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787840660; x=1788445460;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2fHA9bPYM7tbZfA24HvC7UFlHp3+AZYr4ct/oC5sYQ4=;
 b=gSZFqyu75HuHgTIL09X7E1BlafotkPoI4mgRKWKceP9xBDrJl8m2Uu8NQ+bbLEdO/Z
 ICOYJCPeHEWu51BSXDDl5IZx/F4GZrMoin2/kEDGH5b30yfX7c3YPVczkVA0+KsfidXH
 bZWl6Nw8JqY/VO5onPUYyPYXUorfMnOnkd3m8B4MCwfEwb5m0J793ikGUHGz5qRWS/N3
 AMJEZFHl/K8yzxEJ7qy6iauUldqfEt7hiL8ktnLoT1CEjbZee46s6CKJW2l1u4rNwj9B
 Ga3eLX7f5M/so0p75pLuI03SvbCqgcgb1LF55+te2yilrvTJBUUZMB04zaCBNHZjtSH5
 4aMg==
X-Gm-Message-State: AFuF++miu9AFt6buN9IybnLMiKAD1ZvzwpQRpQ6C5hYmeee+UF5ggoFr
 0XqIdSs+APi8CDW+a2bdCqaye70lISmOUEeG97bVnIPu/bnD5LaDXv4xgob4XO/DSxLZugVFlIK
 gEWhK
X-Gm-Gg: AR+sD11tjN2dFwFbbTy5D/iT7zZzt+UXypgyWW5hpXEYTAvFZ4BvwYNrqFZx8DTHQ5b
 vPtV5xy3o2SI3YZtFwyDMKKrlQavMqIfnOhYhiJOttVu6HNSVbC/kLA6FkH3/Fivr7rziHFl189
 eoNgGDGpPF9XcVfhGTlzURh2haAb+YgliFc9uZ2JoPA7SS/1948TQXU2sd4Hoe7EVIpZfDelHAQ
 D6DxFLO2vFu+7/7MvtPk+0sLvonOvueUJz/MVH4uO5T46Y5qxMrdHzH5LYGONVwtbzUEThDwLfh
 pdxKWuY7jlu3Q0USFX/xtShqPapP2MrDF5G3gwbZV+p9E4smVIu7ud39I4HdyshAQLKu4nTKtIE
 O+khK9DWGTmzCj9r2SxqI+P9gW5jwd2QbLOG4dQbbcfo3QWIeIrqjxTYsPc+f0PjD0YQ6dJ1VVf
 2vRLoLqH3+Q3RK9zO+Zjf22QMJsi4sB8bzmCAe0urIzk1OtucrcJ/x+NT3fQ==
X-Received: by 2002:adf:e009:0:20b0:482:f653:3963 with SMTP id
 ffacd0b85a97d-482f6533ademr222310f8f.19.1787840660091; 
 Thu, 27 Aug 2026 07:24:20 -0700 (PDT)
Received: from localhost ([2001:4090:a244:80d4:4373:6c2f:4372:b8ac])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482e28f25d4sm9204980f8f.30.2026.08.27.07.24.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 07:24:19 -0700 (PDT)
From: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Date: Thu, 27 Aug 2026 16:23:28 +0200
Subject: [PATCH 2/3] bus: ti-sysc: Simplify with clk_get_by_name_optional
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260827-v2026-10-next-topic-am45-ofupstream-ti-sysc-v1-2-e2c43cecc71e@baylibre.com>
References: <20260827-v2026-10-next-topic-am45-ofupstream-ti-sysc-v1-0-e2c43cecc71e@baylibre.com>
In-Reply-To: <20260827-v2026-10-next-topic-am45-ofupstream-ti-sysc-v1-0-e2c43cecc71e@baylibre.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1300; i=msp@baylibre.com;
 h=from:subject:message-id; bh=hg/thNxW0w9wDcDwHFL2vghyEXDDWQ1UC18rCKcdCV0=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhqwJHk17BApaBa7pfpTUqpWv0fo85cL1GN+8VcxdIRs6m
 PYvPbioo5SFQYyLQVZMkaUzMTTtv/zOY8mLlm2GmcPKBDKEgYtTACYSzsHIMOW01c3551jvht0/
 19XFkuukUxzK4hh+I3VayqWrfp7GUxkZ5jm/+5r++8Wy8LdWmn+Luxc29K3o9+preZiwVeDG9rB
 PbAA=
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
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

clk_get_by_name_optional already checks for -ENODATA and -ENOENT. So use
that instead of clk_get_by_name(). clk_get_by_name_optional() leaves
clk->dev as NULL if it doesn't exist, so it is safe to run any other
operations on that.

Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
---
 drivers/bus/ti-sysc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
index d0395893519c..3c4ae585704e 100644
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -53,9 +53,9 @@ static int ti_sysc_get_one_clock(struct udevice *dev, enum ti_sysc_clocks index)
 
 	name = clock_names[index];
 
-	err = clk_get_by_name(dev, name, &priv->clocks[index]);
+	err = clk_get_by_name_optional(dev, name, &priv->clocks[index]);
 	if (err) {
-		if (err == -ENODATA || err == -ENOSYS)
+		if (err == -ENOSYS)
 			return 0;
 
 		dev_err(dev, "failed to get %s clock\n", name);
@@ -86,10 +86,10 @@ static int ti_sysc_get_clocks(struct udevice *dev)
 
 	for (i = 0; i < TI_SYSC_MAX_CLOCKS; i++) {
 		err = ti_sysc_get_one_clock(dev, i);
-		if (!err)
-			priv->clocks_count++;
-		else if (err != -ENOENT)
+		if (err)
 			return err;
+
+		priv->clocks_count++;
 	}
 
 	return 0;

-- 
2.55.0

