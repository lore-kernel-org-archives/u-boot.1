Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48591CCA476
	for <u-boot@archiver.kernel.org>; Mon, 13 Oct 2025 10:05:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A241783835;
	Mon, 13 Oct 2025 12:05:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="dzEHXDZ3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF6F1838A0; Mon, 13 Oct 2025 12:05:19 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4B198376C
 for <u-boot@lists.denx.de>; Mon, 13 Oct 2025 12:05:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1760349905; x=1760954705; i=xypron.glpk@gmx.de;
 bh=NFXKHlVA745xFA2GurK20WdCQBg+maHXPJuiw8FtC28=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=dzEHXDZ322hNDccgMU3u1sO8hQaAcVsf2adLltlRucqFT7R21YeA4sMiJdohnPg2
 v+LCk3T2UETQ2355XmtZV9h43cm8Dlf0bOIIjDNTRN23RDuul0iGaQ49rqgdAaitY
 7iEIlp3ArM/xxdsCDqZzEtCMkVpseWdtWu54OY6fKDNdSGocXwlVUWARjVUDiWiLh
 PkEjYdkCCDFkPsmEif8wD3B6CA0LV18N2it4EDojI90h+YxiMLoUp0hG6d+BFpfuc
 g+24cHXY9Cs1aOCE77V8wHcvC4E3h6MOsdMcGZY8Gl0V7upYjTtsREVzI+CpC4+dq
 ELGLmnc4VejwQEManw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.116] ([5.147.80.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mnpru-1uSu4J07VS-00qlqq; Mon, 13
 Oct 2025 12:05:05 +0200
Message-ID: <476e7a6a-1371-43de-9c23-7a70e70619c4@gmx.de>
Date: Mon, 13 Oct 2025 12:05:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/4] boot: Rename usb to ums
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Peter Robinson <pbrobinson@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Maximilian Brune <maximilian.brune@9elements.com>,
 Moritz Fischer <moritzf@google.com>, u-boot@lists.denx.de
References: <20251012064412.2892979-1-sjg@chromium.org>
 <20251012064412.2892979-4-sjg@chromium.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20251012064412.2892979-4-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ovABivjTX3f0/qU1tecMRRSQtkalOQ3KcqhFtm+E54kfhgz0JpP
 2qVpILnFo+MB60mU96ZxhfHir71xsY3+6B4qYRE8C0yKo4TO7zTQ5jMld3PvtjcsYNq0NJm
 5PAX4VBBECgFjXJCrwR15syAb7I3xiOG+mjUVTraoDDjyvD0xa8iVDwNHi0fPIUYLrXY7AV
 PsIxSJevoTGh2oYeTZ1Aw==
UI-OutboundReport: notjunk:1;M01:P0:XQ/YU+WoDpg=;C6Khez1C8ZLg+a77zG8vRymPiB+
 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
 EeqVEGsOFiQTFrI4gozUIfZrvtEHW/l2ibI=
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

On 10/12/25 08:43, Simon Glass wrote:
> The name 'usb' is quite generic and could apply to any USB device.
> Rename it 'ums', for USB Mass Storage.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Suggested-by: Tom Rini <trini@konsulko.com>
> ---
>=20
> (no changes since v1)
>=20
>   boot/bootflow.c      | 5 ++++-
>   include/bootflow.h   | 2 +-
>   test/boot/bootflow.c | 2 +-
>   3 files changed, 6 insertions(+), 3 deletions(-)
>=20
> diff --git a/boot/bootflow.c b/boot/bootflow.c
> index 6485d473d69..13f086167ab 100644
> --- a/boot/bootflow.c
> +++ b/boot/bootflow.c
> @@ -1019,7 +1019,10 @@ const char *bootflow_guess_label(const struct boo=
tflow *bflow)
>   	if (bflow->dev) {
>   		struct udevice *media =3D dev_get_parent(bflow->dev);
>  =20
> -		name =3D dev_get_uclass_name(media);
> +		if (device_get_uclass_id(media) =3D=3D UCLASS_MASS_STORAGE)
> +			name =3D "ums";

Using a different label ('ums') here than we use for the load command=20
('usb') just leads to confusing users.

We should use the same label for USB mass storage devices everywhere. Or=
=20
use a long label like 'USB block device'.

Best regards

Heinrich

> +		else
> +			name =3D dev_get_uclass_name(media);
>   	}
>   	if (!name)
>   		name =3D "(none)";
> diff --git a/include/bootflow.h b/include/bootflow.h
> index 657e3731f11..2aa00a9b1db 100644
> --- a/include/bootflow.h
> +++ b/include/bootflow.h
> @@ -696,7 +696,7 @@ int bootflow_menu_poll(struct expo *exp, int *seqp);
>    * bootflow_guess_label() - Produce a plausible label for a bootflow
>    *
>    * This uses the uclass name or EFI device-path to come up with a usef=
ul label
> - * for display to the user. Ideally it will say "mmc", "usb", nvme", et=
c.
> + * for display to the user. Ideally it will say "mmc", "ums", nvme", et=
c.
>    */
>   const char *bootflow_guess_label(const struct bootflow *bflow);
>  =20
> diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
> index 7cd83dc7443..b777708f5d6 100644
> --- a/test/boot/bootflow.c
> +++ b/test/boot/bootflow.c
> @@ -1301,7 +1301,7 @@ static int bootflow_efi(struct unit_test_state *ut=
s)
>   	ut_assert_nextlinen("---");
>   	ut_assert_nextlinen("  0  extlinux");
>   	ut_assert_nextlinen(
> -		"  1  efi          ready   usb_mass_    1  usb_mass_storage.lun0.boo =
/EFI/BOOT/BOOTSBOX.EFI");
> +		"  1  efi          ready   ums          1  usb_mass_storage.lun0.boo =
/EFI/BOOT/BOOTSBOX.EFI");
>   	ut_assert_nextlinen("---");
>   	ut_assert_skip_to_line("(2 bootflows, 2 valid)");
>   	ut_assert_console_end();

