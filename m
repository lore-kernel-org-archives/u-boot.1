Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A55EBC36008
	for <u-boot@archiver.kernel.org>; Wed, 26 Mar 2025 12:24:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8759281D25;
	Wed, 26 Mar 2025 13:24:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KRZ6FqjM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D74A81D25; Wed, 26 Mar 2025 13:24:18 +0100 (CET)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F00B381B4B
 for <u-boot@lists.denx.de>; Wed, 26 Mar 2025 13:24:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3912baafc58so5357217f8f.1
 for <u-boot@lists.denx.de>; Wed, 26 Mar 2025 05:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742991855; x=1743596655; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=grFI+AyTJ1nFnkkagj0GQ+g43+wP0+4Jplv53heM3CA=;
 b=KRZ6FqjMxwVX/r5+xPDGDOSVIV9SI0tLcRD9923rWnlikx+EFHHlqaG0mHVYJNYFWi
 VdGa8f3jyNuLcJwQN/x+tHU0bbZskn7Hl2KOgoYNZ28Sg7g9Slmjo3Uwakdbz95nIErs
 e7CAXAIH88HDred+kOjDito9SWmX/bKzxtR9rSNC0Q97Ds/TsLN0rDsED2OiIUe2YsYS
 lD0Dcl22nTz7iE+AbH7hijFhRp7pK1jnOx0VGTiilCrOM+qiWqx1kXflw0ftHzLx71n9
 K3v076vR83PP/PQXF7gzAMWDD/pk3uAxcN67TDUhMgqNhiNAy44Ds/yvZhnOp4fsr2pW
 38uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742991855; x=1743596655;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=grFI+AyTJ1nFnkkagj0GQ+g43+wP0+4Jplv53heM3CA=;
 b=A3gHHuIN6vRX9jU7sevjAtZ86lCIENGa02r/3MT5nCEcvkcTJH6m2ZbHchKodqikMG
 YON6UUPOGdXFELBXXpupNNwtxj8QPZ31BXB8MWbz/o/z7h7dH0Rjff3+VCzUwSmrPBKY
 U7GY2GtBu5EEzFbAIWwEOHQe63IAzjNRhpLbyolMtiYjMIs4GJV6Epo5n2Ky2n1KCLcW
 4rGCfNa4X6/+H5T2UxXXQ8GRcLn4+9Jwg1JGjXZI8FCS+CMbHDHOCHEwnMIQ/rIafsxF
 p3Z4SSX29pMcDZZpN9mYlnB47OEcLhZ4v2r/aDT0Us2toj0XO0T+SSPNIWiJprUz1+x3
 BFCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdLiinGpgjt2W+N6dEveSgiCDwQmYwrQWXwzuRr7q+Eo/HtApYNbciFw7quScZdWpufTCYp7Q=@lists.denx.de
X-Gm-Message-State: AOJu0YyGkbt9bS/C9fU3/TouDhTBe5gaMwIx5tgEJ3EDul+n73xzJAVz
 wwAz/tC7bmLBAm2hBmMt+CI6YWUE/1EYr5yLplTpLItSMzglcTjqBWAsq5TajfQ=
X-Gm-Gg: ASbGncsTKdaCToybLuGDiEcaBhmhtJm0sLxM1xxWgsbH4EkY1C21wgjS1mrGvtxKeie
 w0abkrI6MBxGT0lVqPpTEsZU0kCi6Gxpzm7+FFtLJLekZ2OxyweVyGb2wq/BIMlhKibmrGIGBEI
 lDOnAI3sKZBZHvg0Waor47BUPAPT0EYSIzY+H2u2zrcurB1svRhqpjEVMrq1WkD0+gWapWSbhOo
 ux4Gv2C2EMs4hbqAuqS8WBMxbb3m/FNYmVfc5JPJ9af4zBcV/q79id1PMur0w291w2Q31XaDvmO
 6ERDVZQiMCJwtRvEVyXK03N4g9/cA5RfOrJdbbhOex8M2FUKya9/RkSXsjThT+1gQAlFjWgrVSH
 DfswYaY1gBNFZB1PgS8GCWB8=
X-Google-Smtp-Source: AGHT+IHQkYQ33yHT9DGdpluHPlm+xxs8PxH5lz3giEQVpNJ/ueax/mvwsRiB41xSdoI0Ppovat6Org==
X-Received: by 2002:a5d:47c1:0:b0:391:13d6:c9f0 with SMTP id
 ffacd0b85a97d-3997f940829mr19977205f8f.47.1742991855363; 
 Wed, 26 Mar 2025 05:24:15 -0700 (PDT)
Received: from toyger.tail248178.ts.net (i5E863BED.versanet.de.
 [94.134.59.237]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9e65casm16923921f8f.69.2025.03.26.05.24.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Mar 2025 05:24:14 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Wed, 26 Mar 2025 13:24:09 +0100
Subject: [PATCH v2 2/3] scsi: sync cache on write
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250326-scsi-sync-on-write-v2-2-12ab05bd464b@linaro.org>
References: <20250326-scsi-sync-on-write-v2-0-12ab05bd464b@linaro.org>
In-Reply-To: <20250326-scsi-sync-on-write-v2-0-12ab05bd464b@linaro.org>
To: Tom Rini <trini@konsulko.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de, 
 u-boot-qcom@groups.io, Caleb Connolly <caleb.connolly@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2214;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=K1MLG5iZvnzW5TaW3VDS+A8H2nx905ReNYUkQyhxbaw=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBn4/HqqWIcnL0qRGwXEKPseS61SsBVaJ+c8lrNr
 XElimYlVtWJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZ+Px6gAKCRAFgzErGV9k
 tmXAD/43Lo1kUY8rDtkXUmuvnlh44AWzF0q5eM5glq+4VjZZGwl24BJK6Xy6i0WBbRLESXBBsZI
 dL2tzpglRxAb1WA2ONU9ExfVSfwa4WJLfmibv+cIeHzm+Z/JZ+60npcYU37r5DHH54SHKCceriW
 bMNWGYT3NaA3yw41QufX/1RJczIBJ3/ApY8ENhZqk1oCdZzh5SB8FNXMQO11dnXff42jREnC+N8
 E7/SK5jRbwJfPsYqKn3D7fhvxPMXi+yJBbDEsXq0flBdE3B+iX0y6V7xFPHArf1su3yOowDRKfX
 BAgEkPuGb1LLtN/adJK0eiwPrHc1monRTxln7D5r7acqBQHQ5mbsTboRKHPvwt9zSFPCpg8OW3X
 ne6OwDzreuG9w89GlW9EUVtt1+5F86t0jFH5duwRGLyKzQ8ofyC6cONh235L/2iIp9w/nb1KyDS
 Apt93S4O5I+nWIEiOmJfX5xSpB5pNZHsPlSpXarmpMwBQ9WTtsN4D1h3kZFLJIeb8dxSjKcld9j
 XgOrkcPy3mbi9wS8Hcvmxu/DeoQ2MglS41NXwpGCQJcSwC2ehwhtV08YJXav7vfTOD00TV1O6Cx
 c1ix/5h++tfkDmev9WCxUfdSl3eviq1HBUIbrOXzKD+STStbejEAzD5/vm/oTo801ct1Ha96fyp
 nwCQPAmjJ+xM7CA==
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
 drivers/scsi/scsi.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
index 34ac47c03ab397ca999abf130d84ccbd3be4c419..3e556540cae46734d3b13a72cf279905134336f3 100644
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
@@ -239,8 +256,14 @@ static ulong scsi_write(struct udevice *dev, lbaint_t blknr, lbaint_t blkcnt,
 			break;
 		}
 		buf_addr += pccb->datalen;
 	} while (blks != 0);
+
+	/* Flush the SCSI cache so we don't lose data on board reset. */
+	scsi_setup_sync_cache(pccb, 0, 0);
+	if (scsi_exec(bdev, pccb))
+		scsi_print_error(pccb);
+
 	debug("%s: end startblk " LBAF ", blccnt %x buffer %lX\n",
 	      __func__, start, smallblks, buf_addr);
 	return blkcnt;
 }

-- 
2.49.0

