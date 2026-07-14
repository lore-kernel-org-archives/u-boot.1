Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5D7DC43458
	for <u-boot@archiver.kernel.org>; Tue, 14 Jul 2026 09:53:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33C3F84CDE;
	Tue, 14 Jul 2026 11:53:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="iN/2TPv2";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OHgu4QOK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F02CD84CDE; Tue, 14 Jul 2026 11:52:58 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64ADA84C5E
 for <u-boot@lists.denx.de>; Tue, 14 Jul 2026 11:52:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66E6SkVx3862274
 for <u-boot@lists.denx.de>; Tue, 14 Jul 2026 09:52:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 yTev2e7Kr0l3ZzfsdabBWDz+xKbfQ5yg6wGv+RSwZKs=; b=iN/2TPv23F6TbH17
 gSdhWzFOvN/tB2Bd/IoR61CO7Uh0GcmbnVBTdBfLeS44CWZglIZzvfccUM9pA5tz
 uwSvRKqbsFD14IRjIyNCH0mSNHOi007SAiKnol9kjZJ7+lGKcor563w93HkDrCgA
 wi8YvsG8yamvKT9VKSbqdzc06sJtty0bXBBdXtvzDPAg5ZVI2IqHKYnMunSCOVMe
 +ngmpOGu7EjJhw6ZiI9BKePQC/SNStpnzeJ4y8PkqIKpHBJ88e5RXEVrelzww2Lp
 8EBQ00WeKvA43pKQ4idmLScROmbaVVU5JwxC3AZcVcz6OTHc9bhTlVkTlvVjddgl
 XEYgCw==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fd44j36bh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 14 Jul 2026 09:52:54 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c856470fe9fso793601a12.2
 for <u-boot@lists.denx.de>; Tue, 14 Jul 2026 02:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784022774; x=1784627574; darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yTev2e7Kr0l3ZzfsdabBWDz+xKbfQ5yg6wGv+RSwZKs=;
 b=OHgu4QOKer51vBI0IsAOYuJmNCBK5zev7hYXsn/2aC8AhTbm+1Tv98tEiHZ9CDT+5n
 30s4B40nv3rLWFRjbx1tYnu0UUCEXhU3nzylVXVV4jXDhdAwp78p7d0DqoUJ9alreY7L
 At15G2O2uT1oy42+n/op1HKbV81++KUm2aEFlj93oVyPuDuh1lR7oFBjGS8tkIuwrxyf
 V7kuziaYvVa8TgxvaYeeBXMynAoXNokuqtflZmukxTLZg08tYK5LT+G8h3Os2ceUxjgG
 78V9X2wUKqhHHXFeRkY1dmS6inXLfH7CvZlE9aKwX/Qx3HTgy1ztJ/UAI9q/bU5Ew40/
 ep0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784022774; x=1784627574;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yTev2e7Kr0l3ZzfsdabBWDz+xKbfQ5yg6wGv+RSwZKs=;
 b=FeQyb+Fk2dKNN1H/Df5sUZUyWr2OfQbfFbE0Pybq7JcmyRDEWiHdESscf4LH6S+npV
 kc5gA3GglOP1I4CFM9dZIRxg9whTvIgxx70L2JQlTWoNU9vh9+jJeA4lTYwoyYTlLPm0
 QTx6bfXdr6VoiZorKDajhQDzwet32pkazzZoaa/LYOGNg6rFGrrkgJ/z+hlNt+aDJnUV
 TVBPV5jtwGBisU63Xep47wOIFXpW0sLVXwYnYGlMbJq0qWIyTR9ZBX71D5roQ3fwRGno
 aoCSWjxNFsW91BBMnsy6886eliMgQbc2Cpldd/qnBhX9l83cT9K/urhAuyhbFxA/t2Re
 BvTw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrC2ul9DKGNdh+FHPHz5IjEXmid/UAYedovf1+cxawDKmg0spJ3t1OkZKPac0JXIYfjs+0l/tI=@lists.denx.de
X-Gm-Message-State: AOJu0Yz2kLSqVwVti+45tv0jlG207N6WBvISSxzca/BBjyoDwlkRRIDp
 Pa/MX4LrV6Sb8wMvReFNUj2XQxyw/6aC370QK2kAnqcB6U07EzzzZE+AJw4PC95TMIhOtYL2YzQ
 oDLH/GRyYMMoySI1v2g2KlBcWUpsVdKeDObU6GmvsTPUquM8ds723P4d9mv91XmmQ
X-Gm-Gg: AfdE7ckHTFt1NhO09fTtb2iy+PwADFuuu9vxpRgfQcGP53Bc3v19YWtUVcEL5UP0HaW
 iTR9L0aJJkimP9cC61NBXkp3AboA0jxq6nEcekLdAWQlb1h5Aumg4Ov/2KcKsxWNtWoXQB3ZoL+
 ipRIUCs0ZuQlz3a105+bJSo/xjR9aKQAwU1b0+A+q8Uu18BqL+xFU8yK3tm+UzEvKKQlPk93D8s
 HWoERoBTAqaw1rQTwvLAXIwOzi5rfpDyJ+zh7i0yyibYnfyV+/XOivVLkikoi22G5STGgQYsNyE
 DLWQkwzIrsxKFed/PApyygUfKcrrJlIxmv+LV8sS74KDZVylZIv/NDYDBQeeUAByzifHanbNQSl
 rZ+vHwNIexdS4uuvVUcVxqt69ccvK6zzRW/HRAHEQVbv8m1Bs5zt/qFPej8U4fMVooBDwjKA3UR
 irDoRBVenz+7iL5bnCJf00P8uL36JpdtTVNN9E4q1R
X-Received: by 2002:a05:6a21:6b83:b0:3bf:7bf7:7903 with SMTP id
 adf61e73a8af0-3c1102d7d04mr14563939637.15.1784022773578; 
 Tue, 14 Jul 2026 02:52:53 -0700 (PDT)
X-Received: by 2002:a05:6a21:6b83:b0:3bf:7bf7:7903 with SMTP id
 adf61e73a8af0-3c1102d7d04mr14563906637.15.1784022773137; 
 Tue, 14 Jul 2026 02:52:53 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b9081d5c3sm28180537c88.9.2026.07.14.02.52.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 02:52:52 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Date: Tue, 14 Jul 2026 15:22:39 +0530
Subject: [PATCH 2/3] tools: qcom: mkmbn: Add support for ipq5210
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260714-ipq5210-v1-2-0b98251aabbd@oss.qualcomm.com>
References: <20260714-ipq5210-v1-0-0b98251aabbd@oss.qualcomm.com>
In-Reply-To: <20260714-ipq5210-v1-0-0b98251aabbd@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDEwMyBTYWx0ZWRfX3XB1fgFrGQ/V
 5Kv7GPGO2B1sXGMpyV0uv5c5WqcDD0TByHS4/88DZ0y27wvMlXbdULrr1ez4P6n7NXwX9+VoSPk
 LCmjs1hEPL4RNBpZpNmVqbIlfXjINnk=
X-Authority-Analysis: v=2.4 cv=N4UZ0W9B c=1 sm=1 tr=0 ts=6a5606f6 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=0ffNn-8RTrVMWbVpffQA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: tWzeKldZurDN7rqQyKVvJAQtuZ1s9kpC
X-Proofpoint-ORIG-GUID: tWzeKldZurDN7rqQyKVvJAQtuZ1s9kpC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDEwMyBTYWx0ZWRfXyg1amCtgmSPJ
 FBKpCyWVXknZXgO50mWyt20WZeMX5T4F/JByuvS8kFDtOZp0WG2ApisTmaCaNR1t0VGV8pouiPR
 sIv1KMH0N2FyrAsieCduWJmarVHJh3dSV+lFlt4NbnukKPYibd83EUOnYadD+8PkZx0V2oQDUXf
 INu8QHQ6ftc5m+9HnjZHZaoervHZzmQwvBbn7wrLL0sm7trQ1JKKrYZ3TtSL7UC2rzwDfajkREF
 /Ap7fpcOit/FFrrU3lcpv/6SYaY19WmvJI9Nlnsf+W4vJQaTrIxUBHH5rSeyQxfUZ+9u3shWlGM
 Mj2gGROweQGiKNU33/PDOnnUxBNGRdMa8zdt41GMb/CHOk4x0/DGGw0gaiCHx5tC7FbOXg+fT1/
 FcjL9L2MfwRV4vWM7LnE/rg3cK9IXIv27Z7+zJxNqU3M23umBNw3neuXfoIVXUSNaKr/ZUw+YqM
 UCLHoe2BG3uj6Ur9I1Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 bulkscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140103
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

- Add ipq5210 entry to the 'boards' table
- Add an argument to specify the SPL load address
- ipq5210's boot rom expects the SPL image size to be 4-byte aligned. To
  support this add an argument to specify the image size alignment to
  enable the mkmbn script to pad the image accordingly.

Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
 tools/qcom/mkmbn/mkmbn.py | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/qcom/mkmbn/mkmbn.py b/tools/qcom/mkmbn/mkmbn.py
index 8d2078acc30..46edbcafb32 100755
--- a/tools/qcom/mkmbn/mkmbn.py
+++ b/tools/qcom/mkmbn/mkmbn.py
@@ -85,6 +85,7 @@ boards: dict[bytes, MbnData] = {
     b"qcom,sm8550\0": MbnData(0xA7000000, 7, SwId.uefi),  # C8550
     b"qcom,sm8650\0": MbnData(0xA7000000, 7, SwId.uefi),  # SM8650
     b"qcom,qcs615\0": MbnData(0x9FC00000, 6, SwId.uefi),  # Dragonwing IQ6
+    b"qcom,ipq5210\0": MbnData(0x87980000, 7, SwId.aboot),
     b"qcom,ipq5424\0": MbnData(0x8a380000, 7, SwId.aboot),
     b"qcom,ipq9574\0": MbnData(0x4A240000, 6, SwId.aboot),
 
@@ -100,9 +101,15 @@ parser = argparse.ArgumentParser(
 """
 )
 parser.register("type", "hex", lambda s: int(s, 16))
+parser.add_argument(
+    "-l", "--load", type=lambda x: int(x, 0), default=0, help="Load address"
+)
 parser.add_argument(
     "-o", "--output", type=Path, default="u-boot.mbn", help="Output file"
 )
+parser.add_argument(
+    "-s", "--szalign", type=int, default=0, help="Size alignment"
+)
 parser.add_argument(
     "-v", dest="verbose", action="store_true", default=False, help="Verbose"
 )
@@ -149,8 +156,15 @@ if not mbn:
     args.output.unlink(missing_ok=True)
     exit(1)
 
+if args.load != 0:
+	print("Using load address from command line: %s" % hex(args.load))
+	mbn.loadaddr = args.load
+
 log(f"Detected board {match.decode('UTF-8')} with load address {mbn.loadaddr:#x}")
 
+if args.szalign != 0:
+	data += b'\x00' * (-len(data) % args.szalign)
+
 elf.phdrs.append(Phdr.from_bin(data, mbn.loadaddr))
 elf.ehdr.e_entry = mbn.loadaddr
 elf.update()

-- 
2.34.1

