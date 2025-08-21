Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28235CA0EEB
	for <u-boot@archiver.kernel.org>; Thu, 21 Aug 2025 23:25:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B37A80548;
	Fri, 22 Aug 2025 01:25:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Fwkmc6Mz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5706981FEE; Fri, 22 Aug 2025 01:25:33 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70E478006D
 for <u-boot@lists.denx.de>; Fri, 22 Aug 2025 01:25:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianocarvalho.pt@gmail.com
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-6188b690517so1923336a12.1
 for <u-boot@lists.denx.de>; Thu, 21 Aug 2025 16:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755818731; x=1756423531; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oB5iq/qkBvViu2GBw6pQQ35qBamhYVl+ca1R5HpwQaA=;
 b=Fwkmc6MzwHsJ4SjXtOvTpEtMf0/GNWRq4RdNc1p4P3/ur22OE9z76D2IYQvOsJStvU
 oK1vOC0GZigFvWR/RKwTQGl8lmu856fBbE//VxLrtntJICvRMJqQxWr0rOkTupoaYJid
 cX89O90Az9skJLpu4HB5mXehud2zLF5ds5xOaKvted01tUFuPQJX+fQBPCZkx7JsDO4m
 BZgXw8P/Y079m3EOeSsVH6IwZLwdYacNDVLMNkKjVOlZOLJw+JSt7guIA7nVq0kscB1J
 TvrBBwB5j7/PnFtzPQ+mcw30t9L9rWDSfI/oULyueJb/MsoJRr3CBoUy+zopj0WAtmhX
 MZ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755818731; x=1756423531;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oB5iq/qkBvViu2GBw6pQQ35qBamhYVl+ca1R5HpwQaA=;
 b=l8e2uqjryKpE1aXSxs5OJqkPl0DzXARIx7N6Pw2IIiS9szMaMDIFSvaZ5TZlWOzAby
 LlegoQ2eq4w4hYBY7hr9n3m2xq/MS91QY1ROHTdycuVUOOKYhg9Wle7UBG4kDIsEeKGj
 y6hOMqIk/4QR7EEzC20V+/NzVlQX+qYYeI9BYJfdXX6GWBtfU5IymmA2ebw5Wur5TEc4
 1AOLazyv/M0V8tlXOB4hOzOzIm7ADypulegaPKtO3VWDuikS6iNHZHvXCkII1bMnfW2T
 adgOFwErv8s4GOnszNt/cHGXlpvUOxckThJqtnuA2mk3ugUvgU+2ZCmAxPGwAfGDUfKa
 wj9Q==
X-Gm-Message-State: AOJu0YxkZYWnnhVkGJKpdBjOi7oyOlV4j3OjMTr+HH/z0rU746TLreZe
 9rc3J3NkwMRHnSV2S0DSZFHwup8bCYSV86KftdEaUTl+RaMyRhGMFMDguWnkTxbRG5MpU/7cbNj
 tGuMfBU51SsE9JQZEYpNTl4EMajdfEew=
X-Gm-Gg: ASbGnct7vIYiKBrZBhUIWmpLZPOVkz2sw3ljHtNrvnR6Dx9W5VCMfZP1t0J+vNq6zLv
 w9+arXUx7UxtwLmfoV5oR4hswWLSGEY/W5tQLY511gkEQUDRDicQ9vmXUSmLeuTUjrSmL/pylh/
 rgRazJPx6n6IwYxfV5VJIj1DLfI7t+pdJBcvO4fqn3gjlgUzbgKQLZCBl1Z3qPPHKJN2ybtQ7+/
 CFZ/HQfpStPPFtT7bjO7HkwHYH/15+BOiiX4DSF
X-Google-Smtp-Source: AGHT+IGCL4sWS0fjM3nWjvKK00hcs5K5thBo7dtcWGKQhkPOoR8XXWXvapTjCEWLNO9lw3yKHJ3NqzbFPKsbo9URJ3o=
X-Received: by 2002:a05:6402:2712:b0:61a:9385:c77f with SMTP id
 4fb4d7f45d1cf-61c1b712de8mr598251a12.36.1755818730841; Thu, 21 Aug 2025
 16:25:30 -0700 (PDT)
MIME-Version: 1.0
References: <20250810233742.51902-1-adrianocarvalho.pt@gmail.com>
 <20250810233742.51902-6-adrianocarvalho.pt@gmail.com>
 <b8842289-20b6-4519-b104-f002e4e8daf8@gmx.de>
In-Reply-To: <b8842289-20b6-4519-b104-f002e4e8daf8@gmx.de>
From: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
Date: Fri, 22 Aug 2025 00:25:19 +0100
X-Gm-Features: Ac12FXySdGcIe7A3P25l6y-oKf4vZCRZpYdPHH3Hs8kIQccuEptTGlv8Qo0LC08
Message-ID: <CACAHuLC_k7NB65J=PmFYP2JkW9nOmeZ_OEQ8+uorML0m=BGceA@mail.gmail.com>
Subject: Re: [PATCH 05/10] doc: Ensure consistency of "buildman" (in the
 middle of a sentence) and "Buildman" (at the beggining of a sentence) in
 tools/buildman/buildman.rst
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
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

On Wed, 20 Aug 2025 at 22:11, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> [...]
> But isn't Buildman a proper noun?

I'll assume it is -- it looks like one -- and use "Buildman" instead
of "buildman" whenever it is used as a proper noun.

> [...]

Com os melhores cumprimentos. / Best regards.
Adriano Carvalho
