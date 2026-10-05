Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA81FCA5FFD
	for <u-boot@archiver.kernel.org>; Mon,  5 Oct 2026 07:01:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8C3A440659;
	Mon,  5 Oct 2026 07:01:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eVvpn4PMGRIi; Mon,  5 Oct 2026 07:01:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 8491140645
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791183666;
	b=qoM2tNxPYabKXKWAyDjgGwQRMUWBx+OzF/t5iGGNSjw8P08IgeP5DAgaqVAu2cEcgSXO
	 BK/oWtxivreSfy3cZkpVXhP3c48DUkFsmIL/enV12uVnb0BOQ2+N2I7jliuc30sUNzZwW
	 zVULblhNotCH7sXewDj/xjMZAhz13X0IHYNKkuudT5iqNvymQ63xD0/axLE+UQ3TqxYSO
	 koExRUgvTsSMYB/X8LWEdy5olrd6/R7qTaH9mtWz9Yp8zQquomF/MNCU5We/AVQsgWUaw
	 Oh4qQUSjMZCLyfnG41Ae+JNeqT4GiCiXJOaRPI8xGS+mNB6P5MTRVJcor9PSOEDnTDg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791183666;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:To:Cc:X-Mailer:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=hNqixf2OBM/WK4ayNFlj47umGz0vK2TYZks2HNrjOV4=;
	b=m9MIY1mty72FsWAJnp2zLI/oZ6Qvu1EmTdWhWIndDiPlJfIuA4dbnAiACXUVnMFqDFJQ
	 2VwUcWYe/zFLYZ5Xfzme9FGlzp0r3wWn7EdsnxOmIst20r8/rCDvmZ4P7ErgOg4q7dwFt
	 nueTqRjOhlQ+anKGsTXAO0xPgkyFYxANDCHm9J3qOqHqb63VHBvr7Cbi051DAsIN29yXC
	 VnFjbIK//h2nJ0dVgbNRNc8CgIC5h2wd9jO2BSzGa5XV/PTSwCoHzh8jJOkn9J4BU0vDu
	 BuYARhLZPIbbm2z+c13wZPSjpff0ClKEYRhD4/fT3nBebeFcCO4R4TnSIsiNXZx5UAQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791183666;
	bh=hNqixf2OBM/WK4ayNFlj47umGz0vK2TYZks2HNrjOV4=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=eJlBV5lolZxAPcdWVVA0cWmkYuilgCBVztk8g7BG1CrAYMOLR8oA43R+GeFywG/D4
	 VOnpkIqDbr679Y0+qm+eFR8h3GObWgogQk9fKzI4qOHeG1yTesoOQYsaVt6XmCuO2N
	 vS5lhHgPaR3v0MXP9RyMYcYTkWwAf2AQpdSNlwsL32JXslBLNGlD3oI/BG0J4VaRd9
	 iNuqGt4vOS69N/QgFMLZyTioVUwv/0EqSQY2HzLTBzWtIfwTJVUEKJwAiswhqyZ9s2
	 Aiary42C0XEppSN/vZoyM+C57bv5jeyyjylkhWydU+2PmcQKjlQldiIcmWHbZ3dQNo
	 cOm4ZDXTErTyg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8491140645;
	Mon,  5 Oct 2026 07:01:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 89A1D1A6
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 07:00:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 79929809C2
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 07:00:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OebSD7FhHv5O for <u-boot@lists.u-boot-project.org>;
 Mon,  5 Oct 2026 07:00:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 2B796809C1
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791183608;
 b=egJcK2SR8NwW9ycJlACq32axs8NdS1L1Y8IK2CBeSVj/dfEMYY+xPi6ZGHnyr9j+6LJl
 ZB3pixVq4n8eKZFi/5un60fnEWnYAgQbeoZvu97XRwfiBn/Ztj+JuZbQlklB9j3xn39uf
 Yo7WvXQ6eBpMJbciKB+RoU4mcCbdkdtp362lL6Yn3NsyIfgAt9tm6URkcN5C3e01CWeS4
 5rVyYg14Na/gdbVDPOwa/rL1SBSpWooWpXVoZ0LXSHnMqexTC1d25VUPnKB6OR+FurcdK
 wnx5tSNvoYNBx0khgYOjXwgbZF6ULaKfjk4btbqoCPnxBPs7Su1n0YKV1h7jOheH+9Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791183608;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
 Subject:Date:Message-Id:MIME-Version:Content-Type:
 Content-Transfer-Encoding:To:Cc:X-Mailer:X-Proofpoint-Spam-Info:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=hNqixf2OBM/WK4ayNFlj47umGz0vK2TYZks2HNrjOV4=;
 b=OnU3ZelO6mJSdABliWfdfxMCbhMLWJYtEYilq8Pbm35HL9zKdOiPBh6F5cfdGJWof7Rc
 7b65luYuJuMuGLL+9izvCk7r4rY8faZbUN6kIoh583xuC8WVYmXyLuk/+PJvadLOSqs8K
 J7x/BVy3GMWS52yxjSo9DuHODLRq/KFz6Xzr0lnKPKoqb9DrPJgQ4mTbV/26ZLWa+Nbuq
 NDDKPlVCTpc3/6Om/AbqUN3VgkHIaBPFE/BDl9Up5jGZL3P7Qhn3qF/2u7nC6OMlmlFXz
 QciucNLDTK1pPF7T+6blCLuDF840eSXGctOWGDmOinve7Cv+LuNfh/uovCM0looa7tg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=gkLElFYN; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=WKylVl+5; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=varadarajan.narayanan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=gkLElFYN; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=WKylVl+5
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2B796809C1
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 07:00:07 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6951076C1464921
 for <u-boot@lists.u-boot-project.org>; Mon, 5 Oct 2026 07:00:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=hNqixf2OBM/WK4ayNFlj47
 umGz0vK2TYZks2HNrjOV4=; b=gkLElFYN3IDzbBf4wmg1hIH/oLhek2AiyhOHDP
 HEf0l9iEhUguvagb7WuZ1ZZJG+mrKOvNLx4HvVng6gDi3pWxbt7bHUV3rU/8VR6B
 H3dshbmrv0UkFNOajKoqMOj+NKpX7DZKOJbIgEDTMqYedJjzciFlBVK4uhHa1aRy
 rEVC7HUx8pPf6f+fwrt8I9b0Gg12HMS1a2R6BDbEVa/oYzKHw/CorPqQyx8GoTM4
 EEHyxMkh++NqA5bWTueut0Dmaqk+Nr03TMdWdopGahfUIsjui9NEJUWkWgVdptvb
 YsZqwRrl3QEbWTCGmBffjNOAN1eAbz6IKQOrmNP5dP/qPoWg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h2sssms1n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 05 Oct 2026 07:00:06 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-3510d0baf63so2884818eec.1
 for <u-boot@lists.u-boot-project.org>; Mon, 05 Oct 2026 00:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791183606; x=1791788406;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=hNqixf2OBM/WK4ayNFlj47umGz0vK2TYZks2HNrjOV4=;
 b=WKylVl+5Od4rknFUoULFMQyFmgWq0Dxc5feX3zz11qzq6FkwZhqkWzqrraDsBQyamh
 ZMjSEB1f4ffTFZAwT3c3LezRprbDmtqrlPTyvvNQinyFboDh6jA2+3aAwXgwz40KcVC8
 kLcDsBZ51WXtu5UeAeM2e55SKNqT1Cu0Np5kzi03bEWba/zcAGZtJ2w3dafcN2wknBGa
 IPbldufkw0pBv5606rOToKdPntE3fZxCvvszAsO47X7DnEkqK1QdZOjvNLGH77R9AFPj
 OtllJvMIVE1RfyEXVOavEtpCgvszcx+cJxCdkFP8dup8S37c4kj/MIZ6336LQKLbNXpm
 d7eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791183606; x=1791788406;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=hNqixf2OBM/WK4ayNFlj47umGz0vK2TYZks2HNrjOV4=;
 b=k9L1pCBXOTw+pUAZ5kzZzpevnnPRN7eX3eQhM2JJfkswYOHlvgakMggPQDDv1gUvRx
 lIjfMQsnVyuiMARO0aNTPeg4UamiNd2BzI4QDqjlV5fza8X6kzKEr7KLs18XcU5dtQlV
 D9BEhPpjyHYYaF/RvvsilC2w8bZ9tScqS8uJpCQaIJCq0jF/dtI6MFpcy97qiNSIRNQR
 6YmPBD68bFWi3H+TQr+oWFi0Y5DrTZrI9pW62uJvlBH/6eYqETXdYvG1gaj+3kSPkPFm
 h4k18gfN7aNP1/utlS73GMqi/8LuJPFnqB7s3bJRNfG6w981YA2LlXskEG4XBEs3wQS6
 RhyQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBz0QkyT/P1Fiq8I23Notp//5T94hfy3jt6AmV5H8G0eaF178FBpW4lYdVvOR4rAZf67vjh5qRw=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kTiQsAi9IDZpeYMnCVVA5rn/fsNjuR8gHjHDYMXKXi1eRx0VfN
 G0GK7WjanWecSwj1UHFgFVH+x94Gg83cGuiLpIYGByTRpSSMGR/vyx3MAZ6mFyPX0WO5jcntjnw
 8/hn6SAaz+x3lXG2AujCIRsY1X8sWA8NA62V5a2yEECwsOaLMLPkfnJwPeL4LXrKQ3/L01MEBJm
 S1ZD8=
X-Gm-Gg: AYBFou3KhKoIP4pshJSa184D4CMFX15YcakeZIJAXA0xFBZ/sXLPAMNciFi8zvJJcqh
 2EuFqLTpOLLxVOkscFqvtocxGUKZglmk65qMWhRoqf5M7sCxzluBM8KUB4d8DOb8ULZ1MV4vvvM
 mYOTqiMGzSFNiQoOBleNP9ALx6dZihRBe7/EcPcfk9MaHtDUA7MQQ0lKvKQPg9G/J6lHV5mpCW2
 VT6Fx1upGjc+pQGmBF/ifbDK/gdgxUlBJtLpzGx17e6nuPoMGG9FeEfR3UetsaNApDHOUGHwEQa
 CdJv0wMCB2KkT/h2bPTGJH4QdWFrBwGZwQpBFf9NRB/2P7XO0BQzIlpMEUCCVmNKJknctYdt3cT
 5AO+oIS0n6CW9vjTKcuEfedJObQGGGKc9hCDvw10HkPeK6ISD+S0Lz3YyxyYXPr/cJJWsCuQXjL
 2WLZx5o0ANPAHy0nUNXElRjiDl4MMR
X-Received: by 2002:a05:701b:4518:20b0:149:49c:233 with SMTP id
 a92af1059eb24-151c38af23amr8978136c88.27.1791183605924; 
 Mon, 05 Oct 2026 00:00:05 -0700 (PDT)
X-Received: by 2002:a05:701b:4518:20b0:149:49c:233 with SMTP id
 a92af1059eb24-151c38af23amr8978092c88.27.1791183605286; 
 Mon, 05 Oct 2026 00:00:05 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-151fca985c6sm27963498c88.10.2026.10.05.00.00.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 00:00:04 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Subject: [PATCH RESEND v3 0/4] tools: qcom: mkmbn: Updates to support ipq5210
Date: Mon, 05 Oct 2026 12:29:53 +0530
Message-Id: <20261005-ipq5210-v3-0-e0ec14fb5796@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDAyNyBTYWx0ZWRfX8UMHZC0ucj5G
 OTGXDu+h4J6+J2jc44kJUZVTj3LOkuTvGSJsbo82l4dZehcH/XIwm8goRMetHzbUcdpaKZd4W+j
 I7fU+59yVWLCbXwV4w46r9ZtsWGCyww=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDAyNyBTYWx0ZWRfX7TmF5vJnVHq/
 EI7SkVrCuYemlas9YdCSKSQm257lWFHr41E72UT2ChW0NCIFZBjyNUCShDYu+6tL0ksiLoRzpPx
 UrY/XwSeXuADKlIRedx7MpI9d9UytMacFj6NIe4+qnYT1CcwCEkri4nsYhypVUEmUxjQGAgbcD/
 Sh18VnDXsfaoSBuN0YMnr7KWo1KTBz/DJGFs4D7qYE7ShXsizRpwKU4ZUdyWEnjSgWqGrwwTWY3
 mg9G86T4ScAJ2hCkaBeY+ccz4MBktv480qTnUSOcor+JXrhtG1FVc6aWYiXevMQUr/SRiDsW/U1
 jmT3HFboHys8ypBkv401QCTPPFikquIID+Us1sBfon1NrtPCHbP0nOGaWcssZFKMbl5jM6DsTLC
 i3/TZrVVj4aKgK++QXlvwUtMRyrNEoFks+4s/gl5+uAla6MkRbM2u/Y1xE7+cV70nz6wsHdoSAk
 mMGu2a8+lftJBnJ/H1w==
X-Proofpoint-GUID: TGuDIGQsJw5ZFu74D6E5kQ-Ay6mSSseo
X-Authority-Analysis: v=2.4 cv=HqjjiETS c=1 sm=1 tr=0 ts=6ac34af6 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=p580P5g6mWtK41y3Ph8A:9
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: TGuDIGQsJw5ZFu74D6E5kQ-Ay6mSSseo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_01,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 bulkscore=0 adultscore=0
 impostorscore=0 suspectscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050027
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

As part of adding Qualcomm ipq5210 SoC U-Boot SPL & U-Boot proper support,
the mkmbn script has to be upgraded to create images that can be used
in the ipq5210 SoC.

These changes are to address the feedback in the 'Qualcomm IPQ5210 SoC
bringup' series [1] to use mkbn.

1 - https://lore.kernel.org/u-boot/78ff6a8d-5c63-4bc2-bf1e-6b71b8f9c6cf@linaro.org/

While at it, fix the MBN version number for ipq5424.

Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>

---
Changes in v3:
- Fix review comments
	- Add CONFIG_QCOM_GENERATE_MBN to qcom_sm8550_defconfig
	- Remove load address from MbnData and for all entries in boards table
	- Remove '--melf' option and modify the 'bin' argument to take
	  multiple files for combining into multi-elf.
- '--melf' was actually not removed in v2, but included in revision
  history. Apologies for the mistake.
- Link to v2: https://lore.kernel.org/r/20260910-ipq5210-v2-0-d209f7dc0fc5@oss.qualcomm.com

v2:
- Remove 'load address' from MbnData and get it from .config
- Add qcom_sm8550_defconfig
- Use 4K alignment for padding the MBN images
- Remove '--melfs' option and make them positional
Link for v1: https://lore.kernel.org/u-boot/20260714-ipq5210-v1-0-0b98251aabbd@oss.qualcomm.com/

---
Varadarajan Narayanan (4):
      tools: qcom: mkmbn: Fix ipq5424 MBN version
      configs: add qcom_sm8550_defconfig and debug fragment
      tools: qcom: mkmbn: Add support for ipq5210
      tools: qcom: mkmbn: Add support to create multi-elf

 board/qualcomm/config.mk      |  2 +-
 configs/qcom_sm8550_defconfig | 16 ++++++++
 tools/qcom/mkmbn/mkmbn.py     | 85 +++++++++++++++++++++++++++++--------------
 3 files changed, 74 insertions(+), 29 deletions(-)
---
base-commit: 914dd2f5d18a3a89e4ddb6d1d97b2743618ae5ee
change-id: 20260714-ipq5210-52e1da5af9fc

Best regards,
-- 
Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>

