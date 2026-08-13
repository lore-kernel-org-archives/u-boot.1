Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34C9CC5B572
	for <u-boot@archiver.kernel.org>; Thu, 13 Aug 2026 08:04:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CC16360A6B;
	Thu, 13 Aug 2026 08:04:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RKJsXZVcMwBV; Thu, 13 Aug 2026 08:04:01 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BDA566085D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786608241;
	bh=mL3RARi1gOmMxZHEyVefX/1iiewzbtkIEt8H3mZig3o=;
	h=Date:Cc:To:From:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JSAbWz84a/UwdT9KtqUgupdinD9kGbqZ7RYUe2WOSY4BF8o9WboPnHaFtS27Yc53S
	 iPoCi2tn/wQu5kprKvudrPrE6nK+b9XPHHR2j/H3oCX94jfkxJmnAcxgK2bBPzKCkw
	 Bl8PqVLuLX+ChpGo+gpBJeMn5BQnXmpl0Rpo87lvw8MNqM81HMwXdgyi9T6HH6QsKH
	 gVXLBLaTQgGsZrA2jAJa7csHP/MFNv2YaTeCB/CNYuVH8+B/5q1ggWK2eG90cfy8nZ
	 xuXn11I0j1u58nI/VGXrWq5aJhbnZ6DcOmAibPkgVrn6SGGy7f6jf6KqAs4iWn/Y+Y
	 IdV9/DE4GX5Aw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BDA566085D;
	Thu, 13 Aug 2026 08:04:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2754F3A4
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 08:04:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0D70981118
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 08:04:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DcbxmxM_lHi9 for <u-boot@lists.u-boot-project.org>;
 Thu, 13 Aug 2026 08:03:59 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::334; helo=mail-wm1-x334.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 93EC281117
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 93EC281117
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 93EC281117
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 08:03:57 +0000 (UTC)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-499840a2575so997155e9.3
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 01:03:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786608236; x=1787213036;
 h=in-reply-to:references:subject:from:to:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mL3RARi1gOmMxZHEyVefX/1iiewzbtkIEt8H3mZig3o=;
 b=dQfDVMGGOre7UHVzhwEtio36IhYEXUJxkpFD7UaU3ACzDILvpbN70iEhuGGsfNCHlY
 qSYug2IUzYr67XCedGaD3H4Hy02Ck3JKkgEfEMhLBRs++1Rq3TgICPpTUqKgvW+CJj08
 YvGMnyhndn8XeYG2LBOCrQASJnXukv99q7iGbLphXIrWAf+2KeoT9+JdExnCXNFcDSyc
 qpWkd1rtGsR2xouaydfPyYJd9QM9n6lr7UfhVtyn0NMP6V6DU1pVG221fSXXt8Fc63ps
 XogGNfnzCXyDJ1ZLVGepT14XBtO/lRoY24qIpFPv765rEXMwhLiB1PEeipG0jTX9zPO+
 iLqQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpOITqEoT/Jxh/xTohpqYmqGDFj39nt64tIfExaWyXAtdHQCPp/EsJ9D4aL+of2MRoX7nRGqnI=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YxeIOL7VuvUJMIVps3BNzCrp3RefxV/dPvFJliHHxqX0cw3ppOg
 ETPJifyx3JuWlP9iZ3g0mz3O6zEQb+QYy2KCl6aysryP0oybEimGQRklFq7Acjr0eI4=
X-Gm-Gg: AR+sD13ZgHnOSyAzYAaFBZC1UzqtbGVCUCVYteD6OzY1UJiDZ1d+RnRcrtKiMJ8jN0s
 nS2CiTXrQDTQki5i6DBlfBh+p2LLcS1INf1cGQVIelCJ07qvy7RbZQW/3JiAp3cFxAqYoIVBWHe
 +sQoCqDOg/9hy9exbG6qHCYb7T10xeOomTORCuA7l/dp9U7wQeyIh2OcYIIuj0UbEpt9PVcvsLG
 R+QUsAxjkseVtjeMRT1RIBH3xBr+HKdkHqTAgsBm4XfjMqtcRVaz+FgFUxicCe5qMhq15IIAFgu
 QZYQNFig+E5hUxt/o/o+6ZNk7dHjpnvE7uR+n8+l53IByuvPu/7XicEeoGz6grQ/Ei3h+4iJMrx
 hYdjbGcK8psFG/wkItzHdb/pltYoIHzgXSkLO0FVI1zQfAJkKsu3lPN//YO+1uHTbvhzNNh7DaO
 +j/UdTo1/cBMqiZxjQYaOWQHrYAi0402GnfOw3G1Ee4jF8BxsJMH07dAQaKn81cjaAuePsDjU0C
 kClRL507Zqhlq87gBhBF0S1EiGFHgAvYJymBw==
X-Received: by 2002:a05:600c:a59d:b0:499:80d0:8b73 with SMTP id
 5b1f17b1804b1-4998215a941mr27774775e9.4.1786608236034; 
 Thu, 13 Aug 2026 01:03:56 -0700 (PDT)
Received: from localhost (static-226232.rol.raiffeisen.net. [195.254.226.232])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49981b631c1sm99163585e9.14.2026.08.13.01.03.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Aug 2026 01:03:55 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 13 Aug 2026 10:03:52 +0200
Message-Id: <DKNNRFJVCQS8.2U03AIS9SPIUL@baylibre.com>
Cc: "Julien Masson" <jmasson@baylibre.com>, "Quentin Schulz"
 <u-boot@0leil.net>, "Marek Vasut" <marek.vasut+renesas@mailbox.org>, "Ryder
 Lee" <ryder.lee@mediatek.com>, "Weijie Gao" <weijie.gao@mediatek.com>,
 "Chunfeng Yun" <chunfeng.yun@mediatek.com>, "Igor Belwon"
 <igor.belwon@mentallysanemainliners.org>, "David Lechner"
 <dlechner@baylibre.com>, "Julien Stephan" <jstephan@baylibre.com>, "Macpaul
 Lin" <Macpaul.Lin@mediatek.com>, "Tom Rini" <trini@konsulko.com>, "Ilias
 Apalodimas" <ilias.apalodimas@linaro.org>, "Vitor Sato Eschholz"
 <vsatoes@baylibre.com>, "Johan Jonker" <jbx6244@gmail.com>, "Bastien
 Curutchet" <bastien.curutchet@bootlin.com>, "Neil Armstrong"
 <neil.armstrong@linaro.org>, "Alexey Charkov" <alchark@gmail.com>, "Suhrid
 Subramaniam" <Suhrid.Subramaniam@mediatek.com>, "Arnaud Ferraris"
 <arnaud.ferraris@collabora.com>, =?utf-8?b?UGFibG8gU3VuICjlravmr5Pnv5Qp?=
 <pablo.sun@mediatek.com>
To: "Carlo Caione" <ccaione@baylibre.com>, "GSS_MTK_Uboot_upstream"
 <GSS_MTK_Uboot_upstream@mediatek.com>, <u-boot@lists.u-boot-project.org>
From: "Carlo Caione" <ccaione@baylibre.com>
Subject: Re: [PATCH v3 0/6] Add Genio 510 and Genio 700 SPL boot support
X-Mailer: aerc 0.22.0
References: <20260730-ccaione-upstream-mt8390-spl-v3-0-82fb3bca27a4@baylibre.com>
In-Reply-To: <20260730-ccaione-upstream-mt8390-spl-v3-0-82fb3bca27a4@baylibre.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1786608236; x=1787213036;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:references:subject:from:to:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=mL3RARi1gOmMxZHEyVefX/1iiewzbtkIEt8H3mZig3o=;
 b=E/XbPdSHY4Nye67i0dsO09Eq5a5iJ4BwtwfuwngEsFcD6Mnm1G21VXbjlq7fUxwUuI
 XgiPG0NOPsBIFVjmJHvjLnn1BFkz4eVUI4n33jrn5XRrDkontRfFciEvKvmVCJ8tDYqy
 vpqdFIEgXfYc0XdblWNLIDv5A2vyeC6+A2Ds6BQhxA5xw87QCue1+HTQLeZJ7xGtiiy6
 uiY+dggM+ZIVwToxScyKv6Mrl982DWPLYIYdiELy5TM9eH/yWpKclVfjfe66Mc5xeHyB
 uWZEhMGzczg31jY9JE5vTJbWrdUq0G4KBY8qVa4+4djgx0whbESR7EPAdQjNcScnQ9N9
 sdlw==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=E/XbPdSH
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

On Thu Jul 30, 2026 at 4:18 PM CEST, Carlo Caione wrote:
> The Genio 510 and Genio 700 boot chains use a platform DDR loader built
> separately from U-Boot to initialize DRAM before entering U-Boot SPL. Add
> the shared SPL devicetree and configuration needed to initialize the debu=
g
> UART, watchdog, pinctrl and eMMC, then load a conventional FIT from the
> bootloaders GPT partition.

Please do NOT review this, I'm going to submit V4 soon with several
fixes.

Thanks,

--
Carlo Caione
