Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832E7606A31D
	for <u-boot@archiver.kernel.org>; Sun, 15 Nov 2026 11:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=uP+LiXs0;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CJzzNRhi;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LzXssQmN
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5F27040732;
	Sun, 15 Nov 2026 11:51:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id A-QUszFTzLeS; Sun, 15 Nov 2026 11:51:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A6BE540754
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794743502;
	b=F3VLY4Wz5DighWZZdCrjCEGMCneVCw3bVQOdWmk5Yqn9Z9fL0Rr+JrrVlHgBivlbHmd9
	 HuyV9sJhdgUxS+CcTeP8fRO+RVh6ptnn3idox5KTeZS4Xe4dEqMo/kIc1D+8PTjNcHcjS
	 mB5mrhdIWSIifGfiQb9tT48lfqjBQavLnSv+PxWpvr2ZE0XiH/2qmcFkGHZvTtvasVQGP
	 0hLNKin/z8DbP37gP8oWyuEiaDo5ygDWnwfjEmzXzntb/URm2S8EaujfFruVOVYQTp/Ty
	 Ktwr3scrembO7ppbj1ArXWhd9OS1K4T74U6hYv4b/rNqEQANg7FS3236otOV7072Pyw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794743502;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=6B1EPzD9kEDtSLFKlRMSfZUzE6i451VZzR9AfXuyG2g=;
	b=QfXRCwo8RoYJZx0sCTx83J8oAnd2JBnPwZ6bS5DBsozgfbQHgDNny4i712fO0WRXhnLd
	 rbv7i5e+sXp7Omu2yRKzOxP9nCG5nqV5JYHeHBxsCC5IayUlC73aeKjrS582293HJayWZ
	 xjCjdHyIrJSl7l4OP/e6qtD9vtKCJS0aXHxC7oCeP3IwL+4CGhu5INbI9oajZ0Bxb0ClX
	 ix3KpBApFiEFPCUDIMqTH2jj8fH5FzyvtXzt/TNh4aN4iVO0gn0io6m5nzTshBsYaG9GO
	 06N6PP77NrZ91Spe0mfsJg7/qJEjleCiKX4ReBWdhpAada6W0SQ8vjFE6o9yV+/EhZA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794743502;
	bh=6B1EPzD9kEDtSLFKlRMSfZUzE6i451VZzR9AfXuyG2g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uP+LiXs0W6OeypRw1h3N/0+uHGSEOinlg9f8fv8e+YshF4qZE6u4iu3oOvlM+FZlH
	 Sx0MNOb493ci+YKowWawPwdkjs35d6rKvmuPgK7ySTAOXsnW8tlF665htfPGpULeeR
	 moeQMX+ijuKz/0ril+UPonGvQvQKjL/xrOt3PYiEbEYmMTxloSXfph4sl2mQQvbV3L
	 WuFaBOe7ckmkhh3nN5Ter0DjvL+uY62hTEClPtmZOcfS1AO6EjnronA2UuW+gj8nuO
	 iEyiYekO6tCpyUDXTEGUhxU5s8MUkhjjT8XSyeEy3vPjx2UddOy8aTs/O7KtPTtuHO
	 XXtjuF5lrB16A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A6BE540754;
	Sun, 15 Nov 2026 11:51:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id A1E1470B
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 11:51:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 879F740068
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 11:51:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id k-c78G7hY0SR for <u-boot@lists.u-boot-project.org>;
 Sun, 15 Nov 2026 11:51:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org BAC7C40061
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=CJzzNRhi; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=LzXssQmN
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BAC7C40061
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 11:51:36 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AFBlwUm699491
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 11:51:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6B1EPzD9kEDtSLFKlRMSfZUzE6i451VZzR9AfXuyG2g=; b=CJzzNRhiwgb5c756
 q6ciA0xT0Vf0gdTrz8eHU9UZ+/VVZgX2LiI5pczYXUYccusRRNDGE3dHCsX1OV8n
 Vg6l19Ah/RcNKt86JjtCkqtwadH9dRQnJQIrnX4jfL5k/Ai6ydfYUn57aUxcD2u7
 FQQScEB7vUCVUhe6uYgGazhOpWplmhG2+5PMCQMTIgjii3VR0+dt3h8zQX6/gce8
 NxnATfYUJeXPbWJsPYYnRGZV5YadXipx2nBHRPo8Iyk0e4p3G7JXrtpLM5wB6oiw
 RAXAahRWFPj7qZqyLCmL7HObkwMcb41CjDtPNXiYwdsULqubqV3sfgLFol2mvw2M
 vIeT+g==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhj42w7a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 11:51:35 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93f33438950so66924585a.1
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 03:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794743495; x=1795348295;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6B1EPzD9kEDtSLFKlRMSfZUzE6i451VZzR9AfXuyG2g=;
 b=LzXssQmNB+tuHVWgrweFWXaEZWCmXu03vlrm9eMxiqu7EzUiLaSRJKT+Lgy6Z5xl6W
 4Cs4EvMv8JdhpzpKcXn0rGa/ahEK4vvZdLi5PDbUazQZoaWVCqpJ93eDWen4IcZCvWoA
 /+9NaTPId+v8ru3x1tccSCWDew8+olvDIBCo/2P35jrIdGQFE+J3m26Vv6pBPm/qn2pb
 7bR0kWgussMAPs8d8QM0mUBhed3/GXc1U7TE/bjTb5N2S5HaU7IHV798+ns6bmlOHQST
 W+35t4VU/SnYU9ShbfVGNS0cHzJs8z8uPlst/SYw67S7Rpx4BXaLomsDhRIxpLl7DPXZ
 w8AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794743495; x=1795348295;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6B1EPzD9kEDtSLFKlRMSfZUzE6i451VZzR9AfXuyG2g=;
 b=AYRjHAP5EdtjLzxSA9Pnxmiff4mMs/EjebqnCv3ifEZRLQ0Zabhh+sKg++6yx0Q1R8
 yjcz53M1gpHq/CIPfHCMRbJdZAJpovdMCVw7JTihjOEGmo4iawFkXXdAkj2h13jZCxjX
 hw9Am6gc+nB3aal5hmnnGk+rju4F3L44b4Pmp3WU28YbiCJsjjF0G+18XpDHGMqH9HM2
 0lkJyi/D7pln3T21bKvkYJqjjD42OsuCXHBXv37YbS2nAPlBUjP54ayMui0e1T6EgsiG
 rNaQRthckPZBfFpQJqsUBLtvV61wjV1nTljROQQjK05WlJdBlMfSwn0nTuQyRGG6+sFh
 T4Cg==
X-Forwarded-Encrypted: i=1;
 AL+hErHemLp+LYna91DyNYO9EcCLOi6jbHGIvk4KTXva556m120K45kVDF25PePVSvYZtogOa+i7tJs=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+ZHvF6phCYrrekvptpOy42x9QcE6qTuVwG4odl8jn12+TXRrIK
 ScDpbUnzNbWhb2ZJetiNSjw8sDdWmwVqeA6sUZ4YCLDqyDez9liynfNfn1GfkcZSbHc4XBTZn1e
 RkE0Nmgsu3tY9C/JtzQfgcp0P1V6x7ke6pq9F5cRKtNfLi8HXzmXI7cvT0LvlzZdcNInj0Y4=
X-Gm-Gg: AYBFou2tEpPjM2DVLRwENLKcc7J7KsEjCAhuS61S9n8jPqTbtQJEdozoRz7yxik6I6Z
 Lv0f3c9V75KWYJ6qjbb9fGibMhbltVdA8cfKHVU6tx54OcOjnWoWeRd31k0PVkNhi6zz8A9Wo+Q
 yX0/ab3Uje3JN4LR6lnN1gVJikOwQ4rckr+AaGfl1yvtZEzjmk80/U7Oj0RjOHW7CklyFiADyW4
 p+ZVDLR3hS22IvhSHTaRrXLxlFz4c+wWmDTouGLh4AinU8Re0M98hDALZAmeaKvj2nFv9+wW4MZ
 aUyOLxzBZASfiuzrMh1rf42f0DjeGuO/TQrF4DBvPXJXHUWjyfKG12N2Nw/bT2NRkHx7HaecUto
 lGlSnLmujnsQQFb0UmspPyb5Ar9GhAxRSVApEAEy+vIG99jdQYQL77kaNuRUWj2qZiJi+k2WQJJ
 /TMYMpJJ2bxrXB
X-Received: by 2002:a05:620a:1d0b:b0:949:75f1:e5fe with SMTP id
 af79cd13be357-94975f1e8e0mr156388185a.73.1794743494870; 
 Sun, 15 Nov 2026 03:51:34 -0800 (PST)
X-Received: by 2002:a05:620a:1d0b:b0:949:75f1:e5fe with SMTP id
 af79cd13be357-94975f1e8e0mr156386285a.73.1794743494336; 
 Sun, 15 Nov 2026 03:51:34 -0800 (PST)
Received: from [127.0.1.1] (93-159-22-70.cgnat.inetia.pl. [93.159.22.70])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c5095b3dbaesm299969066b.32.2026.11.15.03.51.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Nov 2026 03:51:33 -0800 (PST)
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Sun, 15 Nov 2026 12:51:21 +0100
Subject: [PATCH 4/4] configs: qcom_defconfig: enable the RPM drivers
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261115-qcom-rpm-glink-v1-4-6255beacc93b@oss.qualcomm.com>
References: <20261115-qcom-rpm-glink-v1-0-6255beacc93b@oss.qualcomm.com>
In-Reply-To: <20261115-qcom-rpm-glink-v1-0-6255beacc93b@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@nabladev.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE1MDA0NiBTYWx0ZWRfX5JclEJ3iQL4X
 dlQGWRChJegzJCTenDHXy1GLwLG02cRVih9J0pyju7mKfWuGEhgAyX3BPxP7rDTeSiGHBBEcsFq
 dLQ6L5NffhDGTtrlrvjg93PICF9AWWXkmrYx7u6ghrJ5wUhKpeHxL4BfEXtNIVc6KkAEwLceZg+
 Hl9odjKZiaPH2xiWJieCFU07wxsS74QdZ+A0EasbiXvlgmwtQlQVahB1jrLOBc/UsZzlU+3Leny
 4KKvFB9wu/gO5Zksj1p5dWb0/UXjgEDRsjfW7vbuLR1QTKFDdtB2CENtcjzvMxkF655OtPjtcax
 mysSSf/aT/NV/bVAUg5nfpJBlIYOOqssUCQnoXt0wuTn0I5uZKtsj4G/s1YbCwQsb5Odo3i6tlS
 /+kgb17EaYmhqdWTh7Hh+zt16ZI8kTU+4dEXFzlCdLoyWJDiRbcvabMHz1N8JBzyVO4l9w0x6sY
 dDOcUzoABMuqzoArA/A==
X-Authority-Analysis: v=2.4 cv=av0nmiZV c=1 sm=1 tr=0 ts=6af99cc7 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=ySe+0nHqNG5yihRO1pIWsw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=osa7vJDqjnapr-kPj8cA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: hFv4WWuJyoht7d_oCmy_n5aN6-FTX8pv
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE1MDA0NiBTYWx0ZWRfX1FAJLeCJglSV
 Os38qG9JgiKXqDkvLP0Kra2ddBJbFsET18kfiHsxATV6Sarg8RkKdRy9WgvblngP7KXEmrOPJUP
 N67h76bxK+osrE4jaXiTB1wifLNlL94=
X-Proofpoint-ORIG-GUID: hFv4WWuJyoht7d_oCmy_n5aN6-FTX8pv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-15_04,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0
 impostorscore=0 clxscore=1015 spamscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611150046
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	UPPERCASE_50_75,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Enable the RPM transport (which selects the APCS IPC mailbox) and the
RPM power domains. RPMh SoCs are not affected, and the other RPM SoCs
do not use the link without an RPM consumer in U-Boot.

Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
---
 configs/qcom_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index e5291750aa7..cc89b0e9b33 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -96,6 +96,7 @@ CONFIG_INTERCONNECT_QCOM_SC7280=y
 CONFIG_INTERCONNECT_QCOM_SM8650=y
 CONFIG_IOMMU=y
 CONFIG_QCOM_HYP_SMMU=y
+CONFIG_DM_MAILBOX=y
 CONFIG_MISC=y
 CONFIG_NVMEM=y
 CONFIG_QCOM_GENI=y
@@ -121,6 +122,7 @@ CONFIG_PINCTRL=y
 CONFIG_PINCONF=y
 CONFIG_PINCTRL_QCOM_GENERIC=y
 CONFIG_QCOM_RPMH_POWER_DOMAIN=y
+CONFIG_QCOM_RPM_POWER_DOMAIN=y
 CONFIG_DM_PMIC=y
 CONFIG_PMIC_QCOM=y
 CONFIG_DM_REGULATOR=y
@@ -133,6 +135,7 @@ CONFIG_MSM_SERIAL=y
 CONFIG_MSM_GENI_SERIAL=y
 CONFIG_QCOM_COMMAND_DB=y
 CONFIG_QCOM_RPMH=y
+CONFIG_QCOM_SMD_RPM=y
 CONFIG_SPMI_MSM=y
 CONFIG_SYSINFO=y
 CONFIG_SYSINFO_SMBIOS=y

-- 
2.53.0

