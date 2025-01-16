Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE039C02180
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 09:44:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20A0380283;
	Thu, 16 Jan 2025 10:44:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="aB613KWs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2B9480658; Thu, 16 Jan 2025 10:44:13 +0100 (CET)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDB5F80214
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 10:44:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linus.walleij@linaro.org
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-3022484d4e4so7290341fa.1
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 01:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737020651; x=1737625451; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JTFcstRQ/yurhsDqr4MosEJwn9D5VW3DgKov37ZxLrY=;
 b=aB613KWsL99OF52Lwt7aiZl2eqJb/f5y+Za04yyekqsKIQq3BTNaWiDzLWSyxqMJCp
 5Q+pC+rdSfkqZFEUn5wwp9LyRNPstPcPc0EA/2w+mTriKs5ePprq31uBlDWmp/XQYNbY
 jvtzSJxZsy7xDtCOS6SisbhfP9gsbYTYPwVpQZRnuEYqo7ev9nHJ0HwOr8s8R3Jq0I72
 tsbKy/0xutLXXORWm45YqhzT2niIWV2st67NUP1S4R3eeUdwlGHBOir7pP47KuiSRWGx
 gX7ErFP+c1f6UIbjBEZZTJ/u5YQjQ/k3freXp1WTZusI+O5gJysOEgMQ2EjN8mL3JJXw
 WV4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737020651; x=1737625451;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JTFcstRQ/yurhsDqr4MosEJwn9D5VW3DgKov37ZxLrY=;
 b=po6tZawTsY+y+J8qhrTRuSnAlZJt8HyBANxNKIexSPjBErUwDQfcVD5d4+UldDMarw
 0M/9ThzGexiRzQ4o81U5OOyhkufrjcXyvdv64frs0OEWXoB6atmUDotgqKPr/J/yP8ll
 3tBtPp3fFB4Eo7W1QSfu9z3r09BmkSfi+7TkDctA29SvuexnmPGvKJbaRw8oCUlNhPLu
 VZlShn/EYyGjxR/JwSwqTqeNt5BZynbze9D9vsFwRGn4dKILjChGR7CAO2SR4DDs25t2
 Dlr00x3XjKCEtodO9HX1mdVqQKhFzBwHf34swaxz/E/3MHdDqdfis4Xml65hTr7M4SZO
 MO7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUpqMtIAlyd+WCA5Onv8Eou6qklbXivb2QVioHtg0vYF1Xe7vRAlgjCvcrcgRQb63cvdFA9sQ=@lists.denx.de
X-Gm-Message-State: AOJu0YxyaPfrHsc3tMoUg04uRSC/PfSOnt+sSlQSPE4zpEcxdjdmmFDz
 8vVQFdGyJ/1fkWQi0/hC8A7rGSFghJsAZk7xGoII6Pigosf6BSTa2gfKUPE5m/WUfwKRZEsz88Q
 Vz6/ZIuf3BK0WEhcs7Qb+jWQ+uuBIoCsrSElg7Q==
X-Gm-Gg: ASbGnctSc79fjTgutFfxm00VrQ3OGEHDLHJDnwZ8D+kBm9G8rgYBicqx+pKkd2zD9+T
 GQjkz6ImKNDn+/q3Y9ypNWqraB0TpItkzvXLL
X-Google-Smtp-Source: AGHT+IHaTP/xsF6uzbxQMGDfUc2yKvWdxXfcfD00dKGYvGJ2drpWG4uwd/c69M18qfM9HaFdiRWjisw1rcx0aT27gYk=
X-Received: by 2002:a05:651c:b0e:b0:300:38ff:f8cd with SMTP id
 38308e7fff4ca-305f4546fd6mr118780841fa.9.1737020651036; Thu, 16 Jan 2025
 01:44:11 -0800 (PST)
MIME-Version: 1.0
References: <3d64bf095ad00a79e185ad034c0a8accdb9f2a15.1736954361.git.parkch98@gmail.com>
In-Reply-To: <3d64bf095ad00a79e185ad034c0a8accdb9f2a15.1736954361.git.parkch98@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 16 Jan 2025 10:44:00 +0100
X-Gm-Features: AbW1kvb8w_Jz71S_TLJUdnFHf5w5DDOJoDdINyqA775s-pnwJBeparlop98GR3c
Message-ID: <CACRpkdb+FmqEuV2uTNZs3vuXv2m6vmjXmbN3UNneP2c45YbPfw@mail.gmail.com>
Subject: Re: [PATCH] vexpress64: Fix bootargs when building without NET
To: Chanho Park <parkch98@gmail.com>
Cc: David Feng <fenghua@phytium.com.cn>, Peter Hoyes <Peter.Hoyes@arm.com>, 
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

On Wed, Jan 15, 2025 at 4:23=E2=80=AFPM Chanho Park <parkch98@gmail.com> wr=
ote:

> When building without DHCP/PXE configurations (NET disabled),
> compilation errors may occur due to mismatched bootargs.
> Ensure bootargs related to DHCP/PXE are not enabled if the
> corresponding commands are disabled.
>
> include/config_distro_bootcmd.h:443:9: error: expected =E2=80=98}=E2=80=
=99 before
> =E2=80=98BOOT_TARGET_DEVICES_references_PXE_without_CONFIG_CMD_DHCP_or_PX=
E=E2=80=99
>   443 |         BOOT_TARGET_DEVICES_references_PXE_without_CONFIG_CMD_DHC=
P_or_PXE
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~
>
> Signed-off-by: Chanho Park <parkch98@gmail.com>

Makes sense to me:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Maybe expand the commit message to show how the current
config strings for PXE or DHCP boot will be passed on to the
actual strings landing on the target.

Can we enable both PXE and DHCP at the same time? I hope
not because then the result will be a mishmash.

Yours,
Linus Walleij
