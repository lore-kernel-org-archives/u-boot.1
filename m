Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C874D606A320
	for <u-boot@archiver.kernel.org>; Thu, 19 Nov 2026 06:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=q/2Goft+;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=o3en/lV/;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=j/XjYy91
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7EAB981092;
	Thu, 19 Nov 2026 06:09:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Kh9pzQL45lbf; Thu, 19 Nov 2026 06:09:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7202580FC6
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795068586;
	b=AkBLJwC9ObGS/Sl3naiC0H7IwVF4dvRm+cwhp16c4catlEcnoscyLE9dKhZGPv7Mg4tA
	 /95AxrKqmOl8gg1eCiy9BLOIb1DrPQf7IkxWZUdzHry5TzlkQLJP5CgSHldO8mfpSqJfh
	 cg1/TuQd1WiPWKof232h+fbRAcyye1JH/hypDq7/C2P5aGEVFTY3Igbyx+R1pjefFyMlv
	 tltvbi+ef3yqGBWMZfJ5Hbq3AFHSnQ3j4LAPDgkGUb4IVTWzeySiidw+NsG8SvMkMk19G
	 4l2lxqWwCdPa+dtFgWxSNI1PpJ2M/dJ6hGyfhqE/MBdle4SZehhSncML8S96/FT8gTA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795068586;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=+qxj1fPPIwjndiFln8bFnr07RF3XHFKRU5TZWBW3QIs=;
	b=fqyvF7yK1jL7ocOcJf4wY7L1zMCmNM8mR/D0zB1ZIjtctW2s3S/tXGaRJuZDbNbd7OKe
	 YzT9h59t9HjeA9Ovo+8WBOSV4gPbXj1lCkWvik5PdZ+oHOdsGHkiREdiUqU0jCI0GNUCq
	 0dDGSlrl3s6rc2ZoPyvBcZyeOmTbb2mF7LHClbFHIGt908TfX60wVca5CfswHm/Z25NmR
	 aGkeTyC1rUe8ni/h49EOoN1Q/t7j4diHIFESy1BRquLIzJaKgq5s+55SaYRmZWAyAmg/D
	 mB7yNZnLZ3DJiU+IbjZvsvRdZuazrbwDSlrvmtBcf35w93NEDdFmH5zozZ4YNBmp7Ew==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795068586;
	bh=+qxj1fPPIwjndiFln8bFnr07RF3XHFKRU5TZWBW3QIs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=q/2Goft+Vcv7x1rataotEGpHIyhyxAO9Q+eSRbta8UjjzbUibxLAkw1bSz1oFk9C+
	 ys1g83r6SSy9+VDmJY1Xskau0vRaOUOoyv7I2cbUCwo778q5rXMpiwFBOcX1CXAZkw
	 dEnF4d2eq1olASnOXWvNpyy4sROBxGDhLgDOJ/WYiPPP81S00jvhNlNbbA2/loYEbC
	 xroZG/dTKnVV98BSiItqteRaLbVlA9c98e4x9+FPrebOaI+IMmgOGbHnU2QBTjRRNm
	 V2MHi0WBuv9wdVO9KywsK27DozjxVZqMCyo2heUEi49GgH7uqFUOTiZ/A5rV+XLKXG
	 6Eke/XkDkbYMA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7202580FC6;
	Thu, 19 Nov 2026 06:09:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5E5889F8
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 06:09:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4EFE040539
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 06:09:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ECa2KyonE6f3 for <u-boot@lists.u-boot-project.org>;
 Thu, 19 Nov 2026 06:09:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3C40A40526
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=o3en/lV/; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=j/XjYy91
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3C40A40526
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 06:09:43 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJ1B7Lv786422
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 06:09:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +qxj1fPPIwjndiFln8bFnr07RF3XHFKRU5TZWBW3QIs=; b=o3en/lV/akd7axt4
 Vp0Uq6bKR2TghLp7NRCHCNjhqhoA0oeDqI+1VWepUJcdauVQTr3v3whLLlUWHKR/
 1ZoJd9HYoy2JME8nku1nw+I5WHOAcNLBv0yfJDD6w4wXlW3LtjyrnuCffnYmXpwV
 JJt7nP9cMHPPWCXhE3et/GPiCQR+0UOhJuIL9UOvMc8+s2eEbBiev45doNZrBNR1
 J6SeT04cFiTufek0/byz5xKkR/uViw43BM3Ygqf0dssJHdLtgNejmKBNrwG/NIaU
 LhtaklGPjSY2lxJSXzCA/uelCuQec11NCjxgTF1uyDF0Nuy9fWMjgzohNJkxgr5g
 i5gYxw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j1dpcbkf3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 06:09:42 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-370230d93efso216501eec.1
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 22:09:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795068582; x=1795673382;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+qxj1fPPIwjndiFln8bFnr07RF3XHFKRU5TZWBW3QIs=;
 b=j/XjYy91B3pqh/FzTsU7FPbE/6NpqteyZMddDvhGk5lOUvak4r25kRC21ihYgT2HeL
 g3mVpL3SGbstmWDZQIz8wW6ulob5kEfokaM6ni6suYu/nGZt6/OgvPqekZr7GZ139ERH
 O3LWZCnDmvtN3I9xnjXDbQTTDCVK9qC2gYm80CsPZTrxcyWz/BbdkvxCC6sQSfI6vCzV
 NJJZ9x2+xWfvyiuCDBJeQuOVtj46ic5qOLJG+4RC+qL1vZ0HOMh6US53t1v3BO2kxa9O
 oWBdzYiAo5HJsPoI/3Wiv7v0uGmqM59IeA8ETWdWriFGsPsV9jH69t1T1pKcxtbjesCC
 lp/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795068582; x=1795673382;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+qxj1fPPIwjndiFln8bFnr07RF3XHFKRU5TZWBW3QIs=;
 b=UoGn7KnwSWB5eLGDLRO98JSRb4nJz7Pe5CrKkX4NnNoqCwJBSpXDHs2mB1/uHdUvMq
 /6IdQK3Vj+Be1fdLIf4o3WXjOOdjfr+y5sE1kguD1RDHPJ8e4mvH5T2nZIx6l4/GPEP7
 HK0EdTju+6cMwS+9o3SIHJt1+tAU/zeH8V/bnBx0nASI/rIV7lTD8LgeuMV8hW9/Bspf
 ZjbzYrlhmuG0xoy1NIaVL3zHD0M2MWorwY3LMXy2SwJ16795it0GcQx2/NCvggX2eICy
 30V2RDdINEe8pcALzVl0T/N0S5vF6AglNyyvlVMkmSCUBLWgmh6z1qrolQD8rlSQoTa4
 KSMg==
X-Gm-Message-State: APuU4Z90pkbaZHR/VZjRpI0QLEfy+zWLeS8cXUvyHe3rUuzrZWlZ+8YV
 OgW1F4fd8YXR2HpPhEkp0W+5SuBbaeHqA94a3e6l9Et/Nurn1JbCa40l44a7G8yp11MprLoCpK8
 8SKVlT1bTFUsnCKmiNPMGScIeCbKFL0C0zoNg/8L6uDETkYlS8jZaeQtn7DyJQvEKUh4B0t8=
X-Gm-Gg: AZFdTZfXi553ued3SBBOdjKYL5z/FJQrotunUJ70yRri0t8n3m+ezjJBvTYgVs8AO7J
 57Tz2K+5XKkhrf8go06TJ3x31QVxIeYhgOmTcdz5vOeCzAXqzVeI7XwChAVT+Hu78y37ykqZtaU
 IIDN0OITEpgLVJdmF0QginAjinYiZ27CLe+aQ09sw+2GHzhEM4ujA3ObcYp89EqYa6VfmRnHGSL
 MJbmrUxfpSQWES+ZLq+h1izvM9SufrgE3QajXTsNNx4wpvZ4CgkaKfgZ+w4yTPRz3FftHzFs09/
 NgH7+wxzwLHNtWQBnXAhmxJbvqbUS1AlkBJJj+8D06aDJIvlYFxXgQACWDHsHreqkAs/DMkc1gd
 UKDoi1R7b5JMMl9lXTJPd2yRh8AL2JTwRypUD/KybFd8lvCCns1ujxvWmBegnsw8CJMNXO8dLkQ
 dR31DmBVbyBmGH1xUr4TdzSsFcdGb9fe8V0yZtvcq5D9W3vvI/okRWBxLr0lx8KqzgFjTBNyo8W
 KhAPw==
X-Received: by 2002:a05:7300:271e:b0:369:4c3f:8a5 with SMTP id
 5a478bee46e88-3827fe755c8mr4937526eec.14.1795068582076; 
 Wed, 18 Nov 2026 22:09:42 -0800 (PST)
X-Received: by 2002:a05:7300:271e:b0:369:4c3f:8a5 with SMTP id
 5a478bee46e88-3827fe755c8mr4937516eec.14.1795068581596; 
 Wed, 18 Nov 2026 22:09:41 -0800 (PST)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-382a72eb2f3sm15871489eec.18.2026.11.18.22.09.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 22:09:41 -0800 (PST)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Thu, 19 Nov 2026 11:39:16 +0530
Subject: [PATCH 1/5] usb: tcpm: Support non-PD mode
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261119-qcom-pmic-typec-v1-1-d197e6d7da5a@oss.qualcomm.com>
References: <20261119-qcom-pmic-typec-v1-0-d197e6d7da5a@oss.qualcomm.com>
In-Reply-To: <20261119-qcom-pmic-typec-v1-0-d197e6d7da5a@oss.qualcomm.com>
To: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>,
 Marek Vasut <marek.vasut+usb@mailbox.org>,
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Neha Malcom Francis <n-francis@ti.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Anshul Dalal <anshuld@ti.com>, Yixun Lan <dlan@kernel.org>,
 Stefan Eichenberger <stefan.eichenberger@toradex.com>,
 Michael Srba <Michael.Srba@seznam.cz>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Dave Klotz <DaveWK225@protonmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795068570; l=6613;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=WcSlNPpy+HArCzkZGdG16YUAOB0ScQUaJwfIjs4Y6mA=;
 b=dnHgbm1IHFnGX8mVoq/ud5MJ9z/WjCvd1wRRWa0IcGpX1J0dsSg0irD6Q8L8jqpS2V+8RTDy+
 YltYExPF8XGDsnMFXBHTEGESimMFsLwfMGNIpiDyfsgiC3mubVM8kRI
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Authority-Analysis: v=2.4 cv=YJ0KWhGx c=1 sm=1 tr=0 ts=6afe92a7 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=rMR5Ams5gif1IU5RwA4A:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDAyNCBTYWx0ZWRfX1j0V4hEbUuF/
 ladPkuLsJG0IbclZscAe06CHdZUmYMv+UhUgebHk/3B+uZnVQQdiWabLZcWiRW15xCzOQoBf76R
 5necOngFaYmcP6DME/4iVnsv6jIkKTs3qPvvZRIdkNGV2t/8AI3k72eaZK37weAJz9yL6tjok7M
 TpU6MvLgiqJoMuW7AcO5PN4PG2lFDKDG5wpMWdWt5Df4eLbeu8pT6qHW6Zubv5rRFSQMxYSG3gf
 KkFB9Jt41E28Lwrkp8Au1L1nPxbdKbQkumX8DiiTchhXAsYR1HqeFaBevha+M2A3Fgeai2piNyB
 /ACntT/pLzP6/hvVOVGuBL6R/OtBITYV9q8BRAClqd7fEQJ7p4MWa0kyI3bccSo5bvVcwe7Vxl8
 GITIJBAwSXqzgLBUx3Pcd3TRgrb6k6tdBlbcCeN7atkO9Cb4gF4IfM/Ia41a9ob35rUlMLWqwzd
 KZ2+om8lxdj/vJzDpFg==
X-Proofpoint-ORIG-GUID: DpXGxGlpGIEtRsDzpYsrX1SCSlYI7z5M
X-Proofpoint-GUID: DpXGxGlpGIEtRsDzpYsrX1SCSlYI7z5M
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDAyNCBTYWx0ZWRfXzCnc6NewEOmY
 0YrPIophcMb5MW5Tde9i5RBmdiZP3SwvMtIpUALUwvYNKZj9oiMF66GCpoBdsBwICC+/c4ye42F
 PRKvJIfgzXZUckcg8nnbrR17eQ2ZXhI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_01,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 phishscore=0 spamscore=0 adultscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611190024
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

Ports with the "pd-disable" property have no USB PD support. They do not
require source/sink PDOs and op-sink-microwatt and take the Rp
value to advertise from "typec-power-opmode", and skips the PD
capability exchange so that the source and sink paths go straight to
the ready state.

Taken from Linux commit e9e6e164ed8f ("usb: typec: tcpm: Support non-PD
mode") and commit 2e7dfb0e9cac ("usb: typec: Factor out non-PD fwnode
properties").

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 drivers/usb/tcpm/tcpm-internal.h |  3 ++
 drivers/usb/tcpm/tcpm.c          | 96 +++++++++++++++++++++++++++-------------
 2 files changed, 68 insertions(+), 31 deletions(-)

diff --git a/drivers/usb/tcpm/tcpm-internal.h b/drivers/usb/tcpm/tcpm-internal.h
index 56144209002..56d02cc3745 100644
--- a/drivers/usb/tcpm/tcpm-internal.h
+++ b/drivers/usb/tcpm/tcpm-internal.h
@@ -56,6 +56,7 @@
 #define GENERATE_TCPM_ENUM(e)		e
 #define GENERATE_TCPM_STRING(s)		#s
 #define TCPM_POLL_EVENT_TIME_OUT	2000
+#define TYPEC_NO_PREFERRED_ROLE		(-1)
 
 enum tcpm_state {
 	FOREACH_TCPM_STATE(GENERATE_TCPM_ENUM)
@@ -81,12 +82,14 @@ struct tcpm_port {
 	struct typec_partner *partner;
 
 	enum typec_cc_status cc_req;
+	enum typec_cc_status src_rp;	/* work only if pd_supported == false */
 	enum typec_cc_status cc1;
 	enum typec_cc_status cc2;
 	enum typec_cc_polarity polarity;
 
 	bool attached;
 	bool connected;
+	bool pd_supported;
 	int poll_event_cnt;
 	enum typec_port_type port_type;
 
diff --git a/drivers/usb/tcpm/tcpm.c b/drivers/usb/tcpm/tcpm.c
index d6c0be82333..4188989b567 100644
--- a/drivers/usb/tcpm/tcpm.c
+++ b/drivers/usb/tcpm/tcpm.c
@@ -141,6 +141,9 @@ static enum typec_cc_status tcpm_rp_cc(struct tcpm_port *port)
 	int nr_pdo = port->nr_src_pdo;
 	int i;
 
+	if (!port->pd_supported)
+		return port->src_rp;
+
 	/*
 	 * Search for first entry with matching voltage.
 	 * It should report the maximum supported current.
@@ -1290,9 +1293,11 @@ static int tcpm_src_attach(struct udevice *dev)
 	if (ret < 0)
 		return ret;
 
-	ret = drvops->set_pd_rx(dev, true);
-	if (ret < 0)
-		goto out_disable_mux;
+	if (port->pd_supported) {
+		ret = drvops->set_pd_rx(dev, true);
+		if (ret < 0)
+			goto out_disable_mux;
+	}
 
 	/*
 	 * USB Type-C specification, version 1.2,
@@ -1321,7 +1326,8 @@ static int tcpm_src_attach(struct udevice *dev)
 out_disable_vconn:
 	tcpm_set_vconn(dev, false);
 out_disable_pd:
-	drvops->set_pd_rx(dev, false);
+	if (port->pd_supported)
+		drvops->set_pd_rx(dev, false);
 out_disable_mux:
 	dev_err(dev, "TCPM: CC connected in %s as DFP\n",
 		polarity ? "CC2" : "CC1");
@@ -1476,6 +1482,10 @@ static void run_state_machine(struct udevice *dev)
 		tcpm_set_state(dev, SRC_READY, 0);
 		break;
 	case SRC_STARTUP:
+		if (!port->pd_supported) {
+			tcpm_set_state(dev, SRC_READY, 0);
+			break;
+		}
 		port->caps_count = 0;
 		port->negotiated_rev = PD_MAX_REV;
 		port->message_id = 0;
@@ -1612,7 +1622,10 @@ static void run_state_machine(struct udevice *dev)
 					       tcpm_get_current_limit(port),
 					       5000);
 			tcpm_set_charge(dev, true);
-			tcpm_set_state(dev, SNK_WAIT_CAPABILITIES, 0);
+			if (!port->pd_supported)
+				tcpm_set_state(dev, SNK_READY, 0);
+			else
+				tcpm_set_state(dev, SNK_WAIT_CAPABILITIES, 0);
 			break;
 		}
 		/*
@@ -1707,7 +1720,8 @@ static void run_state_machine(struct udevice *dev)
 	case SRC_HARD_RESET_VBUS_ON:
 		tcpm_set_vconn(dev, true);
 		tcpm_set_vbus(dev, true);
-		drvops->set_pd_rx(dev, true);
+		if (port->pd_supported)
+			drvops->set_pd_rx(dev, true);
 		tcpm_set_attached_state(dev, true);
 		tcpm_set_state(dev, SRC_UNATTACHED, PD_T_PS_SOURCE_ON);
 		break;
@@ -2153,39 +2167,61 @@ static int tcpm_fw_get_caps(struct udevice *dev)
 		return -EINVAL;
 
 	port->port_type = port->typec_type;
+	port->pd_supported = !ofnode_read_bool(node, "pd-disable");
+
+	/* Get the preferred power role for DRP */
+	port->typec_prefer_role = TYPEC_NO_PREFERRED_ROLE;
+	if (port->port_type == TYPEC_PORT_DRP) {
+		cap_str = ofnode_read_string(node, "try-power-role");
+		if (cap_str) {
+			if (!strcmp("sink", cap_str))
+				port->typec_prefer_role = TYPEC_SINK;
+			else if (!strcmp("source", cap_str))
+				port->typec_prefer_role = TYPEC_SOURCE;
+			else
+				return -EINVAL;
+		}
+	}
 
 	if (port->port_type == TYPEC_PORT_SNK)
 		goto sink;
 
-	/* Get source pdos */
-	ret = ofnode_read_size(node, "source-pdos") / sizeof(u32);
-	if (ret <= 0)
-		return -EINVAL;
+	/* Get Source PDOs for the PD port or Source Rp value for the non-PD port */
+	if (port->pd_supported) {
+		ret = ofnode_read_size(node, "source-pdos") / sizeof(u32);
+		if (ret <= 0)
+			return -EINVAL;
 
-	port->nr_src_pdo = min(ret, PDO_MAX_OBJECTS);
-	ret = ofnode_read_u32_array(node, "source-pdos",
-				    port->src_pdo, port->nr_src_pdo);
-	if (ret || tcpm_validate_caps(dev, port->src_pdo, port->nr_src_pdo))
-		return -EINVAL;
+		port->nr_src_pdo = min(ret, PDO_MAX_OBJECTS);
+		ret = ofnode_read_u32_array(node, "source-pdos",
+					    port->src_pdo, port->nr_src_pdo);
+		if (ret || tcpm_validate_caps(dev, port->src_pdo,
+					      port->nr_src_pdo))
+			return -EINVAL;
+	} else {
+		cap_str = ofnode_read_string(node, "typec-power-opmode");
+		if (!cap_str)
+			return -EINVAL;
+
+		if (!strcmp("default", cap_str))
+			port->src_rp = TYPEC_CC_RP_DEF;
+		else if (!strcmp("1.5A", cap_str))
+			port->src_rp = TYPEC_CC_RP_1_5;
+		else if (!strcmp("3.0A", cap_str) ||
+			 !strcmp("usb_power_delivery", cap_str))
+			port->src_rp = TYPEC_CC_RP_3_0;
+		else
+			return -EINVAL;
+	}
 
 	if (port->port_type == TYPEC_PORT_SRC)
 		return 0;
+sink:
+	port->self_powered = ofnode_read_bool(node, "self-powered");
 
-	/* Get the preferred power role for DRP */
-	cap_str = ofnode_read_string(node, "try-power-role");
-	if (!cap_str)
-		return -EINVAL;
-
-	if (!strcmp("sink", cap_str))
-		port->typec_prefer_role = TYPEC_SINK;
-	else if (!strcmp("source", cap_str))
-		port->typec_prefer_role = TYPEC_SOURCE;
-	else
-		return -EINVAL;
+	if (!port->pd_supported)
+		return 0;
 
-	if (port->typec_prefer_role < 0)
-		return -EINVAL;
-sink:
 	/* Get sink pdos */
 	ret = ofnode_read_size(node, "sink-pdos") / sizeof(u32);
 	if (ret <= 0)
@@ -2201,8 +2237,6 @@ sink:
 		return -EINVAL;
 	port->operating_snk_mw = mw / 1000;
 
-	port->self_powered = ofnode_read_bool(node, "self-powered");
-
 	return 0;
 }
 

-- 
2.34.1

