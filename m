Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E89CAC52D7B
	for <u-boot@archiver.kernel.org>; Tue, 13 Aug 2024 13:07:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47FDE88842;
	Tue, 13 Aug 2024 15:07:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1723554465;
	bh=TMILeSjq0zAFNx6T/45rMDVRHCJ91PRZ5srZyO1v8Ys=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ez/EWVggSy2UMNza8kqlJkUM+CpMlbEeEu8fzJ21m4yTIVTY6N0fQqh1RlH89S007
	 kpjI6iMLdiUggk5wOuIY31FmXJcIY/d4uFYPfnyEuM8FR8+BiEau/faV3JxJE8vdSt
	 R5m5kYlsrH8KoHpvdLTTtIAWbaBpRzK0b8Fe/neJkMlR03EcA0Dwzwf0M5VIKFSaCG
	 B+FVW8eDXoKSEbsuAbSyetBjTKnfz2Yc9xywRmEhL2ISicT0+gWQ02BWUbJOY7iBka
	 OfTmZdNy0fnkZx/JROozC4cm7JN1otlOM3I4kleYbjGM0/oLtJ+NFjHjc5awTE+Sy0
	 0dn8dpk0drJ1A==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 2DD24881F4;
 Tue, 13 Aug 2024 15:07:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1723554464;
 bh=TMILeSjq0zAFNx6T/45rMDVRHCJ91PRZ5srZyO1v8Ys=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=brxbQSxWjVMe6ktGmn1ZRqxFhwsN8zY1bKWln5KRgg+0ETqX8IU5SWRBNznSQ0vgt
 2KtdLl+5n0VkEXk0GIUxx9t+n1+Jioh/KBXxyhf6vprRYZf9Yyec3eleY+5wRYYcaN
 rz7tn9DHOxUsWCE0B78a5L/waDE9xM0NYViCoc8AqT+sCoKUot0iDWzyc4E1ofSRHY
 p2PzMzrb57mo4l29Es7eIUopVIyC+2Y7FEAsr4cVF/hOZ5ZhMOCuqduSf0osq1o34x
 9Hdp4Nw7DQ6CZlbOPfj9zeuYr/v1DIni+ZCcLQv11Xw8iMaIzbILHBeTySgObcjqx9
 P28pWBR7bF84Q==
Message-ID: <12e540f6-9b15-48ac-83ea-bd9d5d823102@denx.de>
Date: Tue, 13 Aug 2024 14:35:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] usb: dwc3: support USB 3.1 controllers
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Igor Prusov <ivprusov@salutedevices.com>, Nishanth Menon <nm@ti.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Stefan Bosch <stefan_b@posteo.net>, Tom Rini <trini@konsulko.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Eugen Hristev <eugen.hristev@collabora.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
References: <20240423141551.2410199-1-caleb.connolly@linaro.org>
 <eb12b7f6-dba1-42ac-adb6-3c180d811130@denx.de> <87ed6ssj5x.fsf@baylibre.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <87ed6ssj5x.fsf@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 8/13/24 2:26 PM, Mattijs Korpershoek wrote:
> On dim., août 11, 2024 at 19:37, Marek Vasut <marex@denx.de> wrote:
> 
>> On 4/23/24 4:15 PM, Caleb Connolly wrote:
>>> The revision is different for these, add the additional check as in
>>> xhci-dwc3 core_init code.
>>
>> Reviewed-by: Marek Vasut <marex@denx.de>
>>
>> Thanks !
> 
> Marek, should I pick this up through u-boot-dfu or will you pick it up?

I think this is already in u-boot/master , isn't it ?
