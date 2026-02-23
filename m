Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8335EC1116
	for <u-boot@archiver.kernel.org>; Mon, 23 Feb 2026 17:53:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F182183D8A;
	Mon, 23 Feb 2026 18:53:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="N7ZC+U+Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C536A83EAC; Mon, 23 Feb 2026 18:53:22 +0100 (CET)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96B608063E
 for <u-boot@lists.denx.de>; Mon, 23 Feb 2026 18:53:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-65815ec51d3so7500031a12.2
 for <u-boot@lists.denx.de>; Mon, 23 Feb 2026 09:53:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771869200; cv=none;
 d=google.com; s=arc-20240605;
 b=DuQxjA86iSBSlAX8dMhxfYvHKSpWH5nddV/Jwqp9LMv+ZakcITzJySu7wiiSx0JHrq
 RsjPm1fpr58XmR5hf94NbFOVEm9Eqfqk48vCu5THebhmsD7Ri3LPM2OOf0ABnl0Y76R6
 U4kFMVOMsaXLkFh+Mb7pdlMYNmHIGI9lfZzrV5vHucLU955vz7N3WUfZaAtdk1ye4TM2
 1xwl7b/FyOeSCwGouvD5tUZ8xV8qwRlcF7qu8+qXJDt81GsmL3g/ogSBNWDNbaMvoXcz
 M/qoCqmWAYLllKbdlf3ZqIgUdKmLDAa8ZJSdiqdn2SsZ6V8XXbeg52YcJWT3EB7kfI1U
 6mig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=KUDkSugD6xpMlxXL3gs3k5oMZHPZUKzVuZBiDmFyg2k=;
 fh=HnsLlpVhzwN7uih7Ak2yI4wYc3mQPSEfV2n79G1UCUM=;
 b=jOHjyxjwLMikVuR763HyFnwxRWgq9hyuvfe64ElewEnFNbDbraybjl38tigwHBp7hi
 XL6Pu089XHyOKInGjw81GJUAfIStFNbv53FVFaNeHXKC6AFULqHf4J4yo+lnyZck5vPW
 lgFuSTYD/JiwHGgDcc7y01kZ15YPEo2JFUhrEW7iR1edFKVVp1k7XfWiPRnsOqVw3Kna
 R4qJOIqgyjnFG43sLn/+2VFzS09v6RYxfgDn5aJFauDYypft0lHzJ84+Ub/Bddn9BiNG
 nVO2mSP5oB3MO4ObnqV6JuoCCe6V5Y6pJ+2cHzbmK78T72aiHuNd1wi2P9vXVzq15QWQ
 cU1w==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1771869200; x=1772474000; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KUDkSugD6xpMlxXL3gs3k5oMZHPZUKzVuZBiDmFyg2k=;
 b=N7ZC+U+QvnST5Zft8H1c/9q8tKkeVKYb1D/rxuSRWmFgRzzZPqQ3gNWBaQk5rrRzQB
 8RC3CO5ClOUNwJiCKEAXy/C/PpptKBe6vsnUglZ9DuQxAcaHC/yBQL2PvtBn7V6x21/F
 UcJETYye0Yk0IbTlfnaS5jZAaXG+GIXbxhsLc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771869200; x=1772474000;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KUDkSugD6xpMlxXL3gs3k5oMZHPZUKzVuZBiDmFyg2k=;
 b=cbzyrN/X5h4cDfBIJMMowzegH3EmAySXPkRt1KPy9hWhMgZB32htuo2o7gMwJCs/HN
 rNzCPz7cvduQ/SLeE3mtNTO5PDpo/NDuqiSDvKy3TihN9pS199Irn1M+Hdgj6VHaXnIt
 o05IH70oFtS8O9ObGDCxGK1PXwByVR5uNsScuNgrV6fcuqgqR26fpGCDAVGm9T+tuoS6
 G+HxWWfvkxXiRQyHHqoVvLXfR7ustEaC7UiFE1QE7Mqz+hchz0P18nd/diPVwnzobNg2
 rOfzqsO6unmZbbnDgcizVx78LBtcrZt6nlxxi2laFEw2lWm0PLP4mAHNXW+wHZA+SwIn
 uSfQ==
X-Gm-Message-State: AOJu0Yw+2ffqEB8svEBranUslpLpi4VKUcvPiv5p/vMsFu5qoG0Hvf0q
 AIo9lEWgj7OxuYjC1GIUeEO59hKBb3HMaqqXpIW8MJzferW0TOKAQqfEXZdURHxk7ET/1yXsNEE
 f7J3K6YTCo2rkMvljYIFmxSpIJj1rI5K7u8Vml4NJ
X-Gm-Gg: ATEYQzws0iZRUc0ubutcRMcRMoHp6z+jpm2qpPga+M1AFW00BtqgzyHT8xExAjOl2en
 Dnjo8n8BcGCZrH761kWyef643dNJ38MaEQz8T2l0Tlm47K3PRr1I2PW+Rr07AdHsMoNZKBVwGG6
 YkAPTeCnPLYiodsqbEAE6vK0j+WoJ6SDjlT8JHnBM7oSrtMcVVeguPmer32eJdMVNAN61joi/y2
 p2r+eL71iEcu6pWWvvmWgB8M0CwPrcXEEjTzeYg2CRFcaEq8IEdkZwaP8RqcUDB9GopZACa82Pk
 0H2dPA==
X-Received: by 2002:a05:6402:210d:b0:659:36b2:1afe with SMTP id
 4fb4d7f45d1cf-65ea4f167d6mr5866658a12.17.1771869200048; Mon, 23 Feb 2026
 09:53:20 -0800 (PST)
MIME-Version: 1.0
References: <20260221094252.3103034-1-dario.binacchi@amarulasolutions.com>
 <20260221094252.3103034-5-dario.binacchi@amarulasolutions.com>
In-Reply-To: <20260221094252.3103034-5-dario.binacchi@amarulasolutions.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 23 Feb 2026 10:51:11 -0700
X-Gm-Features: AaiRm50BQ0PJkIzYrPH95H9-QaswfZhNig1MG37p1caaxjZHFodoIJEzNKfEJk8
Message-ID: <CAFLszTgP69Q3y0rTwubeazy14PYq=NTAeXriKJzAmpp5kzcRKA@mail.gmail.com>
Subject: Re: [PATCH v2 4/8] test: dm: spi: add testcase for spi_set_wordlen()
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: u-boot@lists.denx.de, Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 linux-amarula@amarulasolutions.com, 
 Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>
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

On Sat, 21 Feb 2026 at 02:43, Dario Binacchi
<dario.binacchi@amarulasolutions.com> wrote:
>
> Add a unit test to verify that the SPI word length configuration is
> correctly handled by the SPI uclass and successfully passed down to
> the sandbox driver.
>
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> ---
>
> (no changes since v1)
>
>  test/dm/spi.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>

Reviewed-by: Simon Glass <simon.glass@canonical.com>
