Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9128CA0EFD
	for <u-boot@archiver.kernel.org>; Fri, 30 Aug 2024 17:05:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3054C88A5B;
	Fri, 30 Aug 2024 19:05:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IhXTQGAb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 660DD88C8A; Fri, 30 Aug 2024 19:05:43 +0200 (CEST)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7FBAF888FD
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 19:05:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-5334c018913so1853172e87.0
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 10:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725037541; x=1725642341; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gywE+AtWWuWYRUy543m6bVs0kT0InSH/TY/HTnsMjEE=;
 b=IhXTQGAbGp/T3S00cNEweyKVNON05NmGwnIBNTfmFm3+yK7ESjQa2UlAus+1QXojBF
 xWMxq5js1NNbh9YzD2uIuThR3d7WOqr7qiGt2np36qM/cPZpn2YKoxcwgImn3ozfsrnI
 X33ACKwkpkRSXHwvCkQMmrna76wkSLpRjJQLEP8vbOHOY7eogiUYsDudA2zK3mVmzA6p
 qg5CtpKsvLKxp3flBniUTrfzNYoeISHdufseIOt9UgsR8IQbeKHb3IRdcaa0BQdxLB4S
 tiaDg2oqxJ5ZolhCClqhaaSl5fTMfZ9JpindwTkWuUT71UAt9mHix5C626ugy5RqZ+b+
 VHhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725037541; x=1725642341;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gywE+AtWWuWYRUy543m6bVs0kT0InSH/TY/HTnsMjEE=;
 b=qjGscGulKPXxmfmOVTqz6jU0k5y6+pALtD32C6XMvRGlRWIjaElBJer0mzNYcb30Ro
 bObPMLllX1uIzVYbeiDe9epBiCjl9lB+OiOXA3scaiuNumlD5AgcLRgORCf7jlAVABu/
 ke35kgWGunwuzKt3dY9+UkrMrHClASppMNVJIwkqpkn6mwLySNIrZFZLlER17cr31dlv
 psKx0j40hM3n3AnEAh6dkE3PiP4kr+uKrxgC6iBUpNUID4NNjzc0g7RA3fhRvvlE3g6z
 1r4ZzvnjdAaOznoK/Oqj7LABUuhkFT4ai/8y7R7TkS6C4cX6GowPsGH0GNGRexNhG11O
 TzYw==
X-Gm-Message-State: AOJu0YyF8Z/sITwrpGKM+RfJm3d2Qb3E7Z2SVRfQxe/cPu7W/AUdoAwL
 8V3dkn7faBYiZgsl3dOCIhwIUbaPvgmmSGetgWS5Km+uqyE9yuTNwbcU49SBHXJnyEQvEqsznjr
 BKNWOFfZ2TK9mpOoDL+IxLDKiTeM=
X-Google-Smtp-Source: AGHT+IGPpNNL0vvjFi7A8LduprSgABPSzGPGUsC94qJF6AvttXDjfylistO39yolfOgwUpA/q/gfIEHsrOuTzDG7OB8=
X-Received: by 2002:ac2:4c4f:0:b0:530:aa3e:f3c with SMTP id
 2adb3069b0e04-53546b05f96mr2420774e87.14.1725037540167; Fri, 30 Aug 2024
 10:05:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAOMZO5AUvhAGZd5VyiJGXXTKbEHJGysgTPLbjWE4H7wSh697hQ@mail.gmail.com>
In-Reply-To: <CAOMZO5AUvhAGZd5VyiJGXXTKbEHJGysgTPLbjWE4H7wSh697hQ@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 30 Aug 2024 14:05:29 -0300
Message-ID: <CAOMZO5Bx-drCkfw2sUBJtO-M_bPFqV=tNYV0GKwcnf1J9HqmZQ@mail.gmail.com>
Subject: Re: imx6ull-evk: Hanging with Ethernet enabled
To: Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>
Cc: U-Boot-Denx <u-boot@lists.denx.de>
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

On Fri, Aug 30, 2024 at 1:49=E2=80=AFPM Fabio Estevam <festevam@gmail.com> =
wrote:
>
> Hi Peng,
>
> Running top of tree U-Boot on an imx6ull evk board causes the board to ha=
ng:

I was using a imx6ulz, not imx6ull. The imx6ulz does not have Ethernet.

Sorry for the noise.

The imx6ull-evk is booting fine.
