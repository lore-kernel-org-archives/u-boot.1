Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36696C27C53
	for <u-boot@archiver.kernel.org>; Wed, 19 Jun 2024 04:46:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50FB5883E7;
	Wed, 19 Jun 2024 06:46:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1718772362;
	bh=/QVZ4nBV1xzC5GFyytHV0C4rEr4SoyG1lR4FIlI/ejM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tSzRob234zgLO0iKETH1Cfx+9bte0MS819t9egobihXMoEHXMrln0Yl0FlfXjvR1s
	 CwRqB9mXrDYMRPs43E54K+thJ0Xi+sH0/cDdk97Ibme/PgdwYO4ENq3wnk1i2uklR1
	 SXVZLA+V002wAIWCx29+qxyuZHrD4YnPUHQ8NNcmehar8XfqHEQDCoMjkjlNhLsOZ4
	 i14QtVkY+n+XmVyjJxc+FHJCrGzxHgLQoSlPJkB7Y3+R0LQe0ighCoPwGxkNAeu/sw
	 +JQAG9cmGIRC3w3YUfcEySMp4fHVoMmo4RQ9k6fGKFvxHl4Iree1/xIXiAyB+7h9NA
	 uA0ByCwwa7uJw==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 39DC886784;
 Wed, 19 Jun 2024 06:46:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1718772361;
 bh=/QVZ4nBV1xzC5GFyytHV0C4rEr4SoyG1lR4FIlI/ejM=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=DbYpLjABnIKuhSIGkA6t/di/V4PGzroiWPGdEU2D25DxV5MpmzL9scrz7Lhw96scY
 ICfJmTNoR4xsAQ6xZRgHUdU8UuZu2Gett263pfn6LLvVJs1AC4R9aWxsguDEra2Ja9
 WGTSPDw32aL3fWW00NpnE5c1Dq5c6qfwyPfErT21N7UfDKY1YDPNOP5oizwQpX3tPz
 94PSDbdRx0t5KTusxG8jEOqj6MfiUTv9tQ9GNvvIFZ6nKbxZdZrDn+uqcH7APrZ11m
 381Jy5eLSWn0NEi6Egoe0w8cMVjfzM4b3OQTluvkBof7BUpXYb8xqxnQqePhN4KR5v
 8SNp3PkDSSxSA==
Message-ID: <cefb4e81-ac73-43e6-83e2-a7f14e007bf4@denx.de>
Date: Wed, 19 Jun 2024 06:15:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/1] usb: informative message if no controller
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, Dragan Simic
 <dsimic@manjaro.org>, Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
 u-boot@lists.denx.de
References: <20240618190729.15201-1-heinrich.schuchardt@canonical.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240618190729.15201-1-heinrich.schuchardt@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 6/18/24 9:07 PM, Heinrich Schuchardt wrote:
> The message 'No working controllers found' provides no clue that this
> refers to USB controllers.
> 
> Provide a message that refers to USB.

Applied, thanks.
