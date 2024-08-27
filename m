Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE5E1C54736
	for <u-boot@archiver.kernel.org>; Tue, 27 Aug 2024 19:47:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4523688717;
	Tue, 27 Aug 2024 21:47:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=pritschet.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=pritschet.eu header.i=@pritschet.eu header.b="K4iOVKt9";
	dkim=permerror (0-bit key) header.d=pritschet.eu header.i=@pritschet.eu header.b="Jdo1Fwxz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB63E88A3E; Tue, 27 Aug 2024 21:47:47 +0200 (CEST)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de
 [81.169.146.219])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EBF2B88671
 for <u-boot@lists.denx.de>; Tue, 27 Aug 2024 21:47:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=pritschet.eu
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=matthias@pritschet.eu
ARC-Seal: i=1; a=rsa-sha256; t=1724788063; cv=none;
 d=strato.com; s=strato-dkim-0002;
 b=tBBg+K/HdgqRbz3k25HmV9b2ZHQnq/1L+dSghK5F/LOUmDHpzVy8ggac7VZ0S4uwWI
 9xkESx+J9szV43956tBZKR2taFSbhBEcNgDD6CAnRDx1jcY2NMx1jprQgVfNVEUc7bxA
 xayqxVIz+C3ye1FSGYpnnaHQ0w/tLjXxFLZv284sQe/uvQ7a2mD/Y6R7WrjyKzCnSSTA
 3DlkU+6+X4AJHbY0B23lbqnaPCmR8sINPyVTH0ahODg2wWHBZczB8ripaswsO76MxPtu
 Dw8y9RxAwG6hEvb7rBLOcPMEigFx07vcCCEJ9bqPaPcMKWXygh72CmW4c0MOpNVO3jFr
 qRbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1724788063;
 s=strato-dkim-0002; d=strato.com;
 h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
 From:Subject:Sender;
 bh=ygmj4zIvKvHG9wJyxczcSBeNAGps998YpMGmGqsvPYc=;
 b=TbwtOli1VUEkb4oEINxIaBwSa13mQjjaOMHol92pGYtxZh1A2J8SXEFifr24ZD+uD9
 Z/Gdx2V8AXJphJtU3IsjPMX36zN0Q4f8PPnDieLKllp/aNcvs8mTZ2aqdl4onMTSBDFQ
 BQ6zYcsOmyGM7wFNxeR6gaspFU7SEGVHCWRr/xOCq+hxFVKtj4Rr+lEFtss+iTd3cGPp
 c/plJWKm1k8u2pd8x6Jg8vIxDH+//MhnCazKby1QOkRKX4UdCkDFQYdNKNeZ+YP+luxk
 ruRuN9qceQGNQV6Mc0ouWEpgqEstOc6wIAOp4G0eHGPs0vVWrMKhhLhQAiXfa0OYEnpz
 UkHg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1724788063;
 s=strato-dkim-0002; d=pritschet.eu;
 h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
 From:Subject:Sender;
 bh=ygmj4zIvKvHG9wJyxczcSBeNAGps998YpMGmGqsvPYc=;
 b=K4iOVKt94hKG1crMhGxwpdsCZ7GoxjlbJwf2IHwvHRWYecSYB2z/sr3YWzq+glufn7
 j7/8D+1vLro9GnnG3M4fqKXo39Z+3G6/34OoQPdbC1X5yXbLrn+jpCbgIZHnaDNFi82x
 rGfMrEokb4Ei8fIKHAUUZgh1nJV6JGG6rMd4GzaXZyIpFWXiZo9OOQn2zFPZJ0XDdJZC
 KJVQbDLfgRfGLbUTOKSpkUxpuQ244IlsRmSIYIcN0jUhPPcwUZ+4qjWzlA+lU6962fi8
 DDkcR0KM+VhY/9L+Q2spci9u6pYMceswyTpOBa6iiuKnQy9NW3SlB7QHJx49Y9CKROrQ
 cKRw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1724788063;
 s=strato-dkim-0003; d=pritschet.eu;
 h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
 From:Subject:Sender;
 bh=ygmj4zIvKvHG9wJyxczcSBeNAGps998YpMGmGqsvPYc=;
 b=Jdo1Fwxzqb3uDTFszajmArsOPUsRscr+S+zCKnsqRFV2iXlgcAZmSCKbipgczG7J3J
 +rno3aoS4/hKAMX3GEAg==
X-RZG-AUTH: ":IW0QYUiheuxX18P29qqHt/qCfjagLCCd1qyzKexpcQi1jQNsuxOyhTejoQQ4wC2Bp2zYdWPg2FSP9SQ5RapwYXGg226O9jufEh9FdQ=="
Received: from [IPV6:2001:9e8:31ee:a000:76b5:2208:5ab8:6fd]
 by smtp.strato.de (RZmta 51.2.3 AUTH) with ESMTPSA id Yed7a707RJlgpex
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Tue, 27 Aug 2024 21:47:42 +0200 (CEST)
Message-ID: <af9c9733-4841-448c-98d0-3f960814f039@pritschet.eu>
Date: Tue, 27 Aug 2024 21:47:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mkimage: ecdsa: add signature/key nodes to dtb if missing
To: Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de,
 Matthias Pritschet <matthias.pritschet@itk-engineering.de>
References: <20240827160054.26819-1-matthias@pritschet.eu>
 <CALeDE9MLsyxNstkTy6SarjvtxO9_qu3=DA3NEfheSU=gehpahA@mail.gmail.com>
Content-Language: de-DE
From: Matthias Pritschet <matthias@pritschet.eu>
Autocrypt: addr=matthias@pritschet.eu; keydata=
 xjMEYAvn3xYJKwYBBAHaRw8BAQdAsOZSUAnRUPv6AGvGQ0ZAK+f4+oZ/dN4SEeovDNQUo/vN
 Kk1hdHRoaWFzIFByaXRzY2hldCA8bWF0dGhpYXNAcHJpdHNjaGV0LmV1PsKWBBMWCAA+FiEE
 00KVu/VT2UO2HZzJFnwPi9kgHfYFAmAL598CGwMFCQlmAYAFCwkIBwIGFQoJCAsCBBYCAwEC
 HgECF4AACgkQFnwPi9kgHfYC+AD9HmOmhjDzw4w3s3krqNIK27b2I0+LKa2X/bY1/K6e+5kA
 /i+F/3vj08bmDTnZsb+jgDv/Y7kAtekAurnjfg8KN08JzjgEYAvn3xIKKwYBBAGXVQEFAQEH
 QKxYz1KTA1tCZaa/oMtqDxJ7hk4/BxFEMYeWv5CYzC8aAwEIB8J+BBgWCAAmFiEE00KVu/VT
 2UO2HZzJFnwPi9kgHfYFAmAL598CGwwFCQlmAYAACgkQFnwPi9kgHfYfAgD/fqY6cuDXCHt5
 GFZJORkhFP/oKA9XUcjYtl+3M6zdiEABANfftDe3u7QXTaEyVS0Y6dG1Nwgw96mKzF/VIZot sTIB
In-Reply-To: <CALeDE9MLsyxNstkTy6SarjvtxO9_qu3=DA3NEfheSU=gehpahA@mail.gmail.com>
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

Am 27.08.24 um 20:40 schrieb Peter Robinson:
> On Tue, 27 Aug 2024 at 18:52, Matthias Pritschet <matthias@pritschet.eu> wrote:
>>
>> From: Matthias Pritschet <matthias.pritschet@itk-engineering.de>
>>
>> If the signature/key node(s) are not yet present in the U-Boot device
>> tree, ecdsa_add_verify_data simply fails if it can't find the nodes.
>> This behaviour differs from rsa_add_verify_data, wich does add the missing
>> nodes and proceeds in that case.
>>
>> This change is mainly copy&paste from rsa_add_verify_data to add the
>> same behaviour to ecdsa_add_verify_data.
> 
> Could the duplicated code be moved out into a function shared between
> the two *_add_verify_data bits of code?
> 

I don't see a reason why not.
However, I'm not too familiar with the codebase and not sure where to put it.

If you think it's worth it and give me a few pointers regarding where and how to implement it, I'll happily draft a v2.

-- 
Matthias

