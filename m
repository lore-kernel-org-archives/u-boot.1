Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D294CA9ED6
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 05:35:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 584086071B;
	Mon, 12 Oct 2026 05:35:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Jmjel9q3O9in; Mon, 12 Oct 2026 05:35:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 48591606EF
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791783312;
	b=U6GMi5RviE5+Db479vEAuve3vi0qBfVDF4HsHRvE3GtPmqc5zDv3lexC7uh3QxhZVBYw
	 n+yLfAbTQ1m3SooUwr2HDx8DSsgrrTGPgv18bV09aLKDbR7V7rciYRjVxKKQdqCMxL7Fz
	 QLWwAshv/Si7HEyFtDw7AFKtaBBuNHoZTjtkPmdlOfbVnFdiBzNyi9E7tF/sfgqiyinP6
	 gHUTglSUglW3dOAZ3upQe4Qd00sW9kiGtRmhqzRRKvvQ8NvyH6hmWfx1qaDKE2Fmwwk6l
	 4CFVvCPJ2TSNdO9U2xe6QCGvKrgsTdnRugSq3App+ID+N1bE2MmTQA3kEn5RUJdW34w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791783312;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=6tCREOKYDTfhvuzey1in6iO8z4m/J2F6Nthv4/X+YuQ=;
	b=KpM3430F9P7B6ITMLfM1H2zua55ABX70NLIX65kv156YlECd723TexeNn1XwoBU0NCqK
	 wt2E7YkZoIWLmP+nWhEBFaMjizRlTQ9hsMMat7vuAl2mRGbT1AqJphxxy051QjyAVPsp0
	 jww2bRrh3/xuzlkvWVBbY9eRPYm8Wgsk+pEJBcmkSbdiHI8Ek1guq8FO7AyMNzpAh0I/B
	 kFf9Olza/4ANoR+UFZDinz46WiCqhn1hWOQtcr5/gZV6qWjIHgyFMWQx4Xk6VHx1O6KTY
	 W953MhBOcr2L7CARcvkbwGJMrxbn8L8GHnTXIV0x5eyaQLNNo1jRTRGtgh07hQ5B8mQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791783312;
	bh=6tCREOKYDTfhvuzey1in6iO8z4m/J2F6Nthv4/X+YuQ=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=C3rDhceVhf+nvKE3Wo/EA4rsc1wVa1D4KdvZQalaat7EkKsiGGLJKwnA8qyGhx416
	 Mn37kRefcCSXwr/tPOn1Vzz7PtnFYpkIj2agq4mU4WHpJOV9lc3sONVXKdmOLTkqWo
	 ekmebBlspZBXpZ/BsqrqqdeXy5y/pmTc3O0xsC0G5Jwm8K0Cat8XH4b1m+pxHHW6dq
	 HEmXEYj02ecB3yE4Nw1Zt7X5tx00XIcTMhb1d33osrbE82uv+cfOYJxLemo9H/YnL9
	 96hAkvwu+k7lyeut5EDccFr8/CVwOVL+EHpwOVVcQMTaNlvIR0oorz1gEHfSLhddd/
	 M16UupxHSyHxw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 48591606EF;
	Mon, 12 Oct 2026 05:35:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id AC4C59DF
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 05:35:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9DE4180CD8
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 05:35:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id k2ZdP68fUZ9j for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 05:35:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org ABC6A807EF
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791783303;
 b=NogPUYjETE8ANrkPWOMuSD+P/xbGt+thN+bWEEChpRgjqc//XtrWie1wBonipNm9H4vJ
 MmBbmjYlQtAzPEpeyy6ZlCSqyKb134nYwPKnzJkxQUTUsGTkJ2EPqk4QTbf/DQyCH5EAT
 DRnNbqnEyaz0ST6Dd5st+2mhAtRt7rlcxIO6gnymnZ/Zrn4VHCtYGjQ+QoxODxFz1dUVX
 IavyllAW2MJkubsVAe1uhc2cFezCmwMyR1YsaPKWIItBNa8uj/4LDW/k2kyydpIU+cySf
 b4RfXcanB0zeVqYxyFGJW/5ogZFq42FhiVhp55O2Zb0E+SyVoI4cfEqxFl9vclMIrJg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791783303;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=6tCREOKYDTfhvuzey1in6iO8z4m/J2F6Nthv4/X+YuQ=;
 b=WUpsjeOR6pnyDZ/Yh+hOvSnv3U8IPAi9LeQdnxQ6WWp6GSEeJpRJbdgKk999HJYTgnyz
 zmT/bIM6XoQ4tQh99Ju5jGdxrKF3XsF81gDbeiHDfCbDuUm9REWc7d3ooQko2FTPOlBfu
 SZ6VvkexUkNCFk0Xpe6Z8TnyaDvZ1uPL8RqKQPrhr34xxPL364eDdPNILXTbaFJNQS210
 Iehh8t92EOB2a852k8lIb8ny8lFS9GVsEGa3SS1Ve+/5dS4VhOhMiiog9TyZbHQDYBTWL
 ttOW1BJmZIAol/welCA8VAqyfMZAf4ZEySU/fb8i8mUknLdM0nfgCe+1Kk8XT/lmURQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=COl2Sjtd; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=khYDA+C3; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=abhilash.v@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=COl2Sjtd; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=khYDA+C3
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id ABC6A807EF
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 05:35:03 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69C55qSm303001
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 05:35:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=6tCREOKYDTf
 hvuzey1in6iO8z4m/J2F6Nthv4/X+YuQ=; b=COl2SjtdeZB3OLIQG2FQ2I9YBqu
 6fODn+utxMNaJXh3SOiE6zxU4sGWu4tzu3CBYPV91opIiRD+CFIJgVvw7IqdrCVZ
 dYN2g42lwWBOp5uIfEY1axJWrbrVLX76VnGC/Ll7t1gDoGU3RJxs5FrmPTRIzlmu
 FB3ks+9X0l5kOnOeC/9LcbeAtOvbVDaofQ13CS4jebXfMwt16/EZFblegis9GqPZ
 12IEova/Lw2J1F5hnveAhGv0h3sFpqGMXHPhhGCw+3jKAh7DvP+CPuQ2jEPgqYiJ
 8WSyj8x78A4h6E7JaREEL9Snzu3MUuzl3q0G2V6iVLe4oz681FH2uKSFYxA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8j6dh2ut-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 05:35:02 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-351788121cfso3305927eec.0
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791783301; x=1792388101;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=6tCREOKYDTfhvuzey1in6iO8z4m/J2F6Nthv4/X+YuQ=;
 b=khYDA+C3kQ4vP4m123AvX8HUN4/vhXFgOe3WuoXVuJjpwieyvBa5OXDxBasQ2rWYRp
 Bd6YYiMs1aBQdzPMq/45KfZ/2b64ZC3yktUH0S9XmQYp2GoPad424nN4ZCFI0lqtQC7o
 ehn6Q4WgkWPCQEVoYkdUlc5dW9ZLU0rV1RXa/rV9VOXMN8Am9UVtI87W5oMcXSn0Uisf
 sQpYSJjqwro37UxQ1GGdIXMG3D2rrd3QgvX1c5ehUv6KopVrtuVCYb2XKaWGhAehsdoH
 uWHRYiq0g6yxirHIlbgjVRDVJb9FuUN6OO7LjKeUv0ldMn/959Q7VNvbifPTOb26mI9g
 yF5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791783301; x=1792388101;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=6tCREOKYDTfhvuzey1in6iO8z4m/J2F6Nthv4/X+YuQ=;
 b=KFz5JnynD47mGuYb1OpI73xsjxyRh5OhnfZ5iGqQCNm0d/Kd/UfYDEQ0XLjOL62akp
 eKQFZ3lXJSP5AklZjf8gSY/XYgxEC2NB1K3+d8SxPHpGPiMybjmzevt+pSiJkrKE7lZR
 m2CLJt42oQBI48/IIka/eVdr4FF+0ElVtDm4y7tGV3BtPQsfa524h8xQLFEbg1gQQCb1
 qWzLwdqtBQ9LrPBMZimHtOooh/cxmj6o7Sx/JIr9vlgbYjqaAQ2L1ZK3Xbn3q9CMZ9AK
 S7SKewJctEUXQK8wCoR0mYHcoI6LCYEQtqrowTSPsX/g8xW5Lyb6GzsnuoRFSz7isKy7
 ZRnQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxWrCQftkfMsvfDiZbevCp4zMX73WTc6zyx/lcX5Fu6vk5ZuCaR7/fli7hDVZu2WbhYLj/QKP0=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJ71k6E8ix3+/SGRTht18/BMtm9LMDNbV8A1JaEeJWZrOTSLqE/
 37wKfcYSax/aTcqk6HCEqNNJfwKBX8POQSfPREhNpdH3DnUdhAPJNuJHm/pK9XiIl1c+Wty7Ff9
 r92XDuksDv72m9KmrPtuq2bEX6mqLYtikIJE+LzRrHYfyQEoKOQ+GHvqgTOhkPaPcE/O20yo=
X-Gm-Gg: AYBFou35veY55tPbYxdCNhsHdRwyvjH3kwwKXb/76Dt0pToD9YC3EwdQGYitbqIBIog
 MDiPCsbY3kI3vVPdNkHUiWaBioBtz+wmXVlLN+yATDgMa6itA7xxpAEG179Gn1xrPwxV1SkplqM
 lBf8TZVJx6dwrNgcWzspHgmxdwh27FIq/fBp6IPqvGD96OTAQhccE7ezCrYgUYzBzzictLzxSUT
 gsqlUnGw1vVVO1ck3aiJY/fSxr1ZF1UMHi0LweQzoBKKWBt1v7iA520JhmNykYfZZbL6+JOSUux
 NEV7mc7j+0JWbbEux+b62/zyWChEkS9LtL8bgo98a6Mvs+ztUjAHL1ryLk7vDjx2CSb2P85rm/S
 o4lbePeXxcaNx6eIpGiwhJdbVU6jXtC8rmfLGB/zmPpRADDt1
X-Received: by 2002:a05:7300:8806:b0:34e:f5c3:96a with SMTP id
 5a478bee46e88-3537e0a9a67mr14884803eec.39.1791783301000; 
 Sun, 11 Oct 2026 22:35:01 -0700 (PDT)
X-Received: by 2002:a05:7300:8806:b0:34e:f5c3:96a with SMTP id
 5a478bee46e88-3537e0a9a67mr14884751eec.39.1791783300335; 
 Sun, 11 Oct 2026 22:35:00 -0700 (PDT)
Received: from hu-abhiv-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537cab27d5sm33446935eec.17.2026.10.11.22.34.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2026 22:34:59 -0700 (PDT)
From: Abhilash V <abhilash.v@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org,
 aswin.murugan@oss.qualcomm.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, lukma@nabladev.com,
 peng.fan@nxp.com, jh80.chung@samsung.com, tanmay.kathpalia@altera.com,
 abhilash.v@oss.qualcomm.com, sjg@chromium.org, Michael.Srba@seznam.cz,
 balaji.selvanathan@oss.qualcomm.com,
 varadarajan.narayanan@oss.qualcomm.com, luca.weiss@fairphone.com,
 nathbappai@gmail.com, jbx6244@gmail.com,
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: [PATCH v1 03/13] board: qualcomm: shikra: add SPL board support
Date: Sun, 11 Oct 2026 22:34:42 -0700
Message-Id: <20261012053452.1567885-4-abhilash.v@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261012053452.1567885-1-abhilash.v@oss.qualcomm.com>
References: <20261012053452.1567885-1-abhilash.v@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDAyMSBTYWx0ZWRfXx8W+iiIgeOM1
 lTCSMMfFQnQYpEfS2qPQnFe0PipWw1Ic24uYnvAn0EL5dF5njTazq4DcQvHpdHLa0/qJp5PXS66
 1JLnlq75ySfEy9rzTkpOCv73Os+W1pjiDoj3pXDCkl51pU3QiR326mOVsRGzrATVbkGAceG72Ej
 K6bNgX6His+iNy844242zlJm7GNZx+rUgs2j8/xgyEOs3gyPUwFKwE+/kGEoIqF+4iOMUU3jonL
 cVO+K6ZB8UAzBdhRn/79qbhXQzXcIYBAJS3Y0mF0jB+FQWDBe8gNwcrSSIUM+VkKgAdJJW+udsP
 13qIqA5yMDYVd7BUp6/5i1ymDDqlJG8yWjqlSHmWI898VA/znk3Z9j+ohgB6y5eAb0cnrsotzqr
 +Yo5XG/64y0zThJm9czH10XIWnHFXI0oEH8nItAqJ2D2W7bUOD2j8wpdtJUBE/e1gAw0Q0h/o7g
 hKvf/sRwWFCZpHHr7Xw==
X-Authority-Analysis: v=2.4 cv=aK5lOr9m c=1 sm=1 tr=0 ts=6acc7186 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=hzPBnW3WXoijDYWl_3cA:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: 7fTmrO_sZzklt0_p7rz0x9b6-xzEzKff
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDAyMSBTYWx0ZWRfXzTnRMkIU8IUL
 2Ov5dSqlkWWYOEGcZDMQEtYxud8de8pi343eJw1zyIS40qKCVjInWZHVveaCENO5a8h0Hyhkf+Y
 UttP2f3lL0Hq06xwiK6DzYdc94XoBx4=
X-Proofpoint-ORIG-GUID: 7fTmrO_sZzklt0_p7rz0x9b6-xzEzKff
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_02,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 impostorscore=0 spamscore=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120021
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Add the Shikra SPL board implementation, build rules, linker
wrapper, and board configuration header. Configure QCLIB
handoff data, early reset handling, and MMC boot-device and
partition selection.

Signed-off-by: Abhilash V <abhilash.v@oss.qualcomm.com>
---
 arch/arm/mach-snapdragon/board_spl.c          |   4 +-
 board/qualcomm/shikra/Makefile                |   3 +
 board/qualcomm/shikra/shikra-spl-wrap-elf.lds |  18 ++
 board/qualcomm/shikra/spl-shikra.c            | 202 ++++++++++++++++++
 include/configs/shikra.h                      |  11 +
 5 files changed, 236 insertions(+), 2 deletions(-)
 create mode 100644 board/qualcomm/shikra/Makefile
 create mode 100644 board/qualcomm/shikra/shikra-spl-wrap-elf.lds
 create mode 100644 board/qualcomm/shikra/spl-shikra.c
 create mode 100644 include/configs/shikra.h

diff --git a/arch/arm/mach-snapdragon/board_spl.c b/arch/arm/mach-snapdragon/board_spl.c
index 5aa84a3a6d1..dcc81d5a17d 100644
--- a/arch/arm/mach-snapdragon/board_spl.c
+++ b/arch/arm/mach-snapdragon/board_spl.c
@@ -99,13 +99,13 @@ u32 spl_mmc_boot_mode(struct mmc *mmc, const u32 boot_device)
  *
  * Return: Partition number to boot from, or default partition on error
  */
-int __weak spl_mmc_boot_partition(const u32 boot_device)
+int __weak spl_mmc_boot_partition(struct mmc *mmc, const u32 boot_device)
 {
 	int p_no;
 	struct blk_desc *desc;
 	struct disk_partition info;
 
-	desc = blk_get_devnum_by_uclass_id(UCLASS_MMC, 0);
+	desc = mmc_get_blk_desc(mmc);
 	if (!desc) {
 		pr_err("%s: Block device not found\n", __func__);
 		return -ENODEV;
diff --git a/board/qualcomm/shikra/Makefile b/board/qualcomm/shikra/Makefile
new file mode 100644
index 00000000000..eb3961a3ead
--- /dev/null
+++ b/board/qualcomm/shikra/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+obj-$(CONFIG_SPL) := spl-shikra.o
diff --git a/board/qualcomm/shikra/shikra-spl-wrap-elf.lds b/board/qualcomm/shikra/shikra-spl-wrap-elf.lds
new file mode 100644
index 00000000000..b2922cd2c2c
--- /dev/null
+++ b/board/qualcomm/shikra/shikra-spl-wrap-elf.lds
@@ -0,0 +1,18 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-only
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+PHDRS {
+	ptype PT_LOAD FLAGS(0x7);
+}
+
+ENTRY(_entry)
+
+SECTIONS {
+	. = CONFIG_PLATFORM_ELFENTRY;
+	_entry = . ;
+	data : {
+		*(.data)
+		. = ALIGN(4);
+	} :ptype
+}
diff --git a/board/qualcomm/shikra/spl-shikra.c b/board/qualcomm/shikra/spl-shikra.c
new file mode 100644
index 00000000000..99bb670bdf5
--- /dev/null
+++ b/board/qualcomm/shikra/spl-shikra.c
@@ -0,0 +1,202 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+#include <blk.h>
+#include <asm/io.h>
+#include <dm/uclass.h>
+#include <linux/err.h>
+#include <linux/string.h>
+#include <mach/qclib.h>
+#include <mach/spl.h>
+#include <part.h>
+#include <spl.h>
+
+#define IPQ_SPL_BOOTCFG_REG_ADDR	0x1B46070
+#define IPQ_SPL_BOOTCFG_DEV_MASK	GENMASK(5, 1)
+#define IPQ_SPL_BOOTCFG_DEV_SHFT	0x1
+
+#define SHIKRA_DDR_INFORMATION		"ddr_information"
+#define SHIKRA_DDR_TRAINING_DATA	"ddr_training_data"
+#define SHIKRA_DDR_SR_EXIT		"ddr_sr_exit"
+#define SHIKRA_PMIC_COCOS		"pmic_cocos"
+#define SHIKRA_PMIC_WAILUA		"pmic_wailua"
+#define SHIKRA_DCB_LP4			"dcb_lp4"
+#define SHIKRA_DCB_LP5			"dcb_lp5"
+#define SHIKRA_ECC			"ecc"
+
+#define SHIKRA_DDR_TRAINING_DATA_ADDR	0x0c368000
+#define SHIKRA_DDR_TRAINING_DATA_SIZE	0x8000
+#define SHIKRA_PMIC_COCOS_SIZE		0xbc00
+#define SHIKRA_PMIC_WAILUA_SIZE	0x6000
+#define SHIKRA_DCB_LP4_SIZE		0x4800
+#define SHIKRA_DCB_LP5_SIZE		0x4800
+#define SHIKRA_ECC_SIZE			0x400
+
+#define SHIKRA_SHRM2_SPROC_CTRL_ADDR			0x0c36000
+#define SHIKRA_SHRM2_SPROC_CTRL_CORE_SW_RESET_BMSK	BIT(1)
+#define SHIKRA_SHRM2_SPROC_CTRL_DEBUG_SW_RESET_BMSK	BIT(3)
+
+/* GCC_APCS_MISC contains the RPM reset control bit. */
+#define SHIKRA_GCC_APCS_MISC_ADDR			0x01491000
+#define SHIKRA_GCC_APCS_MISC_RPM_RESET_BMSK		BIT(0)
+
+#define SHIKRA_RPM_STAGING_ADDR			0x04690000
+#define SHIKRA_RPM_STAGING_SIZE			0x1363c
+
+#define QCOM_SPL_FIT_IMG_PARTITION	"uefi_a"
+
+enum {
+	IPQ_SPL_BOOTCFG_DEV_MMC = 0x0,
+	IPQ_SPL_BOOTCFG_DEV_SD_EMMC	= 0x1,
+	IPQ_SPL_BOOTCFG_DEV_EDL		= 0x2,
+	IPQ_SPL_BOOTCFG_DEV_NAND	= 0x3,
+	IPQ_SPL_BOOTCFG_DEV_EMMC_SD		= 0x4,
+	IPQ_SPL_BOOTCFG_DEV_MAX
+};
+
+int qcom_spl_soc_qclib_override(struct interface_table *table,
+				const void *fit, int images_node)
+{
+	static const struct {
+		const char *name;
+		u32 size;
+	} fit_blobs[] = {
+		{ SHIKRA_PMIC_COCOS, SHIKRA_PMIC_COCOS_SIZE },
+		{ SHIKRA_PMIC_WAILUA, SHIKRA_PMIC_WAILUA_SIZE },
+		{ SHIKRA_DCB_LP4, SHIKRA_DCB_LP4_SIZE },
+		{ SHIKRA_DCB_LP5, SHIKRA_DCB_LP5_SIZE },
+		{ SHIKRA_ECC, SHIKRA_ECC_SIZE },
+	};
+	uint i;
+	int ret;
+
+	table->global_attributes |= QCLIB_GA_ENABLE_UART_LOGGING;
+	for (i = 0; i < ARRAY_SIZE(fit_blobs); i++) {
+		ret = qclib_add_iftbl_fit_blob(table, fit, images_node,
+					       fit_blobs[i].name, fit_blobs[i].size);
+		if (ret)
+			return ret;
+	}
+
+	ret = qclib_add_iftbl_entry(table, SHIKRA_DDR_TRAINING_DATA,
+				    SHIKRA_DDR_TRAINING_DATA_ADDR,
+				    SHIKRA_DDR_TRAINING_DATA_SIZE);
+	if (ret)
+		return ret;
+	ret = qclib_add_iftbl_entry(table, SHIKRA_DDR_INFORMATION, 0, 0);
+	if (ret)
+		return ret;
+
+	return qclib_add_iftbl_entry(table, SHIKRA_DDR_SR_EXIT, 0, 0);
+}
+
+void qcom_spl_soc_shrm_reset(void)
+{
+	writel(SHIKRA_SHRM2_SPROC_CTRL_DEBUG_SW_RESET_BMSK |
+	       SHIKRA_SHRM2_SPROC_CTRL_CORE_SW_RESET_BMSK,
+	       (void *)SHIKRA_SHRM2_SPROC_CTRL_ADDR);
+	writel(SHIKRA_SHRM2_SPROC_CTRL_CORE_SW_RESET_BMSK,
+	       (void *)SHIKRA_SHRM2_SPROC_CTRL_ADDR);
+	writel(0, (void *)SHIKRA_SHRM2_SPROC_CTRL_ADDR);
+}
+
+int qcom_spl_soc_pre_qclib_routine(void)
+{
+	qcom_spl_soc_shrm_reset();
+
+	return 0;
+}
+
+void qcom_spl_soc_rpm_reset(void)
+{
+	clrbits_le32((void *)SHIKRA_GCC_APCS_MISC_ADDR,
+		     SHIKRA_GCC_APCS_MISC_RPM_RESET_BMSK);
+}
+
+int spl_check_board_image(struct spl_image_info *spl_image,
+			  const struct spl_boot_device *bootdev)
+{
+	qcom_spl_soc_rpm_reset();
+
+	return 0;
+}
+
+int qcom_spl_soc_post_qclib_routine(struct interface_table *table)
+{
+	struct interface_table_entry entry;
+	int ret;
+
+	/*
+	 * Clear the full memory region reserved for the RPM image before loading
+	 * the post-DDR FIT, including its zero-initialized data.
+	 */
+	memset((void *)SHIKRA_RPM_STAGING_ADDR, 0, SHIKRA_RPM_STAGING_SIZE);
+
+	ret = qcom_spl_get_iftbl_entry_by_name(table, SHIKRA_DDR_SR_EXIT,
+					       &entry);
+	if (ret)
+		return ret;
+
+	qclib_set_ddr_sr_exit_address(entry.address);
+	return 0;
+}
+
+int spl_mmc_boot_partition(struct mmc *mmc, const u32 boot_device)
+{
+	struct blk_desc *desc;
+	struct disk_partition info;
+	int partition;
+
+	if (!IS_ENABLED(CONFIG_MMC))
+		return -ENOSYS;
+
+	desc = mmc_get_blk_desc(mmc);
+	if (!desc)
+		return -ENODEV;
+
+	partition = part_get_info_by_name(desc, QCOM_SPL_FIT_IMG_PARTITION,
+					  &info);
+	if (partition < 0)
+		return -ENOENT;
+
+	return partition;
+}
+
+/**
+ * spl_boot_device() - Get the boot device.
+ *
+ * Return: U-Boot boot device identifier, or -EINVAL if the device is invalid.
+ */
+u32 spl_boot_device(void)
+{
+	u8 boot_device_cfg =
+	(readl(IPQ_SPL_BOOTCFG_REG_ADDR) & IPQ_SPL_BOOTCFG_DEV_MASK) >>
+	IPQ_SPL_BOOTCFG_DEV_SHFT;
+	u32 boot_device_smem;
+
+	switch (boot_device_cfg) {
+	case IPQ_SPL_BOOTCFG_DEV_MMC:
+		boot_device_smem = BOOT_DEVICE_MMC1;
+		printf("Selected boot device: MMC\n");
+		break;
+	case IPQ_SPL_BOOTCFG_DEV_SD_EMMC:
+		boot_device_smem = BOOT_DEVICE_MMC2;
+		printf("Selected boot device: SD MMC\n");
+		break;
+	case IPQ_SPL_BOOTCFG_DEV_EDL:
+		boot_device_smem = BOOT_DEVICE_USB;
+		printf("Selected boot device: SPI-NAND\n");
+		break;
+	case IPQ_SPL_BOOTCFG_DEV_NAND:
+		boot_device_smem = BOOT_DEVICE_NAND;
+		printf("Selected boot device: SPI-NAND\n");
+		break;
+	default:
+		pr_err("Invalid boot device configured: %d\n",
+		       boot_device_cfg);
+		return -EINVAL;
+	}
+
+	return boot_device_smem;
+}
diff --git a/include/configs/shikra.h b/include/configs/shikra.h
new file mode 100644
index 00000000000..7d88dc0e670
--- /dev/null
+++ b/include/configs/shikra.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef __CONFIGS_SHIKRA_H
+#define __CONFIGS_SHIKRA_H
+
+#include <linux/sizes.h>
+
+#endif
-- 
2.34.1

