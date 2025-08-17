Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 107D4CA0EE4
	for <u-boot@archiver.kernel.org>; Sun, 17 Aug 2025 16:39:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 04B9C82063;
	Sun, 17 Aug 2025 18:39:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="O7dLG43/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF00D830C0; Sun, 17 Aug 2025 18:39:39 +0200 (CEST)
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net
 [IPv6:2001:4b98:dc4:8::228])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77B7381D5D
 for <u-boot@lists.denx.de>; Sun, 17 Aug 2025 18:39:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jeremie.dautheribes@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 662C34443F;
 Sun, 17 Aug 2025 16:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1755448775;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U9pV/R1Oiz8UQXJC72WJL8co3AF0p1ghyY/w1kakpek=;
 b=O7dLG43/8QNE1M3307KAr0C5mwAs13oJU/2kGtXHh/oJ1NdOiyGAKmGazURwTttNwVk/LQ
 LLWVGHfVByQ3o98bzL26Qc7GQ/B5Qkl+j/Hva1B4VflOwkMMd/LgrSYh/yNOeTgf9zyjpW
 L5Va3fYHG8AjdUd++PAQkSacZ0neNFi/mVDnX8PKENb9mlXAMLLv9jQH/IyzjTIYMKZME8
 Y5p0OP6Ve9uyarVdVR5WoLdoByZPcuIWH7PGWjDB2Tbbq5avvII621t665L5qZfx8KCbKw
 oHpPm77Yip2rgpcvNZrdPLt/sWAf6U/0wUW2gxN28BCLbn2U42rL53jonEel9w==
Message-ID: <cced47b7-ec79-43cf-af08-653987d62fc1@bootlin.com>
Date: Sun, 17 Aug 2025 18:39:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] imx: imx93_evk: Fix conflict SPL early malloc address
To: Fabio Estevam <festevam@gmail.com>
Cc: Stefano Babic <sbabic@nabladev.com>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>
References: <20250814163926.1205901-1-jeremie.dautheribes@bootlin.com>
 <CAOMZO5Ank65-NpF+b4icn8BxCAR11VEUPt-v4VAMrQeu0Xr1NQ@mail.gmail.com>
From: =?UTF-8?B?SsOpcsOpbWllIERhdXRoZXJpYmVz?=
 <jeremie.dautheribes@bootlin.com>
Content-Language: en-US
Organization: Bootlin
In-Reply-To: <CAOMZO5Ank65-NpF+b4icn8BxCAR11VEUPt-v4VAMrQeu0Xr1NQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduhedtvdefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhohgjtgfgsehtkeertddtvdejnecuhfhrohhmpeflrohrrohmihgvucffrghuthhhvghrihgsvghsuceojhgvrhgvmhhivgdruggruhhthhgvrhhisggvshessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepkeekfeevgeevueeiueeiheegtefgueeuveekveetveekgfegheejgeelleegjeejnecukfhppedvrgdtudemtggsudgumeekugelheemjedvtddtmeehiedvtgemvgeltdgumeeifhgvtgemgegsfhdvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduugemkeguleehmeejvddttdemheeivdgtmegvledtugemiehfvggtmeegsghfvddphhgvlhhopeglkffrggeimedvrgdtudemtggsudgumeekugelheemjedvtddtmeehiedvtgemvgeltdgumeeifhgvtgemgegsfhdvngdpmhgrihhlfhhrohhmpehjvghrvghmihgvrdgurghuthhhvghrihgsvghssegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeeipdhrtghpthhtohepfhgvshhtvghvrghmsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshgsrggsihgtsehnr
 ggslhgruggvvhdrtghomhdprhgtphhtthhopehusghoohhtqdhimhigsehngihprdgtohhmpdhrtghpthhtohepuhdqsghoohhtsehlihhsthhsrdguvghngidruggvpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhmpdhrtghpthhtohepmhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomh
X-GND-Sasl: jeremie.dautheribes@bootlin.com
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

Hi Fabio,

On 14/08/2025 19:07, Fabio Estevam wrote:
> On Thu, Aug 14, 2025 at 1:40 PM Jérémie Dautheribes
> <jeremie.dautheribes@bootlin.com> wrote:
> 
>> -#ifdef CONFIG_XPL_BUILD
>> -#define CFG_MALLOC_F_ADDR              0x204D0000
>> -#endif
> 
> Should imx93_frdm.h and imx93_qsb.h be changed like this as well?

Yes I guess they can face the same issue. I have access to a frdm board 
if you want me to test it.

Jérémie
