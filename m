Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D358E606A323
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 13:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=GUOfCsRJ;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=NgdTMgSv
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B0311608C5;
	Wed, 21 Oct 2026 13:13:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nGJJ2o4txVdw; Wed, 21 Oct 2026 13:13:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E279D60888
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792588429;
	b=ohYUib//6oQqBBEPzZ5sc2BHsGsv3M3PBsWqxqeDMb5jFIXQ6YiYWKOKxJf1OEGkTQ39
	 Tx6GFFQbrOJt2Xf/ydOAXjLAfrLIqtH4wUcYhbpZFKaW/m2C7DwRFMgfwcpBuiICIUcsF
	 yqM0EZOGnIFVwYfcBo6NVS+dAvgXjGFy1sFwEvvFdD9a0+oatRHyOle8oZi54cX/qadDg
	 Djxhp6zCIkUtxJ6MHSk1yZOpuzxPABt1AAiyGto7qzsN56XgTn1q8LHbVMTNkC6t+Pc4f
	 W/BRcweDMSp2xGx+9SLV/cP7ISGZNmrJSto5xOBeHozchCv4llpUWlXqsJ+GIcQpkQg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792588429;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=B5PKB0zRiNGDsALTs2ZYqQYan9KRbZekbjXXrUAQz7Y=;
	b=q8iLIL4lhez7JomeXhnI3i5aeSVaC44rpxKxuk8QOtdaJ1uRz631ZAjbGHTt3cqZLs9d
	 dMkHhqeXojai3u4Bi+aA/VfK5gAV+tHzLxZhhphxLRs0sIkNrhXVhmhlCdFlR5hUMYcXc
	 8p3O9rG9edbe/mUKYc5N1tA34mxMTnzZo/PUwBIIwfJZqP4bVlkWk/iR80oK7Qh3m3UBi
	 5+QAkzRN5cySjm9s+tS0qI/k5eckIcJ6ZSXQBG5HTUjP4LyhmYSJS8wzLtaE5rEJvrIAw
	 70KJbg8U2RqW95OPDMwcUEP9Onp5FGSWAdkJqlpj/D4XfeIZT8SEhuxqh9rHVa1ob7w==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792588429;
	bh=B5PKB0zRiNGDsALTs2ZYqQYan9KRbZekbjXXrUAQz7Y=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GUOfCsRJRbqZ61WOdw7sTuvLEKKLqiSAqFyA8bzRk7JeG428FQqI/Me6okc4McBJ0
	 fBCsviF4U99YELTy2LplN+WYzG78JnRqRIJsJpc8/z4OAWzemGaE7Qf+0I5gnQOKMf
	 hTDP0Ufc6OM+EXdocCy+WjOrF/uaua6dHvBTCIZs+xLSy7Mwf7+FCHNPQwAAjN+H62
	 RvFIFf6KEG8uZ4zJGEeya4uuS+WnOUbzdcOx9Zge8EvLLYLSa8QiKYTNvZB6fflgi1
	 GBvLEP1iUe7VL64TqEJmc8rd/eYqCNXhw0NhczpTDBn3E+CmVisguwzrsNvj0l5k31
	 TVECo480oLyYA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E279D60888;
	Wed, 21 Oct 2026 13:13:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 60B7B23A
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 13:13:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 43360403AF
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 13:13:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Lwt3qc7nVeB5 for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 13:13:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 9B7E3403AD
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::629"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792588425;
 b=nLWUdNmnV4A0bcbWP4V+LM44sYiJd0QUETqeScWN0LX5hHa56NfA2yYS7ZPYKkWQTEu6
 +Xx05bqm8ID39BDYFIQu0Pf22EjGH16ozoOxX5FrINkQSBj/A6m/mG50fqq+nLuno7onq
 7So2X6MpqEQnK71P0Z4FvdFz9ma6FRqwfGqc+/E1fQuMlQFqRxHO/nTPmaiMau335o+3L
 Py129hFJkZFWTXjBnN2frlw0enxsoM8BfelhHM6tMVQ8t1WFGhzw896EATiminoOo6/KD
 L5ViaeEvP6OALPP10vYnGmq5inbkXYQo7ZLiLKEOuzhtZ+3rmsayeRKHpB2PJrZekmQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792588425;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=B5PKB0zRiNGDsALTs2ZYqQYan9KRbZekbjXXrUAQz7Y=;
 b=gByt/cqoz2Jim93uyoCzvFpYknowt6kloAgBD9ML4SWCiCoqSWsUEQrs8rMyN7j8JKdw
 ZDnam96o+1B40IxOtPEZzYmATP4VQxJYBdNupNCwLC+Mk17bP3ElAiuBcq4ulH9x5FLDN
 KAz9ZmKg9FjIi54WCvJgzaRZmSqqUMsOwVGa35gP68YbTcsoHAoC2nTJC2JmWD1DeGaay
 s/vZZRkNPcTLPHhMiUneWDS5t5FO8tV06EjTSTvuuvKPY5clL40oJ7xQO670V+MtNaRW5
 0glNsHt2Uo7y/F4CRNhi+0cMO4aFnG5NafVnVwnT8W01XuDEB6vXEEMQ1xZgYL5gVNg==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=NgdTMgSv; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::629"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::629; helo=mail-pl1-x629.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=NgdTMgSv
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9B7E3403AD
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 13:13:45 +0000 (UTC)
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2e8b20a899fso3677945ad.1
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 06:13:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792588425; cv=none;
 d=google.com; s=arc-20260327;
 b=J6WE4uAfV9KdNxwwWCfotvuJf7sWRG3aCeTIAgTaiUtCqUxhvR/fD0rVVwQChpTdSW
 8acrFyOUjfzn4k0KCKQCdkW9dNCZ9fet4bMyBvULl/tI6gUwyN5kXB5ZZMLUCbudl2UI
 yZtRcA6tF7iv9HzH/IndY4VH/v2FTULry0U1FdkkN+bWvSF5UAR60fZ0LxEgHrUh72mp
 oZXSbJEUufDx65PrXv4b7YVAVrXe8QsUEbnm2jGuetWanh2M/C2ksmIxYD/VhWrtph2v
 N+k4fIpDfgpl82W4qLaytr9zRuNwBUtzmliwrlROGmLC+e9BYmqknkhvUflHrs5LxYDR
 tDhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=B5PKB0zRiNGDsALTs2ZYqQYan9KRbZekbjXXrUAQz7Y=;
 fh=NE69m14VdS+iLI1i0Nk+Z7UEeZ7dZqybdllMvaA72+o=;
 b=ViUwy2XdweOpQ7Im8a7DIzkR3vzrTBQFyofkvib/GnwzwKcVsjfP/BzukwxuO8e8oX
 chhi+dwXkG2Qzjv69yzhkoh0DbUFCuGO2cT/Hm4d757DpGTA8O89v9YIcyb38wCO5Vo3
 0y6XF45t3Iax70n8HuV/f8PeVAXQGAERKy3JBPX0Hfd6Aw28gA9gTvA+SOZeSAL1l0MK
 OnKRjaBiaCmJICwvFWQ09ypBgV6Ic7/czTET2YlCqXJuI8OsXFNx3ex9XA/NbgK99VUk
 KW8jBjjy80C5z5wDVtjL0KQ8gjmjEaNFuPwUy5mG8WmRUSZ7HLR7Y+8udw5SXXJy6+hr
 XubQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792588425; x=1793193225;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=B5PKB0zRiNGDsALTs2ZYqQYan9KRbZekbjXXrUAQz7Y=;
 b=NgdTMgSv0yGDx3yt+MQcd9oU8A87RpwOjBJYJzwb0K2ICKrXHHO7gmRZtt8izIawGh
 01Hw/t5p3W6Im/XVw3jeikbPqcQWBZwGp6yKfzw4H4Rc9j5Fbal31uf3zF32DTcbY8RV
 A0kUYfLcHWb/Ihy3VzYn5o2J0X2b52x0RUIgk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792588425; x=1793193225;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=B5PKB0zRiNGDsALTs2ZYqQYan9KRbZekbjXXrUAQz7Y=;
 b=xGm+UWlc+SvdYESH5/RMiT+9v5z1XQyOci32adO4LfmKzPZ1Ay8rnuKmdeFBsbL+nP
 ZqlpwCUptM4j7zywjdWMt+ZmyvZD2HIHgkZgwNxoWmTyB3/J2nMGJGt/NlUQFa/nNgq0
 SI3HKt+vewYCxlq88++8lLCAjb0W4shGznxlJREUbb1dqOLQiDg74m0wEV+/VSNNCYuH
 pu0ggrzirG706hqxQNMoI5FqJcGvGrE7xK0NsxcBXN4y9z3SR98ur6c0amB6TwlfhTyz
 c9fKH3kirIFzkWlrgi096EQErEcsYwNBfbLnN4a3R79z4ClpwsjU5wvCf4R0xBWQLMLJ
 l0rA==
X-Gm-Message-State: AFq9FYLMfUMi47mJAJMWQ9aB38nD5HKDF4R4JtGNivlMU0ufptUT428b
 HyUytHKu/+VwG/9wvIAiJzRVQ+WjgMN5f5k2gUwFZSYkftd9TxOiscbAjLPDxr0dZ27tWDY8Abr
 LGz339HqODl4Yb2n3l2sXxZf8W5XKdE9/ypXdFDx8T1hjTJBqdqd+2Q==
X-Gm-Gg: AYBFou3aJTSsWx8tJDfXOmQymQtyNbZBRMK+slCxVtNHF9AuiAh+GwbAfpTUruDs1md
 xBWK7CnxXX9nbC8aLoH8xh/+/OMuZsVUPpHhJEm+wPFeADC7SIyj6E3EBA5mabpx3rPfieRRVCT
 fD62gGVQ4Rl3cVzxQIB8kOq1cQ/9ovMMjilLdgJYqIJPIIaLaB5vEwUzMBRmf7efcKQFav0K+Bc
 WLRnR0mll2YvIZePqt56v4cy4pqwbxC9oE1ZiRpcBQgGh/hKSzQwh1azxL0Yg25plMJiw9xReoM
 AVYNIeAPlE32aQHCbFlr9kCKwkov+wqpuewy8ng9Q6h9YwMYgxQcatDzeI+rtxV5Ggk/DvNmr+X
 m0gyCxKH5i/G0pT/2kUWmUgnMCNyUZmBLTpo=
X-Received: by 2002:a17:903:fa5:b0:2e9:64b9:a33d with SMTP id
 d9443c01a7336-2ea43febd0cmr15991085ad.56.1792588424104; Wed, 21 Oct 2026
 06:13:44 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 21 Oct 2026 06:13:39 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 21 Oct 2026 11:30:04 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260824-improve-logging-on-missing-uclass-v2-3-4bee2cdff72b@baylibre.com>
References: <20260824-improve-logging-on-missing-uclass-v2-0-4bee2cdff72b@baylibre.com>
 <20260824-improve-logging-on-missing-uclass-v2-3-4bee2cdff72b@baylibre.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 21 Oct 2026 06:13:39 -0700
X-Gm-Features: AclHuK8GUgYpYY84r3nIV6Pn67waLEayfxeTqx5MKRahajJ6VdMxmvD31KSgRqU
Message-ID: <CAFLszTg5Cn7-BWH7mkHcL=Lob2LdTfROmALyao--Q3CxsLrvrQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] initcall: initcall_evt: display error code on error
To: jstephan@baylibre.com
Cc: u-boot@lists.u-boot-project.org, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>, dlechner@baylibre.com
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

On 2026-08-24T08:44:18, Julien Stephan <jstephan@baylibre.com> wrote:
> initcall: initcall_evt: display error code on error
>
> Currently when an initcall/initcall_evt fails the error code is not
> displayed. Display it, along with the corresponding error string if
> ERRNO_STR is enabled.
>
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
>
>  include/initcall.h | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
