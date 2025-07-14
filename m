Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DB86C83F1A
	for <u-boot@archiver.kernel.org>; Mon, 14 Jul 2025 17:05:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C615D82F14;
	Mon, 14 Jul 2025 19:05:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="IXm4U7GH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7A0D83046; Mon, 14 Jul 2025 19:05:30 +0200 (CEST)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDF5082E37
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 19:05:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-40a4bf1eb0dso2044013b6e.3
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 10:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1752512726; x=1753117526; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AEjvudriAhDvwt7EouajwCcuspOgYjOQ/QjjLAn/CFE=;
 b=IXm4U7GHt91GVSv5w3RkCZc0nKoOctkERtPE1Lpdb0jlW3Zj8dUWsbjMWA4CBEbrj0
 eGVRJeVyolnnWhUpRkm/2oXO+GTf6DZNbwy57KBCT/2lZ+3Roq1N8cy1qgr2wdPXBvzU
 sNDz/XcZhXSlSkPFjMNO/iF02vx1gL1W21lB+LKW0oOhe7aj70nMuH3osMF87Beln8mx
 bdE355vaUickNE/AspZh6YpwcMDmNamY8O/N0uzcdUvBo/2cthuHbMgK2+uMzDvzowqS
 Pq6CNKcRjayzq+yX4WLBINep6u8kaLDprE5zGnP9rQlYWp8YEO8jZzhkE2bgki7j+N/N
 t+iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752512726; x=1753117526;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AEjvudriAhDvwt7EouajwCcuspOgYjOQ/QjjLAn/CFE=;
 b=lonarZaOJPX1+jxGbi85QXVMY1FwPWrfc/k5l1zendZu1ehvtevl7cCGbioeW/QVdn
 bkQMuqKWWyXcuZ4l4vK9/U/i+G0IAf9dBhX6mU1NyaMBZug4eWBByqtQrFo+Hzl3N+rJ
 ur9Bt5MuZmVUPtPi10dD0USa/SsKPORwWrFF5/xibnAmsVJ2PAGh5JNtnoqqwVX7LmXx
 FPg3y9pcdowAGF5fBRyi00smuvVFNgyn2+lO8d1x5UpfCWmOuWMEQ//OKwPi/BqcZJnm
 VRLIYpDrB2Y+kbO9Rj4pixEHqgbQBh8T1o3wggvfKlaxzFi4XIAWqHClO3YYu95FdLcW
 J3QQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUG2yQTG9l8JW+osjDZ8RX6Hi7Ni8ptl5exWrgqzlLaibZy1KwVRSshTHRaPDGouW9927lxEzE=@lists.denx.de
X-Gm-Message-State: AOJu0YycxH9tdhhSZ6ep6uT5DAKBb/rNWTD9L8JspHHoI2vw4JSDrs2u
 dOo7loBjjBPWgekkb6jppdcoZr8UBMT+FtB4NYnR1SywF6ZfRiOH61MspAi87zzlbnItuFPyc73
 2gU//9QNt/I4adlBQgPEXZSDnX5HXUJnfscfqj3x1hQ==
X-Gm-Gg: ASbGncurPrjeKGG/yALnV0Or0krNPSgnCx5etPI6rZOKCsos4ro+iXkhSPN0VOloQwC
 9a6kFW6VM+3MzhXbX7iHaixxxoJfo1ZhACEhvoz1UNY4EQSKwss02R8ZsVhcBMw9WyEYM2Y7PvV
 c3mu/71hdGtWAfGQ/ZhuLj9DJxew6rGww0e8cpvd4U4G+8zUSscpSv6VfAUOdqgzIhTHYoA5ut1
 +hGvvE=
X-Google-Smtp-Source: AGHT+IE0sy0Isyq/9YEXzqWqOJtZ3HD/PO4DDPZ1w5IeKW1pqKQw5bOcyRdJx6ms0lnOsEI3eLKrCzCuGNwoeZ2WHtU=
X-Received: by 2002:a05:6808:171a:b0:406:6a36:230c with SMTP id
 5614622812f47-415397b9ea5mr9240428b6e.19.1752512726603; Mon, 14 Jul 2025
 10:05:26 -0700 (PDT)
MIME-Version: 1.0
References: <20250714-binman-typing-fix-v2-1-dbe6519c43a0@phytec.de>
In-Reply-To: <20250714-binman-typing-fix-v2-1-dbe6519c43a0@phytec.de>
From: Tim Harvey <tharvey@gateworks.com>
Date: Mon, 14 Jul 2025 10:05:14 -0700
X-Gm-Features: Ac12FXw3ibR_tf4iFFbXMDk0rmRgIgNK-sjdhutQjVvcAWheIOXGdRLsPDtQ5xY
Message-ID: <CAJ+vNU0qyE40o44WHDNuLYSz-9mmJ+xEHAWS17P2Y7UYw8mW_Q@mail.gmail.com>
Subject: Re: [PATCH v2] binman: Fix typing for python >= 3.5
To: Yannic Moog <y.moog@phytec.de>
Cc: Simon Glass <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Tom Rini <trini@konsulko.com>, Bryan Brattlof <bb@ti.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Sun, Jul 13, 2025 at 10:44=E2=80=AFPM Yannic Moog <y.moog@phytec.de> wro=
te:
>
> To make it work with python 3.5 and 3.6, need type hints from the
> typing module.
>
> Reported-by: Tim Harvey <tharvey@gateworks.com>
> Fixes: 21bc3433a43d ("binman: rework dropping absent entries from package=
d image")
> Signed-off-by: Yannic Moog <y.moog@phytec.de>
> ---
> Changes in v2:
> - drop newline changes
> - Link to v1: https://lore.kernel.org/r/20250711-binman-typing-fix-v1-1-6=
6ab075015ac@phytec.de
> ---
>  tools/binman/etype/cbfs.py    | 3 ++-
>  tools/binman/etype/mkimage.py | 3 ++-
>  tools/binman/etype/section.py | 3 ++-
>  3 files changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/tools/binman/etype/cbfs.py b/tools/binman/etype/cbfs.py
> index 5879f377231bf94697bea97c3cfc3a2515665b8f..c5e77f3a0df22ff768aa7254e=
4dd9ecbe6f81684 100644
> --- a/tools/binman/etype/cbfs.py
> +++ b/tools/binman/etype/cbfs.py
> @@ -6,6 +6,7 @@
>  #
>
>  from collections import OrderedDict
> +from typing import Dict
>
>  from binman import cbfs_util
>  from binman.cbfs_util import CbfsWriter
> @@ -276,7 +277,7 @@ class Entry_cbfs(Entry):
>          for entry in self._entries.values():
>              entry.ListEntries(entries, indent + 1)
>
> -    def GetEntries(self) -> dict[str, Entry]:
> +    def GetEntries(self) -> Dict[str, Entry]:
>          """Returns the entries (tree children) of this section"""
>          return self._entries
>
> diff --git a/tools/binman/etype/mkimage.py b/tools/binman/etype/mkimage.p=
y
> index 75e59c3d3a3104da7559982f64968fdd99b7bd5f..9f68f3386bd4d6615a9c917de=
6b783c2d20b31ee 100644
> --- a/tools/binman/etype/mkimage.py
> +++ b/tools/binman/etype/mkimage.py
> @@ -6,6 +6,7 @@
>  #
>
>  from collections import OrderedDict
> +from typing import Dict
>
>  from binman.entry import Entry
>  from binman.etype.section import Entry_section
> @@ -205,7 +206,7 @@ class Entry_mkimage(Entry_section):
>              self.record_missing_bintool(self.mkimage)
>              return data
>
> -    def GetEntries(self) -> dict[str, Entry]:
> +    def GetEntries(self) -> Dict[str, Entry]:
>          # Make a copy so we don't change the original
>          entries =3D OrderedDict(self._entries)
>          if self._imagename:
> diff --git a/tools/binman/etype/section.py b/tools/binman/etype/section.p=
y
> index 03c4f7c6ec74c6fa75c9362e2fecdb0e6ab568cb..471c6fa55879c3d568ea64275=
0348df216fa1e18 100644
> --- a/tools/binman/etype/section.py
> +++ b/tools/binman/etype/section.py
> @@ -12,6 +12,7 @@ from collections import OrderedDict
>  import concurrent.futures
>  import re
>  import sys
> +from typing import Dict
>
>  from binman.entry import Entry
>  from binman import state
> @@ -537,7 +538,7 @@ class Entry_section(Entry):
>          for entry in self._entries.values():
>              entry.WriteMap(fd, indent + 1)
>
> -    def GetEntries(self) -> dict[str, Entry]:
> +    def GetEntries(self) -> Dict[str, Entry]:
>          return self._entries
>
>      def GetContentsByPhandle(self, phandle, source_entry, required):
>
> ---
> base-commit: 6bb0679377abb01a82db1ce69b5bf1d40aa02ace
> change-id: 20250710-binman-typing-fix-a207bed6416b
>
> Best regards,
> --
> Yannic Moog <y.moog@phytec.de>
>

Thanks Yannic,

Tested-by: Tim Harvey <tharvey@gateworks.com> (Python 3.8.10 on Ubuntu
24.04.6 LTS)

Best Regards,

Tim
