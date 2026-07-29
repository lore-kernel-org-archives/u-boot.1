Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F353C54F51
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 19:35:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C512A607ED;
	Wed, 29 Jul 2026 19:35:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EvJBrUPjexsK; Wed, 29 Jul 2026 19:35:47 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C8B3A60731
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785353746;
	bh=UJADZrqPccLExo88/CNrN3WLJV/2TAIgzjiDRooKbP0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=1MorRTh/0ZYSdqHrmthOih15I6nxlhmIvL6Er0x2an7OASSynKYU2QQTbD0FN2/FV
	 gj66clI+QyU7X14HpfRsjXoQmkcf+cZjlaiOJEki9ND4vJFgasogEzxTM4aPkhjbts
	 4yBnpYP06moAJ2ROMT7CNgGp/XArLKR2WEYgzXJPvnMlZ7aNiK965PDrzBM1GcgDRK
	 /i8oNgoF3irfPGrVqpMbD8AUQTY7uqksi47bgqe4pJFHxE9WLyGLh0mcsObOtXJ9tm
	 RfBPiSqskqQarc9bpFMJg8+lWTYfPadOV4pM9UuWnXSe0/tixMHutuuSNAgDaytbnj
	 pmHCl1zD8U1jw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C8B3A60731;
	Wed, 29 Jul 2026 19:35:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id EFD9027F
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 19:35:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D679B400AF
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 19:35:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fUgy5HZ_8A5Z for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 19:35:45 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::330; helo=mail-ot1-x330.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org BE23A4009C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BE23A4009C
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BE23A4009C
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 19:35:44 +0000 (UTC)
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7ee4f241f42so52230a34.1
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 12:35:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785353743; x=1785958543;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UJADZrqPccLExo88/CNrN3WLJV/2TAIgzjiDRooKbP0=;
 b=F34SWmKasW2nk1eCEyUOqEsSU8xyQdA3rktK6jhH/s4n2EaTAz1gvb9eiMAEoJ7jkV
 AWwoRTBEa+FMJLAVi+M4goye5i/sjuoeD6p4imnwiItlIoWS2lL5CfJVUP56JrdrzPVi
 fwCaEGoY4iqq1NR9jHzN0OxbtiJ7alrAfH1+nQfVhpBWp7GIZPJ30YXZhQV5YHPXbAq4
 gqSbGI1Di+1DSfWZhDsuXM68hyeRSZPJABUK0OcQ9EiTEvUsFvF5r3ApMcInjamCcrzK
 We21aM9qq1mDNw/8LtQ6pdoxOaqIBxK8K/Bc9rH+bIwRZnOQGJlSLl7f+iY3q26/9WTc
 0+UA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqj7i1n7IgsuHTTPtRRzOGGF8J032BpJrL8r/rDKaW+XsjSLAP4s+Nzs6fAyaqM4AFmIqSEnbM=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YzTwSctoR9DGUT212bsfvjZTQN2Lwck8fNYEbr72aWdwz8+Eno5
 pudolm2lThdRPLVjD68AnXMe2VPjysjD4YsIgTgne++KApjcQWZhLeInD+KkGp480Ck=
X-Gm-Gg: AR+sD13hBOdVrCIVrFKaBgMyYSjh3J3ZcaBgrg/vVqq7LSW32bBgJgOhl60svifGAW0
 D3nokpjARUcfnYGpGiYak9+DIBp35yOWFAL9hI2da0ZvjhjyuimwcWHQii0JJTlkTvyhZP1ihqL
 XNiizOhBkSRJzlGsqlkOPoMFDvsQWtKsucTXIsCBI5V9ljSg5X0lBFofTtSefTYSDkxksZv61Xu
 /qTWCJ2XZSlmISn2erNPmjioptWEhQuur5gkRq7Eg5vdM5DXGmPs9xDEOiuyFbmFZJyaSjz8PIR
 iBDjn/C7yhGFyQ8GR7VwgcJrAf/U5ydcYaF79CktFY/Jg3rtPRMi1/EI0AC4aJvGt2yr4jeAw22
 uB3+QEILu8eDlS3vo84QZEl7+2rp/7mruCKWWbwUm9mdxR0VIysMUyp6CkxnQcS7cKcsZgA8s2Q
 lKTeLUoeZUv63up0CkyFLmr480631OgNioB+OJk3naPe5w5nVAvGAke/a4O9aPDeyTgj7xGR8gO
 4TY+IA2WmqlgAwQX0pOvMuR2yGxpmD2AJSN1Ck=
X-Received: by 2002:a05:6820:2904:b0:6a3:7d5a:1ae0 with SMTP id
 006d021491bc7-6aca9a12039mr1616200eaf.29.1785353743335; 
 Wed, 29 Jul 2026 12:35:43 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:3096:ee5f:6f57:afe1?
 ([2600:8803:e7e4:500:3096:ee5f:6f57:afe1])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-458868a118fsm3380981fac.13.2026.07.29.12.35.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jul 2026 12:35:42 -0700 (PDT)
Message-ID: <df3c4a66-76e9-48da-9ec0-7ce6e4058b03@baylibre.com>
Date: Wed, 29 Jul 2026 14:35:41 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] arm: mediatek: mt8390: build boot images with
 binman
To: Carlo Caione <ccaione@baylibre.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 u-boot@lists.u-boot-project.org
Cc: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Vitor Sato Eschholz <vsatoes@baylibre.com>,
 Julien Stephan <jstephan@baylibre.com>,
 Macpaul Lin <Macpaul.Lin@mediatek.com>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Julien Masson <jmasson@baylibre.com>, Johan Jonker <jbx6244@gmail.com>,
 Quentin Schulz <u-boot@0leil.net>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
References: <20260722-ccaione-upstream-mt8390-spl-v2-0-7aa005345711@baylibre.com>
 <20260722-ccaione-upstream-mt8390-spl-v2-3-7aa005345711@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260722-ccaione-upstream-mt8390-spl-v2-3-7aa005345711@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1785353743; x=1785958543;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UJADZrqPccLExo88/CNrN3WLJV/2TAIgzjiDRooKbP0=;
 b=hNOy5odCsXQPqgk5cPu9k842wv8HbJtNzvYaW+J6gYlkY1JYpthZ3WVzzTAZr3O9wB
 PfnprnGCn93pS3ByM5gMGy/RnGxIuRuzEvqG41ZFsyD2cvb7WSnLLEvld2Om1ZnnA69x
 27K20p40RRlaYwiBDongK8DoQxqgr2VfZom6pGZcPhneAYoRFNuCCL2iMl1Z6IYcDvp2
 /G4fzTEAEsLOUJTbfWXlghEKLlH9w1x8PC4nbOwMJy3gJXAK2XomNK6u0DJCk/eaYYhB
 BoqO1/piizJAuiMsSDGlDRO4hoj2fsv0JzQSpx0Y0hTXoOze+dcsOhYjkkhbXDv509v5
 3mFg==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=hNOy5odC
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 7/22/26 4:35 PM, Carlo Caione wrote:
> Generate the Genio 700 boot-chain images from the U-Boot build.
> 
> mtk-boot.bin wraps an external DDR loader, padded to its fixed
> 0x4b000-byte ABI, followed by a CONFIG_SPL_MAX_SIZE U-Boot SPL region
> in a MediaTek eMMC BootROM image. The external loader copies that
> complete fixed-size SPL window, so pad the region to keep every source
> byte inside the BootROM-loaded payload.
> 
> bootloaders.img is a conventional FIT containing BL31, U-Boot proper,
> OP-TEE, and the U-Boot control devicetree.
> 
> Use the standard BL31 and TEE binman inputs and obtain ddr-loader.bin
> through BINMAN_INDIRS. Disable SPL binman symbols because SPL and
> U-Boot proper live in separate storage images. SPL locates U-Boot
> through the GPT FIT partition, so there are no in-image U-Boot offsets
> to publish.
> 
> Signed-off-by: Vitor Sato Eschholz <vsatoes@baylibre.com>
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> Signed-off-by: Carlo Caione <ccaione@baylibre.com>
> ---
>  arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi | 120 ++++++++++++++++++++++++++

Similar to Julien's comment on patch 2, I would suggest to put
as much of this as possible in mt8390-genio-common-u-boot.dtsi (following
upstream naming convention) so that we don't have to repeat it
on Genio 510 or move it later.


>  arch/arm/mach-mediatek/Kconfig                |   1 +
>  configs/mt8390_genio_700_evk_defconfig        |   1 +
>  3 files changed, 122 insertions(+)
> 
