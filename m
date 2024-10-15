Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CC87D1D88B
	for <u-boot@archiver.kernel.org>; Tue, 15 Oct 2024 16:55:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01599889E9;
	Tue, 15 Oct 2024 18:55:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1729011339;
	bh=9UdZQjaVvLg/ZT0wsQrGi9B20U7+K5wUW56Lz2Af0SI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=p9aHUiySJvZfXJDfEP0dFpKnZrWEMepO2F/mZuF2Lb0fIRfHWhHsarq0XGmxNvYU5
	 ewNm4C0nHliQA8fFQ8OT+4UffEYEnF2/Ot5tQzJs6P13/eG3+Wxo3cTlMMCQq+sjyp
	 mPwVLnR1jMJV5jbKvKYl1z0YmuyJfuHdTIU6WH9d25On3FtxWZQNaLSqwKl5e+FQDe
	 yLId4DfrzGhFRwJVAv/EzAUYyt4PXpu9zSejgUB4fA+msfAVLtJc4zfnoi2bE2LyFp
	 XmcCRtG70p1JhcFlfNoOFAe/wnG2QtYYqfTpWSbzmgWggZLxXmw7UMfCRUDXo+crEZ
	 u+K3TaEdA0rCw==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 75E668878A;
 Tue, 15 Oct 2024 18:55:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1729011338;
 bh=9UdZQjaVvLg/ZT0wsQrGi9B20U7+K5wUW56Lz2Af0SI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=dal/jHn1LDQpw4nwntya3+hRIT2T3VZYeWzx3Qg8vJkI8EY8vlzFwb0yzHjT36QwY
 uel4bpbdkt6noie+O41IWsVri0mEC4zjZahA2NUW5HOSmOaDLw5T+ck2w5N+2Z6N5R
 IeRr5M9vlXflanQC37rg8GO95JDjCmbnVbK3Ji2O/OhXSUkriK+3n/lQa7Z1TQhQit
 J8JH1+I2p2x79Txx2pXhLqo5HPTghzc8aMHrol6wn/R8WA+AuRh1+IXq6JNNhjQMBJ
 bLpqPfznKmV2RuHubpSOyMXKUId8mzgTJZ96DS8pKh3wenJ1ab4cIxHXmy+14yqUj+
 9NfiqtfN6SuKw==
Message-ID: <55d0d6bc-e18f-4ac4-b017-03c3e8bca36c@denx.de>
Date: Tue, 15 Oct 2024 17:42:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 6/6] MAINTAINERS: add TCPM section
To: Sebastian Reichel <sebastian.reichel@collabora.com>,
 u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>,
 Soeren Moch <smoch@web.de>
Cc: Tim Harvey <tharvey@gateworks.com>, Kever Yang
 <kever.yang@rock-chips.com>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Simon Glass <sjg@chromium.org>, Anand Moon <linux.amoon@gmail.com>,
 Maxim Kiselev <bigunclemax@gmail.com>
References: <20241015152719.88678-1-sebastian.reichel@collabora.com>
 <20241015152719.88678-7-sebastian.reichel@collabora.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20241015152719.88678-7-sebastian.reichel@collabora.com>
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

On 10/15/24 5:26 PM, Sebastian Reichel wrote:
> Add new section for USB TypeC Port Manager (TCPM) support, which
> is needed to figure out cable orientation of USB-C plus and to do
> USB PD communication.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Acked-by: Marek Vasut <marex@denx.de>

Thanks !
