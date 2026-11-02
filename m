Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4D5606A324
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 05:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=NWUfu/F8;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=OaOhkMjI;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=i9IpoegB
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 580DD4078F;
	Mon,  2 Nov 2026 05:52:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id X9vOBFEIeURs; Mon,  2 Nov 2026 05:52:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7CD8C40748
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793598771;
	b=H+ub33pr/QuhHk/nmIt+cq0CdyYEFkYyb6blmt2OpR9jnMYLmdY9yOaqNy0ZwlErjs08
	 2tVPwN5fDf8q6JyoM3UHxrFoVAQqXubYr63engFw8OJSkAPSl2xVxkuAt5fEkEuSGXJ51
	 cHVHgxqWGbm0lX0o9i7gCYk94uOqqT642kJoehIIyiyT35FgoF5uAEPLimQROh0sOnhwK
	 peDZKgmdk4NBjNKrolyhAFCu2OHr1fhv52TDpZJMHsayBrODlA4fZ5EmqUFZvKcf7JAUo
	 6YcJ8qq7Wb+H5FiaAnBD/89IurflFVFGIaeutqqqNXDtqIO0wRmfPXvn/RmIVG1ESjg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793598771;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=pZJRS6XDMtAvRF/EukerNef0fSgcbR+HdXlJ4+U9nDo=;
	b=l1l+1eTuoeMUcsJpz6+1NiI4EV+D0Ai5sPmTNImpNWXcG89j0m1/89q2ucOfsrXotxpL
	 Iuz0cJ7QyM1lnM07QEFM1CAyNpciWervmJRHDmT/AiKG+twVuchHP5dFQU2AHSFKj0ugL
	 4sUxC6HUgJeBZHD+3+No3BJY2zv+rDgAjP+NEcU6JwNA+5/kYjrVA739JD/W8AoVyL5DL
	 WBkQhHombN2YaspLLlQOVq136fO2EL/IgtJSL5pxWMp6ucspQcsxqfY+qEwIoggfHMlxM
	 bhH2Azd0VludeGmSfLx9n5k5iv5NxYsxUtqOBbB6fbkpXdOVQtQEZbAovIp8owgpX0w==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793598771;
	bh=pZJRS6XDMtAvRF/EukerNef0fSgcbR+HdXlJ4+U9nDo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NWUfu/F8pwLjCPyWmRpo+VuZ8Xl8jzF5d/lJSygs6lU8JbX5XC9CVlvv9TOR7NJKu
	 J5P5kLeADxLA0Geptcg+jM/A5+Fq/otuNQPYu3XpfffVvJ2OBtWM0naq7wLvORLsCh
	 w7cESw+4f3bZqZzahD4DqA18KW3dD+WjPC/kl3TkrfXNfWz3YrnTCGyTgZa4w1iGbT
	 kceKWsRzsv5bLdNft1DepBXAz5R7kgC3fdr59GfVEUn1YWb2xf54wSbYjtS8hFbMUt
	 cDH11HN3Fu+fu5vMtJvICdWNKcHmX95viHPFKwi9Hp7BHvLCClMAaPANMsJgxGyiju
	 1Wsi2SIb+f7rg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7CD8C40748;
	Mon,  2 Nov 2026 05:52:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2E70A4BC
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 05:52:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1492660760
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 05:52:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zKMFN_wxzyYu for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 05:52:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4A805606EA
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793598769;
 b=GmdKKCCPFAMGOw8jw9fr5LT7UmWdPAfcSaOFUCfPghlqMO/rrZS/iiW20UYS6wQHoUUu
 mhS/Be9F328qL46zeFruARLyqMNTD9P9At7Aol5T51ikRQ7P6W/3/qy1+gd7kevN99ZiU
 1Jk/TS5w/cldX9ZV1x8P+K5UR3VooX5sqt+bm4U8RtoHKp6uqqAITbbdrmdJoqPiR0OC2
 I52vOF0JYC5yA+873+TIt/l4ydWPqoQAB1rRfEM0YyXfWy4+7VLvmQHJAC/8sGdY2UvBW
 qhAT5nARZxU+e0aDuBFM7OHxRJYz9j71w4NQwGIBBOuLx/d18jWEN6/GbzpYYT2+wWg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793598769;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=pZJRS6XDMtAvRF/EukerNef0fSgcbR+HdXlJ4+U9nDo=;
 b=mMkJ1SYuKMsblGQby6fi+TuBTRPCRmON9+GULypdo/U0Hg2gNmFlxxmgxPvwNZ1Jrn/p
 djaE9AHAJiFxPbsoIxK2luW9ftaOYUJczKqr79PpT2VqX5wzaPMVT2eY0V3pRGsf53Xpa
 R+njV65d54oSl3fwWlgtTVQRSK/817zEcNIBvet6wWVzrKG4rpOlD0iIhE91z6HIbCeuh
 EwGfgKGNQfakCMdaFcDB2F5EqbQaKCx/gMRjfEUcjduypo4oMN9ViZszjwNA2GAcCmhIi
 1rP5XOWpN2HSyq4idagIOX8v+NQFjBL7RovT4G4C88MqelH3Uwh8lB5cBl0x1B+AlHg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=OaOhkMjI; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=i9IpoegB; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=varadarajan.narayanan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=OaOhkMjI; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=i9IpoegB
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4A805606EA
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 05:52:48 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A23vHtH3324636
 for <u-boot@lists.u-boot-project.org>; Mon, 2 Nov 2026 05:52:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 pZJRS6XDMtAvRF/EukerNef0fSgcbR+HdXlJ4+U9nDo=; b=OaOhkMjIF6GW5kC4
 go8kpB9yfhx49DHj2Aj6Pn/JljkCjdmds/ruEYAmj96amulSk5HLrcnzgPL+gr0g
 sOortKgsZCNQB5tFZzKQeca7ETV1g8zwJ0i0J58vohUgnYZofaZx/aIe+FdyICCA
 XJjNyROCujh1NEU5hw7AqPfc89FtHaJF3Eg55R8aRTPdXuMr4MRD1IqfDnhbQ6Hb
 T2yb6b9oIigknbH0gI/MsGSaf40YUPe07CPCeifyiYVYY+hXj3PnScvc4AFtZnQm
 yQHifL5H9NQS4APtq7Ad/vcJi8GptLJhCr/1zzqAGnX8uAzR9lG5SmqPD2xlHN2o
 8FSoZw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn7b6nfyk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 02 Nov 2026 05:52:47 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-3692c5b061bso7893466eec.1
 for <u-boot@lists.u-boot-project.org>; Sun, 01 Nov 2026 21:52:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793598767; x=1794203567;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pZJRS6XDMtAvRF/EukerNef0fSgcbR+HdXlJ4+U9nDo=;
 b=i9IpoegBr9kZGsbGydGzEwFLjsP/BemH/qA27I5NkgF/iBlw/6243iJrOOat9702yu
 Fyq+Ah8mr+pqWpRuU4ycOYer/Gzz5jqWYVmlEYZgdB7CPsbkq6zJaVbFf7WCjv/h7Pen
 fnAVJqfeKGOU2fnyHs/mLs9NZ0acQ5Ej9XojQWn7TVjdJDR9DoFLpSrtCX5EQt5uNXbI
 epfgKK28WYpyT1/pxXWfxSNseeXYRHLVdr5HcVcNKNkDG0Pr4wKPe4BZejZIvacLPoAZ
 Xg0zxh+7YCC7jBeV6vtZ/p8hZZI6z/q5jdetWBt2TvFD+9AAG1c4ru34PaATD3xkQX04
 GTgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793598767; x=1794203567;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pZJRS6XDMtAvRF/EukerNef0fSgcbR+HdXlJ4+U9nDo=;
 b=F6whaxWmN4/o4Ta+wxKVuNMp5vdtBklv5gbb47O6sjqWCSz7pVa5/y7otC0FRpjZg+
 Z9TTAw/x0CHtjKryNkEhxUYWDctVWtX/CDuJ9OwtzVG2uzsBU0gXTAXiyIWhbm/ilyd7
 NpbRsT9p8ZIwn146QNnW27Hf5ZSr/UR7Xjc89IGpDHbjibuj4o53BiT1J//TVIsYoKzb
 jtfPelhyW2fI+C4l1P8Bpdg62mcR8sBsmvWLdCFBbmNE1VrkQDknT82ivWUr8MNX48TF
 W83E2xiFje+WZaQ/gQ+kkuS168OET8BnSDDR760PLdSTeaHOE0vpFCfc8lJh46bVcK5V
 rWZw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwwiRRkd5hMtOpThMpIlTmFifHt9V6jigUC/xHpcvcoo9WGqpH5C2Pos7iDhXvkbVLmQkbA6EE=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLsR2FobxDpPcA1poQh+oPPTg0rrZMkDzTSYGFVvTRfEZdYZhTr
 swNzdjLNOpBzJJbxo7e3iaGR1NbBhHj125tH9CvBO3Bi8YdrAObIk8lgPMfPBpGbDD9ocyZikKA
 qj+6jEbgtnC1Lg6gwMw0DQGEUnq+5dXyDTYBcKn+LRo2OHRMXvy9jAFB656PDrCEv6HX70yWTcl
 LbjwY=
X-Gm-Gg: AYBFou3dmm0z/Q7rOnySlnK3W6vuKXFd21mAZYiMND7B5M8xSjAmWxZSVvLsd9/fPWG
 lzWhZKPdbowim3MUNDUv5NaLksy0BrP9BMxQDHEI4WY26IreQv2BwhDfaXZwInvh2Y11KieUzCW
 tuJFTxj489axiOeknEaZyDLNODfq6V9aFO7bPlJT6+G82TnqcmCxEaVz3Wn+/2Mr+Rpwmv9vztL
 mkxBDZ1/Y71SsZVkz14jnkD+aiqbQiuvLk82f8A6AsxNm905P3s2DE2TNNF1z3rzIiZ84seLV/b
 Rq+v+OznjqAJVVOk/k06cyxhSO5nByWU0ga5rUY2CQ7ZLmbWJXhK3/wjBogos8zN63JkGTlsK5p
 +4QB0Vi4Tp6mjyGpuMLJ5sknXjrNVG8h2C5gSDqsqC5KpYUr10EYW7bRrckpv4sHaOWyzu2ShEJ
 koazbINowul92lFtMyBfn+iBKN4OScU61XiwwI/3ISZ3A7JLvLH72e/h6aZw1ZcZqjhKPBsrjuD
 nsJ/g==
X-Received: by 2002:a05:693c:69c9:b0:36a:13df:749d with SMTP id
 5a478bee46e88-36a423b3dffmr11978345eec.24.1793598766797; 
 Sun, 01 Nov 2026 21:52:46 -0800 (PST)
X-Received: by 2002:a05:693c:69c9:b0:36a:13df:749d with SMTP id
 5a478bee46e88-36a423b3dffmr11978307eec.24.1793598766060; 
 Sun, 01 Nov 2026 21:52:46 -0800 (PST)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a428af1dfsm35456366eec.7.2026.11.01.21.52.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 21:52:45 -0800 (PST)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Date: Mon, 02 Nov 2026 11:22:29 +0530
Subject: [PATCH RESEND v3 4/4] tools: qcom: mkmbn: Add support to create
 multi-elf
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-ipq5210-v3-4-aacf3930848b@oss.qualcomm.com>
References: <20261102-ipq5210-v3-0-aacf3930848b@oss.qualcomm.com>
In-Reply-To: <20261102-ipq5210-v3-0-aacf3930848b@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: HQ56dN1I1Gcu35pI43kgT7I0Xb5zSmkI
X-Authority-Analysis: v=2.4 cv=QuvLTlyd c=1 sm=1 tr=0 ts=6ae8252f cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=S3gQTLpqa8hfpVGigeQA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: HQ56dN1I1Gcu35pI43kgT7I0Xb5zSmkI
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDAyMyBTYWx0ZWRfX/dcGiDMaBMbF
 dkFpZo2GNEKq0ehdoX7PSob3/+YmZ3bywrPWDAgCsZJmOaoJbi3INwyHMD2vuDVP8CnTrCZi4gG
 PzWVJVr5uAMug7E6/IFavVEx7yanaDM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDAyMyBTYWx0ZWRfX8saknvmOAEGe
 lYsymCM7g3rKh6AdHuaneeVL64AZutmmrzuqkWWH5aiuXaXWk6o9vO9BRH946NqWMlhxIryA2kf
 81nplB1gTUyUSLQssPNwkJhuqKj5iOGgXs/9tickOmpf/mRZfIg2xTXuPnrAPupSSktB0QvFJgd
 B4KiuUzTtay9HlN/sP5RUR2jSDezZtDFOZuH4Hs90lQOaJrlPf0kS5v2KPGFOkBq0RnfOmTUgkh
 3CpJTh35dmY/vr+RrGfCbxpz2tek4XcRQPheZZg5oKUFctdkAeu9+nwXMKZJ2HOOZQL0/LsOZnx
 3QxcghTs6IAAXrs72G9LpFAoeJwKW8vsFOdk31mIPO82qudyN6tCtwuQw3lRLUhWDkQ4orhuipC
 F5mpKGCug8KknvcCmzdw6jDJQWwhDF0qrwpT0u3uecU8oXQ58mr5BsV/xW8eCghk3T2uKhZahSk
 T6wq3/j4xp4m5g6JnKg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 impostorscore=0 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020023
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

Modify the 'bin' argument to take either a single file to convert to MBN, or a
list of files to be combined to create a multi-elf expected by the boot rom.

Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
 tools/qcom/mkmbn/mkmbn.py | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/tools/qcom/mkmbn/mkmbn.py b/tools/qcom/mkmbn/mkmbn.py
index da4d45b600a..8af268a2d8a 100755
--- a/tools/qcom/mkmbn/mkmbn.py
+++ b/tools/qcom/mkmbn/mkmbn.py
@@ -110,14 +110,32 @@ parser.add_argument(
     "-v", dest="verbose", action="store_true", default=False, help="Verbose"
 )
 parser.add_argument(
-    "bin", type=argparse.FileType("rb"), help="Binary to embed (e.g. u-boot.bin)"
+    "bin", nargs = '+', type=argparse.FileType("rb"),
+    help="One or more binaries to embed (e.g. u-boot.bin) or create multi-elf"
 )
 args = parser.parse_args()
 verbose = args.verbose
 
+if (len(args.bin) > 1):		# Create multi-elf
+    try:
+        with open(args.output, "wb") as f:
+            for path in args.bin:
+                with open(path, 'rb') as tmp:
+                    f.write(tmp.read())
+    except Exception as e:
+        print(f"Error: {e}")
+        sys.exit(1)
+
+    sys.exit(0)
+
 elf = Elf()
 
-data: bytes = args.bin.read()
+if args.bin:
+    data: bytes = args.bin[0].read()
+else:
+    print(f"Specify the binary to convert to MBN")
+    sys.exit(1)
+
 
 # dtb is at the end, so find the last match
 dtb_off = 0

-- 
2.34.1

