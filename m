Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE02606A321
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 22:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=hlyiQPwy;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=M/02cghd
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F0FEE40589;
	Mon,  9 Nov 2026 22:17:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OsSbzSnKERws; Mon,  9 Nov 2026 22:17:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5F7C1405D9
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794262658;
	b=o34iygr/q0VyR1fRYSOx5P9N9eJZ02ah7pyfaApbSprPMLvyXv6xsSx0+Su2Kbo/tHE+
	 db/HyghAdFm53IZMiagXu4sHQNKwJnf0jgOXoR5D+ouhU4Us7R0bGeVAIanaQjJKdo9Ka
	 C2HX2ZvVoQjYs8sMZWlinVGiiOltThDmBHx0GWrp0OkmOosUH7wtWwBVGIEp23WH3jpCF
	 WV1jNZvS+ag1DWh6lXgA+D9UPjxCLkTKLtTkpMxFqkJQp08Gp9bvBpB24uKf2XGYuosAt
	 qqNzjTiai+Peu/tukAvXcB2c6VSt/bDTxLRVxiy6OIVe5CflDPerT9A0rL9i00LiE3w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794262658;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=1/6gGtYqVKwHkBT4wzaaMsBdrAD5tBdtMTgJ2VJiYJ0=;
	b=GVZlka2nm20tmXC3TcmOFnoK8TvxCIf/QT70arqD8qJfpV5XZWtbUyMs8A9DY6U9GPBX
	 Pu+3A3rEnObc7kQckOSyhBFhEGnICWzaKrDxa6OBdTghWlYslN9mOs9NlU5G9GXN4oyT8
	 Jj8LlyiQY4kN1BRP2HsBs3VjOJ4MCKK1W8e3N7svIxFFU1J6PC+YDRwDZSgXniIjw4s8Q
	 XQAzjw+giXuQAdPHTr4tC+1cePeStmhxfB8w/RfleD6hdHdljAilnuTUsB9CP+xvgCX72
	 nGiW+YLTOBii3b2Tuf8ibM/OvDOsQIMnUbUVWsbe4idPCiJvaeYfpMM6JviR7avL0mw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794262658;
	bh=1/6gGtYqVKwHkBT4wzaaMsBdrAD5tBdtMTgJ2VJiYJ0=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hlyiQPwymZnmfuj1o1LCndwILQcxRxgTa4xUtAMTnUXWOZJUPGZk1qYwVZW1Mvzhf
	 U6SkZA1ARjZYXoop6RGpEewup0VkqhqC9ap72Bu7mHSWycuBECNkQqopVdHbx3oMHX
	 6ttJ+UlLILfpJ68oqPW5RaxZEBs0MFQrcNFPNAnJwmcyIDxKnAiXITQipbBF3PValx
	 oXIHX9AAUQQQPPoO7L6ddUlTWxa3WBjUPx9tGg1YOL0Gz41gU/QuEfq4bJNB4eSilI
	 bNzV703+WiPK38wW0aY45h4t+2Q0acl3CtIqKFkwcBoLrMkfey7RCxYKqHibGv/0Rn
	 MVlq2TXabMAsA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5F7C1405D9;
	Mon,  9 Nov 2026 22:17:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id EC72BAF2
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 22:17:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D89AA4030B
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 22:17:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aLHLJT7XyIHV for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 22:17:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 1F84B40312
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::22d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::22d; helo=mail-oi1-x22d.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=M/02cghd
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1F84B40312
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 22:17:35 +0000 (UTC)
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-4af81963f35so645576b6e.0
 for <u-boot@lists.u-boot-project.org>; Mon, 09 Nov 2026 14:17:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794262654; x=1794867454;
 darn=lists.u-boot-project.org; 
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=1/6gGtYqVKwHkBT4wzaaMsBdrAD5tBdtMTgJ2VJiYJ0=;
 b=M/02cghdOPXYuQI9HBJnXq7WqOKCneQGyVNcy20DrjvAc1M5FNSrc8gU3asVcETfZZ
 HbzrYHPWo4Om/VMMOLpGs40m/tc64P+yakjKYzIrZZ1LVkESUWkg/QDLqA22hOla6uOm
 50ibsm8UZMRSfZpuJ6Ts0bX+W01pJTXsTbmDeQ01wk1XOrf0Zg0J6oNOv/lJRXPxQcof
 h7VcFaF2sthOqqL2/Yj7w9aYe/Uo9pxIKY2OYY6o70rMNkpbu3F6Ocjk4TSNmmKWUspS
 LspqQ0J7rSKGvClHgUzFDx8fApZfMPetO4VzLmqXjDuAKFihT+e4BQuzPX7mv5MP5zS0
 Zi+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794262654; x=1794867454;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1/6gGtYqVKwHkBT4wzaaMsBdrAD5tBdtMTgJ2VJiYJ0=;
 b=zfmcIaLHGFiE19vqvO7kdslJoaeAW+FGR/v9wYEGVIdIyFuTMv84u8XvmPuPMuR68h
 9W3rTyNHUXswbMy5ysbt+cB9btr/XK1WrObJe1yALujNFIM3lzAZwFhmULK7LC6z8tpL
 7+4+nGKnBzzWv+D8o9RcH5QPVSN7m6moawQ5VQokYChN+I8WrjdXu9Etvn47V2WNx3uW
 h6rYJVWEuthuz22gxnDFo9TIyp3a7tcqM/OtqGDMHfNYJPtA5JNntf/8Y6uyDVfcP8RI
 jP8PEoZ8sCeIb8EICfLR5pb7vU9PrZ2WE/XtqIxP2BmuMH435aN1un4P7xx/FZShHbtO
 HXAg==
X-Forwarded-Encrypted: i=1;
 AL+hErHlNXw3/tCq5p35v+FB4PuqY/mrOlEQdzAm2iCoXdXKHMTHJa6DQ15EvbnFip/p08TsiHJgC9k=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+Wvn15cB94/p7/4L2+Jv4JiaWn51RUdt/oguMoLwCtfHsjfpck
 9rjCRfUfXyJILMOx/pd3etgZbIAQ3Mldf4+C8v5C02q1AbxM408/gGxaAcNBZLFYvno=
X-Gm-Gg: AYBFou3rALiO3VcVJ8ZUwRqAMGqgaTzhwcXPSQYbMK76k6sIFoQMPo71d2dpFYcdPMn
 I8rYsVazzVEaHYIgDiB+WL+ESq3d3CXmlEiS4iGRNfEb6L6ZDsng+hQAKuoQHrqvuQhR446YHBL
 cYTDjR1huRZvM/aC6qofM3uaIR0eFM8u1PPMBVG5GcMvjCxG8DcfMIg1M1IivxFwEHtrhFfOvS3
 Hj6PMrD4O/FFVHO2hCMu+FOA7Fm+B1nRwRuA8V+vqzu/CrWzKvCban2cTJdsdOeOq2o7WLG96Mf
 Tto8lY087w5VfcQGwtQ9HD4XoJuMaAhITAoVWA9D1eH2l4KteB5XhXJXOLJHx1OolWrYVFAfjH/
 X8tu/zHTs81ibyiawrnxpK3isufWX3InpgCAt5C10rVxgw9OV5TebzafyovBEY/2oPQjOJ97qEY
 jys+7vq9yqAcSFHAnES3gGG10ZjYfVJxuCNlRqX507e67U2T4xecAkreTS+E5/DhhI3Nqt6rQXT
 x6WursjU7Dtttx9w+T6P4HG6p+9wWx4sewZjP6bml9vm9KXUpqicc+KiYZsq0qKjuxkMEUVBzxN
 H+oODS1HJ/eoa2ZbpOMw+HkV3WW+czelQg==
X-Received: by 2002:a05:6808:1381:b0:4f5:d3bf:edf3 with SMTP id
 5614622812f47-5683cad6c87mr748339b6e.59.1794262654649; 
 Mon, 09 Nov 2026 14:17:34 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:e08c:f307:ba9d:b979])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-56905736b92sm440620b6e.8.2026.11.09.14.17.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 14:17:34 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v4 0/7] Prepare devicetrees from FIT configurations
 with fdt fit
From: David Lechner <dlechner@baylibre.com>
To: Carlo Caione <ccaione@baylibre.com>
Cc: Julius Werner <jwerner@chromium.org>, Simon Glass <sjg@chromium.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Anton Ivanov <anton@binarly.io>, Daniel Golle <daniel@makrotopia.org>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jonas Karlman <jonas@kwiboo.se>, Randolph Sapp <rs@ti.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Johan Jonker <jbx6244@gmail.com>, Alexey Charkov <alchark@flipper.net>, 
 Vincent Jardin <vjardin@free.fr>
In-Reply-To: <20261109-ccaione-upstream-fdt-fit-v4-0-5323cbfcc9f3@baylibre.com>
References: <20261109-ccaione-upstream-fdt-fit-v4-0-5323cbfcc9f3@baylibre.com>
Date: Mon, 09 Nov 2026 16:17:02 -0600
Message-Id: <179426262250.3924283.9200402463672862039.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=509; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=VlYhMQ+bUQ9XTvfkAPJp9Roo35OlQ/6x982bbQtCimA=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBq8kZvlz0CgzPZEDWQuDHD948g+eXayVRZhO21q
 rW2B09fDdWJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCavJGbxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AYzUIAJWsmaVYWcToHjTjMC4FQA9u2qmZ+w5P0H3L8GZ
 PKjPKEGrVgYEQQCyWCm4KckeZcN91ooYlE9Xl/6v212WjD3qI+paCE29Xg4l/pvI8WE4in/EHYB
 q9PM8YhiQopJfoyFJ3dBZal5+9chQuuikbepqFXe2pEXc/kBlV6LFtrS3SnkhxkLLcEi3+wrH5B
 45E7YDZg8Xy8qwW1VSt6jqoNNqwoq8Ov9YGwtEebPlupfzEKCfIPDnvn2Rd3shaYTKDPEI77sv4
 EYejaVHPPQJJG5eRidiiiH2bRq2znawQNQ/O34xNPg03avYGElbT+gGIAQ5+aXW8gLifUcmM+H7
 PAaw=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 09 Nov 2026 22:48:17 +0100, Carlo Caione <ccaione@baylibre.com> wrote:
> Prepare devicetrees from FIT configurations with fdt fit
> 
> Some boards keep a base devicetree and its overlays in a FIT, while the
> kernel or EFI application comes from another source. Boot scripts need
> a way to verify and assemble that tree without booting an OS from the FIT.
> 
> This series adds:
> 
> [...]

Reviewed-by: David Lechner <dlechner@baylibre.com>

-- 
David Lechner <dlechner@baylibre.com>
