Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07F5ED185CC
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 11:22:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8290D83B87;
	Thu,  8 Jan 2026 12:21:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RgEiUd0V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0107C83B8A; Thu,  8 Jan 2026 12:21:58 +0100 (CET)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E618783A26
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 12:21:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-78fb5764382so33731807b3.0
 for <u-boot@lists.denx.de>; Thu, 08 Jan 2026 03:21:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767871310; x=1768476110; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O+ONvMViwUrB3XgtPY2SBYXi18SvVV/iCn1HMPNhJLk=;
 b=RgEiUd0Vl3fNJjiMrqXwguuKTiBk0Rv0d4c22V/fJp5RK0M9NCHocr91DAvejlhcYq
 joSWCYg3YFTMJN3/8pv5TtJuwpy1gAWeiadujMvduZ+OxmwRBKHXq6cfWha1ucOP9bKz
 9MOy6IMPlYbSNGSjS/m60Id/JW5CLxfGtpeAHy2N/4Kkyo22ZYpta7dQ56I4+DK4z91Q
 NLUjnkFQGHzhQuNTjUOB/iGd/8F1w8zrF5wo5emAh1IvNwLG+NVNrbZVVGFt8q9WUWYZ
 i+qvT/1ZCo2yIzeVp6BG1sZlsQvdBLhdzKEaj6qdyklj6eRofT4fdcedoaK/jdVG13X/
 r6Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767871310; x=1768476110;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=O+ONvMViwUrB3XgtPY2SBYXi18SvVV/iCn1HMPNhJLk=;
 b=eIXM4ssT6wnHunndVEKxn6yKIW654ZR/Lq1VCe27oGo0M8rdSMg7fS4AQawDAxBVgt
 wPOOn5sNN/s9Yk8uN/BrNZ+scy/XzBiuIsP2UAZ19MVbq2eLIvgXF9Lny+1W9yDDnZbH
 ddeCSyB2QrDgAA+yVJWz3yWdfQLPyEuK9JlKrrD5i/Q5Q8TurdPC0UKZxhv4/thWSkuU
 Z2GL3Ty7ZSNgSj23NKBOweyXEUkTVPgVmWUwd+K2hgKEV0FpnkLJvAgffRbbVE8MuaQP
 SCDTrQasr8xqdzZVh5cEguOFJvCkcxdGPrtEKJCiBUhitqXOgCKpV5gAFhG2TdSrjuCE
 9K3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpslfK5CrhiCWpl6EZpLOASWOyLV9n0vVNTS31DZwG/q1ywOlxCgeRftdBY2Bd5X0XzquSsAU=@lists.denx.de
X-Gm-Message-State: AOJu0YzBD7o97YzpyErgysLgNPQySSiGHxUZHr6Eo150dOmfTK7eCTQ+
 nqjk+JR6s0/efMZRyBCA2QENTPk/MYCpO4aTZE/k60kNbRxxSoSaW5TRTDinV7KIqxNhGle8S6/
 2eGtLGsscaXP3nA4hmnh/rH1u/eOB/sY=
X-Gm-Gg: AY/fxX5yeyBfTqmhsZK5icwhq4oZpWFbyUdqg2VL/rxUTShOSdQ1V8AQtAgQRqfUnrd
 aTEM061ByOZEqI0La+IVvfsftVuoa0R1dSzUjslov+9qt+z0KEkCuxxtiTakXndbki0ZDt+A5qE
 votLazXUyF/2QfpIH/B6/kKeZIgTtvqVPOsjtzdloZgHDOGlMIAqMaUchTl9spdqyBkAgQP5l/G
 o1kOcFhNEpIiKGVL2ZQnx5yeNsBn9rOwCXZWcxg8T74wWXmgdHbbKxTLXISJ1LYsQ5SYM/8jgFt
 DAHzOAZVZAUlnsYz3P+Xi4lttyA=
X-Google-Smtp-Source: AGHT+IHEOmLlTE67Z3nS8Ivy4uUGmGtsK+BRmgTMx4NkDc8yI4aUopHQ8wocjhG6BahWKaEW1+3A8Niav6dqeL+EmKM=
X-Received: by 2002:a05:690e:bca:b0:644:2e5b:4117 with SMTP id
 956f58d0204a3-64716c63b08mr5331429d50.74.1767871309703; Thu, 08 Jan 2026
 03:21:49 -0800 (PST)
MIME-Version: 1.0
References: <95beb49733a28c7695dd0bf026b4ffe8c3fc73e3.camel@gmail.com>
 <d9978b24-65d5-4f8f-8ef9-e551c5baf9b9@ew.tq-group.com>
 <6e24770b-ea18-4678-90ef-6338bd40b147@altera.com>
 <CAOMZO5DSf=ViRb-3Z8RWKFiN+P37sk2Wds0Evd9_Gt0nbekc3A@mail.gmail.com>
 <c0809c43-5efa-4150-ad29-497b3b0c8fcc@altera.com>
In-Reply-To: <c0809c43-5efa-4150-ad29-497b3b0c8fcc@altera.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 8 Jan 2026 08:21:35 -0300
X-Gm-Features: AQt7F2rnHVeRpTjykMaODQoQ209iQlAnlrL9s8bEtf-3qfcrZCm23Uq6UOyUfCo
Message-ID: <CAOMZO5DuyO_vTJig9w1WaLhYe81oq_1z9VzabpqRNZnGMmAGPQ@mail.gmail.com>
Subject: Re: [REGRESSION] mmc: "unable to select a mode: -5" on i.MX8M/AM62
 platforms
To: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Cc: Max Merchel <max.merchel@ew.tq-group.com>, Vitor Soares <ivitro@gmail.com>,
 u-boot@lists.denx.de, 
 vitor.soares@toradex.com, peng.fan@nxp.com, jh80.chung@samsung.com, 
 trini@konsulko.com, marex@denx.de, tien.fong.chee@altera.com, 
 balsundar.ponnusamy@altera.com
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

Hi Tanmay,

On Thu, Jan 8, 2026 at 8:12=E2=80=AFAM Tanmay Kathpalia
<tanmay.kathpalia@altera.com> wrote:
>
> Hi Fabio,
>
>
> On 1/8/2026 4:38 PM, Fabio Estevam wrote:
> > Could you please send a revert?
>
> Here is the revert patch for commit aebb523a2381 ("mmc: mmc-uclass: Use
> max-frequency from device tree with default handling"):

I meant a formal revert patch sent to the U-Boot mailing list.

Thanks
