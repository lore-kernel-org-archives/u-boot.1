Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F233C44529
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 18:16:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0A36F406E3;
	Mon, 20 Jul 2026 18:16:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id I3UKFp0G31uF; Mon, 20 Jul 2026 18:16:25 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EAA19406BE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784571385;
	bh=WkUXYWKhVsSJvc4fa2PsRIr5ltKRIozQaelaItkSyCE=;
	h=References:In-Reply-To:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=IJj4oMdktsYQqHSKGyrb47zhmp52DHYc9QrClpIlXSEETA68qDOwtiDgfXHGDuyIp
	 Q3VvzVwC/iJsYiVx53Qh4KZ2zq4DiK2lSE8egBXyicMFU7zUgWGxbQI4R2B8Kfij4+
	 Sqj5ZyYwNg8gmmz/KLCC/lRFcqWOV2bDYXdcWHYXmjUnXEJGfYktRwDhNmqShCcbSS
	 8OO9VFbU8fvCHu2LAwD1mRfk5USBJS6wAmB5CIlVr74XxaVUFbXePNJh6cjEQOidmm
	 c/DtR3Hj9VOOMYIzAQEQWuZEqdaobgxN78mp05L3ZMEkXUZuO7U/6B3Z2I5dt0uJUb
	 rEolKTdWjwDcw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id EAA19406BE;
	Mon, 20 Jul 2026 18:16:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id A3A83224
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 18:16:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8968C40081
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 18:16:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1ebaqfvCNndt for <u-boot@lists.u-boot-project.org>;
 Mon, 20 Jul 2026 18:16:22 +0000 (UTC)
Received-SPF: Neutral (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 4C5CE40015
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4C5CE40015
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4C5CE40015
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 18:16:22 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1E5B844F6; Mon, 20 Jul 2026 20:16:20 +0200 (CEST)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 258D880433
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 20:16:18 +0200 (CEST)
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2ccf2360620so63893575ad.3
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 11:16:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784571376; cv=none;
 d=google.com; s=arc-20260327;
 b=XdkUecCENP/7GUREA5cnnJJUOn8nYqndmorcWiUJD2gu0gPKfFZNQEtOZ7gMGCJzIj
 RJ5cYhxFfkaVtANHAsnr8RzHqPKhmtGiIWbDneA7Bi5+ynwrGN3byigfKKa+gqjt5sns
 LlsCAXm0jqioGvORsfcL39MBlk6hRi/nnDMkKPbDx50sD6lQd6QlMjv8l0zOdizzAgqb
 jREapxQaPFz91qhtFv6J+RL+6837t/IplOhRJxeFG/MqHQwO4n98jXgtbirvgD6X/uPz
 MD+sw4pVqs5tz0m2dTMN9aOyr3vKqKev0U9ObQwDtsbXFTVL+aey4q/4n2MuPQSyhMTA
 2ZxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=WkUXYWKhVsSJvc4fa2PsRIr5ltKRIozQaelaItkSyCE=;
 fh=HGFxqjW7EmEVgkuAAKalGIiLGTacmvL3ctiAmCo/d5o=;
 b=mFRQ3mYFaagDGgmOlrX7gmh02eXg4VV8FPN8OQt4iBdM80Um0XmEcaGBR3kqa3lmy1
 SPWAgP4k4GbrFHJKFFqHtx06UNELukEW1t0D2VZkqrnsmZPZgncrfaPcV9rpi9etoBks
 jUKHce56jv4Ao8q51iqLSpW0jFUAmxvM8hGAPyQ+N3xlxmFmr2zePSs5S2l+mqjsJCCR
 GPx50GQm6fUqBgR8cmFqPX+f9WkW4mpQFmLC8o1zA1B3tDWmY116g/Cl4SFwCoSt40Wb
 46kXefKVa8cwc1cD3/u8zmSNwlg+yzkBKaSDqzkw1Ing0iFQfe4PJR7EHvnX+AoaTP4s
 p3rA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784571376; x=1785176176;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=WkUXYWKhVsSJvc4fa2PsRIr5ltKRIozQaelaItkSyCE=;
 b=YbGL8MGQmc4UVdTVqnRBgJJaj8TysQ8pJD+4xNIjNKMzi/M2yTyjkE/ODNVq9DFqDZ
 +ujvxg0yVKv739wlf351JzZGXAhA0caZl1PJRY9o6BWYzKYaUasFlniEQe0/lkV34lLU
 YzGQPKcP84RFz8t4p2MD/kB93MP7W6A6QzAHfw2v2SAiL8MSJA/VHjo+ITQYwXJpBjhw
 6f0xlcVeTBFuxWnc6lxn5lUvGTDAQ/K7TXd9DZEkwRJCDI2J/tLLlEcEuxD/6yMsGTm1
 +/kzK0qYCXyWRD9cKbJl21aaHzx4+bFIByfcUzDd+B62qrnKdXe3JsAC6pDVLxHnZtUx
 Xd5A==
X-Gm-Message-State: AOJu0YzKIuIwnlL5LvmFDYAKHpfUFqFyPYdyRQ3+dJc87o4Aj7FoWwj1
 4bvrmPyE2QFXLvD2HSa8++uH2yANeTiRTol97PLRB3uiOtGjV/Ul+e+Jw8yCsaEbKfr9Omj31C9
 JA1Ac4CXIyEA7AcxIcXcwtPli/mKJDsFEmC4TjTN+
X-Gm-Gg: AR+sD10dKjfTytUZ+uNDiuvlzf3s7tEWg43vM79PlRhFL0UgGUbEzwXaQiL6Akru1ax
 nr/a8f3UpVX/36NduhXcypecwLQPifmbL254Gq7+OU0PZxBPugg/a2u04vts0tpIXGYIA4X5hey
 nnnmAhBSVfvPRWTcY4sBl7CGqj5WcduH3+P+hAzUsRd85wex4GVSeML51HJFXOaXFSm3rwmYyR/
 TqZtQq63Llnd/SBYxOThojjFPmGW2D5DJAqx7Wiaf52i3eVbrump4Ii2ZwZur6qQw3DayAgp8k6
 QiHiFA==
X-Received: by 2002:a17:903:2350:b0:2c6:a981:b591 with SMTP id
 d9443c01a7336-2cf349961dcmr162329965ad.30.1784571376566; Mon, 20 Jul 2026
 11:16:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260719-aspeed_vbios_fixes-v1-0-c94026f28250@oss.tenstorrent.com>
 <20260719-aspeed_vbios_fixes-v1-1-c94026f28250@oss.tenstorrent.com>
In-Reply-To: <20260719-aspeed_vbios_fixes-v1-1-c94026f28250@oss.tenstorrent.com>
Date: Mon, 20 Jul 2026 12:15:55 -0600
X-Gm-Features: AUfX_mygIkAs0aKUPCN1yZG_eoO9F8qQnrPBh0ntf3PdMrL_gv_CBdAogtQRE7E
Message-ID: <CAFLszTghCHV9nERY5FgsyNLqxsF0o9DGjCEZg_HU-9x7jYLcfw@mail.gmail.com>
Subject: Re: [PATCH 1/8] bios_emulator: select X86EMU_RAW_IO only on x86
To: asrinivasan@oss.tenstorrent.com
Cc: u-boot@lists.denx.de, Aspeed BMC SW team <BMC-SW@aspeedtech.com>, 
 Joel Stanley <joel@jms.id.au>, Tom Rini <trini@konsulko.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Ryan Chen <ryan_chen@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Ion Agorria <ion@agorria.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, Simon Glass <sjg@chromium.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Rasmus Villemoes <ravi@prevas.dk>,
 Rick Chen <rick@andestech.com>, 
 Leo <ycliang@andestech.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Jamie Gibbons <jamie.gibbons@microchip.com>, Yao Zi <me@ziyao.cc>, 
 Conor Dooley <conor.dooley@microchip.com>,
 Martin Herren <sputnik@on-the-web.ch>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1784571376; x=1785176176; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WkUXYWKhVsSJvc4fa2PsRIr5ltKRIozQaelaItkSyCE=;
 b=faDOrpT6vRiJJljc4/0NSzLyoAmXqVDB4h3v6yIg0c5Iwzm5PdE+p853VYHtsmaon5
 vhiQgqha6y+N7ZUUMTFvvx6zpk3zvX6JIqRH1olD5HfaUz8p+SnqD7KK/hzBirsrGCci
 4JHl+GSDXB92szTfVVbTj1hjaoh/qUBjjKd04=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=faDOrpT6
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=sjg@chromium.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=chromium.org header.i=@chromium.org header.b="faDOrpT6";
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
From: Simon Glass via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Simon Glass <sjg@chromium.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 2026-07-19T18:03:31, Anirudh Srinivasan
<asrinivasan@oss.tenstorrent.com> wrote:
> bios_emulator: select X86EMU_RAW_IO only on x86
>
> X86EMU_RAW_IO mode can only be used on architectures that support port
> I/O like x86, so don't select this for other architectures.
>
> This was also suggested by Tom Rini [1], but was never added in.
>
> [1] https://lore.kernel.org/u-boot/20241117025353.GA3151182@bill-the-cat/
>
> Suggested-by: Tom Rini <trini@konsulko.com>
> Signed-off-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
>
> drivers/bios_emulator/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
