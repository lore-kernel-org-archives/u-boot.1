Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0593606A320
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 18:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Y3PvcbYa;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gWGx/knF;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Do58Ze9O
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C2028605D6;
	Mon, 26 Oct 2026 18:45:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aW2TVqw8O8J7; Mon, 26 Oct 2026 18:45:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org ED375605E1
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793040308;
	b=MKN1XXVS02FLC+Qzy0b8HX+KU8xcfC1U7Ve8zzTjZWsudd5bqhg2x43JiCto/aRgz/g1
	 gKqQDKf32uaSLivQb2Xbwlw/2mJMDzjuIWA0qmFujOhteSwOi8aedBTyAWnExZ+AAP3+J
	 DrIsM2cVVAE3gNBak828RiwKRFWRdvSxZwStmPovfZZiSGhXCB0U7youjmjmJT1/19YYc
	 gZqVLiBdB4dGRSo4SGLGDv8zt8HzpvAZi6mGD+I4AxqXo0kvpBKgUssJMYgLrWtwj57m6
	 HG3r3uT6KHwMNCfjoNMiFtqG01fYUv52wvwqvk1U0DLRVCqGIDTJCfUAstcaKF4VeZw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793040308;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=UFwCPt+ovbMPZHZukefvKOscBdH3ePxiw1lvSUaKcZA=;
	b=hizhPS4eTyJhBx+a7XWif9HFn5xhXfw5URLpBhU5IXy8auTNerj7ynnSPU33yCsEevIr
	 E3EROSzkc76bg8Rcpv5jtr9CMjGCRdZ+1Nu4eoCl15i7l9J1mLIUwJY+1LKQULrNMsx4i
	 YBfGJL5KyosxbE5tD5r9FHS2SsHCbbRVHCnTs/PLjwKyGUcrKjshDvTT6lF50d3XQXZCn
	 qzwQxYQhZ+tcGNILuJqHVmzbSjPMUmDJHUH3OtvAk7g6JaBiOd8Hjpfyd+pyfUjWQ1v0w
	 sNfhSlFZAgJMMtt/G4ZDHbHTrhKTO9+uImDh2mKHjCub91XljDno2Piu1zZhQu4KNgw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793040308;
	bh=UFwCPt+ovbMPZHZukefvKOscBdH3ePxiw1lvSUaKcZA=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Y3PvcbYae0/A+PzrWaLEDYhPcsK132DNB8VkTZ9c4GyZGj5fcdDAQdo2OIzcgIxgk
	 fhQ3+VbcpcVlcgYimZvzBZ5KgxhbszZOwi7NONDb8yePxs0zShkR9YSDDEE3/+jUqC
	 LWQ3Fsf9ajzlReB2yDzpVbwQEHfeDKO+zD2mkEZsawYVBQ0XYUEwxmeB7p+r11i/9l
	 RKPwHrbwbWe3lHvk2wMPkO9jYk967qNCBFmqMhGww3wEQVG29VZfGTSatsPXj3D0lJ
	 9Lhm5AmbxR8gKjGLS0j84Q73BxBl9LveJYznhuCc7qtztX7DOz0rzb5hOxyAvpSVIQ
	 qg//ZGKpdW6Ng==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id ED375605E1;
	Mon, 26 Oct 2026 18:45:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1DC3D380
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 18:45:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 038F140075
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 18:45:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AdTArcaX19hN for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 18:45:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 16BCE4006F
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793040305;
 b=no7wGKK3cxB//e2j9Fp42T/n6G+HEyJCok4VHSASxvhqvLxchWrYo+OyFcOvGXx9Oi2u
 7aB0jo2yWi/YJWcgrpGIc/YTNugsWne5n4L7P8ecEk0sgNDB8o97yTEUSGl9G4sNDhq/U
 bGLByXkzfIq5KLtXKOzagKVJeT25+javGUhL9qsBLelhtaJthIJOVouEMzU/Uri9z8ySH
 5xMvMEoWrVXffRC33EvwBlTdkrii3C8crb4NDlYKMMcl3g3wskJDl2krpuxm6nxV0Row/
 rSWTvrmcLQL+ch6nrrt9D8e2yToZquowT4M56+yVJBgtgQIjBtvELnL/T83xuRRI6CA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793040305;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
 X-Change-ID:To:Cc:X-Mailer:X-Proofpoint-ORIG-GUID:
 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=UFwCPt+ovbMPZHZukefvKOscBdH3ePxiw1lvSUaKcZA=;
 b=tYqE5TdDu1aheYGLh1LfylzpJ8bYhz6XsmpLeuauS7bTXg03Ncb8R2rI6BC2g+gk5EcJ
 YQkuseNoyVnuzoe6pt+FGKtpurjA0FX6i4wADAx9c14AXbMfGsRrymJcs3ro5R5Kk18Q9
 Zu/11H1iyuR2mpK1VP20S/mNdOWWtKHCsgLxpI41kPtjAu/hBSQnu6ldsxexbf1eZIOea
 aX6P69OYXseH8NiaOVENGwOZqmS+zB4LaZHrwS40Jk7M/ldJ3ZyeVTG6iMZhDNU0Gg2Ao
 P0IdsWwaEVT6lyjsNWN/XcLWezKvvsvH0W5xf9l6c8DgP/2SqCESGXzdCfb44OE9t5Q==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b="gWGx/knF"; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Do58Ze9O; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=gWGx/knF; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Do58Ze9O
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 16BCE4006F
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 18:45:04 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69QEvZdN2544038
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 18:45:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=UFwCPt+ovbMPZHZukefvKO
 scBdH3ePxiw1lvSUaKcZA=; b=gWGx/knFOtCyBBriPBOjxc5EcGe2/PcICfDMba
 QlA7SmAV5mEYz9AR0cTkA29g7cyxib12dlfbzMu+cIxY5JJwvzm2ssKPK/5ZF5zK
 1HmKits3efoQrJuIaV84bCwM93vQtdjouTNFf6uvx4rAlkEZYKdG1Tra7z+k0SiR
 qyQR60xzJ6tuuNOlxyCLdvmHOjFoGmOTy/It9XWwcpZpKtjXHLyiJ2A2L6ZppOJ3
 eb5u5UfTRIsAwZUBRYHCG0RdlvrJPIb9s3ha/y4mvKl6OjOD2SFA9LbG+J8XeHFd
 LfhESusW8Fs6WGzpPrr0XKjREPCCq+Q93dujrQfkHfDoW6sg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hj8sms17x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 18:45:03 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93f1f2fafeaso456812985a.2
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 11:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793040297; x=1793645097;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=UFwCPt+ovbMPZHZukefvKOscBdH3ePxiw1lvSUaKcZA=;
 b=Do58Ze9O5tt84Gukvnpb1Vsez141GQPQfN4q0SXOcuIOJk0g9CkwRWLsrM59u08nLq
 K777w9HZip6uD3QAxt3mtjVVEMtz8+tIcT4yY99FvtTJduwQqy6Z2F35xOTOmUhuKnyp
 JMwIU/t9EP348U4CuTKt04YLEHIlIuq9jA0ujusxS1770IdsEYFhu5Nb1ni3SRkWn5jL
 cTWBbOt5lWmv2WZPSg2yuNRfQOpm2HuIRzs+twqUDQNbcWF0QY4xv/gbmbN2Gufafnu8
 SayRE/F/EO05MOHB3limQoNFk/sGMptAZSkTJDxorxI03nXH7scyGradKD5+ZakMaTFJ
 h4TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793040297; x=1793645097;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=UFwCPt+ovbMPZHZukefvKOscBdH3ePxiw1lvSUaKcZA=;
 b=LEoS/bZPVGl6MPsyJSGZmeJlOiW0juI5ajAK7wHEglQF9uz+8CXGhMyp6WqcXLSt+M
 8jJbgsIjdHHzxxclPQEq5qQnf0IqQIs41I/UDlTG3WkPDBcPbKXZdDs/6hWr16vBrqhp
 EOS8uI69pBseE83qZFVmODX7ZDtQK7tdal5/KVeL45ChCGURj0IyUoWJpzfUJpdpBUqD
 ON4BUmp9NlrE94PxzDUO6WFMXFyjyKNH9cN91L0SBbwYIWzBCBgtAv/2ZBodXpQNT/FC
 FutViPraQ3B2E6OaS/DSWeVvlRf8ME2xvtKlsDS2CHsZeVKRoi/FGqZMFQfJMD7Y19O8
 dAXA==
X-Gm-Message-State: AFq9FYIp0RACBtNMbXbPb1QvoIFeXSXWIYGU7P7GDOa+XxbMdGI+6wAh
 TS7ru6rCnc7vyLIrE8WA/85o0S7n4BaN57PTc3w6gQXMjVrdWWjHZWl9INdGopFTMJ0pea5etT5
 BmtsOx56SNdWVRFW3Rz/oD0knkCGcNPVWco5n0t9jWuVRvRnDbjrLjCchAuTS5xeCGBeYCYU=
X-Gm-Gg: AYBFou39qp7fHb/uZXxDgJKbdoZHQdeSpENdcYyO6i286ZkueFUtiF+Ow4zCOc1L3f2
 MJsHKAw/16+mUsbEzBioNpebFgUJqJ3Wj2Fqo5m0W5EFuTC6MuFX1lNJSFCBsXW3ktu57dJgs+4
 nJAYtHvXx7q3evhd8ONq//kN4ceSd+sAhy0q/AhbKuNnIUwZHcY5MaiJbr7mJtMaY83TVs8vZXl
 3yBbPXUmdfbxhmpBUTVOy1TYfQzB09JeXGDglFY7slck9fuvZoA8HVAVoZ23kQ3Q6mWQDImwrpf
 xoumCJWn0bHkN2Wapxwjih6HeFdjC9Svbg+lKqBVSNj0fmZYXKi/VANJZIQSeavLEezNYP5+0ps
 8i1oMTyIE+f2mYG/vpJ8eFvpSQXi8rOz9k3iNBps=
X-Received: by 2002:a05:620a:4116:b0:93e:e376:9b1d with SMTP id
 af79cd13be357-940ef7d306emr1099405785a.9.1793040297401; 
 Mon, 26 Oct 2026 11:44:57 -0700 (PDT)
X-Received: by 2002:a05:620a:4116:b0:93e:e376:9b1d with SMTP id
 af79cd13be357-940ef7d306emr1099400885a.9.1793040296766; 
 Mon, 26 Oct 2026 11:44:56 -0700 (PDT)
Received: from [127.0.1.1] (93-159-22-70.cgnat.inetia.pl. [93.159.22.70])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd520838sm350543066b.31.2026.10.26.11.44.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 11:44:55 -0700 (PDT)
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 19:44:50 +0100
Subject: [PATCH] board: qemu-arm: keep U-Boot below 4 GiB for 32-bit DMA
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261026-upstream-u-boot_qemu_arm_b4-v1-1-223dd8060db0@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQ5AMBBA0avIrE1Cg4iriDQtg1lUmapIxN01F
 n/xNv+BQMIUoMseELo4sN8SyjyDcTXbQshTMqhCNWUK4x5OIeMwovX+1Ae5qI04bSs09Tw21Fq
 lbAHpsAvNfP/3fnjfD4BknW9tAAAA
X-Change-ID: 20261026-upstream-u-boot_qemu_arm_b4-a5fc6e8b22b0
To: Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Tom Rini <trini@konsulko.com>, 
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>,
 Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.u-boot-project.org
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: sTsVNypQTnCvV9dBLxsHQYvrNVnXM9Jk
X-Authority-Analysis: v=2.4 cv=Sfti5fRu c=1 sm=1 tr=0 ts=6adf9faf cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=ySe+0nHqNG5yihRO1pIWsw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=Gb3j71dWSLDLRJht-i0A:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: sTsVNypQTnCvV9dBLxsHQYvrNVnXM9Jk
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA3NCBTYWx0ZWRfXwvGwjssZ8QeA
 onCwdngkoV8yijtT7UI29uy9AcDQEQd7TKo9C9VEWNWIssVy3ylk58sdnMq9eiwhGK9MGJO/+vp
 PrZmf1/WOc9FBYBuyGPd9QXIOj46zkA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA3NCBTYWx0ZWRfXzmowvziyXQVJ
 zTtt20sK5zzpPMzxe0J4XtOrgqDQc5xbLOVoYCAijY3Tk4HomoMnEBxMJMJ+caPm3Cb7ZDAQ1aZ
 zTc3Dvk76urh/DNpmOnHT8DJ+xZzXLV9yjqcP5GzAD1SE3QDoIKJoCl2EhcaJPTtG0AdpypXllV
 6wwQKYaZizPFZBFemPjhF6DamwFwgOFFRApWJX6KDMTBfNY8+lKYNI9WnQLVycfYpCpSjuLh7EP
 CLwbA43CwKeJnwp2qz74Jyqnb/ntRsezCOnZ72y6VwhO4AFhyf76ffI4sViyCJpIMYS+zoTkD5X
 KMBfyZGITHn39hWaUOFilp163evmrN0qSOxxuyWKj4QwD3G5Sjf7h3QPnIGbesEF3fa62zpFgDn
 M41FbSufRRnxlVdp8on7D9p9cDY4PSv4EB77WBIVUH/8UDc3f6uD3gJ9tvlzobyu2kMNMp1PnNZ
 mAlFtODh0CwbZ/Z4MHQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260074
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

U-Boot relocates itself and its heap to the top of RAM. On the QEMU
virt machine that is fine with -m 3072 and below, where RAM ends at or
under the 4 GiB boundary, but with more memory (e.g. -m 6144) U-Boot
ends up around 7 GiB. Every buffer it then hands to a DMA engine that
is limited to 32-bit addresses is unreachable by the device.

The generic SDHCI driver is such a consumer: it transfers via 32-bit
SDMA or 32-bit ADMA2 descriptors. With an emulated sdhci-pci eMMC on
the virt machine and 6 GiB of RAM, card initialization data transfers
fail silently, the MMC block device never probes, and bootstd finds no
bootflow on the eMMC: autoboot drops to the prompt with an empty 'pci'
listing as the only visible symptom (enumeration not yet run), while
'dm tree' after a manual 'pci enum' shows the controller bound but the
blk child never probed.

Clamp the usable RAM top to 4 GiB like other boards with 32-bit DMA
constraints do, so U-Boot and its buffers stay DMA-addressable however
much memory the VM is given. The OS still sees and uses all of it.

Fixes: f37770c7707b ("ARM: qemu-arm: Bump RAM size in AArch64 MMU table")
Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
---
A single fix for running U-Boot on the QEMU virt machine with more
than 3 GiB of RAM: relocation then places U-Boot (and its DMA
buffers) above the 32-bit boundary, which the generic SDHCI driver
cannot address with SDMA or 32-bit ADMA2 descriptors, so an emulated
sdhci-pci eMMC silently loses its block device and bootstd finds no
bootflow on it. Clamp the usable RAM top to 4 GiB, as other boards
with 32-bit DMA constraints do.

Found while bringing up an Android boot chain (TF-A + OP-TEE +
U-Boot AVB + eMMC/RPMB) on qemu_arm64 and raising the VM memory
from 3 GiB to 6 GiB.
---
 board/emulation/qemu-arm/qemu-arm.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/board/emulation/qemu-arm/qemu-arm.c b/board/emulation/qemu-arm/qemu-arm.c
index 38f0ec5f2fb..18daca4a16f 100644
--- a/board/emulation/qemu-arm/qemu-arm.c
+++ b/board/emulation/qemu-arm/qemu-arm.c
@@ -144,6 +144,20 @@ int dram_init_banksize(void)
 	return 0;
 }
 
+phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
+{
+	/*
+	 * Keep U-Boot below 4 GiB when QEMU is given more RAM: the
+	 * generic SDHCI driver transfers via 32-bit SDMA or 32-bit
+	 * ADMA2 descriptors, so buffers (and U-Boot itself, after
+	 * relocation to the top of RAM) must stay DMA-addressable.
+	 */
+	if (gd->ram_base + gd->ram_size > SZ_4G)
+		return SZ_4G;
+
+	return gd->ram_base + gd->ram_size;
+}
+
 int board_fdt_blob_setup(void **fdtp)
 {
 	/* QEMU loads a generated DTB for us at the start of RAM. */

---
base-commit: 8649a54d301a4d0ac526324c7a7ad2574939ff27
change-id: 20261026-upstream-u-boot_qemu_arm_b4-a5fc6e8b22b0

Best regards,
-- 
Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>

