Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9939C28B30
	for <u-boot@archiver.kernel.org>; Thu, 20 Mar 2025 11:58:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3175E806FC;
	Thu, 20 Mar 2025 12:58:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1742471884;
	bh=/e45txFlPaH4jRTuc7OvLHMLavezcRo287gwPenitqc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=M9qSZxZchHR4lBxPkb9oiLBW63cK8alpixv8+7//cepWfrFRyb9iMOy3eroOrAyPK
	 JO2OCClu61zPd1aPy3dddhCyZe+4yCIfiG+Lb5tN3GDwtXEdYz7Mk7NDC1K++AkPri
	 ImCEhKU50awApIHCJkv5wq02q1w+L1t8sekeshJohR6p6OaAdTWBGL9F3UU+/SII/k
	 LjmL6SV3/OLCiijVa+TsKl+BDjqVuywcIsJZ9oGMm1fgDbgknM6AYwI1xKmO78+cpL
	 05fCB33iNzLHzdB2LR163MVwmt6NQvtlV+y5vTw3rh6UFmHjXhbRdysWqF2Ug9MEwL
	 bgEHVOzvITEOw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0F7180540; Thu, 20 Mar 2025 12:58:02 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9FEFE8003E
 for <u-boot@lists.denx.de>; Thu, 20 Mar 2025 12:58:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="CnwKNetE"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 0E5EF101E9087; Thu, 20 Mar 2025 12:57:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1742471879; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=/e45txFlPaH4jRTuc7OvLHMLavezcRo287gwPenitqc=;
 b=CnwKNetErW81bvzkG9UHog/8SzjJPaL4/9RczaHBNkpVlHZ3hOXZBm6NpAortmRzHQRzCi
 GwIgYFodVZVRdv8Gf58UGdorNdfBqdy2nbZOMrXAr7Lu8D2sOgTZ3tvYBTZgEETOu21eiE
 MKJhE6nR3hBNoumi8ERyfLH31IdG2zytB1PP6evrUuvcMOhzp4JU4uURrgClRVSq/SIy1h
 jshE6OLN/XJiRN+EMAJGTZmdpfTB0IOQ9bhTdEE8YKChyD2xUdxq92tdQ1LXYCttne7GEw
 WXz+LowpU5FwNTwAzvdk15upoFp9gpnoLL0o22OF5fq/hY2yNxNjRQGYLWXIGw==
Message-ID: <a6ab86ac-4404-4081-8529-b8d11b37b5d2@denx.de>
Date: Thu, 20 Mar 2025 12:49:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tiny-printf: Add support for upper case hex values
To: Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Benedikt Spranger <b.spranger@linutronix.de>, Simon Glass
 <sjg@chromium.org>, John Ogness <john.ogness@linutronix.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20250320102346.13564-1-cniedermaier@dh-electronics.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20250320102346.13564-1-cniedermaier@dh-electronics.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
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

On 3/20/25 11:23 AM, Christoph Niedermaier wrote:
> If tiny printf is used with 0x%08X (upper case X) the output is
> always 0x00000000. It could be confusing if upper case instead
> of lower case is used intentionally or accidentally because the
> actual value is not output. To avoid this confusion, tiny printf
> is extended to support also the formatting with %X.
> 
> Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
TINY_PRINTF is meant to be tiny, i.e. not consume a lot of space, at the 
expense of functionality. This is meant to be used in size constrained 
environments, like the SPL. If you need full vsprintf() formatting 
support, disable TINY_PRINTF in your config and use the regular 
vsprintf() implementation.
