Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37148C36000
	for <u-boot@archiver.kernel.org>; Thu, 20 Mar 2025 11:58:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 88988803CC;
	Thu, 20 Mar 2025 12:58:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1742471886;
	bh=kGf7v+4hNzfpyIx4M8BghjKzS0J5F6JQ1RI3ZZxkVAw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JXtFwLrh0pIoOx6/DaAkCIDnGgW6NIScVbIHld6IRsYkSuK3ePcS3BGlelbyTudma
	 Ah7Bc8MOz6mrLkd5FkyCm3wk5d2b+b4vkPXmXLjrdu+xW8y8zs9wGe2urY+XzXRlsk
	 vdx5UeaRo+pK59h6oEAWkeRtJpX5hCzP/Wr8KUHjpUzeR3K4Unoz8QZZ7MTIRUNRd1
	 +4KNXAUjmo452qiPZny+UujHxcVppg0D915tQwxAfknohiGZaW5tiyZnAR0WdzTrNP
	 niL7blsjX8GZhx+97ONieTUUZhbAgcasxrQtfqJNEKUgtEml6UmKBawEiMcmvbqVl2
	 QQFV0tEU0lgng==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 708B881101; Thu, 20 Mar 2025 12:58:05 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7DF728003E
 for <u-boot@lists.denx.de>; Thu, 20 Mar 2025 12:58:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="SBcj6Lrg"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 0CC4B101E908C; Thu, 20 Mar 2025 12:57:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1742471882; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=kGf7v+4hNzfpyIx4M8BghjKzS0J5F6JQ1RI3ZZxkVAw=;
 b=SBcj6LrgiVjPRDCrFfpl0JfCHWR0YudzE6wxq36Ikh9UP9tUivAjBWCO01ZwLotpuFwHmD
 wfuUDoQs2x05zYNd2ZB7g+6uPb+0zFS7eosKOt7mCQgcTJsvrli4+65lMksfQeicapuI0G
 4Tl7wrjSbrn0JI6cyicAHviclor2PVaVjaBXAO22+VVBc6Ov+IL9TQIFe6xuPLIoQciqqh
 InsodS47F+TwifyVVnCLHVuBhxL2wGjWYyYKpP5z5w9gRJqofq8BuDvSMCN/SRe95hwBFV
 ZBIN+gK5MXvxn3p12I+FQyT+2Gyb6rVd35/immF5wlMzlUq/5S4dRzSyC5J2KQ==
Message-ID: <c990d260-e4cc-41e5-991b-56dc35791f1e@denx.de>
Date: Thu, 20 Mar 2025 12:55:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cmd: env: select: Add output for available evironment
 targets
To: Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 u-boot@lists.denx.de
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Tom Rini <trini@konsulko.com>
References: <20250320103257.14185-1-cniedermaier@dh-electronics.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20250320103257.14185-1-cniedermaier@dh-electronics.com>
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

On 3/20/25 11:32 AM, Christoph Niedermaier wrote:
> If "env select" is called without a target parameter the result is
> "Select Environment on <NULL>: driver not found".

Why is this not the correct output ?

> Improve the output
> by showing a list of available evironment targets, where the active
> target is marked with an asterisk.

If the goal is to add support for listing available env options for 'env 
select' , then better modify cmd/nvedit.c do_env_select() and implement 
some 'env select -l' .
