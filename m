Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DA8606A321
	for <u-boot@archiver.kernel.org>; Tue, 24 Nov 2026 05:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=aZ5KBBzR;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=N8/YKes+;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=c+zLt3I1
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 84F91607C6;
	Tue, 24 Nov 2026 05:58:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wnKvJOPOB7LP; Tue, 24 Nov 2026 05:58:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6CDE160789
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795499930;
	b=EMmuZ8ORufsvUUAU4F3GPqqIstnF6d/5BFoHoOPPIud+7bvTMksMLR2ZAzMj3IOb0Cbd
	 lBfO/aSm4DjMSpkT4bSxXvIS+1lOonj+fG3Hu25H/O5f8JdQQks+XiETC/+8/svfGYzSm
	 f1/r5IqplXZAYLUmxzHWFaRNxnJ88+yx4NKt/bvYGTgUjkkbKTKeghaovA51Im0O0Mo3T
	 2MbrUA0XbFnxeyO5keztIFsU9KvNKhGQmKV4mQ5AYAToDzYwvJ7l8xE9WyeIejnMWwofA
	 Rl/nadL7nnE+tAnoKYkaVX4sYCN4LzIK6F/Q+nd/RasBbJJTwUaVamK+/YMd3u1veDQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795499930;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=TnZz2YMkae9lWk29Yx5foxiToAhN+47uo34XcIYO1kc=;
	b=mDX/DgoSINq8Hvq1TTW+UOvhV51TyGVO0xLJ9n5YslCYFIkB6pBRuYAsfd0PPynp74WQ
	 wx2yp6BGFZMH7tiLQ1IAQ6P34fINg6+W0T41fa8OqS3VlwWOoBrpVgU2wfacaqdVtZz/x
	 WvV3p5KQWlwbJ4AWylurgFIWw10fADQHIRkp/A5pwTlm7oWVcrpqZQfBdwqoVcxk6e6B4
	 50HdK7bgZcr8LWDOHMlkjdrrQAfVk9cLP5/qb0e9u+LlIM7kIUPVfWpHLQ5VbxJiIhFtz
	 jm4W8pkqQzFfkCSeqLkWuskKyOsk9Z7PG0b8Kah+dLxfNX2TVyqdE8y6fyk8Cc5eR6g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795499930;
	bh=TnZz2YMkae9lWk29Yx5foxiToAhN+47uo34XcIYO1kc=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=aZ5KBBzRY+UKUki04+XDhhYpcY3kD1+KHdbhKiT4plyPg9OHtr8Rh5AOaKE5crG+C
	 3aYjV73EQdUsmahmedzeT0WWkLA/8VIHUKByQD4fF93gBrEUlfvAfeNyTRWXZC8MgM
	 t4BeW0bMKQiQaOsgeqNpVpb9f0MigA6aEt1JXIAvdCMnFstmyQi2pglQQP/P2H+jj/
	 9EJxERcCoKoifuFodSq094llpI0m37X6LREqcFuAOwPiyKK2JN/HtY6Qzbh/TtwnMM
	 qjHtSAebyGoPw9TI3mckThdGllgoF+xs4AFd3G4kJV7uLZi4yHklc7XUfxJOy8/TY4
	 TpsdtTcYRwU4Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6CDE160789;
	Tue, 24 Nov 2026 05:58:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id D83CB3A8
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 05:58:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B52E280D82
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 05:58:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uJZ0l2qw0iNA for <u-boot@lists.u-boot-project.org>;
 Tue, 24 Nov 2026 05:58:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E323380C7E
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=varadarajan.narayanan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=N8/YKes+; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=c+zLt3I1
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E323380C7E
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 05:58:47 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AO2k3vp3701186
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 05:58:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=TnZz2YMkae9lWk29Yx5fox
 iToAhN+47uo34XcIYO1kc=; b=N8/YKes+XuRewyNfxAAtqugs1y4GTRGNpYobyL
 h2QqApq38l7BVMk4Kag9ZHmCOkXx4GyPCzyZO94XpKzj4YGQxw/OEpeEo7zpoFQ6
 m4TqWKHFea28t1GP4BbVj/t+JKWqsBvcL/Jjdw8Wbi6O3SwbwFBC3+mF+0zzRgKG
 RNTJJfKtpeuDIcwNh5/EoANP60Zss9MEJ6APmTpA8I7qUWLhORbc4jdoFTdw2j2b
 9bciP8XhByWGdo58QUIlxiyY8uxAbu3CPlbI3qjv8Rjs1LBcrRNOqY07YEVkvhlm
 YCzFNW92+1apevtMDp1rMek9I5c/NCff1ao+hPaQiebF2HAg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j50ky0xs8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 05:58:46 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-386a65fca25so2850848eec.0
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 21:58:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795499926; x=1796104726;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=TnZz2YMkae9lWk29Yx5foxiToAhN+47uo34XcIYO1kc=;
 b=c+zLt3I14SV1bKIs9q0rorCAUyUD796UkZW2qJesfsAEmJncbjHFq+3Dof05/P19n/
 rszn7/6+avB/NOb1N3xGx6PIjjORJuND//kLFCoTeJeLzUn3e6ELbun6ecrn/0J6+Yaw
 tTAE3rDLroN3ydMCF1PeZh/vx+hiC7AteMzJthqxP9L88ij5IZGRwwDhYqmkSxJA+QY+
 2T2rvAWVI5nhJiHunmTWU8lvauyLZJebB7sivTR6/KUZ4h/QJJmqgsSw6ZywdeP8OvC0
 evlBFs5FvEvaimQMNV5kAP00YsfrsZ86A5UyauJx35ar0AjHhQ+DxFKmlzaRa2qWPBVF
 ljow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795499926; x=1796104726;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=TnZz2YMkae9lWk29Yx5foxiToAhN+47uo34XcIYO1kc=;
 b=pTpOVU/E8CmMQnmVPhqtOftWO9euZQ/b4/Bm77d9OQfE+kclDGOo2rR6FKRZM/pLQL
 3r8tyYWXjTCY7gxdnvcAdkMDOXwuh5NDeN69xraxQ3QCVMLaGEEtel3oD7i8lHujL+vO
 4jDD3Afl4PPGkFhgpXKCLR79bREyVz2f1nIVfLp4eym7NEWOEStp2vPzCJ0bSX3T6jem
 LE8jhp422Io0MxmqX1xgFWosWApN0rUk9ei4m1WySw+Uqq2N1WMBJiksb5cJfiLojYpL
 3NVpDYkhfV1SPFByRrdesxnyhwhxLom/Kc6QQNdyzFMF9E8CM50HW1mtDXy2Jfn9PHFf
 MHJQ==
X-Forwarded-Encrypted: i=1;
 AL+hErHJfbv3Ynj1QLfEOB0bdaODle+Ov2ii87J8WfyI1hJyV/aPa6ZXSNtIuIRGstuWZ++2k40t1as=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+vwWLXZ3gQZSw76Ptlokt6kLVniQKe4LAr5bWHFes8CRr0qpks
 VVHSZF5K8mvQo3/8Lp0ab7/s09PLEvldANlspFx/wKsQyGSjgeTZZH1vV1dPyjm+/KHyBeQN5nu
 3nVYrgJV8Xt0+Ak9JXBgREtN+drNwxIQ8L2q+VH2eJrIw+rMk9hXD/A3NCpHfxKiiazLiC6XDoH
 2kzjk=
X-Gm-Gg: AZFdTZcoe4DKuh0LZrmqakE3ugxCvJwokG0YeyqyJ+9NK3CXAB5/r0i/trfGDCbdqJs
 u4HBPP4lTO4gmgm9MEy0k+x1p/n7U2r5Z8uCzKGj52gzOqCI9bPWgYvBQ2QE8w68YxuU+b9XJig
 Xhzj5wSvwUzO9aTTwSiAkGLVjRz0+xUQ6ZCDmAM2zn7EiL0f8BEkIphXdP+vvdCyS90/8MxEGuF
 2GPo9VV52yaY0OfK09XkUwR+gHLQHjdbzZp1+k4Y7p/WerqvYpkcu0tTS73kvJ6mdu+rh439okF
 sI6ybv/RwKzXtwQ4bza+0FgeLsUDbsosnEuAWXFk25hdXFXdMgKi1ECHWCLBf8RmWbYwICPVCQx
 Wr3hc4/bkTsXKkWIHbxkXuRdH5AuAqsYxKKzz61ya7/01wpNcbYsu1Izsf1/sWxXFtVlCbHK4Xj
 Vo0aqumdDwMwaOJt5Yqjg873RrF3mtg41DkTK1o0P7BF9wwI8vckXnOV2aKFDsV3i8Z2qTRGl1t
 fpnHg==
X-Received: by 2002:a05:7301:7107:b0:386:b494:8642 with SMTP id
 5a478bee46e88-386b494879amr4428058eec.13.1795499925711; 
 Mon, 23 Nov 2026 21:58:45 -0800 (PST)
X-Received: by 2002:a05:7301:7107:b0:386:b494:8642 with SMTP id
 5a478bee46e88-386b494879amr4428034eec.13.1795499925162; 
 Mon, 23 Nov 2026 21:58:45 -0800 (PST)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-38567abb870sm34742351eec.25.2026.11.23.21.58.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 21:58:44 -0800 (PST)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Subject: [PATCH v5 0/4] tools: qcom: mkmbn: Updates to support ipq5210
Date: Tue, 24 Nov 2026 11:28:34 +0530
Message-Id: <20261124-ipq5210-v5-0-b509d2b05180@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIonBWsC/3WPzQ6CMBCEX4X0bE13oSCefA/jobRbbaICLRKN4
 d0tNf4c9LLJbOab2b2zQN5RYOvszjyNLrj2HIVcZEwf1HlP3JmoGQosRQUFd10vEQSXSGCUVLa
 2mkV358m6a0ra7p7aU3+JgcNzyRoViOv2dHLDOquhMAatNLBis/3gwtD6W7pjxORPlXWselWOy
 AU3KGpbGS2slps2hGV/Ucc5dRlHihrzb7z64PmMAxid06qBkv7gxRsHEOUHLyIe/wXUGptSwA9
 8mqYHqdaEbFIBAAA=
X-Change-ID: 20260714-ipq5210-52e1da5af9fc
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=Y+ptIReN c=1 sm=1 tr=0 ts=6b052796 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=ut7fy3Y2aEGntDmQLfkA:9
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: eJ4J7JcKFcH5PQBDCMbr8TAMklvrKfBA
X-Proofpoint-ORIG-GUID: eJ4J7JcKFcH5PQBDCMbr8TAMklvrKfBA
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDAyMyBTYWx0ZWRfX5xU9c8Vmp/kq
 5lttS0VYNblVD3nWsSRhYb6mM5karQVfNOqaGwRn4fKsVwPCBTL+kabu3heJjR1V6Kfyw4H8Mar
 ve++mixOBLokp6FF0rsktOVp4mWPQSY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDAyMyBTYWx0ZWRfX6rfesNnHfltl
 qCoNX93G1bS2R2KVJPDvGqqqfM85m4pBSSBJE4PNf+14RFl1Qyr9bLF6XtdiIT/XrJ/IYOJYlND
 5qPkdi/deahfqsUAN/uNvqrAc9AZaWKhcwWSFXmGdm5y5La0COSp1ZbvcGoUqLMuLHyRUMQDbSG
 beDbH7YRpe0rUxvHu+PKhcuG2utVtseEb/EsK3NLt5hMaTjqDvjtK7jug5C+aQ+jaBAjGTraSd0
 QQj3esj7RySMaWgr38I/0SmIxoaVyTt45Q4dEAiRseEmQDRjdHzWvhWeS2RihXxsV900glGlogc
 cxKhA3Wh01m9fCb+ZjhpvxgngUg47eLrkZyQGU683syf84PQ1aJze8BwXzKYyf93Ni/t+8HuxNj
 h2TYJE0qrzGha9fQgByo9cEEFaD6UglBuGiW34/bxSHy+i8QGRHDTokyg6/7CYcdDI4DBntSO2h
 ecCbOqMDOR+KEl+94lA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_01,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 malwarescore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240023
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

As part of adding Qualcomm ipq5210 SoC U-Boot SPL & U-Boot proper support,
the mkmbn script has to be upgraded to create images that can be used
in the ipq5210 SoC.

These changes are to address the feedback in the 'Qualcomm IPQ5210 SoC
bringup' series [1] to use mkbn.

1 - https://lore.kernel.org/u-boot/78ff6a8d-5c63-4bc2-bf1e-6b71b8f9c6cf@linaro.org/

While at it, fix the MBN version number for ipq5424.

Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>

---
Changes in v5:
- Revert back to sm8550 full defconfig and instead of a config fragment in board/qualcomm
  per [1]
- Link to v4: https://lore.kernel.org/r/20261106-ipq5210-v4-0-5af12cc2b601@oss.qualcomm.com

Changes in v4:
- Drop sm8550 full defconfig and instead add a config fragment in board/qualcomm/sm8550.config
- Remove SPL_TEXT_BASE from mkmbn.py error mesage
- Link to v3: https://lore.kernel.org/r/20260917-ipq5210-v3-0-d11dc3e8b16e@oss.qualcomm.com

Changes in v3:
- Fix review comments
	- Add CONFIG_QCOM_GENERATE_MBN to qcom_sm8550_defconfig
	- Remove load address from MbnData and for all entries in boards table
	- Remove '--melf' option and modify the 'bin' argument to take
	  multiple files for combining into multi-elf.
- '--melf' was actually not removed in v2, but included in revision
  history. Apologies for the mistake.
- Link to v2: https://lore.kernel.org/r/20260910-ipq5210-v2-0-d209f7dc0fc5@oss.qualcomm.com

v2:
- Remove 'load address' from MbnData and get it from .config
- Add qcom_sm8550_defconfig
- Use 4K alignment for padding the MBN images
- Remove '--melfs' option and make them positional
Link for v1: https://lore.kernel.org/u-boot/20260714-ipq5210-v1-0-0b98251aabbd@oss.qualcomm.com/

1 - https://lore.kernel.org/u-boot/20261118140909.GT554944@bill-the-cat/

---
Varadarajan Narayanan (4):
      tools: qcom: mkmbn: Fix ipq5424 MBN version
      configs: add qcom_sm8550_defconfig and debug fragment
      tools: qcom: mkmbn: Add support for ipq5210
      tools: qcom: mkmbn: Add support to create multi-elf

 board/qualcomm/config.mk      |  2 +-
 configs/qcom_sm8550_defconfig | 16 ++++++++
 tools/qcom/mkmbn/mkmbn.py     | 85 +++++++++++++++++++++++++++++--------------
 3 files changed, 74 insertions(+), 29 deletions(-)
---
base-commit: 914dd2f5d18a3a89e4ddb6d1d97b2743618ae5ee
change-id: 20260714-ipq5210-52e1da5af9fc

Best regards,
-- 
Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>

