Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51398C3DA4A
	for <u-boot@archiver.kernel.org>; Sun, 11 Aug 2024 17:39:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13C0E884DB;
	Sun, 11 Aug 2024 19:39:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1723397972;
	bh=gqNXrwvCnchg0YWfWibe7SJUsLh22M8usZTnRqtX5rk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ncfOW5aietoKSDafTosBKu8/YR6jj3R4ANNHMcx8XCUwN1RYXQBuBrbfwPmm4cSY2
	 jTncwqodmIcDzFFMrbkii8IJWV09apJX+8kotIZpHBO5dmY0cUvN6xuLh6SRotK+4v
	 VZzejmV2pLcaggFdsMyV65C3vWole0uD26oN/epVNDgsFAvODC8GtnWKx/8SpF2zNZ
	 zg8xDVtJk6VwTKA0EbzJLEHAR1eZqsAyzDXtQegiR5pK4pJNMuwEYMenkPtNbSXQ2l
	 ZzAQebYVp1p5ME2XnREWmq5H0PyKssPSVoc1TZqHYt2M+YhuSMXVTxIN5sODuO5UTd
	 sTsk7YfPGySsA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 43D9C8837D;
 Sun, 11 Aug 2024 19:39:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1723397970;
 bh=gqNXrwvCnchg0YWfWibe7SJUsLh22M8usZTnRqtX5rk=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=KeGVc4+1+O94Oqv6ySFGIlSNgsSlV8P7hmc/U9OOuc1E6BkFYc2hcmBuh1gPOlRAJ
 2/+DEUhSwQ9R27KEM4KrQ+8mTzrm+EJw4jnzZrzEUMr5WcepBJLnebZY/Azm30Z+7s
 g9Rr/qlZluCR2PPOsx3ywsEg9uFWTLoZv9W2QKJTkYADTlyayzknAGf8X3rfK3VgYa
 9TwQbYMMFhUxQoVBCtkM3j1zfLOXk85Ei51L0Qn/DXOal6FiIPCx7zbu3WnzQtKjNs
 Lt+JJerPuHArAcmG7O2dPTG8WLVTr+TxhQt+mrEAGj1m+uJFfZeiITy6+tlGaXX2sr
 dHhsCrYQkE9sA==
Message-ID: <eb12b7f6-dba1-42ac-adb6-3c180d811130@denx.de>
Date: Sun, 11 Aug 2024 19:37:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] usb: dwc3: support USB 3.1 controllers
To: Caleb Connolly <caleb.connolly@linaro.org>,
 Igor Prusov <ivprusov@salutedevices.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, Nishanth Menon <nm@ti.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Stefan Bosch <stefan_b@posteo.net>, Tom Rini <trini@konsulko.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Eugen Hristev <eugen.hristev@collabora.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
References: <20240423141551.2410199-1-caleb.connolly@linaro.org>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240423141551.2410199-1-caleb.connolly@linaro.org>
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

On 4/23/24 4:15 PM, Caleb Connolly wrote:
> The revision is different for these, add the additional check as in
> xhci-dwc3 core_init code.

Reviewed-by: Marek Vasut <marex@denx.de>

Thanks !
