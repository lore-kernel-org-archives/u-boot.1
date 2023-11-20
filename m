Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B29BC197A0
	for <u-boot@archiver.kernel.org>; Mon, 20 Nov 2023 08:49:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3BAA87250;
	Mon, 20 Nov 2023 09:49:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="VLI+S5p0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE7DC87452; Mon, 20 Nov 2023 09:49:24 +0100 (CET)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF58E871A0
 for <u-boot@lists.denx.de>; Mon, 20 Nov 2023 09:49:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-99bdeae1d0aso554019966b.1
 for <u-boot@lists.denx.de>; Mon, 20 Nov 2023 00:49:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700470149; x=1701074949; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=x11i7CrRe/PUshJkwT/zA5eZ8S/Yx3D/JabYmmhj6us=;
 b=VLI+S5p0Fpd67B5lDoCu6FpzfkD5XAB+gXbELMZm883FuXjhYxkAaEBj2bvktPObkJ
 MVfVt0IyAGTPxVdZD2WRNcmuaY+UYli/8PIJeuWktvt40anumwwlnCIdLmpVnK6Qgq4b
 q7F2tFF/iqQ7THBWHx2ytAt4SGjUyAdf23t1rOdbgYZKinhd31dtcn7B7AlP4ya9FrN4
 Fkpopg9CXKxh336ZA9rGMZCIrmHjbGMnEBqmNUumolE9cK8PwWKhfuSBQ23AEzJHj7SI
 Wtt6oPTGnDbtsNWs6KtUsd3EdkaxSvbwHqHvRrmI1cl7OPyN5L5b39BmaEmeEdf0XZbk
 CpXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700470149; x=1701074949;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x11i7CrRe/PUshJkwT/zA5eZ8S/Yx3D/JabYmmhj6us=;
 b=gLmnTLlH7Te5sYgRMIPuF/+cRbt6DStNUiST2mu1sfvGbzyZx86h8uh1N6fs7xrPL+
 jFiHMVkc692Re/Z0qsIkE8X44Sbj3xRmZeZGgRuH0ojdi4bEnYrqUAYCQJHE10n1xl4r
 hfjeWHriWv/em7ejiYCJnimBNJ7whdw/vaFeus8TkdIiJh67rbM9WCqch5VWWUw0fhkS
 nRu+COlnsFddKBqtIlzYX9hvP5AE7oWtoWbUvI6Pwr3iB605qmXSp+5YjUCljU2arcb5
 Z0EDY7zIj9DqcfXf6SV3oQGx9vIm6WoxeTdy4Y8xZ2yGDYBs6n6jHsS0Zk9/nuB+we6z
 qIRw==
X-Gm-Message-State: AOJu0Yz9e2z5xRnYIuYRWK+iVUPj/nGhYg5WnKwuN6Cj5hr+y89BC+Ch
 icddC+7Dm7Clz0uBmOpidgPlnQ==
X-Google-Smtp-Source: AGHT+IGzJD6oonKdWNVZVhns9ANq0STwqkbTtxjsOHqndXjxF+U1/oAf6bis1Qi3597Fu4+GU37K6g==
X-Received: by 2002:a17:907:8692:b0:9be:fc60:32d9 with SMTP id
 qa18-20020a170907869200b009befc6032d9mr5176960ejc.47.1700470149665; 
 Mon, 20 Nov 2023 00:49:09 -0800 (PST)
Received: from hades (ppp046103219117.access.hol.gr. [46.103.219.117])
 by smtp.gmail.com with ESMTPSA id
 q2-20020a170906b28200b009ad8acac02asm3703296ejz.172.2023.11.20.00.49.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Nov 2023 00:49:09 -0800 (PST)
Date: Mon, 20 Nov 2023 10:49:07 +0200
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>
Subject: Re: [PATCH v2 2/3] tpm: Convert sandbox-focussed tests to C
Message-ID: <ZVsdgy0XJeCxWPbw@hades>
References: <20231112004345.80145-1-sjg@chromium.org>
 <20231111174337.v2.2.I8ff77e0c1288f6a4da564e9454eb223f72809839@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231111174337.v2.2.I8ff77e0c1288f6a4da564e9454eb223f72809839@changeid>
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

Hi Simon, 

On Sat, Nov 11, 2023 at 05:43:37PM -0700, Simon Glass wrote:
> Some of the Python tests are a pain because they don't reset the TPM
> state before each test. Driver model tests do this, so convert the
> tests to C.

The python tests restart u-boot though. The problem is a bit different
here. Python tests run late, so if the efi subsystem runs first, future
tpm_init() calls will return -EBUSY.  Perhaps the dm tests run earlier?

> 
> This means that these tests won't run on real hardware, but we have
> tests which do TPM init, so there is still enough coverage.
> 
> Rename and update the Python tpm_init test to use 'tpm autostart',
> since this deals with starting up ready for the tests below.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
> Changes in v2:
> - Keep test_tpm2_continue_self_test()
> 
>  test/dm/tpm.c              | 77 +++++++++++++++++++++++++++++++++++++-
>  test/py/tests/test_tpm2.py | 38 +------------------
>  2 files changed, 76 insertions(+), 39 deletions(-)
> 
> diff --git a/test/dm/tpm.c b/test/dm/tpm.c
> index cde933ab2848..f8264af13789 100644
> --- a/test/dm/tpm.c
> +++ b/test/dm/tpm.c
> @@ -50,14 +50,87 @@ static int test_tpm_init(struct unit_test_state *uts, enum tpm_version version)
>  	return 0;
>  }
>  
> -static int dm_test_tpm(struct unit_test_state *uts)
> +static int dm_test_tpm_init(struct unit_test_state *uts)
>  {
>  	ut_assertok(test_tpm_init(uts, TPM_V1));
>  	ut_assertok(test_tpm_init(uts, TPM_V2));
>  
>  	return 0;
>  }
> -DM_TEST(dm_test_tpm, UT_TESTF_SCAN_FDT);
> +DM_TEST(dm_test_tpm_init, UT_TESTF_SCAN_FDT);
> +
> +/* Test TPM startup */
> +static int test_tpm_startup(struct unit_test_state *uts,
> +			    enum tpm_version version)
> +{
> +	struct udevice *dev;
> +
> +	/* check probe success */
> +	ut_assertok(get_tpm_version(version, &dev));
> +
> +	ut_assertok(tpm_init(dev));
> +	ut_assertok(tpm_startup(dev, TPM_ST_CLEAR));
> +
> +	return 0;
> +}
> +
> +static int dm_test_tpm_startup(struct unit_test_state *uts)
> +{
> +	ut_assertok(test_tpm_startup(uts, TPM_V1));
> +	ut_assertok(test_tpm_startup(uts, TPM_V2));
> +
> +	return 0;
> +}
> +DM_TEST(dm_test_tpm_startup, UT_TESTF_SCAN_FDT);
> +
> +/* Test TPM self-test full */
> +static int test_tpm_self_test_full(struct unit_test_state *uts,
> +				   enum tpm_version version)
> +{
> +	struct udevice *dev;
> +
> +	/* check probe success */
> +	ut_assertok(get_tpm_version(version, &dev));
> +
> +	ut_assertok(tpm_init(dev));
> +	ut_assertok(tpm_startup(dev, TPM_ST_CLEAR));

Replace this sequence with test_tpm_startup().

Probably a c/p mistake but you need to call tpm_self_test_full() as well.

> +
> +	return 0;
> +}
> +
> +static int dm_test_tpm_self_test_full(struct unit_test_state *uts)
> +{
> +	ut_assertok(test_tpm_self_test_full(uts, TPM_V1));
> +	ut_assertok(test_tpm_self_test_full(uts, TPM_V2));
> +
> +	return 0;
> +}
 
[...]

Thanks
/Ilias
