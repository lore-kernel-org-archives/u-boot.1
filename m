Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4E5606A688
	for <u-boot@archiver.kernel.org>; Tue, 24 Nov 2026 16:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Xr8SmjAb;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=BLZ0bfQk;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NFdo8OvF
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EB78B405C4;
	Tue, 24 Nov 2026 16:47:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id z8Fwac2jlNrw; Tue, 24 Nov 2026 16:47:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 40E18405AD
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795538875;
	b=fNyaoQh+cdpfvdJPWlhVJ/HliQiq9WCdkotd3qVr+gVn86yEPaUHuoWv8KK1omo+4lbc
	 UMmn3z9+7ZiqALNHqFQfkh1Ph2v8eq0Eocu4Mz+4ZR0DQER7M+hfFrbeIyrukwAKqamao
	 QQGENeeU65n+MhDF/WpvAOkzSQ2H7u4P4JuWkTIe+pSmdLEsKGrfZ14dRd/4AMe0gXm6r
	 8QoWgYnHd4GlbqivjgMHTbJq8wZ88t7wfEOD19cUsaG19YAi0quWQLE0sKr9ECbizOCFx
	 Pds6XvR5ZnV54P/6zXSM/Gsle1FFJ+5n0T0bZUhLbW0o8opQKijxZdor8Vb6LOyLUBw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795538875;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=jYeLB6+QYQS5tfXYNToMI4fc8E9bNTQ5n57g9yKHZf0=;
	b=Vhi+Kn4CX1uCXtpSox6SmY3Tfp1eDKHipATTNYpxlBb6K78Cwy2xDys5/PBXlIX+x193
	 mA4mzGdfpojOHyofD6/GfdPY12xz9KNE8SkZd5Yg134nzyux/mksFZ9SwwbPiahXzmAmd
	 ssLgTZ64G+PkGYYTC2EJQ48/Fl24TDCEg1GS1/74ImnGyxk9RXyyCjOMC3eFJKkOWWt2O
	 wbMlTaxmr+JWIUb8XLJ2yeNe4uiSwVqUSalBnzAKY/WJyy9rwmDKOSTpHfp32E/x9ycNX
	 RozUbKEchmosjvcaI5HGwPeX41GUBtlJavFn0B+kh3HpMdV6dU26uwFR9TUUH1Jc0Bw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795538875;
	bh=jYeLB6+QYQS5tfXYNToMI4fc8E9bNTQ5n57g9yKHZf0=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Xr8SmjAb52OBXG2kAMrh2HCKvyapGNanF2M9wZ6KUFQmfclhMImbCKhpAOdPdms9e
	 EzaDrJwLbWEzunNKNNqVV4nyEW9y13dWPJYMtk4w54lHuE0N4+fqnOHHCPfJXCdDAx
	 xlLjnAWV2u1Ny+xP2ElTucpfyKCNOsvJJf5vYAN+u9Q8p4ydAut4RYHl9ohwd1Lu/q
	 zjo1zh1t8JhuejGADRfaIsGkotJehC8qmp4kjgcSCMN38Iis8pKVzQfNWCdOnIgWfD
	 rNKyIb/sHSf/RHN1hCXMH3qbzOb5LGaeWEQACpDP9/JAEaZIPH2QNm/pQUjoZP9QEK
	 1sWhy94T1rYvQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 40E18405AD;
	Tue, 24 Nov 2026 16:47:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 7531A3A8
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 16:47:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5B6964018D
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 16:47:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1ZJ55pErO0Zr for <u-boot@lists.u-boot-project.org>;
 Tue, 24 Nov 2026 16:47:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 9AF0C400B3
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=BLZ0bfQk; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=NFdo8OvF
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9AF0C400B3
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 16:47:51 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AOFL3Kw1873400
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 16:47:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=jYeLB6+QYQS
 5tfXYNToMI4fc8E9bNTQ5n57g9yKHZf0=; b=BLZ0bfQkLz4s22gkAKkrjnqx3G7
 yARo0uZZ3tovesRDFSb6zhyBooLFm+G+Iw5cUmsmD5J1BxDlA5Un6sODhIRntGCy
 oANwuBI5KgEJwBM75wGMwNf/p8Jr41jcQesff3sew01FV/l58bQH0xOcOtiVcTp2
 19DjPSn6w6V+SAUwX+85pPVVNDDLKXRr7cl/OUm028B+y1eWxc0Uf8kInOxATzqu
 2+Es7aCwuiLvxGQHlqdZIitrvZ3ml1agf+Mfzxvfhdp9qWMft9ND3i700BASUZT1
 ES8sc2Wlnj6IpUkdWGksWTiia2d1K5pKPYaEFz8bO2Tf4mt3nFXQyBG28iA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5cxk8f7c-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 16:47:50 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-3846d5f54c1so5871260eec.1
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 08:47:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795538870; x=1796143670;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=jYeLB6+QYQS5tfXYNToMI4fc8E9bNTQ5n57g9yKHZf0=;
 b=NFdo8OvFsmhLdoLkE5Nh8SkVS5k6rDd/Um+PFb4WkNlSskH3c9bBVndgOEtUQsmopM
 MFDVDTIo7cxY8ywS0vRVovqwIt8QXHd4eOQxFAO9FSGisb/JbvCDRiU5DfMK17sHm+E4
 8K6962U8cNjGryY5nuOeIbCWtEj1IqbIDRzQLqPgVRHLvUvg6eCl5EwRZ4J/1m/TmzIl
 npbnJhpWAD4LaU2sMnkcU295pjxz5eabiU/yRdgwzxcYdN+ALzs7bkFdqCOW9BGqhh4+
 JJlH7wPZArqNpTTVyelln4f0VRqQiaSltjVjeVutidL3y5x26ICgDSe60z1VTzWVLDPi
 TwBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795538870; x=1796143670;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=jYeLB6+QYQS5tfXYNToMI4fc8E9bNTQ5n57g9yKHZf0=;
 b=DCwDwEK5c7P2jsF3hJs4AjdJ3becM0Xm4EPggL48zf6J+s2NrglK0793hhi6ZsVwJi
 e31H6DcPt+hOfUz5F9l+1YL6OKpB/sxswqMsH5srSgXb+lhTy10ov1Mef5TVkjgPR5cE
 lP0kbhybTWrtoAX93linkwU/cxHi8nfKQB8trMKt3fwNer+D4O8CeprRvrR7KKyiCwKp
 Cj2myoy8ctnENT65OQTyk7bMdO/3jvZRYovRju+PJKawODb7qF5gc+hyMWqE9jbyrSIH
 uvJ2bbDMAv8XcyUm0ZoE8cn8IlxDMKFfrm4Y2DNtz9IjL3Tn0KYsxqaJyF+Nufx1Or3p
 H+Wg==
X-Forwarded-Encrypted: i=1;
 AL+hErEr551Cy8PvlWg5HwgTvpy27BWtjbC2zfv9OaiHB/tuIZ1lXW1I3C32aEwdvtxaj8JyvjmFdeQ=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/ba5r8Sp6STd8Lk4NtDJoxi1UYN93EYNT7IIy8nHSSKf4cAdEg
 zjwaG98yGUF92B+btVzPUHkF2BMkTSfQQAYyrembhAl+5JoY9PCFTbuvF2+c2hiSSIb+x2f+OZI
 /vlz4oYibV+hwcJd9cMEE0Yp7XA/vOzh+ePSXHsr/ISvsEG53/INRO/MhjI2n6EOYfSgKJCQ=
X-Gm-Gg: AZFdTZe1hhuZtIpFX0PzABYD1HUgmsqitDzMYvRgttgz0yBlRhK3ErKJJI0xwU68Oiu
 00ACFDTE1wDPjGxehwqKdVomZ9Oel5/H3gZTs1M8vZ84Rh6T026JLppkkpLh1hS7wC/aaK/Chjb
 vBKr215JrnR5JDJ3uYW+OBaBl7vpAH4ZEv+PccvPZIFwvKgsSnFGIyt9rK5c8ikVcTkN03qQuX9
 5USXM0XvxwM0OJLl6vszMd9vrt6DR1HpiYHyMbi4riHfEhFk2Ggd1UPy1kIF021W5anklJPT6u8
 VadoMkbOTgP4+OLx7YCx7cA5Yi2ED6SXib7qY76GqaWUuw9DW2H1KcqezfhI9ZBGb1SwA2WxCgR
 PDHEG4RMALqEXuNFXyLCWxFtJa7ht/+vXXBG8UvxUxibwf1Vcy7ctSrYM5A4ctrl2iXgFrG8aNL
 Dw5akhNDS8Xu77JSCi49IgKo4HvEoE52TkAJ6s6vrBcngTCZHgzIWxDaPnz2+2bYhgpANR
X-Received: by 2002:a05:7300:ff48:b0:385:3595:5e87 with SMTP id
 5a478bee46e88-3856fd5b5damr14775291eec.16.1795538870169; 
 Tue, 24 Nov 2026 08:47:50 -0800 (PST)
X-Received: by 2002:a05:7300:ff48:b0:385:3595:5e87 with SMTP id
 5a478bee46e88-3856fd5b5damr14775254eec.16.1795538869619; 
 Tue, 24 Nov 2026 08:47:49 -0800 (PST)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-38566cd40c5sm55365072eec.10.2026.11.24.08.47.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 08:47:49 -0800 (PST)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com,
 aswin.murugan@oss.qualcomm.com, lukma@nabladev.com,
 marek.vasut+usb@mailbox.org, balaji.selvanathan@oss.qualcomm.com,
 Michael.Srba@seznam.cz, quentin.schulz@cherry.de,
 william.bright@imd-tec.com, nikroks@mainlining.org,
 macpaul.lin@mediatek.com, dlechner@baylibre.com, xerikasxx@gmail.com,
 jbx6244@gmail.com, u-boot-qcom@groups.io, u-boot@lists.u-boot-project.org
Subject: [PATCH v6 7/9] qcom_defconfig: Enable Shikra clock & USB driver
Date: Tue, 24 Nov 2026 22:16:58 +0530
Message-Id: <20261124164700.1606518-8-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261124164700.1606518-1-aswin.murugan@oss.qualcomm.com>
References: <20261124164700.1606518-1-aswin.murugan@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA2NSBTYWx0ZWRfX9X9b+eQ8exAN
 xmEYbyigkcKuattsg5en7Hc1woNLLuedA0nJ68vZwXeEVUdYsX9HtCcg9bIYDzLI04LLejiDFNw
 4tUuhBInTi/njapVZFapocm+s75urCv3rRBSrGMTgAq/RhZ9lzmRBklu+LzTJKPWv6bY2q6dssf
 1kFzi3jqbNYnOPVjlxUthI+ARvPuI1UABftNyB74m88RGXCmHkRjkInA1IKOm0LPxCwOPMwgfLL
 lNt9tTdkwG+U7r6AJO5HM73xmmfyvGOyLryCZMqQhzAiKbeJAPLfdCQqU5kkswhQ75OQAd+3q48
 DrrixufrmjLiLqVKTyB4kqJQUiC8TArddSp5XFD3vpwzOoVx+gXT1x6Lz637dcpKR8zdKhrcaNK
 FmnhRDb2TM7bFAQIk9wZdottLwUtAmO2sg1yIv42ZaJFdy04tTcxrLn2tIqVm1BDIR+/LyNb+9j
 obFsq5OOgawbl5qJySg==
X-Proofpoint-GUID: Ussk8M9WVz21u7xdSRuFKJ5Qd26hXsZS
X-Proofpoint-ORIG-GUID: Ussk8M9WVz21u7xdSRuFKJ5Qd26hXsZS
X-Authority-Analysis: v=2.4 cv=TLbQ2Fla c=1 sm=1 tr=0 ts=6b05bfb6 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=uqFMpbG4MC8BjM4yXrYA:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA2NSBTYWx0ZWRfX1+F7gYbEPsn1
 gaZ5nKMrrlEKSXbvpm6JOyGbxQsUM5mP1jnCVyYnRnzBzWVgqyrypKOF4jb4AOEDZ93HF4vSVpX
 gK6bKjG3rJ3JixD34J4uAFQL9RPJb0Y=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_04,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 spamscore=0 clxscore=1015 suspectscore=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240065
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

Enable the Shikra clock & USB driver in Qualcomm defconfig.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 configs/qcom_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index db399d92c44..0b26e280ffc 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -62,6 +62,7 @@ CONFIG_CLK_QCOM_QCS615=y
 CONFIG_CLK_QCOM_QCS8300=y
 CONFIG_CLK_QCOM_SA8775P=y
 CONFIG_CLK_QCOM_SDM845=y
+CONFIG_CLK_QCOM_SHIKRA=y
 CONFIG_CLK_QCOM_SM6115=y
 CONFIG_CLK_QCOM_SM6125=y
 CONFIG_CLK_QCOM_SM6350=y
@@ -113,6 +114,7 @@ CONFIG_PHY_MICREL_KSZ90X1=y
 CONFIG_PHY=y
 CONFIG_PHY_QCOM_QMP_COMBO=y
 CONFIG_PHY_QCOM_QMP_UFS=y
+CONFIG_PHY_QCOM_QMP_USBC=y
 CONFIG_PHY_QCOM_QUSB2=y
 CONFIG_PHY_QCOM_USB_SNPS_FEMTO_V2=y
 CONFIG_PHY_QCOM_SNPS_EUSB2=y
-- 
2.34.1

