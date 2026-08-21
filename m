Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 810F7C5DF8E
	for <u-boot@archiver.kernel.org>; Fri, 21 Aug 2026 13:16:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 58C5540F49;
	Fri, 21 Aug 2026 13:16:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kGNuKBKkHNJO; Fri, 21 Aug 2026 13:16:42 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787318172;
	bh=cUCXB2Hh1KEVuBttkBHfzo9RbsDtI0CS3TqBKi/NtqI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xg8hCeG1mMYmt1Jp7gpqAqzPNbvFStcmLyN87gXu26pBp28UuZR/eFOfB31OjDoQY
	 iSptRMV4qGXx3qZ8+Fj4ZsUWw9iepi+X6PxJauWf8VxfrdwrBUiYH8rxGHdD+Svblz
	 OKp+Q5qDZ4+dnGiEt9ING5L5Xxw5Ix0LUH/FpM7G+cwnXiDOoRsYYnJSN8wcVawJik
	 klihA+lhby7zypvVdnSBB3ejHpLE4+lLOsZcVYyT85LFILfCdNDUM5IFfW7Raf5RVr
	 eSOmBedm52UQD6ZPooQzC/98HMgNxF0muHSI9zrpiYcbfXdKz7S9n9CxuQ227eKRBZ
	 uMN0ahkqT9VQQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1D13B40E43;
	Fri, 21 Aug 2026 13:16:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id D53FA1CF2
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:52:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C749B4006A
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:52:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cuyKdTIdvaKD for <u-boot@lists.u-boot-project.org>;
 Fri, 21 Aug 2026 08:52:51 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::529; helo=mail-ed1-x529.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=HC2Jhd/s
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AE06F40071
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:52:50 +0000 (UTC)
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-6a18ef236ecso187761a12.2
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 01:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787302369; x=1787907169;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cUCXB2Hh1KEVuBttkBHfzo9RbsDtI0CS3TqBKi/NtqI=;
 b=HC2Jhd/ssb6vqytdHggKvzcJba96O6kHabAgwRf56PcBbAJu6dL0+sa2JntqAdUeIh
 OB2+p9f1apq6GmsGge6wyoGmxMLUcrEm44gTeRlQK2aaXMDlIr2ujl4aWh2XsFZLhHYS
 C9wLO83FbRq2dcQXylCPN/ZIEO8X9/ysjWiOzkDGQHcInANx/l3w3X0CELZxWYZjWOgK
 drzAkoCY40CPQg9hEjBI4hMvz/5T1XYYj2rCju0IK2kGgUHKxhu6RcQ8pAnpWNH85jUw
 xK72dme7T3fuU/PUD5oZnpzkZ4fZT90kDrS6nls1WmdaehDmpxJ6IJm2NIzwAA/POTOg
 uezg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787302369; x=1787907169;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=cUCXB2Hh1KEVuBttkBHfzo9RbsDtI0CS3TqBKi/NtqI=;
 b=AQ1AOxB9JC9yTyfTPHdAQB8WEzqJwrpXpF22hyerZ5kwL/CsH5uUuVRBvbgvaZEnJa
 1HD+kThzIVMa5sGLp8Jg+DlcMNlAokluRyOlf6EOlWBXgLYM4rxt+mZcLj7fHRfJ6aMM
 U8dmEMhpYieTS/8jBvFVeFAp6nmeaXDGE3pgDyV+SSkjcQxvZPyyTc4dBqk2w15uq38D
 gG3KLQyHXG6nFcwmxQZr+m+hQ/cQ4/yJAy3SYRLX03peIokRZOsANw8bLAkpov/xDW/O
 x/RIpRWubIyN8ni/JpdIuoIkHgDVU4rkl92nOeyBF9sMNIM0h028n6EdUkFoszTbazAX
 rsDg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoXmtpRtWxsFtnK8bmYpq2kSPlaR5yO6zmWI9KpLDk91TkLQOY7xSk6uNZyxO6nur/3ao5rEDs=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mYLpU6P0prb3Ya/aB627SeQzoI3qkeVqVFKXZHeYwZoLrCtoQS
 Jf8msPomDPSjmbEKLleReJ9snMEn7oM2V2bjfiw6wdHLr0eLcOq5J3djdTa4UUTOMRQ=
X-Gm-Gg: AR+sD11JkURxj5jSnF09uEyuX/Ufr6Bs9alwjGTuz0TM/7l5sefOHP4XOUk6lX/BCGN
 wrqAY6B57M/aHmfu6Xyob37/vp603z/HhlkHtphNwhqV0gQNY89173vr0O36SX3KnqhTHR+lfeQ
 jajIdCN/wiR8cZw3V6UHp2e0RMZal39TwXj9lFDj7VQ/yTbKxk4WOe5lOCWyODzjsSEA4rWQMhz
 t1L/M4IpBWFj5H7rcNOez9Je9mgTkqcrwKRTEHawAHWdDDnSTM2Qisz7vY24j4bH/qxcXyaUyP1
 1GTMrYsovV4EGNsja4e+dy7CMkJtdS8yzF8fcjQhvRom7MxLIU9owzvoX+33VR7zBHj0drtVNmU
 aylb9sKFfxzRpa9URFNnCkP2Y+vZKYDZNrO8Zp8N1vPt8/Kr9C7UNbRm3P+L4oK5EXZAmTbPM8H
 9NdoWj0Adp8Wjx/BPxapnKsI3mDkIB5tk0GqYZF0+MBfGJ4b6qjqG3mPHI6FVTCm/e55puj/KH+
 DsfD8b1VYS/jwOrmvVjHvLGSThu9KYQfso=
X-Received: by 2002:a05:6402:5d0:b0:6a1:d68:338a with SMTP id
 4fb4d7f45d1cf-6a42eeaf432mr2761560a12.0.1787302368710; 
 Fri, 21 Aug 2026 01:52:48 -0700 (PDT)
Received: from localhost (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a3ff1567f8sm5620912a12.18.2026.08.21.01.52.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 01:52:48 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.denx.de,
	marex@denx.de
Cc: mkorpershoek@kernel.org, ilias.apalodimas@linaro.org, trini@konsulko.com,
 michal.simek@amd.com, alchark@flipper.net, jerome.forissier@arm.com,
 Anders Roxell <anders.roxell@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 David Lechner <dlechner@baylibre.com>,
 Julien Stephan <jstephan@baylibre.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, u-boot@lists.u-boot-project.org
Subject: [PATCH v6 84/87] usb: mtu3: fix up after the resync
Date: Fri, 21 Aug 2026 10:48:00 +0200
Message-ID: <20260821084829.2070426-85-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821084829.2070426-1-anders.roxell@linaro.org>
References: <20260821084829.2070426-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 21 Aug 2026 13:11:41 +0000
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

