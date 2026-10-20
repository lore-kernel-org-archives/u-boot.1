Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD52606A31B
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 07:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=k6cq5ldd;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=AJFUHFUC
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 72BBF60854;
	Tue, 20 Oct 2026 07:56:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id w2nm9c5h-m6m; Tue, 20 Oct 2026 07:56:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A6D1E60838
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792482982;
	b=SxIcgTqnbfDiu++KPx7P0rlY5rc73E6dm6modBzGi94g72fAeCDQYQ5lWnDTMV2Iub94
	 u8c5z2KIHQXZSk0ggx5+orQvbCyAsEmXhOpT92RVXBUfPUyfQ1ghh9DWdQumXJ5CJkN5i
	 cra08WwoTXxaIThaZrDOQkFxQbwkhi9sCZws1uJB80HtRfinMm7myiYmviEsBuFhnoiMN
	 RI9ISnlAqi/Hq6G+piUiuQjK0ei1Np5p8dI4iGP3ShxM+q7WYmtDkvdEdLtEKgF0mjQEa
	 wH4ETpS1aZkmSAzbUEe3e7zgy16FuUdH0M6z3CsFVCoHvZeXehhcRnhcPvujGMeMjjw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792482982;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=FVaOn3Tgw1s2wRM05OiNju2ddboIn0SnRt2C/OvR1KI=;
	b=X5zQv8bBw05T73SGt6MMOX4XI4Fc6z2zW50iRK1fUhhl1PLBq6hPKFp9LFzkkkGBIlfK
	 wiUxbnVFrjhOIQuzhLyUS67d/p+Iv8NfDVxB77Z+M7s5n8vy0o11xKEeD6HMcJJVA/QrE
	 vjHbDjnKG3B3sCZLQdqQMiGg77LC4Tyxi5s/9O+cULjs57IKK/Q8wuWm6JH3qwcGo/TUl
	 EGOuYYJWjeKFwvKEoWEWN+/L9eKZVI3VxVwmaHPZ9Jim7D8VpdzGbTzGyqbmwxlo1yqEC
	 as/lVXLV45GXu5BvJ4/e8eL9KhREHo2BjBIet8U2Xvb5iIsZ7wFGKL42jXfZJbbRZwQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792482982;
	bh=FVaOn3Tgw1s2wRM05OiNju2ddboIn0SnRt2C/OvR1KI=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=k6cq5lddi1ehJ2MySsWZGh4MkDLTcSQ3wff/mLqfLmkNPgdVVqgDwS26OwM9G/R6Y
	 lufR60ZID1Ni7W/RvutTrw+dhcg8u2nMDyi12hc8X1Hgm22BDVdHioxhgcjYnJeJNT
	 UHVB9CBHgSfSWderwoHyyymmG4yFhVKe3Q+agQhp2//ec+tSYWpgMM2iZLIU0loZcv
	 HFyAwFcezHbvkFdvTQTpoJ/bSdYl1xttYL5eiKHWFd/NPMivhRGDr/XvfwAFUTdZ/P
	 hKgmAGIf0JbjuTp75Dfoua327qMHQZHc706sJlpxL6Awp14gj9btEEaW9C04Xo0E8G
	 dqw6tx/myDKBQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A6D1E60838;
	Tue, 20 Oct 2026 07:56:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0E202465
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 07:56:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E1E174081F
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 07:56:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id z4y04X95VUie for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 07:56:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 405B3407F9
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::102b"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792482981;
 b=RpK5vHlR6J9L1HxLRGCoGhHNbJUjTJmcNGIvN7/xlvPSim3a1gNHrBTlO7l2ONROo0mg
 xA/9ZM+4twI/82StoEBzy2ElyJXqmiFJ2jAD2IXhHVmVeuzs5+hKZK6XsvckjOHxxIahj
 3P8G6PS+zz1cXTooW0HcFdKTOinMPyu0tgEKgx4J7OAXojyk8+mdIvZjmkFGONXvgullT
 Yd1/gb9jIK+YoWQ8PblPJB3pznkCfZjJvmfNAUEgcaGcYlUYC0SPI+NmRng3sz+0Eh/Vz
 T49/NL1oiN21ZXCxvcQN/a8Zgws6DXnKeeMAo5E52Q4XvMW8DAJepP16noFE1zLn9JA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792482981;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=FVaOn3Tgw1s2wRM05OiNju2ddboIn0SnRt2C/OvR1KI=;
 b=CkdeSHt9kcGvYhsvibg/o6LvSVo5tIFuunHwvFbhOBCvSaS0CS51mbRHVEy3OPft/mpF
 8BmMFtWqHCQAksijma+NfHn8jB0TlEAuVPGIYOETVTzzyLU5lzmWU12TTZIg08p6eCRHz
 a9hVQoch+SBtGefKxaqtkRLGBKyECPmriU+4X9+UMBsfECAJac1KYeuzK+/XTRqV1WEqE
 o5JeOEoV7DHX6vevGwFiZbVSyK5B667K/xbKzYrnX0XP3K34TejPmWCa0PS8+qP+v/ApC
 UB415U2DOeDN335BkjgdOP97C6QaluTyAUFFcfTPqptpNnIgDRHyNGvwyEuoFMibLDQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=AJFUHFUC; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::102b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::102b; helo=mail-pj1-x102b.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=AJFUHFUC
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 405B3407F9
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 07:56:20 +0000 (UTC)
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-3ac77270fbfso1738934a91.2
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 00:56:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792482980; cv=none;
 d=google.com; s=arc-20260327;
 b=S9JUJqTicpulKmoMRH6seue00S1PmD8x7HzrVGI0oXR5oE6q9RWnTISDjTNu1xRrT/
 unctKOMVe8pZ6S4OwXybUIdW6FsTlmj9+BLpgnquKmLFS/MpOAY41MHP8TjwJeTUPxuJ
 LD4dqhh8GpDc/XuhwxBdl7KhaF6/YebDm2MPVxT9wAaGKbCfuXsPmVkcyTTxa0TdXHbq
 tov1atpDR7ZG1ySGKdZg6jPaxnXeXeV/Nikw0/ECZamFM5Df41o2qMB5Op481r5nsNmF
 J/d6/xjaw2cG4ZezFJUN2acAP+KjYnmDO0GTVld4b0PW+8GWPAciYH/wEr96njJhntPZ
 dLNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=FVaOn3Tgw1s2wRM05OiNju2ddboIn0SnRt2C/OvR1KI=;
 fh=zAXIRpz4b0tlIYbplbg7uwQgk2XZdCIXQ4nALaXxgGc=;
 b=OVta9ZI06UPe+FTX4Nuik4v54Oig9MhkPOFNIsp7U2/+ZQS7mFZnNn+dj0Nv54pZsx
 a3NcIcjXUL4gro9VI1q78iabBAgzI/RVMF0+N8kiJeEO1203UV5Kn1arNFoUTUld5+ve
 O4pswdntf2M5OibjX8aR4I2sfu0ksA5Gao1IQLsIh6M0lytHBAdJuj+WZu3BI3cAi5hW
 sxiRXfgZzDFT5JhV2y2uGpreS51jpGSZXsES956XmIIRaFoqsTbbrV/62LzOMuZL0pdZ
 luKVHYvjDkVD+SOyDnyfpiHbHei2YtcC717nqlkpKWtdGuHBcoovM3STyTk+iXVpLHKf
 1gWw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792482980; x=1793087780;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=FVaOn3Tgw1s2wRM05OiNju2ddboIn0SnRt2C/OvR1KI=;
 b=AJFUHFUCaNPuNjGbGvuJNSPRUTwp30R3OFUoO8Y/KanlR7krHv6R1qwwB6cZh/Yzt+
 n3TXSv7jG1HaxWm4Ha5InfoW5gLNQyMGh4EMA6bzpt3p3/VERS0MU+ZhiYx7vUKqKka/
 Xu8IZbwRGbXCdLXOwK7Q4hkDVYmJoO8TIxS3Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792482980; x=1793087780;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=FVaOn3Tgw1s2wRM05OiNju2ddboIn0SnRt2C/OvR1KI=;
 b=xj4QCeQn8QemA2plLDAwM0BcoPoJWHKVy0GOt0/zeQ13SOd54LNXGTCWtgTFkbgXMz
 /jLgNEzBZNsqGfK7fP+WL7NrJ1pBHEE177AdN6vwJOAYGO6QQV254FbwkSg07ND5w1te
 3KZtS7m9Optml/aXbBXFJsIQ2kT9VfsqruE4QbSx3jVJg0VCtBQ2ZHmX4kjC4HAboI2a
 gmr4QI0cquaGHKIFHxKDZPJa8MR30P5+Uh60RuEHn4fQVu9jRVqNk3/xK9rEkOVsfI65
 mcAPWCQ/g094t4RpCsytgBAPOAOrWCFp5MZah4Uz05rLPMPb8L7CbLBb56YZGAmHN3fK
 wBAQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByE26AW+J9FVDX+UQ3DMWbJJx0yDgcalhVYcZ6JcTE2Qi/CqkHnYDJpgzcGw9u14CmYBWhXvo0=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIdxgfh5kjQ6D6yxodTq2nPEUuhG1NuYk9tBnJaG4eaWAWf01dn
 zO35Wh0slyBgVmrksO6U10Pu1kbZ7YSCn0RuEJHjhDlWGkYyrR4XxOxEonALLcWws9r95TzypMO
 HjaRjLs7hpaaS1C65ODikVmIJ6itz5CrCffq2fmZS
X-Gm-Gg: AYBFou2SwRXdG83D+sN/hHq45V16thUuN0SFP1Svc4qKFHlqze7VkLXprDGIVPyq8H3
 Wy1N2VpAGoJyKF8lFDmhhmPmvNWRVJ4WN8OgpwgiyY3S4wZguStSYM0urY1dVR4vXmFxPz7Vsrz
 VimmZ8uEKPFiZ19ZVQ5WbUYkKhcLP/plvWB3UMXLU8ByRZLzDtXlpEcP8+jLWRxfUfPPyRUbScB
 xPGdhnOcXSpban0aCJkrS7pkjsjO9tl6HwtMadyGcEOBRG58ZqBJYm67T9EWHhK4jIhg+BXIakV
 ahwOhOY94IVDHKBnOjktdVErpzjmsaDUdfmMi09jXMMkxk6RLq6LHFbK/h34dT/bKFzLkKHpsto
 m/fnSKA0IVDUCF5uXFY897bYRDmS4FHdi0IU=
X-Received: by 2002:a17:90b:4ac3:b0:3ac:7874:639e with SMTP id
 98e67ed59e1d1-3acef4fb85dmr8993006a91.46.1792482980245; Tue, 20 Oct 2026
 00:56:20 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 20 Oct 2026 02:56:13 -0500
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 10:31:54 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <d21c48b8c37cb9225e76c996a102a3576fbd2e76.1791966831.git.daniel@makrotopia.org>
References: <cover.1791966831.git.daniel@makrotopia.org>
 <d21c48b8c37cb9225e76c996a102a3576fbd2e76.1791966831.git.daniel@makrotopia.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 20 Oct 2026 02:56:13 -0500
X-Gm-Features: AclHuK8bRi4jJSHiZxig5ErztJuEA8-B0tAzpKj1CvYK6FHvbRjWS5xT63z1IWc
Message-ID: <CAFLszTivif1oLe42_9uR46GRYtku-4u4ci6-L5hPL1h6F=eLsA@mail.gmail.com>
Subject: Re: [PATCH 04/11] test: boot: imagemap: declare locals at the top
To: daniel@makrotopia.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Aristo Chen <aristo.chen@canonical.com>, Vincent Jardin <vjardin@free.fr>, 
 Anton Ivanov <anton@binarly.io>, Randolph Sapp <rs@ti.com>,
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

On 2026-10-14T08:38:38, Daniel Golle <daniel@makrotopia.org> wrote:
> test: boot: imagemap: declare locals at the top
>
> Two tests declare variables away from the top of the function body: the
> extend test wraps its last assertions in an anonymous block to scope p3
> and p2_end, and the out-of-bounds test declares dst after a statement.
> Neither shape is used elsewhere in U-Boot.
>
> Hoist all four to the declaration block.
>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
>
>  test/boot/imagemap.c | 26 ++++++++++++--------------
>  1 file changed, 12 insertions(+), 14 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
