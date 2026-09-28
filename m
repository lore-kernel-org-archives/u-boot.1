Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 730AECA5FA5
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 22:32:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3C58080A75;
	Mon, 28 Sep 2026 22:32:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IlWxu2lct4md; Mon, 28 Sep 2026 22:32:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 84AD08084F
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790634737;
	b=Y1qBVg92JkXSxiAIrlHdGLr6srAHbnPEpYJeuHgJHcDcXUKg0I+UukqvEDaX/7aq1nV7
	 DsRsG9vs5HAqj4yVUvUwIl2Vx3gNwqZEUVbKnMwYljpfQEH+op1sYsdHpiEMif7lJ2Fs7
	 LUHHDwIcbpQAdmWYeQuEXeR2T16X3fvvLUsCwWUZyQN4PsX8iC7GSvzQ0uE2Vo4CCNJBc
	 7Q5D9EGJndpqVTxHA0J9DqQnDXGrwUjSWpcBRnRYy97hAgIE5KmDs0NqhkBr4yIwCmHUm
	 +4p96rVPB561n/RndyURVLattmEwLGBZb+dAuBKHeQi8mA9/L3WD187ewDLEIJWXPAg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790634737;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=uKgyz5wtYevDyUKy+N39Sb4gQkSeeI8MhZW34m8FlMc=;
	b=cK2T20wZEYedSo8fKQJCt1F5d/N9ovTFTtawGDu/9NwiCXqSmAKdd4Dty3kZGqzdrIFm
	 s5IIDafHX9MbdP92xZY8mKXJqf+xIB7Pj47ZMnc66hffENVDAW2t2gwG7aAlGA0jPTWAZ
	 0SH3dMKpH4G0Ktk3TlFHvmE2V/qlREvv/oggt59ztwuoYDYT/2Qbx5OAUJxi7rLuMDCbO
	 qWRnBjFZABHZZDFSHvtSoCwHqZa0V5G07RGG4bqhoM/BN6ORMfT21lqcJPcc4Vvd1vb7Q
	 d/QQjQXnE3rvhm27zBYRqsl370E8jVJKnaF8Fu1HJ3xkSfbMqdOz8lFt+AicnoB1/Uw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790634737;
	bh=uKgyz5wtYevDyUKy+N39Sb4gQkSeeI8MhZW34m8FlMc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tp+HiIXIoTqvKAtifBzkl3kLkFO1apCb6oyy+udxWbSjjtk0JbhJCbtsxDcoPaF2L
	 yHcyzTqFajvP8Y0FLche+xBIufZKlcZIheeqtpOGZPXHDX/jsO6JSGOhc1ZUdvwu/G
	 hJwtyF0QIwBk3NZ5ep+laj0VQmS8bn51/GxHMP/o3CunVZpxGLDwDkLMbK90xi0YLC
	 5HuoXP0M4JJosaDDcBqTSUPp7VIf69wE70TsQcRd1f8QRrOPbsXQvck6YKyWjzcJDt
	 X8FisCHzBM+qd5GFRCY8XhQG8LDtzYXbVFtJ/Og6La1A3OFZ8zChulGoKEBmV8s7B4
	 7gwTvVIr083fw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 84AD08084F;
	Mon, 28 Sep 2026 22:32:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id E11B761
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 22:32:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D2DC04008A
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 22:32:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Pe_1-GJiqTNW for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 22:32:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org D145140090
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:33::d"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790634735;
 b=Lw/ybNY8g4/6j3I1JunaUV7osF0K941ivUHjZsSySlVKxIHqxNW/MBeYxLd23gfRT8dY
 Gww0J//8EgXoe8vPf0IptUvb68vZr87X+k07UV4pdATgTKJ5ne1aNHKumjaMvYI5ubrkZ
 hB591wsQ/LiAQmp71gOKYdi7ug2kE0btQRbzUrPr5mesd1cfFMWVJtmb0+VuQt5tqm4Bu
 CKQEA69Hgg6NKFMBxmRbT/OltaHxOGCeYs+4AhG9RlaG7n00DmXMxSSYuhUtvWZ99RUWV
 2OqWUgGrYWIXQkU6/VyV3LCvOByh6d0d3C6pHqyF8UoGwSZ9/so11Tft6S1G89QsMew==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790634735;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
 bh=uKgyz5wtYevDyUKy+N39Sb4gQkSeeI8MhZW34m8FlMc=;
 b=a0HPDREqi4CEw+trBxU8KqMcjegOOVxlfesaWWuv1WVCQXnnwHmwB0LR8MJLc24ygqIi
 zo7h3ipnGYV9P6LEUjWvzwroem+WAdoMQapPcUc6r87FGL/iPd04c7xhOmpnlimhKw3Qi
 nfYWrma/ZJKqrrP/jeuW0ZT4BAScc9rHJAvL3fBHHcB3M7xzZTSElicJknDvNoXRKhk7n
 sBAm/J1tEpaKvoPClGEUk/qO7fjapwnIMIuxMs2UJHJnQKeOWIzc07hEzLb5XkFs9Ug9X
 wsi+ZgeNfLfdg7vu5jZDN3K1VjXbg7Sxs9FzAc4JP2tCFYEV2B1TfVaA4ARrCE1rv5A==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b="Rh5I9eB/"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:33::d"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:33::d;
 helo=mail-ed2-x0d.google.com; envelope-from=sjg@chromium.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=Rh5I9eB/
Received: from mail-ed2-x0d.google.com (mail-ed2-x0d.google.com
 [IPv6:2a00:1450:4864:33::d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D145140090
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 22:32:14 +0000 (UTC)
Received: by mail-ed2-x0d.google.com with SMTP id
 4fb4d7f45d1cf-6ac5ef2610aso1260297a12.0
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 15:32:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790634732; cv=none;
 d=google.com; s=arc-20260327;
 b=DBBvqsnoVxmkmr8MXw0pXKyDdVo01BGEBqcWdHDB7aLrHsgF/9d8U6GSxpSNEwknxD
 kzZ+sg5lxjF+j2K89fMc9V36RSgZ9rOmudWEI2rf17DXefOHKfYdChI6+9jZ5thZWsSr
 ftbCc6ohKRzCrs46aAuFu386U6FoSNfuaIx0EPcq0/mtP8dIp/0FDyf7RLayZ1C73hRe
 yeA4schq13wjvl8xAQ4WyNWfXcFyIEcd74GyvWdl7+uDN4MXmWhcT1hWLLxOUJD5TZ5I
 NHb2P8s8JEn90NdvmE1V78zq+yhBwPymZxLl9DLpV55Q/otwidZPqILVIoF/+2Vki/1g
 lcCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=uKgyz5wtYevDyUKy+N39Sb4gQkSeeI8MhZW34m8FlMc=;
 fh=oHaZdIuMtNsKajTH0qg94dbogiUfoD68WHCK/WXlUYw=;
 b=I0PFYfTWYqRhTP2h8KrWnD1YITy3sJeUa7Hr4Mb+x6DMG1OUHGFmZ1wcjPofv7PFlO
 7QndnW4j5ox1F/IGa1NuW2VcYfR4ZQbx68wrRMP2IViMSx5x3EeVaVsaS+ijOHxI2+Rb
 KILfxjyMr38tnPXEJm4P7PSKTCPGkVb77RhyVUz6Zz3qG+HIbMYpRmYxNyui9spZzc/I
 Z/Nf5pDRjf82pf6cx72JjW66xaDkQAqXVhQWMqmB7C1qGgY4LrXjlwK5a9yBnlJumSMO
 IOf2IR+dyfh80Nr9aEdQbuX6AyGGVCh0o/LqPD9fRevTqXonsdHc3KS2TsANor8LFCpL
 Sybg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1790634732; x=1791239532;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=uKgyz5wtYevDyUKy+N39Sb4gQkSeeI8MhZW34m8FlMc=;
 b=Rh5I9eB/jLMjG44/IU61Uzf2FTCcO2LLaXr7TBqh3q1Qj1dIj+nB9ndnr2196G6lQ0
 QedY1TCtn6jMt1eSJTwy8PiZChlL8Z+xxwe1GKDp4ZvmyPz2h+++ENEUi65ZkFCeZx76
 1uFZG0ij4i9s/cQdtsurIyKMTu7VzwD4im7io=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790634732; x=1791239532;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uKgyz5wtYevDyUKy+N39Sb4gQkSeeI8MhZW34m8FlMc=;
 b=wneKIhWwUFxl9PhsQ1Vp2DHuOa3cKeBrlhuZMtmB+ekhfzgTxBuY7LbMa1yAAwUcFn
 Due49JvdHaSS40lwdcvBBsdqlsFxuT+8PZ/2gWEk1ZB98m/wWut1JbyFr/1CDxaOaxUg
 XPXBG/Mzk0HE922jgLrdivlvacEgng8O9orgZ1GQoE4uY8Y4NIWmywv5E//HqvY5KfS+
 gxo2NqlurvrzUPeYxltM40uyEYg9SNVbpyH43xKO8tki0lhufiElghfJTBo6Z+lDIRIR
 Rj2UZjJBhiHfrhNP/9jlcFMx6o4m3boP3dLpqbGnt/723F4HJRsykTF/D/jfW+4gkHdv
 LKdg==
X-Forwarded-Encrypted: i=1;
 AKwUvByqEcjazGjNYu6MXVbnEJbVnWEE3VCWY50Vj/hpEAfSeWKZyEesSp0O2/zNj8x/v1cYFRzjLb4=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLTK6TNlyJw3733Ybar/LjfPp0/DiJGglwdvyJAQ1gBP+cIEkq6
 XzQIHjy/fFglkW8cjK38IkMmv3BuFCp55qX16yiBEHZon4rZBqq6671IKkru12vxb44Nw89S0zU
 9u6Ow2WkOotwRicMcRust5bB6Uj7YQ4u66NhYin5A
X-Gm-Gg: AYBFou1sP5I71Bl5f+MMchSe0z1L8Rgdfy+6OQco5BUZcDUxks17sVeNfe1shNe90cK
 CsZ73AcHZbpqBh1n7hEJl5hZWiDHvo8YiQGkYLBF3N7Vir7iJPX+BD0ZcKcG9rabTsX964dMhfH
 ggs3sHARxNejw1x06MvowloDOkQHDBtwtCsP/3ikd/3yBUR9loRZ4CMGVkGc87CK/m01g/HcQZ1
 lJXwnZ4ripoEsRVvLmS/BNqwh/7d2vuU2NuJG3eLskCYKao7StXlLpCvjFrh86vH7fB50CCRClg
 UhsWsriZztU8BCcg975bWgWtCy3yVJUuxOAtQ+OJGQ4lQ/H30FHAGzJM8g==
X-Received: by 2002:a05:6402:2113:b0:6ac:8dce:5a81 with SMTP id
 4fb4d7f45d1cf-6aca82f47a4mr446304a12.8.1790634732113; Mon, 28 Sep 2026
 15:32:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260911-imx93-secureboot-v3-0-542a99793af0@bootlin.com>
 <20260911-imx93-secureboot-v3-5-542a99793af0@bootlin.com>
In-Reply-To: <20260911-imx93-secureboot-v3-5-542a99793af0@bootlin.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 28 Sep 2026 16:31:59 -0600
X-Gm-Features: AclHuK-SYP8Ow2DAsfHt4P-pPOdIh_JKBO1ME-bbyuti5EAt8Ua-6dPzyVN1zcs
Message-ID: <CAFLszTgti1cTpdeeayM1gS8JhZDribGV3Amz=jL6puhAxetRjA@mail.gmail.com>
Subject: Re: [PATCH v3 5/7] doc: imx: ahab: add AHAB introduction
To: jeremie.dautheribes@bootlin.com
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.u-boot-project.org,
 =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Marek Vasut <marex@nabladev.com>, Denis Mukhin <dmukhin@ford.com>, 
 Rasmus Villemoes <rv@rasmusvillemoes.dk>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 =?UTF-8?Q?Krzysztof_Drobi=C5=84ski?= <krzysztof@kd-solutions.pl>, 
 Peng Fan <peng.fan@nxp.com>, Alice Guo <alice.guo@nxp.com>, 
 Simona Toaca <simona.toaca@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Christophe Guerreiro <christophe.guerreiro@non.se.com>, 
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>
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

Hi J=C3=A9r=C3=A9mie,

On 2026-09-11T16:35:05, J=C3=A9r=C3=A9mie Dautheribes (Schneider Electric)
<jeremie.dautheribes@bootlin.com> wrote:
> doc: imx: ahab: add AHAB introduction
>
> Add an introductory document describing the AHAB (Advanced High
> Assurance Boot) secure and encrypted boot flow, covering the
> following topics:
> - AHAB architecture overview (SCU, SECO, PKI tree)
> - AHAB secure boot and encrypted boot flow
> - PKI tree generation (ahab_pki_tree)
> - SRK Table and SRK Hash generation (srktool)
> - SRK Hash fuse programming and sanity check notes
> - i.MX 8ULP/93 secure boot support
>
> This is based on doc/imx/ahab/introduction_ahab.txt from uboot-imx
> (lf_v2026.04). Originally written by Breno Lima, with contributions
> from Ye Li, Vanessa Maegima, and Utkarsh Gupta upstream in
> uboot-imx.
>
> Signed-off-by: J=C3=A9r=C3=A9mie Dautheribes (Schneider Electric) <jeremi=
e.dautheribes@bootlin.com>
>
> doc/board/nxp/index.rst            |   2 +
>  doc/imx/ahab/introduction_ahab.rst | 459 +++++++++++++++++++++++++++++++=
++++++
>  doc/imx/index.rst                  |  13 ++
>  3 files changed, 474 insertions(+)

> diff --git a/doc/imx/ahab/introduction_ahab.rst b/doc/imx/ahab/introducti=
on_ahab.rst
> @@ -0,0 +1,459 @@
> +       =E2=94=8C=E2=94=AC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=B4=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=AC=E2=94=90   =
=E2=94=82          =E2=94=82          =E2=94=82=E2=94=82        |
> +       =E2=94=82=E2=94=82Load ELE FW=E2=94=82=E2=94=82=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80>=E2=94=82          =E2=94=82=E2=94=82        =E2=
=94=82
> +       =E2=94=94=E2=94=B4=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=AC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=B4=E2=94=98   =
|          |          |=E2=94=82        =E2=94=82

Can you check that this actually renders correctly with 'make
htmldocs'? I am still seeing a mixture of | and box character.

Regards,
Simon
