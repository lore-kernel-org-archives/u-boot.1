Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 167DCCA601E
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 12:27:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C3C8D4073F;
	Fri,  9 Oct 2026 12:27:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ssXMmc4prETe; Fri,  9 Oct 2026 12:27:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A3CE840707
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791548873;
	b=VIBB6YSXke5tIeN5wG6E1+Dw1hTybY6Hyut3X86PR1MrYvdIC8XjiK3HB3tnSXhT/yn4
	 CRjf0NUc9bQYuFCa1J+JC14d9YFOl1LrzbmGH2lHvQx3RgKJ2wwKDYDx39qdKMCjqxG/m
	 EQW+eYW4ctkydBtD5aZccyl+xEz0e76Iv5ryLEwXTpv51m3mVMGwTDURIZZwGuVwUlIJC
	 L7kTqwZkNKvI5vfhoDG7JgdKxAjQSyc4lUAMp//EcWX8fQWRm1XNnBtoiIyc3keyw86Pd
	 qoYjKco0HX7CXz+G6016dE5iXD8ZlDKS4wGDYuQuH0/9DENrGVXtxjw92+MkWtdiONg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791548873;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=P+KKgMzDAFtugfYchR2CaO+UGSasHRK1xwOzGBZD3wY=;
	b=fHiLmszkPTuyQ2P5JsNw2FmuCmhO1ISqU5Tjsy/RkHG8M87rnR0vWxC8uvGI43W+9S4U
	 APLlPan5xxcvq56BwbUQd2h7sqYAD8MBNI4NcQdvgqqh9+AIOYoYHoQJdLmyx+96De/yP
	 Q3yYDvCwN9MOMb4G2h1f8qbZLQolYc72O+WvJvDqZLTS/T5XQWjtCSTjFjclKp2hgtUoL
	 Ydq4AX9S1JSvJj0RBgkOOKpI3egYQ7Bd2hxYsNy4wZuk+E0sY4aEpg8FWDh1bf8uWW+H7
	 sGaL5rbq4WEebrMzHXGhkRzU3KX08lYsvOVgDO33hpUR6Y0WG5Q7Lih17hCA3uBFruw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=IYLkoHQ2;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Vpp6qKp7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791548873;
	bh=P+KKgMzDAFtugfYchR2CaO+UGSasHRK1xwOzGBZD3wY=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=r8/R1yNSynYvLz3/5tqARbnc0U1QCNHjM5X+m0lpNCEuooci5Zt62JfFB2FYi9J+N
	 Tf/+v35hKozs7f9nI4qCJawAlDmcjznFTSgc4jXpFB4BxUkEqwffId6PwoS5oeFYJa
	 TmZ+o/rirsmSP9yGGIfXAtaVjbVq06hWNFYZ3B5UraK9Hupi5dgZmRMKse7IzZcFHH
	 v4rHXGuP/Z+ZvYCOzkf3lQo5pN2sXDIrKRGvhmE0f9PzZgF6JKPNkp/45ZC1I7LjzI
	 lKLcAw9U5UimczhdjOvmM8Xvqw1/SHG+NJOUaF85q+4fnt03UqSifA0473ZEgq4gBR
	 aZmVjkFt9RIFw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A3CE840707;
	Fri,  9 Oct 2026 12:27:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id C42782AA
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 12:27:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A9C6E404C8
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 12:27:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JXUSY9Y0ZwDX for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 12:27:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7FE5140402
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791548870;
 b=WZ+4/VVdXVl76zWyX0iadqolryHBXJEclLcMxmstgE0X6oTlALV+q8DMJQAISSo3wK5Q
 4kEfScw41gDHJnwExBDcK/sb4BN2y/0yWnXgnznfKZwD+T1PZXDg4kubiOcDpI/4WXcx0
 /hVcl29ISvsdhDfS8rzJT0XyAAAM60HS2Y4kIMlZtcWiKvwso/Rm+VLhd+k8pAeE2m2lH
 MBCiSRZw8SvcbaKTIukpUVIAV9c67A35z3L5iFomhFHtoXaApwbyfpbDCDcxW5dphRZEB
 s89RfSvICAPbcfSq/fKuYFEZzFEIWoMNqLKTJ6qNn03bRhQzN7kl6cDaNSOmaAT+nvQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791548870;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=P+KKgMzDAFtugfYchR2CaO+UGSasHRK1xwOzGBZD3wY=;
 b=WfK086/XLsOZs/6AiS211d0Pg5eLDc5vvlIm084Q9mbF19R47itrTTcRbN8KuhiYB+pI
 P9u9ly6vlhmpwqaQliZTeUYWPhR7/WnytEJld43J2UVxcM4h58s10aYws3Xbg0vChxHhA
 T770FvHkcpLRluajf14tUnGrn+mLNyaCYLAT6WnfKMjAR380sBvHUtRMERxLIOkAIkqm8
 F5e4UnvGIxf8VoJ7iyHB4SfjvlLhw+ySGxnhqBTSFs2ql0ldsQFKcfI3foa4nRo4ZZsaS
 HY1w3pRs1WYqrIyQlQbob/TtMGudHGnN4HtYwByBO+NoTN4XF6rFn7Gg0Y/NFZnu3Pg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=IYLkoHQ2; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Vpp6qKp7; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=badhrinath.s@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=IYLkoHQ2; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Vpp6qKp7
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7FE5140402
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 12:27:48 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6998KECe906780
 for <u-boot@lists.u-boot-project.org>; Fri, 9 Oct 2026 12:27:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=P+KKgMzDAFtugfYchR2CaO+UGSasHRK1xwO
 zGBZD3wY=; b=IYLkoHQ2SwiS332joFeWz8NqcvOdwOYX6DwNBiV37qo3A9JPxX+
 Nncc7LcARdv0dCSK6KbENSlO05A2YhweRukgQr8ytkL8F7UTICibZffG/uFNIugd
 nQl2fk8BYAXARA94sK36QIhPyHPdUSCEHsTiDkcGUiormd7p6kY7/kkxsGEGq6LC
 VUmIdii1SMlbuvDjKdQuD2uTzlbhhoSMlk9uwzLCN3Kg7737F1ljIUxWiDE21ymm
 KGg8p031srh6FXpKD5WUm96+vAcc7osGM8crQDsQRY0n3w21lqnJ8HJYmEpvivkw
 aDJDD0xW6VkabrViopqMXkQAJ74X0yosw+w==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6fmqukuj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 09 Oct 2026 12:27:47 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3965ba1ba3eso7919198a91.2
 for <u-boot@lists.u-boot-project.org>; Fri, 09 Oct 2026 05:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791548867; x=1792153667;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=P+KKgMzDAFtugfYchR2CaO+UGSasHRK1xwOzGBZD3wY=;
 b=Vpp6qKp7KW8ceWCa44GM1Y+a16ghEinaNtC8fZstwOgw0EeVX4PUlynRZV1ay6/mZd
 C989qFPKrPY/TjZz13qrvygeXaTvENSuyYHST33WrNhVBgJCTCDpivK4yv2pUAZn+vsT
 vlAArzLyxgUDUiqP72aGYTEcShVVkq/ZOrm1uwTyVP/XRnyIuI4chLFaaOJpnU/eEfer
 lgy7mV3hOu478TQyYtT9Vy9A+4SuivE+jClkmll69mB9d2e4R9c2IJi46UmHhpX7Mnch
 l5+yxcJcbyFGKIvMp9NVAqnvU7VVE1R0TuOQ2lTYvGD+ejwKeo5PHc+4HCb02K+dQuTY
 UQ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791548867; x=1792153667;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=P+KKgMzDAFtugfYchR2CaO+UGSasHRK1xwOzGBZD3wY=;
 b=nQMMQGvE03WwxN8/NB/l2wZNDFXltq7vnJm06/MbHvXnQmjLu4Qi81/8kT5IcF/mLy
 ioTOH0V8oSqchCna/tB3bF8f/6U2Jv6ZK7d1YQpi8nA9X5AZhH4jYkqBPWUo75mZ+wD+
 1O4/cUU3ZGXwRI/FE7iRZ514QcHqidzC0ebKYc4kuHYpKSD7zWRt2rq1zsg3gNw5m/7b
 TrEsiGIZlHTWn6kYdojkp1FbHUkPvj7wS8EK9zblWb2YMMZe9lNtqk4z+48/xe49gn6d
 LC64nkXPmhziC90drikOYLKnNsSo4zlAEGsnSG5sO6IM2wyDlJBQyxIo3VzicxlFXppT
 OlWw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwcCfXU0/850TfinF47IsqEFztII+bvWdVHzmpoF3mnzRSDJS4j/S4I+/ORwGMd/WYLG+0G6jA=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIBr6P9o8fNCUJAzIcBpJXAMVB1RRcigLFWAkTNPUnUrNFXoBMj
 HYcWR0KlSJFVt9JdZSCXI3YPlTFgsyIaoanFwBKT98NSLOc1XBNEatt+/jYI2CVgx6uuo9IJF8u
 HJtj65bwTxq6Xi09oAiM95NNzrC4g3LEhEbmjCBSDxAgVxhgx943WqCQPIOxVfb/PDA4mj8E=
X-Gm-Gg: AYBFou2uU16LT9xuhocBy1argZ306UDiGYAZvjWYUpkR/oG35fQ1hB8wEzEkQvB4uZw
 zbhY6Z4RiNikzpn9X4hGO8oLFOlYQmReaPx8ZrlQjAkr0ZreZ6WfpZ5Jv0Woe5wpMxwMUOQrq9+
 3QEB5r6/a7dn5XdBrwZF6+dsVSpIPcIgqVvLd7vVbxnlwCz3Ch0jJ9wNl4eqDFvQYPpCaxUCpLL
 U1MldvbhxwEMxR5NkIRWAOV0uFXa9qTCPQT2OYXWRAaMUFbDVr4A09fDzNZrwxR7uk3BsuWw+Uf
 P4yvlPceUpdNPKjoXTTrhlfg/+inORRnE6LNhkiPciOI+O0SCQh0RrYGdw+W4YtbNcUxKfeSeZc
 jR3KCYJDpMgRmEOySDHC5Ky7f+OPekG9+FLtbudjtMXgUeCiP/mmo5SsV2TLFEJdW4xwpvS9xr5
 AKndGliygmSS6Hv0fepOw=
X-Received: by 2002:a17:90b:224c:b0:3ab:2ad1:f10a with SMTP id
 98e67ed59e1d1-3ab3a0ef48emr1527790a91.0.1791548866594; 
 Fri, 09 Oct 2026 05:27:46 -0700 (PDT)
X-Received: by 2002:a17:90b:224c:b0:3ab:2ad1:f10a with SMTP id
 98e67ed59e1d1-3ab3a0ef48emr1527755a91.0.1791548866100; 
 Fri, 09 Oct 2026 05:27:46 -0700 (PDT)
Received: from hu-badhrina-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ab371b2f2bsm3399497a91.15.2026.10.09.05.27.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 05:27:45 -0700 (PDT)
From: Badhrinath S <badhrinath.s@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, peng.fan@nxp.com,
 jh80.chung@samsung.com, tanmay.kathpalia@altera.com,
 lukma@nabladev.com, badhrinath.s@oss.qualcomm.com,
 nathbappai@gmail.com, nikroks@mainlining.org, luca.weiss@fairphone.com,
 xerikasxx@gmail.com, jbx6244@gmail.com,
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: [PATCH v7 0/4] Add U-Boot support for Qualcomm IPQ9650 SoC
Date: Fri,  9 Oct 2026 17:57:32 +0530
Message-Id: <20261009122736.1185878-1-badhrinath.s@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA0OSBTYWx0ZWRfX8YkkyxZ3iNVG
 7GnzWZk6XrBTC50EX/zk7iL55NWaf2VvqtJNvqJGZMw0wxNpxvmOS12ht5eU0BVFjPxL56ECHKm
 wrmVVxvtG9f4as4aoFzQ3qoiOtZfHPs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA0OSBTYWx0ZWRfX7u6gp6T/HX8d
 ICiul8hg3RytDAUatBjvRFnNH8g1Jvk/YdIOf0oOEtaa9MNz1Y0NhtuYdIL8aIZPMAH43agMZmX
 71Kzug4xcgmgPh8ZyRfR0EGQ3t4oYyO5ZGICxi0ylqNT9t7zQ3zL41riyp9I/AiezNO/mUBb6he
 KCqKxp/7ibqKcuLboh/Vl6MMyQcQQO9W8qKI9o6eZaBBGpOuQPxbQD/BmRAl0iPU9K6q7oKpBTt
 ctNwTyAKyuGohlVONGB1w8NkRJ6pbxEC5EfAiet+Fd9Oi4yvq8vCrSZiMvkp0/iEjaUrU6cGLKu
 I4uOWUMHgIwCZdQu2b0b0+7RV6VQdvOjZhuXgIxndlSIZ2NggAovYLL+yIAm+Wsp2Yw4aXD9cp7
 DjU7/bkULxSJ+2ThGu+oZUjJU0BR8FRvmXagjCSxM0i3iGvpnSC3QdLu1WFJsjoYyQWQlqG8QZU
 8j9Gq1B7onY0dcGOE3g==
X-Proofpoint-GUID: hcqOzXCz_Ra7g48zbeouxGjvxcXnDuG5
X-Proofpoint-ORIG-GUID: hcqOzXCz_Ra7g48zbeouxGjvxcXnDuG5
X-Authority-Analysis: v=2.4 cv=IqCL47/g c=1 sm=1 tr=0 ts=6ac8ddc3 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=gu6fZOg2AAAA:8 a=BA_-LPzDovLyT3sFK5IA:9
 a=rl5im9kqc5Lf4LNbBjHf:22 a=2RSlZUUhi9gRBrsHwhhZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_03,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1011 suspectscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610020000
 definitions=main-2610090049
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

This patch series adds U-Boot support for the Qualcomm IPQ9650 SoC

This series enables:
- Clock control via GCC
- Pin multiplexing via TLMM
- eMMC boot support via SDHCI
- Serial console via GENI UART

The relevant DT files are available in linux-next [1].

Testing:
- Successfully boots to U-Boot prompt on IPQ9650 RDP488 board
- Serial console functional at 115200 baud
- eMMC detection and read/write operations verified

1 - https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/arch/arm64/boot/dts/qcom/ipq9650.dtsi
    https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/arch/arm64/boot/dts/qcom/ipq9650-rdp488.dts
    https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/include/dt-bindings/clock/qcom,ipq9650-gcc.h
    https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/include/dt-bindings/reset/qcom,ipq9650-gcc.h

Changes in v2:
- Fix SPDX license identifiers to GPL-2.0-only across multiple patches
- Address review comment from Ferass
- Link to v1 https://lore.kernel.org/u-boot/20260605094801.4130128-1-badhrinath.s@oss.qualcomm.com/

Changes in v3:
- Removed the sdhc node from this patch as requested. The SDHC-related changes will be upstreamed
  separately by the kernel team.
- For the defconfigs, the common IPQ settings have been moved to qcom_ipqdefconfig, while
  qcom_ipq9650_mmc_defconfig contains only board-specific options.
- Link to v2 https://lore.kernel.org/u-boot/20260610053655.2825589-1-badhrinath.s@oss.qualcomm.com/

Changes in v4:
- Renamed qcom_ipqdefconfig to qcom_ipq.config
- Removed optional DEBUG_UART configs
- Link to v3 https://lore.kernel.org/u-boot/20260716062318.4121929-1-badhrina@qti.qualcomm.com/

Changes in v5:
- Replaced deprecated GATE_CLK with GATE_CLK_POLLED in clock driver
- Return qcom_gate_clk_en() result directly in ipq9650_enable()
- Link to v4 https://marc.info/?l=u-boot&m=178471712422519&w=2

no changes in v6, just respin

Changes in V7:
- Rebased to latest top of tree

Badhrinath S (4):
  clk: qcom: Add initial Clock driver for ipq9650
  pinctrl: qcom: Add ipq9650 pinctrl driver
  arm: dts: ipq9650: Add override dtsi
  configs: Add defconfig for ipq9650 RDP488

 arch/arm/dts/ipq9650-rdp488-u-boot.dtsi |  15 +
 configs/qcom_ipq.config                 |  36 ++
 configs/qcom_ipq9650_mmc_defconfig      |  18 +
 drivers/clk/qcom/Kconfig                |   8 +
 drivers/clk/qcom/Makefile               |   1 +
 drivers/clk/qcom/clock-ipq9650.c        |  93 +++++
 drivers/pinctrl/qcom/Kconfig            |   8 +
 drivers/pinctrl/qcom/Makefile           |   1 +
 drivers/pinctrl/qcom/pinctrl-ipq9650.c  | 430 ++++++++++++++++++++++++
 9 files changed, 610 insertions(+)
 create mode 100644 arch/arm/dts/ipq9650-rdp488-u-boot.dtsi
 create mode 100644 configs/qcom_ipq.config
 create mode 100644 configs/qcom_ipq9650_mmc_defconfig
 create mode 100644 drivers/clk/qcom/clock-ipq9650.c
 create mode 100644 drivers/pinctrl/qcom/pinctrl-ipq9650.c

-- 
2.34.1

