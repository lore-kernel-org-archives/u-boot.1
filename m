Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C526CA6007
	for <u-boot@archiver.kernel.org>; Thu,  8 Oct 2026 10:33:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E2C758126A;
	Thu,  8 Oct 2026 10:33:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IMwSnoC7OI6F; Thu,  8 Oct 2026 10:33:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 2454D80ED0
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791455630;
	b=UFqY1dxNtjRjoZK4TW0PqjWF5Un5FRqhDqs7pyOZZ1HysNoMYyvau4xpVNFcGEdDRjpw
	 vICMhG4+PQAjxzSpbiSv/zMRB8GHwyALdvKQaOb5aEuFPBOsikUJEhfk0juQ6LnBvAl0k
	 x2//P0d1LkZFAWRj/QGyFhlyG66aB14Quxa8tZwwmcxca8p/1K6YuzRJaiqaayKEKwJew
	 Cy4T/rB33+/75LwdmOdCDXROoYHqCOinHmOu2DT2MOQjOGki3t7akEGckXdLMugqzPwsm
	 miPnJeFamSo8y5R7MCsxkcR6Nsoqtu6Jo83hKWoO0V6Rl82St4VYf10s2voM1JX2wfg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791455630;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=XII4I3uudPC7MjZmdi+FsrtGRXOg4d2OUGjnaYrNj7c=;
	b=kOODjrfJBRC6AHXP0z7n91/OW8q7W+vuIFHsanNs8MNQXjnfrVSiY8OnIaihp/JEcMkg
	 Xro/6yCZsQ+yfHbL7Oza5vUHR2tHC9VvDmcj8PMQ8w7EJWZNrBI29zdpXylRGefQzopfg
	 vUtmGB13T+T/SnOKhDrlpN6jNYx/GOvmxHRxNqEV/Zvn/uFUv8Z9SXsP4jLj9X6Ro1krM
	 yV76HBkeoiHKYT5VVN1iK4Y6fUPzJbSRRz7Zc+bIy+ac6YH/nrRkp1I7yd6VHaKL9KI2W
	 ko6giJNt8dflsrJg6J84NEh/7CVXyLGQLqaAqKQUOG7sgOeOpqFLF6glP1nHzp9A26g==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791455630;
	bh=XII4I3uudPC7MjZmdi+FsrtGRXOg4d2OUGjnaYrNj7c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pMe1eYh79WzqBSzAgoz2MuD+hut5O2PhdeE9hkfaXa9+hb/qliRTAnM0U4piF7x6v
	 r6bCa4476xpVF2tpDc7bF48gZD/X67TkDVCvoN3YBaDxSdz2Bt28lq477BNMr9E+Lg
	 4tnwfhQj1jQRHfmu9K3aNQUiDDmJDD2k0VcGnybnWmRZIFGFR33/4dJUfvM6YY3mHp
	 CCrPZ9p2o90VhM+thNjuwPSK2EbAFTUyPx9YzFaPne772E/PfOo8u/8Aq5DKHduNvC
	 WGibl283EPfcKwpgmrrfKoVnkqO5aKXJ6zfGAnL9adTMJOPnQ9c1Xs+KWrhAQTeCEB
	 7WMRK5LM4sBmA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2454D80ED0;
	Thu,  8 Oct 2026 10:33:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 20088338
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 10:33:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 11E684045D
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 10:33:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id y2Na9AoH0FeR for <u-boot@lists.u-boot-project.org>;
 Thu,  8 Oct 2026 10:33:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 9D55D40050
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::112f"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791455627;
 b=MlgUVdeOXxfcZfLW8Gq6fSo9ZuPhNuBmEnNals0lJil4wC6mImTDe6edzsE3P0fziQri
 qVm1YhqIUG6Do1kUg2+wMSbXcHsWYLWlZNxZzl8Fvi3TO902v5ZfdfDxJtly4e9HO2grC
 t66Qz5A+OjbKcJka61RHJPZKCVzDlpAye3NoSqFSB2jyqDo6elnF89kNvjwn1MaYcvkIj
 oHJ8CMEViNRdsBlq91oEtx2tenIEVglx5pJmO31n65Ntp18fHCgT3y15v11Bid/bw0Lb8
 soDD7kLA/2hFuF7zRonuOBqg24okVKeZEMLzp/EDlDSVD/mOamxwEwjxtT0B6kL34YA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791455627;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=XII4I3uudPC7MjZmdi+FsrtGRXOg4d2OUGjnaYrNj7c=;
 b=Vp0fb8+sb1MLMhCrD2j2k/p71SvJIRhR1gncpBlJDvbA9zcXS6tNFVLEAV97YxQJKxKI
 VeJjuf+qnP/ZsDmereET9WUe/J2jIuTTPES1akjcV/YN70lpWU+CNbA2QmEuLR7CcBFQG
 kIheURYeHv33Bhay+2Jyiv+NOmnXsXI0CWDEyWIB4U5uq3CaNiSR43Vz2aBTLWBZSGFEg
 p5xv4H/ZHOXlowQ5bMdJGXchf9sV0NsXK7K0u7ylklBJpSFtjFfA4eX3yuclnt/Qou2iW
 dwDspYuoGwD/PPPIghme+/daIrEB5SechF9ziHRIOUEYl9S8sHszY+lp2fJminHV9lA==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=C4Ozu75B; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::112f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::112f; helo=mail-yw1-x112f.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=C4Ozu75B
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9D55D40050
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 10:33:45 +0000 (UTC)
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-8a83d2706fdso42372647b3.0
 for <u-boot@lists.u-boot-project.org>; Thu, 08 Oct 2026 03:33:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791455624; cv=none;
 d=google.com; s=arc-20260327;
 b=BQRjXzBZb3yhaL2TYgoNvJ+JCIEXaDUJLlIfn0SznjemgUdRflmIcMHVPcvyESY4D8
 dHiMnNyNiXxULBjnLPNQxLJ0zwhjyO1T8ZVDcTnzdo1FkAJU/7Bnb6pTiTX+hdmEkFTq
 P2VPnVZE7ziNStYk8KpNAW6hOBnrURPhYrotmyGxETCsceqbhFkOicyfGS9zVB/kBYab
 fouq9gQLsVXnl4Jio5AATaeT3jgM++aLs5/Ft9a7jR//GFZr+t4xlLLVYYDYoo53rLN+
 O3YbjCyG4TKVLWCJLb6wZr+CJwg9cFfPxr958EFCvPZcU7Nz4SzGiLy/k/3vQggrUeFN
 wn6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=XII4I3uudPC7MjZmdi+FsrtGRXOg4d2OUGjnaYrNj7c=;
 fh=eIP6RErOlX6jOJiDVuEguN60jibnEj+3bnU1I+qLvos=;
 b=h8u/sgPYxlhEzxvBkzSHM6Zr2Synav6R/JccRKw9Df74gY1gCaTPtZFHFivDLlU85Z
 Bpz1gh0hSjO3d6r072frSFv7avg0Ucga2MXCymBZKHZaEjCbY01R6ASlQRX4wu4/f6qK
 W6VyeMq2LvxV6myvqhnzu7Bvl2ySLfzJdj7gMxNoTB5rwY1hlTvKLpAZKjd18hxhhzmf
 25H6vHlFcNTelUik2bXDb6wuFan7sLhNQb/B3YOKSnypo3iRsGQV8Lic4a1rAJIUxRlT
 gYkEbVkVNO4i/UntBsvMIjKd7zcXLQ7TouhFz0Dl3x90fV5LoU0uUSlUxKFpasKYqKda
 +xiQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791455624; x=1792060424;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=XII4I3uudPC7MjZmdi+FsrtGRXOg4d2OUGjnaYrNj7c=;
 b=C4Ozu75Ba38npA/TIA/2m0OS1r7+iMLbWmN/cbF6ALyxg/t6i4n/kuJZRTdeQghzj2
 IwmzWDChZTwjMF4STB2o/v8rQk9lhoCELG1pQ44L3L9cxX+mVI7msXa4NibVqDkiOzUw
 UHCZ7N+jXGAtkVxe8hQXtmPuOd/tB6hhlHVbxVy6MEJMs7S0jEbc9OAXkqo7NbSZP2gN
 kttsZU8B0G9yg0NutBo4S13lKAP7FiU8QHykTGp7n8P65kbHWrtMUpC89JkgK0kmy0qB
 w6RXfnuGaskQo0HLGEWyg8ez4pHAIegJad+4Ws2QEZ1Pg3aYEiO1657axM3dR7v/7K7S
 QJBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791455624; x=1792060424;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XII4I3uudPC7MjZmdi+FsrtGRXOg4d2OUGjnaYrNj7c=;
 b=uwQZs+cAdVDXqNE5+MN1FeknU2E803yOaQPHK+kOQRJGTv8sdAGSsKuO5ULsmHUizd
 pEH35Qg8cXzF+/OOop3oRaUvsfW0Ff3DL4Fb1KK2q1GMXB0cUey7zZGVvrnTbyCOGuCa
 1YU91vrY7DfVGqT4BUtUJy/8bLxmiJW1fmfuUUrv3sGHMnKDiiFxxOVeEXP2jd+5PF5M
 MT5hlIP5jOzg3hhS6yV0ZSoUjMuvn0VoiqqktjfBsI5qx0iRfNYwAun89h9A+T2EWWcw
 blBLViNCEA3E51BF16ek64gemMgXeQC0qX1iVTJHcimhcPPhe2feoPkILP7NbyEHOmiz
 HBRg==
X-Gm-Message-State: AFq9FYIfHWFmeOdOJoybTx6Jxow4kwyX4qI2EgOhR4kqApCRSBz+vpCf
 aAd4NhfA7Pp6YwzXvLpkgA829D0V9pGgzdb8ReiEUGKLF2+kmNVPnCnb6fJDl0gGNoH3GuSR6Sg
 w3uBz/kL/uT1bJNbcUEieVggFFy5EXoLgP1gKed4S5Q==
X-Gm-Gg: AYBFou1FvQRlDSkx3xo/8p5XgNWmvJS7RbC5D+NIZHPOyEj8Csb4OS0NOxFWpSMNqAP
 7tHdW8Ho+ewpt//42aG2vmxSdmHXQvNk83dA/PG3AKbv1oJf+nRcaHITjXij9sQRjTwEriSUiXs
 icrm9aKQXRLYIdUXKKmTwbEc1gUOpLZIgX+wj5G9VgQ0LSZbjNprVcFO63QrgvMOztSzPW1I7aX
 rosecS0gd6QCz+8gYBukoxVC3EhCcFQlDvPKypGzJsSgGLOZ5NCb6s3AT15RudVWGshDwyWm4uy
 9u/v/0HAykLskvLwzmDG3kdpE/l4ThZP7hpM0aP6J1IQhQ9EhW2/8ODK20nngOWlEZZzW5QoQgT
 wCThKCb0nV0y/tZ8zoXu7nIOcPuoxdJccUTx0q36cWQsvPwqXqUuhh3Bs2pV8RDiJHNcEhann9a
 ReC0lwTTOPbkQlKqJA9tcRDyl1D/qw80n+kL43WvN59ZSXJ2tOa203KJCCIXxILXVu4p5KqOoc1
 qQouJoEkln3AIYMZl+3GnVN56f6G1GQ9dkZffYTuvKeckx4RlsHMyLW7m/IO6ce4bKHxRVfBDlg
 5+1ACDMqilXa7nom/KbL2aXxr4px4O6uZT6oh393UHsxTaVKkjYXrkcRzNhC4ysOQTkO7FaBsmG
 ftWF+oGrGoPVYpaIug9JbiWlOBlupEsyXI/Kp1PRhjibzBUbyxa5i8oA25JbFiNeT
X-Received: by 2002:a05:690c:e3ed:b0:8ac:d426:108c with SMTP id
 00721157ae682-8b05b14ec52mr26137527b3.70.1791455623771; Thu, 08 Oct 2026
 03:33:43 -0700 (PDT)
MIME-Version: 1.0
References: <20261002-authi-v2-0-900f6f9141d5@arm.com>
 <20261002-authi-v2-1-900f6f9141d5@arm.com>
In-Reply-To: <20261002-authi-v2-1-900f6f9141d5@arm.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 8 Oct 2026 13:33:06 +0300
X-Gm-Features: AclHuK-gjQ18Ey-sr6xT7o6EF2_mWXGcrlZwXQzx4dAkO980ionTaziuCkVOFxM
Message-ID: <CAC_iWjKU=sMHAtLX_AVBfwLZ45HDEnW==2u3Stq+H5MkdMh7QQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] efi_loader: fix image info authentication attribute
To: =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
Cc: u-boot@lists.u-boot-project.org, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@arm.com>,
 Udit Kumar <u-kumar1@ti.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Simon Glass <sjg@chromium.org>
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

On Fri, 2 Oct 2026 at 11:38, Vincent Stehl=C3=A9 <vincent.stehle@arm.com> w=
rote:
>
> The GetImageInfo() function of the UEFI Firmware Management Protocol
> returns the authentication required attribute correctly in
> AttributesSetting only for the first image; fix this.
>
> Fixes: 88a2ef2720f5 ("efi_loader: Enable uefi capsule authentication")
> Signed-off-by: Vincent Stehl=C3=A9 <vincent.stehle@arm.com>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Sughosh Ganu <sughosh.ganu@arm.com>
> ---

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>  lib/efi_loader/efi_firmware.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/efi_loader/efi_firmware.c b/lib/efi_loader/efi_firmware.=
c
> index b41969c70fd..84de95f5c23 100644
> --- a/lib/efi_loader/efi_firmware.c
> +++ b/lib/efi_loader/efi_firmware.c
> @@ -364,7 +364,7 @@ static efi_status_t efi_fill_image_desc_array(
>
>                 /* Check if the capsule authentication is enabled */
>                 if (IS_ENABLED(CONFIG_EFI_CAPSULE_AUTHENTICATE))
> -                       image_info[0].attributes_setting |=3D
> +                       image_info[i].attributes_setting |=3D
>                                 IMAGE_ATTRIBUTE_AUTHENTICATION_REQUIRED;
>
>                 image_info[i].hardware_instance =3D 1;
>
> --
> 2.53.0
>
