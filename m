Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57244C5DF81
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 16:47:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7D76C8129E;
	Mon, 24 Aug 2026 16:47:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id winJn7ZCNg8Y; Mon, 24 Aug 2026 16:47:45 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787589958;
	bh=cUCXB2Hh1KEVuBttkBHfzo9RbsDtI0CS3TqBKi/NtqI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=T9TnN8p4sAIBQ5tyse94JeKZ4loToQE5ZFM8Z0dhjgzNrUtl0b7qGPT/zmE2VqeZN
	 mS1tU0NKGMmG/u13mZJIXlqyxLZ5BAULuD6whA/grBiLB2B03akIjjO0I/Wq1BKap6
	 QB/Cm6wkMMq1hhKChL1kk9a0llWdGHctdEzSm2Dl85gRmTxrTFXCd3tDn86qMNmO3m
	 o0qPw/YDGWtxJzr1HtGOd0IldX2jpULp093dGmzKBB69Y8BM/rW2dc/aZbiR09LhS8
	 Ozs/SkBASb34uL+wyJrHim6kdJcA86npOvCMb30zZwCq91+Xv5YNTG8bovKhuZdOjr
	 ryEqn/5cGXmdg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3C7F880FAB;
	Mon, 24 Aug 2026 16:45:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4F8E73AD
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:43:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 35F2C40540
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:43:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NSi1BxGrTBTz for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 15:43:55 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62b; helo=mail-ej1-x62b.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=t8JgQSno
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5AED74053E
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:43:54 +0000 (UTC)
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-c15df0c154dso31672766b.1
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787586233; x=1788191033;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cUCXB2Hh1KEVuBttkBHfzo9RbsDtI0CS3TqBKi/NtqI=;
 b=t8JgQSno3Rxyp47VBkdSxB0G2c+ShdWWrVb/8Ec6NVQQIw/3oFuw7ezwwgATmCIEv/
 FettHeU7tll67BLrXI4tSJXM20C8WvXJu3tk9En/CZym0bxLFQPoP4eJzE6lgNwJ5RFn
 660JNZ2FgxmprxBu4r6DsnJxn8K1xfvnM1MZv+N3bYWsjwWu4/3mh/WQM9/iMg/iyDFe
 2sdbx6s7fWliHWRC+qlVUjxaij7tR0SHhJ+5gWZzupv4VAR/5Fd6QtLp8T9CkaMAm84u
 f1HVoxiovNGHI4hsfnNrYngVTEULfnE/x2njHIxfezZYqHbkpw/2+HojnsEq62pzmUEA
 56UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787586233; x=1788191033;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=cUCXB2Hh1KEVuBttkBHfzo9RbsDtI0CS3TqBKi/NtqI=;
 b=WmYk294S3KQvPDYOQ5fNtJ7Tjy4AbvG/UDdxjUx51yzVXtKXLhH+cGZHYdxj8Haj0Z
 YjJnnEAuaBrIKdiJu/PjgpfMhsbZ7vOZoaDqQ6CTwoEdvnH65DXxYCg9PTDqOrhIiKqS
 EuDUF3G+Qm42S9f7YfzmgT6qlHzVfBvrso043DuFO6d1PuMblAcCddbX+KfcWKrQzOug
 l7gXugSBAQdpzEcuxC39zRPuPFXeGErxX8MboRoIBY+inpORz6ovJLWvv/g5C+nfthKO
 b1G1SuqkLD8/GtoFDOLaRqdh1gvE3IHhPzjriCaQXScaddpXTj7gs1m4S6fDk8IVR2+K
 3vAA==
X-Gm-Message-State: AFuF++mnd3bszexHjjcRBSBu3ix+BvbFYGZF8OPhy6sziKzvowpu7u0X
 eb4lYm6pd5wxCdxF/7y9phQuybxPY4GlznMvzhKyRJNmTbyEJ8l8PRuKJU183kL/7xp+qcINT4L
 IsE02
X-Gm-Gg: AR+sD12kewd40v+jCL8+puxRmzo7H8vg6H4oZuyNg98P0ZA7rr6E3FSMqVnLvU80PnU
 ya3XzI/h94IMWixvAivFvTX1XMqR2amISJS+AEfWxV6Ils6ZdecViCJ0b6xy7lFMbo/xhEdGIHi
 93BzQAgi0U+lwl55LrDwLbk3RVmy7Ney4laCHEabJX4z4NVOfAKX+Mz+DlHYYaEIx5SXMsQ4iww
 XsGyW28/p64dDPubUMOwENm9ogv5mpcPo6IXOdSm8fJFoGqHhf0iZROiEsz25Pr0QFGaxOM+W3z
 MesAcIdwbEd9Ne+6dC9SIGfyudd2ABhYkVnIoK3NtN+qivzThjHf2G86Wsv3rYq1m6ZwCyi3nI+
 hGqpbha9M6tnabhPUox6/MXYvKsNpdCHcdaPIMIab/80fyf9yjUzAsxW2y7mbfhK707hO2GHiJ4
 l06YBDA6SlhJXgsa6IcEgcISRkSI8gSOExVftzZ0MfP1ZWi8Yko7xGGOk799+W4VTZf5iUO+xQ/
 5va5Z4TC+3zRAXuiw5mXJ/Z8IsDv5Ai
X-Received: by 2002:a17:907:97c1:b0:c21:764c:9417 with SMTP id
 a640c23a62f3a-c246a2eb944mr1675023866b.1.1787586232634; 
 Mon, 24 Aug 2026 08:43:52 -0700 (PDT)
Received: from monster (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c24968ba7b6sm1268749166b.62.2026.08.24.08.43.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 08:43:52 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@denx.de, alchark@flipper.net,
 jerome.forissier@arm.com, dlechner@baylibre.com, anshuld@ti.com,
 sjg@chromium.org, Anders Roxell <anders.roxell@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v7 21/24] usb: mtu3: fix up after the resync
Date: Mon, 24 Aug 2026 17:41:30 +0200
Message-ID: <20260824154133.217744-22-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260824154133.217744-1-anders.roxell@linaro.org>
References: <20260824154133.217744-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 24 Aug 2026 16:43:55 +0000
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

