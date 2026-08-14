Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA258C5CFC1
	for <u-boot@archiver.kernel.org>; Sat, 15 Aug 2026 00:52:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1A3B340C31;
	Sat, 15 Aug 2026 00:52:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jz_-4y8HUHEh; Sat, 15 Aug 2026 00:52:34 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E758540CA4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786755154;
	bh=kxdXEEvFBDlESkW7KT/cnrmZhm5JKA+MHzP4AJPAcm4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EKdMICFb2F+R7//4xlp5hQdGe8+fDfVCViJqAAe6atl8paaCAz7L2PNhCnRTJhNK+
	 odkzgoTF1Unj8i4PZAu3GYw7ZGantV6DkExZD9K0SwsT29KbzsJTn+rS8QQL0V8sS6
	 3zvf6BdaII+2w+CN27oZBsn9SFFWHZ/s22fkJmJk1+jZUyzu6Vq+wcpTfsq6Uyo5wN
	 WY32g4q35CVi/Cetbp0uM3vvJuYSnxIIlIfCIxEuUS9Ta7GRk/ztzVN7tU3ECLlqYn
	 0UHtKy/v22mgpqvgogJ8UM1dcnyQfKQktkVqxesKDQY+NOjXz1aeMjtc7SskalACiN
	 FuXP6L33yHjaQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E758540CA4;
	Sat, 15 Aug 2026 00:52:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 9A7E0139A
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 22:31:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 811786068A
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 22:31:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uMXwITqJ7RfS for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 22:31:30 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52f; helo=mail-ed1-x52f.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 8B8D46067E
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8B8D46067E
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=UADnuBjr
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8B8D46067E
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 22:31:30 +0000 (UTC)
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-6a0794669a6so2461896a12.2
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 15:31:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786746688; cv=none;
 d=google.com; s=arc-20260327;
 b=igSB0MZpzXpLuBSpjRO5CaC9oSa6BoAL8RTFmN/BUXhrPCOAtdA2uUa1q5h+y587Tc
 6ntvlrkSrbTWKqXAAo/kT/x+v+zkAqF3Ae0VwbbcKyyfL5LFr16fstPO16dcfMIU2N1L
 TNpVm65nnpgsXAawlvSSjTWkvAMDejdX0jHQxThFn6UBbOa4eb++OeAxGpJRN7FCJqoe
 Ur2XUmGLH59p/an0io6VCnQs3xTdpb+fwveI6/Ns718qvi7ubA5KddGbXtN1FWRmZ4ib
 qN5ADJSEt5/Yqd5V1ZESaKsSCD3TBWnU7N3TLXVwmKp9DTaIeVJ9wecHn6GVvszeRLEo
 yMGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=kxdXEEvFBDlESkW7KT/cnrmZhm5JKA+MHzP4AJPAcm4=;
 fh=bnad+7a1ZNw2MOCqaBE4yX7FR9MQrd9Cq6xqrouhfQQ=;
 b=fU20TvSk5qoCaQpCgnr/dEgzWsKtp8gR7nQoMTF/p0Y8EvfHw3W8sJ0IyQOQzTZHI6
 nQq29Ew+cpg9mX00qJv5ORsYUSk/2yAINw8Dly4dBtSs++e78W80qLkNBoZd4Xaoe72z
 GvMdP+frXqVluNKBGufUtWLXh3LdmztL/sao75i7f4GG2IqbPO6IoS1AUcwGbLkK/yki
 zv7Hl+2kYDjSJthYycjOf6ktaPCIXI03VKmgtjXSfMovpIR7GzrhZuc802L9VPAK4SvH
 0gUh3IdYXw8RzvR84M2RT8dIz7mv9X0pMQA9FAmQXTAOyvw5dYgQXjyOhwDlMn1aqAUI
 cc6A==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1786746688; x=1787351488;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=kxdXEEvFBDlESkW7KT/cnrmZhm5JKA+MHzP4AJPAcm4=;
 b=UADnuBjrnSbwltb3OrWIxILrPfUo0YYXNrPOSRhCgjhyiTXaALoauhcUHPN9gU+1Q3
 /le3oq+ckJgan+v8hZGv67A5aWAkiJQQyrJI4oSVAv26B39n1FOmgrvACxmQOmjuJREZ
 9kVprtOVfS+ZOmrh+hpU2FsWl8+KO9fvGjVdY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786746688; x=1787351488;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=kxdXEEvFBDlESkW7KT/cnrmZhm5JKA+MHzP4AJPAcm4=;
 b=bsBK7zwajthWX4wRz2gcNOMAGIxPbJu0B3aFheQNizwI9Inz57eafSR1wcxv5192sF
 Oy1ZRRi1L0ok0rBLKkItZzU4qV+M1JGq+URmUa36kJ/G4WfGCdOgi/4TCc1qFA5pW52G
 GXkkgRD1UlpkrmwaPO5VE31vLvc8gEJp2BrPOZp79LDdj0nf6jAbjZ7gcKr2ldyz5lIU
 PaDzByKnJYM6SVxijIYNF3KCaRBXJnOf9j4WL0CBdUveAdiYp+gJaiQ7LpCkuP0csk8e
 hqI05L89ad96ad6iwk0Nfe05mCBSywMHB3sSr0GODrQzVfVMuGTDc7gUIYsX3JMpXzkx
 lfmQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoIGraeY2df2oEzrcJRUFEzUJxubaurp7SvQl4TnNwvaySv7NQ02nT9NlIc/YFuB18kf/xzgCs=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YxEAcJhJdE/7f7osg5kunmz4qpTgC8mviL6GPCGScxvgP8QxfN9
 Io/J0xM39syvm7ifmbFulqt2OE4JVkl/veu89GYf+7CFw9DtZoE9gPyDeOPFhTbFTDxfV9ugaIo
 /0/eyDuHJIigfiSUugbc1T0AjEEIG2Ud6fZDKsvTJ
X-Gm-Gg: AR+sD11us6fePn5r7hy/L4zyG7vX7PbkxEGH3Bk9sj6CbCo3mNi4CZSziJsIL7SMgM2
 ZJtMepn+6tki4LnHO65W5H+y1P2BbgoiLhuf024duP6sWj4D/CjHYHfsW1PQNMie+5vR5nz/G1r
 XavkqzWTi9SxDfprRChaI8lyL5lxSQIprOm/+MWJZgUM/qaCamArSjug8XZ33oBF0jeYORLDgSb
 j8QPgAe5l0rNqvRaoADcU2GysTqZnQJCQoJA7WmKf4PcDyDiUiH4vshY4jofdJvHFO9XetiJjGu
 OA8LkfpokBh/xKeCXxTX19d7oJV0mJ/L/4t7N6s6aPy95Pa1PfGUyQ==
X-Received: by 2002:a17:907:3f83:b0:c16:14d1:b529 with SMTP id
 a640c23a62f3a-c212a2b2a40mr439931166b.18.1786746688509; Fri, 14 Aug 2026
 15:31:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260813-submit-ce-series-v2-v7-0-593fcd8479fd@gmail.com>
 <20260813-submit-ce-series-v2-v7-6-593fcd8479fd@gmail.com>
In-Reply-To: <20260813-submit-ce-series-v2-v7-6-593fcd8479fd@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 14 Aug 2026 16:31:17 -0600
X-Gm-Features: AcwNN1Xxv0N5l_Z_C1Wxr2LAvpqDj2SrnpGWh5CpnTgYUgqxs6qgbOpOBjhnXhs
Message-ID: <CAFLszTig3sOjU-bDZ5mrkmXvRabLA4Rsg4oC_n6+4Y=ghhXpeA@mail.gmail.com>
Subject: Re: [PATCH v7 06/15] crypto: hash: support hardware-only progressive
 hashing
To: james.hilliard1@gmail.com
Cc: Svyatoslav Ryhel <clamor95@gmail.com>, Ion Agorria <ion@agorria.com>, 
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 u-boot@lists.u-boot-project.org, 
 Chen-Yu Tsai <wens@kernel.org>, Samuel Holland <samuel@sholland.org>,
 Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Thierry Reding <treding@nvidia.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Quentin Schulz <u-boot@0leil.net>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Marek Vasut <marek.vasut@mailbox.org>, 
 Rasmus Villemoes <ravi@prevas.dk>, Rasmus Villemoes <rv@rasmusvillemoes.dk>, 
 Aristo Chen <aristo.chen@canonical.com>, Anton Ivanov <anton@binarly.io>, 
 Daniel Golle <daniel@makrotopia.org>, Francois Berder <fberder@outlook.fr>,
 Peng Fan <peng.fan@nxp.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Randolph Sapp <rs@ti.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Alexey Charkov <alchark@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Anshul Dalal <anshuld@ti.com>, 
 Johan Jonker <jbx6244@gmail.com>, Francesco Valla <francesco@valla.it>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Michael Walle <mwalle@kernel.org>, 
 Andre Przywara <andre.przywara@arm.com>, Lukasz Majewski <lukma@denx.de>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, E Shattow <e@freeshell.de>, 
 Enric Balletbo i Serra <eballetbo@kernel.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Lucas Dietrich <ld.adecy@gmail.com>, David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Raymond Mao <raymond.mao@riscstar.com>, 
 Ryan Chen <ryan_chen@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>,
 Mateusz Furdyna <mateusz.furdyna@nokia.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, Heiko Stuebner <heiko@sntech.de>, 
 Vincent Jardin <vjardin@free.fr>, Raymond Mao <raymondmaoca@gmail.com>,
 Yao Zi <me@ziyao.cc>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Sat, 15 Aug 2026 00:52:29 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi James,

On 2026-08-13T19:58:53, James Hilliard <james.hilliard1@gmail.com> wrote:
> crypto: hash: support hardware-only progressive hashing
>
> FIT configuration signatures hash multiple discontiguous regions through
> the legacy progressive hash interface. This still requires a software
> implementation even when image hashes use a driver-model hardware
> provider.
>
> Add provider selection for progressive driver-model hashing and use it
> from hash_calculate(). Allow SPL_SHA256_LEGACY to be disabled explicitly,
> link the SHA-256 software support only for a selected software backend,
> and make legacy fallback paths reject an algorithm whose software
> callbacks are absent.
>
> Extend the hash provider-selection test to cover progressive
> initialization.

That seems like a stale comment, at least for this commit.

>
> This permits SPL to retain SHA-256 FIT support while relying exclusively
> on a hardware hash provider.
>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
>
> boot/image-fit.c                  |  2 +-
>  common/hash.c                     | 21 +++++++++++++++++++--
>  drivers/crypto/hash/hash-uclass.c | 31 +++++++++++++++++++++++++++++++
>  include/u-boot/hash.h             | 14 ++++++++++++++
>  lib/Makefile                      |  4 ++--
>  lib/hash-checksum.c               | 28 +++++++++++++++++++++++++++-
>  lib/mbedtls/Kconfig               |  2 +-
>  7 files changed, 95 insertions(+), 7 deletions(-)

> diff --git a/lib/hash-checksum.c b/lib/hash-checksum.c
> @@ -20,13 +22,37 @@ int hash_calculate(const char *name,
> +             if (!ret) {
> +                     for (i = 0; i < region_count; i++) {
> +                             ret = hash_update(dev, ctx, region[i].data,
> +                                               region[i].size);
> +                             if (ret)
> +                                     return ret;
> +                     }
> +
> +                     return hash_finish(dev, ctx, checksum);
> +             }

If hash_update() fails partway through, the provider's ctx is leaked -
nothing calls hash_finish() or an equivalent free path. Do you need an
explicit teardown on the error exit?

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
