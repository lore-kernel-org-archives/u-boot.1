Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7AEF606A31A
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 06:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=LDTZhDMj;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RFWXKy1Z
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A0ACB40B26;
	Sat, 31 Oct 2026 06:17:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3WMFVtCnmzGq; Sat, 31 Oct 2026 06:17:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8497440B0F
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793427436;
	b=a+k31U4uBjxsqstelK5QIT+wleRyg4pUl7UxFAjNUriDsACbIHEBugDtn3lGLQ1zON6t
	 /Tv9TmLAzPngcuvAOmxwXMaImPxAdc8c1lwSIPqQeDpXkzDQq5TguMSva6jXZIRk+YldV
	 7mgx8dOOAw3qEwB6UzZtkXcK2d4swNBKh8Sg4USdZTpHjcX//FMUNdm3D8/g1+CPKFRNu
	 GKEqnOeyBkL6vECbm9hUgVTLVdJPnZWIWpKhmcUh9aCqzQwn+SVeK19QGQw9pjD0yUl93
	 uc1HXCu52iMHi8AauCRXygWglFsk0r6XksIu8HnnoEpuMiEFVT4fnEG66XIs/jaQwcg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793427436;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=oi2Tk0uotxkqR/D/qXmq1u0//kJQBQoasSukR9IO+OI=;
	b=AeszXWm5dmmUAeoa3NelDDCa1qzkmB8Q7/ZuZnqpYB6SZKgbmqqAigV4ucxcEl4mRQOP
	 jWYB6BWrRby5/v2bfFqJJioKuCgTyXgZNVO7ot70ELbSjQ08L/OE7mwgdLYDgnfbQqwSg
	 0hx2xmwuZ4yGMBnQ9IiP9yaUqLRCf8GoD3b0D0fTyUHOUJOW/LzJ91QmY/nVz7BiZ1yrA
	 NX+WbQLd4sbRAGSajomz0UAL5Qep5L5NpGNlndMiis14ifByyrQcufOT2iUBbXZqyvu3T
	 0mggelYBVv1osHEpopNU+Y6B6l2FzIgOLa1070pD2W81Hdu3BimVIVF7g1S7zaGqaIA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RFWXKy1Z;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793427436;
	bh=oi2Tk0uotxkqR/D/qXmq1u0//kJQBQoasSukR9IO+OI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LDTZhDMjCoOt+YmAuUUgLwr06g+8LZGeNRJ+/PX1SdOkh4QyVZ/UciL/Hfr2zhqrW
	 4vbDoE1B1ryMO9z/WjdfIpjV434bu6whGi5njOFwALRhJ4Ha0659KF9JRDPvMdaAYR
	 x7NnwT9A3G4FtGgve/rAhGuhUaheJ0EAH0R2x/OeENJjvnVJpeykKFj9KqD+Gn4kah
	 Szk5KctgM/4AbhM64+5abgMEWJHLSTEWHxDtwR9MBEfJYwJJ92NL06Mfan2oqcBCI5
	 YCQOSWmBvl5QrVBka5V3tDZZFzwWNc382YozIvAMBfWZGaX8+kNgW60kj0fCukdALh
	 WFche2nMXLUNQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8497440B0F;
	Sat, 31 Oct 2026 06:17:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2F631712
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 06:17:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1233440B0F
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 06:17:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8-O_UaBo-930 for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 06:17:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org DE43140B0C
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::335"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793427434;
 b=KENMbVM0rPNRXCUQ8mu76+ejkUb1ylla9qSCuMpB6r8V9JBsth5xAjjjRaJpIu8Sgir+
 7HZgEPke/krQhsNXfntGlWJ9vG83iguPm2gxjk7jO5Y7/A7zHqv4AhUj4+lxWUxkGpyoh
 Yu8FASDAK/1/TuoyZj+YAUhsQj/dacxng8AeFRWYoQZGJbugoRuz6kSILzSHJUcTRT4SL
 f3w+deoL+BlVwz1zAT+nsBAD+1dedqod/QDetOvYMoAyFsfL0jXa5bCoFsCcA6/u2nb6Z
 B2UnnDtxJFVH0su6wQwyaOwLnAJH9xnPPnhOveP+gImJnp2TKx7U3BFPUDqzygnrh3Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793427434;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References;
 bh=oi2Tk0uotxkqR/D/qXmq1u0//kJQBQoasSukR9IO+OI=;
 b=n541+nwq7GGeoPw7zhlIqY89WuNVfYEv17c9a+joJJozFjcIsQcrcpj3bt3VUPXbKZNJ
 4WXYX9nStPJip0xFjnvmMsuVYHM5wPjew/BpAkLzG82oGqthM2xpdVn/AxWfySYP8KVRQ
 ljoHQ9o2q12fuZIbQwSpXB5BJ49RdLbnby6cvLtXphutExmL5k3yVwp5gk0AC1XyWJsmU
 yz7mvucPFmgRBaATh02Dp0pCZgueK6T2kLJzSS18vb1c8Z+NZKUJDTm1A1qlch2rWCJ/l
 jDpi9I5mgT3I5ZJBKhZomKHZV/MObZtSUaCc/AF2HgmtZDJSoiGHQ31EWk8lwNI53iw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=RFWXKy1Z; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::335"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::335; helo=mail-wm1-x335.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=RFWXKy1Z
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DE43140B0C
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 06:17:13 +0000 (UTC)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4a214c5c4c0so11865005e9.3
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 23:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793427431; x=1794032231;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=oi2Tk0uotxkqR/D/qXmq1u0//kJQBQoasSukR9IO+OI=;
 b=RFWXKy1ZdJP1IrtSbIqq+BVB+eZpLR4wX6cLvtB9blWVrVxI4pxIq2KuWsDV9U4v9i
 4iXM0FPSmIf6r+PUdHloSYEB6HD1HIEd0utDn3AAy/2We98/39+rZyLrNSkRLfxjjudH
 hXE1PDvw8IXudFkijqryA4end2sfvcWOaPM8TAlXGIUroM+xDSnBGuuWoNYjJbWjJK8N
 f+IOb1JnHtzWwXif3wrofSGoR8lJ2EK5RkZ5E/pdC2WLiM4q/J4rJ7euow8okC47Bnif
 qWtXYwEjuejC8U9QY3s7+8bguw6seQ3FUh5cIzTI3sdTKY+2wP0R9QJ70+KpaNzx1W4B
 j7aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793427431; x=1794032231;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=oi2Tk0uotxkqR/D/qXmq1u0//kJQBQoasSukR9IO+OI=;
 b=Ps7T+z3KbrGLkchWWb5EVNLsrpiev1Xsyjlidb0htx3WRGG3Mr9SKfmMHXkWfP2wXd
 ltHFYP9oNpbgVan/BS9yeZg66f1VioznYzP/Mn0bqRRG9EkPJBiDhqPl2v7cpBWdlUkR
 FrwXbaOKj+16wo/2c2Ep670Od6d0rAL5hrgQHFtIEViPubRyR5uHejuvbq35wIpG/Vx1
 tdxxatbZgaErXiBmA4aGfn29b6XZkxjxtEOFoCYPIyr7qxXVsEDiwzXpyb+zzljCC0AL
 TLRkVMeBBn2KooDGKzAhoHziR76L4WVWEZG1e3xuLnVPfl9FnhA+mM1CJtKTgTKGVIkc
 kCSg==
X-Gm-Message-State: AFq9FYJLXSM7L21nucRFglIq1N8LKvNdEUslYYxK3WbWmxJz3Z6xKInS
 z7HWm0To5PqFtggGoxtvEYWxH4EYmd0kYSeeCFqcObeOKNAoFOutBzyB
X-Gm-Gg: AYBFou3rrKmJBwh9pHC5XR5dycch900U6AJMVMuHHVMCzLPJ+dVD+ngFN6SJVY3p428
 rIj5ZBjOtsRnpxvx8vjxRdNbUowoXQ6nmaHtqamg9u2nRf0HVvCt8mwnA+ytaskYwC7YmHwsEsE
 OC515hAopdsXh1MYvFlzfWaxZK2JFY4b4Od94OtQaLPEmL5lKNPC+zp6NoR5y58XrIcu84EciEf
 pcebQKv9uE1h0uFHChaCPLVFb0nja2LHy7FhgiWWVeFgc5mXzd8T7O63wps/jkuRTQtkZ6RotSq
 swwdJC9bIMuGuTlDSyEEVFuTboKjlLGw2JTIZbE4f1mlDXWtelx0OMdvg3Y78pFUxCfSzVJyGXC
 T8lrDZ5lGgudUo49vieOpIJMeip2L57VHebpZzhFi/H+ebymnN+11h/XZlaRvIXNQFPYolzq/S/
 UFXso0ZnYludg0ztS8TbdHb3AQAdvnbRUOe47HzS7dpmEFaFaddjat2sWX32a9JUqc/CCfgu4Fv
 rhdtau84DK5lrktfpgPWpZ/Dv5ZHPkiZDGrUV9MUNzRThoPlBV+ugm8+GFKEFHHujZiVRAdMhkV
 P64RQ5P7GlEoLcIr6uHcPmaOeLT+MV0=
X-Received: by 2002:a05:600c:a00d:b0:4a1:83f0:7c91 with SMTP id
 5b1f17b1804b1-4ac185bc336mr97285035e9.18.1793427431471; 
 Fri, 30 Oct 2026 23:17:11 -0700 (PDT)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa80f04723sm209567635e9.5.2026.10.30.23.17.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Oct 2026 23:17:11 -0700 (PDT)
From: Ana Bobillo <anabobillo3@gmail.com>
To: Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH 4/6] usb: keep interface and endpoint counts within what was
 parsed
Date: Sat, 31 Oct 2026 06:17:10 +0000
Message-ID: <88b3752e-2712-4e1d-9a31-b95c7dfdb699@gmail.com>
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

usb_parse_config() stores at most USB_MAXINTERFACES interfaces, with
the endpoint descriptors it finds for each, but leaves bNumInterfaces
and each interface's bNumEndpoints as the device sent them. These counts
are what usb_set_maxpacket(), usb_set_interface() and the class drivers
(usb_storage, usb_kbd, usb_ether) walk if_desc[] and ep_desc[] by. A
device whose counts claim more than it describes, or more than there is
room for, makes them read past what was stored, and past the end of
those arrays.

Lower the counts to what was stored once the configuration is parsed.
For a device with more interfaces or endpoints than there is room for,
keep the ones that fit, as the comment there already intends, rather
than return an error that nothing checks: stop at the first interface
too many, and skip each endpoint too many. Don't take the companion
descriptor of a skipped endpoint for that of the endpoint before it.

Add tests for both cases.

Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
---
 common/usb.c  |  24 ++++++--
 test/dm/usb.c | 154 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 174 insertions(+), 4 deletions(-)

diff --git a/common/usb.c b/common/usb.c
index 6a4ad346f4b..05502da6b30 100644
--- a/common/usb.c
+++ b/common/usb.c
@@ -385,6 +385,7 @@ static int usb_parse_config(struct usb_device *dev,
 	int index, ifno, epno, curr_if_num;
 	u16 ep_wMaxPacketSize;
 	struct usb_interface *if_desc = NULL;
+	int i;
 
 	ifno = -1;
 	epno = -1;
@@ -428,7 +429,7 @@ static int usb_parse_config(struct usb_device *dev,
 				if (ifno >= USB_MAXINTERFACES) {
 					puts("Too many USB interfaces!\n");
 					/* try to go on with what we have */
-					return -EINVAL;
+					goto out;
 				}
 				if_desc = &dev->config.if_desc[ifno];
 				dev->config.no_of_if++;
@@ -447,6 +448,8 @@ static int usb_parse_config(struct usb_device *dev,
 			}
 			break;
 		case USB_DT_ENDPOINT:
+			/* no companion descriptor goes with an endpoint we skip */
+			epno = -1;
 			if (head->bLength != USB_DT_ENDPOINT_SIZE &&
 			    head->bLength != USB_DT_ENDPOINT_AUDIO_SIZE) {
 				printf("ERROR: Invalid USB EP length (%d)\n",
@@ -462,14 +465,14 @@ static int usb_parse_config(struct usb_device *dev,
 				puts("Endpoint descriptor out of order!\n");
 				break;
 			}
-			epno = dev->config.if_desc[ifno].no_of_ep;
 			if_desc = &dev->config.if_desc[ifno];
-			if (epno >= USB_MAXENDPOINTS) {
+			if (if_desc->no_of_ep >= USB_MAXENDPOINTS) {
 				printf("Interface %d has too many endpoints!\n",
 					if_desc->desc.bInterfaceNumber);
-				return -EINVAL;
+				break;
 			}
 			/* found an endpoint */
+			epno = if_desc->no_of_ep;
 			if_desc->no_of_ep++;
 			memcpy(&if_desc->ep_desc[epno], head,
 				USB_DT_ENDPOINT_SIZE);
@@ -525,6 +528,19 @@ static int usb_parse_config(struct usb_device *dev,
 		index += head->bLength;
 		head = (struct usb_descriptor_header *)&buffer[index];
 	}
+out:
+	/*
+	 * Interfaces and endpoints are walked by the counts in their
+	 * descriptors later on, so don't let these claim more than we stored.
+	 */
+	if (dev->config.desc.bNumInterfaces > dev->config.no_of_if)
+		dev->config.desc.bNumInterfaces = dev->config.no_of_if;
+	for (i = 0; i < dev->config.no_of_if; i++) {
+		if_desc = &dev->config.if_desc[i];
+		if (if_desc->desc.bNumEndpoints > if_desc->no_of_ep)
+			if_desc->desc.bNumEndpoints = if_desc->no_of_ep;
+	}
+
 	return 0;
 }
 
diff --git a/test/dm/usb.c b/test/dm/usb.c
index 7f803f9fe01..145ce79dfec 100644
--- a/test/dm/usb.c
+++ b/test/dm/usb.c
@@ -500,3 +500,157 @@ static int dm_test_usb_hub_ports(struct unit_test_state *uts)
 	return 0;
 }
 DM_TEST(dm_test_usb_hub_ports, UTF_SCAN_PDATA | UTF_SCAN_FDT);
+
+/*
+ * Descriptors of a device with a vendor-specific interface, which is bound
+ * to the generic driver whatever its endpoints. The tests below give them,
+ * or copies with errors in them, to the emulator on port 1 in place of its
+ * own, to check how a configuration that a device gets wrong is parsed.
+ */
+static struct usb_device_descriptor vendor_device_desc = {
+	.bLength		= sizeof(vendor_device_desc),
+	.bDescriptorType	= USB_DT_DEVICE,
+	.bcdUSB			= cpu_to_le16(0x0200),
+	.idVendor		= cpu_to_le16(0x1234),
+	.idProduct		= cpu_to_le16(0x5678),
+	.bMaxPacketSize0	= 64,
+	.bNumConfigurations	= 1,
+};
+
+static struct usb_config_descriptor vendor_config0 = {
+	.bLength		= sizeof(vendor_config0),
+	.bDescriptorType	= USB_DT_CONFIG,
+	/* wTotalLength is set up by usb_emul_setup_device() */
+	.bNumInterfaces		= 1,
+	.bmAttributes		= 1 << 7,
+	.bMaxPower		= 50,
+};
+
+static struct usb_interface_descriptor vendor_interface0 = {
+	.bLength		= sizeof(vendor_interface0),
+	.bDescriptorType	= USB_DT_INTERFACE,
+	.bNumEndpoints		= 1,
+	.bInterfaceClass	= USB_CLASS_VENDOR_SPEC,
+};
+
+static struct usb_endpoint_descriptor vendor_endpoint1_in = {
+	.bLength		= USB_DT_ENDPOINT_SIZE,
+	.bDescriptorType	= USB_DT_ENDPOINT,
+	.bEndpointAddress	= 1 | USB_DIR_IN,
+	.bmAttributes		= USB_ENDPOINT_XFER_BULK,
+	.wMaxPacketSize		= cpu_to_le16(512),
+};
+
+/**
+ * scan_port1() - Scan the bus with a device on port 1 that has the given
+ * descriptors
+ *
+ * @uts:	Test state
+ * @desc_list:	Descriptors of the device, terminated by NULL
+ * @udevp:	Returns the device found on port 1, or NULL if none was set up
+ * Return: 0 if OK, -ve on error
+ */
+static int scan_port1(struct unit_test_state *uts, void **desc_list,
+		      struct usb_device **udevp)
+{
+	struct udevice *emul, *hub, *dev;
+
+	ut_assertok(uclass_find_device_by_name(UCLASS_USB_EMUL,
+					       "flash-stick@0", &emul));
+	ut_assertok(usb_emul_setup_device(emul, NULL, desc_list));
+
+	state_set_skip_delays(true);
+	ut_assertok(usb_init());
+
+	*udevp = NULL;
+	ut_assertok(uclass_find_device_by_name(UCLASS_USB_HUB, "hub", &hub));
+	device_foreach_child(dev, hub) {
+		struct usb_device *udev = dev_get_parent_priv(dev);
+
+		if (device_active(dev) && udev->portnr == 1)
+			*udevp = udev;
+	}
+
+	return 0;
+}
+
+/* test that interface and endpoint counts are limited to those described */
+static int dm_test_usb_config_counts(struct unit_test_state *uts)
+{
+	static struct usb_config_descriptor config0;
+	static struct usb_interface_descriptor interface0;
+	static void *desc_list[] = {
+		&vendor_device_desc,
+		&config0,
+		&interface0,
+		&vendor_endpoint1_in,
+		NULL,
+	};
+	struct usb_device *udev;
+
+	config0 = vendor_config0;
+	config0.bNumInterfaces = USB_MAXINTERFACES + 1;
+	interface0 = vendor_interface0;
+	interface0.bNumEndpoints = USB_MAXENDPOINTS + 1;
+	ut_assertok(scan_port1(uts, desc_list, &udev));
+	ut_assertnonnull(udev);
+	ut_asserteq(1, udev->config.no_of_if);
+	ut_asserteq(1, udev->config.desc.bNumInterfaces);
+	ut_asserteq(1, udev->config.if_desc[0].no_of_ep);
+	ut_asserteq(1, udev->config.if_desc[0].desc.bNumEndpoints);
+	ut_assertok(usb_stop());
+
+	return 0;
+}
+DM_TEST(dm_test_usb_config_counts, UTF_SCAN_PDATA | UTF_SCAN_FDT);
+
+/* test that a device with more interfaces and endpoints than we keep works */
+static int dm_test_usb_config_too_many(struct unit_test_state *uts)
+{
+	static struct usb_config_descriptor config0;
+	static struct usb_interface_descriptor interface[USB_MAXINTERFACES + 1];
+	static struct usb_endpoint_descriptor endpoint[USB_MAXENDPOINTS + 1];
+	static void *desc_list[3 + ARRAY_SIZE(interface) + ARRAY_SIZE(endpoint)];
+	struct usb_device *udev;
+	int i, n = 0;
+
+	config0 = vendor_config0;
+	config0.bNumInterfaces = ARRAY_SIZE(interface);
+	for (i = 0; i < ARRAY_SIZE(interface); i++) {
+		interface[i] = vendor_interface0;
+		interface[i].bInterfaceNumber = i;
+		interface[i].bNumEndpoints = 0;
+	}
+	desc_list[n++] = &vendor_device_desc;
+	desc_list[n++] = &config0;
+
+	/* The first interface has one endpoint too many */
+	interface[0].bNumEndpoints = ARRAY_SIZE(endpoint);
+	desc_list[n++] = &interface[0];
+	for (i = 0; i < ARRAY_SIZE(endpoint); i++) {
+		endpoint[i] = vendor_endpoint1_in;
+		endpoint[i].bEndpointAddress = 1 + i % 15;
+		if (i < 15)
+			endpoint[i].bEndpointAddress |= USB_DIR_IN;
+		desc_list[n++] = &endpoint[i];
+	}
+
+	/* and there is one interface too many */
+	for (i = 1; i < ARRAY_SIZE(interface); i++)
+		desc_list[n++] = &interface[i];
+	desc_list[n] = NULL;
+
+	ut_assertok(scan_port1(uts, desc_list, &udev));
+	ut_assertnonnull(udev);
+	ut_asserteq(USB_MAXINTERFACES, udev->config.no_of_if);
+	ut_asserteq(USB_MAXINTERFACES, udev->config.desc.bNumInterfaces);
+	for (i = 0; i < USB_MAXINTERFACES; i++)
+		ut_asserteq(i, udev->config.if_desc[i].desc.bInterfaceNumber);
+	ut_asserteq(USB_MAXENDPOINTS, udev->config.if_desc[0].no_of_ep);
+	ut_asserteq(USB_MAXENDPOINTS,
+		    udev->config.if_desc[0].desc.bNumEndpoints);
+	ut_assertok(usb_stop());
+
+	return 0;
+}
+DM_TEST(dm_test_usb_config_too_many, UTF_SCAN_PDATA | UTF_SCAN_FDT);
