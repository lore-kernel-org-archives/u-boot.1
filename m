Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8D20C61DD3
	for <u-boot@archiver.kernel.org>; Fri, 28 Aug 2026 07:40:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6A16140805;
	Fri, 28 Aug 2026 07:40:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EjSo4_Uj56KV; Fri, 28 Aug 2026 07:40:51 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787902851;
	bh=YEvbAPeZMTroDoJhA62VJP2s4X4acbfZ9RsCmsa4ki4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CPrqO1iZJyOMbQXfuITraxU6talCkyvldOAz68GXVyzY8ujiqLk1j9c00GNAG55Dj
	 zBkxgtyxmeiiDfaeTyzQ6A56MqurRDxlnDqcv8ZNc9vsu1br+gbUM4EtbewwzFRluS
	 u5G3ulenEUiFVvhtLdF7GlnJTsQhQ0gPCct6/vW9jSN93sTk1wGJp4huW5rckgf/3S
	 H73kNEBAbB436CGj6MtE4KILn+Q8iit1oGHolmlIXX2J2HfHBuexVFusArGd6W1rJg
	 Pbs119YerKToaH2rfK2Y3JCERf904VK9XLU+rNUYyQrErSJn9omEiwJqHFmOkpqirY
	 GN3UrqYmog5tQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A62A9407CF;
	Fri, 28 Aug 2026 07:40:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6085A23E
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 07:40:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5255D80E83
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 07:40:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AkY0mQsHrV6f for <u-boot@lists.u-boot-project.org>;
 Fri, 28 Aug 2026 07:40:49 +0000 (UTC)
X-Greylist: delayed 825 seconds by postgrey-1.37 at util1.osuosl.org;
 Fri, 28 Aug 2026 07:40:48 UTC
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=web.de header.i=smoch@web.de header.a=rsa-sha256
 header.s=s29768273 header.b=F9qYLKUY
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.227.17.11;
 helo=mout.web.de; envelope-from=smoch@web.de; receiver=<UNKNOWN> 
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EEB1080E7A
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 07:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1787902846; x=1788507646; i=smoch@web.de;
 bh=YEvbAPeZMTroDoJhA62VJP2s4X4acbfZ9RsCmsa4ki4=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=F9qYLKUYvsBInLFCISqAkY/5Xlanj82d8izRHFORz9TrozB6PbzZmKlRAaQ+IoKH
 AmpYLKqkI4ysatQ9jnkuTlTtvOfeRykkLgEOTW7GKh3i5GsE1mPVAfSvZ+cCRql9y
 tJ6P95pWCv18HYoY35EOfcC2/2inhObO2cukjOBo9ljh+JZFdaIbFSrDHGfXlhE5C
 b2xg6zM5QFm84c3RZdoSa8VcSmfp39udIBh7DwrDV8w44h8iBkRaJa4t0CEe5udjN
 dqV3kll8sNS4NrYK2XdZc0THr4+ps5z+4+s3RoY2CdVPHv68AzAnJSY0P9TvQ803K
 IKO6PceS7j5pOcYFdw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MCGSW-1x9Adn31gA-0060S3; Fri, 28
 Aug 2026 09:26:41 +0200
Message-ID: <a6c01add-fc9a-45c5-8336-c5978355b32e@web.de>
Date: Fri, 28 Aug 2026 09:26:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 29/45] doc: board/tbs: update link to TRM
To: Quentin Schulz <foss+uboot@0leil.net>, u-boot@lists.u-boot-project.org
Cc: uboot-imx@nxp.com, trini@konsulko.com, sjg@chromium.org,
 neil.armstrong@linaro.org, marek.vasut+renesas@mailbox.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, adeep@lexina.in,
 sbabic@nabladev.com, festevam@gmail.com, alpernebiyasak@gmail.com,
 le.jin@siemens.com, jan.kiszka@siemens.com, iwamatsu@nigauri.org,
 pbrobinson@gmail.com, seanga2@gmail.com, bmeng.cn@gmail.com, lukma@denx.de,
 mkorpershoek@kernel.org, Quentin Schulz <quentin.schulz@cherry.de>
References: <20260825-linkcheck-v1-0-ee7573fe3a4a@cherry.de>
 <20260827195313.129994-8-foss+uboot@0leil.net>
Content-Language: en-US, de-DE
From: Soeren Moch <smoch@web.de>
In-Reply-To: <20260827195313.129994-8-foss+uboot@0leil.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:NACIuEIZMEe9iJ2WszF1XMlSfI40U5vucxJgJDInUfRF9Yx+P7A
 pRI5uFTWNS3+mCCusEwAs6Ds4t7hXzK62FOKtH5/98qWtt9zfxKM8fzRcLJedjlo/WLX8TI
 E6p51I6zne+Um00KKCBKonukLs3Hyu7Ox3aYKoYRgy1XXUbDE+57p871eq4vKSKOX6nJ5md
 6DScGAkj/ZMOKLtJkk3YQ==
UI-OutboundReport: notjunk:1;M01:P0:CXFdUgkE4YE=;ZsViAGEyIT8dpSPffGK/3t9YI7J
 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
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On 27.08.26 21:52, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
>
> The link to the TRM doesn't exist anymore, so let's replace it with one
> that provides the first part of the TRM where the BOOT_CFG is explained.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
Acked-by: Soeren Moch <smoch@web.de>

Thanks,
Soeren
> ---
>   doc/board/tbs/tbs2910.rst | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/doc/board/tbs/tbs2910.rst b/doc/board/tbs/tbs2910.rst
> index 9d4be61783ed..4f2838bc9bd8 100644
> --- a/doc/board/tbs/tbs2910.rst
> +++ b/doc/board/tbs/tbs2910.rst
> @@ -187,5 +187,5 @@ Links:
>   ------
>     - https://www.tbsdtv.com/download/document/tbs2910/TBS2910-Matrix-ARM-mini-PC-SCH_rev2.1.pdf
>       - The schematics for the revision 2.1 of the TBS2910 Matrix ARM miniPC.
> -  - https://cache.freescale.com/files/32bit/doc/ref_manual/IMX6DQRM.pdf - The
> +  - https://community.nxp.com/t5/i-MX-Processors-Knowledge-Base/i-MX-6DQ-Reference-Manual-IMX6DQRM-R2-Part-1/ta-p/1115983 - The
>       SoC reference manual for additional details on the BOOT_CFG registers.

