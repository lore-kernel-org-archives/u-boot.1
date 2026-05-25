Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 968E9CD5BC9
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 15:05:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2AAE484862;
	Mon, 25 May 2026 17:05:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bruL0B50";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C89518486D; Mon, 25 May 2026 17:05:07 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B95A484841
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 17:05:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-bd4f7f05e90so1681190566b.2
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 08:05:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779721505; cv=none;
 d=google.com; s=arc-20240605;
 b=KKdjkDdyrw8k2fs0c6Ls1dJCdQETo7qxWvQ5XKkq5LC4PrK/lTPHl0E666ZTiCMUf3
 3sy2MfZUz//ybRexB3cPbF0xmexKoJDGYEEmx6Z8yoCSIRM+Xbdh5kJ8TCLXDRi1mUpH
 pTSB14CDFdT7Wnaqq58m53xJK18XP13sEgy8XMSmH0RcQMlgTawjo0uRoGzRg/v/nxbZ
 tbQQPfM3PNwi/MjJwP1sEBnggxLbaxLHoCtgiCUvsM9UdRxW8yG8MJtDXSew2eoMzsIF
 Uem7hVUeFDnlSjroBXWn2aZjNFkpR6EMwT5adHIXIvzToYuGzr761FF1mLqGFY6NZ5hp
 sItg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=6ILA+K4KkNN5Zddeb2pco85cNSS2OxFsDS41sbxrH9g=;
 fh=uEwfVtgWmQ+BpqL3MMm4A4agCJ5OLHBunogpqm9TwOU=;
 b=ijpRShueqOJkRUgC9uFNIdYEGLcbVvVckTJ4TqeWtH1iNGhCML0VivpslP25EgrbJL
 pa0J5i8gDjGkJwXD32xIf9kF+smlp4HkXCj8gJ58D/S3S/nIv1N5Fz0ItH+iaGceCqEk
 QFpKnMyrt5P2m+BRD4mesvVjrUA2mbDqCkwkole/ES8+CAlNZxVQY5WBNDPrk2uOmV5p
 3m2EF8Tl9GZ7c0kHofpbCotfpoSC3BxObm+HpIFNRBYC4pd63sszHDP3LVgr93LFJpS4
 cFHnj2VFdZTQIzMk29iYYYDnttacCPadnahGdH93RZQHPTebL59Qk3mLqhfRd3nwZ675
 oRow==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779721505; x=1780326305; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6ILA+K4KkNN5Zddeb2pco85cNSS2OxFsDS41sbxrH9g=;
 b=bruL0B501hWVv8okZVIKc5JUlXUvLQuN6NUa+uMBA8QeNkBonM9fkokwWGryJJELpa
 2y4sz6wMTVqJn2OL0ULg+D1s/Ij6e8ebmJWg/lv63JU6G8mN5LF/7/eLe5ZQO+vOLdyu
 KavBWAF8DGqVp7B5PkvMCLjOSwtlijB4eqigM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779721505; x=1780326305;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6ILA+K4KkNN5Zddeb2pco85cNSS2OxFsDS41sbxrH9g=;
 b=Mf/A3VaFXvuHulD+P2kMOxTEmJpPtgOD2+9AAaznh1t1o9qw0odcrQMg+scmZ6Y2v6
 QfJgQeZ87ywnIUqDTL90Wq/FetyM/AIQ2AeojMw6OujD4lJVV0n1g4hUuy8Vtd7xgUa2
 5Hp9FGHl4gx14SV4y0GfPgNfGIPl/bda1o7nDCpY7JoJXQ8BaTFGEZzayENfYSn5Bpz+
 FBI6oxJhxKWnJoX4UC3cn/mO0QB6e/RMWXdJKLiixzoP3Lt0emV44kJZU/18Wa2NWI0z
 YMUdC5KaFG2XnF573Sh8YFJQrM/7sEAPqz6I350xeZu7f+TDqRgXrbLZGTihjFCOQz5D
 Ojyg==
X-Gm-Message-State: AOJu0YwokGBweMcGBT4T4c6SXj6+ik83JJ8Sbwcm66u6zu7q19tN4lXc
 STEOfO0MvbT/jCPblmDOt7SDuUub345vwrfKXEOlO0xsOfqeu29su00dwqLgPDrmqUa1CDDJzb/
 WWHKnjfa+6M4/SOGEqUaPP/gmC1Te4o/9//yZ+r42
X-Gm-Gg: Acq92OGM67653ooydG7u7pvI8/ZhV+CWqtbDuQkrzIB0CQ9rEZma3Gq/vorowrHNGKn
 k9WUNxDlD+HUY1aCC1/w/df38GswQVm0HZssiXmLuYWlr7ueh4X7VNFFhxyb0SeMyCc2TWSFFW8
 RedJPxMSOtgA+WK+HfquVuTMu5GLOSqQWX+I3MKnihrb3NR+U1UnIXoB8fmgg0GVyQ8ZXNKrrOS
 Fzn7ES828RUMAzZKxR2G82dGHaFNWGGX07HUe+25ZgqpX+lzuvQ3WJGt175qDmVz7Nf2HlxV6sf
 je4oLQ==
X-Received: by 2002:a17:907:602f:b0:bde:170:a0ef with SMTP id
 a640c23a62f3a-bde0170a22dmr510206266b.27.1779721505045; Mon, 25 May 2026
 08:05:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260522212756.3169222-1-ravi@prevas.dk>
 <20260522212756.3169222-10-ravi@prevas.dk>
In-Reply-To: <20260522212756.3169222-10-ravi@prevas.dk>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 25 May 2026 09:04:52 -0600
X-Gm-Features: AVHnY4KaEo6rtJFaPQqfJg7T86oNH3J7Z1169mCADWMlSyxYMRF-Fj0ufY0PTok
Message-ID: <CAFLszTgeAxEAuCr+xQRk0ysJ0bOWHg6J5q-VFTQhcLY=pP2+XQ@mail.gmail.com>
Subject: Re: [RFC PATCH 9/9] tools: add linker-lists.py parser/checker script
To: ravi@prevas.dk
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
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

Hi Rasmus,

On 2026-05-22T21:27:48, Rasmus Villemoes <ravi@prevas.dk> wrote:
> tools: add linker-lists.py parser/checker script
>
> Add a python script which will make use of the special symbols emitted
> by the linker list macros, and perform various sanity checks. By
> default, it ends with printing a list of all the defined linker lists,
> including their start/end addresses, the size and aligment of
> individual items and the number of items.
>
> With --check, it only does the sanity checking and its exit code
> reflects whether any problems were found. That is eventually intended
> to be done as part of the build.
>
> With --dump, it not only prints the lists and their overall
> properties, but also the names/addresses of each item belong to the
> list.
>
> Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
>
> tools/linker-lists.py | 234 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 234 insertions(+)

Perhaps check-linker-lists.py ? BTW I did write a checker script which
works just with the existing linker lists, but I don't think it is as
powerful as the mechanism you have here.  I'll send it as an RFC just
for comparison. That is how I found the alignment problems.

Please use single quotes by default for strings (unless you need a
single quote in the string, iwc the outer would should be double
quotes)

> diff --git a/tools/linker-lists.py b/tools/linker-lists.py
> new file mode 100755
> index 00000000000..419879ee31a
> --- /dev/null
> +++ b/tools/linker-lists.py
> @@ -0,0 +1,234 @@
> +#!/usr/bin/python3
> +# SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +
> +import sys
> +from argparse import ArgumentParser
> +import subprocess

Please switch to '#!/usr/bin/env python3' as the absolute path is not
portable. Also please add a short module docstring

> diff --git a/tools/linker-lists.py b/tools/linker-lists.py
> @@ -0,0 +1,234 @@
> +class unique_dict(dict):
> +    def __init__(self, name, format_spec, *arg, **kw):
> +        super(unique_dict, self).__init__(*arg, **kw)

Can this just be super().__init__(...) ?

> +        self.name = name
> +        self.format_spec = format_spec
> +
> +    def __setitem__(self, key, value):
> +        if key in self:
> +            old = self[key]
> +            if value != old:
> +                warn(key,
> +                     f"Inconsistent {self.name} for list '{key}': Old value {self.format_spec}, new value {self.format_spec}" %
> +                     (old, value))
> +            return
> +        super(unique_dict, self).__setitem__(key, value)

Mixing an f-string with trailing %-formatting is hard to follow - how
about something like::

    warn(key, f"Inconsistent {self.name} for list '{key}': "
              f"Old value {old:{self.format_spec}}, new value
{value:{self.format_spec}}")

with format_spec stored as 'd' / '#010x' rather than C-style

> diff --git a/tools/linker-lists.py b/tools/linker-lists.py
> @@ -0,0 +1,234 @@
> +def handle_symbol(symbol, address, size):
> +    if not symbol.startswith('_u_boot_list_'):
> +        return
> +
> +    symbol = symbol[13:]
> +    if symbol.endswith('_1_start'):
> +        assert(size == 0)
> +        start_address[symbol[0:-8]] = address
> +        return
> +
> +    if symbol.endswith('_3_end'):
> +        assert(size == 0)
> +        end_address[symbol[0:-6]] = address
> +        return
> +
> +    if symbol.endswith('_0_item_align'):
> +        item_alignment[symbol[0:-13]] = size
> +        return
> +
> +    if symbol.endswith('_0_item_size'):
> +        item_size[symbol[0:-12]] = size
> +        return

The magic slice offsets ([13:] etc.) are fiddly to verify by eye and
easy to break if any suffix changes. Please use
str.removeprefix()/str.removesuffix() - they are self-documenting and
the offsets disappear.

Also, the two assert(size == 0) calls are the wrong tool - if the ELF
ever contains a malformed start/end marker the script crashes rather
than reports. Since the whole point is sanity checking, better to call
warn() (and carry on) instead?

> diff --git a/tools/linker-lists.py b/tools/linker-lists.py
> @@ -0,0 +1,234 @@
> +subp = subprocess.Popen(cmd, stdout=subprocess.PIPE, text=True)
> +
> +for line in subp.stdout:
> +    if '_u_boot_list_' not in line:
> +        continue
> +    parser(line)

There is no subp.wait() and no return-code check. If the ELF is
missing, or nm/readelf is not installed, the tool writes its complaint
to stderr and silently reports zero lists - and with --check still
exits 0, which is exactly the failure mode this is meant to catch in
CI. Please check subp.returncode after the loop and fail with a
message. Using 'with subprocess.Popen(...) as subp:' also ensures the
pipe is cleaned up.

> diff --git a/tools/linker-lists.py b/tools/linker-lists.py
> @@ -0,0 +1,234 @@
> +ap = ArgumentParser(description='Linker lists sanity checker')
> +
> +ap.add_argument('--parser', '-p', default='nm', choices=['nm', 'readelf'],
> +                help='Program to use to parse the ELF file (nm or readelf)')

The whole body of the script runs at module scope. Please wrap it in a
main() function with the standard

    if __name__ == '__main__':
        sys.exit(main())

guard. That matches the other tools/ scripts and lets the parsing
helpers be imported by a future test without side effects.

> Add a python script which will make use of the special symbols emitted
> by the linker list macros, and perform various sanity checks. By
> default, it ends with printing a list of all the defined linker lists,
> including their start/end addresses, the size and aligment of
> individual items and the number of items.

Typos: 'alignment', and later 'each item belong to the list' should
read 'belonging to the list'.

Regards,
Simon
