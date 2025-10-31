Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12640CCFA00
	for <u-boot@archiver.kernel.org>; Fri, 31 Oct 2025 16:14:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C51883A1A;
	Fri, 31 Oct 2025 17:14:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Pb0DqH2J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0BB3C83A07; Fri, 31 Oct 2025 17:14:06 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE87C839CA
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 17:14:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 3F27843F98;
 Fri, 31 Oct 2025 16:14:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 899AAC4CEE7;
 Fri, 31 Oct 2025 16:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1761927242;
 bh=S3z3cCJ6uH+XOybucNgmHukxs7cuiL2v3IBMrsBz7CI=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=Pb0DqH2JMjIZy3toZl6GjJV2ryjEi0hN5aHKgR60Z4+uVvOQ//bXWF1FGh2XH0WWW
 Jlm4NfDw+GTAEE8FuFqRapqpl7IGo7g1u46Pe5+3xszdxmMY+i6m5LGB12uvG3e2sn
 IlqTC88R/hp8V2GKeCeM5y55tqJtXYJOJ5hGLFmSVhwgxcL6RnT5H7M1JJ/xj0zAgB
 EAyhRfx/EoqrB+K2ZUN1vEGVgVNUwFcZaa3t/ni0CeM3U6LJsbmEyuHlYKolgvxeY9
 5bWdRXg5s0PSHCX18mqccZNx4cbpIDYYr7LUx3stZbpfud9RrgKvCGgd3BLsqj0upT
 X2RHsSwaRpbFw==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: "Guillaume La Roque (TI.com)" <glaroque@baylibre.com>, Tom Rini
 <trini@konsulko.com>, Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Julien Masson <jmasson@baylibre.com>, Guillaume La Roque
 <glaroque@baylibre.com>, u-boot@lists.denx.de, Simon Glass
 <sjg@chromium.org>, Nicolas Belin <nbelin@baylibre.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Andrew Goodbody <andrew.goodbody@linaro.org>,
 Aaron Kling <webgeek1234@gmail.com>, George Chan <gchan9527@gmail.com>,
 Sam Day <me@samcday.com>, Jerome Forissier <jerome.forissier@linaro.org>,
 Maxime Fournier <mfournier@baylibre.com>
Subject: Re: [PATCH v2 4/5] cmd: abootimg: Add 'get ramdisk' command
In-Reply-To: <20251017-bootconfig-v2-4-8c7c2f2e5474@baylibre.com>
References: <20251017-bootconfig-v2-0-8c7c2f2e5474@baylibre.com>
 <20251017-bootconfig-v2-4-8c7c2f2e5474@baylibre.com>
Date: Fri, 31 Oct 2025 17:13:57 +0100
Message-ID: <87a51759ru.fsf@kernel.org>
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

Hi Guillaume,

Thank you for the patch.

On Fri, Oct 17, 2025 at 15:19, "Guillaume La Roque (TI.com)" <glaroque@baylibre.com> wrote:

> Add support for retrieving ramdisk address and size from Android boot
> images. This command allows users to extract the ramdisk information
> for boot image v3+ which combines vendor ramdisk, boot ramdisk and
> bootconfig sections.
>
> Signed-off-by: Guillaume La Roque (TI.com) <glaroque@baylibre.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
> 2.34.1
