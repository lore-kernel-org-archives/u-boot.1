Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B164F606A31A
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 01:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=fCGn3xZe;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nE8tkvYN
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E64836061F;
	Tue, 27 Oct 2026 01:23:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kI-w6YVljZ3K; Tue, 27 Oct 2026 01:23:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 07386605F9
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793064223;
	b=FMD6jNEHr3IozOfuwHrELqW0KFuFwN1ReaTUvwFhPG7lR/7EqcJXuJP1GVu0iRTMikoz
	 7sCWYMQXiIQAi3GIFDVlS1IT3spsKJPMk1xu5lbeRNEQ3IfuKhWSOgV5pPIhQZYxDK8a9
	 6vO3mZqVNEKr/qYM6I+GE/wELnvw+vGo7rVXNKBtH6WVe4lYrRzXURuCULgnEI/LyrFOU
	 poWpojogdyI7Wx8jxG0neATo/mWEAxaZNfftPYXIEYJtS1X/2gmuHtRF9rd+MC76iZECq
	 aFRikugZWj9RxJNEI0T3IcUnbA+6ZIXKKAvd9ZK7qikVckWG4LVx6EEBGOxdgn2kAJg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793064223;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=zLKj+tm2+xd4P0rxJSTelLiTLlW20N8t7rTVhbjnamo=;
	b=WYgqW2CKEnxCHw/x5qtY01KeIlzMDCreUaXuqJ2p/sdeW9WuIjSGE5s+oJ5Hkij93dxs
	 lj8YQNI/dp76eENAKYeYl+TGLRgevuKFITxZBUzITedQWgXla3t1Eez9cNguOjiGE01rW
	 3Ko0kguGqKbPFEOa02CWlwwZRKWOkLWOXkBPV4Y8JsCZRA4tp6JMIteeWTjVoWqBrf/WK
	 bP7WSwYGivf3uLugPKD3xGYGZAVGfJkcH8PXweEIHsgSuKa7yqTg68lsd3ImOj0yjhfhh
	 yJfmFJyKnNgRNm4DGednznXBUyF4NXy9CHGVQwtvssbpm1wmMa/bS/Kjp78wDECR/lg==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793064223;
	bh=zLKj+tm2+xd4P0rxJSTelLiTLlW20N8t7rTVhbjnamo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fCGn3xZeSgwRsa9smHMlZgHMTbXK+HS9ARk7mKZAieINsMsZzs4ThxZtuEruVtkKN
	 N72gz/V0gDZfJ/42GEfzBP8mARWVsvheRCb6NprFyD99wfVpKRHuvV60EygRXZFIel
	 GgbUk1zolDiFiKcyogJS3fPaSdR12P6Vj/Uj72D+rpyvzypu2zCytu3B/sH+Sq0U/1
	 hWJ4sWm4+1L4yQYQmT4SMhN276wpHSdKRhvToEDHaUxewNf7lAO4fzdTtw17P0GFtx
	 fSMg3e+W4UUt6Q58PycF7GyTi4F3O/ECLAU3Mohu35gxFFFQ/LQDXK8ZOQYKu70eQN
	 o/xL0pNUi4h6w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 07386605F9;
	Tue, 27 Oct 2026 01:23:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 5DDCD2AC
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 01:23:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3FA1940205
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 01:23:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VbMNjHthEuy7 for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 01:23:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org ED6B540062
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::e33"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793064220;
 b=FpBCftLqn28jsS0N5jSTFbWRWZNCcjs86DwVmyHmd3RtHAgKA79scdShwDjz/zodjXdV
 fdf8NXPFZJNk52KowH0BP8UvsxRxe2afovnCVocJN06Awc5zd6LDp5+AjA9nXgeqTw2OL
 GEtLJD5Ybd1YHY014EQ3eT5jVm4pWbMbjh5MgmX+jJSzWSN/hRWholWx4y9EPN8oBW6As
 3LUCMNVgUVk9AC0P9RrY7WR669lQdMJJLVjpcsmh2LpsxHIGx7X/1nD7fW7D6uYdtWicZ
 fpZbEEe5Q54Kn1V3MkTSBO9dW8wt0i+ZUUaSy8Ecn72hRWO+8PKsli5vfLEZPamlesg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793064220;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=zLKj+tm2+xd4P0rxJSTelLiTLlW20N8t7rTVhbjnamo=;
 b=FaXnGyFV2UdAcSPmAoyt4jsdErR6O6nDHXO048hyW4GXR+lYjxKSyeKUQlp3DObbtz3R
 qVZ3xXfZLlA0Y1Rnri61UNMp0t3y7wFF1du7CVWN8MI1xVxwDbjYDgsijl8zsIFTmSjPK
 iOVEcHMAA3Pc+W5TyE+qe7c8jPW/Stc5zKoDtHjkE/vF8olX5NkhGcvKdFJR7i28VMCOR
 Ca9FPt80mh4esaOPaJHLF/x1i38JdqV/eMotY7d9H6E+TCLwmZ+0MavM0C1ZsQeG6X3/Z
 /NBW8IG6vYd/ikPvlk+gwQ1cZ9mkacZDgBth14geYH2WpFnhjQpI4oHE5E1tTtrLiDQ==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=nE8tkvYN; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::e33"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::e33; helo=mail-vs1-xe33.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=nE8tkvYN
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com
 [IPv6:2607:f8b0:4864:20::e33])
 by smtp2.osuosl.org (Postfix) with ESMTPS id ED6B540062
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 01:23:39 +0000 (UTC)
Received: by mail-vs1-xe33.google.com with SMTP id
 ada2fe7eead31-7c03744ef27so1162803137.1
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 18:23:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793064218; cv=none;
 d=google.com; s=arc-20260327;
 b=JB9d7myJVx41fVB3LAIWJrMLeVZ/Pd5lvlHYNMIkJJBzu1s78Wq4GmLpWbmk4wNhww
 2lbZE1TVsBjJXiFgYmZRDXmSrcu/p7yZ4SfycUHNmXMO6dGciqwKkyxaszuLJRwHv0Fq
 JjQdhSDxL7r1UGqp8bzTSvSpsGrNVsL3n9pfAGlnVVWegq+cL/I38Rht+BlQFgOsayGW
 DkRoQmV5pChEdyqy1OcqqQ/76bndpnbmo9HaQ7A/x3M0iEbq4mlLB7YBOepXiaUWyzvv
 x1dPXFrf2aqW1expihBbJnfa5hoNA/uRs3jEKBU94ItpHsJE/FYXqhiQD0mv+vKPrpMP
 qPZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=zLKj+tm2+xd4P0rxJSTelLiTLlW20N8t7rTVhbjnamo=;
 fh=ICfFZz6q9n+eR6cnJ9IsX67c5E8LVnUTDiIaUINNHG0=;
 b=p2Nfgv1tFDqVVkWM7h3Ag491iEFvVG/bC7lXHiUIxstL5tnmkoBk1y0hE/cD9W1rB8
 milM17RwmwrwmdWR+GCAbG2hBMtV7WTKqCMVdDmsaF8e0plJmzFuar5OwckFj7vB50eu
 NS4AyTz6O2k164ogimh7YGshSY6ysYqsOFy3qyp/JsijZwRxAT3B3n6a3tZnN6ZrAv5k
 vfh3kB8wQiuPopdgb6bqHsEJCoh+xLdeoGTYWScCooWhWNOF8x6KclanipJW3IaMLLAL
 XyiuRMh3roKzd3Gy1X9pC1vCRs1ggcnpB7Ic6zc3uAdoWuR0ll82irwMEUsVkZxUK4vJ
 IQLg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793064218; x=1793669018;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=zLKj+tm2+xd4P0rxJSTelLiTLlW20N8t7rTVhbjnamo=;
 b=nE8tkvYN7ItTTRZux3WBSPXjx9N103W5AMmK+aSKVJRdoSY6XsW5ioNrSYzG09cqYs
 pXpBCJGuHUdLTDerRBrZOKhSB3ZLEYHu9pmh01sB0PqPd8OxPeDklvf8iRMcokkCEZwm
 L+KoHyzGt/E5Y2gjMh2SHE5vQGYceCAOhMAoXTSyog31ofciOuwp59IxhcZPo/xER29k
 1Q4qJZzYPrCHk3BWCNcAsPOuCNIY/QyErQLFMZ+zUEaTZqMG4ETL9/3CDhQO1NZI7NbE
 RYVn1nlW1JfntraCW3ZmL5b/pl9gVIz6ePV4bg1cR6HHg9zXifZIsh7uMT9GmeMhhFl2
 iLdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793064218; x=1793669018;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zLKj+tm2+xd4P0rxJSTelLiTLlW20N8t7rTVhbjnamo=;
 b=16sTzSiRqaoaqfIcJ0TpJz4i04EAPb1VVJ1wMiMoG9to5Vy2JsZIHLOYC9i10cjgoH
 eHPrSAa5rFoRpqZFmnz8t3koev2QoRGwxOh8RhcRhzbxU7hFHXrjLmDOBIGDd7bMTqfK
 qBWFiRQEHCbB+iBzEv/zLBvAECopMBNWW+cESACHnTrS2cgruSiQe7EC4yy282BDK2Hi
 Y/xzEpLTcS4smn2+TSm9ugdasHfiB3LeU9I4VqlAJirYGPDqQLBQGeQrx/7mh+2ML8Tx
 ckwRNw66PPvgFh9h0BfOtT2q+0QV7LExuVrIgn36KQISxP8x9UdPF3Um+w3RGFEYn/Js
 MO7A==
X-Gm-Message-State: AFq9FYIDoWOJ5mDVzNJ9RCgG4SuZUIqUA3doeX0T99fSi6PpYSa0F518
 EoVW36Knmmp00sq7YejviDTFmTirWUemYyZcx1a6gQMcsWXrIOqsXIt8LR1QRUtGUqWTfrOQyPG
 hcgKT5uY5xOmiMbARE7nzfbushgyT5A4=
X-Gm-Gg: AYBFou2HLeFCyqxjtyl9TD+sJtl5nFGeqgl4BcQVwUXh05sDliSMoH7ptxdvuV+tljF
 2HjXuAJzgIdp29SEYNxYvYwU9dk2FjielY7VthAaWcqh3SKpIGS4urgoAHmK0VL+ZsMnX0UYVcy
 2cF0x8q5zyuqDmZJ+B5QnVZoB5Ew3PgGndUc69JGT+uUepiDXtArbVvJeXnL6DjixmhWttk82oJ
 g/akHxYBIVUr5iygp7yck6pTwhpe81FML9z24rNkbQbMZbGFNyY1jLAoaDFpt1uvyMvFIkONI77
 IoCe9jYNtwGFZZt29W/PruupCPk3/W4yTlGVwzx7mpLuW86rS5dVc8aHGN6Ys8DEcRdAJce4LRV
 /vSR9ya9CINTE8OCeupQAR3JYrWMbyfK9HaxKa9oh1j0fDWzRoMyjo6OFgia5gfjZqHbcoZI8z3
 Idlts71aufILXFMihiW/XKyWRsFrJzTJnjyNUv02BZnBJuOtkC9zpN5qzlGkm3R0Qj3VhpxZL/k
 zRJuz3pPQJCUusln7i/gSUalRmMVAQeGvj51oX3jlfEMrri0UU=
X-Received: by 2002:a05:6102:c07:b0:7cc:2cef:b341 with SMTP id
 ada2fe7eead31-7ce5ca7cbdfmr2754206137.4.1793064217805; Mon, 26 Oct 2026
 18:23:37 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261026212853.453191-1-marek.vasut+renesas@mailbox.org>
 <CADvTj4owSzHUg2xMqqw3uW_XFKbFXjN3bU48COrtxxgVzXaH_w@mail.gmail.com>
 <67a6e9cf-8ead-4efa-b943-68c856b307f4@mailbox.org>
In-Reply-To: <67a6e9cf-8ead-4efa-b943-68c856b307f4@mailbox.org>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 26 Oct 2026 19:23:26 -0600
X-Gm-Features: AclHuK9WhTAlJkZaQoia6UfgVylJEVK6RJgRoQMw0IeaU5_IbJVpeqaajsrjvwc
Message-ID: <CADvTj4r_aOjNN3a_Eyp=6T8DU0hL8baTrJaMQKV9vkADfHow_A@mail.gmail.com>
Subject: Re: [PATCH 1/3] net: lwip: Make timeout configurable outside of TFTP
 loop
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: u-boot@lists.u-boot-project.org, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@arm.com>, 
 Lukasz Majewski <lukma@nabladev.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 26, 2026 at 6:47=E2=80=AFPM Marek Vasut <marek.vasut@mailbox.or=
g> wrote:
>
> On 10/27/26 12:59 AM, James Hilliard wrote:
> > On Mon, Oct 26, 2026 at 3:28=E2=80=AFPM Marek Vasut
> > <marek.vasut+renesas@mailbox.org> wrote:
> >>
> >> Make timeout configurable outside of the TFTP loop invocation, and sto=
re
> >> the timeout in TFTP context. This is a preparatory patch for porting o=
f
> >> the DFU TFTP to LwIP, which requires a different timeout than the LwIP
> >> default one.
> >
> > There seems to be substantial overlap between this series and one I
> > recently sent, maybe take a look?:
> > https://lore.kernel.org/all/20261024-submit-lwip-tftp-combined-v1-v2-0-=
0f663f735ee8@gmail.com/
> That seems to be quite intrusive, is all that necessary to get the DFU
> TFTP working with LWIP ?

This is more just a bunch of general TFTP LWIP fixes, it's not exactly DFU
specific, although I think a number of the issues had DFU implications.

> Also, are all the LWIP changes being upstreamed back into LWIP or are we
> starting to grow U-Boot specific LWIP fork that would be hard to sync
> back with upstream LWIP ?

I think I had posted a few upstream a while back but don't think I really
got any response, is LWIP upstream not particularly active?
