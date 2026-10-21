Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443B6606A319
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 16:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=WJbVsAf9;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cIBUniEW;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BOZ98D2G
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1F61D6089D;
	Wed, 21 Oct 2026 16:05:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id f8CTXvT1Avng; Wed, 21 Oct 2026 16:05:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 48FC660852
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792598755;
	b=NHjSV47Kj3HTEIiBjg3/nTll+napDFWTj4vrtLeLzhIeODs8DKe/tR27OCXaVJjSz5l0
	 AzkUlpwJXyXJjWQeA0IW+JxURLezQkWoq1o93PwfOHCUtPQiskQ6xb2Nzd40RXlvC36Oz
	 dMLPRtES7oQKwEkK6vCD1QUwx9VjsYuNofoI2VUotfR9CkJS4Ii9O9JlJS7JGBXjCoSBi
	 TYUXu+u1+TGelzKHj/7l+fstTiXmEUgirwzNJ3WYugSM8y4uEGhjSFpN/8NaBiIceVJqf
	 ZcxBTAakc3Hwv8QbbSq51uyI3w8agrATOa4OOPkFD+sDHTHGBHlVw9o25yuHi30GwzA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792598755;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=jr1mgnojc4u9p7o1u01B5RjCpOIPUbFaxksw08HQdOE=;
	b=ikNQnjl7ptYR0qTorOYO463vCD3EO3tP8NH9jMXOBxOlzzAcfIatwDQ45H4jdfZu76e7
	 /7h8AdFAmv51aHfh8WfKjmZuECndXnPjc9oA5g+UyY8Z2zVBk62Pwh2jHAVJkTUfRGZaR
	 ljuA5ChlzuNwHTkmYjGcHU5YhH5KUSFqRdVjYHDegUDJIh7/FliT/j4TeFFOEK5RnJRKz
	 cMLx/WAE+g8f7Vj4YHhPJQdQJ1Y/icyQhLUHFtkxjb5RABpuaC6EE83SbyNAZFvQ2Vvs7
	 C9Ifi6mO0iSW8vbcRmmOuivJ1Jql+NqFREzP0pNxpgNccAk9OZ99mA9EQE80Lr9VvTg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792598755;
	bh=jr1mgnojc4u9p7o1u01B5RjCpOIPUbFaxksw08HQdOE=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WJbVsAf9TKISgpa/gk1cuFllpX1Qxorw/13qo+EsOqLtKcGiik0kDFMbmzjkG7pbd
	 h2A0ISZytzr7jf1TDD6wL8oZs93ht2OlxQ+WsHCvIkptPYKNTCdsFU34zNo9jROkNh
	 llTBvU8TL7x/3DdYZPph8Oi+2JUZnVXZL1vB8skhdW1+8yuyxN/DkCPN1gEPBIPSzl
	 vezimcTlzHnfv08DZi/66euEakkjdNyCLvPqeBIQc++wvn3wmFZRmADuwlZojxWfGB
	 PjwKtEFg4Wlpfhgq84x0/nnBk47tLRROEY17DXiPntmlyuG0iWn8fGvPRRjzg9aT7U
	 vSlZUKMNO3mIA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 48FC660852;
	Wed, 21 Oct 2026 16:05:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 78E30356
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:05:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5EECA40903
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:05:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nqkYFLe8D2Dw for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 16:05:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7B105408E1
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792598752;
 b=tPIgqOIfqoVakJ5ITR2SQWKtENayiUni6DIA70A6I7lCvD6cDDZMPGUh1EJPvCjmk5z9
 4QQI9neLrORTL3mvUcX1borA6O49Ig7UEz0l9ebaKqX0hCPYvs1VE4dfRBBfKSmeRCj5d
 InzhFm3wA6xmTPBhgLRcMkDdX1qHoNjxCftm2RIQLsl60ABhNhGUPSqq1EQlA3f8eIZAP
 1pa8Vl8uejVzCC+bbco3BD/qAZ+mDUI9k1aWy1QP70JGae+s/E08nfBMD9kA0Cmn0nkpn
 X2rWqBL66e3jMslyzMMbUmtL063PKYLuJ/wb2dfKuUfmI0cq7KEqacE8N+N0fgpV7iA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792598752;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=jr1mgnojc4u9p7o1u01B5RjCpOIPUbFaxksw08HQdOE=;
 b=huh1HC4DD7O46mUoscGTWsD8mJyPYoBNlFo65QTHr2ZMSXEnA28RXEm9/PvCxOeMbvKT
 KEtMul1W9+jeRyd4v1eJdBjoUOyCloXc0obfmTotuf9ECwI41GFHlv8wG1oG1g4uuoVwm
 uV5ODq7U4JRYSFAO3dVz1j3KfqNfWf1JJjEjK7Q5CTI/h/tM1YwWqFx3P6v9boWDhtZp7
 hAy9EjGMxIjdJQILqOBkmDAisXD+d2cQEtQnTypo4z3lxdDsVFhFlcmU0zzZ1u/IkEoZP
 Lo1CcZ1R1+ftq870kVBFz0VF707w5JcO4h+OQRKvqv6bx2vFKdVljIoK5TAP2fHwgOA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=cIBUniEW; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=BOZ98D2G; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=cIBUniEW; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=BOZ98D2G
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7B105408E1
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:05:50 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LFpF7c1037769
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:05:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=jr1mgnojc4u
 9p7o1u01B5RjCpOIPUbFaxksw08HQdOE=; b=cIBUniEWkIlyRYJaPrGMUeVemEG
 itqlqFugwtX1kXbrfX/fbDf9MwWkqsltaFTkbNu3N0zyU60NFJkFcfg9+I1Ny9zp
 y7u0m8HkKwTmaC1wU9/+glEtsJmkk3aiYLqt3yGUV0CG5RgFr3Y+V/yTwfkofTtS
 rjsILTIyypYA2KrI/oHw1eHE1fu6iRS9nVyLRHIVUiOmrfgZawFMpmF45DTIhZfa
 mCtPM4Ijke6er73UR1coqzu3cSglwHay+H1l48oFiG1+6Rk9LcGudBeXeA5Pupxr
 dyRbr+OnYixq9wtGxQdnJo8wgxw4AF60iYH2XbFN8lddq5iJuMNoehmvG+A==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4heh5r3x6y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:05:49 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-139b62317d0so2904063c88.0
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 09:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792598747; x=1793203547;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=jr1mgnojc4u9p7o1u01B5RjCpOIPUbFaxksw08HQdOE=;
 b=BOZ98D2GgMTxWlI/aae/MJzXbveoRAusLSf3Lz+7QSDjos2lnWpt7uMjdrThFXB8Qs
 iqqGlKk21M9psv7JR09SY/O+NLeaK8n7VjUNqcApfAVgx/UwQ8GtUF1Op0+l9U16DimQ
 ATaYSwlE6NOZiUdITPeb8mhpezmLCD8bKfEGkoVzgE0WVXgOvf9ufUrpmE1I8nEdQNWN
 FM8+T1XvctPHbfkfmQ25BuNqEjCj6OUvtTJ79KIpA2Ujto4yzN2deIemZzhJtWBZjVMp
 81j7iPL4ok4wqpspO1yLW6SM+lCdDzR5I/uASPBvF1KMxzVK4InXjWXaWfq9FFPxedhv
 MiVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792598747; x=1793203547;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=jr1mgnojc4u9p7o1u01B5RjCpOIPUbFaxksw08HQdOE=;
 b=YhRaQRmeS4c7TgStbRleYmx6FaFMZOID3ZqSPkafhN2eNtqpbJrisAQ1IyyK7lZwxq
 OmTv133YRObjlJFNFyWMAA7I3u07PsLLBGaJ/xjULaNccGodZvJDhiJRwg72KmUcgSih
 YlhLuxgdMD1+RLVTyE1N3x6fhWHwznly63pBG0Y8PDbqxor234hU3UwbS6azlT/KLgiI
 n/vfGi0b6YbTaqYHs/4zabDBzyLNDfUj1cE1X4sVZ6uQjZPZHGCyGv6ULMw5jtGTKLHN
 2sIS6XF92PJSR2u0ShDvJRyR00grpCefclm1tkZMEqKwVw8vcOrTtQMvKltutedet8f7
 W9Dg==
X-Forwarded-Encrypted: i=1;
 AKwUvBw3KpSUrs6w6YzRJ11jUYBa6EXwXBOobXH97paqShbCF2iKfZ3cTW6ZsGD9kRdczjsSYeLAX2A=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKbxlOEEOg6eHI2pcty10gh8UVB8ngJ2Y2F4JwQPXhJQsgQzEUg
 jzLofsSh2xubsBn6zSI7IDVkBiZW3SKiyJv99pggSd47WnWw+irZ1vVYeoMq6gxSd7yurxKZoQb
 qD1cPZzhF4xigD5XI4QJ6+1HbTIj7j6fxTt2CCNDtoRLsKj3TAj8P3JiO8zStOn/AGC/VOok=
X-Gm-Gg: AYBFou0gDIxABa1yzMFzj6XccR7VCRbwnHY1tQYz8jtIXubQ6+d6S1rGLKOAnWoCu7b
 Nv6wMND1fpbV5wfbt3QHUaEgj+UyB9OH0c7lVRK62gFexbxtgug0SiJQ/gZegM2+z6/Ep+w0hbj
 xr8izJL0gFYnmOcByeBo7djK//+jOBsCWha9LS+ZUOMBk6oVfyDgZT4MBxj4huJiJTMBH/r/ZeV
 JzzED24jn0CXua6rvaRmJMza6Sn8oh3CrFMkp6QO4jbaLWcD+8HPtO1Fy25Arsz5K7Zq5pQb2mG
 il5kVIxgQp7eM9y4GzR+0/y9onp+naB7r4qXZfvX7cZaXEf4vkmmnGIVPnIaypXX+60TXwNh+K4
 GtITJjV8GiRvjod5gU0MaENnfcYqJ3z1RpqkK+FMJJ10Bd3IHBYX7vfBGMTk3oMgdWrq3BHW5/K
 alz+XxP3JquiTZYXwLe8M=
X-Received: by 2002:a05:701b:260a:b0:154:e9d2:d741 with SMTP id
 a92af1059eb24-190a6adcb05mr2907695c88.8.1792598746703; 
 Wed, 21 Oct 2026 09:05:46 -0700 (PDT)
X-Received: by 2002:a05:701b:260a:b0:154:e9d2:d741 with SMTP id
 a92af1059eb24-190a6adcb05mr2907667c88.8.1792598746075; 
 Wed, 21 Oct 2026 09:05:46 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1903d3ae06fsm7480185c88.19.2026.10.21.09.05.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 09:05:45 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com, lukma@nabladev.com,
 marek.vasut+usb@mailbox.org, aswin.murugan@oss.qualcomm.com,
 Michael.Srba@seznam.cz, nathbappai@gmail.com, nikroks@mainlining.org,
 luca.weiss@fairphone.com, jbx6244@gmail.com, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v3 6/8] configs: qcom_defconfig: enable nord clock drivers
Date: Wed, 21 Oct 2026 21:34:46 +0530
Message-Id: <20261021160448.3893858-7-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261021160448.3893858-1-aswin.murugan@oss.qualcomm.com>
References: <20261021160448.3893858-1-aswin.murugan@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=aI5lOr9m c=1 sm=1 tr=0 ts=6ad8e2dd cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=ujKt_GTpXtF7ANkCTFUA:9 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-ORIG-GUID: XX8zcH1Or2OgPrBRFJGIhoUyvSde0i0W
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA2NCBTYWx0ZWRfX/k6FAq6z2U1p
 MjOJL724npLySUbA6hRpNTYISN/SdmUEDL7zxJCop9sTw+hue8+X19Jki5HVyErOVXKl4rn+Mti
 bbYyqhjAR2gcIMxXqspVAcftDMNacTQNuE8sCmrpIJWXttthtMl2ffM9E8Mg7p788tlDl3PvwzH
 ayBsA3hTXYbgxn2dXaODuKLtCr1QfJEUUJKuPYVMZ9tFpeY3XkpOAMqpi37wdYMIla406Ia2VW8
 ntnGHBdI9G5uen0t5TznyIczItgSic7HO+3pbGMpsBxQZUPKKvK7xO1GoIuT59cCmwkcVarK5v7
 KysBX9seWLxQiASCQw0ALnaAns3vL2RatkMOVhe5NGSMYi2wt5euwbciw77fYlhPQzGVlG1Nnpz
 K7Krf4T8mxGXzQb2HvtIv7PDyrNlfM+mRIgzqcUti1P3dd3U3PGKaQRfbz3dQT5M7gUXd94PbSN
 nlB8iVWw6PQElfwBqhw==
X-Proofpoint-GUID: XX8zcH1Or2OgPrBRFJGIhoUyvSde0i0W
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA2NCBTYWx0ZWRfXy1YZaS5XSCTU
 JgCwHvYgSI2vgUAe9nfKimt1VSbIxRHMXdjd+BtkE7vowwh5bgx2LCB7bdBf3C6l+6+b+L30htp
 t72iQkwbkaTow68fg3dDlESQcQKO6bY=
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Enable the GCC, NEGCC, SEGCC, NWGCC and TCSRCC clock controller
drivers in qcom_defconfig so support for the nord platform is built
as part of the shared Qualcomm target configuration.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 configs/qcom_defconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index 2655eaece1d..55d182a66b3 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -57,6 +57,11 @@ CONFIG_CLK_STUB=y
 CONFIG_CLK_QCOM_APQ8016=y
 CONFIG_CLK_QCOM_APQ8096=y
 CONFIG_CLK_QCOM_MILOS=y
+CONFIG_CLK_QCOM_NORD=y
+CONFIG_CLK_QCOM_NORD_NEGCC=y
+CONFIG_CLK_QCOM_NORD_SEGCC=y
+CONFIG_CLK_QCOM_NORD_NWGCC=y
+CONFIG_CLK_QCOM_NORD_TCSRCC=y
 CONFIG_CLK_QCOM_QCM2290=y
 CONFIG_CLK_QCOM_QCS404=y
 CONFIG_CLK_QCOM_QCS615=y
-- 
2.34.1

