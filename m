Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3015EC54FD4
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 21:49:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AE94280A78;
	Wed, 29 Jul 2026 21:49:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gCQr0do_kPxi; Wed, 29 Jul 2026 21:49:43 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0173A80A7A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785361783;
	bh=lrorHwyDMIAxbU9ukevbVT3DKb16TYl0SE/HwNz+pfY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=b9TSymAN4IgqMS58dz1DS/+EhEHrR7D1cuNGObSi7G9QwBUnFdxUe1zxMJBaFXBq0
	 mbgXQm7dTofYAS6YyOzUiGXnExOGMixNkukSDuZC359KxsrY9o1HyLp944CmL9Ea0O
	 dcsjAvx8L+xhsbUoZ5T0hNa81PBYCid0g/mVEWICUFhOfWLNWsIuGN7SSmUE+EtVGA
	 VrprWIyDVL/0gcpFbRHLnlGMx/yQhyjVhfYkwQ+p0PABQWEXh1nbNMNjbYYM9No86c
	 4tzBfJUTwFFCIrt+3Tgy1kXiJxNxEmq6fLougavJkCH4RqVadjPc0aDMJ8qix+PeZa
	 pOayRD3UQG7IQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0173A80A7A;
	Wed, 29 Jul 2026 21:49:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0AD9F28E
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 21:49:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E4D3B40723
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 21:49:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JjHuaNVTN_K8 for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 21:49:40 +0000 (UTC)
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=tharvey@gateworks.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 7FBB140721
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7FBB140721
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7FBB140721
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 21:49:37 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B85B8494B; Wed, 29 Jul 2026 23:49:33 +0200 (CEST)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6EF5803F6
 for <u-boot@lists.denx.de>; Wed, 29 Jul 2026 23:49:29 +0200 (CEST)
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-497d6c2d000so790576b6e.0
 for <u-boot@lists.denx.de>; Wed, 29 Jul 2026 14:49:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785361768; cv=none;
 d=google.com; s=arc-20260327;
 b=g9Hle9HDZy1awRekQgwe5Lk8gR5sd7Kk1UHW0Pbb9LbQEXXxDc9CvlEJ7X9yXDO6VI
 jUAOQFGxVESla91Mhb0Ene3AWFPZXP8HQf8J4BF1FPhzrpUGjgl8i7Xnmy5bLqWY5Lwr
 rdNgsnqbfbupclCmAn9hOr6AbQkjFyTE3p7nn7aH4rORNRIx5dO4bPm1Vi1R4vmtqAhd
 1zQCwuZS4gC5sYAar3SY8nm9aWm3qhitN2KiyzOj+NCKdeGLYvUvdQu/tdVsHV3zha0V
 W/ane6y1tqlV0XcjCinAtx8Ze14TvWYPEvbXsSDrCBLpqVW+/k6ij7CRs+RsYe2XT8Uo
 MfNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=lrorHwyDMIAxbU9ukevbVT3DKb16TYl0SE/HwNz+pfY=;
 fh=q0k+maLne/HTjE8iamO+95vVl8A/PELZghOoHrXVEB8=;
 b=k3yXYQIbYtunUgZ3CRRYmfRpatajwXGcdoU+J4dG9pYbA/nZ6XeHwk+x+He9WJ64R1
 69OImcu5Hg+LAljFoPyAps1JSyegHoVgXdxCja6F+puR72H+bi8rbUdKc/FsqH1P4svV
 zhnVdE6P9m9VkWitf7JpqsJtHNA+hPFVydQB/47rqX61XhM5XFnZOeTQq7dt9V5FlUtp
 zPlO6HPGZQqWt1HQ1m1akR88k5PLnsarQaHFkapIPattPBMNZyAaoHF+t7TUTMWWWCH9
 zWUhoVxzhJ3d2E+LO1SudVev477hWaOe/156rCU87YWjk45/9c0Dom751XYfJXLFscVr
 BioQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785361768; x=1785966568;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lrorHwyDMIAxbU9ukevbVT3DKb16TYl0SE/HwNz+pfY=;
 b=AmqiajeI7yE0m0RTil0s7ubXiOru6CZccGUdtSFraNpnXEDnUEVyIebqAj0OszHJ2n
 25XZemt3Af8lpBvD5J5Ft3JITYCJk9JfxUAMMNPUdbgLvozY32dib0+UJ2KofXxdhTYA
 AUiYPfq2Gq61EfXAmLyLTUcLdyalvcfJc6tSJ9TDYt3PFMyug+kDmOTUjjIj0rGtRuuf
 KGG6ztdpRR+yNgjyOaaZfhNncLb1xvXhOhoahie7zr/9hxXq80HHaOVnVbebSpT9ldQY
 +2+7pBe9LbDW0LYuoMIm7ge1kzfC81W6pid6kh5PhZPbIlCYEZHHGFYZBafS1xJ4trOI
 +kQw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrd2Jej2qXm5MgLZAk9yZiUDNv9LDgOJY80S/JmIaQbTez/vfexR8sKPLsm2K0uZSXMDk5P5+A=@lists.denx.de
X-Gm-Message-State: AOJu0YwGx278itOwkMMaK//oNCbaYLWZaV6JBXfE+udyR8uhivMrnXvq
 WrOeM58p46xtpGrQQSJuq/WhOBuFoHx9qpQEB1xfvt6ooEmjcDK5Ad5rE7lpYpiX8ElNqqFsORt
 TtgW0ei3v+TMJO1Bn5rJHn06D8lKUW9ZqE8wQOYKG1Q==
X-Gm-Gg: AR+sD10ArVwvPhPuNaRKnTA0iSfqytattdTf+H2WjfJpyMtWN0xCuI+M0E3+aoJ5hu1
 0TOF/n0dS2jVLkgDOBzCD+kKtN6qA2DVtLxBIsx7wfZQ8R8ZgIMJrtyT48sikAe9UJh9mrL/Roz
 nPmDllcdMdiLZOLO3TPtD6Z/Q6xyQr13FqVCiwJIPrRFQ/PGqzFCfH4puYZq3yYOwZOj4fuq3hM
 3khrHYl3cq1zKckAbpnQYviejbc84RGEEXACsC71+1gk98Hg1SfW2WsHxb3QDs5kbUBGizQM+iy
 Z2kiNNeMzG2722y0b6WZpBWtTGM65EhY5M/3qaIN14/f
X-Received: by 2002:a05:6808:130b:b0:4a0:6d4c:7cc1 with SMTP id
 5614622812f47-4ad8741d0b7mr164196b6e.0.1785361768288; Wed, 29 Jul 2026
 14:49:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260717000644.61897-1-chris@kleiner.pro>
In-Reply-To: <20260717000644.61897-1-chris@kleiner.pro>
From: Tim Harvey <tharvey@gateworks.com>
Date: Wed, 29 Jul 2026 14:49:17 -0700
X-Gm-Features: AUfX_mzqJ9o4E26QONg72ak4lWJMb5Xik6U5-NuXAi4fV7OO4DPzZRtvJZwZl1U
Message-ID: <CAJ+vNU3K+t+Lh87eKcb5LwwDSHZgKG8+6WJLEztBb25O23jckA@mail.gmail.com>
Subject: Re: [PATCH] board: gateworks: fsa: bound FSA EEPROM gpio descriptor
 count
To: Christopher Kleiner <chris@kleiner.pro>
Cc: trini@konsulko.com, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1785361768; x=1785966568; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=lrorHwyDMIAxbU9ukevbVT3DKb16TYl0SE/HwNz+pfY=;
 b=JLhTH+9unoefwF/5sI6P5dD/czBEY/+hC0X7z0MsLgR2ifUwWTMGsayBwfMisVuz1O
 QU9D1U1Y8RAmSsO2eUOIpexWL2cABlYHq02D9+39HSBm2QZ8qfBWqZFwYDVKcPolSXgE
 KvzPNeICkPdJyj9EnD1fNyBBbjWRTYOmdK4PisOzYUZKvEU1HQdjokJl1oTVvVFZEQpq
 IOfbcyUJw+6F1wckIJ/i41ihitPv39a2q4EJHJRDvip5XFkcL2iGDlQ4xi9nizsD1j4N
 s5U6B11rl7fdLWJqL0EauCgclszdWkYAZFDghdf8jzEmLywFnPiRAj01Wh2PJ5IwtKJX
 ZbkA==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gateworks.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org; spf=fail
 smtp.mailfrom=gateworks.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=gateworks.com header.i=@gateworks.com
 header.a=rsa-sha256 header.s=google header.b=JLhTH+9u
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=gateworks.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=tharvey@gateworks.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=gateworks.com header.i=@gateworks.com
 header.b="JLhTH+9u"; 
 dkim-atps=neutral
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

On Thu, Jul 16, 2026 at 5:06=E2=80=AFPM Christopher Kleiner <chris@kleiner.=
pro> wrote:
>
> fsa_user_info.gpios[] is a fixed 20-element array, but the number of
> descriptors iterated and indexed comes from the FSA add-on board EEPROM:
> board_info.sockgpios and board_info.ioexpgpios are u8 fields (up to 255
> each) read via dm_i2c_read() with no upper bound.
>
> fsa_config_gpios(), invoked automatically at boot from fsa_init(), loops
> over info->gpios[i] for i < sockgpios + ioexpgpios, reading past the
> 20-element array (an out-of-bounds stack read whose contents are then
> used to configure GPIOs and build names). do_fsa_gpio() validates the
> console-supplied index only against the same EEPROM counts, so
> "fsa gpio <i> ..." can memcpy() a descriptor to user_info.gpios[i] for i
> up to 254 -- an out-of-bounds stack write that is then written back to
> the EEPROM.
>
> A malicious or swapped FSA add-on board EEPROM (only a valid checksum is
> required, which the attacker can compute) thus yields OOB accesses on the
> boot path and via the console command.
>
> Clamp the descriptor count to ARRAY_SIZE(info->gpios) before iterating,
> and reject any console index outside the array.
>
> Fixes: da9e2218afc2 ("board: venice: add FSA support")
> Signed-off-by: Christopher Kleiner <chris@kleiner.pro>
> ---
>  board/gateworks/fsa.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/board/gateworks/fsa.c b/board/gateworks/fsa.c
> index 1af8021057..126a897ee2 100644
> --- a/board/gateworks/fsa.c
> +++ b/board/gateworks/fsa.c
> @@ -140,6 +140,9 @@ static int fsa_config_gpios(int fsa, struct fsa_user_=
info *info, int gpios, stru
>         int i, ret, flags;
>         char name[32];
>
> +       /* clamp EEPROM-supplied descriptor count to the array size */
> +       if (gpios > ARRAY_SIZE(info->gpios))
> +               gpios =3D ARRAY_SIZE(info->gpios);
>         /* configure GPIO's */
>         for (i =3D 0; i < gpios; i++) {
>                 desc =3D &info->gpios[i];
> @@ -637,6 +640,11 @@ static int do_fsa_gpio(struct cmd_tbl *cmdtp, int fl=
ag, int argc, char * const a
>         memset(&desc, 0, sizeof(desc));
>         i =3D simple_strtoul(argv[0], NULL, 10);
>
> +       if (i < 0 || i >=3D (int)ARRAY_SIZE(user_info.gpios)) {
> +               printf("invalid index %d", i);
> +               return CMD_RET_FAILURE;
> +       }
> +
>         if (i >=3D 0 && i < board_info.sockgpios) {
>                 desc.offset =3D i;
>                 desc.source =3D 0xff;
> --
> 2.43.0
>

Hi Chris,

Acked-by: Tim Harvey <tharvey@gateworks.com>

Thanks!

Tim
