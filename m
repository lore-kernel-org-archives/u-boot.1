Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDCA8CFB420
	for <u-boot@archiver.kernel.org>; Sat,  5 Oct 2024 17:57:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5DD6488972;
	Sat,  5 Oct 2024 19:57:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="UWUQS1X5";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="nrpRhOVh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D7CA8897C; Sat,  5 Oct 2024 19:57:54 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5980488970
 for <u-boot@lists.denx.de>; Sat,  5 Oct 2024 19:57:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4XLY6R1FR0z9sc4;
 Sat,  5 Oct 2024 19:57:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1728151071;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aAPSgveFQza6b6lraqUI5pr3BNyXLOwJucbqUkPpQOU=;
 b=UWUQS1X5wUGRQPw2CEdIPcsD4pvTXtqXzXbyTs/AdLQd10VR5gh8Qq01LvoOEj+0flsJBQ
 xvak7pcDvMIWBybH/vT3ohGI6xteFERSaA29R8nXE88soVqOA2icz2hDE3qoGPIyVrs9Gt
 CCk1dijXqJVZpyklxQXa68hbCvk1tU0q2BOici9JveiHR2qB2GtC691XSLTgGWGH+gYWqa
 4IiMvtqNx2YvJX8qJDV29ACAYb4jTvOsEO3pDepx2e1/+Mn9/s3sbX3lIDzGuH4M5AWCus
 +0keTv2CUN2wcbL61AvcmAILvouzlVW2AmDotxD/DaBA8V5D6Dh3UrNx2Ng5FQ==
Message-ID: <7404f198-0767-4bd4-bd50-413617a94488@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1728151069;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aAPSgveFQza6b6lraqUI5pr3BNyXLOwJucbqUkPpQOU=;
 b=nrpRhOVhCkrcY30y2G7djzs/zSfEfICSm1Vk3XVMKDcPoaogekpJWTsp8y4NcPvi1wiPTr
 MK8ltrfWd8NLAJxEx7WusGR/chv34wv/CT93gRlm5TreFuY/Cb+Ndm8Wd1sVpmF19T/O+X
 k6fBPxgGanV1LqVyXLzLuWn9xpbwe5Z1lRNqdwUtuYqNcNV5UfKTLJygFurYvb0TSO1C6l
 uClrZ5anl6Ps/LgCxg+imm89b5qtgHz6McgYcCVk2/+qgTnHNz+xVPAgZUYT5FhRLU/Alf
 pVbzIRrJw6Rqx2Ej6L6QGIIwyz6iD1eNjvnxFfRGkgxAOqSZhcvmr58chIJcHw==
Date: Sat, 5 Oct 2024 19:57:48 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] clk: renesas: rcar-gen3: Fix SSCG caching replacement
 with MDSEL/PE caching
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>
References: <20241005174523.182066-1-marek.vasut+renesas@mailbox.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20241005174523.182066-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: d92a588dc7dc45fe988
X-MBO-RS-META: ya84uddobrj3knbcghb79oprz9z9ugdh
X-Rspamd-Queue-Id: 4XLY6R1FR0z9sc4
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

On 10/5/24 7:45 PM, Marek Vasut wrote:
> The SSCG is active with MDSEL[12] is not set. Previous commit
> 99c7e031196d ("clk: renesas: rcar-gen3: Replace SSCG caching
> with MDSEL/PE caching") inverted the conditional assignment
> of priv->sscg = !(cpg_mode & BIT(12)) during conversion from
> (priv->sscg ? 16 : 0) to priv->cpg_mode & BIT(core->offset) ? 16 : 0;
> Invert the assignment back to the correct state.
> 
> This fixes R8A77980, R8A77990, R8A77995 and R8A774C0.
> 
> Fixes: 99c7e031196d ("clk: renesas: rcar-gen3: Replace SSCG caching with MDSEL/PE caching")
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Tom Rini <trini@konsulko.com>
> ---
> NOTE: This is for 2024.10
Tom, please pick this one directly for 2024.10 if possible. Or do you 
want a PR ?
