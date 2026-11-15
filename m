Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0BC7606A31D
	for <u-boot@archiver.kernel.org>; Sun, 15 Nov 2026 10:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=O+lnuPGU;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lQrEPyQ2;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fB4DXVQE
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3CE1960650;
	Sun, 15 Nov 2026 10:49:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sNF-Bbcbt0Lm; Sun, 15 Nov 2026 10:49:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 76A1C60634
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794739782;
	b=HwxduzSfBBa1vIDNGQtmsT9JC196Sy7BmEkUnCX7fZ4qX63Yx1+WhOwvQ6N8z9ZjGsTM
	 Ze4AoAIY4iae4SiuL6g8SRDk1tVXw60RXKl1i0Ha+uH/1rtDYj2YoHN+IxnkmnSnK9Tcv
	 2vyOB1300+hDw+Vr+Ys4mgD64hUCE1QCdxEXApFCYIkJt6ittGpkYuZ8yyNTStraaW9ZU
	 hoRCALML+BgXeSkf/s7oxSQihthqyTX7LX3liVqYXiwQKPnbo01GNsBldBK871VJTMX7B
	 ST+ySzVV65yl/Jh/MLzDmmB8bwZsyl+0VyFfgtUPEL7TXhTQoizPO7XNevENJ6P06eQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794739782;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=hmjy7DzVkhdWkPdsryNVJ94eWNDmYFAZbaskUl1e3QU=;
	b=pgzaRdTkhl5g0eiHENpzbnTDokwibUUxLTVX+X8ZdRNPpT2fVtShfzoC+6UR9mV9Vn+1
	 jMdTWA+t2jgxjGirtjWzUfrNHKxle+jnd8HiQ2L9QaKK/3VlqzQnfJr1lmhSTyNW9AubS
	 YzhSXbL1bdiSrvOAjNhUlDMmcRtneYHXYUNLYuEY7Wc0i5v2+JATpjFaZEuyEBUb+Gv4i
	 NRMCrjG7/Defv07eYMLjZnh6NLd0lfIF2DZgPfiqv7kHo/Kzh42h1FzG7GKJstSAaYPr/
	 89B9wnN/CrSJsUoTYrpqPwFcvrPkYQxrenRN3/FKEF/WSabxjjrer3b14zBqFbuohlg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794739782;
	bh=hmjy7DzVkhdWkPdsryNVJ94eWNDmYFAZbaskUl1e3QU=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=O+lnuPGUcWQxvw9xrwwRHTWudFplR18LrSqJqbpeMtwWDK5UbWfFlU9Uzqk+oPNKA
	 RM1xVmQlzJHoVM5UzDWwearZnvMtd+7DG5DQO9A5KzXZDyN+itOilC+jrd+FItJ+dN
	 oLx0MyPF18UNj7RQP1y5iZLZ69U06mMv2X3ZRvd8rcz/cR7KZ2C/AegJ2bUuCX0wPG
	 F+2mFEFGEqUweYjpPOoHuUjJquR/RWcYw2wzXWqF7D2kYohpIkbR5Rvh64VYFt3hmw
	 aMFUJd/NjT9XE1fgM2lk5ICv855MbJZp3Z48Od1Np1rIkAhVNY/0+Lj4stgtK3T/hw
	 HCpTAnDAv+Z7Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 76A1C60634;
	Sun, 15 Nov 2026 10:49:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3A08B2E5
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 10:49:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 16D71405AA
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 10:49:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QggGy_9uGh75 for <u-boot@lists.u-boot-project.org>;
 Sun, 15 Nov 2026 10:49:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org ABDBC4062C
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=lQrEPyQ2; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=fB4DXVQE
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id ABDBC4062C
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 10:49:38 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AF7w36l1655738
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 10:49:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=hmjy7DzVkhdWkPdsryNVJ9
 4eWNDmYFAZbaskUl1e3QU=; b=lQrEPyQ2MTP5nYvDAhG8bYLUTLCAwH8pG2xF6b
 moUnLKAUW4BFqDGAgI16gDbqsd7eLFIGn79xSKeT72Lu1WtaNRyu2fLf97fepWRx
 dQ/JhDxvCFPSk5deT3GWSQSC3DZrf84h2m9UahTglaEL3IyqP+QQ2rieFYFKPMxT
 NCyWY7F+K2+bpxHiK0oIENOTfOhVZM8C2kyJy15dZ0UwFci90jqu5714dtBc3tz9
 6aLTwRNnDGbs8HxWV24trt9Kpg3/1QcnUaHcYRPzEZjljhQzPiE8V0UTUXcVEA2H
 2Dea9qdc3fPwcX5ptXLAhqXAVISvumpQYkxkIB7/OSB1gF/w==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhkwaqf2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 10:49:37 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-55ba5fccc4aso21644191cf.2
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 02:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794739777; x=1795344577;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=hmjy7DzVkhdWkPdsryNVJ94eWNDmYFAZbaskUl1e3QU=;
 b=fB4DXVQERExbPotMZTGZxfJM6cGCC1CNon0v6/XuycDTdILKE0rfCkbMxJo9MKMKON
 Fc5LVrdTUT2MKa3gJJQ71ce8SdsiEouAs4PGAwNxbUmYH7M+TnCqikREvLyk4W/rrNOx
 06Fy0Bts7F2IN4M8EJHnceLMPKpfaEiFC/5ekDOaFJZ/Ca+ejqTMO4NLpD6kfOOYypzk
 1Cr5j0Q54FAn514adQOYQYf3aEjPIIm4FiwnDG/vRJB6+lPU3Cjat/Xw1Z+K5yU5dn1G
 XacPtWMBghC9iFkrbsMDZQHDAsgao5QoN1oI4U1yATCBatoHdw4W6aLGk32Oh5pBwFEW
 4GYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794739777; x=1795344577;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=hmjy7DzVkhdWkPdsryNVJ94eWNDmYFAZbaskUl1e3QU=;
 b=sKcfvZ6VmFr/o0/f+Wh63Tw9YV1uRM5gPZrmwHbsihcjMfIU+CHgJDV6VX2MiITLnD
 jtxZUGkzcY1IGHyYVLikPU+dvGdUOFkv0z/oRYTRI1AuWmo4TjIJrmwGujsNpSVzdYaP
 mB/yU4pCRlQ8/wfR1pyaXH4xQY3SYdIQHe2pDmjNW5/TxN9jPHyLs0GwRBNr11XH0fP9
 FBP+Tl+DZuFil3cNuDqqZvOl0nTinv87BS3g8Z9jCH7fSI8k+vKerLKAh2Hfcw7ZFYbr
 RBiGPCcAnVp7m1I8yM6ndaXnfSTNbGKx7W97BO4lJNZ1ZowOF099vubov/8bary9Bl6v
 b0uA==
X-Forwarded-Encrypted: i=1;
 AL+hErFg1Kc5+B/VI82aVGSck3W0tzs0GX7V3JWuSPwLpg9Nc7B1wA+SWmtXb/gWu85+UANrh7lFqH8=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/6+TsmnA+botcF7q6/R3D9u64Z+OCXYL8CONt9/8TlKvonF6nu
 LJHv/7SXVe61pqWhL35tngYdeEonI5gjPGA3J7/ZJnF+ZdB4WFcyLBgEcw/4Sj+LUleuhba10Nd
 8IGGJgwbQmid3usL1YPqWLqXDz+HNDDyDCNegzR+a22+n0ckxZCBL/slY6Rd4t/P/vnAAo/g=
X-Gm-Gg: AYBFou28EvS5bwT9pQ5oBcZHxq2+WGQV2LV56q7OLkZudEQRrxI/GMkmU1eh+zC3/85
 +qeJxtYiiTJq7naxERnY2iuJXFhEc4+roeJik8akyPbZuOnVkcV/YFqA7Nla/zRdJLcqtA4h+eO
 KMIi7BoIgcuwrmEVc0OISximGRxOCbN7M+UthjlGoReblet62/pIKvpWH440FPnvhhFHo0aqiQm
 6+haaGgnhcYbSF4lh9keVBDr4CiRTXm+0m1bpsUsfwbnFO26pp4yBrpfaFqFgcTSV8tbJz9eDWr
 XzsTt+9X3hSY9XIeSqqInQEpxyQ+/Wtj2kQWy/hxE9cAm4H9ZUJu47JK2gdV+Gl1ussGbWULnKH
 iH5qD1l8W69e91SwdTDa0B+FamyQpgteDK/+5qb7f8NEZ5haP+7Zj+xydP2oPCfohWXm1HxQQWQ
 u0K2QsUeShEJgi
X-Received: by 2002:a05:620a:2b99:b0:940:ed45:c8ea with SMTP id
 af79cd13be357-9494bbeefd3mr1253973685a.70.1794739776787; 
 Sun, 15 Nov 2026 02:49:36 -0800 (PST)
X-Received: by 2002:a05:620a:2b99:b0:940:ed45:c8ea with SMTP id
 af79cd13be357-9494bbeefd3mr1253972285a.70.1794739776386; 
 Sun, 15 Nov 2026 02:49:36 -0800 (PST)
Received: from [127.0.1.1] (93-159-22-70.cgnat.inetia.pl. [93.159.22.70])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b7c24e7714sm3099358a12.28.2026.11.15.02.49.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Nov 2026 02:49:35 -0800 (PST)
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Subject: [PATCH 0/2] qcom: geni: load the firmware on mixed minicore QUP
 wrappers
Date: Sun, 15 Nov 2026 11:49:24 +0100
Message-Id: <20261115-qcom-geni-mixed-minicore-v1-0-bce20aa8f4cf@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/xWMSwqAMAwFryJZGzDir15FXGgbNQtbbUEE8e7Gz
 cDAvPdA4iicoM8eiHxJkuBVKM/AbpNfGcWpQ1mUDRHVeNqw48pecJebndKLDZHRGTN3hZmqtib
 Q+RF50eK/Hsb3/QCdMgidagAAAA==
X-Change-ID: 20261115-qcom-geni-mixed-minicore-d99b809a4751
To: Sumit Garg <sumit.garg@kernel.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Simon Glass <sjg@chromium.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>,
 Heiko Schocher <hs@nabladev.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE1MDA0MiBTYWx0ZWRfX7JxqQF1U1KbP
 hVvjOPaja4ravM+fV8VLyjNuVIHBLAav+l01T2Qh+QEZ4K7DgDr86RDbhtWrGnDY//RPLx1+FiH
 DAqey6jLU43qFVM6nVlVRryel6IX4le6UgLOFSxADed352+DS0nrO9ia/K4EbThca78IOeEoVBM
 rR3nPUZr4QcINq8yGMTtCXKmL6peeTkhZnmXY46badS5Uk9PiDOJiMjYV/YfExvrPceGO5CMpx1
 I6Xaj/iQctiiUKFZ+ryv8myvM9b4K92ZFYIWloC7b4ECB7VcC0Y+SBxHdkniKouKvetAoaW2y9i
 Z2n3PoKPxu/MriYptsUEmaInz5wDy04/Si0Zxy+4udBJpaRiX+hMConmN6kQsAyO7Z8YiiAwdeC
 ptbL1WJa7Z8/N1zhVOzaUd5AtP5C1FGwXy9dIFhtpPI1Qpnun2cvcRCW1zjQ8tnnCFxAgyYEXoF
 QEXyfctzxMo6eTqU/tg==
X-Authority-Analysis: v=2.4 cv=YPYKWhGx c=1 sm=1 tr=0 ts=6af98e41 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=ySe+0nHqNG5yihRO1pIWsw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=cm27Pg_UAAAA:8 a=1VxDqnHFAAAA:8
 a=k-42gJp3AAAA:8 a=EUspDBNiAAAA:8 a=p-LfKV-GAAAA:8 a=ng2-Fsj6i93hMvId13gA:9
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22 a=cvBusfyB2V15izCimMoJ:22
 a=aZ5uHUMKh6B-zo3GvD48:22 a=uCSXFHLys93vLW5PjgO_:22 a=97BuGM4RKn6GwmfqMd6i:22
X-Proofpoint-GUID: mKH30WkrHpVQrY2g7xWg-NxHDR_LZGYm
X-Proofpoint-ORIG-GUID: mKH30WkrHpVQrY2g7xWg-NxHDR_LZGYm
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE1MDA0MiBTYWx0ZWRfX1QipKsid/fS4
 BlieE+90h5rU2WpLhwpdzhK9gM2MUPtA3uVgfO4tzyFQJCBd6x28KGkjXf0eV7zpVAJi4SESKSd
 fyMy/uDb6qPF4WSa6FvBmuF7ZgOb3zg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-15_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1015 spamscore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611150042
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On QCM2290 (Arduino UNO Q) the first QUP wrapper mixes serial engines
with program RAM (SE0, SE1) and minicore engines (SE2-SE5). Since the
minicore support went in, such a wrapper is treated as all-minicore,
nothing is loaded from the firmware partition and every boot prints

  i2c_geni i2c@4a80000: Invalid proto 255
  i2c_geni i2c@4a84000: Invalid proto 255
  serial_msm_geni serial@4a88000: Invalid proto 255
  serial_msm_geni serial@4a8c000: Invalid proto 255

followed by "clk_disable se failed -38" from the I2C error path.

Patch 1 uses the built-in minicore settings only when every engine of
the wrapper is a minicore and the table is built in, and otherwise
loads all engines from the firmware image, skipping the program RAM
copy for the minicore ones. Patch 2 stops the I2C driver reporting
-ENOSYS from clk_disable() as an error.

Tested on the Arduino UNO Q (QRB2210) with qupv3fw.elf in qupfw_a.
Not tested: an all-minicore wrapper (IPQ5210) and a board without the
firmware partition.

---
To: Sumit Garg <sumit.garg@kernel.org>
To: Casey Connolly <casey.connolly@linaro.org>
To: Simon Glass <sjg@chromium.org>
To: u-boot-qcom@groups.io
To: u-boot@lists.u-boot-project.org
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Cc: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Cc: Heiko Schocher <hs@nabladev.com>
Cc: Aswin Murugan <aswin.murugan@oss.qualcomm.com>

---
Igor Opaniuk (2):
      misc: qcom_geni: use the minicore settings only on all-minicore wrappers
      i2c: geni: do not report a missing clock disable operation

 drivers/i2c/geni_i2c.c   |  7 +++----
 drivers/misc/qcom_geni.c | 28 ++++++++++++++++++++++------
 2 files changed, 25 insertions(+), 10 deletions(-)
---
base-commit: 36d2b7b46c77b44021f0a6f36684a123e5560492
change-id: 20261115-qcom-geni-mixed-minicore-d99b809a4751

Best regards,
-- 
Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>

