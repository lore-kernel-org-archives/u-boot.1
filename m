Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E979606A31C
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 13:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=noCBmkVc;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WoRGck7j;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ch/V1Fh1
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DD53D607AC;
	Fri, 30 Oct 2026 13:42:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1qFHhgkpOEmo; Fri, 30 Oct 2026 13:42:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 04B6B60808
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793367731;
	b=sF3Dr6ujNhc80uEjc4Mcunumrv6w1CkHQIxMe9HLtVdn2HjbqaOIB6I3bosg1mIouS0Z
	 CNZKmjL93nJTmu1yT0bssbiqREUanBtYDfi/yLw8kWGabzb/SbgTT2H4MFJR33Oab/FDv
	 bswsExBEb309Dc9eHimr7R1wCdr/smyw/Gq0ZhEIfJkRUq3dKW1773DdjJp5EYD02plvy
	 3Kqpbgl7spI/hpaeQyyPnyQGJN5VkJb2DveKPmBvzlgkKaz5e8sdhvs0UDMra5h91P20o
	 FcVfn01YHoMp2oXcviN5L1N0pFw91RFq+LgjbQMIIzA1I197HtTyV86i0cjWPTK2lXw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793367731;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=v9k6JdBkLnrU00BaRrBCads/V+Fcz/mg/XJ36Bg7fPc=;
	b=BeQSGC72ZClkjUeYU7JXoVhjAcLCINgoAATEkxbPmxxm3UXacxBmUcwea0WNoX8hRTJL
	 giRf5Ge0vyCRFtXrtk8aDKoAYz1oSdXiyxgUQlRmIybUFs7+w0iRPcvnJfhPslKfE7hkr
	 SNVJak0UNE2SKaqn0MdCEi+gnHt7tg7iWFwEBXrk9GAg1wVhgfpIHkXw7ZqYQXMijQ+yx
	 T9EwKPje6aiQX8Sd1Hi6MLf/9nLouvhJDiZLMbq+6Alew3tY4c6wix3ZQZjgWPSg3NdO7
	 3mS1yZnSNWhKNspkhEHPhhJRq7lICNG8Rte0psf07PxfD4QsRm0Tf0+EhgRokO6qXWA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793367731;
	bh=v9k6JdBkLnrU00BaRrBCads/V+Fcz/mg/XJ36Bg7fPc=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=noCBmkVc9bgezzA0G4Z3jI+xF0kPO42BepH9Dc7RWx133vjfXvlRJAjYunMqzS+Bq
	 EccA2xdQjrZRKeta7ey9SzBBtdNXxi6UDBBBXNMNYgMqAkEZalror8PcHrz1MYG3RL
	 ttp08xbEpYmI+4VjulBvzBPrFYeuTk0n4Xf1H3br87vC8RVBYC9DsIv9vtuKbE+NLE
	 uVZ9JmLY7KaXVyzkfni7NE5xgNkihp3ff6TGEEaC5xnjs/0cbCVK6Sw5C2rrNVazob
	 heck3Hqq2vJ/7klA6+SpA0WI7Dg7dXw28JnEAY7wmHq8bv6DkfXX/XOuxi8CGLd17G
	 yoADf9D+E3FQA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 04B6B60808;
	Fri, 30 Oct 2026 13:42:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 08FAA362
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 13:42:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EEA4640AE8
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 13:42:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Yr52YKGHcJDi for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 13:42:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 645DB40AE5
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793367728;
 b=P5H/D8Hge+61R9yaTAPH3Dt6zh83d5d0NNzf4D/kGoQPIgGwhHpVzgTDjwWab2mLFn9r
 4nC6upqJDgWyfkVWFwqenE2ThQmvcdjN6UDXdYx2cAI0HDwGdutWkg5bxmYKnDZ4Udaj4
 qTMNa+y5/eF4sLd5wCWbnPo0Vk2jP91klmxf53FL3/+aR9DdaT7bL8n9XWy0DPn2QHDjC
 oXQpyJFcebdsVNwT7q+ZaPR9jBbHVAuvq/KrJzZUwS6xg6V87sYM4aY20LRGXEgxRYGGA
 cbH41mAgXFVn8tQw0fioF/HtY+DT0+kPUCsDdPsu4ZMN0oulRByw9CUFWRP+28GVoYw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793367728;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:MIME-Version:
 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=v9k6JdBkLnrU00BaRrBCads/V+Fcz/mg/XJ36Bg7fPc=;
 b=mR2ba9Za/ejXeMeZky3Pa/DFcIHqahfXwGjO34ICdP/MWYZXLpgZ+JAFmIBxLLdydvsf
 MVrChPJpZNLR/JMZBs8kSbKsRLo5liNvWpkO7o7poWiDxZZT/uYNrgKsaJPxl3hVCcfDw
 Tj22OaD33Jq/gv4E9W5QWsJrasrcVwjbPGEjv4ZyJ5D65hQ1MoD+6FnpR8fvAS38/hXZm
 HsBMnTnjXPH/Rx53lHZDmpjVGpzeXAQOrJnwQshpupFat7MLm/3eGLVB+O34MefxjvYYp
 Axp2cFy+9nHa9Vmco58v9KzEMLcXzeke2W0Ea1V+UduEOEo/lvfGFwhidTe4eLh1Rxg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=WoRGck7j; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b="ch/V1Fh1"; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=WoRGck7j; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=ch/V1Fh1
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 645DB40AE5
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 13:42:06 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UCMvgc2932618
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 13:42:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=v9k6JdBkLnrU00BaRrBCads/V+Fcz/mg/XJ
 36Bg7fPc=; b=WoRGck7jp1fSQ18A+1e7NqDMiMYdB8PSYhwkRK0cv7cnOzNmRSR
 B6gsCFRlbDs59b+Bla8//TGHkQoFDaxJ8OkoJnkcTcE8ndORVavG1ZapGmFab/H+
 EBYAnX7GkEbKg1R2TpxO3Ql2ovwv6dHGn1Ne0U5YC6mCpL+pxcYrLYs1Edp4oo4U
 htbkOSHTzcaZxpjisvuqGbA1IcmcQhy0ZK0+UHMbktyf9OY1WDttR8VnR2a911FH
 xU2M4E1CxrDCHesjytp8mJDl1WSFUfxe72Mx71SLNWf5SitjEFOfCNHGdJdTppn9
 PvzPzGPTo/GUn87EUAC+URgnLC467fTbR5w==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6qk934-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 13:42:05 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-36a26fe9521so1773189eec.1
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 06:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793367724; x=1793972524;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=v9k6JdBkLnrU00BaRrBCads/V+Fcz/mg/XJ36Bg7fPc=;
 b=ch/V1Fh1IyawAncIrmFPBl5DIO1TeujGrMFfTvuoVA2LI7Cb5LAzJZeyxSfueRk+69
 IU8Fl4eHuafw6R+vXfGSl/e6TqPhNJHDsbp+5E3TXEW+vTVLfJxGPXJsh4xcC4/a2p/W
 XN/6rN7MnXuL9/Bdq0ARAiKxQlW5zB9QO5Prqg1zFPpRkic7EYNJeYXmc/znF9hZ+v47
 lE8xN/V4fa2eGvjSAUCNRfsunRI8x6+YeWbIe+bVzUephIwPsdQesqaZemx937uDcdY1
 myhAEQtZo4jTwb47AfjsbMFSKIYeSkoo0bAd5vRL/hsEDj0S/UGjW0awkYj7BYHgFSR6
 SURg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793367724; x=1793972524;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=v9k6JdBkLnrU00BaRrBCads/V+Fcz/mg/XJ36Bg7fPc=;
 b=l7IUU03DG+3PnscBPAxWqG/VW9NuXEQTspJClhmD5rMvWcNcpe/Wi/c5PxyHhS3G7D
 Ll2IbTIJ7UjD8tbQgfCFZrq5FqMJ4ae+fzkIfFpJxFnuDUfpzYBvMULAm08x8khpOuXl
 QSNpyEy/5AtA4JCkbekwpzg+BCin/8tZKxoxkTZvMPBWLdJZDRe7N7+3K7pQP34Et4GV
 nzdk+pZW8SZIQX91leLeksjnt/DMgQtqhfRog0b+g4BBFXaqjn4tNharGIB92/JhhXEV
 vqANAH9u0dyQRVB3oU8OFuUdXWnpHIdyez6vhLJOKAGjuK93nSLzDDpa+Q7R/qwTAyMz
 S+lA==
X-Forwarded-Encrypted: i=1;
 AKwUvBygubsNCi9SykaCSXHStByoEcyMN0Mkp+HEMxvxPNmE9/0y+gwtlljMNQhNUQcGv5hKwhF5Ctg=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLeGMYL1KpIlYy6j+l2B/33peREAU1AlywbwyMqULGaYgUuFrTc
 xKCYl7rNiJ/k21S1ursDN5tWgZtzcMSUgWgFcKU1DpIjHxygcd377TyCWVmGZwTh20RYN8Qso9V
 YJwoEwQHEhFo4RvCQ03JDo0yIJZ3l3gJTgG1nLhTyUlzMgJerI5ksKZ3DzyMKnoOqWgIiDUg=
X-Gm-Gg: AYBFou0EmYa3cy7CIZk+s8ILkVBD67fUMOTzKpV6s1dfW/O2tqRvmofSOUbkETVd5IX
 srUtTIW661cRApc4CRRuLnr+GpbgeP1EdtBIINrzTmJi3iB2BiNaKiBMASo262+/Y6A0hHKXhg/
 4XIjG+Sai1Neik8ik8W4rg6Lk4YKd8pp0+X4xbjEx58fJMoICh+ElI88ECq0kOKRsEhLgZiPb57
 RfL5/wBdQEzDe4p7QpFJ2emOk//Eo5YzF7C8rikIPR46o4M1MAiOWyKpoy+LSxAAQgdrQ8yY3la
 Qq+QU4kgJT6iZ6OiK/P1WYHuO1sejYwUH04NbMaGMb9oruw7HED3GhVhTDu/pl1ixTCBHDwHtC4
 BrARCv50nDKhGsTeUZbamAVA+h5k9Thpd6VBO/nqwDMxLvgQv+tZ8qNr6e7zzOyqVq/JvUHeiX6
 kPTw/f80BjDx3vnmA2z2NDUNtOCSIXD3QTXPPBTueYnJhWDk2RNXstApYl4nowSjEqerDy
X-Received: by 2002:a05:7022:3c02:b0:196:b805:9546 with SMTP id
 a92af1059eb24-1ac5a67f996mr2585142c88.10.1793367724096; 
 Fri, 30 Oct 2026 06:42:04 -0700 (PDT)
X-Received: by 2002:a05:7022:3c02:b0:196:b805:9546 with SMTP id
 a92af1059eb24-1ac5a67f996mr2585080c88.10.1793367723459; 
 Fri, 30 Oct 2026 06:42:03 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1ac192c2e9dsm9610667c88.9.2026.10.30.06.41.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 06:42:03 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com, peng.fan@nxp.com,
 jh80.chung@samsung.com, tanmay.kathpalia@altera.com,
 balaji.selvanathan@oss.qualcomm.com, nathbappai@gmail.com,
 Michael.Srba@seznam.cz, aswin.murugan@oss.qualcomm.com,
 u-boot-qcom@groups.io, u-boot@lists.u-boot-project.org
Subject: [PATCH v3 0/2] qcom: Enable HS200/HS400 eMMC modes on Qualcomm
 platforms
Date: Fri, 30 Oct 2026 19:11:43 +0530
Message-Id: <20261030134145.2349821-1-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=KsrYSmWN c=1 sm=1 tr=0 ts=6ae49ead cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=zILQ9J64no_-qccxIzIA:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: PsOir_IKjPpxXFygr5GRZxaIaNh8C-zy
X-Proofpoint-GUID: PsOir_IKjPpxXFygr5GRZxaIaNh8C-zy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA1NCBTYWx0ZWRfX3fhFkeecqkP6
 j3j+wJ1pjkLKhbGj8dR373lzA03ngWVMu6BWfQ9ME0kO4fRDV1HbwCkewmPKzvsLqIDyI+UWCvW
 Vov8pdfEPgTUeAoc7xoYL9kmt5rmhHirBLCx1vNpRPNe00/VCQkFTe7RXKvodb4WqA3evOr/8jP
 MLL+d+yZ1VkSFVtONZsUppGTgypewxPpaqOq16D3DYjS1yh1e5/AqQvsbTHSbNtUKARzNoEWOjx
 j8k4Qu1LpsWXDCBHuIQH0DWmZYS/9fa61O91ExZDu1dz2df57HCO38ImrT/4SzrSct7JxcuI1AG
 bmSqtsc4cSJeMlq/Z04RnGzmvUkWKK0nUiVlWpo3aAmJBGbvdHp8KviWXE9fqPV1EML1DZGyZfS
 KAzIB6CNOiyTYra6+DA5dCvn4J7qKYXpuSdzSp70jes2NabZkSYqvRnJCHcltUvGoU49BgQ1Uu7
 aZovbEfALGNfkr3CeNw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA1NCBTYWx0ZWRfX1Y+JcLJOoaYX
 FvDvNE5iv52RamED77CanQ8SIqkdj869+kzCX11rLIBjGeLNCzeFe5/CLafmAB0XjZQWpwL8Czj
 DYFp94ZrG82Fo2dIEtf9+Mh9L+09SBU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300054
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,KHOP_DYNAMIC,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series adds HS200 and HS400 support for Qualcomm SDHCI controllers
by implementing the required DLL initialization, tuning, and calibration
sequences in the msm_sdhci driver.

Qualcomm SDHCI controllers were previously limited to High Speed and
DDR52 modes due to the lack of HS200 tuning and HS400 DLL calibration
support. This series enables higher-speed eMMC modes by adding the
required controller-specific programming sequences while preserving
support for the existing SDCC core variants.

Changes in v3:
- guard execute_tuning under CONFIG_MMC_SUPPORTS_TUNING to fix undefined
  reference to mmc_send_tuning when tuning is disabled in SPL builds
- Dropped the "fix max-frequency read into wrong-sized variable" patch
  from this series, as it has already been picked up.

Link to v2: https://lore.kernel.org/u-boot/20260902170559.3225833-1-aswin.murugan@oss.qualcomm.com/

Changes in v2:
- Address review feedback by simplifying tuning logic, removing dead code,
  and improving HS400 error handling.

Link to v1: https://lore.kernel.org/u-boot/20260827073325.4113071-1-aswin.murugan@oss.qualcomm.com/

Aswin Murugan (2):
  mmc: msm_sdhci: add HS200/HS400 support
  configs: qcom: enable CONFIG_MMC_HS400_SUPPORT

 configs/qcom_defconfig  |   1 +
 drivers/mmc/msm_sdhci.c | 749 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 749 insertions(+), 1 deletion(-)

-- 
2.34.1

