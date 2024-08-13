Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01D0AC52D7B
	for <u-boot@archiver.kernel.org>; Tue, 13 Aug 2024 12:17:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07258889B4;
	Tue, 13 Aug 2024 14:17:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gC4hZH3U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 204AA8871A; Tue, 13 Aug 2024 14:17:37 +0200 (CEST)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3EC59889B4
 for <u-boot@lists.denx.de>; Tue, 13 Aug 2024 14:17:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-6bb96ef0e8eso28596826d6.2
 for <u-boot@lists.denx.de>; Tue, 13 Aug 2024 05:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723551452; x=1724156252; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BYsv62S92dXEvCzH6fXcVU9OzXocCj5lPDrYmHrQibw=;
 b=gC4hZH3UcKMTX4fZ3pQXK8tv1sG527Z24WyUiO8amjzpt2gtZ6jznxQRLk8vwSTjNb
 At06bCqvT31NdfaXI6eXoAil2Bn7r3B8sv393ciWdyF7DqsvAyQnNgw8BRzSYQVadiwM
 S8ezDiJPfx+EzYHlZlMkCJSbKIrCV+zuVjHZg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723551452; x=1724156252;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BYsv62S92dXEvCzH6fXcVU9OzXocCj5lPDrYmHrQibw=;
 b=IKKK25cCLaJall2WDs6bV25AasQEbrNIkc8chhWLOGNaS/GgFr7WQTua5Tq7k1Awvu
 XghrDYP0Rd7kGRkZ7lcvWdVpcgzrldoFFCvJShqlf/1aAnD4OrRA1cKIc5lqsBB9//br
 SJu0ceVoUFWe1hBZE52JLrgIkRBYe9vmSoXv2NoFtHldZScy/oVChxOkskyy/7IDazbl
 ngnSNGZ+F2rEvx5ua8qRfn49XwK4PSEJ9zep2DEh45sFTGynufNQChW1vxQxQnfx0ZQf
 Drjst+4v79b+koQVX3Em3Gy+OfKkT5nojyYqpsnINR9in6D2mvZ2OOwvta6HEjlCuisZ
 4miw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8gIH1SL99lQwHCI0n2hvBuJ4FWX+9r8Qc+99kDTHudvaRXscO9QmSCXbYAnbswYpBkNAoqVc=@lists.denx.de
X-Gm-Message-State: AOJu0YwkocQ2BsYfuR3IzHHJpYOjrqVjwQkIf/0v9cfn2WEZpoJPHUAV
 rXrqNejBSIpF/wCBfwAu/iBjtud1DIN6U+a5K92TRM5Z2RhhyxjvUocuN7Q4ARAQEJNVFvkdDTl
 28sZEnbd0M8xwTDhZL/Cr7Kq9Iz38DTatXrIUGzRwBVBp8Bs=
X-Google-Smtp-Source: AGHT+IEFq8DqmANIUedGDoCMewp1hGvXnS5A6c9NOeNPFwPwlrsHtivBiARcY2yXl7m12IcI1XsU0Bf+i9vYIVVnYx8=
X-Received: by 2002:a0c:f208:0:b0:6bb:9d52:6a88 with SMTP id
 6a1803df08f44-6bf4f8391bcmr37774666d6.43.1723551452060; Tue, 13 Aug 2024
 05:17:32 -0700 (PDT)
MIME-Version: 1.0
References: <03cdd29b-331c-76b0-f6d7-a064552ffd67@marvell.com>
 <CAFLszTiCS-jRfL__PJ=uEQf0rUKcw4J8czp-=khzkHB=q9ySOg@mail.gmail.com>
 <b4d4fe48-c3b0-98cc-dccf-8b96318ec204@marvell.com>
 <CAFLszTgN3AqhPzT+Zpe=sfM_cOZOmOQPseG_ipwMcNYzLbGUdQ@mail.gmail.com>
 <f1a2067c-942c-7e2d-ab28-7906a904a58e@marvell.com>
In-Reply-To: <f1a2067c-942c-7e2d-ab28-7906a904a58e@marvell.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 13 Aug 2024 06:17:20 -0600
Message-ID: <CAFLszTjp4r=h=v9_9gmpAhaEQck-ZiUXBzK4GSFYhDoZktBd-A@mail.gmail.com>
Subject: Re: [PATCH v3] env: remove vars that are not in default env
To: Ravi Minnikanti <rminnikanti@marvell.com>
Cc: Tom Rini <trini@konsulko.com>, quentin.schulz@bootlin.com, 
 U-Boot-Denx <u-boot@lists.denx.de>
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

On Sun, 11 Aug 2024 at 12:44, Ravi Minnikanti <rminnikanti@marvell.com> wrote:
>
> current env_set_default_vars() doesn't delete
> var that are not in the imported env. hashtable
> removes vars that are not in the imported
> env but present in the current env only if H_NOCLEAR
> flag is not set.
>
> This change is to avoid passing H_NOCLEAR flag if
> specific vars are passed to env_set_default_vars()
>
> Without this change:
> Marvell>> env default boot_mode
> Marvell>>
>
> With the change:
> Marvell>> env default boot_mode
> WARNING: 'boot_mode' not in imported env, deleting it!
>
> Signed-off-by: Ravi Minnikanti <rminnikanti@marvell.com>
> ---
> Changes in v2:
> - Added env ut to test the scenario
> - Updated doc usage/cmd/env.rst
>
> => ut env
> Running 5 environment tests
> Test: env_test_attrs_lookup: attr.c
> Test: env_test_attrs_lookup_regex: attr.c
> Test: env_test_env_cmd: cmd_ut_env.c
> Test: env_test_htab_deletes: hashtable.c
> Test: env_test_htab_fill: hashtable.c
> Failures: 0
>
> Changes in v3:
> - Fixed review comments
> - Ran checkpatch.pl and fixed trailing whitespaces.
> - Used UT_TESTF_CONSOLE_REC flag instead of console_record_reset_enable()
> - Removed unnecessary ut_assert_nextline_empty() check
> ---
>  doc/usage/cmd/env.rst |  4 +++-
>  env/common.c          | 10 +++++++++-
>  test/env/cmd_ut_env.c | 27 +++++++++++++++++++++++++++
>  3 files changed, 39 insertions(+), 2 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
