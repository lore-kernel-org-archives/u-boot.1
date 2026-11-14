Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19BC606A337
	for <u-boot@archiver.kernel.org>; Sat, 14 Nov 2026 09:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=GPQHhA0D;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=iVrWJ7tl;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TO6SbCQJ
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CD55081971;
	Sat, 14 Nov 2026 09:19:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3R8_pkjr5N4e; Sat, 14 Nov 2026 09:19:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B947481801
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794647944;
	b=gz9BNofNmg4j8C3xwSmUSxftmj12knT1V6ZbwEnQTwhRgABA9WtCNKwlpOz97Ja8JSz+
	 z1CRJP35J9U/v1SzYGZL9ZTwaSu9vXGVjFAsYQZBPXR7wXPaeseL/qHZi4SOWTztl66gR
	 i/VXE0k6jZIMofTrWamIajibkTfJsDnNu4oWH1/ZKTAvOyOqe9iEdVLtemSrsHFqDX+TH
	 Vfyz0qJTwt6hEjgXHWRdlw+oecm/czGdpU0TO3Jem8jIvbtDdc36UAZPU/YmLTH0GLQ0S
	 IJDFmzYrAjMAUR6McmW8tbA6KkqfYUIu50i3jIaM0ShvEWQ0YFZJsTOXEWv8p+O/v/g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794647944;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=BHMuiihPcD9jQAR37jJEOTAxJ37dyaTaJhSmU+HwtWs=;
	b=pCPqjKzSujvnlVrETEim8952vH9kCvnN8noiUBgap5G3n06ZsQmOJBuYk334DTnmF2j4
	 cx8Dt/eBazyYEwHigEhAwR/YAAWQUyOGPm0RQcjn2mCXXXv0xs2QhIPLgjrxwjdw9fRHM
	 MoUtYGCqlpVZbpzkIr4tj/pC7o7qyxNd/h8mKiIyWZJ/aDD4ZANZ0esOmPmCi88ilXrpa
	 7e6LRM3isM5yE77LcGo8yA+xQQhFvwvTf+lgJXnPntLJQ8OLrOIsyfm95xDVqRTl6D94w
	 fXrgpWVrYxfwgAGTo8JvNpm3Bfsj9DO0F3q0Et5EjhRUJNqYkCRESaVfswwcYADZ++Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794647944;
	bh=BHMuiihPcD9jQAR37jJEOTAxJ37dyaTaJhSmU+HwtWs=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=GPQHhA0DWqt5I/r9zY/RnjHwe4tvhl1AsPkeE6L1MFl4FvBg/qlzfwrmxgk8QVnz8
	 q0i2EkmYOOwM9Dm0GCVJKBPHMdN7FLmr4jqEr5c+u3Q/HXGF7GZSFjYFfyeNEOK/Lh
	 f5xW9p8BqEOr+jGwrEPtSU1kZxzR9MgVRzhnm0UnmkhbeFQVeVbmn+ce9UWaxyp65W
	 y2Eg534K6iVjKn7nNI5e/CxcqQg2xTbxO+YNYsWU+OmCfB7DMNe8EStzu2njcYLKzf
	 MLV+evdLlBA1ddDCjiH6PxGAz5jgUafTZnUEe5qHOlMk4LhH8FZhq28lFTg4UZbUBd
	 0DR8ZehwzAz9Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B947481801;
	Sat, 14 Nov 2026 09:19:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 280E128C
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 09:19:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0A8CD40DD7
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 09:19:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Wjzy5sMo3pSd for <u-boot@lists.u-boot-project.org>;
 Sat, 14 Nov 2026 09:19:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 309BD40DC3
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=iVrWJ7tl; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=TO6SbCQJ
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 309BD40DC3
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 09:19:00 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AE60up7603863
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 09:18:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=BHMuiihPcD9jQAR37jJEOT
 AxJ37dyaTaJhSmU+HwtWs=; b=iVrWJ7tlsByNtcIY1t+wLGwrcPQCTztglmTRZe
 4oRSQz/VY3QuzCVa3sHf3rPGZ/RHDsApKkh5cawX/7fLJJ7s2/M+6khi7Qo9km4I
 z5AFDZP4H3Xr9iibYHisEQdCBkGmlYwkzDkWvhlHGg+BN4OQ6yfOi5t4Kt/YSwwg
 urTgccG6YLrGr1pKIgM02h9Q9b8FR19Gdn5AtuLJD+UQSs09TeKod9RcJsPJherB
 ezcEzBbn7pXH7SFgcnPfFtn2/gYArLulawxXqPefP2LEw3CbIa9jhvVKB7KzDYlJ
 xgcu2XTsexaRYMvfOncGWNwVxxgbF/+ATpjcwPkOta4yk66A==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhm8rcye-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 09:18:59 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-36f479b9819so2096475eec.1
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 01:18:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794647939; x=1795252739;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=BHMuiihPcD9jQAR37jJEOTAxJ37dyaTaJhSmU+HwtWs=;
 b=TO6SbCQJFz8M9/+NyQrAXdlIBnkYwquyamQC3xQH62OEcUdTZGakIkTH2D8A5p7qWs
 8NbneHpEzktpX2ZzQHPCL/qb3kRl56YJ3Lef9j8v9WOcLVXFJcEA4jVlOI3Sy/UotXS8
 KHNSOicQCuvgF2ZdjzaQCIpQEZ/rk90yq5sp3sF4GWJz0vDTOJ675jsaUp/+7qeTr8rb
 bvJIklo/f/PKdpsZu45ux8culgmpzFNA0IbD2OzMNuSEXRmZyKVknhXE8B/itLr2siAt
 we/Fgp2i7arT/UXIWTJA7VEDqu3abbXfFeEOHxcgvR+f5bM1E3/lXBrgvStmzS5SbY+i
 yr2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794647939; x=1795252739;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=BHMuiihPcD9jQAR37jJEOTAxJ37dyaTaJhSmU+HwtWs=;
 b=OmjfhsZybFCa7jB4odsN9Pv2ypSElXm75OHuhCNQ81ybyMGTM1cKCUA1DMUeNWW/Dc
 5JG1FpOkyHEYDcniZfaXpDbRb4jYxYa/3dBLpd80R7FB5fM8E+aUyv0fUPd+UKs6+bFw
 AtVC05hCphXwc7Q00IXmMHQxteXMB9BlwHlxNAL4/sbaOqsdTQ+hpdbGv3h8rqrYnuof
 LUUVTKQEmSlV6sHKx0WuDdm29lOgfMRHnBPL+nkP8iRgNS3ZFUf/phCguxbs8qWEn9l9
 QGNf64vYVP1lr4Eh9mtdZZkzPyshhsPztAD1ATKwYugZxwBysYfo7sJVJ8ITjMcvPejd
 40uw==
X-Gm-Message-State: APuU4Z+cgQRucVc61PTv766Rhx/01rCd6rfqliKmeY9Of2tZXSh3LObC
 EqbvbVu7xOlMbDCtGImB0HLULgURwJEDoebNSQGjaeDy03zEG9+mfHmuST6/Pi2XJh0SY77Fze3
 YlK8DTsJjBNiW09m0PT8hgCq+YGDSj6XjZdNSsduIBv1cCqDa/eggwXb3BB2afyb0sITHWoY=
X-Gm-Gg: AYBFou1AaG6fBQXX3pwnpGAvAilT78Id1E8H7yOklGhuE7jMUOqM+Pn5ckGdUHnp5xa
 6qRs6Tj7r6ewTOubKTiyDv+wKW99MYhpuHYOIaEHO0aGI32h88ApvSOoDTcvIv8EzGgOybDiOPe
 +uRlC48Miyj8uBCq6MGZTIF5TiGzefeVHsI867NtX1II0z6h7Gwfuhj5tXZZ6TyKdhXy2AUvlZr
 +nSq5Q0ufzTeZu6dU9hP27+r0m/tSFBDPLs6WH//E8Wv/sh2OC/n5K5EFZypNXHeBSCqY1Lx3Ym
 b2aMV4uL4pihxbQe1GHrpAtx4cWhCZQLvqOrPqdMPPe4UxjumElzDuImejse/5aItO0FWRXE0jE
 cYZAZ57oKb+8xAv24pYVr74/e0Pu9Fw7SDkULqwZ1wSbV2FjmyhZFy0kjfVSnKNaN0kUvz0am6p
 yztp0PlcIoPij62sPTtxPS5sf27+uzVO9hOyfDEPUn2VzQCcqA+Dn8xx2rog7qvc2o3xjql163+
 9Si
X-Received: by 2002:a05:7301:6184:20b0:36e:a179:85f2 with SMTP id
 5a478bee46e88-379675fea57mr4512306eec.23.1794647938364; 
 Sat, 14 Nov 2026 01:18:58 -0800 (PST)
X-Received: by 2002:a05:7301:6184:20b0:36e:a179:85f2 with SMTP id
 5a478bee46e88-379675fea57mr4512288eec.23.1794647937553; 
 Sat, 14 Nov 2026 01:18:57 -0800 (PST)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-37955332ae7sm23935955eec.8.2026.11.14.01.18.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Nov 2026 01:18:57 -0800 (PST)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Sat, 14 Nov 2026 14:48:53 +0530
Subject: [PATCH v2] efi_loader: Extract FW version even on authentication
 failure
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261114-efi-fw-version-auth-fail-v2-1-f6f098fa406b@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAHwn+GoC/x2NQQ6DIBBFr2JYdwygKW1XvUfjAmGoJFotg7SN8
 e5FNpO8n//fbIwweCR2qzYWMHny8yuDPFXMDPr1RPA2M5NcnoUQLaDz4D6QMBxV0GscwGk/grL
 G8F5q5RRneb6EXP0W9aPLPHiKc/iVT0kcaZHyi2iKFClEGDVF0DHitERIAjg0PQolXavs1d5no
 vq96tHM01Tnw7p93/++AhMexAAAAA==
X-Change-ID: 20261114-efi-fw-version-auth-fail-7dcc0b2a7f70
To: u-boot@lists.u-boot-project.org
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794647935; l=2463;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=vVcubQpg+ISL3LwEOoWc0xUsAE8irgLpz3ofNba9YIY=;
 b=Tm3Jab3kDE1xnFVAA9WtRSUk7iCNCbI11QdOEZsi7fKIzVSh0j2oFBMSqSNKyGU6dOIszuktJ
 BALWpNv4XwJDCqMhAgQEvHRzsuUNo6K4srWEaRdUTSMPF/ZWJChgr0Z
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Authority-Analysis: v=2.4 cv=ItKL47/g c=1 sm=1 tr=0 ts=6af82783 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=OFrvsZgaO87kX3YCiZoA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE0MDAzNiBTYWx0ZWRfX7WN2GJ71zXjQ
 gD8fjYQXduZsZ+5laikxRjsrUy1wBPkm7aDpUlMdtLaUViFjJpWXQlDDTgjGRmaqUxb+T8gTNcg
 E0jQNYser2HFuDKjvYW2DQjmct6BoGA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE0MDAzNiBTYWx0ZWRfX9b0fqZC5UAUB
 +Jd1opGdSJFe3CgdP3J64YZ9XWgnhHCRa/MfIsHk8C4BzbJVx4ZHmS9GFv9QOLxCk05WHHV+7Zm
 d2EKJgQo3pbyYupihmyOOfjVPVZF52Ty8q57fjKLQpo53fEWmhs7IxpiZvAY22ccnW026VFonMZ
 L5P1dNlzKrpfkeiGP6Z0XCCJmv5JYsUqcFYjxaSUfTpZ1/TW4hPAExUR5dZPnFydFK/DxECa7J7
 jlwmVluZRUkJfY76VtTCU+U/kwl4/b2KkwHWP1j2079r9pVwJbnVPPyhRoRTj/28MR5VXQIH2+T
 Ad2qETqiAQOUUUC11pZMqlwqKheh9wwo0Gs9Cjxv/R4Bb7IZYygExqHLcgGqHtAW2iuOpzlcWvS
 bOtJLTg8gCe+cw90xWMoNS/A6Oz1yCF8whiEiotaCep90vXweEY9wR6EbmaiGK8dHQpMb5gvTJH
 2c8Szo2jEXPIO/RNFZg==
X-Proofpoint-ORIG-GUID: FZ9UeCnPdRw_hu-wyFjZo3uERigvntMw
X-Proofpoint-GUID: FZ9UeCnPdRw_hu-wyFjZo3uERigvntMw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-14_02,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 adultscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 impostorscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611140036
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

efi_firmware_capsule_authenticate() does not return the payload pointer
and size when authentication fails. Instead it returns the
authentication wrapper header. So its caller is not able read the
payload information.

So update efi_firmware_capsule_authenticate to return the payload
pointer and size if an authentication fails.

With that in place, move the efi_firmware_get_fw_version() call in
efi_firmware_verify_image() ahead of the error check so the version is
read whether or not authentication passed. A rejected capsule then
reports its real version in ESRT rather than a stale one.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v2:
- Split out of the "efi_loader: track capsule last attempt status for
  ESRT, add efidebug capsule images" series. No functional change.
- Link to v1: https://lore.kernel.org/all/20260813-efi-esrt-last-attempt-v1-3-3be172f47d9d@oss.qualcomm.com/
---
 lib/efi_loader/efi_firmware.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/lib/efi_loader/efi_firmware.c b/lib/efi_loader/efi_firmware.c
index b41969c70fd..4836d723d75 100644
--- a/lib/efi_loader/efi_firmware.c
+++ b/lib/efi_loader/efi_firmware.c
@@ -403,6 +403,13 @@ efi_status_t efi_firmware_capsule_authenticate(const void **p_image,
 
 		if (status == EFI_SECURITY_VIOLATION) {
 			printf("Capsule authentication check failed. Aborting update\n");
+			/*
+			 * Even though authentication failed, skip past the
+			 * auth wrapper so the caller can read the FMP payload
+			 * header for version information.
+			 */
+			*p_image = capsule_payload;
+			*p_image_size = capsule_payload_size;
 			return status;
 		} else if (status != EFI_SUCCESS) {
 			return status;
@@ -540,11 +547,10 @@ efi_status_t efi_firmware_verify_image(const void **p_image,
 	efi_guid_t *image_type_id;
 
 	ret = efi_firmware_capsule_authenticate(p_image, p_image_size);
+	efi_firmware_get_fw_version(p_image, p_image_size, state);
 	if (ret != EFI_SUCCESS)
 		return ret;
 
-	efi_firmware_get_fw_version(p_image, p_image_size, state);
-
 	image_type_id = efi_firmware_get_image_type_id(image_index);
 	if (!image_type_id)
 		return EFI_INVALID_PARAMETER;

---
base-commit: 36c377b9859ffb53eb1e39ea31e8d96d1e0fe1e5
change-id: 20261114-efi-fw-version-auth-fail-7dcc0b2a7f70

Best regards,
-- 
Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

