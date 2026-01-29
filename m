Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA385D6B087
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 16:26:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5972F8401A;
	Thu, 29 Jan 2026 17:26:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="m5jgyzAb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7E7884021; Thu, 29 Jan 2026 17:26:20 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D92C83B64
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 17:26:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 1FC5A60126;
 Thu, 29 Jan 2026 16:26:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59D63C4CEF7;
 Thu, 29 Jan 2026 16:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1769703976;
 bh=KkDGO6oG385M2IBFUAaZk6NR0swM9o6zfLx6lMx8fVg=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=m5jgyzAbqy4+4doRkPk320PEAJsJ8Fum4gtE0C2Ao56vhRgfN/zOSlBLLm6VctOB5
 FkzkD+CfMDv+tBJp0JRhnrLgsKiblOlYjPD0BmJVm2LpajUS3EQ6KIEYbPplGSnk8p
 g+JbMdQAYUNHo3ZG94JwEWGZWxKcdjWUDDnJbkHymJKn7rI7rPYrjrdgZGbvCtn8uq
 03nrVfZaWWROBX8Ye1eLZYPXMSwoZCV5k2Y+uY/z/hR74jNkixnPze4b/kS7oKV5vr
 TKSM7Q9h5S0AXz4tQu6aEpg4liT7gd43QLrylQVJGL7oeFzKi3SBsLQeLb+witEZiT
 xpgQMfmhgGeKA==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, Alexander Graf
 <agraf@csgraf.de>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, Jerome Forissier
 <jerome@forissier.org>, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Yuya Hamamachi
 <yuya.hamamachi.sx@renesas.com>
Subject: Re: [PATCH 3/3] test: cmd: Add test for zip/unzip/gzwrite commands
In-Reply-To: <20260127235914.1503663-3-marek.vasut+renesas@mailbox.org>
References: <20260127235914.1503663-1-marek.vasut+renesas@mailbox.org>
 <20260127235914.1503663-3-marek.vasut+renesas@mailbox.org>
Date: Thu, 29 Jan 2026 17:26:14 +0100
Message-ID: <87qzr8mlll.fsf@kernel.org>
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

Hi Marek,

Thank you for the patch.

On Wed, Jan 28, 2026 at 00:57, Marek Vasut <marek.vasut+renesas@mailbox.org> wrote:

> Add simple test for zip/unzip/gzwrite commands. The test works as
> follows. First, create three buffers with a bit of space between
> each of them, fill them with random data, then compress data in
> buffer 1 into buffer 2, decompress data in buffer 2 either directly
> into buffer 3 or into MMC 1 and then read them back into buffer 3,
> and finally compare buffer 1 and buffer 3, they have to be identical.
>
> The buffers are filled with random data to detect out of bounds writes.
> Test for various sizes, both small and large and unaligned.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

I've tested this with

$ ./test/py/test.py --bd sandbox --build -k ut

Followed by:

$ ./test/py/test.py --bd sandbox --build -k cmd_zip

And I see:

FAILED test/py/tests/test_ut.py::test_ut[ut_dm_dm_test_cmd_zip_gzwrite] - ValueError: U-Boot exited with signal 11 (SIGSEGV)
FAILED test/py/tests/test_ut.py::test_ut[ut_dm_dm_test_cmd_zip_unzip] - ValueError: U-Boot exited with signal 11 (SIGSEGV)

The full logs are available here:
https://paste.debian.net/hidden/704e0be8

(note that the version is reported as dirty because I added a small to
diff to fix the compile issue I reported in [1])

[1] https://lore.kernel.org/all/87wm10mm0g.fsf@kernel.org/

> ---
> Cc: Alexander Graf <agraf@csgraf.de>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Jerome Forissier <jerome@forissier.org>
> Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: Peng Fan <peng.fan@nxp.com>
> Cc: Quentin Schulz <quentin.schulz@cherry.de>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>
> Cc: u-boot@lists.denx.de
> ---
