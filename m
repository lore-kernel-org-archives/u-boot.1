Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB82606A31C
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 13:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Bzd02hGc;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NhFMpp0w;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SSWcacwz
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C758780BDD;
	Thu, 29 Oct 2026 13:33:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SjHRRA45iuCu; Thu, 29 Oct 2026 13:32:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2CCAC80F7D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793280778;
	b=ibQByy49EZafvN52yCeqMLIObW94L7aFs+ohmiXTMat37S5jgbPOwuCO/pFrnbn1kzzV
	 hVR18/gd1Xvp7WTk8YDQll600go1QN/sGTXOzxNNZLtqvwfn6nPcOnoby3daMudGD0yo7
	 gDOBgSSD4P/qAfnV4vKmZ+/P5vTqgrQ8Z1U0HxMSuLxG7ZICX8CWhmqAtzT2UmTQICsTj
	 ZivP7OWakCb/fVK0MJ+ahH//liqTkBn7NaNF2klHwKHVQVp+acVNPgOPr7QGDbL6OJ58q
	 Dj5N3rULGIFjIzanU94MUue4+FTmJAkpWQXBIpGAJtCEfyAMd+uap0gDYNuAAHoPReg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793280778;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=zPFB2q58N9DV9El75aukoJTHJrBE5Pe27CPJ0i8rJ0o=;
	b=E/3xI3XndlfTY/j1N9R3cqDqhE8Hacn3Ey/UI1phyyhP1NLQSfV92ubyB6n7NDQhnjSw
	 Kz9X8ZmX3RjQ+S3uiw1NmU9Z5k4mpJ3EMq6krcv4QY64RQTQ9dTuNt2fnkjfo2SU2LY3n
	 C2AKGLMn2g0PkO6Dk5nmgzBWy892ANhp8W23nXVq1tFhAI2XQbwSkdOXCOG/5BKbNvG07
	 EWFMWzqngdBhYTpuT8aLjVXtx0D/u4hTLkB9492EHpgoeoulMo3kQZnXjjLvAs4WVQeu8
	 ZPlY+ttg3kOrP8tOLe21DcvrxaZSYFJI00o0vLQxpPbP7PmS+c2V1AnZGDeNZ0v9Xmg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793280778;
	bh=zPFB2q58N9DV9El75aukoJTHJrBE5Pe27CPJ0i8rJ0o=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Bzd02hGcmx+HENm2yaBkAmj0Dge/SHLEszmZjTS2xpWQarnq6P0aWrIofBhLUsroW
	 EiBnnDbjol8ybqn2L1sVdYbqaDOe60W2hsXmAc96KVtnjEOBTTioqif2e67Q14OYHc
	 5qBW3LRb804JddP6fM9j0rWd2fROGOygt455ZQvuFhcE2TxFkHlR1HPYQuG4dfbONu
	 6OJD1OZyPGO7nyyneCfH6NDpNR93BdGqUFM3jSMGQtiEcViWtyeFDSlUQFo2CZTiG7
	 pM1iQeUUa2LqEZV5fn+aIK7FGkTmm/Ln4IZ7zULQ2rbbdMJDfhdzlm1l5J2Rry41U+
	 GourARsVHZPiA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2CCAC80F7D;
	Thu, 29 Oct 2026 13:32:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 6FF302FE
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 07:30:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 558786066C
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 07:30:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HM4ngkIws6q0 for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 07:30:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 385A060667
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793259023;
 b=iTyv459roNP6dXeMlaoDjmNVhBDGrVxlL2B4tKrd5d4Ow+aLsZKSb0yDpku/ITdTF8kS
 2I/yxaJQs5eI8kDz3OXUwMezpg3mel8wfjI2vNwIjzJhxSMZBB5KTgsSx58Aa8qpp5kC3
 8zaY4BVkzwa5PgTSBYxaNmXEXWCzUOEtl9vBfYFPLFMMr+OGmKajjUUY9d4KDnS6LNSBL
 mKPGcXtE6TpSUaXxMrm7Bo8AowRWLVCb0637tkcKVGgHYGyRGrQ8b3P1iWZGWoto40OmR
 +mY8k0JTRQokCSqmvzXeqSrCC7gtbkD47pzEobt//NJsd27mUwBioG5ymrvXS11IeoQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793259023;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Authority-Analysis:
 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=zPFB2q58N9DV9El75aukoJTHJrBE5Pe27CPJ0i8rJ0o=;
 b=ljX1qBfOxAkA3xaZexjAdP4Cp1gp3QAQwauG/h7bjfvzoDLluxlj3DQyGF5H9yi5B+v1
 5MZMa/tSYYR312hJvxkUSife/Ln2KJW8alQRFPfv37fv4PpMXeA0LPtuD3NwBTEZ3BI8Y
 uLlC7shNGHHZZxEd7hFN1UM7kd2MpKhY80LfTk3qEDwwGKG3aXrVJuzNvexEXd/qVk8W3
 DLSPC9+jG+fGE/mt1ujaTJtXyh9VURjB6MuSi6C6coqlgGFTNvoiH3uTNJUcbPYnVerk9
 3HaEwZUa6kn6MkWnU1FZPcJHQKfm8AkL2Fj9bC9FujoJ50VrBbmTm+TbRgPkzXxjeQA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=NhFMpp0w; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=SSWcacwz; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=kr.sowmiya@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=NhFMpp0w; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=SSWcacwz
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 385A060667
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 07:30:21 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69T5H2uj3294943
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 07:30:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=zPFB2q58N9DV9El75aukoJTHJrBE5Pe27CP
 J0i8rJ0o=; b=NhFMpp0wWSgUs5IiqjzSfDUrtHbfw11mNjP5agtcEmTQIxRN5GM
 kj0tXlk73XyvdgKgPgTsjZRbu0MwmOq1yVgB/IXptKzEAq6jjF8KZ+YTVl+WI0T6
 1mPOm6ZPFpbCLQqenKlrTbpHY7C4AVeJJYMX2PGGPwaJsbSClN0B133pj+ylr7ee
 acVr+gswkhSOKkeGgGPeTvYXi9S33ully7u5a9dEuxKSv0EUtVeVszm/D+Q5nsbP
 KRs9gKNatG02VKGITTB+EKzsjDKTw9PnXCB00LlBAwNd12wsSXxyvVKhNCA717C9
 8rJzBN0g0aFo5Q3yLn3mi8MnarwiaAYFUow==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hkxshrmr8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 07:30:20 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-36998507c13so2801766eec.0
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 00:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793259019; x=1793863819;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=zPFB2q58N9DV9El75aukoJTHJrBE5Pe27CPJ0i8rJ0o=;
 b=SSWcacwzcP8fPHhXiGKUwPRfxcCb6eDHPgc6EPGDSHzEFNEKqA9/T+qs67X7muF7+d
 A6ccwmWx0I2d2LFde+5NbgICadq5Tic9VotmUb+zmA7K1q+gNj8KbAkgfzhSXOaY1By7
 lhytIbaenUu8VfYUw2miaKq8sDsQDpA0OdazUU0FVKajfiqjeOyJ8GoveOEbpVOmrwmt
 2Atmrxfj/sFMyW3akieFXZLdrQeZHKrNl+LjDkAtDAIVq8gbvEVtN95D3OqeVVUX9L85
 BmkisONpHpVMgN4KqZlocbJrjVcmD0FdfQXLwdSNtMAu7+Yv8UxH5Fhfnq8r1xGLohVr
 Uhjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793259019; x=1793863819;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=zPFB2q58N9DV9El75aukoJTHJrBE5Pe27CPJ0i8rJ0o=;
 b=RPBx2dl5c5j8pN/9wtkmuCn5swe3OtRaaOEEfbphOD9g5pSM6dXtXSKCLcyqijTVfy
 XDLTDPMqXB7tMpRhny3gvoer+LOmGIYxjbVfIONlMsaZ50woDUDm0f9jEadc/55E306k
 1LuftnPNsQxCX3aVLAMegRpjUO872ivEfLbF0fw1DHC83beUWhElE15bo2tB4q7H8wKk
 AJhQ/YbHxD1tUYLQEvX5OkZqackDNePlHMIBf2wP83ewGHA8nJBUInoCNyf4NOHXGN+T
 4XMDeP3OUN3oLf6HTST4BWZBakyyV50KR7Q7C5XM/H1G2ZqBwbJT0k7N0WU5pA4ISGuy
 gEBw==
X-Forwarded-Encrypted: i=1;
 AKwUvByfEyOOFxRio5+5QvapCMpyNi/slz+EfnaKVO7vigCEqO89p97hgNFqFdiy1HKw/+YGKCoreUo=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYI8vYJ6TiOSDq53i+DlDuogILzLRHV9FAHPwg95Nr7Bv3uRCmsa
 666eOVGP8GohYNJ2vtCvn25SWQEZ6WWbTTF2/NTCZxMDDbrLY962TFzxPbsVbHeZevw1jONUOxy
 h9Un4SeGB3uOb+rDNJYGOhqt+le3Y81A4ArD3t/jadTc9nl7pQgoJQACUKGS5fnzsNmXlp7I=
X-Gm-Gg: AYBFou3WlOUCHDEoXKm/G8wYRXmQnyZAeBkMLbgVRzRs1bFjLYXQQuLgpL3nfEEjPcA
 u1cCcIDGNpwPlhE3bhKyG30zi2iWv3G0Kek8XWCpaNgA+dRCx3LHIKFwdRe+STNsQbB1OmuVwba
 A4PRkoqKzxcw5wcw+PLDB/n6kdMt5Wx5/JYpMFKzlCIbT7mnupuLIlDUPrQMyyiTC3cmH/vyOi9
 L0qgBgeog0mJdJPtVKaPoOs3gt9CPrGJMipsmmzO8NEJavQ6JGx64jKCmCodzrsgQb/EFDqW5gm
 IRC8+xwnA5yIFLBO5s2xr7e1KsSnu4aDLuaJIJtbNlo7LJcYgTPkFQPpeI7DiKB6YYjS9LLwZwk
 Ye/kQN/De2oOfXrQvDUsRRiKUYsIuOtUWn3XNj7j9ow0tfA6uGflCvFv2bqDdXQSEwuHr3II5N1
 6JA22PAOxeBauuXbzjSEqQXD/E9nZLE/JgbG1VgBMaomNDlbBQm7n2CZsVj1/P+qCgTA==
X-Received: by 2002:a05:7300:cf87:b0:36a:1732:1e7 with SMTP id
 5a478bee46e88-36a20400e1emr6432908eec.31.1793259019412; 
 Thu, 29 Oct 2026 00:30:19 -0700 (PDT)
X-Received: by 2002:a05:7300:cf87:b0:36a:1732:1e7 with SMTP id
 5a478bee46e88-36a20400e1emr6432852eec.31.1793259018662; 
 Thu, 29 Oct 2026 00:30:18 -0700 (PDT)
Received: from hu-ksowmiya-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a2390929asm17579098eec.12.2026.10.29.00.30.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 00:30:18 -0700 (PDT)
From: KR Sowmiya <kr.sowmiya@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org,
 aswin.murugan@oss.qualcomm.com, Michael.Srba@seznam.cz,
 kr.sowmiya@oss.qualcomm.com, sjg@chromium.org,
 varadarajan.narayanan@oss.qualcomm.com, abhilash.v@oss.qualcomm.com,
 u-boot-qcom@groups.io, u-boot@lists.u-boot-project.org
Subject: [PATCH v2 0/1] Enable DDR training in Shikra SPL  
Date: Thu, 29 Oct 2026 13:00:06 +0530
Message-ID: <20261029073007.385154-1-kr.sowmiya@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: k5WoKAV7AZfJSpsyOG_b4Tdsvgp3c14O
X-Authority-Analysis: v=2.4 cv=H6BOUOYi c=1 sm=1 tr=0 ts=6ae2f60c cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=R0JtNs4P8E7CgTWNuXIA:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDAyOCBTYWx0ZWRfXz8jvJgxWaWAE
 qX3+HF+6LjX+OB/w+2dIjRyJN7Z9H5jRU7mtplc1m3G1dzJ3ymucLpqLojyGXtGbx68NBBZSw/q
 CGEqiiQotWLU4lq6Z0ana+EVgGruEb4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDAyOCBTYWx0ZWRfX+2ZxfBf/MdjB
 gACiR1X4T0M80p979MTF60ApeKsjrxDL96PAumnQOsc5u3tzYGoSxMmmvGdzbU0HxUBr7+8iZGl
 dyxw7wdDa7nPn0bXEFgh1Z7EpgrRQrUzbiyqrCnhfQ4Pu+13zAi37KEYUvKj0QMmsORDnpo+GvX
 gm2+viVFWzz26iVMWOVYqfvXu2IgrKlNexf+Zx4DpFOPy8MplsGBt1fIf2/xrQ6y/GJvguyPOTP
 N3MJDmbgNIKAVdnTjf9+5iRMze6dHGjfWJhcXU1GLKEu/BYLEFKjr4Ud1VFAu4ax4f/8bIBzoPZ
 mtm4lSuoi00V8es9PT7MyOw0QXHgngSA0PhprNF2zjWj87fOkbycRU3POMxUOl6tE+FP1YrfOIh
 FlMHbInzKmp9svXubBycCKaXZtulfk72z4QsBGCHoMw4sc81wpg7J+07nIjzGXQyQhB1xqj6sh6
 sfA7/2i/H+VFVjHJFMA==
X-Proofpoint-ORIG-GUID: k5WoKAV7AZfJSpsyOG_b4Tdsvgp3c14O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 spamscore=0 impostorscore=0 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610290028
X-Mailman-Approved-At: Thu, 29 Oct 2026 13:32:54 +0000
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

Added support for DDR training for Shikra.

Following are added:
Reading DDR training data from eMMC during Shikra boot flow and sending it to 
QcLIB via interface table.
Saving DDR training data in eMMC when QcLIB performs DDR training and sends
the data via interface table.

Depends on:
https://lore.kernel.org/u-boot/20261013053244.2954876-1-abhilash.v@oss.qualcomm.com/


Changes in v2
- Addressed similar review comments received in 
  https://lore.kernel.org/u-boot/20261029062431.3117727-1-abhilash.v@oss.qualcomm.com/

KR Sowmiya (1):
  DDR training: enabled DDR training for Shikra SPL

 arch/arm/mach-snapdragon/Kconfig              |  66 +++++++++
 arch/arm/mach-snapdragon/board_spl.c          | 126 ++++++++++++++++++
 arch/arm/mach-snapdragon/include/mach/qclib.h |   3 +
 arch/arm/mach-snapdragon/include/mach/spl.h   |   2 +
 board/qualcomm/shikra/spl-shikra.c            |  35 ++++-
 5 files changed, 225 insertions(+), 7 deletions(-)

-- 
2.43.0

