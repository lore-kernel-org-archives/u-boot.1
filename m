Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D816C4829A
	for <u-boot@archiver.kernel.org>; Tue, 13 Feb 2024 08:22:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B37287D2C;
	Tue, 13 Feb 2024 09:22:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ltGAV489";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A90C87D2C; Tue, 13 Feb 2024 09:22:41 +0100 (CET)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DCD3387D37
 for <u-boot@lists.denx.de>; Tue, 13 Feb 2024 09:22:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-511972043c3so719099e87.1
 for <u-boot@lists.denx.de>; Tue, 13 Feb 2024 00:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1707812555; x=1708417355;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nYpaD7O5xWMOmbg970skDbUk6kQuzuztgEvd+Biu0m8=;
 b=ltGAV489cwqSl8yV2GusUsRtolN+e78EOQV3Nn2ukObN4xfJ8LGFILb4YUay8Nhvog
 93KXXj1kCNbOqnTBfM8N21eIFAFdMp4Xv9REtrkYFh4lz5Y12JqF7kmB/sq68sibkIkm
 aFolhCWAEOPhUFODUBu1xNvp/VOfnTvw4uvYwqxTS6mAEH/JyngRJ30vJcNigqpp8czG
 XliUre7LgVCpNBS5HgqiR5mBOBnUERUZ5CxDTfdwKBRT52FIrsNt+gS03yn6KQBn3lYD
 6OsTR1G1Bjm+ARGD60VWgTvlT1v0ECc5YIILYHq7WDXe4BGw21XI7HjL5HBX63QRnSI6
 bZQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707812555; x=1708417355;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nYpaD7O5xWMOmbg970skDbUk6kQuzuztgEvd+Biu0m8=;
 b=CHlWrfY+3rE1SFvw0qJpbtTad/FkOzcAVLbQLBpygFa6zD0k8nXEs47l2VkwV3IGLk
 cvJoTUuphdDF3O4LcoWp6soZHmnl0A863G/sOnt/Mqlbtm46OtnZS8dsJnKgfsQPBRdk
 htnpkGkMYzyF4SSwZsWcbUtaOeDYuy6H/uj6HJWyZctx2rndvDD1irbMqrNmVahbolkJ
 BAJbBUDm+HDQgigq+DuAncNMXbJbeuUPzdbSPS/HFUyS6bZsIqPU4mw8fsctjBqJw19A
 MbdxGaKX/4wmXGkPIWZbr6A+OQrsPFzFKLIJRqKcjaEoBVmPIq0wYnVcI6bsxwznkh4h
 g0ng==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQ1Q6sk2BDRkBaSIegvH1tvcehKielIHPBat3YpbVLZYcGcFTaFV9eVI/n3RdhcDhq2fy6r3W81ITtIiml4zokf9WtIA==
X-Gm-Message-State: AOJu0YyvgOHyRnbxQDFlLrXhefolYxr04Tz2v+V6P52ocpNoiFDVFQNJ
 ycrisiUPfpW4EUST81LLoS22jh3s5DUC9vc6pOkS/jkDgXqKjovcZoryioSPQnk=
X-Google-Smtp-Source: AGHT+IEW0jP42dt0e/6JxuxdifxXyFW7osSaVGhOso82WSCz6hb0DzH14KaffYJGWAYroOzzQgvmgA==
X-Received: by 2002:a05:6512:5c9:b0:511:628b:e892 with SMTP id
 o9-20020a05651205c900b00511628be892mr5615800lfo.18.1707812555168; 
 Tue, 13 Feb 2024 00:22:35 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWe0dcFy0/Do+U2zCsMiJfFhIwCezE5xdJ/P9xv5VqWkmuDr1N9EY5yXzuRYdzdgHy7rv1txjK6V6+PAn308EYoBHL79uTUFxYFZHNSVYlMGbMvpKALICnh
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 az6-20020a05600c600600b00411c6c0dbafsm520761wmb.47.2024.02.13.00.22.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Feb 2024 00:22:34 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Igor Opaniuk <igor.opaniuk@foundries.io>, u-boot@lists.denx.de
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v2 7/7] doc: android: avb: sync usage details
In-Reply-To: <20240209192045.3961832-8-igor.opaniuk@foundries.io>
References: <20240209192045.3961832-1-igor.opaniuk@foundries.io>
 <20240209192045.3961832-8-igor.opaniuk@foundries.io>
Date: Tue, 13 Feb 2024 09:22:33 +0100
Message-ID: <87bk8kg4dy.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

Hi Igor,

Thank you for the patch.

On ven., f=C3=A9vr. 09, 2024 at 20:20, Igor Opaniuk <igor.opaniuk@foundries=
.io> wrote:

> From: Igor Opaniuk <igor.opaniuk@gmail.com>
>
> Sync usage info with the one cmd/avb.c.
>
> Signed-off-by: Igor Opaniuk <igor.opaniuk@gmail.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>
> Changes in v2:
> - Address Mattijs comment about usage info, sync with cmd/avb.c
>
>  doc/android/avb2.rst | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/doc/android/avb2.rst b/doc/android/avb2.rst
> index a072119574f..4aca7a5c660 100644
> --- a/doc/android/avb2.rst
> +++ b/doc/android/avb2.rst
> @@ -38,16 +38,22 @@ AVB 2.0 U-Boot shell commands
>  Provides CLI interface to invoke AVB 2.0 verification + misc. commands f=
or
>  different testing purposes::
>=20=20
> -    avb init <dev> - initialize avb 2.0 for <dev>
> -    avb verify - run verification process using hash data from vbmeta st=
ructure
> +    avb init <dev> - initialize avb 2 for <dev>
>      avb read_rb <num> - read rollback index at location <num>
>      avb write_rb <num> <rb> - write rollback index <rb> to <num>
>      avb is_unlocked - returns unlock status of the device
> -    avb get_uuid <partname> - read and print uuid of partition <partname>
> +    avb get_uuid <partname> - read and print uuid of partition <part>
>      avb read_part <partname> <offset> <num> <addr> - read <num> bytes fr=
om
> -    partition <partname> to buffer <addr>
> +        partition <partname> to buffer <addr>
> +    avb read_part_hex <partname> <offset> <num> - read <num> bytes from
> +        partition <partname> and print to stdout
>      avb write_part <partname> <offset> <num> <addr> - write <num> bytes =
to
> -    <partname> by <offset> using data from <addr>
> +        <partname> by <offset> using data from <addr>
> +    avb read_pvalue <name> <bytes> - read a persistent value <name>
> +    avb write_pvalue <name> <value> - write a persistent value <name>
> +    avb verify [slot_suffix] - run verification process using hash data
> +        from vbmeta structure
> +        [slot_suffix] - _a, _b, etc (if vbmeta partition is slotted)
>=20=20
>  Partitions tampering (example)
>  ------------------------------
> --=20
> 2.34.1
