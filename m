Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0878AC5B543
	for <u-boot@archiver.kernel.org>; Fri, 30 May 2025 15:42:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C9E082102;
	Fri, 30 May 2025 17:42:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GXsBCyq/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 560DF8334F; Fri, 30 May 2025 17:42:37 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 526DB801BE
 for <u-boot@lists.denx.de>; Fri, 30 May 2025 17:42:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5efe8d9ebdfso3968355a12.3
 for <u-boot@lists.denx.de>; Fri, 30 May 2025 08:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748619755; x=1749224555; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FvMIsUzzc0tOXtvFPsxIJC2RaZztvCDyHX+g54JGuaQ=;
 b=GXsBCyq/cIwub1Y1qc9r44xw+AJcjECQ3RedTl2Cj9cMUTT5pJ7YQAtzDpiuB0iIL/
 x1+d0HRGqB8lSpHLYsHHFczF/UJl2s2ljdErfLsdjmHSaVnJJTehP6090JSViu5Jt8oX
 06fWOBwitJUH8lCFsgpttxUpgsrWdlMk6ZBZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748619755; x=1749224555;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FvMIsUzzc0tOXtvFPsxIJC2RaZztvCDyHX+g54JGuaQ=;
 b=AJ8U0cFtxjH/pwrWkOYopgK+Y0515eCyOv8Vijmlxu4pmE6n96LG2zEk+X25c7Lk1W
 NK7k4EDEjVuW7kuTRecZJVAvzOEp+SiG0uXTMc+wSgK8Yh07ni5Y5DCu8dklip7Jt84j
 CheqeDJq3bL3HZli64wkF3qeJl96wjcefYgGtGTkX+FkJeHpfyD3QHHkBGbEbydWdGCS
 JYGsMBTvZG/KMbvGbsFiN6On7htTXxfkAayR1ST4cH2LfAMABA7CFzyMKJglyMz98NKH
 QCJMGH5T2gv3BG2UL0ul+BYn/Ce/KjwAIHWgKsWO7lpAMI6ezYaV1VVu+IuI6J8UERAU
 jlLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+5gZHqx8SnAvIW8JM53Ymrdw3o3YNm56fcSGz2692njNdTMf2gsY4475SR7okKiS31oE6TGc=@lists.denx.de
X-Gm-Message-State: AOJu0Yzn3yWzKBEIPIVcywqJHJmnzES7ImkbODns0Q0ac3lscfT2vG6v
 tCDwjGWZ2eqZ3Ro/MwX1Jol7ubSfMzgWicc/aYU0hl79lDJqQSx9cIjWc8s4yyMGesaU3WngKkj
 ppQAK5vAaxczDAY9T4QmHDbGLheiwyMrusomjJL+g
X-Gm-Gg: ASbGncup9qLZTVZRMgViHNXcVzR7aK3GoeDAUIezRk8emi0r8zaFj7Pq7UqhlFVzbOM
 1sQ9uFGLZS8zVeXCdmdr3L+YCMffe3SBjcMEBN4IMFIxEOYqC07qh6Y8drxs9VdW5CQkdGkw7B7
 Snxha8kZIK3a5DTNXO/9wxaTZm6VHmBHw=
X-Google-Smtp-Source: AGHT+IHZ4gNlsUeoY2ZdWLMfknT4sT04kgQ4RApUHqX4TWXpl3/nf1bYJJKZ5OJftWB88gTMv6KnWzWFm7D6k9jw2YM=
X-Received: by 2002:a05:6402:51cb:b0:600:1167:7333 with SMTP id
 4fb4d7f45d1cf-6057c1c291emr2521702a12.10.1748619754487; Fri, 30 May 2025
 08:42:34 -0700 (PDT)
MIME-Version: 1.0
References: <20250520052153.307194-1-ilias.apalodimas@linaro.org>
 <174861631032.4033567.15353362577510384054.b4-ty@konsulko.com>
 <CAC_iWjK2q0nUU3homG4hxp31dYBq-g_VO6xzkS-nGF+JcagJpQ@mail.gmail.com>
In-Reply-To: <CAC_iWjK2q0nUU3homG4hxp31dYBq-g_VO6xzkS-nGF+JcagJpQ@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 30 May 2025 16:42:20 +0100
X-Gm-Features: AX0GCFtCmE02cvSkhldgE8hoz652rsNMJPoqYCHjAK4Zp09qlRry-OHIcBSqMBI
Message-ID: <CAFLszTjhM0-EwrQKdq028c45LMEiKhrsZq4NoxgkA3Lc_y4SHw@mail.gmail.com>
Subject: Re: [PATCH 00/24] Update kbuild
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Peter Robinson <pbrobinson@gmail.com>, Prasad Kummari <prasad.kummari@amd.com>,
 Michal Simek <michal.simek@amd.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Jonathan Humphreys <j-humphreys@ti.com>, 
 Sam Edwards <cfsworks@gmail.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 u-boot@lists.denx.de
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

Hi Ilias,

On Fri, 30 May 2025 at 15:51, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Thanks Tom.
>
> I got another (shorter) series, that I'll send later today. Once this
> is reviewed/applied I got a single patch that brings on par with 5.1.
> Then bumping to 6.x should be easier.
>
> /Ilias
>
> On Fri, 30 May 2025 at 17:45, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Tue, 20 May 2025 08:21:11 +0300, Ilias Apalodimas wrote:
> >
> > > Last time the kbuild scripts were synced with the Linux kernel was on the
> > > 4.20 release. Updating directly to 6.x makes the diff difficult to read, so
> > > let's do the changes incrementally and bump to 5.1 first.
> > >
> > > Since the number of comits is bug, I am splitting this in multiple series.
> > > This one includes most of the commits for Makefile.build,
> > > Makefile.lib and some from Makefile.
> > >
> > > [...]
> >
> > Applied to u-boot/next, thanks!
> >
> > [01/24] kbuild: de-duplicate fixdep usage
> >         commit: afba83ad89d5b17fc49f47df3a8c031a23815d1a
> > [02/24] kbuild: disable dtc simple_bus_reg warnings by default
> >         commit: 31811fbb6b164ad7be63cb34146a63334b3689b8
> > [03/24] kbuild: Enable dtc graph_port warning by default
> >         commit: 1ecfa813bb2d8793e80f55278fea293e2329353b
> > [04/24] kbuild: remove redundant 'set -e' from filechk_offsets
> >         commit: 14795eba8bb3e138314d10313e95cc0862f98736
> > [05/24] kbuild: remove redundant target cleaning on failure
> >         commit: cfccf25100c26cb98d537106f0756363cb0647c6
> > [06/24] kbuild: skip 'addtree' and 'flags' magic for external module build
> >         commit: 3d21332c2f3e299836fc55d69887aa88168ac567
> > [07/24] kbuild: simplify rules of data compression with size appending
> >         commit: 39160c5fbf7b724b4113a8918b9fa3790d080a5c
> > [08/24] kbuild: add real-prereqs shorthand for $(filter-out FORCE, $^)
> >         commit: a73c41c398a1cbbe9aa7ffb644729e6cf7595845
> > [09/24] kbuild: remove unnecessary in-subshell execution
> >         commit: 603a4ade16069851b6005591426e36edd9c465cc
> > [10/24] kbuild: move archive command to scripts/Makefile.lib
> >         commit: 47a4770c7a2f6dab7ada9ba77b12bd41939db551
> > [11/24] kbuild: let fixdep directly write to .*.cmd files
> >         commit: cc571e29a8ecbba909cbb04ba062db026f70ae8b
> > [12/24] kbuild: remove redundant 'set -e' from sub_cmd_record_mcount
> >         commit: 2c180949ec3e924020edbff00884f206e120b028
> > [13/24] kbuild: refactor modversions build rules
> >         commit: 3679f24373d609b59e6434afb5253fd8c7af730a
> > [14/24] kbuild: change if_changed_rule for multi-line recipe
> >         commit: daf8f5af4c9e542ac75b2ddf7f2831b73833b49d
> > [15/24] kbuild: remove trailing semicolon from cmd_* passed to if_changed_rule
> >         commit: 82f75d890d7af1cecd30e6e9f675889b915e68ed
> > [16/24] kbuild: remove redundant 'set -e' from cmd_* defines
> >         commit: 919bd66ca8c966a30448d8befc7b59d58ba8d22d
> > [17/24] kbuild: remove redundant quiet_modtag for $(obj-m)
> >         commit: 47b6ab973728bd99247c1bc31d9608304417dd9b
> > [18/24] kbuild: refactor quiet_modtag
> >         commit: 88067ffc0c6f8c4f5142a1f8d08a206f3ed49083
> > [19/24] kbuild: generate modules.order only when CONFIG_MODULES=y
> >         commit: 1a59e6d3ba8a2f63a27a1e69286affd0bdc66dbf
> > [20/24] kbuild: hardcode genksyms path and remove GENKSYMS variable
> >         commit: bb08767f12795ba72a93948aa2b5477ad548c511
> > [21/24] kbuild: strip whitespace in cmd_record_mcount findstring
> >         commit: 25ab30f1c46efc8d2c11b01013449c09815a3f65
> > [22/24] kbuild: remove unused archmrproper
> >         commit: 0719c79e09de41aaba0ee5d86dcd578828d4aad3
> > [23/24] kbuild: make -r/-R effective in top Makefile for old Make versions
> >         commit: af1a9935708a30614e3dbf4a33e5fe90e846f598
> > [24/24] kbuild: add -Werror=strict-prototypes flag unconditionally
> >         commit: 0128b2cf4da8bd69c695d56743a666faf159d2d5
> > --
> > Tom

This is fantastic, thank you Ilias!


- Simon
