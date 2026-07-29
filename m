Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D230EC53219
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 18:39:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 643376070D;
	Wed, 29 Jul 2026 18:39:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QtN1ftZZQJBY; Wed, 29 Jul 2026 18:39:58 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9188B606A7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785350398;
	bh=d0j0Ldfes5BNDb4rU7rUu5JZcX5gOfPTsZZMo+htt9E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=trPGTMMqtKXMhA9eNqEYhLd0Ht60DgxyFuUHbUxqf2r18qhfcFMKHRQCqmjgXOTX4
	 xzm6eAs2nOHY1HC8JgA4/4/T9Z6E2MEGJqYmjY0rq/hLo9mYvtMcGmiqi7azfPn5gn
	 KqPUOWOjSF6cVhjgi5jcbKqXLzKgwAuC9GZnxYLA6RTM0KMwlFaxqT5ioUlMNNZOni
	 LG5GSrdoVo2HPJm6oJ2oeiKk+1DS+YFtd77CftbBDZIEYLmsoOrUGsukq/fpMXbY6/
	 +0uRXli8DjUldfGs95Z1OJouYEhCI37W6GIA9ujHo9js6enzRsr29wsBgbnGVfvi/c
	 5e9/HoXr4Cm8w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9188B606A7;
	Wed, 29 Jul 2026 18:39:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id CC6C4197
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 18:39:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C9A7F606A7
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 18:39:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3ThDZ1byYYJY for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 18:39:56 +0000 (UTC)
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=festevam@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org B117660671
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B117660671
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B117660671
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 18:39:55 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 489A68493F; Wed, 29 Jul 2026 20:39:53 +0200 (CEST)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5899C803F6
 for <u-boot@lists.denx.de>; Wed, 29 Jul 2026 20:39:51 +0200 (CEST)
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-5b14d1f9315so1026340e87.2
 for <u-boot@lists.denx.de>; Wed, 29 Jul 2026 11:39:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785350390; cv=none;
 d=google.com; s=arc-20260327;
 b=afyD8toJ5S0HbGGwiNS+6aabZcViQtH4kvfWLkcHpwchRrKPF02u47Fu7LiEtNKyp8
 Fx9sDuLvQyCTDQyYBM/d+QH713qEi2H6f8r21j+mAs23HljAWCcWgXtmtk5ehNJy0P7Q
 R2/AT5UyBAHjI2Y3P1aAITYNrN9Fo+bQaEyoAfgkLh0tfQPj4qIxM6WQ8l1LEh0I3p9R
 Z3vYfBWTHFEf0FRVU9fVZ0q8H6UqaNAIDFBiR1Q3C0TR/rqLUlZWbAW8T6F9ebluIZNj
 e0tEvNk3PgiwZPwC3P7YvHIOUgVFGgLCdBo7hymRfy0GgskQAXm7czucV8J6pNlnZKHq
 Nx0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=d0j0Ldfes5BNDb4rU7rUu5JZcX5gOfPTsZZMo+htt9E=;
 fh=noGX9WST+NzpXQai90BC648tcNel1TzzqMuAatYW5+E=;
 b=n1ggQCpjOCw6W4DRLg2CVMaHpz6hZID78hL5HgqGxVzyht6qDfMnwThG2MthiRkU+/
 cMDCR9G5IQ1xSvVNuF31PY5YIukclIH+DSL9c8KjaYtJDm/Gllklw+ibntWpPj4+Ol9G
 Xn8BsJwMoM5asAVqdcaH8vukdBYZiMmz8f6P0e41Tk7F4HVT0NtF9ZDhz6Ai6CaH7gjU
 As1czyp0IIp7Z38a5ea8KI2DP72xedzGTAtjhAWlHh93aTUB/h66/EEghKVpfvfP5QQl
 tK+Wl6jKiuYTNmQm/uRno0+0VmWyrOx0aNNFHTpVpUbBhivfYjy+whdi4+eUV/qk6/fR
 bTGA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785350390; x=1785955190;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=d0j0Ldfes5BNDb4rU7rUu5JZcX5gOfPTsZZMo+htt9E=;
 b=Ke2WG2jzlxo+ia/41fOvek5KQ0sExCwEo+BgGDXwU0OuI8rMGT/Sua1dXCXtuksrRY
 mEN0RP0YUdJ1K1jz8q5ahpcXH+QNks5mNAjnjA8PoogNeYghz+wox2fe4ZzrH9paTFr0
 3f85C6hWGoU7QEhRZazCMwXE5631VBi7ioSgnNLlt8ld37/aWh+p+VlutgTwpkiuOMUV
 EBsiVsCdiapOkHLFxF8qn5LU3k/q+tPxcQJO28n/INQRfl/Xq8IYJy4EW8e00uDm7UVn
 qX8qwGDKiPdm9BSW54FwUEGlpITQNNzdwtfzqpM9JasoPkFSd7WkgiuvAv87JUnjX5sb
 lMjw==
X-Gm-Message-State: AOJu0YykW4GJL4OZeux+I2RBwQPnRrTBxbj8zgteK8SxLGo/Iut0Gx8k
 QWUp3uCtJ/y15O+oCwapH/Z9PgNcw/yA/qzVzIVmGDr2abp3tMip/IgKx2zuQADHlCawtzlGTCZ
 ayk8ue5NwufH4HBJ6viDv13jcxeO3RqA=
X-Gm-Gg: AR+sD13twaqgzv0cpf7A2c0+lTs7E9uMDBW1JccmMzaOUPN/kfIUl33wotkYZ3xaw/O
 aP2uB6ISFTHcvKHl8jb9tnCDHaluT2AIcl4eIf8FgtKpQynV8UYE4MXT8twzBbnay3s8fPJqpm8
 uyNmeIFGVyoYvkV49kGxYlWZ15Mi69yBMLWOUtWILWEblCcmc2HJiRXkh56551AwMz8824sL+HL
 NA1JX3XXnVKc5Jes0AEInMYtWo8jsmkqvjdAxVr62NjKxhjonzsYNioJA1rbXcnoc6Sqb0Mwyef
 TvOSUmYamx5/ZciZ9Uu7h+zW2yTpDhOrLpvbA/+co2xagYszU/tGB/jTzCcj1rVwH3F427MW2Cc
 xJOIWN1n73zRMAGK9GOvJZC8UvY9JnvG2yJE=
X-Received: by 2002:a05:6512:33d1:b0:5ae:aaa8:eb1c with SMTP id
 2adb3069b0e04-5b2d02136c2mr1494070e87.8.1785350390174; Wed, 29 Jul 2026
 11:39:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260728172659.387624-1-shofiqtest@gmail.com>
In-Reply-To: <20260728172659.387624-1-shofiqtest@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 29 Jul 2026 15:39:38 -0300
X-Gm-Features: AUfX_mxyOZ1Gr-AizekFrEJ4M6_zTwvAsVtGC7t_ISQfMmpYRjPaBPzfXlAfjR0
Message-ID: <CAOMZO5Ca-0xisa87dQ2ssz6+8vsVg2EB0yW9+2-6WegdsicXPA@mail.gmail.com>
Subject: Re: [PATCH v3] board: imx6: guard LDB clock init with appropriate
 video config
To: Md Shofiqul Islam <shofiqtest@gmail.com>
Cc: u-boot@lists.denx.de, Ian Ray <ian.ray@gehealthcare.com>, 
 Wang Huan <b18965@freescale.com>, Brian Ruley <brian.ruley@gehealthcare.com>, 
 Martyn Welch <martyn.welch@collabora.com>, Heiko Schocher <hs@nabladev.com>, 
 Lukasz Majewski <lukma@nabladev.com>, Stefano Babic <sbabic@nabladev.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785350390; x=1785955190; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=d0j0Ldfes5BNDb4rU7rUu5JZcX5gOfPTsZZMo+htt9E=;
 b=gUep8blp6N1n6aMBEbZLaaTuijssW31XiqJLllZsMn+Sovrd0unBOq4/DGWHqU2tDV
 Dln3fUvcS9oXYlHVB52S8BfYtxKE7opV/Uxu+0nhjfggBgOJZjigvZZGPehg/7yHFzEn
 FvwI2CvmuihwiotsNMImq3ElMmt3yBmEO50znfzUNwnIkW5JYW73TfYXRf9owLDsrzLI
 rWXnAajDhCi0PPypq1t8r4kQJ2SgF5ZH0GEEa3zcNv211jJAGHplHksCUaVfPzIdstxR
 qLSJoATVbzjTLfJW2iws6JI1KcBTPC++Vlz6cjphx9eVSr5pdwjNYdO82iJ6I6wGgIYc
 c8Dg==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 spf=fail smtp.mailfrom=gmail.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=gUep8blp
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=festevam@gmail.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="gUep8blp"; 
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

Hi Md Shofiqul,

On Tue, Jul 28, 2026 at 2:27=E2=80=AFPM Md Shofiqul Islam <shofiqtest@gmail=
.com> wrote:

> --- a/board/ge/b1x5v2/b1x5v2.c
> +++ b/board/ge/b1x5v2/b1x5v2.c
> @@ -320,8 +320,9 @@ int overwrite_console(void)
>
>  int board_early_init_f(void)
>  {
> +#if defined(CONFIG_SPL_VIDEO)
>         select_ldb_di_clock_source(MXC_PLL5_CLK, MXC_PLL5_CLK);
> -
> +#endif

ge_b1x5v2_defconfig does not select CONFIG_SPL_VIDEO.

What's the motivation for this patch? What exactly are you trying to solve?
