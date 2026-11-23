Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FC9606A684
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 04:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=tI4YCDEg;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GSPjQoeQ;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Sy8+qC6C
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AD1A24064A;
	Mon, 23 Nov 2026 04:54:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kfdAwmmRryq8; Mon, 23 Nov 2026 04:53:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B5A6640642
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795409639;
	b=NQzRWVpgAZznD02DU6VdP6iJUUUAVi7whZPpTJWDb2+pMNKPl5axLVf2Nfx6K36hPH3j
	 9ZymOaWW/PGrXFGwAHe6/2s0vZnlHP/LNRo/u+I/zjjXCdiDdTJKCt7rJ6gEcTJoJE9EG
	 6qqqHIga19Hbj6FHuC7FiJAvHTBV9FZixAlD1crf18AaCMEGKFZSXUG+ilrpR88i9f6Dw
	 Iv7276F/Cl7PapDu2u+CkiNL//o/YaTy1BgdvBRtJ2YCYeub6nn/oEdeJyWLQ6oBVfqlY
	 4Wr1QdU87VqNSfmerQepqFOC02f5HixwfxJaCu5OwTgV56j7KX43CrYCU8U59+FPYaA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795409639;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=uFukcxKBvXQW4lUkrU9U6TCCt5sCVXm+eGredhnWvB4=;
	b=HNeFS4+eXyvFte5ptwQYo4F+pe7yO0/dphotmtmvm0BGG7d1eu2bLhOIwW4wWtlaqzp4
	 QB7tOIXyMKOjRumt4+BQpiXXlkDv0ETpNpIQ1/eIEAhaiMHg5s8PWWhDudInJ1YWTcfEO
	 xWcJIfG6KXnVlYQxzK5T670dK5NZq6w+4rbjqMH3wcXAn+Ktz1SZYJ1HoHN46AxMZC9ky
	 16P0os/9ISi+bP0VyW00XB+o9N9kv7FrTAZMkBmKzg3TUmxSP6LQ7ZhHDC2pzOxED11jC
	 KbbZ7QRF+KHmilzGdKDVFupytatNtzdfxsv5QlhBXuyNwEt7mNFhHeZaL7dslLHJX0Q==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795409639;
	bh=uFukcxKBvXQW4lUkrU9U6TCCt5sCVXm+eGredhnWvB4=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=tI4YCDEgQb040/PZcNVWnRKxenN5Ug6e04GrCcD0KUZfG6vYttkHXFdjfRWdaWx9u
	 oSWdro/Tm/zDzTL8K2OmNvg1Pv8jAu9jEGfhBXo3mptXUIPhyx6BNwdy07aVnPUj8+
	 lWGQAnB7NImJpmOzin+lWHlS0yk6h2UijgpCQ9LZRXQBUgTXFBDrDtGtQnmcA/f+pV
	 +EyijvObckBpz0+Vl2R+K1WgVgGPlAz/Y2TW4/V61f6IDRoJrp2eR2YEzA1RG2rALI
	 DqLzI4btPgKOJdv8Bj0cnoafAgY4w4QDSyzpnxLG9UQ/NbFeHFnYLzWt5BGD1bb/9i
	 Pa5QBswDAAc4w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B5A6640642;
	Mon, 23 Nov 2026 04:53:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 022C91AB
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 04:53:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DBC8E806F0
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 04:53:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fHkce-tkJ4rg for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 04:53:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3580D806BC
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=GSPjQoeQ; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Sy8+qC6C
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3580D806BC
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 04:53:56 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AN41wN41835400
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 04:53:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=uFukcxKBvXQW4lUkrU9U6T
 CCt5sCVXm+eGredhnWvB4=; b=GSPjQoeQFriSeUMaNzRlNYkiUawmPDvXr4uqlk
 kM2U6b/JzDH+a9mnmhf2z9rqw5l4A3ndmMyvnoce8yIcvB+DqTeX+RIK053k5U4P
 xhj6/GMvz26J0CadrBWlV82q5mcdI9VMsWpbxJTXPxF282dnolTW75d7ZPfgMtDR
 HSXCzMs3qlyAix7p1CruYAqjqSMHr/fuhokVr35OJZ8iv7gGPTGNYu9G5mqjTDP3
 RKMVfi3icYndrvrjIC7h25/AIpd1C2grXJY9AzbKIjBIca4MYQCCy9w42Nz6UmF9
 7C0fOGyHZQZfWD3/lXVVAJr910mYVjwP7lCxlFBCPjgYwaVA==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j32a6n9pc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 04:53:55 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-1b25d977b91so3090320c88.1
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 20:53:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795409634; x=1796014434;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=uFukcxKBvXQW4lUkrU9U6TCCt5sCVXm+eGredhnWvB4=;
 b=Sy8+qC6CIwi1nbNGLbPQlfuqtlvPsqrU/l1oBDvmv6HMvkt9PlJPc2roaZO1l288XC
 q8+5HHgl+VgbVcIfZ1J6EUjvlnrBauorHWIZ4DPngYFKIg1ltrBAntVlAUn67GiTK1zc
 R9vu5z9Qk73HuLvwfUCZhboCHfTyP+HiXJtD6+gHWJAQtnXE6g3ACsvfu6ccCGYIQYjQ
 U+SWg/7tvGHo5PvzDLi9M2xFCyEea3ITewZCwfdPqalPnsoQhKQVA5o5CcMNhXPTin9P
 F1keDpb8hAuGnBvPexUa7aZ7x77zhiH8T5xpldWJFsaXawbQz2HwXojVRhDf8VYj722B
 hHFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795409634; x=1796014434;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=uFukcxKBvXQW4lUkrU9U6TCCt5sCVXm+eGredhnWvB4=;
 b=d3KgIvYEolT8Am0amPoUcH1PvmqfENbO82b5G78WSJbu8g8ebycrXmKzNcmPckRMmi
 /re+7wUWl+Ia59iQRaJIDWCkf5J48dMZJ2rW53iGeEdQ5ozpuecUo1zOTGxDfI69r6RC
 oCa0qztLFpcx03uaI4zOfGqbRRGxWPYW9coTF6ERQNjqdlRu/nMrE+E8m74/gyj89nTf
 POiM/KtYAT/nIE1lvtBYW+y0Jk1hZCd0ZZ/OCxt0CT8qaB2xtQx45fVvjlGb+NCDpd7k
 hjDPpnWH/6/NnFDhl5x//KUt/L+P7qM8nNmJ3etWAgsrUFA0RYJ8FogOONR/cotqKlqj
 PIbw==
X-Gm-Message-State: APuU4Z+Q7+t7ErYk3sJ+XMSwQIuCpHBsR9RF2WWb2RflWSkKMirpWNqn
 +kgiBfDfOFIb+KpIXKEbckFI/0GBXlGGPcFO6G8FIJS58RQWN/bgk9m2folh05cRvCVBwGFeFlH
 1ghaRd4OoabpscylKtg8fr3BSHORoA9JOg+NfIJB3YRf0khNZ35hMkbhC5XSvtogD9qSvUJs=
X-Gm-Gg: AZFdTZctCgYnT1bbAvsOSV6Yg4lMo4l/Wsv06R+5+O/WMNrgEsE1I8xtu18xCWkVdvk
 4/1jx6KKxz1iRrdZphC6hMJflsyttvsfgixiaG/KIouzCBeVLpvIhsQef77OPhuHdvr8/0Q+AmU
 AjDXi2Uru8Gl5wGXCwP1mf6Wr9rxdKjhg3Sg0Z1+IUqoI+NwAeiSHjnNJ1I6+2PbL3oT4aSU2rV
 g4KZlzuE5wLKeDnjETbVw3wNsYXNUUjn290mnf+EJwmU/vHM+IuYrrS7GBdCL6txjZO9foNb/6y
 lKCCgY4bsJZiYqAsMYQC6KphXCpGnq9UoojHS/5YiL7ZZrqondQ49Jc20wkuwoAJk+1ysbRQoP4
 roOt/8CkzozzndCORmyyY5WvhmO3/syGUDc8q9dyKTOT8yXPGY+12gulkKdzPQOQvnRTFy3Hr7b
 67TEAJJs/k5BXEj3+JEWEgcRRIL9kgMSTHD7zSdHmcbxryCz52hRbT2Vz/6V8kEDbk0whPVgxpr
 Opl
X-Received: by 2002:a05:701b:2707:b0:1b3:bae1:f5f3 with SMTP id
 a92af1059eb24-1b556865260mr9519562c88.6.1795409634297; 
 Sun, 22 Nov 2026 20:53:54 -0800 (PST)
X-Received: by 2002:a05:701b:2707:b0:1b3:bae1:f5f3 with SMTP id
 a92af1059eb24-1b556865260mr9519552c88.6.1795409633807; 
 Sun, 22 Nov 2026 20:53:53 -0800 (PST)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b556847fdasm28245170c88.13.2026.11.22.20.53.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Nov 2026 20:53:53 -0800 (PST)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Subject: [PATCH v3 0/2] qcom: capsule: build fw_images[] dynamically from
 the partition table
Date: Mon, 23 Nov 2026 10:23:39 +0530
Message-Id: <20261123-qcom-capsule-dynamic-fw-images-v3-0-b665b48e0de2@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANPGA2sC/4XNTQqDMBAF4KtI1h3Jj8baVe9RukjjRANq1FRbE
 e/eKLSrgpuBN/C+txCPg0VPLtFCBpyst64NQZwioivVlgi2CJlwyiU9Mwa9dg1o1fmxRijmVjV
 Wg3mBbVSJHoyggmf0wVMqSEC6AY197wO3e8iV9U83zPvexLbvlxZH9MSAAqZ5akyWJ7k0V+d93
 I+qDr0mDodsCxP/qYxyeqjyoIozT0ympESGf9R1XT92DccKKQEAAA==
X-Change-ID: 20260811-qcom-capsule-dynamic-fw-images-f303270b2503
To: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Mario Six <mario.six@gdsys.cc>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Hem Parekh <hemparekh1596@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 James Hilliard <james.hilliard1@gmail.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795409628; l=2145;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=ssctzAm3HtXbtH9UN8xEqOra0HvImEKhMsRKWhYfb58=;
 b=JGl0w8NeXO6JvlNVwHjIM2BdDgbaUh+ObbaaJz3BQ/HZ90u5LsUFVxVLdUukvAvo6cx5CZl/k
 eBR1Ei9t2qvCd4N4z0fKi8mdBiEEOxzznKajR/GfrtlfTZcSgZqBW85
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-GUID: vTBeXBHVBOKuCZHLnVedq8Rq4cQc7ODs
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDAxOSBTYWx0ZWRfX7x0SGvoF3sdp
 Th9CJhClUWHXLiSDmJL2sWSxP4jhRf/8MBsHeh9Cr0cORuEDWK7RWWmYJIzL1sbpbRmhglJWvlZ
 L50KVImkPWyiL9cKMcTU26RGpWyMdLo=
X-Proofpoint-ORIG-GUID: vTBeXBHVBOKuCZHLnVedq8Rq4cQc7ODs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDAxOSBTYWx0ZWRfX2fjUwOlXxaVY
 km/x0RwGfI/VCAGmVAsqsxeq+ogLYzfLQQlLtT88e2jE0N5Z37rh+ssuQpSfIIOAJh72s3dLqHX
 OWU6hfx4FATCTNv94iXDH/zwsWGv+MB3d+4mITqAcg9JWP2W4Dmk+ZwbMGxAkFlcAB3IkpMKkV5
 c4AH4anGljDoIPL46+tFf9zT6wGSRaVI9mi8G+y628U9YpaVAhdMuWBMakIxaoFaHRr97qjYEhO
 r0HuisI5bnl/VvmYLz6mCodZ6RjhRrty/lq5fSpc5VYLzeYfYeZG5Xoqldl2b3NIDDMoRnKuZW5
 Z6gN6Rp2eSRScdly4qYL6a3mDkEYo1/jdQldafeC9GUIEhO6UqZ/O0YoPC+/a/pTOZhOgmo4nlD
 lm/aYOpP7FaU3w0beAMSVfWCWIOIE0YGfn163/08qwjV4OgyTGOIoJYwXNZe0Q/bq7D94P75E1l
 XSly1YDWpHpa/qzZVBg==
X-Authority-Analysis: v=2.4 cv=UbHE26SN c=1 sm=1 tr=0 ts=6b03c6e3 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=6jD4Ydafot8D7ObQGUwA:9
 a=QEXdDO2ut3YA:10 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-22_06,2026-11-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 phishscore=0 malwarescore=0 impostorscore=0
 adultscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230019
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add capsule update support for Qualcomm firmware partitions other than
U-Boot, such as xbl, tz, hyp etc.

These partitions are found dynamically from the partition table, and
the fw_images and dfu alt strings are constructed in runtime.

Since each board has a different set of firmware images, the
image_index of an image is therefore not known when the capsule is
built. So add a weak hook, efi_capsule_resolve_image_index(), that lets
a platform find the image by its type GUID instead (which complies with
the UEFI spec).

CI test: https://github.com/u-boot/u-boot/pull/1088/checks

---
Changes in v3:
- Use an unused filename for the new test capsule, Test13 was already
  the signed FIT capsule
- Link to v2: https://lore.kernel.org/r/20261020-qcom-capsule-dynamic-fw-images-v2-0-3824f7a66e1e@oss.qualcomm.com

Changes in v2:
- Drop the efi_firmware_get_dfu_alt_num() series, no longer needed
- Drop the OsIndications patch
- Add efi_capsule_resolve_image_index() and a sandbox test for it
- Assign image_index in order and look the image up by GUID
- Replace apdp with multiimgqti in the image map
- Link to v1: https://lore.kernel.org/r/20260813-qcom-capsule-dynamic-fw-images-v1-0-e595ff79496f@oss.qualcomm.com

---
Balaji Selvanathan (2):
      efi_loader: capsule: allow platforms to map a capsule to an image index
      qcom: capsule: build fw_images[] dynamically from the partition table

 arch/arm/mach-snapdragon/capsule_update.c          | 747 +++++++++++++++------
 arch/sandbox/dts/sandbox_capsule.dtsi              |  15 +
 board/sandbox/sandbox.c                            |  13 +
 doc/develop/uefi/uefi.rst                          |   5 +
 include/efi_loader.h                               |  14 +
 lib/efi_loader/efi_capsule.c                       |  14 +-
 .../test_capsule_firmware_signed_raw.py            |  27 +
 7 files changed, 610 insertions(+), 225 deletions(-)
---
base-commit: fd64f94c4404609b9abef32494396dbaaacec62c
change-id: 20260811-qcom-capsule-dynamic-fw-images-f303270b2503

Best regards,
-- 
Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

