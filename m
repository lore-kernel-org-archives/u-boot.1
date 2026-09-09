Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9CE4C79FB6
	for <u-boot@archiver.kernel.org>; Wed,  9 Sep 2026 20:59:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1AA1160802;
	Wed,  9 Sep 2026 20:59:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7ysf93k3Zkby; Wed,  9 Sep 2026 20:59:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 71967607FD
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788987540;
	b=CEaU+myUR7Z/W56hpKBhCFWMCOTe3gLZ6RCyYrL9vx7lbWLLKzmX6mHsv9CmfQm8mleu
	 K5SRZ8Lgxtg0RFAvJJk9v2lTluXItzOupA8nWH0Yi1a6RwbBAguuyhCGyWYKu5IYTG1aT
	 4edCHTyAMokwkiQCDXu7XvtOSC4IKxJiF8JAB6CWrsSMPdOLn26U1FhAFwBt8xLj+kU9c
	 Rds9YVN33HCBRK/ozN2aNykVsypxx0CMm1tbXaO1N3N4tDCuKY9UgCWEgHzq83b5zMRel
	 Z1064x7RORx1yi/XhQOBokQRUOvDkmfH7v+DUKHwlyhjfWRYMPW2V1E0WuukmE4FGUg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788987540;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=UOb47luqUGWyaZ9KUinRHeQYd31d0yFZ5lAmpkZ9dKU=;
	b=jlqARpbRVzZhE26C8C9EdPUERMK71NxBke3ZhsiN2JoXs73SLPoVpXi3uoOpSkeG2bW6
	 AuusOMhd87sfCRJCkohdwXY7imQGlRV8PH8bICWr2I7knDAJSd07vuENabiwvnyxIewmk
	 hZMegVjCX8mUf9aYBwwJh55gUTuhDpGMVMAvJHW9tnLCnPq/m+MxuWpo4zGOyZ+mFI4pI
	 YdPXoY+qZkvbfIiL9s61xI/EmxKSRhOu2rhHscyVe8ScE36JhR4gzWiZDqDUyW5UkPs6c
	 dSKBOtBvW9LidojUqj4wU331bhN2rygzM6hieMNeYhiyM4iD9bp46Jfdcr1muZGYacA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788987540;
	bh=UOb47luqUGWyaZ9KUinRHeQYd31d0yFZ5lAmpkZ9dKU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IeDCxMZiL/dB25+taIU6uu3LgydGF9c+y3L4zTEcmppgqXXkntzpC1kfyEfrW4vbo
	 K/mA2MmawVhznFi8vXiwaVzliVlcv4+Fjzdwv9AT4yZF9AimktiW/SoLdTfyvbZsuC
	 +TS/hB2Ne//tTIy3V3JdSnUUHCVs6h4kQmtwmc2dQlk9C93XtuOHXAwFZhd3T/HN9R
	 AYe6DLVZz86MpEzGgnVmuqhVnCVWe4mCRAihxV6P1WPnz0TbfvPl2cB1gt2+o9HrnX
	 2sQpJL9UtM7IL0gYj3blg+AL+ZO3RoUVyblpFZEa63SUAmS7F2Ua/uW9NEXyQRr05u
	 rYRN/4TnCMOJg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 71967607FD;
	Wed,  9 Sep 2026 20:59:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7419943F
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 20:58:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6B41A810AF
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 20:58:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id a8O2JWmsdU_6 for <u-boot@lists.u-boot-project.org>;
 Wed,  9 Sep 2026 20:58:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 7797381098
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:30::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788987537;
 b=PnNQWxFQ9M0hXxpRFRFtg3lB1lei+m4gHkS654YjEhI13FYc+gNEuQ2B6zkNp+4u72Jr
 Jz3jtsNYS7XyEGTCy63Oglvb+DM8+5nlAtqXZULlCLmhORRWBm9nm/BJ2pBlNJYa36YtI
 jBQ35k8i7ZbU5jeXrCKCh4878CF4qFhi/uWzb/EywUha3nZkdexWbGGf5x4YSUle5w6oh
 EiXsasgPJ5djCfnIDMs2ahI4+sosEO1rpU9c8jmEkdQuNrvwr/526f1xtU7w0SaZDhZ5W
 rHBAWwteOLefgP+FRVHN4xJpGiViCmBn07mpDRb3lASZCjsJ5ffLKIAC1YmFFxUW+XQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788987537;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To;
 bh=UOb47luqUGWyaZ9KUinRHeQYd31d0yFZ5lAmpkZ9dKU=;
 b=ZM3QHO2bmlsuEccfITqvoBQkBmtAN3tNZUxUACgo7dJMydx/9X05e8fetzIgzAUdMtfj
 1qQ/Vvk+HoIoK0y77f1w1xLJYSvZPpd4UsoXWYh0lVX+f5nKg9j2wfZoHdu3gzStvFKcf
 SV8hIXpzWURfCuJNnln+mV5Je2D56uPunAzXBK67oC7GRx0iVCL4pvm1LhFSYapVoaBE0
 2GHG1dHIn4uKAreBQkIymamzJuSRZNE5YZ/yTvrK7LXwAnJTxDKnmJzHajxSE9xWG1uRw
 lTIWDFN+NX30pcXmeQIWsUm0C360Bg2feBLL33ZDIGZ9cESkuZqB8vShaUFKWcjezfQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=UH4b95TJ; 
 arc=none smtp.remote-ip="2a00:1450:4864:30::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:30::10; helo=mail-wr2-x10.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=UH4b95TJ
Received: from mail-wr2-x10.google.com (mail-wr2-x10.google.com
 [IPv6:2a00:1450:4864:30::10])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7797381098
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 20:58:56 +0000 (UTC)
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-482f62ccdb1so912857f8f.1
 for <u-boot@lists.u-boot-project.org>; Wed, 09 Sep 2026 13:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788987535; x=1789592335;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=UOb47luqUGWyaZ9KUinRHeQYd31d0yFZ5lAmpkZ9dKU=;
 b=UH4b95TJMOq1VsXeJx5G3t1bSxAwbvHoVWmkHzcby14HfxAczgWmtNba7tOUz1sNOB
 EE7zjgljkzlEb5Su3ULE/fZ2S00t+RW8ugV6sF3GtxON9st491gC7FG57iabyHELERg9
 O+qfiLlfezvURNDvDDTjj/xdKCvahbhHl7gctp4ZkcSGSJ8sXDfKKN6ydiuo5utuUDZn
 s+ed0jeSAPW3RC4dLX0ne/5DjO5meuBpGvsQTkMxB4ctwK/C0JaK1aNz7RpD2SZ+HyMP
 9QH+Zj290XIVVIseicYEn/X2yiOcVYKqvPMlO3i6R1v9K0VgEbuz9hOAnH+BUE0KFTtf
 6huQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788987535; x=1789592335;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UOb47luqUGWyaZ9KUinRHeQYd31d0yFZ5lAmpkZ9dKU=;
 b=oQbfxEOq79dNOQL4cjYcdYJBr7jShZB1rlywjVinkY3NXITZgi2bXHgoLG9j6kUvjG
 egnE1KcZ2AKopU8iLQKKA79Pydt+CMFbWRnmnxTEnrfkrsPk1yM4Csd+7MZEs5bBzkt+
 lQTBBGhD4LlDInNr+y5W90mThtf8wchLeZnRi57fbN++GRm6Adf9JsH34t+hniCdTith
 vzj557dWuIr7Am/6JYVyt7xPs29ivatl5r5BiZB0F0Ao1RR1NYIecdIKWvm3T/nw92hd
 jwSMBfNFFitX1UC5R6xV8ZQMp0xJdBzNPmhiyCgRosuRxNOWJLga1w8C6AFw9CKkZMnd
 G2VQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBy/NnVWSvpO/jYkCbtuE2PwdSw7zMhFLmrQcB4UzTuOUev28Mzb7x1FdhW2GexQIsB6MWmrTwk=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mIZq1x/DrS36Dg5TDbr9paV7Uaw9BLNe/cWgOXbBPMilVzoPF2
 VbAVRGjB3LRsxrntQm0S+wthMgVafLvxF3wQSny2mCs1oEjgxcBAF7HuxaHGWh7OW+69eWy23ZU
 akmJG
X-Gm-Gg: AYBFou1R5IMC9gVbu2R4mk2AGOyKQ6QNA+lRldgHOXdwtVQNKtF15BjVqzaTLfbcikc
 LOGdS2ofce4gHkJmAPRtEdQadhsh6FG5RfP8zzyPB5jrmkKqVjwvsCBdOAR6pEB2j6ujjIA4gIO
 NPHrWCojorflGkVCUTidXwvaaDtZr4nF3Vg8LwU55hyNGSWE19Bw6Ojpv4MzLKUHgVS29I978Xb
 0hhFKBr3j+pXBeQrNWrP9q4FEoYlAFDSN9jHcr/LItjRv3pRn3pRJFAH0YssvpbotYjryw/cqUd
 ctD2eki2C4uD0JKSJvteiMMh8YlcQOBfD733RUdzKf2vou/tazlRjm0HdSsVPWZ/GBtT62qg1t3
 MY9wjj4imuVpXm3/11irXDiGHR3gYW29bEWrdGZJCxOn43bMfmK2aGVdr5hcIFi3o4gIVB5FEh3
 mHPQNNFgrGHB3tbBhcA8umcNHKpXJZjH/BDYE6uI2td00JWCHLNI67i1NxttVM+CzWK1lgDra1p
 r58g6iFF/7jz8WKQeEsJpI3GnyHNgj8LKgMzyTV0G9KcnVpa3B/8ft5TA==
X-Received: by 2002:a05:6000:288a:b0:485:8224:1a41 with SMTP id
 ffacd0b85a97d-486e0f8ff2bmr1156879f8f.18.1788987535015; 
 Wed, 09 Sep 2026 13:58:55 -0700 (PDT)
Received: from macbook (host-95-232-147-181.retail.telecomitalia.it.
 [95.232.147.181]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485885bfe14sm46706970f8f.35.2026.09.09.13.58.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 13:58:54 -0700 (PDT)
Date: Wed, 9 Sep 2026 22:58:53 +0200
From: Carlo Caione <ccaione@baylibre.com>
To: David Lechner <dlechner@baylibre.com>
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org, Julien Masson <jmasson@baylibre.com>, 
 Quentin Schulz <u-boot@0leil.net>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, Macpaul Lin <Macpaul.Lin@mediatek.com>,
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>, Johan Jonker <jbx6244@gmail.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Alexey Charkov <alchark@gmail.com>,
 Suhrid Subramaniam <Suhrid.Subramaniam@mediatek.com>, 
 Arnaud Ferraris <arnaud.ferraris@collabora.com>,
 Pablo Sun =?utf-8?B?KOWtq+avk+e/lCk=?= <pablo.sun@mediatek.com>
Subject: Re: [PATCH v6 6/6] doc: board: mediatek: document Genio 510 and 700
 SPL boot
Message-ID: <aqHIL8RO4SudXXds@macbook>
References: <20260906-ccaione-upstream-mt8390-spl-v6-0-4d4a11d5741d@baylibre.com>
 <20260906-ccaione-upstream-mt8390-spl-v6-6-4d4a11d5741d@baylibre.com>
 <f12ef161-582c-458d-b49d-974ab55e7788@baylibre.com>
 <aqHGk-XC59Ddhcl-@macbook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqHGk-XC59Ddhcl-@macbook>
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

On Wed, Sep 09, 2026 at 22:54:05 +0100, Carlo Caione wrote:
> On Wed, Sep 09, 2026 at 14:56:02 +0100, David Lechner wrote:
> > On 9/6/26 10:30 AM, Carlo Caione wrote:

[...]
> > Do CONFIG_MTK_GENIO_DDR_LOADER_SIZE and CONFIG_SPL_MAX_SIZE need to be the
> > same or just CONFIG_SPL_MAX_SIZE >= CONFIG_MTK_GENIO_DDR_LOADER_SIZE?
> 
> They refer to two different things: CONFIG_MTK_GENIO_DDR_LOADER_SIZE
> reserves space for the DDR loader while CONFIG_MTK_GENIO_DDR_LOADER_SIZE
> is the size of the following SPL region which the loader copies to DRAM.

Damn, of course the second one is CONFIG_SPL_MAX_SIZE.

--
Carlo Caione
