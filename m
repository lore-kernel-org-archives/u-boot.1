Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68771606A321
	for <u-boot@archiver.kernel.org>; Tue, 10 Nov 2026 11:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=YA4kCMBE;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dEXq9ofw;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bq/8rM6o
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 44C2C4081A;
	Tue, 10 Nov 2026 11:45:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZOwQttm45NTv; Tue, 10 Nov 2026 11:45:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0705F40835
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794311146;
	b=YnuvmrBK00uusPiTprtXrCbLWrjQB1N2bSZsKRlihW6g2Igk1NHwjQkgQzUL1XQYgZMy
	 KwiCxC2d2/SSJzOyH1Yk+mQ2JcUdlK/1LZ83J9NhNqULzWfccReiBvYrQPzPwsY7NRrT3
	 JalTHOvcSEd5NH3v0xGxJZOLbZV1gwJFnbnj70AymMPTcVfKz2SS/A2x5+dHKQv2XZLlR
	 vsu0Y04bAfOWAC5Wm+XGnx59t6jSE3e13naSIrWJekJ6c563tcldTgzFeROl5tgoydAtX
	 QXGAu9kQ4yNfxLC7xpIzq2g6MH7b1Vjw1i44gV23LDu9yfRg2dXfr/x3g4yxv0lOvXA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794311146;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=5tZixvcWGxpqk7Y7ziz9vSCT3jeCxnQPVR31pwCz+c4=;
	b=ZLB7oXh7GnmNhdo+68WuUI8b05fUZN8rJkx+SE6aT2wbtbUvNbQAbIRfPwKzz7w+HDPG
	 XTIpnKi+j1oJBd6OWFoFyt/LPQ6nRFLakVZtcjppG1tggMQLjJCzQEvm5g3iYLPga4tuE
	 Ksk6hyulglE0w8ika1pAwkqN+woWxliKs/GLaIJIF0tIRdanjgF8gm+WHRE5H77Sj3mrl
	 kdQZo3aO7fKdGwddzmzrT7kUdeM8c7v98H8IGOwf2QBJ94uSQn4EwpDGXHvN0uKopYzHl
	 HOaZ/el9A+/nRM2YNBwMBHdL9p08UGwswWODLFC8IDQ9ABhcZ8NrA5hjkAKLR2V1nzg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794311146;
	bh=5tZixvcWGxpqk7Y7ziz9vSCT3jeCxnQPVR31pwCz+c4=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YA4kCMBECgTHL/6L4pwA5ER438Qk75H3niXhcaHQ2w3bR+zH5MTaRFoZm37bqHAB0
	 6CwdMocDPI9/GkTHukq3aQ6RW0l+HYhb2yuV7xarQQ11NFXJwKWj+F7pV7fTYmVJRT
	 U9TW92KW0E330wkO6xtN6BeypTefTq7hetUGbUH53v7BdZazjhLqKHDhKb149tCoOe
	 mnVZ8gW0bBkQo6MC+jyxyCEJbFFOOOh0cCpmvZi8CPxs9dt5EAZCwwqJWiW0WhuY/o
	 SaxL5ZCYPl0KwD5Vl1aC5v02uA3MFXUsVL6XSPgBN+LPMIYMRG7gyqgptAgaLblYfg
	 LIOnucIOmvMvA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0705F40835;
	Tue, 10 Nov 2026 11:45:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id C46C0CC4
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 11:45:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A74ED81141
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 11:45:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vv3Kw-Y_spVZ for <u-boot@lists.u-boot-project.org>;
 Tue, 10 Nov 2026 11:45:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7DA698113C
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=dEXq9ofw; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=bq/8rM6o
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7DA698113C
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 11:45:42 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AABAH7Z2881275
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 11:45:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=5tZixvcWGxp
 qk7Y7ziz9vSCT3jeCxnQPVR31pwCz+c4=; b=dEXq9ofw6x43AUAqmcFKv5tH3HZ
 u1iBNLHcnobN8ZDh4pMKkiMVDzzftZZCqckfZwsHu+9ewVG1ct0wjTYCdKBg7Pv5
 Nl8zuravPCEvpbBJ6I7T7UWQ/fkjTm31JN0Agp6dghVFB2d+8kaGyI54XVh/6gpd
 jBxnJLAo6L/3Zln4kaQ7tYt/XYcmGI92DtUZlRJaMghW4MZVZ0sA1goI4j8DAoFw
 NUcmXRiDjvuv0F8MD+uz1wlihpeMNPJmuMBO/6c2Xp7+I24iAGjPh7wdORAyfyxS
 dCD9GwDP3wwK8G4EDd8Dg41s/W454onyCqKXyifM+LKkygEVI7LlugHgMNA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hux849464-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 11:45:41 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-3724667bc16so1789471eec.1
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 03:45:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794311140; x=1794915940;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=5tZixvcWGxpqk7Y7ziz9vSCT3jeCxnQPVR31pwCz+c4=;
 b=bq/8rM6ojvnAbXK7fbRN1qJbSCEEBWaFNZlDV6FijFwQIYsvVHDd8PQsB3hcHXkT3a
 Puzz6LiGJBYCfyU7DntTud9JJJkVTt3xn8VaJugrOtzSPyBW9Rqi84MB2DTfjaUsz6Xb
 ohtmFB9mSi5lrdIHUavE8OSSiySYFSqjSTkbRqWyqull2L/plHBzl2pmeqes0BWuzlYC
 wrSqTTJi6uuqAZNR+gavwcjBqiUskXUBQ+imzkkuKWHHmmq6Dt18rq58nZTe+YFH04t4
 sZes+0SEjefG69bwvmKTpzouMBe0OjX0UVecwdEtCO9Xf3hba9il4Sx1FuVrYfStkNQ1
 MKGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794311140; x=1794915940;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=5tZixvcWGxpqk7Y7ziz9vSCT3jeCxnQPVR31pwCz+c4=;
 b=stmrpspgjyMNMtNjb04WSNnnPlXBZH7lDVtX9XO7QX207XbdjK1a7KsfmfDqBA9IjN
 EAf5yyJkuEXWQjvjnpABNWkYTMA0cIMSYjkAG0V8B1puJmXb01Bx0c+6PRUmTcBjR8hc
 +950MohjCMGAmrIrXXq9VMp8XBHexAQBK1WpA93xhGLVkdv9Kw9xxVFUnMdsbTfWtXMq
 h5OTOfoRHNpQ4OEx2+ZTArHaNAyrRDwbwaMZoj96e2ulgxZlCVh3gmHTw30o3aSiNFtz
 mUqWsVQeIwP9x4/M0HNwnPRtXg7TgQnP4s8UIb0GitkJOQFJ/Ib3/8LdoaIZT+Ue08Z3
 J5BQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGiGy2/hywKIDUfGeNIDMMNIzqh8OmqnkrCnKHx6WWgJ7K5/HqI050AVYZWr+xLiDDUhNMpYzE=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/V1RCoU+i3prdW40LDH0TqWnuD3sKIOm9gGwzlzznXsUDrIbYN
 crBMArgKho2ID3Dy4XcE+PZnqYhBjBtkp8JUsCUyVQr7vXgGx91u/CTrXUrTE0fI3B1sJNkLGts
 Qv6yfTeToPqFnCSB67T7xnqm8LAQNEiSCVFuGzMkOUnSi4dDE4z46wc7Tl52NFtRod0jnXeU=
X-Gm-Gg: AYBFou1s2niH3AmSKWZZ98jX6h3+ezdtIZY5syNAqnjtUgY5n52kFEooTHKi5keTe0y
 y7eNuClKCAizW/vSrHXnPhHZNxZLcU5BPd0VBSpkpFwPBYSsig6Q776JHIwC0RWJEE7iMg9eKj0
 oQrk/CoggJQqPUDIpZ5Pxqigl2zGLBk6pYkqH10eTcKEmkgaH5tsDDvuAnSPlB+EWmLoOcysHj3
 97eCTn9fZfltAtmKVTC6BFVPh/k7BjTgDuD6pftFidklFuTu9SfD8WlgXrW2FVgu8XGgdIv4ttr
 hjHFU+7qots1/oRWkAU8MINpweMWzbGlh++mbcz/zDOsnKHBW1EIb6OFwwfxX+xMnG6+x2i7/Ii
 yK9EZIVtklpiUxmB+q8hb+bVOln9vb33pbxbwdFpbIXQM6hUNVpVr2yDmKMkRFORYzwHj3tPW6Y
 pPwmqDR0MD2el83xL7Fl5/8sBTNn8tIETCpBkle0+xmeSIoKqPqKcMiNEQ2k4X4Enfve0l
X-Received: by 2002:a05:7301:6481:b0:36c:a26f:83c4 with SMTP id
 5a478bee46e88-37509537791mr3294239eec.13.1794311139852; 
 Tue, 10 Nov 2026 03:45:39 -0800 (PST)
X-Received: by 2002:a05:7301:6481:b0:36c:a26f:83c4 with SMTP id
 5a478bee46e88-37509537791mr3294184eec.13.1794311139039; 
 Tue, 10 Nov 2026 03:45:39 -0800 (PST)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-37520bf3e18sm11828890eec.16.2026.11.10.03.45.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 03:45:38 -0800 (PST)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com, peng.fan@nxp.com,
 jh80.chung@samsung.com, tanmay.kathpalia@altera.com,
 aswin.murugan@oss.qualcomm.com, nathbappai@gmail.com,
 balaji.selvanathan@oss.qualcomm.com, Michael.Srba@seznam.cz,
 u-boot-qcom@groups.io, u-boot@lists.u-boot-project.org
Subject: [PATCH v4 2/4] mmc: msm_sdhci: add CM_DLL init and HS200 tuning
 support
Date: Tue, 10 Nov 2026 17:15:18 +0530
Message-Id: <20261110114520.229480-3-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261110114520.229480-1-aswin.murugan@oss.qualcomm.com>
References: <20261110114520.229480-1-aswin.murugan@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDA0NiBTYWx0ZWRfX3Z93sg0AlC+s
 YvvrqEABW3D86fVTffVe9spw0Biu1KVuJNCogyHOrE6ke01SEOGaCqE2Ntt4orPnVRviwoQUFki
 u2O9I2KaYl2bLKlrlV+zJuuWpLECz5fnL3DsOuVL71Ml5oPmTjVo0HSgnJpIr3Tkjzv/EmC+if/
 N+Ej7Zwjdss+AzYsE90otbPeu185wcNyGZcZdMM3LUQHQiUxgr6OTM9wu+LMSwoRd3RPExbJzjI
 kUh7wmW98G5yDZQ3sLoMxAv2ziZ7/7Uq28jCoGvMWn2f6H8yUf6zwfEvJEWVDTDf2aBMADRU+n0
 23FZnS5r9eXCHvHgq6gWVASp0Q9b69RneTLVNXMUCexzLVfD/wvIS8KgxT7INlOUJQv4S5RfI/n
 xWtIwRtfc54pqT7GvNHVS8XraDIWvA6P6QGH0JbOTHOEfp2Evq1rtn4aQ6Vd2t78pMpumbhI/wQ
 cPG4kXfQO52FJbYLtWQ==
X-Proofpoint-GUID: 6bUY2fupMAQbkxYvRur6efjGcTLoeFaU
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDA0NiBTYWx0ZWRfXwWdpMj0CKcQe
 1e/CYQ0RJOa44/VI8ukLCvm+n+BkAO+/0MVGFfSuDDpWD498Cq49qTmAUCDuLyM+67gUEw7pzMs
 XNq4Dv3LhEaXuG91vDN38BkEPtqT+ws=
X-Proofpoint-ORIG-GUID: 6bUY2fupMAQbkxYvRur6efjGcTLoeFaU
X-Authority-Analysis: v=2.4 cv=JNSuIMKb c=1 sm=1 tr=0 ts=6af303e5 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=1eCGacO4p7ucnnlXo8QA:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_04,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 spamscore=0 priorityscore=1501
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add the CM_DLL (delay-locked loop) initialization sequence and wire up
platform_execute_tuning so the driver can perform HS200 tuning. The
14LPP DLL reset and Tassadar DLL variants are selected based on the
SDCC core version, and an optional qcom,dll-config DT property can
override the computed DLL configuration.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 drivers/mmc/msm_sdhci.c | 411 ++++++++++++++++++++++++++++++++++++++++
 drivers/mmc/msm_sdhci.h |  45 +++++
 2 files changed, 456 insertions(+)

diff --git a/drivers/mmc/msm_sdhci.c b/drivers/mmc/msm_sdhci.c
index d7ae26c609c..23c06e8d15e 100644
--- a/drivers/mmc/msm_sdhci.c
+++ b/drivers/mmc/msm_sdhci.c
@@ -14,6 +14,7 @@
 #include <wait_bit.h>
 #include <asm/io.h>
 #include <linux/bitops.h>
+#include <linux/iopoll.h>
 #include <power/regulator.h>
 #include "msm_sdhci.h"
 
@@ -106,12 +107,404 @@ static int msm_sdc_mci_init(struct msm_sdhc *prv)
 	return 0;
 }
 
+static int msm_dll_poll_ck_out_en(struct sdhci_host *host, u8 poll)
+{
+	u32 ck_out_en;
+	struct udevice *dev = host->mmc->dev;
+	const struct msm_sdhc_variant_info *var_info =
+		(void *)dev_get_driver_data(dev);
+	int ret;
+
+	ret = read_poll_timeout(readl, ck_out_en,
+				(!!(ck_out_en & CORE_CK_OUT_EN) == poll),
+				1, 50,
+				host->ioaddr + var_info->core_dll_config);
+	if (ret) {
+		printf("%s: CK_OUT_EN bit is not %d\n",
+		       host->name, poll);
+		return -ETIMEDOUT;
+	}
+
+	return 0;
+}
+
+static int msm_config_cm_dll_phase(struct sdhci_host *host, u8 phase)
+{
+	int rc;
+	static const u8 grey_coded_phase_table[] = {
+		0x0, 0x1, 0x3, 0x2, 0x6, 0x7, 0x5, 0x4,
+		0xc, 0xd, 0xf, 0xe, 0xa, 0xb, 0x9, 0x8
+	};
+	u32 config;
+	struct udevice *dev = host->mmc->dev;
+	const struct msm_sdhc_variant_info *var_info =
+		(void *)dev_get_driver_data(dev);
+
+	if (phase > 0xf)
+		return -EINVAL;
+
+	config = readl(host->ioaddr + var_info->core_dll_config);
+	config &= ~(CORE_CDR_EN | CORE_CK_OUT_EN);
+	config |= (CORE_CDR_EXT_EN | CORE_DLL_EN);
+	writel(config, host->ioaddr + var_info->core_dll_config);
+
+	rc = msm_dll_poll_ck_out_en(host, 0);
+	if (rc)
+		return rc;
+
+	config = readl(host->ioaddr + var_info->core_dll_config);
+	config &= ~CDR_SELEXT_MASK;
+	config |= grey_coded_phase_table[phase] << CDR_SELEXT_SHIFT;
+	writel(config, host->ioaddr + var_info->core_dll_config);
+
+	config = readl(host->ioaddr + var_info->core_dll_config);
+	config |= CORE_CK_OUT_EN;
+	writel(config, host->ioaddr + var_info->core_dll_config);
+
+	rc = msm_dll_poll_ck_out_en(host, 1);
+	if (rc)
+		return rc;
+
+	config = readl(host->ioaddr + var_info->core_dll_config);
+	config |= CORE_CDR_EN;
+	config &= ~CORE_CDR_EXT_EN;
+	writel(config, host->ioaddr + var_info->core_dll_config);
+
+	return 0;
+}
+
+/*
+ * Programs the MCLK_FREQ (CMUX_SHIFT_PHASE) field. Must be set before
+ * enabling CORE_DLL_EN/CORE_CK_OUT_EN, otherwise the DLL will not lock.
+ *
+ * host->clock is not updated by the generic sdhci.c, so mmc->clock is
+ * used instead.
+ */
+static void msm_cm_dll_set_freq(struct sdhci_host *host)
+{
+	struct udevice *dev = host->mmc->dev;
+	struct mmc *mmc = host->mmc;
+	const struct msm_sdhc_variant_info *var_info =
+		(void *)dev_get_driver_data(dev);
+	u32 mclk_freq = 0, config;
+	unsigned int clock = mmc->clock;
+
+	if (clock <= 112000000)
+		mclk_freq = 0;
+	else if (clock <= 125000000)
+		mclk_freq = 1;
+	else if (clock <= 137000000)
+		mclk_freq = 2;
+	else if (clock <= 150000000)
+		mclk_freq = 3;
+	else if (clock <= 162000000)
+		mclk_freq = 4;
+	else if (clock <= 175000000)
+		mclk_freq = 5;
+	else if (clock <= 187000000)
+		mclk_freq = 6;
+	else if (clock <= 200000000)
+		mclk_freq = 7;
+
+	config = readl(host->ioaddr + var_info->core_dll_config);
+	config &= ~CMUX_SHIFT_PHASE_MASK;
+	config |= mclk_freq << CMUX_SHIFT_PHASE_SHIFT;
+	writel(config, host->ioaddr + var_info->core_dll_config);
+}
+
+static int msm_dll_poll_lock_status(struct sdhci_host *host)
+{
+	u32 dll_status;
+	struct udevice *dev = host->mmc->dev;
+	const struct msm_sdhc_variant_info *var_info =
+		(void *)dev_get_driver_data(dev);
+	int ret;
+
+	ret = read_poll_timeout(readl, dll_status,
+				(dll_status & CORE_DLL_LOCK),
+				1, 50,
+				host->ioaddr + var_info->core_dll_status);
+	if (ret) {
+		printf("%s: DLL failed to LOCK (DLL_STATUS=0x%08x)\n",
+		       host->name,
+		       readl(host->ioaddr + var_info->core_dll_status));
+		return -ETIMEDOUT;
+	}
+
+	return 0;
+}
+
+/* CM_DLL initialization sequence */
+static int msm_init_cm_dll(struct sdhci_host *host)
+{
+	struct udevice *dev = host->mmc->dev;
+	struct msm_sdhc *priv = dev_get_priv(dev);
+	const struct msm_sdhc_variant_info *var_info =
+		(void *)dev_get_driver_data(dev);
+	u32 config;
+	int ret;
+
+	/*
+	 * Keep the clock enabled while DLL tuning is in progress; PWRSAVE
+	 * may otherwise turn it off.
+	 */
+	config = readl(host->ioaddr + var_info->core_vendor_spec);
+	config &= ~CORE_CLK_PWRSAVE;
+	writel(config, host->ioaddr + var_info->core_vendor_spec);
+
+	if (priv->dll_config)
+		writel(priv->dll_config, host->ioaddr + var_info->core_dll_config);
+
+	if (priv->use_14lpp_dll_reset) {
+		config = readl(host->ioaddr + var_info->core_dll_config);
+		config &= ~CORE_CK_OUT_EN;
+		writel(config, host->ioaddr + var_info->core_dll_config);
+
+		if (var_info->core_dll_config_2) {
+			config = readl(host->ioaddr + var_info->core_dll_config_2);
+			config |= CORE_DLL_CLOCK_DISABLE;
+			writel(config, host->ioaddr + var_info->core_dll_config_2);
+		}
+	}
+
+	config = readl(host->ioaddr + var_info->core_dll_config);
+	config |= CORE_DLL_RST;
+	writel(config, host->ioaddr + var_info->core_dll_config);
+
+	config = readl(host->ioaddr + var_info->core_dll_config);
+	config |= CORE_DLL_PDN;
+	writel(config, host->ioaddr + var_info->core_dll_config);
+
+	/*
+	 * MCLK_FREQ must be programmed while the DLL is reset and powered
+	 * down, unless a DT dll-config override is in effect.
+	 */
+	if (!priv->dll_config)
+		msm_cm_dll_set_freq(host);
+
+	config = readl(host->ioaddr + var_info->core_dll_config);
+	config &= ~CORE_DLL_RST;
+	writel(config, host->ioaddr + var_info->core_dll_config);
+
+	config = readl(host->ioaddr + var_info->core_dll_config);
+	config &= ~CORE_DLL_PDN;
+	writel(config, host->ioaddr + var_info->core_dll_config);
+
+	if (priv->use_14lpp_dll_reset) {
+		if (!priv->dll_config)
+			msm_cm_dll_set_freq(host);
+
+		if (var_info->core_dll_config_2) {
+			config = readl(host->ioaddr + var_info->core_dll_config_2);
+			config &= ~CORE_DLL_CLOCK_DISABLE;
+			writel(config, host->ioaddr + var_info->core_dll_config_2);
+		}
+	}
+
+	/* Applicable to SDCC v5.1 onwards only */
+	if (priv->uses_tassadar_dll && var_info->core_dll_usr_ctl) {
+		config = DLL_USR_CTL_POR_VAL | FINE_TUNE_MODE_EN |
+			 ENABLE_DLL_LOCK_STATUS | BIAS_OK_SIGNAL;
+		writel(config, host->ioaddr + var_info->core_dll_usr_ctl);
+
+		if (var_info->core_dll_config_3) {
+			config = readl(host->ioaddr + var_info->core_dll_config_3);
+			config &= ~0xFF;
+			if (host->mmc->clock < 150000000)
+				config |= DLL_CONFIG_3_LOW_FREQ_VAL;
+			else
+				config |= DLL_CONFIG_3_HIGH_FREQ_VAL;
+			writel(config, host->ioaddr + var_info->core_dll_config_3);
+		}
+	}
+
+	config = readl(host->ioaddr + var_info->core_dll_config);
+	config |= CORE_DLL_EN;
+	writel(config, host->ioaddr + var_info->core_dll_config);
+
+	config = readl(host->ioaddr + var_info->core_dll_config);
+	config |= CORE_CK_OUT_EN;
+	writel(config, host->ioaddr + var_info->core_dll_config);
+
+	ret = msm_dll_poll_lock_status(host);
+	if (ret)
+		return ret;
+
+	config = readl(host->ioaddr + var_info->core_dll_config);
+	config |= CORE_CDR_EN;
+	config &= ~CORE_CDR_EXT_EN;
+	writel(config, host->ioaddr + var_info->core_dll_config);
+
+	priv->calibration_done = false;
+
+	return 0;
+}
+
+static int msm_find_most_appropriate_phase(struct sdhci_host *host,
+					   u8 *phase_table,
+					   u8 total_phases)
+{
+	int ret;
+	u8 ranges[MAX_PHASES][MAX_PHASES] = { {0}, {0} };
+	u8 phases_per_row[MAX_PHASES] = { 0 };
+	int row_index = 0, col_index = 0, selected_row_index = 0;
+	int i, longest_range_len = 0;
+	bool found = false;
+
+	if (!total_phases || total_phases > MAX_PHASES) {
+		printf("%s: Invalid argument: total_phases=%d\n",
+		       host->name, total_phases);
+		return -EINVAL;
+	}
+
+	for (i = 0; i < total_phases; i++) {
+		ranges[row_index][col_index] = phase_table[i];
+		phases_per_row[row_index] += 1;
+		col_index++;
+
+		if ((i + 1) == total_phases)
+			continue;
+
+		if (phase_table[i] + 1 != phase_table[i + 1]) {
+			row_index++;
+			col_index = 0;
+		}
+	}
+
+	if (row_index == 0) {
+		ret = phase_table[total_phases / 2];
+		goto exit;
+	}
+
+	for (i = 0; i <= row_index; i++) {
+		if (phases_per_row[i] > longest_range_len) {
+			longest_range_len = phases_per_row[i];
+			selected_row_index = i;
+			found = true;
+		}
+	}
+
+	if (found) {
+		ret = ranges[selected_row_index][longest_range_len / 2];
+	} else {
+		ret = -EIO;
+		printf("%s: Failed to find a valid phase\n", host->name);
+	}
+
+exit:
+	return ret;
+}
+
+static bool sdhci_msm_is_tuning_needed(struct sdhci_host *host)
+{
+	struct mmc *mmc = host->mmc;
+
+	return mmc->selected_mode == MMC_HS_200;
+}
+
+#if CONFIG_IS_ENABLED(MMC_SUPPORTS_TUNING)
+static int sdhci_msm_execute_tuning(struct mmc *mmc, u8 opcode)
+{
+	struct sdhci_host *host = mmc->priv;
+	int tuning_seq_cnt = 10;
+	u8 phase, tuned_phases[MAX_PHASES], tuned_phase_cnt = 0;
+	int rc;
+	struct udevice *dev = mmc->dev;
+	struct msm_sdhc *priv = dev_get_priv(dev);
+
+	if (!sdhci_msm_is_tuning_needed(host))
+		return 0;
+
+	/*
+	 * The SDHCI core may call execute_tuning before host->clock is
+	 * updated to match mmc->clock.
+	 */
+	if (host->clock != mmc->clock) {
+		rc = sdhci_set_clock(mmc, mmc->clock);
+		if (rc) {
+			printf("%s: Failed to set clock for tuning\n", host->name);
+			return rc;
+		}
+	}
+
+	priv->tuning_done = false;
+
+retry:
+	rc = msm_init_cm_dll(host);
+	if (rc) {
+		printf("%s: Failed to init DLL\n", host->name);
+		return rc;
+	}
+
+	phase = 0;
+	tuned_phase_cnt = 0;
+
+	do {
+		rc = msm_config_cm_dll_phase(host, phase);
+		if (rc) {
+			printf("%s: Failed to set DLL phase %d\n",
+			       host->name, phase);
+			return rc;
+		}
+
+		rc = mmc_send_tuning(mmc, opcode);
+		if (!rc)
+			tuned_phases[tuned_phase_cnt++] = phase;
+	} while (++phase < MAX_PHASES);
+
+	if (tuned_phase_cnt) {
+		if (tuned_phase_cnt == MAX_PHASES) {
+			/*
+			 * All phases valid is close to as bad as none valid:
+			 * likely no phase is really reliable. Retry a few
+			 * times rather than guessing.
+			 */
+			if (--tuning_seq_cnt) {
+				tuned_phase_cnt = 0;
+				goto retry;
+			}
+		}
+
+		rc = msm_find_most_appropriate_phase(host, tuned_phases,
+						     tuned_phase_cnt);
+		if (rc < 0) {
+			printf("%s: Failed to find appropriate phase\n",
+			       host->name);
+			return rc;
+		}
+		phase = rc;
+
+		rc = msm_config_cm_dll_phase(host, phase);
+		if (rc) {
+			printf("%s: Failed to set final phase %d\n",
+			       host->name, phase);
+			return rc;
+		}
+
+		priv->saved_tuning_phase = phase;
+	} else {
+		if (--tuning_seq_cnt)
+			goto retry;
+		printf("%s: No tuning point found\n", host->name);
+		rc = -EIO;
+	}
+
+	if (!rc)
+		priv->tuning_done = true;
+
+	return rc;
+}
+#endif
+
 static int msm_sdhci_config_dll(struct sdhci_host *host, u32 clock, bool enable)
 {
 	struct udevice *dev = mmc_to_dev(host->mmc);
 	const struct msm_sdhc_variant_info *var_info = (void *)dev_get_driver_data(dev);
 	u32 config;
 
+	if (clock == 0)
+		return 0;
+
 	if (enable && clock < MHZ(100)) {
 		/*
 		 * DLL is not required for clock <= 100MHz
@@ -132,6 +525,9 @@ static int msm_sdhci_config_dll(struct sdhci_host *host, u32 clock, bool enable)
 struct sdhci_ops msm_sdhci_ops = {
 	.config_dll = &msm_sdhci_config_dll,
 	.set_control_reg = &sdhci_set_control_reg,
+#if CONFIG_IS_ENABLED(MMC_SUPPORTS_TUNING)
+	.platform_execute_tuning = &sdhci_msm_execute_tuning,
+#endif
 };
 
 static int msm_sdc_probe(struct udevice *dev)
@@ -193,6 +589,15 @@ static int msm_sdc_probe(struct udevice *dev)
 
 	log_debug("SDCC version %d.%d\n", core_major, core_minor);
 
+	/* Feature support depends on the SDCC core version. */
+	if (core_major == 1 && core_minor >= 0x42)
+		prv->use_14lpp_dll_reset = true;
+
+	if (core_major == 1 && core_minor >= 0x71)
+		prv->uses_tassadar_dll = true;
+
+	dev_read_u32(dev, "qcom,dll-config", &prv->dll_config);
+
 	/*
 	 * Support for some capabilities is not advertised by newer
 	 * controller versions and must be explicitly enabled.
@@ -283,6 +688,8 @@ static const struct msm_sdhc_variant_info msm_sdhc_mci_var = {
 	.mci_removed = false,
 
 	.core_dll_config = 0x100,
+	.core_dll_status = 0x108,
+	.core_dll_config_2 = 0x1b4,
 	.core_vendor_spec = 0x10c,
 	.core_vendor_spec_capabilities0 = 0x11c,
 };
@@ -291,6 +698,10 @@ static const struct msm_sdhc_variant_info msm_sdhc_v5_var = {
 	.mci_removed = true,
 
 	.core_dll_config = 0x200,
+	.core_dll_status = 0x208,
+	.core_dll_config_2 = 0x254,
+	.core_dll_config_3 = 0x258,
+	.core_dll_usr_ctl = 0x388,
 	.core_vendor_spec = 0x20c,
 	.core_vendor_spec_capabilities0 = 0x21c,
 };
diff --git a/drivers/mmc/msm_sdhci.h b/drivers/mmc/msm_sdhci.h
index a8e1c2e8334..337b73577c2 100644
--- a/drivers/mmc/msm_sdhci.h
+++ b/drivers/mmc/msm_sdhci.h
@@ -31,6 +31,37 @@
 #define CORE_DLL_PDN		BIT(29)
 #define CORE_DLL_RST		BIT(30)
 
+/* DLL configuration */
+#define CORE_DLL_EN		BIT(16)
+#define CORE_CDR_EN		BIT(17)
+#define CORE_CK_OUT_EN		BIT(18)
+#define CORE_CDR_EXT_EN		BIT(19)
+#define CORE_DLL_LOCK		BIT(7)
+#define CORE_CMD_DAT_TRACK_SEL	BIT(0)
+
+#define CDR_SELEXT_SHIFT	20
+#define CDR_SELEXT_MASK		(0xf << CDR_SELEXT_SHIFT)
+
+/* MCLK frequency selection (CMUX_SHIFT_PHASE) - required for the DLL to lock */
+#define CMUX_SHIFT_PHASE_SHIFT	24
+#define CMUX_SHIFT_PHASE_MASK	(7 << CMUX_SHIFT_PHASE_SHIFT)
+
+/* 14LPP DLL reset / Tassadar DLL extras, for SDCC minor >= 0x42 / 0x71 */
+#define CORE_DLL_CLOCK_DISABLE	BIT(21)
+
+#define DLL_USR_CTL_POR_VAL	0x10800
+#define ENABLE_DLL_LOCK_STATUS	BIT(26)
+#define FINE_TUNE_MODE_EN	BIT(27)
+#define BIAS_OK_SIGNAL		BIT(29)
+
+#define DLL_CONFIG_3_LOW_FREQ_VAL	0x08
+#define DLL_CONFIG_3_HIGH_FREQ_VAL	0x10
+
+#define CORE_CLK_PWRSAVE	BIT(1)
+
+#define CORE_FREQ_100MHZ	(100 * 1000000)
+#define MAX_PHASES		16
+
 #define MHZ(X) ((X) * 1000000UL)
 
 struct msm_sdhc_plat {
@@ -43,12 +74,26 @@ struct msm_sdhc {
 	void *base;
 	struct clk_bulk clks;
 	struct udevice *vqmmc;
+
+	/* HS200 tuning state */
+	bool tuning_done;
+	bool calibration_done;
+	u8 saved_tuning_phase;
+
+	/* DLL init sequence variant selection, from the SDCC core version */
+	u32 dll_config;		/* qcom,dll-config DT override, 0 if absent */
+	bool use_14lpp_dll_reset;	/* core_minor >= 0x42 */
+	bool uses_tassadar_dll;		/* core_minor >= 0x71 */
 };
 
 struct msm_sdhc_variant_info {
 	bool mci_removed;
 
 	u32 core_dll_config;
+	u32 core_dll_status;
+	u32 core_dll_config_2;
+	u32 core_dll_config_3;
+	u32 core_dll_usr_ctl; /* Present on SDCC5.1 onwards */
 	u32 core_vendor_spec;
 	u32 core_vendor_spec_capabilities0;
 };
-- 
2.34.1

