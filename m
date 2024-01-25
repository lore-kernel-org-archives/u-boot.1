Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8B34C47258
	for <u-boot@archiver.kernel.org>; Thu, 25 Jan 2024 10:45:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98DE787134;
	Thu, 25 Jan 2024 11:45:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZeZJfrnn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66E0786FCE; Thu, 25 Jan 2024 11:45:39 +0100 (CET)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6FFB7874CC
 for <u-boot@lists.denx.de>; Thu, 25 Jan 2024 11:45:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-55a684acf92so7492367a12.0
 for <u-boot@lists.denx.de>; Thu, 25 Jan 2024 02:45:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706179537; x=1706784337; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IenhAk4joqIjqCkEM8jxJ+2GhQqI+f0wvmGk0QU+lDQ=;
 b=ZeZJfrnne3KBbyoD/RUqIpWbcaxoEDnT7UVoVNQfXVqLLN6FRWeYNTNf4+pRhN5j5s
 KxSflJLJ0QaknJlve1LKLU5JAmVaps/V7AuiD6EokTvVf4uJeKWSSS8Jel5MCTU/8lr2
 rSH5AZcU0p3+Fw5PLGDpQgvAuVDLwkARXTd1spgShZvjkwxGGP4p2P7TVJ6GcVAll4V7
 6nWVtNHK/64eFYhXqYN+9pBmoC9adw0409t13/eWl64Xk4hLwV/o1FxcofHZHUIpwERV
 U+sQUVMCmM2xaTDmEKK0rs+YolZ2HzZ/rqTpSI3W8y1OolGS+BmBgItb8vSS1rRGyjwV
 CIWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706179537; x=1706784337;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IenhAk4joqIjqCkEM8jxJ+2GhQqI+f0wvmGk0QU+lDQ=;
 b=mx9XryLPKQ2KvLkym6YuySYwOOoEwZckcMrbghHS0hu7jDneP34oCMNO1bxxzU7w/M
 EyZ5n82D2NRv6KRyqCDI7epWCqWwCeC6QIWbb7VbY4Rx6JZGszGLnPWEJ3afvfUF6lum
 Y/Wty3StkoMsTNlGcEqL03xkX15uaS3d8JW4raDdsK3vPhQLANPhKHc8VwQ4Bi1YTWVI
 L8S+XZ80wip3/ZeH+NOKoLOOsYb4QzoVcJAH6al2u7ndrvk0F2Ohqy1LhnmYs4QaFxpi
 uGtjYnbJdjxvPcEWGGf9brS9cJsOxAIkYe1oRd+XUxJHIpJLWHZbkIDDcZKRl4DOrbYW
 +W6A==
X-Gm-Message-State: AOJu0YyWAQOF0mf0jF2LUkLyol+goqPTejBVkC/zaWi3Wcx6YcQ2lLSy
 ZupBjjf9uw/8WlY92hM/17x8DlhA7cn9r2jIIlMibvBxHipRRQZ5b2bAW+dQzjnvm5ds8gJTWQl
 wtKG2iL7AiZuYA1CuvAWpn0pAjRg=
X-Google-Smtp-Source: AGHT+IFFAQEdOZzVsAbNEOrtlYfypk8QxzCM2WT8gY7+ZOw+K6kkMW/gXyH6ZLgoXF7+Za5/C21K6W3rRKjNSlOHPvA=
X-Received: by 2002:aa7:d98d:0:b0:55d:b2a:15f3 with SMTP id
 u13-20020aa7d98d000000b0055d0b2a15f3mr152650eds.27.1706179536643; Thu, 25 Jan
 2024 02:45:36 -0800 (PST)
MIME-Version: 1.0
References: <20240117153347.85074-1-heinrich.schuchardt@canonical.com>
 <20240117153347.85074-2-heinrich.schuchardt@canonical.com>
 <20240124211658.GA493567@bill-the-cat>
 <496ce6bb-8437-4ce5-9935-808b0e833ae4@canonical.com>
In-Reply-To: <496ce6bb-8437-4ce5-9935-808b0e833ae4@canonical.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Thu, 25 Jan 2024 10:45:25 +0000
Message-ID: <CALeDE9NzCZ0SqEwc-gn7GTmXoRObbQPgWk3GTyBjYE=9_ZZeYg@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] cmd: provide command to display SMBIOS information
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Bin Meng <bmeng.cn@gmail.com>,
 u-boot@lists.denx.de
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

On Thu, 25 Jan 2024 at 03:02, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On 1/24/24 22:16, Tom Rini wrote:
> > On Wed, Jan 17, 2024 at 04:33:45PM +0100, Heinrich Schuchardt wrote:
> >
> >> U-Boot can either generated an SMBIOS table or copy it from a prior boot
> >> stage, e.g. QEMU.
> >>
> >> Provide a command to display the SMBIOS information.
> >>
> >> Currently only type 1 and 2 are translated to human readable text.
> >> Other types may be added later. Currently only a hexdump and the list of
> >> strings is provided for these.
> >>
> >> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> >> Reviewed-by: Simon Glass <sjg@chromium.org>
> >> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > [snip]
> >> @@ -227,6 +227,13 @@ config CMD_SBI
> >>      help
> >>        Display information about the SBI implementation.
> >>
> >> +config CMD_SMBIOS
> >> +    bool "smbios"
> >> +    depends on SMBIOS
> >> +    default y
> >> +    help
> >> +      Display the SMBIOS information.
> >> +
> >
> > So this would be enabled (today) on 888 boards and is a bit more than a
> > kilobyte. I think we can just let this be enabled as needed in
> > defconfigs?
> >
>
> As needed would be the boards where we want to run the related Python
> test. Sandbox and QEMU should be good enough?

Yes, I think for most users seeing the smbios tables is probably not
particularly useful.
