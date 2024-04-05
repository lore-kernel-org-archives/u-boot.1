Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85681CD11C2
	for <u-boot@archiver.kernel.org>; Fri,  5 Apr 2024 16:51:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0195F88507;
	Fri,  5 Apr 2024 18:51:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Pg2VrmkH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3FDD38850C; Fri,  5 Apr 2024 18:51:16 +0200 (CEST)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C2C688505
 for <u-boot@lists.denx.de>; Fri,  5 Apr 2024 18:51:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2a2f2cd61cdso300568a91.1
 for <u-boot@lists.denx.de>; Fri, 05 Apr 2024 09:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712335873; x=1712940673; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P5V372ORAeqQplHm8xmv0C6jsK0pzV7tsOlu8dH3iKo=;
 b=Pg2VrmkHWLYAtlNDfC7r/wM7060yidN2FZGgzd4fXYMnBKzMnM3nTcgbkco1TMbhhK
 JqmX+dx1ZlIneHlPSeUxFdO94w+H4oWB4AZ4EKTzTaRiRnwQYWuKztY8k4FEcWOwHdlc
 vw0gC2ClqL+E8YlSIQAU0eovptg12E5jf2fOaZELPn2/RI0yojbhMtgoW/BgZ77mwh8Y
 hGtgMgyQ5OzCQIcqtnDwrl5MI8W6Y3//J1fJM2MiIkoMo+okYKTFjpKAPaXmJE+Gcp40
 u8O+JsUUtqZA0FGpZCDlUUEjRip6q4Kmttmc2/VZFQ6KZ9UHdn+EWShxHSf0AZz4Fqjq
 LhnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712335873; x=1712940673;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P5V372ORAeqQplHm8xmv0C6jsK0pzV7tsOlu8dH3iKo=;
 b=NtGexnYUpVy3E8sAGDyeQFhpmKPlwNseLyz/JES+ofZiSXNidEdzushGBgr9iCnN1Q
 lpUfF6/y3oZS0ktqAwbowCwRjfyq5zN8gYLIo7a4UN4bz1wiyKPU8monymkAHBMxhBkf
 dg2PIhsug3vQN5ARVONb/1yWH0a3/RDvhPo8oid9lWK5wwik0BKDKSDuooc9B/LbUJGG
 cvxjxZenDsIMjG3PyvKtmDw4pZRvJPfFlBK2AcY7rulJZFN/dpeoFg2/z8l1efs5RPFU
 /ePhAmZqW1ViOKu5aqve8Bqv79dD16Bbyo9dMcNKvb9r3K1Brc8fzMyr/XILvsjdp45R
 fkSQ==
X-Gm-Message-State: AOJu0Yy+bAdekkiq2dKWMxdkROvdSRvTwJSksjAlgk7ytk1HkEx6oSIM
 seHejZPc5TDht6ecdcroESbOl78GjTT1PoHa4GZalJQs/REfbTJJC4WV+Gk7Pv9XrbG291a5TG2
 gLgxWMc2/1/efbbJ7xzYQIpLBtWo=
X-Google-Smtp-Source: AGHT+IGSUIHB8mt5oM4kqIAgFlgqLB/21ETJNGsihCL7Kva/489JIJf/LqVgZMHvDcf+Di41rSDM/mDbTEW54qRk/PM=
X-Received: by 2002:a17:90a:7d0e:b0:2a4:9464:d2ac with SMTP id
 g14-20020a17090a7d0e00b002a49464d2acmr479740pjl.2.1712335872640; Fri, 05 Apr
 2024 09:51:12 -0700 (PDT)
MIME-Version: 1.0
References: <20240404151110.2890691-1-javier.viguera@digi.com>
In-Reply-To: <20240404151110.2890691-1-javier.viguera@digi.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 5 Apr 2024 13:51:00 -0300
Message-ID: <CAOMZO5C2CvbUK5_kfs8Tcz3HNEBY7wftQMF_BE+2JkHTvWWJog@mail.gmail.com>
Subject: Re: [PATCH v2] arm: imx: fix signature_block_hdr struct fields order
To: Javier Viguera <javier.viguera@digi.com>
Cc: u-boot@lists.denx.de, uboot-imx@nxp.com
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

On Thu, Apr 4, 2024 at 12:11=E2=80=AFPM Javier Viguera <javier.viguera@digi=
.com> wrote:
>
> According to the documentation (for example NXP's AN13994 on encrypted
> boot on AHAB-enabled devices), the format of the signature block is:
>
>   +--------------+--------------+--------------+-------------+
>   | Tag          | Length - msb | Length - lsb | Version     |
>   +--------------+--------------+--------------+-------------+
>   | SRK Table offset            | Certificate offset         |
>   +-----------------------------+----------------------------+
>   | Blob offset                 | Signature offset           |
>   +-----------------------------+----------------------------+
>
> There is no runtime error in the current u-boot code. The only user of
> struct signature_block_hdr is the "get_container_size" function in the
> "arch/arm/mach-imx/image-container.c" file, and it's only using the very
> first fields of the struct (which are in the correct position) and thus
> there is no runtime failure.
>
> On the other hand, extending the code to get the data encryption key
> blob offset on the signature header gives a wrong value as the field is
> in the wrong order.
>
> Signed-off-by: Javier Viguera <javier.viguera@digi.com>

Applied, thanks.
