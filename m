Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C37606A31A
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 19:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=PgRPy18N;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=oaTLe0cP;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=AuWskr4b
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D9F7D60A5A;
	Fri, 23 Oct 2026 19:52:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rhISlastXNlN; Fri, 23 Oct 2026 19:52:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 23BF060A4B
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792785179;
	b=jAikgj87J5blvtxxB83jnmNtLqBQHXRg+HRAZFx35iIgd2MP/3zE3OPlNGO21iiU3jsl
	 IrFRcUcpR7l0aghit7bYfIHuW+67k99T5RUV62SZPkbBS7M3xW+8dFh5tx5ZrGhcPiG6x
	 ITuF/SntpK+LHeGtnITj1o01Js80c6y3ANOs8lynB4lKIDE92WrqSy9NWc2Ap9WFFl56M
	 a0l+xSrkI1hCmM5JIwH4ngKg+oSHDLuU6sfuWnQZM83IoMZu7spow40VF1nhjZ7FPI1WU
	 dm5l7kw7rIm3Rky7PHotj8voTtJ9dd9EEuqpdgfJx6F3AWO8ORW4wYOQ6Z3LySe+kjQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792785179;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=YGBzpU3dnyNp0Q8NYFYz0nwL/Js+DBFOz94KBJjpmOs=;
	b=S3S8ka1wIPhZszrm3lnrr4SnTzIacTEHsUwvvAhkJCoTrY0UodKp8PcvxZcVyvZpkhVR
	 OA3k7fOy3j+Imv69Pi2DDhkgfctwthnnqm4APWnKPuRnYm7UrzteldZMd/ERRjcYkul2/
	 qSfYb80HgszZGItSIMNhLc3KQC/JEfLbv36k0baR21rP/9XPkOFNePSgQ05uR7Nm08q7W
	 3V3ReG/+GCurU9cmB70bO+NUEM+ml1GQN3ougEAdE9KsBTFryF8SLofs1EOkm38AvXDo2
	 yMMTK7cT3foAmQz9OkyQpo8nEgOsEDWPEum4Xy34FORgZZsSTjXod7HonMwFT3slEDQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792785179;
	bh=YGBzpU3dnyNp0Q8NYFYz0nwL/Js+DBFOz94KBJjpmOs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PgRPy18N6USd258/jxB8ocD7huAuVkQJBwI/9KalNW81HxdswdkM1Effb3rVLntSX
	 8mYLqZ4GTjpxWnEpLxBVltzZRTHWh2+lxRLQ1fOyIgkv2Vdl36BmEgAew0qFCY97GD
	 WA6yGrILj6H6v2onfTtAP733eBklJH6HLdGHVl1lZTmwgkD8F4YfHWfMzCfVKgMOq8
	 6EIu+rJc0xcbXra1k1zbrxnXwQTZIfzxE1UaXQwSe/2NaloFrV/t+tD8Nu5uGbwtHR
	 ybw7R610KSXOWMJcu0eff/qVbzuz1nVczJ5TbZ6BLD6oTqhbW0v44g14lwOb/O1Yc0
	 Xbkz/E7tth6eA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 23BF060A4B;
	Fri, 23 Oct 2026 19:52:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 78AC5380
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 19:52:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5E61440474
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 19:52:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tNn6Agpk-tvr for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 19:52:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org C4AA140061
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792785177;
 b=kTzTx3QG3z+ZcQMbSWNm8P9GeLRvRwl2Mp5vVHSBBsr70+nxWbR0mJ7+SC3AhEe0JxIq
 TDuaKTnSN/BfGag3SFBp6rqVikFQ3iMiYk+38vEwTQb7lmuGBDIVp11VVBtKZjebR0tDs
 thLmxEM2QsRN7DrBnco8mjSkT+3I2dZcI/zwGjuXYlBQE//tR7mebJR8vdfTzry58CqM3
 TkHmkiRDxvNuPheaNV+g1d/yHR2A7ymuFqZxAjKVvhfHrra4CqzNNWenfqwdfVdfX3ETv
 r/pNuyBrh3kcD6GMKy+kccA05/o73jGZZJ1GHik+yDUhVCc9jGhy6XenasBXKUEo+fw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792785177;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Authority-Analysis:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=YGBzpU3dnyNp0Q8NYFYz0nwL/Js+DBFOz94KBJjpmOs=;
 b=ZvfySksh8737uegCyVM0D5bN3PHjplnO+oMEnSTZjQGMITrppDLOBl8fpZhhyirq0Ftd
 kcWSk1xY1G0VyW9cpXeDVHY7Iv9KErT7v4a3BdxMi7WMD1QDX8n1idwg4gkqUmwApBBiy
 DjVBCSZWlQp9E6459/sbKqZFDCOGmaMxcqpA9zmnUUIvjBYzwmyA20w9gdv6GdgaekzEL
 bu/d4bny7XpArkgwgzcr0rsjLd4vp10g1xMbC2WouRn/XdCQOVoRqkFOH7wUr5SMIkErO
 lhftxY5PXax9U2y9T+rDtNtM2gVMgnII9DKG/wTUHudSK2ZFSbipWYPaR/o0gU1d7nQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=oaTLe0cP; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=AuWskr4b; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=tyler.baker@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=oaTLe0cP; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=AuWskr4b
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C4AA140061
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 19:52:57 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NIZUVv453786
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 19:52:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=YGBzpU3dnyN
 p0Q8NYFYz0nwL/Js+DBFOz94KBJjpmOs=; b=oaTLe0cPwnT1Zh5pg2OIGJ3HuMf
 VkmmOMOlJd8uLKclmnhe2fbgQZ+n28TGuKeRmR7r1p99nDzPk94knbVvCXpRI8qH
 9RykMCfiO9f3VxhQU70TkTkQ8rBctYePCPXw5Cn6o6hi5wEdvl8Gikc5HzyUUkUf
 f+kidBNJp+GL3e+iMf5wsri7TUFH3zRp0/Rb0AgHd2tabHdL/8iJnaTNtaxQk3IP
 PHMJJV22mQQodJxCGyT9215GAAkqNR0NCT9QpUDIgMg8sQGyYC/ybEY3qMhYjBV3
 IFMCQmv6eVw9BQykV/awDRykgYXspRPxZ9TFm/IWjpK0LD6CYW5U9iUqGBw==
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgcr689n9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 19:52:56 +0000 (GMT)
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-836caf085e0so18574407b3.1
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 12:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792785176; x=1793389976;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YGBzpU3dnyNp0Q8NYFYz0nwL/Js+DBFOz94KBJjpmOs=;
 b=AuWskr4bTvFXYcQxJA8SWQB3gdeNMNd3h5wHe8y0gsA5SX7efw4yjww5iTWP27haJh
 jj6jYNUgr8gE5ELEvBIwFdcnS2IjUVfTkUWzJWD1Zaa9xLwjl5sgimNiuX2OdmM7DtE5
 pFEUZbGAtH4CW33E+u5LNlSJQXQl2yO0itkXhfFBIA3yU3IWlIGHSggiUcCPR2TcFCRC
 gHeYsUa4YJdqgrMiXJKINXLTxUMQwKZHviwLgkrhKXf1Y3glD7g4j7emGYwGQJvXBxCk
 m9qe9/5TW0UcZ3uw2JOs71QypWmsICKX0F16iccpKuv6zppnGBXkpZHuf+n7BCV2NGIk
 i/1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792785176; x=1793389976;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=YGBzpU3dnyNp0Q8NYFYz0nwL/Js+DBFOz94KBJjpmOs=;
 b=CBLP8kDKs8lXPeVPF0BEUxjOjBB/ruPwDeoppiRBy3ZWI192A7DwxtGbzuU05FcaCs
 oLz2aZma6hpZFWIzzb49pT8GDbqpzIp1qNbaZcZzNFPiwicvTjcPKf3JXkGD4p9TWVkz
 Vqkr2etzvaFCfdoKUdYDI/69Gt57yYZzwaoSvxUoApSthHB8Nh0MCZAOSxP7Kwv/HRpJ
 lcGD0MwEvIL9CWZQJZxrC2mzFWmDeQMiLlVRekg2UDPBGwi2K1f7JzofbVkhuSdnUtGa
 eMWCANUmErHJ+agK7ecCrkPG0Wcab5wf47+MeWzjMKM+nOwHhQCUGpOzowcb8c/kdayM
 F9Jg==
X-Forwarded-Encrypted: i=1;
 AKwUvByat8nC6ZuVvEVYUmNSlqAISwJfMS7wqUqsFrRGGhG0h/DsA60QACOuA0Whak9gH0YJ4IgTqM4=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKGxm5nVpxJ4ZBfebYwDMnQWLb3d74UyikGpzzqVfbhjTIJv7vm
 zhhwP6s5AHWlU4N3tRypx7k23ijH3TMl14m9EQXRR8hhM0+kYLMb/5WMGeVuNHn5YN1dIrlHQog
 cNqL+Jq7PmHJvpmtMPHCN2zMpV7JfY72nxlpTES7v8HIiZAUXBuu7SXClFlnewsc4Ch/pCN3rZB
 ErIEQ=
X-Gm-Gg: AYBFou1A+Oa2LfZNEe0bSEPDMUVne4r0w3vIKB9XqXfkw4Te6GaDTMNWxEqSJLac7iw
 k4k3ee+m1DwfgZZBgpuSB7NBCSDYpp8/Dc+Gomqzknilaz2ytchDUIVqJkE+z8f1ZiewexESbNJ
 GZK3CH+4X4CjKJwU164o4vHl7PNneX3rIKOHRHJRMSjI7JseUar9s5HcRLKJ5BsRX87Mp2KsHPz
 Kql9Usnw8KPaf9pNBt1iDwg1rZJPXviYD/gY0A+IR7+NXSBl8Y5zSsc8otOl1EvuZ0joZPSXNzu
 BM/W7y/cUQn2Ynw6VEdcMuwWez7tCJaMYEB7i1WD4pPgtEjhzQoyzTl/Ha+GqYGlSUgIM+z8qmz
 54m4tnG2424zG1+0/vmfYLRbQg0MFyLHfe8DfUjjDpcYUrRDwPnxNh20dfe1u
X-Received: by 2002:a05:690c:c101:b0:8b0:ab62:c636 with SMTP id
 00721157ae682-8b166c43344mr1388137b3.45.1792785175035; 
 Fri, 23 Oct 2026 12:52:55 -0700 (PDT)
X-Received: by 2002:a05:690c:c101:b0:8b0:ab62:c636 with SMTP id
 00721157ae682-8b166c43344mr1387917b3.45.1792785174495; 
 Fri, 23 Oct 2026 12:52:54 -0700 (PDT)
Received: from x2e.lan (108-208-224-205.lightspeed.gnbonc.sbcglobal.net.
 [108.208.224.205]) by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-67a462bd9e3sm7822d50.19.2026.10.23.12.52.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 12:52:54 -0700 (PDT)
From: Tyler Baker <tyler.baker@oss.qualcomm.com>
To: Tom Rini <trini@konsulko.com>
Cc: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH] dts: monaco-evk-u-boot: add reboot-mode support via
 PON/SDAM
Date: Fri, 23 Oct 2026 15:52:52 -0400
Message-ID: <20261023195252.1688068-1-tyler.baker@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261023183645.GI3596691@bill-the-cat>
References: <20261021-monaco-reboot-mode-v1-1-41cd3c8f15d5@oss.qualcomm.com>
 <20261023174443.1552137-1-tyler.baker@oss.qualcomm.com>
 <20261023183645.GI3596691@bill-the-cat>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=HMRWhYtv c=1 sm=1 tr=0 ts=6adbbb18 cx=c_pps
 a=g1v0Z557R90hA0UpD/5Yag==:117 a=PFxtTy0squD/fJwW5Be2sw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=zaRyfxnaU6Ze9O4L15cA:9
 a=MFSWADHSvvjO3QEy5MdX:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA3OCBTYWx0ZWRfX4wM4vO4UPUTg
 JXufYi/V6Alvz9Bk/u2d1/z0OZUk/pdCbOsbJPkYlN9l/1IcxII1tDuLjTKxg6G7SNN2sFW6GaZ
 a1dO0WJNsz4yLO2yl5MaxIOQ/8aReGNkLz+GmvPB4o7Y64LNDpMgDmbc3FQIGY+C5/ugp3UUTM7
 CaZ2100xFg9vBkXCg1gNVg40N0+krvHqpM4CTvs7Mc6mDEvf2/RgGXQfq/UFBDkrS2bUDN9JNY2
 gmeRpK4DhDxyt789SN2nT4uHJx7D6rrC0lpvq7xMRUEdSCwaCuKIlnrk5G8UHyTWGVtFy6yFX0G
 fzJS2cvfSvdV4uj+sqeu464o2etnu5ONsn/PdHz0NUq/a0RMRWwYSVKCE4NxoBIIS5tJF2tuqge
 2KZJBP7Zf/xYlvyNtIR3VMuGUHhhKQJBA9d0ZpTEz6XYnQoBupf8+UM45UT4RfguwYkKBCsuELn
 2r5RbUdPfkNEq+GAG+A==
X-Proofpoint-ORIG-GUID: HBybRpM8y6t6zHGJQXQ2Ixrg1nxsrYVL
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA3OCBTYWx0ZWRfX9JK7UR5nKYyr
 yI0htZ2XCRd0axcSjzJXqpwi7Xh+k9pGAaG5rBtYXxxkfQku7ykYNOXii2HhCcRaDOlCnro7Vun
 vKG3NvKyMswZ0Im7Wkdx/F6v8NngDLA=
X-Proofpoint-GUID: HBybRpM8y6t6zHGJQXQ2Ixrg1nxsrYVL
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
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 23 Oct 2026 at 14:36, Tom Rini wrote:
> Especially with the current backlog, can we just move qcom to being one
> of the platforms where new stuff comes in first via OF_UPSTREAM and
> either re-sync or cherry-pick?

+1 from me
