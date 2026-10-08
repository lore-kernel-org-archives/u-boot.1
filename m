Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3715BCA600E
	for <u-boot@archiver.kernel.org>; Thu,  8 Oct 2026 09:49:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EEC1C60871;
	Thu,  8 Oct 2026 09:49:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Kcf4xVo-z7NB; Thu,  8 Oct 2026 09:49:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 0C8E46085D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791452990;
	b=XicEORim1f+eVo9eZnnNj8I7KMy0dWP2BnORjg9kBco4uvQIz2TG2RUEI57a2racBZZA
	 tsH3vNVzPWhtWRrl+Iuku0LctwIJdoqs/svD3AjeQWci0rnMz2uVSC5cQyGSX/53RA/Gs
	 4KQJFGqnFRDdTmf58le/yHB9z5P//gvcf2aqjjr9bgWQ/CgIQgKvM4tH8azmuYIQMkfqz
	 Y9cgQIvsO8ODhDjIC42xXN7nWwE0Ks+ZSDkJNgSf7UxSAscvCPAxDZjXHxaWRbuD2c20f
	 RDhiFrWprvwdmlqjwRYG9A9Zr7SJNMLM3hRGwxe7ScXzajTsHmjU1MTaMwKHVPaqPFA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791452990;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=6yrV3JbZef4GknAEhuzi7ZTQgr2H5RFwpAIrCaXjAds=;
	b=Mq2+0u/v2Yt3Vy/aElTErkPJ9VwyKt0UhSI0nsb7iNQgUUzR5cfTnwjon9qf+CcB9r3/
	 ccvIcFfcJunWpiRacZ8/Hepas1Dlt3zSG7augVs+GuNG+rwRs4B+w+sqgzLlTt1DUZvAm
	 geY3pDB9KHwAMDnY7J6OVNmDUDjVyrqR9to1Fo0IaVgm4spRPw5c98ucbO1y8s16xBBo3
	 bbApnPrW9kIL/kDyGr/R6kYzOF7O0uieNcnmnS4Izx10OunAYEtdbSeWYcRKD2SQ0N1VL
	 a5c03P/Svzamxg4eBbrthP5MDYWkDwqj1i5Qx8UTQV4RGuDdn7XBgezviaDiYUlpMpg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791452990;
	bh=6yrV3JbZef4GknAEhuzi7ZTQgr2H5RFwpAIrCaXjAds=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AE64zCYVCWsfcDyJTK3PRRJgJCcWHB2OnrgoG8Zdfx3dXzJH12MDzG8jHl8mFEx3i
	 3mC/dY6wDGZ7GagwrDBr4Xy2+5NyJI3c+B4W/Mzyd8eXAJak3lBjiothlJ6Tt78p7j
	 eJxxa4gaPw1sDHdA3QqSuy12Ja7uHIQB3oVoQjX2gc8nM0WdHih9Bdli6JHvgzL43Z
	 LE8Obc1V+aBKJwTGAqw2/Um6CSSWMMyWOinEjvGJOjc3N34sC4O0egbN98oW4K+wf/
	 TyhlYTOPk5VofMfZXwxJC4Srf6fBtyop1ZJg2CEUw/J2tTLFitCo30unnOrrmHaXN1
	 L1AhbWIwTdH5g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0C8E46085D;
	Thu,  8 Oct 2026 09:49:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 7F6222AA
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 09:49:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7D0B540944
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 09:49:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uTS9FW27z3gz for <u-boot@lists.u-boot-project.org>;
 Thu,  8 Oct 2026 09:49:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org C21824091E
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791452976;
 b=laLIPcLJhli4kIaKdfHhnwErGW163Ug5kRo1YidMnKPvRNLJh1WTXvU3pz46aIfgJn4z
 U9Fid2wEVoVvRk4J+5Q/4Blij/iD+em/pUuD9Z3xIdf6XU35mY57VeT3dy/dmyT9BASlV
 d0FL7tGLVHjHtZL5uM/8XlhBaNp7Lk+XLRkrWNrFtrZpUan9kJsxiIWlVLSNHmKam8sQp
 8iF+dUpB/sPMimbsAZdrxvGwX9GiInUJ5uJg/kbG8OsEx201pvUCJjG/zbe2iapvgOJts
 ADTvWQUMkDDG13BMIDV1g6WKMUbTBVMIRJV6CVZAOm0gCHOTn5vx2rGwSdp/GxKJAsg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791452976;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
 X-Authority-Analysis:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=6yrV3JbZef4GknAEhuzi7ZTQgr2H5RFwpAIrCaXjAds=;
 b=n8YENxzVYoBsq39EhUtQhB7kTRlXtzpmSSgs66oeZ4JxgT1ZzDHBqbVFsyS7u/0tQvx5
 fkIBaEIEQGNr//unloq0qAVlL/FXh9gBUc8qXVvZy9t6z8vjxmz9PiHENzBboAopwfsUT
 zL76bx5Al7bUmBGIPy//igOoks2KBwruZnyY13toD6vx9oULDjWCTpfpRosn6gTHmqMJK
 AG7J/RuQ749wRdF4ZCN5pq8BAWppgu7+aHxvraVV3KIQOkw6CM9/KCr4VyLi/ag0RzXfG
 d3T0Yaq2r2fjk3a5zgleG1BGROFjeuP2tU5efozcKj5n6GgGWodpZNCENThlnq9CsXg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=GXe3ufqZ; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=eXNcMYT3; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=abhilash.v@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=GXe3ufqZ; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=eXNcMYT3
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C21824091E
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 09:49:36 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6987KY1e730805
 for <u-boot@lists.u-boot-project.org>; Thu, 8 Oct 2026 09:49:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=6yrV3JbZef4
 GknAEhuzi7ZTQgr2H5RFwpAIrCaXjAds=; b=GXe3ufqZmrCI/PX7tDppXT6F0q4
 hzPobGKeGcDfydGxm/Kv3To5ANBOqjwB+aTUmRjMWOXUBLIdfWCzlkYuxRcU+/8i
 QE64BpArXVzhWdtB6TpeLzFxXG3DMEsVNLakOubqGc2X+FIAd7KzF9avmaiBcZ2b
 qSXm8YulIHvpQYF/mIqgNp1G6iwQdtQuuUqsR6eh/3awlSUIMpLXYFrP43umte88
 HTNUF6a1bibITDKnEaO81L4mSwdwQVgQw333KBExowaGS9/b++TP75Rptj+LwMX2
 2i2LQVmbk8zOTMOhUWAzzO67Khsids2bG1DS2M/HtuimYMuOw1hsN3vi/CQ==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5xe327sf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 08 Oct 2026 09:49:35 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-147be78cd56so18331163c88.1
 for <u-boot@lists.u-boot-project.org>; Thu, 08 Oct 2026 02:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791452975; x=1792057775;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=6yrV3JbZef4GknAEhuzi7ZTQgr2H5RFwpAIrCaXjAds=;
 b=eXNcMYT3jD4E0m23AJA81OSXhedp9RQRPt1jjzDoDDI9RVYCSkZm4CtiRoVICfc7RI
 Z5+A6Q01fXamQQFqYipf8hPCtNGA7DSdRTTrDNSyajLjsGcqJy6KY8mK38pCYEvvJBQd
 AaEPy8DsHjcqvBd2ysT9gcUe5oWWEcmPqfWnnonvR5KXdSxpA7kNi1HQAb9ot6bOQWzV
 UpZEZQrsS6vJypmZAPE24lfZjdplUm7BP7F5WEpKU16SbfpjC74aLKBrpjKI0YLBNUBI
 zsXEUufVrUzweme/K+PhfweGdWiFyQ8DsWHyCUnTGGTOCp/tRRN1y6lshL83kMo3amK4
 sGug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791452975; x=1792057775;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=6yrV3JbZef4GknAEhuzi7ZTQgr2H5RFwpAIrCaXjAds=;
 b=2VW99qmANyyO0RksuI8wRIqGazI5Pds0laRQzH+HAysQMdSLdlayy3pEwNGHuoZQGb
 hGbA6O+JvDJHqSU7qhTrU0Ww8NTV7QYH+8nt6+YZ90fOidyVOWtENz13wt5GIdiPZioj
 ISxxasPk6XjkTCYaWRyIU3JakOsxamLxPgemfGTuKo3Wbvz2WPiOSxOGquiDYf3AUIUD
 ZW0hgoQ28niH/6VrQoHDXJi5nti59Xk0CjLrT3MROnTqDNLugfc+KoOIgTTNoc1+juBQ
 x2a60+Jc8qC5lsyrU7+Lq/7R22+O1KQ9sgFSVwvs/UJDWAX8sW9UNiaRecb95hpHPkGa
 3XVg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxy9SJUdTF9pigsfJA/ohb4LYVrWOXoZMMi1mhrm4wbmBDU0VYxMBGe1iAvPaHhy0dty2XXU2w=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++k3ZCrzDlRx6gJX/bzNtMBxFjkKOvxROuACbwlu4Ae+iAqeVFFy
 q1ng+cRi2SvtwnCX+3dx+ivV3KbfCttVyYHLyyJJYOwnVN8tjw7U9rHDniNk6v1U40Ta4M+NsPc
 2y0/h0vk7iVdYex2/TPO2XWnFHWwlsR5KEc0A6tc7zZFmNZ/gLxOcwvThqOgS5ATdhTsBP/E=
X-Gm-Gg: AYBFou1ezgHDLpgFmL7IsOxAbVl/l3eR6Chi2dGBGqWdU24jxA5NILfDwVMRagAWJRf
 DarypYui6dU4xiY2gM8MyR7ZDfw+TW8FA/Xk+ThpOVAQsEZyczyx7N3aYuIKwHXxtP3AZ5DViQ4
 tno7LUlSVbWUN+X2bnkIpsVDnkexVJSv9Sc6fioDUbashTrEEYQbaCGcvGsFXNbtXL6lzg615jh
 5Y50QMrSLDbPpZ1vh/g4PjeY9YG4DEqivGIXX6PNKYqC5/9NLMT+xm4pZkBiwtJb5IONsF7jrvp
 EDS1yrP8HtI4LFr9f1hy6G0HCgm1moXjuwewwKWAIiVEmI8QkgEjk56okQNNUtQiPxE6NhvmK55
 rzJQH/75rG73M0qsYLnjnl3OELrY5e0/F8s/GJvGkcbnZX6I=
X-Received: by 2002:a05:701b:2096:20b0:15a:9834:73c9 with SMTP id
 a92af1059eb24-162089f4544mr5656340c88.40.1791452975122; 
 Thu, 08 Oct 2026 02:49:35 -0700 (PDT)
X-Received: by 2002:a05:701b:2096:20b0:15a:9834:73c9 with SMTP id
 a92af1059eb24-162089f4544mr5656232c88.40.1791452972941; 
 Thu, 08 Oct 2026 02:49:32 -0700 (PDT)
Received: from hu-abhiv-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-16375a1f898sm9977818c88.0.2026.10.08.02.49.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 02:49:32 -0700 (PDT)
From: Abhilash V <abhilash.v@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org,
 aswin.murugan@oss.qualcomm.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, lukma@nabladev.com,
 peng.fan@nxp.com, jh80.chung@samsung.com, tanmay.kathpalia@altera.com,
 abhilash.v@oss.qualcomm.com, sjg@chromium.org, Michael.Srba@seznam.cz,
 varadarajan.narayanan@oss.qualcomm.com, luca.weiss@fairphone.com,
 nikroks@mainlining.org, balaji.selvanathan@oss.qualcomm.com,
 jbx6244@gmail.com, u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: [PATCH v4 11/13] board: qualcomm: shikra: embed XBL-sec in SPL ELF
Date: Thu,  8 Oct 2026 02:49:10 -0700
Message-Id: <20261008094912.419090-12-abhilash.v@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261008094912.419090-1-abhilash.v@oss.qualcomm.com>
References: <20261008094912.419090-1-abhilash.v@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDAzOCBTYWx0ZWRfX2SWKabaj2f4P
 3xlFIOKGbev2j7gHMCp9/dZj6ISib3nJWcxhukXXFkUc04jFnCV0QrIglJYLaaYVcVFtrjcSHqx
 8dauFcSKks8IEmKJQJxhXsFfXiPYXgrE6FxfaReT8K4wvyMjrj/eqtfof1uu9T5iSqlhoCy4CTG
 Nv1oSKZDwDza5v/A2KflG2SPWNqO1l8XORHET/taI5mbEL7jSSlba4Hm67OjXCpOUwE0Z1Thtde
 RLhSmYel8zKy9v2ZEZtGHllGyeyArD1PnkgFMPjqZo+mB3wsjXPPV1c7aMCqFJi/uNEfjAs11Uf
 BApst6VEDzse9TxQigHR/W1R5QZyuBaAQsak2CjSek35HDdD9QqenSqGEFOGsE63sJ5r/J++rSy
 dOKl6AE6n7BZIqM1DJslaT7q3uh4TGkM8Ypxdqyyd+HaI485c61ToVo3asXZbFG0J6jXOVbZm/u
 /dMFzV0ijE4FfAITwAQ==
X-Proofpoint-ORIG-GUID: 5BmwUoCvJEqZVt0apkCrx-lj7n00ADyJ
X-Proofpoint-GUID: 5BmwUoCvJEqZVt0apkCrx-lj7n00ADyJ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDAzOCBTYWx0ZWRfX3zkFye8FxQON
 FJDlT03R8Urzm+kUSjOszHh4BnDGptchui3TZzDKgH7yWc+nhZRVlAKKoxFEgE702m0RKVpSb4d
 RVbT71h+atCkNEhgpGPyKQr0X/CRwww=
X-Authority-Analysis: v=2.4 cv=KcdHIgYD c=1 sm=1 tr=0 ts=6ac7672f cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=v_ZaApmAW4vm0h-ULSsA:9 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_03,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 clxscore=1015 impostorscore=0 suspectscore=0
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

Stage the configured XBL-sec ELF and embed it as a type-5
PT_LOAD segment in the remade SPL ELF. The linker script
places its complete ELF image at the configured Shikra
address, alongside the U-Boot SPL load segment.

The resulting u-boot-spl.elf is unsigned; external tooling
performs signing after the normal build.

Signed-off-by: Abhilash V <abhilash.v@oss.qualcomm.com>
---
 arch/arm/mach-snapdragon/Kconfig              | 10 +++++
 board/qualcomm/shikra/config.mk               | 24 +++++++++++
 board/qualcomm/shikra/shikra-spl-wrap-elf.lds | 42 ++++++++++++++-----
 3 files changed, 66 insertions(+), 10 deletions(-)
 create mode 100644 board/qualcomm/shikra/config.mk

diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdragon/Kconfig
index 5718b66cde1..b4fb05eec09 100644
--- a/arch/arm/mach-snapdragon/Kconfig
+++ b/arch/arm/mach-snapdragon/Kconfig
@@ -66,6 +66,16 @@ config QCOM_TMEL_ELF
 	  Path of the TME Elf file to be concatenated to u-boot.mbn to create
 	  boot rom expected multi-elf image
 
+config QCOM_XBL_SEC_ELF
+	string "XBL-sec ELF image"
+	depends on SPL && SPL_REMAKE_ELF
+	help
+	  Name of the XBL-sec ELF image in the U-Boot source-tree root to
+	  embed in the SPL ELF.
+
+	  The image is copied to the build output as xbl_sec.elf and embedded
+	  by the platform SPL linker script as a Qualcomm XBL-sec segment.
+
 choice
 	prompt "Qualcomm boot0.h workaround"
 	optional
diff --git a/board/qualcomm/shikra/config.mk b/board/qualcomm/shikra/config.mk
new file mode 100644
index 00000000000..51480059410
--- /dev/null
+++ b/board/qualcomm/shikra/config.mk
@@ -0,0 +1,24 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Shikra secure SPL image generation.
+#
+# The XBL-sec image is provided to the SPL linker script as xbl_sec.elf.
+# The generated spl/u-boot-spl.elf contains the XBL-sec type-5 PT_LOAD
+# segment.
+
+# The input name is selected by CONFIG_QCOM_XBL_SEC_ELF and is resolved in
+# the source-tree root. Signing is intentionally performed outside the
+# U-Boot build.
+QCOM_SHIKRA_XBL_SEC_INPUT := $(srctree)/$(CONFIG_QCOM_XBL_SEC_ELF:"%"=%)
+
+QCOM_SHIKRA_XBL_SEC_ELF := xbl_sec.elf
+
+quiet_cmd_shikra_xbl_sec = XBLSEC   $@
+      cmd_shikra_xbl_sec = cp $< $@
+
+# Stage the configured XBL-sec image in the output directory before linking
+# the SPL ELF.
+$(QCOM_SHIKRA_XBL_SEC_ELF): $(QCOM_SHIKRA_XBL_SEC_INPUT) FORCE
+	$(call if_changed,shikra_xbl_sec)
+
+spl/u-boot-spl.elf: $(QCOM_SHIKRA_XBL_SEC_ELF)
diff --git a/board/qualcomm/shikra/shikra-spl-wrap-elf.lds b/board/qualcomm/shikra/shikra-spl-wrap-elf.lds
index b2922cd2c2c..387b83ae6dc 100644
--- a/board/qualcomm/shikra/shikra-spl-wrap-elf.lds
+++ b/board/qualcomm/shikra/shikra-spl-wrap-elf.lds
@@ -1,18 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries. */
+
+/* The boot ROM identifies XBL-sec by the segment type in p_flags. */
+#define PF_SEGMENT_TYPE_XBL_SEC 5
+
 /*
- * SPDX-License-Identifier: GPL-2.0-only
- * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ * The XBL-sec segment address must match the address encoded by the supplied
+ * XBL-sec image:
+ *
+ *   entry address  0x0c350000
+ *   LOAD offset    0x00002000
+ *   base address   0x0c34e000
  */
+#define XBL_SEC_SEGMENT_ADDR 0x000000000c34e000
+
+/* xbl_sec.elf is staged in the output directory by the board build rules. */
+TARGET("binary")
+INPUT("./xbl_sec.elf")
+
+OUTPUT_FORMAT("default")
+
+ENTRY(CONFIG_PLATFORM_ELFENTRY)
+
 PHDRS {
-	ptype PT_LOAD FLAGS(0x7);
+	data PT_LOAD FLAGS(7);
+	xbl_sec PT_LOAD FLAGS(5 | (PF_SEGMENT_TYPE_XBL_SEC << 24));
 }
 
-ENTRY(_entry)
-
 SECTIONS {
+	. = XBL_SEC_SEGMENT_ADDR;
+	.xbl_sec : {
+		"./xbl_sec.elf"
+	} :xbl_sec
+
 	. = CONFIG_PLATFORM_ELFENTRY;
-	_entry = . ;
-	data : {
-		*(.data)
-		. = ALIGN(4);
-	} :ptype
+	.data : {
+		*(.data*)
+	} :data
 }
-- 
2.34.1

