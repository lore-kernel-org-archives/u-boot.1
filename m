Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 709BDCAC5B8
	for <u-boot@archiver.kernel.org>; Fri, 26 Sep 2025 14:48:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA1C68362C;
	Fri, 26 Sep 2025 16:48:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jlwu0i8z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D33B783655; Fri, 26 Sep 2025 16:48:19 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9EF058362A
 for <u-boot@lists.denx.de>; Fri, 26 Sep 2025 16:48:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-62fc0b7bf62so3151252a12.2
 for <u-boot@lists.denx.de>; Fri, 26 Sep 2025 07:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1758898097; x=1759502897; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4h/EhrgTXKhpT0sS6mtx1pSlVaeykzLbGQ4IMU8uxe0=;
 b=jlwu0i8zM/tF2p/Nl1Qxpd/x/+dmAFXkPnABwjDsfW9VbiP4exqkZoSbrhHDwnbXJU
 G8EOWjl5HDjaNYb+wzJmnMGoeNiwJnyMT1rs557YAXK979oYYgAqEEwmYgx3VvwqFg6n
 9T9bf25dTN4bjM3aphbyrzC0A5Eoq70BqyE84=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758898097; x=1759502897;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4h/EhrgTXKhpT0sS6mtx1pSlVaeykzLbGQ4IMU8uxe0=;
 b=CIREWsCSiFSWqLlk+XyPPAJMHC6PlOILt1ugBBxBwz5YHq3aVucJCtcYKYd/4nh0K7
 LtjZgTa8R4AZw/cvi7eRICUe5ddsJNAKpIC2X2jQgK2ZoKRcRJ49f8QWZSx8F+b+Rimy
 H3e6AbQ5QpHeAr2UWeJx9mlA+4SYC36cif+SwtocqiQT0DztKhn+DEzqDX2btz4asb/D
 5JVa0m1/AF/9MyP+a4AwYJHzW8vEncchxnD/7Saw71c0sxIH2GPPGT9jNzqchWYDeQ/d
 y4ZmUyXMBDi6aVuIozdAadNQ5KjCBAV+XIZzxJGILkKHy5I47S2CJIUcRKvbmfRXNEdW
 fg4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZopv8h28tKfAwo/TzfMc0W9sk9CcCfYrCrUC7cnEz499R1CfZP2PHe1nKFOyfm5xnbe61Dc4=@lists.denx.de
X-Gm-Message-State: AOJu0YyG6tyUaIqwU1neOBOBeokZ0pTTWjBrnK6O/+IaHZTcL7zC1GBt
 4VIE9VND7ggUsRVYutzQbbV/geDn+rtP05+aop1HJl2l/+3+h5xxwOM+UgsxR8BbF+R7aq/uO/O
 fmllBwKpcVPnz7U/PkBz1Z4G9LmaOG2qdpN1bQ/HtqmnoF4mkfk0=
X-Gm-Gg: ASbGncup2iD8yEvx8L9sEHfvI/t4xns6jERWhG6QvUXPBbPvH6Kl2P8lPH9wpbvdYQa
 nH7kB2HOIPpncG07wng73CRngO/wg8IH6ByN7tBo8MFKsj8gXmxi78t5tyzjE4dHiLJ95UZXiQs
 79R8gR9rlukRo0S6LQ8L5v7XzBzx99SIPX1A08SiHzQbsRG7i4EGmUHWsSWDJN0cgIRi3eBwb+n
 n8F+g==
X-Google-Smtp-Source: AGHT+IG54Hdjk3S3A4FhCcrfQKFrNSwjqQKezga0HD+30mEuElqse27La02+cc3mtBIg/ufQLgm8OwK93m5FC/nr2Fs=
X-Received: by 2002:a17:906:6a0a:b0:b2a:f5f5:4096 with SMTP id
 a640c23a62f3a-b34bc8765d2mr830738166b.61.1758898097020; Fri, 26 Sep 2025
 07:48:17 -0700 (PDT)
MIME-Version: 1.0
References: <20250924-ip_dyn_bootstd-v3-1-f67864b81a79@phytec.de>
In-Reply-To: <20250924-ip_dyn_bootstd-v3-1-f67864b81a79@phytec.de>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 26 Sep 2025 08:48:04 -0600
X-Gm-Features: AS18NWB-3pDOjWKxPfUlgjqc2GSbCmhsa2ehAcq5CoRzQPD-lCzGdlMJAzXn5Sc
Message-ID: <CAFLszTgGs8U=B8m+tWQCkZqQNLP+pAiWvqxNyCmX5Ley5JR+-Q@mail.gmail.com>
Subject: Re: [PATCH v3] bootstd: make it possible to use tftp for netboot with
 standardboot
To: Benjamin Hahn <B.Hahn@phytec.de>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

Hi Benjamin,

On Wed, 24 Sept 2025 at 01:42, Benjamin Hahn <B.Hahn@phytec.de> wrote:
>
> Add the option to load the bootscript with the tftp command (static IP)
> instead of the dhcp command (dynamic IP). For this a new function
> tftpb_run similar to dhcp_run, is needed. The selection of which command
> to use can be done with the ip_dyn environment variable, which can be
> set to yes or no. The ip_dyn variable was chosen as it is already in use
> on the imx platforms.
> Also edit the bootstd doc.
>
> Signed-off-by: Benjamin Hahn <B.Hahn@phytec.de>
> ---
> Changes in v3:
> - code styling update
> - Link to v2: https://lore.kernel.org/r/20250923-ip_dyn_bootstd-v2-1-eb59a788e647@phytec.de
>
> Changes in v2:
> - fix build error when CONFIG_CMD_TFTPBOOT is not activated
> - Link to v1: https://lore.kernel.org/r/20250911-ip_dyn_bootstd-v1-1-74f74507cc18@phytec.de
> ---
>  boot/bootmeth_script.c           |  6 +++++-
>  cmd/net.c                        | 18 ++++++++++++++++++
>  doc/develop/bootstd/overview.rst |  4 ++++
>  doc/develop/bootstd/script.rst   |  6 ++++--
>  include/net-common.h             |  8 ++++++++
>  5 files changed, 39 insertions(+), 3 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

It would be great if we could have some network tests, with fake
packets perhaps, like we have disk-based tests. The disk tests are
lightning fast. I've been trying to nudge things towards booting
without CONFIG_CMDLINE, but networking is a bit behind for now.

Regards,
Simon
