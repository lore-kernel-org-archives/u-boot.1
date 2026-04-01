Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2D6410FCAD2
	for <u-boot@archiver.kernel.org>; Wed,  1 Apr 2026 22:48:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E8E484011;
	Thu,  2 Apr 2026 00:48:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="B9g8O1rT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E671984099; Thu,  2 Apr 2026 00:48:43 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F5B383CF5
 for <u-boot@lists.denx.de>; Thu,  2 Apr 2026 00:48:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-b982518b73fso41775166b.1
 for <u-boot@lists.denx.de>; Wed, 01 Apr 2026 15:48:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775083720; cv=none;
 d=google.com; s=arc-20240605;
 b=e4W0islEG7bjtXYFYidovE35Lsnwf13t9GtpxFDRvFN8F6Lhio4GVmwpC4n9iHZ2mY
 nGTf0TnEGESBrqaK13Huyo5NJxuJmbdXE5hVSkKv9Z70KygMV6mfPA49IDwDhLMz80em
 C1W6IQobl0fyEGImPS86qNZ0Zdu+9kU4uYvWuUSwxGJZsE5LcaWczYKHdtVQiKxHJ4f4
 K37EnvJmvUS795KqWVNV/GRXczZi+KVYQnXfPvmxKtWm4syVc3CEq4iDdfpvem2k0Xb7
 9VYS+gmo2yEgPTB0UwCVczDRZFFjMaTo33DNhHusqGdA4OUGQzUCr+Kdw9QatsW6oVQO
 NYbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=UpjOFmrqSd0BgdJHvvLMyWCgKiAjHkYT0vYnNxNB6dY=;
 fh=8RvYNedY7ea6rYjBX93Xe7oGxjcnuHrpsVH8p/O3IqQ=;
 b=ERoDFeSEE2ihBcQKQrFsT1LsLhB7n8oueGAuiLfGHgqGT4YMs5hirQHkuWUmQGU93z
 4iqZjEKJsggJjPe2YTTX+xTIpN7PHMy/ld6REF26b30bSWNGucfGPLe+XAk1qXWIRbsU
 ejJ6lAbiNFrh9YQMRANT86bRp6A9ZgfQ8xP5NoRxPJy+oLgV2BOEz462HVvRsvya876M
 dmh78vLycK99EEpVawIoSr6uOyqt+MYxxf121vvVwDJaLMyhIbQ8KnKO8qoDG6K8VyVF
 o8RVeYA+6IeXp9Sl/3yiIJFYjBqgPNOFkVXSsU0zg0nfOJCe8nfFle9y83ohVhFpSIOv
 GDJg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775083720; x=1775688520; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UpjOFmrqSd0BgdJHvvLMyWCgKiAjHkYT0vYnNxNB6dY=;
 b=B9g8O1rTJnyqbBcZXzcAhrPPoYz/mPABZYLp37m6EyvhJC4r2Yub0BIBhnCcSereuy
 SUs73c9levRlkF89gjW939gT0/ZtNb32f7IYq88FOzV3O6i2iWiF9CFqaMYyTTC034vs
 iVYRxxaebdht9p7RlbmTYRdfVwq3DQ25Y2UVQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775083720; x=1775688520;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UpjOFmrqSd0BgdJHvvLMyWCgKiAjHkYT0vYnNxNB6dY=;
 b=PfT/1JJwf6sbtN+v0G57ni8LBrkUPJnW/sccsgmHadV2fVK0XvO4gWsa6BQbUxefB4
 Qz4aG5c9nfEFqQ82unyGM9Hc/G7Ze74umHuuk6MiJ38oyZQBczdEKt3YTAsepawpM4mo
 jEX1w5Tg25D7EN2EkeRPmAY81HJffmEP/X3oE5lPXSOS52/fFmOweuXQwMjP/nty+w3A
 nsM9CzhtgkRFSdWQ1eqIjKWIC61nVqsV0N6R9H72m5IsS6TU7qiGFzRmy3101pw5MotU
 KjpvwiK5BA+8VurulM529B7KjwAuMlxZuM2+pyq0PgARAGMJhL2OYCqPKQSfw7aIa1gw
 w9GQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4yLlh/I13kjAZdSbBq2KLRywiqTFDTu78F3Arv5E97mWnvD+7Fa565pRJ6AYcgbLLQuQLOuQ=@lists.denx.de
X-Gm-Message-State: AOJu0YxCwZpkHNjyNKs+3Rb3Ka60ZNHQGfmY1v7Omj6iNESfmIs/8iFF
 6rmOZuuJAj+Ote4ikUTWnVZzHaBmqkYPRfKGrISQB9N6gKkYHOluzcqNhJvLGLiPr4K+QMP/TZL
 0YJzw0mPGjG/K5kaXHd+QJcA/mYlKrwX7FTcqPoSs
X-Gm-Gg: ATEYQzzN2xMb6r6zWBabY7IeaA7Kf1lZqWc/7FPffAg382mUwrxLCD1itZNwUrbfWMZ
 NfdAMjoCRmfi9lYO1YhS5o+NOaH9mNoXoNDbWjtfyn0E4eg4PJHKkjhqn/60LWAcy0rEtneyC3R
 5A+ubkSJViYa+AYtDACZwDsQ7x81LSdtC37eX7EmPsQFFhATMVzs7CeKrfphVv+bcUH6zgBGBfz
 fvwGQViFm9rjFxyp5qGhTVeezah3o8h4icj9iavao+GS3mIa5vMHFg/g2Dhg40Ia5W6hUNwkw7X
 ZIzP9sSCYeV2iPrs
X-Received: by 2002:a17:907:a807:b0:b9c:34f8:b969 with SMTP id
 a640c23a62f3a-b9c34f8ba8dmr144522366b.49.1775083720563; Wed, 01 Apr 2026
 15:48:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260331100047.34618-1-philippe.reynes@softathome.com>
 <20260331100047.34618-16-philippe.reynes@softathome.com>
In-Reply-To: <20260331100047.34618-16-philippe.reynes@softathome.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 1 Apr 2026 18:48:25 -0400
X-Gm-Features: AQROBzAarr9-HecFLLApKx3cBL5YPi78NPDOWnnKk9EhB8IVRNLSrrWo8IcvrJk
Message-ID: <CAFLszTiHW5Sb6w2jzWzp6tUNK3vaVg8C5W_LFqYCYDFGFUYeBw@mail.gmail.com>
Subject: Re: [v3,
 15/15] test: py: vboot: add test for global signature with ecdsa
To: philippe.reynes@softathome.com
Cc: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com, 
 trini@konsulko.com, simon.glass@canonical.com, u-boot@lists.denx.de
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

On 2026-03-31T10:00:34, Philippe Reynes <philippe.reynes@softathome.com> wrote:
> test: py: vboot: add test for global signature with ecdsa
>
> As now u-boot supports pre-load header with ecdsa, we
> add some tests to vboot with ecdsa pre-load header.
>
> Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
>
> test/py/tests/test_vboot.py                        |  3 +++
>  test/py/tests/vboot/sandbox-binman-ecdsa256.dts    | 24 +++++++++++++++++++
>  test/py/tests/vboot/sandbox-binman-ecdsa384.dts    | 24 +++++++++++++++++++
>  test/py/tests/vboot/sandbox-binman-ecdsa521.dts    | 24 +++++++++++++++++++
>  .../tests/vboot/sandbox-u-boot-global-ecdsa256.dts | 27 ++++++++++++++++++++++
>  .../tests/vboot/sandbox-u-boot-global-ecdsa384.dts | 27 ++++++++++++++++++++++
>  .../tests/vboot/sandbox-u-boot-global-ecdsa521.dts | 27 ++++++++++++++++++++++
>  7 files changed, 156 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
