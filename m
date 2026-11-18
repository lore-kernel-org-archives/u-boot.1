Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7099B606A31C
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 04:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=f6v7AglH;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=e+FcoEfg;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YNA6rf6U
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 39A4A40800;
	Wed, 18 Nov 2026 04:21:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NyWUAR0EOCkS; Wed, 18 Nov 2026 04:21:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 868A140802
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794975693;
	b=I8VU6F20QMYMQ9DMyySwx6CGz1izH6e0yoWEC5ITMf7S2RGOW703Ezj0QwSp/4Ca6uAq
	 jvFpfCcl3XwyDv+6WxpdhhU5xjvwJ9TuFdmYhIPeKxQGTQp21CBXo+uWte5O+9SaN746K
	 vhKd00XNUok9gET9gFSKimJth8nJQz/tARbTpLTqkI08oWRRzdoKi/X4wIti4gFYchFGf
	 /YXnLH33UBAkNvyt8+eIcB3cKFru9MQFPTmqogXDohltRrEcMqCzF1sjRWpezO+zlRO25
	 e1bbbLQ8mCkuGjaiIUxV1yWzYNgQPKUWCGllfptsL/lQjWhv6YdfJ3apw6Pf0twepuw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794975693;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=59UVLEyfCSEn4XzQnXrtMpKI3Y30f/+9/CHzPXwXoxA=;
	b=q44RJNlTO5q7lTnae9h2FFIVpU9aPVNAkOum/Wt4L/C9lxm6DC8EgnL7GlmiFVH27aQP
	 hHMjR0WS2BOJSp1hineZJFDZLb9f2NIMBjcWfH/Df5LiTArThtHgwjpSKkGo+D1q4TOKD
	 c4IM4w+mJ9IBoyi2tpOZ5Tx7/OQurg0xfmvWJh1SnVyUs+6ft5HTykH4K33853OAbIYHT
	 wv3hMFJ+R3ntV0OxjJ+MMOiJCqD/yjUzqlu8/YajJLSgAOB9SElujyK60rR3Qanl7tSrO
	 R2td7v+kSF73X7lgQODwdqsYSL5KHV1xkeJT5Dn5CeOhi9KFCcWQK4suiyWuF0pZEHQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=e+FcoEfg;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YNA6rf6U;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794975693;
	bh=59UVLEyfCSEn4XzQnXrtMpKI3Y30f/+9/CHzPXwXoxA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=f6v7AglHT+GT6ZxvdLvPkJou9irmCYmf0ZOuZl7D2rV5of5zehizHgqi4aQKlv+ce
	 x/jMgAhZGrq25SNVjP4zExSY6BrsOu4E78IA0/cQLYpbJEnGZU7hlPhaCGxjKxxmSF
	 ZnLoWSGwT5vJ4DaLM7r8fywuBjXL5O6WJNFNofp6adgm76vASJBhrywCgiOf1es8PS
	 wqNDBon2wkNjv6rNsRs+jPyCZLDuTEh8NCtL0DX7c9zmocIElrtfIUbbfBXoLj90VC
	 xRQNcU/u8M6sVDmNSR+IcrXn1GJnWzaznX0zlP87GA+aQnMiNKo+hl6YzJ9XVouBDA
	 KFt+zXO3YsDAA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 868A140802;
	Wed, 18 Nov 2026 04:21:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 535D661
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 04:21:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3935140802
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 04:21:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id niFI5YES9hlY for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 04:21:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 44BBC40800
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=e+FcoEfg; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=YNA6rf6U
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 44BBC40800
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 04:21:30 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AI2V2vt2106333
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 04:21:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 59UVLEyfCSEn4XzQnXrtMpKI3Y30f/+9/CHzPXwXoxA=; b=e+FcoEfgkxWM8WhL
 MICO3vExAIRBOwToR52qXnKM2T1YKX4K9/GYZujoXPTxORwknqertt/lLEkrV8tz
 Osxns8tSgWnJ5QsI07s8zLIQt9N9PRxjumYyYKCYPVTJI4VtYZfRm/DIGWuU8N8p
 4m55UHmQ/KWVn88Ft3Cex7S8PsWo4rTPPgrH1KV1SqM78PcvPZz3X7deLWi1W4Ca
 1afQMZ3RhTc6tksuI70OYBDxkcO2cHpNdvV30JDi1WuHQJ1KTLV93oIH4ogR4etJ
 sMBU0wsZWCF1vckCtAFoD+7vh6YLXOWSssOGc/KJ/ScL88IxmM0glAWgUbiqS55m
 Cvz0AA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0yv8s4et-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 04:21:29 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-36a3451ea93so647929eec.1
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 20:21:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794975689; x=1795580489;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=59UVLEyfCSEn4XzQnXrtMpKI3Y30f/+9/CHzPXwXoxA=;
 b=YNA6rf6UNBgVEudDFmGBaB48nulAN2HBTrOywgRFWQRSP6DUwKkAO8hRSjOUofMuJd
 7CDNmZov3kLybTFCZG8gWWpPYO2pIq555fdK2scmA5sJGB8y/wwO4fHIOwZeTh1D5kIg
 JY6/hVyOlQ0BfZdN6pkHxYubPmFXampkNrjlXGfmtG5+Q86WD4zU2T4LUsqDLD3X3u7K
 AgnzPK5BMLWk37prKhWvVlCykGh+InrDhoDw4QpnvsZDKsU0N8BgIVaogO7WlJdx1Qu+
 WXhcd9jBE5fxkGXnDIGUHc+ZaOljpU49X6UppbYPm3AEiwl7hIqwbabxAjr1AX1K4Act
 mNCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794975689; x=1795580489;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=59UVLEyfCSEn4XzQnXrtMpKI3Y30f/+9/CHzPXwXoxA=;
 b=J5eHdHRAK69lYBXWcJXdcTHh4wp9yI3VDcTiF7wyV19fx+MhuVbAyBl3+59K2a5CWn
 NZx21oSSGtBvXUxK7FIjIADuaTEZyDsGP1HOv1QEb5cCTYT7FDWL5BLFK5perkWDA14J
 VZDxvItjA/ZLBW9jxvsA3hY5ETAL7OKE6ZffIu4mt6bybIWcQ6nWzueD68RWCofXraVZ
 AnpAF0xzGlQoIf2QrVC7Jg0CveV2htjpkrQ5Pag7Z925DjNBDMzatXzaXf3wyVNdA1g0
 5cUyJFxa++uhWTvxZHO6hoHfue6FCPOYhc/+JzfQBv1QADWxefLbCloG8VNWXTgIe2a9
 WNdA==
X-Gm-Message-State: APuU4Z8PC0Aw49fKw6UMpnXgTI1S6G7XASKWQ+zMRA+um4S5Eqeb6Qk0
 rbXlf4hjNwZaC62JMW995IZIws/By0/cNlPy779lNdZjXSHufwu2mu2ptRzcnG3GsYazKRCQUz4
 RqpvbeqK19MWnkK9AdAFkFOZlzllAyQ8QB6fkib9SJghEk8iK2/QVPMYg9djjx39I03uDzes=
X-Gm-Gg: AZFdTZfwm6tULwmLlMk4Ywizh0lGtdLZnNSTPagsyxHwHXC3GIYn0HfHumGznGkYI+T
 2wpisv3xMpwlUMvurdzLtIFRywCfXHrYuzAZVAiyY9LIb1vXBV240VtBfWMvPet3Q+9uWf1gA+4
 UUgDPFBH2dmdOQcLdyetBceywUuALygOJ8wOko9ykoHS40nooB21KUtsftqFT6NpSzJpRIilsaX
 zAYp+4egd3j1YTLM6rxtpQvxOltcf0RpI2lsZd2YNbtutXSWojij8rd0CJ3NxlRIxuAO7/nnnTI
 p0hxMYgQYBzvYeQvMeup8Lf/KMSkzNuPRTTCTrAbAPz3I/U+1nXIp99fplpg0YDaBNZMxMzqyG7
 Kc6tPO2cR2qSg0wDn1eDaA34dDVmtz7zEX903I80gjsSXK2RvNcCQdokbgjJqvgiSX8EhegQfBl
 tCimZYNgObF2U=
X-Received: by 2002:a05:7301:db89:b0:34e:9923:e372 with SMTP id
 5a478bee46e88-3828111a692mr1288115eec.29.1794975688508; 
 Tue, 17 Nov 2026 20:21:28 -0800 (PST)
X-Received: by 2002:a05:7301:db89:b0:34e:9923:e372 with SMTP id
 5a478bee46e88-3828111a692mr1288093eec.29.1794975687859; 
 Tue, 17 Nov 2026 20:21:27 -0800 (PST)
Received: from [10.151.40.108] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-382a63059e3sm4442011eec.5.2026.11.17.20.21.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Nov 2026 20:21:27 -0800 (PST)
Message-ID: <3671a5c7-bb5c-4f72-8ffc-c638979cc27f@oss.qualcomm.com>
Date: Wed, 18 Nov 2026 09:51:18 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 7/8] configs: Enable partition type GUID for
 QCS9100/QCM6490 boards
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Denis Mukhin <dmukhin@ford.com>, Kuan-Wei Chiu <visitorckw@gmail.com>,
 Alexey Charkov <alchark@flipper.net>, Carlo Caione <ccaione@baylibre.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
 Aristo Chen <aristo.chen@canonical.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 James Hilliard <james.hilliard1@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
 Fiona Klute <fiona.klute@gmx.de>
References: <20261115-type-v5-0-79e76209457b@oss.qualcomm.com>
 <20261115-type-v5-7-79e76209457b@oss.qualcomm.com>
 <20261116183804.GF554944@bill-the-cat>
Content-Language: en-US
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <20261116183804.GF554944@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: x6qSVGGjH1y-19QAx7LULLWZu8apquzs
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDAxNyBTYWx0ZWRfXzZMV9Yc4ZwIq
 22J7Lr7aOikgEx5POp41dhPF6l7o/Gj9KkkfXiY7fTF0TFQ1zOmgMFAlW20BTjadRpLq7a6Yfku
 ToX88hfjexTBZ9D9U6ICZHaSvlaCTZU=
X-Proofpoint-GUID: x6qSVGGjH1y-19QAx7LULLWZu8apquzs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDAxNyBTYWx0ZWRfX+OhcDoCeYBSC
 K3I0kxZTVI/46nys79SZ0i+4ZVpYk3FImp4TApzzIUwXnVCtjr6i5rKxQkYGFIMkxl5H5uYtZ4R
 vvNfrcOp0luQWLb1oXCPl9oLIjH27pWr/7IvnV46pe19QNw30YuxyantyVdcidYPnsbXbgwWWDy
 b7Ifc2D+bSttfg/zfLOrr6edUmwL/qkb9JTl6AvmkqobbhPty49vi48kE2Z2arxP+dQyG2oyhow
 nCKTjMdNBJrbZ3PgElbLlqelFk/pwNkGHNWIZ0iG3/QMfIZSLg7vEFBBCMkK8b+ahxRBXFSkBx1
 dUUmjtRtslwzpXjNuV8MKoJF5QU6Br/w1PhcWCRhcDIdnLkCOtHouYTJku+QA4ZovQubffsophv
 Crdl2NEGZU1AatdnJDjpYXiolzytPBScdULzgvyMpc0or3lV19gRZXvmaU6g/Nxhp5i5Hd3cjIU
 uZug1fuDVj4AhJ7cPkg==
X-Authority-Analysis: v=2.4 cv=NNVAaE6g c=1 sm=1 tr=0 ts=6afd27c9 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=cm27Pg_UAAAA:8 a=EUspDBNiAAAA:8 a=XA3tKsssftF7i_htJK8A:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_01,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 malwarescore=0 phishscore=0 adultscore=0
 suspectscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611180017
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Tom,

On 11/17/2026 12:08 AM, Tom Rini wrote:
> On Sun, Nov 15, 2026 at 11:56:09AM +0530, Balaji Selvanathan wrote:
>
>> Locate the SCSI environment partition on QCS9100 and QCM6490 by its
>> GPT type GUID instead of a per-device unique UUID. The type GUID is
>> that of the logfs partition.
>>
>> QCM6490 did not store its environment before, so also enable
>> ENV_IS_IN_SCSI there.
>>
>> Reviewed-by: Simon Glass <sjg@chromium.org>
>> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> We should be putting these defaults in to the Kconfig file instead.

In v6, I'll make ENV_SCSI_PART_USE_TYPE_GUID the default choice on 
ARCH_SNAPDRAGON and default ENV_SCSI_PART_TYPE_GUID to the logfs 
partition type GUID there. The QCS9100 and QCM6490 defconfigs then only 
need CONFIG_ENV_IS_IN_SCSI=y.

Regards,

Balaji

>
