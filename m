Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30823606A31A
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 18:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=yg8jj8TW;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lI+HIjaY
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DC97A60A72;
	Thu, 29 Oct 2026 18:07:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6-MBOGEXiX8a; Thu, 29 Oct 2026 18:07:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D811660A6F
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793297243;
	b=gHFlHkIkngggplM7+aEjHh6j18JI1LwhMcbw1Hm0yXf6i8oSGPHz5cpjwbOLC24zQbgo
	 xz8ESvHUALmERQSP6RGlVG50lTrpEBt4zhg4n+Ps+BOGOOy3PfvdNLV/Q8vZbEXEElBS9
	 ne1cs32VTXxL/9SVA93KBnn2ju9vTDv9ZcEP2GVGeJhpunqrKda+UQzeRJjzNWPTuEP5r
	 A2msri7mBBfEVUsQQK3smdJnWtg+bRgbqP/vPreDMnwdvHgDqc34/jkC3khSJItmL919F
	 n5Acm/EF1nplZ50xmLvQzWBzMRVRXPSvX9+qVNVdvTtPafm2kpPcTCXWuj6OIQBgyLA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793297243;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=24w+nS8m81SzBiPKGn+mZ2nOgO4wf4xbtAXgAO4JQUg=;
	b=IYN2UUxrs56oDGdLU48jc3M0rc8SHXvuIf+mFD46fNVlfviw+tcfvcAG+oIi/X2JkZy6
	 K1Kza3k9j52zRX+dpH0xBN/ZMJnfeSzuDmhKfD9jDauCes3JTiXmhxmdmtkZ4rTSBp8oa
	 N/YioN3a3Fl9C2NCImbVw1cYPrQMWVxW//xtMGGm0QUHEuBN7qvZnw5MHVkqplda55kRY
	 bW557XBpL6tjQwzI+/11jDJZqAcZy42GAvcf/2E2r4XbNK9bwhE53CjVisUVpF0syX1Fk
	 m0oB3KUn76MFzTEY9IkPW/1NfPJspSiX2ws8getPy4s6iXo08ddZHFo3ToxHYcVofgQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793297243;
	bh=24w+nS8m81SzBiPKGn+mZ2nOgO4wf4xbtAXgAO4JQUg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yg8jj8TWAw+wkoF0uLOW8tIgkgFUx7HXRfkK/IZOhz5BdfMz+pnqpv6kmRpL5EicK
	 40I919/6F6P2WhQHpKUjafVoIy/b7cJ5KqaBfNIUpz44NbxEIHrC8nPgSTyrplht/+
	 FFbV/4WZPQ36BxdArcr3HET+JRqLftLoPBoKW2xFsR6s7nNINoc145cNcQKd+D7Kpv
	 O2xSIkvpXtASnAy8gWkJ4sVQMiyjtf42i26vVfc2CCHqFQdOFE+DuQBwYEpvcbU3kh
	 eGpsr+FaT0CasxrhlJHRofPerYFv8ybBPlzyI1SXdSEWkEe4lZp9hbrD3bXZJtEYhY
	 dxlI8MOlcBgRg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D811660A6F;
	Thu, 29 Oct 2026 18:07:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 3D204120
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 18:07:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3AA9080FD8
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 18:07:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OuYQCdbTvF_e for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 18:07:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1D81D80FC6
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::534"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793297241;
 b=Ua4biznO4klnixmt4+ZzCQLtPY1cJXnnfMld1ArvsX54O5JZiONOaj0BIhgQiVRYfkgV
 U0Ts7X0ZPRSbb0izNu+Ejcv/Cs63w4hsWA8kYYY7ik0YYQ7Fe97opJACoxihEMiFC3F81
 acLDobbiqBA4gJvWjI1DRCx6rks/pXBkNEgYToJ+3emvGoNZZ0gwPu3t9OqN6R7DJ+fCe
 eLyhoRpJzVa2aPpdinDjGohdB5T5v+Qwtwu1fZK/3f+1aKdQHHcdKtNdJoXuarQlzfdK0
 ZFIG1D9zsngtxDq8cX3WtbxENnEr1/IPOIX1WQxGrgsVJza4kfvuMpfHngwO6zUZYNg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793297241;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=24w+nS8m81SzBiPKGn+mZ2nOgO4wf4xbtAXgAO4JQUg=;
 b=mgZrp1Wtjdxk+jSD4rZE6/gJ2kBWgYOO2qmaTECCNomz40D0SB9Kd1VI3x6EJRyUeqqI
 FZDm5zK3GZCNbv2nu6dEtL/4vO+oFtNd9Ke6yqiiBQCpW/NcG7r7PEPyxpra/5T03YD7o
 XvLRKpCA8AawUHnRh60Psyy6NMJCmLmfCAbCJ34DhGxiPbMzgSfDbs/2kpWPcQPKD7NSQ
 l4qu8e/MBFLBAWOda+/7+s0/VGKYNMxdJI5bGCjXOl/bvC/X5FEjJwDsbja6OCtbXvUdo
 qujC5pNvNwO9C4NdXgwcpheN7ixAHtDYwgjrmPCKgxdK736EkGC/0mDerhsun9CrZZA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=lI+HIjaY; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::534"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::534; helo=mail-ed1-x534.google.com;
 envelope-from=massimo.pegorer@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=lI+HIjaY
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1D81D80FC6
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 18:07:20 +0000 (UTC)
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-6b1f31c63ebso1732372a12.0
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 11:07:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793297239; cv=none;
 d=google.com; s=arc-20260327;
 b=VvTOw4ikf1qCnSrEo0VAEIpfI3yjADzk0g0JlRyk8JwZ6QUTewpielLwXK3q+1WJ+G
 UteL/cRRVAGzNKvJ0O5TL26UepkoaAPwSAoubfrnYD0p7a1vDj9KsdtnayPKjwqLfdNU
 68qnS8y0/7MkXO6eK+QktsJ7oFJDVLHSgLkQdtS6LnWMhdQaX2SM7YV7OAj3erykBoQm
 2rdvKREFFahJPE9SWd+hXZ9iaMRjZ3tEYTjtFl24bjlIPG/6xv06UXggKh+/zSoivuRU
 3o+DlUg9RJKGr4wx2+4dOUKUKGm9eOzKTCCbUvrDJyFceqBQ1Ri7biGtHWrfRun7j/R8
 HCRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=24w+nS8m81SzBiPKGn+mZ2nOgO4wf4xbtAXgAO4JQUg=;
 fh=p2NDut/UbYEjNkH24PvUKHntCYFjbtrKten6B/X7hD4=;
 b=gdJE0NKP+jACbp5PZnUVPel6oZzQlojb1o380LG/s7PbIIJSgx6cFxf/H9xbJx53Gl
 +tZhmjLJQQesR54Vh0wQ6opjTzK6lTWejOLNEB4TpjR8Be8Ukq3A/rlllUBO8zOI1D2K
 DSr26ZlOtyw2j8kXpTUYQMGiNQp4mc6Z/YSJyRpn+aDhPSnoV1cmSQKhDe5J3/cyG3vg
 0Gd+U4bh9S3ljHlAYZToNqoDvOAeaY4nGYWm6m1GSkyXU9yrxYrSMSgBp0CTD3YFf/MJ
 oUzbHOaor3fvDSV/WSmxP/XMW6zZ0EVMHCGipbj+op5RpSjT2jgzEF7M+AElt/l9H3RQ
 nUIA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793297239; x=1793902039;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=24w+nS8m81SzBiPKGn+mZ2nOgO4wf4xbtAXgAO4JQUg=;
 b=lI+HIjaYOf1kueBlLVnTs3/jI29bKxigJvErzDrEp2IizvRKvPNnZFEuBuBPPoCVQ7
 OmODPDKmrBRoQ+ZUiDqhbgqNdUYS6y1rZdwjT5g7nPimQ5plQh0z2wd22jnNXTZVix89
 JNbGLG4TyZ+VIp9JOH1jPPAGMCyuM+o4X3ezzLFFakFQChN4gyM/kyUVE6xUIKd2K9Jh
 6/cyV8rvklJDTlRdxYMgicOX76lNX9qn+CZqvnijT5XFCufahTnCVICso/ESIeXXrqvp
 OyoPX+FU+AzFOG7iwcvhrOfz3S4CUa2eNNI3es99/uP9jc8AfnYWl55vLYOZc7mkGYq6
 w9ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793297239; x=1793902039;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=24w+nS8m81SzBiPKGn+mZ2nOgO4wf4xbtAXgAO4JQUg=;
 b=nJKY7o1bPfzsu8UnpunjsT0MZ+XJjVJkwPvxLETX2Ls3aELpkUhA1i8BvF15S6bex+
 eNgrMCm5b1tqHVAMHiHh9FXOaXstQtNqKJsnWV4uIAHEUlDwFo35SF2IltKcD9amKhEi
 XkcodNTcfPBQwf+CjOVqKaY9w4ib0sHmVQfdLpQqF5cdRCvLix5ciFafOlpjaSiGOoI8
 G5Lmrv3z6yQDYvrROat7sJU86hYjlGeB0qkJmnt//l5KweJn3W2ZbKyoXahmZ9qqZm+3
 5EyupOmnBUyrRr5Rauv/92wTZTHLmcAiqic644iACJKP3+AxXnFgyuT2rlHo/qvgXjVX
 nZnA==
X-Forwarded-Encrypted: i=1;
 AKwUvBy4oLLhTmIBemiRhgC4TfuZyeBjv5Poi51I7iakbS8xVK4jzNEYnVRnQjHthsidply3Y//g+xo=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIWiZX/TPKzmIGfo7Y6GodYIaeDSUO92gAga4S82S/+P2tv691H
 UgTvabrHA6jYZwJ0XsOQZOnnnt53/TkfG0GVMtg+Nlwl/0X7vIkrxH4u+s0GKIEHEUo0CO2cFFh
 nYs2NlHbFU2qfRkYtDjgJ6xJHVqL/B9A=
X-Gm-Gg: AYBFou0162YktwDFbIGbwyO1Nr01XbH5lJJmRPkgQMUYN6VySYVy9kOgkofntzJFP0J
 I+fAwjZqCag4fDbqypcBwZBI66eBxLNxnQmMKSsaj+RGz7DOlv0HgPpdYtMxkZnHAMUlQXiiRtT
 qcWi/riwlzWRRwM/p8jFJ4FddFoKCiA4Hwybq9GhuW/Es+UMGhE89+nJPTY0K+4TCkDABLrDuCW
 lNVqyvMvPgDc2OOeivJ4JB/MuWODABYp0Cls5lOp9AFy2bkmzG/XsW1Fe2kmEt0gqmp2/ehnlL8
 htkM1CTez3xlqmRFbYb3QFN1KIoc0JELt/nHFJgzlyvH3gec2uWQ9TnIWJAgL8d4MEVeMemkCz1
 5WXkTcQRoRaxkBYPOP66Bg4NEWupN67j5CjHGT8Y=
X-Received: by 2002:a17:907:d489:b0:c41:4512:a3b4 with SMTP id
 a640c23a62f3a-c49d13b6aa3mr310205366b.20.1793297238487; Thu, 29 Oct 2026
 11:07:18 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261015224222.1582607-1-jonas@kwiboo.se>
 <20261015224222.1582607-2-jonas@kwiboo.se>
 <16574e5d-6d1f-4419-8519-b1cc356797a3@0leil.net>
 <6a5e35fb-2bfb-4551-a9a4-2f51a1cbdaad@kwiboo.se>
 <179e0a6f-0dd9-48f1-a79a-3611ddb30cd8@cherry.de>
 <c5cf9db7-7d54-47b7-8cc0-2b677d17fbfc@kwiboo.se>
In-Reply-To: <c5cf9db7-7d54-47b7-8cc0-2b677d17fbfc@kwiboo.se>
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Date: Thu, 29 Oct 2026 19:07:06 +0100
X-Gm-Features: AclHuK84_tfO7sUE_O834gaEbDKzCnUYd8jy1PWnpzPbFxpQ5A9A99TJtoZgUug
Message-ID: <CAC928HYAw5KRcneXuYB_L8S+Aoxy=C1z6n9YNgZvj+fyUNaV_w@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] clk: rockchip: rk3568: Ungate PCIE30PHY_REF clocks
 when PCI is enabled
To: Jonas Karlman <jonas@kwiboo.se>, Quentin Schulz <quentin.schulz@cherry.de>
Cc: Kever Yang <kever.yang@rock-chips.com>,
 Lukasz Majewski <lukma@nabladev.com>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

Il giorno mer 28 ott 2026 alle ore 23:53 Jonas Karlman ha scritto:
>
> Hi Quentin,
>
> On 10/28/2026 7:23 PM, Quentin Schulz wrote:
> > Hi Jonas,
> >
> > On 10/28/26 5:57 PM, Jonas Karlman wrote:
> >> Hi Quentin,
> >>
> >> On 10/28/2026 1:41 PM, Quentin Schulz wrote:
> >>> Hi Jonas,
> >>>
> >>> On 10/16/26 12:42 AM, Jonas Karlman wrote:
> >>>> The CLK_PCIE30PHY_REF_M and CLK_PCIE30PHY_REF_N clocks are by default
> >>>> gated coming out from system reset. The probe() ops of the PMUCRU driver
> >>>
> >>> Are they? I don't have an RK3568 board so cannot test this, but the TRM
> >>> says the bitfields are 0 at reset with "When high, disable clock", so I
> >>> am not sure what exactly this is for (except after a reboot where the
> >>> Linux kernel has disabled the PCIe clocks maybe?).
> >>
> >> I guess the TRM is incorrect, because as I mention in my commit message
> >> these clocks comes gated out from system reset, or I would never have
> >> phrased the commit message as such.
> >>
> >
> > Well, it could also be inferred from the fact Rockchip enabled it in the
> > CRU driver unconditionally. So I wanted to make sure it was indeed
> > checked rather than simply inferred. Thank you for the confirmation.
>
> I would most likely have phrased the message very differently if the out
> of system reset state was not tested, or at least mention that it would
> have been a refactor based on current code if that was the case.
>
> My expectation (and practice) are that when something is definitively
> worded in commit message it has been verified to be true, else there is
> a note and/or the wording is much more relaxed.
>
> >
> >> See below runtime log on a Radxa ROCK 3B (from power off state):
> >>
> >>    DDR 5c7dbc4d49 kwin.chen 26/05/21-10:58:25,fwver: v1.26
> >>    [...]
> >>    out
> >>    PRE: pmu_clkgate_con[2]=6000
> >>    POST: pmu_clkgate_con[2]=6000
> >>
> >>    U-Boot SPL 2027.01-rc1-00097-gec7e6bacaadc-dirty (Oct 28 2026 - 16:35:51 +0000)
> >>    Trying to boot from RAM
> >>    [...]
> >>    U-Boot 2027.01-rc1-00097-gec7e6bacaadc-dirty (Oct 28 2026 - 16:35:51 +0000)
> >>
> >>    Model: Radxa ROCK 3B
> >>    SoC:   RK3568
> >>    DRAM:  8 GiB (total 7.7 GiB)
> >>    PRE: pmu_clkgate_con[2]=6000
> >>    POST: pmu_clkgate_con[2]=0
> >>
> >> Using following code in probe() ops:
> >>
> >>      printf("PRE: pmu_clkgate_con[2]=%x\n", readl(&priv->pmucru->pmu_clkgate_con[2]));
> >>
> >>      /* Ungate PCIe30phy refclk_m and refclk_n */
> >>      if (CONFIG_IS_ENABLED(PCI))
> >>              rk_clrreg(&priv->pmucru->pmu_clkgate_con[2], 0x3 << 13);
> >>
> >>      printf("POST: pmu_clkgate_con[2]=%x\n", readl(&priv->pmucru->pmu_clkgate_con[2]));
> >>
> >> I guess theoretically it could be the DDR init blob that gates the
> >> refclks, however running bare minimal TPL on same board show same:
> >>
> >>    U-Boot TPL 2026.10-01297-g83bfcb8d6e91-dirty (Oct 28 2026 - 16:45:25)
> >>    x0: 00000000 fdcc0098
> >>    x1: 00000000 00000008
> >>    x2: 00000000 fdcc1000
> >>    x3: 00000000 00000006
> >>    x4: 00000000 00000050
> >>    x5: 00000000 00000000
> >>    x6: 00000000 00020002
> >>    sp: 00000000 fdcc0f30
> >>    BOOTSOURCE_ID fdcc0010: 0000000a
> >>    PMU_CRU fdd00000: 00004064
> >>    PMU_CRU fdd00004: 000014c1
> >>    PMU_CRU fdd0000c: 00000007
> >>    PMU_CRU fdd00010: 00007f00
> >>    PMU_CRU fdd00040: 00002063
> >>    PMU_CRU fdd00044: 00001481
> >>    PMU_CRU fdd0004c: 00000007
> >>    PMU_CRU fdd00050: 00007f00
> >>    PMU_CRU fdd00100: 00000080
> >>    PMU_CRU fdd00108: 00000001
> >>    PMU_CRU fdd0010c: 00000001
> >>    PMU_CRU fdd00110: 00000800
> >>    PMU_CRU fdd00118: 00000001
> >>    PMU_CRU fdd0011c: 00000009
> >>    PMU_CRU fdd00120: 0000050f
> >>    PMU_CRU fdd00124: 00008bbb
> >>    PMU_CRU fdd00188: 00006000  (pmu_clkgate_con[2])
> >>    PMU_CRU fdd00240: 00040020
> >>    DRAM init failed
> >>
> >> Above should hopefully make it clear that the reset value in TRM is
> >> likely incorrect ;-)
> >>
> >
> > Wouldn't be the first nor the last time this happens :)
> >
> >>>
> >>>> unconditionally ungate these clocks to help ensure PCIe works in U-Boot
> >>>> proper.
> >>>>
> >>>> Change to only ungate these clocks when the PCI Kconfig option is
> >>>> enabled for current boot phase to delay the ungate as late as possible.
> >>>>
> >>>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> >>>> ---
> >>>> Changes in v3:
> >>>> - New optional patch to help delay the ungate of PCIe ref clocks until
> >>>>     U-Boot proper
> >>>>
> >>>> This patch is strictly not needed, however it seems very unnecessary to
> >>>> ungate PCIe ref clocks in SPL when PCIe typically only is used in proper.
> >>>>
> >>>
> >>> Considering the kernel seems (I had a cursory look) to be able to
> >>> control those clocks and have them handled via the pcie node, it seems
> >>> fine to me to possibly not have the clock enabled by U-Boot (e.g. with
> >>> U-Boot proper or xPL not enabling PCI).
> >>>
> >>> So, I'm fine with the content of the patch, not the commit log. Can you
> >>> please confirm that they are indeed not at 0 when reset (and/or that we
> >>> do this to be safe when doing reboots) and rework the commit log?
> >>
> >> As mentioned above, the commit message has been correct from start, so
> >> please be explicit about what you think is unclear and needs to change.
> >>
> >
> > You could have just said that it doesn't match the TRM, that would have
> > told me that it was checked IRL.
>
> I did not even notice that the reset state in TRM was different, all my
> changes are typically confirmed using runtime testing ;-)
>
> >
> > I can reword the first sentence to
> >
> > The CLK_PCIE30PHY_REF_M and CLK_PCIE30PHY_REF_N clocks are by default
> > gated coming out from system reset unlike stated in the TRM.

In case, I would add TRM document version (1.3 ?) too.

Regards,
Massimo

> >
> > when applying, does that work for you?
>
> Sure, please feel free to make any change you see fit to any of my
> patches :-)
>
> Regards,
> Jonas
>
> >
> > Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
> >
> > Thanks!
> > Quentin
>
