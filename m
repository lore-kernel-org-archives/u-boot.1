Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E2D8C25B79
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 08:28:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3384787F95;
	Wed, 22 May 2024 10:28:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="GdRNculJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1EA6787E95; Wed, 22 May 2024 10:28:25 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3EBA687FDD
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 10:28:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1716366503; x=1718958503;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4Vrp2xFh9EYT55v0YBGO4Th9+/pRrCG53P5FWboOHtg=;
 b=GdRNculJzmPPTedalq3XESZ4wfJ0FlfnESVNVtWUZZN1JMzcn4EXt6afmIe/gpCR
 JrAb3C0Lp8bBTF6uGJWkQG6RZKq5B/nomdNiABhzpJkj4UNeLEVTqN+TL6LFewef
 kkcUReZpXis4kQ3QH8gBUN82BIWzHfmfFvKLIZstOgA=;
X-AuditID: ac14000a-03e52700000021bc-ee-664daca7b917
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id A5.41.08636.7ACAD466;
 Wed, 22 May 2024 10:28:23 +0200 (CEST)
Received: from [172.25.39.28] (172.25.0.11) by Berlix.phytec.de (172.25.0.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 22 May
 2024 10:28:22 +0200
Message-ID: <5af6fad4-244b-4b89-b201-cd04c9c1df42@phytec.de>
Date: Wed, 22 May 2024 10:28:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Upstream] [PATCH 0/6] PHYTEC SOM Detection API v3
To: Daniel Schultz <d.schultz@phytec.de>, <u-boot@lists.denx.de>,
 <upstream@lists.phytec.de>
References: <20240522061827.601699-1-d.schultz@phytec.de>
Content-Language: en-US
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <20240522061827.601699-1-d.schultz@phytec.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGLMWRmVeSWpSXmKPExsWyRpKBR3f5Gt80gxf7WC3e7u1kt+h+p+7A
 5HH2zg5Gj/7uFtYApigum5TUnMyy1CJ9uwSujNX72ArOcVR0v2pna2B8yNbFyMkhIWAisbL5
 H2MXIxeHkMASJon5eyezQzh3GSXuP5/MDFLFK2AjsfrcXbAOFgFVidvfN7BCxAUlTs58wgJi
 iwrIS9y/NYMdxBYWsJe4sHAJWK+IQJzEul2vmUBsIQFLia+v/4HVMAuIS9x6Mh8sziagLnFn
 wzewmZwCVhK3Z69nhKixkFj85iBUvbzE9rdzmCHmyEu8uLScBeIDeYlp514zQ9ihElu/bGea
 wCg0C8l5s5Csm4Vk7CwkYxcwsqxiFMrNTM5OLcrM1ivIqCxJTdZLSd3ECAprEQauHYx9czwO
 MTJxMB5ilOBgVhLhjV7pmybEm5JYWZValB9fVJqTWnyIUZqDRUmcd3VHcKqQQHpiSWp2ampB
 ahFMlomDU6qBcYt/8pYjafEPGndybNhZlm/1jqHYYMsbWS7GI+6/3/ue2bExOWmu3082l9DP
 MYX2v3bEyloo64Xte93Bn/+y9I2EP/f0QKXbEupFl90vi5fvVHsjuJRvztZ12771XgyIl46O
 0rpxJOjdLN3EE3Vmkx/oqzP8Zb/6/ljbzRi9qNrqD+v3LBbNVWIpzkg01GIuKk4EAM2Vt3lZ
 AgAA
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



Am 22.05.24 um 08:18 schrieb Daniel Schultz:
> This patch series adds support for the EEPROM v3 API.
> 
> V3 is backwards compatible to V2 and therefore, the V2 image still
> exists at the beginning. Only the API version changed from 2 to 3.
> 
> V3 is a block-based memory layout organized as singled-linked list
> with different types of blocks. This is a more flexible approach and
> allows us to extend it by more block types in the future.
> 
> The V3 data starts with a 8-byte large header which defines the
> block count (u8), V3 subversion (u8) and data payload length (u16).
> Additionally the header contains a CRC8 checksum a 3 reserved bytes.
> 
> Each block starts with a 4-byte large header which defined the
> block type (u8), the absolute address of the next block (u16) and a
> CRC8 checksum. The content itself is defined via the block type and
> we currently have 2 different types:
> 
> 1) MAC: Contains the Ethernet interface number (u8), MAC address
>          (6 x u8) and a CRC8 checksum.

For this series,

Tested-by: Wadim Egorov <w.egorov@phytec.de>
