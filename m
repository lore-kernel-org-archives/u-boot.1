Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62289606A335
	for <u-boot@archiver.kernel.org>; Sat, 21 Nov 2026 13:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=AZ78eJbW;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=MH+xZZ0m
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 21D8260F1F;
	Sat, 21 Nov 2026 13:15:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cGjebcyM3iyx; Sat, 21 Nov 2026 13:15:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6E8CF6074A
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795266904;
	b=Ia156w63oobSltl0M20yfIdP4OOmHj7xCWmjaDcKquZHHbUV7uQbYCzj3rwVdL0SG7Ne
	 5G7QfntkIIjipxD6yI4o8NHEIYxanOt7vW6iTRugkb7dJCCs1HZTTXz4ceTH4p18CeINw
	 PpJo0jgCPW7WBq9ZMIIAsnHvOy731H6W+3KNLHMD1YnR41EzuvyBo+RiSWRal+jxLSdMf
	 zbi4HrlEq98FxAhuHiGhTqCzMMUwnWcQHvboX0bV3BF9DsRVCvVSqd4Wm9RKhSAev0U5s
	 nhHBqSYuNQ7pDdCO/B2hHVQPS+skH+A6eyQMQkMyawAL/LumwUFlvUzO8bw4hZBANeQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795266904;
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
	b=MznIzQU1JSEI8s6ukCzotZ8APWsW2S4ABjGfd8o/LNZkpUxKZl1Kfs/ZU/hKLVw8fAWH
	 lg4npb6ocO3m2QAoCl9zDRMWUZHLOfX9dAt/8DzPHOzhnuh7StiG0TwgV1IwW+7ef9QOs
	 xVrd3eeMaXX4+iAkJLDthHcRRDw6PNbGtL4KYru0egjVf7GPQKQ4yei9QzbGGBbF7gHS+
	 TCVH8u0gCFVgezQwQxMkl6omnaKqEk0g+uJmbFlnvCLEKc79P0E5LNUFMLU9RRdqLHcfS
	 +Ox9YbjjBbWjVSNrWBh9Ua+uh+Kopb8EnRF6dAXnOlBJZnY4bebvRGV7fzK+kRGGC+Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795266904;
	bh=cUCXB2Hh1KEVuBttkBHfzo9RbsDtI0CS3TqBKi/NtqI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AZ78eJbW7SEmJd8mygsPWn2O4SmGH/XnvrCnNYTMid5WQod2DsopvUnLipIiPKudr
	 why2QggbmZKc4BmHewaCQ4Dawg9d+4bUH63UHXPi4AijNx0atA04fNJU8AnLZjVfM9
	 fXAghIYt5KOBfFtvta0UWH9uRNkn0e5MjoGrYezEAzJzG9vZo6OkC2vhtMZ3NGn+F8
	 GW+XrzNIRr1m+7YlM/lyHVdIgFiaXZOD477Ut/OXxDj2o/2TvRW+PkIQQj2u+XAQrB
	 KSvfeT7+NDQe3SoebO8jZxgqOqcbvQ2tXC6BOT+gOTFFds0CD+xaIj5GiW2WMYq5qk
	 oaqWeGoMlDB/w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6E8CF6074A;
	Sat, 21 Nov 2026 13:15:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6CBAF9C1
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 11:55:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6ACD6400F5
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 11:55:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1O9AGxPDCcd6 for <u-boot@lists.u-boot-project.org>;
 Sat, 21 Nov 2026 11:55:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 7AE4C40012
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::62f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62f; helo=mail-ej1-x62f.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=MH+xZZ0m
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7AE4C40012
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 11:55:44 +0000 (UTC)
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-c50737c64c8so17766466b.1
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 03:55:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795262142; x=1795866942;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cUCXB2Hh1KEVuBttkBHfzo9RbsDtI0CS3TqBKi/NtqI=;
 b=MH+xZZ0mj+oZsNz0o8Oxr/LNOGa5bEDYKOp4hawzYD45XLibKKVWQw72CMvCPpmgRQ
 dgeMdx/L6COOxrQzshYru4pYQZ8EFKDRndc5S88bqqbtNF0v4T1Pju3s7Jicn1aElnW7
 XQZmIDC4k473GnVHPX7l/bRtMpuH/PIeWyMVpG83zXbo7c9dsQ4VmEa4sJRgaLOfKM1O
 LRWIyRTk9v5bC/qBJJO0avb6iqdlPqRyfSRc2RJ1c5VZ3jJGODJ3KGf5xYFcUZeeOM1Q
 VYRuq3a32pT3ulQVDkjkXaXdJ9dKFUOxvnmoHSeACzpa76JRmZcOJQaaGM2Z+TGN/uIp
 NJKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795262142; x=1795866942;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=cUCXB2Hh1KEVuBttkBHfzo9RbsDtI0CS3TqBKi/NtqI=;
 b=OWQmCqPGBcx9uFYzbQ+2XXCTwqQGy0vnqhUwafrl5FTEoUmW92wja3kmbXWZ0aYXoB
 A9y1UywdRbtGvD3V2M0chSpzMMedfeFDa4zT9sZMN40saj50k2A7p4kYl9ITMjGuBmfa
 YMOn/arQjvRAS8u9CzCWKYapQ0zIZeowyqtwCoOy47CO5xfvzusp3xrEm0ZxcjQLQ0RF
 cJ9lst9HRXymgQd+pQCcKHPGeBDx80CRn70izZTrvoGSExYW21u9e2qYHcugA4XKsOzD
 +gN5mV+lL0s9H8ybf7s+6u2rmDAQ5+yf1izfSSLUldqIEAIjpquQX3TZty76r3JTtXKD
 Q52Q==
X-Gm-Message-State: APuU4Z9D++E/eiwJ+CMmVNmcOReI6vYQMgFa9tBG5Ce84v01zROmC//k
 3Gl/u6iGM+z7l92y/21Nc1Lj165/ho1AIvBZYhsxYdAYuXrJ0DY7o+BpXGSj+GNgMzGkmAPBs/7
 d0MKC
X-Gm-Gg: AZFdTZdzW0NqEXhq2W3EqQTL8w36bSv/oj4Ut1rVaNykKTJdzvOUrvzokWEdqeWBvsO
 i5DgrLECLdumpjXgShD1QexzYPZj/juYqeXMopbALJ4pLQsB3KMD4gRMOZ5CuGRyeq5nNBfdvef
 90Zy/K32oO+pRwPuyFyPdU49UK6aQqDAoQB+23cvH80qvJ66KNq9b2BnExF0zUvdiQdx8Nh9u07
 9OabaM44KD6372GSlENIVJLqFif39mKnH/iLcILC0PcmJ4c9+kVUFSa2rZKzGjr5ECIt25/5R31
 L8RAaZedCSkmqNyFoHC5eExjlBrEw0CbCwrmTiCgdkdKmBO9/CccBn8oNDIFKU829AxjtGVyiD1
 M4VU6QaVj0XzF9Trb7Yrnzft3I7hHPDGGFxTYmJkrIJnVtfBv3Xe8A1ivLCEalsDXtJb8+3CjaB
 dXl937qDK89IX2vR/oZcFCHgubZiPz7NkLs9kMTow5rkzrQPi61y20IhaqrrDWX3+O4p05gj05j
 jnQkFrSLqi/unHVgjY/wy1BlOzzr7abMljJIkzjT65RLPBWgAwR2Axzpxrt9mEmRQHH+WuMiyRK
 avYoJubkQdvywQ+gfkigf/MRW4XlZnY7yR6cXAq1Hgh1w/Isds9mgdiLExI0L0LU1sneRyBIEdp
 x60ZuXro0MA==
X-Received: by 2002:a17:906:a11a:b0:c42:e6c8:e45a with SMTP id
 a640c23a62f3a-c513a5f7605mr511322866b.3.1795262142219; 
 Sat, 21 Nov 2026 03:55:42 -0800 (PST)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c513ae6780esm194960466b.17.2026.11.21.03.55.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Nov 2026 03:55:41 -0800 (PST)
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
Subject: [PATCH v12 28/31] usb: mtu3: fix up after the resync
Date: Sat, 21 Nov 2026 12:53:32 +0100
Message-ID: <20261121115335.548142-29-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261121115335.548142-1-anders.roxell@linaro.org>
References: <20261121115335.548142-1-anders.roxell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 21 Nov 2026 13:14:06 +0000
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
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

