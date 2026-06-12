Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DCBACD98CF
	for <u-boot@archiver.kernel.org>; Fri, 12 Jun 2026 18:18:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C83AE8486B;
	Fri, 12 Jun 2026 20:18:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="k6w9UkTx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A047B8486B; Fri, 12 Jun 2026 20:18:37 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA4AC84704
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 20:18:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-6924a68e3f3so2245461a12.1
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 11:18:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781288315; cv=none;
 d=google.com; s=arc-20240605;
 b=SQRjA2XLtb6ECKtBgq43gyJAdoacdV3LQODp22j8NC8eOlD97nUc+oxEieelnFv00i
 O5nFDMz1A1K4LzcgctLsEDrlV7zmpF92IV4TKYxZxV3oSD2jJchhFmP1GMoxa95lQBH2
 we7VXEN6QpssVyKEj/LlZ33fmlL4xQHrYs3HodwJE0ijHx/+4QTG1NIugPvkMMspp0NB
 ZuolN7D3i/N4dEdXA0QUnqvzTjAizkF7X8DlqWu+YtUD2oXohzRbhdbBm/w3JcDvh92S
 xMihmdexcuYlOmTGA1j5HLLApK92z1Z6t6fa40igkIy3iofH8Mr7axx4hjFE7Z06Jp7H
 mFGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=3jYkyd4RQgzGq+jbfgulE0m8Lc/oGLVPp9Rj/Y3HsPU=;
 fh=9ubA2NAtNgaNu4QSndVoEaN2pSDvylShP/9wUbVxN6I=;
 b=KlzlCrhOXyYLyo83xCLbhLmo7PyfBSNDvFpVBdDluFp0cGYfyhO3jVwOfcvN6MCQ31
 PIsy3Ne0nx6F9wQqrIHWFXUvRhEvWa+VpBuBjf0yDFdx2Kn5lxW+aIz9Y2jUpYL/YJ0n
 v4rowiXP4pbR8A+o/cPuSr3dAv3Y6dG91X2mWCrG2ZTjsToJhYl1Jbct0gOEstjBeAsD
 drrj5HGjO73k/6OWecE7CguebL57q6bJTOrKgmLN8H3QoS1KBXUzvtIOtizVH3dNOkYJ
 PI9wTSMkX0KSqQwC4/eIiUUpWd/0KFXyOViC3TDoh9nNmmw2ETWND9ULQFP8Of4fmsUw
 DScg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1781288315; x=1781893115; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3jYkyd4RQgzGq+jbfgulE0m8Lc/oGLVPp9Rj/Y3HsPU=;
 b=k6w9UkTxXz5LtFGH2KxGAwqum5IN0ms1Ln1iIPIUgAZeOexT7SHm17v3mMm2JKJsOz
 jH7/dhzUVaRxyzmQ/iqVfzv5B94FQ5objzBdA6ACZgoMM0GyiorHQCSR0twMF92T4/nU
 /5yq28H6nXDBXueaNWqbKhZ92pHhajNKUvEXE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781288315; x=1781893115;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3jYkyd4RQgzGq+jbfgulE0m8Lc/oGLVPp9Rj/Y3HsPU=;
 b=Ge0GCnPpz7Hi4xGTuQhK8m0wodvp8ReZ8ux65WHLlsDIJlIi+Axj8jbDkPRXH3WW+8
 YkmPuGAew86nsTl8nCZCntMWysu/cPAig4lbC+NNIOkTGPrSux1qz3G5DMO8ivaiAc18
 /O2iOKvQkTBDnSvauJGooOhKgr/WOTzwzFbnWJWGv7W7y5J58bR6HzdZifPnPVWefOgf
 txek47eHMVGGpOAoBXH7GeWsPaVHa0oCf3jPdULqrBEU+lhgGIpqdlnvdTncpKz7sl7Y
 7I9fZq9XSdl4QuVCA0b7Ery/nNxi7mZGMsHvbNutwUTV15WuDc24i2R5an4KczdAL58s
 I6vA==
X-Gm-Message-State: AOJu0YwB5hUHy6RNBxQZg7no0PL7AYyFqZ9DXvMacsZ4abqGgALzNP1S
 C3VU1qAHJdwGA5COS6Bn9edEuDDkaKRKFkENueEYlh3vnpVoNfnh2HsxYi1AYJHkty5OQPU8eWr
 6JIM3SY2ZmIiI1ptPRDzo37pj4lxbNeqEy6FoSJjn
X-Gm-Gg: Acq92OERCHXz84xhsXd999yO7spgNH7CJNY4oKyhWTQmA6GTD14mSix80X1nrKJ4Sgl
 DO1xMGtXJqYVVzFYQryQFy0xRthGhch2yzm4nhe3AgJ8vtiWrmrmuDGTD9tdHH1DCfjJVZz8Tk2
 9GhqZCHPwCqUcnxWE3Dk2wZv4xiW8DBkoKp6eHj0xVTX6Wf19D4djkZVdw10YGbhqaPkIih1BYZ
 FAzcJLdVrYsabdnK/eodF7YyesUO3p1FrsFdHrvrlwiELVW/i3BwhHJYfsdOijnI4681jI2suRl
 FPiGnQ==
X-Received: by 2002:a05:6402:a295:10b0:691:b158:b424 with SMTP id
 4fb4d7f45d1cf-693784eb950mr1309034a12.5.1781288315085; Fri, 12 Jun 2026
 11:18:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260601131311.1163914-1-vjardin@free.fr>
 <20260601131311.1163914-3-vjardin@free.fr>
In-Reply-To: <20260601131311.1163914-3-vjardin@free.fr>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 12 Jun 2026 12:18:22 -0600
X-Gm-Features: AVVi8Ccg3QyVrb-PsFRQRvEHv-zG35aorWDs5boXaSJJldIaLMdqFPWcZIHVwE0
Message-ID: <CAFLszTgOYwsoxbPW+PgMENHx2yVemO6BBrTuzM1XU_YjyqZL7g@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] doc: usage: cmd: load: null-block-device
To: vjardin@free.fr
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Vincent,

On 2026-06-01T13:12:01, Vincent Jardin <vjardin@free.fr> wrote:
> doc: usage: cmd: load: null-block-device
>
> Document the dispatch path added by the former commit
>
>     fs: dispatch null_dev_desc_ok filesystems before lookup
>
> Add a null-block-device interfaces section that:
>
>   * lists the three fstypes that can benefit of it (semihosting, ubifs,
>     sandbox) and the CONFIG option that builds each
>   * explains the '-' convention for the unused <dev[:part]> field
>
> Suggested-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Vincent Jardin <vjardin@free.fr>
>
> doc/usage/cmd/load.rst | 37 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)

Thanks for doing the docs. A few grammar/doc-level nits below.

Reviewed-by: Simon Glass <sjg@chromium.org>

> diff --git a/doc/usage/cmd/load.rst b/doc/usage/cmd/load.rst
> @@ -63,6 +63,43 @@ Example
> +Null-block-device interfaces
> +----------------------------
> +
> +A few `<interface> values do not name their block device. Their
> +filesystem implementations call directly a back-end (JTAG
> +debugger, UBI volume, host running U-Boot under sandbox, ...)
> +and ignore the <dev[:part]> argument. The fstype info table marks
> +these with the internal null_dev_desc_ok flag; the dispatcher in
> +fs_set_blk_dev() routes them by name before any block-device
> +lookup is attempted, so load <iface> - <addr> <filename> works.

This is user-facing documentation but is leaning heavily on
implementation detail. The user does not need to know the flag name
null_dev_desc_ok or fs_set_blk_dev(). Please reword along the lines of
"some interfaces have no underlying block device; for these, the
dev[:part] field is ignored and may be given as '-'", and drop the
references to the internal flag and function. The implementation
rationale already lives in patch 1.

Also: "call directly a back-end" reads oddly - how about "directly
call a back-end".

> diff --git a/doc/usage/cmd/load.rst b/doc/usage/cmd/load.rst
> @@ -63,6 +63,43 @@ Example
> +semihosting
> +    Read files from the host filesystem of an attached JTAG debugger
> +    via using the ARM semihosting protocol. Useful with OpenOCD.
> +    Built when CONFIG_SEMIHOSTING=y.

"via using" - pick one, 'using' is enough.

> diff --git a/doc/usage/cmd/load.rst b/doc/usage/cmd/load.rst
> @@ -63,6 +63,43 @@ Example
> +sandbox
> +    Read files from the host filesystem the sandbox binary is
> +    running under. Built on a sandbox build (the sandbox fstype
> +    is registered with name sandbox and null_dev_desc_ok =
> +    true).

The parenthetical exposes table internals again - I suggest dropping
it. "Available on sandbox builds" is enough.

Regards,
Simon
