Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 227D4C27C40
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 23:58:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3782846EE;
	Thu, 24 Aug 2023 01:58:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MrHsSflH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C1311846EE; Thu, 24 Aug 2023 01:58:07 +0200 (CEST)
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com
 [IPv6:2607:f8b0:4864:20::b31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2631846DF
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 01:58:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-d776e1f181bso2797380276.3
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 16:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692835083; x=1693439883;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=o7mAVDJ1rCQ4VV/7pfT2TNaQgBdMTb68Xq40zhxaEBs=;
 b=MrHsSflHVGR553JKtcYw59PTMowtB4joO2kyIzEuxMxG0578wHxZL0q51tpWbc0MK0
 mNAaOAvNBlvR/9PZOfDx7ymLJjNLT/ZvwzM8fnz1zk7/1gcWfDJ+xfBMYzX/tOCTT8Ig
 V/0FEq9pTbIlXwjgovqTKWqgPDwR2PIYEb3XA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692835083; x=1693439883;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=o7mAVDJ1rCQ4VV/7pfT2TNaQgBdMTb68Xq40zhxaEBs=;
 b=Czc9rLl9hsvt7gL0rVd+WA+kIiNtju3YXBopEk4zKzCsr7R6KiGGje6ZFiod1l/o97
 z+uofumP+up2gUFrkc+ggu/Os2XiEdB6uchh0ZqoB5IftKXyVOBa+Ctb5v/8Hdtds/vV
 5lmfUDGXk31yqwQZc0QaNUbu6dki6/+bzpYdgprKpTGXY8kskXgmFVWGBYI9pG8Qs69b
 FrIAKX4DRlQdM5RzE4vGlQ9MH/MfifW4Vp88pDSH4x0Bs4wKp0TzeFu+00Nzf4sVES4s
 eqBDdzd8gx6e26i5uFTXByPzJzUmUJWY+sjfX93UFKyG0ADLRR4Yzba9p/Q4j72Vbo0R
 gKqw==
X-Gm-Message-State: AOJu0YyXx7Yul8eS5bPjVjZ8V7Kt/5m2uIwfkRHKBOUwyGbu8/rVuJAO
 by5SLfuLNoT7hnvFfNHPNIkHkMbZQcRjTMu/u2LB+Q==
X-Google-Smtp-Source: AGHT+IHWQcS+Ee6aVORKzxOgW7tsp8NyRr3rZCJEcFsA+Tqe2QOtwSF/L0ygMQFSwibsnLAPmUHTdPuqc6lx6J4b6Qc=
X-Received: by 2002:a25:e6c4:0:b0:d4e:ea00:dfb6 with SMTP id
 d187-20020a25e6c4000000b00d4eea00dfb6mr12949832ybh.58.1692835083347; Wed, 23
 Aug 2023 16:58:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230815162726.1524958-1-JPEWhacker@gmail.com>
 <20230823164755.2874792-1-JPEWhacker@gmail.com>
 <20230823164755.2874792-6-JPEWhacker@gmail.com>
In-Reply-To: <20230823164755.2874792-6-JPEWhacker@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 23 Aug 2023 17:57:43 -0600
Message-ID: <CAPnjgZ1EdMEoEM6k=KBSD9Vm1XCMyXh_7TQEpvsMnZP9N3D7MA@mail.gmail.com>
Subject: Re: [PATCH v2 5/8] cmd: gpt: Add command to set bootable flags
To: Joshua Watt <jpewhacker@gmail.com>
Cc: u-boot@lists.denx.de, Enric Balletbo i Serra <eballetb@redhat.com>
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

On Wed, 23 Aug 2023 at 10:48, Joshua Watt <jpewhacker@gmail.com> wrote:
>
> Adds a command that can be used to modify the GPT partition table to
> indicate which partitions should have the bootable flag set
>
> Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
> ---
>  cmd/gpt.c                 | 79 +++++++++++++++++++++++++++++++++++++++
>  doc/usage/cmd/gpt.rst     |  9 +++++
>  test/py/tests/test_gpt.py | 22 +++++++++++
>  3 files changed, 110 insertions(+)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
