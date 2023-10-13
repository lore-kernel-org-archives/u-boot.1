Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFF54CDB482
	for <u-boot@archiver.kernel.org>; Sat, 14 Oct 2023 00:45:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6EE2A86F16;
	Sat, 14 Oct 2023 01:27:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AonsOWYL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D466C86F4B; Sat, 14 Oct 2023 00:06:57 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F4E686F26
 for <u-boot@lists.denx.de>; Sat, 14 Oct 2023 00:00:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-9a6190af24aso425025666b.0
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 15:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697234440; x=1697839240; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fzt3WuWggILpExwO/A+PhWkL8UEGBSVg7I1kBJhze+Y=;
 b=AonsOWYLv6ZnxvdWaOeoxP4G+lSPvu2rzYj1rG32sUDkHMh2Fxsy5jkNDPP3kVe8fw
 92KpXWtOLUWd4qaVrTOgjg5a5CvcNmsqdAGuVCKQ5KxYrxblkCWVJT483NO5+WR7ty8H
 Qbw6M3/wQSPmfWsVWpY74kG/8aXwQd0SkWIuc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697234440; x=1697839240;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fzt3WuWggILpExwO/A+PhWkL8UEGBSVg7I1kBJhze+Y=;
 b=mumx3bzcvQbysV7S24FTyrDTFiQgAOBYaXoJGjEMSfNX8ck7P8E2R8nGALm0Cnbw04
 8ayvXzQ1CYv1xWAroArPaGcWC8Qe6E88hkQdsbupWhcm0krHbGHRmkMoJb4EReStU/QJ
 910rpSisXktnBgd5P+2ynSdm/2dQbd9LAYO7mJl6a5UGpqCMUhTLtzO+DG8wPxcti+SW
 1rMqBzjTTNuN6Pns31ZAstWO63Eaoj+JWnunzR+5vB+2iMLskLVcMxKYlIsatuTIs8EC
 /X5WBrdn8dKAHkHVz4vs4Nz7ZUAYCn/BzSbxbvQGcP7r0MhmNNkgjwZgWKKN/NkFd+wd
 iIJw==
X-Gm-Message-State: AOJu0YzLTE2nvGmkoC/F8KXueOPwDJ1ak0KWUn6Oe/mrKn47ik2vInOZ
 OTp/vEbRpXLEfpbv+dnYrbUFJEnN2QnjZp57dPeUIFW4ygnNPWz2fiA=
X-Google-Smtp-Source: AGHT+IEWURz+PbVdgihn/mrsS5dnAHSizTood20likGuEaXPLgFxHBW/3OSvSZaq7Xx05IQGYClIM6AtC11RnlfqxEQ=
X-Received: by 2002:a17:907:762d:b0:9ad:99a8:7c53 with SMTP id
 jy13-20020a170907762d00b009ad99a87c53mr23945538ejc.60.1697234440264; Fri, 13
 Oct 2023 15:00:40 -0700 (PDT)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 13 Oct 2023 15:00:32 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <CAPnjgZ0xfdjU9GWkFCDvU6a=hxBCXbFh7KrJzgBaaZOPqicSdw@mail.gmail.com>
References: <CAPnjgZ0xfdjU9GWkFCDvU6a=hxBCXbFh7KrJzgBaaZOPqicSdw@mail.gmail.com>
 <20231010091059.375036-1-sughosh.ganu@linaro.org>
 <20231010091059.375036-7-sughosh.ganu@linaro.org>
Date: Fri, 13 Oct 2023 15:00:32 -0700
X-Google-Sender-Auth: yNUBKM9FkLHJEP2vg410O8t0I2o
Message-ID: <CAPnjgZ1fT0q+LLxqH_TVZH_jL0_Q+SMJm6GXmx7h0X41y3Y+9g@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] binman: capsule: Add support for generating EFI
 empty capsules
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@linaro.org>
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

Applied to u-boot-dm, thanks!
