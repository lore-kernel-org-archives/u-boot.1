Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBEE9E937E0
	for <u-boot@archiver.kernel.org>; Sun, 12 Apr 2026 11:44:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5515183DC9;
	Sun, 12 Apr 2026 13:44:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VsYMDZdi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD3F383EC6; Sun, 12 Apr 2026 13:44:41 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4BCD8341A
 for <u-boot@lists.denx.de>; Sun, 12 Apr 2026 13:44:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-b93698bb57aso632336866b.0
 for <u-boot@lists.denx.de>; Sun, 12 Apr 2026 04:44:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775994279; cv=none;
 d=google.com; s=arc-20240605;
 b=IcE4AJGrb37TRtAaqNDAyoBRqKmMuFGOnx9v8kztb3ZFn8VkLYKn7mbJSBZbMhK82N
 6Y7eFS8/sxawxd+kWN3C0DFFtCeo2Rq7Y4rPIfIRlnkXTc9onw7VJEWdi0Di7FnJcYaN
 oV9QW6KdvIQ3391hTaXNG2t6PRVbLwx46K87ePxuetykYDlZsXt1g4qa18ZVMZQM+u3A
 R3o+chbLfbG9A4R8VnCgqxGIFeVmzjvXk5/Xt335xYUAvfEFl7BAsTjX8eBoxcav9X3J
 40RzR03rfrXTQ4QbCV2R2gUGxUKfgNPydzTzQTroqYBJED8la+vKnVaqSeuTA2q28NK7
 nFHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ilBeUs+5UJp8JtZlRX6JtP9hq4Pszkw5eOlZ4KOSZXE=;
 fh=tCk/HFex726fk3S1be8wjLSdRDebQv5BFsTtAh1gpsk=;
 b=XJ2ZZHgV3gUhVUFI4hnuQB9G6quOJea1IzEKw/sqAwe9RFRJuRpfAM5eClkmroYGFG
 9mjZ9FwoXWZV+QA4D2HtTWHQAOA3xG1dId11fwZfIHbUVbIwM9Sfpg4Kh7z1TvRWOJ7I
 Tz61xIMvjmN+gHO9yysC+2ijQYrYc2nBC8iQx7tsKy1M0FQNIwQQMFVAidic+pnbep6U
 LFz0jNvnHqjEJPrvxCTYuSh4TdJbmf4UKAMVEDMKgdHQ9fPKl0RRlkdBbRZm6zqzHbC1
 0lnIGGG/piZGtXYhsBiG6RAqZJY0GbggXr5Wg0+QjmqQFgZJWrGs482x817k5FFUObNp
 8E0A==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775994279; x=1776599079; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ilBeUs+5UJp8JtZlRX6JtP9hq4Pszkw5eOlZ4KOSZXE=;
 b=VsYMDZdivhPWibpt86CeB0mWJL9wgoOF2F6WKJkTU7Cc3sokKhpXRWgtWF7TWf3eqI
 mt41DB8QdqtOOQcUpKFEDg5MbNmlCIyg9Uo1Dyw/rpG3hiYcxJ5TGIebNFkAzYheWnM0
 Y9jGqbULs1hjjv0P/mXzewVxTguxmiWWOh/pg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775994279; x=1776599079;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ilBeUs+5UJp8JtZlRX6JtP9hq4Pszkw5eOlZ4KOSZXE=;
 b=o27/5QiRXpK3n8s0h8N0a8butK+JiEg53gyRPwsvigbus7waMFJLYQnbINBqo3EGfO
 2vyOjjkAe+RUVRu23DTd6htaAoZJZT26uaUeX4VlSEjq9G9sONl0rdNbsBXLzp9b1CY/
 5NZErKA9sC1UDjYrw+BY/dCjVpcC+qQ4V944wAKW3NVEUwpDR8Re0HEhmF0ifrWrKaq6
 llQSCwJmI8oiGZ4A2ifnZQYkQ+90aU1djgeSeqna+IgV60FYfDxwvmSQhF+xuYFIveTw
 eoyJOnimTkT67AKfPuLSfA0FZLQU+6akxoXyeGUNEhfGfI8x74FEhAIUOzuTIoAMdkHA
 6u8A==
X-Gm-Message-State: AOJu0YxIIHZ/UeAYNcZbg4Vp3UMXwc2ezabRvXRC0BX+hUnCMiCqfxOQ
 0XIQkKBFVBoefq5OJW+A+UgvIoURLsM77lbtmsUUvumJKilP1+m6HhdbrI+C9ZHVQ0MK2bgPpkG
 QTgMAogZSzoDyXTxILtsrAypjB8P1/x9dpt/IIxla
X-Gm-Gg: AeBDievRMNLHDTrGvsOqyrpmonwSpLJ4hBv09xAD9e1tkyPYu5XKmpWiLAn82C/mPEq
 gxXZ+oRELuzJnCkbUTT6qstTl6jICvAuPP2b2sUWGx3y1PoQMbsTCSR1QCVaKoyqprm/RUiLWeW
 /EZVsn2qQpgnqvTM83lWFaJB7VqqT44DyjCsZmg+d2YNky7G1i6Tp9xesIuxmmHFGvyE27OBK0f
 U89Xj6tToTNtfzYMpCcfJwiaMsF9O666fUIhIMvKY/z4Cb9oJxT/FxcQETGZjwinO0TWrhmdTf9
 W0kYJw==
X-Received: by 2002:a17:907:7624:b0:b9d:4652:f7a9 with SMTP id
 a640c23a62f3a-b9d4652f9abmr506458266b.5.1775994279138; Sun, 12 Apr 2026
 04:44:39 -0700 (PDT)
MIME-Version: 1.0
References: <20260407204113.3102785-1-raymondmaoca@gmail.com>
In-Reply-To: <20260407204113.3102785-1-raymondmaoca@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 12 Apr 2026 05:44:25 -0600
X-Gm-Features: AQROBzABhRh4hQJk9IQ391ube_lbGBTSuiE6HvWr7YWKjzXqfhkgwWt8DKy7T34
Message-ID: <CAFLszThazExHUPbC8sxxSiHCOeZZrBZbm-fvyT+g0Sa1igR03g@mail.gmail.com>
Subject: Re: [PATCH] smbios: Add an explicit bounds check for Type 9 length
To: raymondmaoca@gmail.com
Cc: u-boot@lists.denx.de, Raymond Mao <raymond.mao@riscstar.com>, 
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Samuel Holland <samuel.holland@sifive.com>
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

Hi Raymond,

On 2026-04-07T20:41:09, Raymond Mao <raymondmaoca@gmail.com> wrote:
> smbios: Add an explicit bounds check for Type 9 length
>
> Fix Coverity Scan defect on Type 9 length.
> Type 9 formatted length is built dynamically from peer_grouping_count.
> Although peer_grouping_count is a byte, the resulting formatted area
> still must fit in the SMBIOS header length field (u8).
> Add an explicit bounds check before extending len, so the size used by
> map_sysmem() and memset() is guaranteed to be valid and consistent
> with hdr.length.
>
> Fixes: a8442c226635 ("smbios: add support for dynamic generation of Type 9 system slot tables")
> Addresses-Coverity-ID: CID 645487: Insecure data handling (TAINTED_SCALAR)
> Signed-off-by: Raymond Mao <raymond.mao@riscstar.com>
>
> lib/smbios.c | 3 +++
>  1 file changed, 3 insertions(+)

> diff --git a/lib/smbios.c b/lib/smbios.c
> @@ -1093,6 +1093,9 @@ static int smbios_write_type9_1slot(ulong *current, int handle,
> +     if (len + pgroups_size > U8_MAX)
> +             return -EINVAL;

The callers accumulate the return value with 'len +=' so returning a
negative error code will corrupt the total length. The convention in
this file is to return 0 on error.

Having said that, you could perhaps change this.

Regards,
Simon
