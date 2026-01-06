Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B74A5C47BDF
	for <u-boot@archiver.kernel.org>; Tue,  6 Jan 2026 10:02:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1966083D9F;
	Tue,  6 Jan 2026 11:02:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="GH1yiC1C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74D1483F20; Tue,  6 Jan 2026 11:02:54 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3FDCD83A57
 for <u-boot@lists.denx.de>; Tue,  6 Jan 2026 11:02:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 33D7510BECA; Tue,  6 Jan 2026 11:02:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1767693771;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=KtoWMgsH8J8PJMB3uvIams7LOWx4VUn6RRXEKFw+pPg=;
 b=GH1yiC1CE36gsa5i+2f/rFVrlurieF9LmqvNd2QhhFTkHBTCAC4Nh04DrpL9fSC9znk2MV
 mfYfwPv31yw4sF/W13nrjnnfxMxrQPs3XiesNuSqWRUFFLWb0f07a6z8bdpAh3Z/fV0QWg
 g26/PbnxQRAGZHRGPLAXuSw0dpiMNStRPkZMSJwFoLAKz1GSbqt4YIx5ZtSGe3IlF8VpE6
 yRHpk97tVwmzl6vA13GfGuMGGrT5KA9pZLHDlKSP9+8Y+qNfjE6b+jG5rrmnd6eJS3R9ud
 NzyR4fbaLwJW4N5GQogV7fou6A1JyPnNp6GNGxpe5MoRMLiJmxJVeszwgXCadA==
Message-ID: <58008116-adb2-1974-db5a-09b02979ea27@nabladev.com>
Date: Tue, 6 Jan 2026 11:03:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: Fwd: New Defects reported by Coverity Scan for Das U-Boot
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Dmitrii Merkurev <dimorinny@google.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20260105235813.GB3416603@bill-the-cat>
From: Heiko Schocher <hs@nabladev.com>
In-Reply-To: <20260105235813.GB3416603@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Hello Tom,

On 06.01.26 00:58, Tom Rini wrote:
> ** CID 449815:       Memory - illegal accesses  (OVERRUN)
> /lib/sm3.c: 252           in sm3_final()
> 
> 
> _____________________________________________________________________________________________
> *** CID 449815:         Memory - illegal accesses  (OVERRUN)
> /lib/sm3.c: 252             in sm3_final()
> 246     	unsigned int partial = sctx->count % SM3_BLOCK_SIZE;
> 247     	u32 W[16];
> 248     	int i;
> 249
> 250     	sctx->buffer[partial++] = 0x80;
> 251     	if (partial > bit_offset) {
>>>>      CID 449815:         Memory - illegal accesses  (OVERRUN)
>>>>      Overrunning array of 64 bytes at byte offset 64 by dereferencing pointer "sctx->buffer + partial". [Note: The source code implementation of the function has been overridden by a builtin model.]
> 252     		memset(sctx->buffer + partial, 0, SM3_BLOCK_SIZE - partial);
> 253     		partial = 0;
> 254
> 255     		sm3_block(sctx, sctx->buffer, 1, W);
> 256     	}
> 257
> 
> ** CID 432237:       Null pointer dereferences  (NULL_RETURNS)

Good catch, as this part is completly from linux [1]
(nowaydays this code is gone at HEAD)

prepared patch, azure run started for it:

https://dev.azure.com/hs0298/hs/_build/results?buildId=197&view=results

if no problems found, I send it.

bye,
Heiko

[1] https://elixir.bootlin.com/linux/v6.14/source/include/crypto/sm3_base.h#L86
-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
