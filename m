Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FF7BC021B2
	for <u-boot@archiver.kernel.org>; Sun, 23 Feb 2025 12:55:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E287880F67;
	Sun, 23 Feb 2025 13:55:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Y9Sfnyp5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4CF8680FB6; Sun, 23 Feb 2025 13:55:44 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 23BC4807A8
 for <u-boot@lists.denx.de>; Sun, 23 Feb 2025 13:55:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 628BF3F516
 for <u-boot@lists.denx.de>; Sun, 23 Feb 2025 12:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1740315341;
 bh=tqa+lubX3Lk84nL7URkNTCmJnbnIjULMDXEW5H3DcfQ=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=Y9Sfnyp5SW9T4VnuKlLWAp0Z1qh0oDxF2qtkd1bP/XP/kGFR+ybJGtKBoNJyzVW6J
 5z34IKsjG9VHIxthnpeRa2y176sNiGNEvF1iekredZJ9pVTN5NP+jUI6CX4FKg7sfg
 LXs7gabXGT9n1afPFelSaDeWJEF573OirNraPAho6Wohbx8B66FHqHQrUiOxvmR8fl
 nAsBXcDNwf9EhT7Jb86vFpMLwDvBs7jbEpjQbf/pXDIbY6RIYcl+C3ClaKJF/tkxSd
 1I76sy0VXfbI6GYQ7nVpyYqkBJf3v5ynPDn++PU/1eiYrRrnlcVbHKUNtSR2Q1UiIb
 0DXY+3JyGYREQ==
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4398ed35b10so17950255e9.1
 for <u-boot@lists.denx.de>; Sun, 23 Feb 2025 04:55:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740315341; x=1740920141;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tqa+lubX3Lk84nL7URkNTCmJnbnIjULMDXEW5H3DcfQ=;
 b=qldQQnHEOKCI0EGOWSa8Sx7r57A9KsMs2A8arFboq0cRrfZMcBZAlDygCbbEYW0P4E
 5Ly7HQdlDWOq59bzPwcZ7YZRzE2ji6LBoxAdxsle9bmkQ2egQh+hGEZq5C+n78h3jzl3
 v17C5pHwn6qmkzOtQHjUyaubxvL4KwQRWgJK6cb7ASnFjdhHhNHYu0KPzGg2ktAmnd5n
 d/fBOB9Yx9/I88WLpzqxlP5GNUL2WTF3QpdGUAo4T5wfrRSJr3XDRp2+aJgIWKr+ivu/
 /ogrlaMu+SdUemcdOX5bLRbIna7lg92mMJoRwdECAMCoA2R0jgKcUkE7vdmo0ur/sRvi
 9+ZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVfvqv8sEy5M1tpcPEU+As3l3EeKMoByfZb6RZiKrWKFZkgdq7F0EyaxB/lO7pSOkDlbxBYBvE=@lists.denx.de
X-Gm-Message-State: AOJu0Ywjw62ON6gorm/X3/e2tnhEBdo/44CVrM4BRERFFAKFBqX6Jcdc
 BEuCX0yVWkbUfsvfPTVCRWdY9gm/LJgbeXg0Ps5Xt2t2iyHUx7lAEmV/DRTBsUosP23/aRBvbzt
 QMFLQuOGGHVFDGoqa6FbybUJqLLyDnhue+x2uGNjW4DrjexyFl5qxaYP/OhxrKWgImq8=
X-Gm-Gg: ASbGnctb7lAfvbR6BR051dy20gLMHEIPF3Xq9I3nJax6+sI2JQxMPdYgiRQhKlQJ7ll
 Dmes9hlxHtl+E1/ucD0tKXl3B76IvFviHSBMG9UH+l2EOWSf258WRlnOYEKbW5B/+Kezr9wsRWW
 UmAtxGQ9+ZLMKwO4ad9hMrw1OG0fvR1mOiwndnBq5U+s6Tjmkglz/m1KXPc/8n0jMwjwSRsyS8Z
 BQUPWUbAALtRQCeLdnP9+F7lQxwPShLsLyFmaC6FOJw72luK8mdi4jgDS7ALDNElK0ZKTUgbpsY
 JGsMw/3ms0zCsAJ9wFebiCXBdhAukTzroSBa79CdkBeZ4U7mMV2FJcLZeMTMFMt2g5ecElUqUBw
 dij+wazRp4RPK
X-Received: by 2002:a05:6000:4010:b0:38f:31b5:b33e with SMTP id
 ffacd0b85a97d-38f70827a09mr9235058f8f.35.1740315340735; 
 Sun, 23 Feb 2025 04:55:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF78hPxpSjyIHGtBr28uVgmbWoaC/K3yZtngkdOirKClAheBA+If4/XUZCb8bTLI6HHvlu/MQ==
X-Received: by 2002:a05:6000:4010:b0:38f:31b5:b33e with SMTP id
 ffacd0b85a97d-38f70827a09mr9235047f8f.35.1740315340392; 
 Sun, 23 Feb 2025 04:55:40 -0800 (PST)
Received: from [192.168.123.161]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f258b432asm28343524f8f.6.2025.02.23.04.55.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Feb 2025 04:55:39 -0800 (PST)
Message-ID: <f1252523-0ae3-4b8c-932a-de36fbbdac05@canonical.com>
Date: Sun, 23 Feb 2025 13:55:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] board: starfive: spl: strip off 'starfive/' prefix
To: E Shattow <e@freeshell.de>
Cc: Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, Simon Glass <sjg@chromium.org>,
 Yu-Chien Peter Lin <peter.lin@sifive.com>, Sumit Garg
 <sumit.garg@linaro.org>, "Leon M . Busch-George" <leon@georgemail.eu>,
 Lukas Funke <lukas.funke@weidmueller.com>, H Bell <dmoo_dv@protonmail.com>,
 u-boot@lists.denx.de, Leo <ycliang@andestech.com>,
 Rick Chen <rick@andestech.com>
References: <20250221095856.36530-1-heinrich.schuchardt@canonical.com>
 <20250221095856.36530-4-heinrich.schuchardt@canonical.com>
 <79f87309-a4a4-4332-8ea1-9a9df0174186@freeshell.de>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <79f87309-a4a4-4332-8ea1-9a9df0174186@freeshell.de>
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

On 2/23/25 02:33, E Shattow wrote:
> 
> 
> On 2/21/25 01:58, Heinrich Schuchardt wrote:
>> The configuration descriptions generated by binman contain the vendor
>> device-tree directory. Instead of adding it to all match strings just strip
>> it off.
>>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
>> ---
>> v3:
>> 	no change
>> v2:
>> 	no change
>> ---
>>   board/starfive/visionfive2/spl.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/board/starfive/visionfive2/spl.c b/board/starfive/visionfive2/spl.c
>> index 22afd76c6b9..d63eb1abe6a 100644
>> --- a/board/starfive/visionfive2/spl.c
>> +++ b/board/starfive/visionfive2/spl.c
>> @@ -118,6 +118,10 @@ int board_fit_config_name_match(const char *name)
>>   
>>   	product_id = get_product_id_from_eeprom();
>>   
>> +	/* Strip off prefix */
>> +	if (strncmp(name, "starfive/", 9))
>> +		return -EINVAL;
>> +	name += 9;
>>   	if (!strncmp(product_id, "VF7110", 6)) {
>>   		version = get_pcb_revision_from_eeprom();
>>   		if ((version == 'b' || version == 'B') &&
> 
> Let's insist on logic statements in board_fit_config_name_match()
> callback that begin with literal items (no pointer math trickery) from
> configs/starfive_visionfive2_defconfig:CONFIG_OF_LIST and in that order:

Thank you for reviewing.

Unfortunately your sentence starting with "Let's insist" does not 
provide insight into your reasoning.

Why do you want to add the 'starfive/' to each of the strings we compare 
instead of checking the common prefix first and the remainder next which 
results in a smaller binary?

> 
> #if CONFIG_IS_ENABLED(LOAD_FIT)
> int board_fit_config_name_match(const char *name)
> {
> 	if(!strcmp(name, "starfive/jh7110-milkv-mars") &&
> 	   !strncmp(get_product_id_from_eeprom(), "MARS", 4)) {
> 		return 0;
> 	} else if((!strcmp(name, "starfive/jh7110-pine64-star64")) &&
> 	   !strncmp(get_product_id_from_eeprom(), "STAR64", 6)) {
> 		return 0;
> 	} else if((!strcmp(name, "starfive/jh7110-starfive-visionfive-2-v1.2a")) &&
> 	   !strncmp(get_product_id_from_eeprom(), "VF7110", 6)) {
> 		switch (get_pcb_revision_from_eeprom()) {
> 		case 'a':
> 		case 'A':
> 			return 0;
> 		}
> 	} else if((!strcmp(name, "starfive/jh7110-starfive-visionfive-2-v1.2b")) &&
> 	   !strncmp(get_product_id_from_eeprom(), "VF7110", 6)) {
> 		switch (get_pcb_revision_from_eeprom()) {
> 		case 'b':
> 		case 'B':
> 			return 0;
> 		}
> 	}
> 
> 	return -EINVAL;
> }
> #endif
> 
> Not sure about code style so that is simply an example of keeping the
> sort order the same as how it exists in
> configs/starfive_visionfive2_defconfig:CONFIG_OF_LIST
> 
> Mars CM (and CM Lite) logic may be dropped since those targets do not
> exist at the moment in starfive_visionfive2_defconfig:CONFIG_OF_LIST
> however, I do anticipate to submit for review into Linux upstream soon
> and to begin that process. A donation board was sent to me so I now have
> Mars CM to test as well as Mars CM Lite.

As you are planning to upstream the boards I suggest to keep those 
lines. You could already use them by manually copying the device-trees 
into the upstream dtb folder and adding the files to CONFIG_OF_LIST.

> 
> Are the duplicate string definitions and logic in
> board/starfive/visionfive2/starfive_visionfive2.c:set_fdtfile() etc.
> still appropriate, could those now be factored out? I think Simon's
> suggestion (in reply on IRC) of CONFIG_FIT_BEST_MATCH could replace that
> functionality? -E

$fdtfile is used for loading a device-tree from the ESP. I can't see how 
CONFIG_FIT_BEST_MATCH which controls choosing FIT configurations is 
related. We cannot set $fdtfile from SPL.

Best regards

Heinrich
