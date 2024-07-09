Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C61D9C2BD09
	for <u-boot@archiver.kernel.org>; Tue,  9 Jul 2024 13:32:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16B9288585;
	Tue,  9 Jul 2024 15:32:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="PDdDYcuI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EBC8F879AF; Tue,  9 Jul 2024 15:32:04 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C463B88585
 for <u-boot@lists.denx.de>; Tue,  9 Jul 2024 15:32:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Schultz@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1720531920; x=1723123920;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rrWdmYeSxJ0akt/Us8JS5GHWxv2ijFxuZoqy4+tH5hk=;
 b=PDdDYcuIL4fxsjyTYv7ECSWVzwU9pmkNmM4POqy9o9anhjO+pZvMY4QX3kVAFce+
 lyd+mVelUELW5a4Xt/1k7qE4J++JRS7VPJSMn9+yzENF7RxdaORu5erKXUuftM6E
 7q10MSPy98+YMIlhF91y2RncU3P80XNOBob80veabcA=;
X-AuditID: ac14000a-03251700000021bc-00-668d3bd07189
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 85.BA.08636.0DB3D866;
 Tue,  9 Jul 2024 15:32:00 +0200 (CEST)
Received: from [10.0.0.19] (172.25.0.11) by Berlix.phytec.de (172.25.0.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Tue, 9 Jul 2024
 15:31:54 +0200
Message-ID: <d5790f87-e4d4-4ac8-9858-2bb199f195ef@phytec.de>
Date: Tue, 9 Jul 2024 15:31:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] include: env: phytec: overlays: Add extension command
To: Yannic Moog <Y.Moog@phytec.de>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, "joe.hershberger@ni.com" <joe.hershberger@ni.com>,
 "trini@konsulko.com" <trini@konsulko.com>, Wadim Egorov <W.Egorov@phytec.de>
CC: "kamlesh@ti.com" <kamlesh@ti.com>, "d-gole@ti.com" <d-gole@ti.com>,
 Benjamin Hahn <B.Hahn@phytec.de>, "m-chawdhry@ti.com" <m-chawdhry@ti.com>,
 "mkorpershoek@baylibre.com" <mkorpershoek@baylibre.com>, "jm@ti.com"
 <jm@ti.com>, PHYTEC Upstream <upstream@lists.phytec.de>, "nm@ti.com"
 <nm@ti.com>, Teresa Remmet <T.Remmet@phytec.de>
References: <20240708060734.4029040-1-d.schultz@phytec.de>
 <20240708060734.4029040-2-d.schultz@phytec.de>
 <510c99dfff5e17768df3fde691d96d848e288583.camel@phytec.de>
Content-Language: en-US
From: Daniel Schultz <d.schultz@phytec.de>
In-Reply-To: <510c99dfff5e17768df3fde691d96d848e288583.camel@phytec.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplkeLIzCtJLcpLzFFi42JZI8nAo3vBujfNYEWXtEXLWg+LTx8yLT7t
 fMxqcbR/DbPFpQepFi+OzWW3ePPjLJPF1Emb2S3e7u1kt+h+p+7A5fH+Riu7x6sDq9g9zt7Z
 wejR393C6nH9zHYmj+M3tjMFsEVx2aSk5mSWpRbp2yVwZZx7vpqx4JdAxd53gQ2MfXxdjJwc
 EgImEmd/X2PsYuTiEBJYwiTRtGsBO4Rzk1Hi+a/1TCBVvAI2EmfuXGLrYuTgYBFQkeiZUw4R
 FpQ4OfMJC4gtKiAvcf/WDHYQW1jAT2LanS/MIHNEBK4xSlxrnQ42lFngCpPEx8YmJogNKxgl
 tq+ZxgbSwiwgLnHryXywbWwCWhJ3tsxlBrE5BdwlNu68yQJRYyGx+M1BdghbXqJ562ywGiEB
 BYnZ2yYzQvwjLzHt3GtmCDtU4sim1UwTGIVnIbl2FpJ1s5CMnYVk7AJGllWMQrmZydmpRZnZ
 egUZlSWpyXopqZsYQVEmwsC1g7FvjschRiYOxkOMEhzMSiK88290pwnxpiRWVqUW5ccXleak
 Fh9ilOZgURLnXd0RnCokkJ5YkpqdmlqQWgSTZeLglGpg1Hwuuuzb7p8Vy6elXlvN8+yOofnR
 r9GOi6MV9pfOMb726pXY3u654e+y9nTuObbla0q5QFN82d/2GdaJa4uM2R7URDh4VP17wt91
 TJo74FQDY/6qK/bTbD1k771K9wmbySG6JuVRfai29i5DS+sbS6OXBB95GSc8QbSV11hm2Q/f
 RU1CT3PPKbEUZyQaajEXFScCABrOyyagAgAA
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

Hi Yannic,

On 09.07.24 08:49, Yannic Moog wrote:
> Hello Daniel,
>
> On Sun, 2024-07-07 at 23:07 -0700, Daniel Schultz wrote:
>> Add a new environment routine to apply extensions. Our SOM detection
>> adds overlays via the extension framework to alter the kernel
>> device-tree according to the flashed EEPROM image.
>>
>> Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
>> ---
>>   include/env/phytec/overlays.env | 20 ++++++++++++++++++++
>>   1 file changed, 20 insertions(+)
>>
>> diff --git a/include/env/phytec/overlays.env b/include/env/phytec/overlays.env
>> index 78721cde654..50110e731bd 100644
>> --- a/include/env/phytec/overlays.env
>> +++ b/include/env/phytec/overlays.env
>> @@ -23,6 +23,16 @@ mmc_apply_overlays=
>>   			fi;
>>   		done;
>>   	fi;
>> +#ifdef CONFIG_CMD_EXTENSION
>> +mmc_apply_extensions=
>> +	setenv extension_overlay_addr ${fdtoverlay_addr_r};
>> +	setenv extension_overlay_cmd 'load mmc ${mmcdev}:${mmcpart}
>> +	  ${fdtoverlay_addr_r} ${extension_overlay_name}';
>> +	extension scan;
>> +	extension apply all;
>> +#else
>> +mmc_apply_extensions=echo "no extension command"
> Do you think it makes sense to make this fail? I would think "apply_extensions" would be
> unsuccessful if extensions are not working.

Technically, you don't need our SOM detection overlays. They just make 
the boot nicer and you don't have any probe errors or other error 
messages. So, in my opinion, it's better not apply them instead of 
stopping the entire boot.

Regards,
Daniel

>
> Yannic
>
>> +#endif
>>   net_load_bootenv=${get_cmd} ${bootenv_addr_r} ${bootenv}
>>   net_load_overlay=${get_cmd} ${fdtoverlay_addr_r} ${overlay}
>>   net_apply_overlays=
>> @@ -36,3 +46,13 @@ net_apply_overlays=
>>   			fi;
>>   		done;
>>   	fi;
>> +#ifdef CONFIG_CMD_EXTENSION
>> +net_apply_extensions=
>> +	setenv extension_overlay_addr ${fdtoverlay_addr_r};
>> +	setenv extension_overlay_cmd '${get_cmd} ${fdtoverlay_addr_r}
>> +	 ${extension_overlay_name}';
>> +	extension scan;
>> +	extension apply all;
>> +#else
>> +net_apply_extensions=echo "no extension command"
>> +#endif
