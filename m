Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 497F7D2FED2
	for <u-boot@archiver.kernel.org>; Tue, 27 Jan 2026 18:52:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 85BFE84181;
	Tue, 27 Jan 2026 19:52:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="fZN1ONJn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3FB6A8416E; Tue, 27 Jan 2026 19:52:42 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58E3384164
 for <u-boot@lists.denx.de>; Tue, 27 Jan 2026 19:52:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4f0vfX3ZX7z9tPg;
 Tue, 27 Jan 2026 19:52:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1769539956;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J7yrDDCwJT+vVdfAl5LB5sanpnoJm533nl/mezYXuOk=;
 b=fZN1ONJn2jAIQQrwOXs3UPx6QGICTWWJyyccDJDLLyIrA8y6JkqFTvlzEnxj0XA3AVy3Qp
 xTvdm0Y0iC2XWwOah/wIAgJmGxBo7lwnJXLTsBJ+lcpEg3hf5opm4jXFNTqG8hZFQvt8QX
 otq/y3ep4sdXIEvHGos1Oi+P4/L9EjkQwH6k6xglojeNbWrVEwRy6Ah/gEAn+2JkMNXH/E
 FAzHtSWevP0Cvmrk2FtOXitzIpaHSfiG1ytarLTFUdnAIfd0GkLG1pL5ze9x3QaiksX+NC
 sAvLObBsb83S8h5+JEug9a9RNIyvna/fzSHOwQpj1qLkWU4QtemKGJxL0dHBqg==
Message-ID: <79af3d2e-7948-4610-9b8e-69aa61e5965d@mailbox.org>
Date: Tue, 27 Jan 2026 19:52:31 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v3] mkimage: Default to 8-byte alignment for DTBs added
 via -b argument
To: Tom Rini <trini@konsulko.com>, Sean Anderson <sean.anderson@seco.com>
Cc: Anshul Dalal <anshuld@ti.com>, Beleswar Prasad Padhi <b-padhi@ti.com>,
 ilias.apalodimas@linaro.org, malysagreg@gmail.com, sughosh.ganu@linaro.org,
 philip.molloy@analog.com, james.hilliard1@gmail.com, afd@ti.com, nm@ti.com,
 vigneshr@ti.com, n-francis@ti.com, u-kumar1@ti.com, bb@ti.com,
 praneeth@ti.com, u-boot@lists.denx.de
References: <1e1f2e09-bfb7-4c7d-abd6-25a79271f256@mailbox.org>
 <DFVWL63A8IDP.23PE1QNTXTMRU@ti.com>
 <6cb4957c-7178-4a31-aea9-ad78d6627c28@mailbox.org>
 <ab3a8a36-eaa2-4030-ba18-6c75647455b6@seco.com>
 <6896afd5-76fa-4b1a-abbd-0798f19185ba@mailbox.org>
 <785327c7-9d8a-4f5f-b792-4a1590796948@seco.com>
 <20260126225842.GY3416603@bill-the-cat>
 <f9310861-396d-4a89-b4a1-d67b9d6cae89@mailbox.org>
 <20260127160637.GD3416603@bill-the-cat>
 <b09e8fbe-1f5f-445a-a28b-ff6386a728a5@seco.com>
 <20260127163844.GE3416603@bill-the-cat>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260127163844.GE3416603@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: pr9frszzemc4cmo57sonpdicfk7mfd7i
X-MBO-RS-ID: 1560d826dad6f0bbe2e
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

On 1/27/26 5:38 PM, Tom Rini wrote:

>> No, the check in fdt_getprop is only for the name, not the value (which
>> could be arbitrary binary data including many nul bytes).
>>
>> I think the assumption in most of U-Boot is that the provided FDT is
>> trusted (or at least not maliciously ill-formed).  functions like
>> image_get_checksum_algo read up to 6 bytes beyond full_name if full_name
>> == "". It's possible to read off the end of the DTB if this is the very
>> last string in the strings block and there is no trailing padding. If
>> we're really concerned about this (e.g. to avoid false-positives with
>> ASAN), then we should just add (say) 16 bytes to the end of every DTB
>> when we malloc it.
> 
> Yes, we rely on the sanity checking in libfdt, which I think the kernel
> also does.
> 
> And no, I'm not sure if we care enough about all of these corner cases,
> but if we do then I'm not sure this right here and now is where to
> start. It should start with upstream libfdt to see whatever cases aren't
> handled, and then what cases fall on the callers to deal with wrt
> security implications.
> 
> Because I really, really, really, do not want to block fixing booting on
> some large number of boards because now we're going to depend first on a
> security audit here.
So back to my and Sean suggestion:

fdt_string_eq_() does effectively memcmp():

return p && (slen == len) && (memcmp(p, s, len) == 0);

So do this and be done with it ?

type = fdt_getprop(fdt, node, FIT_TYPE_PROP, &len);
if (type && len == strlen(FIT_TYPE_PROP) && !memcmp(type, "flat_dt", len))
   align_size = 8;
