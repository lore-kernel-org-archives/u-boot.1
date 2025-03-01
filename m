Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5048CC021B8
	for <u-boot@archiver.kernel.org>; Sat,  1 Mar 2025 18:54:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90A1C81113;
	Sat,  1 Mar 2025 19:54:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OvY/t6qs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 449DC81115; Sat,  1 Mar 2025 19:54:51 +0100 (CET)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D761810F6
 for <u-boot@lists.denx.de>; Sat,  1 Mar 2025 19:54:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5e4ebc78da5so3305796a12.2
 for <u-boot@lists.denx.de>; Sat, 01 Mar 2025 10:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740855289; x=1741460089; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DD5PKsICAVu2AqKl8Y24w7jBJ4ABovdq6Q+FOBNy2fs=;
 b=OvY/t6qsW3CmeS27hSu91m1+dmFEiqS1LlV3vzv/15zXF0xTSOst6Y6wxTVlTNNs47
 dgEdqAipXF9N2q/4+DqAD7/Z/annLMg1ZenV8gJJnZk8dZf9laWFbjc/sF8yZGzV0en/
 l+/5ysyPEWnDPacr5Y8/18ypaRQCvo2RskjXF8Ws0Xye3H9nI4u47Hh8ynKRw+ua+qAa
 jFd5OG8tXrJQAuHuo6+JYqQyo9FPd1QHILrqNNDWinopgqKHk5SW7KszbZNGHCsRmY2P
 vYg50axAlj0hWJK3ovaP/dlM3g9K53+yOKM2G8A2gx///7c7w21idggIqaWhjAeSAv6g
 eibQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740855289; x=1741460089;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DD5PKsICAVu2AqKl8Y24w7jBJ4ABovdq6Q+FOBNy2fs=;
 b=LHwSl/G2kP3KqNDA/PxjQ9W01sSXAxDrJidJ8CnGrQgMwmVa/jYs/b3Nt+tNfp2/IU
 2l3XkCqxDMKIbw1u4Zd7RGA/BHFYorVmScoWRiBhDN3FOXSOqEkOE3x8JEdFRqoEJDN5
 Z122ZQd81EIrNl0yNysFyERakJfsLacfB4SbjjN6T13FHHppkcFyyyate23T6j91h7dw
 JFC76gNoQlToz/pmdy+QyfS2daO8k0HEI4Y9sRLsl66dALmZIcCn0v0172w6HN3lbGvg
 0K3ipIvbevcegj5wiWAZBNI3Ucjkm3DTZ6zlg23rUtfO9zcarDsZR9IPdGEPnKKPtIQO
 8xMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3RIXE7qGsq106DeYSMA5xsdNIKnSXXchfaWgQgXCLN2Fp0LTw1JfK8kfQ9GerHF/FEfnW/bA=@lists.denx.de
X-Gm-Message-State: AOJu0YylPypDbYTI/IV4uH/tk3gLsnmXeuwhOiA7Bn80k0YsH/a8/t1V
 vI29vRDTbuaRxNWRroSlFH5FNKV7nTouIzsgjZ11yjr5/xB4HynHj+k2z3wF7QQqibo4erGTEwq
 Dsj16UhWVAfc2rxeMdUiNmmw0eY0=
X-Gm-Gg: ASbGncskckvP3HzHVahxyVHiMLcpwD6iZzZ+9Iov0SwAVc3O2dYZViwK1gt5t8RfAy4
 Mvk/soavAHlsF+FJvHZe8K+pUAHMbGzEQWzvx53sBacxtcacB6srXzcmFvMxSkbiqj0xW4/bk6D
 +57+43DTEUXTMmvLSuk1B7RZ1RGEB3EnBYNA7+MjX+ST9RsC00OxqD2T8PFWk=
X-Google-Smtp-Source: AGHT+IGBwJ0KJZ0l0+42QLp/LsXjmbBNUUf5SnTAmGrZP1OGrWAsqCZPLSJDuF0MqtC339UyKboH1D6xPbMPtbbSi34=
X-Received: by 2002:a17:906:269a:b0:abf:49de:36de with SMTP id
 a640c23a62f3a-abf49de3e48mr434215466b.1.1740855288570; Sat, 01 Mar 2025
 10:54:48 -0800 (PST)
MIME-Version: 1.0
References: <20250130164758.GC1233568@bill-the-cat>
 <20250131100845.31380-1-atheiste@seznam.cz>
 <173955934703.3052361.10140738654072110732.b4-ty@konsulko.com>
 <CAOMZO5AvRCmZHtOTuw6faW6M0BPJxTsnQ6uu9xHQTX6ovGi-RQ@mail.gmail.com>
In-Reply-To: <CAOMZO5AvRCmZHtOTuw6faW6M0BPJxTsnQ6uu9xHQTX6ovGi-RQ@mail.gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Sat, 1 Mar 2025 18:54:37 +0000
X-Gm-Features: AQ5f1JoGX6Kwzy5v4Z1U082eLKK2NoLSZRKHZgUzFeUei1iNkpr2gREGPiqtC6c
Message-ID: <CALeDE9N_XsqOfVryKSu9bT2NBkGMb+-AvzzjMOLMgQerDLJp7g@mail.gmail.com>
Subject: Re: [PATCH] feat: Add CONFIG_BOOTCOUNT_ALTBOOTCMD to Kconfig
To: Fabio Estevam <festevam@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, 
 Tomas Peterka <atheiste@seznam.cz>, tomas@dronetag.cz
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

On Fri, 14 Feb 2025 at 20:06, Fabio Estevam <festevam@gmail.com> wrote:

> On Fri, Feb 14, 2025 at 3:55=E2=80=AFPM Tom Rini <trini@konsulko.com> wro=
te:
>
> > Applied to u-boot/next, thanks!
>
> The author's Signed-off-by tag is missing.
>

Maybe we need to add a CI check for sign-off's
