Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70BFEC02198
	for <u-boot@archiver.kernel.org>; Sat,  8 Feb 2025 21:31:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01D7F8082A;
	Sat,  8 Feb 2025 22:31:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="iKF3Juqc";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ju4VD8f5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53D6D807FE; Sat,  8 Feb 2025 22:31:15 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 99A31807FE
 for <u-boot@lists.denx.de>; Sat,  8 Feb 2025 22:31:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4Yr3tS2Nftz9t4R;
 Sat,  8 Feb 2025 22:31:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1739050272;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R0wSJ/tDmEcP8FBghxViadbm+RLVNgI1z96m2QkKxc8=;
 b=iKF3Juqc21RA3HZz2HXqPs1pF1eAMpSiP1kaph1zsJ21czTsbge98WmJ19Xdm1vK0aU2Cu
 yPM2zWLc/vTDHIuFzZMjWSOQlV5BinqOJpqRiq1AR4oC74EcceUs7qXCfqc0QkfENk+58y
 C5lNfck5GNXKaJPSyJlHvXLY8pNq4xvbpgpsDe/oHee0BXv5PkRzSJ8dMlaeGWY9j/GAkp
 BYb7CJgkJGBhjfaIevZRe3Kxk7ViJ0h0e2ajrvAWAKEc11k5n5zDg9VNGca4pzTa3wiW1U
 ETtKak9yTZCmsls9SGAeBnJQ+z5vvtBbKlKvDfHdboJB6p23pjgiMQWT5yyYuw==
Message-ID: <196c5bed-0715-480f-b1c2-20724fc056c3@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1739050270;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R0wSJ/tDmEcP8FBghxViadbm+RLVNgI1z96m2QkKxc8=;
 b=ju4VD8f5YBZJ/1QvDEO2MkQG2S3xICt+UQzlXAA3HoSvZV6VGj/v/NJT4aJui0leNRERd/
 6FLLu5cul3gXHAg8MYKLAsIL6vF9ybuUJyfyUDorY8E5tiLGOscEhV9u3K8h7Tj5wo/niC
 G6awrPdJIOyBAbBFZkMewF0nQRhkee7A8MMmtMYmtt0h/6vaEw47dIYtbTMc7GC+xSbNVJ
 WwEsBMXwfBcxv3LnqdLWpAQbYwNDfXBSPCgQlSxbdAcYASvcy0T2J8+klQn1vGEkSsHCqx
 pz5sZulxLrq92ci8L9vaQ+VIvfoWsRBKcE8xAjm2TrdwdV5XuG/W7QQDJcwfEA==
Date: Sat, 8 Feb 2025 22:28:16 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] net: ravb: Drop empty init callback
To: Paul Barker <paul.barker.ct@bp.renesas.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Christian Marangi <ansuelsmth@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, Mario Six <mario.six@gdsys.cc>,
 Michal Simek <michal.simek@amd.com>, Nobuhiro Iwamatsu
 <iwamatsu@nigauri.org>, Ramon Fried <rfried.dev@gmail.com>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tom Rini <trini@konsulko.com>
References: <20250118063458.137258-1-marek.vasut+renesas@mailbox.org>
 <44f1d2e2-7da3-4682-9402-b9b51f1b4dff@bp.renesas.com>
 <3f1613ff-7306-4f94-863a-a204617f3fb5@mailbox.org>
 <982868e8-0106-4e1d-812d-a5cd3e5534a2@mailbox.org>
 <56ef4788-78e6-4945-a954-ef8a360977d3@bp.renesas.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <56ef4788-78e6-4945-a954-ef8a360977d3@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 74c173247bd03205ccf
X-MBO-RS-META: uq5cy51efmh3bpe75czcyt9rfdqfz7km
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

On 2/4/25 7:30 PM, Paul Barker wrote:
> On 25/01/2025 12:34, Marek Vasut wrote:
>> On 1/21/25 1:15 PM, Marek Vasut wrote:
>>> On 1/21/25 1:07 PM, Paul Barker wrote:
>>>> On 18/01/2025 06:34, Marek Vasut wrote:
>>>>> The init function does nothing, the bb_miiphy_init() already checks
>>>>> whether the .init callback is assigned, and if not, skips calling it.
>>>>> Remove the empty init function. The entire init callback will be
>>>>> removed in follow up patches.
>>>>>
>>>>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>>>>> ---
>>>>> Cc: Christian Marangi <ansuelsmth@gmail.com>
>>>>> Cc: Evgeny Bachinin <EABachinin@salutedevices.com>
>>>>> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>>>>> Cc: Jerome Forissier <jerome.forissier@linaro.org>
>>>>> Cc: Joe Hershberger <joe.hershberger@ni.com>
>>>>> Cc: Mario Six <mario.six@gdsys.cc>
>>>>> Cc: Michal Simek <michal.simek@amd.com>
>>>>> Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
>>>>> Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
>>>>> Cc: Ramon Fried <rfried.dev@gmail.com>
>>>>> Cc: Simon Glass <sjg@chromium.org>
>>>>> Cc: Sughosh Ganu <sughosh.ganu@linaro.org>
>>>>> Cc: Tom Rini <trini@konsulko.com>
>>>>> Cc: u-boot@lists.denx.de
>>>>> ---
>>>>>    drivers/net/ravb.c | 7 +------
>>>>>    1 file changed, 1 insertion(+), 6 deletions(-)
>>>>>
>>>>> diff --git a/drivers/net/ravb.c b/drivers/net/ravb.c
>>>>> index 7286ad19598..f9c27f0f370 100644
>>>>> --- a/drivers/net/ravb.c
>>>>> +++ b/drivers/net/ravb.c
>>>>> @@ -560,11 +560,6 @@ static int ravb_remove(struct udevice *dev)
>>>>>        return 0;
>>>>>    }
>>>>> -static int ravb_bb_init(struct bb_miiphy_bus *bus)
>>>>> -{
>>>>> -    return 0;
>>>>> -}
>>>>> -
>>>>>    static int ravb_bb_mdio_active(struct bb_miiphy_bus *bus)
>>>>>    {
>>>>>        struct ravb_priv *eth = bus->priv;
>>>>> @@ -626,7 +621,7 @@ static int ravb_bb_delay(struct bb_miiphy_bus *bus)
>>>>>    struct bb_miiphy_bus bb_miiphy_buses[] = {
>>>>>        {
>>>>>            .name        = "ravb",
>>>>> -        .init        = ravb_bb_init,
>>>>> +        .init        = NULL,
>>>>
>>>> Do we need to explicitly set this to NULL? The field should be
>>>> initialised to zero if we omit it.
>>> I don't think it does, this is only a safety assignment until this .init
>>> callback gets fully removed in follow up series.
>>
>> I would like to pick these two patches for the upcoming release, is that
>> OK with you ?
> 
> I am sure the NULL assignment isn't needed.
> 
> The C11 standard [1], section 6.7.9, paragraph 10 states that for
> objects with static storage duration, if a field isn't initialized
> explicitly it will be initialized to NULL/zero.
> 
> [1]: https://www.open-std.org/jtc1/sc22/wg14/www/docs/n1548.pdf
I'll be wrapping these two patches into the larger bb_miiphy series and 
send V2 then.
