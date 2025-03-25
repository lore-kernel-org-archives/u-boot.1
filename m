Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6188C36012
	for <u-boot@archiver.kernel.org>; Tue, 25 Mar 2025 13:03:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A6F281D3B;
	Tue, 25 Mar 2025 14:03:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ulFwX3Y7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41DE581DDF; Tue, 25 Mar 2025 14:03:04 +0100 (CET)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31FE381D27
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 14:03:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4394a823036so56126885e9.0
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 06:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742907781; x=1743512581; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=55RcLJ+tquhWLa3l8UWa3Wt1h/0nWm7MQB6yx01lSY4=;
 b=ulFwX3Y7/0acRNUT24oA9kQqHJGkEn004Lyiw8CMCDbEcvY2Th3o8eeRhSOscfAMcq
 c2mdDArKaT4TZkiVwaskMoVuagzbAFlDIZh30eqdP53WHtemmT7dojsXqUl5OEvaP1nO
 Q/F6iyX8rk2fs+yUjCPcNvtK5CJ54sxewra5zjtI6PE8MladjA7GSWEwLJ/J1WGshOY/
 rLfR+muBOcVP/r1WtBpuS4Gh92oPPazOMWvmV/dpC8JwxLuKiWAwG/zsk1w+eaaAh/BJ
 F5zdBh6n1w9Yy3n48yKl6GWeYSe7J/XXsC7SqPMsBf/WVfzQpxVFE7Qv4rtFuBRA9NSB
 B8SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742907781; x=1743512581;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=55RcLJ+tquhWLa3l8UWa3Wt1h/0nWm7MQB6yx01lSY4=;
 b=ropx5WGIK2e0Ku09Xh/NXllegDtgWq+q9DV8PnTgHYDqBKEpfOFwPFg/ku8gug06Np
 TNYRB79+mNF5wsTbydxVWSUqCvHWaRpJOGEaEYbGlAcChMYt8vT2AR1vZmn5clJDAXKu
 7y7vdHI6NRDvwkEZUrBu23I9A+wvtIQtt1HZpCOYnoXlg84E/0P2+6gACzKyq5uepkSD
 Vc9xcDfPnSgZKv3MDaYDYlw6EUN4F1gn+F7wBrex2Tvn9vCCzdwdy49/0t/OFVOIKy9F
 Qpiikij1gHQ0ZXrIIJq3HpFkfxeL9/6h5iFegRpC1O2Qgiq2qsswNJPL8lT4mVz3MMjK
 Jdfg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4jXxYXqeiMhNc1lmKLmutV+p0CdMzvb8HvWPLRowrw+BeLkZzLvGJHsSxDkM5X6/W8dK81xQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yz1ZOOch14L2KxWAXxpuL4x7mO5S+TAY8Q4rKBafBUzp+3gLwF/
 EkOzpHSiGR18qoECRB2h9mAn3Z9pG20h4taw3eO74Ia8kzNhgqF4x0UUNwiJsD4=
X-Gm-Gg: ASbGncvDg1uYXLYs6D1VeRL9fPo/SFS3b9Mj6IRATShG/a/f2lUw9nY2oHBboGHIvan
 LHW1zKczAF+/yvfEGoacOMm7+CTVjyHoC7jh5lvNpgEwIek+5G16QfGU+i1+3qjmZOONjG+pyD6
 wBhI/4LPuHZrO0Hn5cmzTRMRukv3lWId/y8jZ40DB4rlOOm3gNP54soTOd0Ez9J7Ex56qVvsSl2
 7+T3wJHPS9YbSXEdOtDO1vgfxoMvoIo69vCb+IEEmKMseX/YQJm2DYrUw8wetN//HUjgAVzhWE2
 ij/qaiAmlDsYCVNRQeCQS06N6tdDcqA1cq8FWqqNvpGLh4y3TdvqSdSbXyIe6vnvTnTaMNDOnRx
 jUKODV+n/92r3
X-Google-Smtp-Source: AGHT+IE6dZfx4QekYYiF72M2LiLEFQc9u4jvVEkqsPCYxfeeWetkRiD7mgq6FvYwWpKafYqzsmobSg==
X-Received: by 2002:a05:600c:1547:b0:43c:f64c:44a4 with SMTP id
 5b1f17b1804b1-43d509ec734mr149775245e9.8.1742907781330; 
 Tue, 25 Mar 2025 06:03:01 -0700 (PDT)
Received: from toyger.tail248178.ts.net (i5E863BED.versanet.de.
 [94.134.59.237]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d440ed793sm204706095e9.39.2025.03.25.06.02.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Mar 2025 06:03:00 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 25 Mar 2025 14:02:54 +0100
Subject: [PATCH 3/3] scsi: sync cache on write
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250325-scsi-sync-on-write-v1-3-3575aa1342e0@linaro.org>
References: <20250325-scsi-sync-on-write-v1-0-3575aa1342e0@linaro.org>
In-Reply-To: <20250325-scsi-sync-on-write-v1-0-3575aa1342e0@linaro.org>
To: Tom Rini <trini@konsulko.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de, 
 u-boot-qcom@groups.io, Caleb Connolly <caleb.connolly@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2275;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=HNK+WBkpcnM1HsMromVRzxLwtuqyPHRwebTQUASR8p4=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBn4ql/FdAQqMGTxtTZwGZvzdX90d7MP2RB2jxNp
 txeGjmxwHKJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZ+KpfwAKCRAFgzErGV9k
 tr7KEACbHKe9lCp50Mtcel4sd80hqoy3dBcsOjV302MjAxCAVwiAjuvwM0WF3hBXhHWhcxwQhPq
 /ALCTqN+z6HQPJ6Op9zyYXYmtWbkP/fE2mKKXnkbKbRltIy+rc00AI9mneyC1UJ5xF17qu2djTK
 FkMpeCMgKgScVl3a1eoCcLQ8M46GNBNqu7uh9BnRB0z6qMxvQUJ+uQGH+tDjeS3HXES4kO4NRlM
 mfqw45OJj7nOEfcJQDBm9azB72RxQwGs628pmiIc2KluzpFiXqvSxxhTZ4MM4QC2aFn96PMCRJs
 JfVXGYXlkW9ejAkQYPKS0ql0RO0Yai/2poodJPiBZXlEe5p3Lxt9AoUN7+Tl/CO1izuq87MrbOT
 atTLHRFrTldX2JZvv27vwb1maZj81IUda+JhqXJV44473c5bVa7oBW/EZqlKESfiU+R0baJBXLH
 CilDcAZmBdCDx0okfI5zXZEUy+7K67JhApjF7ZBMQM6NhtPQQQDcX4yR5E/5Bx03EzqwEDln1cW
 fwtlTkDDhUkczzSgh0jPzfRVP29X8FWN0dyXzBrfUU7hPNnk1Y9ArLnKy5aqq0N8KSpOU+oUaT8
 yJIAlnMAzm7ZtQRBLa93JOytIHo48ZhnH0UtHEvbKtBPy0dhgC0T70pUEOO6mLUUrKVABxv4O/i
 Lf7ZC/N4AyvdTpw==
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

We don't have a mechanism to safely shutdown block devices prior to a
baord reset or driver removal. Prevent data loss by synchronizing the
SCSI cache after every write.

In particular this solves the issue of capsule updates looping on some
devices because the board resets immediately after deleting the capsule
file and this write wouldn't be flushed in time.

This may impact NAND wear, but should be negligible given the usecases
for disk write in U-Boot.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/scsi/scsi.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
index 1aa7fbdbb5278e387de72a3c3e73d19ea0342fff..1b71e580b89b100395ea132a4976366a713cba8a 100644
--- a/drivers/scsi/scsi.c
+++ b/drivers/scsi/scsi.c
@@ -77,8 +77,25 @@ static void scsi_setup_inquiry(struct scsi_cmd *pccb)
 	pccb->cmdlen = 6;
 	pccb->msgout[0] = SCSI_IDENTIFY; /* NOT USED */
 }
 
+static void scsi_setup_sync_cache(struct scsi_cmd *pccb, lbaint_t start,
+				  unsigned short blocks)
+{
+	pccb->cmd[0] = SCSI_SYNC_CACHE;
+	pccb->cmd[1] = 0;
+	pccb->cmd[2] = (unsigned char)(start >> 24) & 0xff;
+	pccb->cmd[3] = (unsigned char)(start >> 16) & 0xff;
+	pccb->cmd[4] = (unsigned char)(start >> 8) & 0xff;
+	pccb->cmd[5] = (unsigned char)start & 0xff;
+	pccb->cmd[6] = 0;
+	pccb->cmd[7] = (unsigned char)(blocks >> 8) & 0xff;
+	pccb->cmd[8] = (unsigned char)blocks & 0xff;
+	pccb->cmd[9] = 0;
+	pccb->cmdlen = 10;
+	pccb->msgout[0] = SCSI_IDENTIFY; /* NOT USED */
+}
+
 static void scsi_setup_read_ext(struct scsi_cmd *pccb, lbaint_t start,
 				unsigned short blocks)
 {
 	pccb->cmd[0] = SCSI_READ10;
@@ -235,8 +252,19 @@ static ulong scsi_write(struct udevice *dev, lbaint_t blknr, lbaint_t blkcnt,
 			blkcnt -= blks;
 			break;
 		}
 
+		/*
+		 * Ensure the writes are flushed to disk so we don't lose data
+		 * on board reset.
+		 * FIXME: this ought to be in a SCSI shutdown path instead
+		 */
+		scsi_setup_sync_cache(pccb, start, smallblks);
+		if (scsi_exec(bdev, pccb)) {
+			scsi_print_error(pccb);
+			break;
+		}
+
 		if (blks > max_blks) {
 			start += max_blks;
 			blks -= max_blks;
 		} else {

-- 
2.49.0

