Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98438606A31C
	for <u-boot@archiver.kernel.org>; Tue, 10 Nov 2026 11:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=EpgbMb87;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=OOzv0IeK;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RGneb8QE
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 661A5407FC;
	Tue, 10 Nov 2026 11:45:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GG1rk1QgBxxK; Tue, 10 Nov 2026 11:45:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 850F840813
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794311138;
	b=QPuss/AgqveE6AZeah8LqW4gvQz/0BwH9RgjjgW/2r9Kpj9wtF25FD+/V0gS7y2zLfJz
	 //vs5tjMVM2rXvGsxsRiH/bF7lBVtiJJ1E+JwsuP7RiAdkzRJ+sON3bxF7hQ79gmsedGl
	 8H6TgQBXB3yBbF/D9oYl35baN+s/P4LfzKo6bRq1/KNab9uZdjKqYURdKvwWWy+OMNuMQ
	 lqq4xiCukYuxlxHS+67whYzGAmKxVxGoYRHLjpnERLEYIcQhrMHWbB3m73wOpOu7r0KlV
	 XUWxTjV+Ral1zkAOAleeqMHv/+jSulArirFRWnkT4r0V1IKpB60FiaF0qoqZIjrBZJg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794311138;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=t6KFB9GB6H9W4fKs02tE+WqTDPcqWW9rqxL0CGpwgcQ=;
	b=TtHr/yLDzLinHKGKpZuHiujq5mLDTzqhxSFIkoe9eZ280cB8TAUx1eJ1+1AJ053qYeZX
	 MbgIQXXXbEi6L+USdWrTAc97wI73MxKrsam/UghlDB0+apkwhslCWJu/xB8Q3w9bWR6F9
	 THwhnS//THxmWv8gMqhpLuXAdGibS9sII3lH7f25ozgLiw1pKQxoUO0EL3r2PIt4XWr6H
	 5BUv0gxOdXlpsUJhZtsuuZT0OLYchyW+zOspgNETxqOsWCQBmnGrWt2kSIKMc53DBxNTh
	 a538ZHGA4gUerhKW18GHz6H0tXK78l5q+1VkoiGuZzDe5CFLmyw6eD1dYhnoMESm/Hw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794311138;
	bh=t6KFB9GB6H9W4fKs02tE+WqTDPcqWW9rqxL0CGpwgcQ=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=EpgbMb87muosbt8O/tSEGlFTaGI5O3cdzHjt6fYodpbu6+gai90FV26+g0+ZIcO7T
	 bswxviavPi1Tc+eSCXZOHFmFjbN3RaiFymyVZv/41jaGD2aKvQk1SoWGp5xh1ALIVN
	 vvk2LRYgAmmrXpJnxB1SRF5mrTjPekjpnnFUJ0hhpjSzlXW1jW+bsWaTDkooemhz3m
	 TF5HpPqbPTjLcheAhkN4L2SqAjA0StZoTsqdVG+M/qVBrvfMRhnVXbAzJkfg/O5ie8
	 IbwtlS5hXMZg+e+WjtzybbACf1lREMe9WG1OkrXw/GcV799Ktq0UgmSXEYiSKTLeej
	 7L7hc1YWPvbew==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 850F840813;
	Tue, 10 Nov 2026 11:45:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id CBB58CC4
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 11:45:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BCECD8112C
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 11:45:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CU4r7s-mFuNu for <u-boot@lists.u-boot-project.org>;
 Tue, 10 Nov 2026 11:45:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6E53E81102
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=OOzv0IeK; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=RGneb8QE
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6E53E81102
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 11:45:31 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AAB9x964186613
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 11:45:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=t6KFB9GB6H9W4fKs02tE+WqTDPcqWW9rqxL
 0CGpwgcQ=; b=OOzv0IeKAOXpNX9tAw+u8JdiNXaMVBVBcdDXfWHG+ToXkpmAvYN
 9SlELxAprvqo9DTMPx/MQHbq+sqLfRoxjeLvxekxBp1c4xqhSQ7lWwxX6qCUh2XY
 WvGdBhCGA6JQMqlwagllB3sH6lXNzDPUvhfwQZ0nUCWdAuTu8wAmzns+XXwpL4dn
 qz/KK+jCD1wwLZ13zek+5Xbsj95YqFPvhfK5p3K+LwNU+Tt7vTLkD/sBQYJkIZSm
 yFuhpNT09Xz0o/SCARWtcgFyv1aVMLKzoFKG8r2qN6JoqeBTfgKw2aoMIVfiLDFN
 KAFjWxlI/t8EzN4mN2G+htUT9/9Pxi2eTsw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4huyvwgn7y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 11:45:31 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-37549877380so1012283eec.0
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 03:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794311130; x=1794915930;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=t6KFB9GB6H9W4fKs02tE+WqTDPcqWW9rqxL0CGpwgcQ=;
 b=RGneb8QE7bdIwuIzdYJtMnmCuxzeoChK8rEdgc0Vha+L7InQ11gqXSHM6L/WXShLZD
 WctfflTfRA/JdQyeF94kl5zu7LJbEEprELQjvOqPBp/VoRhEXES8ivt9f7ICuZYPbY30
 69yg7UVoH6Bp9W2SRBuybCcT7kXxYnNt262HFmii29SgGbAtJmBTJMcGJ/n0oxkxW7E1
 ngEvEEfRiscM0viK1aZbZMda39Y1K3SE+gummaOhZkFI/Ese0wa68gcrcvl3EfA+KgnY
 Kp3a9YMcPpwtR2KtOgmEjAYXZg85J6UH9hsfy0bsvRuzDKVjQXmYdMoKbuP8kwcWWr4c
 O0pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794311130; x=1794915930;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=t6KFB9GB6H9W4fKs02tE+WqTDPcqWW9rqxL0CGpwgcQ=;
 b=GOL89KZPEePiKvWk6BfhHPZ74HrfHW+mtPcE2QxdTQ/WOa2jn/AdoJBWsosR83LrrL
 IAMYhK1Lvbma3FsbY/JsawNBSVHtatIf+P7J3IZBDbzLlbRhbpoBwxS14aXh+sHMUcBs
 YS7tuCH2Rzhdv2HOtghhtVws2d99997Unx1hAX0+3TNe4VnTnIOOP+X5EGg9IhWJXJK4
 vRs0OPrv5yHWhEw8on4dkiUIS6lHouj6kMEFxsT2pIN1pZUkOKzS5sUjwaTODMeo8y2e
 7ljRFtI99HP+1L1mhzt8zNp3jkq22dvPv6cj6EWLTYBKFciH4vysV1+hOtrKWydBAdM7
 OnCg==
X-Forwarded-Encrypted: i=1;
 AL+hErEwZyeu7zOV82EQfHZIfEY9gHxMUdNARH7C7uEEzTPW54QeTN/XIqbbgeL4cHUnEKCWqocXoXU=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z97KDAXI7TzmzzxBTYkKhA36KfEBNZGzPc7wfhN3+NK4gvEAhwz
 Ks6Ky4M8XGcUKcUaR2p2fhpqC/aPVuWQFx6+C9HRQKH5kxbn+KveQGmDEcX2og2joxpN3RN2TqG
 +WpCbn2hfNt6ks+4loTXpmTXghZ65LdI3WSeLjVvoMiTuvKAclneG54r1Tf+1fZst4adgqOA=
X-Gm-Gg: AYBFou0lB7wRcGs3DkS+fTQMIU19co+1CN1YIdxOvYzXjXNbL3p7Z3FzEvsxvmz4Iq6
 dmxod5dwG2iBWE5+rAGDQByB2pXHMa+Mq8leIt82eTGFANiDhMUFYCfH6YcAbH6HBUeURt14ak9
 svonx2DeI+ZD4J3kiTV3KsvMwB2h8YlaWgOXAjjTYlwyU2fOLK5eO7enY5cGwAp2igYwaJRJVuB
 mAbMidOnVRTSOH/yir+2c66UZwzvDeZQH2zpasQOgyEE67vi/KMJFN+smoQBawiSr7crnVPyQjN
 L7K49R/wvJ4uaaVpvH3LynpTLBmHL/LxxF+dGJJrpshwZfnY2RgSDQrsI/9pIesEILfICiQjuGR
 tIFk4LFqqMEZwB9G6yeJhXbSZoGxy+5FhFik94vJ1yqP+Y1QLmO7yX1ru+EGRRbJg/sxTl8SUu2
 HXP8nxL44hol/BSQ0kz1/pPKDgb+j0VJcoUhCaRThiDA2Q6zMxsjGx9ElT2mncIRZ3FQ6X
X-Received: by 2002:a05:7301:fd03:b0:36f:f3b7:6dee with SMTP id
 5a478bee46e88-3751ee7c2c9mr2823235eec.7.1794311130273; 
 Tue, 10 Nov 2026 03:45:30 -0800 (PST)
X-Received: by 2002:a05:7301:fd03:b0:36f:f3b7:6dee with SMTP id
 5a478bee46e88-3751ee7c2c9mr2823178eec.7.1794311129548; 
 Tue, 10 Nov 2026 03:45:29 -0800 (PST)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-37520bf3e18sm11828890eec.16.2026.11.10.03.45.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 03:45:28 -0800 (PST)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com, peng.fan@nxp.com,
 jh80.chung@samsung.com, tanmay.kathpalia@altera.com,
 aswin.murugan@oss.qualcomm.com, nathbappai@gmail.com,
 balaji.selvanathan@oss.qualcomm.com, Michael.Srba@seznam.cz,
 u-boot-qcom@groups.io, u-boot@lists.u-boot-project.org
Subject: [PATCH v4 0/4] qcom: Enable HS200/HS400 eMMC modes on Qualcomm
 platforms
Date: Tue, 10 Nov 2026 17:15:16 +0530
Message-Id: <20261110114520.229480-1-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: FQLVNL5_wYOVlnUnfGswlTHnYebqIjmD
X-Proofpoint-ORIG-GUID: FQLVNL5_wYOVlnUnfGswlTHnYebqIjmD
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDA0NiBTYWx0ZWRfX8SX5H+2gk1WG
 iYyKVKmQlRPrg5tAPE6FbjJRBTgJPNmOKP2b6aBimLboB+alrSpSIOQDA5wqSHl9I/Yr8shyCCA
 h4KoPIG8VNWNdi5eGPA6uUJmsItMXB8=
X-Authority-Analysis: v=2.4 cv=NNpAaE6g c=1 sm=1 tr=0 ts=6af303db cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=zILQ9J64no_-qccxIzIA:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDA0NiBTYWx0ZWRfX3o08eCr9jbxn
 ry/6Oih3fQURONUngq33vWRxV/KnZy0OUoY4AYwP9stsU85tLdl4rXU/+VWCLZLKs3gFMg5Q25c
 tSEub6cyWEz/6WqWLsX2oo1xk2PVif/AuRBSvBNSU7HelTEZaV3LbMF2Se+HupMKl/tXmHcY+Fp
 LbhgTdo4rrpwRrvZqtKyQyPcEPWSgZvWa6X8PyHXZQdi6/3k68O2z2VkPOJSmRzCxY1rlOrt91I
 5/JTAS2/W69/5wHZ+iUmB7hJyMgR3XY+u7ApZh4W22JVXQmFEE0YRi/dri3ap5GP9hOyD2DDnhg
 FbZJPsyFiJrLptVGlbrKB+XdpcnSnnoQeqWXAeNQMySgNYmacOjpgN1REgAmKxMSQjN/UGby06l
 LGKLXrKMgyUMpaPPZFfDAAl+eKhxJJ35hUFV6UCZfYpHYOK+ID2APvON14CGbRmmucxJT/WnUZP
 lUewla43FFIsR0RNYdA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_04,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 adultscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 impostorscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100046
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

This series adds HS200 and HS400 support for Qualcomm SDHCI controllers
by implementing the required DLL initialization, tuning, and calibration
sequences in the msm_sdhci driver.

Qualcomm SDHCI controllers were previously limited to High Speed and
DDR52 modes due to the lack of HS200 tuning and HS400 DLL calibration
support. This series enables higher-speed eMMC modes by adding the
required controller-specific programming sequences while preserving
support for the existing SDCC core variants.

Changes in v4:
- Split the series into logical chunks to reduce review complexity.
- Introduce msm_sdhci.h for shared definitions and improve driver organization.

Link to v3: https://lore.kernel.org/u-boot/20261030134145.2349821-1-aswin.murugan@oss.qualcomm.com/

Changes in v3:
- guard execute_tuning under CONFIG_MMC_SUPPORTS_TUNING to fix undefined
  reference to mmc_send_tuning when tuning is disabled in SPL builds
- Dropped the "fix max-frequency read into wrong-sized variable" patch
  from this series, as it has already been picked up.

Link to v2: https://lore.kernel.org/u-boot/20260902170559.3225833-1-aswin.murugan@oss.qualcomm.com/

Changes in v2:
- Address review feedback by simplifying tuning logic, removing dead code,
  and improving HS400 error handling.

Link to v1: https://lore.kernel.org/u-boot/20260827073325.4113071-1-aswin.murugan@oss.qualcomm.com/

Aswin Murugan (4):
  mmc: msm_sdhci: move definitions to msm_sdhci.h
  mmc: msm_sdhci: add CM_DLL init and HS200 tuning support
  mmc: msm_sdhci: add HS400 DDR/SDC4 DLL calibration
  configs: qcom: enable CONFIG_MMC_HS400_SUPPORT

 configs/qcom_defconfig  |   1 +
 drivers/mmc/msm_sdhci.c | 722 +++++++++++++++++++++++++++++++++++++---
 drivers/mmc/msm_sdhci.h | 127 +++++++
 3 files changed, 805 insertions(+), 45 deletions(-)
 create mode 100644 drivers/mmc/msm_sdhci.h

-- 
2.34.1

