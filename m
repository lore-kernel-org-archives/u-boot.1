Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11CE8C43458
	for <u-boot@archiver.kernel.org>; Mon,  6 Jul 2026 06:33:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A202807C4;
	Mon,  6 Jul 2026 08:33:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="ivi06EHu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D28C807C4; Mon,  6 Jul 2026 08:33:32 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 550B080398
 for <u-boot@lists.denx.de>; Mon,  6 Jul 2026 08:33:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stefan.roese@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4gtvgr36Pxz9tQ4;
 Mon,  6 Jul 2026 08:33:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1783319608;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hq5pzdtmyjYBtgEgbT8wfMpUxz43fQ7xELbxpnIA2Lw=;
 b=ivi06EHuEtXpbKZgKkl/FPNbS9njoxjTLuCZogtqdnP53gHARkcrAg/t7QHLOsd2ATFflc
 0KJG7/Mb7qS8XT3CjGWA62vXnOpCJnYwax5hbk6lMI4SzXt95I0vQDUSzsEMBv/V3Q5lUt
 xtDLxCKTHnE6zctKOpE9kttZTW5gpj44XRCy/idjeWdl6RHJUKezvntDHfj+dsR863GAok
 mxVosVaC+lC4ueukBiIozqL4dH0OInAxifZ+ia+WB/dxY7i3A8KyGmanPNNbyvQ24TRFuQ
 iPC3FKjbXxQX8ktUSuucyx0dont1cZPgKwltTSSMvrxseijhpNG6VgszP/7aKA==
Message-ID: <723cccde-6e8e-4603-b4c0-53cd3359c367@mailbox.org>
Date: Mon, 6 Jul 2026 08:33:26 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2] arm: mvebu: Update docs for Allied Telesis x220
To: Chris Packham <judge.packham@gmail.com>, trini@konsulko.com
Cc: u-boot@lists.denx.de
References: <20260705015054.2534191-1-judge.packham@gmail.com>
Content-Language: en-US
From: Stefan Roese <stefan.roese@mailbox.org>
In-Reply-To: <20260705015054.2534191-1-judge.packham@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: ecnehandr17c9raq54kaaqh7cjmnfxsx
X-MBO-RS-ID: 36728237c3525ed00f8
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

On 7/5/26 03:50, Chris Packham wrote:
> The current documentation doesn't work as-is for extracting the DDR
> training binary from the vendor bootloader. There are some seemingly
> undocumented alignment requirements that we need to meet by padding the
> binary file. Add some instructions on how to do this with objcopy. Also
> fix a minor spelling mistake while we're here.
> 
> Signed-off-by: Chris Packham <judge.packham@gmail.com>

Reviewed-by: Stefan Roese <stefan.roese@mailbox.org>

Thanks,
Stefan

> ---
> 
> Notes:
>      Changes in v2:
>      - Remove binary file accidentally included in v1
> 
>   doc/board/alliedtelesis/x220.rst | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/doc/board/alliedtelesis/x220.rst b/doc/board/alliedtelesis/x220.rst
> index 6ca5f61ec4e1..447867ac7d8a 100644
> --- a/doc/board/alliedtelesis/x220.rst
> +++ b/doc/board/alliedtelesis/x220.rst
> @@ -18,7 +18,7 @@ markets.
>   - GS980M/52
>   - x230-52
>   
> -DDR Traning (binhdr)
> +DDR Training (binhdr)
>   --------------------
>   
>   The AlleyCat3 uses a binary blob for it's DDR training. This is launched by
> @@ -37,3 +37,5 @@ image
>   .. prompt:: bash $
>   
>      ./tools/dumpimage -T kwbimage -p 1 -o board/alliedtelesis/x220/binary.0 u-boot.kwb
> +   arm-softfloat-linux-gnueabi-objcopy -I binary -O binary --pad-to=0x12fcc \
> +      board/alliedtelesis/x220/binary.0 board/alliedtelesis/x220/binary.0

