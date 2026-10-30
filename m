Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7853A606A31A
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 17:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=coK1cbwH;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qJPqUSvl
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4FF0040B61;
	Fri, 30 Oct 2026 17:09:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5qjHAybJfSU6; Fri, 30 Oct 2026 17:09:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 972F140DCC
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793380149;
	b=Pf02Rxu+PPcgqWKs5fzs/9DiooYEGc+b0iOwR54eDeasEhUjlIPfxmInDzfHj8wE6t4g
	 LyRfxGJGZkebrEQ+NFTuYPKrzE1rhU2j1NJA04J57bDpUTC35Vy9frc00tPhgPKADSxjP
	 So8pEjlffT1MHNRUl6dK1XLdley++k3qU6qCMxmiBhxcXgjJF/9o655Fcy8qtshgjr+W5
	 LA7qaK9f6U8ozy7G6NSuF/sJCofwzcvTUGMXhIXYJ1bAhXOIn7Yjszt6sSPH/sG7aX/8P
	 1m7It/O2ZtWe0wDKgYBVBXNybQVnNaJSosAGL2G1cfoeVJec60CXWpFclgrVeDdOLHA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793380149;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=MCaRkiSU5Jo51EG8wwSwUmYUw1xy2LDrq1EsyXL9fFE=;
	b=MPQs+FWjgYuKONyf4hlptvbJFdKRGeRMM2JZ0kBwT31QBf0ueMoz65jBYXhO/XEw/KHo
	 zkhn1idf0gzBQvtkD1fogUp/T7tmMiebNL9WMsdAuBM6SOdYeqeD2f8KObGEI+Wam86v7
	 DW3Rjum+naRsyqKzIAFnyx/Ft2MvvY4FbC5ESnIFBr7e1ia8SgOyMOWsMrqmy1/NHve2l
	 eisSMm/jMW7WHpuAdCbENeOmpbC/3V/GTMxeGfzgN1W5cr3vmFVzfa58pVKK+2OnzkILK
	 sO6uNK+4QwE+zvJQZ0iVKn3PkDAiexLIEbVhYuJwP7p3JNQ3qwr3tjGJj5tvnpQCuIA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793380149;
	bh=MCaRkiSU5Jo51EG8wwSwUmYUw1xy2LDrq1EsyXL9fFE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=coK1cbwHu3icf6BTzP6STWzWCd0sDkCBBxzkJnm7Ge2OyOiSncZeDOk6DAFnNxPWQ
	 iCQf8E5BHABw28boYW9jE4iRk2xyoCKZDbIIWvGROQWWEyLa2kUDYB5cu714KYzbF3
	 uVRS3xGxH2aqMJ1wBh4s50f9H0+JbjCRI8ttCAXzYaQYep2qjSejrX0TqJOJmUpFLz
	 H/Yb3BW2KFy+9Rm+orT46w+7a+oyfZL5U2K1FL1wFl4qTEizSMkZKnYoLj736u0Y0t
	 uv5lxilYWtKBDVAqTUZcCgd4rO5lxQKmtj1hdW/bUfzSoM3MBgPOAu4ebkXC4YSSVY
	 IZwqGpAVGGVRA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 972F140DCC;
	Fri, 30 Oct 2026 17:09:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 202082AC
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 17:09:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0501840574
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 17:09:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OukB7kKzLWDu for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 17:09:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 500C4400AF
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::e30"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793380147;
 b=FiELTHts7xN+nDX82v75jHC/eTEvDMxxz7NrKPqSlXOftycQLCqEev+fmZ4nr5YB8mAh
 1XhNcOmPqaX6EYo797HsT0kIFLsrAYn+SVW3e34SsROSeA5wXz+M+SMDwwyc8GQOcjC2y
 zclNQp0q72aojwns61eTtxpw49QBig3LYDyAWn90hEyHNJcomYZUKFPMIB+sKOariN4NS
 HT7U3A/O3Q1bP6683wzEbfGUKCy1oMRZ7hmWkMVlnDPo5RnuCakO0pOJMcNmcoOfCw4hs
 w360ZunjuuN32r0a94Psj6aEKWyRG8BoDsELkFina6Y89sEQZmjOl5T9VgT2PLY25Tw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793380147;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Type:Content-Transfer-Encoding;
 bh=MCaRkiSU5Jo51EG8wwSwUmYUw1xy2LDrq1EsyXL9fFE=;
 b=M3Ky/afNyMLAYfgWlx8drIBiRM4fLL9DO+sxx4DmToz2rPGWjGfmyjn6/BumKqo3+2+9
 lv9z7YT7qKYcR2TWRoOBpxMVMXPF8HGnYYH106D4Gn7mUHFA6mTiLBde9s3IjRHzPl4VT
 5M7rxslMXFg4ChJXdWcJfG83VjtJFA4pEhpqacKcMa1g5E5maruLDKVk72sLOIb3c3Idv
 HRY6LywHC4yC9Vbb9PbNsUeaq+mm2IUe7bL3uyEPlNmvVzE+bqQIY0NUtDSgD1I6HlqEt
 Qb9kOALg8Jcm3uvqldIfpAJ2D+Ed3jSd8fKamFV9jWYS2D/EaCv2kI2WGwke58oBfsw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=qJPqUSvl; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::e30"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::e30; helo=mail-vs1-xe30.google.com;
 envelope-from=vinicius.eduardo.pedrosa@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=qJPqUSvl
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com
 [IPv6:2607:f8b0:4864:20::e30])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 500C4400AF
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 17:09:05 +0000 (UTC)
Received: by mail-vs1-xe30.google.com with SMTP id
 ada2fe7eead31-7cc365db987so656607137.0
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 10:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793380144; x=1793984944;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=MCaRkiSU5Jo51EG8wwSwUmYUw1xy2LDrq1EsyXL9fFE=;
 b=qJPqUSvloLHfJtWZohHZ+Lc2E2GthtVNMsd1x1VBV/plkEnPak7QGBpBjqBoacBgl9
 Ua+Wa0PCGmwW2T77HgEXcT+QA1HuGSZVsLIWuwtF66YFOWNTBlTIKfCRJHYn8QWWLCF2
 BU752E2V1ObuNttz2gG9HtHce5wOwNd7QGIHHLqU2uUvn4lo+BadmiM08hCF+SC+Xd73
 QsZeYRMzAqTTGjVNsEVusQlZQEnLu1iiMwv4v9/BTD9+wRWiS40VAHoCxz0ThWw+RId5
 eIYcBZRo00yBDlDx+NE0Zyu9z38AOQBQsnQGF3J6pqUmqFRiKZVmo/vppochP00JxcUM
 zHuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793380144; x=1793984944;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MCaRkiSU5Jo51EG8wwSwUmYUw1xy2LDrq1EsyXL9fFE=;
 b=bgDKFiWhU2JsfbNspUQyIXJKp1ZwEKQXA4g2mloiPaf9aZDFeH/uiTON64tiexL6EK
 qBDDDOhOEYZML7lEXUg0rOAIneRYLcSRIEmu1GE8vRr6kk7D4nFPavSyt9Gap573UzoX
 8HvVLJ+HlPoOlNpbzwJrcyVMSsdLR3eFKkVVR8JZD01EQy4dJPHlOaFgWrhM/Plr6Dtx
 e3MY8S5N1FiJqduenqDtn/jGv6XvmIs16GpbmVV/A9spvIA2USW+6YP0NhV2F9FD6S1t
 TvyhjlyM3LcZq9/hM+GNE4AOw94YEifSScM4oSDOSI1nn9Im8Z6JO71lf2qmgF18DYa8
 3N9A==
X-Gm-Message-State: AFq9FYJmDUKS/QhdQIF/d6rZaJKUzNn3lKh87fQmoQp2NwfhQWNbJeoO
 6Oa3x9gSbmd2pLtXZms/J8ryS0wECBb/Xq/fnfA5Nb8u43pJ0/cW2pRV
X-Gm-Gg: AYBFou2RjE/JuS7lk/vsK0XsQZLj0C7se+ZOf7T4O6T0ge83CqILNKpfHk73xURK48d
 28JhwCWuEw47GjqGniUgyO6EM4pZ2zSjyVKlGGkDM6s+YGIBfjGwWlBS7ubxdfNnmGgB2KNYCVI
 jG8lRZaP1NcJJhG+N3wyS6o32qroZCkxT+tRuvtm5k6dL1t5CTque+DQ8V86Gu1hT5zBbH3gYOj
 vn98dK15wbbAwhu5y67TJuCIAUpfZimL8VNgepXEkG8BGzmrgy8FmUPHxuHMd+aFMLhpikqyTZj
 ytHvRpb7FlO28VpF2GlqUzVzU8XBWRFcg6y3QEGEuO8x/Mgzlv/EcmMiFiYieL/g8x9HdVdBbih
 eQJJ+mUrRDarO2+OzLZGj/U9EitZkFpJiR+yJq/wREC8AYsjRmdYkRtT9lxeODTNoTmoMBwcH1H
 foDZ7I50NGSQfPBbzeSt34WoAP6sw0nu3tqaiup/SBqpOJZtmCw4zm1e0qWawewlLA3vue7wg0G
 FGOVEzRqmFO2bRv/3dzBQXj1g1o4iXZ9lBliF78HaZ10ZjUs0l725BWghYu2JMn0GdZTXKQtMU2
 ki38eGeE2gZ5mQmp4wpL5asVA/0+lTlc2ipNvTE3xlFFcxBcv+7RqbMyobBDQK4o1OmkG8oy5aQ
 JgRLMdkXjV8E3USwgy+0pjrjYVlmp022+PkIO
X-Received: by 2002:a05:6102:3ec7:b0:7cc:1967:5e3a with SMTP id
 ada2fe7eead31-7d072740592mr1672083137.32.1793380144448; 
 Fri, 30 Oct 2026 10:09:04 -0700 (PDT)
Received: from MaquinaLab.. ([179.179.238.247])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-992ee1d2d98sm3320502241.2.2026.10.30.10.09.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 10:09:04 -0700 (PDT)
From: Vinicius Pedrosa <vinicius.eduardo.pedrosa@gmail.com>
To: Andre Przywara <andre.przywara@arm.com>,
 =?UTF-8?q?S=C3=B6ren=20Hantel?= <fugininsane@gmail.com>
Cc: u-boot@lists.u-boot-project.org, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 =?UTF-8?q?S=C3=B6ren=20Hantel?= <fugininsane@googlemail.com>
Subject: Re: [PATCH] sunxi: Fix misspelled NCAT2 config guard in gpio_init
Date: Fri, 30 Oct 2026 14:08:41 -0300
Message-ID: <20261030170841.2067385-1-vinicius.eduardo.pedrosa@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <0639556d-dd5f-4f9b-a6df-bad2625275af@arm.com>
References: <20260723105705.3338923-1-fugininsane@googlemail.com>
 <20261030110817.74836-1-vinicius.eduardo.pedrosa@gmail.com>
 <0639556d-dd5f-4f9b-a6df-bad2625275af@arm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/30/26 17:14, Andre Przywara wrote:
> So yes, we need new code to setup the withstand registers.
> Patches welcome!

Hi Sören, Andre,

I looked further into the withstand register handling.

The existing copy looks appropriate for R528/T113, but the A523 family
has its power-mode registers at 0x380/0x388. The vendor BSP also
suggests a different bit layout, so the A523 would need more than an
offset change.

I think keeping CONFIG_SUN50I_GEN_H6 and replacing the NCAT2 condition
with CONFIG_MACH_SUN8I_R528 would enable the intended behavior without
affecting A523 or future NCAT2 SoCs.

I've prepared and build-tested this change locally against U-Boot next
(ed869863). Across eight SPL configurations, only mangopi_mq_r changed;
the A523 and H6/H616/A133 builds remained byte-identical. I haven't
tested it on R528 hardware.

Sören, would you prefer to send a v2 with this change? I can share the
patch and build results if that helps.

Thanks,
Vinicius
