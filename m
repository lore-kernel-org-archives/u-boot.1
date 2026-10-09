Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B49ACA6012
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 07:03:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0064380D21;
	Fri,  9 Oct 2026 07:03:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oUMnAWAYmuXw; Fri,  9 Oct 2026 07:03:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 54E8E81159
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791529410;
	b=ErSe2BZEyAA+BkwsR+a+f22PoR4XugMx8nvO/u/jKiL+fzj0MrS/PMGvq6ZqoUzMSmfB
	 GWUn6Ct8ZHrUVfowwY198SAhTfJh8dDfX8aJQFohxoxsP+Kh/yeOY/iXPYu/5SNvufdoU
	 7r5EbfphQJ2u/VAdDqEuJyBsc9PpmuZ1JIL36lg7WBHJJDgFbejI14ZAFfLNoAqN4yJgf
	 UpdfuktEwou8GjxQzs6v7wbJCDFzyWICkSZpEu44PUZKvMLsQyVkFuOj4gMssL1n+RSTq
	 GcRIditmbGr34UnWhgR9CwGR4KXCnh2ZmD+/tDPDCf8zXTRpXM9+heVggTvyo+DIFww==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791529410;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=FVbVr/SLj/ahirgwJPH49+h2vyuJJWceItNKNu4cfWk=;
	b=rVo34suIpZZlND2UeeQZddEs1Nx93fX14tBen9Y2Wt59R2If5Grhi4MzRDWwWS3M0vIO
	 u6wxkXcBGM8MBwESgE7d8RYr2svDbRqGeBlirMZA54bqQU5FonQbDOLatYMhqfJvFeK0z
	 XItUKQoxQMFwqTNXhUdg2IpecNsYdufbl7pMgxXt8lE0ot4fgJcV2HrWdtLXDkCZXgeiI
	 EI/YsfqhiN0rXU22CltmLGue/r6Bv3mWZPMafdkGnW8KCge9+VduP3Un66oqPvhH0Q/gm
	 K7q3yiUbG0sN+XgA/xg01cu0n+Jz5IqCDdm6XtqC1WYJM8afj/LKPAmiGzNNIzCmstA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791529410;
	bh=FVbVr/SLj/ahirgwJPH49+h2vyuJJWceItNKNu4cfWk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=P7RlgWqCJnzymFSG46ULWMMq4YVg9CVATCtEsZqXd938Kv9Yi5LH6HqEr20LZzOI+
	 +uz/bld5JxXL42z8Mt/pQRsnPnGET8eISuuV/qJrAyBRIMmnZTje/Jn20KLUS5bCX3
	 noScR83+L4UG6Ch2KaTXlcvJd1p3mU/u568NO9C4Jjkql0tDOBzrxQ40fxB7CVoyRB
	 KBroZlz2ynqNXuygbtbFS3JltzDu7iYWjHOp/sUIzUFnMACIkXWwXXBTm8OA0t8mv/
	 O85E+DXeNcQ7wnBILaU7OedaOJkC9Hjfr7HLK0C8HfUUIgXW0T6C7xC0W6zeXNyupE
	 WZEU5tD1ZUaXQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 54E8E81159;
	Fri,  9 Oct 2026 07:03:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id A922D1A6
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 07:03:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8F7C84091E
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 07:03:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Qsp1j7Q0KGLj for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 07:03:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org EA17C4090A
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791529408;
 b=Af2YTzFIrUDqsuUXuM52BQGtEvnzhOo1/POD2vxN5+oqZNX+hvA6OpQgIWy4ASQqe5yA
 JiD9/hdWWiPJ3qhzkifCu+HXQG62bbB4/xlMuVRxNenayPaWkWfr6VDdyDFvQoqATVkTE
 yD9NLYm9yIfoOlrq8qPq04sWZN4B6866gb1GJ6vvbiLIpp1mfBZRA1c0G3h4UrCMsJ9rW
 cn0rlwGEqVAU5izdNATfJd7bByNMhu8NmjimjLd4dp3aht3AHOaU9fSB6qtB5d1CV+34q
 g11pwSRUttfDcQeBVkhxmG1Mb9RXcsX/MsmJ7eWqRnNPjqka3qZBa2Tsf/ead8MUpyw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791529408;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=FVbVr/SLj/ahirgwJPH49+h2vyuJJWceItNKNu4cfWk=;
 b=ZUUTyEYGmDbk6X1naIT0ZNXQmVQ1Zg3JScWx1emvU3edo+wiI8QNZ5ar+VY0acxCamMM
 mLgu7ZVJl1hUBUFESjeNHAMbkje7T1OyCmxy7tWkaU2XtqeycBYC47WCEQz2PR8s7ufO4
 j1caq/xoOalFI99dfU6e0OJFC78UgMvwcYGg+QG+0jdh8X/JBpwaD/DaOJyPucDQFMWNY
 iYfToUv393B8ZWZdH5PepwW11Z7zJDDdty4l2dfVICfx2PAJmBJwXPkS1LGlO4i5H+d2X
 sm8/5SaqFCqCAzRpGaehNKaKYUJ4pg3rlEekPTLV1n0VnHB6DQeZ7aa437uGE6UKgng==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=H0UUG9Lr; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=H0UUG9Lr
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EA17C4090A
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 07:03:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id EAA4B4191E;
 Fri,  9 Oct 2026 07:03:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 765781F000FF;
 Fri,  9 Oct 2026 07:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791529406;
 bh=FVbVr/SLj/ahirgwJPH49+h2vyuJJWceItNKNu4cfWk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=H0UUG9LrVxWiR5osaJaTUfEgeaZ1vYhwlWE53TBZv7WTqeQnjU3hiPvrbhTF08p9p
 6w+et9ptweWoMYzkxr7RTyo5p8RRNrGD5C6YSSdYNOWCV3nW9cULzmqGKAg802HCsn
 y6Wv8qmmAmEEfmyr1LEBGTRGl/ufgo47FvWQSDgUlsGZ8y+zUzCUbzS9xcn5Ds3lYO
 z6YQZSd5aLEa5mg7hQJRPUCMFsObzqD9Oq1i/5C/9tQPbe+75ypZ7pMpi5h3viJaas
 M4IXSEVdFMB8csHAcNU6yNFuVd8KLHZE/A7ZnVk1Gz4TFQQfhHGLFC33svSeVeDkNJ
 cgGG0/e3cgxaQ==
Date: Fri, 9 Oct 2026 07:03:24 +0000
From: Yixun Lan <dlan@kernel.org>
To: Jerome Forissier <jerome.forissier@arm.com>
Cc: Tom Rini <trini@konsulko.com>, Jerome Forissier <jerome.forissier@arm.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Peter Robinson <pbrobinson@gmail.com>, Johan Jonker <jbx6244@gmail.com>,
 Julien Stephan <jstephan@baylibre.com>,
 David Lechner <dlechner@baylibre.com>,
 Junhui Liu <junhui.liu@pigmoral.tech>,
 fanyi zhang <fanyi.zhang@mediatek.com>, spacemit@lists.linux.dev,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH 1/2] net: dwc_eth_qos: spacemit: add support for K3 SoC
Message-ID: <20261009070324-GKF2005@kernel.org>
References: <20260924-02-k3-ethernet-support-v1-0-b8e1fafc9249@kernel.org>
 <20260924-02-k3-ethernet-support-v1-1-b8e1fafc9249@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260924-02-k3-ethernet-support-v1-1-b8e1fafc9249@kernel.org>
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

Hi Jerome Forissier,

On 01:53 Thu 24 Sep     , Yixun Lan wrote:
> The SpacemiT K3 integrates a Synopsys DWMAC 5.40a Ethernet controller.
> Add the platform glue for selecting the MII, RMII or RGMII interface,
> configuring the internal RGMII delay lines through the APMU, and
> managing the controller clocks and reset.
> 
> Signed-off-by: Yixun Lan <dlan@kernel.org>
> ---
>  drivers/net/Kconfig                |   8 +
>  drivers/net/Makefile               |   1 +
>  drivers/net/dwc_eth_qos.c          |   6 +
>  drivers/net/dwc_eth_qos.h          |   1 +
>  drivers/net/dwc_eth_qos_spacemit.c | 313 +++++++++++++++++++++++++++++++++++++
>  5 files changed, 329 insertions(+)
> 

Ping for this..

Would you have some time to take a look at this patch?
and let me know if you want to take it via net tree?

-- 
Yixun Lan (dlan)
