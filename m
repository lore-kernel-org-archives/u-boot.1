Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B77E606A31A
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 06:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=pmxgm0TU;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RaI24/AL
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D79018112F;
	Sat, 31 Oct 2026 06:17:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VQmgVVPGGyAH; Sat, 31 Oct 2026 06:17:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 17F4081140
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793427450;
	b=mufaC6jH+16qKku1AkE8ZXJPZBANr1/e8QSVpnCOacT+E6YnNQZFmTR9L+MwDJRk20o9
	 F4YjsJIDTpGinobx0hn+07D/6H20CeiIQx5Aj+mjDglDjxZX+oW5ObwwXLqETQkaC/ZiJ
	 /MEcjPd96qXVHSmA5GbaRApv/Rc/+xK6RYgnSbGvAv0IwJ1mrSsaFKEhvQrSBaxyK1tns
	 o3xouzbAqTeMBFWjKP7RG/hWCoWWO5PI5iqu7+eDlywGIrsTEz1GfuhkErmnDShMmcO2g
	 n9qtR1D+DOBvmPLevzOomrzqVLVxOGXSjag+lA0raxcKNuecXm/0eRdUkmwHt3IztvQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793427450;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=mN3yQPP5CBCmjW+floQDnL2tWCRLUm9obPXrDfDSiTs=;
	b=CXAtCgyT/EcJ7ImcwCBknnCtPtOS29bJcbSjclsFCoATYzrqeX/rAeuLcu/kc7hA9oFH
	 hujfgwO7Kl3/22xDh9jGcbuGHAqRKpWbi6vXvzdmKsab5BIRa3XLxa1fIEk2PwkN53tbJ
	 wN66coPSd1rmzbfw0aIVIHvizpO8hEGkvrSxUYb+U/NDejPprU1LnVx/QGiaADLnC97XX
	 qc2qP4QyWwnMCEjHs/ScIYg70lQHrwnIZ0wBj7wwucOoEmWyjHw24O0XrTCvn9iWvHXSK
	 UTpNUoBlDGF4JDg8I8xgobyE6pun6S7sQt01mPCt4k7xqEHwx0ld22DZAnj0S6KPk2Q==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="RaI24/AL";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793427450;
	bh=mN3yQPP5CBCmjW+floQDnL2tWCRLUm9obPXrDfDSiTs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pmxgm0TUyUAtHpSCm5GKm0wcM9+vbmpR42t05gBVwcmFLv4tAMdT57AsWxXf6dDEE
	 DFeRhoQdQLk+ZArhAmpzhuUklwglp4A0LDd0I6yp8YPdO4GmYIHpWOUnw9brD/Gi2T
	 w6+K+dYofhz7smOckMHU4hZPkhuKJoLg5aYuXWZb5uvLnJOK1qypOmJlO9JFGgOTXw
	 Dd3Kbl7MoLVomtNuzc4gtSsiVQpxM/YD1DjJ7//fQwlnl1JgwGaoF8B52dottKKpP0
	 LYGHASq/HeFM7DoAyXXmJNcx04mfFYEj/bN5AfA+nxd1zvkdNLouaL4Rke5Jq7hG77
	 ebGnAQiRZE4Eg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 17F4081140;
	Sat, 31 Oct 2026 06:17:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id C31A4156
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 06:17:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A8A7681140
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 06:17:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JEyDWOrEhgtZ for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 06:17:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B54D28112F
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793427448;
 b=Vn/Kl2naNqaxH7jBD6oWxk1CH+fjd68mzDmZrs5bxkh34qWsXen2mbLOOD0e55YvU+E6
 x7uTstl1Xf4gEa7T1Nzu9oK3ZwGYFfxCbfHh8Q505Ri2o4aAAvNvZTWhT6YgjMgdtfObi
 DJpbwfRwjZRuJPi7ppx06gzksTF4QcLTnd9ar2KSDpn0lW1Aa/27teQbTN8nwCttzybyN
 7Qmx61mTatvox9WLs9gaz9876OB0/+zIl+wP0u1zugizwYndpuDANp2LJvRhqM65T273B
 paCqNDQlZEzX9LCh2orkxX0XzFLlKwxgd4IWOpEzRyePJ4BEY7CDRoFyzONFQG5wVwg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793427448;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References;
 bh=mN3yQPP5CBCmjW+floQDnL2tWCRLUm9obPXrDfDSiTs=;
 b=Ba+qnqapBPsN74C6PvUWXDzephzxIQJ4eUzvLdLztjH0yJabNsG2/f9/C06JqDEnvh7N
 3dgVTA4sC+skskHdC7eUzDjXV77iJM3k6BtX/12C20HI4NDaM9KmYJtELi+FIR8vk2eKV
 FD+6HYQV1CxkdZ1sWzFinVlo1X99tBOyKHCcDlB5pwXKXRXUQprRwqo81ZbAeN+40lWuB
 CxElUxlXlOJ8ju/a4NSDXm/Eibg4W8aRUWB88KyWfxcGcRlQM8Qb/OiPmdY/wSpSvRrZr
 47Kk53tNnuM17kPQPQbnO5Tce/eTEHA9kMCzRBJN45kklsRxeD0qHbzAmbzTKV6IgoA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b="RaI24/AL"; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::42b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42b; helo=mail-wr1-x42b.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=RaI24/AL
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B54D28112F
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 06:17:27 +0000 (UTC)
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-48dfdd0678dso964903f8f.0
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 23:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793427445; x=1794032245;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=mN3yQPP5CBCmjW+floQDnL2tWCRLUm9obPXrDfDSiTs=;
 b=RaI24/ALC2Wmia4hw5A+WnrLPF1RxkzHKUcoA020oHfMIbacGhEzlJ/LYGk1SBQ1X6
 DP93+FkYWq7p5vSpNyThER+N0faDgrKj1/5tGmRALpoTT6OympvqOOUd8Jo9bwbJeBYZ
 b2vCKLxrXD1qLlQ9ZztRsG2B3nnmKNO3Qo1WzMbPPGyr93X5/Zy8i6GIYqj/QH7MuJ+A
 rwpcxk6cI35MgCvP3w4HoYDaBBQfYXC6uN+8WFafaUz2L3plzCaXFzZCGibEYuyyVfjA
 ajL5uyczIFkYjX1TORtvRWQg1a4vTS+30wOmIf0PTPisBbPJxk/45t/6RCdvG9N3J+Es
 5ftQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793427445; x=1794032245;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mN3yQPP5CBCmjW+floQDnL2tWCRLUm9obPXrDfDSiTs=;
 b=wWKxPzyH7r5lzo8in8CXRZHcE7z1wMy6a5AsNmxqLb5CRJ50f8Lr3AxMrXqFSNKS/A
 oXbic3IqClZfiL8a1RUZC/ERu4KaD+nH0ZkIfPEOikWhHQpD3HtOffZ1XWYCz9Cn2fGa
 8Myhkgxr8EPRh6xwsMbea+Gp1hSYT8R7tryjs1/Q/2kBCDKVx7Dox7sOBrOPG7asRem3
 DVVp/DS49r/QfnoMkmHDZSRb+X2ImboG7Dj+bPj5sRmYp/Hj+e2bt5hNk8eylgwgbg64
 +xsd3vk70hgnFk++ztciAHzvisqd9Bn2wKH2KPQXNLDPRU237CbKN3b4lwExPr2hCeF5
 QQyA==
X-Gm-Message-State: AFq9FYJVKiAMvEVJpwjfZZmWOLyxwuwwVaso+Gg4Y4DDD0JZgqogxx7p
 t+y3KdgY6ar+aJ76WvEY8Yq2h2i2LWO/cfSZSMhjFo+B9ASvMhvZDycO
X-Gm-Gg: AYBFou12FbHlpscak+cuf8Cwy8biNinWJ9jQMgsJjhA+I0PdNhjJU5R5Fl/Xc4s9nfX
 2Wz99BOT0WDxcuGkOm8K5BJQEmYnf2h3EON4Iq/0rCVDgQ7MF7yH4Gj1O8myXQZjdKTqo946nSw
 7ahgaRrz0svYpPxeouN4KkdPN6wnom370zgm1JvQukVkbh84mArqI+rc8frGEhGYwjdvbaPLbCp
 J1z92C+891T7jejhu4zv1oDih5/WouHCk6bgwEs+9KTFluE2fNgxnVaM+rv0+Hspsm/Z8I2UegF
 p3kVZS2d29IO1VY9KU1ozjih3W/iKwkfP/A6dSNGokhSXcHqAxr2T9ZpOEeEF9COQd1Oovc2yXl
 KWkh/L9WRaGI9o1VW95mrjOzvlwhBGg63bvlDHm5H8CwOlZ8PN6zAMyqg8fNeD5PtkcJsbXqtko
 AwCBpIYN0AIqShMgcvbHf08Odj/XZykX8oqvSSrpuSWbMqhgM4sArvTGB9dcPyfpJWvb4WQlTPF
 uw4FJxqm5Jn9kEYqMXssRcP8An8YLn09o5KLrWD/XUDi4ho5m07TnmS5Zg+5YHep5JdUmswh6mX
 7GxbIGMyxCEg3d8UtjP+ZXxcTMZGQMo=
X-Received: by 2002:a5d:588a:0:b0:48e:932:af0b with SMTP id
 ffacd0b85a97d-48e6e4f6a88mr10030988f8f.32.1793427445122; 
 Fri, 30 Oct 2026 23:17:25 -0700 (PDT)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b78a1dsm6879748f8f.24.2026.10.30.23.17.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Oct 2026 23:17:24 -0700 (PDT)
From: Ana Bobillo <anabobillo3@gmail.com>
To: Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH 6/6] usb: don't use a device whose configuration can't be
 parsed
Date: Sat, 31 Oct 2026 06:17:22 +0000
Message-ID: <0162ed1d-e9b3-4280-b1a5-6b099565a572@gmail.com>
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
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_GMAIL_RCVD,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

From: Ana Bobillo <anabobillo3@gmail.com>

usb_select_config() ignores what usb_parse_config() returns, so a
device whose configuration doesn't start with a valid configuration
descriptor is set up anyway, with an empty configuration. Since the
previous patches, this is the only case where usb_parse_config() fails:
a device with more interfaces or endpoints than there is room for is
parsed as far as there is room.

Skip such a device, as is done when its configuration can't be read.

The hub then disables the device's port, and the next device found
gets the same address. Have the sandbox hub emulator drop the address
of a device on a disabled port, as such a device no longer answers, so
that the emulator of the next device is the one found at that address.
Add a test with a configuration descriptor of the wrong length, which
also checks that the devices on the other ports are still found.

Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
---
 common/usb.c                   |  7 ++++++-
 drivers/usb/emul/sandbox_hub.c | 11 +++++++++++
 test/dm/usb.c                  | 28 ++++++++++++++++++++++++++++
 3 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/common/usb.c b/common/usb.c
index 619132512dd..87f0590bbd5 100644
--- a/common/usb.c
+++ b/common/usb.c
@@ -1232,8 +1232,13 @@ int usb_select_config(struct usb_device *dev)
 		free(tmpbuf);
 		return err;
 	}
-	usb_parse_config(dev, tmpbuf, 0);
+	err = usb_parse_config(dev, tmpbuf, 0);
 	free(tmpbuf);
+	if (err) {
+		printf("usb_new_device: Cannot parse configuration, skipping device %04x:%04x\n",
+		       dev->descriptor.idVendor, dev->descriptor.idProduct);
+		return err;
+	}
 	usb_set_maxpacket(dev);
 	/*
 	 * we set the default configuration here
diff --git a/drivers/usb/emul/sandbox_hub.c b/drivers/usb/emul/sandbox_hub.c
index 066898f005e..c5a5470f9fd 100644
--- a/drivers/usb/emul/sandbox_hub.c
+++ b/drivers/usb/emul/sandbox_hub.c
@@ -190,6 +190,17 @@ static int clrset_post_state(struct udevice *hub, int port, int clear, int set)
 			}
 		}
 	}
+	if (clear & USB_PORT_STAT_ENABLE) {
+		enum usb_device_speed speed;
+		struct udevice *dev = hub_find_device(hub, port, &speed);
+
+		/* A device on a disabled port no longer answers at its address */
+		if (dev) {
+			struct usb_dev_plat *plat = dev_get_parent_plat(dev);
+
+			plat->devnum = 0;
+		}
+	}
 	*change |= *status & clear;
 	*change |= ~*status & set;
 	*change &= 0x1f;
diff --git a/test/dm/usb.c b/test/dm/usb.c
index 4975a952d87..80763eb8e7b 100644
--- a/test/dm/usb.c
+++ b/test/dm/usb.c
@@ -690,3 +690,31 @@ static int dm_test_usb_config_too_many(struct unit_test_state *uts)
 	return 0;
 }
 DM_TEST(dm_test_usb_config_too_many, UTF_SCAN_PDATA | UTF_SCAN_FDT);
+
+/* test that a device whose configuration cannot be parsed is not used */
+static int dm_test_usb_config_bad(struct unit_test_state *uts)
+{
+	static struct usb_config_descriptor config0;
+	static void *desc_list[] = {
+		&vendor_device_desc,
+		&config0,
+		&vendor_interface0,
+		&vendor_endpoint1_in,
+		NULL,
+	};
+	struct usb_device *udev;
+	struct udevice *dev;
+
+	config0 = vendor_config0;
+	config0.bLength = USB_DT_CONFIG_SIZE - 1;
+	ut_assertok(scan_port1(uts, desc_list, &udev));
+	ut_assertnull(udev);
+
+	/* The devices on the other ports are still there */
+	ut_assertok(uclass_get_device(UCLASS_MASS_STORAGE, 0, &dev));
+	ut_assertok(uclass_get_device(UCLASS_MASS_STORAGE, 1, &dev));
+	ut_assertok(usb_stop());
+
+	return 0;
+}
+DM_TEST(dm_test_usb_config_bad, UTF_SCAN_PDATA | UTF_SCAN_FDT);
