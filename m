Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB814CD3445
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 17:37:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6791D84D5B;
	Fri,  8 May 2026 19:37:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Ixjgvupz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2B6784CDB; Fri,  8 May 2026 19:37:46 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C03F984CDB
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 19:37:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4gBxCV1sNSz9tnC;
 Fri,  8 May 2026 19:37:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778261862;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=me4tArdpbczTUVnVqFVPeLes7AXa0GZ7Nq2/oqqwUlE=;
 b=IxjgvupzMrnTRYekm46k/pHaJjcfFf/L6KGlccK6295ijzjYLc5P08plZ3b6fxj1nnuV7t
 NaO9s90F41hLyktfNAuc/oQ2djg+5G4IsqT3MdOnBiYWH7nVggUMGcX1x42nbOqYzu8NX5
 xv5kp4k2hHWVdOixGq/feYpdDKyf/FN1uVqBsKuMEgueZ8lEfjHEyqvy9ektG/Yu8lY/yz
 ZSQzc5hN143U1rxH9Hp46RI3afblAD7+w3HFNMYqdyHhq694x897h4z+uHeJwxwaw0qyXd
 kv9yatNXCXArbhYCGcI/DYR3x+j9OM/GXf8pexlR/NqvJ77yX/UG+6GbBs4PFw==
Message-ID: <b368c0cc-cd66-4879-8eb7-b2e9c214fbb1@mailbox.org>
Date: Fri, 8 May 2026 19:37:40 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 1/3] misc: cros_ec: Staticize and constify driver ops
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
References: <20260507220725.209205-1-marek.vasut+renesas@mailbox.org>
 <CAFLszTiRWmZaGW7ntiN1nBOyJ+PKSobT8kHg-3CRVaf7jpc5Bg@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <CAFLszTiRWmZaGW7ntiN1nBOyJ+PKSobT8kHg-3CRVaf7jpc5Bg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: debd7b3d9a41c012674
X-MBO-RS-META: qaukcu496hpzeccx84737i44abe8sc33
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

On 5/8/26 7:01 PM, Simon Glass wrote:

Hello Simon,

>> -struct dm_cros_ec_ops cros_ec_ops = {
>> +static const struct dm_cros_ec_ops cros_ec_ops = {
>>        .packet = cros_ec_sandbox_packet,
>>        .get_switches = cros_ec_sandbox_get_switches,
>>   };
> 
> Only the sandbox driver is touched - you could do cros_ec_i2c.c,
> cros_ec_lpc.c and cros_ec_spi.c as well if you like.

There is 220 sites which do static struct which can be switched to 
static const struct. I'll do that after I am done with this series, and 
then with ACPI_OPS_PTR series. Ugh ... I think I will be sending a lot 
more patches.

> BTW dm_cros_ec_get_ops() in include/cros_ec.h casts the ops pointer
> back to non-const!
And this one too, I made a commit locally and will submit this later, 
once I am done with this series. I don't want to flood the ML.
