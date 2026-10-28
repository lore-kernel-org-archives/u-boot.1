Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4030E606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 14:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=RU+EbKBC;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Z5eWZ+Hk
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1D223408F7;
	Wed, 28 Oct 2026 14:48:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RzZ2-rBwwu7p; Wed, 28 Oct 2026 14:48:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 57C814087B
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793198920;
	b=qV5TIj5lgWfRAum3FVKlNyYTrLkc8++Eo9cHQnE7eTFJY50muEB9derrivsmT/QpRML3
	 Cybv3MmND1xXkk7IzEibXHk4dXFZ5AWG6lgbNsKBAfoxq4ZO9k1pjN2M4t3xgEpZyG+92
	 RFnPuUc5AJVWZj11WvWy/3SLv+dUdiQWD6m0blAFN7oo+voSVpA9tgl2w31FMxCsJHomr
	 bBUBOhLCW8pBXuvaMhfuOkByfNQ1xKMTjjqoEG7e/Jj1mUY66kFd2ysQjtx+yrEznzLFj
	 QuHMIoBa+ZqnAr4gebMxJw7ABx+x74m7XbWTV+NOyAjULqQsABEttIn36ijh61R3ljg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793198920;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=3SFnx7mHEBtVl8L5Ja4985xmjxwacWTdBthYAY7xw2A=;
	b=LtbOooIEbJXBUI8hEHOFrHbJpAsuz/X2LV5SIsNd0DWizzb+joSY08niWiOlsQKRtMoC
	 kQnc7sE0HlBnCqY0edPQJoMmWeiKkl9UQ5LHKa+ktG3DQIrOpu4fKCwj9KJogwlMowuO7
	 mVpoRkpyLocBmBoo5pxSyvoSnI9wTOh1UOeY+RkD5Hz8mMID0nL1x+bse5V/vZ5mJEYcn
	 aiczcQWMpVCYt5glyNYBV8+nUdc7oaBsUNQzZGMpgSuj/QInVP67ASIiE84Mx8+me7unU
	 Z4+WQOyPzYMv+dtJAFlaKTaF4EfODYzZ77MoK9JuMVR2rR/pY2rgtBF9X9kszySqzdA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793198920;
	bh=3SFnx7mHEBtVl8L5Ja4985xmjxwacWTdBthYAY7xw2A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RU+EbKBCaMn/iYCkjJUGp0+O0lCppMr/tRHe3VDQKFrlrnpTlV9gRErJJPNnak9jI
	 YqTIsdfWkImt5MMMipa7BmXYGdlRc4JX2W5lE2r2cJTgbvV7Yx61GeOEebsFtzITLI
	 Ma6NQDXQ6nuDOBHDgQFZZ06nA4mMQGRdJ+Ls1Mi/8RQHMRus3Bo7/KkXa7puFMOiJU
	 MZC71TtrWMaTmJ0TJwva8unf6CP4rIleAeS/Ne90bvD0gGGMjUg3li7lx73j0LVfiT
	 g4XTF8CkA71zOPOJrnGTqGSuEU99OFJpWb3yLEDQ6fTI1L/lhLn+3OZqknXIfbfHHz
	 gKF5XfN3xN5Xw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 57C814087B;
	Wed, 28 Oct 2026 14:48:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id C120D235
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:17:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A54614009E
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:17:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iwyAj1JniDm7 for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 14:17:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org AB8414008A
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::62d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793197066;
 b=ONBWob6S+QFDkU4dbuBQz0lVbKBrSGSo196jgQO4mjQ+x0AEkei1hjIUWXBEyhe/kwKA
 vlBUfjGyhf5wsHQEDOF3EKV5nY1pb5U5y7N8lexgGOsHQspsP7ZOPz61q/GP2I2NWUpvO
 ZYGOBP05pgHVgPhB8cC0g/MUUovFJxtBq5BX6l02Eug2soD0Pngc3hIRhR/B1DnTSsEFl
 SDQO+mHfoDgKmHOqzpAjRnoBjjU85bKjnr63Q2PQ93kz+lk1NtLr0V6k9kuByNvkT7Ou9
 +PzPXuv6eHB9Nc0UPxNCpIAqv8mQCqWPvgoD7LlZioV/9Sx7V1V7ELq/sFi1Rb9KrmQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793197066;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=3SFnx7mHEBtVl8L5Ja4985xmjxwacWTdBthYAY7xw2A=;
 b=kgh5KNsGi4x3z02VIkFkY5EH3UCV5jEH54WAil2l5nmeWa/TTuAZ2XIo4u3Pe8Qzb3Bn
 wzQ5KNmFcUqryvxZNKkCizyqTqj4R15fTZZyuaIZJITL81yu0GAZU8VkSkQHWLkYSSUEE
 SzffaOuUpzlrbrile46cXro+PvmDNQpc3LH26mZNT+Oy3D+wOZ6h5mPBfJbcXQ15fJx7a
 zly0h6kV+5LgU47LYoXd8z9dIp7UoGP2JKLYnuk69C+PFp9aOxZeMAO/kWZDGD+IFf6D5
 a9dn+sQP3dfHUrUVrOUt4DUCUoql8t9NrSt40LNjefMkwbk1NhBfiD9UR7vVpsP2itA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=Z5eWZ+Hk; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::62d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62d; helo=mail-ej1-x62d.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=Z5eWZ+Hk
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AB8414008A
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:17:45 +0000 (UTC)
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-c40aa03a96fso11312866b.1
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 07:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793197064; x=1793801864;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3SFnx7mHEBtVl8L5Ja4985xmjxwacWTdBthYAY7xw2A=;
 b=Z5eWZ+HkVnCZYnpi329WNA+XUJ4O5N4ClipbGt/Gg0FCO/jXLW6+2neIkEx1rOKUS+
 8dGLAMkBeh2aL/tOqZSasdhH9qJZxerUC5bDIO5IPKnCT7nemn5WGpM4PgNIbNrg75CU
 Ag3wsMnnax6LmESePJkCGUdc4EPWE/EcRLm8kPJOpZXP36YNvee3wfcSAZcaoaGfQHTm
 gtcBLVsd+3cP9nPFceQAjHs8wMwAy8dQ7b7SAsR/2sG8vvUMxBrqxfi7FhPxpvkfg/KE
 XNl//EVcnLEkh4HNKaJPk7uvO6Sa/9FhTZYShVc+iFOPWfRjfRbYMoAdKrxpMK9p5W/p
 RyKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793197064; x=1793801864;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=3SFnx7mHEBtVl8L5Ja4985xmjxwacWTdBthYAY7xw2A=;
 b=IXdEfepKLWqfh3BCchbE063WsHOEiFWq1iUFyAm0syx8jc3EM2kD7j1vZXSSV9fUXy
 ghR3ribVv6SJDO2L4BqFVVcOJmaPTj5Vy9F1LMHlmbUQnNWMEUwTDDV8ko6o4yN66On4
 lc3x7kNH4d5pHjHlMlM4C77srj+WCr5Vt2iHiDKse1VfgomSkHRYU+Qx6SClqqx5vygX
 Q30Y5AXf361eUu2hqUxONmE50OhRcyT6bEiJ1j9bB2N9tznqHky8eyvbl/AFAcHjnqEr
 B1USozCo0rLBE/VONai+k34/JYrbQQS8j7HErt9Ru3lOQPrZwyXnISJy5r9mj2Jr7kYu
 tEMw==
X-Gm-Message-State: AFq9FYL9vipADgRxYQib+Z/n0xdkTQkSuRDadSlYAchRRK50Br1QsG1/
 L5aoTlpn2KiFihL9NMlZLmNjqKpxZCRisVV3szdG4OZmQ0HjZ3WkPYLAbmUHPmMUGRTFNZanoF6
 /KcpZ
X-Gm-Gg: AYBFou37/fbA2F2Csv4reCINHLmNN+RfgOSZ/lfa7twBk6jb2IdpcYHQF0mb/rEwKCV
 XvG8d4qzKDcbzdtBSuYScFMlGEI7hNBrfCKSec0d5VK4vRjhjXcWks5SXYOhglx1wteyeNVS1D+
 UrGOmNeSQTOZu3wqTptpqBlLNqia8ECBzoHLGBKrFmX0SO0Hs5T2uaOzxExK3Oq8SIWdN8sWfG5
 FnkfwZi0TQKlYKi89dbxAEPcNPE6NaFcR1CNT8wFugBFovkQi/DNJRveG8zFf/pJ5mX78Rw/Wbz
 FsY4dPc3HHAwJehGHFOnKLfZJdPIdtWovcuvF1pkDSf2oRL+u8hB0YFWXJ11XjHi04JbHoqGfWy
 S4Hu7SPbyrePI8S16saJF0kvmji9WT584eDWNtZagFodGXfF0c90+a3lGVAkol1GAlVnXfOEydE
 6ohx/E0QracO8T2nw4Wj09DXBcrf1gek8Oe4pfMaIfuGfGl15j8CKmEFEK9RDazYdYFdlTo3TGP
 8xr3lrpXaJIBuHj2oue2YjRV00ywanVQ+/uGz55JNlkCSjomDiI5gFZZKEMUPcuns0oh/rjXBDf
 ceypFBIWWWj+myGtCNVX1N0K1OrsTnlABvRWkazxHq3+Gea82VJ/9SgBmc5l90olxQZmOFIo0zp
 RRSJQlFqYDA==
X-Received: by 2002:a17:907:2485:b0:c32:8cbb:fac with SMTP id
 a640c23a62f3a-c49bdebefe6mr222199566b.3.1793197063537; 
 Wed, 28 Oct 2026 07:17:43 -0700 (PDT)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd0f6f1asm618675366b.0.2026.10.28.07.17.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 07:17:43 -0700 (PDT)
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
Subject: [PATCH v10 24/30] usb: musb-new: fix up after the resync
Date: Wed, 28 Oct 2026 15:15:48 +0100
Message-ID: <20261028141554.3073545-25-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261028141554.3073545-1-anders.roxell@linaro.org>
References: <20261028141554.3073545-1-anders.roxell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 28 Oct 2026 14:45:47 +0000
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

Adapt the musb-new gadget code to the new gadget API. udc-core has its
own usb_gadget_register_driver() now, so drop the local ones.

Co-developed-by: Jerome Forissier <jerome.forissier@linaro.org>
Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Co-developed-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/usb/musb-new/musb_gadget_ep0.c | 24 ++++++----------
 drivers/usb/musb-new/musb_uboot.c      | 39 --------------------------
 2 files changed, 8 insertions(+), 55 deletions(-)

diff --git a/drivers/usb/musb-new/musb_gadget_ep0.c b/drivers/usb/musb-new/musb_gadget_ep0.c
index 25b1de6e58f9..726864aa7979 100644
--- a/drivers/usb/musb-new/musb_gadget_ep0.c
+++ b/drivers/usb/musb-new/musb_gadget_ep0.c
@@ -320,51 +320,43 @@ __acquires(musb->lock)
 						goto stall;
 
 					switch (ctrlrequest->wIndex >> 8) {
-					case 1:
-						pr_debug("TEST_J\n");
-						/* TEST_J */
+					case USB_TEST_J:
+						pr_debug("USB_TEST_J\n");
 						musb->test_mode_nr =
 							MUSB_TEST_J;
 						break;
-					case 2:
-						/* TEST_K */
-						pr_debug("TEST_K\n");
+					case USB_TEST_K:
+						pr_debug("USB_TEST_K\n");
 						musb->test_mode_nr =
 							MUSB_TEST_K;
 						break;
-					case 3:
-						/* TEST_SE0_NAK */
-						pr_debug("TEST_SE0_NAK\n");
+					case USB_TEST_SE0_NAK:
+						pr_debug("USB_TEST_SE0_NAK\n");
 						musb->test_mode_nr =
 							MUSB_TEST_SE0_NAK;
 						break;
-					case 4:
-						/* TEST_PACKET */
-						pr_debug("TEST_PACKET\n");
+					case USB_TEST_PACKET:
+						pr_debug("USB_TEST_PACKET\n");
 						musb->test_mode_nr =
 							MUSB_TEST_PACKET;
 						break;
 
 					case 0xc0:
-						/* TEST_FORCE_HS */
 						pr_debug("TEST_FORCE_HS\n");
 						musb->test_mode_nr =
 							MUSB_TEST_FORCE_HS;
 						break;
 					case 0xc1:
-						/* TEST_FORCE_FS */
 						pr_debug("TEST_FORCE_FS\n");
 						musb->test_mode_nr =
 							MUSB_TEST_FORCE_FS;
 						break;
 					case 0xc2:
-						/* TEST_FIFO_ACCESS */
 						pr_debug("TEST_FIFO_ACCESS\n");
 						musb->test_mode_nr =
 							MUSB_TEST_FIFO_ACCESS;
 						break;
 					case 0xc3:
-						/* TEST_FORCE_HOST */
 						pr_debug("TEST_FORCE_HOST\n");
 						musb->test_mode_nr =
 							MUSB_TEST_FORCE_HOST;
diff --git a/drivers/usb/musb-new/musb_uboot.c b/drivers/usb/musb-new/musb_uboot.c
index 43ab3245e5c3..16907c4681bc 100644
--- a/drivers/usb/musb-new/musb_uboot.c
+++ b/drivers/usb/musb-new/musb_uboot.c
@@ -383,45 +383,6 @@ int dm_usb_gadget_handle_interrupts(struct udevice *dev)
 
 	return gadget->isr(0, gadget);
 }
-
-int usb_gadget_register_driver(struct usb_gadget_driver *driver)
-{
-	int ret;
-
-	if (!driver || driver->speed < USB_SPEED_FULL || !driver->bind ||
-	    !driver->setup) {
-		printf("bad parameter.\n");
-		return -EINVAL;
-	}
-
-	if (!gadget) {
-		printf("Controller uninitialized\n");
-		return -ENXIO;
-	}
-
-	ret = musb_gadget_start(&gadget->g, driver);
-	if (ret < 0) {
-		printf("gadget_start failed with %d\n", ret);
-		return ret;
-	}
-
-	ret = driver->bind(&gadget->g);
-	if (ret < 0) {
-		printf("bind failed with %d\n", ret);
-		return ret;
-	}
-
-	return 0;
-}
-
-int usb_gadget_unregister_driver(struct usb_gadget_driver *driver)
-{
-	if (driver->disconnect)
-		driver->disconnect(&gadget->g);
-	if (driver->unbind)
-		driver->unbind(&gadget->g);
-	return 0;
-}
 #endif /* CONFIG_USB_MUSB_GADGET */
 
 struct musb *musb_register(struct musb_hdrc_platform_data *plat, void *bdata,
-- 
2.53.0

