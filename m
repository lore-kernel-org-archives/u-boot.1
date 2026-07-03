Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEA40C43458
	for <u-boot@archiver.kernel.org>; Fri,  3 Jul 2026 11:50:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3481584832;
	Fri,  3 Jul 2026 13:50:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flipper.net header.i=@flipper.net header.b="j1JloHvM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5D8784994; Fri,  3 Jul 2026 13:50:19 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B60298469D
 for <u-boot@lists.denx.de>; Fri,  3 Jul 2026 13:50:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alchark@flipper.net
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-c1276f8414bso50123966b.0
 for <u-boot@lists.denx.de>; Fri, 03 Jul 2026 04:50:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783079417; cv=none;
 d=google.com; s=arc-20260327;
 b=Qj06Dps8NnSuuPP3nIQ1SKfy9BeFX0kMmCne5ZQGUzbvEptgbbLZssRZJI3G4HzQ7z
 tOXtX3ubWGnrFFyMvKA16IrDXNN5we/EFgKXNOk/1u3YVhvCSbyBelK0apPAeltVAEzz
 dMHaHl1xtEEtdJn+6LpUFuz9+S5f7vTyWzjoKjJt0wAjss/Y2FfSeNobcvbV1PDCS6AC
 zEP+POoFu549UtlW912A2bVMvjRCSBm/bIa7M3EfsCznihzpKzqV4QcdiW4ND7cqdxtW
 oUQw8c3n0hKyiG1OqrL/kxho1E4y5nvhn77o0kuzD+UwxmHG4RymzxzMw0ehK/b1WMHm
 LaOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=nULEiktyMs9USFPl1+mPb3O5oX8gz9cGb/K00tjXyho=;
 fh=suKZt0dJ5CEgKnxJXdbalZtlrp6eMGSfQtRR6dpCRho=;
 b=CFTyi0P7qDoodJiaDh6Xe1khMW4RdCe5M4hQX/eGKtoGVO+EpzjHNMzFM84JIwsbHU
 gbDBTABFmidwfZ/WGweZVLz7sTSJustc1qROxKWUpwtbuKGNqeIR5cmZGlxXj6Bsqd2f
 NsghINRYEtybBLWImqnztd5vko+pupxHrKU/WeTHIpoitGmH8U409jdjdqlvuGQAAhXq
 ZGAgmcJYqEq10o16KtN2NwBABpdPo+MTffumcQOkhL70Fg+w+F8SLB/kjvoxJFL8RddJ
 dpRclw5yfhz+ohlGtgAOVJPycbruckdYzXY4G2rvsx8cKlkysgsbDzk+8+x66a+4ywBy
 e+Sg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1783079417; x=1783684217; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nULEiktyMs9USFPl1+mPb3O5oX8gz9cGb/K00tjXyho=;
 b=j1JloHvMwhbfAPUgnAqq7hx7hOSpq2GmZrmloHT/8lsU8M3ajEiaRIoNXGpdWSORiL
 EJ+I4vkTEamjL+mdARdeNZJI66IMzrJDMLazsV3zFjTXrnE4akGs81ybsD/M/9r06Ae/
 XMPlQVXSXYkQio4rgpeveaNsk3IXuD1EVdV4+bGJhbo57aQ5Y09IQA2buuifbq1grHU3
 klvwOjZRHblQNiybdAehfB4tV7xN2pUQzArpCinAo/VQksjjOBuxwC9+9UA3Dday0VGV
 ik3sOHay1wHbfDFVZesyBkYcBdZ4nggyewR/784sYnfT3COfzlHxo2bkVGH4vqqiZz9C
 Eg4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783079417; x=1783684217;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nULEiktyMs9USFPl1+mPb3O5oX8gz9cGb/K00tjXyho=;
 b=W8yTZhjbGLwj4tljDzg6KODdO06wyj7ymmUmbT+AhziWMuPIdOlt/mZ+XyKteUzJwQ
 I47o+sMg0mVpjfet/UwjibirPZEZ9dtF70wizJ3N1GqXLmZpEq6M4FSei2m+PnYYKIPO
 jLkEicBzkkKVLSV7ahQJI9JRy79pIxFWl4CX9fqg7PYkQmARFpGKhpI/NDgsYXPsw64t
 3VfVN/7GkdC7AifdSWZ/UFQhsStjIo2FmDYitVyGqj24tOntW9Sn1a2mkz4b4UUD/Rcf
 IPQK1TqtvssAvMXmD+4PFENNFaKmOvATe3WN5zSxil5B9K1vYj/lk6yJccijl3EzIMx4
 Syfw==
X-Gm-Message-State: AOJu0YxHXyIcJqSXvDVmXExj6leeqm+5WXB4ZJY3pkC/j1fBaCV1E/po
 ggUYv3iMWPVtECcwi/oCONZzZg9o55gfb8ohFvzlEWlzObRBr7y9Jpn0drCWiFYResP/O+boBBQ
 W7iV0Ii4I1MhC3uWWJYnZrNGpz7YH7m/WglnjU5GlbQ==
X-Gm-Gg: AfdE7ckaWR+BlJ70ssIGWgsBR7+1tu/OOPhpqVDZnz6EwbfZSkFiCG45ufiC8EIhklO
 9cS2zgKTYHRRruXRA7HASxZObOXGSdaj+iZxKeOWBoYUWAELpNZq52gaFmrlj0NnpQL9qCthepS
 h7OIcarkNca9NWY01uSAhypbAoz+Qs0688xz1fO6wG1CY488r0jbRfXhRmaYSZ1JsLj2biz2NhK
 wIdFp2jMrrxeYZOkCW/X/SWLrdk/iPw85ztBHW+W/pt3YWkQXmKXCPNHIO/hzGRUFP16HU8QfUP
 eX9htBynMh1NK2RkMnt7g3UGTw==
X-Received: by 2002:a17:907:cf85:b0:c12:b226:69ac with SMTP id
 a640c23a62f3a-c12b2267113mr359234266b.61.1783079417088; Fri, 03 Jul 2026
 04:50:17 -0700 (PDT)
MIME-Version: 1.0
References: <mwb-8utqeprHrcyYlJKRzVpdMfI457MmWgwqLdkvc5fFiSE43Y9wiz594Nzt2CRn4jUIZmc6F-KzD2pQuixCwkT2KPkZ_NajlkW8vEsCOrQ=@proton.me>
In-Reply-To: <mwb-8utqeprHrcyYlJKRzVpdMfI457MmWgwqLdkvc5fFiSE43Y9wiz594Nzt2CRn4jUIZmc6F-KzD2pQuixCwkT2KPkZ_NajlkW8vEsCOrQ=@proton.me>
From: Alexey Charkov <alchark@flipper.net>
Date: Fri, 3 Jul 2026 15:50:08 +0400
X-Gm-Features: AVVi8CfojglA3r70uG9CSqp6gYGXo5aZfN3YJIM-NL05ybrHh8pDwK6C_9StvIM
Message-ID: <CAKTNdwEwwB40RH-rxf6bPV00THe1g5KtsXRgs-wSKF=H87dqww@mail.gmail.com>
Subject: Re: [PATCH] spi: handle spi-rx/tx-bus-width = 0 (no RX/TX line)
To: r00tnomade <r00tnomade@proton.me>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "trini@konsulko.com" <trini@konsulko.com>
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

On Fri, Jul 3, 2026 at 3:42=E2=80=AFPM r00tnomade <r00tnomade@proton.me> wr=
ote:
>
> Hey team,
>
> I just put together a patch to fix that annoying "spi-rx-bus-width 0 not =
supported" warning we keep seeing on every boot for the Flipper One.
>
> Turns out the Device Tree binding explicitly says a value of 0 means the =
line isn't wired up (like a write-only display with MISO left disconnected)=
. However, spi_child_post_bind() was only looking for 1, 2, 4, or 8, so it =
threw a warning even though our DT is completely correct.
>
> What I changed:
>
> Added the SPI_NO_RX and SPI_NO_TX flags to include/spi.h (matching Linux'=
s naming convention).
>
> Handled the 0 case explicitly in drivers/spi/spi-uclass.c so it applies t=
hose flags instead of triggering the warning.
>
> This should finally clear up the boot logs and close out issue #33. Let m=
e know if it looks good to merge!

Hi Sami,

Looks like your patch body didn't get through. Would you mind
resending in plaintext using b4 or git send-email?

Please also see
https://source.denx.de/u-boot/u-boot/-/blob/master/doc/develop/process.rst?=
ref_type=3Dheads

Best regards,
Alexey
