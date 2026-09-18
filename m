Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FD75C982DD
	for <u-boot@archiver.kernel.org>; Fri, 18 Sep 2026 20:07:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 188F360EE4;
	Fri, 18 Sep 2026 20:07:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AFse9phxVZpq; Fri, 18 Sep 2026 20:07:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 5E96D60EDF
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789762031;
	b=ZFjR2wVdGpumOMR+Sl2YAqr5Rs9MlwPJHxZyeNp6MAmJfLRRzHVsAJrcfN5nFfw7z9h9
	 qcJr59XZ47jyMxjWuR8fwAITK+/2M4hoF1ySeDP73ZXRSpQZ7fYzL/D8YDPVYeWOfGm8J
	 vO0Nb9GDfgSo1OgNMnP+07D70tWsS6YmKOQ+NcWtOYt3nx8SpVZbOXurh9yhx5eg2Qkiw
	 caVU8BcPAWlSKst4m6aI6EORlopDqgtf1oxfQQCQs4m4J9psEPFubfVKIEUtD/f+bZM+A
	 MTPLUbzBPvTSjMk6ugKwKblDFVC2+RrhIJ8iI4IazmzrPbJPgD8iPnBdR0kSYEITROg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789762031;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=IKdL+LxXETN7ELPYBLVSvJn4gcjoU8QCWLHv7a/84dE=;
	b=lS3rNYOATh4xJ2rUwTKCrqrEG9YAj1t18Y2IV0kXcN5GsKZf7H4npd4bN3qY2R0Kv4fX
	 WsVg/Hc7+2GE0/UJNWxxtW5eXTCwhcTCjsPJaxK85FIHX7eZ8hY7lEyIMDzAWmOQS7CnA
	 h5C6dafuZdQApUsYlhQVady5o7FCPzBFKFiNl3bsOOrvm6nyozJQbcNODH6sVNTiMdkIz
	 fWHpmdhcBHA8N/pMRlxYYj1UYZJOsSyYmVZUrXv9YkuSCMiRkS6bLSDEq2BbmNnktqvJe
	 TJuA5ro6KkQKeu4MpqVxw1SN/QVkKuzyU5gOsMAY1NYW3Mht/vJhTcBvZE+yXuBeePg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789762031;
	bh=IKdL+LxXETN7ELPYBLVSvJn4gcjoU8QCWLHv7a/84dE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hnRlLMzfNlxbWzT9eJsviDYNGq/X1vFuc/N9HlO4nlOFru5xg/cvG47vAGGLuAkXZ
	 9H4QXC83JZbjgmKOQWMZZQ4W9o6i7LLV7ZA1BjVeCZBt7r6tCVfPmC2LkqSgVTaQ8C
	 /jRwaZzZIboD8XZRz5W7/lJdhAbs4DgBGxpyP/WUtIbfv3eMAuHfbrmXRcGt40hrss
	 FV2/1hunw407D5g9QMow3KoI/E82QkBcpgHtE2AmmPUUkKm2q8Tt1ofk/maZudABmm
	 S8T0oc5E4pkwwG4WX5vNxX2Cn05UgsVpNKf8s3sTlwOYlKuiWFfjVUvB01qy/kvit5
	 oMYBTW8uAchtw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5E96D60EDF;
	Fri, 18 Sep 2026 20:07:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4BD46224
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 20:07:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 32B8940446
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 20:07:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xwuyYGRIsMej for <u-boot@lists.u-boot-project.org>;
 Fri, 18 Sep 2026 20:07:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 38D6E400F8
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789762023;
 b=ryYTZaNGtugjkfBRmIAeB3ADq/LavACfBIxP+1NUNYUvTcYxgh3S7uwtD9zKYkOVuZf7
 6eC/avO+soEtGkmjFgBCUdkq18hdJRfBDh1VBZizpN9Wj41X53OVNeJYmxPLcHk0mceeZ
 ZMB5sG3Bl5uSISqsG/33lxFfHBsKb9mHx6vAogKv9+pULsY/ZZQ9YiH0xKk3yzKGSl4/V
 xVqKcAncj477zYVw58PJ5vtMAWb0y5QJrQi8tbo9ycNhc8fmJwn2vU3GHjhtl+YCQZKVP
 3WHTHrbvr/BTiEujG/ZkRTFdA4OQ9jvzgMICKSBPHLfM436TXqnyxz8oFIlLhovsU9w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789762023;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
 X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=IKdL+LxXETN7ELPYBLVSvJn4gcjoU8QCWLHv7a/84dE=;
 b=sve58DVjKrCeZFC8TSQeuewUvnM5FbDprGgNQYXFD+mrq4maWeNeE7ryfmppjQ7xA9io
 P2emIYaRGwK+E6hDAa+jxQ8LGQf5js/s9y6h+OFk4Y4m50edevxI9XfT/CvUjyFfRRwMd
 Exv1n5LDyyoAYJee7Ue77W23duzahXWXhgI2e66r4XfeAiR23lrvDyFrlxKDOeb6JisRJ
 8O2sJjj710PfKsJIiL7jIFbreqYvwDSGlg3zWULfqNC8GIKQqGYIZjbqKmJHt6ijlMCcQ
 8g/bCJsmQjD6zgfG0fk05fEG9SxejPq6k8PfB6Erf6Gm78xEHeLK4ihVdwDmHDPAYhQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=d5rVXfhn; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=gx4zIse0; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=jorge.ramirez@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=d5rVXfhn; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=gx4zIse0
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 38D6E400F8
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 20:07:02 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68IGo2Ov1483067
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 20:07:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=IKdL+LxXETN
 7ELPYBLVSvJn4gcjoU8QCWLHv7a/84dE=; b=d5rVXfhn0Th0sLtGipaFr8YQPzJ
 +o6+z5ooucUCtUsK6h35AHQ2xF8ZLJVyDMQUNgWsJiRUxJSeS0eqKOIhbtRfVRe0
 4idL+eX5x5k3MCBYt4qOkNSKnXfvgiMtSFsheGoLieLkyH/3kAgX2c2+gRwyx/8z
 bPRPdJ/cUsyeEX60LNahrNQqnmufW6Q2djgjsnhCAqGRK2/K9W2ymR2fjDrgf/Pp
 eFv2Mp6qXXIGFPtIxLZcFLu4hl0+5shfckg7dKRAKxv8HYZ1mgpFxYGiW2X4Vr8q
 NJYmyjzlbm7YGzyUSpjbNMtXCd+6jkUjVMKJq3aCtp+WiB+n6lE6qQ1pElQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gs7jk9bfc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 20:07:01 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-9393ac4961fso171850985a.2
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 13:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789762021; x=1790366821;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IKdL+LxXETN7ELPYBLVSvJn4gcjoU8QCWLHv7a/84dE=;
 b=gx4zIse0Y+nKaeJl0ZLCDRDCwoWWZiIUHquw1+9fxrTm+e6fsmErPiBvnlaienIyk6
 j3VdZmSkf25NqpUYFDJzGQYL4FJU9dhXC/+eoxbi4NfpqOMv8+DExwN1UuEkihp/uOcM
 7X8uHLipROkedm/f9noIiP6DqjyuOGQUwcpZfZMz+idcv46vmlqiN72EkfnjldEAR6FE
 AGffthmsEzyWrg9JwmMKz/4wZZwotWzk09Kh/hVuDf6zz2Y6g3Gt0oa8tEHl4cQWiJVY
 f+cTZN5FD8b/R/pFH073LV6wAboFK1P84kg7oZolDLeDMA7DSVXVNQMu345Bivh8Kjma
 wW+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789762021; x=1790366821;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=IKdL+LxXETN7ELPYBLVSvJn4gcjoU8QCWLHv7a/84dE=;
 b=sg2tq7HCjOvhPSD5abfJwyLJA6nDIHaTbDeZ2ye8uiWicgK8rrmNOha0TnFKIMBX8N
 dm8ikFZ1EfgFGbGM+qJGEXfOs/RNQBSQzItsXQHLBm1n0vld9AliC+7z8OGzBWA5EP2U
 SC+EWZug69TyQwP6WvRWB11yHteGV1A1uQ1p7wYhQytEJQLhSzLkta3yrWLedE0eb2Pf
 kkjN5a2hMXcOdb3ltjd55uVnClCrsiUP7x+rn2F3p1sSf4KbujesTxT5YXZVlKTMWHGv
 wDaAV/1O1A6JZSPa/kLUbQzqkZ251v6YwJTk+qXvhtx/dm/VgoUHSW37GEu770JIm87v
 Di7g==
X-Gm-Message-State: AFuF++mSz/8kScXxXeV79PYkC+Z+p7hu5k13m9HcAM892oReQDZxU42J
 wUs24rfbNMJhhw21xSQ6OLswkPTdsTL3twAlYr45t7Yln50Er1lgtOLZODplwB7A7UkIdoe4q14
 xqy/C98XPsH25nlt7O11B36eax/RG6Dpg3383t1TmTVnuNZyBNTeSzUNAHPhd+nLans+umFE=
X-Gm-Gg: AYBFou2tlP0wP5i+YWuGidNFrq2K6X9Nuaeb6hnVYTyIQnFCL7rPfBhMJnmPZB34mjD
 TZzuOfPBzAGsYhkXOj8/xIpyqSqp4FQC+rybchvEkmNSmplScPxrEPLZL27rbMTkIzB5TjzEpPr
 qZ3AYE/KWrSX9fy37yD1IkmBdqEfOSVV/CE5aosG8TYqSnzjIEQpJL+F3rPvUpLT431xHuX+qdb
 F5+ujNfVzlAsJFXFbDZL+/FMjYE/A1F6xCgjVg9UG2mIyL0vRDhwhOTQFd+ogRGM8wKikK8SSy5
 p3LYx65c1hG4nf4k4gjdVW1UkkuaTB+QfF+3oZ6Bt/dlq16yvi19xk4tMhp45HmmA0xsK6XWnYR
 8b2eSNe0o5ladk0yWW4JF90pI8pUum7AiMXDIZ78yEeB3hVA=
X-Received: by 2002:a05:620a:470e:b0:93b:c6ec:7825 with SMTP id
 af79cd13be357-93bdc9d55e3mr531986385a.47.1789762020713; 
 Fri, 18 Sep 2026 13:07:00 -0700 (PDT)
X-Received: by 2002:a05:620a:470e:b0:93b:c6ec:7825 with SMTP id
 af79cd13be357-93bdc9d55e3mr531980085a.47.1789762020191; 
 Fri, 18 Sep 2026 13:07:00 -0700 (PDT)
Received: from trex (250.red-81-38-139.dynamicip.rima-tde.net. [81.38.139.250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48724596604sm1136798f8f.30.2026.09.18.13.06.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 13:06:59 -0700 (PDT)
From: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
To: jorge.ramirez@oss.qualcomm.com, dlechner@baylibre.com, trini@konsulko.com, 
 jens.wiklander@linaro.org, ilias.apalodimas@linaro.org,
 peng.fan@nxp.com, jh80.chung@samsung.com, tanmay.kathpalia@altera.com,
 neil.armstrong@linaro.org, bhupesh.linux@gmail.com, n-francis@ti.com,
 xypron.glpk@gmx.de, s-vadapalli@ti.com, michal.simek@amd.com,
 jbx6244@gmail.com, marek.vasut+renesas@mailbox.org,
 sumit.garg@oss.qualcomm.com, jens.wiklander@oss.qualcomm.com
Cc: u-boot@lists.u-boot-project.org
Subject: [PATCH v5 6/6] optee: implement the RPMB subsystem interface for UFS
Date: Fri, 18 Sep 2026 22:06:38 +0200
Message-ID: <20260918200641.2286077-7-jorge.ramirez@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260918200641.2286077-1-jorge.ramirez@oss.qualcomm.com>
References: <20260918200641.2286077-1-jorge.ramirez@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: zotK4sawD797qS-GeoxuRIYhThQPXKRA
X-Proofpoint-GUID: zotK4sawD797qS-GeoxuRIYhThQPXKRA
X-Authority-Analysis: v=2.4 cv=FeSiV5+6 c=1 sm=1 tr=0 ts=6aad99e5 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=N2KLPU99T7rsMuN2xAoQUA==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=4OB2SniIEselFtn8B8AA:9 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDI5MCBTYWx0ZWRfX11jfjk0pjZLD
 tMKQLTScTfqJBlvcyyi6DlUG/YuAZRw6PmHG3WbudOmNb5ZsBwxhV4A2zS926jeptOT0YOAbpwh
 6viV61EsUUjdop64mXF/dGL9rjBAYo4rjPrw7IFX9SJV4/d5Ly8r/s49yAwag5wr38OvuoI1iM8
 4nIzIUq5XkbkWO4TNqo2AXxfkS/2RKri3kBnZkux/MpRMLNx83A50BBGjVhHInW6AuVIznFp+7k
 eSg22ufxkwKy3dR5YNkAkFiKOGG7ybYq6HRECDITbmpXkd4t2MiRD+/6Bm2LpKjq+wzNU2agWsQ
 2gVtKlvccuno7zjjQfN3lQphTJVIfHQODdexXYnC+iiR1hNg83Y1kfwybkZ0T3ZDZuDhcIKFqJ7
 6HWTb6ds/NGoxn+HX0z48T9fJgnpILklXXY1DWxlekWsCNHcZyJrl+VM784Qys2+aA2PJJv5tPL
 BZk8yzYoWui9N372Xwg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDI5MCBTYWx0ZWRfX24B4TeynHd2c
 /3pP/mGL2gPH1LI4d4rznGXOUh/xwG5V1WqbmGIUnUKDp3pieflQz/n3Ite5FmPAlQWS1Rtwm/S
 zDJIsW6TF9bHQAodL6vGX9DrNAb1M1A=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_05,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 impostorscore=0
 suspectscore=0 clxscore=1015 spamscore=0 malwarescore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609180290
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

The legacy RPMB supplicant assumes an eMMC device and derives the key
from an eMMC-shaped device ID, so it can never reproduce the key Linux
derives for a UFS device. Secure storage on UFS-only platforms instead
needs the transport-agnostic RPMB subsystem interface, through which the
normal world describes the real RPMB device to OP-TEE.

Add a UFS backend for it so OP-TEE derives a key matching Linux and can
use RPMB secure storage on UFS. eMMC keeps using the legacy interface.

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
---
 drivers/tee/optee/Makefile               |   1 +
 drivers/tee/optee/optee_msg_supplicant.h |   8 ++
 drivers/tee/optee/optee_private.h        |  41 +++++++
 drivers/tee/optee/rpmb_ufs.c             | 141 +++++++++++++++++++++++
 drivers/tee/optee/supplicant.c           |   9 ++
 drivers/ufs/Kconfig                      |   8 ++
 6 files changed, 208 insertions(+)
 create mode 100644 drivers/tee/optee/rpmb_ufs.c

diff --git a/drivers/tee/optee/Makefile b/drivers/tee/optee/Makefile
index d0c7f8dfb12..f2af10999a9 100644
--- a/drivers/tee/optee/Makefile
+++ b/drivers/tee/optee/Makefile
@@ -4,3 +4,4 @@ obj-$(CONFIG_OPTEE) += core.o
 obj-y += supplicant.o
 obj-$(CONFIG_DM_I2C) += i2c.o
 obj-$(CONFIG_SUPPORT_EMMC_RPMB) += rpmb_emmc.o
+obj-$(CONFIG_SUPPORT_UFS_RPMB) += rpmb_ufs.o
diff --git a/drivers/tee/optee/optee_msg_supplicant.h b/drivers/tee/optee/optee_msg_supplicant.h
index 963cfd47824..b720d5d7b3f 100644
--- a/drivers/tee/optee/optee_msg_supplicant.h
+++ b/drivers/tee/optee/optee_msg_supplicant.h
@@ -152,6 +152,14 @@
  */
 #define OPTEE_MSG_RPC_CMD_I2C_TRANSFER 21
 
+#define OPTEE_MSG_RPC_CMD_RPMB_PROBE_RESET	22
+#define OPTEE_MSG_RPC_CMD_RPMB_PROBE_NEXT	23
+#define OPTEE_MSG_RPC_CMD_RPMB_FRAMES		24
+
+#define OPTEE_RPC_SHM_TYPE_APPL		0
+
+#define OPTEE_RPC_RPMB_UFS		1
+
 /*
  * Was OPTEE_MSG_RPC_CMD_SQL_FS, which isn't supported any longer
  */
diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
index 1f07a27ee4b..2888257aefe 100644
--- a/drivers/tee/optee/optee_private.h
+++ b/drivers/tee/optee/optee_private.h
@@ -9,6 +9,17 @@
 #include <tee.h>
 #include <log.h>
 
+#ifdef CONFIG_SUPPORT_UFS_RPMB
+/**
+ * struct optee_private - OP-TEE driver private data
+ * @rpmb_next_region:	next UFS RPMB region to report on PROBE_NEXT
+ * @rpmb_cur_region:	UFS RPMB region selected by the last PROBE_NEXT
+ */
+struct optee_private {
+	unsigned int rpmb_next_region;
+	unsigned int rpmb_cur_region;
+};
+#else
 /**
  * struct optee_private - OP-TEE driver private data
  * @rpmb_mmc:		mmc device for the RPMB partition
@@ -22,6 +33,7 @@ struct optee_private {
 	int rpmb_dev_id;
 	int rpmb_original_part;
 };
+#endif
 
 struct optee_msg_arg;
 
@@ -60,6 +72,35 @@ static inline void optee_suppl_rpmb_release(struct udevice *dev)
 }
 #endif
 
+#ifdef CONFIG_SUPPORT_UFS_RPMB
+void optee_suppl_cmd_rpmb_probe_reset(struct udevice *dev,
+				      struct optee_msg_arg *arg);
+
+void optee_suppl_cmd_rpmb_probe_next(struct udevice *dev,
+				     struct optee_msg_arg *arg);
+
+void optee_suppl_cmd_rpmb_frames(struct udevice *dev,
+				 struct optee_msg_arg *arg);
+#else
+static inline void optee_suppl_cmd_rpmb_probe_reset(struct udevice *dev,
+						    struct optee_msg_arg *arg)
+{
+	arg->ret = TEE_ERROR_NOT_IMPLEMENTED;
+}
+
+static inline void optee_suppl_cmd_rpmb_probe_next(struct udevice *dev,
+						   struct optee_msg_arg *arg)
+{
+	arg->ret = TEE_ERROR_NOT_IMPLEMENTED;
+}
+
+static inline void optee_suppl_cmd_rpmb_frames(struct udevice *dev,
+					       struct optee_msg_arg *arg)
+{
+	arg->ret = TEE_ERROR_NOT_IMPLEMENTED;
+}
+#endif
+
 #ifdef CONFIG_DM_I2C
 /**
  * optee_suppl_cmd_i2c_transfer() - route I2C requests to an I2C chip
diff --git a/drivers/tee/optee/rpmb_ufs.c b/drivers/tee/optee/rpmb_ufs.c
new file mode 100644
index 00000000000..3e54a1a37d7
--- /dev/null
+++ b/drivers/tee/optee/rpmb_ufs.c
@@ -0,0 +1,141 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include <dm.h>
+#include <tee.h>
+#include <ufs.h>
+
+#include "optee_msg.h"
+#include "optee_msg_supplicant.h"
+#include "optee_private.h"
+
+static int optee_rpmb_get_dev(struct udevice **scsi_devp)
+{
+	struct udevice *ufs_dev, *scsi_dev;
+	int ret;
+
+	ret = uclass_get_device(UCLASS_UFS, CONFIG_UFS_RPMB_CONTROLLER,
+				&ufs_dev);
+	if (ret)
+		return ret;
+
+	ret = device_get_child(ufs_dev, 0, &scsi_dev);
+	if (ret)
+		return ret;
+
+	*scsi_devp = scsi_dev;
+
+	return 0;
+}
+
+void optee_suppl_cmd_rpmb_probe_reset(struct udevice *dev,
+				      struct optee_msg_arg *arg)
+{
+	struct optee_private *priv = dev_get_priv(dev);
+
+	if (arg->num_params != 1 ||
+	    arg->params[0].attr != OPTEE_MSG_ATTR_TYPE_VALUE_OUTPUT) {
+		arg->ret = TEE_ERROR_BAD_PARAMETERS;
+		return;
+	}
+
+	priv->rpmb_next_region = 0;
+	priv->rpmb_cur_region = 0;
+
+	arg->params[0].u.value.a = OPTEE_RPC_SHM_TYPE_APPL;
+	arg->ret = TEE_SUCCESS;
+}
+
+void optee_suppl_cmd_rpmb_probe_next(struct udevice *dev,
+				     struct optee_msg_arg *arg)
+{
+	struct optee_private *priv = dev_get_priv(dev);
+	struct udevice *scsi_dev;
+	struct tee_shm *cid_shm;
+	u8 size_mult = 0;
+	u8 rel_wr = 0;
+	void *cid_buf;
+	ulong cid_size;
+	int ret;
+
+	if (arg->num_params != 2 ||
+	    arg->params[0].attr != OPTEE_MSG_ATTR_TYPE_VALUE_OUTPUT ||
+	    arg->params[1].attr != OPTEE_MSG_ATTR_TYPE_RMEM_OUTPUT) {
+		arg->ret = TEE_ERROR_BAD_PARAMETERS;
+		return;
+	}
+
+	cid_shm = (struct tee_shm *)(ulong)arg->params[1].u.rmem.shm_ref;
+	cid_buf = (u8 *)cid_shm->addr + arg->params[1].u.rmem.offs;
+	cid_size = arg->params[1].u.rmem.size;
+	if (cid_size < UFS_RPMB_CID_SIZE) {
+		arg->ret = TEE_ERROR_SHORT_BUFFER;
+		return;
+	}
+
+	if (optee_rpmb_get_dev(&scsi_dev)) {
+		arg->ret = TEE_ERROR_ITEM_NOT_FOUND;
+		return;
+	}
+
+	while (priv->rpmb_next_region < UFS_RPMB_NUM_REGIONS) {
+		unsigned int region = priv->rpmb_next_region++;
+
+		ret = ufs_rpmb_get_region_info(scsi_dev, region, &size_mult,
+					       &rel_wr, cid_buf);
+		if (ret < 0) {
+			arg->ret = TEE_ERROR_GENERIC;
+			return;
+		}
+		if (!ret)
+			continue;
+
+		priv->rpmb_cur_region = region;
+		arg->params[0].u.value.a = OPTEE_RPC_RPMB_UFS;
+		arg->params[0].u.value.b = size_mult;
+		arg->params[0].u.value.c = rel_wr;
+		arg->params[1].u.rmem.size = UFS_RPMB_CID_SIZE;
+		arg->ret = TEE_SUCCESS;
+		return;
+	}
+
+	arg->ret = TEE_ERROR_ITEM_NOT_FOUND;
+}
+
+void optee_suppl_cmd_rpmb_frames(struct udevice *dev,
+				 struct optee_msg_arg *arg)
+{
+	struct optee_private *priv = dev_get_priv(dev);
+	struct tee_shm *req_shm;
+	struct tee_shm *rsp_shm;
+	struct udevice *scsi_dev;
+	void *req_buf;
+	void *rsp_buf;
+	ulong req_size;
+	ulong rsp_size;
+
+	if (arg->num_params != 2 ||
+	    arg->params[0].attr != OPTEE_MSG_ATTR_TYPE_RMEM_INPUT ||
+	    arg->params[1].attr != OPTEE_MSG_ATTR_TYPE_RMEM_OUTPUT) {
+		arg->ret = TEE_ERROR_BAD_PARAMETERS;
+		return;
+	}
+
+	if (optee_rpmb_get_dev(&scsi_dev)) {
+		arg->ret = TEE_ERROR_ITEM_NOT_FOUND;
+		return;
+	}
+
+	req_shm = (struct tee_shm *)(ulong)arg->params[0].u.rmem.shm_ref;
+	req_buf = (u8 *)req_shm->addr + arg->params[0].u.rmem.offs;
+	req_size = arg->params[0].u.rmem.size;
+
+	rsp_shm = (struct tee_shm *)(ulong)arg->params[1].u.rmem.shm_ref;
+	rsp_buf = (u8 *)rsp_shm->addr + arg->params[1].u.rmem.offs;
+	rsp_size = arg->params[1].u.rmem.size;
+
+	if (ufs_rpmb_route_frames(scsi_dev, priv->rpmb_cur_region, req_buf,
+				  req_size, rsp_buf, rsp_size))
+		arg->ret = TEE_ERROR_BAD_PARAMETERS;
+	else
+		arg->ret = TEE_SUCCESS;
+}
diff --git a/drivers/tee/optee/supplicant.c b/drivers/tee/optee/supplicant.c
index 8a426f53ba8..50b780037fb 100644
--- a/drivers/tee/optee/supplicant.c
+++ b/drivers/tee/optee/supplicant.c
@@ -89,6 +89,15 @@ void optee_suppl_cmd(struct udevice *dev, struct tee_shm *shm_arg,
 	case OPTEE_MSG_RPC_CMD_RPMB:
 		optee_suppl_cmd_rpmb(dev, arg);
 		break;
+	case OPTEE_MSG_RPC_CMD_RPMB_PROBE_RESET:
+		optee_suppl_cmd_rpmb_probe_reset(dev, arg);
+		break;
+	case OPTEE_MSG_RPC_CMD_RPMB_PROBE_NEXT:
+		optee_suppl_cmd_rpmb_probe_next(dev, arg);
+		break;
+	case OPTEE_MSG_RPC_CMD_RPMB_FRAMES:
+		optee_suppl_cmd_rpmb_frames(dev, arg);
+		break;
 	case OPTEE_MSG_RPC_CMD_I2C_TRANSFER:
 		optee_suppl_cmd_i2c_transfer(arg);
 		break;
diff --git a/drivers/ufs/Kconfig b/drivers/ufs/Kconfig
index 648b58b46e4..f174ca0841d 100644
--- a/drivers/ufs/Kconfig
+++ b/drivers/ufs/Kconfig
@@ -105,4 +105,12 @@ config SUPPORT_UFS_RPMB
 	  single RPMB transport, so this is mutually exclusive with the eMMC
 	  RPMB supplicant (SUPPORT_EMMC_RPMB).
 
+config UFS_RPMB_CONTROLLER
+	int "UFS controller index used for RPMB"
+	depends on SUPPORT_UFS_RPMB
+	default 0
+	help
+	  Index of the RPMB-owning UFS controller in the UCLASS_UFS device
+	  list. Leave at 0 unless the board has more than one UFS controller.
+
 endmenu
-- 
2.54.0

