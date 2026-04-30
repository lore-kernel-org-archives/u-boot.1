Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E796CD13D3
	for <u-boot@archiver.kernel.org>; Thu, 30 Apr 2026 07:54:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9765E84255;
	Thu, 30 Apr 2026 09:54:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JvOvCygd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EEFD7845C8; Thu, 30 Apr 2026 09:54:39 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9CFE84198
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 09:54:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 36D9D4391B;
 Thu, 30 Apr 2026 07:54:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A6A9C2BCB3;
 Thu, 30 Apr 2026 07:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777535676;
 bh=qlAoV6V7+JIUog1ZjGZn5CWWDtKNiJxlaJbs3t+O79A=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=JvOvCygd/VpDgN+dWThxBb6mKqW+1xPS7/GqlnKMSJePbeHx6FTeLuRblRRvL2uEU
 RrKcWjoCRfDfPhWZ0tUFg8ahBEOtoSFgKLFNpD5eYIsxN0iOxb7UUjwHHv3LccrxNC
 2K1y7U9FUA+fKQTt8vZNng171ljB/7AdXlh+q+Rwga00y4/DkPbj4yB4SABCJoboBu
 m1VrA8Z4GaWJqVu0IL07DaiexvJg1ea5fykdFBtGAK0aUsxXhp9yccP5LGDUpMR4n+
 FuaOpC6ZZdarogVHp4hADkXif9pzwjlUbRRVhKnq9HdvFeuGip3Wj6AK56M6xbKOGJ
 QNVS5kbBTtF3A==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Eddie Kovsky <ekovsky@redhat.com>, Tom Rini <trini@konsulko.com>, Tobias
 Olausson <tobias@eub.se>, Paul HENRYS <paul.henrys_ext@softathome.com>,
 Simon Glass <sjg@chromium.org>, Jan Stancek <jstancek@redhat.com>, Enric
 Balletbo i Serra <eballetb@redhat.com>, a.fatoum@pengutronix.de,
 mark.kettenis@xs4all.nl, Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH v4] Add support for OpenSSL Provider API
In-Reply-To: <20260429180247.83091-1-ekovsky@redhat.com>
References: <20260429180247.83091-1-ekovsky@redhat.com>
Date: Thu, 30 Apr 2026 09:54:33 +0200
Message-ID: <87cxzgevd2.fsf@kernel.org>
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

Hi Eddie,

Thank you for the patch.

On Wed, Apr 29, 2026 at 12:02, Eddie Kovsky <ekovsky@redhat.com> wrote:

> The Engine API has been deprecated since the release of OpenSSL 3.0. End
> users have been advised to migrate to the new Provider interface.
> Several distributions have already removed support for engines, which is
> preventing U-Boot from being compiled in those environments.
>
> Add support for the Provider API while continuing to support the existing
> Engine API on distros shipping older releases of OpenSSL.
>
> This is based on similar work contributed by Jan Stancek updating Linux
> to use the Provider interface.
>
>     commit 558bdc45dfb2669e1741384a0c80be9c82fa052c
>     Author: Jan Stancek <jstancek@redhat.com>
>     Date:   Fri Sep 20 19:52:48 2024 +0300
>
>         sign-file,extract-cert: use pkcs11 provider for OPENSSL MAJOR >= 3
>
> The changes have been tested with the FIT signature verification vboot
> tests on Fedora 42 and Debian 13. All 30 tests pass with both the legacy
> Engine library installed and with the Provider API.
>
> Tested-by Enric Balletbo i Serra <eballetb@redhat.com>
> Tested-by Mark Kettenis <mark.kettenis@xs4all.nl>
> Signed-off-by: Eddie Kovsky <ekovsky@redhat.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
