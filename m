Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 691E5CF64AB
	for <u-boot@archiver.kernel.org>; Thu, 20 Nov 2025 09:39:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF45683D3C;
	Thu, 20 Nov 2025 10:39:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QEvUgKFy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64FE483D3C; Thu, 20 Nov 2025 10:39:04 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3F8F8405B
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 10:39:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 41BBB4033F;
 Thu, 20 Nov 2025 09:38:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD095C4CEF1;
 Thu, 20 Nov 2025 09:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1763631539;
 bh=QHnPu9MMjHlRNNq1+AllXxs9UcaSqWLHBLM5Z0sREsQ=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=QEvUgKFyWDaLzD6kf/x1cnxQQFgOliCGVsL3H9wkJ7qbiD2v0lIupp6TTq6lDHGug
 RCMfTfheCdno0d2WhMH+j34gcw7gmWsn0nRTYSHFfrE2+n+0xoRiHJ0h8ly/wuDfl4
 yabKhXwtZUWG4O+2rNHGhGpAqV2QL6cxyIrdfWQmLfJmi+IdNA1Lkfep58HFvWbr/L
 mrxVozysuFmhDKsVJUTnyaMDcOi5eqehZPjYNmJqJJHCiTmNgAQTUS7+HNVYy9ckt2
 A5frCOYN/XLZxqA2tFgD7bVnbkakthZf21rRn+tqDu4Nro8cpGPx+H5qFvSDAJ7l3V
 GEFO1KEQ9CWGg==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, Aaron Kling
 <webgeek1234@gmail.com>, Eddie Kovsky <ekovsky@redhat.com>, George Chan
 <gchan9527@gmail.com>, Julien Masson <jmasson@baylibre.com>, Mattijs
 Korpershoek <mkorpershoek@kernel.org>, Nicolas Belin
 <nbelin@baylibre.com>, Sam Day <me@samcday.com>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v3 1/2] boot: android: Always use 8-byte aligned DT with
 libfdt
In-Reply-To: <20251119193311.127633-1-marek.vasut+renesas@mailbox.org>
References: <20251119193311.127633-1-marek.vasut+renesas@mailbox.org>
Date: Thu, 20 Nov 2025 10:38:56 +0100
Message-ID: <87fra9avrj.fsf@kernel.org>
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

On Wed, Nov 19, 2025 at 20:32, Marek Vasut <marek.vasut+renesas@mailbox.org> wrote:

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
> Fix this by first extracting the header into 8-byte aligned buffer,
> checking only the header for validity, and then by copying the
> entire FDT into newly allocated 8-byte aligned buffer. While this
> is not efficient, it is the correct way to handle DTs, which must
> be at 8-byte aligned offsets. Mitigate the inefficiency for the
> common case by checking whether the DT might be 8-byte aligned and
> if it is, map it directly.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
