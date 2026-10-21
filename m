Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13264606A31B
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 16:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=MJDrtJiJ;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gG3RwAqv;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dL7A6uBz
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DB1B1408E1;
	Wed, 21 Oct 2026 16:05:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FUoY92Si-n6R; Wed, 21 Oct 2026 16:05:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org BBBDE408EE
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792598722;
	b=gfUFgrJnFOWfKDLQePUYg3C7RYVWJLPzBhoHz8whfDTSkaM00GcL77zG4uhL3KLGKc+x
	 OaYQ4aiaq0B/TVnFHCmFwwuT8j7Gas71RXho0CDOv03AQyjx8tgf3CXJd4o134GlsELao
	 G5+A9JeJee+EUUW9zjzou6jNXFNiaYvsRboMjIN89WcdEDaQVtfxSy65xBhdGY4lOvYKO
	 oTKxFTskviXD6e+1MHtyilNHw4F8kU02Hq+g31gmVoj+NpZCtRLPMEY+K3L7tTS0xOZze
	 aE0WU7db9HX4F1Flkh/MmBGVPdVU/lUxLxcA1csnYrHljeE3qXTwhwmZX8ElEbHnDug==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792598722;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=wEAUQwCGUukuZszu/H3qhQgq2ASfk7D1mjkZtRF/If8=;
	b=ggR6nNvZRufwGbvHD29QsEwTnlXcF+oyjbkJkXQYQk8BM92L2GkIbRD2pgimMYGxwdAE
	 2B8fFrbpNYNf2OUv+sh2B6SAILvoFDnG2tewMAK9wIA6MpMKwuPgfp6YVMBGCi5SmSsTM
	 YeO0P9GK8Sj99oXB/qcmIjfEeD83BS8YxtHIoqmpB4XFquE58oDYzguqJB78qCeJZziSX
	 J1/GC/8iyzHu7eVAAkugEF9rcgef/rpng7k6sEkcAgYqEv1PJ30JmIf2xfMX1m4aVrJk/
	 iXgktsWScDkb+9C2uxWAQw/bIMvys5qSsdRiM5rrF9lKtp0VLhPl83FYkCzZxRWJMUw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792598722;
	bh=wEAUQwCGUukuZszu/H3qhQgq2ASfk7D1mjkZtRF/If8=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=MJDrtJiJyPCHa0jfMfs1S4iKwszrcOfJFWng10gdc3cHZ6mgc2RJIRDcn62HzxvZc
	 nBS9frRcLs5A0K3+gMupw2FYxDRVeb4H4376vAuk59DySU1zgE6haO6yi9zfbc/8o9
	 rnl++0fL1aBugLRppOxa5DnpdJ7CFG7OUXis+mffBe+OjuCw1UioENudAy7oCXPIb7
	 +180cxWphRErfcGtSMxl5ZHWB8AS2O8J4IHsVg46GAl/hg1MxakCve7YyHaWTw6C1/
	 Pbp+BVyAW7IJxfZTTy10HsLIeR3155p7o/ADKVLwVhEImFGfOB8pA1cbmOdudY9jvU
	 jA4aDTPi9Ocwg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BBBDE408EE;
	Wed, 21 Oct 2026 16:05:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 88F0195C
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:05:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6F1464016B
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:05:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8xcqV_aZHboQ for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 16:05:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 483A94039F
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792598718;
 b=EsNtWe6VWrKBt5ditA4cBzMvuz5UWUpwurKX53a4qaNFdfrgy1gHe3DR2fl1xjiOTetd
 lbTa2Iq/nCVqoiPsQxf5gPDv7JBbYoJezdlYofgK4Kr+0DNr91rk052Hh3Hv8suwYtJ3n
 9xEIYdIghTcphlP8FmpxN2sQ5LliHoSUEMvIUQOm37Dkt97yr4j6G83xWx4KD2tKceLMY
 TW7R3rk0XSJEf+UOmZwg/6kyXQUiHE3aQX3N5KuFf/kqw9VJGQOt1JxCdGteO+xIVdgMR
 vtn1tx+oG5A7GJlUy+4Z/aC+H3yT/XGeZYttQYsmnkfIYgrbyjPxo8hyrOXLO2MF2FQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792598718;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:X-Authority-Analysis:
 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=wEAUQwCGUukuZszu/H3qhQgq2ASfk7D1mjkZtRF/If8=;
 b=n0LsfcM2l5RhUVk5QbXjbo3NDeRy3ECesSazhNLzkn3AMvBzccVOXlLzO+mPFBFpvk8v
 GW9Y/n9fQRPqCoi1MeG9MpFIt7KwCJ4HeGdhHmLTtsPzv/EtPc0C2Mclw11UlZ2P+mrPv
 kyTklNlubwCXfDCmPDgazgFu6um+c3XZvq7qFHsIz4MoEQkmwxGAZIe3d7HbaWuss5DJw
 Q1z1XWCoc0EIf1yN0lfTnNnnzcQCDVbNIu9fkwrINgepGbQAW2bkYAyh5Aa7hBhVQ4yYG
 lYP/Gp3tFrTgfABXHiUclBtCk5+CGstx+n/ok02EaugJIy/UkrQf9MgANL1J9P58Wjw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=gG3RwAqv; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=dL7A6uBz; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=gG3RwAqv; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=dL7A6uBz
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 483A94039F
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:05:17 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LFUG2r4160145
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:05:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=wEAUQwCGUukuZszu/H3qhQgq2ASfk7D1mjk
 ZtRF/If8=; b=gG3RwAqv9hszLADQZNKsKzaFtCv7r/O6yuhRoKm6/nntvtndzZ2
 aNQLT+NgDJ6GjebkL+ohstbwiNi6sH42XeFevrJzU408nQnm6BuDd1W7llDlSZHI
 iqBtrCyp5GWToQBUheFEJWoUDxbUj/tn7OmkrX650lQwy4WCKVcICFtPr+6r5ASi
 /Y0Mx0CDyuTmTbXgYAo3B/O4eaHJ/a5tDwPhkZ+ky3eABnSUeOktbqZJZXCraf2d
 WEGbZ/Yupr2CmFKrYeEzB4RUptNJhdyfj+BXrApXsr07Fc3tdkznxkNJhcjZSeCY
 xEnB0W1KZe7Pk26prnxRbZKQZ7wNQp9pdjg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hex5q8r57-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:05:15 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-33c35f5ca6cso1661466eec.1
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 09:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792598714; x=1793203514;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=wEAUQwCGUukuZszu/H3qhQgq2ASfk7D1mjkZtRF/If8=;
 b=dL7A6uBz6p6A0AcPA4g/llTXzWlDGL4a4yJzCHxvxBWezAIDTe6GfoYx2vHerrvMgp
 c1fataFJgL3P/CWms69zIaCiv6VzIR+Valt/fglGrOII+it6EZKrkjD5T4GwXOjePgGC
 ht/OmhFlx6/ikt+bDOMV1wfgxQmnOuxAHSXBPkub/APe6fgSAuYHtmrsumYHEfzPQk3r
 gESCB5bv1I+1q8mSt6Aka83eq3FG2BJts+ZjybG1ZzO6+HNUWHDobfCcTtKJeIsLlpDD
 nWzueoD0lHXpVRNePN6kHpZKiEWmLyb0uEHe8jMpehb/EHHTDoNIKbFfP8bcUX8kKWJj
 PT0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792598714; x=1793203514;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=wEAUQwCGUukuZszu/H3qhQgq2ASfk7D1mjkZtRF/If8=;
 b=oCrdeAwjJrI4z57IRnvYKyRGtdS09nNpTTWOV6UmurNRbanUpcrWaC+My2GGmU/KSi
 l110qJx6Rb0E74hLE8HiW7YW3QoXPGikprryik9gnnWhCCsJzHy2Cp3P5en9xz417EgH
 N/R/bKRtDjxbfooZu0snJU7dutZXmnXk4LSxFOCx9lmAFzdo3hRrxs02+WaWKzd8gC/x
 HiGDUGRyiRjVrmtZp5LJ0KUVvS3Tdl4+XO0L0JTksmTeuo/U7xiE/IUJPI0TKKJNPaZX
 QehJgsdwzs06Or/nvYgys6D3gHDT5gNQDjASOOPu4nXUpqFs9yF+FhENyzxTLBh2CV0q
 xvKA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxTmoA67eszw2iukq1jOJgSCh12CGjNosLneMetEEORgzqMUZo53QK+hMukVPR3BBlRcEKdbYg=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLitAb79XZG7a6E8lDE8Do0qZf8v2JgKV3llFmlEqT/a2+ZRVqn
 /qjaRJzrFJVNyRQ2EdYfSGYmsCXxK1YdTzsP/GBCfG95lQxIQMfapGhYZhNXQQl97ri+xzgeV/H
 LAW66rzG38iiRlVLcQHZR1cyXdAt/ZtdK+/WtDty+67XKVDOhjAuaxXoGiO3k83EBQJr7eI4=
X-Gm-Gg: AYBFou0xoFzbeX26nIGUo0+GooWWDSUg/a7vsjM2VR4dWKNBhaw0BQT2bNf/Ew/j8aO
 kcwI0u9SiDaYK6rrx6qosqI14l9Pczu3Kxbv1ZcKqWy1vHyzS1pZ6T5W5zLnDRYAfzmm45hoqo1
 +DIyyewhbYSvJfag9rQ+29ieGJGdZxbIdRxGr5myp4bJnc5kv6hMh+ROTG2fjn7Njk1R2R7IMD3
 xoMWSiyb8K9+BVGNE8ynrkhB90VVpqgmz9Gh88baE/8YIQRsSFEegL2zcE4S6qHmDpWhLPm6n/S
 iFqfWcU7nIvVEKyZ3Wa5C4BVNgnrwxu0CZFEAo/x4mY34D8I71nIl0jO0fNAeDFvw1Njw/+fAs/
 RTIgI9w2AQVc+GaY6HuSjObP7btZYThy6CcdClCXi6ycRy+nxBgGhlHKnh0BIiMVnEdnHVdIDgw
 nyLKmaWAkjlhqNftlF6rY=
X-Received: by 2002:a05:7023:a5a:b0:158:7ea9:4a5c with SMTP id
 a92af1059eb24-190a632eb91mr2764338c88.27.1792598712570; 
 Wed, 21 Oct 2026 09:05:12 -0700 (PDT)
X-Received: by 2002:a05:7023:a5a:b0:158:7ea9:4a5c with SMTP id
 a92af1059eb24-190a632eb91mr2764288c88.27.1792598711685; 
 Wed, 21 Oct 2026 09:05:11 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1903d3ae06fsm7480185c88.19.2026.10.21.09.05.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 09:05:10 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com, lukma@nabladev.com,
 marek.vasut+usb@mailbox.org, aswin.murugan@oss.qualcomm.com,
 Michael.Srba@seznam.cz, nathbappai@gmail.com, nikroks@mainlining.org,
 luca.weiss@fairphone.com, jbx6244@gmail.com, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v3 0/8] arm64: qcom: Add initial support for Nord SoC
Date: Wed, 21 Oct 2026 21:34:40 +0530
Message-Id: <20261021160448.3893858-1-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA2NCBTYWx0ZWRfX4rKfuRgWiNpT
 +Ij0E4n5mYzpTf42kvxiNXgg0PyDj/ZWipfvcWBIOKLM+Qg36AkUJ/hKciAoGh0qGOWtYA+xxGa
 7uCwUpRhjJHQgnW5R2ZSqP1Z+IQ/fzI=
X-Authority-Analysis: v=2.4 cv=eJaGH3p1 c=1 sm=1 tr=0 ts=6ad8e2bb cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=gu6fZOg2AAAA:8 a=-KWCMSehS6Sf777T99UA:9
 a=bBxd6f-gb0O0v-kibOvt:22 a=2RSlZUUhi9gRBrsHwhhZ:22
X-Proofpoint-GUID: awucDd_En62QSTPvz8ss2So0tvCW1a7c
X-Proofpoint-ORIG-GUID: awucDd_En62QSTPvz8ss2So0tvCW1a7c
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA2NCBTYWx0ZWRfX29JCspR4hteb
 WbtAicNVdGtn7nsit8Zg/Gn+ZosVT+NAIoHqAoSQ6sy7KskeT7bcddN/rDd20Gl8g20JtthXSy8
 FwBKkMU1GKBCsyJg10jeiGOzI2amvrGrd5+pwWphrwRsJWmkvc5rNa3a2YfitoF/i648JG14Wu+
 Q+VqLOIb/REF141ne8P1O8WM7S1fG88rHax2l7H0KAjqz2JN42tb89Q0oxFdVuV3iYIp1a4dVYP
 ao9xd2Is5Cde/Ftboqa5mjBvcxYxmWrQv7oqmotv+JYxOGcX1cNIUP4BCqiKyg/Xk52Fc5TicfM
 btzcmyygoVpRoXUC85uBPOMRfEp42djszO+k1MooHFV3cizEDobOOadQaShno+aSZqRrRLRUANk
 TuQdA3NJWaObqiSuuCQXrvmsG57OfX50JwSHvEngFAE3nqmn57NyrvFtkR+TGn5zWCKAFwDob+Z
 cjWlJssoVMpwgza88TQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 adultscore=0 spamscore=0 clxscore=1015 bulkscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610210064
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series adds foundational support for the Qualcomm Nord SoC in
U-Boot, including clock, pinctrl, USB HS PHY, and configuration updates
required for early platform enablement.

The series includes:

  - Clock driver support for Nord
  - Pinctrl driver support for Nord TLMM
  - USB HS PHY support for Nord
  - Configuration updates required for platform enablement

Changes in v3:
 - Drop the DT binding patch since it is now available upstream.

Link to v2: https://lore.kernel.org/u-boot/20260928120209.1064781-1-aswin.murugan@oss.qualcomm.com/

Changes in v2:
  - Drop DT patches; they will be synced once the corresponding changes
    land in the upstream Linux kernel
  - Drop Nord-specific defconfig
  - Drop ELF 4K-alignment support changes
  - Add USB HS PHY support for Nord
  - Retain only clock, pinctrl, USB, and platform enablement changes
  - Address review comments from v1

Link to v1: https://marc.info/?l=u-boot&m=178695918491771&w=2

Aswin Murugan (8):
  clk: qcom: add GCC driver for nord
  clk: qcom: add NEGCC driver for nord
  clk: qcom: add SEGCC driver for nord
  clk: qcom: add NWGCC driver for nord
  clk: qcom: add TCSRCC driver for nord
  configs: qcom_defconfig: enable nord clock drivers
  pinctrl: qcom: add TLMM driver for nord
  phy: qcom: snps-eusb2: add Nord compatible

 configs/qcom_defconfig                 |   5 +
 drivers/clk/qcom/Kconfig               |  43 ++
 drivers/clk/qcom/Makefile              |   5 +
 drivers/clk/qcom/clock-nord-gcc.c      | 165 +++++++
 drivers/clk/qcom/clock-nord-negcc.c    | 186 ++++++++
 drivers/clk/qcom/clock-nord-nwgcc.c    |  91 ++++
 drivers/clk/qcom/clock-nord-segcc.c    | 137 ++++++
 drivers/clk/qcom/clock-nord-tcsrcc.c   |  88 ++++
 drivers/phy/qcom/phy-qcom-snps-eusb2.c |   3 +
 drivers/pinctrl/qcom/Kconfig           |   8 +
 drivers/pinctrl/qcom/Makefile          |   1 +
 drivers/pinctrl/qcom/pinctrl-nord.c    | 626 +++++++++++++++++++++++++
 12 files changed, 1358 insertions(+)
 create mode 100644 drivers/clk/qcom/clock-nord-gcc.c
 create mode 100644 drivers/clk/qcom/clock-nord-negcc.c
 create mode 100644 drivers/clk/qcom/clock-nord-nwgcc.c
 create mode 100644 drivers/clk/qcom/clock-nord-segcc.c
 create mode 100644 drivers/clk/qcom/clock-nord-tcsrcc.c
 create mode 100644 drivers/pinctrl/qcom/pinctrl-nord.c

-- 
2.34.1

