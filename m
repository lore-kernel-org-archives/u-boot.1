Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36092C5B543
	for <u-boot@archiver.kernel.org>; Fri, 30 May 2025 14:45:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89A5D82B7E;
	Fri, 30 May 2025 16:45:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JxGQ6dH4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD6A482C03; Fri, 30 May 2025 16:45:15 +0200 (CEST)
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 868488277D
 for <u-boot@lists.denx.de>; Fri, 30 May 2025 16:45:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-60634f82d1aso642994eaf.3
 for <u-boot@lists.denx.de>; Fri, 30 May 2025 07:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748616312; x=1749221112; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uP7htRpcBt3rFMqCXwuazYXoO0mI8kW6kupbYDbjYog=;
 b=JxGQ6dH40li9WTMNezodz5UOAnmmYg6SYISxY9Gg6zwfU9o9pzf2/Lg/aEaSCxAEQr
 aVXHosGJ7GtMIW4dvHVEo8A4R35pJaj6RhK4vyxUi/Eq11GCOEj+yhNfaexWuuavO/e2
 4fNyDiElCStA+7hnQYtNrphFDG+TLl14QHyok=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748616312; x=1749221112;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uP7htRpcBt3rFMqCXwuazYXoO0mI8kW6kupbYDbjYog=;
 b=GI2XxT8a1LQ5/lkTjscgv97NMbR3EReH/C+BRdQ9UC9aFjkFfzX9NeTKJxVd+Q0A6k
 /sZ5HwYGv2/QuK1hxv/J8cA+1PL1kZYL577jQQ7D4zzXaPw7Bz2BQZwqBkHK5wnQjXjd
 IFJ156KRCdetVqfsY4Ht/krSkDkV9bm0Bw7R7bbV7KD7f3R7ueficw1V63yk/ky40yqx
 kEl0fq1zss0JrGfcJX7928E6EIvKqJW0sp/PsfmXCOutE9erjrbBCpFRQiwpD4hSlGwl
 z+VANCq3LyPnqx0POqSo3eBysV8Op/r1nICTkUXHqTU7qgx0MpGM3EQyTs9Lh2AYS2Jy
 PMAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5ZHUFJnT/H6gIPRmmdXTImbE8BJSqJsE+YO2Lg6rrYOZ7mKasqTkxpeDERQwUJoM+ItmmBuI=@lists.denx.de
X-Gm-Message-State: AOJu0YyWwW4wY617sbGus9Sm1XGRY2mp7YAgZT9+SvLiMFkruXDsDvYo
 jQaZWEABfaswCBt0KIM6WgZezTTRGlU4QsaBJInxu453YfmEdKKGHQ9LUXeFPIBoL/g=
X-Gm-Gg: ASbGncsRULYoGJEfKv7SvoyvmV04hwElSKjypKZBOH7EGTvnPLJbZaDEmk7RGN7vTxm
 4EM2EYPFGYM5mWFgOElubC/D/OsWy/E782pzM3xEhs2fzYyHflZSvwKpnys+nKK/3ew8Ige/9f7
 7IqAgqbTR4QD4nE05A8+8G1OU7VqP0AdEX7N3D5fCvGHfUgsNAzl007JsP2dOg9N1FeQpm6IyWb
 eqCUMCZkroY/u0EpXL/M5vYexAbzxqYfRxsGVnpdSjZmpBl5tvZ5v0o5z44aNo3fi0/2hwRlxvZ
 6dQINBokeiko+JG4EAfEHJLohjAmpeIPhnqZ9rS91u41N74AniXTXJ9+tpZlb/2+RTvTBkm+7hF
 PjC8kJ9aoB+Y=
X-Google-Smtp-Source: AGHT+IF7hWLTyFMd98BYi15iS9INIz90g6v0LYzKw5ldNGboLyouNX5j1Z1hZcsjlkKREqfjwNsZag==
X-Received: by 2002:a4a:ee86:0:b0:605:f34d:7e00 with SMTP id
 006d021491bc7-60c4d755a17mr2443409eaf.7.1748616312196; 
 Fri, 30 May 2025 07:45:12 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-60c1eb9c13fsm389899eaf.35.2025.05.30.07.45.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 07:45:11 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Prasad Kummari <prasad.kummari@amd.com>, 
 Michal Simek <michal.simek@amd.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Jonathan Humphreys <j-humphreys@ti.com>, Sam Edwards <cfsworks@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de
In-Reply-To: <20250520052153.307194-1-ilias.apalodimas@linaro.org>
References: <20250520052153.307194-1-ilias.apalodimas@linaro.org>
Subject: Re: [PATCH 00/24] Update kbuild
Message-Id: <174861631032.4033567.15353362577510384054.b4-ty@konsulko.com>
Date: Fri, 30 May 2025 08:45:10 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Tue, 20 May 2025 08:21:11 +0300, Ilias Apalodimas wrote:

> Last time the kbuild scripts were synced with the Linux kernel was on the
> 4.20 release. Updating directly to 6.x makes the diff difficult to read, so
> let's do the changes incrementally and bump to 5.1 first.
> 
> Since the number of comits is bug, I am splitting this in multiple series.
> This one includes most of the commits for Makefile.build,
> Makefile.lib and some from Makefile.
> 
> [...]

Applied to u-boot/next, thanks!

[01/24] kbuild: de-duplicate fixdep usage
        commit: afba83ad89d5b17fc49f47df3a8c031a23815d1a
[02/24] kbuild: disable dtc simple_bus_reg warnings by default
        commit: 31811fbb6b164ad7be63cb34146a63334b3689b8
[03/24] kbuild: Enable dtc graph_port warning by default
        commit: 1ecfa813bb2d8793e80f55278fea293e2329353b
[04/24] kbuild: remove redundant 'set -e' from filechk_offsets
        commit: 14795eba8bb3e138314d10313e95cc0862f98736
[05/24] kbuild: remove redundant target cleaning on failure
        commit: cfccf25100c26cb98d537106f0756363cb0647c6
[06/24] kbuild: skip 'addtree' and 'flags' magic for external module build
        commit: 3d21332c2f3e299836fc55d69887aa88168ac567
[07/24] kbuild: simplify rules of data compression with size appending
        commit: 39160c5fbf7b724b4113a8918b9fa3790d080a5c
[08/24] kbuild: add real-prereqs shorthand for $(filter-out FORCE, $^)
        commit: a73c41c398a1cbbe9aa7ffb644729e6cf7595845
[09/24] kbuild: remove unnecessary in-subshell execution
        commit: 603a4ade16069851b6005591426e36edd9c465cc
[10/24] kbuild: move archive command to scripts/Makefile.lib
        commit: 47a4770c7a2f6dab7ada9ba77b12bd41939db551
[11/24] kbuild: let fixdep directly write to .*.cmd files
        commit: cc571e29a8ecbba909cbb04ba062db026f70ae8b
[12/24] kbuild: remove redundant 'set -e' from sub_cmd_record_mcount
        commit: 2c180949ec3e924020edbff00884f206e120b028
[13/24] kbuild: refactor modversions build rules
        commit: 3679f24373d609b59e6434afb5253fd8c7af730a
[14/24] kbuild: change if_changed_rule for multi-line recipe
        commit: daf8f5af4c9e542ac75b2ddf7f2831b73833b49d
[15/24] kbuild: remove trailing semicolon from cmd_* passed to if_changed_rule
        commit: 82f75d890d7af1cecd30e6e9f675889b915e68ed
[16/24] kbuild: remove redundant 'set -e' from cmd_* defines
        commit: 919bd66ca8c966a30448d8befc7b59d58ba8d22d
[17/24] kbuild: remove redundant quiet_modtag for $(obj-m)
        commit: 47b6ab973728bd99247c1bc31d9608304417dd9b
[18/24] kbuild: refactor quiet_modtag
        commit: 88067ffc0c6f8c4f5142a1f8d08a206f3ed49083
[19/24] kbuild: generate modules.order only when CONFIG_MODULES=y
        commit: 1a59e6d3ba8a2f63a27a1e69286affd0bdc66dbf
[20/24] kbuild: hardcode genksyms path and remove GENKSYMS variable
        commit: bb08767f12795ba72a93948aa2b5477ad548c511
[21/24] kbuild: strip whitespace in cmd_record_mcount findstring
        commit: 25ab30f1c46efc8d2c11b01013449c09815a3f65
[22/24] kbuild: remove unused archmrproper
        commit: 0719c79e09de41aaba0ee5d86dcd578828d4aad3
[23/24] kbuild: make -r/-R effective in top Makefile for old Make versions
        commit: af1a9935708a30614e3dbf4a33e5fe90e846f598
[24/24] kbuild: add -Werror=strict-prototypes flag unconditionally
        commit: 0128b2cf4da8bd69c695d56743a666faf159d2d5
-- 
Tom


