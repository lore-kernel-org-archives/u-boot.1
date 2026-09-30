Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B67C0CA5FAB
	for <u-boot@archiver.kernel.org>; Wed, 30 Sep 2026 06:35:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5AA1B80DC8;
	Wed, 30 Sep 2026 06:35:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XHQY5A_XN80J; Wed, 30 Sep 2026 06:35:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 7F7B680C4E
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790750107;
	b=rtsSbtfBS5yoVP4JJKWNVYYXMK9jrjwMwrzWYC3RtCdh5/irtOuBBYcKi/ZTrTolVCWX
	 ca5UVuxfKaqJgV1EnTUNK7a/WcSpevgOYm/J4cMwvT8eBcbcU7RupE+pI+6AdnGPGvRc4
	 BG5HfBZCV1CQJao3Zo8iXnu5bjEN++C8MGhUnvhK6UriigkAuq3WW5cCqsd9uSMJDu/GT
	 KEI2YmUdKYAQvtyOi+Oo4vZ+lZeEinl6Z1vKSTf6DDtAYbEKp0Oz8uOCZgNh0elhD8e2f
	 qpRkqDcA2oLy8Jq1mvjIFWOTjdWUCDUSmTBQzYEyjTRuJg0h5R16Zap/T6SeLKWyH2g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790750107;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=zyCNUjlSy5U7wCoWNwu4o0yWxLjQQ3dJG0ZqDhIrbp8=;
	b=AjUNA3WhRrzs5yIA7P1xkb2dCct8h7UjfhVyC9mjwkFwBphpydlmOfyH/rxqtlnv++nD
	 /fRMI33iAiS1LbVf83JmF67zpMkx42zBMWRUFjDdxNJmWVnR9DLdKIEYr85jhYfOGpdEw
	 rqLg+ZU3CMHtpKRESvpxrY5M6Q3rWvvtMDMJLJrolxRP9ovFyrRZqVmb7k/RkGesUqwYG
	 /r8fe2SdWouNHgZwVaqOaUEqwXiIZjoUbWXtlXFIDsQthDjh+72HyCgqX2E8UUgfqts3Z
	 pk1bysYiZZgRp4ZjvSo7YtjDSyjIeuR2ZvIHZxK44+PhyfNIu6KRUWpwU/7Ur/DZ/ZQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mXxZl+2T;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KEX9Bxrf;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790750107;
	bh=zyCNUjlSy5U7wCoWNwu4o0yWxLjQQ3dJG0ZqDhIrbp8=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=PL0vsuucyMVHS9Cg99+zdXvotgz9EN1tJ14zPkHswKHbWzdv9jr11ivfCZNZ6mo7v
	 6EJYHBs45WC2irNz2nrhFWrL53aanoB33c9XfOaSf/KGuD7Zd0KASLpcHyeBcnaeym
	 QaIea2jNejAzpxzW6SSNU5ynA5B2e/vIrF2NAa73jjasCI5OQb1oc1rynPNDhWl9Wp
	 L7Gm9YBnVIs0sqGx5MBX9JqkSc572JQ1QBjmTYSsU7ZCfZtSnWZ1X0aQtBTqzjUuMC
	 Z7QbMmbaBHxyJEinOYiwrliOf0AfmM4WE35P2E6BVMnudxnI+Lx0I6FCaKUHHo8PNb
	 8FHfUBlUA3k9w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7F7B680C4E;
	Wed, 30 Sep 2026 06:35:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4CDD72E5
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 06:35:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3DD0A80AF9
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 06:35:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9D4AJKlTgZaC for <u-boot@lists.u-boot-project.org>;
 Wed, 30 Sep 2026 06:35:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org F2DCF80AED
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790750105;
 b=bghgiIfqEn38w54iTbKsAK0zE4QzhEdyRXfSdxa7IhfA5q2G89YF6xlHWIP8iCttuU4p
 o9BLRu9HobokEC5fbgBbgq3LTN2lbE/ao2mv98xbqqCYcHJOmE4PAsrEGD6YN3Bge2GPB
 8GSZ3oqq76IBHt8S8X7drpRNfdypXT5sbmRUKcogsmuCWlf+NakOZq3D8NMrcRT/B6i3p
 i6TZ+389ML7wfH3FKDJytcPqVGRawxRfir9lYn2vKLLNKjBXujaqRYAAtfgByy2f7OkqZ
 6JDgu4RbfphoakRWNrlosEWlxHqsHJJce2oGjvqMdhauwpm32NJrcxZRIjenJuLMa0w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790750105;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=zyCNUjlSy5U7wCoWNwu4o0yWxLjQQ3dJG0ZqDhIrbp8=;
 b=b5+mOJtQgrddnNKCLePeM+rZ5CrDv9iWBeSgM+OekIIdHIivMch/+RWl3iwjxcAEKamt
 CuM/qvQrymYY9mjj2OmKDBZCU2nUWam39ogEaZ0I/2kDSyRR6iZx1iClZq+4L2YlsSQg7
 Ja05zq5XwogNp3za3OsZu+e2QrDN7egN4HznwKP2VpDl+r5IFoSfMMtbSkKP0OJeU16/2
 1SLx19bmHGCcvbxCmLpkEltwmMIkD8y47x1i9ntpYcSScGoBPmXTgFbxSquC479l8tvhL
 UC7bo/yLi4KvHAGPFHIBV9kPniG7lXwFis4aWpACg/sbKbh1pB8Ad5T3rFD1wm0xqmg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=mXxZl+2T; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=KEX9Bxrf; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=abhilash.v@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=mXxZl+2T; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=KEX9Bxrf
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F2DCF80AED
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 06:35:03 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68U2PLRg1522452
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 06:35:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=zyCNUjlSy5U7wCoWNwu4o0yWxLjQQ3dJG0Z
 qDhIrbp8=; b=mXxZl+2TqTh8Vlir0ghq9IGi6T9IWR5UndUMp6CCyDVklDD/kyq
 KbgMx9kZi9gNGgywBYqzJIQa3pyAkBVFOfK8ButTboGGMTWovVSnGLGslTnTXJES
 LmB1wMKUfzKqyY7jxHPobSaIfWkodNNlcud/C01br0F6vyUmURnQstCZknkXDzcB
 0zCwv413eQjvueL9xxGoJY5Eaqc7x25BpN6o8SsX8cqSfgYRQwDWG8W7YlGjsOrW
 xtUPTWtrREuTD3dWtiopzTWmdN8Z1NyixyAQvFOXZ8P6HM4vrrk0qiQ/TLrlafnk
 gVHnCwOamoV5WJR7IQh0KwPlrcndqXgWu2Q==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0smjgxh2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 06:35:02 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-34344599f01so4172904eec.0
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 23:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790750102; x=1791354902;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=zyCNUjlSy5U7wCoWNwu4o0yWxLjQQ3dJG0ZqDhIrbp8=;
 b=KEX9Bxrfv+o5ojWqQm0oK0sRtUYeFQRr1lvkxYAQRUPMamNd8pP4ZdxUBQw+Z3d0Xz
 fYEvxsZxEwgAKc59L1/1mDI3cr8p7UK8xDQvH1SVplX7UjSHu/GftNzAw4DceHBmpsXV
 jBsXyYerPrZVtkHIxxoB/eqX442t/G3fBe8JeolU1KmoSI4wk1ePhjNRUz/sXRC8WEbm
 cO6cs6Np5BJfYG/Tfa8BhBThkvSViEooJO/ftMFc8iPdbcxCOH2M7e2uyjH/Fc90/iEO
 fF08e797VuK3dP30d3IwOg1qrYai4I++f6Tt4TpZ7C2ymfEHhZ9EM8JnztckxZT4unL9
 Tnaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790750102; x=1791354902;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=zyCNUjlSy5U7wCoWNwu4o0yWxLjQQ3dJG0ZqDhIrbp8=;
 b=KWdaXMRdPkYYIC7jxXeKLpMfd1i1sx+f3GuQggOE9btWd3JNtdxyS6KcDOLCKIhh7V
 Y+QGiY3WHWndP+qqqahlDgJXnBckQwhHMk2Eon69y0ji2qvlWeDt8GewC8LpajHW4Xld
 KdOmOOvNJmGPwomCT0RI4BpJexmSWR0m2St7fvBeiVHitno7IXOXtYMV+lRxYTDPKD8l
 OeIAr1q02p+znqo8i8YX55Ef8h8XGz+HlHFUIS1n5kpSoQTiaA3/W6h42haMQqDDeqRQ
 LymB94CvPj6vgyuy8Kgqt5MjiJYWkSBvesDCnRGjcSLoMZij/jYJkCCNFB6JwDPoVH7Y
 qX+Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBzeIuV/nxHlLa96yQpTYo739ZB0ypIhFt1Uio38v57kFdFh8FLSRVToW8v+G0JVriIlaxYWpXU=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYL0N2PmqHJqLsRU/cZA6L8W3y0i955Ip7NPIiZ3r//wGlGsqBna
 cbfka32WhfgUbdlD0IJONoCnOK5Loosp7KXgramJu9kWH28Vj5UVsmte41PT8NTlsMAK3jMyCr6
 DktGvV/KxEB2HH/tkJLFJKm14v0ZN1N+7ExBB1eON3uPkfVLWSo5KpcTEFvzf9ctcBqI1YOo=
X-Gm-Gg: AYBFou1+RSl/CDDSDHSrxSUj//ScjH66Fct4D/uhqWGmXp+i1togNxaIHkSESjjmslh
 284iqQwi1rnDylgGeh04NZAcOITzDBZsZQ9mr0ysg57GRNhHvD7H2ZMoTRP+xf1y1MbISWwYEqw
 NCNaEefLxZbxJh8iLhdq2FwwwP/KLIQDE8mgz87YNUUlci3OjfUh1MZ/ffRNiebN59k7xdC8sM+
 ATlpyclqEdxNbbvf1QG17R7M8UXwnX1Q710WBs0MJKRAiiUP4sAoJJxzqksB3Q0TYPdSeTYtNs8
 GyV1RrJbdobCZV7tOZW5qASRV2DCmX/M/NB2UlwmvNpP8ZnPAWKsWUt8qMIvTn4RjBfZRZJ6qau
 N8kZk5f3iebkzDY6W3QPNhwNzIvS4NovCvpGd10KlOC47uQTt
X-Received: by 2002:a05:7301:6498:b0:342:5098:a983 with SMTP id
 5a478bee46e88-34cdb8e5484mr836080eec.11.1790750101934; 
 Tue, 29 Sep 2026 23:35:01 -0700 (PDT)
X-Received: by 2002:a05:7301:6498:b0:342:5098:a983 with SMTP id
 5a478bee46e88-34cdb8e5484mr836045eec.11.1790750101407; 
 Tue, 29 Sep 2026 23:35:01 -0700 (PDT)
Received: from hu-abhiv-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34cf22f85b7sm1287502eec.3.2026.09.29.23.35.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 23:35:01 -0700 (PDT)
From: Abhilash V <abhilash.v@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org,
 aswin.murugan@oss.qualcomm.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, lukma@denx.de,
 peng.fan@nxp.com, jh80.chung@samsung.com,
 balaji.selvanathan@oss.qualcomm.com, abhilash.v@oss.qualcomm.com,
 Michael.Srba@seznam.cz, sjg@chromium.org,
 varadarajan.narayanan@oss.qualcomm.com,
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: [PATCH v3 00/12] qcom: shikra: add eMMC SPL boot support
Date: Tue, 29 Sep 2026 23:34:37 -0700
Message-Id: <20260930063449.3251317-1-abhilash.v@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDAyNiBTYWx0ZWRfX3Y+vqwGSjJeT
 o4pgFf5D0mVTEb6T4fr9tzhKDfvIdrs3PYL9k6mDqHpSH6JannQ33QVxhlfWaDl4a+4jOEH+juA
 zt8vTupWTEp5Cdyo6J9U9l7p//TIxn8=
X-Proofpoint-GUID: iq8lKJ5x4bXSniPEbHYt3ISbg3nA3-do
X-Proofpoint-ORIG-GUID: iq8lKJ5x4bXSniPEbHYt3ISbg3nA3-do
X-Authority-Analysis: v=2.4 cv=KfxHIgYD c=1 sm=1 tr=0 ts=6abcad96 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=YwgyGQ_rmKvcxYo6NmUA:9
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDAyNiBTYWx0ZWRfX6MwbNZ5qPWKA
 +xP0d/v2hRnnu//QCYA036zY9D536+bgIXMXFuOoQ4do2Ll7Zk3kZkjlnHUgg8Y7deoT7tiSof5
 iduV9Iqalz/XBmhHZxQbbJJ2UYUkKsVtQsLSifXdyNioeT1xR7bmcruKCHn3KOVzN9wW1uyglBY
 2TcPie/dnZb9ZB3k1P9IVTXyPpylgDYhpTN0AfyOltjZWoWoTuNhVpkat5t/mM9ePaaVLfnF+Fc
 VWvdk/1tIKl3kgkCyr7yV3XB3YM9wU4cN/vITdumFhKQKYvEIbepFjZvXBjiExj0fU5rgf1XAns
 pPLMCBdXCZULChvfEUNBmN39lQtJe0foLz8gGR8rAGQy0aURjx0sXkmtIlmrFWhvWgcrfpMKNfv
 6bVYRclJnB1oTKogNVlgD132l5nVFKKvCAxhgMklJZyS0A9g5dzYPNEqZe1WmPv5f9KIpI/qGMu
 7PCMxkZzWIAGEma1ebw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300026
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

This series adds U-Boot SPL support for the Qualcomm Shikra platform.

The SPL runs from BOOT_IMEM and performs the early initialization
needed to boot U-Boot from eMMC. It configures the required pinctrl
and clock state, loads QUP firmware from its GPT partition, invokes
QCLIB to initialize DDR, and loads the U-Boot FIT from the eMMC
boot partition.

---
Changes in v3:
- Added qup-fw load support in spl-shikra.c
- Reverted changes from drivers/misc/qcom_geni.c 
---

Abhilash V (12):
  arm: qcom: add common QCLIB SPL extension helpers
  pinctrl: qcom: add Shikra SPL pinctrl option
  board: qualcomm: shikra: add SPL board support
  clk: qcom: add configurable FSM-voted PLL helper
  arm: dts: shikra: retain QUP SPL dependencies
  clk: qcom: configure Shikra GPLL6 for SDCC1
  clk: qcom: enable Shikra QUP wrapper clocks
  mmc: msm_sdhci: make tuning callbacks optional
  arm: qcom: enable MMU and cache setup for Shikra SPL
  board: qualcomm: shikra: prepare QUP firmware in SPL
  configs: qcom: add Shikra SPL defconfig
  board: qualcomm: shikra: embed XBL-sec in SPL ELF

 arch/arm/dts/shikra-cqs-evk-u-boot.dtsi       |  44 ++
 arch/arm/mach-snapdragon/Kconfig              |  10 +
 arch/arm/mach-snapdragon/board_spl.c          |   8 +
 arch/arm/mach-snapdragon/include/mach/qclib.h |  16 +-
 arch/arm/mach-snapdragon/mem_map.c            |  24 +-
 arch/arm/mach-snapdragon/qclib.c              |  77 ++-
 arch/arm/mach-snapdragon/qcom-priv.h          |   4 +
 board/qualcomm/shikra/Makefile                |   3 +
 board/qualcomm/shikra/config.mk               |  24 +
 board/qualcomm/shikra/shikra-spl-wrap-elf.lds |  40 ++
 board/qualcomm/shikra/spl-shikra.c            | 460 ++++++++++++++++++
 configs/qcom_shikra_spl_defconfig             | 110 +++++
 drivers/clk/qcom/clock-qcom.c                 |  48 ++
 drivers/clk/qcom/clock-qcom.h                 |  24 +
 drivers/clk/qcom/clock-shikra.c               |  73 ++-
 drivers/mmc/msm_sdhci.c                       |   4 +
 drivers/pinctrl/qcom/Kconfig                  |   9 +-
 include/configs/shikra.h                      |  11 +
 18 files changed, 961 insertions(+), 28 deletions(-)
 create mode 100644 board/qualcomm/shikra/Makefile
 create mode 100644 board/qualcomm/shikra/config.mk
 create mode 100644 board/qualcomm/shikra/shikra-spl-wrap-elf.lds
 create mode 100644 board/qualcomm/shikra/spl-shikra.c
 create mode 100644 configs/qcom_shikra_spl_defconfig
 create mode 100644 include/configs/shikra.h

-- 
2.34.1

