Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C6F606A31A
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 06:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=YlfQp+u+;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xHiob3mY
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2E66560ABD;
	Sat, 31 Oct 2026 06:17:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ijk-SykC0SKv; Sat, 31 Oct 2026 06:17:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 447F960ADA
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793427443;
	b=h8ZmuX9w42JrhEHPfTYTr9ufnvyGfh58pKgjPE8tGPV9yZuMXiUIdxzMj1+2i1zXJJJJ
	 1FNWeGgeXyU3FMpZ0vHfooautFxY8nTdsbjsWUfq0VHoRtv2xaGfaTcqc9VQBPinhTi9e
	 3Wyuj/IZdoYSoVpmLt4eXiTQ4D38+m7WxOb53+WDhfZU69hY1njoxrs4Wxx6f3IhGaCyu
	 3HUmwYPkK08sdgE3TbeU2IWGsmG/bpzdoaKdwscuLGEy4UGfoFOn8LUAVdXITdVeS7Gau
	 R1OSnJbK30WQYivenD5LjwHicDLQzUtJ4dPdW3Hm5Q7Zh+yXCE1DcITYaqt/fLu64Ww==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793427443;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=JXA1G3sUpdG9N2Fu7XbldIpAtcpIuRGvE9B6IZD72vk=;
	b=WWxWshnKqNTjC2eP+BgQiPCwYjzTxMJqt/XAXL5nS8qX3LZBqdcblRYan8XkbwdUb6OU
	 mGNOuwQSaKeV/U5rJwqnhQ11NFQeD6sjcnsN4aIoMloqszzeGepUU3toHaT55AXhBOPMo
	 Ew7uyeBRenx60f96C1r9tMR47Rk56zFik3QPrxEW4iDZiSC3aeK+sY3Fsgvkkb+89Mt62
	 gpSy35A6dM2cMq8vCqu6JjxJ8EeGcU2TN1fL/jhQXnQlP6q6B6xlxeIoIyoFh+sH8Z1md
	 A7lssk3oJOuNUWPXQlAWMAB36P0ZPVRaNgzU9OhfWHZ6qsLb7touCDpM4b5uK0Lhd+g==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793427443;
	bh=JXA1G3sUpdG9N2Fu7XbldIpAtcpIuRGvE9B6IZD72vk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YlfQp+u+RPo1i/nQ1bhle+YEXtpOknhIRvbQzcWJF66N/1HIoE3JDx8RzaxtYyqBA
	 9QMuk3Lq3VqJLL6jWMMdlMdjutt/O/nYxDa0wv185MBZPZGbLlBgSLefS35QzaKAtn
	 5Xe1N1pME/SvULYODf9ixn6SgKypAHwoWU+CwS8WyGpZvHh7mFp3F5y57fMZla8CR8
	 HvHvGQ8Bl4kbG3pxTy5C0lE39q9hfmLRIihv0V7RSP8owdfM0lbYsIFQkZoYSFEVxE
	 UlD5CTgdSjC9Y26EqETRNjU7CYr1fBTdKI2a7eCyOc8qLuYdncCl4iQVU3frxQCLsH
	 T26ZqBs/ItvvQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 447F960ADA;
	Sat, 31 Oct 2026 06:17:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 5A060235
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 06:17:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3FF4140574
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 06:17:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lU2Hhm2FiWFb for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 06:17:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 4A3FA40070
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::429"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793427441;
 b=GIKKT1ULdd5HpiqrCyaXvYzquP+5xrZoyO4gnv78q7d85Rcq8O+1C56/YctrPRAXR8n3
 Ni32bvHCMCq5aDAY0pdssYXMIzxACLiphS+KuEorD8u181KG8qA9zhj8L3ARa3P8PWHaC
 TJJNEiGdOqYPDIWe45nGztkDKy1O7+gceZMN9JzbWy4QsmLZS1QJLSfKzT7Y0Dt21Hxun
 jBe4ka4TkUjvSJ2INnGE43VFkFYKZoaOX8CVMguh/yxnCf/qq/ij53XV9fF0an9N48u4E
 ITaZInw/h7DHtXxuqKflYMDF4xnhfTyRuUa32UqDVuax7oL3cGHyqo/jL8fgvYn7XHg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793427441;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References;
 bh=JXA1G3sUpdG9N2Fu7XbldIpAtcpIuRGvE9B6IZD72vk=;
 b=iGNsLPpgk1jtEMYQbdEw2PvNvnlNivYS4SsEhMjPG+OB6BRRV/vQrUmVLwlHpzeFm0ta
 gXU0hePR16p7oMomaj9jzKA2LZTzCRhuyZy1fIMYXzo0ZvMVE2KDar22SA0iZGmKCTdoX
 awgA8hrZb52Kr1HlTBkGEbVPQC9lg2xiDIjwQZdUAMZKxrERcDdzFkhys5chGivEVzaoG
 RDmk0l9nyP/OqebHu9oBJGfOqMQgpq+SgZlmjob/SVT4AgZ19Bfy9jBG5EnDS3Re2w/1y
 P0DunvIwgZYtq82Za4WaZMgDbU2RsZ3mt8UqQlHnPYlt4FOuRpxl4y95pBTB8lRu2zQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=xHiob3mY; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::429"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::429; helo=mail-wr1-x429.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=xHiob3mY
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4A3FA40070
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 06:17:20 +0000 (UTC)
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-48af4d4e61fso771828f8f.2
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 23:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793427438; x=1794032238;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=JXA1G3sUpdG9N2Fu7XbldIpAtcpIuRGvE9B6IZD72vk=;
 b=xHiob3mYN0WLDVggXCd8N4DkYwKBMYBk2/61QY/ICumhgY3p/xPKWg25E/WxjvJs+r
 WwV3VYv3Tfww4Y68zNv2OvaVT2hM0MGAIb7MAJFp5ueCvcgsjBAJNaHHbtGhj08+Gig4
 hVIUz5zvXcK+XUU73UfKLqUfWfOAzuTYP1yIrqOu2PWaLUNCYzRw+EXsTqOuPkie0wy1
 p8tR0KrOEYA/2oN42+qNHRshKTyEeE7vUEoB+oD8h4wT8da7HvlKRgfnnPCurzcBqw8b
 EHqRvkzPk+oKXbRY/DWxZGA4NcKyCHXXm7PljbVm1Lxk6/YrH1RelgGjO8rxNZD86vN7
 5byA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793427438; x=1794032238;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JXA1G3sUpdG9N2Fu7XbldIpAtcpIuRGvE9B6IZD72vk=;
 b=PUC0Q8aeIwGtlgL5esfrIXwM838PbceQpZhN2JcUAVdBhK2MyQhutIDP/jhlxfMdy2
 v3WZ5UmCBquYs5tTlpqvUDBUJ1DQsv0wDaw1i/BCgVbc1DM/wKc26gzTqRlRzL2jXbZM
 TxtxGgHz9kIGAJZm4saTkH8U+/VhOAnU3Ua+g1ieH1fXrS6siFLCPCH6E7zcYfCceaUr
 u7DuAKxLphpneUYi1vi0kYuyRGzbofSmhchGefyyNP46b8K7ZZRux/Fl6aHV4i4fj1uD
 2j0fwVj8H5wTK8Jj6+HdapwGWWh0PaD6CBghUtbrf7bsea+dAdKnySs2ZRLwGDU2B8ok
 p9lQ==
X-Gm-Message-State: AFq9FYKcw79XZfekHiegYaMQpEicUx0ttWrVeaDhuTd79470Icn4/Q5T
 TLSb16Q7HeBOgP1Jazax2hn4tOe2P1yUReeN1q9Lp2PYyihRjfnSWlqS
X-Gm-Gg: AYBFou3LeHi9a2GliCPVINiv1ft2xcpaOeqrtO6xFpvIkBEpC8vqfBNSg/R2O0I3jl7
 iRXFZog97dV5KGbWgvrwb+J4IKVQ9OtlJ+5bBPpkvMpu/4k6aWvbe7D6lm6h3Reb+zX+IzrkSsV
 6cM6UaV3MMwRiQVpJlCrQoROyZAAMzEe4JyFEaq4bUOZbhB/pmlOvi5G+yJp+Y0tFm0qTOmUklk
 DRzNjZNubQBwaGs2J3sgyXadh2zDyQF2Ksc69K0hxAzBeDI7CPi8SSldCB2W1xOVqkvJR++XApw
 OHNGkSvSB9t5COTrizj+x6LPHoLjU2ZL4D+zwgI2DTUU7Ju5LBWxo7ttL2PjhCEMpcGro4tZig1
 mDHi+cbWNFQ71/01gARO2tsPluqNk+Cyoz0iyqHYuMJNhSeGK/pBLynsQjiTThjS2+20LU09aUv
 +C1bG3W3DZb3vsjo9Gk+4pOhMmfpyGmoqPd62YZjvioV1IrVHbCxIm0NeTzrISPghHvbv16XqDC
 BjXJuGGoXfk264SCy5KT7SVrN76dkQjYcyTdHDkBLOcGW/W2jvnAQ5nAYe22sI97Kx8tO5Fa7kf
 htnCJBiHpcsSQEE2U3a95vf6adJM7hs=
X-Received: by 2002:a05:6000:2085:b0:48d:f237:df09 with SMTP id
 ffacd0b85a97d-48e6e2ff044mr10038635f8f.21.1793427438051; 
 Fri, 30 Oct 2026 23:17:18 -0700 (PDT)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b959c1sm7114914f8f.45.2026.10.30.23.17.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Oct 2026 23:17:16 -0700 (PDT)
From: Ana Bobillo <anabobillo3@gmail.com>
To: Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH 5/6] usb: skip endpoint descriptors for endpoint zero
Date: Sat, 31 Oct 2026 06:17:15 +0000
Message-ID: <046d674b-30f4-4972-b340-120e324bcb91@gmail.com>
In-Reply-To: <57123e9b-629d-49d3-b500-095503129ed2@gmail.com>
References: <57123e9b-629d-49d3-b500-095503129ed2@gmail.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

From: Ana Bobillo <anabobillo3@gmail.com>

Endpoint zero is the default control endpoint, which every device has
and no interface describes. usb_parse_config() still stores an endpoint
descriptor numbered zero like any other, so it reaches the users of
ep_desc[]: usb_set_maxpacket() overwrites endpoint zero's packet sizes
with it, and on xHCI, xhci_get_ep_index() gives an OUT endpoint zero
the index -1, which xhci_init_ep_contexts_if() then uses for the
device's endpoint contexts and rings.

Skip such a descriptor, and the companion descriptor after it, as Linux
does in usb_parse_endpoint(). Add a test with a device that has one,
which also checks that endpoint zero keeps its packet size.

Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
---
 common/usb.c  |  7 +++++++
 test/dm/usb.c | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/common/usb.c b/common/usb.c
index 05502da6b30..619132512dd 100644
--- a/common/usb.c
+++ b/common/usb.c
@@ -466,6 +466,13 @@ static int usb_parse_config(struct usb_device *dev,
 				break;
 			}
 			if_desc = &dev->config.if_desc[ifno];
+			/* endpoint zero is the default control endpoint */
+			if (usb_endpoint_num((struct usb_endpoint_descriptor *)
+					     head) == 0) {
+				printf("Interface %d has a descriptor for endpoint zero, skipping\n",
+				       if_desc->desc.bInterfaceNumber);
+				break;
+			}
 			if (if_desc->no_of_ep >= USB_MAXENDPOINTS) {
 				printf("Interface %d has too many endpoints!\n",
 					if_desc->desc.bInterfaceNumber);
diff --git a/test/dm/usb.c b/test/dm/usb.c
index 145ce79dfec..4975a952d87 100644
--- a/test/dm/usb.c
+++ b/test/dm/usb.c
@@ -574,6 +574,42 @@ static int scan_port1(struct unit_test_state *uts, void **desc_list,
 	return 0;
 }
 
+/* test that a descriptor for endpoint zero is ignored */
+static int dm_test_usb_config_ep0(struct unit_test_state *uts)
+{
+	static struct usb_interface_descriptor interface0;
+	static struct usb_endpoint_descriptor endpoint0 = {
+		.bLength		= USB_DT_ENDPOINT_SIZE,
+		.bDescriptorType	= USB_DT_ENDPOINT,
+		.bEndpointAddress	= 0,
+		.bmAttributes		= USB_ENDPOINT_XFER_BULK,
+		.wMaxPacketSize		= cpu_to_le16(512),
+	};
+	static void *desc_list[] = {
+		&vendor_device_desc,
+		&vendor_config0,
+		&interface0,
+		&endpoint0,
+		&vendor_endpoint1_in,
+		NULL,
+	};
+	struct usb_device *udev;
+
+	interface0 = vendor_interface0;
+	interface0.bNumEndpoints = 2;
+	ut_assertok(scan_port1(uts, desc_list, &udev));
+	ut_assertnonnull(udev);
+	ut_asserteq(1, udev->config.if_desc[0].no_of_ep);
+	ut_asserteq(1 | USB_DIR_IN,
+		    udev->config.if_desc[0].ep_desc[0].bEndpointAddress);
+	ut_asserteq(64, udev->epmaxpacketin[0]);
+	ut_asserteq(64, udev->epmaxpacketout[0]);
+	ut_assertok(usb_stop());
+
+	return 0;
+}
+DM_TEST(dm_test_usb_config_ep0, UTF_SCAN_PDATA | UTF_SCAN_FDT);
+
 /* test that interface and endpoint counts are limited to those described */
 static int dm_test_usb_config_counts(struct unit_test_state *uts)
 {
