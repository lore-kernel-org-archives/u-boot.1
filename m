Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE8FFEA794A
	for <u-boot@archiver.kernel.org>; Thu,  5 Feb 2026 00:02:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37D4183015;
	Thu,  5 Feb 2026 01:01:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="wcPZx9ki";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CB2C8341A; Thu,  5 Feb 2026 01:01:58 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57F4F8063E
 for <u-boot@lists.denx.de>; Thu,  5 Feb 2026 01:01:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4f5y7c25Sqz9thN;
 Thu,  5 Feb 2026 01:01:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1770249708;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f1B/E4BwqNFFycGRzb3N5LrkZtGXiKWJQIdm/1utkgE=;
 b=wcPZx9kiZfx/JfJPoMi40IiAgmuNE2WzsM/3/KgOCyfp6GpHNIOjCvLk9ruGbI0lLbGqds
 MO089+2t96cFilPT+L+S9V407m5NFkfZPelZbKAJaw71wRtDazJSOZ61qlCuh/v/qPjZqO
 PujGDsmFhzC6hNK9xoS3dXc95AbF5HqOoMgu6qwoB2XyIcKciMQzsLVuAurgigJYcXFNbW
 pm4X1p4400iDCdAgGxoPYKCK3OsYgDroQH774AhgH2IB3qdxoHz5/AGe/5Tfng6ONxVtjE
 8OJw9ScI7yxKzixsMN6XQkENdE98BCuGWmkeBJw1bXj6mRGLOU9SRp2fXK8Jdg==
Message-ID: <c7aad978-75c6-4b73-9f82-a531206ed330@mailbox.org>
Date: Thu, 5 Feb 2026 01:01:45 +0100
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
 <a1491909-e775-4cf9-ac8b-a7b3b84d264e@mailbox.org>
 <CAFLszTgP7k4NhRHgmQcrhHb+08ixvgEvh9p6Gr_ea7x939auSQ@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <CAFLszTgP7k4NhRHgmQcrhHb+08ixvgEvh9p6Gr_ea7x939auSQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: jnfrod74m8asqqg3tmbrx6u7q7iipxhc
X-MBO-RS-ID: cb039fd0736a818e081
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

On 2/4/26 1:42 AM, Simon Glass wrote:

Hello Simon,

>>>> +       /* Test various sizes of decompression chunk sizes */
>>>> +       for (j = 0; j < ARRAY_SIZE(sizes); j++) {
>>>> +               env_set_ulong("gzwrite_chunk", sizes[j]);
>>>> +               for (i = 0; i < ARRAY_SIZE(sizes); i++) {
>>>> +                       ret = do_test_cmd_zip_unzip(uts, sizes[i], true);
>>>> +                       if (ret)
>>>> +                               return ret;
>>>> +               }
>>>> +       }
>>>> +
>>>>           return 0;
>>>>    }
>>>>    DM_TEST(dm_test_cmd_zip_gzwrite, UTF_CONSOLE);
>>>> --
>>>> 2.51.0
>>>>
>>>
>>> Rather than an environment variable, you could create a variant of
>>> gzwrite() which allows it to be passed.
>> This test is invoking the command line 'gzwrite' command, it is not
>> calling the gzwrite() function . And I don't think the chunk size should
>> be configurable on command line by users ?
> 
> Agreed.
> 
> But the command test could just use the default, then add a C test to
> call the unzip function directly with a series of sizes. Going through
> the command is a bit of a pain. We have quite a few examples where the
> command tests are more basic than the 'lower-level' tests.
Isn't that what test/lib/compression.c test does already ?
