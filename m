Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3C04C61DBE
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 12:42:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 894E160606;
	Tue, 25 Aug 2026 12:42:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IYlAIvfZExbZ; Tue, 25 Aug 2026 12:42:52 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787661772;
	bh=XbwheU2j3z4om8osr+8d0j+aJ6oNyZ/IJxLc3FYN6+I=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=nt2wy5nIW5zu2x25mwwQA540/SVnARv/+ngU3KFGbLxBDnm8uMEgjK1+fFFGgNfGL
	 anerbbcaTS/CzpUw8/9S/8lkrC6dWkw7PrxXRztKSv4PV9wGWjf7y9WM2OVT7AAPuJ
	 AoEWm6NMZmoPhHDE8avBlmDSJu7VZNZ44tNtOnzxAV9YlQU9ySd4/ziM7ozL1jfha5
	 5VnsyG+epK3He7PEktwYNN0CK8cFqC2BmEC3ZxSKSVNOCJLTzTeLjI/VknGhcwpZUU
	 Pg1AkYBu34oCyEntsas+9hSdyOTQvOW8zPqE0XvH+JWj4ohmzyoLxEb+q1Pn0827bz
	 ncqTrn3psoqHQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E0EC260683;
	Tue, 25 Aug 2026 12:42:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3B4783DA
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 06:53:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 20E0260672
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 06:53:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pQzSdEPvTU7R for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 06:53:03 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52e; helo=mail-ed1-x52e.google.com;
 envelope-from=bbanelli@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=J/jk/xJT
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3444C60667
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 06:53:02 +0000 (UTC)
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-6a0a4a28cbdso7749150a12.3
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 23:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787640781; x=1788245581;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=XbwheU2j3z4om8osr+8d0j+aJ6oNyZ/IJxLc3FYN6+I=;
 b=J/jk/xJTBQwoUUoi9tsE0Sh2t8GlayZ+1b0P6NwCmeG3RG+KqTrt3oB0e8I93BIe1y
 MKV/yjGfiUBlvhAFDhs+KTkEXmD+yHW+w948Xbjiq8K6MJOjBXRtGa0HUcGQFWzgq29d
 Dd7jeLE5AB4MN/WFVDKTbDdTnIV48KO9NFO+oLp2wEgNVLiCc8NnAWAwUiEDPOcSxEnZ
 yvsxuHMGP01q/W0/J1RI3vZHEC3yRrXA2RxnBndAakLd+wgPugqjltA+cEzHDF7I8qf4
 rz13N3INmRER/mnR4fQFVkjW7gZvACochJ35Oopduie9e9Mp2f0HEBmOhfcZs3NdSHbA
 wRHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787640781; x=1788245581;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XbwheU2j3z4om8osr+8d0j+aJ6oNyZ/IJxLc3FYN6+I=;
 b=mn/1vkSzVXo357/ChqWsmpQrqp29tupBuIGndDB4uG8MqmCFwPDS4SEIu76ixfvgdi
 YLrWTBTDyzpabj0KEGbShF5ZgQZXCOTJ5+9v4hnylDjYybf796ml8RHEq3KVm9gt81pm
 21hRtUWDPxUTzgWJKaR5ApjX+BpZBsxtk6Kn7Baz0g0VMwK2QBpTixm4S3MwnYNw+8Hu
 rVQtsBqAcbbZXsWLyQkni8GBIHlvqdTUgR9s1Sw3oxMSI9WwRyrE2AYFI8TV+3jm/shB
 d+/YT8d66T5a9pf6/Jlx0pg2CtqjRmF+71ht03S9oleR8hBjjfYeSugqofzeXSGmvD1d
 +BSg==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro8nt7HVOaUHsgFR8mqJvQCM+F7HSuqkFiv35BizEVLsLSm93LRO4tnZD+Fmx3NU21JJl1b7LE=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lAB8+iW96ZMKkZAwXCNXRiZlels71A2MTYBPwag1wUuJtT0n/U
 TkYEMdaeuYGGB6rMkuToRnnW2PN1qABL9keYVbbH93bFuenFQksbzBct
X-Gm-Gg: AR+sD10XlVK7QY0V6mX/E7QdMTuDbighaNapZKWp8CkFjQo7pgXj7wZ9lihllaj033j
 juloL99aCxFIc6EYY6mqHMtWFPVRgirKc6i9WYneJTWfgIngRdwcYd+kEhv4c17HjdkaEe2ANiy
 cAVgTrJCRsJNeUqoaiKz35bgU6z8hIuaJUs0XJkegmkmrCG4CZOKbyKy91v1p+ov9yiKvPc/Hzf
 3mb3OSGFHhvSvwskjTf+C7DoCrcHhnWFB4usPLdfznU1Ngzv92aVDxqdBi47VWOOIX+vTpzqlY7
 lvsR2GD0p6whrlgb1SkLXGbCBDRX+YxwicCJBUa/o0lqIAEdQxbVjLXj40zSqtMJHgJqiIe10Pn
 VLxSSsEf1IMroogwUaWDT/WB0H68jHLTV6eOvLA6QCrFLjwIHFVo2d8W3CSv817fNMW3zuDKzgj
 ue6rmWIZJIrAgbP9soqNYcFdnrKvTs9WKRUKTMiy6ErvSJwTMS1Jybz0B1iaCBSH1wLrZNbBRy+
 L2AYkpTAHXOOEQOH9CDrFdfWJ2KeloA8eeAqUT9OtJmZ9t9XpcuIzG8Pw==
X-Received: by 2002:a17:906:8e15:b0:c1c:4858:c19c with SMTP id
 a640c23a62f3a-c249267be61mr2749518766b.23.1787640780380; 
 Mon, 24 Aug 2026 23:53:00 -0700 (PDT)
Received: from GOLDENAXE.office-radnicka.localarea.network
 (c82-214-103-66.loc.akton.net. [82.214.103.66])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c249606bd05sm1545251166b.2.2026.08.24.23.52.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 23:52:59 -0700 (PDT)
From: Bruno Banelli <bbanelli@gmail.com>
To: Huan Zhou <pericycle.cc@gmail.com>,
	Guodong Xu <guodong.xu@riscstar.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot-spacemit@groups.io,
 u-boot@lists.u-boot-project.org, Bruno Banelli <bbanelli@gmail.com>
Subject: [PATCH] board: spacemit: k1: accept the "m1-x_" TLV product name
 prefix
Date: Tue, 25 Aug 2026 08:52:57 +0200
Message-ID: <20260825065257.69536-1-bbanelli@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 25 Aug 2026 12:42:50 +0000
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

board_fit_config_name_match() derives the device tree name from the TLV
product name held in the board EEPROM, and only recognises boards whose
product name starts with "k1-x_".

Boards fitted with the higher-binned M1 part report an "m1-x_" prefix
instead.  On those, fdt_name is left empty and the function silently
falls back to "k1-musepi-pro", so an M1 board selects the wrong device
tree with no error or warning.

A Milk-V Jupiter fitted with an M1 reads, from the 24c04 at i2c2 0x50:

  00: 54 6c 76 49 6e 66 6f 00 01 00 1a 21 12 6d 31 2d  TlvInfo....!.m1-
  10: 78 5f 6d 69 6c 6b 76 2d 6a 75 70 69 74 65 72 fe  x_milkv-jupiter.

i.e. TLV code 0x21 (product name), length 0x12, "m1-x_milkv-jupiter".

The device trees are named for the K1 in both cases, so accept either
prefix and keep deriving a "k1-" name.

Signed-off-by: Bruno Banelli <bbanelli@gmail.com>
---
 board/spacemit/k1/spl.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/board/spacemit/k1/spl.c b/board/spacemit/k1/spl.c
index d749e21a..e82fad23 100644
--- a/board/spacemit/k1/spl.c
+++ b/board/spacemit/k1/spl.c
@@ -367,7 +367,14 @@ int board_fit_config_name_match(const char *name)
 	int i;
 
 	memset(fdt_name, 0, I2C_BUF_SIZE);
-	if (!strncmp(product_name, "k1-x_", 5)) {
+	/*
+	 * The TLV product name is prefixed with the SoC variant fitted to
+	 * the board: "k1-x_" for a K1, "m1-x_" for the higher-binned M1.
+	 * Device trees are named for the K1 in both cases, so accept
+	 * either prefix and always derive a "k1-" name from it.
+	 */
+	if (!strncmp(product_name, "k1-x_", 5) ||
+	    !strncmp(product_name, "m1-x_", 5)) {
 		snprintf(fdt_name, I2C_BUF_SIZE, "%s-%s", "k1",
 			 &product_name[5]);
 	}

base-commit: 964ad5b5c91b7be56e443e899d7f873e6aa8c9fc
-- 
2.43.0

