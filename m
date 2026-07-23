Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C3EBC531C9
	for <u-boot@archiver.kernel.org>; Fri, 24 Jul 2026 04:21:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 239E8608D9;
	Fri, 24 Jul 2026 04:21:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uQeEuo6IqNS3; Fri, 24 Jul 2026 04:21:42 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8477360AB6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784866902;
	bh=X65Vw8WLxEHqblJzCjla9oV/pOEUayzQwmt8y0MMFDA=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=oLoi5HsJYMgLBXrli0SjG8Crp4/32yg0rbUgZSIHADqU7ldCme85Zj2St9bWJfYGQ
	 D2qVInpuV/Z8tkDARDO40uDMUpKoZCOJbbXiAQandN29xOv+yHEtfqAIqZFnfj2XJf
	 +RokqctfqMBV3egHv/UnGUVa2IRXJJ5z8tuWC/a+1CH00+XnEN1IrT79kD7DhaKKb0
	 hVa6lypQEhbSbSV4vvd1dKg3BuLhQxSuXUuvxWARw8Z71SBpVWWNIfV+tKetFE56ik
	 XPs3msGaNfU7VNVm9MCNchVVqvuyC9qbu3IRX9h9fV61CeeLu1frbM+TGASOLZkEtN
	 K2LLryXeI0u4w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8477360AB6;
	Fri, 24 Jul 2026 04:21:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 7324F2E5
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 04:21:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 595AB4008A
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 04:21:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id W51qW6JAB_iO for <u-boot@lists.u-boot-project.org>;
 Fri, 24 Jul 2026 04:21:40 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=marek.vasut@mailbox.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 5724E401A4
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5724E401A4
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5724E401A4
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 04:21:40 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id D08BE846A4; Fri, 24 Jul 2026 06:21:37 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 627DA800AE
 for <u-boot@lists.denx.de>; Fri, 24 Jul 2026 06:21:35 +0200 (CEST)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4h5vvL4187zKv2c;
 Fri, 24 Jul 2026 06:21:34 +0200 (CEST)
Message-ID: <32d38204-8f6e-4a56-923e-b73b08eec87b@mailbox.org>
Date: Thu, 23 Jul 2026 21:53:08 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v3 2/2] usb: gadget: Add Renesas RZ/N1 USBF controller
 support
To: Romain Gantois <romain.gantois@bootlin.com>, u-boot@lists.denx.de
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Marek Vasut <marex@denx.de>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Kever Yang <kever.yang@rock-chips.com>, Peter Robinson
 <pbrobinson@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 George Chan <gchan9527@gmail.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Herve Codina <herve.codina@bootlin.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Ralph Siemsen <ralph.siemsen@linaro.org>, Simon Glass <sjg@chromium.org>,
 Peng Fan <peng.fan@nxp.com>, Kory Maincent <kory.maincent@bootlin.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Kuan-Wei Chiu <visitorckw@gmail.com>, Raymond Mao
 <raymond.mao@riscstar.com>, Stefan Roese <stefan.roese@mailbox.org>,
 Philip Molloy <philip.molloy@analog.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 David Lechner <dlechner@baylibre.com>, Julien Stephan
 <jstephan@baylibre.com>, Johan Jonker <jbx6244@gmail.com>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>
References: <20260723-rzn1-usbf-v3-0-34dd7c4ddd99@bootlin.com>
 <20260723-rzn1-usbf-v3-2-34dd7c4ddd99@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260723-rzn1-usbf-v3-2-34dd7c4ddd99@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 6j5on6fr3138wugt3m8mgpd1atru5pyx
X-MBO-RS-ID: 48bfefe7d3352879911
X-Rspamd-Queue-Id: 4h5vvL4187zKv2c
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1784866894;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X65Vw8WLxEHqblJzCjla9oV/pOEUayzQwmt8y0MMFDA=;
 b=KE4CjY4SArLVRPzknxN/s1CX/TFa37XU4f73ZWCM555zh0LQc6z0o87ub9Ir7GM4IFgaVK
 WXvGjkjBUm6FoJI7wRI+aPovdfapaqVLwxcs1ORyaLnNWqswI2/mziCa77I1TswFsEZjZh
 kDagy1PXrIosRABTPn9cKXfP/IYJ0aqMD89oLUEP/pTq5zSi6PnmTgV0dNXcpcrOxE0LfY
 hyFfG6JSH0Ws0sRdeyG0pV4Bvt4okfIR7uXJpcOzOdx1YCMq6QU4i3viMCR2xLRKxd4Oap
 HJd+lmpBnCi29vIVTKzEqTpqkg4WjHYV6R6jPcmCoNQBTg20k+I3UDhMjq6V+g==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1784866892;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X65Vw8WLxEHqblJzCjla9oV/pOEUayzQwmt8y0MMFDA=;
 b=OQJhZbgngkk+eQQQpPqOc5EJOovVLP8j0yOj9I6LM2FQXIX5alPHLt4fqqJYmOdhVHqqoN
 VbGyWE4VTBhTFOTUBmxFKGLDu/2IDx9JsA+PRtcXXvf4nUBtb0H3ticHVb246/BP73Elqe
 v6SPwk8DKdUnWHc0/EQUCrcsOTUBzha9K1V+9bTl/hjJRYC8dg2WPmtxA2nkNpKy+K2vob
 Pb/0dVOFKQ+Bfe0gZRQzjf5IpUz49QbDxN5mCJpOh3RYAw3CV63zHFGY6L+9v8DwAz9nGw
 LN+bhk4CeoTSQvrPMvHTN/AJ98qEat7SZIEHxVCE4NESbtV0ArBCSG+Gd+bkfw==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=mailbox.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=mailbox.org
 header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812
 header.b=KE4CjY4S; 
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=OQJhZbgn
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none)
 header.from=mailbox.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=marek.vasut@mailbox.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 secure) header.d=mailbox.org header.i=@mailbox.org header.b="KE4CjY4S"; 
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.b="OQJhZbgn"; 
 dkim-atps=neutral
X-Mailman-Original-Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=OQJhZbgn;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
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
From: Marek Vasut via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Marek Vasut <marek.vasut@mailbox.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 7/23/26 11:09 AM, Romain Gantois wrote:
> From: Herve Codina <herve.codina@bootlin.com>
> 
> Add support for the Renesas USBF controller. This is an USB2.0 UDC
> controller available in the RZ/N1 SoC.
> 
> This driver was originally written by Hervé Codina for the Linux kernel.
> 
> Linux revision this was ported from:
> 
> 74851fbb6d64 ("usb: gadget: renesas_usbf: Handle devm_pm_runtime_enable()
> errors")
> 
> The following features were removed to reduce the memory footprint of the
> driver, and to avoid including features not relevant to U-Boot:
> 
>   - Suspend/resume
>   - Handling of endpoints > 2

The code seems to handle 3 endpoints ?

> +/* Only handle the first three endpoints for now. This is sufficient to
> + * expose classic bootloader gadgets such as Fastboot or DFU.
> + */
> +#define USBF_NUM_ENDPOINTS	3

But why not handle the additional endpoints ?

Also, can you test whether 'ums 0 mmc 0.1,0.2,0' works to expose eMMC HW 
BOOT partitions and HW USER partition as three separate UMS devices over 
the same USB connection ?

The rest looks good, thank you !
