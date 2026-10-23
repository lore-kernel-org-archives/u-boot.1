Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D020606A31A
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 09:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=WR/t4Bps;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jQYU2juf;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Su4hlBK7
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 735A060666;
	Fri, 23 Oct 2026 09:47:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XuZHDW_xt_oP; Fri, 23 Oct 2026 09:47:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 618F760648
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792748846;
	b=IHsG1E9Nm3b17HYeWl7Om1dfLylZj16Jjcmo1k46SDbKpIDuW6erMT68oM/N5836DNiT
	 oarjRwNrpBKl+iDhhcAg0o/C6A4xEBgTQoDWOyclUd7TjcdOtGB36l5wdNVrnl0+CldAi
	 CZzJ2/PsqNJcgji7tKJvHkEzW3S/Ys9yDy+dSH3Z3PLHbo/oXLJrYiyRzBWSSU8en6xnb
	 hT7343EXK2RhBHIDPvGLO9ywr1j4Y7vHVpRiHokml1mdbFsNAh/M/SixD6nTefdzqaS4f
	 340NSzD03EFxx+K9/A0HyZiOSAV7Oy+5qXoNpOViA28lM4PvlawOF0DMV8Qea+lYIOA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792748846;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=JvnNxnTYZLWfQOftFlJVyAwV9ZNp9Wpp38cfXS3sBVM=;
	b=N7AJatnZfxfAHEOOnqso1SUmhdPc8WA6ygz5I1j7ahLUgS+CXO7/XwZQ9RupB4bvuMyX
	 lLDLwEWHRq2xLOKuNSxL83rt+KVyRz2G0ney3l8zHrGkW2m+Ww0WIGUpkoefWGZGU5aoJ
	 f0HCidu56Wq/jdhvCp9Yr3oNkzcNDnBq3nL1EAcL/Q4b2H+mw+XeTkuCVME6Wq4C5LzY9
	 wlVr+S8yFqAuL709klVawk3C/OlQzikhnpKPRBG10rwvvBdOZD3byJZEqUjgs47soHkVH
	 ETu/ENLZ0QUJMNbAcGdknjDpol9qirUzQosq1oRVXan5lVTcNYTXdoxiSLhDjpZpbvg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jQYU2juf;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Su4hlBK7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792748846;
	bh=JvnNxnTYZLWfQOftFlJVyAwV9ZNp9Wpp38cfXS3sBVM=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=WR/t4BpsQCf9lzKZX08jntEcp9c9i5fNP1xsj09EbdK+V81pf27/Aap/i9xN6Lh4D
	 dEWdAqr7zsmDOt5t8y4smr2pFI8HaDQFH7ThJnmpqeYQ2bAz6OymVYrLb9ZgwkoY44
	 8wdtfGVVe5IXZkQASh2dfF4pytPzm84iCLC6I69rT87eZK/rKY6CmK4P0NiSMJGFtN
	 kAxXdj+OLqaV4aoe6UMN3w/9TLJ8YGdAAnjO7778MOkKye7KYvEmIhxKahJqIRHrMu
	 k/gxifq0nZpknL6alcjeU57pdfSCP3kOvjPlaCDhF4sPJk6BtihL1B9va+DuKYnaZz
	 0cdbZGd3SXHzw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 618F760648;
	Fri, 23 Oct 2026 09:47:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id F04533C1
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 09:47:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D6EB56062A
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 09:47:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id re7SECi3jcNy for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 09:47:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B7FAF60648
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792748844;
 b=MI9GCvnbErac2gutbbi8gSenYeaQuP5+Ot7YFmtjodMsJ7nV1LIAFEiLc1rtAcZdysmt
 qC06Vrphl5SKVyZLQ9UdiwLucgPhnZgpA9+MpfREoybX1KbIUXfYkhXWxB56oDCURhGAL
 DltYvlaZhUG5jxLCN95Md2P3fieohFSiMWegdSOknNpDkvSIIsrQPli0qRhnoU5aXBuMa
 3g38G+yfPz419EplDjRakf8xkU7I4tWm26uOmhuyzdZA0TI3jHtubF6Vnmx+bZhh2X/S8
 TzajBwu99hkzD69X7tye5Uaq6wgNviByaenj41GuYr2woBPBIPTp9ysbuI5oJ8SoU4w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792748844;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:From:Subject:Date:Message-Id:
 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=JvnNxnTYZLWfQOftFlJVyAwV9ZNp9Wpp38cfXS3sBVM=;
 b=A40EK/MpTKy3r8ygxfcW9QWa9GSFD8KG7xZpT5KQ0vQLb/1Ycipve4JLHffI56Ng8JGW
 LiH6gRsGJR32h0gL+36UdpYvm7DdCs/Fws4wNVmnBZ96aAnaLD9JwV11hAXQjYbEyYdHk
 pUBV2FEwjJQsBZeHgxSg/eJenwyOLOjnjwPc7NZ4m2Jp3FOtM3myWAl4siDm+3S2WztMh
 aL0ytiHW/Ya2J7FoevaZulUtxOLKh/WOJJJgOiilbIfTVqDNACOymwivfduyujoX9HEPt
 VGR2CnEuyRsCQQaFe450CI633cF9u5+yedeuRMbtroeO7TH4LLso30KH7Z1NVW6x2qA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=jQYU2juf; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Su4hlBK7; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=vandhiadevan.karunamoorthy@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=jQYU2juf; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Su4hlBK7
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B7FAF60648
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 09:47:23 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69N7FK6c2069713
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 09:47:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=JvnNxnTYZLWfQOftFlJVyA
 wV9ZNp9Wpp38cfXS3sBVM=; b=jQYU2jufJ1j0cN/s2/rJPUUlhYH7AojFIdLicn
 keDeXRr1DFm9Bcgqp6Q0S6iWz4jntiA7bQDXTLs/v4QtHIPKvtZ4hRYok9GGBsyC
 mUxmE8jI9R6xF4QPi1YwQQ2hL7GRmpagff8QzVvJXWTlSV8iJiga5sjAw0FUPNqv
 Gnt+qX4eP3hSmfgkpSHUtllJdu5IJE83E8M7Zd1XEWu8onRWUnp0cUR+Gt3zIopi
 Uq0yA2Bz2FC6oDl4Ah6qUcQTCGnACr67ijERQfMt55POPA6T4BrsJf8/vCnfzORd
 ZH/wR3OJ1D0D7Nk9g9vxSiVtOQV9usHHbaB+B4g7Xqpid4jg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfnyw3j5t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 09:47:22 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-35cbea41088so1040746eec.1
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 02:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792748841; x=1793353641;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=JvnNxnTYZLWfQOftFlJVyAwV9ZNp9Wpp38cfXS3sBVM=;
 b=Su4hlBK7QjIvwgLf/rrfrjYnz8Eh2jn7VWgKjgvo5RAmmCF4YVLBQtNUTNHYOpHAma
 6YYi3eBqPl1SVbLc41JEYEH48Hhs7Af/I2Rg4P67/JlajZgcHDaVF0rwl/hjg7A5vRNt
 8qFZuWAXrDvmy+n+ik1gPrtlH8GvrDt4+NTsUHlarA0nWl0VEhR2VAEJifBmClM4FkZn
 MA/ICAyIwhYc5McxvQkiIDsopDPAU3EBeOe/8HvUMQVghFoohBX7ZMDuIwZzh+i24Vj3
 NEp9QPqlnWSPVUKmzGn7BJXPDD8mQboiLi/eRrgt2cZQjK1PbNbgK0FzOtcjBJbsYSb8
 EoeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792748841; x=1793353641;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=JvnNxnTYZLWfQOftFlJVyAwV9ZNp9Wpp38cfXS3sBVM=;
 b=IcCM44pdcYMRVW9Z4Mla6+Te0prZ9EereeYht2IhGfRSOegr+M2NvbEVZW3TS6bKjn
 MJ+VrEvkEtbtppwXbS0uNcCQ1Osi5474wohIAkjEjoeuEXkqrV/rQii7+r3xznzu6BTI
 4mVs4L9tGr98bcarZG1sSMI2sX+DBac+jJbCN7n6SJomHF3wDi0ayIOPKvR7ZqOlxMPC
 Y41jc45YioBRLqoayOTnBRMp/ajQUVRGVLtMp3KG+Y/tf3fibiMwvDFGwCrHpGjBd6rN
 DHG0Qjjsw0ytoVtFTb6+w8FSuNpDjv2cwH2MSOLZ7FcR2mFMmlVcldHwBXo0ZUTkIrMU
 AJNg==
X-Gm-Message-State: AFq9FYJO9Ri0UZPbCpUP3brwy02GehNCkftvdFj1YER7sqqCDW44px6o
 T1hCYhNjeQI+0q72EZFGusJFqd4QLRGsPoHnSuFrTOFZmE2590hBoO/MRdH4o5yUtsegOFXKLps
 KnPcHYEYQ9Xlx7CFg/DwIa+/9QKiEcrNNHOSfcONUxiwVmnR9jCo62engioC9FhYJbj3Pzto=
X-Gm-Gg: AYBFou2BzJ56xiO+BWiMk3WaVSwyTgiuDoqU/yOah7HfVCC2bZ8WnjVVYVVgxzuxXw/
 XVYX0SBW+uCpoOtTe7GulVWXv4QECu+ST8UzSuf1efGVPeFMzBeYEAW704C72JhdaJpw/FyVOXO
 HxaVvEs7kT66rEUHrPQlFtE3iHsZg1HU/L9CLI6KWVbXCF9S+cTpeLxKaLG9r3ccukfJVh/nDEb
 6UsZy2ldIPxPLQ5Hz+Lovb3Xis5fhXTgCvKPgXqkP4X2IqJAZpg1w8gUmIh6P/AmITblB67ZXT3
 srZbpcB4iGM2hhMQbhxmQHhpgGZrnrcY4vwHum3ZiZdmDCe/xdcwfC+BHZvXxdbKzy/0oZuqDfn
 Z1boFJEu+CdSvu1ikzSFwtL2npgsFBB7WTSZKxnncv8UuGIGWCOtcB3P7UHJfq/hlah9lLs0HiR
 tL045JDdIZheOHkvS99Zzpxuw4KH3wn0CbWLkeCUE=
X-Received: by 2002:a05:7300:828a:b0:35c:6ffd:e91b with SMTP id
 5a478bee46e88-369d98ed509mr2057020eec.40.1792748840821; 
 Fri, 23 Oct 2026 02:47:20 -0700 (PDT)
X-Received: by 2002:a05:7300:828a:b0:35c:6ffd:e91b with SMTP id
 5a478bee46e88-369d98ed509mr2056979eec.40.1792748840109; 
 Fri, 23 Oct 2026 02:47:20 -0700 (PDT)
Received: from hu-vkarunam-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-369d9d892b1sm6071291eec.10.2026.10.23.02.47.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 02:47:19 -0700 (PDT)
From: Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>
Subject: [PATCH v2 0/4] mtd: spi: Expose SPI-NOR as a GPT-capable MTD block
 device
Date: Fri, 23 Oct 2026 15:17:14 +0530
Message-Id: <20261023-series1-spinor-mtd-gpt-v2-0-5d29d32c1289@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACIt22oC/3WNQQ6DIBBFr2JYdwxQ1Oqq92hcAKLSVLEMmjbGu
 xd13c0kL3nz30rQeGuQVMlKvFksWjdG4JeE6F6OnQHbRCac8pzeuIDTZ4CTHZ2HITTQTQH0NS+
 FViVrZUHi8+RNaz/H8KM+GWf1NDrsa7vRWwzOf4/ywnbvjJSs+BdZGFBoaJ5JpXQhMnF3iOl7l
 i/thiGNh9Tbtv0AN4gHzdUAAAA=
X-Change-ID: 20260824-series1-spinor-mtd-gpt-c3694cb91fa7
To: u-boot@lists.u-boot-project.org,
 Takahiro Kuwano <takahiro.kuwano@infineon.com>
Cc: Tom Rini <trini@konsulko.com>, Vignesh R <vigneshr@ti.com>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Anurag Dutta <a-dutta@ti.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Udit Kumar <u-kumar1@ti.com>,
 Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792748836; l=3149;
 i=vandhiadevan.karunamoorthy@oss.qualcomm.com; s=20260817;
 h=from:subject:message-id; bh=urIqo8re/W5jkkonSCgiSjjEngdstHiOWAv/7P78W0Y=;
 b=Hc7cdEykP1nNkkKBOG1PWZHZlsfsFZ5D6t7nVNI5e7lFyEMO08TEOsIxd32hF7OH5VRcWfMfv
 xeoVfC7olSsAd8DDcDUCxw2q/kQjwIe64hIA0RDRP+Am7x4u6UCNR78
X-Developer-Key: i=vandhiadevan.karunamoorthy@oss.qualcomm.com; a=ed25519;
 pk=2EVV7DmKqYX4wxSlXPB5QBt44JjomLlz/wTW2AL4H6I=
X-Proofpoint-GUID: kEnvFSJll9KycOlwX-BNlHn1I0qIn9b9
X-Proofpoint-ORIG-GUID: kEnvFSJll9KycOlwX-BNlHn1I0qIn9b9
X-Authority-Analysis: v=2.4 cv=dphOmFg4 c=1 sm=1 tr=0 ts=6adb2d2a cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=1VxDqnHFAAAA:8 a=bUQKSiCPAAAA:8
 a=k-42gJp3AAAA:8 a=sozttTNsAAAA:8 a=20KFwNOVAAAA:8 a=KKAkSRfTAAAA:8
 a=iP-xVBlJAAAA:8 a=97gw6yebQYLqw7axXMUA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22 a=FO4_E8m0qiDe52t0p3_H:22 a=aZ5uHUMKh6B-zo3GvD48:22
 a=-fHZXUhsFbuwFN3fwQAr:22 a=uCSXFHLys93vLW5PjgO_:22 a=cvBusfyB2V15izCimMoJ:22
 a=lHLH-nfn2y1bM_0xSXwp:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDAzOCBTYWx0ZWRfX6gmNwMwvDqhl
 iUOG9hVjeSQLfqDGnd/AzLdFmLm+kQnaGIAyl2VgokpgOYEU55YnlTJnJ0OWeTc/Ehb45uWipYw
 /nRwcJQ8dn3a0wdl4KdxGV3Wlw7dLYQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDAzOCBTYWx0ZWRfX03Rj/u6YWsLU
 CjW+WZN5JFTOZLVNo1uTELNpfa9q4nXLMzw8Pl8d/v3v2iW5Gqt1G6jvt2OCeG4tZsY+FEzXccD
 hWQEv+AyRXR11vjM4vXuPdJIsUfOzCZWn+P/sNP2o55ACkyn0f3uihEvj+BzgzsbmzqJSy8x6FZ
 I4g5JCcYaC0Lmcx9GtWQoj/Vy+KdB+I87J7YBbQ6W0QrsI1qTsshoaSb+gPaU3kbtzCGJ///KE1
 rs0NlJFP6IT3hBYkeunHgJJ1ANmTH6LF1FsmXt4E/W/JOpaWoluldA7KX8EbytGzANxwWBOdpc2
 ar8fPEWZRw32nnb0ZhrNL3qvxvw/jKANAknpG0+5axbRAi6so9hVV0LXvGm+IYrODawVtDWh+3Z
 11DD6jT1uSBK3wUxpBIHElytm8fI9VfwcawAZKH5aD20UO5U0piDu3EKxweW7JR/ktW9a87oeFo
 vwIjnV1g6dOTVb9l6UQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 clxscore=1015 impostorscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230038
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

This series lets SPI-NOR flash be exposed through the existing MTD
block (UCLASS_MTD) device, so it can be partitioned with a standard
GPT/MBR table and addressed like any other block device (e.g. by
fastboot, "part", or "gpt" commands), instead of requiring the
mtdparts= command-line partitioning scheme.

Patch 1 is a standalone bugfix: mtd_blk_probe() never set
bdesc->lba, so any MTD-backed block device reported zero blocks and
could not be scanned for a partition table. This affects all MTD
block devices, not just SPI-NOR.

Patch 2 wires sf_probe.c to bind the SPI-NOR device into the MTD
block subsystem via the existing mtd_bind() (no signature change),
using a fixed 4 KB logical block size (new CONFIG_MTD_BLOCK_SIZE
Kconfig value) instead of mtd_bind()'s 512-byte default, matching the
sector size GPT images are generated with.

Patch 3 fixes blk_get_devnum_by_uclass_idname() so a block device
whose declared uclass_id (UCLASS_MTD, set by mtd_bind()) differs
from its parent's uclass (UCLASS_SPI_FLASH) can still be looked up by
interface name -- required for the "mtd" interface to work at all
via the generic block lookup helpers.

Patch 4 is a standalone bugfix found while validating this series:
part_init() takes a fast path when a block device's part_type is
already cached (e.g. PART_TYPE_MTD from a prior probe), so a GPT
written via fastboot to a previously-probed SPI-NOR block device
kept reporting the stale MTD type instead of switching to EFI. Force
re-detection after writing a new GPT so the device is recognized
correctly on the next partition lookup.

No existing API signatures are changed and no new Kconfig-gated
behavior is introduced for devices that don't opt in.

---
To: u-boot@lists.u-boot-project.org
To: Takahiro Kuwano <takahiro.kuwano@infineon.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Vignesh R <vigneshr@ti.com>
Cc: Javier Martinez Canillas <javierm@redhat.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Anurag Dutta <a-dutta@ti.com>
Cc: Michael Trimarchi <michael@amarulasolutions.com>
Cc: Udit Kumar <u-kumar1@ti.com>
Signed-off-by: Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>

---
Changes in v2:
- Rebase on main
- Link to v1: https://patch.msgid.link/20260917-series1-spinor-mtd-gpt-v1-0-d065abbc7454@oss.qualcomm.com

---
Vandhiadevan Karunamoorthy (4):
      mtd: mtdblock: fix lba not being set on MTD block devices
      mtd: spi: sf_probe: bind SPI-NOR into MTD block subsystem
      blk: uclass: dispatch UCLASS_MTD lookups by block descriptor
      disk: part_efi: force partition re-detection after GPT write

 disk/part_efi.c            |  2 ++
 drivers/block/blk-uclass.c |  3 +++
 drivers/mtd/Kconfig        |  9 +++++++++
 drivers/mtd/mtdblock.c     |  2 ++
 drivers/mtd/spi/sf_probe.c | 35 +++++++++++++++++++++++++++++++++++
 5 files changed, 51 insertions(+)
---
base-commit: acc808479730e13e74199119eb9b2b9113999244
change-id: 20260824-series1-spinor-mtd-gpt-c3694cb91fa7

Best regards,
--  
Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>

