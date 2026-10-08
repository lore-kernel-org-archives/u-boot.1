Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA31CCA6007
	for <u-boot@archiver.kernel.org>; Thu,  8 Oct 2026 09:49:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E0C4581214;
	Thu,  8 Oct 2026 09:49:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YW-J5JbajMkf; Thu,  8 Oct 2026 09:49:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org F262E811F7
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791452972;
	b=Ab0VQ8YAYlNTUMMBqy4HJW4Y7G2J5HhiibB1Ll9y2pTxGvt3WKlfVIDiBy8nAvxhjpzm
	 UAADwmdzR4m979+kr7VAqRhlwFZcf3iAEw6uL+5fwaGeMOhE3a3jiRsZQEYSHrd6kBdfE
	 grfvx9YbEvZIRJWVM29lJEMKOI9g9MKArUa+kPpOIQmN4VizPK3O7dhIYOyaqYhvVVBI0
	 kMFZ4ngdqkkX7adeqchS9/MSS7meryNJsF1xmOHrsqXcx86uZjYTg5rXwb0IoFTjZuLFz
	 iQB25bhsLzD3ix9MCm3sNVcff3ebUluv+6lQGCFILEDejxKigBAuRMH9sC9mkLpkTDw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791452972;
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
	bh=8k212rEkKH7as2DJYDMhPKfi/pS96aKEPLzyjPXI6EM=;
	b=Rgbla+/V93AQvANiPM9lpNDV4ve9fXFSEaYg+J++Nt6I0/FlCtbitKHgFB386h1dg1Zi
	 ulkJ7bBS1B/fmmpk20110ElsEPv8JKqIzhu/qwJXrZbQS/WZlRZcebNDmbIMk2jvliI+2
	 CeNMneCEm/K3NNzTKewrqsdgjXojCU3bTBwcwrgaWTIIdit/2vqnFdJrbK+MET5TAF4iE
	 Eeu7GLSv9myqKco9RrCCKV13Qu+A0EV0I+tdD2SMhzDjhKFlw0UW5IEVxhTgyaahJbM06
	 MBnHTYbDkY5N/RYCRL3eXrbNbQQwUOHoYbRp6US3dkbc4b7g7VQRvJUr3i3OYQyS2Iw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791452972;
	bh=8k212rEkKH7as2DJYDMhPKfi/pS96aKEPLzyjPXI6EM=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yQJ5opdJjxnW5PbJ301S0iODBptxKGFrEI/LZH1zo9zYjYdxfb9nAmVkpO5E8hkXM
	 +sVRkS0yzil5254Zc2q8h6WkBrqSx35l4P6+S595ONsYRlQLwND0Hc6TO0V9ng8i3t
	 u3mx7l0AQxw/NI1f2NTAFswWp23MydxDWp3hd0uyHigf75vol1ounCqiJiso8SC6+Q
	 DyYZTQPMTUfcN3TfADTExk+eMEVK18MWXjkrIBXDIErG6O2S8DRvGpn1b1J9zRs+0L
	 e1Lpr3N7BowzMoUvSLzL18C4ZWwHln9lkSx5LeWXw7vAPouFUnWG/qqjDDzUCUFjMy
	 7Qqb8pK9WEuKw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id F262E811F7;
	Thu,  8 Oct 2026 09:49:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id DEA1922F
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 09:49:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D064A607FA
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 09:49:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lQnsFp7NUOxH for <u-boot@lists.u-boot-project.org>;
 Thu,  8 Oct 2026 09:49:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 0B93A607D7
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791452967;
 b=WnqKgsVMfehmwZ5Fg3joKLmZd7T70VXOQ5fFo0+VSH4ByuNg/3WdZMRE1NR9jfaifaN6
 pkj3788Bz99HGSjrsjrKIreXC631wmGJR5qLPflfYLRtmuDLAL2s5hDh1NnrK2S/3xFY5
 /r1K4me8jrMJD59SdlBCrU8l+S/+tjTFkmrZ5FZpdwfQmBr2N1oFz3q5YrpB+jTzgWRl0
 2L6I/HWVMQcy4fsGOwxOCmgLKKarc5XL7zRlktZVHR62JpUUxdUU5+jRDaQy2pieDffos
 fOqCuDhz1sz1ftIwy10od9G24vebtrMYGOo7vz3LbVjG3m4XaCLtdJcSbWayPJfImRw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791452967;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-Spam-Info:
 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=8k212rEkKH7as2DJYDMhPKfi/pS96aKEPLzyjPXI6EM=;
 b=CpvXsPqldkcC4N/Wud4yXQplTjw4fEfDLGmeuYogC99UE7cpk1NyjGkQLYIZj6/fhDd+
 jitW7tGmooVdlL/LzU+piDri1iNrteDGsZYOPCOgcFCmma8zH3ZAWdHBZzpL7208Rc8sg
 cV0y0W4EoxHucWNaI7tI/EkFO1QMFGoMR9/D33Lav8LbcRU4m6L/Gf9qwtyE+lN7ZQgol
 POqnihGdmgXEvxMRdgY4ExrrjfSmy1UE03u9skXcVOQn2JRmxslMJo0KpQTBVUIBTg4A3
 ZRsfMatW0uHH+QAnSK3aomIN88faPNxNdRESH0JSrBI9sWlpV3jslESeU6UPCxj4ejQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=aWNDmSNB; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=BFSkGwz0; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=abhilash.v@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=aWNDmSNB; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=BFSkGwz0
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0B93A607D7
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 09:49:26 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6987K4T72189845
 for <u-boot@lists.u-boot-project.org>; Thu, 8 Oct 2026 09:49:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=8k212rEkKH7
 as2DJYDMhPKfi/pS96aKEPLzyjPXI6EM=; b=aWNDmSNBR914fLlfnQZLDUZdXXI
 oo7/Zj/saqflB4EnMnxOE2jesdm+50X5ssZh7vRGReUmwUuzJXlUqq2aYSzKT/bc
 COeNuB6IWbDoYfk/zwlI9o6cWUsC2MKnF0TTHlwRV2hlAdKWEKrpndDRV9HZijfr
 +dOdqbnykM3psWkTANatArCq0WdWBuWfP5tf0b2Ty1FWn4G6VpcX+l1Ymbgoip7n
 BWQZ+TUt1iB+yGh4ysv7xPCCKet/t8CwN4s/M8rCCjvJIzLdas5lrnnIFYRi1DZN
 fd1yXaWFqsB156x9ZeFt3x9ZoHORG36ycWEMrflwCb0NySZrgHsttmm38ZA==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5xe3a8cm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 08 Oct 2026 09:49:26 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-139b62317d0so17768783c88.0
 for <u-boot@lists.u-boot-project.org>; Thu, 08 Oct 2026 02:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791452966; x=1792057766;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=8k212rEkKH7as2DJYDMhPKfi/pS96aKEPLzyjPXI6EM=;
 b=BFSkGwz0ccRSAGTMMqHoklhduwxt6LTbrsEQTOOQqK4Oj23IcLuJEu2cG6CrZ4bD+i
 vihVCbHxiy+LQC53KitbI4VNsOBt5Qqa5l93daajsrEiz+tniGL5vUM6Ds0I03D4qMfm
 nQNO+WkuwGC5wZQeDVk+/LUvRokqVhs7iERdQ9RyhWkXk/mlVaRd2Nm3/Hk4W7sEeuPV
 32SOLowY1MBVFO/1zl4FQbUWdh1wJNScihE9Q3GvvnsTTh65X1os8TOOvoQGPwLAYNAM
 gvnt3UVS7ugkjg8WkzTDKku69zI4MKwVyWWhZci91LShfty+2YA06cltMcUAoKFDJ90m
 Ai4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791452966; x=1792057766;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=8k212rEkKH7as2DJYDMhPKfi/pS96aKEPLzyjPXI6EM=;
 b=ri3sxz5/3WH170/1oSgN8hhAh6DLpSwUGNKQJL/lR/sRNOGgZvEf7Mb3afVg4EejRP
 VSQB80fhILC9yihSOHiPdpgYi5FMiJ6/2znWkvY9Nuc44cK+DgD0Vsl+an613XYDFfUG
 r2tz6FBgg5NhTgFsKuAotygVNsQ4bUDnRFORw1HxI+sxT6p0jJ98yq0ooSKcCrTAdKdJ
 RoR8F//7uCA7juWaPHAqOtEpbNO/F2xpAgYYRRFZZ8U6j28yOJdaHSTyHDXHj6Rg87DJ
 kx/kU8NcK8H3C3ThQDhkO+ovSPFXrGmj9cqblxaQf8Q0pxTj6NIm5wIAfC5XTZTrLWnk
 UnQQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBx90wLnpPAgBm/kAUr/GbEkVsANwueE73MW9Ygki2TfF0d0mEiBJMNi1eJ8rgfPfkrpK36bg2c=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kuuJ+MVI+LT2k7Hg5ZYmNhTF5jIgGNgrQ9aU0LO9SlniqPYzBd
 zqzbtcLI6AsLT9GU7JqyZTAMRcpWzuIfseSISC3nIpL0UTrOMQqFwqexRvjpDk75LvioLyMtkXq
 ywdv3O06KC9avHFB06KKz+I7udNg8aZ1YjGddf2nedUtVC+vSsdztaHTKCkAv+F1l/IzHRPg=
X-Gm-Gg: AYBFou0Gqj1GD6CoDEcVdAsdbUDXJwUNWl7X4FAT6kk5CyucQ6L5M5VpuyJqclWwb8o
 XcFPDddJ/0zO0NAiV4r+lNq+b9XFlvlLZeBlXvwQRksZ4rmM4VMAdbutjQSjJYjd58p19gvQGvb
 cl1NgV3a7r6Sq09pa42zyyfKn7eWNy0tLlRGaMe+EIMH/KHj1MUQ7prUzlLgvYGzKRHHrXdSgpy
 a7ySMr2p+7mv4o6kLRbf/FMLRboBk4ejeJEshvuChf8zWTfYNnjbyTt8CgInObDkpTHZTzeXcwE
 9Dpb9C9S/pW//obtJvHn6a4SsPmTtlshmLfbKX8LiBL8eH0+piVXEUUXgdPJKMqyW48NISfOdW4
 ND1XkXdEFGnBIQ2D6+3V7OnJ/lmVb20QhVhmqX/phULq8VXg=
X-Received: by 2002:a05:701b:2204:b0:166:4b44:66e9 with SMTP id
 a92af1059eb24-1664b4467b2mr1884180c88.32.1791452965352; 
 Thu, 08 Oct 2026 02:49:25 -0700 (PDT)
X-Received: by 2002:a05:701b:2204:b0:166:4b44:66e9 with SMTP id
 a92af1059eb24-1664b4467b2mr1884157c88.32.1791452964799; 
 Thu, 08 Oct 2026 02:49:24 -0700 (PDT)
Received: from hu-abhiv-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-16375a1f898sm9977818c88.0.2026.10.08.02.49.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 02:49:24 -0700 (PDT)
From: Abhilash V <abhilash.v@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org,
 aswin.murugan@oss.qualcomm.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, lukma@nabladev.com,
 peng.fan@nxp.com, jh80.chung@samsung.com, tanmay.kathpalia@altera.com,
 abhilash.v@oss.qualcomm.com, sjg@chromium.org, Michael.Srba@seznam.cz,
 varadarajan.narayanan@oss.qualcomm.com, luca.weiss@fairphone.com,
 nikroks@mainlining.org, balaji.selvanathan@oss.qualcomm.com,
 jbx6244@gmail.com, u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: [PATCH v4 04/13] clk: qcom: add configurable FSM-voted PLL helper
Date: Thu,  8 Oct 2026 02:49:03 -0700
Message-Id: <20261008094912.419090-5-abhilash.v@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261008094912.419090-1-abhilash.v@oss.qualcomm.com>
References: <20261008094912.419090-1-abhilash.v@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=J4s/fwnS c=1 sm=1 tr=0 ts=6ac76726 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=enMxUgKZn3LVR2H3xcYA:9 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDAzOCBTYWx0ZWRfX6PUyoKpkhham
 /KkpiiYbSTF2NDTXAYDZiR/cok2WapakQM42wmOQaUQNfT5E9xevMEiDQOfC3yS6I0vPllhhzUx
 WofirFjd896xicYaIduow1gGkgaF2dE=
X-Proofpoint-GUID: _kvQju4_UDZM_K6jn8flPZD_c_fCmF5r
X-Proofpoint-ORIG-GUID: _kvQju4_UDZM_K6jn8flPZD_c_fCmF5r
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDAzOCBTYWx0ZWRfX/P82cFBs71wy
 /aasN2FU1aL8ZZxm8a4c2M+VwyM5kpVjqB0BmHoOFg29eTheOIOVJdfF+KA6u+n0QLccxc/Hb+U
 4fxbm4e7A5gKMmz7tAaI0xIQ2fErQn+SVvzSisDzGTfn+0uDvGvXBOgjxRGqJMjGSTBqKun7Zkj
 WIBYpzAFEUGFY45w70/kU1j2AHSvacFmBt/XFXA/Qra07GHWDVhGKhuortpeaYvdjeI1k5wtrn5
 +62SepWNFX/SzwxWkGDLDZcFJSA2twYLQTDb1LM9unga5yqYEbGIs+ICg2Kqsk8DRuVTKnqtzTh
 ImY+Nsv5vpk64tczhaFNx0RjN8aWBB1TsGgO4eUik1M0TRojpQw447S0W2jtq5Td/arOrViFC9p
 pWb2pghmi2gX0iSyvktfU8mMGVziT+d0uLi5//DVwQPJ72WCH2adSD4ANrYDQ/H4vxNG6JIv1gE
 Ba3KmdlV9xezH4USjUQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_03,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080038
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

Add a reusable helper to configure and vote for Alpha PLLs
controlled by the GCC vote FSM. Per-PLL register offsets
support targets with different PLL layouts.

Signed-off-by: Abhilash V <abhilash.v@oss.qualcomm.com>
---
 drivers/clk/qcom/clock-qcom.c | 48 +++++++++++++++++++++++++++++++++++
 drivers/clk/qcom/clock-qcom.h | 24 ++++++++++++++++++
 2 files changed, 72 insertions(+)

diff --git a/drivers/clk/qcom/clock-qcom.c b/drivers/clk/qcom/clock-qcom.c
index 6b46d9db744..30127c1fffe 100644
--- a/drivers/clk/qcom/clock-qcom.c
+++ b/drivers/clk/qcom/clock-qcom.c
@@ -59,6 +59,54 @@ void clk_enable_gpll0(phys_addr_t base, const struct pll_vote_clk *gpll0)
 		;
 }
 
+#define PLL_MODE_ACTIVE_FLAG	BIT(30)
+#define PLL_MODE_BIAS_COUNT	GENMASK(19, 14)
+#define PLL_MODE_LOCK_COUNT	GENMASK(13, 8)
+#define PLL_MODE_VOTE_FSM_ENA	BIT(20)
+
+#define PLL_MODE_BIAS_COUNT_VAL	(0x6 << 14)
+#define PLL_MODE_LOCK_COUNT_VAL	(0x0 << 8)
+
+#define PLL_LOCK_TIMEOUT_US	200
+
+void clk_configure_enable_pll(phys_addr_t base, const struct pll_config *pll)
+{
+	u32 mode = readl(base + pll->mode_reg);
+	unsigned int count;
+
+	if ((mode & PLL_MODE_VOTE_FSM_ENA) &&
+	    (readl(base + pll->ena_vote) & pll->vote_bit) == pll->vote_bit &&
+	    (mode & PLL_MODE_ACTIVE_FLAG))
+		return;
+
+	writel(0, base + pll->mode_reg);
+	writel(pll->user_ctl_u, base + pll->mode_reg + pll->user_ctl_u_offset);
+	writel(pll->config_ctl, base + pll->mode_reg + pll->config_ctl_offset);
+	writel(pll->test_ctl, base + pll->mode_reg + pll->test_ctl_offset);
+	writel(pll->test_ctl_u, base + pll->mode_reg + pll->test_ctl_u_offset);
+	writel(pll->user_ctl, base + pll->mode_reg + pll->user_ctl_offset);
+	writel(pll->l_val, base + pll->mode_reg + pll->l_val_offset);
+	writel(pll->alpha_val, base + pll->mode_reg + pll->alpha_val_offset);
+	writel(pll->alpha_val_u, base + pll->mode_reg + pll->alpha_val_u_offset);
+
+	mode &= ~(PLL_MODE_BIAS_COUNT | PLL_MODE_LOCK_COUNT);
+	mode |= PLL_MODE_BIAS_COUNT_VAL | PLL_MODE_LOCK_COUNT_VAL |
+		PLL_MODE_VOTE_FSM_ENA;
+	writel(mode, base + pll->mode_reg);
+
+	setbits_le32(base + pll->ena_vote, pll->vote_bit);
+
+	for (count = 0; count < PLL_LOCK_TIMEOUT_US; count++) {
+		if (readl(base + pll->mode_reg) & PLL_MODE_ACTIVE_FLAG)
+			return;
+		udelay(1);
+	}
+
+	WARN(count == PLL_LOCK_TIMEOUT_US,
+	     "PLL @ %#llx [%#010x] never locked\n",
+	     base + pll->mode_reg, readl(base + pll->mode_reg));
+}
+
 #define BRANCH_ON_VAL (0)
 #define BRANCH_NOC_FSM_ON_VAL BIT(29)
 #define BRANCH_CHECK_MASK GENMASK(31, 28)
diff --git a/drivers/clk/qcom/clock-qcom.h b/drivers/clk/qcom/clock-qcom.h
index 9899cd28aad..47930ae9d5e 100644
--- a/drivers/clk/qcom/clock-qcom.h
+++ b/drivers/clk/qcom/clock-qcom.h
@@ -36,6 +36,29 @@ struct pll_vote_clk {
 	int vote_bit;
 };
 
+/* Configuration for an FSM-voteable Alpha PLL. */
+struct pll_config {
+	uintptr_t mode_reg;
+	uintptr_t ena_vote;
+	u32 vote_bit;
+	u32 l_val;
+	u32 alpha_val;
+	u32 alpha_val_u;
+	u32 user_ctl;
+	u32 user_ctl_u;
+	u32 config_ctl;
+	u32 test_ctl;
+	u32 test_ctl_u;
+	u32 l_val_offset;
+	u32 alpha_val_offset;
+	u32 alpha_val_u_offset;
+	u32 test_ctl_offset;
+	u32 test_ctl_u_offset;
+	u32 user_ctl_offset;
+	u32 user_ctl_u_offset;
+	u32 config_ctl_offset;
+};
+
 struct vote_clk {
 	uintptr_t cbcr_reg;
 	uintptr_t ena_vote;
@@ -107,6 +130,7 @@ struct msm_clk_priv {
 
 int qcom_cc_bind(struct udevice *parent);
 void clk_enable_gpll0(phys_addr_t base, const struct pll_vote_clk *gpll0);
+void clk_configure_enable_pll(phys_addr_t base, const struct pll_config *pll);
 void clk_bcr_update(phys_addr_t apps_cmd_rgcr);
 void clk_enable_cbc(phys_addr_t cbcr);
 void clk_enable_vote_clk(phys_addr_t base, const struct vote_clk *vclk);
-- 
2.34.1

