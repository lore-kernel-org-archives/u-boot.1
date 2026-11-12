Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7323060A3817
	for <u-boot@archiver.kernel.org>; Thu, 12 Nov 2026 06:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=HAwnBGFW;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=JYhVsYA6;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BTzQXEJe
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 39FFB608EB;
	Thu, 12 Nov 2026 06:50:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8CRs5TYZHeOX; Thu, 12 Nov 2026 06:50:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4037C608C7
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794466205;
	b=Ier5/n0dFmIH2utH1v8UejzfpPKOOCaREavfD7l9sTTjxAP8amil2GuvomTBV54Rddx4
	 opyxTQpZe8WI41te5ZBcFvuYehGNNMAtCzesCFw1xkZeVqz36nvG1xL2TY23YONkWEdWd
	 waNa+6FHHndEqN21ASruASpTjKBdOtsBiSeXrgWcnxlzEYORa6TEyqCeMC+F7rY1Y4SLq
	 RtR7+GbyoszpcsaUFw/4df0DTONeT/47IShXZzhzQe79ccw6obEmyi6eDDt9jDfi3E8gl
	 vlFugaHK72/8p+6NzMhgQHd1n27EVvgFHAVRCdurv+R8ibYVTtrYm00SfzHvrTfAeAw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794466205;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=05oLPQ6u8IDVb1EGfvY56SZ80wa1bY2BK7IePtrgWcc=;
	b=EXbUH1MSIYXOg4i3ZxDPjidinGn2W1XHDIT/K3mQCWrS+lNq69xI9zzCYNuIIW/gEpmD
	 Bn9YFwMKcZWHK29WhDZZdLPa095IQA/2mmWycempjH9O5uLjTTRoyJQe/UWfqW3J0Cvfv
	 Memj63WUMAitgGlYIX9rtWm+RJTNt/kC0WPdnV2tGyzXn2f/4QXE2qk3QrYudZtSlA6sK
	 qdKj4himUkX8gbFWHTX0fnAt05M1z3TEAPxZbvN+GmMu7W6ezysNDb8bpBt+r2kNRSPpt
	 u9RyrulrWnL47UupQZVuXQ0d4err4Wu/RY9pTqEoNqVeiWvznyOrvtl2+bK2/qvmADA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=JYhVsYA6;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BTzQXEJe;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794466205;
	bh=05oLPQ6u8IDVb1EGfvY56SZ80wa1bY2BK7IePtrgWcc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HAwnBGFWRPTgxVYzvT3kwuaT9LSiE6pCxRbTEoMJX9GkTonkOnGmbJp6ZX8nPUMD0
	 3lcL9L6AWHU5QY6L1sW1i/b05aj5Q0vv960dQfMudHOyC7tcoQTsNXe0C6gq2V/+YZ
	 FpTp5+l1auV+n5M6d9qnD8kMPu71z/xiGDoQ2q5s2mCF0wEl0YhLmwF7wlAL8WzGAR
	 KIpA2Iz7TOy9sNrTv632Ar8CFdSP95zOsgZxaIsui5FVYG/d/FQs3g2c/M+U8PbKGD
	 9PyNihsYDGk3aEyrhnb6+UttiXECPox0vShmnSPFjUnurs+O6zodpwCR18EIBY+aSY
	 x1Jh0dkAuumMg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4037C608C7;
	Thu, 12 Nov 2026 06:50:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4859DD7
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 06:50:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2DEBD608BB
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 06:50:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id B09VAJuaUS0v for <u-boot@lists.u-boot-project.org>;
 Thu, 12 Nov 2026 06:50:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org F38E4608C7
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=JYhVsYA6; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=BTzQXEJe
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F38E4608C7
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 06:50:02 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AC2Za5e2135756
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 06:50:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 05oLPQ6u8IDVb1EGfvY56SZ80wa1bY2BK7IePtrgWcc=; b=JYhVsYA6THAym3VA
 niiGxwOZGxkVsiykhyzQIjjfi8uApVGnHYDu3BIyjyDuEjaWye7nN8E2nS8Qmo0b
 c0QXYE0IRP8H9JsMGJ6OinTxbJzQsZt5QSbfSeCzqf1F2puXS/V0/cPg0QA0EUdO
 /5ibk5UJ6EV6oOeQEt57o2c6AfJDqDlTkJnOZOyc8wIhTVJ3uZ1BlUJZGlPhAnvK
 WQ5i+itbK55vIHPCPih544T8ZK0BE3A7ttU/n1jV156I9GtDbN4SwoFgOQoPLObw
 6j0d62kuEcmBZyanUi0PJG0hlYNgl5++NZleGFBiQADvI6Arqg8q+NuUKFRfcBzW
 5Ttd8g==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvpjjvfb7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 06:50:01 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-36ecd5db581so154212eec.0
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 22:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794466201; x=1795071001;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=05oLPQ6u8IDVb1EGfvY56SZ80wa1bY2BK7IePtrgWcc=;
 b=BTzQXEJeDhQOOX5rzdXyv9MODwNqqAtbqgGneQR5HGsd5uGp/0ySwUq5lSDVhDe5vD
 nHipLKsPBpfXpRTcpCzsae9+AZiprtNDH5MWJnyIS4y2w9m/3mdPtkvzEppe5Hx2HOx+
 HLY00zdErWKLEftWqFLQIczZTYBH/JdUoG7YHf1R5SisgIT+hJ6MKZfAh9Bg6qPz1Q9s
 lbvWhIIoeirNqtxrJkQ7WZEN7KVzDIyi3gO067VuOJsLEvt2+BaHyrMNC3Fk99GXKEVA
 xPdsLoFWF2dF0IHZdNERAxy7Vs97L54Uc4TwVrX+usFf/D/Wsm6eyaysJmbr2vHQxKGo
 xHow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794466201; x=1795071001;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=05oLPQ6u8IDVb1EGfvY56SZ80wa1bY2BK7IePtrgWcc=;
 b=FpPvkLqAIqor8fEauV/OCqFKhsk74NoXjNVYbFxpmm/fMlDY6K4nO9fPDXVDxx7kr8
 /MUPDhOWG1rWwmuA1oSvH35GoQP6EGRc4WSwPwfRKtVlPiDDZTKLVyj8kz6oMSIRLEAq
 02QU/HCOzw1sb3ynCzUZwn55vL9Nj0Ekki5YMip/39N1kRBYAaVLhPHSCPSKXr+BxgMI
 GSxbipgVFQ5cpV1czArH0V5ejeG/NbccAPTBbZ4cISzjYMXL1wmUWR8MWZxp1o9eoQpz
 DtFxaVDo/y2CqD2NyWgyMEqM6ySmmRVJntdR44hreZL3zAI0u1J71h+MkCwL2moC55dT
 8knw==
X-Gm-Message-State: APuU4Z/o/eYtYZo1EIzqTaYSV9T/BcEYsKzoXtlaCv88ixgHUmoau+BK
 FsqMePtmykLO0cjZJGV99Eg6j8FU0mqzlBdvnhCrxCVlo7VcQYqRDEyf8QBMW7mu5dG60laXJHT
 CtAF6XMtojeTzT0J9/tKd6A5gxZcWGSMfaxEchntiEoxrkP7cOkuGPikdUDUCwyE7pY4vGDNuyF
 LB+psiwcI1
X-Gm-Gg: AYBFou0xKdi/IKWMQVfODCnhnJpAqzVeW883Pw4t5LMI6DOlqBxEylXjfWKW1c/q7CP
 iFuwJAOKq2AqaU3+uM3ivFXhnTg10d3TKZsL8PLmiGGcoQNvpbjfD7tpStbNbhcnkUBj2k9ZZCE
 Fju9ah0IRK3L4VLrFSBZe1uPIg2KvFzxYTyduZzTItEAuoK/2Vj/FZPFsI1pl1b62DK7Oa/QIyB
 Q8xVjxHy7qszu+yC7TtVn8P3/sf9uZcTupSsy4qFlG3zo7Chq7XYRNRy6gY8naisQ7MRkqBiuWT
 9uYP++oc94fpXtrUBTidIBFAx+qwwaoF+jLS4Def4kvrwbGL3tBhrZ6VPP/gXb5nM81VEHXTuVE
 A7xySjiJzI+prm7nDH7RU3clJO5TIm/Mih2b0Y+NSYoMEt+cUap1qaLOzBSkvMKEt23NzRTJfpz
 ky1k9GWRohh5s=
X-Received: by 2002:a05:7301:dd98:b0:378:314:4041 with SMTP id
 5a478bee46e88-37803144b5bmr1460584eec.16.1794466200410; 
 Wed, 11 Nov 2026 22:50:00 -0800 (PST)
X-Received: by 2002:a05:7301:dd98:b0:378:314:4041 with SMTP id
 5a478bee46e88-37803144b5bmr1460567eec.16.1794466199826; 
 Wed, 11 Nov 2026 22:49:59 -0800 (PST)
Received: from [10.151.41.168] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-375212e76e2sm24903501eec.24.2026.11.11.22.49.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Nov 2026 22:49:59 -0800 (PST)
Message-ID: <48b70a35-e65e-4cfd-b830-911874c45f4b@oss.qualcomm.com>
Date: Thu, 12 Nov 2026 12:19:52 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 2/8] arm: snapdragon: Guard PSCI functions with
 CONFIG_ARM_SMCCC
To: Casey Connolly <casey.connolly@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io, Rayagonda Kokatanur
 <rayagonda.kokatanur@broadcom.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Johan Jonker
 <jbx6244@gmail.com>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Michael Srba <Michael.Srba@seznam.cz>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Simon Glass <sjg@chromium.org>,
 Hongyang Zhao <hongyang.zhao@thundersoft.com>
References: <20261021-snagboot-v9-0-18ce3e431320@oss.qualcomm.com>
 <20261021-snagboot-v9-2-18ce3e431320@oss.qualcomm.com>
 <20261021173537.GA3275858@bill-the-cat>
 <fbc41e04-88de-4ac7-8267-dba976929fff@linaro.org>
Content-Language: en-US
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <fbc41e04-88de-4ac7-8267-dba976929fff@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDAyNyBTYWx0ZWRfX68XK3ZJX4rvC
 /BDHY8BsTdfgCm176fRgkcTyQU4vLqLA67wQMg0wRKLbB1x1YcoUJo+JoOd7rdZDuRPdC2/hEim
 gua3gozADs4Dw3DMogHfuE9HCDOhqLV4X5bckHulbwAECAuHDNuhlw3WoCcDJrrUsPek8BoxYzQ
 eTiuaQ8p/Vyn1RnLFgUXf493MeV7/WJZwbU7giYY6lTYaikiYhUtpnLoqQlT0oLPZl4r4nHAAqn
 QCP01yy27HMAhk6oCQNSe/KhGiQMtB2dMzv0vH9LfYPlLgEyQVBcLGTWHsvgxBDpEguveQ8JoNA
 zs+DLwHa+a9DsfMXZpxEfKUGLjN9tPD08H3IlP5ZBA9eYHzu9hAMzTFxexgKHhHCW109DngKCcz
 983xOBUNxPIHatsvv7UsoTrwxi4E1/y5FZJkPzJe1PWqfARNVfzHj/V+A9pzv1pwcm+VqXFaPq2
 lhkJMbVM8sotkb0MQ3Q==
X-Proofpoint-ORIG-GUID: YQkCJDvbsHj1WRpsNAtANFMhreXTYKDa
X-Authority-Analysis: v=2.4 cv=FeuiV5+6 c=1 sm=1 tr=0 ts=6af56199 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=7Q0gskmYGg_dxZgL3zEA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: YQkCJDvbsHj1WRpsNAtANFMhreXTYKDa
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDAyNyBTYWx0ZWRfX8xpKkg/2O9IM
 r8GSpKlyEkEwqOYixMlgmcWcAeZUtvWgLG+tkLV2sFMTC0FXGeFlSeAoF9d6KAZ11hKjQauRgpD
 eTzlTucxt3uNMpj1h5G/ZrkPM8A1FZo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 clxscore=1015 bulkscore=0 impostorscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120027
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Casey,

On 11/6/2026 10:15 PM, Casey Connolly wrote:
>
> On 21/10/2026 19:35, Tom Rini wrote:
>> On Wed, Oct 21, 2026 at 09:48:21PM +0530, Balaji Selvanathan wrote:
>>
>>> In snagboot mode, U-Boot is loaded directly by XBL without PSCI
>>> firmware support. The functions show_psci_version() and
>>> qcom_psci_fixup() call arm_smccc_smc() which is unavailable when
>>> CONFIG_ARM_SMCCC is disabled, causing build failures.
>>>
>>> Hence, added CONFIG_ARM_SMCCC guards to both functions.
>>>
>>> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
>>> ---
>>> Changes in v7:
>>> - No changes
>>>
>>> Changes in v5:
>>> - No changes
>>>
>>> Changes in v4:
>>> - No changes
>>>
>>> Changes in v3:
>>> - Added CONFIG_ARM_SMCCC guards
>>>
>>> Changes in v2:
>>> - Newly introduced in v2
>>> ---
>>>   arch/arm/mach-snapdragon/board.c | 6 ++++++
>>>   1 file changed, 6 insertions(+)
>>>
>>> diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
>>> index 87adb100edd..daee2ed4fa0 100644
>>> --- a/arch/arm/mach-snapdragon/board.c
>>> +++ b/arch/arm/mach-snapdragon/board.c
>>> @@ -35,6 +35,9 @@ static void show_psci_version(void)
>>>   {
>>>   	struct arm_smccc_res res;
>>>   
>>> +	if (!IS_ENABLED(CONFIG_ARM_SMCCC))
>>> +		return;
>>> +
>>>   	arm_smccc_smc(ARM_PSCI_0_2_FN_PSCI_VERSION, 0, 0, 0, 0, 0, 0, 0, &res);
>>>   
>>>   	/* Some older SoCs like MSM8916 don't always support PSCI */
>>> @@ -58,6 +61,9 @@ static void qcom_psci_fixup(void *fdt)
>>>   	int offset, ret;
>>>   	struct arm_smccc_res res;
>>>   
>>> +	if (!IS_ENABLED(CONFIG_ARM_SMCCC))
>>> +		return;
>>> +
>>>   	arm_smccc_smc(ARM_PSCI_0_2_FN_PSCI_VERSION, 0, 0, 0, 0, 0, 0, 0, &res);
>>>   
>>>   	if ((int)res.a0 != PSCI_RET_NOT_SUPPORTED)
>>>
>> Do we even need this, patch 1 of the series disables SYSRESET_PSCI when
>> you're doing this special snagboot mode so we shouldn't be calling
>> show_psci_version at all.
> Somehow this show_psci_version() function has managed to stick around
> mach-snapdragon since before I took over, I'm not sure why it's here, it
> can certainly be dropped.
>
> The second hunk unfortunately seems necessary still.>

We moved to v10 for this series: 
https://lore.kernel.org/u-boot/20261101-snagboot-v10-0-e73d5cfedb8a@oss.qualcomm.com/

In v10, this patch is removed as SYSRESET_PSCI is disabled if 
QCOM_SNAGBOOT_MODE is enabled (in patch1), so psci functions will not 
execute.

Thanks,

Balaji

>
