Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51411C47DA9
	for <u-boot@archiver.kernel.org>; Mon, 29 Jan 2024 11:54:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 993B687C3B;
	Mon, 29 Jan 2024 12:54:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="h6lYIYNK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DFE98785A; Mon, 29 Jan 2024 12:54:27 +0100 (CET)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07BBC877DA
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 12:54:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jagan@amarulasolutions.com
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-6002a655d77so22096797b3.2
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 03:54:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1706529263; x=1707134063;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h/q4Mc2ugLmK9eOwfhCBzDblByF8HYAGsiWkaJ/6CPI=;
 b=h6lYIYNKMoa805Gnkf76/Awmi3ZEH1xHECYf9jYV0NiZMeXQ2kFumTK9nJDzU6P6Cx
 aXLaWJfBPUGQOjzt0NpdamRY4OoRVgmC0thE7yQagguJ3vBXvEQgh48wrupG6CnDIFk1
 VTxmSSTO+DslRwtME34DWoKPz2Igmbnxx5p88=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706529263; x=1707134063;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h/q4Mc2ugLmK9eOwfhCBzDblByF8HYAGsiWkaJ/6CPI=;
 b=Hv6JxT44uo8FCPG6a1DBrLAIb2V2r+U550uVV5gGPZJyBqe1WiEfmIFPrVjOfYL6Zf
 qvMG5QHUM5QUi4XX0SNgkPcU2KfMjxH4h38K+greyOX8K0Pobvg17O2WiTZqduOQKhKJ
 XMqNTQ4M/JCt9t1pobzxWdGWSeDFlKtP+i9pe3fQ+W+7uwa/3+r+lVomOcYgPp1pD0x0
 Fov7oKOWMDHR7+RArNUxQ71qynFkrlg+pkUOVMdROCo8KdRi0x3IqhXJphokcrrb35DU
 61VRlNjMpdI2evvCeemRSc1RCrx+8xWLZvXf2qGji/2k7hA5TY6e73Q/ao0cgnDIqtKh
 I82w==
X-Gm-Message-State: AOJu0Yw1yfkLPZ5UZOVrJl2DEXEBbCodAgb9FDvp+xcQp1XoBKiT0uHd
 2NkfBkpVtqPBEF48vUawyPxJVsntji6ukNikf1Luz2pHAsmDDJ4Dh+xm2S8Hk/Wa3bn8DHbNQsp
 /fUkSPQh5wPp15GoYhuYe2HnQKLP1e8RhRrZ6VA==
X-Google-Smtp-Source: AGHT+IEGJdUmDbeLL8ENFpoXHfYUSnWV7MWoarlb/3tVo/Dl2ePR5EI1Y6ea/91rWX/3x5Nhd08wyDFA+9h3jMl7NM0=
X-Received: by 2002:a0d:dd4d:0:b0:5ff:9eaf:be5d with SMTP id
 g74-20020a0ddd4d000000b005ff9eafbe5dmr3164460ywe.81.1706529263756; Mon, 29
 Jan 2024 03:54:23 -0800 (PST)
MIME-Version: 1.0
References: <20231227162839.858860-1-tejas.arvind.bhumkar@amd.com>
In-Reply-To: <20231227162839.858860-1-tejas.arvind.bhumkar@amd.com>
From: Jagan Teki <jagan@amarulasolutions.com>
Date: Mon, 29 Jan 2024 17:24:12 +0530
Message-ID: <CAMty3ZDUXGLuzpyuohAirMmrLYPUJzpVFmaWZSuUNtJHceGwEA@mail.gmail.com>
Subject: Re: [PATCH] mtd: spi-nor: ids: Add is25lx512 chip
To: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
Cc: u-boot@lists.denx.de, vigneshr@ti.com, michal.simek@amd.com, 
 git@xilinx.com
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

On Wed, Dec 27, 2023 at 9:58=E2=80=AFPM Tejas Bhumkar
<tejas.arvind.bhumkar@amd.com> wrote:
>
> Added support for the ISSI OSPI flash part IS25LX512M.
> Initial testing was performed on the Tenzing-se1 board using
> SDR mode, covering basic erase, write, and readback operations.
>
> Signed-off-by: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
> ---

Applied to u-boot-spi/master
