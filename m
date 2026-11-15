Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB89606A32D
	for <u-boot@archiver.kernel.org>; Sun, 15 Nov 2026 11:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=K4Ga685R;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=DkiIgpyb;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=D5k8r2TO
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 41857406AF;
	Sun, 15 Nov 2026 11:05:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xCLIKvV_q0Ie; Sun, 15 Nov 2026 11:05:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7B169406BC
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794740733;
	b=qlXJPUq4MA9La0y3Al9CbivAgHUvKShxkATObs8MzXbK685sJ0JTLdCRCVhEo0QU018u
	 tvk1L6oGfQyd61uLgldCIx8u+VUR7UGYQwz4ytF6PajB4cEJPtXpDpfzX0rtjK6lTT9qD
	 I3x1R0nWJ3yLoKqN2fZgge2K2kcV2XKV+Pj9czESsu5zIXlhpbI9aGlQE9eEVrXq7VNoj
	 xLybPjLUuBpzoGThDjYhWQxiuHG72/bDaQJcm9SXzTrcW9ZX+6+OPtZ9xwFvaOidrdxkL
	 CjG1uCkLuZiDxW/EMNPN41LAs9E+zc0jwT3IlJY6pLYlw2Dcn131lnPQQZhHkd3qk/w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794740733;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=pwlc3+YP0u8D1morAzQmf+gU0szM6sxv1wd/j5yIBoA=;
	b=sR+5vYlc5s6G6fki+ar59civyQGm2Ffw5zVqc1T9BmlaWY/IeJ8ebeIbWnGm1XUFpGrX
	 VV2hQ9XvWnX2O4e9hKYnF/AVAcMRAF/6xWoaeax+52lhrXzhsvnP4rghf38gf1Fhrtm4D
	 WVzo8dpsfWl8zCjWteG5ynf73agMEuNpvcAh7TlaqtTTOMa26hFJWdv5I56lJFHDI1G3S
	 onI+ugzvJOBq2H3wRMxudz0lvcV+fPfJJ0kuyKysIASKvOJYy3SeMq0zyq+sPdcJk6HFd
	 VDQCrbA7xxNZwgNTYyZZFnlEgD41+/x8p10NZTAB4D1upkE4I3cQ/cjOJWevdU8perg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=DkiIgpyb;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=D5k8r2TO;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794740733;
	bh=pwlc3+YP0u8D1morAzQmf+gU0szM6sxv1wd/j5yIBoA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=K4Ga685R8Y19/0QqiulkiXX4coOVnqJ3+kasvfAc6sO3YygDUiLmYWRcsSt/r8w2Y
	 2/BkjZ+n8hVFDAQaKWPoEgxBgLMHB4qwXPfrolgbeqgVbJe/jk931FySr+0/b9vUNw
	 wS5v55Zh3ifgdb7eliP/VPfb/184JO54W/WPMD1e+GI9uaF7JzNt2EKeE/zHtzRqXS
	 b2nSVl8Y++2OWIxOqtfixoEBT2UAIkU6rZlVEa07iYSN8791sDZvPKSohr4/0kz2SS
	 fHqppQmWhGdCTgqrMkxSr+kne8jpDlzR5WVyFZusDKvm7nmoaRmCRGJYK294elhykO
	 QYO5ruAl5cEnQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7B169406BC;
	Sun, 15 Nov 2026 11:05:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4EE181A6
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 11:05:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 35315406AF
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 11:05:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aagke3Ut2Tzp for <u-boot@lists.u-boot-project.org>;
 Sun, 15 Nov 2026 11:05:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 61E10406BC
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=DkiIgpyb; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=D5k8r2TO
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 61E10406BC
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 11:05:30 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AF7w91C2863240
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 11:05:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 pwlc3+YP0u8D1morAzQmf+gU0szM6sxv1wd/j5yIBoA=; b=DkiIgpybVw4cI5DC
 e5eS3VjHqm0tLDGXUyM2Wic3wi0K2GAfzA4JqYZ1B/yTFISZwT6pT9zPFU2ACuHe
 z3XFFJDR6SpVLv+6SqgA7k9Av98svwsdDnaue9J5ZW/d90bONZcx90lJGGoPoAHe
 XjepnvA01GzIxnmgawYxaHDJ0ICotASf8uR2KS0bn+1qiiD1Dy9cVCsx0jj05n4B
 8CmQFkPMZFG8u8nSfmAXLuuU7uwHltgAWTNLZ1FkoZ4KAb4b5uemW3jlDTAPC8Gy
 3ZuUS07NXfwmxzTlspLh6At7xTvnRSFVAai+lj4pVQA0kYz6x+UunnzTk7nQwQcR
 kiuVDg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhmajs0s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 11:05:29 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-33c35f5ca6cso3734226eec.1
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 03:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794740729; x=1795345529;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pwlc3+YP0u8D1morAzQmf+gU0szM6sxv1wd/j5yIBoA=;
 b=D5k8r2TOcHRDTNeAjPK1fp8kUSC1HDv904QAr7MJs5PG69McRTkzo3n+049K0Z9F/u
 Vbbr1o0lazkzEjd23KG1hML9InKFlIblT9xC04CkJijfeebWP/XtrgZClLdu2KV8U7zc
 pgCc7CdZ2qq0ic3P4F77qAMS44+TaXzukCkUmbnEbvQ1CLh74mQsshC7Gzmo4HPzIMDY
 9xWJg3/E59JHwo1pQ0JHy1lfA8BYuobU84gFe2wvT2oUa62lVg9HVqz3EW0Dblr1Ot27
 ebRoD4Cm3vtFMZVp7rY3vjo3Y5SR2GqLf8udnNYmcvg1UuK6k8DjI6xAE3Gdb3ZqWbQd
 KrtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794740729; x=1795345529;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pwlc3+YP0u8D1morAzQmf+gU0szM6sxv1wd/j5yIBoA=;
 b=aeIVxvDv+mmnv+h6fuFm1gUSSwQNb07kp3ISObzZ6gobX4l4hJ9CsS9z7jdVhIFwyy
 XdVW34FZcSW3d11+R0evhEFUr4zcdnD5qf8oSsKOG7H7bk6BgzsLTOEBQA3hWazpyf7o
 911LuChMMTnzwjafwdkf9iGNRKQfenT5RsW/lNfO0deYkfqYnw9AyQOnsEB16CA5H+3h
 Ih1/uu0EUUlOen9XoaNCf4oTuHGKB4LRXJEXI8+NXByFvcTiojIbyd7uLiKaOtzz0hN/
 /xPJUhKQ+HcstcmfNg3bIkSanWPSEGjWj+WpDFoF5j+22BNmPwtECjTdY4COLBLBM8Ys
 cJvA==
X-Forwarded-Encrypted: i=1;
 AL+hErFV5EZ4rey3vuiIKwP3Ob6k3THxh2wt+ThkXXFpEHcEyH4pYWIlLdOYPQcUlkhV25sxesly8nY=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+ru63uDflmK+FDO4JTEcDs7VGHfb1W1z9iCdtxuZwV0A5LrjYR
 IYfb98sgZp36BgI77/0sbEknjihXtQktv0ZJ5bJ5lui9lPbb53YXXII2GIZeUxyzt8xwgn+mfjm
 I6z6FROyZK42bZr2RaEeFt3J+EDgfmS0LDQOBprZob2vR5r+Ka5SfYTDBAa4stMBTa/3CosE=
X-Gm-Gg: AYBFou2GaCSBfk00nSVaQ6//5W0iXXcP7HorCoFs8ipntZNLnz5LgWu3XURjRj13Jsu
 UYvi3ayxaoN8wE8hiA4cB9mSKqaRRZjaMNvARlGRAhYvLKknc5XsxK9/o+oyk4fSixv4fjaiRSu
 8BxAxRmve5fqAUXPTDc8zlaP5uKfWTKMV8wJzgBkw/dAvt/89s/nAo0Y9NnKZ81nxt0SCa7dinX
 caIUl7DJPhxbH1RaozwCiuRxF8+2NeK0bGss0t4u9ScJRiJ8AdsftRcyAB0dDBRwD3m3xZd+d4R
 e2M1qSNpb9DQIQtl/pZYdzYOsr3zQR8409vyxpo7C2xSEEdmjaA/yoR60wb1N0kNCUL0AQIxzWx
 WI8JbB9zoIBF5RFfGIPJn4aM0on1NZTrgcrZ+gi2Vjs0dW2gbclexVvrk4c96tsnPi0686ly4Ru
 io65bsEUncFOEIqsv3dbSS8Xxe48j077zH5WhvOL9fumthKBbVSp51KFJEtJ3ObbxAcA3IhmJ+F
 Yxd
X-Received: by 2002:a05:7301:fc09:b0:36e:b3e6:ebe7 with SMTP id
 5a478bee46e88-37966a58499mr7114546eec.26.1794740728484; 
 Sun, 15 Nov 2026 03:05:28 -0800 (PST)
X-Received: by 2002:a05:7301:fc09:b0:36e:b3e6:ebe7 with SMTP id
 5a478bee46e88-37966a58499mr7114515eec.26.1794740727910; 
 Sun, 15 Nov 2026 03:05:27 -0800 (PST)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-379563e6b6dsm43456454eec.21.2026.11.15.03.05.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Nov 2026 03:05:27 -0800 (PST)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Sun, 15 Nov 2026 16:35:09 +0530
Subject: [PATCH v3 2/6] fastboot: block: Add device selection syntax
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261115-fb_gpt-v3-2-7ddd7ef832f6@oss.qualcomm.com>
References: <20261115-fb_gpt-v3-0-7ddd7ef832f6@oss.qualcomm.com>
In-Reply-To: <20261115-fb_gpt-v3-0-7ddd7ef832f6@oss.qualcomm.com>
To: Guillaume La Roque <glaroque@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 u-boot@lists.u-boot-project.org,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Cc: Tom Rini <trini@konsulko.com>, Carlo Caione <ccaione@baylibre.com>,
 Dmitrii Merkurev <dimorinny@google.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Julien Masson <jmasson@baylibre.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>,
 Simon Glass <sjg@chromium.org>, Sam Day <me@samcday.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Francois Berder <fberder@outlook.fr>,
 Vitor Sato Eschholz <vsatoes@baylibre.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794740710; l=3038;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=V20BuzV7ddb73kFkdyU+QcvuB099RqL4rA1fUINnunY=;
 b=tJyk4VL6zj928IldNXmjG79WPpiKFNmxQTZ280vtTkq/AVdrvc/crsdaYqcIWaXBIgRE8SBJf
 JocSfoSvXzKA7McvPBTC5wvyxtKK23Lkeg4p9kJL4ViyHTfKkIJoh1y
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-ORIG-GUID: q6CJNOvlozpNCI3_llpj54hdwW0VEJy1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE1MDA0MyBTYWx0ZWRfX7DJWxdrfQFYQ
 yOSNrl8Mv4FYdQKES6AD7E6xLkQeO8WWQUbTyVUziLU4OzxsB9AH8+LVjMR57WvissNnFcnhyB4
 uysbz0mlSNc+eEN51DTIoGYGuy2MrNSD4IIkx4eCRQvXmAUwl9YYIJY1JDEnbZUnsZHvEmlNtdS
 O8nZE99e4/TaIyn4To72XyaWAszWwnGL18TehYH6PsbEHf41Jm54expvD69khIjOFl7hB7/OJmz
 R8ydJzpv2EMrgeWareENC9MIpBibCSk4TltVRh3IKSY47mKZylZHtqtyGegD1FgxQnSonHC8lXc
 QjBqCUDP8YRD+9oKXUKDA8/jABX4YzMshWdAweyTKH+UKVC3UWBXUt9KXh/PJlmzHebqV2G4X8D
 Ul2Bb/awe5N+sOXEJwpjOdxZ5ulfF0Ftdb/j27Lt6D7XISmGVXCP0cR/BTGQIg/8SWbBkc1OHXZ
 Mjhqf/Gs+vdaRTKvSqw==
X-Authority-Analysis: v=2.4 cv=NdhzRGD4 c=1 sm=1 tr=0 ts=6af991f9 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=ZNc5tQh6qhnnpm2zjycA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: q6CJNOvlozpNCI3_llpj54hdwW0VEJy1
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE1MDA0MyBTYWx0ZWRfX578RXQg171xj
 OqPDpuiveGMKUqRVaPReM7KRf6Qc1xWBXsz4Iw9Zb8QZXsgZxilHjgUGdow6LX6FaMQvsDGV7TU
 mVlSSL41gFGm4QS4a7u1tyzH4Eu9IZc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-15_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 spamscore=0 impostorscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611150043
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

The block backend can only look up partitions by name on the device
set by CONFIG_FASTBOOT_FLASH_BLOCK_DEVICE_ID, so a board with more
than one device on the configured interface cannot flash or erase
partitions on the others.

Do the same as the MMC backend: look up the name on the default
device first, and if that fails, hand it to
part_get_info_by_dev_and_name_or_num(). This accepts "<dev>#<partname>"
to select a partition by name and "<dev>:<partnum>" to select it by
number, the same syntax used elsewhere in the disk layer. Since
fastboot_block_get_part_info() is shared by flash, erase and getvar,
all of them accept the new forms.

Example usage:
  fastboot flash 1#boot boot.img  # partition "boot" on device 1
  fastboot erase 1:3              # partition 3 on device 1
  fastboot flash boot boot.img    # partition "boot" on the default device

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v3:
- Use '#' for name lookup to match the disk layer, instead of ':'
- Use part_get_info_by_dev_and_name_or_num() instead of a local parser,
  as fb_mmc.c does
- Move the NULL check fix to a separate patch
- Mention erase and getvar in the commit message

Changes in v2:
- Newly created in v2
- Has only device selection syntax related changes
---
 drivers/fastboot/fb_block.c | 12 ++++++++----
 include/fb_block.h          |  4 ++++
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/fastboot/fb_block.c b/drivers/fastboot/fb_block.c
index 16b94b8a0b2..fb0face0429 100644
--- a/drivers/fastboot/fb_block.c
+++ b/drivers/fastboot/fb_block.c
@@ -146,13 +146,17 @@ int fastboot_block_get_part_info(const char *part_name,
 		return -EINVAL;
 	}
 
+	/* First try a partition name on the default device */
 	*dev_desc = blk_get_dev(interface, device);
-	if (!*dev_desc) {
-		fastboot_fail("no such device", response);
-		return -ENODEV;
+	if (*dev_desc) {
+		ret = part_get_info_by_name(*dev_desc, part_name, part_info);
+		if (ret >= 0)
+			return ret;
 	}
 
-	ret = part_get_info_by_name(*dev_desc, part_name, part_info);
+	/* Then try <dev>#<partname> or <dev>:<partnum> */
+	ret = part_get_info_by_dev_and_name_or_num(interface, part_name,
+						   dev_desc, part_info, true);
 	if (ret < 0)
 		fastboot_fail("failed to get partition info", response);
 
diff --git a/include/fb_block.h b/include/fb_block.h
index 189c708e2f0..f60cd3d9635 100644
--- a/include/fb_block.h
+++ b/include/fb_block.h
@@ -12,6 +12,10 @@ struct disk_partition;
 /**
  * fastboot_block_get_part_info() - Lookup block partition by name
  *
+ * The partition is first looked up by name on the default device. If that
+ * fails, @part_name is parsed as "<dev>#<partname>" or "<dev>:<partnum>",
+ * as done by part_get_info_by_dev_and_name_or_num().
+ *
  * @part_name: Named partition to lookup
  * @dev_desc: Pointer to returned blk_desc pointer
  * @part_info: Pointer to returned struct disk_partition

-- 
2.34.1

