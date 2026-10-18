Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21443CCF2C9
	for <u-boot@archiver.kernel.org>; Sun, 18 Oct 2026 20:51:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D74B940712;
	Sun, 18 Oct 2026 20:51:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9_fWXXcnavwS; Sun, 18 Oct 2026 20:51:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B43E0406E7
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792356685;
	b=c3raiU6IuamoOC3YR610uM4MtrfuGLob+o/c6jNBLsS7IfRAQ5nPhmjviFqWJxX7syhz
	 cxlS2nlbE6QaPd3SXKVNfQVYrd6zMZETGPtzqipNtIT+8d4ZciAnwCTC/hOc9j6b7WYWV
	 79pho8hui97NrPyorc8khwCy0OPcX9zscCdnZTj1/fGVWvwpLXepB824dK9UkpnN4bpny
	 IXt5brlgsmOA4cwFmldICGtbqv9L1YgZKAzumf7fYRkO5+BjowenoEJFDyRjZrWRO2tnv
	 i6ybpbjEy3/yrI15PM9L6x5RsfV3udCvmFYs4nmS0npzD6swU9H9uxL9oy+KUlUqgbA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792356685;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=k9dtRxiuTzthIZHdR6aODNKcg7WxgLpeMC8XL3UZsDo=;
	b=VADR5YtWnvl/yxTHg28WAhjk6tg8gNNhveNHuinYveF3U5B3E20i44d++W2eIT8Sm8vE
	 azR2HC6tLs4f38EuJihyupA326nsxZIKYd/MQNp6fijCIoc/yQ6Lil785KbARqpQwv4Is
	 0AFBndBCZR8xSbn84O165JmqvYXzGWDauxEs5c9w4/tFeb+aWiSTM3uhmPSKYgFCfaqga
	 o2+ib/E23LYxkOkn/ZSu3I0hMSaF+aXTpjsTWMGiZmJ6U0wmmkkgJA1fGuyGzBTfg6Bnm
	 onnTRxZrECgxQNU49ACVXzB+t7tV5t8AMjcYn+w8SX3V/QESYlA3iXJ/yV2Px4hKAsA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VYYpWuYG;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TrA0NxpY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792356685;
	bh=k9dtRxiuTzthIZHdR6aODNKcg7WxgLpeMC8XL3UZsDo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iHMrbc52qbS2qPBAA/6foGXo7RKG32gDndBGDhe10LEqrGJvG1s60bijFW07BHNGS
	 d2bi4LdgJrLLhpB5OtkF6paQ6g6ExtAVpagfBPQhlC6zABfuDiqE/R8R0Y2LUc1bOz
	 SxfhkwQMAPf2bIUO0WmoS+B0ZOiFcV4r2DGYH7T5xdvuX0MKzRxEheC8AtwTlxQ1AA
	 2xNJ/wBxcse66f+JQdu8eeqLcgZr8cUnu0z3d/DPryr1/uA7QN3HEzGuXCpXBMEMCz
	 37zxAd8npRcrxYJYzucw0nlVYg70hAGMNxxqWd+FGajTLVPdqqPj9QTdO+x6Xrvnpj
	 o2l/eF39qu3+A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B43E0406E7;
	Sun, 18 Oct 2026 20:51:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id D6CC92A8
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 20:51:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A9AB3406CE
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 20:51:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6MqzOyt5ODCp for <u-boot@lists.u-boot-project.org>;
 Sun, 18 Oct 2026 20:51:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 966C9406D4
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792356676;
 b=OJN9zOyJxBa8MbSbXnAUOTI5o+GUeVbSymV5/frb6/cn3yzbu3jUFWqb30X0abnUWPH6
 UgjR60dHkRTOefnob6nTQZm/Zv63nU9M8wNJucElI8pcreyR+8VaWEneSCBnwam0WfE9L
 RV82BFdTeYjWcuuiWaIJw7kOr5hNFdZKEvd/IHfYeR2+17/bOJ2wERzsQZEO9Gq9VmrQ0
 9qC/Vgru1N5ulHOpU/TKusoeLFyqYWYLByQqa9zkIMaPyw5H92xu0J8jIBr8xojHZzNBw
 C927hmnGNCOs72uP32O7iG4Urz0SOGxjz9N4cgjbf36L/LxjSCp7tOdZq3myUJVggLQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792356676;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:X-Authority-Analysis:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=k9dtRxiuTzthIZHdR6aODNKcg7WxgLpeMC8XL3UZsDo=;
 b=pZ2o7YR9Pw2v3SLqI3vGwWmYyNEj8i9tcdnErjOq+4Z/iznBR5NGOJ5R9TzS4X23zK9D
 rqOepUxxZ4FgyCnEJBxpFEB8tAvqvBHh6bVxW6y6n/P7q7zJsqcWLX0zEiRdlyl27PHeU
 AjZ4Sgh+V3o6ONMxkRrXNOza83QhTzoNaFZ/+uHLpjT4czyJSt3a2u1uayMhGopMW+hZk
 fEeokjUalj5cIWEQEVOSkYGTaXmpdLYq/rz1r2XDNbUOm1+NWRHDqApaErZO2c42Q3isM
 fpXwOxZj1Qx+jY4EYINhx/Y42RLHJA0c5N6c4eV1JJvSr5F4hJh2JoC+nmfcocNaZkg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=VYYpWuYG; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=TrA0NxpY; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=jorge.ramirez@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=VYYpWuYG; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=TrA0NxpY
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 966C9406D4
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 20:51:16 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69IKAoPT351660
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 20:51:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=k9dtRxiuTzt
 hIZHdR6aODNKcg7WxgLpeMC8XL3UZsDo=; b=VYYpWuYGuou3MuwzF0jLUGfiNEW
 Ak3AunUrnM/mMtD1Pn1VpjDP14IelwDXeIqBSZubaSpKRZnmSEFKvhjtDNi/5pDA
 guWy19dFNuwAe1wLOIq4gIulwpENBqksqsm04qvdWbZSyScQUO9GfaXHaRt8i4mz
 bVi4BsBAIIYc8mWvPeOAz/VYhHiCklSAEkRUkOXTgdhZzq/3VIcyEiFeTopBph1A
 8P5XCNNCimcr6Pw37cxv9kB/reSGhg0P9WydtnVWznFIsmBQsVsZd/8j8/9g1i2p
 1+uThJFGPp/Fcq5DRfwXUwsdeA58XqutPxK33mI0krh+taX5vdoJvT9RT3g==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hc0bgm0vx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 20:51:14 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93dd3c3badbso366559785a.2
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 13:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792356674; x=1792961474;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=k9dtRxiuTzthIZHdR6aODNKcg7WxgLpeMC8XL3UZsDo=;
 b=TrA0NxpYmYOjqstQVDNSzvYwrbJAgk4/WJKQsHUvyLylVoxJYwqZpWgU7YCEpvWdd8
 +TWfbQtyc3P2R7aYzZevfWww9ZBwngVZlVe3E+DL4+lDs8sBIzOqblwhiSnZsGk17NIU
 eCO5jbUbft2LQaYgaMdOZauv3CDI06gcHu+xVCtggzuGT2PN3YDfKzRBoKLH6gs+t+ht
 lQktY1MqCTwAJWM5/pXE97PWiqn7GuxtmXokuskDSE08ma9qGkrC/VkdW06VH+rZi2Ks
 6+zvJH4WPMG6C1AJMPDwkWRChHtu36gW2S/kJYnLZJrWF9TWLgpY0gT/bhAbnz7zlybW
 YtEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792356674; x=1792961474;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=k9dtRxiuTzthIZHdR6aODNKcg7WxgLpeMC8XL3UZsDo=;
 b=0lTLum5Q10rjX65PJGZPLGedwqoFdeTXCRBWKS1uOe63PBa+WndSSO4EE9Gb29AlnZ
 tkiwMFC0U3yN8IhuFrt3ai5MQofRrxD+hWw58xsOPpZ+7QgsRPc/5u2iCgXSImwgEZUv
 WFvk/zEzA+jW4g/QqHtHhbB9ZnEWIo0GNhzc6ixSRxJ4ltL9ejgMwmP6Ct3VjcqdwrHS
 Wvqj8DzIeyi42bbt3495vYRjBh/4JXRR7yK6SeNAu6lufGj9EUAC0ef+exaEwxAoVH97
 2ds0sDOMxK1K56AeJKVC9JbZg0mLD3DbAV9kxlWB++4BFHNOyvpUBbsdB7Cfkxv7Q/aQ
 zr0w==
X-Forwarded-Encrypted: i=1;
 AKwUvBwqkUedHU+M+fo4G2KNFVAFdB3Je2EUBrWA9KtD/wNJerTQMVwOveLkV8y+FM2FGZz/3A9osf0=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKVMf2yYEkmea4EI3kn2GO5FHflGuAuDZSBq0Z4q0tx7Kzh4Ppf
 iTaJ7eTDI4TmadmfRZ/hZCGxWsxrY8LQRh84aOLW2Arh513WQ28Q+YL6V52QtFWVr2LefLUVKgu
 7qorgK9aTFgsrFhOb1Wq1bDulOrX+uHhTN6gXptZSCxHo1m03Kqvkdj2+KqoXnMTesvksmUI=
X-Gm-Gg: AYBFou3Iie81IHV9xOzxTAJLV5qsLas3Gyd/twDtGI0dzTnSr8virrka8r8i9UhFCnP
 qrXmSl3Mk5Yyov7F7IE2N3BMt7QAWoY0/P2adhaRBwkchmrdXKCVVEJP5xtmPULICAcHbtgMmvA
 UpcEg0L5C2idxtdL3C8oOcGqmlVIf4Ka2q3EKvWn/A9c3bqYo+ewCLwzj5iOx95SjZDdu7xVqSD
 AtZ8RfkGUf6i7uJC4KnD1V285Yy7NKjA13B6/4zJ2MTBMURmpMgtRwMojOtP72h9URuKMVWHX4R
 OcM72VIOwkcNVIC/bYBwMmj3ERZU1A7IqwVOAHA5yoymKFkvS2v70x7HdAd/67HgUW/f2mjzIhY
 zR63+uNs3/tO86/fSabVOS1AZp8YjqWqlcnTUSOarlAAW
X-Received: by 2002:a05:620a:280b:b0:93f:1ed3:a9cc with SMTP id
 af79cd13be357-93f29ceec2bmr989047685a.17.1792356674149; 
 Sun, 18 Oct 2026 13:51:14 -0700 (PDT)
X-Received: by 2002:a05:620a:280b:b0:93f:1ed3:a9cc with SMTP id
 af79cd13be357-93f29ceec2bmr989043885a.17.1792356673641; 
 Sun, 18 Oct 2026 13:51:13 -0700 (PDT)
Received: from trex (5.red-79-144-193.dynamicip.rima-tde.net. [79.144.193.5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1d756ce69sm148645925e9.4.2026.10.18.13.51.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Oct 2026 13:51:12 -0700 (PDT)
From: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
To: jorge.ramirez@oss.qualcomm.com, trini@konsulko.com,
 neil.armstrong@linaro.org, ilias.apalodimas@linaro.org,
 jens.wiklander@oss.qualcomm.com, sumit.garg@oss.qualcomm.com,
 dlechner@baylibre.com, peng.fan@nxp.com, jh80.chung@samsung.com,
 tanmay.kathpalia@altera.com, bhupesh.linux@gmail.com, n-francis@ti.com,
 xypron.glpk@gmx.de, s-vadapalli@ti.com, michal.simek@amd.com,
 jbx6244@gmail.com, marek.vasut+renesas@mailbox.org
Cc: stanleyjhu@google.com, Macpaul.Lin@mediatek.com,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v6 4/6] ufs: derive the per-region RPMB CID and size for OP-TEE
Date: Sun, 18 Oct 2026 22:50:54 +0200
Message-ID: <20261018205101.2362593-5-jorge.ramirez@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261018205101.2362593-1-jorge.ramirez@oss.qualcomm.com>
References: <20261018205101.2362593-1-jorge.ramirez@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE4MDA4MyBTYWx0ZWRfX5oDMjCPwPZae
 ml0nflatH/ag2pGcAxX1Luo98mesdzJjhhN7lrQvQqaPMhTCM0g1idWyGLgQ5leHDhIJs2bLXYq
 S6fZrS7r0sMX5ZLkdnWj4sTimSXANhI=
X-Authority-Analysis: v=2.4 cv=FayiV5+6 c=1 sm=1 tr=0 ts=6ad53142 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=nno+U714v6U58lXnMUU6PQ==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=_wGwWCd7Qb3L-efQH6IA:9 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE4MDA4MyBTYWx0ZWRfX7cvOlEilHD5C
 GEbZ1PnWUDlP0O0Up0levVjh6uOtVck7OP7JDf48XSsgDmrNbpmy4HvOGhDfGexh+0pLNGmAi2K
 /WpA8p2/7lBhPiNICqCEUea+aO3/Z2bGG1GG86m1Gxm7sQWMuKaXbINhLoQCD262J4Uf7x8B0UY
 /vQC0nbFzUu1hvVjCv2N2R5QoTruqPL6NIiVlOGr6qeaz3VKQftoxr1l4sEJU2ER8kcme3JAM9l
 4TXrYC0wdhwGSXYzyobyw7Cg3TdrSWm378bWE7y02UQUKZhrdFMj2WYR/qNqVwyL6qKlujUAjRF
 LMLqRd+YJNpu4kFECn+n6sel2oPj6RZLWuq2mCdIH9cgARUbx/U+lStgB0kF52OXP6f90RxaiLK
 u5hNz036+yQWJdmT9149lFoes0XO+r5yv4sYE7JCCl1IBQIIAIfoOnAeiJqFRha+s1dY4UbdcxD
 22uCQes0GH4mWo8gBTw==
X-Proofpoint-ORIG-GUID: ZFJTJ-100zvpz_IM9y9Z4mdybNFm6wHJ
X-Proofpoint-GUID: ZFJTJ-100zvpz_IM9y9Z4mdybNFm6wHJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-18_04,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610180083
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

OP-TEE derives its RPMB authentication key from a device identifier, so
U-Boot must supply the exact identifier the Linux kernel uses; otherwise
the keys differ and OP-TEE cannot access RPMB storage provisioned under
Linux, or vice versa. The RPMB probe also needs each region's size and
reliable-write count to enumerate the regions. Provide both so secure
storage stays interoperable between U-Boot and Linux on the same device.

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
---
 drivers/ufs/Kconfig    |   7 +-
 drivers/ufs/ufs-rpmb.c | 181 +++++++++++++++++++++++++++++++++++++++++
 include/ufs.h          |   6 ++
 3 files changed, 192 insertions(+), 2 deletions(-)

diff --git a/drivers/ufs/Kconfig b/drivers/ufs/Kconfig
index a0067b1f203..648b58b46e4 100644
--- a/drivers/ufs/Kconfig
+++ b/drivers/ufs/Kconfig
@@ -95,11 +95,14 @@ config UFS_TI_J721E
 config SUPPORT_UFS_RPMB
 	bool "Enable UFS RPMB (Replay Protected Memory Block) support"
 	depends on UFS && OPTEE && !SUPPORT_EMMC_RPMB
+	select BLAKE2
 	help
 	  Route OP-TEE RPMB requests to the UFS RPMB Well-Known LUN using
 	  SCSI SECURITY PROTOCOL IN/OUT commands. Required for OP-TEE secure
 	  storage (CFG_RPMB_FS) on UFS-based platforms that have no eMMC.
-	  The OP-TEE supplicant handles a single RPMB transport, so this is
-	  mutually exclusive with the eMMC RPMB supplicant (SUPPORT_EMMC_RPMB).
+	  BLAKE2 is used to derive the fixed-length RPMB CID that matches the
+	  Linux kernel UFS device_id ABI. The OP-TEE supplicant handles a
+	  single RPMB transport, so this is mutually exclusive with the eMMC
+	  RPMB supplicant (SUPPORT_EMMC_RPMB).
 
 endmenu
diff --git a/drivers/ufs/ufs-rpmb.c b/drivers/ufs/ufs-rpmb.c
index 97b1c0f82f2..d9d35a06439 100644
--- a/drivers/ufs/ufs-rpmb.c
+++ b/drivers/ufs/ufs-rpmb.c
@@ -1,13 +1,16 @@
 // SPDX-License-Identifier: GPL-2.0+
 #include <dm.h>
+#include <hexdump.h>
 #include <log.h>
 #include <malloc.h>
 #include <scsi.h>
 #include <ufs.h>
+#include <vsprintf.h>
 #include <asm/cache.h>
 #include <asm/unaligned.h>
 #include <linux/errno.h>
 #include <linux/string.h>
+#include <u-boot/blake2.h>
 #include "ufs.h"
 
 #define RPMB_REQ_KEY		1
@@ -27,6 +30,17 @@
 #define SEC_PROTOCOL_UFS		0xEC
 #define UFS_RPMB_SEC_PROTOCOL_ID	0x01
 
+#define GEOMETRY_DESC_RPMB_RW_SIZE	0x17
+
+#define RPMB_UNIT_DESC_LOGICAL_BLK_SIZE		0x0A
+#define RPMB_UNIT_DESC_LOGICAL_BLK_COUNT	0x0B
+#define RPMB_UNIT_DESC_REGION0_SIZE		0x13
+#define RPMB_UNIT_DESC_REGION1_SIZE		0x14
+#define RPMB_UNIT_DESC_REGION2_SIZE		0x15
+#define RPMB_UNIT_DESC_REGION3_SIZE		0x16
+#define UFS_RPMB_LEGACY_SPEC_VER		0x0220
+#define UFS_RPMB_REGION_UNIT_SHIFT		17
+
 static u8 ufs_rpmb_sense_key(const struct scsi_cmd *pccb)
 {
 	const u8 *sense = pccb->sense_buf;
@@ -184,3 +198,170 @@ int ufs_rpmb_route_frames(struct udevice *scsi_dev, unsigned int region,
 		return -EINVAL;
 	}
 }
+
+static int ufs_rpmb_read_geometry(struct udevice *scsi_dev, u8 *rpmb_rw_size)
+{
+	struct ufs_hba *hba = dev_get_uclass_priv(scsi_dev->parent);
+	u8 desc[QUERY_DESC_GEOMETRY_DEF_SIZE];
+	int ret;
+
+	ret = ufshcd_read_desc_param(hba, QUERY_DESC_IDN_GEOMETRY, 0, 0,
+				     desc, sizeof(desc));
+	if (ret)
+		return ret;
+
+	*rpmb_rw_size = desc[GEOMETRY_DESC_RPMB_RW_SIZE];
+
+	return 0;
+}
+
+static int ufs_rpmb_read_region_sizes(struct ufs_hba *hba, u16 spec_ver,
+				      u8 sizes[UFS_RPMB_NUM_REGIONS])
+{
+	u8 unit[QUERY_DESC_UNIT_DEF_SIZE] = { };
+	int ret;
+
+	ret = ufshcd_read_desc_param(hba, QUERY_DESC_IDN_UNIT,
+				     UFS_UPIU_RPMB_WLUN, 0, unit, sizeof(unit));
+	if (ret)
+		return ret;
+
+	memset(sizes, 0, UFS_RPMB_NUM_REGIONS);
+
+	if (spec_ver > UFS_RPMB_LEGACY_SPEC_VER) {
+		sizes[0] = unit[RPMB_UNIT_DESC_REGION0_SIZE];
+		sizes[1] = unit[RPMB_UNIT_DESC_REGION1_SIZE];
+		sizes[2] = unit[RPMB_UNIT_DESC_REGION2_SIZE];
+		sizes[3] = unit[RPMB_UNIT_DESC_REGION3_SIZE];
+	} else {
+		u8 blk_shift = unit[RPMB_UNIT_DESC_LOGICAL_BLK_SIZE];
+		u64 region;
+
+		/*
+		 * bLogicalBlockSize is a device-supplied log2 block size;
+		 * reject values that would make the shift below undefined.
+		 */
+		if (blk_shift >= 64)
+			return -EINVAL;
+
+		region = get_unaligned_be64(unit +
+					    RPMB_UNIT_DESC_LOGICAL_BLK_COUNT);
+		region <<= blk_shift;
+		region >>= UFS_RPMB_REGION_UNIT_SHIFT;
+
+		sizes[0] = region > 0xff ? 0xff : region;
+	}
+
+	return 0;
+}
+
+static void ufs_rpmb_string_to_ascii(const u8 *raw, char *out, size_t outsz)
+{
+	int nchars = ((int)raw[QUERY_DESC_LENGTH_OFFSET] - QUERY_DESC_HDR_SIZE);
+	int i, n = 0;
+
+	nchars = nchars > 0 ? nchars / 2 : 0;
+	for (i = 0; i < nchars && n < (int)outsz - 1; i++) {
+		u16 c = get_unaligned_be16(raw + QUERY_DESC_HDR_SIZE + i * 2);
+
+		out[n++] = (c >= 0x20 && c <= 0x7e) ? (char)c : ' ';
+	}
+	out[n] = '\0';
+}
+
+static int ufs_rpmb_build_cid(struct ufs_hba *hba, const u8 *dev_desc,
+			      unsigned int region, u8 *cid)
+{
+	char serial_hex[QUERY_DESC_MAX_SIZE * 2 + 1];
+	u16 manf_id, spec_ver, dev_ver, manf_date;
+	u8 serial[QUERY_DESC_MAX_SIZE] = { };
+	char idstr[QUERY_DESC_MAX_SIZE * 3];
+	char model[MAX_MODEL_LEN * 8];
+	u8 raw[QUERY_DESC_MAX_SIZE];
+	u8 blen;
+	int ret;
+
+	manf_date = get_unaligned_be16(dev_desc + DEVICE_DESC_PARAM_MANF_DATE);
+	spec_ver = get_unaligned_be16(dev_desc + DEVICE_DESC_PARAM_SPEC_VER);
+	manf_id = get_unaligned_be16(dev_desc + DEVICE_DESC_PARAM_MANF_ID);
+	dev_ver = get_unaligned_be16(dev_desc + DEVICE_DESC_PARAM_DEV_VER);
+
+	ret = ufshcd_read_desc_param(hba, QUERY_DESC_IDN_STRING,
+				     dev_desc[DEVICE_DESC_PARAM_PRDCT_NAME], 0,
+				     raw, sizeof(raw));
+	if (ret)
+		return ret;
+
+	ufs_rpmb_string_to_ascii(raw, model, sizeof(model));
+
+	ret = ufshcd_read_desc_param(hba, QUERY_DESC_IDN_STRING,
+				     dev_desc[DEVICE_DESC_PARAM_SN], 0,
+				     raw, sizeof(raw));
+	if (ret)
+		return ret;
+
+	blen = raw[QUERY_DESC_LENGTH_OFFSET];
+	if (blen < QUERY_DESC_HDR_SIZE)
+		return -EINVAL;
+
+	memcpy(serial, raw + QUERY_DESC_HDR_SIZE, blen - QUERY_DESC_HDR_SIZE);
+	/*
+	 * The identifier format is an ABI shared with the secure world. The
+	 * kernel's ufshcd_create_device_id() hex-encodes the full descriptor
+	 * length (header included), so the serial always carries two trailing
+	 * zero bytes; reproduce that here so the derived CID matches.
+	 */
+	bin2hex(serial_hex, serial, blen);
+	serial_hex[blen * 2] = '\0';
+
+	snprintf(idstr, sizeof(idstr), "%04X-%04X-%s-%s-%04X-%04X-R%u",
+		 manf_id, spec_ver, model, serial_hex, dev_ver, manf_date,
+		 region);
+
+	if (blake2b(cid, UFS_RPMB_CID_SIZE, idstr, strlen(idstr), NULL, 0))
+		return -EIO;
+
+	return 0;
+}
+
+int ufs_rpmb_get_region_info(struct udevice *scsi_dev, unsigned int region,
+			     u8 *size_mult, u8 *rel_wr, u8 *cid)
+{
+	struct ufs_hba *hba = dev_get_uclass_priv(scsi_dev->parent);
+	u8 dev_desc[QUERY_DESC_DEVICE_DEF_SIZE] = { };
+	u8 sizes[UFS_RPMB_NUM_REGIONS];
+	u16 spec_ver;
+	int ret;
+
+	if (region >= UFS_RPMB_NUM_REGIONS)
+		return 0;
+
+	ret = ufshcd_read_desc_param(hba, QUERY_DESC_IDN_DEVICE, 0, 0,
+				     dev_desc, sizeof(dev_desc));
+	if (ret)
+		return ret;
+
+	spec_ver = get_unaligned_be16(dev_desc + DEVICE_DESC_PARAM_SPEC_VER);
+
+	ret = ufs_rpmb_read_region_sizes(hba, spec_ver, sizes);
+	if (ret)
+		return ret;
+
+	if (!sizes[region])
+		return 0;
+
+	ret = ufs_rpmb_read_geometry(scsi_dev, rel_wr);
+	if (ret)
+		return ret;
+
+	if (!*rel_wr)
+		*rel_wr = 1;
+
+	ret = ufs_rpmb_build_cid(hba, dev_desc, region, cid);
+	if (ret)
+		return ret;
+
+	*size_mult = sizes[region];
+
+	return 1;
+}
diff --git a/include/ufs.h b/include/ufs.h
index 1bec3ce73a4..a8b7d370f78 100644
--- a/include/ufs.h
+++ b/include/ufs.h
@@ -20,8 +20,14 @@ int ufs_probe(void);
  */
 int ufs_probe_dev(int index);
 
+#define UFS_RPMB_CID_SIZE	16
+#define UFS_RPMB_NUM_REGIONS	4
+
 int ufs_rpmb_route_frames(struct udevice *scsi_dev, unsigned int region,
 			  void *req, unsigned long reqlen, void *rsp,
 			  unsigned long rsplen);
 
+int ufs_rpmb_get_region_info(struct udevice *scsi_dev, unsigned int region,
+			     u8 *size_mult, u8 *rel_wr, u8 *cid);
+
 #endif
-- 
2.54.0

