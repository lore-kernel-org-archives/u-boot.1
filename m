Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15FB0CA600B
	for <u-boot@archiver.kernel.org>; Thu,  8 Oct 2026 10:32:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CF27380A68;
	Thu,  8 Oct 2026 10:32:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YLxU3DGnX8Zb; Thu,  8 Oct 2026 10:32:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 19B6A80ADA
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791455535;
	b=LW9mlVICPWYpjq8gHsVfh4X24t+bH2dbGvd2yHwuc3+4knpCZh8LoUwvzeuBcoL+57wD
	 4I3/hWpL/TrpIFPbjJ1lHVQRivj44374Mh0bxq9ieT902bZMoqCV/tZQoNr0hHQvMzmai
	 XSSTeUijthULUlk7W09eMFYd9LEyeg/WB+fD4YnneDoojM9eBr+dXEr27xzNiEM6G8pJC
	 m9kkAz36E8lQO8jd+r8lFuC9/yWFj7AzQDEBLclDNZO+kfb9wjQMD2p0V+/ShHOdzi8HT
	 Qcn0zWCuhM96kH7yIgvK/bkxCo8///ZQRGaAdBfgN2RyB1tqETFB91VGnDVqIKxdkUw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791455535;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=nj9RVurctmdQZd3lyQDeR5H13K5eFCTIdjEuiA4KLdI=;
	b=S50ZKi0TE/mv2Hr7lANz3bqVcuPcAijzsv2GXwnfKh6zmL7IeK4aTcdeHgQTKLLOg/vH
	 m4YbygUl03GLuNu8t7D1FBpdcRJwOgVXuRpjk3iLi1+C/3RPD9Ii9je7mEQPBEliTxMIb
	 RJC+4EmUOnDu7pbQIUaj1WOaJS5dt+UkxGuPvwo7Uc4aeYWBM4k28RTgCvLIYSqHVXrHa
	 ypQUjsrGjimz6ikJ0R3DjkojPoLj10G77IFkOcCWGjrqYEraIAV001ptm+WFrZ4I7uXD6
	 /RqFQvRZSfaStfDKe1f0DXScl6ermx0zEgt5jbormvTWsJeuCt9awRFUtPHyvrmvH1w==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791455535;
	bh=nj9RVurctmdQZd3lyQDeR5H13K5eFCTIdjEuiA4KLdI=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ha+0ha9+Z1/uIfgqVxJuQTEwseS5vC9nBtSZZ+QpypPg5vKsBzvJinL6w6DkIQ58w
	 IBP7YjOKUvjggIdSzbUMCRipMp9KynJztVTB+9O89X0C1dZ6PHVONU7cNQehetSrEJ
	 lMi6Z8qp6en3qSaNDe4/Ig0gE1B9vFDp2KpsmF3zDuzJ9pRnNBfGeCRYj0Gex4fgIF
	 3tSzmtVSgpxlRoOmOO8rE+C9yheyzzke0QtGtUUtOC9Q3S4Ogywv6AlQksLJWPckmP
	 2P4SduE2uqsuQKjzwB8Rt6tsuvOhlfRgjZD6e7meQRy/CnexegWWQZKYJRJ4MFzWuV
	 IeBkom2PC3XYQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 19B6A80ADA;
	Thu,  8 Oct 2026 10:32:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 058F4338
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 10:32:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E006540427
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 10:32:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tFcT7AQDIztP for <u-boot@lists.u-boot-project.org>;
 Thu,  8 Oct 2026 10:32:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 31FB140456
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791455533;
 b=XbpNZ2M//0zglgZIesFP+9VdkN++HK/p/9T34SkSBFkg4bUckwccSkPRhu5CSYLetGPC
 Ki0TLIfrDmVJMwVaILcruxZeL34DWA8H1OjT2i9ssMyvRVA4VX18XWiknyAfmHP8nzCpV
 dMtHxEYh496jhSSeTSgxpxcGuVH4OHPDtjZM5pQj6Fmg+mc1G8OhsvJm0Wb6UUo0o4WKB
 ew535KSyFQD6hcQSPMOy6Dfo1zWsdde1HpTSvscssJTLO3+fdWXRsHaUhKOoy3djkEmDH
 oU9dWa3zZg6uMwamaT3NJwFtHweBAXnxcujZmJntUF2O33rban+yZ3hwSSpqHPaCf1A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791455533;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-Spam-Info:
 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=nj9RVurctmdQZd3lyQDeR5H13K5eFCTIdjEuiA4KLdI=;
 b=Fzr9fXcMm27OJSDdoAPuIUJi0Oa9UUDHI4mhucEnvP6IOOkHTtWSTRVyKvWvs8Ej63SX
 y8kJ/f2vzzntDSn0bt7n2i8QIb1g1UQGc/1pczLPqJLvhdBAnd/rF4NHs7lH79ZXsC11/
 tsUQA3TMJgo1U8eLawYp22CBZMijDcWfZ5WW85gsuOVJwIauet8cXj2uK4w/0vxpuOFzs
 E6jl5KD7leZcgbpplDzdqFq8PWIRcvibUf2e661zDPc3/0lCUqOmWFgUjm/sImtdbFfUM
 ar789V410YqLsqKRStMgr2X72hhq1nLntIJWiU5iQROhTAEuoUs3MXuL3vmuzIRjqfA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=XAwpC4Ns; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=EnREeYnx; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=XAwpC4Ns; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=EnREeYnx
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 31FB140456
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 10:32:11 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6987K4cT2189845
 for <u-boot@lists.u-boot-project.org>; Thu, 8 Oct 2026 10:32:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=nj9RVurctmd
 QZd3lyQDeR5H13K5eFCTIdjEuiA4KLdI=; b=XAwpC4NsoEaJPFHbYMIF/mbF2B8
 AP75/TEt2WQpAtmppwkwDQZI+/Ej3AeVhpzQq7hKi/nDOTFfmaZfAqppkkplIv8Q
 9xvwQ26Uzz3A35NH4Ksl8Z64ItFv/t3Zx2YjhUkt1Cg5xVbU9gSHmodebbBzYLU7
 J+zuXEnCZIFnzho/pKmJ9pgBu+LBf9I6Z+821DGFgaOcidNi82e5rKaujgbgyeGw
 b6gA04ptusPS83ZeRowDWYUbs4uo1cvzr4kaftyPVg3ZvFCBy3Vgd18wiXdwcOn6
 cvOnZwGIk3HAl527TsgdNZy7bJbY55JguPyBucGc9SNyEh3tZkKnVtlVlQw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5xe3aef0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 08 Oct 2026 10:32:11 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-3510d0baf63so10442439eec.1
 for <u-boot@lists.u-boot-project.org>; Thu, 08 Oct 2026 03:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791455530; x=1792060330;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=nj9RVurctmdQZd3lyQDeR5H13K5eFCTIdjEuiA4KLdI=;
 b=EnREeYnxTMA+w2vh8fp1QGyaGAoqKtj+Svky8XwHgBJhD+wnWpGqI4PZBFoFE4T4Jn
 StbckP8ZrQl+6sgOwvEK1WZ8okPEwEf/CbNs3OOoSwIvv6gBi6ryyNFJTEZw+im1+/kA
 OYFl8rEXeNZRYKH+q0GH+SSOJ2OCkHTYK4F/LSokCU1LLg8vqVegwD9ZcM0lBXPLmqNO
 poCxTcY7tLG7nYESHlNb8JETUPArmsWEcJvdXTfLdhnxsLpRVW6Yus8kkJZ+PdWzvcIb
 IqgcL95lqm9y4tReuLKye8Y0fsbbAzE0RQU0pKtk9/PiWeXxXGTXc/TuF+Pc708EIqGa
 3q5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791455530; x=1792060330;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=nj9RVurctmdQZd3lyQDeR5H13K5eFCTIdjEuiA4KLdI=;
 b=LikBGrp/7AQEvu1C8wR52CjWJdafd026mgR0Fa/dtmdUYmErh2Kmj8IuxUDuR8Ew9n
 rq1b4GJ3cLF+Gjmy1PDz/nLURZAnCPrT9D/RAoGb9qkqH+hYCidhJPW7KalNdl/hjADP
 M0MR1PHVuWohnW154HEELUqMP/6PLj/z4CiptMbzFly6fLuTqxWApyrfqxSqtU2vrL1F
 PB1y7unzXf3uTbTWdldtuEcaEmYhByr03VfwOL/cWblrCufa9wXyvqr1/91Vr9qf6QAK
 Ah5Jh6o7NBTWhcJ1OiaweOf3U3tbk7E1+9oz1PIfhe7qNEVmoJsEPufMrNJbpnasNo41
 NQkw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwKHIRf7Qv0m2ZeGt+qCo/KqzZZIDRzeOuXZFjNcl9ofQdHmA17aNzmH9ZdcPKLVaLVzYL2i/8=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lI5Bcnj/l9TMQ2d9Xbe8i9/10f9abBBlzcrz2UEIJhmaLWAk1k
 7lZUlQR6pizb/dDQaef5FIcldjnYD5+HBHIMp3xu/7C5apjBkBCtEb1SkHh0TXKmBXy+cpq1mJg
 MTQxowTsttXhVoNE5tU87WFwo91C9TNO9yxREPIbmETTkA+qBwxh1hpjSr9uONaLPuCp5o0s=
X-Gm-Gg: AYBFou0ohToCFqhsV7lyZa1TWaOwC/rYwhNRp37KgAKiABGruU6eFNFp+gU7iBOfvuY
 uZWigLTx/Ne7nVDha3/V6hUtYKFQLoEHGOd26c+DbvuMDVhSJq0DR552wJEgg0PJxTisx1VBCpt
 a4uN78bYvvSoBS+nh7jzKzawip7h9MbAvwizMG3lHAxFvfOBuAyrfqEmepJSJYyqZBiGmglJbAA
 NiVWvaf7/DT7EX7/Z5nfHC7IAqeNNUpGCz2RM7ZKsbEzRUPgRe8bckkgD+IkDe0FJgfkQSKcANS
 +4e1SRKmDNXpKSAbevBsu+lHuxwIFT0/HiIz0FeGR/0oEPowV2bsq8vOJLWH9wtSvf+D6gP0wdv
 57tudEVHqiA3rjPzpW7EKH39Jrt/Hz504Nmuxe+4R+HuEfyciFKw7P7RlE+VoIPXCOKE8puN89q
 /ShjlUXTwOhaEHd+uG4Lk=
X-Received: by 2002:a05:701b:4344:b0:14c:a658:2c98 with SMTP id
 a92af1059eb24-161fe2a7513mr5344747c88.4.1791455530326; 
 Thu, 08 Oct 2026 03:32:10 -0700 (PDT)
X-Received: by 2002:a05:701b:4344:b0:14c:a658:2c98 with SMTP id
 a92af1059eb24-161fe2a7513mr5344718c88.4.1791455529737; 
 Thu, 08 Oct 2026 03:32:09 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-16352800ed6sm10045156c88.9.2026.10.08.03.32.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 03:32:09 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com, nathbappai@gmail.com,
 aswin.murugan@oss.qualcomm.com, Michael.Srba@seznam.cz,
 quic_timple@quicinc.com, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Subject: [PATCH RESEND v1 2/2] serial: msm_geni: Fix clock enable on error
 pointer
Date: Thu,  8 Oct 2026 16:01:46 +0530
Message-Id: <20261008103146.706211-3-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261008103146.706211-1-aswin.murugan@oss.qualcomm.com>
References: <20261008103146.706211-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=J4s/fwnS c=1 sm=1 tr=0 ts=6ac7712b cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=enwCI8h027-K9Gn1bSsA:9 a=bBxd6f-gb0O0v-kibOvt:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDA0MSBTYWx0ZWRfXy2VKCOm0xfUO
 zpQywQlX5t7Az8HOMOmTFYAvL0qA6bKk138dlrvnppy5YwZGPfTEqMRAUIRxitQE/8kU8+bN+zu
 rAYRml1H5Sv8ZG48b3esVh2XjTP6Hig=
X-Proofpoint-GUID: xcsIaJ9ADuKz3sokzjfI6iaXkxbBV81q
X-Proofpoint-ORIG-GUID: xcsIaJ9ADuKz3sokzjfI6iaXkxbBV81q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDA0MSBTYWx0ZWRfX8pX8rpchHrtS
 Swic9IoFDHJMAdiCzlXOSg3Z8c+FKn4ccMAKhD23y1U68dZewJf7cfEgONsMFwH7pI718zUfLE9
 q83cx5IvkMNvqML9usB7iHYQ18whcmbG9Sg8jPbvExjYgwECHz1TA5w+7WhO223WIZbQfHDYxK9
 22lN39oZ5n+M9zMMmCFzE3fascdIHnEZ+bTHWpBDSlsWuO45ThBgQIgQqibGjJQlt7O7G1YSfVd
 hjwicapQ3JUMi+qqtiRnWTncGhBoQ/cu+rWUoUhcLxRcDp56Hnv98wAwJMBvD0d8G6Eq5yQzccI
 e0jmITzmeqrz6LikCwfKMRIHlYc2gugfOp7Zob9i5ZI4uTi3W7nW+xSfA4fLKFmqEKRzt8F6+/G
 /QReDO7+zR2C5Pbapgl9oGzpopuzjjvJXBSH+UQwiHrFPdXbz5RlqKZfc92MleHyj6uuXE5poVd
 0IrBvKxPpYGXOEINqKA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_03,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080041
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
Errors-To: u-boot-bounces@lists.u-boot-project.org

When CONFIG_SKIP_EARLY_DM is enabled and no clock driver is available
during early serial init, devm_clk_get_optional() returns an error
pointer. The original code attempted to enable this error pointer,
causing a crash.

Fix by checking for both error pointers and NULL before calling
clk_enable(), using IS_ERR_OR_NULL() to handle all cases properly.

Reviewed-by: Casey Connolly <casey.connolly@linaro.org>
Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 drivers/serial/serial_msm_geni.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/serial/serial_msm_geni.c b/drivers/serial/serial_msm_geni.c
index ff91e0018fa..935837c18e2 100644
--- a/drivers/serial/serial_msm_geni.c
+++ b/drivers/serial/serial_msm_geni.c
@@ -527,7 +527,8 @@ static int msm_serial_probe(struct udevice *dev)
 		priv->se = clk;
 
 	/* Try enable clock */
-	clk_enable(clk);
+	if (!IS_ERR_OR_NULL(clk))
+		clk_enable(clk);
 
 	/* Check if firmware loading is needed (BT UART) */
 	proto = readl(priv->base + GENI_FW_REVISION_RO);
-- 
2.34.1

