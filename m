Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E8AAC3DA63
	for <u-boot@archiver.kernel.org>; Tue, 23 Jul 2024 13:53:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8100888872;
	Tue, 23 Jul 2024 15:52:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1721742769;
	bh=o8kYk8bumQjMiaA2c56XmgyPYJGjlmfLr/fOSLJ+x9k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UtYOnPnH/5bREu2wvKKXdkIcan9GYErY6nWAdFBW1eDDbgDqnB4tzSx5cocH/BxoL
	 8avCV23vD5Wkn6Ci8q5nq0YNG7pKmQXcvHiFeCZEEaD5+LQR3No8DtaqO7inmc/1gZ
	 xOmWLw/FDzLqK/MJcvEhhG3FjvizP5tLFPRGIjCry5wjTihNDiASeUJEz9kUDb+CU2
	 5vF6MCL2UIRE1fetN7zIVKPCzh9GekWZ619Ma9p3jbjWEb7Xad3tsHI7u1h2HKp7g2
	 cXbqugQLEAe8nVFvVLqdvH39AEXNmOuwq6W+phtIQWQ9FloPNmQs2/YGUDHKUequtn
	 AJLYB12DcSIcQ==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 9013B8887C;
 Tue, 23 Jul 2024 15:52:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1721742768;
 bh=o8kYk8bumQjMiaA2c56XmgyPYJGjlmfLr/fOSLJ+x9k=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=nVIKbcECbcUxMTxYiyXLDWD3M9Etwus1HMu0CWYS84B8pZxgdr2mMMhwHVLqjZVaQ
 2phppA5uAJS6TiwaWEXCOH8DohgAsj+48P2qXoQxNBsx4uHg4thK5ClKdg8KNLzSbS
 Qk3NW1fhusLSq5jjdJps/tcmj1i2clffp1pJ3nJ8rg54EjwxAVy+l4YGH+DiEw1kBY
 9xk95OR3MN6NLSfiRY2dMgRHBN97//bDRgJhX3/GPeKoX6VE2QYntqHAX1Hl3jVSKZ
 0l5ncnZz5tees9jpjyM29TOsF9NobLbNlITm8yIOq9MlJ+3dyg6OV9O4lLbIMPLLgt
 /zr6YU9XR57fA==
Message-ID: <9c3100f8-835f-47ab-82d1-19985d78c575@denx.de>
Date: Tue, 23 Jul 2024 15:35:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/7] usb: gadget: atmel: Move usba_udc_pdata() with
 other static functions
To: Zixun LI <admin@hifiphile.com>, Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>
Cc: Zixun LI <zli@ogga.fr>, u-boot@lists.denx.de
References: <20240723131817.262596-1-zli@ogga.fr>
 <20240723131817.262596-5-zli@ogga.fr>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240723131817.262596-5-zli@ogga.fr>
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

On 7/23/24 3:18 PM, Zixun LI wrote:
> To make all static functions in the top, no functional change.

Reviewed-by: Marek Vasut <marex@denx.de>

Thanks !
