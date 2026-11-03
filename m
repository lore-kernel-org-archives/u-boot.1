Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D259A606D80A
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 13:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=cJtCd9wZ;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=OE2z7X1j;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QHJGR2Iv
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AB66A81167;
	Tue,  3 Nov 2026 13:44:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aoOgY-zYPaGz; Tue,  3 Nov 2026 13:44:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 635B081119
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793713498;
	b=Rl4zai3Bc+SZEfYeJalnwpoTKrMbQYgETi4C33Dn5zvGryBAw7TYlSoDsnVPbiQaGMkM
	 Oa6DgeD4Ec+Q/27enQ+lVdSM6Jr8gqu6GnkgkUy0K0sjROdYEj+J9WedkW1lPsHQLaN8Z
	 u8XA+6IfruWxzZuCXSR0Lr1nLVgbwrc8fQACw47VBrGclmW55+Y2C+A/bPop9KGKrBDgH
	 I3NWIk2gdY5UtZMn+uk4t93pO3kERvc0cGCFckiGqQNjr3heTTxVgBvUDPhD9vbY4ubc5
	 jm+WwkiHcN41ExQHOjv5/PXbmeFcZwtCigDWIzynj6e01NX5zpHYC2wcTdy5vI4lhTA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793713498;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ex2PONDwof3qrPNZ/Br0G9AxZV/Nwtd2xTtDVsz2mzs=;
	b=GY4N6fGp8/F4UTHqI3LmNKEMW9VG/KZdFrvFDdOfUgRs7JlrtAaPSLhx/oWVBRgH80yI
	 +oWsAL37WLKr6trQZQt06PGJWwXnB6M4Po8ZZY/KbrNtPKygb6NhmJLSmmEPsV6GXtdle
	 Nnt7Naz7o2oZRtuxI2obMXp/f7A9Z2YpqKyT9tAjVg2GUIVtQrZtmnCIR7xUZOX8BkJV2
	 T9y42MNYQ92fijUH3x2Lm+EEft6RPOV3OsPceTl5kveonGhOCzreoVnUNqrdy2G2qoXbk
	 HpocvTZGI5vI2rkjr+AyPt6Gh/Q9MHTz3x8zEz7pgk+1c1rcSg12L/j4EmP+ElX6JlQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793713498;
	bh=ex2PONDwof3qrPNZ/Br0G9AxZV/Nwtd2xTtDVsz2mzs=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cJtCd9wZIMhZwzt2dTQzoLlrCMoOYGfPXfwwJ+VuZKtdvTk/d16Ny7Hx9WMYDUogJ
	 7oiRaxblEKg0wMIlzmbqy/rCCOhwtsgIvvpreYTWemmNniV7vRaLBYoYz/surlrZEb
	 iTm5MdQfT2ZRTOyw4XHQJSFZuxERoRfp/UWBFCMhF2SmW6Jjpmecr4694rymkH+iIb
	 nRe66hlPQh2wPvbjyEXl0G3GACUtiuOttavaeSHLd0hp5CZDEgVO7yJBLXaIkko7gI
	 s/U5w9kBfWf1j0x+WfG9yjvU/Ld8tDMVteJaIN04uv9AA59mhlM4yFBH0vVvephNfk
	 w62lr+noAAjnA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 635B081119;
	Tue,  3 Nov 2026 13:44:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 85FFAA15
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 13:44:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7232C4054F
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 13:44:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gibAIzbhCbNa for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 13:44:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 91B9240564
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793713495;
 b=nu+sdkYKbzUpgwv2sL3P3yn2kZu/oSTgTkZ/11raHht3H3NHfonZpMQVE1r8cFrsXjGg
 Rtq61wiS8Ii6YxrvwI3dcg4ob8lm0tYwGAeLfkjS/m1pibmBntq7C9ab90AcqI0WdjV+O
 FZYbI7GIRwtgcb9Rx53iFPhxO0vhnyg6oiuzLQLakJ4vxcg8s4uOVaubht8dpTKPdDH1Q
 uKq2hEqlo7t1qW8L49RFEHVMl4ocrRRqQlHV6nJDvWVBqUQE0oo4HKS7XkSDp93lIvLJf
 UVhB8PFDvJ1RvnEQ+r+10THs2IdSw00xD32M5AaPnUEGX9bHIPON+5dYTkh4kvqxbYg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793713495;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=ex2PONDwof3qrPNZ/Br0G9AxZV/Nwtd2xTtDVsz2mzs=;
 b=T1OVUnnRp5Azg7CZ041YtNVZymo0QEiD9uR0LvqYOenLbIAjrnmPvFUYDqTcOQJJhvn1
 AIT81QMXvVenhwBCBXR3/47jv+4UP5W8F8t7u3uVjU3P7+anWlKA1jz1pbrWvxCKz9M51
 PE+tbO2os2VU9VnV3F9TjNqHDphTpz6QExCWjkN+M7u/OOFMB4JfgS6QjdK5nmbYYIrdM
 eousXM26YbGbOuGqWZVy6nsCh668AHhjLlqlQdV0jepMi+8SzMgp2In4MLCPoD2EsKyXB
 2manqUchV/HOc5dgFYktcBXwO/d8s10IJAr7Vqy+sRyGSDFoFGJW/B9l6LjPVl0bXGQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=OE2z7X1j; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=QHJGR2Iv; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=OE2z7X1j; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=QHJGR2Iv
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 91B9240564
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 13:44:55 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A3DZ6N32449480
 for <u-boot@lists.u-boot-project.org>; Tue, 3 Nov 2026 13:44:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=ex2PONDwof3
 qrPNZ/Br0G9AxZV/Nwtd2xTtDVsz2mzs=; b=OE2z7X1joSFu1O1q5PVa69MmY+z
 e5qq7HSInEn64WiAiYuKqXwFSLzy7P0b3JHwuJkDlvjb7j/mhUK/0d/AF7j/Jv/y
 YHRXxAa6k/IMuFA5f/SS4cCNlBoaro52t/6RsLzqCc7le+EoRuwVqWhS3wc7bAyu
 pc6PYNRwXalAp02h5QT5vwnaQ1QNUrxyEtH1z7ym59XK9AicBHgXUDdFi4F19rIc
 viNSdWKHO606rtPqQW//Nt12qdLiZmW5re3ROHZUTjnnaN6dpBizZNdkSIlJRNuF
 pgpsHR1V1qVY3vIaG/RskkGQ+L63tAQSLSSmhOvSwj5BElWvlIvfRbXxNdw==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hq7yct8g1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 13:44:54 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-16bc6f3fdb1so4019317c88.0
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 05:44:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793713494; x=1794318294;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ex2PONDwof3qrPNZ/Br0G9AxZV/Nwtd2xTtDVsz2mzs=;
 b=QHJGR2IvJKajrA5sVP815w9Hn00bYvSp8fFHhhC2qeMqixveOhsjps4wA7bbMb2EL+
 D/5cw7P4SA8EiAgskl3Y99dA67Fpb2fJ0TERwA3pQnrjOpV/Jcz/VnlKJmK6+Aa4pypU
 9V8vtqoE7juWm3Lm0/1CaQeRQfdZKnop6zp8GUGm/86LpDyuABf5dJz3jkj2pV4uQ9dN
 ebCwu13FOpDUEJxjgnB0/l0L8U71FxyzRQTzr+fFVq1DiRcEw0/lS8WaUiW0fteOcicM
 v0ZKZqLoTc0C80PJZ1dY4TGF+L+JbIOeC9MhBnogtL8ij2fpxX4LJtTVhO3q4UFIeP31
 uT4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793713494; x=1794318294;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ex2PONDwof3qrPNZ/Br0G9AxZV/Nwtd2xTtDVsz2mzs=;
 b=rpQTZhZw10dl2IXyP7F1+96d/tjsMZlRbz/8LNM6DV8kLYq+92HVaHdSvHT1WTx90r
 oc/WoaWyfWZbj9tQVenBYmPAaF9EdM0uRCgSlP1JA8Af7A/DiySNXHoc6FTRtYqIcEDj
 0FSobRx+7RSEfKCFPu9qPQlChB5P7umiZextwnTYNY3CibvU3bx1Mma5fu1R/GrIowms
 P4l/+H1VS68PyqG0UOAffmha+wWpuCbAptS86STAPJ5fh2JuVlVPo20SH74yR5DD1R7A
 ghBy1OGlcMCm5Y58H0nO284kaxl1ZeOAHwK/yC4MJDuf6TO7zgQQj7WaJmM2lAyZd/Po
 8UhA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwbclWcwKgi073TXUJaQjlZ4VYwdazcMNDTw3jvUJ8E0D5OJHbkh4RHIEoz0hc1+VCJvzC3Yo8=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/Xs5IUKoj45iE+B/G1k7vna3ftt88xCR5rGzt227FI8i7R7RGn
 Asa1fSViSUrW00Ie1iNCVCgY8+eOpd5vQqZw95+0UysG3byGmOtVC60/QTkemwutWJu/v+zCwxC
 wix17pllNtMqPgdKeZq7Yls5795ghGCkC9JWPv7gTitmZPmQz19xxLrGWVEmVxg5nEMsm9/Q=
X-Gm-Gg: AYBFou3F7A/iDPWe3jh/3TRVIg4ZRW9jzuQ3rvG3140kDXPi9sLBMdI4u3huabSfzod
 mLixxgIhVLQtFZCyKaQzElmJ8bErmSVPwCGAi66oSZgM0nimF5ZRJ86RNLumovS5P0H7cfVirK1
 tC8lVqpZvT9PbXFgcGniJttOGQthDeq+c0V1EHwezv4iHHXkt6mdGeycHXKdsFDcLxcrI6qdf86
 qVCcXjRB3LcA7k3Q1H5+qG2NQCo62XcLGJT6DPw2bEvnnZncYfilwn/euPTnIbFw1zxI1pFJ7RJ
 lbYz33DJ80Z7O28IDaFTv3TIHkOj5rDs7+KFRwO9r1mFyMvzpI/GJcuUFFuwn7d0LTgdB/XOMt9
 8HCjKCbAUllsI+JWWEejrYqnlD3dLOrsuzNaGVwFPV5WmWjzhE0x8/URXAPb+CWVSRNe11ez6gG
 Av3GewlSU6pDEep1jHimM6L0iV5RY8ZHB8pDgKCv6rKpBxUPtR5uksEOjnWazEb+f7KRl5
X-Received: by 2002:a05:701b:2411:b0:1ac:75b9:f82c with SMTP id
 a92af1059eb24-1ac75b9f892mr16319404c88.34.1793713493926; 
 Tue, 03 Nov 2026 05:44:53 -0800 (PST)
X-Received: by 2002:a05:701b:2411:b0:1ac:75b9:f82c with SMTP id
 a92af1059eb24-1ac75b9f892mr16319365c88.34.1793713493300; 
 Tue, 03 Nov 2026 05:44:53 -0800 (PST)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b23f20d36csm7511194c88.11.2026.11.03.05.44.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 05:44:52 -0800 (PST)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com,
 aswin.murugan@oss.qualcomm.com, lukma@nabladev.com,
 marek.vasut+usb@mailbox.org, balaji.selvanathan@oss.qualcomm.com,
 Michael.Srba@seznam.cz, william.bright@imd-tec.com,
 nikroks@mainlining.org, anshuld@ti.com, jbx6244@gmail.com,
 dlechner@baylibre.com, nathbappai@gmail.com, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v5 9/9] configs: add shikra defconfig,
 MAINTAINERS and doc for IQS board
Date: Tue,  3 Nov 2026 19:13:51 +0530
Message-Id: <20261103134351.3532864-10-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261103134351.3532864-1-aswin.murugan@oss.qualcomm.com>
References: <20261103134351.3532864-1-aswin.murugan@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=V7foQuni c=1 sm=1 tr=0 ts=6ae9e556 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=KKAkSRfTAAAA:8 a=89TKq-WogshHRaIy_BAA:9 a=Fk4IpSoW4aLDllm1B1p-:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: ope16cXHIhk0dOq-U1u7am9piecSNBDp
X-Proofpoint-GUID: ope16cXHIhk0dOq-U1u7am9piecSNBDp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA1NCBTYWx0ZWRfXyLoZCfOtx5kZ
 LgeErct1NUd2Zj3CwkBB1ng5rWPcRATryt/c4W5dO4A139hAUsrefoytq4XwEM5RnhbFD8/H6vd
 obz5l/MWNzIdffXihRfgJUbIxRv7/hr/BdFO+TxI8jR8qKtpTs3QiaoAKKUNxqNVOGO39tHzrVx
 LmqfsflVl574qrsj7hpSAj8evLN9z69BmErUYoMAPaPb3PftKMQ4sb83zRu8dfT6JWcqoZhT5Oc
 5Kca29pN0dXHGsaCor7r02tr2Z1jexIi4IT0iMoavRSwZ+lP3CVkHoF2lT4zHZp2aI/iLD0OfSb
 RJdAYcykQVL9l5eiSj9x4a2jmyat/qAHOXErv1jQaxxw7ZcvehZKXmcvMGTfOTE1dr1nZuJW4W3
 atQccv8Y7jfhk68h+E64E4gT2PSZ2UyTvi6RGVCWONz1YEquITl3baRnubA/w4K1OWUyZRF2kNq
 xyZps17mb5HvBY1LgRw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA1NCBTYWx0ZWRfXylVrPpNiLYIX
 ofhNcSXZG8OFWWmoelmeWryoRbhcsWlDSs6/hedwnkJRR57IeaHPvR8n7JnLqlxHnl/Yg0W3+ej
 fkCTaOKL4LJ64Y7SFy5GYV8t0762HVU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_02,2026-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 clxscore=1015 bulkscore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030054
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Introduce a defconfig for Shikra IQS board, add the corresponding
MAINTAINERS entry, and document the board in dragonwing.rst, folded
into a single patch per review feedback.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 board/qualcomm/MAINTAINERS        |  5 +++++
 configs/qcom_shikra_iqs_defconfig | 31 +++++++++++++++++++++++++++++++
 doc/board/qualcomm/dragonwing.rst | 16 ++++++++++++----
 3 files changed, 48 insertions(+), 4 deletions(-)
 create mode 100644 configs/qcom_shikra_iqs_defconfig

diff --git a/board/qualcomm/MAINTAINERS b/board/qualcomm/MAINTAINERS
index 3767a2a7949..f8cd20ee60a 100644
--- a/board/qualcomm/MAINTAINERS
+++ b/board/qualcomm/MAINTAINERS
@@ -6,6 +6,11 @@ M:	Aswin Murugan <aswin.murugan@oss.qualcomm.com>
 S:	Maintained
 N:	qcs615
 
+QUALCOMM DRAGONWING SHIKRA
+M:	Aswin Murugan <aswin.murugan@oss.qualcomm.com>
+S:	Maintained
+N:	shikra
+
 # RB3 Gen 2 and similar boards
 QUALCOMM DRAGONWING QCS6490
 M:	Casey Connolly <casey.connolly@linaro.org>
diff --git a/configs/qcom_shikra_iqs_defconfig b/configs/qcom_shikra_iqs_defconfig
new file mode 100644
index 00000000000..3c917d5de42
--- /dev/null
+++ b/configs/qcom_shikra_iqs_defconfig
@@ -0,0 +1,31 @@
+# Configuration for building U-Boot in Shikra IQS EVK
+
+#include "qcom_defconfig"
+
+# Otherwise buildman thinks this isn't an ARM platform
+CONFIG_ARM=y
+
+CONFIG_DEFAULT_DEVICE_TREE="qcom/shikra-iqs-evk"
+
+# Address where U-Boot will be loaded on this board
+CONFIG_TEXT_BASE=0x9f400000
+CONFIG_QCOM_GENERATE_MBN=y
+
+CONFIG_FASTBOOT_BUF_ADDR=0xc5000000
+
+# Shikra has eMMC only, not UFS/SCSI - override qcom_defconfig settings
+CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME="mmc"
+CONFIG_FASTBOOT_FLASH_BLOCK_DEVICE_ID=0
+
+# CONFIG_SCSI is not set
+
+# Environment stored in eMMC logfs partition
+CONFIG_ENV_IS_IN_MMC=y
+CONFIG_ENV_MMC_USE_SW_PARTITION=y
+CONFIG_ENV_MMC_SW_PARTITION="logfs"
+CONFIG_ENV_OFFSET=0x0
+CONFIG_ENV_SIZE=0x4000
+
+CONFIG_TEE=y
+CONFIG_OPTEE=y
+CONFIG_OPTEE_LIB=y
diff --git a/doc/board/qualcomm/dragonwing.rst b/doc/board/qualcomm/dragonwing.rst
index 42828842da5..171600b8db9 100644
--- a/doc/board/qualcomm/dragonwing.rst
+++ b/doc/board/qualcomm/dragonwing.rst
@@ -6,12 +6,14 @@ Qualcomm DragonWing
 
 Qualcomm DragonWing boards are industrial-grade platforms targeting factory
 and edge applications. They span multiple product families, including
-IQ6, IQ8, IQ9, and Q8, which are based on Qualcomm QCS615, QCS8300 (Monaco),
-QCS9100, and QCS8550 series SoCs respectively
+IQ2, IQ6, IQ8, IQ9, and Q8, which are based on Qualcomm Shikra, QCS615,
+QCS8300 (Monaco), QCS9100, and QCS8550 series SoCs respectively
 
-More information can be found on the `Qualcomm's IQ6 product page`_,
-`Qualcomm's IQ8 product page`_, `Qualcomm's IQ9 product page`_ and `Qualcomm's Q8 product page`_.
+More information can be found on the `Qualcomm's IQ2 product page`_,
+`Qualcomm's IQ6 product page`_, `Qualcomm's IQ8 product page`_,
+`Qualcomm's IQ9 product page`_ and `Qualcomm's Q8 product page`_.
 
+.. _Qualcomm's IQ2 product page: https://www.qualcomm.com/internet-of-things/products/iq2-series/iq-2390
 .. _Qualcomm's IQ6 product page: https://docs.qualcomm.com/bundle/publicresource/87-83838-1_REV_A_Qualcomm_IQ6_Series_Product_Brief.pdf
 .. _Qualcomm's IQ8 product page: https://docs.qualcomm.com/bundle/publicresource/87-83839-1_REV_A_Qualcomm_IQ8_Series_Product_Brief________.pdf
 .. _Qualcomm's IQ9 product page: https://docs.qualcomm.com/bundle/publicresource/87-83840-1_REV_A_Qualcomm_IQ9_Series_Product_Brief.pdf
@@ -36,6 +38,12 @@ Configure the build for desired platform. This command creates the required
 configuration files in the .output directory. Following gives command for each
 platform (choose based on your platform):
 
+Generate the default configuration for the IQ-2 platform:
+
+.. code-block:: bash
+
+  $ make O=.output qcom_shikra_iqs_defconfig
+
 Generate the default configuration for the IQ-615 platform:
 
 .. code-block:: bash
-- 
2.34.1

