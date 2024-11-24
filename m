Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89F60D3B7C3
	for <u-boot@archiver.kernel.org>; Sun, 24 Nov 2024 22:51:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A551C8976E;
	Sun, 24 Nov 2024 23:51:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1732488678;
	bh=gLYbLfd9N3pNliQ84XTtt+qFvOw+nfWADrnBckY8xEc=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=k3nx9GCEMbumw3KGK6KwLh0sM7UClYyf9q4JbxjchWbpTc5pookCvKdy4WCfjgpuJ
	 3QsRxbEDbb1SNYoQXY3DIFu+CllEKwL6ai3m7Hp9JelFAYSiFPrxUTG2a0Vtq5abqD
	 7VOw6ocBwGf0/n/zZ/Ri8N/GqKeb49+Mt4t9O1wu8r3omj1iokmbzCj4cjL5UKurBa
	 +DdWK6jxtbim/47fFLiTF8jowY/C4o+8LUtov4THYz+PzA0VIdrzPTnM/QZz0iw9Nd
	 P+5kcemS5YvxLLOhsgVCGMfZvwf3Ebdqq5jVFhsTTO5noJW6dCpET3vBPyr5QDsA/B
	 rChaT/5gKBTsw==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 1EC43895B7;
 Sun, 24 Nov 2024 23:51:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1732488675;
 bh=gLYbLfd9N3pNliQ84XTtt+qFvOw+nfWADrnBckY8xEc=;
 h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
 b=LaJEDrNMz7WIqic7A2Y3yHRN7tkP14pkrTWBM2qevFsFKNoz51jiFimqKZGN52qHM
 +7JPb3LTRjqQPe6OxPWXEjTbs5f1tg1XtQumA0dwyA6iXe9PhRubGC0SLT8wxFOU70
 tiARebh3l4FHcfKfaeC5RGl9EqlV0aeuzUao9yg5wGetBDip2qQg83jNXoxDJtq67r
 XL1gJIEmP7hC/wdFXrebFBqj3cEkuXY10Npjsm6xX7MACiZtHoodSBFcXRhdix2fNg
 Lz2A5rPAw2Oa9NRaas2dWqqkGzKQu/R7dt1kDs0Hhvx7/xH/u+Dc7CuLFk2pTIH6QN
 0sBhHa3/GbDeQ==
Message-ID: <751efcf2-b51f-43b8-affb-46fdbd59002a@denx.de>
Date: Sun, 24 Nov 2024 23:11:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 3/3] board: dhelectronics: Sync env variable
 dh_som_serial_number with SN
From: Marek Vasut <marex@denx.de>
To: Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 u-boot@lists.denx.de
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Fabio Estevam <festevam@gmail.com>, Stefano Babic <sbabic@denx.de>,
 Tom Rini <trini@konsulko.com>, u-boot@dh-electronics.com
References: <20241121172154.90507-1-cniedermaier@dh-electronics.com>
 <20241121172154.90507-3-cniedermaier@dh-electronics.com>
 <f87a45e6-0f37-4625-bf34-12205b8ee4b7@denx.de>
Content-Language: en-US
In-Reply-To: <f87a45e6-0f37-4625-bf34-12205b8ee4b7@denx.de>
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

On 11/24/24 10:10 PM, Marek Vasut wrote:
> On 11/21/24 6:21 PM, Christoph Niedermaier wrote:
>> The env variable "SN" is used to store the serial number on DH 
>> electronics
>> SoMs. New SoMs will use the variable "dh_som_serial_number". To ensure
>> compatibility, these env variables are synchronized. This is achieved
>> using callback functions. To avoid recursive calls, these are locked
>> against each other.
> 
> What kind of recursive calls?
> 
> It would be good to expand the commit message and elaborate on the 
> recursive calls problem .
> 
>> diff --git a/board/dhelectronics/common/dh_common.c b/board/ 
>> dhelectronics/common/dh_common.c
>> index a7b0472a09..2e3e5c483b 100644
>> --- a/board/dhelectronics/common/dh_common.c
>> +++ b/board/dhelectronics/common/dh_common.c
>> @@ -45,6 +45,32 @@ struct eeprom_id_page {
>>   #define DH_EEPROM_ID_PAGE_V1_0_DATA_LEN    (sizeof(struct 
>> eeprom_id_page) - \
>>                       offsetof(struct eeprom_id_page, mac0))
>> +static bool in_dh_som_serial_number;
>> +static bool in_SN;
>> +
>> +static int on_dh_som_serial_number(const char *name, const char 
>> *value, enum env_op op,
>> +                   int flags)
>> +{
>> +    in_dh_som_serial_number = true;
>> +    if (!in_SN)
>> +        env_set("SN", value);
>> +    in_dh_som_serial_number = false;
>> +    return 0;
>> +}
Maybe a more generic solution is:

diff --git a/lib/hashtable.c b/lib/hashtable.c
index e8a59e2dcac..75c263b5053 100644
--- a/lib/hashtable.c
+++ b/lib/hashtable.c
@@ -221,11 +221,32 @@ static int
  do_callback(const struct env_entry *e, const char *name, const char 
*value,
             enum env_op op, int flags)
  {
+       int ret = 0;
+
  #ifndef CONFIG_XPL_BUILD
-       if (e->callback)
-               return e->callback(name, value, op, flags);
+       static bool in_callback;
+
+       if (!e->callback || in_callback)
+               return 0;
+
+       /*
+        * In case there are two variables which each implement env callback
+        * that performs env_set() on the other variable, the callbacks will
+        * call each other recursively until the stack runs out. Prevent 
such
+        * a recursion from happening.
+        *
+        * Example which triggers this behavior:
+        * static int on_foo(...) { env_set("bar", 0); ... }
+        * static int on_bar(...) { env_set("foo", 0); ... }
+        * U_BOOT_ENV_CALLBACK(foo, on_foo);
+        * U_BOOT_ENV_CALLBACK(bar, on_bar);
+        */
+       in_callback = true;
+       ret = e->callback(name, value, op, flags);
+       in_callback = false;
  #endif
-       return 0;
+
+       return ret;
  }

  /*
