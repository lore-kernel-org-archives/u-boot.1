Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0403D41D46
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 02:51:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F11A893B9;
	Tue, 12 Nov 2024 03:47:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=linux.starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 292B289394; Tue, 12 Nov 2024 03:26:07 +0100 (CET)
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8928289383
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 03:25:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=linux.starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=hal.feng@linux.starfivetech.com
X-QQ-mid: bizesmtpsz6t1731378296t8ger5z
X-QQ-Originating-IP: 7Rq4y8v1SlzQn7lOdDBEaLiX5UREc23E1Ec+4ggWNe4=
Received: from [192.168.125.182] ( [183.27.99.69])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 12 Nov 2024 10:24:54 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11365542632168157020
Message-ID: <3F07CA2BB3D8B31A+95145369-d997-41e3-a8f0-28417f9ab840@linux.starfivetech.com>
Date: Tue, 12 Nov 2024 10:24:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/13] dt-bindings: Remove StarFive JH7110 clock and
 reset definitions
Content-Language: en-US
To: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hal Feng <hal.feng@starfivetech.com>
Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Minda Chen <minda.chen@starfivetech.com>, u-boot@lists.denx.de,
 Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@linaro.org>, Rick Chen <rick@andestech.com>,
 H Bell <dmoo_dv@protonmail.com>, E Shattow <lucent@gmail.com>,
 Conor Dooley <conor.dooley@microchip.com>, Nam Cao <namcao@linutronix.de>,
 Bo Gan <ganboing@gmail.com>
References: <20241111020808.38974-1-hal.feng@starfivetech.com>
 <20241111020808.38974-4-hal.feng@starfivetech.com>
 <da0f9fde-4ddc-4f03-ad3f-21887a967d94@gmx.de>
From: Hal Feng <hal.feng@linux.starfivetech.com>
In-Reply-To: <da0f9fde-4ddc-4f03-ad3f-21887a967d94@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:linux.starfivetech.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: N/SjMk6IgvyQ7nCWjSPo+xseR+kh9FwYZZz3Gi3OI3RG87gtsC2SmIFa
 rmSQNL8XQDDuK9icv3/zYJQc9rGjdkRB4uDGjyNzpKLg6q2bArpAxZYpLnVOPoghqc65eFs
 7QJRaQhww7jrm6SkU6cLvTzXgsfbOcVtKM8X0cFYDvSyNge2TpZYzS0Vk0wnhsj4YVu473x
 c9kCk6AMHlIx1ZUpRHSyMO5BKE2A/PXxMqLphMWYdbYWtRzedoJfJR7NpOHa2prPXdutVsG
 sz7bJizxnUtzHdPKpdCDR4YMAL6EEKUqqlz9x04ArT4u40Y9Kgf+pCDbRZKOswaqGVwc0OB
 kZHUyUvMhcDaaMDFpW/XjU2tFjvKNqTrOHonUqiThogBR4ectwOX1Gt4uQX2maY8wANB16m
 /EX3mWaJuZ66ZB/5UQIdlCvlHeBW0JaWtxcVuC4RoyLbYLb5jxfZnC9iBK+NBm5D4b0YxaD
 xA2tP11DS/g5U6vXbsgpkogPAe/NwRpQOqKLOs5dXt6rLE+PtKRsM45gmwmCq97t5168l6V
 adoz8OWGsVPZniPPLoZorIlelL7Pqjr52t1nx4my4zSxbIUgQOmJ38PweYZh0JrxJyTGx0Q
 n6YHr/YjsjExlf9qnbrg424gr7vyo219jGV3s0PO/0seq8epGUgQH5PYIk+YbOgOIwOeiPQ
 J4hWnVx18xTHQDd69mEMDecYJ0hJ7v0LIdHaOQVK2hP8LWMXyr9kaxcWiX08Bqxi8j+FWVB
 AGTKacDqkFpps/53KU3YQT7DstWhZWuBwrI+6qhEss9gi0LNvact9b/KBfZHsjgmXh6uinB
 XPvCyWIS9Zd1GYOFmlNrMX3lCAnATG+vuCuw/uTKtsNN/1I1k3gqL1iCLnPp5XaGMvIfC9k
 Tb9uqluXO7EheViEXmmED5P6TSkUEajePdozTFOeJXuW8pGUjbDpC3TcX7Ozk/xe3jrW4na
 qc0fnuw5CCjn9isah/3k0TuTgdCe2YcL2vTY=
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0
X-Mailman-Approved-At: Tue, 12 Nov 2024 03:47:32 +0100
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

On 11/11/2024 6:52 PM, Heinrich Schuchardt wrote:
> On 11/11/24 03:07, Hal Feng wrote:
>> As JH7110 switch to use OF_UPSTREAM dt-bindings,
>> remove the redundant clock and reset definitions.
>>
>> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> 
> After merging patches 1-3 I get:
> 
>   CC      env/common.o
> drivers/clk/starfive/clk-jh7110.c: In function ‘jh7110_stgcrg_init’:
> drivers/clk/starfive/clk-jh7110.c:498:36: error: ‘JH7110_STGCLK_USB_APB’
> undeclared (first use in this function); did you mean
> ‘JH7110_STGCLK_USB0_APB’?
>   498 |         clk_dm(JH7110_STG_ID_TRANS(JH7110_STGCLK_USB_APB),
>       |                                    ^~~~~~~~~~~~~~~~~~~~~
> 
> We want git bisect to work. This requires successfully building after
> each individual patch.
> 

Got it. Will make some changes to make sure git bisect works. Thanks.

Best regards,
Hal
