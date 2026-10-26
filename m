Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF79606A323
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 09:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=kdeS2Abj;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=AMhbB2KJ
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0DC9B405CF;
	Mon, 26 Oct 2026 09:33:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MrfPfpzy8cqD; Mon, 26 Oct 2026 09:33:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 652C7405F9
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793007184;
	b=JTDyOE6HR16TxDGCzOcZvRQv21tIIA2jp2l8ErmUt17BAYHa5gJKR55BFP944DJbfYYV
	 ZcYLZlDtVKqlD4Rlytn57SAzpmZ5EQWDmhn9ivF713kzDUdxYf2WcOSdctXZQRUezg7gK
	 dW2skRAbcg9eYN2abXry9o31gURJqCG1MgzKucecD0hWdQaeZbE7UQ6oSQODvIYCDIQac
	 gzQ6OTwrCEtM8a+zfSbXT2nBPuEW9DGr8H1qViyvVR4Hs1rkmqtWq5ci0nMjHytbiXB6B
	 r+MQnzlUCjYQOTmB4f6nMKq3JWOyuvj39rGx3wjJp5j+JSDb7Rn78XkHeA28yI6C+0A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793007184;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=kRhUeGpkRhgXnY8WoMJWqoGuCNwd+P2vhbd/C54WCeE=;
	b=lMvyOwwQ9FkvHoEa8o9rCpyZ1wA6N8B3B/jWwckpZGLyoKQwxb7xGk7Kce4rEAaBAbGA
	 zfcUBa61Urr8vzH0bwoLWL8cKpcwMlLwzkoeNyacii7ojWf/mFnz7qTDD2dqF2FEtBzGC
	 qEiDBzFRztChbadJe3W+Bb5VqSQtNHCloghFJZWk6S8TlTTSmnN1nV2AOWW4ZzzNf/EQ+
	 72qBW90Vrl+MLTXZVjZCwCUrllL5TmlhxACQlPgU4Bz9mXqs920HjWNrsMzqietRjpm6q
	 YkT0xknhexicUNLcAEC0EUNdaIXU7ByEiHoiWM6h7MJe7toTVf9XfoVYnWkFMjmH6cw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793007184;
	bh=kRhUeGpkRhgXnY8WoMJWqoGuCNwd+P2vhbd/C54WCeE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kdeS2AbjD0kv9tnANaM3XXyhSTqYezfHMJCKKqGCMVDa/qHQBPEQn84NWinO6LFlq
	 RkHGoYvra9mNlzvojPtA4+TWmTfwGG7Lu3f6hCTNIT9lZl/QGahwmPoQwCvBobLX71
	 dkX43U+/plenZEXrqtsj5EpO0s8sLVJqQ3s5KAK6n6PUSdkFIv1hhGjkZD0OnloAlc
	 Qxz4q5cLtwZK+3pVXH7HaT1xUKYBvfv66gBXQffYtE+IRsWWd0omZlcCqLwtBad2Xl
	 rgflz2VRpHFlI9FB7qZZeb0V3i9+mY2jS1g2gVDb5Le7JTCOtRVIf0HrpWB1lriibJ
	 kb3BSGPmBJ7/g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 652C7405F9;
	Mon, 26 Oct 2026 09:33:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id A5B1B235
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 09:33:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8BA034004D
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 09:33:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LdOOUYecZ-si for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 09:33:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org D462840049
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::429"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793007182;
 b=qCdu98mIn2JMoRw/7v20p6/8Oo3MynIJClDltj2DN9ba49NnFMl9OfciA82LeYt/K71e
 WYD2SgT8a08W4gdNDqdVwi/3vLLdGuEMinEgKl0AhJrNXd1H5GHziUzEH7Et3DzLrLaIU
 KqWrJ8g75wbgJwIxI4xTmh3LJ+oz7mWfhutcBE5cQIrpHYHrJenEqzAuep/FznwRBgdOX
 fgCW6lY6inuXjH6XFZMKyM+OfUVBm5fjSl63LBmv8rsnWv11DwL7GbomjpH2UpkkLBV8j
 NoyS3UTQIG0RtGRx5vKWcB6NUModHgdNWhf/FP+IN7LPc4HfER5xd9LQSY6W/KQl6wQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793007182;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To;
 bh=kRhUeGpkRhgXnY8WoMJWqoGuCNwd+P2vhbd/C54WCeE=;
 b=qQnC9a5Abjm1KBsIhpcLfUppVZqqsHKqbPEh9RasUVAQMHUJQdzxWBlQpUyESc1zMnNA
 O8XwcvnAfpijeLLqzhSmoBwm4gqwSotGOZrUDLjAenou+338rDRmMAriEDN3ABs2WQNyu
 0H1YzYn9h+xdJl7ogIh1Ur1FDnioJwH7IPgdJVwi2U945kqgJ3pxrUa4whxnj6MnOB393
 snvz0Ah22GaSxH01aSefn7Fd38qgyTzhPjAtw5s0gvo71nw9XiSJbHJXRffvOUPbswIdv
 e5DQsBsd3QMc9pdLIMwDXFXcX6giDpyu2buYPeMQN+axMDu1w1hLry/0oZhXsWJYI7w==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=AMhbB2KJ; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::429"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::429; helo=mail-wr1-x429.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=AMhbB2KJ
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D462840049
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 09:33:01 +0000 (UTC)
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-48b060ec084so1649228f8f.0
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 02:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793007179; x=1793611979;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kRhUeGpkRhgXnY8WoMJWqoGuCNwd+P2vhbd/C54WCeE=;
 b=AMhbB2KJ5skajtN6zhWn+B1yPxuobaSPAjl7k8gUHDFm9qJBxVF2jccPb/Qje0Phr8
 bFZdNxCc2gQ33EcMa/5VmYaw0/3fprc19RTEkAeHWVHV1sgmmOju/07RKNGt5IWMfJD8
 aV09GTuCQBcuqong1yzQbrCLL/COdbepwbu8oZ5ylg4UJtKk17RIrvVxFQZ5VdGXSIQm
 /2LZX5WSyRT03ULLkineoWuhCNZgX3m2dO8ckJ2Vmuskp/2pAEtK0cpLQWkC/iA/ee+x
 YJBlAb4bQhXSDbFeSvetAGZ9PSdkiyrBMcTWrJzZJ5nXoVMjqrPvV2KiaoxjobeSW8VS
 OzrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793007179; x=1793611979;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kRhUeGpkRhgXnY8WoMJWqoGuCNwd+P2vhbd/C54WCeE=;
 b=RKQ5Vax7uGTtby3/zVUiuA3hEgnPzmx1hfDt+k3UvzMFTSIt+GqS8QUKQ3oaaa3+ai
 opAqC7MQ30rxN4W8eR/ujtFnuxA9V8T5RBC7d38J22gpDf2lb0XfsSixSPmg2Hz4BKjO
 IRUjkzXlXSUsjKs/zTxYsmFtzPn+cCVStY2oMRiPVpIMME/3+APtYomLcDG850KPTO6F
 dyVNIJZnud3wTdgjy1JXqz7mBl4gZp3asMk2Tjuj2gPEm+WVXvfgfOOxL/1XEfm95Ftb
 txrs9w5I2TmITQMsr2XnkDIvgteHbIDGs5EKByC0M8IpXh1fpP1NzG6F4DC6u1/MGfeA
 +QjA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxpuQpWsfE08hkmaaUr1h4KZYCp+mmLQquKWABj96F0YH6hvXbC1EyHqgu4/yOGqM1oG6DnuKg=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKd5x3PGlwgbRjvFJjsW13M1goyouWAp4NuHf85KJh/3BmqqUHE
 +6P7NBJ3jiZKls//Vtv/sIGnFi79pEOZ3fyN1v0iMuh00gOiUZ6hbSoVIS02cwKD4p0=
X-Gm-Gg: AYBFou2KjdCi9a/6dYltXNQe7vjT8AkQyWv7D4ZBBUMOXKoWdI6mtS8P2EyhiViNhQ/
 ViQFkgJzaMNkLRiNjWWHX+j+Y2h9t4V0GrKOnmzI5+aR6IcoDs383/BjFBSqr43q2FS0qS6IHzU
 idAoMuG5mn3bkyirNvksgd+9gKjl2hDs2fnZieFnhSoJ60yglJJZgNBAu75JSTinMdLr6QvY+Ps
 XGkeJa+Kgnc4K4Q7cjxBXVWpJM6tnDzAyoJa1Z5+4oCHSA04Et/muQ0xmuN8YRnhxmchBCM5Vtp
 +DUeWctck1QS+mERvr715Y9+pltYZrgC0LGKZ2gg3bvTyrz3GqNe6W5cJxCU5D96iMuxp3U4suf
 EsjMppZY3jWWkJsGFo2ai6sck/KI5I9WzZJ1QK8sJCZW7DHZSNrkd1iRzxG54j4s68BeLWzWxvK
 t4WlaIiCrjCNkfQz4dpbAbNsaIiGr8lyb9SmMBiixEUCIr97MUIk3X0Gp1HMENKF5eXzlWwIVzz
 K7b5VezKDxRVNQGXeeutO/xod0V/a9GZaNSG750B+2WtCB0Z2MhYdLjZtXR0HukdqUOgUVjyerB
 fg9S6rr8OOwFYmvRR/oKKSIo7WEyZLVJ6Bw5SuMoLynhHXTjnlmPmU3PBNDd+Bao/FYje56Y
X-Received: by 2002:a05:6000:310e:b0:48e:4300:c6d8 with SMTP id
 ffacd0b85a97d-48e4300c7aamr11514109f8f.35.1793007179229; 
 Mon, 26 Oct 2026 02:32:59 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-95-246-144-141.retail.telecomitalia.it. [95.246.144.141])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebc3932sm16492494f8f.18.2026.10.26.02.32.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 02:32:58 -0700 (PDT)
Date: Mon, 26 Oct 2026 10:32:56 +0100
From: Carlo Caione <ccaione@baylibre.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, u-boot@lists.u-boot-project.org, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Julien Stephan <jstephan@baylibre.com>
Subject: Re: [PATCH 2/2] configs: mt8189: enable bloblist support
Message-ID: <at8bx1ToehROlrye@macbook.homenet.telecomitalia.it>
References: <20261023-mtk-mt8189-tfa-fdt-v1-0-f86616860bcb@baylibre.com>
 <20261023-mtk-mt8189-tfa-fdt-v1-2-f86616860bcb@baylibre.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261023-mtk-mt8189-tfa-fdt-v1-2-f86616860bcb@baylibre.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Oct 23, 2026 at 17:32:44 +0100, David Lechner wrote:
> Enable bloblist support so that U-Boot may pick up a Firmware Handoff
> transfer list from TF-A and apply the devicetree overlays in it.
> 
> TF-A BL2 can describe the DRAM with such an overlay: its size and the
> regions reserved for the DRAM controller, which depend on the DRAM
> fitted to the board and so cannot be described by the devicetree built
> into U-Boot. Without a transfer list, U-Boot uses its devicetree as
> before.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>

Reviewed-by: Carlo Caione <ccaione@baylibre.com>

> ---
>  configs/mt8189.config | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/configs/mt8189.config b/configs/mt8189.config
> index a60f67bd7cb..0dc3c2873f9 100644
> --- a/configs/mt8189.config
> +++ b/configs/mt8189.config
> @@ -12,6 +12,7 @@ CONFIG_SYS_LOAD_ADDR=0x4c000000
>  CONFIG_FIT=y
>  CONFIG_BOOTSTD_FULL=y
>  # CONFIG_BOARD_INIT is not set
> +CONFIG_BLOBLIST=y
>  CONFIG_CMD_CLK=y
>  CONFIG_CMD_GPIO=y
>  CONFIG_CMD_GPT=y
> 
> -- 
> 2.53.0
> 
