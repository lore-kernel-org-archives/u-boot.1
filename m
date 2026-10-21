Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CECA606A31A
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 13:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=MtSYFbcW;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=LJiwXjT6
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EB75160891;
	Wed, 21 Oct 2026 13:11:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XJtLhjQAlWgL; Wed, 21 Oct 2026 13:11:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2990E6084C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792588261;
	b=SFN2PDrE3Z/mthmpsmWEueCrpBYOHqtAS2KtaIDOMpUR0uc9G+tuj5aGD+sKEZmUJJQd
	 e5I+iqWeIs4CkVHP3cniazQsFBTyooAmhpMjKgK0mwzIne34OpJE/Vo/OjIIwlMTngMCN
	 asJ+L7f8eoXqdQFqehnVs1oWLznFrAzXKszHNHBQuv+WZSkoq0qpgAcNM790vAy3FxjQF
	 Szgk+84KevZO0Gp1ZDRatOO1XtlMLhjzaq88NMHcCe6yIuJTc+0kPOrZdq8YZaHoqOP4i
	 4Yd71xcA/QSjF6DSou10d0UexqbPPA9M3HPAE2seuBaiPD6IWcYYdNN95/nsIGNglKg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792588261;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=YdI0Mq2IvVS0P+G/iyenQZhMZiFOAUg7KSKO2kt/5Kw=;
	b=I7CuTWIeVEhJ/kGB0JM10z+Mz8hJ9XZIt1oWU5LpH/M8HD8OgYp4ccqG5aFn5lTyv69w
	 b7dMVP7094Y0LVwA+f0m748H1zSRMPY+uPruPbBC1aktn8tWuYyYKP812OfVjA1c/o/3x
	 zDIS2BYlwWrxoyjhISGaQaKLfqOzue44vChj2L8liw02laTv1Trf2UNy30sS/8uibDZnB
	 Z/wQfoZjKAWbsbxp9lr1ua5OHTxzeM9/bIdhj/MhCHp5rbH1KJ3enQFj6k8A5hN4d9GRd
	 IupjCvvBbHCPriZXZJZRbN1nk1SmvrCVsSIgbnwGLh8FTmVLCXMsnSzp+gwN7oi8Spg==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=LJiwXjT6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792588261;
	bh=YdI0Mq2IvVS0P+G/iyenQZhMZiFOAUg7KSKO2kt/5Kw=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MtSYFbcWrJDD/WoZW/vpftMpwWOcS3pzPSMv22GYbUMA5L7Xj7PR9sCY3CwXYogWG
	 j1S7vrETXEuRldKq3cWkC896oH3xgNecGN97Db3Qi5ThFM6pl2fInlxi+IJfnzBsJx
	 Pv54eQxOMKwh7Oze9HJPtFe63KH0FSpIudkc6CK2NncOLva19770eBroQRGNAN+BP0
	 9PW7BF5iTntQQvyhscwWI9K2/xDq/k+zSttsBrBV2+SK9+FPx+jayuzw8rTT730dNX
	 62TRv7emqceDprignT+dovq+9zv3zTIwgTq4SFOy2MElKFtFh80NgN9IMdmEPKTOyP
	 OfEd3JVEozfug==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2990E6084C;
	Wed, 21 Oct 2026 13:11:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id A76C4930
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 13:10:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 98F8D6084C
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 13:10:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id v4hchmQFKKOV for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 13:10:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 010E56084A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::634"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792588259;
 b=QqAOggn+B5F4WP3wZRPZOQXxXY46WQ/d9cfD+Zz6i9KlmpUndAmCN2Uaa6wnhbjA/CSK
 OdvW0VNwgv3KJ62AA2LnsnieO2J0xfLcKnqwHISr9ce5GUvxzPHdZ4URY0R4VljWK7sVS
 j4aMF4+dRl2/yuIHPQoulmLwPKzmSGf7tetWmdhRDePP+cP9i3mtdlX1t3CezuvyFhmRA
 L6OPlzggufqLLo5cfWLpy0qxLfPgHAPmRRjKcOOhjyz2Gu43tGusLKb4ivKWPBdpNdZ00
 g1ghoc6dpu6gZt9mKaaChgmilXt07TpfERoMaKlfYFpkCoShBjkLATt73Bn72uzHz/w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792588259;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=YdI0Mq2IvVS0P+G/iyenQZhMZiFOAUg7KSKO2kt/5Kw=;
 b=jf/rALCcg9EbjcqKnmT5De5RXtDfhCCvzu5+pC4AuzydIYWnLZ9PLzkYpZUxOms67FOQ
 7QoTJGhlQJNgVEE4r/Zii7FEMy+SfAD4ZBnDMW2QSMN5vNceahrRMxQOoGSvaR0gHwDNv
 uwGf5jXCf9GHVZ0ZruME5cr9W00uPtKueJ+mu5M5dzT6II/1WySE4gObfROBN0lT5VTXU
 CtF09KuL2Gg18mfMS2a69a/oszk/zK1RfRiFxaEfpz3eXBy18o05UAaH2VUqOq8r0pufi
 CwHIha+qOs/bH/JUR6j4lw4Cp4+5JEYjj7FLfk2pKFQ8Iss5mXKSlgtiByF3ojltRjA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=LJiwXjT6; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::634"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::634; helo=mail-pl1-x634.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=LJiwXjT6
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 010E56084A
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 13:10:58 +0000 (UTC)
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2e9ae391a05so4772535ad.1
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 06:10:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792588258; cv=none;
 d=google.com; s=arc-20260327;
 b=QEWwdE41vb0z4WYYWb8Gb9maNYRPdy4a18l6sHlQouWx7YhU3uF7bQYWRoVDpUWmFf
 TCysH4qS80gqxyo75pz5ws8XbJFO01pLbH5bU98kYY25RhWOIdeoe7PcCW3lqB/2eFKW
 eWtFLIy+Cf6eH7MIF94AaPj2VbWqsoKW6DNuAXSnJxADTY18V8hd9iXlReybqhF+Daaq
 7WEBDo0vGjM30n0Ln/2Z9DD2T528OeAu9MqpZorwYn2IjCsZ51mxHJF5HcNZYd3QgysJ
 w4IX8dU2QcDKboyjRfnwkCqOKR4Ydqsu6jUZWDOHrh+9EME+idErTssQF3QAYG6KbcGf
 W3kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=YdI0Mq2IvVS0P+G/iyenQZhMZiFOAUg7KSKO2kt/5Kw=;
 fh=rDOkmCQJ9cozxuZkgmyNWj5k0ThXnY0U4gnSEgE31/k=;
 b=FlHRmgEPoyix7wtqPpXv5xkEy3fhXjmS2OXUN4H63zx4q/NEHTDOv9Ntc8FBhMNY+s
 VttrGnnEiHaam58SeG2WyahjTu599yJOuT1Le4OFZWBPQ6Y22SEDDAANh2kPbCnvxktz
 giH8v/UcBZ3S2GSFoURHwHzHzh1A0kp7T4M3bhUNgTvezjC+H7+/NWjCdmeXzpsvM0AP
 JgCVLsmQgAgoufslC1AUCXdSYFSuPJtvGZA5tpj6W4cA5l39CZ2YmSE1+9s5wIn2CaJ3
 OWeCxjHSPVcmtciG3g6BpzXwUBXfiDJu5aEXd0tqNKW5Cilpybla5jwVH4irgV6PXlkV
 a7YQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792588258; x=1793193058;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=YdI0Mq2IvVS0P+G/iyenQZhMZiFOAUg7KSKO2kt/5Kw=;
 b=LJiwXjT6i3tnp7oyhC3SAOfpxCPKwWlixhwK1KmqxQqN8FBuEbV6aX2guqb0SdizqQ
 TZgoOtAywC6qaBMQusCOUr6AZUWKK9pTr5q9UPXZwplF1L0RFEBU7KcVt7RRfDh63QJp
 EnWd+dyk/sRanssom8dztBhF+X21FvOHxHEpc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792588258; x=1793193058;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=YdI0Mq2IvVS0P+G/iyenQZhMZiFOAUg7KSKO2kt/5Kw=;
 b=NEDGMjoRA4qlGOCOrP8dg8whQuGZNZBmB4vvdnATYTi+9O9KzlxdbiR6rwzV48xKs0
 3BkQr10LmPOf6AlA79cnuT0Uxctp84qlRlhYi7EhZhgHt15tEpkpIUWXNUJaJ2/LalZ4
 mUdXaRsSBmJpvCyIeSxT9dlRcwnLsFbJgyh1byu2PkLJS0wJ/z3MBl3x1mBNoP6Ft2Ew
 0ePlnQu9ds9KNA8PGsyPFjuhIDtArYMK46PZsPM/DMZnSUNG3cFjZOtPO7jARkarObe1
 iQSdBzrGwVwK0kZ+unLH+iIhJ6rt1w4by6YrEYaeDd1Nh2NxbO2vLgfDw/jEmQGK6vTH
 qsew==
X-Gm-Message-State: AFq9FYLXr/k+/Bqm/2/U0XUM7zqv/H4f1QkNuSoabjtTVLmywYS6Po5r
 Te4yDddgz0Pn6x0vJemSe9MnTa25LBIqdlfuvR4uevLknS32q3l4eZjDvdJzF8jl2jdbCh37cfq
 7/4HbpV0jQW+3Lszp1NhITsFW1rys7BU+mMeXmtB1
X-Gm-Gg: AYBFou231NRHXNKnOvWAft3a98FhWayIJpeaD8Vg/z9vN6ik7DQV3y8ddYJ3ElK21bX
 NFhP6iUl0ftllJ983GF7omIcpt+B7Safg/QPxLS+UGFzGhUKrBeHNErm39VSpB2aDx3D/7rgzu2
 wAUlXxRXbGOwNzKeALYT9gd6QWYDWnnsmWK+Ib4+wLu2xcECMhkbweXNTsjZfz6G7BPyoFnu4ZT
 uX1OEFAPfDX9r0RWTLUNCcsUudPFvhBcobwP7vyPR44SopxiLvnTLF61wtmnOf4ECmAc7oDC1S1
 y4hAMSoJFQppj9gH+LivxM0AOnvm83ZiomzgAJHYBs7F2ohKXZvOP5s+89Z9nqNHmnE0pDMlaSP
 MEWBZOHgCqiVwn4sY2uJ8HM0nIsMF5bDMgSM=
X-Received: by 2002:a17:902:da8d:b0:2dd:c100:2521 with SMTP id
 d9443c01a7336-2ea44096816mr12359885ad.42.1792588257744; Wed, 21 Oct 2026
 06:10:57 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 21 Oct 2026 08:10:53 -0500
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 21 Oct 2026 11:41:04 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261013-b4-button-adc-get-code-v2-1-72a1352d5965@protonmail.com>
References: <20261013-b4-button-adc-get-code-v2-1-72a1352d5965@protonmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 21 Oct 2026 08:10:53 -0500
X-Gm-Features: AclHuK-0xOpCdMz75wIiTxWp8kDqbpmk0ebocJ_4xVWT2lz4M4i7Aw1GzdGVXG8
Message-ID: <CAFLszTg_H=WVB-fKv6jxsmqRiN6du_3t8nmZV3bEdJt8PDK26A@mail.gmail.com>
Subject: Re: [PATCH v2] button: adc: implement get_code()
To: petr.hodina@protonmail.com
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 David Heidelberg <david@ixit.cz>, Simon Glass <sjg@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-13T16:13:23, Petr Hodina via B4 Relay
<devnull+petr.hodina.protonmail.com@kernel.org> wrote:
> button: adc: implement get_code()
>
> Implement .get_code in button_adc_ops and add linux_code
> to button_adc_priv.
>
> The consumer in this case is the PinePhone Pro platform with the
> volume up and down keys for selection in bootmenu.
>
> Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
>
>  drivers/button/button-adc.c | 14 ++++++++++++++
>  test/dm/button.c            |  3 +++
>  2 files changed, 17 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
