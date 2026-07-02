Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 111B0C43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 08:31:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0885384832;
	Thu,  2 Jul 2026 10:31:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TSCLRigp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DFD1684CD6; Thu,  2 Jul 2026 10:31:35 +0200 (CEST)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com
 [IPv6:2607:f8b0:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5906846A4
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 10:31:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-845f2909cd4so961183b3a.1
 for <u-boot@lists.denx.de>; Thu, 02 Jul 2026 01:31:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782981092; cv=none;
 d=google.com; s=arc-20260327;
 b=DBYqxdOcAraNXf8//6cwHFOig78UZHHO5Yog2W0NTNTu8aPiLflOEeA7WTZMbXECIR
 rAMXNBVR+2dwhNw9d+2cG+6maJ3Lg48JNSYNC6O2azCq9ZCmdk6UqAf2ArEUjfS5Gobu
 eTOEp9d9a1PDD0YyFWv+mOihpgkY39KdbYH5Z2F2DWGkCfeWNAx83F90+HHdCeTG63W2
 SfrunNARSudn/p9jDn8/03MiUiCEgDuOVmr/NWNPu9Hngjn17KZPMaC8+QwX0Uy7MDF5
 fFkCGjfEkhNZPdHQlrcV+XASH7WV1bBpqeCvAuvOtYdk5GkyJLJOtdXNcUfrMSHYBopl
 XL4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=FN5oIEHKWwQBfMI5Z5vy06bofJdTt5TBqgRXHos3U44=;
 fh=MhAo4QPuXEC/Rh971JORz4rq3nvFSJ8p5JStjvc7R4U=;
 b=eXxfUM0OxtqXPDGiduj/2cm97QjeYDudyBs9ANFbl6IgjjA3T/a/+JO13qXQY+eMOZ
 BC976Kh48ggVaac8QWiD9igbusfPXgTvn212BuvSZxSag9cxV9ljKiHyNzT9enV1Y+EW
 ngcaHYbwuEsU8xjRPM/utPKOB9OlE7U3uLPv2xH9aZWChbBrGchbqQOZyb0NoFXqVxEV
 qJAsyGKmg116opQ82hRlQCW/aSsOH6X7AzKBh/YDRxn4oIk0qxfIVxgR/rKVwl0Ujkl+
 RrDWgwKhCxiVoPrE6/k6bNTjyQQXnFBmw0xQv+V17m8bUu65clTr8b9n0Z+PpSb4EdpX
 B60w==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782981092; x=1783585892; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FN5oIEHKWwQBfMI5Z5vy06bofJdTt5TBqgRXHos3U44=;
 b=TSCLRigp6Mvh64Cf7MaxBhaxKgYFkytcwDhd5sAHxYXcqj2kj3Q/QkE9620e9G58Fg
 5jW2hmBm0XCQWoRgxA4GGv7x7XH83XGkXvwipgTN7sbZ+6jOuV11dZqtFyUg5c1U0Fra
 qBbs1SKtiImPXmUWuOLFJu/NrDa5BemU90Lk8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782981092; x=1783585892;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FN5oIEHKWwQBfMI5Z5vy06bofJdTt5TBqgRXHos3U44=;
 b=Amm5E2hIHgIv1N+Q1wACGIEq8D7f1GFQ3Eg5GFwao0cUSMlu7vvCgb6O02ZIMa0ja2
 LkxB5N5ghtgyrdWd6ytxmIyoDKA3XsST1Meii2t5JtSoNzdwMZ0zP6MFJoN56jQyjKsv
 IN2ip3mh/OLooXKbX2qV4EJUVPx4tMkD/qYAsd1SBYtL61M41RKGGmfjZ9T5qfBqYNDF
 7pg/LFN2EDBnO5mdfzQIUX27qUCoz8pmeFjz+2nehbrb3fgqcw2892qKXUHXR4xnW55L
 rmdSCNNhEfpQUL4Su8AXnLKihHt1iD0q1MgY/jRk/ui9tcKff2H8riCEEzMa69Ha+CIi
 s1Ug==
X-Gm-Message-State: AOJu0YwSGAnwMmaQ8hWl90Ne3hJp7Tz4h0rmrzSx/l7qlCjh/pXhk87A
 36pdpVT4Ic73pLxVIOCjknTr9Vo6PDGdURI7k7K2ANsmFd+mSLx9orut0BW4I+KA5gyN63724OK
 MQNNXS+tPoWzadqLlT0trirzSvuv47CJYdEUpmBj1
X-Gm-Gg: AfdE7cn4UWnHnjpyTXcddE66KEL2F4HcuX7oFzEVPoK5PhtlKzwNSjxgsu+Ek3uNN6e
 W8mO4MuxVLQvoWq0dHWoqUUNCq+16K7QCVprbuzIbITJplMZam7oetR7fUFotDEBif5MIcuaijO
 j3N/0x+yYWAGQ7CnGvI1scZJjMzZnFIzmrm0wLchSNVp6Ba5bD4Z25CMo7T9VeXDZUwkKuEcVNW
 5VPN/BtAOIus3HSjSjiyDgfQz1smxV6v3o6exEZLAjnqusyIE3fwTxUc3It76ydNZNG+m0Z9g==
X-Received: by 2002:a05:6a00:9299:b0:846:a26:8e0b with SMTP id
 d2e1a72fcca58-847c0730cc9mr4865135b3a.18.1782981092221; Thu, 02 Jul 2026
 01:31:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260701171535.906272-1-rv@rasmusvillemoes.dk>
 <20260701171535.906272-6-rv@rasmusvillemoes.dk>
In-Reply-To: <20260701171535.906272-6-rv@rasmusvillemoes.dk>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 2 Jul 2026 09:30:06 +0100
X-Gm-Features: AVVi8CdwOPEa8PHZ7ZrPs2HhNMfSX1suFKo0lG4yxnJWvkPx5pU-Z26ezl3sRHo
Message-ID: <CAFLszTj21D_qhsaZFAaGDg5RW7+jAPjvJhwSHrK5L7bzj0=cPw@mail.gmail.com>
Subject: Re: [PATCH 5/8] string: remove more pointless __HAVE_ARCH_STR*
To: rv@rasmusvillemoes.dk
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Casey Connolly <casey.connolly@linaro.org>
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

On 2026-07-01T17:15:27, Rasmus Villemoes <rv@rasmusvillemoes.dk> wrote:
> string: remove more pointless __HAVE_ARCH_STR*
>
> None of these six macros are defined by any architecture. Moreover,
> the ifndef guard only exists in either string.h or string.c, making them
> completely pointless.
>
> I'm not sure whether we have an explicit coding style discouraging the
> 'extern' qualifier on function declarations, and string.h has a random
> mix of everything, but I can't leave it on strncasecmp() now that it
> will be immediately after strcasecmp() which doesn't have it.
>
> Signed-off-by: Rasmus Villemoes <rv@rasmusvillemoes.dk>
>
> include/linux/string.h | 6 +-----
>  lib/string.c           | 8 --------
>  2 files changed, 1 insertion(+), 13 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
