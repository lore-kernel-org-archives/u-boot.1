Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CFD7CA5FD4
	for <u-boot@archiver.kernel.org>; Thu,  1 Oct 2026 16:07:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5579D607F2;
	Thu,  1 Oct 2026 16:07:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JfBRYTjnNDSA; Thu,  1 Oct 2026 16:07:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 6C6DE60B26
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790870837;
	b=FOMR5Kip9WUg/bLHIm1GAQHJGN//5KQ37cIrY0s3q+tkzWsyMzFPrS8+MhINERQaW737
	 OcXo99mi6EbVnPKryhwKxKQlqHl/fJfB5djsIiyUyuglwz7AcagVoC9Mrp1iAkgNdIA3Z
	 XWbVQDvkzYqPUEFanSo08iRSMnlsWSHneOehWsCbMOHhG8rowdckB4YWPR1FpvhwlZs7y
	 7C6yW0ur+XnKeCywpbam01lGl/GLHqQuY3G7rW/PQHxUgBbvOkpLz43PizhMOK80diy2H
	 NVG8Hpy5uLnbTQW10vZ2h8AzDlikcwCNulvjBlXrj6rKg1q0CBRWnvZwR4lsclXTBOg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790870837;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=D0Y8tihLsqcy84IGAEFrza1x8/lG96gZeizBYvSbOwI=;
	b=m3h6ata0hCrf66Ib3dnYmxeS2GkH8b4E5hZiQrfAj7X2Ucu3UvBlH7Ateli0/ceEXIIY
	 zP+TgJnJqaHs7SKNumgb8N1m6Ml1mDRrHhfkwl0Isg1ypSPyvcoabjexTWeE1Ssraqj4t
	 Npg0BkbCufmAb8rv9YyBjhLLuQJskEGm/0vothalBur0Bz8xSkM/tcvbvuSfJxPJRD+1h
	 5We9NMzkqN1HBUD5NINL7FvfOUn7Ygwh2MAHvyApZJtkkqwkxguRkpZGX1CFJHKxgRWYs
	 iVcu5HIL6uFZeAU81owZe+nJALozeOfC4NFf6e8LnJSHb32J4hcMRWn6LtCcGfpyLig==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790870837;
	bh=D0Y8tihLsqcy84IGAEFrza1x8/lG96gZeizBYvSbOwI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZqtLAcG74YjkQmDYhZlvuFp2UX+tEOYYpY3xOdsgRKWT7HAi+KS0+I4o+X0/8Sx8L
	 1dmMliTzFhBhHglOoh173hSCvIDhtoyhYohkxvp6KEJvzmC69UO0iX8yl3WMwT7oO+
	 +lu9m6NMIJD6smX6njBEvroxz2TBTVAotzv0cqmE22e74cuFiHVFeGiz8jlHvDOgJ/
	 m8JtwI+LJDp3bz1aDzIzXYfgZLawfKucXhed27Ygr1K8zeP1zbqRi/s7I+M7DamJOI
	 HCjHlIBlVaaTB39oHga/QYp8Sb3r8+2xAdytWbidmOQf8BDxyQjt9ZQctfg4/n2t9e
	 k4SIgDbKS1l8w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6C6DE60B26;
	Thu,  1 Oct 2026 16:07:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2B9AD1A6
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 16:07:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 122D74080E
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 16:07:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qqSD1J3y1T9e for <u-boot@lists.u-boot-project.org>;
 Thu,  1 Oct 2026 16:07:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 0D36F407C4
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:33::c"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790870835;
 b=cdNF8LxCI/7WDT2B2OU6K4jsV5qWjpU5jdbsXobomX6o+H8Xyawe44yPBl4W3XlFzwYO
 mBfqc8DswDvHRMKOWQq6LqNvkB8HF9nkbazfIbaeR0gM5tadi+jGZmz6l3vEQqJTzXJjg
 1es/YqxLb1QwEYRj64m4fcCOUQKam39Oo30TFCm/iPoQiAxLTlP3kTaA4ui9MXRwyFvEo
 HCbkfZYrv7iD7/Buk8vvg1K5KFkyc6LtDCacdkKd9MgN0Kll0+5qo+sI0Qo3CkRF4Wmfi
 AxM5uZZLTzuoCy7fyrA9V+jo/2xpdxWuGFJa9ayMZQCChewGKFSNGiMbsuXmXEHxhzA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790870835;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=D0Y8tihLsqcy84IGAEFrza1x8/lG96gZeizBYvSbOwI=;
 b=kRff2aA2ULHvq3MJTtUBTKAIQvxq1c+vUHf5TJk26HsohRpKLMd96ZX54L6WjwLkxSYm
 9S6dzp0JoUnqO/pTHVFma+RxAcr+yaZq6KADhpw1EMmhP5LfWAhfNV7nNqZG9LznfunRV
 q4wEgR6uOD2Z2s+XumYDJKTDauso7Fx9snxlWyNraViPtdCqG8YOq1aDoWzXaD4ao3fu5
 JltHhXkgiQVr8vc+B4Zx4NgBTNWSI925CFU9xdioNxZ/hWPg2AAv6CRbTZxV9e66FFSxA
 g5dPeaWApwJOiguNW+H/S4+deCWOJtL/LrHL/A6OoK+nLgMMN/BiS+5Q+Ck9v6ybc9Q==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=ejWq6ehe; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:33::c"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:33::c;
 helo=mail-ed2-x0c.google.com; envelope-from=sjg@chromium.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=ejWq6ehe
Received: from mail-ed2-x0c.google.com (mail-ed2-x0c.google.com
 [IPv6:2a00:1450:4864:33::c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0D36F407C4
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 16:07:14 +0000 (UTC)
Received: by mail-ed2-x0c.google.com with SMTP id
 4fb4d7f45d1cf-6acb6b726b5so5522408a12.0
 for <u-boot@lists.u-boot-project.org>; Thu, 01 Oct 2026 09:07:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790870832; cv=none;
 d=google.com; s=arc-20260327;
 b=DImvLtzeHkw0FHGZXd0rwVtSJv87IVcT8bH7Z2JRXP4FKurtKEPQtpAnaZE2Htu37K
 joz02AAxynVdTy/E7wfo9mmz72tLN7ao23+Fa9vTHthTwXCg0lHTEhyO5v8yK+RPn2lo
 xwPNrrx15LibtXk2/ralO+6kyeqGIQ7o58R8nX7Io1bExvZDbO2yCp8bvsIWrtP5uGM9
 Wtw31ZGTsP0KhAahkCDhJ3DmH9sp83a6+Vq1RXHN3g9zVGvrIxQyahbYXN3vkPJf+0zG
 r2Up+KcdWjSkeLtypclkGuF/pNPglOGb6oGJLE4sryotl+mowzA/5KbUDf4+tCE2CacH
 qWnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=D0Y8tihLsqcy84IGAEFrza1x8/lG96gZeizBYvSbOwI=;
 fh=u5QS1SB/Dt/KeixQ0/C/ovPG15fr1d8zWkl5nfXeE74=;
 b=QMF29RsCVo8K6ZBcB30sZPtIkX8Zy74rA+20ughveHyDZtSCuH+RH2q1PSBL8XGfF0
 AvUuTUQeEjvV5uqYelBdH2tSTSkIFuh5XHjbyGOO4l7ZO1+rpaz4W50PpqOLQOfCtfLZ
 i6WqJQcHfw/YLbBjeYaj8D5p1Mm39pTd6sHOALfYwpX4Sw4Zm+CYLDLcPZRrGqVExzLM
 0JYz8Sq2ePjZzs+FjYzLbdr2qY6CBUpScfa95Gv3Wtdv6mBEfunv5TjyPECP3KKouI/g
 W8I1lkV7iZaS47yKKmprb9Hm9W0L/EVlOaw7WyZ3nJVnJ3HFRmAMEyhYM0w+WkMSEMBt
 OmlA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1790870832; x=1791475632;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=D0Y8tihLsqcy84IGAEFrza1x8/lG96gZeizBYvSbOwI=;
 b=ejWq6eheu1bH7+nIT8SkoqI8i4VVdqd3e2JFdClTKkqtKhOstbtoGdqw+iMrihB+Fw
 QUI03hv16r0nH+pWJwH/k2aAkqgCuextdNV9/ntqQ7IqnNssNpWEDDnKMYqZPdfqcM4L
 KC8uIMrXCYnlEw2iKUQaFQaNJWabR0+pBS43g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790870832; x=1791475632;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=D0Y8tihLsqcy84IGAEFrza1x8/lG96gZeizBYvSbOwI=;
 b=iG2z1aHRgDb3aud6lhatgbuiHZ+8QxTTElPDzBUPxvSsR4qv7FwUq7T2f7XqdSMela
 vapIGXCg+wBxnR9tcKTqblQLuOMGLl9jV8rF4hTBaqBOaGm0KwY/yaEq7uNh0SI0R4qV
 FPHd/A1pjmjBJAGO73an/8UYGgp3QP/EdFiZ0tpWluo/xPGKTULPaBhueZjbIclVcQ8Q
 O1WbSKS3n6nNJA4yNdLxTcRacAzEqYRUMi5oTnN1FIACE6Q4YifdghzIOxJipG72kf9R
 d08tZTpjMvDNwm9ePzJuPkul37mDkZXh+9hm2ixi++j50BA+tjlmmyOkll8tOvElv6qB
 Vitw==
X-Gm-Message-State: AFq9FYJ0rnczFHQPEyw3AOOmPBA/k2OpLg878qn9f0/CMQiMfrcAZ/WZ
 1qIasX0I+P8RZJLk3NAh8LFNYdWvvRLpP1nG8bo9mH8ExWtlSaD5QFqnOoIQ2IMdb8I5LPBMdFA
 acAckh1eD1ycllTYTjuVQqbVW90qDvi6yC/ME9Qtg
X-Gm-Gg: AYBFou2SOhqLb73i4d++t00xjH7mstlZr/v+32dy3GUjq60ei/n1izFlFwk8dY6Ni9m
 MvRePuaRnyfYnlq6DJxS9p2Z+RjcDVPPzQO6dUSlQHg6M6a5wuyeTRBGFtOwkzLGJ1iwBhn5pHp
 sQfB0mY43QMgV7S9Nf1bLl+eE3IF4eqNpnb9uYgcZEzW5WNh+R0kJPsEFAXeUdw/GI0YX8khdw0
 YrLIqaK5o9pm7BaJu7Qh8hAI0oJxo0q08XwgA5LA+WBymLe4cxnNtzAGYc1n1Hr2c1rAc69Vrqu
 erRrJUJPJI+QuemE2l39Uan7l3pLux3it5yL0cK2op3riPPp18U3Qiu7
X-Received: by 2002:a05:6402:540f:b0:6aa:e589:87de with SMTP id
 4fb4d7f45d1cf-6ae198d586cmr4359733a12.20.1790870832272; Thu, 01 Oct 2026
 09:07:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260925072741.1966573-1-0xiviel@gmail.com>
 <20260925072741.1966573-3-0xiviel@gmail.com>
In-Reply-To: <20260925072741.1966573-3-0xiviel@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 1 Oct 2026 17:07:00 +0100
X-Gm-Features: AclHuK8Usv_r7G7itSP-Rcz99aazJhjDydPqHeU87p7nULBr9MEdu3LWUTF_xqw
Message-ID: <CAFLszTjBPxSuGdfaZ+z4jmrM1Hj6B-CwiWWqbgDK0R4MWwGRBw@mail.gmail.com>
Subject: Re: [PATCH 2/2] test: vboot: add coverage for a control FDT with no
 /signature node
To: 0xiviel@gmail.com
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Ludwig Nussel <ludwig.nussel@siemens.com>, Simon Glass <sjg@chromium.org>, 
 Anton Ivanov <anton@binarly.io>, Daniel Golle <daniel@makrotopia.org>, 
 Johan Jonker <jbx6244@gmail.com>, Jonas Karlman <jonas@kwiboo.se>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Eva,

On 2026-09-25T07:27:39, Eva Crystal <0xiviel@gmail.com> wrote:
> test: vboot: add coverage for a control FDT with no /signature node
>
> Build a control devicetree with no "/signature" node and an unsigned
> FIT, then check that the boot is refused when
> CONFIG_FIT_REQUIRE_IMAGE_SIGS is enabled, and that the historical
> fail-open behaviour is kept when it is not.
>
> The missing node is reported whether or not the option is enabled, so
> the warning is expected in both cases and only the boot outcome
> differs.
>
> Cc: Jonas Karlman <jonas@kwiboo.se>
> Signed-off-by: Eva Crystal <0xiviel@gmail.com>
>
> test/py/tests/test_vboot.py | 109 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 109 insertions(+)

> diff --git a/test/py/tests/test_vboot.py b/test/py/tests/test_vboot.py
> @@ -853,3 +853,112 @@ def test_fdt_add_pubkey(ubman, name, sha_algo, padding, sign_options, algo_arg):
> +    bcfg = ubman.config.buildconfig
> +    require_image_sigs = bcfg.get('config_fit_require_image_sigs', False)

No defconfig enables FIT_REQUIRE_IMAGE_SIGS, so CI only runs the
fail-open branch, never the one that tests the new option. Also, as
1/2 notes, enabling the option on sandbox makes 13 existing test_vboot
cases fail, so nobody can turn it on without the suite going red.
Please can you deal with both? One approach is to add
@pytest.mark.notbuildconfigspec('fit_require_image_sigs') to
test_vboot(), or have it expect the refusal where relevant, then
enable the option in a sandbox config that CI builds (e.g.
sandbox_flattree or a new small defconfig) or a CI job, so the refused
path runs. Without that, the most important half of this test is dead
code.

> diff --git a/test/py/tests/test_vboot.py b/test/py/tests/test_vboot.py
> @@ -853,3 +853,112 @@ def test_fdt_add_pubkey(ubman, name, sha_algo, padding, sign_options, algo_arg):
> +        else:
> +            # Fail-open is kept: the image still verifies and the board
> +            # boots, but the condition is no longer silent.
> +            run_bootm('no signature node',
> +                      [warning, 'Verifying Hash Integrity'],
> +                      True)

test_vboot() already covers this case: test_with_algo() builds a fresh
sandbox-u-boot.dtb with no keys, builds sign-configs-*.its and checks
that 'unsigned config' boots. The only new thing here is the warning
check. I suspect it would be simpler to add the warning assertion (and
the refusal expectation, per the comment above) to that existing
run_bootm() call, rather than adding a near-copy of the setup and of
run_bootm(). What do you think?

Also, 'Verifying Hash Integrity' is printed before any check is done,
so it shows nothing here. If you keep this, 'sha256+ OK' would at
least pin down the output you describe in patch 1.

> diff --git a/test/py/tests/test_vboot.py b/test/py/tests/test_vboot.py
> @@ -853,3 +853,112 @@ def test_fdt_add_pubkey(ubman, name, sha_algo, padding, sign_options, algo_arg):
> +@pytest.mark.requiredtool('fdtget')
> +@pytest.mark.requiredtool('openssl')
> +def test_vboot_no_sig_node(ubman):

No keys are created here, so openssl isn't needed. Please drop that marker.

> diff --git a/test/py/tests/test_vboot.py b/test/py/tests/test_vboot.py
> @@ -853,3 +853,112 @@ def test_fdt_add_pubkey(ubman, name, sha_algo, padding, sign_options, algo_arg):
> +            run_bootm('no signature node',
> +                      [warning, 'Unable to verify required signature'],
> +                      False)

The full message here is "Unable to verify required signature for ''
hash node in 'kernel' image node". The empty name is misleading, since
no hash node is involved when the control FDT has no /signature node.
The message comes from 1/2, so it may be worth fixing there. It would
also be good to assert that the warning appears only once, since 'once
per boot' is part of the contract in 1/2. The FIT has two images, so a
count check would catch a regression.

Regards,
Simon
