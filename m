Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D6DFC4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 10:26:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A86686A6B;
	Mon,  6 Nov 2023 11:26:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JWFb+Bof";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2A0A86A6B; Mon,  6 Nov 2023 11:26:27 +0100 (CET)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC02B86F9F
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 11:26:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng.cn@gmail.com
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5435336ab0bso7282872a12.1
 for <u-boot@lists.denx.de>; Mon, 06 Nov 2023 02:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699266384; x=1699871184; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mx3WVl7SzkkvWaHJFSsRsz7744X7W5VF+DWQ/WTxOPU=;
 b=JWFb+Bofkre9I6Boj1BdzB44O5cOp8SCHNWHS7EYJUriGqrQg/2abRPcML5wNbPLeq
 joSOlqeR27a5y4ENjve3iCxwJmDWhrBrPW59YzuaHhw3/5gLUpcZr1SrdrBwvFp5nLG9
 TVyttu5NG8PB47xtqrn9WThDmhozS/4TjNpcrz2lAQ6dgK+0wvNwD+6dJl1R+fdc+j8I
 CJ+XPxYQYXFwjMDBiiph8iyNj7H5WEGVAdA05fnCdqIMdXoyPq3zOgXLVEdCncKQaXZT
 tT4FmD4QMDKaFyeFz/kD77rbAFUd6BsJWXg6J/7EI6Gn5mCmwHavlw7jrJrOsVxCBEcv
 Kj4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699266384; x=1699871184;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mx3WVl7SzkkvWaHJFSsRsz7744X7W5VF+DWQ/WTxOPU=;
 b=wtlMtcAeJeoEX0oGfUB89qC7DMGvv+zeccCIsYllKIRV9bdgO67PAemwbHN7RGw0Nf
 z43UaKKF18lbdTWhcvrlNv0ZpRzd84X0R+ied95IoJxgtnXle+9Joz8jjFyR9/LspJp5
 jm2oh2mZ1mBzZpd0HYC7ItnPNJFyRfBjohg3+vcYQxFn9rQdceH3dvfCWm4JTUEwvPvr
 G/SgDLsIcqiQjNsm5aahwocDlWJpo74f43MbGps+xOUotvkOaTQ3bjbgNDHTb/y/NVCt
 aoVblx/LXPYCZt9RDJwP9MOOYbzoIrc7AkRUtEAsnz1zmwDFsmO3pWRBGGz9toc5jLev
 6s0g==
X-Gm-Message-State: AOJu0YyfPy3b7f6gb5pR/g9mqs95nWkapkN/7w16sbcsTIK0GUiksTJ/
 8zNIwC7WT1YSxzRbB55rlJj/LQka9rm2c3qgT24=
X-Google-Smtp-Source: AGHT+IHfMh6sIFqm8NFPDpu8FqWHBbUt0F6DVmo/VL9FTqAFzis3O/KarEtxG3jMCYsxzVL+2uYk9KdutIuWsqNEd9U=
X-Received: by 2002:a50:a698:0:b0:543:7138:ca92 with SMTP id
 e24-20020a50a698000000b005437138ca92mr14883150edc.30.1699266384267; Mon, 06
 Nov 2023 02:26:24 -0800 (PST)
MIME-Version: 1.0
References: <20231002011450.462468-1-sjg@chromium.org>
 <20231002011450.462468-5-sjg@chromium.org>
 <CAEUhbmWi9phnvS1U=z1O+8t7kK5mV=JLw8=YJ4A_u3tcrPSXGw@mail.gmail.com>
 <CAPnjgZ1CsWJa2Ta8fgbGmXZsvpg_BMFDRJmjqPqu6d+7z-TXxg@mail.gmail.com>
In-Reply-To: <CAPnjgZ1CsWJa2Ta8fgbGmXZsvpg_BMFDRJmjqPqu6d+7z-TXxg@mail.gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Mon, 6 Nov 2023 18:26:15 +0800
Message-ID: <CAEUhbmUD9E+DkA4jq1tLMSi2ZmBLmOnB8x7jU74fL=J3YYNk-A@mail.gmail.com>
Subject: Re: [PATCH v3 09/12] x86: Enable SSE in 64-bit mode
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
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

+ Tom,

Hi Simon,

On Mon, Nov 6, 2023 at 12:29=E2=80=AFAM Simon Glass <sjg@chromium.org> wrot=
e:
>
> Hi Bin,
>
> On Sun, 5 Nov 2023 at 14:05, Bin Meng <bmeng.cn@gmail.com> wrote:
> >
> > Hi Simon,
> >
> > On Mon, Oct 2, 2023 at 9:15=E2=80=AFAM Simon Glass <sjg@chromium.org> w=
rote:
> > >
> > > This is needed to support Truetype fonts. In any case, the compiler
> > > expects SSE to be available in 64-bit mode. Enable it.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > Suggested-by: Bin Meng <bmeng.cn@gmail.com>
> > > ---
> > >
> > > (no changes since v1)
> > >
> > >  arch/x86/config.mk        |  1 -
> > >  arch/x86/cpu/x86_64/cpu.c | 11 +++++++++++
> > >  2 files changed, 11 insertions(+), 1 deletion(-)
> > >
> >
> > I didn't suggest we enable SSE for x86. This is the wrong approach.
> >
> > We should rewrite the Truetype support codes to avoid using float/doubl=
e types.
> >
> > This way the Truetype codes can be used on any other architectures
> > without the need for the compiler to emit explicit floating
> > instructions.
>
> I am not aware of any such library. At present, enabling truetype on
> coreboot64 causes a hang.
>

If that's the case, we will have to either:

- Switch all U-Boot builds' to use software float (e.g. -msoft-float)
which unfortunately depends on the compiler runtime intrinsics.
- Introduce a Kconfig option for hard float enabling and let each
architecture to decide whether it implements it or not, and update
Truetype to depend on the hard float.

Regards,
Bin
