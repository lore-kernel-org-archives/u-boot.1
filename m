Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD062C5516F
	for <u-boot@archiver.kernel.org>; Sun,  2 Aug 2026 00:02:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A3AA160685;
	Sun,  2 Aug 2026 00:02:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yEscHTF3LcXe; Sun,  2 Aug 2026 00:02:31 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 670D06060C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785628951;
	bh=txCaZGupux01giCFmVETdTBZ5PLmb8pvLW2OavDVUuY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zSkz7JlHUnJyiT8XwDtY1eoD4qwlm/Pg90j05wtytT6lV+STVEGHksmwGtdN3eSJ6
	 n+rc1c7ChLvrfc0H6q8qQZ9hdSx0ffFgMkk1ERYmFCtWbyIu17y06kZowZm5Nyvi1U
	 XgGDXNlBxU4yO3I28RnEgU+M8e0x3kAjP7WYAJaQABduCPqhQ4mTZyNhCk/v4Lyv6D
	 CSuHpBG/oAJxTnUbC/FvzaPP3U6kg/wCvethzefXPkqz/oihq39MW82zO5tae9e28Q
	 adk+V071T+6tG7VNjoF07mOYlmDqD7R53q+YsI683WnVbvkBBNmuiVMHN7J9lk83/4
	 m6JuxrOv4nBMg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 670D06060C;
	Sun,  2 Aug 2026 00:02:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id DBA8E23F
 for <u-boot@lists.u-boot-project.org>; Sat,  1 Aug 2026 22:57:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C1CFF80D9D
 for <u-boot@lists.u-boot-project.org>; Sat,  1 Aug 2026 22:57:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Fmf0BGnyyc9C for <u-boot@lists.u-boot-project.org>;
 Sat,  1 Aug 2026 22:57:23 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::102a; helo=mail-pj1-x102a.google.com;
 envelope-from=ralph.siemsen@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org E6F0080D60
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E6F0080D60
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E6F0080D60
 for <u-boot@lists.u-boot-project.org>; Sat,  1 Aug 2026 22:57:22 +0000 (UTC)
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-3811f512167so2221906a91.3
 for <u-boot@lists.u-boot-project.org>; Sat, 01 Aug 2026 15:57:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785625042; cv=none;
 d=google.com; s=arc-20260327;
 b=Bsml0rUEjaj6bRMDhnF83FXSPTSVqwHYrBZlIyyUrd2yIRKjGP3gjcijLYG6KfZAcm
 l1vgr8JBgsmDWBJ1UHJRdiKUinlrD9/Qy2JSv0i4KH70yotD95BwGylu09Nqbn7mNS6T
 UBmZCdsRZgwW1b7xymEfYW5ZzgTR1t6fNijSrYJCdx39cchtVgTnF2lArVbCX+JqGx5P
 FAMgXS00CQVHXRcoeUPZ/ZWv7RtRBI6Di8ipQAz5EPp5mkTZarJkQnXbz93483xJx+sN
 h2y+Z5fFxoRxzXhWnXibNlR1IxinPEqNIV9Shm6hMJIZ6pi/NQ3O0ak7otBah6CEdUzY
 D9zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=txCaZGupux01giCFmVETdTBZ5PLmb8pvLW2OavDVUuY=;
 fh=mv98/Bh4/OE8tOsIbuxEWNwtaX4nSnMD9emH+z6Tpuc=;
 b=DdESnWfw3yQxykGzOjqR+TFacocJP6Qk1XdUtqeBZYBI+crK0coPDLHwyHZ+KHAwEx
 YY7Zr9ssjGBqAEAd9RBbHTDAWd8BJZRo8iNSOMxIgaHtFNogpD+bWQo63Ffhpfw87mtR
 aA+60XOWtSwDNUl6+n3W20CAWAFw+3LUklQ0GQoLbp6FHN3Nt15gQ6M3TrDNOnESp8tk
 can2Psj2fB0Qn+uxjZOsCCOdmZ5DgBVnwFJkfoSxoCP+PdncueUXrqC4Sh1CsOivoxfU
 knx1VBn/6aopMO93e3wLxseoYafKG3xy7R6sUoALXi1RUsgy+GwsXAXqOli7RwG9PwgE
 Nagg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785625042; x=1786229842;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=txCaZGupux01giCFmVETdTBZ5PLmb8pvLW2OavDVUuY=;
 b=Ku7iCHeDv889z/2AkbKvfGH+CGvytI2mwFKAQMJ2Agb8kvUr1IlYeawg9XXklN9cKi
 Odp5uOqgTl+EpiA3FSqtgSCQAxVzl8KUvJttCERN71NZlVlgZg8RNIpKTOXRj+HQBOxK
 9xE62pm20/lb0zCgCuZ1hVlgkXlZ4xo5CEjeo+8yPSVe+GdOyLcUc4oazGsZxuoSGroj
 YPg09OVLGJydLAMsaWhTPfBuE9aL7MUOUT/g3AWFIr3m69FdKmr0xnDQ19BQ9q2A2z1E
 NjM/G2wrDb5lCXOGCSiFZNIO3zo0ELJJ73P9X+YxOUKSHP2MOZiM8tYz34ADWSydhTjB
 eQ2w==
X-Forwarded-Encrypted: i=1;
 AHgh+RqtEZGLfn5pPkwqIcrsYMzCyJ9/pZMLcoiy9LJ3ISvOFs4iLA70gso/6TgeFldF1sruhC3nOWA=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Ywj9EbMaMGThhWQOZEKlHpz8w6p9F0HqWDBCbis/IKr4KEp7RmU
 SK4xzGcYrxhv/593ILXMgq3oonfDdyl5CEX2Xr01fY524cibWdtMaJWNOIVlZzNeNJGYfmIa58D
 RYStBSzmoXYTDP/49DOivDsZ75tv3uOGlA8GAC7Fu/w==
X-Gm-Gg: AR+sD12MzGgY4Bi+1Uca44orlHt2M3Te/gkL2iC2QNQEzq6pFgAbxu79zZyQbwA63ul
 1HsjA3IFLHqBiUALGqTAaa1JpKWfSwfr1R5AIDesMXO6g9yBfLWokrPQa+tWf+StbrZfgLn0N1k
 epAn5GD28TxtUoiTrvbtBIEI+H3BcqaEVYqDqcilAXKROKb6KC08NQar03/S2rChILZB8ziOguj
 aFv0Ql77J65EtqR/9JnNPH/46oNKhg4gNRr5FTO3JJcafCvXXG/RtZqZzkZCqiR6UcOSOoAWl3g
 T4go/IGz7Kr7xv6+AcqIJkTRqMzrgwtKuFFjW4StxW24u7pUiD1a+yMKbZjanvSxYnThzxuOa5j
 JhQoOV3v9sssehN5iO7fhpD11kQ==
X-Received: by 2002:a17:90b:164e:b0:381:dc88:7c09 with SMTP id
 98e67ed59e1d1-38fbc56cda4mr4636213a91.33.1785625042034; Sat, 01 Aug 2026
 15:57:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260731-rzn1-2026-07-v1-0-af2ce80db9d8@linaro.org>
 <20260731-rzn1-2026-07-v1-3-af2ce80db9d8@linaro.org>
 <800f6c85-7854-4b7e-9509-3006c3ca8b42@ti.com>
 <CANp-EDa+2Hdzg2nn9mcOupkLNPvAohnu_1UZ9AaysG_gvK==AA@mail.gmail.com>
 <1ef87c1d-4188-48e6-b67b-205364bbe39b@ti.com>
In-Reply-To: <1ef87c1d-4188-48e6-b67b-205364bbe39b@ti.com>
From: Ralph Siemsen <ralph.siemsen@linaro.org>
Date: Sat, 1 Aug 2026 18:57:14 -0400
X-Gm-Features: AUfX_myPVtQ4l8RC233tiB7iZFOYRkiogQBDDefuN6TcSfuw1ZM9Ldt1JlhUKuE
Message-ID: <CANp-EDZON_QjoF+Y_E099TNxY-DGMH+sZYVtHTwe3mX14C6meQ@mail.gmail.com>
Subject: Re: [PATCH 03/17] spi: cadence_qspi: Use APB write protection
To: "Kumar, Udit" <u-kumar1@ti.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 u-boot@lists.u-boot-project.org, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>, 
 Michal Simek <michal.simek@amd.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Senthil Nathan Thangaraj <senthilnathan.thangaraj@amd.com>, 
 Abbarapu Venkatesh Yadav <venkyada@qti.qualcomm.com>,
 Padmarao Begari <padmarao.begari@amd.com>, 
 Naman Trivedi <naman.trivedimanojbhai@amd.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Sean Anderson <sean.anderson@linux.dev>, 
 Boon Khai Ng <boon.khai.ng@altera.com>, Ye Li <ye.li@nxp.com>,
 Alice Guo <alice.guo@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Jerome Forissier <jerome.forissier@arm.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, Peter Robinson <pbrobinson@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Robert Marko <robert.marko@sartura.hr>, 
 Jim Liu <jim.t90615@gmail.com>, Ben Wolsieffer <ben.wolsieffer@hefring.com>, 
 Stanley Chu <yschu@nuvoton.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>,
 Angelo Dureghello <angelo@kernel-space.org>, 
 Anshul Dalal <anshuld@ti.com>, David Lechner <dlechner@baylibre.com>,
 Daniel Palmer <daniel@thingy.jp>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, 
 Richard Genoud <richard.genoud@bootlin.com>,
 James Hilliard <james.hilliard1@gmail.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Hai Pham <hai.pham.ud@renesas.com>, Johan Jonker <jbx6244@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Julien Stephan <jstephan@baylibre.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sun, 02 Aug 2026 00:02:30 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785625042; x=1786229842;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=txCaZGupux01giCFmVETdTBZ5PLmb8pvLW2OavDVUuY=;
 b=nDuwqc0K7LPgCF0vzx7AReUTVVugiQVnRVO9yWtv0ql5fRpZWMEW+U4othkRJsTMXi
 jRtnXi1DmZ7OlI+FMazIXLINnrnEuazixJppcIhXnSMBBsPoeupvgfDgaAnIqkc365KM
 uyoYROulU0lhO69NTBqNcsZ4llA5IdbG19FQZzbSm1BMyxx0biqYGJqX1CxFgjoEKivS
 HTj0VbJRUlLYHz4VXsPhhKKp51tE6jo3j+5HBZpJDXQfrE5mQ4Donmd/3XjDqb8B/QRe
 kl0XmsPM7wd3+HsudWoXX4+910tdphYDdelv7n9utrkH+tuTEIdoIBIo2nVGq/tzcfxg
 XOLA==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=nDuwqc0K
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Sat, Aug 1, 2026 at 11:33=E2=80=AFAM Kumar, Udit <u-kumar1@ti.com> wrote=
:
>
> Could you share your compiler details
>
> My compiler reports warning (gcc version 11.3.1 20220712)
>
> ../drivers/spi/cadence_qspi_apb.c:334:13: warning:
> =E2=80=98cadence_qspi_apb_write_protect_enable=E2=80=99 defined but not u=
sed
> [-Wunused-function]
>   334 | static void cadence_qspi_apb_write_protect_enable(void *reg_base)

I'm using arm-none-eabi-gcc (15:13.2.rel1-2) 13.2.1 20231009.

I would also expect a warning, but none appears. Even when I change
the "caller" to

    if (0)
        cadence_qspi_apb_write_protect_disable(priv->regbase);

there is no warning. However if I remove those two "caller" lines
completely, then I get the warning:

    drivers/spi/cadence_qspi_apb.c:334:13: warning:
'cadence_qspi_apb_write_protect_disable' defined but not used
[-Wunused-function]

I'm compiling with CONFIG_CC_OPTIMIZE_FOR_SIZE and #
CONFIG_OPTIMIZE_INLINING is not set (eg. the default values).

Either way, I am happy to add back an #ifdef around the function definition=
s.

Regards,
Ralph
