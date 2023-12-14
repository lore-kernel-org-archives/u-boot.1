Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6915C4332F
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 21:27:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1BDD587ADA;
	Thu, 14 Dec 2023 22:27:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cczzRBTi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A557587B1C; Thu, 14 Dec 2023 22:27:26 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D1D187AB5
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 22:27:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a1ca24776c3so218559866b.0
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 13:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702589244; x=1703194044; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tQLR3TCzDnjOcoUY0UAy1UbsLgGNkBs2xj+zMAJuyhY=;
 b=cczzRBTiBd3/GGqMgO7Id/DQJTTR9TjzLsZ+34C5Lc4/UVRwlKerNm4CJ46eVDohgD
 8hkdgFdrc0+jcRqXXr94L/0f54wIQT5rehjo/cP1BqbVffgwVmesWHgRHbMBfWWOX6BP
 6cIPlblOMfW7I6LrZbWX39XDW5Bp75uKVp18I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702589244; x=1703194044;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tQLR3TCzDnjOcoUY0UAy1UbsLgGNkBs2xj+zMAJuyhY=;
 b=Y/3tOBySH1y0jasl9c8Xiv4FVEQx4wAsu4qabkaaaBTsLrXlAWUl4H8X1+ZxtznFaV
 lstDRA+6ytL3mP9EhDXUQCujIJnn2KiVilhN+mZT/fCX+piFFyECrRBsJKkHARCVfGA1
 PDajzZLJvxcZrPkhyf1Y/4nS8SIrCeQi+hfbMnFKQKUBEl85xYTFRAjlI/FT8zWS2Bki
 DrUWQyJavIE9dqmaixl335qvrD9uS23/vi59PT8u12PkZx6QwrqjvScQvFvtWSA7qrAi
 ojc2bQ4ML6n6AfMwcdy3OLMXsCpO64QeX09FU8WLUxqraTtMvqsrHkBsXX8NikJSaByB
 XS9g==
X-Gm-Message-State: AOJu0YwFqJS5YyZxm3mpVQzou12hVLBMsxTPmd/JxB6itFbbfd0F03jg
 Xc03igaEe/gi4bupRZHe5kxwSg4YElEAlb1Qas0rzg==
X-Google-Smtp-Source: AGHT+IE7OYOAzIzBqNAvCTayftZvK3DtzN2NEMkheGR79bvEI3MFe4Unl3+AfpaA2BHcjVdb51pzpP/lBxzBQ/Ebrqw=
X-Received: by 2002:a17:906:782:b0:a1d:2f59:81a4 with SMTP id
 l2-20020a170906078200b00a1d2f5981a4mr10882943ejc.62.1702589243759; Thu, 14
 Dec 2023 13:27:23 -0800 (PST)
MIME-Version: 1.0
References: <20231214153620.23998-1-zajec5@gmail.com>
In-Reply-To: <20231214153620.23998-1-zajec5@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 14 Dec 2023 14:27:12 -0700
Message-ID: <CAPnjgZ31AAauR876W1RmU4JPzKUD8XAMCZrJDumE+Dr4miqABQ@mail.gmail.com>
Subject: Re: [PATCH RFC] dt-bindings: nvmem: u-boot, env: add any-name MAC
 cells compatible
To: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 devicetree@vger.kernel.org, 
 linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, u-boot@lists.denx.de, 
 =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi Rafa=C5=82,

On Thu, 14 Dec 2023 at 08:36, Rafa=C5=82 Mi=C5=82ecki <zajec5@gmail.com> wr=
ote:
>
> From: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
>
> So far we had a property for "ethaddr" NVMEM cell containing base
> Ethernet MAC address. The problem is vendors often pick non-standard
> names for storing MAC(s) (other than "ethaddr"). A few names were
> noticed over years:
> 1. "wanaddr" (Edimax, ELECOM, EnGenius, I-O DATA, Sitecom)
> 2. "et1macaddr" (ASUS)
> 3. "eth1addr" (Buffalo)
> 4. "athaddr" (EnGenius)
> 5. "baseMAC" (Netgear)
> 6. "mac" (Netgear)
> 7. "mac_addr" (Moxa)
> and more ("HW_LAN_MAC", "HW_WAN_MAC", "INIC_MAC_ADDR", "LAN_MAC_ADDR",
> "RADIOADDR0", "RADIOADDR1", "WAN_MAC_ADDR", "lan1_mac_addr", "wanmac",
> "wmac1", "wmac2").
>
> It doesn't make sense to add property for every possible MAC cell name.
> Instead allow specifying cells with "mac" compatible.
>
> Signed-off-by: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
> ---
> List of devices and their U-Boot MAC variables:
> alphanetworks,asl56026) wanmac
> asus,rt-ac65p) et1macaddr
> asus,rt-ac85p) et1macaddr
> belkin,f9k1109v1) HW_WAN_MAC + HW_LAN_MAC
> buffalo,ls220de) eth1addr
> buffalo,ls421de) eth1addr
> checkpoint,l-50) lan1_mac_addr
> dovado,tiny-ac) INIC_MAC_ADDR
> dovado,tiny-ac) LAN_MAC_ADDR + WAN_MAC_ADDR
> edimax,ra21s) wanaddr
> edimax,rg21s) wanaddr
> elecom,wrc-2533ghbk-i) wanaddr
> elecom,wrc-2533ghbk2-t) wanaddr
> engenius,ecb1200) athaddr
> engenius,ecb1750) athaddr
> engenius,epg5000) wanaddr
> engenius,epg600) wanaddr
> engenius,esr1200) wanaddr
> engenius,esr1750) wanaddr
> engenius,esr600) wanaddr
> engenius,esr600h) wanaddr
> engenius,esr900) wanaddr
> enterasys,ws-ap3705i) RADIOADDR0 + RADIOADDR1
> iodata,wn-ac1167dgr) wanaddr
> iodata,wn-ac1167gr) wanaddr
> iodata,wn-ac1600dgr) wanaddr
> iodata,wn-ac1600dgr2) wanaddr
> iodata,wn-ac733gr3) wanaddr
> iodata,wn-ag300dgr) wanaddr
> iodata,wnpr2600g) wanaddr
> moxa,awk-1137c) mac_addr
> netgear,wax220) mac
> netgear,wndap620) baseMAC
> netgear,wndap660) baseMAC
> ocedo,panda) wmac1 + wmac2
> sitecom,wlr-7100) wanaddr
> sitecom,wlr-8100) wanaddr
>
>  .../devicetree/bindings/nvmem/u-boot,env.yaml | 33 +++++++++++++++++++
>  1 file changed, 33 insertions(+)
>

Are these upstream U-Boots, or just vendor forks?

Regards,
Simon
