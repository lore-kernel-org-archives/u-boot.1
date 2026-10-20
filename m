Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8D8606A322
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 17:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Oki+33yu;
	dkim=pass (2048-bit key, unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256 header.s=s2025 header.b=lsuYDfIv
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A2A784087C;
	Tue, 20 Oct 2026 17:41:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XJOevW5a2tZr; Tue, 20 Oct 2026 17:41:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 17BAD40874
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792518084;
	b=ivELxyOywfwesQvoV2/GGD8bvqvd50vhIOMhWmpkK42aW1JFWvMXXe1BMDDp+Mu5pNL4
	 mIA2mmuKpgLeeZY4asumCmasp975tiDmuIjgTmmwHeWmx6+fGmpuJQ86iwlBbsd1qv2L9
	 sOAxLXANIPZ88iRaeOFJCy7+6OtOj/ChFhL9LLAVIh1XgOqomzarNbxb0KZVtmcQVtseT
	 eNiszsBEpI0CTvNUrOTUxr2Rl+h7laYmOHIS1eMLmW/s8OUxdEfPdFpPdxCDqMHyZHFcK
	 Js+w/KlJzSyDFWhsiWw0mFGBrmihZfmVsuGREivFzFP0mm9sEKO4M/7EqgifEWdgDXw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792518084;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:From:To:Cc:References:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=1j+mLZdm8nWbMokoOXE+C5qt3llrTDt6jSXw+poso6Y=;
	b=UbKa+fKiuzEhHLPlUff3+HL98njVBZOy2HYwhe4yxaA8QppRrv2dro9ljuqPAjtHMOQi
	 ayZ0msRXfjnQ6B3MxeF5n55/63MPQ+6SOWvlYZcyP1fuNIo3bebQhoFqSFaQnVTDP+Rg2
	 B90pOV6YeaXeYQKk8MWD9IYO5xWpV2fQoc+TMn7+POtU5/gLJtNpjXhvzup0g9ieUyMZu
	 tfVPpPu8T4oMmnJieBJ8P5je4BmLAP6Y8h3SAdWzfy4WMatTs9Sk9wXWzAFuTKT1eiHMx
	 GhvwVlC3eTjx8ZLz/H0jsXD/cE2fsIuXYdaWYT7hW4LxPKWvG/zsZ6DWUlamEHFIzFw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792518084;
	bh=1j+mLZdm8nWbMokoOXE+C5qt3llrTDt6jSXw+poso6Y=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Oki+33yuLComk6vt8/67FROlyQMN7FYH8w7LTkM17imhTyLF0xyuN869CXerlqHXX
	 9Z08iuNuELMqKdtxs547LiPe2aWwQXN0h4EvQ1EmdsRM1a/WPaSF1BghR3mDt2vCV9
	 HmVHgRDWDfa3B/odDyt6ZWlptuGr0+XjWJ5Q7Ct5MROEqdDCLyserbW+HgQfdx+rGJ
	 1Or8iVznGoo7bUrlvT5wd5j65VQJszxi3edbL8gyxd77/IfETbj6FWNxNHyXru3fx8
	 FVcZLw6IMXqYV1/jpUCeaXYxsvdNb3Moc61LMxbOC0cnFwd76yAevAk2JA/Y1B4he5
	 WBOiFMyP8OYuw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 17BAD40874;
	Tue, 20 Oct 2026 17:41:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id D42D82E0
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 17:41:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BA1326075F
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 17:41:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QRdkjpJX222H for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 17:41:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1571B60758
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=116.202.128.144
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792518081;
 b=Eu0qnEh7kbkc+0sRGQqRLMRR6Iql0gkPpuwGZWqdwlrarmLU/hCBejOYq+J/TdhFgIyc
 e+qlWCzveru2EQfTGVAXgYvCndJMCAzwhA53xT6UiUyA67cVh/xc3UPM8YONhX8KdMatA
 oJLjOdFwNXkSlfNFzn5wb/Yci+9ST+EayYytbIIhOQ4OBJ16HSgnjYWhZwy9WWg5y0YS0
 9S5jWwl/H6a2R70t1KJAANHUTWcqzTwX37dEm36Y0KidiIjtLzf1zjDsK/tVXPDZXi7YC
 0YtXRl+YhG2u3tflzrHTU5+pfaUjLnXIDGmnGD02IRp7D7umTF6Pv4Q1y5RzQRGWSpg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792518081;
 h=Received-SPF:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
 User-Agent:Subject:From:To:Cc:References:Content-Language:In-Reply-To:
 Content-Type:Content-Transfer-Encoding;
 bh=1j+mLZdm8nWbMokoOXE+C5qt3llrTDt6jSXw+poso6Y=;
 b=DOoKQ6GVvq/ETxYrO29hE9bumhRsAear40eKpHnxXhi/m6quD0kI9sK2Kc1waLbfaC58
 emsymPqJsEnmnI6jbGorCAcChyzZ+di8vodGaLFGOo9Ry6VfZER1Cl3xkfF2hKd+i6Kt2
 LVgDRfwUkoNjmZoYMMGhUktTip2dei5Wp1lblKgw/u2eE9jnwiUajYcqUdaZyOVfH0f9y
 Yp0LdxFOpQunxo8ORMWBkSTLj5DJVzs5YA2DG+RdIO8CcJcCOP3pPIk6uX7ps23pLhvGd
 iDgQGlsEm7ap2vLq/CPIQLtM0SNu93yJik/UwET3L4+Q9zuQJZa3k7OcV8jnYlgVprQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=freeshell.de;
 dkim=pass header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=lsuYDfIv; 
 arc=none smtp.remote-ip=116.202.128.144
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=116.202.128.144;
 helo=freeshell.de; envelope-from=e@freeshell.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=lsuYDfIv
Received: from freeshell.de (freeshell.de [116.202.128.144])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1571B60758
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 17:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1792517994;
 bh=1j+mLZdm8nWbMokoOXE+C5qt3llrTDt6jSXw+poso6Y=;
 h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
 b=lsuYDfIvzbD/hxYbPuxZxq4qdPYkPtUPUUA146HPN4N6bQttTUfJagNul0Fp14vIE
 P44X5xWb9sSFyykr06osO6TlFtsM6CXwzKH7lBNyfam3ATbfut9mgnqzKjZMp9KZLL
 aKMG4Ce6IVNsetpmlbneSTDcWAGVzvW5BIxrUC9mbPjUfWhnAgqsNg8i1yCjFU7pZd
 sg5sXP5+Gh4K8v5Pm7bcsGsEnH+bDbK7DSLdQO2U0wVIcAPlMi1vkEA08M6eqZmCjh
 Iam9yZmQGzt9KXgrAnOnWP+OQQJ66CZfZzs54wKJH8qPQ4wyCgmpGi9ABApxfUY9Vh
 hV7QZZJGmlJ2A==
Received: from [IPV6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc] (unknown
 [IPv6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id E145DB220F73;
 Tue, 20 Oct 2026 19:39:53 +0200 (CEST)
Message-ID: <d00305cc-bc14-464c-b0df-f44bc7b1ade7@freeshell.de>
Date: Tue, 20 Oct 2026 10:39:52 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] riscv: dts: spacemit: add 24c02 eeprom on K3 Pico-ITX
 board
From: E Shattow <e@freeshell.de>
To: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>,
 Yixun Lan <dlan@kernel.org>, Tom Rini <trini@konsulko.com>
Cc: Aurelien Jarno <aurelien@aurel32.net>
References: <20261019014044.698294-1-e@freeshell.de>
 <20261019014044.698294-3-e@freeshell.de>
Content-Language: en-US
In-Reply-To: <20261019014044.698294-3-e@freeshell.de>
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
> The K3 Pico-ITX board includes a 24c02 eeprom, that stores the product
> name, the part name, the MAC address of the network interfaces and the
> board's serial number. These values are also exposed via an
> onie,tlv-layout nvmem layout.
> 
> The eeprom is marked as read-only since its contents are not supposed to
> be modified.
> 
> Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
> Reviewed-by: Yixun Lan <dlan@kernel.org>
> Link: https://patch.msgid.link/20260623204431.498700-4-aurelien@aurel32.net
> Signed-off-by: Yixun Lan <dlan@kernel.org>
> 
> [ upstream commit: 930491838c55c41317da9f263e3e9b013cb9aaa8 ]
> 
> (cherry picked from commit 3146b373c9699a456fa58b56a23d1127096cbc86)
> ---
>  .../src/riscv/spacemit/k3-pico-itx.dts        | 30 +++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/dts/upstream/src/riscv/spacemit/k3-pico-itx.dts b/dts/upstream/src/riscv/spacemit/k3-pico-itx.dts
> index dde6028a5ef3..143bf6f41260 100644
> --- a/dts/upstream/src/riscv/spacemit/k3-pico-itx.dts
> +++ b/dts/upstream/src/riscv/spacemit/k3-pico-itx.dts
> @@ -47,6 +47,36 @@
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&i2c2_1_cfg>;
>  	status = "okay";
> +
> +	eeprom@50 {
> +		compatible = "atmel,24c02";
> +		reg = <0x50>;
> +		pagesize = <8>;
> +		read-only;
> +		size = <256>;
> +		status = "okay";
> +
> +		nvmem-layout {
> +			compatible = "onie,tlv-layout";
> +
> +			mac-address {
> +				#nvmem-cell-cells = <1>;
> +			};
> +
> +			num-macs {
> +			};
> +
> +			part-number {
> +			};
> +
> +			product-name {
> +			};
> +
> +			serial-number {
> +			};
> +
> +		};
> +	};
>  };
>  
>  &i2c8 {

Drop this patch that landed in u-boot dts subtree with
devicetree-rebasing v7.3

-E
