Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D18B3CD4F54
	for <u-boot@archiver.kernel.org>; Fri, 29 May 2026 23:03:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5AE2883FB0;
	Sat, 30 May 2026 01:03:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QDouunZ6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8567684693; Sat, 30 May 2026 01:03:32 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9EA9805D7
 for <u-boot@lists.denx.de>; Sat, 30 May 2026 01:03:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-bd2e8931915so2836326866b.1
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 16:03:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780095808; cv=none;
 d=google.com; s=arc-20240605;
 b=M6VIgWxTuFGdMPmxz8l2mZa9cOEbnO7geZGUJRz2DZItuOPLXO3sat+cqc6Cc5jDJB
 Tb2w8teiS0DavPyO14x/X8bH67Viwf1iegqO9OEUoqR2TqcBPO79FosTyFdOaz/PGwd9
 NH8ZcKoFOpICx+P3MvEbe10Qi0iDyYOA4Q/tG3JnyBFcaVJ+WMj3ncez0bWziYq1eM5n
 B2YcaP+98CRSjyN/6sXcFCHVTgXuNmRsMiRWyJdKmb66OJopVSutBvv4AUTRTKPpbqep
 H2vyqJYBWPP19U7l38Lf3Rnq7+GJG0nHs0xP+7MRZXSTu3Td94JKR0bb9UjRtxtfh+OL
 RNVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=xqAzdmNSnUWaNQO6puWmvqxg3ZROi8A12q1eBKwiW7g=;
 fh=Hlhgev5xB0xlM2njeo0mv1AJniEuivCiBjj7I4NN/4E=;
 b=AxzOM+cHbUInBKerwvLt6SyRcv8dfv/hJfCwyqxnD34YBQ0wjEb+MYeQN6f9W4Zs/y
 Q0rD+8U8U5SN2zmIVBuU2cza7HiO1CDMzS5OxfEKNrtRpQ1/MVr0HNiWoc6FhKzMwYWX
 BlrzP5TbuTtZLKRuBKd+HaSqU+xpVDgrdIVXIyBhBDHW8QlLPIm3t1bPyZXgideflRMC
 ZVE3/U2/z+fVGCIcnezzIhVN2TTLNlU9pCTMrpdLuTkPnpGAq+XV5CcOuJt6nDyX203Z
 6tMWmkbPHekmlUoA1x6kbMvBHP4NCNQ5dOv9Oi805VTEYUjh0DpPZzBpyV6yyENwZIwt
 jcIg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1780095808; x=1780700608; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xqAzdmNSnUWaNQO6puWmvqxg3ZROi8A12q1eBKwiW7g=;
 b=QDouunZ6IcMJDGAYCIvfw8QD36JM8xr55bM5+ofo/s+KChsw4jPk/wE4cA905tr07h
 pxsHpEIzEWQU4jiW6P7/eXc83gmXESq+nPjg1Y3nqORmiPBGv5waoglroeg77Qx973Sw
 VWaoc+epORNVb4017+dwqnRJsN73y5bhz+ge0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780095808; x=1780700608;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xqAzdmNSnUWaNQO6puWmvqxg3ZROi8A12q1eBKwiW7g=;
 b=d0ySW856RrOrU79IvydaBvDYAcTJznMrBzY4qJQCDDXQ90oIuptXYPNmiUNg8saG5y
 kSGTm1tGWs1gM8z4EzuB5luzqXlJYk3jK5OYfsZOjYAoyxRnRtGbfGOM0t2qe0bqeWAX
 88CSdXJMxqHF2tq2VSrMzdc/Jo5WraoqWJ7TKq/qwRRg+kXweMv2YU9dG5rhH0iv65rB
 qw9Ei6ahPGB44fqPqmhEVt+6+6FW+p9QEpBRN+12JJoJWlj4tefxdblf/0DbH68z7PNw
 Z/Vot16kpxDVjQieWHKbSgMbIf0HHf5WQVXYYfC56ebWcj5dOJ2GL2H4i+i78RSXIJVe
 Xmdw==
X-Gm-Message-State: AOJu0YzEgxWo82RiKyxukOoZSY57F5UVA+/N1JfDt1811lliKNLMbr5K
 41HuG72bCEzkEbN3YxJHTgJEaD9FOVyHKTnxkeSw0M1OUcW9RDGt3XZd8HUadRx8pNHXeydj54n
 Spl7v6vEZU5PiCn27dWeA0i3cZmgHCzhXUKKZKL2m
X-Gm-Gg: Acq92OFQhMpBNQOwv1bIxAqBJcN29bxMkvRWtRHrCVCXZStGo+sJONFNc/B1+rEXikX
 /2zGX8jJLkxXNC2aNdlB5ZgLdu6PUid48VK3po3+mQ3jmws4kG++dh1l3/zbG5IjodGzZCEsOCx
 Uuy6BonU9sTOCsi65jRcrc1YTUNhpEfCnPsTu+Sw24f1M7xXYV8JtVseRZaMLDKxK48qKURf0lM
 tNwI5SaTgmpzj4Ik2gQ1qEEHp6AxZDjfAerlv7ua5q8vmGtMu5K9dPJa7mS8C2tFWNBkjQAEW2x
 MrS2PpE7sFvO6hVAReY=
X-Received: by 2002:a17:907:75d8:b0:bd5:eb9:6a53 with SMTP id
 a640c23a62f3a-beab06e370cmr60582466b.4.1780095808305; Fri, 29 May 2026
 16:03:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260526105449.48631-1-anton@binarly.io>
 <20260527112443.13870-1-anton@binarly.io>
In-Reply-To: <20260527112443.13870-1-anton@binarly.io>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 29 May 2026 18:03:03 -0500
X-Gm-Features: AVHnY4KaVYud_fAeXGYarqH1W1JQX_2uJKO-82hxehy0iMGvgT3Dn1PZYOzuVdI
Message-ID: <CAFLszTjx_ea1bAG-Lh=-mmG7dGc07x4_qvRznANJ+7X7O3ApLw@mail.gmail.com>
Subject: Re: [PATCH v3] fdt_region: Check return value of
 fdt_get_property_by_offset() calls
To: anton@binarly.io
Cc: u-boot@lists.denx.de, sjg@chromium.org, trini@konsulko.com, vr@binarly.io
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

On 2026-05-27T11:24:43, Anton Ivanov <anton@binarly.io> wrote:
> fdt_region: Check return value of fdt_get_property_by_offset() calls
>
> fdt_get_property_by_offset() returns NULL for FDT with version
> less than 0x10. Callers in fdt_find_regions(),
> fdt_add_alias_regions(), and fdt_next_region() dereference the
> result without checking, leading to a NULL pointer dereference.
>
> Add NULL checks before accessing the returned property pointer.
> Also add a missing NULL check for fdt_string() in
> fdt_add_alias_regions() and fdt_next_region().
>
> Signed-off-by: Anton Ivanov <anton@binarly.io>
>
> boot/fdt_region.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
