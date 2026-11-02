Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F374606A326
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 13:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=IJbfTmX2;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=D5GQvJe7;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UIJmc9UN
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E139040653;
	Mon,  2 Nov 2026 13:30:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HqoiCoEUREuc; Mon,  2 Nov 2026 13:30:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0CB534063E
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793626245;
	b=WQb5+Mw0/OIteSt3asCvjkF0SIOPxhIBLJCe7Dwh7jsLy/nLLp9LjRQiVcfmN3aN4im4
	 0M++NxGX7CCLQXSTwag7pO+/LEHcyt6gbLar9XTwu9zteT8HIvehLrs1Y81pU5MMJgI7X
	 XKZlrREB6+19So/zuNC/gK2/WAmEMr+3VvtZseJFLiecGP8o2vGOxTa/xpczy0WFooxP2
	 RN7S9YIXYVTT1agqG7NsUWGHO+AI+AB6azs6UCiQMWMvXPMlL1Tqfz105JU0zt0bbxaOc
	 K2ncCVBCjw/fbxyOpwGiDwJYpLOp6smsp0AYY5s1dyn4ZAkLRugInp+5Zi1NUxLl/qg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793626245;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=yiQ/laxIRjAJrCYL+zDjglMFlbmj1t7NXvAuZf3thQ8=;
	b=f15hl203R4Tu+E3xoNCK23i75Yjtam3qQ4wfW8gAMQaPnpzk+Vd7ySM6OuFWHq3HAq/g
	 DS/Y/N9tP9hiylVRgJg3k/fztglbhqUAL0Dpxrn4w271lfQ/CLZUyBTKIJ3RucFKpCoWf
	 lFEzZqn7BDhVRXDEdF13L1Rd9XsXIHIEbB6R79ICdV6KUs5kgDQTKb9TNJpBghMJAa1EX
	 Z3DyTzEwlQzCt3rXCB856po8jdrfxpTK/lx2/9greKz5T0qX9T1vOTb89HQp2/sTSX6wB
	 AK8Nyl61TCR7as/TQJpLjxOwXlX2BAQpiwit0Yyy8GS41Sl1GUBvT6YyOFzzGbsiGJw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793626245;
	bh=yiQ/laxIRjAJrCYL+zDjglMFlbmj1t7NXvAuZf3thQ8=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=IJbfTmX27R8mcPnt14EmtBSX61kErl807AIAZX6ZCdHUOE73XW944QmN4MWiF8Dr2
	 55HDBDUXF5SpTEVsReGGwil6YHyWZVwYiHyn+q0CMPs7pa1WUOtRHinF0fmDvGv0DE
	 SJg2bJdQyY6VX/vf3Wzhew6KD7SP9ktCBUyhGuwXQhWnW3SIZCZYTJAWFsTEwFegJL
	 FMnjlrl6Zn0VanzCa9KEIa3ots5c+5le4Md9Cts8tcIZ5Jjg6z8NTvyd8vH2hB3jAZ
	 uyx6lcY6nwgY2CcqDcbZ6zgYK6X8J8JiA/EK4MsRX9Hm3Vg7wSnZEiztD0a661EbWi
	 /ZTswuo8YC3lA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0CB534063E;
	Mon,  2 Nov 2026 13:30:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id BC5EE411
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 13:30:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A2C2A4006F
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 13:30:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LSjm2w-WaoTH for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 13:30:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 544FD40050
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793626243;
 b=mclqrrM/G+AYDTU3LqX44f1vrYk3beQWRBoiI7FdTp1JfKa2N4NZBsdu2vAt8zhbkhKL
 q593WgVq1Su3ObxHQHDU0y6rfMu25k27+4FIv3lBOFB72sRiVFfkZ3tHLe2yXJ3UDd39C
 HcJmHGUfABrHs+B29gMPD+dfvjPD1HOqaPnEF0n9yffaGOv9Q+mBoVaLX58g1zdXIJSvN
 JgSDlI94zRC3vDmLF0pmt7fq8niovqKPYwe8QC1bhvLySuwfEhHcSF9h6CMwDHkQW7260
 FtacHxmk9SSL9WKjZ1loisJrL08kMTyQP/SaXbjdGDfaeYbOTU1S+Wurlwgd5Lm+ntQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793626243;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=yiQ/laxIRjAJrCYL+zDjglMFlbmj1t7NXvAuZf3thQ8=;
 b=f49mFSw2BtEx7yodZ97CiHbpjba55dKUiRx2uCc/M1PRu8DsyU0mVQ67WaklGkSv6Xi3
 qdvRBBddBrgJSFfiHN2vi+Hu0QTTYUqNHlnFHBvcgl0q7Nlw3VhESMgSHXlTy3KHFCzHB
 yTrK+yG0On+7l9n4wFUNn+OBrBDW6+rAKoq21WQb0wKovhadPEMCJyfZyYZq2t5gf7rcN
 FqbBKhmadFUH+C/P8Wr6bSHLJF8K5epnBycN+M/5PiGk3eDnY8WilibSeC0oPUKbE0yN9
 sVjtGoUAWPTnlYNGwgdPZq04gZic/Q57j3NNUsB9t/4GCfbisw7daaD3jY9hyCBeLsw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=D5GQvJe7; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=UIJmc9UN; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=D5GQvJe7; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=UIJmc9UN
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 544FD40050
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 13:30:41 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A2DAVhk3627179
 for <u-boot@lists.u-boot-project.org>; Mon, 2 Nov 2026 13:30:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=yiQ/laxIRjAJrCYL+zDjgl
 MFlbmj1t7NXvAuZf3thQ8=; b=D5GQvJe70yYCksqP1Fu4syMaSveEbiZnihRX/m
 +S4Q2LQZlXyMXNAKA/NsLP0urkfVda+QBAXPLmoE4dwjQijyvBXAc7liEO1eUKgK
 Tra+/zC2wTGJi24ZKxZth8CPQy3og8kq5NLHTHKSdkhfoiquguJ1ek9TB3a7AADC
 sImCJFnISiBguw5HsswnIT2QysvVZIJPopUeOyrxOrtuEkzMaAzscFg6ekVV3+45
 q4my1USEmJtTrWgpe4Xavqz2cs5OACJ2AogXZfdFObgDdksrpTwUHwCwGq+GDB5O
 Ki5X8PMIdw2oF3xUOIfuK9G9DRoJxkVVWfRRBPAisRZW4Vnw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpka620em-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 02 Nov 2026 13:30:40 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93f33438950so579947485a.1
 for <u-boot@lists.u-boot-project.org>; Mon, 02 Nov 2026 05:30:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793626240; x=1794231040;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=yiQ/laxIRjAJrCYL+zDjglMFlbmj1t7NXvAuZf3thQ8=;
 b=UIJmc9UNvwSnQ8PR30p3rs8+mIsJcIk4o3UfwXcQGOStCk9Vgdh6eijGOw+UtgxwrQ
 FDYTgvxFSN7huDEParhrS5nHq3iX1aW/dqTef7BFaPoQ+aiycEYkzB3FSsmOmQtNe9Uo
 1IPinkSusdpk0oU5Y/TUlg2eJaJzPBBk178Oc0OOA90v+dcB5BrJr0u/RCQrOAxRi3/e
 evcfYeXjWKdwFHBgHIFKPg8YOWrRxo5CTXw8doy4MzvhXKlTy34CPvLjHcTUoF3pyDuh
 pSUC2FvX9e7HjI33kBOh7pK0Ohtfvz1Ox3XRbHh2hjNxtN9FGR6owNm5nbD3Mca3u1PI
 dgGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793626240; x=1794231040;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=yiQ/laxIRjAJrCYL+zDjglMFlbmj1t7NXvAuZf3thQ8=;
 b=Fhxyn1sNR7eXcUHLqds764CWi8WPuYtgK1QJGFIIS2l17wRZe5TTSHSeViUJrfx/K8
 3gaYAE8i9b5GaG7BHRZB+4a8BpUQQWFa0LSCuH4Stze4ZYnjvkO8mu35nF/Pw0gJlC0o
 4LkuvTuGqQm/T+Om2BgY208j5rf7nKCDFTDqwZWwT9lktDl9U+gaJ1xeMKultw9mc0PY
 udGSRJvX4uh1lYkR8ktfXcMo1f7ZRAFcFKudWm+atz1XV0sUPFBa/eTRGnVhO3si9SzQ
 kUhZGG8w2N3D+vsDvufWtixbiS9ySC5IjgXaiLsHvU3eRW7jO3me1+48nlomYNWjzYrO
 fd/A==
X-Forwarded-Encrypted: i=1;
 AKwUvBxMdLcZq+W/yRJQVskc0uG0S9en3h3uuVgDSZF3S9sB2yk+Uw9YZWAUnG/IPfNbBwyddZuaVAE=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJkekYvGbDjHg6m1yuaaQXqayrgTCIeNMvFAnVz488jbkQvjdmM
 9iUy1SL19qN10x0LUJLuSnFCxSGHhN5ZjJDJghzhVAuh74c+4qJ+atr5F+u/emOMURmK86uXHGS
 pkcO99gY1/7PQb+RGk2v/5fyS0PTjPYaCQXJPcIToqV/yOQKBvt4PXa9viD+eRvMY7YHukU8=
X-Gm-Gg: AYBFou3nAs+EY5QnVljJKSNVbOz0ddQ/7vAPMcEzkG62tIZR+Ztt0GNMhdYzJxWD9Fz
 HiHKOscpUWMTqVUdhILKjZjSj/QFXGWdplhiX99K2ssHqvGgsmTTthhk2/Bw+0zpKtJ/ua+3Wdy
 lGw9l3YjidryZZnOkpryILvk1NIPXhPJU7/yNuSXfve4WZNwls7MUtL7YuICLKzcKFA+zNkOUSl
 7UboG/AIFYaDl5lG4ee8xVkAPmt75ZHa7fIYdHgmSDLSpYrBguuxb0u1XMh7T1HrOc9YdBIS1JU
 12drioNZy8Jt/5AXVU0hwgp5tebms2TliAEwAIfjTCQz2iI/1m4wzgE/gu7V3WHZAhzMrGckXcI
 NczaIUjDEAEUwsVmpcNMSiguvuzn3AFPvydc/bBnyNDCfVO2AkmKVyUKyf5GSVBOre4lrovgCzG
 5bNy/XMbhgI+uz
X-Received: by 2002:a05:620a:84c4:b0:944:9cb:d41c with SMTP id
 af79cd13be357-94421718c65mr1510493085a.19.1793626240051; 
 Mon, 02 Nov 2026 05:30:40 -0800 (PST)
X-Received: by 2002:a05:620a:84c4:b0:944:9cb:d41c with SMTP id
 af79cd13be357-94421718c65mr1510486385a.19.1793626239437; 
 Mon, 02 Nov 2026 05:30:39 -0800 (PST)
Received: from [127.0.1.1] (93-159-22-70.cgnat.inetia.pl. [93.159.22.70])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b4eca0fa80sm3288630a12.28.2026.11.02.05.30.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 05:30:38 -0800 (PST)
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Mon, 02 Nov 2026 14:30:33 +0100
Subject: [PATCH] cmd: fastboot: default the buffer address to $fastboot_addr_r
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-fastboot-addr-r-v1-1-7ef1a2ac8fd1@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqAIBBA0avErBtQQYmuEi0sx5qNxigRhHdPW
 r7F/y8UEqYC8/CC0M2Fc+rQ4wD76dNByKEbjDJOa2Uw+lK3nCv6EAQFzRTJkbdO2wi9uoQiP/9
 xWVv7ABXuh2NhAAAA
X-Change-ID: 20261102-fastboot-addr-r-28fe6ea5615f
To: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kaustabh Chakraborty <kauschluss@disroot.org>, u-boot-qcom@groups.io,
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: hBPujxKuSVe3XRgiqkbCILfunlUltVFW
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA1MyBTYWx0ZWRfXxf+Myp+YtBEa
 gbriZLU+QC6rdAhoqqgUpxlAq9uE3qjvbDYRQ9VxdTzRWXQwAZ53pvi57tY+87eQvf02nAYMD/P
 FeMgmevnd5+ito3/z/lnFALQzV74Dgs=
X-Authority-Analysis: v=2.4 cv=ZbyIpcVA c=1 sm=1 tr=0 ts=6ae89080 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=ySe+0nHqNG5yihRO1pIWsw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=dNEVgzFE_HBZiHT9TB0A:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA1MyBTYWx0ZWRfX9Ra7/qdtQyCD
 yR/Kt19jHOfbnIMuamTscvyTNISDSkiMUqvK0nZEw2rWdK7uYsHIsjp2Pt8mH2aZNShsj/1+0HN
 RZtOOUVo5YaXFTgBmQtQ6Hz2yMWmo3bc3mMxeuwLMYjQ0EvvxMPxMb+lN/EUD9aWF5Qc0dVurvi
 ajhP395V6HyqjLiDRPF0IG5iiQRYU+o5pPEGkSjDFhmwtZuxx1sEDU1ad5g0MnVYAOAuBigo1kJ
 OEwJrRhZtLfR+A/3VWOknmo8czX43wE8nWE/YbdSr1DJVJn9qXya4gl0o2yg6YvDWMHUmQf5elR
 XSwxq6iBh1eIb7zt7Zs9AHGfWY3uMdJsRqOQoa6a3Pr+gkD/oaKylR61z6xmbWWjv4TroeKJktd
 cvjyMR4AKnmApLYmVl9nJJ+m3uW/MKD7mpa/rL1UMFxWZn65kDzcqeHt/vN5UWBqVZPeCuy+4ff
 Vd1yft9EHfRgrjC+22w==
X-Proofpoint-GUID: hBPujxKuSVe3XRgiqkbCILfunlUltVFW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_03,2026-11-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 malwarescore=0
 phishscore=0 adultscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611020053
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

The fastboot command downloads to CONFIG_FASTBOOT_BUF_ADDR unless -l is
given. Platforms that only know a usable address at run time leave that
at 0 and put the address in the fastboot_addr_r environment variable:
mach-snapdragon allocates the buffer from free memory, and so does the
Samsung exynos-mobile board. Their environments wrap the command in
"fastboot -l $fastboot_addr_r usb 0", but a plain "fastboot usb 0"
still downloads to address 0.

Use fastboot_addr_r when it is set. -l still overrides it, and boards
without the variable keep using CONFIG_FASTBOOT_BUF_ADDR.

Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
---
Tested on a Qualcomm QCM2290 board with qcom_defconfig: before, the
first "fastboot stage" after a plain "fastboot usb 0" crashed U-Boot.
With the patch a 100 MiB download lands at $fastboot_addr_r (CRC32 of
the buffer matches the file), and "fastboot -l ${ramdisk_addr_r} usb 0"
still places it at the given address.

Refusing to start with a zero address instead was not an option:
sandbox uses address 0 as its buffer.
---
 cmd/fastboot.c           | 7 +++++--
 doc/android/fastboot.rst | 4 +++-
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/cmd/fastboot.c b/cmd/fastboot.c
index ace877b6e28..ce4a32729ed 100644
--- a/cmd/fastboot.c
+++ b/cmd/fastboot.c
@@ -7,6 +7,7 @@
  * Rob Herring <robh@kernel.org>
  */
 #include <command.h>
+#include <env.h>
 #include <fastboot.h>
 #include <net.h>
 #include <vsprintf.h>
@@ -88,7 +89,8 @@ static int do_fastboot_usb(int argc, char *const argv[],
 static int do_fastboot(struct cmd_tbl *cmdtp, int flag, int argc,
 		       char *const argv[])
 {
-	uintptr_t buf_addr = (uintptr_t)NULL;
+	/* Boards which place the buffer at run time put it in fastboot_addr_r */
+	uintptr_t buf_addr = env_get_hex("fastboot_addr_r", 0);
 	size_t buf_size = 0;
 
 	if (argc < 2)
@@ -144,7 +146,8 @@ U_BOOT_CMD(
 	fastboot, CONFIG_SYS_MAXARGS, 1, do_fastboot,
 	"run as a fastboot usb or udp device",
 	"[-l addr] [-s size] usb <controller> | udp\n"
-	"\taddr - address of buffer used during data transfers ("
+	"\taddr - address of buffer used during data transfers\n"
+	"\t       ($fastboot_addr_r, else "
 	__stringify(CONFIG_FASTBOOT_BUF_ADDR) ")\n"
 	"\tsize - size of buffer used during data transfers ("
 	__stringify(CONFIG_FASTBOOT_BUF_SIZE) ")"
diff --git a/doc/android/fastboot.rst b/doc/android/fastboot.rst
index 8e15f287f9b..41db4b31e16 100644
--- a/doc/android/fastboot.rst
+++ b/doc/android/fastboot.rst
@@ -70,7 +70,9 @@ downloads. This buffer should be as large as possible for a
 platform. The location of the buffer and size are set with
 ``CONFIG_FASTBOOT_BUF_ADDR`` and ``CONFIG_FASTBOOT_BUF_SIZE``. These
 may be overridden on the fastboot command line using ``-l`` and
-``-s``.
+``-s``. Boards which only know a suitable buffer address at run time can
+set the ``fastboot_addr_r`` environment variable instead; the fastboot
+command then uses it unless ``-l`` is given.
 
 Fastboot in SPL
 ^^^^^^^^^^^^^^^

---
base-commit: 3973f3c4d24df75ca90d7c0a9f03e5e5c9b48f32
change-id: 20261102-fastboot-addr-r-28fe6ea5615f

Best regards,
-- 
Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>

