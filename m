Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50D1CF94CDC
	for <u-boot@archiver.kernel.org>; Wed, 22 Apr 2026 08:10:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0533D83FE9;
	Wed, 22 Apr 2026 10:10:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="BOTDpmLD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A643684178; Wed, 22 Apr 2026 10:10:10 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 99E0D83E76
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 10:10:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-488e1a8ac40so64470295e9.2
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 01:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776845405; x=1777450205; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ny8SbbHD8feLmBSX0Y8lmRPduhAaOnZhJGrj6Zr63ac=;
 b=BOTDpmLDbrjTMnhVAWkmhNxoorrSEMxyTpiStiSIXyDha5ihEfMLwfSL+XUv3tJ0iI
 0auoQ69JlwiCBNdDxXY9sMJJqekvFyWX5WrR9ze76glym9Ob/yjTh0UfjEiQcG31iFbt
 lITN+yPyfs/0kfr+hXWzmRewneUkvlONAOJr7RbUm5bqBzqI5AIXAdWeSTF7pUVjowai
 EcMe6b1BqBS4ScCQjl83zKWpeT8DKtm5XciR5aeykPO865AekYH1hwnGrKM4FWOvpvw7
 s3yWbkJR6reu80HRczMtw6mRKuHx+ZWHsG5m/WzaW33sYgu35/olUCPvklyee1awcnzl
 TI2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776845405; x=1777450205;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ny8SbbHD8feLmBSX0Y8lmRPduhAaOnZhJGrj6Zr63ac=;
 b=JMeZsIPgu35z81cF6hAMWIj6RQOr0GWTsjE7uwdE5SGrOQ4e0+kOH8LCukaLs/Bbw1
 FAR9JTV3uAlvpWrRbF5Nkt7pD8+CsOL0Y3KnbbTu+D53cmDzrhfPweV/9yfOARfBaHmM
 Vs9kNXHYsuy4QwRODgVuZBxKK3pwR7l7jr1EtcidaMd+3/w9o+j39tX/+0rPxyoYxXuE
 0mylRHjwBGxAv0bgb4+jFcVEIKNyAtg/5tcq3W3nhaveQOMN1J5O9+pPWNoX8dgA32Ke
 pk5nOzrmGcip29O27dWwzt1CwU3IrNsfaxoKmW9gHGU8ZrDAuGB5BMBkUrtP/0ye1t2Y
 q2dw==
X-Gm-Message-State: AOJu0YyKjZ+lLXDmo8xpZ0laSMDc7sFap5v2K2hzmaHaF+Zh/lp+mXjq
 7yMnudTkvCUtmA2nqH7vwdsqIctAAiGgPg2S6U4kO24k0kn+nE3NUWwlpSBNE5caufiNOh73KiE
 Z9duTXJQ=
X-Gm-Gg: AeBDietmnQnd76H+C+tbzO2zvUZKIi07h/t5pts0W7OndmJxoDAOXu9U3bl+xEFQ/vI
 mKJ+MfH9lW85p69a8ELjl61kX/S5yBUe/G2iZcz5JN4f1D/YJGZl63Jitaomf055kleVkOq2tz8
 IPMiC/a16L5s+bOqWXo+Td/jwefph5zp1x6e2G4mw3Do5mp8r47h8MdgBxVrWhni/dVdBCgBW58
 BdirzCXjQIshlFb3w7cx0XUDh8jfQIYjnWZe8c2ZN2qLHBr5Wm7h7aa67c0nzDeQjwWtA79XwEV
 3kHJ0Jp2TUtfPn6blJmzYep5Kun9UOdK3zcnM94YKA5r8hIRy8xHOoPkwrwbBwF4JZGsxpikks7
 1Gbs2LU9yiPHOqRdN2vOZYcSfy9oy4P0o/C6WbTn8hivJWv/DDy4JHdSi9C///wZME8kLEKlAtY
 AKTjfaYd5Ygo/FaKATKyEoZBd6DlX+T5sAHGbnBMASqlZDll1w0UHkPy4=
X-Received: by 2002:a05:600c:797:b0:489:1a3a:9e45 with SMTP id
 5b1f17b1804b1-4891a3a9f38mr114578775e9.26.1776845404753; 
 Wed, 22 Apr 2026 01:10:04 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc0f8188sm453974945e9.2.2026.04.22.01.10.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 01:10:04 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>, 
 Tuyen Dang <tuyen.dang.xa@renesas.com>, 
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <20260415215837.448867-1-marek.vasut+renesas@mailbox.org>
References: <20260415215837.448867-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH] ufs: rcar-gen5: Update line reset configuration
Message-Id: <177684540417.2674178.12661677518777822561.b4-ty@b4>
Date: Wed, 22 Apr 2026 10:10:04 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.1
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

Hi,

On Wed, 15 Apr 2026 23:58:08 +0200, Marek Vasut wrote:
> Synchronize line reset configuration with SDK 4.28 parameters.
> These values are programmed into the PHY.

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-ufs (u-boot-ufs-next)

[1/1] ufs: rcar-gen5: Update line reset configuration
      https://source.denx.de/u-boot/custodians/u-boot-ufs/-/commit/1089ed95f54e43ddbbe19712b69d9ace374e572c

-- 
Neil

