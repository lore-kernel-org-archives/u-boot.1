Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96CACCC6B2F
	for <u-boot@archiver.kernel.org>; Thu, 15 Oct 2026 05:04:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2C0086090A;
	Thu, 15 Oct 2026 05:04:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id g0Bj-g-XSXQM; Thu, 15 Oct 2026 05:04:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B9322608DA
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792040672;
	b=bo1UgMfUOhUKycg/m/Mvv/SckfyAOQy4SZZa56sfh2jIqQJoqxcw2rGxMo2xoZPIEvFy
	 rTl2vyYBY2G64+ZGxMbbeP/V/18l8RYUrjGJdN5lP6Q8XybjKsfzBQKbmsnOcw3A01Jl/
	 rcHeBYkQZymYT8n6TcZFFPbrCOHuBx4PzA8sM+Ho++T753SHpAL4UOucQfUES40frROVr
	 wZvNEbUnyVfCfZGHDmPwYBR77/azqBhkTkFRaDT6QK0ioGHm+J4kK7M1qmYL/o+mLyfGi
	 hk8hW9zGTNaKls60sNqFcnseJFPCghYA50RmWc+4WFh+pR6qDgvPcaC+vXrrUNfoCkQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792040672;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=5XMXUIyGvYzXVbV8dr6KfkgMoJ37rILtMite2EjZuO8=;
	b=nWP5MPZxbF5mVBdBetRFVRoHhpQCtcpgXQQajL92qOKF0ECz2OmSAlkhIjsHDFdJJ2sC
	 wimKXOrE7o3vpCDZxif8rOSBuI/gdW/4uYBZEQzzmqi+/HG7xrRGJ5ula4d6xITEY521B
	 imVPE/xDmmtLdJZeMyYKpyCCRoy5Gx4piDG5sMfH1vjwzCs8iMkeLijxt7rSnNTFCCCFv
	 45mHSzUjoQYU1ASy2S3+4zB5TYNc3Ef1FRnTZ2AOvn7A8yBR5sSLBtGESvx1qaOCgdCot
	 +TSRAreX8oykZIPv6xvfshTAHYJ/uS3uQPhM9aiiJPAaPZhJOnsEdMnKMwamstxdBmA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792040672;
	bh=5XMXUIyGvYzXVbV8dr6KfkgMoJ37rILtMite2EjZuO8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jyuXuMHdV3PslzoM2CyhGKH7ptGuQOSaBToEh1PegpHZWKq5ZQgvoySXe3J1zHWmW
	 hJH0KdmgXybEx8jLRH4OCtBxLxSs+TetCCOjBr+PlmuhKZAjCsBsjERl/N9UC2mTyX
	 yJEGZkoEAd7Mvk8r1ZgxawZfLuyZhD6Ub7wRJnqAzLWjSTiZArbvLBbM5EboL0FHV1
	 xqY/4nk0yr1URwsbJmNMd86CKXM3DYwR1myJq+9SoWxHU90sVQJwLD9qqCucDko6ak
	 WQHfBvzHt8yfK3uZBC0zjPomBjaCVf/DCPanEp4EPWc+EoJij+UH0CXGjjfUza7F2E
	 Fq7/JEcOhw6iQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B9322608DA;
	Thu, 15 Oct 2026 05:04:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id B7A9B769
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 05:04:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9DDB240807
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 05:04:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NhL_rmfFFGqJ for <u-boot@lists.u-boot-project.org>;
 Thu, 15 Oct 2026 05:04:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 99809407E7
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792040671;
 b=Vxmmzwl0x1JJ//h/WVMTFLgHt2+WmfpgZgePDf1YRe07Pmz1tOJeBiM41F/A/1UWY5Le
 oHD/pJc649RcAK4JVsjThSnjPb8aCkBxV1vTcrig5Bwuubh6Ut3sCEnNiCgKgwwqcIY8k
 nzUKfJHCn2qN52vT7mLmTFojxP4NSHzb8At/13XQE6qPqO1GiDyOmAjN7dPjkCrPEvaU4
 OuOfPRNw4i3TkNCSe0ykZwsrqC0t7SDIoVBTNLwicPwyxBs8GqSOx7pwN7URtycyLUV9B
 0FbGPcZmXliHVOSj2pJkVCt6atE5bo6Tq03wf2Cs+eZ1hHV9yUWZc73vamFmSIcbVLA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792040671;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Proofpoint-Spam-Info:
 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=5XMXUIyGvYzXVbV8dr6KfkgMoJ37rILtMite2EjZuO8=;
 b=RXpoftqSuX9l3gvfA0IqhbWGKf3s4JsOFDt0gJWM8e27uiOKhkZQbo29dE2dL2QcRlz0
 hxzi3lKVbnPCOgte2AN8uL7xFuoMiP6VZ6BtWQhMmBT1W2BRazZDGHJhfNs2+HEhdNwHp
 1/cEhMb3E6F9TNjdCta4yxFApGiewQjVmsDq+It9oZgzR7t1uP6ClkHAHdeX1zlO9VPnx
 Atab4yvOyNFwS9kQiRImguEEvh2zuE77dXl6jVNMr8uSkie/CRGbLAq1Jply4TcrrWSBx
 KZHHQhsAUU9OL6GEcrGhD1MCPBt1Q/S2do4KejPdjN7/d2xDZS3HrdkifI+duvgbBfg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=XQXHtaTu; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Q9vVS3Aw; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=varadarajan.narayanan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=XQXHtaTu; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Q9vVS3Aw
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 99809407E7
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 05:04:29 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69F3wm281889713
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 05:04:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=5XMXUIyGvYzXVbV8dr6KfkgM
 oJ37rILtMite2EjZuO8=; b=XQXHtaTu/gLnmI4Yo6G1AGl8FDpAwwusyGEgC8Qv
 7YvD3sAqmOSXipXroUPD7VdwgY6S0djlWR/TDnBnL5ick1IYo/jBKoLGh0H2O1aJ
 RQOHrDfuz9ZeQASBdNf9ZO7KMf17nUdUab+HMTvvnqgVQjhs//tQYareqSCPs1j4
 XXzXDXKJs+WuqhXxeWlrXXtwGyzsFhRODSInVK10py7HrBapeFaNQy3s91buE0E7
 Tut/oSRqU4vK5Vj5swQd+/JRZeE6okwnqKMeV/7yag359rDvfOTXu8Zdl2IONnxN
 xn1CyZCNaMe6zACOs/9A0/RGYMbYtQeey7aNpPX7i/2R3A==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4haqda06ub-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 05:04:28 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-3425098ae4bso2542961eec.0
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 22:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792040668; x=1792645468;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5XMXUIyGvYzXVbV8dr6KfkgMoJ37rILtMite2EjZuO8=;
 b=Q9vVS3Aww2FtUVQB+alt0ZV8B5DY0LV5u9LpqoDvgIqrQ1xdh25M0aHCp0Pf8vJf3q
 Rvuh6rCnaT/P+HK9ckMtQU2b2Mh9hh/TubqUzUS7riYKgTosJbe0y1d3cmfWhDQIMb9Q
 K+zRxJ5xbUQD1qiMVE+s8W4Z9ZT9XSvUldHrxTElj5NaIqKh94hoC7z2fu2NqzKbZBXq
 Kpc+gZTmR7Qg1oPMjMgX2F/Jsft+ApPEyteWelm7INie15Vma2MRWoCcad8LbcOo4oz8
 twrATg4Wm2zXFTJVdTCvtv6zsxNMMp8tJtntI47/e9n/ZYWuG1BX79aQ77MT+rBJww1J
 rytw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792040668; x=1792645468;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5XMXUIyGvYzXVbV8dr6KfkgMoJ37rILtMite2EjZuO8=;
 b=whmUmoalpyHzPEApZup6LeNBrYNs4lY9Kz0bZaDKnw4MW06b2gVlQ0M9/7Co25FtsM
 gqx8ER1YitbVP+orweqg1r3PzGGqdX+Edzzspp76yyrr85fpfmH0iyaeT79pSPLZEBc6
 x+x9u20chKvnb5MCN0Y11Rdz4j4Ewx9wnjVSz+l5gwpNKfzLq+2YxOKtiHf310tMBpSa
 SH/3ueX9qjjksxJU4K677nR0+pD0mnynV6gdNxKcl/8nk98on+ERC5NnsuUFVpBNRUbr
 zhrTC6Up+iZbwS660KKyOiq6yhxUwhUxlhRMbFcLDhAr3SbbYef/5WEfZCtgpSs3sBgH
 ilag==
X-Forwarded-Encrypted: i=1;
 AKwUvBwDiZ0GQRTuTcxJxfollcvTy91eHMIEJoXkgfSaeS19SNhefSN6WXyQEiQujqei7KJd2ys8094=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYI81u5jXU0Ozs9xW/GpMVFJNF2NVUIz5I+I9c7St3c3zRe9R6gt
 dm1IjES98ff/GR01rASygjd+zE67i6NURZPP2bWzORoCScSvBN6TggVKA1Y1YrWZuk5CL6WX3nn
 jygrZ3dx82O4BQQFu9KuuYiS9/sSb7OL0UabJ9acrUCl6efrQUY2xGPpxPVj2JwxzJISfuGI=
X-Gm-Gg: AYBFou2IrMQm0/OaiCBEqQbC9QomeE9N9paexOVGuaiaawU+i/WCEAg+NwfaHMER0Ce
 ZgRSlni5X5Dn0mr2/01lfMXmuffcsLVxj/QSm02ZvgONtCGrsdhbpB6+b1RF+p9AskhMuVWjLwN
 ykJUEvAUjelCwlh8DgRLmxxuqyhcuHDrBBsUdLtP87DlLxaEgkcN5eGzHO70j9geRt7NNnCLLSM
 3CigPLJBkoUszlZdh2LIuV37E+wFgkxiBOMGTT1PeZFUKZwegAP/iRdrt4ycCe6+PxHQ2oAO91n
 1zToB7kn/J8uCBe0i4VJ8yy1zcCrn9I5ZqMcmfY1RFstb/s3tkhMNSLrv9YuWjqGH/v3OJfWJnY
 tPC86OVCxkV+pZUNeEyxrcOars44ULk1b8T9cdncHG9LFsAoRHXyn3W8PbH89YwMxqiX2PDrEjh
 o5ahTrKafi2WbZ/sNLz8aaA0G3JMwUUw==
X-Received: by 2002:a05:7022:f50d:b0:17b:d4d5:7434 with SMTP id
 a92af1059eb24-17bd4d57ac6mr7516664c88.6.1792040667497; 
 Wed, 14 Oct 2026 22:04:27 -0700 (PDT)
X-Received: by 2002:a05:7022:f50d:b0:17b:d4d5:7434 with SMTP id
 a92af1059eb24-17bd4d57ac6mr7516632c88.6.1792040666742; 
 Wed, 14 Oct 2026 22:04:26 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-35b29c2f861sm42731105eec.11.2026.10.14.22.04.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 22:04:26 -0700 (PDT)
Date: Thu, 15 Oct 2026 10:34:19 +0530
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: Abhilash V <abhilash.v@oss.qualcomm.com>
Cc: trini@konsulko.com, ilias.apalodimas@linaro.org, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org,
 aswin.murugan@oss.qualcomm.com, Michael.Srba@seznam.cz,
 kr.sowmiya@oss.qualcomm.com, sjg@chromium.org, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v1 1/2] cdt: enable CDT for Shikra SPL
Message-ID: <atBe05SyavP+O9Gy@hu-varada-blr.qualcomm.com>
References: <20261014125125.711084-1-abhilash.v@oss.qualcomm.com>
 <20261014125125.711084-2-abhilash.v@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261014125125.711084-2-abhilash.v@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDAxOSBTYWx0ZWRfX9L/pJTx3tOoy
 zjYij4bAn3jHlrzDvG4bGHL3M+TnVEH/ljZ4b/CYixUq+ZqiMCSuu6KFxHBwwGJy2sqmd9vOkqk
 dBEmLcL/1+Lq6IuBmkEZpHVsPd40cbE=
X-Authority-Analysis: v=2.4 cv=K9u3jCWI c=1 sm=1 tr=0 ts=6ad05edc cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=2ziNnCcEu-lzFoaE8qYA:9 a=CjuIK1q_8ugA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: GgTJbkiJwaw52-lLjjqgpgZSLLPGAcGY
X-Proofpoint-ORIG-GUID: GgTJbkiJwaw52-lLjjqgpgZSLLPGAcGY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDAxOSBTYWx0ZWRfXwUfntmmQse/F
 UDcY14up3mKILFww3OpR0fxDUUhrTuxlWn9cSbQY1zpCMnS45MYqJ9i8EV5aMn00+DLsinh0D/N
 +u6uHdk7uAYBfz42wPul8Xipjlx8EAZ2xraroWDChaEGf/nvQrlwWfTbeSvCm4BjF7TnFYBl8Cz
 fncDrfzctj+7HPLeWEHpMvk2SGp28+jfO5bRwkyLamOZt2fbCW9c952tVfQVXFmNTNIU+cVqRow
 j2+MCaC2gVlOGJoCL/GHZPO0sbwczTLXZ7jXbsrcgtArO2AjobRqeHQvWS/u9ioQz2xqktvOzdA
 lFuThODmsS9E881BveI3/KY2GsUCFnAt4ZCz2F/9QPQZ24MRxM10QFTKW4K2OD5BRbEmH8N5beM
 8x28m1E2v+PbE4HKHlZrirDYpZOQX3OrOdaa6Fyo6z1G4idiTE6v4lfhetjn6gyM5/V+lBqbTzk
 u9eHLO44ZSPDMIrw9og==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 phishscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150019
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

On Wed, Oct 14, 2026 at 05:51:24AM -0700, Abhilash V wrote:
> From: KR Sowmiya <kr.sowmiya@oss.qualcomm.com>
>
> Add support for loading the Config/Chip Data Table (CDT) from eMMC
> during the Shikra SPL boot flow and registering it with QCLIB via
> the interface table.
>
> Signed-off-by: KR Sowmiya <kr.sowmiya@oss.qualcomm.com>

Add your signed off by.

> ---
>  arch/arm/mach-snapdragon/board_spl.c        | 96 +++++++++++++++++++++
>  arch/arm/mach-snapdragon/include/mach/spl.h |  1 +
>  arch/arm/mach-snapdragon/qclib.c            |  8 ++
>  board/qualcomm/shikra/spl-shikra.c          | 15 ++++
>  4 files changed, 120 insertions(+)
>
> diff --git a/arch/arm/mach-snapdragon/board_spl.c b/arch/arm/mach-snapdragon/board_spl.c
> index 31a06b1e002..725d0cfd1e6 100644
> --- a/arch/arm/mach-snapdragon/board_spl.c
> +++ b/arch/arm/mach-snapdragon/board_spl.c
> @@ -10,6 +10,10 @@
>  #include <dm/uclass.h>
>  #include <hang.h>
>  #include <init.h>
> +#include <linux/kernel.h>
> +#include <mach/spl.h>
> +#include <memalign.h>
> +#include <part.h>
>  #include <linux/err.h>
>  #include <mach/qclib.h>
>  #include <spl.h>
> @@ -38,6 +42,98 @@ void __weak qcom_spl_soc_rpm_reset(void)
>  {
>  }
>
> +#if IS_ENABLED(CONFIG_QCOM_SPL_CDT_SUPPORTED)
> +/**
> + * qcom_spl_cdt_load() - Load the CDT from the boot medium.
> + *
> + * This functions read the boot medium for CDT information which gets saved
> + * in IMEM location.
> + *
> + * Return: 0 on success, or a negative error code on failure.
> + */
> +int qcom_spl_cdt_load(void)
> +{
> +	struct blk_desc *desc;
> +	struct disk_partition info;
> +	lbaint_t blocks;
> +	bool is_mmc;
> +	int ret;
> +
> +	ret = qcom_spl_get_boot_blk_desc(&desc);
> +	if (ret) {
> +		pr_debug("CDT: boot device not supported for CDT staging (%d)\n",
> +			 ret);
> +		return ret;
> +	}
> +
> +	is_mmc = desc->uclass_id == UCLASS_MMC;
> +	if (is_mmc) {
> +		ret = blk_dselect_hwpart(desc, CONFIG_QCOM_SPL_CDT_MMC_PARTITION_NUM);
> +		if (ret)
> +			return ret;
> +
> +		part_init(desc);
> +	}
> +
> +#if defined(CONFIG_QCOM_SPL_CDT_USE_PARTITION_NAME)
> +	ret = part_get_info_by_name(desc, CONFIG_QCOM_SPL_CDT_PARTITION_NAME, &info);
> +#elif defined(CONFIG_QCOM_SPL_CDT_USE_PARTITION_GUID)
> +	ret = part_get_info_by_type_guid(desc, CONFIG_QCOM_SPL_CDT_PARTITION_GUID,
> +					 &info);
> +#else
> +	ret = -EINVAL;
> +#endif
> +	if (ret < 0) {
> +		pr_err("CDT: partition not found (%d)\n", ret);
> +		goto restore_hwpart;
> +	}
> +
> +	blocks = DIV_ROUND_UP(CONFIG_QCOM_SPL_BOOTITEM_CDT_SIZE, info.blksz);
> +	if (blocks > info.size)
> +		blocks = info.size;
> +
> +	{
> +		ALLOC_CACHE_ALIGN_BUFFER(u8, blk_buf, blocks * info.blksz);

Do you really want this? This will allocate the buffer on the stack.
Can malloc_cache_aligned() be considered here?

> +		size_t read_size = blocks * info.blksz;
> +		size_t copy_size = min_t(size_t, CONFIG_QCOM_SPL_BOOTITEM_CDT_SIZE,
> +					 read_size);
> +
> +		if (blk_dread(desc, info.start, blocks, blk_buf) != blocks) {
> +			pr_err("CDT: failed to read CDT partition\n");
> +			ret = -EIO;
> +			goto restore_hwpart;
> +		}
> +
> +		memset((u8 *)CONFIG_QCOM_SPL_BOOTIMEM_CDT_BASE, 0,
> +		       CONFIG_QCOM_SPL_BOOTITEM_CDT_SIZE);

Is this needed? The next line will overwrite everything anyway (unless
copy_size < CONFIG_QCOM_SPL_BOOTITEM_CDT_SIZE).

> +		memcpy((u8 *)CONFIG_QCOM_SPL_BOOTIMEM_CDT_BASE, blk_buf, copy_size);
> +	}
> +
> +	ret = 0;
> +
> +restore_hwpart:
> +	/* Restore the default (user data) hardware partition, if eMMC. */
> +	if (is_mmc) {
> +		int rc = blk_dselect_hwpart(desc, 0);
> +
> +		if (rc) {
> +			if (!ret)
> +				ret = rc;
> +			return ret;
> +		}
> +
> +		part_init(desc);
> +	}
> +
> +	return ret;
> +}
> +#else
> +int qcom_spl_cdt_load(void)
> +{
> +	return -ENOSYS;
> +}
> +#endif /* IS_ENABLED(CONFIG_QCOM_SPL_CDT_SUPPORTED) */
> +
>  /**
>   * qcom_spl_get_boot_blk_desc() - Get the boot medium's block device.
>   * @descp: Set to the resolved block device on success.
> diff --git a/arch/arm/mach-snapdragon/include/mach/spl.h b/arch/arm/mach-snapdragon/include/mach/spl.h
> index a32a85c48fd..ed3e5910e7a 100644
> --- a/arch/arm/mach-snapdragon/include/mach/spl.h
> +++ b/arch/arm/mach-snapdragon/include/mach/spl.h
> @@ -12,5 +12,6 @@ void qcom_spl_malloc_init_f(void);
>  int qcom_spl_loader_pre_ddr(u8 boot_device);
>  void qcom_spl_error_handler(void *arg);
>  int qcom_spl_get_boot_blk_desc(struct blk_desc **descp);
> +int qcom_spl_cdt_load(void);
>
>  #endif /* __SPL_H__ */
> diff --git a/arch/arm/mach-snapdragon/qclib.c b/arch/arm/mach-snapdragon/qclib.c
> index b9a74863c1c..16308e0e77f 100644
> --- a/arch/arm/mach-snapdragon/qclib.c
> +++ b/arch/arm/mach-snapdragon/qclib.c
> @@ -123,6 +123,14 @@ int __weak qclib_populate_interface_table(struct interface_table *if_tbl,
>  	if (ret)
>  		return ret;
>
> +	if (IS_ENABLED(CONFIG_QCOM_SPL_CDT_SUPPORTED)) {
> +		ret = qclib_add_iftbl_entry(if_tbl, CONFIG_QCOM_SPL_CDT_PARTITION_NAME,
> +					    CONFIG_QCOM_SPL_BOOTIMEM_CDT_BASE,
> +					    CONFIG_QCOM_SPL_BOOTITEM_CDT_SIZE);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	return qcom_spl_soc_qclib_override(if_tbl, fit, images_node);
>  }
>
> diff --git a/board/qualcomm/shikra/spl-shikra.c b/board/qualcomm/shikra/spl-shikra.c
> index c2a5d2d692b..98912493c88 100644
> --- a/board/qualcomm/shikra/spl-shikra.c
> +++ b/board/qualcomm/shikra/spl-shikra.c
> @@ -12,6 +12,7 @@
>  #include <dm/uclass.h>
>  #include <init.h>
>  #include <linux/err.h>
> +#include <linux/kernel.h>
>  #include <linux/sizes.h>
>  #include <linux/string.h>
>  #include <malloc.h>
> @@ -333,6 +334,12 @@ fail:
>  		reset_cpu();
>  }
>  #endif
> +
> +/**
> + * qcom_spl_soc_qclib_override() - Populate Shikra-specific interface table.
> + *
> + * Adds Shikra-specific blobs/entries to the QCLIB interface table.
> + */
>  int qcom_spl_soc_qclib_override(struct interface_table *table,
>  				const void *fit, int images_node)
>  {
> @@ -381,8 +388,16 @@ void qcom_spl_soc_shrm_reset(void)
>
>  int qcom_spl_soc_pre_qclib_routine(void)
>  {
> +	int ret;
> +
>  	qcom_spl_soc_shrm_reset();
>
> +	if (IS_ENABLED(CONFIG_QCOM_SPL_CDT_SUPPORTED)) {
> +		ret = qcom_spl_cdt_load();
> +		if (ret)
> +			return ret;

Just 'return qcom_spl_cdt_load();' would suffice. Can remove 'ret'
declaration also.

-Varada

> +	}
> +
>  	return 0;
>  }
>
> --
> 2.34.1
>
