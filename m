Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F2EECD3427
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 20:31:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 00A37846F2;
	Mon,  4 May 2026 22:31:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ClLvecrJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C6C684709; Mon,  4 May 2026 22:31:44 +0200 (CEST)
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com
 [IPv6:2607:f8b0:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 639E28470B
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 22:31:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-c80227c9572so507055a12.2
 for <u-boot@lists.denx.de>; Mon, 04 May 2026 13:31:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777926700; cv=none;
 d=google.com; s=arc-20240605;
 b=FkdpE+ulsm4mXSEMvjkiCUECVSSUFMdZpugeNB0NZdfw6dIbPZYEgpgjJDZXqOb1d6
 IB1s+9W7qdRifZZ1ElQhDkrWazGkuD2uBMXl76qvl7sYclwBMBENMNvNNpFE2JeckICj
 /0z6CDriEtRUerkaFpY1rha4smsdq5U+AsS4CqsESxBay5Va+Rmh+lh+sSJ4+Q6LeW1A
 rjc/+8reo6ciWG3qbG+lxaJbr0k8dGtun8Xtvwp/uHLMvKHWfmLnT2RhCml5t3Z1pVL9
 126kT9pDs23ZoL/IwzVNEAgkg7YIw8Xn7lGyZ6tsLDqG18RxF0crgEzCPs+O0E7AfMgN
 ughQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=KAK50ovB6yQpPW5eVmPNo6JcDYgT/gve00AKFuCvAzk=;
 fh=JDmMtl5m1ONTYAIDZy3RW95Kei7pwM4OcFAim19m6HQ=;
 b=ESCLIt+9AsljOhUKrx0nM4xDqTeTCrmBUecdY15Z3VklndZA0lZI/ebgBkkOtHqlj3
 TKqUNmD7aFscj7bqr7ONNFPJsIfaNhhGG0zKY+yBAGJx8paHLOtdmj0bCfUF5qjVpVSZ
 KvKuuHtRfPUyHGvit4hsVnXwlF1ZP/m8ZGDBM/hfUXj1Tlb3UVWNlSofEEMoDPkL7yWD
 28QvDhkGFep/a0oYFk+OFcjRyL3+1SJGdsM+IRyyiQ1Hm5YLhZ8gtGoH2x89ZAgSpIPJ
 a480I3TbiUNg2kGV3jCr0ZUHVB6XXmBDRFgtSAM7PqjZw9fgEO/lo80uPwttU/g5IrnF
 XQQw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777926700; x=1778531500; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KAK50ovB6yQpPW5eVmPNo6JcDYgT/gve00AKFuCvAzk=;
 b=ClLvecrJn1HnqpahMkkWS6ChXOS6c9wWTkuo1KISYm5rBRrcn/W+lRh9BPR7xAHQ/m
 p/3ZD1wbzYDc+fn55P9uZc6DISLHoAoaWsfhPXLYh+Ry55mDTgECXtgJUlYxkHnpKC1M
 ZWccrHYykGFxErW3zd2VopH/66yG4uFNDj5CM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777926700; x=1778531500;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KAK50ovB6yQpPW5eVmPNo6JcDYgT/gve00AKFuCvAzk=;
 b=CigOq3T/N84NuDuwXhZJ2wiBaqcAgXVpEaxOC5tIWhyshhP0xAvOo1RpkiR/DjsTO+
 q6jpFmA/c0sO56SzgyHoDE+ttioMOJP6jgumeeE2VZLtPLT62w77D8Yda1zdq5m27hP+
 1hJetItwFlLIrkrTdPMyfIyDCF+24LWb3Ni/h0mU2/aGEElZQaOQHeTQgp6B+00ePzFl
 YSTu6OGapy4oIMU3jeoOF8IU4MbI0BOV00eNupOZUxxLCSyEW+gH68E/2OQPqLei7dby
 XMRGl5b1HkWB4KpiBuY3sgrMAEKUe8y9fOCDxRLH/XP/tQpkJt0reGqnBUnJINHRjOHF
 tQuA==
X-Gm-Message-State: AOJu0Yyvp94dZZSOfrzseCld7ZOkCc9Z8gTGLDc45osko4Qad/cO5S0E
 UX+mguECzUdSBT+UYVeTRfiRyA1q5TNk1ovC+zT1Djj1c5vdarRXuF6Ppye+AKIjVqKlw/N40rO
 KJO+mk+aCcAUUkrAQ8Fv/fMpcYITsaGDQcNSZG6wa
X-Gm-Gg: AeBDievLbn7+YkO+MIIPWxraZZe2ILJS5oKXVWKnZm2d3HfOLKGqyFa+SvNYBsZqU+y
 YQ8a42kvky7+a7GbE2C0f+5HQu1MHqtbrOGZs5+ChmRQNxTcU3hE/04DshIu4AVIWTCKVjyf9ky
 M+fWB3YzgRuSz4E3wCBTp7z6xmTJS9AGdN1vspyh5d/ivjj504f3c0rQeeVBk/trCC1NDm61es0
 oysJ2t5wXPq0wexBq/uPZXKTb5JkIte4FNrwem5x+CgejIv5GAggRAUCk+QaR47F84TNmaNzh4p
 YLZTz/Z1y0CxaGTn
X-Received: by 2002:a05:6a20:72a1:b0:3a2:d68d:9e80 with SMTP id
 adf61e73a8af0-3a7f1d32439mr11645896637.29.1777926699850; Mon, 04 May 2026
 13:31:39 -0700 (PDT)
MIME-Version: 1.0
References: <20260504-extrawarn-sync-v1-0-b19301d1948a@cherry.de>
 <20260504-extrawarn-sync-v1-10-b19301d1948a@cherry.de>
In-Reply-To: <20260504-extrawarn-sync-v1-10-b19301d1948a@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 4 May 2026 14:30:40 -0600
X-Gm-Features: AVHnY4KJBS-y00vvD6QYMZU_kVyeKL5ziTzo8bdVfoW6J9lDjdQTIeXzT9iQ0tc
Message-ID: <CAFLszTgoTs6pQuAXiT7kJzo3qFqE4_r+cmfOqbA51azVYEwWGg@mail.gmail.com>
Subject: Re: [PATCH RFC next 10/18] kbuild: align W=e with CONFIG_WERROR
To: foss+uboot@0leil.net
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 David Lechner <dlechner@baylibre.com>,
 Jerome Forissier <jerome.forissier@arm.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Simon Glass <simon.glass@canonical.com>, Raymond Mao <raymondmaoca@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>, 
 Adriano Cordova <adrianox@gmail.com>, Sughosh Ganu <sughosh.ganu@arm.com>,
 Yao Zi <me@ziyao.cc>, 
 Rasmus Villemoes <ravi@prevas.dk>, Quentin Schulz <quentin.schulz@cherry.de>
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

On 2026-05-04T13:20:27, Quentin Schulz <foss+uboot@0leil.net> wrote:
> kbuild: align W=e with CONFIG_WERROR
>
> [ Upstream commit f852ce052a8b78d6fade371bd1fad583541e78fa ]
>
> Original commit log:
>
>   CONFIG_WERROR sets KBUILD_CPPFLAGS while W=e would only set KBUILD_CFLAGS.
>
>   As a preparation to unify the two mechanism, align their effects.
>
>   While at it, add some alignment whitespace to prepare for later additions
>   to the list of changed variables.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
>
> scripts/Makefile.extrawarn | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
