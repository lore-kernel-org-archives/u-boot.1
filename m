Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED841606A31D
	for <u-boot@archiver.kernel.org>; Sun, 15 Nov 2026 11:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=AjzCdJqj;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=R/yFQ6Ai;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Xdfw10Vs
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B721260650;
	Sun, 15 Nov 2026 11:05:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5KqF5NgXeBQL; Sun, 15 Nov 2026 11:05:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C838A60634
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794740722;
	b=gyaVxFUcg7s1a96oc+7xcyMhXHiC5cR7Qz0M2dL0rxz1le4zo3M1xBamvRTobNkpiinV
	 xfLsR6GqEeX35Sy9GEVaxooUXXI7eEm0X9IYGdohwbZJG7yXuTe1aPvyKKM7+5BpP9Vak
	 YqFMmKfGLDqYWPpNPKisu2V9BFWkrw4jjKSL/A+k0lAsOE+9Fewf1FPwJjvo1WoW3DBsy
	 w9T934cVzBlHnEP4sTWOcSBFW24qjVUVAja4tcj8svPKR9oxemZvv3MDYY384qDBzkiZH
	 R324MrK5515COLTLSw8GUcWSHq9tGMnvAHM+GR9dF+JevuhR+7L+hhH907qjXX4N0bw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794740722;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Gm6SDgcYkuIp75mpyjCllZ20+/nkKwLJLO4SsDMhWHc=;
	b=V6L6nm5/9DFE4Czyi6LYlcIOmZcqoXXxQi6s9E3ZgpivGSzeWKWd3O8dHWtHTnjnHPNV
	 /zwPbAx86WIctkViogWK98DCes6Re9ghiTPByUfXjWwIr2lOYe0J+3I456Q0ktKhcEd5Q
	 ZqjpBxcuwPTQXi071Gji2SyvUWL8g60vz+S5NUmMN/yksWPSeH2a5puq+BvaSbKETLKsd
	 M7MoNfLR94ldct4scdDOQ/ZK3Shfx29Q9hQHsCCD4VGaZNTZbr+1siJMTBoDgf3+/ZGg1
	 6oTSLNHoPMtZx9EzcS1Xaqx5PdjxwohhJfX9d/H2X5SmYdaSCxdEegvntWwPcWv8miA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="R/yFQ6Ai";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Xdfw10Vs;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794740721;
	bh=Gm6SDgcYkuIp75mpyjCllZ20+/nkKwLJLO4SsDMhWHc=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=AjzCdJqj5nkUs9Oou9+xDggAdVE76CNyppFbApQUzVvxyf2DcGIcPsPez2B6nVNqu
	 /tF5PxibwP/6mKnTYgte5ry48SIcDpj8gC1IP8f0FfaVq35RREM+ZhHgXizrnI7s0g
	 /G21+W9uvqzSnSFFIl8TAZiUP1q+wlaqM7tPO08fqQhcsBfuirK7DuzUQuqH+Yfxxv
	 jLry6Gk2aHH9x9i+Ph69Ct5RfPDLJPonK7PO1Bl6+/83P5xoabK7+5ckoXrz3JwWaY
	 mnLVfmET6nNQKbJdfHMu4JrVY09df4Kzbejg+FKxoI1hZxCzIvlQpq6HeViZl8u8bM
	 y7+szcDsQR+zQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C838A60634;
	Sun, 15 Nov 2026 11:05:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id BB0A370B
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 11:05:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A0CAF60634
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 11:05:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6i8n80klS0fF for <u-boot@lists.u-boot-project.org>;
 Sun, 15 Nov 2026 11:05:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8FAF960628
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
 header.b=R/yFQ6Ai; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Xdfw10Vs
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8FAF960628
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 11:05:18 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AF7xFpe2338478
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 11:05:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=Gm6SDgcYkuIp75mpyjCllZ
 20+/nkKwLJLO4SsDMhWHc=; b=R/yFQ6AicyYJNVdkwfMKL2ImSFo9iYn56ldR21
 +9OBZ4hOtK+emvqvxMLx9Bld60/G7LV+yKT2sd5e9s69HKOtlkXNXmrtmkJMU6Hz
 Vted4kRZ4fYp6dei6I8ihzGHwV4a1uEfB2WuRaVwLKRFnIKY+yG4S+ZnGEC7P233
 UQ9yNyHccncDbEpRRibOr1AJX/4HcNcVojy9X6kz8Ca4W0o4i2Dl4nYRZ2/+DxAx
 hBCjRWN4K1nQM38zfgr950Nf6J3OtzIOQusme/9f7G7xMPgDkF8k8NWA54qjDVkY
 iH4pynxieYk/r78Tz+cf+KQ9qR64kGnoiSxM0RXUVqVjmTDA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhjqjutm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 11:05:17 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-375f0fd31f4so802390eec.0
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 03:05:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794740717; x=1795345517;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Gm6SDgcYkuIp75mpyjCllZ20+/nkKwLJLO4SsDMhWHc=;
 b=Xdfw10Vs+tDHjM4wnyBYHv/EZ/T3UTdEr4CtSPWonoI1kg6uNjDss/BVTstFYI9IvL
 7xWlbs3aXA2tPLC2KFtNGI38RYoM/HyObT0GPzMbHFeA2izb5zrWttcaE5iJFRyiAC4B
 fXuVacywbiJUfPw1sSooCQCphSryfGFe9Wps5UuzE1x5KrNBAjVwxJoiApYyIFfyDmBm
 Pj97JuKBtKzEnc6jeZy0vxY4lcEEgMXzw47WRLdedzXYbyLuucA/lh+MyjVwqrtyXjnX
 h29kyslkVtN7H+YSX1jgGgcX0hK7TzoMRGk2u9aPBWTuDYtsrc16FxVvTAxBGpphzuRA
 5mvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794740717; x=1795345517;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Gm6SDgcYkuIp75mpyjCllZ20+/nkKwLJLO4SsDMhWHc=;
 b=kwVzBOeHyWqFjXwtmvQOWuHhnSTkdFAlYoIePMZDM8Q1xGhGrZiNuWWr5vWm6Rn3m/
 r6Cl5DSAxl+v28qElEStsT5v0ZYpTDFchKf8nJaEYiPoER1dgHzoYu7HkbxI47NJwoe5
 Kyn6q6+Ce+ClJuSV0g45uAu4z6SkI84SJchdTyw6uBlHEvdwtozNzCi6RzxY+NdF88sA
 10xGV2/qx8DWNohHhptsmfN/8mhW/jILsv1DIHZSl4q3zSdJqmEkuwIkjrw9tZ3sIuNa
 7eZmFLRI0hnHzcIgppybUK//zX6Z9iWmEC/xo7CUjmI8GtGyTCm3RNAmpK+wm19ynnce
 JseQ==
X-Forwarded-Encrypted: i=1;
 AL+hErELtGnIuw3eW5vwooUSUhFfsP7WDoeAcKL9uqtq0PtmRU2rQs/G5psuR2P3zG2MpMR9WOudso8=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+hQfdREN7Xi3sgRPmVu4OuzfQK2off6EiHRKp4B+iZ/lvuzJFu
 3+9XqKKlFvxDaB6ZmFDvwsKgMKisaXAVPuCBu2znmmMgz6e1sWjjuGaxdf88Y73khEPpkNQsguv
 s/8YRvql+R5XDCbKCJ13UQanQp5K6m6fyUAeDp+xESwhnQCHzrwrvVgNpG7zP7UwXKy46L1o=
X-Gm-Gg: AYBFou1dlGAYKHFJEVEwfq/CJAzBaYLFpTRq45ol5ioV1gKN0U4Zn/1P8X2M4fjsTmm
 jkzxo3j7+b/MbeUFxfacH8FMzJ4JX0PymEn1/VDIstyIvyiO4WUbH6rMEP6kwxVoJdmj3ecAU8w
 8t9YNyCs9GGDaNe14Mg6p4Jmbk/oNvk8fD54IpNPP1hV+Amo2vl1kr8ulWIwqaAmUakOa8b0cIN
 aEtLjcY7JNaPHYfJ1xQKU/bTWhi8rhvNQceA5sjRKxHfGW1HC+CWseO1yVGqiVtq/kOu3SkBrib
 8FkmbGNmrMCGHjhYeKnX5A8oJDyMgERKkbsdvRmOozn117G71+ifexJvYEnRIL4uDLHgCW87NsD
 vnpVGOv1T9hcFQBBlgHmDIC5jZKoeR7hjEyGCFfXEyWUkDY3S+6Rf+jWTrNdmKxVgdfqyTISK3V
 +V4SR9bcyHHtT79HC8FxWx/PS44DiRXaWcfYjwMuXfHCHWVLTPRi6wcvZ4xaRUJ2hScWeguV4y8
 NGD
X-Received: by 2002:a05:7300:2a9a:b0:35b:cb8a:8d0e with SMTP id
 5a478bee46e88-37966e3b092mr7587384eec.16.1794740716659; 
 Sun, 15 Nov 2026 03:05:16 -0800 (PST)
X-Received: by 2002:a05:7300:2a9a:b0:35b:cb8a:8d0e with SMTP id
 5a478bee46e88-37966e3b092mr7587348eec.16.1794740716063; 
 Sun, 15 Nov 2026 03:05:16 -0800 (PST)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-379563e6b6dsm43456454eec.21.2026.11.15.03.05.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Nov 2026 03:05:15 -0800 (PST)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Subject: [PATCH v3 0/6] fastboot: block: Add GPT/MBR and device selection
Date: Sun, 15 Nov 2026 16:35:07 +0530
Message-Id: <20261115-fb_gpt-v3-0-7ddd7ef832f6@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOOR+WoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHUUlJIzE
 vPSU3UzU4B8JSMDIzMDEyNz3bSk+PSCEl0LsxTzFDNTS9OUxBQloOKCotS0zAqwQdGxtbUAuoF
 +a1gAAAA=
X-Change-ID: 20260427-fb_gpt-86d7d6595dad
To: Guillaume La Roque <glaroque@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 u-boot@lists.u-boot-project.org,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Cc: Tom Rini <trini@konsulko.com>, Carlo Caione <ccaione@baylibre.com>,
 Dmitrii Merkurev <dimorinny@google.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Julien Masson <jmasson@baylibre.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>,
 Simon Glass <sjg@chromium.org>, Sam Day <me@samcday.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Francois Berder <fberder@outlook.fr>,
 Vitor Sato Eschholz <vsatoes@baylibre.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794740710; l=3060;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=frWIcjqDnOezHxrm2ziTcX7CfDBV/2XRkca4Y+VJ5/A=;
 b=PV3PmxBQjTOTrOWxgMG/uBQCMeQi2e31iEZVAjeXUcAsoZzZm/W92bjebHpGSaAlfeOH2sqPn
 5wpG1eJ5aftDjrvS9EfPA6mcMkIz/eUycdgrx1e8wgEOwrHJe81erq7
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-ORIG-GUID: U8ZRu8gsSkqPxImBFPMxah18U3i-YVxj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE1MDA0MyBTYWx0ZWRfX4KjfpPo/oaKT
 yIj8YSYlUrakbaNMSfWqENlhfQGTVaMxSGFQe3y3Wo4SMghO6ge8qW5uEyCTrqcNP6UmTfHTBHP
 lY79FdRv2HrL+a+zbb9QkZS89u8+Xo2iKbsdZMLuqUDVBrCFEee7Qt4BkhP6VvyXz1g78ntM2nv
 yqPKt+7RnjC0Th2pbPPCQBjOaS5VFG+aQqRuNiNAuqSHJjv+BU/fev2tMpeYHkRT8ur2CuLowkA
 l0zHttKTL8Tpps6IXkVdO0NsIhTUsys0ALWot8DpdXHBK9HU0SoHvhHQH8EvFzP7Im9FwbLMFws
 N8ZHX3v9uV++XLFKAmum8iGSAPvfHrqK3Ub110qEMO9KlK0GrRKc5scya7BAATQVDxtwYz5AbDL
 MTdmacxkHw0vB/Bqll+p2UaJPIY2LbKZJrcWiXf/vTfaswIF5zg6GUp5cLLA3UPxYHoyCK7uY0z
 qE6N8LJlM1ymwrN0GjQ==
X-Authority-Analysis: v=2.4 cv=TqJzFzXh c=1 sm=1 tr=0 ts=6af991ed cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=_aTGsJdUfmxtiA1JYQUA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: U8ZRu8gsSkqPxImBFPMxah18U3i-YVxj
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE1MDA0MyBTYWx0ZWRfX/lE9TH1XtnvA
 svmTAKg9YAuolPlkxknoLGBFuscqM4CnES493/Xik5T9po1q0/aWDtp6K/1ZSMGp31p+yixXM9i
 YM23ZdR709vj6W505zMNOOZ9gJgSHUM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-15_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 phishscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611150043
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

This series adds GPT and MBR partition table flashing to the fastboot
block backend and lets the host select which device on the configured
interface to use. For example, with FASTBOOT_FLASH_BLOCK:

  fastboot flash gpt gpt.img        # GPT on the default device
  fastboot flash 1#gpt gpt.img      # GPT on device 1
  fastboot flash 1#mbr mbr.img      # MBR on device 1
  fastboot flash 1#boot boot.img    # partition "boot" on device 1
  fastboot erase 1:3                # partition 3 on device 1

A name without a device prefix, such as "fastboot flash boot boot.img",
works as before with CONFIG_FASTBOOT_FLASH_BLOCK_DEVICE_ID.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

---
Changes in v3:
- Rebase on master, which now has SPL fastboot support
- Split the blk_get_dev() NULL check fix into its own patch
- Use '#' to select a partition by name, as the rest of the disk layer
  does, and reuse part_get_info_by_dev_and_name_or_num() instead of a
  local parser. This also fixes "foo:boot" being taken as device 0
- Pass a block descriptor to the GPT/MBR helpers, so fb_mmc.c keeps
  its DEV_TYPE_UNKNOWN check, and share the validate/write code between
  them. Move them to fb_block.c
- Check the interface name and the device prefix in the block caller,
  and report an invalid prefix instead of ignoring it
- Add a sandbox test for the partition table target lookup
- Doc: use sentence case headings, cut the duplicated GPT/MBR text down
  to one example and mention erase and partition-size
- Link to v2: https://lore.kernel.org/u-boot/20260427-fb_gpt-v2-0-9e7fe3c1649a@oss.qualcomm.com/

Changes in v2:
- Separate adding device selection syntax and GPT/MBR flashing support
  into separate patches.
- Introduce common helper functions such as
  fastboot_flash_gpt_partition_table and
  fastboot_flash_mbr_partition_table functions that can be used both
  in fb_mmc.c and fb_block.c for GPT and MBR flashing.
- Link to v1: https://lore.kernel.org/u-boot/20260410-fb_block-v1-0-68f0c976fe0e@oss.qualcomm.com/

---
Balaji Selvanathan (6):
      fastboot: block: Fix NULL check on blk_get_dev() result
      fastboot: block: Add device selection syntax
      fastboot: Add GPT/MBR partition table flashing helper functions
      fastboot: block: Add GPT/MBR partition table flashing support
      test: fastboot: Add test for block partition table targets
      doc: fastboot: Document block device selection syntax

 doc/android/fastboot.rst    |  32 +++++++++
 drivers/fastboot/Kconfig    |   4 +-
 drivers/fastboot/fb_block.c | 158 +++++++++++++++++++++++++++++++++++++++++---
 drivers/fastboot/fb_mmc.c   |  45 ++-----------
 include/fb_block.h          |  52 +++++++++++++++
 test/dm/fastboot.c          |  61 +++++++++++++++++
 6 files changed, 301 insertions(+), 51 deletions(-)
---
base-commit: 6487c50b8a40f2668ab98a892b9300ad5c181f38
change-id: 20260427-fb_gpt-86d7d6595dad

Best regards,
-- 
Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

