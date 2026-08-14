Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CC35C5B572
	for <u-boot@archiver.kernel.org>; Fri, 14 Aug 2026 21:23:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0F88F80F5C;
	Fri, 14 Aug 2026 21:23:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ia7r1lhW9HfV; Fri, 14 Aug 2026 21:23:23 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 31F7980F5D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786742603;
	bh=vxnrlYV34vZt4/tffqOlXWUinD5mkUmqp92VwMKouwk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LU1OS+goKF76IkXuX96jpkNNdvKVCi8PQnPhHctC+KEiIkBEd+A1yov0QnKp4IbOl
	 KFSnitkPcBs05d+7sTAV4Zd4Kv7T/joOREdn4qGN3CaQ/GxNqJz0nAKD6qob128j/a
	 COocnIQA3B2d53DcPq5k+UozetAgyuzE5MIwWVD31GkhvkQcfjY/PGDnSpdwDeatrA
	 ApWYWPWGC2rtcjj6yu8hxMn3Hlef5PqTe/Ghjd69JlYTBR4XXg55Pq9O8BYy9XjM+n
	 mG3TubHgV2UAyLUE1ReRzVkD6eYdHctTnIQnjaf8rWX7eLLyyOwTe7dMrgSac2iT5O
	 RW8zDxlbfpvNg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 31F7980F5D;
	Fri, 14 Aug 2026 21:23:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6179123F
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 21:23:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 474A480F5D
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 21:23:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pAWV1Xf5O0Au for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 21:23:20 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52a; helo=mail-ed1-x52a.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 4E30180F5C
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4E30180F5C
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=a8+u86ZO
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4E30180F5C
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 21:23:20 +0000 (UTC)
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-6a0c8283146so2131382a12.0
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 14:23:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786742598; cv=none;
 d=google.com; s=arc-20260327;
 b=JDJwPvCu0Se+0JgZ3eb3u52KDWGU0yKM/QhUeFyoFAV5S94jNZby3nei1LcxJjJOqW
 XNjf/xOydzbDO0OL9yHym0kaatmV0pKc9+PmrC+s1f6sYLYNxWmKEN0D+OzdGkeSo4M6
 FtBQja/7W3JB+qQ9lbqYWlhn6Rer/95J44asndUTe5iYfE85rb84yDXAF3s8M6/pFi+X
 XiBJWN3ZqVBA15wUIaBcaj94V09PmNBks8rACQD61m5WX6bHNWaE51t7Icn1Jga/A5Ed
 r3BkaI3GjMN8VjRYQfdH19HgvEyfPZqY+k0lmwvksZqg2m+8qjWCcAVpcYS3UPSztuNd
 HEWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=vxnrlYV34vZt4/tffqOlXWUinD5mkUmqp92VwMKouwk=;
 fh=Poon6yA3zlrUZCfAHy1fkV5/bnkRCwj8rHIj7D2+Ovs=;
 b=JVbO5QasShwlBsqJhGDdFroBz37RkfKB6aPWvGT8soPDTSirZzNkxhgLLlutSF50fu
 9V/Eu1MnVmAXpXPN0MPr220mAs+xJUqpoN/Am0E4sU9qUaXklWyPYfgACrqWcNPiMK1A
 hcyu2AkSXoXY9nEfGx6/2LqEihoraN/jbBlHaxAJGU71FbSSGdqd2hWBZmr7Efppz1TK
 3O+c4zlEVfrOm7MuVzkXEOW/g8E6lofRCl90qGXqzmY8i7aSpGMcMhuEwjp9noub3olp
 +V1+QRBajQa2D6xYxfi6PnfQGc+rwCqpShAGa3aPYRlNVFCl8sl3TxSDTzxjV9j51DhC
 9UJA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1786742598; x=1787347398;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=vxnrlYV34vZt4/tffqOlXWUinD5mkUmqp92VwMKouwk=;
 b=a8+u86ZOIVUhAuoELzhf6tnnRThijJPT7Dr1OE/Qkr3JuKPaLbq3rsyRWk9Qzm0RLR
 zsRhg/v/UC+/k0VLpyBOKkxFkrI46QMU2WtEHWvXFrnHz59cDXrJ4te0wbehCRmrm3Ec
 5U/5d5KdWmVBK9NpzRX3fViqFCzteu25CJ478=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786742598; x=1787347398;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vxnrlYV34vZt4/tffqOlXWUinD5mkUmqp92VwMKouwk=;
 b=mMwkvvReXeP/nlLveLlzlyWH2pG7NZARjSh/0qnyoiCUOvROwsOUykTVRi5X3+oroF
 P0WpVmMyOilCwcIJJCeI02CzOTU4uSFfYmqOz/eNZVb9E0dvoX3EyC5RKkR3pkw4RkZf
 qVf8WOjy4gsR+moJjbARNutHlTx/2io9xaY3v+OtXoTP+zSpQjDb3fBp+TQjb4M/0w2m
 OWQTN8t8W9JN0jHgGP7NPt7XUXcKc4RYCJqVOUuiq6mFmchJN8/oO5Fo4fy6cfAYueMl
 kxpSELp2xfVOKleEeE/I2aXS81WhAwmqA5tbkV8SiY52Iw8o6Ubs7sFGMZ2LlINsHcmn
 1iqg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr7q6WtNZXtNcIo5USfvrK3tW6Y4QM+ZhSZ+Irr1yAnUsScmCqFT1J8domXOmnGFyggZGqU12M=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YzSgPJrGVzzGG/INFo2O8GfAnTEhCmKhzTRJsY0JFpvM+a0n+RQ
 SU62w69bYN+U/vsROcTgJJktghBgrsbPZjef9zMNYi0lfolT3Eu6Vo6uiMDulCIZSDd/AWozeS9
 wiVrT7aS+mbYCrZQ8phNTRiGF6GdBKgh2MXX18Kgz
X-Gm-Gg: AR+sD11zKxH5CPlflORKfh7S2M2Nqmh4DpKT0uWjfzO580qEtvWRU6spWm4wDhOMmWL
 fqJfFft2ZoxEDvlyP28Vv4LsV1AWXEWmLkow8F2uZpmqly3fK6FjQtltrNR7Tze7nk/sWl9Ad19
 +2tvle1Lx52ZvgZuq0H8QHK92yLUKY9AfByL1Sckd1vGJBD+FnfAgLTWCSxOwGLbqYdPk7Lt24S
 9Y8LVTlJ6DyJl/IAorNDkzkwRSEq9adKxFEtdTbH9AiEHczkT7EjUaosqAoSpzC+lb0Q68imcYF
 kGaAJra2eLJ9c7ZYyO0SwLSF1QSzskv7zRDdlxb1Uvk=
X-Received: by 2002:a05:6402:5484:b0:69a:a4cb:2882 with SMTP id
 4fb4d7f45d1cf-6a38a8ff103mr3951440a12.9.1786742598228; Fri, 14 Aug 2026
 14:23:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260814-imx93-secureboot-v1-0-0c3c78020d03@bootlin.com>
 <20260814-imx93-secureboot-v1-1-0c3c78020d03@bootlin.com>
In-Reply-To: <20260814-imx93-secureboot-v1-1-0c3c78020d03@bootlin.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 14 Aug 2026 15:23:05 -0600
X-Gm-Features: AUfX_mz9KNIFTq93_fuvmMP7AfI4AV4JhKE1VU4ruPdaYzvQFbwBDvY-uMEqW7o
Message-ID: <CAFLszTh3EaFTMusTDiPZZWvXZ4PvyXXNLKGORc=ag+4sDF5SFA@mail.gmail.com>
Subject: Re: [PATCH 1/5] tools: binman: add nxp_imx93cst etype for i.MX93
 flash.bin signing
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
> tools: binman: add nxp_imx93cst etype for i.MX93 flash.bin signing
>
> Add a new binman etype which allows signing both the SPL and U-Boot prope=
r
> sections of i.MX93 flash.bin using CST.
> The implementation is largely derived from the nxp_imx8mcst etype, as the
> signing procedures for both platforms are quite similar.
>
> Signed-off-by: J=C3=A9r=C3=A9mie Dautheribes (Schneider Electric) <jeremi=
e.dautheribes@bootlin.com>
>
> .gitignore                         |   2 +
>  tools/binman/etype/nxp_imx93cst.py | 143 +++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 145 insertions(+)

> +class Entry_nxp_imx93cst(Entry_mkimage):
> +    """NXP i.MX93 CST .cfg file generator and cst invoker"""
> +
> +    def __init__(self, section, etype, node):
> +        super().__init__(section, etype, node)

Please expand the class docstring to document the supported properties
(nxp,srk-table and nxp,srk-crt) and the SRK_TABLE / SRK_KEY
environment overrides, in the same style as Entry_nxp_imx8mcst.
Without that, users have no way to discover what to put in the DT
node. Also, __init__() does nothing beyond calling super().__init__(),
so drop it.

> diff --git a/tools/binman/etype/nxp_imx93cst.py b/tools/binman/etype/nxp_=
imx93cst.py
> @@ -0,0 +1,143 @@
> +        if struct.unpack("<B", data[3:4])[0] !=3D CONTAINER_HDR_TAG:
> +            # Unknown section type, pass input data through.
> +            return data

struct.unpack() for a single byte is overkill - 'if data[3] !=3D
CONTAINER_HDR_TAG:' is clearer and does the same thing. Also, there is
no length check on data before this slice or the flags_offset read
below; a short input silently produces an empty slice and the unpack
raises. A quick 'if len(data) < flags_offset + 4' guard (returning
data unchanged) would fail more gracefully.

> diff --git a/tools/binman/etype/nxp_imx93cst.py b/tools/binman/etype/nxp_=
imx93cst.py
> @@ -0,0 +1,143 @@
> +KEY_NAME =3D "sha384_secp384r1_v3_usr_crt"
> +
> +CSF_CONFIG_TEMPLATE =3D f"""
> +[Header]
> +  Target =3D AHAB
> +  Version =3D 1.0
> +
> +[Install SRK]
> +  File =3D "SRK_1_2_3_4_table.bin"
> +  Source =3D "SRK1_{KEY_NAME}.pem"
> +  Source index =3D 0
> +  Source set =3D OEM
> +  Revocations =3D 0x0
> +
> +[Authenticate Data]
> +  File =3D "data.bin"
> +  Offsets    =3D 0x400        0x490
> +

The Offsets line embeds a literal tab and hard-coded values that are
always overwritten before the config is written. Please use plain
placeholders (e.g. '0x0 0x0') with a single space, so the template
does not mislead the reader into thinking those numbers matter. Please
follow the prevailing single-quote convention in binman.

> diff --git a/tools/binman/etype/nxp_imx93cst.py b/tools/binman/etype/nxp_=
imx93cst.py
> @@ -0,0 +1,143 @@
> +    def BuildSectionData(self, required):
> +        data, input_fname, uniq =3D self.collect_contents_to_file(
> +            self._entries.values(), "input"
> +        )

input_fname is unused; assign it to _ to make that explicit.

Regards,
Simon
