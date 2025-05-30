Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6036EC54F30
	for <u-boot@archiver.kernel.org>; Fri, 30 May 2025 07:10:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7AECD830D9;
	Fri, 30 May 2025 09:10:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KygKWacW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 389C4830EA; Fri, 30 May 2025 09:10:00 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0125F8309A
 for <u-boot@lists.denx.de>; Fri, 30 May 2025 09:09:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 4934749CD7;
 Fri, 30 May 2025 07:09:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0271C4CEE9;
 Fri, 30 May 2025 07:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1748588996;
 bh=rCTX/j8JEUTak4SUwIiWV8bwA1kc4vCJ4EHFCM28fp0=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=KygKWacWMGqnQPmccrm9QLF0yQ2SPS1y2M5vMpQiyCIhPsXIte/BRoA5fO40hV0ib
 46XMgsVJN9yQorMGeIUq+fWDoeW5dmEekBXFP6rOEmUoTin2z6qCG4yMT0iSarrBxU
 fF0eJ/OEthiBn5e87d0PJG/KLqaxwViMYmwspAjzKXaOWewnY/vVehLuoLG9hmKlng
 ujPeUz1GCShCG7mvfm2ZgJ0IE/FBl8UDiyptlXv5G0007VExY4xQi5MIydmT4gLQHK
 2srCPZmL2QVlmwWrU4mR4Nw4OzizXHvIZJz2UPM8vklrmyqyR3DtVVZjiI8oHshlXE
 ibxg8acLX7aIQ==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Stephen Warren
 <swarren@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>, Tom Rini
 <trini@konsulko.com>
Subject: Re: [PATCH 1/2] test/py: Use the correct fixture name in exception
 handler
In-Reply-To: <20250529141500.2123363-1-sjg@chromium.org>
References: <20250529141500.2123363-1-sjg@chromium.org>
Date: Fri, 30 May 2025 09:09:54 +0200
Message-ID: <87plfqpoal.fsf@kernel.org>
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

Hi Simon,

Thank you for the patch.

On jeu., mai 29, 2025 at 08:14, Simon Glass <sjg@chromium.org> wrote:

> If a BootFail exception is thrown in a test, it is not handled
> correctly. Use the correct fixture variable 'ubman_fix' to resolve this.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Fixes: d9ed4b75add ("test/py: Drop u_boot_ prefix on test files")

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
>
>  test/py/conftest.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/test/py/conftest.py b/test/py/conftest.py
> index 6c3ac67979a..eec0b5488e4 100644
> --- a/test/py/conftest.py
> +++ b/test/py/conftest.py
> @@ -514,7 +514,7 @@ def ubman(request):
>          handle_exception(ubconfig, ubman_fix, log, err, 'Lab timeout', True)
>      except BootFail as err:
>          handle_exception(ubconfig, ubman_fix, log, err, 'Boot fail', True,
> -                         ubman.get_spawn_output())
> +                         ubman_fix.get_spawn_output())
>      except Unexpected:
>          handle_exception(ubconfig, ubman_fix, log, err, 'Unexpected test output',
>                           False)
> -- 
> 2.43.0
>
> base-commit: 2f3766949bbea7aa5a472157561d387fd94205d2
> branch: py-fix
