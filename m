Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74367FC72C4
	for <u-boot@archiver.kernel.org>; Sun, 22 Mar 2026 13:29:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03D1D840BE;
	Sun, 22 Mar 2026 14:29:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ajoq0K6t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7ED29840C1; Sun, 22 Mar 2026 14:29:52 +0100 (CET)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95998840AB
 for <u-boot@lists.denx.de>; Sun, 22 Mar 2026 14:29:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-5a27eb8311bso2069933e87.1
 for <u-boot@lists.denx.de>; Sun, 22 Mar 2026 06:29:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774186190; cv=none;
 d=google.com; s=arc-20240605;
 b=Q7diLvOYOFdfBiwBjozSLPRxXYosnh+ExojoymbyzSBKP08KJwMPXNfbiLKbZ37SrJ
 HPLlA7F8RUmjMk01IKdqbyl6Dzrb433qUakIDkC97ih7lKF19Uctx6kldx+mwG2YlJVv
 wRcfcU3LRBtNAK2/sjJPJnJhac5QSi6w4bDimbGwgl3T8zvF0aSaKrbuSV6WVO3eShGr
 Mf07TC89xb2dHiGMqRPehTK6tE/Xf0vEMr2DVUedAEMmyU64doiS+Z4+Nz9Yk1fbDTF6
 mS5EvPTQik2FnSNmQMKhPv+NcxAOlVoqO/65Vpk+7GkwL+OPEcvs/riEZhPe4MJkeQBv
 24CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=2R7hR4WtB9JNfkCnsfcLyAxbPd4PIG6LLr+l8irhA/M=;
 fh=Ngq8M6TJmWPXNNjZIAnXvI5Y+JC5ZoVwg4erVnylrss=;
 b=Ff65lpvpsiLg3gA5SETqTihN70CRgEWlPBujtOj7cTW35Z0l0JhQ5RQdb+0w9H6zrN
 J+v7XWOHOI7s71mJIZjyZdIdP1npUse7ZhBZMQqNWYVCpNOzT7FvVHGRAoTyYVxf1M8D
 xs6kld3+NTYEuWk8TvcLrF4JmDsO49Dhb8Fj+Ucm9GrremY1GC38GPqDfVFFHbYsqZ9I
 Mqnbx8ps/cXWVpDLaf6gLugTzFwSWozV5fswOuKHe2dmDtBnc9dqA7WbxDC1unGT5jC7
 BYL7f+bJ10f+zTDRgFahJGv0h/363WZVH/kmRIDO+IyIKLXlsF3gCrwJ11p8bUU+6Qlx
 Nrqw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774186190; x=1774790990; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2R7hR4WtB9JNfkCnsfcLyAxbPd4PIG6LLr+l8irhA/M=;
 b=Ajoq0K6tPlbCCFRsoTeC4wd8rVT3PHhBVJbVOOHW50IAX/pDN4tST4GVAgIXKLq2W7
 S2vqnK4wOcNoGOgAQZmT++v2I912tPkr9aF+gvyn3xkIp0yG3ZARbmniGzhz8mRXPTcn
 4oGrwmHhFU6vijkTiEX84OVgQr/GV7yweiqvEDoPnaJFNDDTVQfImbB2NWA3eFSDc0LO
 Fu4CJXJBUcRnRCLbcet5iVqu1rMnXK0sTcdsXsHEcNoOEe0uW+c7maDktctExdGYAXk3
 u4rtdTJU/UdCbi5D4bC4r+cvNLU8mkB6ZRsoeLkhXhYyH8SZHYyH8y5my7MZ2eqK6WLL
 ASVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774186190; x=1774790990;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2R7hR4WtB9JNfkCnsfcLyAxbPd4PIG6LLr+l8irhA/M=;
 b=VgyuECv1/bULLt79bPOWPr1n+29cPRNNmKXrXXZ3vLlXLtSFhlXYs66i0d6MWWe6m8
 ktJn/iB/WpSC7be1SL/zlVbMDZPh3XFuIWw4HVjVLDKtiz++6CHyORLy5Rr59Rosr95j
 ItofbkjdyRf3OXOV3ir6fvVnR0iUpLDeCY6e+thaAJ6XvGmc1zBbUfFLAZO6shRrhu8G
 eARke7VPPIWdfumjzdS8TfH6/vdAspnkRu8a7AML6ydDfBQTjUE1VslEJhdLIDeVaD/b
 yeaNnjml6Bi9R2lJrzWf2YYZ3VJy/y6az+r8I/P4/85L8d0yHAcOTT199wDgA9IpfvyX
 YxWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXxDtgYM04Ik/5HQ7r5j+Cwno0cXJ+4j2Cf9DZUolGBXSuAWTUCok5X9tprRs5hIqL5Y/GHMh0=@lists.denx.de
X-Gm-Message-State: AOJu0YxjdQGfYzH1fJnj8OBWpMec+unBxpgQpUmHGrCKum2h4HHuMJZS
 cKbZ5xK0LZ7eFJjQ7O4GTbWcy7ciKgMsDD4Ic1rZYlLzn06kI4eN6HUdqf6zTtxynez3wYjlAEn
 dFULY8Efy9ETbG66fDG+37pcPfhWddD0=
X-Gm-Gg: ATEYQzydho9TLOUS92EZncxVCofAQo3mndvM2HzLq2liyyi9kgw7Vd1wKVxBk9aeK1K
 1okSFWaVQkReeIVzcJOqxIHwJ0Rq4yCFUdy6CNf8ZgRrKzUNndZdEMrVM/UWX22AyvSoUb9v6n6
 hswEn9zacykFdlID4z3A51f6wcwPbJUCy2UWKbGdrMuAKJnDK+cmta2LIstJZL+x9IMuT76wlUo
 l45ehHHkwx2UllbAwCZsf8MNVGj7uI6EOI5UqqzLrUPBvQCuGat8+uNZPT4h3Jk4bOjP9sB1emR
 8PmoLa+MIJosuSxGQiS9ECg38nmYfLgarKBPZCPVWGL88CTbpGuDFJUtR+YvumCazZptQDE=
X-Received: by 2002:a05:6512:68e:b0:5a2:7868:eed2 with SMTP id
 2adb3069b0e04-5a285b83ec9mr2780521e87.39.1774186189665; Sun, 22 Mar 2026
 06:29:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260312095711.3219756-1-Max.Merchel@ew.tq-group.com>
 <20260312095711.3219756-10-Max.Merchel@ew.tq-group.com>
In-Reply-To: <20260312095711.3219756-10-Max.Merchel@ew.tq-group.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sun, 22 Mar 2026 10:29:38 -0300
X-Gm-Features: AaiRm505-QYQvirSfwrVAT15-9nis78401up8e22Kun3-aHmjk253Q5efklAxzI
Message-ID: <CAOMZO5BgiAKwTn1N7D4XJWXxLyL2R=OcNANj1Lb1dr6KKbaWOg@mail.gmail.com>
Subject: Re: [PATCH 09/13] board: tqma6: use common TQ baseboard
To: Max Merchel <Max.Merchel@ew.tq-group.com>
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>,
 Paul Gerber <Paul.Gerber@ew.tq-group.com>, 
 u-boot@lists.denx.de, u-boot@ew.tq-group.com
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

On Thu, Mar 12, 2026 at 6:59=E2=80=AFAM Max Merchel <Max.Merchel@ew.tq-grou=
p.com> wrote:
>
> From: Paul Gerber <Paul.Gerber@ew.tq-group.com>
>
> update functions to match common baseboard header
> include TQ common Kconfig and
> select TQ_BB option for MBa6 and WRU4

Phrases should start with a capital letter and end with full stop.
