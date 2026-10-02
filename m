Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F33D4CA5FDD
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 19:13:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6DBDC40DB8;
	Fri,  2 Oct 2026 19:13:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pKg6dO1taN5Z; Fri,  2 Oct 2026 19:13:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org B1BF640ADF
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790968400;
	b=qZE3yFmXDJMqyas/tu2n8kjDQCu3eE/X+1afLhtntx4pl0q1jHvCsrMMAMrNfbLNDMEq
	 K4PDmO7DMbSfSl1f8JVc8EqVTu495cVoCzsMyksaU6SIVt6hHzWjr7nTnowkBt5VMKQeL
	 a59vv7E27d1iVRN5TKC3hkKOr5TnbNqqrQzu15wwqVb9tDXPkMPYftuPrcXenoj76pN1/
	 FfQOsY87EnCkXr3RoIFJZuZy0gtxLz8Fm6IXJzAXNN3j+cDAlKh3vjE133WtaMPIgE2UU
	 MnR1tHgEatapurzcFhv0ETw5hL7u7nnYxm9vDtzIZlykokQ4OZ4H3ZTe+2uLPRYivfg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790968400;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=HZLir80gapi0TeOu05kgTtkMEAxZvaPx+vTHP5NRGXc=;
	b=OnWQyrn6QTydmP8K/SQNRASCA8Sf2qaULw007MaTsoKJnIWSoHbmNkwGfywUZgGRyNJp
	 F3c6xUayd/jqMUZ2Cct4onousPuGDeFSo2OJFC6w2bbKoS5H99hhCocrXjxGz7no07HWc
	 OsON5WQVdsasXHf/Cs5aU3sdlT9CuBafGI/iiqYjBrHk2/b/lFuVvEUZ+KE3Aktw3ksvm
	 r1RxqbM5EktwadwrI6OTTvaoeoiRO6KTGqiYYrXyAN9peOVzfNQ1VZkvumPawNuSVCC/d
	 E1AxFfLr0UdREtZCdwF/aYsSdvH7kHYJWZMnt8v+A8QJ8TrR/NPEQ/U5k/xJRdTdWAw==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TC9NlZ+W;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790968400;
	bh=HZLir80gapi0TeOu05kgTtkMEAxZvaPx+vTHP5NRGXc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RfgQI+FNJL6kJykIoeC8l3aMUifMD6WH299mZtSw59jKkmp9G9gPklOYYxH7EyyOZ
	 Cy0Pq2IekV08oeVl1c2kFqcOYeW3iAiq/FrCp7yetG+wyuKSYBiMK8/R8NOVuLtihh
	 PNt0JKr7GtQ/xToAqRKj7l9TKgMXcCV6uwykIRJQM1mTPxsU/MAVjXg1w2VU69sOum
	 kaUuPWOeElEMGA+q3EXz4teX/zp0ihA7HdAwpMGZ1c+EmswBD7XqfQi2gXp8Vx165g
	 WlOIQG1UAsfqMwvQXXTausUwReIaPAE2kNZAoUr6qQ9KHMAiFxX76x9Zr1shGcV0P4
	 7HGBKzhm4PRDQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B1BF640ADF;
	Fri,  2 Oct 2026 19:13:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 282061D2
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 19:13:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1A1B240ADF
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 19:13:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id r9BC6rk5BOL5 for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 19:13:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 59D2E40A77
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:41::2b"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790968398;
 b=c6xTIwzknLcY6leIG0D/ci0VGyvNpu2iUFfDryWxz7z4urlC9ZcFzt8D68GTprzb94V0
 AKUDl+hGM3Jf3tnv1rLJxAD8nhahg+vksIUHMj6/vh1Lb3RWPLepXrV63zebIew6eGzxc
 lZH9PziXNVdw2k4Na2ATCsmrEG4UAzbP8LneHyST6tB4b3I8hUBfsdkpZBwwbmzOg4Xcw
 VNrck3FD5SLkmRWP/Zs02dc/tDl3Q/qjul/JdsND/TRGevDIPXKpBiQQvmwIumhrBEWAq
 wK+1ONIX81OXv4589j1pGlETbxcSV7QeGGD1R3l18P2/MUepVUPpRyJwcsNZq2GRnaA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790968398;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=HZLir80gapi0TeOu05kgTtkMEAxZvaPx+vTHP5NRGXc=;
 b=MwMZ1KDwJIRMAwxZRESrIqxRZUvsrP2fW9pK1I1cVCf3PXAcF66j5E1UfoCyX2V9Ux2z
 RLYWar3uLk54cZK0DX7Cl76pym9NqjqQqN+mDJ3lwMDeS9T+9co3xc5B4L1L+3NRyPUMa
 geF3Zh+4sDEuuVBVY2RM0fK9P3TTjiW+I/Rq75VFpFmpc8oMHpxTapyamNXkoeulrOJYl
 k+1dQxeYnwuKxZqojxApnxsaHhfoD9cOvbXxE1lKz9yW/o0yWQOYA+g3gtqcnr4XnBBZB
 hIMk1XJwqhdf+QBBoLowndCMjQBD1xLkrWivnWufvfF1vjBmhtESauRiJiBnStfew8Q==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=TC9NlZ+W; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:41::2b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:41::2b; helo=mail-yx2-x2b.google.com;
 envelope-from=mibodhi@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=TC9NlZ+W
Received: from mail-yx2-x2b.google.com (mail-yx2-x2b.google.com
 [IPv6:2607:f8b0:4864:41::2b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 59D2E40A77
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 19:13:17 +0000 (UTC)
Received: by mail-yx2-x2b.google.com with SMTP id
 00721157ae682-8aca30a369cso33065667b3.0
 for <u-boot@lists.u-boot-project.org>; Fri, 02 Oct 2026 12:13:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790968397; cv=none;
 d=google.com; s=arc-20260327;
 b=cGZo2hBGhVs/lQFq6mWJIXqlfIphzQ7F8Efe4ERYDTC7oj9XiyVgaKqpy4kPTy2AT7
 h0YZy5FIB0X8J4Cdr81p54Hb4K/lTGDe2Tm5vtgbKq5q99Vq/quVR70IxQgRSZygyRwV
 OgEPIbgBvkTJLSNv14bAVzhtkaHsuqz2w+Rbzo5C5h/w8BEomyCDIP3Wmn45t8oqsUls
 LrzbJ9u+UibeiTeUu4d0IWuryV4M7ehjhNBDNEV2vnVVmPLKmfUBczfq5Vr/+anjAgWz
 k2Iu13NqZlzPapEli7Efp21v0Nzmtvbop8zwGVIPFgKcpW0XNLWjoqBPW2XhucJM3m0L
 3mHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=HZLir80gapi0TeOu05kgTtkMEAxZvaPx+vTHP5NRGXc=;
 fh=xyhvjVQhvAiwBAzAt4vERCTXzNkwUATgRVAt8FDGV0c=;
 b=dd+3EdiEHO5Q6/qdHHcAYnFGt0UIN7trp0QpNrAoYuTaahyUAesplXPM0FJ+SjhRD1
 kAlJ1qTmk5AI3JTFMK5vZEp8QYthdek5xS/d/PlUR6yTlDLQzKhsuGVdkP/p03u+dgkx
 jh0Y9IeYLicCMbtEuygdBG2t0szFItQdfVZgWNKdq9aJ4BDQHSxM8RNaqIwAkTzPnlNK
 J6nmvxiq5JxpvpCDyDaRJ0mDc+aWRpLkErsiSFzWWJWON5ZTCiySrkA2FlcV1YtSFCTd
 N7RUy3/mopvrNl7a2GxlbKhukPcj8LDFmKelj3d0QHDsrFH2kzF6zGUaN/jQIxKw+j9e
 0YoQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790968397; x=1791573197;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=HZLir80gapi0TeOu05kgTtkMEAxZvaPx+vTHP5NRGXc=;
 b=TC9NlZ+WSrXyVnka4C3AgLsMIEnWPXaReTT+VITlB1MYeQoTeR3Wm2lWFO/lOAhG+u
 OrdCD7ax6tpFPO9+/dYkpZUCjZJnzKvx2isxO/ZSaLLL6fOhp1OkoOnsZG6USwiwgN36
 4CTUGYtQkMkdCDNvvhgYVwd0JeWwtCH6L8haeu78jHz/n/dhgjRb7F7iJgAXKUhJoOsf
 w8cAODx8SH9QhDyAo02UDvr1Mwju+EmpJnprL47giluzWVzxTmaWeU2yV4znBNiFggfb
 GMHCeLtopDgjiQ0j7dzAYYGeXWVBOaPuUtObCmNud6OGJzWGQEIr3kKMTx5tdcmYhAhx
 pbqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790968397; x=1791573197;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HZLir80gapi0TeOu05kgTtkMEAxZvaPx+vTHP5NRGXc=;
 b=zLVtE+eQ7TheKy5lVmeRNUxWj8eNPucs6mgMwCKL8cO622mT5NBEM8Za0k3flBJk3g
 89RVKg08XXRhzZBB16ycybE1Yt6H3n2SUKbGoU1wWWrE8i3slPUKjKr5l47vgd1ROm0M
 alhYfFNR0oFwzQaW59k4UNi/XMLooWh3bsJ8RkCX6vOdMRpTxVJS2/XnryVM89M/MR/i
 OK4hFYaM8GqPC53DTGaXt0X4gFDRu7q5vzV/amD5Px7y3dOWwu9rajU7CYeMJVrPrUta
 zFpKPjcs+maJuEJlpUOlR/xRt4hD9XS7vZFB779AOd7a+o7BazEJqrrORKgCoReHzE3T
 tiGQ==
X-Gm-Message-State: AFq9FYI1mgujxYv+QsP0um1sMwdpkuFRY+76jwQnlnCBG+9M/MeesNgx
 MIf3D3qH9yB/MnTy6gKAOPgrN6a6hSOQ3Qdx0UYJyJ7t4Kwbm2cHzV2NFfwLIF7QBrZqapPPhUA
 9R2I7u/oWrSfAdrQ9sBcbLORqWNbikvY=
X-Gm-Gg: AYBFou2o8kf4zizNrOK8FxHAGgOwzD6JfpbgE9WjREZMUpn7Hc/n1iZAcKRaFt/QW3A
 A5bSp26jPicm7Ve/TnL4hzDMLmMsv5+COsaCHdLe5x/3G+AaKfROkd5Rs0OzG+y9XTSv3FnYDoy
 SfrHjjMwu6PWTfNoTISf6X5KDW6i4/DpHS+0Yfszli6tJJCfYTAUa4xatntaki3XjSZ7+/vOV7d
 E+oJVuE7t/2rwpj+/ucQaMKUkHDZ3hxv8jU/KD9visgxWePJDYuHZAt3im3VQMO40mjd18bvxV8
 Qlsf6g0Jr3udgTAH5MQ1Te3A2yirNH+Ec0ZXk2br/tdfcdq64jQWuBVU
X-Received: by 2002:a05:690c:c50f:b0:8aa:2207:60b9 with SMTP id
 00721157ae682-8ae399a42f2mr19882787b3.20.1790968396682; Fri, 02 Oct 2026
 12:13:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260914-nsa325_configs-v1-1-d4089f3f5bff@gmail.com>
 <20261002093156.2238815-1-stefan.roese@mailbox.org>
In-Reply-To: <20261002093156.2238815-1-stefan.roese@mailbox.org>
From: Tony Dinh <mibodhi@gmail.com>
Date: Fri, 2 Oct 2026 12:12:53 -0700
X-Gm-Features: AclHuK-kIIPMAj9qpJ8WpZ5UYvrsGKd6m5D47xQtgEXaduvaKOMmbQ7h7GhJm4g
Message-ID: <CAJaLiFxcfVWLNEFWRFD5o4x7s4NjUNH7f5t_-oPv7Fb6iqYwgA@mail.gmail.com>
Subject: Re: [PATCH] arm: kirkwood: remove obsolete configs for Zyxel NSA325
 board
To: Stefan Roese <stefan.roese@mailbox.org>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>
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

Hi Stefan,

On Fri, Oct 2, 2026 at 2:31=E2=80=AFAM Stefan Roese <stefan.roese@mailbox.o=
rg> wrote:
>
> Hi Tony,
>
> On 14.09.26 22:24, Tony Dinh wrote:
> > Zyxel NSA325 board has been updated to bootstd, remove obsolete configs=
.
> >
> > ---
>
> Your Signed-off-by is missing, so I can't apply this one. Could you
> please resend it with the SoB added?
>

Weird, I do have a Signed-off-by in the patch. Perhaps because b4
added a break line ----- before the Signed-off-by line when I sent it
as a single commit (without no-cover letter).

Let me see what I can do to get rid of this.

Thanks,
Tony
