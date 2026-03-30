Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D064E1061B17
	for <u-boot@archiver.kernel.org>; Mon, 30 Mar 2026 17:16:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 10FB384035;
	Mon, 30 Mar 2026 19:15:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="DHgXXODi";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fQBqqjYB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F417184035; Mon, 30 Mar 2026 19:15:40 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9DBF83F5B
 for <u-boot@lists.denx.de>; Mon, 30 Mar 2026 19:15:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62UF2IMX3721837
 for <u-boot@lists.denx.de>; Mon, 30 Mar 2026 17:15:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=3Me2Z5C0WXZ
 QfkrxQ4Z5/J0V8p1fOvf0PHZg/ft1QYM=; b=DHgXXODiqrjhrRnfJn+c8rFUgAj
 cAVmZYujsjC2Wr4VNsx6FUtJz3oStnjqJfpSdgwuUGT3ZrPFmfnBmHehrWF3VpUV
 H7U0MxIWbdtLWoK+HldLZlPpTOBWBK2P0leq1s2cGawQC5Km7Np8spCRI+w3nv0z
 T7loFnjA1Eem3xvSz77n4E2IBntdKWwCqTQzuYBbbDq6gFpeNcBeajIik4GNJUcQ
 +js/vCJzyDWQjsO2zlytV5WGvXrxt2Ro4CrE956NQzs9RvU3m+T05ekxHneuvNhx
 z72GQl3dSM+dJAY65nJUHetU36oRECYRFJDU5fEiJN2WeaimsPy04PYvc0A==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d7pvmssk5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 30 Mar 2026 17:15:37 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-82c8768a633so7980481b3a.2
 for <u-boot@lists.denx.de>; Mon, 30 Mar 2026 10:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774890936; x=1775495736; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3Me2Z5C0WXZQfkrxQ4Z5/J0V8p1fOvf0PHZg/ft1QYM=;
 b=fQBqqjYB3UkFHbqw/akOu8PBNHpD4k2qOCT954mXSLX7nc6irRFZjtokH7Ob+WhMZw
 eHR8wWdJwWAnrSZznyxIIWDYOpXJR5fXhHeUuGhosbu+i0XeZ+2l19uu+G0+pOYiiANc
 EmL51dgN0ErUBEn7LeQABNjvub7tD0ZsRRE2G2rWFHitl7BSZSoptkqVVSCDMjkNiUFC
 BGfCkhkProFw5TKvhxkuD83Vgme7iLXhR35M6rRvAlfn+7+p0ZnOGroXhme81g7sc8/u
 uJ/6RBF9dqimCu38ux8BCb6PkBBugUdKi4R8ImV3wvNGLd1nHMAvzI8aV0S9kUAMDjQU
 IoAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774890936; x=1775495736;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=3Me2Z5C0WXZQfkrxQ4Z5/J0V8p1fOvf0PHZg/ft1QYM=;
 b=EzF4KvvxEBRRCRPiz6mnN5ult7zmIp134cV7D3F0iE5TtxVjXednq+hf/CnmRTVsO3
 SI9zxR1hy5S3SJALrSzRMIKRP+js2LMlLWvprIRzdY3FQv+KSXyKxw6Yot7tgOiCvygD
 uGFBc83TCSuCXcfME7oHNPMoPtFWcOsaGxbe5/9tShaezbM8xsHMdv79ETmnYW0RomBI
 r35WbdwT0i6jkoCDvwvIEheZ3f8OmhnY6UzMD2sW14qHCy4pTIKGWKA2bHk5n09JvhAp
 BOovx4/tZSgU1f7cgyt91kDHzknmz0paZ1WIyB2EAQmL0LZNnzF3gx94U3m9bIWXcBY6
 /Dhg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWj2EmRmiTp+WwbDmqCcKtrl26rP7fOF5khCtuz4NdqjH4SYCZl1g/hsKFd6XIvK52sjA5Tuso=@lists.denx.de
X-Gm-Message-State: AOJu0YxOvb5Mhxzxh/F9p45QrcLAbgMmi7o+HrJo+ffYUIFIHwzsHhX6
 +sfGNnNCa5kVNBKwHk+48MmqFPcQuw1ZCs75Hv3TlCJm4D+vhph1i5kH274YyOZEiwcvcwdUod0
 vLQ5QREoNCmhgn4y9HXG8Yr9ae8t4yAdEDvBMwdf3kNcGPwhTFseFisI3
X-Gm-Gg: ATEYQzwa8JBXL8LjvE9Gp36Z7ASwEI3wrdBRKKcA+R3ssgxYLregnLt9TOm4j/0As0/
 dd+EV51BugITs0eOMgnx5YlgosXSYPHWBKdX2na6pLvM0SAYTWOK6m+ElAPcnXhUkYKhxCJF+tN
 RakQNSfzpIAINYhd5c0vr1wNkYIWW5GV2vjQsI9G/CpQm3xG6MhHzRWKQ+49UC+nC5dX560xyga
 X3dbZ7zlnuqbXIWMI6+TtwLGrcmgcJANEuATJpZcSatgDiHn8hnbXPq143LllwlFM4Gjxyfh8ew
 3bGgqef6zuIeO8qOXh0ohV3jHho4GdMX8I2tnQ4uSJIm/ixVG0yx4An0t/yOrGjUVy7OvPSbNC3
 EHChp/2N/ztFcFo2mpt6zZByRPUFd743kWFTAMyWQM8ArL/YsmDCrRz5Ah9oGmU8uFGPuFD0CvR
 csMTCP5FfHOVDi7vxh9wFEr1m9cpI9Kzad9yIIFdzR
X-Received: by 2002:a05:6a00:27a0:b0:82a:7aa3:a2fb with SMTP id
 d2e1a72fcca58-82c95ee4bdemr11979130b3a.37.1774890936064; 
 Mon, 30 Mar 2026 10:15:36 -0700 (PDT)
X-Received: by 2002:a05:6a00:27a0:b0:82a:7aa3:a2fb with SMTP id
 d2e1a72fcca58-82c95ee4bdemr11979078b3a.37.1774890935427; 
 Mon, 30 Mar 2026 10:15:35 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82ca8626518sm7349777b3a.52.2026.03.30.10.15.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 10:15:35 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: trini@konsulko.com, aswin.murugan@oss.qualcomm.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, sjg@chromium.org, seanga2@gmail.com,
 sughosh.ganu@arm.com, ilias.apalodimas@linaro.org, gchan9527@gmail.com,
 mkorpershoek@kernel.org, hs@nabladev.com,
 marek.vasut+renesas@mailbox.org, msp@baylibre.com,
 dinesh.maniyam@altera.com, peng.fan@nxp.com, quentin.schulz@cherry.de,
 kever.yang@rock-chips.com, jamie.gibbons@microchip.com,
 justin@tidylabs.net, xypron.glpk@gmx.de, n-francis@ti.com, h-vm@ti.com,
 ycliang@andestech.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v3 7/7] misc: update API documentation for bit field support
 in NVMEM
Date: Mon, 30 Mar 2026 22:44:19 +0530
Message-Id: <20260330171419.1117817-8-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260330171419.1117817-1-aswin.murugan@oss.qualcomm.com>
References: <20260330171419.1117817-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: paoe-E8KmeWVYPhdP3qAG6sCbSS7UtBu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDE0MSBTYWx0ZWRfX9NS31xipWssj
 tLD9j7+Fq7BDCnKEwxMq5Q19Fess1Lb01VumT2ojvxX+xfI5ekhyYjdWe8LJMnNO9kX/ipIUytH
 f0QC5xw7JDrJU+NduJHETPVDRjnT2UsWRVsNLZa3zkXyJ9j6Voq8YIzAsnC5zvJUHB8OJNcK5hM
 rTsFuDyKdh1PxnCPBJyh8FNseXla76ohP6aagYIk3vLLMw0cDCxbVqrMmGKBam5WRbGYTtqZlPW
 WdnWa9v5t+Evl474vCKhMv+M1N+gD9sJjN14bJExg5RY/bzIiC5jn3wCPHSgpYcun3Bj66WABHo
 wR+gaCxD6gsyWGr9aH0kJy0idpvjHlIoIne5URZxHGVKkn1od+6TaiIDkWRWRDZXBB3+YJ550BK
 ZUlKgXvwPAvoNwNlj5GTXj8tfZG5VNwzdlUfmXMgC1HZfB3xdZtsPJG09yzQTYi6ztr7w4/mX/K
 f4ARRgzy2Hb2AHclrIg==
X-Proofpoint-ORIG-GUID: paoe-E8KmeWVYPhdP3qAG6sCbSS7UtBu
X-Authority-Analysis: v=2.4 cv=S9rUAYsP c=1 sm=1 tr=0 ts=69caafb9 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=FN49bKHmwJfEaFta7s4A:9 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-29_05,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 clxscore=1015 adultscore=0 spamscore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603300141
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
 include/nvmem.h | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/include/nvmem.h b/include/nvmem.h
index dd82122f16f..af1d2594bd6 100644
--- a/include/nvmem.h
+++ b/include/nvmem.h
@@ -47,9 +47,19 @@ struct udevice;
  * @buf: The buffer to read into
  * @size: The size of @buf
  *
+ * For cells with bit fields (nbits > 0), this function:
+ * - Reads the raw bytes from hardware
+ * - Extracts the bit field using bit_offset and nbits
+ * - Returns the extracted value in @buf
+ * - Requires @size == sizeof(u32) and @cell->size <= 4
+ *
+ * For cells without bit fields (nbits == 0):
+ * - Reads raw bytes directly
+ * - Requires @size == @cell->size
+ *
  * Return:
  * * 0 on success
- * * -EINVAL if @buf is not the same size as @cell.
+ * * -EINVAL if @size doesn't match requirements
  * * -ENOSYS if CONFIG_NVMEM is disabled
  * * A negative error if there was a problem reading the underlying storage
  */
@@ -61,9 +71,19 @@ int nvmem_cell_read(struct nvmem_cell *cell, void *buf, size_t size);
  * @buf: The buffer to write from
  * @size: The size of @buf
  *
+ * For cells with bit fields (nbits > 0), this function:
+ * - Performs Read-Modify-Write to preserve other bits
+ * - Masks and shifts the value to the correct bit position
+ * - Merges with existing bits outside the field
+ * - Requires @size == sizeof(u32) and @cell->size <= 4
+ *
+ * For cells without bit fields (nbits == 0):
+ * - Writes raw bytes directly
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

