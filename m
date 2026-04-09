Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D78A1F364AB
	for <u-boot@archiver.kernel.org>; Thu,  9 Apr 2026 18:12:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E26AF8416F;
	Thu,  9 Apr 2026 20:12:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="WnU/VVlK";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FiZ7I/z9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B28C8407E; Thu,  9 Apr 2026 18:05:59 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D9FA83D8A
 for <u-boot@lists.denx.de>; Thu,  9 Apr 2026 18:05:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 639D1U7R1972607
 for <u-boot@lists.denx.de>; Thu, 9 Apr 2026 16:05:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 q8ggXTU6MxizH8YJKc7HeJJVKfA22TZCel4fsTz+KQc=; b=WnU/VVlK47oNggF+
 NdONrftTkfgrNTa+gkYe0IKR9EIXs6/ONQx2QlmmmPFw1AphzCMtnFrs1RgBHM9r
 lOMU+r6xZAVrGCd8/pXETgm+IThcgC90wprDQeJ4HT69ZrTQflxfXA6dGBF49fRO
 gpcCRZq3zEbUULZlXvHkgVFUtb8LwWTz2poVeYwWR4TbiuCTCCI/N5zkVxXhQA34
 8jgX1dXzpLyIEzctJsc93ylF4Hc7xLoigrGIdl1nQGprlU0vOlxw9wN//YwTpUiK
 BrYlSkKxLiMkjNNMzBEUuijmknG9Ij3kBJVsnGklEdkg+UHfZ5/oHSQjvn2Qu61b
 qzcdww==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4decms0pyh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 09 Apr 2026 16:05:54 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-358df8fbd1cso1231535a91.0
 for <u-boot@lists.denx.de>; Thu, 09 Apr 2026 09:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775750754; x=1776355554; darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=q8ggXTU6MxizH8YJKc7HeJJVKfA22TZCel4fsTz+KQc=;
 b=FiZ7I/z9pF3icTCvZMJgqwIW8isDQ9KHWKrOctDGa2+41lpcQ25irK4lJkH+uldPiL
 14NUmoEQBvf6fL9UHONBb79urMoj7C5g3J3UJPhPEkENZ3fN38AyOP+KqQ0D4URaIyiw
 ubuSTl5vCaSXmd7E41kK+uNT+oY+cOJOzcKRumMCv5bYXp1K2NayFoAb+LxZijtc0iih
 bVg6AbdNjbpw/xxGgvNvWUC+NUjVPGA3co3r7FmoLu8XAdQqsEeCMSaNTuC/lxWr7PLu
 OSlztLuPXls3RL+Uv9LCCDwkB5NXqWzx8jwKPAXr32Fdl4qDqOKEfxevL9tqQn8a+t/s
 QDMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775750754; x=1776355554;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=q8ggXTU6MxizH8YJKc7HeJJVKfA22TZCel4fsTz+KQc=;
 b=MRMAlB79JDY04LPXmJ3aIwKg7SpvRhGe6I1k7y6pOCmKjwwjP3MR0JSsf+oOCvPgwi
 /i/OTDGerILpdK6c43yWpqGoApnDN/+S/GBCM+iP1cOQ603X68CLTW/ka/On0lx6L4MC
 bL3tn6ww25CItMIIiSWA5WPXZm4oCro19v6wlySE28LTmgUQH3TrtK02LnoPiVzSmFLC
 YfK/QDJqa4fAVybW+jDIPeUfbYWKMNyUAmZbuU2D12Nd60C+a83WwGRv+13fUr+fizz2
 Hayix95m3Sf+vbDb6RlMXiTumDwm0ermfn6odNqLJ3Xfcl9BEDWbVSPLZahm0eIyst6s
 VkYg==
X-Gm-Message-State: AOJu0YyYNEOD/Vp0JTvOSsuhW1mD7gQtYBDjrHo6oeXwFoMzWxwf3b+J
 or3uB6xU2Iajvsh9HSjkl9vGXvfqe67btQzOCLuPG9aJB9hQbrEFfeo77teguc0+tDJjINNWDY8
 siy3RdoPC8gp+n0dv7XiVIUBKYkdqiy30ZN0SfpCTlvnEx6r2nH2ody4u
X-Gm-Gg: AeBDietQQ2XMahw0BQ6dZlNX/5acEMM/aZeKdCN/K2Nc1eQ73GE7q8vtzGRnwgOVMuE
 VXsV8GMELpzki6E6X11a0r3/S7ie3LI2nIQNBCZXfN+2lTdshdxb4cKa0pf+N2nj3lgR1b1Ar53
 avEfomlgrtxhXdg8Ivj24qaIW4YcsXirX9ZzcN0YSs2UxN4Cj+BxQEBEOPUOZ68syMq4W113Npu
 cVnUHAdSh/bhS2xoLoaPW6GdIaVf28KT61ahbbsfnovXCyceC0XBynVR85cYDWVtXYTacCJI2MS
 tj3VC2NNGUvj16VaBe1ThOpl3GFtHlN9u1mwxFr7b26xFzeWxI413Ym5OaadtpCp2xRMozJCxPP
 lBKj1By5h2dUyZpdzaulmFCe1X5iNZ/seiYPYbkRrRdY69QwZOu1UmnprQQk=
X-Received: by 2002:a05:6a21:3283:b0:398:a934:9be6 with SMTP id
 adf61e73a8af0-39f2f0cc6ccmr25690882637.43.1775750753873; 
 Thu, 09 Apr 2026 09:05:53 -0700 (PDT)
X-Received: by 2002:a05:6a21:3283:b0:398:a934:9be6 with SMTP id
 adf61e73a8af0-39f2f0cc6ccmr25690820637.43.1775750753306; 
 Thu, 09 Apr 2026 09:05:53 -0700 (PDT)
Received: from [192.168.0.4] ([183.82.207.245])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c76c6561fe9sm21424328a12.15.2026.04.09.09.05.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Apr 2026 09:05:52 -0700 (PDT)
Message-ID: <09c269fb-786c-4bb7-9fc5-d3d095675f84@oss.qualcomm.com>
Date: Thu, 9 Apr 2026 21:35:40 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] clk: stub: Add Kconfig option for SPL stub driver
To: Alexey Charkov <alchark@gmail.com>
Cc: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io, Tom Rini <trini@konsulko.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Anshul Dalal <anshuld@ti.com>,
 Peng Fan <peng.fan@nxp.com>, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Hrushikesh Salunke <h-salunke@ti.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Jan Kiszka <jan.kiszka@siemens.com>,
 Javier Tia <javier.tia@linaro.org>, Rasmus Villemoes <ravi@prevas.dk>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 =?UTF-8?Q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>,
 Dhruva Gole <d-gole@ti.com>, Richard Genoud <richard.genoud@bootlin.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Simon Glass
 <sjg@chromium.org>, Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Shawn Lin <shawn.lin@rock-chips.com>, Tuyen Dang
 <tuyen.dang.xa@renesas.com>, Casey Connolly <casey.connolly@linaro.org>,
 Lukasz Majewski <lukma@denx.de>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Michal Simek <michal.simek@amd.com>, Yao Zi <me@ziyao.cc>,
 Peter Korsgaard <peter@korsgaard.com>
References: <20260409-spl_ufs_only-v1-0-f7e0e243d805@oss.qualcomm.com>
 <20260409-spl_ufs_only-v1-4-f7e0e243d805@oss.qualcomm.com>
 <CABjd4Yy4HqEk2m=HDX1_qy9fWDjUmWVyebcFDxMDfVTe=CMobQ@mail.gmail.com>
Content-Language: en-US
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <CABjd4Yy4HqEk2m=HDX1_qy9fWDjUmWVyebcFDxMDfVTe=CMobQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: AClADdJWSGKeHzxAs41XjezMGvahoMj-
X-Proofpoint-GUID: AClADdJWSGKeHzxAs41XjezMGvahoMj-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDE0NyBTYWx0ZWRfX0A2R5WBJlV5F
 IB71Ody8IHMIeiIQS7ojuWc+iH8R7OOQk6catfnKfS48jwafpdMz5C7bCqtCp1DSWFRhcUcUOdf
 YI3VDXmHWUrkZHygeXxbSougm11El96yOAoWS0EaQQvyiY3hEwQCtrB9GDCnhinWOAfbfSvR/Ye
 6TeDDjUIDFMGhR5QKM4FiI9stXHR71zwDdhHQBUr/fYWyATEo0ldMGhYkYkDYP+x8RjW7UIfwum
 9cw6VxLaaKT20imRxsuAPXUTqKMWEfDLtWIPIisJ/MEsKMkUW4bCcPgeDZlnx65eP77q74GGEic
 l6Obqh1OJIDpYQyb6T1Z32vt2PL7wDj5SlebFCUB8RYbykKeGVix+apAaExS8zzYPel7xa+EM1R
 ypWQq1i/0Z9H6kKSGRT9Ry1ouUlDxUR/JD3ubKxpCM7fDCR88w+bUMyfYbwIU6ex2czaGxUZBnN
 RlSWiGQbXePAhoVkc4g==
X-Authority-Analysis: v=2.4 cv=N/sZ0W9B c=1 sm=1 tr=0 ts=69d7ce62 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=A13norTQGndBH59Ws6Bpcg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=3dM5e4jHQVeK-mEdFowA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-09_04,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 malwarescore=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604090147
X-Mailman-Approved-At: Thu, 09 Apr 2026 20:12:16 +0200
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

Hi Alexey,

On 4/9/2026 9:15 PM, Alexey Charkov wrote:
> On Thu, Apr 9, 2026 at 6:44 PM Balaji Selvanathan
> <balaji.selvanathan@oss.qualcomm.com> wrote:
>> Add SPL_CLK_STUB configuration option to enable the stub clock
>> driver in U-Boot SPL builds.
> Perhaps mention that the respective Makefile already had
> obj-$(CONFIG_$(PHASE_)CLK_STUB) in it and only the Kconfig option was
> missing. Otherwise it raises questions why a newly introduced Kconfig
> option doesn't propagate anywhere else in the codebase.

Okay, will mention.

Regards,

Balaji

>
> Best regards,
> Alexey
