Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F03F7D3B7F4
	for <u-boot@archiver.kernel.org>; Tue,  9 Dec 2025 16:46:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56F35807B1;
	Tue,  9 Dec 2025 17:46:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ZnevJnuU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD9788352B; Tue,  9 Dec 2025 17:46:38 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A24C80050
 for <u-boot@lists.denx.de>; Tue,  9 Dec 2025 17:46:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-47775fb6cb4so50096585e9.0
 for <u-boot@lists.denx.de>; Tue, 09 Dec 2025 08:46:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765298796; x=1765903596; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EYeq9UrPQgCUEHibi8itvoF04Zn/gaAU2yyk5DZt3AU=;
 b=ZnevJnuUlLVvBAvL0q2I1miRtcO2kF2rUzVD+qURIgxPvAjCpJJijqhkf2M8VbZOjN
 sbqx5FAd7C9dCecqxlEfGzinvB4Y5XNnvHEln+J+hhx0/TM7ALEkljgD5aXhXjjvhinN
 sS+rv7sxnenAz/2U3LNi3ozpi7TpvDr4oz8NDQfLfiF3weEWrm1yaA8z+JYl7eEYWyyM
 J9Bqq4FSCAmx75O/Qrd3BSoFvBbQZyjwPnSnTPtxa66IY+ON2qJLJ5yh9gCLs87ZPkUs
 KeCXtqHEeE+bx1YA4/BmXbaR2Hx1YmzuC4pErrS/19FmN7D7w7F8Ix8qNlvqBpLFWGt1
 AmmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765298796; x=1765903596;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EYeq9UrPQgCUEHibi8itvoF04Zn/gaAU2yyk5DZt3AU=;
 b=e7AaSt2rBhJVHQwFlVvjoVKhwat9m2DB9P2IRa54UbGDpfQrodU+VfshoSsmZ743CD
 bZ5KvcBbLGl2WG9UGN8C8dj/b7LoCxyUf0YFcum6qzpiss+s371xY/Eyt3bZgPGYfK7U
 d8za8KlIt1FQy5oB0kiasV5f7VgmnUkberrDFbEGiO6Rzs7SWmJ87y6KgPK7ck1ybjOZ
 0VYH0xU9cMU00yY8StfYhrnAUJgsrK9wR14PpV1Ni/KnawGLL+sV7sFG1mPZBjhlbEME
 qur6Q21/qQW/sWLFnEsWB+W07Xs85/uy5R4BOLxpWqvCyWnmC1wQLhu864Cy7h0qXNz4
 /sCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1ZUk2W21zeCzV+szuNh5AssD3vFTY2l+BRTzFPNRmTWxlfU78yVep/V+cAtTeUHO6KjJWVmI=@lists.denx.de
X-Gm-Message-State: AOJu0YyQmUxxzxSqlQ4HlDSjGRtE5TMFJnhA8St71ohLu4ZPhC0MzSN1
 Hyun2dbrEj5VQuJfLdSuXWfIliak1u27g5SMJc4IxPBf12zs/iheVHMNTHXNpg6YyTU=
X-Gm-Gg: ASbGncsfHm9kcFCrciOdpRES4upnnvhceAYjXvOCTEZZ3t49YrJA2YW4OpFrA4DN4bD
 2EIoPtOE9Q8fj4bB5Te5aa7U3rt8ELJsLulRqbqT43oAteVqXT6oga9TA+Iifnlf1CCUQJnm2YU
 jmyu62Jj+vmn1WVPyJJxVu0UXYy82nOUYmOnvX/yR3/WL+iNM7q3Xa5ePzoIP7VG+iLBMBYiCh9
 Sgs18roi5j6VxJwTV2h7Ljr7btTKPW+JleG2REpkfyk/02E3GmMCZ3ug4qdvTWyCbBC2hWvvUnC
 eTO09SNkgdKKjME5C1XYmpCCQDquJ4Zs+CZYErHSmSV9NjZ02Eylde8TFkCq6SP/wJmETfcYmqG
 7or3PVxgr2A0n5twri1Qcd0xPEA9W+47FTgWsXT5gf3o0ePmTVk1k+qLWkcGICSRID6oH/9g7Gg
 K0IThlNVfjLICNRWD7YTfVBOQYoPTW7oaJdzYYJ9N20/N2gPxiU9p9/z3eEHA0
X-Google-Smtp-Source: AGHT+IFD3xq7sQG3tgkOQ1EYAFoDL0ktkh905dYg4vG05VSThkptg8pwHj7QfVupmyqEfm0f6b072g==
X-Received: by 2002:a05:600c:8488:b0:46e:33b2:c8da with SMTP id
 5b1f17b1804b1-47939e3d210mr111213295e9.32.1765298795749; 
 Tue, 09 Dec 2025 08:46:35 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:f7b:b001:5671:a6d7:74:fcb5?
 ([2a0a:ef40:f7b:b001:5671:a6d7:74:fcb5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47a7d70fa07sm47773145e9.11.2025.12.09.08.46.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Dec 2025 08:46:34 -0800 (PST)
Message-ID: <464466a8-193e-48de-94a8-3c78f1e8ae33@linaro.org>
Date: Tue, 9 Dec 2025 16:46:33 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] net: Move some variables to net-common files
To: Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Benjamin Hahn <B.Hahn@phytec.de>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Adriano Cordova <adrianox@gmail.com>,
 Max Merchel <Max.Merchel@ew.tq-group.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Andre Przywara <andre.przywara@arm.com>, Tim Harvey <tharvey@gateworks.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Wolfgang Wallner <wolfgang.wallner@br-automation.com>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Martyn Welch <martyn.welch@collabora.com>
References: <20251208-lwip_nfs-v1-0-1f5d31e15d00@linaro.org>
 <20251208-lwip_nfs-v1-2-1f5d31e15d00@linaro.org>
 <98449760-4266-4575-91e4-1b84fc634251@linaro.org>
Content-Language: en-GB
From: Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <98449760-4266-4575-91e4-1b84fc634251@linaro.org>
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

On 09/12/2025 15:03, Jerome Forissier wrote:
> Hi Andrew,
> 
> On 12/8/25 13:52, Andrew Goodbody wrote:
>> Make some variables available to be used by either the legacy network
>> code or LWIP by moving them into the net-common files. This also allowed
>> removing a small number of duplicated variables from the LWIP code.
>>
>> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
>> ---
>>   include/net-common.h | 21 +++++++++++++++++++--
>>   include/net-legacy.h |  9 ---------
>>   net/lwip/net-lwip.c  |  5 -----
>>   net/net-common.c     | 18 ++++++++++++++++++
>>   net/net.c            | 21 ---------------------
>>   5 files changed, 37 insertions(+), 37 deletions(-)
>>
>> diff --git a/include/net-common.h b/include/net-common.h
>> index d7a0f7dff7e50527e77419ead9a9ff30deeea545..ea43c72ab06a782c621f61811b9774c1185d88fc 100644
>> --- a/include/net-common.h
>> +++ b/include/net-common.h
>> @@ -132,13 +132,30 @@ static inline void net_set_state(enum net_loop_state state)
>>   }
>>   
>>   extern int		net_restart_wrap;	/* Tried all network devices */
>> -extern uchar               *net_rx_packets[PKTBUFSRX]; /* Receive packets */
>> +extern uchar		*net_rx_packets[PKTBUFSRX]; /* Receive packets */
>> +extern uchar		*net_rx_packet;		/* Current receive packet */
>>   extern const u8		net_bcast_ethaddr[ARP_HLEN];	/* Ethernet broadcast address */
>> -extern char	net_boot_file_name[1024];/* Boot File name */
>>   extern struct in_addr	net_ip;		/* Our    IP addr (0 = unknown) */
>>   /* Indicates whether the pxe path prefix / config file was specified in dhcp option */
>>   extern char *pxelinux_configfile;
>>   
>> +/* Our IP addr (0 = unknown) */
>> +extern struct in_addr	net_ip;
>> +/* Server IP addr (0 = unknown) */
>> +extern struct in_addr	net_server_ip;
>> +/* Our subnet mask (0=unknown) */
>> +extern struct in_addr net_netmask;
>> +/* Our gateways IP address */
>> +extern struct in_addr net_gateway;
>> +/* Boot File name */
>> +extern char	net_boot_file_name[1024];
>> +/* Indicates whether the file name was specified on the command line */
>> +extern bool	net_boot_file_name_explicit;
>> +/* The actual transferred size of the bootfile (in bytes) */
>> +extern u32	net_boot_file_size;
>> +/* Boot file size in blocks as reported by the DHCP server */
>> +extern u32	net_boot_file_expected_size_in_blocks;
>> +
>>   /**
>>    * compute_ip_checksum() - Compute IP checksum
>>    *
> 
> AFAICT the following variables are NOT used by lwIP and should
> therefore stay in net-legacy.h/net.c>: net_rx_packet, net_server_ip,
> net_netmask, net_gateway, net_boot_file_name_explicit.
> 
> Thanks,

OK, I was just trying to keep related variables together.

Andrew
