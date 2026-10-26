Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36FF9606A31B
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 08:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=cHwPKgf0;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=foa5Njjc;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Szmdf2al
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C831180DA2;
	Mon, 26 Oct 2026 08:54:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2-PkZczJr3X8; Mon, 26 Oct 2026 08:54:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1965B80C8B
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793004863;
	b=S9BEF2Xsff3ydfJqNSgtaw8GeFH7Url5VJbXtPcz9q6T4nNJGHAUVijZsqC+kBMjlY13
	 jmOww2iNEMYPGr8SrcBrg9u9DWkgwRN7v1tPpaYur+cctpqlH3vFKe2puZZRNahgxhXNb
	 4AGIEn3dhYzJ5xIh78CJy6NFbI0QHlONuuSCbnrMmCoF+bZf0DVcpc+8T/jXM3aSW6lro
	 VNLgeA70YUPVT8D4+LBefqRoofj0OS7jriJNSfghRrAwGKQB4HUYT3chDc2HtvwOQrUwb
	 qcOb9Sg+Dq/kRIBGgzu4lSyIUqJipNqgeArICw/kRhhDJ4EJvjtUevIlPDU0xCA9U2g==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793004863;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=qAQ1oya+CzOVrR+3B4daeyjyjBUoE7S8W5b+qK2InaQ=;
	b=fnAZHYDmLD7TRtvF7UKIygZHtqYqaGnQ72S6s1uJz15YZvzSFFfCbtfXo4Kly+YCHofa
	 PpmFJAo3n0iikVyo/qoJ+PcBtGdJKNumD8KvqFjORpz0fVv69aYszi+sBp6spDQ3ZRvUH
	 ffVXF/4//jrsXHNzMTWlNJvZKKf6OCFIygqtaAVB7Slc9BPfXosqqLjNx0IA0hzBQi6BJ
	 N04BD/o1gY7/JVIqwJ6otohW7xe9M269ieKQuxO/kjEpx6gGBeWKnHp6G1Zgeu7mIsc+4
	 c6U1usNztJMCASD4nnWQ3hLSz7wd5hgLu9GV66SbYUeptNM1RYMEA18hgGLDEm8Cj2g==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793004863;
	bh=qAQ1oya+CzOVrR+3B4daeyjyjBUoE7S8W5b+qK2InaQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cHwPKgf0d3D+jyR264wc04BiNYTMf6lv16K06ec4LwvyKeYlIG/RsXjxgBGQPUhpP
	 5xCRJaR9CDebWbGOMk9IR3P3si3qMzWrpBUOvDMTCKmNJe9wYk9HEP3qzWASBTHwlu
	 jKo731w8tj4N9UhtNa3qI1bOn0hNXHkpimZCYmPvzIcsYc9E1TwZUabG7WzUmJAsuY
	 Ei6q+uC5kSXN63QCD8V88zuaDfAraOXePXOXrg/+eNs+1iXIZWfOfCpbofZ05gM/vM
	 o13FjYpJkXTPzpa4dk/SM3xTW6yOjNXACB0LZ+G2hF/7ay5wQPGjWV4S7acg20LP0O
	 cM2FK88k1w/Uw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1965B80C8B;
	Mon, 26 Oct 2026 08:54:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id DE8A82C7
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 07:16:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CFF976063A
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 07:16:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4wfTCfuKNSdy for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 07:16:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 88E5D60623
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792999007;
 b=bTZNxIP4Md7HYjMrhX3Ck3v80djyrnLSynVIO6dFvMX93bLgbwPSHqw2IXLQpFJmyR/n
 L8GWp7VXmK2I/auLJXnMuyzSubkLbvZy23VUP2mnKp1awqSp0f7woOFI1b6doXA9jq+XP
 NkaMkj6jkn7H61ZRD8XFzVRYVfYkNJdl/oqLyjFtcwblnofmF1bVt0+FHwVvNqEyEe50K
 JlcONhg44nS+fhqkxdDws8l91MyhvqGZ2o55E3CcBTIidmXKvFNVIPeLbW55PHDWOU/La
 unwd0fw+cqNrir5UwKrM0nxRkHtYog+v//JjS6tdlIGDnukNycf6JDPErMaDFANkQkw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792999007;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:MIME-Version:References:In-Reply-To:From:Date:
 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=qAQ1oya+CzOVrR+3B4daeyjyjBUoE7S8W5b+qK2InaQ=;
 b=YZAZ/z6TQJ/WPrRuOoQwg+CpTiHaBBnag/eOZMYuKGGb5LH3xshCzYUeieR6QwwQKNc8
 /38FsStrVG0saKiKqACKwVp2E0p0JyBcHp8dGLq7UQiUyaTv52SI+jsBpnb5te894yaFB
 7bvKszEptMoLCh8aEilLBu4geMiXdyV1Mv51bEpsnqQ7x+JjYEjm5Oh5o8uRl993w3gjI
 EhNCtSO8pFcML3/wsv1XBgHM4g6sfKxF54U5L/z0ynwB1uuO7mxnrZI+V0Kaz4Mbogvod
 FDwOYO57/uM1b4dudP5ZDXMUpHA1NEXbur7JMfC76HSL4FusNk9ThVFtuOS0DQIQ+xg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=foa5Njjc; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Szmdf2al; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=subrahmanya.lingappa@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=foa5Njjc; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Szmdf2al
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 88E5D60623
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 07:16:45 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69Q4b7Pd1907968
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 07:16:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 qAQ1oya+CzOVrR+3B4daeyjyjBUoE7S8W5b+qK2InaQ=; b=foa5NjjctCRwH2dS
 FPPwRiTuzCFzGNNnN1SSH6LUOwLY8uOVPla/EpQvmxpmLofIQKSzvU+D/Vsou9xY
 ZjTk57ThT7dMhhwvNjHAM5Dtu1doPNMgvFwrN370RQoGT0r6LlVl5NhSxQarq8pN
 VikXg6ebwE9FHmlTEsqq3l/QHUIbQR7h4h8ZZvkMom9Z30gcoXLXdCA01idrjqFE
 6IvE2ZbOPwXmVcAsmgw6HmF1mLgNypZEFUDNFe4dNAFddlzA4iM3M/mC/oZG1OzG
 jb8J85/NoMF3Mk8xYZmLD9zUXCZn17NLL769giR74+A+IkQO5x2mwxsrrBS2KMEy
 Wc2ZqQ==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgm0gnajb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 07:16:44 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-7cc2c798d76so49642137.0
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 00:16:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792999004; cv=none;
 d=google.com; s=arc-20260327;
 b=jYKu62ar/IGVa6IERDOwE+IW66j4VoU7Bs5YLxU/ESbzjGQ0RIUuotOJnNeKpxPc+D
 c9V/twy//oROQus/5Oqoh96WK4+eEUUGrgdWrOcZv/Mz85Ie04DS1HPLRKEs2vHoa7Wd
 DhL2yEodPwIvOfPVpTEf1yfPYRgJ7lnTjxvLmxTHRWP2My0S55ozaLQMyix0CoGR9kyi
 O+w4ikGCGPZan959IZYXW3P5j4SYXRpDphdb9R7UhXHsj4iOMAoGR+Ki8Grg4taBUgtR
 9Vk4FupIz2T1+fCSOzG20Ll8spgaDRHv2lSE90L7rvFUjiCa5oumVOq6QesgastsWxmh
 fB8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=qAQ1oya+CzOVrR+3B4daeyjyjBUoE7S8W5b+qK2InaQ=;
 fh=GKDlMD+5P3E+S7j9MXtKsi6vW3O73Ar5s2d+QJMDjMo=;
 b=TSdscndTEfTggj+So+f9SLbyuiOfe1Ew+3mxXg05iOka5f/0jzASb3VOcFrmKWbXKj
 v3Q43VEhvhON3kxV5GABZsx1MQsGvAirgzr4+AWX6EbzNqXA8z47Nxh+rbxsH1l/eReW
 SBUAC7zrA6YA30NhtOk6KrN4PFD5QPDAvVeTmcZT1vQAqC73Sg5QdoDFggvuRGbJyhlI
 jJrwwuugcQFoEB0++31b89K3rEeolNwVDjZVo4NkZnTUoPOz0jemmPxrhugpk3qyWyKu
 3B4d3EerswGtnjMtweo0RAqTATscWAxQj8cSBasfn02McinNecH6GytwdDsYg2yBOPMe
 me4A==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792999004; x=1793603804;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=qAQ1oya+CzOVrR+3B4daeyjyjBUoE7S8W5b+qK2InaQ=;
 b=Szmdf2alB9RAi1rGIM12kyonTxAFIABSjGs2gn4q5WoXpiw2K/ayslrtvegR8C3ZYG
 Zf1P+qRSN1kubN3w1DwQo9IOxqyMFfC+yVvIJL/SqQIJD8Fv/U4RhVNqpjmsB57Lfwsh
 vc1M8PrbOEIopqHRG7LSuO6C/zzWG0aNZnA7hscUW9QntIvRG5lO9DKhu+RuQfe3B2HK
 w0FoB/SBlAeVMW08EzJG96hmi7ptmI+cRkSsKUjuQeJfriPZLDkfGh6id6r9kPJ0w9aH
 Rv9hNQvB9+BufiDD50L+c1DWX1HJ46W44ajpaWvzRTYtuvO/0WEgBDR9isCttgKE/fYs
 M6oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792999004; x=1793603804;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qAQ1oya+CzOVrR+3B4daeyjyjBUoE7S8W5b+qK2InaQ=;
 b=Q+FKGXdz7FyTNO01vU0Pfhz+Q0X9RzTGKWIZ3t2uU8xZ7fU86sRN45ylDtESCbtM/y
 uM7Hucd1pRkI5KlWU+yJRQbrhSkm67jsrLl2kTh54h0wpsiXXYBJqJur2uo3hRf8GXcu
 TAtkKXEbRpZzsuOT/gl2q2Byeq6RG0h2fR1kUonQS8E9saJwoUc+ao2NnK4cXywugjBc
 zOlEv9Zqlf347hSx55qirIaBQYMdXvl6xDTUMpHisTet7X+1p3PX7tfRIx/T4bVJ4eZ6
 jvlCOij+2DC8MaRlDpdtZ4AiBO//AprVSsQmER2ueJkhSw41HA1AjDO7hA7zON5PM8tZ
 /eeA==
X-Gm-Message-State: AFq9FYJKGq7N3GeEmX75TSq3e0LGAiAc3MpbU6IQxOzjKo2nE4C9lAHO
 t5zb5NvMLgX26vFV4oCS4Ho8cB+4qIe3vjuoZkTw7TXiwHON/DJ4km55l800Pssy3jFlO52RO4r
 6HHO0OOydt+CoTpokpw/L16vSOIocuTm9mH/R/PiiqnQwZJCkbxm5dm0qxlbxtx2W8IhvgTauMu
 DOgIbW2nxuwoEgVOBZun4liMJc60+SALtswojrslYbnAiFGA==
X-Gm-Gg: AYBFou3XcWBNfObD+EWal0wfjANWWUN4no9a3Mk859tTWY08s/xyIYTCu3wD+vGaOb5
 A718g3B8YMDI/nRWuj1qycRBaWptCzGV5ByeaS99QKJ3eEpIpB0BPXuwdJ9XJ7tsADlby8G3qq7
 iGLSHL5LrBXajLxTctFmDeh6fJDCVAhcSZV9GPP4LTezHk+HEp765glzUFgsw=
X-Received: by 2002:a05:6102:a1d8:20b0:7cc:22a0:de89 with SMTP id
 ada2fe7eead31-7ce5ccbc119mr1157433137.3.1792999003732; 
 Mon, 26 Oct 2026 00:16:43 -0700 (PDT)
X-Received: by 2002:a05:6102:a1d8:20b0:7cc:22a0:de89 with SMTP id
 ada2fe7eead31-7ce5ccbc119mr1157416137.3.1792999003197; Mon, 26 Oct 2026
 00:16:43 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261014-rpmi_v4-v4-0-d53d34a49780@microchip.com>
 <20261014-rpmi_v4-v4-3-d53d34a49780@microchip.com>
In-Reply-To: <20261014-rpmi_v4-v4-3-d53d34a49780@microchip.com>
From: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 12:46:31 +0530
X-Gm-Features: AclHuK-rzrzZwxs57Yj3WnHn-8-7sOSs2CFDiPFSwm05YGPCBCwI_8F-zqURDoM
Message-ID: <CAPxK-6fPNdwf7ZKhB0JjDGb-mqpZDuey9j0+AA6jk=6+G2wCrw@mail.gmail.com>
Subject: Re: [PATCH v4 3/8] firmware: rpmi: add support for shared memory
 transport
To: Charles Perry <charles.perry@microchip.com>
Cc: u-boot@lists.u-boot-project.org, Yao Zi <me@ziyao.cc>,
 Rahul Pathak <rahul@summations.net>, Anup Patel <anup@brainfault.org>,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Romain Caritey <romain.caritey@microchip.com>,
 Mame Maria Mbaye <MameMaria.Mbaye@microchip.com>,
 Tom Rini <trini@konsulko.com>, Rick Chen <rick@andestech.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Michal Simek <michal.simek@amd.com>, Conor Dooley <conor@kernel.org>,
 Peng Fan <peng.fan@oss.nxp.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: -fiD9sW7OKC0tC1DBAa_BgrRIR3RI3VO
X-Authority-Analysis: v=2.4 cv=UfTE26SN c=1 sm=1 tr=0 ts=6adefe5c cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=NEAV23lmAAAA:8 a=XYAwZIGsAAAA:8
 a=0CjJnxMWMwjMeDG4vOEA:9 a=QEXdDO2ut3YA:10 a=gYDTvv6II1OnSo0itH1n:22
 a=E8ToXWR_bxluHZ7gmE-Z:22
X-Proofpoint-GUID: -fiD9sW7OKC0tC1DBAa_BgrRIR3RI3VO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDAyOCBTYWx0ZWRfX83pl84ynm21U
 YYJ4xDnDjBa6ibHSpNvVzxzUO38Q1y8Ne37XyaxLeB37rOUY/RAZ4ItsQKL4rqRlgmtfIT0se2x
 yvgbPyk18QJUNcWhNan/NR6Z7Br/bMG5O4xhmsoaaLj7OFMc0VM6wg56cDKATy1ray+yOW6aSlf
 ixK3uXv8M4+IMTlGog9h9BcjKlsLyXrd67pevQ0cUISDnjbOnZZHWXbF1S3okpgfUx3Go/i/Xon
 mMzUTEfhPOcawQIRHjbHpalY3EazxUBb02DJTvDoqAFSKEWM7ByWLhvXJJBJLa+NwxkojVkvsfN
 5zk7a0JWsLZ0dbZTZ2ykHN7AzbY2zHBdH5wSpj4F0W/7TLS3eL2Xr2BcoN2SZYh33E/L8ZS4Qp3
 u982+aTLW7lKiKuvS1tNAP1Xe1j7dmR0d5U+jM2L+WXVrJCJD0vMv6ebLtGeTupZB4jWpJMUhrR
 n4/QMSTRo0CZf6z1FUQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDAyOCBTYWx0ZWRfX6cTPNyIl7zlC
 1w9qm19TBDxCJUWw5ruU9JawvPRdxA4x3kR2RYWmZvVlhNF4ireusSk9LUG3hhA3j0+TsXvBoQ/
 73Gi4TGDgLEkdYgjekHq+N61/pM6u+4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 spamscore=0 bulkscore=0
 suspectscore=0 impostorscore=0 phishscore=0 adultscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260028
X-Mailman-Approved-At: Mon, 26 Oct 2026 08:54:19 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-20.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Charles,

On Wed, Oct 14, 2026 at 7:47=E2=80=AFPM Charles Perry
<charles.perry@microchip.com> wrote:
>
> Add support for transport of RPMI messages over shared memory as
> described in the RPMI spec [1]. This uses two or four ring buffers
> composed of a fixed number of "slots" to pass messages between the AP
> and the PuC. U-Boot is the Application processor (AP) and sends messages
> through the a2p-req queue and receives response though the p2a-ack
> queue. There is no support for platform microcontroller (PuC) initiated
> requests nor notifications.
>
> This transport can be used in M or S mode U-Boot, but in the S-mode
> case, one must make sure that the supervisor software isn't already
> using the AP side of the shared memory.
>
> [1]: https://github.com/riscv-non-isa/riscv-rpmi (chapter 2)
>
> Signed-off-by: Charles Perry <charles.perry@microchip.com>
> ---
> Changes in v4:
>  - Fix the default value of the doorbell from 0 to 1
>
> Changes in v3: None
>
> Changes in v2: (from Yao Zi review)
>  - Reorder headers
>  - Don't null check pointers before free()
> ---
>  drivers/firmware/rpmi/Kconfig      |   8 +
>  drivers/firmware/rpmi/Makefile     |   1 +
>  drivers/firmware/rpmi/rpmi-shmem.c | 473 +++++++++++++++++++++++++++++++=
++++++
>  include/rpmi_proto.h               |  23 ++
>  4 files changed, 505 insertions(+)
>
> diff --git a/drivers/firmware/rpmi/Kconfig b/drivers/firmware/rpmi/Kconfi=
g
> index 708d931263ff..421a1fa9deba 100644
> --- a/drivers/firmware/rpmi/Kconfig
> +++ b/drivers/firmware/rpmi/Kconfig
> @@ -16,3 +16,11 @@ config RPMI_SBI_MPXY
>           (MPXY) extension of the supervisor binary interface (SBI). The
>           specification for the MPXY extension is available at:
>           https://github.com/riscv-non-isa/riscv-sbi-doc (chapter 20)
> +
> +config RPMI_SHMEM
> +       bool "RPMI over shared memory transport"
> +       depends on RPMI_FIRMWARE
> +       help
> +         Enable support for transport of RPMI messages over shared memor=
y as
> +         described in chapter 2 of the RPMI specification, available at:
> +         https://github.com/riscv-non-isa/riscv-rpmi
> diff --git a/drivers/firmware/rpmi/Makefile b/drivers/firmware/rpmi/Makef=
ile
> index 71c4aeaed910..4f4bcb929db4 100644
> --- a/drivers/firmware/rpmi/Makefile
> +++ b/drivers/firmware/rpmi/Makefile
> @@ -1,2 +1,3 @@
>  obj-y  +=3D rpmi-uclass.o
>  obj-$(CONFIG_RPMI_SBI_MPXY) +=3D rpmi-sbi-mpxy.o
> +obj-$(CONFIG_RPMI_SHMEM) +=3D rpmi-shmem.o
> diff --git a/drivers/firmware/rpmi/rpmi-shmem.c b/drivers/firmware/rpmi/r=
pmi-shmem.c
> new file mode 100644
> index 000000000000..db9949e39c7e
> --- /dev/null
> +++ b/drivers/firmware/rpmi/rpmi-shmem.c
> @@ -0,0 +1,473 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2026 Microchip Technology Inc. All rights reserved.
> + */
> +
> +#define LOG_CATEGORY UCLASS_RPMI
> +
> +#include <asm/barrier.h>
> +#include <asm/io.h>
> +#include <asm/types.h>
> +#include <dm.h>
> +#include <dm/device_compat.h>
> +#include <linux/delay.h>
> +#include <log.h>
> +#include <malloc.h>
> +#include <rpmi-uclass.h>
> +
> +#define RPMI_SLOT_SIZE_MIN 64
> +
> +enum rpmi_queue_idx {
> +       RPMI_QUEUE_IDX_A2P_REQ =3D 0,
> +       RPMI_QUEUE_IDX_P2A_ACK =3D 1,
> +       RPMI_QUEUE_IDX_P2A_REQ =3D 2,
> +       RPMI_QUEUE_IDX_A2P_ACK =3D 3,
> +       RPMI_QUEUE_IDX_MAX_COUNT =3D 4,
> +       RPMI_A2P_DOORBELL =3D 5,
> +};
> +
> +struct shmem_queue {
> +       u32 num_slot;
> +       __le32 *headptr;
> +       __le32 *tailptr;
> +       void *buffer;
> +};
> +
> +struct rpmi_shmem {
> +       struct udevice *dev;
> +       struct shmem_queue a2p_req;
> +       struct shmem_queue p2a_ack;
> +       int slot_size;
> +       int rx_timeout_ms;
> +       u32 token;
> +       void *doorbell;
> +       u32 doorbell_value;
> +       u32 spec_version;
> +       u32 impl_version;
> +       u32 impl_id;
> +};
> +
> +struct rpmi_shmem_chan_priv {
> +       struct rpmi_shmem *priv;
> +       u32 servicegroup_id;
> +       u32 servicegroup_version;
> +};
> +
> +static int rpmi_shmem_queue_idx(const char *name)
> +{
> +       static const struct {
> +               int id;
> +               const char *name;
> +       } id_names[] =3D {
> +               { RPMI_QUEUE_IDX_A2P_REQ, "a2p-req" },
> +               { RPMI_QUEUE_IDX_P2A_ACK, "p2a-ack" },
> +               { RPMI_QUEUE_IDX_P2A_REQ, "p2a-req" },
> +               { RPMI_QUEUE_IDX_A2P_ACK, "a2p-ack" },
> +               { RPMI_A2P_DOORBELL, "a2p-doorbell" },
> +       };
> +
> +       for (int i =3D 0; i < ARRAY_SIZE(id_names); i++) {
> +               if (strcmp(name, id_names[i].name) =3D=3D 0)
> +                       return id_names[i].id;
> +       }
> +
> +       return -ENODEV;
> +}
> +
> +static bool rpmi_smq_queue_full(struct shmem_queue *qctx)
> +{
> +       return ((le32_to_cpu(*qctx->tailptr) + 1) % qctx->num_slot =3D=3D
> +               le32_to_cpu(*qctx->headptr));
> +}
> +
> +/* 31                                            0
> + * +---------------------+-----------------------+
> + * | FLAGS | SERVICE_ID  |   SERVICEGROUP_ID     |
> + * +---------------------+-----------------------+
> + * |        TOKEN        |     DATA LENGTH       |
> + * +---------------------+-----------------------+
> + * |                 DATA/PAYLOAD                |
> + * +---------------------------------------------+
> + */
> +struct rpmi_message_header {
> +       __le16 servicegroup_id;
> +       u8 service_id;
> +       u8 flags;
> +       __le16 datalen;
> +       __le16 token;
> +} __packed;
> +
> +static int rpmi_smq_rx(struct rpmi_shmem *priv, struct shmem_queue *qctx=
,
> +                      u32 service_group_id, u32 service_id, u16 token,
> +                      void *response, unsigned long max_response_len,
> +                      unsigned long *out_response_len)
> +{
> +       struct rpmi_message_header *msg;
> +       u32 dlen, headidx, tailidx;
> +       int rxretry =3D 0;
> +       void *src;
> +
> +       headidx =3D le32_to_cpu(*qctx->headptr);
> +
> +       /* Wait for the Rx message with matching token, discard any other
> +        * messages received in the mean time
> +        */
> +       while (true) {
> +               tailidx =3D le32_to_cpu(*qctx->tailptr);
> +
> +               if (headidx !=3D tailidx) {
> +                       msg =3D (void *)qctx->buffer +
> +                             (headidx * priv->slot_size);

 The transmit path uses `wmb()` before publishing the tail, but this receiv=
e
 path consumes the slot immediately after observing the tail. Please add th=
e
 platform-appropriate acquire/read barrier before reading `msg` and documen=
t
 the ordering requirement for this shared-memory mapping.

> +                       if (le16_to_cpu(msg->token) =3D=3D token)
> +                               break;

 The response is accepted using only the token. This function already recei=
ves
 `service_group_id` and `service_id`; please compare those fields with the
 response header as well. The token counter starts again for a new driver
 instance, while old replies can remain in the shared queue across a firmwa=
re
 transition. An old reply for a different service carrying the same token c=
ould
 otherwise satisfy this request.

> +
> +                       headidx =3D (headidx + 1) % qctx->num_slot;
> +               }
> +
> +               mdelay(1);
> +               rxretry +=3D 1;
> +               if (rxretry > priv->rx_timeout_ms)
> +                       return -ETIMEDOUT;
> +       }
> +
> +       /* Extract data from the message */
> +       if (response) {
> +               dlen =3D le16_to_cpu(msg->datalen);
> +               if (dlen > max_response_len)
> +                       dlen =3D max_response_len;
> +               if (out_response_len)
> +                       *out_response_len =3D dlen;
> +               src =3D (void *)msg + sizeof(struct rpmi_message_header);
> +               memcpy(response, src, dlen);
 `dlen` is bounded only by the caller's response buffer, not by the current
 shared-memory slot. The current clock callers use response buffers smaller
 than the slot payload, but this generic transport accepts arbitrary respon=
se
 sizes. Please reject a `dlen` greater than
 `slot_size - sizeof(struct rpmi_message_header)` before copying, so a malf=
ormed
 response or future caller cannot make the read cross the slot boundary.

> +       }
> +
> +       /* Update the head index */
> +       headidx =3D (headidx + 1) % qctx->num_slot;
> +       *qctx->headptr =3D cpu_to_le32(headidx);
> +
> +       return 0;
> +}
> +
> +static int rpmi_smq_tx(struct rpmi_shmem *priv, struct shmem_queue *qctx=
,
> +                      u32 service_group_id, u32 service_id,
> +                      enum rpmi_message_type type, u16 token,
> +                      const void *request, unsigned long request_len)
> +{
> +       struct rpmi_message_header header =3D { 0 };
> +       u32 tailidx;
> +       void *dst;
> +
> +       /* Tx sanity checks */
> +       if (request_len >
> +           (priv->slot_size - sizeof(struct rpmi_message_header)))
> +               return -EINVAL;
> +
> +       if (rpmi_smq_queue_full(qctx))
> +               return -ENOMEM;
> +
> +       tailidx =3D le32_to_cpu(*qctx->tailptr);
> +
> +       /* Prepare the header to be written into the slot */
> +       header.servicegroup_id =3D cpu_to_le16(service_group_id);
> +       header.service_id =3D service_id;
> +       header.flags =3D type;
> +       header.datalen =3D cpu_to_le16(request_len);
> +       header.token =3D cpu_to_le16(token);
> +
> +       /* Write header into the slot */
> +       dst =3D (char *)qctx->buffer + (tailidx * priv->slot_size);
> +       memcpy(dst, &header, sizeof(header));
> +       dst +=3D sizeof(header);
> +
> +       /* Write data into the slot */
> +       if (request)
> +               memcpy(dst, request, request_len);
> +
> +       /* Make sure queue chanages are visible to PuC before updating ta=
il */
> +       wmb();
> +
> +       /* Update the tail/write index */
> +       tailidx =3D (tailidx + 1) % qctx->num_slot;
> +       *qctx->tailptr =3D cpu_to_le32(tailidx);
> +
> +       /* Ring the RPMI doorbell if present */
> +       if (priv->doorbell)
> +               writel(priv->doorbell_value, priv->doorbell);
> +
> +       return 0;
> +}
> +
> +static int rpmi_shmem_request_priv(struct rpmi_shmem *priv, u32 serviceg=
roup_id,
> +                                  u32 service_id, const void *request,
> +                                  unsigned long request_len, void *respo=
nse,
> +                                  unsigned long max_response_len,
> +                                  unsigned long *out_response_len)
> +{
> +       enum rpmi_message_type type =3D response ? RPMI_MSG_NORMAL_REQUES=
T :
> +                                                RPMI_MSG_POSTED_REQUEST;
> +       int err;
> +
> +       if (!request && request_len)
> +               return -EINVAL;
> +
> +       err =3D rpmi_smq_tx(priv, &priv->a2p_req, servicegroup_id, servic=
e_id,
> +                         type, priv->token, request, request_len);
> +       if (err) {
> +               dev_err(priv->dev, "tx failed %i\n", err);
> +               goto out;
> +       }
> +
> +       if (response) {
> +               err =3D rpmi_smq_rx(priv, &priv->p2a_ack, servicegroup_id=
,
> +                                 service_id, priv->token, response,
> +                                 max_response_len, out_response_len);
> +               if (err) {
> +                       dev_err(priv->dev, "rx failed %i\n", err);
> +                       goto out;
> +               }
> +       }
> +
> +out:
> +       priv->token++;
> +       return err;
> +}
> +
> +static int rpmi_shmem_request(struct rpmi_chan *chan, u32 service_id,
> +                             const void *request, unsigned long request_=
len,
> +                             void *response, unsigned long max_response_=
len,
> +                             unsigned long *out_response_len)
> +{
> +       struct rpmi_shmem *priv =3D dev_get_priv(chan->dev);
> +       struct rpmi_shmem_chan_priv *chan_priv =3D chan->con_priv;
> +
> +       return rpmi_shmem_request_priv(priv, chan_priv->servicegroup_id,
> +                                      service_id, request, request_len,
> +                                      response, max_response_len,
> +                                      out_response_len);
> +}
> +
> +static int rpmi_shmem_get_attr(struct rpmi_chan *chan,
> +                              enum rpmi_attribute_id id, u32 *data)
> +{
> +       struct rpmi_shmem *priv =3D dev_get_priv(chan->dev);
> +       struct rpmi_shmem_chan_priv *chan_priv =3D chan->con_priv;
> +
> +       switch (id) {
> +       case RPMI_ATTR_SPEC_VERSION:
> +               *data =3D priv->spec_version;
> +               break;
> +       case RPMI_ATTR_MAX_MSG_DATA_SIZE:
> +               *data =3D priv->slot_size - sizeof(struct rpmi_message_he=
ader);
> +               break;
> +       case RPMI_ATTR_SERVICEGROUP_ID:
> +               *data =3D chan_priv->servicegroup_id;
> +               break;
> +       case RPMI_ATTR_SERVICEGROUP_VERSION:
> +               *data =3D chan_priv->servicegroup_version;
> +               break;
> +       case RPMI_ATTR_IMPL_ID:
> +               *data =3D priv->impl_id;
> +               break;
> +       case RPMI_ATTR_IMPL_VERSION:
> +               *data =3D priv->impl_version;
> +               break;
> +       default:
> +               return -EOPNOTSUPP;
> +       }
> +
> +       return 0;
> +}
> +
> +static int rpmi_shmem_base_service_req(struct rpmi_shmem *priv, u32 serv=
ice_id,
> +                                      const u32 *arg_in, u32 *arg_out)
> +{
> +       int len =3D 0;
> +       u32 rx[2];
> +       u32 tx[1];
> +       int ret;
> +
> +       if (arg_in) {
> +               tx[0] =3D cpu_to_le32(*arg_in);
> +               len =3D sizeof(*arg_in);
> +       }
> +
> +       ret =3D rpmi_shmem_request_priv(priv, RPMI_SRVGRP_BASE, service_i=
d, tx,
> +                                     len, rx, sizeof(rx), NULL);
> +       if (ret) {
> +               dev_err(priv->dev, "BASE service %i failed (%i)\n", servi=
ce_id,
> +                       ret);
> +               return ret;
> +       }
> +
> +       if (rx[0]) {
> +               ret =3D rpmi_to_linux_error(le32_to_cpu(rx[0]));
> +               dev_err(priv->dev, "BASE service %i returned code %i\n",
> +                       service_id, ret);
> +               return ret;
> +       }
> +
> +       if (arg_out)
> +               *arg_out =3D le32_to_cpu(rx[1]);
> +
> +       return 0;
> +}
> +
> +static int rpmi_shmem_of_xlate(struct rpmi_chan *chan,
> +                              struct ofnode_phandle_args *args)
> +{
> +       if (args->args_count !=3D 1)
> +               return -EINVAL;
> +
> +       // args[0] is the servicegroup id.
> +       chan->id =3D args->args[0];
> +
> +       return 0;
> +}
> +
> +static int rpmi_shmem_open(struct rpmi_chan *chan)
> +{
> +       struct rpmi_shmem *priv =3D dev_get_priv(chan->dev);
> +       u32 servicegroup_id, servicegroup_version;
> +       struct rpmi_shmem_chan_priv *chan_priv;
> +       int ret;
> +
> +       servicegroup_id =3D chan->id;
> +
> +       ret =3D rpmi_shmem_base_service_req(priv,
> +                                         RPMI_BASE_SRV_PROBE_SERVICE_GRO=
UP,
> +                                         &servicegroup_id,
> +                                         &servicegroup_version);
> +       if (ret)
> +               return ret;
> +
> +       chan_priv =3D malloc(sizeof(*chan_priv));
> +       if (!chan_priv)
> +               return -ENOMEM;
> +
> +       chan->con_priv =3D chan_priv;
> +
> +       chan_priv->priv =3D priv;
> +       chan_priv->servicegroup_id =3D servicegroup_id;
> +       chan_priv->servicegroup_version =3D servicegroup_version;
> +
> +       return 0;
> +}
> +
> +static void rpmi_shmem_close(struct rpmi_chan *chan)
> +{
> +       free(chan->con_priv);
> +}
> +
> +static int rpmi_shmem_probe(struct udevice *dev)
> +{
> +       struct rpmi_shmem *priv =3D dev_get_priv(dev);
> +       int i, ret, qidx, qcount, qslotcnt;
> +       struct shmem_queue *queue;
> +       u32 arg_in, arg_out;
> +       const char *qname;
> +       fdt_size_t qsize;
> +       void *start;
> +
> +       priv->dev =3D dev;
> +       priv->rx_timeout_ms =3D 20;
> +
> +       priv->slot_size =3D dev_read_u32_default(dev, "riscv,slot-size", =
0);
> +       if (priv->slot_size < RPMI_SLOT_SIZE_MIN)
> +               return -EINVAL;
 The probe enforces only the minimum slot size. RPMI also requires a power-=
of-
 two slot size; validate that property before deriving queue pointers and s=
lot
 counts.

regards,
Subrahmanya

> +
> +       priv->doorbell_value =3D
> +               dev_read_u32_default(dev, "riscv,a2p-doorbell-value", 1);
> +
> +       qcount =3D dev_read_string_count(dev, "reg-names");
> +       if (qcount < 0 || qcount > 5)
> +               return -EINVAL;
> +
> +       for (i =3D 0; i < qcount; i++) {
> +               ret =3D dev_read_string_index(dev, "reg-names", i, &qname=
);
> +               if (ret)
> +                       continue;
> +
> +               qidx =3D rpmi_shmem_queue_idx(qname);
> +               if (qidx < 0)
> +                       continue;
> +
> +               start =3D dev_read_addr_size_index_ptr(dev, i, &qsize);
> +               if (!start)
> +                       continue;
> +
> +               if (qidx =3D=3D RPMI_A2P_DOORBELL) {
> +                       priv->doorbell =3D start;
> +               } else {
> +                       qslotcnt =3D qsize / priv->slot_size;
> +                       if (qslotcnt < 4)
> +                               continue;
> +
> +                       if (qidx =3D=3D RPMI_QUEUE_IDX_A2P_REQ)
> +                               queue =3D &priv->a2p_req;
> +                       else if (qidx =3D=3D RPMI_QUEUE_IDX_P2A_ACK)
> +                               queue =3D &priv->p2a_ack;
> +                       else
> +                               continue;
> +
> +                       queue->headptr =3D start;
> +                       queue->tailptr =3D start + priv->slot_size;
> +                       queue->buffer =3D start + (2 * priv->slot_size);
> +                       queue->num_slot =3D qslotcnt - 2;
> +               }
> +       }
> +
> +       if (!priv->a2p_req.num_slot || !priv->p2a_ack.num_slot)
> +               return -EINVAL;
> +
> +       arg_in =3D RPMI_SRVGRP_BASE;
> +       ret =3D rpmi_shmem_base_service_req(
> +               priv, RPMI_BASE_SRV_PROBE_SERVICE_GROUP, &arg_in, &arg_ou=
t);
> +       if (ret)
> +               return ret;
> +
> +       if (arg_out < RPMI_MKVER(1, 0))
> +               return -EINVAL;
> +
> +       ret =3D rpmi_shmem_base_service_req(
> +               priv, RPMI_BASE_SRV_GET_IMPLEMENTATION_VERSION, NULL, &ar=
g_out);
> +       if (ret)
> +               return ret;
> +       priv->impl_version =3D arg_out;
> +
> +       ret =3D rpmi_shmem_base_service_req(
> +               priv, RPMI_BASE_SRV_GET_IMPLEMENTATION_IDN, NULL, &arg_ou=
t);
> +       if (ret)
> +               return ret;
> +       priv->impl_id =3D arg_out;
> +
> +       ret =3D rpmi_shmem_base_service_req(priv, RPMI_BASE_SRV_GET_SPEC_=
VERSION,
> +                                         NULL, &arg_out);
> +       if (ret)
> +               return ret;
> +       priv->spec_version =3D arg_out;
> +
> +       return 0;
> +}
> +
> +static const struct udevice_id rpmi_shmem_ids[] =3D {
> +       { .compatible =3D "riscv,rpmi-shmem-mbox" },
> +       {}
> +};
> +
> +static const struct rpmi_transport_ops rpmi_shmem_ops =3D {
> +       .of_xlate =3D rpmi_shmem_of_xlate,
> +       .get_attr =3D rpmi_shmem_get_attr,
> +       .request =3D rpmi_shmem_request,
> +       .open =3D rpmi_shmem_open,
> +       .close =3D rpmi_shmem_close,
> +};
> +
> +U_BOOT_DRIVER(rpmi_shmem) =3D {
> +       .name =3D "rpmi-shmem",
> +       .id =3D UCLASS_RPMI,
> +       .of_match =3D rpmi_shmem_ids,
> +       .probe =3D rpmi_shmem_probe,
> +       .priv_auto =3D sizeof(struct rpmi_shmem),
> +       .ops =3D &rpmi_shmem_ops,
> +       .flags =3D DM_FLAG_PRE_RELOC,
> +};
> diff --git a/include/rpmi_proto.h b/include/rpmi_proto.h
> index 012ae93d7317..4b557bfeedf5 100644
> --- a/include/rpmi_proto.h
> +++ b/include/rpmi_proto.h
> @@ -60,4 +60,27 @@ enum rpmi_servicegroup_id {
>         RPMI_SRVGRP_VENDOR_END          =3D 0xFFFF,
>  };
>
> +/** RPMI Base ServiceGroup Service IDs */
> +enum rpmi_base_service_id {
> +       RPMI_BASE_SRV_ENABLE_NOTIFICATION =3D 0x01,
> +       RPMI_BASE_SRV_GET_IMPLEMENTATION_VERSION =3D 0x02,
> +       RPMI_BASE_SRV_GET_IMPLEMENTATION_IDN =3D 0x03,
> +       RPMI_BASE_SRV_GET_SPEC_VERSION =3D 0x04,
> +       RPMI_BASE_SRV_GET_PLATFORM_INFO =3D 0x05,
> +       RPMI_BASE_SRV_PROBE_SERVICE_GROUP =3D 0x06,
> +       RPMI_BASE_SRV_GET_ATTRIBUTES =3D 0x07,
> +};
> +
> +/** RPMI Messages Types */
> +enum rpmi_message_type {
> +       /* Normal request backed with ack */
> +       RPMI_MSG_NORMAL_REQUEST =3D 0x0,
> +       /* Request without any ack */
> +       RPMI_MSG_POSTED_REQUEST =3D 0x1,
> +       /* Acknowledgment for normal request message */
> +       RPMI_MSG_ACKNOWLDGEMENT =3D 0x2,
> +       /* Notification message */
> +       RPMI_MSG_NOTIFICATION =3D 0x3,
> +};
> +
>  #endif
>
> --
> 2.53.0
>
