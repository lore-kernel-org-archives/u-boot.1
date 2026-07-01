Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C76BC43458
	for <u-boot@archiver.kernel.org>; Wed,  1 Jul 2026 20:52:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9714E84C39;
	Wed,  1 Jul 2026 22:52:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="TBGYEXJA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8CE184C4F; Wed,  1 Jul 2026 22:52:16 +0200 (CEST)
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5DA184B53
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 22:52:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marex@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id DF8391188BD; Wed,  1 Jul 2026 22:52:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1782939133;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=Q+D6zyPpAguJasnnf8XQZnYeINzZ1gtq91vn/m+nJqs=;
 b=TBGYEXJAMeP7oDcb3azpTcje0uP7l3vVeOOfYuBS+R4m9v+lSRceX2DBfvejNuvvN6hGhA
 /YNk2XIbR7n8G/hpcPHxMfBqyyWsoB4S8xy5LCM5s/03N/Q3q1HJXySUslsAxEB4Tn80AV
 jACBERmE4nnIqDXZNjTIFBmxVRML+OeuNasAcwMbVPAUOHBYHHsKxSmJMHERC+0tdKFRjX
 XUDAEyAgYBDRsqFTvB/Dp+rGA04069515tT7fV49d+ZIKqpttXSOpLYq3aCiw4r3a+iE9X
 EXvpdliKNEcoBV9CPJvbul6+qCFWmzJzpO3Ofuk8Xlqivu0AoNni9zAf6x4dOw==
Message-ID: <8c2e380d-c443-4c31-b834-1840df95da67@nabladev.com>
Date: Wed, 1 Jul 2026 13:00:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 62/64] usb: gadget: re-import epautoconf.c from kernel
 v6.16
To: Alexey Charkov <alchark@flipper.net>
Cc: Jens Wiklander <jens.wiklander@linaro.org>, u-boot@lists.denx.de,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Andre Przywara <andre.przywara@arm.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, Anshul Dalal <anshuld@ti.com>,
 Bin Meng <bmeng.cn@gmail.com>, Casey Connolly <casey.connolly@linaro.org>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Eddie Cai <eddie.cai.linux@gmail.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Ion Agorria <ion@agorria.com>, Junhui Liu <junhui.liu@pigmoral.tech>,
 Kongyang Liu <seashell11234455@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Rasmus Villemoes
 <ravi@prevas.dk>, Ryder Lee <ryder.lee@mediatek.com>,
 Simon Glass <sjg@chromium.org>, Stephan Gerhold
 <stephan.gerhold@linaro.org>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Weijie Gao <weijie.gao@mediatek.com>, Zixun LI <admin@hifiphile.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Jerome Forissier <jerome.forissier@linaro.org>
References: <20260629084507.3254232-1-jens.wiklander@linaro.org>
 <20260629084507.3254232-63-jens.wiklander@linaro.org>
 <7c32155b-8dc8-4d9b-afff-b6539164956c@nabladev.com>
 <CAKTNdwF4Wmfb=K00ZKKybPRZV8H-WtSnbcF9nnMjMPMbM64kGQ@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <CAKTNdwF4Wmfb=K00ZKKybPRZV8H-WtSnbcF9nnMjMPMbM64kGQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

On 7/1/26 12:53 PM, Alexey Charkov wrote:
> On Wed, Jul 1, 2026 at 2:26 AM Marek Vasut <marex@nabladev.com> wrote:
>>
>> On 6/29/26 10:44 AM, Jens Wiklander wrote:
>>> From: Jerome Forissier <jerome.forissier@linaro.org>
>>>
>>> Replace drivers/usb/gadget/epautoconf.c with the one from the Linux
>>> kernel. Fixes will come later.
>>>
>>> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
>>> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
>>> Tested-by: Alexey Charkov <alchark@flipper.net>
>> How was this tested ?
> 
> Hi Marek,
> 
> This was tested using v1 of this series after applying all patches to
> the base commit referenced in that version's b4 metadata, see [1].
> 
> Tested on a Rockchip RK3576 based board with two DWC3 controllers as follows:
> - Set one controller to gadget mode, the other to host mode via DT
> - Confirmed no crashes or warnings in U-Boot at boot
> - Initialized the host mode controller via console commands with a USB
> 3.0 flash drive connected via a hub
> - Initialized the gadget mode controller via `ums`, pointing it at the
> flash drive connected to the other controller
> - Connected the gadget mode port to a Windows computer
> - Confirmed no crashes or warnings in U-boot
> - Confirmed the device is recognized as USB mass storage by the Windows computer
> - Mounted the USB mass storage device on Windows
> - Confirmed correct partitions and size
> - Confirmed correct data
> - Confirmed reading and writing works
> - No crashes or warnings in U-boot
> - Safely removed the device on Windows
> - Stopped `ums` in U-boot, confirmed no crashes or warnings while stopping
> 
> This worked better than the then-current U-boot master branch, which
> had trouble properly resetting the controller at boot, resulting in
> non-functional gadget mode.
The TB should then be attached to 64/64 only.
