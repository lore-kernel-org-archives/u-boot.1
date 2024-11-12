Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB7A1D32D8E
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 10:40:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 664308931D;
	Tue, 12 Nov 2024 11:40:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="PKWX3g37";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 435C6893BC; Tue, 12 Nov 2024 11:40:54 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 51ECF89227
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 11:40:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id E179040CE6
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 10:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1731408051;
 bh=IB3/STKj0oXp2gl4HbPF1zc4lBV0LeGsFebCDpUCDYE=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=PKWX3g37aBDRBf+AIver2gD3UZWdb7/25NleflB3MxmF8+e6fAsnRSrmmlTqSB/x6
 Koztmm7yV2mgkdsim6t2+TTtASCr39nU86CVuJkh0WlFwL6j7VWI//kETu9yAxZomH
 KeNQcPWDfpfUBtGTJldIfBO3TNRwBQOjVgDctDZQrwE3NSdOiUV6CXGdX6uUGnnJYp
 +p92SFxHVCPcHryvomicVpy1/Ha3CUBrmTTRxp7rjxS0xyk6PUR0qckxopXZZNPgC+
 ruyTBvaUzRE/QWMGKvMZ7HsmVmTMEUdNqlU8Iod88OuZ5+3uaAiNh4aGwDG+LEm7yb
 CM2M/DcWxqiCw==
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43151e4ef43so39129485e9.3
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 02:40:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731408051; x=1732012851;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IB3/STKj0oXp2gl4HbPF1zc4lBV0LeGsFebCDpUCDYE=;
 b=QoI7ORrd17SAthVacoWyLBmiauaPwZSFAviORgRB6O+3pvloQxFCAmsgmMN9IfhEYL
 cxNVDt3bPiirN5F/uLakdS19y3ZxK6bobychK4DCN/r9u/MgaK8awtq52gDiErUvSawk
 dk5H9dn3jFUws34eRMCVcRIQx4fz4VWHgPsJOyk2Sh8VGkmUw5Ho5/xOM+I4lIaPu+0G
 iGxtiQ2Ayt3tZeOyS7pN4ZNKR4/Kj/AnyxQkOWLpoOqzEksKzFgWbL0gaAfWRzHGVv23
 ukknVnWWb0bw5aycdPhVu31s1Dh6vi0Q96BxY4C3U2XECK9DIheu5YgQQtKsCFvIWgQI
 nKXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWj+Ntl4GjrrfIFnSkfIxkUXO0ULfu3Z4W8QK7A2mIPf+UoPYq9P31kzdYJC/s+OSS+nFi/uIY=@lists.denx.de
X-Gm-Message-State: AOJu0YzECaJdfUlz9v4vXkpECINm51HqVcxAPTqVlh0wV1acJ3LkUN+P
 AMPipbapZC7cehJdDxy/Sa2dpOudbW8ia50pTzX7WBOgrUwzZf0sHL6olmk9BVyU0qgY+GPdB+D
 vX26YlS4tEPlVQsOqQzD+YiVR8E+9wFQwYJBS2WZOlbTGZDKKKEqZ8xBAIT9VmFbNPJU=
X-Received: by 2002:a05:600c:46ca:b0:42c:bd4d:e8ba with SMTP id
 5b1f17b1804b1-432b7502429mr136170075e9.8.1731408050998; 
 Tue, 12 Nov 2024 02:40:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGGvO6ywrOvWheApyosaC7/P0J//e5RMrwVK+PEzt0Ok/dkM+8TE9CeSO0FHWplGuunD8oS/g==
X-Received: by 2002:a05:600c:46ca:b0:42c:bd4d:e8ba with SMTP id
 5b1f17b1804b1-432b7502429mr136169865e9.8.1731408050648; 
 Tue, 12 Nov 2024 02:40:50 -0800 (PST)
Received: from [192.168.103.101]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432b04753d5sm212821305e9.0.2024.11.12.02.40.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Nov 2024 02:40:50 -0800 (PST)
Message-ID: <895fd71c-d27f-47b8-9448-b5c4c4d3b816@canonical.com>
Date: Tue, 12 Nov 2024 11:40:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] configs: add 'nvme scan' to preboot
To: Fabio Estevam <festevam@gmail.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Green Wan
 <green.wan@sifive.com>, Yong-Xuan Wang <yongxuan.wang@sifive.com>,
 u-boot@lists.denx.de, Yuri Zaporozhets <yuriz@vodafonemail.de>,
 Simon Glass <sjg@chromium.org>
References: <20241112102415.37335-1-heinrich.schuchardt@canonical.com>
 <CAOMZO5Afp9R_BHVv5Y72YUpRjrLpS083fs_PUenmLv95qHNEAg@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAOMZO5Afp9R_BHVv5Y72YUpRjrLpS083fs_PUenmLv95qHNEAg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 12.11.24 11:40, Fabio Estevam wrote:
> On Tue, Nov 12, 2024 at 7:33 AM Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
> 
> The 'configs' in the Subject is too generic.
> 
> It would be better to add write:
> 
> sifive_unmatched: add 'nvme scan' to preboot


See v2

Best regards

Heinrich
