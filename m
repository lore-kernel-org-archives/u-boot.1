Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8644CC3ABCB
	for <u-boot@archiver.kernel.org>; Sat, 10 May 2025 11:25:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37CB382A1C;
	Sat, 10 May 2025 13:25:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kB5Qzst8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D26F82A1C; Sat, 10 May 2025 13:25:44 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7EAD48295C
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 13:25:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5fbc736f0c7so4346920a12.2
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 04:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746876342; x=1747481142; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oQQucchflNQCZdACjDAw+jkUU6ai0fp0HKVU8vqNMCk=;
 b=kB5Qzst8+lkgvg3OuS2Aj0ZC+owiYS30HvaK0IeKBFTcdkbSiMBNPlfNpFDjRf8dHX
 AEI0WR5MKxESvXPqcdvoLQItY+67L1c5Js5TBljsR97o2jw/70grrmUVNzgrJ7xMAmsD
 FAy/aZr7uXZVM/2QmnTSZEFK6arTafNnk/3r4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746876342; x=1747481142;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oQQucchflNQCZdACjDAw+jkUU6ai0fp0HKVU8vqNMCk=;
 b=JR6SGIbpYTd3O0gGkyAoYSOtwFxZDFROAe8wzfCDVVPQ+GUycqEcwkGDP+3+OOSauv
 rgE69C6ZL51cv1EnRFEtPCt0hpdi82hEuRbwE+DY41aIrlV+u0RVrmNlhMmUq7Sk3OF4
 OGyM0Cy9GvpxJ46PfOoV/3ptapJfh+G/VvTJkvVDBt6HdoR7mm7yGWblTSxoJb1JpcHP
 fwke6o0M3yFrHkon9G1imdmjh5UpcMfp8yowytWSpZhSgPbHn0IJMbb6K8KaWActCp8e
 yr5uvjbN22S+Nsc0QHo6M2uerPcwf1Cu4k81jtf8IHwSgTlZBjHo/Lxn+MyBXHjyFtLa
 l3og==
X-Gm-Message-State: AOJu0YxpU5JJcWBTVH3LfAAIQodgRlTznLTD4g+1+rTB1GIWsdT0iWmm
 mYfqgleXgqmtqwyJ1Aao3GODZ8kvqNponA2Oe/MJ5+FspgcLZZSPGJ/EhEAWnaT5S2XSo9sYndN
 hgekEFT2XtMmksJ7xG+iaYPN+E91doxDas3LT
X-Gm-Gg: ASbGncuQC4EOmc66ujoLfeP6OYGG1k3P3zyEsdcO/gXxLCSpmsjNLW/ACc0BmQ0CQYI
 9R7B4s7x8BL8TgJnw2k5b/bma7+mrZAVZtuDo0cQbBecbMsqztaUW5M/m0rX5FLSGk7v5cl0ZPU
 Z1IqB4LEBEe63MeRRb2/PX5QuJL0Bv6a/7DEj0igrdUKiu
X-Google-Smtp-Source: AGHT+IHgdgN3n4r1OpeBOxiRoP+WMH4T8BDgfTm9g8r3+iGWNX1qAV6qCPcTXdX44bGR0mtosJYlt6cPr/jwy6OSoOk=
X-Received: by 2002:a05:6402:2711:b0:5fd:1a42:17b0 with SMTP id
 4fb4d7f45d1cf-5fd1a421bc4mr203142a12.9.1746876341736; Sat, 10 May 2025
 04:25:41 -0700 (PDT)
MIME-Version: 1.0
References: <20250225205003.2640910-1-trini@konsulko.com>
 <20250507221112.518041-1-trini@konsulko.com>
 <20250507221112.518041-4-trini@konsulko.com>
In-Reply-To: <20250507221112.518041-4-trini@konsulko.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 10 May 2025 13:25:27 +0200
X-Gm-Features: AX0GCFsNleiseVXzLXNDKImtSgv0Q-A9u9SJyuqJBJibivyX39CP0n0qZEbAMQw
Message-ID: <CAFLszTh+5AT2pmKwY38+16+Ujdooa9e+1BB=oH3P9z-1PN7hAg@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] doc: pytest: Document the test_net_boot test
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>
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

On Thu, 8 May 2025 at 00:11, Tom Rini <trini@konsulko.com> wrote:
>
> Add the test_net_boot.py test to the generated documentation. While most
> of this was already commented correctly for inclusion the biggest
> problem was examples of code without a code-block notation. This in turn
> broke parsing. Add the missing notations. We also must have the comment
> prior to any import lines or it will not be seen as a comment on the
> overall file and thus not included.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Simon Glass <sjg@chromium.org>
> ---
>  doc/develop/pytest/index.rst         |   1 +
>  doc/develop/pytest/test_net_boot.rst |   8 ++
>  test/py/tests/test_net_boot.py       | 163 +++++++++++++++------------
>  3 files changed, 98 insertions(+), 74 deletions(-)
>  create mode 100644 doc/develop/pytest/test_net_boot.rst
>

Reviewed-by: Simon Glass <sjg@chromium.org>

Can we add some default binaries to the tree, or somewhere else?

Regards,
Simon
