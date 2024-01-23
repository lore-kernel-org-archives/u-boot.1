Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F91BC46CD2
	for <u-boot@archiver.kernel.org>; Tue, 23 Jan 2024 02:44:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8555E87994;
	Tue, 23 Jan 2024 03:43:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bJbxEncv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7710F87A01; Tue, 23 Jan 2024 03:43:58 +0100 (CET)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com
 [IPv6:2607:f8b0:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5CDF587947
 for <u-boot@lists.denx.de>; Tue, 23 Jan 2024 03:43:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6dbcf819511so408094b3a.1
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 18:43:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705977834; x=1706582634; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V+B30mwf9O82znIPlL54PQNu16n+n9bVRImSYOxhpMk=;
 b=bJbxEncvNKXA1OlF3hhfzcn0tWjjqfX4mJ1VhJODv5By6gcMxN5/k7bCm1VGQjFyiw
 114rFiL/RmaETMV/kcFhea3V7KSw6bvRaGfcSI8H9FcjlB82G9rN9V/lnhDV/WamJTnX
 G/Blf65QyVjONtNpLYANI4WbkV5+z9MxSVaBnB5x6PfTbK3r6MwOHNraPuXJjKJ126Co
 JWOR9Sh/VnDfJvvR5D0OV8CFtKWAROcCCDbnlwb2M5vXpIGuFy3SSm2nWRyCnjdEHZZ5
 MAMLcpG6hiFtCUaQIVKXZsDye3s3gWYTBbPllWocUvXgWfCLj3wlvefcIdFa/LGcU26D
 voxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705977834; x=1706582634;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V+B30mwf9O82znIPlL54PQNu16n+n9bVRImSYOxhpMk=;
 b=j+qFlKyGx5mmPK0bttvc4PzkIp/sIKL67b/fTRa1RyGuo0XIIqb9ZdbZkHS6BNO5pt
 nH2pg8eQ3ClGtoZNdz894JwRCy32XORjIwEca2oviQDi9PtJwRKoGKny7GfxL8fp0PJj
 HAuPrWI6YrOIvzYummj29yXrb0xk5fGNWS0wQlYdPI/f3HwoKOpJkjWPDqTuFQSlJvjE
 6YTucpa1r1xp3TXqnbA8eZtRiUrfepQM6uNjw0mj4vNc5a4AKOApCtq/9jTW9p4mv92Z
 Z0OOhdE6BJ9Z5p1Pv8eBpjPn89l5j7Ucwal4+48GVetObsip/CIQg4VBSicMprwKNq6g
 iAQg==
X-Gm-Message-State: AOJu0YwnXUqIRGy+zcB/AVXHS4Bj7wCCAnPCWA4OiPO5Y+i2WbjZvjZF
 JH0kddiDYEajJovO9eI9peyql7xFPAXjWG5QkRnEib0kXt4PmCJl9S26WPJTdiL01aMGCPgceoO
 4WOoIC72albcfnhnTGtDKOLVAa1I=
X-Google-Smtp-Source: AGHT+IEriwlsMoEp4FqHfnp5YIDoofCcTpT99TJjjmb5zyQO4eE7w8NTCqb7x4DUeDdJggCy+0dgS50wz6mpZeM8us0=
X-Received: by 2002:a05:6a21:6801:b0:19a:49c8:b9e6 with SMTP id
 wr1-20020a056a21680100b0019a49c8b9e6mr11920243pzb.0.1705977834575; Mon, 22
 Jan 2024 18:43:54 -0800 (PST)
MIME-Version: 1.0
References: <2dba1330181940c78b5ad47f18ee43fa@supermicro.com>
 <CAOMZO5DTw2uU+uEmVLR9nbFkR4QPgmhuY9VUAz-sgg+GppMG9g@mail.gmail.com>
 <0934648988c9444aaf85f2e3163c0f4b@supermicro.com>
 <CAOMZO5Cy8as7b_cup6J+PYbN-stkj4Vz2wsLB_1=NN3vx5SVWQ@mail.gmail.com>
 <728CCDD9-CEA4-4ED1-9143-189C3F257097@supermicro.com>
 <9c2e7790f0c94b0ebf0e840100eae2c0@supermicro.com>
 <be10a49d2381407fb955958fbc87ecd4@supermicro.com>
 <CAOMZO5D5g6izBC=aCumX_H1tbo5uXTfuhQekSuH_XDqUAN91Kg@mail.gmail.com>
 <8ACC66AF-9761-44E2-A36E-62C8EAADA09C@supermicro.com>
 <509c10723aed4965aceabbd28d36b847@supermicro.com>
In-Reply-To: <509c10723aed4965aceabbd28d36b847@supermicro.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 22 Jan 2024 23:43:42 -0300
Message-ID: <CAOMZO5DUrxpRAt6Fn7xofHGH7B3ngrkdPm9c0YUd4r-19CB+ng@mail.gmail.com>
Subject: Re: Could you please help me in resolving the "
 /reset.c:42:(.text.do_reset+0x20):
 undefined reference to `reset_cpu'?"
To: Liu Wang <liuw@supermicro.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
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

Hi Liu Wang,

On Mon, Jan 22, 2024 at 10:55=E2=80=AFPM Liu Wang <liuw@supermicro.com> wro=
te:
>
> Hi Fabio,
>
> Could you please help me in resolving the " /reset.c:42:(.text.do_reset+0=
x20): undefined reference to `reset_cpu'?" from: u-boot$make all:

Looking at the errors below, there are several errors besides the reset_cpu=
 one.

As you are using an out-of-tree U-Boot, there is not much the U-Boot
community can do to help you, sorry.

You need to get assistance from the U-Boot provider that you are using.
