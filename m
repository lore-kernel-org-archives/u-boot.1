Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138FF606A323
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 17:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=EjegjBqO;
	dkim=pass (2048-bit key, unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256 header.s=s2025 header.b=Ur2xkEzz
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DB987607B5;
	Tue, 20 Oct 2026 17:40:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aMs6vxeZK8j8; Tue, 20 Oct 2026 17:40:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5AF9B6075F
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792518040;
	b=Lcpg67GUvXb1gcmbwAJdQJwzC4BMEpSlwl/vCC+035coazDY1R3+OzkFYzyX6Yp7mGzw
	 gCRo1zm+n1BVP9afTQgRmLdwN9hj0VqLSJ3fB2vZ5qMEe7VbfDEX2Lg6SR67A/O4qMqiF
	 yG10538JVc5lJgD9RAB73NwCAFkNkEc/AXzYQnR0Bl2E5Dz6vZA2lGn/S2qe70btCEbdc
	 dEXcqx3jmIykmbG1oslvjB9JJOynCmXTqu6BPpOCx6JWE1yIPjbfB6V9wkio23Y7IXovU
	 tjHhMZ3FgKs41L49jd2eOJTRIU7in1VnfbSLm/GSZNJz5Sx/jYNfZLr8KHwo4D+NEkw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792518040;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:From:To:Cc:References:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=zMpglnHg11hJOKTAkMy0h+U7jO9DKfZR9p40IU9YpvI=;
	b=HFjBTNvw1XxyVuqTyuz1j87nU1QyGZjnKorRVOP7blKQIiioT9aMHl1CTrOmp06NpVKH
	 wcFIzBNpsxmQ2byl5Z9EOhQJAvUeLr0TdCC0OLYS5S/DGlTniIYh0rDaopX/yyQUxKx/E
	 BuyWOMOk7oZsZE7DSKCUuTAOiNC1v8i0LEn7f0re9uvfLMnJrYo1AWP0/B/hA6ImoT4p0
	 kjkTC0QNEni3waVmaTN5PbWU+sJouCbG3ylSq4/gzWusqiMyRnsGZ6QtoBdLjJIPqYUXf
	 WAHIKWsc2zRFQjsJzGZr7/vBPUEGnjZ4Yt66WdxFWuFh9yu1AKDKWGxgGbDNzkxyqzg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792518040;
	bh=zMpglnHg11hJOKTAkMy0h+U7jO9DKfZR9p40IU9YpvI=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EjegjBqObUcQK+Jghpv2OaRul7ThSi2Jfh+9JbFeInrfrwUThENhU24qf1myemta8
	 xBoNWkbr2sH9XfS7C5/1ysMOIadzGiV4lrhxa3DrRdOxLCa8rsyCMTvFIsDkiyNbUZ
	 ufc+1JuOyga4VZLmZEzl1nESe0a365FTg8BYhOgphaeF9OvQK68rZGQiJ6ini4QY9H
	 84U5Ma0Y22MCH4K3jJLgerD99Kcurr2Ov583rvr5wlEEZoPjGsAJtbaGJNNRQHC2i1
	 IM/J1IAapiD0XWkWonnERL7sdr063MM4LTL7tSjqIiYwbzoUA1gvE3MN4t3A6lagYL
	 aCycwTaoFq66A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5AF9B6075F;
	Tue, 20 Oct 2026 17:40:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 33D553A4
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 17:40:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 241BF80F50
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 17:40:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id K8UhJDDVi2Un for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 17:40:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A9CA880F22
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=116.202.128.144
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792518036;
 b=Z8GtLzuZM2K6DFG6V2dmzYfmAoPuG1kb0rKIJMV4TC6N7sIMj0x3pYoyrLdpJDkuHTIo
 /A8Y8ycUgMvMEJumbPJqSphIbBhR3fc3akRybiyU5vePhS8Qh0r45oAtJdWzcXqJiNwQR
 IGiyqi72mzgXbmFwK9m8IJ250vd/eWLoAxz43cP/+PfOqs1fJ2zkue+0e7l3sptJUhNtS
 0mgq/8RCborKdPINBSWIXKrS62GFhbZaisWsI+0aR7+p89Go4jSMWc/5bOMbdMhn3Ntzk
 WPt7BEJVCrfCl7XqwmmsZs/4EQYab+pDCxPQID70ZuOhOrWxpgeiLkf1sPDxAXLiWzg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792518036;
 h=Received-SPF:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
 User-Agent:Subject:From:To:Cc:References:Content-Language:In-Reply-To:
 Content-Type:Content-Transfer-Encoding;
 bh=zMpglnHg11hJOKTAkMy0h+U7jO9DKfZR9p40IU9YpvI=;
 b=hRyIevqEBJjaW3ltamBL/H+53+W6HZhyhtBler6Qjjejop7PdJ95QsKN5wbyj9KNXnSA
 WATyyQhlP0q2hH+tAjmaFJrmuk6WvArgJag2KHxJ3sNgltYk1VLr75bJO9ItLTCwNBlLh
 fkmiUtQsVkb40DcY1m5kqRwdG8pLgpL8NOPLyqDanVnfOMxlflceV4eCHqfTvbIpD/DPi
 DYWwg7OAnQKw9FNplgGThwfoWwvpMe4JwFgrliS091ueZWJrPavWWS/zU8zAhsTwg25Xi
 JLdA03Qkg0ULx6q4KZSTF12MMnAnMMi6w5iz5NmPVDj8IHat9X5+KzPwWotCgsLo8Vg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=freeshell.de;
 dkim=pass header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=Ur2xkEzz; 
 arc=none smtp.remote-ip=116.202.128.144
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=116.202.128.144;
 helo=freeshell.de; envelope-from=e@freeshell.de; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=Ur2xkEzz
Received: from freeshell.de (freeshell.de [116.202.128.144])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A9CA880F22
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 17:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1792517980;
 bh=zMpglnHg11hJOKTAkMy0h+U7jO9DKfZR9p40IU9YpvI=;
 h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
 b=Ur2xkEzz3gK+KGtCLtSkclhlSmuQtOT0wxnT3b3bc+hcXnpYwA5cmf+gr6Rhg/8Fo
 UYKsIsQcO21+INdk0yVnmxgTebibhrFZQMvhHkPXiWRDIPslz7Aop4QtFqxTCsnvQs
 TkyvcvP8ql2Tq/eMd+02BaP6Drk5DikZb6sCKAjkGZq4BM0AYggEA+Gh/Ew9TejjJT
 lPVr8kHWi0pFSvlkeSc9w75hiKwXsuOFW44gxxj8x1VRVdR/11FAcPqsqxlZHnb9HY
 J20klomWaEndO4odcFLp1jrKpZ9rVLQo44ZiJ7hPMrwFQ/OE9WzZPgFmJVB/oc55cX
 TmFT7VPvqf+jA==
Received: from [IPV6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc] (unknown
 [IPv6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 29DACB220F93;
 Tue, 20 Oct 2026 19:39:39 +0200 (CEST)
Message-ID: <79703d30-2f14-4b74-aac5-504f9d4f9c26@freeshell.de>
Date: Tue, 20 Oct 2026 10:39:30 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] riscv: dts: spacemit: enable the i2c2 adapter on K3
 Pico-ITX board
From: E Shattow <e@freeshell.de>
To: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>,
 Yixun Lan <dlan@kernel.org>, Tom Rini <trini@konsulko.com>
Cc: Aurelien Jarno <aurelien@aurel32.net>
References: <20261019014044.698294-1-e@freeshell.de>
 <20261019014044.698294-2-e@freeshell.de>
Content-Language: en-US
In-Reply-To: <20261019014044.698294-2-e@freeshell.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 10/18/26 18:40, E Shattow wrote:
> From: Aurelien Jarno <aurelien@aurel32.net>
> 
> Define I2C2 pinctrl properties, and enable it on the K3 Pico-ITX board.
> It will be used by the 24c02 eeprom.
> 
> Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
> Reviewed-by: Yixun Lan <dlan@kernel.org>
> Link: https://patch.msgid.link/20260623204431.498700-3-aurelien@aurel32.net
> Signed-off-by: Yixun Lan <dlan@kernel.org>
> 
> [ upstream commit: 48dd3d020528e05795dfa46308ba5b59a1835bba ]
> 
> (cherry picked from commit 5b8d10184a9e7fb8b31d279e09e3673b8d69f690)
> ---
>  dts/upstream/src/riscv/spacemit/k3-pico-itx.dts |  6 ++++++
>  dts/upstream/src/riscv/spacemit/k3-pinctrl.dtsi | 11 +++++++++++
>  2 files changed, 17 insertions(+)
> 
> diff --git a/dts/upstream/src/riscv/spacemit/k3-pico-itx.dts b/dts/upstream/src/riscv/spacemit/k3-pico-itx.dts
> index b89c1521e664..dde6028a5ef3 100644
> --- a/dts/upstream/src/riscv/spacemit/k3-pico-itx.dts
> +++ b/dts/upstream/src/riscv/spacemit/k3-pico-itx.dts
> @@ -43,6 +43,12 @@
>  	};
>  };
>  
> +&i2c2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c2_1_cfg>;
> +	status = "okay";
> +};
> +
>  &i2c8 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&i2c8_cfg>;
> diff --git a/dts/upstream/src/riscv/spacemit/k3-pinctrl.dtsi b/dts/upstream/src/riscv/spacemit/k3-pinctrl.dtsi
> index 3ee1471f3798..50dc124c097f 100644
> --- a/dts/upstream/src/riscv/spacemit/k3-pinctrl.dtsi
> +++ b/dts/upstream/src/riscv/spacemit/k3-pinctrl.dtsi
> @@ -78,6 +78,17 @@
>  		};
>  	};
>  
> +	/omit-if-no-ref/
> +	i2c2_1_cfg: i2c2-1-cfg {
> +		i2c2-1-pins {
> +			pinmux = <K3_PADCONF(46, 5)>,	/* i2c2 scl */
> +				 <K3_PADCONF(47, 5)>;	/* i2c2 sda */
> +
> +			bias-pull-up = <0>;
> +			drive-strength = <25>;
> +		};
> +	};
> +
>  	/omit-if-no-ref/
>  	i2c8_cfg: i2c8-cfg {
>  		i2c8-pins {

Drop this patch that landed in u-boot dts subtree with
devicetree-rebasing v7.3

-E
