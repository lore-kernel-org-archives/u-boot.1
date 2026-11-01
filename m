Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60385606A324
	for <u-boot@archiver.kernel.org>; Sun,  1 Nov 2026 10:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=kfBILVa0;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Boq/SFG+;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bZol51Fh
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 39FAC80DAB;
	Sun,  1 Nov 2026 10:20:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SrMUrFjmqIx1; Sun,  1 Nov 2026 10:20:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 83FD680F7B
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793528407;
	b=WL939PTMGLOKq9L+7GM7m9o8/jOZ2Zi5STcCz8GCSgvMPm2ODxrHgFxTP4m+8oBPsiqH
	 X6IeJ1nD13rDSWTqDXtY7j3pN6/XQVXX2TBvnAGhZ48pek0J/T93AOQ0HOIvCKx/v0skA
	 t6Esp01P226Sijv/uEF4ln4n7FTjNejiGxYCRffIfIjNIHU7p8MRi5zshshF2lctaTNh9
	 UMrAjfV8KNUC93V3u6nvYcs3jsqKhiurEPafqTNbSx08JToTonWCsuKN3xDc38rKlAiEB
	 TvA5peRNlgdAAZGCvjyQ+NjPIFlin2R01KP3eYFn6gegKzd9POzximu+4CXnWHYhaHg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793528407;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=kVRdztV9+ihwIRFdXZQBl8KwBHByWz4qtmJE1wjQr9I=;
	b=tClAYyqGMYEBb6cXXIrj4zBu7M6B2oIe5MrmzEikKGMBB4/K2wTptRtGcLyX0zXWZDvL
	 IhY1QIvVUMHtGpFEdWl0+uvVkC4rQ/irlrSHLG1Z8otoaxgaFc+Qd4HKDWqTppSxIw+RF
	 diprudOAQPn/1aYxD2RCeG6VDY48XeCHfBOMcBYavN6xKTBvJPbBCddzn7ti2fJi4rih3
	 gW4e2xSdu/FSXY4O5NQUKCDNNeHIE3QOwGNTPuBYkJpGhEXvz3GFSZ5U7ASK1SsXjofwr
	 8AFaTFO2rBIL1cE223JLBW58A8H8FI4nLeAcsPwkuaPR7+pKn2ur/Jiwo68NelRhc7g==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793528407;
	bh=kVRdztV9+ihwIRFdXZQBl8KwBHByWz4qtmJE1wjQr9I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kfBILVa0WY3HAqt4U13KjY4Nfku9Z3hCJu4ufjz1LCVTNZacAeHbWhLuDb+I9n8Rk
	 Cyuz4ewriuO/wdB0KeriyeweqtNo5b21Pi6sua+/7LV9353ST5sHCqmIg1MFTT3lbA
	 Uw6yGPVho3fu7f1I3S3zbCIriBodHvibKOz1cacYqKZdMx/R9TjqFp3wow3YmrJX0l
	 bSWfkbrhv3BSl0Z6hHC27SvxBza98D4cQ4mkn6J4i5xtA8PxuErTXPIVfDmZgjpsvu
	 fq/MQ/Zvqv8GSx7VEAfG6AvkhwowT0txmaJCsS1QxsTmwNwiTkA5EwFyzVryqnZZpV
	 a+ButlDSXImxQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 83FD680F7B;
	Sun,  1 Nov 2026 10:20:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id E5B58323
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 10:20:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D77A9405BD
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 10:20:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CguZkpY_lYv2 for <u-boot@lists.u-boot-project.org>;
 Sun,  1 Nov 2026 10:20:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 34E38405BA
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793528405;
 b=MFmWdBpbZzuXX7N0oz0f64Yg+No7YJDRUQFCyMbKA6yN8A+r93wNNji/hu7MTDVMniGw
 jwV4xHMj9hDe1DYX0tuUozM+9ZaNs+RDAN74qXfFeN6ZCGhy61tROS5M7qNyc9ASb4Asf
 u4ynBDk/70qzBBMLhCHQHlTGA5siEGBOHSbV5cWAmr5V8Blcw2bfEra8+ZgGfHReX+QtS
 BEt9egQBIW6TflVApCxYLofzk2PEXkRT0v9yBHcmnD3gjMbAhvzxGwPaq+CdpbmSq1+5r
 EZxVEgrDURaKqwug5rPdC5OrQKw3KAmEKBYY8rY0qedJDMTvxWL09C47JeMbJt2d+5w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793528405;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Authority-Analysis:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=kVRdztV9+ihwIRFdXZQBl8KwBHByWz4qtmJE1wjQr9I=;
 b=nOLjuK/eZJ7aXWsge9dYFM2kvcDByJtr5LvADuB48OiyvQgbab44J/4sE4+B77kmNggC
 BR5EWKr4SAQYqVLxVdjKbJUqUFs8mGTci8eMs1urRXB8DPqZamLbVDv2NZzXVTKXpATlM
 K5Kz7cdCPXZs9NvDBTn/ZrWW4y87kwBI8EdODaoKMp0X5zTOOeGPFe0y//RQO8MLW2HdZ
 sDPnseY16n/pJb+MtKhKUL+L6l2rjaNQv/w/8f+g7/aDWcgd9whAViZEBsYqijZu4XRRj
 bVW7rV+SQCgDqKrwAEHrQmV3Kj2PHQcy8ndJDKqPUsUp+2aZcxPwi7Qzzejr4m+15AQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b="Boq/SFG+"; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=bZol51Fh; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=Boq/SFG+; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=bZol51Fh
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 34E38405BA
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 10:20:04 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A18Kd8W4190591
 for <u-boot@lists.u-boot-project.org>; Sun, 1 Nov 2026 10:20:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 kVRdztV9+ihwIRFdXZQBl8KwBHByWz4qtmJE1wjQr9I=; b=Boq/SFG+ou6ZVzpQ
 Bta43x4Xj55bCTUEf9kkXvjx0AEu5xuMj/NXcSlo6YLK2egsPzNZ8KS7BJ4KAeNV
 aJxKDJSadGtQUxLRsbWmU+rMWYryTFdwykrIBd5y42iN3pScyGfyXMQPJHYQ1UOh
 4PWdI6sZfP8Js45hRshTejfhntVvMaekQxfhwn9GP8DAJUcAih7crM00E52NiWlM
 gWUaKCWjDzJuS9Bw2xPOJI+MhKjlVJdJFh/V/rIUEEht2K/0YoHaMVKSYPxGesnc
 AbEOr26RyVizv7J0L7I8gWfwqsLYqlLme3/zgxZ1miWuedRi+PP90+WOxxEhUYZS
 QdrYbg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn7nfu8fs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Sun, 01 Nov 2026 10:20:03 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-359b81ad4e8so2925183eec.0
 for <u-boot@lists.u-boot-project.org>; Sun, 01 Nov 2026 02:20:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793528403; x=1794133203;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kVRdztV9+ihwIRFdXZQBl8KwBHByWz4qtmJE1wjQr9I=;
 b=bZol51FhH7upiOhJvWNixvfsUiRCJpmuATNUbQZ9v02QWc8DCJ94NVh94jhGM8rfpm
 ISepUuOciyFCWlELxBMa26d96o3WOo1FEfSdw6mwcXe++FT+AyItDOuXfVs2nwrPYMAW
 2O4BWHeHpdGLc/fZWIolPPFgpTb/p4HtJqwHTdAboQcXmOKBWeHcINRMyHNWFIIGbHaS
 JbuOFKt4sNbD8ex/TOTCkhH0jkjhoNmXKqOs/xU68MHz5grrPEDT/JsDmfbOBqJ9Vqfw
 S1QRR60Tda2FtHzgmYWnSS1ulsmXy78is0v3YvUnlhI9g98R+7MexcezLDHr1ulddxgo
 RcXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793528403; x=1794133203;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kVRdztV9+ihwIRFdXZQBl8KwBHByWz4qtmJE1wjQr9I=;
 b=Ha7+L/kd4EzNesWN/Iv0d+t8TynPflOQ4pp1IyPsZh0z8EJnxktZdQX83MPuYFhIBB
 UR8rzWBqm5cYL+dg8rcczwlMkkNREMcysOO+/3IX6RrDYZ/R9R4rulUQBnMEf3jUmePL
 pkcKyhsbGs33Vk1Arr4XI3FuNNA8DhHKkCUomux1kkucXgSGyEmFU9RJ1e5gdyY6kxOM
 C/OAjJynIVmgOv6TnFXnJkRPXcDZfveOe6cmDDESCrS5XXoMyW2G+M7TzUAHP2tOiT3r
 urPGS1QjY5kqUlxa5nRUTFLYZJA1/alukWESOVCyx6kAG13o3PA8NETL7RAqaWZB2pbL
 oNlw==
X-Gm-Message-State: AFq9FYI67S6B0USjA+NgheDUAoyuxPx0KXoUC41yoq5gb5ICQHsW7Jd6
 WYdot0EDz0WZ1VUb1vmuBBmx7KKcW3rVIV+LcW7FWvAV+aYsTE7Dlml4Do99OP6DxX8GgtQu5Mf
 s84M68+EZKhT79HTuJl85ofzrNtXew0TKQAw+WRfC1JLHsYhuQ6SBSTzv6d0j0BiZPnS7v+4=
X-Gm-Gg: AYBFou0ouBK/ClqZ3WPt9TY0zfyKtI+ywB+QqOSL+NHwAX0Bitih/5LPTLf5SWNaiFD
 DYzQt49DA21/Xf9PrrHzDRl7/4Wmspp8ZOxUP4SjC3ZT3PNaEPAUweITpFC8EG0ql9UDEiHT06e
 xRI4gw+GC+zUrkLFE6qPCYQAJYXgSNuwrX4o54Z7F6dnY9usmXw3F/qnU55H5iOwHHrKV2TlJ7T
 DT9Pkr5no5/iRlzP7pT/2Rovg7YTX1Q20HEN5jHdJDv58tmYWIp4Yx4RqTgESAF3lhKcJRWESFx
 9bMs0PkzMXpaFb9iWg+lAkKzLHUF9Qxdg0x5zoWwJiAbXOxxV189vd8YGVJyjFULUOezLEqZ5iI
 VdNFm9J9Qqh5wNnsc89ZS0Szr0LDBJL2G9CeegKBVAh5L/84ICC8ChpQFk1iI/H5yyEm3bXeEC7
 2PKhAy/uPxpqzxQm7WRbzrfP5zyMeNxMXtbBRqGCEp71bPgNs35yFeL/8XEGUv+71qFSY3GU2pu
 inaCQ==
X-Received: by 2002:a05:7300:ce0c:b0:36a:1732:1e5 with SMTP id
 5a478bee46e88-36a4243b307mr10660499eec.37.1793528402677; 
 Sun, 01 Nov 2026 02:20:02 -0800 (PST)
X-Received: by 2002:a05:7300:ce0c:b0:36a:1732:1e5 with SMTP id
 5a478bee46e88-36a4243b307mr10660464eec.37.1793528402130; 
 Sun, 01 Nov 2026 02:20:02 -0800 (PST)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a429467cdsm24596555eec.19.2026.11.01.02.19.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 02:20:01 -0800 (PST)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Sun, 01 Nov 2026 15:48:43 +0530
Subject: [PATCH v10 5/7] arch: arm: dts: remove Lemans EVK override DTS
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261101-snagboot-v10-5-e73d5cfedb8a@oss.qualcomm.com>
References: <20261101-snagboot-v10-0-e73d5cfedb8a@oss.qualcomm.com>
In-Reply-To: <20261101-snagboot-v10-0-e73d5cfedb8a@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793528369; l=1338;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=GM7e+hKlcoJXfn6OgxQ0cxZG3AGbFqYdzicz1CMYx3w=;
 b=Phutn3mUDyaOxUgVkopH736qghYoOqoQWmDDjLu9R1eF7qh+jitsJaz7fXjPMNjLZejYEdi7g
 oGfrS9MoF9lANI/ATvyVDUK4FzoOd/naJk0VLeJ7JvFBX+8nDBcSSZh
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAxMDA0MSBTYWx0ZWRfXySjK6uBu3lDK
 TpK5C78KuE1SFA55OL864w66vmk8Y2zQErAuFVc+Dzfpdlb4CbMsYxgPoo0y6YeTUnj5sNVQeu0
 KHmIsAGUe/H6ehFeVX35Ewrcauv5F14=
X-Proofpoint-GUID: 0AL-jjTbHf2FLOU7bh87OGGBVUd3Zu64
X-Authority-Analysis: v=2.4 cv=FJ2OVOos c=1 sm=1 tr=0 ts=6ae71253 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=ctXGKKDM2EbYtGMECBwA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: 0AL-jjTbHf2FLOU7bh87OGGBVUd3Zu64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAxMDA0MSBTYWx0ZWRfXyAdB7BOM/+Np
 fBWJnOQ9QQN6cQZmOdtYsQQ6uP/f8ZkKqJWzRAdP6bDwy4sxUYzv+TFMnyqTI+qa7GjHxYSmnLg
 TPoPy3vLKS+JrP9Sx9nByOA6xkqhyoRMH1JCiyruyW7m0ofLcSg9uVgzJm2cgypespVFudD7QLE
 fWSbpnRU3hePK2e9pVNEmw/Dn6CpV+vWMwFR3Guv0XfGo5YiziC/vEpGprC+iP+383NsjrC9HoU
 SWUgRlYZWO1BTKE67HDw+IavHSvw+mKdj8vN4+9Fpt7bs7L/VbdDypEOPP4zHb0LtRrk3Iv94YG
 d72t3XVKLKOABqrULIdUsfy4no8B7mDhOpKvbNppzjySqIxMwVLXXyadP9UZdVyIsb6/RO6tQ0c
 cTLALTS6lVOY5q4pDZtpL2LkGTNt9uNFp/WG1pXAlLZiZw9FbpDlzMfCLKsgG3lMNui3TlPj/ed
 KoWiXq4Ea8h8u84zhGQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-01_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 adultscore=0 suspectscore=0
 spamscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611010041
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

Remove Lemans EVK override dtsi: arch/arm/dts/lemans-evk-u-boot.dtsi

Memory node is not required as we can read the memory info from SMEM.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v10:
- Drop the SMEM series dependency, it is now merged

Changes in v7:
- No changes

Changes in v5:
- No changes

Changes in v4:
- Newly added in v4
---
 arch/arm/dts/lemans-evk-u-boot.dtsi | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/arch/arm/dts/lemans-evk-u-boot.dtsi b/arch/arm/dts/lemans-evk-u-boot.dtsi
deleted file mode 100644
index cdd3d32f61a..00000000000
--- a/arch/arm/dts/lemans-evk-u-boot.dtsi
+++ /dev/null
@@ -1,19 +0,0 @@
-// SPDX-License-Identifier: BSD-3-Clause
-/*
- * Copyright (c) 2026, Qualcomm Innovation Center, Inc. All rights reserved.
- */
-
-/ {
-	/* Will be removed when bootloader updates later */
-	memory@80000000 {
-		device_type = "memory";
-		reg = <0x0 0x80000000 0x0 0x3ee00000>,
-		      <0x0 0xc0000000 0x0 0x0fd00000>,
-		      <0xD 0x00000000 0x2 0x54100000>,
-		      <0xA 0x80000000 0x1 0x80000000>,
-		      <0x9 0x00000000 0x1 0x80000000>,
-		      <0x1 0x00000000 0x3 0x00000000>,
-		      <0x0 0xd0000000 0x0 0x01900000>,
-		      <0x0 0xd3500000 0x0 0x2cb00000>;
-	};
-};

-- 
2.34.1

