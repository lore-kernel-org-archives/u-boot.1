Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC9A3FF885A
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 18:08:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45FFA8467E;
	Tue, 28 Apr 2026 20:08:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lgznVTK/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 024B58467E; Tue, 28 Apr 2026 20:08:35 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46CC58467F
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 20:08:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-b886fc047d5so2100066466b.3
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 11:08:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777399712; cv=none;
 d=google.com; s=arc-20240605;
 b=bLlCO58iVKctlPF+1a9GzqLm2LQI/HVSsqoAAqtS9TZ1DSr3CdeY4RPNAXBGikTbcI
 071ofEpGMW7hKQrF3ooYxeLHpfh6KqCKB40Wjz3L3ENu6JBK+frIX8oK5W/2qjL9aXDp
 fw3Km635x6c1yEqahGRoe77drR7Ivg7PXd8sjb136lhsRJv0GjMcVxlGcEPUzU9zizhf
 Xa61ID/gK/CO6cJWpPg/FBf9ouNy+pcF9/qpy7vE/PC8yAV0NZwp9hCa+lFowv7zegZp
 2VYSoPiZtnrAqL35TArHDnh/z1RLSpc9Z0NviR26qWtIyB1vBHxrJowP5GKRlgaEIgij
 NANw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=+3vBP387zf1jia1OQ45saMcFfzzBrKHmgyCEDnXvPho=;
 fh=GYIekQEhESPWanXHuipF/cx0w9AeOdHDaa7vPtUoRvA=;
 b=NnsbjrOsO3GBAkQ3SYvwCMmGzMeU8g2hckPRqFHvBjvWFVxUI/zhzvB7GM+M+da8Ia
 t/Nh1guaK2E1UpUb2ltAkA7xr9PJWkS4uhv7p6SveyHpi7AoOHW6llqT27K9iyNowESL
 gxH/kzqsRuGyYQwaMqbOo4GbP7mBj7KGi1kft4sreT4/vAwGUqQbzPjlNKFODdNer6On
 cryW811BQU5JxdJb+j5bbZ4uhitaTc7lUpw1Ki8YBNandyp5EWIYbvQtfoDSTpv/Awl8
 0kqjFFk2lot9Jj9VVQpVEgE/GltzAuBd319wXXc07TIo6eWA/TWzTXA/8CLsiaHXBjFH
 rTIQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777399712; x=1778004512; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+3vBP387zf1jia1OQ45saMcFfzzBrKHmgyCEDnXvPho=;
 b=lgznVTK/RsoMWPOtvn6ERTA3ZBAbh3+NTseoAbFcOJPTPSTqU6cpjUIIVGNWINaNBr
 5A185M6f6MPFByeOuTqYKh0SvKtr6cZb3JnOOQnLlU12V4XOoVqBi9nWocAfP8DsNam2
 eg+XWZiYaADaJu4TgKFTYu62cl1NLepW+522U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777399712; x=1778004512;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+3vBP387zf1jia1OQ45saMcFfzzBrKHmgyCEDnXvPho=;
 b=ULBOdXLPCHIBqXsIPNNz3InGuT39glIMq+O66Cgox4wjlmY0InkWuwJcw3IOfNSPcy
 p5HvbIqZ0dZgMPw3YcWqseiAQhxevRP6bx7rFJAQWXYXhOGzD3tHMe7uYCVQ9PY3NRQA
 DS+INrm0kiuVb3cuHrwSkbAMBxH3hxN/bwfu8DPWgxX+waZkAvsU8meBY4wKptyMILuo
 YcXQF8VRi2WXigIVSPO2w2rF2Omf2iMQxStmRv6WeDN9hplEXLdpaY+jrDVvaIY/azs3
 aJsAbyJvdKy4alGMUtZAPlR60JeuBU344WWT9dEkqH0bFwaqyGCD2xqHjyoN5l5j9Rce
 Yxyg==
X-Gm-Message-State: AOJu0YyBP9kZPFYYRTombbRincaBUvwxJm9lX3HEQa4ek1pc2RaVHsz1
 GxxjB58t+9Dj44xMwFA7KPH3sFaxS6VmJJc2H85bdzYWZCpq5NYPqYbu59M2ChKtD77atl8KQt7
 0dD81sTnqxfQY3qHxsGd3OYaNE3uaBbTG8eCBkK3v2y2QKs/EotQ=
X-Gm-Gg: AeBDiesRU495Vpb2PA4ZZbPNLisaMYcEHUQ5NCcFbWVHu2u8+Jp1CMOoVzLQtjhpcEj
 FqKI8Ypi2JrtmIzaYeIBCyO3ivJzG29PxnonDa439mAN1pgCfjcP8WedFyulLVoVu6YzlzGTfQr
 nIf5JmdCIJNEExXC0iGLpAOW99Q7i8OPUt1MqA1WqBIQYYPWMuUPfzJxijJJdNLJfZ9MGiL4Xws
 Ln4AgIizocbWfH9RHcuuqh9WyG+DvKcloYfXiMdHlRIc1vFRS/uwNiYYNaH9oFDD8jQhkLeH9a6
 0Pr+kswkksJA7a/7
X-Received: by 2002:a17:906:ef05:b0:bad:8491:85f3 with SMTP id
 a640c23a62f3a-bb804c32754mr247504066b.34.1777399711656; Tue, 28 Apr 2026
 11:08:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260424173151.371134-1-harsimransingh.tungal@arm.com>
 <20260424173151.371134-11-harsimransingh.tungal@arm.com>
In-Reply-To: <20260424173151.371134-11-harsimransingh.tungal@arm.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 28 Apr 2026 12:08:18 -0600
X-Gm-Features: AVHnY4ILs_FLW6y5A_Mt3MSjr1uXEFSjTscpZqOta7n4PgkYey8gA8DNq-jOqNc
Message-ID: <CAFLszTjvRPPY4Cb3X7CmKDwZNke6=mZGnFJ-H0+j1Ex5pXVCyw@mail.gmail.com>
Subject: Re: [PATCH 10/12] doc: arm64: document FF-A runtime path for EFI
 variables
To: harsimransingh.tungal@arm.com
Cc: u-boot@lists.denx.de, Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, 
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hugues Kamba Mpiana <hugues.kambampiana@arm.com>, 
 Simon Glass <sjg@chromium.org>
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

Hi Harsimran,

On 2026-04-24T17:31:50, Harsimran Singh Tungal
<harsimransingh.tungal@arm.com> wrote:
> doc: arm64: document FF-A runtime path for EFI variables
>
> Document how EFI runtime variables use FF-A MM communication
>
> Describe the FF-A runtime layer on arm64 and how EFI variable
> runtime services use the FF-A transport and shared MM buffer.
> Also clarify armffa command scope and link to the FF-A doc.
>
> Signed-off-by: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
>
> doc/arch/arm64.ffa.rst   | 92 +++++++++++++++++++++++++++++++++++++++++++=
+----
>  doc/usage/cmd/armffa.rst | 11 ++++++
>  2 files changed, 96 insertions(+), 7 deletions(-)

> diff --git a/doc/arch/arm64.ffa.rst b/doc/arch/arm64.ffa.rst
> @@ -15,10 +15,10 @@ application in S-EL0, or a Trusted OS in S-EL1.
> +U-Boot's FF-A bus support exposes an optional transport that EFI runtime
> +services can use to communicate with Secure Partitions. Through this
> +interface, EFI services (such as variable access) can request or exchang=
e
> +data with the Secure World using FF-A.

The rest of this file uses lower-case 'Secure world' (see lines 12 and
16). Please keep the capitalisation consistent throughout the new
prose =E2=80=94 also at the 'Secure World' in the runtime section below.

> diff --git a/doc/arch/arm64.ffa.rst b/doc/arch/arm64.ffa.rst
> @@ -158,6 +164,77 @@ they want to use (32-bit vs 64-bit). Selecting the p=
rotocol means using
> +- The communication buffer is located at CONFIG_FFA_SHARED_MM_BUF_ADDR a=
nd
> +  sized by CONFIG_FFA_SHARED_MM_BUF_SIZE.
> +- CONFIG_FFA_SHARED_MM_BUF_OFFSET is sent in the FF-A direct message pay=
load
> +  to indicate where the data begins.
> +- The buffer is filled by memcpy(), the cache is flushed before notifyin=
g the
> +  MM SP, and later the buffer is reused directly with only the shared-bu=
ffer
> +  range invalidated (invalidate_dcache_range()) to avoid whole-cache
> +  invalidation.

This level of cache-maintenance detail is an implementation note and
will go stale the moment the code is touched (and patch 12 is already
touching it in this very series). I'd drop the third bullet and let
the source comments have that, or move it under a clearly marked
'Implementation notes' sub-heading so readers know it is informative
rather than contractual.

> diff --git a/doc/arch/arm64.ffa.rst b/doc/arch/arm64.ffa.rst
> @@ -158,6 +164,77 @@ they want to use (32-bit vs 64-bit). Selecting the p=
rotocol means using
> +- get_comm_buf() switches to the static shared buffer
> +- mm_communicate_runtime() selects FF-A transport when the runtime conte=
xt
> +  is enabled
> +- ffa_mm_communicate_runtime() issues FFA_MSG_SEND_DIRECT_{REQ,RESP} thr=
ough
> +  ffa_sync_send_receive_runtime()

Naming specific static helpers in a public document ties the doc to
current internal names. If one is renamed or refactored later, the doc
silently lies. Please describe the flow at one level higher (e.g. 'the
runtime path uses a static shared buffer and dispatches direct FF-A
messages') and leave the function names to the source.

>
>     doc: arm64: document FF-A runtime path for EFI variables
>
>     Document how EFI runtime variables use FF-A MM communication
>
>     Describe the FF-A runtime layer on arm64 and how EFI variable
>     runtime services use the FF-A transport and shared MM buffer.
>     Also clarify armffa command scope and link to the FF-A doc.

The single-line paragraph just restates the subject and the next
paragraph. U-Boot convention is to open with the motivation/problem -
please replace this with a sentence explaining why the doc was
previously incomplete (the previous text said runtime support was a
future development) and what readers gain from the new sections.

Regards,
Simon
