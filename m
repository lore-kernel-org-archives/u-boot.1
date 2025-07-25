Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5A7AC87FCA
	for <u-boot@archiver.kernel.org>; Fri, 25 Jul 2025 16:54:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20DF3839C1;
	Fri, 25 Jul 2025 18:54:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="jf/nHnZV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B1F68397B; Fri, 25 Jul 2025 15:02:14 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D3CAE82C84
 for <u-boot@lists.denx.de>; Fri, 25 Jul 2025 15:02:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stefan.roese@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4bpSh14LGcz9stY;
 Fri, 25 Jul 2025 15:02:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1753448529;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LpZqbWVYTB0+SLXAYr5WEesKxZNbA2zWRyWPjiQSIKU=;
 b=jf/nHnZVs3qvGkL0VIwA/CYfSKZIqMA7iF1B2yzwO2AY+iSDopkm8FALFw9OGgGqiW8MVd
 EcwSJxSoKTDSdD8Zq0ReMNWkr2EEfV9xX1OS4dUhkVnd8XD4j6+kOrbFAKpCHvMosnixni
 M5A07uq9CY+JTANG30A/U/NrvFnOUrawm+Taz+T76GM1kfBkZ743uwvEG4OGiENyg6gKZC
 rssAk7xFiYZCc8Or6spJwMUFUnpFu/blOTihMhhJze5WCFEKh7kP5UbydDWLO1I1HRY0yH
 fQNH4Iji0xFe488Dzg+4aHY/beYD4vtY5lpIMO0w0FDX+SE3qe88DQ6vbXb+oQ==
Message-ID: <d0e95f4a-6870-451d-a730-0eef30ed4401@mailbox.org>
Date: Fri, 25 Jul 2025 15:02:08 +0200
MIME-Version: 1.0
Subject: Re: Smatch issues reported for Marvell a38x DDR4
To: Andrew Goodbody <andrew.goodbody@linaro.org>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
References: <fbf8148c-1b30-40bd-b709-1b4b6817de4d@linaro.org>
Content-Language: en-US
From: Stefan Roese <stefan.roese@mailbox.org>
In-Reply-To: <fbf8148c-1b30-40bd-b709-1b4b6817de4d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: h7jqk37jfroozthyru6j76sk9bet3rxb
X-MBO-RS-ID: 5f39b3cef1b30d453f4
X-Mailman-Approved-At: Fri, 25 Jul 2025 18:53:59 +0200
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

Hi Andrew,

On 24.07.25 18:01, Andrew Goodbody wrote:
> Hi Stefan,
> 
> Smatch reports the following issues
> 
> drivers/ddr/marvell/a38x/mv_ddr4_training_calibration.c:1029 
> mv_ddr4_center_of_mass_calc() warn: unsigned 'd_min' is never less than 
> zero.
> drivers/ddr/marvell/a38x/mv_ddr4_training_calibration.c:2192 
> mv_ddr4_dm_tuning() warn: unsigned 'reg_val' is never less than zero.
> drivers/ddr/marvell/a38x/mv_ddr4_training_calibration.c:2270 
> mv_ddr4_dm_tuning() warn: unsigned 'reg_val' is never less than zero.
> drivers/ddr/marvell/a38x/mv_ddr4_training_calibration.c:662 
> mv_ddr4_centralization() warn: unsigned 'if_id' is never less than zero.
> drivers/ddr/marvell/a38x/mv_ddr4_training_calibration.c:662 
> mv_ddr4_centralization() warn: we never enter this loop
> drivers/ddr/marvell/a38x/mv_ddr4_training_calibration.c:911 
> mv_ddr4_dqs_reposition() warn: always true condition '(delta >= 0) => 
> (0-255 >= 0)'
> drivers/ddr/marvell/a38x/mv_ddr4_training_calibration.c:924 
> mv_ddr4_dqs_reposition() warn: unsigned 'delta' is never less than zero.
> 
> As I have no way to validate the correctness of the code I am not 
> confident enough to attempt to make the appropriate fixes in this case 
> as it could affect its operation. Perhaps you would like to take a look?

Sure, thanks for all your work on these smatch issues. Really
appreciated.

But frankly, it's not easy to test anything in this area. I still have
access to one board (AFAIK), but minor changes usually don't really
make a notable difference in the DDR controller configuration here.

My suggestion is to send the patches (or one patch) "as best as you can"
to the list for official review. I'll try to review and perhaps someone
else with access to such a board will take a look.

Thanks,
Stefan

