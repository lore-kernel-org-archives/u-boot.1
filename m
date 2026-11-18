Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C105606A31C
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 16:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=YTFiULzx;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=jG/coI8s
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4024140807;
	Wed, 18 Nov 2026 16:20:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dPRxay9zuLaI; Wed, 18 Nov 2026 16:20:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 927784069D
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795018855;
	b=QEaGXBcQPjT3jIeouHokJ2k65dQ8W+0xAcajcbTUXjSt4VJXVEOIb1ky04V+8ymg459M
	 MBUdHNXoddtoCb4ZMY28TGhj3y5yreODC+/ehNXr3jCWRycFphLbJhVvbjruXS1U7s69+
	 7fTmcdZCBTRDF/MbWMraXaKtE8MdrxPD3wb+ielf7koijS0dW48X6dy+6076lPPu4eeEg
	 rm3+8fUTd4GJGyhF30u0GQDVAaAGSSvgwAfO6TsAWV8p811v9BxADqVcGO5OgesSZuBHQ
	 Cam1cxmHXsBYuhbslwbxUCYp40nEUc+vKD/UEhrm+HdT6mn1zzBaq7ZEiJPuXW+/WXQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795018855;
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
	bh=cqG5ModEtfdGf+lbD0LgMWyafoCWwKcW4cTnLmDwu54=;
	b=UCmmtO5m8fFkrG4cxvKQrqY8NETrxdxgRG6qIMLkgc0SUy6g0uiUfBnYOssnj27yaFY1
	 uR9vY4UbacBLtpKP7PZvn8yV4PcXkqqQt7olyljNg5WiWi+zEFZpO7nwXwrR/Uujp5eCA
	 t9jKLiJExv7SZ+rqfbZ5p4IO3yxIsPp2DEs4uQ2E1MNj4Ch/JcSTILm7bA/6NjUx8zGYt
	 4cTCqm6sRwlBJx15olqbe2Jr4vt7MLKvsGmM97ge/N1CAwCMnCPZ316XcX4u28b8U7ndY
	 XGhOwftSY3HpDzcWNvtFWQqFIhDtxy2KnCbfG5DIQvtl13c8sO7AIJGOMbYqcZCcbeg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b="jG/coI8s";
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795018855;
	bh=cqG5ModEtfdGf+lbD0LgMWyafoCWwKcW4cTnLmDwu54=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YTFiULzx13DKpimUkDFV1HM4grWQnMEJczuGwc1D9WN+lhObiqvf68H1CcqQuZsHd
	 SKgxwJysyeONM80yk5RZaMMPr7QOIkMvOFKy1QDqIOZ+Q1OMY9D8FjSZeoEJI+HuB0
	 xf2rwodDwe81Rc2MI3M4wwQa+da3QCPCuFlUYvoxQ9XkBW5bK5ONyxg2mxdz4TWWMo
	 q3kfk1W+G5ufX5uetMT8Jau6adEfarHbSIXQyMwLX/Pmiq1iK0I7cT9UlZMknQk5y1
	 vzX+TGcmt5dCwU0fZfwEHVBcxAcOsoo+9dwkHWcR8m7MwnKUuhSZMk5OCrlxCI5cZp
	 wlGdqhRgZY47Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 927784069D;
	Wed, 18 Nov 2026 16:20:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 7535AD33
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 16:20:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 66EAB4069D
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 16:20:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TIdsenVGLh3P for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 16:20:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6A92440215
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32b; helo=mail-wm1-x32b.google.com;
 envelope-from=glaroque@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=jG/coI8s
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6A92440215
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 16:20:48 +0000 (UTC)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4bb6adaf0f1so11223775e9.0
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 08:20:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795018847; x=1795623647;
 darn=lists.u-boot-project.org; 
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=cqG5ModEtfdGf+lbD0LgMWyafoCWwKcW4cTnLmDwu54=;
 b=jG/coI8sep+mQZgqKpV/YJK4ekYaTSq7ysv9OBSFtP03G73uWOD3W5Nm5yO5EUFlZT
 e/6B5pRHwIQc8Q8dH3cnhVeSvlMAPRsKAnQ9GcICsupCAaMWh9i+oLmt4HW4jh7wuy0x
 ixHY76yd038te7gxNAoGtKxm1alm+zTiFD2HODsBVoOj+gICRfysdM2DuRLTKWLp91Jj
 JHdP8/ZlLQecp/xKUHTlnSI9TokRKoQzHAl/JW+LLsBx7rOxX8AHthQK4YDcAmGXVAEe
 FEWdG8uWpg3Q8WTew0vQ25o4Lo2uzNnELFOisI4MZKvSL6IqiTBxCJ76dfXFK5Q1WOt5
 B/Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795018847; x=1795623647;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cqG5ModEtfdGf+lbD0LgMWyafoCWwKcW4cTnLmDwu54=;
 b=pYNY9KSSGiDzmg4/xGN8Gv7Y/O2Y5ETEMp8xna+MyKNoKEr81j6QzKUY73kjigXMyH
 czjMML6/JxVl3YNE9xeZ28YYe+pAcj7/r/KrinldnnSu/US0WFqm2A1wN9JZzav5nPUS
 46gh8ea8jwkNv0Ch45uSaVLMogsdyZ4PIWW4z1CRc+jj1CDMO75PuIEmz4MJk1Zup2gD
 F1Qh8rItU2ScoKvP7KnYk6er7IQnRWLToYZIz2+stM83Nf2VAOum/p7P//P4uRqJ+2W/
 FP4PpffTkebjSDCES9Ud7hdrZU2443RfUCEvvcxinRDH51eC3RVZNTMjNqLLaA6oAb9c
 9Pgw==
X-Forwarded-Encrypted: i=1;
 AL+hErFYiR4jIn1Jl8lM95JV7tfozx6sBXTqnJORVtG12136XuLztD9cDnExO68XPc6TVJ7moOHLbFs=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9bqGMmAb3C8c230p6okxfHGfXEe05GiR5GLsL+nm2zsVPvbgA2
 rgxv9nC9FU1dih4gcuOOq7gv5c+jqzOJrBU9+P53LVGcivzgzXT56q++hnXK26jeNyw=
X-Gm-Gg: AYBFou3g6phdRpcyCjhqQ6cfTO5Bp5URqBOz/lqTVh5ddM8eqoVJSmoJ2CK/OMxGnRV
 oyh+iqskAeN0l4W90v2eEZOEOJQf09qiVcsHdfj9klfgWhLAeOTimWVlF+FFu6FovCRmPTV0Je4
 wR1P6KQP25ucuxW0RwkWTTh9AmhsrKP4iaQ4EFwjbQCTOBkUjClSuh7/qGqImqy+utzOkAHxi9Z
 q/a4F7GI4TWbcB2zvw7elngGdt8gLCgE718IrqaiqfBuNGTe2FmTfCTKE8fI3F1XXFk0eJPDbp3
 dd6SQp0FwRt130WUyrf1solWhcOMVWQO/3RwPzrhv48HxhrD/RPNO/r9N1UPnJfvYEVY4YDwxiR
 SEsCU9+ytEnuwiqYa00Q5cij/SR1LoHkcvLLsMst3WkJs+mvt1bRi4SzA0hzUwGYyZV5dPODwjb
 0+07mQ6y9k5rlJXSuKoaBPkn7eHa7qDAKbdmEZ4jeErDqY3vsiIBgM5v3z5AWc1pNTDazxTUJjb
 MYAroLLgEzSYhibuIuqR8hBwjuEiKwcJoMRY5DXxZMz1JQy6BDfBaL0dRuJzwUhT0PhI1D1wrUi
 Qk96tLsRQwM6/SHQ6EeoFUWHsrxpUHOYRjvyeDIhBea68tenp6k=
X-Received: by 2002:a05:600c:1396:b0:4bb:6f45:2a79 with SMTP id
 5b1f17b1804b1-4bb7da1b78cmr58900815e9.22.1795018846945; 
 Wed, 18 Nov 2026 08:20:46 -0800 (PST)
Received: from [127.0.1.1] ([2a01:e0a:e50:3860::e1d1:d182])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a650d2efcdsm5537874f8f.5.2026.11.18.08.20.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 08:20:46 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 3/6] fastboot: Add GPT/MBR partition table flashing
 helper functions
From: Guillaume La Roque <glaroque@baylibre.com>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: Guillaume La Roque <glaroque@baylibre.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, u-boot@lists.u-boot-project.org, 
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>, 
 Tom Rini <trini@konsulko.com>, Carlo Caione <ccaione@baylibre.com>, 
 Dmitrii Merkurev <dimorinny@google.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Julien Masson <jmasson@baylibre.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>, 
 Simon Glass <sjg@chromium.org>, Sam Day <me@samcday.com>, 
 Francois Berder <fberder@outlook.fr>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>
In-Reply-To: <20261115-fb_gpt-v3-3-7ddd7ef832f6@oss.qualcomm.com>
References: <20261115-fb_gpt-v3-0-7ddd7ef832f6@oss.qualcomm.com>
 <20261115-fb_gpt-v3-3-7ddd7ef832f6@oss.qualcomm.com>
Date: Wed, 18 Nov 2026 17:20:40 +0100
Message-Id: <179501884041.2226612.6214790331284661303.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795018844; l=677;
 i=glaroque@baylibre.com; s=20261019; h=from:subject:message-id;
 bh=8YAq5BSmPUt8MwGq0+ugMqnBq1sNMDBrWMbMDMk5ZXQ=;
 b=4bvAK7BeFuR1SUz/L8YfXFXe/J+N/XJOTGk6fwz1ep1LPJ5ry50GIp+BMA8gLb3LFPMNFO5Lm
 dWxTXFmyOIDA+J/PNnXlOVCZetIgRKpfKQ+cgl8Py3CWiFfAIvRQJsu
X-Developer-Key: i=glaroque@baylibre.com; a=ed25519;
 pk=nMpSg4NT6M6q143E089emouMc+MXpHO9CWmnEUfjhjI=
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

On Sun, 15 Nov 2026 16:35:10 +0530, Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com> wrote:
> Move the GPT and MBR flashing code out of fastboot_mmc_flash_write()
> into fastboot_block_flash_gpt() and fastboot_block_flash_mbr() in
> fb_block.c, so that the block backend can use it too. fb_block.c is
> already built for both the MMC and block backends.
> 
> Both helpers take a block descriptor and share one function for
> validating the image, writing it and rescanning the partitions. Only
> the validate and write callbacks differ.
> 
> [...]

Reviewed-by: Guillaume La Roque <glaroque@baylibre.com>

-- 
Guillaume La Roque <glaroque@baylibre.com>
