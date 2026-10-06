Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF59CCA5FFE
	for <u-boot@archiver.kernel.org>; Tue,  6 Oct 2026 05:51:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C771B4052C;
	Tue,  6 Oct 2026 05:51:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WDU9-cQ1fnM9; Tue,  6 Oct 2026 05:51:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 0645A40528
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791265889;
	b=r6EWtxuAsDUMVD9ou2B6Cf4IxUrBBRanL5JJmWifFV2G6iCoeEDlY9zQgelBW3RPlIvz
	 qg0To1DEFO5toAXcpXtxE/Q4ha4wxxDTiD/y+QZhr8OHsKfXvEA4dEubsm9Q5FTudA01E
	 SoVY5pLQMiAAvbL5GRZdxI43NTkRf4RBQ05cUuYRg0vgFgihVgtHRxM16LuWdxxCGnj1I
	 fQ6JwbcKl/yo1wmoc0J8S4qKuNFd+QHX649dUs5y5Ti0fdZtXOIGXwGBHQu8DjYw8Guju
	 aDWfiC5LpHY4UV2F9JVhnbxhYSKAa/QbRbdltLW2y2ULf7goaOJK1BoRy9X2ZHHD8Ag==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791265889;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=xsWIzJu63PGmz37dkouV8dnZxkIzclbZVjNPs8L84NQ=;
	b=Bp9loQRAmi7VqSCW73DtZcTgNjXNs0SHMJcU0pNBrDqteHWj75hRRnmg19155xRp1QYW
	 NU1ayFf39w6/R1Lic6AdPIGwtrJIl9Puwsl8+HsZgbRvl6ICEgKlexih4VENqIX8xmThk
	 YBWVAy3Gfjvc3XFKmfvsERB0vjf8GWo0eQ7NRL/zLS+F9eJUETz8L+6KWnzCb+Fo7t+pv
	 4mfDieddT4Mb8nCfgO0ViLQ0FIgfNJiB80HGUVDQ+sqODyftN3IukbzG5iQbvB0zYG9Op
	 sX+1bkuDy0VaI8lQygJQDJ+XkFFlrVmuIpk5w6qShh3hDiuwAsTwCG9dwuSuATkLvrQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791265889;
	bh=xsWIzJu63PGmz37dkouV8dnZxkIzclbZVjNPs8L84NQ=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Rs6nRaIbCRasdKmOsBeLrJ+AxM4Vhwq/cKbVi6uOiSlTlegHaJ/YhfyzQOVT2CJFA
	 Obe5zAL/UEjDrvgSnUdVsP3cjjKsUmk4Y7+/TZXXloodL0uCNCkws9OBxCUfUpBV8d
	 RdZbge3tEP5BFF1AiN+FEkpXMZEgy5G6ETXrj7dIcpD39kulAT6OuPOkIbOz7nSrtp
	 wFKbokCtLMMbSDYD5PxoI8FwyrF+4pzIL7Z4WM9RkGQ8tZPmzcKCzRB1qbKCPZI8UZ
	 Wml37lQnIoH0rBpPy5dNNBmhm0g0L2jhF7q5Gm0d8JwkfG1aWqxRj1WYhWUPplYsjW
	 GGEJs7+GUBR0Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0645A40528;
	Tue,  6 Oct 2026 05:51:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 5387E1D2
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 05:06:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 37B33809C0
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 05:06:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Nq8QLwd_Aq14 for <u-boot@lists.u-boot-project.org>;
 Tue,  6 Oct 2026 05:06:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 3FD16809BE
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791263187;
 b=Kc4GR6LSo/PF6dRbvucXe7m1zkGaggFZdcD3Ma/N+XK1SfrQjKaI2V2V0w6hcJRbQgEO
 hb8iymZJnEuQc+6CkZb2FJPYG0JXzKsGrp5T7bTQM7aULCiONEXaJdvFF0CM9pDKkfgWB
 UczS6ORnAx05lyTBF0xMEyFlGGzuRlKxU6NcYUxC56VarCKNpdchfUwM60x5LUaQWn8Sj
 SgtwEgDmDxhKlUdEvtzkQR876ZoB8CnRaYxBmLATqexv0tPILZ65daMXjJDtAmficsS2E
 Jrbs71DQIlHfWWQQpUmhds6bXme7NfYBHz6SSkpRi/7RHqCOauQawEE9/y6xAmJHRLw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791263187;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Info:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=xsWIzJu63PGmz37dkouV8dnZxkIzclbZVjNPs8L84NQ=;
 b=jp8XVrcP0pnJ3NygMiOxw0vGJmZizptXIUcEfj8iKoL57Qv+MzA+b1xIzj+N4jcPy7gt
 v4Tkjf9TWkV2S5OqXGs3zWEOMnR7hEjCXZHSsqBXomntK+1M64ywPe1LFMeVyc6Pbpjdu
 Cqz13QJDVVeUA8cHJpAcF56Olvn9KLw3Pm+Zjx0Q/6qTEUEOE+cVWFzDgPcVKFxZ6cBeR
 UnsNOsk1PcSICb2OHOybBgo+OZUaYU2oi73OMZqJfVPIArlk2NcSfiV+wnSKPtvudvwY2
 q1cdyD1IHrzN+ctJ2Z7IFHzAX7GVVb/HqbhR10ONUIk5X4UVZ8rq4kTmlHwVTYGAsuA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b="JTP4IPr/"; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=YknvmvXN; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=vandhiadevan.karunamoorthy@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=JTP4IPr/; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=YknvmvXN
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3FD16809BE
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 05:06:26 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6963Ag0g3450761
 for <u-boot@lists.u-boot-project.org>; Tue, 6 Oct 2026 05:06:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=xsWIzJu63PGmz37dkouV8d
 nZxkIzclbZVjNPs8L84NQ=; b=JTP4IPr/j3rRpBaEPDSWOPxa5AIKqUecFipHOc
 zxsDPOez6u1eUd9YjjVb5JNdN2zx8BWIgh0tzSwmPA3ieAJ6aB4EFsXsPyjr0Zy/
 YGfUo4jVIn6A4TWxq7ZeIPYLwxQGSprWwJySxrT5cbUZ8xS+xzoC+0VV0/17tRdG
 akfMJngQjvDs3a3cjv+MbHq2HX6FTXQmODtKmaORWmpdnk8Z47Zaiyw0QR9gqchp
 K2irmyXwl/72ynFS3FWHSgg4/da4z+oYJK3b8OO0kSRQQAH7OEMwarPN1JU5fY/V
 TZL/P1VTeIxeRii1eNWcsXxqsnRtm8rhkhx7qf8BoAV02Xqg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h4a7dunsu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 06 Oct 2026 05:06:25 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-34ef0362d95so4692201eec.1
 for <u-boot@lists.u-boot-project.org>; Mon, 05 Oct 2026 22:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791263184; x=1791867984;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=xsWIzJu63PGmz37dkouV8dnZxkIzclbZVjNPs8L84NQ=;
 b=YknvmvXNEyIRu2vgYtPRDy1cAf1DfVHd8l19kP0SS0/PdOb1eNAKLM5kNGtZ6er2iF
 xwxM4svvE006IIOkpQ2YS/LASKueFFFc/eBJVRWWSmf8rGnhVzcACLmEAmX2ARoabEWU
 Un2UHR2Te9gK0HVjaHxXamW/i4ZwuU6HmLW/05IvJrz+IFW6I7uJvSQ70DM/8o2CLzSQ
 ztW3PEAFRBLNhnQk95KxdXbyp2ipSPbNfKhynYOzPZGViJFVom4sG9LbC8+7gGh57F+M
 6A/xSCCiLIZ37sRCsv5AwChYWPsAUre7L0gOwAfMpMLf66HU8G6ngCCtb+axOQMeQjB9
 cjRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791263184; x=1791867984;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=xsWIzJu63PGmz37dkouV8dnZxkIzclbZVjNPs8L84NQ=;
 b=iSmEHvQB/FLPz6U0Jrb5BOPERwQ1choDmkfXf1SDi/pOy7WMGuFX9UL4SbAgU5b/Bj
 OvSGBsPzetKBJ9VCSU2jftEpOxjznLuAU62sqyIzuKJhxPaztKZVONq5dWd+vs8e0z2k
 dXDOpHbFF7KEjN4DfpD7reoXFpw+Z4Q4WDN/tNMx/rEDbK4p9kgYVLSmC1qDxteuVVj+
 8x5x1OVkzk98MLGmCzTpdQOFm9qFadriL9b7673W9IzD05guzvyC4EfbxUruOelp4tLe
 m2fBGsErum0YGXd46Y/uHOHD/xEvzZAcGv0LzBw5s77bPDJkoV4vpTcJhpKxicN35lEj
 7Mjw==
X-Forwarded-Encrypted: i=1;
 AKwUvBx3j4lHPIzuB67O+ry7/749N8AQiHrBmh2SmJDGF30n+OjHh+IO3Y0k8iRSygU2OAwEousubcw=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKm6+cqgtuh4IwFOac2fiavTLrTuaEIrS6MT8XfgEU+q40prxNK
 2Z1yN9VY/uIjuzwg2cas1ttZmGgaRkRUe8E/8YmGytSs8/w1SKnbFTT+r/XVelLRDmMQxBIeP+Q
 KMjQDq/HwtkOPUXFY9qAtSEtYepAFpNwp2WgeketJZ33R7WF9wxzXtWUm4TQ7JnJ/kB0OlCWICS
 M9ThY=
X-Gm-Gg: AYBFou0slQR9R2HbfT9yNLd9nsAossmyQ8EubLN90fqQjTgTTOM5BoPxkMTkqB/epeV
 INPO4UCWiR6IxlvE2VAoJay1XE8VDaJJ4dX8mq4FSvWyPNbHzIa+9VAtvvI1LDSDQvxtrBACrFF
 GoL9iUBOAtsvXE82rfftlIpF7v1E8N4Q3lih1I6TJ/kCQaP4ca03CTq5DPJ4QePncTd55QwuHCp
 vi09Hs3l+1+HSnqczm8RLphyAKUxRYRQ2SY/3wzkXFThaWd85/RmtrPUSC22JTjdD2n9S2yBKaH
 ZvDqxOB/+oIX9dWRtuhOvzmwr+kvQ4m7ZqpoqqL/WNTsFVftn/slsXufjS8nRg59UQGASdiJS0N
 VnhCOW0emc7ZKqBMBU7oqldJ0bsWIG7LlZcbkdp3qxvUDRFodH6E6SP5RdEU4m6stza0tXN0Riv
 XQpxj3LgoCgOSci4/r3BsEpYuoZhwjkR0LqyoAC5A=
X-Received: by 2002:a05:693c:8508:b0:34e:f644:9083 with SMTP id
 5a478bee46e88-3511148156cmr12618881eec.23.1791263183951; 
 Mon, 05 Oct 2026 22:06:23 -0700 (PDT)
X-Received: by 2002:a05:693c:8508:b0:34e:f644:9083 with SMTP id
 5a478bee46e88-3511148156cmr12618853eec.23.1791263183371; 
 Mon, 05 Oct 2026 22:06:23 -0700 (PDT)
Received: from hu-vkarunam-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-35146ac4dc4sm4309516eec.23.2026.10.05.22.06.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 22:06:22 -0700 (PDT)
From: Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>
Date: Tue, 06 Oct 2026 10:35:47 +0530
Subject: [PATCH] arm: mach-snapdragon: enable SPI-NOR in Snagboot mode
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-review-lemans-spinor-fix-v1-1-f61b32c1a79b@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAKqBxGoC/yWMQQqDMBBFryKzdmC0qOBVioskTuqIRsnYVhDvb
 myX7/PfO0A5Ciu02QGRP6KyhARFnoEbTHgxSp8YSirrgqjC+8RfnHg2QVFXCUtELzs2juqHs95
 4S5D0NXKaf+ln92d925HddvfgPC/qqmibfAAAAA==
X-Change-ID: 20261005-review-lemans-spinor-fix-7c063cbfafb0
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Antony Kurniawan Soemardi <linux@smankusors.com>,
 Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791263179; l=2620;
 i=vandhiadevan.karunamoorthy@oss.qualcomm.com; s=20260817;
 h=from:subject:message-id; bh=T2k9UbdxiQykLsJX/GAnLdQHu3S/NsKw2m4ZZ629bXw=;
 b=wN0QW5QLdx/zfo5rf2kzXstSpC0NN351IV0TsGbFggwZdD2/ynmbow5eT22wA4SrkduuH56hr
 eViApR37eWEDaldfofWNgsVStSBSLenRkuOaIhBNGryWfNk0u5o6V24
X-Developer-Key: i=vandhiadevan.karunamoorthy@oss.qualcomm.com; a=ed25519;
 pk=2EVV7DmKqYX4wxSlXPB5QBt44JjomLlz/wTW2AL4H6I=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDAyMCBTYWx0ZWRfX5EM3Ej25FnRc
 wFG0yC9HeKZVXc/hY36v1HjgMpFU6tJ/NPz8SytdmBNnQekySOpgWx0ZShFI9wFNph1C1olKKOg
 1/QXBgUqlovMGY9wNrDt2A9FwCnnBI4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDAyMCBTYWx0ZWRfX3bT/BwXfRIqK
 yFKn1aU8iOeTeLgDpjD8LMuZKcpnWEK9U2fwERlalhTNyeJ/CepTUm7gBqiV+5r4nvPRbOZ1pc0
 R/754OXW0plWSGApy6v7eDDgNq7axKTqg0Co6CxmjMAO9THquwI1ZM4QuqL7UbnZiuLzVHx1kgq
 0I4D8Mv9gOwSsQsU0z7gbiS1gJtsPgCXrBilrAYuLL4+QuUm6DXb6jxVvQ3mgXJbd+SKHbTmWtw
 e2cVk0eCRssYHAnl21WV+7F2zGMqIma6zmWQyeFD/XquIbmhO66YGAln+/2h2hhLyONUKgDu+2D
 TtI3Sb1eP5qiQtiLoaL6ghIvX5WClWPMCIDAQArJ6MnkX978udEyioVQG/Oh8+oX9g1SDXf/3e0
 KritoV57mmdFalFv0+Ge6FLpD8VlTAyrmwK1gkegLr2oPBYM3JJiVab/TWMh7SBhcYmqO7h8JIX
 zk5pHmBw01otq4dXt6Q==
X-Proofpoint-GUID: y-VWff1yXACWUiKsI3FcGNLjJRhJk0Lw
X-Authority-Analysis: v=2.4 cv=SvwFe/O0 c=1 sm=1 tr=0 ts=6ac481d1 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=gsnHdbw6VzqkxO8V0kUA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: y-VWff1yXACWUiKsI3FcGNLjJRhJk0Lw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_01,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 adultscore=0 malwarescore=0 clxscore=1015 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060020
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

Some Qualcomm platforms use a dedicated subsystem to own and manage
SPI-NOR during normal operation. Consequently, the SPI controller and
SPI-NOR nodes are disabled in the application processor device tree.

In Snagboot recovery mode, the application processor requires direct
access to SPI-NOR for provisioning and recovery purposes. Enable the
SPI-NOR node referenced by the "spi0" alias, together with its parent
SPI controller, when CONFIG_QCOM_SNAGBOOT_SPI_NOR_FIXUP is enabled.

This exposes SPI-NOR only during recovery mode and avoids affecting the
normal runtime ownership of the device.

Signed-off-by: Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>
---
 arch/arm/mach-snapdragon/Kconfig | 10 ++++++++++
 arch/arm/mach-snapdragon/board.c | 21 +++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdragon/Kconfig
index 3cfac19188c..6e318733fe3 100644
--- a/arch/arm/mach-snapdragon/Kconfig
+++ b/arch/arm/mach-snapdragon/Kconfig
@@ -78,4 +78,14 @@ config QCOM_SNAGBOOT_MODE
 	  Build U-Boot to be loaded in Snagboot mode on Qualcomm platforms
 	  for device/factory provisioning using fastboot.
 
+config QCOM_SNAGBOOT_SPI_NOR_FIXUP
+	bool "Enable spi0-aliased SPI-NOR node for Snagboot mode"
+	depends on QCOM_SNAGBOOT_MODE
+	select OF_BOARD_FIXUP
+	help
+	  Enable the SPI-NOR flash node referenced by the "spi0" alias (and
+	  its parent bus node) when booting in Snagboot mode. Boards that
+	  use a different medium for Snagboot provisioning should leave
+	  this disabled.
+
 endif
diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
index 6a66f5e3096..8f841888466 100644
--- a/arch/arm/mach-snapdragon/board.c
+++ b/arch/arm/mach-snapdragon/board.c
@@ -760,3 +760,24 @@ void enable_caches(void)
 	}
 	dcache_enable();
 }
+
+int board_fix_fdt(void *rw_fdt_blob)
+{
+	if (IS_ENABLED(CONFIG_QCOM_SNAGBOOT_SPI_NOR_FIXUP)) {
+		const char *alias;
+		int spi_off, parent_off;
+
+		alias = fdt_get_alias(rw_fdt_blob, "spi0");
+		spi_off = fdt_path_offset(rw_fdt_blob, alias);
+		if (spi_off >= 0) {
+			parent_off = fdt_parent_offset(rw_fdt_blob, spi_off);
+
+			fdt_status_okay(rw_fdt_blob, spi_off);
+
+			if (parent_off >= 0)
+				fdt_status_okay(rw_fdt_blob, parent_off);
+		}
+	}
+
+	return 0;
+}

---
base-commit: 911260be07649563b2f98555f56779a76a99c534
change-id: 20261005-review-lemans-spinor-fix-7c063cbfafb0

Best regards,
--  
Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>

