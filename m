Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82B3DCA9EC5
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 01:53:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0E5ED80AED;
	Tue, 13 Oct 2026 01:53:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rRiN_h38nKFq; Tue, 13 Oct 2026 01:53:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B5FF980AEF
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791856407;
	b=Klnwrkc7chMheuiCRldcDGtjiLYhLfYi4D8GlL5pkDzolBmEA6yUxqEZKS4uljc2DR76
	 8Js/sLlZhwFVi58oM0Pnv+a1pDb+z8DA8ohynbn7zbMBq0SoWGgOitGKawC3wNbhAkjLU
	 Gfmhow0kSUL5EMuo2NRsEBcCeAcy/ZzWPPvU0gQgsTi/nFbgxZ+tL1nKG44+V1nyiUnO0
	 84Dmygjw+IVBb0HTZIaqSTcFnnbF2e2z1t6Vzbe1o2lsEu6uDxrkSTRFCJsFEq1Lk1Xva
	 zlTozH1j33LMjoTtCD9/WlYWc1TnM+iDxCrIZ0Rd1ZPR29MckzH4+LtVKOzlAd9mTCw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791856407;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=VGHm5xxedvx+8WqqSY1vDwfse2PTQ3xlJiRFLpvX30w=;
	b=PJkyEmk2DkR8h97FCg8Tt33r6V7on26hUVH3GP3X0nC4y/98VA95seN28w8O2sxDI/nN
	 7y8RDd8jfh9KJAJfg5OaJwLsRJMnheVmbjNbRc1JyZRPp72I6jc/IMBjkPEEoG+9gYRfB
	 yb/Z65j31S5Nk3i1rEgNvZkVeoFPMzK5F2cEI/I3/unp6D9yucNDGnufHAoM4TAgA5QsF
	 4Ak4qriNahyAKNCKDVwkn9y/VIpK1H5qvefzTpvbw5MDEkReTUwj1ThSRBKvrh45vQNdr
	 mbP5G96hlBTe0fow63ofmpqadaYeQlYeAc+jYPjjXsMHkGevgwrIPsGRYsFgWtYawqA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791856407;
	bh=VGHm5xxedvx+8WqqSY1vDwfse2PTQ3xlJiRFLpvX30w=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Ttvw5vfo4s02N9w0Qc/PlYGCqRKyi9/FMxv/tLSt+Ylota0Ejtvmcnmzb4uDY/QJg
	 nE4j6MVnCv+8mhPwESanci9bAMR96OcfbFisqUGED/3vcGm7oEf7Mjxf1hHub9WrWF
	 bX3qB8PRtpIBEE5NKvRRtbmJHOpH1s0uwUnIwysnq+PBXmHxVhrSkcWg1zDyk9mRBW
	 nPE6K2FJ76+VIYZcd4S0ea2PNk+XkZX9CfKHarPt5VWnpF5S9twsN8nZ7VXP/1w1cR
	 PjHsSaKXVl1CIWY8Otkivd7IAldgbSrHlK7EbIGXcVldIp0bPw9diQV78o3JkL7zD1
	 3ugyFE+Sk9nSw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B5FF980AEF;
	Tue, 13 Oct 2026 01:53:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id D753A788
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 01:53:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BD24D60660
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 01:53:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iYziI9XhHZ8t for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 01:53:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 861F3605DF
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791856405;
 b=QMI8J7GfZ6EnP4p7/kVySAbw/KiMK41XWpAo83Ms0VZPBjC/aBu2fF7/fm8xyQDejZ3S
 VdLzWODBp3Q4SzcFmXRF40kuk3HiWf2anBf78sf5B0ACNIOMK3aOU/y/ZP1qCk+RjUi21
 57z2vgDg+fA9zKWRfCe3waRwV2hmyWfpw1Q85sYJpvXoUldNXSpLkXAorQT/dCB62Lx4T
 ZGsN6jRqlS047yIOYD15H/e+SyTbchCxpN/lHdlNquXkxeMxzQ593uuwY4FDjPlOfszQd
 ztBfnqwxDZjnJxZnAuvGiq5SaPQClV3UFsHDvD2ScKWeHgLHKyHF7Lbv8OoF9TPVS+w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791856405;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:From:Subject:Date:Message-Id:
 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=VGHm5xxedvx+8WqqSY1vDwfse2PTQ3xlJiRFLpvX30w=;
 b=edoAaOyWdYtSGP1jgvPJEepZrlUJetultHZpX8T7ajZO2zii4eykVusQmgbEO3tP6V4r
 c5y2n0xcFAPMePTg+WfiFMUEbiEyhJJ/uKYrkpbw2w3Di/lhXzgBELQJRkN3G97Z05iSc
 kCxMrMAWxav/p3pwCc4zz65kndpU8AB27KZXe//q828VPys2G5OjfIja0kPpxHyCngqRD
 tjR3bZA/zXr0xlgguFQretZfQkzKV0wWrboHKg1QQlBodaLXbj5KstYwy7pJ3IBr8GnL9
 hCMSnDu9pHy4cypBG1uSeV8shVQ23YBj/7eGJSwXgrBb+UWMJxLEnKpBqNRvCOhlZLA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=TxyjmjWi; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=GW8Fogvy; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=TxyjmjWi; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=GW8Fogvy
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 861F3605DF
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 01:53:24 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69CJNJlr1779468
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 01:53:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=VGHm5xxedvx+8WqqSY1vDw
 fse2PTQ3xlJiRFLpvX30w=; b=TxyjmjWiuRHu/lPAs+Wa+Ihn+IpOE5svEpXevY
 HpCv0He3MaJ2sUGiffY12Dyz2DQW7lP/+5B7XUvKXd7btPP2tZP0+zXyhobCyGyX
 AeTmkT4UFnALu+6I+9dwf4Bs2Rb1UrMVcJgu9y8P4/bmvv4hFpMxH5eEAAffZu5M
 p72Bui0IeeX3hyVa3rNYax3xx6jlhGQVMtf0Q7mfko4O8CK6f46gW3CyygylOank
 Ri38upDRSa00bi/Bh/lffbYO/yJg6hVRzymVt9KQfEpePA7mK5hbzawpvDVCCZbF
 spN7YXJhNjxJ3OvpOmSGSMSJ7ncXsO8LcK8VpZtNlIJl0Y2A==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8wfcukc6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 01:53:24 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-33c35f5ca6cso5977715eec.1
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 18:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791856403; x=1792461203;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=VGHm5xxedvx+8WqqSY1vDwfse2PTQ3xlJiRFLpvX30w=;
 b=GW8Fogvy1uBJwoylEHQlT6H+2A622qCRcAXzMwEVe1C4H8zqsxyvIHN75vt54GK6Jr
 T4WHCUz+nQy+Wzm+A2720mRbQidvJDiOT5q486hsAP/TH3xn0N/pscKKRnb4G/HcqiZW
 wdsiFZd7j6fj1+jYzmCvuTObOMs9oD2tqkZQHODrFE+pm+WhGuYLUeflo4SaCFSzLrzW
 WkFSRaE7j7JKXA+VqyyAFOEtOG3ojSr6o5J3OvYy0cvGmN9uZU08OwfnmB6sbWhX9cEs
 9o04UN3aX0zpx3rYqbTm7d1zl6DL+UQdeX4JkVSvldzZ/G3wB4iD9bmWBHsA9RYN9JL8
 tc7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791856403; x=1792461203;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=VGHm5xxedvx+8WqqSY1vDwfse2PTQ3xlJiRFLpvX30w=;
 b=W8bAHU9BIjnLwnlCaBViqGZ5zNKXYsCKDmcSa9hfGg068lrelF9ftrH8+uYQ+ZWJXK
 qAghZx2mnayb1sI23enrVqmWu+CBVjROcVL5FlQQsU0UVYIRBVQUND5TzvX6TVK7WZyU
 maZzlZyhYnQGCfF2HJccEJqGzAmiaRyUCMnvbzy5LPaqo9s0p6QeBhrb0wsgYWabUf/j
 0312nAeSIg6Fiwqg9xiOm1RxfZBWGTynb2isHk+PKcPOM0uE5KszQt21o0nvVnMF9q9k
 3Zf2ET94XIzNw5njBT/O+gFO8UlF+XvWwiJ5XV2jXQ0ydXZCcVRW0jX3TEuPXESlv2pz
 70jg==
X-Gm-Message-State: AFq9FYKguRL72WVo+F6niT3OD5D3ud3E6uF86lewVpIHsu7ZxnOFZhIl
 sl0s3iI996isX/FrZp91/Q6ryDUFP7d/0r50RjJ2mk4LZbiUM2FTu/xr9DWOxsGV/74hVLcP1ls
 Io+l0D5PE1Oft+7Tdb6lWuoO9rjSSmJjmC+9cEnhs/cRu1ctbcdn2CfPYdl2t8BzfHz6fM58=
X-Gm-Gg: AYBFou0z4NaWfyqsU+yzQ+VkGIjuPT7HpR5H4YyrvGIUItF6wBS+oMY8qEF4mBPs1Rg
 UqLyOIN/3kKje0PAiFCWb3C7ZwMHA3zwZuLwNoVdA5HLKU8Ha5BcBEIWiam8C4TjztS5DebgvQp
 s5xg6VusvN/U+RXlMjsegzTidDlMxGgvYkNyJC9j18MLwFb9H+VOgEmJjGaQ4TvdwWikkWpp9LV
 E+6NXV1oW+fj4+EbgPnjQJkpqwhb+wHuuk2PGLB9ZCCfoBZ9TpUSrm+Rt2mmRul22MxglRPXJn7
 SEMdW/j7PP6R414K+zvEyEkhZC2MERJeOvZhkgV9o5tIH5WgfpcbWcx8RZq0OgWmirwz6+eTitj
 qwlT3y3Y0AO046MjvQq1nVmW0GOUgPap+vGP+il3Ieum04+aCXlCVWWQUysFiWcHJMidWv0/4LN
 ubp2a+73hRSYE5/nTTH2EPlOge3Fg=
X-Received: by 2002:a05:7300:f582:b0:353:5ae1:b0f5 with SMTP id
 5a478bee46e88-3537e101bf0mr15619890eec.26.1791856403106; 
 Mon, 12 Oct 2026 18:53:23 -0700 (PDT)
X-Received: by 2002:a05:7300:f582:b0:353:5ae1:b0f5 with SMTP id
 5a478bee46e88-3537e101bf0mr15619840eec.26.1791856402181; 
 Mon, 12 Oct 2026 18:53:22 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537cb68e56sm34612666eec.29.2026.10.12.18.53.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 18:53:21 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Subject: [PATCH v7 0/8] arm: snapdragon: Add snagboot support for
 Lemans-EVK
Date: Tue, 13 Oct 2026 07:23:09 +0530
Message-Id: <20261013-snagboot-v7-0-fc296a32836a@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAWPzWoC/3WMQQ6CMBBFr0JmbclY2oKuvIdxUWAKTYRqi42Gc
 HcLLtzoZpI3+e/NEMhbCnDMZvAUbbBuTFDuMmh6PXbEbJsYOHKFZbFnYdRd7dzEBB2MUga55C2
 k+c2Tsc8tdb4k7m2YnH9t5SjX7ydSYfGNRMmQIZIRUvBDIejkQsjvD31t3DDk6cDaiuqfr5JPV
 W1KrUyDWvzwl2V5A/Xa6bTnAAAA
X-Change-ID: 20260731-snagboot-4e9f66f0252d
To: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Michael Srba <Michael.Srba@seznam.cz>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Simon Glass <sjg@chromium.org>,
 Hongyang Zhao <hongyang.zhao@thundersoft.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791856396; l=5507;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=8uPJ8SjDVL9nDvSSJeh3PhfgweJh+vUBllH50RSa9gI=;
 b=IgNyKVTci+obEECKyrdLwT+t2xAn+iseYxxio6up6PAEWfdgCVV8VKgxtSYVIph26VAPKmH7D
 mFuAPhnkGLKAJE+pyTEODFgiesp8YjuckqcL1QoIoFllC3ALS68K1fZ
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-GUID: Py8I_CpDOOgK5M8pV8k7ZCWVMcaotgsh
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDAwNyBTYWx0ZWRfX1oPLrtmzaAyG
 yUVWXjdcKgdV74Q1hj9DXqGQWVbwj280Rw8cpXShIWS0oruBi+RaAwFfeRmGv/oFPun0hIiixSu
 Q4o6FVWVje3L8tw22mYLNol8SjXv2bk=
X-Proofpoint-ORIG-GUID: Py8I_CpDOOgK5M8pV8k7ZCWVMcaotgsh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDAwNyBTYWx0ZWRfX9VH4qjKut3mV
 uWTE8XK4acA8WKTDNsaylTUPRnfNMnTgkZO59ajDX0jvrF85QHzI+E2GEcgQZKBkX6PSkfP4+4I
 4CMkNZRJ/Z9mmgBH/5ndFCVOLjdC/8B7qv8nJL1Qla2zQO3inM6uWKc3sBu9V+MHZ452Xfqusd3
 eqkADDR354FWnt8LGtUszELkwXcbAjB0owzO/coxpxwF+d1jj3WfEcYjMmxTT8lZYEWNvAJEMG0
 nj9+N69mikmC/PsiUlxQCHAztaja6Bb8AOOQwpFu0z+MgOQOXwzZGlsQvuxmnezleuAQSSMo54t
 7tAkrKiKSWuB7KQ1D1i6JYHR38bdYM0mENNZMTRLAHryy3O4KBO/6uH3E2erWykf89jKKfTesse
 /FZm6DfFdS1TnFYd/mMUk7O8nbuoiuN3ou1vlMSAc3wVeKLVgNoi4KagcWf58MYxxa+sZTK4pFZ
 NxHqunu/Y6wvX14nBkA==
X-Authority-Analysis: v=2.4 cv=PbhqFShd c=1 sm=1 tr=0 ts=6acd8f14 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=gu6fZOg2AAAA:8
 a=4GZlKNTyZuL0fuDD4_0A:9 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
 a=2RSlZUUhi9gRBrsHwhhZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_06,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 impostorscore=0 spamscore=0
 phishscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130007
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

This series adds support for running U-Boot in snagboot mode on
Qualcomm Snapdragon platforms, targeting the Lemans-EVK board.

Snagboot is an open-source, scriptable flashing framework that provides
an alternative to the proprietary Firehose protocol for device
provisioning. Like the traditional EDL+Firehose flow, Snagboot uses the
Qualcomm boot ROM EDL mode and Sahara protocol to download
and execute bootloaders. However, instead of using the proprietary
Firehose programmer, Snagboot loads U-Boot into DDR and uses the
standard fastboot protocol for device flashing.

The framework consists of three modular components: snagrecover
(downloads XBL/QCLib to initialize DDR and load U-Boot into RAM),
snagflash (communicates with U-Boot over USB using fastboot to flash
system images), and snagfactory (orchestrates parallel factory
flashing tasks).

In the snagboot execution flow, ROM code in EDL mode loads
snagrecover, which downloads XBL to internal memory. XBL executes
and initializes DDR, then snagrecover downloads U-Boot into DDR and
transfers control to it. At this point, XBL has left the MMU enabled
with its own page tables and has not initialized PSCI firmware or
populated the Command DB. U-Boot must handle this non-standard boot
environment to enter fastboot mode for device flashing.

Support for Qualcomm Lemans-EVK SOC in Snagboot is available in
https://github.com/bootlin/snagboot

When U-Boot executes in Snagboot flow, it has to deal with missing
platform services such as TrustZone (TZ), Hypervisor and AOP (which 
populates CMD DB data).

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v7:
- Rebased on top of latest main branch
- Link to v6: https://lore.kernel.org/r/20260803-snagboot-v6-0-e8bf7a6fc0a4@oss.qualcomm.com

Changes in v6:
- Forget to send summary in v5 cover letter, no other changes
  in v6
- Link to v5: https://marc.info/?l=u-boot&m=178577208345353&w=2

Changes in v5:
- Make QCOM_BOOT0_SNAGBOOT_MODE as hidden config dependent on 
  QCOM_SNAGBOOT_MODE
- Disable C (Dcache) bit of SCTLR_EL3 register during MMU disable
- Remove now unused QCOM_COMMAND_DB_OPTIONAL Kconfig definition
- Disable unnecessar I2C configs (for Snagboot) in Qcom Snagboot
  config fragment
- Add build steps for compiling U-Boot for Snagboot mode in
  Qcom Snagboot doc
- Link to v4: https://lore.kernel.org/u-boot/20260619-snagboot-v4-0-385497442db2@oss.qualcomm.com/

Changes in v4:
- Renamed QCOM_SNAGBOOT_SUPPORT to QCOM_SNAGBOOT_MODE
- Make SYSRESET_PSCI dependent on QCOM_SNAGBOOT_MODE
- Place Snagboot related configs in seperate config fragment
  called configs/qcom-snagboot.config
- Include above config fragment in
  configs/qcom_lemans_snagboot_defconfig
- Removed Lemans EVK override dtsi: arch/arm/dts/lemans-evk-u-boot.dtsi
- Removed QCOM_COMMAND_DB_OPTIONAL as now we use
  CONFIG_QCOM_SNAGBOOT_MODE
- Added documentation on U-Boot for Snagboot 
- Link to v3: https://lore.kernel.org/u-boot/20260616-sngboot-v3-0-6fb0dee8125c@oss.qualcomm.com/

Changes in v3:
- Brought the MMU disable logic under CONFIG_QCOM_SNAGBOOT_SUPPORT
  ifdef condition
- Moved the MMU disable codes to a new seperate file
- Used "if (IS_ENABLED(CONFIG_QCOM_COMMAND_DB_OPTIONAL))" instead
  of #ifdef
- Removed enabling QCOM_COMMAND_DB_OPTIONAL, ENABLE_ARM_SOC_BOOT0_HOOK
  and SKIP_RELOCATE as they are now automatically enabled by
  QCOM_SNAGBOOT_SUPPORT selection 
- Removed updating MAINTAINERS as the defconfig file is picked up by
  the "N: qcom" line
- Link to v2: https://lore.kernel.org/u-boot/20260608-snagboot-v2-0-036bb0343bf7@oss.qualcomm.com/

Changes in v2:
- Changed SYSRESET_PSCI from 'select' to 'imply'
- Guard show_psci_version() and qcom_psci_fixup() with CONFIG_ARM_SMCCC
- Disables the MMU and invalidates TLBs at the earliest entry point
- Add qcom_lemans_snagboot_defconfig for Lemans-EVK
- Link to v1: https://lore.kernel.org/u-boot/20260409-cmddb-v1-1-b10549b34133@oss.qualcomm.com/

---
Balaji Selvanathan (8):
      arm: snapdragon: Make SYSRESET_PSCI optional
      arm: snapdragon: Guard PSCI functions with CONFIG_ARM_SMCCC
      arm: snapdragon: Disable MMU early before U-Boot reset vector
      arm: snapdragon: Add CONFIG_QCOM_SNAGBOOT_MODE option
      soc: qcom: cmd-db: Allow boot without CMD DB data
      arch: arm: dts: remove Lemans EVK override DTS
      configs: add qcom_lemans_snagboot_defconfig for Lemans-EVK
      doc: qualcomm: Add snagboot mode documentation

 arch/arm/Kconfig                                   |   2 +-
 arch/arm/dts/lemans-evk-u-boot.dtsi                |  19 --
 arch/arm/mach-snapdragon/Kconfig                   |  20 ++
 arch/arm/mach-snapdragon/board.c                   |   6 +
 arch/arm/mach-snapdragon/include/mach/boot0.h      |   2 +
 .../mach-snapdragon/include/mach/snagboot_boot0.h  |  27 +++
 configs/qcom-snagboot.config                       |  46 +++++
 configs/qcom_lemans_snagboot_defconfig             |  18 ++
 doc/board/qualcomm/index.rst                       |   1 +
 doc/board/qualcomm/snagboot.rst                    | 224 +++++++++++++++++++++
 drivers/soc/qcom/cmd-db.c                          |  15 +-
 11 files changed, 358 insertions(+), 22 deletions(-)
---
base-commit: fed92546960a92177d67c0b8d7b22385f50fed29
change-id: 20260731-snagboot-4e9f66f0252d

Best regards,
-- 
Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

