Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF4B606A31C
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 13:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=y75BHYdW;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RuANGr96;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jTqw7TTm
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5DB8580F65;
	Mon, 16 Nov 2026 13:02:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EINpyK85cPEe; Mon, 16 Nov 2026 13:02:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 98D1880F24
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794834144;
	b=GgypZXJbIwNUvquKYX6OT5rA/TDmlS1gEkSGCyt/99EcuEygcECOGIcjc9a11g5bJGxF
	 lFUklVXiaU+DXcsOR61j/y/8AhMN8Ko0ab9a1UJQA3FvUH/S2onOk1EIiTVTNdLYAnREz
	 aM8kAH6TQHGMIa8NXaA775HtCIVqbQzPpEt+oOYFNTBSB1H2ykrJpQde1ARq9zLSkUhVI
	 wP7RF5sWysN+KyN3K2O0Mh43ThJbYElP/hBU28ltTVflbc34IoBNYwZkmUpbKt8Xhshxb
	 upJGOdvKxoz0fntk+XFroszY8DspoqwhtdFvGhm7eOf1eFTd6hSeyegSkQHqqURlK+Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794834144;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=KgEBDHbA9kv94JVlk8vWzAwb9vZd7BlPhAi6IUHRgO0=;
	b=tDdCh+vThtJSSvdJHcLaTbyBEHmzias5sZDj5XoekvvGukATWWf2uO85my0oCldI8URQ
	 IOCS0xj1JLwVNF2a9VcOvrj6H1F6wxg7i0oncksj5Fyc2eQqYvr3BbJtiRkdhJN7Qbll7
	 JZNzGTWZ00jr2/xXsZjiC3jo6WY+uP+hBwuC+m+tvfJBk7Rx2WynvF2eOwBLepar3Bn+4
	 Qp5knYgynXVcHEfMwrLB/veb4ieMNko8UHkTed6Gsiy2NiohJQYI9VS7GsA7+w/cnCAre
	 L73JFD59VFYXCGk11n8EOD6K0GEJBvbR6rq4l8xSyrW45x1RYFul9ngrEXgxRal8DLg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RuANGr96;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jTqw7TTm;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794834144;
	bh=KgEBDHbA9kv94JVlk8vWzAwb9vZd7BlPhAi6IUHRgO0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=y75BHYdWQECi6roUy/rcKn21oh2Om8oi2mwyqTi/8NVcg/+Wbt+HVOeJwo6UFqo9Q
	 7NAF9UazeX1Im3EhDsSmvPKn9oPVCqU33HQ0mn8AHgz0SvpgA5tqXx2YBkCebFmFrQ
	 gWffgt6U5o3thuOZvINKLXBA/S4p2V8iuLZE2aDt8r9zH5AQX5TO4FYHK5B7V5Fwwc
	 LfG2ldLmeVQy+ZCdWebt5PH9Y9bhOqXLpu2VwCehUQWHq/UQ68/9tZtCZuR4eebNiN
	 P7G2W+1VzJe84D4QZAkiB5ImXucTdbKcVWFEkuxUFxBV84exv1HoJ3WTK9zZUuu41P
	 fWUSTR8mkzKoQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 98D1880F24;
	Mon, 16 Nov 2026 13:02:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 5F0C14A0
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 05:08:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 44F09808BD
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 05:08:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fumxG4klkiCN for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 05:08:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2977380872
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=subrahmanya.lingappa@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=RuANGr96; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=jTqw7TTm
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2977380872
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 05:08:26 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AG4QoQi674981
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 05:08:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 KgEBDHbA9kv94JVlk8vWzAwb9vZd7BlPhAi6IUHRgO0=; b=RuANGr96IyBOrw66
 wjxugpSzLiwvYTeyWYYjDpBR37mTMBHEDDLlzQqFOISbUzEy7Hs+Gs6wJraakS7X
 asrOc6l6qMueKoBv7gr1PNhbAQlNniduDG8hE7/nEG+5BQMn2gH7FmDXV+uVPDTB
 g5cT3cA+SEl5Gs0vrJFSbaiAXhqVJF/PqmVw7osiwyBbk0vzqfMosFKSFZ7pl3f6
 KqpBP9Vx4eB5KfpuePDVruAlrioJp8oB/xo94jS93JlAOXyEmP0agJf+1oUZtBoM
 XQFaPPXAzBcLJESnS8TO/tmvuAnRvRC33TW+74lB4kQdeAj98+ABGbaHMvq8j7sE
 Puj7bQ==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hyrmc0hqa-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 05:08:25 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-7cc2c798d76so77832137.0
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 21:08:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794805705; x=1795410505;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=KgEBDHbA9kv94JVlk8vWzAwb9vZd7BlPhAi6IUHRgO0=;
 b=jTqw7TTmK1dZI8z8oQINh0YG7K5E1AbqNzN7ToKpbHPQSiMEpha8ivz7C4bzJtHsnj
 5ncOTB4fdIP2cRSx5afvsdkf5KgPOXGfaBvE3FF/itiZV7zUmqCc1M70ZJ1CmQ4t6iuy
 +oFH1mfuC+hq3oalXOSAxcTFPTpY/6Oglys4MronRH0QaTv3V3azf59eb/MpiO1fDfv5
 vhvsbN9BI9DxUPFxWs3X3vLYuXEyoQW6q1qJy6dRG+7gmhisslXhPU38UQwQMOEyh7la
 adqdlVwAyIFVquLWG3TzA7ToRuFG1D1nGMe2DAnMb33T6l6O46/TMfODpQ5a3q4qc8SB
 zy2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794805705; x=1795410505;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KgEBDHbA9kv94JVlk8vWzAwb9vZd7BlPhAi6IUHRgO0=;
 b=t1f/hyq1CWOooYk1W9ttUCnNgR63DQo+A7/x/Nx7LQxnGykulsb6Ph+Ks2Ojb69o26
 zZPbgdL+hwcFbYwZm6lJkJkf6LLSAlR0Aume7GY/jMcHLdsUb+GdgPB4GMm5yKqT07zz
 Ge0aTRdwtJfaXCvA3AvM0tF+z7uA/EdKlBGz/NNEmhr4RHeg/MU9ozor1qC52KwWRrSM
 ByDGZi+FCBkWBHs5Sa9BGe9sPmpLMhv5ZCz0PfDTwnVniy+YRb/4Og5xqxwGKi2GGw5D
 9RDMFWBkThVwXu7FRj47gh0/JBNoKuSGVBQWFGwUgu1adWR0AdyIR+1haRJjz8f7QD0O
 6MnA==
X-Gm-Message-State: APuU4Z+0pjTVOdarExDDvtsCZCOx7widUiH3zAaABfXB8vm+dsnExtpa
 uevrcvtOhMwnMrptSPkEfnQAxGgbbK017F0h10nFMMptySX2e5QXsQs4bgac9AoP8RCRUE8odrc
 hrmQhG1gqx5YgjLAYAxqLP7LzPkRVONwdSTrzi4TR/zAgh5ashr/rl1m0LFDtVncATtUqNliBwJ
 nKTG10AEhqytMLiFfZtui4i5QQdfr+11g4Vq9qRq+qpvJWfw==
X-Gm-Gg: AYBFou1OiPhf4BK/k9xPtmxqHTStUYaCpgIGgIwz5gsQ6d+cajkdpcgT/m67hwmlBAg
 4NZlIUJ1+mBeXoeKhpViXq9hNgLIjWxXfkfxazJ8mFXhP16aQ6Csf685we/DkZPzAKQY8LWV0CG
 WsS4dpAHFfcQ84HWHUIVPE6g3uHpVCOacvVW4ejyzi0tNIA7sQfi3mbaCQzprkQo0npLYO1F5tW
 NVw3UZci0QXNP/TxyX3Ern+OvNMft+QfBqOM5AQVB4i
X-Received: by 2002:a05:6102:834d:20b0:7c3:99a3:314e with SMTP id
 ada2fe7eead31-7d64d120edfmr3293203137.0.1794805704764; 
 Sun, 15 Nov 2026 21:08:24 -0800 (PST)
X-Received: by 2002:a05:6102:834d:20b0:7c3:99a3:314e with SMTP id
 ada2fe7eead31-7d64d120edfmr3293192137.0.1794805704237; Sun, 15 Nov 2026
 21:08:24 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261113-rpmi_v4-v5-0-6787318ad186@microchip.com>
 <20261113-rpmi_v4-v5-6-6787318ad186@microchip.com>
In-Reply-To: <20261113-rpmi_v4-v5-6-6787318ad186@microchip.com>
From: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
Date: Mon, 16 Nov 2026 10:38:13 +0530
X-Gm-Features: Aa3M54oKmeQebC7sH6fjtVztwYmQZE3z4_PJCMjxcAd9yoavT-FH58VnpARhKaE
Message-ID: <CAPxK-6crCBPOKo5L2M66RtM5Nn3PVa=oHQdcmU=Q7jtDiFRz0w@mail.gmail.com>
Subject: Re: [PATCH v5 6/8] drivers: firmware: rpmi: Add the mpxy command
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
 Peng Fan <peng.fan@oss.nxp.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Rahul Pathak <rahul.pathak@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDAyMCBTYWx0ZWRfX1hXNmQsaYMXx
 UW99d3rDt+GZzbjfxyXljmkGgDawA2PmzE8jq8vtSvJJAbtG/LKddWs6grsOfI5lj92j/Baz/iX
 d/YEI46eqHwQ+13w/AT1B8Ngyg/EuOY=
X-Authority-Analysis: v=2.4 cv=C9N8WgP+ c=1 sm=1 tr=0 ts=6afa8fc9 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=XYAwZIGsAAAA:8
 a=THC3nfLtLiY2RFlhqAcA:9 a=QEXdDO2ut3YA:10 a=-aSRE8QhW-JAV6biHavz:22
 a=E8ToXWR_bxluHZ7gmE-Z:22
X-Proofpoint-ORIG-GUID: xAH4XATW7lo229ly78mq6taVVAWh38A-
X-Proofpoint-GUID: xAH4XATW7lo229ly78mq6taVVAWh38A-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDAyMCBTYWx0ZWRfX+gAwnvFCggRV
 DfTE8VIQhiFbxjHchrdugiiWVRKgh64ZGbT5BGnl9EdY9OxcP7t3GHzlI00fTJj5eJIlDjhLBrD
 QieQKyZUox89G2CPTP4+lPa0ISJ4cqEkjyWZW5FBYCXmhaZ7JC+U/6UFbjORJs7Q6MMdefyStRW
 l5SVXIbvYnAtuHqx9vJbTIa7/ipLtvq8OOuU0oX/xBn21kuGxJDhUNp35HN0EkQn6yIsrA8d9c1
 Gq/+w5FRRDaXE72oHnN6lmCeFPJFGRq4CpxAhn67In54l3t2jxP4rYmFVj2yd7VmIvk3ZNpvtjk
 8jrfHh9OTuV9bk3n/okF9vztBweSaLrcA4tUFdNq08DT1zDXTLi0+3ZCivP+0GtxZ90GPSSGgWP
 Y4HAkPYmpOtctDoOVDNb91a/yq0hNn39sCxt6m9OofoqmBlb4zYX+qa2VpPDseDOxdO+DXWVOeu
 MJrLz0x1LUEOH3MtNKA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_02,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611160020
X-Mailman-Approved-At: Mon, 16 Nov 2026 13:02:15 +0000
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
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Reviewed-by: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>

On Sat, Nov 14, 2026 at 1:13=E2=80=AFAM Charles Perry
<charles.perry@microchip.com> wrote:
>
> From: Rahul Pathak <rahul.pathak@oss.qualcomm.com>
>
> Add the mpxy command which allows listing MPXY channels, reading/writing
> arbitrary channel attributes and sending raw messages.
>
> The mpxy command is useful for interacting with custom RPMI service group=
s
> that have no associated driver. It can also be useful for debugging and
> testing SBI proxy drivers as well as the PuC firmware.
>
> Signed-off-by: Rahul Pathak <rahul.pathak@oss.qualcomm.com>
> Signed-off-by: Charles Perry <charles.perry@microchip.com>
> ---
> Changes in v5: (from Subrahmanya review)
>  - fix a bad indexing into mpxy->channel_descs[]
>  - Add mpxy_find_chandesc() to support the function signature change of
>    rpmi_sbi_mpxy_send_message() needed to support the added bound checkin=
g
>    in patch 2.
>  - Remove the "g_mpxy" global variable and use
>    uclass_get_device_by_driver() instead. (from LLM review)
>
> Changes in v4:
>  - Force a device_probe() of all UCLASS_RPMI devices if g_mpxy is NULL
>  - Remove the unnecessary edit to "cmd/riscv/Makefile"
>  - Fix a printf placeholder for 32 bits %ld -> %zu
>
> Changes in v3:
>  - Add this patch
> ---
>  drivers/firmware/rpmi/Kconfig         |   7 +
>  drivers/firmware/rpmi/rpmi-sbi-mpxy.c | 413 ++++++++++++++++++++++++++++=
+++++-
>  2 files changed, 416 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/firmware/rpmi/Kconfig b/drivers/firmware/rpmi/Kconfi=
g
> index b462d3693987..c6a6b6fe61de 100644
> --- a/drivers/firmware/rpmi/Kconfig
> +++ b/drivers/firmware/rpmi/Kconfig
> @@ -18,6 +18,13 @@ config RPMI_SBI_MPXY
>           specification for the MPXY extension is available at:
>           https://github.com/riscv-non-isa/riscv-sbi-doc (chapter 20)
>
> +config CMD_MPXY
> +       bool "mpxy command"
> +       depends on RPMI_SBI_MPXY
> +       help
> +         Enable the 'mpxy' U-Boot command for listing MPXY channels,
> +         reading/writing arbitrary channel attributes and sending raw me=
ssages.
> +
>  config RPMI_SHMEM
>         bool "RPMI over shared memory transport"
>         depends on RPMI_FIRMWARE
> diff --git a/drivers/firmware/rpmi/rpmi-sbi-mpxy.c b/drivers/firmware/rpm=
i/rpmi-sbi-mpxy.c
> index 3398271f8567..d0a60070d17c 100644
> --- a/drivers/firmware/rpmi/rpmi-sbi-mpxy.c
> +++ b/drivers/firmware/rpmi/rpmi-sbi-mpxy.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
>   * Copyright (C) 2026 Microchip Technology Inc. All rights reserved.
> + * Copyright (c) 2026, Rahul Pathak <rahul.pathak@oss.qualcomm.com>
>   */
>
>  #define LOG_CATEGORY UCLASS_RPMI
> @@ -16,6 +17,7 @@
>  #include <malloc.h>
>  #include <rpmi-uclass.h>
>  #include <string.h>
> +#include <dm/device-internal.h>
>
>  /* SBI MPXY channel IDs data in shared memory */
>  struct sbi_mpxy_channel_ids_data {
> @@ -60,10 +62,10 @@ enum sbi_mpxy_attribute_id {
>
>  /* RPMI message protocol specific MPXY attributes */
>  enum sbi_mpxy_rpmi_attribute_id {
> -       SBI_MPXY_RPMI_ATTR_SERVICEGROUP_ID,
> -       SBI_MPXY_RPMI_ATTR_SERVICEGROUP_VERSION,
> -       SBI_MPXY_RPMI_ATTR_IMPL_ID,
> -       SBI_MPXY_RPMI_ATTR_IMPL_VERSION,
> +       SBI_MPXY_RPMI_ATTR_SERVICEGROUP_ID =3D 0x00,
> +       SBI_MPXY_RPMI_ATTR_SERVICEGROUP_VERSION =3D 0x01,
> +       SBI_MPXY_RPMI_ATTR_IMPL_ID =3D 0x02,
> +       SBI_MPXY_RPMI_ATTR_IMPL_VERSION =3D 0x03,
>         SBI_MPXY_RPMI_ATTR_MAX_ID
>  };
>
> @@ -87,6 +89,17 @@ struct rpmi_sbi_mpxy {
>         struct sbi_mpxy_chan_desc *channel_descs;
>  };
>
> +static __maybe_unused struct rpmi_sbi_mpxy *mpxy_get_priv(void)
> +{
> +       struct udevice *dev;
> +
> +       if (uclass_get_device_by_driver(UCLASS_RPMI,
> +                                       DM_DRIVER_GET(rpmi_sbi_mpxy), &de=
v))
> +               return NULL;
> +
> +       return dev_get_priv(dev);
> +}
> +
>  static int rpmi_sbi_mpxy_read_attrs(struct rpmi_sbi_mpxy *mpxy, u32 chan=
nel_id,
>                                     u32 base_attrid, u32 attr_count,
>                                     u32 *attrs_buf)
> @@ -105,6 +118,24 @@ static int rpmi_sbi_mpxy_read_attrs(struct rpmi_sbi_=
mpxy *mpxy, u32 channel_id,
>         return 0;
>  }
>
> +static __maybe_unused int
> +rpmi_sbi_mpxy_write_attrs(struct rpmi_sbi_mpxy *mpxy, u32 channel_id,
> +                         u32 base_attrid, u32 attr_count, u32 *attrs_buf=
)
> +{
> +       struct sbiret sret;
> +       int i;
> +
> +       for (i =3D 0; i < attr_count; i++)
> +               ((__le32 *)mpxy->shmem)[i] =3D cpu_to_le32(attrs_buf[i]);
> +
> +       sret =3D sbi_ecall(SBI_EXT_MPXY, SBI_EXT_MPXY_WRITE_ATTRS, channe=
l_id,
> +                        base_attrid, attr_count, 0, 0, 0);
> +       if (sret.error)
> +               return sbi_to_linux_error(sret.error);
> +
> +       return 0;
> +}
> +
>  static int rpmi_sbi_mpxy_send_message(struct rpmi_sbi_mpxy *mpxy,
>                                       struct sbi_mpxy_chan_desc *desc,
>                                       u32 mpxy_fid, u32 msg_id, const voi=
d *tx,
> @@ -413,3 +444,377 @@ U_BOOT_DRIVER(rpmi_sbi_mpxy) =3D {
>         .ops =3D &rpmi_sbi_mpxy_ops,
>         .flags =3D DM_FLAG_PRE_RELOC,
>  };
> +
> +#if CONFIG_IS_ENABLED(CMD_MPXY) && !CONFIG_IS_ENABLED(XPL_BUILD)
> +
> +#include <command.h>
> +#include <hexdump.h>
> +
> +static const char *mpxy_proto_to_str(u32 proto_id)
> +{
> +       switch (proto_id) {
> +       case SBI_MPXY_MSGPROTO_RPMI_ID:
> +               return "RPMI";
> +       default:
> +               return "Unknown";
> +       }
> +}
> +
> +static struct sbi_mpxy_chan_desc *mpxy_find_chandesc(struct rpmi_sbi_mpx=
y *mpxy,
> +                                                    u32 chan_id)
> +{
> +       for (int i =3D 0; i < mpxy->channel_count; i++) {
> +               if (mpxy->channel_descs[i].id =3D=3D chan_id)
> +                       return &mpxy->channel_descs[i];
> +       }
> +
> +       return NULL;
> +}
> +
> +/**
> + * mpxy list
> + *
> + * List the mpxy channels
> + */
> +static int do_mpxy_list(struct cmd_tbl *cmdtp, int flag, int argc,
> +                       char *const argv[])
> +{
> +       struct rpmi_sbi_mpxy *mpxy =3D mpxy_get_priv();
> +       struct sbi_mpxy_chan_desc *chan;
> +       u32 proto;
> +       int i;
> +
> +       if (!mpxy)
> +               return CMD_RET_FAILURE;
> +
> +       for (i =3D 0; i < mpxy->channel_count; i++) {
> +               chan =3D &mpxy->channel_descs[i];
> +               proto =3D chan->attrs[SBI_MPXY_ATTR_MSG_PROT_ID];
> +               printf("Channel 0x%x: proto_id=3D0x%x (%s), ver=3D0x%x\n"=
, chan->id,
> +                      proto, mpxy_proto_to_str(proto),
> +                      chan->attrs[SBI_MPXY_ATTR_MSG_PROT_VER]);
> +       }
> +
> +       printf("sbi_mpxy: found %d channels\n", mpxy->channel_count);
> +       return CMD_RET_SUCCESS;
> +}
> +
> +static void mpxy_print_capability(u32 val)
> +{
> +       static const struct {
> +               u32 bit;
> +               const char *name;
> +       } caps[] =3D {
> +               { SBI_MPXY_CHAN_CAP_MSI, "MSI" },
> +               { SBI_MPXY_CHAN_CAP_SSE, "SSE_EVENT" },
> +               { SBI_MPXY_CHAN_CAP_EVENTS_STATE, "EVENTS_STATE" },
> +               { SBI_MPXY_CHAN_CAP_SEND_WITH_RESP, "SEND_WITH_RESP" },
> +               { SBI_MPXY_CHAN_CAP_SEND_WITHOUT_RESP, "SEND_WITHOUT_RESP=
" },
> +               { SBI_MPXY_CHAN_CAP_GET_NOTIFICATIONS, "GET_NOTIFICATIONS=
" },
> +       };
> +
> +       bool any =3D false;
> +       int i;
> +
> +       printf(" (");
> +
> +       if (!val) {
> +               printf("none)\n");
> +               return;
> +       }
> +
> +       for (i =3D 0; i < ARRAY_SIZE(caps); i++) {
> +               if (val & caps[i].bit) {
> +                       if (any)
> +                               printf("|");
> +                       printf("%s", caps[i].name);
> +                       any =3D true;
> +               }
> +       }
> +       printf(")\n");
> +}
> +
> +/* Decode well-known field values for selected standard attributes */
> +static void mpxy_print_std_attr(u32 attr_id, u32 val)
> +{
> +       /* Standard MPXY attribute names, indexed by attr_id */
> +       static const char *const mpxy_std_attr_names[] =3D {
> +               [SBI_MPXY_ATTR_MSG_PROT_ID] =3D "MSG_PROT_ID",
> +               [SBI_MPXY_ATTR_MSG_PROT_VER] =3D "MSG_PROT_VER",
> +               [SBI_MPXY_ATTR_MSG_MAX_LEN] =3D "MSG_MAX_LEN",
> +               [SBI_MPXY_ATTR_MSG_SEND_TIMEOUT] =3D "MSG_SEND_TIMEOUT",
> +               [SBI_MPXY_ATTR_MSG_COMPLETION_TIMEOUT] =3D
> +                       "MSG_COMPLETION_TIMEOUT",
> +               [SBI_MPXY_ATTR_CHANNEL_CAPABILITY] =3D "CHANNEL_CAPABILIT=
Y",
> +               [SBI_MPXY_ATTR_SSE_EVENT_ID] =3D "SSE_EVENT_ID",
> +               [SBI_MPXY_ATTR_MSI_CONTROL] =3D "MSI_CONTROL",
> +               [SBI_MPXY_ATTR_MSI_ADDR_LO] =3D "MSI_ADDR_LO",
> +               [SBI_MPXY_ATTR_MSI_ADDR_HI] =3D "MSI_ADDR_HI",
> +               [SBI_MPXY_ATTR_MSI_DATA] =3D "MSI_DATA",
> +               [SBI_MPXY_ATTR_EVENTS_STATE_CONTROL] =3D "EVENTS_STATE_CO=
NTROL",
> +       };
> +
> +       printf("  [0x%02x] %-28s: 0x%08x", attr_id,
> +              mpxy_std_attr_names[attr_id], val);
> +
> +       switch (attr_id) {
> +       case SBI_MPXY_ATTR_MSG_PROT_ID:
> +               printf(" (%s)\n", mpxy_proto_to_str(val));
> +               break;
> +       case SBI_MPXY_ATTR_MSG_PROT_VER:
> +               printf(" (v%u.%u)\n", (val >> 16) & 0xffff, val & 0xffff)=
;
> +               break;
> +       case SBI_MPXY_ATTR_MSG_MAX_LEN:
> +               printf(" (%u bytes)\n", val);
> +               break;
> +       case SBI_MPXY_ATTR_MSG_SEND_TIMEOUT:
> +       case SBI_MPXY_ATTR_MSG_COMPLETION_TIMEOUT:
> +               printf(" (%u ms)\n", val);
> +               break;
> +       case SBI_MPXY_ATTR_CHANNEL_CAPABILITY:
> +               mpxy_print_capability(val);
> +               break;
> +       default:
> +               printf("\n");
> +               break;
> +       }
> +}
> +
> +static const char *mpxy_rpmi_proto_attr_name(u32 attr_id)
> +{
> +       switch (attr_id) {
> +       case SBI_MPXY_RPMI_ATTR_SERVICEGROUP_ID:
> +               return "SERVICEGROUP_ID";
> +       case SBI_MPXY_RPMI_ATTR_SERVICEGROUP_VERSION:
> +               return "SERVICEGROUP_VERSION";
> +       case SBI_MPXY_RPMI_ATTR_IMPL_ID:
> +               return "IMPLEMENTATION_ID";
> +       case SBI_MPXY_RPMI_ATTR_IMPL_VERSION:
> +               return "IMPLEMENTATION_VER";
> +       default:
> +               return "UNKNOWN";
> +       };
> +}
> +
> +static void mpxy_print_proto_attr(u32 attr_id, u32 val, bool is_rpmi)
> +{
> +       u32 rpmi_attr_id =3D attr_id - SBI_MPXY_ATTR_MSGPROTO_ATTR_START;
> +       const char *name =3D is_rpmi ? mpxy_rpmi_proto_attr_name(rpmi_att=
r_id) :
> +                                    "UNKNOWN";
> +
> +       printf("  [0x%08x] %-24s: 0x%08x", attr_id, name, val);
> +
> +       if (is_rpmi &&
> +           (rpmi_attr_id =3D=3D SBI_MPXY_RPMI_ATTR_SERVICEGROUP_VERSION =
||
> +            rpmi_attr_id =3D=3D SBI_MPXY_RPMI_ATTR_IMPL_VERSION)) {
> +               printf(" (v%u.%u)\n", (val >> 16) & 0xffff, val & 0xffff)=
;
> +       } else {
> +               printf("\n");
> +       }
> +}
> +
> +/**
> + * mpxy readattr <channel_id> <attr_id>
> + *
> + * Read the attribute on a channel
> + */
> +static int do_mpxy_readattr(struct cmd_tbl *cmdtp, int flag, int argc,
> +                           char *const argv[])
> +{
> +       struct rpmi_sbi_mpxy *mpxy =3D mpxy_get_priv();
> +       u32 chan_id, attr_id, attr_val;
> +       int ret;
> +
> +       if (argc < 3)
> +               return CMD_RET_USAGE;
> +
> +       if (!mpxy)
> +               return CMD_RET_FAILURE;
> +
> +       chan_id =3D simple_strtoul(argv[1], NULL, 0);
> +       attr_id =3D simple_strtoul(argv[2], NULL, 0);
> +
> +       ret =3D rpmi_sbi_mpxy_read_attrs(mpxy, chan_id, attr_id, 1, &attr=
_val);
> +       if (ret) {
> +               printf("Read attr 0x%x on channel 0x%x failed (%d)\n", at=
tr_id,
> +                      chan_id, ret);
> +               return CMD_RET_FAILURE;
> +       }
> +
> +       printf("Channel 0x%x: attr[0x%x] =3D 0x%x\n", chan_id, attr_id, a=
ttr_val);
> +       return CMD_RET_SUCCESS;
> +}
> +
> +/**
> + * mpxy readattrall <channel_id>
> + */
> +static int do_mpxy_readattr_all(struct cmd_tbl *cmdtp, int flag, int arg=
c,
> +                               char *const argv[])
> +{
> +       struct rpmi_sbi_mpxy *mpxy =3D mpxy_get_priv();
> +       u32 chan_id, attr_val[SBI_MPXY_ATTR_STD_ATTR_MAX_IDX];
> +       bool is_rpmi;
> +       int i, ret;
> +
> +       if (argc < 2)
> +               return CMD_RET_USAGE;
> +
> +       if (!mpxy)
> +               return CMD_RET_FAILURE;
> +
> +       chan_id =3D simple_strtoul(argv[1], NULL, 0);
> +
> +       ret =3D rpmi_sbi_mpxy_read_attrs(mpxy, chan_id, SBI_MPXY_ATTR_MSG=
_PROT_ID,
> +                                      SBI_MPXY_ATTR_STD_ATTR_MAX_IDX,
> +                                      attr_val);
> +       if (ret) {
> +               printf("Read attr on channel 0x%x failed (%d)\n", chan_id=
, ret);
> +               return CMD_RET_FAILURE;
> +       }
> +
> +       is_rpmi =3D attr_val[SBI_MPXY_ATTR_MSG_PROT_ID] =3D=3D
> +                 SBI_MPXY_MSGPROTO_RPMI_ID;
> +
> +       /* Standard attributes */
> +       printf("Channel 0x%x standard attributes:\n", chan_id);
> +       for (i =3D 0; i < SBI_MPXY_ATTR_STD_ATTR_MAX_IDX; i++)
> +               mpxy_print_std_attr(i, attr_val[i]);
> +
> +       /* Protocol-specific attributes */
> +       printf("Channel 0x%x protocol attributes:\n", chan_id);
> +
> +       for (i =3D SBI_MPXY_ATTR_MSGPROTO_ATTR_START;
> +            i < SBI_MPXY_ATTR_MSGPROTO_ATTR_END; i++) {
> +               ret =3D rpmi_sbi_mpxy_read_attrs(mpxy, chan_id, i, 1,
> +                                              &attr_val[0]);
> +               if (ret)
> +                       break;
> +
> +               mpxy_print_proto_attr(i, attr_val[0], is_rpmi);
> +       }
> +
> +       return CMD_RET_SUCCESS;
> +}
> +
> +/**
> + * mpxy writeattr <channel_id> <attr_id> <value>
> + */
> +static int do_mpxy_writeattr(struct cmd_tbl *cmdtp, int flag, int argc,
> +                            char *const argv[])
> +{
> +       struct rpmi_sbi_mpxy *mpxy =3D mpxy_get_priv();
> +       u32 chan_id, attr_id, attr_val;
> +       int ret;
> +
> +       if (argc < 4)
> +               return CMD_RET_USAGE;
> +
> +       if (!mpxy)
> +               return CMD_RET_FAILURE;
> +
> +       chan_id =3D simple_strtoul(argv[1], NULL, 0);
> +       attr_id =3D simple_strtoul(argv[2], NULL, 0);
> +       attr_val =3D simple_strtoul(argv[3], NULL, 0);
> +
> +       ret =3D rpmi_sbi_mpxy_write_attrs(mpxy, chan_id, attr_id, 1, &att=
r_val);
> +       if (ret) {
> +               printf("Write attr 0x%x on channel 0x%x failed (%d)\n", a=
ttr_id,
> +                      chan_id, ret);
> +               return CMD_RET_FAILURE;
> +       }
> +
> +       printf("Channel 0x%x: attr[0x%x] written 0x%x\n", chan_id, attr_i=
d,
> +              attr_val);
> +       return CMD_RET_SUCCESS;
> +}
> +
> +/**
> + * mpxy send <channel_id> <msg_id> [payload_word ...]
> + *
> + * For RPMI, msg_id is the service_id. Payload words follow.
> + */
> +static int do_mpxy_send(struct cmd_tbl *cmdtp, int flag, int argc,
> +                       char *const argv[])
> +{
> +       struct rpmi_sbi_mpxy *mpxy =3D mpxy_get_priv();
> +       struct sbi_mpxy_chan_desc *desc;
> +       u32 tx[64];
> +       u32 rx[64];
> +       unsigned long tx_words, rx_bytes;
> +       u32 chan_id, service_id;
> +       int i, ret;
> +
> +       if (argc < 3)
> +               return CMD_RET_USAGE;
> +
> +       if (!mpxy)
> +               return CMD_RET_FAILURE;
> +
> +       chan_id =3D simple_strtoul(argv[1], NULL, 0);
> +       service_id =3D simple_strtoul(argv[2], NULL, 0);
> +       tx_words =3D argc - 3;
> +
> +       if (tx_words > ARRAY_SIZE(tx)) {
> +               printf("Too many words (max %zu)\n", ARRAY_SIZE(tx));
> +               return CMD_RET_FAILURE;
> +       }
> +
> +       desc =3D mpxy_find_chandesc(mpxy, chan_id);
> +       if (!desc) {
> +               printf("Cannot find channel 0x%x\n", chan_id);
> +               return CMD_RET_FAILURE;
> +       }
> +
> +       for (i =3D 0; i < tx_words; i++)
> +               tx[i] =3D simple_strtoul(argv[3 + i], NULL, 0);
> +
> +       ret =3D rpmi_sbi_mpxy_send_message(mpxy, desc,
> +                                        SBI_EXT_MPXY_SEND_MSG_WITH_RESP,
> +                                        service_id, tx, tx_words * 4, rx=
,
> +                                        sizeof(rx), &rx_bytes);
> +       if (ret) {
> +               printf("Send on channel 0x%x failed (%d)\n", chan_id, ret=
);
> +               return CMD_RET_FAILURE;
> +       }
> +
> +       printf("Response (%ld word(s)):\n", rx_bytes / 4);
> +       print_hex_dump(" ", DUMP_PREFIX_OFFSET, 4, 4, rx, rx_bytes, true)=
;
> +
> +       return CMD_RET_SUCCESS;
> +}
> +
> +/**
> + * Subcommand table and top-level dispatch
> + */
> +static struct cmd_tbl cmd_mpxy_sub[] =3D {
> +       U_BOOT_CMD_MKENT(list, 1, 0, do_mpxy_list, "", ""),
> +       U_BOOT_CMD_MKENT(readattr, 3, 0, do_mpxy_readattr, "", ""),
> +       U_BOOT_CMD_MKENT(readattrall, 2, 0, do_mpxy_readattr_all, "", "")=
,
> +       U_BOOT_CMD_MKENT(writeattr, 4, 0, do_mpxy_writeattr, "", ""),
> +       U_BOOT_CMD_MKENT(send, CONFIG_SYS_MAXARGS, 0, do_mpxy_send, "", "=
"),
> +};
> +
> +static int do_mpxy(struct cmd_tbl *cmdtp, int flag, int argc,
> +                  char *const argv[])
> +{
> +       struct cmd_tbl *c;
> +
> +       if (argc < 2)
> +               return CMD_RET_USAGE;
> +
> +       c =3D find_cmd_tbl(argv[1], cmd_mpxy_sub, ARRAY_SIZE(cmd_mpxy_sub=
));
> +       if (!c)
> +               return CMD_RET_USAGE;
> +
> +       return c->cmd(cmdtp, flag, argc - 1, argv + 1);
> +}
> +
> +U_BOOT_CMD(
> +       mpxy, CONFIG_SYS_MAXARGS, 0, do_mpxy, "SBI MPXY channel debug com=
mands",
> +       "list                              - list discovered channels\n"
> +       "mpxy readattr    <chan> <attr>         - read one attribute\n"
> +       "mpxy readattrall <chan>                - read all attributes\n"
> +       "mpxy writeattr   <chan> <attr> <val>   - write an attribute\n"
> +       "mpxy send        <chan> <msg_id> [payload_word ...]  - send mess=
age\n");
> +
> +#endif // CONFIG_CMD_MPXY
>
> --
> 2.53.0
>
