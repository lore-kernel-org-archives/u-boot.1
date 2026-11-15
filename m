Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9AA4606A323
	for <u-boot@archiver.kernel.org>; Sun, 15 Nov 2026 05:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=QywxBiNa;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=H4RPFnlk;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=O38naDjw
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C26C681175;
	Sun, 15 Nov 2026 05:05:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yYv3cYdhf_VQ; Sun, 15 Nov 2026 05:05:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B7D008116A
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794719106;
	b=fmo55fTil+UzUGiO8nrWHHMc28N75go5lOqNzVC9P1R8VV38fsy5RiCEGgv6yxMQ4pcy
	 k+gYl0fxcrZ/7b4yOC4Kwn5qctxPeCHTjSmeUbxmGkz6M5r1wdAPyza3w2SQl+h4qAIPr
	 avU89n/rg9qHUYhwH6O+wZhvYQTqbd7Z4GVle7DFimXrqbalWut7npWrRFhf1ygHVIZHj
	 ayAvMdqU5YWa7QK2ooeKE2XD8CZYtMfZapg77+XTpVH8XNLmyjLVKBVhz97LzY/nd3CAF
	 ZaYTqbHFrmZSJXejpbRih3NKuXARqRNdL7akJTaDuv6mWUBvDIEF/KYBKpjSk8nSpyQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794719106;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=6CEt3ZW9QrMUS8s+nnJRL2khESqxc3Loav0QD55IDVg=;
	b=BJOSRPCYxHEvpBVv05sSviTAQ3FAB03sHSdH8mrmV0rsQ/aYKOKXWC6ysRhSaRAHDhno
	 RHPvIAyyPRupqXRseh44tgKJbalG/Ir0nKCl6kVEx/5yD+wHzC9/E6sU0FbWwyENXGsxh
	 EIcEGGixKclN0N0xuVCU8MtgbsQmmGb/uW/u5nmzXDVMQNyGORHWzJjew4zmnvZBhjU44
	 PsGQCZ/dDLMpl05UDBKWUSMA5Fj3fIkuXmf3o5K7IIyghhRO4PCokvTfWL09WZdh/rOFq
	 ry6j8RHL2AOG675x03++mlpFHf+triV7NQTg606A6ds6mTi74quM3A1tUqAXlECIP8g==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794719106;
	bh=6CEt3ZW9QrMUS8s+nnJRL2khESqxc3Loav0QD55IDVg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QywxBiNadMO70lLL1dYD1eWS+JX9PZ9LqhN5hNgtNpvTnPnBDsONKHzC4vrornODe
	 m3TfSrZztHEz01WtPD9vg3JhPVT8SLHijpOnnW8jDrj2FrYSofhcKZ0NbLgPL6Kt/N
	 XI210GdbFibdAR2Nswsx3SBvMcYD65Np9mx36skOb6j8Rpuv5PqDPhNXYk4nHo8ZX0
	 ZtFW5mFnTojbmVkT18mKTKIKWx04o1B5tMe4a5oyMoVO92B0oS4q7LWOrWH+i/08CW
	 j/2RNQuz6exkW/cd4d23aWn94nDA3GEDlohQKQItF0U93wm2qTTb1RCZTJVnL22fOF
	 K8dj/uCjDi56w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B7D008116A;
	Sun, 15 Nov 2026 05:05:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 05B5E28C
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 05:05:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 03389406F3
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 05:05:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CWn-MiOBr7Ui for <u-boot@lists.u-boot-project.org>;
 Sun, 15 Nov 2026 05:05:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4DC50406A8
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=H4RPFnlk; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=O38naDjw
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4DC50406A8
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 05:05:03 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AF4THnA1234881
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 05:05:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6CEt3ZW9QrMUS8s+nnJRL2khESqxc3Loav0QD55IDVg=; b=H4RPFnlkOdFm0syx
 BggnUl4SNZTDhNWdoWHFHEtWcdvh/pwa92htJoqKs21fepxFSREXdxVLDh5mXPga
 JmHu6msSSFiTNS4R0S6fnEkjjAjojgLk8BxtfSKA54VAiuLljQ9igeKSNj+lSv/f
 QuKwK0u8FfwlqBUh2PEn5sApH5WzoWf9OU0doUGxu9Xv1AU3uf9euV1KDSM0bBqV
 4qtzeY2sGDhx06NfYnsPq61fHmnjmp5f3uIfyfN2eTJIH5isfdzdnrT5QnISCOqi
 JbInlQ26CPChKctM88sFpVEEYN85/OneXBpjYJgCXMptNawiKg4ghk77BbuRD+7X
 9lw3BA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhkwa892-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 05:05:02 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-36f479b9819so564149eec.1
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 21:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794719102; x=1795323902;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6CEt3ZW9QrMUS8s+nnJRL2khESqxc3Loav0QD55IDVg=;
 b=O38naDjw/NVivdbGH33ZIYYMHiDz3epKgDHNs1PW31YUck7Af0rHVqVmMFo5rRD5Bi
 HXEih7w4/qlPrdV5j48chUoY65hk/nFWuINFp9OIaaHd5YFU4WfBLw7YOzLhFd3BwUaC
 fA2OnHQ1GbItuo3wgsTHJ2ZuPINCFDb9+NJXrlF2JAhg7e7LnCMgi6HXfZcV0cSMAX63
 LJ4Cwp/aXjXgwyMkt0Y4HzmiwZ6iBpXZygGSIHiw06ApoiOHp09oqDw/aoDOitj4wqSp
 XQa/DCLZLF4wz62lOeQNIGbysgYnXp1xtPPrEpXI+IUSU3grsyQ1cnlXh6u4BP5IhZYI
 admw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794719102; x=1795323902;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6CEt3ZW9QrMUS8s+nnJRL2khESqxc3Loav0QD55IDVg=;
 b=gII/xNny3jLU1Xjv4qQRVZXe2G5qKBqR7oj5v2PJ4PWz3IxRsV3WjgYORX89/Kf0FW
 86LMeC9X6mDfs7MEizkkMIcZM5Gqcvm4EtniF5Cvd71G+cDcpmb9aYCqVDjK6rRpzBwX
 Yz77xMlRoHRbJGmmnE3WqL9vPJnl41ABh7sd4Jjq43LCtYGG6DVR6eb0xAUGKhOPdG/j
 9uvWO6D0aa7xuK4foKcKp7/HrIuvgRaOm7yOokoLOZfGQ98jEf5Vh4jpkQDxC1ioXQhT
 FyZJ5vk/OyHybmdhcYTkr8RjigRyhMJBVC1qG7OPIU4e1BKWCWss4kychOKMNdZYiWsJ
 Ij4g==
X-Gm-Message-State: APuU4Z8P0C7gjEU9Zbf1ig4H/dsxYN1jGUIyimYWGpZBiRuS5xffQEWW
 eCOMflSQOA9qoPV5JGJIF+xJj19ijN4AmbUvzgU13DZvEe1E3KF4xk6IAX2eiYdo4+ivzriYucA
 mh3pWiuoPEwfCLa7NQVWc76eraRAnoANNUg2r9OaaGwMdJyRBMfnYArs96DVWnNXBAcBW2tc=
X-Gm-Gg: AYBFou2mbpF1LUdptcZ6egMmcX9k+wLDKsfZoWtUXUKRkxqJ266ndWi8Ij8ktDMK5dY
 Up+oNuO4B5on/547dCc38hmJ5mrzjzH5mF9L40kTH3OFOmCekh3apO4F7k58DWkfFZvJDu49B5y
 lV5MduaCHzP0NVelvW28ksHfusvpzQDDVo9CuN31odWoHmUSuVNB8eLrSqd1C0x+uIvbnNeV6Fh
 b3HV4Nb+69PCsWbt5jWk1HdBFjkgW/Lm2RP+F9Guo2E3pgTSmXyNvDgRNp7oaUY/wq2KL85zz6Y
 r+Ew6dJ3oxCDZgwndI4mTefY3fbQbRW1WLEgtNvWy1k11A6ykUgg97KY35f+BhVv4yM9dCmrIPr
 gYijTfJoi1ScZbZNZDtAAKTVCGBZY/J2c1LCdQTNgMKFnLJYxFzNwKdgJ8L0ZbqJRQUJ/lWLPnJ
 nJzSFFtycxFaCYZsQvDof7/k6IWe/FBZKmDE/nfLdg1MW5NgEPQxSriVMJeQ9avJLQH7rwttyAB
 Tt0
X-Received: by 2002:a05:693c:88db:20b0:36a:1e9e:ae61 with SMTP id
 5a478bee46e88-379684ae78cmr6820920eec.38.1794719102017; 
 Sat, 14 Nov 2026 21:05:02 -0800 (PST)
X-Received: by 2002:a05:693c:88db:20b0:36a:1e9e:ae61 with SMTP id
 5a478bee46e88-379684ae78cmr6820904eec.38.1794719101540; 
 Sat, 14 Nov 2026 21:05:01 -0800 (PST)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-379565d269asm23487034eec.23.2026.11.14.21.04.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Nov 2026 21:05:01 -0800 (PST)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Sun, 15 Nov 2026 10:34:42 +0530
Subject: [PATCH v2 4/6] sandbox: capsule: Add a config file for generating
 capsules
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261115-mkeficapsule-v2-4-9fe141b2cc7c@oss.qualcomm.com>
References: <20261115-mkeficapsule-v2-0-9fe141b2cc7c@oss.qualcomm.com>
In-Reply-To: <20261115-mkeficapsule-v2-0-9fe141b2cc7c@oss.qualcomm.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@arm.com>,
 Peng Fan <peng.fan@nxp.com>, Daniel Golle <daniel@makrotopia.org>,
 Vincent Jardin <vjardin@free.fr>, Peter Robinson <pbrobinson@gmail.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Sughosh Ganu <sughosh.ganu@arm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794719081; l=4172;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=EeL2HgUYX/RT/Bv2gxA2TeWmoQGJWoEVxJ0eVF6/IVY=;
 b=4CfRx/kPswG0ZKiY6xCSV708bx2boswVWNTg271w0upEzKf+6BZEx7GN/8VrLcKDWz8jlLwZJ
 Cw880kHWYbABSW8ERYxDod6OhQVPu0l8XBszm8SjVLePQ3WW0VWWG5A
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE1MDAxOSBTYWx0ZWRfX7SM+YxCHB+qO
 88gqf3WE4ROB47qjOwU4D5ZUBgfcjEE45B2UJ/YXW4pnWtvcty2Yu4SEKvmYhG5TWVtcQBVX8xJ
 Gm0dZDiZd2thRrLvQGfzV+33LKRVEslp1JtSb/P2jUtEH4heIjbvYTFvfI+WortGha8a+AN9y8y
 Qa/WE3lEjU5qoDRDwWJ1/SXI6o33furO0JO5moAU0YudFLifwEFg1whnQ5BYypE5RctbjpEpO07
 48tDuH1KQrCfw1FOd4xhmDmmSodELMNagZ9f50LTSoF3Htdcw8nNn2igPntwklD6puefQx1mv/t
 41kG0pEQDecc8yybHUm57s2ZOMWZ6so9QegOIiXTjQ5u3ZsL93v/VH/9bSGY5Qy0TE9vnssw9xN
 9sumIMARVZ4ALmpso5j+YXHGyfGivnScRUd/Q62jw+kGrKYJPcqOgDy5TKl4QYxBw8NuXqgMxbv
 1meeUg+0pqh0np9cJoA==
X-Authority-Analysis: v=2.4 cv=YPYKWhGx c=1 sm=1 tr=0 ts=6af93d7e cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=hVFtLThziIPPOTj0udsA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 53nLVn3n5LXhtdNAcZCbRTQgU2W94Kgn
X-Proofpoint-ORIG-GUID: 53nLVn3n5LXhtdNAcZCbRTQgU2W94Kgn
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE1MDAxOSBTYWx0ZWRfX3f5JOYhQ+Z/c
 Hd9AX8NMNfhLA5ApMrVwC49aZHmTp39pUgVmmnVP6vGvJ20IiJ42XzheG/zNFohbC2Sv3bPEW6Y
 dSCSS9h+6LCBOWP6fccCnNZuZThAcAg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-15_02,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1015 spamscore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611150019
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

Add a config file listing the capsules to be generated through the
mkeficapsule config-file parser. This is for sandbox capsule
update tests.

Fix Test05, which had two identical blocks (same image-guid and
image-index) that would now silently merge into an unintended
2-payload capsule under the parser's new grouping-by-filename
behavior; give the second block its own index and GUID so Test05
instead demonstrates multi-payload grouping on purpose.

Add Test116 to cover a multi-payload capsule with a signed first
payload and an unsigned second payload, and Test06/Test15 to cover
the same raw-image update path (rather than the existing FIT-image
examples), with Test06 unsigned and Test15 signing each payload
independently.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

---
Changes in v2:
- drop the sandbox_defconfig changes, the tests now use the config
  file by its fixed path, so the EFI_CAPSULE_CFG_FILE and
  EFI_USE_CAPSULE_CFG_FILE Kconfig symbols are not needed
- use the current SANDBOX_FIT_IMAGE_GUID for the FIT image capsules, the
  old GUID was left over from an earlier version of this config file
---
 .../tests/test_efi_capsule/sandbox_capsule_cfg.txt | 118 +++++++++++++++++++++
 1 file changed, 118 insertions(+)

diff --git a/test/py/tests/test_efi_capsule/sandbox_capsule_cfg.txt b/test/py/tests/test_efi_capsule/sandbox_capsule_cfg.txt
new file mode 100644
index 00000000000..4ff4eedcbe8
--- /dev/null
+++ b/test/py/tests/test_efi_capsule/sandbox_capsule_cfg.txt
@@ -0,0 +1,118 @@
+{
+	image-index: 1
+	image-guid: 46610520-469E-59DC-A8DD-C11832B877EA
+	payload: u-boot_bin_env.itb
+	capsule: Test04
+
+}
+{
+	image-index: 1
+	image-guid: 058B7D83-50D5-4C47-A195-60D86AD341C4
+	payload: u-boot_bin_env.itb
+	capsule: Test05
+
+}
+{
+	image-index: 2
+	image-guid: B0ECDF61-24BC-4A61-A0A9-095A77279E84
+	payload: u-boot_bin_env.itb
+	capsule: Test05
+}
+{
+	image-index: 1
+	monotonic-count: 1
+	private-key: SIGNER.key
+	pub-key-cert: SIGNER.crt
+	image-guid: 46610520-469E-59DC-A8DD-C11832B877EA
+	payload: u-boot_bin_env.itb
+	capsule: Test13
+}
+{
+	image-index: 1
+	monotonic-count: 1
+	private-key: SIGNER2.key
+	pub-key-cert: SIGNER2.crt
+	image-guid: 46610520-469E-59DC-A8DD-C11832B877EA
+	payload: u-boot_bin_env.itb
+	capsule: Test14
+}
+{
+	image-index: 1
+	fw-version: 5
+	image-guid: 46610520-469E-59DC-A8DD-C11832B877EA
+	payload: u-boot_bin_env.itb
+	capsule: Test104
+}
+{
+	image-index: 1
+	fw-version: 2
+	image-guid: 46610520-469E-59DC-A8DD-C11832B877EA
+	payload: u-boot_bin_env.itb
+	capsule: Test105
+
+}
+{
+	image-index: 1
+	fw-version: 5
+	monotonic-count: 1
+	private-key: SIGNER.key
+	pub-key-cert: SIGNER.crt
+	image-guid: 46610520-469E-59DC-A8DD-C11832B877EA
+	payload: u-boot_bin_env.itb
+	capsule: Test114
+}
+{
+	image-index: 1
+	fw-version: 2
+	monotonic-count: 1
+	private-key: SIGNER.key
+	pub-key-cert: SIGNER.crt
+	image-guid: 46610520-469E-59DC-A8DD-C11832B877EA
+	payload: u-boot_bin_env.itb
+	capsule: Test115
+}
+{
+	image-index: 1
+	monotonic-count: 1
+	private-key: SIGNER.key
+	pub-key-cert: SIGNER.crt
+	image-guid: 46610520-469E-59DC-A8DD-C11832B877EA
+	payload: u-boot_bin_env.itb
+	capsule: Test116
+}
+{
+	image-index: 2
+	image-guid: 339B1ED4-A9C4-4A4E-A3E4-04138A91734B
+	payload: u-boot_bin_env.itb
+	capsule: Test116
+}
+{
+	image-index: 1
+	image-guid: 985F2937-7C2E-5E9A-8A5E-8E063312964B
+	payload: u-boot.bin.new
+	capsule: Test06
+}
+{
+	image-index: 2
+	image-guid: 9E339473-C2EB-530A-A69B-0CD6BBBED40E
+	payload: u-boot.env.new
+	capsule: Test06
+}
+{
+	image-index: 1
+	monotonic-count: 1
+	private-key: SIGNER.key
+	pub-key-cert: SIGNER.crt
+	image-guid: 985F2937-7C2E-5E9A-8A5E-8E063312964B
+	payload: u-boot.bin.new
+	capsule: Test15
+}
+{
+	image-index: 2
+	monotonic-count: 1
+	private-key: SIGNER.key
+	pub-key-cert: SIGNER.crt
+	image-guid: 9E339473-C2EB-530A-A69B-0CD6BBBED40E
+	payload: u-boot.env.new
+	capsule: Test15
+}

-- 
2.34.1

