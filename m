Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AB8CC52D7C
	for <u-boot@archiver.kernel.org>; Fri,  9 Aug 2024 16:29:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C8C28895D;
	Fri,  9 Aug 2024 18:29:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sigma-star.at header.i=@sigma-star.at header.b="XvPhZLSS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EDFDE88B9E; Fri,  9 Aug 2024 18:29:38 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8DC3B882F0
 for <u-boot@lists.denx.de>; Fri,  9 Aug 2024 18:29:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard@sigma-star.at
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5a156557029so2805854a12.2
 for <u-boot@lists.denx.de>; Fri, 09 Aug 2024 09:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sigma-star.at; s=google; t=1723220976; x=1723825776; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6dfoYFNKl++GI9dcIjE6TFdsylyTS+tfUteqKRLj/qQ=;
 b=XvPhZLSS8Q1FnJRTj309s1Wzlh1sow0qvJ5i68R90pKcReoFLKrWtXsS7p9WtdQtJy
 KYvFioIhCV85aL8kipzoWIWbyKD2DckRiN9lUOLrLhBzmgjacuMM2+sEKqHCEV1UwDb8
 4wVQ/39oVK/jB/6TpKHMrErz7WdxImwsumZqzha3PQ6neQ9M7meN9Ty39GMWxIiiI4Pt
 Tgy7pJITvRFlnxYVje2X64pPBzob99Pqcf1Vh7yUkm5ZAPC3XOilNX7TYi0zDbB/TDl1
 1UZf3KWMQW7oGBDitTn1Tz7/ild00sFOElO8pNb7KbHt3iLq1r8wH7vKticEu31DYP7p
 oCyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723220976; x=1723825776;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6dfoYFNKl++GI9dcIjE6TFdsylyTS+tfUteqKRLj/qQ=;
 b=CXZ1l62yMwFtVF6iE1sV6mBdj1VJx/RzGX0fEE/aHr3hWzULf4kW3jIDINh4FdfbTy
 rOAiNTpzOtEgQWBYCQ+nZuFYfvuRUe0rVHeuwsxIWhDTBytLcMIUabOQ/CGYVklP0VJH
 AkU7kfDrFn4z+8xC4e/NTVpm+q6Sbm+8ISPBelnz2MF6b2p5p7eT34T53pwHfr1eW7oQ
 5vj+wSsn5KTAqyfgwrut2CDTD9/USLt1n1wROO8a8Bf2qHvjzJVXAyBRQAMrGQSkgvtx
 1gWRoSIx7JVREUPo7djumwjwyciR3V1cL+IN73VY/cZhrFXruwoRIGc7sLCVim3qTEMl
 h5bg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXiAf1FYmTIC+ps2DAvC0NNr62prkKRIN545KM4JNGO/8vo716drvNSFFmVsPFKiS/2iwuo5io=@lists.denx.de
X-Gm-Message-State: AOJu0YzLIwQTUQkfpr8Lv//RTD7/ImpKaSQ1sOnX+BKA1t8SfJ+5qNU5
 ukCaVy3CnVt0jSK5Q1tyGhvyjpp1Vs0/MMDYS9jw7L+M3LxTq8y2HLaLcP7MC9g=
X-Google-Smtp-Source: AGHT+IFo0ixyFF341TIx7Q1rxyyoZCik2x3JcLBUQnB9vmNY0YCLdEaSYeZmppqbK7qx8ZPJK/ELPg==
X-Received: by 2002:a05:6402:3496:b0:5a4:622f:63c6 with SMTP id
 4fb4d7f45d1cf-5bd0a52c365mr1798473a12.13.1723220975725; 
 Fri, 09 Aug 2024 09:29:35 -0700 (PDT)
Received: from blindfold.localnet (84-115-238-31.cable.dynamic.surfer.at.
 [84.115.238.31]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5bbb9eab248sm1029687a12.50.2024.08.09.09.29.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Aug 2024 09:29:35 -0700 (PDT)
From: Richard Weinberger <richard@sigma-star.at>
To: Richard Weinberger <richard@nod.at>, upstream@sigma-star.at
Cc: sjg@chromium.org, Jixiong.Hu@mediatek.com, marek.vasut+renesas@mailbox.org,
 patrick.delaunay@foss.st.com, ilias.apalodimas@linaro.org, seanga2@gmail.com,
 trini@konsulko.com, upstream+uboot@sigma-star.at, u-boot@lists.denx.de,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH v2 1/3] ext4: Fix integer overflow in ext4fs_read_symlink()
Date: Fri, 09 Aug 2024 18:29:34 +0200
Message-ID: <39167592.RpJgFE2GTS@somecomputer>
In-Reply-To: <04ba0220-864c-40cf-bdc4-73ae6137b704@gmx.de>
References: <20240809095430.3656-1-richard@nod.at>
 <04ba0220-864c-40cf-bdc4-73ae6137b704@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
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

Heinrich,

Am Freitag, 9. August 2024, 18:13:27 CEST schrieb 'Heinrich Schuchardt' via=
 upstream:
> Thank you for pointing at the problematic code.
>=20
> You are calling __builtin_add_overflow(int, int, size_t *).
>=20
> __builtin_add_overflow() is not defined in the C-standard.
>=20
> Is there any well defined behavior for this on systems where size_t has
> more bits than int?

https://gcc.gnu.org/onlinedocs/gcc/Integer-Overflow-Builtins.html says:

Built-in Function: bool __builtin_add_overflow (type1 a, type2 b, type3 *re=
s)

These built-in functions promote the first two operands into infinite preci=
sion signed type and perform addition on those promoted operands.
The result is then cast to the type the third pointer argument points to an=
d stored there.
If the stored result is equal to the infinite precision result, the built-i=
n functions return false, otherwise they return true.
As the addition is performed in infinite signed precision, these built-in f=
unctions have fully defined behavior for all argument values.=20

So, I don't really see a problem here.

> I could imagine implementations just copying an int to the first 32 bits
> of alloc_size and leaving the other bits untouched.
>=20
> Hopefully your C-compiler simply refuses to compile this code.
>=20
> I would prefer to stick to standard C:
>=20
> alloc_size =3D le32_to_cpu(diro->inode.size) + 1UL;
> if (!alloc_size)
> 	return NULL;
>=20
> Here an overflow can only occur on 32bit systems.

In this specific case we could avoid the builtis, yes.
But I prefer using __builtin_add_overflow() as it offers a generic
and bullet prove mechanism to avoid these kind of bugs.

It's not that they are something new and funky.
Other projects use them since ages.

Thanks,
//richard

=2D-=20
=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8Bsigma star gmbh | Eduard-Bodem=
=2DGasse 6, 6020 Innsbruck, AUT
UID/VAT Nr: ATU 66964118 | FN: 374287y


