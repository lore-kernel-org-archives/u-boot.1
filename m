Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B382CA9EC5
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 01:53:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 21D81605DF;
	Tue, 13 Oct 2026 01:53:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KhJOL_yWT6PN; Tue, 13 Oct 2026 01:53:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 53E9F60660
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791856412;
	b=Bv72w7DzgIJjch5e0YHb7FoUpp79HuzU6xKYVAY//yzWbJa5QCMHntPMdydlRS7Y3PTL
	 fgZ2QvvJKRfXG5pFgU9gzB4wq8E/a57dQLwSVpDJvlv1fcjzImfC/qalFCYc9MJnEX+FP
	 m2Oif5k19X7ZrzSd2Ron535i0ySidEcO4+7vw5JZXV4ka3xCc77iO/Zb1RaPxMAISHqPx
	 YhLzKmy8+yhj/3nUFq02Xr0Z7S7j8pfRiTeosoXRm97fGyyxsIcNZoQ+rFdp0deLCZN+a
	 d5j/lNNtG5Zrr9rIK06F37G+hoQv6ABkIrgCeJiGXfk8RH0mZGj2rbkCE2MswbJTPyg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791856412;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=u9SakT4EHN+Bia9c6ciqE9ORqE8sy335d+lf3nVYf1k=;
	b=qKpcx/jazRkDe+lwvYeyWYoDNudqJTcGg/fW6R1qtatB0zRKdrdyqx2pQXrDJCkbODxq
	 qLNCWnrPY6oTdIzrld7FFN3Pl5i4f6+qaX7zbSRbrmBR8P7aCVuInmK+HMQCcahfQ5lvY
	 mYgHWkcR/YSSg0tAYkyFA5YZ2OZcrhSmfWan29+HBSq2ie/E+us4nieEgo55IhC/4w4gg
	 qWA0aj+Bv3ZSO8U3JvQpjmcGjBkexC9FTjNUMKoODY6wrGEEOBXOTzoEiabEo+bbZtt3k
	 KFI4aued79OIIxkaUj3Hvym1PbLE1bwKrjZqHpWfFtmY3Ar87x7vCyffCM7TH57noIg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791856412;
	bh=u9SakT4EHN+Bia9c6ciqE9ORqE8sy335d+lf3nVYf1k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xnwYwc1jf93WLfSSAY2eEo+zHZOXvbAtjRUUQ9XdwaMIgeXIPN5F+2yKPNMxedCNy
	 UdvadH14eBZUpQHBskOFwlPfrlt+yFcdyjppmnGSuL4AuqTrmlaHN2GBk2L4jlAkVd
	 9DNh08x0KhZfQdaiJH5ilDvww08yZVCIjnLhC+34O1N2PFyoT36umf2BBbhtgIzThE
	 FJH000cTmlPrI7p+m9P4rm3J+oYn9twazddnYXa8817B4IFzVCAaZbUsT/96DMD7nu
	 YbaV0pUjgjvJNo0BWgp/RHT5fCO+oSqDF4c8pqk3bW8wKRDN3KzvHhsb911d+coo2s
	 ayTd2vPOECcEw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 53E9F60660;
	Tue, 13 Oct 2026 01:53:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id C1D042A8
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 01:53:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B3C7A40512
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 01:53:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vR9MVn7ZGmS3 for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 01:53:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0CE754050C
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791856411;
 b=l51XTbc9GCbWjqOkmjpeEGL8hMzZsqrz06XS9y0Q9SwcWELMc5hOsKDUqrRPdXaSoCJ/
 R+bON1T+wywPt5Efldy4G8Z01LXya9pJDd5cIbZ0advlttFgu8Q6yH4LUc21f6Zt9p1/w
 XJr9/be1EjD7a15VDPO4A/+ESYgVOdhChAtQu6n1qEyL3pkWNI0vZuedfsmg7BCCp63xb
 LsGFzrgpTqoReDTi3+2z//WAOOALHNYmHuaGtc0dTzzuBWCrclzIH0jYA4Re0KmTGlLUQ
 EtmvZrCZGayF8dx5nb8eWAlz7ref0na+pSO9nXyjxHhLwBTUhpIgKXXnmw6lm0bY5Yw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791856411;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=u9SakT4EHN+Bia9c6ciqE9ORqE8sy335d+lf3nVYf1k=;
 b=J4nX51L/4JO9YtXRa+/2LQt/i4Spw5rbqVGGhATn3cLl6u4tdpluK2O8/tnGCayNztvo
 0W02PlMnIoMcWUKg6GKDq/1xdV7Fd7bJ4zq06lbsa3pC5NB6WMbScnTnJU1iQXrSe8Ikq
 St9kGSDyVPtx780Vk91XmY+6QNX+Pz8RlySYbsXDgKuoS+OY8flqtGjHe6gpvUkhdNAzi
 w0K+Kr8Wb5tXKubjZU19h74ssYBxk2DwT8axeCTRXvhtyADrbGuKjj5sOvZZ4QK+RyR5V
 S4JTpLoVxpyXiZM/kTJikbNmCpYbM1vQyhLOAVNWFjGPBSc4JWIPoVH3D4ovtHvzyBg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=VxqtwZ58; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=PAdRHIfX; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=VxqtwZ58; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=PAdRHIfX
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0CE754050C
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 01:53:30 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69CMc1MN497904
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 01:53:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 u9SakT4EHN+Bia9c6ciqE9ORqE8sy335d+lf3nVYf1k=; b=VxqtwZ58/5JRHyZp
 9PohE4pDU0vBvSt0OCb+WE4Xa8NIT8iBUz211W+DIQftxSOSWv8DVk4cxFaKIpkd
 ZP+C8cDiUF66KPi11WvO+Y7ujc3IImI32cB0WRPNKAVot8tShLofpYSzj2KiF/Rr
 D8bfMwJx702Ek6lhYSmwz8rbZFTDyEZrS5BDwo+DTpYTSX+QTE+ml5fpEZnUr7/R
 367lrm0nT2ACXLiaS+/oaq9FkssVqtnJHmacJoMhkb10LiSA5DoFBXHCZA37HTZk
 vjbtkGLzsauRyjvw3fkxjDQ4rHSdh3Te0m+jYwy8d6+CaaehMhjlnqEuIy/tJMMN
 LINHZA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h98h1rgg5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 01:53:30 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-3552883bd19so1189565eec.1
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 18:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791856409; x=1792461209;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=u9SakT4EHN+Bia9c6ciqE9ORqE8sy335d+lf3nVYf1k=;
 b=PAdRHIfXYNJ1zTsZSR4b6LHcM9xXxJgMlh6SN2KaoEBqoh0IsgZyKEe4SLycza+LH5
 IRYoWiEksvO/y0GLcRYniBs3sJEAAaizUAE/xnF0Htn8koIfvhOEd5Y0ghbGUxSyzwAr
 ygTOaFV6ew10bHBXJMTjmcgdAKeI2tvbo1H29W6Wa9pwzdwp6q3nD5I9q28R6u+IET/M
 gatK6FO0RB6P+WMJUdOQte73U+xGTM3Fz+PGuSiLw90WyYDTAMaIKn923Daycylm3I6y
 61MIBYSSNLwR2n2vG7JA1PQ3f6Gf1psoYYW5ra3/ZqKCcgXLX+MvG5h7HkSNvLXz8LBT
 6IfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791856409; x=1792461209;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=u9SakT4EHN+Bia9c6ciqE9ORqE8sy335d+lf3nVYf1k=;
 b=qe1sCfOwLTCnFJF0UKDWAqRsYBqJN/aybhRNlxApLE01XMTt06RtWvQIJaVqKqbASr
 UUxzUHlOWsoNR/X3BWFQVU+EJ3Uv5IQ/HLNjJa3oHk2FN6oiGmA1iChnIqylIDhYdE+X
 iu9VNTbr1w3nyrksLH6zyrNokWjtAri8pO3U3LucOXw0eoxJY1zWXSy4n80+LBDxApAC
 hY3e5//FsbPRaxkRl1QR4R3jiRjiDDpC9zdKlj2JuzMOxTSoXAc+MlU/seZ71eLVZfoO
 antWc9s0pidXXVo3JbPSYG80YU1EVAkp09Idva7rQAh4rg5rycKbofRZ+6nBEU9MgDGu
 u3vg==
X-Gm-Message-State: AFq9FYIBWF1ZCOEDtUufujc749TKqG0lqzBhRpNtaKcRjnTly2fj0fvL
 wk+jfmo9VxwxuYWI0w0ZARWpok1hNG66OehKvREHEj4yGtkWvCx526Xr5iODa16HVqnXcvR0Zap
 7BIeetZVcncnBDSFE+Ja7UJyFSMQfUF4AFRKl40f+A/Jq/8xP/YztOJMoYpKIPMc7vpYrrqQ=
X-Gm-Gg: AYBFou3QwyMVQVg0gWKKglkC5zCy1qTF3P74R9pUCZdx2845tG3v9OIoU6ZSiLt1kl2
 vbHUQPnpyLkOlF7RtWyofnl6ftvn5ZDTA2aKeKvLQtwgAdFDNNgiBzgRVo+ewJ66LobMOJ/GHeA
 gv9YUv5ZtbZvcOXH2KW1/Pp1vWidNmRoZGNW7QAUGxzozAbwLowzCbWdhwqTHkCAf45FrgY6bny
 rVZdft6WbrVuFr3XQGhEJOkTYrtcYDkiOThlMZQiqt6TcdKUL91lkI46D9c/EnELB+EFIEQhBWH
 3yGIwTHjvRZpAqF1dgIL1EdTpANxpvSY/cnzC/SfQ3I1P5G6dPMZngZxU2a6+K+uHKu6DA7jwiJ
 d90uBWZCnCdpLpWy++HqjtcEtVZR45CuVWZXURj+l1ZOvZoH+vnWKqUnV7zSMztHrbPKZHS8vDj
 LJja+U8AXgipScn1peVkWNnDH46ps=
X-Received: by 2002:a05:7300:2216:b0:351:28d9:4908 with SMTP id
 5a478bee46e88-3537db99e8amr21641950eec.0.1791856409198; 
 Mon, 12 Oct 2026 18:53:29 -0700 (PDT)
X-Received: by 2002:a05:7300:2216:b0:351:28d9:4908 with SMTP id
 5a478bee46e88-3537db99e8amr21641892eec.0.1791856408494; 
 Mon, 12 Oct 2026 18:53:28 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537cb68e56sm34612666eec.29.2026.10.12.18.53.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 18:53:28 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Tue, 13 Oct 2026 07:23:10 +0530
Subject: [PATCH v7 1/8] arm: snapdragon: Make SYSRESET_PSCI optional
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261013-snagboot-v7-1-fc296a32836a@oss.qualcomm.com>
References: <20261013-snagboot-v7-0-fc296a32836a@oss.qualcomm.com>
In-Reply-To: <20261013-snagboot-v7-0-fc296a32836a@oss.qualcomm.com>
To: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Michael Srba <Michael.Srba@seznam.cz>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Simon Glass <sjg@chromium.org>,
 Hongyang Zhao <hongyang.zhao@thundersoft.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791856396; l=1142;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=TfHvwBncGiGT5hjC8HrtPimKPWS1PylfevaI2V49eds=;
 b=x8Q5p7EErvzFJRENRpzooWvaP/E+p1t+rrw6UwBIHeBf0XmAl78D7ETIDrTb+GSeCu58t5o4q
 hnUBsH3y2R9ADw7SIaIxjPlP/Zt22BNY9VznntsbLCbWMabBI2sb16s
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Authority-Analysis: v=2.4 cv=VqC2kO2n c=1 sm=1 tr=0 ts=6acd8f1a cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=881fuD-RhmhaU7In5wAA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: jkBFam27iabT0ClQBGD3y6lQlBRGgkko
X-Proofpoint-ORIG-GUID: jkBFam27iabT0ClQBGD3y6lQlBRGgkko
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDAwNyBTYWx0ZWRfX0PRaL2XGXfrO
 SAZwc4qwXohcvZpnx3LCKkfsB3d2CdDstcrhoRwMII4bBxN8JUTuXWQqM9fMNkk6fLn+qlZ0WyJ
 ufuWgoLTQqJdLEbTLCGm8h38hVc7kNk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDAwNyBTYWx0ZWRfX8iCKOVJpZWCT
 hAxMDYVVAbRRNUSENi9DPXnMEDYG3tLvcGlrS4DYIBVstBeEWDUojF9TbA2ebismPwObTb0cWPC
 nFxWkyUSxd9I+Ywyw0DSDqKsMKb4nj7hwPgNWnVcnLlizwv/ntjupFXgeiP2aVPE4Uz5Ya1KSpS
 d69mGaYtcxZquQ/KzZNmgyeR7wX/r6REjcpb0xpJ+G3GaTIHMD4UcMgNG3nuXoOKUnzjgdO+fUA
 0VQdx3vZ7gR9DZ4KXxknCvySnmoBILHI/nsivF3Of9RzFEBbWsVyEoYx850n+EYbTiJtdTQXzk5
 ZzlJupeBSWgT6b+viqb86o0Uh+O2gTl+/U/qheUzUdyKmtEzo3yZiPhk2XD6YITJf6YE1qnY2GW
 wGMCFGURKnhOa01x+X2VPAhjYlIuKgzrcmWHDS3LYjqazrvDLmEpXBci7L0AeEzjhIVhkJP66w2
 SAyQ1YMtbiv1mWWivEg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_06,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 adultscore=0 phishscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130007
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

In snagboot mode, there is no PSCI firmware and U-Boot will crash if it
attempts to make PSCI calls so disable it in this case.

Reviewed-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v7:
- Make id dependent on both !QCOM_SNAGBOOT_MODE && !SPL

Changes in v5:
- No changes

Changes in v4:
- Make SYSRESET_PSCI dependent on QCOM_SNAGBOOT_MODE

Changes in v3:
- No changes

Changes in v2:
- Newly introduced in v2
---
 arch/arm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 3e9f3b51031..b438f0b9c14 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1150,7 +1150,7 @@ config ARCH_SNAPDRAGON
 	select SAVE_PREV_BL_FDT_ADDR if !ENABLE_ARM_SOC_BOOT0_HOOK
 	select LINUX_KERNEL_IMAGE_HEADER if !ENABLE_ARM_SOC_BOOT0_HOOK
 	select SYSRESET
-	select SYSRESET_PSCI if !SPL
+	select SYSRESET_PSCI if !QCOM_SNAGBOOT_MODE && !SPL
 	select ANDROID_BOOT_IMAGE_IGNORE_BLOB_ADDR
 	select MMU_PGPROT
 	select SUPPORT_SPL

-- 
2.34.1

