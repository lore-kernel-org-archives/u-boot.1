Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE0C1C44529
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 19:31:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6E39280D3C;
	Mon, 20 Jul 2026 19:31:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OXJ-fh3PuSmN; Mon, 20 Jul 2026 19:31:04 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1D78B80B9A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784575864;
	bh=lpBTD29ANYJUL0jzeXKVgGNTpg0WKp9/9qR7dWM31LE=;
	h=Date:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=q0Ob06YfvB4z3ymo/Nmx4MXrIDSW4VFgiQPz3Iw9IA2oJSd64l1gN426qHO7C7rPX
	 eJPa560bWMATxVByQ1EQdAY1yLY+Pj8Sdcq9d+VkNpVRW94YhOdfPTwhyPeRGkHXB+
	 ks7wPBeMMPerWuVyDF+EWONUr/g5RVV5UjdPuhEGjh5skmneWXsIrkoAfUDnLS+hON
	 x7XxuNEzld3BjXFWxwtowKl9lfBfI77Uvj5Rlh2GMW1NLDTmSRe4HVdqjd8702WERn
	 K+c472GDuwntup0Yqubqdcj6YUtUicMK5wIj1OLzgv1X4mNKt+G199ytIApPQ2VyIe
	 GiZMDyghqsBLA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1D78B80B9A;
	Mon, 20 Jul 2026 19:31:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6A303786
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 19:31:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6779580B9A
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 19:31:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kfkHkIOXeIaV for <u-boot@lists.u-boot-project.org>;
 Mon, 20 Jul 2026 19:31:02 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 1FAF080B8F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1FAF080B8F
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1FAF080B8F
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 19:31:02 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id AFB0683C14; Mon, 20 Jul 2026 21:30:59 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 816CB82991
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 21:30:57 +0200 (CEST)
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7eb4d8a21a8so4645382a34.2
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 12:30:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784575856; x=1785180656;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lpBTD29ANYJUL0jzeXKVgGNTpg0WKp9/9qR7dWM31LE=;
 b=ijDjB6us+w6OicFvyGHQPVS7igrny1xRCQcL+7YSRAJjGj46lOaCl7hgFEp9FmbMD6
 xlUOcx48Dhr44X/RGVd8mn34HpGHh2/c1OQvxim35PBJeHgpaWCxRA04vTSXeguE0D0M
 yv4UApJu66mtcM8zBRyUSfL5xV+NTaosE9y6f0r5K49/yLLhFOQnjG6mvmDnsXoZWblt
 CQLAtsE3hEcUQyBDPzjw6mqF5Ijtl1uyWY4PpPjrcJ8HT3yEjbpNKwbigCpBtqjPHiIw
 zVcOXOSI1UuNypzLgAvgTBA8zJgq0mkJFWMJ9O16R9mMFdbW2QyjZDv2KDutSQwPeAMs
 e7Sg==
X-Gm-Message-State: AOJu0YxsHtDLCNoDSLipaqyq+xy7pow62upUvjBL5GCvT+ixjwuRqalc
 HNo2ZUkPSq0QyCVSEMBvOM6dkzrNjU+GXVXUkobt5+Nz3LX6lMuj059DNRe5M2u0r9w=
X-Gm-Gg: AfdE7clAG3JyoWnF7ZfHTYFRTsZsiBjJUaz6DuSzFUi6TZB4/NjD5y/uCydBQ+fCJex
 izMlH+sAElv4SzqAM4quc9x3pfCINIRHK6IFrAOlqKhCIcYtTz+YCX4Z7P3+Q/rwCfP/fQGOlb5
 wTBbtf3isdZrOtrk4acU1y/tijJlNGyQw0I9V3NcLgiaLBnRbCfDWHJZ76r0u9nQXET3eSeUuK5
 wyuH7t4H/At81ENW0ERf5lfaEM2+fUitgQijko/xQgp9ahhpO9XqM90Jjjg0nSq0yg0JRPS8AUr
 sPS9xSJnB4Qbp7AunSBgKBivgLh2RZrRMaLkoEHS+fo+kBLSYaICpSTtdfsTC8PPJbNo2HFpdyK
 FSJmW0jAYuDxk0Of+TPeDdSs/2aZk6l9Luqw2ezE4IbqllRCnt6FQP7DfnfLb6rrvdsZagloV0d
 c57O9vvUPQRyZR45FYjWf/QtNc5xjyDeAsPn0ZFyyMO/jkwWm18riUz3JUwDuviAl4Jc3svnAFO
 WMPkKQmKJlso6gh8ZJSOSGqpdE=
X-Received: by 2002:a05:6830:82bd:b0:7ec:6749:f38d with SMTP id
 46e09a7af769-7ed941f0623mr9170619a34.0.1784575856005; 
 Mon, 20 Jul 2026 12:30:56 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7edad918e81sm8878782a34.6.2026.07.20.12.30.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 12:30:55 -0700 (PDT)
Date: Mon, 20 Jul 2026 13:30:52 -0600
To: Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>
Cc: u-boot@lists.denx.de, ryan_chen@aspeedtech.com,
 chiawei_wang@aspeedtech.com, BMC-SW@aspeedtech.com, joel@jms.id.au
Subject: Re: [RFC PATCH v1 1/1] arm: aspeed: Add ASRock Rack B650D4U BMC
 support
Message-ID: <20260720193052.GI749385@bill-the-cat>
References: <20260719121752.88393-1-prasanth.padarthi10@gmail.com>
 <20260719121752.88393-2-prasanth.padarthi10@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="V1sHdmQ1EcMF4v1c"
Content-Disposition: inline
In-Reply-To: <20260719121752.88393-2-prasanth.padarthi10@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1784575856; x=1785180656; darn=lists.denx.de;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=lpBTD29ANYJUL0jzeXKVgGNTpg0WKp9/9qR7dWM31LE=;
 b=JQCQj4xOJ0v8oQ2Ckc3coL0SaS2C2hy8oZmAPWfFbK/2HRFqHp5QbvpvF7j+RQ5heC
 AXgjP00zRgHghX6i+jdViIDb0Owgjf1dqLY9fExRv8ozyql4XoNcZ3DQY+I6/tNP78wU
 UW6TGu/+CyRKnXkPxGBMQtxBvnEB98WzgQFwA=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=JQCQj4xO
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=trini@konsulko.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JQCQj4xO";
 dkim-atps=neutral
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
From: Tom Rini via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Tom Rini <trini@konsulko.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>


--V1sHdmQ1EcMF4v1c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 19, 2026 at 05:47:52PM +0530, Prasanth Kumar Padarthi wrote:

> Add U-Boot support for the AST2600 BMC on the ASRock Rack B650D4U.
>=20
> Describe the 512 MiB DRAM, UART5 console, watchdog, 64 MiB SPI
> NOR, RTL8211F-connected MAC0 and RMII/NCSI-connected MAC2.
>=20
> Use the existing AST2600 EVB target infrastructure and a
> board-specific defconfig.
>=20
> Signed-off-by: Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>
> ---
>  MAINTAINERS                      |   6 ++
>  arch/arm/dts/ast2600-b650d4u.dts |  74 ++++++++++++++++++++
>  configs/b650d4u_defconfig        | 115 +++++++++++++++++++++++++++++++
>  3 files changed, 195 insertions(+)
>  create mode 100644 arch/arm/dts/ast2600-b650d4u.dts
>  create mode 100644 configs/b650d4u_defconfig
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d4b527560aa..52aefd17217 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -213,6 +213,12 @@ F:	drivers/reset/reset-ast2500.c
>  F:	drivers/watchdog/ast_wdt.c
>  N:	aspeed
> =20
> +ASROCK RACK B650D4U BMC
> +M:	Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>
> +S:	Maintained
> +F:	arch/arm/dts/ast2600-b650d4u.dts
> +F:	configs/b650d4u_defconfig

This should be in board/aspeed/evb_ast2600/MAINTAINERS since it's just a
build variant. And is the device tree itself being submitted upstream to
the linux kernel? Thanks!

--=20
Tom

--V1sHdmQ1EcMF4v1c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCal53bAAKCRAr4qD1Cr/k
Cg8fAQCNdU3VGyOosgC4bvZZpCN38o0Fd6SOkJrdioWv365KHwD/R1JfZzGMo/H8
OUkcu3+f0JFbOe/y93x3zooG+kOhgwc=
=LFHc
-----END PGP SIGNATURE-----

--V1sHdmQ1EcMF4v1c--
