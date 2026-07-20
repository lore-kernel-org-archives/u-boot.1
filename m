Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8A52C4452B
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 12:21:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2A01838D7;
	Mon, 20 Jul 2026 14:21:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PWYsAWvf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A16083E76; Mon, 20 Jul 2026 14:21:11 +0200 (CEST)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56AD280517
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 14:21:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-8ee88fce572so77179206d6.1
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 05:21:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784550068; cv=none;
 d=google.com; s=arc-20260327;
 b=U+/i1ZNOTKVYNXERmfazolRRl9AYuGhYRJXzfzNWZIsL//Hl1Wo3TDNXy3uUOlVfby
 SkFrg+7R1tJSM0DB3xLzwXBQaSPOYWJycEh2R/2vBnqdvdSAORBrYneCBCytxSD8HfHE
 4At/KAgWUTIipV4YaqtRGo3c3aXdIP0JgjZyrwrJYtlTlRfTUeMyR8YwvU9d8HGatKy+
 +kPpyyjrZsL1aq9KhoOPSRhsVH5qrivS5Cq+eZ/ev03rARokBPtBzBfgkOjaLncM2jYP
 E7s1+WqcXDTEhmVEbkH79NNEHj7G8Xe/3+zUru3MMH0TznnekJXkZsFw2MDhvze5Kx0d
 J2wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=BrPTVclDPP6FcvspE/EAgoFJyYmrmknt89W6mopjg9A=;
 fh=g/gRVkA9Cz13V4q0m282EBvgwkM+OQ0vSphsHv8tiWo=;
 b=ZKR0g1sSGZiCVijicn3hPp16cMXftm9/7CFIWwCO450sraAFysYb5VGVhfTuxDKBy1
 T70Y0+1MA5mXhokF7oy/vUt7iyWen5d4QdCj15hBjiXuJwwJz0zoQ/RJTXGnGXJM8RLg
 VQL+D3fKudvyAU+r9k8+mcVvuP1bRTyeGbnvJarGwfwKQp+Zr4/BGinRYMgvMk3+5xhz
 aQbdYNA5XTDhU1qzPjudBLOTcOPB+6YRVxbHRCRHc2oWOaqNoMW9azjW5x8TCwUM3EnX
 sihLimzq29Q+02Cz5Pj5Khwp5/hF19B2heI8qrFIuSJMeFwLbx2JSqjcq+90uFXTq9A+
 qPrw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784550068; x=1785154868; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=BrPTVclDPP6FcvspE/EAgoFJyYmrmknt89W6mopjg9A=;
 b=PWYsAWvfbJIjlh4k4+ca0NgzF9QPBz18JN0CwbDd7kQxvvjhsVrgK70kwiVmQL0xUi
 DMI4L1H74ay7vZ7exSyZC56p5nQO9fSQPlKhuM+ap+I3iAYpdz4V9rUmq13B+3p53d6G
 ho+ghAntU9Kr/ITUNDf6kRkyC64bl8G06wQqX/ocEhli86LVZdQmp4LEJSGRr0MMlI22
 kzr2Y0HoKSP4+h+VGCpJAA/ogBzdkNsI0ONBDopggRNRzuWRYJU/++OkphEdV3vNgZij
 cjxnMm4zxoTMM2/5QKXNuyjdoI8hLv45/c+jkRaF7IMHCnN6H7585M/UDIMuUpC8/3Kl
 ZIVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784550068; x=1785154868;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=BrPTVclDPP6FcvspE/EAgoFJyYmrmknt89W6mopjg9A=;
 b=ZdBn8vHdVPNSqTektOt9o7QgUb2UbMzwnGhY1M+RNrSas/UykrJjEZP5dbYbV9N41I
 DcyUWQqkAaKEwVMWfbhLLMpjljdDmsFB/Zj24ejL23SqIwSTx/OCI+mIMFmd2bGBJVct
 hLftLc4kJVz7H/D/juH2UkEQAbSLL2aBB3TxkP8cePLB/X88TtcKzDHHWSUvpJCuArVe
 OuQsOJQ+QT8bUAKi1/cfRDrg0oLiBHw8dH/1lkSPbELkJXDhJ2+SMb1U77QJ5gr4Ha3A
 dzNDl6F3hhyhYDBxBGpo5TAqa5pYARRqlgBwdDAHMSTVATXGJRSXIze5Q1Od903YvpD+
 N78Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RqScdq5QBH9b4CAlybx4VntKRswu5TxtiXV+hy9bOPQxSdIWcQwLtbKrk6RrFICtfDP9P54e5Y=@lists.denx.de
X-Gm-Message-State: AOJu0Yz9JHoVylV9gDmtgjVZeOOTjzLEPRLYYMiZDSTVyyGRltVw7HAz
 mXk1mv6KLbqI/FicHe3qwpJVcD+4xwUURLMvBK28a/CazNSrnkEZwTIWuv31OnSpXIV3K3qac+9
 NPtwWz07Pvty+pX4BlyeWQ4nk2l5M8dU=
X-Gm-Gg: AR+sD11/G0aJx1xl+6aOed8GyLEHchVHA6Eo3DmAhH/bIw0dzdnyMYGpuB4oEWOwhNd
 nrsE/+o13MFXHyV6sVzWE9sOsdB34lRd0+wGCUGcpk5oPvAWr34nyzIG0OAbTkA/2YVJC2+3pbr
 NZlrcBDRVJRopSv6FksrFZ8nJEhUM6H9kUOe/ysQ7qKkvuP98who+SqrdNcGIFvk8laY/MIbCCG
 +UjjIxbsDt8nx1u7pIrle0H0UGthtqi3pO7OG1HQRPPPlAlI/zCJW2lSEpaeHYRh7Vc8c2n9LzF
 Uni1AKj582wKP244bLKLcM59wVkyrzTS1n2e0KASeAZSEu5NSMzkqWOqFdqOmztq4GsXSusGZM2
 LXN3x6MYylrrPoK18fnJHawrPaMS+LXa/DuaIGp3EQvo0BmQ7BpKyAmGN
X-Received: by 2002:a05:6214:238f:b0:8ee:e686:1b24 with SMTP id
 6a1803df08f44-907783bdceamr142277246d6.45.1784550067964; Mon, 20 Jul 2026
 05:21:07 -0700 (PDT)
MIME-Version: 1.0
References: <20251209210347.492763-1-pbrobinson@gmail.com>
 <6f8d755c-ce0c-42e3-a066-08e75640f3d1@cherry.de>
In-Reply-To: <6f8d755c-ce0c-42e3-a066-08e75640f3d1@cherry.de>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Mon, 20 Jul 2026 13:20:54 +0100
X-Gm-Features: AUfX_mwYOBrlxLB64nc-warjriEq66wgx7maZgVZimpz9Snkuiu1WrQjsmKgqcs
Message-ID: <CALeDE9O7Zp_+g8Q6zd8PbaUDrotzyJ8kur1VvfVqo8WqR5c17A@mail.gmail.com>
Subject: Re: [PATCH] rockchip: rk3568-nanopi-r5: Drop duplicated/extra sdhci
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, 
 Tianling Shen <cnsztl@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 u-boot@lists.denx.de, Dusty Mabe <dusty@dustymabe.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Quentin,

> On 12/9/25 10:03 PM, Peter Robinson wrote:
> > The pinctrl settings are now upstream, with the upstream
> > voltage supplies, and the HS200 mode is confirmed to work
> > fine but the HS400 mode had reported issues so let's just
> > consume what the upstream DT has now as it's all known good.
> >
> > Reported-by: Dusty Mabe <dusty@dustymabe.com>
> > Tested-by: Dusty Mabe <dusty@dustymabe.com>
> > Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
> > ---
> >   arch/arm/dts/rk3568-nanopi-r5s-u-boot.dtsi | 8 --------
> >   1 file changed, 8 deletions(-)
> >
> > diff --git a/arch/arm/dts/rk3568-nanopi-r5s-u-boot.dtsi b/arch/arm/dts/rk3568-nanopi-r5s-u-boot.dtsi
> > index 64c43374c04..7e24be1a5e7 100644
> > --- a/arch/arm/dts/rk3568-nanopi-r5s-u-boot.dtsi
> > +++ b/arch/arm/dts/rk3568-nanopi-r5s-u-boot.dtsi
> > @@ -12,14 +12,6 @@
> >       /delete-property/ vpcie3v3-supply;
> >   };
> >
> > -&sdhci {
> > -     cap-mmc-highspeed;
>
> I'm assuming this isn't "necessary" since we have HS200 enabled? It
> isn't part of the upstream Linux DTS.

Sorry, I read that as a statement, not a question. No, it's not
necessary and I've got a few users that have been using this patch in
Fedora without issues booting off eMMC for quite some time.

> Considering we have HS200 support enabled in both SPL and proper, it
> should be used, so:

Ultimately if it's needed it should go upstream, but it doesn't appear
to cause issues.

> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
>
> Thanks!
> Quentin
