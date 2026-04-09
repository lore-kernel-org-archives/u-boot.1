Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07B98F364A6
	for <u-boot@archiver.kernel.org>; Thu,  9 Apr 2026 18:12:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D7EE84106;
	Thu,  9 Apr 2026 20:12:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Kr5QgPeo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E2E0284142; Thu,  9 Apr 2026 17:45:30 +0200 (CEST)
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com
 [IPv6:2607:f8b0:4864:20::834])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D64C083CF5
 for <u-boot@lists.denx.de>; Thu,  9 Apr 2026 17:45:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alchark@gmail.com
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-50697d6a69cso5633731cf.2
 for <u-boot@lists.denx.de>; Thu, 09 Apr 2026 08:45:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775749528; cv=none;
 d=google.com; s=arc-20240605;
 b=WZ56nGcs6HJ8khfRZAx1nQAU8lZGYGh5xaYZNCrTzGO2fr7qydocvOGF3hAGmR4RN+
 zAR+Xsgb4t+Bog33ewSeO69XoTPTq2dxE6JlL8Ab404WdNf56RTpJlV/b5iHBb5oEVuo
 y+ReUSO8t+1wj9o6LwnWKvWo1MQ7Fe3oruqWapSXVzIQNYfIBAsgvmCgR2PSveMaw26D
 PZIRC0+jyKsS8CVA6EQH28ujAS7jseudCD6NKf+Is8RJvJuCj/7wm9O5ioMEq0DmZ6oA
 JeiP0VGT2pGdlCK+/9tOAINJ0AdWYmhyCh0O1KmRgPV7CbtxQK8zuME8bgEacnLSlVQF
 /i/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=fWp66h9OOKmovvLQ52D4bmGRD7AWjHWnsSJEKUjTPaE=;
 fh=uOhV1t+0iFcV5eYFRMCyQ4vbcPD89Ro005zURaNYH3A=;
 b=RNTrLIMlH9kC0NcquIhHsFkfNpfANsFHxeAZU3oaEwkAkW+yl6A17d+35LBZ4HijnO
 RF3YrH/+3Opj/Uo9k9GFNw3U18y9vMByzVFX7n6vTL9TAp/iiGpyBjAtQl6uwZde3wQA
 qlVjsNusQTfwif42ZEcXt3+uqVhuQqXPX5clZI6NQygjdgfJvW4wNqekZKVNYxQzSd7V
 v/nLWmmuGqYXDa++HnJIcgYbirINzODhnS+FEeobdJT/ZCQWpfUa1o3ocVP16feCMISp
 4ZiuXBjdYxILjwzGdbHnDUqDkFhRoQfYvx51UElAGyle6XuFB33cv+h7G0gtkxjGwDtD
 1yaQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775749528; x=1776354328; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fWp66h9OOKmovvLQ52D4bmGRD7AWjHWnsSJEKUjTPaE=;
 b=Kr5QgPeohFfrwx7vD6KBVxlC0Q8GywYUWNu0XnhOgGMCBgq4YIjIUz0F0vG1f0jsM7
 CSRbFZ8ve2MRkmDwSduFnkrj2jsqpoX+r09tXqlHiWnewa3nM1JnAzo77rv+6badKnBv
 f3u86oHchDzIIIaj7cfiEdYY9Fy6r3IvUx1nS4qAGLZbsrjXLp78fXFUOadp1BAWYNjQ
 HXHXKC8fDZqh/SnJPAnixFKLzORzHYCrLr3v7NwEdDy2Yo5H9TWs38u3mKfXutPlr5xj
 X+/odH14fKPpkxHsTWw5vLwWjBQurQKq3tFVrHRM0bGiFHwEl8ltD0/UB/TQ5Opkb736
 VpUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775749528; x=1776354328;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fWp66h9OOKmovvLQ52D4bmGRD7AWjHWnsSJEKUjTPaE=;
 b=jqSBEpQXAwWdN5jYYS2w4vY801FetgPMBHCSMagF7qodLuvDiuOi296dbILZn39PJE
 42UvfZWIbc3RLRbL9SaSec+EA6jOTtaTl6/armJ5vu7Fgf7tLeUUGuQMPNnJt+Co7wE1
 sarF8/MvB7XYpGGQhDIaQNSgZllPjK/xlW+UTnaR9/aSqbONiMn5P55ZipmUN4rJqCUk
 HgtATEtjU5sh+rnRZ5w6582xx3dEI8oU84lUt/vqnViyQ3R9SDdSgF80TKGcm1POk3ma
 y+GEJlQVDlujjbYuK2/IfKG9sHzsxsFXn0AkDAfSEbmyfEgRYmUrmK1rVb3Y5YktcQcp
 WNVA==
X-Gm-Message-State: AOJu0YxU5Oc5N+0gzoZ2Yzd8rk66JXHBkq2jjMd9cv6JV7eYRvHhbXv1
 qCeMFVOHYXRwgqk+SDufzX3XXDvQpcRZpHGJZ4PqOEyI2+ZuWmUzOm8hl+ADadqtehZ4McurZlZ
 Ik0zbXCVwGlyH9I1TUpyx850mkyO2DCE=
X-Gm-Gg: AeBDies76VNk3KJJedGsrJbFG3SRr/Yx4Acl25vYBL9YdJ2lYcvnJku1KQnC3x8Ubir
 Hm4XzWG9K0zWPCQ2Z+eSyfwZzt/Wm+Q6o3snpTZLWrPp+T3FvrmQs4r7T9UHKyRZ+TNdR+WxcsZ
 0PRfh/wJYPhfDF2+bYbxBFftUK00x6m1QcMrgf0b8uoPMB81ofFu5xl0Q/CLnNNra+GkVKjZg2Q
 lcYYJNpK0r2HgaCBMtxPz8rCkvKQhf4FayaO0KNUJDJqdRL7dxMKwek7tANUfE5eJ1Vd9dHFILx
 OHQ5hkE=
X-Received: by 2002:ac8:7d11:0:b0:50d:65ec:a071 with SMTP id
 d75a77b69052e-50d65eca37cmr368713971cf.5.1775749527548; Thu, 09 Apr 2026
 08:45:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260409-spl_ufs_only-v1-0-f7e0e243d805@oss.qualcomm.com>
 <20260409-spl_ufs_only-v1-4-f7e0e243d805@oss.qualcomm.com>
In-Reply-To: <20260409-spl_ufs_only-v1-4-f7e0e243d805@oss.qualcomm.com>
From: Alexey Charkov <alchark@gmail.com>
Date: Thu, 9 Apr 2026 19:45:16 +0400
X-Gm-Features: AQROBzBv39BwrX42ujKUFQZMDLHGq_0XHoqdMypIZnAGhyMxmByWPVsoZFnEtBA
Message-ID: <CABjd4Yy4HqEk2m=HDX1_qy9fWDjUmWVyebcFDxMDfVTe=CMobQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] clk: stub: Add Kconfig option for SPL stub driver
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io, 
 Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, 
 Anshul Dalal <anshuld@ti.com>, Peng Fan <peng.fan@nxp.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Hrushikesh Salunke <h-salunke@ti.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Andre Przywara <andre.przywara@arm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Javier Martinez Canillas <javierm@redhat.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, 
 Javier Tia <javier.tia@linaro.org>, Rasmus Villemoes <ravi@prevas.dk>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 =?UTF-8?Q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>, 
 Dhruva Gole <d-gole@ti.com>, Richard Genoud <richard.genoud@bootlin.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Simon Glass <sjg@chromium.org>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Shawn Lin <shawn.lin@rock-chips.com>, Tuyen Dang <tuyen.dang.xa@renesas.com>, 
 Casey Connolly <casey.connolly@linaro.org>, Lukasz Majewski <lukma@denx.de>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Michal Simek <michal.simek@amd.com>, 
 Yao Zi <me@ziyao.cc>, Peter Korsgaard <peter@korsgaard.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 09 Apr 2026 20:12:16 +0200
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

On Thu, Apr 9, 2026 at 6:44=E2=80=AFPM Balaji Selvanathan
<balaji.selvanathan@oss.qualcomm.com> wrote:
>
> Add SPL_CLK_STUB configuration option to enable the stub clock
> driver in U-Boot SPL builds.

Perhaps mention that the respective Makefile already had
obj-$(CONFIG_$(PHASE_)CLK_STUB) in it and only the Kconfig option was
missing. Otherwise it raises questions why a newly introduced Kconfig
option doesn't propagate anywhere else in the codebase.

Best regards,
Alexey
