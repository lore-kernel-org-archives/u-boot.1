Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ECE7C5AC67
	for <u-boot@archiver.kernel.org>; Thu,  6 Aug 2026 21:02:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3F4DD80F03;
	Thu,  6 Aug 2026 21:02:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id swW_4cIn-gcy; Thu,  6 Aug 2026 21:01:58 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3C4F780EA1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786050118;
	bh=BsnFBHcl6TsfdsNIwTde09HEyv/2b0RFxykrr7WTRcM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hwDHQvyrYG5oV8JFwNWcxrQVirpr8+JDvsJ9XZD6CqYxqODkezS7Gc6lYii/+/VWF
	 ucrY9x8sebJnkXPVS+4r8QHouln5/9Qvqvc9XT8VzRAEpMo7e1idzwt6zGhB3PWF/4
	 vO5X/FTDr/4sbLOB/Rq8yHltG9/LIoDMj71JAgOxYhyF+wN13iqj85SJwX0s8fNSiv
	 lGB2rwlGDqxItLeQzBgg0WOtqplCVN/vFJ0yH3kdFT6/kuhFC12So2egT5VnD6K50w
	 6AMHO11NqQh5/t4lh+58VpQ8RiMMSKlOlfOvDi5qmKWdScQvHC2bZF2FtOrIemXH7f
	 Mqz4ijLF1xWLQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3C4F780EA1;
	Thu,  6 Aug 2026 21:01:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4EBA5218
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 21:01:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 349DE605B7
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 21:01:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dcm0aOpRlafu for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 21:01:56 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::530; helo=mail-ed1-x530.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 29B8A605CA
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 29B8A605CA
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 29B8A605CA
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 21:01:56 +0000 (UTC)
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-69f7fa1c548so4216522a12.2
 for <u-boot@lists.u-boot-project.org>; Thu, 06 Aug 2026 14:01:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786050114; cv=none;
 d=google.com; s=arc-20260327;
 b=n7S91H9hBN/pCz3gsj+YSZGNXnwc3WOGHZ61e1880nKSvYiOhjPw2RLhZBhJcrSdHa
 SqLRXnOS2Gwz0wBt/yxxNE9d0njxxuI1FbERQ7Wir3B9oHB5ux7dnjLfmHi7/qFzh+r3
 D+wYeykasHug5QgHfdK3O6dLtRJm8nK59WykVKTA/N2qivU+MvchUWA879PVklW8F9/Y
 ukyMwak1hCQLYGNcIvznhB90Jk082/07SrfhN9Vd6/Eq0I8oMNRfx7NtpGkou3ER70Vd
 +zGWLs905WculcxAuisUfi/OUQYCImgoW7gvRAiwnbEdLT/Ffh+X9LafHErupXSxJZJg
 DD9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=BsnFBHcl6TsfdsNIwTde09HEyv/2b0RFxykrr7WTRcM=;
 fh=Kr5LEl8VO36nO9QaObL4rekpGgXWGRt6UPOr2FjZHWc=;
 b=RgU1t4k6OLx5T83GdndyBtDpzeE8SwoYrMEwN/f2fP2y0531uNqf5Yct21Uw3lQSDY
 l5uoPa5oa/wGSZZA0XevrF6OFT8ZDtuSjvRWRb/IQDfMiz0eJe1qGqym5ge78HAlApHF
 L8jFUQl/2+WwFoh1TPGY064+UaxTy9TbRGOgnE+oXi/v4NXQfd06z28i5xqCXtCCqLYu
 wOFl3TPtClbpC18CD1manhFo5ZrcqwanuDn7uCFsyD7lwz1mDpFR+ke3wSowiQPQrGYA
 2HdjFnQJyIPBvY5y0ilKqd2CJIiVlZDQNTJ5VyL2rPFZLNPyz3hINVNB9XzkuIYvKTQ2
 Cn1w==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786050114; x=1786654914;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BsnFBHcl6TsfdsNIwTde09HEyv/2b0RFxykrr7WTRcM=;
 b=YiUfIpo7axc0GpEpCXuMzjyktC/BE5O5g7J909n41Mdhr/SdJ+dKBDnNtwLtstw4Xa
 nbEzi/HbnD1LsXg0gb9RmQCm8Jlra8IFgeiVxBQqjHXz6sSsipHAnR/rXOC9Ut75SbOe
 L9otz42eyZBg0LdntHg7JwoFmqQUqjhs0YD3DeNE+vu6jpy0VZlZ3zf97GNqm2C2VX2L
 p1I949h5TCZQEANv2vAGwO4RyiIqmthk8R29n+YTWQgF5FOrGhiEPu82BjJY8onioBfh
 i62vv85iUE0UKFsxLsYWrESSpdCmKV1ppRnKdJoOb+XID6IErbcJbIKgjD3y1yt4Fpaq
 ltiw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrRonK5Bi4ilnH2Gf6vT/+DYIcQRPlXp7k2rwwqCRoIoiAXeppq/gwTGPF6YJLEMnUOtmPG4XQ=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YwHXyoavmDvyvJWkbtvs9Z3kA8PYVBIhqstWynu76O15QVk8Rku
 5LbaEcitBL2rC5Vhq2VEXNLyAAVB6NtQ6bTHf+fwQIJJaVe1RCQ0Ym1twLJK0dfbCVa3aDKyoVh
 NJxWt3RQsWyS6jN1ORpVr4ew1jmTC+rlik+8/O5th
X-Gm-Gg: AR+sD11ZVXSbAiaRG1QMR2CwvYwc3+O4u5bSAUu9c+DlR3QqaRnCe+8lIIwtF+DKBnh
 UyGL6x8H8t2fLUJTadzbGpCd3uV37B3vS4Ck2tZXLlzend+gDIkAonPFZZbsjdEMU43c6CZyeVS
 l89FSEQbwjbY065cnYtIWqzbq7gK+BFkC/B9psQQZSjm2bzdLgLui3krTAIn0Dj1y5CbWbz/vq8
 YyX9ORYkkbWm53elcv5cPT3myCHNWAJjSapX9Q/RoeSMuZg+Q4h3KenNr9/r1AOqOmUXO36NRlt
 ba0KPOtnzFk9i0ahkuYamYEegqLWhchecg+11YYlvR8=
X-Received: by 2002:a05:6402:5017:b0:698:4992:77e7 with SMTP id
 4fb4d7f45d1cf-6a14f09cde4mr9318560a12.7.1786050114066; Thu, 06 Aug 2026
 14:01:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260728155624.86989-1-marex@nabladev.com>
 <CAOMZO5DA6N6Mv1uD7vG5VbfooB1O7BRqE2TQNmUQOuWTF0UrZg@mail.gmail.com>
In-Reply-To: <CAOMZO5DA6N6Mv1uD7vG5VbfooB1O7BRqE2TQNmUQOuWTF0UrZg@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 6 Aug 2026 15:01:40 -0600
X-Gm-Features: AUfX_mzcnKUo5mneS8BC6uK1a-8B3AB3jtqhrS5BPsSL1-4MxB6iRquzPDdS0Mc
Message-ID: <CAFLszTgv_dynEnDcc-ngVHJFk0NRvt2aCfEqFG0PHwqMg3jstQ@mail.gmail.com>
Subject: Re: [PATCH v3] binman: nxp_imx8mcst: Handle FCFB header during SPI
 NOR boot
To: Fabio Estevam <festevam@gmail.com>
Cc: Marek Vasut <marex@nabladev.com>, u-boot@lists.u-boot-project.org, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Stefano Babic <sbabic@nabladev.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1786050114; x=1786654914;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=BsnFBHcl6TsfdsNIwTde09HEyv/2b0RFxykrr7WTRcM=;
 b=f78YqrapGdPz3YC5mVKqh4oM//eXKxqxK4ZnRRG6Ix3AknnI+9mKkSjRiUPY1DMu7i
 3MeTxDEnq6hNNjW4EFAkkKGTtks7buMAADgJyoUQaVAMkt7JNfSyi64RLp/64Amys/Ab
 4ez8tiJA3JK/HzLYcicxUjKk+6rk+vw81czn4=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=f78Yqrap
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Wed, 5 Aug 2026 at 13:10, Fabio Estevam <festevam@gmail.com> wrote:
>
> Hi Simon.
>
> On Tue, Jul 28, 2026 at 12:56=E2=80=AFPM Marek Vasut <marex@nabladev.com>=
 wrote:
> >
> > In case the image that is wrapped in the nxp_imx8mcst already contains
> > an FCFB header which is mandatory for SPI NOR boot, then the IVT is at
> > offset 0x1000 instead of offset 0x0, but the whole image including the
> > FCFB header must be signed to prevent attacker from tampering with any
> > of the headers. Add the FCFB handling.
> >
> > Signed-off-by: Marek Vasut <marex@nabladev.com>
> > ---
> > Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
> > Cc: Fabio Estevam <festevam@gmail.com>
> > Cc: Simon Glass <sjg@chromium.org>
> > Cc: Stefano Babic <sbabic@nabladev.com>
> > Cc: Tom Rini <trini@konsulko.com>
> > Cc: u-boot@lists.denx.de
> > ---
> > V2: Update the block comment to mention the FCFB
> > V3: Add testNxpImx8mCSTFCFB test and document the 4120 figure
>
> Could you please help review this patch?

Reviewed-by: Simon Glass <sjg@chromium.org>
