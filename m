Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F1F9CF2591
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 13:16:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 104D883956;
	Wed, 19 Nov 2025 14:16:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lpUa8/oN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0112B837F2; Wed, 19 Nov 2025 14:16:24 +0100 (CET)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 04B2983DBF
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 14:16:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-b7380f66a8bso604875366b.2
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 05:16:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1763558181; x=1764162981; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sjXeOeMLIl5XtTbxP7JmDA+nndGr6dBhMRoDafqHAB8=;
 b=lpUa8/oNjgVrRzdtRzGgTfrs6Hk6jSiiw7b59nB2rpkrejwyrddTpqEW/ugRBEJQnW
 lulAxOSC9nHcYZLbVZl2/AmcbC273HQCraTzF4Sk/CEBqCh8qPfM4lMPhB6q+/5H/LDr
 hTaa9H3odxQuQWo6oh+PbvKDDCoxV7lNoIdBI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763558181; x=1764162981;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sjXeOeMLIl5XtTbxP7JmDA+nndGr6dBhMRoDafqHAB8=;
 b=ucrafCDWEVoka7sPmj8MLVVfPkTk1UruNziv20zd8ged1zWeOFZkXuV65KNz1YK0Ti
 wjJTec7uP9L0heSMK7gEWUYO5naE2fb7tfDlSXHm+MYTw9HBV/ETRiga9Ce4SdOFN6Mk
 zy2VS79B/nuKAMUp8bZ2yKlCe7j65G02dyPezW05VkatM+tFMbb7sQmiKU/H8T2myE0n
 ZyzUNxwlD+EBi9o1PaMZZGNVWYDgVb7gzI1EPZZLFljhuHbz6nCQYHjm/y1jWYjlCx6x
 PD1/hZcVYZZ35saO/vya4Zb2/Ukf7rqG7W/gmYi31sAtwgkm+bE5jPrV5sm+ZjAzRjXj
 KxgA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWeJf6doPDW/htl5UPl7uQASMPil6QIQDOmYlDC4o7UzqtAt6sA3DD0WevuRElFKmaYjhT33xo=@lists.denx.de
X-Gm-Message-State: AOJu0YyQ4LNJktXlMPjLu/PkVSTWSAvCO+SnUnymqLVQ9xir6vNnDnKi
 GRRD8LNnj+lTeXWAYGxiihpcw5M30kVc3vr4veJy92clHiT1RNtxufLPAUVMntWO861LJZwdLqq
 T/nVVbZUdlq1LclaMnq8v/wd6/vzSKzCTfGO6FF6o
X-Gm-Gg: ASbGnctKR/TVj2mz3exdl5WoIEDz1YrzREC3aHxGbybSjZsRUtilvbjfXOiPMl31F0r
 GYSwKQJUWPnaL8UqPKmF3afj4RWttQgtfcIkSvhgYQe0frdk/m9Ffaw2omQFV7yxttuGCgY0y9J
 fY3w11G1ylbXNAOOT+O0DNVxHKBFPs9ROFBmR191e3QAIAYQxQ8kpGnzENvUdm/lEBmWRozAAH7
 I+YuHtjpn7QTUYFd/YvRxJaHaHFIJ75G15JyYBkt/zDAtcvFt3psXVf5XTRw7FRK/DETXG/Tez9
 I062
X-Google-Smtp-Source: AGHT+IGSP7yRJwnr3CgOGwu5Zh3oNr/p/F+FbO22mYYZvbzjIHd6IvhoOEljZStWhkD8ufjhvCYrNwZPMv18fi2WChA=
X-Received: by 2002:a17:907:98a:b0:b46:6718:3f20 with SMTP id
 a640c23a62f3a-b736793db07mr2129554066b.48.1763558181060; Wed, 19 Nov 2025
 05:16:21 -0800 (PST)
MIME-Version: 1.0
References: <20251118201733.67297-1-heinrich.schuchardt@canonical.com>
 <20251118201733.67297-2-heinrich.schuchardt@canonical.com>
In-Reply-To: <20251118201733.67297-2-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 19 Nov 2025 06:16:07 -0700
X-Gm-Features: AWmQ_bml7iK4D7mfojAzuKho0ljXQhQNZhU_v9F9nwi7ujevL9HC1kT4NTcGakg
Message-ID: <CAFLszTg5eg4cbWGNtrqjCFo0YrZbaN0nssR2TkUOMX==wZXwpw@mail.gmail.com>
Subject: Re: [PATCH 1/4] doc: make writing DM test subsection of writing C test
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de
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

On Tue, 18 Nov 2025 at 13:17, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> A driver model test is just a special case of a C test.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  doc/develop/tests_writing.rst | 55 ++++++++++++++++++-----------------
>  1 file changed, 29 insertions(+), 26 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
