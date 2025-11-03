Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3428CCF9FE
	for <u-boot@archiver.kernel.org>; Mon,  3 Nov 2025 13:23:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF78C83984;
	Mon,  3 Nov 2025 14:21:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bh1LFHi0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A630E838EC; Mon,  3 Nov 2025 12:07:17 +0100 (CET)
Received: from mail-yx1-xb129.google.com (mail-yx1-xb129.google.com
 [IPv6:2607:f8b0:4864:20::b129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98D3E836D1
 for <u-boot@lists.denx.de>; Mon,  3 Nov 2025 12:07:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng.cn@gmail.com
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-63e393c4a8aso4062036d50.2
 for <u-boot@lists.denx.de>; Mon, 03 Nov 2025 03:07:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762168034; x=1762772834; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dki79PVB5FuWmvspzPK4DPzQnE5tLA/LSXbE+QMaV3g=;
 b=bh1LFHi05pIrDlkRlgZMmTfBAESw92103YFBrxdLibIBg7b2ilnvj9GUwfTgszPwVm
 TO407wPLx50KEEUXQwwsLUMk+GPuI4Y+fEBMMviTiVEks8T+e6Gn0vbKqhe3kk37+AND
 PDEB+aLdLv1CL0gNzPGHjsUl7yqgwGm03cfVQTo8JADqHPpbPNTuZuyrhBxP3FkSIAn1
 ztpj19jiDVpzKzKarLfTMguik8mjcIEkv3rGaey4uF0YWs62fon+NVvhmLXH8yzotfG0
 9gwWS6TB1r/9qCaa1LubIHfbpXj88kk0M80yzjFDIgfqd3BWqUcFUtqOpqeHOU04nrv1
 3NlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762168034; x=1762772834;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dki79PVB5FuWmvspzPK4DPzQnE5tLA/LSXbE+QMaV3g=;
 b=uIn88b+ywAoEHFNgD6//YZysaIynbiR1I6p8GBYa1/qO3VF3kHuYR5MjONYqzVFj4b
 l1JbZd3MJfer+C1T5JQ3k0lb6oIkycUbioF9lkFelFp69dYw0UF5smCIVEwGjBaD/7aH
 7PzWdMFn/tfv1wpDJ1nBlHJZ7uoulLsNhS+wQZVM+kcSJQaCgo9TUp8SPLggeAo8+ivB
 A01kHQClP+ZnfCuYiztOtmN0XEMECYxoYYzCfPuej6CSNSi4wsdHm4TSwFmVmO24+pVf
 E+1tuxvfO02PqqvAYO/IJs/1I5Uhw59r5/5joyhPl1UUDpQGvl5pK5whwQRJyzvBnwRq
 OVSg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgY0EFyVN0y3MXqKrUDgjQSEPE3AjY/vY1qLw2Jbsp1jSCSL197EfobSoowkKUo5baThxab6A=@lists.denx.de
X-Gm-Message-State: AOJu0YxNUtLY0jYzPT+7nC1+RGHwXrf5t4iFM6s3KpDART5rAz2XqwGG
 sbImdfkQjUk5WDqzPZXWV2PcoMiMTAYaNeV3AhLQznWTAMkk7Dw6pLdOZ+FXSeEBo2IT3O+/COn
 iPxoFBsbmXuuW2ts9Skb453ULjBAWjcU=
X-Gm-Gg: ASbGnctsoK9LtoiMJ0zRhiYFXaheZht3LRpTI9fDuCcMuAmfZxg2dQ0BszyqAtnB2G7
 5LI9kJXlRqGrfFKv2Y9Qs8mFuMmo93KuNQVZN756fWolAmql7uoCq2e5coZ+6RwRPkW3yMxxzct
 Ch5PL6+tr3Us2Ao53YRnmojfOWynBMeB6xGd1FPZxhLVE2TgO0ViXrTQfEVZ0w2/X3s/XhqzQQh
 dbJLADXcJnKLHo9MjZCgTwjWBR+NlztEjclNZGrOovo2tClFlaNCJYPkWScLH8=
X-Google-Smtp-Source: AGHT+IEImyD6odapVtjtAJQUuY6NKSg98O9ORTdJN7n/BQ94gPSpUYbZsUVNYuhx2dsfs1LiW4GzJBZ/1nP0+fUpTHk=
X-Received: by 2002:a05:690c:5c01:b0:786:4fd5:e5d2 with SMTP id
 00721157ae682-7864fd5f604mr80699307b3.45.1762168034409; Mon, 03 Nov 2025
 03:07:14 -0800 (PST)
MIME-Version: 1.0
References: <20251031195931.622513-1-heinrich.schuchardt@canonical.com>
 <20251031195931.622513-3-heinrich.schuchardt@canonical.com>
In-Reply-To: <20251031195931.622513-3-heinrich.schuchardt@canonical.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Mon, 3 Nov 2025 19:07:03 +0800
X-Gm-Features: AWmQ_bmbFobVJFIgkoShOnwoEKYe-t6KuO5ulZuPr9AoFV6tRWXWzN9W-LdsUDo
Message-ID: <CAEUhbmVqZQQ6b574eAPGK8=SjCuLBH7BFe3LoViUoyfLZbjQvQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] test: provide test for 'acpi list' command
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 03 Nov 2025 14:21:42 +0100
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

On Sat, Nov 1, 2025 at 3:59=E2=80=AFAM Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Check that some mandatory ACPI tables exist:
>
>   - RSDP
>   - RSDT or XSDT
>   - FADT
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  test/cmd/Makefile |  3 +++
>  test/cmd/acpi.c   | 52 +++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 55 insertions(+)
>  create mode 100644 test/cmd/acpi.c
>

Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
