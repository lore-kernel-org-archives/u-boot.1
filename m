Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B97606A31F
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 06:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=GZBLbCZp;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LTH+emHM;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ShbCTrdg
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E385F80BEC;
	Wed, 21 Oct 2026 06:43:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SLk2ege-iurS; Wed, 21 Oct 2026 06:43:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2928480A7B
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792565026;
	b=qy3pfMfCFAW3OERJYYEkm8YBpnL6k78gpj2BVB9V1TyCH/taL4Q5TGi8ndUbEkBogJua
	 cRL49Tla4QpL8zGLOHGybPwwUDZQo8UUlH0WC8H6bIaMq0xwh2QOocK7AVOFVaud9vQ2+
	 5oUhfOw4EOtUnqf3rMEHH1/6sfZ/Y7+rTegPdXmi5+T61Qa++OrmChfeQvcdWtaalYdvs
	 kfl0/wIY7MiFJRj0fySk1ugnLX8Dj0XWeU1fERm8+zhXUn8S+DGuJw1U7+ndMeM5ti9J7
	 KAD88Bu/ydke+4xA1ZWfY4O1G7izJwT4VzxUgQy4OmavgXsPS4397SX3rPY10sRAOYQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792565026;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=BshkmCpZ/CgMhn+t72chtvtd9uDnRbu2WURcbL8WmiQ=;
	b=eObV3Um5fqMbrabZO2mMPswxgb3X54bV/0tbi+Tepi5TLHyVfBZTOl8EBqmEZYozuxRE
	 luRV0MoqyB7yIS65SPBT31MhD2u+ljaTAvnlDO+v4cMt4433sWHuzfA1IRobLCzgEAsFx
	 kSUwCGjQR17GdnyZWpSU8oziZSSXk7yj7i3h+kfwHX7sWP8ebtMTpdDICtyYjFmZp9T0e
	 SsR1fG4dy0veV8ch74RDxUrsXwbc19AKI+rNQb6MP5hMkUtnD49MOs0CKt+EJftSI+OQH
	 PYQr8CzLKCAIzYK71eVy0r8D5Vb3M/ZvtdWX9vXkzDQ3QjsMsS1Jdoo+lR7mStd6u8A==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LTH+emHM;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ShbCTrdg;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792565026;
	bh=BshkmCpZ/CgMhn+t72chtvtd9uDnRbu2WURcbL8WmiQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GZBLbCZpoGmM33bS5gsO9zHrJrWUwsZtbQjkBAjbLAOAzaZYafrw7lHGPE1c8Sn6+
	 trvfW6BSGiAGlsTGJga0GhTYZM95I5YyXqJ75/ZKlazQqm/TcXePp4R+7RbBU/oBq0
	 mDJF8SInVWo3qwnaQkVzQnSQ0RirdbYhDZxF1vP7sMVvrrID70RKpkYk/3pj+fH5HG
	 qUTLTI/b83fpQsy+HcLVoRY5NkYh5cnQe60Q+MnZzRJJ4eLNEkQT1HNydDyBQosf/i
	 Sh95+zuk/aVQlDZggF2tUUb1cZHr/aXagFdj9hLcTx6a3G/q7m23g84GHmUGsFYJ/s
	 MWQ8plIabdAgg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2928480A7B;
	Wed, 21 Oct 2026 06:43:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9400C11CE
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 06:43:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 85EAA808C5
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 06:43:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id p0FsiQwLS719 for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 06:43:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 48B2E80971
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792565024;
 b=hBiPn9RU8wT94pbUhoGvjHXSF7z2yEyCw9+jegAw5bSMe0iz9t/ccQpzetiWT0J/Lge3
 cNXc3vs4PZcnU6AniNcx9rI9NGvDl/9Q7oXeSWn4sMZzNJ30c2W0ahiWPkBjE6D93YwvW
 PdR22IT/NcQoWQ3mvx87QaecHHoWETJ1EHzY9VJxEvbz8L2o5wnQSIujznBdsSMLHGEp+
 DvWxkb3x1OdDY82GQsNfeqrdtdkEO0azUmliVWbsRXiajmbnBTcNu3wZCk+qPOnI8vD0s
 pdqKC0pVU4j5syJbUazaU06DUhxVlFpM58lNmsmH19CstM9eXEgG8d2gaZ468FDwDZA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792565024;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Authority-Analysis:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=BshkmCpZ/CgMhn+t72chtvtd9uDnRbu2WURcbL8WmiQ=;
 b=YmsEvYFI964zK4u3PL5bNmezc+pDADW+Ip2e96iXIecFaz8Sbp2dp6T5flVajmfpljy4
 rLiiImim3Zg2iiHHy+aC2qMmsAueHMYC2ew2qvUHkiAVnHeQx5hVrJAMxK/gQDKBWtGO0
 ep2cBiQ3b0fJleUKTNuW0UfEG1qMxJtzAd9nmONSbsUu4SYT6Qx2s3Sbg6RQIPr02kYwD
 U8y6xcVAr0jy84M5kR6pVSOTNin0Q/XK8JHH73Q46W4XEK0S60WePPUXdig+jVLEgSI+v
 vG5+LKWAjrleom0ByqJcj5bEH34lorFc4BqPi18iJlFkn0ZLpFfgM5yYW+6E2tESQKg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=LTH+emHM; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=ShbCTrdg; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=LTH+emHM; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=ShbCTrdg
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 48B2E80971
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 06:43:42 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69L5j9nc3874614
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 06:43:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 BshkmCpZ/CgMhn+t72chtvtd9uDnRbu2WURcbL8WmiQ=; b=LTH+emHMLC+SxBsw
 l1G8y5m2/t8qc0b4X5eMOKOaMWdTbqM021mZkycLAJToUduRMc1BprViaLAXh7LJ
 Y56ttLkhjt2Bj6sg4kEzc/tUmP+DOayn3fmoPv4A1piiQVc/kHDU6CdrFvxeRgTR
 johcBBff58hXB6n2Frh8x/+jesQKnpFMAevsHfINtOwWBeljLGeVOdHpZLuXVPEm
 JrXL4Z5lNJ8RHOexvJ+/IJ7y00YGDLmyHGaWwxrZkVgyNLcKl7gHszuy8Z7j4x02
 OE3gaWnzkBbi6Lz3gQPqkzoRDj1B/kOstft26LFVpy34pTNu9lnn2IUbV5a2RY9R
 QRn5wg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4heh5r1fsg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 06:43:41 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-341eff9e381so1007334eec.1
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 23:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792565020; x=1793169820;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BshkmCpZ/CgMhn+t72chtvtd9uDnRbu2WURcbL8WmiQ=;
 b=ShbCTrdg3dUTMKtJBl91esBWkKmeFGbNueIBsKDl9jrzXVc4OrxM6P01z314UoHwsV
 VkHaJTjnweZ7Y0jJrPaQQVtHzwniK3O3WImYyjUTgqZfuNEeYrbZ1bASUeQEM5r1J3x4
 UAWI5hhQxUGkTGitmCS73yKGcLqcdKCuQehr8dTyYVsZOun5b1CnPwGu7KUoQL0jBZFV
 RWlWyVtyYJIOzuClGjxVyMy3TpV/k+nxwVWv8uhiybu0R3a0C9qxeNQJH1GNF9YwvXfV
 rblo8sJMPE53kaJKVKfmrptmol98FVZnggH1v2lsjkwbKvCAKISZIJQ+SLwvPbbLDOIe
 qwug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792565020; x=1793169820;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BshkmCpZ/CgMhn+t72chtvtd9uDnRbu2WURcbL8WmiQ=;
 b=Ho3gm9m62waN0Vyrrdtk6hoS0wY6HDUt1tD8eUKH8iONbdkO30hBgnWzBFQCQrr+wi
 BRN1H+JCy9hcC+yTru7Jff0wnfYuUFpwlx9I9idcuvlMu4L0poA7AkU+0vjbioPrl0aY
 SU+CWFmxNG2Z0VqQGmyl4QObNT0ZzpX1MZXvc7nDiZ/V7+QWQJTV9Lta56/IJoGdDwuW
 jbylTOgoUjxl4fmERwmeTVxk6CXC2E5X7ItoKnKrrTlC54rpjNTW8iVjr/KLa66TyJy/
 MTZtzAVO+MzMrUZX5Zla/Hq0PGLG/JZWBgQQX1ZAbTcmcY1etZ/Yzqp9CoeCjhgL9QWu
 v3WA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwuk3ywEvoat5PmYUV5Ox5EfzlbfTB9s+qsut5HHTdjtC+dmDzLixWLVbqYaEBQWrwFXrF6Xt0=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLbr0aE2yLJoxZJvv564Qy9jC8QMx3/ANVeG8y/JWbFTIJayCe6
 R5GviS0eeWgWI21LSPc0R6gVEVU9BOgI54r5Nb42aDcuw1sF4s1fUZJOeYojmsCs9ErAo7+b3Qc
 bzC09acEEO8TG1rQXUY5Z4Mq9cunvG8zusMJ0/EgsPXK0c2bV+9nh3nwjowDJltuCEDcCREo=
X-Gm-Gg: AYBFou1x3JG+0q6TvnouS1j0bju6ckp9zQT5QSqVlO/ayEpWH+mZf944R8FgwVt+MVt
 yAt0Lx9Sn8BetRxXFqcaqYRoBm/jIem1r0oC1eldXB9iWIij3Bat4ugGEVJS03eoZFMRtT73Lxx
 iXMWpEtzBe18nns0Lk5UQw4vq2XX7p8aX/q+uFjZs+2ozBI4wweir4HKGFamHcO/CBOLYcfgLpu
 qvyIvnoLhXGBSMXDYiJ4N35UG2mKwrZLrWGbxfvAg7GjCiGlCcBr0I9BACGqex99QbaFZdMWTTO
 Wu7Wyv3ekfAbRBw9mT64sUn7Q21qjfbzZXAdQh9/1gFmes0xRric22+x8a+JXLiai0PK+f3FC/i
 iX3uorpWBEfmxeMHHyehEtZuJxHr9aI16kl206NcbGtU3pvBTiQ3NKXzqSMBrsgmotGi1OcPKPq
 Urm+3Pra/w+MKdWckDgztoUawnpuEC
X-Received: by 2002:a05:7301:2514:b0:35f:2bc:82d3 with SMTP id
 5a478bee46e88-3674da575cfmr2085984eec.15.1792565020316; 
 Tue, 20 Oct 2026 23:43:40 -0700 (PDT)
X-Received: by 2002:a05:7301:2514:b0:35f:2bc:82d3 with SMTP id
 5a478bee46e88-3674da575cfmr2085960eec.15.1792565019793; 
 Tue, 20 Oct 2026 23:43:39 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-367411bd27dsm4547476eec.17.2026.10.20.23.43.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 23:43:39 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Wed, 21 Oct 2026 12:13:13 +0530
Subject: [PATCH v4 4/5] configs: qcom_qcs8300: Switch to monaco-evk DT and
 enable new drivers
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261021-b4-monaco-v4-4-c90f0c01d312@oss.qualcomm.com>
References: <20261021-b4-monaco-v4-0-c90f0c01d312@oss.qualcomm.com>
In-Reply-To: <20261021-b4-monaco-v4-0-c90f0c01d312@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.u-boot-project.org,
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@nabladev.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Vitalii Skorkin <nikroks@mainlining.org>,
 Biswapriyo Nath <nathbappai@gmail.com>, Johan Jonker <jbx6244@gmail.com>,
 William Bright <william.bright@imd-tec.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792564992; l=806;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=i4eUGjoNUejdgglEQlRUFk4UAXMSKqbCwtIFQmrHRWY=;
 b=8LZJLTnfTsgE1KNhwHRL38WK0qUY3cRucaL9RLZHeeWhvqAG12qGZJCXYC8s136dOcfaV0oTt
 tIhdhUSY5X/ABMcU/1OwR51e8YJFX2/ksOw1Zq5jZ3p33YRDMrvNMAZ
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Authority-Analysis: v=2.4 cv=aI5lOr9m c=1 sm=1 tr=0 ts=6ad85f1d cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=p8VvgLCOea7M2xW4:21 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=uNq1Cg9DbGaxvhqkZz4A:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: Dz_-glrKI_Sz0AF5fOHR7tYKqaKsTjUD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAyNiBTYWx0ZWRfX7NqtbGV9OITg
 kXCvivRpjqguB1aQjM+XjTmbGMsTY7+jAJr5qahQrEz9D8JR8UGKQGVVvo0AFoy0u7Tsm0nJOJe
 XFcaA+Fw06BEVovKGohku1a2JxnUwgldz2W2E+AhyOqD5IGTJS8SPaadSFRlomMt3yVAydZRGJn
 +9z7fYWOg2hxfHJdksJZrInmQpwr3W+lkBsYQtdrbuf4+8EXTa9AcULOwM7NV4AJc4cFZvxOevi
 TpCvbbW+XzPeOvGB6qduTwAoR5B7QOHk8XQEqJmr3rknKIilwu9bnuNd1B+ZYQirUvq9crcXHvY
 x/LQvAhWnPDD9n9ikRuLl+GsyzxgJrfkNUD/ax+8LRX4QmmJHNAwPsRuY4Oatk72gK/Uqt53TPh
 67NDJYhT0Oj9I+RBfjzw9f98sXF6SXT8eO0rqE+qLUsxNkPo2hln0XMoRPiaigMP4E27E4HQ1TC
 qi9o+kS/lem9mJc4lHg==
X-Proofpoint-GUID: Dz_-glrKI_Sz0AF5fOHR7tYKqaKsTjUD
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAyNiBTYWx0ZWRfXzuSbb6MhmtMF
 ZbS2ZS6DbxkZUYET9uN5K4fIuh8w7YR5n5vd9V7LVdT+44IAoHmPz2d/LwANHkJI6Y48yV7HmOe
 /s2KZOsat4GecUNttuibd1OoXptHBe0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-21_02,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 spamscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 adultscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210026
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

Point qcom_qcs8300_defconfig at the monaco-evk device tree and
turn on required drivers.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v4:
- Drop CONFIG_WATCHDOG_AUTOSTART
---
 configs/qcom_qcs8300_defconfig | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/configs/qcom_qcs8300_defconfig b/configs/qcom_qcs8300_defconfig
index 8ff790f2889..80d70ca2858 100644
--- a/configs/qcom_qcs8300_defconfig
+++ b/configs/qcom_qcs8300_defconfig
@@ -18,4 +18,6 @@ CONFIG_DEBUG_UART_CLOCK=14745600
 CONFIG_TEXT_BASE=0xaf000000
 CONFIG_QCOM_GENERATE_MBN=y
 
-CONFIG_DEFAULT_DEVICE_TREE="qcom/qcs8300-ride"
+CONFIG_DEFAULT_DEVICE_TREE="qcom/monaco-evk"
+CONFIG_PINCTRL_QCOM_QCS8300=y
+CONFIG_INTERCONNECT_QCOM_QCS8300=y

-- 
2.34.1

