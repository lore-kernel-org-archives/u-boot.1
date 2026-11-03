Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6C7606A324
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 13:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=sTauYYp/;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256 header.s=zmail header.b=See02LiD
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5ED6F607B3;
	Tue,  3 Nov 2026 13:54:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id X07Rf1NUFERG; Tue,  3 Nov 2026 13:54:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0C65B606CB
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793714069;
	b=oGkIGeB3oUYcwLuJFvf8zvdZlHhisoT49ThUZeYolsMxGuIjrAiXr02ZmQaQA4ypALqk
	 Yxh264PdfAR+4SQlZpW4R/W0jDttIPQu07mIFXw36LyPYrZlcvyEJiPMvj5pz16X/8UU0
	 wk2Edhxn7o8oyV2biEoK2tdN9ZXsPkq4WunU/gAvUklSIazFEyAX+U1OJiVoEfI3jClso
	 C44HpyS1FuSbyTDodkUOYGUR3UoEXc+CqkQlhYPwCRUatN1QoTfHbvAj/sf8+jNY2FcMz
	 +xnl4/8F1NDLpbf0UfYKu9TY8v1PJMqBHZSiyH92WgNtl+69+cq790qFfMFUs+SfA2w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793714069;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Zoho-Virus-Status:X-Zoho-AV-Stamp:X-ZohoMailClient:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=QZ9UjxrKnGyj3Qu/s6qEnbLaZz0YpgWeuKRu7gYauTA=;
	b=pmnnlJFPS0fiWg4KJ7fbC6Dmm+hQJMtrPnAhJoKvorPBpidVvOhvRFF27nefyT35lQhN
	 Tkg5N5bqCDZ4vfD7gZ7wvg8YNX3oY/7Axkog73dx2qPOWXWcmWWHwo3W5O8oroMS/e9fF
	 8UsYl3/RjCqvpf+vNJzoqgoRSynbT+DP1/MAJxXwNv7wPvPju6uxJehYd4CFl/cVuHPFV
	 UJp4MBFF+ZSpHBDrhtFn9e/YhBbC32oL52pJMJLZUQToDpHJvTtkJd5uCno+ykSOe5kCf
	 eu/g2xhps1mBFwmEeMFL+MvRKkEQ+v2OUDAvZHkR9l7MFa0lzWWg+4sf/tVyTImFY6Q==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793714069;
	bh=QZ9UjxrKnGyj3Qu/s6qEnbLaZz0YpgWeuKRu7gYauTA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sTauYYp/2EiVIlqgvWM57wozYCa/Ai7lTlLWhd/YsPr415pXjCkyWv2RZvaiJ3UDW
	 tjwIJ2N4IPMS0TWLf052lGeNdK+id7QTEA1+gDxkXPWrNlF2B2958biKq4c/vgdEfR
	 23P9Tj7NX414xIYeh3XWjZefL73VJw0nR5JireSctAPiaJKrrDnH8z808f3Z90V+49
	 mkqrF4GEnayj5O+Jl2fvF37UnTGJwmdes0YRmKiv8iAjqXLGssGGRzzMRnJTuKPFt+
	 hjzrcgZdVvr/u7ElWR6ziMigV+FhgwyKAAB5Tv51aKw0P3cYn8PHiNa7fQLgWoXxW0
	 RxGcO/JCOugyg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0C65B606CB;
	Tue,  3 Nov 2026 13:54:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 41463A10
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 13:54:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 326E580F87
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 13:54:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id B4aRKLKIYz6N for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 13:54:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E7B7580CBF
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.180.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793714063;
 b=nWMU1Fw6Y8KuE96v7UNCA+2yms/9zIDPxjy4twQ5kD+GhbplByJlF148sqQUQzJUY1qi
 ewDYD7BrLtTz+TSz1iqqqwcvhYafBFvfpJ5qz+dqf5fWALCczWgtCuDN4tcWL2yYpWU/q
 pWc9frOcoO8lfa3PNCVtgA0feVSe88xt4KlxQQbOj6XxKGgkyNjcW0vS9NjH0vQQlVbMd
 pqF3zK4IJ/2q0lVKtvlI0uzhJlT97kfegSNVnSPeRTUA8aftJvyX5tuKo9tcRLchQXhLp
 buaTr+pwr/R689j9Er+iOG2nokDFZdF1GD+wziJjNvZ+QIku71l68t9W/7Wf7GaIZ3A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793714063;
 h=Received-SPF:DKIM-Signature:Received:Date:From:To:Cc:Subject:
 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
 In-Reply-To:X-Zoho-Virus-Status:X-Zoho-AV-Stamp:X-ZohoMailClient;
 bh=QZ9UjxrKnGyj3Qu/s6qEnbLaZz0YpgWeuKRu7gYauTA=;
 b=mOeqHa4gSoUv/KcBKoN6lI64068b3Q7ZJXvj2kx9G1CP3bh4bxhaBESldH3Gm59QfaZj
 6jTcEAzjXANFrCMJj9nvQ8VCo5OYSHNWMur0DoE0TrEeOcRS2KnqMA1zmPP3yLCL1xK2C
 fwid83sb+wdoks0OQEUK38+fZwlk+5VE6DZGgzDlJaM1/E3oDcZkSAyRZHKi8DIIm5mli
 gSArpOMOtg04T8/kkKlfZQNrt46Y/52M/7ECLhtEyobW19ik99greRzRf4W2ulWQcydV0
 KPyFhxHub358idBcZOiI/26Qgu8xhazQ8YNrfos6X7A/a8pBuLdDQLM1QrvTcAR+Vjw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=ziyao.cc;
 dkim=pass header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=See02LiD; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.180.15;
 helo=sender6-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=See02LiD
Received: from sender6-op-o15.zoho.com (sender6-op-o15.zoho.com
 [165.173.180.15])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E7B7580CBF
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 13:54:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1793714034; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=mwPcmWmzQNpSbGilZ/78pahkrzVAxI4e4S9pNIcv+NXKaZogr/2xuogrgSRFjd4zuH9ydrlfZmCy8OReXl609gVFjZEcn9fynDhcaPQqhYAEkEC1F+enhz20DltOde5DXZCTcrupKS2tuNYaIm4s/IOiq3HnoJXjr+0zW/pjBDQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1793714034;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=QZ9UjxrKnGyj3Qu/s6qEnbLaZz0YpgWeuKRu7gYauTA=; 
 b=JA09d2FRxyfIt4xCslR9B/mWaFwDuUoAMttg80eGAx1f6dAgvCWUV+d7RaXQe/MjOXLt8OzoBELbfApwt7GE5Bycksk+WJjC1cle3pueZ6bcqgqPNbwPXXMnjrVxegyA5OXEFi9GkoGh+WHMEANFDF4Dt7m8HsA92NYgQ6kyvMQ=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: a=rsa-sha256;
 b=See02LiDg10E3ayrbkC30hmcCeYHFwh+cjqxsVGbdkzqk/YwrOXfEbRdLttBz/4m0X8RXXoCCii8aRhfum822qfX99/34U4W3F3dGz+v/S0ew5j1KBY8u6jrcRRdeyRGvMRJlt0LzhGr78B0fsvnnwsd6sa2uZA0aOf6G3FCdvk=;
 c=relaxed/relaxed; s=zmail; d=ziyao.cc; v=1;
 bh=QZ9UjxrKnGyj3Qu/s6qEnbLaZz0YpgWeuKRu7gYauTA=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1793714034029106.67303862885353; 
 Tue, 3 Nov 2026 05:53:54 -0800 (PST)
Date: Tue, 3 Nov 2026 13:53:44 +0000
From: Yao Zi <me@ziyao.cc>
To: Hiago De Franco <hfranco@baylibre.com>, u-boot@lists.u-boot-project.org,
 Yao Zi <me@ziyao.cc>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Marek Vasut <marex@nabladev.com>, Tim Ouyang <tim609@andestech.com>,
 Leo Liang <leo.liang@sifive.com>,
 Kongyang Liu <seashell11234455@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Bin Liu <b-liu@ti.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Andrei Lalaev <andrey.lalaev@gmail.com>,
 Zhuxu Ran <zhuxu_ran@zohomail.com>, Udit Kumar <u-kumar1@ti.com>
Subject: Re: [PATCH 2/8] riscv: cv1800b: add SPL support
Message-ID: <aunnaN0SOzsRBtlG@pie>
References: <20261021-milkv-duo-spl-v1-0-ee7618860237@baylibre.com>
 <20261021-milkv-duo-spl-v1-2-ee7618860237@baylibre.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261021-milkv-duo-spl-v1-2-ee7618860237@baylibre.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/293.698.2
X-ZohoMailClient: External
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 21, 2026 at 09:54:18AM -0300, Hiago De Franco wrote:
> Add SUPPORT_SPL and SPL_CPU.
> 
> harts_early_init() enables the C906 caches and T-HEAD ISA extensions.
> 
> Signed-off-by: Hiago De Franco <hfranco@baylibre.com>
> ---
>  arch/riscv/cpu/cv1800b/Kconfig  |  2 ++
>  arch/riscv/cpu/cv1800b/Makefile |  4 ++++
>  arch/riscv/cpu/cv1800b/spl.c    | 31 +++++++++++++++++++++++++++++++
>  3 files changed, 37 insertions(+)

...

> diff --git a/arch/riscv/cpu/cv1800b/spl.c b/arch/riscv/cpu/cv1800b/spl.c
> new file mode 100644
> index 00000000000..6fd62d66da7
> --- /dev/null
> +++ b/arch/riscv/cpu/cv1800b/spl.c
> @@ -0,0 +1,31 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (c) 2026, Hiago De Franco <hfranco@baylibre.com>
> + *
> + * CSR setup based on the Sophgo FSBL (https://github.com/sophgo/fsbl),
> + * lib/cpu/riscv/bl2_entrypoint.S.
> + */
> +
> +#include <asm/csr.h>
> +#include <linux/bitops.h>
> +
> +#define CSR_MCOR			0x7c2
> +#define  CSR_MCOR_CACHE_INV		BIT(4)
> +#define  CSR_MCOR_CACHE_SEL_BOTH	(BIT(1) | BIT(0))
> +#define CSR_MHCR			0x7c1
> +#define  CSR_MHCR_DE			BIT(1)
> +#define  CSR_MHCR_IE			BIT(0)

MHCR-related stuff looks the same on both C906 and C910
(the TH1520 platform). I did a quick check for C908[1] (used in K230)
and C920[2] (used in SG2042), all of them have DE/IE in MHCR
(CSR 0x7c1), so I think it makes sense to move th1520/cache.c to
something like lib/thead_cache.c to re-use it for your series, reducing
some code duplication.

Regards,
Yao Zi

[1]: https://github.com/OctopusET/XuanTie-C908-docs/blob/master/XuanTie-C908-UserManual_xrvm_20240530.pdf
[2]: https://www.xmosc.org.cn/UserFiles/upload/file/20251230/%E7%8E%84%E9%93%81C910%E4%B8%8EC920R1S6%E7%94%A8%E6%88%B7%E6%89%8B%E5%86%8C_Rev.09_20251114.pdf
