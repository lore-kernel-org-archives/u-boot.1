Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0976FCD98F6
	for <u-boot@archiver.kernel.org>; Thu, 18 Jun 2026 15:12:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98891849CA;
	Thu, 18 Jun 2026 17:12:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="M35WPtY6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68F7A8460E; Thu, 18 Jun 2026 17:12:40 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7ABE18460E
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 17:12:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-695f5ae95e1so1167814a12.2
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 08:12:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781795558; cv=none;
 d=google.com; s=arc-20240605;
 b=XObDDW7LB1GKcchpS0augqvvrI9jhg9g5VME8If+QWQZAB4OaNH9hFEw5CUYAPGClJ
 EZa+7UYVUX8aKiXK4ZJL519FGuQzZOj13zZY23Kpn7A3ndb3CadrZOm/mppzFv3LjUKH
 QyegINLCOF80x5FEWuntgjwNuwaW4U/VXO95eF03WhyBOm1gRRZqLtYX8QCKTJppd+qu
 rh1mka7PvPx+AJazk0Q7HbnbXQ3DdU4OpDfujm/4N0kWk+nGddKHdBzxjGTmH6parx4t
 bq3tF//vuMvwsTwboV61KaTuyEQ6AW9b4EROaBRj1B/QIFUp+1+Ikew96sqVHX9GFe9l
 x6PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=dRfcWvD+dF7fmbXJ6V5OnkJFE4hn0gp5umQFd8sEYWk=;
 fh=pqQDfe3LJMDmm+c9NDum1Jzf1ll4C62eeHhIID4fPOY=;
 b=W/ON+OfOPNg3P190J0Uc+AOP9/QirP7gt7GFMN7IFDKds2+LxVHQZnklVza9R/VHie
 yqYzRZku674rbdpUA3Z5ykCcLuXO5x/ICUJmWzKkJ8avEBWCm0orIeUt9lW5rx033FIp
 d/Kt1pBEWMH3wySRqOLR/OfJbj0izVcjhGNdj7qy5VTA0EBpFizR0px3pszwV4z7FNht
 reLL0kO5P9+Ba/71P7wwjqpXhLi27rjVIS+yM6tbdReQK0bJ/goUTnT9JmZz7d63r7NJ
 C+dTz4F3gyI78KAJLC8R+KcY5Sz7zOKCZhS6wsuaCzUaWZwv8skKt5MYiBVZjaIMbE7z
 3KQg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1781795558; x=1782400358; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dRfcWvD+dF7fmbXJ6V5OnkJFE4hn0gp5umQFd8sEYWk=;
 b=M35WPtY63P1BK7VX1rpeRlqv6fQmzeH4cz+9qGPLxSbomDrg/qllBtVK+NAWxyS5Gt
 m7vdTtkMF3Wwnoge4KNHba2wGKO2MFq0W/I8DxfnB0M+dAgdCHVH9CKGCXoLuj2H2z83
 nJfCYH1hZBb21ZlAVSobkf91m4/05LjWAn9yw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781795558; x=1782400358;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dRfcWvD+dF7fmbXJ6V5OnkJFE4hn0gp5umQFd8sEYWk=;
 b=jgUW5hobPhsJNNucJmuRP0yfYGc+VVpCVw/TAJ1IxlmgkiM13aIlrH0uROCtNXzadw
 vrzHDoKXscobXI5GYJDHuDOhZ4RI3oefh+rtlAzg7AuDw6LNW7VidCybmPvLMbAyclqL
 wEdT1jdRFSPl8TQTH+GOtSkMxPRaULh49q92nLr40H47lWEIvSSq/R4RjTXKJSQSW7eC
 hkXJRxznp8OwLf02+VZLEEytM/lhWKGI7ersR5YgpLez2KUBvdSvHyVgNkvpJYNo2WtG
 6H31X0UVKRM7AURY76I0ciDIWBOP5Ki8HmugPMQMoIdJpfuFlmzQCZ/xtYnFZDbJ6M+x
 s4QQ==
X-Gm-Message-State: AOJu0YyTyxIdaeRGVUjvSXJc5JlYokxMe8CxvV1PIaVFk92QUNWr35EY
 vKeu08Qya91USA9Y5lpzMR7JS9WHPhxykEct6kinmtOo2b+VBD0EQb/1NAqqCwQ0UO+Oz6BJYSg
 TJD774EomtDWf1mK3ff8hqRG6GovSHrQxoV4uxqLN
X-Gm-Gg: AfdE7cnQY2AoONTbege//+imkor7rKXSTY2NRFqubf7tfmLPNP+fw8l2Dq9W5U1DITa
 pqbibF1cH+XmdqTD1WeoW3Q1USrQl4DxdYiO6sYnntcaquyJL5VYfPzJ1LUtA6d70TdIij1oiqm
 aXEQhfNH2Xu/eqHfcy43n/o7ph5OPDEC6CUKZ7hhlreIlvVUch3BLEGpgExEjdT9rWPW60KOYu6
 eie3jMtuGRCM27SlAhg+Osce4O0P4QahxE/z2Oj6p/Ji9yaJr5hp5k/guc0FqbyKj5ODpNMmw==
X-Received: by 2002:a05:6402:28c4:b0:695:a13c:ebd4 with SMTP id
 4fb4d7f45d1cf-695a13cf5bfmr3364303a12.9.1781795557906; Thu, 18 Jun 2026
 08:12:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260604-bls-v1-0-4ce6d1ee4711@flipper.net>
 <20260604-bls-v1-3-4ce6d1ee4711@flipper.net>
In-Reply-To: <20260604-bls-v1-3-4ce6d1ee4711@flipper.net>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 18 Jun 2026 16:12:25 +0100
X-Gm-Features: AVVi8CfvvhVeILc9HLmijGTb8r8uukzGdE7bisDkAulxtHq7JX4iKQ8YL3sWYM4
Message-ID: <CAFLszTjK8sYQwzEuKghSq47ktssMVSEnD6Gifsfe3BUNkV4zLg@mail.gmail.com>
Subject: Re: [PATCH 3/7] pxe_utils: extract per-entry key parsing into
 parse_label_keys()
To: alchark@flipper.net
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Simon Glass <sjg@chromium.org>, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Anshul Dalal <anshuld@ti.com>,
 Peng Fan <peng.fan@nxp.com>, 
 Martin Schwan <m.schwan@phytec.de>, Daniel Golle <daniel@makrotopia.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
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

Hi Alexey,

On 2026-06-04T15:31:05, Alexey Charkov <alchark@flipper.net> wrote:
> pxe_utils: extract per-entry key parsing into parse_label_keys()
>
> Split the body of parse_label() into a standalone parse_label_keys()
> helper that walks key/value lines and populates a pre-existing
> struct pxe_label. parse_label() becomes a thin wrapper that creates
> the label, reads its name, attaches it to the menu, and delegates.
>
> This is a pure refactor: the new helper contains the original loop
> verbatim, with the local variable declarations moved to its scope.
> No call sites or behaviour change.
>
> A subsequent change will export this helper so callers parsing
> formats that lack a 'label' header (notably Boot Loader Specification
> type #2 entries) can populate a label directly from a file body
> without duplicating the parser.
>
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
>
> boot/pxe_utils.c | 58 ++++++++++++++++++++++++++++++++++++--------------------
>  1 file changed, 37 insertions(+), 21 deletions(-)

> diff --git a/boot/pxe_utils.c b/boot/pxe_utils.c
> A subsequent change will export this helper so callers parsing
> formats that lack a 'label' header (notably Boot Loader Specification
> type #2 entries) can populate a label directly from a file body
> without duplicating the parser.

This should be type #1, not type #2, right? The cover letter and patch
7 both make clear that BLS type #2 are EFI binaries (out of scope),
and the new bootmeth parses BLS type #1 .conf entry files.

> diff --git a/boot/pxe_utils.c b/boot/pxe_utils.c
> @@ -1288,34 +1288,20 @@ static int parse_label_kernel(char **c, struct pxe_label *label)
> +static int parse_label_keys(char **c, struct pxe_menu *cfg,
> +                         struct pxe_label *label)

Please can you add a kernel-doc style comment, since patch 4 promotes
this to a public symbol. The file uses /** ... */ for the exported
helpers added in patch 2.

Regards,
Simon
