Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AFF7FD0040
	for <u-boot@archiver.kernel.org>; Sat, 28 Feb 2026 22:16:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ABA7D83F14;
	Sat, 28 Feb 2026 23:16:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="f9h4kO0t";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="t3YzjgqG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 425AC83EF9; Sat, 28 Feb 2026 23:16:55 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B38F983CDF
 for <u-boot@lists.denx.de>; Sat, 28 Feb 2026 23:16:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4fNfgQ2WZzz9tWv;
 Sat, 28 Feb 2026 23:16:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1772317010;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Tb1NSP9ef5gRhl86l02lED+D51as2tEHZQkHmsykgbY=;
 b=f9h4kO0tU6vCXygZsd0HbEeTTP8hzAc5CvpkDeVvxuqL3OWBf4fk/DPj4iexcjgUTI0WFf
 n7RPfgHSa+OipZUTsFNOoEqgSe/PO5Lo0tGVcgzpioMNDXb1EJuqMECKCHh1sx8pPg2W2v
 pQia4LILZZcLoJmwIbxgKkDzGqaI6wTaBxN+JofyxxOeFnj+IJrLyxXPC5gmgOKEQUSYi4
 IUATLdQovsJORH3tbsBsADu8SjGC0qHxt2hOxNhsmdWGHbjK70by7yWwEhiWHcXbi2V9WZ
 s2Pyt4xLZ+xCq9K29L+90YVWOcZnG0pT3f19iPkSH6lCAi3j0uxxPftrIcLraA==
Message-ID: <40018ce7-5fed-4eb4-8888-601f99747109@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1772317009;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Tb1NSP9ef5gRhl86l02lED+D51as2tEHZQkHmsykgbY=;
 b=t3YzjgqGmyrSfAn36hi8vdJpuzI17wqd2pXMPzY8GJzG7ITBdZt2rkgaaj7wwNBl+6PEC5
 DpDauAOsvHg/beItAruO9SJ7Q4siiXicRpO+nshsvWkxHP7oVoPI/CtUTnwF8PP2B96onS
 OdF43KT+vbV51al8KBNP7rzCGBaJXvYfGenhPj9YFENPa9mEyh6ODeOhi0dDB5FnFZRidO
 EFiTb207EQjg36Ai9tqkYfflQUMHzyViYBN1hZFJWpbymnyQklgrapRKw53iwhlwt1b9Z5
 3FYv8SVvahAtqZrRO+H5JsuVqIW/ugVrv+ApQP/q5H3lwTXttC2O8p3ntCBimQ==
Date: Mon, 23 Feb 2026 20:23:25 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v2] gunzip: Implement chunked decompression
To: Simon Glass <sjg@chromium.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de,
 Alexander Graf <agraf@csgraf.de>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome@forissier.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>
References: <20260219003351.388722-1-marek.vasut+renesas@mailbox.org>
 <CAFLszTj42WZF3DTOt4HxskNW3qyZJ5_pQ66RsBNdbr13rXTFeg@mail.gmail.com>
 <2acea5e6-5760-40b3-b8e7-952fc355e621@mailbox.org>
 <CAFLszTjRjpFRxxQJt2hNXzuMn9O3Kgcwrh10XpAMXqczK146NQ@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <CAFLszTjRjpFRxxQJt2hNXzuMn9O3Kgcwrh10XpAMXqczK146NQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: iduzrh9abb3dxfyctthzcpko8xbecemy
X-MBO-RS-ID: 7540cb6cf590ca78b72
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

On 2/23/26 6:41 PM, Simon Glass wrote:

Hello Simon,

>>>> +       /*
>>>> +        * Allow runtime configuration of decompression chunk on
>>>> +        * sandbox to better cover the chunked decompression
>>>> +        * functionality without having to use > 4 GiB files.
>>>> +        */
>>>> +       const ulong minchunk = 0x400;
>>>> +       const ulong maxchunk = SZ_4G - minchunk;
>>>> +       const ulong chunk =
>>>> +               CONFIG_IS_ENABLED(SANDBOX,
>>>> +                                 (clamp(env_get_ulong("gzwrite_chunk", 10, maxchunk),
>>>> +                                        minchunk, maxchunk)),
>>>> +                                 (maxchunk));
>>>>
>>>
>>> As you mentioned in the last version, there is a compression test in
>>> compression.c - could you add a version of this function that takes
>>> maxchunk as an argument and call it from that test? Reading an
>>> environment variable to avoid passing a parameter seems pretty odd to
>>> me :-)
>> Do we not want to test the command line interface ?
> 
> Yes it is a good idea to test it, although we don't need to
> exhaustively test each compression case. I suggest using the dedicated
> compression/decompression tests to check detailed features, with the
> cmdline tests just checking for basic functionality.
The compression tests already test the memory-to-memory inflate path, 
but they are not suitable to test the gzwrite inflate+write to block 
storage path. The existing gzwrite test is suitable exactly for that. So 
no, I don't see the compressions tests as a good place for gzwrite test. 
The command line gzwrite test on the other hand is already there and is 
testing exactly the inflate+write path.
