Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC084C2D0CD
	for <u-boot@archiver.kernel.org>; Wed, 21 May 2025 14:49:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 51A9282EC6;
	Wed, 21 May 2025 16:49:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="rIAyb3/X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E6BA282F03; Wed, 21 May 2025 16:49:41 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74B9982E66
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 16:49:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 05ED66111C;
 Wed, 21 May 2025 14:49:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C4A4C4CEE4;
 Wed, 21 May 2025 14:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1747838977;
 bh=VKNNtreIcpC1yI/23Nw5UIkpB0cbg8TU8R295QUnMIM=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=rIAyb3/XD7NQhUgC8QPfW5NN8JdyE7KPLd2/BGLMbHgkW+FkFyrpGVDq3AGC5wj4V
 RQ5wdD2QmVSpCsedY+aofxfIYNKodi40BTVArOsVET9tnBJG167/YFcTStIqNppvuB
 5CeM25NZ+yHqIWuudptXdXR9QLpjg5BJ1svZFP1Cl3qcfR5sZIOGlCl1ZXYkbiC9IW
 LWey/IA3a8ZWQDu1AhS21bFGSPa9f2Qahn7fnC4pu8+N+Ht9u98fh0Q9r9Q+zjAAla
 oQsC9R8IbeKhtR70y0sJhPZmvyCXMq87ueBxhQkXnprq9/vlcbIApxQX49p7HwI+Wb
 9VSfloRz4QRMA==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Mattijs Korpershoek <mkorpershoek@kernel.org>, Tom Rini
 <trini@konsulko.com>, neil.armstrong@linaro.org
Cc: u-boot@lists.denx.de, Dmitrii Merkurev <dimorinny@google.com>
Subject: Re: [PATCH RFT v3 0/3] fastboot: add support for generic block
 flashing
In-Reply-To: <174774092427.332438.8643753165301653831.b4-ty@kernel.org>
References: <20250506-topic-fastboot-blk-v3-0-d94be5829f46@linaro.org>
 <174774092427.332438.8643753165301653831.b4-ty@kernel.org>
Date: Wed, 21 May 2025 16:49:35 +0200
Message-ID: <87zff6nhmo.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Neil,

On mar., mai 20, 2025 at 13:35, Mattijs Korpershoek <mkorpershoek@kernel.org> wrote:

> Hi,
>
> On Tue, 06 May 2025 18:10:06 +0200, neil.armstrong@linaro.org wrote:
>> This serie permits using any block device as target
>> for fastboot by moving the generic block logic into
>> a common set of helpers and also use them as generic
>> backend.
>> 
>> The erase logic has been extended to support software
>> erase since only 2 block drivers exposes the erase
>> operation.
>> 
>> [...]
>
> Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-dfu (u-boot-dfu-next)
>
> [1/3] fastboot: blk: introduce fastboot block flashing support
>       https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/88239b5bb04bea2b58f7bf4c3ea72cf832de818c
> [2/3] fastboot: blk: switch emmc to use the block helpers
>       https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/25ab5c32c28b9f25fb193f726f239d75af3c365a
> [3/3] fastboot: integrate block flashing back-end
>       https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/a885bd8c969e25d03bf406207d89b1145c9490fb

It seems this series cause CI to fail:
https://source.denx.de/u-boot/custodians/u-boot-dfu/-/pipelines/26238

Without the patches applied, it passes:
https://source.denx.de/u-boot/custodians/u-boot-dfu/-/pipelines/26235

Do you have any idea what is going wrong?
I could not find anything obvious by skimming through the logs.

>
> --
> Mattijs
