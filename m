Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58B8DCD37AC
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 13:30:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0E48838D7;
	Mon, 11 May 2026 15:30:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="h/upgWGH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42A96838D7; Mon, 11 May 2026 15:30:11 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE68080398
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 15:30:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-6763cc8775cso9603763a12.0
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 06:30:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778506208; cv=none;
 d=google.com; s=arc-20240605;
 b=AQLiCY0fgaXnnOc7b3hBBGXIohtwioKcVYBDXfylvaw5Uw8GxHfsiBsvqcT44gIJfR
 uPLCuBlUigyVlvfCwpiEknXh03rnh1jvVs5AcK5efVMjKe8ipiFGnIV/DAeoTF3+fMcU
 s8AYZKrhUDlskZv/V1ABntvUdc66Beeh+Gi2EO6jUzGea6V3P+ccWc5YBYCKnSBvZ7Of
 2EGovcTMZTVmNluuyu1oBqF5XJFpor4dDFueKOeJy+/XST+jZRi28rPJFA1JuncPEhOc
 57phrC8ToBhzIIj3DzzOjW+CypxSs/bFwgG9HA2jvWzZAzr26umeg7s8O+kX9f/HhJsF
 pCcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=JjfE+F6s2ZbNPQcsZgsykBwKdYDljSABQbHVqqaaXKU=;
 fh=MNq73r8Ygn0hn7yFFjGDct0t/82JW27+1b75IbPhr/Q=;
 b=ZDDucehlrhaj+QKDBJjAzQXLCwGn4esE4kVt4hEvfKZWiGjvDbUgVLV4BJcngWjyQC
 BF1d5ub8Bc46gkL9zSTTvAPlMYLtbh1xdZK2riBIC2DGh728MZO5DJNH/W/TDDrrvJql
 YzY/m2JsT8W3F+4h6MQT9v2N4vyyINI0LroYusRkB2lBvoJKr2c8m0fdyTdWg6ON0PnT
 SYqfUNswtLVaQB4Mc4KspziWRFuWPPLO5aR5yFtCthp5lK61PeUdrQw+pK2UMFzZnlWl
 XOoxAN9dbze8aHY3dOMIbsHEZdilkl59Sn1aeoEfzxmrRxZqMxtHYBG77Q4/nQJfU7c5
 FAag==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778506208; x=1779111008; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JjfE+F6s2ZbNPQcsZgsykBwKdYDljSABQbHVqqaaXKU=;
 b=h/upgWGHIBShotDKVxGqwxZ7oceX7Ino/pvIDahWCkZKRgGlrt3y1xCdzDd+RaNkh7
 wBanlZrwq9IWHmIiM7bYhWZORLDlZrGDIX6k1I3XKvcLGPeeCWyaz2HV+/43mghXzX8C
 WjFGwQE/FzbJIpsPJqyFeYlFU2CbvwcsC4ggc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778506208; x=1779111008;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JjfE+F6s2ZbNPQcsZgsykBwKdYDljSABQbHVqqaaXKU=;
 b=nC54noZRg4Dn1VOHfRzilFPHbjV/w8A8qZNqkdowkDiHBe/BpyU3iZEVs7WJcr1fuK
 HRlqNP+53406ke5ZfMlC93DNm/qeg4BjrDMJYa1m3fIc6nUH+Nu/q0Dz6xPzyJN0Mnjv
 Ibl0TuZAsQvP6l3c3JOR3g9Tvs5bHhm0/xEifLjzAHiJQQkgknoBPVP68Y6Zqji75ZRR
 UsmjMBpVIxztAEqGsTh5n3JzoeoImsTkuVy0XuGY5LgBtgyBSxS5zeFqZPfvaNZ48pRD
 9L25BxF8KHtvSWXg0vUN97O9D/0hK5k4KdKF6Pyb1COeaouy2iVMxFRlTH2ANd2LvPQH
 f9Lw==
X-Gm-Message-State: AOJu0YwYRbVsBxooeAZyE6uIucMT+iFRQeVMjf+gj8TPvcSJ6Ir6WPMi
 2QgOXnoJ5NACi1O2/4FMRutLzOq/dQW3h3BMA/O0qv2BCw7qTHE9UrogUO64+5Cbs2BTfg5fi0K
 VaZMxNgBqOQA8bZ8bUmyqRxrIYc0KkRQ4J0FZ8l6Y
X-Gm-Gg: Acq92OFy7IZXJcTDj2h4IwJYw1TMcg0aAfeH/t+u4PoArdJqDY6fh49qul9BTI+poAa
 fmATkrodI6R+nQa4Ik3GyzYTrWvy41Wu0xIQkbNM3mYJ8Bwl4pkVZEOnnBu8Ef0Rtm8DRdscIwr
 HCHIc5cQ0DqHUdifiDxesfKGOJYvPOqsF1p1kE8ZHp2kjRu6j8GFnb/3a9JK6pnoO7t47W5JBep
 qsUYGXrxxGFx6SzKeVpCUDIONSiJzmOcb5o9IusaTSpUiqEvlfHk8h7WEXpf+/5fT6k/PipzMPV
 P4Wy2Q==
X-Received: by 2002:a17:907:da17:b0:bc6:3122:c241 with SMTP id
 a640c23a62f3a-bc85c890f00mr884516966b.18.1778506206699; Mon, 11 May 2026
 06:30:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260511085857.3933053-1-aristo.chen@canonical.com>
In-Reply-To: <20260511085857.3933053-1-aristo.chen@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 11 May 2026 07:29:54 -0600
X-Gm-Features: AVHnY4Lg4XVR9wvuDUpHJcF5pKVCmG9l3jD_RQJuL3ZhRxhzRofxo9uKi1e2U8c
Message-ID: <CAFLszTj8kmRyf5_GrcP2zKRxouCwr3BNoPOk6GWse8RRVQ2BJg@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] test: fs: Use shared generate_file from utils
To: aristo.chen@canonical.com
Cc: u-boot@lists.denx.de, Huang Jianan <jnhuang95@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Joao Marcos Costa <joaomarcos.costa@bootlin.com>,
 Richard Genoud <richard.genoud@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, linux-erofs@lists.ozlabs.org
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

On 2026-05-11T08:58:50, Aristo Chen <aristo.chen@canonical.com> wrote:
> test: fs: Use shared generate_file from utils
>
> test_fs/test_erofs.py and test_fs/test_squashfs/sqfs_common.py both
> defined a generate_file() helper that writes a file of a given size
> filled with 'x'. The two functions were functionally identical and
> differed only in parameter names and docstrings.
>
> Move the helper into the existing test/py/utils.py module, which is
> the established home for generic test utilities (md5sum_file,
> PersistentRandomFile, attempt_to_open_file). Update both call sites
> to use it.
>
> Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
>
> test/py/tests/test_fs/test_erofs.py                | 16 ++++------------
>  test/py/tests/test_fs/test_squashfs/sqfs_common.py | 22 +++++-----------------
>  test/py/utils.py                                   | 13 +++++++++++++
>  3 files changed, 22 insertions(+), 29 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
