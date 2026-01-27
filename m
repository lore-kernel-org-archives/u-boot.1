Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8654D2F002
	for <u-boot@archiver.kernel.org>; Tue, 27 Jan 2026 11:41:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29D8883FE9;
	Tue, 27 Jan 2026 12:41:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="fCqcOlaZ";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="JDYfwydn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2D7583FEC; Tue, 27 Jan 2026 12:41:05 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0731C83FDE
 for <u-boot@lists.denx.de>; Tue, 27 Jan 2026 12:40:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4f0k4T5Dz1z9v7S;
 Tue, 27 Jan 2026 12:40:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1769514057;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Zh5s0weMnpTab4VXT1yz1VTn2Jbllt24kNR1Dm3KURg=;
 b=fCqcOlaZS9wL1dzZUs0dsoR44mD/bdj3EC/s0nu/FgRl3vJ7mml7IaFTU3rfi8w4Nk1WyJ
 RcmCjS2l2Fg6wdPEis9Y4Koewz7aUf22mZxhMHBA1DOhsu9hQdhdaz34X+MAGwFhWdOw7T
 B+MoveQ0LKLmepbPnwFPWGvT+/bhmx2dj+wZNp5dMdxH72Hc7sk23fCpgBgQtKbLNEiBMZ
 kjf3d3xoyUaWw7o5+ZQw7ode2Iz2tivwYIN3Jpvq0F1kMW/IHJhFsF8kLWh1ekMcdZHU0Q
 KrcqMad+a6iKdBRIfpgA262Jo2K6N0oVuLNU8lHZ5zZgAgV7VUmY7mFBpE0FJg==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=JDYfwydn;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <75b9e8b8-dbbe-4502-8d4f-9a50b332bc7f@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1769514055;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Zh5s0weMnpTab4VXT1yz1VTn2Jbllt24kNR1Dm3KURg=;
 b=JDYfwydnocvdLrVpxZDQDtKzds4k+2ED9Bv5R+n9xqREy3W2gtDAYtO+Du+ZaoSV/mQPZF
 VZICpm5OBFUjxJnNrTkz7AV0kfn3xo6LWI7hXlylBsQtDF1KWJ52SGVp8D1UNKQnfSPgSL
 /Fa+Vk9aYsz61BaAnSddsEaHh+2BcxArPDeHQxxInM36CSQ4h5Ym9gqLIByCw+myF9Z9uE
 Q+K0rZU6xZyKdCgpoI6WAEHr6jMar4eWHOLo14Yx5+RRL5GcGVBn1hyjt72lBm4YQfi6Gd
 NQLOHIO40ovo8jX8g5iZb21wVUcmP10L7Hjn39D1qRJjEfF0MbRGD5N76mpiig==
Date: Tue, 27 Jan 2026 12:40:50 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v3] mkimage: Default to 8-byte alignment for DTBs added
 via -b argument
To: Beleswar Prasad Padhi <b-padhi@ti.com>, Tom Rini <trini@konsulko.com>
Cc: ilias.apalodimas@linaro.org, malysagreg@gmail.com,
 sughosh.ganu@linaro.org, philip.molloy@analog.com,
 marek.vasut+renesas@mailbox.org, james.hilliard1@gmail.com, anshuld@ti.com,
 afd@ti.com, nm@ti.com, vigneshr@ti.com, n-francis@ti.com, u-kumar1@ti.com,
 bb@ti.com, praneeth@ti.com, u-boot@lists.denx.de
References: <20260122172247.2995437-1-b-padhi@ti.com>
 <20260122174546.GB3416603@bill-the-cat>
 <c05217b3-f753-4fd1-9582-921e2cfd3a0b@mailbox.org>
 <b65ad902-2d07-4948-8a1a-64f4d5825a08@ti.com>
 <1e1f2e09-bfb7-4c7d-abd6-25a79271f256@mailbox.org>
 <89bde76b-b144-4323-bcdb-4ea04b55d695@ti.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <89bde76b-b144-4323-bcdb-4ea04b55d695@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: aikqmhzpe6yaocjw3sxjopfpmdh43cmo
X-MBO-RS-ID: e6fa2b1724413f5546e
X-Rspamd-Queue-Id: 4f0k4T5Dz1z9v7S
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

On 1/27/26 8:46 AM, Beleswar Prasad Padhi wrote:

[...]

>> "
>> diff --git a/tools/fit_image.c b/tools/fit_image.c
>> index 0306333141e..0c606ba4cc3 100644
>> --- a/tools/fit_image.c
>> +++ b/tools/fit_image.c
>> @@ -642,9 +642,15 @@ static int fit_extract_data(struct image_tool_params *params, const char *fname)
>>          for (node = fdt_first_subnode(fdt, images);
>>               node >= 0;
>>               node = fdt_next_subnode(fdt, node)) {
>> -               const char *data;
>> +               const char *data, *type;
>>                  int len;
>>
>> +               if (align_size < 8) {
> 
> 
> Do we need this check?
> Although unlikely, but should we account for mkimage invocations
> with -B > 0x8 and not a multiple of 8?
Yes, you should, that's a good point.
