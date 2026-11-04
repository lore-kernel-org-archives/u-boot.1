Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39E2606A328
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 15:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=SiMmxszI;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pp9oBLM3
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1C4AB60628;
	Wed,  4 Nov 2026 15:26:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id s7VNu1j5oeGY; Wed,  4 Nov 2026 15:26:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 25742605E3
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793806014;
	b=SmigvagMI/e3SKN0nz+mrmdlsVUUEdKR/I97YMObEwfM+oyD+cMCKn0j61ITZgq/0jVD
	 u8UY4jZbg4LPftwLR57lHaSU7Eu7S+GkyfFwHa76WamJ7HCqU4NT/NyljTZt0bTJIX7Tz
	 WG3r+QTjsJ+rMTU9xc8b7wTx2cSCYAJdBPDWy2eHnVMgaFJeCDqY5t3RojzOgU3jQGRPG
	 2rjjD+BwlJ7IUaeByOE1N5Q52uPgO7vxJRWqkVbYgaUjsF0eiCipR3Yr2UK7u+vgU93Aw
	 pC1HgdU487z9lqPwiFeuCHxP0DTgIc6vzc2TE0ARRj5NlNOfLe41P2ZGmQOmKioeRNQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793806014;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=KEwbgkcpfPa+4ASHl8imjB6fiCjP47b4golza3hpUKY=;
	b=QPl5m0TQeR3sUtwOCqo4vOIk64onqTn78ncyQJzH2YrC6JlU0VrKynHylwjaKwKoxNWu
	 AyzmsN7rcdBiZ3o3Opz6owuInT/a0YIzstX4j+Z9lBW1jvK+gnYUmHlw0Sw/lyFKy6m4J
	 B4Ov8b3OFCGsQJFKjlGLmz2b1ZbaOHj15CSRQxR/EyYf+AqkWfiNPpC+NijRlJ8sBqBRI
	 CYiDHUSe3AnP9dvjWhbQ/hQSd9ml5VsC0lj1Y/VkLBYTYXnvVI7Kx3rHhXLc7KDTP10fV
	 YeZgh92TInk0mwtGpzIwkrRkYji6dfVbCTkN7QOPEDt0jC+KDce9rbPRTJb787BHtJQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793806014;
	bh=KEwbgkcpfPa+4ASHl8imjB6fiCjP47b4golza3hpUKY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SiMmxszIwCH4n/YYg9JatwmLmhDUD60IBLiKDIvwaBtv+T2VcRWSB6oaBUkoZoBla
	 Ayb29f9Xq57NBrCrrCdIo3ptktMbhRaM9MF77+kRTPi1m54ajEfk4B2DnvOH18/XZm
	 OOWWdu7ih4XXosaaae3+MZZIbF4P36JfYiuZuHQNu9u1FCQm8ByBkJ5fMvkw73zOp2
	 BqQ6xoalCgXQ8iL1j7i2n+4lR/u3KISLjFv4DPo4YFi0CLKIFRPTGqdc1FLTCV5O2d
	 AKLQVQyzuqSLdWo2OGGTBqjq+sYx7Kv86xbylRrOwuEaHpcltRdXE3kVB6ViOpWrfe
	 1NSiXVUh8J6IQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 25742605E3;
	Wed,  4 Nov 2026 15:26:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id A8FA1362
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 15:26:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9A2154051C
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 15:26:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Lee8-_jI6We1 for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 15:26:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C7EA840517
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793806011;
 b=lfgBMpASqqa6lXfcB1V/BRPbaF7KA2g3ESEwgQq22y1MaTShhk5VOiQjEeYxKPipzGzd
 CfVBgJDgGstppt11WEz0E1QDuSTjMlkAu8qtGi2nwJNWacKVulchDHw1v37CpZSE6QPdB
 l+IPUHmCGEYOp9Rlz52KiKkjm5mp0aGB1991cNQGhntzC0N2SpO5MdoMz8Ce4smaLy/vs
 347xQS1e6rMZYsfY3jciZaDpUc+zBp1GyxsNibAZ+lBGaoNLrILbwwIStRk8F8/sUrkYQ
 NGSu+nfw3i+uVsGv4u2fncjUbbSQ4Bw9Vaj0OPs0S5IBfFk3DAeUZ6PXBP/5dL9CDCA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793806011;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 In-Reply-To:References:Date:Message-ID:MIME-Version:Content-Type;
 bh=KEwbgkcpfPa+4ASHl8imjB6fiCjP47b4golza3hpUKY=;
 b=VXyLQZ0Au+w1Q+x3f8GBrXAD5KGJtW6xg8v9EMNaJlHPk4rlb77DyNl2S0YNJcWXEVfe
 m6DcXHFUH115tjKz0pTd2uwLQClUx5TagQpBDLBl9prP3EYidtSDalHC4QyQGOUEU59ui
 OA+GlEfJEo1w4xGlL1A220GMvC8PT2j/rCfsHr00GcDl3v7l+AdITrCoMegn9TwmF1Arh
 dE0oHHv46IMkEiS3pUi4Jtb/vBJgKvL5E2IpK2SQMlXUKL8oOw9XURQqEVa7sViTwrZ4Z
 kwa8AfQlkakuKaet74vL9vAGtIrKTGQX5REGb6lE5wyQlLW8Lc/hUpmKhivMYdvhudw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Pp9oBLM3; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=Pp9oBLM3
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C7EA840517
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 15:26:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8DF75405BE;
 Wed,  4 Nov 2026 15:26:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F058F1F000C1;
 Wed,  4 Nov 2026 15:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793806010;
 bh=KEwbgkcpfPa+4ASHl8imjB6fiCjP47b4golza3hpUKY=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=Pp9oBLM3H0JO8AD4ncyyVVVaiO4wkyVlha+jiuq18ZRTvOijd3D0Fd2if9kRoSUiL
 AdfonPSYXSnnh0ivR1PhLv5JQ5NH0NVnRaFCHh8xYveyqT2Cy/+e/n5FcCiLx7wkTi
 yCp/KK8StMFxVYlNOoLKIBFRUZnHnMdhOTHSsLRq4AVzWX1dpWBlYsxL8jNHPWB0/p
 FGuraMuTSKUsbDYuf6koj87AUA/Dn8KbtiRXdCCRDbjS9D0h2eV2nHNEZMLuF+4OIV
 1uCThlSCHLMK//ImJa+dZsE5qG6ogJC6AnpYrFE7vsapghgtvDPO+vcw+9yaeJiFST
 TheCfJxoe73UA==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Guillaume La Roque <glaroque@baylibre.com>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz
 <quentin.schulz@cherry.de>, Marek Vasut <marex@nabladev.com>, Michal Simek
 <michal.simek@amd.com>, Igor Opaniuk <igor.opaniuk@gmail.com>, Sam
 Protsenko <semen.protsenko@linaro.org>, Guillaume La Roque
 <glaroque@baylibre.com>
Subject: Re: [PATCH] MAINTAINERS: android: add myself as a reviewer
In-Reply-To: <20261104-maintainers-android-reviewer-v1-1-a239c7926351@baylibre.com>
References: <20261104-maintainers-android-reviewer-v1-1-a239c7926351@baylibre.com>
Date: Wed, 04 Nov 2026 16:26:48 +0100
Message-ID: <xhkdby0b8wrbb.fsf@mkorpers-koolstof.csb>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-20.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Guillaume,

On Wed, Nov 04, 2026 at 13:48, Guillaume La Roque <glaroque@baylibre.com> wrote:

> I review Android boot, AVB and fastboot patches on the list, so add
> myself as a reviewer for these entries to get Cc'ed on them.

Thank you for offering help to review patches. I definitely need it so I
appreciate it.

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

>
> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
> ---
>  MAINTAINERS | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ae3e9819d450..3909a2896c7a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -102,6 +102,7 @@ ANDROID AB
>  M:	Mattijs Korpershoek <mkorpershoek@kernel.org>
>  R:	Igor Opaniuk <igor.opaniuk@gmail.com>
>  R:	Sam Protsenko <semen.protsenko@linaro.org>
> +R:	Guillaume La Roque <glaroque@baylibre.com>
>  S:	Maintained
>  T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu.git
>  F:	boot/android_ab.c
> @@ -112,6 +113,7 @@ F:	test/py/tests/test_android/test_ab.py
>  ANDROID AVB
>  M:	Mattijs Korpershoek <mkorpershoek@kernel.org>
>  R:	Igor Opaniuk <igor.opaniuk@gmail.com>
> +R:	Guillaume La Roque <glaroque@baylibre.com>
>  S:	Maintained
>  T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu.git
>  F:	cmd/avb.c
> @@ -851,6 +853,7 @@ F:	test/boot/
>  
>  BOOTMETH_ANDROID
>  M:	Mattijs Korpershoek <mkorpershoek@kernel.org>
> +R:	Guillaume La Roque <glaroque@baylibre.com>
>  S:	Maintained
>  T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu.git
>  F:	boot/bootmeth_android.c
> @@ -1037,6 +1040,7 @@ F:	include/extension_board.h
>  
>  FASTBOOT
>  M:	Mattijs Korpershoek <mkorpershoek@kernel.org>
> +R:	Guillaume La Roque <glaroque@baylibre.com>
>  S:	Maintained
>  T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu.git
>  F:	cmd/fastboot.c
>
> ---
> base-commit: ab4dc5aacf957835c295b59ef2dd28281839cb20
> change-id: 20261104-maintainers-android-reviewer-08a974f58916
>
> Best regards,
> --  
> Guillaume La Roque <glaroque@baylibre.com>
