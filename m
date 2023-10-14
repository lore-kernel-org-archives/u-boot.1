Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 200C1CDB482
	for <u-boot@archiver.kernel.org>; Sun, 15 Oct 2023 07:09:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D694A86F39;
	Sun, 15 Oct 2023 08:33:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="tRrqPmO2";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="QiTgZn4D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D13C286BD3; Sun, 15 Oct 2023 08:31:38 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F39C086F28
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 08:30:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4S7DcQ1z7Mz9scC;
 Sat, 14 Oct 2023 21:55:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1697313302;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hYqgR19AMG0FH3oXsEOQV4t/Cv9mOktY+gnDVse4/0o=;
 b=tRrqPmO26AUCNxRW92s4/iVGHdkpQH1jckibC3hqxizhvhtZCKikq6YooqCtomZu3PxCjS
 p2xDrMX+27xPWPp4PL1WX7IhxZro1/UrN3VfDtdFSD1xc2I6tNlqW30K101GqBqqWDEHZV
 6DE+KreFXst5pFmfB5OQguwACN4FQJZQi7c+u7whc2RUL32eJJA4q9ZPfKlzlj2wFc1vjr
 6hEqnBRQSwt63Q90UPmX4lkCOz6RylSE3ZFNGqA3WlGkCUbS9PfG36ihKIDRunlKcEY7n5
 Qn0BRn7jqLNmNQvSZPKG82gN/dVUIB4OmsU7+mM3IAMRZ79Z/8Hh542lz1gYSg==
Message-ID: <7b826f49-55c3-4d34-a03f-dfd51023fe7e@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1697313300;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hYqgR19AMG0FH3oXsEOQV4t/Cv9mOktY+gnDVse4/0o=;
 b=QiTgZn4Dyqoy+NkP31Ne/XHwIRu+Qg1s5aj4eSoiIDD/tFzW8HGDMIfyrxdqBl9/+bIFqR
 GWfEHkCgW+AY5f5W5IeRx891Jx8suDo4scpmoKcVEekuXCsiPCxdKu4hM3IVydemoX9Yja
 GwvoXtpexP6TpRXPu+fyUaTCajRT2Sf2sGd5l/ztD7Ngg5S65dRsuJePBAYWbrwB7v3fK8
 PdnDJ+sviy/SJOL67V8rJKLZwPldcFiEUCKBRW3A8gsgvJA73PqviLj7NHEadc4ZRw4eOa
 2H6bCpfkC5MHwau9SBgPOxiSKvAQ/sRBRYAMXSdbhoDw2SNh7E6d/7Divb2Cnw==
Date: Sat, 14 Oct 2023 21:54:59 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 13/19] mmc: renesas-sdhi: Refactor probe function
Content-Language: en-US
To: Paul Barker <paul.barker.ct@bp.renesas.com>, u-boot@lists.denx.de,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Hai Pham <hai.pham.ud@renesas.com>
References: <20231009164645.164464-1-paul.barker.ct@bp.renesas.com>
 <20231009164645.164464-14-paul.barker.ct@bp.renesas.com>
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20231009164645.164464-14-paul.barker.ct@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: f5f8fe2b808e1a853d5
X-MBO-RS-META: jmht1mdc5zbiefuj7gcq87oake4113qm
X-Rspamd-Queue-Id: 4S7DcQ1z7Mz9scC
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

On 10/9/23 18:46, Paul Barker wrote:
> Move the assignment of priv->quirks earlier in the function. This allows
> us to drop the quirks local variable and makes it easier to maintain
> clean error handling when we add RZ/G2L support in the next patch.
> 
> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>

Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
