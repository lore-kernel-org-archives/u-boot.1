Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A00A1C982C1
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 01:11:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2A91C40689;
	Thu, 17 Sep 2026 01:11:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MVJZPdY0dQAP; Thu, 17 Sep 2026 01:11:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 5364A406A0
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789607513;
	b=cxZe85pXsNM0XPc/UYlGlLS7BuGlpeW2tlTmC6cU1ahp60tjk2/3cb59GHZthKFw+UY1
	 5q5PMlcxx/2BKi/Na8c9rUH1hBOtV7ggxk480hOb5Xv1yp/s4PVAz/FTj5v9WSxjc8jp8
	 3bEdeTknoWXXlWLDAHyIqZdjhdNwEraFMxvMgqHHkGLs/XZbT7UT30fvPLxN9zLv1qmCr
	 bZOr3OnO4PDz6F30roVDSDsW4R3bc0Lb+e6q6OFzaIj7Ki6RCt7tte5P2SstmwCrAfKTA
	 3dNxn30XjzZBo1HO5d0rsY0cQ+Q4uHSxlGsyXMJnJnhtve6SIHrwpLrS63VkiTVxWOQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789607513;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
	 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Yg2R2coqFAKrXJ9XpRaK1WusiZPCM6pjhEjKQcYQ1yo=;
	b=SJPOqbUZdoIHagY0pwIUt/nCczLKWu2x2gtRMbojvr1TSBLeFZXlZssNaZADQocmDZ4K
	 aHDyDGS2aS/igsAIse8qbosfgqzm17MWwilIsrAkjXhTsVkkoTDBdZZ1Ef9Ec4AyFktEg
	 1DLXfsFyYFAhoLQf/keOQVUd5MXmFG8jK5BRn98CJDKHLgtfX1NpMxgZ2okQX4aSVSeVy
	 rbSTwcLyfEcSsl9FsdAlqPmcFwC3hshH2Ynzw0vsDzyDC8JFpTYGrO6pcztPBZihszBQT
	 qvOnJsMGkUrEC0EKqlmmXlnyIe6yxWOSKlB8lAyVC3pT9D+3EOCUIF4yKfsGZopCL9Q==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789607513;
	bh=Yg2R2coqFAKrXJ9XpRaK1WusiZPCM6pjhEjKQcYQ1yo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ROY36nzzblzEy+LA+r9VXbqUz5mT8tFprR674GXM/FH0t2Aa9lKz+yF7WvWZlwt6A
	 ikgmjENnI4fFs56CGKtNMNToFBWK9/RvgxjN0dihjpDLJm7d6PHkPqNquuEzFJtWet
	 Gc7PzyCAxhq30IlTKGftau8stv2XRVdXVDx1CnAIeldywUyvAx+65lE12VqqbaTr1R
	 rGtSmYZo1hPflFCpphFBU5vhzoAsKf44FUAf5B1W8aj89KZV2foh5RENVyRZyANNTT
	 F8+9lc76xuaFU23jPZnYAjblugI2QlcB8n6A/11jJ5/4d2ESyOzCGf8CoYzGuiwd5m
	 eYXWYqrWDTIMw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5364A406A0;
	Thu, 17 Sep 2026 01:11:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id D96B2422
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 00:47:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D390860642
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 00:47:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jadarPHlAyGt for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 00:47:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 1C6F26062D
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::2a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789606030;
 b=YoOZLj/yio3UBLCTpjGIbndRyEIJcfMgMZeEU0d+4kbht2XvyTT3iSMZxssZx8AEf9f5
 yT+v9Teyj2VcA2xFKk/ovoCoJkVFX2cN9uctfQ3bWf694TIwjuxAlKlWzg8yYjc53zWfq
 XcDenDftRnGpPjb5KkaLAKw5QHyNkQ2i90/gbgQ/FYXveq8kPYz1nD/bzSG1lVbEQtJse
 13inycdjJVOUb4xAKNqq4Obmy1sY8liGbQpb2MrlORXFrRFzj/uOaOA98/l/njVNnw0Eu
 DH82iCrAQ7Tszu1EXds340bCQMGLNN6IU0RJhvO75l3tPs1DVz+X0aMrMKNP/v5hyoQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789606030;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer;
 bh=Yg2R2coqFAKrXJ9XpRaK1WusiZPCM6pjhEjKQcYQ1yo=;
 b=kS5LfhzQ4gJqQ6wr8g4lX1A1I/j7O1l3510QclrGloIgZlZK7g3yKHosW8c36JlZK7Mk
 c0xQ+vkIrVM0Zlh52gS2olXeDQ319RSANBHTO2cw5/8PNlEe7IBI/LapgjZwSqt+B3TZO
 y08QEZPPEPEPM7QazOdqVHnbUkC3rhdm4ILWEg8acLB8L2ldmmZeIEHvetYDvmIzq7cyE
 4gKvfDkzJVolP5cJxTiydG47aQ5yNhIW4QCheXIgp8w7rBLU0dqPH0jQcJrcZN92p/Tic
 CW6MmSIhspxQpsxtt5QtNW/+AYC+0t/Z62WXmGKNsV8i+mBGYvbYG/TCAB3p/6ZvP/g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=iRcfiiAL; 
 arc=none smtp.remote-ip="2001:4860:4864:20::2a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::2a; helo=mail-oa1-x2a.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=iRcfiiAL
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1C6F26062D
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 00:47:09 +0000 (UTC)
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-4678d3e490bso189935fac.1
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 17:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1789606028; x=1790210828;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Yg2R2coqFAKrXJ9XpRaK1WusiZPCM6pjhEjKQcYQ1yo=;
 b=iRcfiiAL8aHBVSYIy0//p1amvLb9qTnt7YecuKuRhKL32z3s2yNxiks6l6uG4EX/60
 RWgtBOjDeIC/kmPgN3yqvZEhTI6ObZ59F6aYWpeZUAVfVzxogu8X356Td5vnUJxTOIU+
 ZRaQ7XkHY9xHiStPjj272oTbSG9b0K6zdqqIk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789606028; x=1790210828;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Yg2R2coqFAKrXJ9XpRaK1WusiZPCM6pjhEjKQcYQ1yo=;
 b=K+01nwvteuXz1BFxENbgrLGcx3nUddbngPX0Pu4w7TUg5A3g2dfmjd4Wv/TgZZJgbV
 UV2kfs/F6JmxUKrysuLqAdkz2kwVjozAOqFNxVkL/Hqnj0fgBmfSxC+cqAZscRJfE2s3
 RGqA1Mj8v6PeWGEDBuVKgazQ9fmoybeEhy4qxL4gHh8/e0EKvLP4tShKhCQkvqOdKeOV
 tELiiK+VdKYw4Lp1Z8UUOmNF0W3nghYFAerQNMB0cgku8/RhDGo/1mT3T1FqFCcxJfHF
 y1Qew+xCKUtiOy5tsWkoBsngtoF44p0wku9YxVTuALl/l16AWGLDxF+xyY/LrCdHiTfu
 3/AQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzzMgt1IcdyR9gkVnk0+Lyc/Y0KOExXh6yp4jd32jih9HGBrS+9R/5TlX+Ie239KaOBWnZiHhc=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lTXSYp9MSeHkVJZ3ISwuuGbnON1BSHt7PB9Uku+MgSxlwzafHT
 H05XFHLmUAR54mA9ym6128OL2J9QSsOBzPOff+HGg/NW+eHgAoOrgRV4weOK34vD0So=
X-Gm-Gg: AYBFou2k6dzrJYSG6ZsDrlrM0g7+CGmJkzKxP7+hOdI1hHWzkZBI50nVbFTemR8E47n
 /KW5pVKP2nyblqsY5+KgT/YwiYw1pqS1d95N08GRHeM5Kbd2EjBXgJjdZWUcPHBeiqoIxfZjooU
 +dfvJ29kw9lstibjleRKLla1BuryoZL3YxCh0Jz9TVgQlgSUWUpIvQK55Wfb32jMU1BpoHvjZg1
 WtlxgnXd1yfFLmhWRzmZFjuYo/Xl8tAUuTVOijKcW+wqC4hYVdaQ11c/mLEevAM6iQzt3GtDnu5
 nH1mbZY3QNnkTVfQI0YNAfAYInEISGLA19EvBMsMlqz+UUX0qdmjmHJZp5nltJdiaPTrOSi8wy5
 OHh4JLPmxUH17myv1SdvZUlLNlCEuOX2BuaaDSm2M/qOkTCAtpLr46evhsyt4PmRgijPrv4QDj5
 y9pvLZyW2KmCoytLK//EOBC+w/15TUcb+ZeiYmVihOCNIWmGkbOwv4XgJP00vpvwXV7aP16uqY9
 oBd/DJTfJFqZuIysW9TsFpKfe4ot3TNnU6UmxNL8sGt2iOJTUwi80aq5StqvSM2deXH5ePByhnz
 2hpM7dAFlC81H2O5MxAl
X-Received: by 2002:a05:6808:14c2:b0:4ab:224d:6dd6 with SMTP id
 5614622812f47-4cb68c34cb4mr1209502b6e.15.1789606028570; 
 Wed, 16 Sep 2026 17:47:08 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-80c466a2e63sm1547432a34.15.2026.09.16.17.47.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 17:47:08 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Julien Masson <jmasson@baylibre.com>, 
 Bo-Chen Chen <rex-bc.chen@mediatek.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Yang Xiwen <forbidden405@outlook.com>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, Bin Meng <bmeng.cn@gmail.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Sjoerd Simons <sjoerd@collabora.com>, Eugen Hristev <ehristev@kernel.org>, 
 Claudiu Beznea <claudiu.beznea@microchip.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Quentin Schulz <u-boot@0leil.net>, 
 Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>, 
 Chris Morgan <macromorgan@hotmail.com>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, 
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, 
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>, 
 Dylan Hung <dylan_hung@aspeedtech.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 David Lechner <dlechner@baylibre.com>
Cc: Macpaul Lin <macpaul.lin@mediatek.com>, u-boot@lists.u-boot-project.org, 
 Stefan Roese <sr@denx.de>, Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 u-boot-qcom@groups.io
In-Reply-To: <20260903-b4-dm-addr-null-checks-v1-0-db945bd5e712@baylibre.com>
References: <20260903-b4-dm-addr-null-checks-v1-0-db945bd5e712@baylibre.com>
Subject: Re: [PATCH 00/14] tree-wide: check dev_remap_addr() for NULL
Message-Id: <178960602578.1287933.12439501348102455430.b4-ty@konsulko.com>
Date: Wed, 16 Sep 2026 18:47:05 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Mailman-Approved-At: Thu, 17 Sep 2026 01:11:52 +0000
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

On Thu, 03 Sep 2026 16:35:44 -0500, David Lechner wrote:

> We noticed a mistake in a few MediaTek drivers where we were checking
> the return value of dev_remap_addr() and friends with IS_ERR(), but it
> only ever returns NULL on failure.
> 
> Then we saw that we were not the only ones who did this. So here is a
> series to clean it all up at once.
> 
> [...]

Applied to u-boot/next, thanks!

[01/14] power: pmic: mtk-pwrap: check dev_remap_addr() for NULL
        commit: b4df0bd0d40640bb2bb6fd1e1bdd622ed674050e
[02/14] net: mt7628-eth: check dev_remap_addr_index() for NULL
        commit: 5d965c1cd00ff2d388cce0b3fe62209ba1a02fc4
[03/14] net: airoha_eth: check dev_remap_addr_name() for NULL
        commit: 4978553131f8b70fe0302893c1656d0dff41a697
[04/14] net: hifemac: check dev_remap_addr_name() for NULL
        commit: d1fc2485ad1cfed79658617f22f1e6bfb571404e
[05/14] net: hifemac_mdio: check dev_remap_addr() for NULL
        commit: 06b05d6424bfde6a1063c3bada0b7cef2cf69936
[06/14] usb: dwc3-octeon-glue: check dev_remap_addr() for NULL
        commit: eed5fc97c0693cbfb58007b5d9257480b098d7e8
[07/14] usb: dwc3-am62: check dev_remap_addr_index() for NULL
        commit: 83abf91200719ab923ce72d4cddf20e9d98726ad
[08/14] timer: mchp-pit64b: check dev_read_addr_ptr() for NULL
        commit: 535e0b95d8d99b0cd976a29a6d7f9172f51997a0
[09/14] phy: qcom: snps-femto-v2: check dev_read_addr_ptr() for NULL
        commit: 4829a386955a370011c47ff4e156655b1fae37fe
[10/14] phy: rockchip: inno-dsidphy: check dev_read_addr_ptr() for NULL
        commit: 003a91a3786bc75b4319e43ce47dcf5726a7fbb6
[11/14] pinctrl: aspeed: ast2600: check dev_read_addr_ptr() for NULL
        commit: 332091bda7c1686083d0ef9301741e72f622353f
[12/14] reset: ast2500: check dev_read_addr_ptr() for NULL
        commit: 3ed90bd8d136cb422015c19a97e4aca3cc8aba84
[13/14] reset: ast2600: check dev_read_addr_ptr() for NULL
        commit: 5fcdb017c49c689fb7d9e593d77e6033e70f2c41
[14/14] arm: aspeed: ast2600: check devfdt_get_addr_ptr() for NULL
        commit: 1d487c6ba5056b0c996ba13f35e93422a0d22029
-- 
Tom


