Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5718C9830D
	for <u-boot@archiver.kernel.org>; Fri, 25 Sep 2026 14:26:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 90D59812FE;
	Fri, 25 Sep 2026 14:26:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8UlbMYi9ULPM; Fri, 25 Sep 2026 14:26:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org ADF77812AE
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790346393;
	b=o2Amp2C1llIaUeXou8OUb/gbVp7owUHPy64Bq7HU3TQLE9Uo1jPGeAhb9B2U4MeyEZm2
	 +eIkMB4F2QqrP3SH2iTqu8o8fKIqC81pwgrBPjWswxn/zswvdUufm8IW3X6MESKeq6Pks
	 RUywrjP3zi2rqEjdPitm0eAxwYGppZ3uJXtAvDhedWnKak66apziog8L0apiqSHVAD9O7
	 O97i9uNJTiK5Yy7RG1Mk4gFBrQNr6wuYii7+Zu/KPYqBzUcbyRpaEkEOn781+1cM5HG26
	 m9ZlJ1ZmlODp+AtteTmrlWWcyWpsw3DtHcbdIuU3d5CLQv8NwFoXnZLF6VqOIkM5u4Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790346393;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=WkaJ9kh22sZcVRNr/Hkn4qrAjQUcROVGD99sCOXTWZA=;
	b=h78rBV6uDuObeQg5YVlmhceuS5avxUZSVN9A6rvO/nhQp2H6qQHPW0j5MQeABoQlnH12
	 KC6z1EE5GR+XcSBcxBuZYDisv3MNPqmaITIPGC/TxqZu22le8232P34SA6awgOjeeQPd0
	 IfjDb1d05ANQW0ht2egcfBqiFR/x18QSoUfbDyNQ/3fitmwizcHc7f9nGc5O/4n6YkZQ7
	 4nBeEsLAVZUtqAj8fbYPZNkF7W/BnXUCWU7UacPzypYr/R4ii5l2R11hhgi/NVJE3G22W
	 rz8NZk6QW8ZVI2dK3LYFvWPW+2DEH/cV9J9fyVHS9jgmdRfdtBnNnAamL23dT4v0WlQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790346393;
	bh=WkaJ9kh22sZcVRNr/Hkn4qrAjQUcROVGD99sCOXTWZA=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VTOZ75aynQ3so9nW6liticYa41chFCDjG0EIpBdprXRuHtPuhsgwaNi/D/RmgtxSO
	 9SMHGgOADrK6VpwtWNMk0ALCmH0BxTnnp5b3EvVLzakwI1E7WfHckJWag57T6rPFZJ
	 MfeJ1bwNtyx/BLNEDJkabEkUhJWP1gNaPTy5eMbKB2v9v0FjoNGwDiUz6ww6tMZx5f
	 DUXSG+Zz/Ax3f42ux7xHZSeZrCtmlU6DlR0t+5R/Bu6XC5An2P8e29L42n2m7BWVIQ
	 f4UNZu1WSxyigjdlOh66SfIU4MwrJuvzcAoDoJONzWFe02e33Q+8gN+iQXBQAaOBj4
	 lM27F0W/7v7fA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id ADF77812AE;
	Fri, 25 Sep 2026 14:26:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id B811A334
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:38:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A95B140180
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:38:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id r7p4L9p82O-B for <u-boot@lists.u-boot-project.org>;
 Fri, 25 Sep 2026 13:38:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 52FDB40042
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790343494;
 b=LE21QOMJWo+CVRc4iaa+fRmazQoSuIKcKtSlFpdxScWpthKUgOb2NNTgMWhs/CJkwHfH
 7dWGjwOF+v5NMXtDJt5O/EEMONqFJca0lyje/0peBOoX92sQzqedxuDiZwN297ggdYmS/
 WUc9Hx6XVYFwxIP8Sztz/k1pGrPJ7HZKSqScW5lyzUH5rkSbWE9HzUJ4WHfo/KTORDVZg
 ciNi5qKNtc5kBeh8bQAJCccXlu82GzC/ragFzYoRACXQK1eNb0sUFuA5bQJM00nepMH2k
 gSN5jdTfyBl8pImHo3YkdM/94L6LUScpDfNaZqTDX6EfO9MqrUmughT4nQGye71Qi5A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790343494;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Type:Content-Transfer-Encoding:X-Proofpoint-GUID:
 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=WkaJ9kh22sZcVRNr/Hkn4qrAjQUcROVGD99sCOXTWZA=;
 b=Qy+qFdZ7N/A4v7rucEz2f6ZAeiHBLgmhGpCeqOpWLIQQK0vokpLg/JFhfIcuPuwjvKdW
 arE1eh5Auccfn2+NG97J3ZrueOU3HNmiLFo9ew32NA3prChOQxbkiT6rLRUyCDcTiyGMN
 mK8kFa3QkdIxB2jj35m8S+BDh5Je3u1Qf473MpOGDU989rewxE/iWz2YDIrnTw/7jDF8d
 suwNYa18rjE0Fk11QgrMpkgLAMnvvpWvD5AgX2eZydRl+HfLGWzujkrzbDoEGwFyZb9Cw
 Zo2oVt9nlDn0Gjz1mpdY4K82l9gu850nvnEgN8CxfRFme/r3Lh2WdwgeiqDaMnYf+BQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=SK1unKcL; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=E01FRMtK; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=abhilash.v@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=SK1unKcL; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=E01FRMtK
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 52FDB40042
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:38:12 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68PDGHAk2911727
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:38:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 WkaJ9kh22sZcVRNr/Hkn4qrAjQUcROVGD99sCOXTWZA=; b=SK1unKcLvZgrNlxr
 3VrcoGNKEzMl1Lw+z+ue7bzUgQ+iJX7Yjsuu3svhkiDcE/5hQcx7C+w9kMmuavQ+
 nMK5PoKmaMfq6dCh6ABhkn2SnLB+oQbDrLqvqSJd7T1HLxMiG/EjV+TkMJvqqY/E
 1KcS/sVFwnUgm0jVNtK9BzZdq5z8s/4ocuALpnFVHqwSvxXztc3HdEw0MAgg0yIU
 RImEu9ReChthKSEEm9Ked/jSH6hiK0NSu9Dx7DcEU/ejsDRDekvxgyXOnDWdP32V
 I4kmcwiDJ5vPN8u4Er22bluco+oN591kowYJcjsERXKYMw2fTGZ06wy70yo9Ijrc
 KInxcw==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gwhm51q71-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:38:12 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-14388794dcfso853952c88.1
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 06:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790343492; x=1790948292;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WkaJ9kh22sZcVRNr/Hkn4qrAjQUcROVGD99sCOXTWZA=;
 b=E01FRMtKhB+5E19gIMPd10w3qazz+EXYoQcUngkqWBW/Sneq/0DAxA+TjnLTtqe9MY
 b7WVHJPnWi6GA93Vh/pGzNojD6p7F6OHO5KTJ14H6YBG2av+hXmvLOjZSrSQHjuN3w0l
 8GAGjU+HG6yfKTCHCKJcxBAy4XIO13QDRmxoHQbVyQokPctuuDWDvVDDLxdTt8H08Ggb
 vZtWnqKDpQKt5+xk9JWlTU01hhQ0Sy2e/o2VM3NMmQxhuU+n70C6CWr0M2Athe82/W/m
 OuFKw7ygsIdcH6o2Ch3YRjk6K1/+E8p9OBqsXCyqoPIVIsPCdHEaliBXXbeY2jMfzeU1
 OUng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790343492; x=1790948292;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WkaJ9kh22sZcVRNr/Hkn4qrAjQUcROVGD99sCOXTWZA=;
 b=nUCa39iyL1ap5Evp7nfBbulTL2y/OWV3qWu9jnNmL81TZbb9aGXPsd00gkxiO2W7Pd
 TKa7VU5WtiDdKbYfhrykIYfA06FhmSrD7fNz7tXhAcNhb4A5aYdUtlS6TQ7wVjJQlpOY
 3G28SPF3anW1hOjLPUVbnE2Ny1fQ74bPiksfdcuK5CmdFdnGuUbLwMT2PEgMpgMCV7tH
 E0Ou8y8kPS/rk6rxoHTqen156RQk9WknJ4Y/5nOc7YanpPUU4ij8LuMogEUhbkD/Zk/U
 1hQSMYP7JCGTgGnYK1ehukxjBCFOQlFNDm9oSVfuytWt6ob6a70kUA5n5fgH7yH+URuB
 3t5Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBx95ipbszsIP5AltElwJqFSTqq2gF8uL5QzUZ1F7g3RyNISOyyr+JJQj0L38gQRzPktj8HMIbY=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kEo/aAUmx2LFx0riIJgwYlmu+kjYVhwJ7igQgUZSOwZZrUnQ2r
 fvJdaUgPYyEatOZwrKZOgtVUPVjrrb1cQK7+PXdZ2fKyUQV0oBzPmeQDlF2Zc91GucJEhyERzA3
 M5uWnoYnm3Ej9UqmbdzD0CowrKJfdvHX+R+1X3lIS+pTlFf0igLlw2F/SwwHRSFKmSdjw2fc=
X-Gm-Gg: AYBFou0a+KB8Iiec/aTiPeKgAYLvThqoJcml+xOmv3QclmfKQdqovyhRF9reFKugnKC
 Fc6oWFY1A4v1BQbXO/P7F6OJCj3Vpdhr1Gy/QSuu0WjoenQ55cTPdPNFh7cMVAEPVS8ORccSXFu
 xDSP5IfTSbqO29INI2iyC3lOv/gvM/Qv28oM9eSVXO3k3wIWQQia41xwP2TiV+GMHLgXB9/4NWl
 UZOtDLJwmAkZl9+jv4iWF1BTVuNxVJt/C45DA7qkaUuC5bYEh7mKVO/HZaqtVCgs572h1xkhJSt
 hiL58+dPUjEsaZ0rrbUHwezK/oQalNhI+G3J5Z2rLiSKrhEXTsGyRoyf537VYqWb8r+LMVnYfqR
 mD3xjm6Y6FOgFh/QEIwqEW2DFWm+R4j24yNX18+FC+5UfdPQ=
X-Received: by 2002:a05:701b:2205:b0:146:e669:2f90 with SMTP id
 a92af1059eb24-146e669323cmr32381c88.43.1790343491250; 
 Fri, 25 Sep 2026 06:38:11 -0700 (PDT)
X-Received: by 2002:a05:701b:2205:b0:146:e669:2f90 with SMTP id
 a92af1059eb24-146e669323cmr32356c88.43.1790343490593; 
 Fri, 25 Sep 2026 06:38:10 -0700 (PDT)
Received: from hu-abhiv-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-145adbcd1bcsm7706290c88.14.2026.09.25.06.38.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 06:38:10 -0700 (PDT)
From: Abhilash V <abhilash.v@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org,
 aswin.murugan@oss.qualcomm.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, lukma@denx.de,
 peng.fan@nxp.com, jh80.chung@samsung.com,
 balaji.selvanathan@oss.qualcomm.com, abhilash.v@oss.qualcomm.com,
 Michael.Srba@seznam.cz, varadarajan.narayanan@oss.qualcomm.com,
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: [PATCH v2 01/12] arm: qcom: add common QCLIB SPL extension helpers
Date: Fri, 25 Sep 2026 06:37:55 -0700
Message-Id: <20260925133806.1403713-2-abhilash.v@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260925133806.1403713-1-abhilash.v@oss.qualcomm.com>
References: <20260925133806.1403713-1-abhilash.v@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=yes
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: q2N84ahah6w0ghC0LgV_K9liCj8bqF25
X-Authority-Analysis: v=2.4 cv=QYnzLcbv c=1 sm=1 tr=0 ts=6ab67944 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=WN52PlUurRMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=2F8QJI7O2KTJmeVboGYA:9 a=3ZKOabzyN94A:10 a=xE34mhsjmDcA:10
 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA1NCBTYWx0ZWRfX+IF9s2kgXVDh
 8pb9e+UO/7UM702gsLpYM+qSkChLJqQTZMjEFyn8TX9jpxlN2mWoFGjj1lgFisV2rmnB3lIjXAK
 fqHUyurK+g4JXPbLgcCFWE/0C6pu0T+diMpK8TzCVz4jhzJaDXMd9KuTPU4WqbQMY7O3o1GQVIX
 K85haJypPl6HS1l+sg+qVAOBcD5O2tgjfgwOTCWdwB6NQ6EpY5Av3/ka9hg5KeDDQKT/qTUy7Bb
 FSgHE2p+vWTWFb8EnzNgAQdvIGR8xfR9MyzSNQrzmaYwxrTKZd08mSslE7aCCF0EmwfwgPeKX77
 LiOwolKi+WBXKL5IRNSvwcJq/ocpBTTRI+6/5AHxGKQUkG0LGDfZZFVaFucz5aiPg75+UfO9mjo
 E8LyhN0LG7MGS6+iO16BJD6NmysVieZbFSFlMvVO3zLvJiFENCHo8FucvQS55t4vs2bUybnH98v
 08eUAwWKZukNt8s5V/w==
X-Proofpoint-ORIG-GUID: q2N84ahah6w0ghC0LgV_K9liCj8bqF25
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA1NCBTYWx0ZWRfX9UDWGocRtHkS
 pn0vXOu4BP3qi06sfidqBuJM1jQ6gfEVq2699rxjjhUFBs7rcThNT8AbfcjzSSPdswBuJGkgU5c
 hDCwTqLvxrodVPofLhdNSRTLNS2Y158=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 phishscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250054
X-Mailman-Approved-At: Fri, 25 Sep 2026 14:26:30 +0000
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

Add helpers for adding QCLIB interface-table entries and FIT
blobs, expose the DDR self-refresh exit address, preserve
U-Boot global data across the QCLIB call, and provide weak
reset hooks for SoC-specific SPL code.

Signed-off-by: Abhilash V <abhilash.v@oss.qualcomm.com>
---
 arch/arm/mach-snapdragon/board_spl.c          |  8 ++
 arch/arm/mach-snapdragon/include/mach/qclib.h | 16 +++-
 arch/arm/mach-snapdragon/qclib.c              | 77 +++++++++++++++----
 3 files changed, 85 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-snapdragon/board_spl.c b/arch/arm/mach-snapdragon/board_spl.c
index 3293eab8f81..5aa84a3a6d1 100644
--- a/arch/arm/mach-snapdragon/board_spl.c
+++ b/arch/arm/mach-snapdragon/board_spl.c
@@ -27,6 +27,14 @@ __weak void reset_cpu(void)
 	hang();
 }
 
+void __weak qcom_spl_soc_shrm_reset(void)
+{
+}
+
+void __weak qcom_spl_soc_rpm_reset(void)
+{
+}
+
 #if IS_ENABLED(CONFIG_SPL_SMEM)
 /**
  * qcom_spl_populate_smem() - Populate shared memory (SMEM) information.
diff --git a/arch/arm/mach-snapdragon/include/mach/qclib.h b/arch/arm/mach-snapdragon/include/mach/qclib.h
index b44874c514e..10865b03ea1 100644
--- a/arch/arm/mach-snapdragon/include/mach/qclib.h
+++ b/arch/arm/mach-snapdragon/include/mach/qclib.h
@@ -65,11 +65,25 @@ void qclib_set_qcsdi_address(u64 address);
 u64 qclib_get_log_buffer_entry(void);
 void qclib_set_log_buffer_entry(u64 address);
 
+/* DDR self-refresh exit address accessors, populated post-QCLIB */
+u64 qclib_get_ddr_sr_exit_address(void);
+void qclib_set_ddr_sr_exit_address(u64 address);
+
+/* Interface-table entry helpers */
+int qclib_add_iftbl_entry(struct interface_table *table,
+			  const char *name, u64 address, u32 size);
+int qclib_add_iftbl_fit_blob(struct interface_table *table,
+			     const void *fit, int images_node,
+			     const char *name, u32 size);
+
 /*
  * __weak SoC extension points. A board's spl-<soc>.c may provide a strong
- * override for any of these; the defaults in qclib.c are all no-ops.
+ * override for any of these; the defaults are provided by the common
+ * Snapdragon SPL implementation.
  */
 bool qcom_spl_soc_check_dload_mode(void);
+void qcom_spl_soc_shrm_reset(void);
+void qcom_spl_soc_rpm_reset(void);
 int qcom_spl_soc_pre_qclib_routine(void);
 int qcom_spl_soc_qclib_override(struct interface_table *table, const void *fit,
 				int images_node);
diff --git a/arch/arm/mach-snapdragon/qclib.c b/arch/arm/mach-snapdragon/qclib.c
index 7f25f37b5d9..b9a74863c1c 100644
--- a/arch/arm/mach-snapdragon/qclib.c
+++ b/arch/arm/mach-snapdragon/qclib.c
@@ -2,7 +2,8 @@
 /*
  * QCLIB interface-table protocol: generic, SoC-agnostic orchestration of the
  * hand-off to the QCLIB firmware image, plus __weak extension points a
- * per-board spl-<soc>.c may override to populate SoC-specific table entries.
+ * per-board spl-<soc>.c may override to populate SoC-specific table entries
+ * and provide SoC-specific reset sequences.
  */
 
 #include <cpu_func.h>
@@ -15,6 +16,17 @@
 
 static u64 g_qcsdi_address __section(".data");
 static u64 g_log_buffer_entry __section(".data");
+static u64 g_ddr_sr_exit_address __section(".data");
+
+u64 qclib_get_ddr_sr_exit_address(void)
+{
+	return g_ddr_sr_exit_address;
+}
+
+void qclib_set_ddr_sr_exit_address(u64 address)
+{
+	g_ddr_sr_exit_address = address;
+}
 
 u64 qclib_get_qcsdi_address(void)
 {
@@ -36,6 +48,42 @@ void qclib_set_log_buffer_entry(u64 address)
 	g_log_buffer_entry = address;
 }
 
+int qclib_add_iftbl_entry(struct interface_table *table,
+			  const char *name, u64 address, u32 size)
+{
+	uint entry_idx = table->num_entries;
+
+	if (entry_idx >= table->max_entries)
+		return -ENOSPC;
+
+	memset(&table->if_table_entries[entry_idx], 0,
+	       sizeof(table->if_table_entries[entry_idx]));
+	memcpy(table->if_table_entries[entry_idx].entry_name, name, strlen(name));
+	table->if_table_entries[entry_idx].address = address;
+	table->if_table_entries[entry_idx].size = size;
+	table->num_entries = entry_idx + 1;
+
+	return 0;
+}
+
+int qclib_add_iftbl_fit_blob(struct interface_table *table,
+			     const void *fit, int images_node,
+			     const char *name, u32 size)
+{
+	int node, ret;
+	u64 address;
+
+	node = fdt_subnode_offset(fit, images_node, name);
+	if (node < 0)
+		return -ENOENT;
+
+	ret = qcom_spl_get_fit_img_entry_point((void *)fit, node, &address);
+	if (ret)
+		return ret;
+
+	return qclib_add_iftbl_entry(table, name, address, size);
+}
+
 bool __weak qcom_spl_soc_check_dload_mode(void)
 {
 	return false;
@@ -43,6 +91,8 @@ bool __weak qcom_spl_soc_check_dload_mode(void)
 
 int __weak qcom_spl_soc_pre_qclib_routine(void)
 {
+	qcom_spl_soc_shrm_reset();
+
 	return 0;
 }
 
@@ -60,7 +110,7 @@ int __weak qcom_spl_soc_post_qclib_routine(struct interface_table *if_tbl)
 int __weak qclib_populate_interface_table(struct interface_table *if_tbl,
 					  const void *fit, int images_node)
 {
-	struct interface_table_entry *log_buffer_entry;
+	int ret;
 
 	memset(if_tbl, 0, sizeof(struct interface_table));
 	memcpy(if_tbl->magic_key, MAGIC_KEY, strlen(MAGIC_KEY));
@@ -68,17 +118,10 @@ int __weak qclib_populate_interface_table(struct interface_table *if_tbl,
 	if_tbl->num_entries = 0;
 	if_tbl->max_entries = MAX_ENTRIES;
 
-	/*
-	 * Reserve the "qclib_log_buffer" slot — common to every SoC.
-	 * QCLIB fills in the address itself; SPL just allocates the entry.
-	 */
-	log_buffer_entry = &if_tbl->if_table_entries[if_tbl->num_entries];
-	memcpy(log_buffer_entry->entry_name, QCLIB_LOG_BUFFER,
-	       strlen(QCLIB_LOG_BUFFER));
-	log_buffer_entry->address = 0;
-	log_buffer_entry->size = 0;
-	log_buffer_entry->attributes = 0;
-	if_tbl->num_entries++;
+	/* Reserve the common qclib_log_buffer slot. */
+	ret = qclib_add_iftbl_entry(if_tbl, QCLIB_LOG_BUFFER, 0, 0);
+	if (ret)
+		return ret;
 
 	return qcom_spl_soc_qclib_override(if_tbl, fit, images_node);
 }
@@ -146,9 +189,13 @@ int qcom_spl_invoke_qclib(void)
 		register void *x0 asm("x0") = &if_tbl;
 		register void *x1 asm("x1") = NULL;
 		register u64 x8 asm("x8") = entry_point;
+		u64 saved_x18;
 
-		asm volatile ("blr x8"
-			      : "+r" (x0)
+		/* U-Boot keeps global data in x18 on AArch64. */
+		asm volatile ("str x18, %1\n\t"
+			      "blr x8\n\t"
+			      "ldr x18, %1"
+			      : "+r" (x0), "=m" (saved_x18)
 			      : "r" (x1), "r" (x8)
 			      : "x2", "x3", "x4", "x5", "x6", "x7", "x9", "x10",
 				"x11", "x12", "x13", "x14", "x15", "x16", "x17",
-- 
2.34.1

