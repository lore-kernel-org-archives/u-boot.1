Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8DE606A326
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 08:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ZWGNWUvP;
	dkim=pass (2048-bit key, unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256 header.s=s2025 header.b=fHl+reQ4
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D3EEF81232;
	Sat,  7 Nov 2026 08:30:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BG7IZ2YbbHCN; Sat,  7 Nov 2026 08:30:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 63EB981134
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794040246;
	b=fLQB3jch/PyUrOfERtATT0KYiDPi0mNMzCXnJ6cy9igk6N9uWhb/srD1AY2ekrv1r/Cb
	 qd/kVJmCGUztl4J4ZEYkhPWWJKNGSjnV2z9FvKr+T/ze4tzrUMzibhomYHy0BdAHjNSp5
	 CpxjvV3CLhtWg0Hlx2OPLUuxjsG3xhf6aZJDwD+U/79smjwt9vvwim1WFXVd8k+m6VEqw
	 4r5drv0sBYwUpYNi2DXhKQBC+oHSDEzF/8uckPFNOLlXGuJwQe7FGWr2E520XI9exmR9g
	 ATKu81ENctF8UWg02fgcfEfkBTH3FD/7cwIMH9t+tcLjpYEL1cFKNXvxFp018wj4LgQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794040246;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=egow9qfIr4fCqPQt1yfmppy2vWaTtkBgNpcZv0Wsq+U=;
	b=PWEz9qljUFl926fY55OIWzzjS5WvFN/5pHbgaQXSa9COWYm+RSVNFv1uMyIQFNfr7jYg
	 6D5tTmJJM+7scE1mcza+8fFy6HahZKAVLQ+5HTxtUrZ65NFemZ1CPnueSbVArCQXsiqa6
	 SoRvkTiHdMtK/HuTAMEppN+5KbdaZ0cEhqIKjNq4gx5PR+dBga3mSkHyB3xLTEFK5ON6J
	 /6tuvJ0ft7/hvaw9d5zSYfn7dzbI9cbhYkgU32GbAO267o0d73lAWJB3OToXMog2VX/GZ
	 PTnihsg7ZW3vo4i7lcjSbTXl+Ljz9Wq8h9TK7V6FkiVoC25fYnm5SBJ2jnHfMykLS8w==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794040246;
	bh=egow9qfIr4fCqPQt1yfmppy2vWaTtkBgNpcZv0Wsq+U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZWGNWUvPDj1YTQ+8JfmExKUHHllQCU/q04Jsoxn8DcuygoRQByBFFc7ff6OlOA5sU
	 98HB9nxWjyssqpSvNrUgi88d5XqC0p6dz+VpMJ/qI4Du01SENjIKL1T7pDTSVJuMw8
	 APqvl7bZQVM3HeRkO5Xy2yHmyVdHL/oOlBY+8U2Ygoj+s4RZofDBil8Cg3VK1kJ8QQ
	 BpG4vb/+XyP2cxffGsw9ZwELBFk/i9//t4+XuXIcd5tsCPhao++VsDk3RiipUBWzzv
	 oO62uTRTmCTwtmQ9mvWNuIiY9pcrceDLn6Okkcrwjqod197yYkYXD1hw1O1FA1RVt/
	 4mjLBhGp1IQkg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 63EB981134;
	Sat,  7 Nov 2026 08:30:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8CAA7362
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 08:30:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 72A5B4005F
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 08:30:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 94PIs0dsR7Zp for <u-boot@lists.u-boot-project.org>;
 Sat,  7 Nov 2026 08:30:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 31A5340042
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a01:4f8:231:482b::2"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:4f8:231:482b::2;
 helo=freeshell.de; envelope-from=e@freeshell.de; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=fHl+reQ4
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 31A5340042
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 08:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1794040225;
 bh=egow9qfIr4fCqPQt1yfmppy2vWaTtkBgNpcZv0Wsq+U=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=fHl+reQ4F3X5JkJj3iWtU3NrdlkrXsQqYvNEmfU2wqGpP7OvRFNxcGAM3LRMF2Mgb
 IgZZxuAi0dNcpi8FfekSvJ5QsoUeKFVrHKcH/zaOGoeuncOvPYDZJXNo/1++fRDHB+
 phCygohBKwPnalEHMHz8QTpkBEdyNHjT5Wo1OyjUkNolX7PfXmSL9GKwXInPYiHuaE
 z/bNXdqpYkRZVFIxv+lYbHZ9bpH3KOqIb94DDoVMGhRDwBU3fNIho56wFJce7R0zIb
 9c8NU1FlEy7ETPcjTWmSCwntFTDP0k+kKRd6mJsvE11sOg7guIliCoFbk8rmDELW9V
 B/E+P/clQ2p2w==
Received: from [IPV6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc] (unknown
 [IPv6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 5AA60B221CEF;
 Sat,  7 Nov 2026 09:30:23 +0100 (CET)
Message-ID: <896494fe-261b-442b-91a5-25333371c8d0@freeshell.de>
Date: Sat, 7 Nov 2026 00:30:15 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] cmd: lwip: wget: write the download to a block device
To: Igor Velkov <iav@iav.lv>, Jerome Forissier <jerome.forissier@arm.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>, u-boot@lists.u-boot-project.org
References: <20261101-b4-wget-blk-r4-v1-0-e27a009e4043@iav.lv>
 <3bb5a9a4-ce05-45c8-9fc4-d4fe99b1b0c1@arm.com>
 <79fdb1d0-c777-43c4-a7ea-98455186e900@freeshell.de>
 <2b5d3f92-666f-4c0b-863e-c681674c611c@arm.com>
 <20261107-re-jerome-shattow-wget-blk-0@iav.lv>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <20261107-re-jerome-shattow-wget-blk-0@iav.lv>
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
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Igor,

On 11/6/26 14:40, Igor Velkov wrote:
> On 06/11/2026 20:10, Jerome Forissier wrote:
>> ...I agree that compatibility is a must and that we should not
>> introduce such a change lightly. Thanks for raising the point. Let's
>> see what others think. I will drop this series if it is deemed unacceptable
>> or if we simply need more time to discuss it.
> 
> We are new here and not yet familiar enough with U-Boot's style; we
> don't want to make it worse. We'll rework the options the way the
> maintainers advise. The writer is a separate sink (lib/stream_sink.c),
> so a 'cc' command can use it too. That notation is new to me, though:
> more usage examples would help - which inputs and outputs, with what
> offsets and sizes.
> 
> I'd like the options to cover memory, a whole disk and a partition.
> Ideally a file on a filesystem too; how to do that is not clear to me
> yet, so I haven't tried. Still, the syntax should leave room for it
> and stay easy to read.
> 
> Igor

Are you willing to write something like a 'cc' for U-Boot? This 'cc' is
only a new idea I am thinking of. I'm not much help with systems
programming code so I'm only able to describe the user interface for the
idea.

I've attempted this previously as a U-Boot hush script for read/write of
eMMC block image to/from file and then tftpput over the network, which
is annoying to construct in this way and also as being unable to parse
outcomes made it very error-prone.

The most immediate 'cc' implementation would be to fully re-use existing
commands. The idea of 'cc' is for any data read/write user command where
you have source and/or destination with an intermediary buffer that does
not necessarily have 1:1 relationship with the source or destination:

'cc dd'

There may be some sub-commands (cc input, cc output, cc buffer) to
assist with setting the variables so that env variable setting is
discoverable by users at the command line, and a sub-command to begin
the data transfer action based on the env variables e.g.:

cc_input
cc_output
cc_addr
cc_size

I suggest 'cc dd' for the sub-command name to begin the data transfer,
it is familiar as taking data from one place in chunks and putting it to
another place. A subset of coreutils dd arguments could be parsed if we
will want e.g. 'seek=' 'skip=' 'bs=' 'count=' 'status=' and not have to
invent this syntax again, just refer to how it is written for dd
documentation.

I think load / save / 'mmc read' / 'mmc write' are good first candidates
for cc command support on input and output, and with some more work to
extend support for streaming commands then wget for input, mw for input
and output, md for console output, etc.

env set cc_input 'mmc read - 0 50000'
env set cc_output 'mmc write - 50000 50000'
env set buffer $loadaddr
env set size 0x400

when cc_input env variable gets parsed out for 'cc dd' each iteration
the support for mmc as a 'cc' command filters on argv[2] as a buffer
address placeholder, and then argv[3] and argv[4] as initial inputs need
to be re-calculated in a series of calls to the real 'mmc read' command
so we don't overflow whatever cc_buffer_address and cc_buffer_size is
specified.

A similar filtering occurs for cc_output.

Overlapping the input and output ranges is undefined behavior, but may
be useful so don't prevent it.

Initial support for input commands that are streaming like wget, when
the output commands are not streaming (like I describe the most basic
possible way to re-use existing commands) can just require that the
memory buffer is large enough for the whole input, and failing early if
overflowing $cc_buffer_size. Then re-factor the 'cc input mmc read' 'cc
output mmc write' support as a streaming input / output, and streaming
refactor of 'cc input wget', and then whatever 'cc input load' and 'cc
output save' support for file on filesystem source/sink that you are
interested in.

This would be amazing, is it possible?

-E
