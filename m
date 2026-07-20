Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCAD0C44520
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 18:22:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CC51440598;
	Mon, 20 Jul 2026 18:22:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kh6VrAMf4TJn; Mon, 20 Jul 2026 18:22:33 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 68E894053C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784571753;
	bh=k4MP+3Qchv7xKjDpUtGNmFRYeKoWZHKy69AeR8FviL8=;
	h=References:In-Reply-To:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=QOskVMFzchjyNPF58z3kIAAoTPTetHZIr7rV/1eFqmirfDl6wJt6DBwmpbbSbWQPC
	 htfSKptTWxIm5OWpVH9zn0rh8IwmvOKUSzuyswxYw4Y/x2PIxE/MCszzHUtd0/B2ij
	 AzZ72HuTAAdrlW/+rpfYB4KdsBdZiOrEAvbxEV4OK9/884s4P18dRD2q/npVV3IwKk
	 q8ML8hwe5eArN1LqIAx3bW9zEo0udVdkd4xb4pv7HeSWNt2CiomyrkwmKZqIg6VloU
	 leAVS6XjkiiJb9Xk90mgiHFQ9McIvIAH1WBZ1d7CoefocA3w7CaQqk7JLehDdrp036
	 5N4uygcmlR+Cw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 68E894053C;
	Mon, 20 Jul 2026 18:22:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id C545B2E5
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 18:22:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B744840081
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 18:22:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xR_j4GsHG7hq for <u-boot@lists.u-boot-project.org>;
 Mon, 20 Jul 2026 18:22:31 +0000 (UTC)
Received-SPF: Neutral (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 7A42E40015
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7A42E40015
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7A42E40015
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 18:22:31 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 021A8844F6; Mon, 20 Jul 2026 20:22:30 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F008A80433
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 20:22:27 +0200 (CEST)
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-c16794450aeso710673766b.2
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 11:22:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784571747; cv=none;
 d=google.com; s=arc-20260327;
 b=m227yV4nyrT+ZrbFFyRBGqT1LtvcPRIJjqtVnS8dWjvi7ieeATVIw72CM8rVpsO32V
 DmAwWXrWwYD51j8I/SJq6ekn2HML9nsZm/nMMPflW71e8fFiNnCAhi2ejEmeRKjZ1CEF
 zfPtGV00Z9Xa3c6ZaumFmOJTs5vRPGGFQuYkBKkn1KLIAUc12ZQc+Snp17BGUFMJCC4S
 A8Tw0Wn8vYQHfQwnyo8QrD2Ef7b9R/RujRvi3HyzTL/dwbhl06riJdU1ZlhGaonCK9XA
 +MJh5V4Ra/uRy2xYzjQbdX/whf8gYOHoLmwf9S0LXIulTlcU5L60dHRx559v3+J/QNrX
 y8Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=k4MP+3Qchv7xKjDpUtGNmFRYeKoWZHKy69AeR8FviL8=;
 fh=JcawS49slyrlb1DYn0onXZHqg/P1v/BnDUoxr7QpqQQ=;
 b=dIfEqSW4MyIFlkHQqt0JuBTvxanInYxsgQabCwVIf6v7KPPD85/FBmhY5dZ2KWvt+v
 FU0w60Ausc44mCBEL3Dz6UQj0RFZ965GMUKslolBd+2z9oLSa9yt7a8PvNYLwe0hdGre
 skVM638EjIjXt1FzSzj4Y/DcZWCUK6ve+3PpgxnNJKTBFBC4T0bEpTCqmwhlsikpVHfu
 4ORweKTwLh2kHiARqY3s7NicSAdvMuLnSemm0+vlg8D1/Tee3gE0VLDw4QdG3pXK4lrx
 h3dsepJ8VdeJBNwXVfCyXWRRnDtEYnpGM149bH3FBVk+YPFY2yYFrGeHOMxabBj10e+V
 L52g==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784571747; x=1785176547;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=k4MP+3Qchv7xKjDpUtGNmFRYeKoWZHKy69AeR8FviL8=;
 b=Z8tjYnds8cOeOhrjQd07ylg/OQocNWoGqQ0fDavYkuYfGR+QMotChSoas6sLdumcck
 hCdRCn5SkFtrMXmcYjt9olLD3mRN4BX3MUgZEjfk9DvCdr+BdLyYwa4mUuNn0skQDJFJ
 9umOWtOukVzQL9ucROxUKhQQxqcoIdkJhUbIXmpAdZDPoqG35n79gpiU1MSAWehTCG0b
 bBpWQPlHtzyIp9FvyKk9wC/NNet499Fai+X8EzTuSp8oebbfIMUl3HPSSf6odtB0qYeq
 onfb6gekBC7CTtjtSE8es2Pp3+wy7nvHTyxe3SXoQAWozHMNDDwooLXJ3HxqSPZv87Ge
 ew+Q==
X-Gm-Message-State: AOJu0YzsDqR1Vvrb39vVCGGZcfZ2ps/q6CaRQel/RaTOh9TCBYpXOk0f
 nHyJep2l5tyG/xTdX5ROQuAXuGnerXq+jK2cI5bHo3lSYcyYN3WreYnn9zSq0jDyxqcg79WtxGK
 PyaqhMcf8CupwdtDwZp5Gk+7zT1KTSlzJCpky8FoE
X-Gm-Gg: AfdE7clQuCDO9q8YCaSrM+vMVR+pkTgqJvHpnMoJQKcBwXhWowVDnhM+7k2Y3IjlqNf
 hct9SkJ5dcypumamDdBl1Y7wXRo0S7gH+GiJcUcHjjo3j+TJwrsCpmhEcVx/CgVczNYFzqf6R9A
 SVhd+WYOzmu1GqiflA+WT/RoVmk21DgV6mhOVnejljP45cmKjYh8cjNosRxPjHVwhqv80VC7T/J
 3xAShp9gOnNtZzb3V1q7YRvl7qAKVU934hTgNyWV+GeiJqNwmRG2uyrUSvF
X-Received: by 2002:a17:907:9445:b0:c15:d0b6:495c with SMTP id
 a640c23a62f3a-c16b4702c27mr604776266b.29.1784571747288; Mon, 20 Jul 2026
 11:22:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260703214005.3818185-1-james.hilliard1@gmail.com>
In-Reply-To: <20260703214005.3818185-1-james.hilliard1@gmail.com>
Date: Mon, 20 Jul 2026 12:22:15 -0600
X-Gm-Features: AUfX_mxM4fzQ6siMQPTQwmmpAKhaVs_uMkaSH42VtxBIa3wyTzcPEJwf4xV9Fmk
Message-ID: <CAFLszTgmYkj+kWMkoP89Unv3DYeET+o2OTMk_yTwHnTfDr75Nw@mail.gmail.com>
Subject: Re: [PATCH] lib: ecdsa: use .key extension for keydir keys
To: james.hilliard1@gmail.com
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Lucas Dietrich <ld.adecy@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1784571747; x=1785176547; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=k4MP+3Qchv7xKjDpUtGNmFRYeKoWZHKy69AeR8FviL8=;
 b=Xw9/zmRWgVWBvsVEV5SZkNeG1UWuXJbS6ingzj6BX2vy3l7M4fim28vBkAcPg3050e
 v6RVmH86Ct9GVNf9TEGcyiiloUTz2b1NRwRSJQZZbMAOXVhaBydUMvSSYPfDD7WvZOQR
 uL1Dvzec/apEDZZsGVgBS1y4D4cKxl2Meq3Yw=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=Xw9/zmRW
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=sjg@chromium.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=chromium.org header.i=@chromium.org header.b="Xw9/zmRW";
 dkim-atps=neutral
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
From: Simon Glass via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Simon Glass <sjg@chromium.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi James,

On 2026-07-03T21:40:03, James Hilliard <james.hilliard1@gmail.com> wrote:
> lib: ecdsa: use .key extension for keydir keys
>
> The keydir/keyname path should follow the FIT signing key convention and
> read <key-name-hint>.key. Using .pem here is incorrect and does not match
> the filenames used by mkimage and binman key-directory flows.
>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
>
> lib/ecdsa/ecdsa-libcrypto.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

> Using .pem here is incorrect and does not match
> the filenames used by mkimage and binman key-directory flows.

Not quite - this has been the ECDSA behaviour since 2021 (commit
eb22759e2be). It is inconsistent with the RSA path in
rsa_get_priv_key() and binman's fit etype (which look for
'<hint>.key'), but not incorrect as such. Anyone signing with 'mkimage
-k <keydir>' and ECDSA today has keys named '<hint>.pem' and this
patch silently breaks them. Please can you mention the compatibility
impact in the commit message, rather than describing it as a straight
bug fix?

> diff --git a/lib/ecdsa/ecdsa-libcrypto.c b/lib/ecdsa/ecdsa-libcrypto.c
> @@ -338,7 +338,7 @@ static int prepare_ctx(struct signer *ctx, const struct image_sign_info *info)
> -             snprintf(kname, sizeof(kname), "%s/%s.pem", info->keydir,
> +             snprintf(kname, sizeof(kname), "%s/%s.key", info->keydir,
>                        info->keyname);

Given the existing users, I suspect this should try
'<keydir>/<keyname>.key' first and fall back to .pem if the file does
not exist, perhaps with a deprecation warning. That gives people a
migration path instead of an abrupt failure. What do you think?

BTW test/py/tests/test_fit_ecdsa.py only exercises the keyfile path,
so neither extension is covered by tests - it would be good to extend
it to use keydir so this does not regress again.

Regards,
Simon
