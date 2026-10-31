Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E672606A31A
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 08:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=OZmPCbjN;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=V/ldcURx
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id ED44B40B47;
	Sat, 31 Oct 2026 08:53:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jpkwowJVsyHI; Sat, 31 Oct 2026 08:53:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2045140B3E
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793436835;
	b=lm6QxCuLhtIDPG9gvfZGX3azxVIbEqPzKT0GTdGPKb4gsf87WsbdqZveFqMy5mygGM6C
	 BfvMZKQAyEx8D/WI+MgGOuFJbGn0JimlgeH06q7Q1TCDcXbwfZIAO/kwHH45nM3CwdWpo
	 5fGbe8DxgaWZRk/J+X8rBQnLEU+wsAuGloYlxGEH1EWwyjwsn+YiTRw6v4DHzIIDjqg+Z
	 9a3KRLxmjyV8GMBbHary+PWefS1yQzgQPMolK4iRtcSgRrDcTcE1u79VVgk9jTYxQDT6A
	 gFgM3994EGeOzZxhaBpi3qVZ2IFuyEgmvIUXiPZF5Ik8Rtriu4kGUfes3xY+lnLtunw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793436835;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=YiMM4GNnyUK3Tj2Hpt/I1K/b1Uz9N/y576cM3pNv99E=;
	b=TymmNCKQrOmQ54aXLnFRIfx7K4OjjGWl2WruqzZGmijBXWlk5wahb+8o97i7vn7dsMpg
	 s4ygpoGSsrnGzGzAl6qXCzLKFrvw2UdqhHGFHrPXVuQGpP83JJCpynqdYbDIW8K3K06hW
	 1tyhvVTS7R6b2VYTljVC5mFoIScMJPzYsbHjlUOXAjujSK2PNINPKdne/qNfAWXoT9YHQ
	 7p1Cv9mvw4cwsuVU4TX/80k0Uqxh0I6YjhK+pOE1+b6oPTtBfovCTOI+GVmt4j9mHyvM4
	 BwRHipQkbknHfdp2Mwr8dyHeUq1SWNmVs98j5GhagV9IUbVNYDMMMrrHKLGVXLfzCaw==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793436835;
	bh=YiMM4GNnyUK3Tj2Hpt/I1K/b1Uz9N/y576cM3pNv99E=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OZmPCbjNFibyhxGqNhNxABJNOU8WH3wEqzsl+2FQGRmfGOHiBvhhKFH0LfU55nA7Y
	 tPLcQ7VqfPI5R8jPZydNCe1z67Wd1tPeuRd08ieVDJKnP0ZpX+38hmFZnYlH8WeFTF
	 Q8zLH+ohFMoMlRKKgB/eVfLrPNYH4dlZl2cF0bY9RKAUl2d/ChXXsapA2UsjgUuhEj
	 hy60kch6RgPxPULBtFW++0qf6iFwmpIJKqYgWqLKAMshOhwBLNncmTTRA+pyW/sFtE
	 Ogk2eJcHkmu3cTIgt0vgD65O3d3oU27T/Kb1JxEyEXBvHs1dwCng0b1w4KazIa+ZW/
	 mycNhsJgbatwg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2045140B3E;
	Sat, 31 Oct 2026 08:53:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 5B70B380
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 08:53:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4D3B9400B4
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 08:53:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Xp6eFU9t26J0 for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 08:53:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 9126E40057
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::529"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793436831;
 b=DWMpTdcdvJC8EbnWDgEwfVfptW++kh2FYPyr7XoSe7On9MXTQFVD9UnZ1TItrHPwKsNg
 GTw4GejyxeCod961xV95KBXBVTeubjOpRw1B+yThY3Mf1uHkd1d2HUTM7VAsYyi/6VFXn
 SfAzH1e7mRE/PWRnlZCxJeV5gEW1iwGLYeg9HSEUD6rOrUYt80FSf4N+A7CXoJcUP2dIj
 sl4zNkCebqO8laC1jbD9WMQfUpMwRHQslDicqO7hZcx+seoXpsIvbPMs/tCz9CmXsA4p+
 Urcv6GhIBoLyfCoTB+GfFF7V0hzqTUBPMQw3rCWWW07nhts7vdmlsD/dNQhJ2etOUWw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793436831;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=YiMM4GNnyUK3Tj2Hpt/I1K/b1Uz9N/y576cM3pNv99E=;
 b=YSZgdb8gK8xaEllb94Pg86naeIMVnncrX1cE+v22yMLt8hAuvdrH+6TXvaODG+eif+AZ
 XkZ2Ha1XTdHGFgzcl9PD5aFkJAceCEKM1L3lwPN4jNPPLtQiBMewSeu/GoUD+Vmv3O0jA
 96BK34ZyQ+Jf2UvVPZJsIFfVvZ4kidzWao7G1lyhrzSpjGb8UhrFNiQRRX8Y1FN9syWgk
 rDj+hD9fjPcTdOGcP0i5jR1xODNkDH4qMq0H1dj/Ih0fDu4XhaY0l+jJM7NDcs64g3HcP
 P0BVkqKSy9xRRyI3kYt+wHoUgcY39WmP2cZG//+4K1zZuHxU7pgOxMYVh0f+kweBKCA==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b="V/ldcURx"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::529"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::529; helo=mail-pg1-x529.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=V/ldcURx
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com
 [IPv6:2607:f8b0:4864:20::529])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9126E40057
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 08:53:50 +0000 (UTC)
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-cc147d86bebso996686a12.0
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 01:53:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793436830; cv=none;
 d=google.com; s=arc-20260327;
 b=oeX2hGqzDc4cYNueXtLMS6N+85EYGroF+wObRPKUhM5alUZVIvy0l3VZ4spqwaJ5NX
 zh3K9DSDaF7gbK6YXmXw9h5/U/HOeIAG80SuSyMp9YOJcaiHP+TT2uzMhMCEKN/l1a2T
 3vY9ho7Ohh6EtP1x63rt+xsfsClofyvgHWLEo44RLhrL4s1g12wG6Bo4m4oOH21Hb7AA
 PBIEiFQuL2a1I+U0nULEmEAO3y9DnkwRasPnYyNqq4aNI6GrUlfU1k+Hm3kBAgLwHIwi
 PeLFtPWSDRphrjkNb5yY7mLhKNLN5M26kSrv6AjN1Yyy7HUneN3XHubk9Mk+gSEWtUve
 vGqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=YiMM4GNnyUK3Tj2Hpt/I1K/b1Uz9N/y576cM3pNv99E=;
 fh=14V5QZ2qJWOmkUpIay8f5wLH4+hU5ubxJ+YNB0Krams=;
 b=KWKwMHjng59/y/GQVDmqXrvlGdjOjjfchaD6WIye/dypJzdGO0JPobvmuV1Dz1Fiy9
 +aBb4xlfhU7SGgTVVeriiWpr67RQ7ZYO+9YZKxc8ZfvlR7f/831J+gE6AskJoYJ08+3T
 4kjHP9L3zdnEoAVZli6LFmO1KSMxhIemWSFeoNSdiKFWUboXLFnZItDOLXvb6Sh6iM5k
 R50X4spakl9/q3UI8s27AGSsI7s/6dM9lwMRUSzKk6K4ELqKGz1Co9g2VMY74g/2cVxn
 D419DyD5pt46a3SVcDWvYtbkYs476Z+JeaUwb4lhfjgxZkMLSIEC/byVQ1K/Do7xP/hN
 cysA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793436830; x=1794041630;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=YiMM4GNnyUK3Tj2Hpt/I1K/b1Uz9N/y576cM3pNv99E=;
 b=V/ldcURxUvgr9OrjR610WvGbD///Ozc3yoNX6zjsJuz9Jm9NApSghI+XKiqaaFVufF
 IXRjyFaJJokZ6kOVjPEChtXyvTZzP6Es4FEqdAcn8d5JbcNHUDPs21ufukt/EtGGv4N/
 OTHch3jGl/0ta+jn22Rcg29ZT+zOFawGePj2E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793436830; x=1794041630;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=YiMM4GNnyUK3Tj2Hpt/I1K/b1Uz9N/y576cM3pNv99E=;
 b=eJAZmgHvy1scfrDFv0m7Da05kUo/B2I8ouDm8Ny7hOrfHgHGF0/KaWdDfMguKSzJgz
 y1ZMLLqoX4HqC7j6WK5u+UhUnwC6GUh3cGp7q4jkbVm2q7Y52pO7mjfJaJCkTEK/WlE+
 dg74EVm8432R2KO6/WGGEbRjXgJ9JdozZxPrhqisIhl7hi4+4ibSwIBEIzSpY2gzrtdE
 +LKhbZyMixFSSFlY0mGg9iySowU9Ulg55aJE1pnWwUxf3FbmEHRXYlvcGk4fdSjFH9DV
 yqz2FZHA/xVl0Spj2QDDIXIP2JcWFeq84ORU8+junOdGRj5na9MsK/i0MqlTRYuSTl10
 /Umw==
X-Gm-Message-State: AFq9FYJDeOYoSaooXhhstpEI1QJsIkS/Lv8OPV7aN1KH1jH9XHcid9qh
 SvSGsAkdLOwX0ghP0isJGv3UF3JS9uh9rsgmCGIQhq8i99KzLOvz/5wDveGuhs4WCQ6HqatDUbS
 4nR6S+FwddtQdSgzF7AfHN7w+Cergdn1UkCh8ul+X
X-Gm-Gg: AYBFou0JdmozHidbQqWa0SyMGUpM/CA2ZQGb+UfcCzJPXnIAGzVlYuxyZw1ymT8h0DD
 H9S/mZcF14ja9gcZb9/HwbIoxFYvc/iPljs5bFDOlIVvDFjsFF7W1n9B7P3paqdKx2WrLmKNQ9f
 DAOfPjwrw21GOoz3HEkJzOAeldFnkX2vOJN5RGgpfV091sxkR6oZwfnNAhFHTOVJHQmIy68AOSX
 viLRQA/W2LG2cj79YrjJo+GfrQg/HGVybZNgzazKqflS9jXUt7WClP2VfKW9kJSpAvPOuAMdKZ4
 J4JUdCv91FjZVJbhusV9Ub7MB9jyKUx5NpWmMJ/wjJcY0m8F+b+G2ckPfiI8SwQliJqqbSh+LFL
 pYIZjBz9w1XEMcQpdXiyQRKVDxpyW09t9kYZdZ9m5KXfZxDKsiDl+rymikrZyZDxXE5XMeSjJ
X-Received: by 2002:a17:90a:e7c5:b0:3a8:337d:228a with SMTP id
 98e67ed59e1d1-3ae89559886mr2598938a91.6.1793436830109; Sat, 31 Oct 2026
 01:53:50 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 01:53:45 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 03:46:49 -0400
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261028103102.414657-7-ayoub.zaki@embetrix.com>
References: <20261028103102.414657-1-ayoub.zaki@embetrix.com>
 <20261028103102.414657-7-ayoub.zaki@embetrix.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 31 Oct 2026 01:53:45 -0700
X-Gm-Features: AclHuK-RZdAKkEtJWqVo8Wroe-Dj4Me9iRDakXu7Hiad3yl5gVcXYlLAkTAb26s
Message-ID: <CAFLszThp726MRAAGENYacpu3kXxmsiu5rEjGiZ3P3DpgF8e10Q@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] test: fit: Cover private key filename fallbacks
To: ayoub.zaki@embetrix.com
Cc: u-boot@lists.u-boot-project.org, sjg@chromium.org, 
 Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Marek Vasut <marek.vasut@mailbox.org>
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Ayoub,

On 2026-10-28T10:31:01+11:00, Ayoub Zaki <ayoub.zaki@embetrix.com> wrote:
> test: fit: Cover private key filename fallbacks
>
> Test RSA and ECDSA signing with each suffix alone. Test both suffixes
> with different keys to check which key is selected. Verify each image
> signature against the expected public key.
>
> Check that an invalid or unreadable preferred key prevents fallback.
> Check that an unreadable fallback key makes mkimage fail. Check that
> missing-key errors name both attempted paths.
>
> Check that explicit -G paths do not fall back to another suffix.
> Missing keys remain optional.
>
> Signed-off-by: Ayoub Zaki <ayoub.zaki@embetrix.com>
>
>  test/py/tests/test_fit_key_fallback.py | 121 +++++++++++++++++++++++++++++++++
>  1 file changed, 121 insertions(+)

> diff --git a/test/py/tests/test_fit_key_fallback.py b/test/py/tests/test_fit_key_fallback.py
> @@ -0,0 +1,121 @@
> +    utils.run_and_log(ubman, [mkimage, '-D', f'-I dts -O dtb -i {tmp_path}',
> +                             '-f', str(datadir / 'sign-images-sha256.its'),
> +                             fit])
> +    nodes = ['/images/kernel', '/images/fdt-1']
> +    for node in nodes:
> +        utils.run_and_log(ubman, ['fdtput', '-ts', fit, f'{node}/signature',
> +                                 'algo', f'sha256,{algo}'])

One thing I'd like to check: 'sign-images-sha256.its' no longer
exists. Commit a6351dbef18 ("test: py: vboot: prepare integration test
for ecdsa") renames it to 'sign-images-sha256-rsa2048.its' and adds
'sign-images-sha256-ecdsa256.its' alongside it, so every case should
fail at this step. Did this pass for you on a tree from before that
rename? Please can you rebase and use the per-algorithm ITS files,
e.g. f'sign-images-sha256-{algo}.its' ? Then you can drop the fdtput
loop and the fdtput requiredtool marker.

> diff --git a/test/py/tests/test_fit_key_fallback.py b/test/py/tests/test_fit_key_fallback.py
> @@ -0,0 +1,121 @@
> +    if case in ('preferred', 'both', 'unreadable'):
> +        write_key(preferred, key)
> +    if case == 'both':
> +        write_key(fallback, other_key)
> +    elif case != 'preferred' and case != 'missing':
> +        write_key(fallback, key)
> +    if case in ('invalid', 'explicit'):
> +        preferred.write_text('Not a PEM private key\n')

This is hard to follow: to know what is on disk for a given case you
have to work through three overlapping conditions, and 'invalid'
writes the preferred file only after the fallback one. The checks at
the end have the same problem. It would be worth making the
parametrisation a table, with one tuple per case giving the preferred
file contents, the fallback file contents, whether to use -G and the
expected result, so the body has no case-name checks at all. What do
you think?

> diff --git a/test/py/tests/test_fit_key_fallback.py b/test/py/tests/test_fit_key_fallback.py
> @@ -0,0 +1,121 @@
> +    if case == 'explicit':
> +        key_args = ['-G', str(fallback)]

The commit message says this checks 'that explicit -G paths do not
fall back to another suffix', but the path given to -G here is the
valid key, so a fallback would never be triggered. It is
'explicit-missing' that actually tests no-fallback; this one just
shows that -G uses the file it is given, even when the other suffix
holds an invalid key. Perhaps reword the commit message to match?

Regards,
Simon
