Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5FFBFA1FD6
	for <u-boot@archiver.kernel.org>; Wed, 22 Apr 2026 16:39:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3ABB4842BF;
	Wed, 22 Apr 2026 18:39:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VDvo54Fr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF93E84312; Wed, 22 Apr 2026 18:39:14 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B65C58412A
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 18:39:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7dcd9061b1aso1804876a34.2
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 09:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1776875951; x=1777480751; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O/UPfWCw/WUinCc5NO9XIMVfY8PeMfHr96iibE+Y2aU=;
 b=VDvo54FrRhyvZW43rX8gF9izTLHBzt7hwWeZWbnrqyuGEYSj3IQcLOmuq9N28oww9F
 8saMqlaxccU9X71dFQZgUTSs++oRATyR0sQ7lL8clRg9Tf30DUugGm38VdPRBxRrr4BZ
 VNFJ3b/wZFzoQBp7+HttSrgmpvjth3SFy/kBU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776875951; x=1777480751;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=O/UPfWCw/WUinCc5NO9XIMVfY8PeMfHr96iibE+Y2aU=;
 b=Lk+Th2GyTms5Xw839L13kKUVDv5cCRVewZNjZfamSw13M2X8SUazNYn9KPackZibY/
 9uuqe853xDWmq/rqqcWA0ifJED9rpDOOkmAfWYuloGN/QskynjB5Ss6gxWfadC937OzH
 K5HurydEDTr5ZNDXYE4DwO/eLxtVR3Ecd+8EI9H9E2kEOXzVHNMQ/h45KzwuQa1Xv/Ve
 Cjh9pIf2+gKP06vzfYEoSJv5OIpRYND9qwD1mnvdPw0Cq9yAH4uItV6BTZJGyGyvhjFC
 aoHyR8qr375VG22hKvokmIQZEDuRdNqNXVmtNe5w4YqCtYBuEGujWq2lWOsx3oJ3472s
 l9xw==
X-Gm-Message-State: AOJu0Yyv0M8OcjU1lSAE2Ws0w3esPe3es5FMyYYphZ2XWe6ORcOpVRNN
 iFhiHv4YwDhgGGoGBlxTLbtnBheMhBttZHb7oz/Ppz59ne/oFIFJGO3GGlTmRiTlink=
X-Gm-Gg: AeBDieucCzWS0jXULGR09XZKG+0c1K9m39UPFw7+niKijacDeFZO0xqejrrKFP/QPJM
 FRg7p/1Uu6BPFCY033QJGDxSUPg7hT1g7KZeHguZ1kgZZ0zHEMpJ8iuEjbzbIi8K/F2uDwNZR5a
 0t6JXixTBYmzIFK5TFw271ZS0HX7sMssnGl9IFNu117NH4adeXzn/dHCKVRXFF0abRzZTWDQX8O
 lfE+S5U5yCTyYfAOJEoEQHWeAcnqhrAofaQoWcxjZp36kOfIrEI1fCf24tsMcBAbe/GjL/HH9Ql
 XMXdk0S63aEarhJXADOicPu1vITq78eVlOIovnt0Pz1nSNOPhc43Hu/f67xU7GyX6dr2W9/S8HK
 U9go/W6OT5oY6QKJ4z0Y9IwtKFrkhJGDFI9b5WP81LWUZSayHq4hkhf8FOV8fifSKJQ7JV1NUue
 N+TP7cyOvfjqZYe3GH/cztI6dKspRIfbS1GnXaVbIG3wlbHB/mYu7b2oX93IeruzNIoyYNNo2lq
 sBfcRtpg/2EwWzPO9fYNfsxs/gkYecblWr/ScT53ez32d/7/OMHp9wuGeyZ
X-Received: by 2002:a05:6830:82a8:b0:7dc:dd3c:9a3 with SMTP id
 46e09a7af769-7dcdd3c1101mr4884658a34.15.1776875951450; 
 Wed, 22 Apr 2026 09:39:11 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7dc9759bfa3sm14380249a34.13.2026.04.22.09.39.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 09:39:10 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
Cc: Christian Taedcke <christian.taedcke@weidmueller.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>, 
 Martin Schwan <m.schwan@phytec.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
In-Reply-To: <20260404140328.3724864-1-sjg@chromium.org>
References: <20260404140328.3724864-1-sjg@chromium.org>
Subject: Re: [PATCH 00/14] test: Convert tests to use FsHelper and DiskHelper
Message-Id: <177687595019.1874069.6108189427119374756.b4-ty@konsulko.com>
Date: Wed, 22 Apr 2026 10:39:10 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Sat, 04 Apr 2026 08:03:04 -0600, Simon Glass wrote:

> This series adds a DiskHelper class and converts most test code to use
> FsHelper and DiskHelper instead of calling mk_fs() and setup_image()
> directly.
> 
> The FsHelper class (already upstream) provides a cleaner interface for
> creating filesystem images, handling temporary directories and cleanup
> automatically. The new DiskHelper class builds on this, creating
> partitioned disk images from one or more FsHelper filesystems.
> 
> [...]

Applied to u-boot/master, thanks!

[01/14] test: Add a helper class to create disk images
        commit: 7c69117337412d2477bc3f72e4042bca4a4e66b3
[02/14] test: fs_helper: Skip empty srcdir when creating a filesystem
        commit: 4e1793b1fb21e3896cf018fc35fc2c9c3e202138
[03/14] test: Fix broken fs_obj_fat fixture
        commit: e072d3aa24d09b8160af4596b82023ae94739c1d
[04/14] test: Convert test_cat to use FsHelper
        commit: 46a732469003314a7b7752637e5296d962dce773
[05/14] test: Convert test_xxd to use FsHelper
        commit: 17eb232e47fdee7f29e40599b0ce40dbeaaa8064
[06/14] test: Convert test_efi_bootmgr to use FsHelper
        commit: 3dc999d17ef9b4c8873358d0761a03cc5d155281
[07/14] test: Convert setup_bootmenu_image() to use FsHelper
        commit: 57e1788ee1362d9ad03e72e75026da5ae7d1b686
[08/14] test: Split out core of Fedora image into a new function
        commit: e3077e03e69183c71c9ca58e49ee9eaf7ccd9fcb
[09/14] test: Convert setup_bootflow_image() to use FsHelper
        commit: e7c46fc967fc2f180393a4e42f7c338311330c1e
[10/14] test: Convert setup_efi_image() to use FsHelper
        commit: 22ff15d191c0196cd87678a57e45e7525313770b
[11/14] test: Convert test_ut_dm_init() to use FsHelper
        commit: 28e8fcd9eabf7c5ef44aeee0315bd375247fd86e
[12/14] test: Rename setup_bootflow_image()
        commit: 8fc67f3901fd77381d9e88da78d6345d15dda5ce
[13/14] test: Convert setup_rauc_image() to use FsHelper
        commit: 1469083834bfc9f4925005bf06c0b45957055a54
[14/14] test: Convert test_fs fixtures to use FsHelper
        commit: bbc04206b5cb358e1482d06c74f2801c9ef97751
-- 
Tom


