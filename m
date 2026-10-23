Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC599606A31A
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 19:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=YzKxKLO7;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=igkDGM2e;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=O2691ir1
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 158A481673;
	Fri, 23 Oct 2026 19:51:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id u2nPY6-KE5HO; Fri, 23 Oct 2026 19:51:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 36B0D81671
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792785074;
	b=e827gMlh3Tn2AtJhe0k11GJU1zn+RPjy9II/5B9KZs4jhB8hoS6Rfzw3wGkhJMinDRry
	 me7u3Hhpn/649G46o4rUczWnL46BocqDMEx6ARE2PtpoFAarJf5g+31Lt4NvHAQU+eZAD
	 dTdb+Ys+mxTPJftu64tIkplaCcx4vGOdLuJ5Tdnb1+qvKt8bLGXtfZmX16/QMN3vDBn8U
	 ajrvlM7Xf9Z1ppnlimNAe1mNQZ4r3FyvvP1Dcqh8+w3TwxMN2WkX6n/AiBoyKvlpR86Ga
	 zoY1oa4SsKuMSxzDQMPErBpcpul+d9H26KZ5/R6e1SeT3xAGHN078g4ZFP9CQTijjfQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792785074;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=m2Gtxb0+ZviRJu6s8MSXf4+FQKm996Gx2+on/a9ZLOw=;
	b=WTqdssYMvRgswuUOqt2KyvN2hV4dcs14QN53L7/d/W80SZGcC6+JR7hDfH3ePk4i2EdI
	 EfJlsRpw2sC7B3viEUfiTFOvlk3djv2V8nVvY2WJvAHDo9b2HpfKkXVTg+TMZ8Fbzidxx
	 zBTOZoCAWXmGapINHGbVEftTQuaOHFnR3s4EykLsibyBIH4hZbYV2LacaG+u59agtESVS
	 MvuIGTdYCFBBRIE+46sm0SbrLtVM5somol8IWevZyCoItqMm0jMmLs3u4YLdsdViW+bJE
	 E6TJ5MthBdCa3JqfKjXzXEHgFAosx+mi5q960luLywgERHEgg4f81eQ9eYmXIaWuYLA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=igkDGM2e;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=O2691ir1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792785074;
	bh=m2Gtxb0+ZviRJu6s8MSXf4+FQKm996Gx2+on/a9ZLOw=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=YzKxKLO737WLeM84axGTLi1sFrX88ORWoBa/ZbONL1aWAe2oWkbaH2ZOYNgrnUx1m
	 TlnzaNgftb08RhKuEq9lQad/dMbNzh5fDso0RFl4nmUaXsbWsQ0wB/wNqqmeV25SwN
	 gJ2m8xk6/eef5elIV53FeNhqI+rwyNy8vhTu99I1Hr4OkCiNMnHaJD+Qt8zYYnab95
	 W3lW4cviPU7BOh/Gf+6rsmq0hwOCSbW2YyaLv+ap0R8+ZRvAwLgXrJMYj7ZWJNabGI
	 k177n8ODl4Q3LM2+3u8Mn0hC7oJQiGM+luuAwww08XBOFQSg/LwGaPcv8hlSgUb1Jb
	 G47/yeY8Mj2Bg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 36B0D81671;
	Fri, 23 Oct 2026 19:51:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1D1003C4
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 19:51:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 02BA981672
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 19:51:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oqi0-oIgQqUV for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 19:51:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1EE018166B
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792785071;
 b=gdfPEVzZwzN9N3l9NkOuPvrtZzCcCcQvxgAK0tx/PxdByKRmqPd5AYV8PjOrLj+T/PAE
 ieQ3bww8qXtfPwRggz+/CuFcrjHgYQDC3D5cnE4Zs9wj0pvS0o82UAvQbO7rj3m8Z5I/7
 yZx4p1rrn/wdUnT4dWDB2h+/vLrF2c6wsbBMGn6dd26D8TucUxEWE4+4Opo88zmc1dv4H
 lkeImkhH+ijitP4+RqDlexHCeI4UaSmAqf2hZ5zVGQTetVqJZlTFB0JUFHZBV7XUZl51j
 fwCapeCCC+yDSV2+mUcR+12OQvBRzEM6quOIRUxadHO51y48x9HkhVp6JwvzYBG6Ieg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792785071;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
 Subject:Date:Message-Id:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=m2Gtxb0+ZviRJu6s8MSXf4+FQKm996Gx2+on/a9ZLOw=;
 b=L1hm9TwYV0bilYDjqpBiWr65kYMpi03HS4W2oY4RWzl3PwCKFVq7zPbKP/uyzB7KVcny
 i5cYT74+3QYlMwULhNxf4Qb3crSamkdzNsPb4Bqk9yExZU3+f/OA41tOaWm72Oonmqkp7
 DXLgQU9/e82edzrIUi50ZcLctEJihqAJl9ZvODzMa+tb0kE825/iaD/fqTNpjIUQr0lYh
 ULrExg73slZzCfjsPbnuLMyXelCoG/+YkHhCbmfBSvzU8AXm0jbndyk3LVb4654krgzVS
 3gPBizbAu08S6GHXKU7R3/0tsYBLPXVTjcJfXf8o5SrPY3HE9pzGDSjmJqK/1f9Vn4A==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=igkDGM2e; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=O2691ir1; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=igkDGM2e; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=O2691ir1
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1EE018166B
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 19:51:10 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NIZVBv463421
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 19:51:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=m2Gtxb0+ZviRJu6s8MSXf4
 +FQKm996Gx2+on/a9ZLOw=; b=igkDGM2eaBwTANdqu6Q2yz94CqqVM9UVXSXuEV
 qdryRdDK59ULgddgpVJB4DxaiOdWn9Q0gSUEbJ7NCp/lsG1k8N9w9VprEAnKSbTc
 aMcNaArJ8hTwOSoLXrr5Zneflq1wQoLi8yrmSDlT4NvMVRvnSShtwd0QCpgXAht6
 WXIw6ezZjN2lsBZb5dyeIMEfP3Cd6StziI064RQ3dBgCao7+FYRFGHrsiyJjkeV/
 3MBYfZ4u6jDndX0wks0JKvxjn/CDM8yZtnD2x4tGsxiBPj1T+oRXPouIUSOqJSdy
 +J9Yc89IM6Z2JUSLHJ3h14NI4JKf8NTCMFEYAPr5SGdbjxfA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hg7bw1puv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 19:51:09 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93f6f4fe531so233579085a.0
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 12:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792785069; x=1793389869;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=m2Gtxb0+ZviRJu6s8MSXf4+FQKm996Gx2+on/a9ZLOw=;
 b=O2691ir1jkLY+HsJvgCy/Y1rxEjrJmaVt66ddf/WL5Aq8YvmG1DUEnvgJzVfAVDGyn
 Szt3TgKuyskxu9EEnodLQaTy6Df34ZbdrCwff7nyFrUtsjeOp2yF2NPIHQpg9ZZN8Yot
 KZMRY79vvYstP4xkAcYRaGAvumD/IPwzILz0dkQWc+GDIi1W8Ns4+CCSysKe0OgNiPo9
 +Vh94DzbD7WwVZnRusdr+qesE84qa/taHx8UYEQpyAtMx24/jstIbktwNO/ZUKWLFrhI
 b24eJuUtgoQ7UiFmDmd7NFcWqTEKJH6UExh2SkWGNDHBDyl7g+Zm9jnpSEIrYhW7x28i
 v8YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792785069; x=1793389869;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=m2Gtxb0+ZviRJu6s8MSXf4+FQKm996Gx2+on/a9ZLOw=;
 b=l3p660m+iELR6PJM8CVo5ngu+zrK+JEqza4FSHAGwpOn4PfrHGoFZ2u/H+Kat+dwUd
 dwzf0BaX2QqVHT2Y4Kw7q7yCwBhR0rr51mULr4Qw3FiQFkJJU8ILkyF+31pxkf+T7oqW
 5Px7Dta6oQH5BcTT4/EE+cuT68F2SAOk2uhb7bs17Du/ZNYJQK5S4vezEHPFVKYnTIZL
 Z2rWZG16jAO9jZGMaj0eqpS8yVuaaio98Q87EoYOjkhf8qth3nlm5f/360rxBj5Tb0Jt
 nbz3XQ57Y3yVscvlSZq7Dnu6R67IOdWVuzCZMFV9TsSzrWR07URJSzYNLnZ95S+vcM1h
 NUqg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwYqOOKqhkMhaKbLtxyY9H1OzBcUF8tg34RFJIiKSehPbS5Nx99hGzSkm5hbW1C0O4VL5GFPGM=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKlitTlBMhw6KYJIs5xjzLkON5Oq6bZng5B9qMgU8AM5J1z33Yh
 1JjcQO0Ew6H/kDERmvs+4qa1EtTCaIoni9ZwLlNCXPIXWhYeMKLuEGNiEoeFzOGBwTLEXBF5xAU
 N6SWKYNHTWpKQzuX+iDMUK+2lCL71Ge/PGGh1PP2RJNT1ww0WsW0wrgUOoFnPxnohys1LUEc=
X-Gm-Gg: AYBFou2QXYBFJw6KdM3yXGR4WhSz7mJ9Kloptuoi06+vQkQ+2i8RYGtZ2qMJCwQ/kQE
 Gjb5nwMCpPVdB5PbaXhzmuioXkrdvW+tMy6vb5YCWYR7y1Ir04K+OiwIcePNYtgPibUAoid6OlK
 tr4AueTG3Jl4XdkL6hD+TjSAlmx+YAViGEgYqhe/wF/6QbBAfnPEmcPDKMLc4e7nbLH68BAfI/4
 S8OJJ53ROxTnSOUCGbuHvVhIzj+CnOJ70WBc/zNTAg92IO0uW938rL8Xm4VZIZCwn33Xxdl/4of
 YlpI+a8lUm9eyMe20oMWHGMCIQMStcnb/8MJzfDSbFjfA6WyFiXknnRNemkHnUVEaSm7hOAWcID
 nLhI1Cm+utx8bqooDjaSaMyrGuTTMrmiV/fi2wdxIUrQL7ow=
X-Received: by 2002:a05:620a:1a24:b0:93f:38c7:70f4 with SMTP id
 af79cd13be357-940ef90195dmr11945585a.26.1792785068547; 
 Fri, 23 Oct 2026 12:51:08 -0700 (PDT)
X-Received: by 2002:a05:620a:1a24:b0:93f:38c7:70f4 with SMTP id
 af79cd13be357-940ef90195dmr11942285a.26.1792785068085; 
 Fri, 23 Oct 2026 12:51:08 -0700 (PDT)
Received: from [127.0.1.1] (185-164-143-216.cgnat.inetia.pl. [185.164.143.216])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd7984f5sm456366b.77.2026.10.23.12.51.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 12:51:07 -0700 (PDT)
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Subject: [PATCH 0/2] libavb: resync with AOSP 1.4.0 on U-Boot's SHA library
Date: Fri, 23 Oct 2026 21:50:44 +0200
Message-Id: <20261023-upstream-libavb_b4-v1-0-97ed25b09ed3@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWOUQrCMBBEr1Ly7WIbqqJXkSLZZGtXtCnZpCgld
 zfRv3nDzDCbEgpMoi7NpgKtLOznAt2uUXYy852AXWGlW33sWq0hLRIDmRc8Gc2KN+zhhJrOvW1
 dZw6qFJdAI79/o9fhz5LwQTbWpZpAIwQYzGynarkx7ROg9xGKrIGJJfrwqbdyzl/OtpZZpgAAA
 A==
X-Change-ID: 20261022-upstream-libavb_b4-7b2e94c0d1a5
To: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Vincent Jardin <vjardin@free.fr>, Petr Hodina <petr.hodina@protonmail.com>,
 Bruno Banelli <bbanelli@gmail.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Jan Kehren <jan.kehren@emteria.com>,
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-ORIG-GUID: oeaVvQGgQooSfUVBMW5SHRGgJjpC7_pn
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA3OCBTYWx0ZWRfX0MSTFZws9UTk
 60Kgys7DnrvKVvUpG2VkXB8hwd6SvabmEyaNcrM2RWY+ffv1vYdr6XMlSWgjzLnFDwyTIdVMCMG
 Qz+pOHa4IodfSSGGcUKrZCTxldiCmZ8=
X-Authority-Analysis: v=2.4 cv=QdTzLcbv c=1 sm=1 tr=0 ts=6adbbaad cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=+XDFW8w5h4l+9U6kKVkjeg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=KfvtO5_bGylaNj-OXcIA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: oeaVvQGgQooSfUVBMW5SHRGgJjpC7_pn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA3OCBTYWx0ZWRfX+eCGHdiD2J3c
 0QMmMykuWLKuxPn+rSjKIXFfyzcbjzNOOpV+WYGoGchfwXb30/6ZRe6bPHL3KqiSmhL7zw4KRpa
 MOv+sJlYBRT/g3g7hyK+XBCCvOq5zHU/yYLZOOUqTQ6ug2a1qHsUyOyxyVAaJ+1TDuwc5OLbl8x
 UMj8rpyRRiiaZ3/kQ7QMIXWbo3dB3IHbA3whw63BOf4HXz7xNw/HcqTUSvjjtKGHGfE0ockV+TH
 0O6MK5k0I2CwZlEx5WMODjtGmw11v+uvrWxU8M1WlNHEyUEoI/Vc5XcEyIUaC+h8zwh/DQVJLAa
 KBPrSvB9A+CS4A4fioRnDSpyUq0ydFdnQvwx4yyfDqvwAyrsxU5gaLb0Wg/Ubk1TetSCOytholp
 tQEJhvDRnyemVGYy7T+iO+792qpEaLX7p8KvkuP7+uPFbawRgcaeqSanfcU6T6OARf6/G4E4fgW
 vAWPn2U9MtCvFUFLJGg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0 spamscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230078
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

lib/libavb is a copy of AOSP external/avb's libavb from 2023 (1.3.0)
with U-Boot glue. Upstream has since fixed a verification bypass in
chained vbmeta partitions, a silent failure of RSA verification on
allocation errors and out-of-bounds reads in the key parsers, and
added the vbmeta digest command line properties that newer Android
releases expect.

Patch 1 builds libavb's SHA-256/SHA-512 on U-Boot's lib/sha256.c and
lib/sha512.c instead of the bundled implementations, following
upstream's crypto back end layout. Hashing a 64 MiB boot image is the
dominant cost of AVB verification, and this gives libavb the hardware
accelerated and mbedTLS back ends behind the same API.

Patch 2 is the resync to AOSP 1.4.0 (external/avb c5066a96caa7),
The ML-DSA algorithm types are imported with
a stub back end that rejects such signatures; the bundled SHA
implementations and the BoringSSL back end are not imported. As with
the original import, the AOSP files keep their upstream coding style so
that later resyncs stay diffable; checkpatch is expected to complain
about them.

Tested on sandbox (the AVB and bootstd tests pass) and on QEMU virt with
OP-TEE, where the Android bootmeth verifies and boots the Cuttlefish
Android 17 images with the resynced library.

Based on u-boot-dfu, which carries the AVB lock state series this
builds on; there is no dependency on other pending series.

Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
---
Igor Opaniuk (2):
      libavb: build the SHA functions on U-Boot's SHA library
      libavb: update to AOSP 1.4.0

 lib/Kconfig                             |   2 +
 lib/libavb/Makefile                     |   8 +-
 lib/libavb/avb_cmdline.c                | 109 ++++++++-
 lib/libavb/avb_cmdline.h                |   2 +
 lib/libavb/avb_crypto.c                 | 348 ++--------------------------
 lib/libavb/avb_crypto.h                 |  21 +-
 lib/libavb/avb_mldsa.c                  | 136 +++++++++++
 lib/libavb/avb_mldsa.h                  | 144 ++++++++++++
 lib/libavb/avb_ops.h                    |  10 +-
 lib/libavb/avb_rsa.c                    | 398 +++++++++++++++++++++++++++++++-
 lib/libavb/avb_rsa.h                    |  10 +-
 lib/libavb/avb_sha.h                    |  27 +--
 lib/libavb/avb_sha256.c                 | 375 ------------------------------
 lib/libavb/avb_sha512.c                 | 361 -----------------------------
 lib/libavb/avb_slot_verify.c            | 116 +++++++---
 lib/libavb/avb_slot_verify.h            |  13 +-
 lib/libavb/avb_sysdeps.h                |   1 +
 lib/libavb/avb_util.h                   |  10 -
 lib/libavb/avb_vbmeta_image.c           | 118 +++++++---
 lib/libavb/avb_version.h                |   2 +-
 lib/libavb/crypto/avb_crypto_ops_impl.h |  43 ++++
 lib/libavb/crypto/mldsa_impl.c          |  57 +++++
 lib/libavb/crypto/sha_impl.c            |  50 ++++
 23 files changed, 1166 insertions(+), 1195 deletions(-)
---
base-commit: 4dbadf86e2799f29c9c6043d3bcd81012a82ae47
change-id: 20261022-upstream-libavb_b4-7b2e94c0d1a5

Best regards,
--  
Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>

