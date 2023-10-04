Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57642E8FDC5
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 02:12:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B455D87480;
	Wed,  4 Oct 2023 04:12:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="dMh+eG0j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52D6D87476; Wed,  4 Oct 2023 04:12:07 +0200 (CEST)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A40187259
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 04:12:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-579de633419so19530517b3.3
 for <u-boot@lists.denx.de>; Tue, 03 Oct 2023 19:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1696385524; x=1696990324; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DPeAf/+6FaXVVllX76XTEn0Xk7VBU+oDpN9pXNafu9Q=;
 b=dMh+eG0jnNipwQ1H8HIUewu72gObDdO6v4+p8qYkQuIt1soQqsuXFwfbDpxG1+TZnO
 r3T9ZMr1heCqMlQ+VOeu7idg8xU9kopWtgrAYPVHfJaNnLGL1FcYqFV1leRRbPy+EfXH
 UJ229AodDQU2f5s2ViEU/YLLCk2km9d+igEzvuzgH1TY5C1l8RDBoofyZlhTdLW+jaSu
 H0sIMtDxszAIEErGBrUdaKA+qHirIwNzEFXFpVAW+N/Kv/gFIZQXFnlWSc9GLTvRaI5P
 nALILYMQ0sAmITycBqsUSrkuw+wii5QgaygGvzg4DgUp0uz2CT54qnLS7r5/kJ7b+VVM
 7l7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696385524; x=1696990324;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DPeAf/+6FaXVVllX76XTEn0Xk7VBU+oDpN9pXNafu9Q=;
 b=BcVHioqbVjz2HdnhWWbeyZEZksgjVEKxS+H8FIDY1CcuNnjOT759s1z+BqsRSUMBLa
 Ok1kE8qGnEbL+rhtfk/X5CKqHkYpdR5b6JFpBKJRKkmp8GArAuTt17JTQgwyKZWkzowA
 BICTLmwGsg/M0OaiZnpgHc0MMJEEA0MGAgJ+me3rHcmDaWNawr3AkESYcqSDFPJulp7Y
 Ra62t1tBhXqbWG9AZOa1c1Rc2YUsy5LZPpB0FAKgQEzLSq9mHMLhV1bu2fVOi1GkiUpn
 x845GFiRFP2i3ZNooRRThy54REJVe14bApQNQi06oiBh1Dfc9XWKfy/TkvpcUatXGGLr
 27jw==
X-Gm-Message-State: AOJu0YxAFxH3d0naTxLKefdBLn9C3/2lPdvDnQyVy6pltWEEmIZa09xk
 KIX4kcVD1fer1idpsW/rTcKw27LQvenAYOuGRpsKLg==
X-Google-Smtp-Source: AGHT+IGRMLwMLzFqatEJw6cG0YokQHp3zQtAH7uYMj6tYXN99HNlB+8XSYBv7/ef7vYqPaUGOU0L9+erk+Rj2fzJGow=
X-Received: by 2002:a81:5b02:0:b0:583:a3ab:b950 with SMTP id
 p2-20020a815b02000000b00583a3abb950mr1026300ywb.50.1696385523446; Tue, 03 Oct
 2023 19:12:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230930143623.318903-1-seanga2@gmail.com>
 <e3663767-0f99-aadc-924c-5295dafc1e6a@gmail.com>
 <CAPnjgZ32HSq0TOaULvt+TJ3NNeT7ScCVZFh3ft4sqtNZ7QRH6Q@mail.gmail.com>
 <29c14b2a-8872-ba11-b1de-040fb68da416@gmail.com>
In-Reply-To: <29c14b2a-8872-ba11-b1de-040fb68da416@gmail.com>
From: Simon Glass <sjg@google.com>
Date: Tue, 3 Oct 2023 20:11:06 -0600
Message-ID: <CAPnjgZ0QhfjaUhgmyaB7mNm4r9vL_4kbexVQ6qmqvL81SUBRBA@mail.gmail.com>
Subject: Re: [PATCH] linker_list: Fix ll_entry_get alignment
To: Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@denx.de>
Content-Type: text/plain; charset="UTF-8"
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

Hi Sean,

On Sun, 1 Oct 2023 at 19:43, Sean Anderson <seanga2@gmail.com> wrote:
>
> On 10/1/23 21:16, Simon Glass wrote:
> > Hi Sean,
> >
> > On Sat, 30 Sept 2023 at 09:23, Sean Anderson <seanga2@gmail.com> wrote:
> >>
> >> On 9/30/23 10:36, Sean Anderson wrote:
> >>> When ll_entry_get is used on a list entry ll_entry_declare'd in the same
> >>> file, the lack of alignment on the access will override the
> >>> ll_entry_declare alignment. This causes GCC to use the default section
> >>> alignment of 32 bytes. As list entries are not necessarily 32-byte aligned,
> >>> this will cause a gap in the linker list, corrupting further entries.
> >>>
> >>> As a specific example, get_fs_loader uses DM_DRIVER_GET(fs_loader) in the
> >>> same file where U_BOOT_DRIVER(fs_loader) is present. This causes a crash
> >>> when walking the driver list.
> >>>
> >>> Fix this by adding appropriate alignment to all accesses.
> >>>
> >>> Fixes: 42ebaae3a33 ("common: Implement support for linker-generated arrays")
> >>> Signed-off-by: Sean Anderson <seanga2@gmail.com>
> >>> ---
> >>>
> >>>    include/linker_lists.h | 5 +++--
> >>>    1 file changed, 3 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/include/linker_lists.h b/include/linker_lists.h
> >>> index f9a2ee0c762..e0c8a01b9ba 100644
> >>> --- a/include/linker_lists.h
> >>> +++ b/include/linker_lists.h
> >>> @@ -209,7 +209,8 @@
> >>>     */
> >>>    #define ll_entry_get(_type, _name, _list)                           \
> >>>        ({                                                              \
> >>> -             extern _type _u_boot_list_2_##_list##_2_##_name;        \
> >>> +             extern _type __aligned(4)                               \
> >>> +                     _u_boot_list_2_##_list##_2_##_name;             \
> >>>                _type *_ll_result =                                     \
> >>>                        &_u_boot_list_2_##_list##_2_##_name;            \
> >>>                _ll_result;                                             \
> >>> @@ -229,7 +230,7 @@
> >>>     * @_list: name of the list
> >>>     */
> >>>    #define ll_entry_ref(_type, _name, _list)                           \
> >>> -     ((_type *)&_u_boot_list_2_##_list##_2_##_name)
> >>> +     ((_type __aligned(4) *)&_u_boot_list_2_##_list##_2_##_name)
> >>
> >> OK, so this causes an error in clang. And it isn't really necessary
> >> because the entry is already declared at this point.
> >>
> >> So I guess the right fix is to replace DM_DRIVER_GET with DM_DRIVER_REF in
> >> get_fs_loader. But this seems like a really big footgun. You can use the
> >> wrong one and there are no errors except at runtime. I wonder if we can add
> >> a warning of some kind?
> >
> > I can imagine having a runtime check, something like:
> >
> > ll_check(sizeof(struct something))
> >
> > which checks that the linker list (end - start) is a multiple of the
> > struct size. Do you think that would find the problem?
>
> Most of the time, yes.
>
> > If so, then it could be perhaps be turned into a link-time check. This
> > produces a list of the linker lists along with their individual
> > members:
> >
> > or ll in $(nm /tmp/b/coreboot/u-boot |grep u_boot_list_2 |sed
> > 's/.*_u_boot_list_2_\(.*\)_2_.*/\1/' |uniq); do echo; echo "linker
> > list: %ll"; nm /tmp/b/coreboot/u-boot |grep $ll; done
> >
> > ...
> > linker list: ut_str_test
> > 011a9a20 D _u_boot_list_2_ut_str_test_2_str_dectoul
> > 011a9a30 D _u_boot_list_2_ut_str_test_2_str_hextoul
> > 011a9a40 D _u_boot_list_2_ut_str_test_2_str_itoa
> > 011a9a50 D _u_boot_list_2_ut_str_test_2_str_simple_strtoul
> > 011a9a60 D _u_boot_list_2_ut_str_test_2_str_simple_strtoull
> > 011a9a70 D _u_boot_list_2_ut_str_test_2_str_trailing
> > 011a9a80 D _u_boot_list_2_ut_str_test_2_str_upper
> > 011a9a90 D _u_boot_list_2_ut_str_test_2_str_xtoa
> > 011a9aa0 D _u_boot_list_2_ut_str_test_2_test_str_to_list
> > ...
> >
> > Then you can check that the address of each one increments by the same amount.
> >
> > Maybe.
>
> Yeah, this would be the best way to find errors in the current system.
>
> But maybe ll_entry_get should look like
>
> #define ll_entry_get(_type, _name, _list)                               \
>         ({                                                              \
>                 ll_entry_declare(_type, _name, _list);                  \
>                 _type *_ll_result =                                     \
>                         &_u_boot_list_2_##_list##_2_##_name;            \
>                 _ll_result;                                             \
>         })
>
> (untested)
>
> Regardless, I think a link-time check would be a good sanity check.

OK, well if you take a crack at it, you have a failing case to test with!

Regards,
Simon
