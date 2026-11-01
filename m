Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5103606A324
	for <u-boot@archiver.kernel.org>; Sun,  1 Nov 2026 10:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=cs0xJ5vK;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=QoD2IWFq;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KlgiD48i
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A26DF80DC5;
	Sun,  1 Nov 2026 10:19:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9MIMGVrqWqOn; Sun,  1 Nov 2026 10:19:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8DD6F80D6F
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793528381;
	b=AuX3O0aIMYCsRrS0jVkEHYYPNPZhUwnLkeSxlM1MqogXz7weRLyXFisUVOx5m5htCPSK
	 GaGRJcVc9/IALk6XXXD5/AytKVp2rKDCXsQRQa5Wxs49xIIIHU5H87uKq9Nj8WJBjQJby
	 dOjEf0Guq9IfMjrE81pAJixoPAMDyReQoWGzVBW6wtXUbp4R9Vlr2Tio2hh8TcC3IXtGN
	 SivMkSBTFLXaz++/C2lMcYh2VwCGK7vIHHoRvdweag5PqF8y0rOOblLZJHCItluKc3dE9
	 xdeaaG86vZ40nnZf/U1NzzxKBju4xDw0U0iVZUH7AmVy7V54UoawCPbvrPt6i71Oyew==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793528381;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=oQlloc51IgyeLrN5lQugwBlPOV1VmbAeX4l7iibVGcU=;
	b=YsI/x9FuaG5uErL0wKoo6eVl0j8a8R+xKWKSNz+ylnvTIlyAS6WcpqJst3YlaxpFkeiX
	 gugz2K6gE1j4/J8bzrVWE9wjOO7s7XCAWUbBUHcRBBEVMVMAxhdaVnm4A8URy6pNeAYOn
	 BmfoKsYpSni4ybLelpM1B6djtwZmR704w/PhaPpebUayIpv4wK15uCCCrkpUEnSWI7MKX
	 G8ykMoFkXEEycIcYz3wpXDA5aTh8qwycpCXvcVLbTOW4WwSsgdaZr5tjFuzxvbB++cFoI
	 LmWSJVXMPV0o5QGzo4QM0lIRFEULffXFt5wZ7cKPNq0wvgpRB4HF9lfHpnLC/oGqdWA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793528381;
	bh=oQlloc51IgyeLrN5lQugwBlPOV1VmbAeX4l7iibVGcU=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=cs0xJ5vKfJpCYOCfyMvOS4poC/XFfIfKpF6A9Iy6jRalayylhVphk5HdaakbFYqSS
	 1nsiRxEKwxwlGert01z2nN++rs5KrAnq75Rw90/ADhLDtFgD3NLBBPlJFanJ4SGqes
	 K32k+qjoYyZaoWgdz1mTO/gIvjKmNfvvphWI2M7AJ9m6QHjY0uOhJk754SHz+8ZIWg
	 +2+Uwc6oU6u90g7x5nYFcy2HaF0ei7Cb1h9kBTh9iGtdtK9dZNcbO3ymmFrMrRtUUf
	 3n2fwTCcKLLDhTXWFPZT57SRwyRaqQzhW7nnOjpd6g72yidad9sGRW3hnc9F+WGafG
	 ELGjGX3YrGXJA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8DD6F80D6F;
	Sun,  1 Nov 2026 10:19:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2534E2AC
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 10:19:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1714F4004D
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 10:19:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id x-cgiX4wFaG1 for <u-boot@lists.u-boot-project.org>;
 Sun,  1 Nov 2026 10:19:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 427A340042
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793528379;
 b=Y0rehbYIOQgXg4+u5AI1w5tUErS4DqIcmMx6/MokAepONbV/ckQopXjjVmtTPlKrsoVw
 PTrm8K2Db8oGQK3ZXfIn+Ibp7BLJihbpkaDpGPJNChbLE9CnLQ/+qnQtbi1bp9ZSi+Xyn
 KgzuPBGyXGk/gl9DMXpNNAARfYfT5F4QJGwbnILEaAhCsHDawJDKTgA/CmlUBB7gjiE0Y
 JL9lyh8KJP82hOL8Wfs7kSMei9eLwlpLWO5aMNxjMHzE+UFl4julV/adeso0CmQes7ngu
 YRnxLZT50OsQumqB6zheXMXRkihYF0q9HtwEwmKYuQ7L5OdRUkt9nYNv4rzrAy+zv3g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793528379;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:From:Subject:Date:Message-Id:
 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
 X-Authority-Analysis:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=oQlloc51IgyeLrN5lQugwBlPOV1VmbAeX4l7iibVGcU=;
 b=Uc6x6H5/EhSsqmGfhcPq0+c5ttzVUSsmrLRFbN+kQF8N4Ylh0Tb0K0Fz+rHYLUSxv5s4
 Ick+pmPg3jQF+TJDY15AiQKZIO4tZzbijE8GP4/X2Nlm70KlTvwm/2V51pjbvRdAP0ZFg
 tkMBhRdDldDKbxt5SpTFXAyVmu3XovUh3/YUAtaW/SsFJKXyuzAoDZFjSgoOvEOJ6XhJo
 9du/7fivuw4lyMRUoAjXyzAPAz2A8CC9xfDxKGxj2es3xg0CyLzr1TNQn1pFFiDP55Hyu
 o54QHGqzKEhF3ScZsuqSRH5kJ6/HsaOgJPolJSkDeoCzxxSn6EAWz5t9qHqg2O+d6Cg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=QoD2IWFq; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=KlgiD48i; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=QoD2IWFq; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=KlgiD48i
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 427A340042
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 10:19:37 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A18K2ZG3570528
 for <u-boot@lists.u-boot-project.org>; Sun, 1 Nov 2026 10:19:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=oQlloc51IgyeLrN5lQugwB
 lPOV1VmbAeX4l7iibVGcU=; b=QoD2IWFqXxNd7Xwgyisiqx03WBbb9EXMACV7bI
 PbARyHAZjyYJJjTFHUuvtPujLM5opzmeFhRtYaCnSwuOOYFAUlpERY2aciFNo8c0
 yVrDKVUzfFS6Y5WY65LjnjAtb3Qjzw+pj+T6ytomicHaLr0DO0e2w7q8GiPWJ1x+
 V2+74gUkqs4gPE52EpwJlIrKLLR1SEf0sHcSpD2qtiSkzJ11VHyKkMb6FrujeDGl
 QhWinq+X4C9iAySpi0KTZLoB++K/jgks0zrG97TdCddRRZ5nypMQcrVzs8KQMhnC
 EuyxT05+2KWDLLGaRDMR60o+0cP8Y2hb7LOib8pYLdm8ioLQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn9m9axgp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Sun, 01 Nov 2026 10:19:37 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-30c0d568830so4244140eec.1
 for <u-boot@lists.u-boot-project.org>; Sun, 01 Nov 2026 02:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793528375; x=1794133175;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=oQlloc51IgyeLrN5lQugwBlPOV1VmbAeX4l7iibVGcU=;
 b=KlgiD48ivWptnaqg5dZCRKdAp8zjBh8l8gKJmYx/FnoFN/ZXfMRVkp9EnzFxz37SfL
 hOAcvNPePsQ1nI/6z4M+MRPxUcjzbUH2i/Bmu9OqglDWtCpO51D87q3X7VEuruUmcD/T
 MFsWli5oBUuzOx7Upl9MwlkmZkVP4hOg6rEXGdMIvhvELkSoX/44qve66INgvZsL1T/o
 PaCEuyQpbmH2SL97pXoOzAJJfiAMr86rEozBbUkY5Cj8L58SLRFXu2O3NF5RyjQROz1D
 B1bWxAdaBj6xPSrm0q+3MOIrrWndKcKISSRsBgrlNJ83gcVDkO2sMzO/6bSZzBFV5bcJ
 X4Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793528375; x=1794133175;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=oQlloc51IgyeLrN5lQugwBlPOV1VmbAeX4l7iibVGcU=;
 b=1BhFO2+JZ8Gbhtv+pzUWunLlC/PIeCcvPrP0WTF6KM0nRf1HJGdh5zigFMJaIovykE
 PxogYAkXDfH84HSdr+x5+P0a0FzjFFnawo04D0V8et6w6nodXwfj1njDeqgN3VyYjVZU
 cfOyKAdAHFwpOLCM7VsLLLGzFHrMDxapVPjsMmGaRpNDmto3gHDJrJ3qKM+WgzLDtILF
 TmW2vHJBMSbQdsZQ7mMkhMYOzNP4ycRBxrFLGK+l75CYBkvLJdymsoGJMYWaO8d7lhQx
 2fCoyVvp2AzpoPbpFzELitAonUQr3c1vdsEuFUMWaiB5hnPyH8Uf60+4EP/goCjfwzhu
 nTxg==
X-Gm-Message-State: APuU4Z91GqbBoNQNCteIVTbIp3J9NDqcj1R03Vxc0clWBFPowUmE+F6T
 Zn3b3CjC0LE8AwEV1p70Yn0D3jzICq1JUV+d/2kXHzKHjo8F4JsSr7MSG1gIURDJy4RJfGwhAIN
 iB95qj4nNRECpi3dh8WD5cTFjc1G9bC7iupDxUfhdSA9awx/4KLCXoHIy7AnoJ14vB53Pw1x6ua
 YUl8mVWQ==
X-Gm-Gg: AYBFou0590f99gvlBhhJ8aBzan2HQvvQDbTECr634Zcew6KGv3QikWXSgH1QOEsocB1
 mfI7OttoSKfC/s1ROFps8UsJqlfb9Vt/+f0wQJyTHxBPpRWjddjeOoBqnqrk5KPlfoL774VFFtD
 h5yM0TSem/pru32qhUuR0pQBj33sg0L8tpzf2v5EWq5Vn6yf/lJFu3Dt/508vqvyTe+999wiDko
 P3q95Z0UtYSC3noanutoz7HGxNa7kSZVEKtie2kspsDmQLsdeIFLMFsBZitENfbiN0Vj8/Xp2cF
 ZxItV4y1sBF/noW6PtxvtahRORqwJ1OFYepZ7GlDZ5JpyDDkOIBYKt5EuZCkblOKAPdzsl7yx+J
 vhEYTguXpP2sTaO7HDIi3Ti3ifb40w85xlyD6S5TdKffAPN5IWLTYD20i/DIn53FQ2U47AAh77r
 rNR0BvVURxCf+RrfSXUoKumg9p54gQSxVKIarxXZiKbtZvrwOy3hJiUdxjphxUtDPMSS5CiwwaO
 v4H5g==
X-Received: by 2002:a05:7301:6787:b0:361:306f:c32a with SMTP id
 5a478bee46e88-36a42345b05mr14074324eec.11.1793528375267; 
 Sun, 01 Nov 2026 02:19:35 -0800 (PST)
X-Received: by 2002:a05:7301:6787:b0:361:306f:c32a with SMTP id
 5a478bee46e88-36a42345b05mr14074286eec.11.1793528374692; 
 Sun, 01 Nov 2026 02:19:34 -0800 (PST)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a429467cdsm24596555eec.19.2026.11.01.02.19.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 02:19:34 -0800 (PST)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Subject: [PATCH v10 0/7] arm: snapdragon: Add snagboot support for Lemans-EVK
Date: Sun, 01 Nov 2026 15:48:38 +0530
Message-Id: <20261101-snagboot-v10-0-e73d5cfedb8a@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAP8R52oC/3XQzU4DIRDA8VdpOEszfA3gyfcwHlg6tCR20aUST
 bPvLq2JcnAvJDOZ3//AlVVaMlX2uLuyhVquucx9EPCwY/EU5iPxfOgLJkEiWCV4ncNxKuXCNfm
 EmEAaeWD9/G2hlD/vreeXPp9yvZTl655u5rb9iThQf5FmOHAAStpo6ZWmp1Lr/v0jvMZyPu/7w
 26thlseuyc3JRswRQh6w9tfL0CM3nafovQYlHQKw4Z3o9eDd93bGCg5NCgnu+H94OXwic13L1w
 kRVoJJeEfv67rN1LGfcOoAQAA
X-Change-ID: 20260731-snagboot-4e9f66f0252d
To: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Michael Srba <Michael.Srba@seznam.cz>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Simon Glass <sjg@chromium.org>,
 Hongyang Zhao <hongyang.zhao@thundersoft.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793528369; l=5922;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=CQBCFUAcbwpIOc1w7vBEA0Wb2Gc/R4zqSUC0OBQFqQ4=;
 b=+fjH2KC1jHsAzWA+1enzFeWPzrdXoKgjdrEQ/Mu2j1bOg276/kfdR2fXmSaJR89f/pegxa2DP
 2SP0NG+Sm4PDocPPAZqIYIgbtj5Jgc8OSKdJXGf4q3EB65PlRWqABU4
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-ORIG-GUID: S3DWtaZiNI0naN2e-dJMQP97oAMH3qMC
X-Proofpoint-GUID: S3DWtaZiNI0naN2e-dJMQP97oAMH3qMC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAxMDA0MCBTYWx0ZWRfX0Fl6WMNTUZ9n
 ldxYjH3eimMU1YaWJ/QH6nvbCHVGod3QU0AZGG7aZGH4iTtcmD0EIl556TKnzxLnNwC42Lnv2V0
 P2NJDgI+qRtyLiovTTpn/gEtPWAIm6IUlatDu20/4mJkx5LH2cmnI4aSBXFdP/cuhs7tuiwu5rY
 h8EIHL0jDStlSJDQ6vr5JfB+J19h4ilopL6P8kpQisFNXdYIBe1fGktqZJNVdUKb6ctsiLXgR+Q
 2LUr+geiuu/M1cSU+JvH8ZXRNaDmKg5lCrZcOL3o2832epX6GtdHwoH6VypEy4GMF25Nzl5zyFr
 f0nHGv1jpJR/hv2BzCQ3Ro5cnkYFayWCvg6dZdJKOQy/7iLx/nnNDgMi1pFYA4T3dcxvCNxx5Uy
 1Nc7Zd5b3dp9Eew3aBI8MK+//NGI3WJrU9gQNisRSBl4/n1G0M5iNYv7yh7kVgGUTn8JjoreNkg
 lqqwHAsCa5/0HurMwvQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAxMDA0MCBTYWx0ZWRfX9CHrhq0FycgH
 TnkFhIyxtaXnSc8lBdwlueordYvqDjuEmlzbEogAq0uAZJ/oFpJrgUl/Biq+1hCyNdKdLu1jurk
 qFmCxMxQdc497BrWAVHfYpdmyunxNPs=
X-Authority-Analysis: v=2.4 cv=cfVHPXDM c=1 sm=1 tr=0 ts=6ae71239 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=NEAV23lmAAAA:8 a=D3gdSb3EAAAA:20 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=gu6fZOg2AAAA:8 a=cXjSA4HeMtV0Hkx-pl8A:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22 a=2RSlZUUhi9gRBrsHwhhZ:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-01_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 spamscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611010040
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-23.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series adds support for running U-Boot in snagboot mode on
Qualcomm Snapdragon platforms, targeting the Lemans-EVK board.

Snagboot (https://github.com/bootlin/snagboot) is a recovery and
reflashing tool that works through the SoC boot ROM. On Qualcomm
SoCs, snagrecover loads XBL over Sahara in EDL mode to initialise
DDR and then loads U-Boot into DDR, where it enters fastboot so
that snagflash can write the images. Support for the Lemans-EVK
(IQ9075) is in the snagboot tree, see the Qualcomm IQ9075 sections of
https://github.com/bootlin/snagboot/blob/main/docs/snagrecover.md
See also the doc/board/qualcomm/snagboot.rst added in patch 7 for
usage and build steps.

XBL leaves the MMU enabled and does not set up PSCI firmware or
Command DB in this flow, so the series adds a QCOM_SNAGBOOT_MODE
option, an early MMU disable, and a defconfig and config fragment
for Lemans-EVK.

Tested on Lemans-EVK board.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v10:
- Drop the CONFIG_ARM_SMCCC guards patch, SYSRESET_PSCI is already
  off in snagboot mode so the PSCI functions are not built
- Depend on ENV_IS_DEFAULT instead of selecting ENV_IS_NOWHERE
- Drop depends on !ENV_IS_IN_SCSI, !PSCI_RESET,
  !SAVE_PREV_BL_INITRAMFS_START_ADDR, COUNTER_FREQUENCY != 0 and
  TEXT_BASE != 0
- Replace the cmd-db.c change with a patch that lets QCOM_RPMH build
  without QCOM_COMMAND_DB, and disable QCOM_COMMAND_DB in the snagboot
  config fragment
- Fix the title underline in the snagboot doc
- Shorten the cover letter and link to the snagrecover IQ9075 docs
- Link to v9: https://lore.kernel.org/r/20261021-snagboot-v9-0-18ce3e431320@oss.qualcomm.com

Changes in v9:
- Drop the assumption that snagboot mode needs IOMMU disabled:
  QCOM_SNAGBOOT_MODE no longer depends on !IOMMU and
  qcom-snagboot.config no longer sets CONFIG_IOMMU=n
- Link to v8: https://lore.kernel.org/r/20261014-snagboot-v8-0-7caef86562b7@oss.qualcomm.com

Changes in v8:
- Make changes in documentation
- Link to v7: https://lore.kernel.org/r/20261013-snagboot-v7-0-fc296a32836a@oss.qualcomm.com

Changes in v7:
- Rebased on top of latest main branch
- Link to v6: https://lore.kernel.org/r/20260803-snagboot-v6-0-e8bf7a6fc0a4@oss.qualcomm.com

Changes in v6:
- Forget to send summary in v5 cover letter, no other changes
  in v6
- Link to v5: https://marc.info/?l=u-boot&m=178577208345353&w=2

Changes in v5:
- Make QCOM_BOOT0_SNAGBOOT_MODE as hidden config dependent on
  QCOM_SNAGBOOT_MODE
- Disable C (Dcache) bit of SCTLR_EL3 register during MMU disable
- Remove now unused QCOM_COMMAND_DB_OPTIONAL Kconfig definition
- Disable unnecessar I2C configs (for Snagboot) in Qcom Snagboot
  config fragment
- Add build steps for compiling U-Boot for Snagboot mode in
  Qcom Snagboot doc
- Link to v4: https://lore.kernel.org/u-boot/20260619-snagboot-v4-0-385497442db2@oss.qualcomm.com/

Changes in v4:
- Renamed QCOM_SNAGBOOT_SUPPORT to QCOM_SNAGBOOT_MODE
- Make SYSRESET_PSCI dependent on QCOM_SNAGBOOT_MODE
- Place Snagboot related configs in seperate config fragment
  called configs/qcom-snagboot.config
- Include above config fragment in
  configs/qcom_lemans_snagboot_defconfig
- Removed Lemans EVK override dtsi: arch/arm/dts/lemans-evk-u-boot.dtsi
- Removed QCOM_COMMAND_DB_OPTIONAL as now we use
  CONFIG_QCOM_SNAGBOOT_MODE
- Added documentation on U-Boot for Snagboot
- Link to v3: https://lore.kernel.org/u-boot/20260616-sngboot-v3-0-6fb0dee8125c@oss.qualcomm.com/

Changes in v3:
- Brought the MMU disable logic under CONFIG_QCOM_SNAGBOOT_SUPPORT
  ifdef condition
- Moved the MMU disable codes to a new seperate file
- Used "if (IS_ENABLED(CONFIG_QCOM_COMMAND_DB_OPTIONAL))" instead
  of #ifdef
- Removed enabling QCOM_COMMAND_DB_OPTIONAL, ENABLE_ARM_SOC_BOOT0_HOOK
  and SKIP_RELOCATE as they are now automatically enabled by
  QCOM_SNAGBOOT_SUPPORT selection
- Removed updating MAINTAINERS as the defconfig file is picked up by
  the "N: qcom" line
- Link to v2: https://lore.kernel.org/u-boot/20260608-snagboot-v2-0-036bb0343bf7@oss.qualcomm.com/

Changes in v2:
- Changed SYSRESET_PSCI from 'select' to 'imply'
- Guard show_psci_version() and qcom_psci_fixup() with CONFIG_ARM_SMCCC
- Disables the MMU and invalidates TLBs at the earliest entry point
- Add qcom_lemans_snagboot_defconfig for Lemans-EVK
- Link to v1: https://lore.kernel.org/u-boot/20260409-cmddb-v1-1-b10549b34133@oss.qualcomm.com/

---
Balaji Selvanathan (7):
      arm: snapdragon: Make SYSRESET_PSCI optional
      arm: snapdragon: Disable MMU early before U-Boot reset vector
      arm: snapdragon: Add CONFIG_QCOM_SNAGBOOT_MODE option
      soc: qcom: Allow RPMh to be built without Command DB
      arch: arm: dts: remove Lemans EVK override DTS
      configs: add qcom_lemans_snagboot_defconfig for Lemans-EVK
      doc: qualcomm: Add snagboot mode documentation

 arch/arm/Kconfig                                   |  2 +-
 arch/arm/dts/lemans-evk-u-boot.dtsi                | 19 -----
 arch/arm/mach-snapdragon/Kconfig                   | 14 ++++
 arch/arm/mach-snapdragon/include/mach/boot0.h      |  2 +
 .../mach-snapdragon/include/mach/snagboot_boot0.h  | 27 +++++++
 configs/qcom-snagboot.config                       | 25 +++++++
 configs/qcom_lemans_snagboot_defconfig             |  8 +++
 doc/board/qualcomm/index.rst                       |  1 +
 doc/board/qualcomm/snagboot.rst                    | 84 ++++++++++++++++++++++
 drivers/soc/qcom/Kconfig                           |  1 -
 include/soc/qcom/cmd-db.h                          |  7 ++
 11 files changed, 169 insertions(+), 21 deletions(-)
---
base-commit: 3401e006432abcbf7d73d7210f10df157f990ed3
change-id: 20260731-snagboot-4e9f66f0252d

Best regards,
-- 
Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

