Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 587F1C87FCF
	for <u-boot@archiver.kernel.org>; Thu,  7 Aug 2025 19:45:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90A3F83C30;
	Thu,  7 Aug 2025 21:45:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="CbcPN66D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 857BF844E8; Thu,  7 Aug 2025 21:45:12 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A4D783C01
 for <u-boot@lists.denx.de>; Thu,  7 Aug 2025 21:44:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4byczn44nzz9tfF;
 Thu,  7 Aug 2025 21:44:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1754595845;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QeeGswK6sJkj7HsVhkxk8R7bKo/M2xOiNSsWU1RAC18=;
 b=CbcPN66Drbx1YX36eSPm+ZxG8iPuPfqkia47FrmANnX1M42bU8QoNoDvYpOdnXsu8qLQhE
 y0bJjoWsro0+hKHSp3z66dUoa2O2Dyt4eoDoFLP8jbE/4xx72Zy0h252Evlmr5Nor7l6cj
 uJmamOX+VE7oZJLm9haPkK+KDXjCYmatZc2/pS0hDyQNsiXiU8tB6NxBfsWJlZtKlyOQaT
 +McdL3cGCqKU6Ok1kuSkLDUFvFMLExAQz7UXr++/U/qEdTOIi+Y8KnExBujmH6SpDbfYGO
 UceNgpMoz+IM6cxQad0hGr0bqNfYKP5FS9SuPtjfj4eDCXQq5TCLnAsdLtoeeQ==
Message-ID: <008d9b62-2b22-4916-8cf3-c00fd8411701@mailbox.org>
Date: Thu, 7 Aug 2025 21:44:03 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/2] binman: add a new entry type for generating a data
 file which is passed to mkimage with -n
To: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>,
 Tim Harvey <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Alice Guo <alice.guo@nxp.com>
Cc: u-boot@lists.denx.de
References: <20250728-imx95b0-v1-0-5cdae3764d21@oss.nxp.com>
 <20250728-imx95b0-v1-1-5cdae3764d21@oss.nxp.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20250728-imx95b0-v1-1-5cdae3764d21@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 3go5ke5cfdr6u87gfpcmoxfqqe3pwmbs
X-MBO-RS-ID: 7a54aa7d700fe3b7efe
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

On 7/28/25 1:35 AM, Alice Guo (OSS) wrote:

> +/dts-v1/;
> +
> +/ {
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +
> +	binman {
> +		imximage-cfg {
> +			type = "nxp-config";
> +			cfg-path = "spl/u-boot-spl.cfgout";
> +			cfg-content = "CNTR_VERSION 2",
> +				      "BOOT_FROM SD",
> +				      "SOC_TYPE IMX9",
> +				      "APPEND mx95b0-ahab-container.img",
> +				      "CONTAINER",
> +				      "DUMMY_DDR",
> +				      "IMAGE OEI m33-oei-ddrfw.bin 0x1ffc0000",
> +				      "HOLD 0x10000",
> +				      "IMAGE M33 m33_image.bin 0x1ffc0000",
> +				      "IMAGE A55 spl/u-boot-spl.bin 0x20480000",
> +				      "DUMMY_V2X 0x8b000000";

DT should not contain text list of the generated text file. The 
addresses here should be DT properties. The file names are not relevant 
as they should be generated by binman etypes or subsections, see e.g. 
how imx-cst is handled on MX8M SoCs.
