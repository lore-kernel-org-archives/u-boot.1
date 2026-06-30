Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DF64C43458
	for <u-boot@archiver.kernel.org>; Tue, 30 Jun 2026 22:26:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC7F684B32;
	Wed,  1 Jul 2026 00:26:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="fMI9q9h3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CBDB84B48; Wed,  1 Jul 2026 00:26:00 +0200 (CEST)
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 724C184A1D
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 00:25:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marex@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 176DF118721; Wed,  1 Jul 2026 00:25:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1782858357;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=xyq/VB+x3cT3nqtLYIROatu4bF+4g3tD0Q5GA2YW5UE=;
 b=fMI9q9h3zsenj7ybD1h9Q5mwuuM487a2NYIQGrCtblNQrjp1yq93sFrOfY0CTvoB9t/8Kt
 A77QZ26Dme2q3T+3l3wUyFP8HQ9NqEpjwHueNny+nFE4HxoigSQ0jE0Wa88Yb5ETnspHSu
 iG0CH/6v+3wXgVuyxq5NI3ZMI77a+SAFM3Sh+2aqgI5kzD9oehIiVYL/YE5yeEiQYn09uH
 pV+Ek6ZlBU00ZS1OBWSzRBXM9qzl8nNe7K0MogVKYRr3Dgvhntus6VXAVE3NFjtrcCTRX0
 H1WsaYd+e2ECKVQJq5vKzVzsx09w6ADM9iqUSEsuC7zpWZWi4m1gu3Xs/tj8jg==
Message-ID: <aa193305-8177-4d9a-b5b4-9243395451ee@nabladev.com>
Date: Tue, 30 Jun 2026 12:35:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 61/64] usb: host: re-import xhci-ext-caps.h from kernel
 v6.16
To: Jens Wiklander <jens.wiklander@linaro.org>, u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
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
 Jerome Forissier <jerome.forissier@linaro.org>,
 Alexey Charkov <alchark@flipper.net>
References: <20260629084507.3254232-1-jens.wiklander@linaro.org>
 <20260629084507.3254232-62-jens.wiklander@linaro.org>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <20260629084507.3254232-62-jens.wiklander@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 6/29/26 10:44 AM, Jens Wiklander wrote:
> From: Jerome Forissier <jerome.forissier@linaro.org>
> 
> Import drivers/usb/host/xhci-ext-caps.h from Linux v6.16. The file
> is needed by the updated DWC3 code.
> 
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> Tested-by: Alexey Charkov <alchark@flipper.net>
Shouldn't this be imported at the beginning then ?
