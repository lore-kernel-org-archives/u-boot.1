Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 065A3E8384D
	for <u-boot@archiver.kernel.org>; Mon, 23 Feb 2026 03:12:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 243EF83935;
	Mon, 23 Feb 2026 04:12:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="htKOE1zZ";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Elcv6+2x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DFAB83BC9; Mon, 23 Feb 2026 04:12:11 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD41883642
 for <u-boot@lists.denx.de>; Mon, 23 Feb 2026 04:12:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4fK5Vw3dRPz9tCf;
 Mon, 23 Feb 2026 04:12:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1771816328;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=47ukdhkzxWrvKP9jsPuFYxXlsnPQSEMXG8Y/VrV+tjo=;
 b=htKOE1zZfuciGgw6i9bxRlbGo8qkTRJdSZxdBzORcwNv1j2Djm3etFWaPRxPoBusOROvgP
 2APkaYX1x9yNPJ5iNqYtatGXT2sT69a0WZMbbPJ8UiH8tl10qGElco0NFmKJZjM91sZCJv
 WjCRO3qwO4zi6GJcV0l7bAIahyvMciP/hewTNM5ghOb6BLkSp2WF9+/nzlb9A0Wf2oM++t
 F1hS2hOe5qSdkAFsB6CTKUAOxVaFSGlKD4xLWAlgVWQCoyJss+pIw8e2k+gA/lUaaXMK0s
 Iah8HeAPft7Rzrg9rYftASHuWxgsz4BDWitX7lcHFk89tU9b1aWbvHjNCX4tTA==
Message-ID: <2acea5e6-5760-40b3-b8e7-952fc355e621@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1771816326;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=47ukdhkzxWrvKP9jsPuFYxXlsnPQSEMXG8Y/VrV+tjo=;
 b=Elcv6+2xjhTr1KWPAgIYuo+4fl1X1WxotFm1fubCWMA/4QDssW7virKUExI/+G5TaWHPEv
 Vn6H5VxGMTCrNZpv4jIUnoXO/xfRiM1E05Mw+pNWEvlKLaM8cvc25L6gj0W8UioWF+NLBL
 sRMfnbOr19RSixStpjADMBF5wVJMEXPmMXsNxH4VBQoVcy1SmQB2ddvwuJ7TuEN4XNLKJ/
 XCt+VZpvDnNkLK8rWfng0NK7iBRWFNpyaZfP5e/yVMYuyLA4mIoiT3yz9rDzuUgXbdGxVl
 s4xCUJwVuj2RAhslofnpc05A5Es8/jTLPYnzKCLQXzGYo5sepsy1nF1TrfE8Iw==
Date: Sat, 21 Feb 2026 19:33:32 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v2] gunzip: Implement chunked decompression
To: Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Alexander Graf <agraf@csgraf.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome@forissier.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>
References: <20260219003351.388722-1-marek.vasut+renesas@mailbox.org>
 <CAFLszTj42WZF3DTOt4HxskNW3qyZJ5_pQ66RsBNdbr13rXTFeg@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <CAFLszTj42WZF3DTOt4HxskNW3qyZJ5_pQ66RsBNdbr13rXTFeg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: ec541f99353e6e33aa2
X-MBO-RS-META: rsfpu9t3d1wygjq65kds4p5cpr7u1bnn
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

On 2/19/26 2:09 PM, Simon Glass wrote:

Hello Simon,

>> +       /*
>> +        * Allow runtime configuration of decompression chunk on
>> +        * sandbox to better cover the chunked decompression
>> +        * functionality without having to use > 4 GiB files.
>> +        */
>> +       const ulong minchunk = 0x400;
>> +       const ulong maxchunk = SZ_4G - minchunk;
>> +       const ulong chunk =
>> +               CONFIG_IS_ENABLED(SANDBOX,
>> +                                 (clamp(env_get_ulong("gzwrite_chunk", 10, maxchunk),
>> +                                        minchunk, maxchunk)),
>> +                                 (maxchunk));
>>
> 
> As you mentioned in the last version, there is a compression test in
> compression.c - could you add a version of this function that takes
> maxchunk as an argument and call it from that test? Reading an
> environment variable to avoid passing a parameter seems pretty odd to
> me :-)
Do we not want to test the command line interface ?
