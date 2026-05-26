Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0653FCD5BB1
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 12:42:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A902A84869;
	Tue, 26 May 2026 14:40:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=binarly.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=binarly.io header.i=@binarly.io header.b="EuqKzaIr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5734C83FF5; Tue, 26 May 2026 12:57:55 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 727C280433
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 12:57:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=binarly.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anton@binarly.io
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7dcdaf06498so6751953a34.2
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 03:57:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779793071; cv=none;
 d=google.com; s=arc-20240605;
 b=fg2mh/IgqpXHrfek6Brz0X1wvdxA9/OEDPKgCW8Sp0Bi10wAhxcI0g0oUI/VqcjGjC
 Sxv/m7lJW1Awq3E3EIpYK9oAC0/kHGQSAbm26EUqewi5QFGvvYoR8iSSEIKenBankrET
 6hZIOeik20ZvXo8VBLm83WJqnTO5n/M5wcI1+DdwNTp5/ozv3tLojrvMG1VroZ2vNHNi
 cIzgUMHrt2evyA8nFCjZXCGCBBupMTMvdGseyhbxSQezTUMmsCYFzpuSbcH8YhO6jL3n
 V28aqx0okkV7iuY/Atj9bQQiw34AG89kD5PlLECKEWxX1ykPGARhKKdwUR6apcQrg6Nb
 n/7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=NNGqw0kIgA35bcqrE7yvl5KZlva6MrRSAwElqPgRcGk=;
 fh=WiQnRVALQAX+rGD+UAbZLXRgVCwFx/voafi+skY4A8E=;
 b=NQs+O/MDwYf0z/olekI6FGG0kSqXvRYur02ocGfNaE7GvA/F+2bC5POVZjDo9Vn4Ch
 duhZ99OMPJDN4maQF/Mi6gpV7+Sny3NKLotOojggqQCOh9QqHvnmdY6xLE7BKLltDLzX
 0VRcA1/Y5O024F9xJW+1MnYZAWWwGKzpepWzd7WQH1ulrNVo5CHDHzDSyqSbKOwm1CtU
 kRXRXeCu4TUrkmNVOttrGTN/93Qc131kfVhsJvy23CXNrwhvNaGaXSiz4tlQOb9LB4kE
 jQDf+TpwMYSRohpaKqoo7K/j14HbaX35ABWpzWvmKWLNJOkvhV4+JhKHBiYXwrSQigku
 FXEg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=binarly.io; s=google; t=1779793071; x=1780397871; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NNGqw0kIgA35bcqrE7yvl5KZlva6MrRSAwElqPgRcGk=;
 b=EuqKzaIrpVBIEkhLb1YwCbkabXQURJM+zCUW0t6yqqk2o+WMca3voG2sqDLddj5cEQ
 eoMl0i4B4M93GRAqkOqWssyJ4VTPKpwWHFqUrKHyK7637AaRH8UhIcZFSfqwWyJnXw4B
 FVdiHFGciGAfI6z0uWUA/q/R8XrwJ67Gp8LBKKxsYgAQ/34dBM2zr+5m8I0A7sRR28+L
 a6iOt6vbrT5iO3VKZuubqpKKgCEoLMlSCmC+YN/mz4L0bibo03Nwhqc3YRDLR2cMEo3i
 ftfDH5pInkGThX13/3b3N71HWe68Xyvmdi8r9oMK07QJrTxHqhrTWxmYOqsxNDfGPyF6
 yjWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779793071; x=1780397871;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NNGqw0kIgA35bcqrE7yvl5KZlva6MrRSAwElqPgRcGk=;
 b=WHcPQDdXJJRp7j5umqmE+PL0HXN7p9DI6YI6KEiLOxvOwRXZe5SGIZ9vljiM64p376
 JBtn8SBhk9KzUmF8z6Ty2Lj7Ykw8QOwaV5Q6gylJPNVGUwKJPu5EOXJGyfIXW6mE7RJt
 C3Kwr19he7Mxdpx6m/e/SKJXydSlXHN9D7XWc9gdgLorgL0BvHtr60kySBjUH5RgndMJ
 Boyjhnrla3BUxwgJYF0uI9uHvU14Az7AN/f4BAU4eyPWSGc2l2TKF9R8GZzzv+uIG3Ru
 WWHCCE9Bj6X/n9+gQJHPyDyY8QrqUTQCzL3pYGRo7YTSwiiHFYhQAXK4zWGWSLAufFkR
 qLDA==
X-Gm-Message-State: AOJu0YwcuGMNh/q9vYcOIG9nVPJbMNOSx+xDtKakue6qpErgadi7JmAS
 L91vhQfcyz4wASdYfGT/umttkdQHNjnmiIg+QoWVh+d2jc1OJrS5SCMHZ83z5oDXV6TCRbeBrQR
 mvLE0C0d5YcZH7BTHRIOF1Bt98m+nnKFAECI82RNyR6vAE5655wAVn6Os6Q==
X-Gm-Gg: Acq92OHUku7ADUpXdXZGOSfLKcg4QqOGW5K1Z8T8KWyv3bDo9BCAX6nON8eZ/pqzN0k
 Q+ei42DZT99MhKZRd2Za2HnXnqyhXcfWF5Gr6BoHTtR3h8CPYDSpmKzeAUFQZwBzLcjS3EP1V2h
 tPYJ8ec4zPvtcQ79UReu6O/xK+XrqUX+uGWubV48r8JUJElaJ6ljkNrE9xnT7TY94PFfrJGqi8o
 mzFAKRq2OOkG90YeeR3tSm+PHhcH2ORSf+0t1ohJJMRmHrbmZsk4KCXvt4VtjcubkUGGBlhGr+w
 FcvcWF0XhGxFzkBvRQ==
X-Received: by 2002:a05:6830:4983:b0:7dc:e336:c828 with SMTP id
 46e09a7af769-7e5feed3958mr11622353a34.10.1779793071035; Tue, 26 May 2026
 03:57:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260522123024.6292-1-anton@binarly.io>
 <20260522183228.GZ1858239@bill-the-cat>
In-Reply-To: <20260522183228.GZ1858239@bill-the-cat>
From: Anton Ivanov <anton@binarly.io>
Date: Tue, 26 May 2026 11:57:40 +0100
X-Gm-Features: AVHnY4KcTFuHaHmgLUflhROWU_54JqMuAyzhnKLXchA83o6nafpeh8NdWieAsHA
Message-ID: <CAPWaX56D7qwmjpm97dpRM44BpWAnHEogoEBs-UAk7zDxR2HRoA@mail.gmail.com>
Subject: Re: [PATCH] fdt: Check return value and len of fdt_get_name() calls
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, vr@binarly.io
X-Mailman-Approved-At: Tue, 26 May 2026 14:40:44 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

> So scripts/dtc/libfdt/fdt_ro.c comes from https://github.com/dgibson/dtc
> and should be sent upstream there too (and all of scripts/dtc/ is, for
> reference for the other patches), so that we don't drop this part when
> re-syncing later via the linux kernel.

The patch for fdt_check_full() was added in the upstream dtc code back in
2022:
https://github.com/dgibson/dtc/commit/fda71da26e7fa00966a58afeb2114269b5512=
e59

It was never ported to U-Boot, most likely because the function was moved
from fdt_ro.c to the fdt_check.c.
Linux kernel does not use fdt_check_full(), and thus it is not affected.

We also updated the BRLY-2026-037_BRLY-2026-038.patch to align with the
current dtc logic:
https://github.com/dgibson/dtc/commit/50454658f2b5c8968ccd7856d94020c893a4b=
e46


> Next, please rewrite the commit message to be concise and follow best
> practices and examples found throughout the codebase. This applies to
> all of the patches you posted, thanks.

We sent the new version of patches with the updated commit messages.

Thank you,
Anton


On Fri, May 22, 2026 at 7:32=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:

> On Fri, May 22, 2026 at 01:30:20PM +0100, Anton Ivanov wrote:
>
> > From: Binarly Vulnerability Research <vr@binarly.io>
> >
> > fdt_get_name() in scripts/dtc/libfdt/fdt_ro.c can return a null
> > pointer. This happens when the fdt_ro_probe_() or
> > fdt_check_node_offset_() check fails, as well as when the
> > '!can_assume(LATEST) && fdt_version(fdt) < 0x10' condition is true
> > and the FDT node name doesn't contain the '/' character:
> >
> >       const char *fdt_get_name(const void *fdt, int nodeoffset, int *le=
n)
> >       {
> >               const struct fdt_node_header *nh =3D fdt_offset_ptr_(fdt,
> nodeoffset);
> >               const char *nameptr;
> >               int err;
> >
> >               if (((err =3D fdt_ro_probe_(fdt)) < 0)
> >                       || ((err =3D fdt_check_node_offset_(fdt,
> nodeoffset)) < 0))
> >                               goto fail;
> >
> >               nameptr =3D nh->name;
> >
> >               if (!can_assume(LATEST) && fdt_version(fdt) < 0x10) {
> >                       /*
> >                       * For old FDT versions, match the naming
> conventions of V16:
> >                       * give only the leaf name (after all /). The
> actual tree
> >                       * contents are loosely checked.
> >                       */
> >                       const char *leaf;
> >                       leaf =3D strrchr(nameptr, '/');
> >                       if (leaf =3D=3D NULL) {
> >                               err =3D -FDT_ERR_BADSTRUCTURE;
> >                               goto fail;
> >                       }
> >                       nameptr =3D leaf+1;
> >               }
> >
> >               if (len)
> >                       *len =3D strlen(nameptr);
> >
> >               return nameptr;
> >
> >       fail:
> >               if (len)
> >                       *len =3D err;
> >               return NULL;
> >       }
> >
> > The fdt_get_name() function is used in fdt_find_regions() in
> > boot/fdt_region.c:
> >
> >       int fdt_find_regions(const void *fdt, char * const inc[], int
> inc_count,
> >                               char * const exc_prop[], int
> exc_prop_count,
> >                               struct fdt_region region[], int
> max_regions,
> >                               char *path, int path_len, int
> add_string_tab)
> >       {
> >               int stack[FDT_MAX_DEPTH] =3D { 0 };
> >               char *end;
> >               int nextoffset =3D 0;
> >               uint32_t tag;
> >               int count =3D 0;
> >               int start =3D -1;
> >               int depth =3D -1;
> >               int want =3D 0;
> >               int base =3D fdt_off_dt_struct(fdt);
> >               bool expect_end =3D false;
> >
> >               end =3D path;
> >               *end =3D '\0';
> >               do {
> >                       const struct fdt_property *prop;
> >                       const char *name;
> >                       const char *str;
> >                       int include =3D 0;
> >                       int stop_at =3D 0;
> >                       int offset;
> >                       int len;
> >
> >                       offset =3D nextoffset;
> >                       tag =3D fdt_next_tag(fdt, offset, &nextoffset);
> >                       stop_at =3D nextoffset;
> >
> >                       /* If we see two root nodes, something is wrong *=
/
> >                       if (expect_end && tag !=3D FDT_END)
> >                               return -FDT_ERR_BADLAYOUT;
> >
> >                       switch (tag) {
> >                       case FDT_PROP:
> >                               include =3D want >=3D 2;
> >                               stop_at =3D offset;
> >                               prop =3D fdt_get_property_by_offset(fdt,
> offset, NULL);
> >                               str =3D fdt_string(fdt,
> fdt32_to_cpu(prop->nameoff));
> >                               if (!str)
> >                                       return -FDT_ERR_BADSTRUCTURE;
> >                               if (str_in_list(str, exc_prop,
> exc_prop_count))
> >                                       include =3D 0;
> >                               break;
> >
> >                       case FDT_NOP:
> >                               include =3D want >=3D 2;
> >                               stop_at =3D offset;
> >                               break;
> >
> >                       case FDT_BEGIN_NODE:
> >                               depth++;
> >                               if (depth =3D=3D FDT_MAX_DEPTH)
> >                                       return -FDT_ERR_BADSTRUCTURE;
> >                               name =3D fdt_get_name(fdt, offset, &len);
> >
> >                               /* The root node must have an empty name =
*/
> >                               if (!depth && *name)
> >                                       return -FDT_ERR_BADLAYOUT;
> >                               if (end - path + 2 + len >=3D path_len)
> >                                       return -FDT_ERR_NOSPACE;
> >                               if (end !=3D path + 1)
> >                                       *end++ =3D '/';
> >                               strcpy(end, name);
> >                               end +=3D len;
> >                               stack[depth] =3D want;
> >                               if (want =3D=3D 1)
> >                                       stop_at =3D offset;
> >                               if (str_in_list(path, inc, inc_count))
> >                                       want =3D 2;
> >                               else if (want)
> >                                       want--;
> >                               else
> >                                       stop_at =3D offset;
> >                               include =3D want;
> >                               break;
> >                       ...
> >
> > There is no check that the value returned by fdt_get_name() is not
> > null, which leads to a null pointer dereference (at *name and
> > strcpy(end, name)) and a potential stack overflow of the 'end'
> > buffer. However, if the strcpy call succeeds, the subsequent
> > 'end +=3D len' decreases the 'end' pointer, since 'len' is set to the
> > negative error code returned by fdt_get_name(). As a result, the next
> > iteration of the loop writes data to a stack location before the
> > start of the 'path' buffer, which can be used to overwrite the
> > return address of fdt_find_regions() and achieve code execution in
> > the context of the bootloader. This attack is possible when the page
> > at address 0x0 is mapped, which is common for embedded devices, so
> > the strcpy() call doesn't fail.
> >
> > The same lack of validation exists in fdt_next_region() in
> > boot/fdt_region.c, fdt_check_full() in scripts/dtc/libfdt/fdt_ro.c,
> > and display_fdt_by_regions() in tools/fdtgrep.c.
> >
> > Fix: Validate both the returned pointer and the length before use.
> >
> > Signed-off-by: Binarly Vulnerability Research <vr@binarly.io>
> > ---
> >  boot/fdt_region.c           | 4 ++++
> >  scripts/dtc/libfdt/fdt_ro.c | 2 ++
> >  tools/fdtgrep.c             | 2 ++
> >  3 files changed, 8 insertions(+)
>
> So scripts/dtc/libfdt/fdt_ro.c comes from https://github.com/dgibson/dtc
> and should be sent upstream there too (and all of scripts/dtc/ is, for
> reference for the other patches), so that we don't drop this part when
> re-syncing later via the linux kernel.
>
> Next, please rewrite the commit message to be concise and follow best
> practices and examples found throughout the codebase. This applies to
> all of the patches you posted, thanks.
>
> --
> Tom
>
