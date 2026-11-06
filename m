Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E88606A32C
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 09:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=z/hgVSi2;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=QTzKZk4t;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=IMrA+Fci
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CAABF408E0;
	Fri,  6 Nov 2026 09:43:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3XDZllhcrEQ6; Fri,  6 Nov 2026 09:43:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org F411C408E8
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793958182;
	b=WgMBnX4X+R6OFM3wi1/zqK0ezDmF28N5iRhidgq5u2d/m+TbEE7eJ4sMdLGr8CurRDZg
	 nnqc1b0ZYtZkr49G4SaWPMb5WCZpd/UrCJLPwBEN5WNF/z+JQ50pO2TyCjh4Z1rQpr+4a
	 TwCSAn+VMxrQ8qkvApMr674UwLrvLUNxl8vDW05d1D4PivQ6iGR1cPKv9p+95kc4MAm0k
	 PW8ZZ/pKTSQ2N45ahYGm0ZkCykICPF2RMcm1zz8TKffxIeGdZTbli+R1vz91zwVRLUJyH
	 5SiYgmip+Qg1SJbk7ASnBbgc1XiNwnkVOE2fSPauNucH01Tc4OJMUXe7qEvSwS4zcRw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793958182;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=T/Oxd33iEHyVswOB4Al8h+kNfPgsYxypIxFw0iBWYSo=;
	b=H6a3cPSqUWty6rfAjqwMMAxvtT8EX3B1uF6ey2Qw7UlioWaWGh77DpQ5B60HQAdAS415
	 5gfszyUBqgGyyD6Pl3Q4bmEcm+xGpKHwj0iN+uqL8cMw2e3354Z+PSEBn2MQOu6Py3Pd5
	 zdpT04g4Al2ur2KJHbLe9NactwPfoVcAVGQtodbMuFwSV5GsGg5qSdhm5gA5gnSnSAL1w
	 F5MRQYwW6QO8Z4biu0+edAGrtP/rWCX3ZlCuALim01mmkebP6OVYAuf4A72hV1lZfFegr
	 nnTWwvNyUAHxsOfiulpUFx9BLXgCrPvDhHWVM8eMBfv6WWocwH3S7TdC9iaFbsosJpg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793958182;
	bh=T/Oxd33iEHyVswOB4Al8h+kNfPgsYxypIxFw0iBWYSo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=z/hgVSi2RXGXtlkqustkunaKIqnPuJUDNohsaPSk/HhcosuDn/6In9lZ0F6ItH3u+
	 CacIdtE9WkZI6CpaHI3+JKnVmlKvnyKqlsB3oHD0QWKHjtJcNEIMrrUI3+E1xAWXCI
	 ILpdY4cWPhk5bkxpUM0Z9f8tS1DpWVd483Cz8mIq6LDl6lbnZLDILzWFPM3O2kuPuj
	 9B1obcLUNNLJC2nK/PVrVm7wT/7PP4YMUOOxRbUSh7oDVuEnFn73Fn4F9L2HJV1GAi
	 ZZK9a7yMJe4S7t8heCnQsJTl9eVjEahkd1Rkt2fBVyIJKyCLrbkPMSeZiYg51sxNtt
	 xRsaotR3S5X9g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id F411C408E8;
	Fri,  6 Nov 2026 09:43:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id E69C731F
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 09:43:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CCA7D403A6
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 09:43:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4nNZIsusTQCL for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 09:42:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 2FEA7400D5
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=QTzKZk4t; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=IMrA+Fci
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2FEA7400D5
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 09:42:58 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A67R9rN2333816
 for <u-boot@lists.u-boot-project.org>; Fri, 6 Nov 2026 09:42:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 T/Oxd33iEHyVswOB4Al8h+kNfPgsYxypIxFw0iBWYSo=; b=QTzKZk4tZcv5CDBP
 wARQF22Gnuj5HCgXa2waFbHcdpQV8lR4iD2Y1pExrXsgOpg0MD6u5q+qZ6if7crc
 1FL5A9RxvdFjqhyykNnEcLNr5TDcnll8kuGdfGKix3E6P6aMdt4I3o69T6kqhwrF
 Do83fqEkPHj1fiMQmQu1YFtwtcS+RP2Yvwf0s7LWCHvKbJjMiJiQj4+gjeVEaArS
 Tgtfg9sfgr4y3tXchMekjsXdKyEsVws3puYdvlfQpMvj6uOkeBEOKEhAtJo4tMsE
 oKkljie3Eh8UNlPXURet5waFYRptXM90Wqd5smn5ZxfGIHBVg80BaUK9bvLpE1DG
 9G/RgA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hs3p9a8fr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 09:42:58 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93ce7a85f04so97400185a.0
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 01:42:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793958177; x=1794562977;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=T/Oxd33iEHyVswOB4Al8h+kNfPgsYxypIxFw0iBWYSo=;
 b=IMrA+FciLu8VR0lisSkb6NqpWaAMwdkbQhaflLKALE4Qg4zSJAJ0c78whTcj+pm+i7
 VX9FItWQgZx3Xg+kMI/yNAb/jShfcD1zivqQSjhr2tcL/mGDKbimVeOmUWrBeZ8qkBHy
 hKAZIjezCrY1jyszb2179qO6Zbg/ogChLwGT927VDNz2O/NEjXigmvNlBBpxx1UQ5kKz
 XZj9+KloADImxKGG+UMcWr1kya4bXPbY0Sjs3AdUw10Fo/Cshvj/a1Ig9zyHFRBh1MPG
 HpHqSpSjUcO+d3JL922rKV/z/BJOWFL60np6tApbv5NBeMkUv7WNuqEuakypQLZLoLmH
 iz5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793958177; x=1794562977;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=T/Oxd33iEHyVswOB4Al8h+kNfPgsYxypIxFw0iBWYSo=;
 b=JwgFLMq+e4PRf5K/9e2yp7J7+pP3UIf0cXAflTduAsKLiwEjhbMgw/yKNceeojam74
 sqfHt+qsYSzP32G6skD7F1ZZOWCYzOYAH3X3qnpv6n60C4mhN2yPxu6um8XLiWtrNp5V
 rDKChUkTBXH0K5MWfFtJJk/JvWSw2+R/H1pvGEMSu0b5l7I326mOngd5UcNghNhXHfX3
 O13SQAxsDqB1OTpTSvpS/AcTdZiGTcvn19FeKzDHMtLOIOEi/DYjiYid/rap/uuOsFxS
 S62IJfPhz5iN7atN2WhN4Vf1MdFYqHGdyqedxx9ZIYvENp4Aa2Zk1DGdtdZ1SiphEqvR
 IinA==
X-Gm-Message-State: APuU4Z/fSn9GY03UyWztbEpep+Eu6kOYMTL0+6MdyE4zrk74fRaUOf7R
 lcJQOzoJH+druAjN/VoqjCb8FOY0huYJkiMHBUlq6foMbF+s4nE4mEEJquO3LVuti3vxSkS95B8
 X6nYxNBH4nzToMulsOIPqq6CZaAlY7PMNoucAWzbzU8gkXJxGyVCXImMlpLWIGzJ2m3d/9IE=
X-Gm-Gg: AYBFou3RTOY3rnz7Tyjl6w4EP9376dGCKsi7bMpO2x+wvGKL7Um++M3wTCTOSRZo306
 52VKT7sxmBw6PXlAchgJ9HzRAR/xwk7pOG338RdevvDZ/gY0SIAFitEmXYdcc+RNunk70CyuIjk
 oEaGl/qhkWtdcJrIQd9WPvudZ1iEi62/NEQuhWH01R7JjPSYNWabIL3s51AvVYnJhHLPPp3jWfU
 lGtUSt2CVMzsrzL40b37+vsHr3XV1rBt7wmpg75OPcuUI2vSBUywegPYpWhl34Rf5gXyFgaQ+pA
 sAZ2SML1jT2H7yiWeXGDfqW83s3UNiadpNpvRVqFscVXVGGqrigyOcRmwCJ2KNTR4CetNIE6DP6
 VEotSFqTWroSWQ6fCgLQBrDATQLUG6/QoDwVCQSlUYyJMEDnfcJQOlUgi9aM4eN5a+k+LAGJEvE
 8KK+JAqhuO0Wm9
X-Received: by 2002:a05:620a:7004:b0:93f:3a43:2771 with SMTP id
 af79cd13be357-945f3648383mr275479885a.78.1793958176739; 
 Fri, 06 Nov 2026 01:42:56 -0800 (PST)
X-Received: by 2002:a05:620a:7004:b0:93f:3a43:2771 with SMTP id
 af79cd13be357-945f3648383mr275477985a.78.1793958176213; 
 Fri, 06 Nov 2026 01:42:56 -0800 (PST)
Received: from [127.0.1.1] (93-159-22-70.cgnat.inetia.pl. [93.159.22.70])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4d3562ec2csm64822366b.14.2026.11.06.01.42.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 01:42:55 -0800 (PST)
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Fri, 06 Nov 2026 10:42:33 +0100
Subject: [PATCH 01/14] usb: gadget: add a Qualcomm Firehose function
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-firehose-v1-v1-1-e7591c12fc65@oss.qualcomm.com>
References: <20261106-firehose-v1-v1-0-e7591c12fc65@oss.qualcomm.com>
In-Reply-To: <20261106-firehose-v1-v1-0-e7591c12fc65@oss.qualcomm.com>
To: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@nabladev.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Marek Vasut <marek.vasut+usb@mailbox.org>,
 Johan Jonker <jbx6244@gmail.com>,
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>,
 Vitor Sato Eschholz <vsatoes@baylibre.com>,
 Carlo Caione <ccaione@baylibre.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Simon Glass <sjg@chromium.org>,
 Mehmet Fide <mehmet.fide@screeningeagle.com>,
 Vincent Jardin <vjardin@free.fr>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Michael Srba <Michael.Srba@seznam.cz>,
 Biswapriyo Nath <nathbappai@gmail.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Rasmus Villemoes <rv@rasmusvillemoes.dk>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: 5HF9uJGP8P3Rs3MEjG6YJJdw-nWMQdPz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDAzOCBTYWx0ZWRfXzrFnFVqTbWrr
 yjZ+lzOWKX4UnolGtJ31SEgVLJmXjoyqMicEZd+/A238OuDCUJ64mixzKRWRrS49RUKsOxfqJye
 1lI+1aD+sBF4mD+WkseBhzlCJjdvWcMH9lndbI+TmZu9VU85P/4TS+SRy/HLMqJF8zAUA5wJuJN
 e3I7hjRYWsfmVzZ8BQ7xapR3B8EUPQIECYaTHksolGaJVPWmbbqJHe8VGlckZf78WL6pdNylXs1
 2JRAwKCRJF9sP5auTYoXOM7rgdGgudwxRSbnBnILyXZT3e9M0J2L2eRaZ0sFvAogjhJv6G/y/t2
 5mw6KO5x+4TqE58wFb21QQfYOnPVM3WR5dTEU4QIdMUFLDIKgC/bc89a2zaaR9AKsFRX5r4mt68
 5WUGv0aPmTJDCERs0xFcAEViPb6h4CIla+E9NRzmcphIVyI5/gDB3hlID4G1xTcRF0KZi88lyKM
 KhscyZkWXjZL+8N11dg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDAzOCBTYWx0ZWRfX9N33KIjmjS5b
 RxYblYs45uInzoJRUAHct0LJlGD/mA3+BEvgwr6pX8xQN05jpNwRcUDYDP0J6U01r5Z4iKHsNbK
 SA+Yg2aoWVeRcTxzCp4ZcXh+kCmsX9s=
X-Authority-Analysis: v=2.4 cv=WMzqzXsR c=1 sm=1 tr=0 ts=6aeda122 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=ySe+0nHqNG5yihRO1pIWsw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=6TUCzGt79ZC0Du4lHtcA:9 a=QEXdDO2ut3YA:10
 a=O8hF6Hzn-FEA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: 5HF9uJGP8P3Rs3MEjG6YJJdw-nWMQdPz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_02,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060038
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-23.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add a USB function speaking Qualcomm's Firehose flashing protocol, as
used by qdl [1] in EDL mode: one XML command per bulk transfer, answered
with <log/> and <response/> documents.

The XML parser accepts only the subset Firehose uses. This introduces
only support for configure, power (reset) and nop cmd.

[1] https://github.com/linux-msm/qdl

Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
---
 drivers/usb/gadget/Kconfig          |   9 +
 drivers/usb/gadget/Makefile         |   1 +
 drivers/usb/gadget/f_firehose.c     | 611 ++++++++++++++++++++++++++++++++++++
 drivers/usb/gadget/firehose_parse.c | 110 +++++++
 include/firehose.h                  |  67 ++++
 5 files changed, 798 insertions(+)

diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
index e42d5a43696..2e515f7d30e 100644
--- a/drivers/usb/gadget/Kconfig
+++ b/drivers/usb/gadget/Kconfig
@@ -198,6 +198,15 @@ config USB_FUNCTION_MASS_STORAGE
 	  Enable mass storage protocol support in U-Boot. It allows exporting
 	  the eMMC/SD card content to HOST PC so it can be mounted.
 
+config USB_FUNCTION_FIREHOSE
+	bool "Enable USB Qualcomm Firehose gadget"
+	depends on BLK
+	help
+	  Enable a server for Qualcomm's Firehose flashing protocol, so that
+	  host tools such as qdl can program a block device with the
+	  rawprogram/patch XML files used for flashing over Emergency
+	  Download (EDL) mode. The board picks the USB IDs.
+
 config USB_FUNCTION_ROCKUSB
 	bool "Enable USB rockusb gadget"
 	depends on ARCH_ROCKCHIP
diff --git a/drivers/usb/gadget/Makefile b/drivers/usb/gadget/Makefile
index 9dd3abe2a5c..ec64971e9f5 100644
--- a/drivers/usb/gadget/Makefile
+++ b/drivers/usb/gadget/Makefile
@@ -28,6 +28,7 @@ obj-$(CONFIG_DFU_OVER_USB) += f_dfu.o
 obj-$(CONFIG_USB_FUNCTION_MASS_STORAGE) += f_mass_storage.o
 obj-$(CONFIG_USB_FUNCTION_SDP) += f_sdp.o
 obj-$(CONFIG_USB_FUNCTION_ROCKUSB) += f_rockusb.o
+obj-$(CONFIG_USB_FUNCTION_FIREHOSE) += f_firehose.o firehose_parse.o
 obj-$(CONFIG_USB_FUNCTION_ACM)	+= f_acm.o
 endif
 endif
diff --git a/drivers/usb/gadget/f_firehose.c b/drivers/usb/gadget/f_firehose.c
new file mode 100644
index 00000000000..460216a2bf8
--- /dev/null
+++ b/drivers/usb/gadget/f_firehose.c
@@ -0,0 +1,611 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Qualcomm Firehose flash programmer protocol over USB, as spoken by
+ * qdl (https://github.com/linux-msm/qdl)
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include <blk.h>
+#include <command.h>
+#include <console.h>
+#include <env.h>
+#include <firehose.h>
+#include <g_dnl.h>
+#include <log.h>
+#include <malloc.h>
+#include <memalign.h>
+#include <dm/device.h>
+#include <linux/sizes.h>
+#include <linux/usb/ch9.h>
+#include <linux/usb/composite.h>
+#include <linux/usb/gadget.h>
+
+#define FH_XML_SIZE		4096
+/* Raw data transfer size, what qdl uses by default */
+#define FH_PAYLOAD		SZ_1M
+
+#define FH_XML_HEADER		"<?xml version=\"1.0\" encoding=\"UTF-8\" ?>\n<data>\n"
+#define FH_XML_FOOTER		"\n</data>"
+
+/* The handler has sent its final response itself */
+#define FH_RESPONDED		1
+
+struct f_firehose {
+	struct usb_function func;
+	struct usb_ep *in_ep, *out_ep;
+	struct usb_request *in_req, *out_req;
+	unsigned int maxpacket;
+	bool online;
+	bool in_busy;
+	bool out_busy;
+	int xfer_err;
+	bool reset;
+
+	struct udevice *udc;
+	struct blk_desc *desc;
+	void *buf;
+	char rx_xml[FH_XML_SIZE + 1] __aligned(ARCH_DMA_MINALIGN);
+	char tx_xml[FH_XML_SIZE] __aligned(ARCH_DMA_MINALIGN);
+};
+
+static struct f_firehose *firehose_func;
+
+static inline struct f_firehose *func_to_firehose(struct usb_function *f)
+{
+	return container_of(f, struct f_firehose, func);
+}
+
+static struct usb_endpoint_descriptor fs_ep_in = {
+	.bLength		= USB_DT_ENDPOINT_SIZE,
+	.bDescriptorType	= USB_DT_ENDPOINT,
+	.bEndpointAddress	= USB_DIR_IN,
+	.bmAttributes		= USB_ENDPOINT_XFER_BULK,
+	.wMaxPacketSize		= cpu_to_le16(64),
+};
+
+static struct usb_endpoint_descriptor fs_ep_out = {
+	.bLength		= USB_DT_ENDPOINT_SIZE,
+	.bDescriptorType	= USB_DT_ENDPOINT,
+	.bEndpointAddress	= USB_DIR_OUT,
+	.bmAttributes		= USB_ENDPOINT_XFER_BULK,
+	.wMaxPacketSize		= cpu_to_le16(64),
+};
+
+static struct usb_endpoint_descriptor hs_ep_in = {
+	.bLength		= USB_DT_ENDPOINT_SIZE,
+	.bDescriptorType	= USB_DT_ENDPOINT,
+	.bEndpointAddress	= USB_DIR_IN,
+	.bmAttributes		= USB_ENDPOINT_XFER_BULK,
+	.wMaxPacketSize		= cpu_to_le16(512),
+};
+
+static struct usb_endpoint_descriptor hs_ep_out = {
+	.bLength		= USB_DT_ENDPOINT_SIZE,
+	.bDescriptorType	= USB_DT_ENDPOINT,
+	.bEndpointAddress	= USB_DIR_OUT,
+	.bmAttributes		= USB_ENDPOINT_XFER_BULK,
+	.wMaxPacketSize		= cpu_to_le16(512),
+};
+
+static struct usb_endpoint_descriptor ss_ep_in = {
+	.bLength		= USB_DT_ENDPOINT_SIZE,
+	.bDescriptorType	= USB_DT_ENDPOINT,
+	.bEndpointAddress	= USB_DIR_IN,
+	.bmAttributes		= USB_ENDPOINT_XFER_BULK,
+	.wMaxPacketSize		= cpu_to_le16(1024),
+};
+
+static struct usb_endpoint_descriptor ss_ep_out = {
+	.bLength		= USB_DT_ENDPOINT_SIZE,
+	.bDescriptorType	= USB_DT_ENDPOINT,
+	.bEndpointAddress	= USB_DIR_OUT,
+	.bmAttributes		= USB_ENDPOINT_XFER_BULK,
+	.wMaxPacketSize		= cpu_to_le16(1024),
+};
+
+static struct usb_ss_ep_comp_descriptor ss_ep_comp = {
+	.bLength		= sizeof(ss_ep_comp),
+	.bDescriptorType	= USB_DT_SS_ENDPOINT_COMP,
+};
+
+static struct usb_interface_descriptor interface_desc = {
+	.bLength		= USB_DT_INTERFACE_SIZE,
+	.bDescriptorType	= USB_DT_INTERFACE,
+	.bNumEndpoints		= 2,
+	.bInterfaceClass	= USB_CLASS_VENDOR_SPEC,
+	.bInterfaceSubClass	= 0xff,
+	.bInterfaceProtocol	= 0xff,
+};
+
+static struct usb_descriptor_header *fh_fs_function[] = {
+	(struct usb_descriptor_header *)&interface_desc,
+	(struct usb_descriptor_header *)&fs_ep_in,
+	(struct usb_descriptor_header *)&fs_ep_out,
+	NULL,
+};
+
+static struct usb_descriptor_header *fh_hs_function[] = {
+	(struct usb_descriptor_header *)&interface_desc,
+	(struct usb_descriptor_header *)&hs_ep_in,
+	(struct usb_descriptor_header *)&hs_ep_out,
+	NULL,
+};
+
+static struct usb_descriptor_header *fh_ss_function[] = {
+	(struct usb_descriptor_header *)&interface_desc,
+	(struct usb_descriptor_header *)&ss_ep_in,
+	(struct usb_descriptor_header *)&ss_ep_comp,
+	(struct usb_descriptor_header *)&ss_ep_out,
+	(struct usb_descriptor_header *)&ss_ep_comp,
+	NULL,
+};
+
+static struct usb_string fh_string_defs[] = {
+	[0].s = "Firehose",
+	{ }
+};
+
+static struct usb_gadget_strings stringtab_fh = {
+	.language	= 0x0409,	/* en-us */
+	.strings	= fh_string_defs,
+};
+
+static struct usb_gadget_strings *fh_strings[] = {
+	&stringtab_fh,
+	NULL,
+};
+
+static struct usb_endpoint_descriptor *
+fh_ep_desc(struct usb_gadget *g, struct usb_endpoint_descriptor *fs,
+	   struct usb_endpoint_descriptor *hs,
+	   struct usb_endpoint_descriptor *ss)
+{
+	if (gadget_is_superspeed(g) && g->speed >= USB_SPEED_SUPER)
+		return ss;
+	if (gadget_is_dualspeed(g) && g->speed == USB_SPEED_HIGH)
+		return hs;
+	return fs;
+}
+
+static void fh_in_complete(struct usb_ep *ep, struct usb_request *req)
+{
+	struct f_firehose *fh = req->context;
+
+	fh->in_busy = false;
+}
+
+static void fh_out_complete(struct usb_ep *ep, struct usb_request *req)
+{
+	struct f_firehose *fh = req->context;
+
+	fh->out_busy = false;
+}
+
+static int fh_bind(struct usb_configuration *c, struct usb_function *f)
+{
+	struct usb_gadget *gadget = c->cdev->gadget;
+	struct f_firehose *fh = func_to_firehose(f);
+	const char *s;
+	int id;
+
+	id = usb_interface_id(c, f);
+	if (id < 0)
+		return id;
+	interface_desc.bInterfaceNumber = id;
+
+	id = usb_string_id(c->cdev);
+	if (id < 0)
+		return id;
+	fh_string_defs[0].id = id;
+	interface_desc.iInterface = id;
+
+	fh->in_ep = usb_ep_autoconfig(gadget, &fs_ep_in);
+	if (!fh->in_ep)
+		return -ENODEV;
+	fh->in_ep->driver_data = c->cdev;
+
+	fh->out_ep = usb_ep_autoconfig(gadget, &fs_ep_out);
+	if (!fh->out_ep)
+		return -ENODEV;
+	fh->out_ep->driver_data = c->cdev;
+
+	f->descriptors = fh_fs_function;
+
+	if (gadget_is_dualspeed(gadget)) {
+		hs_ep_in.bEndpointAddress = fs_ep_in.bEndpointAddress;
+		hs_ep_out.bEndpointAddress = fs_ep_out.bEndpointAddress;
+		f->hs_descriptors = fh_hs_function;
+	}
+
+	if (gadget_is_superspeed(gadget)) {
+		ss_ep_in.bEndpointAddress = fs_ep_in.bEndpointAddress;
+		ss_ep_out.bEndpointAddress = fs_ep_out.bEndpointAddress;
+		f->ss_descriptors = fh_ss_function;
+	}
+
+	fh->in_req = usb_ep_alloc_request(fh->in_ep, 0);
+	fh->out_req = usb_ep_alloc_request(fh->out_ep, 0);
+	if (!fh->in_req || !fh->out_req)
+		return -ENOMEM;
+	fh->in_req->complete = fh_in_complete;
+	fh->in_req->context = fh;
+	fh->out_req->complete = fh_out_complete;
+	fh->out_req->context = fh;
+
+	s = env_get("serial#");
+	if (s)
+		g_dnl_set_serialnumber((char *)s);
+
+	return 0;
+}
+
+static void fh_unbind(struct usb_configuration *c, struct usb_function *f)
+{
+	struct f_firehose *fh = func_to_firehose(f);
+
+	if (fh->in_req)
+		usb_ep_free_request(fh->in_ep, fh->in_req);
+	if (fh->out_req)
+		usb_ep_free_request(fh->out_ep, fh->out_req);
+	fh->in_req = NULL;
+	fh->out_req = NULL;
+}
+
+static void fh_disable(struct usb_function *f)
+{
+	struct f_firehose *fh = func_to_firehose(f);
+
+	fh->online = false;
+	usb_ep_disable(fh->out_ep);
+	usb_ep_disable(fh->in_ep);
+}
+
+static int fh_set_alt(struct usb_function *f, unsigned int interface,
+		      unsigned int alt)
+{
+	struct usb_gadget *gadget = f->config->cdev->gadget;
+	struct f_firehose *fh = func_to_firehose(f);
+	const struct usb_endpoint_descriptor *d;
+	int ret;
+
+	if (fh->online)
+		fh_disable(f);
+
+	d = fh_ep_desc(gadget, &fs_ep_out, &hs_ep_out, &ss_ep_out);
+	ret = usb_ep_enable(fh->out_ep, d);
+	if (ret)
+		return ret;
+
+	d = fh_ep_desc(gadget, &fs_ep_in, &hs_ep_in, &ss_ep_in);
+	ret = usb_ep_enable(fh->in_ep, d);
+	if (ret) {
+		usb_ep_disable(fh->out_ep);
+		return ret;
+	}
+
+	fh->maxpacket = usb_endpoint_maxp(d);
+	fh->in_busy = false;
+	fh->out_busy = false;
+	fh->online = true;
+
+	return 0;
+}
+
+static int fh_add(struct usb_configuration *c)
+{
+	struct f_firehose *fh = firehose_func;
+
+	memset(&fh->func, 0, sizeof(fh->func));
+	fh->func.name = "f_firehose";
+	fh->func.bind = fh_bind;
+	fh->func.unbind = fh_unbind;
+	fh->func.set_alt = fh_set_alt;
+	fh->func.disable = fh_disable;
+	fh->func.strings = fh_strings;
+
+	return usb_add_function(c, &fh->func);
+}
+
+DECLARE_GADGET_BIND_CALLBACK(usb_dnl_firehose, fh_add);
+
+static int fh_wait(struct f_firehose *fh, bool *busy, struct usb_request *req)
+{
+	int ret;
+
+	while (*busy) {
+		if (ctrlc()) {
+			fh->xfer_err = -EINTR;
+			return -EINTR;
+		}
+		if (!fh->online) {
+			fh->xfer_err = -ESHUTDOWN;
+			return -ESHUTDOWN;
+		}
+		dm_usb_gadget_handle_interrupts(fh->udc);
+	}
+
+	/* Report a failed request only once */
+	ret = req->status;
+	req->status = 0;
+	if (ret)
+		fh->xfer_err = ret;
+
+	return ret;
+}
+
+static int fh_tx_flush(struct f_firehose *fh)
+{
+	return fh_wait(fh, &fh->in_busy, fh->in_req);
+}
+
+static int fh_tx_queue(struct f_firehose *fh, void *buf, size_t len)
+{
+	int ret;
+
+	ret = fh_tx_flush(fh);
+	if (ret)
+		return ret;
+
+	fh->in_req->buf = buf;
+	fh->in_req->length = len;
+	fh->in_busy = true;
+	ret = usb_ep_queue(fh->in_ep, fh->in_req, 0);
+	if (ret) {
+		fh->in_busy = false;
+		fh->xfer_err = ret;
+	}
+
+	return ret;
+}
+
+/*
+ * The host follows every write that is a multiple of maxpacket with a ZLP,
+ * which can complete the next request on its own: requeue it.
+ *
+ * Return: number of bytes received or negative error code
+ */
+static int fh_rx(struct f_firehose *fh, void *buf, size_t len)
+{
+	int ret;
+
+	fh->out_req->buf = buf;
+	fh->out_req->length = roundup(len, fh->maxpacket);
+	do {
+		fh->out_busy = true;
+		ret = usb_ep_queue(fh->out_ep, fh->out_req, 0);
+		if (ret) {
+			fh->out_busy = false;
+			fh->xfer_err = ret;
+			return ret;
+		}
+		ret = fh_wait(fh, &fh->out_busy, fh->out_req);
+		if (ret)
+			return ret;
+	} while (!fh->out_req->actual);
+
+	return fh->out_req->actual;
+}
+
+static int __printf(2, 3) fh_send_xml(struct f_firehose *fh,
+				      const char *fmt, ...)
+{
+	size_t hlen = strlen(FH_XML_HEADER);
+	size_t flen = strlen(FH_XML_FOOTER);
+	char *p = fh->tx_xml;
+	va_list args;
+	size_t len;
+	int ret;
+
+	ret = fh_tx_flush(fh);
+	if (ret)
+		return ret;
+
+	memcpy(p, FH_XML_HEADER, hlen);
+	va_start(args, fmt);
+	len = vscnprintf(p + hlen, FH_XML_SIZE - hlen - flen - 1, fmt, args);
+	va_end(args);
+	memcpy(p + hlen + len, FH_XML_FOOTER, flen);
+	len += hlen + flen;
+
+	/* Avoid a ZLP, the host would merge this with the next document */
+	if (!(len % fh->maxpacket))
+		p[len++] = '\n';
+
+	return fh_tx_queue(fh, p, len);
+}
+
+static int fh_respond(struct f_firehose *fh, bool ack, bool rawmode)
+{
+	return fh_send_xml(fh, "<response value=\"%s\" rawmode=\"%s\" />",
+			   ack ? "ACK" : "NAK", rawmode ? "true" : "false");
+}
+
+/* Messages are fixed strings and numbers, no XML escaping needed */
+static int __printf(3, 4) fh_log(struct f_firehose *fh, bool err,
+				 const char *fmt, ...)
+{
+	char msg[256];
+	va_list args;
+
+	va_start(args, fmt);
+	vscnprintf(msg, sizeof(msg), fmt, args);
+	va_end(args);
+
+	if (err)
+		log_err("firehose: %s\n", msg);
+
+	return fh_send_xml(fh, "<log value=\"%s%s\" />", err ? "ERROR: " : "",
+			   msg);
+}
+
+static int fh_configure(struct f_firehose *fh, struct firehose_cmd *cmd)
+{
+	const char *memory = firehose_attr(cmd, "MemoryName");
+	const char *name;
+	int ret;
+
+	switch (fh->desc->uclass_id) {
+	case UCLASS_MMC:
+		name = "eMMC";
+		break;
+	case UCLASS_SCSI:
+		name = "UFS";
+		break;
+	case UCLASS_NVME:
+		name = "NVMe";
+		break;
+	default:
+		name = blk_get_uclass_name(fh->desc->uclass_id);
+		break;
+	}
+
+	/* qdl gives up on a NAK without the payload attributes */
+	if (memory && strcasecmp(memory, name)) {
+		fh_log(fh, true, "MemoryName does not match the device (%s)",
+		       name);
+		return -EINVAL;
+	}
+
+	/* A host that asked for another size adopts the supported one */
+	ret = fh_send_xml(fh,
+			  "<response value=\"ACK\" MinVersionSupported=\"1\" "
+			  "Version=\"1\" MemoryName=\"%s\" TargetName=\"U-Boot\" "
+			  "MaxPayloadSizeToTargetInBytes=\"%u\" "
+			  "MaxPayloadSizeToTargetInBytesSupported=\"%u\" "
+			  "MaxPayloadSizeFromTargetInBytes=\"%u\" "
+			  "MaxXMLSizeInBytes=\"%u\" />",
+			  name, FH_PAYLOAD, FH_PAYLOAD, FH_PAYLOAD, FH_XML_SIZE);
+
+	return ret ?: FH_RESPONDED;
+}
+
+static int fh_power(struct f_firehose *fh, struct firehose_cmd *cmd)
+{
+	const char *value = firehose_attr(cmd, "value");
+
+	if (!value || strcasecmp(value, "reset")) {
+		fh_log(fh, true, "only power reset is supported");
+		return -EINVAL;
+	}
+
+	fh->reset = true;
+
+	return 0;
+}
+
+static int fh_nop(struct f_firehose *fh, struct firehose_cmd *cmd)
+{
+	return 0;
+}
+
+static const struct {
+	const char *tag;
+	int (*handle)(struct f_firehose *fh, struct firehose_cmd *cmd);
+} fh_handlers[] = {
+	{ "configure", fh_configure },
+	{ "power", fh_power },
+	{ "nop", fh_nop },
+};
+
+static int fh_handle(struct f_firehose *fh, char *xml)
+{
+	struct firehose_cmd cmd;
+	int i, ret;
+
+	/* Also qdl's Sahara probe: the reply tells it to skip Sahara */
+	if (firehose_parse(xml, &cmd)) {
+		fh_log(fh, false, "ERROR: malformed XML command");
+		return fh_respond(fh, false, false);
+	}
+
+	for (i = 0; i < ARRAY_SIZE(fh_handlers); i++)
+		if (!strcasecmp(cmd.tag, fh_handlers[i].tag))
+			break;
+
+	if (i == ARRAY_SIZE(fh_handlers)) {
+		fh_log(fh, true, "unsupported command %s", cmd.tag);
+		return fh_respond(fh, false, false);
+	}
+
+	ret = fh_handlers[i].handle(fh, &cmd);
+	if (fh->xfer_err)
+		return fh->xfer_err;
+	if (ret == FH_RESPONDED)
+		return 0;
+
+	return fh_respond(fh, !ret, false);
+}
+
+static int fh_session(struct f_firehose *fh)
+{
+	int ret;
+
+	while (!fh->online) {
+		if (ctrlc())
+			return -EINTR;
+		dm_usb_gadget_handle_interrupts(fh->udc);
+	}
+
+	fh->xfer_err = 0;
+
+	/* An XML first message tells the host to skip Sahara */
+	ret = fh_log(fh, false, "U-Boot Firehose, %llu sectors of %lu bytes",
+		     (u64)fh->desc->lba, fh->desc->blksz);
+
+	while (!ret && !fh->reset) {
+		ret = fh_rx(fh, fh->rx_xml, FH_XML_SIZE);
+		if (ret < 0)
+			break;
+		fh->rx_xml[ret] = '\0';
+		fh->xfer_err = 0;
+		ret = fh_handle(fh, fh->rx_xml);
+	}
+
+	return ret ?: fh_tx_flush(fh);
+}
+
+int firehose_run(struct udevice *udc, struct blk_desc *desc)
+{
+	struct f_firehose *fh;
+	int ret;
+
+	if (FH_PAYLOAD % desc->blksz)
+		return -EINVAL;
+
+	fh = memalign(ARCH_DMA_MINALIGN, sizeof(*fh));
+	if (!fh)
+		return -ENOMEM;
+	memset(fh, 0, sizeof(*fh));
+	fh->udc = udc;
+	fh->desc = desc;
+	fh->buf = memalign(ARCH_DMA_MINALIGN, FH_PAYLOAD);
+	if (!fh->buf) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	firehose_func = fh;
+	g_dnl_clear_detach();
+	ret = g_dnl_register("usb_dnl_firehose");
+	if (ret)
+		goto out;
+
+	do {
+		ret = fh_session(fh);
+	} while (ret != -EINTR && !fh->reset);
+
+	g_dnl_unregister();
+	g_dnl_clear_detach();
+
+	if (fh->reset)
+		do_reset(NULL, 0, 0, NULL);
+
+	ret = ret == -EINTR ? 0 : ret;
+out:
+	firehose_func = NULL;
+	free(fh->buf);
+	free(fh);
+
+	return ret;
+}
diff --git a/drivers/usb/gadget/firehose_parse.c b/drivers/usb/gadget/firehose_parse.c
new file mode 100644
index 00000000000..89e47659fb2
--- /dev/null
+++ b/drivers/usb/gadget/firehose_parse.c
@@ -0,0 +1,110 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Qualcomm Firehose command parser
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include <firehose.h>
+#include <linux/ctype.h>
+#include <linux/errno.h>
+#include <linux/string.h>
+
+static char *fh_skip_ws(char *p)
+{
+	while (*p == ' ' || *p == '\t' || *p == '\r' || *p == '\n')
+		p++;
+	return p;
+}
+
+static char *fh_parse_name(char *p)
+{
+	if (!isalpha(*p) && *p != '_')
+		return NULL;
+	while (isalnum(*p) || *p == '_' || *p == '-' || *p == '.' || *p == ':')
+		p++;
+	return p;
+}
+
+/*
+ * XML subset, parsed in place: an optional declaration and one
+ * self-closing element inside <data>, values without entities:
+ *   <?xml version="1.0" ?><data><program A="v" B='w' /></data>
+ */
+int firehose_parse(char *p, struct firehose_cmd *cmd)
+{
+	char *end;
+
+	memset(cmd, 0, sizeof(*cmd));
+
+	p = fh_skip_ws(p);
+	if (!strncmp(p, "<?xml", 5)) {
+		p = strstr(p, "?>");
+		if (!p)
+			return -EINVAL;
+		p = fh_skip_ws(p + 2);
+	}
+	if (strncmp(p, "<data>", 6))
+		return -EINVAL;
+	p = fh_skip_ws(p + 6);
+	if (*p++ != '<')
+		return -EINVAL;
+	end = fh_parse_name(p);
+	if (!end)
+		return -EINVAL;
+	cmd->tag = p;
+
+	for (;;) {
+		struct firehose_attr *attr;
+		char quote;
+
+		p = fh_skip_ws(end);
+		if (*p == '/') {
+			*end = '\0';
+			break;
+		}
+		if (p == end || cmd->num_attrs == FIREHOSE_MAX_ATTRS)
+			return -EINVAL;
+		*end = '\0';
+
+		attr = &cmd->attr[cmd->num_attrs++];
+		end = fh_parse_name(p);
+		if (!end)
+			return -EINVAL;
+		attr->name = p;
+		p = fh_skip_ws(end);
+		if (*p != '=')
+			return -EINVAL;
+		*end = '\0';
+
+		p = fh_skip_ws(p + 1);
+		quote = *p;
+		if (quote != '"' && quote != '\'')
+			return -EINVAL;
+		attr->value = ++p;
+		end = strchr(p, quote);
+		if (!end || strcspn(p, "<&") < end - p)
+			return -EINVAL;
+		*end++ = '\0';
+	}
+
+	if (p[1] != '>')
+		return -EINVAL;
+	p = fh_skip_ws(p + 2);
+	if (strncmp(p, "</data>", 7))
+		return -EINVAL;
+
+	return 0;
+}
+
+const char *firehose_attr(struct firehose_cmd *cmd, const char *name)
+{
+	int i;
+
+	for (i = 0; i < cmd->num_attrs; i++)
+		if (!strcasecmp(cmd->attr[i].name, name))
+			return cmd->attr[i].value;
+
+	return NULL;
+}
+
diff --git a/include/firehose.h b/include/firehose.h
new file mode 100644
index 00000000000..2a31d862cd0
--- /dev/null
+++ b/include/firehose.h
@@ -0,0 +1,67 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Qualcomm Firehose flash programmer protocol over USB
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef __FIREHOSE_H
+#define __FIREHOSE_H
+
+#include <linux/types.h>
+
+struct blk_desc;
+struct udevice;
+
+#define FIREHOSE_MAX_ATTRS	32
+
+struct firehose_attr {
+	const char *name;
+	const char *value;
+};
+
+/**
+ * struct firehose_cmd - a parsed Firehose command
+ *
+ * @tag:	element name, e.g. "program"
+ * @attr:	attributes, pointing into the parsed document
+ * @num_attrs:	number of attributes
+ */
+struct firehose_cmd {
+	const char *tag;
+	struct firehose_attr attr[FIREHOSE_MAX_ATTRS];
+	int num_attrs;
+};
+
+/**
+ * firehose_run() - serve a block device to a Firehose host
+ *
+ * Registers the Firehose USB function on @udc and answers the host's
+ * commands until the host asks for a reset, which does not return, or
+ * until the user presses Ctrl-C.
+ *
+ * @udc:	USB device controller to register the function on
+ * @desc:	block device to program
+ * Return: 0 on Ctrl-C, negative error code on failure
+ */
+int firehose_run(struct udevice *udc, struct blk_desc *desc);
+
+/**
+ * firehose_parse() - parse a Firehose XML command in place
+ *
+ * @xml:	NUL-terminated document, modified by the parser
+ * @cmd:	filled with pointers into @xml
+ * Return: 0 or -EINVAL if @xml is not a supported Firehose command
+ */
+int firehose_parse(char *xml, struct firehose_cmd *cmd);
+
+/**
+ * firehose_attr() - look up an attribute, ignoring the case of its name
+ *
+ * @cmd:	parsed command
+ * @name:	attribute name
+ * Return: attribute value or NULL if missing
+ */
+const char *firehose_attr(struct firehose_cmd *cmd, const char *name);
+
+#endif /* __FIREHOSE_H */

-- 
2.53.0

