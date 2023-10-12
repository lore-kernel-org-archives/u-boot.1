Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AF3DCDB46E
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 03:51:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9EC6B86F3B;
	Thu, 12 Oct 2023 05:46:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZsJuc5ld";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3593B86E5B; Thu, 12 Oct 2023 05:46:28 +0200 (CEST)
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com
 [IPv6:2607:f8b0:4864:20::b2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0ED4C86ED3
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 05:46:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-d9ace5370a0so65176276.0
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 20:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697082385; x=1697687185; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=028s1lUTzidZRzUaoAz/xJWlk7TwXeOn86TfUyqeQMw=;
 b=ZsJuc5ld/Yh6lE7SvH2y01nMsJcBrrSq91LJ8KE27XsU9AaZsYF7goDOawzAXBaxpR
 Z7bNZaW5IzGj2K+qtPdKak/B3xNMv7ZP3H+x8AnZ4BbozkIFgthg8LZKDX0DMoEZsfmO
 HoxX3JLz/0r/KPLmg9cS/jz6kt2KTcaCM/sBs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697082385; x=1697687185;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=028s1lUTzidZRzUaoAz/xJWlk7TwXeOn86TfUyqeQMw=;
 b=ZE6ccCJDzobypAIZ0wub9d9adMvpomRIEmojWusb5uXO+RGvsPhSNWvQtr7DhyJqUt
 Fq1CwoOsGm6wvZK3Q6wTkJkFOwggqqtCgFziYEyx0HJuLBU9U7Z5JCKGv981N89v10R1
 1cV9rHTKfnujjj1UTwHajAMXiASE6qcSgE56oaGwb2QmsOWkNdzKu3Nvf0qk+PcfB50t
 09AKC4DsGaXsncMOC2cZSAX0nb2HLVk9SWrssV6Q5JbmRcuxncnckyHu8K3uEU+xE9Bp
 Ie1N7J1soSVfMYWfJAhz5siZ/pU9DqS5Z8lv80Be5jeHK9csnxu7VfQL6KMkU1Vk8o50
 qSkQ==
X-Gm-Message-State: AOJu0YxCIX1IzeyBDnrmqPRIqWtPMriuHhM8hS4teMR2+tnVOIrAlDQg
 x7eSItdZ9jmEQQPIkfZ+kGMTvDeeMEERKpvk+3de2Q==
X-Google-Smtp-Source: AGHT+IG3TY0BYA9naLmKGwKznU+dqEuVZY5AnbwB4GADL2f3z+JCIU6lBnB/WL0k8wQpjxIAu6n4nHBFNzHJV7cAz7Y=
X-Received: by 2002:a5b:f09:0:b0:d78:441d:4d62 with SMTP id
 x9-20020a5b0f09000000b00d78441d4d62mr20042257ybr.22.1697082384595; Wed, 11
 Oct 2023 20:46:24 -0700 (PDT)
MIME-Version: 1.0
References: <20231010091059.375036-1-sughosh.ganu@linaro.org>
 <20231010091059.375036-7-sughosh.ganu@linaro.org>
In-Reply-To: <20231010091059.375036-7-sughosh.ganu@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 11 Oct 2023 20:45:20 -0700
Message-ID: <CAPnjgZ0xfdjU9GWkFCDvU6a=hxBCXbFh7KrJzgBaaZOPqicSdw@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] binman: capsule: Add support for generating EFI
 empty capsules
To: sughosh.ganu@linaro.org
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>, 
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

On Tue, 10 Oct 2023 at 02:12, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> Add support in binman for generating EFI empty capsules. These
> capsules are used in the FWU A/B update feature. Also add test cases
> in binman for the corresponding code coverage.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
> Changes since V1:
> * Instead of using two separate boolean values, use a 'capsule-type'
>   property for indicating generation of an accept/revert capsule.
> * Make corresponding changes in the sanity checks, documentation and
>   tests based on the above change.
> * Use lower case characters for GUIDs.
> * Call get_binman_test_guid() from the efi_capsule entry module.
> * Add the documentation entry for the empty capsules in entries.rst.
> * Remove the #[address,size]-cells properties from the test dts' for
>   empty capsules.
>
>  tools/binman/entries.rst                      | 44 ++++++++++
>  tools/binman/etype/efi_empty_capsule.py       | 86 +++++++++++++++++++
>  tools/binman/ftest.py                         | 57 ++++++++++++
>  tools/binman/test/319_capsule_accept.dts      | 13 +++
>  tools/binman/test/320_capsule_revert.dts      | 11 +++
>  .../test/321_capsule_accept_missing_guid.dts  | 11 +++
>  .../test/322_empty_capsule_type_missing.dts   | 12 +++
>  .../323_capsule_accept_revert_missing.dts     | 13 +++
>  8 files changed, 247 insertions(+)
>  create mode 100644 tools/binman/etype/efi_empty_capsule.py
>  create mode 100644 tools/binman/test/319_capsule_accept.dts
>  create mode 100644 tools/binman/test/320_capsule_revert.dts
>  create mode 100644 tools/binman/test/321_capsule_accept_missing_guid.dts
>  create mode 100644 tools/binman/test/322_empty_capsule_type_missing.dts
>  create mode 100644 tools/binman/test/323_capsule_accept_revert_missing.dts
>

Reviewed-by: Simon Glass <sjg@chromium.org>
