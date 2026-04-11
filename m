Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18202F3ED4F
	for <u-boot@archiver.kernel.org>; Sat, 11 Apr 2026 14:38:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79C07841CD;
	Sat, 11 Apr 2026 16:38:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Fdu+VxEW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D75DE841B9; Sat, 11 Apr 2026 16:38:29 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5E9A84118
 for <u-boot@lists.denx.de>; Sat, 11 Apr 2026 16:38:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-b9358bc9c50so409058066b.1
 for <u-boot@lists.denx.de>; Sat, 11 Apr 2026 07:38:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775918307; cv=none;
 d=google.com; s=arc-20240605;
 b=Hh4cLfytK55cBBd0ZP3wXT7hTmONz3U7TAiaYJJQAG5Oz8B3fn1nsDuJpM9+GC+bOt
 JpioIu2N3ZXWRZnjimZ/E+N7LLAxmNURtUiIYiFZ+y7JLh+wMuY+JIwKP9QZ10G2deny
 raj+RZvfTEvk0EEm69oKEFIuPhgeDhkLQbulv6kZLe9s1/XBkMQP4CtpFj7Y2gi91J/+
 zKuhPSRErFq+ZvqiuMMMQUjr28rB6fNbVSC3DltgxrulTnjtwXxbdwo5R4v3foX9oWas
 M2RZRAejZFZzw8NnQ6N9SyEY2NoFjXnbbyk9Kef0FzS5/MNh0GKTyJbcRTGf3gWun6Y7
 PJTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=J1kTB9xvYtTFfVrIiHdLA9cok3I9J53flz3HGMyuzRI=;
 fh=fzkA9x94YE5UDVQWJtvPgpPtCZt/HBkqd5rb9Z8l0kw=;
 b=jcI+wcT847NejWDHkPCkrebpz4B7nbN6xB51KArXt2aD6/9nEosT4Yvx0zcPCpYwEh
 s2UXo3NtFdHBuyQLh1U1NxLyw05NwW9XAMeR8JzOzNH7eiOX03UeW9kF79T7ioLWcYcZ
 LtHRUaErkmCf1b7/kfab/qlnqyCvnfDm3ULb7M4nVFxLs0vbWEttNVaGZksicXGtpmfh
 Kt5KWwSbXT9cleffJ62SVj49LbMoKvH2t/7xTIN1koP0DcrtvD3ymHpa2Xvpo/hxma+6
 XkXrEB6PAOIIWIYCVKtrVt8nXUaHXI5Ff+2UswLTiffjQROnATilVQOWJcEUz5/AyBNB
 3MVA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775918307; x=1776523107; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=J1kTB9xvYtTFfVrIiHdLA9cok3I9J53flz3HGMyuzRI=;
 b=Fdu+VxEWaolaaayNvVvQ8ATyK68mx/CfixPjw9D95cDZHTTIUUF0gO3Kr1Srzlhc4i
 rZLKfX8AoMfJRKfRyi+kxRRw0ARLAu3iwC9ftqVHenQr5OfDyDgxNHYrs0LKqrAFFZ5I
 3gtYZxtKs2DRC/OZ4Z0Kwjs3Jwh0NvlFOFbHg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775918307; x=1776523107;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J1kTB9xvYtTFfVrIiHdLA9cok3I9J53flz3HGMyuzRI=;
 b=AbMYkyQuhE+nlUOBb192z/l7z6ynwyrg43XRaDfdcFapcnpGkBou7celhzhFuiaD99
 +rbcRUTidqQyd42nrA1sN4xZ+tVPnYppxdg84eHMTRJzKSTxevS0YAmMaw5jJbg58HLH
 w0LPGKD03nsu9zntPtZ7/9+LNJLazqFSfzGrRlcYpnghW28JWZkIujG5VX5fRW7i2JDH
 dYfFJTgkylVY54N4Ow24VplU0pHpfZs7npG/ZLBFQFFs1FlfTvANjwskK0r08AZ4PoL6
 9lo4lxbTjgdJoZN1+uWGRaVHE86dzY8WEt2NWD7+0WgWeSWQxnm75ruokNnXudIaJ+op
 stQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7lioE0Bio17Fm0vMcl02JIRDUUW1WyHninGG6NyMw70sn1DYickKowc+oZX+9te94bwj0Tv8=@lists.denx.de
X-Gm-Message-State: AOJu0YyUscnmh4ORwogQwgZl+zSnvN3z9+MTmrrod6K2RdO6AnI9O8w7
 01IPy7hAOKaF8nd06jYdbh0/Ps0jOwHoPX0gmc18lnhacHtLOynvzn9I4C2HiV6ysHpq5EGzWhY
 it6Y4lGAOolwmMYGh7bJxfO0A8lvxsV9uojGhGlxx
X-Gm-Gg: AeBDieuPpaV/kRsPQRePBd/L0fLTBNLSuMGyjV50RS8d4qhdKIWj8pQoI5kEH2kF1iO
 eAM8zjVgd1A5GAnsyk2z3nnSnilxTfUeZYx6r+efK/C3FK2yCTzUYEXRv2jq3jsfBN3Jgo/wqUB
 tPY1DoVX3SDKnWQkf1XzIWKW22tYuSARbivlA8aXhcheklK9yXRFFSs80H8TJb4nibCTRo6Pe7N
 LN3rCp/Ki9rHW1doDMC2xf0ccvj1mG+DWkeyfn6LkM4s1U23bS12+Fph1ylyqmVhJ1a1dXXds91
 mgtiTzyhIeBw8s/w
X-Received: by 2002:a17:907:9608:b0:b9c:b88c:6364 with SMTP id
 a640c23a62f3a-b9d7249921cmr396245566b.22.1775918307232; Sat, 11 Apr 2026
 07:38:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260405144944.41074-1-lucienzx159@gmail.com>
 <20260405144944.41074-4-lucienzx159@gmail.com>
In-Reply-To: <20260405144944.41074-4-lucienzx159@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 11 Apr 2026 08:38:15 -0600
X-Gm-Features: AQROBzBNZ3cqyDAYb-9gFor1Xqlja2pWwNp3HqCQEm0vZADHp4AvFiSSalokJro
Message-ID: <CAFLszTjF8L0+xcuZBRpRfXL1oLRZQCRJtQ_VPnnjq+Pn=P_-Vw@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] test: dm: add PHY common props unit tests
To: lucienzx159@gmail.com
Cc: trini@konsulko.com, jerome.forissier@arm.com, sumit.garg@kernel.org, 
 marek.vasut+renesas@mailbox.org, vladimir.oltean@nxp.com, ericwouds@gmail.com, 
 kabel@kernel.org, frank-w@public-files.de, daniel@makrotopia.org, 
 ansuelsmth@gmail.com, mkorpershoek@kernel.org, skylake.huang@mediatek.com, 
 lucien.jheng@airoha.com, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

Hi Lucien,

On 2026-04-05T14:49:40, Lucien.Jheng <lucienzx159@gmail.com> wrote:
> test: dm: add PHY common props unit tests
>
> Add obj-$(CONFIG_PHY_COMMON_PROPS) build entry in test/dm/Makefile and
> sandbox DM unit tests for the PHY common properties library, covering
> rx/tx polarity lookups for all relevant cases:
>
>   - missing property (defaults to PHY_POL_NORMAL)
>   - single value without names array (applies to all modes)
>   - count mismatch between values and names arrays (-EINVAL)
>   - name found by exact match
>   - name not found with no "default" fallback (-EINVAL)
>   - name not found with a "default" entry (uses fallback value)
>   - unsupported polarity value (-EOPNOTSUPP)
>
> Ported from Linux KUnit test:
>   linux/drivers/phy/phy-common-props-test.c
>
> Signed-off-by: Lucien.Jheng <lucienzx159@gmail.com>
>
> test/dm/Makefile           |   1 +
>  test/dm/phy_common_props.c | 319 +++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 320 insertions(+)

> diff --git a/test/dm/phy_common_props.c b/test/dm/phy_common_props.c
> @@ -0,0 +1,319 @@
> +static int dm_test_phy_common_props_rx_missing(struct unit_test_state *uts)
> +{
> +     ofnode node = ofnode_path("/phy-common-props-missing");

This patch references DT nodes (e.g. /phy-common-props-missing) which
are added in patch 4/4. This breaks bisectability. Please can you
either squash patches 3 and 4 together, or swap their order so the DT
nodes are added first?

Regards,
Simon
