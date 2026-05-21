Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC1FBCD5BB0
	for <u-boot@archiver.kernel.org>; Thu, 21 May 2026 18:07:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 363CC8482E;
	Thu, 21 May 2026 20:07:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="DLH1oC3B";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SJRZ0pTf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A4208486D; Thu, 21 May 2026 20:07:14 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4394484874
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 20:07:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64LGk4Cc3532248
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 18:07:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Oi9p3KSmXSj
 aONenYGOhlvi4NjzG8gESGM50dVCXrTg=; b=DLH1oC3B0QsGfNCV/2ezOCL+nRt
 ZaXCEHxdtjiGgmOWBDO33KdXrrHRN/BFyFBYPOjhaKrgnZxcIFYpTPJKV9pDOTux
 jZ0J1wYvbDJT7YlYkxe3MkC+0Sy7eTh7eshYa6+ywp7amUVDW/gijH91KF3w3wpx
 FOiBj23hQ3s/hcP5jVsA4ExaJTne8AfkJz12qinWsUY4F2ThoHHBH+v/MqZOnX3V
 4mlixRApaBwaWctjThZuvjea8ujQv3Lh32J1RoEO6hLgG/7+Pnm22SRXdQMeBnge
 upVZ2eYXN6sG/xg33hDp/gk5mDdmgSkIc/Ch+icbce8EIFnKCUxxSCqwBDQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ea39gs4gv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 18:07:10 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2ba5f794825so50351155ad.0
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 11:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779386830; x=1779991630; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Oi9p3KSmXSjaONenYGOhlvi4NjzG8gESGM50dVCXrTg=;
 b=SJRZ0pTffcYHWEyy/AZYK000g+vRphwYeHRSfUTNSj6ODcEfwd8mlM5ShbX+Fl8D9u
 FrBsJickRsDTMICMYcaMns2Nn/69Gqp522cmWAB+GVUWaj+Qdbm1yRDCu4/Zkws+xR9v
 tBrrLZCLxnSMd1iMwwbs5ymCnQI9LZ2InCpKHfFs0vHqwoKNxbJWk9fvdH/Mun9fvxGp
 JCPuDuClYF08C9wL9WuZawJvXAkB/YHKIN6uD/Ih3P+PsDsd/1gNbcjiNpWsXfyZ2r1I
 BH28nQn3izxCbXDXYSCkUOS1xAycRTj9qSfSpBB1ESxXc/q36X/kbDfKlLiQFstbAAqa
 i2CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779386830; x=1779991630;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Oi9p3KSmXSjaONenYGOhlvi4NjzG8gESGM50dVCXrTg=;
 b=R4wQKUqpzRyYNsi7mRwLCUpEbnPB7nuM7EYxgoqvQQlGjzwC23HkDFOw42XRCehIBT
 rlBttr541F9BJkdeUo1E6afSk1bFIfG87IF/iArgtlncN/ks5Tu1CfZmyp1ROr0/ZOdq
 H2MPkeLZ4WxHb5WB+TvkfFnhnRPSO3CgF4OZPokHXg08t6qSGmP7/OymFdQbrxDhmloX
 6LQwpK9xb6iP0FSb3qlPiUow8rNzdRfdbxy5GYkYgipDuoh+YijyKDRrue03HOnALJLR
 U6IJpPfW9L/a/YBsKUaoBGMyH/oWgySJ96qtZSC9wOV9f2+EdCndqIs1XLfvvYwFuTHC
 6qew==
X-Forwarded-Encrypted: i=1;
 AFNElJ/Y7fxW4y6mFL3X4ETvTSFJKZgEyoTUXCguzAI7FRmMLNiCPDObEqaqJn0ZsfZnyuUWBop2eC8=@lists.denx.de
X-Gm-Message-State: AOJu0Yxpu7b/C34H5fHKFGMpmmI0ez/d0GvNrKGZjcMCy1d+yI7xnHYY
 Qg996mTl+TMELKTqIY6iJeUBgz5i4t2yFqSldTMBllTYuOBsjv6jPMkSh40z3UDvFwz6jwtb4Fb
 8wSI5GeJGasDchAbZSQjfG/PpXxlTd7Bb0/hrqwKGO7CL9fGhcv3pFGuk
X-Gm-Gg: Acq92OE9RuFWC/owpYmSb7miorZ6aAcCHEWkCqz+d11H/nK458cadzTEMfcj7/XLIyj
 hupHs945Lxls1xavVHbiNzAVITZMImZ89JhiU9AV0eCFxIzoOUCVUM5IXrr+vFPZpyFCkWIbdta
 LF2AMTM/z90D2gWTCF2P3oyZPa+/Ca6R9mJmesSfqV+t8aepVZyYpf/M5JbrNGgv78HYBZsZ5h4
 oGiXkm7LSDBQ2lpe1SB/6s7xqSAcUhVIE3hbxuQMTDUyUU9zg2xoJbNHob5zKLXZqjszGeJu+1i
 1UQZe1sd93OUov5nuYpppySSCpoUM3lQfe6UFTJzwIASCzlnXFDsC0y9W0SvrewXbv//3ntPyEe
 UdIQYh+bZ0j5PUOfBD9qeQMnKcPwjooDf6nMfsGLLWomJ0/p21mCSp/cqqZo7rEia+gd2VVnLXD
 61oBR48+gjI0ES+4XWHmU7UbTsyHkpdiG6uEZzQ3b6
X-Received: by 2002:a17:903:190:b0:2b4:5cb8:99eb with SMTP id
 d9443c01a7336-2bea3338a8cmr43767765ad.27.1779386829581; 
 Thu, 21 May 2026 11:07:09 -0700 (PDT)
X-Received: by 2002:a17:903:190:b0:2b4:5cb8:99eb with SMTP id
 d9443c01a7336-2bea3338a8cmr43767045ad.27.1779386829050; 
 Thu, 21 May 2026 11:07:09 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bea9902828sm22638805ad.60.2026.05.21.11.07.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 11:07:08 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: sjg@chromium.org, trini@konsulko.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, seanga2@gmail.com,
 mkorpershoek@kernel.org, marek.vasut+renesas@mailbox.org,
 hs@nabladev.com, clamor95@gmail.com, m.schwan@phytec.de,
 msp@baylibre.com, aswin.murugan@oss.qualcomm.com,
 lucienzx159@gmail.com, sajattack@postmarketos.org,
 luca.weiss@fairphone.com, varadarajan.narayanan@oss.qualcomm.com,
 peng.fan@nxp.com, anshuld@ti.com, ycliang@andestech.com,
 n-francis@ti.com, jamie.gibbons@microchip.com, justin@tidylabs.net,
 quentin.schulz@cherry.de, michael@amarulasolutions.com, ravi@prevas.dk,
 dinesh.maniyam@altera.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v5 7/7] misc: update API documentation for bit field support
 in NVMEM
Date: Thu, 21 May 2026 23:35:49 +0530
Message-Id: <20260521180549.282377-8-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260521180549.282377-1-aswin.murugan@oss.qualcomm.com>
References: <20260521180549.282377-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Yr8/gYYX c=1 sm=1 tr=0 ts=6a0f49ce cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=xnw-sE8SsPs_kYMhUbAA:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: PwInZOS8dA_RoMy7o69HL6-XyTuf5P1u
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDE4MiBTYWx0ZWRfX3bjV3m3rMGjM
 O0q6sHDc4Jdmt1uoJlHM4RcujAi0wDXAt6GJo4XTtgOHA1BF/rbFHszhKWtLtCreHSE/orwB8E0
 JiYTsqUK4OcDaP3ApriQj1sb3zXrdndCjZ+tAaE497hCzjfNsWF4ptnXIXEAaclJ6plXV+UMlvg
 lAszIFnl1l1q/ZDy4vpqN+/pc6Dnwnc2S+ucxyJjOO+plRuyjMIFxXbVAGmz7as0RgRC98dEym+
 eqxPQRe56zgBU4Oqys+hdl+rfLhFNFkAA6k2TbncB8XHoTpucykVLMeedC4Ex5g9I46Qapf41kR
 eSWjHiA/opWu6MUr2HLqZTC3NKgQBtEV4THNGG6ZkmfGwnhLyn8OaytDDAj8NGBcRCxsFT/9XaC
 xHNWnOxXU5GVqO6WjYa91qG34ZEL3RFGF3YObCl3jly9UoQiRTSk3hExNE3U4tgbPusg0wZLM8Y
 dfq3H1nJUPPecDI6Z6g==
X-Proofpoint-GUID: PwInZOS8dA_RoMy7o69HL6-XyTuf5P1u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605210182
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

Update the nvmem_cell_read() and nvmem_cell_write() documentation to
describe the new bit field operation mode.

The documentation now clearly explains:

For bit field mode (nbits > 0):
- Read: extracts the bit field from raw hardware bytes
- Write: performs read-modify-write to preserve other bits
- Requirements: buffer size must be sizeof(u32), cell size <= 4 bytes

For non-bit-field mode (nbits == 0):
- Read/Write: direct byte-level access
- Requirements: buffer size must equal the cell size

This helps developers understand when to use each mode and the
associated buffer size requirements.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
Changes in v5:
1. No change in v5

Changes in v4:
1. No change in v4

Changes in v3:
1. No change in v3
---
 include/nvmem.h | 36 ++++++++++++++++++++++++++++++++----
 1 file changed, 32 insertions(+), 4 deletions(-)

diff --git a/include/nvmem.h b/include/nvmem.h
index dd82122f16f..c3d845c3a7e 100644
--- a/include/nvmem.h
+++ b/include/nvmem.h
@@ -43,13 +43,27 @@ struct udevice;
 
 /**
  * nvmem_cell_read() - Read the value of an nvmem cell
- * @cell: The nvmem cell to read
+ * @cell: The nvmem cell to read, containing:
+ *        - @cell->offset: Byte offset within the NVMEM device
+ *        - @cell->size: Size of the cell in bytes
+ *        - @cell->nbits: Number of bits to extract (0 = read entire cell)
+ *        - @cell->bit_offset: Starting bit position for extraction
  * @buf: The buffer to read into
  * @size: The size of @buf
  *
+ * For cells with bit fields (@cell->nbits > 0), this function:
+ * - Reads the raw bytes from @cell->offset in hardware
+ * - Extracts the bit field using @cell->bit_offset and @cell->nbits
+ * - Returns the extracted value in @buf
+ * - Requires @size == sizeof(u32) and @cell->size <= sizeof(u32)
+ *
+ * For cells without bit fields (@cell->nbits == 0):
+ * - Reads raw bytes directly from @cell->offset
+ * - Requires @size == @cell->size
+ *
  * Return:
  * * 0 on success
- * * -EINVAL if @buf is not the same size as @cell.
+ * * -EINVAL if @size doesn't match requirements
  * * -ENOSYS if CONFIG_NVMEM is disabled
  * * A negative error if there was a problem reading the underlying storage
  */
@@ -57,13 +71,27 @@ int nvmem_cell_read(struct nvmem_cell *cell, void *buf, size_t size);
 
 /**
  * nvmem_cell_write() - Write a value to an nvmem cell
- * @cell: The nvmem cell to write
+ * @cell: The nvmem cell to write, containing:
+ *        - @cell->offset: Byte offset within the NVMEM device
+ *        - @cell->size: Size of the cell in bytes
+ *        - @cell->nbits: Number of bits to write (0 = write entire cell)
+ *        - @cell->bit_offset: Starting bit position for insertion
  * @buf: The buffer to write from
  * @size: The size of @buf
  *
+ * For cells with bit fields (@cell->nbits > 0), this function:
+ * - Performs Read-Modify-Write to preserve other bits at @cell->offset
+ * - Masks and shifts the value to @cell->bit_offset position
+ * - Merges with existing bits outside the @cell->nbits field
+ * - Requires @size == sizeof(u32) and @cell->size <= sizeof(u32)
+ *
+ * For cells without bit fields (@cell->nbits == 0):
+ * - Writes raw bytes directly to @cell->offset
+ * - Requires @size == @cell->size
+ *
  * Return:
  * * 0 on success
- * * -EINVAL if @buf is not the same size as @cell
+ * * -EINVAL if @size doesn't match requirements
  * * -ENOSYS if @cell is read-only, or if CONFIG_NVMEM is disabled
  * * A negative error if there was a problem writing the underlying storage
  */
-- 
2.34.1

