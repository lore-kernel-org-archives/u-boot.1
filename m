Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F00E71073CA5
	for <u-boot@archiver.kernel.org>; Wed,  8 Apr 2026 12:21:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 41D148418C;
	Wed,  8 Apr 2026 14:21:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="K0VYV84z";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JEx6ocKN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 026308414B; Wed,  8 Apr 2026 14:21:26 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A6FC841C2
 for <u-boot@lists.denx.de>; Wed,  8 Apr 2026 14:21:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6387Q4CK2451202
 for <u-boot@lists.denx.de>; Wed, 8 Apr 2026 12:21:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=9UpYA7IIq/O
 l5ltl8etEhl+fI9ks0CQF1vfaQBqqkDQ=; b=K0VYV84z54gKE7yPjldNs1JGZ9o
 MRzY+pwCeGAKeJu/lvpcGKNhTe44NAxen9PwmrSaE9DFqpdQOd3HnPCSPrMSlk8V
 NDM8MO/agFi7y7TIfitM4uP8S9cYxjhmmSrcU94+O1RixGsfajQnzPRTP7Car0pP
 xxfSCoAeIfJRyfp0CbQ8XSfxSIFf7LvLvUfd4LQqhYXnOn3clchkyomiT1c28AHD
 fGn9fCEX61gBa0fvEiCCqruy0K/oSS0dYoevCfs1tUwaN6DMEAWWVxsMUzammF66
 KJJ6dL1ph5vlDdq7fGbj+uAZy11Oudfxup7i4zsob7rk6MXNajVp8z6pJAQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ddae6aq0s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 08 Apr 2026 12:21:19 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-b630b4d8d52so3950708a12.3
 for <u-boot@lists.denx.de>; Wed, 08 Apr 2026 05:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775650879; x=1776255679; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9UpYA7IIq/Ol5ltl8etEhl+fI9ks0CQF1vfaQBqqkDQ=;
 b=JEx6ocKNxo5kLFrfcbNv9BYHYRNpRaHpIQi/ihvyucIFBJOygRame7ZloCkYuAFM4M
 mB82mUIyUTbsZxbRzJMcq8nhFOJMrB41TV3HMu3IfukrbbARdqsW4x7Dq9Ib9vMub+0Z
 vZ3uFv9bhM/6/Zb2IdTuV7Pg+5O9C7e8xiaANOlWwqx1X48lM2b20L/lOCAMBZTbGXhg
 21+6CYrxjGCRUfoj+B6GxyMDjGRsN28hyGroLotWCrey9R0DkH0vtibbEmloiDZA71z/
 hdFrzslWDf5Nkjomk+7poMj3SMfpBfa12WuCbFzLscGcARAVklvGEq+JFZvvud1VN0LP
 GPDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775650879; x=1776255679;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=9UpYA7IIq/Ol5ltl8etEhl+fI9ks0CQF1vfaQBqqkDQ=;
 b=LS7o8Kili0DDYKFsikxKK48RSFCWjdBYBGUo+3FTUK2g/gqNg/GioQghP5r9O1YCyn
 k0sMiuaRAlUGjMO/MsF2dWGAEDkhdGSohHvWykVv6/DflJywH41D6FRQvY82ysM32+t5
 8o07PExO4gjS+W7NgnVc8Jq0+DiDnVeonynxJH1D3c+DcJ3uXKtvhbLusuwFY/N/OupD
 4shpK3EQfjTMCrRLLXFOt5/iRah4XzZ3lyQWa3FUDdo4mezG3A9chQhJcV/Yxayy/KPs
 N5SChY1yTvStMBnvOhhvd8XWRRg7vTeZrHrib1mcxDg/2w0b1K5oJWPIKIECrDjvVMv1
 4wTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMEiR5JfPqcuYNHS26iShqmLMzQkmVoRYHnqr/S11r298/zMvysQOZq+BDud5nvLGiq5IJBMI=@lists.denx.de
X-Gm-Message-State: AOJu0YxyU6g7FY34nftxyUbSZfBGpC4nR4s+XQwLXExDthhuMCdRIz0C
 PjFkMwtH8tWZlQetuWg+aT/DLwmKtqBn5TLqz4XJ9YauPVFZnE2sPISwBNaOxupVm0nLH3kNZ8G
 t+bNjijphF9ZEqYRhA+9s3pSqNY+KPIe6/vieGMYd9YKkMu6dbo+9Upo0
X-Gm-Gg: AeBDies5fR7Gwc0rXvPwdB6RnTGntwphrU9ngEAyVzLVH0hP/xEOKthX+bjcob79heS
 w4LR1PptsJEWQISjrl5WBX6S5aVZ9f281ozAQaCi9BVHgaPHKBNiP91+/rUu52SwddUZKCRVCmI
 XItDqM64AAaNXTLn88R+dyNsb8/4QUahoTtDm7Owiy/BRYCran9/93Js6J8gD+yboTM3eXgVPcy
 KPzp2zmLAQ3DMX6h97p5rAFGgrnNHSV5XZLPP9/Mu2rc1BciSEx4TRZhs/bKXMVzrKpie6GiPPh
 eXt/jGY6+RF9rwP8If9lRYuiyQjBHXMX1xpjKx0ZSDwebIm37M7O9rdBOVLWFw1ogMiZEWAXLKw
 9NjCiHk9yBZ6V7IGUvaSk5kIH/YC+qA+8H/Jxkp0XpsdVxONgXBztla8m98qp7qZtRteA6Q9ygI
 R3G/4f7gn5HigG1Hx8Snr8piY4UdxJlk53JZ+YaUHf
X-Received: by 2002:a05:6a00:3693:b0:829:7d31:dd99 with SMTP id
 d2e1a72fcca58-82d0db7e27cmr21032965b3a.38.1775650878504; 
 Wed, 08 Apr 2026 05:21:18 -0700 (PDT)
X-Received: by 2002:a05:6a00:3693:b0:829:7d31:dd99 with SMTP id
 d2e1a72fcca58-82d0db7e27cmr21032924b3a.38.1775650877852; 
 Wed, 08 Apr 2026 05:21:17 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82cf9a24039sm20512602b3a.0.2026.04.08.05.21.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Apr 2026 05:21:17 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: trini@konsulko.com, aswin.murugan@oss.qualcomm.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, sjg@chromium.org, seanga2@gmail.com,
 sughosh.ganu@arm.com, gchan9527@gmail.com, ilias.apalodimas@linaro.org,
 mkorpershoek@kernel.org, marek.vasut+renesas@mailbox.org,
 hs@nabladev.com, msp@baylibre.com, ravi@prevas.dk,
 dinesh.maniyam@altera.com, sajattack@postmarketos.org,
 peng.fan@nxp.com, quentin.schulz@cherry.de,
 jamie.gibbons@microchip.com, mateuslima.ti@gmail.com,
 justin@tidylabs.net, wens@kernel.org, n-francis@ti.com,
 ycliang@andestech.com, jerome.forissier@arm.com, clamor95@gmail.com,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v4 7/7] misc: update API documentation for bit field support
 in NVMEM
Date: Wed,  8 Apr 2026 17:48:41 +0530
Message-Id: <20260408121841.186410-8-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260408121841.186410-1-aswin.murugan@oss.qualcomm.com>
References: <20260408121841.186410-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDExMiBTYWx0ZWRfX6Vmqmfu4PGzH
 lOXASTkOO2M8daCm7ypSNCI6sRcEVIMFLF+35GOXY0z6NWR5fqc3WF+Pb1CdLz6qaYInCguNuKl
 cT37dcbGOeEBenX8AKEaGizsvsvlWpNK46DDdMZCKYdfyws+RxBFueNNOunO/ZEgLGQkqKa5+D+
 OMU3tDImY87DxdY6iDYsoWcMWQymTh7GfwAw7qo4MwnJPoWKTX8oGNiMm4jYcKGqZCJeJ9+Kd5y
 ZvfsMOAlT23bq+2cRPeNRJnV1Su4Rfvx/7Yy3OIstvzGf8tuZqcj7Heqw9Qk9UGSXsWRMy4C6sC
 svPrjOkZ623bOW3rom1Ak7rR2n1vYOmnY+oOR2awQKww5GaOEhUsDoTZzT7qUUtxK5LVAExFjBl
 5DzHEpCAzkfKjwk3Y352D4/G4cv9FiHb3pXvdnio4UknjlxJekJyJyutU+Ghz60mzwMalpxFKJa
 EUbPGzZ5FJcGckSe5Jg==
X-Proofpoint-GUID: 8qtxsLyAPx5zluVTVIdcsOsVa_5ewHfc
X-Proofpoint-ORIG-GUID: 8qtxsLyAPx5zluVTVIdcsOsVa_5ewHfc
X-Authority-Analysis: v=2.4 cv=K4AS2SWI c=1 sm=1 tr=0 ts=69d6483f cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=xnw-sE8SsPs_kYMhUbAA:9 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_03,2026-04-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 clxscore=1015
 phishscore=0 malwarescore=0 spamscore=0 bulkscore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604080112
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
Changes in v4:
1. Added explicit documentation for all `@cell` parameters:
   - `@cell->offset` - Byte offset within NVMEM device
   - `@cell->size` - Size of cell in bytes
   - `@cell->nbits` - Number of bits (0 = byte-level mode)
   - `@cell->bit_offset` - Starting bit position
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

