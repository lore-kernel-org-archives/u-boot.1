Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3635CC6B2F
	for <u-boot@archiver.kernel.org>; Thu, 15 Oct 2026 04:47:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1E9FE60904;
	Thu, 15 Oct 2026 04:47:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nPiNguKIFChz; Thu, 15 Oct 2026 04:47:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3D0B2608CE
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792039648;
	b=qpLUubG96msV043XJEnI2gDAfTkWypYu3rwUojgwQu4pI/Qrn5YjcB2XbzfWHgYzVgxX
	 +PHDkALt++ohI95yfcbT4dcub9qZBwdlzHpUHBiF/3aL3J/trl1N/7GR5PhDjrITBphGl
	 hudOw/kCb5A/eRnEgAVEdmp+RKJFhKoXogn7DeP3ML7a5dz/q9Rtsyr3ReJfxSTVdyVlZ
	 oTn499wIu+Qo6TrhqPPzGWvQ43mB3HZivuM9Ef6QfjRToln1Bneeha/RPZI05q7DCIbSY
	 Lj6PKcv5hGxIt85cgddEcNtFyce7ldTWH2Zlv9iwmwyKNLzinGWClXExGrpb/XaH64A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792039648;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=go6yA0ewfppdJgFJKkbu1orKIgIWpt/uB9N8XXFqoDI=;
	b=GweBsK0bjOAS5lqTLQmSYGryzFu4Z8ZItXdm3jUP3YjNUd+szAdf6bBrbsl49lAYTCVA
	 ru+m241iwADkEPNcBZQuuEuQx4o/pzjWNcRqAOlG7yfA/jhMzFKdktSBVEKg1s+4vMXAb
	 dqpC2AV7ddHtCmwUS4OXTXUSCDflSOcTGS/1xPsRbZYjO6FXKtzEW57gNMPL+cA9PPMtL
	 GV672ite/MooSZuzV8DrZNINXWcIvKT63TeutknzXrlzKFxpc3BoqrFdQugAPCii03ClW
	 lhx1Z+9lzi9+TzdN1w6CrW3b3DeGmpBp+IRm38AuOVnXwwukD7d1FfzKRKeYcPINaSA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792039648;
	bh=go6yA0ewfppdJgFJKkbu1orKIgIWpt/uB9N8XXFqoDI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wENYumWjkiH5xy3GInfdl/OkBGqdy9PMOIngn1P1sDKzeOZfhVZ9J50vGF6X57N/g
	 gilhnjK/AbLxMOx/XHX1sik/0zxJ0wSdc5oZPmo8QD6D56tgVUiPjQozZnFG8pKiUE
	 nYJxZjgkIzBy9n2YCK0pvIkwJ6Eed1gBNozX5w5rPMFHPquk5i3mbwOmHQTgSE6c6I
	 /t0zoedUu7lAM/yHgldbrk62PetrZTFuZpFlNvzrWu35DUfCfsSxT1iuFSi96Pjb0F
	 IIwv0hD008S/03A/iqmYypQJL0vlkrsUg3etem9YGVkKXwJLIvGkXVrZwZmSmOBHcX
	 dPUj9W2Ba3EJw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3D0B2608CE;
	Thu, 15 Oct 2026 04:47:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1A692E4D
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 04:47:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0C9FE80FF7
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 04:47:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ceSTR3rg9_Ci for <u-boot@lists.u-boot-project.org>;
 Thu, 15 Oct 2026 04:47:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org F135780F5C
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792039646;
 b=WkvbCfDykw6VRDmnQA2C6I8FsIfMK67mDwqkZiJRXlXB/LIiv/z6OTcapeyjXABGMT1A
 sFb2S6SUtAgl9cPwsf4Yr1B/p1eYYx3BN4CoqpePCoCkBquB3aguTQQfa5GW6KaD4wz71
 CIuUj8DngSvRREpNPc1FykskS6bzAxeY1ARDmHgCpysaeub9uhmn2md4VrG/tTi0IOzfN
 pxog+qCqt1hYQR+WDPFfmOIUuLgHNnT91MkX93DOfs1njWfFNp8jAb2xcRmHv/c2qWBk6
 JhXH6f+mvWp8f71d0xwxQ9KQgGG0cHQjEkXnIPazg2adPqZMCvlg2Gkpe5DeUBkU1+A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792039646;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Authority-Analysis:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=go6yA0ewfppdJgFJKkbu1orKIgIWpt/uB9N8XXFqoDI=;
 b=niBx4NPQsikwY+rpsuvi3nxmgbBqUHbNVLeAovHB4ImCHNdBStm0qe31CqtD4pNXnA2y
 roqaZTHDZTYGsVucWaEDKrYIRoO0yIwDyD119M6WGFRQ3IMszgVHthYZFUZTcXHMvkfb1
 CnKmnGmiB6gR5o8fwYoCYaQzkqe619DQufZJlBtof8dtPV5fDtw9KkaJMvn+5DYJLV8CH
 ml0N9YZWSd2+JAd2E7RgyopkAuzqlU9lU8iVKcOjyeQY+GRNXP/S9aHxgadAcSq35ouh7
 KRVp/+ib2sNwLjIFTAoP/f500qNSxMP3HLoz5EG5ctGtrYW563abK25uEMUR98XRnBQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=ehGsPpdP; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Dh4idceK; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=varadarajan.narayanan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=ehGsPpdP; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Dh4idceK
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F135780F5C
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 04:47:25 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69F1OhKN1707333
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 04:47:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=go6yA0ewfppdJgFJKkbu1orK
 IgIWpt/uB9N8XXFqoDI=; b=ehGsPpdPrAY8q6w/eQ8KLpyulKx7bfqSPfv1XEKb
 rNWFamol//fmsBGkBpwG7cYByhQ0l2t1e+YrN4CNpq0fzprXSUES8IsCXpRLBF+B
 05nZN4mTibqbt+jPT0DG0U1cfdngY+euf84ZjBqDyDEf9Q4zQqWo/RM3/uK4sxG9
 EOdykhfeclf65KFh2ATMAFS2DfoxW2SitFiaCdRCspHBNxaZdXgVV2x7xG+pJGEc
 zJOsIfzAkSGYpwkSiqOmCJtzTDEy9LGn/tYQh/pGT5izz8wxsGENzmh44l8eG8uB
 3r7CRbeeMWAEa+vHEh/QvTVr+KlXeOlY/p5LLJnrnJCOxg==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4han54rn7s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 04:47:24 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-1383723dfddso3160608c88.0
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 21:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792039643; x=1792644443;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=go6yA0ewfppdJgFJKkbu1orKIgIWpt/uB9N8XXFqoDI=;
 b=Dh4idceKEVf4C57EAcLWbMYujfNO+C8XyQ1hqyeD0lxl5x7RdfAOx+6m8Y/tLHpVdk
 PAUWapjcwrZqmNbyPN8xY+/D5LrsKmeSuks+3wqLMhRgKaDu98485YvbJ3ysfaC1OYCG
 mW89ByAdihfEKxEFKTz7MHRP+snAB62mTlRm9wRRHeQDmdfk2FyjLkjv8e55FWSUu0If
 aXiYS3Z/7ViuXQYuSEwQbyhjTQcQBRSaZMp054g6RXTA30v3OFYbfV6HL7Tqm5P3Nuxl
 EvvO3zHMlRGYsl4u/F5osl/fAg9CrDs9gzCNyzQqrSZp9vPbIvcHPlOx2aacMaDUkciV
 MfRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792039643; x=1792644443;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=go6yA0ewfppdJgFJKkbu1orKIgIWpt/uB9N8XXFqoDI=;
 b=wQgi00at7MwY+6gyq0PIsCsGDJLTF81Q+tiPTe6/r2yhX9Fr2X+p82D6RSvapx5FjC
 6BwlYf5iI0jJzOuWjPpIn6/IArJtl0lXa59EVAUrRfu6uPXauB1bljXNQwXYqdjEq5Rr
 cfR2QLWYUreS9j38r86pZTQ1lwVpjxcg7ue7HS5v9cFGo2MEIRzTDOshbw3NTq4omoU2
 CLyJyQ3CMZ0F45m94jXtPnerQAnmL0ApV+tdqHaahTzxPxvzqe7tzKz7rswZTLEe+73r
 IDoXvbONBBSqOFpzc3dy45hLs/MHj8fkYhWQYyIKXcEKE4JR5PTCOvDtlwElo7jIdbBE
 k4HQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzkt1RblCWgRk72dBJl4wfUd/Zzyiv+I+bhvLpM+p1pwdgn+5E7VnSpb/9JhKlC4B7UtyroltM=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJfKCL6/Sfenx2xE/F59VphoarbTK9wLErKlyM93Ds1NkGQbJ7p
 EsRqZElTaXB0R0rOcpN8mRY3scz5uyvy3iDfEHquGpBMDMcPy1nXtcNhuzIbqX/6smjfbSM3kug
 vqJ9163kuNjtijfkrxlF6lMIqrSlymPHRp5B2ITqTSchVuyJ0KOL39JRaH+0To2fADP+XQ1QkEK
 0vnVY=
X-Gm-Gg: AYBFou3i3r5aQLqiHHZEbke1CEEVyd5ruvRPE/wxKX6TBCk3KWDFEEQXaadTkpdkaE2
 BRSlzZRhp2JL4S1lUTQrCVp5MObi2ahUOsv0tB3LoAwxHXUJSPL6JggFT8xEWBc/KczMM3NZ95f
 PVuvw5yBgw1lJBw1hHX/egQH9St1vc/WvBLkYuLt1dxhcIcosI0l0oO8Z/YRcyp5iwO2z289hId
 0f0kRWLW77CWtvHF4a1RgvDSc5TCC9lUTbuoH2OB4zyMhX7bmHFxc0ux5c9nWIuOWE9sgga7bwX
 nHa/CjnfHcUm2mwVtthHp5IvX/BLoJe5RAeH1NpLF1m1iogDTqO9ei+Do7wuXMX5wXFOldoCGny
 ia3sd5Kw5tXpBIdpvmQfATanIVhw3SGPSnkDMmS6J4bZ334c8w1CN21a85dHakFu/2HLNJwX9KS
 cGspHE10WkcYI2mrc1H+vO+BxTllfd
X-Received: by 2002:a05:7022:2211:b0:166:4b25:8bbc with SMTP id
 a92af1059eb24-16a6203dee9mr36555379c88.32.1792039643209; 
 Wed, 14 Oct 2026 21:47:23 -0700 (PDT)
X-Received: by 2002:a05:7022:2211:b0:166:4b25:8bbc with SMTP id
 a92af1059eb24-16a6203dee9mr36555226c88.32.1792039640838; 
 Wed, 14 Oct 2026 21:47:20 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-169a3f6186fsm54400311c88.14.2026.10.14.21.47.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 21:47:20 -0700 (PDT)
Date: Thu, 15 Oct 2026 10:17:12 +0530
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: Abhilash V <abhilash.v@oss.qualcomm.com>
Cc: trini@konsulko.com, ilias.apalodimas@linaro.org, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org,
 aswin.murugan@oss.qualcomm.com, Michael.Srba@seznam.cz,
 kr.sowmiya@oss.qualcomm.com, sjg@chromium.org, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v1 0/2] qcom: spl: enable CDT for shikra Add support for
 loading the Config/Chip Data Table (CDT) from eMMC during the Shikra SPL
 boot flow and registering it with QCLIB via the interface table.
Message-ID: <atBa0CC5IBWk9CLN@hu-varada-blr.qualcomm.com>
References: <20261014125125.711084-1-abhilash.v@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261014125125.711084-1-abhilash.v@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=RYQFmFtv c=1 sm=1 tr=0 ts=6ad05adc cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=9U8HI1bZefmV58vc:21 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=4NIWSolvcrG_LdBZkeIA:9 a=CjuIK1q_8ugA:10
 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDAxOCBTYWx0ZWRfX7vurS9LQwmeY
 vtlX1MnxX8Nw6Qj+EZMtiGZv99jlUOJBySwNmC4rPIIEV36sDRlEk5sDakkGPCbdRB5ZcbdssX7
 opA9RWAo9rLwtVu568rlWI+NXQkYMKn8007cTAUA4eU+M3+GLbNQtnkYDza/ic7cT+jPaoNqoa/
 LDRtXNuFQQOh8zZbAM3BAwWymhrXaNAAubY8j2lDpTJYwY6qfo9bIX/A+NtiTEcJiOC8muzmsDz
 D8wngNtKCDD0rKvArKKJ2eLSYFw/jSgMmCN5pX7hiOPog8ZFDAWRgf9tdR28o/+FhCMQ3twwpz/
 0sLIHP0e1Eje1CzaFCPfXkM2dPk4SmDR6gnO6MkXvn+jGm7Pf8NEemyg22p3Kh1C705kLou53bq
 ygNZ8nRoPdYUh/4Pe92exsM6gRKZNSo1qghibcFl2c+ExfrdaQt9QbUbYsnn2U+bAWP3y4S0kkS
 txv/FaGkzbsRy4bNJfA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDAxOCBTYWx0ZWRfX9ZZ/YgPhdk/U
 QphnTJKk6tY5qgPJ7fJVyR/a/+KcL+3VDualV3zqu1V0F4ciANisgniAyU8lxIuZ1QGsBvbBFDU
 EpyIzm5HoFEMckd7PEaQ/MDlMyzhs9c=
X-Proofpoint-GUID: _oiXw62DZcv_QGVGfhvhN5Rq_RMUM33V
X-Proofpoint-ORIG-GUID: _oiXw62DZcv_QGVGfhvhN5Rq_RMUM33V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150018
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

On Wed, Oct 14, 2026 at 05:51:23AM -0700, Abhilash V wrote:

Commit text and subject combined into one long subject line...

-Varada

> Depends on:
>
>  - https://lore.kernel.org/u-boot/20261013053244.2954876-1-abhilash.v@oss.qualcomm.com/
>
> KR Sowmiya (2):
>   cdt: enable CDT for Shikra SPL
>   mach-snapdragon: Kconfig: add CDT configs
>
>  arch/arm/mach-snapdragon/Kconfig            | 72 ++++++++++++++++
>  arch/arm/mach-snapdragon/board_spl.c        | 96 +++++++++++++++++++++
>  arch/arm/mach-snapdragon/include/mach/spl.h |  1 +
>  arch/arm/mach-snapdragon/qclib.c            |  8 ++
>  board/qualcomm/shikra/spl-shikra.c          | 15 ++++
>  5 files changed, 192 insertions(+)
>
> --
> 2.34.1
>
