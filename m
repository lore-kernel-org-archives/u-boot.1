Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1399CDB483
	for <u-boot@archiver.kernel.org>; Sat, 14 Oct 2023 01:15:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 703B686EDB;
	Sat, 14 Oct 2023 02:55:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IU+UIsj7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2841886F55; Sat, 14 Oct 2023 00:03:37 +0200 (CEST)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05F8A86F94
 for <u-boot@lists.denx.de>; Sat, 14 Oct 2023 00:00:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-503056c8195so3423898e87.1
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 15:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697234440; x=1697839240; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MuY+q1kVcCRsoZ2S/VYp5TpFUKOlAA656qi328+6aFo=;
 b=IU+UIsj7a+JMRH++eTERB/2+ZPS40zfecvE55T/vkEDHufWSvzHDWvH7nOhK2vQzJs
 lkFt6U08f+60F4bTwMGPMCropmC1bl0fWcvIoVZUW088TsubIB+1OyGYm1cC69FzZDJS
 oOG3OhSZphB3HDHi+c/gNGcQu0s8KdCBpzFgM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697234440; x=1697839240;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MuY+q1kVcCRsoZ2S/VYp5TpFUKOlAA656qi328+6aFo=;
 b=A7tuU5gqJjPDMlUJNnXxQClj9DclJe8LYnDr1nmJqrkiQaZA9pakHnq+DOFSOKitUl
 eBI1V6Y4YZ74P29G2hp9J0j4lEkisQ2Ix3ZCML9+kc0F/S5vbAbz3qdq7iUO9XPnTXtj
 ebCeWQ4MAvmyxc5XHb9kgM4lg1kH5GjKwXukeWB9lb3VhXXr6P5PY+jf5LrASHyMhllt
 u6Nkvp3ey5jMYgZA139P0CNR4qp/R2c5safpyhYOR+kvv7VcbsFJxjwEs+7py8T2wMi9
 k6nd5/dc/dBNxrY7yG9tn7jCF2M8EpbDYoLnR80iyxWir4kzbnHRD2JfG/YreMnIYfrK
 Bbzg==
X-Gm-Message-State: AOJu0YzsJQDiWOcUDXiZNLn55g3ceaxxEQaPpT9fqQ7PsTsIIKbd/ORA
 ejrpTb4n9tUQxOcndwXcQgN+e9tIdG+GQM3/nxsnBw==
X-Google-Smtp-Source: AGHT+IEjiXlurqV85Q0C0NSbP+oq1z+a0p3kt5UGG65u7ZlnuG4V05+6HFxZ1Ie5Vy/CdjM8y666sNlvUOD97C3gmjs=
X-Received: by 2002:ac2:43c9:0:b0:507:9691:f854 with SMTP id
 u9-20020ac243c9000000b005079691f854mr3607507lfl.2.1697234440288; Fri, 13 Oct
 2023 15:00:40 -0700 (PDT)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 13 Oct 2023 15:00:39 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <CAPnjgZ36Gcgc0LDGW81-zrDo+9F8ogs7XsE8bfdcpZDvn54xXw@mail.gmail.com>
References: <CAPnjgZ36Gcgc0LDGW81-zrDo+9F8ogs7XsE8bfdcpZDvn54xXw@mail.gmail.com>
 <20231004085635.330221-1-lukas.funke-oss@weidmueller.com>
Date: Fri, 13 Oct 2023 15:00:39 -0700
X-Google-Sender-Auth: RTo0Yf1S0J_56zdwQIgu10ySa9E
Message-ID: <CAPnjgZ3S3GApjszt+chr4Z+gV1TXBxFbZUVKt19po=d9mcGddQ@mail.gmail.com>
Subject: Re: [PATCH] binman: bintool: Change make target arg type from string
 to list
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, 
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Michal Simek <michal.simek@amd.com>, 
 Lukas Funke <lukas.funke-oss@weidmueller.com>,
 Lukas Funke <lukas.funke@weidmueller.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>
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

On Wed, 4 Oct 2023 at 02:56, <lukas.funke-oss@weidmueller.com> wrote:
>
> From: Lukas Funke <lukas.funke@weidmueller.com>
>
> The argument type of `build_from_git` was changed from string to list
> in d71e7116997f14097735f04cc7847f0a68dbc485.
>
> This commit adapts the argument type of all bintools using this
> function.
>
> Signed-off-by: Lukas Funke <lukas.funke@weidmueller.com>
>
> ---
>
>  tools/binman/btool/bootgen.py  | 2 +-
>  tools/binman/btool/fiptool.py  | 2 +-
>  tools/binman/btool/futility.py | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
Tested-by: Simon Glass <sjg@chromium.org>

Thank you.

Can you please resolve the test-coverage issue, too? It is the one
line in the whole of binman with no coverage. If it is not needed, we
can delete the line, perhaps?

tools/binman/etype/xilinx_bootgen.py                       72      1    99%

The offending line is 216:

   data = tools.read_file(bootbin_fname)

Regards,
Simon

Applied to u-boot-dm, thanks!
