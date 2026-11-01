Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE26E606A325
	for <u-boot@archiver.kernel.org>; Sun,  1 Nov 2026 07:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=w7lnjpC2;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hEvMANTD
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CBB186081C;
	Sun,  1 Nov 2026 07:03:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SegP_0Q_kydQ; Sun,  1 Nov 2026 07:03:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C2634607EB
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793516597;
	b=Zjw6QisJ5OojvwzTyiuOIy8hxEWeLrP16YdXMPKy6n6M7Wyesu4rfaXglhcNRMy8+AcU
	 im5z1gOrWu/3DABzyamaZnsRSo1kGleiqxzzPuHa9+MmoYQrEOqh8Zds7ee22fSpyNlBI
	 SpsZKAXgz5eKn/HI1+8xSyaWXS8TIWJ1jOytIQxFOgWXCiKiis3ELmPmQo+Bgdt9RA8xE
	 C6U0sHSiFpWlusTvWL9WWHV/5fU3633V8yhmDUDgAKIFMtgkVur8tmL91gySksBr2T9KF
	 ROVHIPcMJnGS39xDXpeKFVX8uYmyTSJ5R2ITrzRwPOD3mQ1XOjfxKRiTbXiFHkl9VmQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793516597;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=c1IDo49Y6A1POkmV40qXw1eSaDhFqSqUgN5dbj71Syk=;
	b=LU61RUq9kBuhI4Hf0F1t3Pu7csA6uimy7L4pDDg6oocc5jtI5rGdRX92i4kETaUQCXhj
	 T3Pe1vwk3jdHZILScRTcUhGG5SGNdfForXaV5KoXsxArnSwLra65/5Kut+lXViYfsepHE
	 sBTdyDlfivqzlJlgUcAICRF9lP3Fcm6+rmky4YRBuY8IqfPjmcm5T3iHeXGSUbVgzZ5P7
	 JYwcg8h/Jfni/2zNn+DgDnrPYxxYE0EuUkFPoaf+mPgpB2atwQWF20lKBTwcetMQws/S4
	 7lj2JhbVKQRiYpPCN0ZWxaspB8WMrXplJTckFPhpPAGzOLRAAgtfIb8LMIk0PjoozQA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hEvMANTD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793516597;
	bh=c1IDo49Y6A1POkmV40qXw1eSaDhFqSqUgN5dbj71Syk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=w7lnjpC2cC2Yc13PgMIJyQfZ3rz0bkmhuanWvQ3n3xkpBC2BNax1KlLvYOGflZE7n
	 yifY9Sh151UZvk7Z2RrDvf04KzlCY8Dl7vHCS8HGXOObjvvIQspj2pcWQY2oIAKJs4
	 voXumh0UkXQE9ov8gvbDtokjcFnDm5U2fiQFUL6ywmlBWh5DuaeqkOo+VSnDc2GU1m
	 gKNSy9jaN+IBSOa6iPwJ+1VRGod+pzRgdZ3k21lNvxiMi+lXaXfhhnZfEIVpGeG3eA
	 6CwZwteGLMaQPucth3OLHg1jtZn1gD//klAsQDFl+LR5nMVqhFAK4u2Wy93uDyPbba
	 XV1JnD5OUdZUQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C2634607EB;
	Sun,  1 Nov 2026 07:03:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id E611ED3A
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 07:03:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CBA11607EB
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 07:03:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id q5U5206nR_Aq for <u-boot@lists.u-boot-project.org>;
 Sun,  1 Nov 2026 07:03:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org AF754607E5
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::335"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793516596;
 b=tbOG0pgqoJe1IlyBlgH58jcRblKxiN3deAMkzXu10ok2ri2otE2CddlvBiWV8yMmzzcM
 DZ2+ueyBCUB3sZiy/zrsg3+w63QPRrOGZKHCOiC0shS+uAG6w8NL82nFy+NdbTi94Eb40
 XbVz5vIKDhXOjTKLMnHk3Q2B/ijLzknVRPSxD8feJaZr9gK6jz0fP49i98kBdr2gXN2Av
 jVGxqlSNFGAHe2O3cCXcIdpsVeLBCV3qkUD5OxgjkbwDLl1BQG2j0Sa2qYhFNiHXoKSKF
 ShDljSHtGKH259mXeO2FOsvbceg3T/TJlNydC5mTnCZyntv+L93bMbm7KKXX1LFanDw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793516596;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References;
 bh=c1IDo49Y6A1POkmV40qXw1eSaDhFqSqUgN5dbj71Syk=;
 b=gw8C3DL4n/kkC+dkPwUoAolsIoQHSPqhOJk5XWsgFAiz9Bgb58rf3mMLRSIiiuAPBLKw
 oRhTcs+F/Najcqa9Xww2nf0lAXdU8aBIJXH7yGEuLLVnxJuccQvPAUs3LZWvZA5kM8F5X
 jWuS4fr+IlnBA9DD8CDjgwGoMNcfI8E2wqw05M5GJFYHqk4pugv/eKwNTA6BKsmhsUhVf
 a6kcf3FSZf2YSfhVhkoBTTp9BXcOsxcde5UmZ5HxZo9NdRu4xla0KigdKykyGFqT5BmcA
 ePu99EDkP6JhcyV8XE1eXy8Q9gkKCAgZo2iEaBKqQOAJgzG5dK1OG8ZPJo8AX4jR99g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=hEvMANTD; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::335"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::335; helo=mail-wm1-x335.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=hEvMANTD
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AF754607E5
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 07:03:15 +0000 (UTC)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4a35d5d4a20so22482415e9.2
 for <u-boot@lists.u-boot-project.org>; Sun, 01 Nov 2026 00:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793516593; x=1794121393;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=c1IDo49Y6A1POkmV40qXw1eSaDhFqSqUgN5dbj71Syk=;
 b=hEvMANTDUeojOxV6iQmujQT4IaiFOwJrZfbIZrwPw05WrGbJMhv608+sB6kKrm+dUP
 cEdiGGFXa8woreBqhUetoov2BVwubi1LMHclyY7H7+2VSUDgYSe4f1binU9ZBsn6fZ/0
 ne1wYjIAtDZ4Mg3JPLR/XTb9SLt4qi8SMbeI2ZuYAAYtT8/NNrwCwgKRGPo99ZQ9UoEk
 rs3tikg14S/HdRvvcN09VTX9B3z9VFoI1si5r85qHNMc5ldK60WYNAu5d/hR4I8kjSur
 7nbSBvXYI6eHaBdZ9FM99CQ7eJHos3h0ySWJlQzQzVNhNd/NgGwpsSsXKjn4mzGbXU37
 TxYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793516593; x=1794121393;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=c1IDo49Y6A1POkmV40qXw1eSaDhFqSqUgN5dbj71Syk=;
 b=1HDecyzgzzKEVKH+whK69QQpWNzYrmCuYVomR7g9Q/Gd72FkC/4bJnNx5fAuEmpZC4
 qi3d9L7utBueOZX3awAeg3zNX22D3xAPrRkc5HCM/jrnyv/z5Wx6SpVtXkCSvTv5RvZh
 uE/b0hfH1k9jbk9wXYbb7XeH96tQ9ajLYEOHToRE6v507mA51+g9fZJUD8Ah1Cl4EZHV
 oxnBQ6LK/UC4EMmvDx/9l9jvc5Zc7KgySjpBpPx09X5wQSYq8WadShHFMgWBp0oY/aVt
 aWmCzL0NGHwG0JNgJJwTlJqxvH9RsiEdwSAoPoG4HojF1O6Es72FLJZkHVnLc46YnNlx
 aA+w==
X-Gm-Message-State: AFq9FYKcjM3X2I2+lBCqk4Kj2maxiVFxBpKhBO0GmnBXpbi49kLOP/pP
 vA3vZhAjhmLun6AxjOM6ENUNphlun/4gOZ5JrXy060kegxYyBxGtJPDO
X-Gm-Gg: AYBFou04wsGySLcwa6p1YQxRuFE1rfIMNK2ce7AnnIZw1M9kg42T4/ET9uJTJ6aNtEu
 1oNl8zwGHr/8KZmFg2k4RQM1QJSugWktunYxl1rMY/vDmnSmNl5Ldy4Ooq9YuPPqOeUBooBFnJu
 jS0qJZ7+0OgnnhI1r+adkLbrXMccWkzf4Gh1dJ6xHmMDmBQBD7+QOz4LJgbY6MOyK1TJQ2sh780
 4l+15U8GqSHWfYMgtgUAVFSG4OuUQOW1Dvdjt0fZ6w6L1sxe9lvGNeOinv/Us+dxQ7BOeE7BJF3
 /WgrGP+sKkiCwgtlIav+QLTyw0I9q/C6K4oh8sXP5FaeJ6kb6dqI2bZ5I9fyASpg0Qm9I1+mLY2
 V4lPLAwqpbGoqf/+ckIWIr+R9dH/Gukave1WDo15cx6yPOr9QYq5nfsX+7tOKeWzvdFMDltFeW5
 vHUQvkgF2cYtw1elrChQomJONnsQtheno+jU9dSSZ5wT8in91UZVRzxmdKIolFb/CwXOog6A5XI
 1sAOv1sLjolVxeoS9r+UpdO4cwyhuAadhPBBv+alHuzf7HKr4z3xO27Mi0PgvZO4L2OtZXKMpO/
 Jg5teDE9T3p5hyXBS4Cr3xlsl9Zn2Ic=
X-Received: by 2002:a05:600c:674f:b0:4a2:1655:87db with SMTP id
 5b1f17b1804b1-4ac1228a434mr161720045e9.0.1793516593152; 
 Sun, 01 Nov 2026 00:03:13 -0700 (PDT)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4abeb77af8csm254785765e9.1.2026.11.01.00.03.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Nov 2026 00:03:12 -0700 (PDT)
From: Ana Bobillo <anabobillo3@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, Bin Meng <bmeng.cn@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Alexey Charkov <alchark@flipper.net>,
 Javier Martinez Canillas <javierm@redhat.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Subject: [PATCH v3 14/14] mmc: Always use a 512-byte block length
Date: Sun, 01 Nov 2026 07:03:11 +0000
Message-ID: <10123a81-af26-4fbf-8bb1-f6c66c5849ad@gmail.com>
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

mmc_startup() sets the block size of the card's block device from the
READ_BL_LEN field of its CSD and only caps it at 512 bytes from above. A
card reporting a READ_BL_LEN below 9, which the SD specification
reserves, gives the block device a block size below 512 bytes. A block
that small cannot hold an MBR or a GPT header, and the partition and
filesystem code assumes at least 512 bytes, as the patch adding
blk_valid_blksz() describes. Nor does the code bound an MMC card's
WRITE_BL_LEN from below, though mmc_bwrite() then writes blocks of that
length where the block layer passes 512-byte ones.

The check in blk_post_probe() does not catch this. It is left out of
SPL, TPL and VPL, which commonly boot from MMC. In U-Boot proper,
mmc_startup() runs again whenever the card is initialised again, by
'mmc rescan' or 'mmc dev', or after the card-detect poll has seen it
removed, and sets the block size of a block device that is already
probed.

Use 512-byte blocks whatever READ_BL_LEN and WRITE_BL_LEN say, as the
code already did in DDR mode and as Linux does for its transfers; the
capacity is still computed with the block length the card reports. Only
some old MultiMediaCards could have blocks that really are smaller, and
the partition and filesystem code could not use those either. This makes
the DDR case redundant, so drop it. The SPL does not grow: imx28_btt3's,
close to its size limit, gets 16 bytes smaller.

Make the READ_BL_LEN that the sandbox MMC emulator reports settable, and
test that a card initialised again with a READ_BL_LEN of 0, 8 or 11 gets
512-byte blocks and can be written and read back.

Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
---
Changes in v3:
- New patch: blk_post_probe() does not see the block size the MMC code
  sets when it initialises a card again, as the v2 cover letter said

 arch/sandbox/include/asm/test.h | 10 +++++++++
 drivers/mmc/mmc.c               | 34 +++++++++-------------------
 drivers/mmc/sandbox_mmc.c       | 11 ++++++++-
 test/dm/mmc.c                   | 40 +++++++++++++++++++++++++++++++++
 4 files changed, 71 insertions(+), 24 deletions(-)

diff --git a/arch/sandbox/include/asm/test.h b/arch/sandbox/include/asm/test.h
index 76e2f11b059..f73bf51ef35 100644
--- a/arch/sandbox/include/asm/test.h
+++ b/arch/sandbox/include/asm/test.h
@@ -143,6 +143,16 @@ void sandbox_flash_set_block_size(struct udevice *dev, int block_size);
  */
 void sandbox_scsi_set_block_size(struct udevice *dev, int block_size);
 
+/**
+ * sandbox_mmc_set_bl_len_shift() - Set the READ_BL_LEN an SD card reports
+ *
+ * @dev:	Sandbox MMC controller
+ * @bl_len_shift: log2 of the block length, as the CSD's READ_BL_LEN field
+ *
+ * The host reads it when it next initialises the card.
+ */
+void sandbox_mmc_set_bl_len_shift(struct udevice *dev, int bl_len_shift);
+
 /**
  * sandbox_osd_get_mem() - get the internal memory of a sandbox OSD
  *
diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
index 4835ce0c64b..90331823926 100644
--- a/drivers/mmc/mmc.c
+++ b/drivers/mmc/mmc.c
@@ -2555,7 +2555,7 @@ error:
 static int mmc_startup(struct mmc *mmc)
 {
 	int err, i;
-	uint mult, freq;
+	uint mult, freq, bl_len;
 	u64 cmult, csize;
 	struct mmc_cmd cmd;
 	struct blk_desc *bdesc;
@@ -2652,14 +2652,7 @@ static int mmc_startup(struct mmc *mmc)
 	mmc_select_mode(mmc, MMC_LEGACY);
 
 	mmc->dsr_imp = ((cmd.response[1] >> 12) & 0x1);
-	mmc->read_bl_len = 1 << ((cmd.response[1] >> 16) & 0xf);
-#if CONFIG_IS_ENABLED(MMC_WRITE)
-
-	if (IS_SD(mmc))
-		mmc->write_bl_len = mmc->read_bl_len;
-	else
-		mmc->write_bl_len = 1 << ((cmd.response[3] >> 22) & 0xf);
-#endif
+	bl_len = 1 << ((cmd.response[1] >> 16) & 0xf);
 
 	if (mmc->high_capacity) {
 		csize = (mmc->csd[1] & 0x3f) << 16
@@ -2672,18 +2665,21 @@ static int mmc_startup(struct mmc *mmc)
 	}
 
 	mmc->capacity_user = (csize + 1) << (cmult + 2);
-	mmc->capacity_user *= mmc->read_bl_len;
+	mmc->capacity_user *= bl_len;
 	mmc->capacity_boot = 0;
 	mmc->capacity_rpmb = 0;
 	for (i = 0; i < 4; i++)
 		mmc->capacity_gp[i] = 0;
 
-	if (mmc->read_bl_len > MMC_MAX_BLOCK_LEN)
-		mmc->read_bl_len = MMC_MAX_BLOCK_LEN;
-
+	/*
+	 * Use 512-byte blocks whatever READ_BL_LEN and WRITE_BL_LEN say. A
+	 * larger value is the most the card takes in one block, and a smaller
+	 * one, which the SD specification reserves, would give the block
+	 * device a block size the partition and filesystem code cannot use.
+	 */
+	mmc->read_bl_len = MMC_MAX_BLOCK_LEN;
 #if CONFIG_IS_ENABLED(MMC_WRITE)
-	if (mmc->write_bl_len > MMC_MAX_BLOCK_LEN)
-		mmc->write_bl_len = MMC_MAX_BLOCK_LEN;
+	mmc->write_bl_len = MMC_MAX_BLOCK_LEN;
 #endif
 
 	if ((mmc->dsr_imp) && (0xffffffff != mmc->dsr)) {
@@ -2765,14 +2761,6 @@ static int mmc_startup(struct mmc *mmc)
 
 	mmc->best_mode = mmc->selected_mode;
 
-	/* Fix the block length for DDR mode */
-	if (mmc->ddr_mode) {
-		mmc->read_bl_len = MMC_MAX_BLOCK_LEN;
-#if CONFIG_IS_ENABLED(MMC_WRITE)
-		mmc->write_bl_len = MMC_MAX_BLOCK_LEN;
-#endif
-	}
-
 	/* fill in device description */
 	bdesc = mmc_get_blk_desc(mmc);
 	bdesc->lun = 0;
diff --git a/drivers/mmc/sandbox_mmc.c b/drivers/mmc/sandbox_mmc.c
index a24520f2e78..34a5c7506ab 100644
--- a/drivers/mmc/sandbox_mmc.c
+++ b/drivers/mmc/sandbox_mmc.c
@@ -29,6 +29,7 @@ struct sandbox_mmc_plat {
 struct sandbox_mmc_priv {
 	char *buf;
 	int csize;	/* CSIZE value to report */
+	int bl_len_shift;	/* READ_BL_LEN value to report */
 	int size;
 };
 
@@ -62,7 +63,7 @@ static int sandbox_mmc_send_cmd(struct udevice *dev, struct mmc_cmd *cmd,
 		break;
 	case MMC_CMD_SEND_CSD:
 		cmd->response[0] = 0;
-		cmd->response[1] = (MMC_BL_LEN_SHIFT << 16) |
+		cmd->response[1] = (priv->bl_len_shift << 16) |
 				   ((priv->csize >> 16) & 0x3f);
 		cmd->response[2] = (priv->csize & 0xffff) << 16;
 		cmd->response[3] = 0;
@@ -144,6 +145,13 @@ static const struct dm_mmc_ops sandbox_mmc_ops = {
 	.get_cd = sandbox_mmc_get_cd,
 };
 
+void sandbox_mmc_set_bl_len_shift(struct udevice *dev, int bl_len_shift)
+{
+	struct sandbox_mmc_priv *priv = dev_get_priv(dev);
+
+	priv->bl_len_shift = bl_len_shift;
+}
+
 static int sandbox_mmc_of_to_plat(struct udevice *dev)
 {
 	struct sandbox_mmc_plat *plat = dev_get_plat(dev);
@@ -169,6 +177,7 @@ static int sandbox_mmc_probe(struct udevice *dev)
 	struct sandbox_mmc_priv *priv = dev_get_priv(dev);
 	int ret;
 
+	priv->bl_len_shift = MMC_BL_LEN_SHIFT;
 	if (plat->fname) {
 		ret = os_map_file(plat->fname, OS_O_RDWR | OS_O_CREAT,
 				  (void **)&priv->buf, &priv->size);
diff --git a/test/dm/mmc.c b/test/dm/mmc.c
index cdebb955196..d393883855c 100644
--- a/test/dm/mmc.c
+++ b/test/dm/mmc.c
@@ -6,6 +6,7 @@
 #include <dm.h>
 #include <mmc.h>
 #include <part.h>
+#include <asm/test.h>
 #include <dm/test.h>
 #include <test/test.h>
 #include <test/ut.h>
@@ -51,3 +52,42 @@ static int dm_test_mmc_blk(struct unit_test_state *uts)
 	return 0;
 }
 DM_TEST(dm_test_mmc_blk, UTF_SCAN_PDATA | UTF_SCAN_FDT);
+
+/* Test that a card with a READ_BL_LEN other than 9 gets 512-byte blocks */
+static int dm_test_mmc_bl_len(struct unit_test_state *uts)
+{
+	static const int shift[] = { 0, 8, 11 };
+	struct blk_desc *dev_desc;
+	char write[512], read[512];
+	struct udevice *dev;
+	struct mmc *mmc;
+	int i, j;
+
+	ut_assertok(uclass_get_device_by_seq(UCLASS_MMC, 0, &dev));
+	ut_assertok(blk_get_device_by_str("mmc", "0", &dev_desc));
+	mmc = mmc_get_mmc_dev(dev);
+
+	for (i = 0; i < ARRAY_SIZE(shift); i++) {
+		/* Initialise the card again, as 'mmc rescan' does */
+		sandbox_mmc_set_bl_len_shift(dev, shift[i]);
+		mmc->has_init = 0;
+		ut_assertok(mmc_init(mmc));
+
+		ut_asserteq(512, mmc->read_bl_len);
+		ut_asserteq(512, mmc->write_bl_len);
+		ut_asserteq(512, dev_desc->blksz);
+		ut_asserteq(9, dev_desc->log2blksz);
+
+		/* mmc0 reports 1024 blocks of the length in READ_BL_LEN */
+		ut_asserteq((1024ULL << shift[i]) / 512, dev_desc->lba);
+
+		for (j = 0; j < sizeof(write); j++)
+			write[j] = i + j;
+		ut_asserteq(1, blk_dwrite(dev_desc, 1, 1, write));
+		ut_asserteq(1, blk_dread(dev_desc, 1, 1, read));
+		ut_asserteq_mem(write, read, sizeof(write));
+	}
+
+	return 0;
+}
+DM_TEST(dm_test_mmc_bl_len, UTF_SCAN_PDATA | UTF_SCAN_FDT);
