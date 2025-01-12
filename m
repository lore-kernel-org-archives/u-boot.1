Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38B69E77188
	for <u-boot@archiver.kernel.org>; Sun, 12 Jan 2025 19:08:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F06D80079;
	Sun, 12 Jan 2025 20:08:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="sBcrk8ZZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 429F9800D2; Sun, 12 Jan 2025 20:08:32 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 222A580027
 for <u-boot@lists.denx.de>; Sun, 12 Jan 2025 20:08:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 5254E3F473
 for <u-boot@lists.denx.de>; Sun, 12 Jan 2025 19:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1736708907;
 bh=eH9JTIJhGye1sBq2FoTXd0ORYV9vOfwK9vfscNMC3VU=;
 h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
 To:Cc:Content-Type;
 b=sBcrk8ZZYT3+9RK1zul5SFQ1pWr+GB2BumoQ4T655cwqL4mSF3wErtKR9yG5BWb57
 hoX1Se/6ZV70KzRo9baRn1HlZYTrwgEjYxDdbKiW+1r1qGbqxQ9/CdPIq75u6LZQnA
 fg1UDA4Azay8n0xDRB1rZ9yzWydVm1s4HYVvnipRKISjT4oNvqnrcHOd3x89J9UiYg
 6Wj3TRsK4Evc6CzxO0TQvJy8vyE1Tacm8X38KtWOkr2IHK5SKTuoAuErj6Pm0dFyry
 H3vI6FALrcH+joWJLl4swYscA1T7GQXmr1pgU+7CBKFQM6Ne29brwJLUmh8doaeQZv
 b7jSadbAsN3EA==
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2f550d28f7dso6280257a91.3
 for <u-boot@lists.denx.de>; Sun, 12 Jan 2025 11:08:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736708905; x=1737313705;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eH9JTIJhGye1sBq2FoTXd0ORYV9vOfwK9vfscNMC3VU=;
 b=QI4AowapfBTWeXgl7gJWGAAMnIYvTMuTTymJ3DL48efejk714pblxw6RPCd1FYuWYd
 35EaquWexmfMlazrl2e8J3GpYQkBoXchmjT5KEiAbqVUAFMvdekMjt8bCjuUNsDQhaKC
 EYEzh0J1EA0KW7S82PpV6gzQj33CCthUVW5NEDNNMjmsRRQm1OGOxrTM2SVydtG1UC2J
 57Y4OvKVsntPBtU5cJgdbBfaUVZeLBOnjkd0MdWt5bh2J5EGp332HwwmllIJxKbfhNBi
 r33wieRdfhFHXJU9VnD5C80yxsnhwiyBZISKkMtvmYNoLBjypiZkVYh/dcCyn6wzy3Jr
 gPAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfMt0raVWPaqHsoSN/UrtZ05o1wiXInTyDkV+79aQSxnMVRg5ncL4C9luhQQlmRbV0pvp9iHQ=@lists.denx.de
X-Gm-Message-State: AOJu0YzKnFOMmF4bfKqm/MdxmI2xUAui/R/2Ku1Mjgh9D9z+9tlqPmqU
 bRk7IW5JSTL7+9XS7+Z8Ywzl5dzjFtvBUqYjR3OQEHTcLf3HUYWqyUW5evMJ1PqntlH4frMFQbx
 TRl5KF9TIMhm9ydIIyjw8r4WZChh1X1Bt8zNQjR6+HqGEy23I+yvSI96LyQKKVfSPGOQY8bMP50
 1h0KK12ivrbah+jR3Jbf/E7UlY6vEP2hiDUrAPR26EEA==
X-Gm-Gg: ASbGncsPCWF+7K95mrOahZe+oj4Y+jysAmDvmIolXMOwk/1m3TznGE9+tJxDe2511Uw
 TAfRL6b7qYNABTKBqXJRE1uu3EwRTjy60KN4=
X-Received: by 2002:a17:90b:540b:b0:2ee:d824:b559 with SMTP id
 98e67ed59e1d1-2f548f44e6bmr25393287a91.28.1736708905664; 
 Sun, 12 Jan 2025 11:08:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHRTZTkuA7wy+xkOpkGa5SLmZ0p45WC1DSBNbcK9tLNSEJ1xKvjjbxdsA0aRqhAEzYnDlWh3suQlzizJ9PXmz0=
X-Received: by 2002:a17:90b:540b:b0:2ee:d824:b559 with SMTP id
 98e67ed59e1d1-2f548f44e6bmr25393250a91.28.1736708905322; Sun, 12 Jan 2025
 11:08:25 -0800 (PST)
MIME-Version: 1.0
References: <20241127070631.16412-1-heinrich.schuchardt@canonical.com>
 <20241127070631.16412-6-heinrich.schuchardt@canonical.com>
 <20250110224554.GA2278614@bill-the-cat>
In-Reply-To: <20250110224554.GA2278614@bill-the-cat>
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Date: Sun, 12 Jan 2025 20:08:13 +0100
X-Gm-Features: AbW1kvabBDbplFlYU5lwfTnDE0N4S8X9KQp2pvpqVdDS00zdJF21vNA0A7LPY4E
Message-ID: <CAM=mAOmee=By9ErZrvk0hVbZyLH_viguu_wMfOsV3LzTwddArw@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] cmd: bootmenu: add parameter -e for UEFI boot
 options
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Michal Simek <michal.simek@amd.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, 
 Raymond Mao <raymond.mao@linaro.org>, Weijie Gao <weijie.gao@mediatek.com>, 
 Daniel Golle <daniel@makrotopia.org>, Svyatoslav Ryhel <clamor95@gmail.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jonathan Humphreys <j-humphreys@ti.com>, 
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Tom Rini <trini@konsulko.com> schrieb am Fr., 10. Jan. 2025, 23:46:

> On Wed, Nov 27, 2024 at 08:06:30AM +0100, Heinrich Schuchardt wrote:
>
> > The bootmenu command can display
> >
> > * menu entries defined by environment variables
> > * menu entries defined by UEFI boot options
> >
> > Not in all cases showing the UEFI boot options is desired.
> > Provide a new parameter '-e' to select the display of UEFI boot options.
> >
> > Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>
> Very strangely, this leads to the EFI selftest "Executing 'random number
> generator'" test failing on Pi 4, where was was passing previously (and
> Pi 4 has an RNG, unlike Pi 3), and this is



Do you have a link to the log?

Best regards

Heinrich

on rpi_4_defconfig with:
> CONFIG_CMD_BOOTEFI_HELLO=y
> CONFIG_CMD_BOOTEFI_SELFTEST=y
> CONFIG_IPV6=y
> CONFIG_IPV6_ROUTER_DISCOVERY=y
> CONFIG_CMD_TFTPPUT=y
> CONFIG_FIT=y
> CONFIG_FIT_SIGNATURE=y
> CONFIG_CMD_BOOTMENU=y
> CONFIG_CMD_LOG=y
> CONFIG_UNIT_TEST=y
> # CONFIG_CMD_EFIDEBUG is not set
> CONFIG_BOOTSTAGE_STASH_ADDR=0x02400000
> CONFIG_BOOTSTAGE=y
> CONFIG_BOOTSTAGE_STASH=y
> CONFIG_CMD_BOOTSTAGE=y
>
> added.
>
> --
> Tom
>
