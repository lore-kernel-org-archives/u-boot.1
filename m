Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B94DEC44512
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 05:20:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4923C60724;
	Wed, 22 Jul 2026 05:20:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pIFjcHB7t8Ks; Wed, 22 Jul 2026 05:20:07 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8382160611
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784697607;
	bh=4fhn1rjKntpJQttmo427KupEobiWrYIWxhlQXiMIe6U=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=asIqMqAjYYy4Oayu1KcQGTC8YkQynXG4m3qZSixgqDAZvCcMEBlt9qkUf8MKeEFK2
	 a650Jk92I5xnUx3LgZtBlNOZPmyp739jIcamJPrfth1KRW/pZwGw6JtiQAkI1pLcAP
	 s2AnlBGubZ4BXimR6CKRIMUXdm6I7c9YgiSJTnQmrzuntiwW/k5VEyu1MsjiGfm2Al
	 PP/iWrfwB7izTiGO+xAtKNbeH4mMiePEER4bjVZN8ygY/846hIBGpb7pU0c23+xRsF
	 ZddqnBGGDwJZ57rStOjMSBoFq/o4/KlOLpLxBGdqhofeCmEC6roEB4kBOUHpXI4MMt
	 shmVgKIcwFWZw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8382160611;
	Wed, 22 Jul 2026 05:20:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 39272DF0
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 05:20:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1F22760611
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 05:20:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V1IqrNxEJMkx for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 05:20:05 +0000 (UTC)
X-Greylist: delayed 518 seconds by postgrey-1.37 at util1.osuosl.org;
 Wed, 22 Jul 2026 05:20:03 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 9C8CD605F1
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9C8CD605F1
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=178.251.229.89;
 helo=mx.nabladev.com; envelope-from=hs@nabladev.com; receiver=<UNKNOWN> 
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9C8CD605F1
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 05:20:03 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id A26B611AA3C; Wed, 22 Jul 2026 07:11:08 +0200 (CEST)
Message-ID: <646829de-7030-661a-9aca-2398713dcc87@nabladev.com>
Date: Wed, 22 Jul 2026 07:10:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 1/2] edid: add default EDID_ADDR macro
Content-Language: en-US
To: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.u-boot-project.org
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 David Lechner <dlechner@baylibre.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Pavlo Yadvychuk <pyadvychuk@baylibre.com>,
 Justin Swartz <justin.swartz@risingedge.co.za>,
 Johan Jonker <jbx6244@gmail.com>
References: <20260717-mt8188-add-ddc-i2c-driver-v1-0-e89ccd173567@baylibre.com>
 <20260717-mt8188-add-ddc-i2c-driver-v1-1-e89ccd173567@baylibre.com>
In-Reply-To: <20260717-mt8188-add-ddc-i2c-driver-v1-1-e89ccd173567@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nabladev.com; s=dkim; t=1784697075;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=4fhn1rjKntpJQttmo427KupEobiWrYIWxhlQXiMIe6U=;
 b=ErRGqBLLoSVleohJU9ag7n4Ual8c2Ue3pVUwFCg3dLSrTk5moXKD+yTsH+6pmZaFYepraT
 BuCy0VYmH9vGCb5pNHNjRbTpZY+bsAR75UvcTidXarOyAGPaIyZBYOdqv13QnSlrcsh0OO
 ayfJjBygv52sHuXHaNin/Ynogjh/uE8Z8dIxFHBCwZSNYUnwaVwO9qnywj9N9XRmo8/Aeq
 CAf2/svhb7T54AiON2M//Z/LPCevQqSNJ7QuPAWROFwGzurfLihnOZS/eyeERJB2Oaa1JW
 Akod02Lr91yE26ij3e5tJxgY1I+juIIEQYzip+y9jW1ZT5oIyxMfEBGr1l4VeQ==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=ErRGqBLL
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
From: Heiko Schocher via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Heiko Schocher <hs@nabladev.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hello Julien,

(used the new u-boot ml address u-boot@lists.u-boot-project.org and
dropped the old denx one)

On 17.07.26 14:33, Julien Stephan wrote:
> EDID info is most of the time stored at address 0x50, so define a macro
> for it in the common edid.h header.
> 
> Also drop the now-duplicate definition from the Rockchip edp_rk3288.h
> header and rely on the common one.
> 
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> ---
>   arch/arm/include/asm/arch-rockchip/edp_rk3288.h | 1 -
>   include/edid.h                                  | 3 +++
>   2 files changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Heiko Schocher <hs@nabladev.com>

bye,
Heiko
-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
