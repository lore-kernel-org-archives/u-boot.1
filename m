Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B07D2C5AC67
	for <u-boot@archiver.kernel.org>; Thu,  6 Aug 2026 21:14:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CF3D84087E;
	Thu,  6 Aug 2026 21:14:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id W1EOBT0h3_cM; Thu,  6 Aug 2026 21:14:11 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A19F74080E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786050851;
	bh=r7wlR3WZUBPMx7g6dRxxeEh2AmY8eMSuKcPfOkWUiuk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZWxLsRrkuCZ3q6VGiqCjao8shJ9BHlhod1kLuMqweP0vaBr6aZXdRNFmNUHPLZ/6T
	 FmlnjEPpPV/+GgbPoAexsydcDE74GMN7BqCcTivgQxuObGA3wL852gn6T1W/2vTU58
	 TjKsq5vHVWd78dPx46OBmiwbG3ELkYHStD+Rd9yBhes7P5h8YBUG8NPBz5yzwwHMDr
	 by8H9nrMsRhUcq8+22yEFf+OQtO3YOjoL8u7gzXpydOICTuFMhDo3HYhuxriXPQZkQ
	 srN9N1MIuKd2fYRrTjciM7zQUXOzrlq+tLov8N3w1nDVxxCqAgZRXyB9fTlFWPmfEH
	 itC4eDixwlBSg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A19F74080E;
	Thu,  6 Aug 2026 21:14:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 688E2198
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 21:14:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 65E79400BC
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 21:14:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id p7uSXUrK9l2M for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 21:14:09 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::531; helo=mail-ed1-x531.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org F40E74022F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org F40E74022F
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F40E74022F
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 21:14:08 +0000 (UTC)
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-6a0a4a28cbdso3879183a12.3
 for <u-boot@lists.u-boot-project.org>; Thu, 06 Aug 2026 14:14:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786050847; cv=none;
 d=google.com; s=arc-20260327;
 b=qd2X4PRthUfcETfLy14kkRqvZhgZMrhgD2FwnTEFAfAVPC4VGcGZpH9iwsjW5DvXpx
 Yfw1NaENJGzuAcmHCHU07B0jzViAfjOUkbYsrij4cmg8k/v5jZTidCtdRqKvEQjcKfPG
 L2P+WYCUuaDvBlOIWTb62qQkfpnq0zUJ04lmFvGQaVgYCOUCmYa2rGP18MuQokbx0uTJ
 DRNgh1Jeu4Cfgp8qiLHLORIpj4GuTov8q49lGP9NpBH3VMHfHx8ipYR0he6hhb1H57bp
 WSC8waxF2X6thKjsiWon5BDc3UkGM5Lv3zl/jKKw9xVWmchK0W3TqlKQJ4JuxBjE410f
 S71w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=r7wlR3WZUBPMx7g6dRxxeEh2AmY8eMSuKcPfOkWUiuk=;
 fh=Ye9d8c9UuIgjdEYE5AmpFdHtipkFyQbZju95WIBagdg=;
 b=aDdDzg/wq0mP9O9C8B8I1yW/H50pS98Rlq8woQxMRyaf9A9iXZMo8kub6PriUMkFZs
 6NzSc8S45/P6axtDH62vKm8LXhl6ibfNYef14afsmLKkgoKYkFVxLlYyWUwvL78AOllm
 bhRoQytBaCEOZVG1+8w7dn8P5oCD7enMRPxJG3XIeJNBotB53gYXu2BZwua2affwaxde
 HUuYeXWBGK1zTT2wuDAfIEvuGw14nkt7rM+GEoSKtXe4agZZdm8ASGPqoMeE0+Ybsp/O
 YZ8UKusbAIApDPm7zq9w3tBYxvm3C+KdMbLMPW6yBOXU/rYMBdt6+dN86iOzacXIOl9N
 ACAA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786050847; x=1786655647;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=r7wlR3WZUBPMx7g6dRxxeEh2AmY8eMSuKcPfOkWUiuk=;
 b=T3/dxCmhoMpPhucZRYojEwWdlN4poqQCn/aglzpNmbI/3qhbna/MOJVgV811ZRlwqH
 rPeaVLVpoyXV12ySymae4gN6OXqd7aEsWdW5p51Z7Cl73gsZ8i0F0+zlaU+Ojxm+0Yzc
 +tINtK0c1BjVY5zctTg+pp3LPzkFoErwosAI9Vaxmlrh3tRkJzd3yw/g9pbMBWD/0Ie5
 GLfW/D+IQzam6O/rlxlE/IzOrYQQ7RrbQ9zKdGgJlubl83dnwHMJBrIBBRv4dbYh6Hcx
 bOpyn2Z3+/BqJcgtXEgdQ3mH0MYSyhLgUDUxIbOWDnzo42iyR0KgzNaR2F1s+6BKYbM+
 rJQw==
X-Gm-Message-State: AOJu0YyYhxLu7725g+aMiSbZm56W217u2iZPttq9x8bZ+ZK+GnwYhXWc
 xtVPcv9JHNERDx0EhPsPTaM0DF4gCQiAUPuiUOgRRUaaTdhEzcNQfG3xX68pl7/gGZMcPoly+8a
 ygw1RMvabn6xyE0aKvWVYwLViQbJcmXzXSUxKBc8zrtFXKMLNiSs=
X-Gm-Gg: AR+sD11DrXjyrfehXyvynRAEUNyzKI/7UuGhmyyQwalQdm847/pMe7oYFvvhonm3GOn
 fba0Pl9P36xT8rKHhRyJkn7L/hMCKLSpqeMsSPyPZIT/mGEK7OMH4KkTksKZwNXFdHuaR7m9D6A
 YJljgu6k3C5y73seGBMRuBq2vs15pb9QBJp+7PRx+MpPM3dDT2GaIjFnlgPzEpJSNudKu88pWmf
 QBpzQYMWjzzxk9d+PRVXVBKQTAVAG4SVUCEpOVuBWjmPd6vnKqWZ8SrDIAawy26UE8Sq/OIsdZa
 nv8pMaXfGPP2W7YiN6zbe429YFInbh+TEwcoZEyC8A79PoNPCB5E9UPLfqmD8jtfgg==
X-Received: by 2002:a05:6402:505c:b0:698:c14b:a719 with SMTP id
 4fb4d7f45d1cf-6a14f26bdbcmr8511142a12.20.1786050846932; Thu, 06 Aug 2026
 14:14:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260804-am62lx-v4-0-01746157643d@ti.com>
 <20260804-am62lx-v4-10-01746157643d@ti.com>
In-Reply-To: <20260804-am62lx-v4-10-01746157643d@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 6 Aug 2026 15:13:53 -0600
X-Gm-Features: AUfX_myytbno2CwIaD8GYn-hIZLKsJ5nw1ym0OPE_W85WG6mNwPMsBFp5qjwDPM
Message-ID: <CAFLszTg1PyOeBhJ9C_Cf4gkM51LDdfL8VpwWg-W7=3KCBioa8w@mail.gmail.com>
Subject: Re: [PATCH v4 10/11] doc: board: ti: correct path to tcl scripts
To: bb@ti.com
Cc: u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1786050847; x=1786655647;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=r7wlR3WZUBPMx7g6dRxxeEh2AmY8eMSuKcPfOkWUiuk=;
 b=GvdD1Vm8mTqOo00RtOgSG1MPY88zan1Hwrz7WclSAuuHu/muV0hmURola6i5fpwlC9
 EVtpNTcJ/7wtgJGGQxpW9B1txcVPcaivzbSiRUKh4CVM52Y1Bkp4z2yC1CEJO9mYXFCZ
 RyPqRjEBuP+LMNUaUXtxmcnxEE1ZlD1v00XGs=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=GvdD1Vm8
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Bryan,

On 2026-08-04T21:55:02, Bryan Brattlof <bb@ti.com> wrote:
> doc: board: ti: correct path to tcl scripts
>
> OpenOCD has moved where it has placed the tcl scripts for TI's reference
> boards. Update their paths to the new locations.

Minor: 'has moved where it has placed' reads awkwardly. Something like
'OpenOCD has reorganised the tcl scripts for TI's reference boards
into a ti/ subdirectory' would be clearer, and it would be worth
naming the OpenOCD release/commit that made the move so readers know
which version they need.

>
> Acked-by: Andrew Davis <afd@ti.com>
> Reviewed-by: Anshul Dalal <anshuld@ti.com>
> Tested-by: Anshul Dalal <anshuld@ti.com>
> Signed-off-by: Bryan Brattlof <bb@ti.com>
>
> doc/board/ti/am6254atl_sk.rst |  2 +-
>  doc/board/ti/am62ax_sk.rst    |  2 +-
>  doc/board/ti/am62dx_evm.rst   | 11 ++++++-----
>  doc/board/ti/am62px_sk.rst    | 12 +++++-------
>  doc/board/ti/am62x_sk.rst     |  2 +-
>  doc/board/ti/am64x_evm.rst    | 24 ++++++++++++++++++++++++
>  doc/board/ti/am65x_evm.rst    |  2 +-
>  doc/board/ti/j7200_evm.rst    |  2 +-
>  doc/board/ti/j721e_evm.rst    |  2 +-
>  doc/board/ti/j722s_evm.rst    |  2 +-
>  doc/board/ti/j784s4_evm.rst   |  2 +-
>  11 files changed, 43 insertions(+), 20 deletions(-)

> diff --git a/doc/board/ti/am62px_sk.rst b/doc/board/ti/am62px_sk.rst
> @@ -331,13 +331,11 @@ detailed setup information.
> +   Until the next stable release of OpenOCD is available in your development
> +   environment's distribution, it might be necessary to build OpenOCD `from the
> +   source <https://github.com/openocd-org/open ocd>`_.

The URL has a stray space - 'openocd-org/open ocd' should be
'openocd-org/openocd'. This will render as a broken link.

> diff --git a/doc/board/ti/am64x_evm.rst b/doc/board/ti/am64x_evm.rst
> @@ -227,3 +227,27 @@ https://www.ti.com/lit/pdf/spruim2 under the `Boot Mode Pins` section.
> +   Until the next stable release of OpenOCD is available in your development
> +   environment's distribution, it might be necissary to build OpenOCD `from the
> +   source <https://github.com/openocd-org/open ocd>`_.

Two issues on these lines: 'necissary' should be 'necessary' (the v4
changelog claims this was fixed, but it is still here), and the URL
again has a stray space.

> diff --git a/doc/board/ti/am64x_evm.rst b/doc/board/ti/am64x_evm.rst
> @@ -227,3 +227,27 @@ https://www.ti.com/lit/pdf/spruim2 under the `Boot Mode Pins` section.
> +Debugging U-Boot
> +----------------

This whole new section is adding OpenOCD debugging documentation for
AM64x, not correcting a tcl path. Please split it into a separate
patch so the subject matches the change.

> diff --git a/doc/board/ti/j721e_evm.rst b/doc/board/ti/j721e_evm.rst
> @@ -261,4 +261,4 @@ To start OpenOCD and connect to the board
> -  openocd -f board/ti_j721eevm.cfg
> +   openocd -f board/ti/j721evm.cfg

Just to check - every other file in this patch keeps the trailing name
identical (e.g. ti_am625evm.cfg -> ti/am625evm.cfg), but here the
second 'e' is dropped (j721eevm -> j721evm). Is that really what
OpenOCD ships, or is this a typo?

Regards,
Simon
