Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F5B4C44532
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 16:59:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8E76080AC5;
	Wed, 22 Jul 2026 16:59:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zWJEZtsXu6bu; Wed, 22 Jul 2026 16:59:24 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E5796809C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784739564;
	bh=SeRBCIftOQkMDhPyjeTb2UgpAMKmyGXmjB7MWPw6gyM=;
	h=To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=N23Nfiv5KJuiZKdk87ZOE8SwVnSY/ksFCxEO8PWWcwMIQ2xAlDAw3S0YraoafecG5
	 5nckjrdtX6GIIWaXTfoKA6r+rWKJZAEEvBwk288fvCq2I2UCkEqI8mlBk7DG3a7rYM
	 Wui26L6TvsO7ixavxmeZAUMQr5wLSDztO9ZrdNtyqfn/ahh3Rk2fqvgmpZRedSazuo
	 MjumSmGoNb8XdtJb1ljlS4xyCFm+t8L1k7Du5ybaYPWPzyRobnSf84exlOWgXR8C1j
	 l9c/hYSJXAA9FTgcxhlX/V3roU9eWiS0JnoKXTkc0slJt55zpJGhEu4HJ3jX6ZITob
	 VRKjbexQ1PDFw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E5796809C0;
	Wed, 22 Jul 2026 16:59:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id AC0A72E5
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 16:59:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9173B607FA
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 16:59:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jszI78dFo0Kf for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 16:59:21 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 0C9D1607F6
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0C9D1607F6
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0C9D1607F6
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 16:59:20 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id E574C846A4; Wed, 22 Jul 2026 18:59:18 +0200 (CEST)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E0C283E76
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 18:59:16 +0200 (CEST)
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-451d8064238so7572431fac.3
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 09:59:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784739555; x=1785344355;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SeRBCIftOQkMDhPyjeTb2UgpAMKmyGXmjB7MWPw6gyM=;
 b=KpVM9fe2fJoYPGhhKCFx+8ara8L7AxqwUf+OxNe89flh7LmfXcdAUL5Nz2Kx1BRBOP
 ONxcOuYzFQhC+X9SOfFBzW+31YOa/ZKZsC18xy+jLlHNDtbtqHc0LRl5Xr6bX1bHUMvH
 44p3e+n98dlkQKlyYmO/FBtL5gxCZVqrx0BT1oZu61eM4pjTQjB4a1LSXFpBx3fJy8Xw
 ZfYgFY13TTJ0ygDYGDbdZB3AJhc5nJqpBBwWhvgS5s94gilm3xIugvpkWoISk2+eNAXW
 K8rq3SbRN7KFdvp1GXViMY0XbSZ4nCqacUh9vxKfW5gyOFylLYro1WNFvvosJeXOf+CU
 So0Q==
X-Gm-Message-State: AOJu0YzEJdA3GfVMGTXsugCEEiC7qIFthHMoBDXSRMLvatn0hN0P4Q2a
 o9TwWOG695NOiGuIE1PnZWGWOMx+LsfI4pFFgy3H52Cuh7NRBFvMht2A3aIpg2TcCuI=
X-Gm-Gg: AR+sD11fJ5YzI+CkuPvgKHu4Gqfrp0j9MXVHUONiHacFit6Tx2DmHz7np00QzYFWGao
 nwOO4TKaLM2VfJyLFAhXHBwaZrFomi379oP/uYn358A9x+wJE6kyJNVNJceevNvlpmAW28QqA/k
 RzH1MlE1mUibiaMUj/7XcdGa4qfiJE5nCx+tuo2hvKUoHB468ER8pdxx5W4J++BEZmdPalJ6Xeb
 1Q0DccqloUXzOX7+ltcHmedACnaF+Wmzi1+bU0FvogSGh5vneSzckv2ylbfcx4F4y9MS6oOtOHi
 GSHVNUSzKv429JGsuar0hWKuKCjr4T2w8jDTlokUEDK1OFm6QssdYPvGJpGR2AUaNx44l6bnbX+
 u/q/pi3weLxK1R566ZRlzLL/GRrSZ+4RM8fsLNLvPKF2MS/+QRAyyIM6ByhbNRPDpZKNWbYgeJh
 yajA5Cqw==
X-Received: by 2002:a05:6870:a10d:b0:456:45cd:f164 with SMTP id
 586e51a60fabf-45690350db3mr12604847fac.28.1784739555034; 
 Wed, 22 Jul 2026 09:59:15 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:d067:7d1:556a:2be5])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-45766f16541sm2273795fac.6.2026.07.22.09.59.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 09:59:14 -0700 (PDT)
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 David Lechner <dlechner@baylibre.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20260708-mtk-mt7623-remove-dup-dt-override-v1-1-efffd4b6c12a@baylibre.com>
References: <20260708-mtk-mt7623-remove-dup-dt-override-v1-1-efffd4b6c12a@baylibre.com>
Subject: Re: [PATCH] arm: dts: mt7623: remove duplicate topckgen override
Message-Id: <178473954370.3352940.9675137811675404416.b4-ty@b4>
Date: Wed, 22 Jul 2026 11:59:03 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=334; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=Va02LfX8n5Tjxlhs+VQ4LRlGCR2/O6uFh6kMHoWvEYU=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqYPbb17fG3CAxivnppjZfaXB3AiozPlB//18MX
 UeSfhGQT1eJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCamD22xYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AKS4IAJuWFMLeUUQ/RmUBCZkNMhjR85v4av58cB8oo7v
 FJUcJEqxXou31rH2ipkz7gVJIuNs8TspgoSdwB+O+vsH7hUn2qE6/uCiC0DxnP0Ey1ufEOSJGSo
 BDtsUxt2ZNt3b0emvtBCktya2yZ94LFIV/das9nA9FEX/i73ySjdEQPpqLOvkxGsmm1W3kZnoud
 ZA4iYQae7WSlV+pY68Nse67M2aKq9RucKvycYj9TR7JKg3txnW10xAIrayouWw3clwBIo/cdJd9
 33rp1CjqX5LGuaF1UHV2J8f6SswPNghFOhV1Q5jhVAxwXdUQQaiRRqFltDBaiBe31AZmgsyVCIg
 nVqw=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1784739555; x=1785344355; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SeRBCIftOQkMDhPyjeTb2UgpAMKmyGXmjB7MWPw6gyM=;
 b=FTshfKpVWYmpgpHCqlkFobUeDZYPB9rk1X8TsUz43w6tZ24ShWM6TYZW7jJtSsO8kJ
 pwj+29rFie6Dr0aD6Y45KTEiOpTWg3T2inuDw6DLSUrpBebbSzEKBOXX2xKY6CrOPs5f
 U2XNcF2RxJIi+X+3lcLM/dUXntDsbe7MZOX2CV5+H68xE+GmvkvBoTd7wapgN5G3S4/o
 bFK7rMstOKeBnSgjlYxYsDcuusEvTYG7sBdkRCmkk4vYw9+inQByd8d9rJESnOzUj994
 Lh56bGbF/7pgOCrwqSOLzlVZfI/EAIDXuYsVmBYd0I5odjOsKdon/NG3UiFfp2e4CBvV
 ZE5A==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=FTshfKpV
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dlechner@baylibre.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 secure) header.d=baylibre.com header.i=@baylibre.com header.b="FTshfKpV"; 
 dkim-atps=neutral
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
From: David Lechner via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: David Lechner <dlechner@baylibre.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Wed, 08 Jul 2026 17:24:43 -0500, David Lechner wrote:
> arm: dts: mt7623: remove duplicate topckgen override

Applied to mediatek-for-main, thanks!

[1/1] arm: dts: mt7623: remove duplicate topckgen override
      commit: a29d3dd85b0aa603098b2f9017c495b3c81810bf

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

