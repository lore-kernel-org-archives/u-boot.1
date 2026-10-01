Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 133B4CA5FDD
	for <u-boot@archiver.kernel.org>; Thu,  1 Oct 2026 21:24:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B12BD40AF0;
	Thu,  1 Oct 2026 21:24:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8Myo-Lc16loJ; Thu,  1 Oct 2026 21:24:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org D540440B02
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790889887;
	b=b7FXYcQmrZ/OQcldKsw0v647+1AHRl/JBFv7gWXfO0XjuVCuVCCWE86UN+HoxfrumgoN
	 ffsHkuBQ+If4P9FjW+Qou5Kjg3iqto/1qRhvaqYhtUJKQKyeHL2gzhBngeF+U69DKtuOQ
	 AAR8VytCra8Mhwo1VkrW1PNLMuaQZDBF2oNZ+J21r++RPa5bP3TdilJF+MwOA7+0Lgnrv
	 PFLNRHi5UW0tgILj20CVHW+y2tunIbCY3HMZBj5xfh3ie0Pi8kkQMRIJsxYftPHaEs25m
	 YodQRIwbskRCn3Vm38SqiDrSc5Z6FfBOvU/I7ovKnfPHjin8lLVefM7Dkr//U6GNHxg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790889887;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=m/LRDTbdTfV0r3UVaGMSOvpizKPKiwrDk4n9ycmAxTQ=;
	b=p5JBiT+LVdCQ+b4XXmMaHgawln5c4uVLtbVvrm2Z1pbtjv8a0671Y0Ykh/9RnQzB1OJ2
	 s/FhZt5AZhClX9fP9pOZF3kBRExbNlPksvsshGj/0+WwbylZYKT51O0iT+jgVG0hObW0o
	 pLWKitR3fluBnEsfSgMnGouutgYf6fZUnkVsuKb7RJEFyezoOfBYbxIg2GZjJ0FxDtk9q
	 O+i2pFaT5zJJVtHqx/NFrp98VJUfoqRyAlSkK/aNKqBFAKEr1go51BX3bzpZnvZQuXYRR
	 rEFjcW6wGjiEhmq2yMzvvdBoCp0sbvzt3Y7fRYw6W+1QFiBwR9zHIyE50ZqLU3wtaVw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790889887;
	bh=m/LRDTbdTfV0r3UVaGMSOvpizKPKiwrDk4n9ycmAxTQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cX72c0knZog73i4Q5mIrZEVySrcY3w73xpRk5+p2J008GJtxNkZBXF/XNJ+EDMO5H
	 1Ow9Kbugro1AYVMYg32+1fbCYci7Z5htsgys3o+Crek8AXN7gdNiHjkmit6+yICOK0
	 8VBzHq+1DjusSHw+gSkm5UeNVTG/CmKeExPRGCPyN0Jrg9SwD9OUzS2GRpB+F11YUN
	 q0YuvQf/3cfMqTnXyHwp2jxnAoEKV4dq25xlkKtWsy5rOCLK/ThFaAdC+6+pECoB7Q
	 R7bqG/KEWfQAS0uscxyYDkDo3gaJ81cLjZaKlUY9UWBoMR3sMImxXDeZiNClnSXDFa
	 9Isx6NXFxZykA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D540440B02;
	Thu,  1 Oct 2026 21:24:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id AFFB2282
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 20:45:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 95B68811DA
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 20:45:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9L0dEBd6kMZb for <u-boot@lists.u-boot-project.org>;
 Thu,  1 Oct 2026 20:45:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org E7CBF811D4
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:39::c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790887512;
 b=OTldcgf+YZt0creikVKMRadUEhkvJ0vvFKSOgkpxGXRhlomzRcP2dSaHDOlAwCPOKkUp
 mrR/AMkR3MEweGCfVJMR3MmyVIQGAhowJ1WDHxKAbvW96nBA15JRdnP4KyMgqxnq0ePem
 QuA0KU5L/RNbuQyHLuHyK8RNuGJm1awObTjcnzNpDyYY9O7lYf/jb5klyYh6XSSZLnC6n
 DlGEfBYtSA4IkUlov4zXK0PCy2tZKFC4rhSjoFvq6gmKkULkz9FK23flKjCCteGSeW6sE
 VY4DhucWO0FFN9Vbg1pl/yhEx1YBO+xfQRnDXXTqXyqmBWoUxIEcWJKEkEVkhf0UmVg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790887512;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=m/LRDTbdTfV0r3UVaGMSOvpizKPKiwrDk4n9ycmAxTQ=;
 b=jPcdl/0YeZ498g/iaiiGjK3bbso3aVLPWYUbcvXYSE3I0r5IHWfeeEbNMMWGWr90BuxW
 tUJ5k/t4Oy2wfQE+vo355IDoOfDd69OkddW8OwvDE/x6M19N1yBZHny2AVE6n9/Mgr2Rf
 TcaFayRYlIvVkBpsG0i271h2JNON1caIdyvOQPH8ZXAAelvN41HhbFS3qM8+2tBCRorTT
 BiDYjleTtKlc62Fv8LY207LO4Uzt053J0IO0BtyutV1gDP/B2eP1/s6rUwXTR/MnpAonu
 ML6WMod4EXR2K4kpyHczFt2zwKg5MxbBXLspJNADty6QO9L3gvO7d6Ve0Yuo994q3hA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b="PQl5Lr3/"; 
 arc=none smtp.remote-ip="2607:f8b0:4864:39::c"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:39::c;
 helo=mail-pj2-x0c.google.com; envelope-from=lqing2013@gmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=PQl5Lr3/
Received: from mail-pj2-x0c.google.com (mail-pj2-x0c.google.com
 [IPv6:2607:f8b0:4864:39::c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E7CBF811D4
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 20:45:11 +0000 (UTC)
Received: by mail-pj2-x0c.google.com with SMTP id
 98e67ed59e1d1-3a0eeda3e03so3024518a91.1
 for <u-boot@lists.u-boot-project.org>; Thu, 01 Oct 2026 13:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790887510; x=1791492310;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=m/LRDTbdTfV0r3UVaGMSOvpizKPKiwrDk4n9ycmAxTQ=;
 b=PQl5Lr3/xe/TmAMfVvWOpDqAXrvMOzxwWB+9CxJcB8AdiDOSiV0y+IbpNYamYi9c9Q
 /eCfLzBDwiXI91Ma09zlMZRd4zWm+/jrcIAtoULtfXZiwcyCeoG7ckvoBdlGctMbjGCg
 gAIfZZkwaJXdRa8q5FdBSbBMEtfAM0d9SHIT8mENkxpW9ajNp3cMsv6UXc0b7gEZvLvO
 Brz/DSJOQP7hqRtgPPVj6M7xx/xebitEuih2pNIzN6Lw3mKTPX7HLYucNmt7zK5bN/1X
 YqS8QlVo/15iAjujGsgTbsCAmE2a7BJ9j4u+sCSFB6jx+HwNy6G6h8hwGENHpgipz3/4
 JXng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790887510; x=1791492310;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=m/LRDTbdTfV0r3UVaGMSOvpizKPKiwrDk4n9ycmAxTQ=;
 b=YWTRaQ/LdG6PUaRWzVIySpHB7zWSpEdl/zqUCqj8gGQCHnfkSxVANtQ4VFowV0H7JH
 SlcyoFSprnlzg5TG3h20OTH/n/RB4xYyMPSG85xuu0mw1RVrrAz7UMxZNY7c2+q+u6Cd
 UL+7/PotlAF3ISOHJt/CWqbIoco38QB5vztzu4snOvWEqt29F738TPnOnfltFVq52Abj
 gwN9D8wvM4tisde8VuTVhwOqVwghL7BUXtfOBzTvWLZwdf5G+TM4Ho6+vubzDd2okYUP
 KBW+d1gIdjErwhXC/ZOEpk0M6PpupX8Xa4NvKbxye4IBbpJKr6QXuPtNjlgKHpQccNAO
 xpfg==
X-Gm-Message-State: AFq9FYIQn3sh9Yru4AsVPzTGDzVoBObc9iQciLHzS2CQGLO6bZVGIgZx
 apWb6qb+NCWI0J6LyFXPbzeWgwbgVg5qyXmbfbDVqn3pKqH4sChZEkJ8ScB9JziNH58P1gtY
X-Gm-Gg: AYBFou2pTNeSjHBMKqicBGb7QR0cAj7SbqRxiqoXfvsn9eaeaKnVF5bO6ndeg7zEIxG
 6IVwNUJPHrw/LegAOYxaa1WawjbihE+jvC8Mj3NRM7DLAf0v9RmEkEZkaMEWOA8jbToVKVJAUmb
 /LzXHTxn5WimAh/m45rC2aJY6Ul35VTM96g/SnEKnzkIm0vxdLdNpHNmf4p2E8FUMEI1d1CiIKm
 QVsGj6W7dR5oK6yovLH9NY+QMhINjsAU2IKSdoxps/9yqphZq8ezj+XjIBvUbpcsAm53ferJSnu
 w5xabPIBZRTh221E3UlU1TdT850lXMnTSfP/ksi0pB0MI/4/STJPa0RHB+qoGTCRmB1trwfXdhj
 JAU3PXdhYxZ6YW4OnY3hA8m3QF5ylwXZunFSXWEDCfyy6Q3rbVf43MFnK7Si7SWQf9c+GM6wUbP
 n74zSCRU9Epfi+yy2xv/aSlv0NjSKqsv0weWZ/zVbcExHOFVnLzBjKhNV1eG+lQgcU9a9UYhP9Y
 kiPsH80uc19LXVoynwocJBtR1i7T2MmXButBN0=
X-Received: by 2002:a17:90a:d64b:b0:39d:f08e:e6e7 with SMTP id
 98e67ed59e1d1-3a6ce3570eamr302500a91.9.1790887510388; 
 Thu, 01 Oct 2026 13:45:10 -0700 (PDT)
Received: from localhost.localdomain
 ([2409:8a30:2e86:1710:20ae:2ce4:794c:d830])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a6cd634734sm883877a91.17.2026.10.01.13.45.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 01 Oct 2026 13:45:09 -0700 (PDT)
From: Qing Li <lqing2013@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Qing Li <lqing2013@gmail.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 3/9] ufs: bound request size,
 enforce timeout and latch failures
Date: Fri,  2 Oct 2026 04:44:46 +0800
Message-ID: <ec3f2172a8d12e33155d2da9efd48880f34ab3fe.1790887323.git.lqing2013@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1790887323.git.lqing2013@gmail.com>
References: <cover.1790887323.git.lqing2013@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 01 Oct 2026 21:24:42 +0000
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

A single large request (up to 32 MiB, 128 PRDT entries) can stall on
some controllers, and a stuck request hung U-Boot forever because the
UTP completion timeout was only checked once the link had left
SLOWAUTO mode.

- reduce the maximum request size to 4 MiB (16 PRDT entries)
- always enforce the UTP completion timeout
- latch io_failed after a timeout or controller error so further
  requests fail immediately instead of reusing broken descriptors

Signed-off-by: Qing Li <lqing2013@gmail.com>
---
 drivers/ufs/ufs-uclass.c | 30 ++++++++++++++++++++----------
 drivers/ufs/ufs.h        |  2 ++
 2 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/drivers/ufs/ufs-uclass.c b/drivers/ufs/ufs-uclass.c
index 6ef01f8e4aa..7a8d3e9de53 100644
--- a/drivers/ufs/ufs-uclass.c
+++ b/drivers/ufs/ufs-uclass.c
@@ -60,7 +60,7 @@
 #define MAX_PRDT_ENTRY	262144
 
 /* maximum bytes per request */
-#define UFS_MAX_BYTES	(128 * 256 * 1024)
+#define UFS_MAX_BYTES	(4 * 1024 * 1024)
 
 static inline bool ufshcd_is_hba_active(struct ufs_hba *hba);
 static inline void ufshcd_hba_stop(struct ufs_hba *hba);
@@ -915,6 +915,9 @@ static int ufshcd_send_command(struct ufs_hba *hba, unsigned int task_tag)
 	u32 intr_status;
 	u32 enabled_intr_status;
 
+	if (hba->io_failed)
+		return -EIO;
+
 	ufshcd_writel(hba, 1 << task_tag, REG_UTP_TRANSFER_REQ_DOOR_BELL);
 
 	/* Make sure doorbell reg is updated before reading interrupt status */
@@ -926,16 +929,15 @@ static int ufshcd_send_command(struct ufs_hba *hba, unsigned int task_tag)
 		enabled_intr_status = intr_status & hba->intr_mask;
 		ufshcd_writel(hba, intr_status, REG_INTERRUPT_STATUS);
 
-		if (hba->max_pwr_info.info.pwr_rx != SLOWAUTO_MODE &&
-		    hba->max_pwr_info.info.pwr_tx != SLOWAUTO_MODE) {
-			if (get_timer(start) > QUERY_REQ_TIMEOUT) {
-				dev_err(hba->dev,
-					"Timedout waiting for UTP response\n");
-				return -ETIMEDOUT;
-			}
+		if (get_timer(start) > QUERY_REQ_TIMEOUT) {
+			hba->io_failed = true;
+			dev_err(hba->dev,
+				"Timedout waiting for UTP response\n");
+			return -ETIMEDOUT;
 		}
 
 		if (enabled_intr_status & UFSHCD_ERROR_MASK) {
+			hba->io_failed = true;
 			dev_err(hba->dev, "Error in status:%08x\n",
 				enabled_intr_status);
 
@@ -1030,6 +1032,9 @@ static int ufshcd_exec_dev_cmd(struct ufs_hba *hba, enum dev_cmd_type cmd_type,
 	int err;
 	int resp;
 
+	if (hba->io_failed)
+		return -EIO;
+
 	err = ufshcd_comp_devman_upiu(hba, cmd_type);
 	if (err)
 		return err;
@@ -1661,16 +1666,21 @@ static int ufs_scsi_exec(struct udevice *scsi_dev, struct scsi_cmd *pccb)
 {
 	struct ufs_hba *hba = dev_get_uclass_priv(scsi_dev->parent);
 	u32 upiu_flags;
-	int ocs, result = 0;
+	int err, ocs, result = 0;
 	u8 scsi_status;
 
+	if (hba->io_failed)
+		return -EIO;
+
 	ufshcd_prepare_req_desc_hdr(hba, &upiu_flags, pccb->dma_dir);
 	ufshcd_prepare_utp_scsi_cmd_upiu(hba, pccb, upiu_flags);
 	prepare_prdt_table(hba, pccb);
 
 	ufshcd_cache_flush(pccb->pdata, pccb->datalen);
 
-	ufshcd_send_command(hba, TASK_TAG);
+	err = ufshcd_send_command(hba, TASK_TAG);
+	if (err)
+		return err;
 
 	ufshcd_cache_invalidate(pccb->pdata, pccb->datalen);
 
diff --git a/drivers/ufs/ufs.h b/drivers/ufs/ufs.h
index 0f6c93fbce7..c35f395ea7a 100644
--- a/drivers/ufs/ufs.h
+++ b/drivers/ufs/ufs.h
@@ -719,6 +719,8 @@ struct ufs_hba {
 	struct ufs_pwr_mode_info max_pwr_info;
 
 	struct ufs_dev_cmd dev_cmd;
+	/* Do not reuse UTP descriptors after a request failed to quiesce. */
+	bool io_failed;
 };
 
 static inline int ufshcd_ops_init(struct ufs_hba *hba)
-- 
2.50.1 (Apple Git-155)

