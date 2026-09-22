Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C52FAC982FA
	for <u-boot@archiver.kernel.org>; Tue, 22 Sep 2026 08:05:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 21294606CE;
	Tue, 22 Sep 2026 08:05:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MI8UGWpSvYfj; Tue, 22 Sep 2026 08:05:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 6FAF560652
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790064315;
	b=e4OHNz/NpsscDTg5bOf4JuML1k7VELt9dVS5fBS/oE1792sDbeYRXx+Uz7vj5cswtpTr
	 tfMkUf9nv9B7lrYino2EFs/pcchbCjyTG2SWYH81dP7AGyRSFwtOn25ZF39z52YfvkRRA
	 QUPcqyD5Td0+/DbDGsFVNVfA8aWMtjRfI7f4ccTRKVnNuM8LmLdY97pPwxTq7qZnLUs4I
	 ZHE0/ZUvyEgJ9NDf4OZFn5w/mtaCx2A5Ik71iPPlaCnSRGAE/hrAsrWnejoJxt88WS+Wy
	 2JNq6piUE551Ho8NQx6riHC9lpBDTBP8yNeoBiAKRYVd0Etf64vKFUww45YR/5zexIQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790064315;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ZUFgS3xmm2GoZjF2JlwEvJrWKQV/Pi/xPmcfmk5XqOY=;
	b=lkpshge2YF6WilYNLcq1kVXZduTL1d6XbbrZV0ykhnQgCsegz1b6nQUGcnx/66+y6WQ+
	 33jbflQbkUb8hrtH/tNYkh9xHyWlQRIMWsqDNMlAMQfOpdLAnShbt+qgqTqQCtn2YbkYe
	 3r5+VhWcj/VhXnuCN+bo7p+PFIyFOIo1AHUoGca3qJWqprnMG4T24k2zTaa2pYrsHsPEn
	 wOGdbLMTbZPcjJrA6aTMHvo+nFAAlelG72+aUiFaYF5iha5PDvru/wu0PO3+qHLsIW9eu
	 2Afs08m+JNOX1ERj5LhkgKFRihBj1V7Mkk2fpDITyG3DMmUwGMWibfyoyaq/e8AoQyw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790064315;
	bh=ZUFgS3xmm2GoZjF2JlwEvJrWKQV/Pi/xPmcfmk5XqOY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hFF9/BeYz10eklkZ7HU3YMPt2wYdSAteMcJtD6ZTLVrG+mjD+ukwbfAn2Ucy/4n+P
	 XHcu97AFXhJt6aOHrb9PRFl4WirATlPUrqJ/VAU3mJJJwmDaqIXr0USst+xdFW1cGv
	 Ei6i1i7EaKCarvFas2vS0nMl7sg+ua0EYjmzPe1JiZuMS/OAXNHGSAXH8ON3pKVLMX
	 ankwgfuH663vjaHk4bdfbg/Np3/wyYhviBRTIFg51g/9+Oj7xWPNP52NydaMsi5hNp
	 /ypugRbuui8DTuMrKptd5bMS7evNguzHvBMi1KujhajpT6NXWqxZXF2x5y2wV/DyFK
	 s4ZQu/tMGiMgQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6FAF560652;
	Tue, 22 Sep 2026 08:05:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 299E613B
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 08:05:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 189A7400AD
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 08:05:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5HGyNFP8QL2A for <u-boot@lists.u-boot-project.org>;
 Tue, 22 Sep 2026 08:05:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org EC89640061
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:30::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790064313;
 b=TGuKbprhwBw5fhuExKBZRgOMRI2zq/J+i0fP00K1TsCZyh1vYsOBhJpY/VY0rhdcaDAm
 H2jOVvN5v8tHnTu++wPy0l8vlXEtXQVk0ltAmhCmMEq4wWTGm2MwZnMp5+vK+BtdseGvz
 e/q5gnKuoH/MSqtgAlxVCSkNVxJ/u/67zHcRFbK1YXqkgXSNZx2emaignq+OlIDa6aEUR
 kZndhTDYE5GLID3ZeMdfkM76/8CN1wBmqTy7FBRxUqqwic43dFSX/layLvN9yttYcKQ/k
 5ZXArZbnOSWOs2MG/DRmEfitnFj/G1j8pzJUo1CZXI+ZKcb3V1J0LZRAO0IRyoIBguw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790064313;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=ZUFgS3xmm2GoZjF2JlwEvJrWKQV/Pi/xPmcfmk5XqOY=;
 b=n1gsMblUdUmPQXxwUyIvZkHFaEuFaUe0p8m4aIaHp2hWizGwBMfnQcqCLYan0j3DSfBz
 UXj6jf9MbaseOxo+dv/5UZGm6z/WEcFWEvPWOs+fAGe6AMf7eN0PNoArgJwhF7Hnl7GEV
 ZQH+y+zVYN3TFMdeITifrIKkfR9rYLNOU3JVBKyf8GmafZ3X1jK1gCamiy8U2RBJUb4ua
 NUmBXEIRCkagvBKUu2yW94tbjNh5sPZcy6fGksYcxrz6omf+T+kaoZe/4YhRjDJaqUS8h
 K9XCh1ig4kgY1iktfroludpbcEN2mutVifptzXVF39BR8D4RTFKOMGMlFeSg+NUIYRg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=PeWnjTQG; 
 arc=none smtp.remote-ip="2a00:1450:4864:30::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:30::10; helo=mail-wr2-x10.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=PeWnjTQG
Received: from mail-wr2-x10.google.com (mail-wr2-x10.google.com
 [IPv6:2a00:1450:4864:30::10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EC89640061
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 08:05:11 +0000 (UTC)
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-485933b2522so2589922f8f.0
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 01:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790064309; x=1790669109;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ZUFgS3xmm2GoZjF2JlwEvJrWKQV/Pi/xPmcfmk5XqOY=;
 b=PeWnjTQGdWh0D3h3NZILdaBYiLaoIntKNGb9B7kwcglWYFEwQLsjFsyq29NG8SoWvp
 rbcc4Vla74dZMfmVORm5iwc+r2ETst0OzRK7fbtbLrVJ1PXO6S107CpbEZlLBv6cXAce
 2qZvJ13vWMQhRxXfywmYOMZkuLRN1czTSX33EDml897AaZ9RYH0hQeB+OxfQ5zgzbKgg
 MX+IZgIwRptIvmXXqpXE+ruyj003skmrbMOB2bR2R7ayVcHgD7fCRdSm8JBDfVAydMNG
 pAPOC7sHTGzDCq4Y1Mec7q/MqRkdhSftDDQyq3ClOlrmc2E6q4vKIszHYsTbtGi3eRNq
 QxYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790064309; x=1790669109;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZUFgS3xmm2GoZjF2JlwEvJrWKQV/Pi/xPmcfmk5XqOY=;
 b=wXBqqrOx7A5u2Osa5jmwqWC8ivvO+2ppvUOBPY3WBfYZjjl4/5L8t+/K9zeR/LfhVE
 1jm/kfIoUFNu9rhHCLgNq1YCqPBcQ294zWfdrGOKI/ljqRYLPm+RY9qTJlF9DNSt17gg
 8XhbMTNQRrGPAxOsE1DJ6IkhxSewiYzOnqC3KV3BJg74stzNxAdOY1jyNgYJqaDwVq00
 w7DXIgjuON8L5wR2JKRD/6dIpQ6cvuwhPPqEVUTL/NNkS/xQ0E9JsWdT7kqmmSFrwQ2J
 gJNYU2cdNe9sZRNDK9heZud/kUA9IlaQDgs5KXlWiT+Qmz0GBldfGOaScRNLmjGEEwL9
 UOwQ==
X-Gm-Message-State: AFuF++n6D5M7LuH+h8TR6kj/vHFeTY0JeT3mo9iRs08J7sj61vx1jwff
 9LWwohAoL0ibJ5Cgt/tB+zluyFxOP9Or6cKzTFgm55nBHwxntaq2FXu1jgce9R5HxDrc+uZdrvL
 GezoCaGw=
X-Gm-Gg: AYBFou0uZT2Z3YR1c761YsEZ6sOCZ7PMgnTvJ4erSi2FOt2joIBcIMoKjCJl2+OsRW5
 Ygc7NhTdnn8AyhokpPcJtfeUsx4lyFBWrBWzNixb+DbuvSOEWz1q3pOxQ1mtqF/ovgFlNID9ES9
 Z3f/7stTjz2kLcXg2jabXg/O/D6DuZUgM7++Nuudt9MnzwJmLHpLWP2iHMrpipZNiSCSuXzgHKy
 hkcjqg6NFOCKYu6iMnIEx0KC87sD0uAnf4NWM+nfuD5tA6Vt1esrLNfg/nEgdKiENZ8kTEIHFIC
 Mq/FlCxpXp4xh4ADhpTiqpjZiGogWOOZrqXhevYzzBugK6TOtHOG8vTrOu3dYKiQLjhiC6LjpvN
 fRGG++6Xp2B2zKXf/85vTrCL6S+ANv75iQL/1SYaQkhOmV3Qmthp5ocsogSS7cpB7PvPrJautcG
 p8ig7dX6+5tHzsbUugU8loTwHppMH7IwGZQJkhqrUvUrfqhzt5tkUnDvgqK8JEQeuBtHSGOUujc
 /R2/BmmCtXpe04UjwoVmQ3o5dfGrA/h7tRdV1kfAb8auqBuhU2EJrQM22NnS7b9MeEZkgj2+ufm
 Z1DzJejEByo6ing=
X-Received: by 2002:a05:6000:38f:b0:487:ee4:b5e4 with SMTP id
 ffacd0b85a97d-4871e21a26bmr23681633f8f.8.1790064309236; 
 Tue, 22 Sep 2026 01:05:09 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-95-232-147-181.retail.telecomitalia.it. [95.232.147.181])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48862786dc2sm3031582f8f.25.2026.09.22.01.05.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 01:05:08 -0700 (PDT)
Date: Tue, 22 Sep 2026 10:05:07 +0200
From: Carlo Caione <ccaione@baylibre.com>
To: u-boot@lists.u-boot-project.org
Cc: Ahmad Fatoum <a.fatoum@barebox.org>, 
 David Lechner <dlechner@baylibre.com>, Julien Masson <jmasson@baylibre.com>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Johan Jonker <jbx6244@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Randolph Sapp <rs@ti.com>, Daniel Golle <daniel@makrotopia.org>,
 James Hilliard <james.hilliard1@gmail.com>, 
 Aristo Chen <aristo.chen@canonical.com>, Peng Fan <peng.fan@nxp.com>,
 Vincent Jardin <vjardin@free.fr>, Peter Robinson <pbrobinson@gmail.com>
Subject: Re: [PATCH v3 0/5] firmware-owned devicetree for EBBR / SystemReady
 DeviceTree
Message-ID: <arI2cncDYOGXucjb@macbook.homenet.telecomitalia.it>
References: <20260903-ccaione-upstream-ebbr-v3-0-016658d0b6ba@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260903-ccaione-upstream-ebbr-v3-0-016658d0b6ba@baylibre.com>
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

On Thu, Sep 03, 2026 at 15:09:47 +0100, Carlo Caione wrote:
> EBBR-style firmware owns the devicetree: the OS is booted via UEFI and
> receives the devicetree from the firmware through the EFI configuration
> table instead of shipping its own. U-Boot has the handoff mechanism
> (efi_install_fdt()), but no generic way to describe and load the
> firmware-owned source. As a result, platforms carry downstream commands
> to provide it.

Hi Simon,
before pushing v4 to address Ilias comments do you have anything for me
to fix on your side?

Thanks!

--
Carlo Caione
