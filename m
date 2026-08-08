Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 469E8C5AC67
	for <u-boot@archiver.kernel.org>; Sat,  8 Aug 2026 18:04:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EF69560625;
	Sat,  8 Aug 2026 18:04:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TeLp6jUVxmTb; Sat,  8 Aug 2026 18:04:05 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4A501605D5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786212245;
	bh=7JfcOblNTHH85szJ9eJxjalSE3sMZzrWs5dBjafx5fo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WzluMYFX6n0EqS+BUKlBz1oWvVSrx91e7FYvN2FSRaGJwtjJlPCaU6YjdQ5NUpZZI
	 FUiNaq0pBQw5eaKu6qCh0x1SrrOsDQ0XlYmlOFd3SO45+iwNb5e14GWJCrfPnvE3Vb
	 ZxCY59Vkr0k6PHXRa7y6aW1fWhCZRsHgj8PrHe2hrcvSq2fpmCJDpd/7jRuSnqY+1J
	 ZBWmZEDGUGGxwW8EwRiExyCRKdGmBDKyLxYYE6ZNNmqVtpuptWECgeRwGYnoWIFS+V
	 QwnCB7gvl24AbrjlfDeJvUATiL64TfOsM7cxDrZJ2FjeJGs2w6hpFGtPYyenpac3Wv
	 JMZshfrfIO6hw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4A501605D5;
	Sat,  8 Aug 2026 18:04:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0C3E3282
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 18:04:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id F2803605D5
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 18:04:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1wASo0Hpc8we for <u-boot@lists.u-boot-project.org>;
 Sat,  8 Aug 2026 18:04:03 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::530; helo=mail-ed1-x530.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 12C92605D1
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 12C92605D1
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 12C92605D1
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 18:04:02 +0000 (UTC)
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-6a18840e2abso680310a12.0
 for <u-boot@lists.u-boot-project.org>; Sat, 08 Aug 2026 11:04:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786212241; cv=none;
 d=google.com; s=arc-20260327;
 b=Fsu7fECrN8U8M0PIvrRVIRfMbWDXGc+FTiwZXqb7S5fR+ekIZ4itTa/+qnhtvxOd6P
 XBVVAgxs8LRdY29irwu26SJyqtAnfoqt49v2DCaC5e3cFP6vBGusmUYHuw4lDLqfFNcF
 eSl1xU6HJHE7V6LvnTdAQ55ab+5GM4QCdlto5CUhlhBfI+sTCXFRSNWERKG+qOVTg47z
 NwvJMsAv0HO7qq1Phv1SgZ6MvkG+AqS2BsPLsqKbR6Se7cvK0kibKU/qrZuDXKknnwP+
 pyftZOTR6fYLz47aixnoht0HtO8LcP1JEuMWDE5qvYZ7nLOkDSQJLONkRsU6R49gnlD+
 EXEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=7JfcOblNTHH85szJ9eJxjalSE3sMZzrWs5dBjafx5fo=;
 fh=mP41zWuH0WtrKGSq2MhviURDVmaMLU3IfrOPV/Obc00=;
 b=gxlJ3dZWougGepYVC3ZnPPCNGnFPegPbyGN3xEi/un9su5JVYSXbq5SClSClTawOho
 5dEKIhVPDOyfUq6SzjsXE9fYhG3qCQ8/XxSl4vZRA9TbAvxjoZI07efuHvsHarglAXFI
 zSxoRipCT4GoAtN/eNUrU9THz9507/0SxU7xOVKP5wlW2EUz8qFsZGp5dBylVgJxqTV3
 lKdBUiO98Oi/IzK2QAjxDN/7ycMVN+l0q6VKXiTZ9B2eqwX88/0f8w7tayJK/kXTTQj2
 APlGN9pLPwwauTraxFsEn+1PiQqpi3OdODGmbJFpoz4PD5eOF2x9p/3p4prZLDnuM1z4
 TkDA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786212241; x=1786817041;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=7JfcOblNTHH85szJ9eJxjalSE3sMZzrWs5dBjafx5fo=;
 b=mCqFYgpdHx6vECiIH+nIchyDfNUxI/i4/8sY4kqij2zpZB+EQ/8SgJXCDh7IgVepgM
 GG+qbofVQGpM1iGHuz5DEHmoOJMgmZrOhar0Ztmk/tBJQV61Pr6W5fnM0NHwCTcCRE+/
 g22U6GBSFzJrKImAynuDZCP7thv6XtwzlSwzZJMMxLpsCu7jI2xbHCPzL0MosGcTrUfC
 5hcRfLuDykUipRtXWZUvQKUQZlvmnObKYgWeRzmxvqd9nRHiHw1n6mm16G59ytCVneK5
 i53gznvHX5lpTZcCxO0x5wkHAR8sDqxm0v8quCStAUu0bWSKl9C8DMIhnD50gwguS1OO
 0VLw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrdZUrxJzER9NVVh/FJoX1enXwVN4wAUu6GRX9O0yI13PI/fqL/dlcy+23b0Q1sqIy3BlbKhNM=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yywo4sKrftTMRhq10mp+fDxx3Ro9oLa7aRhdKUsa7a8MSTBFLg2
 P/03jdh3h9wlbmMtO/PEkkn/OBoFfsK27+tquGAqy2Yb6D5EDbWEaIFs0m7IKtz+kWVHtcLRCZA
 38ubiBGUdyrwfaYYtzMQt4q1Amr64p4123ZGZN0g1
X-Gm-Gg: AR+sD12Hi5xsWEA3dZ9YfFP+b8JZ8nHX7079oRuDB/hOSLb3h1Me+sqlVOs4adAQClD
 kAomOXhrTkuMv1FcMypLTHiU2P4vnRL4iMKojBa36RfUTnG9k8itZFQflF7sgsYhW+kW+EDiUo0
 JLKSlJkp+/MDjr/yBFw8TBeuWSl9EaMkiTuBGFR5OnqZyDXd+taFutk1kzb8DoJRt2/AtfK/Md3
 cgjaFF+GG5Irm182HWUze9sNcLrR3bIxrAX0+SjnyTjD5In3D+PMF1xDWefLt4igvLN7x+5uI7J
 6swlPYXKp2YLbvwv8h7kYGgPz8PtZ0CErMeP3GsmGi4=
X-Received: by 2002:a05:6402:22fc:b0:6a1:7ccd:5205 with SMTP id
 4fb4d7f45d1cf-6a17ccd5664mr10261850a12.2.1786212241143; Sat, 08 Aug 2026
 11:04:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260728161904.96004-1-james.hilliard1@gmail.com>
In-Reply-To: <20260728161904.96004-1-james.hilliard1@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 8 Aug 2026 12:03:49 -0600
X-Gm-Features: AUfX_mw90lyHwYvX_aQDfdjmChsNiJXE92XbIbkvsRphVfWBEF7OPZy7F1Afb-k
Message-ID: <CAFLszTgX5zFSxmfra5cv6SqodZd1EZXFUhA8MymOYqsL4VXEeA@mail.gmail.com>
Subject: Re: [PATCH v2] tools: fit: sign all config image references
To: james.hilliard1@gmail.com
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Ludwig Nussel <ludwig.nussel@siemens.com>, Simon Glass <sjg@chromium.org>, 
 Daniel Golle <daniel@makrotopia.org>, Aristo Chen <aristo.chen@canonical.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Romain Naour <romain.naour@smile.fr>, 
 Shiva Tripathi <s-tripathi1@ti.com>, Randolph Sapp <rs@ti.com>,
 Anton Ivanov <anton@binarly.io>, 
 Marek Vasut <marek.vasut@mailbox.org>, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1786212241; x=1786817041;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7JfcOblNTHH85szJ9eJxjalSE3sMZzrWs5dBjafx5fo=;
 b=adYv2kkTxZEBDqpjHRBamO6VJKyD+O3SGHZpb8VXzSB0ZlDNGrc9MIhBRr/pscdcoY
 EWcsXJM4FI5LLLLyHmTSexzdEwiWoG/XmNs77NoquF0potGh22anp7HWglIJnh5TWhKw
 Sxif07IOR8DAUchEaDRZUcgCsh71XIFpouhEU=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=adYv2kkT
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

On 2026-07-28T16:18:39, James Hilliard <james.hilliard1@gmail.com> wrote:
> tools: fit: sign all config image references
>
> Target-side configuration verification builds the signed-region list from
> every image-reference property in the selected configuration. Host-side
> signing still uses either the signature node sign-images property or the
> legacy kernel/fdt/script default list.
>
> This lets mkimage generate configuration signatures which U-Boot cannot
> verify when the configuration references other image types, such as
> firmware, loadables or ramdisk entries. It also lets the host and target
> disagree when sign-images names only a subset of the configuration images.
>
> Build the host-side signing list from the configuration properties in the
> same way as target-side verification. Use one shared property classifier so
> the host and target cannot drift apart again. This makes signed
> configurations cover the root node, the configuration node, every
> referenced image node, and its hash/cipher subnodes, regardless of image
> type.
>
> Warn when a legacy sign-images property is present, since it no longer
> limits the signed image list. Require every referenced image to have at
> least one hash subnode. Add sandbox coverage proving that a firmware
> reference omitted from sign-images is still recorded in hashed-nodes and
> verified.
>
> Update the signed-configuration documentation to describe the same rule and
> the hash-subnode requirement.
>
> Fixes: 2092322b31cc ("boot: Add fit_config_get_hash_list() to build signed node list")
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
>
> boot/image-fit-sig.c                               |  9 +--
>  boot/image-fit.c                                   | 17 +++++
>  doc/board/ti/k3.rst                                | 10 ++-
>  doc/usage/fit/beaglebone_vboot.rst                 |  5 +-
>  doc/usage/fit/sign-configs.rst                     | 13 +++-
>  doc/usage/fit/signature.rst                        | 26 +++----
>  doc/usage/fit/uefi.rst                             |  2 -
>  include/image.h                                    |  9 +++
>  test/py/tests/test_vboot.py                        | 11 ++-
>  test/py/tests/vboot/sign-configs-algo-arg.its      |  1 -
>  test/py/tests/vboot/sign-configs-sha1-pss.its      |  1 -
>  test/py/tests/vboot/sign-configs-sha1.its          | 11 +++
>  .../tests/vboot/sign-configs-sha256-pss-prod.its   |  1 -
>  test/py/tests/vboot/sign-configs-sha256-pss.its    |  1 -
>  test/py/tests/vboot/sign-configs-sha256.its        |  1 -
>  test/py/tests/vboot/sign-configs-sha384.its        |  1 -
>  tools/fit_image.c                                  | 12 ++--
>  tools/image-host.c                                 | 84 +++++++++-------------
>  18 files changed, 121 insertions(+), 94 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
