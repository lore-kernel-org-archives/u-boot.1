Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5654A606A331
	for <u-boot@archiver.kernel.org>; Tue, 24 Nov 2026 06:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=FmbnU3wa;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=pigmoral.tech header.i=@pigmoral.tech header.a=rsa-sha256 header.s=zmail header.b=XcnKUKKN
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0B9AF80ED1;
	Tue, 24 Nov 2026 06:34:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RHnqfWGgfatl; Tue, 24 Nov 2026 06:34:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org ED8EA80D48
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795502081;
	b=PpeTuiqVufszWEjU8w2eq3BKgceMIWyIUQeuEjf19jtnNh0nWSlxTomU/xgLDuVwwSHT
	 /aHcpgAs8igCTyLmA7qKrb++einPbouS2jDtIxkFgBf8tMpFBmYmSVL1znoINUF6YO9kk
	 HuNJ+sx99UtgNB5QoOxlJG2TWD5XdCnrH2qpj/A/mFi6mV6urKva+y01tsRXHNVKbdEBG
	 9Lbe3DokDJTfvH4LV/hfhVsC9C3PboZsLqda4GD9ljvcTCcA00e2lRfj9Fa501b1uY30M
	 YklPq97cZvF3wtq6sqr5s9j1jNIzEqzPBw4GZD+thTNyvI0/wnHNpPh93bPnqT8KKZw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795502081;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Mime-Version:Content-Transfer-Encoding:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:X-Mailer:References:
	 In-Reply-To:X-ZohoMailClient:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=NHAOjR+f3gwTWiATLIoknlKBiadP+0kUrpCvqqDEfeQ=;
	b=nIe70psLQKPOCJ7BUo1gGEOi2+EtVOzxxCXHG1kC/B43OnN3lVurbxbLl5pZ6ygFvXTv
	 oyCUVdidI7i9/J/4NyVzBhyd05kOw/jIOdb49epEUgJzsjwsVIShtPvqfFxvUOhvAbvzY
	 qof4Ol8GpqMmkgY1xXtlKxJDV6IaEOrK7u6aZHKVjqa1tC/4tLq+5ANU/TVtabXFEuK3d
	 RqpbxvwooBeLw0GX+diiUpSIR3IQ5ntL3DEKDS97WCHI3VaJ6ux9E4jOo1FlFR3LLTlLk
	 tZmx9yVxqJ+vQL9FqhCYyC2296MLb+S6olgv0AzkRQyYzfPFNJKBiK9380D737lv9tA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795502081;
	bh=NHAOjR+f3gwTWiATLIoknlKBiadP+0kUrpCvqqDEfeQ=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FmbnU3war2OtjUEMegX29DS80pfuR3EVUmZiBTmaJQ1bmDprIe4Crkt9U0SnAwLaO
	 mIA4Y3R9usC+Dl3vLmHnbYuls2RvSieKm4Lt6ty9Xu1r2LonzMI0wJgb/Btqw98CXJ
	 CV/9EEC2DtEQLADJGLVd55I80fdYT3jCoHZVwwImvRchysnVMmYdTFzTmAFUSDVsue
	 SwMmI8ABKnb40DsJfT1B94v883toyD6NeYG28IPT3Qij+nOEx2daOlTIhDnlDVwChd
	 tR9LVTO1+t0DzucMW293dwq+2NJdC3VdTYKD1+ag0AMPK44hHWKnOxByLg4JDKW9g0
	 di9HifxOfWzyQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id ED8EA80D48;
	Tue, 24 Nov 2026 06:34:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 51A6D3A8
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 06:34:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 37F07400AB
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 06:34:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4MiWqOiDieEX for <u-boot@lists.u-boot-project.org>;
 Tue, 24 Nov 2026 06:34:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 9384B40068
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.180.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.180.15;
 helo=sender6-op-o15.zoho.com; envelope-from=junhui.liu@pigmoral.tech;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=pigmoral.tech header.i=@pigmoral.tech
 header.a=rsa-sha256 header.s=zmail header.b=XcnKUKKN
Received: from sender6-op-o15.zoho.com (sender6-op-o15.zoho.com
 [165.173.180.15])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9384B40068
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 06:34:34 +0000 (UTC)
DKIM-Signature: a=rsa-sha256;
 b=XcnKUKKNcao4ZIJRxBdo7llqeZAqwrx/jmEcUtljYnH9EVOBT0n2wVN6h3T4IoWc/QBGWAhMYBaX9Td8WRWbm8a/7j7qvUnx79Pj0UjDZ7jqYPHqgnHyUP4cxM/hH5E4kqOfXJXLDF6TszrPRkGtiEDbGczAQ+b3dT6Fwdj3Rqs=;
 c=relaxed/relaxed; s=zmail; d=pigmoral.tech; v=1;
 bh=NHAOjR+f3gwTWiATLIoknlKBiadP+0kUrpCvqqDEfeQ=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795502042316279.0763964014517;
 Mon, 23 Nov 2026 22:34:02 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 24 Nov 2026 14:33:54 +0800
Message-Id: <DN38CNP2NRX5.2FYONBA01NUVM@pigmoral.tech>
Cc: "Dave Klotz" <DaveWK225@protonmail.com>, "Eric Chung"
 <eric.chung@riscstar.com>, "Hung-Chun Tseng" <alan.tseng.cs@gmail.com>, "E
 Shattow" <e@freeshell.de>, "Yixun Lan" <dlan@kernel.org>, "Tom Rini"
 <trini@konsulko.com>, "Guodong Xu" <guodong@riscstar.com>, "Raymond Mao"
 <raymond.mao@riscstar.com>, <u-boot-spacemit@groups.io>
Subject: Re: [PATCH v2 6/6] riscv: spacemit: k1: Enable GPIO and pinctrl
 support in SPL
From: "Junhui Liu" <junhui.liu@pigmoral.tech>
To: "Anand Moon" <linux.amoon@gmail.com>, <u-boot@lists.u-boot-project.org>
X-Mailer: aerc 0.22.0
References: <20261123193714.5096-1-linux.amoon@gmail.com>
 <20261123193714.5096-7-linux.amoon@gmail.com>
In-Reply-To: <20261123193714.5096-7-linux.amoon@gmail.com>
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
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Anand,

On Tue Nov 24, 2026 at 3:37 AM CST, Anand Moon wrote:
> Enable GPIO and pinctrl support in SPL for the SpacemiT K1 SoC.
>
> Select the SPL driver model GPIO framework and the SpacemiT GPIO
> driver, along with the pinctrl framework and K1 pinctrl driver.
>
> These drivers allow SPL to configure pin multiplexing and access
> GPIOs required by early boot peripherals, including I2C, MMC and
> other board-specific devices.
>
> Cc: Dave Klotz <DaveWK225@protonmail.com>
> Cc: Eric Chung <eric.chung@riscstar.com>
> Cc: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
> Cc: E Shattow <e@freeshell.de>
> Cc: Yixun Lan <dlan@kernel.org>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
>  configs/spacemit_k1_defconfig | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/configs/spacemit_k1_defconfig b/configs/spacemit_k1_defconfi=
g
> index 0f6e9284259..6c60ca789a9 100644
> --- a/configs/spacemit_k1_defconfig
> +++ b/configs/spacemit_k1_defconfig
> @@ -121,3 +121,8 @@ CONFIG_USB_DWC3_GENERIC=3Dy
>  CONFIG_USB_STORAGE=3Dy
>  CONFIG_USB_ONBOARD_HUB=3Dy
>  CONFIG_SPL_LIB_RATIONAL=3Dy
> +CONFIG_SPL_GPIO=3Dy
> +CONFIG_SPL_DM_GPIO=3Dy
> +CONFIG_SPL_PINCTRL=3Dy
> +CONFIG_SPL_SPACEMIT_GPIO=3Dy
> +CONFIG_SPL_PINCTRL_SPACEMIT_K1=3Dy

As I mentioned in your v1 series, CLK_AIB and CLK_AIB_BUS are still
missing from the SPL clock driver, but this patch enables SPL pinctrl.
Once the pinctrl controller and pin configuration nodes are retained
in the SPL DT and used by a device, K1 hangs during boot.

--=20
Best regards,
Junhui Liu

