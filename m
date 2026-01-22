Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAD55D6CFA2
	for <u-boot@archiver.kernel.org>; Thu, 22 Jan 2026 19:20:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44E4983AC5;
	Thu, 22 Jan 2026 20:20:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LgrDA6G7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6D9983AC5; Thu, 22 Jan 2026 20:20:10 +0100 (CET)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F454839DF
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 20:20:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-383122fbc9bso10192851fa.1
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 11:20:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769109607; cv=none;
 d=google.com; s=arc-20240605;
 b=ZpXREwZSLKZP9Swymmh5jWan02XqCC4n1jEMAZqleJ1TWf7zGbv7jZvCmwQTrnU78P
 60YDwSo1tHexlNo0DX90D2pPEzIXw+2GwJvIBG9ZVjFbMIfX9s2I4j8F9FtdMwwWXX82
 +SbZ8faM9k4BO24BdRlFSqlVOFIKlS8Mzm+XybAVvpEkBKidsD9KJB/10MZJ9BKLNg1E
 RoIJl97DbqZ+4/IaGqR9FbVtJLmUtf6538BQPeAWFiPNCQT+iZlsF5j1rKJ2r1pQowQ6
 X1M4a65aP4qtfBpg7vX1L/4UUyMxyf3X5z5C9a9nWHl2Gl3qseaSpTNRm2nHHokE1B1D
 +eUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=3mA8UbrIczvAi7/Fdr/Vu1NiCyKznsllfr4VxXh8/rM=;
 fh=a745K87F3y9Gs+Vbl8alxuQHh6ZqH47cbltSzYQ1CGE=;
 b=CpyHX35EfkZZBREXPhROP3XGJa58bBwyH91wPzjiZAmC5PYM7mCR2X5pWs8igURtv7
 Ha0be4qLl2WYiGhyQfYzVhcYcuJIugQiVdiN+sss3mNa3CmBdfTYzS9mxGpamMuRp32U
 ScuTm7M16K4e7DHj0Jfg2sLpEvSWzrq6TG2H7tpB8WtSTqof2v6Nd5lmoS0fa/wgrhqH
 FpCP8RRlvVzAzm7mhPQ9+NgTkVMJfNoEFaDw07JOntR0HOyhX5apXtLOOaZn36vPQ1Zg
 15weMG2xI66H3c1QTUcBNWDpfmgVM89I3EuP02AFkASe0oRHrK4DULqP/0MMhRp3kX0b
 92Ww==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769109607; x=1769714407; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3mA8UbrIczvAi7/Fdr/Vu1NiCyKznsllfr4VxXh8/rM=;
 b=LgrDA6G7MrxSMjBF0qKtNp9BlFSU3YoYPqHs3WW0EyXEFffJP8ZzvZHoXMytzokXW7
 W9CCTyYQ2qeVjzQp7x8V29/Yx8xktGYXU1Ynl9a9utzvNDnlZTFZc+hw7YgaNR67SwRn
 Nwm/2FcAGjL8EEHTDeplXnNYH4IN/3gTI5waO0oDL9vxPbQ4UuqQCW0FAby9ver7NFS2
 lNpkRaWKs85vA/21y5IlW++3scQpltM6KfVHG2NgdT2oSvFFmi9mCevhsHM96I/FcEX/
 cP/Yha9lFW6NZ0lVceqmcCXFJxRG2tIE1gy2NPm8sk3+UJxSukHjtE4oemmkR9gZ2kiq
 kj4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769109607; x=1769714407;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3mA8UbrIczvAi7/Fdr/Vu1NiCyKznsllfr4VxXh8/rM=;
 b=Fd48gZkq52Mg39wTuzKFEwcl3M52S+WP5+asfXHiFjuo4VuYMhsXgjBgBuxlcfpdFx
 Mq4lZVpuqoVsWRh9PjWz0qy/G+oNlM0vNNKex/kPWxAFjwHzhYw78fffA+zbWIdhUOGn
 ua3Wq2q6lbkMabyL0rhov+Wggu66zLyKSSk3RQmt4vT58Ed5s6IHNRzOPFqsALJkzEcG
 oYIgwpZA5ebw3YmVQT5kLgYeFbl8jp0AVTAk/CjrkTd/9cilBtrHKRgCROIXFsNHjSv8
 di4AP82S1hMTpy/Q0fHF+O6ylAclqq2f7559epvlNRduQUgbkWIclAvqMAyn/umzYREZ
 s+7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCwlR7EZrnufeCM3PoLnwzpKSt/qxebtlTO3s39k5pLnmNdnBABc6xxBfvQa//bUGIe8TUnlc=@lists.denx.de
X-Gm-Message-State: AOJu0Yxjp0l2ovu/fd6ZLMdMA+obZooQMplmTNTCsfYTJumgjCROjAJy
 bMYHXM1JfgabEm0AVHoSsmgL4oBOZtAza+v9FbipRzoMkZHggEIc0PWJNPhmASCCro2VBtxTPSw
 /82XgNiDCNg164qvBWFW9wPIhANHryrE=
X-Gm-Gg: AZuq6aLZkNe8Ej0Clo7nJ9qNOFt80elaDAMp7t6RinEZGJEtVxKjeIT7tke43OLf2LH
 VjTi1ivjmx3pNIh7x7o+iP6frYfsFMdvDO3RY61aaB8d6wP2l8fOVdfMRQ40BMZ9SY2S1kVZsgQ
 /tH4Hs8KPpQcVAqgpk83uLLhmuwDDgFBYLX8DPU/+GuNOIIzhfWTNTPKrHSBUeQrL2G8gDjMjuM
 NGkYgBL+z0aKG6goaalH0ztPakkGY8LKkGqw7d2yJVgeq3gTfBU+MjIDFd9WqgnrbP0at7EPbcs
 grChchACnIDQBa5ThVwqL6TsRIU=
X-Received: by 2002:a2e:a556:0:b0:383:1ec5:9640 with SMTP id
 38308e7fff4ca-385da02f857mr1680891fa.32.1769109607221; Thu, 22 Jan 2026
 11:20:07 -0800 (PST)
MIME-Version: 1.0
References: <20260115222828.3931345-1-trini@konsulko.com>
 <20260115222828.3931345-3-trini@konsulko.com>
 <CAOMZO5DZNJ+=AP1spWCv7Ar6etf03H=DFVU=mXZcC7QFTGoh_Q@mail.gmail.com>
 <CAOMZO5COTa3ykhF8XZyzmJ0QZNotK4USo0LrH0XBJLogatfXFQ@mail.gmail.com>
 <040e129c-44ca-4a59-828f-d37c6e41d3b2@mailbox.org>
 <20260122142323.GX3416603@bill-the-cat>
 <CAOMZO5AZiBajXK1b6Mse9LPwHEzhJSM_-OcQs4BsnbXP3WzuxA@mail.gmail.com>
 <20260122191042.GD3416603@bill-the-cat>
In-Reply-To: <20260122191042.GD3416603@bill-the-cat>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 22 Jan 2026 16:19:55 -0300
X-Gm-Features: AZwV_QjjP4NsLMm60AJlRp8fQ3vRE6ci0lToUQ_O_-jyc6xFkWdptTQcjuL_IGg
Message-ID: <CAOMZO5CJ4BAi95gjV8a=_W-Wu=zr1dMOoDOCB4yUVAzY2ARBUA@mail.gmail.com>
Subject: Re: [PATCH 02/10] arm: Update linker scripts to ensure appended
 device tree is aligned
To: Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut@mailbox.org>,
 Kever Yang <kever.yang@rock-chips.com>, 
 u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Beleswar Padhi <b-padhi@ti.com>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Adam Ford <aford173@gmail.com>, Andre Przywara <andre.przywara@arm.com>,
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, 
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
 Eugen Hristev <eugen.hristev@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jagan Teki <jagan@amarulasolutions.com>, 
 Joel Stanley <joel@jms.id.au>, Michal Simek <michal.simek@amd.com>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, Stefano Babic <sbabic@nabladev.com>
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

On Thu, Jan 22, 2026 at 4:10=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:

> Can you please share it with my off-list maybe? I'm still confused as to

My work-in-progress tree is at:

https://github.com/fabioestevam/u-boot/commits/rv1103_prep/

This tree boots fine. After rebasing these patches to the top of the
tree, it fails to boot.

> Well, where is the dtb ending up in the resulting binary? The addresses
> are aligned correctly, but the dtb isn't where it's supposed to be,
> where is it instead? A challenge here is that I could only check the
> linker script used by about half of the 32bit ARM boards
> (arch/arm/mach-omap2/u-boot-spl.lds) and not the one used by the other
> half (arch/arm/cpu/u-boot-spl.lds). The initial error you reported makes
> me wonder if we can somehow unify these two afterall, which would be
> good in general to do.

The spl/u-boot-spl.bin file is 4 bytes longer in the failing case.

Let me know if you need any further clarification or if you'd like me
to test something.

Thanks
