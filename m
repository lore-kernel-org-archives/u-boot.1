Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54032606A324
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 12:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=xt8wouWx;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=i4M2uB0r;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=N0G4CiYQ
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2B5DD60785;
	Tue,  3 Nov 2026 12:08:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Eu23ZntZEmTP; Tue,  3 Nov 2026 12:08:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3FF95606A2
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793707731;
	b=fmDWcvLxU1hVllN6kQOHkPWK8Oq/LwWQHIC6jACvlo1pIS9fEZvvczjpnmjjVgXxbDHB
	 oix1X1CN1HYKOFcrk5qLn3jptRqyvxClxK1wp1hX4mEgt7+U7en1c8uJPRiNLaFy/Qf7v
	 2dfy2bMdiTKTMaou9Q9V+EkZ02A3uJI1EZslFueFQPnf6s0UnYVxWCfFThGoHB2B2rTey
	 TC+K/U+pEqmWh57PF/U59GjkpilnGZfwYuu1AlGMAqDV6gpJa58eGIx8lXNjAzlexi4zh
	 BRl0Tzva1V2wtwZQpPdPGptd40+3eHUzy2JcAbf2RNwBKiM2SBsy5TyaxnY2iIWBJtw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793707731;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=BFP2T6tRUTp3bUTKvpG7FAiOKG8ZMqhcUEItwDGn1PA=;
	b=mTyfv0qSvArSAYzYIDvDOwXGTfEDkpRKl11cXKixcb6qrE8XTsNFwVCZJhSx6YgTJSey
	 y8Ad74VMBx0+cUVkmu2MMJoyhTRGS+puzbvF9mA30in2mQDRyx5JVQ1Zn9RwsDvMhWGUN
	 tayAP6f6zYZ4aw8ArmbNq1yCQcMG7+1vI3BUlXC4eCXBZ6BWMmyCz0jzmfO2fvZKLjAfM
	 KVjGGv7O9lIL9xjvpHrbAHeUDTePPfHu+RMfbSUH6bzkVsT9MXk4XR4p7u0qt+WAJCqIC
	 Pk1j0yeup65xg+dzpyw/DN5t59c2abcEdw82V4bm94r3p32sfkP9fPIgeKK7S++u8DQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=i4M2uB0r;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=N0G4CiYQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793707731;
	bh=BFP2T6tRUTp3bUTKvpG7FAiOKG8ZMqhcUEItwDGn1PA=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=xt8wouWx50lvKiy7Z5kKfFuWGpYWYKi8uQCI7Rz3Wa8hNip79Cqk2ZMwrtq9nO70F
	 AAF3IfsehcXCSKLZCb+l3qDS+b8nCr7bxTxxx6F8tUyRDLMHbb5TgR1Eyg3CK6ZR9y
	 p5P+2TXZT14WkimkhgHCbtMrPe2VMfz3U/R2RUjargpZEd7jS6D8SzI9qFYBh6IJFm
	 efmeD6W+a5KrgGjZV0Sn6MpPWOZrXA2vWM4KWFS8GxHeV2ZGAiH1hjSuuVF9mULim0
	 M79AoqS2fU5nf1R0hiE0LiwgP6VtOQqOPJ7nKrSEYkaK3Rfps/XD9fwo/ZIViyJJsz
	 xdVO8RtuzAV8w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3FF95606A2;
	Tue,  3 Nov 2026 12:08:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 52D6B2AC
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 12:08:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 44767606A2
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 12:08:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IXvXl4kkCesl for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 12:08:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 363EB606A0
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793707728;
 b=ALVmhQE2xbZFrVsy/KBdF2IjK6J5F/bUxIlgqM275MtiRkcDeMZHAv2K4KEQfXcmFj80
 7cRNV20X4OIpnqs66YjQvtbrh+ajeKpsVSNuyMok5hO5Tnd40HLkEK827JEd1aK7zBooF
 y07cp3uHCQYl7YOQOpsRcXomCn3Za2WLG7WeD/bFtgtuZseIokgW40Obq3WAGmfMMlgcE
 PxN4Dm9oMbiwg7ZmBPitIWYcnJZ+4PWzbe1d8YfSAiYFaNISB1D8fdpjI+QufeDqqfc0I
 EuPueVXtpd2wr36T7JCNV71/KTH+xRArvSMSjsbuJb3gjC17g2xZ5fOJhBW7RLsBX4w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793707728;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:MIME-Version:
 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=BFP2T6tRUTp3bUTKvpG7FAiOKG8ZMqhcUEItwDGn1PA=;
 b=Y0ewghzgrdZwuKUNX6dMCJdSsJEqLCX7vaOXBbqt27up9hsFINLHE+MJw66Z6DlHj1vp
 TTlQaK7sVEiqhCMoomT8bMIIaC9xIF6J4ZZf6SHppptMxVJQmxEZjHOHIR2YKhVgmkDoo
 wDRGRQlHKTtjqi1HoCLKK4YkH11ceM3WLJCECy6hdh4GsK80wZo9RycKEOxKnJEyLmIqn
 E7d4mKhU1HsrRU3BHVpv7BzWM8HVANuC9oqh+lpGNVwHHdRM5ljlSVGrwiiCUEcl8wIPS
 DTpide8xyZh/l3ib44KSuhKoMkaAHba+qaIuESKgLphLwF6zjMKHUPwVmnZOWIO328A==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=i4M2uB0r; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=N0G4CiYQ; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=abhilash.v@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=i4M2uB0r; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=N0G4CiYQ
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 363EB606A0
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 12:08:47 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A3A9xMA3130815
 for <u-boot@lists.u-boot-project.org>; Tue, 3 Nov 2026 12:08:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=BFP2T6tRUTp3bUTKvpG7FAiOKG8ZMqhcUEI
 twDGn1PA=; b=i4M2uB0rP2U9h6yKSlN3R/fOSeZdAk4SfWB8PeapU/wZwCHvZK6
 CAwCQkIs5waHcKr1wb4FDD9nrfQEI4V+rs1U3KSFndS0T3z3/f1rk67Kuxr6wNDM
 37YR/zAxDJ/vULqPgWGKM9VMyXgC1v5a6t5Xum2hkT8pE9GyUfwIPGXA9iraUlfL
 IXbFOxQuafr/PFhLPfceRCClxp8HSrc8qlp9iSjarESEuPB+h6qvqpMXqudcVjmL
 d4X2VpDiJiLWkEiWLVTjTP81mdWW+JhhLSqU4OBWSV31OZgWGhMj6zlepGidW52S
 92rFj7BV+UkAO12j1KKdWfh7bUPaSgf7cGQ==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hq94csm82-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 12:08:46 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-1b0d864826cso7301310c88.1
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 04:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793707725; x=1794312525;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=BFP2T6tRUTp3bUTKvpG7FAiOKG8ZMqhcUEItwDGn1PA=;
 b=N0G4CiYQ6zFlv3zlE83l638+m4V+oozKKTjcdZdPu2+pSjSXAhoX62o3Y1Jpa3plvi
 u2j6IldlF0L8IObbSyF///THDDk5Uint9CpR/g00ITMYggKu5cDpBlj6HOESnFMziwO2
 TmM6wcgmaeM3aJGzFbk7a2jdwtvZmK75z1nSqOiD3oApSvqm4P7nVKa0s0wLcl9IPjfE
 8TPbVWIQH3xHGOaiyu76cyOvoMc133fUrunyNtElpm9D4S55vSGr/cVZO71vJvXZBE4h
 WpTKiEuJa7ZOX2D+dZPqh1aMSiBRU7KYMyWekBVuD9ENCXcMX65CQlu63D0grar7pgSb
 fZkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793707725; x=1794312525;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=BFP2T6tRUTp3bUTKvpG7FAiOKG8ZMqhcUEItwDGn1PA=;
 b=NPfVJ0kSN6hwpedyl7bPdJGDuP2VU87Ape10nHbpDBiZR9my4rQMiSqC6MxSCOORLt
 6QlRHMlb2IU4hRlSq+EJiTANmvCOciAiSUUmyZG7KRLXqat3JicNhgx7QdKWbkwmEhvM
 M7lmB1O8WdZyrcllunPsZpTZG7kPDK3Dcz+yeHQ7m3vyUfFHzPxsQGGiL7+Kl84gVLIU
 0NfNGmHhoy9Asm5MTJudi2X7WYFyON0SZRQzANNMzDZFrNdITCNTih5nGOY8oiA3lKx1
 uNQuAeliCiqlPdOS8dFCsvL3yhnpwmk4JBjhlViGg9PuQxRThtvbXt8E0HmCW5dBTZ0v
 neaQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzjo290tgkf90AtjBJU/uk0mkFW3yzFyOMQeZyKUdOe7dE+cGUffOHGfAu7mdp8Xb0lvYTnE6Q=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/6DaN13JqaaydDdQlBI/SoB7e62+7cZxXrqq2I++kxzMcie1an
 Y83Kb9fGGHqm1GcnLxbJ4kvFIPBsybaJNKDolTvdOUUbKGf/xPxeAvJ/eQwfMpFAXBdw5AUumiS
 mmRVKaZY/1DbcHZVG6O2QeO3hBL5I0l7CvXfgf4+lGBE9wYwK4j21bzmWF2PmjWKDmHASiGqNe2
 iX28c=
X-Gm-Gg: AYBFou1VEtF2SA0x0rUtYKfxe/1Q9LOgeQI63LdplAj1Ik/huG3N0FaLZjhy2ufPQEt
 nJjt3REik5sPbTb/9M/NnvDnTVYzZgYksj/DI1QQ1x11MF9mUpiqLl/m1zDhzOI0eGq6S1FsXmb
 vJixpaL89qatt7G4W8ohsEAndThmtORdsOBWdBNc9UN53jooJK9nRozJFS4+PIR1deA4dob51Zn
 1PXWHNwkyd5S86krxb3YQzVK53+qeKr/wB+rk9IPE0cvKmTsGvzNxHlapSiRO3mJOwMYn9Ula7T
 CwiWKyxyE4Vyg5p3TYy8Gy1ZxWY5HJ7QDR+kMHwU7sxBSduJf1DyV5erN3qWhvAuicRBjmLmQFr
 cf3zSfrz8WspRTgtrPhIzBUzgyl4ptBlRmdtHP+Tu+LhULUv4EeOHMXJ0yltxhFTXlKHm0K81x6
 S8H6l4r6wgCMWepU7pSHNXjw==
X-Received: by 2002:a05:7022:b0c4:b0:144:eb46:c3f with SMTP id
 a92af1059eb24-1ac560219bamr17787425c88.2.1793707725110; 
 Tue, 03 Nov 2026 04:08:45 -0800 (PST)
X-Received: by 2002:a05:7022:b0c4:b0:144:eb46:c3f with SMTP id
 a92af1059eb24-1ac560219bamr17787372c88.2.1793707724460; 
 Tue, 03 Nov 2026 04:08:44 -0800 (PST)
Received: from hu-abhiv-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1ac1a13652csm48198640c88.17.2026.11.03.04.08.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 04:08:44 -0800 (PST)
From: Abhilash V <abhilash.v@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org,
 aswin.murugan@oss.qualcomm.com, sjg@chromium.org,
 Michael.Srba@seznam.cz, u-boot@lists.u-boot-project.org,
 kr.sowmiya@oss.qualcomm.com, varadarajan.narayanan@oss.qualcomm.com,
 balaji.selvanathan@oss.qualcomm.com, abhilash.v@oss.qualcomm.com,
 u-boot-qcom@groups.io
Subject: [PATCH v4 0/1] qcom: spl: enable CDT for shikra
Date: Tue,  3 Nov 2026 04:08:39 -0800
Message-Id: <20261103120840.1575918-1-abhilash.v@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=O+KsLx9W c=1 sm=1 tr=0 ts=6ae9cece cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=gdTGAlOGh0IRkg8vHy8A:9 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-ORIG-GUID: abPqBgdm-rPg5EFJPY5da6ZFCbgUIEvP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA0OCBTYWx0ZWRfX2LGXgIfTu472
 Mo4+o1nOnnaNSmXOuEBDzlXtrcMQ58yBODnhndORpq7XYpbuhaVFa17AeSDWV9PcTMzqpynpVm3
 k2Tt4L6VC1xtgoHvFzKt0+7GWupDWMoA1SZS5LkYePcGRv0bvnv0j8yFXV5ghAME0T7mu7mJ7k5
 ixW5tU0FtKAqhIW2e26EODUDMdXgmL9w7IqbPqQJi7hhbRUW2WDLqwFnMO4krMm2aWQycHLEJe9
 Ue3fQjT1sLZA8+AXyYqbRaVEP8ucfjntJ0paGP1thnR5NDCrn+WbYY8n8KSBJ+47y26lwBqO5up
 iLkZzk3TbP6XnEmUhrz+Ua6anfVC9W90qkUZSJuCm3YD+FYnlbAmGo+MPF0vNwETyxOZhl82IXx
 p6vymFQx+CV58UNBMZYRBCBvOMs77k9EKlAROuA852CpLdyuc/dj0EVv9CH/uZiBaRz6uW4W+7O
 gU9gsGu6MTXyw7ctcgA==
X-Proofpoint-GUID: abPqBgdm-rPg5EFJPY5da6ZFCbgUIEvP
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA0OCBTYWx0ZWRfX5LCVIolDB2+e
 zJG0ofaB77I7U0N2yshvbmLLPaRGFDAMCEfv2rzXPAbHv0FBcpT2ObzoC+vwjPyRosBuTJv6NfJ
 bLntzsP6VHCGSbpLRjC8pQPlg/z2iDg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_02,2026-11-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 suspectscore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611030048
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

Add support for loading the Config/Chip Data Table (CDT) from eMMC
during the Shikra SPL boot flow and registering it with QCLIB via
the interface table.

Depends on:
- https://lore.kernel.org/u-boot/20261029105746.3487456-1-abhilash.v@oss.qualcomm.com/

Changes in v4
- Address Tom's review comments
- Add conditional compilation for DDR and CDT related changes

Changes in v3
- Address Tom's review comment 

Changes in v2
- Address Varadarajan's review comment

KR Sowmiya (1):
  cdt: enable CDT for Shikra SPL

 arch/arm/mach-snapdragon/Kconfig            | 73 +++++++++++++++
 arch/arm/mach-snapdragon/board_spl.c        | 98 +++++++++++++++++++++
 arch/arm/mach-snapdragon/include/mach/spl.h |  1 +
 arch/arm/mach-snapdragon/qclib.c            |  8 ++
 board/qualcomm/shikra/spl-shikra.c          | 10 +++
 5 files changed, 190 insertions(+)

-- 
2.34.1

