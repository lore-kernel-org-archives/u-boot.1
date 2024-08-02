Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86CFAC3DA49
	for <u-boot@archiver.kernel.org>; Fri,  2 Aug 2024 03:28:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D96A7866EE;
	Fri,  2 Aug 2024 05:28:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B07588718; Fri,  2 Aug 2024 05:28:32 +0200 (CEST)
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E19783333
 for <u-boot@lists.denx.de>; Fri,  2 Aug 2024 05:28:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=naoki@radxa.com
X-QQ-mid: bizesmtp84t1722569243tnvrbi4k
X-QQ-Originating-IP: s6QV/RvmDPL/HRe2Vz21FMbrISKE1x2x4HvBKTcBkfo=
Received: from [192.168.159.131] ( [106.150.157.243])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Fri, 02 Aug 2024 11:27:21 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9273069181475630164
Message-ID: <17C1D96C39DEF097+d7de14f3-d5e6-4eff-bf01-ebf8ea2535dc@radxa.com>
Date: Fri, 2 Aug 2024 12:27:20 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] board: rockchip: add Radxa ROCK 3 Model C
From: FUKAUMI Naoki <naoki@radxa.com>
To: Maxim Moskalets <maximmosk4@gmail.com>, trini@konsulko.com,
 u-boot@lists.denx.de, sjg@chromium.org
Cc: Maxim Moskalets <Maxim.Moskalets@kaspersky.com>,
 Jonas Karlman <jonas@kwiboo.se>
References: <20240722105623.74606-1-Maxim.Moskalets@kaspersky.com>
 <136B826B50004A39+ea8c295c-7877-4fc4-9912-3b35da605b8c@radxa.com>
Content-Language: en-US
In-Reply-To: <136B826B50004A39+ea8c295c-7877-4fc4-9912-3b35da605b8c@radxa.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:radxa.com:qybglogicsvrgz:qybglogicsvrgz8a-1
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

sorry,

On 8/2/24 10:54, FUKAUMI Naoki wrote:
> since USB Type-A OTG port is peripheral mode, you can enable USB gadget 
> functions. could you merge following patch?

it's wrong.

"usb_host0_xhci" dr_mode need to be deleted...

--
FUKAUMI Naoki
Radxa Computer (Shenzhen) Co., Ltd.

