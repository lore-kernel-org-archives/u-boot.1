Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D89EFCA9ED5
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 05:08:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7F77480CD9;
	Mon, 12 Oct 2026 05:08:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RfnZTcI-2tW8; Mon, 12 Oct 2026 05:08:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 09A6380C12
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791781722;
	b=gUGBHUxYW+QObHCDO8ADFmbe7BQXbICDC5pf5WLIn/N5xbNsyOP0aGlp5rtmxlDgRE7a
	 SQzqBdMXnicX7WCv6V0IpuNPar16GPfHqtn5CyPwN7Ruh+hunJdIJSvHSKl1N1ip5UgFv
	 Z3W6iylMLMbCJj0d1LOo8ej4hNTXpej9BW0jA3/j4pY5SlN4xqTtntbhththMO0iKXhmX
	 wMpJp6qpHxSHYB28c5u7GgqsQxG79EbNESH1WRH9X95coMPpNWb0WxmA4sW/Hgoe/ffYu
	 YFLycXOaeaY6O+ygKpHlsxmu/GffWH2oB41okS3NaYxWcfQWzArcg2+xzHNyEM34oiQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791781722;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=WzEEqXvcDEXkxzxjt415fl9Jwm5rPrXMAK30/rgoVwU=;
	b=gRMuqh4yJIj+Zd79+U80gTQGnDRVyDNZcERBz/gI3w1s5rM+RzlAWSX3kO5FGGFO3qH0
	 ZSWz+ij141NMwb9qEr0cdU7ArsIh7DG0FQAjidPxIF0rHZRf2zaoM2wb2R2z64eyoBR8j
	 hVCbtnYgUggnwfsjrILDTIM6pXnZcjjCLzAOALymmDNqVWJFvbFX6McyH/evQAA9if8d0
	 vhFEHSYYK+hYOwnwBuaOOb8umYAYD58zpTrlOuMiy3i752pocyWKd4I/aIyWb7d52t2RD
	 Rl77vCZJoFPKBjvMsvh8gJ7b4vbDSk3fFcYe9Z+LdQzTSYGORU//bHvVA2XRIeERiGQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791781722;
	bh=WzEEqXvcDEXkxzxjt415fl9Jwm5rPrXMAK30/rgoVwU=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=J4BnRIkZ4BuzOeUnWBZXaGxIjMSKVKt5+NZvzOdXaelxxOItAHUdSnDJM/wdikpGD
	 AMqp7NTOErnyLp2UJVzcsKeI7IuYx038gzKKRv7L+k7bbVeiUpXnooHj4Y8yQe9eVP
	 I5jiKcrX4HWdTtaIMt66/JBMEZC3KqW6sn+t8BxefYWi0EJG/NwsACHEzxOHYTrWcG
	 6QdnbRM0xqqp9mTxzq63rKiEmdOj69MaWw2gDyo/SsAwmhFvklIh8FGMevkOWucuLu
	 5BGOY2ydCS/YEHeY5fQVjE0/PXVLMdEt45cvtL3V7whPZtGBNWywDXv0eVkED2ppKS
	 4Gd/Xnt6RMe0w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 09A6380C12;
	Mon, 12 Oct 2026 05:08:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 87086194
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 05:08:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 849A04056A
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 05:08:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id it6mXOJoPBsQ for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 05:08:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org ACB444052B
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791781719;
 b=iiqfsLr/SN1nhmSREziYe31I3YZMbozdCYC2pFezWvIm+92wuVa/n+pjSnJVymSEai8f
 nB3yXvDBiGCpZYrGiwSyIXqn8DpdTnWj5eMkvf3cXEDtU4Ke7ijyVuwafohydWwL1CNg0
 TpXpF4+33gWeV4k7AwEXQamUbDq2jopZ6JqgUKbIG1evQvklh62UPpkZppzQjboflYLPs
 YfSanyapLWNmbFRZqP7C+9AxIou6LMvHOetc6q/RfVLk3L/tFUAETN48yJpc9eAJ/LMAT
 etBwE2q+xpdsjdA70gf8VPZCyWdSFEEAKSfR+kgZqPjB1r9pbWsqCpgMhDxCSbwUA+A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791781719;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Authority-Analysis:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=WzEEqXvcDEXkxzxjt415fl9Jwm5rPrXMAK30/rgoVwU=;
 b=mIxv1mZbhb3jbZtqCiFR0x54b5czczBRWD+RufZrXkeecPhUWwACF8O+x+dRGORzISd9
 rRnXZ8MjRQB7L5I9ikd68zUKzGtzzuxr/ftkcOIWNeOjBW5UcPyS7y8pgOQaIy3ge5Vxo
 queuH5V2q+mS+aVHrz3NSN3mSPVuZ5VFFX6N7gp1fw2S/LNJ/ENCPKBHrXTAhTLK7WhPa
 xAdCHERuDjJCRW/HY42yP3ahqOvaa5vYHIwtZASqd/q0bQu0aApp7lhEW3QXIZt2j4KGn
 gB3cq/gB/MhdUNWTz67uPIaUtvLW2xAJ/M7uwawE2nPZnTyJuW7i/oYSsZ7gW3uhwTw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=nSYmP9y5; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=NQIg1sV+; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=abhilash.v@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=nSYmP9y5; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=NQIg1sV+
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id ACB444052B
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 05:08:39 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69C55hBV2355038
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 05:08:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=WzEEqXvcDEXkxzxjt415fl9Jwm5rPrXMAK3
 0/rgoVwU=; b=nSYmP9y5sZDPnnF5gKAdJxCsDm+HBhguNjxRji+bZvFiayTOe5P
 BtCC4giYvMUWLUOi0LMgZ/diHUewDJpxnF02ZyAVa3UyXHjTOpwWH/b8AEUgJmB7
 nQ5Fw2vDhGizWqZ8vC5yD9dNTxxadx6JDhQiRxQnR8dFiIAEqzIwd9M9js8G07fZ
 kt8aE3hVL+fKlzVZopa7rsx3oEfKPgY3eE/rDb1Q1Cpcx5yHeZ6syc4eMTIcbbUl
 MS1VGYWQt3pK3Qj3WCksD+RD9zWXz1KAvLmwem2IC72kb/depL4C6TbZVH/G2fag
 ki5RpAht41nYsm5Nf0gyOfZ43fy9WMt4izA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h7cascy4n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 05:08:38 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-359d11365bfso2684085eec.1
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791781718; x=1792386518;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=WzEEqXvcDEXkxzxjt415fl9Jwm5rPrXMAK30/rgoVwU=;
 b=NQIg1sV+VyYTRi4zJY/RD/OBF8yBdYSrImbcMbBuT63v3uLHtqu5OENyxAkS/SC2eR
 /QLoBD4EMzqGkQEiinx7Rry0ojPkG/40FmzVkd0fDDWX2c79CsICVqDywrFzXD0BGak7
 UIfwP/R7S9ZwORan0Rpo6tdTEPzAci6wJNqqjt3oC1aHVpUCyAQOS1m6P6hT8oS1KBBL
 ZBnIWLQIyj/3ob16bxCOW+sg3r0BfERmP6zFFyS4BRwaX63Ifapmcke0r9bFtTAM+g60
 2NUS8GJcOiOfKOTQGZezPJCz81KPWTzjVmkTDAuMCg/IOllGuIj8e2b2PiG6PFvJwqQm
 8/Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791781718; x=1792386518;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=WzEEqXvcDEXkxzxjt415fl9Jwm5rPrXMAK30/rgoVwU=;
 b=HE0jv6isiZjTUzmOp4/j/X+f7iuA/F1BeK/hDLLYPLivh6LxSh25wyhDK2HnJF7UyU
 PNqq/cBaNy8R972PBRwtnpiSLgVZQRezyJ4W5IkCx4tTyW2iyq7al0iEDaZvqZ5I7yP6
 C94mETa7geBjOQyZ6+FHUkwOPnpgGN5+DH+7GI1bOUJHQBaZlAw4mOAH0B7kLajfRCho
 TSkW1sgDU7iTpUzDpmWB9lvL/GKIqm2JU175wbRHqpZfvkIanjp4xSBNGtiT4xoUvmc4
 tLbl2LgxSe7m9nyxA39n/KFkjHQJLlhDKFxviX+GB6Zh+baY5EvPScWnd40WM4YT7RqP
 InSw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzhl3judlWaFVG2oGsocvNIs9vANcpWyYwHD7NKumVWzvYTGA0he7LC5sazW9BnY1sKTktTmmc=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLxhCbYo7Ztsk2R722xIh2iqMUERJ0IJeuzrDDT5gsyu9OPrG6L
 e35jXvYYhZ6aArkTojDwg1Nft89iY7JYzu1A1ryzJsRA/XtTa2crntbPHhfnDgmwnQinoDC3MET
 V+Sxu8vpAOwpqjzpdwyKz7FJzDP3kCZ7kXZybRkbV1S74x3xPq+ihzXw//WS0PZw3fXWTHXw=
X-Gm-Gg: AYBFou3JZqz4bFh+s/yMDrEe+jXgeMp6Bdc6lbgbt6cw8LZaeCXLEnzRm0fNd2mHPET
 koKuz7J+h9fGdGR4zwEUt2G+V3k3gLzcDaxENi/xfzz7dTERYSAiimiDnUp9EFv/3oa7SjErGmm
 eYce8DtZoboRL+50YskcZI8V2jWAAKTFqu9P4a8L6llG8MWYS1hTlD0FDtLvi78Db0LyfsNKVam
 KNfvzECwILFtM1X1G9DqTnBrogrIZ/ytZuLboyyT/f5MQGAryXL6VwyqzfcMHSM+2rPLI4RAhNZ
 lgvHp1QEOZ57fcQsvQsrW9q43BbUzt4g5tMBDngCllKnE16aB4pKwKMxXVrQ4cRZ7jrs+x5G9fQ
 YojkEsGPZTgYBf6yD/+rYD6u+E1n05VRmEjkVsLyF+4b6nlM=
X-Received: by 2002:a05:7301:1826:b0:359:866d:5bea with SMTP id
 5a478bee46e88-359866d78a0mr5196825eec.21.1791781717704; 
 Sun, 11 Oct 2026 22:08:37 -0700 (PDT)
X-Received: by 2002:a05:7301:1826:b0:359:866d:5bea with SMTP id
 5a478bee46e88-359866d78a0mr5196794eec.21.1791781717099; 
 Sun, 11 Oct 2026 22:08:37 -0700 (PDT)
Received: from hu-abhiv-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537cb2954bsm30362095eec.26.2026.10.11.22.08.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2026 22:08:36 -0700 (PDT)
From: Abhilash V <abhilash.v@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org,
 aswin.murugan@oss.qualcomm.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, lukma@nabladev.com,
 abhilash.v@oss.qualcomm.com, u-boot@lists.u-boot-project.org,
 u-boot-qcom@groups.io
Subject: [PATCH v1 0/3] arm: qcom: shikra: add SPL SD-card boot support
Date: Sun, 11 Oct 2026 22:08:30 -0700
Message-Id: <20261012050833.1554624-1-abhilash.v@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDAyMCBTYWx0ZWRfX+Ml3ypDyKH06
 dIFJUGU4oig0vqCNG1s//IoHQiq1xN0YK1faHvHTWwAcoOedOAEEgds+TjjGx/5DPEj9OZtSy9c
 lfIhQbIXM7O4bTXHupmQxNWz1rHu0M4=
X-Proofpoint-ORIG-GUID: tHQvaAGEIPtCVROt80uZGJo75SMpeVU1
X-Proofpoint-GUID: tHQvaAGEIPtCVROt80uZGJo75SMpeVU1
X-Authority-Analysis: v=2.4 cv=eMWGH3p1 c=1 sm=1 tr=0 ts=6acc6b56 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=ZFy_JGi008fR3e2gkXAA:9 a=zgiPjhLxNE0A:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDAyMCBTYWx0ZWRfX6ouhhqogtcQQ
 lJEBD3QAPRV4IVgXKMJh67ZuxL2lhm/E7hUjVGP+6SbUqRz7eRrX9z2MJjCLUDCmUv9hzfUT6Ik
 OhmcxFUocw6v3s3q9cN9Pp+fh4yhJyYIZCrBkiotw6yqnbr6da7KsmTtMUt1MlD2BDyv7+2s/Rg
 KAbhAV7o+AM4yL2PUIzc9WrZADkIyWTyOQPANmk97wPtx5mVpWQqYHGfY5W+B8xtOky52ArBJGL
 6XpVDsOX7NHXZ40y0vaS0XZOjffR1OijjD5e4O+3UCLtWoRZNmliuKf2M6+3/1DpKrh9SK1yUlx
 I9t2XMPPt0x7io1ggqTFTtdKDgjTdhWFmyrX799dG6JX0ADGj6YJ73U29Q8jDHRXRVChCuiL5jd
 /z5fCYy2Mixb3Tg9oXs/O8a61H8ytIz3jCajyqjlGzppJNeTjR9nHZchz2/0VVEDCHE8TV8eoo1
 dRkyxf3u+PobEGF0IvA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_02,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 phishscore=0 clxscore=1015 impostorscore=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610120020
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

  Enable booting the Shikra CQS EVK from a removable SD card in SPL.

  Add the required SDHC2 device-tree support and select the eMMC or SD
  boot device. Update clock handling so only the PLLs required by the 
  selected clock source are enabled during early boot.

  Depends on:
  https://lore.kernel.org/u-boot/20261008094912.419090-1-abhilash.v@oss.qualcomm.com/

Abhilash V (3):
  arm: dts: shikra: enable SPL SD card boot
  board: shikra: select SPL MMC boot source
  clk: qcom: shikra: gate PLLs by clock source

 arch/arm/dts/shikra-cqs-evk-u-boot.dtsi | 19 +++++
 arch/arm/dts/shikra-cqs-evk.dts         | 14 ++++
 board/qualcomm/shikra/spl-shikra.c      | 99 +++++++++++++++----------
 drivers/clk/qcom/clock-shikra.c         |  7 +-
 4 files changed, 98 insertions(+), 41 deletions(-)

-- 
2.34.1

