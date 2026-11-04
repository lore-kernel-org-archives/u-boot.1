Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD7A606A326
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 16:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=twEQyAFi;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=HonAVMYk;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RZYlh+Zf
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0938180D50;
	Wed,  4 Nov 2026 16:35:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aiJZ000RD-LN; Wed,  4 Nov 2026 16:35:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 431A880C7E
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793810144;
	b=EkJAX56CM9SxzSUqqj1xoeL3IV+/a2FcH27NpvePVZpI2sxI9BuoPHpw/ifrYN3aT0c0
	 evIaB571rPaFvDxsOu1LHDUGZ51QYH6H5BZ591jKrKVBYRL2LmfPgYUMRMp3Vnauv4VZ0
	 Kd97dwiDK3bJwvs9hD+fHr2pQLrQuJXknXD0P27hsOkTP9AZBDu58ntKFmDJxYCMqfpa7
	 4E8nCziUxgSOVCQtsAPqelk0mlacUljiTnuuU1ZgEFVhZgdQakkLG0zLHr4570DTOnBJT
	 6Ms7b34ZKCtCAwlHVWYzRohu+hZl4P5TuxVoFhBMWcIesrIj6JJIaX1/Xiq9WyQ5sqA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793810144;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=rVAiOCLTRbApVn9H2OP1Qa8nDsp7moMETbhhP6rAMZ4=;
	b=iY6WlH6vIFPxhXSTc5misodGOXtiAWERZ63Sj/1H8lpEOoTvSnAJAgC/EfZvgwIz3ulY
	 KxjFbObLWuqpceuwUXvRJyNQ0jOgGKlDkEd03lcYJFqm1Zvl+fFdFHhbv4RLDyuKngfE6
	 lGkMu7DzBaRDgKDCI9YqwPvQtG6Pv78rJstif3Gjj95JZnyN+p8g3FeOQUg2pac07Ip+V
	 NAZhkaysBrUF68UCY7c3bqEI2S5dL1VjPDeGWVHBywQefBXQ3ilTQdyDYEm9zJsydGf3D
	 CFAX9IA07J3FrG5zNp8PrNbjj+VHz2GO328VDtroTdvIPM3YoOQHoKuel7tB1nZ1HmQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793810144;
	bh=rVAiOCLTRbApVn9H2OP1Qa8nDsp7moMETbhhP6rAMZ4=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=twEQyAFiYSfdf21QtYTWZslh/7x0l/p+5Bbz5bO069U3ME6dZ3Wu6Z1QLCrzSwhvW
	 8HbCBM3rTdRon1koUwEwMy01x8ccHsPIB0cY55aPqLLlS1Cdemknc3i/91/05dXtyP
	 medANmzukfBYgidf+nvce2sBnEi/RuCmh14EfS/UZoYOLARyqO6JrTjDiRQ7N+A3nU
	 JOG47hAUgzSg2R8Fj5HDc+NpH3YKpE2DUa69cMFsBA8xqiLKL6Rsq6I8wuQ55BU5+k
	 FidpY1hYXeDtn6SjGdByegDJFgt8AXZ1RQTFhUqKuyU9oPI0SunvUlLeZTpFArNb6i
	 ASTLJWaU9OW2A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 431A880C7E;
	Wed,  4 Nov 2026 16:35:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 29827165
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 16:35:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1B79C60650
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 16:35:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UPf7zSEIwH6i for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 16:35:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7C1AA60642
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=sumit.dhami@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=HonAVMYk; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=RZYlh+Zf
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7C1AA60642
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 16:35:41 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A4FipXU1292216
 for <u-boot@lists.u-boot-project.org>; Wed, 4 Nov 2026 16:35:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=rVAiOCLTRbA
 pVn9H2OP1Qa8nDsp7moMETbhhP6rAMZ4=; b=HonAVMYkR/7L4Hrv7X7mhTHF7Lc
 WT1dQiXtWcJHpqTvojpx7o4R6S6sWB0qIyo9+ZfxP2AGQzH62ZZyUOPI5FxQBozm
 txOqlQbZYZA3AaoU+UlHetaiT2ajttKnn9xXGI+BDf/FALxOSe2IrGLk7wWi+hCR
 eyTVroCfOWdX5PjG1jI6vRDlp92zWUO4vQdBXNMT8JB+uFiIAMlCSwMUTeMFpaaf
 gFC7AAfbwUKJS3KVLC7hZVGADUTLzzQYn5DPK2Vi6xCmZuWNDsybImC6lvFXSEgU
 b4UqmXuLuOboszAHbJOnnYNXhz9wYbTJrwUfQk6kNP9EpG3EA6+hfNU8eVw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hr163hx77-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 16:35:40 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-36d2d353a5aso593834eec.1
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 08:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793810140; x=1794414940;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=rVAiOCLTRbApVn9H2OP1Qa8nDsp7moMETbhhP6rAMZ4=;
 b=RZYlh+ZfV3Ybton4nKgxA3D4VKlswDsAPMYTDJqcF537ZdiPeEq/34sHhPyC4+iPvF
 G7lDG3Pce+d/IncIr58/sWOGsssJ3C/9MwETIRKiaF0LUku/u5fz8OcBofYGJ1BrunHc
 rnPqH1ze1hM3E5av9Ask9OzaByLzaCX7VWqWZGCXipae0iXV3hrzxzGflEI0yJY1vj/I
 qmY+YsKLTL5Foeo49UfYl1pvRFhDteV317/cRI3vxxmW4hWF7Jzgw/Vd7q2KslQUBExK
 lxXMna8fQ/U8jPLLzr3LxYH9D9DPPm+cjUognOf2/7++tXmv9r99Nbo1SoG3PE0uhn6Z
 EMGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793810140; x=1794414940;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=rVAiOCLTRbApVn9H2OP1Qa8nDsp7moMETbhhP6rAMZ4=;
 b=XkzQLwNQ2HDYj8+T9rQHlq7wxFXp/cD7Yo3DeSD72EVyQIjO+gJqEHtb4jpuYgyNBb
 TJTLPvMgDQaOOwTf35UvBG4yqFoikKigvM6Cc8o6tdztdaiMlOFtZFMf6wC6X1fFaRI0
 zhyCXbvKqiRexwwl7K7jzO03ChxbfOQgJKRiXx3BwzWfE4JMe5UPyUcnqiET5Z+IsKo7
 jzXfcjqwFAcZCXTDhGpvZ5x2mbIjK01lvl+FQMLc0k8OKtwO6pkFko+eY7yGr7zyNMFF
 lcioUGHj3RrsDhSUPSMogDGqlVnj226z91CqXVgpQf9Zkx3PEh2AMvorygiAQXY/684U
 W7xQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBy/5lx4o3PLQSgiSKdCf44ohYwkMSLnG1x2WVDo/TRf4dRZx1Ug/2ooYiC+GwlEqShLKb5Vt+s=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8Tkhoghcr/JaaJOmzslrqHYOUN/jTvOr7dChS8YCErszmTdTCo
 udfWcHMcapdbyGdJseLb/mER4hss1iDVZ78qouHFMWKRx3lF2goKrLm8CdHlFO5F9rfXFK1v9Bt
 daCCuyKItsUqNGl2fryHs7rbG4a7U2YtabPpy4dmw/ZI7mhS2rpUhaxXvpwmFFB6UkEQwUZA=
X-Gm-Gg: AYBFou02u6i0t9rYi+lMONxuhdQj1msB/Imh06+Mj+Ny6PKiiQvnpTNzR+ov0+xkK3p
 F+lfy4ik3jlY5IRD2CNqkxgxhyS3bRjzfqquZwl2mjitTIhc+aNxUN9USGtXzLNbTB8ap1wQZRC
 lB3vaMmLQYJzxUwxdwi0wCucqocYviC/3mgJMgG7G7sluVrCbnS/nz0p/T5j+Umd80P1kJiKYmn
 MNVR27JOpRzsboKTn8YSqzLOW1EKpV6xz5udZxSNZtxF9dtqQaQD/FWPX7Iv5ZfKGdtzBErqKGM
 joCQGeOtnTOjh8UCqry2gGJneAzdOlEWo/4xLcF5xFa0rTACTOFPNE6Syjj3fWSIgA1M8x0l3ha
 K07qYi6OVrs800g7u/0TbVzhic9C0pccPr+j3pR5Rd7cxAkPuCLUkUAil0TwiKH2BnkXc0hO2Jh
 JF0UK+SXgnqNNcV+/auA7g6X3BLcJaM67vjpbkLpRglqp8Bb5lHW4dVz1nIL5I0xfp
X-Received: by 2002:a05:7300:dc10:b0:36c:a1bc:6102 with SMTP id
 5a478bee46e88-36de0488bc8mr137208eec.0.1793810139850; 
 Wed, 04 Nov 2026 08:35:39 -0800 (PST)
X-Received: by 2002:a05:7300:dc10:b0:36c:a1bc:6102 with SMTP id
 5a478bee46e88-36de0488bc8mr137148eec.0.1793810139288; 
 Wed, 04 Nov 2026 08:35:39 -0800 (PST)
Received: from hu-sdhami-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36db94376b1sm1046879eec.10.2026.11.04.08.35.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 08:35:37 -0800 (PST)
From: Sumit Singh Dhami <sumit.dhami@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, lukma@nabladev.com,
 sjg@chromium.org, Michael.Srba@seznam.cz,
 senthilkumar.l@oss.qualcomm.com, sumit.dhami@oss.qualcomm.com,
 manivannan.sadhasivam@oss.qualcomm.com, nathbappai@gmail.com,
 balaji.selvanathan@oss.qualcomm.com, petr.hodina@protonmail.com,
 marek.vasut+renesas@mailbox.org, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v1 9/9] configs: qcom_defconfig: enable PCIe1 RC/PHY and
 qcom_board_init override for QCS6490
Date: Wed,  4 Nov 2026 22:03:58 +0530
Message-ID: <20261104163408.1250410-10-sumit.dhami@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261104163408.1250410-1-sumit.dhami@oss.qualcomm.com>
References: <20261104163408.1250410-1-sumit.dhami@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: HlJmFv9fbnaHBLinZoMFrNlcg_OXQbjr
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA2NiBTYWx0ZWRfX/7OffxpT/3cf
 bwGsRyLVUEpkiUIxjSN0P4SjKEQIIkfwr9fmwLCgmvd/HKUhgkD/jhjiwdR3KMREcCNJqYFDOpS
 feF1M3pC9Oy+sNwnImbJAkNoADRDYg4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA2NiBTYWx0ZWRfXwz37oDJ2CQOp
 1gaR0F598fJi4xrhs5FVTi6SNhyUGFXIK+zYm1WO2iaMIEhELjo/cIjvjrLg7p5w1q/HX8lofCU
 BOULOTKhBUPEPFyGl12U9qeUP8TFwjebvR7Doz3BEGfR9tbAnFzop6kEPFwvILQBvWBkPR/U80X
 O2fgIWoevpZPUEdgLpf8nEYFSzUB2HLE9aNm0zDrJkWFbFsscn1qf9I/vdlQ+IExSWzII+20YT+
 XT4ykKH5bF0A8+gH6wDQcXCrnJb9tdEBF5me58DsYJ34qdxarBFL2MM9N8t4B6ztvMMstktQSos
 gkyC1/jqBwhroIF47GnPSsW7+UUvj+FU8mXkNMRYxjYk7chXOljjo+PeVggNT1oPWXKZwWzbvWZ
 DILhUOnJiFN3YJ60CTpXOg7pgPyn25gIhTBTceDXryoWstFR4edzBIBH8NeQKmXgOSPPy3SYbos
 drtR52E8NBzrWohLvRg==
X-Proofpoint-GUID: HlJmFv9fbnaHBLinZoMFrNlcg_OXQbjr
X-Authority-Analysis: v=2.4 cv=O5OsLx9W c=1 sm=1 tr=0 ts=6aeb5edc cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=2xNLncASRj2ts_CbtmMA:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_05,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611040066
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Senthilkumar <senthilkumar.l@oss.qualcomm.com>

Enable the generic PCI subsystem, the PCI command, and the Qualcomm
DesignWare PCIe controller and QMP PCIe PHY drivers needed to bring up
PCIe1 (RC1), which on RB3 Gen2 connects to a QPS615 PCIe switch.

Also, enable QCS6490_PCIE_INIT to override the __weak
qcom_board_init() in mach-snapdragon/board.c for
QCS6490 / RB3 Gen2 platform.

Signed-off-by: Senthilkumar <senthilkumar.l@oss.qualcomm.com>
Signed-off-by: Sumit Singh Dhami <sumit.dhami@oss.qualcomm.com>
---
 configs/qcm6490_defconfig | 1 +
 configs/qcom_defconfig    | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/configs/qcm6490_defconfig b/configs/qcm6490_defconfig
index 7e7739c9d73..a8afd2ccced 100644
--- a/configs/qcm6490_defconfig
+++ b/configs/qcm6490_defconfig
@@ -16,6 +16,7 @@ CONFIG_DEFAULT_DEVICE_TREE="qcom/qcs6490-rb3gen2"
 
 CONFIG_FASTBOOT_BUF_ADDR=0xd8800000
 CONFIG_PHY_QCOM_QMP_COMBO=y
+CONFIG_QCS6490_PCIE_INIT=y
 
 CONFIG_FASTBOOT_FLASH_BLOCK=y
 CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME="scsi"
diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index e5291750aa7..387ce2492cf 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -111,7 +111,12 @@ CONFIG_DWC_ETH_QOS_QCOM=y
 CONFIG_RGMII=y
 CONFIG_PHY_MICREL=y
 CONFIG_PHY_MICREL_KSZ90X1=y
+CONFIG_PCI=y
+CONFIG_PCI_PNP=y
+CONFIG_CMD_PCI=y
+CONFIG_PCIE_DW_QCOM=y
 CONFIG_PHY=y
+CONFIG_PHY_QCOM_QMP_PCIE=y
 CONFIG_PHY_QCOM_QMP_COMBO=y
 CONFIG_PHY_QCOM_QMP_UFS=y
 CONFIG_PHY_QCOM_QUSB2=y
@@ -143,6 +148,8 @@ CONFIG_USB_XHCI_DWC3=y
 CONFIG_USB_DWC3=y
 CONFIG_USB_DWC3_GENERIC=y
 CONFIG_USB_GADGET=y
+CONFIG_USB_HOST_ETHER=y
+CONFIG_USB_ETHER_ASIX88179=y
 CONFIG_UFS=y
 CONFIG_UFS_QCOM=y
 CONFIG_VIDEO=y
-- 
2.55.0

