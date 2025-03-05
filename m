Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41E22C19F32
	for <u-boot@archiver.kernel.org>; Wed,  5 Mar 2025 20:35:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 069F08121A;
	Wed,  5 Mar 2025 21:34:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="KpXtTk38";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="AiGJmH71";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF8B780ECC; Wed,  5 Mar 2025 21:34:33 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDE9880F92
 for <u-boot@lists.denx.de>; Wed,  5 Mar 2025 21:34:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4Z7PRW3sQSz9scM;
 Wed,  5 Mar 2025 21:34:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1741206871;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s3EGSqNjMAMq5HuRN5+sSGa6GFaZ14oSCM/pIZ0MtP8=;
 b=KpXtTk38iRT1KkOCvZOtOcEIZs9csgDZMqJFLUpURsk7T+bgbZL4FoKsa7jkOaj+2flOks
 5DN05x92D4ESl2pzSN/ZBQiy7jZZCWMKKoB7rFMjnV5XjvfMTdVQ0QOEHVrJ+A/Z4+KGSi
 uCKjv+/wIqylKkIstW1lbw1EwLHfdS6MvXHRM5olmNzSZxJnOil8rZtskC57wwlPGq3Q3h
 5R9vx6jawEziPjZR/UuH22Zi1Y/RpqMM6HjV/2LXCpLLfeHXjNoKSuUiPmmi7EWQWeYTlp
 IIWDEl//+7XYk4uamDbZspRQ+ZBh9HGpu+uZFUNKP5JeGMPyOQXC8RPUInJsAg==
Message-ID: <df4d1368-13bb-48e4-9d64-a30217002571@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1741206869;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s3EGSqNjMAMq5HuRN5+sSGa6GFaZ14oSCM/pIZ0MtP8=;
 b=AiGJmH71yvShvYEmRuYdy1F0+dr5AT17vx+Wc1vrPyGJ4X0JwbGE/+YS6ykCShFIfKTT+m
 kCrz7eFeDL3q7JHZHWu/04tjUlfdCenWjDX86q0jqtxqzivoOB0JFEpRukcDGDXTEzseXr
 jq9Ug/SruX96zBePXOvKauFZiWJ1AFb+BLHgEbnTcUCIGN/E5OFvB2FwY6/fJVSrTZaK8p
 iXRsRxPL424NyJPJirs+lHJUQ9vU+Uux/v6EYnVIBncOBvcELZw3ur7mjgAk6x/83IRGrk
 IIVXu7ztD+hHbnj+lk8LNebksl+8PzVNQotn1txUX/a9TTLq9G25K0FrgkhBRw==
Date: Wed, 5 Mar 2025 21:10:10 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 3/5] reset: rzg2l-usbphy-ctrl: Connect up vbus regulator
To: Paul Barker <paul.barker.ct@bp.renesas.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250304163736.89326-1-paul.barker.ct@bp.renesas.com>
 <20250304163736.89326-4-paul.barker.ct@bp.renesas.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20250304163736.89326-4-paul.barker.ct@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: a95ea0258c347b46376
X-MBO-RS-META: sajg7wgjjhbrgz9phix5zscipy1abp7a
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
> Bind the USB VBUS regulator driver under the USB PHY reset driver for
> the Renesas RZ/G2L and related SoCs. This additional bind is needed as
> the corresponding device tree node does not contain a compatible string.
> 
> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
