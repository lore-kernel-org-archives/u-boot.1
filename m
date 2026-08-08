Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E97D2C5AD44
	for <u-boot@archiver.kernel.org>; Sat,  8 Aug 2026 19:33:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 980A380BDD;
	Sat,  8 Aug 2026 19:33:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id P4wFP7yU704f; Sat,  8 Aug 2026 19:33:56 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A02F580BF3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786217636;
	bh=FkPyJ9vTGWJtev0rtcn0v4VXwnITb9NxT09sy2x550s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OOfVn754X3Goqw2lbzom2kbqJ0PWTzTQFJuVgpbLdZJZTfbESvTKVXkWqlI7G+Q0s
	 Wt04KaxQf6zu9bK7mRwUGns3OIP6ZlxQU7wA042Aet9uyGbLLPcp+Tuc3bjMIvekm+
	 LF1IvgNQq+boG9ojRVasH5fLAckKS572YNgjj4oEmmfecmr3qxT6TxnjFI9BnrKO0V
	 K9gUyWdDLXGxboc/9QU0WF75Lm1wNxzf7vMYbVkXepgdOvjx4/jxuNL+wbQeBc1VHj
	 3JxdrGvuHsBKnQA8oRKkcJQ3Y5AsFcdXe5SUYruUbt+wPe6tvZpnufS3TZTc4s/Nt+
	 dO8+2g3r3fn+Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A02F580BF3;
	Sat,  8 Aug 2026 19:33:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 5F9DF10E
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 19:33:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 51C6740061
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 19:33:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TFLzLOgzzO3q for <u-boot@lists.u-boot-project.org>;
 Sat,  8 Aug 2026 19:33:54 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::331; helo=mail-ot1-x331.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 5EB784006B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5EB784006B
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5EB784006B
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 19:33:54 +0000 (UTC)
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7ee37dc91f5so374729a34.3
 for <u-boot@lists.u-boot-project.org>; Sat, 08 Aug 2026 12:33:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786217633; x=1786822433;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FkPyJ9vTGWJtev0rtcn0v4VXwnITb9NxT09sy2x550s=;
 b=c6/QkARCfGCHJ27dnhyMVCD4INBHibWX/P/HklYpbc5MPs8Bf4Qe/aneptpvZkGwqf
 PROp+DYYEaZJFKrfzXcWaFJ/hKsQb3PKN1R47SBrco8BwR6nSnKpIkOLzeqHxxcgcOZ2
 GkIv0X/vDVcj96ErolkGvQTHNc3GDIWnahc7oWU1W+euWwxGvxGVv71IApSlXmJrdMKV
 IS/EndPI0y9+WaXr9v8oK3x4CDnqnfHNtq3H3e2x6vFJoRsDgEmkKWjKwcSpF4njb9tA
 NQqPX0F/+iYXiTmSSjQPcgggIMHa6fvc9eP3MR7jwk3Zn7oQWGzv07X3hRrY8q/1dP+A
 EuAw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpjiPjlhEFkP+inNL4ehFgJ6geLEHsrkCb++GFqgBSNQZSCyl6ZT8eN9bxzRph8Lo2tbhpzaKQ=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YwuWYyTK8akVxVJnJBwhVKIlAK0XWBuren/eqomIWFNyxujdgW+
 w9w6ZlwAd5AOvAoCM0zzydPBTx5dn0VK8B4A9LheeYxwiXyOHnSB6H8awUdyhzsCAq54rLCB6T6
 q7FXrq0w=
X-Gm-Gg: AR+sD10dgFhAzJGgLa8cYGli8W2uY8p+bfskJAXfQ3bODKoBpGeGlskUUlrldgRZ7J3
 +kPzVmyr+ukjXtGM1h7YH4M4Ov2JZx1ZcTJtBvsFiiMX/RLbjMkvqLjgNnhjChPoAhrWmeMQkNq
 Fc/lCfVj46Hv8qmuZw9PJw55xOhnsZd/EFhBYTK5wh9mc2avEcQyzw+nRWuuAKTl9eo8o7mQejS
 xqTUqibA2O3wU6ewGxwGAgIzX62tosnosK5QSxRrtgyE4gbvceUdwIypPrXVS0jxz9Po/eCuOZ1
 KhLXLz+ncQ8RAKlffOhUHHuH96kqoWVJBCs2gx7KOGjOVzgRlCtlz3QyP3stlP7PkNIIXfx08EY
 xdgR3JKqyky+lIgor996wj/Kinoj7yWIPMWqpBkTtlda3DkYs5rvE8mUfP5hrf6u4PyIVYtLAiY
 xoaqVsaN+Ug7IKVTSn88AsOxLvJaJ5x/6XhnZBNKRO6B3hBA8//2Y9Kv3m0VsExHENOty6w1az6
 mjYphE90V2lmNh3373YHQC9N+0GrmIZ8AcCjHylTOSDE4alrUW93o6/8tvfEqq6rSv2hBLFKqv5
 IzzD1UtFew==
X-Received: by 2002:a05:6830:82eb:b0:7e9:e0be:583b with SMTP id
 46e09a7af769-7f1e5e321femr18891763a34.9.1786217633305; 
 Sat, 08 Aug 2026 12:33:53 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f35b76fe2fsm3801946a34.16.2026.08.08.12.33.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Aug 2026 12:33:52 -0700 (PDT)
Date: Sat, 8 Aug 2026 13:33:50 -0600
From: Tom Rini <trini@konsulko.com>
To: Alexey Charkov <alchark@flipper.net>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH] pylibfdt: Grow the FdtSw buffer geometrically
Message-ID: <20260808193350.GD394392@bill-the-cat>
References: <20260805-pylibfdt-geo-growth-v1-1-dabe082367e5@flipper.net>
 <CAFLszTiJK9JFDe30ZfaXkZvmNUfWUVmC8ZVLU0b-7vfTsHaQ5w@mail.gmail.com>
 <CAKTNdwHyab4T-02-YjSHqmEVHYVXmZSZ9FqYWzpvUpt63UUHEg@mail.gmail.com>
 <20260808181058.GB394392@bill-the-cat>
 <CAKTNdwHED5XzQc4vQX7k_R-+O_0ae3q__w-tG5mfViPgBXW67g@mail.gmail.com>
 <20260808191935.GC394392@bill-the-cat>
 <CAKTNdwFBCbW5+-aX7Y5gt3gNx8rBAHsc0AuVMSJMm8ztNN5pXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="zUuG+3yYEfy3KsKA"
Content-Disposition: inline
In-Reply-To: <CAKTNdwFBCbW5+-aX7Y5gt3gNx8rBAHsc0AuVMSJMm8ztNN5pXg@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1786217633; x=1786822433;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FkPyJ9vTGWJtev0rtcn0v4VXwnITb9NxT09sy2x550s=;
 b=qSughgyitYoz+SVv1iRu28+w0HZBC4My5YBxPIP5EG1/hMWROC89KCXurNyU08a+ry
 gIdngzBKMmi8vUtOdM+PnqK81MrkR9OCHBznVJjmjJTjI0LKLy1p40IDhRwfM5JqDzC+
 kFwAjuV2oFGcwE0SlnDw1MeU6zCP+3lFxkPiE=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=qSughgyi
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


--zUuG+3yYEfy3KsKA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 08, 2026 at 11:26:44PM +0400, Alexey Charkov wrote:
> On Sat, Aug 8, 2026 at 11:19=E2=80=AFPM Tom Rini <trini@konsulko.com> wro=
te:
> >
> > On Sat, Aug 08, 2026 at 11:12:47PM +0400, Alexey Charkov wrote:
> > > Hi Tom,
> > >
> > > On Sat, Aug 8, 2026 at 10:11=E2=80=AFPM Tom Rini <trini@konsulko.com>=
 wrote:
> > > >
> > > > On Sat, Aug 08, 2026 at 01:02:02PM +0400, Alexey Charkov wrote:
> > > > > Hi Simon,
> > > > >
> > > > > On Wed, Aug 5, 2026 at 11:34=E2=80=AFPM Simon Glass <sjg@chromium=
=2Eorg> wrote:
> > > > > >
> > > > > > Hi Alexey,
> > > > > >
> > > > > > On 2026-08-05T14:47:38, Alexey Charkov <alchark@flipper.net> wr=
ote:
> > > > > > > pylibfdt: Grow the FdtSw buffer geometrically
> > > > > > >
> > > > > > > Every expansion copies the whole tree into a freshly allocate=
d buffer, so
> > > > > > > growing by a fixed amount makes building a tree cost time qua=
dratic in
> > > > > > > its size. This is especially painful when assembling larger F=
IT images with
> > > > > > > binman, as it assembles the image with the data inline.
> > > > > > >
> > > > > > > Grow by at least as much as the tree already holds, which is =
what variable
> > > > > > > sized arrays usually do specifically to avoid such excessive =
copying.
> > > > > > >
> > > > > > > With this change, building a Rockchip TF-A+Falcon image whose=
 FIT carries
> > > > > > > a 31 MiB kernel takes 33.1 s rather than 44.4 s, with binman =
itself down
> > > > > > > from 25.3 s to 14.0 s, as 7139 reallocations become 187. The =
images
> > > > > > > produced are byte-identical and the binman and dtoc test resu=
lts are
> > > > > > > unaffected.
> > > > > > >
> > > > > > > Signed-off-by: Alexey Charkov <alchark@flipper.net>
> > > > > > >
> > > > > > > scripts/dtc/pylibfdt/libfdt.i_shipped | 8 ++++++--
> > > > > > >  1 file changed, 6 insertions(+), 2 deletions(-)
> > > > > >
> > > > > > This is a _shipped file from upstream dtc, so any change here w=
ill be
> > > > > > reverted on the next resync. Please can you send this to the dtc
> > > > > > project first (see https://github.com/dgibson/dtc) and referenc=
e the
> > > > > > upstream commit / PR in the U-Boot commit message, similar to h=
ow
> > > > > > a63456b9191 links to dgibson/dtc PR 154. Otherwise the improvem=
ent
> > > > > > will be lost.
> > > > > >
> > > > > > > @@ -808,7 +812,7 @@ class FdtSw(FdtRo):
> > > > > > >          if check_err(val, QUIET_NOSPACE) < 0:
> > > > > > > -            self.resize(len(self._fdt) + self.INC_SIZE)
> > > > > > > +            self.resize(len(self._fdt) + max(len(self._fdt),=
 self.INC_SIZE))
> > > > > >
> > > > > > Logic looks correct - doubling gives amortised O(n) total copyi=
ng, and
> > > > > > the INC_SIZE floor keeps small trees from taking many tiny grow=
ths.
> > > > > > Nice measurement in the commit message too.
> > > > >
> > > > > Merged upstream: https://github.com/dgibson/dtc/pull/189
> > > > >
> > > > > Shall I spin a new version of this one to mention the upstream co=
mmit?
> > > >
> > > > Yes please, and are there other changes we need to merge in from
> > > > upstream as well, in the pylibfdt portion?
> > >
> > > I've also added public accessors for address-cells, size-cells along
> > > with add/delete methods for memory reservations, which David merged
> > > earlier today [1]. It would be great to pull those in, too, while we
> > > are at it.
> > >
> > > They are useful for the Falcon mode via TF-A series I'm working on [2]
> > > but haven't yet posted the new version due to breakage in am335x_evm
> > > which I am yet to fix. I could send them together with this change
> > > here as a separate mini-series if that works (i.e. ahead of the Falcon
> > > changes which rely on them).
> >
> > That's good to know, and yes we want them. But I'm asking if there's
> > other outstanding upstream changes to bring it?
>=20
> Not for the parts I touched (they are self-contained), but I could go
> through the whole diff to see if there is meaningful divergence vs.
> the U-Boot shipped version and report back (hopefully with patches if
> applicable).

Yes please, we don't intentionally lag behind upstream on that part of
the code.

--=20
Tom

--zUuG+3yYEfy3KsKA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaneEngAKCRAr4qD1Cr/k
CuYhAQDRt3CkBEK7rDGmuREbUeJCODQEpQ7VdH3Jzu9RQWsEawD/SLmJuddMsJn2
gAlG4tocpUbEonAxkQy+pD7jXC5hmwA=
=BMw3
-----END PGP SIGNATURE-----

--zUuG+3yYEfy3KsKA--
