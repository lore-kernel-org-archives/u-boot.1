Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F54EC25B75
	for <u-boot@archiver.kernel.org>; Wed, 15 May 2024 16:53:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A8B888261;
	Wed, 15 May 2024 18:53:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=armadeus.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3569188260; Wed, 15 May 2024 18:53:21 +0200 (CEST)
Received: from 5.mo561.mail-out.ovh.net (5.mo561.mail-out.ovh.net
 [87.98.178.36])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E59B488262
 for <u-boot@lists.denx.de>; Wed, 15 May 2024 18:53:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=armadeus.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=sebastien.szymanski@armadeus.com
Received: from director9.ghost.mail-out.ovh.net (unknown [10.108.2.179])
 by mo561.mail-out.ovh.net (Postfix) with ESMTP id 4VffRy2bfKz1R1P
 for <u-boot@lists.denx.de>; Wed, 15 May 2024 16:53:18 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-s86zv (unknown [10.111.182.7])
 by director9.ghost.mail-out.ovh.net (Postfix) with ESMTPS id D49A01FE80;
 Wed, 15 May 2024 16:53:17 +0000 (UTC)
Received: from armadeus.com ([37.59.142.107])
 by ghost-submission-6684bf9d7b-s86zv with ESMTPSA
 id DxqhL33oRGarshcA5OnDeQ
 (envelope-from <sebastien.szymanski@armadeus.com>);
 Wed, 15 May 2024 16:53:17 +0000
Authentication-Results: garm.ovh; auth=pass
 (GARM-107S001e5535f9d-7d59-47db-9a73-4c84d48e2240,
 03DF5091F34F52AE6C7A285C13E5116C4BD8D023)
 smtp.auth=sebastien.szymanski@armadeus.com
X-OVh-ClientIp: 92.140.169.135
Message-ID: <5b5d6fe5-d436-4ac0-b6bf-7485196a97db@armadeus.com>
Date: Wed, 15 May 2024 18:53:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [NFS] fetching kernel via nfs
To: Johannes Kirchmair - SKIDATA <Johannes.Kirchmair@skidata.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: "joe.hershberger@ni.com" <joe.hershberger@ni.com>,
 "rfried.dev@gmail.com" <rfried.dev@gmail.com>
References: <GVAP278MB045609BECD802008B0FEBD2C8CEC2@GVAP278MB0456.CHEP278.PROD.OUTLOOK.COM>
Content-Language: en-US
From: =?UTF-8?Q?S=C3=A9bastien_Szymanski?= <sebastien.szymanski@armadeus.com>
Autocrypt: addr=sebastien.szymanski@armadeus.com; keydata=
 xsBNBFNfZLEBCACv1lqSePHJNpRgcnER+3emy+Arjz84zFax3XkogjY/e3ZneihIgWrVKe5M
 ql16pX4KTkzNgMUKz4bG/XwT3kjcrXshxFLlg7KrHMl287C+W+QOUjnjVeRi/su+SPmjz8VD
 yr11h+ZkVLAWhS+uQJ93jy1NwG8M4t1kBLAVHHD5Vw4FJ+3ouaVYIp1X1Cr8bVKQw33Q1aTd
 ro0kMBb96B9vNu7ciJZ3gvlaBzUEKOgNnq9KaywuLnqrqr4HUIn5JuxZjCjJzt9kTAKcTfp2
 cJM8qpp+2FF5qtbkse9fZ6M64qozgOPr9Tk4Amf9fZEUQ6UNw14mmBZuXSzoHe75gI7TABEB
 AAHNN1PDqWJhc3RpZW4gU1pZTUFOU0tJIDxzZWJhc3RpZW4uc3p5bWFuc2tpQGFybWFkZXVz
 LmNvbT7CwJAEEwEIADoCGyMHCwkIBwMCAQYVCAIJCgsEFgIDAQIeAQIXgBYhBJwGygpYm/1C
 /GCmwbCaKeiBMmTiBQJdhIHLAAoJELCaKeiBMmTixXIH/2W3kbzRG0UF81jtRRnp0H83rjDT
 v0H+8fgFMRL/7HCJ1QPArkfRJlM2wlJkN+ChP09CCarYfUEHfRCHlTb7At6Yyrz1jziD7ZwX
 8IWHYRXnZkY5eZc5DsiUgq6JH49kt+GPzK8UVP9MTa6zkBpPCUf7LzZ4pD3FihdkT52BU3gI
 d9P49fSI0TYySlb/VKn815aOhvwEr7+Dh3mZUjSh7saofbRmVUOr7p+R3MvvGI19/IJZjeOE
 ZWliODDOt6HnBOtoGSXMcNIFF6snH52D5N5gY88njZjTwhgGGUBix1bsgf/EY0v4R5itZBXB
 B/Ze4Tm++YHaB75hZK6PQu/YRv7OwE0EU19ksQEIALo7jhXddrXBTRu5SAjelV53jyHBJTX/
 vN4nL/VbbW/saca+NJjDSxx5DBmotZbQdWIyZiSIjU/xnTREvtDrl6ZeSsKWd7ZqiuiY4fSR
 zwuQp9rd0yqRuxesrWeyJB1zCSdEvLyKASERt+nxkOA+IzJ4y1qLtvnWr+SL1AXgTMw+Tkyw
 KIDCRWHTIYas11ldGj82gOIpYeXnapeNLHfT4EQwg0NeWYHynJxAQWiX5aPlw0uSpAQSsBXQ
 FIe3fpoveMSnXK+PG2BBOzexYv7r4S70a6sF9sgTTPpfKqUaqqC+u1+bUX6alTAKhGKJywaF
 6ViqLlgY8PfwohSyAlqlTRMAEQEAAcLAdgQYAQgAIAIbDBYhBJwGygpYm/1C/GCmwbCaKeiB
 MmTiBQJdhIHSAAoJELCaKeiBMmTitU8IAK7NQM3fEwaF5XaKtepYWsVka44CD8A9e4r7NVK9
 ugirKvXirIxBSDmN/Db862NmVpITsZ6ERNSNZLm/7k55N+TexKYiFZeU7G92TEfAM6qPElvx
 DLEcrkNMq9r08YZeUloacsq31AL5fK4LW+xdvXudkdiKRMJsdTpmff3x5kIziGOHjwFP9wve
 ZgEH52gpbRsP8Whx/Z2lNX/BBRmFM8OnEXFsjjqDzYThdxTq85wGPpkgvvUGyPNRD7TpbB1C
 pajOUUkPxgj5LKt77HD1afeZNudWhgcdkbtT5PMQTT0WY6wvMEj9S1+bGPeXRGWLYB7gHQ+L
 JNoSD7Kz6Y9qnKo=
In-Reply-To: <GVAP278MB045609BECD802008B0FEBD2C8CEC2@GVAP278MB0456.CHEP278.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 16752827665915177779
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrvdegkedguddtudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomhepuforsggrshhtihgvnhcuufiihihmrghnshhkihcuoehsvggsrghsthhivghnrdhsiiihmhgrnhhskhhisegrrhhmrgguvghushdrtghomheqnecuggftrfgrthhtvghrnhepiefhgeffudetiedvheeuffelieetffevueekgffgffekffehveehvdegheejkedtnecuffhomhgrihhnpeguvghngidruggvnecukfhppeduvdejrddtrddtrddupdelvddrudegtddrudeiledrudefhedpfeejrdehledrudegvddruddtjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepshgvsggrshhtihgvnhdrshiihihmrghnshhkihesrghrmhgruggvuhhsrdgtohhmpdhnsggprhgtphhtthhopedupdhrtghpthhtohepuhdqsghoohhtsehlihhsthhsrdguvghngidruggvpdfovfetjfhoshhtpehmohehiedupdhmohguvgepshhmthhpohhuth
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

Hello,

On 5/15/24 14:40, Johannes Kirchmair - SKIDATA wrote:
> Dear u-boot people,
> 
> I encountered some problems trying to fetch the Linux kernel via nfs (v3).
> One problem was that the nfs file lookup always returned NFS3ERR_BADHANDLE.

I have fixed this. See:

https://source.denx.de/u-boot/u-boot/-/commit/d2986567b27dae764b19886bcda1d24b7c41d075

Regards,

> This is due to the following line in nfs_lookup_req() function (net/nfs.c):
> 
> 		len = (uint32_t *)p - (uint32_t *)&(data[0]);
> 		rpc_req(PROG_NFS, NFS_LOOKUP, data, len);
> 	} else {  /* NFS_V3 */
> 		*p++ = htonl(NFS_FHSIZE);	/* Dir handle length */    <=====  this line
> 		memcpy(p, dirfh, NFS_FHSIZE);
> 		p += (NFS_FHSIZE / 4);
> 		*p++ = htonl(fnamelen);
> 
> In the NFS_V3 case we add the dir file handle  size to data and then the dir file handle.
> IUC, this is not correct here because dirfh includes already the size of the handle in the first 4 bytes.
> Feel free to correct me if I am wrong.
> 
> As a result, if I remove the line "*p++ = htonl(NFS_FHSIZE);", it works fine.
> 
> Don't have an in deps understanding of nfs, so I am not sure if this is the root problem here.
> 
> Best regards Johannes

-- 
Sébastien Szymanski, Armadeus Systems
Software engineer

