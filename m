Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDDDA606A31B
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 15:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=TiMw2fnT;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ikkZF45A;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Y05Kg8t1
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2F15E40889;
	Wed, 21 Oct 2026 15:57:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 04SoPGOiUKKW; Wed, 21 Oct 2026 15:57:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4EC194084B
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792598276;
	b=nyRSYUu7kppaKgPtQVDOXC5UzfwJz+c9vhQ05v9E5EH1lGrNTusshenJ5yElD3tkstZ4
	 lvAsAS6kdi7Yc7p7YLDwsLnXgeydH0IRNsKu4fcGIP9HZq9jtNAov1cThHQgAkFrsQT+J
	 BLE7CigTuddXgJFwTDQEswnSHuE84Cilx+RQGkoXfZq6cYzxj0kLPgvkFOLYyg4Ke1RfG
	 CMSdZ7OPwMJYGwM26W+mbJg66mv4r2sxl7924UijbZcUMgpJEbH5Sz9VpIqd4RJBdMzxT
	 cqOiFf95DfIvRXdivXRQHBgMyHS9lc+kwLdmrB0ZfNDqrs6CSI/SuWPgrkrsASRYEvA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792598276;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=8vvGuvRKSuTA1a3D8su7ifURUeJn6fR72g51dvtlB5w=;
	b=GIQSFzth9CTT7hjfyjN1o9uWA45OrGbu9hU5I3ApctcyyHgxt3DO5ObgsUUcStGPYNrt
	 npG+1xnUB6/T/u7C49QiIyRpulkfp2OVVPYyKYLz7lwP0MULCIT6M1/q4lDoUjQi7cV9x
	 IYQM63pSPwcS/RBnKvW5b+HuIJskuyl4wjVR82bphjTGU+WQNOXmOv50LytohKA0VpXzs
	 Lxt4/fD1yLtAvrkMO+rde98r7JstRJ+ddyE17FMmGVJz8QsX8QwtzVz4EMyz6GsS3wQEy
	 RGaORl/EoPHyLhVOA8fW+On8V6RaoieyZM7YrbM2Ia2t7XzvJ9zQ7cQbcT4Lp0scppg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792598276;
	bh=8vvGuvRKSuTA1a3D8su7ifURUeJn6fR72g51dvtlB5w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TiMw2fnT32S7Fwxjmcd4UDBiCidnA33E8GQuJbB3Z0A2C8C9oa4qYjjc2lwE0eGgp
	 sicm62TY79qZd22gEd6xaI8WbwK3FNQil2GQX38P6F9ggejtY1asyVKbevh8M7qWu8
	 rE83VmUninunP6+xMoWc4k1sYrumsm6VzldlQD0h5fopsnmTqV0ngVByrpilyuLIWq
	 g/dEotjOK2tdrmaOmc3UXQncxS53b2mJLHK0tFqx3iePgx5EBDxRqgg0mMZoCQCAQE
	 cMQe8+aScnSVbvdz2plYGmJLfS+t8JWiR4nev75U8r1ENlrbB6Fx39LttbpFEn6hLb
	 EJi8eOj74gsbQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4EC194084B;
	Wed, 21 Oct 2026 15:57:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7F3D81AB
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 15:57:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6516460846
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 15:57:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id B78lecAX2skr for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 15:57:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8DD14607E4
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792598272;
 b=rBhHbbHxJxatyOreHE0G2swhfIJFRDSC9wm4ClR9sc4LbMJb4BhGaSf/uRQh1vTEms6V
 1eTDLe/n9DXgpgMVxuvKbpNaEewaMQDbf0aDbailhi5t+5RPOdcNR/Ls8HkwgaT8o0Zjc
 JeirNLH8VokEpI8XgXNoGEk7seehDaOb3XkpFSjiqvsz37AP8RdQcslT6BL0IpkfsFV8+
 raOAO7Th++4z99iemde9bPTHvIkPCWJZGps8Tw2w1TtbkuivBkeFOLFqj2BqXkKW3+c+U
 9sOvI7UAliQ8TbxD5L58yfvI+LIezXwDt6H9Y3rNgmlopn2SOu4dLmemVYR/AlBTMwQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792598272;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Authority-Analysis:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=8vvGuvRKSuTA1a3D8su7ifURUeJn6fR72g51dvtlB5w=;
 b=olWqxxX2TcJQT4zWkavHqoWU7Hn0Dm8pdAdDuCG7VUoGb4coJLGbtAmqIkoT/3a3ZlgC
 kHWuCiVQ2Ty6N9habL+6DLAIAEIKS72SPfFlEB/YnjxqC3hEeXkWul716coXkT/OMPdS6
 4AkDtlQwOjLmNUTBQw4DiGtln2fh8DXH1pvzgk8h7tNI6jdPb6ojWuO5uh1o2pXOO4idF
 tQS3THNyi+JI3FKSkeHTg46ODZfrxYhEsMXBIkP1g99OeGRmcm/2Ux1jAQO89+LUSCTjE
 ykxbFjzuuFFrAwTFMvA8ZVkXBOsdp93IpWTyJHUUZeiDl3M4qfnW9kz3W6Z4UQNClRA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=ikkZF45A; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Y05Kg8t1; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=ikkZF45A; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Y05Kg8t1
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8DD14607E4
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 15:57:51 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LFoCBJ524220
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 15:57:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 8vvGuvRKSuTA1a3D8su7ifURUeJn6fR72g51dvtlB5w=; b=ikkZF45A3Wjgp8HL
 7j1tR2zYfoMK6fVkymHDqnJuetmStHNK1zm9G7paP2InBLvFjmmC/apual9h5lxP
 4+hImoKv7py5DDSPJlsXPp6Dyh1DJT/ROMk2RBSro48KzCARUvL/qnnlSccPH4Mk
 uKNp0tXrhpfINRABAKEjLaP5ep2G3BmgGGVnUUKrD3kEIY+9roXaJ8GMoU3Exuxq
 +sR3IN1Uktm5ktsiSqcX3gzg0DCEGC91d1Lkx6CUO0cUR+o8E7oYZfGtcjLT54EL
 82cNiqVR9YsWAc85KBDmLrH0WGtB8cxDTBQXH4vtHUl433DDWp4tTdqxC16uPgVQ
 bM+K0g==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf0cv010x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 15:57:51 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-1665200f4c2so1265269c88.0
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 08:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792598270; x=1793203070;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8vvGuvRKSuTA1a3D8su7ifURUeJn6fR72g51dvtlB5w=;
 b=Y05Kg8t11xtISgwPXjW4eo+tS+2etAoLm5tWyVlHGz9DotLWr04qlZiE/luMBDnfdM
 YYRQLPgE7TTaIXuneTN8u8X5F6jGpRrYRmVwSHvbhp8/m9/dVm1XH0yloMy94jBWkQOR
 WrsxHMSnePPe/7LdGQFg/ix628bxOheAH+QaPLAS0FI6XB6bE4urGP/jOlVbRvnpYpub
 pEBgyQY0Q5Z8zuvIVGjiZ30D8cM/kBB1ueMLTgffm2Ne+iAWMRCqEDf9DceMUeDz8XdJ
 m6V5cqQg9npWvFNrZTUVsC5vU2Y1R22I4RkQWFXYLM0Hy3yuWMJWOl0l1NoklYScLsOD
 bP5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792598270; x=1793203070;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8vvGuvRKSuTA1a3D8su7ifURUeJn6fR72g51dvtlB5w=;
 b=tLDqDdjd040JUIBt5MANF7JrsT0jSmuy8AipNazZPf5Cbwk0IaFkxRH5R4+P9K5AVU
 c3utz+3XcWcp+rxW3d/cEI05qwl08raof3eTNbZ5N5mAsaz5Z09Q1HdClPRIEYBPF+X4
 KPkUJX/zzEx3uP23342GULW2ePQ5oWbnYsksH3OsU331YNN9+4E+wW7f63gKAcvYhi86
 /xnpMW5Cytf1t6qel+kGG9yhkF2GLGa9k4jWide8R/qjyvdWYzJdDxe5U4gvuAvOwPjj
 dTCwZxGEhYywgO1o0WmzLveuJRR2zay6By6ls8dkuHfSo4H52pkEsghiDdLMvoU41A3i
 RiJA==
X-Forwarded-Encrypted: i=1;
 AKwUvBygqpaTnJSHpiYUK3phAE4b31ycbv4/FpiSB7GiJd6AIuXisHPLulbso5IncUhFxo1Tq9jdb24=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJ49ku69mNY2Yt8P3zVdgv5KbFcafkQ0gWtmarWz9wNi942HNlt
 VcSb3DvEsAR7pawYko0VbwfjbULAyPRKjzwtGXNAPaPNyEh4djnigN3FQSiPIEb/BINH65KxhrZ
 1U9wuW3y5sHK0DbrmZIykWVkKLN+E/CWM2/4+aPOCpc5H2PJADm73qI60+bS+8FO2b/CO1vQ=
X-Gm-Gg: AYBFou1SJqE+rGh3JnqAsQDwxPO7W9agu/J1DBKGrM10SqUI0V/tmr4JYO2/Uoc934S
 x7MOMxQp4/x/Pspg/u17/D+YSJ1arxjvBazcG/ge7Xr1Ms781/LhnjMouJGfk7lrFadVBREoAcC
 gdezBp4f5r4vCWJXgpAVpCrSCe1TLKfne2+sq4m8f5RuY7QXtWEAElbrE1iZ4yykPwrxvVlVN2o
 igivDzN8VwKaF9T9UoAJIRTfq3ZuN47hAh6q6e7dTnCxWGHmfxcamaZOq3UR1IOYYkXJwDxtBTS
 mK9DGpP2XVO5rN92ywfHcm6RRTNNhKX50/kgxgGOMaLjDZRS4RgJJ6mUsactp6nq4Qf2S+4pa9h
 RHcMeGj9OXO1A04OBJPtILVbkTMh0k0mj4MpLeB2nuzrRG/a60os5X4XmOohP/E8YVj1lkeYei4
 fiodDSTkYWS/o93tBFgF4kNzyRncE=
X-Received: by 2002:a05:7022:298:b0:15e:3a65:5b97 with SMTP id
 a92af1059eb24-190a4b29ebemr2669810c88.16.1792598270348; 
 Wed, 21 Oct 2026 08:57:50 -0700 (PDT)
X-Received: by 2002:a05:7022:298:b0:15e:3a65:5b97 with SMTP id
 a92af1059eb24-190a4b29ebemr2669780c88.16.1792598269771; 
 Wed, 21 Oct 2026 08:57:49 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-19035926035sm6521745c88.1.2026.10.21.08.57.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 08:57:49 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Wed, 21 Oct 2026 21:27:19 +0530
Subject: [PATCH v2 1/2] mach-snapdragon: scan SCSI devices in board_late_init()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261021-qcom-env-drop-scsi-scan-v2-1-0880a06974c5@oss.qualcomm.com>
References: <20261021-qcom-env-drop-scsi-scan-v2-0-0880a06974c5@oss.qualcomm.com>
In-Reply-To: <20261021-qcom-env-drop-scsi-scan-v2-0-0880a06974c5@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Michael Srba <Michael.Srba@seznam.cz>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792598262; l=2647;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=ackj3AjnYJQEjVyWBeejwguBbv0gyt5UHPgT/lfXe5c=;
 b=Sg6vDRyeG/4f14Q0t3IV2sUiv7nZPvSr72JrXvHtS85QEgx45Xmg0OFxFJ6WJ+SXSq4xh8sV4
 9eyDFmORhPzASKQ7OyRrEcBOzZwDi8cQMUK7wowMiX8svk3RaRwYHeF
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Authority-Analysis: v=2.4 cv=NrRE4MdJ c=1 sm=1 tr=0 ts=6ad8e0ff cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=AOHYocy9HzUathKzSIkA:9 a=QEXdDO2ut3YA:10
 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-ORIG-GUID: eSVCaH2Qrq0wyWztiYV-Q9tsT4FIGNiq
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA2MyBTYWx0ZWRfX9jS0yII+0qXb
 gJIU5mLHD9d7tIRQTZNThx9zSeyJw//uIq5ciRRa532ZBIx4tZIrycbV0nO1blODdzdx5pLAISo
 ZgRuktJjIsoYcC3mrVC0fq/M1t4Q0Rg=
X-Proofpoint-GUID: eSVCaH2Qrq0wyWztiYV-Q9tsT4FIGNiq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA2MyBTYWx0ZWRfX1gRljQU16LBR
 SCb/VcOCC+51RLKP5Emu/hyOlgsUQOVAJ7gfxFBgz7HA9mQ8Pzcq+TS0ODVEnQwuwC+qyJd0BJI
 x6yUmDfhJ5FKgD+ypURroozRT+sdaabQ40nhWkBet2CXPR1r0yCqCE65kSe9HEneaox9mnZh8vD
 Hbqa2cnT985Qre+uV63c29Tl7ihOZwPAkF0iUDmYuTsiykGRWsu+lMRJFG4Oj00VnIJ2bmbWHtR
 mFGZmajA6thlNOB8u/sN8+nVWH0R5fq896kJvoV4VtArkSE5Fkflw3/qkkF7SWcSxexmKFM/Kzw
 YCG8vDl76gFkyNs/qCr+NodO4SqcAJbJpC1jnKMgqwzaejCzLe+UH/2SqKDq6NAtmDLC75VmNNg
 otoc06jcJ6wvzoq1owjEZ8Bfvwc8ntalwQzlnA+qd1U7MFAiI+LQ2ZwxQu01kWstQ/JeixaRkuV
 xAlkzSgOBpItVikg/bA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 spamscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210063
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

The SCSI scan that makes UFS devices visible is done in
qcom_configure_capsule_updates(), so it only runs when capsule updates
are enabled. Move it to board_late_init() so it runs whenever
CONFIG_SCSI is set. The capsule code still needs the scan to find the
boot partition and now runs after it.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 arch/arm/mach-snapdragon/board.c          | 10 ++++++++++
 arch/arm/mach-snapdragon/capsule_update.c | 12 +-----------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
index 87adb100edd..2569f875a8a 100644
--- a/arch/arm/mach-snapdragon/board.c
+++ b/arch/arm/mach-snapdragon/board.c
@@ -21,6 +21,7 @@
 #include <linux/sizes.h>
 #include <lmb.h>
 #include <malloc.h>
+#include <scsi.h>
 #include <soc/qcom/smem.h>
 #include <sort.h>
 #include <time.h>
@@ -396,6 +397,7 @@ int board_late_init(void)
 	u32 status = 0, fdt_status = 0;
 	phys_addr_t addr;
 	struct fdt_header *fdt_blob = (struct fdt_header *)gd->fdt_blob;
+	int ret;
 
 	/* We need to be fairly conservative here as we support boards with just 1G of TOTAL RAM */
 	status |= !lmb_alloc(SZ_128M, &addr) ?
@@ -449,6 +451,14 @@ int board_late_init(void)
 	qcom_late_init();
 
 	qcom_show_boot_context();
+
+	if (IS_ENABLED(CONFIG_SCSI)) {
+		/* Scan for SCSI devices */
+		ret = scsi_scan_new(false);
+		if (ret)
+			debug("Failed to scan SCSI devices: %d\n", ret);
+	}
+
 	/* Configure the dfu_string for capsule updates */
 	qcom_configure_capsule_updates();
 
diff --git a/arch/arm/mach-snapdragon/capsule_update.c b/arch/arm/mach-snapdragon/capsule_update.c
index 353969a3cc0..33cb614782a 100644
--- a/arch/arm/mach-snapdragon/capsule_update.c
+++ b/arch/arm/mach-snapdragon/capsule_update.c
@@ -14,7 +14,6 @@
 #include <efi_loader.h>
 #include <malloc.h>
 #include <mmc.h>
-#include <scsi.h>
 #include <part.h>
 #include <linux/err.h>
 
@@ -291,20 +290,11 @@ found:
  */
 void qcom_configure_capsule_updates(void)
 {
-	int ret = 0, partnum = -1, devnum;
+	int partnum = -1, devnum;
 	static char dfu_string[32] = { 0 };
 	enum target_part_type target_part_type = 0;
 	enum uclass_id dev_uclass;
 
-	if (IS_ENABLED(CONFIG_SCSI)) {
-		/* Scan for SCSI devices */
-		ret = scsi_scan_new(false);
-		if (ret) {
-			debug("Failed to scan SCSI devices: %d\n", ret);
-			return;
-		}
-	}
-
 	partnum = find_target_partition(&devnum, &dev_uclass, &target_part_type);
 	if (partnum < 0) {
 		log_err("Failed to find boot partition\n");

-- 
2.34.1

