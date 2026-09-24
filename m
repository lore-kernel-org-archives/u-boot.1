Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3DF3C98304
	for <u-boot@archiver.kernel.org>; Thu, 24 Sep 2026 05:08:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2DB35812F9;
	Thu, 24 Sep 2026 05:08:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4dUFCe2aeMV0; Thu, 24 Sep 2026 05:08:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 646A781314
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790226486;
	b=fyR3qHQK2UeSdHRBUg24ZtKiNxJe7a/yN8FwjHzdviRmjZ6MQx0zepxPQ94KDfCYt0Wr
	 I5TB2QU+ZT5/q1HZ/2OKuUjMWbAmQSntu+CC5szvBUg+gT6fKxstcewPOQ3wHeO0Drh3J
	 Tuj/rT8EArS/8ZuRHVGsLOZMG4M8QXzJPkpylef+o2qrSMXvBOOnKjMMvnKjTmBtgzMcy
	 ZRPObonKz6ZhgnpUmtyXOR4c7Wwk+D+EUxOdweoAGahwqxH3Z6sgN7OOjq9gAYnKOlIdK
	 WrFZ0EqGkaVY92ivcu42lIRp4cRfFhR4ysurdLQYPUlQNp1iWHXJj871RCQdMAeLaGQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790226486;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=NqA6OlnyVjP05MAItB8evvzXWncAmy6N4NuUTkLIx10=;
	b=gucHUx3iMZR8uy18nSrXgB54/YRqIjOgjWAWbC3C1rDrDDdYA8M6wz43PrdsUFZHorlf
	 DnA1ObQdnUiwy4Uhh150JU3Ml6tTKjRxqz3Lctfd5BSIeotJrRpzaB7+DQEBba/hnIo94
	 Qh0n0qIF7FKadk3JrHezbceHGu/Mh0NTMNfAAVEBUwA57l231sz4oRQJ8E7cA0a4m+VJ+
	 4QjJVWjS9Uy1htLGuLPUxd9yYS59kmZ6sQZkiWYgSfw/NSqb0zAs5kJlqvf1uCSMgxMBd
	 LVkbW83bPo/3OH/vRevF3Xzz1+tuwr5GbhMMKykmOlCznKidw3E1JCNa+Ozc3y2udHw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790226486;
	bh=NqA6OlnyVjP05MAItB8evvzXWncAmy6N4NuUTkLIx10=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=H211nTn8OXq95cS/o725/EPCWsU+h/uuRjEW2yvtLuCbjrfIILXPP8i8SeFF4uVLN
	 IkkbXliH3rW5+hM5ui8eoSBUulYe5k57Syj5XpZ5ajrUyPQQVA4TntzyiH2UCFUSQ9
	 62WtJ1nYVrOlaXxci8ugplTti2RJS+7Xk7dDlpi0+eEiu0NTxbEnA/fIsfi5nU/qHL
	 slX79XKvIrmuGhETQlFtMG816CpiVYPVi16rWTufoA1s8x4Ak+DPv+F0Pr/lohdUvR
	 Gx3fs+XTyFBIP0fjGdikR2utDkguF/wtzbkbYSkZmgA6m3JsXd6Kw6WPgLYeksy/RY
	 GZMm2HekvbjHw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 646A781314;
	Thu, 24 Sep 2026 05:08:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id E435F2F5
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 05:08:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D538860B1B
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 05:08:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CHSLuxYHbFxb for <u-boot@lists.u-boot-project.org>;
 Thu, 24 Sep 2026 05:08:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org E7F0860645
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790226484;
 b=rWlfYfltiz4o1mVLc/KNlUsFNwmkusv7lpnsN7NFtfLwakaRU6kDyikXpMOwj86gVg/Q
 CyNhT6O4sL1sZNAWu4ppTGBb2SHejg2RGcK9Hg1E7myGw0vxrVnajqcfhE2PFgcn+MC0E
 HpPJi0nOEi5rM0a8eT0RsloK1bOPURTbzlzpG38tprqDntwfDkc0BnDxd0XfSGbKaQuXG
 4nNbUT3c/VCWZx7/YE5Od50zr77TODEX8M7VaJ3CKtF+6Y6sO94mYJboBtQPqvwE+q/oN
 Dboc7V5xdQ/YFtmeJex/zHNosQ5KwNjEj2G6K64Woy3lWWy/h+Mf2uHzsYud/FSx8UQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790226484;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=NqA6OlnyVjP05MAItB8evvzXWncAmy6N4NuUTkLIx10=;
 b=Ek2B81iv4XPEdoUy2bHq6VxUzxB8ZDrHqiSxVpPt/Xf9jJGCqHzwSlYP4ZjmOXMVGR8l
 XpHxngwHOOxyLUqKAhlC+eY1Dl01OScGmaX6roLyFNA1c2T61m6qpbc/BsBulIAV9FYqI
 IKXKIaJI520pJLMIPGQZDfYf0OsF16JSiPIaGr/Rpv+uXAgXbH1Ji+FPMyIyV7DEBkUPH
 FgfbOibt/MHRyrOLPqSg15fZm2bdAZzo/w83Da8kjL2QC/4uR8fsQ9ENgvEdbknomcTzs
 0fFkJZ0vFs3xRm3Bvsx2YGA5roHFGEqmYxqDvAuZvJrDrwXnF+/rM+wvmo7BxnKNePw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=UzwfSeW0; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=LwzmPDXB; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=vandhiadevan.karunamoorthy@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=UzwfSeW0; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=LwzmPDXB
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E7F0860645
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 05:08:03 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68O43KaX364870
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 05:08:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=NqA6OlnyVjP05MAItB8evv
 zXWncAmy6N4NuUTkLIx10=; b=UzwfSeW0I3Yu8f0U35Jqwsp2v2a1hLHbTGT03n
 y/RsOSjd+n/WKSDBTJIVucO9HuznuAZGfj4hK3XUE8Jy+EUqJOdZ+Q98IvzzKjvW
 /3kkZnFQD02OBFCs0x7W80Q9o0r5T8otK7duhDQ0k9bDFHrbT1/zd2dqHYDX1Z7c
 N4+fQq7E/hEXgfTisceMTfSvAJFal6991+J41QqjjVAIIkIg32W7zDcsXt+u6fSz
 gtCEvituftZLSlK5uTToD2GfwHXvxHJo4HGdQJBPQDzLXihD2/3y/tHlS7HENk4B
 5TkXYifTHnT2OFLXZKlfxhRcntHt1mkPLC8hR2HOX9uvZcSg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvvgh85uc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 05:08:02 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-333543ac378so1984657eec.1
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 22:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790226482; x=1790831282;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=NqA6OlnyVjP05MAItB8evvzXWncAmy6N4NuUTkLIx10=;
 b=LwzmPDXBhD0XWAROkPjSGtRM9LFCSBZBO7JBc9/Ill2izMGu5SRdtabiRZgqkpUkId
 mAVrl/dghRuqmCNV5Q2URzRyL86BdeeW5GAnVtG26fPaUEsAE91Cv/aWXCSM6c9jL0of
 Gn4ZR+HMlJuuWreSlgk3H3oK6/urrDVv4o0hwLn/fInv6veDcvBuQI4TIWTwO59eET2M
 nl1k+p91HAipfrXIj9XXUK0dxQJnzpywHvsES6wTA1l9Qfykj//ZkV6aNGqruRYXhmr9
 wW7ENXNZGhDIE5MKRQsxL9HVKtaPLebPKf4cMP+0fzefv6nB+SV336lWRE9CAxmThiGU
 c/Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790226482; x=1790831282;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=NqA6OlnyVjP05MAItB8evvzXWncAmy6N4NuUTkLIx10=;
 b=xn2x7caRnzYYVAfXmLnGJ+gjs6GQZ9ASJoLwjFRtxVTxZwxWED3B/sqPSCw4ypxqJa
 MgZ4UNFu/RFZ4ytNAs5FXaCTibumwpR7tdn/7ZUftbLV5mItUBfTYuXo8YiN3bnmG8Bv
 R8r6tYPDsZFpO4LSoyoew+Q0wXHR5A+3yYW8zELkO2PRSlur2WGHHrzmSl21EyoVFvNc
 QUrWvDUrgTuCUv4xMELUaU6Lh8rupg+LWiePrSQrtcLqlOKxBppVFmdXxd1mUY67ggb1
 y9Oyyf0q6PhcGqRe/BGPVWE24bL1x9GPXvdiEjJ+NmM81XmY01MHksm5WCY14g1obP87
 CvpA==
X-Gm-Message-State: AFuF++ko9G0aMexkERphf2Hp0RhpKQTf20deBddyKl4y7QXynVH2siSn
 LBkY/4FTB1mx1jgZqlMM1gEEIRTXsUc6q0r8AV5HINcPf3V0r+UtNbsxfZs6K2G0YdEhU95Vbm7
 qJZtrwCin6F9qMEkmEDeV8XRLoGgnfW/5/aRokXJElkEM7XsUOCiCod3T+O1HZVK6CZnC2hF6jE
 fNAOk=
X-Gm-Gg: AYBFou18E5H7c9uYnyawW1RBYiMoNY/FQzOvYEyUWSqfnjqU95iyf98S+KkGPVp+fvJ
 pqKGjVkyuHmx1eR8RpYEJ6Z7/z8+7YUAuWluDqocuNWxLmQCGPBGdU7m3iFEudhtMTvaOPLjd8S
 q6rLGjOkIuYIy3dIqX6h6xl+UKDNi0N0sbe3b3uiGoWh5MqoR7ztFl8GWq85N960RO5XlzBM36i
 yzAuC7a6setkXp3yJzriwPapGnYX2lm2jCRDCBCEifbRgBrIhPKusi7TqA6Ejpvy2JmDpw08FKW
 eVWXvzdOG9Y3PHY9UuGkmCB+3YHpn8F5dVwi3WDG0toB6DEXBSO8hXJ5+pfF6A32Ey+LwKQbYXm
 5E54znvKGX1ApdP+vOh3ZldS+k+wCPvKFzIiscHo/L8bhq0VG7h6QppMyx5pKTuxYkJnFtgDFPb
 A6+To35xFx7YdVX3KXsOLtCbX4ukFU5HcmgMiWJW4=
X-Received: by 2002:a05:7300:7315:b0:33e:9bea:1010 with SMTP id
 5a478bee46e88-340030d845amr1338146eec.13.1790226481385; 
 Wed, 23 Sep 2026 22:08:01 -0700 (PDT)
X-Received: by 2002:a05:7300:7315:b0:33e:9bea:1010 with SMTP id
 5a478bee46e88-340030d845amr1338107eec.13.1790226480573; 
 Wed, 23 Sep 2026 22:08:00 -0700 (PDT)
Received: from hu-vkarunam-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33e95c7bf6bsm9915584eec.8.2026.09.23.22.07.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 22:08:00 -0700 (PDT)
From: Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>
Date: Thu, 24 Sep 2026 10:37:54 +0530
Subject: [PATCH v3] fastboot: block: support interface-prefixed
 device/partition selection
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-series2-fastboot-block-target-v3-1-fee713341e76@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIACmwtGoC/5WOQQ6CMBBFr0K6toYOKsWV9zAu2jKFKlBtC9EY7
 m4LWxPjZpKXvLw/b+LRGfTkmL2Jw8l4Y4cIxSYjqhVDg9TUkQnkcMg57OjqA9XCB2ltoLKz6ka
 DcA0GqjhWO8alkLUmsXF3qM1z6Z8vK/tRXlGFFE1Ga3yw7rU8MLHkrVsVK39sTYwyqhUvgEsFN
 YOT9X77GEWnbN9v4yFpcoK/ohCjUJRMc8n2Ne6/ROd5/gCfU5DCOAEAAA==
X-Change-ID: 20260824-series2-fastboot-block-target-c8e9418babdf
To: u-boot@lists.u-boot-project.org
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Dmitrii Merkurev <dimorinny@google.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Adrian Freihofer <adrian.freihofer@siemens.com>,
 Heiko Schocher <hs@nabladev.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Sam Day <me@samcday.com>,
 Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790226476; l=18956;
 i=vandhiadevan.karunamoorthy@oss.qualcomm.com; s=20260817;
 h=from:subject:message-id; bh=pHG8nfpZxWeymE7Z9ApbwxpLHiklhWsvcrjtM9MZVxE=;
 b=7SUscibTRYBmq1JgW3yxrYAjYN3CkXK19tWF7n6tzc5WvkTYmOKbcbejJs0fv+RxojbWpfbK3
 K9PbaAb2g7jArjGtv/HxxXXs0h8BDRgJScwh2ifOH3d7cX/jnCRzcZU
X-Developer-Key: i=vandhiadevan.karunamoorthy@oss.qualcomm.com; a=ed25519;
 pk=2EVV7DmKqYX4wxSlXPB5QBt44JjomLlz/wTW2AL4H6I=
X-Authority-Analysis: v=2.4 cv=KYhHIgYD c=1 sm=1 tr=0 ts=6ab4b032 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=GZGZu5LAGiUpZqVw-asA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: 9EojFflmk1ubqtKvKrw7LQbrIAoJRfd7
X-Proofpoint-ORIG-GUID: 9EojFflmk1ubqtKvKrw7LQbrIAoJRfd7
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDAyMiBTYWx0ZWRfX91ltLZ+2H39E
 CoV4w1domTAlB/fHUlW/bDvh+icjv1L5+Fbb7XNiU8fYDAFszB8LDX+TI3oksu6kNrliKa5cf2X
 X02Q6/GY4cE5tmYXNZ4unyZMRUUR3sI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDAyMiBTYWx0ZWRfX3dpyBVCrE+kB
 iwpeEc2bqOdplCeyBtI2MRTRxBNq24CkgQMApc2VV6Otbh1Kzdr+jZ0izgAUS9fkN+36eErrTa/
 eUs5Fb7JefuqalQVelDFnvoyiMCzPe6c8hM3gXHn9+/3Uf7I0Sd5EtWFdOHkDkE4KbKeVoreIKv
 BY2PG9dh5c6VpQ4XPmeCdoM/usnE9mVPb4mzN0ecd5Hq/MUZS2FW06Vh6K9xovgNrFM9WhsKSvu
 sojyH31KIkbGt084yqXKHTm+aMSUF6ZUkVhI25AAGcktMR9mdAJ6c4t4DVETRGQyYLmAQjVg2mt
 XbyTTJDEqJc2JQbNCyF9BT10jXvH48I3ATgzgfQRen356Nqdiui3PnIiD8MFn6hBY6zgEajc+tf
 N433QjrmvldZ/o15XW5fPRZGR7sh480bFtynV5+v7G7WUOnKOq5tKvajCHZGJM7x9sH9Xs6+ReL
 vESj/mGPo5P2Y/ywGWw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 clxscore=1015 spamscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240022
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

Allow selecting the block interface, in addition to the device
number, directly in the flash/erase partition argument:

  [<interface>:][<device>:]<partition>

This extends the existing device-prefix syntax ("<device>:<partition>")
with an optional leading interface segment, e.g. "mtd:0:boot" or
"scsi:4:boot". Any segment left unspecified falls back to
CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME/
CONFIG_FASTBOOT_FLASH_BLOCK_DEVICE_ID, or to the runtime override set
via fastboot_block_set_target().

Some GPT layouts use literal partition names that themselves contain
a colon (e.g. "0:SBL"), which is ambiguous with the device-prefix
syntax. Resolve this by checking both interpretations against the
resolved device: a fastboot_partition_alias_<name> environment
variable, if set, wins outright; otherwise, if both interpretations
resolve to different existing partitions, fail with "ambiguous
partition name" rather than silently choosing one.

Signed-off-by: Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>
---
This series lets a fastboot client select the block interface, in
addition to the device number, directly in the flash/erase partition
argument:

  [<interface>:][<device>:]<partition>

This extends the existing device-prefix syntax ("<device>:<partition>")
with an optional leading interface segment, e.g. "mtd:0:boot" or
"scsi:4:boot". Any segment left unspecified falls back to
CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME/
CONFIG_FASTBOOT_FLASH_BLOCK_DEVICE_ID.

This is useful on boards where one interface (e.g. scsi) is the
default block target but another (e.g. mtd) is also present.

Some GPT layouts use literal partition names that themselves contain
a colon (e.g. "0:SBL"), which is ambiguous with the device-prefix
syntax. This is resolved via a fastboot_partition_alias_<name>
environment variable, or automatically when unambiguous; genuinely
ambiguous names fail with an explicit error instead of silently
picking one.
---
Depends on: [PATCH v6 0/8] arm: snapdragon: Add snagboot support for Lemans-EVK
Link: https://lore.kernel.org/u-boot/20260803-snagboot-v6-0-e8bf7a6fc0a4@oss.qualcomm.com/
Depends on: [PATCH v2 0/4] fastboot: block: Add GPT/MBR and device selection
Link: https://lore.kernel.org/u-boot/20260427-fb_gpt-v2-0-9e7fe3c1649a@oss.qualcomm.com/
---
Changes in v3:
- Replace the 'oem set-block-target' command with inline
  [<interface>:][<device>:]<partition> syntax on the partition
  argument itself.
- Add fastboot_partition_alias_<name> lookup, mirroring fb_mmc.c.
- Add ambiguity-checked dual-candidate lookup for colon-containing
  literal partition names.
- Update doc/android/fastboot.rst for the new syntax and alias
  mechanism.
- Link to v2:
https://lore.kernel.org/u-boot/20260917-series2-fastboot-block-target-v2-1-2371f8b15de5@oss.qualcomm.com/
---
 doc/android/fastboot.rst    |  59 ++++++++---
 drivers/fastboot/fb_block.c | 249 +++++++++++++++++++++++++++++++++-----------
 include/fb_block.h          |   9 ++
 3 files changed, 245 insertions(+), 72 deletions(-)

diff --git a/doc/android/fastboot.rst b/doc/android/fastboot.rst
index a80eef98548..fa318b4007f 100644
--- a/doc/android/fastboot.rst
+++ b/doc/android/fastboot.rst
@@ -150,32 +150,67 @@ their names.
 Device Selection for Block Devices
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
-When using ``FASTBOOT_FLASH_BLOCK``, you can specify which block device to
-target by prefixing the partition name with the device number and a colon.
+When using ``FASTBOOT_FLASH_BLOCK``, you can specify which block interface and
+device to target by prefixing the partition name.
 
 Syntax::
 
-    <device_number>:<partition_name>
+    [<interface>:][<device_number>:]<partition_name>
 
 Examples::
 
-    fastboot flash 0:boot boot.img        # Flash to device 0, partition "boot"
-    fastboot flash 1:system system.img    # Flash to device 1, partition "system"
-    fastboot flash 0:gpt gpt.img          # Write GPT to device 0
-    fastboot flash 1:mbr mbr.img          # Write MBR to device 1
+    fastboot flash 0:boot boot.img        # Flash to default interface, device 0, partition "boot"
+    fastboot flash 1:system system.img    # Flash to default interface, device 1, partition "system"
+    fastboot flash 0:gpt gpt.img          # Write GPT to default interface, device 0
+    fastboot flash 1:mbr mbr.img          # Write MBR to default interface, device 1
+    fastboot flash mtd:0:boot boot.img    # Flash to interface "mtd", device 0, partition "boot"
+    fastboot flash scsi:4:boot boot.img   # Flash to interface "scsi", device 4, partition "boot"
 
-If no device number is specified, the default device from
-``CONFIG_FASTBOOT_FLASH_BLOCK_DEVICE_ID`` is used::
+If no interface is specified, ``CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME`` is
+used. If no device number is specified, ``CONFIG_FASTBOOT_FLASH_BLOCK_DEVICE_ID``
+is used::
 
-    fastboot flash boot boot.img          # Uses default device
+    fastboot flash boot boot.img          # Uses default interface and device
 
 This syntax is supported for:
 
 * Regular partition flashing
-* GPT partition table updates (``gpt`` or ``N:gpt``)
-* MBR partition table updates (``mbr`` or ``N:mbr``)
+* GPT partition table updates (``gpt``, ``N:gpt``, or ``iface:N:gpt``)
+* MBR partition table updates (``mbr``, ``N:mbr``, or ``iface:N:mbr``)
 * Partition erasing operations
 
+Partition names containing a colon
+"""""""""""""""""""""""""""""""""""
+
+Some partition layouts use literal partition names that themselves contain a
+colon, for example ``0:SBL`` or ``1:SBL``. This is ambiguous with the device
+prefix syntax above: ``flash 0:SBL`` could mean "partition SBL on device 0"
+or "partition literally named 0:SBL on the default device".
+
+U-Boot resolves this as follows:
+
+* If a partition alias is defined (see below), it always wins and no
+  ambiguity check is performed.
+* Otherwise, both interpretations are looked up on the same resolved device.
+  If only one exists, it is used. If both exist and refer to the same
+  partition, it is used. If both exist and refer to *different* partitions,
+  the command fails with ``ambiguous partition name`` instead of silently
+  picking one.
+
+To make such names unambiguous, define a partition alias::
+
+    fastboot_partition_alias_sbl0=0:SBL
+    fastboot_partition_alias_sbl1=1:SBL
+
+and reference the alias instead of the literal name::
+
+    fastboot flash mtd:0:sbl0 boot.img
+
+A partition literally named ``gpt``, ``mbr``, or a device-prefixed form of
+either (e.g. ``0:gpt``) is always treated as the reserved GPT/MBR
+partition-table target and cannot be reached directly; use an alias to flash
+a partition with such a name.
+
 Partition Name Formats
 ^^^^^^^^^^^^^^^^^^^^^^
 
diff --git a/drivers/fastboot/fb_block.c b/drivers/fastboot/fb_block.c
index a8c74e35d0d..7fd9bd8c0eb 100644
--- a/drivers/fastboot/fb_block.c
+++ b/drivers/fastboot/fb_block.c
@@ -5,6 +5,7 @@
 
 #include <blk.h>
 #include <div64.h>
+#include <env.h>
 #include <fastboot.h>
 #include <fastboot-internal.h>
 #include <fb_block.h>
@@ -126,62 +127,172 @@ static lbaint_t fb_block_sparse_reserve(struct sparse_storage *info,
 }
 
 /**
- * parse_device_partition() - Parse and validate device:partition format
- * @part_name: Input string in format "N:partition" or "partition"
+ * FASTBOOT_BLOCK_IFACE_LEN - max length of a block interface name, including NUL
+ */
+#define FASTBOOT_BLOCK_IFACE_LEN 16
+
+/**
+ * block_interface_override - runtime-set block interface name, empty if unset
+ */
+static char block_interface_override[FASTBOOT_BLOCK_IFACE_LEN];
+/**
+ * block_device_override - runtime-set block device number, -1 if unset
+ */
+static int block_device_override = -1;
+
+/**
+ * fb_block_interface() - Resolve the block interface name to use
+ *
+ * Returns the runtime override set via fastboot_block_set_target() if one
+ * is active, otherwise falls back to the build-time config default.
+ */
+static const char *fb_block_interface(void)
+{
+	if (block_interface_override[0])
+		return block_interface_override;
+
+	return config_opt_enabled(CONFIG_FASTBOOT_FLASH_BLOCK,
+				  CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME, NULL);
+}
+
+/**
+ * fb_block_device() - Resolve the block device number to use
+ *
+ * Returns the runtime override set via fastboot_block_set_target() if one
+ * is active, otherwise falls back to the build-time config default.
+ */
+static int fb_block_device(void)
+{
+	if (block_device_override >= 0)
+		return block_device_override;
+
+	return config_opt_enabled(CONFIG_FASTBOOT_FLASH_BLOCK,
+				  CONFIG_FASTBOOT_FLASH_BLOCK_DEVICE_ID, -1);
+}
+
+int fastboot_block_set_target(const char *interface, int device)
+{
+	if (interface) {
+		if (strlen(interface) >= sizeof(block_interface_override))
+			return -EINVAL;
+		strlcpy(block_interface_override, interface,
+			sizeof(block_interface_override));
+	}
+
+	if (device >= 0)
+		block_device_override = device;
+
+	return 0;
+}
+
+static bool is_all_digits(const char *s, size_t len)
+{
+	size_t i;
+
+	if (!len)
+		return false;
+
+	for (i = 0; i < len; i++)
+		if (s[i] < '0' || s[i] > '9')
+			return false;
+
+	return true;
+}
+
+/**
+ * parse_device_partition() - Parse [<interface>:][<device>:]<partition> format
+ * @part_name: Input string, e.g. "mtd:0:boot", "0:boot", or "boot"
+ * @interface_buf: Output buffer for the interface name, FASTBOOT_BLOCK_IFACE_LEN bytes
  * @device: Output device number
- * @partition_name: Output partition name pointer (can be NULL)
+ * @partition_name: Output partition name pointer, using the device-tier-stripped
+ *	interpretation
+ * @literal_partition_name: Optional output pointer to the unstripped interpretation
+ *	of the device tier (e.g. "0:SBL" instead of "SBL"), or NULL if no device-tier
+ *	stripping occurred. Pass NULL if the caller doesn't need this.
+ *
+ * Parses at most two leading ':'-delimited segments: a non-numeric segment is
+ * an interface override, a numeric segment is a device override. Whatever
+ * remains, colons and all, is left untouched as the partition name.
  *
- * Parses the input string to extract device number and partition name.
- * If no device is specified, uses the default from config.
  * Returns: 0 on success, -EINVAL if format is invalid
  */
-static int parse_device_partition(const char *part_name, int *device,
-				  const char **partition_name)
+static int parse_device_partition(const char *part_name, char *interface_buf,
+				  int *device, const char **partition_name,
+				  const char **literal_partition_name)
 {
+	const char *default_interface = fb_block_interface();
+	const char *p = part_name;
 	const char *colon_pos;
+	size_t iface_len;
 
-	*device = config_opt_enabled(CONFIG_FASTBOOT_FLASH_BLOCK,
-				     CONFIG_FASTBOOT_FLASH_BLOCK_DEVICE_ID, -1);
+	strlcpy(interface_buf, default_interface ? default_interface : "",
+		FASTBOOT_BLOCK_IFACE_LEN);
+	*device = fb_block_device();
+	if (literal_partition_name)
+		*literal_partition_name = NULL;
 
-	/* Check for colon in partition name */
-	colon_pos = strchr(part_name, ':');
+	colon_pos = strchr(p, ':');
 
 	/* Reject invalid format like ":partition" */
-	if (colon_pos && colon_pos == part_name)
+	if (colon_pos && colon_pos == p)
 		return -EINVAL;
 
-	/* Override if device:partition format detected */
-	if (colon_pos && colon_pos > part_name) {
-		*device = simple_strtoul(part_name, NULL, 10);
-		if (partition_name)
-			*partition_name = colon_pos + 1;
-	} else {
-		if (partition_name)
-			*partition_name = part_name;
+	/* Leading non-numeric segment is an interface override */
+	if (colon_pos && !is_all_digits(p, colon_pos - p)) {
+		iface_len = colon_pos - p;
+		if (iface_len >= FASTBOOT_BLOCK_IFACE_LEN)
+			return -EINVAL;
+
+		memcpy(interface_buf, p, iface_len);
+		interface_buf[iface_len] = '\0';
+
+		p = colon_pos + 1;
+		colon_pos = strchr(p, ':');
+
+		if (colon_pos && colon_pos == p)
+			return -EINVAL;
+	}
+
+	/* Leading numeric segment of what remains is a device override */
+	if (colon_pos && is_all_digits(p, colon_pos - p)) {
+		*device = simple_strtoul(p, NULL, 10);
+		if (literal_partition_name)
+			*literal_partition_name = p;
+		p = colon_pos + 1;
 	}
 
+	*partition_name = p;
+
 	return 0;
 }
 
 /**
  * is_partition_table_name() - Check if name matches partition table target
- * @part_name: Partition name to check
+ * @part_name: Partition name to check (already stripped of interface/device tiers)
  * @table_name: Config name for partition table (e.g., "gpt", "mbr")
  *
- * Returns: true if part_name matches table_name (with or without device prefix)
+ * Returns: true if part_name matches table_name
  */
 static bool is_partition_table_name(const char *part_name, const char *table_name)
 {
-	const char *colon_pos;
+	return strcmp(part_name, table_name) == 0;
+}
 
-	if (strcmp(part_name, table_name) == 0)
-		return true;
+/**
+ * fastboot_block_resolve_alias() - Look up fastboot_partition_alias_<name>
+ * @name: Candidate partition name
+ *
+ * Returns: the aliased literal partition name, or NULL if no alias is defined
+ */
+static const char *fastboot_block_resolve_alias(const char *name)
+{
+	/* strlen("fastboot_partition_alias_") + PART_NAME_LEN + 1 */
+	char env_alias_name[25 + PART_NAME_LEN + 1];
 
-	colon_pos = strchr(part_name, ':');
-	if (colon_pos && colon_pos > part_name && strcmp(colon_pos + 1, table_name) == 0)
-		return true;
+	strlcpy(env_alias_name, "fastboot_partition_alias_", sizeof(env_alias_name));
+	strlcat(env_alias_name, name, sizeof(env_alias_name));
 
-	return false;
+	return env_get(env_alias_name);
 }
 
 int fastboot_block_get_part_info(const char *part_name,
@@ -189,25 +300,24 @@ int fastboot_block_get_part_info(const char *part_name,
 				 struct disk_partition *part_info,
 				 char *response)
 {
-	int ret;
-	const char *interface = config_opt_enabled(CONFIG_FASTBOOT_FLASH_BLOCK,
-						   CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME,
-						   NULL);
-	int device;
-	const char *partition_name;
+	char interface[FASTBOOT_BLOCK_IFACE_LEN];
+	int device, ret, literal_ret;
+	const char *partition_name, *literal_partition_name, *aliased_name;
+	struct disk_partition literal_info;
 
 	if (!part_name || !strcmp(part_name, "")) {
 		fastboot_fail("partition not given", response);
 		return -ENOENT;
 	}
 
-	if (!interface || !strcmp(interface, "")) {
-		fastboot_fail("block interface isn't provided", response);
+	if (parse_device_partition(part_name, interface, &device,
+				   &partition_name, &literal_partition_name) < 0) {
+		fastboot_fail("invalid partition name format", response);
 		return -EINVAL;
 	}
 
-	if (parse_device_partition(part_name, &device, &partition_name) < 0) {
-		fastboot_fail("invalid partition name format", response);
+	if (!interface[0]) {
+		fastboot_fail("block interface isn't provided", response);
 		return -EINVAL;
 	}
 
@@ -217,7 +327,30 @@ int fastboot_block_get_part_info(const char *part_name,
 		return -ENODEV;
 	}
 
+	/* An alias is an explicit, unambiguous statement of intent */
+	aliased_name = fastboot_block_resolve_alias(partition_name);
+	if (aliased_name) {
+		partition_name = aliased_name;
+		literal_partition_name = NULL;
+	}
+
 	ret = part_get_info_by_name(*dev_desc, partition_name, part_info);
+
+	if (literal_partition_name) {
+		literal_ret = part_get_info_by_name(*dev_desc, literal_partition_name,
+						    &literal_info);
+
+		if (ret >= 0 && literal_ret >= 0 && part_info->start != literal_info.start) {
+			fastboot_fail("ambiguous partition name, define an alias", response);
+			return -EINVAL;
+		}
+
+		if (ret < 0 && literal_ret >= 0) {
+			*part_info = literal_info;
+			ret = literal_ret;
+		}
+	}
+
 	if (ret < 0)
 		fastboot_fail("failed to get partition info", response);
 
@@ -382,31 +515,27 @@ void fastboot_block_flash_write(const char *part_name, void *download_buffer,
 	struct blk_desc *dev_desc;
 	struct disk_partition part_info;
 
+#if CONFIG_IS_ENABLED(EFI_PARTITION) || CONFIG_IS_ENABLED(DOS_PARTITION)
+	char interface[FASTBOOT_BLOCK_IFACE_LEN];
+	const char *partition_name;
+	int device;
+
+	if (!parse_device_partition(part_name, interface, &device, &partition_name, NULL)) {
 #if CONFIG_IS_ENABLED(EFI_PARTITION)
-	if (is_partition_table_name(part_name, CONFIG_FASTBOOT_GPT_NAME)) {
-		int device;
-		const char *interface = config_opt_enabled(CONFIG_FASTBOOT_FLASH_BLOCK,
-							   CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME,
-							   NULL);
-
-		parse_device_partition(part_name, &device, NULL);
-		fastboot_flash_gpt_partition_table(interface, device,
-						   download_buffer, response);
-		return;
-	}
+		if (is_partition_table_name(partition_name, CONFIG_FASTBOOT_GPT_NAME)) {
+			fastboot_flash_gpt_partition_table(interface, device,
+							   download_buffer, response);
+			return;
+		}
 #endif
 
 #if CONFIG_IS_ENABLED(DOS_PARTITION)
-	if (is_partition_table_name(part_name, CONFIG_FASTBOOT_MBR_NAME)) {
-		int device;
-		const char *interface = config_opt_enabled(CONFIG_FASTBOOT_FLASH_BLOCK,
-							   CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME,
-							   NULL);
-
-		parse_device_partition(part_name, &device, NULL);
-		fastboot_flash_mbr_partition_table(interface, device,
-						   download_buffer, response);
-		return;
+		if (is_partition_table_name(partition_name, CONFIG_FASTBOOT_MBR_NAME)) {
+			fastboot_flash_mbr_partition_table(interface, device,
+							   download_buffer, response);
+			return;
+		}
+#endif
 	}
 #endif
 
diff --git a/include/fb_block.h b/include/fb_block.h
index 189c708e2f0..fd981d95316 100644
--- a/include/fb_block.h
+++ b/include/fb_block.h
@@ -102,4 +102,13 @@ void fastboot_block_write_sparse_image(struct blk_desc *dev_desc, struct disk_pa
 void fastboot_block_flash_write(const char *part_name, void *download_buffer,
 				u32 download_bytes, char *response);
 
+/**
+ * fastboot_block_set_target() - Override block interface/device at runtime
+ *
+ * @interface: New interface name (e.g. "scsi", "mtd"), or NULL to leave unchanged
+ * @device: New device number, or -1 to leave unchanged
+ * Return: 0 on success, -EINVAL if interface name too long
+ */
+int fastboot_block_set_target(const char *interface, int device);
+
 #endif // _FB_BLOCK_H_

---
base-commit: 4d3823469724bca19ba4ed3a5a38fc8e951775e2
change-id: 20260824-series2-fastboot-block-target-c8e9418babdf

Best regards,
--  
Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>

