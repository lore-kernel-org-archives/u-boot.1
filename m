Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ABF0E7AD46
	for <u-boot@archiver.kernel.org>; Tue,  3 Oct 2023 13:41:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CCF4587468;
	Tue,  3 Oct 2023 15:40:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="YWwmCQvU";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="iHyNrWd6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 774F187460; Tue,  3 Oct 2023 15:40:49 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE44086E13
 for <u-boot@lists.denx.de>; Tue,  3 Oct 2023 15:40:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4S0Jqg3PgXz9sW5;
 Tue,  3 Oct 2023 15:40:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1696340447;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rd4dACFLc9SgWojeXUBuBKMfSj1Y4LG4qGuLuFRJlG4=;
 b=YWwmCQvUKRwujrZtSR9RSRfhOoNtPMvE+YM0EwdQ7yXbqHr/ykwJcB3H3d5p1bL7DaBT0Y
 cc7UnqBE7ku3tS4ypP37+v3vZBhrNc2lI7z4nwcyRxdjYdbI/WstKpFmW1Qvb9zmyqzaTZ
 dBIJBdpimMizZBI56QADgEMo6DMf07OrOzrDFYn3mCS30B/87UlD4A7In2DSCQQUvsRZzX
 rIcXKB+ViY8vCCStN0O3yHlGsoLOmpLbgvNGzfRv3NA+ClNwKSIQ36j6ZKVtddTg32LDjP
 hZMyWWlLAVbhdZMZTuDESMOuL67j/Cc+4srqDEyiQmjC5UHFmmvU1L07aQtgGw==
Message-ID: <530a9fe1-c8a6-01cd-483c-540e39e48766@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1696340445;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rd4dACFLc9SgWojeXUBuBKMfSj1Y4LG4qGuLuFRJlG4=;
 b=iHyNrWd6XE4ggUNWdVcNOXSNTgV+JANa8zdm+3EEHvdIZs/N71cg/FQWdMgZTmijRJjkWg
 xC3jrbYMHrwrFoWTOXYQ5wxjHU1SP2/ahMwjBolnj4aZHA49Pk9ey0nS+9XMZw6fxC05kJ
 PLIwCWqL72XY0Q5x15x7lAAL3OYlJ1tW83WAZwA/RV/WlPzANImH7k3/TkdXkg2IQHCAne
 QCkKjRUoKq/5Q6WGcA0oQ970Ho+Sq+joxWlSOb6wYO4WfEZJRpP+EyKrAKwC8sHkc49K9E
 14MwebrhJjhcYL+jpcE+Mr3fS3f859WB1bmeN9uL5XV6WeQvtB4rVPi1YFztlg==
Date: Tue, 3 Oct 2023 14:43:03 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 04/16] dt-bindings: Add RZ/G2L IRQC bindings
Content-Language: en-US
To: Paul Barker <paul.barker.ct@bp.renesas.com>, u-boot@lists.denx.de,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Hai Pham <hai.pham.ud@renesas.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20230920124212.63535-1-paul.barker.ct@bp.renesas.com>
 <20230920124212.63535-5-paul.barker.ct@bp.renesas.com>
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20230920124212.63535-5-paul.barker.ct@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: e0b121fcd8468de0b50
X-MBO-RS-META: 74e8xxp5j1tfii9x4mt9kgf9a6p4y55e
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
> Import bindings for the Interrupt Controller (IRQC) module in the
> Renesas RZ/G2L SoC family.
> 
> This patch is based on the dt-bindings in Linux v6.5.


Please also include the exact commit ID in the remote project when 
importing files from it, see example in e.g.:

a7be3fb54a65 ("ARM: dts: renesas: Synchronize R-Car R8A77990 E3 DTs with 
Linux 6.5.3")

With that fixed:

Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
