Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA6C606A332
	for <u-boot@archiver.kernel.org>; Fri, 13 Nov 2026 18:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=nlutJdYC;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=Jcqzyy0Y
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2F12E40E7D;
	Fri, 13 Nov 2026 18:49:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 29myKNCliwrc; Fri, 13 Nov 2026 18:49:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1436240E66
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794595758;
	b=gS47lrZdWk+YLAw5fwBwGqOYF0cYXRqZB5jw8tZSQCTXafFJN3xz/lhJJ7qmCr1jj46L
	 qBEU12UdHTIfCI2tfCtcHvcbi6QcSap9ObkkvGorSVlm1GRut7Sm+M7N+v306+//2WuLe
	 9s7sYcRozHm2FAJ2Jdhy0/Q0GAWjIQEBHudGlXPkl02CfelNdhxz9yZjisxSnR3GuY5Nz
	 22Oe/LICkNH+iP61u9xFu3+SBbzE1vAD5FPfDrJR/i/nJryvf8SHzvGNdvoffpBX8d3la
	 LiHRZcPOYcDQGz5kKO7V6YErBcK8peJyQJ8TF7o9zV1NP5Ryt9OodGDKOKJSDjNJamw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794595758;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=QPpx5P342Lu/+D1OXCp5Kkw/Uf8BqTgnQjdZNgySK+0=;
	b=PuplqboaXtrQugv0HUwW5wrtVO+kCn7ljSXcb5i2GFFIyzV2rgn+fRlosP50XeTgUpq3
	 dOfRep6kyGfF8nws+jf34+W5u4ibkYy1hErvlh6RdiuCOYsh8CjyjRTL5+vGRkUhTeHw5
	 j9uZaDfZRk2I/dlI65xGo224UraUuyYrDBXJRL7XM4WtJ0VIGy5ej6nrV1WJlFdASgPzK
	 70T+6HWMcdayFE0dkJifjE2U21k8MbgO+Ha73mAUPf0JdpAtD/0QG0gLv7AbL12i6P74t
	 yiRpHrMCdNEhr/FDbW7jkLkje+mPS6wI0ON6qeOpf/rkhwZ7ov/cizhvkhKX1hMNWOA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794595758;
	bh=QPpx5P342Lu/+D1OXCp5Kkw/Uf8BqTgnQjdZNgySK+0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nlutJdYCjyqCwz2/43bAtAnmzAYhMZI1eYVg7s3euaomcmNc9T+MeaBsi9iup0VBU
	 Dn0P30VPATxo/e6Vf77UGmaWLj4zHQBQZaYbe/Dki9KToqbgOzk8ZOMHwBSU93ip/P
	 R5BWB64tHJk1ftTvCyui4OR1O49E90cPtp7Pm/86ZPEBRp8dWlJJ1s+x5vzXotIlAr
	 muajqNW4g6JXGpBDTlcfgGjz0UgQkM8iCZhoN5z44Jb5EpZMPWEaDr/0tU7YXuo2wb
	 RNVtELImqfSw5Hb3SPFwoemb2De/9LMeNY1d5joJIg3/yZLmYdyi5OWJtZH2aaomLg
	 ZFDe/NDedPtqA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1436240E66;
	Fri, 13 Nov 2026 18:49:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id F0EF01A6
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 18:49:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D6BF660DAA
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 18:49:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8lUXYZPYtnAW for <u-boot@lists.u-boot-project.org>;
 Fri, 13 Nov 2026 18:49:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2ADA260D91
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32e; helo=mail-ot1-x32e.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=Jcqzyy0Y
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2ADA260D91
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 18:49:10 +0000 (UTC)
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-85c1135c286so1633906a34.1
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 10:49:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1794595750; x=1795200550;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QPpx5P342Lu/+D1OXCp5Kkw/Uf8BqTgnQjdZNgySK+0=;
 b=Jcqzyy0Ytsw04xQZAGzRWSllDLgcvzqI81/WnqIB48SbL+V0NvTuT0us865wlhvE4Y
 fjJspgi4aDYRksCHI4hKd7vLxksGD3RfS5joHx4WJ5KhrMmNAS0x3x2raM2ePKHcaZhi
 fleDBI9SkWpJ//gsBXKoWaxgp2cv2OIlCSO2k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794595750; x=1795200550;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QPpx5P342Lu/+D1OXCp5Kkw/Uf8BqTgnQjdZNgySK+0=;
 b=icYu8dzzV7rMnDf7cHGb5WStOEye5NTNNaxvpVRwYSVnoWoM6nX9p9HvNsn9hnsBlR
 3mU+U+Xru24seASyzuewyrlqa6WYhrKsXTHCZHB7KyvmRWezrbCqOj1AdI9ZDRiixVFx
 Yy3eEYb0Ps0IZQPx1TQzWvu4vkPxd0ekD/cCshFWWEzeUtABy9La29JhYOsCiwax52Tb
 shPQXzYSE4kFAyLlhPxFelONrN2JOT53AiTmN0bfEKZf2GQDLgNO5WrPrB8iIk5TYzmt
 ieNza1SXg4jTm5DMGl7Xv938aS4glZeGtXXa0WoR7lIfQEnTY8jUu0GypotPpsybc70u
 YBNg==
X-Gm-Message-State: APuU4Z8Z59HunfpZw6/9PiC4eCLEsfZp06b90yTBiJlgJHSc4wAmR60a
 IxzDl7iDqtpREUgzrd//Bf3/6rYQPrCwvrFVeBQfRGf2KxAcYtnBwvNjav9xhpWKW08F+22qoJ5
 FByKXMlvV3g==
X-Gm-Gg: AYBFou1jxxASXIhXj79Hji2EY/c+UqJvBzLnXoi71fSl8ZkRJwwPKwXhRPHzmHJ/dtK
 k8qfJr+WwWizS5Q2FYeCmqS8WbqMpFPkRsb0/BGtAk9vWCRBEAJKD9szoe2BEiH7pgXAeSBh4iV
 /OlxzZhuSR4JFb4n8F1Ocws0oth8wUuJh/jGyOw+m4B454bIZNM+MeYhEyqymLF45tqMCuZhJBW
 +TMHsZ/7tC2w171gREc4ecrKklAgk4HHqGjbnv1EGLgc1FPJUR+JHuITELjuMb+7M9Suq024aPR
 IbjUUHd5p6009We7sQ/3bhSlmLVLIfZvZTMY/D2Ayp8t8PGCAMM3KyR4D7my0FmYZotrF/O+l0q
 s37cgH3TiIafpG8ng7Ascjjj4UCMaYdW0enqCgytGROM0azmm79zJSfz3JRbZSUNnkDdAhrtUgt
 PtZNBQRl/5lP2ls94g4w7kpVGPSW05IwSsZqlk5ymMg+vanwInIAMiYMOadU0Lt8WQ9h/aWY/qA
 0BftD++6rghPvJDcwzvrK47TXRGjEbsBP03nGcU1WhHgp72OO1UHLQw9b0Hcibm4AsaEJZEwWoe
 Dp0J+LV5CtsqOEnlgm05Q1gUEcqc9cWi3Umw8cIi4ScMrkeQhM2TgyvYxY9jWV8+1qBwNgEkS5n
 nz7rKxU52irQ06rrOnYS5u7AZwKQTXwJfdqSB5JKulLrKWnWXRY0QPseXQTvB/QmHeCDc8ijVBB
 QEg9EXO7Vvl7QfhqzeHeymvextw/bmBEPuYxWA6VqMOQLz8GOn+vs=
X-Received: by 2002:a05:6808:4f53:b0:4cb:f21b:6f8d with SMTP id
 5614622812f47-56e645df783mr3360100b6e.32.1794595749743; 
 Fri, 13 Nov 2026 10:49:09 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-56e7094aafcsm2747435b6e.12.2026.11.13.10.49.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 10:49:09 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, 
 Josef Schlehofer <pepe.schlehofer@gmail.com>
Cc: Stefan Roese <stefan.roese@mailbox.org>, 
 =?utf-8?q?Marek_Beh=C3=BAn?= <kabel@kernel.org>, 
 Simon Glass <sjg@chromium.org>
In-Reply-To: <20261028121258.572-1-pepe.schlehofer@gmail.com>
References: <20261028121258.572-1-pepe.schlehofer@gmail.com>
Subject: Re: [PATCH 0/3] macOS improvements
Message-Id: <179459574875.1254556.9876275437844934575.b4-ty@konsulko.com>
Date: Fri, 13 Nov 2026 12:49:08 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 28 Oct 2026 13:12:55 +0100, Josef Schlehofer wrote:

> With HOST_TOOLS_ALL=y, the U-Boot host tools do not build on macOS.
> crc8.o does not compile and kwboot does not link. The kwboot link error
> also stops board builds such as turris_omnia.
> 
> Patch 1 links kwboot with the system libncurses, patch 2 removes an
> unused function warning in kwboot, and patch 3 keeps the sandbox
> asm/sections.h out of the host build of crc8.c.
> 
> [...]

Applied to u-boot/main, thanks!

[1/3] tools: kwboot: Link with libncurses on macOS
      commit: af5ea6f9b0cff8720eff993adc2ff445fc0ef8ac
[2/3] tools: kwboot: Define _is_within_tolerance() only with BOTHER
      commit: de2f8355f9ef1a044bf7b6b03205260efdb1e425
[3/3] lib: crc8: Do not include asm/sections.h in host builds
      commit: 3a310b42b6dd79f409850fe88bc75764cf4765c6
-- 
Tom


