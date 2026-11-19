Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF51606A32C
	for <u-boot@archiver.kernel.org>; Thu, 19 Nov 2026 06:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=MbwbAOtf;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UVBvVNgP;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ThwnWqWc
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EBB9160A94;
	Thu, 19 Nov 2026 06:10:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DmmsUq45dqXO; Thu, 19 Nov 2026 06:10:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3246E60B02
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795068608;
	b=mdAtkG8qH/BmMZdJjKejDaADlM0OEDBkHz7eJ3dhy+mZbyCycU1Laao3RELo74XEB7Gx
	 AV+v4LenDK3BBtEC55helS2+4873gUegAWx5r6QrgZ8KbbQYzKjjdmVWUg1hTTStUDid6
	 IPC6THj+Dpk6narBaXfRi5LxRvExtlxY3iLSqs11nt5W8Lsbf1zpbR/238Juj8tFizMIl
	 AteUymVhscDGd/fVpi0RY8vJfqHihKPzf7T6pHuZXTfLdu16JPKHygU3eSvxWNhDddcVH
	 ivSr2zmWkLwpo6kg6poQwC32YEOODzVAhNG3ophhaOcIF3WZrq+MHf19189E9PccdTw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795068608;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=hk9Hh8hLMzIKPnWjs9zWWLOoHcXWtfi8JIuScmIwntY=;
	b=raA48YE5EcP4lR5I+i8yVXZVO0kizHqPfUVR3714mYWOvsX5J1ZGb5rNb2Lr4xm5s2Yw
	 eCRIjhI5YGiAGUo+bOQwLBY935ecXXD71tF3+cIcIlUC6UuE2NOHkcLwgGPmmTRHX9GEp
	 D/svKcM3XhIzB+2/eeGqqLdJkH74fwMTRPUNWbdJB7zcKoymGYgnvco+jXzv5ck9/tw6f
	 7kRh8IivdlN8RhUvkkLvpRILlsqf7yx2oLhgak5owmQYT8d+9Nqrb35I5U3TND4M9SrYy
	 76seD/Vrg90aKp3JX+5ZJJi2FaNMXMgRvND7W5EpPAxjh+/ZDj9LaJiVr77o3rnspjw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795068608;
	bh=hk9Hh8hLMzIKPnWjs9zWWLOoHcXWtfi8JIuScmIwntY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MbwbAOtflXGNsMyYZgXT2KttSsXDuyJ4WgDEeKCHscfgKWw6lgS3+fhhN9Ivs5Q69
	 cE9NunHrpQeFeE6njVjUP/nelqnuI/EPPYanntJNvS9pyfkSs5WRZEG0KxFLgTHA3R
	 PxencAEPpT1bK6oixalppl/e7quu7Sr0J438SVUhpbtCW4F5Q5acZXvd4O96BCD4j3
	 XwVTeAs/leYvHjPEKaSyxw9Ow1a1IIRTcPPk8h2TkZbNCrB01yvWP1oWN/GTz+rDjV
	 34AdrqLa4h0XQjcVZxxDXEq2tv92p3fY/qBWEe9OMmSSZbPBGJzM6R9vJ9NGtZLkfP
	 vxoUMu9nKZ2Iw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3246E60B02;
	Thu, 19 Nov 2026 06:10:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8E65C22B
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 06:10:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 74C414054D
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 06:10:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id F47PtAtB4AGY for <u-boot@lists.u-boot-project.org>;
 Thu, 19 Nov 2026 06:10:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A94E34054B
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=UVBvVNgP; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=ThwnWqWc
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A94E34054B
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 06:10:06 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJ1AtLE1444502
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 06:10:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 hk9Hh8hLMzIKPnWjs9zWWLOoHcXWtfi8JIuScmIwntY=; b=UVBvVNgP+gQaxFP6
 77Lo5iMQxfIn5XRQOhsJ8dglnBT72WH1WPwtTgTwqQOg3gytXFLf/z6rskui/sg5
 +FbI4SG9QI4X7nTHjZ3c+fS6mu1I9nyH0sgQBO0usOdtQOb3vNn3dMexMQEcx9eU
 VkA+VWGWAue1+UhRoR9S2qRZq7lEn1NwhIDZd64MdR/Nhu9ze6XMk3W1lFFdgARL
 JPyc2oO60FsVUFwMmgZ5IcCM6kc8iMWW8hOyPmA8zmzXG5rvsKNlDkq0Dcd5sD+b
 Llw/nx9CFjAz5VAgT9NJp83Qq0wzpbHuavE5lK9kaNCSZi39YERLmCHbnm15Cp71
 VaGf3Q==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j1e5qudpq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 06:10:05 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-3724667bc16so448963eec.1
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 22:10:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795068605; x=1795673405;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hk9Hh8hLMzIKPnWjs9zWWLOoHcXWtfi8JIuScmIwntY=;
 b=ThwnWqWc9igMde9gyKA07CE8erW+S6H2cfq8xRbSIXZGMlckEoOi+8H1h1eeEKWD7W
 0Xto3a5PWFsaM97HuADj1fDhi0JbXexujhtMV8BiKAKLwTaIzHSowCTuXFsP6V26szOc
 OVGEtkkIX0fUSIfBQ2vptR05SZMtJG4id2O9S+9x8FS0FpwEx8UviGUiNEajELQgHmi8
 VaVBZdnFg5aatpraxqeLsnbHJSLtmKxhKSSmfyEwRhtXoqRK6Gz9S04rP2CV93otr7sf
 THhYTYw2Bgd+KwQVMhAV9VOzcuNkboGO0yxLcn4QS/TGbfrEgQ2oHPfKRSLn/pe4S4DI
 pCjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795068605; x=1795673405;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hk9Hh8hLMzIKPnWjs9zWWLOoHcXWtfi8JIuScmIwntY=;
 b=L5w63TS3X+YKVPSgUNvNdmDq/bw5E08hWYcd2HTJBS5wlOiZQE52WVCSHo4GLsi2pG
 aeGttTD2gQbCoiqT0L3aJ1FcScVw87Rwi70ZJOZmIcOpqkEm4yuSWRPZpKbtNSHydNTg
 KHJthYbpMguRpGMiJN28ReOJC9rFuwepBhGX9ZNugMGRNXpCTj22W0frXdOxqu6T0LIR
 3VBJXA5yugJ3VO9/a9DuS8mdrBrg5CJe0PjjDXVcWao6ELgCUsPlrhR6HsODlN/VJ9+q
 ejvgHzgXfUVmegZGFiUEetYdiywZ0Po9MzDMOZ0NtzRc/duVRM52Yfpro/pTm41bvPPK
 8LrA==
X-Gm-Message-State: APuU4Z9Jf9OcMe81NeTi0wuzplRsY+Q2nsVqqKE+lVphN2UNWxX7cNFt
 e3i48mfG3igPEjj3JBl4jkl9m6q1EZhF8IYWGz5XAIz2b5E7PXjuiKHr2kf6G8vWUO92Bi64nB0
 9KeIaUaZ+L3zoDxSM7uEMv7MD3bQ/Ioztt4ixVxYzTe/rijm5MkSoB9Tt4uFPqvtiyF48mpk=
X-Gm-Gg: AZFdTZfjCj8XsviZBBlIpx5kL/Hus+6FGxCDCo0dpSIJTO6tVCjA5dD0kvkHPPNguAP
 uNTYFoT9Y3Azfp7TVmjN8oChKN/F5yEbLzfm4ZaJFY8RdIpHrX8ceMJIfryt64SXYFoeZRk8IxP
 1fUveYmtVPc7x7UX+hchvPepsKgj/mAVjS2A5xzkyxTricPIzq3wOO7kmIzNYrtDk5uygkSlDQc
 E81mfeKIGYDyMS2/sOPdzleiGsT3UfTkxk4iz3wiz+aIzSAVLim0JqqwoW9Qnh+XH8stLqMql1K
 Op09zI8mBolyKJlIqOyPTjzhygzM0Vd7t2WwzRVlskjxDkH9Tzz767Yzgm29xQwRILI6bzWmS6Y
 a5aFKkS6yu6kgKIJwB1XIlVPDxn1c+mWb8nRT/m768ftcM+D5lUsbUF4WDPmC/UcSXFxDq3bZFW
 PXn5hNnUls/82ah4R9EkQkPrkwbouEEe9JXHd0HV9KCL3IWsVMzNt/UpdiXD9hl1IsSQ2K//VIJ
 Kg/bA==
X-Received: by 2002:a05:7300:51f8:b0:375:85ac:d14f with SMTP id
 5a478bee46e88-384b3e786bdmr131174eec.14.1795068605337; 
 Wed, 18 Nov 2026 22:10:05 -0800 (PST)
X-Received: by 2002:a05:7300:51f8:b0:375:85ac:d14f with SMTP id
 5a478bee46e88-384b3e786bdmr131135eec.14.1795068604815; 
 Wed, 18 Nov 2026 22:10:04 -0800 (PST)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-382a72eb2f3sm15871489eec.18.2026.11.18.22.09.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 22:10:04 -0800 (PST)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Thu, 19 Nov 2026 11:39:20 +0530
Subject: [PATCH 5/5] configs: qcom_defconfig: Enable the PMIC Type-C port
 driver
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261119-qcom-pmic-typec-v1-5-d197e6d7da5a@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795068570; l=851;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=mDmaycYApEQvnXNvB3SzWtJ1FXempYVB+Mm9sZK6QTs=;
 b=tQ+WiBSTZtlb8wmyQB72qbKGln+vSeG5r0ca9aJ/mIAIo3lx7a31Kmu0H6KWwbPmpDUrOK7P6
 IXBj1+Mw+xEAp0oKLj12zyeEZwhSLemDvRuA/Zhijf5Us8dX0rZ5YEX
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-ORIG-GUID: uKcArhrCtcpKFJRgzibsQpLZN_miVyr_
X-Authority-Analysis: v=2.4 cv=c5Q+0h9l c=1 sm=1 tr=0 ts=6afe92bd cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=7txCI4ylUhOV7w6tKwcA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDAyNCBTYWx0ZWRfXxwzJp9Ob8LOw
 shj3tu/JKhL8nljrVGULfdB89vFVqh15IK2cbHbmFqSLYwe+XaGhmfOVsOqHCzNteE+SPC4RCSf
 eNHWdls4zclseDCR6jPK3fbPWqoXUnE=
X-Proofpoint-GUID: uKcArhrCtcpKFJRgzibsQpLZN_miVyr_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDAyNCBTYWx0ZWRfX4GWTXWn5Jjbd
 03cxxidy2ZK9iBHihehVaUS6zBcqFPEKRqnKGpFLP/ij7g42M5kTankbJcOjMURUW5mrEjxvbQi
 fPgM5EQhrYj0kATlAi22EOmsxih/l/xRC8/ITKvN6nQmH7un6DCkL/9vj0RYNRUXxg2MkZmdspZ
 bRjk4yton+GW102VXsAHLVGibQNSWeqf0pyKJU1YWLoiXP++Kph+DZAGRVEh94QVzbBXV99ltPi
 2dgGKWDHdu/Gfs41EjOhsDLmG1DUuBgUe66tNzVufCcFy37BdnZBxLiyhM9vdh20VlZFGnp++oE
 GoxSn4FM2Q8YRMJyAFmprFMVdiHEOrzgE6nMHHCjm792UDnBVELSxAmGdvZR6JR1TP/YAzrKePF
 RY/EMKQ+D9kCR/YZwHf7Wl748BUdJ17agFUJuLGUZm5HR6P2hYbql17pK+7fi5ohuo1Mz/wtla+
 w27u5PzrAflIOrhNVuQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_01,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 phishscore=0 priorityscore=1501 malwarescore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611190024
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

Enable the TCPM, the Qualcomm PMIC Type-C port driver and the USB VBUS
regulator it uses.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 configs/qcom_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index e5291750aa7..7d82ed48bc4 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -126,6 +126,7 @@ CONFIG_PMIC_QCOM=y
 CONFIG_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_QCOM_RPMH=y
+CONFIG_DM_REGULATOR_QCOM_USB_VBUS=y
 CONFIG_DM_RNG=y
 CONFIG_RNG_MSM=y
 CONFIG_SCSI=y
@@ -143,6 +144,8 @@ CONFIG_USB_XHCI_DWC3=y
 CONFIG_USB_DWC3=y
 CONFIG_USB_DWC3_GENERIC=y
 CONFIG_USB_GADGET=y
+CONFIG_TYPEC_TCPM=y
+CONFIG_TYPEC_QCOM_PMIC=y
 CONFIG_UFS=y
 CONFIG_UFS_QCOM=y
 CONFIG_VIDEO=y

-- 
2.34.1

