Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C46CCC6B0F
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 06:50:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D42C24062B;
	Tue, 13 Oct 2026 06:50:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eOKyzLfNDpHr; Tue, 13 Oct 2026 06:50:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C0867405B0
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791874204;
	b=MH5TWASkJxYxqyN59K2dDEyk3rDBTVIF0kcti2IcR6+0u+08kYPETwjiUuKlOU4VmlVQ
	 UZx6xZJwK/4je8Dzn+tdRNty88m+pqgyrTOfGwos1t8KMvXRopap4PcXKl7Z59P9cDrPl
	 NFBqBagcPxxLFdhg77BxaMIzcH365A0ld/U9wF/jsh9RAhsnBZJxcJqf9uzH0kBJJLSAE
	 6R96/MeiHKQo0fk+WVmPM7uwLLRnX7SvdQplfAxf41VoyHwvJbDnxm0ELaFoqRvmAI9Ug
	 1FQNQSj69DmY/7Bknzvk46qAcz75AX1KA5Xr0ZyjiYt/Gv1ZH8KrYhWGwBbG97GLhaw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791874204;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=duR8J8UYlOfYhwYHkRhXTsZlL/jNWSJG0mRwFT5x/Qg=;
	b=qnb9hRzfnVgvLhuUk3UV1w57vAePjlJL1Td01eH7MHoMjcJpThb7Hni2Oe85phj5z/uO
	 LY5rKibM0B6my/U9K17IXv+bh92s3c/TEZxT3AIop64WUgB/MWlFK9PM64DBJ7ixxLOo0
	 dFAwSY63zZRSJ8JhALub8+vDDA6N/RBq57hrBao7H9hRfuik1lSjczlxaB6D8wP2WIRSz
	 h7wKItbaFgKG0tFR/cifIBqNzFCPvIDu0RVyncxADc2GwttItpgwVzvjlpjrycI/i7KLR
	 9VgZ2vLzCR/U3W68QilTnIRRMEoaA3zrnr88Jsu1xwgmsf4VMwFdhYIIXasAv3p2Gzg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791874204;
	bh=duR8J8UYlOfYhwYHkRhXTsZlL/jNWSJG0mRwFT5x/Qg=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=vE4d63Jf6wwJXXv4RouoV3QSVXYklEjzH1q8ehBjCvtW6WUaUdqEMFJwoWgWOBUTE
	 RLU7Q6iCdAuP16pogIGSIzum2Xj8oOJW7IQCUxwFX2mRTmI2xqaKBmLnTI/Z951svE
	 wRe9mLT9NXv21/jQ4sN6A5JJNSDeT9vgn+hKyaDj07IzCEr4aX13PYVkwW1KzSWBZe
	 hEUBRx3ilLfQ/EoAGv2zWNzfqS+811CYLPO15yJK7twQ64tZZSPKwi+o4sO2NrE4Lz
	 j838VPgOToKRIe1AT5OycnG0yYOafTykDh8j6QlWdUozc+hJXuRSWfkIxIhGH6rskj
	 zhDEXUNDxSqHA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C0867405B0;
	Tue, 13 Oct 2026 06:50:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 78570A58
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 06:50:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5DAFF80AD0
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 06:50:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Iu-5ywq7pxIr for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 06:50:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4808F80C16
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791874202;
 b=rNW/Uu41xTT/A7aVDzmOxdT4EqdapmmVSnrHJlGdqnIfx/rxiGE9v8uo4BwyUb3zAuCd
 B6CSKmtuslj3G+nHk7ssRFj6NRF5HomXUGdkhHyOInTNp5G6NaG2bivazQkTcR26GAVLr
 j0J3dBJoT028T0w2LROHfq24W9AYY5EiuFCRDVEbDY486UjWRgSSS3/rEzF2WmQZulGUy
 YAc/ys71CzC39bzwZ29kO+kzsZa3skOxJswzWoudnCbH8BpaPBI7fv9s4cj7HBmgGLoPj
 AsfquD7mfblSTJZdd6njeBtF8ZWOYzTfzt+QV+RR5GxStySR569j9iQp2M0oqVzCoEw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791874202;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Details-Enc:
 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=duR8J8UYlOfYhwYHkRhXTsZlL/jNWSJG0mRwFT5x/Qg=;
 b=rePzigBKkHD8W3pkJUuSsQyQw3C4saRlNY55ngxVha8wZHMBGtopxiCFb9NY028jas9n
 LULc3zfqEQwerGH7QMskZkM9FPt8LU2IjElDBis6Y48I4fL6ULRh3px56ikKZR1mjOFtK
 Jb9mXIZzIqQGnyeoFjkKdq5IQDEwV/NGpF0qYUVj9yXBJLqADr24xMYVUhSnl1G0oUsej
 AQ6O5Ox37VDJmas/5jdybf3bFSe5PAOTC3LMjMaUZan7D51j0o23OQ0ApGkvrw6CiCrkh
 oLOB3TnVqpZqGs8AF7ff0VldMACAR7LPj/V+eawW+5ZF4zNjG0rQp//aC/XqLKTAerA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b="aL/IAVqD"; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b="cZkxV/qc"; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=vandhiadevan.karunamoorthy@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=aL/IAVqD; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=cZkxV/qc
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4808F80C16
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 06:50:01 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69D20rAv302935
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 06:50:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=duR8J8UYlOfYhwYHkRhXTs
 ZlL/jNWSJG0mRwFT5x/Qg=; b=aL/IAVqDm7Kc1m1xaLCUjIie8QJkMQv0WClZcj
 S1pBqbU0yM/JhS6HPxNiN+VanCgWVAIQJ3Q1gGEPSOzTYjwoqffOLvZOEHIsBY3D
 V1zuE0mOeSrmPnLxQVktb5dIHEmKfgwpZWL0oye2u8ncc2L4Q0nTTIA3evF7xRju
 8PSnEA49oNNoNvsFxUGnrE+Od4WKWFzUeHckcgojAKMz2rc320Om92Tl83zQYrS1
 xgm6TLLwW6I3WaZi0tNNwF/XwbZXUlb/sR89NTqEjMSq0J3hPvCQopB96Tdi27N2
 +cQ3Pedppmtd+TyTh+HJhAVrUYyasEF1W6r24lWnd2/jTrOw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h98sq9eyf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 06:50:00 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-33c35f5ca6cso6386991eec.1
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 23:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791874199; x=1792478999;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=duR8J8UYlOfYhwYHkRhXTsZlL/jNWSJG0mRwFT5x/Qg=;
 b=cZkxV/qcUZwFQXo8mV4PxBwLmGzamUxGCbE7YrJoL99JFRyQwXZdpHBYZCEicgBHcD
 jaiOTlsD7jmmHLTOWP9ApAIeNOyJcCSerKjKQ9iK9WhJLyu/ew37fFFRfSCTia1nOdGw
 xY6SoZ5Sp8BDSqpq4zR8fyT+hmK1N2dY5jP9j0RQcqL9X1AYtFn5eP3b6e4wmoTTu8fX
 vcA3zJh+klach39GGVM/68fqqNz2xL4UBRZUAOIkWvSWn62eYz+F8hNmo0nENHtwK3h9
 6Pjto4SnmWCua3rsu3w1o513z+jSeZJQKohmpRGMq3WKDgP+cT8gDbng1QvOwF8gugOc
 BWrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791874199; x=1792478999;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=duR8J8UYlOfYhwYHkRhXTsZlL/jNWSJG0mRwFT5x/Qg=;
 b=pdvdwlCkbIgbuRDTWH4CUN+9zX8bsbv9ioKMs/q6Urak+mWlHrwzyuRS2VgacSlH+o
 m63Yl7SmdFHgJzrZb+9/cPx/PFje35YCWoALfWOT61sMC1JCHDMGlJemgs0vV8oYsaWo
 R9YLsunIkZwTOe49Ye7NbO56tNdSNv2+W/D5jXlYwJxDRG1TJVb6LpzHtH6v6ghSkulp
 YJNW5lkAWC4o2MmSrjvRk26frWjwU65OxHpy/AmZGN7zghYKgi4njPWY2ZGu/QPeqZpg
 o3UrmuE0WJPMALn5eXUVwOJFmA+IJwi/PX3L/X2oyf0acvFcH0lNMHnriNYXbZFKxiRy
 /Aag==
X-Forwarded-Encrypted: i=1;
 AKwUvBw52YYlPRGndbnPtUHPJH1XhWnfnzKdgADkhRvsXcPjGJHJSJYtVbXG/fwTU9ntkAzyN9rUJE4=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLuXTrGbub7/DvJ0JIuqvcg2hrwdlvuIh4uyyrS8JSKlMZzSsUu
 ADwWcsOCdUpjGT3Rj0k2NhvMmv9gjuTL9jcF4oMH6rWu9BA8NeCsPK4wtC3jgo2atIrY/6cWXKc
 7rUNEMTbYyTJhtWrqAHQXSOChUYYxtPGprO76pe7CvEH+2M3aQpG7sX+VWCricwEMcNbrS7w=
X-Gm-Gg: AYBFou0/lmALyeYnBtzRSiGqm7Qs7mx7W0pF60qFad4LKlEVXtvxFK6ePnlFTrJtUu3
 WrH+0yb2d9Wx/1wYBA6RYSp9LyNX9jDlfYp9AUcDRbsShtROEMhL1he0deS3aSIUpGpNB4Uwzy7
 jZL/t1yKuzlVM+v6cfYn+fRIGnnOlJTMu/nX4lKS6V5D7faQ+h1CNzD4KNjL5gZS8ZA6puryzBu
 bFypinvK81WtFb0P8liJLn3IsG393viwyD4+JkSGI/twjTo5CD4nC++n/afQuWO+L7ldOsFj598
 9yM2HsYnxTrOJKXfqWPvN6zz3ZSTQRhejvQLgyH/qh5t8zUle3omFJnJRkdZw7YyIjHGXln2GTg
 cjVJo8oBF65e7fGq2eAiKeKLCBMEB4exy2b6DcPkOgZoSnCrKEhfwLork1efTSI5AhEpwH/zecY
 5YP0C44PPY6+jwIfR+DiNLqFs8Oh0sBO4X1jFxSQ==
X-Received: by 2002:a05:693c:4196:20b0:35b:af:a075 with SMTP id
 5a478bee46e88-35b00afb749mr6600942eec.22.1791874198916; 
 Mon, 12 Oct 2026 23:49:58 -0700 (PDT)
X-Received: by 2002:a05:693c:4196:20b0:35b:af:a075 with SMTP id
 5a478bee46e88-35b00afb749mr6600910eec.22.1791874198347; 
 Mon, 12 Oct 2026 23:49:58 -0700 (PDT)
Received: from hu-vkarunam-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537c61eaa0sm44776545eec.0.2026.10.12.23.49.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 23:49:58 -0700 (PDT)
From: Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>
Date: Tue, 13 Oct 2026 12:19:54 +0530
Subject: [PATCH v3] misc: qcom_geni: fix NULL pointer dereference in
 qcom_geni_load_firmware()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261013-series3-oem-spi-nor-init-v3-1-f621792686c7@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAJHUzWoC/32Oyw6CMBBFf8V07RAo8nLlfxgX2E5ljFDs1EZj+
 HcLbNzoZpKb3HvOvAWjI2Sx37yFw0BMdogh326E6trhgkA6ZiFTWaa13MHaz8FiDzwSDNYBDeR
 BGmxKXe7y1hQizkeHhp4L+nhaMz/OV1R+5s2Njthb91rcIZt7q6bJ6t+akEEKedZog6hLJdXBM
 if3R3tTtu+TeMRsC/KL9+/tICPP6LpVssIqLaqDR/YrZ5qmD04FDOMhAQAA
X-Change-ID: 20260824-series3-oem-spi-nor-init-2fe96d643af5
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791874195; l=1719;
 i=vandhiadevan.karunamoorthy@oss.qualcomm.com; s=20260817;
 h=from:subject:message-id; bh=CUw1cAQzAZC3ttUvpwBLBwsJbtwIP8QxiMH/Mfq54F4=;
 b=hKWux5z+VtCyGjIVK8t9jJOpVkaQwb+wCxjZMMgYje9Nj10YlQd/TGuF6ZqMFP0575DrPCQgs
 fDU2rF1Mg8mAYCDD+s69E04ZEI+vjfeSA1QNqT5vk/uHrcNBIvKCSbV
X-Developer-Key: i=vandhiadevan.karunamoorthy@oss.qualcomm.com; a=ed25519;
 pk=2EVV7DmKqYX4wxSlXPB5QBt44JjomLlz/wTW2AL4H6I=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDAyNyBTYWx0ZWRfX2zllY0QY97SP
 wqO3A5NxHlihM3PPZrS68ySRgbH0zSppJ0C2YGUAji8StES9sDxNqFtyQCl08eLnfmgZTy0dSIF
 Ilo/JMmQUlCTW4GesvC1c4b6adehPkU6EN6s2Gk2c5lRDkJoIc4Idlu/wbX5zlN2tZP8AohKB3q
 z5D2Zt4UFO229zPy/oYPZYHgW9iZWr7rAulDKtJp6V1rtqKx8F8ZJuuLS+zRR5sw/vvyWrp0V+J
 vrdzubTpYSb1lz81GOw0gU91i6l4clPZbzyfOndZ6Tdet4s6gi5JNAo+68Ds9KHCyd2iCrWLG+i
 +aQ9Lujcg4G7uRoWWXFYQ1gijg8LdhTWxMR4uq1WWAsg4eqfzqFB4fa1EsM2NE7MZUOGeIIfkoN
 1l5UbMqpIhamqzaLTBpqiJWGVg4frYMYv+/32PGXAJkVZ6R2tLxMn6AqROD2gXtsSUDACyVjv6k
 xIsfJSwGU4fhPVauy8A==
X-Authority-Analysis: v=2.4 cv=JN+uIMKb c=1 sm=1 tr=0 ts=6acdd498 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=bC-a23v3AAAA:8 a=r6LF-9bVAAAA:8 a=EUspDBNiAAAA:8 a=ahTRo_KIBJZTkFoebYsA:9
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22 a=FO4_E8m0qiDe52t0p3_H:22
 a=sL0kBDm1BSwOBZmmfnro:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDAyNyBTYWx0ZWRfX3vnPq1j+SU4d
 fADWaJiXh4UhcavIDD3lRYuDX6In6QEs6YFKT2XOxqolmwLF9D89e7sNGkXTAZIHGV8ej29GdO+
 K96hzrzjw2jFfloWGijRC8bdX5Hu7V4=
X-Proofpoint-ORIG-GUID: f9Idmt0glR8eZ50wwhjx1SIGbdL68DEu
X-Proofpoint-GUID: f9Idmt0glR8eZ50wwhjx1SIGbdL68DEu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 adultscore=0 suspectscore=0
 phishscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130027
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

qcom_geni_fw_initialise() only populates the GENI wrapper's private
data (fw) if it finds a firmware partition at EVT_LAST_STAGE_INIT. When
no firmware partition is found, for example on a board with no MMC/UFS
storage where the firmware has not been provisioned yet, fw is left
NULL and a later GENI peripheral probe crashes dereferencing it in
qcom_geni_load_firmware().

Add a NULL check that returns -ENOENT instead, so the caller fails the
probe gracefully rather than crashing.

Signed-off-by: Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>
---
Changes in v3:
- Drop "cmd: qcom_geni: add idempotent qcom_geni fw init command"; repost
  only the NULL pointer dereference fix
- Rebase on top of upstream main
- Repost: v2 was sent with a wrong author/Message-Id domain (test.com)
- Link to v2: https://patch.msgid.link/20260924-series3-oem-spi-nor-init-v2-0-fd8ac27e7057@test.com
---
 drivers/misc/qcom_geni.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/misc/qcom_geni.c b/drivers/misc/qcom_geni.c
index a62ae6a2478..2e8f72d5c8e 100644
--- a/drivers/misc/qcom_geni.c
+++ b/drivers/misc/qcom_geni.c
@@ -376,6 +376,10 @@ int qcom_geni_load_firmware(phys_addr_t qup_base,
 
 	/* The firmware blob is the private data of the GENI wrapper (parent) */
 	fw = dev_get_priv(dev->parent);
+	if (!fw) {
+		dev_err(dev, "QUP firmware not available\n");
+		return -ENOENT;
+	}
 
 	ret = read_elf(&rsc, fw, &hdr);
 	if (ret) {

---
base-commit: fed92546960a92177d67c0b8d7b22385f50fed29
change-id: 20260824-series3-oem-spi-nor-init-2fe96d643af5

Best regards,
--  
Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>

