Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84ACBC8303D
	for <u-boot@archiver.kernel.org>; Fri,  4 Jul 2025 12:34:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B16E182FC7;
	Fri,  4 Jul 2025 14:33:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="prgCVUGf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3942F82063; Fri,  4 Jul 2025 13:25:37 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5B73806D8
 for <u-boot@lists.denx.de>; Fri,  4 Jul 2025 13:25:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=xiang@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id A15E761454;
 Fri,  4 Jul 2025 11:25:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08F79C4CEE3;
 Fri,  4 Jul 2025 11:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1751628333;
 bh=rpBSB4vC8J/yzro6d6f5bj5eJ9yNHud6GzBh8/h8HtM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=prgCVUGf9iFPdLL0mwZDF5Xhg/XUyJNinoCj3J4qw5siOiRw/POQ1+Qpjgm+uFivX
 OLKorPY/idVAbQ90DqwfT5nlc2EBEPcSRxE7IUdyF/hjJHnGfIWqbE59eGLjWpbkhW
 V84intNbfds/W2sbxUTPuCQpvK1b9pdfnYWZNTatvXWBK3qAljoD1ZvyiEchAbIMO7
 vjsBMVs7tZ3nTyCAMRxlPI1Xxb9HZ+8mOfMHtaop745ud1zsq4Zm4BSFNYRcQtUUxQ
 9iGTvruV/nrddVBU3xHQ6PlpUK3N+s2rZQQ/6NvoImKBnzzNW4remettyGn1kSoS+L
 xsg2y/YxvLwmQ==
Date: Fri, 4 Jul 2025 19:25:26 +0800
From: Gao Xiang <xiang@kernel.org>
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Huang Jianan <jnhuang95@gmail.com>, Tom Rini <trini@konsulko.com>,
 linux-erofs@lists.ozlabs.org, u-boot@lists.denx.de
Subject: Re: [PATCH] fs: erofs: Do NULL check before dereferencing pointer
Message-ID: <aGe6JvgS6YDzkY7p@debian>
Mail-Followup-To: Andrew Goodbody <andrew.goodbody@linaro.org>,
 Huang Jianan <jnhuang95@gmail.com>, Tom Rini <trini@konsulko.com>,
 linux-erofs@lists.ozlabs.org, u-boot@lists.denx.de
References: <20250704-erofs_fix-v1-1-956be16f32e9@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250704-erofs_fix-v1-1-956be16f32e9@linaro.org>
X-Mailman-Approved-At: Fri, 04 Jul 2025 14:33:47 +0200
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

On Fri, Jul 04, 2025 at 11:53:18AM +0100, Andrew Goodbody wrote:
> The assignments to sect and off use the pointer from ctxt.cur_dev but
> that has not been NULL checked before this is done. So instead move the
> assignments after the NULL check.
> 
> This issue found by Smatch
> 
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>

Reviewed-by: Gao Xiang <xiang@kernel.org>

Thanks!
Gao Xiang
