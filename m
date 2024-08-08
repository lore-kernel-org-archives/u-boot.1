Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53DCDC3DA4A
	for <u-boot@archiver.kernel.org>; Thu,  8 Aug 2024 14:07:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C024A88ABD;
	Thu,  8 Aug 2024 16:07:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1723126050;
	bh=efNwa3cSPQt7O5j9opILOGKCh9jn9MOvyI/gY+P2Xgg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=AWYynSsINeQBWOU8RAAvhaFLyYcJf43ih2CECgbsmNtMP6I/NpkkHH3E/C/wqC+iB
	 MG3nBmLoSJrFU4DLnvYI0PiqkcKPiPT1w7/9JJRroSydkqqAjMHUF82M9oyfq9IIdA
	 1kQCvam2EoeVcXVbIPqKg4P6NbjUfmeQ43moApCqEpBerpNXFZMFbDMPAx0uaNemoV
	 P/h3IVPkDc56ZNnInQ3Rxc4F0K90mhE1cIQWS+2R9i4l3DKl7P+oJnYrQECPGd+sMs
	 Wr+5ZFrO39im29h+ZEBSvpc4y+ZksFgjYUg6go62mKBylwLCDnL3SmKuHjPYELAJ2+
	 cejjR2X72SjWg==
Received: from [192.168.1.107] (89-186-114-92.pool.digikabel.hu
 [89.186.114.92])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 3F901889B7;
 Thu,  8 Aug 2024 16:07:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1723126049;
 bh=efNwa3cSPQt7O5j9opILOGKCh9jn9MOvyI/gY+P2Xgg=;
 h=Date:Subject:To:Cc:References:Reply-To:From:In-Reply-To:From;
 b=wYW8bRJAa09QL2pTH+HSwtMNhUCIt/A5re/ULnPGlxaBRAa+kgwhSCoX6yi4Ffn8b
 Todto125zJk+nIF0oCOWxID3ulPFiuFzYEiUODJ1vym9ZviG/VHipovA0sl2tmy9Ei
 zbeUja7g1a1lU/8M9rx3BMC29JOXluDiC+vFH17vwIPRejupokSEMngN1KDLCN9USh
 izCpKqREv3Yte0OWgImOxkIElIjBueO6p5YuWo9PgIMAptnGLFhLlkGplC766KL2yA
 siL84tcMp+r6qLRzWowpYTr0trCbhfRrvq3HZoo0yRTUTmLC51UUE7wuntV4fezVcb
 gQzvTyMMhJx1Q==
Message-ID: <e17ddd19-6445-b038-88bb-9ff59a11b735@denx.de>
Date: Thu, 8 Aug 2024 16:06:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: Please pull u-boot-i2c
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Anatolij Gustschin <agust@denx.de>, David Virag <virag.david003@gmail.com>,
 Fedor Ross <fedor.ross@ifm.com>, Michal Simek <michal.simek@amd.com>
References: <8d333c2b-2aef-bd73-4489-f79fa6be84ed@denx.de>
 <20240808135854.GL1626301@bill-the-cat>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <20240808135854.GL1626301@bill-the-cat>
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
Reply-To: hs@denx.de
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello Tom,

On 08.08.24 15:58, Tom Rini wrote:
> On Thu, Aug 08, 2024 at 10:42:47AM +0200, Heiko Schocher wrote:
> 
>> Hello Tom,
>>
>> please pull from u-boot-i2c:
>>
>> The following changes since commit b7d5ce05b1b52136af09cf34541c6a91079a4b86:
>>
>>    Merge branch 'master' of
>> https://source.denx.de/u-boot/custodians/u-boot-sunxi (2024-08-06 09:36:46
>> -0600)
>>
>> are available in the Git repository at:
>>
>>    https://source.denx.de/u-boot/custodians/u-boot-i2c.git tags/i2cfixes-for-v2024-10-rc3
>>
>> for you to fetch changes up to 3d299c355912e05ba534574ac557ad0c9edd7d99:
>>
>>    board: vining_2000: convert to DM_I2C (2024-08-08 05:45:11 +0200)
>>
>> ----------------------------------------------------------------
>> i2c updates for v2024.10-rc3
>>
>> - i2c: samsung: Support platforms other than EXYNOS4 and EXYNOS5
>>    from David
>>
>> - imx_lpi2c: cleanups and support read transfers longer than 256 bytes
>>    from Fedor
>>
>> - pca954x: Remove pointer to GD
>>    from Michal
>>
>> - DM_I2C conversion for some remaining boards
>>    from Anatolij
> 
> First, I would like this for -next, at this point. Second:
> 
>>        board: sniper: convert to DM_I2C
> 
> As Paul noted, he has (and I've taken it for -next) done a series of
> patches to cleanup and improve the platform now, including the
> conversion.

Seems I missed that ... sorry!

So, should I drop this patch, and rebase to -next?

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
