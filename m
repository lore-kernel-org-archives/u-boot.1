Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4535BCD342F
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 17:49:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA0FD84D1E;
	Fri,  8 May 2026 19:49:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LaV2mtrG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 34DB284DB8; Fri,  8 May 2026 19:49:36 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 330DF84CE5
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 19:49:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-bc1f0830f44so620384566b.0
 for <u-boot@lists.denx.de>; Fri, 08 May 2026 10:49:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778262574; cv=none;
 d=google.com; s=arc-20240605;
 b=YTb7Sbeusyfp0IWZZPyvQcq2vuHulIXCO/NTLXch2EBbYv12F9Q7sSfvW6gNGzZWeH
 NUh9Ze0QSHeUln+SJfHc2me/Srt6TVGmM/3cMjoOC1njt2W6/WR36978h2qeleAfeyBB
 IRTz+VRzj8Jw4wn3w9WpiVU7/VwpnLFhn+xuw4vzdh+/0d/J7fYgmvZdhJcDyGgD8dLA
 VBVaXD13YCjhV89OQcKbH3DlCHWPWiH4ano4A2Ngx1JR2xenhUwps4+SuZxWHw53vkxP
 QN7FAmcGHYDGqvf76q7xqoQieIvuBlXkc4aV1t86Kv5PZiaAMLZBomIkZlUIxg2ojHod
 MNUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=2lpc9yQzFo7+HfBP1/93DZrSXA5HmmEAe/0dGWxEnMM=;
 fh=DerlmRk7iJqeDKfNmCV1Q3W6nvbySuXXUtvhcw5QhYc=;
 b=IEVNmQpqafeck7sMXQezC0P8IUH+lYcoznJyhMuLVbWwGtqLi/dz5InSgnvDNLIiwC
 1gKT3AzuH2HNXN3blyt8sBNe+j2fhSi2ZuzYCxd6uq6963m05AgPL/jbgZv0txOaQi4z
 fRj5zz/96EOimCPOg0+OEUWjvJpyRn05lmDBv25+Z28QgrQ4TL4xIcLdQm7+O9g2R0tJ
 kVyRVq/zXKPtezuZNIFhi4v7rmEAtRm9AY2wEG1d2nKsB1MzOP1hl9gju+fUvUUPQ32x
 aIxFvX/KMDXjgcZMu0a7gJ7PpZoBxMVu7Ou3FJ6Hbl3w+G4/2QZLV4dbOb6B0coPoHi2
 Ilmw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778262574; x=1778867374; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2lpc9yQzFo7+HfBP1/93DZrSXA5HmmEAe/0dGWxEnMM=;
 b=LaV2mtrGKgfOMT5ueCIzt9zsagZ+1B9oDWyx0rkm2a1eUUcqlezhZILquaiZB8ZODx
 zXnzgROv8ziVof2UeP2hQq4HL9h9lV2GsZtLN1WszB62ZWOzBgCLWHQ80id4OFWBZ0PM
 fB/kHSMz4MpiE2ARb7MUwrkpaKFPqMt63lKhM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778262574; x=1778867374;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2lpc9yQzFo7+HfBP1/93DZrSXA5HmmEAe/0dGWxEnMM=;
 b=hQM32nrB+rZnAJTQnq43iCYoR/GO51YQGdZrOXjATqac1EMu6Ayl8GlpltqVs85Zy+
 JzXBAZj01E4QvQfB/Qt1yDFFhGfgQ3eRb+HAQymxVbkUMzvBouKQ7+scPis0fv6erwnU
 nlW9k+//7cuiatiDs+fQcZ900bNfFXhqLzEi+aDm+BSioUxZt44C/gujzSVEbUQYqAf6
 OSzUVid7cTPJTgRFKbWLl5nXQDkqkwXNF7KB8RF327ssKZxOAIRCJqWc9jVpdcM06+af
 vkdSJhiv/noCdagRMAkV1Uuz/mAbgMCYLClMkXiOJgZ6DDugFwij+MM3eslsWNenmxzF
 PbXg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/y3+RIiGH6Z++ypL8KU6K8JugQdg6WrGccTxO8d82Bc73cZJGHitDlP6R6QlJz2m/wEOPQo1U=@lists.denx.de
X-Gm-Message-State: AOJu0YxwT+tzI+Ocj/VNSy7gYCd8yfvOOXGCTQ0eQBi6t1QAwcXpMJGT
 9LEM0LNy5ujvoVPcLzCPgqT4iSqU9bQ2B83S8HEQE4kmNvQLsGS4hKRtYW9nRyBips5+v2QTbmy
 NnlfHkCsWoHLXjOyLDs/1rCRYkT7j/Ac0y+ho+A6w
X-Gm-Gg: AeBDieuWpnsJ4OoICQQh208yjU+gG23Er4ah0nZbqNAKpUM9jX5To4qexbS4SSvs2RH
 UWJLYmwXA+EVu/IGPlTywytQ5qohMjZ+/3EndOHz7ytmga/vsR5mOHmj/Qk7ezfbyh46rxBSfwx
 dJCaUuJCNYJLEHhy6ElsdKz8Zr95C1Pueslx6DMDcK7czruqgCe766xWxrAHZhGl9MV5/5FVUGZ
 Ru0nxwch2ec1xrVgekGz+BDac6SNPEn5qovMgiVjr29iayeLpodY5+f+e2W0OLatlWV94HC9ZNz
 95VGWPBqpe/uMFUO
X-Received: by 2002:a17:907:848:b0:bc3:a0aa:1a04 with SMTP id
 a640c23a62f3a-bc84d48a9ffmr476276566b.13.1778262573455; Fri, 08 May 2026
 10:49:33 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1778171184.git.daniel@makrotopia.org>
 <71ddfdd634aec7fc931f43f3b6c587774aa718a0.1778171184.git.daniel@makrotopia.org>
In-Reply-To: <71ddfdd634aec7fc931f43f3b6c587774aa718a0.1778171184.git.daniel@makrotopia.org>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 8 May 2026 11:49:21 -0600
X-Gm-Features: AVHnY4J0iGtdAKGtDAifiCazuG9SYX2gsaWHeSL8mxdmoJSq1tyU0sS-5j-2quE
Message-ID: <CAFLszTgj-uatd8EXQQLXHk7kGk0ELeh6R+fScVT15rMciz-fYg@mail.gmail.com>
Subject: Re: [PATCH v3 7/7] test: py: add mkimage dm-verity round-trip test
To: daniel@makrotopia.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Kory Maincent <kory.maincent@bootlin.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Anshul Dalal <anshuld@ti.com>, 
 Martin Schwan <m.schwan@phytec.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Sughosh Ganu <sughosh.ganu@arm.com>, Benjamin ROBIN <dev@benjarobin.fr>, 
 Ludwig Nussel <ludwig.nussel@siemens.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Frank Wunderlich <frank-w@public-files.de>, 
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Shiji Yang <yangshiji66@outlook.com>, 
 Aristo Chen <jj251510319013@gmail.com>, Rasmus Villemoes <ravi@prevas.dk>, 
 Francois Berder <fberder@outlook.fr>, u-boot@lists.denx.de
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

Hi Daniel,

On 2026-05-07T16:40:15, Daniel Golle <daniel@makrotopia.org> wrote:
> test: py: add mkimage dm-verity round-trip test
>
> Add test/py/tests/test_fit_verity.py with two tests.
>
> Both tests are skipped if veritysetup is not installed on the host.
>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
>
> test/py/tests/test_fit_verity.py | 145 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 145 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>

A few improvements below

> diff --git a/test/py/tests/test_fit_verity.py b/test/py/tests/test_fit_verity.py
> @@ -0,0 +1,145 @@
> +    # Without -E, mkimage should fail for dm-verity images
> +    dtc_args = f'-I dts -O dtb -i {tempdir}'
> +    with pytest.raises(Exception):
> +        utils.run_and_log(ubman,
> +                          [mkimage, '-D', dtc_args, '-f', its_file, fit_file])

pytest.raises(Exception) is too broad - it will swallow any failure
(FileNotFoundError, an mkimage segfault, etc.) and the test will
appear to pass. Please use utils.run_and_log_expect_exception() with
the specific retcode and a fragment of the expected diagnostic
('dm-verity requires external data') so we verify mkimage rejected the
image for the right reason.

> diff --git a/test/py/tests/test_fit_verity.py b/test/py/tests/test_fit_verity.py
> @@ -0,0 +1,145 @@
> +            dm-verity {
> +                algo = 'sha256';
> +                data-block-size = <4096>;
> +                hash-block-size = <4096>;
> +            };

Since v3 extends the block-count overflow check to cover
hash-block-size < data-block-size, and patch 5 calls out that
hash-start-block only equals num-data-blocks when the two sizes are
equal, how about a second positive case with mismatched sizes (e.g.
data 4096, hash 1024) so hash-start-block != num-data-blocks is
actually exercised.

> diff --git a/test/py/tests/test_fit_verity.py b/test/py/tests/test_fit_verity.py
> @@ -0,0 +1,145 @@
> +    # Build the FIT with external data (required for dm-verity)
> +    dtc_args = f'-I dts -O dtb -i {tempdir}'
> +    utils.run_and_log(ubman,
> +                      [mkimage, '-E', '-D', dtc_args, '-f', its_file, fit_file])

The test confirms mkimage writes back the four computed properties,
but never that the digest is correct for the data, so a regression
that produced a stable but wrong digest would still pass. Can you run
'veritysetup verify' against the external data and assert the digests
match?

Regards,
Simon
