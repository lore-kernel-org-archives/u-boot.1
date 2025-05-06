Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE049C3ABBC
	for <u-boot@archiver.kernel.org>; Tue,  6 May 2025 18:06:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F615820EB;
	Tue,  6 May 2025 20:06:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="iZ+vkzpi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 856A58214B; Tue,  6 May 2025 20:06:11 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADF5E80BAE
 for <u-boot@lists.denx.de>; Tue,  6 May 2025 20:06:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5f4ca707e31so9668489a12.2
 for <u-boot@lists.denx.de>; Tue, 06 May 2025 11:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746554768; x=1747159568; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=H5omYjhbU9smn3dDZATIEnjUBSIGIj3V75/tIvIfeN0=;
 b=iZ+vkzpiPQZd+qbluvUkTZ5T38PNZMqjL7xs9UYOvfVDFp28H9u/4TzDnafRgaI/8E
 1LGhA2DcRYiDFVeXg+jqDdzNY9H/WW073g8VdtHm2+F+74qEF3Iebn1KLES+dH/LP7Ce
 tELcGbKGFkGO2/aC4lyRCSlV4eIQe9oAdD1nc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746554768; x=1747159568;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=H5omYjhbU9smn3dDZATIEnjUBSIGIj3V75/tIvIfeN0=;
 b=pwugWdjtQowBDFyi0f5fZdZewLwUBRC6Yxk7BmKgStTBvXd6UvBB4bwM1UO8psUzQ1
 ZU8os9W/EWZi2IrplL+/dvR7+tXPb+Y3bvr4V6hukMgWFV61uOKWyQuvPo+DXXwkTu6r
 apg9aMWSJHLhXJ+bQ2mW38f1YawCWsr21TxkV2MAVpjuoBL2MQk5gqIlOPEwGVTWaA6m
 vYKwplqBTuOnrRojvd4gsw+eP6nbs03c4WLWxO9s5C7SvJPJrKfSJRFrdtVLlDhf8EZp
 stGyn9e0SssG5EnPmWBZPAZaSvlXCXE6ilJcGVzloYuWncSBsJ4RrmnBqYh4yBES2jbH
 M6Kw==
X-Gm-Message-State: AOJu0Yy5hCU4KZRVAes783bqTc1spC+CDFZqTTyqkAg4FRIv8rfIVuIH
 oJV8Hpy8fdy43u56itLluJjOQcA5wJtBWyKLU7LEiis9p6yJpLwpNEtRzyIhR0bZui53sWiR8Gh
 tB2YtZOAI/xKJRFc92VFGQsnBRAlWFtUePkGFxjev6LOMj298mPaMD8BPbA==
X-Gm-Gg: ASbGnctYwMMv2iUpBNs5zIUctX/8W7QJZdHa174xw1h+LU7PXDTJPhbV7BnlqMyhFFO
 IdCI/u900xo7tIjmQR4L4XPDHK88ypfqItl3zLET/nfuhsD3qCP2w5nrlqRvDMAw6P/55r98Qsu
 bEPiTK2ziRS6Z4iuISzJXsjb8=
X-Google-Smtp-Source: AGHT+IGoTjL8b56hg1gLSzVi7183aOVj0yq94W4p7jG+yzrlkRLOm+qOADAFdjSorakM3UXp5NqDwH6qdVwva8IXSFE=
X-Received: by 2002:a05:6402:5213:b0:5ec:9e6e:c48f with SMTP id
 4fb4d7f45d1cf-5fbe9f6a1bemr194756a12.29.1746554767975; Tue, 06 May 2025
 11:06:07 -0700 (PDT)
MIME-Version: 1.0
References: <20250506140412.190005-1-trini@konsulko.com>
In-Reply-To: <20250506140412.190005-1-trini@konsulko.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 6 May 2025 20:05:55 +0200
X-Gm-Features: ATxdqUH9bgP1ib8Y_pjpkzF5e3-SdwxEXinJDCzKonTpS1CzymF1axlQgDRHmzY
Message-ID: <CAFLszTjBxQYtxwVmrLEzFUcqK+kYd4kEKu0QY_7zhj-e=EdMEw@mail.gmail.com>
Subject: Re: [PATCH] Gitlab: Rework sjg-lab calling test.py to be closer to
 test.py stage
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
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

On Tue, 6 May 2025 at 16:04, Tom Rini <trini@konsulko.com> wrote:
>
> There are a few differences between how the test.py stage invokes
> test.py and how the sjg-lab stage invokes test.py. As a start of making
> both the code and the output and artifacts similar, this updates the
> sjg-lab stage with the following:
> - Pass "-ra" so that we get the summary information in the job
> - Make use of TEST_PY_EXTRA for passing "--capture=tee-sys"
> - Re-order some of the arguments to be the same order when possible.
>
> And most importantly:
> - Create and save as an artifact the junitxml output.
>
> The last part here is the kind of test result information that in the
> future we should determine how to archive for future reference.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Simon Glass <sjg@chromium.org>
>
> The JUnit part can be seen for example at:
> https://source.denx.de/u-boot/u-boot/-/pipelines/26106/test_report?job_name=jerry
> ---
>  .gitlab-ci.yml | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
