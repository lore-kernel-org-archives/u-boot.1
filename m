Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7EC6606A31B
	for <u-boot@archiver.kernel.org>; Thu,  5 Nov 2026 18:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=UEEMIqi+;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=EWVeFnyR;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=f0o3oRLK
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BCBB4811C0;
	Thu,  5 Nov 2026 18:26:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id n4PL44wbr4Zp; Thu,  5 Nov 2026 18:26:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E73A7811B2
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793903214;
	b=IIVMgzO9BSRPijJQFzriV95I0omgxKZfx5oopmmZypviTS4s8BvMLXgn7HC6L5ZiVc7s
	 csGskaOd0IXO1RA/HwpvnVCWtKGE5QjWM3sJgE7XpX/ShCQT8z+wsAuFDzQBRCGiQHVC3
	 BLM7m4tejEfcJXo7LFvVl1iRNny1zm0fbAcgJ9Ki0VlfAiFmxFvKUwIqzym1y0oWpGOLi
	 Ihc/0lSM7YjBYvx0vqURFwU34Q7OXrB6VTtZv0Vsgkp2EFkN/oMX4fNUkZSvdiOn8i23y
	 inOgEGzVsrkCiPzlBf/uoJsMsLyXiQX6QSNABDt2l1+Plpno2+U/rM8aTlYnUaB6QNw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793903214;
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
	bh=TiORPU4AOmCwdZa7GYRCcEvYSanXuNvxUqprVPCWubw=;
	b=HvYSFD1srNMl8hLvq9OGXGNLd1AtWgFk6rQOqzN56KE02EiqRpxqvyJNIIymVUzC3fEn
	 unTnZ6skzR0Hd9VC5m+tIzxLSlqsBTi5S/6xSbk/bHMWnUHYQ+X4GGXZ7s3cFu2u+53ps
	 Rqz1IvGB1HdeJ8vqIEra5+Q8k0DtYOrBsuwPNyO/WFr0FFFQh33uP2a6ltfTWxdrM5Tqc
	 MJM35gywfz+hhcL7e0XWpY0UM6kfm5TbAdPZB6mFZqqtN1x3m9eKRK7VTh19iqh+br7Bw
	 2xPAMP+60YslBVYgVNWOw84fAy1KvPN33/piM95YOAt0T1aRrSK1d2LcJJPtnMjhEQQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793903214;
	bh=TiORPU4AOmCwdZa7GYRCcEvYSanXuNvxUqprVPCWubw=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UEEMIqi+WsY8/ehna8FqS3flH+nDMPLazDreMZf6Nz33bQcfmLP30af82QxQv553n
	 PylygZhEhxHMXi4524G3/H3xeVcwyVOqQUxoEtV5QUZEQYttcA8zTITqjbUTMaXDBQ
	 lm/PnaFFS1z7G8mz2aBvvelymAZyI6vXmrUqQ+mWPy6CDwZsUNVWNSpl9KoKhW8qoj
	 eT9UKBTj44r/LjUSmBOG3A9jek09SWFHVkK0mCy/l29rPf8525eNakH59g/oVNBScV
	 pTB0vP6sgvJxKjMHJEoH4R6OzwnsSqC2aFUMDxEKjQkSqhDu2HwzNC0OFPDjAPSYZG
	 4NlOJKFGaq21w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E73A7811B2;
	Thu,  5 Nov 2026 18:26:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3652D31F
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 18:26:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2813E60833
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 18:26:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sU_UC7C0eAX1 for <u-boot@lists.u-boot-project.org>;
 Thu,  5 Nov 2026 18:26:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D1D8C608A2
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=EWVeFnyR; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=f0o3oRLK
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D1D8C608A2
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 18:26:50 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A5HeM4Q1485111
 for <u-boot@lists.u-boot-project.org>; Thu, 5 Nov 2026 18:26:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=TiORPU4AOmC
 wdZa7GYRCcEvYSanXuNvxUqprVPCWubw=; b=EWVeFnyREObKKL8inMrOzudAQJN
 3cNrDu56Yksm7czkyxjf/kN2FZaYEcT8wgCaI+Rwdizz6xUrClVUMPOD/Zkx6htE
 7t3EOOwftSOEeFEkPE680+lZxQ957bxmgH0YHUU6jCFpjNv0FEEo+uxe4fwk94+S
 5ZUQeH5yER0U4wx3mhrj87vpX8DN4yQkwNS/QHgv6bV1N/FblLnLYg6gYMa0UOGd
 seFDINICNtjTc85TOk3GWlfcMyzCPD4hsdhll5ykyTtgh0ZmG9qJcGEwMdsFneSD
 fP/4ItEtUIjptL333gOamYxookdQsesrpJLTC6APtRInVw/qQYr/5o833HQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrpaajmd1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 05 Nov 2026 18:26:49 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-36d1353fdcdso931290eec.0
 for <u-boot@lists.u-boot-project.org>; Thu, 05 Nov 2026 10:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793903208; x=1794508008;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=TiORPU4AOmCwdZa7GYRCcEvYSanXuNvxUqprVPCWubw=;
 b=f0o3oRLKot7rDfE1NV5+Qu2uN9Dg+x5eLduF4tsKM8OSZGGSnPK4nUSQ+c7qXt2fp+
 KG4DuiDeLJaARvij28uxFQsjR74BLRCdPARtOUNj5dLCsYVsX+SrLfOqGq3Ix/9UtCRD
 7aeRCR8m5xXjowaWZsvMnK/8Fc2lfe2m03qGyTOnvVKmxK6q/bcY9hVdEyC3QfSnViw5
 hGYrC9PVRWvxDf0v4jBrGt1wf8lG1V1RmPNZGlxnF1oEj61xmpUElmmT7wF472BBtz9g
 VJ3sdxhVE3Q7jKByC3vYxFRwK9bM0IvzygPvUnedj/hzKuQcUa8NQVH6RhucaiX8LXjB
 QmFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793903208; x=1794508008;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=TiORPU4AOmCwdZa7GYRCcEvYSanXuNvxUqprVPCWubw=;
 b=x3TrE2oqcJPCqy1+NAauKCYOUPfjl+BjS9WcpGZv1BlZlhSCRpiOQpBLISMDvaJV09
 ixDVVrrfNcSPX4dGkLR7J/Vh8/G0axehZ3uGZ9ioAwxSZu67441CZ2KLbbcZVPZymmk7
 RrOn3UB69yTArMnMJshNT5PlU/zZbUBkkaeMDczSuJ2iSUtrFdsc86FJ9Y1DJQdaVSuI
 K9yR2xmX0Jai1NLlpO7kU8VQJufEHgAPL04/qvnypFuz/4Dtum6jAjUarBGAiLYAJg5O
 xI1mQlEj9yoCXqsoF1IWdi6IOyJV5H/vy3kJvWEmuBYtf8iFTCLiJioOVPydkf/LOAld
 xo7g==
X-Forwarded-Encrypted: i=1;
 AKwUvBy+LxEGD1ih76gDAaSzRrUnfz9ZhqgP9xxQJZXqCV151PmoyoxcMdqwYjPMSlFiO/ccP8M8mjQ=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9vnggRDI4B01zIZxxcvmgq9eCahO0to0tXEhYXM75d7YAYpfUf
 G8CaCxHL6gyIaqyLWAz3QFCmlko/ahUW1cRbIFuSNHCA/7y5GYQ53H7MF3JXPdBlvzSIzcgx4DP
 /PGBNst3voXbFDrfibEX3eN8RKEgfn8XFr+Ah9/Jwc7w/0Tpr5t4HBv8BbNfzucCs5HtWXA8=
X-Gm-Gg: AYBFou0ibDDwL/9/SzJaTPWVLN1l0VwdbvTLUbdzm+nuGYtae7vZHZArr1YsGrL1LWa
 3mOGu6jqe9SMUY/4RCOaw3PXAXgbZrLATY+p5naY+I9+hqa0bBUxvVeQn+TqEfWtxISyQIJyp9C
 n9Nw4HO79O4nqyqMVstlDX9ihsBKZ9nsvGs7svenQoaVbVxHZeXbDnL1bsPh6j4DB0LGz0xGnMB
 yA0MJqML9Qsvne0cfPSdxhzHVVgB9nI63HEbfZfqyKxX+QtxW/yUUJjeZA2rfKiTzohTk5+jbbG
 FW/OCchdm22g1ppTi6Up5pCtuHbZoWCTya9vg923neg19DT6sX/W1Uy0EEExMv7d1HIwrVeC+xS
 zgrPUm7PKlTrT2plXWYRKZH3QJzYIJaPIJ0a6UW2r7NYRWMjdMFhHfhWzS9fTbYTmZpn4j+QMb0
 hFNmv3TTsZUk+PPxzRJJ8KCaPxklUWhec39zRMHihZrU9VwoGid3muD0mirzU52n0V7Bol
X-Received: by 2002:a05:7300:4353:b0:369:fc93:eda5 with SMTP id
 5a478bee46e88-36a42434630mr42367240eec.39.1793903208030; 
 Thu, 05 Nov 2026 10:26:48 -0800 (PST)
X-Received: by 2002:a05:7300:4353:b0:369:fc93:eda5 with SMTP id
 5a478bee46e88-36a42434630mr42367188eec.39.1793903207563; 
 Thu, 05 Nov 2026 10:26:47 -0800 (PST)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36f6b2be5bcsm141198eec.6.2026.11.05.10.26.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 10:26:47 -0800 (PST)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com,
 aswin.murugan@oss.qualcomm.com, lukma@nabladev.com,
 nathbappai@gmail.com, balaji.selvanathan@oss.qualcomm.com,
 Michael.Srba@seznam.cz, tyler.baker@oss.qualcomm.com,
 jbx6244@gmail.com, nikroks@mainlining.org,
 bartosz.golaszewski@oss.qualcomm.com, shengchao.guo@oss.qualcomm.com,
 andersson@kernel.org, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v4 04/13] clk: qcom: add NWGCC driver for nord
Date: Thu,  5 Nov 2026 23:56:05 +0530
Message-Id: <20261105182614.2405482-5-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261105182614.2405482-1-aswin.murugan@oss.qualcomm.com>
References: <20261105182614.2405482-1-aswin.murugan@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA3MyBTYWx0ZWRfXymFRyBoGxES7
 Jstk2q0fhPxvTruyM3hXRNs0Tkz3/ygXksS2+lj31/BY7jF0hsSEX040bX5G/Zi4btPPxEmPtXZ
 UDYYZif0oT5Ms3Iq9h9FSCIsL3qrUm1CDy5awCKSHwbyjExBh5i8t4aVLxLAA90jXX9NodVehms
 8yOKyt+jRhLGQPujxSMNllzD6Yq2DBImn0bNXM6F7MpCFLJTxuNwMSXxpwWDBBA93pCS1LWfkxr
 VaVECTJJB7I/0LGPX2YoEWRfBn5qtS3XfAqXWY41UAHNiCQfo3WYhSYbqfpPAoU560zl2nay14A
 6j+8Pb4TsY64VtZttrf588ykD1Pu+1E8wzb+zzSGCzSgnV7SDAiGuP6XhvG6rdHZf2c8KNbghha
 6klDozHPxnxf61LPjU/qA8WNme/3U8UqBIOeUpHJrY0TxkAPP/JQa4rOyw22VjvSkqkbgh6cstc
 onnR43K/IgQ8oYfojLQ==
X-Proofpoint-GUID: qYXM9InqIFwb21aKB4seWUdeJxPL03n0
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA3MyBTYWx0ZWRfX451ghrZCWx0d
 cNZvqTo87JM1lm7psenXCW6B59ENfmDBHqrvtw4LWfTCWqiS7fd52lYJsHj7NlMsa2ZZduLJfgl
 kr2StAERyzQrmIr6QNB5Y0O+WfTzLJI=
X-Proofpoint-ORIG-GUID: qYXM9InqIFwb21aKB4seWUdeJxPL03n0
X-Authority-Analysis: v=2.4 cv=WOXqzXsR c=1 sm=1 tr=0 ts=6aecca69 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=pD1Co-7Bf1NQk9G-IDYA:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_05,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 phishscore=0 suspectscore=0
 impostorscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611050073
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

Add support for the nord NW Global Clock Controller (NWGCC).

Implement the qcom,nord-nwgcc driver to provide clocks, resets and
power domains required by nord peripherals.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 drivers/clk/qcom/Makefile           |  1 +
 drivers/clk/qcom/clock-nord-nwgcc.c | 91 +++++++++++++++++++++++++++++
 2 files changed, 92 insertions(+)
 create mode 100644 drivers/clk/qcom/clock-nord-nwgcc.c

diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
index 816c862932b..19cee32f9ba 100644
--- a/drivers/clk/qcom/Makefile
+++ b/drivers/clk/qcom/Makefile
@@ -13,6 +13,7 @@ obj-$(CONFIG_CLK_QCOM_MILOS) += clock-milos.o
 obj-$(CONFIG_CLK_QCOM_NORD) += clock-nord-gcc.o
 obj-$(CONFIG_CLK_QCOM_NORD) += clock-nord-negcc.o
 obj-$(CONFIG_CLK_QCOM_NORD) += clock-nord-segcc.o
+obj-$(CONFIG_CLK_QCOM_NORD) += clock-nord-nwgcc.o
 obj-$(CONFIG_CLK_QCOM_QCM2290) += clock-qcm2290.o
 obj-$(CONFIG_CLK_QCOM_QCS404) += clock-qcs404.o
 obj-$(CONFIG_CLK_QCOM_QCS8300) += clock-qcs8300.o
diff --git a/drivers/clk/qcom/clock-nord-nwgcc.c b/drivers/clk/qcom/clock-nord-nwgcc.c
new file mode 100644
index 00000000000..bfcfb559ed0
--- /dev/null
+++ b/drivers/clk/qcom/clock-nord-nwgcc.c
@@ -0,0 +1,91 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ */
+
+#include <linux/types.h>
+#include <clk-uclass.h>
+#include <dm.h>
+#include <linux/delay.h>
+#include <asm/io.h>
+#include <linux/bitops.h>
+#include <dt-bindings/clock/qcom,nord-nwgcc.h>
+#include "clock-qcom.h"
+
+static const struct gate_clk nord_nwgcc_clks[] = {
+	GATE_CLK_POLLED(NW_GCC_CAMERA_TRIG_CLK,        0x16034, BIT(0), 0x16034),
+	GATE_CLK_POLLED(NW_GCC_DISP_0_TRIG_CLK,        0x1801c, BIT(0), 0x1801c),
+	GATE_CLK_POLLED(NW_GCC_DISP_1_TRIG_CLK,        0x1901c, BIT(0), 0x1901c),
+	GATE_CLK_POLLED(NW_GCC_EVA_TRIG_CLK,           0x1b028, BIT(0), 0x1b028),
+	GATE_CLK_POLLED(NW_GCC_GPU_2_GPLL0_CLK_SRC,    0x76000, BIT(6), 0x24150),
+	GATE_CLK_POLLED(NW_GCC_GPU_2_GPLL0_DIV_CLK_SRC, 0x76000, BIT(7), 0x24158),
+	GATE_CLK_POLLED(NW_GCC_GPU_2_HSCNOC_GFX_CLK,   0x2400c, BIT(0), 0x2400c),
+	GATE_CLK_POLLED(NW_GCC_GPU_GPLL0_CLK_SRC,      0x76000, BIT(4), 0x23150),
+	GATE_CLK_POLLED(NW_GCC_GPU_GPLL0_DIV_CLK_SRC,  0x76000, BIT(5), 0x23158),
+	GATE_CLK_POLLED(NW_GCC_GPU_SMMU_VOTE_CLK,      0x86038, BIT(0), 0x86038),
+	GATE_CLK_POLLED(NW_GCC_MMU_1_TCU_VOTE_CLK,     0x86040, BIT(0), 0x86040),
+
+	GATE_CLK_POLLED(NW_GCC_ACMU_MUX_CLK,        0x1f01c, BIT(0), 0x1f01c),
+	GATE_CLK(NW_GCC_CAMERA_HF_AXI_CLK,     0x16008, BIT(0)),
+	GATE_CLK(NW_GCC_CAMERA_SF_AXI_CLK,     0x1601c, BIT(0)),
+	GATE_CLK(NW_GCC_DISP_0_HF_AXI_CLK,     0x18008, BIT(0)),
+	GATE_CLK(NW_GCC_DISP_1_HF_AXI_CLK,     0x19008, BIT(0)),
+	GATE_CLK(NW_GCC_DPRX0_AXI_HF_CLK,      0x29004, BIT(0)),
+	GATE_CLK(NW_GCC_DPRX1_AXI_HF_CLK,      0x2a004, BIT(0)),
+	GATE_CLK(NW_GCC_EVA_AXI0C_CLK,         0x1b01c, BIT(0)),
+	GATE_CLK(NW_GCC_EVA_AXI0_CLK,          0x1b008, BIT(0)),
+	GATE_CLK_POLLED(NW_GCC_FRQ_MEASURE_REF_CLK, 0x1f008, BIT(0), 0x1f008),
+	GATE_CLK_POLLED(NW_GCC_GP1_CLK,             0x20000, BIT(0), 0x20000),
+	GATE_CLK_POLLED(NW_GCC_GP2_CLK,             0x21000, BIT(0), 0x21000),
+	GATE_CLK(NW_GCC_GPU_HSCNOC_GFX_CLK,    0x2300c, BIT(0)),
+	GATE_CLK(NW_GCC_HSCNOC_GPU_2_AXI_CLK,  0x24160, BIT(0)),
+	GATE_CLK(NW_GCC_HSCNOC_GPU_AXI_CLK,    0x23160, BIT(0)),
+	GATE_CLK(NW_GCC_VIDEO_AXI0C_CLK,       0x1a01c, BIT(0)),
+	GATE_CLK(NW_GCC_VIDEO_AXI0_CLK,        0x1a008, BIT(0)),
+	GATE_CLK(NW_GCC_VIDEO_AXI1_CLK,        0x1a030, BIT(0)),
+};
+
+static int nord_nwgcc_enable(struct clk *clk)
+{
+	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
+
+	return qcom_gate_clk_en(priv, clk->id);
+}
+
+static const struct qcom_reset_map nord_nwgcc_resets[] = {
+	[NW_GCC_CAMERA_BCR] = { 0x16000 },
+	[NW_GCC_DISPLAY_0_BCR] = { 0x18000 },
+	[NW_GCC_DISPLAY_1_BCR] = { 0x19000 },
+	[NW_GCC_DPRX0_BCR] = { 0x29000 },
+	[NW_GCC_DPRX1_BCR] = { 0x2a000 },
+	[NW_GCC_EVA_BCR] = { 0x1b000 },
+	[NW_GCC_GPU_2_BCR] = { 0x24000 },
+	[NW_GCC_GPU_BCR] = { 0x23000 },
+	[NW_GCC_VIDEO_BCR] = { 0x1a000 },
+};
+
+static struct msm_clk_data nord_nwgcc_data = {
+	.resets = nord_nwgcc_resets,
+	.num_resets = ARRAY_SIZE(nord_nwgcc_resets),
+	.clks = nord_nwgcc_clks,
+	.num_clks = ARRAY_SIZE(nord_nwgcc_clks),
+
+	.enable = nord_nwgcc_enable,
+};
+
+static const struct udevice_id gcc_nord_nwgcc_of_match[] = {
+	{
+		.compatible = "qcom,nord-nwgcc",
+		.data = (ulong)&nord_nwgcc_data,
+	},
+	{ }
+};
+
+U_BOOT_DRIVER(gcc_nord_nwgcc) = {
+	.name		= "gcc_nord_nwgcc",
+	.id		= UCLASS_NOP,
+	.of_match	= gcc_nord_nwgcc_of_match,
+	.bind		= qcom_cc_bind,
+	.flags		= DM_FLAG_PRE_RELOC | DM_FLAG_DEFAULT_PD_CTRL_OFF,
+};
-- 
2.34.1

