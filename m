Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27CE6606A329
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 16:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=gIiy87JT;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lPgcsQhn;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=IWm4ziAA
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F3ED7405C6;
	Wed,  4 Nov 2026 16:35:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Mfg1q9JRkMRI; Wed,  4 Nov 2026 16:35:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org DEB6740312
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793810129;
	b=khMmrfYLgQP3MB9QYWXL7BRqdEBWIlPLaZeXf+uY+QZ9RpJO1Ux+Hxs6PaDIQjno2kY+
	 urjwOyGE08S0OC2QJ0H6uO2TWbC+XNzIAZgfXb6apdwgTT9gtTZZLUB9oQ5/FKPdFhPMu
	 plUkT8SoRu9xbxB0XY8WwWtkUFGpWqjyn573DJOqDNPt/S0wc2dHhtippw53rlLAVCoR7
	 9VHH9fDCUjpDhRFQ95J8arR42O/cIA7oiaBNLEiiODf5e7iYw83nYFCelokoBhY63qw2+
	 jvZIDzR+7GCbafFrTqKkOx+FdbVMN3+gyWiYqV5/eo2tJiNDAnEY2kwBqhqAwul9xWQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793810129;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Q4L0V+yT/wFuBA/rLzoe/ZyVgXiV5kNqQzvSMldagDE=;
	b=hWQhtoIAyBMqpetERPHtkh6XmfZ1sHdJkAZlCbLN7eY0BqWKLF8TLe+UT7nI4h7CXBAr
	 N8JNtyTWscYkMf+ybh0zXdTZNwdiw2cKGGnM8qmuSqhbNp1AOV6CVschiAuy68p7zZjGb
	 LWhLaCterGQG2YSHERCwA/8kGoJ+jvoi7uDSvwdq4AENKXT310ns3fTYMqPQ7vWo5ycHl
	 OKPXh6UrbPNDtR7ptF9k2o4FkRNySpJswvgzpKFS4HDkyR94fnmfGXKTdw27IbqqD1R65
	 +Bd/2lco6fiVsAwUTRTyNiX4XNyyAbMZNgwtv8swwBhl8yuQ0f6X12pWed5BOAWLx0Q==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793810129;
	bh=Q4L0V+yT/wFuBA/rLzoe/ZyVgXiV5kNqQzvSMldagDE=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gIiy87JTwDpRTIPur+7v9Fvw3+vbfrfd+qxgb3/wWgcbCbHgALUNFZpCGE2psafKU
	 YODxmY8w49i8yAXs5TFQPJX7RQbgLFVZrkgsfqAJxslB7FrkuOT4DStRjokVJsZ/MQ
	 AoAyYAVzHklUIsaZB1RQBnuo6+fvwCiG8LFa0Oy2tsONTwmlY/hjaKBSsHmYzl8mx2
	 lbw6Edtdmr+p3JMMI04BGXOE3dp9/gcDjWgyTREF5dPwGisVjVsjGJYLc6nQv65uG4
	 xDE1vAXOOfl/i22/OtfI4PfNZDMjyWqo6v8aytFPUfyY2Qbih73zvNDMCHcYNrQWaC
	 JFM64Ox1gBeYQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id DEB6740312;
	Wed,  4 Nov 2026 16:35:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id F352A280
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 16:35:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D949340068
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 16:35:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JnJSwA1ZkAu3 for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 16:35:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org F24B940062
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=sumit.dhami@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=lPgcsQhn; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=IWm4ziAA
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F24B940062
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 16:35:25 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A4FimVV3272795
 for <u-boot@lists.u-boot-project.org>; Wed, 4 Nov 2026 16:35:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Q4L0V+yT/wF
 uBA/rLzoe/ZyVgXiV5kNqQzvSMldagDE=; b=lPgcsQhndKJFkeyY2W7T3nIHnVF
 /JNITsclM/KNopq1kSoZpg+HCA9Th7Wg9fQEXpUz4/NluZ14DkihePi8PztxKsGy
 fFOol+mcB5HgnwiDneuu9bia+nIorvnHRr7u1ZUMQ6JnOqezK1evFi4ON8QQuUBB
 J9b6cxY0iMyjxQce9Shmdsb+OSsXftwDX7Pzq/Ed8rLlHr0aTlEbAHydVA9HFNbm
 dSCf7zNvA48UNcmmNsV9P1JcKuupGpmLg71srxl4Gem6LJdrn+WRJkYb7Q7uX+9N
 nSjgEwderjlPNMN+y5oNRpE7zzDhWo3VoiJUaIOHEF6ylUFsK+bAgm34pag==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hr6bngj89-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 16:35:24 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-351788121cfso3781937eec.0
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 08:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793810122; x=1794414922;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Q4L0V+yT/wFuBA/rLzoe/ZyVgXiV5kNqQzvSMldagDE=;
 b=IWm4ziAA977fpLQ6d87jJtwtg8TAL8xjbMbbZJqC06XAYeT8bIZ4XlB0KrHn5V/FHi
 64TMTkMPiQ7N+2HaDQlqOCv6u6xZRqBUvdnBqcAwjpG15Uzh5PCxkb7QUN1Rrb/h0Gat
 YLL7zVYYRcET5X9AGxr5m9Z//4mJDnY5kqmRHGfjSe8AmG8gyOAN3L2f/qtghrPPDLuZ
 4zvhXpnFVepKUjZNZMa1FET1tfNe0l91kEkVOcQ6DyAy9v/qQQ5HEQXYRHQGb2Wo5SOl
 +HkH5+an4irFDfjRxV7nXlVZdvf6OnH82NC69DAUtYU97PKm5jEI+1eLmcPACCannPDO
 cCdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793810122; x=1794414922;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Q4L0V+yT/wFuBA/rLzoe/ZyVgXiV5kNqQzvSMldagDE=;
 b=ADu35GMtpvTrcabtT2f8JCXY8sULk0c7qB6bOq7RdwWrd8V/As4xGS7YPWc/vGGXhh
 yRlGgyUcHOggHHcPRTStX9hWEHSCUl5puydYPk+mJ2VwzEqALiYzdoeEodqtF7peWeVU
 pGhhfTwASF+iSoaKqH+p5AJtu3xMJiUfyz8l9vWtjDv3bYcexLxUAlCjoGx5Qj7rL+6F
 +YFsUzNSKjtz75MAAI2bz5VXztv+5cSGxdO67D347yqj+0tqCzTsu6CvKZiK5piKFmRS
 LS7NYkQjoKSQ/FbA3Qz4q3WNIuWVrVgOvUq8+FyYjtPxMt9aKO6hGVGJz3VYypkSUzZg
 m9EA==
X-Forwarded-Encrypted: i=1;
 AKwUvByOoirJiilP1sPIse2jR1DrMLK7LFKY+XvcXGzTBvdC1ct4Ewau4COaOadu1nETDJ3EHCCKoBY=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/P4vV5DxSRaa3W6QXCkCti3VRF43CsMeMgWEN/f5ZgGEIHtNGT
 Gz1pS3y551ARacgmApcOKUHufkOj87SNNcD2lBEipPnlEA9i/i1TEQH0k+ukh99j45gqXyHViPO
 ACG/cnuSnL6T6t4gq9Rsz/lrrtdoGTGM3SYJVlUCS0aK5jXuSoaz9/jZ3vBHCQuPbISDI7t0=
X-Gm-Gg: AYBFou3DwuzRqN1R9QnN3UJ2xuiBZM/ZmjshXl9dpf7LIP6JBA4ki6txxTLaO3Wn+2j
 USvgjVUhWL40anYVtBxTXG6Qni/IvVovUS3Y1N2K71CgbCS/ZX8EbSR9JY2Xe//f0cFR/SVI95k
 tcfIvwQ8StIlExiV8wRPdtjshgIhzueowpy3p4MOqvn+6zMSCZzyF49+P8bUg6DSPF/LdwzSmSa
 FTxVJo0zBrQkQOOMpwi8MKXgK5A3NIuL6r/gLprBOjoR+bECqfY5KTbIPaPJ3bsVbmdFG3Bcc7G
 83Uaeb12J7oDFnTrTzPcAmP+vWe+cl5fvAmrnl3Or7XgEGn98BudYoYj+B7JumvVLc3SxjQ50wO
 2A4+hlvt2fZvJzfQGFaT1UbjWGWAFu/Tg7oYHJlTXWr/wrLCR1AUAS+BBl0ytnIIka9QirpsSsk
 wDQxKVgZVdIua1WAGhXs1rG22u5BdhmqhWPYCY3gze6AkaGfqhO0uWy6cedJQhbWcI
X-Received: by 2002:a05:7300:6016:b0:35d:f7f4:bc1c with SMTP id
 5a478bee46e88-36a4235facemr22202192eec.6.1793810121360; 
 Wed, 04 Nov 2026 08:35:21 -0800 (PST)
X-Received: by 2002:a05:7300:6016:b0:35d:f7f4:bc1c with SMTP id
 5a478bee46e88-36a4235facemr22202151eec.6.1793810120427; 
 Wed, 04 Nov 2026 08:35:20 -0800 (PST)
Received: from hu-sdhami-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36db94376b1sm1046879eec.10.2026.11.04.08.35.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 08:35:19 -0800 (PST)
From: Sumit Singh Dhami <sumit.dhami@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, lukma@nabladev.com,
 sjg@chromium.org, Michael.Srba@seznam.cz,
 senthilkumar.l@oss.qualcomm.com, sumit.dhami@oss.qualcomm.com,
 manivannan.sadhasivam@oss.qualcomm.com, nathbappai@gmail.com,
 balaji.selvanathan@oss.qualcomm.com, petr.hodina@protonmail.com,
 marek.vasut+renesas@mailbox.org, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v1 7/9] arm: mach-snapdragon: add QCS6490 PCIe1 power/reset
 sequencing
Date: Wed,  4 Nov 2026 22:03:56 +0530
Message-ID: <20261104163408.1250410-8-sumit.dhami@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261104163408.1250410-1-sumit.dhami@oss.qualcomm.com>
References: <20261104163408.1250410-1-sumit.dhami@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA2NiBTYWx0ZWRfXyXrARoDbeHCj
 AxMyhVYBPG8ov5j2Uokhob7USbisRDlWvbFG9DxpIgJSVUvC2FI7TpoNjEgGe1Csc5xuFTNigHw
 MzDeFR22jhzuCGzGA0E1uLLNpubtOXm4GZdcrgL2m306rUlbxcl4LSnMZbFufwFFnzkP7lXiynM
 Pt/J9ugafhCYGxGKG4uTrV6ta4rAYZ3y+znTZ5IXkB5ZNgajMgQicTDSp8oifQxnGeluy2unROM
 EPNhEAYuns6zpv98SVPAyJ933gZKaRCxMI/HyocP5WxqcDol2aws/uwvqL6eQv5/LOG/9QTwLsc
 LB3ul7F7KXvBbc56fbywKu0yNSGLX6se/AKXMCgdJtDrM/jc5i70cEydVrZPGlVsrhVFz6arIoo
 OGLjDmUnRRNj+gP+Lnqdtu+g9SH8aG6jTC8TBb2AU5n51OOAa3Ih3FDU3KLU3FrTV0bPEUasd8S
 5fft+SqTywGsZRpfx1A==
X-Authority-Analysis: v=2.4 cv=KLLPn1Fo c=1 sm=1 tr=0 ts=6aeb5ecc cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=rf3vRHtkVPbNZXy0ZyEA:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: 9lXytD8o1wRq-VbOCVYkvGrPqIlUMEf4
X-Proofpoint-GUID: 9lXytD8o1wRq-VbOCVYkvGrPqIlUMEf4
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA2NiBTYWx0ZWRfX+EfjuxtJ84um
 DjH0SdLmZplbowIt1F9ySE0v0Ya8dZJMlovjCe0kt+oaUsjbg8+gjxr7Oykp4kiTNwQOQCFZTW0
 DV6zL4w4ZK4enopQ6HGSvm7Ofv42HUg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_05,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 clxscore=1015 phishscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611040066
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Senthilkumar <senthilkumar.l@oss.qualcomm.com>

The QPS615 PCIe switch and downstream Renesas uPD720201 xHCI
controller on QCS6490/RB3 Gen2 need their reset and power-enable
lines sequenced before PCIe enumeration. A static DT gpio-hog only
drives a fixed level once at probe, so it cannot re-assert again on a
warm reboot while the PMIC rails stay powered.

Add a qcom_board_init() override that drives these reset/power-enable
GPIOs directly via the DM GPIO API, issuing a real
assert-hold-deassert pulse on every boot.

Gate the override behind the CONFIG_QCS6490_PCIE_INIT option.

Signed-off-by: Senthilkumar <senthilkumar.l@oss.qualcomm.com>
Signed-off-by: Sumit Singh Dhami <sumit.dhami@oss.qualcomm.com>
---
 arch/arm/mach-snapdragon/Kconfig             |   9 +
 arch/arm/mach-snapdragon/Makefile            |   1 +
 arch/arm/mach-snapdragon/qcs6490_pcie_init.c | 178 +++++++++++++++++++
 3 files changed, 188 insertions(+)
 create mode 100644 arch/arm/mach-snapdragon/qcs6490_pcie_init.c

diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdragon/Kconfig
index 2c182c7b974..a50e13efa6a 100644
--- a/arch/arm/mach-snapdragon/Kconfig
+++ b/arch/arm/mach-snapdragon/Kconfig
@@ -59,6 +59,15 @@ config QCOM_GENERATE_MBN
 	  New platforms can be added to tools/qcom/mkmbn/mkmbn.py if they aren't already
 	  supported.
 
+config QCS6490_PCIE_INIT
+       bool "QCS6490 RB3 Gen2 PCIe1 power/reset sequencing"
+       depends on DM_GPIO
+       help
+         Drive the PCIe1 downstream power-enable and reset GPIOs for the
+         QPS615 PCIe switch and Renesas uPD720201 xHCI controller on
+         QCS6490/RB3 Gen2 during board init. This overrides the weak
+         qcom_board_init() in QCS6490.
+
 choice
 	prompt "Qualcomm boot0.h workaround"
 	optional
diff --git a/arch/arm/mach-snapdragon/Makefile b/arch/arm/mach-snapdragon/Makefile
index 2360b7c658e..b3fa46548ae 100644
--- a/arch/arm/mach-snapdragon/Makefile
+++ b/arch/arm/mach-snapdragon/Makefile
@@ -9,6 +9,7 @@ ifeq ($(CONFIG_SPL_BUILD),y)
 obj-y += board_spl.o
 else
 obj-y += board.o
+obj-$(CONFIG_QCS6490_PCIE_INIT) += qcs6490_pcie_init.o
 obj-$(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) += capsule_update.o
 endif
 
diff --git a/arch/arm/mach-snapdragon/qcs6490_pcie_init.c b/arch/arm/mach-snapdragon/qcs6490_pcie_init.c
new file mode 100644
index 00000000000..e2559255eef
--- /dev/null
+++ b/arch/arm/mach-snapdragon/qcs6490_pcie_init.c
@@ -0,0 +1,178 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * QCS6490 / RB3 Gen2 PCIe power/reset initialization.
+ *
+ * Drives the PCIe1 (RC1) downstream power-enable and reset lines for the
+ * QPS615 PCIe switch and the Renesas uPD720201 xHCI controller directly
+ * via the DM GPIO API, issuing a real assert -> hold -> deassert pulse
+ * on every boot (see commit message for why a DT gpio-hog is not enough).
+ *
+ * Hardware topology (pcie1, RC1, x2 lanes):
+ *   Kodiak PCIe RC1 -> QPS615 PCIe switch -> Renesas uPD720201 xHCI
+ *
+ * Power/reset lines:
+ *   QPS615 switch:
+ *     vdd_ntn_0p9/vdd_ntn_1p8 - regulator-fixed nodes, self-enabled via DT
+ *     resx                    - PM8350C GPIO 1, active-low reset
+ *
+ *   Renesas uPD720201 xHCI (downstream of the switch):
+ *     vreg_pcie0_3p3  - PM7250B GPIO 1 output-high -> 3.3V supply enable
+ *     vreg_pcie0_1p05 - PM7250B GPIO 4 output-high -> 1.05V supply enable
+ *     hub_rst         - PM8350C GPIO 4, active-low reset
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. All rights reserved.
+ */
+
+#include <asm/gpio.h>
+#include <dm.h>
+#include <dm/uclass.h>
+#include <linux/delay.h>
+#include <log.h>
+
+/*
+ * PM8350C/PM7250B PMIC GPIO numbers used here are 1-based in the DT; the
+ * DM GPIO offset within the qcom_spmi_pmic_gpio device is 0-based.
+ */
+#define PM8350C_RESX_OFFSET		0	/* gpio1: QPS615 resx */
+#define PM8350C_HUB_RST_OFFSET		3	/* gpio4: Renesas hub reset */
+#define PM7250B_PCIE0_3P3_OFFSET	0	/* gpio1: 3.3V enable */
+#define PM7250B_PCIE0_1P05_OFFSET	3	/* gpio4: 1.05V enable */
+
+/* Settle delays, matching the fixed regulators' own ramp delays */
+#define PCIE0_3P3_RAMP_US		4300
+#define PCIE0_1P05_RAMP_US		10000
+#define RESET_HOLD_MS			15	/* reset-low hold through rail ramp */
+#define PCIE_POWER_SETTLE_MS		15	/* margin after resets deasserted */
+
+/**
+ * pmic_gpio_get_desc() - Build a gpio_desc for a PMIC GPIO offset and request it
+ *
+ * @gpio_dev:	PMIC GPIO uclass device (e.g. resolved via pmic_gpio_uclass_get())
+ * @offset:	0-based GPIO offset within @gpio_dev
+ * @label:	descriptive label for the request
+ * @desc:	returned descriptor
+ *
+ * Return: 0 on success, negative on error
+ */
+static int pmic_gpio_get_desc(struct udevice *gpio_dev, uint offset,
+			      const char *label, struct gpio_desc *desc)
+{
+	desc->dev = gpio_dev;
+	desc->offset = offset;
+	desc->flags = 0;
+
+	return dm_gpio_request(desc, label);
+}
+
+/**
+ * pmic_gpio_drive() - Configure a PMIC GPIO as output and drive it high/low
+ */
+static int pmic_gpio_drive(struct gpio_desc *desc, int value)
+{
+	ulong flags = GPIOD_IS_OUT | (value ? GPIOD_IS_OUT_ACTIVE : 0);
+	int ret;
+
+	ret = dm_gpio_set_dir_flags(desc, flags);
+	if (ret)
+		return ret;
+
+	return dm_gpio_set_value(desc, value);
+}
+
+/**
+ * pmic_gpio_uclass_get() - Find a PMIC GPIO controller by its DT compatible
+ *
+ * pm8350c_gpios/pm7250b_gpios are DT phandle labels, not U-Boot device
+ * names (the device name comes from the DT node name, e.g. "gpio@8800"),
+ * so uclass_get_device_by_name() cannot find them. Look up by compatible
+ * string instead, which is unique per PMIC on this board.
+ */
+static int pmic_gpio_uclass_get(const char *compat, struct udevice **devp)
+{
+	ofnode node;
+
+	node = ofnode_by_compatible(ofnode_null(), compat);
+	if (!ofnode_valid(node))
+		return -ENODEV;
+
+	return uclass_get_device_by_ofnode(UCLASS_GPIO, node, devp);
+}
+
+/**
+ * qcs6490_pcie_power_init() - Sequence PCIe1 downstream power and resets
+ *
+ * Assert both resets low first, enable the Renesas power rails, hold the
+ * resets through the rail ramp-up + settle time, then deassert both.
+ * Runs unconditionally on every boot (cold or warm).
+ *
+ * Return: 0 on success (non-fatal if a PMIC GPIO bus is not found)
+ */
+static int qcs6490_pcie_power_init(void)
+{
+	struct udevice *pm8350c_gpio, *pm7250b_gpio;
+	struct gpio_desc resx, hub_rst, pcie0_3p3, pcie0_1p05;
+	int ret;
+
+	ret = pmic_gpio_uclass_get("qcom,pm8350c-gpio", &pm8350c_gpio);
+	if (ret) {
+		log_warning("pm8350c_gpios not found (%d), skipping PCIe power init\n",
+			    ret);
+		return 0;	/* non-fatal */
+	}
+
+	ret = pmic_gpio_uclass_get("qcom,pm7250b-gpio", &pm7250b_gpio);
+	if (ret) {
+		log_warning("pm7250b_gpios not found (%d), skipping PCIe power init\n",
+			    ret);
+		return 0;	/* non-fatal */
+	}
+
+	if (pmic_gpio_get_desc(pm8350c_gpio, PM8350C_RESX_OFFSET,
+			       "qps615-resx", &resx) ||
+	    pmic_gpio_get_desc(pm8350c_gpio, PM8350C_HUB_RST_OFFSET,
+			       "renesas-hub-reset", &hub_rst) ||
+	    pmic_gpio_get_desc(pm7250b_gpio, PM7250B_PCIE0_3P3_OFFSET,
+			       "vreg-pcie0-3p3-en", &pcie0_3p3) ||
+	    pmic_gpio_get_desc(pm7250b_gpio, PM7250B_PCIE0_1P05_OFFSET,
+			       "vreg-pcie0-1p05-en", &pcie0_1p05)) {
+		log_warning("failed to request PCIe power/reset GPIOs\n");
+		return 0;	/* non-fatal */
+	}
+
+	/* Assert both resets low before touching power rails */
+	pmic_gpio_drive(&resx, 0);
+	pmic_gpio_drive(&hub_rst, 0);
+
+	/* Renesas xHCI 3.3V */
+	pmic_gpio_drive(&pcie0_3p3, 1);
+	udelay(PCIE0_3P3_RAMP_US);
+
+	/* Renesas xHCI 1.05V */
+	pmic_gpio_drive(&pcie0_1p05, 1);
+	udelay(PCIE0_1P05_RAMP_US);
+
+	/* Hold resets asserted through the rail ramp-up */
+	mdelay(RESET_HOLD_MS);
+
+	/* Deassert both resets (active-low -> drive high) */
+	pmic_gpio_drive(&resx, 1);
+	pmic_gpio_drive(&hub_rst, 1);
+
+	mdelay(PCIE_POWER_SETTLE_MS);
+
+	return 0;
+}
+
+/**
+ * qcom_board_init() - QCS6490 / RB3 Gen2 board-specific initialization
+ *
+ * Overrides the empty __weak qcom_board_init() in mach-snapdragon/board.c.
+ * Sequences PCIe1 downstream power/reset so RC1 enumeration works reliably
+ * on both cold boot and warm reboot.
+ */
+void qcom_board_init(void)
+{
+	if (ofnode_device_is_compatible(ofnode_root(), "qcom,qcm6490") ||
+	    ofnode_device_is_compatible(ofnode_root(), "qcom,qcs6490"))
+		qcs6490_pcie_power_init();
+}
-- 
2.55.0

