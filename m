Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E777FCD11C2
	for <u-boot@archiver.kernel.org>; Wed, 10 Apr 2024 13:18:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24030881AF;
	Wed, 10 Apr 2024 15:18:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=monstr-eu.20230601.gappssmtp.com header.i=@monstr-eu.20230601.gappssmtp.com header.b="TKAaSj3Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B87C7881AC; Wed, 10 Apr 2024 15:18:15 +0200 (CEST)
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com
 [IPv6:2607:f8b0:4864:20::b2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A034869F7
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 15:18:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=monstr@monstr.eu
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-dcbc6a6808fso6610658276.2
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 06:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=monstr-eu.20230601.gappssmtp.com; s=20230601; t=1712755092; x=1713359892;
 darn=lists.denx.de; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WTUOlSZ9YF8uobWO1z7sub0taVwcgwWQQy0Ho6pD0p0=;
 b=TKAaSj3QKpJVgHRsqygDIvr9iBIXHcpsSaH7xCLQI4viCaT6xmmkFryEPaySNhr7+x
 TGVatxL0m0iS4tQhQfUft291nheQZhczeW9RzIyGTZyz3QvR2k1g+8iYKQXS+cgW2ljg
 AkRg7wAI0vgjHZ9urnseQl7TBGsCXoYp24Uj8O22qE1aTwBx2l26GxAEvpajzy3HLnew
 bseOLMn0J6fasXNECSgB6AT5QEKprKMHuMRzUjoyk7+htea46NZ1wmg+dADqWyLJ3oYh
 ErJ2hclHexR33eo9Mi2sUtK4y3KCcz5+Y2e+zenQtJ4L4XcweI8aozsKFb61jG/Y2GWu
 hMwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712755092; x=1713359892;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WTUOlSZ9YF8uobWO1z7sub0taVwcgwWQQy0Ho6pD0p0=;
 b=jUZO5oC4sJsed3Rwi9SGibBST3WrW2kjk1pc43grMXT1KslBoWgvuLhg9hlR+tfE+7
 qNEgSZbP9qkCCnBpceTCtehfBK16DDES7rSJAAq5sk+GpvgZ4m0EOB44yZ7y1ulKyv80
 WQdjhbFjMkeurMOPIpOPLnXJbRKiWLLbGBXBudkwDIe2I6uCzJhKAE/fnAEBb9vvOFaS
 E18ij3hZLBC31/a3bzvJCdsgq8jcBIWPO5QnZmHkrdi6OdW5JWXltwXPMO/Unp8D/gdE
 Skjru1UxCWoy21WnCprN42WU1uEDbRyHUp77GXwG1f1jgqaarhYCMyVHXq912wSvmFRR
 2tOA==
X-Gm-Message-State: AOJu0YzEyzSVsRiIeUUODbnvR+pNuwBPEChh44I8mzOX+PYBfBnUWUeW
 XbpB21P8Mze4ymNlMi7U0NvDuC32UsgVsohphL4J+4xPb6Qw7NvA4TzWZ67kk2HCQTDXH/vpOf7
 LS9VIZbbCZLZLaZTWjbwghzFI42w2CCQjOXkb
X-Google-Smtp-Source: AGHT+IGWtLvOSNEDvrYnGpiGzCY9fQp6kCN8ths5zBf69Bx8O36X1uXlqSl4t5x96WJCXdSxOh1nZ2N5cwZI+DmZBOY=
X-Received: by 2002:a05:6902:4d0:b0:dc7:6192:c688 with SMTP id
 v16-20020a05690204d000b00dc76192c688mr2556922ybs.65.1712755092041; Wed, 10
 Apr 2024 06:18:12 -0700 (PDT)
MIME-Version: 1.0
References: <20240404114422.2905194-1-petr.zejdl@cern.ch>
In-Reply-To: <20240404114422.2905194-1-petr.zejdl@cern.ch>
From: Michal Simek <monstr@monstr.eu>
Date: Wed, 10 Apr 2024 15:18:00 +0200
Message-ID: <CAHTX3d+-CGGN5RptDugPAroLebVH1p40ZgKUPonj9ELr0tWd=A@mail.gmail.com>
Subject: Re: [PATCH] xilinx: common: Fix MAC address read from EEPROM
To: Petr Zejdl <petr.zejdl@cern.ch>
Cc: u-boot@lists.denx.de
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

=C4=8Dt 4. 4. 2024 v 14:23 odes=C3=ADlatel Petr Zejdl <petr.zejdl@cern.ch> =
napsal:

> The upper-to-lowercase character conversion now avoids altering the
> MAC address field. In the previous version, this alteration corrupted
> the MAC address.
>
> Signed-off-by: Petr Zejdl <petr.zejdl@cern.ch>
> ---
>  board/xilinx/common/board.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/board/xilinx/common/board.c b/board/xilinx/common/board.c
> index 66edf857f1..49dc5d10cc 100644
> --- a/board/xilinx/common/board.c
> +++ b/board/xilinx/common/board.c
> @@ -101,10 +101,14 @@ static void xilinx_eeprom_legacy_cleanup(char
> *eeprom, int size)
>         for (i =3D 0; i < size; i++) {
>                 byte =3D eeprom[i];
>
> -               /* Remove all non printable chars but ignore MAC address =
*/
> -               if ((i < offsetof(struct xilinx_legacy_format, eth_mac) |=
|
> -                    i >=3D offsetof(struct xilinx_legacy_format, unused1=
))
> &&
> -                    (byte < '!' || byte > '~')) {
> +               /* Ignore MAC address */
> +               if (i >=3D offsetof(struct xilinx_legacy_format, eth_mac)=
 &&
> +                   i < offsetof(struct xilinx_legacy_format, unused1)) {
> +                       continue;
> +               }
> +
> +               /* Remove all non printable chars */
> +               if (byte < '!' || byte > '~') {
>                         eeprom[i] =3D 0;
>                         continue;
>                 }
> --
> 2.31.1
>
>
Applied.
M

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs
