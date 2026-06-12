Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B8CDCD98CF
	for <u-boot@archiver.kernel.org>; Fri, 12 Jun 2026 18:31:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0804783FEC;
	Fri, 12 Jun 2026 20:31:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BK6K9C3o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0DE1A83FEC; Fri, 12 Jun 2026 20:31:32 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5FEE8063E
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 20:31:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-693c69b97e7so137726a12.2
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 11:31:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781289086; cv=none;
 d=google.com; s=arc-20240605;
 b=gO7Xe72DGHZcJDMrcimfq/dOap0+5fsa/06bKYCgBPwauCXtWBuH7YqdUv9wGCrb9m
 Q5fPOtE0HQbncgvDtcEQeQ4TTtxN8LefUKz/wQLwsBaNDbBAkdbT6RzLR7/wOGDCLfTQ
 +0bKGDBMZmWkf9X6Bnf7LDjUYLvs/8dW3ad79GImKkwwZB2y9ubzTxfky+AOsDI0NugP
 j73Q1CCj2W6X+i/VodVp82gslEiF6PZ3Lr8fNTnMsI0iNuW0NIhJMtcp3U1/h+Qf6FQC
 7KWbNZnNKgm+ZGWbvNl571CpcaykMJRkQPVTmuFnTtEeu+IfYbGkEbx2S6BC/pmjT6by
 jD6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=7x4bMuDNaGotsvOnWsDbSpok3/RJKqzTpXZ0PgYbcuE=;
 fh=lziDtBNn4+TATspMUfUgr8nt1aKuAi9J43Lz+/nMSJI=;
 b=DSDtj4uATZu2dzp/jkjDoYRZDmI89w2fiAyv1Jvlm6gcwSSS8yMnSz9QkncCR3WhZ5
 FsoRHXsyGtvxwECq5QNnJlIcLMDt9GWKJptBch3mZzZZPTX6a73KJbEt/OHAQNLFH1Ly
 EvW8N29jwyGuI53oQiLgsZWL7sTyNGUD5fMg4g1g3jcTyBNnWS6hDsRaJ2nQ1rAF1rot
 JTiJg4qTpvtXzUBO/ABELxYk9YqR2S8WNRiASuJF2poQMIuWnOwYm8iAKQZIQUZAWM0T
 +1gYIdD61ambe+gS6PO/HgGvxnUA8Emv2ZLvJeb8Uobserk5gevrb6KHwpzOBi7lsohT
 bAGg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1781289086; x=1781893886; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7x4bMuDNaGotsvOnWsDbSpok3/RJKqzTpXZ0PgYbcuE=;
 b=BK6K9C3oLQFKxAaKEX748WuHvN3vul4OgZHOREFtMSOZfT5/6wuudNIPew4xr69RKp
 4N42r7ihUvWWpn+wdw/ZJN+CahR+LMCIL/5Vf7jLBvy6EcdLtsRUbXwsCoLby08UyUpJ
 dOo29DytWRl8EPzzWt7/zgRTWwlQCTMO872Po=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781289086; x=1781893886;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7x4bMuDNaGotsvOnWsDbSpok3/RJKqzTpXZ0PgYbcuE=;
 b=bkgny8PRhZ/gfFtGZ+P0rnlHgVbgv1DMfadnuA1x9Iqh1Sk02BEa+y4LMlr2sEicFg
 rhpqY06EEQg8QqPeAG1LQS7hUhhQ31fX+06VoHSzGV0x1XfOPQMCXakRGT3LAazFXAy9
 9lOqsOYFkbpQk7lLd/B905NuY7TKHwrybPsw5s2qlGv+HvgOU58Ppn42e8XJCqVvtOiy
 gLbRCwkGPs0XsIfRYViOqAg0EGefdvov8yTmAADuDUV01RaOT/wAOdOmBLi9FSwBdYYi
 W1+RLnQtp3bPCYBsLdt8LGw8+XfqGT9OLoP3obd0SOBMrZGCcfwVdF2NKeJmA+Ma8Zmz
 SPXA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+IsMCn8uyu5rlNzFTNrOliC7Ue5hdckQnx94p84Jk0Uq2kE3ZL7RDmMkBE3v1Bc2wmIKvcexg=@lists.denx.de
X-Gm-Message-State: AOJu0YwoJigiZq/e04u9SWxqQRWNTOFsnXF1JvPg+O5QaJN+fybQnFXs
 YbHvPkKcpT9g/WTETLwl5yDB2cYGnHSqGhXH/lv9A99Eq0SiLL1sFYqpmrokHtc3AAHEjf2dcea
 t/66B3O1AACl2kjDQYiNqxYPTfxX6cuF6n5vXrXxcm6LCrEpLYqLhjw==
X-Gm-Gg: Acq92OFi0QMM52J1pE/O9MzDFgOXvoPerlrRFgGEeTtF/xMpTGqqB2QmC1+iBAcpQji
 K9ioSY/+H9Rznktq0rd5l5YKfyyY5E4A2HvDMDsDcRzfSlLdIq0lWOlg+P1pAFokLkvVtFL4p5Y
 35OE6EpOFcpXimefpjLqscvuA/WDFKSBiKNCLzSlqOEcXkVfW2xepVoj/rzA0ccou63waWh/PH7
 DDwU1ufTxs3OXlrhXzUK3DNPELoei3KVUhvYN3gp9FtVFKrzurETA16tma1sNprXk6U8DndawsR
 /eWTxA==
X-Received: by 2002:a05:6402:390a:b0:68e:4c0:f599 with SMTP id
 4fb4d7f45d1cf-693784de192mr2023697a12.5.1781289086374; Fri, 12 Jun 2026
 11:31:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260601134310.2452454-1-philippe.reynes@softathome.com>
 <20260601134310.2452454-4-philippe.reynes@softathome.com>
In-Reply-To: <20260601134310.2452454-4-philippe.reynes@softathome.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 12 Jun 2026 12:31:13 -0600
X-Gm-Features: AVVi8Cfi-14QkJLyxszH5F5gVXGyn8xUKsAz8ioQHGV8HxBMMxmaDHXbzw03XgY
Message-ID: <CAFLszTjYnGe1TyxeX6265xdW8QVkzWf4W9RneSyePq9xWrjGJg@mail.gmail.com>
Subject: Re: [PATCH v8 03/15] ecdsa: initial support of ecdsa using mbedtls
To: philippe.reynes@softathome.com
Cc: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com, 
 trini@konsulko.com, simon.glass@canonical.com, u-boot@lists.denx.de
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

Hi Philippe,

On 2026-06-01T13:42:58, Philippe Reynes <philippe.reynes@softathome.com> wrote:
> ecdsa: initial support of ecdsa using mbedtls
>
> Adds an initial support of ecdsa verify using mbedtls.
>
> Reviewed-by: Raymond Mao <raymondmaoca@gmail.com>
> Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
> Reviewed-by: Raymond Mao <raymondmaoca@gmail.com>
>
> configs/sandbox_defconfig       |   1 +
>  include/crypto/ecdsa-uclass.h   |  15 +---
>  include/crypto/internal/ecdsa.h |  39 +++++++++++
>  lib/mbedtls/Kconfig             |   7 ++
>  lib/mbedtls/Makefile            |   3 +
>  lib/mbedtls/ecdsa.c             | 152 ++++++++++++++++++++++++++++++++++++++++
>  6 files changed, 203 insertions(+), 14 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
