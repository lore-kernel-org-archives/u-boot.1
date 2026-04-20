Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5795EA71B0
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 05:10:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1DF4C840D8;
	Mon, 20 Apr 2026 07:10:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="U5oB2We1";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JBI6bDJ6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D47BF84198; Mon, 20 Apr 2026 07:10:54 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28B1480086
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 07:10:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63K4qZ7i3241991
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 05:10:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 hc4khmOJXe9OMU95sXoN827G/viOMdikSGmB9mW2dsU=; b=U5oB2We1EGG4xds4
 pD/o2Yi3V2u1j1FXgalOklRobYePNIJGtIneuutxzMPvHFFytwa5xwpr6DRJCrgY
 EXWZz8uzpu3IpB/3u9w9QFGnIqdSm30+Sfo789iDchAChpeSdADtsyBVuhBuInSF
 8gDLsurbWuZ2lDxSX19wS+or/8QdY9fEovG2wyqfUsma5gYAECUDRVSND3JEs8bM
 SPFBcTJ9aca7NR/86Tq+QV3a6pm84SsFFz76BKaf3wAzPda/nTe0/zxxTimvQAR1
 qzjR9t82NMYY7+T/YaKqpFSJW2xsg4+ohBm1E+clH7ZRV5L1X6SXbCQGoq1dhtDY
 JxR43Q==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dm261v36x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 05:10:49 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3614272b00cso2826302a91.3
 for <u-boot@lists.denx.de>; Sun, 19 Apr 2026 22:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776661848; x=1777266648; darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hc4khmOJXe9OMU95sXoN827G/viOMdikSGmB9mW2dsU=;
 b=JBI6bDJ69XqnLgO2N15OfXl8P1BsZpYfT/l5G/CeoC8vhKXweQr8PHKnEeqzU76Hqj
 4um6zWn+LqLpGuk6F2YKvHGShvW6TZyqnJIn8pybVZeMKGXJ2PBuAo7PIC8BD+8D20fM
 863tw2czAEoMI4SdpLHjf0xQS4mpkD72/XAxnfl1y2bKzuS6Az0/W2sJpuAc80aavF7P
 xLD137fo8WBT9Ehsw13TMInXRq0pjLp6zIiRpyyT5rgLCvCrYJcKx626mBLIOkDEpuyX
 fm46BiQqnkZNTxnJfVpAnT6ujMsiE9wuRq2i/X0oTMrF6pVHpy/aAb3+VJmtqlrLqmNK
 DO7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776661848; x=1777266648;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hc4khmOJXe9OMU95sXoN827G/viOMdikSGmB9mW2dsU=;
 b=IpvXqSp+CxHNyBVV4/P/NanGA9TSxrK+U1wFjeal4HG7uYwDKLAIWLJA+qPSPElm4W
 G0Uy8AO4Xt9RujcBbRbyMoD83cMgbZpnf6p0QeFmpachojHYPy1gc4c5cpTgLBE7ffX/
 kF3wmZCYFy6jMNYTiHaJl56NibenF4PVWll81uvvSwojo4I/tmCtLNDm2vwI4p4t52+P
 lbfGhAxMoU/+ZVYmZu7REsSF4LGgBgXJvmWA24FuoPg24TFUxox4crp7sg2wgdNHJ7KJ
 P0rIYG7ysTFXutKaCRE6ScY2tZaZ/7YrP6X1w+FQfQVwDOmoB7RT2XNXky7kh0v/HcBC
 mDCg==
X-Forwarded-Encrypted: i=1;
 AFNElJ97F5sDQBv8QyByYeFth7Q5ThDRsDn1NhxoB3tFIPOKtsjkF6iiEPBXSmRyx/KWnTr5aXMZwbs=@lists.denx.de
X-Gm-Message-State: AOJu0Yw/K0qh+oQyRWFij2+3irkATBQHUDzuhUqga22/3dP6wxDZQ9Au
 JiuwV43Px6czMgL9ZDWWgkrUs0v9a+C4CIbvc0jEOMXV7Qm1MgLR98eKwffZztqHoBw/XB+3bc+
 yzuX3a1y6jFCbWDMcOIp4Sualdc/T3jgraFwBaRP+mVl2TKBmd0O/7w63
X-Gm-Gg: AeBDiesBFgM9Sk46ZqA7DmudKB1gQ+tBnbnHj71nvEbhJln5kcaZ3WkgT6lYdoOp3Sx
 Ob7EALemC4aaziw11yXuUe0uWu3aRtINHXt7RuG4o8rux5HNldAsn3DlUd1k7FssynnOxQTSMVH
 BY5iiOCIusPKJD7nthlAzApgmh/iNm9+z3W6a8SZU/JrtGHwpSmlR11C8YfIDdfvWvU30q1Fbta
 75Sy9FhBDLFcdWkrgr/2JqF4v4T6SQkTPNIs8yxiNIBiJbkr824CePHGksTzQvZpfQcBByy5Ja2
 0qJA4dNiWA96CmZJGXDLSijXFqoumlv+fThgCFjpdV/Vl3rjiTTDqCQzOX0dCMabgMCeQ9LC7No
 Ux4I8Yah3UjDSvzyuSO7e1t2syRfJqSS+tPrLK3iwWCV2NTfHWVWgZOyG2MY8QPSGPQnRkw==
X-Received: by 2002:a17:90b:5865:b0:35e:27ec:dea with SMTP id
 98e67ed59e1d1-36140493410mr13248990a91.23.1776661848429; 
 Sun, 19 Apr 2026 22:10:48 -0700 (PDT)
X-Received: by 2002:a17:90b:5865:b0:35e:27ec:dea with SMTP id
 98e67ed59e1d1-36140493410mr13248953a91.23.1776661847942; 
 Sun, 19 Apr 2026 22:10:47 -0700 (PDT)
Received: from [10.152.199.49] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36140fc593bsm11302345a91.1.2026.04.19.22.10.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 19 Apr 2026 22:10:47 -0700 (PDT)
Message-ID: <db5dcdd2-12aa-460b-bc0a-2bf3e25277e5@oss.qualcomm.com>
Date: Mon, 20 Apr 2026 10:40:39 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/5] Enable USB3 Super-Speed support for QCM6490/SC7280
To: Casey Connolly <casey.connolly@linaro.org>
Cc: Lukasz Majewski <lukma@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Tom Rini <trini@konsulko.com>, Luca Weiss <luca.weiss@fairphone.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Peng Fan <peng.fan@nxp.com>,
 Yao Zi <me@ziyao.cc>, Kory Maincent <kory.maincent@bootlin.com>,
 Kuan-Wei Chiu <visitorckw@gmail.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Raymond Mao <raymond.mao@riscstar.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Philip Molloy <philip.molloy@analog.com>, Sumit Garg
 <sumit.garg@kernel.org>, u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20260418-kodiak_ss-v4-0-d381670c9d78@oss.qualcomm.com>
Content-Language: en-US
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <20260418-kodiak_ss-v4-0-d381670c9d78@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDA0NCBTYWx0ZWRfX71uH78yCYF+/
 HP40phLj5cGTredCzOIfIO2uOgRmhnNpbQvvbRvM6M/1gFQNNTr2KUc7UEX9ggiJ8p/zgWi3vmd
 USQEBvRV0nP8EQ+Rgd7lj34TXDju5Jj0pp0uMmWfTo2OzeIua5Qmq77Q0X1iOF2f/XH1X+2k7FN
 z0/J7zvb0fyUmDfWq4pkbGPLPAT69Oz8cFr+PL0I0ieH5Uk17d54ZHFcJzJHnoJHU6cFW2JBzoP
 k0fOdOjZCtoBODCFdTCx31dmzzb6UTUT0YrgiM0IQF5hvQ4AaRkPzzYNJWLnsUQE8sWgK7db4tk
 inD1cnvTebVYz7fumwgiGLQfEMQOG8uYgYfD6iigr55mlsObsaYlcQF6v8Yf7iE/ITGH+0SgLOT
 B+ZX3I0rgZPU2UJTFfOcScr2JGwW34y3ybfRBZYZsiUiS8GgF6XF96k2uXOKPxHC7xa1cY6UjcQ
 vVv5nL3dhfmn7FxvH4A==
X-Authority-Analysis: v=2.4 cv=dcywG3Xe c=1 sm=1 tr=0 ts=69e5b559 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=fD6okpgmLAauAhto0_oA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: 3d00xYk9l-ibuAX8i-LwTpq3xv_POhKV
X-Proofpoint-GUID: 3d00xYk9l-ibuAX8i-LwTpq3xv_POhKV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-19_07,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604200044
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

Hi Casey,

Can you pls take this latest series (v4) on QCS6490 Super Speed support 
instead of v3. This still has the "unused variable 'cfg' 
[-Werror=unused-variable]" error that Tony specified though in th pull 
request.

Thanks,

Balaji

On 4/18/2026 12:05 PM, Balaji Selvanathan wrote:
> This series enables USB3 Super-Speed functionality on QCM6490 and SC7280
> platforms by adding support for the QMP USB3-DP Combo PHY. The combo PHY
> is a dual-mode PHY that can operate in either USB3 or DisplayPort mode,
> and this implementation focuses on USB3 mode to enable Super-Speed USB
> support.
>
> Patch 1 adds the necessary clock support.
> Patch 2 implements the QMP Combo PHY driver, ported from upstream Linux
> Patch 3 adds logic to skip USB High-Speed fixup if Super Speed PHY
> driver support is available.
> Patch 4 adds the necessary defconfig.
> Patch 5 updates the Maintainers file.
>
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
> Changes in v4:
> - In patch 3, instead of automatically detect if SSPHY driver is
>    available at runtime (which adds computational overhead), instead
>    just skip HS fixup based on usb node compatible string.
> - Link to v3: https://lore.kernel.org/u-boot/20251203110735.1959862-1-balaji.selvanathan@oss.qualcomm.com/#t
>
> Changes in v3:
> - Corrected regulator names in drivers/phy/qcom/phy-qcom-qmp-combo.c
> - Made regulators mandatory in phy probe;
>    if regulator not present, now probe fails
> - Removed support to manually disable the USB HS fixup via Kconfig.
> - Instead added code to automatically detect if
>    SSPHY driver is available and do HS fixup only if SSPHY driver is
>    not available.
> - Link to v2: https://lore.kernel.org/u-boot/20251124155503.2839766-1-balaji.selvanathan@oss.qualcomm.com/
>
> Changes in v2:
> - Gave correct commit id for reference linux implementation for
>    adding mdelay in drivers/usb/dwc3/core.c
> - In drivers/phy/qcom/phy-qcom-qmp-combo.c:
> 	- Added pipe clock disable in qmp_combo_power_off sequence
> 	- Added all required clocks except pipe clock
>            in qmp_combo_phy_clk_l
> 	- All clocks except pipe clock are enabled and disabled
> 	  seperate from pipe clock
> 	- Added support for regulator power supplies
> 	- Added a minimal xlate to only return the USB3 phy
> - Added "drivers/phy/qcom" to ARM SNAPDRAGON section in MAINTAINERS file
> - Link to v1: https://lore.kernel.org/u-boot/20251119152530.4175628-1-balaji.selvanathan@oss.qualcomm.com/
> ---
>
> ---
> Balaji Selvanathan (5):
>        drivers: clk: qcom: sc7280: Add USB3 PHY pipe clock
>        drivers: phy: qcom: Add QMP USB3-DP Combo PHY driver
>        arm: mach-snapdragon: Skip USB fixup for qcom,sc7280-dwc3
>        configs: qcm6490: Enable super-speed USB support
>        MAINTAINERS: Add entry for Qualcomm PHY drivers
>
>   MAINTAINERS                                |   1 +
>   arch/arm/mach-snapdragon/of_fixup.c        |  54 ++-
>   configs/qcm6490_defconfig                  |   2 +
>   drivers/clk/qcom/clock-sc7280.c            |   1 +
>   drivers/phy/qcom/Kconfig                   |   8 +
>   drivers/phy/qcom/Makefile                  |   1 +
>   drivers/phy/qcom/phy-qcom-qmp-combo.c      | 644 +++++++++++++++++++++++++++++
>   drivers/phy/qcom/phy-qcom-qmp-common.h     |  62 +++
>   drivers/phy/qcom/phy-qcom-qmp-dp-com-v3.h  |  18 +
>   drivers/phy/qcom/phy-qcom-qmp-pcs-usb-v4.h |  34 ++
>   drivers/phy/qcom/phy-qcom-qmp.h            |  17 +
>   11 files changed, 825 insertions(+), 17 deletions(-)
> ---
> base-commit: 30429c8bd2f18d33862cc41fe520f7459fa4bfbd
> change-id: 20260418-kodiak_ss-49942d3249f0
>
> Best regards,
