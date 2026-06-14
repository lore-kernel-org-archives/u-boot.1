Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CECCCD98C5
	for <u-boot@archiver.kernel.org>; Sun, 14 Jun 2026 16:18:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01D8683FEE;
	Sun, 14 Jun 2026 18:18:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gsGmvn2S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 696EB84841; Sun, 14 Jun 2026 18:18:42 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19F3783EEF
 for <u-boot@lists.denx.de>; Sun, 14 Jun 2026 18:18:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-bed4f2f0898so334957566b.3
 for <u-boot@lists.denx.de>; Sun, 14 Jun 2026 09:18:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781453918; cv=none;
 d=google.com; s=arc-20240605;
 b=aRefYbpHBvVJGgPQ27Qw7IDXPbJiLi1QQAA/O6kCNbwcCy2RZilI5J7npfHuYFGqV/
 XUoz4BVKGfO92LgpzNnfQALFxgCwuNO1o73hcJ+nfdEv+6IrxqV46ykLyZ+594SdTozu
 sE+Snmr2v3JOgI/ItPUldZ+d9GGARJ1UcCRIUx5Pqubq/v+AS/ex5GrJNT743Q3qFCUP
 SugVIeVJVnOGjKANigJ+X5MvxuPEuYWyV40w61qJmKu2GybBN7xJbdCeIt/rRgJrc9d0
 xKBDw1Pbi+UlnGBmF3ThCYFllqMLHA/FbflRgIoFpLNHQwZOfUtoyKsf2+8GNtvQXIYy
 wA3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=sW0cFVRzIv+LqxBghX7pElrPbaDLfoOe0N95Gk6yx5Y=;
 fh=zR2buvS04tl8yfD/I/5YjPdhsEu7HKufx604qAmmYsI=;
 b=YmBL0+XIVi/xS/TqlXnb9I9Vl5BuIqomckRE9JYNVlgIB7R/85AfLoQ6z+XA5FdWI3
 CZYogj05VaPmuKnUQHWDLHI5kLHc5U4Raz+C/ug/RiZEZiBoP9gsSKfilXAFT/fxXQdx
 zNDtCGLtQYg230hopo067z4SaiElbN27xBDc3kfqsuPYLhEV4AlTxSt+/gZg9/s5GX8a
 +TZCy9bzB9aBfp7vmoJliRRhOFDDTzs4vpFi+zZCmZzmwAWvXkQQbGEVzDCy699sbWvc
 QuzL56hniMikMrdZF0yBjZcW5UAKBMnrIU/FzfDh01OOpY/E3orhHxXO1ryiitsuNtCj
 SjLw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1781453918; x=1782058718; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sW0cFVRzIv+LqxBghX7pElrPbaDLfoOe0N95Gk6yx5Y=;
 b=gsGmvn2S4f4kXRFjT7C129vcDpJdgu+N6YO1j88plhGh5I1be4NJXNf0zPDOLvKERB
 oTg89xJWhFTxnrqr2b/DdzomFMFD8fpwtm4bu2sQnuN/Y6oxkcIArtz7NhhEyaMH5GdJ
 y90NtnQUwmvMaLIGkdmVn2tOu7RUBjdLfytc0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781453918; x=1782058718;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sW0cFVRzIv+LqxBghX7pElrPbaDLfoOe0N95Gk6yx5Y=;
 b=VNB1P5edpgSY/SL6fTpTfZhfItjXIQqhXrVmyYlZPz5OOubAk1mL4y5EZwtlGshx2F
 483XRgqwJWBMRlulKNfUTY6HO1zCFFn5TTUUiz7+UplaaLhpErd/VyWy3/IE7dSx0IqH
 8umErRmpdMUClDGvnyEiIkWjejhGHyvTNb0KCWlGvxcpBx4MfifYH2WCHcaL3AsT+OwQ
 kQWEWR8m8X7BDi4zTWFEdU1E/OuFQ/zOX2oM+CH5ebCzEU/lF8VYKBhrMiCYM49PzHl3
 5q5hc6sX6lskiAABMaoAGav4AxTfLkgjc6PpISvxycNzoUJ5l6NCEyrFoklXH+BERpyX
 cHwQ==
X-Gm-Message-State: AOJu0YxkhUIkhbIuLgUJojTclkc2kylAhDKr+54+FDJ/HIW7RMc+H26y
 168FnN6U6cwTW//artBFnkDxHpqFsk1BGRgU22GGdgcySx5kBy5Ecg4Yag8TNjpoaIW58EFlQiK
 xl4hN9Z7svIMxID75hzhu3UEO4xveRS4DOZjUzsNx
X-Gm-Gg: Acq92OHWpjrAT+I44GMKm5q0moFWUKcjOc0DpkayLCvsLo7Nb07xXOfPAZZLAM1QGCj
 /MOumrXeOAwiTvaPV219Ea015+P0jnInoWAJqgZrut92Bru4W1HitMlLqtGyLxXAh7oVDWBzV5T
 vwSfeFMgHAMXsQYWzyBnVGFd4O7xfSOy2fNYuTT9wd6mttX7NaYNd1IJ5mZMOABOdrBYCU2ZTQY
 R+FELl1xc8/ykIOXioATKdKzE9BKjjEKeOhjw0mQhRmg2unD8k8eAJ6ycmqLIjrmuE8nM1ViXoN
 iFVUUg==
X-Received: by 2002:a17:906:ef0d:b0:bfb:1853:c34c with SMTP id
 a640c23a62f3a-bfe282fb74fmr527482866b.14.1781453918566; Sun, 14 Jun 2026
 09:18:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260610-android-binman-v3-0-710298a38fcc@samcday.com>
 <20260610-android-binman-v3-1-710298a38fcc@samcday.com>
In-Reply-To: <20260610-android-binman-v3-1-710298a38fcc@samcday.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 14 Jun 2026 10:18:25 -0600
X-Gm-Features: AVVi8CcTbU5ScDysJGfe5X33txp0vN7TdiH_W-A4wKn3bl9z9cE9YZbSAUY2Aac
Message-ID: <CAFLszTgRVzKdwNyWh3sQxBwrMad3JJ+RW940wvJW9ncW1NRFuQ@mail.gmail.com>
Subject: Re: [PATCH v3 01/10] binman: support running multiple tests
To: me@samcday.com
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Bryan Brattlof <bb@ti.com>,
 Yannic Moog <y.moog@phytec.de>, 
 Wojciech Dubowik <Wojciech.Dubowik@mt.com>,
 Yegor Yefremov <yegorslists@googlemail.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Rasmus Villemoes <ravi@prevas.dk>, 
 Javier Tia <floss@jetm.me>, Minkyu Kang <mk7.kang@samsung.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>,
 Henrik Grimler <henrik@grimler.se>, 
 yan wang <yan.wang@softathome.com>, Marek Vasut <marex@nabladev.com>, 
 Denis Mukhin <dmukhin@ford.com>
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

Hi Sam,

On 2026-06-10T01:27:41, Sam Day via B4 Relay
<devnull+me.samcday.com@kernel.org> wrote:
> binman: support running multiple tests
>
> The helptext for binman test suggests that this was already supported,
> but it wasn't properly wired up.
>
> tools/binman/main.py            |  8 ++++----
>  tools/u_boot_pylib/test_util.py | 23 ++++++++++++++++-------
>  2 files changed, 20 insertions(+), 11 deletions(-)

This looks good.

> diff --git a/tools/u_boot_pylib/test_util.py b/tools/u_boot_pylib/test_util.py
> @@ -157,7 +157,7 @@ def run_test_suites(toolname, debug, verbosity, no_capture, test_preserve_dirs,
>              the output directory for this test. Both directories are displayed
>              on the command line.
>          processes: Number of processes to use to run tests (None=same as #CPUs)
> -        test_name: Name of test to run, or None for all
> +        test_name: Name of test, or list of test names, to run; None for all
>          toolpath: List of paths to use for tools

Since the parameter now accepts a list, please rename it to test_names
and update the four other callers (tools/patman/__main__.py,
tools/dtoc/main.py, tools/buildman/main.py,
tools/u_boot_pylib/__main__.py, tools/dtoc/test_fdt.py) at the same
time. The isinstance() branch then goes away too.

> diff --git a/tools/u_boot_pylib/test_util.py b/tools/u_boot_pylib/test_util.py
> @@ -182,12 +182,19 @@ def run_test_suites(toolname, debug, verbosity, no_capture, test_preserve_dirs,
>          resultclass=FullTextTestResult,
>      )
>
> -    if use_concurrent and processes != 1 and not test_name:
> +    if isinstance(test_name, str):
> +        test_names = [test_name]
> +    else:
> +        test_names = list(test_name or [])
> +    test_name_set = set(test_names)

test_name_set is dead by the end of patch 2, which replaces 'module in
test_name_set' with _match_name(module). Please fold the two patches
so this set is never introduced, or skip building it here and just use
'in test_names' until patch 2 replaces the check.

> diff --git a/tools/binman/main.py b/tools/binman/main.py
> @@ -58,8 +58,8 @@ def RunTests(debug, verbosity, processes, test_preserve_dirs, args, toolpath):
>              the output directory for this test. Both directories are displayed
>              on the command line.
>          processes: Number of processes to use to run tests (None=same as #CPUs)
> -        args: List of positional args provided to binman. This can hold a test
> -            name to execute (as in 'binman test testSections', for example)
> +        args: List of positional args provided to binman. This can hold test
> +            names to execute (as in 'binman test testSections', for example)

While you are here, the line above ("If a single test is selected (in
args[0]) it also preserves the output directory for this test") is now
stale - preserve_outdirs fires for any number of selected tests. Same
comment for the matching docstring in run_test_suites(). Please tidy
both up.

Regards,
Simon
