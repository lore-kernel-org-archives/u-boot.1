Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E1F0C55175
	for <u-boot@archiver.kernel.org>; Mon,  3 Aug 2026 06:43:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D27BC606F3;
	Mon,  3 Aug 2026 06:43:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EcwitUasdZM5; Mon,  3 Aug 2026 06:43:18 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3A3A8606E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785739398;
	bh=Qt6Mcphm3DNJFcH4Xrg2tbAj+RBZkU9E4ZEVpuQDv/w=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=LK5QLjmpxuVIzi+sAE31SI8Fbi3vkfgOxHKl3S1RYwUfhdFAS7hKF6K2LP5jj5+Bk
	 M11CC6U1zvHuAvPTCetyCTRuPf35M/Xq8xQBORfjmHQBHyvWfxMalgkbHJJ/bL6JXf
	 rxudwvHwnO7jd/LG8QpMDGXskVoE+cq/25mBQ4Vz4fnTmIu4MuD6wOPAI0RQJtzE5d
	 QpOKzdU98ieyPA2itmFXNHtaiSGKpa4UQhA0jo3Xw4k5kf8Q5s4KStVR3DaEB7N4CO
	 p+mOKY9O4nQTshqvWDRw/XndFi5nPjRpZL2JnKJlgR7QivZnAR3Xn7+vGyWeFSr45l
	 jEBDuc2OBnedA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3A3A8606E0;
	Mon,  3 Aug 2026 06:43:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 3BF8226C
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 06:43:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 213A580BB4
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 06:43:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DQ_UGS5kM0bv for <u-boot@lists.u-boot-project.org>;
 Mon,  3 Aug 2026 06:43:14 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=balaji.selvanathan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org C1F9380B91
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C1F9380B91
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C1F9380B91
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 06:43:13 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89A8C846E2; Mon,  3 Aug 2026 08:43:11 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C947F80087
 for <u-boot@lists.denx.de>; Mon,  3 Aug 2026 08:43:07 +0200 (CEST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6736DbSd3882607
 for <u-boot@lists.denx.de>; Mon, 3 Aug 2026 06:43:06 GMT
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ftnhkg3ce-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 03 Aug 2026 06:43:05 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cb7d6ba548eso3945110a12.1
 for <u-boot@lists.denx.de>; Sun, 02 Aug 2026 23:43:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785739385; x=1786344185;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Qt6Mcphm3DNJFcH4Xrg2tbAj+RBZkU9E4ZEVpuQDv/w=;
 b=kLW8IAYmnzVTQN/FTI86bawUZe1Wg96MgwLvqnx7wMXUrZEp06HdydiSkglTbK5lSg
 v7WNcZITrzKHT3cLuWcVdIrjKdtoWmeXIeQOM2yVssh+lKo121z4hAJJWQ6OmkJ1/RiK
 Gg00YJ5B2CdTOL5cYI9TDT1ON2mM+S0rhaWZFoSY0gwcva/vEw9XRd2q84eM15WvgjMx
 +1AYcDIV2KTipX6DIf/l1jNDVA4FdjPax8n8x9J+5zt214fzGkdfNknWkFIW93M2oJQC
 EHZpubZbqXyQhu68ZndP/hBt1umP+ffTOlaBxVhMMMDkBAUnAH6LUr23waa6ukqF0f9D
 ltkw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoNwVk2nb7QciwgmQeTq8X5Nq7qbVWE9CXe0+OziuGExN+e2eWe1NxpaQg7Wh4LkWM5scJfQ7g=@lists.denx.de
X-Gm-Message-State: AOJu0YzeP84slD7Bgu9xvBCd7wIRuzN86nLVLUxnA3qUgvw1eyt9IdKe
 hQ5MYf9rzi6Qm6mYqMjkQtEzUHuuNuahC8/DPLerpbUPsh5tfBGFPa6/JM9XUdfR5pjoALq+4Qg
 zvoKnu9FaM4toeKQlbXYWMzN136LKK8IwFcDPxwroPOqY+52GLhGjFj7b
X-Gm-Gg: AR+sD12MS6uNhlkSpb5iMawaEgDEMJw/Cnq6tYexeuq5kovQmJoMUwBwQipI7SjGTeb
 1E0K7qZEuw17LbJMDNzoA290JkfqiTBUU1+nufE828szJYMCdb31ZNPwg8ketgxWFMLsC1CDDOa
 BxZY8HIspGK29zaJWDyGz2Wy7WJ13g6oYDTUGIa2/5hHQyQxbDEZlDciuMA5922rSTtyHIuAo7Z
 I5TrtUdKgb3ToyKVG3lnis/gpdJngYuf/P9NWErFYRO4Vx7upQhiCRY902jmXwqiuXJ/rCcz5dR
 pyYvPNpno6yQb2r4Mek0AopgpcXOn67ZhiNVvWlW3TTewpfXP9hrMc5OCoUiVTL/v3Pch7lcIIp
 sEZ7jgpy+7pTa+cDwZapFv9MuB4xFWjMngBvoFQ==
X-Received: by 2002:a05:6a20:3d82:b0:3c3:704d:57c4 with SMTP id
 adf61e73a8af0-3c92a5a13f4mr8237353637.12.1785739384435; 
 Sun, 02 Aug 2026 23:43:04 -0700 (PDT)
X-Received: by 2002:a05:6a20:3d82:b0:3c3:704d:57c4 with SMTP id
 adf61e73a8af0-3c92a5a13f4mr8237304637.12.1785739383717; 
 Sun, 02 Aug 2026 23:43:03 -0700 (PDT)
Received: from [10.151.41.150] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3153dd4e5c7sm38678751eec.5.2026.08.02.23.42.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 02 Aug 2026 23:43:03 -0700 (PDT)
Message-ID: <0c80c273-2d06-4917-bc23-db6fb0b5c094@oss.qualcomm.com>
Date: Mon, 3 Aug 2026 12:12:54 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] qcom: capsule: add FIT capsule support with
 multi-partition
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Alexey Minnekhanov <alexeymin@minlexx.ru>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
References: <20260522-capsule-v1-0-ff0ac9978d48@oss.qualcomm.com>
 <CAC_iWj+yLvqqunA_j6WX_0v_DSkf6xwXPSL+kysrUM7G3isSKw@mail.gmail.com>
 <8de79ca7-e826-4a61-b380-2bdf01c39871@oss.qualcomm.com>
 <4b344c4d-ef0e-4595-a6ff-10629cfaaa82@linaro.org>
 <936f99e6-bd6f-4168-bfea-8a8c777b4c52@oss.qualcomm.com>
 <6748951d-d720-46bd-82bd-19c4d97a6f20@linaro.org>
 <73fa32f5-0d10-4f95-a02f-2cac91d072d6@oss.qualcomm.com>
 <013d5bbc-983e-4386-b236-8c63f4406fc0@linaro.org>
 <aaeb155a-6195-4574-b4b4-fa7d6a88a00f@oss.qualcomm.com>
 <20feda09-ab10-43e4-831b-6a8647f5c62e@linaro.org>
 <37b8a403-b299-4e0d-98fe-b4b3ae660b13@oss.qualcomm.com>
 <CAC_iWjLJRk34i4S04L+3bKMVji-JzmieBKrEmYUZmEuc7Jd-4w@mail.gmail.com>
 <bea27826-0028-4de7-a4c7-94ba3eb2f1b4@oss.qualcomm.com>
 <e1ca0b58-d38f-46dc-a9e4-e0695e69a950@oss.qualcomm.com>
 <49cc74de-5d73-44ad-86e0-6acd0f61ff1e@linaro.org>
 <eb42084b-b4ac-4b6c-9caf-256d013daa25@oss.qualcomm.com>
 <CAC_iWjJVzs=s2NbVtUt1QKbdKzWs93ioLe5+7CZoKcFLs2wOwQ@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAC_iWjJVzs=s2NbVtUt1QKbdKzWs93ioLe5+7CZoKcFLs2wOwQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: wDAso-l1l38E7Ka8I_3JLu3ZkMAfqzX6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDA1NyBTYWx0ZWRfX08UhLg0FnFk8
 Xz8JfjOw1285CCJW8bKEAjE5mow15EDyGMxmbBS5+WeKhqMnVjYyz/p+nVzVZAXFnNtlpC3Av2y
 6G0qeviWk9dqnodJLQdOAN4YFZPZurciuCnLA1Uie+9yH9hDwKlTfaYZUN5qAFRxzXFLGXXSdug
 SoyZAbIWuQ2zPFXo13IeC9NYbEQG5pOeVHc9+5T+f19ulbnVxul81czdScHnygQaeNXaCrjIJam
 5ZoRlXl8N/0AWx56wkNunNsAHizHJzKT/fBTBkyLESL1BF336BEdVCpg7Ny7kkP3pMIF+8eJRhV
 7bokEbu6NQnLV2dDfKbz3zaOib5mZrs2BHwC60xl5H1/7Zl8yks32bXgNP7wM3tiQ8L7FQL12x+
 G6LuVFx4ic2ndUWHd8dsXli47KDmJlWskwcpfETOQ9iWpdNmM+65wNdpog/LIGODFAgq0VMg7J1
 xC5uI9j00ycHSV5EnfA==
X-Proofpoint-ORIG-GUID: wDAso-l1l38E7Ka8I_3JLu3ZkMAfqzX6
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDA1NyBTYWx0ZWRfX7+3Ud7FaYfP+
 spqi99dhHAUXcw2IaCjMiHtXMC+RReQypX/CrW8ykeDRSoBKCET8vIeUpwmPEBjMKSvmLZ1ZhPt
 pCJk+SsiN+F+evXc7AM2F1ZjiEuCdmk=
X-Authority-Analysis: v=2.4 cv=UIjt2ify c=1 sm=1 tr=0 ts=6a703879 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=dw0t6H4-AAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=EWWIny1Tf11uDKhFqaoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22 a=wVJa4CU9-Z26yuRAZDil:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_06,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 bulkscore=0 adultscore=0 spamscore=0 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608030057
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Qt6Mcphm3DNJFcH4Xrg2tbAj+RBZkU9E4ZEVpuQDv/w=; b=FqCaNFxjrOu79W0I
 1If9VG7LH6G5exTD3Sxa3xDv/8Cr2H8oz2Bn2nQ88ZlMm8qhaIzT5ZxRTiCND9Aa
 pr8x4C7Ksl4aEcDTrThJlcFf4Lw34bXOYby82v0kwGtYmqnt2bEdgi/22SmzQrNx
 bYoTT5xc+9M/dtbRigP+iSB3mQhbQ0pZmJUE9gG7dUuWbwF0oCdcdGixr/hnCiCS
 Fnw47tWpYouPgNHGEEM9AKwGBQ0hp6Cz6okvEtP+gvQfmRHaN4egke7xAdJ+DRwM
 2ZBPPQqG6r55w5O6w0veXsyHzZsLrk30YMslZA9jnXnf1kXgx4r4z5ZODaHgHuVa
 EHlaNA==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785739385; x=1786344185; darn=lists.denx.de; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Qt6Mcphm3DNJFcH4Xrg2tbAj+RBZkU9E4ZEVpuQDv/w=;
 b=aSNI06ed3A6UkzZzJub1TdYcQ6mg5M1JeCiq8oF4FBCCui64CxvD4t9mwx4rR/5+9h
 IopVbWsyKUubK6asaTeLjXp100g34EtIWynADHdkzWuD5iyrvNBAYCVQmqyOld0bNf/t
 sGo4P08lv0qiw2qzuEx/SQwGze3o2N2oeUU0KfnXCvlRx/90jtCkY9R6kInSerCNh1m4
 cqS8qVrOcOXmTiLvP4rr3CN0/npoC7QKxy5TC9DqY2+QwolC8fESEvUTwK0aJ2fa5mtM
 wYDtpxNaGwVbs/L8Egw687EOWJcoWDLsXjM34VjoO7gjHmami2RQcXUX9BEBuwIu83Dw
 fqSA==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org; spf=fail
 smtp.mailfrom=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=FqCaNFxj; 
 dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=aSNI06ed
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="FqCaNFxj";
 dkim=pass (2048-bit key;
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.b="aSNI06ed"; 
 dkim-atps=neutral
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
From: Balaji Selvanathan via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Ilias,

On 7/31/2026 3:06 PM, Ilias Apalodimas wrote:
> Hi Casey,
>
> On Wed, 29 Jul 2026 at 13:45, Balaji Selvanathan
> <balaji.selvanathan@oss.qualcomm.com> wrote:
>> Hi Casey, Ilias,
>>
>> On 7/28/2026 5:51 PM, Casey Connolly wrote:
>>> On 28/07/2026 13:44, Balaji Selvanathan wrote:
>>>> Hi Ilias,
>>>>
>>>> On 7/27/2026 9:57 PM, Balaji Selvanathan wrote:
>>>>> Hi Ilias,
>>>>>
>>>>> On 7/27/2026 6:11 PM, Ilias Apalodimas wrote:
>>>>>> On Mon, 27 Jul 2026 at 13:00, Balaji Selvanathan
>>>>>> <balaji.selvanathan@oss.qualcomm.com> wrote:
>>>>>>> Hi Ilias, Casey,
>>>>>>>
>>>>>>> On 7/24/2026 12:37 AM, Casey Connolly wrote:
>>>>>>>> On 23/07/2026 18:43, Balaji Selvanathan wrote:
>>>>>>>>> Hi Casey,
>>>>>>>>>
>>>>>>>>> On 7/22/2026 8:19 PM, Casey Connolly wrote:
>>>>>>>>>> Hi Balaji,
>>>>>>>>>>
>>>>>>>>>> On 22/07/2026 11:23, Balaji Selvanathan wrote:
>>>>>>>>>>> Hi Casey,
>>>>>>>>>>>
>>>>>>>>>>> On 7/18/2026 4:19 PM, Casey Connolly wrote:
>>>>>>>>>>>> On 7/17/26 18:16, Balaji Selvanathan wrote:
>>>>>>>>>>>>> Hi Casey, Ilias, Simon,
>>>>>>>>>>>>>
>>>>>>>>>>>>> On 5/26/2026 7:05 PM, Casey Connolly wrote:
>>>>>>>>>>>>>> Hi Balaji,
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> On 25/05/2026 13:24, Balaji Selvanathan wrote:
>>>>>>>>>>>>>>> Hi Ilias,
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> On 5/23/2026 6:23 PM, Ilias Apalodimas wrote:
>>>>>>>>>>>>>>>> [...]
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>> To support multi-image RAW capsules, we would need to:
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>> 1. Enhance mkeficapsule to create multi-image capsules?
>>>>>>>>>>>>>>>>>> There's an equivalent tool in EDKII that can produce a
>>>>>>>>>>>>>>>>>> capsule
>>>>>>>>>>>>>>>>>> with
>>>>>>>>>>>>>>>>>> multiple payloads. There were also patches posted for
>>>>>>>>>>>>>>>>>> mkeficapsule,
>>>>>>>>>>>>>>>>>> but need some minor tweaks to merge them
>>>>>>>>>>>>>>>>> Can you please point me those patches? I did a search
>>>>>>>>>>>>>>>>> myself, but
>>>>>>>>>>>>>>>>> couldnt find those patches.
>>>>>>>>>>>>>>>> https://lore.kernel.org/u-boot/20240419065542.1160527-1-
>>>>>>>>>>>>>>>> sughosh.ganu@linaro.org/
>>>>>>>>>>>>>>> This patch you mentioned here can create capsule with only one
>>>>>>>>>>>>>>> payload;
>>>>>>>>>>>>>>> means for multiple binaries we need to create multiple
>>>>>>>>>>>>>>> capsules. I
>>>>>>>>>>>>>>> have
>>>>>>>>>>>>>>> also asked the person who made this series to respin, but
>>>>>>>>>>>>>>> havent
>>>>>>>>>>>>>>> heard
>>>>>>>>>>>>>>> back from him.
>>>>>>>>>>>>>>       From a quick look it seems like it would be fairly
>>>>>>>>>>>>>> straightforward to
>>>>>>>>>>>>>> extend mkeficapsule to support multiple images, the capsule
>>>>>>>>>>>>>> header
>>>>>>>>>>>>>> has
>>>>>>>>>>>>>> an item_offset_list[] array with offsets to each image, today
>>>>>>>>>>>>>> we just
>>>>>>>>>>>>>> write 1 but it shouldn't be too much of a challenge to put a
>>>>>>>>>>>>>> loop in
>>>>>>>>>>>>>> here and extend the argument parsing.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Given that we a) already use raw capsules and b) they are
>>>>>>>>>>>>>> part of the
>>>>>>>>>>>>>> EFI spec, I'm gonna try and save us all some time and just
>>>>>>>>>>>>>> put my
>>>>>>>>>>>>>> foot
>>>>>>>>>>>>>> down here. A single raw EFI capsule file can already support
>>>>>>>>>>>>>> updating
>>>>>>>>>>>>>> multiple images, U-Boot already has all of the machinery for
>>>>>>>>>>>>>> it with
>>>>>>>>>>>>>> the
>>>>>>>>>>>>>> exception of mkeficapsule but I expect that's something you can
>>>>>>>>>>>>>> tackle.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> The upside to this is that you will be able to build capsule
>>>>>>>>>>>>>> files
>>>>>>>>>>>>>> for
>>>>>>>>>>>>>> updating xbl/tz/hyp/aop that can be consumed by U-Boot and edk2!
>>>>>>>>>>>>> Thanks for the detailed feedback.
>>>>>>>>>>>>>
>>>>>>>>>>>>> We agree — we'll drop the FIT capsule approach and move
>>>>>>>>>>>>> forward with
>>>>>>>>>>>>> RAW capsules.
>>>>>>>>>>>>>
>>>>>>>>>>>>> Here's the plan:
>>>>>>>>>>>>>
>>>>>>>>>>>>> 1. mkeficapsule tool: Extend Sughosh's multi-payload capsule
>>>>>>>>>>>>> series
>>>>>>>>>>>>> [1] to support generating multi-image capsules from a config
>>>>>>>>>>>>>         file, so we can build a single capsule covering all the
>>>>>>>>>>>>> partitions
>>>>>>>>>>>>> we need to update.
>>>>>>>>>>>>> 2. U-Boot (Qualcomm): Today the Qualcomm capsule update code only
>>>>>>>>>>>>> supports a single firmware image (U-Boot itself) via a
>>>>>>>>>>>>>         single-entry fw_images[] array. We'll move to a SoC-
>>>>>>>>>>>>> specific,
>>>>>>>>>>>>> multi- entry fw_images[] array (defined per board, e.g.
>>>>>>>>>>>>>         board/qualcomm/<board>/fw_images.c), so a single capsule
>>>>>>>>>>>>> update
>>>>>>>>>>>>> flow can cover multiple firmware components — each with its own
>>>>>>>>>>>>>         ESRT entry and FMP image_index — instead of just U-Boot.
>>>>>>>>>>>> No need for this, just build fw_images[] on the fly derived
>>>>>>>>>>>> from the
>>>>>>>>>>>> partition table on the board, with an entry for each partition
>>>>>>>>>>>> that
>>>>>>>>>>>> can be updated. You just need to add a map from partition label to
>>>>>>>>>>>> fw_name string, starting with the xbl/uefi/boot partitions we
>>>>>>>>>>>> already
>>>>>>>>>>>> handle.
>>>>>>>>>>>>
>>>>>>>>>>>> The entire point of having logic here was to avoid per-board
>>>>>>>>>>>> stuff, if
>>>>>>>>>>>> you're thinking "ah I'll do this per-board" you should immediately
>>>>>>>>>>>> wonder "but can we do it dynamically instead?".
>>>>>>>>>>>>
>>>>>>>>>>>> Thanks,
>>>>>>>>>>>> Casey
>>>>>>>>>>> Hi Casey, Ilias,
>>>>>>>>>>>
>>>>>>>>>>>        Thanks for the pointer — agreed, building fw_images[]
>>>>>>>>>>> dynamically
>>>>>>>>>>> from
>>>>>>>>>>> the partition table is the right call, avoids per-target code
>>>>>>>>>>> entirely.
>>>>>>>>>> Can I talk to a human instead of an LLM please?
>>>>>>>>>>
>>>>>>>>>>>        Plan:
>>>>>>>>>>>        - Keep a fixed table mapping "partition label → fw_name + a
>>>>>>>>>>> fixed
>>>>>>>>>>> image index", this mapping going to be a superset list for all
>>>>>>>>>>> the Boot
>>>>>>>>>>> FW images supported in different Qualcomm targets.
>>>>>>>>>> This reads vaguely like a rephrasing of what I proposed, not
>>>>>>>>>> clear if
>>>>>>>>>> you really understand it though.
>>>>>>>>>>
>>>>>>>>>>>           Sample table:
>>>>>>>>>>>
>>>>>>>>>>> ┌──────────────────┬───────────────┬───────┬────────────────────────┐
>>>>>>>>>>>          │ part_base_name         │ fw_name                │ index
>>>>>>>>>>> │ guid
>>>>>>>>>>> (fixed)                                │
>>>>>>>>>>> ├──────────────────|───────────────|───────-|
>>>>>>>>>>> ───────────────────────- |
>>>>>>>>>>>          │ xbl                                  │ QCOM_XBL │   1
>>>>>>>>>>> │  QCOM_XBL_GUID                  │
>>>>>>>>>>>          │ ubootspl                       │ QCOM_UBOOTSPL│   2   │
>>>>>>>>>>> QCOM_UBOOTSPL_GUID     │
>>>>>>>>>>>          │ uboot                            │ QCOM_UBOOT      │   3
>>>>>>>>>>> │  QCOM_UBOOT_GUID            │
>>>>>>>>>>> └──────────────────┴───────────────┴───────┴────────────────────────┘
>>>>>>>>>>>
>>>>>>>>>>>          Target-1 supports xbl and Target-2 supports ubootspl.
>>>>>>>>>>>
>>>>>>>>>>>        - At boot, scan the partition table against this table. Only
>>>>>>>>>>> partitions actually present on that target get an fw_images[]/
>>>>>>>>>>> ESRT entry
>>>>>>>>>>> — nothing hardcoded per target.
>>>>>>>>>>>
>>>>>>>>>>>        - The image index for each partition type stays fixed and
>>>>>>>>>>> published,
>>>>>>>>>>> so whoever builds a capsule (mkeficapsule) always knows which
>>>>>>>>>>> index to
>>>>>>>>>>> target, regardless of what's discovered at runtime.
>>>>>>>>>>>
>>>>>>>>>>>        One wrinkle I want to flag: today's SetImage() path assumes
>>>>>>>>>>> dfu_alt_num = image_index - 1, i.e. it picks the Nth entry in
>>>>>>>>>>> dfu_alt_info purely by
>>>>>>>>>>>        position. If a partition from the middle of the table is
>>>>>>>>>>> missing on a
>>>>>>>>>>> given target, everything after it would shift by one position
>>>>>>>>>>> and the
>>>>>>>>>>> wrong
>>>>>>>>>>>        partition would get flashed — silently. Since I'd rather
>>>>>>>>>>> not touch
>>>>>>>>>>> that logic in common code, my plan is to keep every fixed index's
>>>>>>>>>>> position in
>>>>>>>>>>>        dfu_alt_info stable by inserting a placeholder (U-Boot's
>>>>>>>>>>> existing
>>>>>>>>>>> virt
>>>>>>>>>>> DFU backend, which just no-ops) wherever a partition is absent,
>>>>>>>>>>> so the
>>>>>>>>>>> position
>>>>>>>>>>>        math stays correct for everything after it. The missing
>>>>>>>>>>> partition
>>>>>>>>>>> itself simply won't have an fw_images[]/ESRT entry, so a capsule
>>>>>>>>>>> can't
>>>>>>>>>>> target it
>>>>>>>>>>>        anyway — it'd get rejected before reaching DFU.
>>>>>>>>>> Skipping past this noise... Ilias probably knows better here but
>>>>>>>>>> yes the
>>>>>>>>>> way dfu_alt_num is derived from ImageIndex does impose a
>>>>>>>>>> limitation here
>>>>>>>>>> currently where we need to ensure the indexes always start at 1 and
>>>>>>>>>> count up.
>>>>>>>>>>
>>>>>>>>>> That being said, it's already quite complicated to have to
>>>>>>>>>> maintain a
>>>>>>>>>> database of the indices for each board, and even more complicated
>>>>>>>>>> when
>>>>>>>>>> we have boards that may or may not be using U-Boot SPL (for
>>>>>>>>>> example).
>>>>>>>>>>
>>>>>>>>>> Having fixed ImageIndex values for each image would then seem to
>>>>>>>>>> make
>>>>>>>>>> the most sense as we could just use fwu to set dfu_alt_num (or
>>>>>>>>>> another
>>>>>>>>>> platform specific mechanism), however the EFI spec is clear that the
>>>>>>>>>> ImageIndex of EFI_FIRMWARE_IMAGE_DESCRIPTOR must be <=
>>>>>>>>>> DescriptorCount
>>>>>>>>>> as returned by fmp->GetImageInfo(), so we would need to also have
>>>>>>>>>> dummy
>>>>>>>>>> entries in the fw_images[] array so it doesn't really solve our
>>>>>>>>>> problem.
>>>>>>>>>>
>>>>>>>>>> https://uefi.org/specs/
>>>>>>>>>> UEFI/2.9_A/23_Firmware_Update_and_Reporting.html
>>>>>>>>>>
>>>>>>>>>> Currently, other than for setting dfu_alt_num, the only other place
>>>>>>>>>> where the image index needs to match is in efi_fmp_find() which was
>>>>>>>>>> added by [1] seemingly to prevent an incorrect image index in the
>>>>>>>>>> /capsule/ file causing dfu_alt_num to be set wrong resulting in the
>>>>>>>>>> wrong partition being flashed. In other words, we should be able
>>>>>>>>>> to find
>>>>>>>>>> a way to safely remove this check.
>>>>>>>>>>
>>>>>>>>>> But alas, it seems like we are stuck with fmp->SetImage() being
>>>>>>>>>> called
>>>>>>>>>> with the image index from the capsule file per the spec, and it
>>>>>>>>>> is the
>>>>>>>>>> only way to identify the target partition without doing other hacks.
>>>>>>>>>>
>>>>>>>>>> I'd like to get some feedback from Ilias on this, since adding dummy
>>>>>>>>>> entries really doesn't feel like an acceptable approach to me.
>>>>>>>>>> The only
>>>>>>>>>> alternatives I can think of also don't seem great... Either:
>>>>>>>>>>
>>>>>>>>>> 1. Sidestep the EFI spec by either caching data in the call to
>>>>>>>>>> GetImageInfo() or by assuming that the void *image pointer
>>>>>>>>>> immediately
>>>>>>>>>> follows the efi_firmware_management_capsule_image_header (this is
>>>>>>>>>> true
>>>>>>>>>> for us today but would be a fragile assumption to make).
>>>>>>>>>> 2. Use the internal image index (looked up via the image name and
>>>>>>>>>> type_id) as the index when calling fmp->set_image() - going
>>>>>>>>>> against the
>>>>>>>>>> spec.
>>>>>>>>>>
>>>>>>>>>> It's not really clear to me what purpose the ImageIndex property
>>>>>>>>>> serves,
>>>>>>>>>> since GetImageInfo() is meant to match on the ImageTypeId anyway, I
>>>>>>>>>> assume it relates somehow to the fact that there can be multiple
>>>>>>>>>> instances of the firmware management protocol, but in U-Boot we only
>>>>>>>>>> have one.
>>>>>>>>>>
>>>>>>>>>> I think the other way forward would be to use the only included
>>>>>>>>>> escape
>>>>>>>>>> hatch in the UEFI spec with a custom GUID in the capsule header
>>>>>>>>>> capsule_guid field which would let us have a custom mechanism
>>>>>>>>>> which in
>>>>>>>>>> our case could just be a soft-fork of the existing spec with minor
>>>>>>>>>> changes so we can just remove/ignore the UpdateImageIndex field
>>>>>>>>>> in the
>>>>>>>>>> capsule. Maybe this would be the most correct solution?
>>>>>>>>>>
>>>>>>>>>> Hopefully Ilias has some time to chime in on this, I'm sure we
>>>>>>>>>> can find
>>>>>>>>>> a way to go about this that doesn't involve exposing dummy data.
>>>>>>>>>>
>>>>>>>>>> Thanks,
>>>>>>>>>> // Casey
>>>>>>>>> I feel we are complicating it by trying to go for dynamic fw_images.
>>>>>>>>>
>>>>>>>>> Rather than introducing a solution that diverges from the UEFI
>>>>>>>>> specification, shall we use a board-specific static fw_images[]
>>>>>>>> Well, the solution I proposed at the end very much doesn't diverge
>>>>>>>> from
>>>>>>>> the spec, that was kinda the point.
>>>>>>>>
>>>>>>>>> definition. This approach is simpler, remains spec-compliant, and
>>>>>>>>> other
>>>>>>>> Simpler for you to implement or simpler to maintain? I think that's
>>>>>>>> quite debatable...
>>>>>>>>
>>>>>>>>> vendors (like NXP, TI) have also implemented static fw_images (in
>>>>>>>>> board/
>>>>>>>>> nxp, board/ti).
>>>>>>>> The decision not to do this for mach-snapdragon was quite intentional
>>>>>>>> and was the motivator behind dynamic generation of image GUIDs:
>>>>>>>> https://lore.kernel.org/u-boot/20240830-b4-dynamic-uuid-
>>>>>>>> v8-0-79b31b199bee@linaro.org/
>>>>>>>>
>>>>>>>> The image index issue was always bound to come up, and it's absolutely
>>>>>>>> something we should be solving and not just sidestepping. We already
>>>>>>>> support dynamic fw_images[] anyway and it's already being used by some
>>>>>>>> devices, so we need to maintain the existing support regardless.
>>>>>>>>
>>>>>>>> As I understand it, Qualcomm also intend to support multiple boot
>>>>>>>> media
>>>>>>>> (UFS, eMMC, SPI flash) with a single U-Boot binary, so to some extent
>>>>>>>> this array must be dynamic. And since at boot time we have all the
>>>>>>>> info
>>>>>>>> we need to generate fw_images, keeping a static list per-board is at
>>>>>>>> best lazy and at worst will just make things even more complicated
>>>>>>>> when
>>>>>>>> we suddenly want to support configurations with/without OP-TEE and
>>>>>>>> with/without SPL.
>>>>>>>>
>>>>>>>> So unless I'm missing something here I think there's a strong case
>>>>>>>> here
>>>>>>>> to add support for ignoring the capsule provided image index, but
>>>>>>>> we'll
>>>>>>>> see what Ilias has to say when he's back from vacation.
>>>>>>> Okay Casey.
>>>>>>>
>>>>>>> Hi Ilias,
>>>>>>>
>>>>>>> Request your input on this.
>>>>>> So the problem you are trying to fix here, is that you have boards
>>>>>> with multiple configurations, that their image index might change, but
>>>>>> you want to update them with a single capsule right?
>>>>>>
>>>>>> If that's the case, we can have a board specific function that does
>>>>>> nothing by default, but on the qualcomm case, re-arranges the capsule
>>>>>> image indexes *after* the capsule authentication has passed. I think
>>>>>> this still violates the EFI spec, but I am ok with it.
>>>>>>
>>>>>> Cheers
>>>>>> /Ilias
>>>>> Hi Ilias,
>>>>>
>>>>>     Thanks for the input. Just to make sure we're on the same page:
>>>>>
>>>>>     Our understanding is that we'd add a board-specific hook (default
>>>>> no-op, so other vendors are unaffected) that runs after the capsule
>>>>> signature is verified but before dfu_alt_num is
>>>>>     derived from image_index. On Qualcomm boards, this hook would look
>>>>> at the partitions actually present at boot and remap the capsule's
>>>>> (fixed, published) image_index to whatever position that image
>>>>> actually occupies in dfu_alt_info on that specific target — rather
>>>>> than assuming a fixed 1:1 mapping between image_index and position.
>>>>>
>>>>>     To be clear on scope: we're not ignoring the image_index value
>>>>> itself — it's still read from the capsule and used as-is to look up
>>>>> which firmware component (xbl/uboot/etc.) is being
>>> no, the entire point is that the image index is bunk, why are you
>>> feeding these emails through an LLM?
>>>
>>>>>     targeted. What we're overriding is the spec's assumption that this
>>>>> index also encodes position, i.e. that dfu_alt_num = image_index - 1
>>>>> and that image_index stays within descriptor_count.
>>> the spec's assumption????? this has nothing to do with the spec
>>>>>     Since our FMP descriptor list is built dynamically per-board, a
>>>>> fixed global index can exceed the descriptor count on boards missing
>>>>> some partitions, so we remap it to the correct DFU
>>> no
>>>>>     position ourselves instead.
>>>>>
>>>>> Is that a correct read of what you had in mind?
>>> please use plain text formatting for emails.
>>>>> Regards,
>>>>>
>>>>> Balaji
>>>> If the above assumption is correct, then we will have following problems,
>>>>
>>>> During authentication, U-Boot performs anti-rollback checks.
>>>>
>>>> As part of this flow, the Image Index is converted to an Image GUID
>>>> using fw_images[].
>>>>
>>>> Since the capsule Image Index does not match the fw_images[] Image Index
>>>> at this stage, the anti-rollback logic may resolve the wrong GUID or
>>>> fail to find a matching entry in fw_images[].
>>> I'd like to understand from Ilias why we need to authenticate the
>>> firmware first before adjusting the image index, I'd hope we could avoid
>>> that? Unless changing the index would invalidate the checksum
> I was remembering the FMP parts wrong. Looking at the spec again, it
> seems that UpdateImageIndex is not part of the signed payload. So you
> can switch it before that.
>
>>> The image is authenticated inside of fmp->SetImage() at which point we
>>> don't have the image type ID or name so it's too late at that point. We
>>> would need to adjust it earlier.
> Yea that should be fine
>
>>> perhaps we could go about it another way, what if we add a dfu_alt_num
>>> field to efi_fw_image (and add a flag to efi_capsule_update_info to
>>> indicate if the new field is valid), then in efi_capsule.c just before
>>> we call efi_fmp_find() we can call a new weak function that would adjust
>>> the image index of the matching efi_fw_image so it matches whatever is
>>> in the capsule. Then we don't have to care what it is since we can use
>>> the right dfu_alt_num field anyway.
>
> Doesn't that have to be defined per board config though?
>
>>> Maybe this could just all be done in efi_capsule.c and not even need a
>>> platform hook, either gated behind a config option or just behind the
>>> new efi_fw_image.dfu_alt_num field being used.
>>>
>>> I worry that's too much of a workaround that might cause issues down the
>>> line but I'm not really familiar enough with this to be sure.
> I think the workaround is not too big of a hack. You are essentially
> remapping some image indexes based on runtime info of the board
> because you want a single capsule to support multiple confugurations.

Thanks for the suggestion. Will go ahead with this approach and will 
soon post the series.

Regards,

Balaji

>
>> Casey,
>>
>> We have checked and this approach seems to be fine. In this approach
>> though, it comes back to the issue we saw earlier: the image index (from
>> the capsule) could be > descriptor count.
>>
>> If this is fine, then we can proceed with this approach. Atleast we
>> won't be creating dummy dfu strings.
>>
>> Ilias,
>>
>> Would like to hear your view on this, so we are all on the same page.
>>
>> Regards,
>>
>> Balaji
>>
>>>> Regards,
>>>>
>>>> Balaji
>>>>
>>>>>>> Regards,
>>>>>>>
>>>>>>> Balaji
>>>>>>>
>>>>>>>>> Regards,
>>>>>>>>>
>>>>>>>>> Balaji
>>>>>>>>>
>>>>>>>>>> [1]: 7cf06f09cc51 ("capsule: Put a check for image index before the
>>>>>>>>>> update")
>>>>>>>>>>
>>>>>>>>>>>        Let me know if this approach sounds reasonable.
>>>>>>>>>>>
>>>>>>>>>>> Thanks,
>>>>>>>>>>> Balaji
>>>>>>>>>>>>> Will send an updated series once the mkeficapsule and qcom
>>>>>>>>>>>>> capsule
>>>>>>>>>>>>> update changes are in shape.
>>>>>>>>>>>>>
>>>>>>>>>>>>> [1] https://lore.kernel.org/u-boot/20240419065542.1160527-1-
>>>>>>>>>>>>> sughosh.ganu@linaro.org/
>>>>>>>>>>>>>
>>>>>>>>>>>>> Regards,
>>>>>>>>>>>>> Balaji
>>>>>>>>>>>>>> Kind regards,
