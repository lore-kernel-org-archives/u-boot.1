Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DE4606A326
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 12:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=fOHOHO4F;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=hDgUvC0A
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 51F8360684;
	Sat,  7 Nov 2026 12:50:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SFCX1J0qhfih; Sat,  7 Nov 2026 12:50:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9FC8D60762
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794055844;
	b=ApuHmSoa+hR3LXCw3tj4dHa4ylAsO9rm1X07akcATNVqI+GfotJBskUDHst+0ctzLlLK
	 /z8JPehr10E4XRgV4HtnkDHtBFxWDlTnoia8ZD5YH7NMSJpwuGQnJ6YhS8X17bOEb4bsJ
	 Q2fXK1/ngMEJGYGIAyoENzOZyXSNia2dBHSc+alqhUTLCJN2XAxYLkQlhmhuRM7lnEFj4
	 UzQDGm10QCYEv4C7QYATQjGyK7w+Ze3COY0ppZAM2VRpK107Cc/aYNVTbXp0VSUREm+W1
	 /AzeC+mK82mbnH1KyQxFELePquCkmOsZlKUSsfSZUk3rc5GsEDGw7cSdiNJSbgO+b2Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794055844;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=cUCXB2Hh1KEVuBttkBHfzo9RbsDtI0CS3TqBKi/NtqI=;
	b=MV4GZxPWNSWPcvddjGOKJwI6Mz7PPgdoVOfSJolC3aALDPQS6vwxgTpaavMmm87rqMx+
	 SyP60r1P0TACdLmXjl6pE9iqdyGNyb5iKlNLe4fNMwndq7/+eY1csdU8dHkEgC0NtKJI0
	 z0XZJT6JOie9Bu5dvjAUVvDVfh+Rf/krWHWjS13akZ6WnGGyX78kgJ6Ndrlqfw7myBhO3
	 mxbwLfT0vnPQsSm90APgoaLeRlsATQFpMjDz5AeBXXeK8cvptqtdK7/9wRvoquTiY4WTu
	 o6+awSTmF4dT3GcDVUFqDRS5yobnFFGDVHT1aR8mYxS96gkvyPQEsPZJFh+RVChVyHg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=hDgUvC0A;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794055844;
	bh=cUCXB2Hh1KEVuBttkBHfzo9RbsDtI0CS3TqBKi/NtqI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fOHOHO4F+MwoRKvz4UysIImdvZGEVtj0U9V+b9rAGDq5PypSJJOsuDF8adfw62PcZ
	 4AtHp5xLSCAqaDy+RMCvkb4ThTAIX5AKJajKJtZvGaP0KyCg/xUG5JwHLBTCg8nht2
	 9fOmg45oIBqdwN0XeN875gxdR2ysDLiPdOd46Cc/cJPqbBZnxLFwmh2LKK9UJVKnpw
	 9IlsMoiQxdgPNobmp6hMJQO2BhbB9zAJqSHAcxcYPsWThr93Bc/ps5gfmmkJ56t3Qd
	 w/d9Kj519Orqebvkgt4s48Hi8xqGtNCk1OmWPIOZPLM1Wmt36V5+ER5ewpdcj7LH7c
	 iKe11F6J74SqQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9FC8D60762;
	Sat,  7 Nov 2026 12:50:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 117FC2AC
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 07:24:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 03321606BB
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 07:24:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fN1qDFgohFqR for <u-boot@lists.u-boot-project.org>;
 Sat,  7 Nov 2026 07:24:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2C10D6069B
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::52b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52b; helo=mail-ed1-x52b.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=hDgUvC0A
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2C10D6069B
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 07:24:12 +0000 (UTC)
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-6b5ab84193cso206562a12.1
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 23:24:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794036251; x=1794641051;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cUCXB2Hh1KEVuBttkBHfzo9RbsDtI0CS3TqBKi/NtqI=;
 b=hDgUvC0A9I8rGYEGk7oklajNc+8ZjPFEVht3VPlBWt3fGs4v4x6CiiCuoG+VsaEw+T
 ylIZ60a5SWNBoYGJ5qmfPReOtdI2rmBm3f3+1xqUQqwTuhEvRSQih4u7rmoA4e0d68Bi
 513KlGxzy71CBCWnNMU2Hx5+GY3CYTNt0M792DN2RI5uEnVEX7ENedioEvUFfGjBTzdD
 Fo+DDHeQYrrX/TfA3MQKN58SPHlIcs5a9f7RvAuUU4qJC27+JcWZG/dJ/MSIDSEy+Q6m
 OWiPNbGhs5QkjcsYtOZbvpc72Rrl7cyZQOsrk8Tfp2VsPdzBMjujXwHI29T7gQIK8iiR
 nyNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794036251; x=1794641051;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=cUCXB2Hh1KEVuBttkBHfzo9RbsDtI0CS3TqBKi/NtqI=;
 b=Nn4mryPr1R2c6apC549Gm9pSh0tQKGVLQIac0sNkf3tAy3t+b+Vjsh5+xtvpkMjklG
 Di1URfNDbmDDTH1RJQV2eroJ0egHLyWEqwQUghTk6P1CC6cdyZShS4qYRvnBDOgdtUmG
 EOnO8sZctbb1iygsYPgiUNi2fIJ+a3NBDTS8b5lAcFpQhYLV8Wv/ERr3OrVcImuOJghs
 QnyVZsWnM6wjy0nLX4P4URsdWQApZpXKVMeS5WrKNqZCRuXTiWPytDfLjd4hqbOxBfJT
 M1BY522D9DE7/Wb0OQ3fl1hOALLQEk4kyhDEJzL5u2d30KPszGtQWtmXB321q4EmYGH4
 2BCw==
X-Gm-Message-State: APuU4Z/0rVgub7oGZrqMmCLLxtNpgH1rtJMQFP8ZHnjFLyea00vtWBDW
 F1fMoqVf3wZloSLrMe8TrYeFpoYnAK9tpCWyyNkvUugNA6UAeuI89HBr9lVNY0l7Q6BDp1G7nBN
 SdvNi
X-Gm-Gg: AYBFou0RjgrAquAsq+W+fDi2rxh1aBWGJhE25lDcxxS9e/TZC4uDMgwZBoBgn1ToI4j
 fPWxLHwvnH9NXJ3AdnUK15f6sLdtDXIUxtIVecpZAw2xyzbQLIcB6LSN92DUA9tkfscVFIcrKou
 jd6TM7w/p2W0fJJo8MosZ4zP8d1ZjuUTfRKShC5GXllyp/KKgW3pnmxDvkuoUJzx1f+XqAowJie
 Obkgx/0SMNdnVkW5BHlOI7Dmt9KECdFgKnV8pjvMJu/q82Qn0lthcwFadIRg28XJDrc7ffQSBMp
 p7e3tiwZO4qKGMApGkWooNIFvsjOPO83vbP7Ecol0SDsbK/Hi/cPm5M71wgGOYqnfwCqWzBzu2u
 o1fRRKWhExNEYBB0gWckE+xSh6eoLL3BuI7SomY9tRVudQlasT2QEsdP7u3K4jl1ae2z4NwQSc/
 AvI7c9bfw2DIukz0yWSBPWSfW8ahWcEZKKl8DkJZ++NxzL/k0SQ4CODx7+O6OOKfn0OujmAV06c
 TYPh78oj+qTCpKv9LNIawVBH663HcY8rrLCG4L6R8jx/EBcTJ7A2TyHWiQSCfJRgyThH3X1fw9Z
 vJwcFZUnjzRGQIkHsTwusP00HVPYykf/v0ZO+nt8PyLKyR0MWeb0OtTTUz7zIO0gNFH7QjSUOHg
 tbLHmO+Dk6A==
X-Received: by 2002:a17:907:3352:b0:c4d:481:e68e with SMTP id
 a640c23a62f3a-c4d3529dc62mr335916966b.2.1794036250738; 
 Fri, 06 Nov 2026 23:24:10 -0800 (PST)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4d3562ea8csm130129166b.22.2026.11.06.23.24.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 23:24:10 -0800 (PST)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@nabladev.com, alchark@flipper.net,
 jerome.forissier@arm.com, dlechner@baylibre.com, anshuld@ti.com,
 sjg@chromium.org, Thinh.Nguyen@synopsys.com, mkorpershoek@kernel.org,
 love.kumar@amd.com, quentin.schulz@cherry.de, s-vadapalli@ti.com,
 Anders Roxell <anders.roxell@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v11 27/30] usb: mtu3: fix up after the resync
Date: Sat,  7 Nov 2026 08:22:21 +0100
Message-ID: <20261107072224.3492260-28-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107072224.3492260-1-anders.roxell@linaro.org>
References: <20261107072224.3492260-1-anders.roxell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 07 Nov 2026 12:49:49 +0000
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

Adapt the mtu3 gadget code to the new gadget API.

Co-developed-by: Jerome Forissier <jerome.forissier@linaro.org>
Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Co-developed-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/usb/mtu3/mtu3_gadget_ep0.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/mtu3/mtu3_gadget_ep0.c b/drivers/usb/mtu3/mtu3_gadget_ep0.c
index 4b0bc5f02d10..07775d23d508 100644
--- a/drivers/usb/mtu3/mtu3_gadget_ep0.c
+++ b/drivers/usb/mtu3/mtu3_gadget_ep0.c
@@ -300,20 +300,20 @@ static int handle_test_mode(struct mtu3 *mtu, struct usb_ctrlrequest *setup)
 	u32 value = 0;
 
 	switch (le16_to_cpu(setup->wIndex) >> 8) {
-	case TEST_J:
-		dev_dbg(mtu->dev, "TEST_J\n");
+	case USB_TEST_J:
+		dev_dbg(mtu->dev, "USB_TEST_J\n");
 		mtu->test_mode_nr = TEST_J_MODE;
 		break;
-	case TEST_K:
-		dev_dbg(mtu->dev, "TEST_K\n");
+	case USB_TEST_K:
+		dev_dbg(mtu->dev, "USB_TEST_K\n");
 		mtu->test_mode_nr = TEST_K_MODE;
 		break;
-	case TEST_SE0_NAK:
-		dev_dbg(mtu->dev, "TEST_SE0_NAK\n");
+	case USB_TEST_SE0_NAK:
+		dev_dbg(mtu->dev, "USB_TEST_SE0_NAK\n");
 		mtu->test_mode_nr = TEST_SE0_NAK_MODE;
 		break;
-	case TEST_PACKET:
-		dev_dbg(mtu->dev, "TEST_PACKET\n");
+	case USB_TEST_PACKET:
+		dev_dbg(mtu->dev, "USB_TEST_PACKET\n");
 		mtu->test_mode_nr = TEST_PACKET_MODE;
 		break;
 	default:
-- 
2.53.0

