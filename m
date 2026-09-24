Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1227C9831E
	for <u-boot@archiver.kernel.org>; Fri, 25 Sep 2026 02:41:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2F9C081247;
	Fri, 25 Sep 2026 02:41:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id S1fdYH_CIoBt; Fri, 25 Sep 2026 02:41:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 2095A8123F
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790304096;
	b=oy1bgHLb6G4GeK2jjrqpIWciyZpi3kDon+Up0DTKQsKqzf8Lc+CNXkuf9Chxjma2kG/5
	 uEtCUZVSXqFcejFsDbRSaYTkdiDg3K60O9x3TpWP4UOnQwFHE7l8/yjUZu4wVjJNKBsC8
	 El01wKaSqmC+/mkiGiGJCLXzJ/MllHNGI8GcXHzp7ki4H8c4uhbua73WM/YU5Amg4A8aH
	 km7AHBOZAW+VcSuPBnovBrvwgMjgESy4TGHJKJ3vR8BHbCaVd9RZys4sIhuFxr9SRT41N
	 rWr68BJxXuMKw7QinW2iW8enWz1uFP8BhoujVRhxV2KVxT3r5ClTUVR7gwGz1MCT/ag==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790304096;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=BqyNjx+5VBQRIrzhNDdgLkDKh2wNbOPBkdKJmwiKz4c=;
	b=PnaJyfkMc74ZFdbk1/4S89wKmKC9NeEs/BwVcA+lTRrvXg5MzjK0Yv7Q8k6lqwU2c5x+
	 njH2tnVpFHfpD6vs+orcwrxFbpPLtb25AlQX/cOw7R/EoEXiGJxYBo6BY7Y79JCMudtCH
	 if46IMEgNVhAnMxrz4/DeFaCnv/dtPepWbPiRr0isndfnl2q6nmyPo4jutmVW+MmQRU9s
	 ggbgxIba2MfP7SliYbPklhrYs+WCkr2C/UqeVO2U0xrzBYOU9TwUr2LVFzf23hUfq0CNs
	 Qgr4m9jc4Ph+YrkcSDbLfQjnpoIKibeJf2l9bkVaxT9RPrZqxwobkJtmcRRU+2MiRsQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790304096;
	bh=BqyNjx+5VBQRIrzhNDdgLkDKh2wNbOPBkdKJmwiKz4c=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=DOibDgBCLnpWCGafrs64cVPWxlmaswqEIhSvm5iW5IUeZo2ZDNoEY5DDNZoHRk5KP
	 Ko1UC9jx0+c/7txcQXXd0adMr7ZoHzofQs4kKo4LwBP/5RiRbh8BDNsdOri+9RKkIn
	 or48BiOOZApnvpycIsj5M3Yxlm9gB0XCWXc07ssaS4XJewHX/3xCnaZNKk7jbcihyL
	 LjmGMAPWFGt0+HxMJ34wl8ZyXsDrf8qUgIvcK04AkVkPn2Pd2AlWihnwI4cST2nVbk
	 0X8sWexNi36MPw37pKY0ldnSLE9hW00dEADoRMO0FM//r6aEW6TyUeQJJfA+QiZc4d
	 3zdxIMUMFVKag==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2095A8123F;
	Fri, 25 Sep 2026 02:41:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 24A06355
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 23:38:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 01D3260BC6
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 23:38:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MoWEZjWRnEpG for <u-boot@lists.u-boot-project.org>;
 Thu, 24 Sep 2026 23:38:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 05936607E4
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790293087;
 b=CMSLj57nasBlFg79Yf5XKW467KkU4+CPZ5g05BvNGm+ejmB1WzStnvTp/qpnDV2EA7hH
 /l0KjdJXhH7dHcldWr+lcHkXWnvp1hkA08OKptArFDlIFtC2BJVfbgcUBrcbz3GIDwQEI
 aY/2XZsIPk/sbEAGfXE+6AYyEvaT58IvdC87jjfLtLXaporQVAHIbwMgjQREz9+eJNNS4
 JYbhcOr5p9jFCB6sgAfSY3rejF6uCcv/Bp45k0dwcok0lQZC3CWIEGRAnZJWGStYe5GMG
 PHOcKXEmFcFqeMbHdJKmJjsTdaahfRzMajveRk73boIgAzp+qESiaVREandxsgLeQNw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790293087;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
 Subject:Date:Message-Id:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=BqyNjx+5VBQRIrzhNDdgLkDKh2wNbOPBkdKJmwiKz4c=;
 b=IyDYKgdtNLhitFz3GBrmiNAnKf0M6/sFO+bJUfeEpL70BXT/o4eyX2bNCgKHAH2Fxs4d
 srmiY6NuyVITrdlriK/OqBPcM1udFSOc8y+HJgwu+qRho58txV/PKeShagqnAqOhazmC5
 +byc1sSjEmsAUoewPMHwU+AYfecpI9stv26bMxWDkrew3Gc8CXbM7aJOKoVVlVnt0VTXV
 fDjFxcPxb8cmIB+fK6F1/KEQcIDl8NVM0GvOn1Idgdedxv9Dq5kYW6Dk3YLxDThuIQWUH
 NIycTrs94M8GkkEU/kDPdzsuM0hPruMiJPYgovA7kuyVmeqnexI8TMgsoaUJ+QrXjiA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=ilv3lu1S; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=GtP7nGYu; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=tyler.baker@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=ilv3lu1S; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=GtP7nGYu
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 05936607E4
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 23:38:06 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OMOvCH280386
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 23:38:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=BqyNjx+5VBQRIrzhNDdgLk
 DKh2wNbOPBkdKJmwiKz4c=; b=ilv3lu1SxSk/9+9GXhqb1Ipca6b8WUVLmb+VwX
 NiPgWK1OtZrted+uDKcVI+xtMpSyPBl04dxPUzkYPjEKVEtJZp0N3eP88LZ7DPUB
 KaT8ntGcJu8ym4Hj9zmWh6Naopm6i4QDVGJZ4/jjD0KRYSGNRVyB05DSQCV/3aWO
 nC4HS348anfxizQ+8Ul/bEOlYcbtRG1tDANJC9AuLjIyxKwH5X2KDqjF63oz+EIR
 ZHRMJnA+AR+Pmn7ery7fEvAleqkuYhPG07I2LVIVG9E83cAl2fx0KLO1FFkSS4ke
 GTtpDYPlDGg2MEpUdBlQ2P7FAmwH8lwu18Pau5wrMf+b4GSQ==
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gwce7870s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 23:38:05 +0000 (GMT)
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-893d2c627b4so5675027b3.3
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 16:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790293085; x=1790897885;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=BqyNjx+5VBQRIrzhNDdgLkDKh2wNbOPBkdKJmwiKz4c=;
 b=GtP7nGYuzFr1sLqdn15CUr95rtfrWihuIgbw4knKWWaz7ZWGYRn3J9pr5aqYtpW28o
 Wk+4n57J0XfYpdihclVzb8dfAX8tOdiCVXj6HcnMJ5CXVz5/AmIAh2M38yzBhRbb3/El
 w+8FX/YNETjKc+5wLv87Cc1R9YoXPZLEWo9z55kIjaFCxHGmpW/z/hNcEqok1FWY+wTc
 TuM6+rDLZGonM8ZWBPBhDgf8xR+Eecm13nJP0yjwp9uoUfmNUyhyXcexVJ3niW1Ptm9K
 yTcBipvAWCPji4Z7stYI5GrUUlx7ckDwrHCRZt0+ceB/gsS6eFzQCbK5uXMuCKnbSQQx
 dj4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790293085; x=1790897885;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=BqyNjx+5VBQRIrzhNDdgLkDKh2wNbOPBkdKJmwiKz4c=;
 b=hMQzMyCy7+f8bfX2xdHELcoZOFFv5mbLerH7RzgrgwTjrKCMSipNiZV6Ekibas1IPF
 KlNxGuPhaHr3Yt0YJzhr3upYYmxJzFsyEeVBuWdc6pouBnnsF0tVPCpkhCEX58PinWzl
 ash47+6YCGzA4IE/NFQDMJE4wxEnPQ2Vxsyl0SfJhY6KTZplHnJY1k4CDqXuW9yQR4Wj
 EtPBNNfRrmIf58PChyv1jN4LK/d96w9rC+qpypL3VMI/nHSg4lVeV4/tMw1C/pyrhTlD
 IysvhHA/UGuyBc0M9U+snIgrYWNqz/xX4zVBYpb3XlQL9D/g85n0LCvgs1WwyenAO/0T
 5t4A==
X-Forwarded-Encrypted: i=1;
 AKwUvBw4oy6Z8/eEPR7UMfLEVUFr9LcaP0R/600jftOKTgR2+zNt5gLqQu5ZBBt39BOTqjWkqytXgo8=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kun+mBtsnPbFvZHNl3+yuzka8K/JIGrI8XTLydWRoeb1shWPmM
 1U8nxsagFcJtHYXx9y7GhPaqla5shDxV/QfS6vsDw7vcMwyfWjKyi9SSN0+Z9Y6UKI76XnrLXjC
 KkbeCmuoGtq/r61bzBCsPiulN67WFrTD3ucELTt4xLZvKrpkbTYqZaAigctPHPLAiZAv0Lug=
X-Gm-Gg: AYBFou3hdS1i1dmGxoD9pw2dlg8z2BJFEpjYgk2eWQk2B4DUuLzmm4DsMx3CqAGudF6
 u5BeRUcBRXmL6fdKJ6HlTh9dWj0yh6dizMBh3RPgfdB/PK8Ehd9EAap7pKABIIqrTDm7s6wF3bX
 wMOsWZ0PWGviO41Wdw9T/yNHH6w3lzD86D3GeClt4fxSKO21CHxoBmLCac2ZLinY1wd2e3bqFF4
 I13rlDzMkiKlAP0jX+kBfSJQNaYjq4w9Ex2ChNM/5bojXBXcdJR6XQlb3THdGTyB2yzBpNKCvEi
 Jygi3QCalUJJNU0lf5jQCi9ihHBCBWnCl0wT6gzO2QtMwrbjuIWztHN+f3JCOsyPewo2eqwjgIz
 OW6cMGv7WlF5h5Bw5RZNKDA8l9Sq0qXCwnBepBNymeIoCr4MmiKI7eN1feUb+FWl/hYxfeLua
X-Received: by 2002:a05:690c:e3c8:b0:8a0:8955:5aff with SMTP id
 00721157ae682-8a64a38f021mr26494527b3.58.1790293084648; 
 Thu, 24 Sep 2026 16:38:04 -0700 (PDT)
X-Received: by 2002:a05:690c:e3c8:b0:8a0:8955:5aff with SMTP id
 00721157ae682-8a64a38f021mr26494407b3.58.1790293084179; 
 Thu, 24 Sep 2026 16:38:04 -0700 (PDT)
Received: from x2e.localdomain
 (108-208-224-205.lightspeed.gnbonc.sbcglobal.net. [108.208.224.205])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8a860325fbesm3025817b3.5.2026.09.24.16.38.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 16:38:03 -0700 (PDT)
From: Tyler Baker <tyler.baker@oss.qualcomm.com>
Subject: [PATCH 0/7] qcom: add support for the Arduino VENTUNO Q (QCS8275)
Date: Thu, 24 Sep 2026 19:38:01 -0400
Message-Id: <20260924-monaco-ventuno-q-v1-0-290b6a4d10c0@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFm0tWoC/yXMTQqDMBBA4avIrDsQ4w/qVYoLTUadQieaqAji3
 Zvq8lu8d0IgzxSgSU7wtHNgJxHpKwEzdTISso0GrXSpap3j10lnHO4k6yYOFywzpXJbFFVte4j
 Z7Gng416+28dh6z9k1v8HrusHNMwPqXQAAAA=
X-Change-ID: 20260924-monaco-ventuno-q-63004d5589db
To: Lukasz Majewski <lukma@denx.de>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot-qcom@groups.io, u-boot@lists.u-boot-project.org
X-Mailer: b4 0.16.0
X-Proofpoint-GUID: vT15hJv0r9loRERaqhEke5g2UYs-Tt4g
X-Proofpoint-ORIG-GUID: vT15hJv0r9loRERaqhEke5g2UYs-Tt4g
X-Authority-Analysis: v=2.4 cv=NJFAaE6g c=1 sm=1 tr=0 ts=6ab5b45d cx=c_pps
 a=0mLRTIufkjop4KoA/9S1MA==:117 a=PFxtTy0squD/fJwW5Be2sw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=b45o4kL6AAAA:8 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=dOeE5pAH2eQalPq40Z0A:9
 a=QEXdDO2ut3YA:10 a=WgItmB6HBUc_1uVUp3mg:22 a=dhdsR-PFWuPJUldTnwXm:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA5NiBTYWx0ZWRfX94luaU8+MlZe
 Cnd2bJHhsDPTZk3SiOyEIz8NZyrn/XyJJjsfADEx0oPDNZjJ50ayLqSyycWkVB+5sWfPU/1BLpM
 sBQHxWEqRe41EjIEsaTVqinL6M+VY3khQphR/iFH5ZdmLDQG1N/Yc/5nYeFe81LRH4Xy50mtCBS
 uS7YnBdBfns8dGfmlM64ND+lpmLgW3llmjqJLceBm2yYrQbJVzX8wtCx3VPSWl1CZv2oDjcYZAc
 iJ8QFUWmB83xo2NS/QA/NgXR7W0Co1mcWrGRWRoXDUiExuyE+qGY3N4OfEIZMz/vTOMGiaprTOT
 XEw4S0bhsQ2QjoqoB2nEC0/H5HUE5gpdxA5Oee1z5/4+bjJATRHHxDpGCtFIYV35NUw5nWBExnK
 md5HePqtCcCdaZmxJb9vO8nWD11jjLoBLOmzbYwdjrEDtCZ1lyhZzswoRJZ6ZaRqNxj1TYV7D74
 THc4PY5MaaJ8Wu0V5tg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA5NiBTYWx0ZWRfX7XbN+67P09ye
 2C+wSnQthTaTzv3xbhFb4lKFVKnok1+3e6JyXDBPnjB9nlboHxez1jKaJyJBytG/5mREC0jb2d9
 adsdeaeANBuKY7MKqnvkV3UDHygfj84=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_06,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 spamscore=0
 phishscore=0 suspectscore=0 clxscore=1011 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240096
X-Mailman-Approved-At: Fri, 25 Sep 2026 02:41:35 +0000
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

This series adds U-Boot support for the Arduino VENTUNO Q, a QCS8275
(Monaco) board, running as BL33 after upstream TF-A and OP-TEE.

The series first completes QCS8300 SoC support with the SDCC1 and QUPv3
clocks and a TLMM driver, and makes the tfa-optee fragment enable
OPTEE_LIB so the OP-TEE node reaches the OS device tree. It then adds an
optional boot0 hook that moves U-Boot to a chosen CPU with PSCI. The
Monaco boot firmware enters on a Cortex-A78C, which has pointer
authentication while the Cortex-A55s do not, so Linux started there
leaves the Cortex-A55s offline unless it is given arm64.nopauth.
Starting on a Cortex-A55 brings all eight cores up without it. The
board config fragment, its memory map and documentation come last.

The TF-A and OP-TEE sides are under review:
https://review.trustedfirmware.org/q/topic:qti-monaco
https://github.com/OP-TEE/optee_os/pull/8053

Tested on the Arduino VENTUNO Q with that TF-A and OP-TEE, booting
Linux from eMMC.

Signed-off-by: Tyler Baker <tyler.baker@oss.qualcomm.com>
---
Tyler Baker (7):
      clk: qcom: qcs8300: add SDCC1 clocks
      clk: qcom: qcs8300: add QUPv3 clocks
      pinctrl: qcom: add QCS8300 TLMM driver
      board: qualcomm: tfa-optee: enable the OP-TEE library
      mach-snapdragon: add a boot0 hook to run U-Boot on a selected CPU
      board: qualcomm: add Arduino VENTUNO Q config fragment
      doc: board: qualcomm: document the Arduino VENTUNO Q

 arch/arm/dts/monaco-arduino-monza-u-boot.dtsi      |  27 ++
 arch/arm/mach-snapdragon/Kconfig                   |  21 +
 arch/arm/mach-snapdragon/include/mach/boot0.h      |   2 +
 .../mach-snapdragon/include/mach/boot_cpu_boot0.h  |  33 ++
 board/qualcomm/MAINTAINERS                         |   7 +
 board/qualcomm/arduino-ventuno-q.config            |   6 +
 board/qualcomm/tfa-optee.config                    |   3 +
 doc/board/qualcomm/index.rst                       |   1 +
 doc/board/qualcomm/ventuno-q.rst                   |  53 ++
 drivers/clk/qcom/clock-qcs8300.c                   |  77 +++
 drivers/pinctrl/qcom/Kconfig                       |   8 +
 drivers/pinctrl/qcom/Makefile                      |   1 +
 drivers/pinctrl/qcom/pinctrl-qcs8300.c             | 531 +++++++++++++++++++++
 13 files changed, 770 insertions(+)
---
base-commit: 9e002445cd0d47d3965312f12e97a18e1ed8bd53
change-id: 20260924-monaco-ventuno-q-63004d5589db

Best regards,
--  
Tyler Baker <tyler.baker@oss.qualcomm.com>

