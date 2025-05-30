Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CE44C54F30
	for <u-boot@archiver.kernel.org>; Fri, 30 May 2025 07:10:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D1545830EA;
	Fri, 30 May 2025 09:10:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CsVvYKmf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E69E38312C; Fri, 30 May 2025 09:10:28 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E52A7830D9
 for <u-boot@lists.denx.de>; Fri, 30 May 2025 09:10:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 986206115E;
 Fri, 30 May 2025 07:10:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04D5CC4CEE9;
 Fri, 30 May 2025 07:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1748589025;
 bh=nwIU1p5micFBNR4vStxniMk55/AcnpnRlYpo8nr8DXs=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=CsVvYKmfP0LsybQQPBEzwniQ5xp5SqnsKXvkKA/ZlIyvThimOeXBbj9YPc+truVe8
 01kotI0zAbDiAgdRO6WzcLPibIbWUPcT1gL7y4yF3HtNjtSNeEZJdS5RJUROSgRsBF
 ynjZye387NUr9iKz52nDKVUmV+tSTcUKQfBq2jMX62h5qkC2AjU2KDly5zsNnZeFGS
 5XzVYUN1FVpRMfsHFwH/W1d7iqpRAIcQve9yhRSdOHzOGJGr7lbZJPJGRhNivzZPAA
 DZrmhAhFgg76IikwfsCHE03LmsCHd2NWEHsUM1QpdDmeN7g6SBPzemU1LCWaKuSS6K
 ud4FkDNCYah5A==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Stephen Warren
 <swarren@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>, Tom Rini
 <trini@konsulko.com>
Subject: Re: [PATCH 2/2] test/py: Correct handling of exceptions
In-Reply-To: <20250529141500.2123363-2-sjg@chromium.org>
References: <20250529141500.2123363-1-sjg@chromium.org>
 <20250529141500.2123363-2-sjg@chromium.org>
Date: Fri, 30 May 2025 09:10:23 +0200
Message-ID: <87msaupo9s.fsf@kernel.org>
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

> If an Unexpected exception is thrown in a test, an undefined variable
> error is reported. Fix this.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Fixes: 85d7dae377a ("test: Detect dead connections")

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
>
>  test/py/conftest.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/test/py/conftest.py b/test/py/conftest.py
> index eec0b5488e4..8ce680a92a0 100644
> --- a/test/py/conftest.py
> +++ b/test/py/conftest.py
> @@ -515,7 +515,7 @@ def ubman(request):
>      except BootFail as err:
>          handle_exception(ubconfig, ubman_fix, log, err, 'Boot fail', True,
>                           ubman_fix.get_spawn_output())
> -    except Unexpected:
> +    except Unexpected as err:
>          handle_exception(ubconfig, ubman_fix, log, err, 'Unexpected test output',
>                           False)
>      return ubman_fix
> -- 
> 2.43.0
>
> base-commit: 2f3766949bbea7aa5a472157561d387fd94205d2
> branch: py-fix
