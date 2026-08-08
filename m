Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A242C5AD4E
	for <u-boot@archiver.kernel.org>; Sat,  8 Aug 2026 19:13:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 54FB760689;
	Sat,  8 Aug 2026 19:13:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cCsIMbyaZ0le; Sat,  8 Aug 2026 19:13:04 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 874956060D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786216384;
	bh=Kv5ETN2k4aLOdDzXAFROnYzWQx6jJxRs2gukBTr9IoI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VUKd7qMEUadmVFml2zhOVT3vII7hunLdbB0zYnIYnLFwMA8VyrwKeWs55XYNa8A27
	 ZZdgpv57AyFwIaTOAfutnBYkoLVWOJUyOgESk/v5ASH2a+QI4lGR6jo+CfFYdfWr5g
	 fiyuSGPQVe5Y9eNrgh1WbKhlQkO82rVsTUTujoorWs2gR4aNd7uYSqAi8P6DMnDnrR
	 9Hr1mnsChtbhKrnK2Nm6EGqW1GVFKGgzs3VjvjDNC741dZQAqBleOh+gATlpx4zOMn
	 0Pd4PW0FMaB5Uw6imL47REB9ryrnxfcyB9nPjDfQ1ZIc4f3XHgcrbXfgZSAE+8FvY4
	 xItUBnQknbc1g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 874956060D;
	Sat,  8 Aug 2026 19:13:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id AC09A2F5
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 19:13:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 929DD40065
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 19:13:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id F74OCBSjlF9o for <u-boot@lists.u-boot-project.org>;
 Sat,  8 Aug 2026 19:13:01 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62f; helo=mail-ej1-x62f.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 7C28E4006A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7C28E4006A
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7C28E4006A
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 19:13:01 +0000 (UTC)
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-c15ca7a7ca9so51488366b.0
 for <u-boot@lists.u-boot-project.org>; Sat, 08 Aug 2026 12:13:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786216379; cv=none;
 d=google.com; s=arc-20260327;
 b=LTTvtcIZ0r090nm3Nc0ba2Kl49cLI+rJWIQ4LALjZX6JkCHSRjCK0BUzNGPCcYILcU
 utOHvgmX+HCv3fcNT6qsmRkO/0oHzLHUu1CGR2YnV+ZZZUunjZGhtjN6sErWqbLd7S/D
 /Y9k1xr8V1mQ5IRnuXEymuqgyfLswhXkL3cDlmm78I3ODNB4kUqYRaHw7bRJhq9tpsO1
 CYmE2XAUN420ftQhzQXii39B6eJ2PwYmCisjpwQz0t+s3dAiJa8uuneUwhMA3C/JOusq
 7kxvCICKmo/tORWbKvHJ1Qrpr0zS3GJ+xd5V9bHCKpYY4mRNiifjOs4mdmb9GmkuD7ty
 0MdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Kv5ETN2k4aLOdDzXAFROnYzWQx6jJxRs2gukBTr9IoI=;
 fh=h19i4MEHjZ0J++4StxZYxmIpBaCkUmhbpUec1J1bxWk=;
 b=GZK19rOJPEQ17qBYl7yKo4mOOOe1rzN8JI9FrU3+pk4eaw2ZCLJ8deozWgOFDaF+lk
 8NeLSLxon9HvD544Edqt4YrMKu9h3t9GP+QA6MORE+a3LfpyAzyHY3zDkOxaSookmblM
 3kUEy3N92SY1MS8+HB4jpbmGklKuAMaLKL6aONwt8CYZeZvdGZZcLOfFJUldYoFu4V1o
 GpKOxFXwhGpc1mJRjplpGoIoSbZFkkqSZnrlgiX0SENqns6NMNSO5qdOUyRNmgqjY/8p
 dFh5BII/jIXHWCgrdFzC6hkVlnAbmIiaqsXdh17XgmdNi+R/SymNFSWhJIN7mUAvbOmq
 SvPQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786216379; x=1786821179;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Kv5ETN2k4aLOdDzXAFROnYzWQx6jJxRs2gukBTr9IoI=;
 b=nn9yX1raP1x0UjUXrYu4pxqdGGt11uxDkkGPQ6c9O1GSy+rd+ko8fO0xo0j5jSTa3b
 mayLx6ElankJkPCO1gi24BpexyvX/JEE33Rq6k+555N6owRm3711SyJGh2TRIWmvKun5
 5Q+MB03Pw8D7B2czIY8LkAk2fmilwN/FEyn1q2klqSh8sf9jBZ2UgcY0ltcryboZ9raf
 O/JXYsdkUyoXPjdT1hN/Gbmw0zA7eqGlJXEku6Y/P9CaV4re4Sl0a1I5GE7RhVBEqaK3
 s3EAsPU8QgyjwxNFqfgi0Y0tMJeqtRqt4sCdt7CmT7FNQIzyLXNFjkTqs83ant4Mr2pX
 i4wg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrGVxtArIX0W4SsuPh9JNq7LrH7WCMceYfgCNmGX4m+nFCPjUKYD94HN6Xh9UVd/xwyB+d97w8=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YyzaJGn3NCtJKhMiM+pdbtxL6ewmGumUxad2DZv8Q+FEQS1Fh08
 O2PFE+lRn5Yho7L50Lam51efAAQJYvACO8ucO94Gc1SvV2NVIIGFlpF7TRKVmcBz9N6kH9W0R5i
 ABRktUAix3EDi8GkLaWLhXwvysQPpULNmS85UN1WjbA==
X-Gm-Gg: AR+sD11FawjXL++sIAZEH9B6OScZqJYJ6N6GlVoW11p8nZG46Myl30X0iXoLLCHSOEs
 eXulTETYRH/BH+kxgUQUk9YguedAX6xyN6NRyKNIwoI/2e39fHDc6+4wK7y2DY7mJmP9v9BBS1c
 Ad/9ZMsIedkDxwasVnNCrwlWAR0Jkvhf0CtpYD111ecRgPqlEOGNzdWGfSyKsOA5uTAAAjbQTz0
 RH/UV7Zk5IzJRluhAalY3w9qftpJJSNwWB5A9VAWJucaPOE+4LMoI4/Zr/COJivD7q/0agPe6RA
 ZcgHqnw8KLMR5n8SVZ8l9nYkJutEEd0P5v8TK/5YJNxwW0bfFX1DQPQkqM0l+99k/4ZLXDBvjCE
 =
X-Received: by 2002:a17:907:1609:b0:c19:611c:fa8f with SMTP id
 a640c23a62f3a-c2087505850mr424197466b.18.1786216379289; Sat, 08 Aug 2026
 12:12:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260805-pylibfdt-geo-growth-v1-1-dabe082367e5@flipper.net>
 <CAFLszTiJK9JFDe30ZfaXkZvmNUfWUVmC8ZVLU0b-7vfTsHaQ5w@mail.gmail.com>
 <CAKTNdwHyab4T-02-YjSHqmEVHYVXmZSZ9FqYWzpvUpt63UUHEg@mail.gmail.com>
 <20260808181058.GB394392@bill-the-cat>
In-Reply-To: <20260808181058.GB394392@bill-the-cat>
From: Alexey Charkov <alchark@flipper.net>
Date: Sat, 8 Aug 2026 23:12:47 +0400
X-Gm-Features: AUfX_mxYQiINhX7d6wQcteb2bJX2C_9RV5Uo9ni30ir3piI7pYVPB5Oc5f6HzRs
Message-ID: <CAKTNdwHED5XzQc4vQX7k_R-+O_0ae3q__w-tG5mfViPgBXW67g@mail.gmail.com>
Subject: Re: [PATCH] pylibfdt: Grow the FdtSw buffer geometrically
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1786216379; x=1786821179;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Kv5ETN2k4aLOdDzXAFROnYzWQx6jJxRs2gukBTr9IoI=;
 b=7QHEjlcw14B7yHBwYAQzAA9X1UUua58TFVuxgdpJeKcwNNtNBokQgSms5umXwLXG0t
 LszXDEK5WFVzThA35HlwIW1VOz7R+1VLlgp2OMqGj4Uki3Q/hMkuwgr75ctvPW2FiSyK
 VW8ZsYxxxonMM674IkCqxGpzbTnfJhy+RG18p0lsUNHgUYC4bL2dJp+GpWACe80aYEqz
 cNl9ly0iL7bFfivc76nIy23VrQXX9iKrdPKOXcjW4oTl99HJpmg4nJ+sBEHMRRJWs0c4
 +H55+Z3qyAdVl8uPqjP/Cpechc+iTzN4HAylX0/04fH20n6k2x2bJ1VxZVUMIibAXJRU
 h/nQ==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=7QHEjlcw
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

Hi Tom,

On Sat, Aug 8, 2026 at 10:11=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:
>
> On Sat, Aug 08, 2026 at 01:02:02PM +0400, Alexey Charkov wrote:
> > Hi Simon,
> >
> > On Wed, Aug 5, 2026 at 11:34=E2=80=AFPM Simon Glass <sjg@chromium.org> =
wrote:
> > >
> > > Hi Alexey,
> > >
> > > On 2026-08-05T14:47:38, Alexey Charkov <alchark@flipper.net> wrote:
> > > > pylibfdt: Grow the FdtSw buffer geometrically
> > > >
> > > > Every expansion copies the whole tree into a freshly allocated buff=
er, so
> > > > growing by a fixed amount makes building a tree cost time quadratic=
 in
> > > > its size. This is especially painful when assembling larger FIT ima=
ges with
> > > > binman, as it assembles the image with the data inline.
> > > >
> > > > Grow by at least as much as the tree already holds, which is what v=
ariable
> > > > sized arrays usually do specifically to avoid such excessive copyin=
g.
> > > >
> > > > With this change, building a Rockchip TF-A+Falcon image whose FIT c=
arries
> > > > a 31 MiB kernel takes 33.1 s rather than 44.4 s, with binman itself=
 down
> > > > from 25.3 s to 14.0 s, as 7139 reallocations become 187. The images
> > > > produced are byte-identical and the binman and dtoc test results ar=
e
> > > > unaffected.
> > > >
> > > > Signed-off-by: Alexey Charkov <alchark@flipper.net>
> > > >
> > > > scripts/dtc/pylibfdt/libfdt.i_shipped | 8 ++++++--
> > > >  1 file changed, 6 insertions(+), 2 deletions(-)
> > >
> > > This is a _shipped file from upstream dtc, so any change here will be
> > > reverted on the next resync. Please can you send this to the dtc
> > > project first (see https://github.com/dgibson/dtc) and reference the
> > > upstream commit / PR in the U-Boot commit message, similar to how
> > > a63456b9191 links to dgibson/dtc PR 154. Otherwise the improvement
> > > will be lost.
> > >
> > > > @@ -808,7 +812,7 @@ class FdtSw(FdtRo):
> > > >          if check_err(val, QUIET_NOSPACE) < 0:
> > > > -            self.resize(len(self._fdt) + self.INC_SIZE)
> > > > +            self.resize(len(self._fdt) + max(len(self._fdt), self.=
INC_SIZE))
> > >
> > > Logic looks correct - doubling gives amortised O(n) total copying, an=
d
> > > the INC_SIZE floor keeps small trees from taking many tiny growths.
> > > Nice measurement in the commit message too.
> >
> > Merged upstream: https://github.com/dgibson/dtc/pull/189
> >
> > Shall I spin a new version of this one to mention the upstream commit?
>
> Yes please, and are there other changes we need to merge in from
> upstream as well, in the pylibfdt portion?

I've also added public accessors for address-cells, size-cells along
with add/delete methods for memory reservations, which David merged
earlier today [1]. It would be great to pull those in, too, while we
are at it.

They are useful for the Falcon mode via TF-A series I'm working on [2]
but haven't yet posted the new version due to breakage in am335x_evm
which I am yet to fix. I could send them together with this change
here as a separate mini-series if that works (i.e. ahead of the Falcon
changes which rely on them).

[1] https://github.com/dgibson/dtc/pull/190
[2] https://git.u-boot-project.org/u-boot/contributors/alchark/u-boot/-/tre=
e/b4/atf-falcon?ref_type=3Dheads

Best regards,
Alexey
