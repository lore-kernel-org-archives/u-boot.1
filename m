Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76A0ECD11DD
	for <u-boot@archiver.kernel.org>; Fri, 22 Mar 2024 19:33:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B244C88178;
	Fri, 22 Mar 2024 20:33:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MBpBzWF2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D844287CAC; Fri, 22 Mar 2024 20:33:19 +0100 (CET)
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com
 [IPv6:2607:f8b0:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 762DD88178
 for <u-boot@lists.denx.de>; Fri, 22 Mar 2024 20:33:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-55b5a37acb6so434881a12.0
 for <u-boot@lists.denx.de>; Fri, 22 Mar 2024 12:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711135996; x=1711740796; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qi3Uh4WYj/QZyZFvc6TKgU+p30epeNSasXziXl/mshc=;
 b=MBpBzWF2Pdp67SIrXcQio2YcQyxKPqjspgmXdFRsQOtTKwz1e62JKFTJIHKT9mNWLT
 Cusp/lmCjjqBdXLibi5Sf78INMUl5Disx4uXGJXnekRx651qExhCLVL6hlM8+RhFO9SN
 GZnfrdKr9vfI+Bj0ODZi2TIFlBgwPjNu1mnpghCPrjmzcfs6jLBOxKM/TfIdQTHT4Gjb
 5V99iWeP8LAHBjdqMYxdRrhTyxgCGpE65DDwp80BoXIDwEj2mQoJl49ZC3q+KF22g3qJ
 gy6ffrbeNfRXhQe12zJiBs/AhG+Vsh9FDQ6TvkqXal/6aFZs0ZpYMAJZ9xv2MZe+nV5k
 SZtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711135996; x=1711740796;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qi3Uh4WYj/QZyZFvc6TKgU+p30epeNSasXziXl/mshc=;
 b=jtaychRMIU8Lfa7VSQ12ev2RqRH2NBuGlRCzSrB5dK0hyJfGPcLtKuRhjVZVYbwSkx
 ZADE8kcrKiTGURcg9j3I8kkbX28ypmui+p+uXyWpwQeQh+tmwW0oBYEFrGhwNGKtkPJ5
 zZiI/DGYfOFO9dTNXMuvJIrfdwVsjM3Yt5/VR5IIfNvDbBHMRiITuLh6Ww+U30WhwGjU
 zVwTbWTbPfS94yntnGop6ndnl5iKSuxTrVANMyoD2GHKQusXjv9vVfVLAiWZbd2EYDt6
 UNv1JZx7eldlWVzto/U5V9POSLJ1ZbXc1428khRyTFNQjolj/1qeH3Okt+jZ3ska99E1
 OK9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUKqjBti6dco6YHAMeFr95e3H3HKQ9wgHjoLhva0uEksb+2bBgtmtKmF8g2g81GPaCNT6JdRrUBFVUTenJ9/o+w9e/Wdw==
X-Gm-Message-State: AOJu0YwC26aMcTaVqd5PBpi4bzDkQBmdTXitZzPBn6sx6eGZXetHofdk
 ZKt6Vbwyk54JFaRu2g8LZ7j+xsDGS1WgSMxxbCXNSAZayLGoqRgnFESnztwdPfoyiZQVDsHCUfa
 rGwPNp5saT8z6Z8inuxNoGEXcDmA=
X-Google-Smtp-Source: AGHT+IGMN6/brz404GWDaG4Pw6Sc4msVoUUhRdGw/mvFUYezItbAq15o1d2UgbbvR4dPQwBwqqRjUqK64UOS1IDrpEw=
X-Received: by 2002:a17:90a:6285:b0:2a0:4197:4648 with SMTP id
 d5-20020a17090a628500b002a041974648mr642409pjj.0.1711135995918; Fri, 22 Mar
 2024 12:33:15 -0700 (PDT)
MIME-Version: 1.0
References: <43haokus4jdxguk4arig5tsqcgq2wbezwpbj7oti6pdkvrfual@wa7vz2iypcv5>
 <86o7bazheg.wl-maz@kernel.org>
 <qnca6it6fh6pznsvm33rwa3pf6ushtkpvyui6fds43fcdjxcz5@66tiqctl7arc>
 <CAOMZO5CNgJUbDGdyP4tS7YBXPqcmyT+FkhaF+phbR64grA2i0g@mail.gmail.com>
 <yltha7mziq43ke7kas433zlvxamri2p7h2p7oos3x4dexk2oct@gfhscvngsjcw>
 <CAOMZO5Cy9tu_kWDmZZjHa0PAH9+RjHrQKHMwqCPe7fFvj=W6wA@mail.gmail.com>
In-Reply-To: <CAOMZO5Cy9tu_kWDmZZjHa0PAH9+RjHrQKHMwqCPe7fFvj=W6wA@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 22 Mar 2024 16:33:03 -0300
Message-ID: <CAOMZO5B8fkS_MEry_8LnDmzLBJJ5N-03P7dZXFgnTVarcaZkcQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: Fix map_range() not splitting mapped blocks
To: =?UTF-8?Q?Pierre=2DCl=C3=A9ment_Tosi?= <ptosi@google.com>, 
 Tom Rini <trini@konsulko.com>
Cc: Marc Zyngier <maz@kernel.org>, u-boot@lists.denx.de,
 Stefano Babic <sbabic@denx.de>
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

On Fri, Mar 22, 2024 at 4:31=E2=80=AFPM Fabio Estevam <festevam@gmail.com> =
wrote:

> As Pierre's explanation addresses Marc's concern,
> do you think this can go to 2024.01 to fix the boot regression on imx8qxp=
/8qm?

I meant 2024.04, sorry.
