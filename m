Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851B6606A31A
	for <u-boot@archiver.kernel.org>; Sat, 24 Oct 2026 17:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=KsQd8ZcW;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=QzlOIus6;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZY5qO2PI
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 644F140786;
	Sat, 24 Oct 2026 17:38:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RflpNW6KUh0p; Sat, 24 Oct 2026 17:38:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B38EC407A3
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792863506;
	b=aJNH71t4RbM0lt7qHg4E5UUHbBeSxA9b5boW8VVlZYoD99zAci7MG8K8fIjEcPrdIQpJ
	 PBrX69a+4VE+X5YHZskbfdfk+C7nfG2Au9rr6vSCGDOPmP3NZ50yTFXt0elzELQhmxUZx
	 iXvVcHVBKlaTUfL9xsVH6pXgGcdg+Sz43I8FslHi8fRhwGSiNs8Mp76kOkTIDoYtCOUT6
	 3H2jMHv1McELZwl9LYpshYNqhNCY/K9jEXxSFLcuh1OmS3FDn2bgW6Da091L4FLscfFPL
	 1k0JswJ8QjFo7PvoMK4/v1hTq5Tr9drzzdHiYGbVD/mfPk7zMNTiT3LiLAXOSmPEfqg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792863506;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=5ZK2SlTGf5SdzLbRKff+buGwl9vRSkotkSYaRGlBZxc=;
	b=h66H9ojLKX6MnhN2EWVRLph2Xjgu/HFyUfcf/XC3MMMhr/Jxkdkaz/GacL7YoNfrOxGO
	 UvUy20sFq7ITdA43ykVAqF7xuU+BuzjZnYTS2PqXAWmGyWR23kKJ+bgVvddMVHNeUT6b0
	 de+ka9ifRxkgtFREyzAj1Jpb6vZlBOlelApIASW/hoHyk82QL5ma7LM7XnuBEeo6QsYo9
	 joGp2xtCcZD9WAd3ZbKGjDNo08kWQutj/FnktDSut7el5zoZGnP8PLhHn85/N1ypgP2YJ
	 V3cEoqKcja48lARVbZ1umVdgsiCy1XXJs02RlMXOwl08kdrvukAGLM+Fp5wWH4S2cxQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792863506;
	bh=5ZK2SlTGf5SdzLbRKff+buGwl9vRSkotkSYaRGlBZxc=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KsQd8ZcWngbWCzi6yUfuvG0PTi7xnD7BCPf1D59DWdtedpPm7buYrRi8/CqLRTjXL
	 qjoEHpBqieERR7KQP6+hko5SJHS1ga0L1iA8+mzljOvtJ48H8Nns+GuJc4IQn8Fzir
	 5RYA9nrFazHRpNSzN5Nce3bnz6o2erc+5VbzdLcq7CAqjQjUbXjgUtD5Ya0F4WYsHk
	 dl2fGxQe33HaMyKtokmKeo4M1sIbZiYvNgMeg/yya1gyz5KiENrWvQYf9kOHqulVOe
	 hxlT/apWLj1+FVj2kHxFlRXQNajjL2iX/pZpZTu3Bazmr5P5LdLOw9xBmltqrixW65
	 ImhEdadMAYQBA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B38EC407A3;
	Sat, 24 Oct 2026 17:38:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4A1E24D1
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 17:38:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2FAEA816EF
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 17:38:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id i-V6i5NuK9wI for <u-boot@lists.u-boot-project.org>;
 Sat, 24 Oct 2026 17:38:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 84FDA815C3
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792863504;
 b=c5/JAcrOvCnoG8oQiSiYSS8df6VzyNJ1st727XT7EbzsSvLgPNtbity7L68x8d1Y34Gw
 5YDhtVxAt0Dco5yR1Zns03k4b64meDxjZv1q07jmJshAPpXoNQ/OtusUHARTWtlR530a6
 qqjFh7X1hE2Lax1ZHjzB9GtZRb+FgpXqcCakVnUSDRvci3sVyLDV4u42LV9vvo6d1EEfs
 thgiab3++ibnurRlETFiYiYJZZyLjTjrJDs5h+tcBJTJTkoe97QA5Zdujzp8h5qfvwzZo
 eiGwOnnB8SakQTJy+pVMLp0oCkVDtdhwKz/oP6bHvxOlLbkgrTSm++WVsmqY6Rn+kBQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792863504;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=5ZK2SlTGf5SdzLbRKff+buGwl9vRSkotkSYaRGlBZxc=;
 b=Yw26riXa6vM6b+9UbZwFucg/a3OrNvXgcOjrcvYbIH2wbmW0q3fAh+qqEj2Fo4m1nbLy
 kKpyU0/6ZbKkA5m45sCMPFPPnhDIVSKrnEVUmNDc3yh2L+6Rwoix46DFFf0ILZ8YbTRhA
 sxT9tddqPsfQvzS97u1AARqG0up84urmLthpLEbXsC/xEzkSEgoHUxh5YFqn3qYgGeWOX
 pyDXUrNhemOR3x6rnSYQMjz1L7v6vLQemi7mgl6QkN2jwalJ91o5lwO/ci7KULhCuCK/B
 wTEp3ihk79/nEAcIcCNxIMW/VFO2bUKtIcbIZ1n1tewwc9RPh6c0IB4hEHPBFqOgpYA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=QzlOIus6; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=ZY5qO2PI; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=QzlOIus6; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=ZY5qO2PI
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 84FDA815C3
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 17:38:23 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69OExvXo374069
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 17:38:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=5ZK2SlTGf5S
 dzLbRKff+buGwl9vRSkotkSYaRGlBZxc=; b=QzlOIus6k1hBeevzCPbxbu7ub/I
 iKssXbd5SW1vJ0Eq6dUTQGiJa5aNb94Y5WVXrgIKMypFuDuO8JpLeFVSoAo/2SZ8
 SD1+58OPBpfTjdxamWWOivMrdJCE11uNQCYbYg+JzYMfA0pWyYdG83AqkcyGLcXM
 ODEqelig67Taqv9bxUnpFP8OfhJm19SUKEnjdWsQ2KK5ZMJRi1eMgYMeomRqphgF
 iqnJiDXNxKgv+rYDLtjrMCSEaWDTZ5gcUs6v2Ws7e/fO8vJX9krob0Kn3GRoFZ0y
 s41XWPmdCCX8T0SMzoRi/SHdfHVj8lDk/myMlig5EQ8Hu6ZaeHHCc3w725w==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgnuk9amp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 17:38:23 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-3510d0baf63so4895937eec.1
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 10:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792863503; x=1793468303;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=5ZK2SlTGf5SdzLbRKff+buGwl9vRSkotkSYaRGlBZxc=;
 b=ZY5qO2PI4QdxvAwjqlGFiq+tEJFb2czrjfMfdX4LXFWTvXFnPkPpyKKpOsqGkP/e6y
 snQVAqToAGywL/DuQyZ4Gf1uVF80gP5K4fTZH5HeOOe08BuFUatOtTNZ8nt4W5CnceKR
 gy5XqCOPbPe3YcumQyFSoSlb9nwwbRfOQY+dSYMQqvOR+yMi6fygqUFquXKZNceotnB9
 vGoaL5OzY8ZwWCJYkXszMtdel6cOuXjsqLVKLZ1twHbo1qMxgQIW299E0vdQnqHJMzaw
 xHnmIbYytWbg4j/VeFxfv/7Fuy3dx3uA3avvdUl8giZa45oXCngBwaFSU0PEssMsLpLI
 4zXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792863503; x=1793468303;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=5ZK2SlTGf5SdzLbRKff+buGwl9vRSkotkSYaRGlBZxc=;
 b=2Pa/h/TVeAVKS0DaDdA1d8IKrh6PkwKmh7hMGHNmRNcvSPjBG5KF0zOSbPrVfzg5Jn
 l2PWrgtlPzSTEvt9wwqbZp07pd8zxoEdHYVGvPHpx6cb6U98NwUQAt58PLZ5yfUU18hG
 GWGZeHbSDqvllyVY+AQ/tmfwG4okh7uc+y27e4gaI+KtW7US9skL6qhNig5OSrHv3PBX
 kuQsvak0eHtXuUpVG8aBJe/eDa+dmVtqeRhkJbWCNUvVg1R4S/PFJzVYcYim0HoNI25E
 iQdKcvgPfZAoUCI+3FrqVbZLVK/nQTruC6gwijXlapiyxt5FCWAbIF6tCTKNkjKlL2pO
 Bhsw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxuqt6oZZCRd+vgq50Ev3k6FEpV0u0Lq2vzxFXGVOEkv12CdLIOs/y1tj6lNOtxytSAFsjrNlo=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJu5my6CNjgBP92SGOvcgKtf+gaKddVIdJB/B0Zlh2Xf7prsPBc
 cp46AIafnkzZokpexauJcZwYtQNaW7MJXuoExMgdISfv9byZGlQdhvOIFnzI9CTOqHHk9NsD6NZ
 VPW8GJbNgEQaIok6IWCaaVTdZXzqvTSXxX61INqTwfLGMNqnl3c/llOHw+U4kVp5NRYzXSdg=
X-Gm-Gg: AYBFou24V8081dcP3Mr7S6/CN2tlfygGozqroqTRH1cbBZ2wYqt3nfN81PhkXo1EL79
 YuvEr6pF3g582AoT6t/qTBDuXADfADTA9W7qPqtwSmnzPwikgabgdfVtdLVxpJBRMliEYgrYsDC
 les+7FRbGVBtSNEr3D5WYRpv5xrRxcqNCSW3edGP4U9z2LZJ9a8flmYSKN7woSUCWqLFw6pD6hd
 iEZ1R0jBicT+qRC+wpHxXVvSqXQ1eWRV8TDfvwP5y3tMsjewiIgeyfkSYeGiZOvzQXGR2RXhk6V
 Xrg2ffkYRyET9XmWoI9jlKCF6U1AatN0OMryRbZNS2Yha1JmpIeIwvbUZ/Vi81gF+eEAVS2nJiA
 q4hIA1BoZVUvPlsrpmIWb4Vrm+eIR6UF1gO1mcCiHlxqClwZCBWIh0m//Fp9mafeDoLGyITLGc/
 C+yixN3QqyG0mJpyrUv64=
X-Received: by 2002:a05:7022:6990:b0:14a:8cff:fbb8 with SMTP id
 a92af1059eb24-1993580f1ddmr5591127c88.28.1792863502690; 
 Sat, 24 Oct 2026 10:38:22 -0700 (PDT)
X-Received: by 2002:a05:7022:6990:b0:14a:8cff:fbb8 with SMTP id
 a92af1059eb24-1993580f1ddmr5591086c88.28.1792863502203; 
 Sat, 24 Oct 2026 10:38:22 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-198a020df20sm10714248c88.6.2026.10.24.10.38.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 10:38:21 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, xypron.glpk@gmx.de,
 aswin.murugan@oss.qualcomm.com, nathbappai@gmail.com,
 Michael.Srba@seznam.cz, balaji.selvanathan@oss.qualcomm.com,
 sjg@chromium.org, aristo.chen@canonical.com,
 jorge.ramirez@oss.qualcomm.com, smoser@brickies.net,
 ccaione@baylibre.com, vincent.stehle@arm.com, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v3 3/4] scsi: Add scsi_scan_new() to scan only new devices
Date: Sat, 24 Oct 2026 23:07:48 +0530
Message-Id: <20261024173749.3509050-4-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261024173749.3509050-1-aswin.murugan@oss.qualcomm.com>
References: <20261024173749.3509050-1-aswin.murugan@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Z8Z5j3RA c=1 sm=1 tr=0 ts=6adced0f cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=Llik4w9wTn4nbzgA8qQA:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: GyImB-gjUOBWNQ_sxWHSNH5drbNywAUT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI0MDA3MCBTYWx0ZWRfXxe7JM8nB74Wd
 POi8L/FW5UREs07QpgA/LcjSZPeK9qzEAgAPWm346WMoPvwJCNkqI9WZ+3yiUkoeloait6CsFlc
 tySRFHTkTvtiSg9TrWWHRB0AMy2xE0wt9wasHp8p/DbpT7O83tDa6+q6GBNZzbywxnwCV/6BQ3S
 vDOLs/Xnn8Jv4mIvXuPsCtm3lzbMhe9dEQdovcl6xe5ERmaKI72tVYIYE1yLyppXe2NTn54rS9y
 gQXjczq4LmhS3bc9m1l02126bEVP7Bay1WGfEm376GAIS3vFX0dWnGeGlxKZ6L3PG16KEFbaf6t
 c8ldPFkQ3OGSMFVVewhB/DT1ahm0tI1dtpucjziu2fZ6AQNI9PGcbXiejavDFe/qHwsNzMx+Eb0
 oxmWE9z06KdUHRGiKGylDF0leG34WtaGcxUsTYCEQygue/UzrRHmshA52t2GBteOvVsoHehVwHU
 1F+zExrp0xk6QY7mCkg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI0MDA3MCBTYWx0ZWRfX5X1evGY+9YNL
 6QwmPrnG0WqSydiZ+UYcSf72/CQMA48XFBt2tti/aW+pV0yuvq8p8dGILYOQioaICJK4xF3XpYJ
 /OQeOsKBVsqNLnMkrvYZoYnjcQZXDJ4=
X-Proofpoint-GUID: GyImB-gjUOBWNQ_sxWHSNH5drbNywAUT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-24_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610240070
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

scsi_scan() removes existing SCSI block devices before rescanning,
which can invalidate existing references and requires callers to
avoid redundant scans.

Add scsi_scan_new() to scan only controllers without bound block
devices, making repeated scans safe and eliminating the need for
scan guards at individual call sites.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 drivers/scsi/scsi.c | 27 +++++++++++++++++++++++++++
 include/scsi.h      |  8 ++++++++
 2 files changed, 35 insertions(+)

diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
index 50e7d749921..736dccfcbff 100644
--- a/drivers/scsi/scsi.c
+++ b/drivers/scsi/scsi.c
@@ -673,6 +673,33 @@ int scsi_scan(bool verbose)
 	return 0;
 }
 
+int scsi_scan_new(bool verbose)
+{
+	struct uclass *uc;
+	struct udevice *dev;
+	int ret;
+
+	if (verbose)
+		printf("scanning bus for devices...\n");
+
+	ret = uclass_get(UCLASS_SCSI, &uc);
+	if (ret)
+		return ret;
+
+	uclass_foreach_dev(dev, uc) {
+		struct udevice *blk;
+
+		if (device_find_first_child_by_uclass(dev, UCLASS_BLK, &blk) == 0)
+			continue;
+
+		ret = scsi_scan_dev(dev, verbose);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 static const struct blk_ops scsi_blk_ops = {
 	.read	= scsi_read,
 	.write	= scsi_write,
diff --git a/include/scsi.h b/include/scsi.h
index 439a7f4fede..17db9707f4a 100644
--- a/include/scsi.h
+++ b/include/scsi.h
@@ -344,6 +344,14 @@ int scsi_bus_reset(struct udevice *dev);
  */
 int scsi_scan(bool verbose);
 
+/**
+ * scsi_scan_new() - Scan all SCSI controllers for new devices
+ *
+ * @verbose: true to show information about each device found
+ * Return: 0 if OK, -ve on error
+ */
+int scsi_scan_new(bool verbose);
+
 /**
  * scsi_scan_dev() - scan a SCSI bus and create devices
  *
-- 
2.34.1

