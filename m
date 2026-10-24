Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02EC606A31B
	for <u-boot@archiver.kernel.org>; Sat, 24 Oct 2026 12:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=biBCKjet;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=D5MEgzFf
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8B95760A9D;
	Sat, 24 Oct 2026 12:16:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zc8Ey6WYqhS1; Sat, 24 Oct 2026 12:16:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 81A9260746
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792844217;
	b=ZleZrjyEZslNKXb1IEE/Kd5zXYDSpq95qbARGbg9OLFtLuNPSLxbwa6Dzt1ZlN1AiRxu
	 6E9HCS8O+Z2tz26mzVmMMiHdNJfG8/ePW5hGw8Tgu1v3rP+dCULdu19nZ5BcWh39xofaC
	 hv4lowoXP9ylfZUmNYRNaBz1OTHDXlc7fGMcSGSDbWO6C0/73rvuoJeY1Q8tMSLnjiRTw
	 2jjtm6MlmbiwO471OHbeu9NzaP1yUB2yqvjmjMnbixn7YDEGasgYUcgYh2WlOkSdzsC99
	 da0/S+8msjyHLFUex0WGcOzO5228hnqxvNtvN8HVB7NcVKnGaSBBvtbLHLlNC7f+5CA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792844217;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=ravdT2CimUtOmMLgYrrWLoEPCaUNRWBirJK/9VWax8g=;
	b=SxY06hW6A3Y6+nxK371wBUM8/acaZQAAGfu0VFQ6yG5SUYeWlq1nCt6WMktXlCM94BeY
	 7itSGDE9J7vWa5M0jYWpoBppnE+yQkP5hUEuzh1sw9UWTLY7h+7nCDctK4q8Wzkfio516
	 6mdNT18H4GIjyofZgvYGTVj2elJVFt7AuwvbZpwIM6CTMOTCuCwjZOAzvPg4eWbbFNjmL
	 d9WJa5beD8BIBA+mzqHsSP0Go/m0tS30qZSbo6q+UelN/SzVVIrbGQqR8oFqroJGdlTX+
	 PoLSVrQAEGV5eL8NRAwcu1nNcwp5x8CfFtOXVVwmRPlVDyBczIa5I1hyWkI37njMq6g==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=D5MEgzFf;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792844217;
	bh=ravdT2CimUtOmMLgYrrWLoEPCaUNRWBirJK/9VWax8g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=biBCKjetF0uRXB0k4o9/9VQmzx/bhmVhFqnu2ZkKRs62/L6imUaHH1p00nU35j2Pf
	 SlSe1O1HSoMHfAV/nKQByr8JvetofrH2lIKtHqo5dm7T1uUumKOBPi5J8dLd27MmaO
	 1A1ypeKlH7WnupVqr9yGAemMEO5i7Ebga3QSBS5zDMCBrT2Ot4wrKtuupXDFOZaZam
	 /WJVT7U3Pw1Rgj03gXH8dV3z1RoVuGWpbtvGPTC5LQ6zaMNKoS8MNgnwMuarP8tOD/
	 X+1oe0eERVI8+K2GlE7ZBIfN+xZK3ADX4eKGt1GyaaruyUX9raKVrMzo5lzVMOASol
	 fwLQLUPmCesyg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 81A9260746;
	Sat, 24 Oct 2026 12:16:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 90712380
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 12:16:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8276260A4B
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 12:16:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Y_kIw-6Un1VE for <u-boot@lists.u-boot-project.org>;
 Sat, 24 Oct 2026 12:16:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 782476073E
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792844215;
 b=ASJTSfxv0zc9+3z/FsAKK0pf95yFSsazFaO0HjpobOiAI2RZhEI2WazNoOkwLuJElaha
 N4mcltJHcY5xzTg+qfkxExrSdQE/fQL1euriSyHMXjMcP4eNII6W1YbBQAImrLRrG/b+8
 1guzse7hhFDb659PxPMmqGfBjj1nkeY/IoKwrTHt03U48rUzKIKDe42eq5qWZLUg1P2/u
 juCArvpRUClldj9lEI7PsAgnLP/+NUfpJrJLdvnXlBEo1qJ3/NrRoroVR+pdcxWM9zZPJ
 4b9NkTQr6SYYdtlVrsAYQsbFDCBjnRWxfq8JWhyMA6OJWQ8QytIlFxD6beRztm56+Xg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792844215;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References;
 bh=ravdT2CimUtOmMLgYrrWLoEPCaUNRWBirJK/9VWax8g=;
 b=WG2NXEH2aHQCUeitCS3SNLlIXLNGeIosqt2Lf4gu5PUIjAlv4mpfmr6MuDaZ7j76yg+s
 QMojGiw/7OtifpNMeaf6X+QzaBYaIPEVRbnQRySA5DdgQcx7uN7yDrduWzPztS1sjSnNT
 l9kgJm6mjSdyKfH6NwxZdjpUkScnpKww8BA3OEsbVP0KxnviZxAwPkn/2zSikldE+qKqT
 h33kxyX46BEwHcd8hsni/E0FyIlKmjHiTiuh9ErpPE1aDKTu9+FL4tslvPZugGNnwSexW
 Kr0PvLWD+IAcqpm0ZihnqdiuEvTwhtJMrK4o4acUEwpPWPKt3wivJKwBbcMHST3TMKw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=D5MEgzFf; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::42d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42d; helo=mail-wr1-x42d.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=D5MEgzFf
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 782476073E
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 12:16:55 +0000 (UTC)
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-48dee593f18so1228681f8f.3
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 05:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792844213; x=1793449013;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ravdT2CimUtOmMLgYrrWLoEPCaUNRWBirJK/9VWax8g=;
 b=D5MEgzFfebxyIVvEfyinhSNrjW0QywBpvfgFbhNq78OvYZAD2aGjW3oTJQMbl/PWWw
 BOuMAq6WUB5QL7XQCMnrhTSnbjhBvFXwqLC0SBgzDep2WIYPn+v1/fHPt+h5fvJfFnPq
 yuMZHtZJmM+OAQkvl/KQJ45bEek3Q1K4yhWBKYrbQZFNtIRHrtgTmuY6AX58z5ODUNMl
 GB2Us1nDKFGH+qVQL4n+hvbnttLuxBOIs0Nws/EMhhdaQfHmvEA7+J6wyhZU34rvQZJL
 ZBlTkn6c1zA1x/5ZfFi1mTOGv2jBZ9dTPbBeHSeho5kraCdU8hIfkJ3lrbHCfYlHiWtw
 E+xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792844213; x=1793449013;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ravdT2CimUtOmMLgYrrWLoEPCaUNRWBirJK/9VWax8g=;
 b=cuDz6KCJ2IsIZMea+UQconHHTE6K2zMndD9fvuCJjNC2NWvNWvgp28Pn5CRGXZPI6D
 fol71EyhtS0PA4pV/IXZwaOrgGNKJlBYTUtOXY6he89e2LZwPtN59yHa2iPl3//4WgtB
 lWkoHQoauN+2v7FTlpkUu+jVtdNpgpLGXe6axVYRUhA6GZWcMLnak91XEmH8Mt3tENw8
 O8deXOlcw3PeYtf9YnGGnD1xnr+hHe9Yc/c/OS8GonGP4hJ4/Gd3BC+NbO9WLn+5rVqT
 /FlECviT0z0B7kanDuIBYgWomEEEXSH0ctMHvTXzs41C78Ah//ObzXwexMBz7vt2R+HI
 zuCQ==
X-Gm-Message-State: AFq9FYIjShCRX18PtIg7yaAAI4ngNRnLlYyERsOaCXN3I++zFEJing4q
 uwzLhE8NZDePSHXwxzHB5z50aOMqYJqvBJlr62NtDvnJ/6ea7dhiW1yFqeOEJfuJ
X-Gm-Gg: AYBFou1bEls2MfSZ9roL1z/hhoelEUkOfJkg4Fby78yyOGcnyIZAN6xsf5ybWQ2720a
 sfwIWx10XgcO6FqoEHNehrlrg4xVHZRJr+lHN5cLa7Mxt26vGYZQYeU5J+x5Y1p3LVP7OdLVbfO
 XHZy06upU9rCY0oupoiE4G27MtpPPgvlWt0S6/FBwCj+YbzADktv36mgnnkWzrcy4ZtLZK2zkQV
 72yC2xHeTSM0k3wkmQ/SuErxuLoXd6jSgpHCC20Ci/UkMwkzdGvpbyd2cD5jLeVn9/ZcbUXyEzF
 L41qwrMu+/kGFTvbQecNzlG3NM/OHxNLZbzzKJnyloznvV4/b1mWu0uSceEnXLobnPTHRlkIokN
 qW3lTZwBI00RX0t/5SG7dWRyckeNrcCFcBi2Vhprx5tBd/TIShg6TKmNwHDMmiH4NjFfNlgU9FN
 EgBmbacX0hwepzH5aLY4SUMNChRE7ILxgU0dK9PLwfCzgtHolEkh31OAu/lTi0ByO6Vakf4nYlK
 /mSJvebrpMB+7hR1hJHivivs2mu11drSR6F1bfI04Hu8QL/sxRNDATfRQ==
X-Received: by 2002:a5d:64ed:0:b0:487:1575:ebe2 with SMTP id
 ffacd0b85a97d-48e3eb96fb0mr2873363f8f.44.1792844212942; 
 Sat, 24 Oct 2026 05:16:52 -0700 (PDT)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebcb90dsm3626540f8f.22.2026.10.24.05.16.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 Oct 2026 05:16:52 -0700 (PDT)
From: Ana Bobillo <anabobillo3@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, Bin Meng <bmeng.cn@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Alexey Charkov <alchark@flipper.net>,
 Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH RESEND 2/9] usb: storage: Refuse a block size the block layer
 cannot use
Date: Sat, 24 Oct 2026 12:16:51 +0000
Message-ID: <85b11418-82b7-4951-a9ac-cc014cd1c92a@gmail.com>
In-Reply-To: <08c6c3f7-4241-40ab-8a60-383b9408b6b3@gmail.com>
References: <08c6c3f7-4241-40ab-8a60-383b9408b6b3@gmail.com>
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

From: Ana Bobillo <anabobillo3@gmail.com>

usb_stor_get_info() takes the block size from the READ CAPACITY reply of
the device as it is. With the block layer now refusing an unsupported
block size, such a device would fail to probe in blk_post_probe(), and
usb_stor_probe_device() would stop there, skipping the other LUNs of the
device.

Check the block size where it is read, and treat a LUN reporting one
that blk_valid_blksz() rejects as unusable, as for a LUN that is not
ready. This also covers the legacy (non-BLK) path, which calls
part_init() itself.

The fallback used when READ CAPACITY fails sets the reply in host byte
order, while it is read back as big endian, so on a little-endian host
the device got a block size of 128KiB rather than 512 bytes. Set it in
big endian like the reply it stands in for.

Add a test where the sandbox flash stick reports an unsupported block
size.

Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
---
 arch/sandbox/include/asm/test.h  | 10 +++++++
 common/usb_storage.c             |  8 ++++--
 drivers/usb/emul/sandbox_flash.c |  8 ++++++
 test/dm/usb.c                    | 45 ++++++++++++++++++++++++++++++++
 4 files changed, 69 insertions(+), 2 deletions(-)

diff --git a/arch/sandbox/include/asm/test.h b/arch/sandbox/include/asm/test.h
index 0438790028b..e5590d01a92 100644
--- a/arch/sandbox/include/asm/test.h
+++ b/arch/sandbox/include/asm/test.h
@@ -123,6 +123,16 @@ long sandbox_i2c_rtc_get_set_base_time(struct udevice *dev, long base_time);
 
 int sandbox_usb_keyb_add_string(struct udevice *dev, const char *str);
 
+/**
+ * sandbox_flash_set_block_size() - Set the block size a flash stick reports
+ *
+ * @dev:	USB flash-stick emulator
+ * @block_size:	Block size in bytes
+ *
+ * The host reads it when it next probes the stick's mass-storage device.
+ */
+void sandbox_flash_set_block_size(struct udevice *dev, int block_size);
+
 /**
  * sandbox_osd_get_mem() - get the internal memory of a sandbox OSD
  *
diff --git a/common/usb_storage.c b/common/usb_storage.c
index ac331f1c1b0..49acae26724 100644
--- a/common/usb_storage.c
+++ b/common/usb_storage.c
@@ -1496,8 +1496,8 @@ int usb_stor_get_info(struct usb_device *dev, struct us_data *ss,
 	if (usb_read_capacity(pccb, ss) != 0) {
 		printf("READ_CAP ERROR\n");
 		ss->flags &= ~USB_READY;
-		cap[0] = 2880;
-		cap[1] = 0x200;
+		cap[0] = cpu_to_be32(2880);
+		cap[1] = cpu_to_be32(0x200);
 	}
 	debug("Read Capacity returns: 0x%08x, 0x%08x\n", cap[0], cap[1]);
 #if 0
@@ -1512,6 +1512,10 @@ int usb_stor_get_info(struct usb_device *dev, struct us_data *ss,
 	blksz = be32_to_cpu(cap[1]);
 
 	debug("Capacity = 0x%08x, blocksz = 0x%08x\n", capacity, blksz);
+	if (!blk_valid_blksz(blksz)) {
+		printf("Unsupported block size %u\n", blksz);
+		return 0;
+	}
 	dev_desc->lba = capacity;
 	dev_desc->blksz = blksz;
 	dev_desc->log2blksz = LOG2(dev_desc->blksz);
diff --git a/drivers/usb/emul/sandbox_flash.c b/drivers/usb/emul/sandbox_flash.c
index b5176bb30ce..02e0901050f 100644
--- a/drivers/usb/emul/sandbox_flash.c
+++ b/drivers/usb/emul/sandbox_flash.c
@@ -13,6 +13,7 @@
 #include <scsi.h>
 #include <scsi_emul.h>
 #include <usb.h>
+#include <asm/test.h>
 
 /*
  * This driver emulates a flash stick using the UFI command specification and
@@ -357,6 +358,13 @@ static int sandbox_flash_probe(struct udevice *dev)
 	return 0;
 }
 
+void sandbox_flash_set_block_size(struct udevice *dev, int block_size)
+{
+	struct sandbox_flash_priv *priv = dev_get_priv(dev);
+
+	priv->eminfo.block_size = block_size;
+}
+
 static int sandbox_flash_remove(struct udevice *dev)
 {
 	struct sandbox_flash_priv *priv = dev_get_priv(dev);
diff --git a/test/dm/usb.c b/test/dm/usb.c
index fa894c1096e..c53e6c48ff0 100644
--- a/test/dm/usb.c
+++ b/test/dm/usb.c
@@ -84,6 +84,51 @@ static int dm_test_usb_flash(struct unit_test_state *uts)
 }
 DM_TEST(dm_test_usb_flash, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
+/* Test that a flash stick reporting an unsupported block size is refused */
+static int dm_test_usb_flash_blksz(struct unit_test_state *uts)
+{
+	static const struct {
+		int blksz;
+		bool ok;
+	} cases[] = {
+		{ 256, false },
+		{ 520, false },
+		{ 2 * BLK_MAX_BLKSZ, false },
+		{ SZ_4K, true },
+	};
+	struct udevice *dev, *emul, *blk;
+	struct blk_desc *desc;
+	int i, ret;
+
+	state_set_skip_delays(true);
+	ut_assertok(usb_init());
+	ut_assertok(uclass_get_device(UCLASS_MASS_STORAGE, 0, &dev));
+	ut_assertok(uclass_get_device_by_name(UCLASS_USB_EMUL, "flash-stick@0",
+					      &emul));
+
+	for (i = 0; i < ARRAY_SIZE(cases); i++) {
+		/* Probe the stick again, so that it reads the block size */
+		sandbox_flash_set_block_size(emul, cases[i].blksz);
+		ut_assertok(device_remove(dev, DM_REMOVE_NORMAL));
+		ut_assertok(device_chld_unbind(dev, NULL));
+		ut_assertok(device_probe(dev));
+
+		ret = device_find_first_child_by_uclass(dev, UCLASS_BLK, &blk);
+		if (!cases[i].ok) {
+			ut_asserteq(-ENODEV, ret);
+			continue;
+		}
+		ut_assertok(ret);
+		desc = dev_get_uclass_plat(blk);
+		ut_asserteq(cases[i].blksz, desc->blksz);
+	}
+
+	ut_assertok(usb_stop());
+
+	return 0;
+}
+DM_TEST(dm_test_usb_flash_blksz, UTF_SCAN_PDATA | UTF_SCAN_FDT);
+
 /* test that we can handle multiple storage devices */
 static int dm_test_usb_multi(struct unit_test_state *uts)
 {
