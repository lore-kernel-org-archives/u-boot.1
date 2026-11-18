Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25427606A33A
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 14:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Hs+YoGcT;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=nzn9Oz33
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EEF8540790;
	Wed, 18 Nov 2026 14:15:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pG6vspj-E17B; Wed, 18 Nov 2026 14:15:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 28F4F407C7
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795011315;
	b=n0OU5Hamk4XCO+i8OAgsuhSmQOIZWftbvb1gP+f73PJ3bBODD+jB6bUslqg358ByFRW8
	 f+TPBeNA1W/KmudW7iw5DybVNwrIngemyKQtOtjk/clM9WUFT4mfgQov55UD6T2qTsEbS
	 AUTFY3IPStjimRHnHyVxEHBNLg03rx7T23OjnD9UA3H6bU321lX3r3hroEmadyTZizJL0
	 n5pSSffne4shAaDhtIQfhIdao7vpUQctt0UeoGDLuZZ1R03P9ekP6EY6kJnk1IRq1LEM5
	 6mUcxpP56AwRS/HCDYPyXUvVO3WuydrJbKjN6YOcZZmH9rgqle9gnMYkzc+wEQU41aA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795011315;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=/FHPc9LGXQ/OtR54UxyFZbVh7I4sIjaGAw7Om9b/Lew=;
	b=JDGmodUfkEFKFW3eTNMTB/30sMbF8gQ6SY2A6NrddrPiFTS8H6S7jeq0q/bCyr1HrT9r
	 5UIKNwG3rv39crg1+dpiYSI/5SUwMLv0G5o2Eevj0LKRKu5o4UTOoy5P5mXIHWB0Z0J2X
	 bbPlM2tUU0Ymsvrl3qCjaXYS/PPcFXnSRxPF5PCIbH2ogYLn4fw+hO02aHROT7ECtN4X6
	 LdkP4v78SYgU4sWyNmf/z5slt6J3VQ6Bxi/Iz7wcyAYB/Q4WrQKnKWP8A7j2ClYwoXU8A
	 d26CUxtdJVUFO9gkoiMr21xr+6fD5kBSImSnYBj1dVbE0DDVy6H/WllhxuLeRKNrUQw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795011315;
	bh=/FHPc9LGXQ/OtR54UxyFZbVh7I4sIjaGAw7Om9b/Lew=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Hs+YoGcThWOFq0EDFyv1tR85/A2QM/bvaIIFlZNZqiS11agqhcYxQ0sxS8har2C2G
	 yKOTQ/MP3VrqBqU800iilwRrwlbBvAAYoWINwM3DlQWRA+lrwGoguG6SfcuArl53ab
	 qEFPLwx88p6h5f4lb+G3GjjjIdhMyetrGqAMnOFY60D2fre+MsJpUFOLBkc5hh5gIh
	 rTL5IrnvHOYgxvP79Exuj81IanIRr+M4x8Qyeyx1K7qCvxocuDhgXfm4Jk83Z/zESZ
	 hDOMfLSJ3zeP1VX9rsBJTYxjxCgFYrDfGRcNIZJ1He48XiwMJFYhcWuua8EuUBlJYl
	 kzgIW/TfEkQxQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 28F4F407C7;
	Wed, 18 Nov 2026 14:15:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 9C46270B
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 14:15:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 81EAE60844
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 14:15:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zfbK2mKl1nIx for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 14:15:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 724F260860
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::b12a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::b12a; helo=mail-yx1-xb12a.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=nzn9Oz33
Received: from mail-yx1-xb12a.google.com (mail-yx1-xb12a.google.com
 [IPv6:2607:f8b0:4864:20::b12a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 724F260860
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 14:15:10 +0000 (UTC)
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-67da69e7c31so913959d50.3
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 06:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795011309; x=1795616109;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=/FHPc9LGXQ/OtR54UxyFZbVh7I4sIjaGAw7Om9b/Lew=;
 b=nzn9Oz33ch5DEj1fU/D+Vmhd3dZgdvr+cMH9+7PD4jn3Vchlgzq3JSeK/38g2E9n29
 Z1wJNKXnpBPy9Va4kyV5igMUFi4mKCdcOg5MeZGlGChijkRg4eVclxUPLMfgmQWi2khr
 DLclBw+lWWdBY7dMvwsP+VFPZvwYW0fSh87KYlYsMaljGk2dUof9aT9P/J1BLfgsuSkU
 If41f7BqfA0shURx9zMacWvMEV2yLnzk/VFfzaYzeiJ6wfgFkHVSVbwFEoH7xC96xSoT
 Ns1mrwDwARR+f8iHW9II+i3cThuNWS1v8Szi30nONhlC2eeaBGSEgG5JkiWGYQ9+g7W2
 H08A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795011309; x=1795616109;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=/FHPc9LGXQ/OtR54UxyFZbVh7I4sIjaGAw7Om9b/Lew=;
 b=Yy6jWIcpP1ONu5bcoqieK9SBjApCqTFUaMESfa0KytcrdnaeGsbleewbwdKGK/WfIW
 yrUnY8H2IrkHyi++jnT9/vK1/aPqhgYCYQj7ahgpxg7DuWfCaSWFrip8ms6zqxQg+xFE
 k3gkkemW0pgMxCk3MaAQ8kV+gTJS+GMyLS/qmhLf4+IZ6XgX/tcNQlH/OHdPDM1FSDbm
 /vS7TgyVxATJBjB7L57n6/TlWqDFr3jVf/6+YDulKaptu4JVDrZBimTqv/LP2IXv/QUW
 Z8YUoBN3c2badraVYcbGd6D7MGZdO27XGifHP01RwICMVNZxUMoXNc5hgCa2+qFevKf7
 idzA==
X-Gm-Message-State: APuU4Z/JS+J5CQsZl8Xj4bCf/ljPPw/ZVmSvmSrxqInhriELM3dvdo99
 kAq9fF5rwuJtWMTQrNKKMQ1ns/zltWfrqoV5AGhwnc/paULw05naV6iNp9w9CIYSG2E76udNSvN
 h0YWmmzbJj728LHAuxWrE8EUqeQGBUZ8Ptp7oL64p8oDZx1cHbpsDigI=
X-Gm-Gg: AZFdTZcOye53it4Vzm//s+nk25cOkluk3dzttJh8ysxdbLbh5wF4pTTU16IAqscuyms
 +zmkhJyFEmaEw0xB2V2Y+U2vCps6xXKLg6rY4bpQ0VtzKsFIHBUFN8jXbiq/PR/x44IdRUVAsUL
 mDcFka2tPsXzK9EFG8e+dVrk+aN4TrJZ0KucLTZjWj0XDYYfFZOsU1AsIF0gjpgN+0H3JA+OgAr
 p2b0wiY805m9PalggNFqUVoaVe1KQGf/YhYvJdnGzvDPDgkGB2ewUv3s2bUZK/1WZZnR6s2TNKQ
 BVeDoWlz/nUULdYPc4GJw2DfH2vI+z4MqKAM/vOedz6XRH98XBbVGxcOEvqCFmwFMvJVBSerGzs
 cy9vCZZ6fWkqSkm/eZqwejz/eOo554tOCqa3vQNzdDKT2Tl1dvnC+S4NpbQYanL9gGCQsLsB/BV
 S8U/yHHyEYEIMuskgHgzRkYzK6w/ltB3tHMuUEqiJ2QzrEJc7iScl4lhiE8SaiNVl1P8n4/PSGk
 NNpM/sg/eElWdi9TUd8c3JyqmcSANVG/tOodTLweCd9QaTNu6kX5q4KyVljuEmW+yXPwT+tjVhX
 9UxXmEX9D1rB0wNb/MbCSgGthEjU2++pNTg2N3aWN5Hpyb+DsqwQrrnPFMIE1TgfsgFrnWj/yQp
 SAW2oqA2+Z2wLW1ESRcA/eTUEvWviMSBN+AslM2xCGdh/8n0ptd13G8DOI3/2hHBxqqD7tVDs0h
 zqpLseNM6J5+LYNo5SKPXmB6URLFmXIDkW5Of2xKUejPN+VxWFonFjjZuE4aRDpdgGZM+/
X-Received: by 2002:a05:690e:1382:b0:67d:9fef:d614 with SMTP id
 956f58d0204a3-67dd4530a30mr1145813d50.38.1795011308700; Wed, 18 Nov 2026
 06:15:08 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <dacef858-56d7-4708-b784-16b0133bb6aa@gmail.com>
 <608bd6ca-5dec-4f2e-a17a-83bfd3608261@gmail.com>
 <CAC_iWjLXfmSAgd0nSrXi-OzsKq0ZwRRwACmTUcT9uWEBRqcGbw@mail.gmail.com>
 <CAJnxHsgJNP_kMbVT6583uBd7aur2c5s+hSHd8YkOQQj3Jze20w@mail.gmail.com>
In-Reply-To: <CAJnxHsgJNP_kMbVT6583uBd7aur2c5s+hSHd8YkOQQj3Jze20w@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 18 Nov 2026 16:14:32 +0200
X-Gm-Features: AclHuK-M7xS1Od2OSLhlFlxENTJkmABLoKPfLiJg6GRFBe4jCnl2HkG6AwMdD9M
Message-ID: <CAC_iWj+Us8uL0h_4wdaLkY1DaXqPSULuXYoc2f9KYiH1nnX43w@mail.gmail.com>
Subject: Re: [PATCH v3 10/11] test: lib: add tests for the PE image checks
To: Ana Bobillo <anabobillo3@gmail.com>
Cc: u-boot@lists.u-boot-project.org, Heinrich Schuchardt <xypron.glpk@gmx.de>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 18 Nov 2026 at 15:21, Ana Bobillo <anabobillo3@gmail.com> wrote:
>
> Hi Ilias,
>
> On Wed, 18 Nov 2026 at 15:00, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> > Is there a reason to open code this to create an image?
> > For example, in lib/efi_loader/efi_image_loader.c we check the Magic
> > and then decide if we are looking on a 32/64bit image.
> > The headers into buf are in known offsets and we only really need to
> > look into IMAGE_NT_HEADER32 + Magic.
>
> No good one. The test follows the loader, which switches to
> IMAGE_NT_HEADERS64 once it has seen the PE32+ Magic, but every field
> the tests set except NumberOfRvaAndSizes sits at the same offset in
> IMAGE_OPTIONAL_HEADER32 and IMAGE_OPTIONAL_HEADER64. So the image can
> be built through IMAGE_NT_HEADERS32 alone: test_image_init() sets the
> Magic, and for PE32+ only NumberOfRvaAndSizes and the start of the data
> directories differ. struct test_image then shrinks to the NT header,
> the data directories and the section table.

what's "No good one". I assume you'll get rid of the custom struct

>
> > > +/* Set a field of the optional header of a PE32 or a PE32+ image */
> >
> > This is obvious we don't need a comment. And we can probably remove it
> > overall with what I mentioned above.
>
> Agreed, opt_set() and its comment go with the above.
>
> > I am not sure I understand this comment. You just need a buffer to
> > store the image no? What size check is missing?
>
> None with the series applied. It refers to running the tests without
> patches 1-9: a test then reads past the end of its image, and since buf
> is larger and zeroed there, most of them fail on the returned status
> instead of faulting. The comment could simply read:
>
>   /* Images are built at the start of buf, which is zeroed */
>
> Should I send a v4 of this patch with these changes?

Not yet, I need to go through the rest of the patches. There's no
point sending a new version unless we've had time to review the entire
series.

Thanks
/Ilias
>
> Thanks,
> Ana
