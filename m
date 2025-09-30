Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 201BBCCA468
	for <u-boot@archiver.kernel.org>; Tue, 30 Sep 2025 13:16:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 57B7F83071;
	Tue, 30 Sep 2025 15:16:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="licZFS2X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91BEC832AD; Tue, 30 Sep 2025 15:16:16 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 17C6D802C1
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 15:16:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 602B3438F9;
 Tue, 30 Sep 2025 13:16:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2776C4CEF0;
 Tue, 30 Sep 2025 13:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1759238171;
 bh=Cco193yOpjHabD8ervPH+h82+T/Dgf/1VKgaYDRB4Q8=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=licZFS2Xt0gFjvfy16hljdn0CT76eyTqXHSlx3Nk7Z8BGVp615/c/TXbUlKsoZuVZ
 AC14Qxg4HbvBARnIP0NG262BcXBeubpozECIRPOljBmTIKLA4xodoJL8FULEiuiHOg
 WxprTexiU67X89mG9kUL8ZBjVCBs4Q3ipRH1VtC0FxkS9wm5Ucd4J0n5Bf6IY8M4qO
 6VBtXAZ5xERL3UQb03CmAkh2ZTZU3OkKu6fUzG3z5vDL1dN/axPrqy9eLc3v91f51a
 lVTidXLOHqqu121pWgattt90lEfL9QBWUb0kO8wJrDLYEV1YbEndr0bRq0IfatPHzp
 zYwYsuucTiIBA==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Javier Tia <javier.tia@linaro.org>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Javier Tia <javier.tia@linaro.org>
Subject: Re: [PATCH v3] doc: Update coding style to recommend b4 for patch
 submission
In-Reply-To: <20250930-b4-docs-v3-1-1fbf094347a8@linaro.org>
References: <20250930-b4-docs-v3-1-1fbf094347a8@linaro.org>
Date: Tue, 30 Sep 2025 15:16:08 +0200
Message-ID: <87cy78hyhz.fsf@kernel.org>
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

Hi Javier,

On Tue, Sep 30, 2025 at 06:53, Javier Tia <javier.tia@linaro.org> wrote:

> Replace references to patman with b4 as the recommended tool for
> preparing and sending patches. b4 is widely adopted in the Linux kernel
> community and U-Boot ships with configuration to simplify its use with
> the project mailing list.
>
> The updated guidelines describe how to prepare series with b4, handle
> cover letters and recipient lists, run style checks, and send patches
> safely. Instructions also highlight how to collect and apply review tags
> before resending.
>
> This change documents the preferred workflow for contributors and
> ensures consistency with common practices across related upstream
> communities.
>
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
> Signed-off-by: Javier Tia <javier.tia@linaro.org>
> ---
> This small series updates U-Boot's contributor guidelines to sync with
> current best practices around Linux kernel patch submission. It should
> make contributing smoother for new developers.
>
> The first patch updates doc/develop/codingstyle.rst to recommend the b4
> tool instead of patman as the standard workflow for preparing and
> sending patches. The revised documentation explains how to create and
> manage series, run style checks, handle cover letters, discover mailing
> list recipients, and collect review tags. This reflects widespread
> adoption of b4 in the Linux kernel community and ensures U-Boot
> contributors follow consistent, upstream-friendly practices.
> ---
> Changes in v3:
>
> * Update trailers
> * Link to v2: https://lore.kernel.org/r/20250929-b4-docs-v2-1-478285f08639@linaro.org

No need to re-send a new version *only* for updating the trailers.
The maintainer (custodian) who will pick up this patch will do that for
you. See:

https://docs.u-boot.org/en/latest/develop/process.html#work-flow-of-a-custodian


>
> Changes in v2:
>
> * Drop commit changing .b4-config
> * Link to v1: https://lore.kernel.org/r/20250929-b4-docs-v1-0-a56c1a1856c5@linaro.org
> ---
>  doc/develop/codingstyle.rst | 54 ++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 48 insertions(+), 6 deletions(-)
>
> diff --git a/doc/develop/codingstyle.rst b/doc/develop/codingstyle.rst
> index bc18b2ebb7b0fc875a299b9e2e5c64c3d6a8e2b3..8ed6babe4556423fe30effc504615e07a841f21a 100644
> --- a/doc/develop/codingstyle.rst
> +++ b/doc/develop/codingstyle.rst
> @@ -23,13 +23,55 @@ The following rules apply:
>    <https://peps.python.org/pep-0008/>`_. Use `pylint
>    <https://github.com/pylint-dev/pylint>`_ for checking the code.
>  
> -* Use patman to send your patches (``tools/patman/patman -H`` for full
> -  instructions). With a few tags in your commits this will check your patches
> -  and take care of emailing them.
> +* Use the `b4 <https://git.kernel.org/pub/scm/utils/b4/b4.git/>`_ tool to prepare and
> +  send your patches. b4 has become the preferred tool to sending patches for many
> +  Linux kernel contributors, and U-Boot ships with a ready-to-use ``.b4-config`` that
> +  targets ``u-boot@lists.denx.de`` and integrates with ``scripts/get_maintainer.pl`` for
> +  recipient discovery.
>  
> -* If you don't use patman, make sure to run ``scripts/checkpatch.pl``. For
> -  more information, read :doc:`checkpatch`. Note that this should be done
> -  *before* posting on the mailing list!
> +  Start a topical series with ``b4 prep`` and keep the commits organised with
> +  ``git rebase -i``. ``b4 prep --edit-cover`` opens an editor for the cover
> +  letter, while ``b4 prep --auto-to-cc`` collects reviewers and maintainers from
> +  both the configuration file and ``scripts/get_maintainer.pl``.
> +
> +  .. code-block:: bash
> +
> +     b4 prep -n mmc-fixes
> +     git rebase -i origin/master
> +     b4 prep --edit-cover
> +     b4 prep --auto-to-cc
> +
> +  Run the style checks before sending. ``b4 prep --check`` wraps the existing
> +  tooling so you see the output from ``scripts/checkpatch.pl`` alongside b4's
> +  own validation. You can always invoke ``scripts/checkpatch.pl`` directly for
> +  additional runs.
> +
> +  .. code-block:: bash
> +
> +     b4 prep --check
> +
> +  When the series is ready, use ``b4 send``. Begin with ``--dry-run`` to review
> +  the generated emails and ``--reflect`` to copy yourself for records before
> +  dispatching to ``u-boot@lists.denx.de``.
> +
> +  .. code-block:: bash
> +
> +     b4 send --dry-run
> +     b4 send --reflect
> +     b4 send
> +
> +  After reviews arrive, collect Acked-by/Tested-by tags with ``b4 trailers -u``
> +  and fold them into your commits before resending the updated series.
> +
> +  .. code-block:: bash
> +
> +     b4 trailers -u
> +     git rebase -i origin/master
> +     b4 send
> +
> +* Run ``scripts/checkpatch.pl`` directly or via ``b4 prep --check`` so that all
> +  issues are resolved *before* posting on the mailing list. For more information,
> +  read :doc:`checkpatch`.
>  
>  * Source files originating from different projects (for example the MTD
>    subsystem or the hush shell code from the BusyBox project) may, after
>
> ---
> base-commit: 26efc940c865a04d345ac9d39f71746fc2821da6
> change-id: 20250929-b4-docs-60da5560f06a
>
> Best regards,
> -- 
> Javier Tia <javier.tia@linaro.org>
