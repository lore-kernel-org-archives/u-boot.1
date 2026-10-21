Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56268606A320
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 15:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ZHw1sQMJ;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZmxRDt2Q;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MrXHyPqU
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2067281164;
	Wed, 21 Oct 2026 15:57:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id g0uLvm15QLpV; Wed, 21 Oct 2026 15:57:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1B6B280F7F
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792598273;
	b=dqgNbd+6VV+T8YOAbxaSlSJvys7I38QKX9XcbDffA7Q6MFxPl5j0tv5AjZDv67JJbh3f
	 OfjgIgA+xzh7WzbqvZIZoPufOFulM5FmNPs/cqcqEh2CTvXd/r5o1j4kPJ8B51NywGzzx
	 kf+HuBBEW8+KLcwm+dbiFa+2VhaIe19kMzzh8oxTIiCsDwVmphNKn7IHORIw/M3imEmdz
	 KYbtv+Muc6TJzRY2Q7K2HNxctHpdupDkzNag06B35cuwfI5tNFh2yyVeY3SFttswv+5jb
	 JEvUAhiGflPpXpya4s0oKN8VvrN0D4G/vJIgAmEVwJi13eHxrFpQHhB21hL9XaCYLXA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792598273;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=auzDHJfkl6MjYvmpa69i4ihiB9w4uKMgivugCldAsGY=;
	b=go+0Upb7TkDzrdZ0TG8fHeqRJ/wEoTGuORHzvA/dcZNpCUsS2jmNzX8XYptrCAXB446v
	 46HKPdCpzlFvV0geV68p1ER7JiHqynCoJ7m55iPUnW+iKqEQs8IrEMNMC4RdT/6fKRZZ2
	 K9HAy0wfoMYScnwWd9O19QnVFr9iwCaZTAo+mCiMNP2iOfhm64zPnkgjnJ6fHmw4+uIs8
	 nVHOvL2ft6/HQzmMw5LCsi9OU8Igj3eJjfyPn+QP3L029atFEEGUNA+EVukNMh1EPYIJU
	 Xf+VwYwv3N0sFO0NQvXnkFMGcoh4Axk6fvKHFdBf/J7PK5ewmr97YRIAvuzvqDer8FA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792598273;
	bh=auzDHJfkl6MjYvmpa69i4ihiB9w4uKMgivugCldAsGY=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ZHw1sQMJ7CYrlRjaH9E1vY6ydYxw9TaSLfAKrXEU/2RWhxMG5xGS9KNPE2qpkQ7UD
	 yDg1Qdv79CRfb4YA+FcFi9y5RZTPyaNtDfc5Dsv6NDa8JMWMlRzfXbXEyEzxpAWvMg
	 r1UeEKlmulcBgz2KvmbTUlMfTC6o3T2G+c5sXtRApUFC/KjoBUzKg6DgyTZFoZ70Qv
	 zppP3Osv/eST5M567kVou5KOpq1bUtBzl8ivuHu62QZKj5cTe9TibwE92pfAgP3vr3
	 v8WJDDgsIGtxMmcAvShDhVghj/cWwRpu8OMGzPNm6g7EwLS4FrhGRmAziRz7l1y0k1
	 j8D01YkhdmhQw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1B6B280F7F;
	Wed, 21 Oct 2026 15:57:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id A79321E11
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 15:57:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8D6FC40877
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 15:57:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1igZmb_ykwpT for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 15:57:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7F6B14077B
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792598270;
 b=lvJirj+cUx2Dp94oBEIz6vcR1F+nGMIb/gl/bLkhaH0+DnnVD9Hng+1yHIAHoo+suCfK
 DQHA/PNSOvOy0QU4bvbXHQsMiyuAC5qhN2LeTdvtMKohNddaz+0uceVCt7E7Tu53siM3P
 JT0CFLoE1roMgcVrHHWMrR835GGBvrJ5VZVIjWIw/WccsgUbkFEWtER0rva7QniBaS9yL
 07p6NAk3mel0b4faIUbIdPJ0sBI5ZRGElhzgIOjJmbp2rfCgMRtDqpbu9tX1Hgf5U1qrv
 FI/8I5f/Mg50GK8wDpTdi55CzTqepm+rX1J0O2lQ4IyjUXy0va8gR8yp+ux/LDh0n+g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792598270;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
 Subject:Date:Message-Id:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Info:
 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=auzDHJfkl6MjYvmpa69i4ihiB9w4uKMgivugCldAsGY=;
 b=XTbwGmcxKX9d9fex4KLo0GmHt37HlbiKpe/iFy2S0vmlac3mKIVGjxUpKBUaljn3dium
 nyuwLt2DBeHjg7k3dASznZEx1V2ESZPViEehpNBQpqq0mD7VQoqtCWYblBv9t8qinvw2B
 QZXf/FFe/G/aQENhhfWdUsTUESjI0/NXFZrCtOMJnKp6uR3Fh675izYza+djNt0jIz7aP
 cpL8gjWmx8Z5c3Go3zK/0rPO7RIa/0HOoAPORzF9kXGVb/uIt7dnnY85726bWBAm0LbBp
 kRZ5TKsufAOmk+z2I5qSK3CJJ2Pg1TM53f4YUkWYiPtrnGdqO9M+rT4Qv5r9pa8bvjA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=ZmxRDt2Q; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=MrXHyPqU; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=ZmxRDt2Q; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=MrXHyPqU
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7F6B14077B
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 15:57:48 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LFTp7A141152
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 15:57:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=auzDHJfkl6MjYvmpa69i4i
 hiB9w4uKMgivugCldAsGY=; b=ZmxRDt2QQ7ZiiVDkO99K2Ndo68oig2r3daahHN
 7Olxwzkt8OFtzRVn4otoiRiowor03gt6yB9pvjtr+1lJFEa7rOTJucTzOZwBSNm4
 Jq2sATLPqKhJUQkkuXAhy/RzZ2UNAy1GCfcM2ReQRFa67y/XPq4gEFvgdm8MYv58
 6WGgTkSCdO21WrORH/zftH3ifJvd+rF0Ap959p1f/ugYs1Wusr9CAlE78NNUkR90
 X99r8Od01UIMJnO/utfi85/BHSwvXzwbcnyp6pXQKmZRXYBNF/qe8ftTt1iJB+c+
 /w+tN3B33uGY3qO3+I+CG4IJWbFuwJi3wvZ1F/e1PJpeLHiQ==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hex588pwn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 15:57:47 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-151ba226e1bso1567630c88.0
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 08:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792598267; x=1793203067;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=auzDHJfkl6MjYvmpa69i4ihiB9w4uKMgivugCldAsGY=;
 b=MrXHyPqUamYzU79t0mJeMNI1szloZSXKe8ZM33OX20wXXsYhwCQBeDcTF/Z9oTrIZx
 i5SpDlnCSN2L7NJIHEeN1956RBctNDv5BACvOVUz7oWSAdCX6MQm3HHzKAuZrrqYyI4s
 lK/Nl3A3ME2PbOa9KwP5N5iGR0NxKTBpG5CsVXSThFFFa2FaDixE/YLZJ2yvHJapJ6+d
 D2EONr7LsJ88WT4qTMiNrXqiDZ0tQtHeBQ50eQQ4jGyX0APr2HzzDk3iQXKghOQL7ftc
 3XJFxaoLk4LYKxm1wkatzcGcqnL+WysZGuNt2jr6GT+MR6BQ/SDrbo5uWEma8xFz2sn+
 faAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792598267; x=1793203067;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=auzDHJfkl6MjYvmpa69i4ihiB9w4uKMgivugCldAsGY=;
 b=nUolTZ1FYKT15RjDu92JU4Gw0pBhOQpMhRiWIZZuA2z8hf0T/e9ne+W7H00h/R2XVg
 mteAM6Sbv8+3KeYbE34eP1mpQGIcR03XK7Dx1zdCJLo2iILMwIN1lLatH/UGXCe0ABS8
 C8kurXE9tZhz8rTrd88hTW9c6LvThApFTYh73yXY+XLMbCEHRi56Wth/2QR9AZbXBmxo
 fB0YWEWnJ/dYP05PbigSxMEg1BooqYH1U4ftGL1DKaXJi7//GMZq5Uc9rw9XCfG5k1Go
 UcmkoWOLVUxT8ZPERS0Q7sVh38cLOBzU1hHW0QmZ1UnXR4cPT7vmSuLC7zhUDAo4i26K
 xtRw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzCR/qIQBpctMI/PShe7L//TPWAh4eAyZKZsJjF5qbSCyTPTvegQSByqjUGPHNuKx57KGwV5k4=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYL7PrK4zEbLeHeq7r7Ri0MG68u2hdxztRY+U1nIpHXj7ftv3wye
 n9i2rZXDEBo81hNmyovGXHhw6n/0n6E4apvY/rZc5/oJTczUWN5mIetSK/RgM+7/pJJn0H0FWfb
 G5RAY/wDsTA5uzkOH9T2uNK3goUwCncdbqpw/B5/VGBveY7tl44ilg9mm66o830kjdfl9f1E=
X-Gm-Gg: AYBFou3uJE1u+7zWWYUTZBfFNYuDbloGU6el044VJCCvo6bkEB0Y0dLFr4E41NcOslW
 HRSkZm4B18B6yd5mnGckrv/9hpIOJj5stpqu6Fhcwgp0vY6kjVlQXtqVTG+Qzd8OYLw0rJYGjsp
 xDN/Hn9JXLvdd9GFYlIWp71k8ULDCIe+nEPcMs2z82TMXygR/MFtlZYY339qaB5TLZip3YWVfY2
 G6rwMVtTdo53kqe7rEUwFOIy0mZZsJw4zPzmWDq5VY4biUTEs0X/NNBvzZQyD9n/oDT/np49v5w
 I2HmMGypPrZM2nvLeWAc73mjPLO5grODrDtqBCHventXEouWVIbie6HBc/WoT5HFvBqAg9fQ0/z
 pgAjb52rCkXBfQhw+DZRPWJz9dLtrmHwEe3hztzUpjLHE59s/S0BmYYIQnpUo71QVioSkIXd5jJ
 CogPPmeHOhznKVyBe/vv3FHK1cwwg=
X-Received: by 2002:a05:701b:240d:b0:168:e942:4e62 with SMTP id
 a92af1059eb24-190a728a379mr2670593c88.40.1792598266541; 
 Wed, 21 Oct 2026 08:57:46 -0700 (PDT)
X-Received: by 2002:a05:701b:240d:b0:168:e942:4e62 with SMTP id
 a92af1059eb24-190a728a379mr2670554c88.40.1792598265964; 
 Wed, 21 Oct 2026 08:57:45 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-19035926035sm6521745c88.1.2026.10.21.08.57.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 08:57:45 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Subject: [PATCH v2 0/2] mach-snapdragon: move SCSI scan and usb start out
 of the preboot environment
Date: Wed, 21 Oct 2026 21:27:18 +0530
Message-Id: <20261021-qcom-env-drop-scsi-scan-v2-0-0880a06974c5@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN7g2GoC/z2NzYoCMRAGX2XI2UA6P52JryIeOp2eNQdnxkRlQ
 Xz3DQp7aagPqvqlurQqXR2nl2ryrL1u6wB7mBRfaP0RXctgZY1FMBb0jberlvWpS9t23bnXcWj
 VnjzahZASezXsvclSfz/l0/nLTW6P8eD+HdVOd76M/HFKWSgsNDM4EyE4QPRMLiVXFu8CMmacf
 cyf7r8FTlIugBAMW4MzFx8gZsEEUGIc6jzCRtT5/f4DLZPRt+gAAAA=
X-Change-ID: 20261021-qcom-env-drop-scsi-scan-4a462fa6a9c4
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Michael Srba <Michael.Srba@seznam.cz>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792598262; l=1673;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=3X7q/37rTMURDM0x3MDg7WiyLJWAIBwUOTOd8miwA1k=;
 b=zwxYEKYFIUJwistTdwiP+u8U5f49sMfaJT2syThmqinNB+mpuAXbmEIoDjeFnFB7EF7tM8Tbu
 BMGup9/6/8XBoYLGxuMtAY8cl6dxAFUYeLvKUPUHGEmlj8+uOS63CS9
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA2MyBTYWx0ZWRfX2QDGMus+7YGs
 dVjp9EaafeVwOQoEyuG27tU7jazKMrPMTTftZ42oH5z+mSeLF6vDij6SwxauOU2kD/uqxJl8NSc
 Wir3kUN9WFzBeWcJoaze8h0KyYktddk=
X-Proofpoint-GUID: 3OeARASjhoxfn1TEpbd0U_167v9P_MXJ
X-Proofpoint-ORIG-GUID: 3OeARASjhoxfn1TEpbd0U_167v9P_MXJ
X-Authority-Analysis: v=2.4 cv=Ku7YSmWN c=1 sm=1 tr=0 ts=6ad8e0fb cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=QKfdjNd09NGsDNTfPw0A:9 a=QEXdDO2ut3YA:10
 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA2MyBTYWx0ZWRfX9g63JVD7os61
 wQ5so+LPKhxAimqDHwIBuG3dfh5DUS/F6JaBQTHbv5iziVJyS7du2iQ2s3RBJRgA4a8OjN6Edk5
 EFCrBfaWn6B07qqDQhdgUcgHjJxHpDX27q84OcSKFuTjeXNl4fL0q8BiJmftvM9VK+EAloI+RNZ
 pvHmnVM47cIB2hvHd/sFkJG7nhSBQOg6L8Ozfhc0lrQmpRTQuuqmPKq2wCxpts2toHKEl72pP7C
 fwE8p4cNDu072WmSOmomVrO0qMvLHiAnBY3ToaVUgAlm+mtJMGBMU1U1SXrXjpiBZoV4I4OIoWF
 1BdmPdHzgAzMC+Sc8K8MJmUzOlSAUcsNSo8Be9ZA3KMu3sVUjN+4GQh2hx4rrSe9nBBIoMSajZr
 GbGe4zeC/HZNBE7Pv2gRwnAFQBmGK4THYoN0BlmBYnzqO3Xthe6I8tMvs/MomufuQ//Sh9hcovX
 8F49rl+hx4yVurcZ14g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 adultscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210063
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The default Qualcomm environment runs 'scsi scan; usb start' as
preboot. This prints an unknown command error on eMMC-only builds
and spends boot time on USB enumeration that is not always needed.

So this series moves the SCSI scan into board_late_init() and removes
'scsi scan; usb start' from preboot default environment.

Dependencies:
This series depends on following patches:
https://lore.kernel.org/all/20260906121751.3550628-4-aswin.murugan@oss.qualcomm.com/
https://lore.kernel.org/all/20260906121751.3550628-5-aswin.murugan@oss.qualcomm.com/

Changes in v2:
- Move the SCSI scan from qcom_configure_capsule_updates() to
  board_late_init() so it no longer depends on capsule updates
  being enabled, using scsi_scan_new()
- Remove preboot from the default environment, including
  'usb start'
- Rewrite the commit message
- Link to v1: https://lore.kernel.org/all/20260126155938.2717540-4-balaji.selvanathan@oss.qualcomm.com/

---
Balaji Selvanathan (2):
      mach-snapdragon: scan SCSI devices in board_late_init()
      board: qualcomm: drop preboot from the default environment

 arch/arm/mach-snapdragon/board.c          | 10 ++++++++++
 arch/arm/mach-snapdragon/capsule_update.c | 12 +-----------
 board/qualcomm/default.env                |  1 -
 3 files changed, 11 insertions(+), 12 deletions(-)
---
base-commit: b3142e3ed0e08194a85223728a80df9eb7ed5a20
change-id: 20261021-qcom-env-drop-scsi-scan-4a462fa6a9c4
prerequisite-patch-id: 9bea5fa8c13071531664ca3993df4356c6b6847b
prerequisite-patch-id: 13e9bd16150c2068cd4517be6911d77df489be0e

Best regards,
-- 
Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

