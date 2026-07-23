Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7799C531F7
	for <u-boot@archiver.kernel.org>; Thu, 23 Jul 2026 15:14:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DCEF860A93;
	Thu, 23 Jul 2026 15:14:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VcVLpB--TyR4; Thu, 23 Jul 2026 15:14:09 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A2DD960A83
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784819648;
	bh=woijcUiGGC0VAzRJxPIm9/dR9eOTLkQZJanbZM/EPYQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jxHJ/2WMoJWPG36lA5NsXG9LokZRiz1BtV3mJG/UyakpNFI4cmWRw3l2hhXAI21PH
	 zDiolZeoFI1glCkmNNJifzc5SJZ2Bs+QQjVqvq4CGubokgVHYZSr/gFJNrxlwAwMTW
	 PUr6vZ7x/iWb4By4eBv0ZGOGetrTEksoZV9VRY5P4/yGXalzibFv6znLjAjvABFAZQ
	 qFauW8X7C9lC74ao5pXVBTUaUNpaKP27ATc2ha8zl8QUZsuBxTF6XOs8/WoJPG3KVs
	 m/dCaAfavnCK0QHbvhY67D+aQLNAupU0Y0Zj7eLbGrvQnZjhUEc5ENcntOiMhu+y4P
	 3cwMVG1k3PTsg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A2DD960A83;
	Thu, 23 Jul 2026 15:14:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id E1FAF3B0
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 13:30:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C75C0608FB
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 13:30:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CWW1aspFseWg for <u-boot@lists.u-boot-project.org>;
 Thu, 23 Jul 2026 13:30:40 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::335; helo=mail-wm1-x335.google.com;
 envelope-from=tan.siewert@9elements.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org CC2BB608F1
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CC2BB608F1
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CC2BB608F1
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 13:30:39 +0000 (UTC)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-49554ebb87dso7512285e9.3
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 06:30:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784813438; x=1785418238;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=woijcUiGGC0VAzRJxPIm9/dR9eOTLkQZJanbZM/EPYQ=;
 b=WbyB+TRM1AIkCkwPdAybnOfUzn+cT/Z9nWbGd/4CyDsS1bnCwLJJYQSn4W04WvHh/l
 o1vil3Lb/yyMt9wg9siuqoyr6ZEvTMtonwA5lhs+8wAJitgJ8a5fLMnaCcq4EtlcIsZT
 F75Lxvig4THIpdaUtCK1O/osOVxP2ccFr996vY7SBUmiJ1creMGcNFavgCCAV0oEt5fM
 NaeeS7SGyzz75K/uEa/MYhE/BTd2wpQR8nv2wbSfcYtld3DzFG3NaM8S8qTI06JN9kJt
 TBZGwfRZQDErQEBhPl0nqnRzGODgnOrTcgxJ36au7e0V+9Hf7ZcVXI8BwJwUk5F8KFMP
 NSHA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp1EbbAtk2aEYNBYKvPh281N7ileu4b1pmurPjKKGOwZC8A0R/PS368cic/AOw1UQ9EnPipyCI=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yxf6pFRkaeQRY53GJ1Igb/OsGzKLEDIdRpPyYpp72bEzkGFn2fu
 A3yYZzNVEfGpC2SSkzc+Nm9uQPGU/VFcZ+oak8mVGbx7V8EIMGcgeVuUbAXEi/7y4OI=
X-Gm-Gg: AR+sD10AWdr5h2W6CCMbtRiHAl9SL8PpFff55HeSy9bYxN93bqbKRcRGwEtn0m5SHWg
 2rEWFfykJjQgXjoN7kmyUMz4MgaSlL+VaWfnbinKLPdYwNwz3pWCaKG0P7QwHE7l6iB0Bia+/dw
 xa4ucrwRUCvDGIrTgk/Xf1EnFRe1rkzx2pTcNTur1ZEfQD5eOrXAm3ka/lQlU7Nd2ezkGFWTDUH
 pUlNAzcqPs220BuBYwTWkI66+H9CbJefDpkXyoiWq0pXH5tlnDPiVfc151wNYqnbVgJb5lb/YkB
 k7yi70K7HbJJHz/+95mQ/DkOb1VXNXvVF74R21HDFju1nTHmBqqgIY/CS2jMNXf8Fi1lbN+swkk
 +N2Ijpt73c9kZ3C7IfskqACs84Z8vw1TtlSYWHVVAS1i6SH+KHWtvRkEMEjwx3lJlv0AvBax7qO
 zMqRzyMBniqaa44w==
X-Received: by 2002:a05:600c:4f82:b0:493:f0f5:f2d7 with SMTP id
 5b1f17b1804b1-49573cbe8c8mr32262815e9.7.1784813437813; 
 Thu, 23 Jul 2026 06:30:37 -0700 (PDT)
Received: from [10.12.249.172] ([2a01:599:841:3b94:b6c8:2fa:40db:8ecf])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956b043727sm97075405e9.4.2026.07.23.06.30.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 06:30:37 -0700 (PDT)
From: Tan Siewert <tan.siewert@9elements.com>
Date: Thu, 23 Jul 2026 15:30:07 +0200
Subject: [PATCH 6/8] board: hpe: gxp: add boardinfo support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260723-9e-gxp-v1-6-f86e5cea239f@9elements.com>
References: <20260723-9e-gxp-v1-0-f86e5cea239f@9elements.com>
In-Reply-To: <20260723-9e-gxp-v1-0-f86e5cea239f@9elements.com>
To: u-boot@lists.denx.de, Jean-Marie Verdun <verdun@hpe.com>, 
 Nick Hawkins <nick.hawkins@hpe.com>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Marcello Sylvester Bauer <marcello.bauer@9elements.com>, 
 Tan Siewert <tan.siewert@9elements.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784813429; l=1266;
 i=tan.siewert@9elements.com; s=20260527; h=from:subject:message-id;
 bh=dWaWGPoiE1DSRurtl4EOcQPAFYLqFHYlDo9z//9MB7Y=;
 b=3MyLu4Os1szC84aZvgIhrhdSk1o1G7GFlBzjJLyY0M9it7UrMjzlCDaI81h7rYSv6QUqBIAy9
 DVX3IZ9UYNaByqH351ARN4LwNHtk54Ms78asQ5C7kjDbIEmcZdTgPwh
X-Developer-Key: i=tan.siewert@9elements.com; a=ed25519;
 pk=ORQd/zQf+LsAvJGXP1CjQwVO6t6iEOGq/eGUsmRVTG4=
X-Mailman-Approved-At: Thu, 23 Jul 2026 15:13:57 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1784813438; x=1785418238;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=woijcUiGGC0VAzRJxPIm9/dR9eOTLkQZJanbZM/EPYQ=;
 b=DxPVPXtlCNB7HAgnMa2JeJmzcBrF63pYBkg2gu38Rd8ddmoTPnNJ6SBGTFxhlEGgUX
 RyeI0GB8L08VpUkLE39281U4WmS7Vc8XikJyeouYRoFTCKdYRjYrmTpUJjSsSBtPWtUR
 kr/ZcNiEBsPouUwZA9pamLEflQa/mhxCOjD5v/Ruudb3csddjb/xu+aZDgQr5ipthMKn
 76y57lPXO8w8UzRRQMPnQ6hFmJpvbhiHD04DFpSqp0OfVU/b0faYFqkraPM0ipTcBqsw
 0XFjP7OaXfLnLMDR2oVXQqp6FTLdkGqLbLqDrK9txIh6JgxeHNLEeFXgr0+/bDd52wqh
 KTAg==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=9elements.com header.i=@9elements.com
 header.a=rsa-sha256 header.s=google header.b=DxPVPXtl
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

From: Marcello Sylvester Bauer <marcello.bauer@9elements.com>

Add support to display server identification during boot.

Signed-off-by: Marcello Sylvester Bauer <marcello.bauer@9elements.com>
Signed-off-by: Tan Siewert <tan.siewert@9elements.com>
---
 board/hpe/gxp/gxp_board.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/board/hpe/gxp/gxp_board.c b/board/hpe/gxp/gxp_board.c
index b37725761af..4a51ff55797 100644
--- a/board/hpe/gxp/gxp_board.c
+++ b/board/hpe/gxp/gxp_board.c
@@ -30,6 +30,35 @@ static u16 gxp_get_server_id(void)
 	return FIELD_GET(GXP_XREG_SERVER_ID, readl(GXP_XREG_BASE));
 }
 
+int checkboard(void)
+{
+	struct udevice *dev;
+	char str[64];
+	u16 server_id;
+	int ret;
+
+	server_id = gxp_get_server_id();
+	printf("Server ID: 0x%04x\n", server_id);
+
+	ret = sysinfo_get(&dev);
+	if (ret)
+		return 0;
+
+	ret = sysinfo_detect(dev);
+	if (ret)
+		return 0;
+
+	ret = sysinfo_get_str(dev, SYSID_SM_SYSTEM_SERIAL, sizeof(str), str);
+	if (!ret)
+		printf("Serial Number: %s\n", str);
+
+	ret = sysinfo_get_str(dev, SYSID_SM_BASEBOARD_PRODUCT, sizeof(str), str);
+	if (!ret)
+		printf("Part Number: %s\n", str);
+
+	return 0;
+}
+
 int board_fit_config_name_match(const char *name)
 {
 	char expected[16];

-- 
2.53.0

