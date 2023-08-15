Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEAF2C001B0
	for <u-boot@archiver.kernel.org>; Tue, 15 Aug 2023 18:40:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E870869A5;
	Tue, 15 Aug 2023 20:39:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="C7tjrLqx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9675C869AE; Tue, 15 Aug 2023 20:39:54 +0200 (CEST)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7F7C869A7
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 20:39:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2b9f0b7af65so86760511fa.1
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 11:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20221208; t=1692124791; x=1692729591;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XpM/YwcXzFq76Oum+707JqDHr52/oJ4L4f7/ExpcSko=;
 b=C7tjrLqxJeGkZPECBg6BI8IXAa4fNA4Gwy2DJ2P5HtMEuUidNWk/Vg5J8kl2yb9fmV
 Zjxy7rdfqJ/vYEVQX0O7cWGdMWBxyIh5TS7uba7AYJ0nzrXfJDXzd6A4T+3Uj4jQ7l5d
 s3QGrJ6khLDLGeFCPeme9NUdKHxcY3qF4+HCF/HthTEdlUj4ca/intzsRsqd8LXCbK74
 B+e02V5Pp/jE2Ollaliz7JE1mjPBVdDzz1k7StdoPGcsCJxehM+kBdZFJ/nsTc5WqXFC
 B7HkzUhhP1uxzvCIwSTxuhy6WYaYdRUQxmmHvF2GuPxX2nU4ix0dGtJekAJ9jnIw4Q9C
 zUyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692124791; x=1692729591;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XpM/YwcXzFq76Oum+707JqDHr52/oJ4L4f7/ExpcSko=;
 b=HpDcekF5Cjc0CnCEWRhKjDpeXx0rG0Sxj8adle9mgIXVNiZ0buOlot17ntb3JOV2Pg
 pvfbXRrOv0V7DKJz8LuYM/sYjewMgvYSLuhf7jP6esEEtPX+Ph+Hv+Px6xMC/EnYFc9r
 tydbBtz/D5xp9Y7zODizbZGvQljaFtYpmM9KwPbZvoicwPPYau896L5pOZpkuXLBehpy
 XkGOnViBjrynJFCd1JVdwjhkvgeZJ5S+xTaPWChy8Cke+l4dKx0u1fXp11k5MNtF1+Yq
 x5liyKsDVZo9B/mUdtnQf3HTa3wKZ8lXMFumHQRAC8UqV4Ig0n4UMA43SKzLA9tSFBLC
 Qqaw==
X-Gm-Message-State: AOJu0Yw7idm8BHPgsEgZApVEDIbQor3z37jE6asssgADSupsRYwoqkNQ
 41CpMBWKU5TFucziJWOlL2VpXZhQunCtuFZnwL9+L3zgyPKNgvXlstE=
X-Google-Smtp-Source: AGHT+IG8AIsRXqWdZkLu4LQZ8qzKanHbpiOjIS78jJVzY2kFn5QSe1m5U/sJcQWDHckZ2aliFkIGtViP0uShp5a733Q=
X-Received: by 2002:a2e:7c18:0:b0:2b9:20fe:4bcc with SMTP id
 x24-20020a2e7c18000000b002b920fe4bccmr10221707ljc.21.1692124790699; Tue, 15
 Aug 2023 11:39:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230815162726.1524958-1-JPEWhacker@gmail.com>
 <20230815162726.1524958-3-JPEWhacker@gmail.com>
In-Reply-To: <20230815162726.1524958-3-JPEWhacker@gmail.com>
From: Simon Glass <sjg@google.com>
Date: Tue, 15 Aug 2023 12:39:38 -0600
Message-ID: <CAPnjgZ007uu9EFw4sn8A-9u2Fj7DH9aC=_Te0tEVqPuxrx-8FA@mail.gmail.com>
Subject: Re: [PATCH 2/6] cmd: gpt: Add command to set bootable flags
To: Joshua Watt <jpewhacker@gmail.com>
Cc: u-boot@lists.denx.de
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

Hi Joshua,

On Tue, 15 Aug 2023 at 10:28, Joshua Watt <jpewhacker@gmail.com> wrote:
>
> Adds a command that can be used to modify the GPT partition table to
> indicate which partitions should have the bootable flag set
>
> Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
> ---
>  cmd/gpt.c | 80 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 80 insertions(+)

Can you add doc/usage/gpt.rst and a test?

Regards,
Simon
