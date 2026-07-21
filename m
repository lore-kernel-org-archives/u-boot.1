Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C094C44532
	for <u-boot@archiver.kernel.org>; Tue, 21 Jul 2026 15:55:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BF447607DE;
	Tue, 21 Jul 2026 15:55:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BxOsb9T53wxR; Tue, 21 Jul 2026 15:55:44 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0D0C860853
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784649344;
	bh=4G6UIxie3WxRhMZ8eXRtv3eVjfrpHhKDu7SIDWN3VU4=;
	h=To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=oYLRk/mNU3jRThQNiBSFDxZRH8HKuJ3euzRNKvQkA0nQcMUeRG3sqFeppMt1NZkh/
	 sdZSDit3i+kA4OxJ7pwEAn4yGg4KBZjXUvb7tjNmGsuhQWPmOKGeesz8kxqhL3rOoK
	 cpbbzBNthtg+wA3L/w25bWINbo0x/M8+IEjPNn5RY6MkzLbhiuM1mWtTs49NutmG9e
	 41Dc6F8m8yqt6b8qTlqxEl+yDGhrSnFJiwbK5WXDuhbqUkCuqiaz3y8E7++bdybTeX
	 /T5G4YevgPtCwF0SzLFHsjmAjdEKT33i8qEqnsjtfmVsH5tg7Lgg02uDtw2d59fOHs
	 PQSKZOJQ+mfMQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0D0C860853;
	Tue, 21 Jul 2026 15:55:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7C4811338
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 15:28:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7A0E06062C
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 15:28:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aSnHrNWbw1AJ for <u-boot@lists.u-boot-project.org>;
 Tue, 21 Jul 2026 15:28:44 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.122;
 helo=smtp-relay-internal-0.canonical.com;
 envelope-from=aristo.chen@canonical.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org A373960843
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A373960843
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A373960843
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 15:28:43 +0000 (UTC)
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id ABFE43FC05
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 15:21:26 +0000 (UTC)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2caf4173b1cso164458415ad.3
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 08:21:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784647285; x=1785252085;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=4G6UIxie3WxRhMZ8eXRtv3eVjfrpHhKDu7SIDWN3VU4=;
 b=EK+rL0VLxdmjYoYCsnsdMoWdNDG5Dzx/b2RjHnakKCVCgd3QsG5BwJxdHbXpMgISIU
 EaJLRBfvburThnjZ2CzB872KF6PlLx72WHUFYtwiy3V96I/6j2aUCpS3IXpb+QDXoYjj
 BFq0ummqinSsHSVJ7kYkY7dlQygbazUSxfmpkMLP4dsPRxJqvJklmmunaleLn82AIWlY
 ikm5P7AAUHFbnBiUAgyKzClG3QxY/ib2Fj5RvKj1V7V2JvS39tvTKk9BmBcnxjpd0Rlt
 bVJPXAXJW7erC5sW5pXX+A9t0kYbpl6YNoCGCNytt5Hb+/+Wu4if06yKxS76s5+BJPiv
 tYdg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr19cn5Ya+PWtlGjHWrnVlNqXFKvJuoX7xC1M6QuCJd9AoVh0ivtpgK2EPYv351D1c5eJHZsts=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YwLUXN9xe0RCm9Shg6U+X5KcQqw0kzGUuXJbBqRPhSNRq85fqIW
 dzVAmFiM3rNoV96u5z5QnFlhFnB2urxaioBMCD6L7BVvrjhOCtAIHRGOnmFnm8Er2kbR1Dkq2LL
 OdqMn++tImz8xRs2HAv7QPKPB0nahCO54t/OYcZTJCZYSzxbsGVTM0SYD+CLAPpFuyhrflRHESN
 hG8DAoPfp1wQ==
X-Gm-Gg: AR+sD139ruRwEZYIBF87R9ah8HO/oHU/5JsV93QLfz02JgnPQ+863vdZW+Hro43WWrB
 D47Fi7t0rtPJyuuKTTFn/BScATXPoFj5bCbGOzN3/XdURLHZanIAX9v3aQCaIOvFwuhbOFFMv9z
 fgnZCfPoVefFqiH6KchX3kO8uSolaBj6i4N4Xhwo+eoDrkZFDQpEITJeWPgU/MW5KGcyh+UNzqM
 GlTlBqMpJtlU+TSVqtmRSMw39Y8wSpuG1fjjb7kosZOks4dBvFzjDe+9TPqU4GObREn+6g4MRSr
 CK7ffwy4PWRL3+Py/724Kcy98ANNlHPAFG2Z1JANBlWCyO/rGNrUnL/xuS9LQ4GAxoZgSdnwwgU
 rlN57zgT1S99SSZ+gnk/MkWn40kIqOGpXoEE/A/wo0gIkfMlWv+Y5rUa/QWpDQIckKuU=
X-Received: by 2002:a17:902:fc8f:b0:2cf:4544:104b with SMTP id
 d9443c01a7336-2cf45441560mr169859065ad.5.1784647285123; 
 Tue, 21 Jul 2026 08:21:25 -0700 (PDT)
X-Received: by 2002:a17:902:fc8f:b0:2cf:4544:104b with SMTP id
 d9443c01a7336-2cf45441560mr169858735ad.5.1784647284732; 
 Tue, 21 Jul 2026 08:21:24 -0700 (PDT)
Received: from noble-uboot.tail872496.ts.net
 (211-75-139-218.hinet-ip.hinet.net. [211.75.139.218])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cf347119dfsm77733775ad.56.2026.07.21.08.21.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 08:21:24 -0700 (PDT)
To: u-boot@lists.denx.de
Cc: Aristo Chen <aristo.chen@canonical.com>, Dhruva Gole <d-gole@ti.com>,
 Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.u-boot-project.org
Subject: [PATCH v3 1/7] binman: Fix typo for the test case name
Date: Tue, 21 Jul 2026 15:21:00 +0000
Message-ID: <20260721152110.283998-2-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260721152110.283998-1-aristo.chen@canonical.com>
References: <20250914110021.4103-1-aristo.chen@canonical.com>
 <20260721152110.283998-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 21 Jul 2026 15:55:37 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=canonical.com; s=20251003; t=1784647286;
 bh=4G6UIxie3WxRhMZ8eXRtv3eVjfrpHhKDu7SIDWN3VU4=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=Be/hblFLkiJuuT9G62tp3Ep8hQJJ3V8zJZUh7MQlN/v4KoXJfI3uQPQTp4+gnnxP5
 0Cz8O7ch6B56n9Dc3TjYcNR4fyqH6kRRQ8K83mdu7GAzSTkBhSKd9amFNmnMoi2wp4
 scNa3oABJO1vP/0NZcURMzA//k7OKRI4DAfIDjo7VdlbpwU4OH/0czn0AyDrJopzc3
 D3+ZvPlUERPaZ6MLu0xipsz6ZPxBZczVbKz/SkBtr989xwH6Pysin1x+M8MFF9fy5V
 DIfTRQP6g/IP8Wr59t31KpRQx1W6NVGbcPjCCuO3iYSOf6UVq1dF6yYdm63mTA9JXM
 Z9VfloegjKDB9kYTZTwQZF1Khx/r+Zyyk8ZDOYphyBRKRMBwxdxxxAEJU+VNpIql1h
 0GGOORqHF973IT1FoVDgPAQJdOrGE7FPUtNGBwglg1YJB9e45Xap5o4WNh04bMt7wt
 R7higGYWFsDJNTBAr6EU34PLqEV0D7gjJuciJ6tXVbSXNq0L43qA+EPaSl7DZylQxo
 V5ngW+6QWGmAHmmWT172K29HPd7ZYPr1WPap0ViYtqhpJgKBgbf6FkJB9yD6PQ7beu
 dEMya6dg20Nej5n0z9FvKwn546dEkLkxQvNwFL6PWqwQH874b0DjQLXKOqvjbdPA8w
 U+l8iaMH91jQhxgtFLXa94Dk=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=canonical.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=Be/hblFL
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
---
 tools/binman/ftest.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index ea2fa6eb83a..82db2950ec2 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -8440,7 +8440,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
             'Node \'/binman/fit\': multiple key paths found',
             str(e.exception))
 
-    def testFitSignNoSingatureNodes(self):
+    def testFitSignNoSignatureNodes(self):
         """Test that fit,sign doens't raise error if no signature nodes found"""
         if not elf.ELF_TOOLS:
             self.skipTest('Python elftools not available')
-- 
2.43.0

