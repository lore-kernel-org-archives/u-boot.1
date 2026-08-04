Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16977C55ABA
	for <u-boot@archiver.kernel.org>; Tue,  4 Aug 2026 19:17:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C22EC60634;
	Tue,  4 Aug 2026 19:17:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9vo5q7iNQkQj; Tue,  4 Aug 2026 19:17:44 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0797F6077B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785871064;
	bh=3FojU4CMkKnshoI8cQ39aA9EQDQWxrxJTZl8TOj2Sks=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BxhuyqomqWUbHvpvqx2GAvqwj+HUVFLluqT06sNoM5wDX5Hbd+6hpaTH5vwdwRYxu
	 HM03SIpFo7xyy26QV9iD7kcgGWwSKQ449KZaaYQHypmy+6RvpwkloYSa5xRZ71oFvx
	 /ThyMP+3wq9nI+Xgb2Cmly0ztbGif4DvhLrYFI6W2HPn/87e9yNkpquFLO+g/+TVA5
	 tNfjOQ74XrwsEQraiDsJ0V8xdmd0ZIt6TbBF2ODg/vEcV4jmatQ2W99/7L37RDKhdh
	 2fGD4y8x4Ks/mh8u/eyvg4TNvpi3fHD/mJthy09HUtn9hxKViGqOVL1G21eAnGtYcx
	 7DSd2ggEOvA/A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0797F6077B;
	Tue,  4 Aug 2026 19:17:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1556A218
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 19:17:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 070386077B
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 19:17:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OCTvXNJxI5du for <u-boot@lists.u-boot-project.org>;
 Tue,  4 Aug 2026 19:17:41 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62e; helo=mail-ej1-x62e.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org F330E60634
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F330E60634
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F330E60634
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 19:17:40 +0000 (UTC)
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-c169ae1cb26so236018766b.1
 for <u-boot@lists.u-boot-project.org>; Tue, 04 Aug 2026 12:17:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785871059; cv=none;
 d=google.com; s=arc-20260327;
 b=q3gLKwNqZLFOrKBROIlce3cujNB/Ab13L9gCTdxtH9jM7I0KYfUe8B7Y5EAzNO84/W
 FGWKMhb/DGLH24RZ/9VLs8GSRRtxz6cd4a6bIsf2e5MzAC/SYCY/FDFIRWZjhS8mDyFk
 GarQXffmnP6QflCRufA+0k52aehFob1uL3te4liNv1O/V3tsOg4oOQe4sY7/2U5UgNol
 86Xo+7F9HublhMbrHdWn4h5uM5eJUfaSSxO7sYdhHrUbnxOGbD6WIUOt/gBxu8R+gC90
 8M+lf3bHRDfsOp6vu4E3kXnInFxlW4cEwVCPEGDQFchbM/hYy2GH/Jl4PDyxfwJCb92c
 CfGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=3FojU4CMkKnshoI8cQ39aA9EQDQWxrxJTZl8TOj2Sks=;
 fh=a9rA8Tjmrcu8J9V8SESgNfyW3lpWOvJ02WECYd9EIng=;
 b=A6/62mdoDI7ZOP+A4NUGTLGORTZNN2UCJ2hHxFiKOOx5fx8gySnrFG6upacmo+uyjl
 0Qi5Ev3hFOTzPWkpplNyKbdrTqMdxo8n/Wv/xLkneOO5AFh4d/S8X/BtFNMfn29eYoy9
 4nkDe2f2DXEHDP3ceT08eC+1t5bEWJcxRZNSneEEw1o2JlMEy884qu6pMRmYcCLxZLWa
 u/i8wh8A72GzOpE2v2svFVIHYX+a6Q2jnRMfkni2HUnM6f0Nt1dzMU74OaMuUccrQbD/
 mLr9QiqgmWp4mIOJGh56f1GHT5jvHRXk7c1XXDfATaYFz1pd9iGHn5xilb/uvKlVdys8
 3ETA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785871059; x=1786475859;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3FojU4CMkKnshoI8cQ39aA9EQDQWxrxJTZl8TOj2Sks=;
 b=e61ylwCcOFhn0ZfiEOXTHxsV2vwBnzQjCSVCQtb8YeLIz/BvVTVNMQQyCyDRl+6zNW
 ikk9b0IC7+Jhr7wgmcz8gTTp3F6/N3PllkdeMvIUjtWYOTnG9VnqS0pJdQ2wsz6Zjjbn
 fEh6LARFPxuOP57cHgfgsxFKnQRtKvC24nvV8ORutS/fk2NteUbNBSavylhXSRLKxBvH
 z8JyWPd584Y/8Ls2Mz9rYEmmwcNOLjJx7zaIIFw3b+V0K17nCvpSf09blAMLq6nquOlh
 PzAT8FIxgfOiDQmbrHklzlZnru/2Xo3Xtd5S9bV0oGQgkZz4+xzzUo5nWD0oCfN3SgUB
 e+YA==
X-Gm-Message-State: AOJu0Yw7pVjCFnt/7aqGbTGFBniYjpfu3yrzEbiagc/CQfPCVPEZtLoB
 KEPSoAls9NenS2ULSLxfdktlOmOEnNPQTNc+2q1IdRvYo6NeBzdFnap70aOQhVIsowdguCi6tLL
 1C9mH1EOzjIcgf/M6BTTrIWB/wwDfqPS/AzfKBQixuzlq5aE4eX8=
X-Gm-Gg: AR+sD10XU0CtrbkwIFowlbKY614BL3M3QNfqNaZQWwNb4nWSsTdDj8N5JUHRSNyBP4c
 6kcPpEAfIJoforpmT7zyA7L0soKuVP9ki8tVl6M7YO91wacyRARA04g3kLGiJYUpClgbbtXlLKF
 w0C0Cxl0MLx46GdBJcDrF6XWwE3wQZxUJDhiS33IgultqWzMd6GBAej7C2tr60S7AC3QgeHyamK
 ttZZbMzrNXBEW8LEOY4d0Hqx5SrjCSy/P7YEqx0nR7B4QZ8DHMPSqBSaeuD8xzJVa/l5s/MOQVL
 cQSwSPuAs6bB3EEyXqOIwVJ0tBCC1hKAGzBUj7JUCGg=
X-Received: by 2002:a17:907:c491:b0:c20:2164:2dd8 with SMTP id
 a640c23a62f3a-c202483cde2mr543941166b.14.1785871058944; Tue, 04 Aug 2026
 12:17:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260731-atf-falcon-v2-0-acb97c172993@flipper.net>
 <CAFLszThEcG5J7vzmAe2hFXEu7vbCzhTiT5QB9v0ib6c6C8pWWw@mail.gmail.com>
 <CAKTNdwH2EHkj1-zcniKCB5NGU8w8oBfVzfeLsVuYZFX61eG6fQ@mail.gmail.com>
In-Reply-To: <CAKTNdwH2EHkj1-zcniKCB5NGU8w8oBfVzfeLsVuYZFX61eG6fQ@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 4 Aug 2026 13:17:23 -0600
X-Gm-Features: AUfX_mwNVm-Jrowa0MFymUhalrNZZtMBT7NafFBjP64W5umQVZMHSHAM7Qo9-jY
Message-ID: <CAFLszTig8TguQ=9623qu=tjELa-2R+ja1fPnJt4A0r3gWG7Hgw@mail.gmail.com>
Subject: Re: [v2,
 00/10] spl: Add support for Falcon mode with ARM Trusted Firmware
To: Alexey Charkov <alchark@flipper.net>
Cc: u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785871059; x=1786475859;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3FojU4CMkKnshoI8cQ39aA9EQDQWxrxJTZl8TOj2Sks=;
 b=UGzPo8Wt/Q/tWwb0v/CxugWKnmLCOlvrKlBMYEMudQJZDca5N9PPrrse9y6kGTWRJ3
 l+3sjec0TcronqUKJ3Kh1b6jOuhP21jdCkoDaN/F1nK6RQmSFKEWyh9dfKmYtjwI+uud
 yIVAM+yOxfTmlKx7BdBjv2wE2vzux8qM2sC6I=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=UGzPo8Wt
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

Hi Alexey,

On Tue, 4 Aug 2026 at 08:47, Alexey Charkov <alchark@flipper.net> wrote:
>
> Hi Simon,
>
> On Tue, Aug 4, 2026 at 5:05=E2=80=AFPM Simon Glass <sjg@chromium.org> wro=
te:
> >
> > Hi Alexey,
> >
> > On 2026-07-31T17:10:44, Alexey Charkov <alchark@flipper.net> wrote:
> > > binman: tests: Add test coverage for a FIT with embedded Linux+initrd=
 and /chosen
> > ...
> >
> > > This has been tested with an uncompressed ARM64 Image as the payload,=
 as
> > > well as with a GZip-compressed one (using existing SPL_GZIP functiona=
lity)
> >
> > Just to check - is there any test coverage for the SPL side (the
> > atf/UFS/Falcon-decision changes in patches 1-3), or is that all
> > board-level? A sandbox_spl test for the caching behaviour in patch 1
> > would be nice if feasible, since that is generic code.
>
> Oof. I'll need to check what the sandbox SPL implementation can do.
> The whole Falcon thing is quite SoC specific. Let me give it a try.

The sandbox_spl tests are fairly limited but there is test_vbe_vpl.py
and also test_handoff.py - it's not critcal as we have lived without
coverage for a while, but it would be great if you can figure it out.

Regards,
Simon
