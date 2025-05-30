Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E298BC5AD49
	for <u-boot@archiver.kernel.org>; Fri, 30 May 2025 15:46:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 492A482B0E;
	Fri, 30 May 2025 17:46:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="e9+KT+LA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C35FD82CB6; Fri, 30 May 2025 17:46:48 +0200 (CEST)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F33182991
 for <u-boot@lists.denx.de>; Fri, 30 May 2025 17:46:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-70e78e04e48so17437007b3.1
 for <u-boot@lists.denx.de>; Fri, 30 May 2025 08:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1748620004; x=1749224804; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aG0TIYbXwjvRiIfdPyGfIIae5cHhspyEXX2jr3YIVpw=;
 b=e9+KT+LAZw3cy2YJ0JaMFDtXJMURsc3GCkBBQgwfBSu0bkGWp/RDBlVSRvOxT9bUP/
 /qaLinWkYvjFSl9hnSGfqRihUId6DfTGpMtNi8BVtiURou5fMpBMQQ/ghoeH1HsHVBBJ
 uovdq2jwL/MXc5PJyUseqedAUkeiuu7V2K6e7fKzOQP+/F9MGIGDpJTF+9PtZ2Fz5SOJ
 pSi9ogvpXXW2+OKpKAfR7lGtBJUbyw8ERqMXqncIyyWtOP2R3YeirEzW+5Td1bGLEy88
 NJwwPS6yKX85gHGn8oc1LyToW4OvHetlLMGiA4k0OeVokDKu0xI2PjB/Nxg4smJFw4FO
 IMnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748620004; x=1749224804;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aG0TIYbXwjvRiIfdPyGfIIae5cHhspyEXX2jr3YIVpw=;
 b=boeY/S3ojpWAMpT6aZa/RbZqJ33XHFGbU8Bl5oeBv1ExPm0smT1Hxw1J8ank8Jck1K
 HP//hc2mzHhLxNydxZ57VQSkERUwsjrs4h/w9xCRjnSx+7iBo8+UPmx4hc4iTu/gzEmZ
 f0d7GsH9uNoUOgJc3yRuw5W0ULDXSsNiiomvLK4kKuzKbQGF+EfHMtc+vAXMZ6rX15Hj
 RzslA/uQN3jBo6kqG+QV5nCRobrnEqBKO5ACgntckPih4LNbYpIH3VF/YaHQXxlwZ0vU
 Fx1NMGpa7UkKwP77s0/gtUhHjLxaGdj6bX5121B8VZI7YSc2bTjj48QFP1HIWqnfKXel
 Ve1A==
X-Gm-Message-State: AOJu0YwvXcaDVDv3M/WyLiKFhQAMTdUI9m6yOXxs66bdqx8lvkySfG9v
 x+czdEjH3z42NFLoTrNFZc+7b3HL7N7zu/EYKwJGQIofKrp1f29f1gzqAbr6uUK55NsohaQDUDN
 5/PjJNGUQMjPSGkQLxQwHDfpEtMdJO4Tzx9zPov1EkA==
X-Gm-Gg: ASbGncuYOLSRlWCe0mWIeWyRWRoDCV0VMT5JLO//3Q6AvWkBD4nLk4G+FBwL3JYIVFD
 yERGczfIJs5FYpqOayrYUqYXzeiZJHX37wvnGOffiEWe/5TR/x88iOqWm6zDtFttifUCdLTlOg6
 4G2gkhVjvEmuw98w9vuU/sBrJ6A2qAu+NP
X-Google-Smtp-Source: AGHT+IEjL2M+e3dksbE0WhIW/BcMEzYmzQCwjRmU6G2TaEkFma3k47e+1zBHKBeolQxGtfkywrqrayEqSwNU7zoJ0AU=
X-Received: by 2002:a05:690c:4485:b0:6fb:1c5a:80ea with SMTP id
 00721157ae682-70f97ff9266mr56743637b3.32.1748620004301; Fri, 30 May 2025
 08:46:44 -0700 (PDT)
MIME-Version: 1.0
References: <20250521151516.16729-1-jerome.forissier@linaro.org>
In-Reply-To: <20250521151516.16729-1-jerome.forissier@linaro.org>
From: Tim Harvey <tharvey@gateworks.com>
Date: Fri, 30 May 2025 08:46:33 -0700
X-Gm-Features: AX0GCFscfLdYHD2uBtjWmFQC23-bAQGV_iZ-I_gqNRZawy9a5slHL2-nz_akHRo
Message-ID: <CAJ+vNU08-=eWAceEedRg7RabqB-BKO_1F+8EkDHB8zHg79VK3g@mail.gmail.com>
Subject: Re: [PATCH 0/3] sntp for NET_LWIP
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: U-Boot mailing list <u-boot@lists.denx.de>,
 Adriano Cordova <adrianox@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, 
 Joe Hershberger <joe.hershberger@ni.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Michael Walle <mwalle@kernel.org>, Michal Simek <michal.simek@amd.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Ramon Fried <rfried.dev@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, May 21, 2025 at 8:15=E2=80=AFAM Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> Implement the sntp command with lwIP (CONFIG_NET_LWIP=3Dy). SNTP is
> supported as an app in lib/lwip/lwip/src/apps/sntp/sntp.c so this is
> mainly about adding that file to the build and writing do_sntp() to use
> the sntp_*() API and run the receive & timer loop. There is a patch to
> extract a small bit of common code from net/sntp.c to avoid duplication.
> The QEMU arm64 lwIP defconfig is updated to provide the sntp command by
> default for convenience.
> I could not test the case when the NTP server IP is provided by DHCP. If
> someone has access right away to such a configuration and in case it
> does not work, please let me know.
>
>
> Jerome Forissier (3):
>   net: extract function net_sntp_set_rtc() from sntp_handler()
>   net: lwip: add sntp command
>   configs: qemu_arm64_lwip_defconfig: enable CMD_SNTP
>
>  cmd/Kconfig                       |  13 +--
>  cmd/net-lwip.c                    |   5 ++
>  configs/qemu_arm64_lwip_defconfig |   1 +
>  include/net-common.h              |  13 +++
>  lib/lwip/Makefile                 |   1 +
>  lib/lwip/u-boot/arch/cc.h         |   4 +
>  lib/lwip/u-boot/lwipopts.h        |   4 +
>  net/lwip/Makefile                 |   1 +
>  net/lwip/sntp.c                   | 128 ++++++++++++++++++++++++++++++
>  net/net-common.c                  |  28 +++++++
>  net/sntp.c                        |  23 +-----
>  11 files changed, 195 insertions(+), 26 deletions(-)
>  create mode 100644 net/lwip/sntp.c
>

Hi Jerome,

Thanks for the continued work on lwIP!

For the series:
Reviewed-by: Tim Harvey <tharvey@gateworks.com>

Note that if this is merged before my series we'll want to have a
followup that removes the sys_check_timeouts() after net_lwip_rx(udev,
netif), or if it is merged before my series I can send a v3 that does
it.

Do you have a list of lwIP features you're still working on? I'm going
to be moving the Gateworks venice boards to it as things look pretty
good. The only thing I saw that was missing was TFTPPUT which I don't
really care about.

Best Regards,

Tim
