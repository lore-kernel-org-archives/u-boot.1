Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1796606A31A
	for <u-boot@archiver.kernel.org>; Sat, 24 Oct 2026 06:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=iXdVT8pS;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=SObYOc/G
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 44B8340891;
	Sat, 24 Oct 2026 06:29:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kzIcr6pGHFRY; Sat, 24 Oct 2026 06:29:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 78C2440758
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792823349;
	b=cA5elBzDzup/yLyo4ADzS6AxT/bos5NYlMPYS3D+Cod91Iq9+7gwe+IeYsl8MRz2GtVB
	 /casLZVABJW6HYKfu5kfynt9RMPkdgmbf8asQWUbH7wPHvEtljV1/tQjiw7vJKrebvX7x
	 ItY/FIijZjyNy6ERMIj5GfYZGzpnuDeOooN6n8ugkgk1ebjEVP2fXwsQDc6/xHEKdtF+n
	 TPtqFyDqhjkyxcJR5ei3EaGQUJSFNgncSHajXIm8n3Y/PmBjFfnVYIp/42/Tud+EprwII
	 PINNrdYKPnjg7dpiSllJWqIRhqJC2nnrgmYIHcYGAJp0PAqKHPh4aSW0e9zHa9xPcfA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792823349;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=h4dxGHCoBxr1dvcKCESLBA4zpT66UeWHTVNdehHBtRE=;
	b=hDQQGIXmZikxNR74N7woEpOzwFl+CsUqMZPrwETyRccQ+7zFY8iJwecf0IUQG8twp6Cp
	 jNrVDq9Vbujm4w8yszfXsVPCnDRQQM72UZNObQTHpRrq4wXT51AjOD/svN7gRhZCmpj4s
	 Jjvl/J4g6L6zzyyQPmjozUoJ7qkVuZ39XsK2SGvPR0+XCwTAJTdCeldB+jCNOtjg3kDW0
	 w2BTy9khCRXGA/zNUfx7H2FJKbyyv5lfVmAsvQgvIp45/3r6QcO7nGNq198S52Gt8wKN5
	 1MyyIC/EhP7SDCXL3jYOIvLB7BL/16OaGR4S4C/o1nB+YGHbvKgIk4lYhv6S/U8SrOA==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b="SObYOc/G";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792823349;
	bh=h4dxGHCoBxr1dvcKCESLBA4zpT66UeWHTVNdehHBtRE=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iXdVT8pSb5uz/KsRT/QTtVPWhUz7C8eBqOy7uDA1rGFafgpS7P6t90ZQZZAyJK4X1
	 iZMOvAMDkbV01PMn0do44e5ZM+8kgsf91zbOYzhDaWBg0oO4UnjSPfi1S2EdvuEchi
	 gnncZXmHN7ikvqJ9geZ2PLmv9XpG90T1IHrqU898yQjv9rCO5zXT2j3GZnlybsh5GN
	 A285PdcMHeapSwhq0/j5TUPr2s0UW5H4rpDkRSn1CAj2TE9iL9oV3n4aNG6ljX+w+0
	 mZdw2ikzbboMdpaQriQjgrALwNks9D5jqmwgSgf0aNPLjSzN0NxQmE3noPS1QPqNbt
	 1pUZJrB1eYjBg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 78C2440758;
	Sat, 24 Oct 2026 06:29:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 100F53C4
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 06:29:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 01D5340758
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 06:29:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PEEnP-TlPRyy for <u-boot@lists.u-boot-project.org>;
 Sat, 24 Oct 2026 06:29:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3C351406D0
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::52d"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792823347;
 b=Ln/VNwHPi6yJovoMbYyZZ3eT1Yw9CYxZtogK6MuzJFRujqIDwOMC/1YY+SM8E+HUTiB6
 J6sGx3KCdzSXDFd7mdgvcgIcbMqYJKjinx/2NpzB6TyjZkoWtvV4jzvoBh66iF/2Dxtag
 1k9ig+muOwwjkZsOiCUxXGozbqK7giJGh0u0X5F2Vy1XodQNDoN8Va4fnywAWzikNeu8f
 QnHZi8mhyevxC53W3haBk2H+5GWn3uFi1UlVxAdQPpZrBBv91/jBmK2yV8yzOvUSOdVbW
 Nv+RXOJV/5XzDbLl/s9TPczQ+IOTEDl/c08DRQCshY+o4QNMAt9T9Gu6bceP5Erj/ew==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792823347;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=h4dxGHCoBxr1dvcKCESLBA4zpT66UeWHTVNdehHBtRE=;
 b=ekkzCLaNCuFs2mswjjln5h9/Lrasy+bYLkQNdIenl6Hvzrm0LtvyPtylk7eKAo0B3G1G
 8IoPoOQQNksxynfvOZi9qwbzR3aUuM5mNDY7pS4v7i5kqHOSXMCjVp+iGtbHPV5wbjYSR
 6FBjzsJXNDIOBG8CnKemlTanm9BGov7A/o1Ut7JLM5elgnpJjVIeiDLcUslT4AIJSA1Hi
 EOIJlX1AbwN0npyZ8zSZQ9ZL837u+faZLfgiQXq94oMOd3lDzoJUqI/1N0gvPjv2XUJ78
 79zSh6eCFR+N/XHCCmAU3DmDASOxVcMb7kgR8tUhY8tmiArOMbsY1JUunFR7qRo2jpw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b="SObYOc/G"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::52d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::52d; helo=mail-pg1-x52d.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=SObYOc/G
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com
 [IPv6:2607:f8b0:4864:20::52d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3C351406D0
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 06:29:06 +0000 (UTC)
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-cd6a7b62ce8so535863a12.0
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 23:29:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792823346; cv=none;
 d=google.com; s=arc-20260327;
 b=WEL5onoGnPlqU/KpmjrzytRF288WhdBz62Pej7efI5zZZ5GY51yCYR19i9YEoRY7OE
 J5ydloP2nr9b8unZP7/tOCBW2r4+0NhmDdnSqlm9KTnH+TMOSw6h2dAvwmekyclGlb1B
 uO0JO8cZ7eE3Pz1jriEgXyHHlnLQW+SIfDyDIKT1FK4w9MErkFqYlQcQ/iZTRrN7+awT
 1goklSTTDB0bEHvKYUe0cBpMzbpRpxuHb0JiqXN0yFA5Nlevv4u0Ne9YWKVwxQ9m73fl
 Rt/9PPqDNuJ3j5PTMrfwH8cF/EvhVOdM8s0nIxdNQAH2d7kFb6aEq6I0WxzKMpMwGtGW
 yOFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=h4dxGHCoBxr1dvcKCESLBA4zpT66UeWHTVNdehHBtRE=;
 fh=sqFYa5HhsXMHk6lK1uJ95N3qZeoUfXxEDP8vyXdmNZo=;
 b=in0ZetsUOXTs6NmtzHPh/Z3sB9hxoAEF/gYcwvnRTyv1uU77T8x8cWKw9du+lHXQY9
 NqHzBQPCAF2FoU7RxDkXJ4PFqTqhocsnqDDqF5JYUbRVHVOqDw2oFdq63G7413BV1FtF
 YVZQbRXDdnO1rfat15VLpLAgJuX/sluea1vZwzileMIDEA99u6BO7csFp1f9oViV4dIq
 K62als+g3kfbIMYDVef4DvJDo7PIo0X2BZvUA0+HP3CzreV2L8Uy+iRsvThbGXj+sbRq
 7BtTDUYM23DBub67ambm7tOkQhjucINUbR65tmBS17qAm+k3BkYvqb4uBwwJgGo7mN6t
 VV8Q==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792823346; x=1793428146;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=h4dxGHCoBxr1dvcKCESLBA4zpT66UeWHTVNdehHBtRE=;
 b=SObYOc/Gcllnhuw1MZ/L0NRFUgGiZg6KLk6KP3szyMn/4fYfgDf/IpXjsLvJIk2V0c
 zev1j0YkC32VDv2yY8gj1ZxO0bW9U7aFNl/9SGiT5I+HGViuSSisGYUStgMel+AhwSjU
 Wol0TakwR/sLyrRsPWm86iGNuFz7HkEhh4RPc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792823346; x=1793428146;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=h4dxGHCoBxr1dvcKCESLBA4zpT66UeWHTVNdehHBtRE=;
 b=R9Fl59KfJfNUjVnc4OqGYaQpXjm7i3q2sQy/vrjti67MJPCrPugCTa98hS4Q6xd1hr
 ery9bmWsyqedSZbqW71HrlHDgSq6ZG52j4A7g4o0c0aIsBtSh+rOisMljIsz8YBHOe3f
 0sA/o/rgrqCdjpnk/6Km1zsyB3P1+QEWfGgnAFviKrIWbcNQlubPpeH91shuNmkquQkr
 SrREvoaUGgo+PIO4aVh4UtZ1IlXEixHnQlI4PDyWzjEjHMEjfKMHwn/x9Em0wzARqrbP
 VCnVjcorEqgPlIhxlk+zomkQhdANNAvijwlZvnxsZ3LWmATV8fcrEM0xEmQaa5lfMhCF
 aEjA==
X-Gm-Message-State: AFq9FYIkjylDl3f91qoRg0FrbE12pEtiyRBFt5okRc3/Ru/xspOSLtBb
 rMIA4amhURDYhR1dS8vGdUGZieDpwA1Ve954haXm7Ekbd0Ttu6qCuZpg2y9NrlVbBAAc27gRP2Y
 p4yym+W03gXHQ5X8GZAkVMp5JcWlEQnJU+xuQv8WY
X-Gm-Gg: AYBFou2chxJzhpIh9yPk2ZVmFnXtSpYUz5j4nWcbuDuxb3E4o8SnERKGeOIp9ffhPAy
 c4dIpf5ms4ex7wxyfHFn67KdSS7m7/x/xTqnod3RYpcGJxUo0/H/1G0Nv5OE7v1NH1jvJ7tAF1U
 mGq+ntGIx2441AsDr7v5i8+1ZVEdV7ciQnzfxQe7NHBvX7mI8f6XFIBcwVCnw6Fm00mIYPDZ8Rv
 N3rjrkC9Sz1P8WhBOUX0ot7z9Wu0+s2KX6h+v7bsfy7rbWojjsnlIHZtmKBiDHWEXtRmJdaU/Vm
 SRXjmSgFZg30UiUunGFsjN0FgEfdlovEgrewLoha5xEXiVr4HXwrVTuMvx9bMKJecgDwiaqc+oT
 6J/S400AjBKNFBb+NeIQP9jB1jrgbZRUpzWc=
X-Received: by 2002:a17:90a:da85:b0:3ab:c370:3684 with SMTP id
 98e67ed59e1d1-3adead45d61mr1060588a91.30.1792823346416; Fri, 23 Oct 2026
 23:29:06 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 Oct 2026 23:29:02 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 Oct 2026 11:56:29 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <f47970b1-cd95-41f0-a36c-cd938c89d3d1@gmail.com>
References: <2646c589-e23d-460b-92d6-cab299fc4f56@gmail.com>
 <f47970b1-cd95-41f0-a36c-cd938c89d3d1@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 23 Oct 2026 23:29:01 -0700
X-Gm-Features: AclHuK-3ghjmklYkIgwXssZEtaayxtfs6T6RD_47UcE7IBsYPItZ4B0luPujpEg
Message-ID: <CAFLszTi+juCmRtYy6uP4cP_1M-X8=6fcKmKi62c6vqokmN2kQw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] image-fit-sig: bind a required image key to its
 own verification
To: anon87111@gmail.com
Cc: u-boot@lists.u-boot-project.org, trini@konsulko.com, sjg@chromium.org, 
 0xiviel@gmail.com, me@ziyao.cc
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
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-22T18:38:39, anon87111 <anon87111@gmail.com> wrote:
> image-fit-sig: bind a required image key to its own verification
>
> fit_image_verify_required_sigs() passes each required key's node offset to
> fit_image_verify_sig() as key_offset. That function never uses it: it calls
> fit_image_check_sig() with required_keynode hardcoded to -1, which both
> boot/image-fit-sig.c and include/image.h document as "any signature will
> do". rsa_verify() then tries the key named by the FIT's own key-name-hint
> and falls through to "try each of the keys in turn", so every required-key
> iteration is satisfied by any signature that verifies under any key in the
> control FDT.
>
> With two or more keys marked required = "image", one signature from any one
> of them satisfies the whole policy and the others contribute nothing.
> doc/usage/fit/signature.rst says of "required": "this indicates that the
> key must be verified for the image / configuration to be considered valid."
>
> The configuration path is correct: fit_config_verify_key() passes
> key_offset through to fit_config_check_sig().
>
> On sandbox, with key-dev and key-prod both required = "image" and a FIT
> carrying only a dev signature:
>
>   Verifying Hash Integrity ... sha256,rsa2048:dev+ sha256,rsa2048:dev+ OK
>   sandbox: continuing, as we cannot run Linux
>
> The doubled "dev+" is one signature satisfying both iterations, including
> the one for key-prod. The same case against the configuration gate refuses:
>
>   Verifying Hash Integrity ... sha256,rsa2048:dev+ sha256,rsa2048:dev-  error!
>   Failed to verify required signature 'key-prod'
>
> Nothing exercises this path: there is no required = "image" anywhere in the
> tree, and test_required_key() builds only sign-configs-* fixtures.
>
> Fixes: 56518e71041f ("image: Support signing of images")
> Signed-off-by: anon87111 <anon87111@gmail.com>
>
>  boot/image-fit-sig.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
