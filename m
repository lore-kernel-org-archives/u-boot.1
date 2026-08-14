Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F7BBC5CFCF
	for <u-boot@archiver.kernel.org>; Fri, 14 Aug 2026 17:13:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 37A6140C38;
	Fri, 14 Aug 2026 17:13:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dYjCq0TF5PHm; Fri, 14 Aug 2026 17:13:19 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5059640C40
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786727599;
	bh=BFb56Ceq09okWRSHJ8f3qpYCWRtv7fBagtDuv9SIyds=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=IqvR1xB3gvOGnMvabIYaySLK1Zw63JC9e7JEIU6qD29NoqaHt1WrxzG4S0UORjhR7
	 hGMZooRf9KlZxELBIRh6HtbT7DJFAp52DQ7AnGAdXbxn5Yd3UxvVwUOh5vgbbelUFn
	 aBtMGa/aeB1gVQ6EZ+1EabI6p8jhk3Ko6ZuGnQ6vvFLhmWLID2jf0efX4EX5SnjXX/
	 FpEiOyTdRgpLb3crZIEqWNdnE3OKSTY9vEYZ1jEgRnc/Z1I7BN95+XCUF7GR8MIghz
	 XMiGvc9Ys3moQmxI1kKYC/Paux63dzV6GnowKzEfWbkPwScXyWTKjQrXUxDMP9XkYM
	 R3pRtvV3PplLQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5059640C40;
	Fri, 14 Aug 2026 17:13:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 694BA2B2
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 17:13:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5B1C8812F4
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 17:13:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MYHWCSnSGNl3 for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 17:13:17 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.85.4;
 helo=smtpout-03.galae.net; envelope-from=jeremie.dautheribes@bootlin.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 7090680E95
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7090680E95
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7090680E95
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 17:13:16 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 116E64E41233;
 Fri, 14 Aug 2026 17:13:15 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id C26916046D;
 Fri, 14 Aug 2026 17:13:14 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 1B9DA11C4EF31; 
 Fri, 14 Aug 2026 19:13:05 +0200 (CEST)
Message-ID: <604a8eb7-f6cb-4bd8-8ef7-4a316c03976b@bootlin.com>
Date: Fri, 14 Aug 2026 19:13:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] binman: add nxp_imx93cst etype for i.MX93 flash.bin
 signing
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Rasmus Villemoes <rv@rasmusvillemoes.dk>, Denis Mukhin <dmukhin@ford.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>,
 Alice Guo <alice.guo@nxp.com>,
 =?UTF-8?Q?Krzysztof_Drobi=C5=84ski?= <krzysztof@kd-solutions.pl>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marek.vasut@mailbox.org>,
 =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20260814-imx93-secureboot-v1-0-0c3c78020d03@bootlin.com>
Content-Language: en-US, fr
Organization: Bootlin
In-Reply-To: <20260814-imx93-secureboot-v1-0-0c3c78020d03@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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
From: =?utf-8?q?J=C3=A9r=C3=A9mie_Dautheribes_via_U-Boot?=
 <u-boot@lists.u-boot-project.org>
Reply-To: =?UTF-8?B?SsOpcsOpbWllIERhdXRoZXJpYmVz?=
 <jeremie.dautheribes@bootlin.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Apologies, I had a typo in the CC list, adding Marek Vasut 
<marek.vasut@mailbox.org> here for visibility.

On 8/14/26 19:07, Jérémie Dautheribes (Schneider Electric) wrote:
> Hello,
> 
> This series adds support for signing i.MX93 images by leveraging binman
> and CST, the NXP tool used for secure boot. This introduces a new binman
> entry type (etype) for this purpose.
> 
> The implementation is largely derived from the existing i.MX8M support,
> since the two share much of the same signing infrastructure.
> 
> This procedure has been tested on the imx93-evk board, using both ECDSA
> and RSA-PSS keys.
> 
> Patch 1: introduces the new etype
> Patch 2: updates the imx93-u-boot.dtsi description to include the new
> signing nodes
> Patches 3-4: documentation
> Patch 5: adds test coverage
> 
> Signed-off-by: Jérémie Dautheribes (Schneider Electric) <jeremie.dautheribes@bootlin.com>
> ---
> Jérémie Dautheribes (Schneider Electric) (5):
>        tools: binman: add nxp_imx93cst etype for i.MX93 flash.bin signing
>        imx93-u-boot: wrap SPL and U-Boot nodes in a CST node if AHAB_BOOT enabled
>        doc: imx: ahab: add AHAB introduction
>        doc: imx: ahab: add i.MX93 secure boot guide
>        binman: test: add code coverage for nxp_imx93cst etype
> 
>   .gitignore                                         |   2 +
>   arch/arm/dts/imx93-u-boot.dtsi                     |  54 ++-
>   doc/imx/ahab/guides/mx93_secure_boot.txt           | 269 +++++++++++++
>   doc/imx/ahab/introduction_ahab.txt                 | 445 +++++++++++++++++++++
>   tools/binman/etype/nxp_imx93cst.py                 | 143 +++++++
>   tools/binman/ftest.py                              |  78 ++++
>   tools/binman/test/vendor/nxp_imx93_csf.dts         |  18 +
>   .../binman/test/vendor/nxp_imx93_csf_imagename.dts |  24 ++
>   8 files changed, 1014 insertions(+), 19 deletions(-)
> ---
> base-commit: d3e8597e46b635ec556a057bc42f0b0859654bdf
> change-id: 20260814-imx93-secureboot-b914e7b6cbbf
> 
> Best regards,
> --
> Jérémie Dautheribes (Schneider Electric) <jeremie.dautheribes@bootlin.com>
> 

-- 
Jérémie Dautheribes, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

