Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 913FBC0218C
	for <u-boot@archiver.kernel.org>; Sat, 25 Jan 2025 22:42:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE1BE80ECD;
	Sat, 25 Jan 2025 23:41:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dPZbTAC5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A4B180EF4; Sat, 25 Jan 2025 23:41:58 +0100 (CET)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 080AF80EC0
 for <u-boot@lists.denx.de>; Sat, 25 Jan 2025 23:41:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5d982de9547so6197103a12.2
 for <u-boot@lists.denx.de>; Sat, 25 Jan 2025 14:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737844915; x=1738449715; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KCP0R/zokfBAKOiKeV2o8ZI1x+kCchgjAg7EGt68svk=;
 b=dPZbTAC591hm7cY3HTU1qyGSxlci49eBix01RneyrY0kT/0H1qRz73oXhPiXgeChgo
 dSpl0ikRQjiY46Qnz42Ov2PxytPpG7EwE27iZWZgIIN8dZUqpu+DgxSmQVQIZAZdJHoo
 Z2pdsOpC6Pnc/80J2rd0U+DUcLpHe2p8cB7mM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737844915; x=1738449715;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KCP0R/zokfBAKOiKeV2o8ZI1x+kCchgjAg7EGt68svk=;
 b=wtKs8ArOmTo+WqurZ7VRcC//YY/yo09s/DNiL48ni3T8qI/L+UtvufvbKEdQPnC5rt
 t0u/QwyrRExJKtGXZYS6pEqrAehyttugOieQ9kZBeTB3vwBoIA4l2pDbX1ZNmQRYvybc
 gGRxeMpVTi6jLit/QiYRPASsJnsFEiV9XQ1v9Pcq5GhIL0CLZmQ9cLHeb450YoBMC/mM
 7x5oPEj8FvlU1rPpdyFoVSnugUYnY+W5F/zlJIj32auzMgSOyieqMzYmXxHTUDodZXxS
 vDOwq/8kHx3ZrWoyac3xC1N/qFbnezv2QFPDNTqJSIgh+zrzImgWXoxGRSUZySIKC7y+
 LObw==
X-Gm-Message-State: AOJu0YxqsxRsNMFzd/Lwk76bFkhFACEIRZLCAYM1jIcUL9St6UBR4T4+
 fEela9WBVs/ZgFezNXal0x73Fl1LGTUOEgmVV5KrbxpCECE78/XQKYViSPz5i5trKHX3KpIu+Cx
 oPLvIFnAbx1wEntUbGWeq/WIasfpgx8DOCM4kZzjBOtFxMrE=
X-Gm-Gg: ASbGncs27dVOZObqQc+3SnWpTbzbMlcqMGZWHduViHJ24yPY8yhAXpK2nlJ75SAVdqA
 cvJvjEUjS0RSb2wKT0TDqU61G1iz0RiwjUJH40YxM+N0PpJyc9TQdzFwNwhk0Um4=
X-Google-Smtp-Source: AGHT+IGCdwkMydEYIc8bcTJU5YTPTrl/xe6F/NN8wFQWtB/3moFcpC0nGWT0gIa1u1PCoS87xQBKQ5Vq05tJUJiHvNw=
X-Received: by 2002:a05:6402:358f:b0:5dc:1059:69e with SMTP id
 4fb4d7f45d1cf-5dc105a60f9mr9308891a12.10.1737844915316; Sat, 25 Jan 2025
 14:41:55 -0800 (PST)
MIME-Version: 1.0
References: <20250125213150.1608395-1-sjg@chromium.org>
 <20250125213150.1608395-3-sjg@chromium.org>
 <20250125214613.GE60249@bill-the-cat>
In-Reply-To: <20250125214613.GE60249@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 25 Jan 2025 15:41:43 -0700
X-Gm-Features: AWEUYZme6SsWzfwgJV7NhlDouv6zsKbv87HEPrHvQyfSPh8wbOv8-DPXG5wiNgw
Message-ID: <CAFLszTgYPNxmiO=agM+MUp0da_6q3BBro74bWEnNbqeM-tT=bw@mail.gmail.com>
Subject: Re: [PATCH 2/4] test: Drop u_boot_ prefix on test files
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Caleb Connolly <caleb.connolly@linaro.org>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>, 
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Jens Wiklander <jens.wiklander@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Julien Masson <jmasson@baylibre.com>, Love Kumar <love.kumar@amd.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Michal Simek <michal.simek@amd.com>, Padmarao Begari <padmarao.begari@amd.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Peter Robinson <pbrobinson@gmail.com>, 
 Richard Weinberger <richard@nod.at>, Sam Protsenko <semen.protsenko@linaro.org>,
 Tim Harvey <tharvey@gateworks.com>
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

Hi Tom,

On Sat, 25 Jan 2025 at 14:46, Tom Rini <trini@konsulko.com> wrote:
>
> On Sat, Jan 25, 2025 at 02:31:37PM -0700, Simon Glass wrote:
>
> > We know this is U-Boot so the prefix serves no purpose other than to
> > make things longer and harder to read. Drop it and rename the files.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
>
> This is a massive bit of churn and violating namespace best practices
> when it seems like we really need:
> [snip]
> > diff --git a/test/py/tests/fit_util.py b/test/py/tests/fit_util.py
> > index 16ff8c96c63..7aad4030be3 100644
> > --- a/test/py/tests/fit_util.py
> > +++ b/test/py/tests/fit_util.py
> > @@ -5,7 +5,7 @@
> >
> >  import os
> >
> > -import u_boot_utils as util
> > +import utils as util

The real namespace is the one in site-packages, where you are supposed
to put things in their own modules. The Python tools operate in a
proper namespace, but so far the tests don't. They just use whatever
directory the file is in. So, for example, we have:

from tests import fs_helper

where 'tests' is the subdir in test/py

One option would be to move the pytests up a directory, with test.py
in test/ and the other python files in test/u-boot and the tests in
test/pytests or something like that.

Then we would have:

from tests import some_file (*)

like we do in tools

Also, I wouldn't call this 'massive' churn. Most files just have a
line or two changed, with test.py and test_ut.py getting more.

>
> A lot more of this type of namespace shortening which I believe is the
> normal Python-way of solving this issue.

It doesn't really, since 'util' might conflict with something. When
you have a set of related Python files, as with do in test/py it is
better to use a namespace. But even then, I think we would want a
shorter name.

Regards,
Simon

* "tests" is safe, I believe, since no modules use it it, e.g. it is
mentioned here:

[1] https://docs.pytest.org/en/stable/explanation/goodpractices.html#tests-as-part-of-application-code
