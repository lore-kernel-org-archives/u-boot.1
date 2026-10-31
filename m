Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC3A606A31A
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 14:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=h31g5zFJ;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=nE93JM/R
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 52B1340B82;
	Sat, 31 Oct 2026 14:06:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RuZo6XG-CGYv; Sat, 31 Oct 2026 14:06:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 88A4040B0C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793455588;
	b=Ukomns5X42rv7apFYI0IvV4iIA0ukAhziS8xqCXzsMmVnu05MQEF3QY7VFoLuUC/cK9V
	 kPpRUPy3n0la9DnL9Yjw01dBWSpeCwSJ1WUrrb98jRL4PPAUSq3vz+mCe/podGCJFhpr5
	 L4h72fEYJAiYahEhohuz/1ae81oMOJxEq5T24MTFmAFvfmTzYSoZogQie3qndfw3wUVDl
	 c9HkXWoNXW9eU6uvqZ5AbTOMrnbTVUEgIyjZtZIp8/xpOM31kuJ/Fguw7iYoSdTSPyBlc
	 RV1wS5WCblCy6ip3pLcEQm9iVt+d1DBIEyMUdoSz8hrKBAv2KSIroCRBJB0bt0bllzQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793455588;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=XEpIJVMTpyi3rBnnyoDLl2fEx8xuJap+ou5JZ5I3kPo=;
	b=eJrPATMeN42G/djih+zxuGK14Zlep/nO4zMeU8PBeJGdPh7jpQ5SeCg2Tf+oxa+OC200
	 XYnVxuz33gU13l1VVYiqAGIhXoVEyGf+ZTZRjau10P0+5ad9BgNseaoXKDi1f0f6u6XEA
	 XODo+kOVay/i/yRwSjrTgc7Zws0f2pJRaRr4obyloLMn706rATuWW6QIAdZGxegp6/XaD
	 K7bfzI1KKlSmu8EMlNzcgfmMwpHrRpWO5KkVlILdw1Eu6CKaIjadmNnmH7mISIAbN1519
	 RVjpDQTWujQm8GfNFJ6K/ADOfwUGKvuIOcj8sTu29Zj9CPUZu8xaTheSLFuLUg0XEFA==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793455588;
	bh=XEpIJVMTpyi3rBnnyoDLl2fEx8xuJap+ou5JZ5I3kPo=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=h31g5zFJLNQ/nwm4f+jWn47FVuwugKgj7Pjq+4mvPbG1ZoACe7WL9yuPOCzNNTcAT
	 nSbSvC3sRgqwTORehzg7HVlh3CEEn5OvITt4aI97Op0kWK11lghPRSaYBxVuWAJB/E
	 a+NURRuHG7UFWrdNOC3dzZgR7GA3rcRVwkwusbNCb2JuhRMqRjz2ALebRx0D7K8gj8
	 CdHYCDRZ81b8srsz7iwrBvOHuT2S1QUbMG6BLwfHQHmSlvV+ZoY163XqiW6lG3DvB5
	 6ZfSCPlbNdZvkVovS+9kCHlqG9NuvOA92pCb5XTg9vB/HwB3FzzyyGtobKUwwVHFDT
	 1HKx2y1la2+kw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 88A4040B0C;
	Sat, 31 Oct 2026 14:06:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 595B7156
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 14:06:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 565AA6061B
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 14:06:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fvh1jXdHUBFX for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 14:06:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4696C60614
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::536"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793455584;
 b=f7S60Bv600aIWoIQeQgebDQ0dVGHwDoPEQQ6t3yJCpklF8B8255yOxLZIYRKo5azs6mF
 NQACblL8GEmOLbpgDeeUMBO+K7ZeIfxONU63T9Di09PU5H7wWBqWOWT+ip4Z/I45h+vHn
 0E8+zSRnUP5YvNtLN8XRGUZuImBCCgql6xiJZyfzrLkF3k2vP0n83jS6zAWQdy/eDMBSU
 r1GjEYGc1OfQJnFQ4diP0Vp3U5l6/xmFmVw+4XBjkStP6mTjzgPNfTFthzAbPMB4ikKKy
 6uJbXymC12hXolx0i/cr3HIQeiNWEPIuq9aoTAVK7sYZQCkjOJt8Rw5J4pKbpOhh+rg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793455584;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=XEpIJVMTpyi3rBnnyoDLl2fEx8xuJap+ou5JZ5I3kPo=;
 b=Zvjuli64vi/G5BTPHi93zn7Faz8eXmX2NaSsNvjpCCrC1KNg4B63zVcodoNVVpoAlviI
 tStvCkvE1KLOSNQegUQdFGXYsRYiJn26DkSm9mGKPfGXcTQ2eAOEBxKG3IBEoldSmqT9k
 n1fEZ8aMssvJsHN9EUsuWpSLETzgnKbm0Fy5SWDGI8VXkiYDgvVroQlZk+X3uDzTwrv1x
 IbfaQ9KBsEdDuftNL0HdIrZT6R6xxrmlMNIxjZU2Sz5kzV29JO3hbV5wFChLzKdjl0zTP
 +AwI1n0lb4SlpB2A56UT/OTlgsSXSdVn6Pdv+ZjeL2UhrCcBUfbx8kTiaUc0txOqqcg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b="nE93JM/R"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::536"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::536; helo=mail-ed1-x536.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=nE93JM/R
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4696C60614
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 14:06:23 +0000 (UTC)
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-6ae14eecc64so2135667a12.1
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 07:06:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793455582; cv=none;
 d=google.com; s=arc-20260327;
 b=CoYENpcE8LAfqqYSya8jy2gjaekVdRAf87Ca8mYPgqATsSqdrdUBfs+5x/EVnjlWpZ
 IvCzNYwswk3Ep5gGCMMQedEuqpHWyCdZ/i/E9If6dZ3ja+dRCRHhoemeUbYCQqv6qAaD
 dAcH4Mj2yIlFGemYf6ad15MgOtPqmExJlraGF5w0ja334vyoIVi1QtVMJUl/0J5vYRcd
 5Nga8GQINYoMe9FyLPXMgIGluTdg1I494vTVUrhlWmuZlPOfJmWmaj7AKpLXikq1Hqnm
 lAjL9yjGCVsmqAF8eTPe9CzvN1Qa/V4uvD56tcnCfPEKqjeN2ZF8sebqGKaWQJryKS6M
 EP6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=XEpIJVMTpyi3rBnnyoDLl2fEx8xuJap+ou5JZ5I3kPo=;
 fh=gnXVS/dDdwjX+vFhhow36UY0GqsWPKWA+0UcrsiPWYI=;
 b=eXtNhJYHEX44UEkjGGEiZ3AhfEtD4TByhiKrGnado0/dSXAVG/MzdzUlW0F7hl77gv
 UxWtGGw9ezIUCPw7syFMGZ6rZc7+Tyct4Dttn0DyUVO5gmCPBFJNrceOuZqO6L9Hz+b8
 0X39FANHi0dmh8Lcg1OmMmLJBiK2mCQpZCA84Zekmvrjz+hD1lqWIVmDkMqfOXyXzSfy
 rQx1gjo5iOodJZAvbLblhhE4jZVKJf9WPjGsxbmpBMDMIRTSokwtrWGLpKdoqc4zhu10
 4kyjBygd7Uzl4XqsahLQfRmXEjMZ0fAK8xeUQ+DE+dxUjiAgqz5aomLX+8ZAX9QqG0iJ
 p3Qw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793455582; x=1794060382;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=XEpIJVMTpyi3rBnnyoDLl2fEx8xuJap+ou5JZ5I3kPo=;
 b=nE93JM/RaJ4S8n0ZLnQNRAYIOEXzw5Fu/MbuqzW80la+e3LGc6qX7GLRm0L7oJ5iI5
 GExj+NnlKtqbVLRtwjr+9LAy8WReWmFs9pr/hd3F3pSCkQNpzMey1pdF2A46wepxjyEC
 bKRxBg0ws9mPfIFiqqswPkD/q4tX9yVlZyCNg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793455582; x=1794060382;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=XEpIJVMTpyi3rBnnyoDLl2fEx8xuJap+ou5JZ5I3kPo=;
 b=PCmaD57AgehTwOi7p29I93wbp531Q2wjNHd8GE948LHL4xqmb88WJz8CNNxd1PNUXb
 lKi1qiWVuPqKcEiXVUH4PvO5NyVYb4J6hXe4V07amCOWXb3qC4GwBeW1igzFuVZjVHma
 AHckwIwOcU0vQfoeT4NfaxwLAzo1bhuYRT4UBK96PRKSzreVvbQI1JdEp+iYbKjXCKPe
 j5jjv1xqGKud5ajnLeCDFhQ+QVuz0ex6Ahn65xQBM3yPy0fHwqBoejIEOc20WpnvTdwf
 XHvirlPvZsgpV4i/3bNBQRgwi8tgsPJgEsiWi6cjSnKPwQ+YPwQ25SgcAMusw9j9zlbr
 swlw==
X-Forwarded-Encrypted: i=1;
 AKwUvBz9XeSVqacFcPEkToXSJzIWS5pQWiVZTFQiCkspBZ32QHDIeMjbLFyRynX6Qe2QpZmqHmieUxg=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLgSKK0WtrB2Um4sHZ6+bckibw1XvSpcGO/+OYUjcE+vfGaPSPu
 F/TyHtW+hThhPhbCtBT9QPCkjiKszOrF4PqQBuxwFBr9JDf0p48RqeQyjD1UfN4hm2E+Qdt+zwA
 F2+gC8OKBfv9YUJWfpvnk8/ZTSB8+rBlWhs2/uZKu
X-Gm-Gg: AYBFou3C1Qfz03K7CiNJUXwBisoqrExVMa3S8ja+7LtT4Sr1B9UCJdgD99O4GwxrSxZ
 wd77qJ1kaaH54rdQu6v1nK7oy1q+sZHwIgK4nKV8IMxCMnvgWCpDdXYWBV8wIpnUSQlahNiB9p+
 Ml5sJLAs60Z2XtTJehsUCKey2f+l+X56eh2HV5NHx9xzPbbaPvdApSxON8zByskpfZoUKJsof9V
 qmu6jRysCTvo4s0SnUb3iVYlCJmDvXQ9D0hRb07GWByZaY2bcrlI8juMeHAywWuPBFfPe5Zbf0n
 rgGccVEofYYUQIHWAQcUloZJbgn6ZaDfEXX0CM/d0fL+be1CxJVB6mhSdBQWOFHwa+8dWyDF69H
 6x7x/aY9AGKp8p3nhfrNMvBkosjW9+KWF7NlSHBMKuo0P5Y6fMpLifV+PRGSr6j6/A+oD100=
X-Received: by 2002:a17:906:ef0b:b0:c25:91bc:ff55 with SMTP id
 a640c23a62f3a-c4ca7a878bamr465435566b.23.1793455581876; Sat, 31 Oct 2026
 07:06:21 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 10:06:20 -0400
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 03:14:41 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261029-main-v1-10-b5a878627107@kontron.de>
References: <20261029-main-v1-0-b5a878627107@kontron.de>
 <20261029-main-v1-10-b5a878627107@kontron.de>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 31 Oct 2026 10:06:20 -0400
X-Gm-Features: AclHuK9hbYGGQ5lLbP6q3L-SWKopIEyomNW5kSl8B7n4xwPNh5zxWaMmg7eGpyQ
Message-ID: <CAFLszTidnwJ9DRaqQUvc+39imSkrDJEkDJD5Nr-N=N8M02VAPw@mail.gmail.com>
Subject: Re: [PATCH 10/10] test: boot: Test the RAUC built-in boot command
To: frieder@fris.de
Cc: Martin Schwan <m.schwan@phytec.de>, u-boot@lists.u-boot-project.org, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Aristo Chen <aristo.chen@canonical.com>, Alexey Charkov <alchark@flipper.net>, 
 Daniel Golle <daniel@makrotopia.org>, Johan Jonker <jbx6244@gmail.com>, 
 Francesco Valla <francesco@valla.it>, "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, Michal Simek <michal.simek@amd.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Frieder Schrempf <frieder.schrempf@kontron.de>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-29T16:23:07+11:00, Frieder Schrempf <frieder@fris.de> wrote:
> test: boot: Test the RAUC built-in boot command
>
> Set CONFIG_BOOTMETH_RAUC_BOOTCMD on sandbox to run a test variable,
> and add a test that boots the RAUC bootflow on mmc10 with it. It checks
> that the command sees the slot's partitions and raucargs, that slot B
> is booted once slot A has no tries left, and that a failing command
> uses up a try.
>
> Booting saves the environment, which sandbox keeps nowhere by default.
> Set CONFIG_ENV_FAT_DEVICE_AND_PART to the first partition of mmc10,
> which has a FAT filesystem, and select it during the test. No other
> test uses the FAT environment.
>
> The test is skipped unless the command is the one it sets up. As with
> the partition name test, this needs an #ifdef, since the string option
> does not exist without BOOTMETH_RAUC.
>
> Assisted-by: LLM
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
>
>  configs/sandbox_defconfig |  2 ++
>  test/boot/bootflow.c      | 78 +++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 80 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
