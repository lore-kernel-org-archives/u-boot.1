Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20D6606A33E
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 16:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=CVZlrhHU;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dv/DZkyr;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TyCeUwih
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B8DBC80874;
	Wed,  4 Nov 2026 16:38:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id O9vNrxWMWeZv; Wed,  4 Nov 2026 16:38:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 02DC480897
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793810328;
	b=f80Q5qomOh4SRfJzIaAf3gSOshVfinil4Y5ZW9L4M4qkEBNfPytPmqHAWA3QGdGFAQdL
	 P9ex7UTp2E1jtpuMOmnCy11f201LbsLLZnDk6H+8DoYkecSqLo7nHyY83nQ/wSiTv2NjN
	 jr8+MMz5+CwN+6dNgrGw2wDzoCmHDTje+GhsCkq4qkCa+Q8YZ/X71Vmeucc8laCmg2b2k
	 dqyZaMB2WgUDIMqxV0XHayrGsUuiNX1l4UhUXhHUF/wXr0efc+IsPKANnhIRxwJ14euth
	 SbE7KwQDhR+e0dQtM8TfikQCQHaPraDRNczbgP2C1kcRB5wHhF7VKao0kSh7ya2DFXQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793810328;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=p8kbWxlrO7FbYjhfotx/8w09TXbF0sm3JGNso2x6Kec=;
	b=Tsd/4bIuYAco3qhQGKnaCG3DoyG/mNcxJOmVEqxDJmS0/aC/W/nBP1D1iyP+kuEON6bg
	 EdA/AL0wF9BIa5tBbll8k7yIGnAyS/C8W3QqpaODkxgVSwxjUR8eKaAE7yHKfInxfpRr2
	 8/dCENAeLjBgaapc3wtMJSd15wVYCxHbTMW/lAorhU6LGdRgZ6WiyYXSL71AzAsP7vczs
	 MrmNwJ5TRpr9Y0ynpZH9iTbJEJklceIiU1rTP/scbaf2LC/X1AL3I/0Lg2BizDdZ3BqiB
	 j4bGXJ+V7brgUoqVN7hgSrs1BfY5eVuM5HIY61iLLweWmScIiQmq2kwDO9UH/j2+wcg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793810328;
	bh=p8kbWxlrO7FbYjhfotx/8w09TXbF0sm3JGNso2x6Kec=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=CVZlrhHUqKlUUipZg5LbKmxQpzaXMXTDom8Li8DgZYdwtY/relUUCNbH16lGIicZQ
	 T5lt93V6KAs+SGTJOu8d39+jPqNlcKTu4/pDgNhpBEb+fWiZ2KzsYKsDhpJr3Wzn82
	 SeGE9dGHix3SAtz/b2MsAvMvLcgWyJXkCYrlH4nRGPCvIfmSNOuNtgGj6sdQ8/PxmX
	 xGt4IJohX3Wo4Vruz8sKpR7eVaHv16jnJABGaL3horv5d5uY3PDRwDBfRKhjcEaNui
	 gKAMAnEadxW2xq3fafuznwYN52xlvNCm7+lZV+GlVFGWvT21nSt8givDbVNnSREzyw
	 q6YiUqnFKYYGA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 02DC480897;
	Wed,  4 Nov 2026 16:38:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id CD8CA165
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 16:38:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B413840062
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 16:38:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Es52BTSrsy2S for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 16:38:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 222D540068
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=sumit.dhami@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=dv/DZkyr; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=TyCeUwih
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 222D540068
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 16:38:44 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A4FisRO2210738
 for <u-boot@lists.u-boot-project.org>; Wed, 4 Nov 2026 16:38:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=p8kbWxlrO7FbYjhfotx/8w09TXbF0sm3JGN
 so2x6Kec=; b=dv/DZkyrl8GrRCv6Mg29HGAAYfJEPhznf4mnmH6SO/TIvBtYIeO
 LfBbIzRL6sn1Wi1jYAt7xZqe16UWNfwCvR/6GNQXiVf/mBMG7IFegCU965qt1AYy
 K7haYIvjbSoNavqxG46VLOTZtJ7HJPxxAmI+1G+hnM6kwNBWq7Tsj+nCUWh7sHLX
 E0mqx+qEDA5HEuxqDl5Bzs7wtP7r54W1Qvhami3kX047KxbuLzMl6g1T2gb3fUNj
 c2xdqT2XWb9KIFYQ2GoFBVkI74StXdP/1lXP3mj6P6Qis3XPREw5WQJ88k+wrKLh
 QhwuvsAqcpwgDwFrpvUSAXq7chbyo4493nA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hr6bdrjr4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 16:38:44 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-30bcb065bfdso1628380eec.0
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 08:38:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793810323; x=1794415123;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=p8kbWxlrO7FbYjhfotx/8w09TXbF0sm3JGNso2x6Kec=;
 b=TyCeUwihYWIZ1JKuT0PTPoIxCDs/4CxK7h8M3bu2ztl8BvH+tmPOtgc9FUye6Fh8Z2
 bh+AGH/TOkRZ4FG8eLchtMjKj0PNksmNztwu37soatblARAvVdjqOH2BjW2lCtuoa8o/
 /G2julvaMdbzSOTO32JNmvHn7j/iG8PH6oadsN0D268S4e3V3x0xD3gxpZW3J5e1xqKJ
 b7MoHateGlpAWP2i+icLxtdq9PhbuffXbinHAwg9F+xF0MMhsAFcIUdlVNsnMZrjVK7a
 6BTtuSMg0IzymeJI0JBiSyqvjHHlyDlUT7RPAv7v2/itrPPORAJXXfqDz3jtKLi9E0tF
 /a7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793810323; x=1794415123;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=p8kbWxlrO7FbYjhfotx/8w09TXbF0sm3JGNso2x6Kec=;
 b=YWEzCffGC2nR/AaISABV3Xd8f0r4G/h0aGcY/go2LEa2RH3ONMvIeDrqZ8OZoC1iAD
 bBkh0/90S0U0RTFnwkoSZ3sRk/jqBGNiqyzS6OD1TCNy6WIsVTCWahBBWhhyGJ4zxq2T
 U4u/8y17xk/g7f4PTNS/D+VldmaSdHXulFabX554LEN+covFnbHWMe/5I8CdSYybFnA8
 HzqwHeqKVbUPMbZyDzEdzhuZ7p4WaQMhw1kWGqJqQcOYTuqoejlhS9RXvvumxW/lmz5C
 +xC8UbbFISDEzpheSvyUvnz2SAaXesjtUgW47rNSO9bDJL/ACSUwJGPSetKIWi4j9N/8
 Yb+g==
X-Forwarded-Encrypted: i=1;
 AKwUvBzYfdX18EdD/GlHcouWehqZkUFRbonzKmso2Gaoe9XvfdUNH7c6KbIFYpr15QR3g7OAtVdCXhs=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+9dGVdAoQ3MmzH5xnlylC7zjo7jqXsGJlAqCz+TusZ0v5pFBBL
 ioHAMZNsaSD+SCwB+nUQLGyYHk44KlAwVQ6X5Q9Oe7LUKn0WEvqViCgNWonQe2NDiK7tGScXZoX
 KY6C4kLWEwVu6TGzffg0CyJsI2x+Fr69ROJpa+rAHO3sWzF9/PDAt37le29w8andlPmSEPA0=
X-Gm-Gg: AYBFou0wJnWzXJG1M9oJdPnC2suFtghgq3w4snCQjxLnMA86OnKtdc5jgkPIItOib/h
 KNnK2dL9tapT2Jn49p6VMD8CnlQGv2Cah7awsHTaIqJub9pjpeXJpj9YPi3klR1J6Yofjn7qtpD
 gCH/KXvrqGx1HR5M65j4NLlrj9c5F0xFcesTaDEadWWvWyXJ6SWHYTf6NKVectmKLys8Uf/1fnZ
 0l5PrsG+paz5JrZV933ljd4iEcu+ZXkRck3vpslzsvSZppTVXUVo/5+58UyYr1DmbLnBeeps4FP
 1YqU4nWfyx9VJPPkAlqgOUA1nVyk+YBlHOLchuNvmFoiCzX9k+jt1Sd3YonzzqPx02Ysudzn3bX
 Lh9eTi77pSuUcyVfIAztj56VCXCZwOm94UkJix2tKC3eUrKwcaqxJZgDShQO4FFbZq/2+0BViW9
 r27g1C3CsRHiTXNxbZriKsa/DsEopMAhN8OyW+3G87Ah/rALPdP7nUVEWm4ulGcaBk
X-Received: by 2002:a05:693c:20d3:10b0:369:fa21:ba0b with SMTP id
 5a478bee46e88-36a42451227mr25269062eec.33.1793810323119; 
 Wed, 04 Nov 2026 08:38:43 -0800 (PST)
X-Received: by 2002:a05:693c:20d3:10b0:369:fa21:ba0b with SMTP id
 5a478bee46e88-36a42451227mr25268998eec.33.1793810322404; 
 Wed, 04 Nov 2026 08:38:42 -0800 (PST)
Received: from hu-sdhami-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36ca394c2a3sm9057759eec.20.2026.11.04.08.38.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 08:38:41 -0800 (PST)
From: Sumit Singh Dhami <sumit.dhami@oss.qualcomm.com>
To: trini@konsulko.com, alchark@flipper.net, sjg@chromium.org,
 suraj.hanumantkakade@amd.com, u-boot@lists.u-boot-project.org
Cc: Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Sumit Singh Dhami <sumit.dhami@oss.qualcomm.com>
Subject: [PATCH v1] boot: pxe: support booting PE/COFF EFI applications
Date: Wed,  4 Nov 2026 22:08:35 +0530
Message-ID: <20261104163835.1254033-1-sumit.dhami@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA2NiBTYWx0ZWRfX0gG3RqXqKarT
 yLipDaWtWWNjFvKGTkPpt9kIcGQfvctvDgQYbLrvPsYKCFEKh3Djb1L2pKuXRCFGZoj3r8TMBj6
 NoPt4Znu29bp7r3UODpk82IzYfYysSo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA2NiBTYWx0ZWRfX7Y1JUrX5vfd5
 Y8mSnL4Z6zTHTtnMdJ993EVNcXNXevL09amGMb34An4GYwdlU/sUX08E9nMra/HS7u4WCYcC6vn
 Ge/T0obmAzw4U2VJ8Zuuy54+IX8IPiDWeNXBXEIAe7zQScswAOKQ3UcXtdTiGIFmMH8e8tfJPZC
 FaqRYtfLXaXiVBNaGDv9Gva77mssVO130YpfS8Dy7XTElXmda/h5UuXHroURGYgXp/bbTdrLt/l
 Y8xBmiNnLisStYc2InFwSPXZ9NxQdMQVo6J/qY3djsZ43e8umilAM+n/BjmztAU11YJSB91n3Fw
 WiFyPqy3Jk2s3KK+37KNTm+/G3TDz6VZvzC/1tuUb7G2C5TaS1fRK1MP0mBWdycPhmJrhw4OBav
 B5rg3lRb+43v2XLRYo7Qwnh/LyDWH18VcpMfnPrJ95yaKhrY85ADKGC8fS/BCBXZvG7qhRrr9vz
 ewkpHcsLco/U3JUwnrA==
X-Proofpoint-ORIG-GUID: rX_SwEcXFlKp2GdV1boo8XyRmWVVw9kE
X-Authority-Analysis: v=2.4 cv=D4XSufRj c=1 sm=1 tr=0 ts=6aeb5f94 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=EnWGw99cw_KhmYqpXBkA:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: rX_SwEcXFlKp2GdV1boo8XyRmWVVw9kE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_05,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 adultscore=0
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

From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>

PXE assumes that a downloaded image is a Linux Image, uImage, or FIT
image and dispatches it through bootm, booti, or bootz. However, PXE
may download an EFI stub kernel or another UEFI application in PE/COFF
format. These images contain a DOS/PE header instead of the ARM64
Image magic, so genimg_get_format() reports them as invalid. The
legacy bootm/booti/bootz path then fails with "Bad Linux ARM64 Image
magic!".

Detect PE/COFF images downloaded by PXE and execute them with
efi_binary_run(). Track the downloaded image size so it can be
validated, and pass the selected device tree blob to the EFI
application.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Signed-off-by: Sumit Singh Dhami <sumit.dhami@oss.qualcomm.com>
---
 boot/pxe_utils.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/boot/pxe_utils.c b/boot/pxe_utils.c
index 8ec48a43bfa..c60429a5e12 100644
--- a/boot/pxe_utils.c
+++ b/boot/pxe_utils.c
@@ -9,6 +9,7 @@
 #include <bootflow.h>
 #include <command.h>
 #include <dm.h>
+#include <efi_loader.h>
 #include <env.h>
 #include <extension_board.h>
 #include <image.h>
@@ -536,6 +537,7 @@ int label_boot(struct pxe_context *ctx, struct pxe_label *label)
 	int zboot_argc = 3;
 	int len = 0;
 	ulong kernel_addr_r;
+	ulong kernel_size = 0;
 	void *buf;
 
 	label_print(label);
@@ -555,7 +557,8 @@ int label_boot(struct pxe_context *ctx, struct pxe_label *label)
 	}
 
 	if (get_relfile_envaddr(ctx, label->kernel, "kernel_addr_r",
-				(enum bootflow_img_t)IH_TYPE_KERNEL, NULL)
+				(enum bootflow_img_t)IH_TYPE_KERNEL,
+				&kernel_size)
 				< 0) {
 		printf("Skipping %s for failure retrieving kernel\n",
 		       label->name);
@@ -800,8 +803,21 @@ int label_boot(struct pxe_context *ctx, struct pxe_label *label)
 		bootm_argc = 4;
 	}
 
+	/* Run PE-COFF images as EFI applications */
+	if (IS_ENABLED(CONFIG_CMD_BOOTEFI) &&
+	    efi_check_pe(buf, kernel_size, NULL) == EFI_SUCCESS) {
+		void *fdt = EFI_FDT_USE_INTERNAL;
+		efi_status_t efi_ret;
+
+		log_debug("using bootefi\n");
+		if (bootm_argv[3])
+			fdt = map_sysmem(hextoul(bootm_argv[3], NULL), 0);
+
+		efi_ret = efi_binary_run(buf, kernel_size, fdt, NULL, 0);
+		if (efi_ret != EFI_SUCCESS)
+			log_err("efi_binary_run failed (ret=%lu)\n", efi_ret);
 	/* Try bootm for legacy and FIT format image */
-	if (genimg_get_format(buf) != IMAGE_FORMAT_INVALID &&
+	} else if (genimg_get_format(buf) != IMAGE_FORMAT_INVALID &&
 	    IS_ENABLED(CONFIG_CMD_BOOTM)) {
 		log_debug("using bootm\n");
 		do_bootm(ctx->cmdtp, 0, bootm_argc, bootm_argv);

base-commit: 3973f3c4d24df75ca90d7c0a9f03e5e5c9b48f32
-- 
Best regards
Sumit Singh Dhami

