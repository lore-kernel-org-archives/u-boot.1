Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77EC8606A31A
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 13:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=wLrnF3sW;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=WUbO8JcW
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9B1B6608B6;
	Wed, 21 Oct 2026 13:07:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 93czjycaY2DS; Wed, 21 Oct 2026 13:07:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3B8E5608C8
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792588029;
	b=etKfUihGcWlaldwhg81YtA+Jzk3LmjhYDyuFDPPzN7qTbLM/QbrTtW4YVIrC9od3M4bV
	 TCKw57T60NRqOKBQgKvLv5dLYmZ6eI0A0PBj7uVi+rG+nfapDsIieuMKpEbV0QPseZF/l
	 lyAYOeWm7Bac/LvKwxsZhNf8DWvPFJZMwV/+ND4oAAd1zv9tWmf7+11CyNg84hXdXDVg+
	 CpX8g8aPdpTTW6ENIMzhbSeoBVEb/hVhQTqlw6pC0a8gwqujtoW1GDRGsxwnLHvFQUAKP
	 +iFVfvt5eoGgxKUKe/fmHsOSXCelnANyeVHPYzTUnwR5cYMGlNDWrVKHWRALMt726Wg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792588029;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=isKPLU38IQtHXHXTf5Mo3FfkLYl+fZdhgge54EpoqPM=;
	b=Cul6z9OkG6sLIDb9OHUsQaNPx82pvFXPJ754WqrQRIA//pO2VUspTqZm+O4Ab/wfqNLX
	 Vo6ZmYqX9XzTGHTNd/go9X5Zx48KeBQni2uSPJEl2lRSweZ2bLgUG7tyS4XFGiPmxSvKq
	 /0dmY5IXt/wexGNic099EmRe92N074wzpaIt8gh6VZGH/3hgi2zFn9mbNU74GbdufUXk9
	 dWbQW/dpwavMkfST4kwIDicXUSEkLSUsN3zXa/H2AHy0HbCm4os02DCIqR5fOjJZHfqQ7
	 Jj9Gmj3Oa6skE3R5Lget3b6niixAtIQ0q+FvVJPzFDXvHnJT5zwzZQ6LsaXdWjjc9Vw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792588029;
	bh=isKPLU38IQtHXHXTf5Mo3FfkLYl+fZdhgge54EpoqPM=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wLrnF3sWtsxayXE+LAJblpNk889KTghKGNQKK+UBZFGYAACI223SDYRZje3xcgyt3
	 hKq3SIUWJzHBdRvYIV51F2fNTf9oBh2sCAf0fmHSnyVgMcmm6YUtdnzPGBM6JhJpIr
	 ZpKd5XSqRnkLPn4hJV0BMFtmB5gWefQXsZBx4c7JDg+Tg4zvz4xQq11Bng9l/JAgrp
	 DjP6H6EyGFQ7f3Bvy52emm3mpSjtqrmpV4Wwpycd5j+O17Ocnt4rsuP/mYaWLnGb+c
	 z7VNt1w6hugdZqgyYqhOfb3fF6nsSlsqliv1DeuOy8RoxWzwkVGHIgHREbFi8pocz8
	 QENu91XT2y6PA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3B8E5608C8;
	Wed, 21 Oct 2026 13:07:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id D02C7930
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 13:07:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C159881134
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 13:07:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qlIQvpoqQpr2 for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 13:07:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 96FF880F50
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::529"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792588024;
 b=s3y0cvVv3LB5YkV3Q8EwYkI1wbThgaFBixJ6T+/Xz27Y7s5DWE1OnHUTnvU8ZdYzvGO/
 mM3nCcIk5Z8qHJBKp7LY9E3bt6yqcNzXagFrnXrBylF3Wr357fW93xtkw5ZQCFEVrhy1x
 DalrajZkx6CJHmu3kLK0mYL6ob5NHYCd8jiVd+84Z9wpIgwF1vcXzs66BLB9+qc6QyBK3
 SirzCFecVW3JIZBndejUWsz7PX4U/MSYm6U5riqZiGUSTSn+HEyae4Z3J3bu81gRnH056
 SGI2yAW2SQd9mL8VVLtNPwOQK6oR3c9sl84D1YiizausmJBIg8MG/ju0CM6hLqIM3qw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792588024;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=isKPLU38IQtHXHXTf5Mo3FfkLYl+fZdhgge54EpoqPM=;
 b=gs1eigrnpctga5L3Z5aQqxxb9set2H3Z6hAi34gjzjp77AEEXSq2uXyXjIpynqY2D//D
 fPrDHnQ71LsPFH1CmJM9Uc6mye6jTYW36vJ1kQTV1TxAlDllfkAEHHOAfVLsPfcGFl8rF
 yewQ+x13HN7PX/nHogbefdMuVHCwJeM52J2j0qhsXSaY0UO7K9Sc4qGIdNYnG21dRPrmq
 z1eoRDmT+oEMfz8Xh/oNOR8dgfYVn1UgoVFSn7NuLcF1fY2YURJ5Y2yp7rNATRrL/LxLh
 W96IKKYFmxUAc/yGHH4hLytMVIV2AZpMNsMxfCmiVt0s7hXjT+mDVym0EH+0XmFQtng==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=WUbO8JcW; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::529"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::529; helo=mail-ed1-x529.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=WUbO8JcW
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 96FF880F50
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 13:07:02 +0000 (UTC)
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-6b413b0a974so446314a12.2
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 06:07:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792588021; cv=none;
 d=google.com; s=arc-20260327;
 b=KKYh0l04VAbihsOV035dKouxNKY10RJcvYGc4IMv42nVseLQG+TJzC5+bivR+58PsU
 VogF1hjYE3M+mIddr89apQfhSMmlG9TcGg69XKLlFZ7IBvFM/0EPMvOotJa9kzGRTXQw
 HbSjYjjPxrnEEqMHP09TgNrVQlfTpDGqDqiuN6Zj9fKdn6M3kpGZboDL8rFLjAjuFXZL
 S2kfVfuqJWKQHtsdWWQyGOUNI0JSrmR77szyeUtqaqEyPlHRSVG3o0BjacJAUFElEJ5N
 Sf3uBIjudwhWpzOzf2kF1AiLuda23G9RJUHUD3in/MQqW9OnVyEuSLxeyfaYEbfpL+jP
 ZCUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=isKPLU38IQtHXHXTf5Mo3FfkLYl+fZdhgge54EpoqPM=;
 fh=QSz2LWxXxIlE5sVY3cc6rCrz5I3EPoPd6wg5hM7ii44=;
 b=WZRZC3LlksjBc/ovWXktXrKjqP/ZSxcttD8zyQUy2Fe4tKq1TEnKE6gLH9I2H2WGlg
 C3Bj9MTcuFF7He6Bdva+7rh96CcaWGRfeeDEoTE3+VzUWI2xWV73Sv0NzZvBZOengyQv
 KVaOZI9Ur30cNatFlDfhY5KrkWuicYPiUiLbrawrVL90BYkK0U9S3/x7OXRQRxvxksya
 SwAmxpRpj74+h4rICykEF46psPn3vuK6RdglxQMAfNxlH8C4qMBgOsgFJpuexQ0xhwQR
 /R+KyhglBVMvP6J448UZVuQsaWNfn3G2UFGJUcFXciW85+CbVF0vL+K7LW+gdBCnO0iN
 AtdQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792588021; x=1793192821;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=isKPLU38IQtHXHXTf5Mo3FfkLYl+fZdhgge54EpoqPM=;
 b=WUbO8JcWeI2Ap01YXfy6zmziTvTY9gfJiGMR0VN1HXrDdKu4CBturomEkr9NhTUSOr
 +VRESp6nAM96wzDTRFLZLjxFal416gtV2e2KYtYtiQ8hNd/wb8fhnfYUdgYVXZM4wMBa
 bLz6RIpd7s6QmAOsDUYc/Rlf0hffudvGS1iJU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792588021; x=1793192821;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=isKPLU38IQtHXHXTf5Mo3FfkLYl+fZdhgge54EpoqPM=;
 b=04ltj9twhpfk7z6+EjpWcof0Qxh5XN+AxeLXK4T9nO2ZOACcBVklB4PkmQrkhorB4S
 PYACLpnw22rsdPM0VA20yti78iUP/N7VayzSBrPCi/2I4L0fz5FlHkU9TaxehSvHaR2M
 e+QcxpXjJ1/eI531Yc/xC60L+K2wQvZhwj0fRyFjfP7fwXk0Piz/x2d7/ywNngkhwVUY
 HWa1ZPvR8Qd/1x1W/Lu4sSLRLOI4eK7UXDQcDVZcx0WkfZusIWTn0pR0X8rRKhLME2vD
 4vC8PvCG4Bb4m8K8mdBuh87TmCGBE/MtcCqTwsLoEJR5QXDkeIW0bDkeRo1HAv6iOpuQ
 KZbg==
X-Gm-Message-State: AFq9FYLfpbXH/zc/eo8NPudZ6sZpVNoj0ZMT+yDGjVOuB5YygSeEY+rl
 FIDFMkCxe7ytVz2uvqlTcQlIZy5JuI0VHHSfs6bmAGSe2n42o75Z0Vm3nz/dDZJlQIn7aQEeqQP
 G8Sz4gpF3d2K4NYn05J2fhVPro1kXofMurYomJlxJ
X-Gm-Gg: AYBFou2ZXNwBF0LmLrwaC23IMoRly8b7OsBQWlyBmUNu8uCUyeu/wfskii1jcxG+t87
 +Xhyz4po0qyGLdsNYjrfvmBklc44+16DOCkGCKAnNbvpl0eKFIF3ZuQW+l+Bn91FEGpGHaTOV7e
 jhZT1hAZ6lwOoijUGiYff4PsJqoVw66p5lD5KUYqpKiFWOyXwBggubiNfcvtJDtRFcD5iFqzhDO
 sNuhBkDSCsOW3M1POrdvuiy8TloqeibmSjZSViCCHbXd/qnvS3+TVLktXlEE6JRDBCeYlMQ0sqk
 tB3CMTiqyzCFO559rdOjElarVioiBH+Ym7pxYJ7CJXjcClCaVap3RLJuK0ypTdVsj2E6jPKJz3i
 LWcQr9Poe4kmnmuMWiVQwVrIVKqUu/r5a070=
X-Received: by 2002:a05:6402:458a:b0:6b3:9b66:2bb0 with SMTP id
 4fb4d7f45d1cf-6b408ed537fmr1518498a12.33.1792588020752; Wed, 21 Oct 2026
 06:07:00 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 21 Oct 2026 13:06:59 +0000
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 21 Oct 2026 11:42:33 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261013130235.3172204-3-hyyoxhk@163.com>
References: <20261013130235.3172204-1-hyyoxhk@163.com>
 <20261013130235.3172204-3-hyyoxhk@163.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 21 Oct 2026 13:06:59 +0000
X-Gm-Features: AclHuK9pbh-Dhugd2---ANPWxuXpaiRBiCCPnFGOkMcaDVuRsGqIei76ccitEhM
Message-ID: <CAFLszTjMskpor_2=Csriy1pg=c7SnNz-mTVrDY4hOKZC_Oo2DQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] bootstd: Add a bootmeth for scripts in raw
 partitions
To: hyyoxhk@163.com
Cc: u-boot@lists.u-boot-project.org, sjg@chromium.org, trini@konsulko.com, 
 alchark@flipper.net, daniel@makrotopia.org, jbx6244@gmail.com, 
 quentin.schulz@cherry.de
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
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi He,

On 2026-10-13T13:02:35, He Yong <hyyoxhk@163.com> wrote:
> bootstd: Add a bootmeth for scripts in raw partitions
>
> Some disk layouts store a U-Boot script image directly in a named
> partition, without a filesystem. Add a script_raw bootmeth to find these
> images without a board-specific bootcmd.
>
> Read the image size from the first block and bound it by the partition
> size and configured limit. Support legacy scripts and FIT scripts with
> embedded data, using the shared script parser and execution handler.
> Validate the FIT structure and reject external data before verification.
>
> Keep raw-partition scanning independently selectable from filesystem
> script lookup. Document the configuration and self-contained FIT policy.
> Enable the method for sandbox and test it in C, using a generated GPT disk
> with valid images and malformed or unsupported images.
>
> Signed-off-by: He Yong <hyyoxhk@163.com>
>
>  MAINTAINERS                           |   1 +
>  arch/sandbox/dts/test.dts             |  12 +++
>  boot/Kconfig                          |  26 +++++
>  boot/Makefile                         |   1 +
>  boot/bootmeth_script.c                |   4 +-
>  boot/bootmeth_script_raw.c            | 183 ++++++++++++++++++++++++++++++++++
>  configs/sandbox_defconfig             |   1 +
>  doc/develop/bootstd/index.rst         |   1 +
>  doc/develop/bootstd/script_raw.rst    |  51 ++++++++++
>  doc/device-tree-bindings/bootmeth.txt |   1 +
>  include/bootmeth.h                    |  12 +++
>  test/boot/bootflow.c                  |  84 +++++++++++++++-
>  test/boot/bootmeth.c                  |  31 +++++-
>  test/py/img/__init__.py               |   2 +
>  test/py/img/script_raw.py             | 107 ++++++++++++++++++++
>  test/py/tests/test_ut.py              |   9 ++
>  16 files changed, 518 insertions(+), 8 deletions(-)

> diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
> @@ -187,6 +188,10 @@
> +
> +		script_raw {
> +			compatible = "u-boot,script-raw";
> +		};

Adding the bootmeth to the bootstd node means every existing bootstd
test sees it, which is why this patch has to touch
bootmeth_cmd_list(), bootmeth_cmd_order(), bootflow_iter(),
bootflow_iter_glob(), bootflow_iter_disable() and
bootflow_cmd_scan_e(). Please can you follow bootflow_rauc() instead?
That test binds the bootmeth with device_bind() and DM_DRIVER_REF()
inside the test itself, so the other tests stay as they are and the
new test can run on its own.

> diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
> @@ -222,7 +222,10 @@ static int bootflow_cmd_scan_e(struct unit_test_state *uts)
> -	ut_assertok(run_command("bootflow scan -aleGH", 0));
> +	/* Exercise the filesystem methods without global-method scanning. */
> +	ut_assertok(bootmeth_set_order(IS_ENABLED(CONFIG_BOOTMETH_GLOBAL) ?
> +		"extlinux efi bls" : "extlinux efi"));
> +	ut_assertok(run_command("bootflow scan -aleH", 0));

This drops the only coverage of the -G flag on 'bootflow scan'. With
the approach above, this change is no longer needed.

> diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
> @@ -1948,4 +1975,57 @@ static int bootdev_hunt_fallthrough(struct unit_test_state *uts)
> +	static const int errors[] = {
> +		0, 0, -EOPNOTSUPP, -EINVAL, -EINVAL, -E2BIG,
> +		-ENOENT, -ENOEXEC, -EINVAL, -E2BIG, -EINVAL, -EINVAL,
> +	};

This table is tied to the order of 'CASES' in 'script_raw.py' but
nothing says so. Please can you add a comment giving the case name for
each entry, so the two can be kept in sync?

> diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
> @@ -1948,4 +1975,57 @@ static int bootdev_hunt_fallthrough(struct unit_test_state *uts)
> +BOOTSTD_TEST(bootflow_script_raw, UTF_DM | UTF_SCAN_FDT | UTF_CONSOLE);
> +#endif

Please keep the /* CONFIG_SANDBOX */ comment on the #endif

> diff --git a/test/py/tests/test_ut.py b/test/py/tests/test_ut.py
> @@ -760,6 +761,14 @@ def test_ut_dm_init_bootstd(ubman):
> +@pytest.mark.boardspec('sandbox')
> +@pytest.mark.buildconfigspec('bootmeth_script_raw')
> +@pytest.mark.requiredtool('sgdisk')
> +def test_ut_dm_init_script_raw(ubman):
> +    """Prepare the disk used by the raw script C bootflow test."""
> +    setup_script_raw_image(ubman)

If sgdisk is not installed, this setup is skipped but the C test still
runs and fails because 'mmc12.img' does not exist. The other bootstd
images use sfdisk (via 'fs_helper') and are created from
test_ut_dm_init_bootstd(), so please can you do the same here? That
avoids a new tool requirement and a separate init step.

Regards,
Simon
