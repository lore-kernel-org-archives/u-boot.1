Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BD31C4167B
	for <u-boot@archiver.kernel.org>; Tue, 28 Nov 2023 19:12:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75DE687701;
	Tue, 28 Nov 2023 20:12:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QBq5rD9P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5469287741; Tue, 28 Nov 2023 20:12:47 +0100 (CET)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6332B876B5
 for <u-boot@lists.denx.de>; Tue, 28 Nov 2023 20:12:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-280b06206f7so995787a91.1
 for <u-boot@lists.denx.de>; Tue, 28 Nov 2023 11:12:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701198762; x=1701803562; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pBUoGqfFBetMnBN4/zKM7JWd9svtpRgDNlrj/tQ9Z6k=;
 b=QBq5rD9P6bfTw3UmfEMYQ5cyHd+FULtYQMBar554tN/QD4Kl8L7i9FmEiuuIOg96oB
 yV9wPAj3ja7B/LxXFVvFn/hlCSB9PIpwCWfqip3NfRYHb3hBlcFPNBmkQlVduyRPfG3B
 Q1fbzN2ZSz84uMztVai9WP3/71YtZjK/LDglfr4KrQmn2tBjgj5Q96/KjXv2PiAdvtOY
 2bZC2x4jPZJMemdjrgkwrQcTFrL/Nh5VW/WizmTJHsAMUIjQv9LwSmtXapHFHwrUAogP
 tzcIJKY6iYBe+d6QhYcXUPW5QCjad/3Afy5AVvMGOk/WF2AT6wYPp9663xgXDpq6Kvt+
 UeVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701198762; x=1701803562;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pBUoGqfFBetMnBN4/zKM7JWd9svtpRgDNlrj/tQ9Z6k=;
 b=P4eZWKAeBkzTegtTD7dUQ4Q2dGROFogBQhTghG0LfNSCl0fwOPbdTcjYc+vMWM90BC
 GJdE/GsiLtPU8mCcYrqNA2p0eULZum17cCqjnF1iTfohgAgcRnTBodoBoiRFqSXxQazr
 E+50F0IB3z19nBLusuKWf7OqwT9wzcgUngxsGxqYtRkWKfR0kufq8P6WgiyZcJRmJdzK
 GS1iqvfK3tLKHhH9ar0nw2kh5MqbRJNRN3wjMWHqcDJnDhIOTJViQBAw3yePxBivConx
 2BhI1XGNk8k3FAAaSQyBAaP/I+KhPxhjVEMJ1vfm0ZPkcgjUahbtLRcMsiMGhWUD3MZt
 wbBg==
X-Gm-Message-State: AOJu0Yyp096GgHD1E4JdLnhpZnG8RPa37KT7gmWvkqK0p2lKhWcvUUaQ
 vf7+5PqPbBxnDcOtfQbo/WPpoAV+BN+x1fr22ik=
X-Google-Smtp-Source: AGHT+IH+y1HrGLUbROLdxspGk9BR+JlFh3DituflmFk5nfnZU67MwbUhzTE8ihNLiGFWpVJNU+bRLkdzrguIlcWIKYs=
X-Received: by 2002:a17:90a:7408:b0:285:6f2b:4e82 with SMTP id
 a8-20020a17090a740800b002856f2b4e82mr16151748pjg.1.1701198762628; Tue, 28 Nov
 2023 11:12:42 -0800 (PST)
MIME-Version: 1.0
References: <20231127125726.3735-1-maxim.uvarov@linaro.org>
 <20231127125726.3735-8-maxim.uvarov@linaro.org>
 <CAOMZO5AdtdHDnpNUkUieHh7_jhxDOtXp5Mtv2ybkTVLamuxO5g@mail.gmail.com>
 <CAD8XO3bLiTsgaYrYUSJgiwfYQGn6C9+=VN=UhxmZOo_c3ox3xg@mail.gmail.com>
In-Reply-To: <CAD8XO3bLiTsgaYrYUSJgiwfYQGn6C9+=VN=UhxmZOo_c3ox3xg@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 28 Nov 2023 16:12:32 -0300
Message-ID: <CAOMZO5BkNQaMxg1b=Rryrvwfbfe5-0sDLiMe8=D9=NFbdZK-+A@mail.gmail.com>
Subject: Re: [PATHv11 07/43] net/lwip: implement wget cmd
To: Maxim Uvarov <maxim.uvarov@linaro.org>
Cc: u-boot@lists.denx.de, pbrobinson@gmail.com, ilias.apalodimas@linaro.org, 
 trini@konsulko.com, goldsimon@gmx.de
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

Hi Maxim,

On Tue, Nov 28, 2023 at 4:07=E2=80=AFPM Maxim Uvarov <maxim.uvarov@linaro.o=
rg> wrote:

> From this log it's a little bit different wget output. My version prints =
"#"  for status. So I guess it's original wget. You can spend time on debug=
ging it but this code will be replaced.
> With my code I tried big iso download and check crc. I did not see any is=
sues.

Thanks for your feedback.

I will test wget again after your series gets merged.

Cheers
