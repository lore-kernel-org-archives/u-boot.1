Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04722C5AD4E
	for <u-boot@archiver.kernel.org>; Sat,  8 Aug 2026 19:14:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AF20080BEC;
	Sat,  8 Aug 2026 19:14:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id y1ToUF4DQyAV; Sat,  8 Aug 2026 19:14:33 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C4F1080BC4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786216473;
	bh=JGyBGi2yIVXMtjm3WqkE1YhtbqOeaqJEU3zLIH15WWI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ovYcFteX234UziHujYNf0BcYoxaHqxjjl0W4Daeue5CjarF7O5o6vh4yEdJ8wbwo1
	 v5q9G5PRUWO2sIRbDrNTMTjTFMRczfnOjQDFAo7g0o6D2N13ky8UmX8UKgZbKvFrDY
	 fcgt5F8lteNqmHd++mx9ZAdMg0urFcCVYRYx8y9S1cSjmdnhuxnEUbZ7V4+TbFChEX
	 Zpcxn9UxO3tEDL2TwSrDi4kBDFGoitlKwKOz9MErQ/eDhxS9xZFQ4FlXEiJi+c9Cdi
	 gPMqUEMipOOYQ3EHWwx0z052fEiSex04fWbHZXZMkZTEfayisb4okqeQ7dmpXyUjgM
	 sclh2hvZdBMgA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C4F1080BC4;
	Sat,  8 Aug 2026 19:14:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 37B45218
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 19:14:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 296F980BCA
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 19:14:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qE1siepLMhK8 for <u-boot@lists.u-boot-project.org>;
 Sat,  8 Aug 2026 19:14:31 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::530; helo=mail-ed1-x530.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org EB51380BC4
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EB51380BC4
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EB51380BC4
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 19:14:30 +0000 (UTC)
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-6a17211b9ecso750730a12.2
 for <u-boot@lists.u-boot-project.org>; Sat, 08 Aug 2026 12:14:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786216469; cv=none;
 d=google.com; s=arc-20260327;
 b=gAj5RG3kh3q5M0BZfwv02MuiXck8oNRISqu+GPo0lw4I3aKwYjtF3EJ8/GxIM0nIRq
 gHW6Td3H6VW1etavZNNQCPwRcer6aeMCW4lUOVWBpswmJKGaZf3vKRgsUautUG1GGnzj
 DjzuASL6Yw4fV6hHgTByzYTD4xljKwGYU1SM0TDmRBHgosus3/1RssbNgbmF5dbKF28Y
 Tr2KD5V9xHkayx1rXdla13FlWAK/5ZoQUiwEY1SsNSpDZb+wK2hf+Kxdc1CHBy6Diui4
 F9s23jkAizifpcJNSHcmHiGxxj25JWdJn2m/nxdTNNHZbKJHQDkfLs1bj9nxjE5vX9XV
 ZWBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=JGyBGi2yIVXMtjm3WqkE1YhtbqOeaqJEU3zLIH15WWI=;
 fh=q4oTVouPigt8JvBPAjPE1kzymVX6rifNlXhZh/LPiu8=;
 b=FWg3WJatHAnTadm+zvCW9NWI+cV25tXhdhJmleajsBfD6/z0QWCqK+ljfyteVfyzAG
 Va2CBvgrWKydwKdZEbTDx16+a+Dn+2Vsa3rt510snnY6J1/S7yOw0ueFyfqM1GAywRS0
 MJsK93xhqV6niKi5KTu+LktC/8MzJ6Luokq2lKFCJJo1a6a3qHVUg2yKfpupozUIjoJ7
 aQLeV+iYVohwCJQjhidIFj/qvnI45Xsys4XoOigmWAiZncpbyt/0xjBGpsWBUI8dmsR+
 ljfTxrguSFRJCYxhsKPJJ3EXwVXzjlvm86mWWosRyCAmUY7NlW8m1DaArpWV6l24NKhS
 W1qw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786216469; x=1786821269;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JGyBGi2yIVXMtjm3WqkE1YhtbqOeaqJEU3zLIH15WWI=;
 b=pLshRv0nRXJD3KLHNILFtda+33u8go9MsH09kXEAxfMvQrJ0hvudbpSVf6TenuEo3D
 ktyOh6qQykXSS+jUZBziZMKaLCOLTPELkhA411uZnjjdr8Pae/zmFSoygmAAoCqTkQ4A
 Rn7zz85jAKCiVrDDYLv6YSu7g3QEX+7J7l+uFuPR/HBIvabngDAHbKqA6ToU/lwc3r+6
 HLrM2zftEvQ6bemtRDpJ7DTb+EQiDObn16zfvfwsgXKNw3va849Ztzqu2aoAEFH5hLd0
 nQfezpirs8q9kogmClyOGejDQQRoIgCvc+4fm3vyuuljzj5wHejOE43ZBs5/BMh/9jb8
 bgkA==
X-Gm-Message-State: AOJu0YyFvooR8r/dsZdd5GNtKXhX/W9qKCtnzSqPgdzTW7IzgQWiHYGP
 EwAIKSL/1QXh+OynRB2qtVPFIgef+9tB0SECaVg1VjOyMLtwCp32KSriFPNUxwPjiSNABglhGym
 A9yUgeqZtXgu7jg+2DijKY7cEjshvHDLr2MHAZ3QEutGD0Iym5/4=
X-Gm-Gg: AR+sD1231GivjpEDdgeWHWPcQviE4j1R8FHq4EPN7tg4uxUJEdxeUx6DFkLmVoY4X74
 yGb+cdo/VHP0hTljSMLNgiCMVyKrcKmUjp1NpfB8yn50xiZ/Vu83TOWprkxVEcWTCOz+eCsuE8a
 odudICVHIJYxo9sfUeyuUVMXK2Z1fFr/Hv93tNnzcL+/gv2Rc3pNK5ftXDG5Ddfp0s/OuM8V7u0
 ERf1pYDFq93bhWVeVRA5no+mX6s5ofBbYTLg0Z4HErHpIW8ufiJoQ4IT6AfgmmArzeiGpPWSyd0
 685bMiuFYgDrmgL+sm65sW5cs/nv1QSf20GGC5pKofs=
X-Received: by 2002:a05:6402:a503:10b0:6a1:9b21:457 with SMTP id
 4fb4d7f45d1cf-6a19b210969mr7849341a12.21.1786216468803; Sat, 08 Aug 2026
 12:14:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260805-pylibfdt-geo-growth-v1-1-dabe082367e5@flipper.net>
 <CAFLszTiJK9JFDe30ZfaXkZvmNUfWUVmC8ZVLU0b-7vfTsHaQ5w@mail.gmail.com>
 <CAKTNdwHyab4T-02-YjSHqmEVHYVXmZSZ9FqYWzpvUpt63UUHEg@mail.gmail.com>
In-Reply-To: <CAKTNdwHyab4T-02-YjSHqmEVHYVXmZSZ9FqYWzpvUpt63UUHEg@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 8 Aug 2026 13:14:12 -0600
X-Gm-Features: AUfX_mxegqJfgNegDUsXZEEu5ArY9LKhcXOIc1MytISVL1mjzOoN_SjIycn-xEQ
Message-ID: <CAFLszTjPmx=TqeeG6JfkdGsXOQ9uHYQAH_txWM0koGiqpKnL6g@mail.gmail.com>
Subject: Re: [PATCH] pylibfdt: Grow the FdtSw buffer geometrically
To: Alexey Charkov <alchark@flipper.net>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1786216469; x=1786821269;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=JGyBGi2yIVXMtjm3WqkE1YhtbqOeaqJEU3zLIH15WWI=;
 b=drsm6Nrjkbt73mL4MSf3RnjKvU4R7w5z9WICM4Q/2BDeIcNLWwHYxxlQDJzZqBh3bS
 vtdOPsEEobuwIvHCblzTE/qpIyzqNCs9qES2/m5bVF1DdMTH2D4kiMN1K0PkZhjFsEhI
 49OnW6Wrgfy4fgXFc7R8MgDSSG4ZXGsqfn2rM=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=drsm6Nrj
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

On Sat, 8 Aug 2026 at 03:09, Alexey Charkov <alchark@flipper.net> wrote:
>
> Hi Simon,
>
> On Wed, Aug 5, 2026 at 11:34=E2=80=AFPM Simon Glass <sjg@chromium.org> wr=
ote:
> >
> > Hi Alexey,
> >
> > On 2026-08-05T14:47:38, Alexey Charkov <alchark@flipper.net> wrote:
> > > pylibfdt: Grow the FdtSw buffer geometrically
> > >
> > > Every expansion copies the whole tree into a freshly allocated buffer=
, so
> > > growing by a fixed amount makes building a tree cost time quadratic i=
n
> > > its size. This is especially painful when assembling larger FIT image=
s with
> > > binman, as it assembles the image with the data inline.
> > >
> > > Grow by at least as much as the tree already holds, which is what var=
iable
> > > sized arrays usually do specifically to avoid such excessive copying.
> > >
> > > With this change, building a Rockchip TF-A+Falcon image whose FIT car=
ries
> > > a 31 MiB kernel takes 33.1 s rather than 44.4 s, with binman itself d=
own
> > > from 25.3 s to 14.0 s, as 7139 reallocations become 187. The images
> > > produced are byte-identical and the binman and dtoc test results are
> > > unaffected.
> > >
> > > Signed-off-by: Alexey Charkov <alchark@flipper.net>
> > >
> > > scripts/dtc/pylibfdt/libfdt.i_shipped | 8 ++++++--
> > >  1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > This is a _shipped file from upstream dtc, so any change here will be
> > reverted on the next resync. Please can you send this to the dtc
> > project first (see https://github.com/dgibson/dtc) and reference the
> > upstream commit / PR in the U-Boot commit message, similar to how
> > a63456b9191 links to dgibson/dtc PR 154. Otherwise the improvement
> > will be lost.
> >
> > > @@ -808,7 +812,7 @@ class FdtSw(FdtRo):
> > >          if check_err(val, QUIET_NOSPACE) < 0:
> > > -            self.resize(len(self._fdt) + self.INC_SIZE)
> > > +            self.resize(len(self._fdt) + max(len(self._fdt), self.IN=
C_SIZE))
> >
> > Logic looks correct - doubling gives amortised O(n) total copying, and
> > the INC_SIZE floor keeps small trees from taking many tiny growths.
> > Nice measurement in the commit message too.
>
> Merged upstream: https://github.com/dgibson/dtc/pull/189

Nice, that was quick!

>
> Shall I spin a new version of this one to mention the upstream commit?

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
SImon
