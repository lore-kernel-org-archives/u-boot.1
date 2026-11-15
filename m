Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB448606A327
	for <u-boot@archiver.kernel.org>; Sun, 15 Nov 2026 05:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=trBqe16u;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dA2L80QJ;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=X6IWlWRT
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A907380F6C;
	Sun, 15 Nov 2026 05:04:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jOXWI0RgSQVI; Sun, 15 Nov 2026 05:04:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org AA56480F76
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794719091;
	b=JTeiS3oRT4bEmfcStYwITjtEkrOWbwGd/xvqGvdpN7KzsiMU2Xs5GNL7jJgqcBub0H3+
	 K5apr8sGfvBc939Sfs1ofhsURKhuE2YOCDLglgv45/z1Iq52j3/Tk5eTAnOi/Dy5n9PGA
	 pbfT1L4HTHkfuusbgkOGM3hXxuhtkBmtrRubBstBdL4a9z2Sz8qGUnr8lSpgsrxMXq1Va
	 0AB9u/UD+LMyvmKpochYi4QAfBL9T/H/t4YPl1ihf1oPwx99iW0Jj0TPIYTOjIdCX+OTG
	 NLMMXlXBx96v/FiGK9GeuFP3r9LD+9+VL3GoFpvMArRtIEPOync9oRe6/lgJvCN4z9A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794719091;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=CVD9DeBPbyta/z14GhVLzNipJhCvbJZ0OFsLAQNXKd0=;
	b=X+PjJ1qx/f/4XgeCtgKKG3zSEuAjJq3vwB4EvHsrR6YIieF8OOUi7eD8jsq5ICn8im7S
	 m3eWL6f80P/+Htn9hl+7wafTS/6AX78TheAeuiT6zaLhSajJnc1uQ/lc8DYvZUfAFsiO2
	 oM9jSDZ55SJOzmvWYwQS8GxV2nZJo3Tk3BNyoIvaFK9bXdUiDePuIzgcdorOS8ODDtkbo
	 /bvcIMS1/npZn4yNeK5foFgjfKnsxYoJbi+gTjSrTCwagWsvyHWlF95vIw+tVlxpcTUCq
	 qW+4KYQPO7CMwva2/p9SdsAqrZ0tPicXEZOtFjlBdG0FGqPNZZIMUlexodKJF7ianEg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794719091;
	bh=CVD9DeBPbyta/z14GhVLzNipJhCvbJZ0OFsLAQNXKd0=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=trBqe16uhyb3souk5Oc0+X5Inr58TA4kpt3T4Cn/dGRNe+dC60jb035kg4ufInbCh
	 md4Fc3qX5oqAsG442OHTEKvdYYVpQx0ErgAEZTW/QThQaUIjyTu8PhTSqHg6zbrCSu
	 QvOM1v+ouYCaWBBmhxcQeJyXMFbXwvA6b+kfzcGwzwuACJMx/clI/iHjYwa3sWtxb/
	 1Ge69PPwTQ7FCL6FuLPdwFVyuzCw71rihfhN+O36bamJHEWBtSaaykfP6WuIc4NaX0
	 Z1oeR4UxPPaOWC/hFbc5R7FJL8WfVtHoNYfRgesZpeoKsrHyDlpAt5EVUEVPUhYxZN
	 4U7k2gOh2JNPQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id AA56480F76;
	Sun, 15 Nov 2026 05:04:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 42BAA28C
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 05:04:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2C802606C0
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 05:04:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bYJQBrgXjfMb for <u-boot@lists.u-boot-project.org>;
 Sun, 15 Nov 2026 05:04:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 31A1B60615
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=dA2L80QJ; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=X6IWlWRT
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 31A1B60615
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 05:04:47 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AF4RsxT1911866
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 05:04:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=CVD9DeBPbyta/z14GhVLzN
 ipJhCvbJZ0OFsLAQNXKd0=; b=dA2L80QJBT8NzyGj76GAz3AsWkPSgAKNq0UyHT
 D9u58THhNZUyamfC7N5IBKw826m2fOOEqs7jaxMwaGofa6pgdyXmWIj1r3bRlTLn
 SvZylGiOhtou0/i9LVtguG4iiHUpf1kWHV7ANns8zUL99HspnffFEx3H88Rw3zL0
 jeYEaGTOQz/rzEodPqSPbRlC3WvgnmLuLuuP/4xAtAyctcCSV9ie7niMZZBsO/2V
 40o/BbNcsnlfA2bGsqFIfPtcc2FjdUepD9sE5U45r4GqQox2majd64jHLl6FTCmO
 pFiDdnzI94dXNqMb7DRk+f/Hxlnzx7NBNI67X/u1zp+11xVg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhjqjc00-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 05:04:46 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-370230d93efso9783298eec.1
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 21:04:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794719086; x=1795323886;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=CVD9DeBPbyta/z14GhVLzNipJhCvbJZ0OFsLAQNXKd0=;
 b=X6IWlWRTZuHiOmibiiVY8AspZo0CTDUANlfpOZr0JMS1KflZPEXU8nf6mNoFvrUiAy
 WrGu3778AYSMWvVvCj56paKp+vk3evJdTUafgIwsoGpnXG3WPiN3ibyawxiIAyF8YgUj
 jjsUv2vdrSgPlvelbmDRChVE0NXJ2MxL76gA+TwVFNdf5Z5J2GK/byCC1fLa7caeZzu5
 oNUHk7pc8InVEwVJ3mcFadqo1XxguFQUtOxuS21bxugFnAqJD5uHvo1nj1oPC3YkLtyT
 m5L8M6bjUTniR6vbB5f0NheZIwCBugfeiolXTfuaBCNkkS/dtoYRgUrdX4KOHp9CDqYB
 V91g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794719086; x=1795323886;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=CVD9DeBPbyta/z14GhVLzNipJhCvbJZ0OFsLAQNXKd0=;
 b=kl8sR35/c/LIPOQxovF0kwMzlgiBaNJZw4wrflJ5jJVoUVQ5DNMFJXVrMEWhEwCmUP
 wZMoQ8E36DQc+/z3ajguCFEgXngNNUexgEoHU6ikoG1nbDb/hJBuxBtJ2jEAIN6dUIAT
 RKOfsheN1I3ParnImzmDwpkOnNARQtnZzceeZJYvvdj8wgHrPjFBQL9x0k0jmTkWG9x9
 oaijSc+BxGCR1IaqXBdJbIGOZvRXRtt33dvVxzU+UhNxiL1ae/D/rUu091XY2C7D96RN
 JuHhphqYJJkGquFqUENwOGYRzCjQ5CUU1sFfJJqiZKUd5RsniOkjf9+cYwDFi3X9c+Ea
 98Xg==
X-Gm-Message-State: APuU4Z/5wkL2YuCzhoUJpN/V/pGtGnkrTBusw2KiIpthvPoj9F3Zt+0p
 NuBjK2ioKR2teajKbCcYUWZ1Re2Z6YlW6BHwZSnjKt9LyP7xqqFpq2XNalZtnepYB6j9AsOfZEN
 HblsNoF1fpW/t13DmYki37/FCmTXVhWJ+SoTgt0V0ffjh0PHd4LPADlQKwXW4zuJwJYjlC31vFz
 tF0Ug=
X-Gm-Gg: AYBFou15Vm6VRhNlWQ0aXQnNZ0E7v+OseasDjClIVAr2EtEhwfq528s5qMgiiauRRyl
 fZsqtWoF93X83ENxmR/rIJurJpuQwNOi8/+BolBYfD5K479gnLY1h5dY/Hvjlfz/zWSnZ5M5MfQ
 a7s5JH6dwQ3GAf5fqCpm4SxaNRFIWKfqJgi8HZf7X6ONwOnIRFUGUb5TPMfpz1dvbwWFS8FVtuU
 yy8DV5wLAOVWJYavCJf/sGCyy5UaDZ9FDB/yp8S8gYff9D1Nr5OhqDbX0PSRHqsP+TLrz+orfuA
 INAkCpXURg3uYks1oyOvviREiLZM71ERlRqjJQEObs4K6UXXkIylrl5c+CrD2DOyNB3HB7DocOT
 vUtF49yH7WfxEyIrO0eLX64oyqnlol/W7+eyfPBtpXe9iwjhiwO5UVpD3oZ1jxrW/PZxBNEDsOJ
 Hx5bKjWbc89QdZyYrfe9OrsLJxy1QILb0JP4J4iQTCK2xBjHlxn2v0qAwTSwwkCSxv840gTWZUW
 O6w
X-Received: by 2002:a05:693c:6384:20b0:36a:1709:458 with SMTP id
 5a478bee46e88-379675fc98cmr7453624eec.27.1794719086108; 
 Sat, 14 Nov 2026 21:04:46 -0800 (PST)
X-Received: by 2002:a05:693c:6384:20b0:36a:1709:458 with SMTP id
 5a478bee46e88-379675fc98cmr7453600eec.27.1794719085584; 
 Sat, 14 Nov 2026 21:04:45 -0800 (PST)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-379565d269asm23487034eec.23.2026.11.14.21.04.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Nov 2026 21:04:45 -0800 (PST)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Subject: [PATCH v2 0/6] mkeficapsule: Support multi-payload capsules
Date: Sun, 15 Nov 2026 10:34:38 +0530
Message-Id: <20261115-mkeficapsule-v2-0-9fe141b2cc7c@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGY9+WoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHQUlJIzE
 vPSU3UzU4B8JSMDIzMDcyNT3dzs1LTM5MSC4tKcVF3LZMOUFLNkA9MkEwsloJaCIqBkBdi46Nj
 aWgCrvprFXgAAAA==
X-Change-ID: 20260725-mkeficapsule-9c1dd6c05b48
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@arm.com>,
 Peng Fan <peng.fan@nxp.com>, Daniel Golle <daniel@makrotopia.org>,
 Vincent Jardin <vjardin@free.fr>, Peter Robinson <pbrobinson@gmail.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Sughosh Ganu <sughosh.ganu@arm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794719081; l=3321;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=wtUCwsqXMt5UbORItJOFWO+iyZRTtyCbzsQHkg2JE8U=;
 b=P5s6O7eWnIRRmNQPutRpi8pmvLVTrv7X2EKGYdG9Rk7AUEIGDqr6qq6zBEgl+m9KNVG80lfFk
 i8KhNu9ws2GBw05HOXHc64bMlefyiu9ERrDRoBZc/N7g7DO9xm3rz89
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-ORIG-GUID: bamIPOZbi6kRF3xqMBUJsA3s5LWRTuBj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE1MDAxOSBTYWx0ZWRfX1+uaG3Xuonjj
 RSWaLlwWy6tKVqfVMxFU44erpjPPHpjxLT9iOrp/C4eiwIFh7uotWMgZOYuF5dO5nRlJyh7Xnfx
 hdh8/RlEDLGnsOyeSRkU9cMyYFDPWq1LJBBe5k/qxn9B1WerBNNUdpXRsRAtbEyySUAUwH5o9N4
 vi0HbxKofYoaRNm0ExXR8Viw0HCVvExF+LQ+XjxKjsiKAN34OaXlmwFHa5tOOiw4xx9rCl92fTd
 dVMBFgtVOp6YVtXWLPdU4RSliPrusLCpB6/XHBOL4olPjVW/k2YXGXIAz2REWSSRV4HU9mhnFZc
 phfJHRWAGbWzZhJfySGjO1iTs+o1QQBr1zrfZ1DqWNFV/4fX0fxPvH9gltENkTeR9O38Vls/vYk
 8P5ol6+vHJzeaXjUEMCQJkpAVq1ui30ugjMid4GDeWEUaHSGZZpjcj6X/2pzeLEPGnhKp/pvlmg
 LczQoJpMDmeWn2YGKLQ==
X-Authority-Analysis: v=2.4 cv=TqJzFzXh c=1 sm=1 tr=0 ts=6af93d6f cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=VrdbzQJdUFUJzbhS4sgA:9
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: bamIPOZbi6kRF3xqMBUJsA3s5LWRTuBj
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE1MDAxOSBTYWx0ZWRfX9eZlFIpgVJBL
 46ky1a/CpZ4600jf8+0nrarnEamday7khUxWH5Q+HvfrQri30r2vBxRh5RgmG5Z2nywaXg2r9pE
 mxu0kAacJir3VdTpJ2TVEsNB4CZLAts=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-15_02,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 phishscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611150019
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

This series adds support for bundling multiple firmware images into a
single UEFI capsule, driven through mkeficapsule's config file.

It builds on earlier work from [1] adding config-file-driven
capsule generation to mkeficapsule. That series produced one
payload per capsule; this one extends the parser to group payloads
that share the same output capsule file into a single multi-payload
capsule, adds a new API to build that capsule, and extends signing so
each payload in a multi-payload capsule can be signed independently.

This series is part of work to bring multi-payload single capsule
based capsule update to Qualcomm boards. It applies to all boards,
not just Qualcomm.

[1] https://lore.kernel.org/u-boot/20240419065542.1160527-1-sughosh.ganu@linaro.org/

Changes in v2:
- Squash the signing patch into the multi-payload creation API patch,
  and the grouping patch into the config file parser patch
- Exit with an error when entries sharing a capsule file include
  accept or revert types
- Drop the EFI_CAPSULE_CFG_FILE and EFI_USE_CAPSULE_CFG_FILE Kconfig
  symbols. The sandbox capsule tests pass the config file to
  mkeficapsule by its fixed path
- Mention the --cfg-file long option in the commit message, and add it
  and the config file keys to the mkeficapsule man page
- Reformat the config key list in the documentation as a definition
  list and explain hardware-instance, monotonic-count, capsule-type
  and oemflags
- Fix the capsule test setup: run mkeficapsule before the filesystem
  image is created and drop a leftover virt-make-fs call, so the
  config file capsules end up in the test image
- Use the current SANDBOX_FIT_IMAGE_GUID in the sandbox config file
- Link to v1: https://lore.kernel.org/u-boot/20260727-mkeficapsule-v1-0-5b162866b092@oss.qualcomm.com/

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Balaji Selvanathan (6):
      tools: mkeficapsule: Add multi-payload capsule creation API
      tools: mkeficapsule: Add support for parsing capsule params from config file
      doc: Document capsule generation through a config file
      sandbox: capsule: Add a config file for generating capsules
      test: capsule: Generate capsules through config file
      test: capsule: Add functional test for multi-payload capsule update

 doc/develop/uefi/uefi.rst                          | 140 ++++++
 doc/mkeficapsule.1                                 |  55 +++
 .../tests/test_efi_capsule/capsule_gen_binman.dts  |   2 +
 test/py/tests/test_efi_capsule/conftest.py         |  13 +-
 .../tests/test_efi_capsule/sandbox_capsule_cfg.txt | 118 +++++
 .../test_efi_capsule/test_capsule_firmware_raw.py  |  36 ++
 .../test_capsule_firmware_signed_raw.py            |  33 ++
 tools/Makefile                                     |  10 +-
 tools/eficapsule.h                                 | 128 ++++++
 tools/mkeficapsule.c                               | 306 +++++++++++--
 tools/mkeficapsule_parse.c                         | 474 +++++++++++++++++++++
 11 files changed, 1277 insertions(+), 38 deletions(-)
---
base-commit: 574b1adad70a19d95c65e0f37f9c36d94fb5418f
change-id: 20260725-mkeficapsule-9c1dd6c05b48

Best regards,
-- 
Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

