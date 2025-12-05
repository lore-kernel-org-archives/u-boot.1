Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3262D3398B
	for <u-boot@archiver.kernel.org>; Fri,  5 Dec 2025 16:22:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0587984056;
	Fri,  5 Dec 2025 17:22:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Rh4vfPcN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7FE078421E; Fri,  5 Dec 2025 17:22:41 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A4E18404A
 for <u-boot@lists.denx.de>; Fri,  5 Dec 2025 17:22:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id A50E644004;
 Fri,  5 Dec 2025 16:22:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C983C4CEF1;
 Fri,  5 Dec 2025 16:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1764951757;
 bh=Jz9Mytt6li6gZ4t1zPTdSt3LTk/FJKoiw+ynEdcQfpU=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=Rh4vfPcNf4dKo97tWgk7Ijrlw0ov1huBbog5fe2vN01OG/8wLrGf2Vcon6f5bBQ+J
 8ZIYsFXdmUpNP/jO5xg4Jvx8fxoLdkAikiDwHdrPsRXVxppZdJM8TPL2VAlF+HQuRe
 VwvLagYdWlfLgaWiim1E8MqOy79HDlT1NwPkeKZc9V5qxLXNxXrWk4eK6drMsdtbc6
 nxkkz9a9aqGNMyUC+4cv7yzgH3NeFseCY3rRtJQxkqmzwOUnkxWE/bz+X2dXNLs8nR
 leiQY4TZsQWTmraXwWoZwzaMPxtHGrM21I52zvD778sU1xWdFe5TVbt2WVp3Jhr7Ka
 HtWrnXCkmIdDQ==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Aaron Kling <webgeek1234@gmail.com>, Eddie Kovsky <ekovsky@redhat.com>, 
 George Chan <gchan9527@gmail.com>, Julien Masson <jmasson@baylibre.com>, 
 Nicolas Belin <nbelin@baylibre.com>, Sam Day <me@samcday.com>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
In-Reply-To: <20251119193311.127633-1-marek.vasut+renesas@mailbox.org>
References: <20251119193311.127633-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH v3 1/2] boot: android: Always use 8-byte aligned DT
 with libfdt
Message-Id: <176495175488.66630.16033316142063703580.b4-ty@kernel.org>
Date: Fri, 05 Dec 2025 17:22:34 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

Hi,

On Wed, 19 Nov 2025 20:32:51 +0100, Marek Vasut wrote:
> Newer versions of libfdt strictly check whether the FDT blob
> passed to them is at 8-byte aligned offset, if it is not, then
> the library fails checks with -FDT_ERR_ALIGNMENT . Currently,
> android_image_print_dtb_contents() passed FDT directly mapped
> from abootimg to libfdt, and this FDT is not always aligned to
> 8-byte offset. Specifically, the FDTs are somewhat packed in
> the abootimg, therefore if the first FDT blob is e.g. 0xfd bytes
> long, then the next FDT blob ends up at 0xfd offset, which is
> not 8-byte aligned.
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-dfu (u-boot-dfu-next)

[1/2] boot: android: Always use 8-byte aligned DT with libfdt
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/2da3af2f9ee0dbacaf26e95e1ae5261445f1a43c
[2/2] test/py: android: Point fdt command to aligned addresses
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/42ee514ed049d5e689e39bb4a8b6b5fb519aa3be

--
Mattijs
