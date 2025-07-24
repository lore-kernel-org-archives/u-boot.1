Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5138C83F26
	for <u-boot@archiver.kernel.org>; Thu, 24 Jul 2025 16:34:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4EB82838D7;
	Thu, 24 Jul 2025 18:34:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="F3kh6AnS";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="QB0PW8OR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5457C838DC; Thu, 24 Jul 2025 18:34:39 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43D7B838C7
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 18:34:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4bnxRd0CYQz9smL;
 Thu, 24 Jul 2025 18:34:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1753374877;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JlgEieGOoLARI32H6mOvDkFgp6yQcSDjVCxfQhBY7Yg=;
 b=F3kh6AnSLBZMPazb/aUDuG1yLpEaDzqsyQlfSo7e9iVBtQAlHG8yWEjunnAaw41Gjn+qWT
 8DRO7G544Q9EIgie0GLfMftpHaezXJF0pql226Hxp+ITGliXngRdhRVeA7JVijb6Izk/9i
 nx3Bhf7Dm24+oYQ766mgXqY2/b9EjnOMAYSjlbRpUllYiWCdg2/2VagiIhia0rEsquUNTf
 258n/9AuyxTxuaoqW3iOgEI8R+shkd7eKprKCNwZ5z0fywHRGo240l6MhmU1T5AX0ghE0m
 DRNoCcwkNlUzYYhM8FREBrkKrgUItVpOLrHH/BYzG6kMOvRpQsIGh0UhTnSJYg==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=QB0PW8OR;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <38db3eea-3846-410a-9f5c-89410b153fcc@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1753374874;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JlgEieGOoLARI32H6mOvDkFgp6yQcSDjVCxfQhBY7Yg=;
 b=QB0PW8ORw6MVSTen+Ma8KlgKhI1XuHxOUmkq6QHZ0nahv0Z+o1JVvlGrgMH1a4ozMPEgMx
 VL8gk8I4ObjKD00iduAGZM6nhkJ7wRHzstdyePQ75P69KBFu0C0gKjKkKF241z5c8WTWbO
 e6I6qoGSxdiU53ccB1xSUK63LHuCQ4QrRphUV/rm3OEy4qfK/HuOQHz8wiENuAIpmR9xqT
 Or0GYX/2JczpCUjLVwR33cEUBmTnAa+d4cytRpGuLRo8RLCaBT8uneI0BwZWjTN1zWeNxD
 5KCj3J5FrhmYVvjHKJSUTGxBgAIumEvYz+3p+bapKNcULeupEIG5+wf+EZKrNw==
Date: Thu, 24 Jul 2025 18:34:31 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] clk: renesas: Do not test unsigned variable to be less
 than 0
To: Andrew Goodbody <andrew.goodbody@linaro.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250724-rcar-cpg-lib-v1-1-46d64ffbf5aa@linaro.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20250724-rcar-cpg-lib-v1-1-46d64ffbf5aa@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 8fd58933d5d86d50cb5
X-MBO-RS-META: umifhzqxp3okxhq3yrrda9yy4k555q4y
X-Rspamd-Queue-Id: 4bnxRd0CYQz9smL
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

On 7/24/25 12:48 PM, Andrew Goodbody wrote:
> In rcar_clk_set_rate64_div_table the unsigned variable 'value' is used
> to receive the return value from rcar_clk_get_table_val which returns an
> int and then attempts to test for being less than 0, which can never be
> true. Instead declare value as an int so the code can behave as
> expected. Also remove initial values from 'value' and 'div' as they are
> not needed.
> 
> This issue was found by Smatch.
> 
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Thanks !
