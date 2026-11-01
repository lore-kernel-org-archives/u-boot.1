Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5526606A329
	for <u-boot@archiver.kernel.org>; Sun,  1 Nov 2026 07:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Wa/q/6Rd;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OuqkoLKH
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C42A460725;
	Sun,  1 Nov 2026 07:02:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gBVc46fplBC1; Sun,  1 Nov 2026 07:02:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org F2307607D1
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793516525;
	b=sZGKcibb9TX/FSJcoRVusnIk936lpJ4eWU3KI6cryDr0JypDqCOoC7RPI7ULMwSmQRSx
	 mCIv8/LwooQMKj2HMVx3W4IG+lAIr2/5vOOBZoyeF+c5P0e5BjCQ0UDKDlhMn2WZY/w6x
	 6suzrExt2gKLOUF59hy3PKhTnjF1B0QrtNaESd43tNcmLDc+cEHCnR4LSLL3n3hQB2gO5
	 605xVZPtEK7KqZo6ublrj5FC1oo+NXJhOg95uUpi9LUzg+nQlQfAEfKcMtV0am9E6xssg
	 J4aFe9b2yv7hEV/jybD8MlKi3A5/fq2gb/lhS/OnmgrkxRHrPnsvX7LMEa0py6jBR4g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793516525;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=/Q64LJxhd6d8Nqm+xp5UxY8S6DMN+N75zY8poqEbpOg=;
	b=hdLlGpCVSN4+QL3uh8SobpdXp40+H7XTWQui63lEPNje5OzSU9p4YPLKfAZbGMpNCJMA
	 +EB+Ic/PlUkVsQ2XdRrKl5hKd4M9yzpBKqiMfHp+A78qG60DDyVzuKeJOynCbx81/lPGn
	 9CRI7FmOLgvrT0v05VCLfMWEUsCZ6+bXCcey8Ml60uVRDAk1mG8dx7vbgZbXBr97kK9v3
	 frTs+VfbwAYgpI0daXCgI4h/Bjn+SCDiUdSwN7N2CWaMEEoBQPCRp4mNNIWQyRevxBT5D
	 +1mAJxdH/KcwWXhqjmhUl+Nf4L8MMsRGej8CfjZhcNfgtl3lAgDuSbnSmIyjB6OpNCQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793516525;
	bh=/Q64LJxhd6d8Nqm+xp5UxY8S6DMN+N75zY8poqEbpOg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Wa/q/6RdvKzWwYSrq7bMYrzTunCEergQPS9sPjnZnQ7iP+XB7by1oR0Z6z1jLobwj
	 kn+WzS/k4V+kT5XIBBHKRxEZO3exJEpsX6adBf5Oh3BNx2Yr6qOCc2wqIolTEmyzJT
	 aeQAmav3Wlj66QqNgV7e50h23BErgKyV2MHFRu75AsEy4G9e0mMiNb2ISsDM/oWrG1
	 CllmpBOSUvm3Cr3R9VC8JACyBKykgM+tIldsfsZnog//JR91smblebvwUt3NB5Usfh
	 4CwHcOuiNG/6/ZuF6lLW5W+E+YLOtSV3JyHgJBgJncEKHoPhzN11XwZR/C0qDIkgUW
	 y6JNkdMwQLE/Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id F2307607D1;
	Sun,  1 Nov 2026 07:02:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id DD7824E0
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 07:02:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CED5E4004D
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 07:02:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xUULSn_-mfhd for <u-boot@lists.u-boot-project.org>;
 Sun,  1 Nov 2026 07:02:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org BC7174024A
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::336"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793516523;
 b=D24bdpiJ9ftWLRk9Xfdb72gEY+IKPW3mA6fipogPVRy1ODfzQwl629m+zSGAfp9ub93M
 4rlzYiwX7lgDoY6NdwjPv3mQ3GV/Rg9QPc99eXESDgSb3aRIinUA3Gf7vEO7C9s6jIqEv
 wGF1aNVoREjfC2VB1GRRho85utsauUHOdOpNpJUOM42i2f5FzHbswj8QnYrBWODCeFquY
 ZxEGwft+p+a++h1QS3Gy/oN3HC9rYDtCK9ynqb+GOKPdH+MXnHdRP06Y0LULQUjX6iLLp
 uyp4MA3VYS0p90dCNYtO8ah5tepJERgi+EGqSvDL4ECwYGkN3leDV3PhKN7vyAEsHVA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793516523;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References;
 bh=/Q64LJxhd6d8Nqm+xp5UxY8S6DMN+N75zY8poqEbpOg=;
 b=fQzHQoLWKIBQS/62nEaIlTNeoFSGK4Nfwka9F4rbgM89JT3biu5h/+bYbx5InjUlPqVb
 e1vh/nzMuEsROjyGHutK25O08PRpb8aimcp9vaAfGm5hHWDMuw+3p9r2arPsTzYiVSeg5
 aOF6PlrNYCpsBkC6tV8dfRtaPlkZFlgcXTlO97L6sdUaaBHCTiI+Hnr/5aeuOE+JP/QZB
 ATkq9RtZWNTuWr+wd+OZu9oh4lkVBeQZCnfaxoBfv5IPFikmqCiKWsw1z1HQHEcvuKARM
 4sU96EHHDpZqKJ2lRGfT9wSD/KP1DFvh1SDja0ckp7OCnQKu8W3dxEf7dk+mQXINH4A==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=OuqkoLKH; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::336"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::336; helo=mail-wm1-x336.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=OuqkoLKH
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BC7174024A
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 07:02:02 +0000 (UTC)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4a214af2076so14770315e9.0
 for <u-boot@lists.u-boot-project.org>; Sun, 01 Nov 2026 00:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793516520; x=1794121320;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=/Q64LJxhd6d8Nqm+xp5UxY8S6DMN+N75zY8poqEbpOg=;
 b=OuqkoLKH1ZQecHga435stWG/tcoiwIy1UXzmLHXEUxiMHqvc+l7tINNx4gjjF8ne1f
 kWKTU//Yg9jqE3k/qPPOIjC7qU8Em2fJM59kZfEfXI7QYjeaXdYRUeJ5jyrc0xz0kIKC
 1KJYF06BB5TkU6N0X39/5nKMZ7RO8WrYOazmX3dnLOFkxfx70F+tD3tXenIQQHuYqqon
 qeUkA05lXDM6ergE2cv8CfEC4KA0CUSCPfq3rM9w8r3qtoS4VseHDWOJC2zn5EdtgBNZ
 78xsa2Mlv55gj/l1k7DKKoNNjFunRlsufQkRJvuULR10efI6LtfDssajA9TccWwvhXuN
 o75g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793516520; x=1794121320;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/Q64LJxhd6d8Nqm+xp5UxY8S6DMN+N75zY8poqEbpOg=;
 b=oivI2mr3m22E41x8/9qnq2/k1zH1T1oRJ5Cqb09th8vSpHdHBWrZ0Kn0t7JXqKtooY
 Sm4ZrPFTqVVP2MoyrEki0k45f4v8ztKtz5dUl/T4fCOTCTVUa56x+AvKfeYB9AK2X9vH
 9jKtvhsl1uFhyQUtJgJSyXCfF+dBSUc7SEUb5awmt1W8nP8i/dOpKOquFQgAhy+iBLa8
 bSJSAtYs4TeSwPQliM6kc9VbEyQaMsYFdwHZDNipVuo/Va84cbo/vMDiCT2PBSXP3N4W
 8mjGGF7MCJyH9M/Zsxa0mkYnMxf7MsfAkZq/p+vvbhn9Szr4SmjWktFcAHnClCH+ngpt
 1nfA==
X-Gm-Message-State: AFq9FYLsCo5KngHGax907Wip1TLm0/Q8obUu3lQx+oPTiEXr14Fhh/Bk
 AjdgNFITGd8WTBCHFTieYlH59J8HAiB5qTyDz62sGEFjstYWP3/glxKk
X-Gm-Gg: AYBFou1ewhzSSYZ30fofTaQpucpIIcpd5HgAsNdAkeuyWGOuwqta9LQYAFg2N7xV6lA
 nON/IPdeTIdumVuUdbXm40ddkiTGv7tACYytUOS/zBOf1H5qq7E13Ox+K6LKCk/K07S9rDbQQaZ
 WRYlLha5sQQK3QFZAl9zVlFjSAoAJq0cHqsRNv1qBbpOpci4Ukp9dRcD/y1kiYsUmvXrH5BSFgL
 lL67C2qmMLpMXNx0svSCz7gnaiBnoXW4VLO+eJ2pjRJkj1x0t6ioTHqxVqPklrEM25y/ly6AzSj
 FCos/XH5FxqwM72rBtT7SFzhjSlOSR34M3KFSGDQDvMz7X209s3T7j1E6sOvZYdu3eBvRrEb57x
 ejndqYaqliL1xiIqwNdbEeK/iXx4WEeOPs5HXOnW9bd806qW+O/b0vBgfbnE40GVMbH8t0n/RYS
 fH5SkVKPhS+ywFwSkplPNkFbiY6CvFb5BadGC6MpNirWhyQedJbGSLI+V141wj5rQqObYM8RgCU
 WwJ0OVhak+JUdKQdkgPZKo/vzAgPm0W/51Du3Xs7yXy7eAON12h3wpjyx9HXOet5mmpS1ZKnu7k
 y/VdUN90zyR/aeMKCA2u3zQmZ+hcI1Zs
X-Received: by 2002:a05:600c:c171:b0:49c:fa20:cbfd with SMTP id
 5b1f17b1804b1-4ad739eb30fmr81788365e9.20.1793516520251; 
 Sun, 01 Nov 2026 00:02:00 -0700 (PDT)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4abf67aa704sm171540145e9.8.2026.11.01.00.01.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Nov 2026 00:01:59 -0700 (PDT)
From: Ana Bobillo <anabobillo3@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, Bin Meng <bmeng.cn@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Alexey Charkov <alchark@flipper.net>,
 Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH v3 04/14] usb: storage: Refuse a block size the block layer
 cannot use
Date: Sun, 01 Nov 2026 07:01:58 +0000
Message-ID: <37a004a1-3707-485b-bdc3-8fde187f501f@gmail.com>
In-Reply-To: <1ea4ecf3-70d8-4469-be94-1943ab8e3337@gmail.com>
References: <1ea4ecf3-70d8-4469-be94-1943ab8e3337@gmail.com>
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

usb_stor_get_info() takes the block size from the READ CAPACITY reply of
the device as it is. Once blk_post_probe() refuses a block size that
blk_valid_blksz() rejects, at the end of this series, such a device would
fail to probe there, and usb_stor_probe_device() would stop, skipping the
other LUNs of the device.

Check the block size where it is read, and treat a LUN reporting one
that blk_valid_blksz() rejects as unusable, as for a LUN that is not
ready, saying which LUN is skipped. This also covers the legacy (non-BLK)
path, which calls part_init() itself.

Add a test where the sandbox flash stick reports an unsupported block
size.

Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
(no changes since v2)

Changes in v2:
- Move the READ CAPACITY fallback fix to a patch of its own (Simon)
- Name the LUN in the message (Simon)
- Check for that message in the test, with UTF_CONSOLE (Simon)

 arch/sandbox/include/asm/test.h  | 10 +++++++
 common/usb_storage.c             |  5 ++++
 drivers/usb/emul/sandbox_flash.c |  8 +++++
 test/dm/usb.c                    | 51 ++++++++++++++++++++++++++++++++
 4 files changed, 74 insertions(+)

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
index f7c96195b59..6bada2b309b 100644
--- a/common/usb_storage.c
+++ b/common/usb_storage.c
@@ -1513,6 +1513,11 @@ int usb_stor_get_info(struct usb_device *dev, struct us_data *ss,
 	blksz = be32_to_cpu(cap[1]);
 
 	debug("Capacity = 0x%08x, blocksz = 0x%08x\n", capacity, blksz);
+	if (!blk_valid_blksz(blksz)) {
+		printf("LUN %d: unsupported block size %u, skipping\n",
+		       dev_desc->lun, blksz);
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
index fa894c1096e..79a85b11910 100644
--- a/test/dm/usb.c
+++ b/test/dm/usb.c
@@ -84,6 +84,57 @@ static int dm_test_usb_flash(struct unit_test_state *uts)
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
+		console_record_reset();
+		sandbox_flash_set_block_size(emul, cases[i].blksz);
+		ut_assertok(device_remove(dev, DM_REMOVE_NORMAL));
+		ut_assertok(device_chld_unbind(dev, NULL));
+		ut_assertok(device_probe(dev));
+
+		ret = device_find_first_child_by_uclass(dev, UCLASS_BLK, &blk);
+		if (!cases[i].ok) {
+			/* usb_stor_get_info() refuses the LUN */
+			ut_assert_nextline("LUN 0: unsupported block size %d, skipping",
+					   cases[i].blksz);
+			ut_assert_console_end();
+			ut_asserteq(-ENODEV, ret);
+			continue;
+		}
+		ut_assert_console_end();
+		ut_assertok(ret);
+		desc = dev_get_uclass_plat(blk);
+		ut_asserteq(cases[i].blksz, desc->blksz);
+	}
+
+	ut_assertok(usb_stop());
+
+	return 0;
+}
+DM_TEST(dm_test_usb_flash_blksz, UTF_SCAN_PDATA | UTF_SCAN_FDT | UTF_CONSOLE);
+
 /* test that we can handle multiple storage devices */
 static int dm_test_usb_multi(struct unit_test_state *uts)
 {
