Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A440CA9ED2
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 20:43:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C4C72606FD;
	Mon, 12 Oct 2026 20:43:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id o9XjWgEFyChW; Mon, 12 Oct 2026 20:43:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A402F6060C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791837833;
	b=So1GkykbjWPOVra74QfpZMbUFKuHO7FmU5D9tQ70157XZ+Js4gz9GZMMVqHR2/SE54rr
	 27KJl1N9FtQ6B6RF2we2NDYiUvn5QBMON1WzukVd/lHzdqtrYRR9o4qX2TNENvaq5xG7Z
	 zwE43DW1rcEL6kJrylgBnS9ka/zB0UOyHiS07iKvyClkMEpG0CDZD4TIE0X6Qcvr7nLjQ
	 wM0aGV3Pr6TNI/Zpn7z4sNeuAeUVf+2xIdNNf4Di5xstAHpxQm5yBzSgpIdSHdIB9FJAU
	 Z7E04mx//Adn6cPx/yxrktB/v/aHoqKljeKHKqoMRtZQA7SQCg1V2k654nGHAashGQw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791837833;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=qdoCxjLeWO9IU57x5bROGEFMYN6ks53DqecZJjL6Q3M=;
	b=oaxyC43a8Do8t1FpBO+keZFg4aTQxIVJZHJVPRy5wLgJMIjCmrfhn5EO9FYbgSMOGL4l
	 RsNGZkVC2BfHe7o7F2vXbrFoa/JVYSBOWFkFY/2tfx/UgPu/uwWIHe50aG9a1HbWJSSyO
	 S1WdmwW0W/UOlqxcXOHebcM/nUoFGlLhkuUoIfm6JmSQThSXjMJzfAj/l1Prty4TXk5wD
	 3+qjR4rrsnZkb0bUCNLMttQ4BaFYRA0zdIgXtm+newB5m5PVnXDQYHKWkgVLhsyS4CZzX
	 QycHn/Sypj+6NPpri0h9O2s84wVF5PnoTIEFIK6yEfxpopNcL4FC67OdPqfYBAyCOCg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TIm+kfTe;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=J55fgMGc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791837833;
	bh=qdoCxjLeWO9IU57x5bROGEFMYN6ks53DqecZJjL6Q3M=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=IKqXJ6tcrukcaPI0CyVTotu66QroWvH7n0lo3zcFzd6nAgdes55kNOPYF5KFkS2nH
	 7ZmczLHCEfLb8/B/nKsT3+LuLb9gPQbIQvhfc3uLtsxWrCTJ8gN/aI5EmU6uvhtSGO
	 KdmJPsrPX76oGeZeKR8y3AK3swamymQJ8Wbzg7txz/O3ihaq8MQh1JrGYIA8GNkUZ7
	 oUlX8AIWsCnkSTx/EfSHPaGRpuZFluajS15iUZs6iIiiLpcgIZeIyxhm+5wjyyKrW7
	 Qojmmbl4r/bZFnK4tY7Ru+b87h/C85pLEZ7oO0iElhQH3jamOreh3GoV6zO0LgXcRL
	 44C6SRj4uNlMQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A402F6060C;
	Mon, 12 Oct 2026 20:43:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 49AA9788
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 20:43:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2ED9A60600
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 20:43:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AWL2mLzP9T2V for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 20:43:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 13D57605D0
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791837831;
 b=kGEXnUnAjoKq8WaEXTR44Yl7hyDvPuZEvq9wyJhWhpsRmsoGHFd/iRjpEYvwBVuJocZM
 x9iKK7KJwPVVLceRTOz1djKTD7AknX/WjxGpdnonI1Hqyq9w1qjhOugdI0YK2a9U5g6VC
 a0UcJaIubSXvh+IBXtLVSjO1mdHPjvAvtKz2fcRVeQIN8l5GnHndT3hcZzD8Rq1AJmYPL
 mxFIqckILAstwdNL/pndnq4pZe3/dgGRahlEUr+hzoJ07U3U0OW5/g8lDBtC1CW845C11
 pXZ/cZ6jQNltVucrnV5qqA9ZhA0oG4se3sC2H9qD5TTt6KPeq52sIbsBgdXDJ5UXvgw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791837831;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
 X-Change-ID:To:Cc:X-Mailer:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=qdoCxjLeWO9IU57x5bROGEFMYN6ks53DqecZJjL6Q3M=;
 b=ChnOUxhS8Rj2iRHUQIIQsqTGHW2Tnr0c8j4e34yoz69NTQMfG5r0ZiIxz1QqDy7HR3ey
 To/Bsae80VlWox4AK57TZIjwTRjN12+BBGtBc2z0Wl3I7ZP5eSf5SK70bvltnVYEn+VzA
 Rd6WVSyDyIHFkwW2LgdnqqBf2MxmWScKkoRhb4aE1LOd1KvHirx3276G1D2Ldhvg5e26Z
 JFNazPmlZamggxHpBqn1kWKZ6NTFQ/mj4sWLl9wJVcEAL8FHJ1kUjFp1hk05nMM8Wyr7j
 IzPMcckQOwcvI7NsjsbCAvxbnPCUhnQGWWBUSmy3j9j9tPtN0tA2TfOQl2VmTVe0LEQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=TIm+kfTe; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=J55fgMGc; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=TIm+kfTe; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=J55fgMGc
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 13D57605D0
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 20:43:50 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69CJgZkS3106566
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 20:43:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=qdoCxjLeWO9IU57x5bROGE
 FMYN6ks53DqecZJjL6Q3M=; b=TIm+kfTemptQKITTyyWmoL815prhG5m+q2GI9R
 SFL7RCVys3VF4rMqhS0Ye7CIkIlSkO7J22Q/uW0DytdM0TAqQ9jMcgOSwcF4iGAZ
 C46kKpp6M6utNy2NXGHPRqtrh6IDR0Cqo2LJVUUeU+5zJU0XbIzqvODVkxi1HpF2
 yufqrEJRlPrSe3CKKQERMY/e3UwmBG+0NcGdWyycN2vtlUaISlI65JhG4uOf8iyE
 JNppaGq3KU/SWsSZnOiLeVqozfyazNOBOhiTcVeznfLA8R7soQp/bgARIZDSpYVQ
 +sHMLn5zlrWx5sWsU+LtaIBAqc7CdFZ75Ou56htbWY+/pHaQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h95xqr6sv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 20:43:49 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93c5ab5c136so388410085a.3
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 13:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791837828; x=1792442628;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=qdoCxjLeWO9IU57x5bROGEFMYN6ks53DqecZJjL6Q3M=;
 b=J55fgMGcseyro2iozaEo7cg7MXAWgppC5ET2rp9+pS22EszyJDC4ZoYsqxNWhSbKk/
 u9F89PjTFHN20FrYeMCOOlIB6kuO3L59ZIuwKNGWhLlPQnLansyC9gIFBS19G6EVatjr
 nPlGKf+6tZL9QDYakU72AI9AG27DD5uU8EedbuE1FVvpE2xmgvBu4bozyAYfX+L5EFHV
 1TketTp0Fn7w5LNSUZ8DEK6UFlCo+ZHfTeb3MBmb3sa++KEJCpn1em32w+VKtUJI+2PB
 AhT52uFKyR6hwvfS1oOvn0DPPZ2LE5yG7iAu8hh+ZVpd47ThExZJTosArPdF+lzfonfr
 awqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791837828; x=1792442628;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=qdoCxjLeWO9IU57x5bROGEFMYN6ks53DqecZJjL6Q3M=;
 b=xH7/1w+J2DNuTNnRKHYAzbnGaFrSN+Pd8KshPAKPKa3aOD5Ud0WdXQkK9zMgS1TCUl
 Gb0XazBRJgmd5fvKnugWEcG9QorqZykVumP5rqSMoOr/bpdybU9h272akjeDsU1XGbWh
 N9EX3BUpqlyXRGYQ/7hUS0j+niUpnoh2IqX9/HEQWtJ78qhgsfoAy6lVflQUGnH/IWpz
 A3v8q0/GXdsx1HNEdqP1Msn5yQVTBXKF2Edd7v9PiQ1sAavTpDC1xZteAsYhhQJ7TD6/
 SpuK4suYE9xpvi1MXw6l4foIA75IT5nD9qmlIWsR1y0knHD5y2mmZgJEpX/J5Pggqb7B
 Kdhw==
X-Gm-Message-State: AFq9FYJkkFu1OFBeoW/jjsLHx+BprkUz+e7Z6vvQbE0kkUlmm0dk2b8T
 Sa1g5jNLOqnMUG60B0+clXX/uMTlUCFnH03Kczgf0/fkF0OS5vP7DELEtwjCTES/6x0pLXWxeY1
 +0u2Q4igmj6dNjd/3ybZ2XR7zqYctZyMNVSsdg6FFggFlxEp9i7uvIpWIcq1qzMjTfFYu9qE=
X-Gm-Gg: AYBFou17TVAQdFuS7Q/RSqzDoU90eTEGYJCTX3iFmysdTcqRMkLBRCJxskLfoh4lt7X
 W3oOOT/GmywVe/uk2CBxSHY9hcnSgQH/nmIHv5W99pDbjFZB6HPjBaqkyiF+fpGWD54WPS33xE3
 susGuNl4kWpWjehC852lEyi2QN5dOaGOtAHVZNJNs5svsnj3jC2xd0sbfaiFdOYnBWMxdx6WpzB
 LPdsvqCFQS2kpUCv9Phv2hpTs/5qoSlZseRw9huwRlIf/Fawruti64QvPCNMIrhDbjl6sKg1GfI
 55tqvUpDU53DCC3dm5pbZeTnAAAlsBiAr7sUyWR0LYA5az3Ix4uxIQjhL+TgbtP5WTIaYIM/rRZ
 /EH0pcLnEkSN8Y0lcKF8Uv+uvOZoxilxUyqQ0pk92iVWu
X-Received: by 2002:a05:620a:3705:b0:93c:c27f:961b with SMTP id
 af79cd13be357-93ebd20b8fbmr1758653985a.44.1791837828370; 
 Mon, 12 Oct 2026 13:43:48 -0700 (PDT)
X-Received: by 2002:a05:620a:3705:b0:93c:c27f:961b with SMTP id
 af79cd13be357-93ebd20b8fbmr1758650985a.44.1791837827668; 
 Mon, 12 Oct 2026 13:43:47 -0700 (PDT)
Received: from [127.0.1.1] (185-164-141-21.cgnat.inetia.pl. [185.164.141.21])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c31a9a3ae9fsm489682766b.26.2026.10.12.13.43.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 13:43:46 -0700 (PDT)
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Mon, 12 Oct 2026 22:43:39 +0200
Subject: [PATCH v2] bootm: set os.arch for Android boot images
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-upstream-bootm_android_b4-v2-1-4c18a34550a1@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42OWw6CMBBFt0L6bZFWbNQv92EI6WOUGmmxUwiGs
 Hdb3IA/k5y5Myd3IQjBApJLsZAAk0XrXQK+K4jupHsAtSYx4RUXrGKMjgPGALKnyvvYt9KZ4K1
 pVU1rONdGyyMX6kjS/xDgbufNfWt+jKN6go5ZmC+URKAqSKe7vDLg5r2DOeassxh9+GzFJpYd/
 3SYGGX0ACdeCy41r8TVI5bvUb607/syDdKs6/oFSc7wbPcAAAA=
X-Change-ID: 20261011-upstream-bootm_android_b4-4e94dca526b5
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Aristo Chen <aristo.chen@canonical.com>,
 Simon Glass <sjg@chromium.org>,
 Nora Schiffer <nora.schiffer@ew.tq-group.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA4MiBTYWx0ZWRfX6e9EnRGU8xCf
 LcOWtjdPQ6bDtEvjLCkRFGGWw+ceseFQygQuqrecMu3A5HlwHIoXTVEunC+9bry5tRJ0UGSXvhq
 ig+2g3jG1YavbStaY58NcryIoTTq+frRq+mfQhMHpt2wyLjrQpPObbW6C/Id5PS9fVWOrFmV7GF
 i3Jxu3Oj2ba5b8tP7bEpCY1Huk8s9/KaG/ySci5gwESSmssrDaiW6HSrz2uN4A9p7lDHmpsn0uM
 tZXq5pUIo6aoPyX2/0e6vWE22paOxcZjPCsNbcqqb6HY8cNEo8vPZsYIqyA/dkEq17IstyT4qVr
 MHcfLN1VF6mJXptpCoKYwOBZVwsNkT85wI2Ru5ebiR3Q7o/ZDaamQ+VSHLaj3tskHeaSi07Ytpi
 C2B5pieajlNPt88PvoO2Z6teYkXMIz/dLNy60pnWZ3H3w9f3Mwp8hTp+v6N+5elX/GejfZhWG2k
 FW/cvRqgZ+8uupIfkkw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA4MiBTYWx0ZWRfX3rBHbZ5h98ik
 X7kEF3RNHtRLGOSQ2gZVk0dIMsmPkGqrV6bb3YL9/dQ55VxUiBjETP8UpUPKqHxzyauD9/OWXe9
 ZE/H80tbcVhTZt5cvcA+YtJHeQizPNM=
X-Proofpoint-ORIG-GUID: 7LyJXQ-qKj5yePdHKBmqnkOWXpQfiHri
X-Authority-Analysis: v=2.4 cv=EP+TQFZC c=1 sm=1 tr=0 ts=6acd4685 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=JsdSkJyxCPcZmfxNhm0PvA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=cm27Pg_UAAAA:8 a=232JLdb0kJR1mXPfA-sA:9
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-GUID: 7LyJXQ-qKj5yePdHKBmqnkOWXpQfiHri
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_06,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1015 spamscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120082
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

bootm_find_os() leaves images.os.arch at IH_ARCH_INVALID for Android boot
images: unlike the legacy and FIT headers, the Android boot image header
carries no architecture field. The arm64 Image relocation in
bootm_load_os() (booti_setup()) is therefore skipped, and a kernel that
is executed in place, which android_image_get_kernel_addr() arranges for
any uncompressed kernel whose header holds the default kernel address
(or with ANDROID_BOOT_IMAGE_IGNORE_BLOB_ADDR), whatever the header
version, runs from boot.img + page size, which is not 2 MiB aligned. The
kernel reports "Kernel image misaligned at boot, please fix your
bootloader!" and dies early (observed as a stack overflow in
start_kernel() with a GKI 6.12 kernel on QEMU virt).

Set IH_ARCH_DEFAULT, the one architecture this U-Boot can boot and the
only value available for this image format, so that booti_setup() moves
the kernel to a properly aligned address. The other readers of os.arch
are not affected:

- arch/arm/lib/bootm.c switches to AArch32 only for IH_ARCH_ARM, so an
  Android image keeps taking the AArch64 path exactly as it does with
  IH_ARCH_INVALID. Its update_os_arch_secondary_cores() hook, implemented
  by Layerscape, marks the spin table entries OS_ARCH_SAME only when
  os_arch equals IH_ARCH_DEFAULT, so with IH_ARCH_INVALID an Android
  boot currently releases the secondary cores as if the kernel were a
  different architecture; this is fixed as well.
- the x86 setup.bin lookup in bootm.c is only reached on an x86 U-Boot,
  where the Android format is not bootable through bootm anyway.
- ARM32 and RISC-V do not read os.arch after bootm_find_os().

For a v0-v2 image whose ramdisk is used in place, booti_setup() can now
move the kernel forward by up to 2 MiB, and the memmove() of image_size
bytes (which includes BSS) overwrites the start of the ramdisk that
follows the kernel in boot.img. Executing in place already had the same
problem, since the kernel clears its BSS early, so this is not a
regression; the ramdisk is relocated by the ramdisk_high logic when it is
in use, and loading the kernel to kernel_addr_r instead of executing it
in place, like the compressed case, is a separate change. The LMB
reservation also still covers the original load range, as it does for
FIT.

Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
Changes in v2:
- reword the commit message (Simon Glass): the Android header has no
  architecture field, the in-place execution is not specific to header
  v3/v4, why IH_ARCH_DEFAULT is safe for the other readers of os.arch
  (and fixes the Layerscape secondary core release), note on the
  ramdisk overlap for v0-v2 images booted in place and on the LMB
  reservation; code unchanged, kept unconditional
- add Simon's Reviewed-by
- Link to v1: https://patch.msgid.link/20261011-upstream-bootm_android_b4-v1-1-3e82462ac206@oss.qualcomm.com
---
 boot/bootm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/boot/bootm.c b/boot/bootm.c
index b6ae0163b27..75b34f39cca 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -432,6 +432,7 @@ static int bootm_find_os(const char *cmd_name, const char *addr_fit)
 		images.os.type = IH_TYPE_KERNEL;
 		images.os.comp = android_image_get_kcomp(boot_img, vendor_boot_img);
 		images.os.os = IH_OS_LINUX;
+		images.os.arch = IH_ARCH_DEFAULT;
 		images.os.end = android_image_get_end(boot_img, vendor_boot_img);
 		images.os.load = android_image_get_kload(boot_img, vendor_boot_img);
 		images.ep = images.os.load;

---
base-commit: ed869863c7e2aca50d57a05d843830dd843138c4
change-id: 20261011-upstream-bootm_android_b4-4e94dca526b5

Best regards,
--  
Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>

