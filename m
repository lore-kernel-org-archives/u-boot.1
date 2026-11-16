Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FD6606A888
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 04:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=jqjnb0hz;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dR/40db7
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 94B3D403FF;
	Tue, 17 Nov 2026 04:34:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lbAK6SQIsGEg; Tue, 17 Nov 2026 04:34:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B40554043B
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794890093;
	b=j7cFaZ1IsdEu6ZYYgX6ssXwdq4CchPYrLbaXAKoQ0clPzj6ScQ+wbnzLAuSNdpW4kuMi
	 CJhpL1zexnjLBUtU/fSEYlcJWB2AsRM8AchCnGS/oGLYFhB6+CvpLfzwQC3fdu0qfgQSV
	 ZOpc+rfFWXWV/Cbt7idiFG6gpZasMvh1PfJ/HZVixMmcATULNsxausLYxQokR6D3lXlPq
	 3qdqOgSi9gkNqS7wXvq+j3Icu+vvzgCnlCfXQZVdc1JsspxU7lbwwwASPY8MtNOnxDX65
	 U28abo1bpTyYIw7NpXze5yqPTGma1p0GADTNzXyha7x1LDlVm6trHHhb+XepiRrFhcg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794890093;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=T49UyMlm+WGeqe5N5Z0iRWrjDbUHrmqGBk5TyVHOAoo=;
	b=l7hTzhWqav121CwJ0B6IqLDjGZoPxi6DfvzeydLndPhdOvwPiW1KC88JEZNkPDY2DjPV
	 NPd90UjFDk/5t9wL1wScUBewQ5LO3Zw8so0UULKOQ0q/dIUm6nuPcq9VrsKSbHaKnveQx
	 vCgLHrZv0K/PjNIfkRNp69GuF8FIxnl5JmCSsISiE5s/fvxsWRqb9DvStPBSumrTYVTLB
	 fQ6Rkz2ewxuochL2EIEjyy1DK6iPc6rESYJ/YbfZDjw/sZ8dpA9bcDBbMF8zuXbDT7rXe
	 nISlN29Hq1QvuQEKPdPzy64+0FrElCo1t5HGTUI14l+z3uQlCW5sPrfdU3v++r15EDQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794890093;
	bh=T49UyMlm+WGeqe5N5Z0iRWrjDbUHrmqGBk5TyVHOAoo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jqjnb0hzP4GZa06DuDbC8/yqqG1/7uKlJRx+oaX10hXphQeIgMOM0bPzZCbsCubU5
	 Mpl8R1PYRhIB0rIL7xAko/aFJSwiHf/V457NSBrySy7OZ+mkzIeyTqjOfDqzNNBXCs
	 CjAYarFITNoIKSYKKuhXNmkuk1e3IPKOEppp2rcxkgzd/9Bk+DLQKiEgm9iaW7E7Sh
	 KZUYwR53tWc3yaKtC2ATdr+L3I1eoQDwQpz/iPxPol/PjoeTgtJrX7RTb5/iuNW9my
	 h3iEgKGrsGB8WhlKCcwiq40FzgpDjmd9Im7oiqQnzZLIqx+rnYAzzJ/tOcpDbNzrNP
	 VO77nVDwvIprA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B40554043B;
	Tue, 17 Nov 2026 04:34:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id D408970B
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 21:26:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D071660811
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 21:26:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id g_eUIaQ-juxK for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 21:26:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 82269606A2
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::635"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::635; helo=mail-ej1-x635.google.com;
 envelope-from=dilipchowdary21@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=dR/40db7
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 82269606A2
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 21:26:15 +0000 (UTC)
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-c4203bbb1e9so672535266b.3
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 13:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794864373; x=1795469173;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=T49UyMlm+WGeqe5N5Z0iRWrjDbUHrmqGBk5TyVHOAoo=;
 b=dR/40db7wZvUbUDa8+o3F9vfOi2ONrXeOtf4ftGOkxvuTxbTdkvKfM1pdj+cnOJN10
 wUbFMPgoc9Vzzeoz7mGWY0qrPOCP/aHSAtpM6O8iunEncLSax9nPLT0AXEU+gjLjoDKD
 hNxAM8uANKLxwBziNI7hS8s9XBSNKm/n86AlZlsfaj7NjJiPWqpP8OYZW2ZC3XY3gZjI
 qlolGxfkpQ4+NgKhreoY2GVAkI24SHdumPtH2UmQyZnXh72kk3Cuo3byU69GZgX+v32e
 12HSF4VNoTfzVDrtClUsIRpVd7GUYAYPUqlo/TYePiogQsiTPgEGr38qLKKg4+MG+kFz
 VsPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794864373; x=1795469173;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=T49UyMlm+WGeqe5N5Z0iRWrjDbUHrmqGBk5TyVHOAoo=;
 b=y0DuqxftwAoceEBlJIC+hMnRLEykv3gKBjUOfKJKQAMbto74G+cXrBGZyYT/WjGKsC
 YOGDu8j/xsw8AV7j7T9q/QF2LKeTgMFpv38QwiqxKr+Ra+c+tO4j1Jr1FJjpTzvNwf+z
 V8JhqGhm3a0QL174cmiWuXrArDH9ursuBtesimzF8vCAXrlX+QL1TSgUeHe3+JgZ6ZBE
 5umMccAnKHphP9TdH6Ayvrqcvo1BWcZ/4ur+3tjgqrP+Yz4Bkw5YlIl2HX87n8vl37wV
 QW24gQB5uAcS0aV4w7P00SIPAvlxXN3RBvQIABaTDvN1zZsI8SrECpbUHehjJgLLVHkT
 cSyg==
X-Forwarded-Encrypted: i=1;
 AL+hErEURMtjCocUcvHZW5WendglzM6FLHlizibtEK+82ha4TGDpyxPEIJCLC6hW1hVWk8usdyuC/OQ=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9QMkjgglGeAiuQos/vv+dvGZxGmv406TBqc2uRsCwLGKOelsO/
 U7HLqwEVcLf3Y5MpQjoZX8YLYqN2W096l2SbVOD8uIz5l7qMFnmOxDv/KrmKzSNTW56qkAPbuxG
 yPL4bn/nFkKogt7IHkAe/lbSYYbiZWT0=
X-Gm-Gg: AYBFou1Jni5MoNDtCDY5kOyVkfvWP/ZeT8T2gsS1mGVNpfIpar9RF4Ngg+ztPQ9Uuco
 h3DSbfNkkd1iHHNnQrAOBFrLpHhBkk3MTPl7YnxgOTJyFVylOrHm6t83alcsF4vFal9XqGhxU6K
 ku9tTDPw0l26IM07UPQV6vlGxM4ZDESwS7w9lQiRq1mpFuSdqvfyXmvMpSDZkD7CcoHNyDIL0ox
 6k1tbuWfX3a+80Zwn9CNW/RYgszYCniq4mAdJKkxnzyZlH97Fnl+/f+xJc43Qg6b8WunB9mh6zh
 IEF+FklHcayp/dbduz6bkd/udSLUfDG6NTiNHXvi9zH2VD1Koy/kSPlUYkQZ8428hlwJzjZN0r8
 yv7PnHz4dUl1mKypLCHU/9HtvbzKKmIygOR9sa7XEkjMUmftyyefMdVmioTx+BAUaVNjg7jQ/Fr
 1hrouoNnNmk7P7TTJN2uCKSm/0kUBacRYXm5JnSCkrlUz0
X-Received: by 2002:a17:907:6094:b0:c2e:4292:d268 with SMTP id
 a640c23a62f3a-c50963067a2mr1109420366b.16.1794864373265; Mon, 16 Nov 2026
 13:26:13 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261116205502.14884-1-dilipchowdary21@gmail.com>
 <767dd299-5aa0-4e4f-a84f-a55395214a30@suse.com>
 <20261116211731.GL554944@bill-the-cat>
In-Reply-To: <20261116211731.GL554944@bill-the-cat>
From: Dilip <dilipchowdary21@gmail.com>
Date: Mon, 16 Nov 2026 15:26:01 -0600
X-Gm-Features: AclHuK9Dk4oh3rWTv8SmXVCbX_0phuhQIqRPhnoTIifSbyqZ0REyyETH765SEC8
Message-ID: <CAPmzV5nK54_k3imwV3UGV9dQjGpa-FjFK-5PEsFz1yrDrOcWKg@mail.gmail.com>
Subject: Re: [PATCH] fs/btrfs: fix path buffer overflow in subvolume listing
To: Tom Rini <trini@konsulko.com>
Cc: Qu Wenruo <wqu@suse.com>, =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, 
 u-boot@lists.u-boot-project.org
Content-Type: multipart/alternative; boundary="0000000000006377c106606b6dd5"
X-Mailman-Approved-At: Tue, 17 Nov 2026 04:34:42 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--0000000000006377c106606b6dd5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Qu, I'll drop the comment in v2.

Tom, noted on the AI policy. To be upfront: I did use an LLM to help with
the analysis and drafting here. The bugs and the fixes I've gone through
and verified myself, but I should have said so when Quentin asked, and I'll
keep future submissions in my own words. Happy to continue only as far as
is useful to you, the findings stand on their own either way.

 Dilip

On Mon, Nov 16, 2026 at 3:17=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:

> On Tue, Nov 17, 2026 at 07:43:31AM +1030, Qu Wenruo wrote:
> >
> >
> > =E5=9C=A8 2026/11/17 07:25, Dilip Mallavarapu =E5=86=99=E9=81=93:
> > > get_path_in_subvol() and list_one_subvol() accumulate a path across t=
he
> > > on-disk inode-ref / root-ref chain with strncat(path_ret, tmp,
> PATH_MAX).
> > > strncat()'s bound limits the source copy, not the destination total,
> and
> > > there is no depth/cycle limit, so a deep or cyclic ref chain overflow=
s
> > > the PATH_MAX path_ret buffer (CWE-787/120).
> > >
> > > Use strlcat()/strlcpy(), which bound the total length, and reject the
> > > path if it would be truncated (which also terminates a cyclic chain).
> > >
> > > Reachable via the btrsubvol command on a crafted btrfs image.
> > >
> > > Signed-off-by: Dilip Mallavarapu <dilipchowdary21@gmail.com>
> >
> > Reviewed-by: Qu Wenruo <wqu@suse.com>
> >
> > Just a nitpick on the comment.
> >
> > > ---
> > >   fs/btrfs/subvolume.c | 25 ++++++++++++++++++++-----
> > >   1 file changed, 20 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/fs/btrfs/subvolume.c b/fs/btrfs/subvolume.c
> > > index 68ca7e48e48..bac9c1d1722 100644
> > > --- a/fs/btrfs/subvolume.c
> > > +++ b/fs/btrfs/subvolume.c
> > > @@ -64,7 +64,16 @@ static int get_path_in_subvol(struct btrfs_root
> *root, u64 ino, char *path_ret)
> > >                                (unsigned long)(iref + 1), name_len);
> > >             path_ret[name_len] =3D '/';
> > >             path_ret[name_len + 1] =3D '\0';
> > > -           strncat(path_ret, tmp, PATH_MAX);
> > > +           /*
> > > +            * strncat()'s bound limits the source copy, not the
> > > +            * destination, so a deep/cyclic ref chain would overflow
> > > +            * path_ret (PATH_MAX). strlcat() bounds the total; rejec=
t
> > > +            * the path if it would be truncated.
> > > +            */
> >
> > This comment seems overkilled, and it only covers one call site.
> >
> > To be honest, I don't think there is any comment needed for usage of
> > strlcat()/strlcpy().
>
> Yes, and it's the kind of thing which AI tends to do, and then expects
> human reviewers to remark on. Please note that the AI policy for U-Boot
> is "please don't".
>
> --
> Tom
>

--0000000000006377c106606b6dd5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thanks Qu, I&#39;ll drop the comment in v2.<br><br>Tom, no=
ted on the AI policy. To be upfront: I did use an LLM to help with the anal=
ysis and drafting here. The bugs and the fixes I&#39;ve gone through and ve=
rified myself, but I should have said so when Quentin asked, and I&#39;ll k=
eep future submissions in my own words. Happy to continue only as far as is=
 useful to you, the findings stand on their own either way.<br><br>=C2=A0Di=
lip</div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"l=
tr" class=3D"gmail_attr">On Mon, Nov 16, 2026 at 3:17=E2=80=AFPM Tom Rini &=
lt;<a href=3D"mailto:trini@konsulko.com">trini@konsulko.com</a>&gt; wrote:<=
br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Tue, Nov 17, =
2026 at 07:43:31AM +1030, Qu Wenruo wrote:<br>
&gt; <br>
&gt; <br>
&gt; =E5=9C=A8 2026/11/17 07:25, Dilip Mallavarapu =E5=86=99=E9=81=93:<br>
&gt; &gt; get_path_in_subvol() and list_one_subvol() accumulate a path acro=
ss the<br>
&gt; &gt; on-disk inode-ref / root-ref chain with strncat(path_ret, tmp, PA=
TH_MAX).<br>
&gt; &gt; strncat()&#39;s bound limits the source copy, not the destination=
 total, and<br>
&gt; &gt; there is no depth/cycle limit, so a deep or cyclic ref chain over=
flows<br>
&gt; &gt; the PATH_MAX path_ret buffer (CWE-787/120).<br>
&gt; &gt; <br>
&gt; &gt; Use strlcat()/strlcpy(), which bound the total length, and reject=
 the<br>
&gt; &gt; path if it would be truncated (which also terminates a cyclic cha=
in).<br>
&gt; &gt; <br>
&gt; &gt; Reachable via the btrsubvol command on a crafted btrfs image.<br>
&gt; &gt; <br>
&gt; &gt; Signed-off-by: Dilip Mallavarapu &lt;<a href=3D"mailto:dilipchowd=
ary21@gmail.com" target=3D"_blank">dilipchowdary21@gmail.com</a>&gt;<br>
&gt; <br>
&gt; Reviewed-by: Qu Wenruo &lt;<a href=3D"mailto:wqu@suse.com" target=3D"_=
blank">wqu@suse.com</a>&gt;<br>
&gt; <br>
&gt; Just a nitpick on the comment.<br>
&gt; <br>
&gt; &gt; ---<br>
&gt; &gt;=C2=A0 =C2=A0fs/btrfs/subvolume.c | 25 ++++++++++++++++++++-----<b=
r>
&gt; &gt;=C2=A0 =C2=A01 file changed, 20 insertions(+), 5 deletions(-)<br>
&gt; &gt; <br>
&gt; &gt; diff --git a/fs/btrfs/subvolume.c b/fs/btrfs/subvolume.c<br>
&gt; &gt; index 68ca7e48e48..bac9c1d1722 100644<br>
&gt; &gt; --- a/fs/btrfs/subvolume.c<br>
&gt; &gt; +++ b/fs/btrfs/subvolume.c<br>
&gt; &gt; @@ -64,7 +64,16 @@ static int get_path_in_subvol(struct btrfs_roo=
t *root, u64 ino, char *path_ret)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (unsigned long)(iref + 1), na=
me_len);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0path_ret[name_len]=
 =3D &#39;/&#39;;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0path_ret[name_len =
+ 1] =3D &#39;\0&#39;;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0strncat(path_ret, tmp, =
PATH_MAX);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * strncat()&#39;s boun=
d limits the source copy, not the<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * destination, so a de=
ep/cyclic ref chain would overflow<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * path_ret (PATH_MAX).=
 strlcat() bounds the total; reject<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * the path if it would=
 be truncated.<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
&gt; <br>
&gt; This comment seems overkilled, and it only covers one call site.<br>
&gt; <br>
&gt; To be honest, I don&#39;t think there is any comment needed for usage =
of<br>
&gt; strlcat()/strlcpy().<br>
<br>
Yes, and it&#39;s the kind of thing which AI tends to do, and then expects<=
br>
human reviewers to remark on. Please note that the AI policy for U-Boot<br>
is &quot;please don&#39;t&quot;.<br>
<br>
-- <br>
Tom<br>
</blockquote></div>

--0000000000006377c106606b6dd5--
