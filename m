Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C4CFC3DA45
	for <u-boot@archiver.kernel.org>; Sat, 13 Jul 2024 15:16:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB91A88898;
	Sat, 13 Jul 2024 17:14:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VC/mNf6R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79C7887E13; Sat, 13 Jul 2024 17:14:22 +0200 (CEST)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com
 [IPv6:2607:f8b0:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E1938889A
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 17:14:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-70b0e7f6f8bso2607373b3a.3
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 08:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1720883659; x=1721488459; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=duy3pGMoCtgk5D+5+htXwjl/B/fObhv/vJQ3MpeBfW8=;
 b=VC/mNf6REt3mvFSntUeOtiyDUzrUjNzLKtVRBfJvgoebBtdom0ZUHj4oAUndSCyrB+
 0A20d37CZOyXT0wNf+ulWF+UAG4DVUvvcP5NHuY4igC+hjY8WnL2/CQmkzzsLki+rmwj
 oi+dVJfQPrXj9jUeC1G+cvY4rL3m+zH1raMd8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720883659; x=1721488459;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=duy3pGMoCtgk5D+5+htXwjl/B/fObhv/vJQ3MpeBfW8=;
 b=WPzVMuXJnyrhzfI4FDUdjN5frlIlamYu1jzu8YWdRXenW9OA9/BkuXDxEkTtbYg2UT
 L7iywTPYY1JaKL0AwCIRO7qQw4HuatQFH421FQJ6U2FoioaRMitgPNYcaPjyXn8AxM6n
 3paR5Ohdj4D+t9gZd5bbLXfHmaNCr7hDesyGqOjGUSzjP5b/uTexKBFKE4fJSYXHEkRb
 UryXOB9n9qmGNXD7G4pZpDvN4wKh+uodllr5/Bj4/5HgblA49qKlXdib52D5OaksNwhi
 VVMdMta5VHcGJg8LgxkfVNAQqB+0SYvYqqm0rSpdEvPeSzx5siUZRhMHOXGOsVI33zDg
 2HZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWheUtnS0U1SXBJpNV8lnd0wIRRbsI3x+DzButcNptbNM2JsRl7zKrD6DB2qSprSl1zjcjlmyAweNF9PLlF4kmhPI69mg==
X-Gm-Message-State: AOJu0YxxZtpQaRBhJB7ug0nk8gr2rNRTs892Iz2brg/+3PlAtToLtNly
 MpXuJDSheCvmBMeADl1QDNE1sR3R43IT0/3/z09PVQ0m5KLNSLLTcsCfyLT5UqXYNvHuBWlRDOt
 ZZJ2itB6E19dRO+qPNR595F9OKZ1hUZ0zPg0L
X-Google-Smtp-Source: AGHT+IHKliWBDeNyHMlcSpJSDaKqvmwmPW6eSHs7+PNatImq4tVWlVqb3jIZhIigmGlCGmvzfQZQ2/tyr0h7BGTJJz4=
X-Received: by 2002:a05:6a20:7f98:b0:1c2:8eb7:19bf with SMTP id
 adf61e73a8af0-1c29822de09mr17050822637.37.1720883658812; Sat, 13 Jul 2024
 08:14:18 -0700 (PDT)
MIME-Version: 1.0
References: <20240710-bootmeth-android-v3-0-b99406e22da3@baylibre.com>
 <20240710-bootmeth-android-v3-2-b99406e22da3@baylibre.com>
In-Reply-To: <20240710-bootmeth-android-v3-2-b99406e22da3@baylibre.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 13 Jul 2024 16:13:45 +0100
Message-ID: <CAFLszTiY71XHozYOGA8iy1Y9EXFDTQz2C2R2bU1GSdK4y2x8Bw@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] bootstd: Add bootflow_iter_check_mmc() helper
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Julien Masson <jmasson@baylibre.com>,
 Guillaume La Roque <glaroque@baylibre.com>, 
 Dmitrii Merkurev <dimorinny@google.com>,
 Roman Stratiienko <r.stratiienko@gmail.com>, 
 Igor Opaniuk <igor.opaniuk@gmail.com>, u-boot@lists.denx.de
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

On Wed, 10 Jul 2024 at 09:40, Mattijs Korpershoek
<mkorpershoek@baylibre.com> wrote:
>
> Some bootflows might be able to only boot from MMC devices.
>
> Add a helper function these bootflows can use.
>
> Reviewed-by: Igor Opaniuk <igor.opaniuk@gmail.com>
> Reviewed-by: Julien Masson <jmasson@baylibre.com>
> Reviewed-by: Guillaume La Roque <glaroque@baylibre.com>
> Tested-by: Guillaume La Roque <glaroque@baylibre.com>
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> ---
>  boot/bootflow.c    | 12 ++++++++++++
>  include/bootflow.h |  9 +++++++++
>  2 files changed, 21 insertions(+)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
