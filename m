Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE76DCA5FE2
	for <u-boot@archiver.kernel.org>; Mon,  5 Oct 2026 07:07:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A09A840693;
	Mon,  5 Oct 2026 07:07:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Auw35uXPWyiZ; Mon,  5 Oct 2026 07:07:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 2199840684
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791184048;
	b=m23xNCrvtL3MDrdIkzCamOl5H9yLX+VdbXtOTq8ocaHBJdTLvGNTgr2iZ6zct05rgidW
	 PMAqpbzGdp2+GGbj23UrXoOHdWkXNlzT5urCYMYcFSBkd+/96JllHUWmGjQyvhUw/4D9z
	 sQbfRPaeYtr8y17/S8jpI7mj2X/8vpxFhksZTVdPwlivBv/RKfkUv958hhb0xDGwxCgJA
	 EAj4HMKkmVPUJmncENOG29MM64vXNLjgwt/K57rGPtZFeI+ptFlYCAJcV7m/i/D47nnil
	 13JpzQNyNLZSNGiLU1izioEVzAovShKiuGt8WrIT6pMle9IjW+b3OVJEtmZqNQTlADg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791184048;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=wyJ1pfgdCUgZZtvSU0nqq6gTdOgAycnqqivr1oRZNDU=;
	b=qntP+RfNAMo26NfDqg4TRkGDZQ+WgGJiR4Pw/HQ6EuFvPh+FO5L7nEuJ9QIpVQ56iej1
	 y7bLc29fkvG7tgVSprGd2NntaidhuEXNwPMAUOptxYr/YC5/68He5vXqr/k7A0CAnCCgM
	 4gFo4NT50Cd4xsApfqE4/zP/zgwbfoRe1B6AP0cbaepe3ej2GhWr8Z7WXKteJwxsLnlbJ
	 V0L7LC+7KFwHjLuKbHRzjIVEGDP9ZWCMahkeymgn7bo/sU3INSBkFxungFoVSyfefAv+V
	 Wi9/CDEXHZv2NeXm0OazWkUl/VxZMJVzcP6kOHAM1RZQQGUHEi1oiMS32Ul1PanB7iw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791184048;
	bh=wyJ1pfgdCUgZZtvSU0nqq6gTdOgAycnqqivr1oRZNDU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=A+h1qmCsnkROm8FGIRDmhgOg5qZomhmLeXC6gQE7W4iFZiYpv3bU7VICE434sllcp
	 /kvuVTQfrnUnod8G0Ta5NvKpVuyq0e6G3j+ux7/FED9gsJsLC655AKxw7LMFs5m1AG
	 bqhYx6+ccmmvc/Df/OuvslBg6siAl73/vvWJUhEECAezB1FTodK+B1z4l+3kKl/pg2
	 STN2F7uJqpp6iC69ZboLDIjyUUqc/WHR81n4N7pM5IjmRmg+v6DA0iCpqcfUQck88V
	 W4CYzBqyW3uT7hxapQyVSLoPL39DTJFoJyrHRwFGkbPzaW6T2zV8YXbiIdxqBwwrQ7
	 4p/0700/0PsEA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2199840684;
	Mon,  5 Oct 2026 07:07:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 126CD34E
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 07:04:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0494880AAD
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 07:04:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FI9qnBVa_izC for <u-boot@lists.u-boot-project.org>;
 Mon,  5 Oct 2026 07:04:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org D4C7E80A80
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791183894;
 b=JUZJkpI7AN5ZCRZa+5tZquvZDtbDWbQBk6b3Svx1a0GdcaBL+KwuRcOJFAO9XY5j8+8o
 OVXuh4vrvofzc3zj+r50HlQ14JyuoZN9V5Y41/Ggw2jGixmqAqyQ2WV2HYW6fbIvvoXNh
 uoBmN33oapoiSoUJYjUudf/e/2kWJZIkAlpwIsuYh2bgUVx+lYd/HMRyjMwM8wmOjwtgV
 O1+5wJoDJFgpAL+oQjdkEzjouoiASw2pT6H4xL5kBv9Jvp6/MWmbcEaV0sekHQPNkZXRD
 kcqdbtY0fCQ5hNa4sXjvge3Bz92PwOkEWJLSZLy8/xn4SoSyTj26lc8QU3IMLdC+O6A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791183894;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=wyJ1pfgdCUgZZtvSU0nqq6gTdOgAycnqqivr1oRZNDU=;
 b=RgJglOYFhXMCgumrGCyg/xdcJIGW3KroQDxdwLN/hKt2J2SqllTh8WwD6bAt5sFQ4dqS
 WfB55LS61rq/T657oj6xlAGIifcq7y9qqvJK+/xyNUS/KhUjGC2VsaT92YR5y7Qadc0r5
 ORRl/3FeIBfE54HdUXZlLrEBiQBtbKu8KvjpduPWrjHX9wo/upwmQ0xK2FGBvC7ojtSep
 YKagYfeNrGdab7Oo/H9wI9cfqWWCqJvzfvfTJSm2em39Ahf21NPrKLnH1+Ox8tnd7/rHW
 /YLNZYPKrNeoCDIz3kAoD5qklIZgCBQIT0yxYZpnkajrasihuiObbETgfkVeVQ+AY4g==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=i4v7tosA; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Jzo4AZE9; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=varadarajan.narayanan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=i4v7tosA; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Jzo4AZE9
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D4C7E80A80
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 07:04:53 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6950xvwc470376
 for <u-boot@lists.u-boot-project.org>; Mon, 5 Oct 2026 07:04:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 wyJ1pfgdCUgZZtvSU0nqq6gTdOgAycnqqivr1oRZNDU=; b=i4v7tosA3GW0ycb4
 gnobFG5nK6CigjmDtZds1DN+jM1pZTQ4CnD5xAJ+6yLq+Vy/XApthJPTMhbDFiGV
 PhFZan1OTugin5OK56+vZElv/9uiN0bH+r7Hg8eDP/rgesevFjlCY90kV6AdAVHZ
 +/WDyJqzhetYZ0B0c9iriG74Ibu/PAy/uV8K0NA6nbjzBXFe1mp0vAKgprMg8sHd
 JlH1E30cF42hbiFEaQqqAY7A+FArvE+Tl85UawijA2KgsIQUguwraIMilWQjdnq9
 Bcr1d5Q533ENHyPdoq2IspI1GP1D3yhMOcSGlag1x6EIDMYaWSoRq+tPvVNOWZ14
 IRRUyg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h2ssucu6f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 05 Oct 2026 07:04:52 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-33baaba6371so3749453eec.1
 for <u-boot@lists.u-boot-project.org>; Mon, 05 Oct 2026 00:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791183891; x=1791788691;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wyJ1pfgdCUgZZtvSU0nqq6gTdOgAycnqqivr1oRZNDU=;
 b=Jzo4AZE9U5P5sEZOYNsSIcR5lbC17m/kgoRfqsgTQd62WgBoeb0o2+YsCdHA6JDayS
 53h8yd+4yp/ITkFD4M4tFZPpivEHhONEQgEZxqLkiuFZhJgZOCIbcfc1+Mkjig+0bQl4
 CZzjAyKzS5sMVlYsoUh4FR1p6TYIRgXWZkdBMAl0n31Kfkvx9KPMCGVvRyY6z2FRL/LM
 W07jrlP2BYVbJUfJf2wkj/3jlJH/7V1R277yjF8ETkJ4s/iV9l7WGCBe2Jjo1iew9+i+
 kqAFJDiM/DdBZlF3ulPDRvIxYBs4zCB1qpSpqT33Yk6JKTwzWfk/fm+5QKe3RIbuovcD
 P/xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791183891; x=1791788691;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wyJ1pfgdCUgZZtvSU0nqq6gTdOgAycnqqivr1oRZNDU=;
 b=1gujA81MTUIz1y9WS3qrQM+f4La/4jTswOjmMejFd94MUv5kv4O3O4QqWzcT5AFFbC
 TSW0P3z2OTFG70VLdnZk8rqoazYR0jvhjsCKTR2lDKv9dltZk7Lkaq4/HT3Ige/49zRq
 Ii+OPwT082i3bGJ5LIPVB58JmcL3Rvg+gGbatrlEX1CEUeb72+pecsFqdQ6E5d6QN51Y
 x1LM0bePwlHmJGKWjB3VXx7qeldB1onYummc5Xbr4jpALEl1+cFWE6q1IJY9p378alY5
 4qbkQDNz/K4CbgTNGi0FkeTqETDVCWUIt0A/5O6Ik8UpFw2PJgwvUoylHXS85eWM07UH
 O/FA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwSAJpCOlUOuS2X5mmyTdoHARARYMjA1k1gtWVpFbyyf9ZNyo+cNeibb84riv6wmEtD81Qp5DU=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++k1iNe3Segm7Ed13Pq7cmFDqnhhIDDXB8B1no3NOOoO7Y/Pv6DT
 i7GYkMtlEbQdqB1Wyn7rUwROJfgYAClVEg6cewGuczyhZdmiW2kppSgu7WnnGdpGQmFjLWbpfer
 0PQFZ/uUPFf5MPMj4RDOsOggiYCal7Ws6UAU+FhCneL2yRld/+xMFjh5R4A/zHm8iaxnKc48=
X-Gm-Gg: AYBFou04DgOQAoYSYq542+GF9ehU7Ysqob78/BpL0YGB/LtYYfE6abO8zXB2yJTICkI
 Lc+t2mXTAfRnOTf3Wks+JhbfZoghL5RSiJB2bZEiBrFVlK4t+uDh95ZJJykPp5hcCLt2S1dtWyQ
 fP4rKHKikVG8OHus7eMMy/Lla6OfSxjNkFFcyFfIXETSycSOwDU1z1XgX87vzD00AY+ehbMmTHG
 VIL+zlFfrAU1UODeztldfpDW5tyYwOVdzvQ9ZxCofZii4exV5s2E4/TFvSpD6FfXRqjc9E4QeDX
 sUhCQHNEtogvJ7nm5aWYzysl3FnG4DvHgBVAN6deOAbf9X5KVcQjxLF7D9oaPYWgFbdgZEN2C1a
 X2ELtK7QKLQaLgjIhg8weDa+HiC2IAET4mLjSLR+nfToGT7++SG8zxWFIZCLnpflUzbDdN4VA6y
 QmxlBbztXAsBNI+FQVNoqF73Wt6jG2
X-Received: by 2002:a05:7301:922:b0:342:547:cc49 with SMTP id
 5a478bee46e88-34f2185ab04mr12123102eec.25.1791183891048; 
 Mon, 05 Oct 2026 00:04:51 -0700 (PDT)
X-Received: by 2002:a05:7301:922:b0:342:547:cc49 with SMTP id
 5a478bee46e88-34f2185ab04mr12123070eec.25.1791183890293; 
 Mon, 05 Oct 2026 00:04:50 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-35127160107sm9797561eec.11.2026.10.05.00.04.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 00:04:49 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Date: Mon, 05 Oct 2026 12:32:31 +0530
Subject: [PATCH RESEND v10 15/15] doc: board/qualcomm: Update RDP build
 instructions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-spl-v10-15-c4ca29bf27ed@oss.qualcomm.com>
References: <20261005-spl-v10-0-c4ca29bf27ed@oss.qualcomm.com>
In-Reply-To: <20261005-spl-v10-0-c4ca29bf27ed@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.u-boot-project.org,
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Anshul Dalal <anshuld@ti.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Andrew Davis <afd@ti.com>, Michael Srba <Michael.Srba@seznam.cz>,
 Alice Guo <alice.guo@nxp.com>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Lukasz Majewski <lukma@denx.de>, Luca Weiss <luca.weiss@fairphone.com>,
 Danila Tikhonov <danila@jiaxyga.com>,
 Biswapriyo Nath <nathbappai@gmail.com>,
 Vitalii Skorkin <nikroks@mainlining.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 David Wronek <david.wronek@mainlining.org>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jens Reidel <adrian@mainlining.org>, Erikas Bitovtas <xerikasxx@gmail.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDAyNyBTYWx0ZWRfX82DQD4vY271U
 Y3e9ehGevPhmLljm6yb6S4Gio1QiaSUZB3W8Awrukj99/ugAvQc/zczJezvd5TuNVqKMFvZgr0/
 +3fY9K2+4lQ2pwB4LIntJiw9WCqLiJk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDAyNyBTYWx0ZWRfXw1P8tKkdVetp
 pxlAlLAShD8vGYw8bx0rwysf0ObrjxqQghpoGrPGpOdLK42TRkPjKoxR0jOF/kvwLOlh07U5p35
 lDaOoHd0vuCXRSz60S0KfXEtQe+/QXe0XlohHrPN2Eqc+utekPw2T/gHoK6Pj8GlGR+F8xEja37
 TjvwiX2AwDmdl1F8Z7v+dykegCkdDz0ZIid2jHc1jSxHeGutOJDAKEPtjzIwvmngtAmH2+qYevS
 TZCSUi6U2I2nZNQysb7Byj/loXFbfaVCInkVjyLvlqYnO7Wj2vqbzjxjdcDzq1wWUyC2qXbp5Ed
 TjZakQicTvYnaVNklBtPf0DoC9RIb4dBHUudqqeFzDzKRdbJTCxbPpttnPiZbefj3eYScrSoo2c
 tLSWx298BhSYIAX4Mo2xSlqu7jJIcDMs5XNJE+vKn8cbEOzP/ShwFG0ohT6QzTBHP4plokRF9Ii
 CLZ6xVfmONpHMSq4e6Q==
X-Proofpoint-GUID: Mlqe1Q_EKwoQTXigjE58gHRt2zKqH_Pc
X-Proofpoint-ORIG-GUID: Mlqe1Q_EKwoQTXigjE58gHRt2zKqH_Pc
X-Authority-Analysis: v=2.4 cv=FryQbGrq c=1 sm=1 tr=0 ts=6ac34c14 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=1FHRc4FDAAAA:20 a=qC_FGOx9AAAA:8 a=NEAV23lmAAAA:8
 a=cm27Pg_UAAAA:8 a=FmD-qdgRN1vrldnJjaMA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22 a=fsdK_YakeE02zTmptMdW:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_01,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 malwarescore=0 impostorscore=0 suspectscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050027
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

Add details about the SPL & U-Boot proper build steps, converting to
flashable images, source URLs for the needed binaries and scripts.

Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
 doc/board/qualcomm/rdp.rst | 96 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 92 insertions(+), 4 deletions(-)

diff --git a/doc/board/qualcomm/rdp.rst b/doc/board/qualcomm/rdp.rst
index 4e63fe624b8..27101cc2d0d 100644
--- a/doc/board/qualcomm/rdp.rst
+++ b/doc/board/qualcomm/rdp.rst
@@ -25,13 +25,17 @@ about image signing can be found in :doc:`signing`.
 The firmware expects the ELF images to be in MBN format. The `elftombn.py` tool
 can be used to convert the ELF images to MBN format.
 
-	IPQ9574: (MBN version 6)
+IPQ9574: (MBN version 6)
 
-		$ python elftombn.py -f u-boot.elf -o u-boot.mbn -v6
+.. code-block:: bash
 
-	IPQ5424: (MBN version 7)
+    python elftombn.py -f u-boot.elf -o u-boot.mbn -v6
 
-		$ python elftombn.py -f u-boot.elf -o u-boot.mbn -v7
+IPQ5424: (MBN version 7)
+
+.. code-block:: bash
+
+    python elftombn.py -f u-boot.elf -o u-boot.mbn -v7
 
 Then install the resulting ``u-boot.mbn`` to the ``0:APPSBL`` partition
 on your device with::
@@ -43,6 +47,81 @@ on your device with::
 
 U-Boot should be running after a reboot (``reset``).
 
+Build steps for IPQ5210 based Qualcomm Dragonwing F8 & N8 Platforms:
+--------------------------------------------------------------------
+
+Please refer to the following URLs for more details about the platforms.
+
+	F8: https://www.qualcomm.com/networking-infrastructure/products/f-series/f8-platform
+
+	N8: https://www.qualcomm.com/networking-infrastructure/products/n-series/n8-platform
+
+1. Since U-Boot SPL is enabled on these platforms, the build command generates
+   both the U-Boot SPL and U-Boot proper images. Assuming ${uboot_dir} is the
+   top of the U-Boot sources and ${out_dir} as the output directory,
+
+.. code-block:: bash
+
+    cd ${uboot_dir}
+    export CROSS_COMPILE=<aarch64 toolchain prefix>
+    make -j8 O=${out_dir} qcom_ipq5210_mmc_defconfig
+    make -j8 O=${out_dir}
+
+U-Boot SPL image:	${out_dir}/spl/u-boot-spl.wrap-elf
+U-Boot image:	${out_dir}/u-boot.elf
+
+2. Convert the SPL image to multi ELF
+
+.. code-block:: bash
+
+    cd ${out_dir}/spl
+    python elftombn.py -f u-boot-spl.wrap-elf -o u-boot-spl.mbn -v7
+    python `create_multielf.py` -f u-boot-spl.mbn,tmel-ipq52xx-patch.elf \
+					-o u-boot-spl.melf
+
+This u-boot-spl.melf should be flashed into 0:SPL partition.
+Please see below for the location of `tmel-ipq52xx-patch.elf`
+
+3. Convert the U-Boot image to bootloader image
+
+.. code-block:: bash
+
+    cd ${out_dir}
+    python elftombn.py -f u-boot.elf -o u-boot.mbn -v7
+
+The u-boot.mbn has to be combined with `qc_config.elf`, `QCLib.elf`, `TFA`
+and `OPTEE`. Please see below for the location for these ELFs. TFA and OPTEE
+can be built from the sources using the following commands
+
+TFA:
+
+.. code-block:: bash
+
+    make PLAT=ipq52xx QTISECLIB_PATH=path/to/`libqtisec_dbg.a` SPD=opteed
+
+OPTEE:
+
+.. code-block:: bash
+
+    make PLATFORM=qcom-ipq52xx -j16
+
+These binaries can be combined into a flashable image using `gen_its.py`.
+
+.. code-block:: bash
+
+	python gen_its.py --arch ipq5210		\
+		--qclib_path `QCLib.elf`		\
+		--qcconfig_path `qc_config.elf`		\
+		--tfa_bl31_path bl31.mbn		\
+		--uboot_path u-boot.mbn			\
+		--optee_path tee-raw.mbn		\
+		-p qcconfig qclib			\
+		-P tfa_bl31 uboot optee			\
+		-o output/hm_503_test_uboot.img		\
+		--template `template.its`
+
+This should be flashed into 0:BOOTLDR partition.
+
 .. WARNING
 	Boards with newer software versions would automatically go the emergency
 	download (EDL) mode if U-Boot is not functioning as expected. If its a
@@ -55,5 +134,14 @@ U-Boot should be running after a reboot (``reset``).
 	Note that the support added is very basic. Restoring the original U-Boot
 	on boards with older version of the software requires a debugger.
 
+.. _create_multielf.py: https://raw.githubusercontent.com/coreboot/coreboot/refs/heads/main/util/qualcomm/create_multielf.py
 .. _elftombn.py: https://git.codelinaro.org/clo/qsdk/oss/system/tools/meta/-/tree/NHSS.QSDK.13.0.5.r2/scripts?ref_type=heads
 .. _edl: https://github.com/bkerler/edl
+.. _gen_its.py: https://git.codelinaro.org/clo/qsdk/oss/system/tools/meta/-/tree/win.platform_tools.1.0.r34/scripts?ref_type=heads
+.. _libqtisec_dbg.a: https://softwarecenter.qualcomm.com/nexus/generic/product/chip/software-product/IPQ5210.NLQ.14.0/ipq5210.nlq.14.0-qca-oem-qartifact/r00036.1/WIN.TFA.1.0.R4/apss_proc/out/proprietary/qtiseclib/output/ipq52xx/release/libqtisec_dbg.a
+.. _OPTEE: https://git.codelinaro.org/clo/trusted-firmware/optee_os/optee_os/-/tree/win.optee.1.0?ref_type=heads
+.. _qc_config.elf: https://softwarecenter.qualcomm.com/nexus/generic/product/chip/software-product/IPQ5210.NLQ.14.0/ipq5210.nlq.14.0-qca-oem-qartifact/r00036.1/BOOT.MXF.2.3.1.1/boot_images/boot/QcomPkg/SocPkg/Hermosa/Bin/LC/RELEASE/qc_config.elf
+.. _QCLib.elf: https://softwarecenter.qualcomm.com/nexus/generic/product/chip/software-product/IPQ5210.NLQ.14.0/ipq5210.nlq.14.0-qca-oem-qartifact/r00036.1/BOOT.MXF.2.3.1.1/boot_images/boot/QcomPkg/SocPkg/Hermosa/Bin/LC/RELEASE/QCLib.elf
+.. _template.its: https://git.codelinaro.org/clo/qsdk/oss/system/tools/meta/-/tree/win.platform_tools.1.0.r34/scripts?ref_type=heads
+.. _TFA: https://git.codelinaro.org/clo/trusted-firmware/tf-a/trusted-firmware-a/-/tree/win.tfa.1.0.r4?ref_type=heads
+.. _tmel-ipq52xx-patch.elf: https://softwarecenter.qualcomm.com/nexus/generic/product/chip/software-product/IPQ5210.NLQ.14.0/ipq5210.nlq.14.0-qca-oem-qartifact/r00036.1/TMEL.WNS.2.4/tmel-ipq52xx-patch.elf

-- 
2.34.1

