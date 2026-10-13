Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEC67CC6B0E
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 16:49:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6C72080EC2;
	Tue, 13 Oct 2026 16:49:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HpmFXA-pyWQk; Tue, 13 Oct 2026 16:49:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A916A80E58
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791910160;
	b=cQ1t5uV4ESGxKDmfLxCifFfHznPnAY7NmAm5yk8QucQuDgO0Z643il3ELJLITcRgH0Rb
	 SMJ4v8bXFr/diLlM8y7I1C6/EXkBSTC5M1fflAhsEIM0L4G6otLx1IQatEulQ4f0bh/SX
	 LxhHDejXNFPyd8KwZhjUYz2x0144/HdOBzMXgnVEivEiX+Oibd4Q2gN4dmbjuFk1kuqlr
	 Nt3SyX40spv7l2gakZ+wFJIjSVhoSj9dGSV5Ibn/ZDyhSRLVXotHsX6hpRWrNYpbPtvlT
	 fekqpDJSN5L9mh/I2xw6sVWO+TPF+j1C7L2RHz8YFJ8aKmDtT1f5BJoN5D1sv4osmFw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791910160;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=XboB0KVdJ1jMTMUQzX724V6y4Y7IT1jWD2E2FvpMZik=;
	b=OT3AYIXaz5kerV0eJFtJv07hJCv0ErQSyInxQHDKWxxVRfGqhUHdc5Nx+LPIAQ5eK3sQ
	 CYCwVTw3yhxxwvqvMSaf69WKeqeCK9NYGn2MasHGDAnOcJNzSgSL8cvwMmeQOUTwszU78
	 09tab41/7x47Bw4N/jquN5BMlYtPLj4l6BnVMeWOlshuRmjnYSUVtkoZ388DIKdUh+CYw
	 ceHMfwwAKuwQsYgghu0C4WOPtOVDsZ31bSNaf0OsKo9Ba9IIvORqYEeyYAXadNL6j5m6M
	 Wv5Hd4+wCk8UNqwufVPuY2UoWscy7M2NHcrfoUiBi6yyDE//GMe17e994udMhr5COxw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VlHz05SV;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="EFpUu/3z";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791910160;
	bh=XboB0KVdJ1jMTMUQzX724V6y4Y7IT1jWD2E2FvpMZik=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PbMi6jTKc7f6++w7Nk9vM9V3nyJp4QPEJsMPDHicnVCpcF0/1r/tFNhdfk6J3+UTH
	 kBz2sHilmEQprYOk8E/2Ww/W3G/rbEx6Axj++HHlfwmwYC6fbGfxkiA8V08ClFpfIT
	 pw8HPNBZ0ebCeU0aeT6Ibnky60QzvKJgwya0s+RQPuG8BDLH4gouiOimV6cpy4BGx2
	 2ShBOGb4kWwqp8Ily5aKEhocRmsuV2+qbe4kN17BsJRXGDa6Bo/k3A/Fb/RIicyOYk
	 i+lIcT5vq0F6qpmrIZjUFd60r5MAN877ZF+eGGy5grgmEDayyHlDSvDmslf/R1xPyy
	 4HthH658e45mA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A916A80E58;
	Tue, 13 Oct 2026 16:49:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id B8483235
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 16:49:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A6A7780E58
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 16:49:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 69pZvkGtFMOW for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 16:49:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 13CDE80A76
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791910158;
 b=DhD4CstlqAuif15OcBn/iB3yuWjeiG1EYUQ00A0pkkgL8x4QLAJW5Zau+f9w+fmntDBV
 Gt3ZWQWcDYS/LHGMmPnPM3WwLWQoRrK8TZjm8CPbGUGdY5fgw0N+p1IlsnWq2pHAdogyX
 21LZRgbVWOOK8SYvhRQv8h6IFMRgNBYnCGzugYhTof1ZbQkImTYEfm3wur9TDSAr2KXTJ
 hgV7y1cjj6Gb+L9qsD1/pZp5K9LLZudFTUVv4nalevq+RF+OHZRBkVPtgtrkHgA0jhLEo
 acKhUrNHVusFq2ruKS0oeocIaduSyZx6jsqOFXsOR+UCAQQaFOhFFDuOcPKwN5DC3jQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791910158;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=XboB0KVdJ1jMTMUQzX724V6y4Y7IT1jWD2E2FvpMZik=;
 b=CZdjOa/ChbZ4S6aYc9uIzqN98+WiIvkK8aRH0yUsl+TdqkosXiYPUNLGsS6mbEl9RJnm
 k7aIk0njvsuiKlRcoFuVuQ3wD7bVy9/HX/bE+aSUXwW9zFKoMELCF97WJ5YRPSji18wzz
 qSIUX1d+9PqKSo0sd1cHfD01bAHg7UkAc/yEDEjCCFv6GlMGDIwasK64BlclJ6mdyLIMk
 poQzx+IgcrW0sIIF/O5ynrtqZKCdhMuYNUDQWwp1z/u0ZNwxWj4mm+NMi6vGNx4bmsNI5
 zFFZNUpAZj26c1PJ9dbvw/fp4zSq/huoqdvKsrOY1YfSYQ8oZgdBAhUQs6qeDmtSIlA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=VlHz05SV; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b="EFpUu/3z"; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=VlHz05SV; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=EFpUu/3z
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 13CDE80A76
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 16:49:17 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69DE3gdA1143678
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 16:49:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 XboB0KVdJ1jMTMUQzX724V6y4Y7IT1jWD2E2FvpMZik=; b=VlHz05SVajC+0yUI
 r0UblkqZKDXIM5EmSNVWphyP84okG445ZCp873xTf5GhKFBZsX3Cjnrg0DKczOi1
 UO28PG4NRaNkI65P5LYA+PssIhfO323jP0M2S7yIdiUxcU+WDkrp3rVCeEkPsrYQ
 943+1ITf91eU0GsWXuLBYJyJzjkvIdreulnwKf1vFftwcSRzgEBFdAu2BGjAFQQQ
 4ymzEiZDDTOEhARiuS/VrGUaLvi+RwZiDne4oAfjBr0Y0937VIbalmSbXEttYw6V
 PuYUjUkX+m79udZ4KPcPWaHM1A13vCQoRMkGdRKd1CxzGOY3rk6R8s7NI/hpn08R
 UIyujA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9hpga1kx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 16:49:16 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-35c5aef2a74so217360eec.0
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 09:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791910155; x=1792514955;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=XboB0KVdJ1jMTMUQzX724V6y4Y7IT1jWD2E2FvpMZik=;
 b=EFpUu/3zjPwnQK2BbcZPr22WiP4VxVjesTf9l0ZOt5sAKTZ13jlg9tYodVAajfmjvD
 XHxSWSkHBMZVemLsmjzwM/lA9dOJUCZL499zlQs3s1H2JMW4ZrkXIblsYNz2MKkOe709
 3A47BcOdzlRsNGscqTrMBuepqELBkdsx5PaondTck2wtlKMAJu/Qq2FB6/3VtnJzevBA
 k7U2GIQFCWQwGF1W6I/XYOKQ2MrKZrmkvZ/WrW7QUH628kgNSQI1zfbddrvukOFDTk0d
 9AmYrr5OerY+PPEzAEPbRjXvAk8eL12UlOjJZ9jonX3f338Xyli990ikYqy76LWyicCQ
 Oc1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791910155; x=1792514955;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XboB0KVdJ1jMTMUQzX724V6y4Y7IT1jWD2E2FvpMZik=;
 b=lBkJQtLehPHKyzyF+Zq8jgf8pri+7ZJO93HpSuQw6lUvOpQgx5yaeQ/F3ccDOjWHKW
 DXGcznF+nrr3roqCkdPlcMaBHC/RygK8Yo8jYP8G82Zlpk742Qu5IkMnPqHUB095y7Ej
 dMmz/xMJI3itxMsWAud3XuLX433YoS57LFXDzjhM5eQxBgaPex4ivdZBnWOJdpHdlLlD
 fAh+zYQ4ql84dKLDYy1SX4PEccEQq7W+SywotxO1FsvUC9IstgwphKn1vcg8evL3zPlR
 ZTyd/4GgQ8TKy7aVXER3Wjvyif53Rz9nIeWfW7jy6Bq6yrjlpDX8ILb6At7W5Cgl1mA1
 TNlA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxwzy5BbD0qPYHQej6k2N9FIz6K4ttCKTFynPzqKdGTxfxyx/04iljsOJmYBilL3WFlZ4bexfM=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYInnWazTCP6/TIHhmKW6IljI6yAUOQ8J/VXwwwc4UmfcxoW4wRh
 neC0hC9E0NMXUpGaoCFiTHo8dlvn+rMwvjfuJKz+PFUPH/0621CyaXMHPwdU4TurxuCmdSH3OSV
 iSgocoJgKp3mlJtgNGjs1IHTLOUNFQwfCosc24d5+qsoffVZtcWIAHhuk0MA6WhJPM8Ct1dsf5/
 r2n9M=
X-Gm-Gg: AYBFou11XX3mdZO8ueWeie8QDk4N/sLxcUeTIghCnLqiFgDurt0qgWhT3cDYDPz9CBc
 Ff0xtdggDSSvZp99xbpDTImnytAT7LmK2HePURrUNPutEqtQAdrszd0CnP5N7Z5q6hI8uY+O5r1
 rO00WJAb5VsKx46Dd+Z+ngU4DEy2P8IDOfYc1gayz9zVWxFIu61Z87NNwvkNuJNUDxnGRVInK4X
 pDj/WbQHBroDb4C0QUVBouYnZcdV5W9RVKFL6Di0/2wWVJI/r9jbcV3g0qHq5s8PQ9laS1XkLBN
 9Ni+r2VUaxWuHPGEnZdH+LM20G9yxnJKKJgEjNvCzn8DA549DINal61L8/83tDhR8IehRLpziNh
 jaZP3HHMb5QyL7Xx4gCySoLjXArwIUdwjvA==
X-Received: by 2002:a05:7301:1890:b0:351:13b4:9c59 with SMTP id
 5a478bee46e88-3537dde3eb0mr19878516eec.2.1791910154875; 
 Tue, 13 Oct 2026 09:49:14 -0700 (PDT)
X-Received: by 2002:a05:7301:1890:b0:351:13b4:9c59 with SMTP id
 5a478bee46e88-3537dde3eb0mr19878468eec.2.1791910154117; 
 Tue, 13 Oct 2026 09:49:14 -0700 (PDT)
Received: from [192.168.0.6] ([49.206.97.56]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-35b690af3easm15483555eec.1.2026.10.13.09.49.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2026 09:49:13 -0700 (PDT)
Message-ID: <b03aa068-c69b-427d-a50d-b5b3ad391cf4@oss.qualcomm.com>
Date: Tue, 13 Oct 2026 22:19:09 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "drivers: usb: dwc3: Add delay after core soft
 reset"
To: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Chris Morgan <macromorgan@hotmail.com>
References: <20260724-kodiak_delay-v1-1-57b687e6d67c@oss.qualcomm.com>
 <87ldb07bdb.fsf@kernel.org>
Content-Language: en-US
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <87ldb07bdb.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: tlNnB1M8AS81TZOnCavAqvUsuXAza6Kp
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA2NiBTYWx0ZWRfX7UuwHMx1FJav
 d2P74OOM3oJbb2AP5vS2AvQXWfG/br9PDsx4R4aRKVr5mVLtLSpIN3t0PsYxTotkuaGvpEW1S07
 Uv5rrXu94AyaNnL0pRbwHQ8bpAN8C7c=
X-Proofpoint-ORIG-GUID: tlNnB1M8AS81TZOnCavAqvUsuXAza6Kp
X-Authority-Analysis: v=2.4 cv=Z4Z5j3RA c=1 sm=1 tr=0 ts=6ace610c cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=215ql7HDt+dySc6PayfnQg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=Az5zpQ0G5qWVnpgRR6EA:9
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA2NiBTYWx0ZWRfX3C2O1583CCcr
 Ie5T8DIoL730jxWeggdbs7lCfCXa1APQIoZzBdQ1WRzjN2XdsRH12PkZ9hWT0xYJkJbhuLzIyXN
 qG4jo3F+60xvLMrWVOFhw6Z3pAtJFnkrDo4aV9izwoUbS+/3cd3bJQEnnjZWlVwPl7AUmMRXMgZ
 r2dl5cZI31BLDW+mVJ0xJHavQiQ6Gz7/GQh1QfHYQhjSmlQgZlYK5I62tSZXobzFZDijDMmR+AD
 spFNz07BXHRd36f557hN6N4IRGqqmFSkSrIMoCcXoEXli8/XEF8dnpdNJkHlLw6+VeH1vgBXWEU
 L7Bp5FftFDIAExX4M/ZTF2iZ0j3CIuvg2k41IPMmvxyqgwu84LO5nopKC4YVCedJkTYAszFcJ10
 bBPi2PPEKISGpHfmUah8zgneKQCeJc1tmP9VkdlHJndlihWB4VAQp/XG+1w6UtsQed57vsQTiWj
 JLVfa4hPP0MNT1dx7CA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 phishscore=0 bulkscore=0 adultscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 spamscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610130066
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

Hi Mattijs,

Sorry for late reply.

On 7/24/2026 7:12 PM, Mattijs Korpershoek wrote:
> Hi Balaji,
>
> Thank you for the patch.
>
> On Fri, Jul 24, 2026 at 14:58, Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com> wrote:
>
>> This reverts commit 6de333b5caf035c38d7af9fa7596aeffcc49db42.
>>
>> The delay is unnecessary. Upstream Linux does not add this delay after
>> the core soft reset and the USB works fine without it.
>>
>> Tested in QCS6490 RB3Gen2 Qualcomm board.
>>
>> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
>> ---
>> - This is part of ongoing initiative to reduce boot time across all
>>    Qualcomm boards. So we can remove this unnecessary delay.
>> - Actually, this delay was removed in the Kodiak v4 series:
>>    https://lore.kernel.org/u-boot/20260418-kodiak_ss-v4-0-d381670c9d78@oss.qualcomm.com/
>>    but v3 series got picked up: https://lore.kernel.org/u-boot/177745255938.126665.16625119085748603933.b4-ty@b4/
>> ---
>>   drivers/usb/dwc3/core.c | 2 --
>>   1 file changed, 2 deletions(-)
>>
>> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
>> index be198041f08..ae22e1c792d 100644
>> --- a/drivers/usb/dwc3/core.c
>> +++ b/drivers/usb/dwc3/core.c
>> @@ -106,8 +106,6 @@ done:
>>   	if (DWC3_VER_IS_WITHIN(DWC31, ANY, 180A))
>>   		mdelay(50);
>>   
>> -	mdelay(100);
>> -
> The dwc3 driver is not only used by qualcomm, but many other SoCs.
>
> That delay indeed does not exist as is in the Linux driver since the
> following commit f59dcab17629 ("usb: dwc3: core: improve reset sequence")

Yes, this delay doesn't exist in Linux driver and the delay was added by 
me in 6de333b5caf035c38d7af9fa7596aeffcc49db42.

But found later that this delay is actually not required and hence would 
like to revert it. Have tested the revert on QCM6490 and USB inits fine.

>
> However, that commit is more conservative by adding retries and such.
>
> I'd prefer to stick with Linux's approach here.
>
> Also note, there is an ongoing effort of updating the dwc3 driver by
> Linaro here:
>
> https://lore.kernel.org/all/20260716134305.614278-1-anders.roxell@linaro.org/
>
> Could you maybe give that a try? It should have the
> "usb: dwc3: core: improve reset sequence" patch in there.
I agree the Linaro series is the right long-term fix, since it carries 
the retry-based approach from Linux rather than a flat delay.
That series touches a fair amount of the reset sequence though, and it 
may take a while to land upstream.

Given that, would you be open to taking this revert now as an interim 
fix, since it's tested not to regress the platform it was added for?

Regards,

Balaji

>
>>   	return 0;
>>   }
>>   
>>
>> ---
>> base-commit: d7ef23c07b8e34f65b3e15e3b4e7f58d074923c8
>> change-id: 20260724-kodiak_delay-a5f1e8b675cd
>>
>> Best regards,
>> -- 
>> Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
