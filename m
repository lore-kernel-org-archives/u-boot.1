Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A43606DA91
	for <u-boot@archiver.kernel.org>; Tue, 24 Nov 2026 09:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=uiaXomJN;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bJ2wiu/j
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8ED7F40662;
	Tue, 24 Nov 2026 09:46:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id duGrmjbCq6ax; Tue, 24 Nov 2026 09:46:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org DDFA14066F
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795513615;
	b=RdjHXlaaVGjn8i1d9biAMWkQPUDuUUd+93glaCcjMLghyfxTkX+EOKd/RniKLbcmsefp
	 PS6Y19ISCsHNAUc5UsWuk9eTZ85EyxoCtyOB/RWYwsUsR9EaXl7856Be2WxuZ4ivEeo9X
	 AUq6J6SpFs6tGTYN3oXwhE2spomniGugdmlmoC48R9tOt6UZQs5tBwca+xbwS69oVfBRk
	 e/6bMtLWKPbj8hyLwD7UVbHK8dAOyMSzI1IVcDqjPnTIHB9g4UZpAbhkNC3GrtxOEsq1w
	 pEvjyRkHtmm5ZHTbtAZWtUzHT+JhQUuc8HeerxfB/RJjFFOW/N4An6TGEhQk6/K45IA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795513615;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:X-Gm-Message-State:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:
	 X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ZezgQaNM1hMwmB8HmXC1vSSl8BIKVLV6xzzy0uOkBOc=;
	b=Nm43GxZti724PuJvtbKJOuu3iJ4wU8Vxp0yLrtQScdy9OM0qW2JzV9Osq+1x64AC9OCc
	 Jx2OSk+ENRuBd8ZfRcxvHZ9SZnP7Q494ZdLGXx1dJKEmnj6qb3vhSn1taNnKW4nUOTtxn
	 vN03fiOgAv7/oR8d/BWcs8Q+wMK5830N0PWhqvhehRVzLAQlKNFfqG/GwRajl5Yf7BURC
	 G34/kSizB/i71ZVX24cHxNNs5A390UxZ1lhFCF8VqiwsnLNbGfM869Ngq3Mr9zFY8w+XF
	 TERRHCiaaxNblgExX1hPRnPdVA/T07rHhUM6cL/c1Ez0boDH4LBdnphaNUiObOYdXEQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795513615;
	bh=ZezgQaNM1hMwmB8HmXC1vSSl8BIKVLV6xzzy0uOkBOc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uiaXomJNyiRNF4CJvAFwf9LZ8nFsM9W9hr3ArC11g0Pvl1ZS24F2ZvHHhS+NfWlL1
	 khgxoC1IP73V48820xM/ODmtrPmgaUf5WZh66x6i7ntaCp8xdiHCxL+hEsH30QeiqV
	 EtoAPSIQU5nPPXlHakSdrxKBNCaaRgRbxYdRfFvxgVyD4W9HocUBK5BEloPU0Z0IWH
	 3mFW8utt1swpqZgwKQwHRG21wRPQ0eQSmJYxfpnYALrpycJrS9MhR3rhz3NNQP2x4w
	 /ithomWATSL5a36+LFc4/Qf3PT1/3mKUlJ5XCmOnYLiVt5lnbgTahnJDQ03dn3LnkK
	 13CNCiqlQBnCw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id DDFA14066F;
	Tue, 24 Nov 2026 09:46:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 26AE33C4
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 09:46:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DAA4880F48
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 09:46:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id U4gOXFqPFtqO for <u-boot@lists.u-boot-project.org>;
 Tue, 24 Nov 2026 09:46:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 452C380F47
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=linusw@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=bJ2wiu/j
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 452C380F47
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 09:46:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 68D886259E
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 09:46:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 129561F000CF
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 09:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795513611;
 bh=ZezgQaNM1hMwmB8HmXC1vSSl8BIKVLV6xzzy0uOkBOc=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc;
 b=bJ2wiu/jG+lKGyysUeaYwB18zoLFQhMBS8MBgAXSkvlQu6QKkfaYsUO+0rgzKlI15
 YXFkid6N38rPY1wNtG9tYdgucbp7gzZDK3++T8b+L7kDZ/JQwW3zUSH32LD6xwakZg
 AHF7G0UExXuKJyG4yJz0nrkxinJQhcJRvhi4R7ntaYSOaBoMKKNP5DyDV6ep5KZmE0
 q5gwGyTj4eDe/igadtGw6XDDdy164wHm7p1E+YkqB97dL67au2Rnkp5/nCwQKTLJDu
 Hs8LC8TmdZftyvN/pQKxw9SzDHyARbHICGlhBVjUgvnko8iQrV0+yImotnV1lLN2Uh
 zd+GcUnhKtOzg==
Received: by mail-lf1-f45.google.com with SMTP id
 2adb3069b0e04-5c148d4dbfbso4123705e87.3
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 01:46:50 -0800 (PST)
X-Gm-Message-State: APuU4Z84f42CxBeSpMm1hdwZjyTFh0GI+I4mKkpfmdZ+isJ6te+MUsxh
 +Yw3pRX2dMMYtF6CKItlZLjxO8oaO87K5O3G/+JTdRm8Mkn9h1nQksl6jE+dMLgd+Cm7nc0/pRG
 U0R3IgXHTux/ZdudEs6zfibZBAUj7B1A=
X-Received: by 2002:a05:6512:3d0b:b0:5c1:5c55:2d38 with SMTP id
 2adb3069b0e04-5c1bc7d465fmr4607448e87.25.1795513609827; Tue, 24 Nov 2026
 01:46:49 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261120-ux500-efs-v1-1-58147e2eae41@kernel.org>
 <awM3X9Ku4Q4_-jkX@linaro.org>
In-Reply-To: <awM3X9Ku4Q4_-jkX@linaro.org>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 24 Nov 2026 10:46:37 +0100
X-Gmail-Original-Message-ID: <CAD++jLmsVBgrcYpWWPG+ooAmZh7Sio6N39vZ8z7wW7a34wo=og@mail.gmail.com>
X-Gm-Features: Aa3M54qgZAXdOm092z412FCPvCekhZs_sXfsndYm25DzfwOebizA85rqATHbTpg
Message-ID: <CAD++jLmsVBgrcYpWWPG+ooAmZh7Sio6N39vZ8z7wW7a34wo=og@mail.gmail.com>
Subject: Re: [PATCH] board: stemmy: Read persistent radio addresses
To: Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Stefan Hansson <newbyte@postmarketos.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Stephan,

On Mon, Nov 23, 2026 at 2:12=E2=80=AFPM Stephan Gerhold
<stephan.gerhold@linaro.org> wrote:

> > +     for (part =3D 1; part <=3D MAX_SEARCH_PARTITIONS; part++) {
> > +             if (part_get_info(desc, part, &info))
> > +                     continue;
> > +             if (!strcasecmp(name, (const char *)info.name))
> > +                     return part;
> > +     }
>
> I guess this is basically part_get_info_by_name_case_insensitive() as
> fallback to the real part_get_info_by_name() above? Do we actually have
> partitions with differing case on some of the phones?

This problem was only in my head. Indeed after looking at some
phones they are all uppercase.

> > +     if (fs_get_type() !=3D FS_TYPE_EXT) {
> > +             fs_close();
>
> Do we need the same fs_close() call in any of the other error paths (or
> maybe even the success path)?

Most other cases are on the error path of  fs_read() and
fs_read() has an implicit fs_close() on failure. I tried to clarify.

> > +     /* Fall back to locating an unlabeled partition by its contents. =
*/
> > +     for (part =3D 1; part <=3D MAX_SEARCH_PARTITIONS; part++) {
> > +             if (part_get_info(storage->desc, part, &info))
> > +                     continue;
>
> Oh wow, do we have unlabeled partitions on one of the phones even? :o

Another "better safe than sorry"-hack from my side. I've dropped it.

I've sent out v2 check it out.

Yours,
Linus Walleij
