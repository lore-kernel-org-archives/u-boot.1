Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74DD2C531C9
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 15:56:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CA2E280E7C;
	Mon, 27 Jul 2026 15:56:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4RxvIeD_2G5b; Mon, 27 Jul 2026 15:56:40 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F1E1E80E66
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785167800;
	bh=hhgTlb89LuIRugF3P3X53cuo+uw8PwK21tJoNVvLGpQ=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=kTR4OW+aKNcDNYESS6Kxe+c2TJ+zzOv61g1AaNODD1AoekZLi5BTXJlz4O3VFGKmB
	 NOiwpu/60h05jVSfKNYCUDgGG7ft+acDXrx9tH7H5rZtIGBvEnTf6MIrhZ056oj1IJ
	 3wdSAYcLuwiRC9kzvJiNn8VQNvCexmOOwHCGwS2DSAAk7fet85dqU1IAeSBjiU1xmU
	 sOnk7kf/lIruHKlg+i1eXtbanMSDFEvdSFBRXH5Lphpyt19yuFBDkkwBKYV32tkiaJ
	 ZEMc6NbmklLqDm2Jn1bLLuz5nAXmHh037THj2+uA5EB6aDZzBxW2FgNWBYjiYfesVe
	 wjJZ7tCJr2Rmw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id F1E1E80E66;
	Mon, 27 Jul 2026 15:56:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id D0DE578A
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 15:56:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BC51B80E69
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 15:56:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4KeSPgGSf5bs for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 15:56:36 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 3D43D80E64
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3D43D80E64
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3D43D80E64
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 15:56:36 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66RDleGq033159
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 15:56:35 GMT
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fp4c61p5j-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 15:56:35 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-ca860baea9fso6375723a12.2
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 08:56:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785167795; x=1785772595;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hhgTlb89LuIRugF3P3X53cuo+uw8PwK21tJoNVvLGpQ=;
 b=RRjGsP5llPUdmW+mclXqQIN7S98PSsC684X/ZZ47AHZ5cJbGMqKTKfu8Zlp36hKFkQ
 ox+etfJXFrFqvDT9QfQ15kljrr5kg/qXQGRkBVwfmIQltb3xIZmeP3uS/3LTrM50G8Kr
 HXfSLLzm29+uhPJvQJTNBQT+sZ4Ka6earxF1uFrxs3ezTfwRIw2VO0EezwCqjMwgy9NI
 SOiesUWyQwTUWs3TjN79yRGFz5vkOQjhFQePlnd84/2Ti7xhfYG/ZdDJmAg8ST1WdVsn
 AAenMCI6CQSjFPj/GoBdt7udRdJeNTszRQSHOXGlCLoqp4G2QmHMM0ox3JAUYS3uBPfQ
 3hNQ==
X-Gm-Message-State: AOJu0Yyygq3wgIamXkvBKT5iE8mIQmqKfSbNdFxB4xsr9YyUZMMKYm9j
 lag6il7ItY5mV4nbkMqmS5aHVdnHvXxe1qZjIuvBipitz8nx/ejJ4Ckbr3zipS/8elGu1Zli+Qs
 SP2liPkiDSqhckgio2Vwtmy8PwYXZ7FiF9LtCf/z2BRTIq9ofFQz+e58Y03ldSAJkshVrGMU=
X-Gm-Gg: AR+sD1112JyO/mAzghqyavWxzgIdcfoMKk9f7wPQIGUgyPlgTpQd0d7/Bm1sk9q3yzx
 gcF3fFE+wTFI/XWeKtuWJvAPE0K+VoDm+NC1JaN8AOM9WtA3B2kRD8YswEEgp40l/rY9zbCc8Xm
 QW6iBMhjuugqJuc2KpWDRX7osPom+1L8c+41ZCIRQK9Ow8NbC8pyv+r5TO82noQbEQiefPt8spn
 La/sUv4nCyjDlrvWtUbrqqnALEsxTSK/GEN4UzHlDmOZdkuPt/hspGKicELCmvcq+dU33N6tUo4
 prIA+zh6oZrmjNx/i9tgQ4Pbp+9rItyTMKz72UvW9ghVK2O/Oc4R4RPEpNj+tgOBFbwLG6ulatk
 Ci5ISk30hCQuAOZd36Ss4iw00AfS2/rJBFlQ76BeftMDCKwtjk0W2wB/NMOB2P3Ee3oMObfLnlj
 PnibAHKQ/6s8TQWxMPf7lxL2RMlrVY
X-Received: by 2002:a05:6a20:1609:b0:3bf:b1d3:393e with SMTP id
 adf61e73a8af0-3c67d9b376dmr8348581637.2.1785167794726; 
 Mon, 27 Jul 2026 08:56:34 -0700 (PDT)
X-Received: by 2002:a05:6a20:1609:b0:3bf:b1d3:393e with SMTP id
 adf61e73a8af0-3c67d9b376dmr8348551637.2.1785167794184; 
 Mon, 27 Jul 2026 08:56:34 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-314bc419e3asm33286941eec.11.2026.07.27.08.56.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 08:56:33 -0700 (PDT)
Date: Mon, 27 Jul 2026 21:26:00 +0530
Subject: [PATCH 2/8] tools: mkeficapsule: Add multi-payload capsule
 creation API
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-mkeficapsule-v1-2-5b162866b092@oss.qualcomm.com>
References: <20260727-mkeficapsule-v1-0-5b162866b092@oss.qualcomm.com>
In-Reply-To: <20260727-mkeficapsule-v1-0-5b162866b092@oss.qualcomm.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Wojciech Dubowik <Wojciech.Dubowik@mt.com>,
 Simon Glass <sjg@chromium.org>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785167781; l=8001;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=5ME8wzV+NBAiyfA2FM0kjTLPc+OaF2wT1A6GR+oe++k=;
 b=VDEf7+bqCSTnYRP4xYJ0pXUr+1AfetN1N1RIYZhr6JQe8z1aRMQDMd1BWArQUPWy1kfB1Hy8a
 GbjahpFrfY2DtH7891X9KH/6cm5ch807dwIFAncTKsshNPjdRXoIM5M
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Authority-Analysis: v=2.4 cv=eYQNubEH c=1 sm=1 tr=0 ts=6a677fb3 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=ThqpGPODw0hT9kUEG54A:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDE0OSBTYWx0ZWRfX/+xBHAarKffZ
 zGyiOmyhYB24f2ETszBnFo5TBl45Tee5uB8KjAaCzuVyXd60TjUSJDcBIGdH2vmxxw8Z4vKYlYh
 LxiLCfuKPGBxQd7rjKK9GmIWTQH939A=
X-Proofpoint-ORIG-GUID: XaHuHGggvtAPvD-5WMF8o-3RpWpBVQjq
X-Proofpoint-GUID: XaHuHGggvtAPvD-5WMF8o-3RpWpBVQjq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDE0OSBTYWx0ZWRfXzbo/YZXudVzz
 8odxvYsBHusWt4CQ9Sui9tko1B54Fgg9EDaIqrGXA1vNdhAei9LbSjx2pzsp4ZV/Dbwd+VV9HXk
 P6vo44Vukb29Aj+mTaGEFEhDwQt387oZNX22NDKQkwewmTxxU4Bz2K6ujc0gVk84RngwkkaIIN0
 urSmT3rZ/QHiksmiIBKQckkGr09YLwEuoEMAHO7j7iCba5fMZ1iRDDwvPwQXteeLaeTqEBFooUb
 uHnR92f68586zkgd9WspGM91tz5T/nkvq80RlYWkC7jhUIKBbbQF83LcrPv0pTalsFRAfCA+/au
 7v8Xv/r4q1V75NoSNdw9kKFb+q5VFmzOAVGApadVPx19EjXVK/Ai79mR9Pk0tr4XzdlQ766CdIU
 6YIZsY797RZd5vR4lkrQXsPLuevnC9Y+wKcL0u3E9WNyTh7d+lQkM0eRiuypVMD0BojoJ98nHGN
 qBoZDgs47XVFJWtOD0A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270149
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 hhgTlb89LuIRugF3P3X53cuo+uw8PwK21tJoNVvLGpQ=; b=Ei1Y74Lultd3xpmN
 pXdl39dKBjtVGFAoo/qnKvfHDXjg1xksCvKiDFZQGfOcvhL1yruJFnUcnpfs9nAP
 HsnnaGzKkoEhnoNKzyzmwty//pPfZIz3G8feGAJo8QGqG2cLS4JFOExx8pRzUsKv
 Uduxyruh5yIahlouxY2kVLwLWO9qZ/oakrNGQdPCVEpdWE0oJDCzIiubAAnnHX4n
 cKU8iWRi4ryQElbwuArPC3FImLjwLKPtyY0EhEXLHP16MH8+Cf1bZSmYt849EsyQ
 H8mi1CU7MazIiUI1XF6RnjEQQxNZgbpS1Ebeyo5fY6PU2gP1/eK8RllZVnuyRe7E
 IHqCKA==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785167795; x=1785772595;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hhgTlb89LuIRugF3P3X53cuo+uw8PwK21tJoNVvLGpQ=;
 b=L3ooPXOxF0+/qxKNZLVpVbsbEBxAe8xODuWDQE7LSLuxfnyYHG+A1ncG/BVaTMprbX
 45J57w9zDYeLp7VLthh3flNJ85rOWf0lrBRHaqUVC8JVme0CY0IoCIHbU2tSO4WvQuxi
 QryVbhoLGDZCzRAIbxWGJFaCpDdQMCLBsjoeVR6lIQQTizlehtyhY+h9X15/z4yVgpN+
 It1yUD2NegsQwGiQBznVkTU+ORa+4B/gaW1cTgmhjL86Jc9MghIFES4ZFev8cp11TTlA
 Lfl/FRJvgNaamwjR+kgfwLcI7ok/HUDLSK/qgZskwBBOOoiS9HzJtGX/7vY7XMO4gj5w
 XIIA==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=Ei1Y74Lu; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=L3ooPXOx
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

Add create_multi_payload_fwbin() to bundle up to 16 firmware images
into a single capsule file. Only normal blob payloads are supported
for now; signing and the config file parser integration will follow
in later patches.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 tools/eficapsule.h   |  27 ++++++++
 tools/mkeficapsule.c | 174 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 201 insertions(+)

diff --git a/tools/eficapsule.h b/tools/eficapsule.h
index 6e27ed05144..27ccb66c3e8 100644
--- a/tools/eficapsule.h
+++ b/tools/eficapsule.h
@@ -179,6 +179,18 @@ struct efi_capsule_params {
 	enum capsule_type capsule;
 };
 
+#define MAX_PAYLOADS_PER_CAPSULE 16
+
+/**
+ * struct efi_capsule_params_array - Array of capsule parameters
+ * @count: Number of parameters in the array
+ * @params: Array of pointers to capsule parameters
+ */
+struct efi_capsule_params_array {
+	int count;
+	struct efi_capsule_params *params[MAX_PAYLOADS_PER_CAPSULE];
+};
+
 /**
  * capsule_with_cfg_file() - Generate capsule from config file
  * @cfg_file: Path to the config file
@@ -235,6 +247,21 @@ int create_fwbin(char *path, char *bin, efi_guid_t *guid,
 		 uint64_t mcount, char *privkey_file, char *cert_file,
 		 uint16_t oemflags);
 
+/**
+ * create_multi_payload_fwbin - create a multi-payload uefi capsule file
+ * @path:	Path to a created capsule file
+ * @params_array: Array of capsule parameters for multiple payloads
+ *
+ * This function creates a UEFI capsule file with multiple payloads.
+ * All payloads must be normal blob type capsules.
+ *
+ * Return:
+ * * 0  - on success
+ * * -1 - on failure
+ */
+int create_multi_payload_fwbin(char *path,
+			       struct efi_capsule_params_array *params_array);
+
 /**
  * print_usage() - Print the command usage string
  *
diff --git a/tools/mkeficapsule.c b/tools/mkeficapsule.c
index e778343a296..03a9a44e1bd 100644
--- a/tools/mkeficapsule.c
+++ b/tools/mkeficapsule.c
@@ -725,6 +725,180 @@ static void print_guid(void *ptr)
 	printf("%s\n", buf);
 }
 
+/**
+ * create_multi_payload_fwbin - create a multi-payload uefi capsule file
+ * @path:	Path to a created capsule file
+ * @params_array: Array of capsule parameters for multiple payloads
+ *
+ * This function creates a UEFI capsule file with multiple payloads.
+ * All payloads must be normal blob type capsules.
+ *
+ * Return:
+ * * 0  - on success
+ * * -1 - on failure
+ */
+int create_multi_payload_fwbin(char *path,
+			       struct efi_capsule_params_array *params_array)
+{
+	struct efi_capsule_header header;
+	struct efi_firmware_management_capsule_header capsule;
+	struct efi_firmware_management_capsule_image_header *image_headers;
+	FILE *f = NULL;
+	uint8_t **payload_data = NULL;
+	off_t *payload_sizes = NULL;
+	uint64_t *offsets = NULL;
+	uint64_t offset;
+	size_t capsule_size;
+	int i, ret = -1;
+	struct fmp_payload_header payload_header;
+
+	/* Validate all payloads are normal blobs */
+	for (i = 0; i < params_array->count; i++) {
+		if (params_array->params[i]->capsule != CAPSULE_NORMAL_BLOB) {
+			fprintf(stderr, "Multi-payload capsules only support normal blob type\n");
+			return -1;
+		}
+		if (params_array->params[i]->privkey_file || params_array->params[i]->cert_file) {
+			fprintf(stderr, "Multi-payload capsules do not support signing yet\n");
+			return -1;
+		}
+	}
+
+	/* Allocate arrays for payload data */
+	payload_data = calloc(params_array->count, sizeof(uint8_t *));
+	payload_sizes = calloc(params_array->count, sizeof(off_t));
+	image_headers = calloc(params_array->count, sizeof(*image_headers));
+	offsets = calloc(params_array->count, sizeof(uint64_t));
+
+	if (!payload_data || !payload_sizes || !image_headers || !offsets) {
+		fprintf(stderr, "Failed to allocate memory for multi-payload capsule\n");
+		goto err;
+	}
+
+	/* Read all payload files */
+	for (i = 0; i < params_array->count; i++) {
+		struct efi_capsule_params *params = params_array->params[i];
+
+		if (read_bin_file(params->input_file, &payload_data[i], &payload_sizes[i])) {
+			fprintf(stderr, "Failed to read payload file: %s\n", params->input_file);
+			goto err;
+		}
+
+		/* Add FMP payload header if fw_version is specified */
+		if (params->fmp.have_header) {
+			uint8_t *new_data = malloc(payload_sizes[i] + sizeof(payload_header));
+
+			if (!new_data) {
+				fprintf(stderr, "Failed to allocate memory for FMP header\n");
+				goto err;
+			}
+
+			payload_header.signature = FMP_PAYLOAD_HDR_SIGNATURE;
+			payload_header.header_size = sizeof(payload_header);
+			payload_header.fw_version = params->fmp.fw_version;
+			payload_header.lowest_supported_version = 0;
+
+			memcpy(new_data, &payload_header, sizeof(payload_header));
+			memcpy(new_data + sizeof(payload_header), payload_data[i],
+			       payload_sizes[i]);
+
+			free(payload_data[i]);
+			payload_data[i] = new_data;
+			payload_sizes[i] += sizeof(payload_header);
+		}
+	}
+
+	/* Calculate offsets for each image */
+	offset = sizeof(capsule) + params_array->count * sizeof(uint64_t);
+	for (i = 0; i < params_array->count; i++) {
+		offsets[i] = offset;
+		offset += sizeof(image_headers[i]) + payload_sizes[i];
+	}
+
+	/* Calculate total capsule size */
+	capsule_size = sizeof(header) + offset;
+
+	/* Open output file */
+	f = fopen(path, "w");
+	if (!f) {
+		fprintf(stderr, "Cannot open %s\n", path);
+		goto err;
+	}
+
+	/* Write capsule header */
+	header.capsule_guid = efi_guid_fm_capsule;
+	header.header_size = sizeof(header);
+	header.flags = CAPSULE_FLAGS_PERSIST_ACROSS_RESET;
+	for (i = 0; i < params_array->count; i++)
+		header.flags |= params_array->params[i]->oemflags;
+	header.capsule_image_size = capsule_size;
+
+	if (write_capsule_file(f, &header, sizeof(header), "Capsule header"))
+		goto err;
+
+	/* Write firmware management capsule header */
+	capsule.version = 0x00000001;
+	capsule.embedded_driver_count = 0;
+	capsule.payload_item_count = params_array->count;
+
+	if (write_capsule_file(f, &capsule, sizeof(capsule), "FMP capsule header"))
+		goto err;
+
+	/* Write offset array */
+	for (i = 0; i < params_array->count; i++) {
+		if (write_capsule_file(f, &offsets[i], sizeof(uint64_t), "Image offset"))
+			goto err;
+	}
+
+	/* Write each image header and payload */
+	for (i = 0; i < params_array->count; i++) {
+		struct efi_capsule_params *params = params_array->params[i];
+
+		/* Prepare image header */
+		image_headers[i].version = 0x00000003;
+		memcpy(&image_headers[i].update_image_type_id, params->image_guid,
+		       sizeof(efi_guid_t));
+		image_headers[i].update_image_index = params->image_index;
+		image_headers[i].reserved[0] = 0;
+		image_headers[i].reserved[1] = 0;
+		image_headers[i].reserved[2] = 0;
+		image_headers[i].update_image_size = payload_sizes[i];
+		image_headers[i].update_vendor_code_size = 0;
+		image_headers[i].update_hardware_instance = params->hardware_instance;
+		image_headers[i].image_capsule_support = 0;
+
+		/* Write image header */
+		if (write_capsule_file(f, &image_headers[i], sizeof(image_headers[i]),
+				       "FMP image header"))
+			goto err;
+
+		/* Write payload */
+		if (write_capsule_file(f, payload_data[i], payload_sizes[i], "Payload data"))
+			goto err;
+	}
+
+	printf("Multi-payload capsule created successfully: %s\n", path);
+	printf("  Total size: %zu bytes\n", capsule_size);
+	printf("  Payloads: %d\n", params_array->count);
+	ret = 0;
+
+err:
+	if (f)
+		fclose(f);
+
+	if (payload_data) {
+		for (i = 0; i < params_array->count; i++)
+			free(payload_data[i]);
+		free(payload_data);
+	}
+
+	free(payload_sizes);
+	free(image_headers);
+	free(offsets);
+
+	return ret;
+}
+
 static uint32_t dump_fmp_payload_header(
 	struct fmp_payload_header *fmp_payload_hdr)
 {

-- 
2.34.1

