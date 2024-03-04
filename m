Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12EF4C48BF6
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 12:15:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 478A087F80;
	Mon,  4 Mar 2024 13:15:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gbVqcjpD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F4F387F85; Mon,  4 Mar 2024 13:15:27 +0100 (CET)
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com
 [IPv6:2607:f8b0:4864:20::e2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33DC6875FC
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 13:15:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe2c.google.com with SMTP id
 ada2fe7eead31-47268928105so874668137.1
 for <u-boot@lists.denx.de>; Mon, 04 Mar 2024 04:15:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709554524; x=1710159324; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q4UJgBGnVqksvbIU/rGaVo2cDKgMFnpLDn7/6SYqDpg=;
 b=gbVqcjpDPsRAWAK6kidar1CaJ81kDzoyWJ52M/YqVajaM+RHWsWRX5L7KnIU+6kEtJ
 CY6Pob9kLGcJE3UutFQzoqzlznSsxJZWPPgUSVYONwvYCU2OP8ENjELtZ/urqUxD7SVo
 n5UzO81srAAd/PlpJUyYFHlWF5XmoqwEEIt0fauTi5MwhezejhuK9kJtcaTkrKnjE3NJ
 T5GpsHyZfiDxHRkBCmQykXyYgA1VHSW9qjUmGJFXg0DuwcMWY6eAfZ9G1fXQyqArEJTU
 yvDKUHIhugwpImi9IbEhTuxFsh5mbf8NUyIf1e0HHL95GCi1rgCgysYeSCAxctYb7JR5
 ZM7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709554524; x=1710159324;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q4UJgBGnVqksvbIU/rGaVo2cDKgMFnpLDn7/6SYqDpg=;
 b=N2s1WQokZUoHx4LykdZkP0Z+G2J13GOJGCK9qB7Lajv4qUfjFZ8EGBGsRUBnU+yhz+
 2yvhFTJCHkey9usjOb9NlICyP+xJvEERzjFOnDwC+JVWgu+z+dPk/FcezaXdNYmivHiE
 KJJEJEdM9jD34PBBSyNQJGYOW972otFeox1lA2yhpJRFiWrIuMru/+D6bq1J73xlPcRi
 XgzJ6UrkicEFZgYw5atPkcLRYu+h+o7CY/w25WRAaEUnnII5j/Lj+4IXfO8fGGMdAV4h
 IWYtMWpcyzXAT+UBZRvvcGq81jOnwwQqOUgG1O7cel+h3ZaBTk7i5PisS+9eS6uFIeUv
 t53w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFVSo1K/XBPxrB4D2eZ4vr+Z+EZiLJaKFpU8XP7EhxJHkNHurTzxqSgYuDje2BEp3gTAkDvTFmfsEdPV2bHDyMgy9BsQ==
X-Gm-Message-State: AOJu0YxcOFxXJuMjOcFsQCjZHJHn0g7AKG92aCc/VFMKyrm1Cnx98qQz
 HxF25qodBP7VyAlD8VUsjZ1swqNOx4UWFJFZiT50Nd9KkMO8UTNnb5oeUey4q2ddO8vuoyjMyHl
 i/Du+nw1PkX7qosamt0xifrfG+99uexw4sLl0I09VmQWRZQR8Eas=
X-Google-Smtp-Source: AGHT+IHARc6GZUJGeufPEhOPczozIVuIiX5cSX8yDHwEZbW4cvzaHIrSnqZBtpXbwhEX/O78bVZqD2STE9IP9FlJMyc=
X-Received: by 2002:a67:fc88:0:b0:472:bfaa:2f5c with SMTP id
 x8-20020a67fc88000000b00472bfaa2f5cmr1830559vsp.9.1709554522786; Mon, 04 Mar
 2024 04:15:22 -0800 (PST)
MIME-Version: 1.0
References: <20240222093607.3085545-1-sumit.garg@linaro.org>
 <170929783825.70492.4756963077870833230.b4-ty@konsulko.com>
 <CAOMZO5CjeUhFfLBs3FRt4Hbk0ULXrRoOZaZqvSRzWbNySdsOhQ@mail.gmail.com>
 <CAFA6WYMf7Z-sW8pSHzYUJ_O9fqfunBEhyigJj3BW-DYuujxDbw@mail.gmail.com>
 <CAOMZO5AhTGskhEX9mv8oMJ1k4cbZzfZ2Vck5VcrVrYUvBA2r7w@mail.gmail.com>
In-Reply-To: <CAOMZO5AhTGskhEX9mv8oMJ1k4cbZzfZ2Vck5VcrVrYUvBA2r7w@mail.gmail.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Mon, 4 Mar 2024 17:45:11 +0530
Message-ID: <CAFA6WYM12F_9yyNwXY5xj9+zh3Jwa_Jmz8MkaKsxm3Jn3NPNKA@mail.gmail.com>
Subject: Re: [PATCH v6 00/11] An effort to bring DT bindings compliance within
 U-Boot
To: Fabio Estevam <festevam@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, peng.fan@nxp.com, 
 marex@denx.de, Bryan Brattlof <bb@ti.com>
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

On Mon, 4 Mar 2024 at 16:54, Fabio Estevam <festevam@gmail.com> wrote:
>
> Hi Sumit,
>
> On Mon, Mar 4, 2024 at 3:33=E2=80=AFAM Sumit Garg <sumit.garg@linaro.org>=
 wrote:
>
> > I think you also need Bryan's patch [1] to be incorporated as well.
> > Give it a try and let me know if you still see any further issues.
> >
> > [1] https://patchwork.ozlabs.org/project/uboot/patch/20240205-am62px-wi=
p-rebasing-v3-11-04cbb42eaa6f@ti.com/
>
> I applied this patch, but now I get a different error:
>
>   BINMAN  .binman_stamp
> Wrote map file './itb.map' to show errors
> binman: Filename 'freescale/imx8mp-evk.dtb' not found in input path
> (.,.,./board/freescale/imx8mp_evk,arch/arm/dts)
> (cwd=3D'/home/fabio/denx/u-boot')
> make: *** [Makefile:1126: .binman_stamp] Error 1

I suppose the earlier reference patch wasn't complete, can you rather
try its v4 [1] instead?

[1] https://patchwork.ozlabs.org/project/uboot/patch/20240304121257.3551104=
-1-sumit.garg@linaro.org/

-Sumit
