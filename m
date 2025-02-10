Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C249AC0219D
	for <u-boot@archiver.kernel.org>; Mon, 10 Feb 2025 13:45:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ECF7480AE6;
	Mon, 10 Feb 2025 14:45:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1739195133;
	bh=sWGbjvx+OO75I6IEP5m3eFjyF8Oca9QDjjw8cS57aec=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BaYAO9X+SmHrQFpWxatTFH4bZzq8cZNQ33E2GulC1Pb5vQr1Bqu2DiyeMqWUdVpP8
	 1ax02ZJOZIy7O5WU2/vuzF7LT0h2fc0nrJVIftb2UFqYYpJoJKlMG249QqAFm7+svV
	 IJNrLRw+Lytw4uh872lZaWoAVD6G3Lrfkqg2QVv6z33mhrA2M9jWo8uON+bpQMWTEb
	 5h8r9cH6Xt0neMsRbl4hppSVYzt3LiXI5+Qj3KUSVwxFPZY7NM/XWSauop7UAsTgW/
	 0WIctXcimt79hW6d/8hMvj79Yb8oSUbem6ul1slrzTjpx4zwtOW2JSsbWdxdh+H2dN
	 MDUzSS83qCrCA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2CF3580B98; Mon, 10 Feb 2025 14:45:32 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB34380C5A
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 14:45:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="eSjmbaV7"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 1C8E81038010A; Mon, 10 Feb 2025 14:45:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1739195127;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sWGbjvx+OO75I6IEP5m3eFjyF8Oca9QDjjw8cS57aec=;
 b=eSjmbaV7SEbVf2mbAKNrXPLc8VE/vSsR8sEY9vofAf8KaSNhhb7d8MtPhqzVmDL6pAAm0L
 V0jkFJroTEmYsu4htu0rBVFN2XQh5S9l/J9pKCUwZSRGKzBHa1xjIMYcQ3x6UD17bRiv06
 WSQ6675gsg5UTWfFAsYt/2VJkifvYI+WUZPQdq0Wwr0tMHhF9txTwXwMA4VOJz4aOyfi25
 as24YW7Hb23yysNS0pvANXlHrtpEqA9TTyPQezq1QLoVW+Pzy5SxHDztubmu21BxohZDik
 hw/EgTktjYpopLbocibYwU6mCbLe+aK32nyWxzfrn7qf11bdty/ducm2MUkcHQ==
Message-ID: <c8790ad9-0e81-4780-8da8-bbc06377c360@denx.de>
Date: Mon, 10 Feb 2025 14:42:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/9] Restore USB and add UMS support for STiH407-B2260
To: Patrice CHOTARD <patrice.chotard@foss.st.com>, u-boot@lists.denx.de
Cc: Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
 U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jan Kiszka <jan.kiszka@siemens.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mathieu Othacehe <othacehe@gnu.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Robert Marko <robert.marko@sartura.hr>,
 Sam Protsenko <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>,
 Sjoerd Simons <sjoerd@collabora.com>, Tom Rini <trini@konsulko.com>
References: <20250130163547.512990-1-patrice.chotard@foss.st.com>
 <4492fe8a-1b60-44da-93b7-383eae3fa269@foss.st.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <4492fe8a-1b60-44da-93b7-383eae3fa269@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
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

On 2/10/25 11:28 AM, Patrice CHOTARD wrote:
> 
> Hi Marek

Hi,

> Any chance to get this series merged in next U-Boot tag 2025.04-rc2 ?
Gadget stuff is on Mattijs desk, please ping me in a few days if he 
doesn't pick it up, I'll do so then. Sorry for the delay.
