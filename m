Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70AD2606A31C
	for <u-boot@archiver.kernel.org>; Tue, 10 Nov 2026 11:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=DDFV9B+t;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=EGJXn8eG;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Q4IjFo7y
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F3CFB8115D;
	Tue, 10 Nov 2026 11:45:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Q_-kckJ_6pJV; Tue, 10 Nov 2026 11:45:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 367FA8112A
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794311141;
	b=LpvT4IDXb8ep8znL0uIrpiVZGHeMdVH9wo+GgaPu7n4tKfp0+z5YK6xtjlSvYnJvgEgC
	 BbNIt7LQ5ZizgfV9sU863R+PsnbxJ5Xt03MTrKLZWdsYsi/+itTBI8sIc8tmK8n9ROgdJ
	 aitXVqtQ9bJzWOMKrd9f46+GFSRnW7HJ3rKzcJfvui06F6dVyzMnEoLfbibb8sIJOQMuo
	 8epQZgYJm77MWtczvj5XRTNqHXmQ/49ryLg30StTk8B79Y1L5PvvRTfVq7RAjIH6LxZAS
	 BwDPg2VbjrzUgs8h939TNDo9PhpR60nXVMDIJi3QXE0CewFroscn4SN21tb0+9uFc3g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794311141;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Oh1OY9mslg9WXT9if7VZawClber3mU/Xf4BbXsRDyxQ=;
	b=BngjYomfLwUEpclK3AnNlsjhVR+r7zTjto1UcQieCTWWiq0NMslra6IxVULnkuhHzF0j
	 I0uf/RcBldwGc7I+fAbmIRe8JH4abvQyLq5eYeAmGSaLSB69RFGCR1xpGktzmww95LVGe
	 QEIqjNM8urcpXY3JrS7GQBOlCDHJGSRhJydUWs5W34ncl7W/Vp+hfVKK0UnO9pGHXyI7k
	 S2pimbo/6ksKVx6MySKynTIqo3KFcYLOjsoz5b6huQaajqcJU36wtK5LiBsZnOKD+YfaE
	 u1+6sqmFh1wuopPp/NplGpm5+Wmw7pogKTo7Ow7I73GBfxVdfND2BMZwjvNK7xJiVMw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794311141;
	bh=Oh1OY9mslg9WXT9if7VZawClber3mU/Xf4BbXsRDyxQ=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DDFV9B+tciNXw8kNaCID0jk9fKSQjGpli9Dhklqp8Huk1begHTCl+W+dXTkdy5rEF
	 u8oqrEAAHx7OhDVkUkGBjZ6XxSm751V/f6jPLXsg1zZSCs+vdUJ0fIn51wXCQpP+K5
	 Tgvju0y433q/8fdJVG6IKolJ2gVdf6+hAD3pDKApC71mh5RcLehdkG+YPVHGfnUSH0
	 viEAxPTs0roMHjgcMSsmNVrmqHxymZv36oM1a4CB4pBQ1w7V9vFutfsMrTuEzEYoEw
	 cDe8aogJj2sI22ByQa9jI31kunhV7aIH0cR+5Z5rnb6lgC1PfVqdKn9v9H9DRqU/WL
	 iYJQW8FUu0IRw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 367FA8112A;
	Tue, 10 Nov 2026 11:45:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 070EF2FE
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 11:45:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DCCD0407FC
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 11:45:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mEpfCCFdf1ii for <u-boot@lists.u-boot-project.org>;
 Tue, 10 Nov 2026 11:45:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D25F040811
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=EGJXn8eG; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Q4IjFo7y
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D25F040811
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 11:45:36 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AABAHRG2688078
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 11:45:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Oh1OY9mslg9
 WXT9if7VZawClber3mU/Xf4BbXsRDyxQ=; b=EGJXn8eGDjtSrwCvl2OToI6ce8s
 8R8rq4sowAiTFJqPQQF7F7XDRSkVdquQXEdTdSmcQP2SGQ04B5u+oWN9LEaCiFiv
 FzsajWkz1jiaf8+UodBagnS8TRNm8O8Ka3YnMqj+fQ6RG595Rh4JjD2+iSWX/I8+
 fryb4ad5ckSFUC3C5R6SWScfpSVuUDnMgrJKX/9JKf5/GBKlb46NkMBrYxSuXcfM
 CDzzbNn68x/DfCCMhDaTcQSrFkl6bmLaEcfmjAruuxAgoPvl83a+aCF8lV9tbK1D
 1wzG50ZXr3GextpQqK0ucM6Au1Lp5+oBLeDEuPWcxl0be9ymeFD7SeN76fw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4huucp1ssf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 11:45:35 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-375f0fd31f4so283921eec.0
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 03:45:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794311135; x=1794915935;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Oh1OY9mslg9WXT9if7VZawClber3mU/Xf4BbXsRDyxQ=;
 b=Q4IjFo7yf4VRVBgV0jb/Lut/UVNqn0k9IrNtBLiNp+MK+CRJA+unueO+n+rm9O0AsL
 oQR+2axaPU3+shIeZj1j3fOr4dwRtsXzcPPhf0CCmaR4alBfBE75Grn6Do5zV2mYSSwP
 zFFq0G8LdgoeR7ccaok6tNaqqlv60+wXFHvDFmuYcggOtUyFv83rfNFsusoxVC+Gw77f
 t4PD/H08JqUcwcdPHSMXaNxGEz9ocauD7WVgcaCM74IDaG7gOLE5XIBKaxzwsNDcju+d
 pJPFQL4uAi8yg+5UIhn6MHM9ZfmlA6+2P8AKns1e4eMefdhT/1kUSX4G8xKPsbnqdS3R
 mYgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794311135; x=1794915935;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Oh1OY9mslg9WXT9if7VZawClber3mU/Xf4BbXsRDyxQ=;
 b=NZCQYi3bh0aGOVFYLEbBsuN2hgdyG1Ww4BGtZy9McCJq9vSB2C8Lx2MSr4MxQa7bS5
 mnjve9c4IeE937+21hw8akT0y67NGAyXwVZ29uC3imcbb9toB6tRfS6YxKSxh4iDj7/m
 I5wU9dZUuy0IFRgn+vzB6EfkUuYR6lQHuQf22df9YMeNRUeVI/GL9Jcge0EDDYHdvuR1
 h7jGzTxPuww1U98btmq1RtZUKQaIJOOlz2uqhMs+bdpXJF6p80O2rziUI00tsa+4ZxX4
 SGNj2UbjSJCmYwCqJjSSUkTjPl5/F79PbMpMiFTgwgwaDzf2ZCN60ZnqKFi/fyE3gdS7
 E1qw==
X-Forwarded-Encrypted: i=1;
 AL+hErH+b230CIT8AVFBlFqLaHENxwJcg2FjdpsQDuu2JJsIpTZUa174vVLYdXJBigFjuy+OrcFIQ7k=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8JvxWHlyttl6cPxCb/O+DwqIGcSXw10ajJEu6iX51+AOPknQt8
 msaW7Fb9VcmoWiKz2hFd0HJEuILN5ZrmqARG0tiaNnFe43KUeT+iWDb/z5i793krq0U3w+KQrKA
 FSJgFfvptZtJ0JVu0yhB5WukIBe3s/bINs4axv/6yNA6eR27U4NYHNtMMSkrpd3urd3Ti3BA=
X-Gm-Gg: AYBFou2M2qqZs/nG8pxsVT2u2HWbRCm9IrYy2v6FJOdl8RCJJxd5bTIN3YRQ2qRxBTk
 W9ft4eYK23s01ygxNjeH34PPFVVTJPgZNhAnwIHB70xnQamVpa3mWLf092eG2KjlSmicpU8oh1B
 APzhkrS8jgTzSRRvzdkReTd2ohYewY5MoHXrndNVrK6l6B5HQ4rNj7/MmQsWxozB/TI71IjC0OP
 t6QnUz0IT117jdd0u8bb4uFjcIWmtB92cDPCI19+X4o+T18PJIehXNkNRc86t2f03Fgcv3M3hWX
 Ini3gtTKFUWd/XOMDNpu4UHS68jUvYLxGSzGokyDPDzmFNIZQOiItmyqUZ2SIRkImrPqSOy4roD
 56i1FvA0ULmCMPS8FcDWFJZgnUEyPguNiNtFw5/jOOGkVnaPHlQ8mYYQrsGBFlKjQbgiZM2xNzL
 6ch+JQYt7QQbdOWyd9Ou0zJvBQhTR3tXFHYFaWtHnqQTZPMimk7p/kTH9391UWhDZlg6zS
X-Received: by 2002:a05:693c:8083:b0:36e:1fbe:357a with SMTP id
 5a478bee46e88-3751fb352ebmr2870488eec.13.1794311134791; 
 Tue, 10 Nov 2026 03:45:34 -0800 (PST)
X-Received: by 2002:a05:693c:8083:b0:36e:1fbe:357a with SMTP id
 5a478bee46e88-3751fb352ebmr2870446eec.13.1794311134147; 
 Tue, 10 Nov 2026 03:45:34 -0800 (PST)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-37520bf3e18sm11828890eec.16.2026.11.10.03.45.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 03:45:33 -0800 (PST)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com, peng.fan@nxp.com,
 jh80.chung@samsung.com, tanmay.kathpalia@altera.com,
 aswin.murugan@oss.qualcomm.com, nathbappai@gmail.com,
 balaji.selvanathan@oss.qualcomm.com, Michael.Srba@seznam.cz,
 u-boot-qcom@groups.io, u-boot@lists.u-boot-project.org
Subject: [PATCH v4 1/4] mmc: msm_sdhci: move definitions to msm_sdhci.h
Date: Tue, 10 Nov 2026 17:15:17 +0530
Message-Id: <20261110114520.229480-2-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261110114520.229480-1-aswin.murugan@oss.qualcomm.com>
References: <20261110114520.229480-1-aswin.murugan@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: OVLB8pzx_dRwt9Kl5uggfxsi9tDDNokL
X-Authority-Analysis: v=2.4 cv=U4oHnuru c=1 sm=1 tr=0 ts=6af303df cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=pGLkceISAAAA:8 a=tiNvdn2s32eWz7v9I9UA:9 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDA0NiBTYWx0ZWRfX0gEYNBz6N+fO
 uyVPG1w4tWcV+ZWgkxjyryOkQdEoIk9Mu59uN3BYUbk5Hrb5ADNSAp5TOwCZ8Ooa7pSkLylwymg
 BOqMYRRsdZGHr0bCg1LBpHvAPm7PQD1zLK1FDYZt2BImJ8oZp84v+8RzR/C+CRunnyY//Jdok02
 +SQ8ISKUESpExJeFImsWYV+oby1qxsLJeTOsJl54BDHIKx9Qs66YAEHUfYOHh8Z17Y4vz9cxPcN
 T2YuIXN8BhWTAw0VbRDkHM20dHsTV6R6Dq4F3cQdrNBDMUi9FTnVucT2J4M4cHQcHYbuNhrl4mm
 b4UrO5AY6cRMN7WcN3XYvGjMZ3xFZG8erlqNc4Xw25KhPtUn+l/BejvpIOiipRRh+Vyk/0RLLp7
 cN1DxHcZ9ds7jnUwuv28i1UhxfLF/xXtEQHW/RrV2WXDZZMgTIPiZacoK5CI1IrtG1qdqNUollo
 F/dRDQHvcV2OruZcmzQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDA0NiBTYWx0ZWRfX0reBO/OrmK/k
 PT/AnE+ICvuGO3CiSiP6/63KwjpLmRDKeHsWIIZ0ZMiPze2qLqtInkA15/+c9693irW9a2QivpB
 D6prjBlyafr3ERc6jTBKVkNaMTRaUh4=
X-Proofpoint-GUID: OVLB8pzx_dRwt9Kl5uggfxsi9tDDNokL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_04,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 spamscore=0 adultscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100046
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

Split register/bit definitions and the msm_sdhc/msm_sdhc_variant_info
structs out into a new msm_sdhci.h, matching the header/source split
already used by other sdhci drivers (sdhci-cadence.h, tmio-common.h,
etc). No functional change; makes room for the HS200/HS400 additions
that follow without growing msm_sdhci.c into one large undifferentiated
file.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 drivers/mmc/msm_sdhci.c | 45 +--------------------------------
 drivers/mmc/msm_sdhci.h | 56 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+), 44 deletions(-)
 create mode 100644 drivers/mmc/msm_sdhci.h

diff --git a/drivers/mmc/msm_sdhci.c b/drivers/mmc/msm_sdhci.c
index 9cc11a5e269..d7ae26c609c 100644
--- a/drivers/mmc/msm_sdhci.c
+++ b/drivers/mmc/msm_sdhci.c
@@ -11,54 +11,11 @@
 #include <dm.h>
 #include <malloc.h>
 #include <reset.h>
-#include <sdhci.h>
 #include <wait_bit.h>
 #include <asm/io.h>
 #include <linux/bitops.h>
 #include <power/regulator.h>
-
-/* Non-standard registers needed for SDHCI startup */
-#define SDCC_MCI_POWER   0x0
-#define SDCC_MCI_POWER_SW_RST BIT(7)
-
-/* This is undocumented register */
-#define SDCC_MCI_VERSION		0x50
-#define SDCC_V5_VERSION			0x318
-
-#define SDCC_VERSION_MAJOR_SHIFT	28
-#define SDCC_VERSION_MAJOR_MASK		(0xf << SDCC_VERSION_MAJOR_SHIFT)
-#define SDCC_VERSION_MINOR_MASK		0xff
-
-#define SDCC_MCI_STATUS2 0x6C
-#define SDCC_MCI_STATUS2_MCI_ACT 0x1
-#define SDCC_MCI_HC_MODE 0x78
-
-#define CORE_VENDOR_SPEC_POR_VAL 0xa9c
-
-#define CORE_DLL_PDN		BIT(29)
-#define CORE_DLL_RST		BIT(30)
-
-#define MHZ(X) ((X) * 1000000UL)
-
-struct msm_sdhc_plat {
-	struct mmc_config cfg;
-	struct mmc mmc;
-};
-
-struct msm_sdhc {
-	struct sdhci_host host;
-	void *base;
-	struct clk_bulk clks;
-	struct udevice *vqmmc;
-};
-
-struct msm_sdhc_variant_info {
-	bool mci_removed;
-
-	u32 core_dll_config;
-	u32 core_vendor_spec;
-	u32 core_vendor_spec_capabilities0;
-};
+#include "msm_sdhci.h"
 
 static int msm_sdc_clk_init(struct udevice *dev)
 {
diff --git a/drivers/mmc/msm_sdhci.h b/drivers/mmc/msm_sdhci.h
new file mode 100644
index 00000000000..a8e1c2e8334
--- /dev/null
+++ b/drivers/mmc/msm_sdhci.h
@@ -0,0 +1,56 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Qualcomm SDHCI driver - SD/eMMC controller
+ *
+ * (C) Copyright 2015 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>
+ */
+
+#ifndef __MSM_SDHCI_H__
+#define __MSM_SDHCI_H__
+
+#include <sdhci.h>
+
+/* Non-standard registers needed for SDHCI startup */
+#define SDCC_MCI_POWER   0x0
+#define SDCC_MCI_POWER_SW_RST BIT(7)
+
+/* This is undocumented register */
+#define SDCC_MCI_VERSION		0x50
+#define SDCC_V5_VERSION			0x318
+
+#define SDCC_VERSION_MAJOR_SHIFT	28
+#define SDCC_VERSION_MAJOR_MASK		(0xf << SDCC_VERSION_MAJOR_SHIFT)
+#define SDCC_VERSION_MINOR_MASK		0xff
+
+#define SDCC_MCI_STATUS2 0x6C
+#define SDCC_MCI_STATUS2_MCI_ACT 0x1
+#define SDCC_MCI_HC_MODE 0x78
+
+#define CORE_VENDOR_SPEC_POR_VAL 0xa9c
+
+#define CORE_DLL_PDN		BIT(29)
+#define CORE_DLL_RST		BIT(30)
+
+#define MHZ(X) ((X) * 1000000UL)
+
+struct msm_sdhc_plat {
+	struct mmc_config cfg;
+	struct mmc mmc;
+};
+
+struct msm_sdhc {
+	struct sdhci_host host;
+	void *base;
+	struct clk_bulk clks;
+	struct udevice *vqmmc;
+};
+
+struct msm_sdhc_variant_info {
+	bool mci_removed;
+
+	u32 core_dll_config;
+	u32 core_vendor_spec;
+	u32 core_vendor_spec_capabilities0;
+};
+
+#endif /* __MSM_SDHCI_H__ */
-- 
2.34.1

