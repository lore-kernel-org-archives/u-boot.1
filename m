Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADBCFC55165
	for <u-boot@archiver.kernel.org>; Fri, 31 Jul 2026 00:15:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E8ACB606BB;
	Fri, 31 Jul 2026 00:15:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ce-rsAhRNKLS; Fri, 31 Jul 2026 00:15:36 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2EB2560674
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785456936;
	bh=XLWSkw29IAzLEqM7eeHUhwQIzZAsc73sYZX50a+YY/c=;
	h=To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=JB3tjPvK6SP+XkGS5aIgkq+9bNTE3VX2wRQS6ig8GDDPibHpUUaSaJbmq4ccs0R2H
	 zHOm6yiIs1bD6BwI5dnzmKu5jwKoIb/VHSKcqe5xUi9COIiz989MC9j3foSlX5GjJE
	 e+FBbvvdRRP3388qeSyI28IdZpamxLAtmj6+tZ2OTapRyzGp2SAW1DA/PlnQDGgRuR
	 cuSDoaTQVlq+OrXGvIHtJViKshYdAQl4QITp7AgULucsBjwVdHtx2hr9NsC9FblGZ8
	 TgIN2PLoe3WlBXg1pvypFPOcnRBtUCgy5NT9zffcalvea+a72ifMa2FjrO0o+lISjz
	 UkbYnP//nLakg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2EB2560674;
	Fri, 31 Jul 2026 00:15:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 02EA826C
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 00:14:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DD6A8400D1
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 00:14:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id B45MqIODhxrk for <u-boot@lists.u-boot-project.org>;
 Fri, 31 Jul 2026 00:14:41 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.123;
 helo=smtp-relay-internal-1.canonical.com;
 envelope-from=aristo.chen@canonical.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 905AB4007B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 905AB4007B
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 905AB4007B
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 00:14:40 +0000 (UTC)
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id D40583F9BF
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 00:14:38 +0000 (UTC)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-848474825ffso294480b3a.0
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 17:14:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785456877; x=1786061677;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=XLWSkw29IAzLEqM7eeHUhwQIzZAsc73sYZX50a+YY/c=;
 b=ezfpdgXHwNnJ4laxkSMejP9nBtoImX6P4TdLg5j/TA/qnlQkg7XK3MUp89msJ8d450
 fkKrLx4AR2U9j85Mag4mXaxx2ajrtcom6aZDFi5dwCuacjm/NEL4XBfVq4XLfF90JT6M
 h9NfvYJ/H2NPcXjt54WQNUCXDlBYxV7Bb79Zp8V9nQFK/xTaqXVFM6aIbvopWnqPT0E6
 NlZkmHSmsL0syVuTLuph5ZMX0brR0it7YyB8Ez+jPoYccqrhaOH7Z+j5DSSCOt2tui5+
 NFIHDwsaSIEE+OWtFnI9alUUFjbtqPdprCMvCvjiS9CMzraNMznlwkPXcNbwcy31iEL/
 doLw==
X-Gm-Message-State: AOJu0Yx1TTeziBDrtk6XTJvWTSWZUB5WGzlqAP990X4IwXh1ReE8hnmb
 HwcTU9e82kUtSD5Trv/XuPHXr2d0WRsBFyKGnDvVX9UMP4R5ZEWmRjKLxHrcodugnhBbcEoFId3
 1NHCGYdKnhXDp163Thz+JQpUcSSoF/lBPZsucChpMJrBZIjFQr/t1qKVPUQ37P/owq8Sy0AmmuR
 VKeBf3lqMngg==
X-Gm-Gg: AR+sD11W853LX+z3j8ASZFw2/J2rqVjBXMrHci9g8NOms78mKSUOWIIzgW8qI/3T5JH
 xbaxIJa42aoj5YUI0bKEaCbiO5r40wXdP/02aAWlmzK2QbQNZlzGzjQYKorK53IFP2hu2RT0OJY
 4OSDDk36cNcBkzVnOa0tr+eB5Xh3SbUxUPMvOeTwMPuJgbuueEyvPDYTrx04Z+TTMjuf3YK2V/o
 UhIsJG8drZsfF6RmC9nN6fMB0xcCtiDlKBND7CGY5tOrvD9myGnPfj5HxMwQUq9XgnT+MxO37G8
 9i3jG7hiohWIsM32/Pz8CwFIuJSyfdRFFEuY5jndbeaPyWKhBQIHtdyaA1IiK1O3GKf0lqq68K7
 2IYHoz+JcyvJ7SJ81gzobIpje+EKipgFvg9NFsYvjZYHHjUmr/wr0f4X4o7VPBQRXCTr8Pw==
X-Received: by 2002:a05:6a00:1314:b0:848:7bcf:9a9a with SMTP id
 d2e1a72fcca58-84eca4b85b2mr1150783b3a.1.1785456877288; 
 Thu, 30 Jul 2026 17:14:37 -0700 (PDT)
X-Received: by 2002:a05:6a00:1314:b0:848:7bcf:9a9a with SMTP id
 d2e1a72fcca58-84eca4b85b2mr1150763b3a.1.1785456876843; 
 Thu, 30 Jul 2026 17:14:36 -0700 (PDT)
Received: from noble-uboot.tail872496.ts.net
 (124-218-37-86.cm.dynamic.apol.com.tw. [124.218.37.86])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84ea02f8461sm3695718b3a.28.2026.07.30.17.14.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 17:14:36 -0700 (PDT)
To: u-boot@lists.denx.de
Cc: u-boot@lists.u-boot-project.org, trini@konsulko.com, sjg@chromium.org,
 nm@ti.com, bb@ti.com, n-francis@ti.com, d-gole@ti.com, e@freeshell.de,
 jonas@kwiboo.se, Aristo Chen <aristo.chen@canonical.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH v4 1/7] binman: Fix typo for the test case name
Date: Fri, 31 Jul 2026 00:13:35 +0000
Message-ID: <20260731001347.35624-2-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260731001347.35624-1-aristo.chen@canonical.com>
References: <20260731001347.35624-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 31 Jul 2026 00:15:33 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=canonical.com; s=20251003; t=1785456878;
 bh=XLWSkw29IAzLEqM7eeHUhwQIzZAsc73sYZX50a+YY/c=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=ksX4qbtJmVQjDVthD7N1kitqdPj00OU/6cLflDXkYDPU0QgVkkOTA/bRvv38iMlC5
 pkjNLy79cICICEi1r78CYD/bMgBe8KyqY/AlVh7KPHCwo1pK1m1feUMsZL7KyZPNqj
 H4ET5T21crGdjreyu4GAqdCwz64TM29uSdEZxyYocpsMseuQ9ncf+6aR9NOyW3LZ3T
 nAW5oQnPiCgFeYeRavF3cZwe5ZIbXZ3P50dVNM51/m76ACXst8clppY6K1E0Vs/BNW
 Xl6LTlVc9pUIg46sMxNxJ90lJ5MAWS8v5VtSjWDZZULIW7h0NkZ2N3GC2yT7WvPYTQ
 Cj/UluxvL4cN4Yq1JuWlh/313P/OeszlONYYUnori/iKeik2kSrORMnmN9iEHOj+Vk
 KcfYjm7YSnyiGcUq8y76FEKLwhp9z9XwwKF/Lbh19AfHkTkIsXVshe76f3nbNRS7qG
 4bAHwvQn53P63xKk1jdmb79divzS3ESuaID0eEy2UVLWXMAuR+xiDUIbx9WIXfnLxi
 CeyoReKEkJM/wURg+jUn+0B+s7lOnneBzzXpKhofW0M+zfJzVL2tIx/WHJrfaqm2UF
 18PwyeJMXbl3jgvdys0BKhLK2P9exxmGRDYpuHsBTADExjcNz9vLMykfHqP+6d4ZmQ
 ltmj2gkf8NQFUV2JokSDOEqE=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=canonical.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=ksX4qbtJ
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
From: Aristo Chen via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Aristo Chen <aristo.chen@canonical.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Fix typo from `Singature` to `Signature`

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
Reviewed-by: Dhruva Gole <d-gole@ti.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 tools/binman/ftest.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index 9553eb6b736..b5e56707c83 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -8466,7 +8466,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
             'Node \'/binman/fit\': multiple key paths found',
             str(e.exception))
 
-    def testFitSignNoSingatureNodes(self):
+    def testFitSignNoSignatureNodes(self):
         """Test that fit,sign doens't raise error if no signature nodes found"""
         if not elf.ELF_TOOLS:
             self.skipTest('Python elftools not available')
-- 
2.43.0

