Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBF6606A326
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 18:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=pHQ19pmB;
	dkim=pass (2048-bit key, unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256 header.s=s2025 header.b=FGLVlTo6
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 65AFC81202;
	Fri,  6 Nov 2026 18:41:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CkOJk1dL4cT8; Fri,  6 Nov 2026 18:41:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9A40D810BB
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793990480;
	b=YTSegCsN8zlAhXP1ClFQrLuls2AgU7RJbcDkrHA0AAGYyVOlUp18DEGiJTZc3ks4dNkp
	 4PVCr/MX1Bs319H7l4TIZ1jCDzLSl75TSEaId0IAa4vgSa7bcFe1Go95Sw8isrL4ddI7Y
	 G0N+qyGWC+QA6Qc6eoUEbGfEQhnkOORaVzyPB540FNrerhnSMpSbVVbtByKEsctYWUm57
	 k17ay1P0+yOBKcZrXpJb3Is/LebGunej2nvQvODfJGrgyTERMXYaJgALUD/vFBWT+GUHJ
	 z7OJO9OmTjeolofpsD6q2P3EZeNTDnwEQK/yB2gx07OM3D3bcyqSKxqOqf7t8WuSw7A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793990480;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=9CGIp6EmJ7gV4Yh5zKDD5Ms11wS10MzsKAx7A8fi3T0=;
	b=DWYq9tKP0EIrbyGDS5USOvdjOCNwbxQItx5cn8/IP7FaLDWH7iHj4LaVvJBuYJk837Qz
	 mTLnw6PzxLkgJD2tTAfaKvQ1l4Iu7LcEdfxzjQRrTYdEmSpl3eavw9vyGs+Abi3R8GpxK
	 BLLVVrQVy9/VUL8Dm3qSv/ordDq/d8mxKpOs9pFh7LQD2Xz3dR9YqHRfYZroSbfXVJb+8
	 yo9I6NmxG2ekW6ganlEzmJZ5ni6mfVUMeyzUlqUZ7mAmPmdhyxXg/Oxz2S4qFit1LVR4w
	 T4qKq+wGUZ9DcOZM0j1+gstoSRLeXptjbiDQUlVseNA78+oJuoHTSzraflSlkz5fOGg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793990480;
	bh=9CGIp6EmJ7gV4Yh5zKDD5Ms11wS10MzsKAx7A8fi3T0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pHQ19pmB7qlabwhXrZyu7ZD8L+/4vyqDdwvBXJIYMA5RiTwWjXfFD0c32XlclIIQK
	 5fn6ApLarCkChaWWugeRoggoPRIe+31R4Ab7y1aGw9ogICZWNUG6M2HzVr7yaIVGX2
	 eUNyWzBDHjoqbmc1nok9+Culqbe505I5tpedAM9shqnRvkcbFcfLb1JSqxvg9GqOv1
	 eFs/gjmbtgjxfdSApufhSHmuD9ejixejmHnyYchgOv5wuVKjm76HZ6y+iex3Rj00ks
	 NMVm0m9YtCsBAlTGGJuGZll2nOQFqgwcAeU9asHZ01VlVsF2s0hc/M8RuylvEmq+6J
	 JnswXH2B1b9zQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9A40D810BB;
	Fri,  6 Nov 2026 18:41:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 26D764B8
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 18:41:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 181D9403D8
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 18:41:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oUkk9nnOeic2 for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 18:41:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 9B303400A2
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a01:4f8:231:482b::2"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:4f8:231:482b::2;
 helo=freeshell.de; envelope-from=e@freeshell.de; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=FGLVlTo6
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9B303400A2
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 18:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1793990458;
 bh=9CGIp6EmJ7gV4Yh5zKDD5Ms11wS10MzsKAx7A8fi3T0=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=FGLVlTo6jgSdUBjWGmNEp3TOM0U1l6iFhEj5YvtKp2iSn1zC0I+nynE/VTTbR1KWS
 ggT3Om9ZClRim3r6m6QBwJGx/u3yttp/upRQorcbXmR5L0VudL3sVDoFDPFasYB83w
 e1zPBvI/7VAB2pWUEKfh9x/fnlH8pnstKdTPF4/d3DywRpWanbgOiet7wOodCMPf21
 Dm5hGP22dqT1G/PF5nQ9s48t7Argl78EXy6fr6qC/YnPYf8wOJ2OH7cy29tiILDyd6
 sc9y15nVBoaSmdFodhcSfo7p+Lbyft8rBZAqIqz0U2I/2QmjPsx9y/msTweXf4Xrg4
 avptAIGQxvuCw==
Received: from [IPV6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc] (unknown
 [IPv6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id EC46FB22007F;
 Fri,  6 Nov 2026 19:40:56 +0100 (CET)
Message-ID: <79fdb1d0-c777-43c4-a7ea-98455186e900@freeshell.de>
Date: Fri, 6 Nov 2026 10:40:48 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] cmd: lwip: wget: write the download to a block device
To: Jerome Forissier <jerome.forissier@arm.com>, iav@iav.lv
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>, u-boot@lists.u-boot-project.org,
 nd@arm.com
References: <20261101-b4-wget-blk-r4-v1-0-e27a009e4043@iav.lv>
 <3bb5a9a4-ce05-45c8-9fc4-d4fe99b1b0c1@arm.com>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <3bb5a9a4-ce05-45c8-9fc4-d4fe99b1b0c1@arm.com>
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
X-Spam-Status: No, score=-21.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NUMERIC_HTTP_ADDR,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Jerome,

On 11/6/26 10:07, Jerome Forissier wrote:
>> wget can write a disk image only after the whole file is in RAM. This
>> series lets lwIP wget write the download to a block device while it
>> arrives:
>>
>>   => wget -o mmc 1 -b 400000 http://192.168.1.65/armbian.img
>>
>> The target is a whole device, a hardware partition, a partition by
>> number or name, and an optional byte offset into it.
>>
>> Patch 1 fixes the buffer size check for a reply without Content-Length;
>> patch 4 sets that check to the target size, and without the fix such a
>> reply would be refused. Patch 2 lets a wget client take the data
>> through a callback, patch 3 adds the block device writer, and patch 4
>> adds the options to the command.
>>
>> Tested:
>> - ROCK Pi 4A: a 1862270976-byte image to the SD card in 3 min 16 s to
>>   3 min 35 s with a 4 MiB buffer; the first 1862270976 bytes of the
>>   card have the sha256 of the image, and the card boots. A
>>   2936012800-byte image, past the Content-Length limit below, took
>>   4 min 18 s and checks and boots the same way.
>> - QEMU arm64, virtio-blk: a 404 writes nothing; a file larger than the
>>   target is refused before any write with Content-Length, and at the
>>   end of the target without it.
>> - sandbox: ut lib lib_test_sink_blk; every patch builds on sandbox and
>>   sandbox64_lwip.
>>
>> Notes:
>> - lwIP's http_client.c reads Content-Length through an int, so from
>>   2 GiB on the length is unknown and a file that does not fit fails
>>   only at the end of the target.
>> - EFI HTTP, the other user of check_buffer_size, retries with the
>>   reported length when it exceeds the buffer (efi_net.c:1715), so a
>>   reply without Content-Length still ends in a 4 GiB allocation there;
>>   patch 1 does not change that.
>> - checkpatch asks for IS_ENABLED() at "#if defined(CONFIG_WGET_STREAM)"
>>   in cmd/lwip/wget.c; that #if picks lines of the help string, as the
>>   WGET_CACERT ones next to it do.
>>
>> gzip and zstd input follow in a separate series on top of this one.
>>
>> Signed-off-by: Igor Velkov <iav@iav.lv>
>> ---
>> Igor Velkov (4):
>>       net: lwip: wget: accept a reply without Content-Length in the size check
>>       net: lwip: wget: hand the payload to an optional sink
>>       lib: add a stream sink for block devices
>>       cmd: lwip: wget: write the download to a block device
>>
>>  cmd/Kconfig                      |   9 ++
>>  cmd/lwip/wget.c                  | 107 +++++++++++++++++++++-
>>  configs/sandbox64_lwip_defconfig |   1 +
>>  configs/sandbox_defconfig        |   1 +
>>  doc/usage/cmd/wget.rst           |  43 ++++++++-
>>  include/net-common.h             |   6 ++
>>  include/stream_sink.h            |  75 ++++++++++++++++
>>  lib/Kconfig                      |   8 ++
>>  lib/Makefile                     |   1 +
>>  lib/stream_sink.c                | 189 +++++++++++++++++++++++++++++++++++++++
>>  net/lwip/wget.c                  |  89 +++++++++++++++---
>>  test/lib/Makefile                |   3 +
>>  test/lib/stream_sink.c           | 137 ++++++++++++++++++++++++++++
>>  13 files changed, 655 insertions(+), 14 deletions(-)
>> ---
>> base-commit: 3401e006432abcbf7d73d7210f10df157f990ed3
>> change-id: 20261101-b4-wget-blk-r4-833f8a3d344e
>>
>> Best regards,
> 
> Applied to u-boot-net branch for-main [1], thanks!
> 
> [1] https://git.u-boot-project.org/u-boot/custodians/u-boot-net/-/commits/for-main
> 
> [1/4] net: lwip: wget: accept a reply without Content-Length in the size check
>       commit: 8498fbf8788eff07bc7fc59f9b15cf6c65025b10
> 
> [2/4] net: lwip: wget: hand the payload to an optional sink
>       commit: 40611fe0277a7a8f9639aab02a6f1a1e0e897d57
> 
> [3/4] lib: add a stream sink for block devices
>       commit: fdf4d9621c8b507f69fe0dd09fc53ebfe860fda5
> 
> [4/4] cmd: lwip: wget: write the download to a block device
>       commit: f0870bb385cf923bfab0baddacc952151efa4c39
> 
> Best regards,

FYI stating my objection to making the wget command take these
arguments, it seems short sighted and not very U-Boot -like.

The functionality itself I have no objection to but including this
command line argument complexity now for 'wget' implies that scripts and
documentation will be built around this change and then we must maintain
that compatibility, which is a bad design choice in my opinion.

Respectfully,

-E
