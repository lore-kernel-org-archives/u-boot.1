Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5BD1D4977B
	for <u-boot@archiver.kernel.org>; Sun,  1 Dec 2024 18:51:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 188AE8947A;
	Sun,  1 Dec 2024 19:51:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="e8vj2giH";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="kH+yyP8E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B69238946A; Sun,  1 Dec 2024 19:51:27 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C3E338945A
 for <u-boot@lists.denx.de>; Sun,  1 Dec 2024 19:51:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4Y1bbt40hwz9sJ6;
 Sun,  1 Dec 2024 19:51:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1733079082;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c6H0N6WHKcPtgosDaVqjaQsKmb4drcnr3uM+SvfKQJg=;
 b=e8vj2giH93BqkoJoD7ypm2XaBcjPSRmJuGgi6fXJTLMmNuw/5/+bK/CzAaQaBhW4Z/TFBB
 G2cQ6ewSqFfbyP6w7buBG3vreRBLllNItLHvEwZQg3kqnYuISgMybusc/SqFECE/OEEouE
 C10ZZ/VPfWx9Akgfn53Y86gD4pJYVufa2jDl7csiymezOs7E1fSOtFfR0ODvdO3nzWJRwr
 913OPtqIJHqL6YbOclPb2zk8P+gmzw+QZHwemqpLF90PgEiw1ivoMOpYvoCsi6ZBtCjC3I
 l+WL8KttpRccXaLd15GmOXktPba8sLMEyASW6Z12yur6q0JHaJSQeQQsttTvrg==
Message-ID: <17cde70a-c85c-47c0-86ac-b22473004426@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1733079080;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c6H0N6WHKcPtgosDaVqjaQsKmb4drcnr3uM+SvfKQJg=;
 b=kH+yyP8EuUWQcHGxEqCFr7PeWB8qZSHHp0OGjKU70mslWQtxW7VdCS51CdFT7+KdJngPrh
 9/d6Wd5mS/ca7DIa1LKvIkh1Kj1twVdL/4ocj8dm0LY+nzJ4j4ri37gYrkTB6KcdpwgVce
 8/que0ZE0aEqByRYe+rfGgDzx35eQgBj/gFOV2KbCQ0Rtdu4V3LWuLdb97WJQ8ifTDNfAu
 4j5jorSlVzzb43Ks5maw/4NMMVCKaMnuYjMaAn63Qu6nv3e0M1ZWOroVPai4aK5FUWz4MY
 OjcPMZr9F3LsgO4i7vfDyCgnj0opki+eIS9/wxqt72E1gnX6CZj3ofyKlcCQ1w==
Date: Sun, 1 Dec 2024 19:48:06 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v2] net: ravb: Simplify max-speed handling in
 ravb_of_to_plat
To: Paul Barker <paul.barker.ct@bp.renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>
Cc: u-boot@lists.denx.de
References: <20241120094939.129-1-paul.barker.ct@bp.renesas.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20241120094939.129-1-paul.barker.ct@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: z3mttzbutarhmsoqeia8rwfwo15qc3mp
X-MBO-RS-ID: 7edf7bda9ab27ea5e05
X-Rspamd-Queue-Id: 4Y1bbt40hwz9sJ6
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

On 11/20/24 10:49 AM, Paul Barker wrote:
> We can call dev_read_u32_default() instead of calling fdt_getprop() then
> fdt32_to_cpu().
> 
> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
> Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Applied to sh/master, thanks.
