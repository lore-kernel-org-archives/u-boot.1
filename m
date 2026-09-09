Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C523C79FB6
	for <u-boot@archiver.kernel.org>; Wed,  9 Sep 2026 12:46:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 11DF9407FC;
	Wed,  9 Sep 2026 12:46:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1hZDMjqvukNO; Wed,  9 Sep 2026 12:46:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 50E314076D
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788957996;
	b=RRSQWkXvmGMftRpz/JUlov+MAM3GQX2Rua23M8THKprqG9+Mn6Q5FXnPWqJc5r8iMApW
	 haDNQH3gBw00RIfl6492UnJmVLF9DSrIA8IQvE7xr/yvUmT/cVKa5PQ2+EddF/eQwHTWT
	 n7UJU2c/NU/hBYk1s+iH6x5tT95iBEWj4Yt/iAzzGQ3je6B1AmdSRFRcRUUwWXByWYu9l
	 Lilju4+6SVZbkaxIZYzEFkGDP4RTWs5geP09Og+9LOSFu00mpyfU4wYxsOd2oVv0jAcpD
	 7TsHHQPIvCSlKRzbOuJsYY803nJ3WQNZWrarmHa6oxQF2bLwx8rM8VBqcsJizQwYgzw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788957996;
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
	b=oWV4hKVO8Yp7G9Ys9mHPJjaYNAWIgk8fx7C+qcYveAXM/7SElhbryTRLlu7rdcZFG6vk
	 AB9O5ViZIX1H05jk2IEvPEyii1is2iOvfTuzIc69slKv2HDG3ts0kmg4u/lSgzAnb+vEa
	 fST5bp7pW62ohNB5IsJ4kkqYHn+a0Y6SZg0X31J7B9eieqjydOPrneH7pVhCGsVY7/Pxi
	 Q2CRmuOuie4r+X2eU2kcnqdZJ4NNds8WdWZ9EYY7yt4y63HOmj6a1gOtdk+Fqef2tFP9C
	 Kt8silheAtG1+evMxyeK+QGjtxWauIMssPuNeR1xTqAySp8V6FwkvNVKSmrSLB4m9ZQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788957996;
	bh=cUCXB2Hh1KEVuBttkBHfzo9RbsDtI0CS3TqBKi/NtqI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SDMeDWFh8/qZ3h08EgQytPk2XUzf2hW1yiip7KIh2F4zzMHpKPtgSUgAxZbYJgtlU
	 9PEtOn8oYTV0BvTyqKdjGL4tSJHKgNmVjTPBXz6tOKm8Y2XQvo6yEou+NANsvd/wro
	 Low4tcx7TCEVgT0U9ZpPyGsdGJtksTAdxU2MhgBk+mO7FAty7L/KP0pgmUhsd6p2JD
	 ugfPPZG5KMUDXeBSpqfc+3+KdFALoDsPA9IGmNz2hpbjEX+CVbtew65748aHfbkorn
	 z+hPojxvWwHxiMMcezs1KMSAO9/zD9/p3YCK21mKeeHAHZflxX1oGsJu2RiX4Yf7D1
	 sdg5MzmC4DSfQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 50E314076D;
	Wed,  9 Sep 2026 12:46:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9BC95724
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 08:53:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 81EA0400AA
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 08:53:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id idUJKRFKRIim for <u-boot@lists.u-boot-project.org>;
 Wed,  9 Sep 2026 08:53:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 7E41F40055
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:34::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788944006;
 b=h1fjf0TL1gYvt7ZpI86QXiXPw3/eExadDzb8K1so8KXi5g2+8prr8N7GGJZ+WFLSAK6S
 1WzG3jyPJj2qJ0IkJ0DbCCkoaXcjG2qV4WfYHYnR1FldoD54vHV1BbMQ1HjlGJ/3Sc19s
 F6D/WrbOBhAN8ApqkC1pwuadIMBVlG4knsSMxJ0cCh+lYEdWjXoRxZhRc1CiFSuw+7f6+
 4Mce3yLC6elb+VWR3Gn0V4TLS47jqA4dvGDh249/k8xzzl/0m0VLfLxde7X260HcG3ntG
 7akW9/vsR4uASRyexbc5GDxiWE7xzlMrqS2HX1sfjGpv4FJabQUWZFwdw/Z8x+03OFA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788944006;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=cUCXB2Hh1KEVuBttkBHfzo9RbsDtI0CS3TqBKi/NtqI=;
 b=l308D9g+gE7QMYgtKjgZGTyykVtWChHzMAjQvkMniEKzm/BJ1FN8+nwGbsYo4n2NA7N1
 5wI2qLtGb+gaCo+lt52Jrb38au0Tc5o57+8qbRe96HrC/e0Mlby+r7IObWMXRID/8/V6e
 AysdwUjhA/2jnfvKzucv7pjapMgfn4xVPO9iZYLQZufUs4vevv7615KD0OFcJHNBxmc3L
 Qkfi4WiI2xM6rJM8HDnFoCd+hFNcXefhBl+IFI3GHbjZf/u18zi+FnpGJfjbm74Yqj0TE
 4j5LeU0nZU+MQRt5PmQtoqQ7hmaIZlin2pz9yVsy8lzpsn35d5CXnxw8PMqDAj/7rRQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=AFjTVvpz; 
 arc=none smtp.remote-ip="2a00:1450:4864:34::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:34::10; helo=mail-ej2-x10.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=AFjTVvpz
Received: from mail-ej2-x10.google.com (mail-ej2-x10.google.com
 [IPv6:2a00:1450:4864:34::10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7E41F40055
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 08:53:26 +0000 (UTC)
Received: by mail-ej2-x10.google.com with SMTP id
 a640c23a62f3a-c293d3da33bso506266b.3
 for <u-boot@lists.u-boot-project.org>; Wed, 09 Sep 2026 01:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788944004; x=1789548804;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cUCXB2Hh1KEVuBttkBHfzo9RbsDtI0CS3TqBKi/NtqI=;
 b=AFjTVvpzzeom3lrCxUx8loaFrSRXOZH+MNSGXy34VPJk8NspQIFLgEGJnVK2UsmPxV
 bz5nFppr7OVsU64rw5jGE+XxKGwZFj+5t+6+9xT1Z+1WzFKASTqRNfLuaT4bRB75PVMc
 DdB4/Cah2OFmRzn0gH31gwIYYi4u1LFv/gsK1q+x6kSlAljBF6dn2yct5hHgrKCmP6zU
 fC+1sOnoRFWkwlv3CaO1InBadZ/8o1YJUp1HvNeWBDJ+9k+ec25Xm1Aa1Al1UngOWoSa
 i1b8Zp/QgJ025M6hVZj4FyEko4zELYtMRYoLlmL2k19hk/PpjK0b1poem4hpy83L5gm4
 D+TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788944004; x=1789548804;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=cUCXB2Hh1KEVuBttkBHfzo9RbsDtI0CS3TqBKi/NtqI=;
 b=ldWJLtUa4VG/dmmuxwuNXIDLpNBhcsOf5HfU8TpTZcJPNp5DDb2LqJpD9fsU5fZvgE
 7aqQjHXvF+RE2wMvOJrD50xgvdOqBldkpdGmnlQvPNGWoiI3hoP4OT/DOlK61OPEiIDL
 6LeKM+0uRXrLe4Yyo9Z4QHFnV2BmS0LeGBWIYViFKUBYe/lWXsZqOjhpoi3HfZ0Z3Cle
 aegsze23k9DYy/80ky9zSyvVidjHbksUyINdSyFOKFQiIEdRoV019F6vpJeWcsho3c0b
 eKnC84y1QemiGvURhYWlpC7dzv6uMZPxazoxM6VcBKITa/AEe4GZCGACpHVBMqgma4ZO
 IrNw==
X-Gm-Message-State: AFuF++nFoA62Tj3oMedtHXK6OIiJ0L3IbLZ2aphyzYhW5WzPx6EEk8U4
 qhtPsLgfayMa/ragTedFTYbk7fCVxMKrJnCbIhifRwDmxDM0jafTj4JD5nNMuK9AriDn/fIvFtW
 K9r8G
X-Gm-Gg: AYBFou0wOWSpw+D54A66Zo/DV1bDtFvgkDSTNRpgcWPtQ1DOR+uKOZKxMXdzATHpB1Y
 74f4qeChU+kZyUwqZjKRzoL+auH7+oud0o34LkTnU5gCkZ+00HFQjlqYd0FzYYv2qlaJzfTsD40
 zaXwadBPNlpLCEjINQ/JKPXHi1jfe0QiWPrvX9WAq0YCo1OldzoUs4QT5VwzA9rJyFOqKXI1tCZ
 x7ymHqKoWw73t1HCGOyuN2ZgIaNoYI2Qei+hYAwiC5uklqmQoLthsLoFyekCpOWaYIfqHhoAsaj
 pjzUXEZAO+gYFYNC1GU/Tm1QKmA5Ge5dIrzxcHkA7BiYTyVlEVbNun2yQtjwFraB/XU7c59nv2R
 9IJw7BXUTqc/kYKV0AyPv5skTdObdY+KHeMmvAT/pOJsNpK1Kt28V0uchofEPn7e2nT0cMLhEqI
 C71CDbMPZ/jAnOfN+OsdjBqYeaubbb2Alu20aSKyrWKY7zotB0aCGh3d7LEKIKGZvNxeGtR57xZ
 YH/pTdorhhuCqQq2HjSVvP9x71i2pV+
X-Received: by 2002:a17:907:7207:b0:c21:7bf1:2c88 with SMTP id
 a640c23a62f3a-c2625035993mr1044428466b.2.1788944004582; 
 Wed, 09 Sep 2026 01:53:24 -0700 (PDT)
Received: from monster (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c262f97f1a3sm557381266b.19.2026.09.09.01.53.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 01:53:23 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@denx.de, alchark@flipper.net,
 jerome.forissier@arm.com, dlechner@baylibre.com, anshuld@ti.com,
 sjg@chromium.org, Thinh.Nguyen@synopsys.com,
 Anders Roxell <anders.roxell@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v8 22/25] usb: mtu3: fix up after the resync
Date: Wed,  9 Sep 2026 10:50:12 +0200
Message-ID: <20260909085015.2480097-23-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909085015.2480097-1-anders.roxell@linaro.org>
References: <20260909085015.2480097-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 09 Sep 2026 12:45:47 +0000
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

