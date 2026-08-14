Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62295C5B572
	for <u-boot@archiver.kernel.org>; Fri, 14 Aug 2026 11:21:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 23DB86060A;
	Fri, 14 Aug 2026 11:21:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rzZsO1f7Orqh; Fri, 14 Aug 2026 11:21:38 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 72EBE607CC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786706498;
	bh=1xM1/XSksA9Wt/UDiVtImxLy5XOXfaBBtsy+khGzzK0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wFqLsjPA4+33qyiGPBhqWMwTqEOHU1ERIM+b8mrJDFWfZ9tpgOVuEjwvfi1Juczgp
	 pXVPASdBJDmYjPwljeyXtkTAyYLX1hO5RfZtbOy8+HUIDDpVu7Tu94gAT11782yXBY
	 qd7M8eG6Nvwjy1fwNDKaoZI0adzXgiNBc+TZ+jX3ffpsMFckuD8+D6R2fHf/Pswt7r
	 hMqzBmDqTrrGWm3/Aid6BmmL2uThFrMWxfcbRbqkKDSxqHOsWiZTpZ/me2J8h3BUam
	 TuuNuxhZsGp4SsNTYwQ3tMPN/0YSMNRHn+9yIiprZwKhUwA3rvan+pemk+A+IU2nxV
	 mgK6t863AQ8pg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 72EBE607CC;
	Fri, 14 Aug 2026 11:21:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id EAFBA139D
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 11:21:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D805D6060A
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 11:21:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oqs9X1fAI2QX for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 11:21:29 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::333; helo=mail-wm1-x333.google.com;
 envelope-from=fra.schnyder@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 05A15607A0
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 05A15607A0
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=D5K7H1kC
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 05A15607A0
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 11:21:28 +0000 (UTC)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-49556f97a9dso6513565e9.1
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 04:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786706487; x=1787311287;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1xM1/XSksA9Wt/UDiVtImxLy5XOXfaBBtsy+khGzzK0=;
 b=D5K7H1kC83dDBQoufs8bB89fpnCdXS6sXhBadxaRAS19mcu7pk/e5+f6Z+lKgVq7je
 zLIGf420qxDHE5nOV9uWVyngDRfvP57e9xn/lW3fHuES2ezpsQjV4Fzk7Iu3Hwm3VanP
 EHqBOkM8WMjzXQ1o5tIqKSewVK274IFSUeyV4Kp9rgTh8c/wlWOr8DWKdRmzLl3MaaTs
 dcBcflSm1sFTaKNlOjUtO+6LxYH6+4lAEpu7dgCISlmvvsAs/+AaJ0LwJxBH8M38JPCL
 VKhYMFEd1Qd8gHTbbBi5aGFC4rHfNnfqYBmjc2QIV2NhoURQEYxYhLYxidfEDLyEb+Ic
 0nGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786706487; x=1787311287;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1xM1/XSksA9Wt/UDiVtImxLy5XOXfaBBtsy+khGzzK0=;
 b=EOLbaehO7mKdY967H0bpipJd2K9H3i0nQ5SvCjXSSlWlYjFbfPwSxLBkz8YszlllEx
 kR+rSpXnfyRy7nKZq9CZtr84Iy91v1E5b0nSM7Dtd4+WByzzAKSiu+hEKgeNrngipx+K
 +2Qm9xKYozXMc7bID+hZFtsgZ5n4rm90ueGDuNoFx0D6LRV56KScVx+jDqkC2gDeBWhK
 Iw5niKkC9kS79d6ga8GLOOB+IENdBTT9TG/kJDFUP6ZNQ9oQf3tw52QNZ6GTv0Ybvp5F
 MYhtwR6K4r6s2zFIxisVdo/vyRjDDT0uaK/Jzjolb0qjr7qCsd2sDh15eJ4k8GOgKzbk
 pPFw==
X-Gm-Message-State: AOJu0Yy86Psnt2b8UKV8fiex6hT91l+Kw/UlZlOfWMUAuqM9IY4LL1NW
 HLN+vqbusFsxz/y6K9e46Y1gB+BcsDXRF0Lgzh+bhNFJWRZmSpR7Ejaw
X-Gm-Gg: AR+sD12YJf3jO0JpcXPOUlZUBL52tvwlbBel+co9pthI5GTDu86/xKs7G2tWVANY6CE
 Qaoyj5H9+bnKt3jwsFiODi+BGhZPsqlX1sg0tDEZ6WRAT9NGQpsNUkrL0VD/d06d3I/0sKRiy+s
 o+45wHRbaTGGs9h/WqWk6SmcNm3+XQZ5HCTLvP97qYB0kyLc7AalfLUBEw0i89Dd4MMY1GbZ4qS
 Hx6sFsedG8T2BHeNC36opjYJRGQL/YXKZc72k5DJgN29LVZLASnmYNkp5NxccAqSvLZigRhTsXS
 umfjYYQnrFuNWXHErp9u2iYGonpShGay0CGIGedTFnac8X88tGDzUH+eMwhJxEsfAojFP/J/rft
 /+wtlHi+jAHEm8ClZqcwE41BYDLa9Dl9g+2zQqVDto6Wq/oueCvBnY99cy45IPizW70IbYbDl55
 BuQifSqy0EM+TOmYhMeJGXNv2I6fH/6196A2H/iOLkNSmf0JJSvpxL8c6zdmK2ra5CHds5FXYsN
 PwnfZ0UVsKkWyx4g1tArXquixytWTfX1xpGwX61n/A79y1EHDGn451qSwKm8kkby+zwS7wg1qKP
 dLJ8OFEWfXZBUjGfHWAG857iP7tq8RosYXbOgXQC+aaJDz9/
X-Received: by 2002:a05:600c:4744:b0:499:7900:f2ac with SMTP id
 5b1f17b1804b1-499879aafeamr59469505e9.15.1786706486987; 
 Fri, 14 Aug 2026 04:21:26 -0700 (PDT)
Received: from [127.0.1.1]
 (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49988b2a509sm41692355e9.14.2026.08.14.04.21.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 04:21:26 -0700 (PDT)
From: Franz Schnyder <fra.schnyder@gmail.com>
Date: Fri, 14 Aug 2026 13:21:22 +0200
Subject: [PATCH 7/8] toradex: tdx-cfg-block: Remove validation against PID
 table
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-get-rid-pid4-table-v1-7-b8605ac094d0@toradex.com>
References: <20260814-get-rid-pid4-table-v1-0-b8605ac094d0@toradex.com>
In-Reply-To: <20260814-get-rid-pid4-table-v1-0-b8605ac094d0@toradex.com>
To: u-boot@lists.u-boot-project.org, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@gmail.com>, 
 Franz Schnyder <franz.schnyder@toradex.com>
X-Mailer: b4 0.15.2
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

From: Franz Schnyder <franz.schnyder@toradex.com>

As no new entries will be made to the Toradex product ID table,
interactive config block creating should no longer depend on that table
to accept a module ID.

Remove the interactive lookup against the product ID table and prompt
directly for the module PID4 instead. Only check that the entered module
ID does not exceed four digits.

Signed-off-by: Franz Schnyder <franz.schnyder@toradex.com>
---
 board/toradex/common/tdx-cfg-block.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/board/toradex/common/tdx-cfg-block.c b/board/toradex/common/tdx-cfg-block.c
index 0b1798dc812..9ddb944fc42 100644
--- a/board/toradex/common/tdx-cfg-block.c
+++ b/board/toradex/common/tdx-cfg-block.c
@@ -512,24 +512,16 @@ static int get_cfgblock_interactive(void)
 	int len = 0;
 	int ret = 0;
 	unsigned int prodid;
-	int i, idx;
 
-	printf("Enabled modules:\n");
-	for (i = 0; i < ARRAY_SIZE(toradex_modules); i++) {
-		if (toradex_modules[i].is_enabled)
-			printf(" %04d %s\n", toradex_modules[i].pid4,
-			       toradex_modules[i].name);
-	}
-
-	snprintf(message, sizeof(message), "Enter the module ID: ");
+	snprintf(message, sizeof(message), "Enter the module PID4: ");
 	len = cli_readline(message);
 
-	prodid = dectoul(console_buffer, NULL);
-	idx = get_toradex_modules_idx(prodid);
-	if (!toradex_modules[idx].pid4 || !toradex_modules[idx].is_enabled) {
-		printf("Parsing module id failed\n");
-		return -1;
+	if (len > 4) {
+		printf("Invalid module PID4. Too many digits\n");
+		return -EINVAL;
 	}
+
+	prodid = dectoul(console_buffer, NULL);
 	tdx_hw_tag.prodid = prodid;
 
 	len = 0;

-- 
2.43.0

