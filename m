Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20DA5D116F3
	for <u-boot@archiver.kernel.org>; Fri, 28 Nov 2025 11:04:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A0A584500;
	Fri, 28 Nov 2025 12:04:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="cSp/7/YC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE5D484502; Fri, 28 Nov 2025 12:04:14 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 796F5844FD
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 12:04:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id B142A440B1;
 Fri, 28 Nov 2025 11:04:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AAF1C4CEF1;
 Fri, 28 Nov 2025 11:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1764327850;
 bh=hyQG5lKgW490eboTozhXYzPN+GmiZURLLkV6MiKYm7g=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=cSp/7/YCXgxiVSt3QCrkd+jkT4r+vngto/FBmjkn0dTls0oUZNhwYxzlmzoLjd6fj
 Ra4mIjLWaNpcmcuDPvak514BPaTYBz+px7tTLasyTPUkLVIQ1uZqUOPxia9Vq/hcd0
 HfG6VPoAiyjVJl8+Pu3wBV8Zq0R8hNrQU7deKlbHNcexGIO0nRrlx3Mws2zYRdbNep
 ntC0PlylqfBETauulREYEX8pj4n2xoev7rxcbrycGxNB4mVw6aSnYB1m9pPPd0zhVo
 /7PwAQvaOhs/zn0QNHn2/10pWrGHvtP3GCcfB42Z+qdCbIa5sWZnrwd8G8fNRALcTF
 oJsofNTrgDqjQ==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, Bin Meng
 <bmeng.cn@gmail.com>, Marek Vasut <marex@denx.de>
Cc: Andre Przywara <andre.przywara@arm.com>, Simon Glass <sjg@chromium.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Love Kumar <love.kumar@amd.com>,
 u-boot@lists.denx.de, Heinrich Schuchardt
 <heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH 1/1] usb: xhci: avoid noisy 'Starting the controller'
 message.
In-Reply-To: <20251128064647.12162-1-heinrich.schuchardt@canonical.com>
References: <20251128064647.12162-1-heinrich.schuchardt@canonical.com>
Date: Fri, 28 Nov 2025 12:04:06 +0100
Message-ID: <877bvas9jt.fsf@kernel.org>
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

Hi Heinrich,

Thank you for the patch.

On Fri, Nov 28, 2025 at 07:46, Heinrich Schuchardt <heinrich.schuchardt@canonical.com> wrote:

> We should avoid overwhelming users with non-essential messages.
>
> The message 'Starting the controller' is not written for EHCI.
> We should not write it for XHCI either.
>
> Adjust the Python test accordingly.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
>  drivers/usb/host/xhci.c   | 2 +-
>  test/py/tests/test_usb.py | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
