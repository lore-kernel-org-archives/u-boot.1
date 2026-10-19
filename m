Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD624CCF2DB
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 10:28:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A6F63606CF;
	Mon, 19 Oct 2026 10:28:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hRu3xpj7hGeI; Mon, 19 Oct 2026 10:28:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org DCD31606EB
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792405722;
	b=LuCrNIVSH0tGJVCRpqqZ9Ns0BM2tqfq6iV3tAnM0Tp9JvgIlk52i5KL99zNqoQGuiNw8
	 p/D9/5sCko2QWxunJMAhc78l3CBUpgs2sudbotS+zVS4wgrukFm5skBjuNMOcVMhNgUMq
	 YsB7Jk/DHVCShFT1rmToquGI843/izxKltPmh0xeFRPafc0o0cYhbTe94yoX++eoQ7kTw
	 QbFV8/09Tsp1tzfYeGuYO7KomdugTQ4IOXgz1xXpxJ8O2BkDxmqPvJq/L7rW3a3JUbBFu
	 J2DinhlVPxY4PGS64/HBCIhfFgsEyX2iF/k+RXxF4WSORMuLy15H5OXpbynlBV0LGXQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792405722;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=9ljailM8eQtpc2piapapGkA0P2Af9PO9OssKi2WPBzA=;
	b=hdsZJI/3XdS1qYaD7GvPo+AN58jo/rA3JpIw2zO62jkGiwwjogtFtMp7TlkTiHjSSZ7Y
	 X6dL22Eu2fwVgjvovQRrOMydx+lngEN0UPVU/HCBAcnNEaYL9nrXCAgnzrIlsRW2Q9PIN
	 A6gweto9UtEOK72eATVJtoKyWUFHHA7Fx9ztPcDcXUZeGuGEG0Bg8Y++EpFxPC8B7o5G6
	 O1qQQ1h49AIev/YxAwjpbBFHvROC2ijFodQWhR0qxaiH4FxTRAbYyp13JKhDeWGma+uhk
	 y8Si+MhFvN1AqXVtt1bCXXyfEFXE+6mseG/zEBOmjn5KKZkAhMQwPGc7vqwztLt3TMA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="cNEb2VZ/";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=CPOcOfb4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792405722;
	bh=9ljailM8eQtpc2piapapGkA0P2Af9PO9OssKi2WPBzA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ysqL/q1xbEuzpqYs/o1V7pACSNr/Stt9a2Ryuqls+OSC9O2gRia9fX7JjaVznYNKl
	 MqHhzzryjEeYFZmPlb7TqEql5Tf4XBGCo5gm9AFSg4ojoUxGCvRWGpEc0E1afg8WZG
	 eNvcsJg8y3i1hFxPAc33CWGgfcBEf5z2XtPKFLgF31JHgX/VO7VHOK/IjybHWdsEPb
	 rtU8giP7Qt+B6f/NVYyTsju6a6Rj/iCjW0T2cZfzfv+LCkO2ECFp03aKSVN6YJ+nqg
	 gioRt1P2JgMBlcCNGkV5d7Qg2Wyzg5tkMDmRtnYzYmVT3KFmBUfvgd5nlDc/gm7+Lt
	 U92lw5ZxTXLZQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DCD31606EB;
	Mon, 19 Oct 2026 10:28:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1CA232A8
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:28:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 033DC606EB
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:28:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DJIuPNKEiHwB for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 10:28:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 22C2C6071B
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792405719;
 b=BRhSDbEdaLD0HO29W0ZjZ3CdxTtRGUwvnzP5kGJs8qqu7OAzBono50zcQFIQ0qdJF3wJ
 F4U9R1f0NdeEawVllY6d65z/gRn/YbzcB7zYRYi3DKO/zNMJXgbH3AHstS20WNXLkyZIo
 D4G5K6MwuPdfFK9AyuoFSmzIp2VfNpbkhhNOqlTfGzrESYl0ioTh/1iYGGs/nHUYohmBr
 rBUatrleAtJWUd8A2bFRBQjoHVio4aosZyRiJRWAQgcLtRVlvT13ED09WT6+PNt8PXkZT
 O/h3OxVTKs0CsO2ASBXw7+F4FreYmVNCe6Xt74MsAHZ/0tTLPoib+mXWc1tC+M+06oQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792405719;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type:Content-Transfer-Encoding:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=9ljailM8eQtpc2piapapGkA0P2Af9PO9OssKi2WPBzA=;
 b=F1zMYXP8R3/TYwf8s4MRJkhBmpO5fY5Tjg0bwpFfmh7t/FZcpH4e7d/wMOou2XO+8r5f
 eaH4yDo+vU3fo0RuXbpqo5Sl4eT92VEFJRhqeBMvtnjnU3HDkL5fkAxyZrS4DKB2Z0JCN
 DnveYgTwZy4/Rv/otTwOmE36tiD/PpNOIcZa9gIc7oq0dFt0f0q2Pyy3J9erVOEt8+1FD
 whNSHCHhCnSL062HbcBp4Ju5bvcnFDUoxGLjBXqepBNK0lCbccrlGGa167TppAJ8QbqL7
 lLQMiWREr0kE/wcpnoVoHfm+Cx/N7MC13nrk36ji2BQA5m+loFhPBQETPmzBuIIb3PA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b="cNEb2VZ/"; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=CPOcOfb4; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=cNEb2VZ/; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=CPOcOfb4
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 22C2C6071B
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:28:38 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J8OuGI2752301
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:28:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 9ljailM8eQtpc2piapapGkA0P2Af9PO9OssKi2WPBzA=; b=cNEb2VZ/m5tukSkd
 YDgphMl1O70fFVTanb6oSvqDqZWpRsBe5jJh5y+dWcn8MF7tAsnCX04hfv0IH36V
 aJ8poMy76e4TT5AnHEjxdGPy886yJx2118PWHEetkoNBsZaLLa4OJ+drcWT5QF35
 h6SGUi24ZgUFUv9B22KuOyJi8etGMtGtvnoqf96rMyww9qkVi96LPkLJrYkNuR64
 AZoJGIZ2nBQGVtwJ4W4H9VzyVLe1d/W17bExj34/jQxwdsZqLgQHJnYV7SfRfGXj
 +PS8/GcueK+rQ5RfwuKH3YcIj909RWNd/EZHG7FqAvubJ5ZPjFgoYX68qKqeM7yc
 Ws1yFg==
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf48gkxv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:28:37 +0000 (GMT)
Received: by mail-yx1-f72.google.com with SMTP id
 956f58d0204a3-67994567a44so2672676d50.0
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 03:28:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792405717; cv=none;
 d=google.com; s=arc-20260327;
 b=kjIbk0rD4y8dYCs1JCSHVrqpP0xfJn8YbhnPlrj3qdS1ldrctAP8v0L36eFQasAuzR
 +LfWeneVrmb302u4olUULzOXVOlGs2eYjzxMlrqty5MrqukcCW+om25GrxpR1XJCYHyF
 yLx0LVUCKIgkwMyqx4H9P09Y+tJ9+Jtk00GlzBAiFjf1bCgPGzMBfX0LMTK575z7/WMJ
 EgcNTkNG5/k6mcQEzwox/HHh7qUK4LEFGlebZrZHqbKGxPkPD+hFsBMs4RBQyux4mQwX
 iYoUEl40WF4Wq3zXtHp/9FfFXGRs4zpHlzagXrR6/l2u76ykNsymgOzDJyg7BDtgLbMe
 LrmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=9ljailM8eQtpc2piapapGkA0P2Af9PO9OssKi2WPBzA=;
 fh=UykVtw3aQ9ACoqKEnJLxBywxHUD2pirsEpWf9V/+tH8=;
 b=IjTdvwx6eYfBaiOZDX+4EkPoidzaWL33kRLbMr3TUvUYySjwLUt3et3ihmQ8QqXfT1
 8md9GEUWRdO4kRW1aJSk1Dx1tx769RIeMPSIcMHb3ZRWPxJBDxrmQ76pVKw+Y29grXO4
 lPWYUpt0CJydRK06tXFCxWDva2OlmFzw0xO1rs74vDRmTjm8HLforFxKcpvxEqwV5RIZ
 EULydSbHHePCXmTnuRu6+jNRwlvDOLGA5RTWrfx+1nkecK9SIa+uelG1leWenOO7bz2H
 z6zbo2KhoshE9F0fwpd5fX4UeDyuMVi7AD5hu5EeGNnlclLuwDMCZUcAmdJ5+XkNikOm
 GoVw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792405717; x=1793010517;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=9ljailM8eQtpc2piapapGkA0P2Af9PO9OssKi2WPBzA=;
 b=CPOcOfb47Ywa2dlW62wMKODU9lrPX1sFCa5ibun4LYjbryoa2alLBPY1pn765ZP+Df
 T06/+WiNtjHgSz/nNenq4A+cvW4q2zqxB+Qbl31ej73h0m8LsrwY03ccuyrxeetOPH6Y
 ScD7EIBj/MYS8Ptup7XGvdGStfG7dGe54XtPU2ejTqEIYlzzlklMYJ0ohLc+wvrfsxgn
 QvYrTI/n32Xw3azYx0ExG8ErdYYUE9P8tGxFgdmOKF7xXfdhydpVz7ivOgfjgyK4J9I/
 bANdV0MT9giSz35wT8HNNTZYZ0UaXNYNgnlYF627GCu8H3bYRsmgQXUdRDeHFjqzjuZx
 jpMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792405717; x=1793010517;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9ljailM8eQtpc2piapapGkA0P2Af9PO9OssKi2WPBzA=;
 b=CuQVhsOjvJ//u0K1Vs7+PGu3oO5nSensvAVbfXTzIX9PWKlY6oFMBtNnif5Ab8Idby
 8JLbefU5fIx5J6h0Ftf8Q9qWWPSgvC0mCOGFj+QI6HEKV9ssQSjfR0NL6PpffMcr7nvw
 7B/bU8otyhkGeSY2cdCBNBIOFINNUOfL25O6c5T1X9KkqUObh7TN2mYafyhetpW1zqUr
 YfJlDmh+WkV4NHlNmKMlzerX9J4PbwuriXjMwbvCa5Lj6gzvGzjRyNhUchgoPkI3MiTG
 YrTvDyNZhDGrGQXhgca3tPNSWKWTwc5LKjbku3CrAafUEzPI1gdV56EvUjJzietOYE+N
 BSjw==
X-Forwarded-Encrypted: i=1;
 AKwUvByPA2aLz6HZqsOlxWJdqMfADy/bIcyNVPlSnJKrl9WEFo22AAvSi675urvsXq1u7mUJi+7025k=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKYzcm32rLn/jw3dEL9r5LGbE86oeWG/j3cO8q06oqKb4M28Y+k
 X2GwWPfQQAhdb438XJ5adywEObrGS4IBAD/f35IKKe9s0mViHr5hPkZ7C4nVJfEzr5IOqlmq6Kd
 a0iua0+YJSDcC51fg6ZwuKIgNZU2HPVgugr9rE7nSsT0s3sSxYgbHT5XrVfzKyXaUZIEvEZvxCd
 f1U0QsZFuHlBDl8Wwh5XyUpQElJLwfLFkTODENA3awC2MXYw==
X-Gm-Gg: AYBFou2KjYptPfyf2/xvWLh9bj+s9HulBTC/rF4Aj8kjSF7plQJzzJAR2uHmMBdPReI
 uODBwV8Vx4D5/sG1x/0QTW/Mq4ozWuI0Y6YzVYTERW3GAgZgfvP6jrcAwqHq2d7E4r1FaV7YW2S
 63OYik5hKxTp5HY/JMztRBAIZ4i5BixoI5O+yu6whCDbg3Idvjk8vxi9J9+w==
X-Received: by 2002:a05:690e:488e:20b0:677:d759:3939 with SMTP id
 956f58d0204a3-679ca7aab35mr1352727d50.43.1792405717116; 
 Mon, 19 Oct 2026 03:28:37 -0700 (PDT)
X-Received: by 2002:a05:690e:488e:20b0:677:d759:3939 with SMTP id
 956f58d0204a3-679ca7aab35mr1352721d50.43.1792405716641; Mon, 19 Oct 2026
 03:28:36 -0700 (PDT)
MIME-Version: 1.0
References: <20261015-test-avb-fixes-v1-0-9e5b82644359@kernel.org>
 <20261015-test-avb-fixes-v1-7-9e5b82644359@kernel.org>
In-Reply-To: <20261015-test-avb-fixes-v1-7-9e5b82644359@kernel.org>
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 12:28:23 +0200
X-Gm-Features: AclHuK8XUD-OP1LdwAEkbSCu3TSHeJm1AC6Nau4tr2AmqG1Y4GLdny1zQiKwSPk
Message-ID: <CAPzfCAarQao__8FE=k82KS0mhHXv0zzug1vsi4TA6m4Gqp+rfw@mail.gmail.com>
Subject: Re: [PATCH 07/10] test/py: avb: Use format specifiers instead of
 str() for mmc_dev
To: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>, u-boot@lists.u-boot-project.org,
 Jan Kehren <jan.kehren@emteria.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA0MSBTYWx0ZWRfX1zzYy1diNZrq
 cmnliJAaaNLOBsrBKQxFfiaiqelG/xzreO+rRf9AaAolqSg1iVaw4xl7byvh/CTH2WdK0MFQiZt
 Wx9wLo4oXwH2ouwsajJFRjG7m2q5x4gBPp9z2eR4k4W6R8s7UQ2tbAaJ49Tqtx40PMlQi6QjYuB
 0cwWkiPft+wk5o7aC1kZK9NoGsaAPHHquesM13qrTTFEEKmH1PxXHmN7gmKUsl2MFvfrceBRF1m
 CAUOQNuZRg7zRcJEvW06fb+YTsIAIGdLx0eAz1z8kFWjgbVhTGO0/D/91nlPTgi6C+bhVmPrvG/
 n/fc/n4HxBcjOrYsyQ7YBbdy6G0L7k0d14LZfazoimXsPK4bdpXlrKZmIaHaRWfElMqamhP/c/B
 xi9z/m9q+3BsiRESwbBiZ0xZOgjYzP/3KaPzSoJPS2bO8XGlRJUN6SVbPnoV81cRMFGxzVZeYxE
 LTlKmXYMg3N9muff6LQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA0MSBTYWx0ZWRfX48cmuNlqs5OP
 ZFPxH89EMGU1QM3GF2jjl/TLyswbot4EBQBn+tIzeKegmQJ3kWMwzbvwAt9TT6b1DcqFRqDrflg
 kqxeV9fm3pcG84ja+OQkf9XXAUKx5AA=
X-Proofpoint-ORIG-GUID: ud_op7_aLweXHurNRsW3rkPuM74IR4oa
X-Authority-Analysis: v=2.4 cv=Qr/LTlyd c=1 sm=1 tr=0 ts=6ad5f0d5 cx=c_pps
 a=VEzVgl358Dq0xwHDEbsOzA==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=2CJ50WXqNmR4tNz0luYA:9 a=QEXdDO2ut3YA:10 a=uujmmnXaIg8lM0-o0HFK:22
X-Proofpoint-GUID: ud_op7_aLweXHurNRsW3rkPuM74IR4oa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 impostorscore=0 spamscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190041
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

Hi Mattijs

On Thu, Oct 15, 2026 at 3:55=E2=80=AFPM Mattijs Korpershoek
<mkorpershoek@kernel.org> wrote:
>
> The tests format mmc_dev using str() conversion, which produces a
> decimal string. This works when mmc_dev is 1, since "1" is valid in
> both decimal and hex, but breaks for other device numbers like 12
> (0xc): str(12) produces "12", which avb init would interpret as 0x12.
>
> Use %x for commands that parse hex (avb init) and %d for commands that
> parse decimal (mmc dev) to format device numbers correctly regardless
> of their value.
>
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
> ---
>  test/py/tests/test_android/test_avb.py | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)
>
> diff --git a/test/py/tests/test_android/test_avb.py b/test/py/tests/test_=
android/test_avb.py
> index 137d83e1deab..c66ef0cc52d5 100644
> --- a/test/py/tests/test_android/test_avb.py
> +++ b/test/py/tests/test_android/test_avb.py
> @@ -29,7 +29,7 @@ def test_avb_verify(ubman):
>
>      success_str =3D "Verification passed successfully"
>
> -    response =3D ubman.run_command('avb init %s' %str(mmc_dev))
> +    response =3D ubman.run_command('avb init %x' % mmc_dev)
>      assert response =3D=3D ''
>      response =3D ubman.run_command('avb verify')
>      assert response.find(success_str)
> @@ -43,11 +43,10 @@ def test_avb_mmc_uuid(ubman):
>      'part list mmc 1' output
>      """
>
> -    response =3D ubman.run_command('avb init %s' % str(mmc_dev))
> +    response =3D ubman.run_command('avb init %x' % mmc_dev)
>      assert response =3D=3D ''
>
> -    response =3D ubman.run_command('mmc rescan; mmc dev %s' %
> -                                          str(mmc_dev))
> +    response =3D ubman.run_command('mmc rescan; mmc dev %d' % mmc_dev)
>      assert response.find('is current device')
>
>      part_lines =3D ubman.run_command('mmc part').splitlines()
> @@ -75,7 +74,7 @@ def test_avb_read_rb(ubman):
>      """Test reading rollback indexes
>      """
>
> -    response =3D ubman.run_command('avb init %s' % str(mmc_dev))
> +    response =3D ubman.run_command('avb init %x' % mmc_dev)
>      assert response =3D=3D ''
>
>      response =3D ubman.run_command('avb read_rb 1')
> @@ -87,7 +86,7 @@ def test_avb_is_unlocked(ubman):
>      """Test if device is in the unlocked state
>      """
>
> -    response =3D ubman.run_command('avb init %s' % str(mmc_dev))
> +    response =3D ubman.run_command('avb init %x' % mmc_dev)
>      assert response =3D=3D ''
>
>      response =3D ubman.run_command('avb is_unlocked')
> @@ -101,14 +100,13 @@ def test_avb_mmc_read(ubman):
>      """Test mmc read operation
>      """
>
> -    response =3D ubman.run_command('mmc rescan; mmc dev %s 0' %
> -                                          str(mmc_dev))
> +    response =3D ubman.run_command('mmc rescan; mmc dev %d 0' % mmc_dev)
>      assert response.find('is current device')
>
>      response =3D ubman.run_command('mmc read 0x%x 0x100 0x1' % temp_addr=
)
>      assert response.find('read: OK')
>
> -    response =3D ubman.run_command('avb init %s' % str(mmc_dev))
> +    response =3D ubman.run_command('avb init %x' % mmc_dev)
>      assert response =3D=3D ''
>
>      response =3D ubman.run_command('avb read_part xloader 0 100 0x%x' %
> @@ -127,7 +125,7 @@ def test_avb_persistent_values(ubman):
>      """Test reading/writing persistent storage to avb
>      """
>
> -    response =3D ubman.run_command('avb init %s' % str(mmc_dev))
> +    response =3D ubman.run_command('avb init %x' % mmc_dev)
>      assert response =3D=3D ''
>
>      response =3D ubman.run_command('avb write_pvalue test value_value')
>
> --
> 2.56.0
>

Reviewed-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
