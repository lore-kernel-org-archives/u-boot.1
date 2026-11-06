Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032C2606A326
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 06:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Vrj2ysrN;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TnLheP2P;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=drTac8hm
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5378C80F61;
	Fri,  6 Nov 2026 06:12:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tL8dVD7SDHO0; Fri,  6 Nov 2026 06:12:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7B43380F4D
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793945551;
	b=hU4rFd+OnoIAwOk+Xq39cFF/P8gk5mc87cyoaAMF+W2J2wOWc+aDVe1VihCN8zRfiRS7
	 nDRBVPM0GT/mY/h6l4ST3ckyXCzLYtU8Kgbmw38dY5l/e9p0WPvUitdI4dBcZigkte7Em
	 BAG0YNbliHlrxxn0zG+TqnXWPirTDyQF0VtK4II/81t8xnaliHi8NcRl8d5Jp5Acg/O4g
	 Dcy46NPYaGKMZLfTFtqDxcg8wdgceuTs2Jg4xeWkbC5kbtjlHC5PvZR3mMzGNoEETgMMD
	 txKk4WA7KqBjhaDe1Z/9DHmFGUyLeslU5zyF3E7U2Bg7X6m/3QUk40r3o+QqpAwBiCg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793945551;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=qy/UTCRvUX/b/Mhgltd8wWBdHN3estwUcSuWgO8i7P4=;
	b=IFs/dVpb4QnER7YxOZorpwMMEMiXqjekgR2Rya+/j8p3eJtRQS+b9sFAL7UlWiSNwHwS
	 K2DkxkRUn4wD1BMBAmswOp0aSuLrPPPTU2vaDvY201hQWwfbTzlltdRPQZx7YTXD0ASe6
	 9bW3nkg3bxgDaJMrEZTFuOC8qwmSyjHLUaGNyVTPGswiBSWlvR2PdyqXCDi4QAdC/ilD1
	 s715bX3p/65k84xYYS8G7w1ri+0L1FKPWHPPqsvRnS46j36GsgQKdhRQcBEUmAPiWDXHw
	 4L1pyfSjBcwpBF7jlx6cEpQUGAGtHewaJRex1jzBZyIywL8b884Mx6A3Y/s2kBLP3Ow==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793945551;
	bh=qy/UTCRvUX/b/Mhgltd8wWBdHN3estwUcSuWgO8i7P4=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Vrj2ysrNJROyW/I+1lPRayHXENKtwJaY1BySNlLZaEK3pfKfJRrwoY7Gzjt8zN48t
	 n3ACvzpFhY/rCiIhC+AuScNfn8v7/eDfaF1WjRSCqKKeGZRnpVDI0iso5qGJRLzdDY
	 ZBI9MruO4Ah+01e9x1PLquocid7fFTykaXr9e0PQ3alliZ4A8rJVQlqa4TpE5UE2YP
	 rP00AbyZerpP0/AtTrZ0Pgrm9c+/1uFrCkGbnOxUgIr21RYWhUZ7nd8axeHo7UwrZY
	 2LaW+jBWH8UV5TJmBhA2q71qJLxvyNcGi0Mvf3cFfCxxwGjju6bB3YyItffAfLRiqC
	 2O56oTJSIIRlA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7B43380F4D;
	Fri,  6 Nov 2026 06:12:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8FFB032A
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 06:12:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7593E406A1
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 06:12:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wc6VoLBfHbwT for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 06:12:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B1751405C5
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=TnLheP2P; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=drTac8hm
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B1751405C5
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 06:12:29 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A640Cnt3857022
 for <u-boot@lists.u-boot-project.org>; Fri, 6 Nov 2026 06:12:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=qy/UTCRvUX/b/Mhgltd8wWBdHN3estwUcSu
 WgO8i7P4=; b=TnLheP2PQmrSD7FdQQcW9LXps6iL6zJkZ2jsOaCxGJ4cjwM7lPs
 WiNalSzqDuuRm8ltq80WZD2eexKFFKIcroGGzsRTlXRyA9bz0y+UOU0nslMNip9F
 kJ1YxzYyTlaFDXwkq65S/aUidngo7AsLGd+d+uDHxAA/53UwQT+Ru+FLsjgaZqT3
 pLYrVgY1LL0tKiDr1KJmbEmHfLj+vtezVXKkF5ddspG8tz1S4H+mCcEh6Xbgpo9S
 fSPK5DN+r8gBuoJ9Qz4I1kbFgoQEumf9S8p1AcYVD/s0J6qVrgd8dosaa1dDOR4s
 0O7DBS5W+cqYwZnYZ8FYM+1IrheBD9UakqA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hs3p9s86a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 06:12:28 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-33c35f5ca6cso655994eec.1
 for <u-boot@lists.u-boot-project.org>; Thu, 05 Nov 2026 22:12:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793945548; x=1794550348;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=qy/UTCRvUX/b/Mhgltd8wWBdHN3estwUcSuWgO8i7P4=;
 b=drTac8hmS4Qq8DOJaroXNKVszadfAsD10KKVEZFBWc41jrco6Xa3MAuOYM243jbiCd
 tLu4bl5cVCPq88E5yhak5Lg39oAAIJm5i1nXtoOSQatV3p19aCVUJP8ZmmV++wKlWnsg
 6AkppFIWKucuhUoUv7FlnAxxk8CAo8mJpvgS0MY16Fi731fE9LP+0BaiykP6rBJBb7vI
 HjLYBDigJnMgSvux5jGbc2dL5zeFk99V8uFp8EuyyC5veYlqAr7fVOavNKEcM7NB8LWC
 RjYC4ZGAkcQi9yhe9Y0Wefp54Id8N3NdoLYmhzlwaE7EVUJfGOS/+aZJMZdJBNHIdBU5
 kt5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793945548; x=1794550348;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=qy/UTCRvUX/b/Mhgltd8wWBdHN3estwUcSuWgO8i7P4=;
 b=EFT5UX8qPCOpY3sIl4t7CAEPWP4j0ntC8oFbZNogaygJPam3KULAMopRCE0yFJ00qX
 V9tUNh+ZR1HMY35xmpKi734QjmibN6uYQgEhCgmT+pu5HGXsQWmNOOm9/cg8ApHhBxf3
 TzaqKJIs+TPm2lVGG8L/uV7VrFp5HINyyaNY69T2SLfY60gXHymUu+DviBNetMePSGqF
 236B7DsCaVQvwV9wec+PNTF2PEzngLLWw9XT6QC0xXoGBtLoSKgsH0r9E9CHcm8jMtHB
 p7Zb666p4oCnQII3jeFobLGMd05UX675vEAijfdj3IVjHu9BH3x+ZEQ9NcyJ3N1rTzHw
 Iyew==
X-Forwarded-Encrypted: i=1;
 AKwUvBxlgcc0NoKzemOFnV9zZCcdclEUoY2x6D4GpUrYu+7EzsIGR0Obj+iNMA74M1cV7bGSgXGvz6M=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/hjJyDFPb8Il6BY/qIJTvYa3OTw/yuHYX4IVQVC7BCqpEq8N6f
 Ys01ghQpL5WLSKtryEv6DTX9bzJk0nCFsSh3cKJdeVlFFf1HaQagiP7mIxEkNfBphKcuUKQi+fx
 E6QDl8bT2b8uYm6elxusdolFwG+vaLr1epRb/+aX3VNUmqLDcLZSZySFzcsVZne3HC+lcPEs=
X-Gm-Gg: AYBFou2YE4alqyOgaUCMLz9bRwTI2iBseAKyDnIVATjH7b6z+HVc2zrgXV0ekZCZeVj
 DNP9mp1XNWOQ9YXSmeKFHJIqIFIQjLn7r7pr1jxoXWDbMkn206XzSh+ZL1IlFWeVQ6A8kyqPN8b
 jS7KVY3NPDyG+HSy+O+5XtqX9AV4XzjiYAHnimQQZ2zb7M+LgPv5EqnrIf2KVkLHccJbS5zXO4v
 kGQItcuOFf+6LwVsurOfxLVwIf99qxgb7sxmh3DLCuL9DQYuGH3PtYIGup+bRSlBwmsdN46tBLx
 EugrcwvUJq59iLOH1YRW3ycnrlWnSLAjOcMCYoexbgY7lhwCQ4+ZkAQT6+XLln9UX8ZnvIS42Yq
 0QzEuf1bnNuRsp2MSCRvqEnIi7jP1t1vr7mxHWTKYDemUxqQvkUUsC/j+WUUpd8WIETL7ActWD+
 Qkv2/UPJSRDciN9bZIPbUwUAmHiOsITErtbCpNvqcksVJehIKaKChvIzT61kI2qfmLChs=
X-Received: by 2002:a05:7300:f58b:b0:35c:f667:8b9a with SMTP id
 5a478bee46e88-36f75253776mr2217499eec.6.1793945547790; 
 Thu, 05 Nov 2026 22:12:27 -0800 (PST)
X-Received: by 2002:a05:7300:f58b:b0:35c:f667:8b9a with SMTP id
 5a478bee46e88-36f75253776mr2217468eec.6.1793945547275; 
 Thu, 05 Nov 2026 22:12:27 -0800 (PST)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36faa5afffasm3608039eec.25.2026.11.05.22.12.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 22:12:26 -0800 (PST)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: rayagonda.kokatanur@broadcom.com, trini@konsulko.com,
 ilias.apalodimas@linaro.org, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org,
 Michael.Srba@seznam.cz, jbx6244@gmail.com, nathbappai@gmail.com,
 balaji.selvanathan@oss.qualcomm.com, naveen.osdev@gmail.com,
 aswin.murugan@oss.qualcomm.com, u-boot@lists.u-boot-project.org,
 u-boot-qcom@groups.io
Subject: [PATCH v2 0/2] qcom: Enable CONFIG_SKIP_EARLY_DM for Faster Boot
Date: Fri,  6 Nov 2026 11:42:00 +0530
Message-Id: <20261106061202.3049194-1-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDAyNCBTYWx0ZWRfX5Ls2FimRr2sW
 bK9ET1jRbSSBEP5Q9olXPxDgkdOxhF/BcKNHCu79LsxQQuR77yHymTMyOtAb46XuTmwgxwWt72m
 NlxKuF+3u6epurObKoGWf3JcU/ahAss=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDAyNCBTYWx0ZWRfXzGB6oI48xZ3N
 uoju5x5cttQygsh5zcI0/o5I75frlgiurTqWyXwjJtUibll9jpPsY+PltE+oPkWgP/74n1GTMFU
 1hH/2fE7/fn+DVBT83qS4LLW9mjJe9Pic1kaeKVIacj4QMWfqkMeshJAbPOegY010NrI3PZtB/D
 oC4bq17AnuObj7f6bAFLiNRApE1+Pw/JkhPumEN4b/UbgIeP3sOBqMMU8r1QO6la1i1CBh4vEbL
 2PJSpk3YMqPAcR0GJA2cCubsw1EJhvSlSuopqlbgQhWc/lrDWBRzilcVwVfTojCZxmGCWz6mEVK
 +KFGrTzE+2UQ58h0JzPtIRgnnqLlyMbWHZkXlR4W2fXOi57R5kJCyboHxsF+YNgK4zLh2wLNytg
 7akcVGkTLxrPFQLWZ6o8es0nIKx8hnQODOOmqi4rGuKcDW0bH7KNEu8yYTSlqM3CDqtp9FSgjMa
 CK39gR2xt7udAEjpd3g==
X-Proofpoint-ORIG-GUID: S5isRJhTbfxrjFZKEEHyeOlM_ft32jXU
X-Authority-Analysis: v=2.4 cv=f6Pdl+yM c=1 sm=1 tr=0 ts=6aed6fcc cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=hrX1pVykQ6R50l7j1osA:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: S5isRJhTbfxrjFZKEEHyeOlM_ft32jXU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_01,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 bulkscore=0 phishscore=0
 adultscore=0 spamscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060024
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Enable CONFIG_SKIP_EARLY_DM on Qualcomm platforms to improve
boot time by approximately 50%. Address a serial driver
crash seen with CONFIG_SKIP_EARLY_DM enabled by properly
handling error pointers returned from clock operations
during early boot.

Changes in v2:
- Move CONFIG_SKIP_EARLY_DM from qcom_defconfig to an imply
  on ARCH_SNAPDRAGON in Kconfig

Link to v1: https://lore.kernel.org/u-boot/20261008103146.706211-1-aswin.murugan@oss.qualcomm.com/#t

Aswin Murugan (2):
  mach-snapdragon: Kconfig: imply SKIP_EARLY_DM for ARCH_SNAPDRAGON
  serial: msm_geni: Fix clock enable on error pointer

 arch/arm/Kconfig                 | 1 +
 drivers/serial/serial_msm_geni.c | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

-- 
2.34.1

