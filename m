Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4EF3606A31B
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 12:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=VT44uRYf;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GHw+CElr
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AE56280F95;
	Wed,  4 Nov 2026 12:51:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MkBsSZNkJ0ek; Wed,  4 Nov 2026 12:51:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B907381086
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793796718;
	b=CHPCHybeuFtX/+D/v9HORBsKsaeQW1DCQpK2z1cYOgJikBRZ1vzWB6cBz4cdA71pxIF2
	 0hjM+c0qXPrC+iH+ZeylOpwI5UNyjCbhgi3mXoZuGkRxOZWAVPjJ5k+bLE9mxxh3jXc1q
	 yEJXDLGL2mmMyqnqq7l3lGwIMMJ8E1VBb2lYoOcitqhgfpdzzojd4QNLkWfVkmiXcEkQC
	 N5klAob2Oab7yFnoTZUerTIooFnAN+RmPO9Yg6nscYCCCIFt3JDO+2OxheedE3aL6q+n/
	 stAw35kOwQWyueItLkHI/GdHCjCF60GhUPL6M/BqAESW/PIh4J2AlJJsxrRwcvtSjRg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793796718;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=qO5VskAPpf/j0nAvWLXMo5w5HsgZ1/qXRSe5Q1Yx3AE=;
	b=AHxCjpmu4KSg2sayQbqKyi+Cfks3m6H/9jxaobKnKsB9olQ3aclBTkE3vyx7OYQ7lYvY
	 8AIMHHLyfYFe4sfnR35M+x+IVY2UBTrIinQ3kzHwx+UypXHKB5bZ6Zz7SVgJBmelhxnbT
	 ddASD6+RfYjBDF8ffvG3j+q32LBZXLZ7hU6R42jTLvtMAce0OQPcijz17CCGHw6bq1zH0
	 lOpLQlruNevdS5elC9rlCWhEZ8rN8S/AAPJpXHph/qp9Ido2HdAUPkY9ZPJ3nMCu8OT0W
	 1yKmOqbfzmIS8ngjNNrOcwLv+QK7Gr6D9wBllsbs8OFnod8Y0ha0X3WdcyztEH84tkQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793796718;
	bh=qO5VskAPpf/j0nAvWLXMo5w5HsgZ1/qXRSe5Q1Yx3AE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VT44uRYfgJWWP9AxIbC+WezDcow9NSQggHn4jNuqck1HtvT60Q7j5od2NbCTMDsal
	 +wEzfDs6OX0F1vkwxuavgdzj0zuBud5/8rVeSYbFW7MQwYjjQlbjaP/DDO4aRHKdxU
	 LLbzFklCGTmDx1MyJbVM2V03v9VrQt42nIc4uzyvLqf4addL0IqugRh1UQ7akW6FaH
	 AF7UqU/k1h8SnTzDZNGSUYKF/JaxMERbuV+z/w1ueBMLXkRObQsuDCdjjSc6Buaa7F
	 vpEvNUT3Od0wCvNGpP1H1IJR8TkwNfFec3O++00hPrd+3bbZlhquOTDFQWlYmXTHVb
	 A+MooxGUj3QGA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B907381086;
	Wed,  4 Nov 2026 12:51:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 88E75A10
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 12:51:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7A8AF607C4
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 12:51:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Jod0s3gH5Nbp for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 12:51:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 40E68605DA
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::62a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793796716;
 b=LXtXErCsfYl3/ieC47nHczYwJro/1rpUDroQ8+s03HHdRpMJSYrB3UaNcLacdaQGq0zm
 JRiVx/TtuaJ5gQC1toXRF/wH8f/cyUKDAfFRKw0rCY4OCeXOfMMpDEkOt42DVBLP/G1AX
 f5rxsGHjRE4tzksgULr13+Y5Zaq2hXs5dso1aFE6iphP2TQUjg+h4HU2oW7JhFvvTyB5w
 LYUsJz7caoYj4L+QL6xWv4xOc1rllKLn+ehp5yDAzetf3V6FjfYaNUiX7mk6V274XGmon
 bWcUWpGB7/3VbibMu/X1BcHtuVenmK7ltrwEba/lsnbMVrAqNIamIoExa4BaKIy6VDQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793796716;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References;
 bh=qO5VskAPpf/j0nAvWLXMo5w5HsgZ1/qXRSe5Q1Yx3AE=;
 b=bKWOrCkvvF18NYBH0FIwgOx6mbCIiEBiI1PyExwEn0jv9fWM5SzvEtSB5rQVAcdUWSJZ
 vh1Jcg4eoQn5uX1/pHz+oPzf8KLJ5z2L1PnQMARonZ7WxuhE9hLgre57OaVpZ9z5N2uUq
 IVo19BIN9v+0fzyzBP9IVL1lObIF881p9BN+7sBBfCVhQHdZbv/eN/2Zjw2pDnMDAwY8q
 1NfFnH24GVb4QuFD+E6NMTVYrc2tS6gO9PA8gH+gvoPkMyND0gfXE8zgd8lrmzcEy9FAW
 wPxOsbikJoSA/o+JWqz+DFFfOV2ckM+0bOrKy70saM3V//i2j27Rlw47MNI/8iHFFjg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=GHw+CElr; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::62a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62a; helo=mail-ej1-x62a.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=GHw+CElr
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 40E68605DA
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 12:51:55 +0000 (UTC)
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-c4cac7a7d3cso88622966b.3
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 04:51:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793796714; x=1794401514;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=qO5VskAPpf/j0nAvWLXMo5w5HsgZ1/qXRSe5Q1Yx3AE=;
 b=GHw+CElr40CtT1m8QLNu5feCpAkH893/58xlU7OM47ysFV7ReZ4wlm7bkmfcl6M4Bh
 b35CJ8e8WpHUhnE2ScwtVC7b70OCeKOoezCui08qGxutk/bQ2wJcpzxQ3FmH+3LF6DYO
 3Ng4tZq2oIlz+yMMZ8oAr5I6rpfZUEPML7A3QKObx+siamqWAy0bA6Sf3SnK63gTmns7
 vKp+Ocx6A1oH3nL5ghGKbYHx1qGnZ1nuz/M/UnCMUWsNfqwNlBOKcQDl8PLJw0Iruahz
 7ISd7nkAhu5+ZPprz5Y2ZwogzQpR9tEiYRQM05sPKBzX1U1BWtNUvoQ5lOL6kkNrRJG6
 jPkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793796714; x=1794401514;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qO5VskAPpf/j0nAvWLXMo5w5HsgZ1/qXRSe5Q1Yx3AE=;
 b=pgfeyNrBbM0/CNUwElRDSoOuEgrNLxWcVdzlZs057FvZJYUIsLwdgV/4ISku5WB5KM
 CCEbImtVnHd51bNGMGQFgLg81+/DBSx011BKwwv+mXCHY6tIpKsl2e9Q9b/HI7SMi0jL
 2vyBUtETlAqMUie76Ep1rh6KZauBOqMalYuA3JAiuL5cQJ55lwDnabvfuhpIsVs9t7Z5
 mp0m8Cacv55ANcvTyvAWfA1VCIzZ3ikOIQCRpxtEgUZS9jiI3Ms62jN0XGrHk8AcDNSm
 hXIQOerf0E4qt6qiSlznn+2q41It7ld4k9ESaAMt2hrsFA1qvu3fgDHDtem0obF9vj+2
 u3ZQ==
X-Gm-Message-State: APuU4Z+DBmuwMPuftvR0mPSBGlzzngUaJBpBC7gsOOdae8EgBox1Rs6n
 aTUwGFGft+7WIwtZhzrBfQx1h72+URqUSCNT+BNK33hyJPH02kci+r6o
X-Gm-Gg: AYBFou3NtYjGpCcTFY9PaudMJT9hs11LND9+TKefPlgUUaGYV77/uvJapa9foQdFz95
 +YVw6j3zWQ7m3/pSpnHuY/1W00p6QkEt+WK+OYhIUs5E73XrEkE+8qCyYZ+alTacAQNt0Tq5pQ/
 +ZLUyefgJ6MFvUWLiAErQxQOIo0iJe7t0KVWZB/OEGKPQEfNJmXaXWY9qMubWI8nc99fs3r+D2X
 2eEH0GEUDs7J3e/ejmVys38xq6cgHhHNT6kYpKgGEao3NqJnublO1j+DPy7G+U1lzmVpoPhbwmU
 aWCyNibKE2o7PIJQiPKirL38OP5tPeNY4NHaUc8dQzzACD4PGt7tT/tu3Mze4FWD6MKbZuy1MmS
 O5GoqAp784pLFE0mssU2dOUB1JVZw+r77LLM/RZkeeulCX4j4h7lLUi9o+JNd7LHOm2UXSkY0ZW
 sTsVqhMEVztWc9hjM10HPQmaYktS/rm0odCL0Yuc5GkQXyPNjG7ZHP6dLBqDGELr4HQyU4SJA4D
 FGOGM3Izer+sUf/tHPVYjp0tKOCPZaA/+k+nwxU9zTMqFM9GfUqLG3I4TxKjwtFtVL3777puhCR
 FkdyWfYgUvSxfi3W5e4yf4wzWp0mL9o=
X-Received: by 2002:a17:907:1b08:b0:c41:835b:8f24 with SMTP id
 a640c23a62f3a-c4ca7adc682mr1273954466b.49.1793796713898; 
 Wed, 04 Nov 2026 04:51:53 -0800 (PST)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4d0e4a76d6sm66317766b.84.2026.11.04.04.51.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Nov 2026 04:51:53 -0800 (PST)
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
Subject: [PATCH v4 14/14] mmc: Always use a 512-byte block length
Date: Wed, 04 Nov 2026 12:51:52 +0000
Message-ID: <6a4e3afb-4336-4e21-b5c7-b9ec88a9b6bb@gmail.com>
In-Reply-To: <1369653d-e0d4-4baf-adef-895a24190250@gmail.com>
References: <1369653d-e0d4-4baf-adef-895a24190250@gmail.com>
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
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
filesystem code assumes at least 512 bytes. Nor does the code bound an
MMC card's WRITE_BL_LEN from below, though mmc_bwrite() then writes
blocks of that length where the block layer passes 512-byte ones.

The check in blk_post_probe() does not catch this. It is left out of
SPL, TPL and VPL, which commonly boot from MMC. In U-Boot proper,
mmc_startup() runs again whenever the card is initialised again, by
'mmc rescan' or 'mmc dev', or after the card-detect poll has seen it
removed, and sets the block size of a block device that is already
probed.

Use 512-byte blocks whatever READ_BL_LEN and WRITE_BL_LEN say, as the
code already does in DDR mode and as Linux does for its transfers; the
capacity is still computed with the block length the card reports. Only
some old MultiMediaCards could have blocks that really are smaller, and
the partition and filesystem code could not use those either. This makes
the DDR case redundant, so drop it. The SPL does not grow: imx28_btt3's,
close to its size limit, gets 16 bytes smaller.

Make the READ_BL_LEN that the sandbox MMC emulator reports settable, and
test that a card initialised again with a READ_BL_LEN of 0, 8 or 11 gets
512-byte blocks and can be written and read back.

Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
Changes in v4:
- Drop the reference to the patch adding blk_valid_blksz() from the
  commit message, and say the code already "does" use 512-byte blocks
  in DDR mode (Simon)

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
