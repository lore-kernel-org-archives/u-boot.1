Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 453A4C88E72
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 07:46:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1AC7780EF9;
	Thu, 17 Sep 2026 07:46:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pRril7Z63Gw8; Thu, 17 Sep 2026 07:46:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 412BA80EEA
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789631192;
	b=Rgl71J77AQzAOhP2BhSE3tID1CHfheWMZaiUEta0flmwv/LXvOw1byfV59XxwRRJl6XH
	 ibn1ZMsYAcSPRcnYrYiUUE4ENph1SoGU4eJb+bzYD26FAUT9R/2KPk7WdBjQ4AdgRk6WE
	 0vbgdEec19yiNvHbJCoPvclopDsQ72XEGD+sHCAUl/V5bwMg/5Z0dN/M2Mm2/TCyEryY8
	 t3PXeYut9hu6UL5mab2hbJlGy369d2IdIWcREV12Dqg7vsNeeeKRmA6NT7IHfOKnkk6Ha
	 udeIfJxq8zEiihkgZDxZpEiUiDDeZTzQailVuMR3kPw+sb7dDj1q4tzkL2Mz7zeW+vQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789631192;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=APuXpy6E4Z4wscraFT43NHiLoaSuwDjGnGcOXVOw7v8=;
	b=bRUUgn5gF4q6jM5lGIu5TdDgh2K8OPitJUQ/+p2aUV2iAVl48fmzOsxb6qc/UvMMsexs
	 j2t7wiXdZKNCnswsQKA3LOrIZ7JIAkDsJE9ghOdUjOvkuykQB8Okf84gVczxJPYnDqTqg
	 qW3FkDDEKLAO6F06jHgaoxnWDdG432jk0L3wgTZHTNDDC87y2Y3Z8jAEbCqV+fGuwUmcv
	 OPBso9brsXJSGXH9jSy68Cd3S+E40m5QliYYhm5WcKVgjZlas8Fi9jbnij2K/0j88k+BO
	 0z2EybYwUiTRHaiUWkO7R9SosjPmov8qW8iyfxIkSIP3L+kD1IrMNik3Rg28OgN76RQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789631192;
	bh=APuXpy6E4Z4wscraFT43NHiLoaSuwDjGnGcOXVOw7v8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gZsaseCQ7UVGbq5ad1tT4whyq1hnZ9uQL1GmlXRjszhoVe8Ea9S/jvS9eYgz+MjPx
	 IP9ob2epzaB6TNn6448EoCve1m8cdtU/6a55EGcf+BC0pP+sczaNveuRfg+OVLY3aH
	 BQR2CUPOUJIX+SCHu+5UoXZJ05X9CXftsjGqwAfrTc4O1Jewa/5j3CDeoHFbJ54eNL
	 9BFnStgj/hNQcien/c5afW46+PT+3Ja2ha/wPj25JxonPCo7hXRuxGNpz7CmBRYnxk
	 oGTQDKx/Ua9+0iNRGe0SRZA6OJ4dC68r44cs+nrjh4/6J3z9aMN16AWo9Pmzt9PDUs
	 3lW+DmVxKSFRA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 412BA80EEA;
	Thu, 17 Sep 2026 07:46:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 35B3E2EB
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 07:46:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1B3F2407A0
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 07:46:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QaP3WW2_1TyJ for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 07:46:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 6B7564079D
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789631189;
 b=ZYQOlBh4xTock7IipJB3G4DFgUsLlyAAN4w76PxA1jrXGFlXPnLEH0id9l3fqsReEEwY
 oZv30SZxERNWWSyMtcmycrBzyMAi+65vEyRi9sPnbeVPMScwfHUP/rvkQl9v4lK83lP1a
 97jNGojUTkMCHHM3yeTa4N3xqOhFUvJR4gGzwQkFOGzxmMOoPhhAJWptB52ZQcrE37+dO
 fOAoLx5/xu9WUmjicQgTAzRNj9F9AZCUys+ytMb6m/UL+oGE3dT49c3fnqnbZSwipgW7f
 Zc2qjn/wMKh+DA0ZDhBawGAvrathz6J7+YhUCSffVcYoz81OaGdu+O959pDdQDD/jJQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789631189;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:X-Authority-Analysis:
 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=APuXpy6E4Z4wscraFT43NHiLoaSuwDjGnGcOXVOw7v8=;
 b=cR69nYAn9fiEM/TkucIYDN/mbTe+LBFakCI7kcPoxns1cKRK29PAI+/l7hpy6PZtl4ly
 tcpOFZ9/bTGxNy77mNdt50iWWYwb+Lrsb+k0XzU5ckst7vioLC008tSbdBD1eSbgtfWwa
 zUo4TRhw818D/ysagXj2d8FZ/34f8ndEXQLSq/bs4jGaWE3cvExr2eel3zjLsPmRuW8PD
 HuIu4PvAxXq+IvxAO/NIPL2Ovs9RwJar9jTAEeVKOcKPA55CFuij5qPsCmMIFGDbcX7FR
 uFgkveZw6E4ZRA82Jvi+bN+G+YjobDS6EtoDy2nDVT3Gp0sCYrKohimbqZE3U5VBIDg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=RKstdnBl; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=A0YBsnZz; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=varadarajan.narayanan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=RKstdnBl; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=A0YBsnZz
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6B7564079D
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 07:46:28 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68H60Clh1721151
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 07:46:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 APuXpy6E4Z4wscraFT43NHiLoaSuwDjGnGcOXVOw7v8=; b=RKstdnBlqOhv73VE
 bS8TR7cp7U/DE8kyMG0ptK4vVzSzjrAZYVCmwv7J9QkBA5Ub/DoTxuH+uBl6rqjM
 bCw+eSDWR4PpDXtAI0rqcPW82gPM0QnwDCKFEAeyxy1cqu3drbArMXtcOkMqtend
 aKhILtJyn18WdRkEG5CuKKwKInSFhuJzmq2dLluhGATG53KvXZUxe89O4dXvZOiZ
 dS6OWFJnuTBZ19w5swkUGcT/q+K2R0Q7DYpae8cUvyD6gSOce55E6jc8FEO7QF4x
 5RMpoQrf27B/Aud5vBbGw5Jx+EbEyLfLaM6GqSfwiZaMRwSHQ0x65/saCs5gVRlJ
 IjBAlg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gr79m14qg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 07:46:28 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2d6fed0652bso8321725ad.2
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 00:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789631188; x=1790235988;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=APuXpy6E4Z4wscraFT43NHiLoaSuwDjGnGcOXVOw7v8=;
 b=A0YBsnZzlmrgcaPGXITll5rxXxkCgi1B4mhspQCJrpQ3wuQlRiQm3frtP6gLzKdtjo
 KFH1oqbplw7EPsWNzv5j6nBlFo98lkensfgGJ5vV/0FcnS3h79/0kQLk3oEi7PFot6t0
 7ojTWXIZiQJ1zxmUsjW72LgNIw3Ml+5u8YDFFOfJ8kAO+KDmc4hv4LIQILCuGCgJiHmF
 IW6mNJBoS+FCwj+9YsxClAZFXfA+nF4wGTgfi/q4sNWXkieL5GFgk1pLguzHsYP1e+4R
 uoDlP20ND9hEJpGyTxrN5XD73BlqAswiRlk9Vx303WB4Q+zssRL4oItwhFNbViDAqBlr
 B5ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789631188; x=1790235988;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=APuXpy6E4Z4wscraFT43NHiLoaSuwDjGnGcOXVOw7v8=;
 b=nF+q7on2gj0X66OOeZ35gUYSNkyuSL05WGvuTLnpP1y2+TF3CkHOamo73ZICJnY/8D
 wor2DyOn1lpXmCXcomK1p+d56U3eMB2cwqq0cnWWn6HWhoFLOuT+Ddpuvp4gaAFS/wao
 rsVlxQsGgA7tUjUw+AOqx18PoVxaeiXPdD5eN8684F/R3cGfjfyBFG/woA5x6NKIkGBh
 dvUoij8pKu3DeOSDk8XCq1F8M594xsbvKk/S90ekraIz/7tB0wtTbJ1hlX07Wk5DTt1p
 nby0t6nSbrtWUHXzX7yx9NypWazHISEcrmWPy+Bl81QPr4R1ZYSxHsylyVzb9iEfHbcC
 BpIQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzlK9jvksZIZYKHN00elE3FpbDcZ9O+Pq/E8KLFj1PIUNXDCCWb3dMhZ1zVXQXO/pWl7YkVJAA=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mISUovcxoVixut2ee3N6BQWvs5kES5ZSMU861rBXoFRt+arYuX
 QOES8oLGM5CNfS7Upz28xQz7Njmo3pX8zn3MizNvFupc+zRXSMtH3G+eR4r+9LRgdLLZmp9ht9F
 v8K86lSBZqCe3LqUfd5LvIBRYv8RvuZJ7z+VjYHL+l/mEmhMA24Jb5MOnV0h47u1PQp5+lR4=
X-Gm-Gg: AYBFou0zZQbofR1aNtr5pir8cSLd2Gb8GkIGxDaJU9BzcxvgATHotNhYkorHNvKs+VX
 ykkBrjlkDl+Bek0hkVS9KeE3bJBNj9edQHfi5tmbMPe2LGg8gVBkdVLtE8Wv6EkfMz597qhkPDa
 y/4I3vGFx/PrfaPPKT6/ZLFkSIAwtc6AdJZPzMMjshsIfjzr83xE8bH5J1BJyWkYbDiBkWU3YMD
 4lcGK69zM44d2WDf17iUCaOuw66iimMU1USO9eMH3St5mSD5V+A/VK4GhjIRjZ3P79xP1ccpZrz
 one/OSnGzUady9lIEHvVTZK15AuQrbgT16+vNs9m/Xr6HmgLVoKk6/La6cE5lat7IcyNNKUe3S3
 7Nh43cFlc43C5mmcYdYSW/r0R+Rv/dVONyZBppFWQibsMzhES4YuvfbTnXgR9eDvwLhe6KRip10
 OH5TmqXEZgZbOFp0WyyCTy6KN1CiSX0g==
X-Received: by 2002:a17:902:da85:b0:2d9:1dee:43e3 with SMTP id
 d9443c01a7336-2dd8e6373e1mr117126575ad.18.1789631187285; 
 Thu, 17 Sep 2026 00:46:27 -0700 (PDT)
X-Received: by 2002:a17:902:da85:b0:2d9:1dee:43e3 with SMTP id
 d9443c01a7336-2dd8e6373e1mr117126165ad.18.1789631186823; 
 Thu, 17 Sep 2026 00:46:26 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf5aa1e38sm14379848eec.16.2026.09.17.00.46.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 00:46:26 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Date: Thu, 17 Sep 2026 13:15:33 +0530
Subject: [PATCH v10 04/15] mach-snapdragon: spl: Update boot device
 information in SMEM
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-spl-v10-4-3e83dcd239f0@oss.qualcomm.com>
References: <20260917-spl-v10-0-3e83dcd239f0@oss.qualcomm.com>
In-Reply-To: <20260917-spl-v10-0-3e83dcd239f0@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.u-boot-project.org,
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Anshul Dalal <anshuld@ti.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Andrew Davis <afd@ti.com>, Michael Srba <Michael.Srba@seznam.cz>,
 Alice Guo <alice.guo@nxp.com>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Lukasz Majewski <lukma@denx.de>, Luca Weiss <luca.weiss@fairphone.com>,
 Danila Tikhonov <danila@jiaxyga.com>,
 Biswapriyo Nath <nathbappai@gmail.com>,
 Vitalii Skorkin <nikroks@mainlining.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 David Wronek <david.wronek@mainlining.org>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jens Reidel <adrian@mainlining.org>, Erikas Bitovtas <xerikasxx@gmail.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=Qf7zLcbv c=1 sm=1 tr=0 ts=6aab9ad4 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=cm27Pg_UAAAA:8 a=DQyr3D7bF9Lo941LOacA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: AKb9gxZ73p2g0kgFhh6eEbXxBtWfnd99
X-Proofpoint-ORIG-GUID: AKb9gxZ73p2g0kgFhh6eEbXxBtWfnd99
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDEwNCBTYWx0ZWRfX8uEp0M1DIYGp
 TKy0hddvxjLVq960POkvDnBufsxXegjllr034hX600nER701LgD5glcWY7rq4FABCSW1BDK+1F3
 EHH7Pl5iT0Taf8Yexyo5a4/OSmppnOnsthtvdPUswdMSvPr8jb87PBI2rWRGUfU7JURnNtwlfQx
 ieNqmCAalv4a88Edh1EX/w5s5jRpt4W3W7ntkzad0qKR2j+bbKlkl6NZDbU9r1Hn485Xlnr2UZx
 f0suZsdB8/mmtOj0Svcvim7w0K6LYQWawoy+/JBxbv5hrHRa/Fqc6KBArDhn6ug48kl5qb5K31t
 mBJb3bza4QkpM8vOBPUHm8Pp/z3M/HdqjoVL0YDLxtoL5ojb1htn5mmm5bpC5y1KfvNi1RzZyH1
 mJtQckli7tBJMlikWWBfTHw/huS6DqjtuwdfEZGLV5sNeXX6my4xt7RQN3ZQqVSNMAzxDrA63CU
 V3ZomSEobA8uT6eVUeA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDEwNCBTYWx0ZWRfX1op9OksgJ43w
 YCzWYvmJ4vKTUkLeY7Drxv6Ii7vr022ExwARMWh1FC8LbHVvnJ8zjxP9aUZvmiwDO8kBqFe/qrs
 5XFUrX5PHZmBZmn6CAoj3bPDHdkSR2Y=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_01,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 phishscore=0 spamscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609170104
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Update the SMEM with the boot device information got from the boot rom.

Reviewed-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
 arch/arm/mach-snapdragon/board_spl.c | 42 ++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm/mach-snapdragon/board_spl.c b/arch/arm/mach-snapdragon/board_spl.c
index 41d8789a002..460d07ef0a3 100644
--- a/arch/arm/mach-snapdragon/board_spl.c
+++ b/arch/arm/mach-snapdragon/board_spl.c
@@ -21,3 +21,45 @@ __weak void reset_cpu(void)
 	printf("reset_cpu called, going to hang()\n");
 	hang();
 }
+
+#if IS_ENABLED(CONFIG_SPL_SMEM)
+/**
+ * qcom_spl_populate_smem() - Populate shared memory (SMEM) information.
+ * @ctx:	Pointer to the global SPL context.
+ *
+ * This function initializes and populates various SMEM items with boot-related
+ * information, such as flash type.
+ * Return: 0 on success, or a negative error code on failure.
+ */
+static int qcom_spl_populate_smem(void *ctx)
+{
+	int ret;
+	size_t size;
+	struct udevice *smem;
+	u32 *fltype;
+
+	ret = qcom_smem_init();
+	if (ret) {
+		pr_err("Failed init SMEM (%d)\n", ret);
+		return ret;
+	}
+
+	size = sizeof(u32);
+
+	fltype = (u32 *)smem_get(-1, SMEM_BOOT_FLASH_TYPE, &size);
+	if (!fltype) {
+		pr_err("Failed to get item: SMEM_BOOT_FLASH_TYPE\n");
+		return -ENOENT;
+	}
+
+	if (IS_ENABLED(CONFIG_SPL_MMC)) {
+		*fltype = SMEM_BOOT_MMC_FLASH;
+		wmb();
+		return 0;
+	}
+
+	pr_err("Boot medium not specified\n");
+
+	return -ENOENT;
+}
+#endif /* IS_ENABLED(CONFIG_SPL_SMEM) */

-- 
2.34.1

