Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B668DC5B572
	for <u-boot@archiver.kernel.org>; Fri, 14 Aug 2026 21:23:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 817F36082D;
	Fri, 14 Aug 2026 21:23:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0N6IgqURsImu; Fri, 14 Aug 2026 21:23:55 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9667C6069A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786742635;
	bh=S2kAeVmrF/uWUlG8BF4IXCeIQsI8sgIhY6pj/Yp4Wgs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=d6+neIobQhfo7ijzKBFI2TePMo48pbEZD35mrwpOrC8jQ79GsHTNLEG1G9XNaSLu4
	 mLqkdDMrGRAjG2LgHymmj1Pote9Awy+0c+YAuF5/L4mnx3qpzkOVYfLC8XvfX6Rge0
	 4L9PIcSxmWsCW8gTessGDuufCHhSQU4U/z8DeqOk0+xDQ/Era9elZsii1RxMiJsrL7
	 ds8F0y8gLorN4MOCdgy3T0QWc5MX4YbsTHLpm4tAAPd1dNO8tbESxsWb/4na/Ew81F
	 kQyR5XFtm56Kd8AmgcO+VLK4cVkdGbCvAb36oUrjgfhMQF2YzQ+eqNnCZ5LTQxssAQ
	 VsWS6BWdIAOgA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9667C6069A;
	Fri, 14 Aug 2026 21:23:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1F9F73DF
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 21:23:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 061A66069A
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 21:23:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TX8yzeFfzSRE for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 21:23:53 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::536; helo=mail-ed1-x536.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org C4F4A6067F
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C4F4A6067F
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=DwNhoSYS
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C4F4A6067F
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 21:23:52 +0000 (UTC)
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-6a36982a875so1846092a12.0
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 14:23:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786742631; cv=none;
 d=google.com; s=arc-20260327;
 b=hYO2p9MfLRq3S3hbpeBkxZctoSMzN18r1emJtCPAwrCH78v19l9lc3F25lJbxGeYy7
 mmIiC4ulpeAcX/YSSXbLGMySreGp9XFe69o+iD8rSsnK1y91zfZNt7BpLDQJ2ikxTSHb
 l7HFhICqHwSeR8XzQGcEf5dNgNw0fKaqbGbnPL97m/UrRS44IAJTqmUE4Xg5/sPFfD3s
 0D6VQKUIhsYrHSVGYwQKNrXLYqeiroZOn3ZboloKX1g58PecrP7ASZrba4+ek8EPD2hm
 IVaR8jHUM7QpUTMvNxUpt81ubz0MFYqqSd5TLaeUnHxTJp58fCjPmyOI2PSEEXG9foPC
 Totw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=S2kAeVmrF/uWUlG8BF4IXCeIQsI8sgIhY6pj/Yp4Wgs=;
 fh=o/TVdZdfR4biOv13Ruw0VTrD/BYEc+RtKl+Eg54Pl0I=;
 b=CLZz5bMx1EyCtUoNK1+lbG4Kc4sx/KlpNkTBzNr6DZ6TdOeE37wsUj/wTI0GTh/juB
 Mifkzfx26gafxT23v3oxyq85Qk4wvw8EAU/ppsoXLa5oY52g3rp5rLsbCuQTjMc2fGgl
 hykWfu9H6YjBejXndbtH4YLx8TGehDw6IO1swKXLXwjg5IpfWlW0RWeO080UAWzlI837
 wEtuJ/P4dHIRjLSHzYVEobXmn11PI1uxtd7BMR4fu9xgp7ldBf65mfKCok8mw4/DVReY
 efy39wIXOdCLLS8cYovYziHDRuS/NC8o/oZqOooelKA2P1v1ND1lt1EQdOrzhDh8k7hU
 R98w==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1786742631; x=1787347431;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=S2kAeVmrF/uWUlG8BF4IXCeIQsI8sgIhY6pj/Yp4Wgs=;
 b=DwNhoSYSD/uiFHD8c4fFJVkJUwOI4/7FvnQ5+nUQxTh5vLcGVoZH28zyRztTNkANNF
 22E1j6oesefS5X5dzX8XvPxyaILiqZ04IdXK4vVjQuS1ILUM1Ot3JNFW35XSKES00ue1
 Sv4+BsNZjJLpbxhBIRqd829uiDkYP7yhB3GRQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786742631; x=1787347431;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=S2kAeVmrF/uWUlG8BF4IXCeIQsI8sgIhY6pj/Yp4Wgs=;
 b=suq/FIqFsxV/l9pcxd8EA1ok/rXFLBv1QdllbzDrxqPGickoDZTMGpM3ZyrPBxgX0x
 oXhjn+Mzo6owzSCg0AeQgExPEffuqNQE8Xps6mAoSPSO1x4KCHMuDE/OQ93Pchls5uHl
 4C9i2LFRbFt2B6XWlTh7fATdrmjBokmRerwALmBFiBjP0QWrRyRkQCuw2knXH9Wu4KrY
 3EdNhnO2tVnCUml20XOWHjZP8YnNNI/5a6+YrsrahHDBeTA4zZ56GbM2u0lIfXTH3s2q
 8lO1JERNnwNX2hqFR+yHespVwfypG/niZKNSBDumnp3sKcQT30a8I/NPxWZisVNQ24T6
 bOHA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq+BP/fV751es1l2nUrw8c0eUkwou92iZm01zXlDpJAIsm7xabNhqri8zWqe8+VzAp9Fb4WzcI=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YwM9Dj2jREsaBobevCJyH/p/K1vw42maiT1puc7K8mQ5alTyZP5
 woVTYywLcqqmnXX4fCkwff/jASLmHPV5PshVVfdDXaAkHXjUAyK1mmyAVDO74NuIsvyAHWYXdkk
 3ho9aQ8Z8rAhD55xsLcb+i4IbThJbwmNf6kTVfzF7
X-Gm-Gg: AR+sD13bxFHbCcZD1OQEj5uqF5EHsMH/E3wCtjv5LaYPReJqELdZ8yzhjF8MS0gaHMQ
 ss0xPEF+WUXu0Ls5KPHXbDM6tvIUN1WeixLYUmUrBBVRzQO3BxSkJYw83hmfa9wFM8KyTrxAOJ8
 0mkd/WdX1WuliRCqq4KHD2Bhni1dNPTWIiPgsIBk5Q9EEl3zAYrgyPxJdpw398Fb5uENUlJTtk9
 rnXd2NZFcym+07wWmC9oP5jv/E9D7Ba7o2kI1I8SFINiOVX9pQ4fB9hsX1VpKPyFclx5Cc1WeyA
 4dil/aUWnpRtLbXEy7B2WBurr/Pk/WMt6GoeOh0TwSI=
X-Received: by 2002:a05:6402:5003:b0:698:3ce6:767f with SMTP id
 4fb4d7f45d1cf-6a38a96aebamr3846668a12.12.1786742630638; Fri, 14 Aug 2026
 14:23:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260814-imx93-secureboot-v1-0-0c3c78020d03@bootlin.com>
 <20260814-imx93-secureboot-v1-3-0c3c78020d03@bootlin.com>
In-Reply-To: <20260814-imx93-secureboot-v1-3-0c3c78020d03@bootlin.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 14 Aug 2026 15:23:35 -0600
X-Gm-Features: AUfX_mx472Ppkn0QlU55DH2_zinaTHhRekHx5VcFo0rAG-IHcmOHdoBQsO7NapI
Message-ID: <CAFLszTisvqoC+5EhdsCwWr1XZmZ6fAAbbtQM9qx5+-U6mnGnQw@mail.gmail.com>
Subject: Re: [PATCH 3/5] doc: imx: ahab: add AHAB introduction
To: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Dautheribes_=28Schneider_Electric=29?=
 <jeremie.dautheribes@bootlin.com>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.u-boot-project.org,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Stefano Babic <sbabic@nabladev.com>, 
 Fabio Estevam <festevam@gmail.com>, Rasmus Villemoes <rv@rasmusvillemoes.dk>, 
 Denis Mukhin <dmukhin@ford.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>,
 Alice Guo <alice.guo@nxp.com>, 
 =?UTF-8?Q?Krzysztof_Drobi=C5=84ski?= <krzysztof@kd-solutions.pl>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marex.vasut@mailbox.org>, 
 =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi J=C3=A9r=C3=A9mie,

On 2026-08-14T17:07:09, J=C3=A9r=C3=A9mie Dautheribes
<jeremie.dautheribes@bootlin.com> wrote:
> doc: imx: ahab: add AHAB introduction
>
> Add an introductory document describing the AHAB (Advanced High
> Assurance Boot) secure and encrypted boot flow, covering the
> following topics:
> - AHAB architecture overview (SCU, SECO, PKI tree)
> - AHAB secure boot and encrypted boot flow
> - PKI tree generation (ahab_pki_tree.sh)
> - SRK Table and SRK Hash generation (srktool)
> - SRK Hash fuse programming and sanity check notes
> - i.MX 8ULP/93 secure boot support
>
> This is based on doc/imx/ahab/introduction_ahab.txt from uboot-imx
> (lf_v2026.04). Originally written by Breno Lima, with contributions
> from Ye Li, Vanessa Maegima, and Utkarsh Gupta upstream in
> uboot-imx.

Firstly it's great to get some detailed documentation, thank you.

Please convert this to reStructuredText and hook it into the Sphinx
tree (e.g. under doc/imx/ with an index.rst), so it is discoverable
via https://docs.u-boot.org rather than being an orphan file only
mailing-list readers will find. New U-Boot documentation is expected
to be rst; the neighbouring habv4/introduction_habv4.txt being .txt is
legacy, not a target to match.

>
> Signed-off-by: J=C3=A9r=C3=A9mie Dautheribes (Schneider Electric) <jeremi=
e.dautheribes@bootlin.com>
>
> doc/imx/ahab/introduction_ahab.txt | 445 ++++++++++++++++++++++++++++++++=
+++++
>  1 file changed, 445 insertions(+)

> +1.1.3 [i.MX 8ULP/9x] The Edgelock secure enclave
> +-------------------------------------
> +
> +EdgeLock=E2=84=A2 Secure Enclave is the security subsystem based on a de=
dicated core
> +(RISC-V) to manage security tasks with a tight control on security resou=
rces
> +along with other enhancements.

Just to check - is this really verbatim from uboot-imx? The =E2=84=A2 is
non-ASCII and will look odd in a plain-text doc and trip up some
readers. Please drop it (or spell out 'EdgeLock Secure Enclave') here
and anywhere else it appears.

> +NOTE: The terms Sentinel, S400, and EdgeLock secure enclave (ELE), and E=
LE
> +are used interchangeably throughout the document.

Nit: ELE is listed twice. Please drop one.

> diff --git a/doc/imx/ahab/introduction_ahab.txt b/doc/imx/ahab/introducti=
on_ahab.txt
> new file mode 100644
> index 00000000000..4a5b6f795c4
> --- /dev/null
> +++ b/doc/imx/ahab/introduction_ahab.txt
> @@ -0,0 +1,445 @@
> +1.2 The image container
> +------------------------
> +
> +Due to the new architecture, multiple firmwares and software are require=
d to
> +boot AHAB supporting devices. In order to store all the images in a sing=
le
> +binary the container image structure is used.
> +
> +At least two containers are needed for the boot process, the first conta=
iner
> +must include only the Security Subsystem FW (SECO/ELE FW provided by NXP=
).
> +Additional containers can contain one or multiple images, depending on t=
he
> +users specific application.
> +
> +The final binary is generated by the imx-mkimage tool.

Since this series adds a binman-based path for i.MX93 (patches 1 and
2), please mention that binman is now an alternative to imx-mkimage
for producing the final signed binary, and cross-reference the new
i.MX93 guide in patch 4/5. As written, a reader would assume
imx-mkimage is the only option.

Regards,
Simon
