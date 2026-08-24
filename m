Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA778C5DF81
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 20:22:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C2FC280D4B;
	Mon, 24 Aug 2026 20:22:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rrkR0fphKjxP; Mon, 24 Aug 2026 20:22:17 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787602937;
	bh=unuKznMYZpKW42+wrlv6rbE40RCQBv14BJCCSD2Uq0o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ME7f3fxOqi/GKh2i21ox/O2oxvzHw7ljoppHCi7YR4By3aXd1XL8i5wotUqtkn0fo
	 uCBbAIr85vhgownjZPKkAI7ZMbTb0y9BqKh1eiVZUSMlytE/lXyX7G1ZU1ELXRho/H
	 PZAmC3eREA2FBUxngWoXBojfV43lbbqkbIkelS0lRHh8pTNMHaLB7HLZTSOWg8pnKX
	 UYX1qiJ5DU8qN//olxPiX8VinH9/1rVsci+ZJ393AXxLUOZJt4Z7n1c9cgl0u4nYjq
	 WPJKc+S8/NSQtfusKjAm+vIPTn6lynMHBZHvAse3aa3h0cRxKlncXzm5dE254NFdqh
	 AXTuDqCS2MVIQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id DF31480D1B;
	Mon, 24 Aug 2026 20:22:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 92DFF29B
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 20:22:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 849A7400A2
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 20:22:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KIajh67kwpCA for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 20:22:15 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=linusw@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Ml/PtjnB
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E20D840083
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 20:22:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9127E40635
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 20:22:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7545A1F000E9
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 20:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787602932;
 bh=unuKznMYZpKW42+wrlv6rbE40RCQBv14BJCCSD2Uq0o=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc;
 b=Ml/PtjnBfVlZ9osklYj/Uk9L29zOenFKNnKwBHDA6gCPGnLzdc5ypBtQJSYWqE5cr
 PNb+Vr25Tl1WwPGoDGbCjf1ZElpFlFCCgKST/lM5LlYRnxN4JTr/Kn+zEKgIl8lAdq
 ome9dltu1hKTwWYy/yl98T8l7bjqXtJOsK2XnSiBH8gZcPGK9V20MaUtzmSd4FkGKB
 +7aoOSaRGBK98EnV0o9qvNUDcOGTjYtMVi5H2QJaWPtP8clO6eqwKEZnCr4q+Bks61
 QRfWuLnb4KGLTGxH/pf5D+Q9upkQgp4lmKDHw2dvwlH1Q7he7R0Fq46gMy1Li8jbdj
 7wZNxyeyp/1bQ==
Received: by mail-oa1-f52.google.com with SMTP id
 586e51a60fabf-4563ac048f4so3616710fac.0
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 13:22:12 -0700 (PDT)
X-Gm-Message-State: AFuF++kO9FK8tEWoHIj+2U5jIEpAJfKFQoCSuv9b7sGiKxe7K5hnTJOd
 /baaDWowR26bfoT7piS/4oVLMMVR7uKdhB/143ESnZ65SLSFpRFV/G1TU5qunQpfAfOA4dZtR+r
 SkwOniIHAlORJdJw6pg5rud8ShXk4E6w=
X-Received: by 2002:a05:6870:46a2:b0:456:8f0d:4fb3 with SMTP id
 586e51a60fabf-4644a3db326mr1645002fac.12.1787602931785; Mon, 24 Aug 2026
 13:22:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260823-ux500-external-sdcard-v5-0-07ca794e2b94@kernel.org>
 <20260823-ux500-external-sdcard-v5-10-07ca794e2b94@kernel.org>
 <aoxNWLhEtchd5Q5X@linaro.org>
In-Reply-To: <aoxNWLhEtchd5Q5X@linaro.org>
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 24 Aug 2026 22:21:56 +0200
X-Gmail-Original-Message-ID: <CAD++jLkBbjCvA-YbtTaNVV--GQuY6rtVLbwS+cchAgW+28dvJQ@mail.gmail.com>
X-Gm-Features: AcwNN1XcT9px5T7Fqzct4kHBVuL2pj-ZJD8CVMmx1GUGKXN9sP8UC_g9f4RfNOw
Message-ID: <CAD++jLkBbjCvA-YbtTaNVV--GQuY6rtVLbwS+cchAgW+28dvJQ@mail.gmail.com>
Subject: Re: [PATCH v5 10/13] arm: u8500: Switch Stemmy to upstream Janice
 device tree
To: Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Stefan Hansson <newbyte@postmarketos.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On Mon, Aug 24, 2026 at 3:55=E2=80=AFPM Stephan Gerhold
<stephan.gerhold@linaro.org> wrote:

> > +             mmc@80118000 {
> > +                     status =3D "disabled";
> > +             };
>
> Nitpick: Maybe you can add a comment here to explain this
>
>                         /* Typically SDIO, unneeded in U-Boot */

OK!

> Although long-term I think we should try to drop all of these overrides
> and handle workarounds in the board code or drivers if necessary. With
> EFI, some people may try to boot generic distro images that don't
> override the DTB, in that case Linux will boot with the original U-Boot
> DTB. E.g. arch/arm/mach-snapdragon/of_fixup.c has some DTB workarounds
> that are applied only to U-Boot and then discarded when booting Linux
> with the U-Boot DTB.
>
> But that's something for a future patch series, not this one. :-)

Hm yeah Ux500 ARMv7 is a bit fringe but I guess it could be done.

Yours,
Linus Walleij
