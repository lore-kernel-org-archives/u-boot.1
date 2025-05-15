Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87F3AC3ABC9
	for <u-boot@archiver.kernel.org>; Thu, 15 May 2025 08:02:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C12ED82AD2;
	Thu, 15 May 2025 10:01:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bIcsZenB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E2CBA82B19; Thu, 15 May 2025 10:01:58 +0200 (CEST)
Received: from nyc.source.kernel.org (nyc.source.kernel.org
 [IPv6:2604:1380:45d1:ec00::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4C4F8288D
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 10:01:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id C6EFAA4D5EA;
 Thu, 15 May 2025 08:01:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4111EC4CEE7;
 Thu, 15 May 2025 08:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1747296115;
 bh=u1d4EMzUR9sGwYYCqEt0JDT8mOoyJCQyEGC/vFEwWDU=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=bIcsZenBSRSTqz6hoNBMQzotvt3HtWrjUwfUfAJ62w84DPL/ByLo5xTErCz0rSSm2
 NMurDNN8Q/9Ob1EJ32+Sa3yelvahjvjrP9Muz7EqL2/qZsGqZaDz8tVEO3sydJ40m/
 CCM11k5SY7NK5F/oZNgfQ+AKWcoAxUX1wJa4OhunlUwPsYPql5V2fTVvn39/P9AS0S
 HPbL/n2rMi0DWMMV5oSdLrD/rKDghvIGkMa26kKrSZ1RsefwAgCD8g4QftAV4nl/R2
 f6crdWMBmxa4xFG2tP/50C7fcmWNNImiJ4i5mwvn98U5nEiseBt656/sNrtYn/2GDf
 bglBJuYUV9EvA==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Anatolij Gustschin <agust@denx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>,
 Jerome Forissier <jerome.forissier@linaro.org>, Linus Walleij
 <linus.walleij@linaro.org>, Lukasz Majewski <lukma@denx.de>, Marek Vasut
 <marex@denx.de>, Mark Kettenis <kettenis@openbsd.org>, Masahisa Kojima
 <kojima.masahisa@socionext.com>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, Rayagonda Kokatanur
 <rayagonda.kokatanur@broadcom.com>, Simon Glass <sjg@chromium.org>, Simon
 Goldschmidt <simon.k.r.goldschmidt@gmail.com>, Stefan Bosch
 <stefan_b@posteo.net>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Tingting Meng <tingting.meng@altera.com>, Tobias Waldekranz
 <tobias@waldekranz.com>
Subject: Re: [PATCH 4/5] global: Avoid indirect inclusion of <env.h> from
 <command.h>
In-Reply-To: <20250514225002.15361-5-trini@konsulko.com>
References: <20250514225002.15361-1-trini@konsulko.com>
 <20250514225002.15361-5-trini@konsulko.com>
Date: Thu, 15 May 2025 10:01:50 +0200
Message-ID: <87a57e5mkx.fsf@kernel.org>
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

Hi Tom,

Thank you for the patch.

On Wed, May 14, 2025 at 16:46, Tom Rini <trini@konsulko.com> wrote:

> The include file <command.h> does not need anything from <env.h>.
> Furthermore, include/env.h itself includes other headers which can lead
> to longer indirect inclusion paths. To prepare to remove <env.h> from
> <command.h> fix all of the places which had relied on this indirect
> inclusion to instead include <env.h> directly.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org> # android, bcb

> ---
