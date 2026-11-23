Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F58606A321
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 16:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=VCJhlTqQ;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=BF/+LMM0;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Tg000h1G
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E778180C76;
	Mon, 23 Nov 2026 16:19:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0MqSqAg7oQwb; Mon, 23 Nov 2026 16:19:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E9B1E80C3F
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795450750;
	b=TAvG0Xgbzd1Zbr7fpBLxkUEt1Nift8IrZZxjmVpbjE9teybzJw8x7H+UUiPijpc6d7Ch
	 mOeWXddBRTCCfNT8WwXeEopiGwXqegV9DlxrXa/Ikx2XJ4faTpldbbNYFGgPaoj7d2+cl
	 MhoomWuuv9EjoBbgTQ85FoayR7s2rNcH65svb8JmIB755zPMIYkdEZh7SLMdcRQ/YlGJt
	 AaDOhrFEX7thRZiY9jXMgND6aNX/SD+JffUVDUM/9xGRp2rJ4TchA6p+CJCDxPPXVLIfL
	 jFdGWY5wRD29LB0AWZvwrJJt493ULeb5cVSb5YeMumvaYIZwWP+39pmDEgbKoVwVHbQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795450750;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 From:To:References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=2esBZ5FIu0hU9Kdowx859Lcp5chDLU/9b6O6Jqg7FS8=;
	b=dRmDB4HYI2A/kk2UTbBg1rpqKlr9w3Dro+jMA9zv4tYVzaPcHGAyGsvVz5BqWLYCvLwY
	 tP/zoPJkU3sPb3kY1s7zm9NOnm9ZY0ODe9ywWEijxKpR3IhG604DpnaKhL4erZGVkUoU0
	 qje5Mt5bYW4lUR6vVZ/EXDFZAVHOh1ZMtw3xdYNoTwD35XqT26crGZXS7QCNGUjx8P10W
	 wC7+tcsUj14Waf3gPtqwwSQgOsst1GnCcCpB5EXohbh7L2iRJG/8bYOFTtQCI2MII4t4i
	 6El4/fuWAmQnQYNP3bkKQEG/lBWFS8iFWA9wV1GA6DYpEcZuUKh2OaPEZw12HOkSunw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="BF/+LMM0";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Tg000h1G;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795450750;
	bh=2esBZ5FIu0hU9Kdowx859Lcp5chDLU/9b6O6Jqg7FS8=;
	h=Date:Subject:From:To:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VCJhlTqQWw2SiE+jY+f4FZ2FzaQGpTqvleeE0kz7sUXns6CPuQDvYS4bNFo8Qx803
	 8Za82hxCVVX2w3b6dkxi8ZJQLVbUAmX8hNbOBmb1jhPwfDPK8tBRFP4Z+G8TnLK6lH
	 7JfBdHjBR9UdD5T8O3KOxFTZB1ElHmjQ/t/mDhjw2Cpeym69ysSBA/Kxdg97XffdWG
	 Bb6Rz+ZXgA8aQZynmHG03nrXttHdQgKLIec7PNH5RHcpEY51ck+sX/DfpODeZP6L89
	 QERFhmH2nYoejYe0m8x4HvCCwDN/bTWmz8+ioq+6x+iUERTnpN+zi36uCGFdp2nn0x
	 WtR9LZxsmpLEg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E9B1E80C3F;
	Mon, 23 Nov 2026 16:19:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id D1AB015D
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 16:19:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B750A80C3F
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 16:19:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id f3P_QmBDxrLa for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 16:19:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1427980C35
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=gopinath.sekar@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=BF/+LMM0; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Tg000h1G
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1427980C35
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 16:19:06 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ANGI0vK236158
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 16:19:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 2esBZ5FIu0hU9Kdowx859Lcp5chDLU/9b6O6Jqg7FS8=; b=BF/+LMM08vcJzRUr
 OX1fkCtvSVCn34jeQ46011lIVSYSqB70N7RKOjUaLEJyRJDPekMVsh8Yn9DEjdAl
 5wZuSA9j8TE6RqVs1HH+dtK2ZcVJGOic0LHZYf2coRIJO4OJE1/LSPXw+L3X+nIR
 Dy9t/rGA0oOJw2T/yQwdAvHgvUin4dr7RoqEXJ0IZ2zz5HDVFrRH+cqYChlPWVed
 9rjw/tHlkFI+CaaWjF2HjhFv4VlKv/txNkxgwJbEm9mqtnjVaB8vj7SH+matDPAn
 czno0PavRJ4IoOBJ33Ma49/p6CqTI7TUgEYrI28fxyHqO2Lc2eyacaWGc/okI+dD
 t2E6hA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4evsjgp8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 16:19:05 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-339628f2bbaso347096eec.1
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 08:19:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795450744; x=1796055544;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:to:from:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=2esBZ5FIu0hU9Kdowx859Lcp5chDLU/9b6O6Jqg7FS8=;
 b=Tg000h1GLqVDOBEbBhNBuxT2zWCoy3PXVA0sGQVhYP2lRWCEyTDxvrq1Z5utNM53WO
 Z4EFcTIRtG8bFnBGGxQvv5kBGjKvOEhdDo/L2TPujwDWnmQGPchEvMf3ElT7k35icDjS
 nMKjsSnu2uZQts4thBO8fog0st5mCiMjVHUahcunHq97xoxJoTJNryvMq0uVvUjV8RvJ
 2+PvUev1VF78URIwXi0qIVHw0ncmjUDvReFjtN6OEi8Vk2NWsAj29OD4/NSXZS3zdwaG
 3yKUDBVhm8vKe6vE1aVweS24MAW4DqwJCaV9sFUT1XnY1eoPgMn+grVOY58Sp6Lbkp5R
 jATg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795450744; x=1796055544;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=2esBZ5FIu0hU9Kdowx859Lcp5chDLU/9b6O6Jqg7FS8=;
 b=1es7weGenOFaaALfxQuRItnBeonRBW4ZruBuqJJcblAmK0OeJWI7ewx5WT7K1VT/Ts
 XGDSmouSm6Y0PGsqhtfFyi+7TrLFElTNL/MNRFQuMdQpnaebNzPOejFcCWkFOJ30VC91
 BGbU5uIyd4Ebd1Tb3a0mqiXpePmnDM4zlycubtzfb/0jp1G5rE3ucDPaVMqvvTUBHBtk
 RJRQEI/YhiAin4eM4e0zr0mZ4LBZWj7dxgob+C2nvQCtLQxl/j1FQ1+8uaMrhem7Y2dH
 7xBgCSiHELxxGhh8OFgSZwhwdbSAPwomJm1tjkjSgJOcfWPpwZK1qQ8kU6K/IrBlKAUn
 rVtg==
X-Gm-Message-State: APuU4Z/6rQSFW0yVlre6dsOPnRcHOgQaXTf813jOWxh5uLvFsKXqv1Vt
 etI/YJDsCOKuMpm+sKCy5ZoD/IZdpwG0tf1HAKDaTt9YmFh4fXhzLSDiHCXdBN7mQLHNw2g7a2i
 XS2plNONbrqwcA811+h6eyYkylLbbnWA4fhuRgEYJcJkbGCRQgRtFxDE2kNO92802boV5uFeU+/
 nS9+s=
X-Gm-Gg: AZFdTZe/XkyYj7Eat/OuYN826l25MLSJ7tisgW8aqr9aqkJBgb/3CdrKyGLCQhT07l2
 3Okq9vwbucP548qHhwo1LyEeT3G+zAMbLvHb5xhIztJLf32V/Gqn/HwUb9xHNFeWegVTY9W7QnF
 9vPqMkz7gc168L0ltZcaHV5ZTJZ1AGbtCntdPffJiEiwzgU0pmc95HVHukfja6QQUxy8QG5BUfm
 Lc78lihZvngU3QF/FhMq7PVmUwKWr4VutEHO0t6eM6kZg8uJooNEXrbolAy+T8rl6EKX3GmJ3gJ
 yLzUH//eni0tF5YzECGHaOWe+hWNIpwaKzkhOA5PnEziC3NQ4eaZZA3+ZbtJYiKnK/nsrAtQE9U
 mu4uxRUZWrJG1vDg9465tIAGvdlpc+F6b/ncnKVgs1O3r8Qx7VJzl7v6GVTa2qfVmtQaDpqfdc7
 48bjOJrA==
X-Received: by 2002:a05:7300:caa:b0:385:4627:bd5e with SMTP id
 5a478bee46e88-3856ec46bccmr24885945eec.2.1795450744320; 
 Mon, 23 Nov 2026 08:19:04 -0800 (PST)
X-Received: by 2002:a05:7300:caa:b0:385:4627:bd5e with SMTP id
 5a478bee46e88-3856ec46bccmr24885902eec.2.1795450743759; 
 Mon, 23 Nov 2026 08:19:03 -0800 (PST)
Received: from [192.168.1.3] ([106.219.178.136])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-386992b404bsm26275921eec.1.2026.11.23.08.19.02
 for <u-boot@lists.u-boot-project.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Nov 2026 08:19:03 -0800 (PST)
Message-ID: <f93867a0-0940-41a5-a5b1-a092d76eb1dc@oss.qualcomm.com>
Date: Mon, 23 Nov 2026 21:49:00 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] clk: qcom: sa8775p: add SGMI reference clock
From: Gopinath Sekar <gopinath.sekar@oss.qualcomm.com>
To: u-boot@lists.u-boot-project.org
References: <20261121063919.3313168-1-mmanikan@qti.qualcomm.com>
 <20261121063919.3313168-6-mmanikan@qti.qualcomm.com>
 <93974190-f499-4873-a7fb-b00b1c2bdc04@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <93974190-f499-4873-a7fb-b00b1c2bdc04@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=AL9GXjHq c=1 sm=1 tr=0 ts=6b046779 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=jCNHygwvtdUFbBAtyvamYQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=x8XOHHbUe3aQP7JscPIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: 5oMdJv76bDeMmD1RPNhlZlHbW5BqP1PH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA2NCBTYWx0ZWRfX3BkyyFRtXjsi
 qgg4IHzXr94SIRqYnWOKRuxAyrI7FZdflKSHA33yN+p0MqcF0pNsYlZgGsuw+DMX1Fj46iA6mJ3
 1bUdx83bImcA5uJHTv/YV7IaF6ZT07f72jiadayuTF2gQ51a9I+RCZJtVG3qIwHzzYMmTY5jHOG
 5MBDUDhh22vq9BE3iM+8Tl+m3X1oSEViJ7WQjD0CkZFcL5zum2kNEIoslPaNlsJxxzJfIpL8I4C
 KfBy7+mTjC4iNmXfJqG8ikOowRlh2ty6/Pta6nSWqnJ/GM0ue142wdNu9zJr3Sfjh39mnp7jFU/
 2Q9cakPm2X202AgBv+s8fIXg9h6BvTn2+wa+EuM6WAFRrYhd5kr/A+wYXp6ns8859g/DN9S17In
 6OtzfRejtGApYU97T8MQS6nmQRy1yAFFSxLdos1SLvCvjtmPqWqHcb3qa/GVAqGpTD2Xpy6jzRb
 Cj9EIffNB1DGcXthMIA==
X-Proofpoint-GUID: 5oMdJv76bDeMmD1RPNhlZlHbW5BqP1PH
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA2NCBTYWx0ZWRfX7kQuHDntfA5B
 YH7tcSjUXQNqnFQE2u+wSbSRavMGgnyMYdZ+OS+iSIzCED1NLOPGEsq9ztEI+4L/CDSAUY8og+L
 Ybn/kTRNOXptTVMSuisvj2s0j+f2KXU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_04,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 phishscore=0 priorityscore=1501 adultscore=0
 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230064
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/23/2026 9:04 PM, Gopinath Sekar wrote:
> Hi Manikanta,
>
> On 11/21/2026 12:09 PM, Manikanta Mylavarapu wrote:
>> From: Manikanta Mylavarapu <manikanta.mylavarapu@oss.qualcomm.com>
>>
>> The SA8775P DWMAC SGMII SerDes consumes GCC_SGMI_CLKREF_EN as its
>> reference clock.
>>
>> Add the SGMI clock reference gate so the SerDes PHY driver can enable 
>> its
>> "sgmi_ref" clock during power-on.
>>
>> Signed-off-by: Manikanta Mylavarapu 
>> <manikanta.mylavarapu@oss.qualcomm.com>
>> ---
>> Changes in v2:
>> - No code changes.
>>
>>   drivers/clk/qcom/clock-sa8775p.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/clk/qcom/clock-sa8775p.c 
>> b/drivers/clk/qcom/clock-sa8775p.c
>> index fd495b73635..65f8bd42a15 100644
>> --- a/drivers/clk/qcom/clock-sa8775p.c
>> +++ b/drivers/clk/qcom/clock-sa8775p.c
>> @@ -227,8 +227,9 @@ static const struct gate_clk sa8775p_clks[] = {
>>       GATE_CLK_POLLED(GCC_UFS_PHY_PHY_AUX_CLK, 0x830a4, BIT(0), 
>> 0x830a4),
>>       GATE_CLK_POLLED(GCC_UFS_PHY_ICE_CORE_CLK, 0x8306c, BIT(0), 
>> 0x8306c),
>>   -    /* EDP reference clock (used by UFS PHY) */
>> +    /* Reference clocks */
>>       GATE_CLK_POLLED(GCC_EDP_REF_CLKREF_EN, 0x97448, BIT(0), 0x97448),
>> +    GATE_CLK(GCC_SGMI_CLKREF_EN, 0x9c034, BIT(0)),
>
> Can we use GATE_CLK_POLLED? for CBCR backed register.
Please disregard my earlier comment. GCC_SGMI_CLKREF_EN is not 
CBCR-backed, and I noticed that GATE_CLK_POLLED is also used for some 
non-CBCR registers in this file.
>
> Thanks,
>
> Gopinath
>
>>         /* SDCC1 clocks */
>>       GATE_CLK_POLLED(GCC_SDCC1_AHB_CLK, 0x2000c, BIT(0), 0x2000c),
