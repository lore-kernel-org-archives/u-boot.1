Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F37A5CD4F5B
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 20:13:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8753284841;
	Tue, 19 May 2026 22:13:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="DE5etWoD";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="fwS5CZdf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED04F8484A; Tue, 19 May 2026 22:13:42 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C2DAC84717
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 22:13:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4gKm8N4NC9z9tpJ;
 Tue, 19 May 2026 22:13:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1779221620;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZZCsKMg7lGlxfc/1bdq/4wEb3n1nPlcVNmp1JoHthwk=;
 b=DE5etWoDcxZ5qdBoTZAg4usolTgz4bISj2BOdtW13Bt5LQdGwCze3mSeYHNSj+FU/vuV8h
 jnLniVJAsYKN4JC/rseKiSxhLigT4Mwx1Lei3uaszgqbXWjzpkVgJjKTXbRat4lC/SWLk4
 STM3M2otoXJeYGIy09zMw+3zhJx63SiqPUllWt1HWWvk4Z9jrLNcUuUZ+Qe6ZP5IWlsKi6
 mzoFTT+/njlnJ9jSh8gwI+rrM21NpLftqDtnqmua6CrgOTnOxuB8gR+H0BAhWHaDM3m3VF
 CwA+E1ThBVt+UjAOlJWa9zigVk+FQk/wTsGKtQIsgh1cUNw9x6qx5zslwoc/Tg==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=fwS5CZdf;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::1 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <e6936131-af07-4c06-a3f7-1a43320a582f@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1779221619;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZZCsKMg7lGlxfc/1bdq/4wEb3n1nPlcVNmp1JoHthwk=;
 b=fwS5CZdf846oMgS+9PmZvhA9ZRtBQcFCkL4+O3uugm7sv0sckknkSP+L7y8/cUP4TN+l/o
 RKA54vUpUgY7qddUGalMXJkVfKOEjyL/HlWqHxfPiDf/PLekNVg2fVvh7bZYC8vMnDQfMI
 1ChA17ZQ1msECqs5V4ULhZDhdsiYeBTO9G/OFLCryKd0VGiiPAjq5Vo5khOtbkRdW+buGi
 KPFR7vtp/ke81m9d1rRcfMsE8FLl0I1CwFY9rkFpAAyhPOCd6hgCp8s1503TTf6ArokcWk
 8A2P8L3zJaI6s0eBP7Ymx03sZ8fo+/OQoT3feZGAX7XEV2Hjd7s2K4M2bDXv0A==
Date: Tue, 19 May 2026 22:13:37 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 1/5] bootdev: Fix the case where the driver ops field is
 null.
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
References: <20260519152101.716714-1-trini@konsulko.com>
 <20260519152101.716714-2-trini@konsulko.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260519152101.716714-2-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 7xmtckz79wxq3bor3cufabbee65ej8jt
X-MBO-RS-ID: 9053a5b4623ae559d60
X-Rspamd-Queue-Id: 4gKm8N4NC9z9tpJ
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

On 5/19/26 5:18 PM, Tom Rini wrote:
> In the case where a bootdev does not have a custom get_bootflow function
> but instead relies on default_get_bootflow to provide one,
> bootdev_get_bootflow was not handling the case where ops was simply not
> set. Restructure the function to check for "ops && ops->get_bootflow"
> and add appropriate log_debug calls for both cases.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Thanks !
