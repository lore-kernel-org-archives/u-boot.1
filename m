Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E534C624D7
	for <u-boot@archiver.kernel.org>; Wed,  2 Sep 2026 07:32:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3B07A60829;
	Wed,  2 Sep 2026 07:32:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jJbDFAVHNXLK; Wed,  2 Sep 2026 07:32:27 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788334347;
	bh=L1LpIstrLIOVJRe45VNxJrNFg6dFZUnKEIywR42moTc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eV5y56q+zMvBDP6yhctBl3SrHlehcNAxFddHugDTlMm32L64fx7coFj3WZq1i91tu
	 sDJmQgNGRwDSSzuCMeJmA1nFytQoUHQR+S9SZj3+TgBV4DC6dsNkHAqP6iCZGRyHaF
	 ENJO459WJOOTeSpTyw5mLw8CkvZgfrZbpPwNZRFVlSlEeP6eOuNEEq0lw/NhOYL3lK
	 P73ohjy8cwyw45vOWZq9ftWaLa3f23gApQfbUcLtwFs+kQpOe9woAsybKIkhNkLw04
	 Pb3v7Xel59Ts3GyZTja01+HKGiwaC+IqsRxCO4muEr/taN9217XfRBNCCHx4pxL0+N
	 RfN+LGVwWuOmA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9036360811;
	Wed,  2 Sep 2026 07:32:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id B270A230
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 07:32:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 94DB540821
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 07:32:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jFpBl-2IqZjm for <u-boot@lists.u-boot-project.org>;
 Wed,  2 Sep 2026 07:32:25 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62c; helo=mail-ej1-x62c.google.com;
 envelope-from=monstr@monstr.eu; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=monstr-eu.20251104.gappssmtp.com
 header.i=@monstr-eu.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=rbKsaqoC
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AE0F94080B
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 07:32:23 +0000 (UTC)
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-c2531f453eeso89026066b.3
 for <u-boot@lists.u-boot-project.org>; Wed, 02 Sep 2026 00:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=monstr-eu.20251104.gappssmtp.com; s=20251104; t=1788334341; x=1788939141;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=L1LpIstrLIOVJRe45VNxJrNFg6dFZUnKEIywR42moTc=;
 b=rbKsaqoCH20ntxcTNJlys5Hrp6ZwZ+Jf8iZ8Foix8fNj72zV4zdiWYgnw8vXNadf//
 a45Ab/T6nMZCMT5XOliShThZdrDX8vSK9D3+q3vIH67INplMMZrJxEG58tA5VkfOqwrF
 FKUdeB5llewOCRW6Cntx/W8H9XgdzYyOFc19oohkGY9cV8RROJBaqLZfDahWulCw9wvn
 3hcDdbC0NvnnnLbWEH2HoXmtpgpKiLAbR/t/5Qa0TIag0+9dlGxCPi9EvcPeLLKtT56Z
 wYrCgpzEoGbNWN6UC654ybiWiofGfS+0NLm5MWoWFvQLjchE0dJumn/vLivh0A7THhtP
 GIVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788334341; x=1788939141;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=L1LpIstrLIOVJRe45VNxJrNFg6dFZUnKEIywR42moTc=;
 b=KoQm7pm4j6tE9D/RNfvXA3ev1JL5ABHPZrywjM9cyeQaYTW6ixtj/Zx7PGirR78dRH
 5a57XMQJVC2pWzMHEdscRQJ0SGF6FrOwG0UYs0vvBwdF5Zie5xUiK9SzwdLx8hkpQayX
 s8miAgx7m9y4byDTuyGHlNA2sm3SkLj58yhCHDgm/9dZ/LCsKeA42bxwZIFjbAKZGbbb
 ig14r81qYiuVVYj7RlpgkjIIi4WSgmLfSaCTTGErrnNZ4z1d14Wj9pIiPcug7xFWpTSX
 3vRnERhQdluBpdwFZ1v2+hw2oJB4C3jJ+fNoeALrmCzu5O8Xo2ZYiSNIOzpzph0jnz/L
 VCgg==
X-Forwarded-Encrypted: i=1;
 AKwUvBx8R2JEwWaS9U/5AAUemyIbe0vG0ku4exIaqnAIKcFh0N7l/46jooJZDVK/gvzjlRvWtHro7Gk=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kRuNfS1VNldjuu0HJ+7S4ds+A5fmk/o0P05BuqCm7QignezMjT
 QW+opm3kMnLg/0JYtxc/97/JdAEuf8XSQVDjHk7ojm/kzQ+I4SeAcKg47WQaNxiO/ESnfwnx6Gm
 2+jlOsPm+
X-Gm-Gg: AYBFou2sQ/VMU9fCoY05Bqw5ptF8umgw+suUavPd6/LAIZRNry3tIGUR+noO9DH7NeA
 fUf5Wt1Y4dk+S1cczxdAHjBbbFtMk1TeDc4+eUCTPLc5ZDets6SShpnB7ahbqHCY9aUDapVl3ug
 ePCoIxpcY5jLBkfnru460WmBtt5HuPi5rK1CKpNOrslXfbvraJzxvIWrk8D6OsmTrXprJ8J9mWG
 VpusxlS67vXcTIu4tMCEx8claEzE0XLXap8PSGOAciWTIdL5WaEtkFzwbkYiYV0nHtoDGSNrvjN
 n9lN/lEFegkH1M+8nHXIoyXWQzN3tcIf899jknhiHJzn+cYG26HdKKmj2ppL5aDVW2E5yGAWHsW
 wH+3x05twhKdfRQ3UsTJRsFa1lV8dNTA2KA3sUDECGvfKNaOn3YOV0nAez0THLvSPqaklHCJLkB
 jTDrl60BnZ/+mxc3SLs1J/+4lzyJP5VAnal7vcuEcHjpBarDsTqr/ICqYoyZg0kQg7rLaCHxCLL
 eDq69t1oU+sLqXXjA21TlIa0cgr3CsLES5Znkrg6iuYgw==
X-Received: by 2002:a17:907:940d:b0:c16:84dc:9607 with SMTP id
 a640c23a62f3a-c25d5509043mr161929166b.19.1788334340968; 
 Wed, 02 Sep 2026 00:32:20 -0700 (PDT)
Received: from [10.0.0.13] (89-24-185-125.customers.tmcz.cz. [89.24.185.125])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c25d03fa17dsm80387666b.48.2026.09.02.00.32.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Sep 2026 00:32:20 -0700 (PDT)
Message-ID: <4c3bedcb-6d60-435d-ae5d-4bdfe65dd0a2@monstr.eu>
Date: Wed, 2 Sep 2026 09:32:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] reset: zynqmp: move reset_assert() into firmware
 driver
To: Akshay Belsare <akshay.belsare@amd.com>, u-boot@lists.u-boot-project.org, 
 michal.simek@amd.com
Cc: git@amd.com, padmarao.begari@amd.com
References: <20260820153258.261076-1-akshay.belsare@amd.com>
Content-Language: en-US
From: Michal Simek <monstr@monstr.eu>
In-Reply-To: <20260820153258.261076-1-akshay.belsare@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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



On 8/20/26 17:32, Akshay Belsare wrote:
> The ZynqMP reset assertion helper currently resides in
> drivers/reset/reset-zynqmp.c, even though the driver is built only when
> CONFIG_ZYNQMP_FIRMWARE is enabled and the implementation is entirely
> firmware-backed. This series moves zynqmp_pm_reset_assert() into
> firmware-zynqmp.c, alongside the rest of the PM firmware interfaces.
>   
> With the helper residing in the firmware driver, reset_cpu() is updated
> to invoke zynqmp_pm_reset_assert() directly rather than issuing the PM
> request itself or relying on the reset uclass. This is important for
> boot flows where reset_cpu() may be called before the reset framework is
> available.
> 
> Akshay Belsare (2):
>    reset: zynqmp: move reset assert helper into firmware driver
>    board: xilinx: zynqmp: use reset assert helper in reset_cpu()
> 
>   board/xilinx/zynqmp/zynqmp.c       | 7 +++----
>   drivers/firmware/firmware-zynqmp.c | 7 +++++++
>   drivers/reset/reset-zynqmp.c       | 7 -------
>   include/zynqmp_firmware.h          | 2 ++
>   4 files changed, 12 insertions(+), 11 deletions(-)
> 

Applied.
M

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP/Versal ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal/Versal NET SoCs
TF-A maintainer - Xilinx ZynqMP/Versal/Versal NET SoCs

