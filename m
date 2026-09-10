Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56803C79FBF
	for <u-boot@archiver.kernel.org>; Thu, 10 Sep 2026 10:29:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CF4E260B1C;
	Thu, 10 Sep 2026 10:29:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id STJG2Oxxrn9Z; Thu, 10 Sep 2026 10:29:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 1021F60B14
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789036197;
	b=HeywFHrb+6qmFvabRf58jRbk8kmxQT1BX6I+QAQi9blHA61ifPID3fq/0xH2d5sBRXTN
	 YdwYVKvgRFf7ZMKA4OZ0mZifo+7O8EnTf/zJuGz/SYxWDDq71mdr/L9amRXSeYcTivknW
	 AgR20gloliCYEibL3Y2A+SNNwKTF2yyUXkPHImlnctELNTALof1G73m7lliR8BHrjBv3d
	 4X74Qj+bQFU7xySj+qa/nki4ReZXM/Vo1NaPlL+mJnrzBydPprEXpiFan9LI8x892qOew
	 UEdr8c/bi+X5bVglN9n40l1xmsLrdnilJWFN87icGKio8fOEsZfoZ5MwqCSOEg21Ohg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789036197;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=uHuPpXbWUarYKkHmWMWYXThH2ErRJoj3FkMrz5Xow64=;
	b=PjpuLPUfOD7HJVxlfucpI5TCmT+XZqH4VNjP3RuVr1WR1Ttt6p0dvlW/DazXkaPbaqaY
	 Zk2VYYitNd479sfHlm1BzYQUZYK0G9DPNKFsYSPfsM1hnZoU4NNyhhqyPPnueDsO7jtHr
	 GkxSk+QoQlMiZ3V/OQCYEpoO+O6ePCFuKz3INkYbKxcIRNAzz01BcqiKY/okA1j/c3w9K
	 FAv32XLd3oBNtgwRhacjD+bkpJHSXQ/s2RUm40BE4tNrBree9+pTzFd0FfTU2VV8W45oV
	 svHQkS7SJgUjhbBK9RT14pDWBUQLimiRrxKbGr38DD7wU0X4FIPoF+PkuBs3iCcLjHA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789036197;
	bh=uHuPpXbWUarYKkHmWMWYXThH2ErRJoj3FkMrz5Xow64=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NYVbdUUC7t6BtRQ/pKMY382n+k1+ekliZeXZianDFSYCTyNlvkKuvlq51liQqXVb0
	 d1N7chxUpX+luLsaPvWJs0c55w+k8bCX41tWJSu5I8tKQVL3tNwovFILtp4gpak9Ql
	 lvN0vrkXkhG9aGoRerT/HvEGDZ+LIKS/ayQwvnDZiS8u52S+tY8DxpIJ1YhhEOxzfY
	 QVvbkibC95+NAqvcP7R/s5l/F9d/aDtt8u2MxgRVgLBAcnMQsFo4s1gqdnlSkHhSoU
	 HinnfFniKfmqCCT8/ObHVjLSmgM6qhKGbWhdwQh8cR301kVOEEvvkKDMFTGMl6/G/f
	 Z1z9xF42+5tUg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1021F60B14;
	Thu, 10 Sep 2026 10:29:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 368BE2E3
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 10:29:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1CB0D407E9
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 10:29:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iBvHXB-Vrqm1 for <u-boot@lists.u-boot-project.org>;
 Thu, 10 Sep 2026 10:29:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 4EAF940766
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789036195;
 b=oSFagjOcXMX81k2L0GvdD6jE6IOvvDpPlKfMMBVv7FlRjpyQ3FO3r9RkbeRcqnZ15ltG
 HpBHOEa2OnsWWAgMOtQ4SX01SEh+0qB5cendPjj2OTn0/WmWls9zhpd5TqKPBjeD2535e
 Iu68kxhOKQ2cAsVj8415h6E0pqGRfj++1Lf8iBDZeEFV3QnAJjNHqcqe1pfym6AW9yWlJ
 LraiDbgjxtJ+yYID2EMWo8TgCjnyX/Nj5Si2xHn9AqGVXYDAdFwCPEpblqFCf1cU92Pf+
 mZcXWvE7vH5XffPGzPZXeYatW65EFmpzgVwoz24xqr+nXf22UG5oH7q6bQ+kyaUXdYw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789036195;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=uHuPpXbWUarYKkHmWMWYXThH2ErRJoj3FkMrz5Xow64=;
 b=hhR3+M4c1nYT5vLbYHt6OTY9m1oy/Oo+eR3bwrnyi5RtV1qw9huZH3d+kPhjpQDdluWP
 FSc+inFUpT+stwti2JFsbN8utsxt2d6rD7815WmnIfj1fnxAL9RI80NNQ/cCiwmPYcL8Q
 I5miIC98K7CWVmvxUF+HII7nGusYcNz3aivpc9RMowYIfH2tst0+T1b8wmzB9eKq1a+6T
 jluWam/vF07pO6o9H+hJvj3U7sjdyk9n7sDOgGrdAPJYTS0ggmoSL43d9MHnB5aMRNPvD
 WXLYzO6l2plZqHDfkJWw6hku9GGV6Weix1HWShCaCRvWxX3L5ThUNhOwhsUP+NLluYw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=O36HHOfz; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b="EmyGH/N7"; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=varadarajan.narayanan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=O36HHOfz; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=EmyGH/N7
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4EAF940766
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 10:29:54 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68A8poPC340809
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 10:29:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 uHuPpXbWUarYKkHmWMWYXThH2ErRJoj3FkMrz5Xow64=; b=O36HHOfz6fDDfTqK
 /pf7m1QKNErAqUkCfU4H8JX+QfC7B7ZUNkHdepnTCh5aY5DjBK8ejNxiNCarJbCD
 KliDSstInZ5p/pBlN+PyfguawYkITP0Dp0vVHoTxm6J8LKP1SERfb5K+F2ZBCHNU
 GMyW+oyoUB8JMJjpNLrdmyYAzHSjRuwVA+IlNZqyprVvoMzfScb+fFBNmHt3kYXo
 fxRXzesa3UGHztpPcpvs/N6K4NASo8iZTkutgKTEaVKvPAreqYhRFF9ZMXie/Suk
 rmFqgf2nS1jsSQLFJlgB/mk6Va+F3SNKP6wV0a7mQ+vRIE5M07X3NNUOv4rK+Kqu
 Ao3qGQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gkrak8nn6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 10:29:53 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2db050d469fso12722195ad.0
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 03:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789036192; x=1789640992;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uHuPpXbWUarYKkHmWMWYXThH2ErRJoj3FkMrz5Xow64=;
 b=EmyGH/N70W+jtdn+oV8EgKJki9MhfZQYYoKBBS1UNkA5RxAWzi+NmMFsFCEdESyLkJ
 AQLuBhSWrmIwb1mPaSjrIll/If3+soGPQCJJmQgm9kpK0h7dkvzB1kAd3mLwBklbJ9KS
 CHFHl9ix4rha6uspwlt7EsV91McEq4p/IJ0+wTGSD5GUY0/up40jCkygQJTgjYdrJBcn
 2UCpU/rznAy6IhFAKCjR68rBdyVitNK9g8ubopTwLm7xWfIjOaHPhDslWw4h9+qQl8j9
 7/7SXSNSmNlJ2dSSqn3leZEQ0w9b9AnP2qcZtdmsXe2XsFUQ0NGu1h3HLQ84zrBimRHR
 UnNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789036192; x=1789640992;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uHuPpXbWUarYKkHmWMWYXThH2ErRJoj3FkMrz5Xow64=;
 b=b5Jbk0Az8wN7CzGIATZZR6iuVnmqqg5jkfq014PUfJ1BYnNVSsVbGTK6h8G1qA6/55
 /wSXknRyIA7tlve3bKda6PlNIdT0nR1YxEThEKb9QcQYVV3Z/msl82ejPBy7hsCAPOcV
 yxaUa8l4GgklQ42PUcYvG4hcMRsUMcgtPq7xsjMkVokRnTWRFm31QypljdB8Iw66S342
 JfSs/yqoReDELeZx4EJ1c+Flk5eVXQeEiShefpVyV5v3Vad2r8nfRB7Rsn/c+IadxL+F
 d/RJWtqvTpIQ7/BV4+UNwms3TU8uLcNmtMwfA9KiSko6zzFFlBdlvJBc/WOCGlMFqHiJ
 b/RA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzXIHxeXZ4V6ESu5+kizDoaNUoxCBWKCW5tO0AVbvjnBYCD8LwrCX5XAzL1SIfQMjekDq3pbd8=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kyvNqICAN+k9hxDHfcY51WOQTqeelh6RD/dDRO1WVcfQgIcxRU
 M/H3cUYKdK1hg77f0gpdzawF5LfEk2UoLy0kWmBAq/FXsI7uaGXT9/o3ANvwW1FxfQN7NCQ5TD0
 PWgcw1V5Lx6575Yrv2gN0iHZUTp+N6ar40TWQG1iYaVdAx0L/23M/OgEcSkPw2QpWU1sw9g0=
X-Gm-Gg: AYBFou0+PQI3l+4EBAvzvtdsN8XSNOXpV+rC4mAJpcLDCpyqfJ49MkcC0DM7NbGlABW
 ua1txT78Vxuc/qhzbzYylsMI4LbvEXyploMBW/5nWHWghjsi0J2Sby/h08Ag6L8CqJXJiJhNsdk
 zSYcjBZNup1fGNd1vqklbUmSy/VLvHklnEy1dyJE3ZVf+thrUMfE5pOakEevdDCpFpGsRwuDKFo
 u5EZDhskok90ZaeoVnEp+lf1obKoa+oskDmik5jgiFvKWhmSLY+XNhnqxq/BGWJgGppAExWkF7p
 DB86QJHlAxS+S9JQh/sFAPOi0ZVZm7zkYc8VxYxOI51luo9BZZMvROi4Vlkf9Ktu3DoCCmJrXD6
 6WVMjpi/Bbtde8WVse28ESWXiBpOBwqceTg9PQVsC52arLOnbOSLBpiA/MiXhlCmEUNhoVp84Jr
 4GxAd29wm5UFSqNEy20JsaUl5sr+6UKA==
X-Received: by 2002:a17:903:1a88:b0:2d7:1858:1d96 with SMTP id
 d9443c01a7336-2dd0e9e565emr43268845ad.7.1789036192585; 
 Thu, 10 Sep 2026 03:29:52 -0700 (PDT)
X-Received: by 2002:a17:903:1a88:b0:2d7:1858:1d96 with SMTP id
 d9443c01a7336-2dd0e9e565emr43268465ad.7.1789036192084; 
 Thu, 10 Sep 2026 03:29:52 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3339a62be87sm42824576eec.6.2026.09.10.03.29.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 03:29:51 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Date: Thu, 10 Sep 2026 15:59:39 +0530
Subject: [PATCH v2 1/4] tools: qcom: mkmbn: Fix ipq5424 MBN version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-ipq5210-v2-1-d209f7dc0fc5@oss.qualcomm.com>
References: <20260910-ipq5210-v2-0-d209f7dc0fc5@oss.qualcomm.com>
In-Reply-To: <20260910-ipq5210-v2-0-d209f7dc0fc5@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDEyMSBTYWx0ZWRfX9bY3bhnUjPPw
 j+pvR0Hd35Qi/vRA90K1VXPP8tCdwl2m6T3ztDif/5bkZ6GY/63lihGF69a4E7X6Hs/vy/sn3Gj
 o4IH0N2XVpPxu8M71UC2EnbflzfaWqU=
X-Proofpoint-GUID: Ll8RquzqePHAmTgHNZdMy6dH1JiVgFZC
X-Proofpoint-ORIG-GUID: Ll8RquzqePHAmTgHNZdMy6dH1JiVgFZC
X-Authority-Analysis: v=2.4 cv=EspHPicA c=1 sm=1 tr=0 ts=6aa286a1 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=5oOYJkjiZhHqBJ3UFLIA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDEyMSBTYWx0ZWRfX7IpRudz4s2ec
 4UkywTmTXJdcxGit9B6eHqWGwv4dmiiaesiVl0DbbnxKNKun/PxfhIfoyH9QLO8viKGbkL53hue
 Kr58V40HqNQx4gk20799Wgw8gK2kHdbA/oAEORuhU5tyPWZ7DfonlKHcr92eWIIJ19Fwry30U99
 tUBs6CIFovbWp4xEGtdJHlXJd6atLwKxs5z5YCMMqLaXEfViDolHScmcTM/ppf4FRI+zkRuKAiJ
 DNCoGj4news6a7ADlOZxPHuad28N8YDaZCxka/z/WUMRzUFAmBFy5GtAkx3JL0YZoysQaVV4InA
 XoCLGBy4ro4J5VM4WOuJyZ5acuKs2sZNp5ZCRPKau+fLzrsA9B+j2ig73sdeMYZaQAvzSVxqmcX
 xHxFzmG/h6frqgGTnCTNEB8Frroe4JpWCmuBQf77qd8ulxSaQKvd9MBT58xcZ2Brwsw4V5AwS3K
 6a1nT9IvvyfZWb3Xh8Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_03,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 malwarescore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609100121
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

Since ipq5424 uses MBN version 7, update the ipq5424 entry in the 'boards'
table accordingly.

Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
 tools/qcom/mkmbn/mkmbn.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/qcom/mkmbn/mkmbn.py b/tools/qcom/mkmbn/mkmbn.py
index e4484b539b0..8d2078acc30 100755
--- a/tools/qcom/mkmbn/mkmbn.py
+++ b/tools/qcom/mkmbn/mkmbn.py
@@ -85,7 +85,7 @@ boards: dict[bytes, MbnData] = {
     b"qcom,sm8550\0": MbnData(0xA7000000, 7, SwId.uefi),  # C8550
     b"qcom,sm8650\0": MbnData(0xA7000000, 7, SwId.uefi),  # SM8650
     b"qcom,qcs615\0": MbnData(0x9FC00000, 6, SwId.uefi),  # Dragonwing IQ6
-    b"qcom,ipq5424\0": MbnData(0x8a380000, 6, SwId.aboot),
+    b"qcom,ipq5424\0": MbnData(0x8a380000, 7, SwId.aboot),
     b"qcom,ipq9574\0": MbnData(0x4A240000, 6, SwId.aboot),
 
     # msm8916/apq8016 has an "aboot" partition but the process is the same

-- 
2.34.1

