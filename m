Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DA14E77188
	for <u-boot@archiver.kernel.org>; Wed,  8 Jan 2025 15:48:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11F0F800DF;
	Wed,  8 Jan 2025 16:48:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=postmarketos.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=postmarketos.org header.i=@postmarketos.org header.b="J4iS+mzu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 522DD801E8; Wed,  8 Jan 2025 09:39:50 +0100 (CET)
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com
 [95.215.58.189])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0360A8006D
 for <u-boot@lists.denx.de>; Wed,  8 Jan 2025 09:39:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=postmarketos.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexeymin@postmarketos.org
Message-ID: <de8dafef-187e-402d-87cb-fc79b4249a40@postmarketos.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
 s=key1; t=1736325587;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WtG0Q66FejxT31nXrIwS6bNb15kkBwrZYXXPg32wXZU=;
 b=J4iS+mzu9PRqUu9k3LTZfySC/+9BRbEPA8PsNbDUZ4ncTyciAd5kchR1gVYEt9Jeps044d
 SdC0sZh+uyvzmLzMzeTgbqyPtuFhfmy25GHCPhKBh9HePMNmNBdmTULmug/NyhWGGs0Gf4
 iq+SaSF+ffSzt+mmr6A13+PTT9BJYKHo0jmMoJi2aWir7lDPrIIHeHRGxkNvQ6c287y+s2
 /9VrSs5vIv1zh4gYQ2ZmXbLOdzgnGuccOaMpGTx640KGBs1SwMq6hIPW4+po9Gz7GRo9Jr
 n7sf2q+2j1Gb8AL/4SfVqlxrBWvbjl33RtQ2zETwuchGp1UeaysB9LHFb6mkeA==
Date: Wed, 8 Jan 2025 11:39:43 +0300
MIME-Version: 1.0
Subject: Re: [PATCH RFC 12/14] pinctrl: qcom: Add X1E80100 pinctrl driver
To: u-boot-qcom@groups.io, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Anatolij Gustschin <agust@denx.de>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de
References: <20241124-b4-efistub-arm64-v1-0-3e33f0340071@linaro.org>
 <20241124-b4-efistub-arm64-v1-12-3e33f0340071@linaro.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Alexey Minnekhanov <alexeymin@postmarketos.org>
In-Reply-To: <20241124-b4-efistub-arm64-v1-12-3e33f0340071@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Mailman-Approved-At: Wed, 08 Jan 2025 16:48:26 +0100
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

On 11/24/24 23:27, Caleb Connolly via groups.io wrote:

> From: Neil Armstrong <neil.armstrong@linaro.org>
> 
> Add pinctrl driver for the TLMM block found in the X1E80100 SoC.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>   
> +config PINCTRL_QCOM_X1E80100
> +	bool "Qualcomm X1E80100 GCC"

That's not GCC though. Pin controllers on qcom SoCs are called TLMM
(Top Level Mode Multiplexer). GCC is for Global Clock Controller.

> +	select PINCTRL_QCOM
> +	help
> +	  Say Y here to enable support for pinctrl on the Snapdragon X1E80100 SoC,
> +	  as well as the associated GPIO driver.
> +

--
Regards,
Alexey
