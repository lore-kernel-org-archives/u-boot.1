Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 973C9D132B9
	for <u-boot@archiver.kernel.org>; Mon,  4 Nov 2024 12:29:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2FC3B88D90;
	Mon,  4 Nov 2024 13:29:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZQ5hNEV4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 55FEF88D35; Mon,  4 Nov 2024 13:28:58 +0100 (CET)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81AA088009
 for <u-boot@lists.denx.de>; Mon,  4 Nov 2024 13:28:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5cebcf96fabso3284477a12.3
 for <u-boot@lists.denx.de>; Mon, 04 Nov 2024 04:28:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730723335; x=1731328135; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KzMRtNjz41ozmWusPUN/YlF27jqwfTEDUkVyZnnXpxc=;
 b=ZQ5hNEV4wwjvtMW6O7VA433LEg+Casl0UyjHfZD8J89iTzWVUE9ztQnmqpNxlO6aBX
 5Y7ntrzPcFTblB+joVr/sCSPZYG5uzqniUI11StlKISlyQF1210u50dfUOnSG6rl0awU
 tvi/Reot4YJjqM5lGyF9vhAVT3UP5NAPeA/032rLT/wQGhVREGFfrzdmQzaV7LLMxZcC
 v5OI8KLnM4DPv5HykJw6Y0HvoCUV2J1TFmmrqyVvaPobYnxdOolBbv5dI9vNxdIV6zdd
 r8nk+adxxNYlKNIm3cjN+c9YVZTJXXUeUN9YHl+ob51CsHtmN4c3mC9pceo5GoDyatMu
 nhBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730723335; x=1731328135;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KzMRtNjz41ozmWusPUN/YlF27jqwfTEDUkVyZnnXpxc=;
 b=Ur0EIlSmIy+CWILaABU8b2q6fEayzG4iumkzgDpXKzWfe7sLRgOjTJyx0IrxCaBp3h
 mF78Y5TpMTvmKMxfjegSYB2G3x4cuViIZBj162qwgzBsBfUG1uZ+G3bwmstBitlB2To+
 FVMsrF7zpjTpDny9aPDntQh59hC45WYmYMbkW6wFPA3ApWH5pBN2k8D0prA4z59olArp
 XAE2LckwPSuKKyhhJXzCCFdsB2gc7cf6oePcuFpG4wlvayEz3O2o+9CyrhvXLH+RpdAq
 9/1CB2QYmIhBhrfonockBhtPJSt6e/xt+sIyloazSODpJA5/lYI2PokCJ01HKhK5K9RU
 LCwQ==
X-Gm-Message-State: AOJu0YyIhtetaKnSfh3ljhykH38fVfp/UPm9iPL9lw5a05aaTnE4WdGz
 EVk3PnbpDy9QTtm4k/f9mdDuhnrLPrekUVgspM2exBFaPRW2z9KGplmpnbdWRifPBdIv5X8vH28
 HPoAy+PmloYlfz8Wsp8GRAXyUBtymEStk
X-Google-Smtp-Source: AGHT+IG+S2mqFxgywfOWfgWEWxL3U5RLapyMqVPHdRKIPG2LcAsqlWkQPwMVt0cbZG4xbm68XU4oIBgBR6jGkUaKDT8=
X-Received: by 2002:a05:6402:51ca:b0:5c9:45cf:483d with SMTP id
 4fb4d7f45d1cf-5cea9687f11mr12173536a12.15.1730723334602; Mon, 04 Nov 2024
 04:28:54 -0800 (PST)
MIME-Version: 1.0
References: <a0da63e8527876ed60cfce25700793600ea2304a.camel@opvolger.net>
In-Reply-To: <a0da63e8527876ed60cfce25700793600ea2304a.camel@opvolger.net>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Mon, 4 Nov 2024 12:28:42 +0000
Message-ID: <CALeDE9P8MpaDnMqTCd=w362=PWAnKO1WdLmHY2CLY9u7YA4yXQ@mail.gmail.com>
Subject: Re: Fedora 41 drops OpenSSL ENGINE support,
 u-boot can't compile anymore.
To: =?UTF-8?Q?Bas_Magr=C3=A9?= <bas@opvolger.net>
Cc: u-boot@lists.denx.de
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

Hi Bas,

I am the Fedora U-Boot maintainer :)

> On compiling on Fedora 41 you will get the error:
>
> fatal error: openssl/engine.h: No such file or directory
>
> It was already legacy:
> https://docs.openssl.org/3.0/man7/migration_guide/#support-of-legacy-engines
>
> Fedora 41 has removed it:
> https://fedoraproject.org/wiki/Changes/OpensslDeprecateEngine

To be clear, it's been deprecated, not removed, this is because Engine
support upstream has been deprecated[1].

> So after updating to Fedora 41, I can't compile u-boot anymore. (I can
> compile it in a docker-container). But this will be a problem for more
> people.

You just need to install the openssl-devel-engine package as the
engine support has been split out in preparation for it being removed
in the future.

> The code that gives the problem is here added:
> https://patchwork.ozlabs.org/project/uboot/patch/20170106191417.6115-1-george.mccollister@gmail.com/

Upstream is replacing engines with providers, I believe there are
people looking into migrating the U-Boot code to use the provider
interface, but the name doesn't come to mind.

> On GitHub I have created a branch that can compile now. But this is my
> first c code in 20 years (only done this on my highschool for 3
> months).
>
> https://github.com/Opvolger/u-boot/tree/opensll-without-engine
>
> I think you can make a nicer/better solution.

[1] https://github.com/openssl/openssl/blob/master/README-ENGINES.md
