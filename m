Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0F43D6AAF2
	for <u-boot@archiver.kernel.org>; Thu,  2 Apr 2026 16:49:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4DD3C83F7D;
	Thu,  2 Apr 2026 18:49:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=posteo.net header.i=@posteo.net header.b="qKZGD0t6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 524F083F8F; Thu,  2 Apr 2026 18:49:31 +0200 (CEST)
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D87183CF5
 for <u-boot@lists.denx.de>; Thu,  2 Apr 2026 18:49:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stefan_b@posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
 by mout01.posteo.de (Postfix) with ESMTPS id EAECB240027
 for <u-boot@lists.denx.de>; Thu,  2 Apr 2026 18:49:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.net; s=2017;
 t=1775148568; bh=6YfXLPXCFpQ8y5W7QKLMnFAr8kLLEF8m5JeBXvfx8n4=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:Content-Type:
 Content-Transfer-Encoding:From;
 b=qKZGD0t6tuuyDOrLphXm7X9OnZAc//wnuiVxBL4pF0K2NMusylUWf53usUEa0RsDh
 iOlLglKz4j/LOZXOWCV5rZFhqk3OlfarwU3YtBiawlPQqlTN1NRnTLWe2RITwwqn0O
 V0eQakQ/8YGK7lJNUC3D88YlY6Iv2XjaVeV27qjFeI5Edqkwn0uA0aqDv3E3tXnSI3
 MCrTB+TyE3p+d1n1Z8+d+oP/May05vJz66wvQXFQeNGxSy7g2qCziDWzqvJT15TN0T
 uZPJp9nlU/4RJ3H/ouWM/hxloetpe58oVRTNuq3fnunWrzW+bAjXlDeyztGVzgZf3X
 ufeWhTVpCZRJA==
Received: from customer (localhost [127.0.0.1])
 by submission (posteo.de) with ESMTPSA id 4fmnrS3GXVz6tw2;
 Thu,  2 Apr 2026 18:49:28 +0200 (CEST)
Message-ID: <3317b47b-c505-5bf8-7d68-f3c5139746d6@posteo.net>
Date: Thu, 02 Apr 2026 16:49:28 +0000
MIME-Version: 1.0
Subject: Re: [PATCH] s5p4418_nanopi2: Drop unnecessary BOARD_EARLY_INIT_F usage
Content-Language: en-US, de-DE
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20260325190031.3428654-1-trini@konsulko.com>
 <37959750-b370-97cc-5f55-e0d6c045a8f0@posteo.net>
 <20260331181517.GE41863@bill-the-cat>
From: Stefan Bosch <stefan_b@posteo.net>
In-Reply-To: <20260331181517.GE41863@bill-the-cat>
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

On 31.03.26 20:15, Tom Rini wrote:
> On Tue, Mar 31, 2026 at 05:40:01PM +0000, Stefan Bosch wrote:
> 
>> Hi Tom,
>>
>> thank you for the patch. You are right, board_early_init_f can be removed.
>> But where is CONFIG_BOARD_EARLY_INIT_F enabled, I didn't found it. Have I
>> missed something?
> 
> This might be another case (since I sent out a dozen similar patches)
> where the platform wasn't actually enabling it either and so the commit
> message is wrong in that regard. I can fix that when applying if that's
> OK with you.
> 
That is OK for me, thank you.

>>
>> Regards
>> Stefan
>>
>> On 25.03.26 20:00, Tom Rini wrote:
>>> This platform enables CONFIG_BOARD_EARLY_INIT_F and then has a
>>> do-nothing board_early_init_f function. Change to not enabling the
>>> option and so not needing an empty function. >
>>> Signed-off-by: Tom Rini <trini@konsulko.com>
>>> ---
>>> Cc: Stefan Bosch <stefan_b@posteo.net>
>>> ---
>>>    board/friendlyarm/nanopi2/board.c | 5 -----
>>>    1 file changed, 5 deletions(-)
>>>
>>> diff --git a/board/friendlyarm/nanopi2/board.c b/board/friendlyarm/nanopi2/board.c
>>> index 4dff32e10d6b..ca8ae529ddf4 100644
>>> --- a/board/friendlyarm/nanopi2/board.c
>>> +++ b/board/friendlyarm/nanopi2/board.c
>>> @@ -406,11 +406,6 @@ __exit:
>>>     * call from u-boot
>>>     */
>>> -int board_early_init_f(void)
>>> -{
>>> -	return 0;
>>> -}
>>> -
>>>    int board_init(void)
>>>    {
>>>    	bd_hwrev_init();
> 

Reviewed-by: Stefan Bosch <stefan_b@posteo.net>
