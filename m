Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0F0606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 21:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=q2Ig9Y0+;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=panWSBbd
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7D41940A7B;
	Wed, 28 Oct 2026 21:40:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id n_ZJIRALSRYp; Wed, 28 Oct 2026 21:40:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3DE1340A6B
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793223608;
	b=SS67RVj1Y49X5G+6u3EFKOgO6uLW84ZPKy/uDypSKS0RNBgA70DmtUnDIq8SbfHDxCo8
	 VciQhBJ0sJkCHZ4BuVNIjzzcs36Uxd34UcExVDxzYErs0+iQfVKOh2XwcwemKc9Dmc0Ix
	 OZ/1Ps8l9ZSBbUjxPCtool06xCLgTl2Mubs0IHfjwGE/WsqmY05wf2qqnNDOlLSv7XgwR
	 zwuHXEPjwsiFDVZk2Nbsd77kUiSltJ9krnCyWJV7b5PNBnRIYOF7+ugvpw4I7hckjxIRJ
	 /+Ucbc87MQXWjIoJ2KQ83tsaBP6VBspEm6XIxzrHRFSTS3LKWfw9psLNlqLgLFN/O3w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793223608;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=2S4zu2BIr5NXnUXKpTaKrf5BSSSZixRgwusaWa29VCI=;
	b=WEyv+cUaQdhX+Ic6yRLKEJGQGHKzv9ERtnbhze+E4hUbGotn73ZMfqn1tSYERvsGut9m
	 gKkrmKkNFbT1WbWEcXRfKFlxZ65A5NOo4n7CQe2mU/HmRcOX3ZwI+6ZlQ02nrBNavWA62
	 3FMP7eMjR/oogjHWUhcFB+7WHSzB06FEbdDdZ2a6wBxqqNr7UCPIWTcgtccOWOyXh13lX
	 pw5wW1ocxkBO9zrsKp9hl6+Bh4CzNa4oKd7XmB5pc5ezCY4My+79RGwcVgqLUnllH3Bd1
	 IGAJYBaZpp0BOTmmNP/OuQtyQ0RClhjuepBjuJgMoqBOwYbpcYyfMCyuhj0VEgYtrvQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793223608;
	bh=2S4zu2BIr5NXnUXKpTaKrf5BSSSZixRgwusaWa29VCI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=q2Ig9Y0+YdiFW/ANaS6lA/ENlBEYkm4iKVowzDDvJoTYeK1pWWfe4vFrEJ4ufLzCR
	 5SYqUmV5uhGDF0JpujpCQXE0G05phzudGBOmj/qd+RvlfPoHnlOCKv3uEaQI8rBKzf
	 4aIXzHZx9kslHujU4tZdMrHrYZza5cJ03hmzziVq0xnIV5xO4aAFS0juM03lC4DkQX
	 xWgex4LFrkP3d/6LBJBucJPg0HbOdct1udNG5PWEjJ7EDFEK6zb/nxyGatlnuR3+gk
	 aCsqRwdi7A5coQVC591dqLUztRnp6BPN1W81cR6ZHal9bczn2aWE1Onko7LqObTFGj
	 MJzCHEwWO/FEg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3DE1340A6B;
	Wed, 28 Oct 2026 21:40:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1662C235
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 21:03:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 07C7C81126
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 21:03:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UBsG_tvflGqY for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 21:03:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 60F7481116
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::7"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793221397;
 b=Zc7c9+WYQ/pYx4qkxZRKJ+vEWEuFDkTosYVFs1DP0wR0yzz3JGX3Ja6kpDRywg+k1AOA
 Lo92G12uEY//B2wKqeJVJfulkgHNl1VtL2jl5z05mIeHYsHOZV/mMZITo6RrcHjgE+f9y
 fmrOnXPbzNkOMpxnLqYQzgcJr/WXUm41K8dRSXgLXupEaLP1Tpxg9C7gdw2Rlo8lmc6au
 cevqT50S5+clzOtJjLkp2YcRUD5/HTJgJ1jlwZ6JMdSL53x7GfiL3cQwUmlB6MpnY5JmK
 qld6b462LlqV1QBuIBxU3Yq4ZMUuevvZAnTe2ymxEohLxnUgGEwIf/GWhAs1iZjQfpA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793221397;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
 bh=2S4zu2BIr5NXnUXKpTaKrf5BSSSZixRgwusaWa29VCI=;
 b=P2dLIcl5L3JOgHeyNpidkewNtwkLBHJcyDmsG2cMNkEEgxLki3ykgoEEdqpP2KMmh/aO
 rhhsgpyneDAGOZG65H0Yd5ibs2TD7nrWPYWGYf4Pd+XbhNYwXKfU/MRViU/JzrfvWPixS
 2NabKyJsRl8EsglcFSu5aenKlJG8Zs9YzFz8ZVNvKqUfOMEbiMAr40zr5yIKej167XNAf
 /sBkLA/RTf8LqLozlPrVY5HQSAHfdctNpi5JolwAcyoMclNeG/pQ+ZIah30aCi+K9zx+L
 Y0Z8ZwWZPe6j1P3sKq87EIJZJjZ+IKdqrKZRcHNxonVf+oioswgC0fPn8s9vGDfC1xQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=panWSBbd; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::7"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::7;
 helo=mail-oo2-x07.google.com; envelope-from=ryanbrue.dev@gmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=panWSBbd
Received: from mail-oo2-x07.google.com (mail-oo2-x07.google.com
 [IPv6:2607:f8b0:4864:31::7])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 60F7481116
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 21:03:16 +0000 (UTC)
Received: by mail-oo2-x07.google.com with SMTP id
 006d021491bc7-6dcee5a2fa8so183014eaf.1
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793221396; x=1793826196;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=2S4zu2BIr5NXnUXKpTaKrf5BSSSZixRgwusaWa29VCI=;
 b=panWSBbd99WPlLmYgIwEZhtHdJfd5m90n1xoXSMLhsyq4iXQtejz4qu0AebWxOpLxP
 9MwniRWqBwvflEhwSLCn65cKzySL2CFxLguE8n/AaEpgxqZ05MoWGe95MN0dLQCkbwj8
 B+DT2WrZDR8hUAZ03NTsf7ngSIFaeYEEfgdSxGRqWTsut8IqPhM92xJBHo9Co9AQ9k/H
 LJg6RDWk/rN67RvA8MywGAGmNfcsWuIaI1ytW6LpAcrlDaS68W355xziFF+r3+ceIBk3
 CKD6V3Bo56vC9seOoquAT6jwCTpVXxKJ4JfYkw5rjVkgLErPXzFjlDEXygW97dsn8j8Y
 X8dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793221396; x=1793826196;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2S4zu2BIr5NXnUXKpTaKrf5BSSSZixRgwusaWa29VCI=;
 b=BQfe6CjMk85TJPtUgwZcgrbH4pTTOGxaH2uiW+s5oN8hCCEO2844LrJxwYi40CfWKd
 KDeNkoR3tErMwc4i6i9+eVP2O3RykGbrlJd0fnoBIlqVZX2fZzuOQHsMLTpeqqvwhA2x
 qvT5bcA2wiyi6mV0SC7QyfeP8XI/Pc6GlkVay5zn24P6CttWNWy8xG75PDk7umh3Y3gF
 x19uGEQ04PRJdE3d9kXO20V0CVzq118FLlpRnt+vN+E3S55srwxpvsX7XaOFDL23Mmqg
 5qxVDk0vunv3X4nAJgn7ATM3TFS47OKoHDENmmqOY7z6ME+HexrNNmRH5foDYYL6mSTk
 KiJA==
X-Gm-Message-State: AFq9FYLVWP6C+qCGHT7WSi2KcmxRQRSbH/Gd8V/jgoEz7hl8vC8iMdkf
 Pf4E5lNmLmwVc+00nwhLlxJuNKHdj1YkjxAutCGjoMIFkhc6OvPo3Ww0imJXRp82nF4=
X-Gm-Gg: AYBFou1/HgDXGwjZtx3dxbtRgpmlj2Qvym/Qqizq7ES6tpxmh/GqRkwYmQJfJ+37fsz
 FkFRMD/Q1B72ZVNZP7jGSfLujq3iMdJBq26Qhlz6RQFgJuolbVgPFw4DL+yW//K6oyQmFNcIiqr
 4o2sjjuipt2Tj4hCdGvxMCh/aRNPKgLFun24jyVkICGu7vH79RyANSf8fNnM6vqzUgGT5HT+MSL
 BrJc4GHN9Ts1HPc4KVYqgEa1kklPzsOusHDk8vW3iuNAX2QXWlfv4jCxWvjuIn9YmVa1b5cahEn
 zo3cmLVHH5mFtTqQWWGZ1RYdcdpAnXeB1QMIZVD8e3/OKzBUumq0vIr6dUzAgKW6/fRd6KmVGi3
 8X7HCeE0XvA/RsnjXp/Vg44VMxKlTjeAKJCAioFXpinIu9e6yiliPfzWrUVJ4ikdpTO54zO1aSM
 z8TRpyX2yau8ar5qadR1B21qxZGM9nguUP+gSr8wLJ+zRIpUa4Yl/uSfZmP6pFmzcxBbZ6Xk65e
 k24B5qrDOzWZ/XFx3a7cXi/aSTiXy5ylGaNhJbXV5PWB/v92CjOx8D7WdZfqN3K3jTUnNaFXgjv
 de69YCe0nAxq5AJBFXy1IgG0Sk2gYsQ2gxAX4nBeNRebao1Rvo/VOQDIgV4985He4uYcDc+kKBF
 bsotblAq3cAP44hLmWIgg
X-Received: by 2002:a05:6820:811:b0:713:f236:a79b with SMTP id
 006d021491bc7-714ddd2a2f9mr421817eaf.11.1793221395785; 
 Wed, 28 Oct 2026 14:03:15 -0700 (PDT)
Received: from [10.10.121.179] (wsip-64-207-253-118.tu.ok.cox.net.
 [64.207.253.118]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-71426f16f66sm2335279eaf.0.2026.10.28.14.03.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Oct 2026 14:03:14 -0700 (PDT)
Message-ID: <1eb09c07-a602-4f61-a821-b437cce86cc5@gmail.com>
Date: Wed, 28 Oct 2026 16:03:13 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] misc: Provide stubs when MISC is disabled
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Sean Anderson <seanga2@gmail.com>,
 Simon Glass <sjg@chromium.org>
References: <20261028-b4-rbrue-suez-upstreaming-misc-stubs-v1-1-9a88ac233299@gmail.com>
Content-Language: en-US
From: Ryan Brue <ryanbrue.dev@gmail.com>
In-Reply-To: <20261028-b4-rbrue-suez-upstreaming-misc-stubs-v1-1-9a88ac233299@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Wed, 28 Oct 2026 21:39:59 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

FYI, this is a PATCH RESEND only because I had not signed up for the 
u-boot mailing list prior to sending, so the message got held.

Best regards,

Ryan Brue
