Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65680606A329
	for <u-boot@archiver.kernel.org>; Sat, 14 Nov 2026 09:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=cgN/gRpL;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=L+WZQGht;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=J7KmdNbo
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 27D5B60675;
	Sat, 14 Nov 2026 09:57:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qHJTwPs-DVfd; Sat, 14 Nov 2026 09:57:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org EB6706069F
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794650269;
	b=s9P5Xh489kBemwC8W2TsCH1xvEs8SwxNZeAwdDXTEngkIOwEyeDyKrElbZ+jmEutc+Q9
	 tUwmPRqrnASBBhUCtsS968FmzKsIZWKpoPZ3YpZoAf3NdfiyoR84RYHRQOaIpAofPbJvS
	 9CTZ6g02mASCfr93htxfrg/GX5DkxwnEHxOxOsfu+/kzW75gN6oAHuv9uTOzwUluRdh4o
	 +tY7TpdxVoM/ct098+oqrnUjnUg0Jmtt8TH1EUs2wEENERooVUoold/Hpn+ALpUHlR7cb
	 YYTE0fP7wQ/3tX+QoAVX3hdGAcoOX5yXtrr2fAyNIbTCx7dskMU+/sO3ov5nPxhSvuw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794650269;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=6v3w7se31be3CXFXKzX+2TseIt11y6q3BjiovvdWGoE=;
	b=XBqFdNpdAdMnDngbpIRoYeyAlG8Utt0oAGsRZVsi722dvq6y/WTAD3BVpAoFyXNSdkM6
	 iYnhINE2uTUJ+5Z72vJLDETg3XCwkIdG9MMSIjcEgO1ug2PytpPqKCDy3M4+GOIjz9jxl
	 juQAdWVQ9Cz/JozXVywPgOhtgwfxWC8uDVtsPG+x6d94yKaRXNDs8GhyMqutXzaog8wEi
	 koxICa1kv0Ww5ywemsvhNPG5I2tpLKMIEQ6oZc//pj39vdTNIg+KO8opZqrCzZ+LZNP5D
	 jWOy27fFgRD5iniuJJiHv1+gTBiaIko3dQKi9gnRxY9zOymf+Y0xm8cEr+JWahTPKDQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794650269;
	bh=6v3w7se31be3CXFXKzX+2TseIt11y6q3BjiovvdWGoE=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=cgN/gRpLgJaheA2f4KQydRcZkBdbhnjvV39ICyceowKgTY+cod66UKCspKjQexqpi
	 Oi1SfAiad3txGpd+CeVj1RSl6glbikFziTz6/o5kTGAnbdZdxcxopCR3YLc4yO280l
	 jVydAja2xPSbul5EgrpvnTabHVxWrMjK35zoBcfsRVLtvWWnw55PZLge3+lg2hs7Yp
	 pab0XXyJ4hhLBgXGP+FBdkamR7jc4fv5h7AwQD6A9JEak4v7K20eEYCjjQDgw/9ZXj
	 3wqtijttHIFjamrpIbjTEWjxDJ7vP357d9/pJk5cUsrCOYhYM9WqlLHRkxvG1GWpxU
	 aO23bhcEDfEuA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id EB6706069F;
	Sat, 14 Nov 2026 09:57:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4A01C28C
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 09:57:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 301FF40B1F
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 09:57:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VCBExbY7UzmQ for <u-boot@lists.u-boot-project.org>;
 Sat, 14 Nov 2026 09:57:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 198EA40A5C
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=L+WZQGht; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=J7KmdNbo
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 198EA40A5C
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 09:57:45 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AE619MV2224091
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 09:57:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=6v3w7se31be3CXFXKzX+2T
 seIt11y6q3BjiovvdWGoE=; b=L+WZQGhtMec2TRfeqFqUyymcc71USVK2HnidVy
 8drOXJ/vY+u/woZ5qUjzXscCYWZH3zmXnBZGI+T4iwtAKva08CQInpgwr47fV5Hs
 Rck/tEvuO3nELgmuUk1pOb0Yn7KYEcADYS7gCiF2R/8cVIi5JpEU3nH+yXdANCv3
 KNfWrYnI/baHh4Gs1p2dk0R0vbyct1DWvKRF1Fpxg5ztowW5gQsTRYGC6DKRUAIu
 27ZDN2S0iYN+mlR15mNzrDUfd7mzBQGnEc/FV+bILT3hpNEdvtQRuD3SJPoqBGRx
 cmaX7O80ad/6WUGJjAp9t41StqsJDdS+UwxsAUDB54B4Z1Bg==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhmhgf8f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 09:57:44 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-1383723dfddso2023033c88.0
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 01:57:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794650264; x=1795255064;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=6v3w7se31be3CXFXKzX+2TseIt11y6q3BjiovvdWGoE=;
 b=J7KmdNbogtfRxU1Stn5bfffKE5m03tBhY+BUn97dA0WBdScFtSOTKpYIhg593PpAqd
 jvcaZAanSOCx/Mul+nVmz1/+60KJY8q9pgOeRv9Gf5rEazcid1w4HSZgM90TANkCPWrc
 zqLEUXnWXEFwuns7HjmWe15qvOwJSlW7iyPTas0Rtu9MghUymOOyB/A7pocefjF0DuDH
 AiLiZY2B8UG4TtPQE0g992qtqK1y1YkCkHytvIBg0z1XqokJe/uYmRw/c+ZNkPaTpF7v
 UhaWYRPruVsOTVPArbXA9A6IGVFggjF+zI3i1K9UunjyHYzEI7dQ9M8xX3DRbNDBGffg
 yEgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794650264; x=1795255064;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=6v3w7se31be3CXFXKzX+2TseIt11y6q3BjiovvdWGoE=;
 b=hPPfAjzTmju+fDrraMU7NYewhz6zFD7E56u1hwHY9VOU9C6FW45IUS/lqvuFqcT4om
 lYFY5Xz3g5p7FahasG9sE9RBz2MjLQnZoxk1bDTleKwOJceIWWdH5zoSVOA+8wqn7UwB
 70Qqw+A/lxhFR3tTKxUw/OTgu/Of93a1q+18MJU4SUHpa6XPzyTOtgMw51Hz8k8Yqqek
 HOhbXPzcDSL1LMPcIWstOkgeqWSm1UOoNGWD+Qx6xgbSXS+SUJAIX/GS103MSBWOOhP5
 vH7nN+QK7ZfCnSnab5v1GL/Iz1tPywZmioiPwFOu7neGio5SvBFm87zb0Q4LCrkpxl0z
 ry1g==
X-Gm-Message-State: APuU4Z9y+xMHdNgUwNyKGYBQXG/90FygkIO/mQOShlQSghdeHYWGnd1/
 ImRfI9diDyzyNCgIAqppp06vHRS+3gnZiJHxqZnP4rvVUHhibMvr5571ut8SnllvPsztOnu1Imm
 C8TXVBFN4M+BPH77JWE2z3yyU4kqg8tKEltOb3ox3XGtEktXE7yUUSjRsRhuDECJ3w9khrlk=
X-Gm-Gg: AYBFou3tlyUcmqsxDqFVvxNajTecx7K7Y6wDlndVN8Rl+NVXcQQy7QUzrQHDW4DzFj0
 v/7gYeymZY8mwwMuIEBSmqc65WJhtOiVW5pSA0WxRIbfMXqWfAUZOu6Aazn8qLq6aZXzNE2xlMA
 JBQZz/m8o9ocmPo7gOFZitVTqxscijBuh8HgBeNlpL6/klkXdXxwdqJPe3khRwzk8NhhWeQM0nL
 d844ZOnUA8fKJwPxVk0MuYOJWm3/7ceGOUzRHst3+19X41K9jtf3ukoxyH4xwQW1SIMx1K3t1Wk
 TlFHdzIPIL41ebWcW/kFwtj5noKkIckteb0I2ScfppAM5kc8wsgp3eovC3OLDEWiFw2sJ26FDAq
 doiJal32nrBSEQfwWIL5iWeDAYj82+HtFDHMKhXgXKQwdlrXSSCjH4MTlE5QBEWTY90KOdGOt7J
 Nj4trpPX2DaXSqxdjHBkX5KPcLKWD2tS0dJHJSHUoD7nJWpXVDMK9kd3qSyVkER06ixWhHLjmGY
 8dkpg==
X-Received: by 2002:a05:701b:290a:b0:14a:8df8:56c5 with SMTP id
 a92af1059eb24-1b50311581amr4362393c88.26.1794650263842; 
 Sat, 14 Nov 2026 01:57:43 -0800 (PST)
X-Received: by 2002:a05:701b:290a:b0:14a:8df8:56c5 with SMTP id
 a92af1059eb24-1b50311581amr4362362c88.26.1794650262985; 
 Sat, 14 Nov 2026 01:57:42 -0800 (PST)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3797f98b9b2sm14491356eec.6.2026.11.14.01.57.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Nov 2026 01:57:42 -0800 (PST)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Sat, 14 Nov 2026 15:27:37 +0530
Subject: [PATCH v2] efidebug: capsule: add a command to list updatable
 firmware images
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261114-efidebug-capsule-images-v2-1-f66f0513d3d2@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAJAw+GoC/x2NQQ6DMAwEv4JyrhEJqKQ99R8VB0MciESAxgG1Q
 vy9gYulWXvHu2AKjlg8s10E2hy7eUqgbpnoBpx6AmcSC1Wou5SyArLOULv20OHC65j2Hnti0NZ
 i2WqskbRI7SWky+9lfjeJB8dxDr/r0SbP9HIWWpanE4hDhBE5AsZIfomwSaigbEnWyla1eZjXz
 Jx/Vhy72fs8DdEcx/EHdCEQucMAAAA=
X-Change-ID: 20261114-efidebug-capsule-images-8ffa3b8a7ae8
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Heiko Stuebner <heiko@sntech.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Aristo Chen <aristo.chen@canonical.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794650259; l=10365;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=Tzeh+qm4x5BcFMCirL7AnXho3sztTAWAaOeXFBrzysc=;
 b=HKc5na9NwrFLrqzg4QwnFgzqU/j96dFyQu0zeeu32Jtl4NL37l0Xydp+7TN83jSh96cvydmtC
 hCCgWue2bSnAGVkxIdP2YcGsmKfFx2GcJuyTryyWFJgZJgUZ982C/HM
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-GUID: vDmcgVfn8yAknVmlOyO8-NTqk6OMPchI
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE0MDAzOSBTYWx0ZWRfX/dxEKADF1Q0n
 qhyucUYKLfOt4hybrl1doVS4+xbtKqNHl7yvJuU7ISOl8tOfNUrIQMqo88yHjQvb9t6D40NKxuD
 MXqNQFuqOd0BCgvRSL0OLTJE+DREP+c=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE0MDAzOSBTYWx0ZWRfX85wljXf5G5bk
 I4EE2PsJ2sQbBMCwufPE7LI+cdLPraNV94w0oouMDkTRY8ILHqs4w0LW7PFlIYCERW+XJ/dPfYz
 062BUGvv3sG7Wv8a4RjIQcHFOb+HiWKgdCRXR1Va4+fIZyHLJo4REj/ShhfP04R+qEJOouq++KF
 3RkNsSGBCOCgEqOl7ENi4cqn/EBoJ270c/pr02uRfs0z8Vng3nl002edqigKlpwW4dFH59/EtPo
 ZXEZzl5aN0p7wNP6fy6q/xIN118Vq2yKhPeSq/9mO+lxw6qr3hbn9cAHRUfMCIb2ENYFL+OgwGE
 EuduwncBYgiTDXR360pq4YnNE29kSCqbYs+25kfnitlnQYDdgvbvQ5rX94+9IPgdRa130BxxzZG
 qxMGFZ+Nl2JbEuJoevnSVevRcAY562YaqPt/Ml0NPlXB7wp1+V1cwdvFzkJtA1DhB1uYD6C499/
 hs7SAHFMgiXDxxtHITQ==
X-Authority-Analysis: v=2.4 cv=e/2T2qp/ c=1 sm=1 tr=0 ts=6af83098 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=jEybGn2LzqtTk4ujN9UA:9 a=QEXdDO2ut3YA:10
 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-ORIG-GUID: vDmcgVfn8yAknVmlOyO8-NTqk6OMPchI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-14_02,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 malwarescore=0 spamscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611140039
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

There is no easy way to see which firmware images a capsule can actually
target on a given board. Especially on platforms that build their
fw_images[] table at runtime, since the set of images vary per board.

Add "efidebug capsule images", which walks the installed Firmware
Management Protocol handles and prints the image descriptors each one
reports, along with the image index, name and type GUID. This is the
same information capsule matching looks at, so it doubles as a quick way
to check the GUIDs in a capsule line up with what the board expects
before attempting an update.

Add a sandbox test, test_efi_capsule_fw6, which checks the images listed
on sandbox.

Add doc/usage/cmd/efidebug.rst, which for now only covers this
sub-command, and mention the command in the capsule update documentation.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v2:
- Split out of the "efi_loader: track capsule last attempt status for
  ESRT" series, as it does not depend on the last attempt tracking
- Add doc/usage/cmd/efidebug.rst documenting the new subcommand and
  link it from doc/develop/uefi/uefi.rst (Heinrich)
- Add a sandbox test, test_efi_capsule_fw6
- Link to v1: https://lore.kernel.org/r/20260813-efi-esrt-last-attempt-v1-4-3be172f47d9d@oss.qualcomm.com
---
 MAINTAINERS                                        |   1 +
 cmd/efidebug.c                                     | 102 +++++++++++++++++++++
 doc/develop/uefi/uefi.rst                          |   4 +
 doc/usage/cmd/efidebug.rst                         |  57 ++++++++++++
 .../test_efi_capsule/test_capsule_firmware_raw.py  |  22 +++++
 5 files changed, 186 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e1379a6a3e7..b789e1a7fb5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1034,6 +1034,7 @@ F:	doc/api/efi.rst
 F:	doc/develop/uefi/*
 F:	doc/mkeficapsule.1
 F:	doc/usage/bootefi.rst
+F:	doc/usage/cmd/efidebug.rst
 F:	drivers/rtc/emul_rtc.c
 F:	include/capitalization.h
 F:	include/charset.h
diff --git a/cmd/efidebug.c b/cmd/efidebug.c
index e55de04c699..a9e445d03fa 100644
--- a/cmd/efidebug.c
+++ b/cmd/efidebug.c
@@ -294,6 +294,104 @@ static int do_efi_capsule_res(struct cmd_tbl *cmdtp, int flag,
 	return CMD_RET_SUCCESS;
 }
 
+/**
+ * do_efi_capsule_images() - list firmware images updatable by capsule
+ *
+ * @cmdtp:	Command table
+ * @flag:	Command flag
+ * @argc:	Number of arguments
+ * @argv:	Argument array
+ * Return:	CMD_RET_SUCCESS on success, CMD_RET_FAILURE on failure
+ *
+ * Implement efidebug "capsule images" sub-command.
+ * Walk every Firmware Management Protocol instance and print the image
+ * descriptors it reports, i.e. the firmware images a capsule can target
+ * on this board along with their name, index and type GUID.
+ *
+ *     efidebug capsule images
+ */
+static int do_efi_capsule_images(struct cmd_tbl *cmdtp, int flag,
+				 int argc, char * const argv[])
+{
+	struct efi_firmware_management_protocol *fmp;
+	struct efi_firmware_image_descriptor *image_info, *desc;
+	efi_uintn_t info_size, descriptor_size, no_handles;
+	u32 descriptor_version, package_version;
+	u16 *package_version_name;
+	u8 descriptor_count;
+	efi_handle_t *handles;
+	efi_status_t ret;
+	int i, j;
+
+	if (argc != 1)
+		return CMD_RET_USAGE;
+
+	ret = EFI_CALL(efi_locate_handle_buffer(BY_PROTOCOL,
+						&efi_guid_firmware_management_protocol,
+						NULL, &no_handles, &handles));
+	if (ret != EFI_SUCCESS || no_handles == 0) {
+		printf("No firmware images found\n");
+		return CMD_RET_SUCCESS;
+	}
+
+	printf("Image Index    Firmware Name         Image Type GUID\n");
+	printf("===========    ===================== ====================================\n");
+
+	for (i = 0; i < no_handles; i++) {
+		struct efi_handler *handler;
+
+		ret = efi_search_protocol(handles[i],
+					  &efi_guid_firmware_management_protocol,
+					  &handler);
+		if (ret != EFI_SUCCESS)
+			continue;
+		fmp = handler->protocol_interface;
+
+		info_size = 0;
+		image_info = NULL;
+		descriptor_version = 0;
+		descriptor_count = 0;
+		descriptor_size = 0;
+		package_version = 0;
+		package_version_name = NULL;
+		ret = EFI_CALL(fmp->get_image_info(fmp, &info_size, image_info,
+						   &descriptor_version,
+						   &descriptor_count,
+						   &descriptor_size,
+						   &package_version,
+						   &package_version_name));
+		if (ret != EFI_BUFFER_TOO_SMALL)
+			continue;
+
+		image_info = malloc(info_size);
+		if (!image_info)
+			continue;
+
+		ret = EFI_CALL(fmp->get_image_info(fmp, &info_size, image_info,
+						   &descriptor_version,
+						   &descriptor_count,
+						   &descriptor_size,
+						   &package_version,
+						   &package_version_name));
+		if (ret == EFI_SUCCESS &&
+		    descriptor_version == EFI_FIRMWARE_IMAGE_DESCRIPTOR_VERSION) {
+			for (j = 0, desc = image_info; j < descriptor_count;
+			     j++, desc = (void *)desc + descriptor_size)
+				printf("%11d    %-21ls %pUl\n",
+				       desc->image_index,
+				       desc->image_id_name ? desc->image_id_name : u"",
+				       &desc->image_type_id);
+		}
+
+		efi_free_pool(package_version_name);
+		free(image_info);
+	}
+
+	efi_free_pool(handles);
+
+	return CMD_RET_SUCCESS;
+}
+
 static struct cmd_tbl cmd_efidebug_capsule_sub[] = {
 	U_BOOT_CMD_MKENT(update, CONFIG_SYS_MAXARGS, 1, do_efi_capsule_update,
 			 "", ""),
@@ -309,6 +407,8 @@ static struct cmd_tbl cmd_efidebug_capsule_sub[] = {
 #endif
 	U_BOOT_CMD_MKENT(result, CONFIG_SYS_MAXARGS, 1, do_efi_capsule_res,
 			 "", ""),
+	U_BOOT_CMD_MKENT(images, CONFIG_SYS_MAXARGS, 1, do_efi_capsule_images,
+			 "", ""),
 };
 
 /**
@@ -1618,6 +1718,8 @@ U_BOOT_LONGHELP(efidebug,
 	"  - show capsule information\n"
 	"efidebug capsule result [<capsule result var>]\n"
 	"  - show a capsule update result\n"
+	"efidebug capsule images\n"
+	"  - list firmware images updatable by capsule\n"
 #ifdef CONFIG_EFI_ESRT
 	"efidebug capsule esrt\n"
 	"  - print the ESRT\n"
diff --git a/doc/develop/uefi/uefi.rst b/doc/develop/uefi/uefi.rst
index 6fd1db6606d..cf30da48154 100644
--- a/doc/develop/uefi/uefi.rst
+++ b/doc/develop/uefi/uefi.rst
@@ -490,6 +490,10 @@ following command::
 
     dfu list
 
+The images a board exposes for capsule updates, together with their image
+index, name and image type GUID, can be listed with the *efidebug capsule
+images* command, see :doc:`/usage/cmd/efidebug`.
+
 When the FWU Multi Bank Update feature is enabled on the platform, the
 image index is used only to identify the image index with the image
 GUID. The image index would not correspond to the dfu alt number. This
diff --git a/doc/usage/cmd/efidebug.rst b/doc/usage/cmd/efidebug.rst
new file mode 100644
index 00000000000..bfedd64a6c5
--- /dev/null
+++ b/doc/usage/cmd/efidebug.rst
@@ -0,0 +1,57 @@
+.. SPDX-License-Identifier: GPL-2.0-only
+.. Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+
+.. index::
+   single: efidebug (command)
+
+efidebug command
+================
+
+Synopsis
+--------
+
+::
+
+    efidebug capsule images
+
+Description
+-----------
+
+The *efidebug* command provides debugging access to the UEFI sub-system.
+Only the *capsule images* sub-command is described here.
+
+efidebug capsule images
+~~~~~~~~~~~~~~~~~~~~~~~
+
+List the firmware images that can be updated by a capsule on this board.
+The command walks all instances of the Firmware Management Protocol (FMP)
+and prints the image descriptors each of them reports: the image index, the
+firmware name and the image type GUID.
+
+The image type GUID is what the GUID in a capsule has to match for the
+capsule to be applied to the image. It can be used to check the GUIDs in a
+capsule against what the board expects before attempting an update.
+
+Example
+-------
+
+::
+
+    => efidebug capsule images
+    Image Index    Firmware Name         Image Type GUID
+    ===========    ===================== ====================================
+              1    SANDBOX-UBOOT         985f2937-7c2e-5e9a-8a5e-8e063312964b
+              2    SANDBOX-UBOOT-ENV     9e339473-c2eb-530a-a69b-0cd6bbbed40e
+
+Configuration
+-------------
+
+The *efidebug* command is enabled by CONFIG_CMD_EFIDEBUG=y. The list is only
+available if a capsule firmware update method is enabled, for example with
+CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y.
+
+Return value
+------------
+
+The return value $? is 0 (true) on success, 1 (false) on failure. If no
+firmware image is found, a message is printed and the return value is 0.
diff --git a/test/py/tests/test_efi_capsule/test_capsule_firmware_raw.py b/test/py/tests/test_efi_capsule/test_capsule_firmware_raw.py
index b8cb483b380..1ca3dd92e6d 100644
--- a/test/py/tests/test_efi_capsule/test_capsule_firmware_raw.py
+++ b/test/py/tests/test_efi_capsule/test_capsule_firmware_raw.py
@@ -238,3 +238,25 @@ class TestEfiCapsuleFirmwareRaw:
             check_file_removed(ubman, disk_img, capsule_files)
 
             verify_content(ubman, '100000', 'u-boot:Old')
+
+    def test_efi_capsule_fw6(
+            self, u_boot_config, ubman, efi_capsule_data):
+        """ Test Case 6
+        List the firmware images updatable by capsule with
+        'efidebug capsule images' and check the images sandbox exposes
+        for raw capsule updates
+        """
+        ubman.restart_uboot()
+
+        output = ubman.run_command('efidebug capsule images')
+
+        # ensure that SANDBOX-UBOOT and SANDBOX-UBOOT-ENV are both listed,
+        # along with the image index each one is exposed at.
+        assert '1' in output and 'SANDBOX-UBOOT' in output
+        assert '2' in output and 'SANDBOX-UBOOT-ENV' in output
+
+        # ensure that SANDBOX_UBOOT_IMAGE_GUID is reported.
+        assert '985f2937-7c2e-5e9a-8a5e-8e063312964b' in output
+
+        # ensure that SANDBOX_UBOOT_ENV_IMAGE_GUID is reported.
+        assert '9e339473-c2eb-530a-a69b-0cd6bbbed40e' in output

---
base-commit: 36c377b9859ffb53eb1e39ea31e8d96d1e0fe1e5
change-id: 20261114-efidebug-capsule-images-8ffa3b8a7ae8

Best regards,
-- 
Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

