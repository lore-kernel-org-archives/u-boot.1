Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C697606A326
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 13:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=vo1lcyPF;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RcSqqwQ8;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bHZjnR0Y
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1286D607AE;
	Tue,  3 Nov 2026 13:44:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xekeihaHG0Eq; Tue,  3 Nov 2026 13:44:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D02EB60705
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793713448;
	b=in8w2NusLx8c13LXb19kb16dpuuBdxE8h9Qvx0HOOQ6Rz9NLa4BCIGDjloKjVtqMHkzB
	 cVzjRWTrgiWnokehxMDWTv/5+OwI262eiluNlj18Zs7TzNx/jiaXAi3orvr1qelCn/K4v
	 CLPmBBjCTCXfNQ8GQ/NJd3sPbBYKjK4+b8REGd1hpTSsA6wPQw1I4ScpgiJmmPdXWQsCu
	 senFR/KCoELnDc+XPuHEqvlPaJx/7G222xPDeUlTTxYT1hmuZczxdyK1BTUlkzzC6+hgw
	 BGWVFQ/PiC3PIbxvWw/JwSQuKMj+FlSQVDzSlQmpl7NwYIudLeYtMAgWG/oS/rTjhHQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793713448;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=NNa4LlhTt8lG6Ra9Z4XDSA2pAtFZRpmHLzmaB2Fp/jI=;
	b=V+08GmOAC8IckyccjFI5PwlXaSU7Q3jG1EOBaxJNExfmAYgIBGSs//kXYCai4KEQtPct
	 v4+pM3mO7/6c6VosaKl7YYqBLtncawb5pmhapGhE8KMwG5RltgzZ2xb1U3OD+2nAMv2Ff
	 jRrT4qbQNuwifC6RmpHrvEBgGQSA3TrL94RpYDmkXejVtsYZhQJbn42SK/XuHCHTquV21
	 1AUTJS6POWQjJW3nvfGeO1jLAOVVS1JAvMiRbNvsvPJRatHchR9AgF3Twus5K3z244sPR
	 /zEDqI1/PJ4psicIjtwPX6R2oOfeKrwbWSZR9TyTSCW1CLTV2ioWOeXgXo+qCEQhm7Q==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793713448;
	bh=NNa4LlhTt8lG6Ra9Z4XDSA2pAtFZRpmHLzmaB2Fp/jI=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=vo1lcyPFli6BMOkUPPBCnCH6IR3zRwgyqSMNpnEDEizzs0FuTvtLmYLPkGU1cCNDD
	 2nNcmK2eD6vZXYwCV4DNZgH20FaLlho5l3M6UbbYmZaA11Obl1hZTcuqoMOVgtnWpl
	 QyIHsZJRKfbuyvb6T5GdwCrj1fB1A4E8jyEpmZzgEBxb3aJuBO4WM+nJHfJ/aDlLAD
	 /l7tlpQkzGAYxdKpujSryivi5ctLcBAhVr7WPj+cNy3W3e+kLx1iydkSB74U7LxAdH
	 VjftkRLLPg8UBi4RJpv0w0E8e/OnXi0qxTlSqULcmDlDYt0JDQCpaZ10oVP5VmVgtb
	 09zLcj1nXB3iw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D02EB60705;
	Tue,  3 Nov 2026 13:44:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 0E588D3A
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 13:44:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E7824809F8
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 13:44:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2WKl0DgKBzLv for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 13:44:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org ADE7E809EC
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793713446;
 b=r4iahdqquxLHqCMefCpAvhSlmK/xYbuYb7Eo6UykA7OFjA00fXa2UepkP7UlXC0ny3Vi
 xqCSomKlOkD2dttBd/9z+GM0Xtt83IEOCHwFtlSwSX3MDZXQ/vhOliTJ8WX9CaSO05JzW
 qEk1lC26OOdhQVsp300O+DxAeVTIcFf+/8mprqyj25GY3oubJ4pkPWNUbwGJVd/L44rO+
 XwcwIL+3Jnfi7xsP5Yi4U+IuWgbwWWzYqgg5tqPeNb2FltVcofFE+SuMT9xp8RFQy9Bfm
 yT37Q8dsz4wgnN9yNImiZtVpY31KW9x7qbCucG+QZgglIOQYJ71uOdhK3vUCut/x/yg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793713446;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:X-Authority-Analysis:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=NNa4LlhTt8lG6Ra9Z4XDSA2pAtFZRpmHLzmaB2Fp/jI=;
 b=L9PL5dvVNV8w/dG47jPd2yleGVfp3yFEtZGHHt6CJdkqhmFHx5li+OSTVQnST4INx7/2
 35PzflLAEka8SmGrU4LXpkfgRPtVIXQ+0FcvDjLw+yVIvQjHodzmxlYHGhxDZponneVJN
 h3sMQxGKw68R4kBU9Zmsh0Qmth3crM6R2QV0HEToSMYkH+AlqpX71rUIlSLXyjjm8HL6M
 /NNMLtzwueXZtznQe3ei5Hdt/9zVhqJI3zE2oo/jNoIfn0GyLgkyhD3BnreZuuK0USlqy
 AVnke4qXms+vKmGPEPPV8+wZozbF6kGD6/lBa56MZqzRDIxsmpMFJxTZ7Inj1W0qg1g==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=RcSqqwQ8; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=bHZjnR0Y; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=RcSqqwQ8; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=bHZjnR0Y
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id ADE7E809EC
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 13:44:05 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A3DZGrG3002351
 for <u-boot@lists.u-boot-project.org>; Tue, 3 Nov 2026 13:44:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=NNa4LlhTt8lG6Ra9Z4XDSA2pAtFZRpmHLzm
 aB2Fp/jI=; b=RcSqqwQ8ESlByTWpXX8ln5enSr7J9hu7xYaJEbex7+V9EQfoPe4
 HOoctKY46FjhI0r6OMrTGGxYYu0odOhu0VtAeUn4EEjQ1c9whgqL2gnKyz4rlRuf
 bt2X35uM3pgY7vpkf/hEncofXVQpoPuWlqNh4QU06id3G9JsaV7S2MfDvnGyDL1l
 7pLjX9Qwd+CK7TfAE8VDz8quQMewBmKnxq3RaRPclcagvl6mAXn3H0cbmYRL6l5W
 fnihGsIxc0TifNmhFv2BFyvxmgBkTQQR9EAiIgqHuZ5fjGAEsQoPPbrlu6LoeoOh
 77Nh9XKLWSReAjAfPTYsOdOEpruGa+4L4Aw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hq0873y2e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 13:44:03 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-33713e5e6daso4893259eec.0
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 05:44:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793713443; x=1794318243;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=NNa4LlhTt8lG6Ra9Z4XDSA2pAtFZRpmHLzmaB2Fp/jI=;
 b=bHZjnR0Y5jRl00KQyoanHyzM0PnxofYR4BnPGFyWKC6mRUhA8blhNYoFWYGvwZOAAz
 2Yrg5MdFXwhPvrkFS5Nr4EP7832rXNijdfLYhk7T4W6i0Dt3Wldtdoel0Pomf7bvyblq
 eme9mSDKvR8Q6IuqyisKcQ+MgvdH8yQg7Zx5/8km4UfCIpBV7dOG/evo3f7ItZq+Wrrd
 q7v8gd1h4GZ+7S1Ln3sa9Jk5p3UbKZYTkhPrNR+/2I5pjQ2uTlq7trUspH9QjeW/OkB2
 Y6gkXgSjeEPoi+fScpxX/0BylEYEFhOB74CdjsQfeylYvkRhxeXtiiwTPuE1JUs+NBKn
 YLKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793713443; x=1794318243;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=NNa4LlhTt8lG6Ra9Z4XDSA2pAtFZRpmHLzmaB2Fp/jI=;
 b=yM8ZIuz+Qh5um/cQSohBrHp14KJ6EBdaeLYGmYAcZ5okuVBljz/TeEKVugVibWOwkB
 /eINZUkP+8NG4/TdYcEGuAa1Feb+UbB0mXUDCDgfaAkRbf8tvwBBXQd3+lkNbPoKI8S/
 SZEQZ/on0W9HlibBxCc7LHyN0Fgx/PYqgkCbs1UuyIKWC0dZVhD7bDPp7ztnaH/2eWPh
 vl6FXkq6wYIzdMcaVUyKxVfyqC1iBfSJHH1ty/hYvFp/zjpcdrIf7QM7C2Pvcu+v//vO
 cY9hADVMBgxsl/00G2VEOdc8BfgVlWjxq1wvRP870VtsHj3WPPK784dtd/c36By7ql/v
 58vw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxu29riUWmnwzv2DnKKPYBK6xkcme01Rj0oPAaKJjinoJXKh4UbEC3zFTDhRUySsQ+TyV3wOeQ=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z879DS9AZrNY4d2/SadHOKYWupUtPYfB5t1pl5RMxQ/3JBk6z1q
 Lyz5vy6RompocyR9KEKR/JRA1bjKuilT62kDcBXvsSfWsiAwkvrKkmclIHe4062fKyb5L3yFptR
 NvOc61xN8fOhLG+3aZTEujN7O0hjX1FItACSAYe+00r2nQsOjv5Ifh7Alj7CnAoElG4qMRo0=
X-Gm-Gg: AYBFou1VpD/GefXy0bVa3M1Xr8kFU1PIAcclNX+AVFPQqehUfBAUVF8IMMdFQwzfFbO
 1Wli3UKKwRKPSGZcNNW/wueQZ88vvz06y2JZ39gOSe4yljO/FUgUMNL5hI5S9EVlGH9SOfQNmh3
 9UohISYVYEWG/8AdoVQmfNR5T5U2hcPZjLlb5z3ZmALR+3OnyF40YYyVZA17XBqb0u3EE9nqzId
 AuiMdTsQyTSb+bZIDrrg37NFOWWBfsrQqI6E6647YIZcYEDSEXfd87TDimo4GmGV9GO2se7t/fv
 NEm1hfSB9TBFicriLQkbfR1PAGOAAMdE7ccS55T/TTeVMr/oYljGgiwrHJIChapuDGDIV4yTbvC
 XYCJf7N9XOJZem6uPU4HM1sqK17iFzLKMohJ9Tyo8sBDVRt0G5W+KA+rEf9SrFia5ymwHUG2w+W
 SuDa5KllxlgK7uDlM/EvZ2dkOthIkTusROVCmQrZ1XUFLN40zkx0J21/rGN5S9UnGlxas/
X-Received: by 2002:a05:701b:4283:10b0:191:a5b2:ef4a with SMTP id
 a92af1059eb24-1ac5cb186d7mr19876339c88.28.1793713442747; 
 Tue, 03 Nov 2026 05:44:02 -0800 (PST)
X-Received: by 2002:a05:701b:4283:10b0:191:a5b2:ef4a with SMTP id
 a92af1059eb24-1ac5cb186d7mr19876281c88.28.1793713441929; 
 Tue, 03 Nov 2026 05:44:01 -0800 (PST)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b23f20d36csm7511194c88.11.2026.11.03.05.43.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 05:44:01 -0800 (PST)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com,
 aswin.murugan@oss.qualcomm.com, lukma@nabladev.com,
 marek.vasut+usb@mailbox.org, balaji.selvanathan@oss.qualcomm.com,
 Michael.Srba@seznam.cz, william.bright@imd-tec.com,
 nikroks@mainlining.org, anshuld@ti.com, jbx6244@gmail.com,
 dlechner@baylibre.com, nathbappai@gmail.com, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v5 0/9] arm64: qcom: Add initial support for Shikra SoC
Date: Tue,  3 Nov 2026 19:13:42 +0530
Message-Id: <20261103134351.3532864-1-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA1NCBTYWx0ZWRfXw0vox5Ej5YTY
 hR2ztE23YErlXU/oEuzMQTZsaQ6KtavGmJ9+EcS78e3ZTazwwXMBlD5EbChG/ftscdWOvtAlnG/
 vVAH5xZyAr8JRvfeC2QJdhGL1dGlq6I=
X-Authority-Analysis: v=2.4 cv=K9m3jCWI c=1 sm=1 tr=0 ts=6ae9e523 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=gu6fZOg2AAAA:8 a=XM3drYV-cKaoLeI7bekA:9
 a=bBxd6f-gb0O0v-kibOvt:22 a=2RSlZUUhi9gRBrsHwhhZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA1NCBTYWx0ZWRfX4pMU7WTLZxjM
 OHIvQyt7fV05febGhSMcR0kN5TQ8vgPbQ3yYbBkiFGKEh1fTu5ZOE6sBvkNH65mB3YAgpuj765E
 IPInm4pBzp3WWEOjvpqJiP+1qMfadVV/Fm6xWOvIC+tjREgXmIUPLcMoKbnfim6ZMOc8EKKPJlz
 oy2A/a/ESHAjbe5WUpaNdJnJvv0OBksRIIc+n0cpUnycsN+JK27kT0Cjzwa0MA4it9uI8wB2W1h
 0mUIcb1TZwULKyxBjOfusFltRgBVz3ygM5xkIpIxlYKaKg/oHjpY9qX+VUZQaicmJyftUZc/wzh
 +yLm9e2jsv6GAqrcPn4zOHn8Qotrr0/1IrIPXMONeCYp5UgosjNtJlILUTBEBhZi5f0qK0F8pXc
 +4bqfy47QevpBl6V44SATXruOM7oIDCX8t6XWp6d6HlgsGTTptdGdLlIr20+s7pBcFf1Xbyefes
 9DxKXYkrxgg5U47N25A==
X-Proofpoint-ORIG-GUID: 2cYuFuldIbDehrahYd-7EHefrwGgVu5H
X-Proofpoint-GUID: 2cYuFuldIbDehrahYd-7EHefrwGgVu5H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_02,2026-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 adultscore=0 spamscore=0 suspectscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611030054
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series adds initial support for the Qualcomm Shikra SoC in U-Boot,
including device tree, clock, pinctrl, SMEM updates, USB and configuration
changes required to enable early boot on Shikra-based platforms.

The device tree support is ported from a Linux linux-next branch

The series includes:
  - GCC clock driver support
  - Pinctrl driver for Shikra TLMM
  - USB hsphy & ssphy support
  - SMEM update to support higher host count required by Shikra
  - Defconfig updates and Shikra-specific defconfig
  - MAINTAINERS entry for Shikra platforms
  - Documentation for Shikra platform

Thanks,
Aswin

Changes in v5:
- Use GATE_CLK_POLLED() for CBCR-backed gate clocks that require branch-enable
  polling before use in clock driver.
- Align the Shikra USB3 QMP PHY driver with the upstream Linux
  phy-qcom-qmp-usbc.c driver
- Skip remote hosts beyond SMEM_HOST_COUNT during partition enumeration instead
  of failing in smem driver
- Add MAINTAINERS entry and board documentation for the Shikra IQS board
  enablement patch.

Link to v4: https://lore.kernel.org/u-boot/20261021160916.3894471-1-aswin.murugan@oss.qualcomm.com/

Changes in v4:
- Drop DTS files already present upstream.
- Keep only the IQS board variant defconfig, remove the CQS board variant defconfig.
- Add documentation for the board.

Link to v3: https://marc.info/?l=u-boot&m=178668446732727&w=2

Changes in v3:
- Added USB3 support
- Created defconfigs for IQS & CQS variants
- Added WDT & fastboot configs in the shikra defconfig

Link to v2: https://marc.info/?l=u-boot&m=178595470886921&w=2

Changes in v2:
- Added USB hsphy support
- Ported Shikra dts files from Linux linux-next branch
- Created config fragment for debug UART

Link to v1: https://lore.kernel.org/u-boot/20260615121828.1798789-1-aswin.murugan@oss.qualcomm.com/

Aswin Murugan (9):
  clk: qcom: add GCC clock driver support for shikra SoC
  pinctrl: qcom: add driver for shikra SoC
  phy: qcom: qusb2: add Shikra PHY configuration
  phy: qcom: add QMP USB3 PHY driver for Shikra
  qcom: smem: ignore partition entries with unsupported host IDs
  tools: qcom: mkmbn: add Shikra board mappings
  qcom_defconfig: Enable Shikra clock & USB driver
  configs: qcom: add debug UART config fragment for shikra-evk
  configs: add shikra defconfig, MAINTAINERS and doc for IQS board

 board/qualcomm/MAINTAINERS             |   5 +
 board/qualcomm/debug-shikra-evk.config |   5 +
 configs/qcom_defconfig                 |   2 +
 configs/qcom_shikra_iqs_defconfig      |  31 ++
 doc/board/qualcomm/dragonwing.rst      |  16 +-
 drivers/clk/qcom/Kconfig               |   8 +
 drivers/clk/qcom/Makefile              |   1 +
 drivers/clk/qcom/clock-shikra.c        | 344 ++++++++++++++++
 drivers/phy/qcom/Kconfig               |   7 +
 drivers/phy/qcom/Makefile              |   1 +
 drivers/phy/qcom/phy-qcom-qmp-usbc.c   | 534 +++++++++++++++++++++++++
 drivers/phy/qcom/phy-qcom-qusb2.c      |  14 +
 drivers/pinctrl/qcom/Kconfig           |   8 +
 drivers/pinctrl/qcom/Makefile          |   1 +
 drivers/pinctrl/qcom/pinctrl-shikra.c  | 478 ++++++++++++++++++++++
 drivers/soc/qcom/smem.c                |   5 +-
 tools/qcom/mkmbn/mkmbn.py              |   2 +
 17 files changed, 1456 insertions(+), 6 deletions(-)
 create mode 100644 board/qualcomm/debug-shikra-evk.config
 create mode 100644 configs/qcom_shikra_iqs_defconfig
 create mode 100644 drivers/clk/qcom/clock-shikra.c
 create mode 100644 drivers/phy/qcom/phy-qcom-qmp-usbc.c
 create mode 100644 drivers/pinctrl/qcom/pinctrl-shikra.c

-- 
2.34.1

