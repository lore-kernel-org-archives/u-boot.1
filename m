Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BE6606A31B
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 19:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=sjScIzXi;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=o3Yxauhm;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BcbttE4G
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2449981678;
	Fri, 23 Oct 2026 19:51:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id U23lJBYZRwrn; Fri, 23 Oct 2026 19:51:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 53F5981690
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792785080;
	b=fQVKB7tJg9fana2R+EVcAFUBXm39+6hC0xB2zMBvyu6ppQoyzZqtk5CCazJhVS9iUwR+
	 6oQ6xjCXaNTXdQhnMCNyWaNV4KJhu9mHOVBS6xGOeG141SWScVn+B4Ddgfh7dlUthWwsO
	 uCWCcKWRBjxU+5YHUy8JpmI24+1izX/F0nATB1+HDcGYm2xOLZrp0mesWi3lPthHYfQii
	 nIdZQsVt1y53fnZO2cer3KSF/5GeE2ZihT8nBkOhQHdlX0UwwtRhJ1Tim8iSiK7A1dKzX
	 5X7w4t0CEg7gdxjAz65VyK9D9ziI6pB1YTxTgMCfCre4f+aUTEsOhcqBxfcllR0pSDg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792785080;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=IwJA+Ovq2E4/hp9Tmhktd2RnQflUjfPFhmY9PwivUfY=;
	b=ZVTDySkLr5ddCIUo2vAoVQKcIijv3LtfBRVoZwkGM4uIKOwdGZQrxnC8PHQy0XHT5+bC
	 4XiNe7ONSw1gd+FqIzxKoCjPqgcYtmhyCpQ3yHcGRh6QCcmlfAsDL6Ybpdg5XiWwSopcI
	 9H8IWew15pUTfOXhLhQXCoB3qJJJUqV3lc6a22XjsrqDuqd4TwIZ3RehyafKKXCnkoGqG
	 B7ugIqCdyXQdQCG5A9bPo+llvVgAvH9/g1EpJU+PHwDy9Z2mNCCAXY/3JD2mnHnXfFFg1
	 Vww6Gw4sXIhJ+FAm9P3sFyQWQCEo69KlyNDHpiXbTSKpGpuN4Apbg862XmJUY6PCM/A==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792785080;
	bh=IwJA+Ovq2E4/hp9Tmhktd2RnQflUjfPFhmY9PwivUfY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sjScIzXieiTSsWbrEW96tQtFRtv442cZHFqsJjdeyjSV9FJFksPiLEvdZO7PpiHtR
	 rbnZcXHyp6FThV8ZSM+qP2A/bvoHygvKKRvsPLl/9zfRsYyutxZiC/3oQHSBWLpIqb
	 IUCgGaZ7xNqFmSRCQ/3TltZ0wCQhg32nX7+Bozw5/JwQ3icY25U5E8QE8IoMWmc7T0
	 lUSRjbXXEvWYBI8C9zid4pdWrhkdb9rLnOccVO2tt5wDg/13DsTQV//cjjInFVa8mk
	 iKxTRrlvXPBkwHuiiYQf6oo5Cm8Va2n/44FQnRLWfruzHPrscZKX2GpDL7NjPrpa0b
	 UWdx/Ie07+OmA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 53F5981690;
	Fri, 23 Oct 2026 19:51:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 654BE3C4
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 19:51:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 41A0660A4C
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 19:51:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Wfzm_6u0-whJ for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 19:51:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8568F60A4B
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792785074;
 b=XJKauRYF742i+/uC7fUELMF9yirm4soo+dTILZj8M4+axFmCUQwfMBOlDTgeHITq+y4O
 jDyGU6MpCQ7t1VFPp3APgO+50yy6xTRrU1mtPWkTfnQTyuIxVCv97O15RFAIRXx4wGAjX
 3Yj7rW73xKY4BHzxJipY3NP3GtJA2q1NcvjKgHAUsm5J+BMZUYbq5EThYYeWYPgseCe85
 79fU4J+YIG/0KDGKgACWhwWW7uzz2lHNSlejtPKZxE+N44LH6ArePenriE00MDdbQVPbV
 qvAgl+V9JqrxllLYEvtJFvr+9QYwh+x3CuKaqO9izWUixJazbFLyxou+0V2Hbi3DJUA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792785074;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:X-Authority-Analysis:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=IwJA+Ovq2E4/hp9Tmhktd2RnQflUjfPFhmY9PwivUfY=;
 b=YN8ay7fM6lL4kFKxmSnCYOG510YUvHhZ6xH8mKXAdXbjrDE3lYy1J9qNrDWuM1Jc4m+s
 mkbUJewqevnunMmIkOsNOXhEyewBYvu8h/2qqMxn77hGO+5CSfvCD0b389VuniOAhzkSR
 Be8zLq64inHCWX6NGr7bmt9l0qc/MS7mwMJEEz8s4FFrLGi8MXvisOGYQs3ZoQB06PJPR
 De/J+v8d1GAZRLU024GZnUmp7GuYn1LOUg8rXV5e04htJdt5H+sgEY23PVucyq9u1eZww
 k26EyKnYaVfUF9GVP2bmP5dBw5s0/ihhfG9Tih2hYd9b3zWLmKjrjf0Uia8aa/AH5Gg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=o3Yxauhm; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=BcbttE4G; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=o3Yxauhm; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=BcbttE4G
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8568F60A4B
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 19:51:13 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NIZN2o453742
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 19:51:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 IwJA+Ovq2E4/hp9Tmhktd2RnQflUjfPFhmY9PwivUfY=; b=o3YxauhmHkVOfTLz
 d77TGfMnjum6C4ooT6adHsEySttl6F6PVC3b16jYUo9p5xJWWfynbHYcZTuKnqk0
 V5CzzlU1egQzgn+qETUgMSqV/oEkWb+yJxGjB1ooK5uGbA+SIiXvgXM5Fz//NyvD
 Hob9pqB7zhVR+2eJyVDkLHvcbDTGmGyAIv/YngucpYqvAmVQZT4iFJwKODb4Hoh9
 6N5B7a9UMtOX7Br3wK/0h2tuFvCx+YW5sm13Lba7ODrhK8XMvenZD/iujU8KZ56W
 18CshH4eveWwifpyoDdaQR2Ur+roGPo5CP2qT8XyLGI0YhV39CvZCHo4V7GO0SdY
 q4E9Og==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgcr689h1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 19:51:12 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93f5844e383so226859485a.1
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 12:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792785072; x=1793389872;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IwJA+Ovq2E4/hp9Tmhktd2RnQflUjfPFhmY9PwivUfY=;
 b=BcbttE4G7+X0wNTo1drL0LRa0t6cMm8wYBkAoOmQvm8cvAZMa+JQ+nJE+H0o98NGHW
 DJeuTL6XxU+/VndcQ2oYOLQB8X4/eNJ7jWZ/3D4jM4/SDU4AlRxya6h8+eOhtXnAPsDJ
 pU7wzowy6Ub5Igt2h7/loMjzaWeXTQcSa+6uRC2p1MaVEK2Eln6N69KlVwtfnTgGl/aO
 gCBWBoQD0euBZDMANqE1HrpgHgH7hcex14jE3vFLd9MLRxeENjKraWIJeT+ZMSrBkxkm
 mJkiJ8rqHEhKBTi9B7otMdrMG1hF7WrFUeiwsHmwFzrivjn9bURp8gvbQs+CEhrKqDyJ
 Vjhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792785072; x=1793389872;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IwJA+Ovq2E4/hp9Tmhktd2RnQflUjfPFhmY9PwivUfY=;
 b=bc2IqXjSkwACbtJbYBbpvzycSlbmDh0S7pKDm8HYZguDH8512RbWXeVOjrknHRq4Xa
 QQPN59ziFQJpl5+qP87VxTile4C/SPCFLGRdPJdLNOnL7Zeqc+yCGp3HQLwjeNNskpvB
 neTEkFS43BvnsKksNdSM84QOpor4hG5+MkENmoeEb6mAJPpkrkz+RbKcRPKqottSJyyV
 mPrPWrgkF3E4vR6DWaY/Kjvo3VNaIcw9PPaRohXEwelTEzFTEnH9bbXU8mvsfJG7/hyF
 QSFaKV4V0jnYZvUh5/zqdoTlP61Q4PRFPPzllEj4haLtLapa8PYscP+9GsHrbUwQJfBD
 JNhw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxXlblbgzAXgPWfnRthabMKN8PXAyYN1Hz+BEyfwYJYFfggzUgFnfApkUT9rd6TEUciizMtnxI=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKECE9nVCxqxM8WUNb/8uyvWujuPus8h3SMDvdhW/fHpvot+50S
 PTMtDeWApppN6vZlliSUhVxY85rOFl7qKAg+dUvz/uHYN/DJAadUpzYSrTllen6jVFi5FgkTBYR
 ahSN233hyV4eDdQ9+dHA9GduoKfEXg5ADXuhzgIo04J63nx69+ZlqNyv4OROVMJOPaWGXo3A=
X-Gm-Gg: AYBFou156YFqZxh1dF29WaRG3RUO8eHeSKDPx0Qp2GuYctDZXbC7aAYo71Jv6PJFshD
 2jLbMXybwKzJv7vdGQpYjmNR/3iFJLUmg79VHSPGNuRZ3HgZzQ7G2lhcnWs6IiZQ0q/GHvEagqi
 xeZhaJZPRPZjvLJ1muArw9uBwZVW3sBPqz10WDHTu//TSFBwXoYzv1tuhsjEiFdrXDfT5VRL9ta
 zUdkb4jpacOvB4YboB0BbDiVjuor0dJW/YE7AbvWggFFz1+VAepfOvnetEdaUO+RJhK9F1JYh8a
 AjmyXGiQuGnv4Oc0AA83eNF2BUAPxkALTseuxTG9583lLauUc7QogtxpG67FG9QuKnweg0hn0js
 Qy+2XBGLJdNfiH8teYHWgNy6RyvRuNaXET8wNnOmRpomdk0g=
X-Received: by 2002:a05:620a:458e:b0:93f:216f:f404 with SMTP id
 af79cd13be357-940ef956be3mr10320585a.40.1792785071093; 
 Fri, 23 Oct 2026 12:51:11 -0700 (PDT)
X-Received: by 2002:a05:620a:458e:b0:93f:216f:f404 with SMTP id
 af79cd13be357-940ef956be3mr10316685a.40.1792785070341; 
 Fri, 23 Oct 2026 12:51:10 -0700 (PDT)
Received: from [127.0.1.1] (185-164-143-216.cgnat.inetia.pl. [185.164.143.216])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd7984f5sm456366b.77.2026.10.23.12.51.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 12:51:09 -0700 (PDT)
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 21:50:45 +0200
Subject: [PATCH 1/2] libavb: build the SHA functions on U-Boot's SHA
 library
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261023-upstream-libavb_b4-v1-1-97ed25b09ed3@oss.qualcomm.com>
References: <20261023-upstream-libavb_b4-v1-0-97ed25b09ed3@oss.qualcomm.com>
In-Reply-To: <20261023-upstream-libavb_b4-v1-0-97ed25b09ed3@oss.qualcomm.com>
To: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Vincent Jardin <vjardin@free.fr>, Petr Hodina <petr.hodina@protonmail.com>,
 Bruno Banelli <bbanelli@gmail.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Jan Kehren <jan.kehren@emteria.com>,
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Authority-Analysis: v=2.4 cv=HMRWhYtv c=1 sm=1 tr=0 ts=6adbbab0 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=+XDFW8w5h4l+9U6kKVkjeg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=e4PMwjkC_zZuZ-H3NLYA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA3OCBTYWx0ZWRfX4B9rdMAKFdM3
 gelKPllj7Ti9TdpJxt6PsVAnDaqasMddOu3SuuGkizSTPQqGwPbvWdKkZlB1Ku66vvu+4xpQzZF
 Z/pAlLf2Gvj0pk0KG6Z9XjzTejJnONTeCtShX5fpiP6CpgkFu4rf6EoK8annpnKuD1kx9HBGULW
 qlquSRptbLyMrwd7td2LMC716me4JQ+vp3X/mjovrJAt/gJUt3Zl5ITrUsqVmgQ9y2aDDt5yWhE
 GVoNdz4Kunwl0FQTpE1sEMr3QASsf3s0biHhYtgfXFJSzkdbMUNHBTvc5iK+IOVsIHTG9a3PVt/
 ib2RIdIoqr2ELNGn45p8r0XFvr9arnB5l/gHi6VGtdQalkgyybcFrKO6uAs4hUiWQ2eaRF7vhIR
 cVjpsn1yVR0Id54wEt8HDl0iuSVeYc3eAPUo/4zeCT3ppcppYpOB01J4bS3iilnOqzwDacJUhPV
 n1OMbDYmf+amhWMzSQw==
X-Proofpoint-ORIG-GUID: MTY8xKgKY50AFpzhS8y-t3Xoy7EfWiH7
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA3OCBTYWx0ZWRfX6Tx8+x5GO5fO
 4gJWcBoGQbF9uW/r8BIqyI7n221lKhw9UCNT7EPInVpZilx+kgO+bHBjA6aUMhFFJ9VvDapEmNE
 Lc83LQvdzGEq9/QwIR8UuILK3yAPHJw=
X-Proofpoint-GUID: MTY8xKgKY50AFpzhS8y-t3Xoy7EfWiH7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 suspectscore=0 spamscore=0 phishscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230078
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

libavb carried its own SHA-256 and SHA-512 implementations although
U-Boot has lib/sha256.c and lib/sha512.c, with hardware acceleration and
the mbedTLS back end behind the same API. Hashing a 64 MiB boot image is
the dominant cost of AVB verification, so use U-Boot's.

Follow upstream libavb's crypto back end layout: avb_sha.h takes the
implementation contexts from crypto/avb_crypto_ops_impl.h, which here
typedefs them to U-Boot's sha256_context/sha512_context, and
crypto/sha_impl.c maps avb_sha*_init/update/final onto
sha*_starts/update/finish. LIBAVB selects SHA256 and SHA512, and the
bundled avb_sha256.c and avb_sha512.c are dropped.

Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
---
 lib/Kconfig                             |   2 +
 lib/libavb/Makefile                     |   8 +-
 lib/libavb/avb_sha.h                    |  24 +-
 lib/libavb/avb_sha256.c                 | 375 --------------------------------
 lib/libavb/avb_sha512.c                 | 361 ------------------------------
 lib/libavb/crypto/avb_crypto_ops_impl.h |  43 ++++
 lib/libavb/crypto/sha_impl.c            |  50 +++++
 7 files changed, 111 insertions(+), 752 deletions(-)

diff --git a/lib/Kconfig b/lib/Kconfig
index 021a82d4709..73b6bbecbff 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -631,6 +631,8 @@ menu "Android Verified Boot"
 config LIBAVB
 	bool "Android Verified Boot 2.0 support"
 	depends on ANDROID_BOOT_IMAGE
+	select SHA256
+	select SHA512
 	help
 	  This enables support of Android Verified Boot 2.0 which can be used
 	  to assure the end user of the integrity of the software running on a
diff --git a/lib/libavb/Makefile b/lib/libavb/Makefile
index b983fe768e5..89451758db4 100644
--- a/lib/libavb/Makefile
+++ b/lib/libavb/Makefile
@@ -4,10 +4,12 @@
 
 obj-$(CONFIG_LIBAVB) += avb_chain_partition_descriptor.o avb_cmdline.o
 obj-$(CONFIG_LIBAVB) += avb_crypto.o avb_footer.o avb_hashtree_descriptor.o
-obj-$(CONFIG_LIBAVB) += avb_property_descriptor.o avb_sha256.o
+obj-$(CONFIG_LIBAVB) += avb_property_descriptor.o
 obj-$(CONFIG_LIBAVB) += avb_slot_verify.o avb_util.o avb_version.o
 obj-$(CONFIG_LIBAVB) += avb_descriptor.o avb_hash_descriptor.o
-obj-$(CONFIG_LIBAVB) += avb_kernel_cmdline_descriptor.o avb_rsa.o avb_sha512.o
+obj-$(CONFIG_LIBAVB) += avb_kernel_cmdline_descriptor.o avb_rsa.o
 obj-$(CONFIG_LIBAVB) += avb_sysdeps_posix.o avb_vbmeta_image.o
+obj-$(CONFIG_LIBAVB) += crypto/sha_impl.o
 
-ccflags-y = -DAVB_COMPILATION
+# avb_sha.h includes the crypto back end's avb_crypto_ops_impl.h
+ccflags-y = -DAVB_COMPILATION -I$(srctree)/$(src)/crypto
diff --git a/lib/libavb/avb_sha.h b/lib/libavb/avb_sha.h
index fdd92fbe22d..ffe3cc74984 100644
--- a/lib/libavb/avb_sha.h
+++ b/lib/libavb/avb_sha.h
@@ -21,27 +21,25 @@ extern "C" {
 #include "avb_crypto.h"
 #include "avb_sysdeps.h"
 
-/* Block size in bytes of a SHA-256 digest. */
-#define AVB_SHA256_BLOCK_SIZE 64
-
-/* Block size in bytes of a SHA-512 digest. */
-#define AVB_SHA512_BLOCK_SIZE 128
+/* The following types must be set to something appropriate
+ *
+ *   AvbSHA256ImplCtx - SHA-256 context used by the implementation
+ *   AvbSHA512ImplCtx - SHA-512 context used by the implementation
+ *
+ * We expect the implementation to provide a header file with the name
+ * avb_crypto_ops_impl.h to do all this.
+ */
+#include "avb_crypto_ops_impl.h"
 
 /* Data structure used for SHA-256. */
 typedef struct {
-  uint32_t h[8];
-  uint64_t tot_len;
-  size_t len;
-  uint8_t block[2 * AVB_SHA256_BLOCK_SIZE];
+  AvbSHA256ImplCtx impl;
   uint8_t buf[AVB_SHA256_DIGEST_SIZE]; /* Used for storing the final digest. */
 } AvbSHA256Ctx;
 
 /* Data structure used for SHA-512. */
 typedef struct {
-  uint64_t h[8];
-  uint64_t tot_len;
-  size_t len;
-  uint8_t block[2 * AVB_SHA512_BLOCK_SIZE];
+  AvbSHA512ImplCtx impl;
   uint8_t buf[AVB_SHA512_DIGEST_SIZE]; /* Used for storing the final digest. */
 } AvbSHA512Ctx;
 
diff --git a/lib/libavb/avb_sha256.c b/lib/libavb/avb_sha256.c
deleted file mode 100644
index 86ecca57b72..00000000000
--- a/lib/libavb/avb_sha256.c
+++ /dev/null
@@ -1,375 +0,0 @@
-// SPDX-License-Identifier: BSD-3-Clause
-/*
- * Copyright (C) 2005, 2007 Olivier Gay <olivier.gay@a3.epfl.ch>
- * All rights reserved.
- *
- * FIPS 180-2 SHA-224/256/384/512 implementation
- * Last update: 02/02/2007
- * Issue date:  04/30/2005
- */
-
-#include "avb_sha.h"
-
-#define SHFR(x, n) (x >> n)
-#define ROTR(x, n) ((x >> n) | (x << ((sizeof(x) << 3) - n)))
-#define ROTL(x, n) ((x << n) | (x >> ((sizeof(x) << 3) - n)))
-#define CH(x, y, z) ((x & y) ^ (~x & z))
-#define MAJ(x, y, z) ((x & y) ^ (x & z) ^ (y & z))
-
-#define SHA256_F1(x) (ROTR(x, 2) ^ ROTR(x, 13) ^ ROTR(x, 22))
-#define SHA256_F2(x) (ROTR(x, 6) ^ ROTR(x, 11) ^ ROTR(x, 25))
-#define SHA256_F3(x) (ROTR(x, 7) ^ ROTR(x, 18) ^ SHFR(x, 3))
-#define SHA256_F4(x) (ROTR(x, 17) ^ ROTR(x, 19) ^ SHFR(x, 10))
-
-#define UNPACK32(x, str)                 \
-  {                                      \
-    *((str) + 3) = (uint8_t)((x));       \
-    *((str) + 2) = (uint8_t)((x) >> 8);  \
-    *((str) + 1) = (uint8_t)((x) >> 16); \
-    *((str) + 0) = (uint8_t)((x) >> 24); \
-  }
-
-#define UNPACK64(x, str)                         \
-  {                                              \
-    *((str) + 7) = (uint8_t)x;                   \
-    *((str) + 6) = (uint8_t)((uint64_t)x >> 8);  \
-    *((str) + 5) = (uint8_t)((uint64_t)x >> 16); \
-    *((str) + 4) = (uint8_t)((uint64_t)x >> 24); \
-    *((str) + 3) = (uint8_t)((uint64_t)x >> 32); \
-    *((str) + 2) = (uint8_t)((uint64_t)x >> 40); \
-    *((str) + 1) = (uint8_t)((uint64_t)x >> 48); \
-    *((str) + 0) = (uint8_t)((uint64_t)x >> 56); \
-  }
-
-#define PACK32(str, x)                                                    \
-  {                                                                       \
-    *(x) = ((uint32_t) * ((str) + 3)) | ((uint32_t) * ((str) + 2) << 8) | \
-           ((uint32_t) * ((str) + 1) << 16) |                             \
-           ((uint32_t) * ((str) + 0) << 24);                              \
-  }
-
-/* Macros used for loops unrolling */
-
-#define SHA256_SCR(i) \
-  { w[i] = SHA256_F4(w[i - 2]) + w[i - 7] + SHA256_F3(w[i - 15]) + w[i - 16]; }
-
-#define SHA256_EXP(a, b, c, d, e, f, g, h, j)                               \
-  {                                                                         \
-    t1 = wv[h] + SHA256_F2(wv[e]) + CH(wv[e], wv[f], wv[g]) + sha256_k[j] + \
-         w[j];                                                              \
-    t2 = SHA256_F1(wv[a]) + MAJ(wv[a], wv[b], wv[c]);                       \
-    wv[d] += t1;                                                            \
-    wv[h] = t1 + t2;                                                        \
-  }
-
-static const uint32_t sha256_h0[8] = {0x6a09e667,
-                                      0xbb67ae85,
-                                      0x3c6ef372,
-                                      0xa54ff53a,
-                                      0x510e527f,
-                                      0x9b05688c,
-                                      0x1f83d9ab,
-                                      0x5be0cd19};
-
-static const uint32_t sha256_k[64] = {
-    0x428a2f98, 0x71374491, 0xb5c0fbcf, 0xe9b5dba5, 0x3956c25b, 0x59f111f1,
-    0x923f82a4, 0xab1c5ed5, 0xd807aa98, 0x12835b01, 0x243185be, 0x550c7dc3,
-    0x72be5d74, 0x80deb1fe, 0x9bdc06a7, 0xc19bf174, 0xe49b69c1, 0xefbe4786,
-    0x0fc19dc6, 0x240ca1cc, 0x2de92c6f, 0x4a7484aa, 0x5cb0a9dc, 0x76f988da,
-    0x983e5152, 0xa831c66d, 0xb00327c8, 0xbf597fc7, 0xc6e00bf3, 0xd5a79147,
-    0x06ca6351, 0x14292967, 0x27b70a85, 0x2e1b2138, 0x4d2c6dfc, 0x53380d13,
-    0x650a7354, 0x766a0abb, 0x81c2c92e, 0x92722c85, 0xa2bfe8a1, 0xa81a664b,
-    0xc24b8b70, 0xc76c51a3, 0xd192e819, 0xd6990624, 0xf40e3585, 0x106aa070,
-    0x19a4c116, 0x1e376c08, 0x2748774c, 0x34b0bcb5, 0x391c0cb3, 0x4ed8aa4a,
-    0x5b9cca4f, 0x682e6ff3, 0x748f82ee, 0x78a5636f, 0x84c87814, 0x8cc70208,
-    0x90befffa, 0xa4506ceb, 0xbef9a3f7, 0xc67178f2};
-
-/* SHA-256 implementation */
-void avb_sha256_init(AvbSHA256Ctx* ctx) {
-#ifndef UNROLL_LOOPS
-  int i;
-  for (i = 0; i < 8; i++) {
-    ctx->h[i] = sha256_h0[i];
-  }
-#else
-  ctx->h[0] = sha256_h0[0];
-  ctx->h[1] = sha256_h0[1];
-  ctx->h[2] = sha256_h0[2];
-  ctx->h[3] = sha256_h0[3];
-  ctx->h[4] = sha256_h0[4];
-  ctx->h[5] = sha256_h0[5];
-  ctx->h[6] = sha256_h0[6];
-  ctx->h[7] = sha256_h0[7];
-#endif /* !UNROLL_LOOPS */
-
-  ctx->len = 0;
-  ctx->tot_len = 0;
-}
-
-static void SHA256_transform(AvbSHA256Ctx* ctx,
-                             const uint8_t* message,
-                             size_t block_nb) {
-  uint32_t w[64];
-  uint32_t wv[8];
-  uint32_t t1, t2;
-  const unsigned char* sub_block;
-  size_t i;
-
-#ifndef UNROLL_LOOPS
-  size_t j;
-#endif
-
-  for (i = 0; i < block_nb; i++) {
-    sub_block = message + (i << 6);
-
-#ifndef UNROLL_LOOPS
-    for (j = 0; j < 16; j++) {
-      PACK32(&sub_block[j << 2], &w[j]);
-    }
-
-    for (j = 16; j < 64; j++) {
-      SHA256_SCR(j);
-    }
-
-    for (j = 0; j < 8; j++) {
-      wv[j] = ctx->h[j];
-    }
-
-    for (j = 0; j < 64; j++) {
-      t1 = wv[7] + SHA256_F2(wv[4]) + CH(wv[4], wv[5], wv[6]) + sha256_k[j] +
-           w[j];
-      t2 = SHA256_F1(wv[0]) + MAJ(wv[0], wv[1], wv[2]);
-      wv[7] = wv[6];
-      wv[6] = wv[5];
-      wv[5] = wv[4];
-      wv[4] = wv[3] + t1;
-      wv[3] = wv[2];
-      wv[2] = wv[1];
-      wv[1] = wv[0];
-      wv[0] = t1 + t2;
-    }
-
-    for (j = 0; j < 8; j++) {
-      ctx->h[j] += wv[j];
-    }
-#else
-    PACK32(&sub_block[0], &w[0]);
-    PACK32(&sub_block[4], &w[1]);
-    PACK32(&sub_block[8], &w[2]);
-    PACK32(&sub_block[12], &w[3]);
-    PACK32(&sub_block[16], &w[4]);
-    PACK32(&sub_block[20], &w[5]);
-    PACK32(&sub_block[24], &w[6]);
-    PACK32(&sub_block[28], &w[7]);
-    PACK32(&sub_block[32], &w[8]);
-    PACK32(&sub_block[36], &w[9]);
-    PACK32(&sub_block[40], &w[10]);
-    PACK32(&sub_block[44], &w[11]);
-    PACK32(&sub_block[48], &w[12]);
-    PACK32(&sub_block[52], &w[13]);
-    PACK32(&sub_block[56], &w[14]);
-    PACK32(&sub_block[60], &w[15]);
-
-    SHA256_SCR(16);
-    SHA256_SCR(17);
-    SHA256_SCR(18);
-    SHA256_SCR(19);
-    SHA256_SCR(20);
-    SHA256_SCR(21);
-    SHA256_SCR(22);
-    SHA256_SCR(23);
-    SHA256_SCR(24);
-    SHA256_SCR(25);
-    SHA256_SCR(26);
-    SHA256_SCR(27);
-    SHA256_SCR(28);
-    SHA256_SCR(29);
-    SHA256_SCR(30);
-    SHA256_SCR(31);
-    SHA256_SCR(32);
-    SHA256_SCR(33);
-    SHA256_SCR(34);
-    SHA256_SCR(35);
-    SHA256_SCR(36);
-    SHA256_SCR(37);
-    SHA256_SCR(38);
-    SHA256_SCR(39);
-    SHA256_SCR(40);
-    SHA256_SCR(41);
-    SHA256_SCR(42);
-    SHA256_SCR(43);
-    SHA256_SCR(44);
-    SHA256_SCR(45);
-    SHA256_SCR(46);
-    SHA256_SCR(47);
-    SHA256_SCR(48);
-    SHA256_SCR(49);
-    SHA256_SCR(50);
-    SHA256_SCR(51);
-    SHA256_SCR(52);
-    SHA256_SCR(53);
-    SHA256_SCR(54);
-    SHA256_SCR(55);
-    SHA256_SCR(56);
-    SHA256_SCR(57);
-    SHA256_SCR(58);
-    SHA256_SCR(59);
-    SHA256_SCR(60);
-    SHA256_SCR(61);
-    SHA256_SCR(62);
-    SHA256_SCR(63);
-
-    wv[0] = ctx->h[0];
-    wv[1] = ctx->h[1];
-    wv[2] = ctx->h[2];
-    wv[3] = ctx->h[3];
-    wv[4] = ctx->h[4];
-    wv[5] = ctx->h[5];
-    wv[6] = ctx->h[6];
-    wv[7] = ctx->h[7];
-
-    SHA256_EXP(0, 1, 2, 3, 4, 5, 6, 7, 0);
-    SHA256_EXP(7, 0, 1, 2, 3, 4, 5, 6, 1);
-    SHA256_EXP(6, 7, 0, 1, 2, 3, 4, 5, 2);
-    SHA256_EXP(5, 6, 7, 0, 1, 2, 3, 4, 3);
-    SHA256_EXP(4, 5, 6, 7, 0, 1, 2, 3, 4);
-    SHA256_EXP(3, 4, 5, 6, 7, 0, 1, 2, 5);
-    SHA256_EXP(2, 3, 4, 5, 6, 7, 0, 1, 6);
-    SHA256_EXP(1, 2, 3, 4, 5, 6, 7, 0, 7);
-    SHA256_EXP(0, 1, 2, 3, 4, 5, 6, 7, 8);
-    SHA256_EXP(7, 0, 1, 2, 3, 4, 5, 6, 9);
-    SHA256_EXP(6, 7, 0, 1, 2, 3, 4, 5, 10);
-    SHA256_EXP(5, 6, 7, 0, 1, 2, 3, 4, 11);
-    SHA256_EXP(4, 5, 6, 7, 0, 1, 2, 3, 12);
-    SHA256_EXP(3, 4, 5, 6, 7, 0, 1, 2, 13);
-    SHA256_EXP(2, 3, 4, 5, 6, 7, 0, 1, 14);
-    SHA256_EXP(1, 2, 3, 4, 5, 6, 7, 0, 15);
-    SHA256_EXP(0, 1, 2, 3, 4, 5, 6, 7, 16);
-    SHA256_EXP(7, 0, 1, 2, 3, 4, 5, 6, 17);
-    SHA256_EXP(6, 7, 0, 1, 2, 3, 4, 5, 18);
-    SHA256_EXP(5, 6, 7, 0, 1, 2, 3, 4, 19);
-    SHA256_EXP(4, 5, 6, 7, 0, 1, 2, 3, 20);
-    SHA256_EXP(3, 4, 5, 6, 7, 0, 1, 2, 21);
-    SHA256_EXP(2, 3, 4, 5, 6, 7, 0, 1, 22);
-    SHA256_EXP(1, 2, 3, 4, 5, 6, 7, 0, 23);
-    SHA256_EXP(0, 1, 2, 3, 4, 5, 6, 7, 24);
-    SHA256_EXP(7, 0, 1, 2, 3, 4, 5, 6, 25);
-    SHA256_EXP(6, 7, 0, 1, 2, 3, 4, 5, 26);
-    SHA256_EXP(5, 6, 7, 0, 1, 2, 3, 4, 27);
-    SHA256_EXP(4, 5, 6, 7, 0, 1, 2, 3, 28);
-    SHA256_EXP(3, 4, 5, 6, 7, 0, 1, 2, 29);
-    SHA256_EXP(2, 3, 4, 5, 6, 7, 0, 1, 30);
-    SHA256_EXP(1, 2, 3, 4, 5, 6, 7, 0, 31);
-    SHA256_EXP(0, 1, 2, 3, 4, 5, 6, 7, 32);
-    SHA256_EXP(7, 0, 1, 2, 3, 4, 5, 6, 33);
-    SHA256_EXP(6, 7, 0, 1, 2, 3, 4, 5, 34);
-    SHA256_EXP(5, 6, 7, 0, 1, 2, 3, 4, 35);
-    SHA256_EXP(4, 5, 6, 7, 0, 1, 2, 3, 36);
-    SHA256_EXP(3, 4, 5, 6, 7, 0, 1, 2, 37);
-    SHA256_EXP(2, 3, 4, 5, 6, 7, 0, 1, 38);
-    SHA256_EXP(1, 2, 3, 4, 5, 6, 7, 0, 39);
-    SHA256_EXP(0, 1, 2, 3, 4, 5, 6, 7, 40);
-    SHA256_EXP(7, 0, 1, 2, 3, 4, 5, 6, 41);
-    SHA256_EXP(6, 7, 0, 1, 2, 3, 4, 5, 42);
-    SHA256_EXP(5, 6, 7, 0, 1, 2, 3, 4, 43);
-    SHA256_EXP(4, 5, 6, 7, 0, 1, 2, 3, 44);
-    SHA256_EXP(3, 4, 5, 6, 7, 0, 1, 2, 45);
-    SHA256_EXP(2, 3, 4, 5, 6, 7, 0, 1, 46);
-    SHA256_EXP(1, 2, 3, 4, 5, 6, 7, 0, 47);
-    SHA256_EXP(0, 1, 2, 3, 4, 5, 6, 7, 48);
-    SHA256_EXP(7, 0, 1, 2, 3, 4, 5, 6, 49);
-    SHA256_EXP(6, 7, 0, 1, 2, 3, 4, 5, 50);
-    SHA256_EXP(5, 6, 7, 0, 1, 2, 3, 4, 51);
-    SHA256_EXP(4, 5, 6, 7, 0, 1, 2, 3, 52);
-    SHA256_EXP(3, 4, 5, 6, 7, 0, 1, 2, 53);
-    SHA256_EXP(2, 3, 4, 5, 6, 7, 0, 1, 54);
-    SHA256_EXP(1, 2, 3, 4, 5, 6, 7, 0, 55);
-    SHA256_EXP(0, 1, 2, 3, 4, 5, 6, 7, 56);
-    SHA256_EXP(7, 0, 1, 2, 3, 4, 5, 6, 57);
-    SHA256_EXP(6, 7, 0, 1, 2, 3, 4, 5, 58);
-    SHA256_EXP(5, 6, 7, 0, 1, 2, 3, 4, 59);
-    SHA256_EXP(4, 5, 6, 7, 0, 1, 2, 3, 60);
-    SHA256_EXP(3, 4, 5, 6, 7, 0, 1, 2, 61);
-    SHA256_EXP(2, 3, 4, 5, 6, 7, 0, 1, 62);
-    SHA256_EXP(1, 2, 3, 4, 5, 6, 7, 0, 63);
-
-    ctx->h[0] += wv[0];
-    ctx->h[1] += wv[1];
-    ctx->h[2] += wv[2];
-    ctx->h[3] += wv[3];
-    ctx->h[4] += wv[4];
-    ctx->h[5] += wv[5];
-    ctx->h[6] += wv[6];
-    ctx->h[7] += wv[7];
-#endif /* !UNROLL_LOOPS */
-  }
-}
-
-void avb_sha256_update(AvbSHA256Ctx* ctx, const uint8_t* data, size_t len) {
-  size_t block_nb;
-  size_t new_len, rem_len, tmp_len;
-  const uint8_t* shifted_data;
-
-  tmp_len = AVB_SHA256_BLOCK_SIZE - ctx->len;
-  rem_len = len < tmp_len ? len : tmp_len;
-
-  avb_memcpy(&ctx->block[ctx->len], data, rem_len);
-
-  if (ctx->len + len < AVB_SHA256_BLOCK_SIZE) {
-    ctx->len += len;
-    return;
-  }
-
-  new_len = len - rem_len;
-  block_nb = new_len / AVB_SHA256_BLOCK_SIZE;
-
-  shifted_data = data + rem_len;
-
-  SHA256_transform(ctx, ctx->block, 1);
-  SHA256_transform(ctx, shifted_data, block_nb);
-
-  rem_len = new_len % AVB_SHA256_BLOCK_SIZE;
-
-  avb_memcpy(ctx->block, &shifted_data[block_nb << 6], rem_len);
-
-  ctx->len = rem_len;
-  ctx->tot_len += (block_nb + 1) << 6;
-}
-
-uint8_t* avb_sha256_final(AvbSHA256Ctx* ctx) {
-  size_t block_nb;
-  size_t pm_len;
-  uint64_t len_b;
-#ifndef UNROLL_LOOPS
-  size_t i;
-#endif
-
-  block_nb =
-      (1 + ((AVB_SHA256_BLOCK_SIZE - 9) < (ctx->len % AVB_SHA256_BLOCK_SIZE)));
-
-  len_b = (ctx->tot_len + ctx->len) << 3;
-  pm_len = block_nb << 6;
-
-  avb_memset(ctx->block + ctx->len, 0, pm_len - ctx->len);
-  ctx->block[ctx->len] = 0x80;
-  UNPACK64(len_b, ctx->block + pm_len - 8);
-
-  SHA256_transform(ctx, ctx->block, block_nb);
-
-#ifndef UNROLL_LOOPS
-  for (i = 0; i < 8; i++) {
-    UNPACK32(ctx->h[i], &ctx->buf[i << 2]);
-  }
-#else
-  UNPACK32(ctx->h[0], &ctx->buf[0]);
-  UNPACK32(ctx->h[1], &ctx->buf[4]);
-  UNPACK32(ctx->h[2], &ctx->buf[8]);
-  UNPACK32(ctx->h[3], &ctx->buf[12]);
-  UNPACK32(ctx->h[4], &ctx->buf[16]);
-  UNPACK32(ctx->h[5], &ctx->buf[20]);
-  UNPACK32(ctx->h[6], &ctx->buf[24]);
-  UNPACK32(ctx->h[7], &ctx->buf[28]);
-#endif /* !UNROLL_LOOPS */
-
-  return ctx->buf;
-}
diff --git a/lib/libavb/avb_sha512.c b/lib/libavb/avb_sha512.c
deleted file mode 100644
index b19054fc749..00000000000
--- a/lib/libavb/avb_sha512.c
+++ /dev/null
@@ -1,361 +0,0 @@
-// SPDX-License-Identifier: BSD-3-Clause
-/*
- * Copyright (C) 2005, 2007 Olivier Gay <olivier.gay@a3.epfl.ch>
- * All rights reserved.
- *
- * FIPS 180-2 SHA-224/256/384/512 implementation
- * Last update: 02/02/2007
- * Issue date:  04/30/2005
- */
-
-#include "avb_sha.h"
-
-#define SHFR(x, n) (x >> n)
-#define ROTR(x, n) ((x >> n) | (x << ((sizeof(x) << 3) - n)))
-#define ROTL(x, n) ((x << n) | (x >> ((sizeof(x) << 3) - n)))
-#define CH(x, y, z) ((x & y) ^ (~x & z))
-#define MAJ(x, y, z) ((x & y) ^ (x & z) ^ (y & z))
-
-#define SHA512_F1(x) (ROTR(x, 28) ^ ROTR(x, 34) ^ ROTR(x, 39))
-#define SHA512_F2(x) (ROTR(x, 14) ^ ROTR(x, 18) ^ ROTR(x, 41))
-#define SHA512_F3(x) (ROTR(x, 1) ^ ROTR(x, 8) ^ SHFR(x, 7))
-#define SHA512_F4(x) (ROTR(x, 19) ^ ROTR(x, 61) ^ SHFR(x, 6))
-
-#define UNPACK32(x, str)                 \
-  {                                      \
-    *((str) + 3) = (uint8_t)((x));       \
-    *((str) + 2) = (uint8_t)((x) >> 8);  \
-    *((str) + 1) = (uint8_t)((x) >> 16); \
-    *((str) + 0) = (uint8_t)((x) >> 24); \
-  }
-
-#define UNPACK64(x, str)                         \
-  {                                              \
-    *((str) + 7) = (uint8_t)x;                   \
-    *((str) + 6) = (uint8_t)((uint64_t)x >> 8);  \
-    *((str) + 5) = (uint8_t)((uint64_t)x >> 16); \
-    *((str) + 4) = (uint8_t)((uint64_t)x >> 24); \
-    *((str) + 3) = (uint8_t)((uint64_t)x >> 32); \
-    *((str) + 2) = (uint8_t)((uint64_t)x >> 40); \
-    *((str) + 1) = (uint8_t)((uint64_t)x >> 48); \
-    *((str) + 0) = (uint8_t)((uint64_t)x >> 56); \
-  }
-
-#define PACK64(str, x)                                                        \
-  {                                                                           \
-    *(x) =                                                                    \
-        ((uint64_t) * ((str) + 7)) | ((uint64_t) * ((str) + 6) << 8) |        \
-        ((uint64_t) * ((str) + 5) << 16) | ((uint64_t) * ((str) + 4) << 24) | \
-        ((uint64_t) * ((str) + 3) << 32) | ((uint64_t) * ((str) + 2) << 40) | \
-        ((uint64_t) * ((str) + 1) << 48) | ((uint64_t) * ((str) + 0) << 56);  \
-  }
-
-/* Macros used for loops unrolling */
-
-#define SHA512_SCR(i) \
-  { w[i] = SHA512_F4(w[i - 2]) + w[i - 7] + SHA512_F3(w[i - 15]) + w[i - 16]; }
-
-#define SHA512_EXP(a, b, c, d, e, f, g, h, j)                               \
-  {                                                                         \
-    t1 = wv[h] + SHA512_F2(wv[e]) + CH(wv[e], wv[f], wv[g]) + sha512_k[j] + \
-         w[j];                                                              \
-    t2 = SHA512_F1(wv[a]) + MAJ(wv[a], wv[b], wv[c]);                       \
-    wv[d] += t1;                                                            \
-    wv[h] = t1 + t2;                                                        \
-  }
-
-static const uint64_t sha512_h0[8] = {0x6a09e667f3bcc908ULL,
-                                      0xbb67ae8584caa73bULL,
-                                      0x3c6ef372fe94f82bULL,
-                                      0xa54ff53a5f1d36f1ULL,
-                                      0x510e527fade682d1ULL,
-                                      0x9b05688c2b3e6c1fULL,
-                                      0x1f83d9abfb41bd6bULL,
-                                      0x5be0cd19137e2179ULL};
-
-static const uint64_t sha512_k[80] = {
-    0x428a2f98d728ae22ULL, 0x7137449123ef65cdULL, 0xb5c0fbcfec4d3b2fULL,
-    0xe9b5dba58189dbbcULL, 0x3956c25bf348b538ULL, 0x59f111f1b605d019ULL,
-    0x923f82a4af194f9bULL, 0xab1c5ed5da6d8118ULL, 0xd807aa98a3030242ULL,
-    0x12835b0145706fbeULL, 0x243185be4ee4b28cULL, 0x550c7dc3d5ffb4e2ULL,
-    0x72be5d74f27b896fULL, 0x80deb1fe3b1696b1ULL, 0x9bdc06a725c71235ULL,
-    0xc19bf174cf692694ULL, 0xe49b69c19ef14ad2ULL, 0xefbe4786384f25e3ULL,
-    0x0fc19dc68b8cd5b5ULL, 0x240ca1cc77ac9c65ULL, 0x2de92c6f592b0275ULL,
-    0x4a7484aa6ea6e483ULL, 0x5cb0a9dcbd41fbd4ULL, 0x76f988da831153b5ULL,
-    0x983e5152ee66dfabULL, 0xa831c66d2db43210ULL, 0xb00327c898fb213fULL,
-    0xbf597fc7beef0ee4ULL, 0xc6e00bf33da88fc2ULL, 0xd5a79147930aa725ULL,
-    0x06ca6351e003826fULL, 0x142929670a0e6e70ULL, 0x27b70a8546d22ffcULL,
-    0x2e1b21385c26c926ULL, 0x4d2c6dfc5ac42aedULL, 0x53380d139d95b3dfULL,
-    0x650a73548baf63deULL, 0x766a0abb3c77b2a8ULL, 0x81c2c92e47edaee6ULL,
-    0x92722c851482353bULL, 0xa2bfe8a14cf10364ULL, 0xa81a664bbc423001ULL,
-    0xc24b8b70d0f89791ULL, 0xc76c51a30654be30ULL, 0xd192e819d6ef5218ULL,
-    0xd69906245565a910ULL, 0xf40e35855771202aULL, 0x106aa07032bbd1b8ULL,
-    0x19a4c116b8d2d0c8ULL, 0x1e376c085141ab53ULL, 0x2748774cdf8eeb99ULL,
-    0x34b0bcb5e19b48a8ULL, 0x391c0cb3c5c95a63ULL, 0x4ed8aa4ae3418acbULL,
-    0x5b9cca4f7763e373ULL, 0x682e6ff3d6b2b8a3ULL, 0x748f82ee5defb2fcULL,
-    0x78a5636f43172f60ULL, 0x84c87814a1f0ab72ULL, 0x8cc702081a6439ecULL,
-    0x90befffa23631e28ULL, 0xa4506cebde82bde9ULL, 0xbef9a3f7b2c67915ULL,
-    0xc67178f2e372532bULL, 0xca273eceea26619cULL, 0xd186b8c721c0c207ULL,
-    0xeada7dd6cde0eb1eULL, 0xf57d4f7fee6ed178ULL, 0x06f067aa72176fbaULL,
-    0x0a637dc5a2c898a6ULL, 0x113f9804bef90daeULL, 0x1b710b35131c471bULL,
-    0x28db77f523047d84ULL, 0x32caab7b40c72493ULL, 0x3c9ebe0a15c9bebcULL,
-    0x431d67c49c100d4cULL, 0x4cc5d4becb3e42b6ULL, 0x597f299cfc657e2aULL,
-    0x5fcb6fab3ad6faecULL, 0x6c44198c4a475817ULL};
-
-/* SHA-512 implementation */
-
-void avb_sha512_init(AvbSHA512Ctx* ctx) {
-#ifdef UNROLL_LOOPS_SHA512
-  ctx->h[0] = sha512_h0[0];
-  ctx->h[1] = sha512_h0[1];
-  ctx->h[2] = sha512_h0[2];
-  ctx->h[3] = sha512_h0[3];
-  ctx->h[4] = sha512_h0[4];
-  ctx->h[5] = sha512_h0[5];
-  ctx->h[6] = sha512_h0[6];
-  ctx->h[7] = sha512_h0[7];
-#else
-  int i;
-
-  for (i = 0; i < 8; i++)
-    ctx->h[i] = sha512_h0[i];
-#endif /* UNROLL_LOOPS_SHA512 */
-
-  ctx->len = 0;
-  ctx->tot_len = 0;
-}
-
-static void SHA512_transform(AvbSHA512Ctx* ctx,
-                             const uint8_t* message,
-                             size_t block_nb) {
-  uint64_t w[80];
-  uint64_t wv[8];
-  uint64_t t1, t2;
-  const uint8_t* sub_block;
-  size_t i, j;
-
-  for (i = 0; i < block_nb; i++) {
-    sub_block = message + (i << 7);
-
-#ifdef UNROLL_LOOPS_SHA512
-    PACK64(&sub_block[0], &w[0]);
-    PACK64(&sub_block[8], &w[1]);
-    PACK64(&sub_block[16], &w[2]);
-    PACK64(&sub_block[24], &w[3]);
-    PACK64(&sub_block[32], &w[4]);
-    PACK64(&sub_block[40], &w[5]);
-    PACK64(&sub_block[48], &w[6]);
-    PACK64(&sub_block[56], &w[7]);
-    PACK64(&sub_block[64], &w[8]);
-    PACK64(&sub_block[72], &w[9]);
-    PACK64(&sub_block[80], &w[10]);
-    PACK64(&sub_block[88], &w[11]);
-    PACK64(&sub_block[96], &w[12]);
-    PACK64(&sub_block[104], &w[13]);
-    PACK64(&sub_block[112], &w[14]);
-    PACK64(&sub_block[120], &w[15]);
-
-    SHA512_SCR(16);
-    SHA512_SCR(17);
-    SHA512_SCR(18);
-    SHA512_SCR(19);
-    SHA512_SCR(20);
-    SHA512_SCR(21);
-    SHA512_SCR(22);
-    SHA512_SCR(23);
-    SHA512_SCR(24);
-    SHA512_SCR(25);
-    SHA512_SCR(26);
-    SHA512_SCR(27);
-    SHA512_SCR(28);
-    SHA512_SCR(29);
-    SHA512_SCR(30);
-    SHA512_SCR(31);
-    SHA512_SCR(32);
-    SHA512_SCR(33);
-    SHA512_SCR(34);
-    SHA512_SCR(35);
-    SHA512_SCR(36);
-    SHA512_SCR(37);
-    SHA512_SCR(38);
-    SHA512_SCR(39);
-    SHA512_SCR(40);
-    SHA512_SCR(41);
-    SHA512_SCR(42);
-    SHA512_SCR(43);
-    SHA512_SCR(44);
-    SHA512_SCR(45);
-    SHA512_SCR(46);
-    SHA512_SCR(47);
-    SHA512_SCR(48);
-    SHA512_SCR(49);
-    SHA512_SCR(50);
-    SHA512_SCR(51);
-    SHA512_SCR(52);
-    SHA512_SCR(53);
-    SHA512_SCR(54);
-    SHA512_SCR(55);
-    SHA512_SCR(56);
-    SHA512_SCR(57);
-    SHA512_SCR(58);
-    SHA512_SCR(59);
-    SHA512_SCR(60);
-    SHA512_SCR(61);
-    SHA512_SCR(62);
-    SHA512_SCR(63);
-    SHA512_SCR(64);
-    SHA512_SCR(65);
-    SHA512_SCR(66);
-    SHA512_SCR(67);
-    SHA512_SCR(68);
-    SHA512_SCR(69);
-    SHA512_SCR(70);
-    SHA512_SCR(71);
-    SHA512_SCR(72);
-    SHA512_SCR(73);
-    SHA512_SCR(74);
-    SHA512_SCR(75);
-    SHA512_SCR(76);
-    SHA512_SCR(77);
-    SHA512_SCR(78);
-    SHA512_SCR(79);
-
-    wv[0] = ctx->h[0];
-    wv[1] = ctx->h[1];
-    wv[2] = ctx->h[2];
-    wv[3] = ctx->h[3];
-    wv[4] = ctx->h[4];
-    wv[5] = ctx->h[5];
-    wv[6] = ctx->h[6];
-    wv[7] = ctx->h[7];
-
-    j = 0;
-
-    do {
-      SHA512_EXP(0, 1, 2, 3, 4, 5, 6, 7, j);
-      j++;
-      SHA512_EXP(7, 0, 1, 2, 3, 4, 5, 6, j);
-      j++;
-      SHA512_EXP(6, 7, 0, 1, 2, 3, 4, 5, j);
-      j++;
-      SHA512_EXP(5, 6, 7, 0, 1, 2, 3, 4, j);
-      j++;
-      SHA512_EXP(4, 5, 6, 7, 0, 1, 2, 3, j);
-      j++;
-      SHA512_EXP(3, 4, 5, 6, 7, 0, 1, 2, j);
-      j++;
-      SHA512_EXP(2, 3, 4, 5, 6, 7, 0, 1, j);
-      j++;
-      SHA512_EXP(1, 2, 3, 4, 5, 6, 7, 0, j);
-      j++;
-    } while (j < 80);
-
-    ctx->h[0] += wv[0];
-    ctx->h[1] += wv[1];
-    ctx->h[2] += wv[2];
-    ctx->h[3] += wv[3];
-    ctx->h[4] += wv[4];
-    ctx->h[5] += wv[5];
-    ctx->h[6] += wv[6];
-    ctx->h[7] += wv[7];
-#else
-    for (j = 0; j < 16; j++) {
-      PACK64(&sub_block[j << 3], &w[j]);
-    }
-
-    for (j = 16; j < 80; j++) {
-      SHA512_SCR(j);
-    }
-
-    for (j = 0; j < 8; j++) {
-      wv[j] = ctx->h[j];
-    }
-
-    for (j = 0; j < 80; j++) {
-      t1 = wv[7] + SHA512_F2(wv[4]) + CH(wv[4], wv[5], wv[6]) + sha512_k[j] +
-           w[j];
-      t2 = SHA512_F1(wv[0]) + MAJ(wv[0], wv[1], wv[2]);
-      wv[7] = wv[6];
-      wv[6] = wv[5];
-      wv[5] = wv[4];
-      wv[4] = wv[3] + t1;
-      wv[3] = wv[2];
-      wv[2] = wv[1];
-      wv[1] = wv[0];
-      wv[0] = t1 + t2;
-    }
-
-    for (j = 0; j < 8; j++)
-      ctx->h[j] += wv[j];
-#endif /* UNROLL_LOOPS_SHA512 */
-  }
-}
-
-void avb_sha512_update(AvbSHA512Ctx* ctx, const uint8_t* data, size_t len) {
-  size_t block_nb;
-  size_t new_len, rem_len, tmp_len;
-  const uint8_t* shifted_data;
-
-  tmp_len = AVB_SHA512_BLOCK_SIZE - ctx->len;
-  rem_len = len < tmp_len ? len : tmp_len;
-
-  avb_memcpy(&ctx->block[ctx->len], data, rem_len);
-
-  if (ctx->len + len < AVB_SHA512_BLOCK_SIZE) {
-    ctx->len += len;
-    return;
-  }
-
-  new_len = len - rem_len;
-  block_nb = new_len / AVB_SHA512_BLOCK_SIZE;
-
-  shifted_data = data + rem_len;
-
-  SHA512_transform(ctx, ctx->block, 1);
-  SHA512_transform(ctx, shifted_data, block_nb);
-
-  rem_len = new_len % AVB_SHA512_BLOCK_SIZE;
-
-  avb_memcpy(ctx->block, &shifted_data[block_nb << 7], rem_len);
-
-  ctx->len = rem_len;
-  ctx->tot_len += (block_nb + 1) << 7;
-}
-
-uint8_t* avb_sha512_final(AvbSHA512Ctx* ctx) {
-  size_t block_nb;
-  size_t pm_len;
-  uint64_t len_b;
-
-#ifndef UNROLL_LOOPS_SHA512
-  size_t i;
-#endif
-
-  block_nb =
-      1 + ((AVB_SHA512_BLOCK_SIZE - 17) < (ctx->len % AVB_SHA512_BLOCK_SIZE));
-
-  len_b = (ctx->tot_len + ctx->len) << 3;
-  pm_len = block_nb << 7;
-
-  avb_memset(ctx->block + ctx->len, 0, pm_len - ctx->len);
-  ctx->block[ctx->len] = 0x80;
-  UNPACK64(len_b, ctx->block + pm_len - 8);
-
-  SHA512_transform(ctx, ctx->block, block_nb);
-
-#ifdef UNROLL_LOOPS_SHA512
-  UNPACK64(ctx->h[0], &ctx->buf[0]);
-  UNPACK64(ctx->h[1], &ctx->buf[8]);
-  UNPACK64(ctx->h[2], &ctx->buf[16]);
-  UNPACK64(ctx->h[3], &ctx->buf[24]);
-  UNPACK64(ctx->h[4], &ctx->buf[32]);
-  UNPACK64(ctx->h[5], &ctx->buf[40]);
-  UNPACK64(ctx->h[6], &ctx->buf[48]);
-  UNPACK64(ctx->h[7], &ctx->buf[56]);
-#else
-  for (i = 0; i < 8; i++)
-    UNPACK64(ctx->h[i], &ctx->buf[i << 3]);
-#endif /* UNROLL_LOOPS_SHA512 */
-
-  return ctx->buf;
-}
diff --git a/lib/libavb/crypto/avb_crypto_ops_impl.h b/lib/libavb/crypto/avb_crypto_ops_impl.h
new file mode 100644
index 00000000000..ab7418ad083
--- /dev/null
+++ b/lib/libavb/crypto/avb_crypto_ops_impl.h
@@ -0,0 +1,43 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * U-Boot crypto back end for libavb: the SHA contexts come from U-Boot's own
+ * SHA-256/SHA-512 library (lib/sha256.c, lib/sha512.c, or mbedTLS when
+ * CONFIG_MBEDTLS_LIB_CRYPTO is set), which may also use hardware
+ * acceleration. ML-DSA is not supported, see crypto/mldsa_impl.c.
+ */
+
+#ifdef AVB_INSIDE_LIBAVB_H
+#error "You can't include avb_crypto_ops_impl.h in the public header libavb.h."
+#endif
+
+#ifndef AVB_COMPILATION
+#error "Never include this file, it may only be used from internal avb code."
+#endif
+
+#ifndef AVB_CRYPTO_OPS_IMPL_H_
+#define AVB_CRYPTO_OPS_IMPL_H_
+
+#include <u-boot/sha256.h>
+#include <u-boot/sha512.h>
+
+/* Block size in bytes of a SHA-256 digest. */
+#define AVB_SHA256_BLOCK_SIZE 64
+
+/* Block size in bytes of a SHA-512 digest. */
+#define AVB_SHA512_BLOCK_SIZE 128
+
+/* SHA-256 context: U-Boot's. */
+typedef sha256_context AvbSHA256ImplCtx;
+
+/* SHA-512 context: U-Boot's. */
+typedef sha512_context AvbSHA512ImplCtx;
+
+/* Dummy structs for the stub ML-DSA implementation */
+typedef struct {
+  int dummy;
+} AvbMLDSA65PrehashImplCtx;
+typedef struct {
+  int dummy;
+} AvbMLDSA87PrehashImplCtx;
+
+#endif /* AVB_CRYPTO_OPS_IMPL_H_ */
diff --git a/lib/libavb/crypto/sha_impl.c b/lib/libavb/crypto/sha_impl.c
new file mode 100644
index 00000000000..6fca8deaa9b
--- /dev/null
+++ b/lib/libavb/crypto/sha_impl.c
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * libavb SHA-256/SHA-512 on top of U-Boot's SHA library, so that libavb
+ * shares one implementation with the rest of U-Boot (including hardware
+ * acceleration and the mbedTLS back end) instead of carrying its own.
+ */
+
+#include "../avb_sha.h"
+#include "avb_crypto_ops_impl.h"
+
+/* U-Boot's update functions take a 32-bit length */
+#define SHA_CHUNK 0x40000000
+
+void avb_sha256_init(AvbSHA256Ctx* avb_ctx) {
+  sha256_starts(&avb_ctx->impl);
+}
+
+void avb_sha256_update(AvbSHA256Ctx* avb_ctx, const uint8_t* data, size_t len) {
+  while (len) {
+    size_t n = len > SHA_CHUNK ? SHA_CHUNK : len;
+
+    sha256_update(&avb_ctx->impl, data, n);
+    data += n;
+    len -= n;
+  }
+}
+
+uint8_t* avb_sha256_final(AvbSHA256Ctx* avb_ctx) {
+  sha256_finish(&avb_ctx->impl, avb_ctx->buf);
+  return avb_ctx->buf;
+}
+
+void avb_sha512_init(AvbSHA512Ctx* avb_ctx) {
+  sha512_starts(&avb_ctx->impl);
+}
+
+void avb_sha512_update(AvbSHA512Ctx* avb_ctx, const uint8_t* data, size_t len) {
+  while (len) {
+    size_t n = len > SHA_CHUNK ? SHA_CHUNK : len;
+
+    sha512_update(&avb_ctx->impl, data, n);
+    data += n;
+    len -= n;
+  }
+}
+
+uint8_t* avb_sha512_final(AvbSHA512Ctx* avb_ctx) {
+  sha512_finish(&avb_ctx->impl, avb_ctx->buf);
+  return avb_ctx->buf;
+}

-- 
2.53.0

