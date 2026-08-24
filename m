Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1568C5DF81
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 08:44:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 987EA605F9;
	Mon, 24 Aug 2026 08:44:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DOT1eBNHvX67; Mon, 24 Aug 2026 08:44:32 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787561072;
	bh=ERLH2L60kqjnlEkHkZzl/fK03kBw4hO+y4ApVe3e/6Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AY0HvcM++PgjswiPfGuvRmFEmAC/K8iyUiT8to/42O0isqIP8Xe5ZywIr9bdPFKgU
	 d+0iKrO7eQp7QUAFP5SUy93uxOCwU2X4PrVPnKt3X0h3UnkEVoT8CJfAeMs0DH8R5a
	 IW3RrPRuNtLS/P2pMq+npW1w3mdQBK79G1wEJaQwlHv2OXpvo285O+/7bsaE6P31Em
	 QKZFIzl6PoDt9BDJauqjPfMmGczRsgj4tZ3D/4tmE1HUiBdb7M7bK7ktInWI1XPzX8
	 uh9JmhbSsKv5Y02MvM4zU7EcArTmarrHJBRn02BN11zTVTAnJ7HNeDafsh98T+/wjY
	 tV45qmSVNj3zw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6D50F60622;
	Mon, 24 Aug 2026 08:44:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 688C83AD
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:44:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4EC4E80E03
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:44:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QNGQWovQaMG2 for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 08:44:29 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::333; helo=mail-wm1-x333.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=aEy9kGHn
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6D71280E01
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:44:28 +0000 (UTC)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4980fe6b3beso27263985e9.0
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 01:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1787561067; x=1788165867;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ERLH2L60kqjnlEkHkZzl/fK03kBw4hO+y4ApVe3e/6Y=;
 b=aEy9kGHndyEgG2vxdl3fgcUF2EJ8OE8fGDqiL7m7AFXDbr91395mkFEYc50kXa2gra
 iUsLHRjaPk328j1xKucRMiDOLOdWVftDJyTTheyV71vcmqBDnt3DmNS7FdivvAOWHBHv
 n3q7vDGhBYT57f27wslGNkuorlapF4vK8F5dwkkllB1f1lf36BLycrM/bNImv3xXe4nM
 g1voyvU+WI/bQnPj2hEe68mfHsYetuE6Nzat15kw26ESuP/2JRniLWt67HZAxByVPeHJ
 1rxrpXKHfg99/mYfMbmgPe8Aglqm4LACm6Wu43XlcvJJOhjL0I8yY9YH1NG/Urh8EJxK
 KpOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787561067; x=1788165867;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ERLH2L60kqjnlEkHkZzl/fK03kBw4hO+y4ApVe3e/6Y=;
 b=HKI5663M1pwUHHZ43SCYyaE65AQ7hpgL+fneiW10NAAYAZNJgwWXY3+ov4hgwI1MDN
 GQAM+HEiveOk5xjPpmb+/PSK9AlDNBXusQQo6SBbylhbiES/vZoO/qYUj/4D/TQii840
 FtgxbOpAomy2ckh3+o/yNHpgyQDhVJhghdoHiCChNewt3wGiRp2b7RzFzEHrnAogW+fG
 dY1hjqKtqSirulZSmCFrDTT3au8KLEPyxjOjjpykAhj/DZ0s5O8xICCDSrNRHAhyWFUm
 uCE0+O9soWrI/bB3LDQ53FiFdgKVO4TkVjAlOV0psSz1Zf/RJ1GYAeP8R3DEw1wfyjev
 8lLg==
X-Gm-Message-State: AFuF++ng2uThY44XU3VmVMNFJXWBn2EyxCr7aTcFSf0pRFQywjU2GioV
 zRW6sqrM/oLiIj6knCi7FJW2RI4PAr5sfohEeetdgxlzhhe7k9VK0SPPdDifJp0txcY=
X-Gm-Gg: AR+sD13Uq3Q/qjtqpUNjC858dYdC41LiJ+KwGM2sWqBWZ7+QgiL67PqtW7mch2J4Pbi
 lSMPURaYa/xoyWrZeO+W2Mp0ArQXFHcCgWN78hQKSAKzS4WcBOER9JgrZl+Ri7xkB2EdrU9Fqfm
 vrzUjm6x3TQGDdPBE81c0Ys5+0Um9TkjNJS/CV293T79yfxM9YI7eVrnYV5bjboDrZP4QO9fYHK
 Ppdrk49ZQ3DU1KCI49tQqW6YL7C2y/jH/030Cwn3K25ltGawCuPbBjopU0qkLMbbqsV0V1TXUeO
 L+JAsRi1IKbTEomEKGVy5veMlGEB3lkUyfnBjNMw7u1SnKsa+8rTOmCsRM1jeoGSFAUEEKZ4khU
 eY/SIBSMjOp6UQt6QvsO4geoew6/l7uSZNjbZbePyTptFwWAehpHhX7RgzH3luqfDPVy08G754C
 QHqzvOE4RFa4BWGkjVz7pSWTqg2oppQQMGqv52W6FbZUzx7CiSL0BovG/iQs8J97CVssBLQA7Ba
 CyDb1St+043G5hcs9DxL2FzV3mDT2f7D5bKsJfXfYOj0xtNqPNPMbmyprodZxFcfnOy4gFKOUy+
 NgIBBOfs66WR2iErLpVFVYV/40v9deZXV/dsUljL23Z3dA==
X-Received: by 2002:a05:600c:350f:b0:495:5d6d:9cc1 with SMTP id
 5b1f17b1804b1-499b90be53bmr201939245e9.0.1787561066949; 
 Mon, 24 Aug 2026 01:44:26 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499c35a1aeasm79788475e9.12.2026.08.24.01.44.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 01:44:26 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Mon, 24 Aug 2026 10:44:18 +0200
Subject: [PATCH v2 3/3] initcall: initcall_evt: display error code on error
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260824-improve-logging-on-missing-uclass-v2-3-4bee2cdff72b@baylibre.com>
References: <20260824-improve-logging-on-missing-uclass-v2-0-4bee2cdff72b@baylibre.com>
In-Reply-To: <20260824-improve-logging-on-missing-uclass-v2-0-4bee2cdff72b@baylibre.com>
To: u-boot@lists.u-boot-project.org
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>, dlechner@baylibre.com
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

Currently when an initcall/initcall_evt fails the error code is not
displayed. Display it, along with the corresponding error string if
ERRNO_STR is enabled.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 include/initcall.h | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/include/initcall.h b/include/initcall.h
index 220a55ad84d..12e5235f506 100644
--- a/include/initcall.h
+++ b/include/initcall.h
@@ -14,18 +14,20 @@ _Static_assert(EVT_COUNT < 256, "Can only support 256 event types with 8 bits");
 
 #define INITCALL(_call) \
 	do { \
-		if (_call()) { \
-			printf("%s(): initcall %s() failed\n", __func__, \
-			       #_call); \
+		int _ret = _call(); \
+		if (_ret) { \
+			printf("%s(): initcall %s() failed (err=%dE)\n", \
+			       __func__, #_call, _ret); \
 			hang(); \
 		} \
 	} while (0)
 
 #define INITCALL_EVT(_evt) \
 	do { \
-		if (event_notify_null(_evt)) { \
-			printf("%s(): event %d/%s failed\n", __func__, _evt, \
-			       event_type_name(_evt)) ; \
+		int _ret = event_notify_null(_evt); \
+		if (_ret) { \
+			printf("%s(): event %d/%s failed (err=%dE)\n", \
+			       __func__, _evt, event_type_name(_evt), _ret); \
 			hang(); \
 		} \
 	} while (0)

-- 
2.54.0

