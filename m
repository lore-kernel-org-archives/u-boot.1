Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C8D9C27C40
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 23:59:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D09D8650B;
	Thu, 24 Aug 2023 01:59:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fDd1oAuB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7DF8686525; Thu, 24 Aug 2023 01:59:20 +0200 (CEST)
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com
 [IPv6:2607:f8b0:4864:20::b30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE435846DF
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 01:59:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-d77c5414433so1136478276.0
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 16:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692835156; x=1693439956;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JddXzktE6kkUKQKs8PkuqKLP50wRxfmxI7RFLriJbV4=;
 b=fDd1oAuB5KE8T8iokQiPz8Wl51uKLExB5chpEcs8Sg6VWhNxos9fsQCo6y6mDAJY2X
 KRCVduzs7AmtsLC/t5vFBpkcI6B2XLjhFEicxvvbPuFZoUFvm7EBSTDkgmOmwm7OL3Jw
 cYklksGZNDnqGMh6V3CKGiZg7V5LfGuuY9U7U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692835156; x=1693439956;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JddXzktE6kkUKQKs8PkuqKLP50wRxfmxI7RFLriJbV4=;
 b=i6FT2c/yL8cnilSe5wHH8YyDcRZQvKrl2KnUzfsb21VQ/89B7WZngUY4cy5YwwcZEi
 CI/r0yv7IQqOMtPfCbawfdDY696z9zMXmE5XnC1ygTIYMz+1fejZd1adU5qCBv8s7dDH
 d6zBFdo+UMpV2l7W6CiUzuu7z9BvBZQZA0k0FwaUrG++J+0XyE5NN1dMJV194i2oAORh
 xoHJ8ODQ6nKv652I8UbD5+JOjhRQp0UNCSLE9icB10nerhPn6KtQLCOXvf7hLY1Zzjzg
 /96OkHaU1gbKFdEfEDsYjDDEVEH5CSI7SnTaFZGgARKdCvfthUCKu7FUMl/Pw9HqXuv7
 SInA==
X-Gm-Message-State: AOJu0YzQkA5M0vQYbJvm53VATeAQ6Mul80d3VEaoQ25VlfmvxPFgXobT
 at3gON4LtELG2hjfCXXVTUyvoodYEkUbz+akIRbHZA==
X-Google-Smtp-Source: AGHT+IHWlzoIs3m3G1ObGqa8Kr4b6RGDe01EqULTIB2z3R6iKiOFY7ZPV0/qEC1NVih4tGKBzI1MO5oxw3QNFEF0hw4=
X-Received: by 2002:a25:157:0:b0:ced:974a:1aae with SMTP id
 84-20020a250157000000b00ced974a1aaemr13716931ybb.58.1692835156425; Wed, 23
 Aug 2023 16:59:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230815162726.1524958-1-JPEWhacker@gmail.com>
 <20230823164755.2874792-1-JPEWhacker@gmail.com>
 <20230823164755.2874792-8-JPEWhacker@gmail.com>
In-Reply-To: <20230823164755.2874792-8-JPEWhacker@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 23 Aug 2023 17:57:49 -0600
Message-ID: <CAPnjgZ2hyZdMZSeUk=kAy7=UpYE4DDSfYiX4k5+q8Jr8_1Niwg@mail.gmail.com>
Subject: Re: [PATCH v2 7/8] cmd: gpt: Preserve bootable flag
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
> Sets the bootable flag when constructing the partition string from the
> current partition configuration. This ensures that when the partitions
> are written back (for example, when renaming a partition), the flag is
> preserved.
>
> Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
> ---
>  cmd/gpt.c                 | 3 +++
>  test/py/tests/test_gpt.py | 1 +
>  2 files changed, 4 insertions(+)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
