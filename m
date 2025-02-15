Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F621C021A0
	for <u-boot@archiver.kernel.org>; Sat, 15 Feb 2025 13:02:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9FD3E80C77;
	Sat, 15 Feb 2025 14:02:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aD7/u03n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B027380C83; Sat, 15 Feb 2025 14:02:54 +0100 (CET)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46AD780756
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 14:02:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-aaf3c3c104fso476554066b.1
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 05:02:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739624572; x=1740229372; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MSgv9s1r2zDudW11d4Vl0Nb037DddAzkQyBN9W6G6n4=;
 b=aD7/u03nfJc7kFae13MnzjhYiNYcpGrc+LVw5W8BdF9giyFjUi6H86XILRd8dLy3ey
 FLn6jBKXfCDdWfxUZcCbNzb4imx4BPj0b27c5dNaOpcuOb5ECVbt/ysI/oso2mlYxReu
 xxQOUjoNz84zl7mspyxhYPteUB6Bvfc/j7Q1Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739624572; x=1740229372;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MSgv9s1r2zDudW11d4Vl0Nb037DddAzkQyBN9W6G6n4=;
 b=c9ZEYlUwxPDXuRDsGBeYRzegXBBHB3AO7DW/5H1jXhXSe97EK93lWcMzYULmjpnMcn
 eGGskt83qTeO0uenQaKjM6L17CJeYa3dDUzIL4V1tnGyNAqeowHQTVdJZ/7xeL+loZHO
 dc0ITFZpg9OtflOd+EvcM2y+LXktTGCTFCgs3PMmzI8Um3IkYOn73+A+yCgB5deSEAWD
 B3tsO95VzWMq15gr+ozhaO6T6WYnvJuDG3aPRtR82Zn+NkJg7qE+lJyYKJU6Lpg0ekxP
 dYu/40EmfyMf1+y8aOnhkxLF+Mozj+Ds2+7tK2v57JxrHnNYS5ayVlUaaNzwcJZIDeyb
 593Q==
X-Gm-Message-State: AOJu0Ywv5OKIhLGpSBje1Mxx9SNSpT+eV2yHVQBRsTh6HWX6N5kaEzdp
 XGJ948UAE6Hv4qGp073GXhIe2zG3EMf4CzFsZQUy2fb0YOYoBRIZ+N8qgsLoeAR6YBIqMn7fMr9
 L43KumNcAYWGQo4pYsa4QLF1K5rG8WBVATu5w
X-Gm-Gg: ASbGncuHjuk1eHjn59NoJjuePYmFMNVOyQAxkYGlAtTWeIlVRlKlqMQWBrwpOG52lL7
 Qc/E/OGnTjC0g9sFlUKVBJ2v3PKxOmkyykWORafvTCTQ+Hpshrs+EGC4brycVN/7nt0vnqU8OkQ
 ==
X-Google-Smtp-Source: AGHT+IHxc24lOsCqlOJKQmzLKDHn2Q8UlEupYgp/VKJx2aN6HEIYtfyD/9YsquzuQycy9nFBja+jfpngdMMQUT0oogg=
X-Received: by 2002:a17:907:7244:b0:ab7:d6c:5781 with SMTP id
 a640c23a62f3a-abb70b35452mr233922766b.24.1739624571703; Sat, 15 Feb 2025
 05:02:51 -0800 (PST)
MIME-Version: 1.0
References: <20250125213150.1608395-1-sjg@chromium.org>
 <20250125213150.1608395-5-sjg@chromium.org>
 <20250125214443.GD60249@bill-the-cat>
 <CAFLszTiqhKn4DF0CQg7egocvvVTu_NhC4BgGaOV6j8zbDXkoxw@mail.gmail.com>
 <20250125225042.GH60249@bill-the-cat>
 <CAFLszTgc4=gFuDuZrN0LYRrN28w6QZPQRWdvKSzn4rq27RyEUQ@mail.gmail.com>
 <20250125230058.GL60249@bill-the-cat>
In-Reply-To: <20250125230058.GL60249@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 15 Feb 2025 06:02:39 -0700
X-Gm-Features: AWEUYZliPTL9e2A-w-1AintHExERAPgUGYGKnw4P0cFtWn4j9mCAGGBfsFQUzVk
Message-ID: <CAFLszThcg5imJQUiOccPYuJkVuQ2OmZd6K0BoLMkWj6-DPVGJg@mail.gmail.com>
Subject: Re: [PATCH 4/4] test: Make net tests depend on CONFIG_CMD_NET
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Love Kumar <love.kumar@amd.com>
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

On Sat, 25 Jan 2025 at 16:01, Tom Rini <trini@konsulko.com> wrote:
>
> On Sat, Jan 25, 2025 at 03:56:02PM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Sat, 25 Jan 2025 at 15:50, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Sat, Jan 25, 2025 at 03:47:26PM -0700, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Sat, 25 Jan 2025 at 14:44, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Sat, Jan 25, 2025 at 02:31:39PM -0700, Simon Glass wrote:
> > > > > > This fails on samus_tpl as there is no 'net' command.
> > > > > >
> > > > > >    => net list
> > > > > >    Unknown command 'net' - try 'help' !
> > > > > >
> > > > > > Fix it by adding a condition for the test.
> > > > >
> > > > > For this part,
> > > > > Reviewed-by: Tom Rini <trini@konsulko.com>
> > > > >
> > > > > > Add a blank line to keep pylint happy.
> > > > >
> > > > > Can we silence that pylint? I don't look forward to the churn of adding
> > > > > more blanks everywhere especially since imo it doesn't improve
> > > > > readability either.
> > > >
> > > > Yes, but we would want to do it globally. But it isn't really a good
> > > > idea IMO. We are trying to use PEP8 which loads of tools expect...e.g.
> > > > my IDE shows warnings in this case. It might be better to just fix the
> > > > problems.
> > > >
> > > > As to readability, I'm on the fence...in practice it doesn't matter
> > > > much as few non-trivial programs have a lot of top-level functions. I
> > > > would rather keep the tool happy and use the Python style that people
> > > > expect when coming into the project.
> > >
> > > Yes, we should do it globally. Can we not globally also tell tools the
> > > deviations from PEP8? I remember back when people would argue about if
> > > we should tell file editors what to expect for whitespace, etc :)
> >
> > I'm sure we can do anything. But why deviate? Is it just that you want
> > to avoid churn, or do you actually not like this part of PEP8?
>
> I think it looks bad (personal preference) and we have that in almost
> none of our tests I suspect so adding blank lines to make PEP8 happy
> rather than adding hopefully a line to a common file normal tooling
> reads seems the wrong direction. But I don't care enough to not apply it
> if someone else does it. I'll add missing blank lines when needed
> assuming the pylint CI job complains once it's done.

OK. I'm a bit confused about the double-line warning since pylint
doesn't actually show it! For now I've changed my IDE to use pylint
and disable pycodestyle so now I don't see these.

The current Python files show up with lots of (other) warnings for me
and I would like to fix them. But it is quite time-consuming.

Regards,
Simon
