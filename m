Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC085C61DC6
	for <u-boot@archiver.kernel.org>; Thu, 27 Aug 2026 12:56:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9E13960789;
	Thu, 27 Aug 2026 12:56:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Z-6uOl3RVUwb; Thu, 27 Aug 2026 12:56:39 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787835398;
	bh=yIJe1fY/Xj/94/8SoiKev4Ehig9kcytJBqw+X5rLSPo=;
	h=From:Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AcqNqEP8mtV6iU2bV8Gwu/+0chdKZ5/k9RMkzQ2H5t+oypSM7M5uFZTdbuFfz8Alp
	 oKLZPgZQXI+P5gMwiW/TmT5EFx9JfeDXhXADhnkygTlpyP7y0mdTSPgkLogCfeCuG3
	 bBoQAOsOOnvIaLp3WiWNPiG08FIbwXo28IcAe6TVh8yZwPx7sCs5foUebFNDjTHHcG
	 1eMQMCvGoEeD+MJilV68K94sGIVpJNC5/AV5cRB0w0gMrqb+bhXRphdoH+JYRH4G89
	 UPgjxvtLf47YjwPWo38qYYaw5DlCrb+tESjFVIm/ehtzAIzWMDepLF0pQlbVnFedxy
	 DmTWHx3eLD4Zw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CDFCE606CC;
	Thu, 27 Aug 2026 12:56:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5B7F02FD
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 12:56:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3F0DE606CC
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 12:56:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TJj_X2_BFx78 for <u-boot@lists.u-boot-project.org>;
 Thu, 27 Aug 2026 12:56:36 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.123;
 helo=smtp-relay-internal-1.canonical.com;
 envelope-from=heinrich.schuchardt@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=Zah4JozB
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1FC8260643
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 12:56:35 +0000 (UTC)
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id B58333F6AB
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 12:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1787835392;
 bh=yIJe1fY/Xj/94/8SoiKev4Ehig9kcytJBqw+X5rLSPo=;
 h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
 In-Reply-To:Content-Type;
 b=Zah4JozBw+EBxypmQT4m2P1KyTlb6qq98/sFAL+5g+nKXgqFSP1I/+e5+6AdxBaI3
 ESWg5Ao+16DNPf+acDBQXjVyQY11dHib75IPVx5bKlp+fVKf5NnzizXaOn1H64T7gy
 AuN8sYuERldm/wbBBKzNb8MTPjaOrD1jbeVokLGypH7ylaxc5PiIdAri7uyHBT3hsO
 mJ3xFiR294k5FxisNNy2l6A+WoMCQcXkwivlretQGKHYhuSz8RhIHJvi5fHRcPWuU2
 VuBuB9RbO2NCmTPt2D30wGhtT1/V1Yl/EqfeAXYm9wS7+wypm1GBkgypiTMdSlzHWy
 H6hFwO/oL5H2NNCrwupksZkxHCZpYhGSo3liDLKm77VJVlpNl1CLsrxWA+PPrX7j7+
 PV2ll3Ni3wFn+fgUKAfPz68XSVySwSrRLYmOT/U4gxtTxe690l+HO8UCvqqYmG16Yl
 3xVGRhF/AvnsQX0Foxsm0onS1MJ4i7xjxerIDHvEFiJzfYdnHANDB3fmy6Th6cWVBL
 BeZ6G/6UiRKr+s1dxpZiLzPDTsJCRfYWqq6SM/4oSR4VkcA3JRoawwx3dzcmDNisdD
 vkeBtljVk9bXwAgR3PM2aL8q/dhxz4n7Rxyg4AzlAq/qJktZppCo5g2Vn52YDqs+j7
 czdZhphGoiuUPhd5KUZ8Yh2A=
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4994cf6cdb9so13153395e9.3
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 05:56:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787835392; x=1788440192;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=yIJe1fY/Xj/94/8SoiKev4Ehig9kcytJBqw+X5rLSPo=;
 b=EAPVMx2mIYwaTMJWMzVTz00t6iZCcYmvDikGNNrqjYz9Ju+1QjGUjpWSdQk4FKly43
 G9SX4ZlyNsr8DVWwFx7dR7QDggY2y5BIGQrRaZObgwUX5Sdsj82sfugeIpH0eROEl6sl
 IYyVoWWHjo7cMSIg0bkzk0IAPBhEYOkR/4HfuXv1FjI1aviktucWNadPos1vaJ/HPAY2
 88SwGCgT8tCUczLMHPxDgf3E2GaohjSiIR0ITd/C+MmbAPGAZxRKBCglIMahcs75loZR
 Zi318jb8oKMkUjv89Tf1LzZh21aRP0WHCkqYCLXVGcRyk8Q6lmWS2/wVhlMFuW8yJeGp
 icEw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoMmZWzaaFQxpmTlMgBtg1avmU7s7RfQW+oDkH9KpoifHwS5k1airDg6irZYWlkAybSg2rmxXw=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++ns6wrSikf2Cq+3N1NnRWYQseqnIFpImS3mERJZEuYhyOMLVyYV
 t3eBsCZDt5pCLVIUUwC5UJc6CL75EwZ/0cC9+nXIlpMJeruu5/zT3yI94xCdz3f3WT/6BXTkgna
 gvOH1rfd7Sy2PlTbn9XAieFv2sAQ0PE81Z3/KqCZShWSULcMneUB9E0WnqY84dAjR629kfORfRq
 frOAys338AZA==
X-Gm-Gg: AR+sD10FALXax8Y88kPiRMdfzxGiBUI1fy+iFOfBB03r8XMmBJXGZ8PXjm+L6/1uWri
 shAiDa0J+W5KsILcZiSQ/TY7csqmMl19u+dlvEFP/LnHeR2ZjrkiMIut2qvDRpmDszO8WK1xJ9p
 mrUOR/tJ2oVQTcsOqi9IgEm+4kF+OoLGxu50D8CywTPEqsa6OOZdZBFZSYik0xvS1zd/EdX2DPC
 2SeilYVBQpReiRGAsDICNiO866OP8IinWtHXnjhfWJ57crAyHSai42x7jVUbJuZKXfkEGJeIUKe
 mjw6kuEIrNoLhcR0KvTFec7/mz39cTFM9dkC8cAgB1qGeHymu4NNaJ9k+sew/btSzOQOco1heWZ
 yDQcHQ4Zar4PkfNUKmjB9VYA+/qdiM30ix5RZOMBDoy3UMOmqqR45V7VL7YeBLvKNVu1OiQBcQr
 eBP5e1Q54=
X-Received: by 2002:a05:600c:81ca:b0:499:9eb8:a1d7 with SMTP id
 5b1f17b1804b1-499dc72268emr174455655e9.9.1787835392339; 
 Thu, 27 Aug 2026 05:56:32 -0700 (PDT)
X-Received: by 2002:a05:600c:81ca:b0:499:9eb8:a1d7 with SMTP id
 5b1f17b1804b1-499dc72268emr174454815e9.9.1787835391933; 
 Thu, 27 Aug 2026 05:56:31 -0700 (PDT)
Received: from ?IPV6:2a02:908:1242:30e0:d8da:da16:d52e:e57d?
 ([2a02:908:1242:30e0:d8da:da16:d52e:e57d])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b8eb6ef7bsm26361305e9.5.2026.08.27.05.56.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Aug 2026 05:56:31 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
X-Google-Original-From: Heinrich Schuchardt <xypron.debian@gmx.de>
Message-ID: <c735b050-0bef-4e75-9306-f037dcef015d@gmx.de>
Date: Thu, 27 Aug 2026 14:56:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: omap_hsmmc: Add "ti,am437-sdhci" compatible
To: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org
References: <20260827-v2026-10-next-topic-am45-ofupstream-mmc-compatibles-v1-1-24299cefb42a@baylibre.com>
Content-Language: en-US
In-Reply-To: <20260827-v2026-10-next-topic-am45-ofupstream-mmc-compatibles-v1-1-24299cefb42a@baylibre.com>
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

On 8/27/26 14:37, Markus Schneider-Pargmann (TI) wrote:
> The upstream devicetree describes the am437 mmc/sd controllers with the
> "ti,am437-sdhci" compatible. uboot's devicetree uses the omap4-hsmmc
> compatible. As the driver works fine with the hardware, add the upstream
> devicetree compatible to the driver to support the upstream devicetree.
> 
> Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
> ---
>   drivers/mmc/omap_hsmmc.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mmc/omap_hsmmc.c b/drivers/mmc/omap_hsmmc.c
> index ae7420806432..b56b6f75d70d 100644
> --- a/drivers/mmc/omap_hsmmc.c
> +++ b/drivers/mmc/omap_hsmmc.c
> @@ -2026,6 +2026,7 @@ static const struct udevice_id omap_hsmmc_ids[] = {
>   	{ .compatible = "ti,omap4-hsmmc" },
>   	{ .compatible = "ti,am33xx-hsmmc" },
>   	{ .compatible = "ti,am335-sdhci" },
> +	{ .compatible = "ti,am437-sdhci" },
>   	{ .compatible = "ti,dra7-hsmmc", .data = (ulong)&dra7_mmc_of_data },
>   	{ }
>   };

The Linux driver also treats "ti,am335-sdhci" and "ti,am437-sdhci" the 
same. LGTM

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> 
> ---
> base-commit: d3e8597e46b635ec556a057bc42f0b0859654bdf
> change-id: 20260827-v2026-10-next-topic-am45-ofupstream-mmc-compatibles-f42b5bb9af5f
> 
> Best regards,
> --
> Markus Schneider-Pargmann (TI) <msp@baylibre.com>
> 

