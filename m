Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2547DD2ECE9
	for <u-boot@archiver.kernel.org>; Tue, 20 Jan 2026 13:57:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 83D1783A8F;
	Tue, 20 Jan 2026 14:57:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EUqaKo57";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A39D383A91; Tue, 20 Jan 2026 14:57:53 +0100 (CET)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AFDEF83A8D
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 14:57:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=daniel.schwierzeck@gmail.com
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-b8765be29d6so766071366b.0
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 05:57:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768917471; cv=none;
 d=google.com; s=arc-20240605;
 b=ZY5BQi0Juk6hi74s2w2cCbgROP2zijnbVsEJf5SoQmO9lGDgmSbzdKdJH2rZdxOi0u
 t8ttg01da36X/3dvuYxvu50avUyMvrTPcV1gGaL2HuhhRM0MmZy+vtI4mxNFg5JWz4pS
 FKmJMNHssip2Mm8Nya+4eIPYQedrKCxfVFKlu98+Vj88OiJ5jBMpCDsU2IO6ZMsmFKqy
 OhVzVP9XYpWrbWYYBzTpS0zQat3iCCQJ+y/PUxgMzs6fN5nxN7p6dXNPHj5H4yNJE0WF
 VWG4s/8DMgZms1KVTGx+7WjxUVqB1t1+tydfvCSqR7sLDCVl2e0NyygpVXjp95yTCeXa
 4rIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=NDoRFjcTuhpwUHNHXYsvezUPEwBu7WdsJmv8CESUzb0=;
 fh=djqp5RNAivCrQcJ6yn3LZ31udmbcS4HuePKKCFSLxXA=;
 b=LoQ1dYJJ7xhfljqRJRmDfnlr2/EQDHeXNVvoZn7/xxZQ+GZCZ/f95kuVDv2UxFJDP6
 CYCyXVMbZBm+17WtKQK5YEKrnDKxZNpJbPG6l5LLf0frPSogW/GVr9xi1ST9TApvX4Xw
 39Dv0NdWNhYndk00OrSqsAlZE5uTs7TJ/sOCE0AsR8qoJ6hSWAZByZXTOiOpaAAI17FG
 6ejWxZrX5ZxkfM5tADDz2F2JLhgpZ9Pb+nvL5ELJsUHMEDdkjzolk/CPym2PEhv4JoUJ
 pHz1Ksb3e1JLdn9XDfvl+Vwa3sK2oTSHSLyWeTdiOT52iNdrvqAhBR+6afpa8a4s0U7/
 XdOw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768917471; x=1769522271; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NDoRFjcTuhpwUHNHXYsvezUPEwBu7WdsJmv8CESUzb0=;
 b=EUqaKo57M3RI1oH18cu2UPdb+TKgU40K2Tcn7seBFQdcrzte3LeqdkQbGz6ONxjCvj
 SfgbM0eMgGFPavikeZkpZxWeZdolswHF6SoP5c+7ikhuvADhlfs5ah3WGapVUpVvN8sL
 U/Bio8G670JJAJScEBt8hKiNklsHZoYMNZ/wdqhUw5zkGtX+5wYiwJtsCCypS05H8jKp
 viIQUIHoDAV7DFy2de2GzoZookSTHS9atImJQxJv+nQ42W0NH4ax3FTdO5osfZIzupOk
 nP7PqfgRjob9+n6jcLpSHcaGZYCstKKTA72RT9k2mORnleSBOzXW7pQ7RrkQr1hP96BO
 oMYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768917471; x=1769522271;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NDoRFjcTuhpwUHNHXYsvezUPEwBu7WdsJmv8CESUzb0=;
 b=eeKbHJlz8atUvP/5FMh6zQ32tuKGioNGc23z7RdGk1pfKRyX9oaWNuHR9PC0nPHqG+
 N59vPbCoFkq1Dc+cQuy1ZepRl2bU7IOd8VkctautNahVsp+evLguTii2Gpn8e7pRMWVV
 3mD70CoLalOsIFGnVVyIYcqRomAnZoEqRJm5m5XUMn3129B2uLLmYUagca1Ip8v3pQNG
 buoxd2bmWEy3gZO/2mZfoM6QLtxyvNrEX4v/bO5QhgcYCpQ0J+W345tn6MJYP2yVCxr4
 2XJncoJdqkC42VVAFYVDT+svTtQ5rAiOv9rSo8UUhOAcmcCwEXd18R+TlfBpsyR34NHA
 NuBQ==
X-Gm-Message-State: AOJu0YyHiv8ekx1mYF+7g9O0HrD0UUgCBDYKHvadS4FBvcrybeMt6cEa
 Q7yfVPLGAmf6HxL/5AWCwoKa9/buiN5IVaSuyd8t9Rr8SWanjmlunXzRUy5IUjShhdklbrmP4om
 SRXBis6gSstK9LISvGJwu/mGMPIIPbd8=
X-Gm-Gg: AZuq6aIcCcObg8U1nWeaVcWVlDjQ6tejLrw6DCTlH8f4301zPs3YmlC2xePMh2F1gN3
 op81Ch4ZeWrHBIeEXa32b+8V53cmasdiwkiZZtWxrA2n4d1ZFGwPM8HTUe2SVXOuhRPBgydtRBj
 IG64i73auIG8u0qZ7vHJtgHNGhD6xLvoe8snE6g5bkapq5SnJcX93sSQ2YFIfA2eZ00VyOifT7L
 eh/Gn4OAwBUhQUeNG67dwz5/nS+8pkaNqKl0mYoy+2EfNoD+GQZeK46nTPqtWq0tnYmYftQlQ==
X-Received: by 2002:a17:907:9484:b0:b83:15cb:d4cf with SMTP id
 a640c23a62f3a-b8792f51456mr1204960366b.29.1768917470744; Tue, 20 Jan 2026
 05:57:50 -0800 (PST)
MIME-Version: 1.0
References: <20260115222828.3931345-1-trini@konsulko.com>
 <20260115222828.3931345-6-trini@konsulko.com>
In-Reply-To: <20260115222828.3931345-6-trini@konsulko.com>
From: Daniel Schwierzeck <daniel.schwierzeck@gmail.com>
Date: Tue, 20 Jan 2026 14:57:38 +0100
X-Gm-Features: AZwV_QgFQJYSxL6ijwT2N4gtiiG2re50EE8L7b_0RyN-BER-G5lpQIqpTwkj4ZU
Message-ID: <CACUy__U+pTmZb+Spmh02SMu8U+7w5vDTRthCYS690pONCy0B4w@mail.gmail.com>
Subject: Re: [PATCH 05/10] mips: Update linker scripts to ensure appended
 device tree is aligned
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Beleswar Padhi <b-padhi@ti.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
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

On Thu, Jan 15, 2026 at 11:28=E2=80=AFPM Tom Rini <trini@konsulko.com> wrot=
e:
>
> With commit 0535e46d55d7 ("scripts/dtc: Update to upstream version
> v1.7.2-35-g52f07dcca47c") it is now a fatal error to U-Boot if our
> device tree is not 8-byte aligned. In commit f613a6e15ef7 ("ARM: OMAP2+:
> Pad SPL binary to 8-byte alignment before DTB") Beleswar Padhi explains
> that we must have ALIGN(x) statements inside of a section to ensure that
> padding is included and not simply that the linker address counter is
> incremented. To that end, this patch:
> - Aligns the final section before _end (for U-Boot) or _image_binary_end
>   (for xPL phases) by 8-bytes by adding '. =3D ALIGN(8);' to the final
>   section before the symbol. For SPL we need this in two places to cover
>   all build configurations.
> - Remove now-spurious  '. =3D ALIGN(x);' statements that were intended to
>   provide the above alignments.
> - Ensure that we do have alignment by adding an ASSERT so that when not
>   aligned we fail to link (and explain why).
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Daniel Schwierzeck <daniel.schwierzeck@gmail.com> (maintainer:MIPS)
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Cc: Richard Henderson <richard.henderson@linaro.org>
> ---
>  arch/mips/cpu/u-boot-spl.lds | 6 +++++-
>  arch/mips/cpu/u-boot.lds     | 4 +++-
>  2 files changed, 8 insertions(+), 2 deletions(-)
>

Reviewed-by: Daniel Schwierzeck <daniel.schwierzeck@gmail.com>
