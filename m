Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64A13CC6B00
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 14:02:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 23E2980A49;
	Mon, 12 Oct 2026 14:02:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RjKZdzH4wg33; Mon, 12 Oct 2026 14:02:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5BFDD8084C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791813733;
	b=plNHA8YeLFi6J1gitYtlwG0U8CShcyjEUChRVoS1U0Rw1WP8afTQI5RUdp2MOgAqVvoH
	 DFCktxOqB+6YZoLj1hOW3dUKiUpjpnrbEBD5IAfcDIjMhIlpKDlr6GKCmxAJlyLMgRJ7m
	 RWXrrVqCWc7J2k1L4QvjypHLBJshw7KQ82KHqyDOXxilN9s4VN/n5lsKYSmzXtGKMSs+n
	 yYa1ys5B2ej8EfSE2Zpf51Wftx1f0U2ii/PNjQxh0FukREfTuFZeSzJsvNAELkjcr1Nrj
	 sCy0QgkLsd21OAFRb7m4i5nNPjZQ9b5jzaJxywosfpOgzVnh1ze2klxUMch+YFsK8Dw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791813733;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=7Kn3yMWPHiBYYtgLw3UjDxm0CX1Ntj0559RaHE2aI4o=;
	b=P5PXV2oHunnhb1CHheYie2rq58TnSYt/uD7mLQLAuSTz5fRd6RQ08qiSBOP4Z+nuzFI6
	 cdxwC7w+H78SNgcVn7vHS4820V6sGdNa1ERWmvn0Oc/ymPUykFP1H3FjUPzNlZlofJ6Sg
	 4KOIGH39TQHJePA1upjdGMBlLcoqys4Sfh+NF253QS5dyPZhWoDfO7HXL/TipR/6S5ebc
	 L2vTQi0hGie7kWHiZm2xv+HMd0TbgLkf0n9W7GwJDndyXgZp374Wks3v8b9qACh2PowU4
	 SCuZKkfHRulMvOGFU2Uc/8oJLwRAlf96WS2yMUKVCo6mOV6z+j5qCjgk+LY+/B9XGZg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791813733;
	bh=7Kn3yMWPHiBYYtgLw3UjDxm0CX1Ntj0559RaHE2aI4o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=q5E0T0jPqftEBVT30cdlky9p6dj1vTWrqSAynFY4qGAiG129YqPz+3TUpAvq90P0c
	 YaY/Vh7NpYHrLfde8XJ7xngTPbK3S/PLy+zqbmvi2dSTa9ZbkwKTe+ogrrX6L6flwF
	 t2UgrVJHRHplYq+JnNan+FDVvL/cwDB8G9eV3zMIrQesRNCzM3Hp78JN/0KVyd82kJ
	 /o2UZHz+44b5OpEd+KGNxTsfUqA9nzEVwAlQzaJTusmVAt//Lkblep55MDxqmQVhLR
	 SwL3I5boo3bEXWLP94El2wkRDn4ER2OuKelQjqYzZctkychF+UYtdk7ujmpYy1BB46
	 p58Du7MLJtSKQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5BFDD8084C;
	Mon, 12 Oct 2026 14:02:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id A588E2E0
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 14:02:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8BC8B405E6
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 14:02:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id frRapefP_CzA for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 14:02:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D16FD405D0
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::52b"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791813731;
 b=RjovUh1nOyuCrJp2XlQ2Ab4cxeMWhpEOUSSWbF5sHQ5TirO7A00a6lK/4lqkpw/l2OmH
 ozb/vDAg1yRRDMHHH2slyyl5HQ4hEBwC80qjIZ3qCOJuzULr/y3+iERYgiE2vdH/jAhKV
 TKNijT1w7CA1EWH+2YnBzmt2bw2uS9/D/v/lnyAXghPTno8dygFmKu3lLriHOv/2QS0pX
 hphkYv14Vf33IxwIsMi86TsFkbPJnSTkHk3GJ3JGc0h85IDwmTeqaaquoxjIS9Ib+OTSr
 av6SHTN/OWTT2Kxzwonf7S80d42AvYMn3LqcQFxA9EJ8ttbHe/0MyGtXdoZIk9pSXhg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791813731;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=7Kn3yMWPHiBYYtgLw3UjDxm0CX1Ntj0559RaHE2aI4o=;
 b=o1TVP1VlK8CkRXfbG0NViME0bsXvxxUE84zkIZvu+PqG4mvFc3CEciKm57cszVKd+MXz
 fV4/F7fP7jZFsRzwZyomGjl2D+lMpZuqq7Ifr6pDg+iTDV2RJUMbi0sYOrUZiclFUcTPY
 sj/QnaAe11Nr+811Rqb7hTjxFP8OH+czL5BLiSgiclg5IPAlcPYOKnv/utqFn4ZhSuRGo
 Dsu9vrajuGq61piWGklQIgdzhdbVO/ZQGRA2iy5ZEs+0gPW/V1WkAlsPMd+ArzLYJurf3
 Pel8ytF9wsSPZtU8i2Q/yRCnYQNRVFeCQsmDM25Uueui5EMqxwUpjpE9PdhZxAMG4Ew==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=YsTKbViY; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::52b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::52b; helo=mail-pg1-x52b.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=YsTKbViY
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com
 [IPv6:2607:f8b0:4864:20::52b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D16FD405D0
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 14:02:09 +0000 (UTC)
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-ccce6d9abfeso1093592a12.1
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 07:02:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791813729; cv=none;
 d=google.com; s=arc-20260327;
 b=G3V2ZVsq1Dsi4KacqI7YvqC+PYI+3pfJjSGt9YEydAcVUTwDX75TnloFKjLkhJLKQV
 nlTZxVsbROoW385rUkhvqP0P+SCwnX4iIZiOr4mAnMv+hIbaERSbOVIr0JngkbFlbbG0
 X9v6+byil+aPUC3hEqfYLEqQOlKasMAeWLA3cZZENJk+yuuc7SF9BwT3LXTuL5wQW+px
 1aokOheZyDVaAcDOUXclRNJQjv2niM7Bkj448x/zfd6MP8LOWz6uHoTpZ212rWWp1ZcN
 dGyyV55BICqxxoHQXp2a++X9bnPE0Awi1H4DMYAqQsRaJ6UMgyy5eVcHNdNtGITQa2Ka
 ezBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=7Kn3yMWPHiBYYtgLw3UjDxm0CX1Ntj0559RaHE2aI4o=;
 fh=rDOkmCQJ9cozxuZkgmyNWj5k0ThXnY0U4gnSEgE31/k=;
 b=fGLg5VAQ/Kj8cKLfQoHuCwvv0y+Gfy/BEq40iI3CO12E0PrHWEMw9T3Qow7FuwWQlx
 hf2CvESmb203pGvtVvIaTtOGwbKOYMVTvkxyQMD8b9U/sa7O9UmCtOa1A8Bkcb8JKedP
 Tm+f4DFx+UlyLhrS4H55cZTSj8QUO4GwWnQQ4h3UBsF5gH4rQA6e2v2hVNK4hiPTk3Pd
 GO4JH5OUOg2pfjeMaxqMRrdN8suVY3jh6OixIDkFLTy1SZYl3Egh6Jw5egY2G36z3jbX
 gQBl31rCYLoy5e2PivolIxTi0yQV10qXYWqG/dvErX7LuJ9GMVvQlTAbr0xNPBdDjSxz
 hAKQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1791813729; x=1792418529;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=7Kn3yMWPHiBYYtgLw3UjDxm0CX1Ntj0559RaHE2aI4o=;
 b=YsTKbViYZWk8l7RY7NliooIqQUG9y4iCk7+ReRL7atSZoJ6XOzdmikTLILkahj5CGn
 Ox6bs0qj4xyWP5EhLdPOjM7Yu46lbPiJoum9V8s7hpRJB0utw2CNcUhJOqpB06hENzos
 Igp3DQwmXTbahQHL7fz+XqQhrwrIfB8XHFMfE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791813729; x=1792418529;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=7Kn3yMWPHiBYYtgLw3UjDxm0CX1Ntj0559RaHE2aI4o=;
 b=BT68jzPl1pjMnDaaNCQ15leOmR4AqVBdd1rbUJphRVcJdZPdrdDOQBbcPf2H9mqFn+
 T2ZUoh8JL0x3YYpL77AO7JesPP7FuEl+AbnZphNRQEaoi4Kn4uURTQbko6FfoqUEgF48
 AsRY2/rbzWWW5H+Zn1n+yTI4Rm+Kg9Q/5FhlqpHzfGzb9J41mYvNId7yW2ovtow6XBUn
 JjbntBdZ8CEWCbZyNm2wkNKGRs/Di/x+hprqp8jX+BHKaNBxXiJ8fMJjkfAGRwt3jM+5
 65pR2njuKzAur8Ayc29dHPmOE7uF4KZiqzqsByG53t9fRTZn+3dsrCvXhO5z85FeJAeJ
 1N5A==
X-Gm-Message-State: AFq9FYLnZzZB2eJdq0n1wJ+ljbg+/zm+ifLtgZQU8Px02ai/rsiARGHz
 CjH/EPC7VwgMzsTI1jpR320ZL7FB28WfZHa8m6rt+BqA+xgt98COWF80EEXB5xzL88Rzu6EWY2J
 hMmJPNDwsgZNsZ/Ifvhoe0H0VAyPloz9yWJNEmXGxSYCPqOum7a8=
X-Gm-Gg: AYBFou0te/Dls1MIsajOF8YmxRr2N4/O5vlWOmH2NVu+wt8YTPMcximl2lw9aytsdyx
 4VpXbeIJm109vu4840Z6l6O8akCF2SeVgzxRW5c5vBm0gIS5ZAhSkJqH4LIz+cWi34MTKOQ0Vnh
 +la7YeVfiMquLkk0yF0/4oBflaJSphS+UjInpfrjZ5Xzz94/rftr6Tw7bE4V6w5VFn0kR67KKhz
 uMJcL2sCgGFzqqzjMKkqXxrotSh3fbO54ezoTYbVvgpDdsDIzKyYp6pda0KM4+d8i+vXfLxebh1
 HEhoAPZBM3J/2TK4xqxhOKKEDiIFiUhCKX6armjTeoqyLRIiay0Iu+I=
X-Received: by 2002:a17:90b:390d:b0:39d:84af:a0b3 with SMTP id
 98e67ed59e1d1-3ab3a90e821mr8070443a91.18.1791813728860; Mon, 12 Oct 2026
 07:02:08 -0700 (PDT)
MIME-Version: 1.0
References: <20261010-b4-button-live-monitor-v2-0-004f47a4a7b1@protonmail.com>
 <20261010-b4-button-live-monitor-v2-3-004f47a4a7b1@protonmail.com>
In-Reply-To: <20261010-b4-button-live-monitor-v2-3-004f47a4a7b1@protonmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 12 Oct 2026 15:01:46 +0100
X-Gm-Features: AclHuK9AwWh5mXkPzZ5vCIcGr5NZlDcKld9PkR02pyHRDp3zPFwBOB3FBjSmmaw
Message-ID: <CAFLszTiJ3isHVs=eT93ERHKAuySPA8YQZHoOgae5mQMO1YJEJg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] test: button: add test for monitor subcommand
To: petr.hodina@protonmail.com
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 David Heidelberg <david@ixit.cz>, Simon Glass <sjg@chromium.org>
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

Hi Petr,

On 2026-10-10T12:27:54, Petr Hodina via B4 Relay
<devnull+petr.hodina.protonmail.com@kernel.org> wrote:
> test: button: add test for monitor subcommand
>
> Run 'button monitor 200' on sandbox and check that the output lists
> button1 and button2 and that the command returns 0 after the timeout.
>
> Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
>
> test/py/tests/test_button.py | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)

> diff --git a/test/py/tests/test_button.py b/test/py/tests/test_button.py
> @@ -37,3 +37,23 @@ def test_button_return_code(ubman):
> +    response = ubman.run_command('button monitor 200; echo rc:$?')
> +    assert('Button monitor' in response)
> +    assert('button1' in response)
> +    assert('button2' in response)
> +    assert('rc:0' in response)

This only checks the labels, which 'button list' already covers, and
not the printed states. Please can you drive a3 high first, as
test_button_return_code() does, and check that button1 shows 'on'?

I also wonder whether this would be better as a C test in
test/dm/button.c, using console recording. You could then check the
exact lines, including the escape sequences, with ut_assert_nextline()
and similar. You could also cover the Ctrl-C path, which is new in v2
and has no test yet: call console_in_puts('\x03') and then run 'button
monitor 0'. At present a timeout of 0 has no test at all, and a bug
there would hang the run. A C test would also run faster than pytest.
What do you think?

> diff --git a/test/py/tests/test_button.py b/test/py/tests/test_button.py
> @@ -37,3 +37,23 @@ def test_button_return_code(ubman):
> +    response = ubman.run_command('button monitor abc; echo rc:$?')
> +    assert('Button monitor' not in response)
> +    assert('rc:1' in response)

The CMD_RET_USAGE text includes 'button monitor [timeout_ms]', so this
check only passes because of the capital B. It would be clearer to
check that 'Usage' is in the response. With a C test you can check for
run_command() returning CMD_RET_USAGE instead of 0. Please can you
also add a case with trailing junk such as 'button monitor 200x',
since that is what the '*endp' check in patch 1 is for?

Regards,
Simon
