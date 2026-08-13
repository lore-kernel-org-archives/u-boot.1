Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4E22C5AC67
	for <u-boot@archiver.kernel.org>; Thu, 13 Aug 2026 05:50:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7B102606C2;
	Thu, 13 Aug 2026 05:50:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id C_8VSBct6dM1; Thu, 13 Aug 2026 05:50:46 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9EB486084E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786600246;
	bh=5U6leZVmUEp/VWM0EGNrgNoL9EFzh2tI0yAqNNU8jpw=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=WD1pGSfhZK3DMd98FJbzs2ugaIu2RFjab4//udlvFHkncqr2PkhR8ndSaZNNpjhQQ
	 OAdUuF8B3+fxMC80NI7J8a4uWFOQWTducIAe0nDjSCgUJLP6QSQWnqn/1Ph2QHTNu/
	 DdkCZid+/xk9BghAZ8QuK8Uzzsu47djbrsFtK0Of8mPoZbVX6Vwp01tYkTPChXK2BB
	 hbftoPVrkhskaZThe3w6dD/G9j0oGpSB1PbeJP/FLw41YR34gbXu/mnKmkijc2sc/w
	 lnp3zHQtpUfjYWqoC2IG84CJZIgedJIaTkRWiZSSGOlbNZRVh3FwjBR3ouTBcJ/PCi
	 ayE8HBLiQ7Drw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9EB486084E;
	Thu, 13 Aug 2026 05:50:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id B7B8A744
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 05:50:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9E3CC80FB8
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 05:50:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id N4Nz7QoG_vuG for <u-boot@lists.u-boot-project.org>;
 Thu, 13 Aug 2026 05:50:43 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org A09C280F34
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A09C280F34
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A09C280F34
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 05:50:43 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67D5fms12974510
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 05:50:43 GMT
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g152m8p3r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 05:50:42 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-38e7621655eso2684038a91.0
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 22:50:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786600242; x=1787205042;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5U6leZVmUEp/VWM0EGNrgNoL9EFzh2tI0yAqNNU8jpw=;
 b=RHinnRX1bRU1kJJUzDlkcAg3V4/iKM/e4pJst4XbWcji9Tv22by/buRBi54KZPoQBv
 6snvXvAS2P47+tVOmgR2oXdQG500x2uZ9L6I6hqta0cL5ba5CQAAOE5/zmb1M+RriTPE
 d4a4Sv69XeGvLNaUyCJrAhClt2vO3cnjcyc72P2OULjS/oa1ZAD0SIo4nMaaeY5vQdTc
 5UwP4zXBq69WlI4CsDQ9ecZaNEYpzY0HlHUvhLG9cSfARsBMp9q4feVDVFvaeOZJ5Hrx
 ppNa3FKBTPIBbxRqeRVVNQjOCK+uSlJMJ/aEMLu0nqEjZP2KWY6Ay4qOqqHftEWpOiEl
 Irng==
X-Gm-Message-State: AOJu0YxhlHAu3rHyA6E0pYBD9CsFd/vdnQNGOcxFhPwT4zG72x8SD7YQ
 vI4/GmpYWZeFQmJP6I2WFap4+zw2JaDK1K1sIhsycYHEgkDvxjcBIbS4rYaOmr9RmiYsNvZU0Tg
 WQkdifVZAZcZFsEAuO4ZyAluAWyrLn9BPIUjZ1e0RZDHMLPeaHpP7xIYEKD2DuBlB7YRMyiM=
X-Gm-Gg: AR+sD11y7UoZm3YOYDPzviGMm6fB31SQRF2lSgdNkI/L4n3wQA8iaC5U8eYUXx+3JI3
 cMz1/o0a3APHCYJS+SqnVZpJRq+ANJF+Wrk1cDmzKhb7pWBOLHbqKRhakzqRBgItYyTlmNKliqO
 R/i+BYIaeJ9Igptba0oWwA0B4syCjok7MKqOeCHs5IbhgaLhjymNoEjNGNLzeJxCX3LMUxmPcXi
 pu3OjIqKykHbHz7/0NhDNAgxvrrpPhtrGZPs5m4Jx4UQ0kd97FSoVWf3LDHnpcMzuhH1dXcrVhz
 9LLZWrmlL4S3c6sG2UGzgGfN18wsvEVr30JPY6rkqLrbDAAexisxQBDwuGMtCGJIIs8vFH9ut6f
 QwNcKywv9eYTe8X5IjphDQDOYKVEDQWQyVLRT0QhDN9oT4XKRG0UBNmjTU7XUpdc/gVbT9m4Bhx
 54pTwS2re+OCCYvRxlX9KO2hF/NKjt
X-Received: by 2002:a17:90b:580e:b0:37c:18e0:90dc with SMTP id
 98e67ed59e1d1-3931e2537dbmr4504614a91.16.1786600242127; 
 Wed, 12 Aug 2026 22:50:42 -0700 (PDT)
X-Received: by 2002:a17:90b:580e:b0:37c:18e0:90dc with SMTP id
 98e67ed59e1d1-3931e2537dbmr4504522a91.16.1786600241538; 
 Wed, 12 Aug 2026 22:50:41 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31ec022acabsm3402870eec.27.2026.08.12.22.50.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 22:50:41 -0700 (PDT)
Date: Thu, 13 Aug 2026 11:20:19 +0530
Subject: [PATCH 3/4] efi_loader: Extract FW version even on authentication
 failure
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260813-efi-esrt-last-attempt-v1-3-3be172f47d9d@oss.qualcomm.com>
References: <20260813-efi-esrt-last-attempt-v1-0-3be172f47d9d@oss.qualcomm.com>
In-Reply-To: <20260813-efi-esrt-last-attempt-v1-0-3be172f47d9d@oss.qualcomm.com>
To: u-boot@lists.u-boot-project.org
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 =?utf-8?q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>,
 Aristo Chen <aristo.chen@canonical.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786600229; l=2100;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=pGvcQL7w7/FPOrSk7WdeNABNQ5qze6XUNg8bkjoX5U0=;
 b=Jl6MdPSIbtkoOWLBUyW3vEMWaHJfhkt/FEZU/hp2XWtCtXhzqsmTYRW0NIF5TR9D0/kgXk2Is
 U88OY+9jFu/AZv7tBRwDlOCbkK8OsS4rns/Wt6Mq/eBqVdX/s7gBlah
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDAzNyBTYWx0ZWRfX9RPrFnQx/vJP
 q5bzrTw55bJkjvPa/EPIt+jzje2mmZOywsVha/Hd8nkeaxzuek5Ymfx2HpEQrEdlMiSJ6fWJ4L/
 OyH/dXXWXMtw5UR1n8q5cRTRUdWBkS0=
X-Proofpoint-GUID: 5ExvfoVcrJ8RPSDoeVbYqoBXTOW3I2yy
X-Authority-Analysis: v=2.4 cv=D8R37PRj c=1 sm=1 tr=0 ts=6a7d5b32 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=OFrvsZgaO87kX3YCiZoA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDAzNyBTYWx0ZWRfXxmg00G2TS171
 mbmJyFbXNTuAF3ed7yqZYuC52LMYkDskH/UThO91cBRiZ7lRN6mgV9evzVZY1wHCG1M5wyOTImf
 6pB80V31XzUOZ14sk15ijds498Dvt993vNE7an40OOo+dp6h09Y37CMXYEI11BsgKO4/b+v5qom
 mJQPwI7LOcovZbB1EdU8hQ/lD6glrReUW02rKHJpG8xPfbBOeys0qrM5Km7kGlmptliG7tG7gZu
 fgUY7yuWyJaZAr/YVxBgXnLUHmpmlewGFQB+pNVcVq1esOHXxgis+3J9fCzTq1ZxMhyLv6XbmVx
 bk6oMR3TYvaD9P2zprUL/hmn4VbYZKmq5IkC3zmHO62N+e0AZWZE2aJPVdjbAREuhpgQyEIhIRz
 3Kjfsu2qOMb+U/H9HHLLdaZ7JV68K9vXwoKtsaDSVXSFZAZXNnxikePmlFE9Yf+q8dJ+KD15dlJ
 xi+LsGG0F5i3b6X86SA==
X-Proofpoint-ORIG-GUID: 5ExvfoVcrJ8RPSDoeVbYqoBXTOW3I2yy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_02,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 priorityscore=1501
 adultscore=0 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608130037
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5U6leZVmUEp/VWM0EGNrgNoL9EFzh2tI0yAqNNU8jpw=; b=Qv9lcyKk6L/OQ+fx
 RBWpjticXnSoGvVfUIYpPidDLx4mLTh+I4uKY+dbui5ScG7tCC9oPHariNSQyf8U
 oDZ55UJaIl4IxU1psKB+4s75uuOLhwLm0NIsKPKg4StofwU0BIJxPTDdIrE2oo1q
 hajVPG4P+JroxhkBNIGWCbmzAVCVQMTCjW48HQ8Xy+aL3FYTW+3VLpHB0oMDuQCh
 EKmzjljbiH3BJdEZOIQ+PCRuEQcuqzd50ADkSHgjFyWwkKX250dpKlCcCrd2GL3g
 76YhVHgSG2BtOh9ayWDZK9afrqjQXIo1uUAZSh+kjNBW1E4tORfJOKi9zhX3bCc8
 E+JNEQ==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786600242; x=1787205042;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5U6leZVmUEp/VWM0EGNrgNoL9EFzh2tI0yAqNNU8jpw=;
 b=RI4q9np8FA8QqHIVdZgDjPtDiYUW/sXyBY4qzcYbiBBnfvv/crmv9JHviZDKmuoltN
 iHQ+XgsMQUJkb1b2vhgoHM57YnR/xIqH/LlxQpF8z0NwSAx8Hnl2JyZgBqrn+t5ATdWH
 ohOU+PXOSPwYcQJiz/ZyMh5sfoF/HwD3bqDgaoE6q22FrokTwodJKHvGR06MeVG9Rc1H
 sj2nclyTmdSc/XI23pVT2jFvfsoRT/ubfm8xjtlxG7OOO61WQeb5lac+hBn9MKro35xe
 m6CcD0ThgjINTVfZkjNiudY1/O68V2Civk2AySs1WIgZyJ3tBtf6qEXmU0/uKJvf/YuH
 Aotw==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=Qv9lcyKk; 
 dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=RI4q9np8
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
From: Balaji Selvanathan via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

efi_capsule_authenticate() already strips the authentication wrapper
before it verifies the signature, so on a security violation the payload
pointer and size it computed already point at the FMP payload header -
but efi_firmware_capsule_authenticate() discards them on that path and
returns. Pass them back to the caller on the violation path too.

With that in place, move the efi_firmware_get_fw_version() call in
efi_firmware_verify_image() ahead of the error check so the version is
read whether or not authentication passed. A rejected capsule then
reports its real version in ESRT rather than a stale one.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 lib/efi_loader/efi_firmware.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/lib/efi_loader/efi_firmware.c b/lib/efi_loader/efi_firmware.c
index 455d79a19ca..f7be480090e 100644
--- a/lib/efi_loader/efi_firmware.c
+++ b/lib/efi_loader/efi_firmware.c
@@ -453,6 +453,15 @@ efi_status_t efi_firmware_capsule_authenticate(const void **p_image,
 
 		if (status == EFI_SECURITY_VIOLATION) {
 			printf("Capsule authentication check failed. Aborting update\n");
+			/*
+			 * Even though authentication failed, update the pointers
+			 * to skip past the auth wrapper so the caller can read
+			 * the FMP payload header for version information.
+			 */
+			image = capsule_payload;
+			image_size = capsule_payload_size;
+			*p_image = image;
+			*p_image_size = image_size;
 			return status;
 		} else if (status != EFI_SUCCESS) {
 			return status;
@@ -602,11 +611,10 @@ efi_status_t efi_firmware_verify_image(const void **p_image,
 	efi_guid_t *image_type_id;
 
 	ret = efi_firmware_capsule_authenticate(p_image, p_image_size);
+	efi_firmware_get_fw_version(p_image, p_image_size, state);
 	if (ret != EFI_SUCCESS)
 		return ret;
 
-	efi_firmware_get_fw_version(p_image, p_image_size, state);
-
 	image_type_id = efi_firmware_get_image_type_id(image_index);
 	if (!image_type_id)
 		return EFI_INVALID_PARAMETER;

-- 
2.34.1

