Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60228606A32E
	for <u-boot@archiver.kernel.org>; Thu,  5 Nov 2026 09:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=se57COp/;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=igqy0WZL;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bm7ndlQV
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 357BF40802;
	Thu,  5 Nov 2026 09:58:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fXjowzbfTOhl; Thu,  5 Nov 2026 09:58:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 81E1440825
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793872734;
	b=ted9ZZtdFIPrSYZpD5oTq3v2NXKA74xpkLUEsLp4yp8RibJk1WM631gu/EAgOLiM5GVS
	 vJQE5rBDxiF/MQIeQsrm5p59uaN7X0rXSW5Yr4ebB/RKuwgw69FPSzkTbfGyy0Z6k3TqR
	 FfZaSu7crsUNUzmUOlt3LPkKJ7MVNc1dXbbwnXGZ67yucchzB640/tK9AYOyNW0t1ATKz
	 /PnnfLDOaABBrSnj0eCiwLCkPw8sDh71qfDxVxgw0MhsX5OgMi4dNOaCfEhczTe5Arq7x
	 RDDDcYByNYBVJxp+YX4v5eCroGeOQM5uiJzCZ05gNvn5oVdv20IUdv+9dNIMelAKndg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793872734;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=pg44fAMgyc6OM5FE+F2B/JCSI3jODQj00eqM5anz4IA=;
	b=SxYUvFVS692fFeB+DiDUc2r646gfOjrvCuIw2eDlOO9yOj21Atm20tbbxdJ/KiFdHiIO
	 XqwbAJlUCAt9evztGqCBSlidFUZGOzujoTv+pNhyGLFtyUaEf58VEik8SKiV6KOvtG37J
	 y+qHtoz8AzLpPt0iZJmfBZ9SF6tji3DG/nG+dsUT+XXfeCHKo62BYgHrSU9NGPdTrNS7h
	 WntCPYq0sgwsqAmDwnAdWkYHfx0r/UMFyn+qysU5g12KCYQ9qc8E+r8CQi9XP7gv8wUhl
	 LghfbPaK4DXB0p3OV98ReOmAt29bAg3qBkG0AmcHOnbsxPFI/zZAlqfr+kE7Y11mh6Q==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793872734;
	bh=pg44fAMgyc6OM5FE+F2B/JCSI3jODQj00eqM5anz4IA=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=se57COp/3kHtUCLVjR4NrXPHMqeGHRUC6n6WFKL1zKPsMkkDQ5zQ1gn4G5480mHy4
	 cxZ+Q14BDK2gnGF780J/bHamB3k3nfgNPZWuPteHjkyidvLdIecmsTYx+A3UBkDQA5
	 3OkDdfS/9b/tNFPABtlOd3NQDH11TVIZLjCy4y/sysYap6MImNBpgGeQiMU8QIpmXG
	 DSoXEtC+pQJFP5dIGYTpHmrZA6fC0JI5DbqRo1C4e50svyJj+iT+68jbPVQvdbWiw9
	 cjv8Y7LpW1/8QU61NdDI3JRaeayF2iwvVpCjRVbuCc7hgzZQV7dHx09aRy2pBJlFv5
	 kfYh0ptU6qIpg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 81E1440825;
	Thu,  5 Nov 2026 09:58:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 287C9D3A
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 09:58:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 216E0400F9
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 09:58:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id P8LbJgEcxQdr for <u-boot@lists.u-boot-project.org>;
 Thu,  5 Nov 2026 09:58:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 459F14008E
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=badhrinath.s@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=igqy0WZL; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=bm7ndlQV
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 459F14008E
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 09:58:51 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A59tcEG1028283
 for <u-boot@lists.u-boot-project.org>; Thu, 5 Nov 2026 09:58:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=pg44fAMgyc6
 OM5FE+F2B/JCSI3jODQj00eqM5anz4IA=; b=igqy0WZLPuBYtrm1LEugOSYdN6l
 mOvT+VuxLNF+aO+DtDr/I9/iV7WtJe0jQY4pu9w075moT/XiCaK1j/jqRW9GDOgQ
 RZicGjKy4nhYSV5tAYWtNVyrykSuKGUcH2igihEwtzcVV2FKqrP3mIv1KZVUzL7J
 voHAsbpmkcXx1w3swD300VwwrGFE30WAm0o6e1ukUXT8sVKwjlIy+6HULJEzaYrR
 QsBs3+e3vWwaCmwjHhyd2rG2ozKYWg78ZOJva4AUOlH3hjhIIQ7gMUohh1+j5yTA
 N7i3YnrPlAHdLDCMP/gUW4cKpb8htpJhu7TQv7LKHRMWEo6+Xl2rkBnITFw==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrkaq95jp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 05 Nov 2026 09:58:50 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-1ab289bb41eso622342c88.1
 for <u-boot@lists.u-boot-project.org>; Thu, 05 Nov 2026 01:58:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793872730; x=1794477530;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=pg44fAMgyc6OM5FE+F2B/JCSI3jODQj00eqM5anz4IA=;
 b=bm7ndlQVxeUWVorZwjjyWiWtBKZkRyZ1PcJ6FvS0biv+0HUK5MEKsli6cVCvV5HM52
 gSwhQRNhbGgMCdSMueZIvgpaHCLg1kIcTHo4wieTLvP3tPpk3T1m0QX4uUYlMI3UQKbG
 14s8eBj36i2VT+Hco3xXXdj0hUiz5WoED4AonfHkqBhIurlhq9rtcDSIfkNH7z+JihTg
 rpO/Hob63cZKI9nQae+1jJfRavfb/fKj9a2ZaeQIex9i7pyLCmHqCYm9hwBt3TUoHrto
 fEbNKogqenPdAR0FYuS/LXelDGVRG+WhIHnh1P05Q2fV/ZpQX/EX9W3uSRtGcRr1YIgF
 qlBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793872730; x=1794477530;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=pg44fAMgyc6OM5FE+F2B/JCSI3jODQj00eqM5anz4IA=;
 b=HiT90YtKquZ3OlR1q7w13UST7j6CTzVvj+zkrMHGI5a/P8wD6Qf3fDa8uStuHeIH5Y
 6nsVjXrV1BFE6m9age6aUuBXT2/hL2PTOl86FI/tdp6lhSkXq2ZlV3fFZDY5+2+DgP5C
 prZsdVnSYWMkKQbERlSvegL9etHt4vlXnP911LowvOt/pz0F/WOB9WuKN92FLbAjOGMM
 vCFABMWws9FLUUADc0nFphC8rvbREt+BwM9GUo/pvgkfza2tJOJTZVxHzYhERxFUkNIB
 pTNMHCL9ke9z1E/IsNn3yy3VHH2bqinsLcwCk7RrNk36VryZE4PAW07q60qBdaIubjJd
 Tv1g==
X-Forwarded-Encrypted: i=1;
 AKwUvByKdU+KNeestsBUzm9/xZaGhsGEx+tpaHfMw7dBnQQeMHIRW5nP1w71SjmmoqT7ZKBDodnbdHk=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9sNeCgWK+8oe7doqw/tkkvLw7LXohPy/6gnsSpYd/OsmJeUSNe
 U1R0G1Mh+xASEqD0m/gaGWR7NvsIxdB7pN7bH04Q6Zw6L37chnRrPUQeL7S6ExV5Mj1aWl0aQRE
 Am3lafj1bK+rVTxVjWdgeQUGZVjNuJ2GQ9DR1quud7Uk5rSAA4qkTkDXr5GVHdHbFb3CRsYw=
X-Gm-Gg: AYBFou28yHSye4qBwaCvJQuZ04Sv5YS269KhzGhnndkODhe2zv564O3JWmfbviPBczu
 tw5dX+gB8WgVHYJ2WEx71Um2Uxr/BVseZGZd6Fj0o1WgPHQ5X/2gSCvSXa3XUqBpICePs48/4VG
 +RIyu8VxjbDb5O90e+xPVdT8syYfi159UpSyM5dmjpn4ZngQ8x6yJVq9Dge1i6BaL09nU8rIXud
 daXK7IcPDdtAH8hOCGTxk33eQi3fofY2cZzngooSpfboou7Z8vVmf422HoAHlYJcbecmaM0kFxZ
 ae3JcYrwVOAuTMX2kL7gg5eSdNnA6OLYMVjwrVdxbFwj20RmKtEXKnot78KY/qT8cZXH86Jdc7b
 X7FSQ8OylPWmVE5f+PHrIezULg1QtxBhCXVdFnCevfWPw5w07JTxYBw/2WqmZds7HIwYuqJmBtQ
 GpVnVXkORdOIN7ggCcCfLUl8S77Y1K7Oggq8XBTVIGAI0xdHQPnnrhfIaSZeJ1gY21/J/zaQ==
X-Received: by 2002:a05:701b:2803:b0:1b2:46ee:4cba with SMTP id
 a92af1059eb24-1b24f4d0241mr2338142c88.18.1793872729526; 
 Thu, 05 Nov 2026 01:58:49 -0800 (PST)
X-Received: by 2002:a05:701b:2803:b0:1b2:46ee:4cba with SMTP id
 a92af1059eb24-1b24f4d0241mr2338117c88.18.1793872728965; 
 Thu, 05 Nov 2026 01:58:48 -0800 (PST)
Received: from hu-badhrina-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b245ac2f44sm15844487c88.0.2026.11.05.01.58.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 01:58:48 -0800 (PST)
From: Badhrinath S <badhrinath.s@oss.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com, peng.fan@nxp.com,
 jh80.chung@samsung.com, tanmay.kathpalia@altera.com,
 lukma@nabladev.com, Michael.Srba@seznam.cz,
 badhrinath.s@oss.qualcomm.com, balaji.selvanathan@oss.qualcomm.com,
 nathbappai@gmail.com, nikroks@mainlining.org, jbx6244@gmail.com,
 xerikasxx@gmail.com, u-boot-qcom@groups.io, u-boot@lists.u-boot-project.org
Subject: [PATCH v8 3/3] configs: Add defconfig for ipq9650 RDP488
Date: Thu,  5 Nov 2026 15:28:21 +0530
Message-Id: <20261105095821.3009544-4-badhrinath.s@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261105095821.3009544-1-badhrinath.s@oss.qualcomm.com>
References: <20261105095821.3009544-1-badhrinath.s@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: lJSg_FuKuCJDp738eTAif__biIfAC781
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDAzOSBTYWx0ZWRfXyqyLIdrVGJ8r
 vztBRJ7juRSCnTXt0Xo2syMPmtkVi522hxXqee3NL0HzaizXhGnEZpIqZ+FiLVuEpGHIVsrLj8W
 EoLQ1Qblg/52PXJ0DNcp94LuxXjmX7c=
X-Proofpoint-ORIG-GUID: lJSg_FuKuCJDp738eTAif__biIfAC781
X-Authority-Analysis: v=2.4 cv=OZoNnRTY c=1 sm=1 tr=0 ts=6aec535a cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=UuI9o3pZbsgdCeA7RPUA:9 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDAzOSBTYWx0ZWRfX6Do66hGhES+q
 KApret7bI76lGnFaZKGLzxoH+hDVVR0nka9nGIs3q/pMwwh3iaD1elL0T9ZLkPOartKm1XTcQwi
 TbQ/1ZLir55B2RtmP5QjfVkp1DGr8zn2fE5N7TeMmiOPZ7jNfUS2i6jATfKz5FWNuyBzYPR8v2Y
 oX801MC/msQ47xw6ll+jHSO9X3pBdjmVsIrlfR/yQw2jGGGQRlDT2Aw+W8UfMPfzJFNYfq5bq1y
 plA3+08ljxauXKudkl2lvNtkK78FAsJCYJGlBlsqdEO8dtrUJe1JHJdjAlm1RP8Cl3GdbBYo5NL
 3Hgp4PIX/ayfNLRgKbF9LL3R4VdoA1dVCMuv1AiZUWykmq+dmov65jxWJ4q3TB0m64YaPJ6IK0j
 LrqjCELav/p+Z2U6pr4OmSgmUmGt4T8OK/dpkEjgTJnFxCgMSjuLtrVaQLpwEO1OY2GbwPADRwI
 P6OYuuOnxasOY8mhXdw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611050039
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UPPERCASE_50_75,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add default configuration for the IPQ9650 RDP488 board with eMMC boot
support.

Signed-off-by: Badhrinath S <badhrinath.s@oss.qualcomm.com>
---
 configs/qcom_ipq.config            | 36 ++++++++++++++++++++++++++++++
 configs/qcom_ipq9650_mmc_defconfig | 18 +++++++++++++++
 2 files changed, 54 insertions(+)
 create mode 100644 configs/qcom_ipq.config
 create mode 100644 configs/qcom_ipq9650_mmc_defconfig

diff --git a/configs/qcom_ipq.config b/configs/qcom_ipq.config
new file mode 100644
index 000000000000..e649b07cdb2b
--- /dev/null
+++ b/configs/qcom_ipq.config
@@ -0,0 +1,36 @@
+CONFIG_ARM=y
+CONFIG_SKIP_LOWLEVEL_INIT=y
+CONFIG_POSITION_INDEPENDENT=y
+CONFIG_ARCH_SNAPDRAGON=y
+CONFIG_REMAKE_ELF=y
+# CONFIG_EFI_LOADER is not set
+CONFIG_FIT=y
+CONFIG_FIT_VERBOSE=y
+# CONFIG_BOOTSTD is not set
+CONFIG_USE_PREBOOT=y
+# CONFIG_DISPLAY_CPUINFO is not set
+CONFIG_DISPLAY_BOARDINFO_LATE=y
+CONFIG_HUSH_PARSER=y
+CONFIG_CMD_PART=y
+CONFIG_OF_LIVE=y
+CONFIG_CLK=y
+CONFIG_MSM_GPIO=y
+# CONFIG_I2C is not set
+# CONFIG_INPUT is not set
+CONFIG_MISC=y
+CONFIG_QCOM_GENI=y
+CONFIG_MTD=y
+CONFIG_DM_MDIO=y
+CONFIG_DM_ETH_PHY=y
+CONFIG_DWC_ETH_QOS=y
+CONFIG_DWC_ETH_QOS_QCOM=y
+CONFIG_RGMII=y
+CONFIG_PHY=y
+CONFIG_PHY_QCOM_QMP_UFS=y
+CONFIG_PHY_QCOM_QUSB2=y
+CONFIG_PINCTRL=y
+CONFIG_PINCONF=y
+CONFIG_MSM_SERIAL=y
+CONFIG_MSM_GENI_SERIAL=y
+CONFIG_SOC_QCOM=y
+
diff --git a/configs/qcom_ipq9650_mmc_defconfig b/configs/qcom_ipq9650_mmc_defconfig
new file mode 100644
index 000000000000..624d10e83c5b
--- /dev/null
+++ b/configs/qcom_ipq9650_mmc_defconfig
@@ -0,0 +1,18 @@
+#include "qcom_ipq.config"
+CONFIG_SYS_INIT_SP_BSS_OFFSET=0x180000
+CONFIG_TEXT_BASE=0x80280000
+CONFIG_NR_DRAM_BANKS=24
+CONFIG_ENV_SIZE=0x40000
+CONFIG_ENV_OFFSET=0
+CONFIG_DEFAULT_DEVICE_TREE="qcom/ipq9650-rdp488"
+CONFIG_SYS_LOAD_ADDR=0x90000000
+CONFIG_SYS_PBSIZE=1024
+CONFIG_CLK_QCOM_IPQ9650=y
+CONFIG_CMD_MMC=y
+CONFIG_ENV_IS_IN_MMC=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_ADMA=y
+CONFIG_MMC_SDHCI_MSM=y
+CONFIG_PINCTRL_QCOM_IPQ9650=y
+CONFIG_SYS_MALLOC_LEN=0xC0000
+
-- 
2.34.1

