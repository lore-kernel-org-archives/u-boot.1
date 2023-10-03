Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEDEEE7AD4C
	for <u-boot@archiver.kernel.org>; Tue,  3 Oct 2023 13:42:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 019C68749E;
	Tue,  3 Oct 2023 15:41:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="shf5vNoj";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Hd1tapqB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D6A487494; Tue,  3 Oct 2023 15:41:05 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4F318725E
 for <u-boot@lists.denx.de>; Tue,  3 Oct 2023 15:41:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4S0Jqz4XpNz9spF;
 Tue,  3 Oct 2023 15:41:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1696340463;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H9jfFLco6at+1xOI7jImdF1dxyqnr0iRi5UABVVvhdc=;
 b=shf5vNojzNGrALoT08VzGZDB+2CGc1MkmWWxC4F8Q2xehSw1GWos/9rLD6Y8VRWa74vx3o
 bNoY+Rgd7XqOEgAqN51yiPXXhdq8ABMl5S87FPm4YfH0m019KcMdNMuhDVQVxcrrDdMOH4
 LlU0N8QujaYMS3tWJ+1vSV1vVGXq/dNzUa4ZyUikZOisQCkBUeVXasvT9m6AFqXp+Ik86n
 rHXj6DSg5XRKJKU5SW5xEVutvOII34byaZa6ghI+EQ8IvJfJpy1BEsibKxwQbzZr8uprym
 I+LeGmZfl2mtaqn0iaJmf1viDpOq/sD/00P7jrTJ65l+hvXwyQhIcHSPPZXjuw==
Message-ID: <af43734f-e901-3261-1a26-094b5c84583f@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1696340461;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H9jfFLco6at+1xOI7jImdF1dxyqnr0iRi5UABVVvhdc=;
 b=Hd1tapqBL1c9NJLpEASlSaqrGS7IKb5/oxMRs2EDF6sdCf2dAnxErbK5wtREy4/pcIZoE7
 aP9wn+kitIANda2qeEpJ1oI5GQg4Jqa/BWckPqzj7ghFkiljVayXGe8menBn0eJSe/AXn5
 qNF4Dj3ZT31OMib4buiw+FF4IfQzb2bFoTewqqPrCclGlehi7hWSIwarxb+2qVlHiAZR7v
 CygFRvBHYYcFTeeLXAqkd1QjQkTKB/lhiJNHYunYwzgkWaUV/qCraeEIKEssl8SSQdTVtK
 28+irRZ4+KaztsK9eXK5POlGExA38D0eGLNtIADViuorhrtD301gQq0NPI33ag==
Date: Tue, 3 Oct 2023 15:28:47 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 13/16] arm: rmobile: Add CPU detection for RZ/G2L
Content-Language: en-US
To: Paul Barker <paul.barker.ct@bp.renesas.com>, u-boot@lists.denx.de,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Hai Pham <hai.pham.ud@renesas.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20230920124212.63535-1-paul.barker.ct@bp.renesas.com>
 <20230920124212.63535-14-paul.barker.ct@bp.renesas.com>
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20230920124212.63535-14-paul.barker.ct@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 6a904c32c8b62d35268
X-MBO-RS-META: shajwo5indigco5bo9n8z8yoxxfxkqbu
X-Rspamd-Queue-Id: 4S0Jqz4XpNz9spF
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
> The ARM TrustedFirmware code for the Renesas RZ/G2L SoC family passes a
> devicetree blob to the bootloader as an argument in the same was

same way (typo)

> previous R-Car gen3/gen4 SoCs.

Gen3 / Gen4

> This blob contains a compatible string
> which can be used to identify the particular SoC we are running on.

Why not read the PRR ?

[...]
