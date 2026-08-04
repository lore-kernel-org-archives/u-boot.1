Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5471EC55822
	for <u-boot@archiver.kernel.org>; Tue,  4 Aug 2026 13:11:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 99EDE60792;
	Tue,  4 Aug 2026 13:11:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KtO9Qq-868WC; Tue,  4 Aug 2026 13:11:13 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1DCAC6078D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785849073;
	bh=vggjn/mgGqyEcHQQ/w50aP5Qw/gT1XbZhxDDWvmxOcg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vU4HYyRPliB59ddDgOvKEUEd6FGos0l94cgYtep0qtQjISubYONKii2CbUorrWjNi
	 FjPLIqKzb90K6yOxLMsf16Pg/XPc9DoIjCr/pHxE7j/nDoedbDL+l8c4wA/IPEJ4gT
	 GWpTFaKq2BjI8qXoO0QBF5YleqG5t5069JMVt4m3rnhAyR0zlcILzMgnk9V83JOsAa
	 UdgZNM9Dvoo7DeAHwCRUf+H75peGhpoqqjUhToRDqqJbylHoPmXBeeQTVmh7ap7Wmw
	 jNL0WXYGL+8Q0olvbi4ANOyozhV8LbJCi5pT7pnHGaVi53ffvvX8yBkm2b4gleEOSY
	 cxNRO9/ygC1+A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1DCAC6078D;
	Tue,  4 Aug 2026 13:11:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 83C5432E
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 13:03:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7635680ADE
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 13:03:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rFPwY3mR9OWs for <u-boot@lists.u-boot-project.org>;
 Tue,  4 Aug 2026 13:03:01 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::531; helo=mail-ed1-x531.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 8B1EE80ADC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8B1EE80ADC
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8B1EE80ADC
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 13:03:01 +0000 (UTC)
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-69c20ba892eso1405615a12.1
 for <u-boot@lists.u-boot-project.org>; Tue, 04 Aug 2026 06:03:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785848579; cv=none;
 d=google.com; s=arc-20260327;
 b=ASIBRrCRGIzLQN1oZbZEzw5liJacDGGcIwkoce6S5MDGb4xs81dS1aNrZ2CVricC56
 II2poDsjSU+2v4mJbN5viNYHKMHIwMfeIZ3OWjFJhGI60JIKCE3ZJvLncZwxv09s8EMi
 LP8S6eFsDpdKBGPYk0kpN2GITyx6PMgpkbCSXB84j9tArZk2kPfCZCklWztBk3ezgodd
 biDu1CkZKV6E8L8+SUNu0JvFdEZNjAXw7FSZNd0u6CNRI1fecYhkmPalPGyqTM8QGpWV
 wkIW5qlIoWAAkL9faPvfLH6kmoHUoHSbgDm1OejNVYF3fZjv70/4hEeH3GgXuvKiTPBn
 081Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=vggjn/mgGqyEcHQQ/w50aP5Qw/gT1XbZhxDDWvmxOcg=;
 fh=hsQzq9IYCmZwK0E7cVW3p7RZJMnlUShWANxf+Zzt34k=;
 b=ID3n0rygVjr3fMCFfaFLBmIjozW8W/xkTgdEtrz4bmwJsEQzK9YX/h+y4yt1vrb4Mm
 nJbL6ceZG2MWNz+W7zgSHa8iPbwCZIU1/Qf0SGjqUg8z2T8U6byEaRPr1JBIrn1mCBs7
 qw7V6QCPVO/ZGxV9ody8jURwhEORjqq58ksY7GlotP8rGByn3PK2fzn2gBW6BjHUXaWf
 4nV6hPXjaX1pg4lTJmghjtpQ21WRwRoqkJdCZa4Xc2liVCw7ujZp1AuS7iY88j8TbM6X
 oR4gE74rJrbCnFsrlaCTGpGiLAIT0ZV+s48L3SLN9KeTVZK16yQpmDtLdKjmpy4yW+px
 PdOw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785848579; x=1786453379;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vggjn/mgGqyEcHQQ/w50aP5Qw/gT1XbZhxDDWvmxOcg=;
 b=Vn+1YtCMZVHKiy4XYLRbwcd+tUl07Sri+JOsMVkRXU+1NQ5HceKEF1NUNd4TpDs9sK
 miGEJlQKgDXzTn1vNC8CcXltzUggAVBcRvoLymdbuiZst0Tl4aNhNGJuE81XxjfyA24j
 Iv2WifBWtb/9dqwZE1mxncs6fuPQksVG26UuScme5+qUm0mXS3qgcdEJCbTBAMvyXAC1
 DhNxbHGM2nqbTr1caCWHh9zpQLgIwOftItChShEs0uZQjYsy/m7iLpXQaBhpIdPbU3Hf
 ok81Sij3Y/U916P4MbMWT7pOB91j6zdVsa8HVTgn/gb5miOPULhIOuur3fudfHZyF5wV
 9k7A==
X-Gm-Message-State: AOJu0YxZe8/esYfWXnbeXipZdmsgFOD4LDNPvGBgMCklaVwtoGRe4ckH
 hw9oU/8sGJC9crLEba/Z5taJgN8HwrXF62ube9zRm0eZ/ASNeXJjDlyZ1AV60hGw9zNxVBJdB5r
 RRElaf9pa9Zdrowj4YAxliSYYBqpu8fy845iH9/wY
X-Gm-Gg: AR+sD12QZ90TMjYSqseq7ghUsoCb/JF1K23z2T5l7eaeM53bqLv6u7CwZcsw+UKlEhR
 DZq6Qj+ue9/tCP79VDgFujVwnie4akumiGT7puThOLAA8Fr/nP4/qNeazR9TvwhCKJuFZWsBf3u
 /sIdZzvapQLgJgzhhY7WwKp+HDVrC9HirLMkEMaJzTs+dJYDMV9TUvRZ0oM8i6Y2RflQIbb7yeg
 brEjaj0tjooZOk26VQxthC+IIdb4R8+NMzbhdtPnFNJKw9ln0o2IOoz5bpYEr9A7QjsyXicbhkL
 H2Up+DCIcbZkRqE1EcD1qumbWNogbkivDr2U4Jzkoq+V5wbPuDNMK/c=
X-Received: by 2002:a05:6402:5383:b0:6a1:1742:ac22 with SMTP id
 4fb4d7f45d1cf-6a122e38796mr4143806a12.2.1785848579473; Tue, 04 Aug 2026
 06:02:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260731-atf-falcon-v2-0-acb97c172993@flipper.net>
 <20260731-atf-falcon-v2-4-acb97c172993@flipper.net>
In-Reply-To: <20260731-atf-falcon-v2-4-acb97c172993@flipper.net>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 4 Aug 2026 07:02:46 -0600
X-Gm-Features: AUfX_myrUBtKKzpyBOloW2a94As4-Z3HfAA0YaNUAk6coflop2wNLgYZTxQ8hUU
Message-ID: <CAFLszTgVmR508j5h_ncKwUQT3T1_ZW=wCctrBut2+hf-qr13sw@mail.gmail.com>
Subject: Re: [PATCH v2 04/10] binman: Add support for externally provided
 Linux kernel blob
To: alchark@flipper.net
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Anshul Dalal <anshuld@ti.com>,
 Peng Fan <peng.fan@nxp.com>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Andre Przywara <andre.przywara@arm.com>, Andrew Davis <afd@ti.com>, 
 Hrushikesh Salunke <h-salunke@ti.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Ronald Wahl <ronald.wahl@legrand.com>,
 Richard Genoud <richard.genoud@bootlin.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Johan Jonker <jbx6244@gmail.com>, Daniel Golle <daniel@makrotopia.org>,
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Tony Dinh <mibodhi@gmail.com>, 
 James Hilliard <james.hilliard1@gmail.com>, Quentin Schulz <u-boot@0leil.net>, 
 =?UTF-8?Q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 04 Aug 2026 13:11:06 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785848579; x=1786453379;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=vggjn/mgGqyEcHQQ/w50aP5Qw/gT1XbZhxDDWvmxOcg=;
 b=IwweDSji1hILRqMVeHz9ziF8JSV4euWVJJnLgzRwZKNi7Eh46292rg8KWG1ep5XALS
 83xj5JHT2sus2+buaALRL9YSCCOtpyqMl53j7A/7s5XmHbGQLwMuRo7oxlMZ1nSlG+SZ
 YYYKcI6YobaXRT5ovPJV1ny6DoERyQ60DNwuc=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=IwweDSji
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

Hi Alexey,

On 2026-07-31T17:10:44, Alexey Charkov <alchark@flipper.net> wrote:
> binman: Add support for externally provided Linux kernel blob
>
> Add an simple named Linux kernel blob type to binman, activated by the
> "LINUX_KERNEL" make variable. No processing is done on the passed blob.
>
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
>
> Makefile                           |  1 +
>  tools/binman/etype/linux_kernel.py | 22 ++++++++++++++++++++++
>  tools/binman/missing-blob-help     |  5 +++++
>  3 files changed, 28 insertions(+)

> diff --git a/tools/binman/etype/linux_kernel.py b/tools/binman/etype/linu=
x_kernel.py
> @@ -0,0 +1,22 @@
> +class Entry_linux_kernel(Entry_blob_named_by_arg):
> +    """Linux kernel image blob
> +
> +    Properties / Entry arguments:
> +        - linux-kernel-path: Filename of file to read into entry. This i=
s
> +            typically an uncompressed ARM64 Image.
> +
> +    This entry allows binman FIT templates to consume a kernel provided =
via
> +    make variable, similar to how BL31 is passed to atf-bl31.
> +    """

Please drop the ARM64-specific wording - this etype has no arch
dependency and can hold a zImage, Image.gz, vmlinux.bin etc. Something
like 'This is typically a Linux kernel image such as Image, Image.gz
or zImage' reads better and matches the style of atf_bl31.py, which
just describes what the blob is rather than how the FIT template
consumes it.

> diff --git a/tools/binman/missing-blob-help b/tools/binman/missing-blob-h=
elp
> @@ -32,6 +32,11 @@ If CONFIG_WDT_K3_RTI_LOAD_FW is enabled, a firmware im=
age is needed for
> +linux-kernel:
> +A Linux kernel image is required to build a Falcon mode FIT image, which
> +lets SPL start the OS directly instead of U-Boot proper. Build with
> +LINUX_KERNEL=3D/path/to/Image, or disable Falcon mode image generation.

This ties the generic linux-kernel blob to Falcon mode, but the etype
itself is not Falcon-specific - a user could reference it from any
FIT. Please reword to describe the blob generically ('A Linux kernel
image is needed by a FIT that embeds one =E2=80=A6') and then mention Falco=
n
mode as the typical use case.

Regards,
Simon
