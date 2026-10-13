Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B555CC6B03
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 05:35:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E0E0380C23;
	Tue, 13 Oct 2026 05:35:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5DxixFfPex1C; Tue, 13 Oct 2026 05:35:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2C07A808D9
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791869734;
	b=NEkO/KWGp8mqNvMtMZNv4hJyvdqXRfoBuPAldhPKttz8JDacei0MeJ/s6u/aataauddo
	 w9R8P5DFLwIWd15wb0AOCnaPblKvMuaITeR/+Iulk+TjAm6aGZK/YnojHu9LKNzRBx2LN
	 XoKRzm44wbYrI3utd+6e/WLB+Wpe4jd4SxoyKF+RAgZeLvQA6bSsysBZDJIoPET0HxcrM
	 pakPQVU8Unk0rAX4rnKQxjcKQtUQqJg3Z3V2O85dbI1Nn8qbyf5nEQUmCSaqXMnub6WZ6
	 PF+lWnm8m5NVnBrSDK/fRBUV7IUL53ZKXnNCXzH0ISs09vtuEIcxQmZYz7c+Ug0YzCg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791869734;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=VWuDDnKQ/kxwdTVkGwvcyzd5NbG/KQJZen2yuq3+LUY=;
	b=UL07YIFng83YIwieN3mGI7Unqn2KOD0iW3rVK5G5lToISwSYJLbPDb0Lq0nDRDv1qdvJ
	 +qnHbBxmppvJSwM8rLZtTAZ5bAQ1cWbDmx1IHnP/ELYo6BM5JaswpRjWPX+Zm0b/B02OW
	 6MZJgvNMunDrhgS9wGC77en8d/si/4H5ep1wCrbRA+K/zDRSfiLI3Z/6saK7P6YEylT+8
	 jS848W7plP7024JLUJjMsmdltohDU1b6BSN7w9Lgf8dvQM2stmN44MzQMFqUAIXT4wYCj
	 ZFRiD9thxGcFbpQiwdHpw1216Ppwwv04/hkX6EP/Iuj8eWoIvW3LAWGgywWiqI7TaCg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791869734;
	bh=VWuDDnKQ/kxwdTVkGwvcyzd5NbG/KQJZen2yuq3+LUY=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aRHQB2YKo04TAYroRRKv3h/7R0yYv8b4XOytovYF5Vmrq32fQ1DzqOXfkumDVjZE7
	 AuIa4H+Tz5DFrfqCaknpP1uXklFy89Gr9JSAxffyMosgNUQZdj1zqEA+2/h0y9+X1k
	 SGU+exh0r7zyMfUBAEbqkwiD9JH2LFeQSc1MYUWacZ934zsDzpmRR1Z2YXDfTuDCLB
	 mbcbXfRoL8eYW1Q5m6W+xEf1MF3pB0LMczuV3bBtDKoH5g9FIGHcvr2fQxnb+y1HXL
	 kXrgSvGNHokIL9/Xdx4TY/8KlHnfal8kXT9eyOMN+VX94gRRpthv11OMzHyKaDg9Wa
	 JBOzsSl6mJQNg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2C07A808D9;
	Tue, 13 Oct 2026 05:35:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 919B4DE0
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 05:35:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 77CB0606EB
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 05:35:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sMdTajgbCK-P for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 05:35:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org DC4EC6066F
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791869732;
 b=Ztiuz7rlvwJM3+gUZmj68ScRMl2ukwsNWryMPoJP4nSA2RDokcCI9WOCfyuPadg1qB5w
 voWY37LN0zY9xXBH1VHAuwPkX7tw/HsFsnEM2hYvGYtjlzNG3CCDskzIfog169D+LTB29
 rBj8AkRNTpnoWNYIfg65VG59YEcu802feoGCRVml2H0PQVcIJ8L3Zqy2lBPza1zWihtK5
 HPu43TtanehbmYYi4IUH4qQ0SY60mdRz3bRulo9RMq4iZIqLjTnVgjKZmc1kG/DKzcPOO
 oabruVLk8cG2W1SuNEcXcTja3ITpREz2nnTvw6u+HsK9FF0MuBxhKPBSMfYUVYa1nyA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791869732;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-GUID:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=VWuDDnKQ/kxwdTVkGwvcyzd5NbG/KQJZen2yuq3+LUY=;
 b=XMfEE2vSt0jCeY0JFCT3g5BKmQXv1N0l/0Lc68FiWdKte2+vt/4lBCGI2FK2fLcmLK+H
 JZd3kYgzNhZ5gzQvosh/tSwrvJdASX3aVcOzkp2TmcSZXY466CvAh3sU8tda93r9DV9SP
 Lee5P5j6/SDnzH0aDvTHJBBqc9MsocEQa7F6TR0VgxzrIfa74lBtN3fEB0A0ON9yRGTgj
 qmAARrbi4oKHl0lKUYKVVdsx117997Mf1/F2sX0PhJF0uW8op2tjjBHeu+eVvJTR/D8vn
 0TvXM/raittbLZm5SfYC6Qa6lNfg2iR0HNjpLtKpxjn45X6S/B/rwPHaGUUoFmfl5/w==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=MFEkzUOX; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b="V/ZWXz6X"; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=abhilash.v@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=MFEkzUOX; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=V/ZWXz6X
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DC4EC6066F
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 05:35:31 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69D20cbu922849
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 05:35:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=VWuDDnKQ/kx
 wdTVkGwvcyzd5NbG/KQJZen2yuq3+LUY=; b=MFEkzUOXg7ZrSwrzJOqE7Erj+3C
 X449l0AvOPa8KluhK/GcjyUIU6R8anzD+ujsjcOGV6G6mdIMLnOUQeubBIWZQWFx
 ehJ6yIfCPEeq9a7H+Nnbq3yGD6QDUWLpJFljOhdrOumq9OELSelrcWkPV2BPpXHT
 IcNx1L3JE7BZewb+KDdz3BdRDB0gInWpHHqtPU38F1DaSlVu/635cLiMee8lOvuP
 xjPHpfRSEqyKIT1JGRVfJ8qu1OY1dYyZkJygRbdsimdRo/FYCSqYjV5aCztrJ+9N
 cRzKv2GaVqTP1agxT3oe8XKA23vb30sNvo3t86lhNWzVuEULLLU7ub5a68A==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h98h1s82d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 05:35:30 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-35c3c370b17so920215eec.0
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 22:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791869730; x=1792474530;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=VWuDDnKQ/kxwdTVkGwvcyzd5NbG/KQJZen2yuq3+LUY=;
 b=V/ZWXz6XWeAokCU7BAxX8KwFOXCy50iFWMz7iMcehfHTxqy3iaWi3FGlf9NmNUbaWz
 67AAgkwOIJY5cKnCkiPAI/hrCluoL4WZ6X/uo351sFK/8dvaDF2qwk+BZ9s8iww5gput
 /ijhcrVve9ZEwSpdsceKeNFwRz2UtIG39Gnj3O7pZvVTvCiUmM3eTM0qNqVUaO5Ytu0I
 3h9V5cOHAiIeDCVN3rNmaggOh63N8Ba+TnJzPW0o+nt3+QkF2bDYggyvTbjJeJHF8sur
 q1/XcDKGNz7+pGk+0yt7D3aYnIK5jzCJFMpTjMulBdS2nB3jeo3/Cry6cnu91Fy7Aoob
 G5BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791869730; x=1792474530;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=VWuDDnKQ/kxwdTVkGwvcyzd5NbG/KQJZen2yuq3+LUY=;
 b=LbHdN/6/wF8WTi9mqacIbL4BhUCAWDvohBTrlSqJgZZSaafMIMbwxSEg/m67AYeUTl
 YQpBnrmGPFK0idDvxVMNethrmq+AEGJKw4fb1k3FeeKtnFZ6mEkYgT4bMuBwnXWrPxFS
 1cweStUoihwgcXB1vj5+w6faMKp/YwcFWeosxMXEhPe6W3Gkc+MQzLL7Jlw9vhqddH+y
 UP6xLk1Y9Pp83py2SdestBzZ68BQPKWMjc0w1v3quoCw/fqKJ+Gcdmj5tJJaKSU5oQBJ
 eSSNbtNpr5nXgOMWdNEcl2hGVyHasj0q3WwviULyxLja+4ITWFbmSsZTi+eS44GYiDhY
 9NUA==
X-Forwarded-Encrypted: i=1;
 AKwUvByPNcl+O2TdMj12hNj8qO3UvaPPBzDMdG5g5S0bMuwM6UPSbvEKxfmTajRIH/0Bdh8ynnSsJu8=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJYv3S3uRBbyIsQM/g25tYuy4LKwVeC5BT0sk6esPRz8g8urff5
 eexrXGuq0lo+Xj2O/sBZDtWV+1qNRO0Hch410hF6+HxFkRIn82NMMpUhAmbL78ouEtmWDSPxQF0
 NxeNc0ZnQxVyhwFuyly3nLn5E3w4qd1S8U+dinhQQouDyo4dK/VBxQdJYMCn34lbpcuCwUzA=
X-Gm-Gg: AYBFou2eZ8O623zrPlOmI1i+Zx+ZP83+4op2v3oKHNmCLQZGF602ODj18SwZ2jraDTR
 FAXTrHJrvX4PN69mNpx3Pj2mx2hSVhYZILoF9+ThWUTmsZa5nUT9+uASq1Qm+UwRCP3nXgErytz
 wvrOMwY0SV919iMd4+YjN4b2+QkbA9eJIBhtcq0vXEzMXMm3Y+oZLBOeJhX++hiOeRQzLWZyVCL
 UhXzM8axJ6mOA3a4ebL03IwM1RqwTVHkY5vXBWS79kUgDMBegB1nnNl5P3nLfjSeaJKpY/5mOcm
 1g24wKCXfPW6BTpuTIIFn4u0euGT2eBYkSrLXHm8n4QJfXyBDU4joULUTma382BKSZ9UF5UvhQs
 AngBG8wxMab4KyX0i6d6ZgXPcQJgXMqT1BxaeVNc6OULXM5U=
X-Received: by 2002:a05:693c:60d4:b0:359:2a1f:520 with SMTP id
 5a478bee46e88-3592a1f0673mr12375721eec.24.1791869729720; 
 Mon, 12 Oct 2026 22:35:29 -0700 (PDT)
X-Received: by 2002:a05:693c:60d4:b0:359:2a1f:520 with SMTP id
 5a478bee46e88-3592a1f0673mr12375694eec.24.1791869729094; 
 Mon, 12 Oct 2026 22:35:29 -0700 (PDT)
Received: from hu-abhiv-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537ca6d202sm38347170eec.13.2026.10.12.22.35.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 22:35:28 -0700 (PDT)
From: Abhilash V <abhilash.v@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org,
 aswin.murugan@oss.qualcomm.com, lukma@nabladev.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, abhilash.v@oss.qualcomm.com,
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: [PATCH v2 2/2] clk: qcom: shikra: gate PLLs by clock source
Date: Mon, 12 Oct 2026 22:35:17 -0700
Message-Id: <20261013053517.2955571-3-abhilash.v@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261013053517.2955571-1-abhilash.v@oss.qualcomm.com>
References: <20261013053517.2955571-1-abhilash.v@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=VqC2kO2n c=1 sm=1 tr=0 ts=6acdc322 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=cbElVB0p0K_n_hLG8QkA:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: 0ZfvKJE4qDksAsH41crLM2XFgzLVs7VD
X-Proofpoint-ORIG-GUID: 0ZfvKJE4qDksAsH41crLM2XFgzLVs7VD
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDAyMiBTYWx0ZWRfX4NvOkYdPx7MQ
 0gdJvOdB2v+si/qKV9quU1Qrdv41/D1fL0PI576yBZAa9euCrY9dn+kztl6Paf/wTerAAtMs0lO
 1DYOpR6o3snFem/nD3G6zqUv9vCNrS4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDAyMiBTYWx0ZWRfXyP0qziJwhd1e
 54tQ2JdGR6ZjfoLMo1GRIELXgfhhBLZGDr0sCW1jDi/wQGK204x4/82LZiDR3OFwLxet6HvPzyK
 xTRC7mMq5KWrc5d3ttjhFJ536xLNsM9x0Y1Y5An7sGfuiCT8cfR+WPWrWb5HKY5eASa2qnQLV4Y
 QX3L+aJrJVnYvaHy3+hhA8nN3hiQfhOshImjcioMLpSP8C1NOY44QC2x5CI9hH/Agf+d4KADTDQ
 1EHNle8PqGDfJTdB9/3RR0vFyIPW1mDOegTlOE7zkamhGkIDdYil3NxIhl6xPdZmDps3cl+IMDj
 T8X1XegBdXuGL5MDLUczOBtmhrqwm2lqGO3iBI8h9NWdQqFvYDpteq6TPQQz2HiqPBtQIht8Iqk
 rZcCYaWeR8d696Kz8eCtxlp87jhwHlgjJQTrXDY1zsekCNbi2GhAcodkZ4Qiqa5W002BqA6yZWm
 QaNku6pdciaEfJC9NMA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 adultscore=0 phishscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130022
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

Select the QUP and SDCC2 source table entry before
enabling its PLL.

UART rates from GPLL0_AUX2 must not vote GPLL6. SDCC2
needs a GPLL7 vote only for its GPLL7 table entry. This
avoids enabling unrelated PLLs during SPL clock setup.

Signed-off-by: Abhilash V <abhilash.v@oss.qualcomm.com>
---
 drivers/clk/qcom/clock-shikra.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/qcom/clock-shikra.c b/drivers/clk/qcom/clock-shikra.c
index a74d529f4cf..72b6696127a 100644
--- a/drivers/clk/qcom/clock-shikra.c
+++ b/drivers/clk/qcom/clock-shikra.c
@@ -138,9 +138,9 @@ static ulong shikra_set_rate(struct clk *clk, ulong rate)
 
 	switch (clk->id) {
 	case GCC_QUPV3_WRAP0_S0_CLK:
-		/* The QUP clock table includes a GPLL6 source. */
-		clk_enable_gpll0(priv->base, &gpll6_vote_clk);
 		freq = qcom_find_freq(ftbl_gcc_qupv3_wrap0_s0_clk_src, rate);
+		if (freq->src == CFG_CLK_SRC_GPLL6)
+			clk_configure_enable_pll(priv->base, &gpll6_config);
 		clk_rcg_set_rate_mnd(priv->base, GCC_QUPV3_WRAP0_S0_CLK_CMD_RCGR,
 				     freq->pre_div, freq->m, freq->n, freq->src, 16);
 		return freq->freq;
@@ -152,8 +152,9 @@ static ulong shikra_set_rate(struct clk *clk, ulong rate)
 				     freq->pre_div, freq->m, freq->n, freq->src, 8);
 		return freq->freq;
 	case GCC_SDCC2_APPS_CLK:
-		clk_enable_gpll0(priv->base, &gpll7_vote_clk);
 		freq = qcom_find_freq(ftbl_gcc_sdcc2_apps_clk_src, rate);
+		if (freq->src == CFG_CLK_SRC_GPLL7)
+			clk_enable_gpll0(priv->base, &gpll7_vote_clk);
 		clk_rcg_set_rate_mnd(priv->base, GCC_SDCC2_APPS_CLK_CMD_RCGR,
 				     freq->pre_div, freq->m, freq->n, freq->src, 8);
 		return freq->freq;
-- 
2.34.1

