Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0483606A332
	for <u-boot@archiver.kernel.org>; Wed, 25 Nov 2026 17:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=VhSveJtq;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cx2VsuKH
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9BD9F80DF9;
	Wed, 25 Nov 2026 17:54:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GdOMWqPckdYf; Wed, 25 Nov 2026 17:54:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C987680BD6
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795629255;
	b=YzrsOIRf/E5e+snRJb2/77kaw35Ev5e1qMEKTaipBRDNyJkBKh+/cZN/KjkiLf+W+QdQ
	 NRYeOEj2nesEljvFg0I9OfZ8CDu/SJUvIEe8Ic2B9hFQWeCuzaWL8cJsAYSTC88PftAok
	 Lj47kKUq3hnkMtpqxc4PWGNqEQxIQRBDg6X+uN/wXz9aoXxFLsQwSl+/KguZqQt9WkkX3
	 qXe15ptGf1F5ipSQnPn4CQCDcZI35V5XSwNwH0ybh8Zz3idVu8GXk4ytIikJFrxyA5Bpo
	 2HwQo0R6Ddg+//cMCqrvosQ8HBIMjQzozn8l2VwKdzhGWvFqM+GrlnGSXL9HERlE9xg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795629255;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=RGkG3dWLlm4fcpE/sJvHksdJNKhDjFwKtyvGuWcq6n0=;
	b=kYp/gFroYjpnBvPTKkogAUam/+6JDRn3r1f/QiFXRS0lGxp69YGdmT5D6Ymr0RT5f1Hh
	 EzftJXCARpm6+myznavkb8SVLY+W86RDUvOYtTbbR8qd1W6FDAaFN/pXnVgo02FFBpKCc
	 1JTEl3U4rxy/B/yvzHmLg25rDkaam8w2kI54nCqo98oHkY1GwtmGhmoMHVJJ4zFYA4uYM
	 LqMzvPw+DVtLVgGnYzLzUSlBxBeR+Y8yBlOQEWlXdJBOHQZMkiHBjUxQqEW24dENrRNVD
	 UrXhH+OJTdBsVvUz26+4adaJwahrxhLV1Fm5qaRvjnpudahogJaAZc19+4qhaCvFpLw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cx2VsuKH;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795629254;
	bh=RGkG3dWLlm4fcpE/sJvHksdJNKhDjFwKtyvGuWcq6n0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VhSveJtqV95/7te7aQjmstFDlfrRvnlvKCoxY0gzozr7ohL3AUsYCD/UMETjqF+zA
	 UZjiJpmt1gKBtsnvbRch4K/FQlr1m4qwjbWcFmcFRyJzr5l4YtMQZQfDGElRmAoyUu
	 0itvySFaznuWN8MixgNq7QL4RHCirdMZXQp0DKH5gjWTNWbxQcb904u2oYqZFW78/w
	 beb6zLa0P3VtoNGnVAvQmAxzT0Rs271wMOVWauiFcX90ucyViyAyBGX2Jja/lwJ0Il
	 ibEX8ZfJd7b1I1WmmzbvG6u87WVy5QMWzSrDsby+V2KLQ+4h9D/2ajX4IwS6+OdRbj
	 8Hf2b6jdWFHyg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C987680BD6;
	Wed, 25 Nov 2026 17:54:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 670501C9
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 17:54:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4C9CF80BD6
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 17:54:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id J_XD2bwQOkdK for <u-boot@lists.u-boot-project.org>;
 Wed, 25 Nov 2026 17:54:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5744C809C0
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::f2a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::f2a; helo=mail-qv1-xf2a.google.com;
 envelope-from=pbrobinson@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=cx2VsuKH
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5744C809C0
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 17:54:12 +0000 (UTC)
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-921367ef6b3so43067626d6.0
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 09:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795629251; x=1796234051;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=RGkG3dWLlm4fcpE/sJvHksdJNKhDjFwKtyvGuWcq6n0=;
 b=cx2VsuKHNaQKdc/dcgt1Gwah0qUqS8wph/ePJkRrf1uuje5piyadRnc6KutYT9l0X5
 smKIkF1V2beGRA95WrLCM9tGS+T8toYtuBPUPP+9QixGmscWAIfGd8LyAPYkHa/eRF/T
 N+Ohh8qy1ZS4jn9hLhagw6ys4yWOLuV6YjdOmXhXtetk5aK/f4Py0MxE9E392ZZ2/9qg
 +VIMaoJekwKhhoV4f1cGLVUldk8jPXvQjxfShiw7ZjbkDDbfZ+mv/TWUxy4+LtsamKRB
 0gu9AOubUmCtXCsaJDFkyVibeMyIpKHv1hwOts1b4trMI6lB3WXRtbGNkOMk0h7xAkDS
 uYeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795629251; x=1796234051;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=RGkG3dWLlm4fcpE/sJvHksdJNKhDjFwKtyvGuWcq6n0=;
 b=wonJ7qcgtR2AdFhfBqRCNXDpwaYvqRx5QNM2YMSbx5Wm20vYUDwtgihJwHZgkXgQAO
 9nuzTjT5rAeHYWlm9zH8LeZ3Ej80Jkk/ASqmhu9foBunjAKX1Tg3l3ZseYNBs4l12OB7
 p5Wp6rXv6DWdJu9eJXLdiLetFaQZxy8uTJ5BvyttT1CX1dIxc9+ICY1SIxNe2aoOFJb2
 CIIwLjeGuJeTwRg3SvnHh6ddzWnSIi82MXrr8ZdfVnmXrmbLv9OHWQHyOFSQpToLBqju
 Ve9nS/920BeYhd4EiM+6BFDx5Izy/4BIkpFpdFLmQ2yWfdcq1ruWA6JK1Jk/K1kbTzir
 gOoA==
X-Forwarded-Encrypted: i=1;
 AL+hErG86xwg4FKJV3aC/pDfH1HnqvOd65Jm+LiyCt71aUqFKKqW2OJL6wj9sC7oSz/Ay9Yt7P8PVfM=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/1vUH0bsK8YVC2R4SKZ4R+Wx9C8VlfuDWqbXvZYcfr5kZtkGSX
 OQgqLkfF2FlEhPBcODBz4Mwybzy/ucK2xOLYj2GFjLb/QBB3GK79fEP68UsbOVS0H23T/l+Dk9V
 iqGqmKyh4uy4xE5tMA0D9RWNfBz80dAk=
X-Gm-Gg: AZFdTZcEMF5hWTds5CGbtizGtgIHhiRePI4mpXIKd7R5mtUtSzk+r1q0Ety7W96JYMV
 48nuHYeRWkLuDoA3frbk83XHr7S3GWnVQGrrsVzpErQTSU/GaSLujK2TKo0NRK/XTNa8NnbYQ+x
 Ii32nxLdx5+AAVIgWmN8Ib0lfQpdl6z5jS5v6Izl8ns9YiOWku16JSFwMjF2MC4DTJUuMouuSPJ
 MhfxCzH2EPXNDCUmlrYkT8eI3U97/Xl+R4fjUgbEUHpb5uu676OE0ZZRvNfV2A0SFChdJ6WKwgk
 Hz26BKLf9TIcGd370RuWc2XcjPYGbx+p6u3g2JLsp8YLa0T+LLPIvHMSLbOcaIiAjqHrCACuXWX
 T4+GznXUlaUNjH88HYEcYsM8wTk8VBtdyRfQhPM9R7e9QU6Fgb0jTEVb+c21On4hS0JIHT4TZ3L
 HrQjOQf+EjLqSChZwBeOUeOBxKPElY75iqJhEMacvmqNdXwAX2oA8xt0+/3wvcY/r8ZnY/A1y3S
 1+gJBgE/CdV7mJxjhjgmv0vggliHjnK0VjAs4bcmhbHLybFCTwcYH+a
X-Received: by 2002:a05:6214:2b8a:b0:921:656a:9e29 with SMTP id
 6a1803df08f44-921656a9e5dmr135069256d6.54.1795629250825; Wed, 25 Nov 2026
 09:54:10 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261123-submit-lwip-wget-httpdstp-v1-v1-1-e1759174ab9a@gmail.com>
 <55dd0a77-5315-416f-bbe8-e952a03d874f@mailbox.org>
 <CADvTj4p9LJ+kwDSZ2fyw-P3fLEewbxN587dvF2OrpKQdY=k3Yg@mail.gmail.com>
In-Reply-To: <CADvTj4p9LJ+kwDSZ2fyw-P3fLEewbxN587dvF2OrpKQdY=k3Yg@mail.gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Wed, 25 Nov 2026 17:53:58 +0000
X-Gm-Features: Aa3M54pAu3Er_hNhSW8-3lHVzbBhVWQVLTuKixYAYnAcXYalZYHdKAcy9_nG5Ts
Message-ID: <CALeDE9M-r=p9TNEZEw4-4Ju-rKR3_wJx0ok_dgy4ykqGAADzyg@mail.gmail.com>
Subject: Re: [PATCH] cmd: wget: honor httpdstp for legacy arguments with lwIP
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Marek Vasut <marek.vasut@mailbox.org>, u-boot@lists.u-boot-project.org, 
 Jerome Forissier <jerome.forissier@arm.com>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Naveen Kumar Chaudhary <naveen.osdev@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Content-Type: multipart/alternative; boundary="000000000000a4d35206611d83e3"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--000000000000a4d35206611d83e3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 24 Nov 2026 at 10:00, James Hilliard <james.hilliard1@gmail.com>
wrote:

> On Mon, Nov 23, 2026 at 4:37=E2=80=AFPM Marek Vasut <marek.vasut@mailbox.=
org>
> wrote:
> >
> > On 11/23/26 11:13 PM, James Hilliard wrote:
> > > The ADI boot scripts set httpdstp to 8000 and use wget to fetch
> > > ${serverip}:/fitImage. With lwIP, wget still connects to port 80
> > > because it omits the configured port when building the URL.
> > >
> > > Use httpdstp as the default port for [host:]path. Preserve a port
> > > already present in the configured server address. Pass HTTP and HTTPS
> > > arguments unchanged to the URL parser so an unsupported spelling is n=
ot
> > > reinterpreted as an HTTP request to a different host.
> > >
> > > Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> > Do we actually want to keep perpetuating this legacy behavior or do we
> > want to leave this behind and not complicate new code ?
>
> Not sure, I figure maybe try and get feature parity first and then clean
> up unnecessary code afterwards to simplify migration to lwip.
>

Personally I find the cleanup rarely happens and in 10 years time it'll
still be there.

I think now is the right time to move, how long has the code actually been
there in the legacy case, we haven't supported HTTP for that long.

--000000000000a4d35206611d83e3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, 24 Nov =
2026 at 10:00, James Hilliard &lt;<a href=3D"mailto:james.hilliard1@gmail.c=
om">james.hilliard1@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex">On Mon, Nov 23, 2026 at 4:37=E2=80=AFPM Marek =
Vasut &lt;<a href=3D"mailto:marek.vasut@mailbox.org" target=3D"_blank">mare=
k.vasut@mailbox.org</a>&gt; wrote:<br>
&gt;<br>
&gt; On 11/23/26 11:13 PM, James Hilliard wrote:<br>
&gt; &gt; The ADI boot scripts set httpdstp to 8000 and use wget to fetch<b=
r>
&gt; &gt; ${serverip}:/fitImage. With lwIP, wget still connects to port 80<=
br>
&gt; &gt; because it omits the configured port when building the URL.<br>
&gt; &gt;<br>
&gt; &gt; Use httpdstp as the default port for [host:]path. Preserve a port=
<br>
&gt; &gt; already present in the configured server address. Pass HTTP and H=
TTPS<br>
&gt; &gt; arguments unchanged to the URL parser so an unsupported spelling =
is not<br>
&gt; &gt; reinterpreted as an HTTP request to a different host.<br>
&gt; &gt;<br>
&gt; &gt; Signed-off-by: James Hilliard &lt;<a href=3D"mailto:james.hilliar=
d1@gmail.com" target=3D"_blank">james.hilliard1@gmail.com</a>&gt;<br>
&gt; Do we actually want to keep perpetuating this legacy behavior or do we=
<br>
&gt; want to leave this behind and not complicate new code ?<br>
<br>
Not sure, I figure maybe try and get feature parity first and then clean<br=
>
up unnecessary code afterwards to simplify migration to lwip.<br></blockquo=
te><div><br></div><div>Personally I find the cleanup rarely happens and in =
10 years time it&#39;ll still be there.</div><div><br></div><div>I think no=
w is the right time to move, how long has the code actually been there in t=
he legacy case, we haven&#39;t supported HTTP for that long.=C2=A0</div></d=
iv></div>

--000000000000a4d35206611d83e3--
