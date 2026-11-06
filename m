Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F64606D81D
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 09:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=owZWrjyk;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WAbUUjcA;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=R8tF0xJu
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 26384409AD;
	Fri,  6 Nov 2026 09:43:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id y9qtd3VQQc2w; Fri,  6 Nov 2026 09:43:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 33E76409C6
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793958213;
	b=CljyfUoX/LlZbNJAROntJsvQsvJn+43MIOaIfthUneYDTrb5oyIVwV918IQl69B5VYvS
	 cFsIehmo22hewycRXCANZeVaHkfqrvlFl93ZmooHcPCT/D1iqeoOsfIRrWRS6aWnvozrq
	 RVahgBEmRjl9edM5UiGxmV71fI7QASFJWVHug0IFw0oUOSGRxPGEbDWy+77uK3L2zzAaD
	 X7wA/DX2ZWArUXXWZBNi3x1gn/8qO2KgS4DfRKHgCf4nCbEuXny14SiiCPmDRrXOfJoOR
	 7lM2jlgrGpYiHAMJ77Oby2YK/Y2bl1jFu8aI0beiS9+PgKc8H/qlqPC1JIaz/igdOQw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793958213;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=2OU5fFfmP5wKvevFXInYcHGlz5wU7NVaUUlsFwXqglo=;
	b=tVk8CQaKe1YG8yFD9z3v5xomv3C6Dy6ZAVbOCSZJvR5EyknF8aB3ADZHqP1fvPnSMkGU
	 w+2Te/AueQWjoIVnDkw1NS2GkvVa9xg86QF8m20b2ESXosFP8IS6r8TJqaL9dkVHhyu9T
	 ERL9C+TwhIa2aDhNqAplZhwODoMojKJJ4VwMS1NWNC0Wnr98nv4WHvYWKPxugqYWPsNu/
	 5i2qt3F52JfANDMxkgC8iDUT9H5mi54UEB0sO3aNur5EHyemu/4o3z+X7JDFwaZ4KahD5
	 emzkz0gW8314rjM3/6PERCiPN8T8lIiEYVykMmFqma+zTit/NXIRDl4yDYtSKN27kJQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WAbUUjcA;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=R8tF0xJu;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793958213;
	bh=2OU5fFfmP5wKvevFXInYcHGlz5wU7NVaUUlsFwXqglo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=owZWrjykxqZ8PWzFY83ENfwVHA2ngXCXHjHP+iCvgsYic6ToS4AMxfUC++x6pe+XJ
	 u2dZ5HK8LeoGKFAUEWwazODZ3Vkfl1ibYSfsQY8KSBS2cPq5e9MbsfOoANj8ccaZTp
	 Ii30phAGFcAQTQCT7xx1UtjTkbRHk9K9SRSkF/7evqnfj2MOtJotzbfe6tiU4SP01f
	 /gNiwtALuJwXk4SCblUK4jVBlR/hKZabPuvEsWhtFNK5ONT/eG/n5D1Ow3oeKjk+Yt
	 zLJQL8TQxYj+AZv957DQxC+0sPhSaJlS6EbQ3Lzwn3CGjX3UBaGfgjBrgNGgHFGJzu
	 EfIifAhKR0ePQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 33E76409C6;
	Fri,  6 Nov 2026 09:43:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 11CE81E3
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 09:43:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EAEBE409BF
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 09:43:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TvMNvYUp5SHY for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 09:43:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org EDB0B409B0
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=WAbUUjcA; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=R8tF0xJu
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EDB0B409B0
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 09:43:30 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A67RTVs2730723
 for <u-boot@lists.u-boot-project.org>; Fri, 6 Nov 2026 09:43:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 2OU5fFfmP5wKvevFXInYcHGlz5wU7NVaUUlsFwXqglo=; b=WAbUUjcA//0vKnQg
 +zR+uSogO1WfaTiu3JF+OyuQpt347MLwwIFDW5x7nMECo+puebOMrBCapR8tpFUo
 Rs/jFX/HfgVJqrZQJurIuWGb54HRheXjPMctOR83pAGuWLCECn+hdEhFvYwYTpiM
 gticFdwzG/oaa/748ctknKCg3Yk/xtEPL+ziqXhoT7qvOt8RdjW7kDWaTXT8QYJr
 wpe8EJtdv/pZia1FgpML5VPTiFPNJwZEZ5ByEy7UUS+eG6yxMpS1A8hxJh/uKUR+
 IIjmXOXmT9LrqPoiCE+QDDf6nuGNRUXlaciMZw/qRiG39qNEUq8CDWi/q8q+VAPf
 8VLfxQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hs3p9j51y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 09:43:29 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-91e7f61a26eso8562246d6.1
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 01:43:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793958209; x=1794563009;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2OU5fFfmP5wKvevFXInYcHGlz5wU7NVaUUlsFwXqglo=;
 b=R8tF0xJuKulwBT8sbhqcyTw5abCalaWiWxmPfjoH2gH5hQNX/DSHa4JHkBiygr0h9z
 BmsXDP8Ti7WgdY7CjrF3oUNbNPZ2aFWnAHKm1YHLnTysZkrfopi4WiWNh/sCBGUWmbAB
 3yn02JlumA2knz/oO4U+SnkevuqRGD5e5F2zVZXlBQfOQuv19ujnmc33kgE2iBwtCIDf
 1+9xhDLq0LlCiAdgOFCLyTfnr1jPyMdQTuL8PVYoQ9JOUdR54NwzFovzAfbJBGtIjTvy
 RPo9ycjbiVaZ+vXDWXDBES4qdFknxGjgB1hO8vvpBGxoqWASnUPCGfpleTl8F4DmtUd3
 nHqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793958209; x=1794563009;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2OU5fFfmP5wKvevFXInYcHGlz5wU7NVaUUlsFwXqglo=;
 b=ACFhdiex85WJ/Nqw1XG/aSNu7B5Eju2RWNVaQ34PLejOZYiOXTGSlrNb1lBLnMW7ZW
 +XDpy8WW9W1As7tEh9gTYOBjY2a2tQ433PpiFesENViq8xuZRiUUCOqVaa1W8tWBNhL3
 eE2SN+uiJoL7/fPdaz3kJS2eYitt1DGZ3q/Ycf77I//E3iy+USjFhhuKWtIkOpJkizKj
 K6hKiZ6EhyKkYew5NOu6S/h3zuxwep4gLsdnl5KEweUYUySnn6ZMW7KI2UsBGjvkEWs+
 QZS63X2Y1aq4I8+Y/AzA8pbopVDYW8kTaxVZBFLNgm4SRULNGKrbeNEg3Q9y4USRV782
 TZEQ==
X-Gm-Message-State: APuU4Z/DXsCrSrsFEQWIEU7xoknotdzYkgij5lgFvuMKC6GNSu+Q5+F8
 gYkoTJavWQa5tp1UUfutp+YbK6nZayhxblM4pWZWyCwSnX/bxBl6XtuL8U7dtrf8ydnjAgf+3ey
 tztDkd7b1IjUxmjBHYxb5KErKnMSDvsufpXCzD4MtInk2MDjhuLbZHmGIM9wkw7pTe5/IA0Q=
X-Gm-Gg: AYBFou3K/CJJl4aybFkC87tGVNTgwrp52PM7ETUyrvLhtpDmBwesCVGpzbRCm3koiq/
 gFJZFrcMaOIn2IZ7CuBcMaxrJLju7NSZOP4GU+gcSV8qi7d0+vK148JZTbicbKFl7HOCeRsbyMC
 zPTXmeuw/C3egeDnCiCxaWKbnbhQOLlyVKnfFkaW/+wG7zdjmZFmemv6PYNHVngFrcoMOW5YVCQ
 oy15SNbQOkGH2ghhxS3qen8KeEaE1mGJSNrc1rxL3uWwc8Sd4KwBhVK2aL+H523CFx4q8VtLsOu
 CVqcGZpH0JwTiHAKQz4Pc5FZ/1qI6yBu/Uq3PJoTenvcSVxNdJZJPxWF7sG8YCsSRF2ZiOegHWW
 J8MALM/4ALLB9bGN9wBf3aJP47fKJU1ZQXs1ZG+p7AMy4qvLy+shvTqJnHZhjI5K/l0BpHwwyeJ
 1wIl4g3I6hx5ma
X-Received: by 2002:a05:620a:800a:b0:93e:e2a4:b0fe with SMTP id
 af79cd13be357-945f3537d9fmr261380185a.66.1793958208825; 
 Fri, 06 Nov 2026 01:43:28 -0800 (PST)
X-Received: by 2002:a05:620a:800a:b0:93e:e2a4:b0fe with SMTP id
 af79cd13be357-945f3537d9fmr261377385a.66.1793958208365; 
 Fri, 06 Nov 2026 01:43:28 -0800 (PST)
Received: from [127.0.1.1] (93-159-22-70.cgnat.inetia.pl. [93.159.22.70])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4d3562ec2csm64822366b.14.2026.11.06.01.43.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 01:43:27 -0800 (PST)
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Fri, 06 Nov 2026 10:42:46 +0100
Subject: [PATCH 14/14] test: py: add firehose tests with qdl
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-firehose-v1-v1-14-e7591c12fc65@oss.qualcomm.com>
References: <20261106-firehose-v1-v1-0-e7591c12fc65@oss.qualcomm.com>
In-Reply-To: <20261106-firehose-v1-v1-0-e7591c12fc65@oss.qualcomm.com>
To: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@nabladev.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Marek Vasut <marek.vasut+usb@mailbox.org>,
 Johan Jonker <jbx6244@gmail.com>,
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>,
 Vitor Sato Eschholz <vsatoes@baylibre.com>,
 Carlo Caione <ccaione@baylibre.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Simon Glass <sjg@chromium.org>,
 Mehmet Fide <mehmet.fide@screeningeagle.com>,
 Vincent Jardin <vjardin@free.fr>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Michael Srba <Michael.Srba@seznam.cz>,
 Biswapriyo Nath <nathbappai@gmail.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Rasmus Villemoes <rv@rasmusvillemoes.dk>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: WqDbOpIZBMV3ZGAP458ylkyrC8j4wNWJ
X-Proofpoint-GUID: WqDbOpIZBMV3ZGAP458ylkyrC8j4wNWJ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDAzOCBTYWx0ZWRfX0Q2JO05GI9aW
 MKY2UybRzwDMwi7rSDRpNNm/smgGhudJonzznlGq4N3bW4u1F7SnpIH9kQRocRph1/ORSDRff6V
 5rLWvsrFms3mqtNxK8adPiVeTslwZSw=
X-Authority-Analysis: v=2.4 cv=XvNvqlF9 c=1 sm=1 tr=0 ts=6aeda141 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=ySe+0nHqNG5yihRO1pIWsw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=uy2gxMiAOOLwXdiPlisA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDAzOCBTYWx0ZWRfX+np9xd0ghY/K
 Z1N5rDLQA+v/0LWyPAMAN1ARmWxCRmAYyK6imslPptHg+t1ZI6Q9HKgqzVmj+aVJlJDJUk7mXnp
 7Ey9vYRFijWePQaFkvAdBPM8M8vqbOVp1qjmA5A6IlHeK7m15th5V0nkF5o0s12EeOs6YA/Dl0R
 N5XfxzcQzDZFlVkI5+dnA3Wa58n2wZH3XspCOIJVwOpNeWFx2nwvNG4bhM2xs2zNtJkdoSMFooI
 E9PiJDgD63R8bUTRqmC4FnQuS+X7a1ovDtOUQ7gRNuEBKUJhBB/AX1LgM1/cCfFcz5l8JEewlDK
 AAD4WC7zC9SXXD5fq/Re+EiEAd9oqQLHfe5xmVrQZec7k4flnrdYrbNQw70IOt8YsUCsUxYGfrG
 PL309SDqv/3wGzy8oAE7CV1l+c+Bp4zQw/l9ujCJWPiO7F0xQafYGAkDcyf1+XVIHwKdslRxcNI
 fSiQPVJ4Mr96xMr+kDA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_02,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 adultscore=0 malwarescore=0 impostorscore=0
 phishscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060038
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-23.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add firehosr tests using QDL flashing tool [1].
qdl is taken from PATH unless configured; the tests are skipped without it.

[1] https://github.com/linux-msm/qdl
Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
---
 test/py/tests/test_firehose.py | 99 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 99 insertions(+)

diff --git a/test/py/tests/test_firehose.py b/test/py/tests/test_firehose.py
new file mode 100644
index 00000000000..f458c6d83ad
--- /dev/null
+++ b/test/py/tests/test_firehose.py
@@ -0,0 +1,99 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+
+"""Test the "firehose" command with qdl on the host
+
+The test starts "firehose" in U-Boot, with the configured device and with
+the device picked by the host's MemoryName, writes a random file to a
+scratch sector range with qdl, reads it back and compares, then stops the
+command with Ctrl-C. A second test checks that a power reset from the host
+resets the board.
+
+The tests are skipped unless the boardenv defines env__firehose_config, e.g.:
+
+env__firehose_config = {
+    # Arguments of the firehose command; the first one, the USB controller,
+    # is also used alone to let the host's MemoryName pick the device
+    'cmd_params': '0 mmc 0',
+    # Optional: qdl binary (default: qdl from PATH) and storage type
+    'qdl': '/usr/local/bin/qdl',
+    'storage': 'emmc',
+    # Sectors of physical partition 0 the test may overwrite
+    'start_sector': 738584,
+    'num_sectors': 4096,
+    'sector_size': 512,
+}
+
+The host needs qdl (https://github.com/linux-msm/qdl), the tests are skipped
+without it, and the host user needs access to the USB device, 05c6:9008 on
+Qualcomm boards.
+"""
+
+import os
+import shutil
+import pytest
+import utils
+
+def get_config(ubman):
+    config = ubman.config.env.get('env__firehose_config')
+    if not config:
+        pytest.skip('env__firehose_config not defined')
+    if not shutil.which(config.get('qdl', 'qdl')):
+        pytest.skip('qdl not found on the host')
+    return config
+
+def qdl(ubman, config, prog, *args):
+    """Run qdl against the running firehose command
+
+    qdl needs a programmer image, but skips Sahara and does not send it when
+    a Firehose server is already running, so any file will do.
+    """
+    cmd = [config.get('qdl', 'qdl'), '--storage', config.get('storage', 'emmc'),
+           prog]
+    utils.run_and_log(ubman, cmd + list(args))
+
+def start_firehose(ubman, config, auto=False):
+    params = config['cmd_params']
+    if auto:
+        params = params.split()[0]
+    ubman.run_command('firehose ' + params, wait_for_prompt=False)
+
+@pytest.mark.buildconfigspec('cmd_firehose')
+@pytest.mark.parametrize('auto', [False, True], ids=['device', 'memoryname'])
+def test_firehose_write_read(ubman, auto):
+    """Write and read back a scratch range, then stop with Ctrl-C"""
+    config = get_config(ubman)
+    start = config['start_sector']
+    num = config['num_sectors']
+    size = num * config.get('sector_size', 512)
+
+    test_f = utils.PersistentRandomFile(ubman, 'firehose.bin', size)
+    read_fn = os.path.join(ubman.config.result_dir, 'firehose-read.bin')
+
+    start_firehose(ubman, config, auto)
+    try:
+        qdl(ubman, config, test_f.abs_fn, '-R', 'write', f'0/{start}',
+            test_f.abs_fn)
+        qdl(ubman, config, test_f.abs_fn, '-R', 'read', f'0/{start}+{num}',
+            read_fn)
+        assert utils.md5sum_file(read_fn) == test_f.content_hash
+    finally:
+        ubman.ctrlc()
+
+    output = ubman.run_command('echo ok')
+    assert output == 'ok'
+
+@pytest.mark.buildconfigspec('cmd_firehose')
+def test_firehose_reset(ubman):
+    """A power reset sent by the host resets the board"""
+    config = get_config(ubman)
+    prog = os.path.join(ubman.config.result_dir, 'firehose-prog.bin')
+    with open(prog, 'wb') as fh:
+        fh.write(b'\0')
+
+    start_firehose(ubman, config)
+    try:
+        qdl(ubman, config, prog, 'reset')
+        ubman.wait_for('resetting')
+    finally:
+        ubman.restart_uboot()

-- 
2.53.0

