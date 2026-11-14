Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70ED4606A323
	for <u-boot@archiver.kernel.org>; Sat, 14 Nov 2026 09:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=efMfH5X4;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=kra0rh7v;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hKKFrQqD
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DFE1681A1C;
	Sat, 14 Nov 2026 09:02:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GaGszdCRVg0J; Sat, 14 Nov 2026 09:02:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 67072817A0
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794646970;
	b=N1alBAnZhqC9YmHh9X/JUOYRmfjsvgfnVCZJ3+ma2wKwkdt7/P5RQT2XeIClK7cOfRgL
	 /o0044ixkDz1MpFrwnHv6dJE0Qy05su7lboUImiM+zrLtWQ6irxcWBOm8SHRKCglSQ5es
	 2G4GO/u87R2dV3Hn4kZ4s7xzjTPA7lIdQHPWzTi5FlzJHQ406VUbIm9Xy4I85FdrPwBhw
	 V1qQUgisBhkIZEM67QZW4Rg4QwFKfDPISu8g4Dt3Hciq5EIt9p4XsHApQbjEgYuXi3MYK
	 +bEsph7tav8msJ+nBXRPIglEEptzTx37l3Cf+2NkvV1ZqD1GFA2hmSEkVismn+SJtOg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794646970;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=RpVYQuNuEBPMoTAMSmnpjTbASpHAVdS/hCFORW82+0Y=;
	b=VpMHhusswA/KLAm3H3HfLtDZs9rDzLkRtJSoD/WXJ8QWkPI2c1jDCjLptFFU3P2bsqbG
	 JiVI54HZzZKVq6cWyxg+zyGND+5wSLFhbE2zkZ9meyXEleGzdvr9g8cPB/6HcsHciimAp
	 uOgk86OCIkahhW28p9Derdf2A1X/N2zpmdT6yFr98zF70Yx0LQd0GNKeqCgr3DC0oSNhn
	 JXINOSgW6eSKzQTUPmn44EekNE2/iGi+Dn1IxteBQtd9KNQWG3ODmTRjgS+SshVqUl0+N
	 hl5eG9FMR2Z5g3vrVT1svC9TpnUdrIAAey5FbRFMlrpGJrRwZ0PCI9cVKF1DefiXeYg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794646970;
	bh=RpVYQuNuEBPMoTAMSmnpjTbASpHAVdS/hCFORW82+0Y=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=efMfH5X4Rru14wIOl2pkNn+CCW/471oPk92BZ5+F/WuZRWopGbjivZ3wEtYN5P7wK
	 qTdiAeyZf6QUdWgv/hy4/YxEqyGfZv9uVRUf6Vi3UMhuHi3glio6WuJEcnEAHTxjfr
	 eFj+2N9SoDch36AY5IWG/ddeSd0XNUvtHc0eb8+Ki2p8CAujvC+UuaGqL6JGMXPXDm
	 4Jds+CtNgQ8MleuLu8PdZL8GeznXxs7j48f/T139YaEqd99IMe4rv/RTAeFrjFpDLg
	 o9MMpGH6H9Eym7Rsb3pVw2Tq0lT0KUarbXwPGznjY2kq4ESNYOZiVpY39G9gVjId/x
	 oUzixFfFtMT0A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 67072817A0;
	Sat, 14 Nov 2026 09:02:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id B0CC328C
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 09:02:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9690360699
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 09:02:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id c-myiGzYldjC for <u-boot@lists.u-boot-project.org>;
 Sat, 14 Nov 2026 09:02:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B7BBE6066E
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=kra0rh7v; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=hKKFrQqD
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B7BBE6066E
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 09:02:45 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AE60xtk2730280
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 09:02:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=RpVYQuNuEBPMoTAMSmnpjT
 bASpHAVdS/hCFORW82+0Y=; b=kra0rh7vrn3cHeJrdt7affUkkeugW0H0R4BWm+
 VaUK4I4+7h3egITQ0419XQIdNTn8+ZrCUx4nuqLGFKUI9OoGZODLTK5p3ftQjVEK
 O1Vz5JPUsYP5+Ihwfm22YG2o1ntMfP+b0K7cITd0SVwhg4KHLoG2S5KVc1GLDf3p
 l9L6xyWKk+87CF8M7GFsUO+1VKy4WmanWcMwd67dXBCCCzTg3VE2jTnkRMgDaRV+
 dTF7+SuiAQJKBcpRVy4vraAWImR6sFTsFCEnmg4JyglTwrp13oiZr8W8Jy54sDmA
 QqhBQf/p3gP16HyKn7sYDmjCuMOeLtAzBaE7kFSQt8I0lKqw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhjqggt4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 09:02:44 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-36efb506f29so2894816eec.1
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 01:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794646964; x=1795251764;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=RpVYQuNuEBPMoTAMSmnpjTbASpHAVdS/hCFORW82+0Y=;
 b=hKKFrQqDtA9W4JREA8Swij4zm5986L+YH6bmurSRXYi+Bc24/YPXjGNOPLff//2nRM
 xwXLaxZsjS8Y2Y9+AcoirMACyq2LgP1HieLgk0YsZZMZ2/VOCvM87p6gvLCy5rZbDHpN
 VrOMNq27CLw0PWEzBh3rVZ4cTh5srQLVQAOuxOV/6KJ0s9soPJHQ9/Onb/YqChsgsFQX
 hJF1E2Z4rA83/YRlp46uEdqRRGpkbWlNH6x46oU9MuYcNn+KU+EpcaTqvHPjkT1ZvEfw
 kZzcWYH93+6T5X7nk7xYejmzUezy+WVJTsRJGMxGJozdza+Un9lPBHhZXvWbaC5ZZdzc
 aGiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794646964; x=1795251764;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=RpVYQuNuEBPMoTAMSmnpjTbASpHAVdS/hCFORW82+0Y=;
 b=nvTCq4pvo/V0hGskq403/qSqCLXhWRgv45InPLagCN9HDnAyv6yhoJcHjqt5mGww4b
 fz6A/uDheOBkX1PExWQAsFZxE38csfsY5dSq+vivOiWsuPs69LLQk1/btGfk7iCqascq
 OnuRnt3TQGXPklebU7631RnN8VfHqqffYkJApq+Cm/OMZ0OGRcsjHDzqmFm2Xtt+sjUK
 a28yuHfHmlrzi9cK5BIC6qOCWRXUs3+8j+iofAwSZvvwMmAAsKDG2j+LKK8ubKoHBBJ8
 niX8UmbKSkwDzFhW57ohZH77v3KMRLzEr5ELZAKZ6OT4baKgQWThKVjsutKvLLn8pe+L
 iVVA==
X-Gm-Message-State: APuU4Z/sS6KgOFBjOWe5Qu9hGa3KZxxGKe1gi/xFpB+lLpNECF1K3o80
 HAPKSJsMQmPZU+AoOyGjuYR2qRPdKhJtTadXKdEU8d0lrURScB9wtXQv46DIN8MjXIP+wX0OCpU
 pjwDx9HqAqYMa/6013NpEsz/ACuEzpwYG2Mex5rx2tVuuqyF0bu9CBHmtzsdwDWYzEowd/2UGok
 LSclrAEg==
X-Gm-Gg: AYBFou10NiQmGLqZBR8TN5UZchoLCRdZEUsbsaWF+xCx0BVR7VGvLIBTyTKEeMvqoAQ
 d6etOnYrMR5WIFDC7w1r3KZ22MCGPkfBi5U1KOqi/IBxBjO6O1dkEJRru5AfTTmQO/L0WHw79CD
 1lXhZVStpowewM9sYLu96Z2l4g6ZZUqbS+rKeui0xhxidLNp7Uji5VKQVC+6RhNBuRzwyjJ9U7c
 F9BSX4Sfh7HktbtcHNMgLAhgK75r8sbREbovlv2Vygm6QxXt6XH2aY2KvKjM4uCncSB8FrNv+ZF
 v60aFR42akPbw1flMr//smL9mNzhtHeXQJPsrSmlAyKs1j4O311EidFvWWzUmCgju1H2XxpdkLw
 0UBkR92GEzLhV4Ai5vq8x6hTcsOyEuAftvA0NkcSjjc4mHs2wHkKKXwDfNMIK1LXstjP0BFEKkG
 EVz/onYFjtPJwUVeqmQ4Do6IEQKq1vs73d/wVqRLOKM+0DKwC0Fs92UiFJsb+b6duswc13u3IDW
 Sq6LQ==
X-Received: by 2002:a05:693c:41c1:20b0:375:c862:34e with SMTP id
 5a478bee46e88-37966193789mr5075627eec.20.1794646963537; 
 Sat, 14 Nov 2026 01:02:43 -0800 (PST)
X-Received: by 2002:a05:693c:41c1:20b0:375:c862:34e with SMTP id
 5a478bee46e88-37966193789mr5075602eec.20.1794646962858; 
 Sat, 14 Nov 2026 01:02:42 -0800 (PST)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-379565d07b3sm13892343eec.22.2026.11.14.01.02.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Nov 2026 01:02:42 -0800 (PST)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Sat, 14 Nov 2026 14:32:38 +0530
Subject: [PATCH v2] efi_loader: firmware: track last attempt status for
 ESRT reporting
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261114-efi-esrt-last-attempt-v2-1-f47a430a6917@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAK0j+GoC/3WNQQ6CMBBFr0Jm7ZC2GIquvIdhUWEqTYBipzYaw
 t2tJC7dTPJ+/n+zAlNwxHAuVgiUHDs/Z1CHArrBzHdC12cGJVQtGimRrEPiEHE0HNHESNMSsVZ
 GCtKN0FZB3i4h916799pmHhxHH977myS/6c9Y/TEmiQKrG0mt7FH3p/7imcvH04ydn6YyH2i3b
 fsA+U4D5cEAAAA=
X-Change-ID: 20260811-efi-esrt-last-attempt-62a10e7807f2
To: u-boot@lists.u-boot-project.org
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 =?utf-8?q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>,
 Aristo Chen <aristo.chen@canonical.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794646960; l=11731;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=nGYW4ipy1/1BHcMvAsaKKFbvUt2Rf15WxRyPX6tu7ac=;
 b=iqj+frr6Ob/i0Y4hnTcCzBBj3mfl6aKMgtSZrkaqhKkPnjteM7GPZ3FNdIckzyIiZWCCto845
 /taS8UBzdqJBK48GIYxjs23TwSukfcxktuQZwiS9ab/SFYNg25fn1S4
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Authority-Analysis: v=2.4 cv=KelHIgYD c=1 sm=1 tr=0 ts=6af823b4 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=TOCeXH0Uw-wwiP-3N8gA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE0MDAzNSBTYWx0ZWRfX3hpsCk0iYbSY
 MthpTwgUEJRe4fpqgwRu71HrrUzsHcr+tHt4R+ySVKkqKDDxdtLz8BIyEfLN2EXhzWF0xRi5IkJ
 FkatXgpqfs2QLjjOaRm9Lk9CNFZ/RHs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE0MDAzNSBTYWx0ZWRfX5sl4UZNHgx+D
 B/yhTUcD+eww3WCOESULa6748drVIjS1/woKIpMp5p1u109+5NvOZ4mdPlsNBh5MUAzdwA3OiKm
 bwrVlzybdofYbtbAGMursEWC/oo3mTushWsroN4eMxlzMVgp76E2uK4Ntoyx9CNVRAlENLeGCxX
 lByuMDqcbz9g3I3iZYSYjjiV7SAhwoPs4ygHOnrsuktzR2bsaLMtgKTlPtVtxKaTucot0DnxxJL
 E2HVKWM4TCHElCW53t+CGATb4aZk0c7GcH3Q7+Cb2YXG1B1M/wxaTKd5IkxutwOvIwZwC3dtHMi
 ZGuOBgVecXaQa7r3+MiTty9rcMmHpohGCVvhmS2ktPW9efe0Ue4chXuwW+q8FzdGSbRtHtZEleL
 HwbsG4QX8RXUFVq6+kWvv/IyLwzNm8ecAISvo4i+LQAWl+ftHrb8THaBxOzsB5Bt9qTH6L7BRqW
 SIBobgnKpXyjJTwPfCg==
X-Proofpoint-GUID: 4vbSbGpDbDfHy96ot3C0sLYUizI1e8WR
X-Proofpoint-ORIG-GUID: 4vbSbGpDbDfHy96ot3C0sLYUizI1e8WR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-14_02,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 clxscore=1015 spamscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611140035
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

The last_attempt_version and last_attempt_status fields in struct
fmp_state are never populated, so the ESRT last-attempt
information exposed to the OS stayed at its boot-time defaults
regardless of what happened during an update.

Add efi_firmware_set_last_attempt() function to record the last
attempted version and status. And add efi_firmware_record_attempt()
function, which uses efi_firmware_set_last_attempt to record the last
attempt version and status and then calls
efi_firmware_set_fmp_state_var to set FmpState variable with
recorded values.

Call efi_firmware_record_attempt() in efi_firmware_raw_set_image() and
efi_firmware_fit_set_image() at every point where the update can fail
and on success. A query of ESRT then reflects the outcome of the last
attempt instead of stale boot-time values.

Also, fw_version is now only advanced on a successful update so a failed
attempt does not overwrite the recorded good version.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v2:
- Describe the last_attempt_version/last_attempt_status fields and the
  efi_firmware_set_last_attempt() parameters
- Track last attempt for FIT capsules as well as RAW ones, via a new
  efi_firmware_record_attempt() function
- Merge "track last attempt status for ESRT reporting" and "add last
  attempt tracking for RAW capsules" into a single patch
- Move "Extract FW version even on authentication failure" and
  "efidebug capsule images" out into separate standalone series
- Link to v1: https://lore.kernel.org/r/20260813-efi-esrt-last-attempt-v1-0-3be172f47d9d@oss.qualcomm.com
---
 lib/efi_loader/efi_firmware.c | 146 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 123 insertions(+), 23 deletions(-)

diff --git a/lib/efi_loader/efi_firmware.c b/lib/efi_loader/efi_firmware.c
index b41969c70fd..887acf453d7 100644
--- a/lib/efi_loader/efi_firmware.c
+++ b/lib/efi_loader/efi_firmware.c
@@ -47,14 +47,17 @@ struct fmp_payload_header {
  *
  * @fw_version:			Firmware versions used
  * @lowest_supported_version:	Lowest supported version
- * @last_attempt_version:	Last attempt version
- * @last_attempt_status:	Last attempt status
+ * @last_attempt_version:	Firmware version of the last attempted capsule
+ *				update
+ * @last_attempt_status:	Result of the last attempted capsule update, one
+ *				of the LAST_ATTEMPT_STATUS_* values defined in
+ *				include/efi_api.h
  */
 struct fmp_state {
 	u32 fw_version;
 	u32 lowest_supported_version; /* not used */
-	u32 last_attempt_version; /* not used */
-	u32 last_attempt_status; /* not used */
+	u32 last_attempt_version;
+	u32 last_attempt_status;
 };
 
 /**
@@ -190,6 +193,50 @@ static void efi_firmware_get_lsv_from_dtb(u8 image_index,
 	}
 }
 
+/**
+ * efi_firmware_set_last_attempt - set last attempt information
+ * @state:		Pointer to fmp state
+ * @attempt_version:	Firmware version of the last attempted capsule update
+ * @attempt_status:	Result of the attempt, one of the LAST_ATTEMPT_STATUS_*
+ *			values defined in include/efi_api.h
+ *
+ * Set the last attempt version and status in the fmp_state structure.
+ */
+static void efi_firmware_set_last_attempt(struct fmp_state *state,
+					  u32 attempt_version,
+					  u32 attempt_status)
+{
+	state->last_attempt_version = attempt_version;
+	state->last_attempt_status = attempt_status;
+}
+
+/**
+ * efi_firmware_map_error_to_status - map internal errors to UEFI status codes
+ * @error:	Internal error code
+ *
+ * Map U-Boot internal error codes to UEFI-compliant last attempt status codes.
+ *
+ * Return: UEFI last attempt status code
+ */
+static u32 efi_firmware_map_error_to_status(efi_status_t error)
+{
+	switch (error) {
+	case EFI_SUCCESS:
+		return LAST_ATTEMPT_STATUS_SUCCESS;
+	case EFI_OUT_OF_RESOURCES:
+		return LAST_ATTEMPT_STATUS_ERROR_INSUFFICIENT_RESOURCES;
+	case EFI_INVALID_PARAMETER:
+		return LAST_ATTEMPT_STATUS_ERROR_INCORRECT_VERSION;
+	case EFI_SECURITY_VIOLATION:
+		return LAST_ATTEMPT_STATUS_ERROR_AUTH_ERROR;
+	case EFI_UNSUPPORTED:
+		return LAST_ATTEMPT_STATUS_ERROR_INVALID_FORMAT;
+	case EFI_DEVICE_ERROR:
+	default:
+		return LAST_ATTEMPT_STATUS_ERROR_UNSUCCESSFUL;
+	}
+}
+
 /**
  * efi_firmware_fill_version_info - fill the version information
  * @image_info:		Image information
@@ -237,8 +284,15 @@ void efi_firmware_fill_version_info(struct efi_firmware_image_descriptor *image_
 
 	ret = efi_get_variable_int(varname, &fw_array->image_type_id,
 				   NULL, &size, var_state, NULL);
-	if (ret == EFI_SUCCESS && expected_size == size)
+	if (ret == EFI_SUCCESS && expected_size == size) {
 		image_info->version = var_state[active_index].fw_version;
+		image_info->last_attempt_version = var_state[active_index].last_attempt_version;
+		image_info->last_attempt_status = var_state[active_index].last_attempt_status;
+	} else {
+		/* Default values if no previous state exists */
+		image_info->last_attempt_version = 0;
+		image_info->last_attempt_status = LAST_ATTEMPT_STATUS_SUCCESS;
+	}
 
 	free(var_state);
 }
@@ -427,6 +481,10 @@ efi_status_t efi_firmware_capsule_authenticate(const void **p_image,
  * @image_index:	image index
  *
  * Update the FmpStateXXXX variable with the firmware update state.
+ * On successful update (last_attempt_status == LAST_ATTEMPT_STATUS_SUCCESS),
+ * updates fw_version to the new version.
+ * On failed update, preserves the old fw_version.
+ * Always updates last_attempt_version and last_attempt_status.
  *
  * Return:		status code
  */
@@ -471,11 +529,19 @@ efi_status_t efi_firmware_set_fmp_state_var(struct fmp_state *state, u8 image_in
 		memset(var_state, 0, num_banks * sizeof(*var_state));
 
 	/*
-	 * Only the fw_version is set here.
+	 * Set fw_version and last attempt information.
 	 * lowest_supported_version in FmpState variable is ignored since
 	 * it can be tampered if the file based EFI variable storage is used.
+	 *
+	 * Only update fw_version if the update succeeded.
+	 * On failure, preserve the old fw_version to maintain accurate ESRT state.
 	 */
-	var_state[update_bank].fw_version = state->fw_version;
+	if (state->last_attempt_status == LAST_ATTEMPT_STATUS_SUCCESS)
+		var_state[update_bank].fw_version = state->fw_version;
+	/* else: keep existing fw_version (don't update on failure) */
+
+	var_state[update_bank].last_attempt_version = state->last_attempt_version;
+	var_state[update_bank].last_attempt_status = state->last_attempt_status;
 
 	size = num_banks * sizeof(*var_state);
 	ret = efi_set_variable_int(varname, image_type_id,
@@ -490,6 +556,28 @@ efi_status_t efi_firmware_set_fmp_state_var(struct fmp_state *state, u8 image_in
 	return ret;
 }
 
+/**
+ * efi_firmware_record_attempt - record the outcome of a capsule update attempt
+ * @state:		Pointer to fmp state
+ * @image_index:	Image index
+ * @status:		Result of the update attempt
+ *
+ * Map @status to a LAST_ATTEMPT_STATUS_* value, store it in @state together
+ * with the attempted firmware version and update the FmpStateXXXX variable.
+ *
+ * Return:		@status, so that callers can return it directly
+ */
+static efi_status_t efi_firmware_record_attempt(struct fmp_state *state,
+						u8 image_index,
+						efi_status_t status)
+{
+	efi_firmware_set_last_attempt(state, state->fw_version,
+				      efi_firmware_map_error_to_status(status));
+	efi_firmware_set_fmp_state_var(state, image_index);
+
+	return status;
+}
+
 /**
  * efi_firmware_get_fw_version - get fw_version from FMP payload header
  * @p_image:		Pointer to new image
@@ -662,27 +750,33 @@ efi_status_t EFIAPI efi_firmware_fit_set_image(
 	status = efi_firmware_verify_image(&image, &image_size, image_index,
 					   &state);
 	if (status != EFI_SUCCESS)
-		return EFI_EXIT(status);
+		return EFI_EXIT(efi_firmware_record_attempt(&state, image_index,
+							    status));
 
 	orig_dfu_env = env_get("dfu_alt_info");
 	if (orig_dfu_env) {
 		orig_dfu_env = strdup(orig_dfu_env);
 		if (!orig_dfu_env) {
 			log_err("strdup() failed!\n");
-			return EFI_EXIT(EFI_OUT_OF_RESOURCES);
+			return EFI_EXIT(efi_firmware_record_attempt(&state,
+								    image_index,
+								    EFI_OUT_OF_RESOURCES));
 		}
 	}
 	if (env_set("dfu_alt_info", update_info.dfu_string)) {
 		log_err("Unable to set env variable \"dfu_alt_info\"!\n");
 		free(orig_dfu_env);
-		return EFI_EXIT(EFI_DEVICE_ERROR);
+		return EFI_EXIT(efi_firmware_record_attempt(&state, image_index,
+							    EFI_DEVICE_ERROR));
 	}
 
 	/* Make sure the update fitImage is properly aligned to 8-bytes */
 	if (!IS_ALIGNED((uintptr_t)image, 8)) {
 		img = memalign(8, image_size);
 		if (!img)
-			return EFI_EXIT(EFI_BAD_BUFFER_SIZE);
+			return EFI_EXIT(efi_firmware_record_attempt(&state,
+								    image_index,
+								    EFI_BAD_BUFFER_SIZE));
 		memcpy(img, image, image_size);
 	} else {
 		img = (void *)image;
@@ -699,11 +793,11 @@ efi_status_t EFIAPI efi_firmware_fit_set_image(
 	free(orig_dfu_env);
 
 	if (ret)
-		return EFI_EXIT(EFI_DEVICE_ERROR);
-
-	efi_firmware_set_fmp_state_var(&state, image_index);
+		return EFI_EXIT(efi_firmware_record_attempt(&state, image_index,
+							    EFI_DEVICE_ERROR));
 
-	return EFI_EXIT(EFI_SUCCESS);
+	return EFI_EXIT(efi_firmware_record_attempt(&state, image_index,
+						    EFI_SUCCESS));
 }
 
 const struct efi_firmware_management_protocol efi_fmp_fit = {
@@ -763,7 +857,8 @@ efi_status_t EFIAPI efi_firmware_raw_set_image(
 	status = efi_firmware_verify_image(&image, &image_size, image_index,
 					   &state);
 	if (status != EFI_SUCCESS)
-		return EFI_EXIT(status);
+		return EFI_EXIT(efi_firmware_record_attempt(&state, image_index,
+							    status));
 
 	/*
 	 * dfu_alt_num is assigned from 0 while image_index starts from 1.
@@ -779,7 +874,9 @@ efi_status_t EFIAPI efi_firmware_raw_set_image(
 		ret = fwu_get_dfu_alt_num(image_index, &dfu_alt_num);
 		if (ret) {
 			log_debug("Unable to get FWU image_index\n");
-			return EFI_EXIT(EFI_DEVICE_ERROR);
+			return EFI_EXIT(efi_firmware_record_attempt(&state,
+								    image_index,
+								    EFI_DEVICE_ERROR));
 		}
 	}
 
@@ -788,13 +885,16 @@ efi_status_t EFIAPI efi_firmware_raw_set_image(
 		orig_dfu_env = strdup(orig_dfu_env);
 		if (!orig_dfu_env) {
 			log_err("strdup() failed!\n");
-			return EFI_EXIT(EFI_OUT_OF_RESOURCES);
+			return EFI_EXIT(efi_firmware_record_attempt(&state,
+								    image_index,
+								    EFI_OUT_OF_RESOURCES));
 		}
 	}
 	if (env_set("dfu_alt_info", update_info.dfu_string)) {
 		log_err("Unable to set env variable \"dfu_alt_info\"!\n");
 		free(orig_dfu_env);
-		return EFI_EXIT(EFI_DEVICE_ERROR);
+		return EFI_EXIT(efi_firmware_record_attempt(&state, image_index,
+							    EFI_DEVICE_ERROR));
 	}
 
 	ret = dfu_write_by_alt(dfu_alt_num, (void *)image, image_size,
@@ -806,11 +906,11 @@ efi_status_t EFIAPI efi_firmware_raw_set_image(
 	free(orig_dfu_env);
 
 	if (ret)
-		return EFI_EXIT(EFI_DEVICE_ERROR);
-
-	efi_firmware_set_fmp_state_var(&state, image_index);
+		return EFI_EXIT(efi_firmware_record_attempt(&state, image_index,
+							    EFI_DEVICE_ERROR));
 
-	return EFI_EXIT(EFI_SUCCESS);
+	return EFI_EXIT(efi_firmware_record_attempt(&state, image_index,
+						    EFI_SUCCESS));
 }
 
 const struct efi_firmware_management_protocol efi_fmp_raw = {

---
base-commit: 36c377b9859ffb53eb1e39ea31e8d96d1e0fe1e5
change-id: 20260811-efi-esrt-last-attempt-62a10e7807f2

Best regards,
-- 
Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

