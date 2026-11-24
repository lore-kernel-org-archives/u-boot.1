Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3835606A697
	for <u-boot@archiver.kernel.org>; Tue, 24 Nov 2026 16:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=AQvr4dGm;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=EjQjVGIG;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=J4B+rg66
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C0D5680BC0;
	Tue, 24 Nov 2026 16:48:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OJxDzCK7RENW; Tue, 24 Nov 2026 16:48:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7C0D480848
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795538889;
	b=ceOM0FK+AdLQKL98ZRTfyD0v2fymMb4f32eYdA0acgvHhaEbKXd8zzC2z+2lKA+SzXDU
	 ocPTofNNA67QDftmAH+GZ0WZ0Dgt8jcOAO/brlInUKjMCF3+c2Dtcj0923oPHo36NtaKu
	 394Z2pU7hqGVMx0BoIdl/4CGiVi5fQ96STim8LzonlxcNWjocny4YFT3d23jQbVCN8ySm
	 CLXpDtELcE0ZKxL1+RTC+XAXu5j/EqKi3ZcLKVgoILN8PashDzeFJQ6oCSv9fIC3YOU/w
	 69turNlYkeXGDUJD244INn8WD7d679gQ3gDxBUlujAhn47BUQNQym3OXRKWzdpQgKUA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795538889;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=DEGJL3nMTmR/sUcm6Di8sswrta5wllQiXvIrJn5Hw2s=;
	b=BUoMMkA0jSyVfvH7PIa3cOr1X0Y/5dDMKqNT1rgSlS6tljmuyOB0aMQ/9GXfhr4EJIFe
	 KOsOdISJx8VYaOhRf5EqG7mCQ48J03+4ZqZTLzNaXbjD66YpM2NrpkV5Tvmurojdi49hM
	 mmjoZxlX5PsPMgqGrnZxTJPVzZ/eJjehLfTqMjPJ4q+I7aMTHUvUKInpDVlNj9LP6UcVw
	 ONQQXafpqwOlKugcElTdOkp9WfJ9bxLfi72CZa1nB0iBkE4Hu97XRrSQr5HcEAqeLZe0h
	 DF8vDd90OyRX28i6s1bKf6EWZy3z8sAhzEkolaMiInsTqzcu+t5dasIX6w3cOjP8M3w==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795538889;
	bh=DEGJL3nMTmR/sUcm6Di8sswrta5wllQiXvIrJn5Hw2s=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AQvr4dGm30YC2hZsoIdLSoFUAg28Ctx8bBO8Le2mP1UAfyh8b5E+yXtiZA+p4KOeD
	 PMpJ1VXdu2sh8l9HXePjFAIZ2ferpp984E2takECzjLFmXFoJ1xDHxO8QEr/iVr3xn
	 /Bs25YXzdl19XfRKsx0HT4sWpbrheUYBZMbZiZ+TA9N9DVwhxmm8qmKHzMyN3p8WHM
	 Zy5fmrI77k3gOC6Z1tpXwEQ8bTbxRf7HJvAFmwGIJ1Vb7gm8nJhRikSqeCVtPiOngm
	 fPNsjJWSO+gLdPkw7mvImCs8P7c6swCkUnpT3w/G5QvQ1q4O6dPkyBDgtqumrmWe1+
	 wtChvNYFGi87A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7C0D480848;
	Tue, 24 Nov 2026 16:48:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id A90E0371
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 16:48:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9B09C4018D
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 16:48:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ngMCei1RDJkY for <u-boot@lists.u-boot-project.org>;
 Tue, 24 Nov 2026 16:48:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org A00FA400B3
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=EjQjVGIG; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=J4B+rg66
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A00FA400B3
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 16:48:04 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AOFLW7a1331868
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 16:48:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=DEGJL3nMTmR
 /sUcm6Di8sswrta5wllQiXvIrJn5Hw2s=; b=EjQjVGIGr+bb6HycQsVbHWb4JG0
 1io9stxnlGAucWnYfVOLXP6qL2fojcjKur5OynlvIeBpUqu7qWyQzvvLb4fQIIeG
 iesIVcneGlR+KfNoJ7zne4Y8VoIM1lqSpyJugKnJ385fPCWBc8pGzlpQeOZjEgnq
 P61nqt/Z1cIE7GUSCGEmyJyt8zSm7vEkCQgqNMMiL5xfJBNqo4sYxdk6Xzz3IjJN
 QbTOzt5q5+AOKb8NH4i6ORTwmWcyZpl9llDtx0MxDIOw2P3HklNqd2k0yuMYJbpy
 bm4T59EZOV9+BNEOMEoTl9m1UW1J9bqBcj/tn9oOLLKVmnjsU5f2qhLfTuw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4yvb3vuc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 16:48:03 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-341eff9e381so7572381eec.1
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 08:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795538882; x=1796143682;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=DEGJL3nMTmR/sUcm6Di8sswrta5wllQiXvIrJn5Hw2s=;
 b=J4B+rg66x8EFOi/xPQWP/K4fSHD0AcgTwUYGm4uLC+ViOYl7E0WxCsVmP1rEczDWx7
 7jcD/nKMTxeTnyz0Xu4knVPfLCjrWJ2EWYx74q9zIqhg0Tr0L5P/yVpsdBpmBnxuv8cv
 QVVX4qLMKzHUyhRPo5XAjBE3RiWxUkgMz4lo04WACoUiM1uKzoyXCr0hYL7D+6tq6qzt
 0nh/OcudKV1wfVN/hVmUbR82rIKXSJ+FmS85j4X1nLlu27i0FUY892TPCgDDQHlJrehZ
 dGJ/XgaZmgH4L9n2Vtk1bck5gYBdSVDI96X0QC6oOHsEUySW4fZ5nndJCyFVzmzam1S/
 cY7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795538882; x=1796143682;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=DEGJL3nMTmR/sUcm6Di8sswrta5wllQiXvIrJn5Hw2s=;
 b=xD6sASXNcf01uG6+8Y9ThBeiFIJcN0P07Mm3ltGNtdABsfw4txy0LOHtRg0Hgp8R91
 zQjYZQSLd3pNeCEa8lbrpAbFDOFVohhPHUHKU9w8KkmvT0YGTG8Ca9SoqJvL4wNljqIy
 nIrAHZJU1iCyrjCsIaSsg8W7i7/gr4YYBf+JR2vtvYiYjwek5ym60AOQ03FJ3N7d/F54
 vXs4fBf1AvGp/0/VECJy5NanFqlWxHGeoTg13+o1ZZnKBNtTJDcp/7eX5y4rVTWiju6l
 ryQeOTjHS/39lXlxo2JBesYBbpL/GMHeZ7srZEFtXvYhu7begoncJAeykNaphDhePTJL
 RKuQ==
X-Forwarded-Encrypted: i=1;
 AL+hErFngMsYHVSSDWsnoYV4QvaiQuN1f8WxwPdYcVCqMNeX+kcPnMJiR2cQ7aV0JUtLSSyDS3mSVL4=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/SZ4wwxd7HhLc9uWDsGYFCNfU/i8UJPkYVWL8jnb5sZACfneqo
 VYRsqpbv2ORp3WlPBRjrKy/54rndrjHxEeAkFQQX0USdX46h+JUusG1OIkz+eleEXM6k60GmBLG
 JSwYa/hIYF5iFuV8im2/CxfzF1JxaGzsEflHBGsgWitbaUB5ELPul8/suMU7kaQKacFHmXSU=
X-Gm-Gg: AZFdTZdPzgxDzO9UGkT2/lHoibb7l4+zjROhzswdAyczJwLjVpusaDaSRxMxDlkKcgt
 e2Ftp+WimvQG1IBXKrs+IOfudGw/2Q2L0nXWVy8eSdw/laTGhG55b0h+MiAyvT2a8LWfmOyRFrN
 4+6gzXfvhQfaRlT4jE+IGxENFSDFBRVugQurPnr4Z0oC75bW77Juv0vWKjZdrdoru2ZAc0QLHkC
 G5faGVlzM3S1FIAjazP1vrTaog82SiBLVVm4AqoUOcTt77wpBjJvHGHdPK0jDLfTI5wSKiFekdA
 pQoCj8QrvqL8aug5G7WU9sFhddXrjduitoaiyeLSCQOlYspsvbG7yEURw9LlnmBu2mdDLezY204
 3tONdV95dCMm9xtCm8IbA1q+LJA9Vyh3P6xnOPKf2obaPeImlIIppsTQ4I4cvoPVfANgMCwBD3s
 ZMgbvJ0a1pnbavbaVRlqNeA2NpNb5WXEg8wZxxWc14Sxd5GwQQPl9w7j3RzQ22rbidXW08
X-Received: by 2002:a05:7301:6184:10b0:386:a9d3:6ce8 with SMTP id
 5a478bee46e88-386a9d36dafmr7959348eec.7.1795538881833; 
 Tue, 24 Nov 2026 08:48:01 -0800 (PST)
X-Received: by 2002:a05:7301:6184:10b0:386:a9d3:6ce8 with SMTP id
 5a478bee46e88-386a9d36dafmr7959318eec.7.1795538881090; 
 Tue, 24 Nov 2026 08:48:01 -0800 (PST)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-38566cd40c5sm55365072eec.10.2026.11.24.08.47.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 08:48:00 -0800 (PST)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com,
 aswin.murugan@oss.qualcomm.com, lukma@nabladev.com,
 marek.vasut+usb@mailbox.org, balaji.selvanathan@oss.qualcomm.com,
 Michael.Srba@seznam.cz, quentin.schulz@cherry.de,
 william.bright@imd-tec.com, nikroks@mainlining.org,
 macpaul.lin@mediatek.com, dlechner@baylibre.com, xerikasxx@gmail.com,
 jbx6244@gmail.com, u-boot-qcom@groups.io, u-boot@lists.u-boot-project.org
Subject: [PATCH v6 9/9] configs: add shikra defconfig,
 MAINTAINERS and doc for IQS board
Date: Tue, 24 Nov 2026 22:17:00 +0530
Message-Id: <20261124164700.1606518-10-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261124164700.1606518-1-aswin.murugan@oss.qualcomm.com>
References: <20261124164700.1606518-1-aswin.murugan@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=aJ1lOr9m c=1 sm=1 tr=0 ts=6b05bfc3 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=KKAkSRfTAAAA:8 a=89TKq-WogshHRaIy_BAA:9 a=scEy_gLbYbu1JhEsrz4S:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: nymlgbA4V7stScWkuATdCMMzULUtxgMz
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA2NSBTYWx0ZWRfX3t1XWBz1ya6z
 PZgaVqlW+/KOlGK6AfwF9X9MZUjMZZ9cHoL6yazreuF0RIxy0XU+tuPGQs+LA7VLgex1ghc/eI0
 /xJhSY26NOQoQi85UyAzInRVi6z94gw=
X-Proofpoint-GUID: nymlgbA4V7stScWkuATdCMMzULUtxgMz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA2NSBTYWx0ZWRfXyG8fp+59d8BJ
 OxiBHWW3vRmD1XVURzCGygOdgbzFssIUSVsPsm3/eZQZgVwfuYhx9IuNxHN6eIcimvlcxFey3Dp
 MKz5n2nR0ODe8q4PNfU9WSVxXEjQGqjZBE+tg1l0LHYTJB9jxrOPEoyVavSgJgVxCqeo4VHFIUh
 ThqCTqtaJwmMw1Jvj8wAxlz0w3kclXP+EYhftWQ9VMh4+AmdUoFiR6C1LZ3O2rX4mFXg7uqruZY
 Ob8IwditOg0kD0n7Y6onrJt4LXIIphLJKBs87ttL2OWZKiXPGZf6w1oCfctdVqBVrwif4+wmKpj
 aTAIVL2X+iWkziB7yUOa8m5d7gCJe+kRTi37BVE5w61/DlIvMGeBbJ10cjE3lGjMCkKAAYweeqx
 deXnzVcy2uVDPSO31jeZTZCACw3YD23RauC4JR5PTBpoXTY7EHimWMNFu4jAv+QZ9pOXc1NLpdJ
 94gIaLTjf1N1Fl4Ls9Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_04,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 adultscore=0 bulkscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240065
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

Introduce a defconfig for Shikra IQS board, add the corresponding
MAINTAINERS entry, and document the board in dragonwing.rst, folded
into a single patch per review feedback.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 board/qualcomm/MAINTAINERS        |  5 +++++
 configs/qcom_shikra_iqs_defconfig | 31 +++++++++++++++++++++++++++++++
 doc/board/qualcomm/dragonwing.rst | 16 ++++++++++++----
 3 files changed, 48 insertions(+), 4 deletions(-)
 create mode 100644 configs/qcom_shikra_iqs_defconfig

diff --git a/board/qualcomm/MAINTAINERS b/board/qualcomm/MAINTAINERS
index 3767a2a7949..f8cd20ee60a 100644
--- a/board/qualcomm/MAINTAINERS
+++ b/board/qualcomm/MAINTAINERS
@@ -6,6 +6,11 @@ M:	Aswin Murugan <aswin.murugan@oss.qualcomm.com>
 S:	Maintained
 N:	qcs615
 
+QUALCOMM DRAGONWING SHIKRA
+M:	Aswin Murugan <aswin.murugan@oss.qualcomm.com>
+S:	Maintained
+N:	shikra
+
 # RB3 Gen 2 and similar boards
 QUALCOMM DRAGONWING QCS6490
 M:	Casey Connolly <casey.connolly@linaro.org>
diff --git a/configs/qcom_shikra_iqs_defconfig b/configs/qcom_shikra_iqs_defconfig
new file mode 100644
index 00000000000..9ae425450a6
--- /dev/null
+++ b/configs/qcom_shikra_iqs_defconfig
@@ -0,0 +1,31 @@
+# Configuration for building U-Boot in Shikra IQS EVK
+
+#include "qcom_defconfig"
+
+# Otherwise buildman thinks this isn't an ARM platform
+CONFIG_ARM=y
+
+CONFIG_DEFAULT_DEVICE_TREE="qcom/shikra-iqs-evk"
+
+# Address where U-Boot will be loaded on this board
+CONFIG_TEXT_BASE=0x9f400000
+CONFIG_QCOM_GENERATE_MBN=y
+
+CONFIG_FASTBOOT_BUF_ADDR=0xc5000000
+
+# Shikra has eMMC only, not UFS/SCSI - override qcom_defconfig settings
+CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME="mmc"
+CONFIG_FASTBOOT_FLASH_BLOCK_DEVICE_ID=0
+
+# CONFIG_SCSI is not set
+
+# Environment stored in eMMC logfs partition
+CONFIG_ENV_IS_IN_MMC=y
+CONFIG_ENV_MMC_USE_SW_PARTITION=y
+CONFIG_ENV_MMC_SW_PARTITION="logfs"
+CONFIG_ENV_OFFSET=0x0
+CONFIG_ENV_SIZE=0x4000
+
+CONFIG_TEE=y
+CONFIG_OPTEE=y
+CONFIG_OPTEE_LIB=y
diff --git a/doc/board/qualcomm/dragonwing.rst b/doc/board/qualcomm/dragonwing.rst
index 42828842da5..171600b8db9 100644
--- a/doc/board/qualcomm/dragonwing.rst
+++ b/doc/board/qualcomm/dragonwing.rst
@@ -6,12 +6,14 @@ Qualcomm DragonWing
 
 Qualcomm DragonWing boards are industrial-grade platforms targeting factory
 and edge applications. They span multiple product families, including
-IQ6, IQ8, IQ9, and Q8, which are based on Qualcomm QCS615, QCS8300 (Monaco),
-QCS9100, and QCS8550 series SoCs respectively
+IQ2, IQ6, IQ8, IQ9, and Q8, which are based on Qualcomm Shikra, QCS615,
+QCS8300 (Monaco), QCS9100, and QCS8550 series SoCs respectively
 
-More information can be found on the `Qualcomm's IQ6 product page`_,
-`Qualcomm's IQ8 product page`_, `Qualcomm's IQ9 product page`_ and `Qualcomm's Q8 product page`_.
+More information can be found on the `Qualcomm's IQ2 product page`_,
+`Qualcomm's IQ6 product page`_, `Qualcomm's IQ8 product page`_,
+`Qualcomm's IQ9 product page`_ and `Qualcomm's Q8 product page`_.
 
+.. _Qualcomm's IQ2 product page: https://www.qualcomm.com/internet-of-things/products/iq2-series/iq-2390
 .. _Qualcomm's IQ6 product page: https://docs.qualcomm.com/bundle/publicresource/87-83838-1_REV_A_Qualcomm_IQ6_Series_Product_Brief.pdf
 .. _Qualcomm's IQ8 product page: https://docs.qualcomm.com/bundle/publicresource/87-83839-1_REV_A_Qualcomm_IQ8_Series_Product_Brief________.pdf
 .. _Qualcomm's IQ9 product page: https://docs.qualcomm.com/bundle/publicresource/87-83840-1_REV_A_Qualcomm_IQ9_Series_Product_Brief.pdf
@@ -36,6 +38,12 @@ Configure the build for desired platform. This command creates the required
 configuration files in the .output directory. Following gives command for each
 platform (choose based on your platform):
 
+Generate the default configuration for the IQ-2 platform:
+
+.. code-block:: bash
+
+  $ make O=.output qcom_shikra_iqs_defconfig
+
 Generate the default configuration for the IQ-615 platform:
 
 .. code-block:: bash
-- 
2.34.1

