Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F7EEC43458
	for <u-boot@archiver.kernel.org>; Mon, 13 Jul 2026 06:22:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71C5A849D2;
	Mon, 13 Jul 2026 08:22:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="kXvUcuYJ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cTMdJ+tx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10E8F84A48; Mon, 13 Jul 2026 08:13:31 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D24D3848EB
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 08:13:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66D39u9q039615
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 06:13:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=5dyJjJ9cPdEITdvmEC8XsNA7
 PC/REZaP030FyjHJF2o=; b=kXvUcuYJq39wTgfIWlVZzvjjzEEdRTlcpoWASFGH
 GoWvFyEgEXhS8LxwNGL43O6Tbrtfj9WLHM/ywDuuqrmrPcPMt+Uw2d5eckS4l4ZH
 GgLuFoFtz3XbKXwjwjRuL0Oad8/Og+I6f0+Bvu/VvqDKPsTFOkwDnK2gN8eeqzct
 SryKT0m98eyOdnesiH0zB4eaO+PcsNtjXXmTpwoRBiaAor2hSL2+fQr/2ILeOqX/
 Zhe2fSyE8YuXAQwoN6Otc+DUVhTKBA3sDZfi/YfWe/SkNi4e2QREpW7tZP6uMdVs
 /reFYtor7sKEu26qaZZVeY0ZFQKulkfYWAL/YF3qMUDpew==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fbf484gba-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 06:13:26 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2cc640dfde3so37884635ad.1
 for <u-boot@lists.denx.de>; Sun, 12 Jul 2026 23:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783923206; x=1784528006; darn=lists.denx.de; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5dyJjJ9cPdEITdvmEC8XsNA7PC/REZaP030FyjHJF2o=;
 b=cTMdJ+txvKM+0h74t6+tVidNTib2nwmBFsfCM2Po/xmk2IcIB5zd4+JDSCHx+BZQPE
 KChZgLZnYwfZ8g8GeDzH9GMsZVCvVCrVcDGllWzIr5p7vSArA2cSpfyOnSRH/NQR9KDC
 s7ziq+Eadc0tsH0LoViIYC/Bo/ahtK/6EYProGPQjF6F6MqaEvX3xDP2iuZt1U3ikJ3E
 CdYqMOoY8X/DodYbIucSegK8Dut4WqScKriyPUj7jlWuQ1Erpbiy9NRpEF1usD3/f5qC
 jvhWye5ZYDJl+pQNPaiiORGKzl0/Ap/g1iRQ5ktuZAFRj0ZpgmgBk4ZyqFS7VGNcgxUN
 PxRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783923206; x=1784528006;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5dyJjJ9cPdEITdvmEC8XsNA7PC/REZaP030FyjHJF2o=;
 b=pqjJwY30iolJxuI1R6yN4sma1M/r9gUB/rpJn1grZRyfHlVYohs6hjeeyDySU5ZCZ6
 yc/Iayluev1Tdc7e6xV4zwjNnAXvQ3v/u1Q6/hzuwVvgOdtGwZSeld7kzPdYj3i1xBrs
 CN7SiTuFZ3dwkBUqghcbrZ+fhtYMD3Z3l0AQv6odQHRPvV/XTRI0BU6jX/f1Ts86oIwr
 ev0MT4udIpI2xWTO1rSY1ax/EVXE2JaURDIPslogWV4BqtFR1jHJzAKZcvj0aa5mnj2c
 FBnBlF2VUXktsxPefSG38TK4BBdUPz3yUGTfQCU9HvUuehXuPzDPPMOlR27hOviUYUZh
 hVdw==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro2Hs3U3M0aZoN2kr1LEMHfYi1Brg9NmYrY14v32//AJCiaMmkbY+GsOI+L+EmN2I8yQffLXo8=@lists.denx.de
X-Gm-Message-State: AOJu0Yw4sVgofVetWjmgWZC0jGqXT5TVdoQDtPkXuJ3Up1CNKduOhT8A
 9ATWrmxb7LO6T2qVeW/Fvxa8xGKh5I72U4A1vWlJjmftC1X0fvQiS1lKqB06NFQJo3bLoo83vfK
 DbaUQYYFAkgA1zeyUlzfk7upxopJvCAKGO79CQpc8di4oQrdXmv+0qrGx
X-Gm-Gg: AfdE7ckgKzCrLvG0juh5GC79bnImp9CiyWQoz+XgbyVLYCSZDZx0khnnvRyqGk6VoH2
 tpnl6HcUuYT6x22WxM54YZfYuWpP2JvCClgWqMXyRrZvKz1G7UItePZgxOZlyr+g8Kz+xsvkang
 HC6AZK4ZDKC+LNb89mtPXu6CJfJlaqJAJqAtoqNMuiufmiHx9dCZSvZzfIEdBYjpM9wvrASYX0o
 Xc9dza/ZDR+Q+q9n5Ere+dCUoxQtqB6HUXDqt9Aio5LzbF/BJQZZZtY3gLNLos1zc629rkfcO4z
 bw57pZuZ/WJq21uVNyfueoC0W3PoOi4GhV0Sc5+2u85bCfIUZiJ9X7IJ7SRznFyCc1Oc0x4978e
 eRAmylyOAFPBg3+Gh6zqI06IT7QJjCaC2SufVqb+Pc2YGfs9Jn3sKMcHjBkLxw40zIWh83CzNjI
 S8N6uxzl/jAEjMqZtBhbrc86vIQJ9OAmPHPTw7Fycl
X-Received: by 2002:a17:903:1aeb:b0:2c9:97a8:aff5 with SMTP id
 d9443c01a7336-2ce9f4d41acmr86599545ad.46.1783923206208; 
 Sun, 12 Jul 2026 23:13:26 -0700 (PDT)
X-Received: by 2002:a17:903:1aeb:b0:2c9:97a8:aff5 with SMTP id
 d9443c01a7336-2ce9f4d41acmr86599185ad.46.1783923205780; 
 Sun, 12 Jul 2026 23:13:25 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659d8da9sm113196424c88.14.2026.07.12.23.13.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Jul 2026 23:13:25 -0700 (PDT)
Date: Mon, 13 Jul 2026 11:43:10 +0530
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: Casey Connolly <casey.connolly@linaro.org>
Cc: rayagonda.kokatanur@broadcom.com, trini@konsulko.com,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, peng.fan@nxp.com,
 jh80.chung@samsung.com, lukma@denx.de, tien.fong.chee@altera.com,
 anshuld@ti.com, alif.zakuan.yuslaimi@altera.com,
 tingting.meng@altera.com, alice.guo@nxp.com,
 marek.vasut+renesas@mailbox.org, quentin.schulz@cherry.de,
 ilias.apalodimas@linaro.org, sjg@chromium.org, andre.przywara@arm.com,
 afd@ti.com, h-salunke@ti.com, alchark@gmail.com,
 mkorpershoek@kernel.org, dinesh.maniyam@altera.com,
 luca.weiss@fairphone.com, balaji.selvanathan@oss.qualcomm.com,
 danila@jiaxyga.com, aswin.murugan@oss.qualcomm.com,
 ycliang@andestech.com, n-francis@ti.com, mateuslima.ti@gmail.com,
 jamie.gibbons@microchip.com, david.wronek@mainlining.org,
 james.hilliard1@gmail.com, philip.molloy@analog.com, ravi@prevas.dk,
 sughosh.ganu@arm.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: Re: [PATCH v6 07/11] mach-snapdragon: Add initial support for
 IPQ5210 SPL
Message-ID: <alSB9vsCN2w9k25X@hu-varada-blr.qualcomm.com>
References: <20260623064804.3988799-1-varadarajan.narayanan@oss.qualcomm.com>
 <20260623064804.3988799-8-varadarajan.narayanan@oss.qualcomm.com>
 <474cdd0f-9c50-4c70-a53b-94c62d227943@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <474cdd0f-9c50-4c70-a53b-94c62d227943@linaro.org>
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDA2MSBTYWx0ZWRfXwgsVkZsTaGc1
 N4xtAkYOKRWxZ56TsoNiyfIYEFWPLlg37ooAoCoCEwsa2pWm61+ZyC+O6aiG+4g14xCVXCb7XXd
 w1uYrYjI2+Zo1ubpuOzErx7/b7a/Kug=
X-Authority-Analysis: v=2.4 cv=OsJ/DS/t c=1 sm=1 tr=0 ts=6a548206 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=pwwa8DMPWyUhrMe26YQA:9 a=CjuIK1q_8ugA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDA2MSBTYWx0ZWRfX47MimnqsWV8z
 a8qnraIX5sw5YT1yxgvilXFW9assFniwgqFcY2eJaIhYplYwlDoUUCv6XkMfpVgptnttse35J4w
 2ePgOmbcaJ+6IcEG3Swpd3plSaa4HOS+jK3aNEeffargfOeHDLnxtI8Aat6huvdXs8zErq96LXn
 bV1kKGsYN+jYxVpu+z/+93sd85fVC2e8sQk4LhatHtAjppDRECgB5eaFnA9jYcfHblkiUwbZBdJ
 kvvFlNqBwkczL6nMvejc9yoYfGXyYTb+4RKWXywuE9s5D18g9UGWt1kyIxdfHeLpZNEUdZStBEK
 bfQDSYK95aX8FT2MziIMd5mrbGdyBGdmAE5IQhFF2UWxD1la8rne6/EsatYXwXwapNKIPCBG7Fq
 IsyugiUriCXdLNqiaPNCiTf7jRRInL3lmlHj6wDZ//Ae3ztGwTPRTJitw5jYqrgPrJo92Zarbrd
 0ynfNqsIKzpur2ualMg==
X-Proofpoint-GUID: ZkFkTjJLpjHynAAVGNZA8y8sWRPTnFpv
X-Proofpoint-ORIG-GUID: ZkFkTjJLpjHynAAVGNZA8y8sWRPTnFpv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_01,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 clxscore=1015 impostorscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130061
X-Mailman-Approved-At: Mon, 13 Jul 2026 08:21:59 +0200
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

[ . . . ]
> > +#define QCOM_SPL_IS_DLOAD_BIT_SET	((readl(QCOM_SPL_TCSR_REG_ADDR) & \
> > +					QCOM_SPL_DLOAD_MASK) >> \
> > +					QCOM_SPL_DLOAD_SHFT)
>
> Unused?

It is used in spl_board_prepare_for_boot() in the next patch. Will move it.

> > +#define QCOM_SPL_FIT_IMG_PARTITION	"0:BOOTLDR"
> > +
> > +#define MAGIC_KEY			"QCLIB_CB"
> > +#define MAX_ENTRIES			0xF
> > +#define IF_TABLE_VERSION		0x1
> > +#define QCCONFIG			"qc_config"
> > +#define QCSDI				"qcsdi"
>
> Please document this API (as in, under doc/) maybe show examples of what
> this magic "interface_table" might contain, etc.
>
> I'm quite wary around this, we want to keep working to reduce the board
> specific hacks and code, providing more info about what this does, how it
> works, it's all going to help justify these patches.
>
> It would also help to split this out, have a patch with the FIT parsing
> stuff, then add the qclib API, then add the board code.

Ok.

Thanks
Varada

[ . . . ]
