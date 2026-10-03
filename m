Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31294CA5FDD
	for <u-boot@archiver.kernel.org>; Sat,  3 Oct 2026 05:40:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D435B810D1;
	Sat,  3 Oct 2026 05:40:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3RPYXyvUMtBZ; Sat,  3 Oct 2026 05:40:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 7522380F19
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791006023;
	b=IBsasflLI+BzGC5fcrSpBykbKchFSweHBLog5N97Nyhm6k77BGJ/gn/xt4tbvha/4kFQ
	 K0f+B9xIk4elCG+fOHHjkqD+b2tvEr/aYRfdmoaKwKOg1pHCSd0vK5MHdDOgHlfuUbEwv
	 Uf5YSuvYq0acg8TO/up/R2cZRIZe0f68i3sKIn38nZGZWtCEwj9oHN4/POsGkgaD3FluC
	 d9Py+Do+Kri7JSjGcu+fxMecatdiunuU1wrdDkSP2y81NP5QVC0nz5pq82TaxB43HI3kc
	 gOA1/FsxPbQDSOjHAB7xcmCIzplpnkP2YPn4N4KYkjtRPvPsgAiGyPUFcPR+Gwqyx6g==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791006023;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=flV6Hmy9/9PVfrJLy9mxvRatj9UVitXfWWRgukTBI54=;
	b=ZdKQ+WqKG2xSSNbwPdi7cFHqv1DkiGdMDmWpFRgtKG89pDYdl6w5FXJM4e3SyQH0awnq
	 0rdI2H27ZoKDIvrIE0+OK1d8RJxELngaMNakV99oXms1nKHrlGMastzrlf4+ZWGPGoFpZ
	 utUtxvdfwXnvpUTuAiUDKJUls4o8DvbZODoBS8QW5jMx5ZcMKXCqGbyaFCUaoZc41tnaD
	 mncgFUGNEak1x9A0UB3VHSJ3BIvAAGJ7CLYlBZweFfbktOfbToB/seW7wAomLdDpi2JMd
	 uQrPEJKXIpMQ4h6eNJ9UpdoUEwO/IQBe7wK7DP34tHLIzpHFLkyqdIT7TEHAG22w8Fw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791006023;
	bh=flV6Hmy9/9PVfrJLy9mxvRatj9UVitXfWWRgukTBI54=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YufoyzEXo/n6XCL4eaUpvyxjIw/aUQORFlZFGbqJdbXpzN+JvLUEKa16e2A/8JAl7
	 WRtdGM5gl3gPAlmv/jyLtz52QBZklL54yItPXeRLhkZp4uqzDigQ/29sYoH9PM8Vil
	 7nVA3PPoA8on4jOivauR/k37EM98WC8LIz0Cdr6U1z6QenWsuPbdIp2GgvdYNfic6S
	 0UOayvezUu3ZdMGuNbxknkvEkC+FfEQRlmGeznfwxU+1K9pJqkUGc/OLfad+kkXkmj
	 yx1fhPAc+wE9Ogl83T5x/EO/bl5o0pmDufHey2GFNC8f2ilKcqAffRIQ3i2CbleXq1
	 JDcMgJpWCAwCA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7522380F19;
	Sat,  3 Oct 2026 05:40:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1CC4C179
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 05:40:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0EC8B60624
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 05:40:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xkD8BEGO7B5U for <u-boot@lists.u-boot-project.org>;
 Sat,  3 Oct 2026 05:40:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 195C96060D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::529"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791006021;
 b=bWiU1ldk6eOSRAS6ADQEnhru6yn5uLk2xWnob7osw71406Wi1ht38y2ZZ+9LuFotw1mc
 +ILq+hsQihZwa9RRSS1XjkGBxcBnHneb91AfgOlUuN405x1SWvg8Nr8pw17K2ONUEPGpd
 0ybta+Rdn7QttOPlmG3mjEXj4HYbD3S6MrgSWTdL7SCG+kGdWziO2pDKlNS57AUPbYwyX
 M/TbXoU6eo09FRrESKANObB/rFwycWn/W4k4d9FmU7HT7Z+mrZt06YxAubEsteNvLfi9C
 3xWtYGTp20P+NgwdJ65KcIz/PLUAj3b31pxYtGp4mkLChewDP0ZIyHeUi5poJtW0ffw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791006021;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=flV6Hmy9/9PVfrJLy9mxvRatj9UVitXfWWRgukTBI54=;
 b=O5r7CyhXCh/5/Q1y90TvycKzfalRM67kh9x3E3mJ5v7FyJ28U5dAFTbUR21QFnepE4sL
 T492MxAWBM+eTP78WG/j2jFNYRou2MzA6e6cZyewHz7oqtquRW94rWOPpIBx/H66ynlAQ
 tWBlqotI19dpzmYM6/EvEztjy86Ni6u/qR1TqOhSe9eB9azQA70h5c1ltGw5exehZ/uy8
 /lOKlk0L2deO0m6ZOskzGybM13IlewUzQDZwVA5rpKcYuDENexiAEwTOAaofEgr9gkS7p
 1NF/e1mwujG9UOYWrERz98gYJ1zTVzcb5I2nxmugmk+Nm9DQbzPNbX9ttk1d+cd9FnA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=OUKwXYoC; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::529"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::529; helo=mail-ed1-x529.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=OUKwXYoC
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 195C96060D
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 05:40:20 +0000 (UTC)
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-6af9befd04cso254019a12.2
 for <u-boot@lists.u-boot-project.org>; Fri, 02 Oct 2026 22:40:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791006019; cv=none;
 d=google.com; s=arc-20260327;
 b=W3Zv0ol8gTcS4458lXaFotb23+7bTwas8rOZ+KzzLMsN0V/UiR3E/1xd3HCc08k/Pi
 IrqBs152QBVCvIPIKXLO5Cz9eIQec/QVgO++64Mgq7ouchC+WY5d53zFpt8w8Y36/T+W
 naL8dmHvXR7ZTNpZLCxXIsjbLv3Nzm6YISrXkaVgNqbYyt+IF/E+TDUQeM8if9JzbLAg
 JXT4Y0KPK1Eu+Z/kvRVrqEgGGUZFuurNYNsI1DQW7J9hgQym25dDmCBn0xQdL4qmZppe
 H5eV7fCJUoJMi8NxfEnYztPOH29+Um+KPh/K7qprY2dyw4kboCFZZJVIFJRB433u/uS8
 qqXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=flV6Hmy9/9PVfrJLy9mxvRatj9UVitXfWWRgukTBI54=;
 fh=/iSLKRqVvo6KJdHoN8Uo8Tff/SD7I9J3YwaJdCKLPiE=;
 b=YiCsgyjKpv72GES/x/F8Bp8bfFjaQa50zgn53uxPdiPl3xu6RbTCoPji7jqHAMZuJU
 hUuJlMZcJaYpeeg/toZuMbz5DM3IqKscALCFo6q76cab9YpxxjHGGdqlJZ5lLznxD8PQ
 nYzhEJph5TemJx25mDJrd5OJmb4y7PbhAYb+65cpOsFzEzWZ5EG6bHqEydQu/HEFd4ci
 eh6lsI3muiShOrnT2YxZzvANH3y8rlrMaQkL8GXQ4kNTyRZOsLvSJ3smwSBvzjsmjrjK
 NWKlTgr2TaA2A3Cz9nyZ9A3a6SYjOoYMKhOTSvQWVbAVsDo1wcjmdyT7ef2N9IG7fg2Y
 3EtQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1791006019; x=1791610819;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=flV6Hmy9/9PVfrJLy9mxvRatj9UVitXfWWRgukTBI54=;
 b=OUKwXYoCDFQ5S41/pwlOwPmQlTfxcw4tzH8cuxxGe3OTaNwULrJcgbqYq9HsL4X8kB
 3qlwfpdsDA8lzGVKwc7SJZO+f97JGQ9RNv/vGnNLqwF8su53qBvzR0wpc/xrZGdmAhAM
 2HY3IhC3K/E5Z2RJw4gNjBZH8Wh1Y5V8bQPq8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791006019; x=1791610819;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=flV6Hmy9/9PVfrJLy9mxvRatj9UVitXfWWRgukTBI54=;
 b=yneRWBqRVpuhBXVmne1VI4bEJzAtvHErIkNV/OqKKXb+U2LEEKAZbNi1aytTARNRJJ
 mkp2qZBcq72Q4ayP4j7dZDPCXCxV5X00Nn4hTyuhTVwi3y+45KQ5jqlip4nMrc3XtK2V
 8+fKswtefTm0U75AXnv6gkAzLRZKgnHqpP64WaZFEXt6XRSWH6d4O5zRKrnfkRSUzs1O
 Ax6/mNU9TJQPIrM1nayU1JFqZvCfIcQhRZZtePvWSl+vNVf7hnU4bYndNu7hpTK77Dss
 UFAa/CPS2IuDGUmkFFjelo+So3lcon2N6D61vozict+z6YjPjn4EAr9+PZO1ZPT2JbGW
 ANvg==
X-Gm-Message-State: AFq9FYIrLRMsmuSpNCuiCHYz/83IDtnT5UHNkPzPFlPEq172AU8YhikS
 iYoaGH3dBrCheDfyqabYHcx8ilNBWwODifLFAHLoqGutGaK6Ts1UMhqaq7hMBAq4N87JgXmfk71
 XBY6JHhVNT/J1gNWujwBwtpwWegabl4hFokUo5MYI
X-Gm-Gg: AYBFou0N2aM1e+fAHUrhn7PGEwKfOmG6NS44AwfMBufkUETad0aU71v9UyCURlbaI0q
 FUuu4IsX5e4iDEQ44k4AcA3VPYY+jiLZp2/TWaNI7FA/RObzkAOk0oBkRP1J3hwdcaaG4awBJJJ
 Nhm2C+6xqnGlqG1m8rX6GsPsuLXD2LMM/jByok//dh4o6+cw8qky+IbV0bB0ICXtm02WxxuuOfD
 1OBpl0MHmVoOo5asT+48UY84hngfT/6Fr0hTRbK/Ae0cyVTcSRpbvxRHBNKF0GpG6isg+HU7nCf
 RTLtCBaXCrX6wf3Kh9K+ixjbUyH3q17dLCACji2Pda9pmgg+mG2PI9HC
X-Received: by 2002:a05:6402:2793:b0:6ac:fe75:16a with SMTP id
 4fb4d7f45d1cf-6afad760031mr1382054a12.1.1791006018748; Fri, 02 Oct 2026
 22:40:18 -0700 (PDT)
MIME-Version: 1.0
References: <20261002-authi-v2-0-900f6f9141d5@arm.com>
 <20261002-authi-v2-2-900f6f9141d5@arm.com>
In-Reply-To: <20261002-authi-v2-2-900f6f9141d5@arm.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 3 Oct 2026 06:40:04 +0100
X-Gm-Features: AclHuK-raSbvsi6nx1_FiMNjaF3hSOBY1VtMso2CulEM5QcP-MF8bj89v6-J2HA
Message-ID: <CAFLszTh8mPZRmvY3zNwtj2Qi5sAi9SJ2Zo_HU20eUXyLk__U9A@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] efi_selftest: add minimal fmp test
To: vincent.stehle@arm.com
Cc: u-boot@lists.u-boot-project.org, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, 
 Sughosh Ganu <sughosh.ganu@arm.com>, Udit Kumar <u-kumar1@ti.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Simon Glass <sjg@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Vincent,

On 2026-10-02T08:37:46, Vincent Stehl=C3=A9 <vincent.stehle@arm.com> wrote:
> efi_selftest: add minimal fmp test
>
> Add a minimal test for the UEFI Firmware Management Protocol.
> At this point the test only does the following:
>
> For all handles in the system with FMP,
> - Get current firmware images info.
> - For each image, verify consistency of the flags, with some attention to
>   authentication.
>
> This can be tested on the sandbox with the following command:
>
>   ./u-boot -T -c "setenv efi_selftest firmware management protocol; \
>                   bootefi selftest"
>
> Testing with multiple handles supporting FMP can be done by enabling
> both CONFIG_EFI_CAPSULE_FIRMWARE_FIT and
> CONFIG_EFI_CAPSULE_FIRMWARE_RAW.
>
> Signed-off-by: Vincent Stehl=C3=A9 <vincent.stehle@arm.com>
> [...]
>
> lib/efi_selftest/Makefile           |   2 +
>  lib/efi_selftest/efi_selftest_fmp.c | 240 ++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 242 insertions(+)

> diff --git a/lib/efi_selftest/efi_selftest_fmp.c b/lib/efi_selftest/efi_s=
elftest_fmp.c
> @@ -0,0 +1,240 @@
> +     if (desc_size < sizeof(struct efi_firmware_image_descriptor) ||
> +         __builtin_mul_overflow(desc_size, desc_cnt, &total_size) ||
> +         total_size > img_info_size) {

Please can you use check_mul_overflow() from <linux/overflow.h> rather
than the builtin? Nothing else in lib/efi_selftest or lib/efi_loader
uses the builtin directly.

> diff --git a/lib/efi_selftest/efi_selftest_fmp.c b/lib/efi_selftest/efi_s=
elftest_fmp.c
> @@ -0,0 +1,240 @@
> +             if (!IS_ENABLED(CONFIG_EFI_CAPSULE_AUTHENTICATE) &&
> +                 (attr_set & IMAGE_ATTRIBUTE_IMAGE_UPDATABLE) &&
> +                 (attr_set & IMAGE_ATTRIBUTE_AUTHENTICATION_REQUIRED)) {

Just to check, is there a reason to limit this to updatable images? I
suspect AUTHENTICATION_REQUIRED should never be set when
authentication is disabled, so the IMAGE_UPDATABLE condition could be
dropped. Not a blocker though.

> diff --git a/lib/efi_selftest/efi_selftest_fmp.c b/lib/efi_selftest/efi_s=
elftest_fmp.c
> @@ -0,0 +1,240 @@
> +     int i, result =3D EFI_ST_SUCCESS;
> +     efi_handle_t *buffer =3D NULL;
> +     efi_uintn_t count;

Since count is an efi_uintn_t, please can you make i the same type, to
avoid the signed/unsigned comparison in the loop?

Regards,
Simon
