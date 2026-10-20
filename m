Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F65606A328
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 15:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=p/PYz1pF;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=n1Wi30vv;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UUqvmVLc
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 75EC381068;
	Tue, 20 Oct 2026 15:38:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EzrgSa387a_C; Tue, 20 Oct 2026 15:38:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org F298980E81
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792510712;
	b=eKVeRrjE0N9HFaeA1nIQbpdqZe912GuRlPKhkrRIIjn4bQAek4UxIt0CWsFUopCIkiiu
	 ee5giviM8t4QBuoR6mNy86FVCZ2FEYcuxaOXe3Ayudt0cvyJsthx62PsTKkqH412ygNvh
	 IzddWfY381kFMlpb0dqxJ5fRVRkaTGel0rMThDuxm7Z5LfVcEle7ZM1PZ5hBVvrzIwlZ8
	 Cy4S+cd+k9ptfoUxIkLl7ZyN7Q6Cx9tQUil2D8b0EZTh78BEULZNfeAYdkiILZxwgLARo
	 xdYOewQ4Xbw8h3Mrt1S/t4ow1WWC/yjeRWcAGW7Slng/NR5q3/ylBucgBo8fiCWGt6Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792510712;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=yxMhhGNAtiLDfydpGuAKIVRihygH1/V8M48zQKiofZE=;
	b=QVmxZYcSCn52ps2OxEotD5vRj6luVqZvkB7ADmIroc2c3hjWX7BUF8LK5Te91bv5PLct
	 5j18muUoyCWtutkp7081GjD7gaY3D06RFUG2KP50x+96Z5sx14O5c6UA3gxsxwhwvMQ8/
	 sonxHw3dqw7sPYr1wX5OeHbe3N5i9OLdZDQwng1j2BGOY6OSawyxpLLGc1I5Cl4lyZ78J
	 +IsL4OnALw1jaB03kFk+ISXH2bh4wBOCJN/gCeyZRFVQNPspV1CfeWStCJEq9N+VVhoz3
	 nAoGY1ZUELi9G2kjEPI86GV1EvZBNDAWr8SiqIJsCXVOW1hZf0NmrTGhSCfW1N+3fLw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792510712;
	bh=yxMhhGNAtiLDfydpGuAKIVRihygH1/V8M48zQKiofZE=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=p/PYz1pFwLVbN7Xv+ZOEwShx8O/rLLsHqHFjS3FSs8BmMtR3nRh6Z3NK2EeeNytUC
	 ecqnvLJiJT/GLO9rNOX9Nfp3wM/2sOm6PzeZSVM9kpjMYIrpzlX6ztWZPWhD6C+aMv
	 vF4Dt/9n0j69EZ7bndTTBraKQ7O+sS1fuaGOuf4PxAigeq3HUGJhL8vIzsVQoCoLli
	 A3Z00JPCr96/Zo8VeaINz6CQf5P8yRfHhb0JCFGsg/KnRXjCmoi/uKbIGluCfbkr6E
	 aasUnuZEMNRlL40YG6y3l7nAf74a2MUNNRJJfFgKkGNRvPPeq++F9eP4gu8Bivvfv3
	 JvD0A4mYukxFA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id F298980E81;
	Tue, 20 Oct 2026 15:38:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 12BF6930
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 15:38:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id ECB2B607C1
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 15:38:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4UOM7YFkXNvh for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 15:38:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A5E43607CF
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792510708;
 b=WlcgsJz24WgYq92xsTlzC57cw1capAH96lty5OjWguZG9vc4Q8tx4A5QjiQQ94Jc+edy
 aWV0Keqqgq685+yJQJlotlhE6B298w/NcPW3yUveZDpQudEuyCeqQ//Z0goq7iyICXO8J
 fyCeAdpYxBNHOqN/LmV9w/8yoodXQpOfYScxyv1MjmjKVdGMQGuQ9/L/gvRQrGdwMOJnK
 zlAxMWF59In5nhA+TaVdYu5/SDCNYzbyDOMa1Hbyl9NzgeXHy+m20gLGhScDJ5W67V3uu
 KrBfySQqx3lUn6+qInCbC1MLNKH/rFVDBV+fgFWGZerG+JvFXGkL3k69aP9Cqzc3zkQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792510708;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
 Subject:Date:Message-Id:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=yxMhhGNAtiLDfydpGuAKIVRihygH1/V8M48zQKiofZE=;
 b=Thf+0ZQX3ofRbsHQ6aT2kBhh7ITnccMbHY/qnVZW3eCYSTt2dilkyNdtspzcfF18pRRM
 QZjHS0le0qeb3fUwCp0TEZ8OU8vgjSoCKEjWunx6kRCFCdY3ZoWo4mmHFWs7jcdr0kz7x
 UQWy6MI0Yt7/dPb2+gW3aQUMubYFykTeMP97yAVJw9q0HwMECXPYr4/TC4a7u31Ep9hzM
 0cHwhh3PB4+BBHoTZVaaEyMv6L49Z4quPJ9XuwumYu7DN2Mn85epAmz8lelOERBrx7wKN
 HjqKQL5ePOl44yTu7jr3epPPOpUgkX87PycaM4uHKEsem2Kl5JHSHZLOsy8Z1uF3ZCA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=n1Wi30vv; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=UUqvmVLc; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=n1Wi30vv; 
 dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=UUqvmVLc
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A5E43607CF
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 15:38:27 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69KFG2JQ2009841
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 15:38:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=yxMhhGNAtiLDfydpGuAKIV
 RihygH1/V8M48zQKiofZE=; b=n1Wi30vvkTAU5uK7iLWpD1fVNh8bgbSy0KWQZP
 c6vOdgn2dVJVo3ljmv/lhBa7H4nKl0I7FR1a0n2pR7tpU8YPIxs5hI021eG3LCfd
 oUSiWD1ofNeLAWNu4UD4MuvSF0elLewiFLqiJWS5pc/VLBQE18SV09xnynhMVaI3
 Yes5ap+546tEn1O3gfmRFvtorbfB/qKuka9ZxnOaBtRDP/OW+2Puaf2OWwlAKkWM
 QSTwzPpiwzCO206mkZX1x7Z8w/ngg/Fjx36EGskXQEbIMjiVKr2fOcMRnJsxK9GJ
 bhuYhqwL7udsUTY5W9kKTeKjzyE2rAfbIu6VM0WlmGjlAbRw==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdw5n376w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 15:38:26 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-91b994cb09fso70387006d6.3
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 08:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792510706; x=1793115506;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=yxMhhGNAtiLDfydpGuAKIVRihygH1/V8M48zQKiofZE=;
 b=UUqvmVLcpjt++pm7OUCq7tsyp3o1zf3iXGdX5pK48iSIg97qUHfhIq8HSeQZR5i0CE
 hMKKqtfgZZ6DJ6u5Sg4KO46/96RfAbFV2OgYWMjMfnY2bsQB3YIdgTpDdvRUD1rJyeZJ
 87SoZ2cWfS4l4Kq539Xt8egYmlMiwDyswkma4RvjccbJ9qFjYLpwwwh9IxSy9eqOTF1d
 wAFPl4bf/5aOTT/h4XW9ume0wLCkjl0w3A7IY9g5shdTXlUP12f/qAYnWEAj1Lf9rt5R
 oTssr6ijCqrFmnm/hZ7vOI6VeWuXAxA1ZXGSwSd1SvScD76VSGvDjZB7HoR123KOLwNd
 NZhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792510706; x=1793115506;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=yxMhhGNAtiLDfydpGuAKIVRihygH1/V8M48zQKiofZE=;
 b=DNwPu7RyU90PefeFarKPCwBuCWJ+XVZDDH2n7KSE//fLj4L7iYqeTO8f1jD2CwdNGZ
 74gClrz5zabvSfECn+HligHyYWKaDUZTYOeSSjgrF0PuzGN28cr9v2I/vwha7t0Ceyfp
 qUyTFd9p+BfS0GSqJSGOLbLW1KiS3t9ZKJtk5xwMUgzdbHvMHBSzACdFISUbifvDeK3r
 7qOHCG8PDx/aiw9H3RjIMxgYZB6TsOu/Eljs6p1ourzg46okXex4eRg0f3KAZNvZJJZu
 ZafANsdeIIzYw0U58SukD8Fp76DBJjDnCHAQ8QK75qhHIIzzxd+RhSILzd85jrS9wFma
 Xl2g==
X-Forwarded-Encrypted: i=1;
 AKwUvBwmZn/M+gqdKw13FBeX7YJqLXQglyRBIEowh/GlCAA39/bjDCsUBaBwaRr8JoRrM+yv28+/1D4=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKpKlQO6iXJ5S2IoVPFmxj0NBxIuXUuz8AaxzUwy3w7CC9+VfgT
 dy8R6omy+C2LMWnA7iermKk9C7QMCSTr/9ERXkCsWw79l4XY+UwT9I+bPcnV6fk97ilM40t8tc+
 TQ2upo24e4oOd0Os7FS+26k9/L1gKYEZpUk63IpYFodit1N+UAyEBHbhC9rTDEjwEXnRs83s=
X-Gm-Gg: AYBFou1EERTFO9dGxUl5wgPs5vZ0PMn9Dmz2/PaO0iGoV0Lc+/QYsIgQeaGrGKLktMQ
 ntuBEFCkEpcLTRhFroBcv4kzafE8XUHfqektrbu7j2L3iqbuZRAJ6b9e9ECuvpKQhabWIYr5o93
 Io5mMXi92QI8oOWK5VRifXjKPdIU9tOMfneXRlX3cpbnX9VXjwMCmblfZHKmC5gdwjdSQXD+2tv
 TwxWZpCbmXjjrg7Nn2oZEpqz42i+s7mrF3u7Jq3hmTaxvsLiqRwkYXUmnSelq4uubNlxpAcZc2Z
 NUOqQ8sJ4NgKU3sKWy8DpoqRnBWgwW4SUKrkA9V2Bx1A9IoinUSwZsmaPq9+ydikgO5IwBFjWXM
 z05xGFHvf/M74Jo0qXoUxGdFc+RLEivoT/tXkRuylZuYJ
X-Received: by 2002:a05:620a:6410:b0:93f:24e6:4052 with SMTP id
 af79cd13be357-93f29b7604fmr1760896085a.10.1792510705665; 
 Tue, 20 Oct 2026 08:38:25 -0700 (PDT)
X-Received: by 2002:a05:620a:6410:b0:93f:24e6:4052 with SMTP id
 af79cd13be357-93f29b7604fmr1760890385a.10.1792510705075; 
 Tue, 20 Oct 2026 08:38:25 -0700 (PDT)
Received: from [127.0.1.1] (185-164-141-21.cgnat.inetia.pl. [185.164.141.21])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b38a1b140fsm5574963a12.9.2026.10.20.08.38.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 08:38:24 -0700 (PDT)
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Subject: [PATCH v3 0/5] avb: device lock state, root key provisioning and
 in-place verification
Date: Tue, 20 Oct 2026 17:38:07 +0200
Message-Id: <20261020-upstream-avb_lock_unlock_b4-v3-0-e280795a98cc@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6WRTW7DIBCFr2KxLhbGGP+sco+qisZ4WpPEOAGMW
 kW+e8GJqi7aKlJXaEbzvnnzuBKHVqMjXXYlFoN2ejaxKJ8yokYwb0j1EGvCGZcFKwq6nJ23CBO
 F0O9PszruF7M9vaBDCVxK1bB2ECQSzhZf9ftGf3651W7pD6h8QqaJHhzS3oJRY2odwNBQ0tS96
 y1elmjK3yC3eTVPk/ZdhkMj20aWqt6mJ3QONsNddrcrWc2lYHld81YKymlckB9xtGh2OPl4OuS
 R9pi6/Jda/KZOwYza+dl+bL8Qiu3ShwIPBWUURAWooBJx5252Lr8scEoZfeED/47kfyN5RDa1k
 Ay4wKpqf0Cu6/oJYQ4dFzkCAAA=
X-Change-ID: 20261011-upstream-avb_lock_unlock_b4-d3a266c809d4
To: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Shahriyar Jalayeri <shahriyar@byteray.co.uk>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Pengpeng Hou <pengpeng@iscas.ac.cn>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ahmad Fatoum <a.fatoum@pengutronix.de>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Jan Kehren <jan.kehren@emteria.com>,
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-GUID: rJCuqJzEsNjQIw88grrD9AEWBtPngZuu
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA2MiBTYWx0ZWRfX9co9IYqEvevY
 hSrHln+7n138MdnuNWrpstBdsg6HFcNAW03/B+MveDCobmFKzfpsSD6oBH6g0EeNA0JXzdYWSIj
 1askBNm3iNyU3kGlNE3cknQPkQiaVhA=
X-Proofpoint-ORIG-GUID: rJCuqJzEsNjQIw88grrD9AEWBtPngZuu
X-Authority-Analysis: v=2.4 cv=A5z5rKWG c=1 sm=1 tr=0 ts=6ad78af2 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=JsdSkJyxCPcZmfxNhm0PvA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=HAEnkh90AAAA:8 a=Y4ZAcZfw-zZUe6kDIGYA:9
 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22 a=FO4_E8m0qiDe52t0p3_H:22
 a=LzkeyO55kmtmzvcb4Ayl:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA2MiBTYWx0ZWRfXz+F1+3hSKEnJ
 2S1whSitBxysFSYivJVTNbIcNR59IW9xy4GpFL9Ao+hknZa0iF/7n1sWyb57+SO38wEll80qh0j
 3PID0HLdoR9XTDAaf0b4rdw1q75cv3dRF/dwzRP3kl1glXQVGSMzhat6YhKSRHcqdpSK68EaXQn
 htxDVj99QpZ1oz8gusOmVzl09VpeD/kGc9qyhELibRoc3hMsbkNZd10GZ+3QEqNwsLNdkPcClAP
 pu2me64Waq5ybaBjOuOXxIpMmmTDQAZwi/MZHxycEDqfJwBHUd26R9O/N4EjbYtGcI3pk9IEeVd
 3QNhxWZMyRKtcQv5X4Wrga4fU4o9/RyqEKhJbngbjByUJ9IKoRHUfa2jQQFdo2zmLtaMvoMqafY
 cXKKVwx6XpVfFpYUM36YXU8Stbcx26rTCVt6CkBSMNLk0K3oKt3c0PMVmgC3Y6rVKDIXtbHI2LO
 2AGK03L0TBkXbfKU5YQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_02,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 adultscore=0 priorityscore=1501 suspectscore=0
 phishscore=0 spamscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610200062
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

This series completes the device state handling of the AVB 2.0
implementation when the state is kept by the OP-TEE AVB TA, and fixes
the way the Android bootmeth hands the boot images to libavb.

Patches 1 and 2 add the shell side: "avb read_pvalue_hex" and
"avb write_pvalue_hex" provision binary persistent values such as the
SHA-256 digest of the vbmeta signing key that CONFIG_AVB_ROOT_KEY_TEE
consumes, and "avb lock"/"avb unlock" set the lock state through a new
avb_write_lock_state() helper. Until now U-Boot could only read the
lock state, so a device backed by the TA could never leave the unlocked
(orange) state.

Patch 3 makes bootmeth_android verify the boot images in the buffers it
boots them from, via AvbOps.get_preloaded_partition(), instead of
letting libavb read, hash and free its own copies and then reading the
partitions a second time for booting. This closes the TOCTOU window
reported on the list and halves the amount of data read from storage.

Patch 4 adds "fastboot flashing lock|unlock|get_unlock_ability" and the
"unlocked" variable, so the state can be changed with the Android
fastboot tool, and makes the state matter to fastboot: "flash" and
"erase" are refused while the device is locked, and unlocking follows
the "OEM unlocking" setting Android keeps in the frp partition. Both
transitions erase userdata and metadata before the state changes, as
AVB requires.

Patch 5 documents the root key sources, the provisioning of the TEE
digest and the lock state in doc/android/avb2.rst.

The series is based on Jan Kehren's "avb: Support verified boot from
non-mmc storage" v3 (avb_ops_alloc() takes the storage interface
there), as agreed in that thread.

Tested on QEMU virt with OP-TEE 4.11.0-rc1 and the Cuttlefish Android
17 images: the chain boots locked (green) to sys.boot_completed, a
modified kernel is refused, "fastboot flashing unlock/lock" over
"fastboot tcp" erase the partitions and flip the state reported by
"getvar unlocked" and "avb is_unlocked", flash/erase are refused while
locked, unlock is refused while the OEM unlocking byte in frp is clear,
and the sandbox AVB tests pass. Build-tested with sandbox (in tree,
per patch), sandbox64 (out of tree), khadas-vim3_android_ab, sei510 and
am57xx_evm.

The lock state is stored in RPMB by the TA; on boards where U-Boot
serves the RPMB requests of OP-TEE itself, the two fixes in "optee: two
RPMB fixes for RPMB requests served by U-Boot" are needed at run time.
There is no build dependency on them.

Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
---
Changes in v3:
- Rebased on Jan Kehren's "avb: Support verified boot from non-mmc
  storage" v3; the fastboot code calls the new two-argument
  avb_ops_alloc(UCLASS_MMC, dev).
- Patch 3 (Guillaume): drop the "if (priv->boot_addr)" check, boot is
  always loaded by then; register the vendor_boot buffer on the boot
  image header version instead of the recorded address, which was
  never initialised for header v2 images; allocate the bootmeth
  private data with calloc(). Add the Fixes: tag (Mattijs).
- Patch 4 (Mattijs): the "unlocked" getvar entry is now inside
  #if CONFIG_IS_ENABLED(FASTBOOT_CMD_FLASHING), like has-slot, instead
  of a NULL dispatch.
- Patch 4 (Guillaume): "flash" and "erase" are refused while the
  device is locked; the userdata/metadata wipe goes through the same
  back-end dispatch as "erase" instead of calling fastboot_mmc_erase()
  directly, so FASTBOOT_CMD_FLASHING now only depends on
  FASTBOOT_FLASH; "flashing unlock" honours get_unlock_ability, which
  reads Android's "OEM unlocking" flag from the last byte of the frp
  partition (always allowed without an frp partition). The flashing
  code has no mmc specifics left: the frp lookup and the AVB ops use
  the fastboot flash device of whichever block based back end is
  configured, and getvar "unlocked" goes through a small
  fastboot_flashing_is_unlocked() helper, so fb_getvar.c no longer
  includes avb_verify.h.
- Patch 5: document the lock enforcement and the OEM unlocking policy.
- Collected the Reviewed-by/Tested-by tags on patches 1, 2, 3 and 5.
  Patch 3 and the doc changed slightly after the review (see above),
  shout if you want the tags dropped.
- Link to v2: https://patch.msgid.link/20261012-upstream-avb_lock_unlock_b4-v2-0-87460a24e559@oss.qualcomm.com

Changes in v2:
- fastboot: guard the flashing_lock/unlock/get_unlock_ability prototypes
  with FASTBOOT_CMD_FLASHING. They were declared unconditionally while
  their definitions sit under that option, so every configuration with
  fastboot but without the flashing commands (sandbox, sei510, ...)
  failed with "declared 'static' but never defined" under -Werror. v1
  was only build-tested on configurations that enable the option; the
  sandbox CI jobs caught it. The series is now also build-tested with
  sandbox, sandbox64 (out of tree) and the arm64/arm32 boards that
  enable AVB or fastboot flashing, and the 107-column dispatch line is
  wrapped.
- Link to v1: https://patch.msgid.link/20261011-upstream-avb_lock_unlock_b4-v1-0-a45aeca54016@oss.qualcomm.com

---
Igor Opaniuk (5):
      cmd: avb: add read_pvalue_hex/write_pvalue_hex
      cmd: avb: add lock/unlock commands
      avb: verify the boot images in the buffers they are booted from
      fastboot: add flashing lock/unlock/get_unlock_ability
      doc: android/avb2: document the root key provisioning and lock state

 boot/bootmeth_android.c       |  73 +++++++++--
 cmd/avb.c                     | 141 ++++++++++++++++++++++
 common/avb_verify.c           | 102 ++++++++++++++++
 doc/android/avb2.rst          |  75 ++++++++++++
 drivers/fastboot/Kconfig      |  15 +++
 drivers/fastboot/fb_command.c | 275 +++++++++++++++++++++++++++++++++++++++++-
 drivers/fastboot/fb_getvar.c  |  22 ++++
 include/avb_verify.h          |  39 ++++++
 include/fastboot.h            |  14 +++
 9 files changed, 738 insertions(+), 18 deletions(-)
---
base-commit: ed869863c7e2aca50d57a05d843830dd843138c4
change-id: 20261011-upstream-avb_lock_unlock_b4-d3a266c809d4
prerequisite-message-id: 20261016072640.772964-2-jan.kehren@emteria.com
prerequisite-patch-id: d0ea5299485f2cfba253ac68ab2d228255604a35
prerequisite-patch-id: 16b2dfbd478a6707672b4e62902987126c96544b
prerequisite-patch-id: f4f311b25e3405dfa47a0f67bdbe43d718a183be
prerequisite-message-id: 20261016072640.772964-3-jan.kehren@emteria.com
prerequisite-patch-id: d0ea5299485f2cfba253ac68ab2d228255604a35
prerequisite-patch-id: 16b2dfbd478a6707672b4e62902987126c96544b
prerequisite-patch-id: f4f311b25e3405dfa47a0f67bdbe43d718a183be
prerequisite-message-id: 20261016072640.772964-4-jan.kehren@emteria.com
prerequisite-patch-id: d0ea5299485f2cfba253ac68ab2d228255604a35
prerequisite-patch-id: 16b2dfbd478a6707672b4e62902987126c96544b
prerequisite-patch-id: f4f311b25e3405dfa47a0f67bdbe43d718a183be

Best regards,
--  
Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>

