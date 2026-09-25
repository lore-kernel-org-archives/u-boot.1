Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A071DC98324
	for <u-boot@archiver.kernel.org>; Fri, 25 Sep 2026 14:26:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 59C6C81352;
	Fri, 25 Sep 2026 14:26:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LuVbKQxMBBZn; Fri, 25 Sep 2026 14:26:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 678C381340
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790346412;
	b=YEV0cjL4ByuMCWngxmhDeFqpPVRyS3SNIkxgRYoY/6EWujPSCrX6cdPvyX2TdzZA81ao
	 cudB1SkSv8/QQkP4T16zfinCTz1zxd5wuXnUUPlvLCMBZl7BRssm4WlVY/MBAY+GtO/WY
	 YbbouAXgGcGCDUxi2MESs1+P9bC+XJc/rXtHLL1cxmz3TF/1GtNv7PQvFkZqh9bO6EuuX
	 miIxl+0QOitV/H7bl23X1ya3+WiCNcukFEmCCEj6RlnnHUq4lhFUK9wCOlXCcarEG03Bu
	 Xx7xYR9cDlsd3MPCbvkBK+/xmJxYRSUF4llvaAyLXP1j+2F6A+1cQHWdZqWnopnJbyg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790346412;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=OuU2b/La8IOgmt6Ei4mSlZEx1uxrWJdgxJX6X8P1U98=;
	b=VgQRg7BHk7UrSVwwsD5c5xnH8KwwWhhPZ9CifpVxTpRGXS1FVtRHOmOXqJ4KRqhdDqNC
	 nRtYz6//B7KGTwysKm34bS0YqTjO+K2n+kn6KxnpWCB9i4ehLG41SqDA0lLTvEZVAV9CI
	 QzdmOwK7NdKumm2hNYTDZ6cYq+mhgpPET9jPeqCD5dVeKzdt1eRjYUDCpGriqZqrujkW+
	 /ZRlK/5+b1kTRK8JIzUfXyh3HAmJ4HRQ8oqJnkfmwgQ045DVA8eOClBnC8oOPGPDt7+59
	 rF/zyWmsBMqadrmC71Zr16kOtfy8nTFLWkwlglp6aONvZjuQmluoPig5R+hWUwx/tkQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790346412;
	bh=OuU2b/La8IOgmt6Ei4mSlZEx1uxrWJdgxJX6X8P1U98=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=X7ixW42TRwIKeGjQpj4dVHK2hnQ/lHJwgVwkFwXImY4sTWQajNbm+jT1YhROtxVNL
	 jPCVTRP+EoqAmK2jOqUJyxnyUoBth3OQ30bMsSlc4VfgFMJIwXzEnWE0IxO5WVdis8
	 9wx7f/Ti/p02g/LEb46jbU8ipq5UQqTwBgOmmWAZEWOsp3TKnOfRglG83vY17VpJpU
	 0ntmDzq0Sw7j2OOdjwVzgGxdKFXIeHok/jw1Wuhwx2JQXSmkkOVDWJIXxU8DsQZeMy
	 DKMYwqAkHx3ar7jk8zPvZRH5qHqjLr+DJSfa+nhve0JbubKYD+ocaCtpWjnitJ/gA9
	 8dbsgKEiAThSQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 678C381340;
	Fri, 25 Sep 2026 14:26:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id BF7E0A33
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:38:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B11CB60D5E
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:38:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3401mSL6tkIt for <u-boot@lists.u-boot-project.org>;
 Fri, 25 Sep 2026 13:38:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org C6C07606E5
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790343503;
 b=cskThxOSnpTVtiE4zacrPw/17pV5Tta3K91gCEgF+vs5UNX2vd1xAFS8s9wJOOy4ClgV
 Cp7sj6FlfUDLFhxB6pkI6uMFN+3E0OOBpcDSQsZFOUXuu5TCiBMbQoIoserrgtFZ/1k2f
 z5puxXJuuAm6sUMk/l8YYeR+kJEB8eolDVXfr/LOBqiXza/uu3y8EDPMZ0IThae8Id6Kg
 TBtiUHPe/sVgxvOYH/CHlMUxYoCHeVld1/ymngwL0UBq//qjdsH0Lq8bYrS8+2AIba0Ed
 eGWiUjdPTDcHtWlqb+y/yc2uXv/Ziur1GsOaOEPGYoW0q6w9u6Np6TKw/Uz+wpPuH0w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790343503;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Authority-Analysis:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=OuU2b/La8IOgmt6Ei4mSlZEx1uxrWJdgxJX6X8P1U98=;
 b=m2d17irFbIUtExYPaRvgGnFy8PwiYbQU45hEhqdm+9+BjAMe+iARrwgORruuZ30p+8jR
 J0E1QYsm7Qo0Sd3UIfvg6ijfweJA9zqe/fT10isfz9sNLsGHf+gCyXE1JqQsHzb9GwsXt
 ahk3gAl7QZt//0QUgJOYZ6FyPIz0RmHNkNiAnxf2r1Qk3yW1H+LIBTp7CG+irp/7pbIcO
 /jndTbyKsclE+yP4KqWHgNRTmqcLamNSLA9TEyDApk1kMc7J1VHoHKmBaKkHmu0nwQSuG
 hUHzhPKBeO+OFf32vj5EZ03lXg0svvWG1VUM0NIXJkPjbEGUyh09reZswNiILYygnAw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=gC88JFni; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=B8JkSj5N; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=abhilash.v@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=gC88JFni; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=B8JkSj5N
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C6C07606E5
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:38:22 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68PDBXZO289534
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:38:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=OuU2b/La8IO
 gmt6Ei4mSlZEx1uxrWJdgxJX6X8P1U98=; b=gC88JFniU/+TzSp5vMs2Q6b+Eh0
 Q3CcQR4Ti+SQb1QYopSRkIdy8a4tqnHoEUw74DrWZTEL7AzFXSA35S95cJgVcDPY
 rcwe1VEZdrgDkvCuK6Nf1mUPt1Xgyy/MPeY46BcGaDKQvRHVrLlHSEEks/u6e2G0
 wtChxZ5BvkffKckSn9G5ucwPoRlp99A/F1t+gX3jQ/d7E5/t2CNMOsyblysR66li
 AT81UJviRWEArzO2yOQeJmotRJTqxQAOQH8d84Wfu3ky527ItUlUFF9GPJHtn58r
 Hz7DJ0YjDV31vvF+UsfrpUCREuArt4to2cPLJrf87OVIFUkl4dUjWFlPEcg==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gw881uqr4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:38:20 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-1438492fb40so1369389c88.1
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 06:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790343500; x=1790948300;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=OuU2b/La8IOgmt6Ei4mSlZEx1uxrWJdgxJX6X8P1U98=;
 b=B8JkSj5N4xeeXSvVXRzL0f242XhdnoLWs22su8HVbD5Rs9eIDuRHMZD0MtNYma9JVu
 +Xav1+y/McZXRhceibbblNlFs3nFXTIxD06aLF5SI8mixvy2uhdAbqHygh89HeNImmHu
 Y7H54CO3Fdk5+OI8nQDMpRzjEkxo8dOcOPwPYDSjVe74jaFIxnTgbiTS8cQkabTHBL64
 RuIOn6KgieK4w0uv6UNTjx8eYCOoEiS1zKaPitMHLVblrgO4Y7kW3ejcsNyht7YEoySW
 qwNFBsMlp959NUtIa4cFhfRXLHdGkO3bmm2mo2VxYM8v7QeC60k7ekidQKIwGZHJFeC9
 qvVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790343500; x=1790948300;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=OuU2b/La8IOgmt6Ei4mSlZEx1uxrWJdgxJX6X8P1U98=;
 b=kaxssTA0qrf02L6XN9X7q5n3kzs21NnvHAZxz0+HxaBrLWBhwzxxSDxCBgUfoK714t
 vnP5rTJepjrptUivT9XePI6Xm6+J1YHAiaH3Xd6RQTSfoV2zg9dBhs7h5hDLmyGomqyO
 dCfQH6VFY7dGOkLX51vEDT7vibbol6Bg0a5Ek3WzIReUHJEhcN5XdwO0KtX5G5XLbNHJ
 b5+ov8ljRsVvGj8skg25q7K1mPP7qDWi5rnelqI5a8Choo3M7Icl2H/UuDlugPam2yk/
 3nW3YQtkKp8TzfdX6bPWDmYpgMSY0qywgwIwEX8hMdRTTvNP4L2HporRSx1VAyi2DG6F
 U9DQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByw8DE57nvQkyFCtFMNdkNYcE2aDB9RxOLpthrpUqAVTzmmibaV1l4BGBoRbIAKPjoFU13DCsg=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nOuEZsp5n0cDNbpBRvvYw/lIkHXjbNzt9NrLFeoPyrmAP8HU3j
 f4XqynXS4/aVQINx3aQuLgCHchrXftj/m6OAaUmSN8+ubBaXS0LS3euxRwQSgKPY5hHkavcpIBn
 vUbTS3QeogpVh1uHxhccrFa9PPg+O+On9ckD7OTqXQXof9DoXvyEHP6BjZgDgz0C2nh7sTaQ=
X-Gm-Gg: AYBFou0wSCT4VHcLM44WW4XA04bZIFUsiXZYj/bMQ1eVaMtA7JWE7SJnq7WbwVILj8w
 3FDVfRhliVq0KjjCUPiqQIpgCVwa4TG4ddsKqu2vKxj7JPG3yfSztGgYmGFo6I2+9cPLZcrHRY+
 2uvu5Eflo2olCxKhtUuC9dCnhM7xPPEZWT2Vvk7PaeBN/O1f+1d6zrBij15DYy8/LJJFsNofVCx
 ZmmZCrcmwMK7eoq1h2SOjJO+Hbgizypcq5FgCSq4TctqE3vDQqabfnwam9xZkGQci/ZoDFd9CLw
 /fWwWvEigq7T2aO4DiQpad4wlYpgsS8Uoe8Tdn2SaOHZxRUN0N1rX/IjzfdaJaCUBXaVLYQnWHC
 AExJGqi8wHkHmQxSNhUQ6Ml5La9NFie4oQW0UA1+juTGGUqA=
X-Received: by 2002:a05:701b:4192:10b0:143:2701:919b with SMTP id
 a92af1059eb24-146d03a0a8fmr233693c88.39.1790343499718; 
 Fri, 25 Sep 2026 06:38:19 -0700 (PDT)
X-Received: by 2002:a05:701b:4192:10b0:143:2701:919b with SMTP id
 a92af1059eb24-146d03a0a8fmr233654c88.39.1790343499081; 
 Fri, 25 Sep 2026 06:38:19 -0700 (PDT)
Received: from hu-abhiv-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-145adbcd1bcsm7706290c88.14.2026.09.25.06.38.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 06:38:18 -0700 (PDT)
From: Abhilash V <abhilash.v@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org,
 aswin.murugan@oss.qualcomm.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, lukma@denx.de,
 peng.fan@nxp.com, jh80.chung@samsung.com,
 balaji.selvanathan@oss.qualcomm.com, abhilash.v@oss.qualcomm.com,
 Michael.Srba@seznam.cz, varadarajan.narayanan@oss.qualcomm.com,
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: [PATCH v2 10/12] arm: qcom: enable MMU and cache setup for Shikra SPL
Date: Fri, 25 Sep 2026 06:38:04 -0700
Message-Id: <20260925133806.1403713-11-abhilash.v@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260925133806.1403713-1-abhilash.v@oss.qualcomm.com>
References: <20260925133806.1403713-1-abhilash.v@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=TptzFzXh c=1 sm=1 tr=0 ts=6ab6794d cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=f8ITsPQRx6dYy5KBENUA:9 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA1NCBTYWx0ZWRfX3r5YST6K68JY
 RLEKMwYM/7ITmj00eUJfH06SGAX/rZBmK387PeYwtfQMVYy96Cm7pBFh86GMVOw4OXujfGM1w5o
 QdEZuFUpQY4I2JcpsvI9JBvREfw4i7gv3Kfs8fIQ2637gtBBbK7vGcLwDA7Y0DbVKb96mvIDp1C
 IWVv5Kw308AXxOc+uXNMYvlgP0fc2EGJNfFmONbE11mO+fkHASwV6n48Ai1AWWrlt9s3bTYKlch
 Y4dhd2rSC4KaQXyBxS/U+2cj/LYyh/TqMjsNY78rmQRhkygA7yMnZ9nPKxmHXtl0UHJSTR1Gn7t
 CVk/VFMUNMM3FDB+IqLw0WtFgw9TlwaHFbr0Wmy8eHk76Lw7On8KKCMHO3/w21vC920tvRnnxLv
 a3Ia7YMo0wvYK49juucJRu7wHnN/zCo9qp85RwNIEgOLMKTt0ZcfcpsF3Tgp/kSumUangnCAGMT
 fRP0BHOWYwq2xgFKm0w==
X-Proofpoint-ORIG-GUID: 3lYS8iqTNs7xHKRX0APCCMSk2p0NV7iY
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA1NCBTYWx0ZWRfX8z43lvWLOa/P
 kC62dOfJ1ktYzn9XZrr6JJDaSTOLD4bVtNYTyUJK2ctNK3QHvf4sfQqhlC0d9VY2YmJupQIPT99
 azKRIkJcNQAFfxY61ZJuHpz2EWYfJzM=
X-Proofpoint-GUID: 3lYS8iqTNs7xHKRX0APCCMSk2p0NV7iY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250054
X-Mailman-Approved-At: Fri, 25 Sep 2026 14:26:30 +0000
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

Use Shikra fixed pre-DDR memory map when enabling caches in
SPL. Allocate page tables from the early malloc-F heap and
select the board map through a common Qualcomm hook.

Signed-off-by: Abhilash V <abhilash.v@oss.qualcomm.com>
---
 arch/arm/mach-snapdragon/mem_map.c   |  24 ++++-
 arch/arm/mach-snapdragon/qcom-priv.h |   4 +
 board/qualcomm/shikra/spl-shikra.c   | 140 +++++++++++++++++++++++++++
 3 files changed, 166 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-snapdragon/mem_map.c b/arch/arm/mach-snapdragon/mem_map.c
index 17c18e5096a..9df522f7a4e 100644
--- a/arch/arm/mach-snapdragon/mem_map.c
+++ b/arch/arm/mach-snapdragon/mem_map.c
@@ -28,6 +28,19 @@ static struct mm_region rbx_mem_map[CONFIG_NR_DRAM_BANKS + 2] = { { 0 } };
 
 struct mm_region *mem_map = rbx_mem_map;
 
+#if defined(CONFIG_SPL_BUILD)
+enum qcom_memmap_source qcom_memmap_source __section(".data") = 0;
+#endif
+
+/*
+ * SPL platforms whose pre-DRAM address map differs from the common Qualcomm
+ * map may override this hook.
+ */
+struct mm_region *__weak qcom_spl_mem_map(void)
+{
+	return NULL;
+}
+
 static void build_mem_map(void)
 {
 	int i, j;
@@ -65,10 +78,12 @@ static void build_mem_map(void)
 #endif
 }
 
+#if !defined(CONFIG_SPL_BUILD)
 u64 get_page_table_size(void)
 {
 	return SZ_1M;
 }
+#endif
 
 struct mem_resource_attrs {
 	fdt_addr_t start;
@@ -185,6 +200,7 @@ static void configure_reserved_memory(void)
  */
 void enable_caches(void)
 {
+	struct mm_region *spl_mem_map;
 	u64 tlb_addr = gd->arch.tlb_addr;
 	u64 tlb_size = gd->arch.tlb_size;
 	u64 pt_size;
@@ -192,7 +208,11 @@ void enable_caches(void)
 
 	gd->arch.tlb_fillptr = tlb_addr;
 
-	build_mem_map();
+	spl_mem_map = qcom_spl_mem_map();
+	if (spl_mem_map)
+		mem_map = spl_mem_map;
+	else
+		build_mem_map();
 
 	icache_enable();
 
@@ -223,4 +243,4 @@ void enable_caches(void)
 		debug("carveout time: %lums\n", get_timer(carveout_start));
 	}
 	dcache_enable();
-}
\ No newline at end of file
+}
diff --git a/arch/arm/mach-snapdragon/qcom-priv.h b/arch/arm/mach-snapdragon/qcom-priv.h
index 27e5c54e512..c267c0d9aec 100644
--- a/arch/arm/mach-snapdragon/qcom-priv.h
+++ b/arch/arm/mach-snapdragon/qcom-priv.h
@@ -5,6 +5,8 @@
 
 #include <stdbool.h>
 
+struct mm_region;
+
 /**
  * enum qcom_boot_source - Track where we got loaded from.
  * Used for capsule update logic.
@@ -40,4 +42,6 @@ static inline void qcom_configure_capsule_updates(void) {}
 
 int qcom_parse_memory(const void *fdt, bool fdt_is_internal);
 
+struct mm_region *qcom_spl_mem_map(void);
+
 #endif /* __QCOM_PRIV_H__ */
diff --git a/board/qualcomm/shikra/spl-shikra.c b/board/qualcomm/shikra/spl-shikra.c
index b967b0137b1..9bab677cce5 100644
--- a/board/qualcomm/shikra/spl-shikra.c
+++ b/board/qualcomm/shikra/spl-shikra.c
@@ -3,15 +3,107 @@
  * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 #include <blk.h>
+#include <cpu_func.h>
 #include <asm/io.h>
+#include <asm/sections.h>
+#include <asm/system.h>
+#include <asm/armv8/mmu.h>
 #include <dm/uclass.h>
+#include <init.h>
 #include <linux/err.h>
+#include <linux/sizes.h>
 #include <linux/string.h>
+#include <malloc.h>
 #include <mach/qclib.h>
 #include <mach/spl.h>
 #include <part.h>
 #include <spl.h>
 
+DECLARE_GLOBAL_DATA_PTR;
+
+#if defined(CONFIG_SPL_BUILD)
+/*
+ * The SPL device tree does not describe the complete early physical layout,
+ * so use Shikra's fixed map when enabling the MMU.
+ */
+#define SHIKRA_SPL_DEVICE_REG_LOW_BASE		0x00000000UL
+#define SHIKRA_SPL_SYSTEM_IMEM_BASE		0x0c100000UL
+#define SHIKRA_SPL_SYSTEM_IMEM_SIZE		0x00020000UL
+#define SHIKRA_SPL_BOOTIMEM_BASE		0x0c200000UL
+#define SHIKRA_SPL_BOOTIMEM_SIZE		0x001c0000UL
+#define SHIKRA_SPL_DEVICE_REG_HIGH_BASE	(SHIKRA_SPL_BOOTIMEM_BASE + \
+						 SHIKRA_SPL_BOOTIMEM_SIZE)
+#define SHIKRA_SPL_DDR_BASE			0x80000000UL
+#define SHIKRA_SPL_DDR_SIZE			0x80000000UL
+#define SHIKRA_SPL_DDR2_BASE			0x880000000ULL
+#define SHIKRA_SPL_DDR2_SIZE			(SZ_32G - SZ_2G)
+#define SHIKRA_SPL_DEVICE_REG_LOW_SIZE		(SHIKRA_SPL_SYSTEM_IMEM_BASE - \
+						 SHIKRA_SPL_DEVICE_REG_LOW_BASE)
+#define SHIKRA_SPL_DEVICE_REG_HIGH_SIZE	(SHIKRA_SPL_DDR_BASE - \
+						 SHIKRA_SPL_DEVICE_REG_HIGH_BASE)
+
+static struct mm_region shikra_spl_mem_map[] = {
+	{
+		.virt = SHIKRA_SPL_DEVICE_REG_LOW_BASE,
+		.phys = SHIKRA_SPL_DEVICE_REG_LOW_BASE,
+		.size = SHIKRA_SPL_DEVICE_REG_LOW_SIZE,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE,
+	}, {
+		.virt = SHIKRA_SPL_SYSTEM_IMEM_BASE,
+		.phys = SHIKRA_SPL_SYSTEM_IMEM_BASE,
+		.size = SHIKRA_SPL_SYSTEM_IMEM_SIZE,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
+			 PTE_BLOCK_INNER_SHARE,
+	}, {
+		/* SPL and QCLIB execute directly from BOOT_IMEM. */
+		.virt = SHIKRA_SPL_BOOTIMEM_BASE,
+		.phys = SHIKRA_SPL_BOOTIMEM_BASE,
+		.size = SHIKRA_SPL_BOOTIMEM_SIZE,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
+			 PTE_BLOCK_INNER_SHARE,
+	}, {
+		.virt = SHIKRA_SPL_DEVICE_REG_HIGH_BASE,
+		.phys = SHIKRA_SPL_DEVICE_REG_HIGH_BASE,
+		.size = SHIKRA_SPL_DEVICE_REG_HIGH_SIZE,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE,
+	}, {
+		.virt = SHIKRA_SPL_DDR_BASE,
+		.phys = SHIKRA_SPL_DDR_BASE,
+		.size = SHIKRA_SPL_DDR_SIZE,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL_NC) |
+			 PTE_BLOCK_INNER_SHARE,
+	}, {
+		.virt = SHIKRA_SPL_DDR2_BASE,
+		.phys = SHIKRA_SPL_DDR2_BASE,
+		.size = SHIKRA_SPL_DDR2_SIZE,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL_NC) |
+			 PTE_BLOCK_INNER_SHARE,
+	}, {
+		0,
+	}
+};
+
+struct mm_region *qcom_spl_mem_map(void)
+{
+	return shikra_spl_mem_map;
+}
+
+int arm_reserve_mmu(void)
+{
+#if !(CONFIG_IS_ENABLED(SYS_ICACHE_OFF) && CONFIG_IS_ENABLED(SYS_DCACHE_OFF))
+	mem_map = qcom_spl_mem_map();
+	gd->arch.tlb_size = PGTABLE_SIZE;
+	gd->arch.tlb_addr = (unsigned long)memalign(SZ_64K, gd->arch.tlb_size);
+	if (!gd->arch.tlb_addr)
+		return -ENOMEM;
+#endif
+
+	return 0;
+}
+#endif
+
 #define IPQ_SPL_BOOTCFG_REG_ADDR	0x1B46070
 #define IPQ_SPL_BOOTCFG_DEV_MASK	GENMASK(5, 1)
 #define IPQ_SPL_BOOTCFG_DEV_SHFT	0x1
@@ -55,6 +147,54 @@ enum {
 	IPQ_SPL_BOOTCFG_DEV_MAX
 };
 
+#if defined(CONFIG_SPL_BUILD)
+void board_init_f(ulong dummy)
+{
+	int ret = 0;
+
+	memset(__bss_start, 0, __bss_end - __bss_start);
+
+	qcom_spl_malloc_init_f();
+
+	ret = spl_early_init();
+	if (ret) {
+		pr_debug("spl_early_init() failed (%d)\n", ret);
+		goto fail;
+	}
+
+	event_notify_null(EVT_LAST_STAGE_INIT);
+
+	preloader_console_init();
+
+#if !(CONFIG_IS_ENABLED(SYS_ICACHE_OFF) && CONFIG_IS_ENABLED(SYS_DCACHE_OFF))
+	ret = arm_reserve_mmu();
+	if (ret) {
+		pr_debug("arm_reserve_mmu() failed (%d)\n", ret);
+		goto fail;
+	}
+
+	enable_caches();
+#endif
+
+	ret = qcom_spl_loader_pre_ddr(spl_boot_device());
+	if (ret) {
+		pr_debug("qcom_spl_loader_pre_ddr() failed (%d)\n", ret);
+		goto fail;
+	}
+
+	ret = qcom_spl_invoke_qclib();
+	if (ret) {
+		pr_debug("qcom_spl_invoke_qclib() failed (%d)\n", ret);
+		goto fail;
+	}
+
+	board_init_r(NULL, 0);
+
+fail:
+	if (ret)
+		reset_cpu();
+}
+#endif
 int qcom_spl_soc_qclib_override(struct interface_table *table,
 				const void *fit, int images_node)
 {
-- 
2.34.1

