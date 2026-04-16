Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51A57F43699
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 12:47:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B4D78439C;
	Fri, 17 Apr 2026 14:44:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Fph6xlMP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 138B38405A; Thu, 16 Apr 2026 23:55:48 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3263E83EEF
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 23:55:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=yusufbtey92@gmail.com
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-b9c6f1d1282so6707866b.3
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 14:55:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776376545; cv=none;
 d=google.com; s=arc-20240605;
 b=YJwk6WRvbtO0DRQeer78AhivcR5EfqHZV8mL6OW0tH7GXCPvu5Xdb/H2irFkmBJy4t
 9YVlUlbNFdUxCEjn0IyaurMSx380wUunYhF+bF3Bn313M/x4RtarhCxAW9BX+PxR9pKp
 gAnHXTmbdyRGUW3B3ZYnvbhDjZ3f9Hxj7ROQyiX8P0dYkN3obr0xNalfbsLeC9CRoEEW
 tTGeR0SK85++STjZQgi3T9Cn9rt+QsS/cy1eSQkCyYMaQUIXpnABKFsruzmg4AHMD03b
 935FZj+tar8kooPp6SBcXyVaE0wZEazw4p2cKlEiGJ1uopw1THL42kS+UCKJV2lOBjYe
 q6SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=GabbEm+lkyjid4hCETh7WCMbhuUvWDw/gkHXwzgn3PA=;
 fh=ea3Lb1kmqTyoSSOGd3r79PdCdfQHXBjS15GzGXd6hwE=;
 b=ZoZf+EJCD7wFGjvMtyA1capL6NTOPLHF4smQnCJBWa6Gvh2WUMWWzWGOk5W7lzk2Xk
 rXaI4EVR3Txz0ALIKbyPs4jgINYoqWJMer0m4p/qQv5gWX52DHCtYMCF48B72Z8G9Vhb
 6QvPQ6ZSVF35M+ThNo/YpR1Ho258OPwYq/pbEuXM/WIh6XKpk3KAp2rS5nHYCSUxnPnV
 6Z0OH6V2ojwZM4pSuE2/6rIuyCXx9JI0qugs5XfF8vMr/yW0TwiDegUtxn5WVecE/hz0
 rTMsoR3mN7G5xz6cor9I2uq11fKjYqfIHZFux93DP9cVgtalWJujl6Z6outBO65m7xRk
 d1PA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776376545; x=1776981345; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=GabbEm+lkyjid4hCETh7WCMbhuUvWDw/gkHXwzgn3PA=;
 b=Fph6xlMPDO75zHJV3Sb0pdeaJO3Phmhgdc8/nfgjpAKop37KkW18FZOFL11lj0kQP3
 BrIH4/lA4wnB4Gflt+67lSQnWnVoH8pNHwtmsJNE0eEi4wJrhAX6sMOprBI4GwI4N4AS
 4OH0bYvDgGJ3PN1SHYV/WoN2HpC4RhXsOl2sQxIDlgiGq+QZEavETOCiqXQXY1Iu9GBy
 eBBm3MKBdshkroaPhOMDzff9J5MZUKiaIvsq4kai6waODsk4hkh2QrXMyTMRgecEFFie
 ypQbPcnH2VQpVAAsA2qk5kjaHrBITF9SvomB26HF3GzWtpS+7MJ/eRcZNPwnFPeDWi7i
 inzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776376545; x=1776981345;
 h=to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GabbEm+lkyjid4hCETh7WCMbhuUvWDw/gkHXwzgn3PA=;
 b=QMqB1sz+wnkBIO8ui5bjyH7f/GYtjr1mXC5VbM7f5JzQcrTXepgJ+UfHCtnAWJdiMK
 ItQugjIfxpL1bdwJTnbKlrHh2IrKZNP0Hr3h4jCIN9519EuKOP8A0fppkqdrXFW7mt0S
 nN77sj7ZieXoyx7LyOb5Spsa01B0na7qrwBc21fA/6jcURDbgLT5+q42yQMAYz2xHzYw
 cm3goq4rCU7kGu//c4tCAr1BCElEHrLh7oP6Yx0a56at+/rkH9R59imTqOsfV9vkireT
 CN1soSSy3fEQZfpj8yQmr7mN9Ebve8dhIEYujGc7MgS53iZKVSxU8nkz3MHF0m6EQU+Z
 hNiA==
X-Gm-Message-State: AOJu0Yx3LrJRuBXylx/RNYn+oWl0PQTPfDxTDBgMsdEgzDQxEclogcB4
 NYi1pnuJ1oaxpsRTdhl9BuaZzNgiRk4bIKpaADGHB6VETMbh8Ar3XeDkuJ8ZcTZDO53I1+q0cCR
 Albhxc1stcR6AFsnB3KaUAKgkabAbyS6aJW39j3Q=
X-Gm-Gg: AeBDiesSJa5oNR0HsYFuZWK6kg1PyDl2XoDCRyZ7xYfiQbFifppb/gd8/qJgdnaHBTY
 A7V3Q14j54jmX7fRxLAoN6hg5PFTxDGhn3asbVeryMsBJ/1y047XVGec4IuCygpmklawKvd1erR
 L+JPkhUaaQL2ryd6zt1HmpUPaKTAdAq9XamBFbCPYzIkisonHAI7iSoPAgLI5rXMftn4zhkaie3
 N6j8la649Hs1vz6155SEoJwkmLu194F27h9nelF4xBMrm01YIZ9Bl4dbh9WxCxTsG0nbDRpobcx
 PxHTFo/pHkDGbdK0KPK0U5ePHsqvftjd8v5ZZ1nnV+NTTYAC0GP5
X-Received: by 2002:a17:907:6a11:b0:b9c:9594:e00 with SMTP id
 a640c23a62f3a-ba418982bd2mr15861266b.1.1776376544958; Thu, 16 Apr 2026
 14:55:44 -0700 (PDT)
MIME-Version: 1.0
From: Yusuf Brey <yusufbtey92@gmail.com>
Date: Thu, 16 Apr 2026 22:04:33 +0200
X-Gm-Features: AQROBzCixatGiELnE6FttT3P2uc9eHJKud_c6J7IQQ9gdiD6Wp4_fccH3uCx3GY
Message-ID: <CACBfyJtoeN52g-oc_3ZrwQQ8UWudm2Y_H6MTcbHVa7gr4S97bQ@mail.gmail.com>
Subject: Re: [U-Boot] [PATCH 1/2] avb: Fix build when CONFIG_OPTEE_TA_AVB is
 disabled
To: u-boot@lists.denx.de
X-Mailman-Approved-At: Fri, 17 Apr 2026 14:43:59 +0200
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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


