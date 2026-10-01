Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AE3FCA5FB3
	for <u-boot@archiver.kernel.org>; Thu,  1 Oct 2026 06:57:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C785F60BEB;
	Thu,  1 Oct 2026 06:57:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id II5nKkdhpGJp; Thu,  1 Oct 2026 06:57:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org CD8616081B
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790837841;
	b=EzbDoKuc2MNrYZBZTQ3ZkV03InMisArXVu5sAtHpyIsMUlL8lLCjpd613WJYNCSd6SHr
	 0yly+pyi9P+jy2mJK8Vaz+WMCHGpT5GxhxYQQo/lyMN41mf4PqPhHGWXmVC/TsqXiHAvA
	 xROwO7fkyUNgXnyANnDcV8b0C11wS2201SCJC/6Me+6jz3kLH9L1VDLZGhCP5eTIozIjm
	 YneiRf/CjQvklax+n239zy+Knn8k3IUaQy84Ruh4St75lKUn7W9CkgW2r2ASt9UWtsjKy
	 hsSLTrjNSEr7gHQ3lO9zVWyPXyThfHu6QqxIvNNLEgGjD/VNopdtNid7zHtVdPyZ2Kg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790837841;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Y+ar2FmjzH2dGtsxUYFrGG6cizUgA0nrORN4LkwK1cM=;
	b=YhDMWqGv/R1PHbIjdDDrmQxull2YgEYZj2KB0cj+0+TCA9D4/vQWFonvcwQX/+saPpdh
	 HwlMpHjT0w6ZR5jqtmQLnnAEWX0+LZQ13l+j+QkU0dneXq1EwhcOQfGoa8DDjNNZrstUa
	 JtudpJVd+Z4CpD1whZHu75CDAFo9mzqi12FTTW7Iomf/FAnQb6pUIMElet4vLv5cUZc72
	 kqT2cPKAFEF2XGeV65szZnj6k6bYBy+EmIEld5+EcKrxZQKnmnlhE1rgE2GRTGMvU5YQk
	 UPlnvbqQXlE6NKVkhHnadLI/lhsM21/cIgAGLQqBeQPktJr8CFEKXUbrBkyV8V5Iw6A==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790837840;
	bh=Y+ar2FmjzH2dGtsxUYFrGG6cizUgA0nrORN4LkwK1cM=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=QHXNXZp1XrTManwok3NgEoYIOfttcNDhq7T0WzuW5Iujnlecm6aOh0zrx5awtY05x
	 VwcTSF9cJqSQtXHfitg6DWc1LUcMnpitD0LMyC9+NEPzOj4ElGqN8nk79pz1i9T9SG
	 bNqmiBOdMRHQhmrW9veTFclOt0TVUzpsCAKo/o/U6wmxUJAbEH/LKN7+ot51sojpUR
	 DpKppaiW/ELsQoOy1ij07o5Glj4WkK6y1Lyopq3dC1rVy/LoWV2JcCTb0wDI9QkAyt
	 84E2/tF3jihGZznQxUpLKP7o9SLffiLBasDvfFqSVYVjKAXYggSKHdnLlFk7LfNyYT
	 0NxyDyzybYWgQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CD8616081B;
	Thu,  1 Oct 2026 06:57:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 62F411A6
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 06:57:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 548FF40CE3
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 06:57:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0iHMj8xexpLe for <u-boot@lists.u-boot-project.org>;
 Thu,  1 Oct 2026 06:57:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org BEBBB40CDE
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790837838;
 b=sfq9TDu4yxCLIR8dhzJNQRtsBJ8X5OVVU6CNfhCPZHRc2OvV68VuunZf1Flxn6HjzeRz
 Cx6I8w6kqrJzP0uxh2w1rMIXLS/RGYYQ+NdSY7BDsEf6PbjNG981zkTRSH+3fs9FL0kFX
 UAkhZjUCg1QqFRWtr7Zdiv0prVafmRoicZGyS+plsJnJk/jVKo+02F5ABdaT/WPKzuBxy
 R2npBA5tLtrcFZUVkPAoMxxvNiEyTWB40jssvdgAztt7BWyLKg5hQesrG3E7Y5JSJOEvW
 zs98CuyKfyaSRlxH2e605FEfp5dpthdN23h1gJSM+L2XmW3XUbHGkh16U/yn4ylFLyQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790837838;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
 Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-Spam-Info:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=Y+ar2FmjzH2dGtsxUYFrGG6cizUgA0nrORN4LkwK1cM=;
 b=HwPIa7PE/Zp/YdZWqBLyr/3bw5kRqrIzlbk4g/6werIXQE5IFCuKdqsRCSo+6g1xDcMj
 y1e7xj6ClFcfsfnjBCdllGs6j1vbKQMi+I+HeHn4+3jiTAVJfCd1EHqV6/ASUbZT75J2a
 RD/kH5nDJPxOu1r9ldrJIxVLImzaY1kgG+o1QkWEWrv+zdCDlqmA1kwGlDT6vJst/hHAt
 a7yREUU9sEIUkQ8idovaW3EBzKIOp0Wz/rJyVmCAIP/uhZqhzItB91cJlWN/TnZy+Wh7o
 zOmwytQYij569eA/QY1YqSXLRHoOARomzJRTW9LgMz4kSOFb0bqt023wn2At3lBOT4g==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=adpx86zo; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Yat5ybHt; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=sumit.dhami@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=adpx86zo; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Yat5ybHt
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BEBBB40CDE
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 06:57:17 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6915GP4w1954284
 for <u-boot@lists.u-boot-project.org>; Thu, 1 Oct 2026 06:57:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=Y+ar2FmjzH2dGtsxUYFrGG6cizUgA0nrORN
 4LkwK1cM=; b=adpx86zo5bUaahR46RXTH5ebSN5N9/VG6Wtp5wAB97t1hWS//L+
 jstzmC5LNmPb/D9pQR2D/ai5Qwxnx4PlCrNJMsWcL3IUucUNeHsAzlr2tEShTbGl
 CAVbjlB0KinPEhBlMKT85RSozTg1QSMTD0n9WeNpFgwm0nVzyMPFczuxG7Pq6cbe
 7RDabXiGY1OC0cFEH2B8Dp/6AmRv/qhViF0aCIQoA924EW6lRt3NOoomk/WOKqlz
 ZE83h0u2GPrpVYONyGS3TMUy9AdVMvMovQK6dUMf5JlwQBjuglv5bRf6+dg3L/eq
 d9llgo/ry0hbiCvoYRwXDCiysCYSNaU9wVA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h1h7nrbn5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 01 Oct 2026 06:57:16 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-30f1b904861so8322017eec.0
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 23:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790837835; x=1791442635;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Y+ar2FmjzH2dGtsxUYFrGG6cizUgA0nrORN4LkwK1cM=;
 b=Yat5ybHtxLstYT6TG/dOQpXGO4us6aunlQOwETKmdLmgKD68wV7GIAf/QInvKP05Tx
 Zqd3hi2R/SJ6fYSpFmxt2lRNhez3C/ePc80aqEURSQxtlBRi+KkGibxQHT1ajzNzU8OU
 x1AjMbkIaCpp0cRs43FCZwzF+njLafFgUPknDozA6GOZnR5wa6EH6WjH5M8GlFjjZOm4
 4tPMV/MnIcSzMEBVHBYXqaOBv6FSg4ncCzBY3N4TAteh5hRZ545BejrfKgmRRDyieeqf
 dBM7cIwdBg19tQxXM7r4uiNUebh3xnyNqDrJDVxSXLoNa34pKdcRgblc+P0stnCxBpGT
 AOLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790837835; x=1791442635;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Y+ar2FmjzH2dGtsxUYFrGG6cizUgA0nrORN4LkwK1cM=;
 b=ovKZRkOJR+szBcUArB2njqVs7zn20/HMsxsxz9Bh3EQdgXf8i82OnVmOPBnuPkgcUo
 ifJSKmvcy+6O/kq4eK6QJMdK9mVxkDO9xd5Vv9ublGI2VcdKCwgx3LN05t5EvO83WV5z
 O7iIXOVL5TM3yAJm6hHUfqFLBST+JKZur8Dxa1K8T9pi2xR5vDk92d48NF3o2GONKrUS
 c/nbMii6mkyS6ykwrJL0uVCyHajCr0ULZ2eEXHEd71TGkqYtoWTQLXoP4r4wvUzyQNZi
 X4uijpVihO7RnYG+zO8xQBlDoZ3mzZNqus/dmAQA6dcRwPrSXhAIHYa1t+oDzvINjldp
 uV6Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBwVZj1tMa3oDuh0DgiY3AS93MUGi6lTXR6LA380B49wm2KoaqkkutkJpHvyr6V5mwesgDKR74c=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJt3IlIlrfQccro1bwwTlwbVwF8zGnWeIPKSoXXPdv8QDudq2v0
 hTzoupuCcmr06Zr4sY+UEYqIxbKiV5whrtQzvjEChO8vNT1cOedkmV6HkAOi5SSFGcr2Am4xaVA
 cNR063qxe0ERiodcN2ShY0uTTfZfPOr9MUQrDo9fQVHn30STqQWbmxvImKS8KaDBhZRmcfumWw4
 i3KjQ=
X-Gm-Gg: AYBFou3XnqgwkpzjXfbhwskY4zoNi4on1aXsk5749fDE9ALrU7nxT9FOL6BFWq4kvoi
 wTVMjEIoWhwDDTPh786LzuGeiWEPTjuewMqpuA0DmIve4olbvUSNDv18675CuD+LYfljPrzePKN
 qseXQbC17Pwqg668dhqmSMV0UJQoCGRQbdnn4i5WE9TP8OMTM5A8Dagw2uvkWGRhtprB0SyQxis
 twmGeU3ZCRGplbjhrk8XGW9emxxnQJDbrZjuJuiEFrOat0cLESaPu8Mvl72e326uLSyMySeoUhV
 nsSGDP69WqxiOp++F8wJX8kMkzn3x1AInC3BqA2ToeNlaN6kOns70AzHtRJbhxqy8G6oMZNMLRY
 pBRf67TyPhn7Xj6AGzWD2J6rFM+UPMrCHsTPu1oYaRZwk4VQZZ881rtrTWx6Ffu25V9rly4ugAy
 tZOPporWUHO9a79HE=
X-Received: by 2002:a05:7301:19a7:b0:34b:7c9c:9a71 with SMTP id
 5a478bee46e88-34cd9170685mr5768981eec.1.1790837835092; 
 Wed, 30 Sep 2026 23:57:15 -0700 (PDT)
X-Received: by 2002:a05:7301:19a7:b0:34b:7c9c:9a71 with SMTP id
 5a478bee46e88-34cd9170685mr5768945eec.1.1790837834516; 
 Wed, 30 Sep 2026 23:57:14 -0700 (PDT)
Received: from hu-sdhami-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34db4926277sm5327122eec.25.2026.09.30.23.57.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 23:57:14 -0700 (PDT)
From: Sumit Singh Dhami <sumit.dhami@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org,
 marek.vasut+renesas@mailbox.org, quentin.schulz@cherry.de,
 jbx6244@gmail.com, Michael.Srba@seznam.cz,
 aswin.murugan@oss.qualcomm.com, balaji.selvanathan@oss.qualcomm.com,
 sjg@chromium.org, u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Cc: Sumit Singh Dhami <sumit.dhami@oss.qualcomm.com>
Subject: [PATCH v2] mach-snapdragon: Kconfig: fix SYS_MALLOC_LEN regression
Date: Thu,  1 Oct 2026 12:25:59 +0530
Message-ID: <20261001065559.1432598-1-sumit.dhami@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=OI6yTiaB c=1 sm=1 tr=0 ts=6abe044c cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=_fEmJGKquHCWhU2f3w4A:9 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDAyNyBTYWx0ZWRfXwlnVVHvwxBYQ
 cY0qOd5mJVpXOLbg11RgxYRyh+MlsKqTB9tKFAxtGKmvsty63eMaSzC50/CY+C5UbSyJPdvRA1V
 z/RUad0DFlml80EawoSxk3JjGe9AWQw=
X-Proofpoint-ORIG-GUID: u75mf-6Nmj2tDn0b6xVa5BgX3rGkmHDW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDAyNyBTYWx0ZWRfXxNbN9LCn8bw0
 iFb/YFISu7/UHf4RyNMdHMvWuMHxvEFVeK6bTKpPV1Udbf1cmjgTXgwK1ThTrxMq6WJKjIJPZKV
 mvUluh8vsn2794Jda1kZDOvT3D8V4B/DYLr8IvEGGrEgUIGLifrHvzfRRqkN9YEKgWsQr/tQXUF
 W+yxdxRtXIuur1GBPBUJUzo0EhN3VVLC+SJhkZYCqu/GMI+8mH3c8QCV+SX51sgaHISoBfyY3Hs
 ztcgWwewAwGrr/d44zr2VxhDfukbLKayeb79LNMlRKE4WMwbRa/e/sKuZpzeea/QioNEXd+RlG4
 MWaV6H5ho6lb3k3coB+A0CrkHQXtDYg5s8RAbbrFCh01jiU9Ijf85iiwSzKl5Ld6HD34O+6MMWF
 UkAHm7vFX4DPlfT7F+bylmQFx9h8vT40Q9sk0c/GnZfqxCgJSkKD4pOKMa1ug4sn8LOKzG1/ifJ
 /2NJuQYcS3EhZbJ5rZQ==
X-Proofpoint-GUID: u75mf-6Nmj2tDn0b6xVa5BgX3rGkmHDW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 adultscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 spamscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010027
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

Set the Snapdragon default for SYS_MALLOC_LEN to 0x10000000
at the symbol's primary Kconfig definition.

The previous duplicate-removal change retains the smaller
0x800000 default, which causes large image transfers via fastboot
to fail with error: "Malloc failed for: CHUNK_TYPE_RAW"

Fixes: d3463a9ffcc6 ("mach-snapdragon: Kconfig: fix duplicate SYS_MALLOC_LEN")
Signed-off-by: Sumit Singh Dhami <sumit.dhami@oss.qualcomm.com>
---
Changes in v2:
- Move the Snagdragon-specific default to the primary SYS_MALLOC_LEN definition
- Add a "fixes" tag
- Link to v1: https://lore.kernel.org/u-boot/20260930083339.351584-1-sumit.dhami@oss.qualcomm.com/T/#t
---
 Kconfig                          | 1 +
 arch/arm/mach-snapdragon/Kconfig | 3 ---
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/Kconfig b/Kconfig
index 67ce72d4270..a9b9c9bba70 100644
--- a/Kconfig
+++ b/Kconfig
@@ -328,6 +328,7 @@ config SYS_MALLOC_LEN
 	default 0x4020000 if SUNXI_MINIMUM_DRAM_MB >= 256
 	default 0x220000 if SUNXI_MINIMUM_DRAM_MB >= 64
 	default 0x120000 if SUNXI_MINIMUM_DRAM_MB >= 32
+	default 0x10000000 if ARCH_SNAPDRAGON
 	default 0x400000
 	help
 	  This defines memory to be allocated for Dynamic allocation
diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdragon/Kconfig
index 7f3af9b4364..2433a0a0636 100644
--- a/arch/arm/mach-snapdragon/Kconfig
+++ b/arch/arm/mach-snapdragon/Kconfig
@@ -20,9 +20,6 @@ config SPL_SYS_MALLOC_F
 config SPL_SYS_MALLOC_F_LEN
 	default 0x2000
 
-config SYS_MALLOC_LEN
-	default 0x800000
-
 config LNX_KRNL_IMG_TEXT_OFFSET_BASE
 	default 0x80000000
 
-- 
Best regards,
Sumit Singh Dhami

