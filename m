Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471A4606A327
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 08:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=NQvBXmLs;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=dr+ZQNrQ
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2531F812D2;
	Thu, 22 Oct 2026 08:26:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zJAdwPhh2x51; Thu, 22 Oct 2026 08:26:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 707C7812D1
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792657572;
	b=ae5BDH3vM+KmHuVOttVmVBDQzFz0ufcFnPnbzP6LZtdE7RCR8S9AWeVNNfTN7McKfjyi
	 zTAT7WdwqFQjJg6Rs6TDnxQtWEYowUVagOaKoVO9WM8zmWVPIlS6wbtIz+yGd6xXo0Z0z
	 oYEbntD3ZKGx7yNHXCLeR3hbdXWphRuNgIMXlo8tS8QYbaaTodZwKURy5vO1EL9nTR+re
	 31UyeMBphiAaCSit3viR+yuxgC8UlKiNdMUI1/dqddjSSkWcOmw3eCPoM8jUcwaTNsGmn
	 piAQesaLTw4MJleawbYKQWbXPAwtu+srSsvg5uA1Hqv0HBYtYEgZ+6WW1Bqg/Ka7kag==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792657572;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=5mygt1M2GrBq3u3mkZP2M7fS1YRHL1ZLI/xGo+lgE3Q=;
	b=hbQMI8QafIxNRE3duC1emGCC+JSJuLCq2VUnpvhwTtAntbJE1tXU42fYJ03VLVghnLtG
	 YXdYwQqbIrYhy5qB/K+sgqd4UMJRj/E5U+zwfNKYdSIH+k3IdPI/8aXDvCdTMHdxEEDN9
	 1cVI+nUBUt1MvJL9SyGj9hw/UasjFtAntmD7FsdwNoPrJa/E2PL1dl5JR1cxOMxqI6w2j
	 ecpmgUj76mkJOd8nTwpZ+TZvV6hQghIgQqoWnwBgtNVIMXNeDQXgtWXTZMoHQopoXectH
	 SewKqiwdtJ+UOHdm1Nmu0OL404KlVVgUy1TmZjPEHJk6LoxRJuda90c53qV0zzF4lEg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792657572;
	bh=5mygt1M2GrBq3u3mkZP2M7fS1YRHL1ZLI/xGo+lgE3Q=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NQvBXmLsAt3qpXvxlg/OZUJK6o4bulx5kuV7APV7Dg9y2FZvp93wUqsCHs6sW8NRR
	 DWatLExX5MqSrmDiC8pPJAhJ1/Ln15FKWRbORqN9uIqBAj/MwDIxPVcjoJYpA9OGEW
	 dTA8Qek0CL5sfZNGT4VqLblaYd0CKhuAwDEI4Zh7h57vEE0rEblN0PjAwtp9umUw3j
	 l9vxBbUB/ExjQE0yBBE33QK3D/p7XXcRPczELyP/ydP/JhPjSSjfZ6Ht9Z2moHmiOc
	 jC8phDZZwSk+apSZoA0yfdKhXA/XwkdFfZ+kgktBwBhPw1DUcmDPBGUQ0sahqchzTY
	 ISmRMr1RBcrRg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 707C7812D1;
	Thu, 22 Oct 2026 08:26:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id F3FD0371
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 08:26:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id F13EA60823
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 08:26:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4LTJAn7a0Ymr for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 08:26:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 718CC6081D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::102e"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792657569;
 b=q779S8dgQsZGDg5/6S4L5DpWEz9kC3SjZ0kYDUWXuRbI970OfNx99ylqQjUMhzy/77Ej
 24814a/q/RYOhuabYQzJBO5PvREUtQwsLu6XvBk3kiips2t87WwAsQHEBudJZwGWE/0w1
 3aq7MDGDOc8ig63ZeWkrfiTO+kmz4TDZy6AuIspBXDmaEhzItbu/9Ak7HXmz5PvLf58Bh
 OR6ChxlM37Uz37AE8payObqDduiAhlkLlabRWniaaDQZrNADMmokn2uOBzrXBUyKqqadC
 Zyy9r6beHFpF7hbGvLdJ0F+29glyhK+ohMJzujWwZlULyavBUfAnRsrBbOprmHLEMGQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792657569;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=5mygt1M2GrBq3u3mkZP2M7fS1YRHL1ZLI/xGo+lgE3Q=;
 b=r3gDLnJyFbWstpElt1gMIk+FkmpcY0a+LKWiQ0gANyvVLjMPU0Q+OpgnC3ZViHpowauv
 wt7/rCnZVOxbqT51JQD+4wZixr7V3LUUDi7V1jvOi9a9SGXM0q98RHvkWsWuZ7VRKLljk
 KdiwEB6/zLmgTGvlq6gggV2zdEIWmawX03jKes5Qurk0u7uHCdmawqSCx38mEr8WCFAUP
 tyDsrNyiNRRimp1TwwIIOuU7SxE8DvmK3wzH/0NoDiNvQKYHn2NnXnbr9lertBTOj7sh1
 gkutUMKQIRjflIUuMNzZInirJDtDB1ADzqg1Miu/PhFFdsPWxW+DkwtgAUekOXasFGA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=dr+ZQNrQ; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::102e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::102e; helo=mail-pj1-x102e.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=dr+ZQNrQ
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 718CC6081D
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 08:26:09 +0000 (UTC)
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-398b3c37877so1036708a91.0
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 01:26:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792657568; cv=none;
 d=google.com; s=arc-20260327;
 b=P9RSZNWXwvoCsPilNYlCxfmMthBSuDBfiCZ6AuGSO6ijfF984LmIAqnBUrOQRBGpws
 BPgf0DTfqPfD9yn0e15VYw2MlUIVETQqRxXBg92YdpEM4C5itV2Msou0zx0jSD+Le612
 OSf6yO6+Lnfas/3ni5K64GYV0iUb9ee4GtzQY05I24u5oHhxsIiumyCKiBa3zKQ6NVyF
 p36LSkKrZ/0HszUMv4yNVj++vNgFHXA5ruGoNv1gpcuyaZOKoEEBGgKNdUomEk4uBSMN
 r8XsBMA8U3/uXzh16YwiYmzo4B9vqdiPRxnkBgmAPimuKev50/XVF4M8J3myLtNGcGLs
 MuAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=5mygt1M2GrBq3u3mkZP2M7fS1YRHL1ZLI/xGo+lgE3Q=;
 fh=m05oYs1G2DNTd3Od/MykNtmHjkHTaiDE16Q5/WMsH/0=;
 b=LjAC54C9of26f9C3vnPu9ZXLV5yXpkFEyqkpUqmJzPqnCVspGkg4mY5WCdyxQ3bQTQ
 fYCm4zB7uXuX+wVnPuB+wLnOtzh98Jd/QQDK9PYpvy98iz8lyOhN2+/G1vXwRc5tDSBT
 d3gR0P2BDupLqSdzE4+7ey99TUZfWYTg+chQop7mTzpnuFvGd1T439XrVibuvrypTHwR
 /hlD4z5G3iEeZ6Jeh0ZChidv9VzOiT9hUA6xExgvsfysjDPzVjVbyk6icdGpkoJkqAez
 ewMeJQ6KISABNa9UIeG83nhnUp5mfJB2ACKX1qxL2pzPaGNeF9RmMwfACybsI4kMWe+X
 FudQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792657568; x=1793262368;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=5mygt1M2GrBq3u3mkZP2M7fS1YRHL1ZLI/xGo+lgE3Q=;
 b=dr+ZQNrQxArxAPV4ea9R0AQhfUOIQW+tsZg2v96GN0ZiM20aN/X2s6ZY8PGhEKGUJi
 FJSvfaxC6CdbrI0JDfHLKCqkkcyf/7cMpXsQ/p/WbPlq07gPB8QsP5sn4FNdoyxvgQtd
 X/khebQUdmPWWADBbEPIOmGE3j1cSojzYJZx0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792657568; x=1793262368;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=5mygt1M2GrBq3u3mkZP2M7fS1YRHL1ZLI/xGo+lgE3Q=;
 b=U7I+WoVMZcYoLsCaapv05osEdquNbVJJ6NrSISlX4s7mS2uVZaF+QfkvDd/0I9CKM6
 0YMT/nPXYWhsi0/qD7Vv6JfIbIQR48pji9u8kaqPlaI1GC+wcwvJPM2pvtLQ/4OJBsUm
 RHCRzOuMIqmhHRrPiWWO9D22bCNvo1uaPvMyoxNyLVQ1HFzf184yESIngvbgy/Pu9oyX
 M+yH9zscebkRYyZFNI5oLpjfajcGxWQvNfsd+5CsxORIEqSL9sy3sWjsuIotRT2OQz5l
 ZFjzvtLlEp2yhSiQShg3dSV71ebdBcb2GubZKji/NbEfFcPEEtPtu0ImZgIoEMTJ2HO6
 ZbvQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxKY9/wjl623DX+JE/sagbtgun/jPn/P1ADHfac8+Du+ievWXYAyLIS356zG6Z1bHki8jy1FJc=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYL9TfJYdusGDhYSSljFwVYn/E4CVW7YASKhcvjqgU5QS80OJ/qJ
 ccCGZWpkyCCrwOdCkWOtZjEtaMffa4byOha6SMC6zwC3L/BcolyxDo4xAOJHeS6nyWBDWWZTMGy
 kCgjfBa0W1bL4Wx/O23yYl7iYYRsu8BxGjWyeiWj0
X-Gm-Gg: AYBFou2BwOkQylrVLzcKGhG3crZzFtEgbsjfN/ZoCwDg19A+V5quUWjx8axguR+W1eT
 9BrvxPSs4zp9y/Y2jNbgGxqK7jbKULSGwvVVPwcKLe9eL9qXRADhaOHKNCwYEhiyegeic/puTnS
 0Y0seycn2u2P61fcIEkIsBB6BivavVhi7cen2evDS1qQkI6q+Ia/bf2AyBt4ofMJ2/auVT9k/7x
 tKQgInmQyVbPh1dKzT8TY6R2K/iH9NXDVN+HkERqaCvTTX0HVoRFcw8c6tiYkvMxeyYxdTrWu/n
 ghm+O2+XniuO+zsxSrYSorf/MQwpOseeC1LU7RtFSPNcVMK8i+IuFiXkchHm1qjxgmqu2Tn9jqv
 d8LGK44SZj+hFa1hDVA8bp4CYPS4RLauSy8j+
X-Received: by 2002:a17:90b:2d0c:b0:3ab:c674:cad1 with SMTP id
 98e67ed59e1d1-3ad86d39b6emr3906321a91.50.1792657568450; Thu, 22 Oct 2026
 01:26:08 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 22 Oct 2026 01:26:03 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 21 Oct 2026 10:09:07 -0400
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261020-test-avb-fixes-v2-6-997f8f04fd3f@kernel.org>
References: <20261020-test-avb-fixes-v2-0-997f8f04fd3f@kernel.org>
 <20261020-test-avb-fixes-v2-6-997f8f04fd3f@kernel.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 22 Oct 2026 01:26:03 -0700
X-Gm-Features: AclHuK_H9-z6lDcZIWAA8j3gbClq0cXldjmJyJY6XLKoVwv2ebVsM1ZDcuPEyUs
Message-ID: <CAFLszTjVn2ccwVEwTfOSx-VoU70D1BXhj6zWjBO5DFWVYOnCNg@mail.gmail.com>
Subject: Re: [PATCH v2 06/10] test/py: android: Add setup_android_v{4,
 2}_image subfunctions
To: mkorpershoek@kernel.org
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>, u-boot@lists.u-boot-project.org, 
 Jan Kehren <jan.kehren@emteria.com>, Guillaume La Roque <glaroque@baylibre.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-20T09:25:49, Mattijs Korpershoek <mkorpershoek@kernel.org> wrote:
> test/py: android: Add setup_android_v{4,2}_image subfunctions
>
> To split out the logic even further, do each image creation in a
> separate function.
>
> This will make it cleaner to add future images as well.
>
> Reviewed-by: Guillaume La Roque <glaroque@baylibre.com>
> Reviewed-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
> Tested-by: Guillaume La Roque <glaroque@baylibre.com>
> Tested-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
>
>  test/py/tests/test_android/android_image.py | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
