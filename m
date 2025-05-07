Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B8ABC3ABC0
	for <u-boot@archiver.kernel.org>; Wed,  7 May 2025 10:05:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6B5A81F32;
	Wed,  7 May 2025 12:05:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="EBdKRhIu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 115BF8212F; Wed,  7 May 2025 12:05:32 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 036998007D
 for <u-boot@lists.denx.de>; Wed,  7 May 2025 12:05:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 50F9143DBF;
 Wed,  7 May 2025 10:05:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B44CBC4CEE7;
 Wed,  7 May 2025 10:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1746612328;
 bh=SpN+syhaZLt4fZPwlPvig3inuXjhu3CzdWWIlRIrP/Q=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=EBdKRhIu5QCzGzjiW+DgJ0KjI2PkBmJmUilgK8GQ7qvlBp7dKspbJRKB4vYkW1faJ
 mKJQzHbZkwvdUen/kHoZH1q4Ly08KhP5eP4+h+RF1RIHBmUerkdcViJ7wl4ObqUdaV
 8a2SRtmBTn+c11vMftAmU2AyPeMG7rDlhWZSwXM6FWO1z6roi8ICIz18sfQj10qT7V
 69Uez19DxYvZCWZkQnbkfF3NySjVVpR6lm64PIcCSU8ymvmJ5emfdWgyWlAuDezkQl
 v8hhfdEhjjVUj4vzv5xiYJAKjoetJo9/9iblMbItrZEJG1SOqIgJBFHtuaIcjoS444
 YyKfmh9NLzBjA==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: neil.armstrong@linaro.org, Tom Rini <trini@konsulko.com>, Mattijs
 Korpershoek <mkorpershoek@kernel.org>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>
Cc: u-boot@lists.denx.de, Neil Armstrong <neil.armstrong@linaro.org>,
 Dmitrii Merkurev <dimorinny@google.com>
Subject: Re: [PATCH RFT v3 1/3] fastboot: blk: introduce fastboot block
 flashing support
In-Reply-To: <20250506-topic-fastboot-blk-v3-1-d94be5829f46@linaro.org>
References: <20250506-topic-fastboot-blk-v3-0-d94be5829f46@linaro.org>
 <20250506-topic-fastboot-blk-v3-1-d94be5829f46@linaro.org>
Date: Wed, 07 May 2025 12:05:25 +0200
Message-ID: <87ldr8ag7u.fsf@kernel.org>
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

Thank you for the patch.

On mar., mai 06, 2025 at 18:10, neil.armstrong@linaro.org wrote:

> From: Dmitrii Merkurev <dimorinny@google.com>
>
> Introduce fastboot block flashing functions and helpers
> to be shared with the MMC implementation.
>
> The write logic comes from the mmc implementation, while
> the partition lookup is much simpler and could be extended.
>
> For the erase logic, allmost no block drivers exposes the
> erase operation, except mmc & virtio, so in order to allow
> erasiong any partition a soft-erase logic has been added

s/erasiong/erasing

I can fixup when applying.

> to write zero-ed buffers in a loop.
>
> Signed-off-by: Dmitrii Merkurev <dimorinny@google.com>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
