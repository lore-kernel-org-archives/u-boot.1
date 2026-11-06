Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CF2606A32F
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 19:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=B6zWY2w0;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Rw8CwmWZ;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TuIAdLij
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A6363608F8;
	Fri,  6 Nov 2026 19:17:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id M2mcZZh3bRLK; Fri,  6 Nov 2026 19:17:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E7795608DB
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793992624;
	b=hpzByBGpfp3szWqkgeDZCGSiQPZUiGSjX9QqaXzeA923Ou3X/hlfX7LssB4AEWWV/FRO
	 HTfJvd6eGYVETw/SLqPGDjM8s5VVHXrC6jXHd70Uv9NoImd5+G6IkQeo1fU/V6zhJsg5m
	 4fYXTBwq6GocTyo8orPezRdd8pckds5N59HLVQCKNEQugAfLNthtGqlc5WTa0y9BZAjNu
	 MNRTHqGTIhANeDBVlsoCy/EYoloPtlEbDvvwZX90T01ylxZQpGhwaFDOTL8cVmtZGTtMD
	 ey03fBwprc44tXf5hiq41437E9yUtGfDTsq/qT3+Ccbu2fh/A9ckAm57if1wS5SEbGg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793992624;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=HPreWabc2Bv8o597sbIPfNyGq5jOH1P6u/UkE+oYOI0=;
	b=ebkA6W6jvS4NxdhM29Kz3hBweHNVFndwU2yJiYE5xxhd68wlCqSiQ6i4HYYd8UAfWZ1E
	 9sQinuHYfHk2QB2T0W1lDSZaD7kNCJ5t4rJ1UduU50Z0sv3iWScyVS1+comYu1Ez69aMP
	 mxZitCEoZzoTgSZeX2putTMCFyjvTYMZyOTEK/ENZAByXsLrSRZtW91SKCnQ/kKZU5AmU
	 y+5EV6hO5TnheagqO0Tv2H2nJKdH9LWYRtCNiwB7lU+7Ff2h3/yKxMg3o7Imu4/TvLlMb
	 zzpr0cPFLyFPLdErBa2m3RqQz3MtmV6Qel4GQSEXi/XLP1MNg4N/ZCgWAL4mUEz+Dgw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793992624;
	bh=HPreWabc2Bv8o597sbIPfNyGq5jOH1P6u/UkE+oYOI0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=B6zWY2w0f8GF+wa53/bKNQmA11T6qBlsydGby9USGQEEK2NpKFvGZceYUv/nGka1Y
	 Qxk1FPHTWPRd0nGJWnv7pYBknWamFWV9RBq+tLpREOyYmjDAyLQHkaCvkKh1fWvCwz
	 L535rTAFlIeZVjiDVoH1MpuPxpWcd+e3sNb2YoL2Yonob186NL4qt/gtAMUB9YU8+R
	 zJEQB71+T9nepu+0nzqd1ZmGml56c2ZRKS/eTvRonVOLRoZMxFVQfAPXg4Ljqe7Jh/
	 OPyoL2lHx8vNaZwPGHlnyQBGjsn5j7IaQ+ZvoLhqgQf1tlO7eny9a/GVXojv1J9c5E
	 eXzhEj0h+WVfA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E7795608DB;
	Fri,  6 Nov 2026 19:17:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id A1DBE4B8
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 19:17:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 938D9812E9
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 19:17:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HVyUG1N3XYI2 for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 19:17:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3D77F812F1
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=urvashi.sharma@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=Rw8CwmWZ; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=TuIAdLij
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3D77F812F1
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 19:17:00 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A6IiMIU3677004
 for <u-boot@lists.u-boot-project.org>; Fri, 6 Nov 2026 19:16:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=HPreWabc2Bv
 8o597sbIPfNyGq5jOH1P6u/UkE+oYOI0=; b=Rw8CwmWZ35JFachDZIZVSoeBeV8
 w6TdWVAjJ87xBZe5BJJjFVzf0pGQKV/J6Gg9TArxBBv8v/QT8ZP2m8y4aifkIW4a
 snDCxF03JvOz7j4OpU7Xrk2WTYd+uN/DI6GBQvRnpXr25yQx4cdGbAu9QZNaUNrB
 9mO6AUTu8F3EiJjHc04ll+66N0BY5GTBatLIrd/iH4jtOVHSCsOvT140HIq2RU/2
 qbMH1hURRWUXAJlEeV1VlYbeBdKpSFHgx8Cj0zjFljRIoQ0gkqS2hCaZOC18oxik
 m8J7jf71Y/ouEBlnH0DtIqptRBo2+sRguExh+gZVx85UTyTfCXifoxYsrXw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hsmeb04ac-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 19:16:59 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-30bcb065bfdso1599333eec.0
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 11:16:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793992618; x=1794597418;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HPreWabc2Bv8o597sbIPfNyGq5jOH1P6u/UkE+oYOI0=;
 b=TuIAdLijz4Y3Kgpxkr1p2fL+XL9We21PWvHLG5HM0FI6T0UGQlAm+YOCz+y2Kzvqbp
 eoxpvb5ZjODjxxJUeZm8qlF0qWacsTfjFLis0il7F0cT1jhyxwf32fceL7dkyQ7rAjlT
 6ftW93OIodtxjrJrrFtLxwA4pho//dZEAxdhJskKtlwgT2U3ww2LHODw9FTy5obpeeYm
 qsWEX+y7eZV/QnkknCTj6KRmDOI68D1P/LOxRyQsbKYGy0zXD/0JMN4ItTpBS0su5JJg
 fH/aSZHJuvyMYa35P9gg03tqMwNZAJf8bUGzckFikV8Gx4yKfoK3LLFwcSsN2S5YC9Ly
 1fZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793992618; x=1794597418;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=HPreWabc2Bv8o597sbIPfNyGq5jOH1P6u/UkE+oYOI0=;
 b=BDMKlpDf/AvuXc5pvxdczv0iB6En1yI2+aFQBplGLfzhV6LwuZr+oIH+d0xENsomaM
 mhoMGnhtOkuYsuOwvwp9Rt/eT5NRX1Iq9S5FbSv6KPjFKsrFTI62zP/x4e9U+miMYziy
 x+ReQ6rSPsZJmVOCbuzDJ8mL+8dQQDKtfG7JoETZLoeEqWaibRj8ohLIKS+w3JZmgu3v
 Plv/FNYRk9UF5P3zFNCF7F2On5sCKBYa/YhcnHTjIXzWsQMWgQZP9TOoQNMbvAGBbmjK
 A6hwDaXP2yl6xLIT8sh5cXflqugA7u1WERIccaDLnyd5LUin2NDcmZ5Aphn+uF3ow+hr
 nrpw==
X-Forwarded-Encrypted: i=1;
 AL+hErG9qjasLjzuJ7m9vj/jOV/ZRer38I7geubplZkg+yYyKGZ4L3hpatAwAOSf5vmWmoVGZmxlJS0=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8tUvl6BPWGe/Ff622muBgto41G2Is4jgDxDE2O5QeGrxoWq4UQ
 cm8eDkn3ymgoqLFW6a3stFH5y94VzXPLs2WEj/3epPSp+L0z/dKNSHB7+j+NdnuAYPyIeaaWQIm
 qPm0fvYZICbujb9gZnu+WeDcYQgPRjn2zv9RSHl9PSmUfKgN6jTM7LLUzAEeHAdElDn1ZVX7Up/
 NhC0s=
X-Gm-Gg: AYBFou08eVoH44GikGY+1QIiHFauAyGQFKYB8S8uqsinG/KqR9jOAEE0LfbI8XH8CDu
 Lz3m+sNNxx7sGopho68otX1eWbq2n/sWLrQUByVwWGvo5phEb4XA275oukU0Z5V5r4NFKPjSFJG
 7qh0+ST7CEubv6Rr7NcPIheOPwdS1l7gL2fN8ITY93cu3+WJkBeAjTQNqzD3xJ102r0tUj4Pr5y
 VAMuzunGGU6HeSV9QZy7y+Go9+6b7JKIXVuoLGS2aVQi8Ben7/+C8nCuvvP+f3L4MpJB2OWu03H
 JXtO2GH0qMR/I9/AVYEbzjf4cYqZPB1NFWjKQv6uhg/Ky1BvqR0k8YoS2OosglyqsQqMqMvRC7R
 laALs4+dsCUNrxBUYe5EuWjRmNji7RzOl8lsAve0tAkGXOP7CN7OMVC1h3q9HWsQiHGsLxLuu0k
 4s8BSgIbOfA2s8k1bAjc+faoGaddCmMw==
X-Received: by 2002:a05:7301:d80c:b0:36a:180f:3154 with SMTP id
 5a478bee46e88-36f75a2772dmr4910483eec.18.1793992618471; 
 Fri, 06 Nov 2026 11:16:58 -0800 (PST)
X-Received: by 2002:a05:7301:d80c:b0:36a:180f:3154 with SMTP id
 5a478bee46e88-36f75a2772dmr4910447eec.18.1793992617781; 
 Fri, 06 Nov 2026 11:16:57 -0800 (PST)
Received: from hu-urvashis-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36fa8d45068sm7475530eec.8.2026.11.06.11.16.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 11:16:57 -0800 (PST)
From: Urvashi Sharma <urvashi.sharma@oss.qualcomm.com>
To: Tom Rini <trini@konsulko.com>
Cc: E Shattow <e@freeshell.de>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v2] riscv: spl: Add BOOT_DEVICE_UFS
Date: Fri,  6 Nov 2026 11:16:54 -0800
Message-Id: <20261106191654.923266-1-urvashi.sharma@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261106173439.GB3669968@bill-the-cat>
References: <20261106173439.GB3669968@bill-the-cat>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: xEBVyJ6IFphNB6Cpv0MrNctB5sUho4G-
X-Authority-Analysis: v=2.4 cv=DOAacCNb c=1 sm=1 tr=0 ts=6aee27ab cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=KpbsFfYZENygytMkYGoA:9
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA3NiBTYWx0ZWRfX/8TnWrARb0Lu
 BDumgbT7kN34l5s31lW2nFDCeFJa4oyIB1dKAo5kPSfFixEyyp2CWgMehtUS5DGsrVILB6ecxcQ
 iuQRtaio1JDC45U91obeHnxKa34boEc=
X-Proofpoint-ORIG-GUID: xEBVyJ6IFphNB6Cpv0MrNctB5sUho4G-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA3NiBTYWx0ZWRfX6/e9oq4KbDFN
 Gz0wVdAJvwFBj+SQMWx1ACpvESuXWM3o/JlqOfH6unokyrkKc6prSjvP5i2fOvHOv54uzv574eW
 umBwEC3T46DgZLtu2SqpuTkeHWpurtaawqPk4rC2hOOu6VpPd8wZ4ipb+cQDGMqN145kb+w7kwF
 loTyU+UoGY+kmmUHn+ocDBVCaExTReX30H0iVcCv7gTe2cXpS/4OVj0rsvfd4u55hPCvcd7LkmB
 l1HTpKbtvlQYbVUOn3uCCBit3TaODPqYhe5nXCo/XhoV8DBnBcMH38qXNqPWbjXhIdZhUvgHxfE
 mh6JsishYHqzB/VVH9CgWNv32QCUv8d5Y4djDNOXf9IJj2pikLqrrwd5zdcOXQZ5RKc2/Kc/Up7
 sxMRDIO984NAFa8OaemtXsAKxkDp61nkLebr/Q1+4X/Cz8jynbEfHIqdZZ5xEvth2b7TgH95l1P
 oVaVsQq59vmYad5gXjg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_06,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 phishscore=0 bulkscore=0 adultscore=0
 impostorscore=0 malwarescore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611060076
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Tom,

On Fri, Nov 06, 2026 at 11:34:39AM -0600, Tom Rini wrote:

> Is it too late to ask you to pick up and make include/asm-generic/spl.h
> instead, and use that for at least RISC-V ? The history here is that we
> have a few cases, such as arch/arm/include/asm/arch-omap3/spl.h where
> the values matter as the values match up with some ROM. We also have
> lots of cases, and it sounds like RISC-V is entirely one, where U-Boot
> itself figures out it booted from $dev and so return BOOT_DEVICE_$dev.

Not too late at all, and thanks for the background. That makes sense to
me, and it looks like a better approach.

For v3 I'll add include/asm-generic/spl.h with the common list,
including BOOT_DEVICE_UFS and with BOOT_DEVICE_NONE kept last,
and use it for RISC-V.

From my initial analysis, other architectures could benefit from the
common file as well, and those can be converted in follow-up patches.

Thanks,
Urvashi
