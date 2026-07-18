Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A73CC4451B
	for <u-boot@archiver.kernel.org>; Sat, 18 Jul 2026 00:08:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D568C84119;
	Sat, 18 Jul 2026 02:08:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KDqPtYrP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74CAD83314; Sat, 18 Jul 2026 02:08:02 +0200 (CEST)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40CA083E76
 for <u-boot@lists.denx.de>; Sat, 18 Jul 2026 02:08:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-43bf9548df4so4317406fac.0
 for <u-boot@lists.denx.de>; Fri, 17 Jul 2026 17:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1784333279; x=1784938079; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vnqSD5LndgcqQ9r0rg0RailG4b5FAA/u6aol3njT4mU=;
 b=KDqPtYrP4d15jV5IpIubUMR0TgrTPxBaETcoQP3nJJA1weF4j2U2ZRh1TDQ90d1gqh
 XKaHoy3FWdrpCQo/7LyEynxzhr9B9up4066nF4YUbDv0+z1XWnF074mOLE67MLMZOX2A
 mYVAoYrXsC2Yen+zWnWqdl35mS8a3d8dIpxhM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784333279; x=1784938079;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vnqSD5LndgcqQ9r0rg0RailG4b5FAA/u6aol3njT4mU=;
 b=jLPKnVdsVn39lZ3Q91Wk8g16vNqIfAobx9wqPylW9HdgBs0+xSnWwJ65iTxrJUXbdp
 VotW/qr7SJAcp50Kf6ami/OaCiPcZSu5IeXykzwebnGWGRMToRi49Tw3QcQyv/8Z1CR9
 32fV1NChZcqUXrhlBiCAPzi266c2uB7FD0boCBz6pBJ8Ko0kPRnqhIaimZBrlKlxH+Fl
 1L5Rb5DBQD3Gr/Mt3qp4T60IiXBnDF/lm4HqH027M5MXszxSRixacaWl2rKb3NST7R/L
 aoWKgqf3wXLb0/2Hoyzy0rISJjyRqnXxfYZuy05O+8HssMqc0kq7bZ7QQlV2EPYLEyIo
 txag==
X-Gm-Message-State: AOJu0YzrL67bFjSQonzWtnkIIEXMK2I+UO6BCcqzRq5hm0aInh9ACus+
 OASOAesrhY43B2S4eIw6xNlNbwVspGVwHOYTsyiTENtnFHolxBneC3n8pVH3l6ySM8w4sGUS+MQ
 v+jNuEOg=
X-Gm-Gg: AfdE7cmG/NrhTYNU62j2j94SEcSGkyDI8xZgcv0bumJ6Wfst/laYJFTTr9LIvo6YKWF
 HKfkdSGlgkssrAV3Kz64hz99OwLE4y2mVesY/w6wdIv1f+rgWO71+iOBPVDKSBmcYeKy3vUkXx6
 yvsZwqsmmivLvWcx9AzSMbIMfG0f7l8gIbGCMU3UgSJ+Mx6519i3R/Y90yw5B1gkh7OxejHWgOo
 EimfQCIYH3HOmqFw2QtqP/p4WzecVqR0NPu6XFc+QlUeyZRVfiRnPPX39ijAD6g4fvH//LXSPOc
 u2kxH6OUS6jQjv/QS1mrBivaiUMwyUsw435IB76IH3kKljAi8vj/AsuH/CwWT1mco6UQx/3gAzB
 1rxW4PZIprO9cl4XWvys5Qu5gz76eRVL71V3VGXjSeRaPfEkxudB9sbCRtPvMEm23cJEPqSCKfY
 jDeiU9ZQW54HhNcv0iqlE8BGXzd6nPOtxlXLq/kyRjHbl8fP4dHS6jrObjYXhImvo0g0rYBMOMd
 a8aAobkKZHP6RK9dvOldL9hKQ==
X-Received: by 2002:a05:6870:a7a9:b0:448:9052:f436 with SMTP id
 586e51a60fabf-456908c1c6bmr3024575fac.8.1784333278984; 
 Fri, 17 Jul 2026 17:07:58 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-93-175.totalplay.net.
 [187.190.93.175]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4568e0be46asm2275893fac.2.2026.07.17.17.07.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 17:07:58 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Wayen Yan <win847@gmail.com>
Cc: u-boot@lists.denx.de, Christian Marangi <ansuelsmth@gmail.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Lukasz Majewski <lukma@denx.de>
In-Reply-To: <178348762707.85793.537680021676357783@gmail.com>
References: <178348762707.85793.537680021676357783@gmail.com>
Subject: Re: [PATCH] clk: airoha: fix off-by-one in clock ID boundary check
Message-Id: <178433327810.1719219.3263568618210059570.b4-ty@konsulko.com>
Date: Fri, 17 Jul 2026 18:07:58 -0600
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

On Wed, 08 Jul 2026 12:06:08 +0800, Wayen Yan wrote:

> The boundary checks in airoha_clk_enable(), airoha_clk_get_rate(), and
> airoha_clk_set_rate() use "id > data->num_clocks" which allows id equal
> to num_clocks to pass. Since data->descs[] has exactly num_clocks entries
> (indices 0 to num_clocks-1), id=num_clocks results in an out-of-bounds
> array access.
> 
> This is currently not triggered because the device tree clock IDs are
> within bounds, but the check should be defensive. Fix by changing the
> comparison from ">" to ">=".
> 
> [...]

Applied to u-boot/main, thanks!

[1/1] clk: airoha: fix off-by-one in clock ID boundary check
      commit: fdfe2ec48d5c1c2ed03073d73edd3fdd3fe1ffa1
-- 
Tom


