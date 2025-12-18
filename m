Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7C2BD6ACE2
	for <u-boot@archiver.kernel.org>; Thu, 18 Dec 2025 11:01:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E3CF83D00;
	Thu, 18 Dec 2025 12:01:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="i/ly+le9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E539583D5D; Thu, 18 Dec 2025 12:01:05 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA26A83B2C
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 12:01:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id AF5C660123;
 Thu, 18 Dec 2025 11:01:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFCFDC4CEFB;
 Thu, 18 Dec 2025 11:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1766055662;
 bh=EEr0OiPTeFJNFY+GigMOkSZAV/sJdlwTs4JW/gexkyE=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=i/ly+le9Wm+yxD8Reumco0/6G5qhriBnnbpaSvEndtiG0cMz+a+QhP2L7LbshpEg5
 LJMBV2H6D5HS3HOp9QI8TUKEE8cP/s6a5QQSeLuKeRLCOgPn4P90y7ZmisVBGjH4C1
 EM1mzyHtExRNSotJ87ujcj/QZy9NLhvRNmhYc8ovyIfUNcfvEgK+R/FECe5ZZazXJx
 F9/Cq+Eben5ru1yzgEhBjW0BOMPUItpjJiBAkcx02yhCeSkwUcvSq+V1s5i6hwoMXC
 Vmrw4GlyvhxQaR1cA7kb95UzC4KAXAulhtMjAa5BUUex48+56qcncaoZlV2wzXoIgG
 mEkycNUNgeiZw==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Quentin Schulz <foss+uboot@0leil.net>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Jerome Forissier <jerome.forissier@linaro.org>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, David Lechner <dlechner@baylibre.com>, Quentin
 Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH] doc: pytest: fix typo in multiple config options
 example for buildconfigspec
In-Reply-To: <20251217-doc-pytest-lwip-v1-1-bdcaa59d4154@cherry.de>
References: <20251217-doc-pytest-lwip-v1-1-bdcaa59d4154@cherry.de>
Date: Thu, 18 Dec 2025 12:00:59 +0100
Message-ID: <87cy4ccavo.fsf@kernel.org>
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

Hi Quentin,

Thank you for the patch.

On Wed, Dec 17, 2025 at 15:02, Quentin Schulz <foss+uboot@0leil.net> wrote:

> From: Quentin Schulz <quentin.schulz@cherry.de>
>
> The option should be 'net_lwip' and not 'net lwip' (see all usage of it
> in the test code base).
>
> Fixes: 2bac578c5aba ("test: allow multiple config options in buildconfigspec")
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
>  doc/develop/pytest/usage.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/doc/develop/pytest/usage.rst b/doc/develop/pytest/usage.rst
> index df3821da20d..924bc185b51 100644
> --- a/doc/develop/pytest/usage.rst
> +++ b/doc/develop/pytest/usage.rst
> @@ -546,7 +546,7 @@ either of ``CONFIG_NET`` or ``CONFIG_NET_LWIP`` is set:
>  
>  .. code-block:: python
>  
> -    @pytest.mark.buildconfigspec('net', 'net lwip')
> +    @pytest.mark.buildconfigspec('net', 'net_lwip')
>  
>  The ``notbuildconfigspec()`` annotation can be used to require a configuration
>  option not to be set. The following annotation requires ``CONFIG_RISCV=n``:
>
> ---
> base-commit: 47b50fb1125c539d80ed3e7f739c02c6486e1b52
> change-id: 20251217-doc-pytest-lwip-9a34f21454c9
>
> Best regards,
> -- 
> Quentin Schulz <quentin.schulz@cherry.de>
