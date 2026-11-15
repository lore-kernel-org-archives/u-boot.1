Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5699D606A323
	for <u-boot@archiver.kernel.org>; Sun, 15 Nov 2026 04:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=WgUkaI2A;
	dkim=pass (4096-bit key, unprotected) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=R9Qk1PDm
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 22BE4606C4;
	Sun, 15 Nov 2026 04:24:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id i7gUAOm9aP8A; Sun, 15 Nov 2026 04:24:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E4DA160623
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794716645;
	b=RfSkuTogUchx63LexRq2k+8N8yDfuoK4FoIedVdPDajrh3eK2DTWGCBUcJcq8rTKi7lv
	 Uf4qTVHb0u549lTtxSv4iOIwL2HudyB2P4M8OHMTF6pvyehwwfNRqZxdjM2zDyZagv9pN
	 S+35vyk/A0SFfTzXFadbV5q7a8Tii4+I9lPcd72ahvUegHDoj7tCRpRUxT9N7VHAkHSzs
	 nJtEWgiLTEV/zwDA8jfSuCbpBMf/NEoUXRkgklJyECUFtmZkuIEoBUg936qwJReoZnrgn
	 fYkMKN4P54rEJSRe5FwTvi9CP4UFc28vXl5KpuUf2iH7vI3hIidG1oUFM8wRsaZph5w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794716645;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=hroz81vLEvTa3p5ywtlUHFWuyEQIHNEmPM4j9pMLXZ4=;
	b=l8yPCrI2VvKrRsR1YeSBQHVCzpOWn0DsMaXh4viVQ4cQqxA4+eNe5tNuYEt243+LXKxp
	 y1ZZO+/Ke0JTfTFsCZS06ZrjaPY0rVmGLg61P3nUuNjN/qV8k7DTTOchYou30Z7S2f4f2
	 OvuKmjphVOkJ+PFYAlyeXJF2eV0TRkkNycBbe+RDEap6hORxoN1pYFqS5cyMdaO9wRjXH
	 9UQ3IowT6Ikg/g+LuehTYCp8G+aSksK28bUfDckkKSehvzmukiKDSQIMwW8cnQR7nCtPr
	 8qo3RNLh9QryU3cNKKl4oY2MDkRIJTl4bDz9Z3VO/Yl478fiVwkmFvzISwMF/dZRvmQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794716645;
	bh=hroz81vLEvTa3p5ywtlUHFWuyEQIHNEmPM4j9pMLXZ4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WgUkaI2Ak3EK2nmIrFjb9lkwxyz4i2yIdL0N1SWS7Ac0EFlWkNgv0dTNL2Ppsi6xP
	 155WLkhT+q0X/wtHiEPmcJ6hEQZm6Hg1vGQzc5oHUhoYHEql+wxRDsdQaLkUrFbSe9
	 55csNQP29QNDLJGzzqbjqtaRGIdU0hCyc0L67UuDdIqbJFQlMW7PA60hRKknTUMwIf
	 6sxbAJGyrKfBDdqLzZ6E0OCTBCYUzX1riebqVha+2aho5jl/G7/0/tnxelADggLnyO
	 c8ton9VZa1MhSa6ZqYStmC1Pg8257y81WO7Yuu0jGe+k4Lc5ijXHLV2QUmUACSMANS
	 AIlU3di0jyOQA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E4DA160623;
	Sun, 15 Nov 2026 04:24:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 489871A6
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 02:18:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2632E40079
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 02:18:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OxKk3oWwMvxu for <u-boot@lists.u-boot-project.org>;
 Sun, 15 Nov 2026 02:18:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 5612140068
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=185.125.188.122
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.122;
 helo=smtp-relay-internal-0.canonical.com;
 envelope-from=aristo.chen@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=R9Qk1PDm
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5612140068
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 02:18:04 +0000 (UTC)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 016F13F030
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 02:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1794709082;
 bh=hroz81vLEvTa3p5ywtlUHFWuyEQIHNEmPM4j9pMLXZ4=;
 h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
 To:Cc:Content-Type;
 b=R9Qk1PDmD83wbqaCYMu/xoBJmL87kOU21AdwUdrg6ruT2LCagwZikMfct9Q8XsLeE
 Nw/ZsgctufZkBPi3UH1/uJQUtmDvRk89FeBAzOjLEcRb8865AYN8NjTheJlwDDugcc
 +Orkh69oTD6gltOvoV7oTZsyS3qwAMHA4hcX9rGqhlGhlkasdc9pKjqSALf+TnYPMm
 Cj2VxDyYWrkExVjNCQlxfFWNrnWmOZ2Pq/KqugegfWbCOoMbdJ+aAAl1maum8+9ou2
 5MIV8yiT7hZ2Ccj+tDfzqSw3VI41i5ePDGnAk1Onll2qT//RT4JYP/yeOAvhdykXkG
 MdKSFN8DyqmpRVD1Y7QRWYPuvh+o1OTtz1lCVBblE2/h6kV2F7cXzmx+0Sfw73REXX
 HniBzbIpcwpxnb/VvrMSQUHj/RgKRbGnJbVH8VsF0CA80OfvUClrzoMOgAJWrcLNhl
 N1nF8nI2IOAnney3WhiWGp9Lyt12ay5bZo9u911KTc9KjC23bdN30CVw+Bvv6YtOTM
 QL6V7nAdZoQW5HZtu4Uqdh1rwycs6iYL+vgxxFNscuRwhIHFDKjV8myyqMRP2L6u1G
 Kv8v0AWsW/Tm4yshA+vDEvWiSkY06FTwQ+XKlSkhR4Xyc7KxZBHsUkQHzOTcns/WaM
 N6oZMCfWy5QqAEfLLpH8+Ie4=
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-6b763d2c2cdso1960232a12.2
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 18:18:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794709081; x=1795313881;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hroz81vLEvTa3p5ywtlUHFWuyEQIHNEmPM4j9pMLXZ4=;
 b=FgQWHOPlTTU1qG6KqQHgEAkxFAxvj+4+kXYU15SMMKs9hAE2/Hedi85t/TjYyw1ppj
 ZH4iyqX1yw/boJQfAcD9jw6zQy3DyOxUcfpJLDBp0h7KWNw5rmxj0qCWsPaN/17n0738
 YnofE/ovJDbf9zl6Kd1aR4R3knbiLE/YT9cxeJ2SaLZ+2tdElaP6bExJSfKmHMAq0eNl
 UUP2fqGnObtKH5FYMxSXV+thZP7hzI4qE50Z9T8XPirZZczEXtPhAmuWGBAktN0ioXT/
 GFynd0j+eo/NeIZ6S0AM8D0MJ7cUJyIt/4/bYLo85EW3u6oAHAvAvufEl+v9GKdm8Q36
 N3sw==
X-Gm-Message-State: APuU4Z819IUYuZONxlH8zw9erZFqbIMdSZQ7dPMRLxK3MY5n7OpviPim
 rcsp0lTUJ20l3czsXXBW8QFVhdyOuNbDqFVL9S05CJp0nsSJND7+CG7zBFvxtdvR0FWT//KGiyG
 0XnaDsQuyFf8YvnsvhXCqsZo+ogsI4HLMM0c9/y/350CY5EGKZBk7iBHzieuNrolS4p07RkoojA
 YO8F/e2fGlqzcP2LQVFYI0kZUXie7pzHyyYSK76FBZG3cmVVU2LGt16rDc8HtF
X-Gm-Gg: AYBFou1/pug1mV1/Mnx7CXQMEhPxkoeiH92aJH0qYrZZqidVP/nAf0vRJBkic0PZ7aJ
 1NGbSMrINuuBx4bjkIZ6i56Bo3YKJbiEcUy3qQF100NP0w6v3WT7Unh8kYStvIrOqGBVSvRSrJl
 q2Yh09XGtskJ2ueCr/85P/cfrSdqZkopCU4z+7kX/LSnQB2+PiefM/qbZL
X-Received: by 2002:a05:6402:2804:b0:6b7:245a:a509 with SMTP id
 4fb4d7f45d1cf-6b7c0d166cfmr4295973a12.40.1794709081624; 
 Sat, 14 Nov 2026 18:18:01 -0800 (PST)
X-Received: by 2002:a05:6402:2804:b0:6b7:245a:a509 with SMTP id
 4fb4d7f45d1cf-6b7c0d166cfmr4295967a12.40.1794709081300; Sat, 14 Nov 2026
 18:18:01 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261109221650.GA3741582@bill-the-cat>
In-Reply-To: <20261109221650.GA3741582@bill-the-cat>
From: Aristo Chen <aristo.chen@canonical.com>
Date: Sun, 15 Nov 2026 10:17:49 +0800
X-Gm-Features: AclHuK8z5o0yOn8u_5oeVOgb4xnDgNqscm9-qJn9WP4diVeql0jwETc_5dXMBaU
Message-ID: <CAA=k7=kgnH8EPpHpdKhqF98ykJG6QdaeYD53sBEdap5OudZwLw@mail.gmail.com>
Subject: Re: New Defects reported by Coverity Scan for Das U-Boot
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Linus Walleij <linusw@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sun, 15 Nov 2026 04:24:04 +0000
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
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Tom,

On Tue, Nov 10, 2026 at 6:16=E2=80=AFAM Tom Rini <trini@konsulko.com> wrote=
:
>
> Here's the latest report.
>
> ---------- Forwarded message ---------
> From: <scan-admin@coverity.com>
> Date: Mon, Nov 9, 2026 at 4:13=E2=80=AFPM
> Subject: New Defects reported by Coverity Scan for Das U-Boot
> To: <tom.rini@gmail.com>
>
>
> Hi,
>
> Please find the latest report on new defect(s) introduced to *Das U-Boot*
> found with Coverity Scan.
>
>    - *New Defects Found:* 2
>    - 2 defect(s), reported by Coverity Scan earlier, were marked fixed in
>    the recent build analyzed by Coverity Scan.
>    - *Defects Shown:* Showing 2 of 2 defect(s)
>
> Defect Details
>
> ** CID 661899:       Insecure data handling  (TAINTED_SCALAR)
>
>
> _________________________________________________________________________=
____________________
> *** CID 661899:         Insecure data handling  (TAINTED_SCALAR)
> /boot/image-fit.c: 2244             in fit_image_load_storage()
> 2238            fit_image_get_comp(fit, noffset, &img_comp);
> 2239
> 2240            if (img_comp =3D=3D IH_COMP_NONE && load_op !=3D FIT_LOAD=
_IGNORED &&
> 2241                !fit_image_get_load(fit, noffset, &img_load)) {
> 2242                    dst =3D map_sysmem(img_load, data_sz);
> 2243
> >>>     CID 661899:         Insecure data handling  (TAINTED_SCALAR)
> >>>     Passing tainted expression "data_sz" to "imagemap_map_to", which =
uses it as an offset.
> 2244                    mapped =3D imagemap_map_to(images->imagemap, data=
_off, data_sz,
> 2245                                             dst);
> 2246                    unmap_sysmem(dst);
> 2247            } else {
> 2248                    mapped =3D imagemap_map(images->imagemap, data_of=
f, data_sz);
> 2249            }
>
> ** CID 661898:       Insecure data handling  (TAINTED_SCALAR)
> /drivers/pinctrl/pinctrl-nomadik.c: 171           in nmk_pinctrl_set_stat=
e()
>
>
> _________________________________________________________________________=
____________________
> *** CID 661898:         Insecure data handling  (TAINTED_SCALAR)
> /drivers/pinctrl/pinctrl-nomadik.c: 171             in nmk_pinctrl_set_st=
ate()
> 165                             continue;
> 166
> 167                     cfg =3D ofnode_parse_phandle(node, "ste,config", =
0);
> 168                     if (!ofnode_valid(cfg))
> 169                             cfg =3D node;
> 170
> >>>     CID 661898:         Insecure data handling  (TAINTED_SCALAR)
> >>>     Using tainted variable "count" as a loop boundary.
> 171                     for (i =3D 0; i < count; i++) {
> 172                             const char *name;
> 173                             unsigned int pin;
> 174
> 175                             ret =3D ofnode_read_string_index(node, "p=
ins", i, &name);
> 176                             if (ret)
>
>

I had a look at both.

CID 661899 (image-fit.c) is real, and it is a write rather than just a
read. In fit_image_load_storage() data_sz comes from the sub-image's
data-size property. For an uncompressed image with a load address that
the caller asks to have loaded (a ramdisk or a loadable, for example,
but not the kernel, which bootm moves later) it is used as the length of
a read straight into that address:

dst =3D map_sysmem(img_load, data_sz);
mapped =3D imagemap_map_to(imagemap, data_off, data_sz, dst);

Two things make that exploitable on a signed FIT:

 - data-size is in exc_prop[] in boot/image-fit-sig.c, so it is not
   covered by the configuration signature. The value can be enlarged
   without invalidating the signature.

 - On the imagemap storage path the sub-image is streamed to its load
   address here, and fit_image_load() only runs fit_image_select() (the
   data hash) afterwards. So the copy sized by the untrusted data-size
   lands in RAM before the hash is checked.

Reproduced on sandbox with a signed FIT (sha256,rsa2048) read through an
imagemap over a disk partition. With the ramdisk data-size bumped from
0x1000 to 0x3000, the configuration signature still verifies OK, 0x3000
bytes are written to the ramdisk load address, and only then does the
data hash fail and bootm abort. The 0x2000 bytes past the signed image
are already overwritten with whatever follows the FIT on storage; the
honest image leaves that memory untouched. load and entry are signed, so
the base address cannot be moved on a signed FIT, but the overflow past
the intended image (bounded only by the 32-bit data-size and the end of
the partition) is controlled.

No in-tree production caller supplies a non-NULL imagemap yet: bootm
propagates one from struct bootm_info, but imagemap_create() is only
reached from the unit tests, and the bootmeth_openwrt consumer that
would populate it, posted as an RFC in February, has not been merged.
The code is in the tree, though.

The imagemap follow-up series that just landed ("imagemap: structural and
cosmetic review follow-ups") refactors this function and adds the
data-offset range check, which is good, but it does not bound data-size,
so CID 661899 survives it. Daniel's series that is on the list now
("imagemap: Fix boot errors and resource lifetimes") does not touch this
function either.

I will send a fix as a separate series,

CID 661898 (pinctrl-nomadik.c) is a false positive. count is
ofnode_read_string_count() on the "pins" property of each child of the
selected pinctrl config node, used as the loop bound, but each iteration
reads pins[i] with ofnode_read_string_index() and returns on the first
failure, so an out-of-range index is never dereferenced whatever count
is. The device tree here is the platform's own description, not external
input.

Best regards,
Aristo Chen

>
> View Defects in Coverity Scan
> <https://scan.coverity.com/projects/das-u-boot?tab=3Doverview>
>
> Best regards,
>
> The Coverity Scan Admin Team
>
> ----- End forwarded message -----
>
> --
> Tom
