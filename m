Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BC90CA0FF0
	for <u-boot@archiver.kernel.org>; Fri, 29 Aug 2025 20:16:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0E8083542;
	Fri, 29 Aug 2025 22:16:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hF7pleRq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52D8F83642; Fri, 29 Aug 2025 22:16:02 +0200 (CEST)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D988883526
 for <u-boot@lists.denx.de>; Fri, 29 Aug 2025 22:15:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-55f6f434c96so219987e87.2
 for <u-boot@lists.denx.de>; Fri, 29 Aug 2025 13:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756498559; x=1757103359; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NHIrTWepCc/o6LvmxXOg+ja3ynAeR6/v3sqnESHNPGk=;
 b=hF7pleRqp4Yin8qz1XnSG1axd3i0vE27tQmQxVK65cP+v5/WO8IjVufkJQ4E+t95kP
 ITCP7G/KoQDSIzk5DBwCXE5mIdXgOybS9Fcy+F1Uy2OexShjdPngwosM+vCZ3AhIMnTz
 NoQjuvOumCa3tquEcIpqs91AaxWBwUzjuRhr3xPNml335lAv+uyVeZNyjXbuZG8M0SW3
 QX5thinvp7fYc7UDqcFbPK0LhmGs+pVZI98QvCThoTOo7TZB3HlG4b9AwVwZJdL+waId
 DZhm7aToPICQREX1gkJrHo/W1NCp+PQeeYmNWrYn//SOKtZXmJC9DDg7p6LXSGur7qu7
 i+zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756498559; x=1757103359;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NHIrTWepCc/o6LvmxXOg+ja3ynAeR6/v3sqnESHNPGk=;
 b=GWU0IBj33C5fEDN5BA0zNRcoWRRPix03YskHN8u80cDqB7JbfaT4vyjFiHLQdo/vT9
 iDwvreIqdrKVRpNI3iTBMWFfMvyaRfYYPAdylR90NYL958tKd7K7vidh5tPgdjgK2rxP
 RGnArxOnFujPmpAnyTMNluqVMjrrvGGUTXIAefLirf0iiOL423LCoR4agq9hOFAEhIBe
 La2HJXvn0U0KrsoUc6UsWox6jYMVYSWmTzGz8H13/yWpQ3qtoPiw5pmjMsVZfxVNhxD8
 T/UqwhrwD9WUI5qwIFkXeyIvXap2x+lZXCMLHEfDnMKjkCMdrag3W8MQNTZd8lxCMc+a
 bAAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYOrka9AwcAGJriDDofL2IOO/iMJm/rZfBKt+xunigJJ0YT+8X1Grp29qsxsmW7akGJ1p9nk4=@lists.denx.de
X-Gm-Message-State: AOJu0YxCt+6iaRE2K7nAFroAYJFcGIoiYuKH+rtAHxqe4FVkrvGCDaNu
 44l8C9oiq86u7U1jgNtnohUIb6Xq/DlTrYGIs4ePGesJh29QOHTvmHfcicnpESLBkiG84EbFapq
 ARQ0wslc02mKjKDnMhuOcIiSn3ibnTlI=
X-Gm-Gg: ASbGncsh7G04ffLr+i8ah7L54WPZ6TwoXnyQb7JaXW3JQKYIZyvnZAtwSqZvXx3pBnU
 mRnOrIXfnftvB+xKqpMWQt4ZzEzMG5shQVe1zNb5Im5GpS4L42eL1XxbBqA4VpokNkeoH50wZfq
 9OOHcFalAvKh9oVeNYGbIN9LmhcJV5u+VG3q0O/a8jUiDF9s3Qu5TrqKu5i9XMqowUkL/PGlP9M
 IZ0IRnng4yGRg2916pbQpfkSBNfQOxaaRHPr5vDdbfhvSehRQ==
X-Google-Smtp-Source: AGHT+IGha4urqFh9UM1wzgi9GefOGk4r9p5lo3TutTjymIYpeAPpPNM8VD0alCtAJYYogTRLSqOtr0DMs3H2+yPOL9Q=
X-Received: by 2002:a05:6512:6703:b0:55f:449c:19f0 with SMTP id
 2adb3069b0e04-55f449c2189mr5858500e87.38.1756498558813; Fri, 29 Aug 2025
 13:15:58 -0700 (PDT)
MIME-Version: 1.0
References: <20250818-imx95-v1-0-f68a19fe30b6@oss.nxp.com>
 <20250818-imx95-v1-1-f68a19fe30b6@oss.nxp.com>
In-Reply-To: <20250818-imx95-v1-1-f68a19fe30b6@oss.nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 29 Aug 2025 17:15:47 -0300
X-Gm-Features: Ac12FXyLQHbNVBZFiwqdY9Fqbm2R_PAeFpCbNfiZxdKpLnnpQQTNJwv3yynvZIs
Message-ID: <CAOMZO5CWftCJn=AMWmWLg2eDE_L=FPpW5eBK0ebMCR_+nWUuHw@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] binman: add a new entry type to support .bin file
 generation for the i.MX95 platform
To: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Stefano Babic <sbabic@nabladev.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Alice Guo <alice.guo@nxp.com>, 
 Marek Vasut <marek.vasut@mailbox.org>, Tim Harvey <tharvey@gateworks.com>,
 u-boot@lists.denx.de
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

Alper, Marek, Simon

On Wed, Aug 27, 2025 at 4:06=E2=80=AFAM Alice Guo (OSS) <alice.guo@oss.nxp.=
com> wrote:
>
> From: Alice Guo <alice.guo@nxp.com>
>
> To support passing specific commands defined in enum imx8image_cmd to
> the imx8image_copy_image() function, this patch introduces a new entry
> type nxp-imx9image. This entry generates a plain text data file
> containing the relevant commands, enabling flexible configuration during
> image creation.
>
> Signed-off-by: Alice Guo <alice.guo@nxp.com>

Do you think this looks good to you?

Thanks
