Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDF6606EEBC
	for <u-boot@archiver.kernel.org>; Thu,  5 Nov 2026 10:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=sSniDlNG;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=aqVlwipP;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TDwfJWAI
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 058B840486;
	Thu,  5 Nov 2026 10:06:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 744cbDHwJKDH; Thu,  5 Nov 2026 10:06:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0164640566
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793873170;
	b=e5KG8rVr3WScMApPMERAUNhmyCw1xfWqWt+2nKBhINojwN20idhNd6p7RF1vrAz+4Y/f
	 VBZqZ4l0CC8iZt06Mk1wdhH1zQ8Fp5rGfBViZWwun/2x1rAFap/CVdUxpzzia6mdyZkf/
	 xb1RBHKnKX1KmrP5/Xh7kSeWp4P7sKJ6JQmD+1YF9slzDCTxuSEHXo9lWDjZtgGhzi78M
	 nbfJXbbgEXJnl6tGIrkj/QngiW12Gb8lTwjU9s9VfajdzARGp5IWWS8CGLmNMs30y5Gr1
	 logmTDIu+zrJyOMuLACfyC/y4V6Ak1++tfxAIplEjidobU3gmi+XB0vSfeQGxV0ARbw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793873170;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=v+NfEPDGdPWYEMahTDk3wRXVk9sYtGf+X3jJBPwN51E=;
	b=f2jRvBMYks7FKfY32r+hkqesHV2lOXbOpGVvVZqxZT+JOkrog6vFbaX1Pn2uPwrSWh2N
	 vEk0nvSSWJ7vp4CuFg6Bwkv6SZs6wIEHYUszqju/6wL2DgBuZmNdThNv/o1wSsE3HSSH5
	 8zl5huF8QbP/QLso7QoG5o+iEOWlJ8YSm9rC+Y7OvPMdLmsOKag7K534I00L6MJaLewzC
	 n0VnPtD8vDDjTu6YecITlGRUMD6MHV5OMVlrqfqS+ARw1dJPrqkyt0ZFoG25MUxZlAhkr
	 JWI4+bYmmMoasagiPe92V3YKCk/MducglsrRSuSe6SrG8JZMcbVE86GSj0wLgkg6hRg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793873170;
	bh=v+NfEPDGdPWYEMahTDk3wRXVk9sYtGf+X3jJBPwN51E=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sSniDlNGmzfZe/yjOt4qsz4ARgVTv9JwIP4id9UDAB6/wtqLrhHDhIU4fH5mmRRpf
	 7v3A3TuKkLnNxPKDEUKBbpKKfFvoePDVF3Z+ztTuQzp4rQkHLfpikHY86/ZtF/B6sN
	 5nLS8Q4dLCinSF58ZkXbcgR/THjK4A+DQPMlbdcjY5PfEUsOLVYvYnDbDFRMWgTSMF
	 paoQxxsbF9rcba47j+BrksdWounKvtlPBSkp6+WVznaRcYpPuU7s8AatruSYKuT7v+
	 NxF7k/dldNnJuBS6nnAKBpRYRzHX8+T6waBCRlfcfw4r+tNzzlKyX6byZsKsB7qrlJ
	 Q09ln+mTPF58Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0164640566;
	Thu,  5 Nov 2026 10:06:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id ACDDC2AC
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 10:06:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 92517400F9
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 10:06:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AoebWlIDWatx for <u-boot@lists.u-boot-project.org>;
 Thu,  5 Nov 2026 10:06:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org A194E4008E
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=badhrinath.s@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=aqVlwipP; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=TDwfJWAI
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A194E4008E
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 10:06:07 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A59tPR4433302
 for <u-boot@lists.u-boot-project.org>; Thu, 5 Nov 2026 10:06:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=v+NfEPDGdPW
 YEMahTDk3wRXVk9sYtGf+X3jJBPwN51E=; b=aqVlwipPIMwdC7BsVw10bbvKfHB
 5inHua5RjmlHvLoWc+VGeD0Fo3x0sjtyhrTKwnvBR9fDTjYqK7c6BKUT2FtLn46l
 pIwjzxdhHD+E02wbNpFKdMpSvpMU1Fu1+YCQeBbZ9g2f5GgqBtsgKcyxjn3DG+T7
 iNrtvFYJX9aSey6nn4Kk07Ag0AhMmrhrHufFOyOYGDdpoXBz9JjFB3Ewo2piQxa9
 AMAoaWJO6FDciaTp3aPEBb6TgcZXJW/LOHklZqgh/0Yg8oywAhxns6U7YNL/rEpH
 hQiQ/CzWiwwW1iEW4uASorEtBggdat1KC4mG4zHEUEUmJsYzfgQM6G+whQw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrmcd8wgg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 05 Nov 2026 10:06:05 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93f322ef7d3so384208685a.0
 for <u-boot@lists.u-boot-project.org>; Thu, 05 Nov 2026 02:06:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793873165; x=1794477965;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=v+NfEPDGdPWYEMahTDk3wRXVk9sYtGf+X3jJBPwN51E=;
 b=TDwfJWAIzGvyMIRfNHR6ATcC9tdLNjwhnkaIMS8O+ukVkIgtcArGOlMo7ER+a1isV7
 TIpmV9GvaZgFMgAix2fVVJJqypBvQz8kGsQ8hC+QH3Y+g52BTy4a7NOoJTJNXbaJ86fK
 wasp1X59jmNcheOgT5XuvQc4gSrzRjEJVDHM3teKLUG4Lgj/JW06U0kL8A/lXM62t5qe
 2h1UVRewFjUGxlCVMaKgdwYrxaDQHyS1RPiZxwMX7JE5hDLQnXOPd+WM635TNXQAhDrT
 AbuGkosT4YhG43xLpbrK75920j7FykSX84MtifWgGxZFmGKTtL1RA3+IU0gm2xCOyAzP
 pxMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793873165; x=1794477965;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=v+NfEPDGdPWYEMahTDk3wRXVk9sYtGf+X3jJBPwN51E=;
 b=Mq5tlNWNi29o+2c9iDXCZV9ncmhY7InPw23q+VHtBJCgjh28R9CKULF3x3gjKTN1IS
 vbrZhD3fsJ5w+YeVd/1ptJr7RHVuiJmHuc7vu8fzlJZm6yPdP4QDnL5sD9fKKz3wd96+
 CHTHy+rIob+ncZ9vb5ZQQS2Zuri3bmR+G+xn1+wKSQXqffq+Dp0qpK+sHI9Vmv7HT2sg
 8UyZfDxIAIyYwaymh0+IHc/rVZCxfpK1qac5fHtg+T1q3FCynjlA7i4KE4AhwyifRiBe
 jSpeawt0uGdgI13/f282qGGHa62euzfXEt/5i/h5T+3WLsxH5D9tHQcLsPSdg8Vrfq7m
 eLXw==
X-Forwarded-Encrypted: i=1;
 AKwUvByoIthJlIXTkjgKK8W9xvfA/PZnsh8uxh4LtYUp++6dELTTxGkZq9NEKDtYzT+PC81HoHkNN3o=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9Pf1fmuB7a9YFgoelibtBSMNxAy7Id4gIckos0XV/8V0aDdHRi
 OXmoSJXMJqnYpZI6ZxvCx+lX4oSPbFqjQ5eqdmTw6QUipbERnzx4DHkLe9m0vr03eteiEhB8hp3
 tbiuzCD62B9C1tE5i8fWlIM4DL3awbczNFkIvkOrb/IoTMwT63mXqpldR30C8ZFbYTZKQVz0=
X-Gm-Gg: AYBFou1v1LiJfnWmhzqW2b7wcLVCDFxidyH01VD5d51+MclhNAbdEK44VLLjnaab9UN
 xnV45H2B5axbn2WGLkTRLN/zyvBtl/sAJvIO4KnnR/gxbHspEslrN6o31k/EXHhjdm8omc1M8VB
 N+usuLPwMSZjpDzfhxKJcY3GDAAXVE8RiHzGddy/CXn/+GiQxMWnGMxeX9vJWtcBmn6G/F7udGd
 OIfYK7APf8Y0CJzWgRht4IPEWuiBHKbJ38yhbXpH5bfrp/sL48y8xBIdEOhxRMeIuo5vdDKHvKI
 AlcaxwZdbLqbZDecp9Qi8HAEGtXoNrCvzby3Uz+mnJBCHLWAJIEBMvSxWlSx5wahKpIBGbIrkA5
 7c2dmvOdFE06SmWRUDeAr5Eap+dndllVeEBDvJJmWhYbwEcHueL9MBNwUqRgJhwyzPaZO/IQAWZ
 Jic0eW7fy1SXaiB3Xm7v/r1T3Z/3nvYgpzzc+0gnwXBFjtGmWUYXpnbMBMPuafPcpFE+nSug==
X-Received: by 2002:a05:620a:6402:b0:93b:d7a2:83d1 with SMTP id
 af79cd13be357-944217e5808mr3352994185a.64.1793873165076; 
 Thu, 05 Nov 2026 02:06:05 -0800 (PST)
X-Received: by 2002:a05:7022:ea8a:b0:188:e51:e86a with SMTP id
 a92af1059eb24-1ac56c9fe97mr24392636c88.2.1793872717176; 
 Thu, 05 Nov 2026 01:58:37 -0800 (PST)
Received: from hu-badhrina-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b245ac2f44sm15844487c88.0.2026.11.05.01.58.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 01:58:36 -0800 (PST)
From: Badhrinath S <badhrinath.s@oss.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com, peng.fan@nxp.com,
 jh80.chung@samsung.com, tanmay.kathpalia@altera.com,
 lukma@nabladev.com, Michael.Srba@seznam.cz,
 badhrinath.s@oss.qualcomm.com, balaji.selvanathan@oss.qualcomm.com,
 nathbappai@gmail.com, nikroks@mainlining.org, jbx6244@gmail.com,
 xerikasxx@gmail.com, u-boot-qcom@groups.io, u-boot@lists.u-boot-project.org
Subject: [PATCH v8 1/3] clk: qcom: Add initial Clock driver for ipq9650
Date: Thu,  5 Nov 2026 15:28:19 +0530
Message-Id: <20261105095821.3009544-2-badhrinath.s@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261105095821.3009544-1-badhrinath.s@oss.qualcomm.com>
References: <20261105095821.3009544-1-badhrinath.s@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=EOGTQFZC c=1 sm=1 tr=0 ts=6aec550d cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=bXGWVFErNL2ettMSjigA:9 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: U_5Hs541MAraVnC5a3Kr9VDbGglKz8c-
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA0MCBTYWx0ZWRfXyCVIqAp7bCuy
 za9cy/5vlYPISncGU5eNlj0PBKBvBeKfg9d5XnraNf6Vanib/OJ5xT595d0A43mh/EeddMuMYsQ
 OVs+5kEloLADmKC5YbqsySiWeDQcR7I=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA0MCBTYWx0ZWRfX/yho5zGcKXwN
 cHn3eb77mFUF7bgJkGo8mBk4DOZfQ1UnQNaKuBA3k5RGmRdrnTIzYh1QVnLBvyQbwXcwtKWKnDI
 I9xXnAM3Sz5GRqmRUYqOogv3c1G8dQmzSbPWVs31N24ItzkpSR4wvFgwQrvq6M73gjQi6y++Vbf
 EfpuSINXMMaZpd+4CdrjMDl2/xlWjiXsFQ4iVUBRB+E3XTO441d1u0Rx0ocUKcWpl+utaYA5yTx
 VFBHbd8dUzkL/YBPxxUDYO4MXJBPSExQs8UyJg5y8j+38XZo+GT+jleiXaKIhqU4/7pur5968Pz
 /EtP/5abZGG+3ISIuy4DEnMFjRyNht+6QKcm2CnDgGQmQHqH3QcUj4Xu2+4RRuXbiMkvh4BBMwk
 +yotgWy1TWy1Bor96knFn1mnl2EJARRdLGjE4IHkDPubULsf77ZuC2sAAP/wBn0YwhCQUkOP4Jd
 P80ljbPLeO4Sy8xlOBw==
X-Proofpoint-ORIG-GUID: U_5Hs541MAraVnC5a3Kr9VDbGglKz8c-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 suspectscore=0 bulkscore=0 phishscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611050040
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

Add initial set of clocks and resets for enabling U-Boot on ipq9650
based RDP platforms.

Signed-off-by: Badhrinath S <badhrinath.s@oss.qualcomm.com>
---
 drivers/clk/qcom/Kconfig         |   8 ++
 drivers/clk/qcom/Makefile        |   1 +
 drivers/clk/qcom/clock-ipq9650.c | 164 +++++++++++++++++++++++++++++++
 3 files changed, 173 insertions(+)
 create mode 100644 drivers/clk/qcom/clock-ipq9650.c

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index 0d8f5028a4e0..1198e57f81c5 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -47,6 +47,14 @@ config CLK_QCOM_IPQ9574
 	  on the Snapdragon IPQ9574 SoC. This driver supports the clocks
 	  and resets exposed by the GCC hardware block.
 
+config CLK_QCOM_IPQ9650
+	bool "Qualcomm IPQ9650 GCC"
+	select CLK_QCOM
+	help
+	  Say Y here to enable support for the Global Clock Controller
+	  on the Qualcomm IPQ9650 SoC. This driver supports the clocks
+	  and resets exposed by the GCC hardware block.
+
 config CLK_QCOM_MILOS
 	bool "Qualcomm Milos GCC"
 	select CLK_QCOM
diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
index 73cafc3f938d..30929a76abf6 100644
--- a/drivers/clk/qcom/Makefile
+++ b/drivers/clk/qcom/Makefile
@@ -9,6 +9,7 @@ obj-$(CONFIG_CLK_QCOM_APQ8096) += clock-apq8096.o
 obj-$(CONFIG_CLK_QCOM_IPQ4019) += clock-ipq4019.o
 obj-$(CONFIG_CLK_QCOM_IPQ5424) += clock-ipq5424.o
 obj-$(CONFIG_CLK_QCOM_IPQ9574) += clock-ipq9574.o
+obj-$(CONFIG_CLK_QCOM_IPQ9650) += clock-ipq9650.o
 obj-$(CONFIG_CLK_QCOM_MILOS) += clock-milos.o
 obj-$(CONFIG_CLK_QCOM_QCM2290) += clock-qcm2290.o
 obj-$(CONFIG_CLK_QCOM_QCS404) += clock-qcs404.o
diff --git a/drivers/clk/qcom/clock-ipq9650.c b/drivers/clk/qcom/clock-ipq9650.c
new file mode 100644
index 000000000000..0aca67982f7b
--- /dev/null
+++ b/drivers/clk/qcom/clock-ipq9650.c
@@ -0,0 +1,164 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Clock drivers for Qualcomm ipq9650
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include <linux/types.h>
+#include <clk-uclass.h>
+#include <dm.h>
+#include <linux/delay.h>
+#include <asm/io.h>
+#include <linux/bug.h>
+#include <linux/bitops.h>
+#include <dt-bindings/clock/qcom,ipq9650-gcc.h>
+#include <dt-bindings/reset/qcom,ipq9650-gcc.h>
+
+#include "clock-qcom.h"
+
+#define GCC_QUPV3_WRAP_SE6_CMD_RCGR		0x04004
+#define GCC_SDCC1_APPS_CMD_RCGR			0x33004
+
+#define GCC_IM_SLEEP_CBCR			0x34020
+
+#define SRC_SEL_XO				(0 << 8)
+#define SRC_SEL_GPLL0_OUT_MAIN			(1 << 8)
+#define SRC_SEL_GPLL2_OUT_MAIN			(2 << 8)
+#define SRC_SEL_GPLL0_OUT_MAIN_DIV		(4 << 8)
+
+#define F_RAW(f, s, d, m, n) { (f), (s), (d), (m), (n) }
+
+static const struct freq_tbl ftbl_gcc_qupv3_wrap_se_clk_src[] = {
+	F_RAW(960000,    SRC_SEL_XO,                 19, 2, 5),
+	F_RAW(3686636,   SRC_SEL_GPLL0_OUT_MAIN_DIV,  1, 2, 217),
+	F_RAW(4800000,   SRC_SEL_XO,                  9, 0, 0),
+	F_RAW(7373272,   SRC_SEL_GPLL0_OUT_MAIN_DIV,  1, 4, 217),
+	F_RAW(9600000,   SRC_SEL_XO,                  4, 0, 0),
+	F_RAW(14746544,  SRC_SEL_GPLL0_OUT_MAIN_DIV,  1, 8, 217),
+	F_RAW(16000000,  SRC_SEL_GPLL0_OUT_MAIN,     19, 1, 5),
+	F_RAW(24000000,  SRC_SEL_XO,                  1, 0, 0),
+	F_RAW(25000000,  SRC_SEL_GPLL0_OUT_MAIN,     31, 1, 2),
+	F_RAW(32000000,  SRC_SEL_GPLL0_OUT_MAIN,      1, 1, 25),
+	F_RAW(40000000,  SRC_SEL_GPLL0_OUT_MAIN,      1, 1, 20),
+	F_RAW(46400000,  SRC_SEL_GPLL0_OUT_MAIN,      3, 29, 250),
+	F_RAW(48000000,  SRC_SEL_GPLL0_OUT_MAIN,      1, 3, 50),
+	F_RAW(50000000,  SRC_SEL_GPLL0_OUT_MAIN,     31, 0, 0),
+	F_RAW(51200000,  SRC_SEL_GPLL0_OUT_MAIN,      1, 8, 125),
+	F_RAW(56000000,  SRC_SEL_GPLL0_OUT_MAIN,      1, 7, 100),
+	F_RAW(58986175,  SRC_SEL_GPLL0_OUT_MAIN,      1, 16, 217),
+	F_RAW(60000000,  SRC_SEL_GPLL0_OUT_MAIN,      1, 3, 40),
+	F_RAW(64000000,  SRC_SEL_GPLL0_OUT_MAIN,     24, 0, 0),
+	{ }
+};
+
+static const struct freq_tbl ftbl_gcc_sdcc1_apps_clk_src[] = {
+	F_RAW(144000,    SRC_SEL_XO,             31, 12, 125),
+	F_RAW(400000,    SRC_SEL_XO,             23, 1, 5),
+	F_RAW(24000000,  SRC_SEL_GPLL2_OUT_MAIN, 23, 1, 2),
+	F_RAW(48000000,  SRC_SEL_GPLL2_OUT_MAIN, 23, 0, 0),
+	F_RAW(96000000,  SRC_SEL_GPLL2_OUT_MAIN, 11, 0, 0),
+	F_RAW(177777778, SRC_SEL_GPLL0_OUT_MAIN,  8, 0, 0),
+	F_RAW(192000000, SRC_SEL_GPLL2_OUT_MAIN,  5, 0, 0),
+	F_RAW(200000000, SRC_SEL_GPLL0_OUT_MAIN,  7, 0, 0),
+	{ }
+};
+
+static ulong ipq9650_rcg_set_rate_mnd(phys_addr_t base, u32 cmd_rcgr,
+				      const struct freq_tbl *freq_tbl,
+				      ulong rate, u8 mnd_width)
+{
+	const struct freq_tbl *freq = qcom_find_freq(freq_tbl, rate);
+
+	clk_rcg_set_rate_mnd(base, cmd_rcgr, freq->pre_div, freq->m,
+			     freq->n, freq->src, mnd_width);
+
+	return freq->freq;
+}
+
+static ulong ipq9650_set_rate(struct clk *clk, ulong rate)
+{
+	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
+
+	if (clk->id < priv->data->num_clks)
+		debug("%s: clk %s rate %lu\n", __func__,
+		      priv->data->clks[clk->id].name, rate);
+
+	switch (clk->id) {
+	case GCC_QUPV3_WRAP_SE6_CLK:
+		return ipq9650_rcg_set_rate_mnd(priv->base, GCC_QUPV3_WRAP_SE6_CMD_RCGR,
+						ftbl_gcc_qupv3_wrap_se_clk_src, rate, 8);
+	case GCC_SDCC1_APPS_CLK:
+		return ipq9650_rcg_set_rate_mnd(priv->base, GCC_SDCC1_APPS_CMD_RCGR,
+						ftbl_gcc_sdcc1_apps_clk_src, rate, 8);
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct gate_clk ipq9650_clks[] = {
+	GATE_CLK(GCC_SDCC1_AHB_CLK,                    0x3303C, 0x00000001),
+	GATE_CLK(GCC_SDCC1_APPS_CLK,                   0x3302C, 0x00000001),
+	GATE_CLK(GCC_QUPV3_WRAP_SE6_CLK,               0x04018, 0x00000001),
+};
+
+static int ipq9650_enable(struct clk *clk)
+{
+	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
+
+	if (priv->data->num_clks <= clk->id) {
+		debug("%s: unknown clk id %lu\n", __func__, clk->id);
+		return 0;
+	}
+
+	debug("%s: clk %s\n", __func__, ipq9650_clks[clk->id].name);
+
+	qcom_gate_clk_en(priv, clk->id);
+
+	return 0;
+}
+
+static const struct qcom_reset_map ipq9650_gcc_resets[] = {
+	[GCC_SDCC_BCR] = { 0x33000, 0 },
+};
+
+static struct msm_clk_data ipq9650_gcc_data = {
+	.resets = ipq9650_gcc_resets,
+	.num_resets = ARRAY_SIZE(ipq9650_gcc_resets),
+	.clks = ipq9650_clks,
+	.num_clks = ARRAY_SIZE(ipq9650_clks),
+
+	.enable = ipq9650_enable,
+	.set_rate = ipq9650_set_rate,
+};
+
+static const struct udevice_id gcc_ipq9650_of_match[] = {
+	{
+		.compatible = "qcom,ipq9650-gcc",
+		.data = (ulong)&ipq9650_gcc_data,
+	},
+	{ }
+};
+
+static int ipq9650_clk_probe(struct udevice *dev)
+{
+	phys_addr_t base;
+
+	base = dev_read_addr(dev);
+	if (base == FDT_ADDR_T_NONE)
+		return -EINVAL;
+
+	/* Enable the sleep clock needed for the MMC block reset */
+	setbits_le32(base + GCC_IM_SLEEP_CBCR, BIT(0));
+
+	return 0;
+}
+
+U_BOOT_DRIVER(gcc_ipq9650) = {
+	.name		= "gcc_ipq9650",
+	.id		= UCLASS_NOP,
+	.of_match	= gcc_ipq9650_of_match,
+	.probe		= ipq9650_clk_probe,
+	.bind		= qcom_cc_bind,
+	.flags		= DM_FLAG_PRE_RELOC | DM_FLAG_DEFAULT_PD_CTRL_OFF,
+};
-- 
2.34.1

