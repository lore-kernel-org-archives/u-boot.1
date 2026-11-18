Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60D0606A31C
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 04:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=tQg5JWAW;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GDMj4Nui;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=X+4/7INy
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 63AF06081A;
	Wed, 18 Nov 2026 04:04:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zoMnoBfl4Rgu; Wed, 18 Nov 2026 04:04:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 79AE160729
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794974673;
	b=hLglbVd6wPjGfl8/bq9tcCs6mNKh4YZYiU5gCBp1iaIZodlXGkks8BKqqe5i5IRWSic3
	 QpGVRWs2gyXQwbfJvPba2/5gSa6NJMnLbVlNPQrHmb9XLKhLEmpjUxpRlFC6/QFIfqP+l
	 1JTPAPMu1RGbauHMeNeSE+h+WfvDVKgB679x1wBLvGCA9w5OSDl6g2Ik9BGfmnm7zXwwa
	 uo1BXYQ7SrymwklTVta5YZrYAptxH0T3jHqwDRcExLQXt3P6rKjU225gjAsoahMrzXzJI
	 CgXIibmZT1GJ8o5tPIA0gXSP2KvJh3ixxznF35i+Mv6tpdupzD39ceg3wm6lWxofKKw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794974673;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Wn7tWBb/DLL1nLMYcqSq2Va/JVa26m8z2ZG9GAhWZEU=;
	b=afVocd3iWErGfXzESNj6TPGdBD1aQUa9D4/LhSoHc75poyfZZ0amAZuyWtwGbAJgPbrp
	 q9Y44JPoLRL9lJnkFW8+rIth/x2yLX1DQZQu8BDStmAUDOQO8TM73UZuUXM6Gd7E25tWr
	 3VPjH6PsGyZhrliNQv7xyd4BdaYtrpc2lk3I2aek8Hqvk2Xoj8FWrUpdiDs1kNrEmTaDd
	 8uR2eyBlWJPDU6sSH0jBJbw0WVwf6nFa1dwznMfdqH/vAp0UtfRHQsMcvW8vBKu9c/3G0
	 JhtJHkHEkjvA7Z0hyEb5QiVgs6mMtR0TdVRnkP3YjO8OrdlkYUUyDji09M+mWtQQUtQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794974673;
	bh=Wn7tWBb/DLL1nLMYcqSq2Va/JVa26m8z2ZG9GAhWZEU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tQg5JWAWVtkGOfMRi1JgXgw9wgqpszyD3+WAlb4G7WCrWC/Q+UG6XIHVyLhdCovsq
	 FoVfqNpGcS8J1S/Bf8xRA3JGbPt8KeHecYQXIs5yk5QPOwfyEKcDHHJL2pQ/t7JwSI
	 skj0LBET+akLxWNer9GnWJoJayC2i3cQs01yiv5rJYDIJaSIQsKvDNoBfvE1wBSt7/
	 0J6ku2t6jcO5FHlu5Utm8e1efdJRlVDvTUXpEMKu0C61cuKfEH+AddlhUBK+xLnrC6
	 OXyNYkwKn3pqNNfGDMt6pfmyzvBptC1uzY1fCbiPiLIentjz8D5iw8rFXN7UjERrB6
	 wgo2jnQBMZwdQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 79AE160729;
	Wed, 18 Nov 2026 04:04:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id BD74DA32
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 04:04:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AEEC240659
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 04:04:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mKTgvmXdNpGs for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 04:04:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5102C40638
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=GDMj4Nui; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=X+4/7INy
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5102C40638
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 04:04:29 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AI2UoT03371277
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 04:04:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Wn7tWBb/DLL1nLMYcqSq2Va/JVa26m8z2ZG9GAhWZEU=; b=GDMj4NuivfzxSHHa
 g512kTevdpc7mnCn0vZpYNllJkCXtjzNaEO7tsiSjXSFHemQLM5LaRuQxaRGILD4
 f8nfy/JqriUuDjCaddOoQJrazT4snPv5B6KtaFTd6Y8O122xhVaqq2X4Gq1iToQ1
 YPvADNGKaeCtBFNeNKrFjRgpfKL6t2os9x8rvEfaHZh/7i2SaSt85iIhn0OCz3Gs
 u0HsupBR4m//EX5VFJ0W0RFNBA9e/KJKODSAbMikc4qPFNLVeqp/5JZWRa29ipdT
 MaqsuTHPISZR5W8ApxibPmLhW3G2VsmODwlnZu+89wnu+XTqV09Jjy6hbAyoMXfy
 b8VOjg==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0yv8s38q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 04:04:29 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-1a71dd190b0so1546544c88.1
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 20:04:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794974668; x=1795579468;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Wn7tWBb/DLL1nLMYcqSq2Va/JVa26m8z2ZG9GAhWZEU=;
 b=X+4/7INyitcmCRImQzny3wu70LgYxVjxwVUaq8cEjA1qG0B7bQIo0sa0wQSOFQnLii
 zzeWeOqQ1zvm1JKXQyV5IvNgZXJZxdmzgrpn0J07/P6PU85tBdpQGSApuHKslj/xFQeH
 W9EcIFMwqSHcdAF4INZQhjRXtGsNLJoXQEU572oAfd+Yv3O0XywAXdrzc5oTjoHtYG9Q
 DxFu0NLeHWQKFbtF1/41wsc1gtPIsccYblRyDD10WRZCxA+TETcegwYBODpWwBHW3Cnd
 9KW157VVuzHFsOYyb59pfV4CiegSpLrpYbFNSCm4BqfaRwynlwsUyBQ6WZu7uDr9LhkV
 pZDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794974668; x=1795579468;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Wn7tWBb/DLL1nLMYcqSq2Va/JVa26m8z2ZG9GAhWZEU=;
 b=XkGlFFrA/23L60o3CpKtrFt+mNQJx8MArVP7MHoZwaohj6aTJJ0v6CBqFogHnKNtw5
 Dol03T/xJySvqkpatL03dAfaJxo/5UO9KigPeHP1iFRZRWmgxWBMTlt5Kh2qm8J+46Iz
 iYpI5aEa7aDwdyc8dnfIGZz5FM1SULwpDwfOTX2Rqp8rFUIAZ9qml49XYb+camWlyXuO
 OGACGa7Dfdzz02HIqKHJJGsfXHpE3U3oc5eYDZoGG5ZrC83M55klpd/Wz8Mvi53is9Fn
 JwsRHQ6Ddchvwi6Q453xavpqaO7q6aqjQHN7pKbRUPI3/3TfgV8a0HVV/WLV+vFYNHPo
 BGxw==
X-Gm-Message-State: APuU4Z+aWueFoofgMbOTUEIC0uWGl0nrewOVfUKsLUYzXW6RQeiGdTWc
 wxcSOmAvJ0MZZXwBdEo7CdCUK39z4mh0O2rVZjbq3czXGQ3wGyaUcq0zagGNL9n48gDp+oC19Yi
 oLvUquqI144/xfAe7gQopm9zRMmccdlL5fsjbHDu3WHquvAqpUWH+fi2b2tRKbMxpzQW9GHU=
X-Gm-Gg: AYBFou1zMcpikKYxQ8MVABt7Xi0aivcj/C24aWaFr8lK9Iffd5gpI38y1m3kULP3GQY
 QEHGT+JtmJRIXeFJ+kuXeXeBLSt4oPNA4fHrUHM/+SsQc4igU4SKyIc1f8RJTPXY0P6fgvJbMc+
 wc7F21X4meqsYN8SZIWZwretcm5Qfuc8o7v18X3ACteKV1yAbbmeofEfIQrQGvBhgGIeRvFmKZc
 wH9msj8bDnYcac96FGN5y8pZGilvlv7HcnDIdwLnVYM8VRGVGKrek/40Qn4zuHSoRhFZYPFKbFU
 1BIbBy26TvmGaKrX6EUIcZd3u7lDp3PCJgZnp9Fo0FX+cdOIWEqiwmjQODaBAz55djdvbf5yMjP
 sjYJnuBpyXIpcJ6qAd13F9a/VkRa8pdVNvJ1muDeIBHLLwO+C9fuBwkNkej8nL2ESVC2KiLpLHR
 0bWQjLffCzqls=
X-Received: by 2002:a05:7022:f516:b0:15a:9834:73f2 with SMTP id
 a92af1059eb24-1b543c3d8abmr1342985c88.38.1794974668201; 
 Tue, 17 Nov 2026 20:04:28 -0800 (PST)
X-Received: by 2002:a05:7022:f516:b0:15a:9834:73f2 with SMTP id
 a92af1059eb24-1b543c3d8abmr1342967c88.38.1794974667694; 
 Tue, 17 Nov 2026 20:04:27 -0800 (PST)
Received: from [10.152.203.87] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b5447c5b02sm2662674c88.6.2026.11.17.20.04.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Nov 2026 20:04:27 -0800 (PST)
Message-ID: <6d0f467d-ad4b-4cdf-a2b3-0ba14cee796d@oss.qualcomm.com>
Date: Wed, 18 Nov 2026 09:34:17 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/8] disk: Add partition lookup by type GUID
 functionality
To: Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Rasmus Villemoes <ravi@prevas.dk>, Javier Tia <floss@jetm.me>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, David Lechner <dlechner@baylibre.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Michael Walle <mwalle@kernel.org>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
References: <20260428-type-v4-0-b7051dc45a88@oss.qualcomm.com>
 <20260428-type-v4-1-b7051dc45a88@oss.qualcomm.com>
 <a5c42652-7346-4775-a13e-e9d74c393ee6@cherry.de>
 <20261116183151.GB554944@bill-the-cat>
 <483d923c-2675-4e61-a21f-af1e47951d54@cherry.de>
Content-Language: en-US
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <483d923c-2675-4e61-a21f-af1e47951d54@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Eu1HPicA c=1 sm=1 tr=0 ts=6afd23cd cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=cm27Pg_UAAAA:8 a=EUspDBNiAAAA:8 a=b6KBTLBP61O1TirLvpcA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-GUID: VoHMoJYkFKpNm6gHZ9CYWgV4huzfv2c2
X-Proofpoint-ORIG-GUID: VoHMoJYkFKpNm6gHZ9CYWgV4huzfv2c2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDAxNSBTYWx0ZWRfX6b5GYwaTHdAl
 lWP86T9GhNWhzZd3/8klgaT/PObynVBHfa94eTIO0kDK02kEajbuYbye08bkLY6ap3xVLWV7zkP
 REmZFq3yiJCfTMes7Z9rCak692tHvqCwLHiys5z0YFU+lagQ2v6QVCbGyiA+DdVzDP/2VKxKg9k
 +OG3jMy3aQnaH4AqaBQxfpAKQ87MJaKLCp4g0j25l7mQSyvkRZ++FLhYjtrdpzb6a1TB9ndmvlY
 YB8v7QMkOSUDjHZihexWLZIeT3DVmC4+s2Wb0cPomIUxLJsGvU+IO/k35rjsnwPstda2orT4m/t
 VBqBvsJwkoj+43sp45SM/DZM+A7/3vRGdE+su2keHLk3nqaSoMl7Z8cTOwFqggqJlBSncRNLXMz
 VoGUArM3exiMUlVDJ01CLmjWHNVy5asJAnVPoLUnSjaT87N/MY2kyPtHIublAx8Ug7bjxS+LUVD
 KnPBWtavrgW0177HPPQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDAxNSBTYWx0ZWRfX6iilJtKozvDQ
 +8Z5s61Pim8VBCvlrrZoNM85YUDAwncPCkMgK7yCHz68Zor8HO5NXfdKrCHu4nAI0J0ld5Yn+dJ
 MhhO3L/+FNZeaJq0kRllzAmFYH7ppvs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_01,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 spamscore=0 suspectscore=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611180015
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Tom, Quentin,


On 11/17/2026 12:34 AM, Quentin Schulz wrote:
> Hi Tom, Balaji,
>
> On 11/16/26 7:31 PM, Tom Rini wrote:
>> On Thu, May 07, 2026 at 03:42:14PM +0200, Quentin Schulz wrote:
>>> Hi Balaji,
>>>
>>> On 4/28/26 9:31 AM, Balaji Selvanathan wrote:
>>>> Introduce part_get_info_by_type_guid() function to enable partition
>>>> lookup using partition type GUID. This complements the existing UUID
>>>> lookup functionality and provides more flexible partition discovery
>>>> mechanisms.
>>>>
>>>> Reviewed-by: Simon Glass <sjg@chromium.org>
>>>> Signed-off-by: Balaji Selvanathan 
>>>> <balaji.selvanathan@oss.qualcomm.com>
>>>> ---
>>>> Changes in v4:
>>>> - No changes
>>>>
>>>> Changes in v3:
>>>> - Addressed minor corrections in part_get_info_by_type_guid function
>>>>
>>>> Changes in v2:
>>>> - No changes
>>>> ---
>>>> ---
>>>>    disk/part.c    | 37 +++++++++++++++++++++++++++++++++++++
>>>>    include/part.h | 21 +++++++++++++++++++++
>>>>    2 files changed, 58 insertions(+)
>>>>
>>>> diff --git a/disk/part.c b/disk/part.c
>>>> index 4923dc44593..4cb3204ac6e 100644
>>>> --- a/disk/part.c
>>>> +++ b/disk/part.c
>>>> @@ -731,6 +731,43 @@ int part_get_info_by_uuid(struct blk_desc 
>>>> *desc, const char *uuid,
>>>>        return -ENOENT;
>>>>    }
>>>> +int part_get_info_by_type_guid(struct blk_desc *desc, const char 
>>>> *type_guid,
>>>> +                   struct disk_partition *info)
>>>> +{
>>>> +    struct part_driver *part_drv;
>>>> +    int ret;
>>>> +    int i;
>>>> +
>>>> +    if (!CONFIG_IS_ENABLED(PARTITION_TYPE_GUID))
>>>
>>> We don't have an xPL symbols for PARTITION_TYPE_GUID so you need to use
>>> IS_ENABLED(CONFIG_...) here otherwise it won't work in xPL stages.
>>>
>>> Or you need to add an xPL symbol for that (see PARTITION_UUIDS and
>>> SPL_PARTITION_UUIDS).
>>
>> Jumping back here as I see in v5 it was switched to IS_ENABLED(...). I
>> believe the correct approach is CONFIG_IS_ENABLED(...) and introducing
>> if needed, or just waiting for the need otherwise, the xPL variant. This
>> is because I can see for size reasons xPL and full U-Boot not having the
>> same environment notion (perhaps NOWHERE being set) and so we instead
>> run in to the other type of compile problem here. Generally speaking
>> using CONFIG_IS_ENABLED(FOO) and later adding the xPL symbols, for 
>> shared code,
>> is better than IS_ENABLED(CONFIG_FOO) because we want/need that
>> flexibility (there are counter examples, but they are the exception, ie
>> we *must* be consistent from phase to phase or know what a previous
>> phase has done/next will do).
>>
>
> I keep getting confused by symbols that currently do not have an xPL 
> variant as to whether that's on purpose (it should apply to all 
> phases) or whether it should be gated by another (xPL) variant to 
> apply to specific phases.
>
> Here, the fact we only build disk/part.c in xPL if we have 
> CONFIG_$(PHASE)_PARTITIONS=y means I was wrong and we should indeed 
> use CONFIG_IS_ENABLED() as suggested by Tom. My apologies.

Noticed that SPL_PARTITION_TYPE_GUID already exists in disk/Kconfig; So 
will switch to CONFIG_IS_ENABLED(PARTITION_TYPE_GUID) in v6.

Thanks,

Balaji

>
> Cheers,
> Quentin
