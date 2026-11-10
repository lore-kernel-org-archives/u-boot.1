Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFED606A31C
	for <u-boot@archiver.kernel.org>; Tue, 10 Nov 2026 11:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=suhz4IJ7;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mPM5Eb39;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=IDYxSjBW
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5A55C4061F;
	Tue, 10 Nov 2026 11:45:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xbncwa2hGVh1; Tue, 10 Nov 2026 11:45:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A803D408B6
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794311149;
	b=pBc3OpHIi/jPLYe552yJ8auljUfT4yTd5U5/8m3ZmQNjUGa8hbRDAfXr08CVGMbLVx+n
	 t7DuRs0ZPICpCU+M8gSHq6+I1J+Kty19eaV5gD7a68yQ9ZfgCzHWxO0IHdsWZb2kqL5Uf
	 5ugTZd7fG3U82yyeveIu0sH74gnQ0mJiSjqVPbcp9qAnh5e5YrQGqiav/mbvGqsnZbzHy
	 eVmPreah/+eS++Q6CPNsvAxH+uFP/GognMI/hkDFq3rg1wErNxiQH7IngGTRikxGGx6gp
	 hNs73nyNrjrXK6lGGSCDsTRWQJjpB6xkMsd3BbnJ5BWkC1q0M7PUwFxO34TjlvHxaLg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794311149;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Ml7yJ0d7urEghC/kVzLUestRGa3DlUtXCrm8aX3M3EU=;
	b=Hit0IlmNRLt789SYv6sgZGgQ968YkdGaZ3aPnExkxx4j/AKcyynIaRu3avB24Ih7UFiO
	 oflSA+bgrnSzQHCIaYCy15NO1vX07TeXTcwkeEzthTGpXnv2xAPW11LQ16U6S1Yk36m7v
	 tRFLJKalu87QzOxfYgjsnzWI/gKKKpRL+SOCN8m59bEHP3bpyDrpYdLqSZQcPR8bERIhj
	 WdtTNuEE3mkC4sjgsA3rXgZQNBtCGBrfibGuDvCUpctEPqRKsnKVgNvC9RbQSqhxBGaF3
	 aBeQHlkOyEpUztDhlbWlpkH1/ynDxMUm78aEX+IwQqFrXLXYB14q91P0frT1mO+T9uw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794311149;
	bh=Ml7yJ0d7urEghC/kVzLUestRGa3DlUtXCrm8aX3M3EU=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=suhz4IJ7kUh+oHs7kKDZGuUPQq1tYXF61ICO9D/3OueQ3oQMEKu+E6+HvxlRIgmpf
	 vAGv4UMqyJ+fNAqfB0BIyjUEimFqMlzLj14xE2nmPB8xfywDYcJHtFFqS+sAl1BI0v
	 Dut5XWhn17Ac7/nPLkXi7pTTk50IvTfgm9vgQH+wHe1qyKa333GcZQ7HVPY/fdRaKS
	 7O8Ps9c2k1QrzUB644eX5tzh6iqRjfS+yDIe8wSBuiV2MhNeQN9royJmXr8Nj5aDkS
	 mjUN+h/YWroes01Ffzvf00buOWw+C0g7STirmrn0V227nRtKK6t905tQQrOKNAsi2k
	 xS8q/iL4xuhFA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A803D408B6;
	Tue, 10 Nov 2026 11:45:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3F914CC4
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 11:45:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 311E96083E
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 11:45:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9kbXtktIBbmt for <u-boot@lists.u-boot-project.org>;
 Tue, 10 Nov 2026 11:45:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C551160668
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=mPM5Eb39; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=IDYxSjBW
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C551160668
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 11:45:46 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AAB9t9C2253399
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 11:45:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Ml7yJ0d7urE
 ghC/kVzLUestRGa3DlUtXCrm8aX3M3EU=; b=mPM5Eb39FOPMIGmW0PpX/jQHzDN
 NVQbklupA3NQdNoLFBaeEuvfhXvHcB6cDUtNVQpj5YTPqTSjCegXbCZ4BH6WhjY+
 6TbD+WTp7WWzu323n7wVIy0AHs06jt1NXScHkVZDZKX8WVua8rGpXXixzbR+5Brr
 DZlN2JMDpOFjHc189iiGMdiDuEB8tRA1t/yzmeZlJ9KmhyeE7ydvyMruBh6+6McO
 4oOvQV5Tosr0D6qsYPbakqtlNY1/gr/WRHYXwj5DuNb011mt0HQvvFKbWVnP53fR
 JAwIkXRMbpN4zOKRyvWdQ1ZkcgdYrN2ZXLxV5DuI+oAJfbL2E1iqbyHjjTQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4huyw48n9v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 11:45:45 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-30bcb065bfdso3462509eec.0
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 03:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794311145; x=1794915945;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Ml7yJ0d7urEghC/kVzLUestRGa3DlUtXCrm8aX3M3EU=;
 b=IDYxSjBWb8tqhDYi4L2IwumoqWZosOGh2l7jwmFzHbTsx5XvOqSjCit2HsTTZwrE59
 CzdF2guTJzH0vJJBWEzh4ASbyyXMK/IgyFoDQcT1gw3UyTWM+SdqIT4OFZlYXBs3q+UG
 L4KeQH64fmRLONu3V/0Ahd3kmy+rDDc7htPyL9MdD8MuPB8R+BR9A5aVlvzJROQjaXdY
 XAnjtdDnaj4wBdvggiMC4GvAYcuoX2o3nMAIl0njd/PmGdU8+bmFMN2ETH2tODOA4cKQ
 Cpb2nf8WSDZdPPgCIwIdQ5fjNuG78iN0HFDYGvp3xBCEsAOUNq7lZ0j+e1MiNx7oTXUX
 IuFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794311145; x=1794915945;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Ml7yJ0d7urEghC/kVzLUestRGa3DlUtXCrm8aX3M3EU=;
 b=qmy9IIEp6CSzHIFKkwwToy1bikLCcjYmpMEKrp1H8RdXev80YU0+aQEFJ8/cXAtlIM
 0OcSOrz37wZR3Bftmq5Dc0FZ8rbppP0okFSBO9fmElwmu78AYU01eDVBrsuYUd9RYaRM
 pPAHs6OJfBXYvQJwN9Zpk3YneBZM9gPSw1yUA29NthR42jOlhOT8z1OPAxkzS28Zr4b2
 f1m52e0nLc0uEqNZtcIHTKnAhDmQ9XZyeaGEfflUria9wwRJs71U8ti8hUBCTnAUshxI
 5+ecG6QbO4/CcTrShe3COvQvc5lWDSOl/xgd2emZU7ig6XGzURWqeLusXEK/pgy3/XRB
 d7CA==
X-Forwarded-Encrypted: i=1;
 AL+hErG2AbND95uSJDRTCslFxp1QU+vP3ef3kYyBFjPcVjDqBAWgLgcbfh9rQ4C/JfnlAabVrfw/U68=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8/kEVQaDK5TCeJQNrbZACJfwkTcYl078Gmfk6rXk/Tyd5RcR+l
 oZOOcfTH46sWMbXkdJP5+Nv1x83QVgOFaEmpWD+0kV2UbT7rJq3z08LMdzOvQo2PLzu7ogvZrhD
 CvVe43ayxZES5yfOhDMIddgPJ2IxkJ8r46A+kzT1ySDioer0aDaQqG85nu3dF6epnWVxZDhyx+7
 2xQK0=
X-Gm-Gg: AYBFou2aYq22ItTPIrg84WZRNo1aCgCjhCS+je6lHCHfliz8ylHuWiTWZgKS9n2HyGx
 OqMv3Bhmksp7PXK/rHTIt5AQFvR/YQfAgeytwXR/BgcyP7mRYMnSL/ip3qANKZkoCTWBKg+O5ft
 No8oRjSdXFTHL5ihmF7Ca1kNSALaSoptXC6UASEd5gwTn1OCWsWzL5zx7T/35dISXAVsPofOj14
 tpli+u1p7tDyL/rqFWND5VZqNIrOO2HLXrpWQtBFX8MgpXkRuxe31X6D3kmCqhffB4zW4AQnrcs
 4+6M+klhpDsyAEFVpWv5QG0MpXst5gMrQ/RFLCeI4FZWUXW8GevCBXsA1QeKFSBf00XdcHapboF
 IEjhak+VL5q++0n3Smnw6pIEoUJmONNbDeCnX7pVMaXqvkJzHwhFXsTiSe0Mj2CSN55ljBGx1zg
 eiT7Oouj3zcipYaGX4c3Ji2f/dw16JZTOmaSchu4HI5ibCkcyG5hWtM/mKDVVQJw7FCb86
X-Received: by 2002:a05:7301:618e:10b0:370:1e50:a485 with SMTP id
 5a478bee46e88-3752011f48fmr2849301eec.37.1794311144346; 
 Tue, 10 Nov 2026 03:45:44 -0800 (PST)
X-Received: by 2002:a05:7301:618e:10b0:370:1e50:a485 with SMTP id
 5a478bee46e88-3752011f48fmr2849260eec.37.1794311143681; 
 Tue, 10 Nov 2026 03:45:43 -0800 (PST)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-37520bf3e18sm11828890eec.16.2026.11.10.03.45.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 03:45:43 -0800 (PST)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com, peng.fan@nxp.com,
 jh80.chung@samsung.com, tanmay.kathpalia@altera.com,
 aswin.murugan@oss.qualcomm.com, nathbappai@gmail.com,
 balaji.selvanathan@oss.qualcomm.com, Michael.Srba@seznam.cz,
 u-boot-qcom@groups.io, u-boot@lists.u-boot-project.org
Subject: [PATCH v4 3/4] mmc: msm_sdhci: add HS400 DDR/SDC4 DLL calibration
Date: Tue, 10 Nov 2026 17:15:19 +0530
Message-Id: <20261110114520.229480-4-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261110114520.229480-1-aswin.murugan@oss.qualcomm.com>
References: <20261110114520.229480-1-aswin.murugan@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDA0NiBTYWx0ZWRfX5PmrUUlus/UO
 cAK7vrtLBIR6lMJbyz9+d8mBFusTFIxzH9JmTtlZth1MVn/mpSQO9rj3OXrLljn6oJzv4JLNcI6
 r4oLqk5O8K2ABQQ/iy8XqyPVjWOMVtaeDAiDmU8st8vVUM2wTMkZu/QhB8KiaFLfjB+25sxt52d
 2knvy40qQkWfFVPZ+HzQwIZ+Q1X9V/Zq+hw7YtMPf/eB3CEEL24YBEGj/723yUohZjf5p2CsUYV
 swWv2dSen+1xAJR+lSojqIk7eBMv9MfWukF4qDWQ0I9CV1Re8hEe0YJMbVvRr2N1NN/2+9wzUkt
 /VBODbrTP/6LTgVmfRkhaRMiIK4yGfQ2H4/EjiY6R2zhT7ypgyRo8CjpfmUIpNaHpgBqT0JUHWI
 OIgNqSnRZFDN10c3Tir9n2HXaqlWGN1U5xKz2RzueU+4d0SY1oqJrUHsT/hRC9gDGi/mKHUViUs
 H9gAuHTLS4fhRKRCR1Q==
X-Authority-Analysis: v=2.4 cv=Ee1d0/mC c=1 sm=1 tr=0 ts=6af303e9 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=sM-x5haXdwywgm3JVD8A:9 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDA0NiBTYWx0ZWRfXxDumwPK2f8m6
 ym7Q3e3Al6hk8inU2oAwh1UeDhlN6siTnKunzLizZG9yAMcemqdwHDSXyBPc21PeCuCeN/otqSu
 A+NxMjMGnq766GkmnLpFYyC4MfNrWD0=
X-Proofpoint-GUID: kfejrwkH06kVzW3mU6YbW0EDRds7GzAU
X-Proofpoint-ORIG-GUID: kfejrwkH06kVzW3mU6YbW0EDRds7GzAU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_04,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 suspectscore=0 clxscore=1015 adultscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100046
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

Add the SDC4 CM_DLL based DDR calibration sequence required for
HS400, along with the HC_MCLK_SEL/HC_SELECT_IN mode switching needed
to move the data path into HS400 timing once calibration completes.
An optional qcom,ddr-config DT property can override the DDR
configuration POR value.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 drivers/mmc/msm_sdhci.c | 266 +++++++++++++++++++++++++++++++++++++++-
 drivers/mmc/msm_sdhci.h |  26 ++++
 2 files changed, 291 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/msm_sdhci.c b/drivers/mmc/msm_sdhci.c
index 23c06e8d15e..b7e0c1e2b58 100644
--- a/drivers/mmc/msm_sdhci.c
+++ b/drivers/mmc/msm_sdhci.c
@@ -340,6 +340,107 @@ static int msm_init_cm_dll(struct sdhci_host *host)
 	return 0;
 }
 
+/*
+ * HS400 DDR calibration via SDC4 CM_DLL, used when use_cdclp533 is false
+ * (core_minor >= 0x34).
+ */
+static int sdhci_msm_cm_dll_sdc4_calibration(struct sdhci_host *host)
+{
+	struct udevice *dev = host->mmc->dev;
+	struct msm_sdhc *priv = dev_get_priv(dev);
+	const struct msm_sdhc_variant_info *var_info =
+		(void *)dev_get_driver_data(dev);
+	u32 config, ddr_cfg_offset, wait_cnt;
+	int ret;
+
+	/*
+	 * core_ddr_config defaults to the desired configuration on reset;
+	 * reprogram the POR value in case an earlier bootloader stage
+	 * modified it.
+	 */
+	if (priv->updated_ddr_cfg)
+		ddr_cfg_offset = var_info->core_ddr_config;
+	else
+		ddr_cfg_offset = var_info->core_ddr_config_old;
+	writel(priv->ddr_config, host->ioaddr + ddr_cfg_offset);
+
+	config = readl(host->ioaddr + var_info->core_ddr_200_cfg);
+	config &= ~CORE_CMDIN_RCLK_EN;
+	writel(config, host->ioaddr + var_info->core_ddr_200_cfg);
+
+	config = readl(host->ioaddr + var_info->core_dll_config_2);
+	config |= CORE_DDR_CAL_EN;
+	writel(config, host->ioaddr + var_info->core_dll_config_2);
+
+	ret = -ETIMEDOUT;
+	wait_cnt = 100;
+	while (wait_cnt--) {
+		if (readl(host->ioaddr + var_info->core_dll_status) &
+		    CORE_DDR_DLL_LOCK) {
+			ret = 0;
+			break;
+		}
+		udelay(10);
+	}
+
+	if (ret) {
+		printf("%s: CM_DLL_SDC4 calibration was not completed\n",
+		       host->name);
+		return ret;
+	}
+
+	/*
+	 * Skip CORE_PWRSAVE_DLL for the 14lpp DLL reset variant: it cannot
+	 * guarantee the MCLK-gating timing PWRSAVE_DLL depends on.
+	 */
+	if (!priv->use_14lpp_dll_reset) {
+		config = readl(host->ioaddr + var_info->core_vendor_spec3);
+		config |= CORE_PWRSAVE_DLL;
+		writel(config, host->ioaddr + var_info->core_vendor_spec3);
+	}
+
+	return 0;
+}
+
+/*
+ * HS400 DLL calibration, performed once when transitioning into HS400 at
+ * clock > 100MHz.
+ */
+static int sdhci_msm_hs400_dll_calibration(struct sdhci_host *host)
+{
+	struct udevice *dev = host->mmc->dev;
+	struct msm_sdhc *priv = dev_get_priv(dev);
+	const struct msm_sdhc_variant_info *var_info =
+		(void *)dev_get_driver_data(dev);
+	u32 config;
+	int ret;
+
+	ret = msm_init_cm_dll(host);
+	if (ret)
+		return ret;
+
+	/* Restore the phase found during HS200 tuning */
+	ret = msm_config_cm_dll_phase(host, priv->saved_tuning_phase);
+	if (ret)
+		return ret;
+
+	config = readl(host->ioaddr + var_info->core_dll_config);
+	config |= CORE_CMD_DAT_TRACK_SEL;
+	writel(config, host->ioaddr + var_info->core_dll_config);
+
+	/*
+	 * use_cdclp533 only applies to legacy SDCC (core_minor < 0x34); our
+	 * supported targets always use the SDC4 calibration path.
+	 */
+	if (priv->use_cdclp533) {
+		printf("%s: CDCLP533 HS400 calibration path is not implemented\n",
+		       host->name);
+		return -EOPNOTSUPP;
+	}
+
+	return sdhci_msm_cm_dll_sdc4_calibration(host);
+}
+
 static int msm_find_most_appropriate_phase(struct sdhci_host *host,
 					   u8 *phase_table,
 					   u8 total_phases)
@@ -496,9 +597,130 @@ retry:
 }
 #endif
 
+/*
+ * Configure HC mode selection. On the first HS400 transition,
+ * calibration_done is still false, so the HS400 mux-select bits are
+ * deferred until calibration completes in msm_sdhci_config_dll(); see
+ * sdhci_msm_hs400_select_in().
+ */
+static void sdhci_msm_hc_select_mode(struct sdhci_host *host)
+{
+	struct mmc *mmc = host->mmc;
+	struct udevice *dev = mmc->dev;
+	struct msm_sdhc *priv = dev_get_priv(dev);
+	const struct msm_sdhc_variant_info *var_info =
+		(void *)dev_get_driver_data(dev);
+	bool is_hs400 = mmc->selected_mode == MMC_HS_400;
+	u32 config;
+
+	config = readl(host->ioaddr + var_info->core_vendor_spec);
+	config &= ~CORE_HC_MCLK_SEL_MASK;
+
+	if (mmc->selected_mode == MMC_HS_200)
+		config |= CORE_HC_MCLK_SEL_DFLT;
+	else if (is_hs400)
+		config |= CORE_HC_MCLK_SEL_HS400;
+	else
+		config |= CORE_HC_MCLK_SEL_DFLT;
+
+	writel(config, host->ioaddr + var_info->core_vendor_spec);
+
+	if (is_hs400) {
+		if (priv->calibration_done) {
+			config = readl(host->ioaddr + var_info->core_vendor_spec);
+			config |= CORE_HC_SELECT_IN_HS400;
+			config |= CORE_HC_SELECT_IN_EN;
+			writel(config, host->ioaddr + var_info->core_vendor_spec);
+		}
+	} else {
+		/*
+		 * Clear these bits for every non-HS400 mode so a previous
+		 * HS400 attempt never leaves them stuck set.
+		 */
+		if (!priv->use_cdclp533) {
+			config = readl(host->ioaddr + var_info->core_vendor_spec3);
+			config &= ~CORE_PWRSAVE_DLL;
+			writel(config, host->ioaddr + var_info->core_vendor_spec3);
+		}
+
+		config = readl(host->ioaddr + var_info->core_vendor_spec);
+		config &= ~CORE_HC_SELECT_IN_EN;
+		config &= ~CORE_HC_SELECT_IN_MASK;
+		writel(config, host->ioaddr + var_info->core_vendor_spec);
+	}
+}
+
+/*
+ * Selects HS400 in the HC_SELECT_IN mux. Must only be called after
+ * sdhci_msm_hs400_dll_calibration() succeeds.
+ */
+static void sdhci_msm_hs400_select_in(struct sdhci_host *host)
+{
+	struct udevice *dev = host->mmc->dev;
+	const struct msm_sdhc_variant_info *var_info =
+		(void *)dev_get_driver_data(dev);
+	u32 config;
+
+	config = readl(host->ioaddr + var_info->core_vendor_spec);
+	config |= CORE_HC_SELECT_IN_HS400;
+	config |= CORE_HC_SELECT_IN_EN;
+	writel(config, host->ioaddr + var_info->core_vendor_spec);
+}
+
+static void sdhci_msm_set_control_reg(struct sdhci_host *host)
+{
+	struct mmc *mmc = host->mmc;
+	struct udevice *dev = mmc->dev;
+	struct msm_sdhc *priv = dev_get_priv(dev);
+	const struct msm_sdhc_variant_info *var_info =
+		(void *)dev_get_driver_data(dev);
+	u32 config;
+
+	/*
+	 * This controller has no HOST_CONTROL2 encoding for HS400. Keep the
+	 * UHS field at SDR104 (same as HS200) for HS400 too; the data path
+	 * is switched to HS400 timing via the vendor-specific
+	 * CORE_HC_MCLK_SEL/CORE_HC_SELECT_IN bits instead.
+	 */
+	sdhci_set_voltage(host);
+	if (mmc->selected_mode == MMC_HS_400) {
+		u32 ctrl2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
+
+		ctrl2 &= ~SDHCI_CTRL_UHS_MASK;
+		ctrl2 |= SDHCI_CTRL_UHS_SDR104;
+		sdhci_writew(host, ctrl2, SDHCI_HOST_CONTROL2);
+	} else {
+		sdhci_set_uhs_timing(host);
+	}
+
+	sdhci_msm_hc_select_mode(host);
+
+	/*
+	 * Below 100MHz the feedback clock must be provided without the DLL,
+	 * so tuning can be skipped.
+	 */
+	if (mmc->clock && mmc->clock <= CORE_FREQ_100MHZ) {
+		if (mmc->selected_mode == MMC_HS_200 ||
+		    mmc->selected_mode == MMC_HS_400) {
+			config = readl(host->ioaddr + var_info->core_dll_config);
+			config |= CORE_DLL_RST;
+			writel(config, host->ioaddr + var_info->core_dll_config);
+
+			config = readl(host->ioaddr + var_info->core_dll_config);
+			config |= CORE_DLL_PDN;
+			writel(config, host->ioaddr + var_info->core_dll_config);
+
+			/* Calibration must be redone once the clock returns to HS400 speed. */
+			priv->calibration_done = false;
+		}
+	}
+}
+
 static int msm_sdhci_config_dll(struct sdhci_host *host, u32 clock, bool enable)
 {
 	struct udevice *dev = mmc_to_dev(host->mmc);
+	struct mmc *mmc = host->mmc;
+	struct msm_sdhc *priv = dev_get_priv(dev);
 	const struct msm_sdhc_variant_info *var_info = (void *)dev_get_driver_data(dev);
 	u32 config;
 
@@ -519,12 +741,32 @@ static int msm_sdhci_config_dll(struct sdhci_host *host, u32 clock, bool enable)
 		writel(config, host->ioaddr + var_info->core_dll_config);
 	}
 
+	/*
+	 * HS400 requires a dedicated DDR/SDC4 DLL calibration step, performed
+	 * once per calibration cycle once the clock is running above 100MHz.
+	 */
+	if (enable && clock > MHZ(100) &&
+	    mmc->selected_mode == MMC_HS_400 && priv->tuning_done &&
+	    !priv->calibration_done) {
+		int ret = sdhci_msm_hs400_dll_calibration(host);
+
+		if (!ret) {
+			priv->calibration_done = true;
+			/* Safe to switch the data-path mux into HS400 timing now. */
+			sdhci_msm_hs400_select_in(host);
+		} else {
+			printf("%s: Failed to calibrate DLL for HS400 mode (%d)\n",
+			       host->name, ret);
+			return ret;
+		}
+	}
+
 	return 0;
 }
 
 struct sdhci_ops msm_sdhci_ops = {
 	.config_dll = &msm_sdhci_config_dll,
-	.set_control_reg = &sdhci_set_control_reg,
+	.set_control_reg = &sdhci_msm_set_control_reg,
 #if CONFIG_IS_ENABLED(MMC_SUPPORTS_TUNING)
 	.platform_execute_tuning = &sdhci_msm_execute_tuning,
 #endif
@@ -596,8 +838,17 @@ static int msm_sdc_probe(struct udevice *dev)
 	if (core_major == 1 && core_minor >= 0x71)
 		prv->uses_tassadar_dll = true;
 
+	if (core_major == 1 && core_minor < 0x34)
+		prv->use_cdclp533 = true;
+
+	if (core_major == 1 && core_minor >= 0x49)
+		prv->updated_ddr_cfg = true;
+
 	dev_read_u32(dev, "qcom,dll-config", &prv->dll_config);
 
+	if (dev_read_u32(dev, "qcom,ddr-config", &prv->ddr_config))
+		prv->ddr_config = DDR_CONFIG_POR_VAL;
+
 	/*
 	 * Support for some capabilities is not advertised by newer
 	 * controller versions and must be explicitly enabled.
@@ -692,6 +943,11 @@ static const struct msm_sdhc_variant_info msm_sdhc_mci_var = {
 	.core_dll_config_2 = 0x1b4,
 	.core_vendor_spec = 0x10c,
 	.core_vendor_spec_capabilities0 = 0x11c,
+
+	.core_ddr_200_cfg = 0x184,
+	.core_vendor_spec3 = 0x1b0,
+	.core_ddr_config_old = 0x1b8,
+	.core_ddr_config = 0x1bc,
 };
 
 static const struct msm_sdhc_variant_info msm_sdhc_v5_var = {
@@ -704,6 +960,14 @@ static const struct msm_sdhc_variant_info msm_sdhc_v5_var = {
 	.core_dll_usr_ctl = 0x388,
 	.core_vendor_spec = 0x20c,
 	.core_vendor_spec_capabilities0 = 0x21c,
+
+	.core_ddr_200_cfg = 0x224,
+	.core_vendor_spec3 = 0x250,
+	.core_ddr_config = 0x25c,
+	/*
+	 * core_ddr_config_old not present on V5 - updated_ddr_cfg is
+	 * effectively always true here since V5 implies core_minor >= 0x49
+	 */
 };
 
 static const struct udevice_id msm_mmc_ids[] = {
diff --git a/drivers/mmc/msm_sdhci.h b/drivers/mmc/msm_sdhci.h
index 337b73577c2..af42295fb79 100644
--- a/drivers/mmc/msm_sdhci.h
+++ b/drivers/mmc/msm_sdhci.h
@@ -59,6 +59,21 @@
 
 #define CORE_CLK_PWRSAVE	BIT(1)
 
+/* Timing mode selection */
+#define CORE_HC_MCLK_SEL_DFLT	(2 << 8)
+#define CORE_HC_MCLK_SEL_HS400	(3 << 8)
+#define CORE_HC_MCLK_SEL_MASK	(3 << 8)
+#define CORE_HC_SELECT_IN_EN	BIT(18)
+#define CORE_HC_SELECT_IN_HS400	(6 << 19)
+#define CORE_HC_SELECT_IN_MASK	(7 << 19)
+
+/* HS400 DDR/SDC4 DLL calibration, needed alongside the SDR CM_DLL above */
+#define CORE_DDR_CAL_EN		BIT(0)
+#define CORE_DDR_DLL_LOCK	BIT(11)
+#define CORE_PWRSAVE_DLL	BIT(3)
+#define CORE_CMDIN_RCLK_EN	BIT(1)
+#define DDR_CONFIG_POR_VAL	0x80040873
+
 #define CORE_FREQ_100MHZ	(100 * 1000000)
 #define MAX_PHASES		16
 
@@ -84,6 +99,11 @@ struct msm_sdhc {
 	u32 dll_config;		/* qcom,dll-config DT override, 0 if absent */
 	bool use_14lpp_dll_reset;	/* core_minor >= 0x42 */
 	bool uses_tassadar_dll;		/* core_minor >= 0x71 */
+
+	/* HS400 support */
+	bool use_cdclp533;		/* core_minor < 0x34, legacy calibration path */
+	bool updated_ddr_cfg;		/* core_minor >= 0x49 */
+	u32 ddr_config;			/* qcom,ddr-config DT override, else POR value */
 };
 
 struct msm_sdhc_variant_info {
@@ -96,6 +116,12 @@ struct msm_sdhc_variant_info {
 	u32 core_dll_usr_ctl; /* Present on SDCC5.1 onwards */
 	u32 core_vendor_spec;
 	u32 core_vendor_spec_capabilities0;
+
+	/* HS400 DDR/SDC4 calibration registers */
+	u32 core_ddr_200_cfg;
+	u32 core_vendor_spec3;
+	u32 core_ddr_config_old; /* Applicable to sdcc minor ver < 0x49; 0 if N/A */
+	u32 core_ddr_config;
 };
 
 #endif /* __MSM_SDHCI_H__ */
-- 
2.34.1

