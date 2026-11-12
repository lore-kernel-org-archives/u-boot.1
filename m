Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80859606A31C
	for <u-boot@archiver.kernel.org>; Thu, 12 Nov 2026 23:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=hq7PMmma;
	dkim=pass (2048-bit key, unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256 header.s=s2025 header.b=UDP8x6EB
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D0FD160D8D;
	Thu, 12 Nov 2026 23:19:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Rc-OE149qqry; Thu, 12 Nov 2026 23:19:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A9B3C60B18
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794525592;
	b=olg7NjgmEYRkA9x7Df8attFDoSU3WgmGxMcwAa8MM+lg162PbrECbPa3NL1xoZgz7BaM
	 FpL29hwFLWri6LJRswEvXZioWBsTd72klc1DTjrKIhjGCfYNfoVK3APxYJtvPJd9BZ4sA
	 B86yfdC9BZrreh4dZq0tnSMVGpQ9+BlxFq6kbRihUs7bW/m478U01HSkjwdDEfeYaamSX
	 hsnUnkccD616cw0jddG8xl27eZJ2Odp+U4W3mHA/j/WqPnhKzyQSGSSK06NJybbSRTzG5
	 hgQaJIa5+bY/V9lC8MQmTBeWvoN+N/ygwb2txFqCJODbwdSWfkHDrqr9DLTrj2H85Lw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794525592;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=UizlmP5H8aw4JziN50m1d4AjxVm697JG/ctwAAuabnw=;
	b=mw4ZLTh/je/sgSPg9hlbk4gw0RVmOpcYCFhdaHj0jrgYwkbOUU4Z4TSGOjdaWu3TcKTE
	 6jnaY23kjehQXQ4Iwm8NdsNuaY+K8ukpbLvybdHkYXLQRCewyswqf4yURXn0vVJzT8BtY
	 NpSs2CAF7Fkj53UypPO5cZxw4hgabd+zAfoMDzqZNAZNCzXZEcNvmxyLHy4K6SFzWdW9r
	 pr2caisr9B5SZBkh1Ao0cBt1ix6c1OnZGrp1mnSEQSvbZzMTlCIFWvUqtvHnXGlJxuFXD
	 tofJL2KB9sdHJtEFMbI0rPgTTOF/uCVejEMTQ2MjB8NBSflyw2t7LBF7XHJt2gsA/lw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=freeshell.de;
	dkim=pass header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256 header.s=s2025 header.b=UDP8x6EB;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794525592;
	bh=UizlmP5H8aw4JziN50m1d4AjxVm697JG/ctwAAuabnw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hq7PMmma5jU7rTrXgLlLIBqiBzxcYmchtZnM4P4GxSdx+EesPsHOVLOP/knC1H3VW
	 C0BCtIMkBIDCJ67z931A5NfjUtfOVofF+pEwNlye07pciY5P7V0poxXEQLira0KGIR
	 lVA07IzCVHD3gEchvjoAuNUdxxmMBTbx8sdhg7vE+WQGk7V9RI9+9yoWmHaMYmghUQ
	 98Mk/DA7GE4JK4WjmodL7VkAWuqqeQLwHqZLwuKOy6LRwdXKNdeHJi6uJoacS8hhSe
	 PcuDCxq00zpgekxhYxKUISg2S6aH8IqfEk+PpsEAezlBeNFiGgjirHxbuETXjB29IV
	 srUDb7AGSRrGg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A9B3C60B18;
	Thu, 12 Nov 2026 23:19:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 15047235
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 23:19:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 06A5860B18
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 23:19:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id C0LBBILF38sj for <u-boot@lists.u-boot-project.org>;
 Thu, 12 Nov 2026 23:19:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9BCA0606FF
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=116.202.128.144
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=116.202.128.144;
 helo=freeshell.de; envelope-from=e@freeshell.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=UDP8x6EB
Received: from freeshell.de (freeshell.de [116.202.128.144])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9BCA0606FF
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 23:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1794525567;
 bh=UizlmP5H8aw4JziN50m1d4AjxVm697JG/ctwAAuabnw=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=UDP8x6EBfAPYz5yKGHWgBwc+hevlRZeXJd63ePUTtR/rubmxiDXJBCW2utMJ2AR1z
 xBBn5FYLnSG23+WKNymhx7JuLj/oL+VijIiiz+eUYPwxQb76yctVyBPpRnGg1DASUl
 y6swz/PMFWEzmNgmvbcNL7/h12uknFWBQ2WxuwE0+Fc3b2UQp4CBndXLJUU9HXXikT
 J1ON6gu774hEzaC4n0D3ZgQS/wQhsO/xZC5DZ/Y+1UY6DmYCuZ6miuppZ/WoBuPhZ3
 fYKe6pyZ216oQSDOKxZdqDjfaA5KyR3ELDs2LdGenzSvOcakUBVkcnRaE/H29/wIEj
 5luRxobWoIn9Q==
Received: from [IPV6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc] (unknown
 [IPv6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 0F19DB220FEB;
 Fri, 13 Nov 2026 00:19:25 +0100 (CET)
Message-ID: <33c70db1-226a-4108-b690-ad07cecf7752@freeshell.de>
Date: Thu, 12 Nov 2026 15:19:18 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] doc: develop/sending_patches: add tips for series
To: Ralph Siemsen <ralph.siemsen@linaro.org>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Neil Armstrong <neil.armstrong@linaro.org>
References: <20261112-doc-sending-patches-v4-0-d6f4b7e3eeba@linaro.org>
 <20261112-doc-sending-patches-v4-1-d6f4b7e3eeba@linaro.org>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <20261112-doc-sending-patches-v4-1-d6f4b7e3eeba@linaro.org>
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
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/12/26 13:55, Ralph Siemsen wrote:
> Related patches can be grouped into a "patch series". Add some tips on
> how to decide how much belongs into a "patch series".
> 
> Signed-off-by: Ralph Siemsen <ralph.siemsen@linaro.org>
> Reviewed-by: E Shattow <e@freeshell.de>
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
> --
> Changes for v4:
> - spelling fixes
> - add R-b
> - Line to v3: https://patch.msgid.link/20261106-doc-sending-patches-v3-1-86fa7d158cc2@linaro.org
> 
> Changes for v3:
> - explicitly mention keeping bug fixes separate from other changes
> - focus on "keep it small" rather than the exceptions to that rule
> - Link to v2: https://patch.msgid.link/20261104-doc-sending-patches-v2-1-c0a90ff6c049@linaro.org
> 
> Changes for v2:
> - small wording changes to help non-native English speakers
> - add R-b
> 
> Link to v1:
> https://patch.msgid.link/20261028-doc-sending-patches-v1-1-66b0f1b276de@linaro.org
> ---
>  doc/develop/sending_patches.rst | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/doc/develop/sending_patches.rst b/doc/develop/sending_patches.rst
> index 99581dc0ba0..dd06d4a8968 100644
> --- a/doc/develop/sending_patches.rst
> +++ b/doc/develop/sending_patches.rst
> @@ -184,6 +184,31 @@ General Patch Submission Rules
>    cases, you did something wrong if your patch exceeds this limit. Think again
>    if you should not split it into separate logical parts.
>  
> +Tips for creating patch series
> +------------------------------
> +
> +A series of related patches can be sent as a "patch series", as described
> +above. Individual patches should be small and self-contained. Likewise,
> +this also applies to each "patch series". Keep the following in mind:
> +
> +* large series are harder to review. Maintainers are busy and may postpone

This reads a bit awkwardly. Maybe "A large series is harder to review"
or "large series patches are harder to review", depending on what the
meaning is you are wanting to convey.

Either seems to me like injecting your opinion about what is easy or
difficult to review which does not align with my view of this that the
difficulty in reviewing a patch series is proportional to the discipline
in focus the author has for presenting their idea and developing it to a
meaningful change with the assistance of code review;  if it will
require a great deal of involvement then don't expect to just dump your
code off on the list and have it be merged because you gave this "gift"
of 100+ small patches in a series, or even a single patch large-or-small
that is several disjointed ideas or bug fixes.

> +  large reviews, whereas smaller reviews are more easily accommodated.
> +
> +* bug fixes should not be part of a larger series, so that the fixes can
> +  get reviewed and merged quickly.

Nothing happens "quickly". The point of bug fixes being independent is
so they can be reviewed and verified independently from unrelated
changes. Quickness is not the driver of getting merged or not merged, or
it should not be.

> +
> +* tools like ``b4`` and ``patman`` send the entire patch series to all

Do correct me if I am mistaken: for consistency I think we are
recommending people use b4 and patman, and not tools similar to these.

> +  reviewers, even though individual reviews may only care about some parts.
> +  Filtering out the relevant parts takes time away from actual reviews.
> +

What is an "actual review" ? That sounds so strange.

> +Therefore large series should be broken into smaller sub-series, for example by
> +subsystem (clock, pinctrl, reset, etc.). This allows better targeting of only
> +the relevant reviewers for each sub-series. Finding the right granularity can
> +be difficult, but when in doubt, aim for smaller changes.
> +
> +Overall, the goal is to make changes easily understood by reviewers, as well
> +as the next person who works on the code.
> +
>  Attributing Code, Copyrights, Signing
>  -------------------------------------
>  
> 

Drop my R-by tag, thanks. -E
