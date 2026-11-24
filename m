Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C27F606A322
	for <u-boot@archiver.kernel.org>; Tue, 24 Nov 2026 09:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=V+1LA/9K;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=n3QM0yRv
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E4000607CE;
	Tue, 24 Nov 2026 09:59:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BSw2yLhnheI2; Tue, 24 Nov 2026 09:59:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 392526070D
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795514396;
	b=H/aLYsTWBpV3ksR3VFlGqLkCqA7L7ibS2jYMvQKJwsoHaR3ea80y5k4XrqFUdDoPelVz
	 BKO1TKy845dr7NVJVOJJpzNnJs7rloG2EqqEaXSx1mNdYTtjFpOINaT/V6JH2Hwq9jYPC
	 mWzyuoxGk5ZcGGhxfRuU36/144XnXBnttiOJOU25jUuNc9PcnXumUMgz2rfQzKXsQsSUh
	 7+INUFk3l+05plM8+oFZbJzhwqR+II4NPbCAGCJSWYOKn7gBncJa/fN5fQT1T5WUHQJXD
	 uXOWHsCh4kfHybYritr5WXgBZtTggTVeWcIgEQLQd94rSSfJYwHYkcO/XwV/Vp2yXqw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795514396;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=HD+wGGoM4r8yN3x+JuPtFhB68f1vgx/e1cZV6pk8xLI=;
	b=RkTyqZIHPtF4rsKWTX0md9P0oko4dhgsU0K4Wbqxdb+T89KPXopyKcJeEGgOIOq9j75O
	 aQT7elyyX5iaE64sDv6knXiATZz5zmHTUp5Lgv/to+vmv88GOO6Vz7UWkRsjyRxPps4GD
	 kFjUb3RGfWGJj4J29KAVEEwaaCe/ismn4PXIkPFiT8wF8Jv6EvJirvjAJFL0X9jXroXUl
	 3SW2mQUyw/fSW1aEOSSF/BBoOnu2eQ6YsRTMzbDLGvspuBKRiHwUO8aWnYTK8ZmXm60R6
	 L4eMnOb8KEbfVb2dQmqccCHu8NQKXPAuwWykb1jkoUxPCNoM05jZuhvbUClnRqxOMrQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=n3QM0yRv;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795514396;
	bh=HD+wGGoM4r8yN3x+JuPtFhB68f1vgx/e1cZV6pk8xLI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=V+1LA/9KJlIO5m5uB0yXILYCd2asZO4TYCJZM+eWPVBZlO8g9Dln+AUQ++YORtjl5
	 3p4yUTHJc2lcmVI25NUFfmF667H/o4iuleRhgWG0BjKyft0U5Vpw/rIKy60Nn+LHP0
	 SizkPGISXZUC8gEHJRkIUtGIbVfuJ391ZX8XX5fnxgqXwYknnTTRSwwVCfdZoq+56M
	 vfR2IaluEnG3WeFVvj1R+5EKMlgaiW/9qhNL4rzelca/Gv2DcyXmOQ33IFPlmS6OgC
	 LoqQWPV5tVZYAkI7WF0uz9qHr8McnbWKlmL8drt3iUKFtFdUGhkFqFgFDGISheJTSE
	 I4h5LqlOWOavg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 392526070D;
	Tue, 24 Nov 2026 09:59:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id C1B761C9
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 09:59:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A79EA607B8
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 09:59:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Y5MMqNN6A_4p for <u-boot@lists.u-boot-project.org>;
 Tue, 24 Nov 2026 09:59:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B24046070D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::a2b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::a2b; helo=mail-vk1-xa2b.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=n3QM0yRv
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com
 [IPv6:2607:f8b0:4864:20::a2b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B24046070D
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 09:59:53 +0000 (UTC)
Received: by mail-vk1-xa2b.google.com with SMTP id
 71dfb90a1353d-5eadef147ffso3435213e0c.3
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 01:59:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795514392; x=1796119192;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=HD+wGGoM4r8yN3x+JuPtFhB68f1vgx/e1cZV6pk8xLI=;
 b=n3QM0yRvcM51J/J8CimOQnIoJZm4OhV/skJxvcRCtWyJd8KnLNr1bmp6IEdroxlkSm
 MQAYhAPnV2Cilk086ELzwv9aTRcKO95olKoRkr2gwDLRBkeSd7d6HihdEZfTZOF3uKVl
 IykMNFEIy89x050UO+OGuAFCA3604Qb0q9/oPNbUMY//+k60IGtFrQ9+/0pXF1A4SHrQ
 tTQRDp5go+we50fxbblIP2oNBXMPt/WQRc/my1N7xu5am3ln1LoVkHP9kjRYZp5oEWGM
 OlD60M+gkmrZPruEv6uX1J0TRkd8gQgfz0REzvt6tNEoW8FwqLuPtZlKnnVc6PUbArux
 a1zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795514392; x=1796119192;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HD+wGGoM4r8yN3x+JuPtFhB68f1vgx/e1cZV6pk8xLI=;
 b=qp3JdmAWdNk6hdCYSaFeO0gdEytSy25579lUQNwqzEzIRzXQNJxls6tiB/4fc5F4Vd
 VfalhW9pmlErdKCDECrz2f6TGbIX2Q9XQkTfLxn0y6lr0T0KHpQQQXYI8usx08jlL5kC
 ZHN1ZClW1DBirN0SXs8eFa1PK8tQvfnFfyKuqKwWY1s6HvyLACCKmZOOYwOxk4p7XAtc
 HFnXieQ5leevc4+iRBmAMoK9DrhGRMuLuDjFOhxMmH/cbP7IVn/jIVOFOqb/0ZQdwGeO
 BkRjl8dyUL7ibRSP/5+mvW9orDUPV1Z9nCirsKx/9xEFvLAcFOL7kdUReTR+OK9a4n+E
 vmlw==
X-Gm-Message-State: APuU4Z8RvhbehPaKyeuE2wA6fnbGYqu/YrfPcow1jsnpzj5rqVC9B0cd
 afZmUwFXNMAPsvYz5fpvPFBTLV6dp0lpuim3VtYD32Hrlhkz9TczVqSJOy0ps2Xfnk6AeZyDVAo
 ez5bkL7vESTyyvyBu3twNQxnabshyJd8=
X-Gm-Gg: AZFdTZfHDaWptHCuvBJvFRvc52ugJWXMYvX/7VJNWNW43P/IkN9NqikKim341u3I9eO
 NR8NA41TfkwfN6Ny6816nfG476oOa3WZ9FrJLtu5CAhstmV0H86KXpk1tBJC5OjavWnylVmHPwX
 7AfNgtMHyrhDjOZT/EepD8jfvAIdilksW55E5BpJiK7znq3urcmLMxj6TNEMpSm0SWxc/rrB8wB
 gVllgMndDejVUuA3yioKvzN+9eyoacTBzjKgSNcoWv1+GVkXQY9XL6hzKRxb7lnz8LgTyGCR+FO
 ctdvKio2XeOd2WrkX8fqoZKAux/IcI7VWuqCbK1MaDJq0K4tZc9jbHrHi/Lwbx9w7skMQAlWq9X
 sez/dftqdWUygoCerzV84pvlR2DBN45A/yI3OQWwFD3UYDVXBKPqyil/weSh2rzUyZ6PrrI8js5
 V3BOMHfjsf0KEfpUfkZowtPfSJWf5PQLFBaTDDdf5d6vWj9Sx+HHbDacMrXKJ+W6TjVu5HHab6b
 gn8ORN8/Q+i5aoPiIQFg9N10nNSLA==
X-Received: by 2002:a05:6122:2224:b0:5ea:d03c:f0cb with SMTP id
 71dfb90a1353d-5ee8ad120d0mr7693703e0c.0.1795514391929; Tue, 24 Nov 2026
 01:59:51 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261123-submit-lwip-wget-httpdstp-v1-v1-1-e1759174ab9a@gmail.com>
 <55dd0a77-5315-416f-bbe8-e952a03d874f@mailbox.org>
In-Reply-To: <55dd0a77-5315-416f-bbe8-e952a03d874f@mailbox.org>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 24 Nov 2026 02:59:39 -0700
X-Gm-Features: Aa3M54qyWfOVOdL8RhG8JzvDfuxY7MyXpBaWmW5eVVx6zzIAZ3EF7Cu7AE2rcyw
Message-ID: <CADvTj4p9LJ+kwDSZ2fyw-P3fLEewbxN587dvF2OrpKQdY=k3Yg@mail.gmail.com>
Subject: Re: [PATCH] cmd: wget: honor httpdstp for legacy arguments with lwIP
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: u-boot@lists.u-boot-project.org, 
 Jerome Forissier <jerome.forissier@arm.com>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Naveen Kumar Chaudhary <naveen.osdev@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
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
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 23, 2026 at 4:37=E2=80=AFPM Marek Vasut <marek.vasut@mailbox.or=
g> wrote:
>
> On 11/23/26 11:13 PM, James Hilliard wrote:
> > The ADI boot scripts set httpdstp to 8000 and use wget to fetch
> > ${serverip}:/fitImage. With lwIP, wget still connects to port 80
> > because it omits the configured port when building the URL.
> >
> > Use httpdstp as the default port for [host:]path. Preserve a port
> > already present in the configured server address. Pass HTTP and HTTPS
> > arguments unchanged to the URL parser so an unsupported spelling is not
> > reinterpreted as an HTTP request to a different host.
> >
> > Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> Do we actually want to keep perpetuating this legacy behavior or do we
> want to leave this behind and not complicate new code ?

Not sure, I figure maybe try and get feature parity first and then clean
up unnecessary code afterwards to simplify migration to lwip.
