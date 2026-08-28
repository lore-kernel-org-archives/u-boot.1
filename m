Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19C7AC61DCB
	for <u-boot@archiver.kernel.org>; Fri, 28 Aug 2026 17:53:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DC70980F7E;
	Fri, 28 Aug 2026 17:53:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0vsQS5cEGAmM; Fri, 28 Aug 2026 17:53:09 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787939589;
	bh=QHWrAQRNv7wzz6czipdmDjA/t24NfeEK4d/YtY6Exks=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uewmuLnIlxNN3WbLKnWBxN04cZusHzpRZBJHCqR1mkljQiANN6wLQudqEp+C3IrBf
	 E8yA0JN2s125M182l6YlvCZApbfYy2BV0Xfeb7Xwm154dG7d0NLyo9dRmLqxtB8mBN
	 1o1rWTK6l/JHrWv631o0CF/4UgRWm7k8J61uziijZ4yK32I8XfsZbo3oYI9KyvOtEW
	 3HcHRXDRyjFs5AZa6y1Io3ALz2LaQ87s4maIVt7gxUg0UL3KhMcgPveVF3m5XvaSMx
	 MssWikU1soPK0Bs50p53L7+u3qJbITCn3fhrkPchdZ3ntrZcvQ5ldgTriD1c5JYsW3
	 UT7rmTbABNXDA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BC6A980F3B;
	Fri, 28 Aug 2026 17:53:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 040C723E
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 17:53:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DEA2D80F6B
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 17:53:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uLc95Ab6EU8N for <u-boot@lists.u-boot-project.org>;
 Fri, 28 Aug 2026 17:53:07 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::733; helo=mail-qk1-x733.google.com;
 envelope-from=ralph.siemsen@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=msPo6iS/
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C9D2980F37
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 17:53:04 +0000 (UTC)
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-92edb12cdf2so84305085a.3
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 10:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787939583; x=1788544383;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=QHWrAQRNv7wzz6czipdmDjA/t24NfeEK4d/YtY6Exks=;
 b=msPo6iS/ysNq19nCWZYnEDq4UMLvGuREcBrVCNilGtdyK+BEYAKBOLYUAWoIgaBw6m
 5XnJPNgmNwn/Sqm/C3KtRT2tBSjvBL7hjUv6UCFdFS52y9fOdh0vpDgaBBh5zzYCOhRc
 CDLgv336JZbX5AJAE/ufTCURMaeLVTgkqISiLcB+poTq1WDNsdUjbBLkhqAb2PiriwK8
 HqFyP80GSRFVwFeXuvztC6sbSmPz8UZTFUjXX90g7gP50udDUKoKT4VpVFaokcl64aNz
 ohleu2WG9/XC4pOMZ/TcmqhgYOx1By6VCEkIbQcpABkP2C+gBlRQFWW0foY9/sanYofC
 lbyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787939583; x=1788544383;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QHWrAQRNv7wzz6czipdmDjA/t24NfeEK4d/YtY6Exks=;
 b=BONgkXAnn3W1+4h7uy0km/pUaH2qrbsQ/4H0dCxjtnSkjGosJe+cMUknKhFXYq3YkG
 GfB3Cst997Eu9mayy2M9L0fAh6jNxg44AhglKazrQYDxlrVB2MLE/5R8iLHaYuaZzHU2
 OG8c9Kyy+PqqjNMnHwoQjJvio4yKCozXhQtrtKb2Y+rxTWWjXCWqrCzE56U8zEptAKcp
 T68vBs8g3cPyIZQpp6oJKTfI1v3nlSqLMqMGorZdxOIHqabZG1HkrmdWjchk2ftRXMOE
 4QNdKrbyWQgOZk/k0yDoScntrXJYZe++0H/o/ExjEz1wuEs27iVxN4ejgnnYu8tx+eUR
 KbBA==
X-Gm-Message-State: AFuF++kq1hpgYfxXB+zF4PX6iTX7/Yq+O5ghiCmJHP1OXHyItkW4Km5D
 AYPv2O4VqP0lMNHKIu8wNVjYRMEYbHVjaVS1Y3x9BSUvZaD6w7PDtERwWjvMetOn3Tm8tX9kBX7
 fztWwr9Q=
X-Gm-Gg: AR+sD12OMuXucy5G8bX1YLgaSYezcgdQln2IyN41YY296Rjvser1hjkwV4JeNIZ1ZPB
 RcUtRyYjm6m4hoLuRNzo7t24sJ8/uEmkEYe//GwqiuB2j42WFcfP+RyAmOaAurpk/lWaxv6LNu/
 lBeKd+TE3ueSXxs32/IitRPjsQCDOCPkjSaeZO60AJ+rBYpcQNBUnv4dxSMwa0Hb+Qe9TqvQ3X4
 wA/PCOQdQ1N4UKoMIiFUChpkVBYIuqWJLAbjiW0Kbbljbh7U1QJRNd1/8kVBhYwUSAEoxG9dvcM
 qMdSjOjKYy5iIjztX3ujL9HLBH6O7t8ijXaT56srrGyt6J1jiDpj51AQ88mI3c+eRlT0zsFkt/a
 ZXWWJJg9u/iM1bqFaUnTNJSutTXPKHsItQgcSFxJ1PPJ0OxbmrDDhDgUckQ8kplMyOABPstXGfF
 gGZXIPjyf4fbwOa4DHybRK/ISsNEp4v/HmDvUdgpnyB8IQn42E4L5CnWHGVfHAoEpJteTIfSlQP
 VLjBqa9LMW2hqX3Yelb/UpI2bqRzN6Dtih3O9RfKiE=
X-Received: by 2002:a05:620a:3197:b0:937:2d64:57ae with SMTP id
 af79cd13be357-93913517ff1mr989509285a.0.1787939583072; 
 Fri, 28 Aug 2026 10:53:03 -0700 (PDT)
Received: from localhost ([66.129.139.8]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-939173a65fcsm192372785a.29.2026.08.28.10.53.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 10:53:02 -0700 (PDT)
Date: Fri, 28 Aug 2026 13:53:01 -0400
From: Ralph Siemsen <ralph.siemsen@linaro.org>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Udit Kumar <u-kumar1@ti.com>
Subject: Re: [PATCH v2 4/8] ARM: renesas: RZ/N1 QSPI controller features
Message-ID: <apHK_Q-dogLc3Mkr@maple.netwinder.org>
References: <20260814-rzn1-2026-10-v2-0-56b6acef0439@linaro.org>
 <20260814-rzn1-2026-10-v2-4-56b6acef0439@linaro.org>
 <7243d0c9-1466-4236-9d41-5d78fa1cae4f@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <7243d0c9-1466-4236-9d41-5d78fa1cae4f@mailbox.org>
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

On Sat, Aug 15, 2026 at 12:25:10AM +0200, Marek Vasut wrote:
>On 8/14/26 8:38 PM, Ralph Siemsen wrote:
>>
>>diff --git a/arch/arm/mach-renesas/Kconfig b/arch/arm/mach-renesas/Kconfig
>>index f86acc31039..4d16d541443 100644
>>--- a/arch/arm/mach-renesas/Kconfig
>>+++ b/arch/arm/mach-renesas/Kconfig
>>@@ -70,9 +70,13 @@ config RZN1
>>  	select DM
>>  	select DM_ETH
>>  	select DM_SERIAL
>>+	select DM_SPI
>>  	select PINCTRL
>>  	select PINCONF
>>  	select REGMAP
>>+	select SPI
>
>Shouldn't this be in board config ? Not all RZN1 boards likely require SPI ?

Any RZ/N1 board that makes use of the QSPI will want this. It could be 
done in the defconfig, but it is easy to miss, and not fun to debug 
(took many hours of printf() for me to find it)

>>+	select SPI_MEM
>>+	select SPI_DIRMAP
>Shouldn't this be selected by the SPI NOR driver instead ?

The same driver has other users, but they may not all want DIRMAP.

I will move these settings under TARGET_SCHNEIDER_RZN1 so they are 
specific to this board.

Ralph
