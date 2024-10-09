Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1A7FCF042F
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 01:59:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 18E9089141;
	Wed,  9 Oct 2024 03:57:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QWw3HjbZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 203D88913B; Wed,  9 Oct 2024 03:57:34 +0200 (CEST)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E90389148
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 03:57:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-6cb2aac40faso3266506d6.1
 for <u-boot@lists.denx.de>; Tue, 08 Oct 2024 18:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728439048; x=1729043848; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NNPZS3qeSE+1XE0Qe3KcTlsJLPX8S+uk6X0bbeGPdRU=;
 b=QWw3HjbZKzxfQEK/SwTxjLQtu9cVeDHITnds4UNH5yGxG/ynBydwneIcExZ945Vp/o
 yAXo054l/hfHUVmrTdwzFzillVqKrucM0APT5/4mmfPkbKW6TOcJ3qV7mJMaakQx/2X6
 8y1SvipfSIp7fsOZ29tRfoKXzLLKpX0R1z7gk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728439048; x=1729043848;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NNPZS3qeSE+1XE0Qe3KcTlsJLPX8S+uk6X0bbeGPdRU=;
 b=KOPxwKZ8zFtxkFYjv5nS0UF7+Fpj7YSITSPuMvDOPggV/4RAF2bKkLe8l/lnejK/YX
 6eA8G+1G3GxhloaX/r1Whp7DSVPSKimmCcGfO+HMKxOAF4tuFskbXTrKl7qFa/Q3mBFl
 JR3x8qpeQkeUoYnwm+/5mQ05u3cWnHjmFM19UFeGRHsXQcEMVI5B4qHuWUAd3t4v9WX8
 87+iEChhHcVguNGcuhHj1GJGeso2d0l5cA3r45txPX/ZXydmTRKvUO1LjGpP4swJm3JI
 tqScJK+iScD2IH8dDKeyaUf9eKhQ149kEmI8LNew9zuKMXXo3bwxonIrhsEmv3OvJkBM
 7xUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV62F3s1Ii5evrSQRU/4YQ2aJsi5UJZ6/aho9Ncg3reSYqmP+fJuixJecJiDV4R2eRz6ltumY8=@lists.denx.de
X-Gm-Message-State: AOJu0YxsRbjdxdE2/+oyhKQ7yeYnF4KmumVM7KkTgIFRKR6haJ0eU/Bk
 sH0NWPRdu41tSDP2EEXwimzHVpe+G12dGlvUvAIike/w+Eahut3nBc0wRR2EDq4yX/JjYNdEndg
 Yk85SGvQDGstpx8h2om/EAqrbtQVPCgoVZUYY
X-Google-Smtp-Source: AGHT+IHAGjKiMPvWyE2C6xhlitS9G6uT54VPI8FH8J7/zvVd+oSzKz4J2ul32GIDYkScdiF2KShcHni7D0nQ7RtSlLM=
X-Received: by 2002:a05:6214:2587:b0:6c3:6344:d4e1 with SMTP id
 6a1803df08f44-6cbba982f95mr73533656d6.20.1728439048024; Tue, 08 Oct 2024
 18:57:28 -0700 (PDT)
MIME-Version: 1.0
References: <20240930161006.41052-1-brian.ruley@gehealthcare.com>
 <20241001135810.96-1-brian.ruley@gehealthcare.com>
 <20241001135810.96-2-brian.ruley@gehealthcare.com>
In-Reply-To: <20241001135810.96-2-brian.ruley@gehealthcare.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 8 Oct 2024 19:57:17 -0600
Message-ID: <CAFLszTgppFmNC2NL+fcE9Zg530oA1Hs3VDpfUK3yOd0swp3UDg@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] binman: add fast authentication method for i.MX8M
 signing
To: Brian Ruley <brian.ruley@gehealthcare.com>
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>,
 ian.ray@gehealthcare.com, Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
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

On Tue, 1 Oct 2024 at 07:58, Brian Ruley <brian.ruley@gehealthcare.com> wrote:
>
> Using the PKI tree with SRKs as intermediate CA isn't necessary or even
> desirable in some situations (boot time, for example). Add the possibility
> to use the "fast authentication" method where the image and CSF are both
> signed using the SRK [1, p.63].
>
> [1] https://community.nxp.com/pwmxy87654/attachments/pwmxy87654/imx-processors/202591/1/CST_UG.pdf
>
> Signed-off-by: Brian Ruley <brian.ruley@gehealthcare.com>
> Cc: Marek Vasut <marex@denx.de>
> ---
> Changes for v2:
> - fixed default key length (s/2048/4096) for srk-crt node
> Changes for v3:
> - code formatting
> Changes for v4:
> - fix spelling in commit message
> - code formatting
>
>  tools/binman/etype/nxp_imx8mcst.py | 34 +++++++++++++++++++++++-------
>  1 file changed, 26 insertions(+), 8 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

(since I am seeing progress on testing, thank you)
