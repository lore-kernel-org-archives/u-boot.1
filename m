Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6594C2BD09
	for <u-boot@archiver.kernel.org>; Tue,  9 Jul 2024 13:47:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E702288406;
	Tue,  9 Jul 2024 15:47:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="dZ6aEcTv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D3E3885C5; Tue,  9 Jul 2024 15:47:44 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8ECCB87B4D
 for <u-boot@lists.denx.de>; Tue,  9 Jul 2024 15:47:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1720532862; x=1723124862;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jgETEgpVXogo3cO1uCJUdYATZReyM+f6pf1IYSLGzSc=;
 b=dZ6aEcTvYD08VFYsDb+e9q+16O38rwTBQdLXLdRUDKhix55NLkDO1Q1aibu6qHZn
 Bp38pBnDYraUKV6MC4lzExL9ld5VOet519DJF6qw7zZ6rwBBIQHeyF6uhXFjhnFe
 QmOevWdFVGL8U4xB5uPJNza8SH1E5ymwcrXG5K4qnkw=;
X-AuditID: ac14000a-03e52700000021bc-32-668d3f7eef65
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id F6.DA.08636.E7F3D866;
 Tue,  9 Jul 2024 15:47:42 +0200 (CEST)
Received: from [172.25.39.28] (172.25.0.11) by Berlix.phytec.de (172.25.0.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Tue, 9 Jul 2024
 15:47:40 +0200
Message-ID: <f5f4b384-1a81-4e0f-b1aa-931db73cd251@phytec.de>
Date: Tue, 9 Jul 2024 15:47:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] include: env: phytec: overlays: Add extension command
To: Daniel Schultz <d.schultz@phytec.de>, Yannic Moog <Y.Moog@phytec.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "joe.hershberger@ni.com"
 <joe.hershberger@ni.com>, "trini@konsulko.com" <trini@konsulko.com>
CC: "kamlesh@ti.com" <kamlesh@ti.com>, "d-gole@ti.com" <d-gole@ti.com>,
 Benjamin Hahn <B.Hahn@phytec.de>, "m-chawdhry@ti.com" <m-chawdhry@ti.com>,
 "mkorpershoek@baylibre.com" <mkorpershoek@baylibre.com>, "jm@ti.com"
 <jm@ti.com>, PHYTEC Upstream <upstream@lists.phytec.de>, "nm@ti.com"
 <nm@ti.com>, Teresa Remmet <T.Remmet@phytec.de>
References: <20240708060734.4029040-1-d.schultz@phytec.de>
 <20240708060734.4029040-2-d.schultz@phytec.de>
 <510c99dfff5e17768df3fde691d96d848e288583.camel@phytec.de>
 <d5790f87-e4d4-4ac8-9858-2bb199f195ef@phytec.de>
Content-Language: en-US
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <d5790f87-e4d4-4ac8-9858-2bb199f195ef@phytec.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmkeLIzCtJLcpLzFFi42JZI8nAo1tn35tmsKtf2KJlrYfFpw+ZFp92
 Pma1ONq/htni0oNUixfH5rJbvPlxlsli6qTN7BZv93ayW3S/U3fg8nh/o5Xd49WBVeweZ+/s
 YPTo725h9bh+ZjuTx/Eb25kC2KK4bFJSczLLUov07RK4MhZPO8JcsEai4uS0/AbGjSJdjJwc
 EgImEpv/fGYDsYUEljBJHDls0cXIBWTfYZTYd/kWC0iCV8BGYk3PNkYQm0VARaLz3GUmiLig
 xMmZT8BqRAXkJe7fmsEOYgsL+ElMu/OFGcQWEbjJKHFskxfIUGaBK0wSHxubmCA23GaU2Lzk
 DFgVs4C4xK0n88GmsgmoS9zZ8I21i5GDg1PAVuL6ZDWIEguJxW8OskPY8hLNW2czQ1wtL/Hi
 0nIWiG/kJaade80MYYdKHNm0mmkCo/AsJLfOQrJtFpKxs5CMXcDIsopRKDczOTu1KDNbryCj
 siQ1WS8ldRMjKMJEGLh2MPbN8TjEyMTBeIhRgoNZSYR3/o3uNCHelMTKqtSi/Pii0pzU4kOM
 0hwsSuK8qzuCU4UE0hNLUrNTUwtSi2CyTBycUg2Mi5r3OcQu2+otYlsTdPr/lvIHJ0PlC++k
 LX6+yPpaCadiLrO8flrCrGX9k2SdpsjL92cYX3Csvqc+VfvAuon//UJ/5Z/2O1bt2cEs7DL9
 unjzoqtH9MtmtmTUZNy0X6BmVJWS2X/jTsSJX4eP56y8r6stw7aMsXnJkRxdR71nk7v95hiG
 npipxFKckWioxVxUnAgA8lGotJ4CAAA=
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



Am 09.07.24 um 15:31 schrieb Daniel Schultz:
> Hi Yannic,
> 
> On 09.07.24 08:49, Yannic Moog wrote:
>> Hello Daniel,
>>
>> On Sun, 2024-07-07 at 23:07 -0700, Daniel Schultz wrote:
>>> Add a new environment routine to apply extensions. Our SOM detection
>>> adds overlays via the extension framework to alter the kernel
>>> device-tree according to the flashed EEPROM image.
>>>
>>> Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
>>> ---
>>>   include/env/phytec/overlays.env | 20 ++++++++++++++++++++
>>>   1 file changed, 20 insertions(+)
>>>
>>> diff --git a/include/env/phytec/overlays.env 
>>> b/include/env/phytec/overlays.env
>>> index 78721cde654..50110e731bd 100644
>>> --- a/include/env/phytec/overlays.env
>>> +++ b/include/env/phytec/overlays.env
>>> @@ -23,6 +23,16 @@ mmc_apply_overlays=
>>>               fi;
>>>           done;
>>>       fi;
>>> +#ifdef CONFIG_CMD_EXTENSION
>>> +mmc_apply_extensions=
>>> +    setenv extension_overlay_addr ${fdtoverlay_addr_r};
>>> +    setenv extension_overlay_cmd 'load mmc ${mmcdev}:${mmcpart}
>>> +      ${fdtoverlay_addr_r} ${extension_overlay_name}';
>>> +    extension scan;
>>> +    extension apply all;
>>> +#else
>>> +mmc_apply_extensions=echo "no extension command"
>> Do you think it makes sense to make this fail? I would think 
>> "apply_extensions" would be
>> unsuccessful if extensions are not working.
> 
> Technically, you don't need our SOM detection overlays. They just make 
> the boot nicer and you don't have any probe errors or other error 
> messages. So, in my opinion, it's better not apply them instead of 
> stopping the entire boot.

My recommendation is to embed all SoM variant related overlays into 
u-boot.img's FIT using binman.

This makes the extension command obsolete, and especially the handling 
for loading of overlays from different boot sources / storage devices.

Having them available directly in the u-boot binary resolves the issue 
of not found overlays.

We do not know how users will proceed after u-boot booted and if the 
overlays will be available to the "extension setup". Better to have 
everything in place and fixup to the best we know using our SoM data 
stored in the EEPROM.

This kind of overlays should be applied regardless of the boot device.

> 
> Regards,
> Daniel
> 
>>
>> Yannic
>>
>>> +#endif
>>>   net_load_bootenv=${get_cmd} ${bootenv_addr_r} ${bootenv}
>>>   net_load_overlay=${get_cmd} ${fdtoverlay_addr_r} ${overlay}
>>>   net_apply_overlays=
>>> @@ -36,3 +46,13 @@ net_apply_overlays=
>>>               fi;
>>>           done;
>>>       fi;
>>> +#ifdef CONFIG_CMD_EXTENSION
>>> +net_apply_extensions=
>>> +    setenv extension_overlay_addr ${fdtoverlay_addr_r};
>>> +    setenv extension_overlay_cmd '${get_cmd} ${fdtoverlay_addr_r}
>>> +     ${extension_overlay_name}';
>>> +    extension scan;
>>> +    extension apply all;
>>> +#else
>>> +net_apply_extensions=echo "no extension command"
>>> +#endif
