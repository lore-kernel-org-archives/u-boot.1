Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B251C79FB6
	for <u-boot@archiver.kernel.org>; Wed,  9 Sep 2026 19:33:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4A55D40AA1;
	Wed,  9 Sep 2026 19:33:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oEWVTatziSnu; Wed,  9 Sep 2026 19:33:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 8E6764084E
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788982421;
	b=ChnCCoSvmPIsIOObkAcd5kcMVMdYEcJaGyA5IMt7iMWhbv7Y1FQ+ZVRC6oQTvGpyuj/L
	 0XW34rxH6QA4Kv2QvPFsom3jtR2oR4h+X2Slg5t9D5KCjNiZPpKRyucXEAqWxV0CoEHcd
	 Hx7ric916VWuw09n0r8VQ/oH6hwuK81enqE82EyWxBNPv7AfctHLoWGeIOH70hcNDWB7k
	 OoW4DDL2SPNjHROV0DM2zWuD69Ig34fp9XAkjvCCrc14SR2WdJMCP2ETeVA6RrDzSIXnq
	 goC3re/aLP1viaCVfoRDoWJF4Zx38sSBMkKpLKD0lK9iv/92iW6/ggpMkflOauFOYCw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788982421;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=TGDCSFMqnkMugmdGs2kNvPXI8g11Svy9bfgw4gTJORk=;
	b=cbYF5HlJtiblONAmi/FxNxDXSDixz2ILRGSvb4iBFqWL8UG0kHDwPfW9B/mpdcdlePso
	 RL1Wsu/+eGGjQm6qsgOqScXOYyeS6cWR4Y+3iduGgEu8kipMtsIDYndKWKeI+aKlGTT2v
	 5uiE7atE75iIR6a2GZmADgmeZojOLGeKMnAAEl/XobbC2ywL18pLiyEUkrdDWsEFMULhy
	 G+Q2wx5PgFI0u+VyHFl2OmEA5y2fzCLZm0rXEoyJDN7aFe3qMtzIFFWUNMCiZATjQVSIw
	 nisFsupJLrTW/H4w5afMXMtoM5283hlDchEVEMfhTbiuALDyPoWsFk6Rflc79m+MOOA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788982421;
	bh=TGDCSFMqnkMugmdGs2kNvPXI8g11Svy9bfgw4gTJORk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gX7uJ8c7ooJcn1P5N4/LCH+cyRMr18ctgSlqRqllxdI3QIsA3jkqRu6+SS4GwYeSF
	 b/gAg5LjuR1z0sqd9YOd8HtASqjFZcTcJzf6cStDM9eYwQm7k92rwKujQIkS1teNme
	 sOFAH0X7fVsc37s+r7yFoBiaVMnvcU0jfP47KLR3ZyBJ5OP6neGOA8mObfouRjxnqu
	 FrHMB2aWFfUSIdt7RnUEDwNAqDej4ZS98EKkpiuJGxmwRVr0JQjpBBZ+DTwdTZHAKA
	 UnsQycdIr43KSLdGZmZATsbZ2kxprV4AGfd8ht/EmAqhbN51r9+Z2VktJ4Xr4Mw2QA
	 H+aZ5wb3FjERw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8E6764084E;
	Wed,  9 Sep 2026 19:33:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id A0C2232F
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 19:33:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 91FF5608B3
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 19:33:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XtJt-HpUZQ-t for <u-boot@lists.u-boot-project.org>;
 Wed,  9 Sep 2026 19:33:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 8BBDB6080C
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::22e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788982420;
 b=dhgz9O5Nk7GG6DokiG2k8BATT/eaMrbO2IUWn2Azy8GHWU1CPNOSWLwUWzwx2eJdtkQL
 ry35/Byb6RWNa+w+gI+ZuY8MtamYKTFaJ9LM2jOpXu4ju0UKCrSu8FAsfSXWBKzmvlsea
 xflGtBq8Lku+0OPvknD1dgIKJ9IH/hwfnZt2w/8Wm939SvN2ryy/mnT5S4mmeeYPoIOjL
 DP9tHkv6NHmJGW0crtnBZfZPZabBGOEyPHxuq2OPoWULkv1NgdQ5/gVIPlAoDwpHZm2Kw
 YSkfTihzjJzL2qNbMnIPsr1kp4yzumb6U58zUW4Rv3PLlmLWgfq5OSJpXI6/qoPdJ1Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788982420;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
 bh=TGDCSFMqnkMugmdGs2kNvPXI8g11Svy9bfgw4gTJORk=;
 b=V8ArkZPXAOmH+BElsf7A7zYwY6KaMdHF+pTeb+VJaF6xaWqpPbMiM40TVmc9DgoMQRR6
 VJ9i2YN7mfLOxp0tchKekQdv0JpNOxAsYbp0zRj3c40FDUNeWcQ6A3/x2LPucutUVBQd0
 jhOmDnQyWsGAjsue0oedYBkl0h9WvTKPgxKA3Xg5k/m6KbvMlwcu9yXVAOeX1bI+Z7cDd
 yIqRoOsAx98m38NfWNW8IUXvkNfd5eh2XQ95DDVsJCBtkvt17FMrTPith/LwfQwrEYeds
 GEKzGTW9MBrL8AKt7mKywFoJN9lovM0upQe5yEmG5w1DGJVUF4jbxrAh+iW+rQoEgxQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=hpvcup5W; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::22e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::22e; helo=mail-oi1-x22e.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=hpvcup5W
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8BBDB6080C
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 19:33:38 +0000 (UTC)
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-4c18e5e9745so321325b6e.2
 for <u-boot@lists.u-boot-project.org>; Wed, 09 Sep 2026 12:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788982417; x=1789587217;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=TGDCSFMqnkMugmdGs2kNvPXI8g11Svy9bfgw4gTJORk=;
 b=hpvcup5WtgqT/mo4sa2qaGnE/f2L5TC6daWxWMUHJ+MEhPM54Liml5A2zY/QnKAyvt
 59L79CO9Y/JBwLCo8sWPqfGtFvcRHmpoOptqDcf9/e98TKo1kXzHrk2COezTzHqXp/G5
 5cLwsJkI6zL3qERRl8uKn4fQoqg5vzLkz9/2lIIkTW5Ad3TU1l4PEdy6DHJe/encCR8E
 g22sH1As6AM+pbZDkx1+gSxNt+VRDGSx9UpO+gsJV/dF4g1yjXC+Kl6lttWyT/cHg/c8
 FZOgbF0YnIS9coUpDD+R8JspSqKTONdT2ByucsBLK1D6UeUKP45qDhAnHRPtxlHHTbcI
 hv7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788982417; x=1789587217;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TGDCSFMqnkMugmdGs2kNvPXI8g11Svy9bfgw4gTJORk=;
 b=oofAAyLIKDi1AWLCZthB51y3ilnBKT5RaX24pFAwLfXJ3Qwy+E5idE2bHxMZHQtDyh
 D38Ub2YKBeIjFk6aXptoEToXS3iJcByhuvNqLbM4bo7YiYFAGUbPeA6QS7kBi2YwMgnR
 RuVRlMm/kWoEWDTMvfsujs65VEwGzH/4LDP/WNPTd3udCUgXxRW3GrTTSYS7NieNQdy7
 ArLpP2nFIjJhqXv6V8oiCNeUooreJyU5O6cgC/XUFoJUFVcjLCdMdE+k7gkYWH2LifM4
 JuwgWRZH1uIA6Y7QWhsD0/b3OxF0aml6+hAPhcPhdeCVfte1Swwt01HGw7q/jQaIVzAf
 AvxA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwFHc79pqFyk011mP+cTjepCNncPiooj1Uo2wBYWIk3vLZtb99IZUkorSAc1uewp54aqrsKNh4=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mGh3mWxTHhmiyfXZfnJMlBtGZK41O4KerQq3gWqi5uF1WEv2Z0
 71FZcKxHZqbUe9UWebf5Vhk0IB+UCrkOAKVjfNTnY/Ij0PcLR36peqNY+vpn4RnoWLw=
X-Gm-Gg: AYBFou0d6UPPji3Lq/20E2C81neGEkOwPsH3kmMa1PBnjCxnPekgvxxbbhsrex2kmCP
 rIoiVuMdIQXUV96/tqNOLx3UGrh4d3M+22T1PcQ/z+g7WtMCPAx4fHdXWSqxzJsI0jXShAYoLO6
 BXsxbHaK6pCj5ueqzkEsNG/pGOmDPcxZ33ALb+HLxlOUB4Eji5pUFc60/SzntA3cEn2J/lMozGZ
 wshEnNEo+ibxexX2hP+FBcOnsDeoEdSsDTKS1+zslP0/QKF7z14gU3FukGV9hv8BwZJ3A/7kPs6
 JDzWOUk2ilXrPiTvaHUjVtVVUci74EoYa8s6b3Nq4Zg+wItoxY3LLws1Hd8lSi2qNEebgiQl3yu
 PA8Ts65lP1Hp0vaErOAhy2KZ69OV/MXlfZKYrYudyvqtICsv9LF60kJoFhWr+efvERg+R3Ea0BY
 SCN0xRr+G7TaOveXMkfw8UOAXPhm2fhvWgQtLoEhcqDAfEiGJ2f9hfkwyeWqodlDe3red/OdRyB
 b3pLLUnB8bFz+F1mDfYDZ2F9Cqzsd00/PxxYosFQ9QBxgZNl6RiUgzI8g==
X-Received: by 2002:a05:6808:5281:b0:4c1:83fb:8c7b with SMTP id
 5614622812f47-4c183fba5afmr1366006b6e.12.1788982417508; 
 Wed, 09 Sep 2026 12:33:37 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:a8c5:6332:5ea:5b26?
 ([2600:8803:e7e4:500:a8c5:6332:5ea:5b26])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4b96eaa508asm17789493b6e.1.2026.09.09.12.33.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Sep 2026 12:33:35 -0700 (PDT)
Message-ID: <8f39c6a2-54dd-4809-badd-dc72619c3aa9@baylibre.com>
Date: Wed, 9 Sep 2026 14:33:34 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/6] arm: dts: mediatek: prepare Genio 510 and 700
 devices for SPL
To: Carlo Caione <ccaione@baylibre.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 u-boot@lists.u-boot-project.org
Cc: Julien Masson <jmasson@baylibre.com>, Quentin Schulz <u-boot@0leil.net>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Julien Stephan <jstephan@baylibre.com>,
 Macpaul Lin <Macpaul.Lin@mediatek.com>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Vitor Sato Eschholz <vsatoes@baylibre.com>, Johan Jonker
 <jbx6244@gmail.com>, Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Alexey Charkov <alchark@gmail.com>,
 Suhrid Subramaniam <Suhrid.Subramaniam@mediatek.com>,
 Arnaud Ferraris <arnaud.ferraris@collabora.com>,
 =?UTF-8?B?UGFibG8gU3VuICjlravmr5Pnv5Qp?= <pablo.sun@mediatek.com>
References: <20260906-ccaione-upstream-mt8390-spl-v6-0-4d4a11d5741d@baylibre.com>
 <20260906-ccaione-upstream-mt8390-spl-v6-1-4d4a11d5741d@baylibre.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20260906-ccaione-upstream-mt8390-spl-v6-1-4d4a11d5741d@baylibre.com>
Content-Type: text/plain; charset=UTF-8
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

On 9/6/26 10:30 AM, Carlo Caione wrote:
> The Genio 510 and Genio 700 boot flows enter U-Boot SPL after an
> external DDR loader has initialized DRAM. SPL then needs the debug UART
> and eMMC controller, together with their clock, syscon, pinctrl and
> watchdog providers, to load the firmware FIT.
> 
> Both boards share this MT8188-family dependency chain, so keep the
> pre-RAM annotations in a common include used by their board-specific
> U-Boot devicetrees.
> 

...

> +/ {
> +	memory@40000000 {
> +		/* Preserve the board memory description; the loader initializes DRAM. */
> +		bootph-pre-ram;

Having this on memory seems a bit odd. Is it actually needed?

> +	};
> +};
> +
