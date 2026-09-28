Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A92BC9833F
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 12:02:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D4E9C808C7;
	Mon, 28 Sep 2026 12:02:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ksgfAJE-_3B5; Mon, 28 Sep 2026 12:02:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org E28CE8087B
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790596953;
	b=Sb51kXNITkNY4nwknDFm0wfWaEsD1Gs8YTfCep0y25KJhMFQodC+vAVOWgaNv6h7ZLw9
	 7A1g1hudmF9F8c7Yly7VX0zNMt8BIGBm8Xk1HwHGN0TrcPhrLJcu19WmDmJ2vmicHYTVM
	 BSlehX4OpQzamMqtZq058pH5+LJq2SwBrT5QYv+g3feC6MYgjKz9f7SBQ6SfNKmzAlGps
	 2d/k6HPvY8psMUzrOhwVcXEtQuVl2tKK5/yOree8Bv+aonYJZ+HW5v88vSACUs50EtRNO
	 pmX2zL+wmhXngpEBCgCAqHgu6m54xBDMn0AHz/pvxmm9IqcJ9+1WL+9vqhJaik+9R8Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790596953;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=NXWOtzroLq+u9ewPHhqtqvBNwaIZuEKpRAuu4ROLSSA=;
	b=EBj4MNaJ/er/nsIxvikhvU9LJqrn/UbqMDMaOaO9SIgsCWpjLEcovMPCHBnFa7x0SUWR
	 KjXjDlDsG8rbhu+J/5gwESiazWsWmQH1Z9GMZKLorZFSyeavDNrf6pevcAZrSilUkbiOs
	 bcupkQzuFolKl/6w63CD+npYSeD++fYHgBdWuNdvW0YOse6Yq2FzxtS17XkBoVbi4eWa0
	 QsBcCqgMMzsgRpBDzSF5wRrpRtR7djDdxkN1tLjSKZB6gJr67mF7eYJefmYYRk8m1z5za
	 /YgyuWi2v6q4kH+gQQSevHvmRz5qHwQ3M8S4LQ+e1nThvHzhD83VLMg1Zu7D1O2EhNQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790596953;
	bh=NXWOtzroLq+u9ewPHhqtqvBNwaIZuEKpRAuu4ROLSSA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tJvfbthwyHGhbaM66wMSYHUBl+QPwvKPE59CM+Sj6u/YcDlXSFMGJuh6lOhdF5QPp
	 QfidP2M0n4eeHtWOE0kl8K0rBki5FxsrQxEfaiDMBcV8MLI5RR9OhItm8uxCk3jEML
	 UhZ4jLKawV/Htj3YXLdXhwuXyEZDi1xLGFLFHL6qPi5gCqjfvWp5ZnKu2uHukuka/O
	 lLOojs3UiZ2R6+ImyD5W5dGQs+RK2rIT3GC+rWhrR5hqUF9hFaq8mwisDMI4nLpe14
	 uw0fK2NWwYyrO4yViAFaxIeryfzbzTS5E1SHirb7eL7hcW7ZMV1nXra7L2jd/X9Nxw
	 pCJsBfHIxsn1Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E28CE8087B;
	Mon, 28 Sep 2026 12:02:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 46EE02B6
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 12:02:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2CA00400DB
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 12:02:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kIfl459EpFLO for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 12:02:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 5393C40063
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790596950;
 b=QL15ZiEq8hTXMl6eh2sy4DVPYBiAgho4fpEHZ6DfMqlYTH5D7WhKyhz5wsH8ytzVsa8/
 gXGiLlgvIm0pxtfV9tOF8VkJ+LKJKYDd0aoUCRoGnDzCb8rb9W9gObSwW1KFoGULm1+dN
 mAvHBHa1pJABoxburLVGvszkyF5IAXoj9I1JL2EF2zUxohPMLl62Oj1eBzCkeS6OELPPJ
 jiotQQREwyedQKcAVHmN88AnOoal2iWXIuwfx0zvCpwx0rEaJ4MzzFrTAbRRSBD5Cj08n
 kUY8uaEmizPzevUSFjp++KaOFmgzwdn9Z5HLwZ3MtiTWldgsb0GjEJYgXH3xG8oWbwQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790596950;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Info:X-Authority-Analysis:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=NXWOtzroLq+u9ewPHhqtqvBNwaIZuEKpRAuu4ROLSSA=;
 b=gr2P+jrBUImD5pbXT3mds0eokENq7eEW18kL18+tzWqDCnPuhUHH97tWvLAEN+Ak/wWC
 +1nbmv4ZrlpgYRigOoerqqP/lrGtgGeKbl3vb9WOSC9Eio2PlqCiB5BZbvx43bYN5ewVu
 Ies6LdHHK9MBEcRQO/qfzoFqPwhkrhmrWrG/pO+6XsIRGEvKt74PZ44ja986u4VnGLPbs
 RXn2NuHxIQON/qNooRMl/CKx8y34dOUFqf3iHBWB2UFLR9ur7wajIBFpkm+Y18r2Peahy
 zjiJx1z+6b6RoLjwqc+qam0skKjbeTo6OKVxzgseRbGIsDeGdMwVS/LuIXBulTY8fdA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=lxiEDrfw; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b="dsH+/ICT"; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=lxiEDrfw; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=dsH+/ICT
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5393C40063
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 12:02:29 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68SBAJCA558162
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 12:02:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=NXWOtzroLq+
 u9ewPHhqtqvBNwaIZuEKpRAuu4ROLSSA=; b=lxiEDrfwdY+mvM7hBpnZlbNaZE6
 Q6cwIp0Mr+3FtmHN8Ws2LsFYD/ZTt70s1fUKSkK6JmJx1SJ3XxMicQ4b9HIICXJA
 CXPfGeTa+r4mCH8xawmCnMvajY76vAc7jkhsQIGfDJYXXnrVniT2ysbUU17LhPXX
 u204LNgtpK/v+OqBpQdWAx4aYxRpvijhmi8r/KE0ActkvbLopnMP38nOIQJfkr/i
 hhXhzLCYASMlMOqxttFLaDs33hPaIIt7ejkiva2UFNIl23nFpdOSqA8kYuTVstxK
 XgkHi5LSux9mBAvpgfjV9/IrD6vOoIHyJ4juR937BtAXnbOd2VeFIZLYWwQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyebq20m1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 12:02:28 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-341eff9e381so1209868eec.1
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 05:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790596948; x=1791201748;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NXWOtzroLq+u9ewPHhqtqvBNwaIZuEKpRAuu4ROLSSA=;
 b=dsH+/ICT2pa7GvsO037F+zqWYJJHPwk8qVy5qzO/7w683LgrD2btbDiKVpeMIlQD3r
 WJZKOaINdfIx5HR8Uk4vhN3soSAsOf0xjjMbqKYD3eg5fAosPM/QjxpQ6zNspuFyVmCP
 VxOF5oCnJ3Q2g2M430avVW39umRyREBIoXaXF1DQJVowfD7Z6w7GziUsRRJ1613KP/Vy
 BF2cSIDGG6p9JoL+3Syq24fVc76WdK6/6tOu+4jfRds6zgaw8TAkLcwhPVLYM0rTfaLt
 /fJEQVhJpTklOQG4NGQQYRfyGeWUkzD70ZuXYLRAQD3yMBMoiN9bW/qw8bpHthoWmP9C
 B1Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790596948; x=1791201748;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=NXWOtzroLq+u9ewPHhqtqvBNwaIZuEKpRAuu4ROLSSA=;
 b=uy8hV0bUiAGraN92DbGnZMcv0CWgw0m4ngZII4mTco+Wy2rSexcnOuh99NXP8Q1Enh
 pM5Uc8HFEovQQZvaDznaDdYm7WFgT2MXWKuXfjnOezk/v+/GunuVcLjUWlg7bKxMq/rp
 BdC6K4t4ZBnDMZCTp7CYSIWW/WCdUqp2FMK6zbS9kXHh57aZhwkETXjFU2Aty/jEjKF4
 QbmTYrmb02FaUL1E1U2ebgMbRrmikH67GUPbMaqPL36ZpPhOJ9lRIH8mWhoo044zHn2B
 ogRSLzA80HKM9N6828ctW9w/G+sAbX0S6fIyH0WBIE6FrqaTXhwXLdUUDvAnwJYhxq32
 OFAA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxt/jR8XkonPLx/0TZBlFUue63QoLCyNqIpxsAjHYRcrHj02O0h+FjBV5+ejqEyuiy9R1uCAyM=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKg+2f/KRWAHByaeEBLSjcuCkNNd8kiQq4AfjiHvglGXyXONBDN
 mBNWyV3pZ94TxUMQBwPpmNjPvOD49MUeJmPlyOe4zQ7MtB22fFaRrFzAFKmEkmzsjAyalhyT13u
 wH2P5KvzBVJiZqppQ/pcTRCzfQ2aaEMTIfnIFpYF8YSeYMgkkgyVARfOkZHPkrwKBlgtRQzU=
X-Gm-Gg: AYBFou3vKoZl6PeZ0OTVXQOKHjn9Oq0b4RG6UWDyLDwgUmug9XpB020LqGdwvyGXQ9P
 ANHy7G4JL/d9UQ640XG8IN3LbwQZ/Zv9CnM7rtLpXj4+2IiTf9tdjpEIIyPNbO76tmuDKRaxhep
 19WrjOJdeo8icfzE3SQ+YlVWMk3BKtUm0+ligCjIw4AmEsAtofzX97h93ycn2LSChBQk+mcmByq
 PlRdSLEDKZgbsUkdK5ncQDXKuMHqY/GLGWwDYw8kk9QZXmhMV7tcqZVldsL0k5TVHWvlIPmwURN
 jcyJpbDeSZvz63wRTvDFJ5nMDHhVvdTsZRXsM5HitCW/+UBTLUbVuvzsUdjHbOQPv0+ioLNjlXr
 nmSMTTviESe4tzznPe9i4Gpt3KEWKeO1EQfI6LazcnKP2CQOZhLx2Pwb4wW2SGIZFbSS7VwKS0a
 bnsSpw6sS4Wh0rCpt3ww==
X-Received: by 2002:a05:7300:7a04:b0:341:8ee2:6f76 with SMTP id
 5a478bee46e88-34272855f9bmr9709324eec.33.1790596948248; 
 Mon, 28 Sep 2026 05:02:28 -0700 (PDT)
X-Received: by 2002:a05:7300:7a04:b0:341:8ee2:6f76 with SMTP id
 5a478bee46e88-34272855f9bmr9709223eec.33.1790596946498; 
 Mon, 28 Sep 2026 05:02:26 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34144b4ae50sm28658382eec.17.2026.09.28.05.02.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 05:02:24 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com, lukma@denx.de,
 aswin.murugan@oss.qualcomm.com, nathbappai@gmail.com,
 Michael.Srba@seznam.cz, luca.weiss@fairphone.com,
 nikroks@mainlining.org, jbx6244@gmail.com,
 krzysztof.kozlowski@oss.qualcomm.com,
 bartosz.golaszewski@oss.qualcomm.com, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Bjorn Andersson <andersson@kernel.org>
Subject: [PATCH v2 1/9] dt-bindings: clock: qcom: add the definition for the
 USB2 PHY reset
Date: Mon, 28 Sep 2026 17:32:01 +0530
Message-Id: <20260928120209.1064781-2-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260928120209.1064781-1-aswin.murugan@oss.qualcomm.com>
References: <20260928120209.1064781-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: oGDCdgNEqX1KZZEsDm-JWclD5TuN1t49
X-Proofpoint-GUID: oGDCdgNEqX1KZZEsDm-JWclD5TuN1t49
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA0NyBTYWx0ZWRfX4F0a/3zvKMQZ
 u9qxlaU33Chb0zpw54jjxdP0WKcQrMpPS6UEy9Z2W5r4yMLbrxYHbc86Zl7yLVpGT6qjv4dTxav
 HOScrEOP7CEbYBuqoBnOfCi5EIR42gM=
X-Authority-Analysis: v=2.4 cv=EqRHPicA c=1 sm=1 tr=0 ts=6aba5754 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=uMgPeQDBqzXvyt0z7VQA:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA0NyBTYWx0ZWRfXyKn3g9ML4w9p
 QX6coRzPHkG8mbNSnUnULFs52GqWqKLmgq9IxtDRArH/rbf71X414Eb4IIL3SdhvqqadKuSykiG
 kevXc03ZRQN45pLXpekRUdBRlDUXnHYS9Q2ClVNcPw3sOd8Le2beq3rsVPM8ClSNJKMH8KGq7WP
 V1VAmnzvh6hLu/4Rz47G2H7I4VY198v/TiJBoa0eJtS5jGHALABKr+J/PciZ1OPDbPq9aGwzYR1
 NYVJlw4NsRhN4IsALgImxNw1JRWRUHEzB3pK0tclmBwCuTc3vgriewCpNIh6nA2zNGV9QeiQqIA
 MCBvmBUYAPx2aTISgI6J1222orCEN76iKmzzHyHxPLIrklUxB5138KmEaMECmZXa/lgzj0PJnvR
 yf7f0AJdCwRoUdT/Q5abue/qALXmAg+bmzwk9qWvYB6xS3s6uzZyOQJMw66WRxzgO1JvE2E3eR2
 m/Vjd1ysFwdu2iEaG4Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 phishscore=0 clxscore=1015 spamscore=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609280047
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

From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

Provide the USB2 PHY reset definition in dt-bindings for the Nord negcc
module in order to enable adding the USB nodes in DTS.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Link: https://lore.kernel.org/r/20260518-nord-clk-usb2-phy-v2-1-17a86cb307c3@oss.qualcomm.com
Signed-off-by: Bjorn Andersson <andersson@kernel.org>

[ upstream commit: d62b0e3104cfd2171281867196cb1365098a25e0 ]

(cherry picked from commit 23d26cb16fe3cc5a65f731ae2ef255e8b4d47d24)
---
 dts/upstream/include/dt-bindings/clock/qcom,nord-negcc.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/dts/upstream/include/dt-bindings/clock/qcom,nord-negcc.h b/dts/upstream/include/dt-bindings/clock/qcom,nord-negcc.h
index 95f333d8e1a..a7024317e90 100644
--- a/dts/upstream/include/dt-bindings/clock/qcom,nord-negcc.h
+++ b/dts/upstream/include/dt-bindings/clock/qcom,nord-negcc.h
@@ -120,5 +120,6 @@
 #define NE_GCC_USB3_PHY_SEC_BCR					10
 #define NE_GCC_USB3PHY_PHY_PRIM_BCR				11
 #define NE_GCC_USB3PHY_PHY_SEC_BCR				12
+#define NE_GCC_QUSB2PHY_PRIM_BCR				13
 
 #endif
-- 
2.34.1

