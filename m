Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 284C6CD484E
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 20:15:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B89C683FEC;
	Mon, 11 May 2026 22:15:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PbMSO1Dx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C48428460E; Mon, 11 May 2026 22:15:42 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88E2383C2B
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 22:15:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-6763cc8775cso10336888a12.0
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 13:15:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778530538; cv=none;
 d=google.com; s=arc-20240605;
 b=M+OIBkbzmQOUBNJyf8N8lzb9lskcjmj8NwDCFATdl/zrwO0bRVRlTEXeAJIVQJBS/b
 hVZkrD19fexSi6R7HtwQ2cGmc7urd2HvEyVmg4bzOFjg/KCSm6qvtLR1imIf/sVUOcu7
 89NewvxzALxpokShDEPdz7WQojOaMnhZqj3tf1eDaPLwV8HK5Snh6TYA1v51kfEChlzA
 n5uyT/PHy+zyPGjMVPbNg+YzdffN7jeotMZTA/ooisFuD4TXGNK50miniXVwIVEdBSlY
 gOZzDk4WwLoMQTFWulgI9ALB4sKE/QlXI/h2k4njRCO2rLvCgDUyDgViSoh4ZdRUX2Ya
 UVlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=TsSImFAXFyCmMcGXCS8ZBKmg/G44NZpBrIelGmR7OsM=;
 fh=AoVEW340XNpvidYYnA4aNiS4cNS3eTFSgS3pBmJ/70w=;
 b=Ij77yC+OUMFXW+vjY01Ft81nFd1SM+NiH4Icy7UoMpoGueeW/tfMNbhdnJ672SQjI8
 jp6RxzOtNzDYWcFBwJcxGY9MggdhjQrgKvzpH6K0yEtQ1V0+2UJlG2GIkg+824YW1Mpd
 a07+uHGxnIZQXsngcA1DxPPkP89/EAH1vqgkOGA6CUXFLpiN6pRZU7dsPumGILu5m6cf
 c0j7issTgT4vNP7w4NayAwISe9n7rq3tXQO0THyX7xssBa0XVhTsFQpghkUmZWEMbNPA
 rpNjUhXvrd7PvFoJdJnYmiH3pkTo1V6scX+IxdEU0eivgFv5qys/J7QgHkubIFv6/fg2
 ociw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778530538; x=1779135338; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=TsSImFAXFyCmMcGXCS8ZBKmg/G44NZpBrIelGmR7OsM=;
 b=PbMSO1Dxab2EL/79l62bQuG57TgaawmRCMtJLA7cCz4cBDs6WIXrlRh7/1O0SwKNza
 6Uf0C1VrzOjy/8bIki61HeZtzIlL4fgLBgPSP3pvLxuPBWr1SFafX6IGfEyglfcGNrtH
 iGSOLOx9Jn5El7mOn3YW8TDiF7gir1MtHdGlE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778530538; x=1779135338;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TsSImFAXFyCmMcGXCS8ZBKmg/G44NZpBrIelGmR7OsM=;
 b=pyXjYLgLMZL9xNNDU+MqP3GzreUwZoG+gD7hlN53gSbS29vVirjJxqKSDBjCm8mZci
 N0nh4huxxNht8Pb4d3p1DA1KMEmkj3mA98E200RKbITXLiKYdO+msZez11YnZlJlScQN
 l2kDWYdlO+x/7+TtkKKKgQB9F6R2vcSeOmdLjcLMJtKJa+DhseU8SR5Q9CPyBBKAZTNa
 bXEkKAIOximSIicUONtONGCCxyicYbu4eUzf+z3pkj6ROnW3+0Kx0HkQEF6Jz5xmYpSj
 R56xtB1SKMy074UuyskTylaaQuOgSN28hnOVjFZSQuNag9F5S4BIuqZxrCPQ8S1B4TbF
 /1UA==
X-Gm-Message-State: AOJu0YzgPm9mEZ5q8Gi8QgPbke5Qg4w+zH1pabiuO9AsH2HjemK0vkKP
 dps8TvviqfMzKbq6MJWDX/226cPErybAODJ0VnFFR0gOyCGhC5x4XaRCJMgqNDZVRGY9jLXgwRQ
 tKckMYifM0r+bpjFvfMlIK21tDLyeOSW6JCHufA87TW5zeE+N42aKEw==
X-Gm-Gg: Acq92OG590vM0NrlIFneVV+/oINe+yCeurTXVww1rKH7q4STfyWAt4oaPxr96JDvcqD
 rMfwg1fcWyulfgKFCltt/U/lEw+9gDAWVmy1tLMHh4TN4BkuAKRDZGZihXhxOaho7aGR5SqHNz+
 engzvXhEI341IkHSRAOXVb4RAPLj7B4tsyTwy6gNktZjmGkb8m/LveLl7y6sa2jyHA6DcxQ8lle
 CQGWf72QyYEtBoUKmLB5FmD3LIMnj+v85GntbE4CgaBIJRPB8e1o1KhJ4NGSLnd/17SK9xbYZIS
 7ExZFVz4KbUAbEpU
X-Received: by 2002:a17:906:209c:b0:bbf:bab5:ecd9 with SMTP id
 a640c23a62f3a-bd23b508751mr49102666b.15.1778530538392; Mon, 11 May 2026
 13:15:38 -0700 (PDT)
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
Date: Mon, 11 May 2026 14:15:26 -0600
X-Gm-Features: AVHnY4Jab60MFBFjL_aGfOKWqa0vY105b9k6gustqQ_uFUlOxYKn01yp_L9p7OU
Message-ID: <CAFLszThRPTPUs7H-2Cy2v2hw78uLGHrG2r9TFWZFdBkomUtGMg@mail.gmail.com>
Subject: Please pull u-boot-dm
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>
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

Hi Tom,

https://source.denx.de/u-boot/custodians/u-boot-dm/-/pipelines/30065


The following changes since commit 22a285380e35a31d0a882af66278bc1edc1b917e:

  Merge tag 'u-boot-at91-fixes-2026.07-a' of
https://source.denx.de/u-boot/custodians/u-boot-at91 (2026-05-09
07:31:55 -0600)

are available in the Git repository at:

  git://git.denx.de/u-boot-dm.git tags/dm-pull-11may26b

for you to fetch changes up to 08bcf962c5fe1d2690ac3ff6dd75d3963325476b:

  binman: Use bintool wrappers for PKCS#11 tools in tests (2026-05-11
12:05:10 -0600)

----------------------------------------------------------------
Add missing bintool docstrings
Minor patman fix
Fix small ACPI bug

----------------------------------------------------------------
Heinrich Schuchardt (1):
      acpi: fix initial RSDT and XSDT size

Ludwig Nussel (1):
      patman: fix use in worktree

Simon Glass (4):
      binman: Flesh out the p11-kit bintool docstring
      binman: Flesh out the pkcs11-tool bintool docstring
      binman: Flesh out the softhsm2-util bintool docstring
      binman: Use bintool wrappers for PKCS#11 tools in tests

 lib/acpi/base.c                     |  4 ++--
 test/dm/acpi.c                      |  8 ++++----
 tools/binman/btool/p11_kit.py       | 11 ++++++++++-
 tools/binman/btool/pkcs11_tool.py   | 11 ++++++++++-
 tools/binman/btool/softhsm2_util.py | 12 +++++++++++-
 tools/binman/ftest.py               | 46
+++++++++++++++++++++++-----------------------
 tools/patman/cser_helper.py         |  4 ++--
 tools/patman/cseries.py             |  6 +++---
 8 files changed, 65 insertions(+), 37 deletions(-)

Regards,
Simon
