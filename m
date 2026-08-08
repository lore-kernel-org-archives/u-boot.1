Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C9AFC55174
	for <u-boot@archiver.kernel.org>; Sat,  8 Aug 2026 09:02:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 212F580F5B;
	Sat,  8 Aug 2026 09:02:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5-gFzInkSK3m; Sat,  8 Aug 2026 09:02:25 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2C5CF80F5C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786179745;
	bh=ywzYzmSCrjAnl8SHXScFhEr7YOEbmvGg8UWiH/J2mgU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GOIMBV+43ynviZzu8qJgnDznblQBBOa0h4eY9/1JBpLr0Ape6A/irT8/m0bMJhG2w
	 Pr85yQnjk/VCbGKrUo6c8dLd1RvHslLEGmcUKzengRndovVU50Uzv/AfNYHqmHym8F
	 jgjJExeZJcplf/qQCidHTz02sdpR3+TR8freHr63IMlwFfJoFq6q2ABO+0UhdmsVpR
	 Z6mFmzJAO9SuJqEgcji/K9Ovf08G568jWOnuFnes7j7opRq2FnBGPgvfUYineo8+f7
	 H2mp3Nb+ohlygYf8jpuVT2xKcN2uRFN6iPhYWrrBNCfh7dNxzUTb8HiGPfecFucRfU
	 Ftfd65XyTwKmg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2C5CF80F5C;
	Sat,  8 Aug 2026 09:02:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id E5A1A2B6
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 09:02:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CFC1F40096
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 09:02:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ARund1FSDu59 for <u-boot@lists.u-boot-project.org>;
 Sat,  8 Aug 2026 09:02:23 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::532; helo=mail-ed1-x532.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org CB2B740056
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CB2B740056
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CB2B740056
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 09:02:22 +0000 (UTC)
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-6983d3dae7aso4279492a12.0
 for <u-boot@lists.u-boot-project.org>; Sat, 08 Aug 2026 02:02:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786179740; cv=none;
 d=google.com; s=arc-20260327;
 b=efLgjupKvidMIo4CslZKsiOj4v8lpsLw/dHm2YdQ5jzqMAMv7h+/AgaTtF4Dwjtqxv
 Dg5jeAu1UNeo6fsJp4WiCa3SgsnEl/WxFj91QYRm1ryJuZ4E6W9i9QbHCxtGRxWAR+Hl
 oP5BLNzhccka4PBUWFbE2HdOsTBMKtyJT8ChZjMfaL7m9h8Eypqay1zQ2U8sZdFlhAOh
 DDsGEV5Ku0ylChqN1BBkQNa+nl+Hx7krprzqSt6pn6nWKqtbg3n1qh+7jM0x1MkrgS+a
 dd/WhwIXzE24Hqi1Ins1ztpdddul1lyuLiPVljbDoqFQhFex/mMRKzjyKhaNQ7So/wDp
 x17g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ywzYzmSCrjAnl8SHXScFhEr7YOEbmvGg8UWiH/J2mgU=;
 fh=oIMmC8iu+RpL9QS0aPIrVHvb7dY/DmDKYgM4/PZle3M=;
 b=YeDS6ZDeFfNWVcx6g0xTl8TFG8FB8mDqC5UofxRCxrgFJtryw592a1w9QjIEy5ttY/
 v+YKTTGiR8I4CHrriu+EtNK9LrMDHMYCEe6SewQrnSfE70D+cRVohqBQuZC9F3eV/F1w
 HH1W8MwX87ztcwS2shy06vxN3FSW9wXohVP+t4XDkPyXl3QiFO3GeAMWqtHSzoKzMu7s
 Xb9Sst9fV0GtZaJ0AmWXIIaQ2JOCLa4+DSepBDG8+W8hu/VVWrAj8FFNcCgXXbt7uZv4
 7KO+9LUiyu6H7HafpZAX/hpBONaFbKot16idO/f2A6T16eWSE8j4pNlTOHtVHO1v9YXu
 rjTA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786179740; x=1786784540;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ywzYzmSCrjAnl8SHXScFhEr7YOEbmvGg8UWiH/J2mgU=;
 b=ryLcjoq+YUFALti9pk2yWQp0LwfiBgvefwjZsrwW/5I6Gtn2SNvUgugqnDQUUP/NNp
 AljcZJjNY28fYrZWVOkhTvI2AjPCZhuXMumLLwQYvZ+RIbis+T0WKQlasAdMzIqy+vdh
 Y1g3EsykktajHQmUW4nqdO5wIEtMVuo5rxe/o3CRa6e+Ez7eKSJFC+jLwKIolldg5lms
 /7EHJHq1/A9EaR99VpXSy7FQ5Sb2KQqA+HVpi/Xg5S4f/LfpKlWQmrhty2bRVRBhGNF+
 ATljz5pSFhhZR+1JWWJh2QKmLDR/A8gIpW4WzNbcJdQZDiezVz3APquhNdGoxO2ixa2g
 mGSA==
X-Gm-Message-State: AOJu0Ywv96+Gls4pYgsSuNniF5iHDTZVZGl0CpIQ7znvCvaxF/TWnOy6
 bUXVGca6Dk515Ut6Qx3JK9SxvElIkTaGjoI1NKKXxtOkuCUSgaOkAPjT7J7w/8+6CUnrWTvtxyH
 9e9cCeD9wCWVPL3uZipWqajZ+iJy1oOTvjWcrvSfRpQ==
X-Gm-Gg: AR+sD12mhzZe0ZRIje2oAHVmfIoVZQJNWmF4wda3FPTT5QVMkJ6AKSpaTRGNc9hFJaG
 83sacpRWoIlG5N3tffb6IaH/spuP54gp5bYY6uKLOxR2DfEsTx5zstsjGCHZ4oW+nFCOL5dd0vV
 Brk5yBcuZDGq6StUZx/ELudccocjoL9bujbGJs11hRMxQhn453BSqucCYAYo1QWVvPckgsDx0Q7
 hWLI+ExXaq6oui2GBCmaBKIjVFPguuqw/5S2KKmxueNtqzS7OXgKqf8k8Anko+R1iWmZ5CXES+p
 ElagH3HzwEsQdQczMjySfoOd/wgSMROZ+Oz8X62k5Ct+NfOW3HQjdUCpu3NiMEFUZXGbNMCpHig
 P
X-Received: by 2002:a17:906:ee87:b0:c19:5bf1:368e with SMTP id
 a640c23a62f3a-c208d4f5702mr198195866b.13.1786179734091; Sat, 08 Aug 2026
 02:02:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260805-pylibfdt-geo-growth-v1-1-dabe082367e5@flipper.net>
 <CAFLszTiJK9JFDe30ZfaXkZvmNUfWUVmC8ZVLU0b-7vfTsHaQ5w@mail.gmail.com>
In-Reply-To: <CAFLszTiJK9JFDe30ZfaXkZvmNUfWUVmC8ZVLU0b-7vfTsHaQ5w@mail.gmail.com>
From: Alexey Charkov <alchark@flipper.net>
Date: Sat, 8 Aug 2026 13:02:02 +0400
X-Gm-Features: AUfX_mx6PEP2L3XfqSGAiW5UFbwPCmf3zarIFMwBy8pdtcdfpFh8SPuJSTHSdso
Message-ID: <CAKTNdwHyab4T-02-YjSHqmEVHYVXmZSZ9FqYWzpvUpt63UUHEg@mail.gmail.com>
Subject: Re: [PATCH] pylibfdt: Grow the FdtSw buffer geometrically
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1786179740; x=1786784540;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ywzYzmSCrjAnl8SHXScFhEr7YOEbmvGg8UWiH/J2mgU=;
 b=4t5R79fdcX+rRoJeCWDXS1gcidTJuQsdW529fGK1fDRntcS3uLloVkjo/kyRzWyFyL
 x29Qd52JshFM/4QgVdv0IQBOCIYFwDDf7T8DgTWo1oAVT3SEhgOmBNJJ3mQqwzPWxIP/
 vmVsx85ga/WOlJd1mM3ebF73+rUWUMbV28FCMsGvu23o5iZiAJmFgIRZN/VQYbKw448E
 zGE0cK3zeXlRzCliYS6H5uRRtMEYv5kgY7lUDlNSm29GdjnEP1c7KLWX5KP+8mMIF34k
 oC+za7UUrm7eaZRm0qdmlD3j9Tq/S070B9ohfwhteDY1wmQVl4PIYi5CQ9gR2q5NwDen
 3D6Q==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=4t5R79fd
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

Hi Simon,

On Wed, Aug 5, 2026 at 11:34=E2=80=AFPM Simon Glass <sjg@chromium.org> wrot=
e:
>
> Hi Alexey,
>
> On 2026-08-05T14:47:38, Alexey Charkov <alchark@flipper.net> wrote:
> > pylibfdt: Grow the FdtSw buffer geometrically
> >
> > Every expansion copies the whole tree into a freshly allocated buffer, =
so
> > growing by a fixed amount makes building a tree cost time quadratic in
> > its size. This is especially painful when assembling larger FIT images =
with
> > binman, as it assembles the image with the data inline.
> >
> > Grow by at least as much as the tree already holds, which is what varia=
ble
> > sized arrays usually do specifically to avoid such excessive copying.
> >
> > With this change, building a Rockchip TF-A+Falcon image whose FIT carri=
es
> > a 31 MiB kernel takes 33.1 s rather than 44.4 s, with binman itself dow=
n
> > from 25.3 s to 14.0 s, as 7139 reallocations become 187. The images
> > produced are byte-identical and the binman and dtoc test results are
> > unaffected.
> >
> > Signed-off-by: Alexey Charkov <alchark@flipper.net>
> >
> > scripts/dtc/pylibfdt/libfdt.i_shipped | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
>
> This is a _shipped file from upstream dtc, so any change here will be
> reverted on the next resync. Please can you send this to the dtc
> project first (see https://github.com/dgibson/dtc) and reference the
> upstream commit / PR in the U-Boot commit message, similar to how
> a63456b9191 links to dgibson/dtc PR 154. Otherwise the improvement
> will be lost.
>
> > @@ -808,7 +812,7 @@ class FdtSw(FdtRo):
> >          if check_err(val, QUIET_NOSPACE) < 0:
> > -            self.resize(len(self._fdt) + self.INC_SIZE)
> > +            self.resize(len(self._fdt) + max(len(self._fdt), self.INC_=
SIZE))
>
> Logic looks correct - doubling gives amortised O(n) total copying, and
> the INC_SIZE floor keeps small trees from taking many tiny growths.
> Nice measurement in the commit message too.

Merged upstream: https://github.com/dgibson/dtc/pull/189

Shall I spin a new version of this one to mention the upstream commit?

Best regards,
Alexey
