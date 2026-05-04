Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6B97FF886F
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 12:31:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5644684664;
	Mon,  4 May 2026 14:31:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mQuCDvnM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CBAA84687; Mon,  4 May 2026 14:31:20 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06CCC83FEC
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 14:31:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-678adefbd26so7433149a12.3
 for <u-boot@lists.denx.de>; Mon, 04 May 2026 05:31:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777897876; cv=none;
 d=google.com; s=arc-20240605;
 b=fUybXYb5F6rEBPg3A+wPTDj2Ml8Ah5GPJv6WtbGC+QmFu0JCcXTHCREaFjYDionlIx
 mA//4tSxSqBHSUQ0YHMjLuipVcqZ020AA+9P3zOyjrYr9Rx+ym4xcWbKzudWDUHWJNQ1
 SyzAfiKjmFnTY/3OxAsaqiY7GdxXfWDBv/SYdefqDrjEdMpBTD6HvTQcpoqVuAIqYWaI
 /Z8MtPWOkYKLD3m5MVOvQJaB1WdOhHpBpskl5SHQnriNGJ4GYJgJsmXSXTDf7fKTR0vH
 qBRuRiKV02jnCwqSBRpVBQ2sxE5CthzPH/HGyHX23t2w9U0lY8k11y7LV+bS6Yq0geKQ
 VNXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=VZxGqJhh00FCKKXASMf467dMDq2a1LymH5WyMbzKPrg=;
 fh=XXcfzCiAuQMJyMuyiaSz7X2bqP/dLoxll3XeZkNPATA=;
 b=Ox+4GoQGHa16DWwzoeB42V8WV07yrRT27L6cURUxTFLdxxPPMc6h6U2l+qWwIykKbF
 X5XJkXL20B1tdhHG5l4Z9sjI/O3ghaU9SNMt96L51JnjgVFzmkt0+ZEmVks7y9LyW9Bv
 sbmZowhoJeLdMrat6CXrDq/Gcugf3cWkSU07Rd0nDgbDnYaIvnFG5L4vgOKyAjla2vpf
 Bs5kwYdtL8dMhEtLNvcRx8ZSAFsXmGQawUYYZW4TbfTTQQAAFpgCktOwTMvg9zvqASlJ
 E+j4tiQqGyIbjv352j4ydIT6056tOQ+FQ60eJWpOEn7y+CyzzcWQtqhyCfpwgo4uhaGX
 dgyw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777897876; x=1778502676; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VZxGqJhh00FCKKXASMf467dMDq2a1LymH5WyMbzKPrg=;
 b=mQuCDvnM9DySX6qWL1H+RV2JN8iiieqRuYACbMj3y+hX8w7F9R9JJFbKbhgdhm7dZW
 97E6C8W3Lxokl3lfF7W8v/98SG4pi9IHI/gr1Yh/9lJcmL7nrtqRu66G2CNiGr128MrM
 IkTcYjBKKhtno5tPHoVBp0ArL4ldGjfJYLxR4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777897876; x=1778502676;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VZxGqJhh00FCKKXASMf467dMDq2a1LymH5WyMbzKPrg=;
 b=GH8XLhqGNAk+lgsNCAy5JwWUkrNkWMcim7PHbKv/SG50y4XGs2rEnMGX7D5gaafPXa
 i4KZGiJJjOc3gUHtiZuQHcE2jcpRHUIFLGf84qEzZ0a8jyQKdN82H4No5Xg2e419dXg5
 7VmK0SLV05+7Eaf9VvWIPt7GziefH4abe2VCXPCR9kDjcVilZaRf4/dS6t+oe4brkcF5
 LzCCab++9IenyyZChDfiNag/ejkrnAF/Iyo9k/r9ZvQdaN30HHNLAds3ZIo3bejasl9a
 6Y2NL4TMonsiVq6WyxOZZqOZ9klx4Ubu56tj+fHWbv48Wenr2NZhMTF4969feVxUGyWt
 Lp7g==
X-Gm-Message-State: AOJu0Yy0h/PiLc64lhIbk4o+WtrodKnGxQzPdx/OJmhIlZNjZ5nOGltv
 ta6Q415TMzijOJbi8Ym8uQP3XTz8v/F4pk/uRBLD/EUBfqgSvzKFCkSJtY4KUtoKxDyrSdz5Gef
 7XbDnXGI8AMYiCduyFekKs7I+UvUfd09WSN3W894i
X-Gm-Gg: AeBDietI3xi5jjHLAQtNj08vmKMBsFlkRNQJvE3fmxZ0m3HQf47BDzz+7Fcevxjqzul
 nNCZ7cXHyeIkjs/H+rqndx41oCC9ZTFx91r46sLcR5tjTgPeG12SkTqufvEuxL+/vzjcRWxdHUG
 4tl1xwF9qNOmKO2Vo2nzaUEU0lI70k/3xJGuG3UoFeVKVHdd742geiagtMRRiID9M1TmTfbqMFR
 4R+kUrk3/x+CZFp1edsjc4LOPO2nJDZbPYfA/eKkMokBJYsl04cVJaOcLqhc0rEFtQdYvtPpUqI
 P1DTO8vXsJ6zxkHDtEaS5XtHZGE=
X-Received: by 2002:a17:907:c02:b0:ba4:8288:b464 with SMTP id
 a640c23a62f3a-bbffab330eamr504405466b.6.1777897875895; Mon, 04 May 2026
 05:31:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260429141850.1.6f48ecca7f833b4f4b90ba78432475de1461e838@changeid>
In-Reply-To: <20260429141850.1.6f48ecca7f833b4f4b90ba78432475de1461e838@changeid>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 4 May 2026 06:31:04 -0600
X-Gm-Features: AVHnY4KV0jzcysKkHq4Uaf0KZdHl5wd4_5W36XdOt0HDYbtKKyqW_0hWSxkjY2U
Message-ID: <CAFLszThHeODorsKtPCqFYmfSPuCJNGMTvdtUQ10yiHRhJnuCPA@mail.gmail.com>
Subject: Re: [PATCH] patman: fix use in worktree
To: ludwig.nussel@siemens.com
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

Hi Ludwig,

On 2026-04-29T12:18:51, Ludwig Nussel <ludwig.nussel@siemens.com> wrote:
> patman: fix use in worktree
>
> When using a worktree '.git' actually is a file and pygit2
> init_repository() does not like that. The intention is not to create
> a new git repo anyway so use normal constructor instead of
> init_repository().
>
> Signed-off-by: Ludwig Nussel <ludwig.nussel@siemens.com>
>
> tools/patman/cser_helper.py | 4 ++--
>  tools/patman/cseries.py     | 6 +++---
>  2 files changed, 5 insertions(+), 5 deletions(-)

> diff --git a/tools/patman/cser_helper.py b/tools/patman/cser_helper.py
> @@ -309,7 +309,7 @@ class CseriesHelper:
>          self._copy_db_fields_to(series, ser)
>          msg = None
>          if end:
> -            repo = pygit2.init_repository(self.gitdir)
> +            repo = pygit2.Repository(self.gitdir)

Thanks for tracking this down.

There are more init_repository(self.gitdir) call sites have landed in
cser_helper.py and cseries.py - please can you convert those too,
otherwise the worktree case will still be broken on those paths.

> patman: fix use in worktree

nit: Please can you capitalise the first word: 'patman: Fix use in
worktree' - matched the rest of the patman history.

Regards,
Simon
