Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7C0FC19F32
	for <u-boot@archiver.kernel.org>; Wed,  5 Mar 2025 20:35:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A50981273;
	Wed,  5 Mar 2025 21:34:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="dqX1/1Ig";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="NzHkP9Y8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C122A80ECC; Wed,  5 Mar 2025 21:34:34 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0AC1811C1
 for <u-boot@lists.denx.de>; Wed,  5 Mar 2025 21:34:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4Z7PRX4DK6z9tC3;
 Wed,  5 Mar 2025 21:34:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1741206872;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QwWQIKi+k4kstA/e0C/fFL4jcpgFOkvDDSNmtJI5vgY=;
 b=dqX1/1IgugBkGCDfOWj2URmBjIaOtJWKDacvXjKN7V2ys9Hus+O5QFC8MYWYpVeVLr7O2I
 UTJj5HiEGJmZbv04RaRUvfXgIAdot8HpTp06Z56Scx8aOyP32d/3u3JtTf53Re2i/mQ9MX
 YmrXssBsTkTRfnOD9dkYQRRGE2svFLFA8tKbtYnwle6xex52BqvDc5D0a6QUSfJxNGY1qL
 urrVV0uoXhE+vbMKTccSvfv5MpVSnmyr3mrK+enir9tYlhmI7yeYE91MJYPZEyhNImEZzj
 CSnh5o4Lc2RgAE9Bwj8u7jhtoOKHc9ti7nN/Xk2Xy70GkkRGHrVkqrAQY92Zgw==
Message-ID: <f3a06e6b-468a-4ea1-822e-5c6a86b4ff5f@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1741206870;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QwWQIKi+k4kstA/e0C/fFL4jcpgFOkvDDSNmtJI5vgY=;
 b=NzHkP9Y8CTYd1I+G/2m/yx1nxXDES3EJo1lSdGp9G5Sw4yZsYx2xUvdqEMquvRuEGiAfWe
 yG4RHpGZ7U/kHMFIARuU0w/sLQ/MEX8EfI0Dk3xMD8aUKiwpMeVDLkwyE3Od+eGYMxa5vK
 A7fhb5CBHQD8SrMCWJa6QaS7f/x+ob2bSM0tOaooJPTuvrffRBK+xJSKM2uE2xsx4nydda
 fv28tBij19mU9Yj0bV0p9bzurRtvtQ3CRsLet/v4d7hwZVJLiebap3TKdsoSYq5SF5dXYr
 i4emYcnFytaGHuPB0BXWV6pVe0Lwog1Rl6dlC6YE9NRsSSa0obj+fvv4J7Puxg==
Date: Wed, 5 Mar 2025 21:32:18 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 4/5] phy: rcar: Support RZ/G2L USB PHY
To: Paul Barker <paul.barker.ct@bp.renesas.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250304163736.89326-1-paul.barker.ct@bp.renesas.com>
 <20250304163736.89326-5-paul.barker.ct@bp.renesas.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20250304163736.89326-5-paul.barker.ct@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 53036fdea94020649ae
X-MBO-RS-META: xk314fcf3567zi7qmnt7iokd7os9qgmj
X-Rspamd-Queue-Id: 4Z7PRX4DK6z9tC3
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

On 3/4/25 5:37 PM, Paul Barker wrote:
> Extend the existing Renesas R-Car gen3

Gen3 (uppercase G)

> USB 2.0 PHY driver to support the
> RZ/G2L and related SoCs.
> 
> Also enable this driver by default for the RZ/G2L SoC family.
> 
> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>

Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
