Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D15606A31A
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 11:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=XajGYuUL;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=fnFL2/tL
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 089F3811AB;
	Fri, 23 Oct 2026 11:37:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nxT9tlcDHtic; Fri, 23 Oct 2026 11:37:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 55AF4811D7
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792755463;
	b=F3jPaVZZdtEnAYuy/yz22663yYCgH433O6HQiw/B4abfLMe9zhUnO/SFP5O0D3OD0R8p
	 5UOZ/QS5DCr1q4PwweDEm+3AV6Ks+1MYn3UHiaulL/ytRBni40GXS8kHAnV1eVoCrSFcM
	 g4uJbfh40uj+ocnlTT7fobEKzuAqF6KgSA5ogZIeBUsfYxYAPhXCZAEfGO4OlHg4SItwx
	 fgNoOVkq58Bg548zw1MEuJUDtLClDVa1RZiOSvnk9N70Dxvn+ZA7V6FEenm8R9911Z2J3
	 u10phSkIfyreJmzBXwkdvB+TeAoUkcPQIJZZzXcbSyJUJE11y5RZQRPlP+64xsLrQ5A==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792755463;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=TE2yqhCitTA2aX/jryyiVTQEKOb90aaW5v2xzXlcg5A=;
	b=r4N/rb2vnCbyXc5+SnuHfuSKCSIOhR2qOcuBnxz/uJLogrh7TUO9t/Pa78MTMufoarRn
	 tHRlmGSuvPslTuRKVE4EYyLj20MKXVMxzJZZlyhYsZYDu5nWMQKfWwNOPJO6Yv5jImqS4
	 bJVvxZSOu4uUfTjds1qVnKLnMAH2bcOKvVN4Mp0A5M6NFHKzBJe2S+BHKiIBE1Yr1ESmS
	 4vh20Sct6R1snz7BjPJvCfHCxk4BQYKWVxr4oKBj2g072CMI/tGUxrILcWXZaPD5vTObw
	 +qfN2/kcsMKLPyQOmE6nDDJC8eNNoJTSi7xYUUqYfMQTYZIazZO7/ueL3rxchn2r1Tw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792755463;
	bh=TE2yqhCitTA2aX/jryyiVTQEKOb90aaW5v2xzXlcg5A=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XajGYuULp2FtZ7rgkvUzeFd14/e7da+iao8Ir6GZfod025KzDGNPLhyp/48LzEQgp
	 S3A9PCfXfZszYglqEeZsAfMJcT/Xd5saGr1RhwYqUUNTMTf5/POJsBlKOpsHxuF18/
	 FvUdi8GYkOA6njrsnml0KemM9UXG6IPGlGJOw6GxmDSbWvKPkQPP6yuX/Dzhkf8WxY
	 K+IHmLCmScwd0idxtU3IX4Xzk+JgIWO0jGD2LLhbI9L/+MIKxdaoT4cX9JlBjoHBAw
	 uolakPXChj+JKjBJOTQwxi8IqPPtpv7Uo3f5S+oqWxG+xHsApsoccE9OvRiOrotvar
	 dvxnBjHmOfz2w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 55AF4811D7;
	Fri, 23 Oct 2026 11:37:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id A83263C1
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 11:37:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 99B7660639
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 11:37:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LrH2Yq_WbAgs for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 11:37:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A7C5D6065A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::52e"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792755460;
 b=NU3dvWrsjHEOSmY685gCAPJ9iL2hdair9jtKoatn47nbURRs+LWiX/kzEAg4DCdDQnBl
 1RPazZq5SGTtHhuw5inSl3E7ROL1P75nYCBapbOj7BCIJuir9XUT6sgQoT1IqwHLHeWBK
 0WY5TgztkHNhqkWkqqBKW+WmZKr1Hph1YNrPXNA+L6GaRj0i18nVmbvui+ZSIdj0vliJv
 LEpvZ3Q0KQf2Y9XCydJtpKY+54+LAvaCoNEXq4/AbD44tj9OY/GeF2oBbdNtvS+ZgtSOx
 qtZ8yIVLy39v5Codbmy28dE/F2XwbZq9IRoz1Cd/eAATO+UMFLTQQb0iccR4h3KydVQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792755460;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=TE2yqhCitTA2aX/jryyiVTQEKOb90aaW5v2xzXlcg5A=;
 b=gA9mH/iZSZjiD+WvmcqSYuTFJqENlQH7XDNFfWPd5G/fttYt/IVZ8hCX2BlBAQCLoyC0
 4ZJXElE+elADafa5w8Daq7uKd/17EeXaukiBIYtkbwwLQx0bjIhRT7k0ctXn4cSzsebfx
 TV9Hkmh5mlcv448QnZKK0iWh1WKIy6W7p3Tb4cXPXbB3EmnXb1NaPGYvJXSyeXO5LEWz9
 G6n+tC2p/TWP9Nv18wExyFQHYhu8vVM96pD5T/tnZycmjT4BT2JTsS98Q6wSRB/wpkN4l
 0rPg7ZhVU+lFY3CuiLJ+0tRfmFtMyJ1QQVp1RN09NX0r+mi1ZWgMyEn8YdS69bKku+Q==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b="fnFL2/tL"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::52e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52e; helo=mail-ed1-x52e.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=fnFL2/tL
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A7C5D6065A
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 11:37:39 +0000 (UTC)
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-6b1dae0febeso1070102a12.2
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 04:37:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792755457; cv=none;
 d=google.com; s=arc-20260327;
 b=Kj01WJOta3Oy5HAg4nmsA+WD9iEmW0+MZ5khV9jvjALIC9YsSxUdcSdA4kP3Wn1+N6
 zQWgdocennTRB/CmRuSO2IdeBwZbhemrALA7TZMcpTOROtXmE6Wm3QSVLc1I6lJaOltc
 ryVFcTqWA85yv4tHqLulknI5B07T/SBobGF4zn8IjWLLrbTq1rFUK3KL2QgbrI1K2teB
 cafpUVI5rOYNffXKJRbj8hrolYKG0jI0uMCeykalEeB6GVjMxgN4O5ear0YuP9yOnbV/
 YKzUxmJjo8txAD72U232xGfSsbmzwbQTqcLXL4xfZrxQOip937fbJf9bksdGriBBJd98
 50oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=TE2yqhCitTA2aX/jryyiVTQEKOb90aaW5v2xzXlcg5A=;
 fh=rZWNL7/f1nOUc1dRIK4oJ2w74wTFGviH1FcAF21d0dg=;
 b=f19JxwuPeR5tgv8LkoTDMjVapcXAxkpEf/t1zV9CG1dgULCcMX7dtEqvhW/UBqW3iT
 GNoTokDJJm9RdpCNbkQ88LiKRXiB3+ewisbIc7+cMCTw8vx59tKGFSMOgq48xNwyMDRZ
 BXZ7qGyV8TFbZ90d5GzPaIrplOPkMx7/seKHVAwUv4GfCIEVDw0S3YZRA1gWVBC8e0bI
 lbHhZnjf/JuItkzFtFsWegFV/WToDlBNcFwLOUHTNKYSJOM5QFyAoAW2O33xzqnBJRod
 4T6tyibcktRkodSMhYou9RwodbeWg5KkWrp6NNmhDfdNyf3a7UKjthxHuAJmhCi+tnPI
 FHtA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792755457; x=1793360257;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=TE2yqhCitTA2aX/jryyiVTQEKOb90aaW5v2xzXlcg5A=;
 b=fnFL2/tLK3hqUIv9LNMSfwYpVRWSodhtZWI0WkBJQGtE+z7x33/DqmOJ2x3WPrAC4k
 u0RBnLp6bLQslP8460ByJGge9Xrnth9VO9zhEj/y0gkcNHVFIGKEmnRKUQJCv5EeYKAm
 S1fBN4AeENUc96vomfmQZpc2KrO2lpB0c/PFo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792755457; x=1793360257;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=TE2yqhCitTA2aX/jryyiVTQEKOb90aaW5v2xzXlcg5A=;
 b=Vxyd48YHesP59LNidEUcY7tP3DTT6DmUOEeXiRxxFqL61ffV1IREH/56HGvUnGGoFp
 FwaayKIwR6VxVgp5SO/fKrByp+NBxrWXlXebNXDo56xpHzQxcO/Mzf2SUR5VCeJtijtd
 Na2lQycYJb7t2i6Y4fJaqYDB/wA4qZEyYuhH2m+n25U1wk+KVCzK5MOKLcCwzl92m3iZ
 1jQZS8q88NZO0Ep/2eaWGYTFrHCPQLWykui9IS/p6sVXmo60OlsyezppQOfWeVnAjc5f
 riTbYpMuNCMDA2cqJOim/d3gJQoW8eZ6V1B1mse2s5XTAHmg0yi7p7h5BQm0qUKHcWKt
 04Ag==
X-Forwarded-Encrypted: i=1;
 AKwUvBwcNB3biANFz7kTPUzg8/cQg6koEYMd6iDLBPdXKzbG9GSqWKMM/F/mTxG2eGAJ0pCumbgynvw=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIY9g1yo1D1lXniZbYCZVKWuw04FWxGd50DDZg1na+xWmKvRTLT
 plWTXOQkMk5eiCnFJLdurzRSKG6NZvDUVvoff6N8eFkjXsg9PLuRkB1v85W8+KI3aGVFhGXlVlL
 0vacpILUyEUYFcw/X49uWwXFupmHcI4TVSNbapbaI
X-Gm-Gg: AYBFou3PR1NU0+kqz0FvJ8GOOkpHI3l8kRedVHUA7CoqReJmkfBFJNtvDGl6wvKctDS
 bci1c5IYW1jFpsim+mgL+K2iha2P/yg+1Hp8aBDnGiUIcd5A3EbmMhOPqzqIlmRcIwOP+ZrImb1
 IVq965WiX5rnU2Gk1hH00tTcO2eALyMB3CaQLYBVUBe2Qc97cp8iMrlNstoqUJ6cbsG/1LOSD0z
 FlqRz7UdGL8VbO7S5LevvQokv3pyd+U14gatfdf6uaE54qY8LA27szcoqv3Y3Rqpr2SObWSFMPn
 QpFy16+GTjOFwgbHjihV3sXFSdyQTUXaTPknaUycBmWRdKU7+W5zkCqXFxkmI4sdwsB7Qr1Rj+p
 FkMmQGvRDlbgBCH/X2VEjSULdhM/OBXSSj8c=
X-Received: by 2002:aa7:c1c4:0:b0:6aa:f0e:a15f with SMTP id
 4fb4d7f45d1cf-6b432c16487mr2438300a12.38.1792755457318; Fri, 23 Oct 2026
 04:37:37 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 Oct 2026 04:37:34 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 22 Oct 2026 13:30:49 -0400
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <8ccc9c3794b6314bb4b450eb8291c3cdaf5e36a9.1792591479.git.daniel@makrotopia.org>
References: <cover.1792591479.git.daniel@makrotopia.org>
 <8ccc9c3794b6314bb4b450eb8291c3cdaf5e36a9.1792591479.git.daniel@makrotopia.org>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 23 Oct 2026 04:37:34 -0700
X-Gm-Features: AclHuK-75m0D5K2W1FQQWss3dvZCQvCAcOkB0IxlkIsq46rw0kH2LxvvFi6Mt_I
Message-ID: <CAFLszTi4YX_mf80U+so1eQfsFqvbQ7ZR5sMJpekc+ewedg5kVA@mail.gmail.com>
Subject: Re: [PATCH v2 09/11] boot: fit: share the external-data offset
 calculation
To: daniel@makrotopia.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Aristo Chen <aristo.chen@canonical.com>, Anton Ivanov <anton@binarly.io>, 
 Vincent Jardin <vjardin@free.fr>, Randolph Sapp <rs@ti.com>,
 Anders Roxell <anders.roxell@linaro.org>, 
 u-boot@lists.u-boot-project.org, openwrt-devel@lists.openwrt.org
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

On 2026-10-21T14:08:59, Daniel Golle <daniel@makrotopia.org> wrote:
> boot: fit: share the external-data offset calculation
>
> fit_image_load_storage() repeats the data-position / data-offset /
> totalsize-alignment sequence that fit_image_get_data() performs, and
> writes the result through an int pointer where the getters expect a u32.
> The copy also omits the range check on the sum, so an offset that the
> embedded path rejects is accepted here.
>
> Extract fit_image_get_ext_data_offset() and call it from both. The
> storage path gains the range check and both agree on one expression for
> the alignment. The signed comparison of the offset and size is
> meaningless once both are u32, so it is dropped in favour of the shared
> range check the helper provides.
>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
>
>  boot/image-fit.c | 166 ++++++++++++++++++++++++++++++-------------------------
>  1 file changed, 91 insertions(+), 75 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
