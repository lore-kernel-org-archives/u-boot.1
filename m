Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760EE60A5BC5
	for <u-boot@archiver.kernel.org>; Thu,  5 Nov 2026 10:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=GNHdbUa1;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=NMDF1WS5
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4EDAD80C97;
	Thu,  5 Nov 2026 10:08:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IbrSJAro9BHf; Thu,  5 Nov 2026 10:08:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9E76A80C4E
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793873333;
	b=BrNQBYtcUAybWAeV/9lvTQWtLV2+dV/mPrizv26tgFqJbT+ZnplRO8eBHXaQ7YVgNG5q
	 KL7By0Z0Gle/ahBeNQve6T/NI5QUw3uOzJpz7ktw97neT0b9cvYqs7/3EFYxMIMLyjfBr
	 7rVlWTKczg2aztwfhe/q9tH4RgEKogh/XG8ojx6IFNaUWzcvp8l1uPeLiWcUV+A3YdUzr
	 uhz8IVXGmsUA3DDS+ykDXypgguE8Zu5AI6UfMVqsFWhg/J/alU9lsv3/wxk3GTJ1Hpd9G
	 Av89fsHZmav+on5DB5PH/OnpT2/5wWaNk2WEFfrgUsmFNxzTMBjr5BwplM5++sTDZ2w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793873333;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:Autocrypt:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=AFwHCbtz4FAb0BP1tvAH1xwgCaznCgnoIb5PqLWC8bE=;
	b=BBUvXEWN5zdcT7kzPQKE7H3P48/PQJ8liFZLs2dpBPMlAETgnVNb7UK47Diu0ETnqAHl
	 MhTcquFpn+RQKbiyF8ny3H9WjPXnTAnYosnbEZbziTElGXpkhoAzSnk9UhKn2Etvlz7GU
	 ell1c2HfSSGQa1WKKyfyE7gsxSldQm9/tISUnLH36BgnPiELJj4FN1FrZgVleSbSYWtJg
	 ytz3KP6SL6wD+qkRtVjJECDluz0e2/WmEy9gTsPNxqElSEGKg0axNW6nBaASQ2pbsVXO3
	 0w3H/Us6XTWtILp5juTUFap2/M/pA1yYASwlaTbYWZ8rtiPl2xFun3mOVjtKsb6AwrA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793873333;
	bh=AFwHCbtz4FAb0BP1tvAH1xwgCaznCgnoIb5PqLWC8bE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GNHdbUa14QhFzdmGmhIQkqzrniBpM51Uv+sttjTmTjgaMndxAcUQrJHkY61DNVSad
	 3/f2yzLu2RMVuJ2SMJyofTcPA/q8oNB81oeSImVx5EQ86+8QmS1WTHCtNLSKWIHsuE
	 KAEts9o8JKZqCd2L372anLrpYaIT0QyV7W6LYWP/9SMOXUy/pqwNQF/L3HSeD0tf1x
	 HHJJznbK8J+yZXKEykSVuD29MATq84o8axLO2QSIusPMjDtnruKo+l0khJNPHEdZ/g
	 0moOdvbmhjMv5FUIg+jog9V6IWDGS4lpUbRHAwtMlaCxXHaY+YGiUUTh/AWYWigbOm
	 ngsgBQdVkdUpQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9E76A80C4E;
	Thu,  5 Nov 2026 10:08:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 58B652AC
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 10:08:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4A29860833
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 10:08:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gmz5i7j8qOEo for <u-boot@lists.u-boot-project.org>;
 Thu,  5 Nov 2026 10:08:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 32A98606A7
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32b; helo=mail-wm1-x32b.google.com;
 envelope-from=clegoffic@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=NMDF1WS5
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 32A98606A7
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 10:08:48 +0000 (UTC)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4a5087a5348so12857205e9.0
 for <u-boot@lists.u-boot-project.org>; Thu, 05 Nov 2026 02:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793873326; x=1794478126;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=AFwHCbtz4FAb0BP1tvAH1xwgCaznCgnoIb5PqLWC8bE=;
 b=NMDF1WS5YYapvKETmoI9jmaEZWMtG9Lyt0oKcmw+MOqsWgY1tzaMMNSdm+/jmccjn6
 gMjfT6nWNtkjlub38Ptfhp9gCXBIbE0bk0B49nohhcKUGHOlFs2iOt+FqyzFahczP2fl
 8BqqdaHcdFcAHNy/WET7UPHkxAaTpCYjmqQNrJM9Z7q1e72eN8Bw/RdF8zG7bAqhnANE
 iyJKvc5lyNRT3+F7Lizl5CvKepANoD11kWqNi0OQuff7cwuXm7d8sGD74gLVQmhqsi//
 njYFI16J7oZJ3HPjRZqzidpvvIM/ogElsUlTSzobcoLTSngxDgRYwHOEy/ZPMf60QoXS
 1PPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793873326; x=1794478126;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AFwHCbtz4FAb0BP1tvAH1xwgCaznCgnoIb5PqLWC8bE=;
 b=P5P299JBXYyFfX/z3/nXf0ha2ZtkyLXdMoZ9mCu4/ATEBejuFe9itZGqnZgoqqCC6a
 GKSVwBIcOAkZr8pY9RlonudadzK2SbKb4Rbc1C0Zzpn/tatAHQs6qxgfqe0rk/pXV11X
 FqCst8C29SkuKthvgPW/QLP7SSk5eS5AiQMfmEu+AshxydB7JCheoCjM33IQE5dsfxwT
 O0KqIwd6+egxhcnqgEGR+uNUmffqSmeXkqMXfCuoVVGXJImI678x41/iVyCS0E4O1IHm
 +YDvpcuOG6mRXgcUft+wn3MGRMpkVl1H6+2t5DeGibOKzS/gDDGwT1A/ofjIaVeoNmXG
 kiSA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwkGkuVyNTm42KvDK9ixg5mKcGVlyQWNHT1ZWCVhVnBfvdUIQP4m7ysRxzDu8aW977hZwM0Zv0=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z94qf7m7g96ij6Pijj4ATkTFaNXQrCBJtPMxu1vbryfafMwGeA0
 W7TpvG+A8CGzZxL31VvYqHFlSpPJs0Fwjj+gk+fvptURDmd3VJTBhDv+eEg6v7t+KJE=
X-Gm-Gg: AYBFou0MlcR26MhVUggKsmVsMzrWCHW/CDiH15GMOv78tX1aL5Q6htLy1saz/YEtpQS
 C5T+71a4LhMyoLcaLEFjgt9PgLGxTfwB1d2SesbbPijWjh39cht52M565164Bg10108XDml7CxM
 ezoye7/GShicO0t4kcCWtGy7J5jOZCjMZZzKG8ywwsVVlZHlkM+KjYcK4uWoY75zDGw4OCIOVRW
 qGcYaKSKDcbCLCidgFL3ayNHT+KEWrvYCMcZniVJeYduIXVjLAtSE4PCXvJWmN8mmQmAa3zpbHH
 2e+9T7+b0Wnkjcf3kcEbUDUVLQtLUQnvSu2uvQTvXGzgcSjwJdOICq/8GFDfIxnLaUrWuVZWpLs
 0mi80XRdaccxshfZn3uVEmw84oFLOopU6OChHz0g51V0au13XMgemg5HMJ0hS5AIiCdAcPStc1+
 MAeEq4EzQRhHQa/wmDhu8AyGLKFg8xCRruUjuk8QY6GEYoG3dh8aqOZgvm9KSFw0YLdmASnhF7C
 8j2l3R6wzDnkas+g4kHwxx4uO/SYc+Ukm58Ri5uP7lMdXe/JRtLt9ygPERBPZT5NiRNbnu4Yvvc
 3Oe1HG9Ijb6RLut3bHpvxMgcd81RwK2sdxvGFACfQfxvIUMcTTwQ1IJIWQ==
X-Received: by 2002:a05:600c:19d1:b0:4a2:677:ad8e with SMTP id
 5b1f17b1804b1-4ac1970b9f7mr402087285e9.34.1793873326362; 
 Thu, 05 Nov 2026 02:08:46 -0800 (PST)
Received: from [192.168.1.62] (140.30.66.37.rev.sfr.net. [37.66.30.140])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48feeb51a9csm9472180f8f.59.2026.11.05.02.08.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Nov 2026 02:08:45 -0800 (PST)
Message-ID: <26d469e1-b752-4da5-ab1a-424cb3411ab9@baylibre.com>
Date: Thu, 5 Nov 2026 11:08:45 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] board: renesas: gen5-cm33: Start the generic counter
To: Marek Vasut <marek.vasut@mailbox.org>, u-boot@lists.u-boot-project.org
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
References: <20261026-clegoffic-gen5-generic-counter-v1-1-4297803e85e9@baylibre.com>
 <bfbc69c2-32fb-4d2d-858d-a4ed36ccf592@mailbox.org>
 <4c9fc2c7-c131-4e6e-908d-0a7e8e6ffb17@baylibre.com>
 <4e720f9a-be35-45a2-9d90-d574ca7b488a@mailbox.org>
 <7fc1e0d3-c7f4-45ae-914f-d485f1ed25eb@baylibre.com>
 <172cda1e-2147-4ce6-8d2d-27ddcb7cdbc2@mailbox.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?Cl=C3=A9ment_Le_Goffic?= <clegoffic@baylibre.com>
Autocrypt: addr=clegoffic@baylibre.com; keydata=
 xjMEafx9bxYJKwYBBAHaRw8BAQdAtc85GIwDXLz0rh9thWXC80Lji0otVDVncXT4qaS4j1fN
 K0Nsw6ltZW50IExlIEdvZmZpYyA8Y2xlZ29mZmljQGJheWxpYnJlLmNvbT7ClgQTFgoAPhYh
 BJjMiHuM4ZUwFqUPr36EW4KtCh6TBQJp/H1vAhsDBQkJZgGABQsJCAcCBhUKCQgLAgQWAgMB
 Ah4BAheAAAoJEH6EW4KtCh6Tt+sA/jVC35rY1npFlOy7YnncTdrID8Qf855JA78IzXgvzpGp
 AP9FkuuT80m66PP3DvgYX9kVnG17mSDKO0+v2W18v6ZgCM44BGn8fW8SCisGAQQBl1UBBQEB
 B0DMwF4u//aQyzsFlO8rPJ/cqsAuPH80IeIA3HOEo5mlVgMBCAfCfgQYFgoAJhYhBJjMiHuM
 4ZUwFqUPr36EW4KtCh6TBQJp/H1vAhsMBQkJZgGAAAoJEH6EW4KtCh6TdSgBAMDS0MiWCivt
 LjzZc9bs+P/xdXywUjDKq3lpQGJ6vZ0GAP9vI6DnN7vwVK6jt6/+0aBGkog5Ura9+WwRFEdM
 vLfPDQ==
In-Reply-To: <172cda1e-2147-4ce6-8d2d-27ddcb7cdbc2@mailbox.org>
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
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Marek,

On 11/5/26 2:41 AM, Marek Vasut wrote:
> [...]
> Why not start the timer using the SCP when there are actual users of the timer ?

I tested it and the SCP can start it. I'll move it there, so this patch can be dropped.

Best regards,
Clément
