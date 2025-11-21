Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFB65CFC28B
	for <u-boot@archiver.kernel.org>; Fri, 21 Nov 2025 14:52:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21F1883966;
	Fri, 21 Nov 2025 15:52:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Bcuv5Imj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E38F483981; Fri, 21 Nov 2025 15:52:44 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09CC383959
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 15:52:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4dCdVd0Trlz9ss7;
 Fri, 21 Nov 2025 15:52:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1763736761;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gyih/8+tZgd4m+vP+RmmWHP2jHMR0Lt8u+Pcbd0B56g=;
 b=Bcuv5ImjAxdJSW3DPJcY2ztlYdt17PHotqeHkfxVyPX/Pe+q+ad/IRUytb7CgiBCRBkaXd
 Hr7d+sYc/6hzVhNBAO29SfUbIZ36jjtOhUkJfpxLjSMfCqcdok3+I4R5MN3kL5TO8E9iwU
 gjx/0m0wxeDS+Wf6VB/BuDX8lRtW7PIpWcNBBtDifXdZSeQy84OfJELUAmvCBPgvcA/Y4r
 qSu5PsZFOHHMrnnwLugZ5pI0PPlLT8hqwJk2kkDcBYlz7aHqZTSxL8c4dgvfmKmBouYQ4Z
 aqu1gE5S9qhdktkDvofP6VzVutzKXuFoOoKRyMHGvdK8VpwsY1UGmsPSiK+MJQ==
Message-ID: <423d52bd-2446-47de-b6bc-4ee61fd0c23e@mailbox.org>
Date: Fri, 21 Nov 2025 15:43:06 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 08/15] dm: core: Support multiple drivers with same
 compatibles
To: Markus Schneider-Pargmann <msp@baylibre.com>, Tom Rini <trini@konsulko.com>
Cc: Maarten Brock <Maarten.Brock@sttls.nl>, u-boot@lists.denx.de,
 Kory Maincent <kory.maincent@bootlin.com>, Rasmus Villemoes
 <ravi@prevas.dk>, Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Tingting Meng <tingting.meng@altera.com>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 =?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>,
 Liya Huang <1425075683@qq.com>, Romain Gantois <romain.gantois@bootlin.com>,
 Simon Glass <sjg@chromium.org>, Jaehoon Chung <jh80.chung@samsung.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Sukrut Bellary <sbellary@baylibre.com>
References: <20251118-topic-am33-evm-oftree-v2026-01-v1-0-91ce13c661e2@baylibre.com>
 <20251118-topic-am33-evm-oftree-v2026-01-v1-8-91ce13c661e2@baylibre.com>
 <20251118140804.GR2125796@bill-the-cat>
 <DEDGK9KKB61P.1QY81TPR5JLNY@baylibre.com>
 <20251120212909.GQ2125796@bill-the-cat>
 <0b9e2a8e-1ab8-4a6e-899f-4ae9fd43b68c@mailbox.org>
 <DEE8BZBDYO08.1SX1UEB750S25@baylibre.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <DEE8BZBDYO08.1SX1UEB750S25@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 33a3ad6d2897b93521f
X-MBO-RS-META: c5aot75yijuy6td8g51bnp3n1x34dscs
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

On 11/21/25 9:28 AM, Markus Schneider-Pargmann wrote:

Hello Markus,

[...]

> Thanks for the pointer, this is using the exact same mechanism as I want
> to use. Is this tested and works? Because if I look into the current
> code for probing and binding:
> 
> 	/*
> 	 * Walk through the compatible string list, attempting to match each
> 	 * compatible string in order such that we match in order of priority
> 	 * from the first string to the last.
> 	 */
> 	for (i = 0; i < compat_length; i += strlen(compat) + 1) {
> 		compat = compat_list + i;
>      ...
> 		for (entry = driver; entry != driver + n_ents; entry++) {
>        ...
> 			ret = driver_check_compatible(entry->of_match, &id,
> 						      compat);
> 			if (!ret)
> 				break;
> 		}
> 		if (entry == driver + n_ents)
> 			continue;
> 
> 		...
> 		ret = device_bind_with_driver_data(parent, entry, name,
> 						   id ? id->data : 0, node,
> 						   &dev);
> 		if (ret == -ENODEV) {
> 			log_debug("Driver '%s' refuses to bind\n", entry->name);
> 			continue;
> 		}
> 		...
> 		break;
> 	}
> 
> So if I understand this correctly, the returned -ENODEV will cause a
> continue in the outer loop which iterates through the device compatible
> string list, jumping to the next compatible of the device if any is
> given. It does not continue in the inner for loop that iterates the
> drivers.

I check the HF one regularly, the SPI is a bit less accessible, but the 
binding code didn't change for a while so I don't think it should be broken.

I wonder if the RPC works by accident, and one driver matches on SoC 
compatible and the other on fallback compatible. In that case, I think 
the bind code should be patched to try other drivers and check whether 
they might also be compatible in case the bind returns -ENODEV, indeed.
