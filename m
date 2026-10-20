Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1368160A2600
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 15:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=BzQKj+YU;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=W0CfScLM;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XmjZ6K5l
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BBDED6082B;
	Tue, 20 Oct 2026 15:38:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uCKbRD5v_Wdo; Tue, 20 Oct 2026 15:38:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org ED68A6085D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792510724;
	b=b+vlFvDJtkSeO5tH8stsdsYul7NRQACIeayDB/ZEl0IdmKRY1/aRF/42PFtSVC9vQAcW
	 EDeQPG/rXzSpXmPucFm8XnqJPredLgHCdoTnA9cMVG3Ogf5TRnIX18/0vPnTtjdH54kG2
	 sDNmPUA3Jit8cJYYCV3Y7yY9ASWg1NOHNPA2zYzM3WQuqEzEs3B1EH8qM2lUbxY+WLYzs
	 3/y+M1SG2eWKBcQ2JyTerZALtTvoIqXHjGws81V7piDWZV4NRYhRCj8qzyA4yvvjjB7Qv
	 bLc+OqBgcVigIyksb1npZOCyiWOc6T5L62VBsB6CUoL4EpxH77bVyfyBVHcZIEkrDyw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792510724;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=mKRdlQlSq/OAg/I+EigJiVcKpWxqwORMfURTlY2UNN4=;
	b=WDRj84ZxTQDzAj60Lzc9/3VXinWDi+US/O/K1D/bWpWSBgGaPTbhn61iZlDClRFp2DSf
	 hYkt8FRLATzcI29Fp6VdkWr/qCuuXfuJwi+4lKNAEqffa2F6jV6vlb+vzN3u5JEvUhjKU
	 uLbwHF4eMs5EA0q4fYV8+MGkCj6qYjx30mMlTmWT+UUT5/wfg2X2WeFjlpx2GyAYC4b2o
	 RJHBjR1kHvTlXtHYil7h0U9T5Ql2t5Qwoz+Yd6jKA5GqseZgZLxgLpAREcq7nhVhYMZxh
	 vZHTS/a/XzNxQuSczgFiHcHxIje62YTuLU/9uZWseYAsO5SfNLZ6YWipb8dTcu/1+RA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792510724;
	bh=mKRdlQlSq/OAg/I+EigJiVcKpWxqwORMfURTlY2UNN4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BzQKj+YUaLgBxcM+nnad1ap8iVL35L1AHDszOLD5mZ7fEi7W0OfKFKkFFjm7pB7Au
	 aHSC2ygDj/ObEE3PBFTuegupCVZxEEcTmy+6ZoxX2xSbC9PxANUNJJpOzac4jv7kcG
	 a6jGO0MON7jCr0J85QnoIgOULRymZMZfrZhtWq30Pl4KPPjYfrO5jRjrrAHldodvx/
	 /z1tu7negsvNqv5mqs98viAM9SX377KF+AMxF1PXO+caiC/k/l5NN5IHulnV1uUp0l
	 LgZa5uGO7Uq8xeg/uV4SoUlGv73eUmY4+w7SkT42GE4EEZCLxALNaS5i/y0jz0QQ79
	 25hNPUYyaqinQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id ED68A6085D;
	Tue, 20 Oct 2026 15:38:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1789C75
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 15:38:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1309380538
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 15:38:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZewyaJGydZ5S for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 15:38:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org DBB6A8102D
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792510719;
 b=It+2zvFdPCgd5t8m+6O7+N5+qxyZpyVQoi6ikU7zEfKevXgPCDcU6Ykd5DHn/zlkn42U
 4KEiumZtzPf6lkEfrngbEVPNSIlj7uWZ0Krr79Xf1x+B6Xy3zh0fuL3faBK8xN4I6moF2
 FKhyA6RYMm4kfgIAQf9dN/u3VJhh7VhnQyvgmoI8v5X8gJtzlowhS73nP7RYNdXVSEOiK
 B8P95XDaKTkxgkZz6G1zExmqEOgXPtpszRSBSgf3q1pLf3/J6/49fCskzEzDt9xkBs78F
 lXyUOTurWGuWZbohHLRYM2UPSRpnk2nlRhsN+AINtNL9As+z2cifbKFBcXStjwxowEQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792510719;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=mKRdlQlSq/OAg/I+EigJiVcKpWxqwORMfURTlY2UNN4=;
 b=NMvsjAhfeIDsqaIkhQjogdwNK/L2i4ZZGp8p7R+lmS4u2FIG7Q2ez3r8tSOFd7zS3lTA
 C66ToX/C4Lud+o57FuGtMcUMp7Hh6hwhiXQS/3ITzW0kXweWq5IYUZJ5rLo8aT71W5yrV
 aAmYHqyCpvIgeVUcBi9CpuFefnFBIwRaa1zAJVYIVm0cbf3RvZ2uDAf7ekh8b8FZ4agZx
 LBDI6ScJA1/fjTWlmCPW50LS7QHaZzreiHym+EGtkKrBHiklYXwgzPaYjN9nOP7hJnWNa
 lo4ktB/KQPQ196YHgGY852i5lt4K8gQyr5d//O3JUYSiaImoZ9vHP8UZhatdMHl12Qw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=W0CfScLM; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=XmjZ6K5l; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=W0CfScLM; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=XmjZ6K5l
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DBB6A8102D
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 15:38:38 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69KFPxDv2031006
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 15:38:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 mKRdlQlSq/OAg/I+EigJiVcKpWxqwORMfURTlY2UNN4=; b=W0CfScLMsK/pFKYP
 1m/gYIXyX/zlue3UKmXE57e7zxVuEggDJg5N76GKddnd0moiB7pOi5f9a2yKqqPv
 OcbAOdyQj5JXHXZjV1Yk0PU3nKGSoBxfsay5DQ8SNZa6TnbVtdIoZ1hP2reo/Psb
 XaL/cSv69JIJkL98G5kKbZIVfO8gUNRoqQIt+cN2tcvCIGKCUTrb1AEVjanH8vaZ
 4ptwBSybdiRZYSzkud0i8lONioO6p7SQ1DYYVBaa/aclqp39aR1WbRj2jXSNxxHu
 fIovEFs5ykMKXkAANQymixgPIJpMvFc6f3d86Zljqr9aZlgQXUAAa4R7ZvGLtqSq
 pCg09Q==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdw5n3788-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 15:38:37 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93909014c85so744086785a.0
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 08:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792510717; x=1793115517;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mKRdlQlSq/OAg/I+EigJiVcKpWxqwORMfURTlY2UNN4=;
 b=XmjZ6K5lkMuKPuSj2BWrkCpqfDbjIgI8wcaDeIpbeJlon7ejK1amHTzXolLJpjNNL9
 M0KvnJrrqtf5JepFDwlcVono9SD7vvkuajwAh5+/QuKhiU9mGQOsbJeEYLLlPHVzIy75
 Naj+I8YW8+DFyk/2Gvx7riNrNV1rSlw30FgldXEI6XECl5hXFaqAimR5vB6tyyqYZwZe
 FHyS0+wkFplwXtoF3z8RlMexFmDSuf7dPN3GxowkXMPbVkWZ4PnOO/zK+9yS8dkaIVOJ
 wyA8fg9i/6mTft1tnoBUlG0SZ/DhH/Pjnf0vIU4oi3zVZIpN9EZ+QXb4nyGcy+bw5Fy9
 vkfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792510717; x=1793115517;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mKRdlQlSq/OAg/I+EigJiVcKpWxqwORMfURTlY2UNN4=;
 b=AVbqHPEWkcN/ZtQUD6YiSmu+1ZPdRJSjUq7cf5HMp290Th+Us69ASkYxJoqTTbRXY4
 dht4fRVFlOSlW1RDA8ok9DJoVqdVP6AFD9HAXnNC1Prh7J8FaAgosu4yq7VrRSe39FiK
 cS7WiaqU8KaOc4fRpGfk/yu1T6kBFqm0VDlpfpVCueI8GAXqdNm0yz5LHO+5hZ9S6rGD
 MVDvJy5SU1OPyAJA7Qd0m5CtYs2YcufnonBxp4pV6MiU9QM9jho5NBftJZXcKJc8AHJm
 5QvYVejb1KYnfvrIDVPgDSDWtBP76/LwMP3iyomF7nyu07ZDzeM2TBWTukDaLe0umcCi
 nW9w==
X-Forwarded-Encrypted: i=1;
 AKwUvBwMjIQRVrtUUrT16I1G/kCsf6FFy2ztc+cr+JxopzNbyq2fa+MpG01nRRBus9NQmdVjHTNGhNY=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLNlNaCRUixKpapMJ//YRDValM/715HWrZMd/MvIcD2+3Txq+3a
 AKfztwDmX2YMTIambbaiBKQbfx8K+Y3SW9Nu1TSQalIvY1/bXgiCzJVd6RR6tFQtynVlyUI6LgL
 sYnlMs/PTO50LSOGhO6C0esX4SrntcehVbXB1vSG8nHSlwTQdtN9dg9zpZNFrb4BC5jmjQ2E=
X-Gm-Gg: AYBFou1HSmbOVXcxgmjdFoppbrcuk92Sm3fnkxySlqpWAKeeg6W0TEPrONO69io0R5T
 To4nVl2l+SGA4A51xUEmtWmJlU8tOZxrdMcU63qYq8ruI7VS+Tmk7QY2jzjhkNHhR6+k0Us3c21
 cvHIZzErfuQ6vHiCvRTyPwN/Uv5e6QKiO1CSCon/IMmFJNii2od2WxA+6aVD3jDdFLldXWWk9Oq
 DR/b6TUePT3Fcs6QazLupiT5aLvBqIpzA/eCD0r2n1rEYRITuiVExbCNALA6Mivj8DdgwcQuble
 cs7t4BJ9FHXjc5KlW+bVQG0f0C0Xnjoovwl07v/8wnzWDYssFLzPAw+Hs6h+lZlzGFECHlrt8mY
 LdiTEPREufoKVA73cKzsbLig0nmGgJ2g6f0ernO2kKyd8
X-Received: by 2002:a05:620a:7101:b0:93f:2465:26d9 with SMTP id
 af79cd13be357-93f29c949aemr1888634585a.18.1792510716479; 
 Tue, 20 Oct 2026 08:38:36 -0700 (PDT)
X-Received: by 2002:a05:620a:7101:b0:93f:2465:26d9 with SMTP id
 af79cd13be357-93f29c949aemr1888628585a.18.1792510715893; 
 Tue, 20 Oct 2026 08:38:35 -0700 (PDT)
Received: from [127.0.1.1] (185-164-141-21.cgnat.inetia.pl. [185.164.141.21])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b38a1b140fsm5574963a12.9.2026.10.20.08.38.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 08:38:34 -0700 (PDT)
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Tue, 20 Oct 2026 17:38:11 +0200
Subject: [PATCH v3 4/5] fastboot: add flashing lock/unlock/get_unlock_ability
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261020-upstream-avb_lock_unlock_b4-v3-4-e280795a98cc@oss.qualcomm.com>
References: <20261020-upstream-avb_lock_unlock_b4-v3-0-e280795a98cc@oss.qualcomm.com>
In-Reply-To: <20261020-upstream-avb_lock_unlock_b4-v3-0-e280795a98cc@oss.qualcomm.com>
To: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Shahriyar Jalayeri <shahriyar@byteray.co.uk>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Pengpeng Hou <pengpeng@iscas.ac.cn>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ahmad Fatoum <a.fatoum@pengutronix.de>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Jan Kehren <jan.kehren@emteria.com>,
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-GUID: desBpnTxKHEfHixyCcZ5kUUe9OqzjHlS
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA2MiBTYWx0ZWRfX38jq2RcqcTAD
 6cUUWTBpIj/WPjqojLkXMYvvklOJ0HVQ9RmdfTeuSLFAJr6PZrvj/bQbdXQTqwnBxPet8ii4Zmt
 f2jpYXZ7Xrel2PlJH7jFfMVEMWWHRpE=
X-Proofpoint-ORIG-GUID: desBpnTxKHEfHixyCcZ5kUUe9OqzjHlS
X-Authority-Analysis: v=2.4 cv=A5z5rKWG c=1 sm=1 tr=0 ts=6ad78afd cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=JsdSkJyxCPcZmfxNhm0PvA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=GIEJCeLk9wm3ZTHTIfMA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA2MiBTYWx0ZWRfXy+Vy+4r8O5la
 td4dG87axTdfvS1GQIVXvC9lFqm+OBtzrrUC2ZFeQEPkYcctoVtajhfo8YtvqAD6+Wu7WC1uuEX
 8wPfDUYuQ9MVTXiO9EI+wahuWXMQnquji979ASZP4EFusE6JMqFr7mHTMvtqMt5eLcKg2oyfGIS
 T78pwf4cJ0IiSJsWC3SRJL2mQ7CsgedO1nclJqHR+iS0WZJ1H7j7KGTHMTUMXZVgUTv11JeJVSi
 24uf31EMOjXZhfK25LVcvD3kQC/EdChnuCgmrnZisAC/y/9gfMesoZ1/5iQ0A07G9fNHvHGMhq1
 Q2V6ro3ntEOklioebRdICShywxFZMkVbmY08Kg/FEgkEuAph/Ihw///0mT5ER5Ni530Aw/JjFSU
 8wuo8BkYpcSsJm7SXcHmkxzVtfLvNgli+5Zf2gwBPB8HbJe0KEt72IeM8Xln99sKaMEssRO+xZU
 YOuYtf9VsqjUDGM69gA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_02,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 adultscore=0 priorityscore=1501 suspectscore=0
 phishscore=0 spamscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610200062
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

Android's fastboot client changes the device lock state with
"fastboot flashing lock|unlock" and asks "flashing get_unlock_ability"
first. U-Boot has the state in the AVB TA (avb_write_lock_state(), used by
the "avb lock/unlock" shell commands) but no fastboot front end for it, so
a device could only be unlocked from the serial console. The state also
had no effect on fastboot: a locked device still accepted "flash" and
"erase".

Add the three commands and the "unlocked" variable behind
CONFIG_FASTBOOT_CMD_FLASHING. As AVB requires, both transitions erase
userdata (and metadata, which holds the file based encryption keys) before
the state changes and are refused when userdata cannot be erased; the TA
resets the rollback indexes on a state change. The erase goes through the
configured flash back end, like the "erase" command, and the lock state
itself lives in the TA, so nothing here depends on the storage type.

While the device is locked, "flash" and "erase" fail with "device is
locked"; "flashing unlock" is the only way out of that state. Unlocking
follows the "OEM unlocking" developer setting Android keeps in the last
byte of its frp (persistent data block) partition, looked up on the
fastboot flash device of the mmc or block back end: get_unlock_ability
reports it and "flashing unlock" is refused unless it is set. A device
without an frp partition, or a back end without a partition table, can
always be unlocked; a partition that cannot be read never.

Tested on QEMU virt with OP-TEE over "fastboot tcp": unlock and lock
erase the partitions and flip the state reported by getvar unlocked and
"avb is_unlocked", flash and erase are refused while locked, and unlock is
refused while the OEM unlocking byte in frp is clear.

Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
---
 drivers/fastboot/Kconfig      |  15 +++
 drivers/fastboot/fb_command.c | 275 +++++++++++++++++++++++++++++++++++++++++-
 drivers/fastboot/fb_getvar.c  |  22 ++++
 include/fastboot.h            |  14 +++
 4 files changed, 321 insertions(+), 5 deletions(-)

diff --git a/drivers/fastboot/Kconfig b/drivers/fastboot/Kconfig
index 1887f78bcec..3f71f662d3c 100644
--- a/drivers/fastboot/Kconfig
+++ b/drivers/fastboot/Kconfig
@@ -248,6 +248,21 @@ config FASTBOOT_MBR_NAME
 	  specified on the "fastboot flash" command line matches the value
 	  defined here. The default target name for updating MBR is "mbr".
 
+config FASTBOOT_CMD_FLASHING
+	bool "Enable the 'flashing lock/unlock/get_unlock_ability' commands"
+	depends on FASTBOOT_FLASH && AVB_VERIFY && OPTEE_TA_AVB
+	help
+	  Add the Android "flashing lock", "flashing unlock" and "flashing
+	  get_unlock_ability" commands and the "unlocked" variable. The device
+	  lock state is the one AVB enforces, kept by the OP-TEE AVB TA. While
+	  the device is locked, "flash" and "erase" are refused. As required by
+	  AVB, the userdata (and metadata) partition is erased before the state
+	  changes in either direction, and the TA resets the rollback indexes
+	  on a state change. Unlocking is only allowed when Android's "OEM
+	  unlocking" developer setting, kept in the frp partition of the
+	  fastboot flash device, permits it; without an frp partition (or with
+	  a back end that has no partition table) it is always allowed.
+
 config FASTBOOT_CMD_OEM_FORMAT
 	bool "Enable the 'oem format' command"
 	depends on FASTBOOT_FLASH_MMC && CMD_GPT
diff --git a/drivers/fastboot/fb_command.c b/drivers/fastboot/fb_command.c
index 18d86988f4c..9d3127ee7a4 100644
--- a/drivers/fastboot/fb_command.c
+++ b/drivers/fastboot/fb_command.c
@@ -12,10 +12,15 @@
 #include <fb_mmc.h>
 #include <fb_nand.h>
 #include <fb_spi_flash.h>
+#include <memalign.h>
 #include <part.h>
 #include <stdlib.h>
 #include <vsprintf.h>
 #include <linux/printk.h>
+#if CONFIG_IS_ENABLED(FASTBOOT_CMD_FLASHING)
+#include <avb_verify.h>
+#include <blk.h>
+#endif
 
 /**
  * image_size - final fastboot image size
@@ -47,6 +52,14 @@ static void oem_console(char *, char *);
 static void oem_board(char *, char *);
 static void run_ucmd(char *, char *);
 static void run_acmd(char *, char *);
+#if CONFIG_IS_ENABLED(FASTBOOT_CMD_FLASHING)
+static void flashing_lock(char *, char *);
+static void flashing_unlock(char *, char *);
+static void flashing_get_unlock_ability(char *, char *);
+static bool flashing_refuse_if_locked(char *response);
+#else
+static inline bool flashing_refuse_if_locked(char *response) { return false; }
+#endif
 
 static const struct {
 	const char *command;
@@ -128,6 +141,20 @@ static const struct {
 		.command = "ACmd",
 		.dispatch = CONFIG_IS_ENABLED(FASTBOOT_UUU_SUPPORT, (run_acmd), (NULL))
 	},
+	[FASTBOOT_COMMAND_FLASHING_LOCK] = {
+		.command = "flashing lock",
+		.dispatch = CONFIG_IS_ENABLED(FASTBOOT_CMD_FLASHING, (flashing_lock), (NULL))
+	},
+	[FASTBOOT_COMMAND_FLASHING_UNLOCK] = {
+		.command = "flashing unlock",
+		.dispatch = CONFIG_IS_ENABLED(FASTBOOT_CMD_FLASHING, (flashing_unlock), (NULL))
+	},
+	[FASTBOOT_COMMAND_FLASHING_GET_UNLOCK_ABILITY] = {
+		.command = "flashing get_unlock_ability",
+		.dispatch = CONFIG_IS_ENABLED(FASTBOOT_CMD_FLASHING,
+					      (flashing_get_unlock_ability),
+					      (NULL))
+	},
 };
 
 /**
@@ -339,6 +366,9 @@ void fastboot_data_complete(char *response)
  */
 static void __maybe_unused flash(char *cmd_parameter, char *response)
 {
+	if (flashing_refuse_if_locked(response))
+		return;
+
 	if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_BLOCK))
 		fastboot_block_flash_write(cmd_parameter, fastboot_buf_addr,
 					   image_size, response);
@@ -365,19 +395,27 @@ static void __maybe_unused flash(char *cmd_parameter, char *response)
  * Erases the partition indicated by cmd_parameter (clear to 0x00s). Writes
  * to response.
  */
-static void __maybe_unused erase(char *cmd_parameter, char *response)
+static void __maybe_unused erase_partition(const char *name, char *response)
 {
 	if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_BLOCK))
-		fastboot_block_erase(cmd_parameter, response);
+		fastboot_block_erase(name, response);
 
 	if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_MMC))
-		fastboot_mmc_erase(cmd_parameter, response);
+		fastboot_mmc_erase(name, response);
 
 	if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_NAND))
-		fastboot_nand_erase(cmd_parameter, response);
+		fastboot_nand_erase(name, response);
 
 	if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_SPI))
-		fastboot_spi_flash_erase(cmd_parameter, response);
+		fastboot_spi_flash_erase(name, response);
+}
+
+static void __maybe_unused erase(char *cmd_parameter, char *response)
+{
+	if (flashing_refuse_if_locked(response))
+		return;
+
+	erase_partition(cmd_parameter, response);
 }
 
 /**
@@ -589,3 +627,230 @@ static void __maybe_unused oem_board(char *cmd_parameter, char *response)
 {
 	fastboot_oem_board(cmd_parameter, (void *)fastboot_buf_addr, image_size, response);
 }
+
+#if CONFIG_IS_ENABLED(FASTBOOT_CMD_FLASHING)
+/**
+ * flashing_flash_dev() - block device of the fastboot flash back end
+ *
+ * Return: the device of the mmc or block back end, NULL for back ends
+ * without a block device (nand, spi)
+ */
+static struct blk_desc *flashing_flash_dev(void)
+{
+	if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_MMC))
+		return blk_get_dev("mmc",
+				   config_opt_enabled(CONFIG_FASTBOOT_FLASH_MMC,
+						      CONFIG_FASTBOOT_FLASH_MMC_DEV, -1));
+
+	if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_BLOCK))
+		return blk_get_dev(config_opt_enabled(CONFIG_FASTBOOT_FLASH_BLOCK,
+						      CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME,
+						      ""),
+				   config_opt_enabled(CONFIG_FASTBOOT_FLASH_BLOCK,
+						      CONFIG_FASTBOOT_FLASH_BLOCK_DEVICE_ID,
+						      -1));
+
+	return NULL;
+}
+
+/**
+ * flashing_avb_ops() - AVB ops for the lock state calls
+ *
+ * The lock state is kept by the AVB TA and these ops never read a
+ * partition, so the storage device is only informational: the fastboot
+ * flash device when it is a block device, none otherwise.
+ *
+ * @response: fastboot response buffer, filled on failure
+ * Return: the ops, to be released with avb_ops_free(), or NULL
+ */
+static AvbOps *flashing_avb_ops(char *response)
+{
+	struct blk_desc *desc = flashing_flash_dev();
+	AvbOps *ops;
+
+	ops = avb_ops_alloc(desc ? desc->uclass_id : UCLASS_INVALID,
+			    desc ? desc->devnum : -1);
+	if (!ops)
+		fastboot_fail("cannot allocate AVB ops", response);
+
+	return ops;
+}
+
+int fastboot_flashing_is_unlocked(bool *unlocked, char *response)
+{
+	AvbOps *ops;
+	AvbIOResult rc;
+
+	ops = flashing_avb_ops(response);
+	if (!ops)
+		return -1;
+
+	rc = ops->read_is_device_unlocked(ops, unlocked);
+	avb_ops_free(ops);
+	if (rc != AVB_IO_RESULT_OK) {
+		fastboot_fail("cannot read the device lock state", response);
+		return -1;
+	}
+
+	return 0;
+}
+
+/**
+ * flashing_refuse_if_locked() - fail a flash or erase on a locked device
+ *
+ * A locked device must not let fastboot change its partitions; only
+ * "flashing unlock", which wipes userdata, may be used to leave that state.
+ *
+ * @response: fastboot response buffer, filled when the command is refused
+ * Return: true if the command must not run
+ */
+static bool flashing_refuse_if_locked(char *response)
+{
+	bool unlocked;
+
+	if (fastboot_flashing_is_unlocked(&unlocked, response))
+		return true;
+	if (!unlocked) {
+		fastboot_fail("device is locked", response);
+		return true;
+	}
+
+	return false;
+}
+
+/**
+ * flashing_set_lock() - set the AVB device lock state through the AVB TA
+ *
+ * @locked: new state
+ * @response: fastboot response buffer, filled on failure
+ * Return: 0 on success, -1 otherwise
+ */
+static int flashing_set_lock(bool locked, char *response)
+{
+	AvbOps *ops;
+	AvbIOResult rc;
+
+	ops = flashing_avb_ops(response);
+	if (!ops)
+		return -1;
+
+	rc = avb_write_lock_state(ops, locked);
+	avb_ops_free(ops);
+	if (rc != AVB_IO_RESULT_OK) {
+		fastboot_fail("cannot change the device lock state", response);
+		return -1;
+	}
+
+	return 0;
+}
+
+/**
+ * flashing_wipe_userdata() - erase userdata and metadata
+ *
+ * AVB requires user data to be wiped on every change of the device state,
+ * in either direction, so userdata (and metadata, which holds the file
+ * based encryption keys) are erased before the state changes. The erase
+ * goes through the configured flash back end, like the "erase" command,
+ * but without the lock check, since this is how a locked device gets
+ * unlocked.
+ *
+ * @response: fastboot response buffer, filled on failure
+ * Return: 0 on success, -1 when userdata could not be erased
+ */
+static int flashing_wipe_userdata(char *response)
+{
+	erase_partition("userdata", response);
+	if (!strncmp(response, "FAIL", 4))
+		return -1;
+
+	/* metadata is optional on older layouts */
+	erase_partition("metadata", response);
+
+	return 0;
+}
+
+/**
+ * flashing_unlock_allowed() - evaluate Android's "OEM unlocking" setting
+ *
+ * Android keeps the developer option "OEM unlocking" in the last byte of
+ * the frp (persistent data block) partition: 1 when the user allowed the
+ * bootloader to be unlocked. Back ends without a partition table (nand,
+ * spi) and devices without an frp partition have no such setting, so
+ * unlocking stays possible; a partition that cannot be read refuses it.
+ *
+ * Return: true if "flashing unlock" may proceed
+ */
+static bool flashing_unlock_allowed(void)
+{
+	struct disk_partition info;
+	struct blk_desc *desc;
+	bool allowed;
+	u8 *buf;
+
+	desc = flashing_flash_dev();
+	if (!desc || part_get_info_by_name(desc, "frp", &info) < 0)
+		return true;
+
+	buf = malloc_cache_aligned(info.blksz);
+	if (!buf)
+		return false;
+
+	if (blk_dread(desc, info.start + info.size - 1, 1, buf) != 1) {
+		free(buf);
+		return false;
+	}
+	allowed = buf[info.blksz - 1] == 1;
+	free(buf);
+
+	return allowed;
+}
+
+/**
+ * flashing_lock() - lock the device
+ *
+ * Verification errors stop the boot afterwards. The AVB TA resets the
+ * rollback indexes on a state change. Locking needs no permission from
+ * the OS: it only takes privileges away.
+ */
+static void flashing_lock(char *cmd_parameter, char *response)
+{
+	if (flashing_wipe_userdata(response))
+		return;
+
+	if (flashing_set_lock(true, response))
+		return;
+
+	fastboot_okay(NULL, response);
+}
+
+/**
+ * flashing_unlock() - unlock the device
+ *
+ * Refused when Android's "OEM unlocking" setting does not allow it, and
+ * when userdata cannot be erased.
+ */
+static void flashing_unlock(char *cmd_parameter, char *response)
+{
+	if (!flashing_unlock_allowed()) {
+		fastboot_fail("unlocking is not allowed, enable OEM unlocking in Android",
+			      response);
+		return;
+	}
+
+	if (flashing_wipe_userdata(response))
+		return;
+
+	if (flashing_set_lock(false, response))
+		return;
+
+	fastboot_okay(NULL, response);
+}
+
+/**
+ * flashing_get_unlock_ability() - report whether unlocking is allowed
+ */
+static void flashing_get_unlock_ability(char *cmd_parameter, char *response)
+{
+	fastboot_okay(flashing_unlock_allowed() ? "1" : "0", response);
+}
+#endif /* FASTBOOT_CMD_FLASHING */
diff --git a/drivers/fastboot/fb_getvar.c b/drivers/fastboot/fb_getvar.c
index e8aa0e09aa6..74e7a4487bf 100644
--- a/drivers/fastboot/fb_getvar.c
+++ b/drivers/fastboot/fb_getvar.c
@@ -28,6 +28,9 @@ static void getvar_has_slot(char *var_parameter, char *response);
 static void getvar_partition_type(char *part_name, char *response);
 static void getvar_partition_size(char *part_name, char *response);
 static void getvar_is_userspace(char *var_parameter, char *response);
+#if CONFIG_IS_ENABLED(FASTBOOT_CMD_FLASHING)
+static void getvar_unlocked(char *var_parameter, char *response);
+#endif
 
 static const struct {
 	const char *variable;
@@ -87,6 +90,12 @@ static const struct {
 		.variable = "partition-size",
 		.dispatch = getvar_partition_size,
 		.list = false
+#endif
+#if CONFIG_IS_ENABLED(FASTBOOT_CMD_FLASHING)
+	}, {
+		.variable = "unlocked",
+		.dispatch = getvar_unlocked,
+		.list = true
 #endif
 	}, {
 		.variable = "is-userspace",
@@ -346,3 +355,16 @@ void fastboot_getvar(char *cmd_parameter, char *response)
 		fastboot_fail("Variable not implemented", response);
 	}
 }
+
+#if CONFIG_IS_ENABLED(FASTBOOT_CMD_FLASHING)
+/* "yes" when the device is unlocked according to the AVB TA, else "no" */
+static void getvar_unlocked(char *var_parameter, char *response)
+{
+	bool unlocked;
+
+	if (fastboot_flashing_is_unlocked(&unlocked, response))
+		return;
+
+	fastboot_okay(unlocked ? "yes" : "no", response);
+}
+#endif
diff --git a/include/fastboot.h b/include/fastboot.h
index b106d617749..ce0d9335b6e 100644
--- a/include/fastboot.h
+++ b/include/fastboot.h
@@ -53,9 +53,23 @@ enum {
 	FASTBOOT_COMMAND_OEM_BOARD,
 	FASTBOOT_COMMAND_ACMD,
 	FASTBOOT_COMMAND_UCMD,
+	FASTBOOT_COMMAND_FLASHING_LOCK,
+	FASTBOOT_COMMAND_FLASHING_UNLOCK,
+	FASTBOOT_COMMAND_FLASHING_GET_UNLOCK_ABILITY,
 	FASTBOOT_COMMAND_COUNT
 };
 
+/**
+ * fastboot_flashing_is_unlocked() - read the AVB device lock state
+ *
+ * Available with CONFIG_FASTBOOT_CMD_FLASHING.
+ *
+ * @unlocked: set to the state on success
+ * @response: fastboot response buffer, filled on failure
+ * Return: 0 on success, -1 otherwise
+ */
+int fastboot_flashing_is_unlocked(bool *unlocked, char *response);
+
 /**
  * Reboot reasons
  */

-- 
2.53.0

