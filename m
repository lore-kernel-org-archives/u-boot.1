Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92EEFE7AD4B
	for <u-boot@archiver.kernel.org>; Tue,  3 Oct 2023 13:42:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9324687493;
	Tue,  3 Oct 2023 15:41:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="qJDox5K1";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ybVz1S26";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42C4D87486; Tue,  3 Oct 2023 15:41:04 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 714BE8748B
 for <u-boot@lists.denx.de>; Tue,  3 Oct 2023 15:41:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4S0Jqy1fSnz9sTH;
 Tue,  3 Oct 2023 15:41:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1696340462;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DbhI0TmL5jXer/4DKeucIwj+1cKOz7Gjs+87Quh0w/s=;
 b=qJDox5K1jk8Pq0JKMjfMJV3SlYAcIei93svtiuKkQiOPDu1GbqWB9bfOEaVyReA1zze7xW
 B84irhESsU9IQF1VBd+a5HzU0PIL3wl5uBmSMtIVSw+WkY0sgLCTb2CV0dgRA06nrmncNa
 eM+4BnEFSJXG8UmMsegpy02y4zNFTUN5oXMgwK9CS7dM8Dv12RP21XC0DVPU6W8i2FVrZ8
 lSMX6JWu7IKr1ifi9KtTn6CptbuTpW+llSDK0ILZccgPxdtKDaZyQYVf0Ro5EwY1pSXHIL
 jnqiMuRZ98ob8udCj7EkZMWu1imkkwRsCsbQA3zChdeowE9U231N23RwA0LPxw==
Message-ID: <c163f447-ae15-2a85-a120-d821848e3e24@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1696340460;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DbhI0TmL5jXer/4DKeucIwj+1cKOz7Gjs+87Quh0w/s=;
 b=ybVz1S261s9Mt9DrXVX7Nl21Po8RyaHwGFT976GgEZVE+FlwQI6qs4Q57bwku0IFqv20zt
 Pgq9TMBcGFEQMhNh+hnecCUgy1QSuCS3KAn5wPIXBNgSINbhu2wtvtebiXNA5PmMtwFXC2
 gXKjwTaXZsbGMUUbw6d9n5I4ynMFUOxBuxof+eHsyyqXJOCrqok9UBg/SUGy/rH9yJV5m/
 iYmLzsUnSemYRCscOhtwQK+UaO6QGzkUgzmz5g65AwhnxGnRQSwqKcVGf216mlPWzBdIos
 rpDyloJljFhfGLEq/2yJj4xnKd21jyqharj7ndnywoSbAmK7a+5O0Bo2CmmOFA==
Date: Tue, 3 Oct 2023 15:27:44 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 12/16] arm: rmobile: Include <asm/types.h> in header
Content-Language: en-US
To: Paul Barker <paul.barker.ct@bp.renesas.com>, u-boot@lists.denx.de,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Hai Pham <hai.pham.ud@renesas.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20230920124212.63535-1-paul.barker.ct@bp.renesas.com>
 <20230920124212.63535-13-paul.barker.ct@bp.renesas.com>
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20230920124212.63535-13-paul.barker.ct@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: jepegz196b7qsd5kqwxs8s9b4wpu8bq3
X-MBO-RS-ID: 35f2f2f7ea07e1ca80b
X-Rspamd-Queue-Id: 4S0Jqy1fSnz9sTH
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

On 9/20/23 14:42, Paul Barker wrote:
> We don't want to rely on source files including <asm/types.h> before
> <asm/arch/rmobile.h>.

What kind of error does this solve ?
