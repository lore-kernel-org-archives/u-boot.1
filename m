Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC2F2C5B572
	for <u-boot@archiver.kernel.org>; Thu, 13 Aug 2026 05:50:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A390040947;
	Thu, 13 Aug 2026 05:50:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1sXG9xRz7zaJ; Thu, 13 Aug 2026 05:50:49 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A956C40925
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786600249;
	bh=g50Lm/iQFgo8LMpF3NO+9Y4+S2csOC3ps5+z6IPO9qc=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=imu2UUgq1Zjuoi1yxqB48NUCsx7Tu5JqM0Cw93FkT1tm5/JLPQXzZgWEkMRrsS/Vt
	 GGKDgDBAey99w2onakodq09UKisEcD2ffYz9IWRJ5vd2B5SVm0oz9L3eP2sTQfcXFp
	 mRB2V9Mr3pewbzTKc1Jj8EUIo0JWvY/mX3D/aspBGLbXnVOLIasr88Cts3po0ZUmy2
	 RCQMz1a/6PkAmHoFEpcQUzKUJttC5gqlM+2h9OUgIK+qCtHNyEIYhFYwuiNaYQRxPr
	 gpnpdG/y8dVzWUhq5a6TpmNyCjsqTGVZwyQFjU7hWKYfLREVTKWxbAmzhGCpm+6QaW
	 j3bGw3im34dOQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A956C40925;
	Thu, 13 Aug 2026 05:50:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7E974744
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 05:50:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 65A3B608A1
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 05:50:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SapvftEyxnYU for <u-boot@lists.u-boot-project.org>;
 Thu, 13 Aug 2026 05:50:46 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 6CB59606C2
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6CB59606C2
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6CB59606C2
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 05:50:46 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67D5g4Z91530134
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 05:50:45 GMT
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g143hru9k-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 05:50:45 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2caf4173b1cso33826405ad.3
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 22:50:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786600245; x=1787205045;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=g50Lm/iQFgo8LMpF3NO+9Y4+S2csOC3ps5+z6IPO9qc=;
 b=PwfR0GR/SkGcbJJATbwpMT+P0CnKhNwYSSCHOA9tSOe+4VTkgkyLtcNCfqdYqrxBxI
 8s5ZG+Sm+OcZvN7EfsEPGxKCA/GmYeNWUjaHhrKQbEsGBZupBO89/8pY9kCs33N4EIWA
 x8cgAdvsBHK2QxsUD103QMH5rPsvFYRrZ6cgfKFgoc2dt8Dq8euuA8x6wB4yfYMAhxgq
 pn7akbA8OgHVMuIVxkSshW+cxGXrEBvNz6D1sfShGHQE23wMbUFXGQHp317djXOY/Kd6
 OsNvrsFN0q5wiDUaEX0PGf2iozDm7/cdIaseOCPO1/CMbUvSn861akuSLOk/6Jc0lZX3
 dMvA==
X-Gm-Message-State: AOJu0YyFhFcZDI/7JXIqDKXl9I2nzqr3FYdVVEaSJBcYDKdqxGGRcnFQ
 ZBwcMKMHcBUzicTP94l0gcIBDUC4Vh6Iv8PnNM6PtEwf3N1RRYE8YkfiMbD5FqP3LHclvqnXb9z
 182bZyksW/8yRewJ/cAkjIZa+m/DVuR0F/s7aVt3ietVxDICcfDPiM+osj3cmQqKfNyLOPZE=
X-Gm-Gg: AR+sD12dO/F8/Gf2iADqVNk6QmumBlzfGWU0qwdPTAU9pTdR+x4Dj/59yYF7++D9+Ly
 FZ+3vQV6spOLAHirBUPDfLvWbDv1WrK7yeA2KfSf9j1pADrZhrQLN31kOp2a1gdBJ0fK728lER9
 Sgwyltu3vLF7gVe22v6hkIi37Ymz1rrptUrW5/pTEcmqtJVyiRS0ky45hdVvaI2lFixU1B6JwFE
 Zi/3zFnHX2XlTQCKm003Mk8seYqzYctiMpSarba1pyBrn9GDTOMJCs7UBzw9aK/hqYL2P9QUdCR
 3+mWTfx7IhjTkXns3OTzMgvalaL7YjBh5ZNHJQTs5hvf5eSzIdFhp1Yq08oOMwLRpkv5iEM/rXJ
 JALXyctqwV7yodhddSbQKR7p2yRfl1YvQ4ECXIGgGGmzyZvDytDb9p+feLEnjHb0v5S7CjqDUTq
 u0YPXfPcrAcFQdEnWn4VfyD0C8zVvM
X-Received: by 2002:a05:6a20:450c:b0:3cb:b8a0:aa5a with SMTP id
 adf61e73a8af0-3cc55427900mr4978588637.35.1786600244992; 
 Wed, 12 Aug 2026 22:50:44 -0700 (PDT)
X-Received: by 2002:a05:6a20:450c:b0:3cb:b8a0:aa5a with SMTP id
 adf61e73a8af0-3cc55427900mr4978538637.35.1786600244596; 
 Wed, 12 Aug 2026 22:50:44 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31ec022acabsm3402870eec.27.2026.08.12.22.50.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 22:50:44 -0700 (PDT)
Date: Thu, 13 Aug 2026 11:20:20 +0530
Subject: [PATCH 4/4] efidebug: capsule: add a command to list updatable
 firmware images
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260813-efi-esrt-last-attempt-v1-4-3be172f47d9d@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786600229; l=6359;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=ed6HjmxqZE78Be8cqRIkyftv+ZtxuUD0KJYrkxvCTBI=;
 b=Z0ae7TBtw5B0px9Q++x80NERo2J9hKRx3JE3X1nCILkH6BAAY44bRsS9wODKi4yva0sczIHMR
 jH0lRN2p1RuBexaGl4DeAeTM2DaG5YhfRwFqqbQ3H23YsCxT60yQF0N
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Authority-Analysis: v=2.4 cv=R5oz39RX c=1 sm=1 tr=0 ts=6a7d5b35 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=ttS00wRf8PlarL_KFAsA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDAzNyBTYWx0ZWRfX+xVEVrDrstvQ
 Wq8PPefafoR+/G3y5zniZ4RuNJ1qTnHHpK5pPW9QAI6YaXQFxdSTeXYluVC7HAs4nfbkwcZMlw1
 iOUlBU/yr8aDz03w1/bUVxorUR4+uWqCe8zIoxu4XM97uEBOqLSnQOLWKMZDyeXzmnrQ5ltofhk
 0Aiubj79T1j5auJa4cxuMkorm4Br71P4l3eblyXmxt9yq6zkcnZzJ1PNddi6HLL+SxPJEZPN6Fw
 Mz50rTt4weqkgW+5n9v6HI9iOmR+VaIdmXy25kNosmYBBXHHEjBv2ObZqFTXdoqod/IOS4qHMwj
 NtRor5IZDGxOauHtDwCSSqKLF58H76CynZ9qaA0IitAJUxLW8cv/dX6zP4fo51WJbdTOlYBdFE+
 cWwlgBPkjc4YGbEePNmLegvvvFVF4RYutTFdZ+ItLLaaowh+bZCZyJCsU/biXC4ko6xUeYatWaS
 MRrYPcyt1u3d+EpKFtQ==
X-Proofpoint-GUID: zpbySMIxj5_rQD1qOKfBnDi6frcZbWuk
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDAzNyBTYWx0ZWRfX6z4smQiKBKWB
 ke6OJeBtIMuyv7XbpetwPCUQK7BbLB4kIi6fyTwK++unT6WgaHMVbczlI7NGu8pe+s5Dwn9Vt2/
 8hyjUbvCaymG3gz+FinTkhzYr+VdlCk=
X-Proofpoint-ORIG-GUID: zpbySMIxj5_rQD1qOKfBnDi6frcZbWuk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_02,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 phishscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608130037
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 g50Lm/iQFgo8LMpF3NO+9Y4+S2csOC3ps5+z6IPO9qc=; b=hmVaw/vCBSrgxSZV
 Q+QF7B9le4E9BubvazhLutx4g7FGEJQWNUpudKoXz3/ExJkOnF8FEYdVuljEZmNR
 CPWgy5rnvwMGdCJGqkuWxFfQbjpd48a/OMhTzWzWQ5Bvg0fS3xJ2e11Zf7xIqeTF
 u6zqXhI2F/xqZ1zPwRD29yW4Om0Spu4nfR+XYTKLN1D6WtyBj0nIQBLg/tqQo/57
 LtujfMiQbTzNMk9I4T6SyfkyiWKKSYcV6yTe0SMkc9zygWFOmi6hD7GankMeT9Cj
 lhdayOPaCD/xG1uBgTquRjPGOnir9WeIjFQ0UH9+O0P/fh47ktLYu6Svi9C/j3oJ
 vEYRzg==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786600245; x=1787205045;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=g50Lm/iQFgo8LMpF3NO+9Y4+S2csOC3ps5+z6IPO9qc=;
 b=J5AyFleq1HQSbJWmNBbeCLzZlkznu5F5x6dMpiAVJ7Rz8did9LQkle+/drLS292ncw
 pnswVRspUfDzzf8yOCDTehQyU9JSIMvqDeb5ArnHtIi4QewfxPtSztaeBfgFTFqhM47g
 CKWgAym/dRYaxYgYDGnLMc9iCep0USzeA86yOVPog6PJhaNIcJ0cEkOTh0Jz4FYAguct
 wi7+XVv3GMXZ0H7aqfAa4hIcqqu35WC3Pm4muF+h5Jtcpu3W9SHimsuFrs3BuEMng300
 iZ4gCjuevncR0e8d7mm+RyHFxhxKZAYq9BVuDtsStyg/CibwRoc7wnyEPJnJacx+7nAP
 OwDQ==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=hmVaw/vC; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=J5AyFleq
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

There is no easy way to see which firmware images a capsule can actually
target on a given board. On platforms that build their fw_images[] table
at runtime this is worse, since the set of images vary per board.

Add "efidebug capsule images", which walks the installed Firmware
Management Protocol handles and prints the image descriptors each one
reports, along with the image index, name and type GUID. This is the
same information capsule matching looks at, so it doubles as a quick way
to check the GUIDs in a capsule line up with what the board expects
before attempting an update.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 cmd/efidebug.c                                     | 102 +++++++++++++++++++++
 .../test_efi_capsule/test_capsule_firmware_raw.py  |  22 +++++
 2 files changed, 124 insertions(+)

diff --git a/cmd/efidebug.c b/cmd/efidebug.c
index e55de04c699..a9e445d03fa 100644
--- a/cmd/efidebug.c
+++ b/cmd/efidebug.c
@@ -294,6 +294,104 @@ static int do_efi_capsule_res(struct cmd_tbl *cmdtp, int flag,
 	return CMD_RET_SUCCESS;
 }
 
+/**
+ * do_efi_capsule_images() - list firmware images updatable by capsule
+ *
+ * @cmdtp:	Command table
+ * @flag:	Command flag
+ * @argc:	Number of arguments
+ * @argv:	Argument array
+ * Return:	CMD_RET_SUCCESS on success, CMD_RET_FAILURE on failure
+ *
+ * Implement efidebug "capsule images" sub-command.
+ * Walk every Firmware Management Protocol instance and print the image
+ * descriptors it reports, i.e. the firmware images a capsule can target
+ * on this board along with their name, index and type GUID.
+ *
+ *     efidebug capsule images
+ */
+static int do_efi_capsule_images(struct cmd_tbl *cmdtp, int flag,
+				 int argc, char * const argv[])
+{
+	struct efi_firmware_management_protocol *fmp;
+	struct efi_firmware_image_descriptor *image_info, *desc;
+	efi_uintn_t info_size, descriptor_size, no_handles;
+	u32 descriptor_version, package_version;
+	u16 *package_version_name;
+	u8 descriptor_count;
+	efi_handle_t *handles;
+	efi_status_t ret;
+	int i, j;
+
+	if (argc != 1)
+		return CMD_RET_USAGE;
+
+	ret = EFI_CALL(efi_locate_handle_buffer(BY_PROTOCOL,
+						&efi_guid_firmware_management_protocol,
+						NULL, &no_handles, &handles));
+	if (ret != EFI_SUCCESS || no_handles == 0) {
+		printf("No firmware images found\n");
+		return CMD_RET_SUCCESS;
+	}
+
+	printf("Image Index    Firmware Name         Image Type GUID\n");
+	printf("===========    ===================== ====================================\n");
+
+	for (i = 0; i < no_handles; i++) {
+		struct efi_handler *handler;
+
+		ret = efi_search_protocol(handles[i],
+					  &efi_guid_firmware_management_protocol,
+					  &handler);
+		if (ret != EFI_SUCCESS)
+			continue;
+		fmp = handler->protocol_interface;
+
+		info_size = 0;
+		image_info = NULL;
+		descriptor_version = 0;
+		descriptor_count = 0;
+		descriptor_size = 0;
+		package_version = 0;
+		package_version_name = NULL;
+		ret = EFI_CALL(fmp->get_image_info(fmp, &info_size, image_info,
+						   &descriptor_version,
+						   &descriptor_count,
+						   &descriptor_size,
+						   &package_version,
+						   &package_version_name));
+		if (ret != EFI_BUFFER_TOO_SMALL)
+			continue;
+
+		image_info = malloc(info_size);
+		if (!image_info)
+			continue;
+
+		ret = EFI_CALL(fmp->get_image_info(fmp, &info_size, image_info,
+						   &descriptor_version,
+						   &descriptor_count,
+						   &descriptor_size,
+						   &package_version,
+						   &package_version_name));
+		if (ret == EFI_SUCCESS &&
+		    descriptor_version == EFI_FIRMWARE_IMAGE_DESCRIPTOR_VERSION) {
+			for (j = 0, desc = image_info; j < descriptor_count;
+			     j++, desc = (void *)desc + descriptor_size)
+				printf("%11d    %-21ls %pUl\n",
+				       desc->image_index,
+				       desc->image_id_name ? desc->image_id_name : u"",
+				       &desc->image_type_id);
+		}
+
+		efi_free_pool(package_version_name);
+		free(image_info);
+	}
+
+	efi_free_pool(handles);
+
+	return CMD_RET_SUCCESS;
+}
+
 static struct cmd_tbl cmd_efidebug_capsule_sub[] = {
 	U_BOOT_CMD_MKENT(update, CONFIG_SYS_MAXARGS, 1, do_efi_capsule_update,
 			 "", ""),
@@ -309,6 +407,8 @@ static struct cmd_tbl cmd_efidebug_capsule_sub[] = {
 #endif
 	U_BOOT_CMD_MKENT(result, CONFIG_SYS_MAXARGS, 1, do_efi_capsule_res,
 			 "", ""),
+	U_BOOT_CMD_MKENT(images, CONFIG_SYS_MAXARGS, 1, do_efi_capsule_images,
+			 "", ""),
 };
 
 /**
@@ -1618,6 +1718,8 @@ U_BOOT_LONGHELP(efidebug,
 	"  - show capsule information\n"
 	"efidebug capsule result [<capsule result var>]\n"
 	"  - show a capsule update result\n"
+	"efidebug capsule images\n"
+	"  - list firmware images updatable by capsule\n"
 #ifdef CONFIG_EFI_ESRT
 	"efidebug capsule esrt\n"
 	"  - print the ESRT\n"
diff --git a/test/py/tests/test_efi_capsule/test_capsule_firmware_raw.py b/test/py/tests/test_efi_capsule/test_capsule_firmware_raw.py
index b8cb483b380..e6246a83ff0 100644
--- a/test/py/tests/test_efi_capsule/test_capsule_firmware_raw.py
+++ b/test/py/tests/test_efi_capsule/test_capsule_firmware_raw.py
@@ -238,3 +238,25 @@ class TestEfiCapsuleFirmwareRaw:
             check_file_removed(ubman, disk_img, capsule_files)
 
             verify_content(ubman, '100000', 'u-boot:Old')
+
+    def test_efi_capsule_fw6(
+            self, u_boot_config, ubman, efi_capsule_data):
+        """ Test Case 6
+        List the firmware images updatable by capsule with
+        'efidebug capsule images' and check the images sandbox exposes
+        for raw capsule updates
+        """
+        ubman.restart_uboot()
+
+        output = ubman.run_command('efidebug capsule images')
+
+        # ensure that SANDBOX-UBOOT and SANDBOX-UBOOT-ENV are both listed,
+        # along with the image index each one is exposed at.
+        assert '1' in output and 'SANDBOX-UBOOT' in output
+        assert '2' in output and 'SANDBOX-UBOOT-ENV' in output
+
+        # ensure that SANDBOX_UBOOT_IMAGE_GUID is reported.
+        assert '985F2937-7C2E-5E9A-8A5E-8E063312964B' in output
+
+        # ensure that SANDBOX_UBOOT_ENV_IMAGE_GUID is reported.
+        assert '9E339473-C2EB-530A-A69B-0CD6BBBED40E' in output

-- 
2.34.1

