Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CB6CCA9ED0
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 01:53:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C692D60660;
	Tue, 13 Oct 2026 01:53:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1mv17LVsNTPA; Tue, 13 Oct 2026 01:53:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 18416606F0
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791856419;
	b=XWxQnq3pGWNWCtlV8wyBdussTrtUKn9PtA4ipZz3hBsOv4F23LQxpWQIGmm2w/hCK1xT
	 x8N0lisr/ccSiWwhWFmMpeyMhnPmj1trtjKkIwnY/ps7OJoHg//UeN7cUJ9dmctfhO+Pl
	 w8f+PAm/8g+OGNNg+D0kra6SSjKItsdZXeA/F9rrsziLh2SKdert2Eytn3LLuxSzyCNhK
	 cdX3hIyskidZV5N40+K6hSKaIvwGmQTXEJths7ArZ7sAYeRn64++NEKXimn7M7c7YstcB
	 VzNjUC06xoHj96z+iROaXvwwUvqMuCmjA1faModMIfdcboIM/5SXGNGtrpJ+aywmO5w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791856419;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=FLuS+CpGAPSTbhzedsRVj9s9aLRtNoo1n/XYgqZRSBw=;
	b=OCj2tzclUvM54GxUPzhyCZRHEWn4PHRtcaZ/C0+Xu3EzfBAPv6aLyr6J7Mzl9JhPj4iO
	 dqsLCnQC6ctTO8nMs41+9Zk8/uGAtMRjOB11ZnI4LAh+M43n7BQqR4vtn1etJyYY3LW4a
	 xRzBjeL8Nca7IdOpmpXF8Q+BCdMYl2jqX/NHeM2rc0AOxHtMSBaElnVQegBHscCjqaBPa
	 obKacIz3AQg62ZgQkGSIasO3anz0Y5alU8xwm3ORAsYn64Qg/ghNbOcmVNR7f5KC+XYtr
	 lEiNgxvs1v4m9ZkjcT1E+gWAutBPn/M4G9ph/f1VQo3JWf38u02U8692YczkEA1royg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791856419;
	bh=FLuS+CpGAPSTbhzedsRVj9s9aLRtNoo1n/XYgqZRSBw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JoDjN1I54S0w75Av+rnUq375UPCkoARS5ffSvXcIx6CU+UBdVaX/uybATszVgyGmp
	 eZ0WaYYhqcwwhqYcJB2ARsDITdyghPxPoDV/bAJrkciKa7kPhgt9yHQiCVGZoNOPx6
	 ZuSn3Yva9sgdDhVby+BDA4mIFlE4GvPp4GkiZHyaEr8RQgQxzBbwpNeB1zWdSk0ar3
	 k9Tx05to4kuZXkySubAzVbBOle7GdClC6lppUMVCSR0/hRjYzZPdLkzwSJTNGuxVjV
	 HLxv5YqMHtGMbwgeYy1u2VJl3+Sj6T894DL6iQ08BmhjHmf+hT3dVXXYE2bCCu71eL
	 AlF4KZgOpmrjQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 18416606F0;
	Tue, 13 Oct 2026 01:53:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id EAFF9731
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 01:53:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D189B4008B
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 01:53:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yxI9TXnxMgM9 for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 01:53:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 0A31C4004A
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791856417;
 b=cqUbWujChU0EzfrDMsp2yVAO08GK4CNFf+8/PBTniCaIywsE6WwZL3SYKevOHIOVS49n
 PVPaCWYkl5g24e5jujcwWeMcFJywRI81NGw+j6+mPFaZXbM7CRkcPHfoNI9gmh6LlscmF
 yQsCLgp5xuqFEdTOiKjELbNJCYD8/Vxh2th+O1QDlWs3SftxUbnIsdkLAhOhLiefYb7Nr
 QI2ETfZIJpD4+BoFTqGRL6agWZ6OlLipIz9BZTJeXJXPaw4dgiqvbonyO9y3UP/Wth4T0
 bo4Yy/O1ra+H8YasUXVZrrT3F9EjYRMKx0vMQt1i/ogMSTe8skL9gX+fA3RSvNN9JHA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791856417;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=FLuS+CpGAPSTbhzedsRVj9s9aLRtNoo1n/XYgqZRSBw=;
 b=nx92b5D9kPaUnKcBZeXkaSHVgFk2jASZ1LbVLOffjTjTTiOOy8AwfZo6LWR5A6GSZFjZ
 yR78RckWgr1laoTZpFi3uj6LDARoEj/Oqr/xmSnY6HqQi7xrJRG4cQevx/9qhSZ/5kCvo
 iyTInikhktZ5oCYdNw9+xwF55qhTrF0frYwLCJeXeeN8cGsqcFbO6LRly4zOYijC0o4i6
 6LdHPt7VffVPZ+/A5uOwG+BeYbQ8BRDLU5erIRaqYsGrd8rvMPTweRU3aiuAMPGKHHm0m
 26BcdLilpK67a2vQmeKR6zBK7OWwa0sr3i4vPm4/K2GjB3K1fs+D03dX59/+N/Sgk7A==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=VTl5svX1; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=IL4jAcop; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=VTl5svX1; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=IL4jAcop
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0A31C4004A
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 01:53:35 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69CMcjFY565247
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 01:53:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 FLuS+CpGAPSTbhzedsRVj9s9aLRtNoo1n/XYgqZRSBw=; b=VTl5svX1R+n6ap9L
 sn3DSvM5MWOqL+t45QIcMk77S9xim1ZE/0BK+kUoMXpNPgU9/+ZHONwRcQAtfenx
 ttPlIBGSh1+/cFtZcFwQRCUszH66vnxiDDgYPzp12N8+JhiwsSVeSSvBmrMCoMMt
 V3twFC/0FsL6ZtGGf0bKL6skN/OnKXv/CW5AVtlpkdri1SMoEEq7IgKKynCP/lGL
 RDfvjMv5UYXUw9NY5WlRmHHbmIDPMHJr8gxwQEG8WUigaGLP1FPAe9ycQmABzrBc
 HFjyqT/lCkA654j4cPEbBm+XepvHclTW9i9Xrbubk1/pt461akSq7Ca3CGsrmB6A
 KmLJxg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h98hc8gme-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 01:53:34 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-3592749a017so2144758eec.1
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 18:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791856414; x=1792461214;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FLuS+CpGAPSTbhzedsRVj9s9aLRtNoo1n/XYgqZRSBw=;
 b=IL4jAcopT9EaXC6EphXVq/A5W5DJE8d4wf01E+dw95IEB/3M02kez6Dn+7WPqRGEV/
 82WRrlgL1yWFd5fxhMDWu7F5TIv0fyyLYVXkO+fvYiyMo0ChvKNhxbBXy/T2JGJToDWI
 FR6c8XKTM/BjMH+xRNRAgDW7jcSWErmdPdQ7omwFLcswAAJ2WiC1niMQbxz8ycBYn8G3
 ggJkdpKvrWFFvo8VlBuESJAuv6GSOpFnqlZ2aLReoK5EvTk5cuopMWZNm7umpBl1NUiP
 e3NvycTyA81q9oOGhenRdqlPAUwk2y7Vjlk7b9Hyxkyf7rg6Em/0d3sxfdgfavgWW8zV
 aSpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791856414; x=1792461214;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FLuS+CpGAPSTbhzedsRVj9s9aLRtNoo1n/XYgqZRSBw=;
 b=lv2+hIxj+ib8gJHu6k9AM6gmZWqK04whMVHDbFnku30LWbJZ0fYmYNQZ6Yr/ZFAb/5
 NFx6htVAYtZM8L39cvBNK/tWUk1Oc45qTguekNVvZiwUaWzcoqhtbGsiEeF6n1uMGphs
 MHItx/IBqvsk9qv+DOjchf1my97rHR2NNznR5AXDTbhn0W+QoZKCcE83NEzOqFq3kpjs
 wPn+TXVUu/Vx84nDYcJ084Nz4GEEvrD9MmzqId81FwmRxmT53KBgVPSlpuXs3G9oBNMY
 kav7zGY9RT6Di2Us0um+XAIJrp+su87AHuHVJpAMMdcY3nztVL2hPAX0ap30gkwfvgSE
 5Quw==
X-Gm-Message-State: AFq9FYLKX72du90ohqJvL8II4vUtt1KoUnQIHFVRjQ9ZAl3/JXXszSDp
 BxUwc68MG80aY/aCP/47FhuYQtoSF3UNY8sOrXCfi3qBlqUJfdZACDlALfNQtD4AxLeFLYuU4EX
 nqbwSI8g17As1E6TnbAHsyOLPWVH/xzz1P76nKnuSyOrdcTTrBoYnZ/TvykeU7F/xVvQ8ObM=
X-Gm-Gg: AYBFou1p/KrLSxrNgSjINciN8ninqZbaDaZIkq8ydbTfon6elxFvTeRVrS39bwlz8zD
 RMFEqtGSmdp8vSu/NFO6ISkXjTncGrtOLak3eh1HSiosJW5AFo5C0UPiWzazPwni3LmBKE+qAJ5
 zcmf8gPPiNEsU1tQTMI40wMTUZmTh822FUzx5nX+4TIEtQ6Jp3Ak0wGdjbsdoWAJ4/G0JZNSPbW
 rkMHD4UXukmQzILgdbbqWZ0qzp750oZ62MGiQzxB0a4mnrgJc79rCYBEIj4DiMgi673ClOezP2p
 +gL9kvUQpGiJydWACnZ2IDrXoYr7e+2NmbykDBLPkyOhSxbVpJnvNw5LbS81ihr+wgnkFB0XzZv
 ixv2/7cRSBtJb0yNzGYrE6Rp5JYivGwqPZ41x4PjHoymvJj6igUy8aPwY8as1Go4JOmH1D2QTkI
 S8qimXeE47mr2jjvi6uAgXvTvkXgM=
X-Received: by 2002:a05:7300:51d6:b0:35c:5c48:19ad with SMTP id
 5a478bee46e88-35c5c481a53mr1179242eec.5.1791856414307; 
 Mon, 12 Oct 2026 18:53:34 -0700 (PDT)
X-Received: by 2002:a05:7300:51d6:b0:35c:5c48:19ad with SMTP id
 5a478bee46e88-35c5c481a53mr1179190eec.5.1791856413732; 
 Mon, 12 Oct 2026 18:53:33 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537cb68e56sm34612666eec.29.2026.10.12.18.53.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 18:53:33 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Tue, 13 Oct 2026 07:23:11 +0530
Subject: [PATCH v7 2/8] arm: snapdragon: Guard PSCI functions with
 CONFIG_ARM_SMCCC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261013-snagboot-v7-2-fc296a32836a@oss.qualcomm.com>
References: <20261013-snagboot-v7-0-fc296a32836a@oss.qualcomm.com>
In-Reply-To: <20261013-snagboot-v7-0-fc296a32836a@oss.qualcomm.com>
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
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791856396; l=1447;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=LB4JLdu0EwvljUsiEw/wbtHkBd6leAp7LUyhNhIrloc=;
 b=gQV7JehHi0SyiohOcTJFE0BuFAeMFH+97J01Il0Hyrs1c8la4ITn27eIbgqa7j/foXUERnc5Q
 BjypAwq8z7qCHa5yNL3unGMuzsWXGuxL24nTqKNQi5IFlmFtHrwTegK
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDAwNyBTYWx0ZWRfX39D3ULBVh2Oj
 BW77Wj1BS6zp6jZS/QkmDwrqTFYWHFSHb9XbVDQhcH8yQYh3QNvU7kzeptpfMmPWEG95/+bPXjX
 phjWawt7GAE9In840PmSTowHaMRonGxxVsERSu56kHOkiEfElAiydtt+maFqmTC8JdxCbfsB4t3
 LoXgdprNfHzNPQhxuQBvaPVBosEsIXbygoEpM+p6pn7NY2Xu/7VafsX3OgAHQfJyewCO1XC7Tjw
 cjfVgB1TIsnp1aaZI5iObauS+L5VLkLJLEHdU95K2fuFBX1BDmymlcvef5YHD5xftrUEGh9b1tP
 ATUMUhtZETODsFl36kDtQhN7FzAUPc9MUgSau5jdQSnRG1YTzBMZuXI1nnJOyC68MdH6Bn0A3VZ
 gSmjnZKKQRvoU+VtIM8zCMan21OoM4bRdE0hmHu1Gm3UXUAFXrbBMwj5zLaJR1M29aoagvXdI7S
 fUeg29K51q+8uRxFwFA==
X-Authority-Analysis: v=2.4 cv=VPVIDNPX c=1 sm=1 tr=0 ts=6acd8f1f cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=xAI3I7ZSbV2oIbCD5NEA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: EvAx5B8yuJH5IA1-vh6mLmBi9EIY-0nI
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDAwNyBTYWx0ZWRfX15YKeKXjeHda
 iWuNRRqn3poFF1u4uVvjued23g1cOITAxxhdZO3lIGEHpvpiJacywipt8R1L0DYTvqEmh65u3Vs
 1dYLxH5jQDN4P9HwiqUIO0H0kjRw+0A=
X-Proofpoint-GUID: EvAx5B8yuJH5IA1-vh6mLmBi9EIY-0nI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_06,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 spamscore=0
 suspectscore=0 lowpriorityscore=0 adultscore=0 phishscore=0 clxscore=1015
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

In snagboot mode, U-Boot is loaded directly by XBL without PSCI
firmware support. The functions show_psci_version() and
qcom_psci_fixup() call arm_smccc_smc() which is unavailable when
CONFIG_ARM_SMCCC is disabled, causing build failures.

Hence, added CONFIG_ARM_SMCCC guards to both functions.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v7:
- No changes

Changes in v5:
- No changes

Changes in v4:
- No changes

Changes in v3:
- Added CONFIG_ARM_SMCCC guards

Changes in v2:
- Newly introduced in v2
---
 arch/arm/mach-snapdragon/board.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
index 87adb100edd..daee2ed4fa0 100644
--- a/arch/arm/mach-snapdragon/board.c
+++ b/arch/arm/mach-snapdragon/board.c
@@ -35,6 +35,9 @@ static void show_psci_version(void)
 {
 	struct arm_smccc_res res;
 
+	if (!IS_ENABLED(CONFIG_ARM_SMCCC))
+		return;
+
 	arm_smccc_smc(ARM_PSCI_0_2_FN_PSCI_VERSION, 0, 0, 0, 0, 0, 0, 0, &res);
 
 	/* Some older SoCs like MSM8916 don't always support PSCI */
@@ -58,6 +61,9 @@ static void qcom_psci_fixup(void *fdt)
 	int offset, ret;
 	struct arm_smccc_res res;
 
+	if (!IS_ENABLED(CONFIG_ARM_SMCCC))
+		return;
+
 	arm_smccc_smc(ARM_PSCI_0_2_FN_PSCI_VERSION, 0, 0, 0, 0, 0, 0, 0, &res);
 
 	if ((int)res.a0 != PSCI_RET_NOT_SUPPORTED)

-- 
2.34.1

