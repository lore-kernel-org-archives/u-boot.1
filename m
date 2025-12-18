Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF166D6ACE5
	for <u-boot@archiver.kernel.org>; Thu, 18 Dec 2025 10:59:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A2C483B21;
	Thu, 18 Dec 2025 11:59:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="J7Nq38bF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4BDC383C54; Thu, 18 Dec 2025 11:59:37 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E833383936
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 11:59:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 36B2143B32;
 Thu, 18 Dec 2025 10:59:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0D32C4CEFB;
 Thu, 18 Dec 2025 10:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1766055573;
 bh=bL9p3x1nwW8kEVfomKWPC0iB7+P5WrXPgk3jHpxClLU=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=J7Nq38bFeOuOpVeT0qY5J/RQjxeKHaRFgaP5MkQT2OQGdrJZHBdK4kCGresMvjJ9j
 jLZDfPOyF0kuS6m4ESZutIy+5L4ItZSuMCV8coY/o/wMpD05YxeVabgJwNPg7FlH/E
 jnF2vKzmkDTYvYG99FE3SBJ9EYwUwaCC/2nB4qGtlEQytDSM77+1ST/xkho/zg7o6w
 fAHIiEWdLGYzLk0CWNayhYUzIKx82npj7vm2DYd0jb1V3xgDkBetR5Mr1SjJa7SxWl
 uIkWiGckPbyyJDQILOcfIQMiPB8WMTrA38/c8DQVJNKfDdpKI/UjRolR5n5FnMTfRd
 xIZhrJxPtY2fg==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: David Lechner <dlechner@baylibre.com>, Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marex@denx.de>, Simon Glass <sjg@chromium.org>, Mattijs
 Korpershoek <mkorpershoek@kernel.org>, Jerome Forissier
 <jerome.forissier@linaro.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, David
 Lechner <dlechner@baylibre.com>
Subject: Re: [PATCH v2 0/3] a few test.py improvements
In-Reply-To: <20251217-a-few-test-py-improvements-v2-0-e1f91e3bf551@baylibre.com>
References: <20251217-a-few-test-py-improvements-v2-0-e1f91e3bf551@baylibre.com>
Date: Thu, 18 Dec 2025 11:59:30 +0100
Message-ID: <87fr98cay5.fsf@kernel.org>
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

Hi David,

Thank you for the series

On Wed, Dec 17, 2025 at 12:42, David Lechner <dlechner@baylibre.com> wrote:

> While trying to run the test suite for the first time, I encountered a
> few minor issues. Here are a few patches to address them.
>
> ---
> Changes in v2:
> - Dropped patch adding setuptools to test/py/requirements.txt
> - New patch to add setuptools to scripts/dtc/pylibfdt/requirements.txt
>   instead.
> - Changed test.py patch to set ubconfig to None rather than checking for
>   its existence in globals().
> - Link to v1: https://lore.kernel.org/r/20251121-a-few-test-py-improvements-v1-0-bacb4148fb0d@baylibre.com

Tested on a fresh fedora container with:

$ python -m venv venv
$ source venv/bin/activate
$ pip install -r test/py/requirements.txt
$ pip install -r scripts/dtc/pylibfdt/requirements.txt

Then I could build and test with:

$ ./test/py/test.py --bd sandbox --build -k ut

Tested-by: Mattijs Korpershoek <mkorpershoek@kernel.org> # sandbox

Also, all patches look good to me, so:

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

>
> ---
> David Lechner (3):
>       test.py: check ubconfig exists before using it
>       doc: pytest: mention additional requirements for venv
>       pylibfdt: add requirements.txt for setuptools
>
>  doc/develop/pytest/usage.rst          | 4 ++++
>  scripts/dtc/pylibfdt/requirements.txt | 1 +
>  test/py/conftest.py                   | 5 +++--
>  3 files changed, 8 insertions(+), 2 deletions(-)
> ---
> base-commit: a333d9e59f6675c9541c34643f334dbf50898647
> change-id: 20251121-a-few-test-py-improvements-b91babfc3e05
>
> Best regards,
> -- 
> David Lechner <dlechner@baylibre.com>
