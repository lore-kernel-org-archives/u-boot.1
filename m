Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05385606A689
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 04:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=VrICzhv1;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=o5oO7Xni;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OxGpXkfT
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AE11A6065A;
	Mon, 23 Nov 2026 04:54:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EuJciGAWeQOW; Mon, 23 Nov 2026 04:54:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C78726068D
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795409648;
	b=QbtEL2hwDy/sPBeJ7orbTmt9PVfqprVa5W36jI9QsGb41S8CFngQoXXPEflmkeaCHp6/
	 zAGWcEJxfdC1LeXAGhXWsmk/GxOaUdOpffsGWXlh24Ewgo7fgKdczln38uzx8/caTfpKy
	 5utwWIiXUmlZ+fBIaFh7WkTXVtl2A3mKU43OkmcfqamGXN/Z5l11c9oEWwj9w+8fz88ee
	 hCJS/iHwUhNu+GmuzD6V5m58PZc+MKpY8Bg971RP8a7FCwD5lpU9X2+zlTbb0Dn825Qgi
	 Ij3KqJwKDMyHcrX6eu1Q0GoUhkx6f0ocYB0sF1rHxhBP2Y5IY2EvnIC4O/dWGZnKISQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795409648;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=FhubIZNC1Rz5foNSN9iR4E5RgZNJQgdp3+H+hcp3bj4=;
	b=cgJL9ome0AtnTotzjwP9LjSsUBISrlEVEbGjt1a/X8jTPPpLyd6ZtGLjBABpQoCGG5eA
	 9ftMZuZfTa8Tl27uPYzV4KcvTa6pslFnrqsTMhgTr//xieBt6ax/riYWEfwOqdnepbNuc
	 X5ep041FfELH5TmCATbcI+CKN3tGy9vPa4k6ZdfcP0vhylP8GBy7eZKiFTOwuU6e3JG7S
	 edRcYZ3hk/6u09dIDvEYLDDbTnH9qDlhn7kOZLoe6GT98m7KoQltJpaNioKZT3Uzp9VuA
	 5LdG6R6xK77k+CwVOcgHE6U8djdkbU/w0SihEA60KRcHA12625VsW1ZJ2uV6oLHlgZg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795409647;
	bh=FhubIZNC1Rz5foNSN9iR4E5RgZNJQgdp3+H+hcp3bj4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VrICzhv1y5QYwrC/xqVkljdATWpqVV5iWurtPwTt+i7XKvYBKj5odauK2RTMODUKh
	 P/xOds4jvifdaizVd0z6euWkxdSczyDaMsclD1s2a/Loqz3FB2Y7AsFpaHA12BOQWm
	 BTxbPcy4I/Q/odPzuWQevGNIel6gJLYj0ir3VVYRtjH4mU9L9Jt9dZoelknMomWQc2
	 NXpXarzG9LKy1x0Scb8VuHUAGrZ+0XABMTUZ0PtQC+u/Jveey8Fpng8rUnJrw2n7i8
	 VGufQ8REF7mX+yfN67Seu4+OmMnpVop95GTWXyDSnY69SLs8wAcr8Jxm2vDbBrRzAt
	 VlW4DSZB8HSww==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C78726068D;
	Mon, 23 Nov 2026 04:54:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 5CC2C260
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 04:54:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 42D52400FF
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 04:54:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id N3uXAz-KvhKA for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 04:54:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org E86AC40081
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=o5oO7Xni; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=OxGpXkfT
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E86AC40081
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 04:54:02 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AN41E3l1206403
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 04:54:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 FhubIZNC1Rz5foNSN9iR4E5RgZNJQgdp3+H+hcp3bj4=; b=o5oO7XniEaibu0Cq
 LAOQq46yt/KGBfanmiqrph6ocEypDXGYTzKpusHsfjPRLhrTcWrFspW64EwJd2jG
 nOPZ0t//rXKUQfk/F4/i5SyASyzaP6whUIvSirdo/NQH+qxN7F5KfFDLL4I8d2Nu
 +gkLynldlpp3WQY/FnThHLi8DldBx84AT9vPE42z0ZHkvfgFraTcMgtaSeHYsZ7t
 10p+VjSF07h9Rx8eUcmLFsu+LLAtMMWiHP0frHV7gSQnw42dxgBIUIoEnCdXW/f3
 sr94V6e8TdZH707IWh0nH1FNRCDJbgR6zjn5i0f5nW0LVkDVUoWSFY9QDENQP0OJ
 6phW/w==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j33cu56fh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 04:54:01 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-386ad819860so1852186eec.0
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 20:54:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795409640; x=1796014440;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FhubIZNC1Rz5foNSN9iR4E5RgZNJQgdp3+H+hcp3bj4=;
 b=OxGpXkfTjmBFk0NamLHGncsZO3uPYw89Z1niN1dKeroJKx6zfGlS2qKKg8nGmvIsCb
 uyabV9ueizRuTGhwHTSgAfl25UyCx7XlHrHySTiP0SjT9KjsXKR1GWHwYGWpubBtMMUh
 +V0Sp0mNEq4VQ2DvDWZOqmkKprPO6OKIUSOQ8tUQ3UwwQnDdoLhdcHdvcDjkSMZ/oc/u
 Kmt7hkobe8qlZ/wDr8QhbZs8HXVllkYcHkqMtNfFrSKjtWVpmCZoOKnlVWGUl9KwFATo
 z6EDhLI/bhn/WiT6KnrSX7CDJ3pjIfDW91tHfwu10MoKSlJCApn49puUNI1NWKpAvXSa
 9+RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795409640; x=1796014440;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FhubIZNC1Rz5foNSN9iR4E5RgZNJQgdp3+H+hcp3bj4=;
 b=wm/wQwrNmJzY5j9zR8OIg9uvXtzAyqIx+YHLjE+erRaDs9PzakoRwtdYpLaWEty28m
 hPFxCZFacQ7V9mY08Xpud6v80NL5B5fMlD1OOyd1Rr6dhqDDj0cgdWQIlDLqTNeWHSVn
 eGAR7wvql185cZhZvNTMg9BiYWKTBN7If7eZxb212mFRYqr2xYVmGVjiBDaF8LYSX340
 QwWISGyHBi5qQ9c/r9+BLGBMuCPiTSGRcgYnMWwLulvxFEQ6Bg7uKInRw8ovrJRTctym
 RoqBc9Zvp0TRx/s7p8iF3aux65IZtwZPjiggrJpHEEEU1Ls2F7+TPa+djs6Ug+kgg8TZ
 FCfQ==
X-Gm-Message-State: APuU4Z9KugBXKfkA6HBW6EAdqkq0fkESoA+IaEPqf1+8JRpb6V1SdiOy
 az3CZb4/j78A/Vqa43yX7LzyTFue6qw+W2ouIFiYPMgPuEMtT/lxXLLxmh3SdSEr3qsrVFGtqca
 2v+9ACeFJJ0JrqHQRFOYfs0l22WNF74Z44xk3St6r866IMDH6AHcvpFih8grgVdTOXYrD+TE=
X-Gm-Gg: AZFdTZeENm2U486pxPHDtSS/gfs/0sPc1RedMGFBcy5IL312v0oVBh5DXkrJ4aCFaEf
 Sdj1Tcowb7q7T9mxsve52ssgGT6zRGjtQumJpixQQHzbLtlVouZqIuNOKOY6z7sgXe76fUrJnT7
 ga2W4rWZT3wq91yTYMx8M3oPK8gJPnKlt1dzlKTSciM+gQVwzNSZSjhqPd5oNkeefqyoFgx404t
 4GSCf/nAxTknzCmlm0qPbRSY54uXf8kXvBvQW0UQbrtRbEfQzKyO3iMXDfa8Bze/yu7rWJd+2W/
 vucr0fxpcTvyk2SyBeZC+yzXG+B0IRf+GGwNp0eX0BDEPuH70llEeheaI6N6AVQrfuBJ4MAKD3E
 JP/Uq7IFhD1n0jOxDVO3dOeSQlrW2c96redvEK8cL/n+KebbJXF1vibwPmUoq+fJLuI+yPE0W4O
 WbLNidN1BblTR1BYbh7fUEhK2rHWaRZalZ7jO1XzbdpSyO/0pKCuwJoIb931Jk14ZYmCSv0yyZ9
 e/M
X-Received: by 2002:a05:701b:4555:20b0:1a2:2da2:b278 with SMTP id
 a92af1059eb24-1b556894b6emr11951517c88.14.1795409639948; 
 Sun, 22 Nov 2026 20:53:59 -0800 (PST)
X-Received: by 2002:a05:701b:4555:20b0:1a2:2da2:b278 with SMTP id
 a92af1059eb24-1b556894b6emr11951490c88.14.1795409639356; 
 Sun, 22 Nov 2026 20:53:59 -0800 (PST)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b556847fdasm28245170c88.13.2026.11.22.20.53.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Nov 2026 20:53:59 -0800 (PST)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Mon, 23 Nov 2026 10:23:40 +0530
Subject: [PATCH v3 1/2] efi_loader: capsule: allow platforms to map a
 capsule to an image index
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261123-qcom-capsule-dynamic-fw-images-v3-1-b665b48e0de2@oss.qualcomm.com>
References: <20261123-qcom-capsule-dynamic-fw-images-v3-0-b665b48e0de2@oss.qualcomm.com>
In-Reply-To: <20261123-qcom-capsule-dynamic-fw-images-v3-0-b665b48e0de2@oss.qualcomm.com>
To: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Mario Six <mario.six@gdsys.cc>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Hem Parekh <hemparekh1596@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 James Hilliard <james.hilliard1@gmail.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795409628; l=7609;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=4OzaKupxWT1a5/QAzs1MIv7d90EX+cfnlbhJe8GcQaw=;
 b=Mbqfsb2/34ZR8HQjx3qZdklgUhv5J0dBX1BkKHJ+z3C6cUKyCkIhtKGmvO9B7VKN3ITLFS8yA
 Fe4ilSpla0WBAkqv7rDGQ5Kd+n5YJL4olx9+ehJi3EA7nnWqyYDuHlw
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-GUID: hKvpnUDDzBPziKJmg_uXoDZdVKXE5Ap1
X-Proofpoint-ORIG-GUID: hKvpnUDDzBPziKJmg_uXoDZdVKXE5Ap1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDAxOSBTYWx0ZWRfX4Xi+aIv9QqMa
 OBDP6o5NbcpEfv8Z/S1ZgongEGoW0XfuFhIiwiHGagSCWcog4/xek9C2HHtSobhyjLHDXvsxy/p
 zQNsTxdaHGeDzm/0/bCPqAVg1UyO2QSII0xf93x/HzT4yTTWP8RmwqTJ9AvJxMT7niCShlWbRFk
 9Zrkum1avd2+q7f4zvZ8iNDHQmaxl2M0tFvgJlVu8r+8iDmIsq+tmf8DgeWVmQIcwcux5sDHqVH
 T6IDhtr5Vv5Yc/xiomRO3dep7u264guM1cMyjMjbtfwONJ0XHMBNeSOhHV5JL52fMHt2/Ax1SpI
 UlpY3zXKX5NerevhWobFtAGCDYs/tVY5BvkUbzfStQwdoRBqpXAoxEpx0GcLksyMDUiSWZPMcqq
 wVBCqQasPnb2Uwy86mEYSgwEpaScr8nB0BcLOSa1/fGZBO4KqL3tEgRhL5RfrbDrTiwzXAatcjn
 n6JOgYwohCCvSRHd9xw==
X-Authority-Analysis: v=2.4 cv=MM71C8Zl c=1 sm=1 tr=0 ts=6b03c6e9 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=vfRFTl3raSCaEq12aQMA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDAxOSBTYWx0ZWRfX1UhNC1wsEgSB
 ZadC4F9OH1N1Uv81Q4GiQCkNty9wuo0lXwoq/KAwO/gZpn197lZktmFDmCpYMZtoT9zNNdQKPzD
 wRbEPpcUkTD1zzllFgBUQzbu7LGXbmU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-22_06,2026-11-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 phishscore=0 spamscore=0
 bulkscore=0 impostorscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230019
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

efi_capsule_update_firmware() passes the UpdateImageIndex from the
capsule to efi_fmp_find() and set_image(). This only works if the
platform's image_index values are fixed when the capsule is built.

Add a weak efi_capsule_resolve_image_index() that returns the index to
use, defaulting to the one in the capsule. A platform that discovers
its images at run time can override it to find the image by type GUID.
The lookup happens before efi_fmp_find().

Add a sandbox override and a signed capsule test whose image index
doesn't match any fw_images entry.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v3:
- Use an unused filename for the new test capsule, Test13 was already
  the signed FIT capsule

Changes in v2:
- Added newly in v2
---
 arch/sandbox/dts/sandbox_capsule.dtsi              | 15 ++++++++++++
 board/sandbox/sandbox.c                            | 13 +++++++++++
 doc/develop/uefi/uefi.rst                          |  5 ++++
 include/efi_loader.h                               | 14 +++++++++++
 lib/efi_loader/efi_capsule.c                       | 14 +++++++++--
 .../test_capsule_firmware_signed_raw.py            | 27 ++++++++++++++++++++++
 6 files changed, 86 insertions(+), 2 deletions(-)

diff --git a/arch/sandbox/dts/sandbox_capsule.dtsi b/arch/sandbox/dts/sandbox_capsule.dtsi
index 34d29916b30..af994373c27 100644
--- a/arch/sandbox/dts/sandbox_capsule.dtsi
+++ b/arch/sandbox/dts/sandbox_capsule.dtsi
@@ -104,6 +104,21 @@
 		};
 	};
 
+	capsule7a {
+		filename = "Test116";
+		efi-capsule {
+			image-index = <0x7>;
+			image-guid = SANDBOX_UBOOT_IMAGE_GUID;
+			private-key = CAPSULE_PRIV_KEY;
+			public-key-cert = CAPSULE_PUB_KEY;
+			monotonic-count = <0x1>;
+
+			text {
+				text = "u-boot:New";
+			};
+		};
+	};
+
 	capsule8 {
 		filename = "Test12";
 		efi-capsule {
diff --git a/board/sandbox/sandbox.c b/board/sandbox/sandbox.c
index 13006a0ffc2..8844f59e4c5 100644
--- a/board/sandbox/sandbox.c
+++ b/board/sandbox/sandbox.c
@@ -57,6 +57,19 @@ struct efi_capsule_update_info update_info = {
 	.images = fw_images,
 };
 
+u8 efi_capsule_resolve_image_index(const efi_guid_t *image_type,
+				   u8 capsule_index)
+{
+	int i;
+
+	for (i = 0; i < update_info.num_images; i++) {
+		if (!guidcmp(&update_info.images[i].image_type_id, image_type))
+			return update_info.images[i].image_index;
+	}
+
+	return capsule_index;
+}
+
 #endif /* EFI_HAVE_CAPSULE_SUPPORT */
 
 #if !CONFIG_IS_ENABLED(OF_PLATDATA)
diff --git a/doc/develop/uefi/uefi.rst b/doc/develop/uefi/uefi.rst
index 94ddf690440..0e1641122dd 100644
--- a/doc/develop/uefi/uefi.rst
+++ b/doc/develop/uefi/uefi.rst
@@ -503,6 +503,11 @@ on the FWU Multi Bank Update feature, please refer to
 When using the FMP for FIT images, the image index value needs to be
 set to 1.
 
+A platform that builds fw_images at run time can override
+efi_capsule_resolve_image_index() to map the capsule's image type GUID to
+the image_index of the matching fw_images entry. By default the
+UpdateImageIndex from the capsule is used as is.
+
 Finally, the capsule update can be initiated by rebooting the board.
 
 An example of setting the values in the struct efi_fw_image and
diff --git a/include/efi_loader.h b/include/efi_loader.h
index 7b865fe900a..1d3e2cf1348 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -1238,6 +1238,20 @@ efi_status_t efi_ecpt_register(void);
 efi_status_t efi_esrt_populate(void);
 efi_status_t efi_load_capsule_drivers(void);
 
+/**
+ * efi_capsule_resolve_image_index() - get the FMP image index for a capsule
+ * @image_type:		image type GUID from the capsule
+ * @capsule_index:	image index from the capsule
+ *
+ * The default returns @capsule_index. A platform whose image indices are
+ * not fixed at build time can override this to look the image up by
+ * @image_type.
+ *
+ * Return:		image index to pass to efi_fmp_find() and set_image()
+ */
+u8 efi_capsule_resolve_image_index(const efi_guid_t *image_type,
+				   u8 capsule_index);
+
 efi_status_t platform_get_eventlog(struct udevice *dev, u64 *addr, u32 *sz);
 
 efi_status_t efi_locate_handle_buffer_int(enum efi_locate_search_type search_type,
diff --git a/lib/efi_loader/efi_capsule.c b/lib/efi_loader/efi_capsule.c
index a77810fa15c..f5f4cab3613 100644
--- a/lib/efi_loader/efi_capsule.c
+++ b/lib/efi_loader/efi_capsule.c
@@ -517,6 +517,12 @@ static __maybe_unused efi_status_t fwu_post_update_process(bool fw_accept_os)
 	return ret;
 }
 
+u8 __weak efi_capsule_resolve_image_index(const efi_guid_t *image_type,
+					  u8 capsule_index)
+{
+	return capsule_index;
+}
+
 /**
  * efi_capsule_update_firmware - update firmware from capsule
  * @capsule_data:	Capsule
@@ -543,6 +549,7 @@ static efi_status_t efi_capsule_update_firmware(
 	int status;
 	uint update_index;
 	bool fw_accept_os;
+	u8 image_index;
 
 	if (IS_ENABLED(CONFIG_FWU_MULTI_BANK_UPDATE)) {
 		if (fwu_empty_capsule(capsule_data)) {
@@ -615,9 +622,12 @@ static efi_status_t efi_capsule_update_firmware(
 			goto out;
 		}
 
+		image_index = efi_capsule_resolve_image_index(&image->update_image_type_id,
+							      image->update_image_index);
+
 		/* find a device for update firmware */
 		fmp = efi_fmp_find(&image->update_image_type_id,
-				   image->update_image_index,
+				   image_index,
 				   image->update_hardware_instance,
 				   handles, no_handles);
 		if (!fmp) {
@@ -650,7 +660,7 @@ static efi_status_t efi_capsule_update_firmware(
 		}
 
 		abort_reason = NULL;
-		ret = EFI_CALL(fmp->set_image(fmp, image->update_image_index,
+		ret = EFI_CALL(fmp->set_image(fmp, image_index,
 					      image_binary,
 					      image_binary_size,
 					      vendor_code, NULL,
diff --git a/test/py/tests/test_efi_capsule/test_capsule_firmware_signed_raw.py b/test/py/tests/test_efi_capsule/test_capsule_firmware_signed_raw.py
index a500c499bb9..07a14105d01 100644
--- a/test/py/tests/test_efi_capsule/test_capsule_firmware_signed_raw.py
+++ b/test/py/tests/test_efi_capsule/test_capsule_firmware_signed_raw.py
@@ -190,3 +190,30 @@ class TestEfiCapsuleFirmwareSignedRaw():
             check_file_removed(ubman, disk_img, capsule_files)
 
             verify_content(ubman, '100000', 'u-boot:Old')
+
+    def test_efi_capsule_auth6(
+            self, u_boot_config, ubman, efi_capsule_data):
+        """Test Case 6 - Update U-Boot on SPI Flash, raw image format
+        0x100000-0x150000: U-Boot binary (but dummy)
+
+        The capsule image index does not match any fw_images entry.
+        The image is found by its GUID and the firmware is updated.
+        """
+        disk_img = efi_capsule_data
+        capsule_files = ['Test116']
+        with ubman.log.section('Test Case 6-a, before reboot'):
+            capsule_setup(ubman, disk_img, '0x0000000000000004')
+            init_content(ubman, '100000', 'u-boot.bin.old', 'Old')
+            place_capsule_file(ubman, capsule_files)
+
+        do_reboot_dtb_specified(u_boot_config, ubman, 'test_sig.dtb')
+
+        capsule_early = u_boot_config.buildconfig.get(
+            'config_efi_capsule_on_disk_early')
+        with ubman.log.section('Test Case 6-b, after reboot'):
+            if not capsule_early:
+                exec_manual_update(ubman, disk_img, capsule_files)
+
+            check_file_removed(ubman, disk_img, capsule_files)
+
+            verify_content(ubman, '100000', 'u-boot:New')

-- 
2.34.1

