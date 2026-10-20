Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C924F606D547
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 16:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=d0Qtgbw4;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=iqQBbM/J;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Lz3GvcFD
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A15BE40898;
	Tue, 20 Oct 2026 16:46:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5rfGpUY3rOsB; Tue, 20 Oct 2026 16:46:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6E31140761
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792514807;
	b=Cp0EB6ieOssXsEbhAp6Q4Z46Bh3Iv3xHIVWK6oMb82YqpUjR2djec4GT9tYMh9LtkX22
	 4+trk4rATZfjshIGSe+zlIRYd1b+v5ecO3OMTJes8WrFu24fTJw7KgVOuz/9E7Lrqa3Tt
	 5H0qGYO0leY069b2qPOgmYS/Bgl3s9iUQHwCM6m15yzacE2CuzHQtub8zUasUvNecmSEP
	 bafKicpJLhibNtv2leVIUDVcBSQUkaU1qzq5MosX6dxXsfsfnCfztY+zKP2RkIup4dgoz
	 1HbZ8Kcm1a0E6l4nPQ5WSOgX3G2vwczYU54vX9l6SEmYEKhCsysKIhzuUxWs1v057TA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792514807;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=LAR1X3gKZynfoVvGzd+rcaEpW63U9XsokmDCVR3h5GA=;
	b=ZRsnpc4YIv6ZeUSOfc+qw1Hiyz0NrtPHhgX0Q6oyXgcFJALB9ZlCGHcECdr2tPfqsi1q
	 qgdAYThyYWA20/baWTgwzkAasP8NJ13feT2cd8OSfFjPIHUYwXedKl9SDDigx2rV8FqGa
	 6tVxGJNleABdML9yeIeZRId/YBjBTLAbzVIyphvk/HcM8koVCxmT8k94NaU+nlgJ1a8Dk
	 eLbx0j7ZG/TaNZnn+yRfeWG2edy+BRkJjbBld4mdQr527xuQcucH4GpuN0COmNtywDfi9
	 y3oeCMhCg+efexCO7MtrZpbBXNji4cx2KTBGXf+r4FxqYRYeMofADSa1JnWAgNWe7MQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792514807;
	bh=LAR1X3gKZynfoVvGzd+rcaEpW63U9XsokmDCVR3h5GA=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=d0Qtgbw41pK0pb/b4q3vQxT7fERHdkwFu9cz56R7AfaCV3HinOcGMZtkBIFuRumMD
	 rusXyNvYvmCOJlI+ho+INHxUkA4G2MWQkPYaXReZeJ7tW3OidMNsbkuwNCVADf8lRg
	 aPS1ULWyyK34gOxuvOVX3mF2+HFrG16L6YoMu44+ikZKGnnqz37PO4M+ymvajzDpng
	 aqpZ+f4epLPP3tMHUcvl1nyymX6ZQ3lMJd/ANeAOwmmdY5cy7xCp+VZ+YtDuc9ZKit
	 iL6Bjibcc3WLJUrVtJByHggWiRiQzNRaH3ZPvB8hou5yuAGHAhuXZ8+VX9eR64E8tt
	 I+jjhYXIEMU+A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6E31140761;
	Tue, 20 Oct 2026 16:46:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id E18BC1E9
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 16:46:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C7ACD810EE
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 16:46:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aHQqDyP_kMYS for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 16:46:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 69439810E4
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792514804;
 b=h7tJvg0L7iB8FEy+9yrlUkNuSQ/ndUuiMAu0C2LIL7S06jrtRjv3O/ccBY1shawDb1vc
 PNpA2T3pAfEyAOTFkBXuW9BL5w9XIDWByBHAgOtzikOcQ3W5KsdyQpHwokiveypdmqkgt
 ETGkjLJovyqgNyKljTJ3xf/XZ5lRtd/ZtQaGn0MOEtb+s44W8JlGJubeKSoT4kJcPMNNd
 91d3T1x/2Jr0LZE8dsaTfofEKs4Su2cjaRbDB/uNBrrpOMx8boxlxFlheZOKlaGFEFLWl
 DdplM6DYpxh1VrK7sVt4+JDjrElkWGj8wpiVxvJzr2UPIsFyiWlqP2MSel2tgMPzPTA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792514804;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:From:Subject:Date:Message-Id:
 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=LAR1X3gKZynfoVvGzd+rcaEpW63U9XsokmDCVR3h5GA=;
 b=ftpTiP12MaNpqBHf/rHc0EkCIIYWgxDav7NKUEZkeH+iKl4rtT1Q2RvBIJQG9HUntzLa
 l0wPmtb+zw5oWBu7n4kS+SdZ0yr4zOLs+DeaHwhsQuWLsgUznBDHBNKvtRPRScXS+M3+2
 H4xv4b3M8z9S01NBx2rtw4YoJRx6+ui/MtJT45HAzk3JXvKG6TTXnR1CE2Y7UMY+kTxjX
 YfzN+hJB7Oh1XuDAAvggptp+/opVMT0lRfyn2qG+3Mc7/75jVs4JDc16Mq5RIuSekV3xU
 t0DzHAmwPrOLPUAYPrOTdSHBQsSCJGn0577dHuEoxwUgUlR5P8QTx/xJDugP7khUkEg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b="iqQBbM/J"; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Lz3GvcFD; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=iqQBbM/J; 
 dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Lz3GvcFD
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 69439810E4
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 16:46:43 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69KDAIwX2214624
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 16:46:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=LAR1X3gKZynfoVvGzd+rca
 EpW63U9XsokmDCVR3h5GA=; b=iqQBbM/Jhlo+TU+rEUaXeeJI/oCbC6F6KV1086
 R8GhMJH8oEQQCYY+DDrcr53B9NbOF220EzU7cy1nAHhx9RDT2CVmyXMxD/moPzCs
 lIvkdMrDbl0bmwuZdpS0nzZVZu0ol2IULmONxfltwO9qIxUMDWbdQ5MHV9SpsDQN
 HVfmwJgYnsZfDEIclQbiYfjNV7gIQukWHwnqyjqVwZrkwgdHBJd+QJXUAnNFfHhz
 XrY2h0P5EGN3XKQKzqQJAhvdv0TKybED+vfjsUvOqrmrpljtBIz2DsUQLWEZjOro
 txgDQ1A4QoR250dcWqv7HdMxA3ZpncutJYMIVMrrvoLAs7wQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdw5nudjd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 16:46:42 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-36696c9f55bso572952eec.1
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 09:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792514801; x=1793119601;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=LAR1X3gKZynfoVvGzd+rcaEpW63U9XsokmDCVR3h5GA=;
 b=Lz3GvcFD75BLD7PZknhcYAVHt8eC4jDThdfHZJmwjlsnJd2+ZvbyKYZORtjUUmPqt2
 pOpYSFXHorvQ72XnpJIPPeW/g7t9xMphrr+SL+FE9JVgFMoeSRVNCzHnLyBmpGq9wz86
 VRzyMS7XHMfek9fSEHBYkoriQSqLaxRvimmHZkw9JjRPZQGt4nZz2xshAKayWeWBvZj+
 5+H2QZw+8hB3iH7kn2Kr0CAgDrflfF3V67zcvWbZQvfyBxWJwMlBU0sxOH7Yv8VJgIFq
 p1T3oG3wUEisFiJLJbEHmvaGNeZSiFGqfZjmwEqu0ANCT9fUS7VxTW/RMX/LOsMWdSeh
 as8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792514801; x=1793119601;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=LAR1X3gKZynfoVvGzd+rcaEpW63U9XsokmDCVR3h5GA=;
 b=zuVUl3sWw1CVnc780/Sgzd/bo9+ufJB75RDZnfS7s4szy6FCvXPwU0aNCz8YEAkSf6
 z9iIjf3rDV97NuWreQLE/i47U6e72VaxUmgbv/2OmzUYnDhtjc6j9whB0lD9C+VpAlB/
 unHMuWHBq1wN9tDdIG3SXDNOu5uAvACq1AH5X/fgHUG4iLkj1/ri7O8PlHCH8HsXGAru
 3WFhvDljf68ZQoNn8i1+Aj4JwzuSqUq3n+WBG+P70nw2dLNLAPZ+6ROhxTpSOHrQJR/S
 T3gBNdTGSD796sfw0Jp/HT9I3q7x6KK+rEBkkO9unNyDY9sa2EX0w10rtPpOwUMHUJ1m
 p3yw==
X-Gm-Message-State: AFq9FYKuEiI/c076Frj5k5rsiFXKJ/opKjrODblj5v9Y7WSCEVuNNkn7
 chx1oeY4Yj/wNzh4huVexo80JuqDuJic0hH871mmbygX4DeEY20b8BJJHb1NDJVPK5zIpBsf/Mx
 Bobdgr5PKKKoqdjEeYS+BPDfVVGnOOqrj0sJRJk1SXXVyEWTC9W/7ud+UCxYtdQu/J2dU2TA=
X-Gm-Gg: AYBFou071l6FTDjbi3/2lKHnZHnY3P3yBeOSLnbai5feaTYgrMh5P9oFGErMbiRLk9r
 dcFTL/ONq6fibOjmuGJuLsXHtGY+knwluvJJ2947Bn1Qqrw+wmGBUKG4KuW1jzb5cjbdSUrcFUg
 MD/J3VXhqjXx6tHCnhfecZ5jR5v0yfyaEALkZsBTR6dvuo8W91GI5zZkPFMnRlSyvgiB/lBGxmP
 hziVyi9ATu+F7ETimYJoliNO6u2xT85GejJN1RwUlc7Q+eWhFudtIIe5meLBcsg4LX6Xhw1qFIK
 UvdIHj1rTKnr0uQJg3SXeDF7d97a4xkNcOybpVnmiJrj+eK381NMSGvXx0HYw9mdxJoIhra2jkg
 LAb3EpjXRRRLTmIxhXlRglBMOgNcqbaRLwVRYFT3N4N+j/JHM+b8SLlMILFnSCVu37tBvxmJdbU
 5omdu8Oyh2ba7+ei2/7YFZlTEvQ94=
X-Received: by 2002:a05:693c:8801:10b0:353:7f47:8168 with SMTP id
 5a478bee46e88-365fb187594mr3199851eec.17.1792514800591; 
 Tue, 20 Oct 2026 09:46:40 -0700 (PDT)
X-Received: by 2002:a05:693c:8801:10b0:353:7f47:8168 with SMTP id
 5a478bee46e88-365fb187594mr3199816eec.17.1792514799781; 
 Tue, 20 Oct 2026 09:46:39 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36632d8b273sm6318507eec.15.2026.10.20.09.46.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 09:46:39 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Subject: [PATCH v2 0/8] reset: dispatch DT-declared reset modes via the
 reboot-mode framework
Date: Tue, 20 Oct 2026 22:16:19 +0530
Message-Id: <20261020-b4-reset-edl-rebootmode-v2-0-f690da515804@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANua12oC/3WNywrCMBBFf6XM2ilJ+lBc+R/SRR5TG2gbzcSil
 P67seDSzXDPhXtmBaboieFcrBBp8ezDnEEdCrCDnm+E3mUGJVQrTlKgqTESU0JyY04mhDQFR1i
 Zo9XCVnVvNOT1PVLvX7v52mUePKcQ3/ujRX7bn1P+dS4SBSqSjXZWNq2uLoG5fDz1aMM0lflAt
 23bB905OkvFAAAA
X-Change-ID: 20260810-b4-reset-edl-rebootmode-3b7ca0c34fba
To: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Johan Jonker <jbx6244@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Biswapriyo Nath <nathbappai@gmail.com>, Simon Glass <sjg@chromium.org>,
 "Lucien.Jheng" <lucienzx159@gmail.com>,
 Michal Simek <michal.simek@amd.com>,
 Aristo Chen <aristo.chen@canonical.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>, Vincent Jardin <vjardin@free.fr>,
 Michael Srba <Michael.Srba@seznam.cz>,
 Alexey Charkov <alchark@flipper.net>, Daniel Golle <daniel@makrotopia.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792514792; l=5134;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=D1f8wCP9mSQiBKeUnVEaFKWx22Rv6akc9xXhiozcPwM=;
 b=pTJ8xpaxKhDHWJiFOG3pgcfxDMOKiarw+MOE8e+TFjPawNkiEi0YsNrK6Gze7F1kOCXZ7QGoo
 p9P36suHhPvDvMMZ2cXQJ4bPWPMl1Y5gtejiish7llHYDm5BYZw86c3
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA2NiBTYWx0ZWRfX+uW63lEktVsl
 yCdGrWU0IgepoVO7EB2hJdWq2Zew4jKc5GQpLjeznDhGP3EMS2JMtRSVSABL5bN+hwBl1Dzni2F
 DkN8k3yE+SIXt68JBlNenRM/E9ZPtRU=
X-Proofpoint-GUID: LW1kN7fFEqXA6vn47GsqsArx2YkR-wGq
X-Proofpoint-ORIG-GUID: LW1kN7fFEqXA6vn47GsqsArx2YkR-wGq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA2NiBTYWx0ZWRfX3hOmYuSoHlJx
 1LxfJ6iMIF4trsZlID2hjzOzKFRojHy3hWaqSanVSIyhhebCLvzNEyqLlz299Ec9plvrbW0OJRm
 F2OdJcOSq6nNLwOO6Dovvk0FCQvDlEf2wdEZQbKWjvLUWgt8AlviVlvfjBGVCB5fCcrfc94KB5J
 VNlgaVhuEs5B3eGywUb3ZZ97/pat+robtOrDJJfWCWSGnGQ4isU5s2Vzf/mCuFzO9lDfCkk91K8
 vgVB3jBQXYP67ZHHcpNylqZgJ0+FfCb3FK0bDxEC1s0O1xHwBKMe2EV5/9yi7fxfuWNrvAIgRdp
 WVMM204lA5veAyr2L7+/6PNhu+E8gxPClgw9S0gVnpSlD7fn2heGz20bPBLn9RS7MmjE/bJZD3E
 M13jq7yT8f+fM3Q/6EhEHR6iBH+dxw4US9O6zFixXghXAUmP28XuqGYQX9DyqrmLJ7Nqx5W3WKl
 A/MNL/SX59PSKg4Kehw==
X-Authority-Analysis: v=2.4 cv=TcsDJhQh c=1 sm=1 tr=0 ts=6ad79af2 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=gu6fZOg2AAAA:8 a=gcKerBIfJX5547E1e5MA:9
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22 a=2RSlZUUhi9gRBrsHwhhZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_02,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 impostorscore=0 suspectscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610200066
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

This series adds a way to trigger named resets (for example Qualcomm
EDL/download mode with "reset -m edl") without hardcoding any magic values
in a driver or parsing argv inside one. 

The design mirrors the Linux "PSCI reboot mode driver" work, which places
the reset descriptions in a "reboot-mode" subnode of the psci DT node. It
tracks the v24 revision of that series:

  https://lore.kernel.org/linux-pm/20260803-arm-psci-system_reset2-vendor-reboots-v24-0-889281373870@oss.qualcomm.com/

The magic layout here (up to three cells, <reset_type[, cookie_hi[,
cookie_lo]]>) follows that revision. The bindings are not yet applied
upstream, so the reboot-mode subnodes live in U-Boot-private *-u-boot.dtsi
overlays for now and can be adjusted if the binding shifts before it lands.

The path a request takes: "reset -m edl" calls
reboot_mode_request("edl"). The reboot-mode uclass matches that name
against the modes declared in the device tree and calls the backing
driver's new "trigger" op with the parsed magic cells. The PSCI driver
passes those cells to a SYSTEM_RESET2 vendor reset and the board enters
EDL. "reset -l" walks the same registered modes and lists them.

The pieces behind that: the reboot-mode uclass learns to parse up to three
magic cells per mode and gains the trigger op alongside the existing
get/set, so a backend can act on a mode rather than only read one on boot.
A thin PSCI driver, bound to the psci "reboot-mode" subnode, does the
SYSTEM_RESET2 call with no argv parsing and no hardcoded values. mode-edl
is declared on the qcs6490-rb3gen2, lemans-evk, monaco-evk, talos-evk and
shikra-{cqs,iqs}-evk boards, with the framework enabled in qcom_defconfig.

Patch 5 (the device tree change) depends on these series, which add or
change the monaco-evk, talos-evk and shikra board files it touches:

  - monaco-evk:
    https://lore.kernel.org/u-boot/20260812-b4-monaco-v2-7-865d288c0be6@oss.qualcomm.com/
  - talos-evk:
    https://lore.kernel.org/u-boot/20261020-qcom615-talos-evk-dtb-v1-1-ae2d2b48b0c7@oss.qualcomm.com/
  - shikra:
    https://marc.info/?l=u-boot&m=178668446732727&w=2

Changes in v2:
- Use "reset -m <mode>" instead of "reset -<mode>" (patches 4-6, 8)
- Handle the modes in a do_reset() wrapper in cmd/boot.c, and print the
  mode list from the command instead of the uclass (patches 2, 4, 7)
- Make REBOOT_MODE_PSCI depend on ARM64 and simplify the cookie handling
  (patch 3)
- Treat a trigger() return of 0 as an error, and make its count argument
  uint (patch 2)
- Reword the reset documentation and update its return value section
  (patch 8)
- Collect Reviewed-by tags on patches 1, 5 and 6
- Add the mode-edl node for monaco-evk, talos-evk and shikra-{cqs,iqs}-evk
  (patch 5)

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
It follows the direction Casey
suggested when the earlier sysreset "-edl" approach was reverted in
c480bbd92b32 ("drivers: sysreset: revert support for args in request"):
  - argument parsing does not belong in reset drivers;
  - the reboot-mode framework already exists for exactly this purpose, so
    the mechanism should not be qcom specific and should not hardcode the
    reset magic values in the driver;
  - the "reset" command should be able to enumerate the modes registered
    with the framework.

---
Balaji Selvanathan (8):
      reboot-mode: parse up to 3 magic cells per mode
      reboot-mode: add trigger op and request helper
      reboot-mode: add PSCI reboot-mode driver
      cmd: reset: dispatch named reset modes via the reboot-mode framework
      arm64: dts: qcom: add psci reboot-mode edl node
      configs: qcom: enable PSCI reboot-mode framework
      test: dm: reboot-mode: test trigger dispatch and mode enumeration
      doc: usage: reset: document device-tree-driven reset modes

 arch/arm/dts/lemans-evk-u-boot.dtsi      |   7 ++
 arch/arm/dts/monaco-evk-u-boot.dtsi      |   7 ++
 arch/arm/dts/qcs6490-rb3gen2-u-boot.dtsi |   7 ++
 arch/arm/dts/shikra-cqs-evk-u-boot.dtsi  |   7 ++
 arch/arm/dts/shikra-iqs-evk-u-boot.dtsi  |   7 ++
 arch/arm/dts/talos-evk-u-boot.dtsi       |  11 +++
 arch/sandbox/dts/test.dts                |   6 ++
 cmd/boot.c                               |  72 ++++++++++++++++-
 configs/qcom_defconfig                   |   2 +
 doc/usage/cmd/reset.rst                  |  49 +++++++++++-
 drivers/firmware/psci.c                  |  16 ++++
 drivers/reboot-mode/Kconfig              |  11 +++
 drivers/reboot-mode/Makefile             |   1 +
 drivers/reboot-mode/reboot-mode-psci.c   |  51 ++++++++++++
 drivers/reboot-mode/reboot-mode-uclass.c |  76 ++++++++++++++++--
 include/reboot-mode/reboot-mode.h        |  54 ++++++++++++-
 test/dm/reboot-mode.c                    | 129 ++++++++++++++++++++++++++++++-
 17 files changed, 502 insertions(+), 11 deletions(-)
---
base-commit: a1b2e1d997b66b9050427a9d91e83678a76edb76
change-id: 20260810-b4-reset-edl-rebootmode-3b7ca0c34fba

Best regards,
-- 
Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

