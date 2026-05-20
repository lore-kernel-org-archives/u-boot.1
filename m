Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB396CD5BA4
	for <u-boot@archiver.kernel.org>; Wed, 20 May 2026 19:39:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE45A84659;
	Wed, 20 May 2026 21:39:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=binarly.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=binarly.io header.i=@binarly.io header.b="AZhDuvnX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E5D7846E7; Wed, 20 May 2026 18:02:36 +0200 (CEST)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2DE4B843B6
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 18:02:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=binarly.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anton@binarly.io
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-439a8366831so2139586fac.3
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 09:02:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779292952; cv=none;
 d=google.com; s=arc-20240605;
 b=OtaLkSadXMy2wii0T3ISUStD7iCicDU4YQtvmbvHzQCw303wO4rTJSb4Ff6cg/MSM7
 uNMgvvJIE8CSbF2XjUiCwUY3P5vuw/V9Mcy62q6+addXi8Qd7Nuyb6sQBk9tZrOt51ii
 uFraV1D032+D3fjIIjEvFg6ZNc0oaa61ohWbpSiMidQhLPH6kHnoZcMw1fgep65R4Ri7
 bPq7BJ9UcyClOg7twTe2Jgt+yvNkpK37nzBfQwegVLaG4MHC1Gvp6G/Umo8y613doiw3
 DSnYvXG7bANLDsNayCEfZ+8dLmjDY32em35+Jgzo2UiOd34+Lc9iDv2eEjZA6XuLdDAF
 1Fdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=+axqK2UvpIkys6EEMmp3pJw4wAyJFmly+gJwI7YDi0M=;
 fh=tN9KwEd8WMWZJqUQPcNWpVRAQiFf8uBAmwm35dpBfzo=;
 b=DhBQ7nD8RJQUUA424HBRRp/1HI+Fl3Q3xHO44lm5XBxw9zAJUj4qkqeA2Ua6FW9wD0
 ZaJFJqqPupAasufuV9zWSbX1zmVX3OVW5oHzp4sefGZQBiOgWW3gVfdy33Z2pmQoDXmb
 JTo98YKUz/knbKXHQnWsSuTzJAq+yX/Qar2irCfrUDviZKhNEag9/xsER5UXgrnG9vCg
 Y8z+dhNJpgCglh+wWYj8aInfqcqvDndK/IyFBxJt88qwaWwhOQ2EZaUdSKz+vrF3WsS7
 WIKyKpagssnLcsCsVJQm8qTigYpIOjFfEheK0A7k4iYl4nMr0J11qJo4IBdMRH6QPGTr
 HfIQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=binarly.io; s=google; t=1779292952; x=1779897752; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+axqK2UvpIkys6EEMmp3pJw4wAyJFmly+gJwI7YDi0M=;
 b=AZhDuvnXE1FXmYL49brXX6ZZqEPzXDd7aBvRGQkgII7s+ljZevug7fJkLQLaYZj0wj
 obJ6KAPHzP/BzXPmdt0oPt8FXsKY8qK+p+jzsn1gXc/zoLTY0PA7ozFx8zTRHs48BcFU
 KeQPvoFNDK4isNZv8HRX49qM4aecfKR326DbeT4xTqSaqgX9iVMWHKl8qni4WQowv0/c
 w++fBfO2N+74umpIOtDKvZcn7aQX1OdGcqvvC3hd50SFWpCMj9uA05P2x9FbqG/J67MV
 C1RUkg56Gz5cle7wrBs8N34niMEgb4yC7fcDEaC10djq+dt0QoLEgAh4WG4srjCxUe7w
 NwMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779292952; x=1779897752;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+axqK2UvpIkys6EEMmp3pJw4wAyJFmly+gJwI7YDi0M=;
 b=bHWjLDSs6w7xoqnmeGmkUsvs+dPLqo5O6f9SfX5uh+53qz0n+/kZlYOJeOywGCYpRH
 DsAbL0GfR6ikphsFtbahwfESLqVHwyhxXY0DTTWTjrCDoQCdC3WCeXGEwbw5TSAUlCxs
 XEu5YDaGz/w5OM3L0RHcQ4K6r57HED9+A3fSwELk4b1NK+q8gWwMZziWujqQ0iBduv3/
 /BthcGzqx1bMSf3haPgAEJxKAisi2jNGwp8Fmo9yJF7yKnnJtFx2ZhIMwZX7mHIS8Dij
 y3jrnYblK3W4vO4BHb6iUNyKWIK1cfuCiTEp8a1/SlMomuivavcOupG4x0SVzCHIo73U
 7CKg==
X-Gm-Message-State: AOJu0Yzeu3kJqPsrLpFxubb9wcN8kK45auYVwY84IJpngQ3hii7N/pZ2
 y6zDWTXh1p64mL87FM/TLyBYPa1D6Qdel25Oi+weaP7CxbXDQU6DAVrIPOuGhXsYrOxntoJW/3D
 +tnbKIDthfJRserV8BGirrHncjNcIn0MzqvpUdOpTj1f3txtCUptW
X-Gm-Gg: Acq92OGzVp6PQisyYV33EGYaYZmiDtMtJxBuLTmk34QCjtdBkAuLJADkXdHZAz2w6et
 FhpZ+z/WJq14JZ58HU1d3eTIBo3UPOSLJw5rexpE+mlo/esnwYKp7yDuau1c7C55Ui4GegF7lMu
 WTymL8Cg/yBxQiT+IUsnznLG7r7iT0I/QgDEPLonNpXjTpfiLxquJCAqCfyJQ7tP2MeVf/f1h7u
 /8ZO4JZbB+M9SdWyMYn6/0TvKJYvX8QNQQUvlKc6ESMgB8HpY45bu3PGaGdVZ3fXavRq1sTrBFw
 H2rXNss=
X-Received: by 2002:a05:6870:3d9b:b0:439:c9f4:e9ab with SMTP id
 586e51a60fabf-43a2da52aacmr15837702fac.12.1779292951082; Wed, 20 May 2026
 09:02:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAPWaX55jG=pc+SD09V_z4T5q8qBcetZ8OJeKnrDF6w7pQ=tr1Q@mail.gmail.com>
 <20260520143639.GM1858239@bill-the-cat>
In-Reply-To: <20260520143639.GM1858239@bill-the-cat>
From: Anton Ivanov <anton@binarly.io>
Date: Wed, 20 May 2026 17:02:19 +0100
X-Gm-Features: AVHnY4Kk-D-BmeTU6zkmg1rLIFV5zso5XJFUHPm0jmcgieZnDi4BgM-bQHWEGX8
Message-ID: <CAPWaX56ZFuBYURp9m7HMjYf25_sDA2dpEP_8H1h6Z0=ke=_0xA@mail.gmail.com>
Subject: Re: Multiple vulnerabilities in the U-Boot FIT image signature
 verification logic
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Vulnerability REsearch <vr@binarly.io>
X-Mailman-Approved-At: Wed, 20 May 2026 21:39:09 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Tom, nice to meet you.

While we understand your concerns about AI-assisted vulnerability research
and AI-generated security reports, we're not sure why you think these
advisories don't require attention.

We have recently started using AI tools for vulnerability research
projects. We use it responsibly, conducting several rounds of human review.
We have confirmed that all the security issues described in these reports
are valid. Furthermore, each advisory contains a PoC section that
demonstrates how the vulnerable code can be triggered to lead to DoS or
arbitrary code execution, as in the case of BRLY-2026-038. We used either
sandbox_defconfig or qemu_arm_defconfig builds to confirm this.

As for the content of the reports, we strongly believe that they contain
the minimum amount of information required to understand the vulnerability,
including the PoC and suggestions for fixes, as well as the other common
information, such as the CVSS score and disclosure timeline. We understand
that this format may feel unusual to you, but this is how we typically
report vulnerabilities. You can find more examples in
https://github.com/binarly-io/Vulnerability-REsearch. Please note that most
of the advisories were created before the AI era.

As an alternative, to save everyone time, we can provide the necessary
patches to resolve these issues. Does this sound good to you?

Thank you,
Anton


On Wed, May 20, 2026 at 3:36=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:

> On Wed, May 20, 2026 at 12:27:00PM +0100, Anton Ivanov wrote:
>
> > Hello U-Boot maintainers,
> >
> > Binarly Research has identified several vulnerabilities affecting the
> > U-Boot FIT image signature verification logic:
> > [BRLY-2026-037] Null pointer dereference and potential stack buffer
> > overflow in U-Boot during FIT image signature verification in
> > `fdt_find_regions`
> > [BRLY-2026-038] Stack buffer underflow in U-Boot during FIT image
> signature
> > verification in `fdt_find_regions`
> > [BRLY-2026-039] Denial of service in U-Boot during FIT image signature
> > verification because of unchecked `size` value of `hashed-strings`
> property
> > [BRLY-2026-040] Denial of service in U-Boot during FIT image signature
> > verification because of null pointer dereference in `fdt_find_regions`
> > [BRLY-2026-041] Denial of service in U-Boot during FIT image signature
> > verification because of unchecked properties of image external data
> > [BRLY-2026-042] Unbounded recursion in `fdt_check_no_at` during FIT
> format
> > validation
> >
> > The detailed reports are attached. Feel free to reach out if you have a=
ny
> > further questions.
>
> This sounds like what came in yesterday with:
>
> https://lore.kernel.org/u-boot/0100019e40e72ac1-c3d57c2e-cac3-4f65-a98f-f=
1c6173c047d-000000@email.amazonses.com/
>
> And so I'll repeat myself here.
>
> First, the current stance of this project with respect to AI is, "please
> don't" and is well explained over on
>
> https://docs.postmarketos.org/policies-and-processes/development/ai-polic=
y.html
>
> Second, if you're going to use an AI tool anyhow, please read
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3D36d49bba19f2c19c933d13b25dcf4eb607a030b3
> and specifically the section titled "Responsible use of AI to find
> bugs".
>
> Finally, our normal patch submission process is documented at
> https://docs.u-boot.org/en/latest/develop/sending_patches.html
>
> Thanks.
>
> --
> Tom
>
