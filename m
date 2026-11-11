Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F0E606A326
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 21:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=uOUB87e0;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=rVr3makN
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 528FA60905;
	Wed, 11 Nov 2026 21:26:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jz7z7g2AYY3f; Wed, 11 Nov 2026 21:26:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8EEBC608E7
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794432367;
	b=k9U8L1ogV2LhLnfT8PkldkgjH32vcgz4UxQh8A+PvxMLWNwNj4UkIr+aNumtdH5KcHhk
	 E2x/ZYm+UzQPIL+350hAZtMpSYq6fLI0XzQBeZKnehkRUKiabhoq5N3+RE6ftHrUAXc5C
	 K/vUmhmtDxIidjtSpFtZtFCl/4eX22mXkvM0iexqdFeZUewjNL719jmrbi8MUKmSWTYNk
	 JSVZztM+IPPy4wMfJx7tvQ2YptP7BjzJlducDgbse/UIL1YU5GtOvenD02tKXk1d/iYdB
	 sEi4EA6sIdWcpdphiormU0XZVsJi6Tw6uhY7wh0kFr1Qe4FlbGi5b8x/hWLV23EsCYA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794432367;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
	 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=XouXKd1b2ATRa0SJDYgEIqijp0bvm6ZFBKjycsxYJNI=;
	b=BaG/D52hLA5GORbDHAgLEbAVa4FOJcFZA8z9TPwpbN+IXIZisV7Y9/MopC6Pj4MC0yZz
	 Fpr7Fvm+iJfd3eZ7mMtYF3OS8zvtH5iL7nbk/oc9QIZLHaaRkkWPUZFI1lRZ/N4AYo/KV
	 szQaFsUcPIgY7/J3gpABbmG9RYYVchwuFq4m53aaiyMi5QlLw/CNHvn4JVRRA+lv9Tz4C
	 CRrz2mNiOp2l3rtJLHCHYyis4M45PW4cd0hWJu4ktoFdAUdyDEffRpPk/Jh43MITKVlP6
	 yEaBuRPdQzAlStFH+LxA0ZaVWfmcML34ZSnPEgjFuqX/26Ajua4GT3qX1FOGEmTdu4Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794432367;
	bh=XouXKd1b2ATRa0SJDYgEIqijp0bvm6ZFBKjycsxYJNI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uOUB87e0kR3S5tk3vsuYjc4apzeFt01grj8WE/OSnDToojRplwFLaoLT2rIY+8JoH
	 ZuIaJ2srMfvQiFPEVdC9l1DLd4Q0zQepuFp6EApSZ/z6ew/1XyQ2n4Il57R4NPhfa/
	 XIgvX0m8xRpwpPy3hIMYOxzxDVlKIzvTwBXWsv3jYaPlO4H9Rykaw2gWLtU37irggY
	 UkR9GxBsdX2DBAlWUP0nKbR0maMbSZwGzWcBVEEX9+g51rY2NY7dKsryJThGsKS0T6
	 K2XdYLDBVNkaAr7ZuuEKgHotKVIUP2W6OdzoSj89oXe3fy3Lof745IZ7HU843LD/Pg
	 J7xW4A5LNcKjg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8EEBC608E7;
	Wed, 11 Nov 2026 21:26:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8373FF22
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 21:26:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 68BA78121A
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 21:26:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id okbyMoUbxITV for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 21:26:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 95CCE81213
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::330"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::330; helo=mail-ot1-x330.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=rVr3makN
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 95CCE81213
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 21:26:04 +0000 (UTC)
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-844a8bf7e25so2579647a34.1
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 13:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1794432364; x=1795037164;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XouXKd1b2ATRa0SJDYgEIqijp0bvm6ZFBKjycsxYJNI=;
 b=rVr3makNahG++wOBAyvKN/AJ7AUmhMGlVV5QA6R+HDScwWfikzKxK+4FgkuZwSphUR
 XFJZ2qYAege7Tng5kCX3ndOIucA6djMyBDyk5lztAn+KamY6ZcQHXasm4ClzX7S8uND3
 bL30eZr5/uMQ7braIHj4o2cNJswRutiTOoPFc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794432364; x=1795037164;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XouXKd1b2ATRa0SJDYgEIqijp0bvm6ZFBKjycsxYJNI=;
 b=ceVqWZzGpCpnwZE+aibKHJ0vdaLpXJpLE0Duaxp5R3hhxTTJWvlgPZwE5Uj6qjpJDk
 D1fK4fGSzShpAq7HBD+tCoNXj9uvA7XiQ/86kDOwmDfz/GK7uYZz5SHJXm7ceJaFV/La
 /4qoFgh+NfJ4jYrfI1jKIbC0/bxWXw6a+xjryn5utE9j3wZnJBttO1JiiPycl3hqUPOU
 hq6+V9snJaddyakcT0PkI46MoLaEjlZkrAFxuhOqG9kfBEQ01+BCN258yrbS8gey3It8
 xX8vjShVk/tbl/kilx5MrBeGBCXzi8n57LnKoW6ZM8XZSSi7DVohNlP2LbOI7FYGZxMh
 FJNg==
X-Forwarded-Encrypted: i=1;
 AL+hErEj9fcVrbMPpz/lDws2+AtwYM5aT79aUgGsPDlqMFULPvTA6P5d/IZ9OdV8Zf7SmUhcrDykimg=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9Za7YweurQpdNlzVfOnQnaJQWlWiMJfupaHhSzwqT9BQs0VZSk
 rPXe6eJZWmJ4GNm977SkapRT+JjvKR9MCREPLzox2b3CZc47elichxbYJo2af2ZU/sd2Qtan3Zb
 cNOvJqG6+66hz
X-Gm-Gg: AYBFou3jqfZ8RN32TNTA8nu8H53K0cElE47WR+scY2LHS0hQJ2j8YquVfBZl/RxFtLL
 o4tiXi0ie2JZi0l+uY2cBRKoR6p8Sf/9L+o6txvOsqDZ3SJbPVvxVmd3VZWuHzY13mwz8F+aSP1
 gL3Jdp5YvXXDyEnenUW8ISK3NBUIxTpZOLv6XtH7eelIKh9yhO4ifh1Sv/njQK3ckP88Mq8vIbT
 IL5pb38HKdDWdOStD/Us1abvUuN5BJmBrKOo7Zu07QibxC7cxvDYl5i9UDai6ZIAWeU7k929tFr
 pXxX4JchW+GAFtnjY2H+DOUIIfpHNmzJ6WlUNxS/+29sincK0ONn41K05NPlY/J80OGA6fQ+MN2
 Ou8IKUJrgaFlBwwlhds1Aq/0ZMMMaer0kRylmGP1Cb3dWJGscBdls7PNQFndjoT6zxMCej6q0cO
 05Wvaj7AkFB2hL3KSXY6tVuP7OcDbjRF02sW+dx83vfLJqQ7kFQuHmcTo8026chuXOIsS8yoRx/
 Epa4LhcKSonLtRWXft7YZ9+8TUT8TyyHWsynnGldu+ICw9iT4PqS3E74u4+GfXIM2HNgFb/0q/N
 7jaSUKQTZuINe2nAfd0CMD5MnSk5S8WJb5HeeIEzaZo0r2Uq3gWgXsl6FmztGZk/Dx+zpwdS8sM
 6jWpALMnCI2gSKUf8VuRsG/KtDkFGNwamR/1A7YUY498QElITWLTmMJzdFLXoqv5ip+YJ+WKdwB
 4vcXFpILB9Lyr/IQsmEtWXWp2Wb6kvMg==
X-Received: by 2002:a05:6830:719b:b0:80c:d34f:5f66 with SMTP id
 46e09a7af769-860f298a86amr3533049a34.31.1794432363979; 
 Wed, 11 Nov 2026 13:26:03 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-860dcbbf1d6sm5205628a34.13.2026.11.11.13.26.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 13:26:03 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Christian Marangi <ansuelsmth@gmail.com>, 
 Vikrant Yadav <vikrantyadav4802@gmail.com>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 u-boot@lists.u-boot-project.org
In-Reply-To: <20261025102634.53851-1-vikrantyadav4802@gmail.com>
References: <20261025102634.53851-1-vikrantyadav4802@gmail.com>
Subject: Re: [PATCH 0/2] pinctrl: airoha: fix pinconf_get and pinmux_set
Message-Id: <179443236316.664252.17379969471028230776.b4-ty@konsulko.com>
Date: Wed, 11 Nov 2026 15:26:03 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, 25 Oct 2026 15:56:32 +0530, Vikrant Yadav wrote:

> Two independent fixes for the Airoha pinctrl common code:
> 
> 1/2 airoha_pinconf_get() always failed when reading back a pull-up or
>     pull-down.
> 2/2 airoha_pinmux_set() matched pin names against group names. It now
>     resolves the pin to a single-pin group of the requested function.
> 
> [...]

Applied to u-boot/main, thanks!

[1/2] pinctrl: airoha: fix bias readback in airoha_pinconf_get()
      commit: a52df653649558fbfc14cbb22b6abda85d15714e
[2/2] pinctrl: airoha: fix pin lookup in airoha_pinmux_set()
      commit: 3e285bf4de884ef0b09b47b8befc65518707af5b
-- 
Tom


