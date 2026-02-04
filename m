Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D511AEA794C
	for <u-boot@archiver.kernel.org>; Wed,  4 Feb 2026 23:44:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 430EC83015;
	Thu,  5 Feb 2026 00:44:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="ciTfBmat";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 884E98341A; Thu,  5 Feb 2026 00:44:43 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98EFD8063E
 for <u-boot@lists.denx.de>; Thu,  5 Feb 2026 00:44:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4f5xlq4RwGz9tRj;
 Thu,  5 Feb 2026 00:44:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1770248679;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a8j0vdeTpOH4qEOfeRXMXrPuDuM/FavDmNTFeHCP0XI=;
 b=ciTfBmat10SRz6VKEuBBjuC2eVWQEg2hBeTTSwdvGqStGuhggj7a0JptYoZLoumivymRys
 gros0pTZc9bYgJD7p9uoggmr7f7qc3dn8E4H9EWYXTvsfuoK8h1z3HjF06hAnBokQt7K46
 88AUtpOJKJ60MzRb4WIEj5KGteo8SZoLoqMGaDlUnLColnQYQMv2nbKPaX0K9zq0xqGooK
 CbTSock3h9gB/JcnM3VSG8qpuHh1vNy2Ea3DKBpA1V3RfMAgY+WRFIt3x/Q44jMNy1U3Ww
 8lsAVGrHX2uMgc4H9U5Npf6tX6QBko4PTSGGx/lJhrEjnmL5V2iMGNAchScZVw==
Message-ID: <42e931bd-2a81-435e-b1ae-b54260d10c28@mailbox.org>
Date: Thu, 5 Feb 2026 00:44:36 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v2 2/2] test: cmd: Add test for zip/unzip/gzwrite commands
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Alexander Graf <agraf@csgraf.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome@forissier.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>
References: <20260129235647.660906-1-marek.vasut+renesas@mailbox.org>
 <20260129235647.660906-3-marek.vasut+renesas@mailbox.org>
 <CAFLszTjMp4crBRadU7EfDtDa9FbR4tp_=Wg7xLvhAj5fKLchsA@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <CAFLszTjMp4crBRadU7EfDtDa9FbR4tp_=Wg7xLvhAj5fKLchsA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: c3b5faa1dcdc4868ac5
X-MBO-RS-META: 5ntjkdywxxpio1f8j4w7xwx87k8rmo8t
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

On 2/3/26 10:31 PM, Simon Glass wrote:

Hello Simon,

>> +       ut_assertok(run_command("random $loadaddr $size", 0));
>> +       ut_assert_nextline("%d bytes filled with random data", size);
>> +       ut_assertok(run_command("random $encaddr $size", 0));
>> +       ut_assert_nextline("%d bytes filled with random data", size);
>> +       ut_assertok(run_command("random $decaddr $size", 0));
>> +       ut_assert_nextline("%d bytes filled with random data", size);
> 
> I would argue for calling the functions directly instead of via run_command()

It seems I cannot include sys/random.h in this test to get access to 
getrandom() function , do you have any suggestion here ?

>> +
>> +       /* Compress data in $loadaddr into $encaddr */
>> +       ut_assertok(run_command("zip $loadaddr $size $encaddr", 0));
> 
> Perhaps add a flag to avoid generating so much output from this command?

It is the gzwrite command which generates a lot of output, not the zip 
command. And the excess output from gzwrite command is solved in this v2 
without any need for special flags to gzwrite like in V1 of this patchset.

[...]
