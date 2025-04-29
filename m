Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57F0DC369DC
	for <u-boot@archiver.kernel.org>; Tue, 29 Apr 2025 13:27:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A67BF826B2;
	Tue, 29 Apr 2025 15:27:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KFJp6l4q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 72B8D828A2; Tue, 29 Apr 2025 15:27:13 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94C7682A27
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 15:27:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5efe8d9eb1eso6431033a12.0
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 06:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1745933229; x=1746538029; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IRCPItSeS2oPlT/BTdSiWawybriwFp46qDvpAX7KnQA=;
 b=KFJp6l4qQCBiJKMa/ZVs40sHst2w4gNVmWRcBxYIz+EfBDifksq1+28te5VKv5mSbL
 /YfOMYEANCdMBYX9CLbTEmPvU5FbyygRN9m/PHKrDNBIRUEl18DCBVshdA+dgS53sYT4
 3cFumVq0JDQ7EvQLjrU+Z8FaUziQYG18+xyKs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745933229; x=1746538029;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IRCPItSeS2oPlT/BTdSiWawybriwFp46qDvpAX7KnQA=;
 b=MAMRRJtjRPwtax4lmgMHN6LlmBjorOIaxCmrx1189jm2rR8fTriGBVHajzn/+ZM16N
 8q/8WC7ZZ54IyQRncAp86RSKR2S6zrivm6O233b+9qn+rO4E7SVEIUTH/XVw/S6oH9rG
 qLlriFYr2WCN+Euh0j895kmzsJWwkPGluglLIQafkDkmXtCV0Al1fe7nmFtLun0OLj34
 yUsGlIsfyqlLJ5rLP6rPN6xOhae14GRRpeab1zDJmMfogJ8UjPMBGClfdQLITfn/oCXw
 ryj3A53okSKAh/OGUzkzMEfttSwH388T2DpXn22U3XVx93edIYfASszC8PoVi30pMn1x
 p3sQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWh9hBT4QrEF1VXp7aYuev343NodXoNzD1tiqOzSmCo0rV1Z9sRBhnVXTD+b9TncrTcM17vJto=@lists.denx.de
X-Gm-Message-State: AOJu0Yyfrztw3tAgqkIyAA+wZy4FCDJjToCFpIjaxGlub5IlN0AjReBI
 96t9zShQuRHN0pZxPieWT9Wd8MbZnoKR9xgsAy6blsy1qNUcUFXB74Id0W2HL0Nr9RWk8lLaYZU
 EJTRAId1YcIe82t28qZt6ANHa/pd1YXLlLenx
X-Gm-Gg: ASbGnctYpC9A5TTdJYKB4P/QZWeEoSEurRuMJJDBMqujFvvNQszzxRwZz9TcmPLcDpU
 6Tt0n1tx4XP3/92zyX/r8E0h339tllcm1fmtUuXEZh8GQJ7S84VEWs5I1jCpa4+SCG06injjGSq
 W80eDmv/cuSAmDusf+IiOhaN5G3b7pgTnf8w==
X-Google-Smtp-Source: AGHT+IH6qYbwYhbJZegrGriK0tMyOoXaWFwzw7+oWyIlZN8VKV2hCtQmKjCmfjBb8kzmyhPVtXcxfgddaNd21OWDc5s=
X-Received: by 2002:a05:6402:d08:b0:5ed:17d9:91d4 with SMTP id
 4fb4d7f45d1cf-5f839225bdfmr2794299a12.8.1745933228922; Tue, 29 Apr 2025
 06:27:08 -0700 (PDT)
MIME-Version: 1.0
References: <20250428214040.GH5495@bill-the-cat>
 <9b009d13-1145-4eae-9051-3837f3793749@linaro.org>
In-Reply-To: <9b009d13-1145-4eae-9051-3837f3793749@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 29 Apr 2025 07:26:57 -0600
X-Gm-Features: ATxdqUHowwhHQRHUtc1se3h66hRb5_NYmrN3IfzWSPtttar8nsJKdPF8GaA0KZk
Message-ID: <CAFLszTjbDG3DM7rR7+YP5f9RMTgKkbfz2Yg_SrrF2Zg9ywxSVg@mail.gmail.com>
Subject: Re: Missing UTHREAD doc annotations
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
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

Hi Jerome,

On Tue, 29 Apr 2025 at 04:16, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> Hi Tom,
>
> On 4/28/25 23:40, Tom Rini wrote:
> > Hey,
> >
> > As part of manually building the docs before doing -rc1, I saw the
> > following:
> > ./include/uthread.h:56: warning: cannot understand function prototype:
> > 'enum uthread_mutex_state '
> > ./include/uthread.h:64: warning: cannot understand function prototype:
> > 'struct uthread_mutex '
> > ./include/uthread.h:56: warning: cannot understand function prototype:
> > 'enum uthread_mutex_state '
> > ./include/uthread.h:64: warning: cannot understand function prototype:
> > 'struct uthread_mutex '
> >
> > Which should be fixed.
>
> Please see https://lists.denx.de/pipermail/u-boot/2025-April/588263.html.
>
> > I also noticed that with KDOC_WERROR=1 this did
> > not fail and still produced an exit status of 0 which is why it was
> > merged and not noticed until now.
>
> That's unfortunate. I don't understand why warning don't stop the build
> given that sphinx-build is given the -W option already.

This is what I see from make htmldocs:

>>>
  HOSTCC  scripts/basic/fixdep
  SPHINX  htmldocs -->
file:///scratch/sglass/cosarm/src/third_party/u-boot/files/doc/output
  PARSE   include/linker_lists.h
Running Sphinx v8.1.3
enabling CJK for LaTeX builder
loading translations [en]... done
Converting `source_suffix = '.rst'` to `source_suffix = {'.rst':
'restructuredtext'}`.
building [mo]: targets for 0 po files that are out of date
writing output...
building [html]: targets for 661 source files that are out of date
updating environment: [new config] 661 added, 0 changed, 0 removed
reading sources... [100%] usage/semihosting .. usage/upl
looking for now-outdated files... none found
pickling environment... done
checking consistency... done
preparing documents... done
copying assets...
copying downloadable files... [100%]
device-tree-bindings/firmware/fwu-mdata-gpt.yaml
copying static files...
Writing evaluated template result to
/scratch/sglass/cosarm/src/third_party/u-boot/files/doc/output/_static/language_data.js
Writing evaluated template result to
/scratch/sglass/cosarm/src/third_party/u-boot/files/doc/output/_static/basic.css
Writing evaluated template result to
/scratch/sglass/cosarm/src/third_party/u-boot/files/doc/output/_static/documentation_options.js
Writing evaluated template result to
/scratch/sglass/cosarm/src/third_party/u-boot/files/doc/output/_static/js/versions.js
copying static files: done
copying extra files...
copying extra files: done
copying assets: done
writing output... [100%] usage/spl_boot .. usage/upl    *
generating indices... genindex done
writing additional pages... search done
copying images... [100%] develop/pics/flamegraph_timing.png
dumping search index in English (code: en)... done
dumping object inventory... done
build succeeded.

The HTML pages are in doc/output.          *
<<<

I would suggest that only the lines marked * have any value. Then we
might notice the warnings.

Regards,
Simon
