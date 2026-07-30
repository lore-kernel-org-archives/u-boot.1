Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41C2DC55164
	for <u-boot@archiver.kernel.org>; Thu, 30 Jul 2026 15:54:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E4E9F80E0E;
	Thu, 30 Jul 2026 15:54:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3kZHNAs7-P1q; Thu, 30 Jul 2026 15:54:45 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 15BFF80D06
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785426885;
	bh=jvJ33JUvxojqNWFQfXGlZ8Dvns5Er1PBFbeuFfKPOUE=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=przZkrpBzs9tzir3UF6m2fv6/YFcM0h9FDYGCX0yzqw61QtzmgfwjPE9UZ3uk8m+V
	 vGv+CKpCajEVnOZ6MCj/EYFdFjV6NC7Ylzjfs1T83didgV8LPH1XKtt2PmMy2fmud+
	 /GX4ySrOmwVDIkxzrcPcuWxNuqlXQtj8hQbmrYSOEkP5gJOICJP7gyn8CbXZuMdVLY
	 aAICCauuyh0gBoNtuQWX4YFk41k6xWx0fWs5T8O9s18zPQUqZ0QNVa6G6hBZHL3kbH
	 ZZCzFN0Dg0BnZj0MRNC6Gvpp1zj2KZtKn/kji1ZUHr8SWIds+CaSo9pztAeEWQ+4J2
	 XHzM+QwGDTd+g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 15BFF80D06;
	Thu, 30 Jul 2026 15:54:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8022C69
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 15:54:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 65A1D40BF2
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 15:54:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sT7uwMhRN_3Q for <u-boot@lists.u-boot-project.org>;
 Thu, 30 Jul 2026 15:54:41 +0000 (UTC)
X-Greylist: delayed 10162 seconds by postgrey-1.37 at util1.osuosl.org;
 Thu, 30 Jul 2026 15:54:40 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 20C6B40BB1
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 20C6B40BB1
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.25.13;
 helo=smtp-190d.mail.infomaniak.ch; envelope-from=u-boot@0leil.net;
 receiver=<UNKNOWN> 
Received: from smtp-190d.mail.infomaniak.ch (smtp-190d.mail.infomaniak.ch
 [185.125.25.13])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 20C6B40BB1
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 15:54:39 +0000 (UTC)
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch
 [10.7.10.108])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4h9v0F16C8z5PH;
 Thu, 30 Jul 2026 17:54:37 +0200 (CEST)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4h9v0D0s1fzHCw; Thu, 30 Jul 2026 17:54:36 +0200 (CEST)
Message-ID: <f79024bf-9b79-4d21-a008-f46391d903a2@0leil.net>
Date: Thu, 30 Jul 2026 17:54:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/12] rockchip: doc: change TPL phrase
To: Johan Jonker <jbx6244@gmail.com>
Cc: kever.yang@rock-chips.com, sjg@chromium.org, trini@konsulko.com,
 u-boot@lists.u-boot-project.org, eddie.cai.linux@gmail.com
References: <5aed2a27-bd7d-4b71-a6c1-0b46b41f3462@gmail.com>
 <0b776c6c-038f-4f13-b95b-0c47b4df62b9@gmail.com>
Content-Language: en-US
In-Reply-To: <0b776c6c-038f-4f13-b95b-0c47b4df62b9@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Infomaniak-Routing: alpha
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=0leil.net; s=20231125; t=1785426876;
 bh=jvJ33JUvxojqNWFQfXGlZ8Dvns5Er1PBFbeuFfKPOUE=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=hrs2asNOnSC0421SYcBoo22HZNcmV2eouP0qtNCFUUVO/xOTcKQ5yISkB4mehSBeu
 G4w8Fhfb4LmXd7J91bOn+FVfd24Y83sA7+eguxeyNQs5EZRVvE/+u98pqXXOkETd4R
 ZcKK3Kvpow8Lnz6zPb3rAxiW7dWJQZZAfVDO13u1q1iQ0DKUspFWlZRwxPZZ2CFojN
 3bGikFW1MPhPRuCL2O8xkZZy/FppKAqLEdi3cYZUx2bfab/uMpbnoGUVhIGBK/3KRv
 MXVZ1mfxvK7OcoG80qWWM8trzPlQtLlx0Fi7e1TLuqkufzTpc+1VHGYn8XHT60ZE7X
 VSvkMpt2ma3GQ==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=0leil.net
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=hrs2asNO
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
From: Quentin Schulz via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Quentin Schulz <u-boot@0leil.net>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Johan,

On 7/30/26 3:33 PM, Johan Jonker wrote:
> The TPL phrase in rockchip.rst has some spelling and logical
> problems. Rewrite and add missing structure by changing to a
> list view to better separate the 2 choices the user has to make.
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
> 
> Changed V3:
> add commas
> ---
>   doc/board/rockchip/rockchip.rst | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
> index 9351a5b8eae7..5144cbccef78 100644
> --- a/doc/board/rockchip/rockchip.rst
> +++ b/doc/board/rockchip/rockchip.rst
> @@ -219,9 +219,11 @@ For SoCs whose TF-A code is not available as open source, use BL31 binary provid
>   TPL
>   ^^^
> 
> -For some SoCs U-Boot sources lack of support to inizialize DRAM.
> -In these cases, to get a fully functional image following :ref:`PackageWithTPLandSPL`, use DDR binary provided by Rockchip rkbin repository as ROCKCHIP_TPL when building U-Boot.
> -Otherwise, follow :ref:`PackageWithRockchipMiniloader`.
> +* For SoCs with U-Boot sources to initialize DRAM, follow
> +  :ref:`PackageWithTPLandSPL`.

If I remember correctly, it is possible to have an open-source DRAM init 
in U-Boot and still decide to go for the blob.

I think the point here is rather, if CONFIG_ROCKCHIP_EXTERNAL_TPL is 
set, set ROCKCHIP_TPL environment variable to the appropriate *ddr*.bin 
file you can find in rkbin git repository, which will be the TPL stage.

If not, then TPL will be U-Boot.

> +* For SoCs without U-Boot sources to initialize DRAM use the DDR binary provided
> +  by the Rockchip rkbin repository as ROCKCHIP_TPL when building U-Boot, then follow
> +  :ref:`PackageWithRockchipMiniloader`.
> 

This is... completely unrelated? miniloader seems to be appended after 
the DDR bin blob (see create idbloader.img step), so it simply isn't 
that. I'm wondering if this isn't some U-Boot proper from Rockchip? I 
have never used the miniloader knowingly so I don't know what it's 
supposed to do unfortunately.

In any case, I think the appropriate replacement is simply to mention 
CONFIG_ROCKCHIP_EXTERNAL_TPL and ROCKCHIP_TPL.

Cheers,
Quentin
