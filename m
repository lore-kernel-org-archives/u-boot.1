Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB825C5CFCF
	for <u-boot@archiver.kernel.org>; Fri, 14 Aug 2026 21:23:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 24A9A608B4;
	Fri, 14 Aug 2026 21:23:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rskUmECd0TX4; Fri, 14 Aug 2026 21:23:29 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 75831606E1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786742609;
	bh=NPJizuUG5GG/hot8f1IkGiec6ahUuvdfkVJtqcSHUTE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oDivFqlNxHcDC/qRynrrkmTzI7jHS3qHDiPhsk9M0Gf/lfQTpib4YwByHOjs4fH9y
	 AVHO8ftM8G2K14/LNyWWW34LxpOY7AbFwRkZKaL5BKkNWyBng4e9fIBix/k0NnqAJV
	 J1E3ovR+2u1JT1cYqolM/4ZjnsugRv5g7TuTfd/FfPvxvgKVpyf7TAoAWew9iIsv/u
	 jqGKX2ZOrObQQ1npOdsMibtpbIEAdvPljVIyyl0jEfukwFi+vGIv3JuG2sXL8RreIJ
	 RqvEFZ1jwRqmkVjwRE9q2nNq72YDcVpioNurDQdHtC0Uscs159Igd4y9NQtJYb0UP9
	 VpVKx+f00weMg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 75831606E1;
	Fri, 14 Aug 2026 21:23:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 05BF43DF
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 21:23:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 03A8940A0E
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 21:23:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 33iVkI4RrX_L for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 21:23:27 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52f; helo=mail-ed1-x52f.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 2CB6540A0B
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2CB6540A0B
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=VD2M9HmR
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2CB6540A0B
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 21:23:27 +0000 (UTC)
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-6a17cb94b26so2545367a12.3
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 14:23:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786742605; cv=none;
 d=google.com; s=arc-20260327;
 b=nN9GBqqoh8vHk1e34TdgoYpt78m+iL27Su8+dYnvejanRFsv6rcc/bluNaJSmn//hi
 O1YHR+NIKIv2vA/W7ogDJc9SG2OSa66NlvyGEaF88YyzL5Nw7HdrTy43DSDZM9tn8mzz
 ehEYSBSdVbQF37gFEsgOpD0FF/bL/Nvv31O/NIefsg+2IqyeibOG481iPujD6iNg6Ahj
 yj2Ro7L6ZQ9MtzVMNg2cPetWbRDEjhOZnpigEFC1dovnN2smsSmBAkzhwff87cpACw0a
 dximz9An90YThc7WFxWzYckrBcFCqF97EOldeRM27ADKCK1Re/x/fT1orwqMGiIkOfHs
 1irA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=NPJizuUG5GG/hot8f1IkGiec6ahUuvdfkVJtqcSHUTE=;
 fh=Q66Cp3bpEzEbjQJE/h3XDQQxStPUWHtiZXNsZQyoyDQ=;
 b=h3eoOE0rB9chLTyStuQJ9wiK8l9lLwXdj9Sm1OPrbn5Sm606JtB0TE5vKM8/vEIY8p
 iXbZ9Cbq4H8JQzGjhOx4eNAjIXysJLN9r2LjWann8u8crJVkq4XdBfI2AoK6IREbkHyn
 vy5akj+g+vm/73ZBfAWRJOVbSrIVHcdD24e+qi+cVru9GS2s4pCpM3fSklQDJy5d/XZF
 +GjU1NsqwSzSLLa2WHBcNVRYzRm5U3c+DSmspT/dkhEssRq2VtUC4nWHs/4Lukb8hxYD
 hY1ndSdqTkrOSUZiv3DwPA5FZNvinZpeJz7KT3RJJxYjAZjUAq4zf1lLKJtmmEFAT1RJ
 wGJw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1786742605; x=1787347405;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=NPJizuUG5GG/hot8f1IkGiec6ahUuvdfkVJtqcSHUTE=;
 b=VD2M9HmR5hyLdRT+UZHFRxPkai8E8a4xfaJLmgn6tfLWR3t2S5fFxPoPfGPYcQMy5m
 CqI6r9YuFQY0hsX7ADSAV2tH4u97mHhd4ukpXa/fwqVe+Xj/Mljd3QDpce2Vjyqz4sqJ
 C3bI6BX5M92kI1MALnJytj1vBFIF4SjbIoMU8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786742605; x=1787347405;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NPJizuUG5GG/hot8f1IkGiec6ahUuvdfkVJtqcSHUTE=;
 b=OGxM9ELG/j+HA2mVuqVBe4PjBc3R5j6PVctDh9dbpP5GSwj/xERwskGF65AiMQCNxE
 5Zsdv76RxEjGcGP37YQPnu5Bm4GREG57SI6QHBHXDwz+lFFsuGKNuKSVz+Spg7hjuPxV
 81IF2hr6C7EOfzcXxGm8yqRMs5Dg2WQiCSv3x/imB4JLsheSSpwbEMDKFOR34Ewpdcql
 CKI1WQhjtSo9vT9oFZvOBHVSzxs5m23NzrUjRh4vRchj9evI0LJ8xZceM4KtVcJhh4Xo
 pMkjWtiqnES1FOwp7IxEWPs2H+Pm0pAC0I3PInhRpeyeUQ+6ngkH6r5KfS7yEZC1+Vfv
 3Kww==
X-Forwarded-Encrypted: i=1;
 AHgh+Roq9G8lNe42gAWFrNMPLf3vVegAGAzza6ATtzwscy8NUBy/NxCqK2Y/PcRmcimSfvg3HRaaD34=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YzG7xp96qdbQgPvZskhbo2QTHHqWIHgYAq6l94frhKCMpsH+fPi
 6ac0cbdocziAeLbl4+/EXuvVCn4pEzUsLDzOPa3yhJ4cVvRGwHRMvr3RGbqOv7cLmq4XJblMk+4
 z2qqG9wQ4H3HWimamNsRMr0vHuSi0LsIJ6sV8ltnW
X-Gm-Gg: AR+sD11j99MRXTstryMW8SJB0mgOakq4Wa1dtZ9F/croODSkry3tIhnE6PO/kFjxDuj
 pTH1E97INspRlLeKp6BZb5mcFnC73Vfx+XLhZ50UXiGCUhzM9wFQP99zDQwyriZkBRFQZOtLBp1
 DeKfoI72vpKt+p/KdykkTz2CJ7Yyc+2PPdFNtGgDJCQXzou7WP2mSvi/YPVxz5o40jLoNfNwQta
 BK8m8C7DESZYk9uzwYRa+pdy/0Z8Xufq64KhBDwYEeVJxI8NTdhvNTAWNz3RTEkmroxAhySooLd
 I4i+bAf1MtVYlG3zDZekP4zqPmU1l2mdPLsO8fHIBaqw
X-Received: by 2002:a05:6402:43c6:b0:6a1:4fc7:94b3 with SMTP id
 4fb4d7f45d1cf-6a38a8d646cmr4371560a12.1.1786742605131; Fri, 14 Aug 2026
 14:23:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260814-imx93-secureboot-v1-0-0c3c78020d03@bootlin.com>
 <20260814-imx93-secureboot-v1-2-0c3c78020d03@bootlin.com>
In-Reply-To: <20260814-imx93-secureboot-v1-2-0c3c78020d03@bootlin.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 14 Aug 2026 15:23:10 -0600
X-Gm-Features: AUfX_mzWydBvnCgoeKl87TAAjOp06phDO9npKCVDCBbkAle6m24dQ9QJWVbxWSw
Message-ID: <CAFLszTjT-8PAzCDyh9FMDJ8jbdvXypBGbJh73qXSzMmO_EC3bg@mail.gmail.com>
Subject: Re: [PATCH 2/5] imx93-u-boot: wrap SPL and U-Boot nodes in a CST node
 if AHAB_BOOT enabled
To: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Dautheribes_=28Schneider_Electric=29?=
 <jeremie.dautheribes@bootlin.com>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.u-boot-project.org,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Stefano Babic <sbabic@nabladev.com>, 
 Fabio Estevam <festevam@gmail.com>, Rasmus Villemoes <rv@rasmusvillemoes.dk>, 
 Denis Mukhin <dmukhin@ford.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>,
 Alice Guo <alice.guo@nxp.com>, 
 =?UTF-8?Q?Krzysztof_Drobi=C5=84ski?= <krzysztof@kd-solutions.pl>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marex.vasut@mailbox.org>, 
 =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi J=C3=A9r=C3=A9mie,

On 2026-08-14T17:07:09, J=C3=A9r=C3=A9mie Dautheribes
<jeremie.dautheribes@bootlin.com> wrote:
> imx93-u-boot: wrap SPL and U-Boot nodes in a CST node if AHAB_BOOT enable=
d
>
> In case CONFIG_AHAB_BOOT is enabled, extend the binman image description
> for the i.MX93 platform with a CST wrapper node. This way, if
> CONFIG_AHAB_BOOT is enabled, binman will be automatically used to sign SP=
L
> and U-Boot containers.

The two sentences say the same thing. Please fold into one, e.g. 'When
CONFIG_AHAB_BOOT is enabled, wrap the SPL and U-Boot binman nodes in a
CST node so that binman signs them automatically'.

Reviewed-by: Simon Glass <sjg@chromium.org>

>
> Signed-off-by: J=C3=A9r=C3=A9mie Dautheribes (Schneider Electric) <jeremi=
e.dautheribes@bootlin.com>
>
> arch/arm/dts/imx93-u-boot.dtsi | 54 +++++++++++++++++++++++++++----------=
-----
>  1 file changed, 35 insertions(+), 19 deletions(-)

Regards,
Simon
