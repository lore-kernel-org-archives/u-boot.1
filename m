Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF8B8C54FC6
	for <u-boot@archiver.kernel.org>; Sun,  1 Sep 2024 21:05:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39FE7884C3;
	Sun,  1 Sep 2024 23:05:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1725224736;
	bh=Fc99Zrajj0tLvNTP0nIx3KGyR3IyxG6APcqtbf6tcno=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hEaD/VSwj63Y+qvok+IFawvkB2vTP8QJ8c6LabskdNpIYsbG0oBBd936Q0PcvdR+D
	 5XkF1LLZJkSS63boVrP40hwVvJ09E0gC7PXO7GtiwAp9bQc7L2eRd0fZWjU9ERN9IA
	 U2hlzgEtWGUqWaqoK3q9wtpbhQsBqtgl3eJyQ7ke7kNs68LcqNHR1Qq645+JE5jZIi
	 nkUQI86GHg+3IsOdY789K9aTeCJR9btrqi4lFRgA7s1IezYkdf8Z6zpkhAvH3Xw0z8
	 SDsqp5nqbLJmp4yyQUowL1nwFRS7R2yFh0rrfhMqFkWmwjItci305+d5JF/EjsWqIC
	 Vl+pwrJHfAbcw==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 75A798690D;
 Sun,  1 Sep 2024 23:05:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1725224734;
 bh=Fc99Zrajj0tLvNTP0nIx3KGyR3IyxG6APcqtbf6tcno=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=J7iC0i30SQI8TWirn26J2gm8SaxGtlm93Gx6Oc1qB/jJh3V6lb9b60bzo1VKfsFbl
 tCvWdFJ5fTX315LY1u5MzIlM3HIiZL3b28c+9m0GrUnBUdhVr7H2hLEG2b5lzDzs8P
 ZQofng3rRsRoZhQHp317tsj0ZU5EwuUZwfNs6ky97a46KcnWYzgPumru1QsuQllIFf
 BJ2eNZBsVv6BuGFlscygi8eLtjkDlsfjiCeOe3kLi/5f6FXaxVi5ftxUEl7MNWWA+i
 nF6NXwSvGpXudMMdikh7CfrOK8Ms3Oz4rS1rJ9ZOrCYesQcxgsX77a4Gjl6w+u99K/
 SRP3odPnpY36g==
Message-ID: <c45c75ec-71b2-48cc-9493-96d25e1da1dd@denx.de>
Date: Sun, 1 Sep 2024 23:05:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/6] FUSB302 USB-C controller support
To: Simon Glass <sjg@chromium.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>,
 Soeren Moch <smoch@web.de>, Eugen Hristev <eugen.hristev@collabora.com>,
 Tim Harvey <tharvey@gateworks.com>, Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>
References: <20240830182330.49528-1-sebastian.reichel@collabora.com>
 <CAFLszTgLDHR2bVFmHaKktfP5Swd_4QZfavQC9GrAsHQh2-zj-A@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAFLszTgLDHR2bVFmHaKktfP5Swd_4QZfavQC9GrAsHQh2-zj-A@mail.gmail.com>
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

On 9/1/24 10:09 PM, Simon Glass wrote:

Hi,

> Are you able to build this on sandbox?

Let's find out:

https://source.denx.de/u-boot/custodians/u-boot-usb/-/pipelines/22195
