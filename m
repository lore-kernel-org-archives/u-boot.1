Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F95FE8B37E
	for <u-boot@archiver.kernel.org>; Wed,  4 Feb 2026 00:30:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13DA183CB1;
	Wed,  4 Feb 2026 01:30:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="jiFcbQKQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D139683C72; Wed,  4 Feb 2026 01:30:30 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0DFB483B03
 for <u-boot@lists.denx.de>; Wed,  4 Feb 2026 01:30:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4f5Lq170bvz9tpj;
 Wed,  4 Feb 2026 01:30:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1770165022;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+xDGWsnHcLyZrxoHRl5de1qCn0nmKGlTjJ9kr4G3KxY=;
 b=jiFcbQKQG+asCb6OlTbNstsbBMa/cCgSuZI8C9IoZ07cwPEvw9PtSM5V3VfCL94nhdhnT9
 xr1Hgc4PFVSIGXSZ4l1Urp1k+r793wRqA8+Lg7q1rLMlRD75e1eBR797K2TTqnSB74NL33
 AC6t6LYu9X2txVc9JtWwmgypD3nNT+TKZXsheFprA7wELuYypv0njgn7Y1uR6miszoW4qv
 IFm6AoutP34sO9HEotneVCPrs+U2m2k0xgUpuu6cCski4fKk5lUgTwt+D4kgk3wrV3gqLX
 D4jH0GFNvd1Cga2+/3rskcZPq8GFsJWATHRoAFdrH+BhOj+s7MU3G3G50WlHmg==
Message-ID: <a1491909-e775-4cf9-ac8b-a7b3b84d264e@mailbox.org>
Date: Wed, 4 Feb 2026 01:29:50 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] gunzip: Implement chunked decompression
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Alexander Graf <agraf@csgraf.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome@forissier.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>
References: <20260128000340.1504375-1-marek.vasut+renesas@mailbox.org>
 <CAFLszTi2oP-vmCoPNayrKfVi8xMide3g5mR6XdcUgpaReyPtkg@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <CAFLszTi2oP-vmCoPNayrKfVi8xMide3g5mR6XdcUgpaReyPtkg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: dded989fa87c8d66342
X-MBO-RS-META: y4yzrhu4ksczqpmghkn7wyjistkb5oho
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

On 2/4/26 1:22 AM, Simon Glass wrote:

Hello Simon,

>> +       /* Test various sizes of decompression chunk sizes */
>> +       for (j = 0; j < ARRAY_SIZE(sizes); j++) {
>> +               env_set_ulong("gzwrite_chunk", sizes[j]);
>> +               for (i = 0; i < ARRAY_SIZE(sizes); i++) {
>> +                       ret = do_test_cmd_zip_unzip(uts, sizes[i], true);
>> +                       if (ret)
>> +                               return ret;
>> +               }
>> +       }
>> +
>>          return 0;
>>   }
>>   DM_TEST(dm_test_cmd_zip_gzwrite, UTF_CONSOLE);
>> --
>> 2.51.0
>>
> 
> Rather than an environment variable, you could create a variant of
> gzwrite() which allows it to be passed.
This test is invoking the command line 'gzwrite' command, it is not 
calling the gzwrite() function . And I don't think the chunk size should 
be configurable on command line by users ?
