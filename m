Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D699FCC6B03
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 10:13:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6F1CF607A0;
	Tue, 13 Oct 2026 10:13:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lG8D30eeoNMp; Tue, 13 Oct 2026 10:13:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7F6A260784
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791886416;
	b=BGtquw6z4V6DiXgrVrVtMGhKH1l40rOnMxu5+hTIl45gfMfxqDJc3H89nCP2uBNVWsYz
	 4luhubghc7DMSE5JkS1c++JXsSutbYt0zxqEapg0YGmHaeXwgkqKuFwp4hNs94EzwQrml
	 BsSjIqzrasdwOX5yJkiwKtrou1Hf6IFzqJIAKJsZ7z3jVqIOnYYPDBSpP6bammXaOTrOt
	 OisQmrcZG8nVwF5cDmkYxT4/H6KhlxtrcolbsJd0SBQd9jAPV0RUq3+ZGQszPZim1nTsJ
	 8n78O1bktTMrgTeEAC6wswO43Xfq1zgYlZRxoq1+CPWdLGgXNCNeCXdNt8uDNI4XWHg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791886416;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=dI/6vwGap5UU14W25XA0yOsKWC/yppcbiSsmfA2JVDw=;
	b=HGFD7r7JmqCycvhdyd+WsmNe2+f7FfUpXGHwI5If2aik+zlvIhKz2Y1F5RVfam1ibM7i
	 tS0jYF24PVqpoP/EVWNBn6ELKwHm4M4ju8miAYwftEXX4K7TnLHc8/4MSVl3re/RRt8cM
	 rRFHoVShpxa85TtY6H5ic/KySGkmGg84qJzaGSpid78ZJdHGpJzW03HqdbdzD/uOGQM8W
	 pZwSQctEZEjPSdQschZs33xlLbALqrDoAQhvo5OwrKdrJvzczHf4AD5IQFrx4On64U+Iv
	 ylGOh0aWSazratfgYqnFvIxYSs8J8nYu8ZQgpXYBDGzT1PCGVNSd9khUWrIscFaEm2g==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791886416;
	bh=dI/6vwGap5UU14W25XA0yOsKWC/yppcbiSsmfA2JVDw=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=rrZoqxteRB7jYv+LcvbLNe7TOuUabAOD3b+9w2iRm1JZNwT15ayr/UV4qMkI9WPdi
	 llj9fMn805RSJc40q9ERdvxA61DslVgjemrCpyOMVHfYwDqU99hptJnRPenJ9lFPfR
	 YgKwZ2UwnT7Opx/YA5OFUJGosD/SYZG4H324NBk0Rmosq8ZKOHmguI7M3eEj3gl6Ck
	 BGamwOBRDF+Ut38XRuz1g+PzRFei9yOYaUne1uzY/V3+yzgc7AA/zbqyyUkdZcNCcv
	 qGsH3CDeWe17drwprhYNhQmht/0sGEmIQ64/4ECkRWY4MJHDkQDPA2xOc5U4DiBxFz
	 CYb4Z1t4hysZg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7F6A260784;
	Tue, 13 Oct 2026 10:13:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id C41E675
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 10:13:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A9CF540277
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 10:13:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dYKxEXVDjO1p for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 10:13:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org E2349401EC
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791886414;
 b=ZqwLPxWEJyt2LOAE7oKfy4F0gI7EndRUEIh96rBpcxC9ER9tD9QCSOuJ3vCYQaKYkIJO
 dw7qBnRJK4zvtEphpuI3frtkniv9g86yxEvvLxzLPRQGxIvMToFuOrbBXuKdMVaiEuTK9
 Ahw9oC9gFTQcNzSp+woNQzbev6daWYUomdeOOa/dBTG3wf2XJv8fEpViQ++IKx2XuUbYk
 K45FAWAvIrZ3GEg3/g6VYmhiTwEBVm9hToJVEnuTPCH23EvSYsftAPQ1wUvHBDGyuv+qD
 zM0AuhF8pizxpGZKrf3ZV9akHCM0MNriKS5UlnYuNmNam5eiLXO0HZczyUvzPLPQ4Aw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791886414;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=dI/6vwGap5UU14W25XA0yOsKWC/yppcbiSsmfA2JVDw=;
 b=LlvKKcmF9nIxj/cGE9vSxQ9bIDXfSV6XyQzZ36obTjLc/NMSwB0aVOC3HYkV9XcQLzFu
 5l6kdRsX05aHhY7hQi9T+MzQUFOBZb/VNvqt+GGzBZCQTAkoML7KcL0gzckdN0KrKj+S9
 0oCwdiLWBXh8tv0efxwialhSF9Q0ut0TCpqygleX7Ne3r2zLd8hhdRbgjNT6XM52Ognla
 OjLqJVrIACOryOiD0tXnWvV6qHjgnrgKOjrQG6G40rJEUXyFl35vf5OX1+FMN+U0+3gGA
 bc7pYRI8FkSA5GlZb4m9oafehTaNDiEQPof6TCACWs06pCRaK3Lpk12eRWFzxUo1jKQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=pEq5h1M9; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=R8lwMUG2; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=pEq5h1M9; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=R8lwMUG2
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E2349401EC
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 10:13:33 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69D80OBT988790
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 10:13:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=dI/6vwGap5UU14W25XA0yO
 sKWC/yppcbiSsmfA2JVDw=; b=pEq5h1M9QDTGde38hnvlHfE+8doYwGFTL3kF6Y
 fKqutrnmLML3tWuvew0wH/TMipRL7SPPe8dOq+oePHxwGSpWR4jI5tr36PibOD9g
 2IOVxQESDYRrblHGoxIX2MtbWzERa15KSFj2tnoXrS2cvCpJnBNTbVvtmKdDmmLV
 VHm2cfJCy1lp+zoaVrfrUxChwoOVKyZTiTu2SBJyHBXT03H+/KxZvW6Z97cAi0FH
 4qZ1NojK0MWVeQDTOpf3mqLjwkYBxwbzKgmUMifzYujwFLouDUfqXRX0onKQv802
 g4vHvQPmpBYmSvlLTRTm44wgDikVn1mFlWnbeI5ufUrBjaKQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h98hcaccm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 10:13:32 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-33c35f5ca6cso6631251eec.1
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 03:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791886412; x=1792491212;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=dI/6vwGap5UU14W25XA0yOsKWC/yppcbiSsmfA2JVDw=;
 b=R8lwMUG2jZKKLxO15ahrdJGUbmpx8dnBNa7VaaSCLSMlEeVHFZERKA/DfIiAU2Vgco
 +MRGEpGVHjNzYQiqg/J0P79SjXp64PuFytzaHBCsA7h0mBLUIEa3KBWoDnl3/i/yRYKc
 MHOhq90x6m9B1YyAS10ju5DezW6thjhA+oJ6vKuVAeGLggzCWZ6qyNFhxH0yIOvNpx1m
 rUXBXrYMEBTQYPjSVCKgvcwwSGMyAnpeRJiq9uZkY3Z9Gm29V6Qc/xFYj80+Ty0qYx87
 sz0BeIFivHK2s16CN6mfwvE2fCZojC2KeT9maY/C5ypeTx6aTt+8Ix9qH2ByVSqtBcGz
 3TaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791886412; x=1792491212;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=dI/6vwGap5UU14W25XA0yOsKWC/yppcbiSsmfA2JVDw=;
 b=XhrMvQpHxAfKKAUy1eCef9Ik/qrB7i3+6R9z/81zE052PPuOVPENj4DYuGKCYTSApk
 4DWzix0bMyJRHSi7i4MNkFAXth9CqPbA4ekgh2ZIOLW4+d1CMiOa16q+Rs6Wq+0EB0Lo
 JeUcYTJbFSYxBGRbWNbEP8n8HqwVYrcRUYYeHJ8XZCxlmS8+XwziHGBhrRHvdHSlkxrd
 NwxNLNnvM0TqLzLb2qqTXtgn8jzK2GAIEFD/mtUfsJn+rPfpvHq7SS7bfR4R1zU/ko0Q
 zoA44sMHZxeeNN2rwiWtmqUhPyBDrixAyZwdOfBEM0UUiE8PkJhp9Lt3CLqXo/3Bif7K
 SYJw==
X-Gm-Message-State: AFq9FYIckAI0ziiPTx6yK2aoy2ymq3bg0IgMR+H76RxCpl9dJZIzRkag
 4QX1wolyH74V5auVAApoGZOzWArkddYVrqKwH79nhpXJcrMw+yTKxsTebyGOLYKLnGV7uBvXn4C
 Yl/ZgCHKmKcZ90wet0V8JKEoy7ltegQNQtYcA4XaFlDZKmFTCDimtNUAIYNdVe/gJZu3dMtg=
X-Gm-Gg: AYBFou1p2Y4xKBplc1wE7q7yAyOXIjL5zH17ozEyRv+bwc2Bl4yFB7wCkMAbFKyYbX3
 eBFGk2sXm8E246+idetemJBbLg0O0ApqgpyFdanLu4ZAiEpIU8w3jett+u1jWepGkcqcKgNz0K6
 rOkpwDY4WMamesrV6hN9rqE0/v/tJER5q/pmOR8T9boOQj9tb613hhJ1A3wYKWtwJ6ZwoMoIBjz
 WcXqdCH4oYbVRT0Pg+5VNfJBcs4tUGii4n3CaISLjql4+9hOJtkzDc3Mqjr5WSh6DGt7ltEXKXA
 tXwtj2UbzPlYQDF8Qs8CqtH3BxNXf+OXJ8muH31ubdQWpY2ZM6Lub70+Sm56uyUoc/2S5vVUqcb
 rWaByLkRQ5GQXQ1Zg8uUjIRg6bysEJDYMPw9gFg1zalLyRhRmpvG2LNanK8ebtpUwvlg8ZqLHFh
 pbO6hm0o2Dg6D2dLzUzAo+o23TbVuz
X-Received: by 2002:a05:7301:470e:b0:35c:73ca:a1e0 with SMTP id
 5a478bee46e88-35c73caae65mr2095358eec.15.1791886411850; 
 Tue, 13 Oct 2026 03:13:31 -0700 (PDT)
X-Received: by 2002:a05:7301:470e:b0:35c:73ca:a1e0 with SMTP id
 5a478bee46e88-35c73caae65mr2095325eec.15.1791886411275; 
 Tue, 13 Oct 2026 03:13:31 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-35a352d4b05sm23497028eec.19.2026.10.13.03.13.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 03:13:30 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Tue, 13 Oct 2026 15:43:27 +0530
Subject: [PATCH v2] arm: dts: talos-evk: Set USB controllers to OTG mode
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261013-talos-otg-v2-1-44a6b51ee9c5@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAEYEzmoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHQUlJIzE
 vPSU3UzU4B8JSMDIzNDA0Nj3ZLEnPxi3fySdN0U0xRLY6M0C2OLRGMloPqCotS0zAqwWdGxtbU
 AULzK1FsAAAA=
X-Change-ID: 20261013-talos-otg-d5d932f838a3
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791886409; l=1554;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=oDaco5dxHaVf1o/0z6SCP6xFuToY5NNGmw9qxfeWYfE=;
 b=lGaVVsEXOYZluh16jtVQHmeK9VOU0HCVE/1/a3JDqHcxXg0dCSV8iY6Oplc7EB4a9ltp9ao9E
 P6O81ucEjBMCCOJkrzj47X8yUUULzKVHbRynjh6x/RGEZLYDhCAsH7W
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA0MCBTYWx0ZWRfX24E7c8TLFzvR
 QbfIqTDNydHWsf2rj9UC9UW08eyB28pupJXqMMu2UMpjGyQjGHcmZKOAbCX23StNF0Z6tNmUrCW
 LsAslwJLqtlDdnOtnLbGr62bXHEe7CEIqUYm0+qv8taM3hkBSfv7+wUSDHusR4alsLzOQzELy5g
 FAPmXkkU749wxq+inBKEmVIKsqr+auyYTyGI0kfBAeM8fm+2wTku1ctnHrN9JBR9TB2Fn+9g7sZ
 5E3m6qqg9zBPL+zJcXEtNsKi2ch69GACB1P6UCf4EdjmxPEArbUdugaR1xz8OH7VsodEqBTommW
 lAamkKmKrRz+yIm7eyTHPYrLSd7n9qVjnl0TU6ZnBhitGbzhWB0yY2ZhY7qKB13dFXfCr5KOQF+
 rWmcbJ8cOQyw+KdaCd6R1NSJ82mAybSRSh1IAIFXSiiBrtbc15+/a1Q3W2iZwiw2TpWNqdhaPkt
 D+QwZPNrHEXLOHJpaDw==
X-Authority-Analysis: v=2.4 cv=VPVIDNPX c=1 sm=1 tr=0 ts=6ace044c cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=fh9ysKhb11-FD4dfF4EA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: u9V90SWFlT7xYdsjJ4WyUadXDMuAJJiF
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA0MCBTYWx0ZWRfX2uX+hBFwodTT
 oj5kEuR8m2r9lTjivSJeeKpW4UHft4qrz2GXaM+WgyTvN1dv4QsFHjnw1I6XU1Wl4nYqLRiHnu1
 C8z0p5spsW+U9P+6mD/NXPGGPgpXGuc=
X-Proofpoint-GUID: u9V90SWFlT7xYdsjJ4WyUadXDMuAJJiF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 spamscore=0
 suspectscore=0 lowpriorityscore=0 adultscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130040
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

Override USB dr_mode to "otg" for both usb_1 and usb_2 nodes to enable
fastboot and USB download functionality in U-Boot.

role-switch-default-mode is set to "host" and usb-role-switch is
enabled. This keeps the controllers declared as dual-role instead of
fixing them to peripheral, so a DTB from this file does not force Linux
into peripheral-only mode if it ever ends up booting from it.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v2:
- dr_mode is changed to "otg" and role-switch-default-mode is set to
  "host" and usb-role-switch is set, so Linux uses host mode
- Link to v1: https://lore.kernel.org/u-boot/20260519-talos_fastboot-v1-1-6908b79ffccc@oss.qualcomm.com/
---
 arch/arm/dts/talos-evk-u-boot.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/dts/talos-evk-u-boot.dtsi b/arch/arm/dts/talos-evk-u-boot.dtsi
new file mode 100644
index 00000000000..aaf04a8f199
--- /dev/null
+++ b/arch/arm/dts/talos-evk-u-boot.dtsi
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+&usb_1 {
+	dr_mode = "otg";
+	usb-role-switch;
+	role-switch-default-mode = "host";
+};
+
+&usb_2 {
+	dr_mode = "otg";
+	usb-role-switch;
+	role-switch-default-mode = "host";
+};

---
base-commit: fed92546960a92177d67c0b8d7b22385f50fed29
change-id: 20261013-talos-otg-d5d932f838a3

Best regards,
-- 
Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

