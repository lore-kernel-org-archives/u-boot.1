Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A49F8CA5FEB
	for <u-boot@archiver.kernel.org>; Sun, 18 Jan 2026 01:47:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 330E983956;
	Sun, 18 Jan 2026 02:47:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XRv2gACn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C45C683981; Sun, 18 Jan 2026 02:47:25 +0100 (CET)
Received: from mail-yx1-xb132.google.com (mail-yx1-xb132.google.com
 [IPv6:2607:f8b0:4864:20::b132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC89180FA1
 for <u-boot@lists.denx.de>; Sun, 18 Jan 2026 02:47:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-6481bd1763bso3012253d50.3
 for <u-boot@lists.denx.de>; Sat, 17 Jan 2026 17:47:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768700842; cv=none;
 d=google.com; s=arc-20240605;
 b=TJnjNyYejXqE/SfqGcciAVzlv1pOn2iqkzdFHge7kssfP3QQDRrA5/ta0PBuaen2sn
 P6AOdzWOlGaXRfNd8lFCJMPEIUpw6Wbh+JuwvUwcskjrx03fzwccamdBX2Ceqy2bF9Bb
 /s0xe854O5zbJ/hFuVLVvrZMgL/RiIFS1MnY8w8WTFSymmgTA9vLhUjaW6k1KjHTa2XL
 HM3oXqlySmhFIP8BYhrSC6t1Lk7dorRbGaUPZoA+xxCg55DzBPBh949wR/LxSGgwBycd
 ZglGn3uhO34FSs9i5ycy7sEc/cNz0Mtqrg7R78XNUNB94mtdbrOiiGHRS4OOWg5l+1Xm
 2USg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=w1NbWLQQhRJcwLRXw46zNsmDEczfYCgVpwYniWoDaqA=;
 fh=a755vRgfebQCotO1iQkMBP7o/NY1VcDsdZu8e1mt0TY=;
 b=GQpujyJNYUcFMcMozpexqK3pIXKvTbTceUBFVj5ItZpJ0WqbpA/fcTzoVVvkmABbKh
 kACrycOsl0hLRlfThySzHZswfWWDSk2MoPEMu0CCuq8JH/UBp3CRnIeZ3ckitT1qbzLR
 pu6pocGPIrvziviZE1YK/Rv4ePdo+DkhLvl7qrtAcW+VmquYOKR5bSmHYYeaoRLW7yyG
 zfxHOs8duPM1QoRjSf3onSctm6R5ypJ577Uuqs8C2zivwW55+A3fFBmCOHf6Lgjsa+N9
 wE9H2ykgCZ8Zw0TLtPUu7JxaUfcxAIB8eQYX1AHOdudr3qPwpiYyV2byUu6of1Sif8oS
 8qaA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768700842; x=1769305642; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w1NbWLQQhRJcwLRXw46zNsmDEczfYCgVpwYniWoDaqA=;
 b=XRv2gACnbg0kCnN5aQXqgzZhoIHnrAUIqgMrAyevk/xS7jV6D6fURi+CH19dNNVRMA
 FF8SkyveuHw/YY79jWuRBFk6As7mfLAxAp9YjgwI97IEpAQol4zSmuDrcN2ZHNYOBMnj
 ueQ9oXdFxaKb0Dtjjaw/Xx2NzZHwwURrMz66v+JKaBWHXHaZpOmkNQAkOSVrHpyTHuYf
 NGGJT4F3ucFeC/T2MJqMW2pnZfBKlm0WP//2mjlDT6dkmZx7wldy48Oy1LbHcnV25ch/
 pwSIV4+iOPfSJ1mTFRcG1bb5h7kW1W4usNH3KD6P7fUAIE4zew/4r2rNGhdUaKRgCkzK
 DDlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768700842; x=1769305642;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=w1NbWLQQhRJcwLRXw46zNsmDEczfYCgVpwYniWoDaqA=;
 b=ndYJBwtcMiAtVGB0U/YLjUyI50Em6wfuqXNiT7gAwHTUPtSds7aUqoJmtTv2sp7jtf
 L8sf2J0LSO3Ji5DLN9wRvIG3N/nEjcYzL2IPgmZCZB+baDlx2opnm7aOFTf7be6etuQL
 BHyRy9+RqYgclR0uVaV7gDlbYaQRWe4ruonPytGU5reLry9MXe8PtnfscFBgRSSZi5Hh
 Hl7lhXwseebLy5v4jLhIWcvLoaeOUrnkfAPRIH1sjhgp71U0jptJtjqvAHBVHjIptG75
 DMytCcP6hqJM6ehVQUdZpIoxFOqU7DOHDOtcJliZOvjePgxy7VPsE9oS3R9wm7oVThQf
 keUw==
X-Gm-Message-State: AOJu0YyJcXw36BhYbUzkav2b7uP+kiwVfMb0sZE98+iPoMadK8qleA0n
 EiwOzoJgLc75EuiJSkvt9f7hH9gewP4WSzJ2yqcfbl+8HN4a93yxin36xj9euvjZPLw9pnsIaSl
 VLskQPC2TH4GFJNVz5y10KLSpdLds33A=
X-Gm-Gg: AY/fxX52r7M6Es0dpkCRktfV9l39x3r74dtSrCQAHXZ+eSuXNZlW8N2TWbZkJG86dbx
 oSj5yJA041HbZhQILHGX1eS6JFT9eUlVYgBqLqCXXL5oG1RTvcY7hVhnTaSvVK3aQ7VLZ34XD4w
 CuyS17iPBUkuaU8effpaOWdj7eoM0ZP0QN9+GK3qD42SM8gbTUM561mMrnL7sCkvqVqnorabvDv
 tj1iRKGgfUQb+Ox8brndkrR0bqn/ClL/7R88u8a6LJIURH+KKL5LyymZNA/uP/Ku4/JfoNZkX82
 cmwHaJpc
X-Received: by 2002:a53:e103:0:b0:63f:a7dc:159e with SMTP id
 956f58d0204a3-6491649098cmr4828114d50.29.1768700842598; Sat, 17 Jan 2026
 17:47:22 -0800 (PST)
MIME-Version: 1.0
References: <20260113125853.3970525-1-max.oss.09@gmail.com>
In-Reply-To: <20260113125853.3970525-1-max.oss.09@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 17 Jan 2026 22:47:09 -0300
X-Gm-Features: AZwV_QgCHbZuE6uUW6G4MdVU2WsifpwTekeA-lvCWtbjPS9jNtpqOv34nlQuoXE
Message-ID: <CAOMZO5Bnmu3e5eFdJwChmBJSi1WWZqhR=uMzn=Muk5Y218MwCg@mail.gmail.com>
Subject: Re: [PATCH] toradex: common: handle third MAC address for SMARC i.MX95
To: max.oss.09@gmail.com
Cc: u-boot@lists.denx.de, Max Krummenacher <max.krummenacher@toradex.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Tom Rini <trini@konsulko.com>
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

On Tue, Jan 13, 2026 at 10:05=E2=80=AFAM <max.oss.09@gmail.com> wrote:
>
> From: Max Krummenacher <max.krummenacher@toradex.com>
>
> The toradex_smarc_imx95 board exposes three Ethernet ports.
> Set the third MAC address equal to the second MAC address.
>
> Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>

Applied, thanks.
