Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84351C4332F
	for <u-boot@archiver.kernel.org>; Wed,  1 Nov 2023 20:22:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E50468707A;
	Wed,  1 Nov 2023 21:22:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OBlpDQ0p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E1B7871F8; Wed,  1 Nov 2023 21:22:27 +0100 (CET)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4768286CF2
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 21:22:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-53de0d1dc46so296513a12.3
 for <u-boot@lists.denx.de>; Wed, 01 Nov 2023 13:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1698870143; x=1699474943; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LJt+1K8v4eakUaON6DSBgl+3A2xT6ojXjBaPMTW1s/8=;
 b=OBlpDQ0pEWs/q68X1FiAf5XWdlHXXdeiDs1qL8mhGmxo4zpVaHY4nTyapY6B+XIt0h
 gbm6lpifOd+nfB/QJpGcqZmrXzoPl4P3ry6TjmbZhGmWK7Iv5PElOw08tbkotdFvsWd5
 fG4ebGoRR4lNBg2fDe4YBe8XkSb+/JzXWwK6E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698870143; x=1699474943;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LJt+1K8v4eakUaON6DSBgl+3A2xT6ojXjBaPMTW1s/8=;
 b=cdX9pqrrSRTgOaF02wxIAjsRoADnSZiBSkVbZPKhKrHzTSEuwCgLCODHvzJ5+6lUWf
 iPmQR7ENRz/ldm7vem9hNtwexyODBYDbTbnaok4ZvwspV9B/zGbjaldSD15zVUWtmGV0
 VqbHQllDlQWlz+9mnTUL43GgRVxMW44iIsmy4cokA+pX1nPfG7Om3P4NriKhQX5bVt2G
 bnL3zRXFr8v8KaTq4nA4JW3wdsnwCeFF7OVl4+t0o3PhzDf3rWaF6pQPbXn35s7g/EQO
 4J/f46++Tsbv0oxxIQAXHwLv1b3sVXJRmuvRu3pZp5yZmXKw42oUEGEjckDnVPPMcqQg
 rB4Q==
X-Gm-Message-State: AOJu0YyNYJZ4Aa4Nwjc4Ud7ABkP7BPbivrVL0QxtMIa5BBzxecKaQvEg
 iUB2Gg82Icn3cE8hR3oIVhcT8f+yiAkE8wc1jjlHPg==
X-Google-Smtp-Source: AGHT+IE46IQMBgm3RC1yAoPIWRynilnAFYs0RMpYvQN2oH0L6MYQ/mj9Bl5stHSETGEuN7sFOaFdqkcyTlFpVD/b/EQ=
X-Received: by 2002:a50:c05e:0:b0:543:5f7a:9e2b with SMTP id
 u30-20020a50c05e000000b005435f7a9e2bmr5676442edd.29.1698870142628; Wed, 01
 Nov 2023 13:22:22 -0700 (PDT)
MIME-Version: 1.0
References: <DDC56A09-6749-48A5-A4E2-B58D2BD5C7D9@gmail.com>
In-Reply-To: <DDC56A09-6749-48A5-A4E2-B58D2BD5C7D9@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 1 Nov 2023 14:22:11 -0600
Message-ID: <CAPnjgZ2BaOKxCHa2D7GHpAQfg83DBjqrMT4vvPaRT7pNgKAJfg@mail.gmail.com>
Subject: Re: U-boot env in binary format
To: SIMON BABY <simonkbaby@gmail.com>
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

Hi Simon,

On Tue, 31 Oct 2023 at 17:07, SIMON BABY <simonkbaby@gmail.com> wrote:
>
> Hello ,
> Can I know if I could generate uboot env file in binary format as part of my build process ?
> Currently it generate as a text file .

There is the tools/mkenvimage program:

mkenvimage [-h] [-r] [-b] [-p <byte>] -s <environment partition size>
-o <output> <input file>

This tool takes a key=value input file (same as would a `printenv'
show) and generates the corresponding environment image, ready to be
flashed.

The input file is in format:
key1=value1
key2=value2
...
Empty lines are skipped, and lines with a # in the first
column are treated as comments (also skipped).
-r : the environment has multiple copies in flash
-b : the target is big endian (default is little endian)
-p <byte> : fill the image with <byte> bytes instead of 0xff bytes
-V : print version information and exit

If the input file is "-", data is read from standard input

You can build with 'make u-boot-initial-env' to get a tool called
printinitialenv to run, which emits the environment. Or you can look
in include/generated/ to see the env files from the build.

If you would like to send a documentation patch, it could go here:

https://u-boot.readthedocs.io/en/latest/usage/environment.html

(in the source tree this is doc/usage/environment.html)

Regards,
Simon
