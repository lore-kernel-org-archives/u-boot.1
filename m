Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A677BD49780
	for <u-boot@archiver.kernel.org>; Sun,  1 Dec 2024 18:59:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 727B48945C;
	Sun,  1 Dec 2024 19:51:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Mdy1CO+c";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="SYtJ8NLL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A63C894AD; Sun,  1 Dec 2024 19:51:28 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFEB188E77
 for <u-boot@lists.denx.de>; Sun,  1 Dec 2024 19:51:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Y1bbs490Hz9t0j;
 Sun,  1 Dec 2024 19:51:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1733079081;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HE2xeu870HAF+w386j9GGaiSvq7Ra2XF3FxAAROWR6Y=;
 b=Mdy1CO+cy8UwoGIt9KmXHwXJqcpBIp+PjhgE8piFN634EPbBADCL63b6Q9BGWvIG/F+bwH
 Fk9f0rdGY2Ht4a7BdhAh4jMXZ6Tfk7BksGi5xn1SarDOdIAmr+w3XCxbWYML07XbQpPT8g
 yWyip/QhejdVb0i1Zpb0S2iberBK9kulh6W4NsC+qgFX6xl68qWvX2t5xuImYxyh/GZm/k
 bRrXs98tNQuzTc3RSab9CFxlEgq32vG6P8u4kmHlTQbXQDJFQYbj0TWhgx1xRq8wa/LNE2
 8P65jg/WrcRb10g4dOmVL2Euis3bwT2X9Fk01pbjFVTgnOGpyeI/HnVkYLp1Nw==
Message-ID: <9e85228f-f786-4376-8ef5-f65a23f486e7@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1733079079;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HE2xeu870HAF+w386j9GGaiSvq7Ra2XF3FxAAROWR6Y=;
 b=SYtJ8NLLaV+WwacGR/0Xu3v01oRDZ/Iy7pqbWW9zZhrUTzA9yy/jjBFljo7OROKS0brDIs
 Gj2HQc+nwDcAU9KCZ0P4EY5B5t6mgn/sydiZml1WHQEk0a11fQVlriCXmuI2F8fBZLGcKn
 fz+udVY6D+ix8A2YSdd1NoVR3rcnqag9EUIunHq1iMUJkkKN5jjvKm6GbTi115uY47uNbO
 8vbD072Hrc9k1kCJjDz1u6NmkOtLkLO63JPOsHtC4+bAuqegx8kZX3u+PZhzqZ2asJKxal
 UE91X6n20ge/Pot3mPx9o/z+XB8QYEKx7HaqT+WnWXYaD+KwusifqzyMLc2HCA==
Date: Sun, 1 Dec 2024 19:47:20 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v2] clk: rzg2l: Ignore enable for core clocks
To: Paul Barker <paul.barker.ct@bp.renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de
References: <20241119193626.2756-1-paul.barker.ct@bp.renesas.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20241119193626.2756-1-paul.barker.ct@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 929b2c29572932a5498
X-MBO-RS-META: ptk3e7ck54ydf1isfbu9e7b17si9n58p
X-Rspamd-Queue-Id: 4Y1bbs490Hz9t0j
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

On 11/19/24 8:36 PM, Paul Barker wrote:
> In the RZ/G2L family, core clocks are always on and can't be disabled.
> However, drivers which are shared with other SoCs may call clk_enable()
> or clk_enable_bulk() for a clock referenced in the device tree which
> happens to be a core clock on the RZ/G2L. To avoid the need for
> conditionals in these drivers, simply ignore attempts to enable a core
> clock.
> 
> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
> Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Applied to sh/master, thanks.
