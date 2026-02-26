Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 637F5FD9E23
	for <u-boot@archiver.kernel.org>; Thu, 26 Feb 2026 23:45:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9065E83E96;
	Fri, 27 Feb 2026 00:45:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="W3SFfRfx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F91B83EF9; Fri, 27 Feb 2026 00:45:33 +0100 (CET)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 991C083D1A
 for <u-boot@lists.denx.de>; Fri, 27 Feb 2026 00:45:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-65c187dfc82so2350154a12.2
 for <u-boot@lists.denx.de>; Thu, 26 Feb 2026 15:45:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772149529; cv=none;
 d=google.com; s=arc-20240605;
 b=ijKaIlXpZ9a1aYEv5ZOW+oHGpi6s/E2wN42GVzPksUnh+bjYSIxDh3eDIdhzojMafd
 9D2ildcIx12fvr5DMyUu7CxH4noDFHjq90XQtdy16Gd+Ub3OS33i2NGDRIKUnwXJi26s
 EZ8kN+78bygb8o4WUiTpMaPX8eZSncc0fIzPQCiKC8ci6LglswXqoYLyiczCIqrOdMLX
 fyKVhvbTVW8yxijr2kqXBYiC9eSXpf/YjIg8LfxX1s99WhdPdB0FEvGJnXUOuFJx7P6h
 bGZ0ZmBVLULsEb9fEglcltDR+cwoCtbjYKwjLWjvTyWujBFauyWumQeOcv2HOPTsIOw6
 vWJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=20ycPyVy/T0yLAvKrToQ87wCoKnYtcZY/AfrIFyzqCA=;
 fh=KxaCEdYOd52nMwKJ6v2b1ScJjDJOLNTS+RcarNliFTE=;
 b=FtlaiXxf5jBX/NwfYJRFbkcPJOGMac7ZZkOzrNLmWrEB8en6vd//1nEz8Q1w77ff+/
 bJ0oH7FHfJJP4U/5fi1Hz83v26sYvmt9HWzr0cXyRV0xpFEqHkji+MXbwhmchTqsgXT2
 ANtD7HswVTCM3zCtawCn7oelVz7XwdoSxQu54rKBp1SZbwDpE/grblBkHTBWs97kTtpv
 gsU5vs+jFT+7fTxA8l0niEDz77dyAyM5BPhWjB63FvMq6PI2xKbyUw5tm7ly5YqobWHh
 sjgdDP0QW0xhA7W0OC7BZK8TD+2SSdJ1eNAffI2Z+/Yqb+RFt41V/AVURLMHLmKUWqxJ
 smQA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1772149529; x=1772754329; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=20ycPyVy/T0yLAvKrToQ87wCoKnYtcZY/AfrIFyzqCA=;
 b=W3SFfRfxSK0UoQBXqih4QpUQzzy0TcftEIrvZCCJvHCVAJHf88GMMWesdCBNQQ/Xg7
 AHY37jcN15Eqk9ijvsr3LCFR21vYK6fNm0gwWTqSI8EcFUdIKTbkZ00UkuoJtfqZDwBD
 hkEK7M7S8CprCkxq9ll09GoRwqe/yk8sshbI4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772149529; x=1772754329;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=20ycPyVy/T0yLAvKrToQ87wCoKnYtcZY/AfrIFyzqCA=;
 b=Zq8vLRzYnmUSQY1dy6sWq2LQvMsBdTZYK4JL05Npnw+y+H6zEv6kUmZncHQ9jqQ7a4
 yMJP5dCPwsbXDwRADi23faARQNpHRbHlhYShKeMMsAmAd8JUfvdXL0Tftb1T0E1gQAxu
 pSInSfHiXXuR4D0n+RcsSezDy2t9saLArQ05b0ITAbYqVxhwTrW6/ViRP73aSK6qCuKg
 1gMiUAbjMi5jAwOStJL3YHvRhW5zoU5aNP5xmVmG9shRWVa3Nev6gR/9G4Xb8hd0pFqy
 MFocjHw7VTe0KDk/bpljA5OOEfvd6LtejELVxgC1iDSt74Dki47/8ZE5vx+6auEj/d9Z
 IXew==
X-Gm-Message-State: AOJu0YyCR9Ay1EG51F/FyQn56OoJV0A66anvcWIRHtlT4x779QmKso1N
 ZNvBFkII6js5QVz1sKgYlzXl3IcRc1jVpaQCERnePF3HbHqDqkFaamZx+lfG0UwZZK8fTo7JVzp
 uliilV6KvnFWfxwKxdDMrPGUc9L4bTgucgH8Am02k
X-Gm-Gg: ATEYQzxFaHPvCMB1qbsX2va2yK9pxZx7jnkk22aFhz6gV2NmKf0eHfHiUTuth1sLPVQ
 k3Mk2wLx73oqIEJCu1UatDbSAUXe2mW2Jt7K7c7RmoTNf2nN5iTDHNIjImxxnXCa951GviJgVuS
 kgkLA0lwtLUR/zqiuy7V4gtI6saz9FmtpCjNdL14rFb46Kcydeww0c91VjU7yWGFX4BYjC7SUen
 itJQZFJde5LdLhsD/iKwT1bKykZGTXAzthi13tJFJJ+foKWnPA4QOFVTx5Sut7zKJGK3N/LJudG
 jjh/rg==
X-Received: by 2002:a05:6402:5251:b0:65b:f342:d1a2 with SMTP id
 4fb4d7f45d1cf-65fdd6bdcf8mr727756a12.6.1772149529046; Thu, 26 Feb 2026
 15:45:29 -0800 (PST)
MIME-Version: 1.0
References: <CAA-ybFQ=DbZzcGq_=HLFx_Gp_D1YKj=oKYXtD0HKPuVYcQyyoQ@mail.gmail.com>
In-Reply-To: <CAA-ybFQ=DbZzcGq_=HLFx_Gp_D1YKj=oKYXtD0HKPuVYcQyyoQ@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 26 Feb 2026 16:44:56 -0700
X-Gm-Features: AaiRm51SGI5ksSDbrHxBZ2tj9iNcqBk17M2BmJfZVxtKSNy1ksx2l7vhzCmOT6w
Message-ID: <CAFLszTisAAQJb53Z9bifbMd9fQL-1iXnmbsyZMRDovAYYF87oQ@mail.gmail.com>
Subject: Re: FIT Verification
To: Nagabhushan D <nagabhushand34@gmail.com>
Cc: u-boot@lists.denx.de, Neha Malcom Francis <n-francis@ti.com>
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

+Neha Malcom Francis

Hi,

On Wed, 25 Feb 2026 at 01:54, Nagabhushan D <nagabhushand34@gmail.com> wrot=
e:
>
> Hi Team,
> I am a recent graduate working in Embedded stream. Currently exploring se=
cure booting on TI boards. I went through some of the writings on github - =
https://github.com/ARM-software/u-boot/blob/master/doc/uImage.FIT/signature=
.txt and other sources by TI. I would like to get few confusions cleared by=
 this mail and thanks for take some time for this.
>
> 1. Can I try out only fitImage verification with hs fs boards only?

Neha may know about that one.

> 2. Can I try it with ti dummy keys or any other way to know if the flow/f=
it signing is correct?

There are tests which check signature verification using sandbox,
which might be the easiest way to try it out. See test_fit.py

Regards,
Simon
