Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF914606CD49
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 16:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ndHXw9TB;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UPOlC77k;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Sof6g/89
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8A22360ACA;
	Wed, 21 Oct 2026 16:19:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uP7KFV5Ok3ql; Wed, 21 Oct 2026 16:19:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C2B5460ACD
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792599542;
	b=f455bfzmBL9H3JvLQYHnseE0XRkqZ3Bi5hsbPeEUsQXwjyaAfrORquuRROi82QWEELlu
	 MfgEuUsfkCT5g7RO6FVdQ/hJLrnGsAykt/fM8USuKjOkbb857RyXpV2wuicpRH2r1sNRu
	 FVY1wlGS/xj2J/+EthEyQuCVR2Z8Kp2HZ/APLthMtCMreshLWgfBjUQP1X6gJtt6uYIFb
	 vFG199nwqx5iQUiMnEs3OEgRz4KJ3BXbT1nG0oxXnEMpKb7tA42OGGoVsHbJi90qoUbJC
	 9B5uorYsrWLH7lhqFJLCcqZ6cSQZkmHelagYoNVgV//G32jPwORRzqdW6xfF+A2Ob3g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792599542;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=/RwD1wksNx50hyqO8u8SKbe32tt15/ObUf2DLyt6cHg=;
	b=MdX6v1d1nHmw7/83pTZ+TAMzBxV86oDQm2ViEyUNGWQxrtSJdoZ5WGV8WWPCZjldGTSs
	 j4mE/JObPeCt4E1J3QSOJ6GapXoRjhKAGSRRPK1/5J8pRajmtV5m0rtP/lt0kHsdt3XMR
	 LCzZRgGDaRJcTgPYuczOli2rW4Ydc/X3HnHnPi2+0e11vq8a9ULoPBm6V0tH8tIBc4Q/g
	 mqMDvOegjoi1MVhxY3+iS896wC37uAzwh7tre50zzrIu+s3MBlMYss/qGwaJClvmtGvt/
	 ynp82hhjkYMTgTqPD4gc+A+P6zAV6zn40Xx1q639l0sUdEgLUXJ7pAI5jAvadAbDhcw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792599542;
	bh=/RwD1wksNx50hyqO8u8SKbe32tt15/ObUf2DLyt6cHg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ndHXw9TBzSjv3AMIihPWpbDievBILGAyr6XkuavwS++uVXWbhYUouYIJ5yAWl0rem
	 usG/hZbnSzUQmNFOAQlh1zuv4/3mk1CWW8e4moEVire/QEu/MmgEFjDhZuZtwiPzxx
	 5I/m4aEvhvsPayRJHAz8nmPeWKo+/UwhLBb+i8an9f4utA/NaCLHY4lH36CFcTLfgS
	 s7XU6YdEvZujRNHf0Nlqyn15ahYkO36nE4W3zV56LD+3bxRdqHK7yO8Jy3W5a4EpfY
	 ferfpvaOdkN9td7ARFhMr1/McfzTjkBBz6Qkchqcc1/P3j5lOK1cDKg3kV4pm4tWTR
	 xKDrtLMrff4EA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C2B5460ACD;
	Wed, 21 Oct 2026 16:19:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 13ACE1E11
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:19:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 056AE4039F
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:19:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id f0I9wcCLgC3F for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 16:19:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 51AEA40077
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792599541;
 b=U2w+iLaAvcIwgmevSM05q5U5PmTOmVDUbu5DOHuhHvwbjFmHVnur+lXI/rySKrpIUMco
 xDeGmd2vwi1uvJNPAhRYDXjnmXD1pcCIgAHArNmdxfBzYbINLN48yZbv/XndKl472yUoi
 R9x+jLG+hTPyOJkRnoQyJ/An/wTMQUjKWXa6uHiP9jHrKYqgBZlHVuP4fAuLBss0iYwW9
 5CrGpdOcXH0NtHC3NhHif4QBzzzq+eb0KeUtUcgIPpVAA04lcvsetHSsqmu8SSTjqHjWf
 8IwexK4ZVRcVhmy6RNFoWpM6hflqAHK8HwhV9m2c6/WwA48ioUzNKaRpafY5V/LrqYQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792599541;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=/RwD1wksNx50hyqO8u8SKbe32tt15/ObUf2DLyt6cHg=;
 b=qJi4cS77BKVQ7ffOMELHFRXtBWdsKgxZKPMbB1wn9cMedvQPSqDtmSKV1VUw402HDCFR
 8slhmtXw761GRhycCS9fKd7ptMH0s1en8lYKPMM1l02gB0R+2P1XTwgAF+zySWNDnRSpx
 QFPbjJmEk0noev4giNTCy7sVC/MympfQzqNg1P0RrNXTwR1R57GMYDBLJ0J7e15nv+nmh
 zwuQ8smMgPH/unLygW8WsjyIwPnUHHG90/NkWMH4eG5ebfPyyGTLVRzg6s2dAVq/ZVUJh
 uPuvQFl1xhmPVL3PSraA4fx4CsKI1mn2vT1d5kXpYuJf2zXjQ2ieOunC15tG6QwlGXQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=UPOlC77k; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b="Sof6g/89"; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=UPOlC77k; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Sof6g/89
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 51AEA40077
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:19:01 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LFU02O3726130
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:19:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /RwD1wksNx50hyqO8u8SKbe32tt15/ObUf2DLyt6cHg=; b=UPOlC77k9QheIAZ7
 R0fu7AjGNCHiyXUaMz5oe9ymBuqN2JVfE2RHJ06MjHUSbBak1sXYV5ThOax3EHXE
 dNUuAYJGXqId6z3Yw0IQOiFJ3GQaxGoL/X6uRZcbNKOc6Iv2phmCuUMTbiDgOtIv
 X8lNQtqpBClNfKdgcItP1/QfHBc7qAobirmSDWrOQ+GZDbeurfIZXfOsixt9y49d
 42j1Um5oioim1rlguKMd+AjDdMoNOjdalbtHeqnn77p1UMRTxStG4BpfWJfAIQGE
 HSTuN6Sjfa5yTWv333+Q8K1jE3m8lpiG8O+535hMYCnUgDLARKzUNy2Ca4KeZeLS
 rf29tg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hesy7a146-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:19:00 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-36803927a49so1365214eec.1
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 09:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792599540; x=1793204340;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/RwD1wksNx50hyqO8u8SKbe32tt15/ObUf2DLyt6cHg=;
 b=Sof6g/899uMyzDwr25WOGPQrCFGRzcDsFUUun6VWkIfOYcGb75UUxwu5qD2QhKqZjj
 uSBO+fcj6rrRJteJxz0qx/qfGvTrjkH9gi6/FUPNROBfqSK/+GMNlaTh3Q/gEut2w7Kp
 +W919b1ZNOi8mpxJt3jstPXTW/w+h4dxbgk7DpbpeSbzq78OE/4BwAWZtDfuHgEsIXaC
 d1yu9d6oo36t10CAsoX0i4B2tYvhtpI5P1GmOnFU/aI5ROdVRB/JvhaXw+l3SLmXLygv
 053SnxIBQIg9n8eP7KQL1hoku4waffiEyjPfyWWLw7waV7JTkguWuyxi388K/RgLelYV
 vSSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792599540; x=1793204340;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/RwD1wksNx50hyqO8u8SKbe32tt15/ObUf2DLyt6cHg=;
 b=HJ0A3sPhTtFFHsBXNlGFnVh93LpsbfnboO6V20XzkXGC2j2Thpw996p6Y/s5IKou9B
 5iof71LKrxx1cS2qs5jmJVxIurJAYjOg8fk6KigNanj20DtyZaXJMSS/MykTdb9GNuIw
 9CxPV3coF0q+3EjSqvKX9PcgLT2zzQJ/aoOmJdEqeopKgTpenh2F4Cjlw0u0ct4EgtGP
 TiqU5xg3fO16QSjFMBES9COs5DtW3wyoINILusgefxJuYLw9i5D+0YbfV09dCftFID2R
 v84jyZh0iX9YUlDW7fOXLbW545OapEf8wfZS+FjDXTulD3fAWqOm3VNf/p7e7nGJKy4V
 DUNw==
X-Gm-Message-State: AFq9FYIRqPNaCztjWVVqdI1CzzSBBcCxe1HeVyRb9zG97x7uTvgrDP2o
 vgXEPx72XutQBpvjuv4aP0K4d6G34Ie4cdm761A9MZfg09AxZmgXBKaCu1TD1rkbtDg70ZqwpWj
 hugRR7qDZonXV11Fr+0NF2ZbWmTjnnbmdvZJRyFZ0/Nyz6D+qvByb+e33dQKnKwEEilakGA0=
X-Gm-Gg: AYBFou3LyXPCuQ12+p1BZKPJQy9y105+JfEHE2j4urVFOq/H9Nbgja8ZeDvbWuR1roZ
 dWoupx4CyKlwHyDP/Y9fL+snxLfcUqxhoORkD85S9HGHg2cmEn5v1bwFd6q6mns9Qpz4yaddI77
 Rn2sGrFBAqYHn0mons+6LauVFitc0jnAJdNrstSbdLMHyr+bzobzt3NB65Zp6jjwBPnyXjs7L3i
 igdzNnKHJhXvNoB2MRzMapKTgPOW6/kUMy1JIaAXZkdpWklfXeL7AudBXFcV2R5WflDyYKmgMfH
 HqD3mXdeTQxUQcfQXFM9f/MopysGszbexu3AhR+A1HI25zsCJeFwrgYNFox1fTcXzStyy+FlSR9
 tuOFeIu2HwPlQ1gm7eavcAoIKk9a+tO18PBqZnXcDlUFyE6a6A/SjbuilFY9gftOXQkbLO7JXxI
 kCNtHFMW2sE9RzekovhZkzKD00q7M=
X-Received: by 2002:a05:693c:839a:10b0:351:45a4:7dd8 with SMTP id
 5a478bee46e88-367502fb26fmr4351094eec.34.1792599539857; 
 Wed, 21 Oct 2026 09:18:59 -0700 (PDT)
X-Received: by 2002:a05:693c:839a:10b0:351:45a4:7dd8 with SMTP id
 5a478bee46e88-367502fb26fmr4351051eec.34.1792599539322; 
 Wed, 21 Oct 2026 09:18:59 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36740cc88b5sm8764143eec.10.2026.10.21.09.18.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 09:18:59 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Wed, 21 Oct 2026 21:48:24 +0530
Subject: [PATCH v9 5/8] soc: qcom: cmd-db: Allow boot without CMD DB data
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261021-snagboot-v9-5-18ce3e431320@oss.qualcomm.com>
References: <20261021-snagboot-v9-0-18ce3e431320@oss.qualcomm.com>
In-Reply-To: <20261021-snagboot-v9-0-18ce3e431320@oss.qualcomm.com>
To: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Michael Srba <Michael.Srba@seznam.cz>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Simon Glass <sjg@chromium.org>,
 Hongyang Zhao <hongyang.zhao@thundersoft.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792599504; l=1942;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=UgnSfcvQN3KxWw8blo6gGammTjNQRx3KkF+Wvh5C7Is=;
 b=H/WtnJIm7CvGHEZeZeySYzx1JyQRwZ1nEFjVGVz90QDqCmadeBaK8Jj/FgsBI1DlnWz7dYTcW
 iUFfv8UFknQDh1fnER2w+eM9FMw1dG/KvB56/wAakWHtcA61g61sbcm
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-GUID: bTDWN9K9FV0jare-vo-kJSvhksAU_R1U
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA2NCBTYWx0ZWRfX+dXq8tA4zZwa
 kGmKKKvRK9RQ9fZ+XcVWCz3Gq7bXLkovCP0txIOgOofeD1pGH+8RiwR8ntBX/YKEMJdoEwfn/6l
 TDk79uMkUF9ASeSRd24egiQWnfaQtye5neP9XogSAC+ZMO6HL7s0xZE7a/b+TI/5AxcpN/B3DHn
 PKNhfVLN1RNaDlKQ4PuwGwUzYfx44usShgv/I8f6AeMjAZ88zzzECVdwB6nDvTyy2GgPO+PgYQV
 k8qWigZNXuFzvQHml2tYv8UUHFqqSlDD65tsTlH916DrBiS3CZ20mszGW92PPYLymLBt9CChJLB
 AbqOxNwW1gCf++LdVPKiiO2sGFBDrjKdIk38WO2NhNDILiyPzMXdoMPot7kDYwmeS3Ax80277z8
 LrPsB6QmlgbCHzgZSdLl7JImW3bPC9iIM9nP9Lr2uwxYcB13zcJpVMZhoqpT0lrlHBZfqR8erjc
 zXsfwN7vftJi9v/RvoQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA2NCBTYWx0ZWRfXyYLEyYuVKiyv
 yOtz3WCB8EERCLNI489iTNYn22wWdnr6sB8LcrmrUmBsunLOUDK0o8L2e82e3WWaE71PUCDUyQl
 lk0B81nnJVhIuNBDDor/ViP7NuJnlKc=
X-Proofpoint-ORIG-GUID: bTDWN9K9FV0jare-vo-kJSvhksAU_R1U
X-Authority-Analysis: v=2.4 cv=IPaXmQvG c=1 sm=1 tr=0 ts=6ad8e5f4 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=GqjHzkLP_lxEehVDorYA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210064
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In snagboot mode, XBL loads U-Boot directly without populating CMD DB.
The cmd-db driver fails to bind when CMD DB magic is invalid, blocking
boot even when CMD DB is not strictly required.

Use QCOM_SNAGBOOT_MODE config to allow the driver to bind
successfully when CMD DB data is absent. When QCOM_SNAGBOOT_MODE is
enabled and CMD DB data is present, we log a warning.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v7:
- No changes

Changes in v5:
- Remove QCOM_COMMAND_DB_OPTIONAL definition from Kconfig as its now
  not used

Changes in v4:
- Removed QCOM_COMMAND_DB_OPTIONAL as now we use
  CONFIG_QCOM_SNAGBOOT_MODE
- Drop these warnings if snagboot mode is enabled since that's the
  expected case
- Log a warning if snagboot is enabled and we do have a valid cmd-db,
  since that isn't an expected usecase

 Changes in v3:
- Used "if (IS_ENABLED(CONFIG_QCOM_COMMAND_DB_OPTIONAL))" instead
  of #ifdef

Changes in v2:
- No changes
---
 drivers/soc/qcom/cmd-db.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/qcom/cmd-db.c b/drivers/soc/qcom/cmd-db.c
index d0a6047b8a6..c94a90a2903 100644
--- a/drivers/soc/qcom/cmd-db.c
+++ b/drivers/soc/qcom/cmd-db.c
@@ -252,8 +252,19 @@ static int cmd_db_bind(struct udevice *dev)
 
 	cmd_db_header = base;
 	if (!cmd_db_magic_matches(cmd_db_header)) {
-		log_err("%s: Invalid Command DB Magic\n", __func__);
-		return -EINVAL;
+		if (IS_ENABLED(CONFIG_QCOM_SNAGBOOT_MODE)) {
+			/* Missing CMD DB is expected in snagboot mode */
+			cmd_db_header = NULL;
+			return 0;
+		} else {
+			log_err("%s: Invalid Command DB Magic\n", __func__);
+			return -EINVAL;
+		}
+	}
+
+	if (IS_ENABLED(CONFIG_QCOM_SNAGBOOT_MODE)) {
+		log_warning("%s: CMD DB found in snagboot mode - this is unexpected\n",
+			    __func__);
 	}
 
 	return 0;

-- 
2.34.1

