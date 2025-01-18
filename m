Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 896D8C02185
	for <u-boot@archiver.kernel.org>; Sat, 18 Jan 2025 16:43:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E99E9803CB;
	Sat, 18 Jan 2025 17:43:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LaYiSX+Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45B7780758; Sat, 18 Jan 2025 17:43:26 +0100 (CET)
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com
 [IPv6:2607:f8b0:4864:20::736])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28C4380312
 for <u-boot@lists.denx.de>; Sat, 18 Jan 2025 17:43:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-7b6eeff1fdfso284358285a.2
 for <u-boot@lists.denx.de>; Sat, 18 Jan 2025 08:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1737218603; x=1737823403; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q26jX9KIlszJAv2oebZQosIpScztjIq68WK9b/GW6q8=;
 b=LaYiSX+YslJM8OdmLb2Q7NzZnvvqIWulmM8USShoXt8SqSMguRl4DZkVwOsL/fQ7+V
 52H4BABL69WNKoGG9pDk6OTjDcB/jcIAGP2WQ2Ne53fhPtkU3VXbUbRv7aQ7jSaay6wW
 ql34P7jSWcVQejb5SY5DDGf5mcJpHPv/lje20=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737218603; x=1737823403;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q26jX9KIlszJAv2oebZQosIpScztjIq68WK9b/GW6q8=;
 b=C47IP+4cLrJb2Y7Fi5xFySP5DQF38Molb77kwYqD7j6i/9W43QJ7E5m58DSNGeMvLL
 lUWv8Lgi79hQ9+LOa3n6KM6FFqbOpSOzag13mr1Ptd2aZW5pkcCA2HTG+0AVfodQJ3lA
 /fz6cQR4sAT9tfVB5VWaWGvtRFkLIyveXgihm3VCxag43dOnH0KZ6J61x7K/cSH29bOu
 /AOGvmo/sODxSbzfcxCJWyK9e0LtEvvtdPcXF//zjo3eWK3jCK8ufNbkuYw6IbFPqlSV
 8zuJO09AHg7DHbUqIHrmpfnAIkkadgBcIwki+L8z5gRt3RtNw+eF+0CllWAx+Nqz4mDL
 ZMDA==
X-Gm-Message-State: AOJu0YxcBEnBZJX+gpVh6KDFMbhtwr/Z6LW3IOXrds3MfL5FEY3PUJ5B
 vJ7Oc+wdhWz5qn0Vy0ExYMh2E2eY8K3c3sfY9oOMcz0o8UI0NShvailqz/WgehU=
X-Gm-Gg: ASbGncu4858egkVnfkx2I50AuTk6Ay1ngkgn5ziuqYlYm3FMi3/rP4vEnRa5id34AQi
 nHzc4ghV2KDBNzkQW+KBijQv/+WUCpCRPfvTZOf/7SfHv34cvSoCSJF0tinOrMSpEkBxUJ/nDPT
 Mlh8FgQuUMX2yEq8ElHsq6GsuyN0P6+esqG0z8nEfr42ozrtodyd8lM2oCKomVr+k0eKdGJToxQ
 uChDJ0dhWqNzxKosBuKW6n/1foCAgOnkoEhbRgzjnO5McuHkSRPD2jVuIa3LlVPuQ==
X-Google-Smtp-Source: AGHT+IHOFP9Ng5EiVkuazwtaqSnunfmMNso0dST5sZ0o27OYPMOmG0ct/6pF1227hTIrHlNo0RGB/g==
X-Received: by 2002:a05:620a:1a88:b0:7be:3cf2:5b4d with SMTP id
 af79cd13be357-7be6320c084mr1184321985a.9.1737218602994; 
 Sat, 18 Jan 2025 08:43:22 -0800 (PST)
Received: from [127.0.1.1] ([187.144.16.9]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7be614f5b3bsm241061585a.115.2025.01.18.08.43.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Jan 2025 08:43:21 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Bryan Brattlof <bb@ti.com>, Greg Malysa <greg.malysa@timesys.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ian Roberts <ian.roberts@timesys.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Peter Robinson <pbrobinson@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Sumit Garg <sumit.garg@linaro.org>
In-Reply-To: <20250112223252.179123-1-marek.vasut+renesas@mailbox.org>
References: <20250112223252.179123-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH] Makefile: Make sure all linker input objects exist
Message-Id: <173721860014.2563206.14366414311567161166.b4-ty@konsulko.com>
Date: Sat, 18 Jan 2025 10:43:20 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Sun, 12 Jan 2025 23:32:38 +0100, Marek Vasut wrote:

> In case the build system builds a directory with empty Makefile,
> one which does not contain any obj-y entries, the build fails to
> link due to missing built-in.o .
> 
> This happens because of this part of scripts/Makefile.build
>  81 ifneq ($(strip $(obj-y) $(obj-m) $(obj-) $(subdir-m) $(lib-target)),)
>  82 builtin-target := $(obj)/built-in.o
>  83 endif
> which does not assign builtin-target in case obj-y is empty. The
> built-in target is then not built at all, and built-in.o is not
> generated by this part of scripts/Makefile.build
>  325 ifdef builtin-target
>  326 quiet_cmd_link_o_target = AR      $@
>  327 # If the list of objects to link is empty, just create an empty built-in.o
>  ...
>  335 targets += $(builtin-target)
>  336 endif # builtin-target
> This is the correct behavior.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


