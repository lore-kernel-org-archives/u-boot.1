Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9447DC43458
	for <u-boot@archiver.kernel.org>; Sat, 11 Jul 2026 13:58:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8DF28497A;
	Sat, 11 Jul 2026 15:58:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XXeIvffZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A7B48498B; Sat, 11 Jul 2026 15:58:48 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0FD8D8488B
 for <u-boot@lists.denx.de>; Sat, 11 Jul 2026 15:58:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-69c5eb6dfd3so1222351a12.3
 for <u-boot@lists.denx.de>; Sat, 11 Jul 2026 06:58:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783778325; cv=none;
 d=google.com; s=arc-20260327;
 b=V4F5Lrh/IoIVkNd1wADqQKS7ZHcRbgTHUeGvNUkdYfgP9iKbtE5EtTiKnMHVzgAEg7
 xArrLLSohQNBq8ROO5kqkyySoxkodkJkogpDQunlQo65/VGl73BTHQHD2X3fAtt/nNAo
 f9P0pV6S3YvQEIm5X0gcrkeQ5TOvnYQEYJkgyZw0iiJ6lhcyGRBt73XFkpFI0l99sXu7
 uxHJhlunzx9owSmgoupwiORCzCZQt70zY7HCG8s2vUh0WDg6IVwt/eLhobQTev+oe3oJ
 dWlZ6KS4Pz9xezzn6u8XCaR6NlWdvPDqkRm84xQGvx02wpMRUHN4cbas4VLuYliPU6zj
 eUxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=qK5pkMl/LB9CUu7AjcZ4BytKKxpVJJ4/+1E8iFc6JSA=;
 fh=fBRWTVSAf4qtX07kw3ROl9suA9As6biFujHxlRB527c=;
 b=lTi/X6YJG1ACI1Gu2uky6dWLcYe0W2iPqIwOuk1ji4ZG6kD1paDIBDrtwXlzPXgfQE
 inVvNxoUsWZ1A0m979knyaDZTP7Yg1sNXeCldSQbthcHo2Q+jW9wgEChNp743HeCwonX
 iaB7LFkE1nAf3kZMPYBpQLpvdcRvtQerhUBEMS/rwcVVYsYbb/hnI6+gcDFu3S9y6wUU
 17SDvePUmloWwOypu1tkCd07YHdnZcClkv3By++qHL53Tzy+3e43z7uP1Mg0cOBf1nKt
 nIi7xvNfZ+zZr6VBkHidkqq1UtEBNmLfJE+q4yZsUj6OglRDVuJ14uxyKOF7zS90Scvi
 7ddA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783778325; x=1784383125; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=qK5pkMl/LB9CUu7AjcZ4BytKKxpVJJ4/+1E8iFc6JSA=;
 b=XXeIvffZ3SY9yvbDhRLltjQKvTB992MvmqaSwvaov2Y/sGGjQKUlnN4QCUsWEaOLyO
 uCx1O2ttj/MAHT8IOroEfoLYaigG8Ky642qJsm7Y8DVMIyuuC/tZJmvfhjQW0TK0qBS9
 re6gQrKtG6KDKKjc6QugsBg1j4hM9Am2D7yWg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783778325; x=1784383125;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=qK5pkMl/LB9CUu7AjcZ4BytKKxpVJJ4/+1E8iFc6JSA=;
 b=khkKoBMd6WjX2icNJ9m5hRZQ24bfknjWUhPNX9Tj3FMIPW7jKGwWLTVY4W+C+gzPcY
 HkFpYv/9jRZL6im1lN8F4g9e3ZOyvWKJrBvpAeC91jc/K4sIam17w8lQguvVbVXl713Q
 Uah37GTdddUpCujlFED+EUaDTM37oJgvDG2c2190KyScqqUfeMfoO3FYNZq8HOLkKxZH
 mGP7b8tJnt1cTnV8IVYtuV7LYXO+4vyK2kgNM4zmfWjaGe58Yr7X0wMNeCBGbrqIcHfc
 TVRjOxWqxaE1kszOVpdzWG4+saqScwlXEPQW/mPYXHk2bUthP5b6brjsufFnMhmOFYtE
 vy2g==
X-Gm-Message-State: AOJu0Yx1SwUm/cay6ZZDr/yAyfVUXc2JhHEIq3J34IvPk2hQoB9WATMr
 mxUb4CHNZXRp37vy+ixQuMJtUNdq5fxdccEMRzatIXSvCI1GZoz5UtcHfaRqyrbpv7rLQF6SNFU
 qsF0qYuSVS4SliCk4xWNJw6rxVl1WJfAAqd25/H0/
X-Gm-Gg: AfdE7cm3saHNZ80GRy0isc8MmN5tWKg3FRv5QPuLZj0DdMmvRLcWr/0GOhAf6LqI4fw
 CBIilYskLocNAYVCfs7/b4xvuS9XIJzy1rnn8YQNxKID7xMzKffrERSHm2ukOXUmvvWl0RQz1eO
 eMMjctkD4Sw+vWouGmmKM4TbmRffIRCx80XBPYM0+jfeQf/nHclyBB85h351EJEF/fRtz3KEmiR
 3FKYg8xy2GHWvw6wbbUDESu0RYYHX9wRvS4BfWsw5bMBzNoI1bCPsGGhFEz3oiYGh4Z294=
X-Received: by 2002:a05:6402:43ce:b0:697:daf8:6090 with SMTP id
 4fb4d7f45d1cf-69c5f0e6255mr1348476a12.15.1783778325530; Sat, 11 Jul 2026
 06:58:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260614103232.3586246-1-yordy1902@gmail.com>
 <20260625174121.3633162-1-yordy1902@gmail.com>
In-Reply-To: <20260625174121.3633162-1-yordy1902@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 11 Jul 2026 07:58:33 -0600
X-Gm-Features: AUfX_mx6yHPGnoaSFK_XtSzgetH9Fux07-UHGzI8Seln4Vc90jpWu6mnQ5XBUaw
Message-ID: <CAFLszThgoHCLm-R874sEKZNTT9SpP5P2y4sdueFSdLO5rYeJ+w@mail.gmail.com>
Subject: Re: [PATCH v2] pinctrl: single: parse gpio-range as a raw array
 (O(N^2) -> O(N))
To: yordy1902@gmail.com
Cc: u-boot@lists.denx.de, trini@konsulko.com, sjg@chromium.org, 
 vigneshr@ti.com, nm@ti.com, anshuld@ti.com
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

On 2026-06-25T17:41:21, Jordi T <yordy1902@gmail.com> wrote:
> pinctrl: single: parse gpio-range as a raw array (O(N^2) -> O(N))
>
> single_add_gpio_func() calls ofnode_parse_phandle_with_args() once per
> gpio-range entry. With a flat device tree, every call re-iterates the
> property from index 0 and, because cellname is set, performs an
> fdt_node_offset_by_phandle() (a full-FDT scan) at every step. The total
> cost is therefore quadratic in the number of entries and proportional to
> the size of the device tree.
>
> The impact depends on when the pinctrl is probed. On the J722S EVM
> defconfig, pinctrl@f4000 (main_pmx0, the SoC's stock 7-entry gpio-range)
> is probed after relocation (caches on): single_add_gpio_func() takes
> ~18 ms there and ~1 ms with this change. When the node is probed before
> relocation (caches off) the same parse takes hundreds of ms; on a board
> that probes it pre-relocation and runs LPDDR4 clocked down it reached
> 723 ms, cut to 22 ms here. Any pinctrl-single user with a populated
> gpio-range property pays this cost.
>
> The phandle target is never dereferenced by this function (only the
> argument cells are stored), so resolve it only for the first entry to
> learn the per-entry cell count, then read the argument cells directly
> with ofnode_read_u32_index() and allocate the ranges in one block. A
> zero phandle still terminates the list, as in the original loop. This
> follows the existing pinctrl-single,gpio-range usage observed in current
> DTs, where entries use the same provider and therefore a uniform
> per-entry cell count.
>
> Signed-off-by: Jordi Trepat Mur <yordy1902@gmail.com>
> Reviewed-by: Anshul Dalal <anshuld@ti.com>
>
> drivers/pinctrl/pinctrl-single.c | 79 +++++++++++++++++++++++++++++++---------
>  1 file changed, 62 insertions(+), 17 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
