Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58C2EC44508
	for <u-boot@archiver.kernel.org>; Wed, 21 Jan 2026 20:49:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E337839D5;
	Wed, 21 Jan 2026 21:48:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OsOLKzmu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80F1283B27; Wed, 21 Jan 2026 21:48:48 +0100 (CET)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B8DF83A3B
 for <u-boot@lists.denx.de>; Wed, 21 Jan 2026 21:48:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7cfe2a6bf81so120307a34.0
 for <u-boot@lists.denx.de>; Wed, 21 Jan 2026 12:48:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1769028524; x=1769633324; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YpeWicXTgdmLUj1kDi/LJ8ONCUBhl0zHgfV5ciPm5Rk=;
 b=OsOLKzmupzf9Wrm0rscrR3ttmU4vzdq7o0/HPRO9IDDiQ2mNydL1BzcUBj0oGK8u3Q
 /XlZJ3S3Gs/1AIdAXclTfaekqgS0N9NP28V9V1i2RDsC8vVPEO/JiLMp5Rta5TOIL953
 vmc+XmjIJCO+l+aZKDYxIiwsZgHwWSA+v0Ulc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769028524; x=1769633324;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YpeWicXTgdmLUj1kDi/LJ8ONCUBhl0zHgfV5ciPm5Rk=;
 b=SvTI0x7N6WxVfdrq74G+ZSpRRKAoDqYZrj63SJMCQcZXPiCVIoAQ37Hq4FCPuoTyeL
 O2iKk/MoJduFDqLU7SuD6yFCNOkov4Nh6XfDJpOxURajtIc+jU/QeY/VHl/KV9/+tH1N
 P1Zh8k5sOLg3EJHF9VS2UO1mVaEtPJScBjc/u0M7+20Ubk6E4sdLUKnIcqLXgpmdo3Cn
 JJ9PfMJ71vptreER18pfUpr35gXsZirv+2l4HxjOBpg9TK0q6j9olupq8twImNyh8hO/
 a/jGwShvrnG+VUe5OOVk+ZXdwHh22zPu1tghW0MPDcjVrJfNwAf2R859dmPOn8Qtt/zs
 Hx7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYBSh+v4jNxlztLGrcstI3naFVQvw5w80oFy4yDDKkJYbPMk6lyIUI4pEJSdUjvuM4tyOW3Bo=@lists.denx.de
X-Gm-Message-State: AOJu0YwMEIJLndZJ7NQjaFGy26DnBvWNyQjT2inPEfi2qQ/TW3Em47N+
 onuJrTPf6mdlduxnOIc0vFnADKfJB7K53LGx+rf9a+UlbM8W9bqTSxDE2a/uGJYdKjc=
X-Gm-Gg: AZuq6aIzqnLN8XbJfSCPhnjCLdVQLnVzOXN+rFwbgSxCQ9BAUtXMz6qHi0Y+FDQFIa3
 6OrfXOwPtXa0VtltoEaQC00qKLXqSwddEQh3RD42Ydr0wwpvRA2luHjqJzeX6sNbx4nsptMMah3
 2TR5wMKjWg9oYTtErnjqHyCBazV4Dm4EukIk09LkCnTtPpIGmjcwLmXsiv3HTzwmv7/dtLNEmS+
 KojVB2q7hBV/xEGgSob6lKeOJziDejlMg9dpdbmr1L2yaq5GyWE+NrnX9KrV9JNiwLZbMJQLcRv
 LZKndb/7x7U2G6cAHrito64le2VhJJ/KErWrP29OlhRahD4yaaeDWjhzQtZ7dynOJ8enaHFjfeW
 tIt5VqHIkqtTsb1l6o0dlHNn/mrRCvpxvT/cHl5HVIhjxsTPW4jTVnm+moWK03LeRO6sd2/K2JJ
 B4H5F4ofEqjrTTjgbQxY39ansZ+8IPSLzDTUD64dkHPS6izktusOBf8k14I9Fgvd2dS+8Ihk62c
 tdumqlS2c5kzthn9msVfusDPIT0kX8EsTtBJg==
X-Received: by 2002:a05:6830:6ac8:b0:7c7:565c:4ce0 with SMTP id
 46e09a7af769-7cfdff679e4mr8160680a34.1.1769028524599; 
 Wed, 21 Jan 2026 12:48:44 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cfdf0d8e05sm11134487a34.6.2026.01.21.12.48.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jan 2026 12:48:44 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260114-fix-typo-in-cmd-pinmux-desc-v2-1-a378150e4ad3@baylibre.com>
References: <20260114-fix-typo-in-cmd-pinmux-desc-v2-1-a378150e4ad3@baylibre.com>
Subject: Re: [PATCH v2] cmd/Kconfig: fix typo in CMD_PINMUX description
Message-Id: <176902852347.661474.5324519606207656536.b4-ty@konsulko.com>
Date: Wed, 21 Jan 2026 14:48:43 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Wed, 14 Jan 2026 10:10:46 -0600, David Lechner wrote:

> Fix typo with correct spelling of "purposes".
> 
> Also change "debug" to "debugging" while touching this since that is
> the more common phrasing.
> 
> 

Applied to u-boot/master, thanks!

[1/1] cmd/Kconfig: fix typo in CMD_PINMUX description
      commit: 9fed667f890fb6bc7a1928cb85509613dd3dbc24
-- 
Tom


