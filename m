Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A6CCCDB482
	for <u-boot@archiver.kernel.org>; Sun, 15 Oct 2023 07:28:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68F7D86F8C;
	Sun, 15 Oct 2023 08:53:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="pf42yfJo";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="EeS9vCEd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1505F86DF5; Sun, 15 Oct 2023 08:52:11 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1351886F97
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 08:51:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4S7GdQ2Hrpz9t2H;
 Sat, 14 Oct 2023 23:26:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1697318762;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2soEuGvvXwvpWubuFxDpHlHxgOrbHxtFxW6YJo5MkW0=;
 b=pf42yfJo1hI0muj8zevIcZE8kEVcjlvXMU1sXWRY0m/9r93Y5pEZkKo13bVKTBdjzG27Hk
 paFsOnBoU2qBRp4lz15D14YVno8MbaVKQHVpuaw4lDy24qPsCx9bhleGk92p5igZ2tomvT
 WOsV1Ur+RG0wZLzyhXiO3zgp+6wwLJObgTv8lQ9qrQG9xX8d0wH0s6DB08Q+x8+SifKyry
 oRXS7KhBs+quXSIyyKVm56O4idhl3GcbNUiAGXNV+5NIhz7oWP8tHAaEmcZNsRXxCa2NCM
 nOCc4DwaMxLkhV2kNEECQaxsWB6/Dmun3c+sZHxSDDaKpGRZWvOfdO+zIf2yew==
Message-ID: <be63b3a4-99c8-41c8-b0ea-72e45b003dec@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1697318760;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2soEuGvvXwvpWubuFxDpHlHxgOrbHxtFxW6YJo5MkW0=;
 b=EeS9vCEdBeCf6bLsqCOFDS/iV4uT4BsRAL8lEswIUxBmGo7/j9YXzq3h1xNYdvkUBA0/p6
 bR2GTGbkN5vUgmIleTpediLrNkZjq0AY1eIQFNrjRMg4gIZvOWGGimBzi04yryHYw+doCH
 dZDs1PJSB1CN8ZDQUH988Bh3ttXoBjJ0+J9iBlEfae8owYL0YltKp9iqxYToQuvypwO38F
 gjXTBUBXel/5MK9tz6wLPLT7Kth8vg0eM4p3754MtWxhPMrnZn14aX4EofIEnncPYqaGDn
 p4fmsXl20xo2C4Epj5oW8/zMVf9XpYgcLuFCrgqcjQM5RoyVBRb/DayaRFQZug==
Date: Sat, 14 Oct 2023 23:25:57 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 12/19] serial: sh: Add RZ/G2L SCIF support
Content-Language: en-US
To: Paul Barker <paul.barker.ct@bp.renesas.com>, u-boot@lists.denx.de,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Hai Pham <hai.pham.ud@renesas.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20231009164645.164464-1-paul.barker.ct@bp.renesas.com>
 <20231009164645.164464-13-paul.barker.ct@bp.renesas.com>
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20231009164645.164464-13-paul.barker.ct@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: cfd81666d7c259ca61f
X-MBO-RS-META: sa33mitj6sffjknuwjtghz1dgec4c7ry
X-Rspamd-Queue-Id: 4S7GdQ2Hrpz9t2H
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
> Extend the existing driver to support the SCIF serial ports on the
> Renesas RZ/G2L (R9A07G044) SoC. This also requires us to ensure that the
> relevant reset signal is de-asserted before we try to talk to the SCIF
> module.
> 
> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
> Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Tested-by: Marek Vasut <marek.vasut+renesas@mailbox.org> # R-Car H3 
Salvator-XS
