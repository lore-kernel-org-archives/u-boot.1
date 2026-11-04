Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBC9606A33A
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 16:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=qlCq+EmN;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=oSZJIqR9;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fghOVAMd
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A5A914088B;
	Wed,  4 Nov 2026 16:37:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bGuSqQr_Wq04; Wed,  4 Nov 2026 16:37:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B0B464082D
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793810256;
	b=eTpqjjvhWkWhblhllY/kVueem29GSa82ra6YU1a/MqOnWRSnVpQuMJrmiB4mQvS46urv
	 lF3RkZnDH3PHy0J1TMAqmO2UtJ9MDgY6IG4+4KhjLIGr0XD8s1RzEyWfZv6PGdSfPVaeL
	 mk/C1qE4FTWmT5czYC51MQpmNL/7wTalhFXPJNGO2bYyZkDz7xM6RXsWmcYc/u+C1miVE
	 q65VJVgRto1HRzzEljA3a5FdbZgK+R9px05Cl8QJlD066juPtjed3I9uXo/e6XvbCeNhh
	 VC1f/qQQ9ECzLQpbf21Ko/5qYxO7dl/lkkMHCxe+/qIgDcTN/88mvSx4UNJkkAAc4uQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793810256;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=5z/332EVX+5vLmUCQxQi3PBJf/K3ZzrO5WezuuLXCy4=;
	b=OEG99mbslDvzhJJ+gwF5MNSFQb6NKFe++BLRraQrrIZXLHo8k+bovu3MqU121D2NcJTk
	 2zU3YgTBzZ6BXX0mPModz7C95IOkcIXMVsD2BYVeDl6fbYSz/1hawkmkRUa3wxr4Q7qo2
	 Tormn1n0lP6B35C8w5DsCxBqU0grOiIzQMsuNWBsmIKx6YsmM/zmXxYp+85oj6KiHQiqp
	 GYoXITh1rOsJ0xIi0iKYdCdizsoK66pyquYNYydQ9CCO0ZsP40kYinLnuIkbbjzZ4+S3T
	 egCHV2n0sDykgmv8y3W0X2V7UY2MlZZbJTVAmzOW3lnoIan8DxV3MpNerOl6K296xZg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=oSZJIqR9;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fghOVAMd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793810256;
	bh=5z/332EVX+5vLmUCQxQi3PBJf/K3ZzrO5WezuuLXCy4=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qlCq+EmNjKH3PLQ4oh1QNNqwh7qvdGkQKfRIL/our+DUySZQnWRiSsjBs3/wHMxAA
	 yTvGzBH9uDH3OOoT2ZofhT+MtaEZqzwZIM88fsE6/pfUr1dxtmx/SNt3L+YwyRTeIj
	 y5DYoJ8hTCfwdlmxAi4Ccuo1QiG+3utTtMIE17PMoAeNzfETSRHB19Xgedmcu98Yg2
	 imUMpRnmqXQee/boKeaaQFpeAbPmzzcDwMjIAkbIIKMJfONhTD8EtMweTDX2maYOJ3
	 g6kX/KMUwXOkssam4GD2OsPA8W6tQKFgB3GJ6GLwh5+tvrsDngViofylqMu/e6dYVg
	 lkrXgHgq2ktSA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B0B464082D;
	Wed,  4 Nov 2026 16:37:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2575F34D
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 16:20:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0AFB341C53
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 16:20:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fcOcZfNKkbz6 for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 16:20:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 74C65412EB
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793808279;
 b=ELh5IvQwtb588qFmUkq3p+LjdAcInLGqCNkYVoH/UqXJMBFLZuoLsUdJMMOkMqtbRUdl
 iF7udP//m63PNBSyKFWCLKU/+NchN7DGHZdf9jhbiO2nxS5+TgxvAL1YnIfHAmWUlseqX
 hbCF5gt2bloDO9rxjLIAQQc+fquSMBFs7F4odwhrNx2vae7DEmuQSxfsgqVa6HEWSDYkS
 rHYqSEdnX9PtCJ6f24hdgKCcjrqR2kEtKw/UfWdefX/H+yjnGFgUbHYZjsMw5RAzIaDcs
 bJ987vx4Gju39XbUqe2xqMUYtdaN+vGaEdV4Qc8NR0UsTu0aXsSe2v6WHOmsOWskTsQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793808279;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=5z/332EVX+5vLmUCQxQi3PBJf/K3ZzrO5WezuuLXCy4=;
 b=ZhrSXySvauJdCYDylyIgtjv3xwaJo/KcqkMlXYSAS6UV7gnRFi1ZmCyT8GlphajfzW9B
 nso1sZ7s9/kjMnMULtN0yp15aFJCHjeQDsmQzAMT33YqgxnU+GadsPoaEFjcx9OnNdKp1
 iGdPqrHoYT7byVssIQNMMFSOJv2ySdHyWs9x62J4Aoq23Fd7KhJX42c+MNoUXjuWYpoVN
 BCiRAanpY/3nYireYeEYQC4//oRDeGO2ImOK8MTsePDC7u1rRXiW0Uo/0A7KopS1qXUiW
 Z9/z14NL4EbXUn7geUSbPrw0j1J9j91gFv1SLRGbIX6bXmb7gFCR3IE9Jglca6NQDXA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=oSZJIqR9; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=fghOVAMd; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=kr.sowmiya@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=oSZJIqR9; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=fghOVAMd
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 74C65412EB
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 16:04:38 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A4FioYJ1292191
 for <u-boot@lists.u-boot-project.org>; Wed, 4 Nov 2026 16:04:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=5z/332EVX+5
 vLmUCQxQi3PBJf/K3ZzrO5WezuuLXCy4=; b=oSZJIqR9pHEPW97dmxJVN29f0a7
 FdNsl0TpwPD7PAI0KUy9ECH8kr976X4iUVVxb2h22zG9RnwfohVm/Gopw8gGp5xl
 3tddoOVvQTU9DJr9OFISWsKNgxJ40/04hTKYDILepeLBdmvsQ+ifeViUkVLeBwNl
 U7LTRIuruV32z8MlVpJN4LKP+OOywBDuAY/pb0yDnx46eQiUTiL+OonQSRQWSADP
 A9Kgqljr8RBgIRJGOQvQCBl8r+oN9w5T2f9icHYWEbMiPL/m7lNhplf6WmkNGQ3/
 l7BP8ky8YKKAmiX1W6/AKK6+2mLN7ck49SS49g8KUAk4cAb25+1Xu2HaMlQ==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hr163hsr4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 16:04:38 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-1663fb7e005so1096474c88.0
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 08:04:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793808277; x=1794413077;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=5z/332EVX+5vLmUCQxQi3PBJf/K3ZzrO5WezuuLXCy4=;
 b=fghOVAMdkn6hVyx+yfJ5I969AaSqA5Y2ZAHnAHuVWeKS5P6xI98PwcNl7SHKpEd06w
 Y1zvMDH3TFbf/vBb3QcI4TATlGV7N5dvu5PKlTUzB6nZELMulGGl/dGy4J0G0hOoWgwr
 PZf8M2uwsu+6jblWF9UwxqrKdt3L/9CRWKGqZx/ybKbgoQkMeiwWoGZE6ks1udnmB+w2
 zMAS5u/ZwvX9v5p7+p+gMB7GTxPCcgITMek3VmLjTZe0TkoxzhsCJLgcDVaVja4SkZ03
 VBuuefbhDg6a6U19H4YQk6U/ZefbNl1vgdTUbmDgO4cJ+dm1Oh5LRzIJHeo3FU7TWoh8
 AfMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793808277; x=1794413077;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=5z/332EVX+5vLmUCQxQi3PBJf/K3ZzrO5WezuuLXCy4=;
 b=uCRJjkKTcvCKDnqNLOdlG7xDTxrpYB8Qs57+XYrYx3RO7H/I7PyDYj4UoCtD/j65jd
 qq/KN/DwqiNfTKbulr1ueYuZ9il7JVR5fq3KKQdxIX4+S5haKpdxV9tmnNH9LoP5k5kR
 8pDAD0xZAD/8e5iQOWO54SPae+MyMSWy1PUb8C7acRBA4xiL1srOOs24iM5l/o4ft3MJ
 CM6+/H9RA/gVofK82shFatca2ngB2vVxULwnlbnsroIBWSTDX8cwL1t23mhkiTwPS2cx
 Rc3/8x61AhX7/TzuEBqUF/pL8UFc0m/gqhTc/iiNV3O4mN3txFiuvPS747JRW6F3SkvT
 y1NQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBytbpXZLftxXKfAF5BK7MED0Euv9Jo2Vn6p+2Dkk+F4gFAeoCExQ91+dPxgd84I+GNo2heAB5o=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+oxGZppaM8pb5j8KMy6J+ub8rYn/TX2avHsscUWZo/gQmrEvxE
 C8FUeLDBoi5AWIo+cvptn0x2etVb3AObo5J/1wQ3018buuKVbeUhiUjmcicStlCMQK9LsqrQdxu
 BSl5X250v0n78xBOS7jFBD9zGhjHGtjnSAad5EHdpT3qQjWoXzpwmoreMKVE0Aoew/INQsfc=
X-Gm-Gg: AYBFou06hG4o36NUJwVGniUibOJ/B3gE1/0sZD7t3wblMWH9KsX0FaZ8NDetZl1jC3L
 lDg6yPCxYl1xF4FliZKIF7kx5yihxL+ynh3n3mtXWjSpoK+szjZ4o2I7SpKkj2n8p902T7Hket3
 u0FHX7Llj4+z0L6N0yKdKvZOlKFxdrqtquvxTkiZV2CI7vlxmCW6GjG5WkUkXOpQ2x8rbG4WvY+
 tyA/jY1mPOET0Dd/spVayFXwbxqBpZI3hS9hp0kIfdxeNUMJ6H32UJXCGLyY69y7qpMb372SfT+
 dcffIRNj+HzehIrUgp6obYZAw44IE45Y+Hsnr0AoYyAZtcS66IjPrOM3cMyiTieePhUN1H1nEMW
 airTKoVwYXEdz1hIZVNCA2b6bafH8pj331rlB1m2crSfmSFyYC3xxgquBDOEoUBCbpOZzrx3Mqx
 3RdPC+93yZ6BeCLZ+uaptP4jMd0UtZv0HGAdLEZFnBFBJotzaJgP/19rtIf0bxGZCl8Q==
X-Received: by 2002:a05:701b:4287:20b0:1a8:b566:80c2 with SMTP id
 a92af1059eb24-1ac5d889488mr24561532c88.17.1793808277232; 
 Wed, 04 Nov 2026 08:04:37 -0800 (PST)
X-Received: by 2002:a05:701b:4287:20b0:1a8:b566:80c2 with SMTP id
 a92af1059eb24-1ac5d889488mr24561457c88.17.1793808276413; 
 Wed, 04 Nov 2026 08:04:36 -0800 (PST)
Received: from hu-ksowmiya-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b245c4706bsm10882667c88.15.2026.11.04.08.04.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 08:04:35 -0800 (PST)
From: KR Sowmiya <kr.sowmiya@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, sjg@chromium.org,
 msp@baylibre.com, kr.sowmiya@oss.qualcomm.com,
 abhilash.v@oss.qualcomm.com, balaji.selvanathan@oss.qualcomm.com,
 vincent.stehle@arm.com, daniel@makrotopia.org, francesco@valla.it,
 anton@binarly.io, aristo.chen@canonical.com, jbx6244@gmail.com,
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: [PATCH v1 4/6] board: qualcomm: nord: pass TOC FDT to BL32
Date: Wed,  4 Nov 2026 21:33:56 +0530
Message-ID: <20261104160358.1131694-5-kr.sowmiya@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104160358.1131694-1-kr.sowmiya@oss.qualcomm.com>
References: <20261104160358.1131694-1-kr.sowmiya@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: jq6s09guK9MvGEoQ-RRnrx_SorVe-4Y6
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA2NCBTYWx0ZWRfXyCrdL6/AU59V
 O+a5Kh+QwTf3dCLrUV2S1MdWYdnvRA0qEyd8rGzCoX2mO91BtAXH6NYMbGF3NY5hSh+8VDL8X3+
 4ngx6KkxmXjsQ1ZKvNDEaXBwGY7P9JY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA2NCBTYWx0ZWRfX+1gFa3m0lDB9
 Y05eaR/Enp+lGyuOAsAi3oXidqXOG0+FvW/cSqYZg12lif6mubrNMdtYgjHFZLffO41oo2JT9Pm
 iyJ5oOuVtRQXxAiEBAtu1TnhojhOTibvRFWOBiZtxNJ90/egn0Nm30RAzwvfyde9QesqZLAs0CN
 b4eTMM/lwpQ1EM0YV7/0U6+T0yUijlsfeaMzZaTs4qgwdagsnoBzkrk6OJ996ST2ON/1y7NzJOC
 ORmpB4ALeSBWy53YFvOyTBvGSjWWbSaG/AG0bTXqMMFvqn9T8gb4qrGqO3GlC8LV5EPlFpWtnwX
 UlfOfephSbX+R37ewRgCMIMJSlyJGTXR9lAvbjcu04foI2mSC5PVUqk0kwP8khbLM1l0eZ33Fz9
 A946voIvCulhaL5zjM4o06wuaXALDwr9WO3m2wV6JMZEBe2+TJWL16o9SXCg7UhvgFteZzo9HZm
 yzh3gTlMqDd1/+B5bQg==
X-Proofpoint-GUID: jq6s09guK9MvGEoQ-RRnrx_SorVe-4Y6
X-Authority-Analysis: v=2.4 cv=O5OsLx9W c=1 sm=1 tr=0 ts=6aeb5796 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=gowqQkZFysVuuHgB-kUA:9 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_05,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611040064
X-Mailman-Approved-At: Wed, 04 Nov 2026 16:37:17 +0000
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

Pass the optional toc_fdt image address to BL32 through
arg0 when preparing the TF-A parameter list for Nord.

Keep the common weak implementation as the fallback for
other platforms. Use Nord\047s strong implementation to
preserve the QCSDI-to-BL31 handoff and perform the
board-specific TOC FDT fixup.

Move the TOC FDT FIT lookup into a helper used by Nord.

Signed-off-by: Abhilash V <abhilash.v@oss.qualcomm.com>
Signed-off-by: KR Sowmiya <kr.sowmiya@oss.qualcomm.com>
---
 arch/arm/mach-snapdragon/fit-handler.c      | 57 +++++++++++++++++++++
 arch/arm/mach-snapdragon/include/mach/spl.h |  5 ++
 2 files changed, 62 insertions(+)

diff --git a/arch/arm/mach-snapdragon/fit-handler.c b/arch/arm/mach-snapdragon/fit-handler.c
index fc419bd3f00..f0bf06f4d28 100644
--- a/arch/arm/mach-snapdragon/fit-handler.c
+++ b/arch/arm/mach-snapdragon/fit-handler.c
@@ -7,9 +7,12 @@
 #include <log.h>
 #include <spl.h>
 #include <linux/err.h>
+#include <linux/libfdt.h>
 #include <mach/qclib.h>
 #include <mach/spl.h>
 
+#define TOC_FDT				"toc_fdt"
+
 /**
  * qcom_spl_get_fit_img_entry_point() - Get entry point from FIT image node.
  * @fit:	 Pointer to the FIT image blob.
@@ -127,5 +130,59 @@ struct bl_params *bl2_plat_get_bl31_params_v2(uintptr_t bl32_entry,
 		}
 	}
 
+	qcom_spl_board_fixup_bl31_params_v2(bl_params);
+
 	return bl_params;
 }
+
+/**
+ * qcom_spl_board_fixup_bl31_params_v2() - Apply optional board-specific fixups.
+ * @bl_params: BL31 parameters populated by the Snapdragon implementation.
+ *
+ * Boards can override this weak hook to add platform-specific parameter
+ * handoffs without replacing the common Snapdragon QCSDI fixup.
+ */
+__weak void qcom_spl_board_fixup_bl31_params_v2(struct bl_params *bl_params)
+{
+	(void)bl_params;
+}
+
+/**
+ * qcom_spl_get_toc_fdt_address() - Get the optional TOC FDT load address.
+ *
+ * The generic FIT loader has already loaded the node by the time ATF
+ * parameters are prepared. Look up its load address so it can be passed to
+ * BL32 through arg0.
+ *
+ * Return: TOC FDT load address, or 0 if the optional node is unavailable.
+ */
+u64 qcom_spl_get_toc_fdt_address(void)
+{
+	u64 toc_fdt_address = 0;
+	const void *fit = (const void *)CONFIG_SPL_LOAD_FIT_ADDRESS;
+	int images_node;
+	int toc_fdt_node;
+	int ret;
+
+	images_node = fdt_subnode_offset(fit, 0, "images");
+	if (images_node < 0) {
+		pr_err("Failed to find images node in FIT\n");
+		return 0;
+	}
+
+	toc_fdt_node = fdt_subnode_offset(fit, images_node, TOC_FDT);
+	if (toc_fdt_node < 0) {
+		pr_debug("No '%s' node in FIT, BL32 will get arg0=0\n", TOC_FDT);
+		return 0;
+	}
+
+	ret = qcom_spl_get_fit_img_entry_point((void *)fit, toc_fdt_node,
+					       &toc_fdt_address);
+	if (ret)
+		pr_warn("Failed to get '%s' load address (%d)\n", TOC_FDT, ret);
+	else
+		printf("TOC FDT address: 0x%lx\n",
+		       (unsigned long)toc_fdt_address);
+
+	return toc_fdt_address;
+}
\ No newline at end of file
diff --git a/arch/arm/mach-snapdragon/include/mach/spl.h b/arch/arm/mach-snapdragon/include/mach/spl.h
index a32a85c48fd..306fdc7a4c1 100644
--- a/arch/arm/mach-snapdragon/include/mach/spl.h
+++ b/arch/arm/mach-snapdragon/include/mach/spl.h
@@ -6,11 +6,16 @@
 #ifndef __SPL_H__
 #define __SPL_H__
 
+#include <linux/types.h>
+
 struct blk_desc;
+struct bl_params;
 
 void qcom_spl_malloc_init_f(void);
 int qcom_spl_loader_pre_ddr(u8 boot_device);
 void qcom_spl_error_handler(void *arg);
 int qcom_spl_get_boot_blk_desc(struct blk_desc **descp);
+u64 qcom_spl_get_toc_fdt_address(void);
+void qcom_spl_board_fixup_bl31_params_v2(struct bl_params *bl_params);
 
 #endif /* __SPL_H__ */
-- 
2.43.0

