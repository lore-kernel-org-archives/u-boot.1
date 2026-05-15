Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EBDECD343F
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 13:41:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A00D846C1;
	Fri, 15 May 2026 15:41:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VFt/ZJTk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C756846C7; Fri, 15 May 2026 15:41:30 +0200 (CEST)
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com
 [IPv6:2607:f8b0:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D93F4846A5
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 15:41:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-c795f441ff7so6720496a12.2
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 06:41:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778852486; cv=none;
 d=google.com; s=arc-20240605;
 b=LJ9MdlPYU7JaWgxubwUDZVnU1E8l+3zeu9A1/mJvXVwP3L29EWZf8R05kLutyvHw11
 hBfcURbEDOmN4i5EN7+s6uILmMCeFJfOvKkea82hWavBtbICwcazxGKiaLgGVrWQD3Qz
 ACq9yArtW1jt5GBa19mWzT7tAyOPkuSJH2fq9TALYHnn6vrNJdedSJqCXzYfrYsBuoql
 DlXT62PV54QunCMxhYjbH/DX8hJPEdlMgaz8X4abZRhuaNjosZLjkUha9+miKatFrz2n
 vfpmzusm+hz9+p23AD+IHB/kUtVLpnJFSIlU9ArdAUK8waTkmA11DF13JWmYaqjhO+z2
 HYtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=VnMJDimnnkqfnqXtpVEx9mM1XtPs5gI6rAnphZa9hA0=;
 fh=PKLU0xSNpsrGOfl0gQ17G1VaKViMSq+Ysfr2F1w3zVg=;
 b=eZGTbPPIuFpFPikTWEML4BCYAelDsBoxFf6rwChMKj3c+/SvIQxcsAK0kGz5bjm9q9
 +kNWOV3VRZahswMIqbplD1Xy5jxTlWfJUWVNO6mvHmhNmfGq6xqJfoxiZ90x+XGcSdsA
 u4gUhIcqQjz6+w0e/Dbj94ap9/1xrxAsvtFduXFa9laNZjY3M2tgWzLAM+/SqixPe57v
 wnhyTPS/DzVQIrLIh04TSiifqtuXgDULVWhkocn+qL2Bq9otyUDYEWyD3l5hfNQX5+rK
 t7rwmXL10uE1zPuaGrWsLvMKKqm/pfv6U5iLAfiSpvDyu5vM2sQanqPrBAnhpG5caI0D
 gCGw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778852486; x=1779457286; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VnMJDimnnkqfnqXtpVEx9mM1XtPs5gI6rAnphZa9hA0=;
 b=VFt/ZJTkRv/DMxzOZgWZ1DR3K1AZ0I/y7jXisuGJYteYv0EPCWzLzHsZTEerRN08JJ
 vKkWagOwkkfZlgKGrW1mvScIBwzELM9p+QZK5LBBfXXolMHTjDIKoZ7K2pcyqvs7EZS8
 N7nmb40JIG7cFumVjlnrHteNMR8zfePUvr+AI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778852486; x=1779457286;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VnMJDimnnkqfnqXtpVEx9mM1XtPs5gI6rAnphZa9hA0=;
 b=GYENIDPIvdacBZdcTrKXdRQC7BdRLhvuXRfF+8+D89JbHU6Qt0c9z0UCmtv/DkXL0n
 lY7ha6HN3jL2GcWiudoTnkjnsKcS4/Ykkt6rS1wOi2GdYpZOWMIvfTvbv2ut2MPmJXPR
 PsEDwnXzOrTj55NdJPjyFRc/excsGN/nkxZ0rQ3Lur8Dh9qkPHiZ3QzZa8OEFP+HFRL8
 q4IzNo5hy41E1tTB5V5IVueMkMkZf8I63naLqTf6L3zctdfL03+cpQnDH+UzLGWjVKIb
 w5BRG8wXgLnlPLBzlfIwKPqwVx8JBxlgGAlTWVaSh/hrI8s9jhIMsfN1V667hHosCYuw
 eMZA==
X-Gm-Message-State: AOJu0YzQMGNIKfiYzxKppBaHGpaAajfGDoQl5wJ32sieZcqkDodPx/+r
 Nn96isquPrAjdUufyGT+eIrEDBCaBQKncspZ6yavD5+w4vHy6NDQ7SxgulXkF7XCPz8593AIa6b
 X5mEmAQhOD5QPSqTgbHehdSrLD8PJdEu/kd0ppkAGR3FDwW1YEomb2w==
X-Gm-Gg: Acq92OG84o7BdKemuiwk8VD9ZQvbW3uDPWCoe17m7AIb/JxdmxHyFRE5S+aoLffPRte
 xKxYMTbj3EyY/IJp+yJfT9IHFBRuQ14m7op4WXm2ni31/cHT3DJB9c7TwJ4nHNqc1/k8BiPXeyT
 I5N/4+jeccUxPFtzCyf5Ld6DkZbzVCqRth6EzBOspXAw5xt4Bhm0ZMKbUIh+0YJQINeqHyUMSUD
 ZeoxEcUZ7lINVQ3W7BPfvZ/T7sHXqworWlSjQsyc0jlf5Z/q5BXy28gIk/5aMpDDDifzeImzbwi
 7jXCJEVKKbtiYlnDR22HEM8KaKk=
X-Received: by 2002:a05:6a21:e082:b0:3a2:d838:bfdb with SMTP id
 adf61e73a8af0-3b22ebe19b7mr4568557637.29.1778852486371; Fri, 15 May 2026
 06:41:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260513141027.351280-1-ludwig.nussel@siemens.com>
In-Reply-To: <20260513141027.351280-1-ludwig.nussel@siemens.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 15 May 2026 07:41:09 -0600
X-Gm-Features: AVHnY4ILORNDixScbcUgKNqRk7NViJ_wPaASd-yJocFNLYxOJKe0bCJ_5MCqLuU
Message-ID: <CAFLszTifT1G2XwBvvTZPtrsBM47Y-DD1GFn8rx=ieRcTFHaN4g@mail.gmail.com>
Subject: Re: [v4,0/6] Improve FIT signature handling
To: ludwig.nussel@siemens.com
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

Hi Ludwig,

On 2026-05-13T14:08:10, Ludwig Nussel <ludwig.nussel@siemens.com> wrote:

> The tests were created with the help of copilot and manual fixups. I
> have to admit that the log output of those tests is not something I can
> grok. I've left the tags copilot added in the commits even though
> checkpatch complains. Not sure what the policy is.

Thanks for being upfront. For my work I have adjusted patman to drop these tags.

The "log output I can't grok" part worries me more than the tag. If
you can't follow what the test is exercising, neither can the next
person debugging a failure :-) I'm happy to help go through
test_vboot.py to help clarify things. You might even be able to get
Copilot to add comments, etc. in a precursor patch?

Regards,
Simon
