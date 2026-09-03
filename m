Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA317C61DD3
	for <u-boot@archiver.kernel.org>; Thu,  3 Sep 2026 05:00:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B03EA8107D;
	Thu,  3 Sep 2026 05:00:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qXULADinfuiJ; Thu,  3 Sep 2026 05:00:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org A32E48101C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788411650;
	b=BYtxAwONOpokuq/U8+0dFsFHm2SAk6hUTr2GGVXMve0/qDhFr+0YQ8aD/ZinB0wVRGsW
	 d0TCI8FxaWzxBQIs9X7wuupbiO8+0itbXAMCt4ddselAShsqUVXVAPKme0oKEdLOG6Wa5
	 R5HKmdm0Vfq7ngNcp2+hP7U7p5kZ1sh802RpUpzN1obTzTooFY0egqvR04hKcDlv4NVS0
	 Kj4i/39UEUtjVzWuXRpFHl4Fvv7K7wtIlR1/5THPE2g8GO1884CyYNYbH2K8Tvsc4JK07
	 uJLjbcj9BA2G8cEZaUbOGhlVoBzRadFGVDMTdCniMAxiBwh7h61xrmJK7bsk87RK4XQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788411650;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=11v5f2PrgHtJRjIBEWnfGAVwV6iMEvu4CmwQjiNqoi4=;
	b=rZJgfo5l/ROAovEKiS1gy8MmWHrmjuqC+EjMF8xiwY16MfBUBzYoNaIiUszVIgd/7td7
	 2jjOlEURVm1o+I9GiwQTpjjpV+7mhGFnkwehQShmzgctFZRmkSgrft41TQG2cmKv7qhfI
	 frJy3nlSlZ+g2TOz4ysOiMnSGPvDzhAwDC9rJliqlPriO+uDeWfOb2jx1b4PLpA7XyVtD
	 h+XcjDNKGZoPphybKyypOhIXtHJl39YRwbhOhjVfHSPTbQcVJyVmqtNyklZc8UfNXdffj
	 19vvZMftLvvB3KWUDcCA2DUyPRu0xGEF7eA5X+fp5+dxCfCFGyc7MeNdAFoyrEt70pg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788411650;
	bh=11v5f2PrgHtJRjIBEWnfGAVwV6iMEvu4CmwQjiNqoi4=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=MEQRRyVguOPW0EBlmbmHZcSw9alGY7osk0yOaCao5TVlII5ZPkAfcuTBLA+0NfwpY
	 AkROelOJ9cDtpOoN73pbo+FlB+xt2/v8vxV9l58D07lV68ULipSoEd82cSOGTuKly1
	 eICQPlpXFz6ZFSluIRLNuUZBIqtmOzG945Up7Jw/5zQ9v8w2aglRyjSpROhhGYke+F
	 EBa5s4m0QYQCrWcaDTWlYVN9d65uRsTDWn2A6v3QgVOE09dUU67Wc4Qj5oZIfri2hg
	 hdOUa13r2KPu0xHA1L+s3h/bWefT6nQNWOwPpoDdmooW1cs9gl4ecrC2RkibwQUAX2
	 f4ha4bcKvWscQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A32E48101C;
	Thu,  3 Sep 2026 05:00:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3DDFA2FD
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 05:00:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2FC4560845
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 05:00:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GjZZC9iNwlst for <u-boot@lists.u-boot-project.org>;
 Thu,  3 Sep 2026 05:00:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 46569607F5
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788411648;
 b=npxvVjaOroQLMDRZ1hREwchVfu8JYm4JCcqsTdcDcRcHmeAoNCMnefnFvFKGyGkOBGAV
 BNmSPO7wH9oFXykLYC/Ak5w3Agmd152hezkY6jrb5PeDWr9LMR/4ASEEt6Y5ehCr5LpX5
 jLqvvMyIQe6b4fbL/lR7+Tu4Dnr5QL+d/2W/PCxnFxXBan7J9IGHVXnARZi8sWIyLFvub
 CNo0/K+lLQ8k4pH9CjhBl+PzX3ogcP58uzNC4UbxZ/7472uhjmjQcfEGJKT0955H74Tuc
 zIJSVir1d01b44roZV1j8bbDXzaAJuu/Ro6otdhoxT+XKtRMDwu867mhzqFm6yRztNw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788411648;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Authority-Analysis:
 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=11v5f2PrgHtJRjIBEWnfGAVwV6iMEvu4CmwQjiNqoi4=;
 b=cGky8WfMy47UqJ/TheCrijBAyTvjR+1eTjowslPb1l1yIhsdIvb5YMMLy5K4NUtjyWcm
 iW8UJYsmJ+2UeVmKR7aAzca4pfti7w3xlpK30Xot9wzxAGMs7GvYO4zejZxHaehjUrdj5
 IptGYt9Q9n6knMORP+TdN9tfYiWFlxixmFOBTnWg5T8VtHF+hFfoOJnmqLBMPIL8+Fw2v
 AvDCp+da80QUewVvAsAIQByxt/xOe/tLuvINzzBJdNh9Z5NUs6VTz62HeyOH/2xQtJaTK
 lzLxTUW5ZbqPi9NEtvoSu4zlT75cD5nYHfPBvBri8Js2/fMc5Ic58ySwmpSKk+kb8qQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=HNWpNImb; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=I3P50s8L; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=HNWpNImb; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=I3P50s8L
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 46569607F5
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 05:00:47 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6832xufT3275651
 for <u-boot@lists.u-boot-project.org>; Thu, 3 Sep 2026 05:00:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=11v5f2PrgHtJRjIBEWnfGA
 VwV6iMEvu4CmwQjiNqoi4=; b=HNWpNImbonfgRjhYTZMosnieIY9VqA1Crnzcp1
 49jEqKj4e2jan+EaC5BqYTMw+8RmkxVEzA7/oAfKw/JMWs2hJ//dpeLKvPxk/rV0
 TlAzjVj4cNUot/+hFJ8yq8Ypzs9ui3Bw+ZkJ2hznjGAQ4pWQ5Ek891hsLhVsWMjU
 ptMOXI+g9Eqsr5B4xH1kojJVF1HoMtsNA60Ur/jStupG2gQXafIWH4k8ztOlTwCo
 rjZdMzTyy6lh0uOdKh6RjAm4xSLhEfZbR2ft14EibvAbMYpwDGm1bZLKvvgOmYpr
 5jWQQ92mP75VS3O1g0e6/7Zf8PVLnTe5TybC8Z/CCOri1SJg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4genrdu686-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 03 Sep 2026 05:00:46 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cbb20f82a0eso1348792a12.0
 for <u-boot@lists.u-boot-project.org>; Wed, 02 Sep 2026 22:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788411645; x=1789016445;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=11v5f2PrgHtJRjIBEWnfGAVwV6iMEvu4CmwQjiNqoi4=;
 b=I3P50s8LsoO8JNm2vA9Dx+zDaU8rR1ZJRe3iwDLWIRbBvp+Q3vRMhXtffGe3acKmzN
 OGCeznL+4PExJdqOgGARwwTrguOZaiyRvLZX4PwOu19rt4augsIojU+hubu2aAuAaTFm
 0frkEZ8ZMMYk6L5lf16XjnKEOcKtZlmwM0rXzaTcfOmoeFf8xfD2A/+LqvI5CZUGmjQc
 mgO6hxq4wIInHGux+xLHyNshspAyaBrsKXJT2MCWvkfTOUe+Yh06y33+eswiycn6U2zY
 kc+h4khmDky/PC3Ckbs7hK+dOYUkamW10dXzIuNQhhsnb0oWpkUJ4/61riknh4426y76
 GlbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788411645; x=1789016445;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=11v5f2PrgHtJRjIBEWnfGAVwV6iMEvu4CmwQjiNqoi4=;
 b=gV1IKSLnHkJ/JWGvRQQlAGsvUQYoKt1GPCzhdlpnQw8OfLG5deVRy9kZ/Qbjtz2d3K
 OoSB4TNSkKvvMshc5MBHNPGhnml4zr9EYjprQOq0yaW23R9hw2XiSh5px3S7B3ztrWL7
 hJQRenuMagfTKEDgH29me3+BZEfg8p7IeNQVGaScaGicDYEOGLtHQUhXsKYA+r2J+wxx
 l5tcQuLwAi0uPIVv6SA9mkP+jBm33cjWNAhHZrWHqf33XhIXDfmEypieYPCmZ9UHLGEU
 oJpXTkv+Hl5CN28VMXdnXjWlLV3RBbKaP6z/UWj3IJuNMIWP1hOjrdkIJuim8kuulK31
 IO2A==
X-Forwarded-Encrypted: i=1;
 AKwUvBycV4H5xJ6tAaNmayzl1wIgXOg4LzmDncj6adIBEExxtv1C36IgMDwnWDg+NsyY9YIIYjcBcGo=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++ljTtUh2la+YsQjWso+HjCvI9rHW7lZDFgzNPc5ISAzevHRpMW7
 9dN/hep+EsRfFGCf5FW8LuJC5chzK8Q2yYkqUY9bEix5DnANA5eelqUVnTlVmLM1cRJob/HA1/F
 2DDLcDAVvrpS/wggzXJEd4h8qdjWVTEt31Eo5Pu7Uh0m99lsW7UgcYGJDBqceHREz45nYK+0=
X-Gm-Gg: AYBFou0IL6zq9MxGmSnQjBj9AaZhXSKJ+J/Qt61cbsFhr72V70il45mwBJ65Q1EU9cI
 FYosYfiGTp1nQmL1BxqPQj8yonfHtq1SRKvn7D7iEWglwnKY7gFzh84ZtQ2ivf2McX26XkAJ5Zr
 BkOzZHaj6p2iWIIQB/dSh3G2bS1nxUJybMH6yDmAIDpZvNMrhE4hYNZo9B/93IDY/tnZz7ZdoaK
 Jgpa2t+xeuRhBjv28b6Z87ZOvV47FPHZUZ/vFAhfYzG2AjqTBZu0QFhxypbv5/pyUzAJB3t/Xuj
 H+UUV9j26ZDR9RX2iL+pCFfSX4qXIzuy6+PKSXS/e2S0Fw9yf10ahduinz+TUffwhODLrBL+YYa
 4hViU4hiO+Bcbe0rEQ1jv4z9ItD9x5qnVTbJBRWmVJCqIe231fNsDLZ38yS5+RcMyA7CSHqIKxO
 0/8zLKmHNi/fzq2p0ZXfpnMdtMt/08
X-Received: by 2002:a17:90b:4c05:b0:398:d93a:b343 with SMTP id
 98e67ed59e1d1-39aedebf901mr14464253a91.3.1788411645104; 
 Wed, 02 Sep 2026 22:00:45 -0700 (PDT)
X-Received: by 2002:a17:90b:4c05:b0:398:d93a:b343 with SMTP id
 98e67ed59e1d1-39aedebf901mr14464118a91.3.1788411643896; 
 Wed, 02 Sep 2026 22:00:43 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1431991f777sm2535731c88.6.2026.09.02.22.00.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 22:00:42 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Thu, 03 Sep 2026 10:30:36 +0530
Subject: [PATCH] configs: qcom_qcs8300: store environment on UFS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-qcs8300-env-scsi-v1-1-0244bffba2a4@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAPP+mGoC/x3MPQqAMAxA4atIZgOxin9XEQdbU81StQERine3O
 H7DewmUo7DCWCSIfIvKETKqsgC3L2FjlDUbDJmWBjJ4Oe1rIuRwozoVrOqOvV8G26wWcnZG9vL
 8y2l+3w+pPdvxYgAAAA==
X-Change-ID: 20260902-qcs8300-env-scsi-137effa9b4db
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788411638; l=1106;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=WoWSdT8yS0TD1M7a4Rm5w+xN8ivvbyxda6dFdVo6eTg=;
 b=ryrTHih5jePXS3APJx6HB8y7I7JEKG0ACqeunTjiIiGctuD2P6RBvxV5fdIx0Aa76S8XBoWDA
 GWUmpUusloVC3cK96mk+RZO73wISIlqyYRN9BKE1Fh5lubZT0WV+IJg
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Authority-Analysis: v=2.4 cv=H4/rBeYi c=1 sm=1 tr=0 ts=6a98fefe cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=JdZyu2eDM9C4YTOe6ycA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: cCGw8UCzegXSzlamGJL08L805w716a8O
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDA0MiBTYWx0ZWRfX92b1iQTZYVSv
 u23P06Y55OUbmsN1AeHHdl0gJRhGLfm4SGMfHxUkB2MHR47tdUI47om7Nk7SqWRNJLp4rTaRQXl
 jcDuWBW4ITejACZyR3Co9gxq/811/2AQmt8exmzPiH3gGTWO4R3cXqWrTr80hWJKQNLVL7pz9yT
 r1NBAVjbQUFRUW57CDau63CEDPdcJjzDG1CAiXNWCUnFn6QmyjZXusE1DCidldX8px3VWsoe7gY
 oH4Rlo5zGnB9+WRQYl7XxVUAWSD6JuT0GHENi8iH06VptbZR1HOeOWUDyFBpCCDY+/kw3OfiWn/
 XIeFbqVjGxfogOdkfpAgZQbDiewfAnZih08KGAL/Ov7hkru1myhSaWoT7mG7q1uleM7SrVBs7gq
 llvQi/7QxNKlWgHITFyHHHt/oyCj23C/w9rDeP1Rnuj11p/XGGTJaveq+233hiYdcr2rfr/mD5i
 iKwyUaBsmvP+iHObCgA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDA0MiBTYWx0ZWRfX2muIkuZXh0P/
 drgvaI/YqsYTLgZQ6aJWGVJRUzUsIFjYhpGB0xCW4xaFhouSrmEmqvrbxJFFunEf8zS1xY7+bqc
 Xam7zWLTT2+MqZgeOGHS4jzFa9kKqwk=
X-Proofpoint-ORIG-GUID: cCGw8UCzegXSzlamGJL08L805w716a8O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_01,2026-09-02_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 spamscore=0 phishscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030042
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

Persist the U-Boot environment to the env partition (matched by GPT
type GUID) on UFS instead of keeping it in memory only, so changes
made with saveenv survive a reboot.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 configs/qcom_qcs8300_defconfig | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/configs/qcom_qcs8300_defconfig b/configs/qcom_qcs8300_defconfig
index 5fffcddc16e..d1746c36546 100644
--- a/configs/qcom_qcs8300_defconfig
+++ b/configs/qcom_qcs8300_defconfig
@@ -19,3 +19,10 @@ CONFIG_TEXT_BASE=0xaf000000
 CONFIG_REMAKE_ELF=y
 
 CONFIG_DEFAULT_DEVICE_TREE="qcom/qcs8300-ride"
+
+CONFIG_ENV_IS_IN_SCSI=y
+CONFIG_ENV_SCSI_PART_USE_TYPE_GUID=y
+# SCSI partition type GUID for logfs partition
+CONFIG_ENV_SCSI_PART_TYPE_GUID="bc0330eb-3410-4951-a617-03898dbe3372"
+# CONFIG_ENV_IS_DEFAULT is not set
+# CONFIG_ENV_IS_NOWHERE is not set

---
base-commit: cc8c034e78eba6b2a3845783889b80753bb1af1e
change-id: 20260902-qcs8300-env-scsi-137effa9b4db

Best regards,
-- 
Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

