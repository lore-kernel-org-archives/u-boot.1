Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2AF606A32D
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 16:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=DzjFvOdE;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=r6GhzsKA
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9C518812A9;
	Fri,  6 Nov 2026 16:56:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ns_RqDNHzwrO; Fri,  6 Nov 2026 16:56:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8EED78116C
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793984171;
	b=FJ3ermJHHMgXZPzlk7/RJjlNgo/jJVL4LTuYUhgdtXlvPBI+/ardxQa09mB4wBVz98Ae
	 omWTLzv37LiwjPN2G/Ulna0ORmWGmuznAiD0fMRNTUDVqNERULZYb2C36Ma/4pwD1AHK6
	 XEPUJ+SINh85hfz67WIOAaNrEs7v2OgLjzAz3mhwlj7BGP7xvg9Dqqwl0bnS+s68t3Xpg
	 xEEg0NO9HyvdYW9Nkc6nucw79N4VjJsv7VSUuCwCL14GfxXD7HR5bea83E1x9LEzAL6aN
	 EtnxjCrQCgl+EqUuWn7+0SN6yYAum0iJx9rktCF8XhsILma8pOK1s2w6Otf/fVvD9Hw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793984171;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:Content-Language:To:Cc:References:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=VnW5o9/5F0nVWzO0VV4lqWaAnIiJihfx5W50vE9uIME=;
	b=Dfwxy6Nb3CoK2/7JwH1A6CIYaJWsodiYPHADxd0i7y4x6lXgdaxXxemiSnZC1xY6mTYv
	 GaAdmAhFlZqHkpkrzdV2R/EiKtqoVuhoMXqSjLopftwHe5qpTllQBWMCwt/c/m4SCN6qb
	 yonZ6zlkEgZgY2FlBzJwwffIyOjkMh23gxKwIOIg8dNV9gAWia5OKcLZvUFeFq09XJHvf
	 1GM2HPXIY//OTuEg24+QWVurqSsJcs6OzZFYwRnGYDZ8CCs/myGiRxP5Xlqqqv/M9pIas
	 pIjqekmgtH5vhUWC1ksMOrTKnyQTtcorvYdWczDBmT0qSIsNXXQPFBKFHBcvW0ip5iw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=r6GhzsKA;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793984171;
	bh=VnW5o9/5F0nVWzO0VV4lqWaAnIiJihfx5W50vE9uIME=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DzjFvOdE1PlpQ2ZWqwjqg+8tSM0hkpW1tPjeYo4uxEmJewKPbb36nebYHZW9x0FEu
	 0pSnQDuhsS41UH4jok4ckjCjR7m9T3WpWSq295Fndr5i9+D4cUReikFiqbTCZvqxBP
	 HhAtBqh61jKhQKVQr6zqzBKAPAI5tztckApE7VxQkjfbOYZ15DRk2+SSohAe0BMmXY
	 bOe84HtvIj0twIsEpqrFE6Hoc85eeWEpQq7REP5grEIyQ0u5ug0opJFDa6I/KV7V3T
	 Uhs5y5+zqAkgtTKRVnZYTtuIkyriJtUh0HdAYkfnq/VEgXtk9hoHgDe0/W2V1Q3qAB
	 QeLlTz8aF6qZg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8EED78116C;
	Fri,  6 Nov 2026 16:56:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id CA36634D
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 16:56:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B08E181160
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 16:56:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bGUTmYjFNPzX for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 16:56:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 433B381169
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::a"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:31::a;
 helo=mail-wm2-x0a.google.com; envelope-from=casey.connolly@linaro.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=r6GhzsKA
Received: from mail-wm2-x0a.google.com (mail-wm2-x0a.google.com
 [IPv6:2a00:1450:4864:31::a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 433B381169
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 16:56:07 +0000 (UTC)
Received: by mail-wm2-x0a.google.com with SMTP id
 5b1f17b1804b1-4a2d6bfe8d6so2667645e9.1
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 08:56:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793984165; x=1794588965;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=VnW5o9/5F0nVWzO0VV4lqWaAnIiJihfx5W50vE9uIME=;
 b=r6GhzsKA9euuCnT7oWIvypVPIGYuEMiQrGK/CbSFBmovjmh0e0malaB5IssOLSPYTL
 pbttiMObRMQJv0sNkGk9xx61f/jsaHKq3JDjvf8b+Az5mCKqDKpg+dDQo65LTUDNpXzA
 s3XADwa6bBGmTlZ3Q1mPSwXHtXymtr94w/aKD4qOF3jd7eQzLg0grFQNLVfgu2cQKW71
 PH9x3uA89Mob+Vr88S8EK9XDReDi6cX2i/hX7CR0B83Fuiwb9SqdEjuGKoBK0DM33bhh
 4lDjTY+V95QfCy7zMtMSqyX+x4jENEglgSqcwQ5vmDjEbLMDEnGW05B68CTvLyPrDPvy
 c90Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793984165; x=1794588965;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VnW5o9/5F0nVWzO0VV4lqWaAnIiJihfx5W50vE9uIME=;
 b=BXHIE4fzqP9nyVeeB8V52WzbtKV9iJb+aTSRvV6x7xkyifvLYshA3V1mlQwOdc+qUT
 5b8oFUisdej2jlQlwNzbedhqwSPMMoupL8oW4RL8He0RpYxutOPbyd66UI1A3+vyree5
 4b6R7CRBpsbiSI6CYYtTlTMJKrPQ87iPi0/aOPmkW6h8Umk6wp3EJ21VWOj6fDguuKtw
 C7zEV/HILjiNjINTvmZtz5A7S+5G8/GNQqN0xioGaheolxaV8HYcEuh8Y0f4T+/6U+U+
 0YCxMvzLAy/Xsxu1xlP5qiQ/b4lcMvUdoqtePRrA+L4OcxbtbTbSVSGWe8AxLUvhDzN4
 jBVg==
X-Forwarded-Encrypted: i=1;
 AKwUvByc8mp0H3zbBrWrYQM+OIvu5vzBU2+yqkzTa8aFXigcrLSMKpPHg1u02zo6ZoO7jcQUYk2WIqY=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+QYcPbUC7yzgBioyMmppgDFnoXMq0beVeIA+elIpu1eesTItfZ
 VtaHSDvOP2rQkembeHz8jpFzqI2vrmZxwpTMaUsNG3dZD/4RNYSD2O9wKXb+4jmDpzE=
X-Gm-Gg: AYBFou3uYcCKvczXCqkDeLHWVQhiD2V5FLRQQ8wVuvmCku5aISGyseJ1ZQI65Yrgagp
 jDS2Cc79PODlOE6nj708nnQciYbsaH6JJo1Gb/e9UidtO9jf6IBigk7ZZbjrV4TraTdO792HWLq
 1ISoX2w0RUcyNXpTlfewAzoKgZyWdZK2bjGYeuWWev7ZDwKzHjedFTBMqfsKoLGosGLX+xGNyii
 ZDPm6y1TFZipBJij3en6BHh2JiY+c4+9CfszeQPZV2sYjQO3Y0yfpABaLNplQdxE2zCbACogcfv
 KAUN0sas6Fn1iwQUhcK37OXmvzz4Tsmr9WY0DGCWEAoaOtwgbTA44iC4doc47Vs5DA5qK400MgQ
 C+lYFmjxUJMdYRwL8IpeEQI2OZXD5x3PClU2sxCOAXtWvV3C7b4P2iCLlWzDiMdM3V/T6Bj4c2E
 O8l0j362LOy1YukuZT8JDfGnHyB1EaFm3NC+Pqxl9LGysGe/YbvLtBcj/ernGa8yvCkUoXgXJ2E
 6PimO7ZPc7fSEch9PEwl1fr4Py5ca/yxTxLzP7hMlGPUkYktV7lGMFBxCHAgfo1BbhprxkxLyJV
 bcxEN7VsQYwKBkB7sDZ9JOPIy+/70ZLITZltIlqzZxUtyer1iyoJ54D2iz1MIxNvZHCoeg==
X-Received: by 2002:a05:600c:34ca:b0:4a1:e672:5721 with SMTP id
 5b1f17b1804b1-4b6df11da11mr51174395e9.13.1793984165476; 
 Fri, 06 Nov 2026 08:56:05 -0800 (PST)
Received: from [192.168.1.37] (p5b29ebc8.dip0.t-ipconnect.de. [91.41.235.200])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b76d6cc909sm2000125e9.3.2026.11.06.08.56.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Nov 2026 08:56:04 -0800 (PST)
Message-ID: <dabc31e4-3e1e-4b3b-9e2b-f69a7ebe52a7@linaro.org>
Date: Fri, 6 Nov 2026 17:56:02 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/14] Qualcomm Firehose flashing protocol support
Content-Language: en-US
To: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>,
 u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@nabladev.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, Johan Jonker <jbx6244@gmail.com>,
 Vitor Sato Eschholz <vsatoes@baylibre.com>,
 Carlo Caione <ccaione@baylibre.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Jerome Forissier <jerome.forissier@arm.com>, Simon Glass <sjg@chromium.org>,
 Mehmet Fide <mehmet.fide@screeningeagle.com>,
 Vincent Jardin <vjardin@free.fr>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Michael Srba <Michael.Srba@seznam.cz>, Biswapriyo Nath
 <nathbappai@gmail.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Rasmus Villemoes <rv@rasmusvillemoes.dk>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>
References: <20261106-firehose-v1-v1-0-e7591c12fc65@oss.qualcomm.com>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20261106-firehose-v1-v1-0-e7591c12fc65@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Igor,

On 06/11/2026 10:42, Igor Opaniuk wrote:
> This series adds a "firehose" command that serves a block device to a
> such tools as QDL [1]. Firehose is the protocol used to
> flash Qualcomm boards in EDL mode. With this, a board running U-Boot can
> be reflashed with the same toolset used for flashing any
> Snapdragon-based device.
> 
> As discussed on the RFC [2], only the subset of the protocol needed
> for flashing is implemented, and the XML parser accepts only the subset
> Firehose uses:
> 
> - configure, program, read, erase, patch, power (reset) and nop
> - physical partition 0 only
> - sector values N, NUM_DISK_SECTORS[-N] and CRC32(<sector>,<bytes>)
> - no VIP, UFS provisioning, getsha256digest or getstorageinfo
> 
> Btw, work is ongoing to make the Firehose and Sahara specs public and
> community driven, so soon there will it will be available and used
> as a reference for host and device implementations alike.

This is definitely an important point, is this implementation meant to
be compliant to a spec or to the existing tools? In either case, I think
there should be at least a high level specification either in the docs
or at a stable link we can reference.

My other main concern here is maintainance, I'm happy to take these and
future firehose patches through the qcom tree, but I'd like to delegate
some responsibility for this. Could we get a new entry in MAINTAINERS
for firehose support so it's clear who will be reviewing and testing
patches?

Somewhat a related note, is there a particular reason why one of the
many other protocols (dfu, uuu) aren't acceptable? Is it just a matter
of keeping compatibility or being too difficult of a pill for Qualcomm
to swallow?

Your RFC explains why fastboot isn't acceptable, and I agree that
fastboot is not really meant for this, but it would be good to at least
pretend to consider dfu/uuu and offer some justification to not just use
them?

Thanks,

> 
> The command usage:
> 
> On Snapdragon SoCs the gadget enumerates as 05c6:9008, the EDL ID, since
> host tools like QDL only probe this VID:PID
> 
> Usage in U-Boot:
> 
>   => firehose 0
>   or specifying the storage
>   => firehose 0 mmc 0
> 
> Running flashing tool on the host:
> 
>   $ qdl --storage emmc prog_firehose_ddr.elf rawprogram0.xml patch0.xml
> 
> The device is either given on the command line ("firehose 0 mmc 0") or
> picked from the MemoryName of the host's configure command
> ("firehose 0").
> 
> QDL automatically skips Sahara when a Firehose "server" is already running,
> so the programmer file is not sent.
> 
> Tested this implemnentation with qdl v2.8 on the Arduino UNO Q (QRB2210, eMMC):
> - reads of flashed partitions match the images
> - write and read back of a scratch range, with and without a device on
>   the command line
> - erase reads back as zeros
> - GPT rewritten with gpt_main0.bin, gpt_backup0.bin and patch0.xml is
>   byte-identical to the original
> - a read of physical partition 1 is NAKed
> - power reset from the host
> - test/py test_firehose.py: 3 passed
> 
> On sandbox, the ut tests dm_test_firehose_* and dm_test_cmd_firehose
> pass. UFS and NVMe are untested (no hardware), and so is a full
> rawprogram0.xml flash.
> 
> [1] https://github.com/linux-msm/qdl
> [2] https://lists.u-boot-project.org/pipermail/u-boot/2026-November/638973.html
> 
> ---
> Igor Opaniuk (14):
>       usb: gadget: add a Qualcomm Firehose function
>       usb: gadget: firehose: add the read command
>       usb: gadget: firehose: add the program command
>       usb: gadget: firehose: add the erase command
>       usb: gadget: firehose: add the patch command
>       usb: gadget: firehose: pick the storage from MemoryName
>       cmd: add the firehose command
>       doc: usage: describe the firehose command
>       mach-snapdragon: use the EDL USB IDs for Firehose
>       configs: qcom: enable the firehose command
>       configs: sandbox: enable the firehose command
>       test: dm: add Firehose tests
>       test: cmd: add a firehose command test
>       test: py: add firehose tests with qdl
> 
>  arch/arm/mach-snapdragon/board.c    |  23 +
>  cmd/Kconfig                         |   9 +
>  cmd/Makefile                        |   1 +
>  cmd/firehose.c                      |  50 +++
>  configs/qcom_defconfig              |   1 +
>  configs/sandbox_defconfig           |   1 +
>  doc/usage/cmd/firehose.rst          |  81 ++++
>  drivers/usb/gadget/Kconfig          |   9 +
>  drivers/usb/gadget/Makefile         |   1 +
>  drivers/usb/gadget/f_firehose.c     | 849 ++++++++++++++++++++++++++++++++++++
>  drivers/usb/gadget/firehose_parse.c | 282 ++++++++++++
>  include/firehose.h                  | 117 +++++
>  test/cmd/Makefile                   |   1 +
>  test/cmd/firehose.c                 |  40 ++
>  test/dm/Makefile                    |   1 +
>  test/dm/firehose.c                  | 204 +++++++++
>  test/py/tests/test_firehose.py      |  99 +++++
>  17 files changed, 1769 insertions(+)
> ---
> base-commit: 709a97a05df66e394f40d249105d0baade46f107
> change-id: 20261106-firehose-v1-af7cf3b4ce48
> 
> Best regards,

-- 
// Casey (she/her)

