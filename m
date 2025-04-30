Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 567E4C369D9
	for <u-boot@archiver.kernel.org>; Wed, 30 Apr 2025 13:55:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 219EB8070C;
	Wed, 30 Apr 2025 15:55:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RycSjeK4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4ECEC82153; Wed, 30 Apr 2025 15:55:02 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40C9582B7C
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 15:54:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-ac3fcf5ab0dso1192350066b.3
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 06:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746021299; x=1746626099; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nssdr6GPHiD7MyeEDOIlEzoyTko/P09KQ5kEfArOzXg=;
 b=RycSjeK4M3QdsvyJovpLCVKFD9Vu1QHaCMSBNnaRrFSxO4BDEHwcT7+nVkKlCTAfqI
 JegTf0BhS2jflGxiuO7+7voQInQ+7WhXrPaiO1khIpLn82IWvlSwnNQ/fCabBA5wqL6v
 POq5JYCT4SF7aCoH1V7aMlVSj0KihXaR9ZdPM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746021299; x=1746626099;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nssdr6GPHiD7MyeEDOIlEzoyTko/P09KQ5kEfArOzXg=;
 b=XXchwV3ObOtN/OhEsB0zAw0byDZIhqp8rZzJK/f8J4YcQbCMdQWgTJtaRjY0Jta9NG
 q/GUlmBP5ZhsxCeL9fAZcWbZ7q71kjruRdhJ+YZZB7gr4VX46e7Hp8yvG6K21CafFY+F
 642wYufOl6xhEqnIMgvm9JB64PukJW5cCjTeciEOL4ajIoRVSXTYEH9ceXenSb/kY3rB
 dGF70aQlOIcaupfSLVYH3owXgDphnXifsVEZCuMQmsEjqjr94v5PS4zEuA+kpm2Vp2k0
 CXIbyXpDeGd3T4TEq+DCde4Fb7nwTP7E8kO0Jm3CYTw+8u7J+8Npoo7bJl+A/OAogpbl
 VvPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUr5YeTfMKb61xTROLKnhAV2ZOOydKzs4rS1L4CqP55s+RwU3v0Fv/BKymtlpFraqf79illnUA=@lists.denx.de
X-Gm-Message-State: AOJu0YwarfkMqPVN8vH4MYjKW8BGLoxrssMpsJ9waZhu2pMdfoE5/nCD
 QnNVrMnGtBClvSvkz5Nv14227yS5+pXXiYq3DurLMlE3I3PW8C/WAN6VQpAk5HWVU0vTt6iN4s8
 KA5GjBsCRReDLTk1p9ckdiB/5sTqHZ2mQfFVG
X-Gm-Gg: ASbGncsa3Fsjrn7tXlahWEPXOPR4lOs2r8xb0XGQlx1zDnShoNxjM5vfl0fySEgpd2Y
 SkNYD7FdNEtowyoRFXZP0QgujwWYEUsZ3SUEXudKJIdRhQKQRCgoI/Vn/GSdPe+qreEHlq64ouo
 iRfsArfb9zD8jZNKO6uWNsmS5bsOswO72MAg==
X-Google-Smtp-Source: AGHT+IEB2Tnb7aEtOo4nOsfzZBz87XCz4t4s64YtPrZxhpIvWHomrPi1IY/8eGlCPCYAf/mOvgEpnYbgcgXmv4s72ss=
X-Received: by 2002:a17:907:3e8c:b0:aca:a3da:80b8 with SMTP id
 a640c23a62f3a-acedc7763a4mr353274266b.55.1746021298601; Wed, 30 Apr 2025
 06:54:58 -0700 (PDT)
MIME-Version: 1.0
References: <20250404135038.2134570-1-jerome.forissier@linaro.org>
 <18d1c97d9a420c40181352bf1445e2772d784d9a.camel@codethink.co.uk>
In-Reply-To: <18d1c97d9a420c40181352bf1445e2772d784d9a.camel@codethink.co.uk>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 30 Apr 2025 07:54:46 -0600
X-Gm-Features: ATxdqUEnZf-D5_cwcxCZZrbFqU3z5YZ1fHXv_wtDursaVliEJhXGbjeA-nkafw0
Message-ID: <CAFLszTjjsdp7xijT1SVq9P3mou9vvGWmK5_ngb1Y6Ap4A99QSQ@mail.gmail.com>
Subject: Re: [REGRESSION] [PATCH v6 0/3] Static initcalls
To: Marcel Ziswiler <marcel.ziswiler@codethink.co.uk>
Cc: Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Stefan Roese <sr@denx.de>, Andre Przywara <andre.przywara@arm.com>,
 Peter Hoyes <Peter.Hoyes@arm.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Caleb Connolly <caleb.connolly@linaro.org>
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

Hi Tom,

On Tue, 29 Apr 2025 at 16:32, Marcel Ziswiler
<marcel.ziswiler@codethink.co.uk> wrote:
>
> Hi Jerome
>
> On Fri, 2025-04-04 at 15:50 +0200, Jerome Forissier wrote:
> > This series replaces the dynamic initcalls (with function pointers) with
> > static calls, and gets rid of initcall_run_list(), init_sequence_f,
> > init_sequence_f_r and init_sequence_r. This makes the code simpler and the
> > binary slighlty smaller: -2281 bytes/-0.21 % with LTO enabled and -510
> > bytes/-0.05 % with LTO disabled (xilinx_zynqmp_kria_defconfig).
> >
> > Execution time doesn't seem to change noticeably. There is no impact on
> > the SPL.
> >
> > The inline assembly fixes, although they look unrelated, are triggered
> > on some platforms with LTO enabled. For example: kirkwood_defconfig.
> >
> > CI: https://source.denx.de/u-boot/custodians/u-boot-net/-/pipelines/25514
>
> This series seems to cause a regression on rock5b. E.g. on today's master:
>
> => pci enum
> => setenv ipaddr 192.168.10.2
> => ping 192.168.10.1
> failed to initialize card: -12
> failed to initialize card: -12
> failed to initialize card: -12
> failed to initialize card: -12
> failed to initialize card: -12
> failed to initialize card: -12
> failed to initialize card: -12
> failed to initialize card: -12
> No ethernet found.
> failed to initialize card: -12
> failed to initialize card: -12
> ping failed; host 192.168.10.1 is not alive
>
> Seems the rtl8169 driver runs out of memory trying to allocate descriptors?
>
> If I revert this series on top of today's master:
>
> => pci enum
> => setenv ipaddr 192.168.10.2
> => ping 192.168.10.1
>
> Warning: eth_rtl8169 MAC addresses don't match:
> Address in DT is                00:e0:4c:68:01:5a
> Address in environment is       fe:b1:db:60:25:69
> Using eth_rtl8169 device
> host 192.168.10.1 is alive
>
> I just completed the bisection and will now look into what exactly could be going on.
>
> Any insights are much appreciated.
>
> Thanks!

I have one of these boards in my lab. Could you please apply the
pending lab patches, e.g. [1]? Also, can we get this board running
network tests?

Regards,
Simon

[1] https://patchwork.ozlabs.org/project/uboot/patch/20241218211020.742702-1-sjg@chromium.org/
