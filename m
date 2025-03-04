Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB24AC282D0
	for <u-boot@archiver.kernel.org>; Tue,  4 Mar 2025 13:16:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7262F81974;
	Tue,  4 Mar 2025 14:16:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lluX45wH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FB318197D; Tue,  4 Mar 2025 14:16:32 +0100 (CET)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B659807D9
 for <u-boot@lists.denx.de>; Tue,  4 Mar 2025 14:16:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5dee07e51aaso10514124a12.3
 for <u-boot@lists.denx.de>; Tue, 04 Mar 2025 05:16:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741094188; x=1741698988; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+7PtqCPfzHXF8UYS44mFOkny9EBunldi+0D+qmAX6Dw=;
 b=lluX45wHeHkVzYH9B7tece+40T/qKWKq6s5DyyAb2VYvhlnvSvmNdLOpQtGgS7JchI
 x4XXY1aMmCnfWWKW6UMs1HAV/jzhPx553nIICkUUI21srh6w19kJDcP/e5PIDL3/A5Ku
 49Klt6FMnJACIC+eBuclSGEdOHJBPhBqbUbkg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741094188; x=1741698988;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+7PtqCPfzHXF8UYS44mFOkny9EBunldi+0D+qmAX6Dw=;
 b=MK0TSXnxvG7GMysNNezdk7pYidkuEw8w6CQdIYbAG27GgGVb+I9nDP8yU8TUV3DYTr
 2ymJKYFas0/7gv3wcY2idzDzif3OZ9oD/OGwt8UkmlyllOLhh5xY7B4b2ASXCB8EiqC4
 WLDz5QJa0nW+c7s4tObbPfbHVuww1kr/i/aUQKI6KmjyDz4DtrxYWG9ewsLhym28mY+r
 lcUzdN/TahYK7pCkb4nwHJ3GkpZnPN1hDog278bVjJkPfhTUOiu4iSzUkDB3cRVQgTRi
 IMBBDfQWs7VUPYrPt6ExMtatEehcZkpxmMyQskqnW+y18WS9x6tfPXtOnywF+MzINqsf
 Cnrw==
X-Gm-Message-State: AOJu0YwmQ8gYbdgsh/+EQyHcIZmQIQ3Ge+GpWJeZeXxqdzkjoDpkJF+R
 WuGPn07FfEIr18eP7VobKOSoyZtADc5mdmdZNd+8aamMKRu4zU4nrS4tk8qPx9N4NVkea1/ei/6
 +doVQWpeLUjkpvOlj8+yr1NGwBCv/tJ00vAvzuM9gM47yUlU=
X-Gm-Gg: ASbGncvJt4UnknNX6qF/PRxojwsEhfdxe/SfiumZUQlO7OgoVzAoBMnb0MGu13z5LrH
 CcXrs4hGuzIGbf1u48J59+rL37SRanh7ElcNRiiXQU3nnSiFajtHfFmM4oESqzwc73pL9LtLfJN
 /M+blrdRbdRmA0YjyStCfgM9He+S8=
X-Google-Smtp-Source: AGHT+IG9ElN7BRBM862uAKYjVS4O8OrBWWOEaS24LWrU1bpB8F/BLhk+Se5EEm0tR5KnG6tnf9D5JRTSMEvIh7Wyl1M=
X-Received: by 2002:a17:907:1b0b:b0:abb:9d27:290b with SMTP id
 a640c23a62f3a-abf25e99388mr2236047866b.9.1741094188529; Tue, 04 Mar 2025
 05:16:28 -0800 (PST)
MIME-Version: 1.0
References: <20250304130947.109799-1-sjg@chromium.org>
In-Reply-To: <20250304130947.109799-1-sjg@chromium.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 4 Mar 2025 06:16:15 -0700
X-Gm-Features: AQ5f1JrWNDtU6iHAo94uXQNIGh6FYN67VFQFhwRFcqegCwBDlhTykRzrW9xrKtQ
Message-ID: <CAFLszTjn0bK9wm9d446M_Vb4_Do4rBGidciWgwOnku4RCpsgbg@mail.gmail.com>
Subject: Re: [PATCH 0/7] binman: Check code-coverage requirements
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Alexander Kochetkov <al.kochet@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Brandon Maier <brandon.maier@collins.com>,
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Neha Malcom Francis <n-francis@ti.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Paul HENRYS <paul.henrys_ext@softathome.com>, Peng Fan <peng.fan@nxp.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>, 
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Tom Rini <trini@konsulko.com>
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

Hi,

On Tue, 4 Mar 2025 at 06:09, Simon Glass <sjg@chromium.org> wrote:
>
> This series adds a cover-coverage check to CI for Binman. The iMX8 tests
> are still not completed, so a work-around is included for those.
>
> A few fixes are included for some other problems.
>
>
> Jiaxun Yang (1):
>   binman: Workaround lz4 cli padding in test cases
>
> Simon Glass (6):
>   binman: Exclude dist-packages and site-packages
>   binman: Drop GetRootSkipAtStart()
>   binman: fit: Drop unused code
>   binman: Drop algo check in CheckSetHashValue()
>   binman: Work around missing test coverage
>   CI: Run code-coverage test for Binman
>
>  .azure-pipelines.yml                           |  5 ++++-
>  .gitlab-ci.yml                                 |  4 +++-
>  tools/binman/etype/fit.py                      |  2 --
>  tools/binman/etype/section.py                  | 17 -----------------
>  tools/binman/ftest.py                          |  7 +++++--
>  tools/binman/main.py                           |  8 +++++++-
>  tools/binman/state.py                          |  3 +--
>  .../binman/test/184_compress_section_size.dts  |  1 +
>  tools/u_boot_pylib/test_util.py                | 18 ++++++++++++++++--
>  9 files changed, 37 insertions(+), 28 deletions(-)
>
> --
> 2.43.0
>

Sorry, please ignore this series, it is not marked as v2.

Regards,
Simon
