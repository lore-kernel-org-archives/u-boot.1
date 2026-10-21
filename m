Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195E4606A544
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 16:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=dOTiTuY/;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=P2+3c9l5;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KAoY4fEM
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DDDD1608DE;
	Wed, 21 Oct 2026 16:18:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pMuY2NdTp1j5; Wed, 21 Oct 2026 16:18:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B354B6081D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792599518;
	b=dWUxycaXD95IA0/2rBRlyz+ccDHcE3KSxKfMP6QE300j4ELPuqLGuQd2gItYm5KgynG5
	 WfnjgogxwUzwX3YcVWo7S143f7LdimjoyPRFEKfZvWU2bCfQ9YhzIvZiGeHEvvqxP7diB
	 k3QFAPjwo2zUUfvNeO98KUqGKhXtdx+ewiqshKhrNMyc/Q/Ah2/z4j1Wz5jGOqIKuhhlP
	 bpWKzFCA5DdtJo8t8nDpHj8axkJy9thzsD+wrC1cTWRktSqYSnPUG1KMGG9UpxHkSX0ap
	 B1AyV/NFKMmQkMV9qS4VAR2bnkb+/l3i4jZSompMCCwpycjuoBw6HZZdIqkwGTAFBOQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792599518;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=FUvp3DGOJ16FHo4Wy30sOXIXEwMSx3R5ZWyqhf4gIRw=;
	b=aVWT8wsdbDaRCsUgseC5H0sxW4+p5j1ecAhONGvNN/ZPC1GkH82PHNpNganxCeGZYfWv
	 dFCw8Ua9gLy5hRTq9LOHuaIYic+b8E3dq0aLYRPbA0Gyqk6/hiDtv11mRN2VhRbTG47x0
	 NxbJnuzF/AAdpOHZ+M8NiyRN3ASNlSaFiNI+/WLUDwMQbIfCGNavnk1Ey8jGCMcw+E/rg
	 oS95pJXEYbZZ0eFx+FCS5xOeCKlFcvsdKijHdINi1dqSlAeFnx86vWdInh+bu/nYbXjw0
	 RNVPVxYYNFHQHUrmohjC8hXRtOb73bbegXOFJIb/1bIF9zWmur1aor7mpEUG6ljZ5Eg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792599518;
	bh=FUvp3DGOJ16FHo4Wy30sOXIXEwMSx3R5ZWyqhf4gIRw=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=dOTiTuY/FvHkPKFUbg5/j8Bq9Up5yKzkm5G7fkdDx6iIw1/vnC40qXsA+teAk1GUu
	 +ak1aufNsAnNp2OVLblpO7bSiAPMoZ3tnoi4rC3J0arVJ+YQUAYUVZRfS7/rHZB7CX
	 wv+LK0ozhIupo7AerhN00N6qrKXqy8QDV/TZ8jUvyCokMnGEAzFfHEaAgED/0iwNxp
	 l/G0VD0ZqNIk9Ykc6CPowmj3rhfqi3bQO7Fptd5LeiUEjltabRZIMzN5YbTd3EWcpu
	 FSd2Lw6JqV2GATI5Fj/qI7Ov0HtCWe3pcrKCE3FlXg7i+mK5kB9M5DTwq6WwiTwbBf
	 VwbY1IjVOo7Yg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B354B6081D;
	Wed, 21 Oct 2026 16:18:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 01932356
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:18:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DB4DD408D4
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:18:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bYQP0bIC96UF for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 16:18:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9EE1340728
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792599516;
 b=JKiZHYTffYlJGnKTaguPN8JPQgblBpduszYg9nlnjHuOf9aroraKv2XwJF0QDkrIxjXm
 hlWzpUVOHD8kFNrx4vJl20yMsxEM4McJLJkFCORlw+VbbNek2mZjOkctm8gat86L9Wy2w
 CBJVXabsXix7juLeG5S2kkMWRkNRGivzul64/vCjBg3atS3HbLwLNTTj2ZaoayZP148UL
 MQGMXjly9MBo8rgG0u+3hofdkeNkDu9Wx+B/8ZYN5/ivsZ1tWoFaUvYgpnhN/fe0SQxLa
 UgP1Lu5YvoH1WYsjDj8+SZV5t4jc65F7SBE0uv3Y53XtmoFxuSEdXoukJCFbwFQP7GA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792599516;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:From:Subject:Date:Message-Id:
 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=FUvp3DGOJ16FHo4Wy30sOXIXEwMSx3R5ZWyqhf4gIRw=;
 b=OaTR4JN6ayLbidgy3dUAtEXt5mpXYGpTedUgj9ZWka3Q0kjUFWlFTd/rIlKT/OpIGIse
 cDAm4LR+QaZDmuU4fcIwsUQ5DProfkAEKmrWOtU9ntWhlWoWrzE7MW/s89tleFJ0IX9E2
 Jg2Us0QdwV62L2H9BkWiLS7jC2BKR8vXq3yYGP+GFB/ZLuN/HF48tipA2khDjDFamQdUR
 p5DKSvHMWPBL0VH7w97p0Qhi2zxsb8G59uK31W2+VHvzs4c2VlvfiQ/QV+1PNkZ2xLVBK
 itHrpATsytJGBfMVS7STaenNVqf8+xD0SsPZat8Ityfr+gUu8FJuLRWS4RM7CeU+EiA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=P2+3c9l5; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=KAoY4fEM; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=P2+3c9l5; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=KAoY4fEM
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9EE1340728
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:18:35 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LFeuDU1016331
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:18:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=FUvp3DGOJ16FHo4Wy30sOX
 IXEwMSx3R5ZWyqhf4gIRw=; b=P2+3c9l51i1BGlZO9u521OFn3lrH5qQ/n2P7QY
 7aCGLvxR66GIId3s/FtGfCXBoA+5v5jYDeNn532/PNd3F/reN4hox4XT9E1xV/UI
 m7es4ZBPiq2VvDklLCqrxKv14FzOmyyUOKRz3s81MmnKWMr6u/4AGSuMf4pxxdrV
 SNBDI/bMyZYB4QlvLGM9Yg9PLQpD2DVCcNLyIWLvwIxNWWUeoCwOqau8t8W+Cvkd
 Ivl5utib/l6iykuMr1ND9PyXPSOEoHU2x8quM+CvHR8rscZIQlw8+62qK8d6Y1Ox
 tEum9MwPPGLTc2o3wX3liChyc48JnpaNBuK6XW8QKRcZ4Wqw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4heh5r405d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:18:34 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-36696c9f55bso12273eec.1
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 09:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792599511; x=1793204311;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=FUvp3DGOJ16FHo4Wy30sOXIXEwMSx3R5ZWyqhf4gIRw=;
 b=KAoY4fEMW3jfiidNw5s/1ODsowPe6HON+9nssO3QDXPKlHqzteJZjqDzsTyOAqL3wq
 QqlpDNMBEOrzDOHc5VkSlc7Dmv+07k0XhEm5W1n8MMON8OKL2nzumUx5T4YxG7nqDSl4
 hZAltw2tnd+sAy9w4/HiOlm2mNI/F9koMmJsqjdL+tXRLFuw+9ERvGqSz6N+xeI/8aMT
 8D6ejRYJf6cji7KxB2NJiMLYEhJ/Ir8m+zociCcvUIgXfyijYRldCwyer6jMn/cSJy5W
 PRIXWAiJQlOSLQAnomiev6ZeubdfpoOphJw2ADQa4vGmK2FX823D1xKqQatZ3nBbTahS
 DjpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792599511; x=1793204311;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=FUvp3DGOJ16FHo4Wy30sOXIXEwMSx3R5ZWyqhf4gIRw=;
 b=jVJ+znkQcI+NaPDbuUr1IMc2cZjBhm4imDMfOW9khrUBrn/AK41q/MP8qLnjZIxM8e
 8j1C+UjYTRKEwsp5JpTFXIZeXCHZM7oG4cQzQ7Mu48/vRS+t1mtxQ8BzZlnZDtuQrA7G
 Cj0kSmSdjgHZc01BYU6upH9C0TTzFdWm+BvX+tmLu78tcPJqGXetfXsYR49fqi2Esksd
 MJ4rxPWt8WvOK5FnL+i0ciURbLWEGsxYozG5uOj7tRcy2JE4FwpI8XQRiqS+KWUYW9P4
 1s1mGhEcx73txkKJSLRAbJLkxnzXeL6t72LlS2M0hCQAXuWh2kom8711rOqEVfCc/Ptw
 JhpA==
X-Gm-Message-State: AFq9FYJJQcnPCJLMi2c+9YURU/wuV7lHFK0N8to1QhoJ28UZDFq/wgIJ
 Gh5n9s8SIycfwEFTsgoopi6tWAiyK9N9qOMDD5/aVpmjFXNNBQm/YvVR5CgpOQwXMWHsf2ApuKo
 aMgQkwb1C1keifMd87fmEWLtZyCWiUexVGGprFr8vi48BmT+UyLd9fImD3UMAYnXZHOAOhSU=
X-Gm-Gg: AYBFou0NIk9rcjRx5oHopgQGCT24R8b6zVckIgAoT16z8nWrU/E6BJjlUwD//CGo6O5
 Y4XSetx6w3Ag1ens1bccxRauV0s/MJlHpLwEjA6Y9VPyj12drbkIi96ghnwJBh6kde3fazDjNAS
 +CR3DbFsu19AxTG57ujXwm5mngVTzZ+oN/Mhs2jNCZwiY9dC+U+WGjpG5sBWbK5jDAXDcomou1B
 76fL0GMLHx5ToNlVDfpoJqovuGOtEuLUo+POwS4PrbluJwne08p9fHuQh42EZVKjnxvSN7w3YOs
 eno54Zu0HHhLcGyBzhb2rjikvBgX6ddnlWRtBLtWuQz9nDDtQou948w+DppzTZDlDo3YDakB57u
 HuQ9jedB0dwmdAxUIqfzsDSrk2qlSOJXSnBaWvRc2M5GsmHzHCY3az78kAnOnimOR/25WLYXxDJ
 fz8c+BxHGt6WdaZwhgOLOvLcRy/0s=
X-Received: by 2002:a05:7300:c3a2:b0:359:27e6:b684 with SMTP id
 5a478bee46e88-365f82a7dbemr6564811eec.3.1792599510856; 
 Wed, 21 Oct 2026 09:18:30 -0700 (PDT)
X-Received: by 2002:a05:7300:c3a2:b0:359:27e6:b684 with SMTP id
 5a478bee46e88-365f82a7dbemr6564762eec.3.1792599510086; 
 Wed, 21 Oct 2026 09:18:30 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36740cc88b5sm8764143eec.10.2026.10.21.09.18.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 09:18:29 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Subject: [PATCH v9 0/8] arm: snapdragon: Add snagboot support for
 Lemans-EVK
Date: Wed, 21 Oct 2026 21:48:19 +0530
Message-Id: <20261021-snagboot-v9-0-18ce3e431320@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMvl2GoC/3XMTQ7CIBCG4asY1mKm/AzUlfcwLigOSqJFizYa0
 7uLmmgXdkPykXneB8vURcpsOXuwjvqYY2rLqOcz5veu3RGP27KZAIFgZMVz63ZNSheuqA6IAYQ
 WW1bOTx2FeHun1puy9zFfUnd/l3v9+v1ELMhfpNccOAAFpZWopaJVynlxvrqDT8fjojzs1epxy
 mPxZJtgHAYPTk148/UVVGNvig9e1OiksBLdhLdjr0beFm+8o2BRo2jMHz8MwxNAReVSZwEAAA=
 =
X-Change-ID: 20260731-snagboot-4e9f66f0252d
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
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792599504; l=5946;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=1vx9AhZfblAfQW2TrOUwEHun675ZCSJkoxd2C5l3gMY=;
 b=pP/tiJKJEvWvK0EGOzjdA0ZG0ZuR8U15AzwVSEyX+N6l5GFwOOeSH90eEmKSImvffeoC25Xu8
 /lpFYZSB6m9DyDjmQTcULPorPcuM/yzAFwQoQnnsc1vr1et5SJnFs1C
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Authority-Analysis: v=2.4 cv=aI5lOr9m c=1 sm=1 tr=0 ts=6ad8e5da cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=gu6fZOg2AAAA:8
 a=4GZlKNTyZuL0fuDD4_0A:9 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
 a=2RSlZUUhi9gRBrsHwhhZ:22
X-Proofpoint-ORIG-GUID: QtZE9QF9Al9ffvOnHSsHANtiRC75wpEk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA2NCBTYWx0ZWRfX/t7MvEwtzK+i
 Dv8sCVYQ80Wr4wh8aBMGxtQpk9haGdRxh8CRBWxCR1VHNIz43QD3LRYHw4eMIGJKFXzwwLphogf
 rWjbaEVVL6xbGfwzdK1M82SHnz5BuYUsD1PLlNH99p/L3FmVeRcR4OxP/1Xl//cZmlp61/LWZrw
 E/VHr3Ssezj7135/HVzpoSw7ADvkVhuLzAhb3r/AUG+nzj9rqCowlD30lXaIIhxaW0SlY7T1Ulu
 287zdJcgP7Hti2aZ7yL8JrRZdUdvmhKM9lOH2JqF0mNJa2oCavmsU2h5bzBTFzisx7JZE1qe4hV
 67cAHkvjUBQueuHZf/6a1Efm6BvwVeiIWkj33SdeM1B8OTwoWSxD+jPJAUmhpWbnFW//nZCI/By
 nBkkMa+HM1hYmIkJXdGwVd6yiYUQX3o8hlkE7dDjA1gRhwNcnAZS3Gx8X+g/8gY+4mRBTA2nX3k
 DBguJIWlFBuISTvKrmw==
X-Proofpoint-GUID: QtZE9QF9Al9ffvOnHSsHANtiRC75wpEk
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA2NCBTYWx0ZWRfX8tjDx4+fqEtE
 5Tgx966wT3bt02cznJQfitVc3FstobFFTaVJ9MUZZUX3jg2uJIbjI7yM63Vj/hphjN4LpqiAMy5
 wKCKwt7pJQt/XydpnYB4B1dKJfys2Bo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 spamscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 adultscore=0 phishscore=0 lowpriorityscore=0
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
X-Spam-Status: No, score=-23.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series adds support for running U-Boot in snagboot mode on
Qualcomm Snapdragon platforms, targeting the Lemans-EVK board.

Snagboot is an open-source, scriptable flashing framework that provides
an alternative to the proprietary Firehose protocol for device
provisioning. Like the traditional EDL+Firehose flow, Snagboot uses the
Qualcomm boot ROM EDL mode and Sahara protocol to download
and execute bootloaders. However, instead of using the proprietary
Firehose programmer, Snagboot loads U-Boot into DDR and uses the
standard fastboot protocol for device flashing.

The framework consists of three modular components: snagrecover
(downloads XBL/QCLib to initialize DDR and load U-Boot into RAM),
snagflash (communicates with U-Boot over USB using fastboot to flash
system images), and snagfactory (orchestrates parallel factory
flashing tasks).

In the snagboot execution flow, ROM code in EDL mode loads
snagrecover, which downloads XBL to internal memory. XBL executes
and initializes DDR, then snagrecover downloads U-Boot into DDR and
transfers control to it. At this point, XBL has left the MMU enabled
with its own page tables and has not initialized PSCI firmware or
populated the Command DB. U-Boot must handle this non-standard boot
environment to enter fastboot mode for device flashing.

Support for Qualcomm Lemans-EVK SOC in Snagboot is available in
https://github.com/bootlin/snagboot

When U-Boot executes in Snagboot flow, it has to deal with missing
platform services such as TrustZone (TZ), Hypervisor and AOP (which
populates CMD DB data).

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v9:
- Drop the assumption that snagboot mode needs IOMMU disabled:
  QCOM_SNAGBOOT_MODE no longer depends on !IOMMU and
  qcom-snagboot.config no longer sets CONFIG_IOMMU=n
- Link to v8: https://lore.kernel.org/r/20261014-snagboot-v8-0-7caef86562b7@oss.qualcomm.com

Changes in v8:
- Make changes in documentation
- Link to v7: https://lore.kernel.org/r/20261013-snagboot-v7-0-fc296a32836a@oss.qualcomm.com

Changes in v7:
- Rebased on top of latest main branch
- Link to v6: https://lore.kernel.org/r/20260803-snagboot-v6-0-e8bf7a6fc0a4@oss.qualcomm.com

Changes in v6:
- Forget to send summary in v5 cover letter, no other changes
  in v6
- Link to v5: https://marc.info/?l=u-boot&m=178577208345353&w=2

Changes in v5:
- Make QCOM_BOOT0_SNAGBOOT_MODE as hidden config dependent on
  QCOM_SNAGBOOT_MODE
- Disable C (Dcache) bit of SCTLR_EL3 register during MMU disable
- Remove now unused QCOM_COMMAND_DB_OPTIONAL Kconfig definition
- Disable unnecessar I2C configs (for Snagboot) in Qcom Snagboot
  config fragment
- Add build steps for compiling U-Boot for Snagboot mode in
  Qcom Snagboot doc
- Link to v4: https://lore.kernel.org/u-boot/20260619-snagboot-v4-0-385497442db2@oss.qualcomm.com/

Changes in v4:
- Renamed QCOM_SNAGBOOT_SUPPORT to QCOM_SNAGBOOT_MODE
- Make SYSRESET_PSCI dependent on QCOM_SNAGBOOT_MODE
- Place Snagboot related configs in seperate config fragment
  called configs/qcom-snagboot.config
- Include above config fragment in
  configs/qcom_lemans_snagboot_defconfig
- Removed Lemans EVK override dtsi: arch/arm/dts/lemans-evk-u-boot.dtsi
- Removed QCOM_COMMAND_DB_OPTIONAL as now we use
  CONFIG_QCOM_SNAGBOOT_MODE
- Added documentation on U-Boot for Snagboot
- Link to v3: https://lore.kernel.org/u-boot/20260616-sngboot-v3-0-6fb0dee8125c@oss.qualcomm.com/

Changes in v3:
- Brought the MMU disable logic under CONFIG_QCOM_SNAGBOOT_SUPPORT
  ifdef condition
- Moved the MMU disable codes to a new seperate file
- Used "if (IS_ENABLED(CONFIG_QCOM_COMMAND_DB_OPTIONAL))" instead
  of #ifdef
- Removed enabling QCOM_COMMAND_DB_OPTIONAL, ENABLE_ARM_SOC_BOOT0_HOOK
  and SKIP_RELOCATE as they are now automatically enabled by
  QCOM_SNAGBOOT_SUPPORT selection
- Removed updating MAINTAINERS as the defconfig file is picked up by
  the "N: qcom" line
- Link to v2: https://lore.kernel.org/u-boot/20260608-snagboot-v2-0-036bb0343bf7@oss.qualcomm.com/

Changes in v2:
- Changed SYSRESET_PSCI from 'select' to 'imply'
- Guard show_psci_version() and qcom_psci_fixup() with CONFIG_ARM_SMCCC
- Disables the MMU and invalidates TLBs at the earliest entry point
- Add qcom_lemans_snagboot_defconfig for Lemans-EVK
- Link to v1: https://lore.kernel.org/u-boot/20260409-cmddb-v1-1-b10549b34133@oss.qualcomm.com/

---
Balaji Selvanathan (8):
      arm: snapdragon: Make SYSRESET_PSCI optional
      arm: snapdragon: Guard PSCI functions with CONFIG_ARM_SMCCC
      arm: snapdragon: Disable MMU early before U-Boot reset vector
      arm: snapdragon: Add CONFIG_QCOM_SNAGBOOT_MODE option
      soc: qcom: cmd-db: Allow boot without CMD DB data
      arch: arm: dts: remove Lemans EVK override DTS
      configs: add qcom_lemans_snagboot_defconfig for Lemans-EVK
      doc: qualcomm: Add snagboot mode documentation

 arch/arm/Kconfig                                   |  2 +-
 arch/arm/dts/lemans-evk-u-boot.dtsi                | 19 -----
 arch/arm/mach-snapdragon/Kconfig                   | 19 +++++
 arch/arm/mach-snapdragon/board.c                   |  6 ++
 arch/arm/mach-snapdragon/include/mach/boot0.h      |  2 +
 .../mach-snapdragon/include/mach/snagboot_boot0.h  | 27 ++++++++
 configs/qcom-snagboot.config                       | 45 ++++++++++++
 configs/qcom_lemans_snagboot_defconfig             | 18 +++++
 doc/board/qualcomm/index.rst                       |  1 +
 doc/board/qualcomm/snagboot.rst                    | 80 ++++++++++++++++++++++
 drivers/soc/qcom/cmd-db.c                          | 15 +++-
 11 files changed, 212 insertions(+), 22 deletions(-)
---
base-commit: fed92546960a92177d67c0b8d7b22385f50fed29
change-id: 20260731-snagboot-4e9f66f0252d

Best regards,
-- 
Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

