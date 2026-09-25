Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6829C9830E
	for <u-boot@archiver.kernel.org>; Fri, 25 Sep 2026 10:25:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 56B0640B4D;
	Fri, 25 Sep 2026 10:25:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qqJ7RMB7ddhb; Fri, 25 Sep 2026 10:25:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org A4A2240B64
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790331916;
	b=dv45kGFJLnyuT2elRguRTpevfIvgXdmnrCfOHn52qVXtWze6Lr5D/iDeqRpADOBDJkXg
	 f0mFDNKNy/GgKsi4wRfZ8O1L6i4HqbndT5Uym9x/Ks6xwP79PWH7WmiAULbNWyGx2T4Av
	 KAFcKY4+K9B4USKTIylfi+LlK5cD0iDZPlrVI7Vx6kwBaKjvA5t3Mp4Qe3tv5vG6YkUNQ
	 xcxzs4BJZdCXSaBzoP1dMalb+RekWbQY3Vn9TjCqZClqwuvjDhQd3rmAmgXdM/ZaGb71r
	 gZHtuXtNpXdlUD31DYHt8x0fmqlL5ZFlrXcMw2SR+VLocq+oZbgoGkHurctAiH9g50A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790331916;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:X-Yandex-Fwd:DKIM-Signature:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=qufqsRfOK0JpqIFG2ePRPPMXglhVmjjalw0pFQe2ewA=;
	b=GTjYSWfMpHgyR2D5xPtWtq3bZr8zTFp93MV9t+o8rlDs6euzJFTEXhkk8kdHQi444yUP
	 hfO8qLbdmUcdsJKKkuGnko5ajSwD/kkpY6JI/HNxUMY8+B3nOUTEeve8PmBbfIPcPKegV
	 nXcv9AKfbS8bj+8zhQDpsXrrFek12/wqtiYbAz9BR8MBoVuShxdOQUG31Ho/M+VY8skgT
	 y8E+hraO+wIIEd7WpVJIBPn0GmnG3teqt0wvHlOJydanu568WqaBFyWRlme7+8fISZ9df
	 MCWSz9pezguECfjRG0EYsC4cuKlVVbi/+6tfdMTqy++EZ5pwVJIn9rzVXc2GPQYLFmA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790331916;
	bh=qufqsRfOK0JpqIFG2ePRPPMXglhVmjjalw0pFQe2ewA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=reqpItm+l1Vw974ca/wLxv45R16+OhTEBdg3bYE9uu+BIaQkDkuZ4CzgvLxye6Gua
	 OOTED5JV4sp1EWMy3NyinQRaurSREz5zXjbPQ2qP6Rkz8vtI07hAgZj34swC9ELbN3
	 /GygHEaC7LEZuCuHhhDtlSGeyn1L9K3lZi6i4Rwsok6wMDZ9mJByfgT2Vhc0giy1fm
	 Htty6Gx3tkGdlotXDXEavW5d4+nAK5fejD2GRIaLDM88Tqmr7TgwnWX4OkHIvjRw52
	 TQxp5f2fgsNFb1gBTrTap2eQPkgEszlkDE5WHQ1oV8AxzPreAXHJqtS15amHzQ3YPX
	 GzlVVTc7Cvk2Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A4A2240B64;
	Fri, 25 Sep 2026 10:25:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2D4073D8
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 10:25:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1242C81287
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 10:25:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id r7OIhYFcS-oO for <u-boot@lists.u-boot-project.org>;
 Fri, 25 Sep 2026 10:25:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org D0FAC8125F
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2a02:6b8:c02:900:1:45:d181:d501"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790331914;
 b=tXxGFMPbfhiJEqqEIk8actIJUCdzPn7ADTO0VyKEQsD2yv0zu5ub37qzcDL3yoOB3Zrs
 1up0k9Nc6h+koj/iIdvzuZz0Rct2EP/EKa/xlTn5tLHLT46zFnE/LYVEUhuQN/FACPVO/
 3TvIvbDhzZAPyBLs2dOtAYpbJIpwrSkQPSMMAbfAiyboyMo7IMrCKUB+0X4mmxN4U1EZl
 Ci0carcq6p97S3bIFqoBLYANESBybe8rT6f59+OgC9kkbNzhofwj0yMXyXkfQJcd3uURU
 PowEnAcmgbwqUnSQ3A6d6d6U7SyMDZ2ntet+XCVg+saNuwc6+CGoMwWIJCXTnm4g6ZA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790331914;
 h=Received-SPF:Received:Received:X-Yandex-Fwd:DKIM-Signature:
 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
 bh=qufqsRfOK0JpqIFG2ePRPPMXglhVmjjalw0pFQe2ewA=;
 b=oS1OzeiW4XdVkwkGIosEbxp7Lzb5R3aNycwcpdxai9PB05iMeKMs0Ry30kbi3WzYRToE
 G6nLtQAEddNcTHWDuZIFXsFAQ7R2QXU1CwbuX/ub+IKWB9CRaSUCebQN0Koy4PasYG7KK
 h+IjAg2XHIdymMEot2+fkXcEPSMvnNsHRdqvL+96E6i+16B7G0IULGUYo4J3CiNZcGCFw
 ayJGT7X71xbgTdkqrjj/yJo8CflIdeG1ou85SD8RXTJTgbkiVAdsL1AWx052sCV5h9PK+
 Lsf1Kgeik/uJHpEBE34AJmezInGULJ1uCjqfGNDJJhJ4wQqH/KvX9p4qpa/8JWR59FA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=none header.from=maquefel.me; 
 dkim=pass header.d=maquefel.me header.i=@maquefel.me header.a=rsa-sha256
 header.s=mail header.b="rch/CwpY"; 
 arc=none smtp.remote-ip="2a02:6b8:c02:900:1:45:d181:d501"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a02:6b8:c02:900:1:45:d181:d501; helo=forward501b.mail.yandex.net;
 envelope-from=nikita.shubin@maquefel.me; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=maquefel.me
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=maquefel.me header.i=@maquefel.me header.a=rsa-sha256
 header.s=mail header.b=rch/CwpY
Received: from forward501b.mail.yandex.net (forward501b.mail.yandex.net
 [IPv6:2a02:6b8:c02:900:1:45:d181:d501])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D0FAC8125F
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 10:25:10 +0000 (UTC)
Received: from mail-nwsmtp-smtp-production-main-71.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-71.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c24:2310:0:640:2452:0])
 by forward501b.mail.yandex.net (postfix) with ESMTPS id 0A742831E6;
 Fri, 25 Sep 2026 13:25:04 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-71.sas.yp-c.yandex.net (smtp)
 with ESMTPSA id tObYIp5namI0-ribbg5To; 
 Fri, 25 Sep 2026 13:25:03 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail;
 t=1790331903; bh=qufqsRfOK0JpqIFG2ePRPPMXglhVmjjalw0pFQe2ewA=;
 h=References:Date:In-Reply-To:Cc:To:From:Subject:Message-ID;
 b=rch/CwpY3ixrQCVKd4XeBs15t0HXn2rmxRxtkKR1sj7df6EV0JYkYDeMImxPft2bX
 v31nxUgX+mpbeHPKOf8byZ/Q0cZyNbz/WSdkz2z2VpPxGQjT3qHuIhQ89x+E0i/OyH
 Yj1mrCsgBsIm8SDbfhG9kFh5ANZDFtRxHl6/Lwac=
Authentication-Results: mail-nwsmtp-smtp-production-main-71.sas.yp-c.yandex.net;
 dkim=pass header.i=@maquefel.me
Message-ID: <0b7209c14e3b31ce91c2ff8e60468cb6aa2df537.camel@maquefel.me>
Subject: Re: [PATCH] arch/riscv: Allow booting from NET
From: Nikita Shubin <nikita.shubin@maquefel.me>
To: Yao Zi <me@ziyao.cc>, u-boot@lists.u-boot-project.org
Cc: Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>, Tom
 Rini <trini@konsulko.com>
Date: Fri, 25 Sep 2026 13:24:56 +0300
In-Reply-To: <20260904-riscv_add_net_boot_option-v1-1-125c3edbdb1a@maquefel.me>
References: <20260904-riscv_add_net_boot_option-v1-1-125c3edbdb1a@maquefel.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 
MIME-Version: 1.0
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

Hi Yao Zi!

Gently ping.

Thanks !

On Fri, 2026-09-04 at 09:19 +0300, Nikita Shubin wrote:
> Add RISC-V spl missing NET boot option.
>=20
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> ---
> =C2=A0arch/riscv/include/asm/spl.h | 1 +
> =C2=A01 file changed, 1 insertion(+)
>=20
> diff --git a/arch/riscv/include/asm/spl.h
> b/arch/riscv/include/asm/spl.h
> index 9c0bf9755c9..55cb56a3246 100644
> --- a/arch/riscv/include/asm/spl.h
> +++ b/arch/riscv/include/asm/spl.h
> @@ -27,6 +27,7 @@ enum {
> =C2=A0	BOOT_DEVICE_XIP,
> =C2=A0	BOOT_DEVICE_BOOTROM,
> =C2=A0	BOOT_DEVICE_SMH,
> +	BOOT_DEVICE_CPGMAC,
> =C2=A0	BOOT_DEVICE_NONE
> =C2=A0};
> =C2=A0
>=20
> ---
> base-commit: cc557af4553382f6f50e3ed62b9577054e7bc54f
> change-id: 20260904-riscv_add_net_boot_option-f7de8b0cbfd7
>=20
> Best regards,
