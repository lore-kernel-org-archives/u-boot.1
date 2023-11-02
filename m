Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EADD9C4332F
	for <u-boot@archiver.kernel.org>; Thu,  2 Nov 2023 22:50:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E924A87749;
	Thu,  2 Nov 2023 23:49:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ObbqJUFp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A54087743; Thu,  2 Nov 2023 23:49:30 +0100 (CET)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6961E87725
 for <u-boot@lists.denx.de>; Thu,  2 Nov 2023 23:49:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-5a87ac9d245so18101787b3.3
 for <u-boot@lists.denx.de>; Thu, 02 Nov 2023 15:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1698965364; x=1699570164; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nWlc1BcaH8TLsDHA5nxMi4zRoqUowceYHpvbmdTcef4=;
 b=ObbqJUFpFkIiA/MPJ8uliFjFsWt9Lgj9XcbWLFSuUEtwkg3d3qnkYqGj4O2yClzzL5
 kmq6uhZlLX5Y5N0LUUpvE/1MPJ7S0tEFkzhxu5diVRwWbXCQBdWMvhkplqXGZmgCOa0f
 qMLRo8Iy2NL8P70lXEonPrET2/rTY5MW6J5g0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698965364; x=1699570164;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nWlc1BcaH8TLsDHA5nxMi4zRoqUowceYHpvbmdTcef4=;
 b=LKFRse71bpudFy3zNrAmM+V4jvOxsdgX50whWoKTf9LkqwbXq+PfOIGYX751cUH3E7
 xIpW8tzvA7BvqxdPNef6AJa+A6jirdGn7e6lc0W7VOBMB+v5/Tw490JTRo+t/w0cyVrk
 mx+UK9kPYSKr2At6NW2NgNgravQ9Z7+WJzobL3xB5qnNcxipv/aSBNdzq9fgWScD7W0r
 4oM8sD1NBoPz4loEaHSi3ymxYlKl2iS5c+lMMx4ke9loA+6VmVFGoQRqfwK6qIcl8ad9
 eY2MqUNa/XTw52+o/vAHDhyOAh45zWAg8K0rLfbkyrTB7EdQatsaWeX2Fy8Rm3qsEK6Z
 kb3w==
X-Gm-Message-State: AOJu0YxssntJwLGf6Ysmmb1/et4QN7ZbwDz6WOrEkyJoEmg9re7URzsv
 uqQiH3zzr6mSIhbF09KY7O+TEt0rDHYaFUXKiS1Tmg==
X-Google-Smtp-Source: AGHT+IF8qgdLmGhN1BOuc3LYySGsO7WfDLPNrcdidMUaVxLG3xjSCUvJ2kYb7DkgjYH+2n599uO0MtzSeNk1dJP8WR0=
X-Received: by 2002:a0d:d912:0:b0:577:3d46:f90e with SMTP id
 b18-20020a0dd912000000b005773d46f90emr1173448ywe.32.1698965363958; Thu, 02
 Nov 2023 15:49:23 -0700 (PDT)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 2 Nov 2023 17:49:18 -0500
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20231014204033.3077052-5-sjg@chromium.org>
References: <20231014204033.3077052-5-sjg@chromium.org>
 <20231014204033.3077052-1-sjg@chromium.org>
Date: Thu, 2 Nov 2023 17:49:18 -0500
X-Google-Sender-Auth: MuqFNdelzeSfykcvMNODY_ZsWmU
Message-ID: <CAPnjgZ2X9U5b0NtCWB2BbmgkHEfACQ6Wvinaxhv36o7pqME2Ow@mail.gmail.com>
Subject: Re: [PATCH 4/6] binman: Replace FILENAME_ALIGN 16 with
 ATTRIBUTE_ALIGN 4
To: Simon Glass <sjg@chromium.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>, 
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
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

cbfsutil changed to 4-byte alignment for filenames instead of 16.
Adjust the binman implementation to do the same.

This mirrors commit 5779ca718c in coreboot.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/binman/cbfs_util.py      | 10 +++++-----
 tools/binman/cbfs_util_test.py | 19 ++++++++++---------
 tools/binman/ftest.py          | 10 +++++-----
 3 files changed, 20 insertions(+), 19 deletions(-)

Applied to u-boot-dm, thanks!
