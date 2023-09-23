Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 234B3CE7A88
	for <u-boot@archiver.kernel.org>; Sat, 23 Sep 2023 18:32:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7FE918641B;
	Sat, 23 Sep 2023 20:32:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="impcrbfO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 560A886945; Sat, 23 Sep 2023 20:32:18 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 733C58641B
 for <u-boot@lists.denx.de>; Sat, 23 Sep 2023 20:32:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-51e28cac164so12023028a12.1
 for <u-boot@lists.denx.de>; Sat, 23 Sep 2023 11:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695493936; x=1696098736; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HDnGXXG+S8zUTxQ1WLCEYvKgcFRWFsOQAL+rl7BlD5w=;
 b=impcrbfOH3PmQCkgOTodwIi1HT8rq6Mv+cgYKxzcNLwfgQrRtY+OevSrSPTHSmRxQ+
 f7LTZ8hz3Cwc32QAW9afXH43vuk2PpQ037VREUgS7aL9pNo3qn+pHuOtoFkSMWwfRxet
 mEDBO5M8vD3obqJEyBJwvr0wCQzFHAKsXIZss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695493936; x=1696098736;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HDnGXXG+S8zUTxQ1WLCEYvKgcFRWFsOQAL+rl7BlD5w=;
 b=MlLNCag47ahT2qhQ21SNQJVRrFN6EJzLBSO5UMw5bfK3Ljrxw0+NIZaJJAzIvRl7e+
 awfZjoC5IOujyN7Q9KOzBl+IDyo8H+gVrsV2pq/bRbCACjV50Faj3AhfVrkrFz1lzbwM
 XdnZtiuHdfGScfosl6wdikPdxJlQ7IrRAQBfb8FPM+0mHMgQIWgmciucTsDhVZiP90sA
 ngCla+XOrYnhpl6auKJp2sI6ZZGkcb8NcoNck45HAL6aV33pYgjpGYGOLIXiJ0aDSwkQ
 +OrezmPbxBFPWtxxlTuoka+0U8im/788AM/fNSFr5wO0fFffKLW5I410V1U/NexbxnG5
 QkaA==
X-Gm-Message-State: AOJu0YzYyK6lTg+c619XBZarw79+I7vMAdv+q/Svh8hN/iSw2p7utHeG
 XgR4twKUDuvjxPNx/Zot5fetE9L+Az2IYEv4daFNf4hLdMCkhKWJ4cs=
X-Google-Smtp-Source: AGHT+IEEGOSB2sR79y/xgFbYAPzPg63PCfMJbOqc8qUTZECTpSm8+9byD4MDjhg53lxPXZ3mYyt/QEdIudpnZeTyOPk=
X-Received: by 2002:a05:6402:2803:b0:533:4a89:5b2e with SMTP id
 h3-20020a056402280300b005334a895b2emr8857184ede.1.1695493935809; Sat, 23 Sep
 2023 11:32:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230915002236.798760-1-sjg@chromium.org>
 <20230915002236.798760-28-sjg@chromium.org>
 <EAEB2C14-4192-47FC-8AB8-E3CF15987361@gmx.de>
In-Reply-To: <EAEB2C14-4192-47FC-8AB8-E3CF15987361@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 23 Sep 2023 12:32:00 -0600
Message-ID: <CAPnjgZ0iYQhyOc4LCbEo1gZky=YkB-VwU3MJUGwHvR82xq4RYw@mail.gmail.com>
Subject: Re: [PATCH v2 27/27] qconfig: Update the documentation
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Masahiro Yamada <masahiroy@kernel.org>
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

Hi Heinrich,

On Thu, 14 Sept 2023 at 20:39, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
>
>
> Am 15. September 2023 02:22:29 MESZ schrieb Simon Glass <sjg@chromium.org>:
> >Update qconfig's documentation to better reflect its new purpose in life.
> >
> >Signed-off-by: Simon Glass <sjg@chromium.org>
> >---
> >
> >Changes in v2:
> >- Reinstate the -C option
> >
> > doc/develop/index.rst                       |   2 +-
> > doc/develop/{moveconfig.rst => qconfig.rst} | 144 +++++---------------
> > 2 files changed, 38 insertions(+), 108 deletions(-)
> > rename doc/develop/{moveconfig.rst => qconfig.rst} (61%)
> >
> >diff --git a/doc/develop/index.rst b/doc/develop/index.rst
> >index 0d12484ace8a..003cdfccf112 100644
> >--- a/doc/develop/index.rst
> >+++ b/doc/develop/index.rst
> >@@ -88,7 +88,7 @@ Refactoring
> >
> >    checkpatch
> >    coccinelle
> >-   moveconfig
> >+   qconfig
> >
> > Code quality
> > ------------
> >diff --git a/doc/develop/moveconfig.rst b/doc/develop/qconfig.rst
> >similarity index 61%
> >rename from doc/develop/moveconfig.rst
> >rename to doc/develop/qconfig.rst
> >index ad8596e6c61a..111e2b2545d9 100644
> >--- a/doc/develop/moveconfig.rst
> >+++ b/doc/develop/qconfig.rst
> >@@ -1,100 +1,37 @@
> > .. SPDX-License-Identifier: GPL-2.0+
> >
> >-moveconfig - Migrating and querying CONFIG options
> >-==================================================
> >+qconfig - Querying CONFIG options
> >+=================================
> >
> >-Since Kconfig was introduced to U-Boot, we have worked on moving
> >-config options from headers to Kconfig (defconfig).
> >+It is not possible to see all the CONFIG options used by a board without
> >+building its `.config` file. This tool allowing this to be done efficiently for
>
> %s/allowing/allows/
>
>
> >+all boards, or a subset, writing the results to a unified database file.
> >
> >-This tool intends to help this tremendous work.
> >+This database can be queried, to find boards which used a certain combination
> >+of options, to aid in discovering Kconfig options which imply others.
> >+
> >+The tool also permits syncing of defconfigs, which corrects the ordering and
>
> %s/syncing/synchronizing/
>

Thanks for going through this. I have updated everything except for
the syncing bit, since that is English these days.

Regards,
Simon
