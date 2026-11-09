Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDDD606A31C
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 17:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Whb4wdRT;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=HxVpDhcc
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 286A2606EC;
	Mon,  9 Nov 2026 17:29:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 03jvIKA9PMsp; Mon,  9 Nov 2026 17:29:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7D050607FC
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794245395;
	b=PlR2APEnt0b8RZE89Ww+N5rlBk9zp9DXhSJN1i7pURxqS22I0VZnahJqZaD3AiSN5QeP
	 Qd6bIk39JUJ4b/q7i3FiVsdCQ0acJcE0RdkY3eTkH0f/KZFjtDXKScNlcdbAPDD+qlZSD
	 hhgWK8Zv5tzDktIEHvHyPlsI5X3K3gU1i4t8bT5XFVEZCFfX+hYem9HoNSab5T9WRRLHV
	 WCKuW5qrHJlygLITOWJg3bvzdnHSOLZgob4dtv4FZz2SkPiZ1aiX6i2K0sV/DSwWgVL0H
	 S1H+ednxPDgOmCpF0fIBS1tCApSmRmt0QBr4b/+9gjCxrRO8lw94WRl28MYV1ZOmp0A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794245395;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=ox+CmLDPyty49oAd0YGtfpU/CI/u/i67tG657Lw7ZpQ=;
	b=eqgkJHnTUm3BBgRK/9r5MCvN6PvGyJkSrzQ5cDX7bajr8GvTsRvXu/gXY6DlJcVAzcSQ
	 2+QgmGY4nf9ME9F1ewnU0CEKRRWT/JbbSOTa+mUkefR70i5ezR7miAI6LB6Xjq3ZTOF0y
	 YzMeB4W6VkK3IaJUvmpqBhHxt1XgxsYp14psqf5c5kj3hpRnI1fwO6za7jwwSnLr7S66B
	 EPMOqBBAXxQXPIGs2ZRmh0lMvKL92GrDaHUtY9FSRtcF/PXT3SeTIxVCeSQRSS2VAqnRs
	 s2FVzXiXLACXnyM7L11ujRwUNs4rd4emTIRUZ6rYAfDSen9lW3iElSp0r1N9zz0fqDg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=HxVpDhcc;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794245395;
	bh=ox+CmLDPyty49oAd0YGtfpU/CI/u/i67tG657Lw7ZpQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Whb4wdRT5QJTw1/0+RrYqC2qZKDb4NT4B/z3SeOSHRm1rewG1ooOXu9zkSqbYsoyZ
	 9vRK3VWsHFBCLdzK3x+9xw3IVmCD89F36ZG+xDbH4Fwg9egva+PPGhs56nXc2mSZWS
	 fvUq56C0/IHxqRgj28TFNy+oKZkslGYjv4E5afQUHd1RWSIHUmITzhdKWXQb7JDmx0
	 ezCbWeyTEtKZ4Sptc30M8q6GIgU5iqpfELOWHX5d2q+Nedb9j+LrMyhBa91g3EH12T
	 NhZHWjpAzZmkIdDoZPXPvtnTmqB1fAyzf4FUQrQeZ+UyoyYuIvzsNrqE7kyKAPOw3R
	 /lOGiekXTKAeg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7D050607FC;
	Mon,  9 Nov 2026 17:29:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 23D253AD
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 17:29:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0A1BA607F0
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 17:29:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dFlh-1LcJwmR for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 17:29:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 66607606EC
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32f; helo=mail-ot1-x32f.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=HxVpDhcc
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 66607606EC
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 17:29:51 +0000 (UTC)
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-84e513877a3so930261a34.0
 for <u-boot@lists.u-boot-project.org>; Mon, 09 Nov 2026 09:29:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1794245391; x=1794850191;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ox+CmLDPyty49oAd0YGtfpU/CI/u/i67tG657Lw7ZpQ=;
 b=HxVpDhccCIi3Yo2hO8Kplr6jdu06rCJPmIp/+b/EdQw+gsr9iGyzNG2fUP0LxaV/ny
 yKWq0S5IxepX3D7Cj4RpHyMQNRvUIlfW4GR5+Svi2E8wkWIeb8hy6IwECkFTnHfKWbZ3
 9YqwHMjxdpiRQaD5P/xkoDU666p/u72nedniw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794245391; x=1794850191;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ox+CmLDPyty49oAd0YGtfpU/CI/u/i67tG657Lw7ZpQ=;
 b=w+k2Al2kqZE2BvzpllABBDxuo/zHo0ir/EaLkKkdijcCmwU1Zk4yEMcCv3lRsJWJpq
 nNYI96jZmKYtx0bUk5PHDx1O+5wTArqk8QrGhJ/cWHfXtseD8zRR8iAn0RCx9KbmVlJF
 LagxPuq312wz4LGrzMtgK96BwNud+G79q7NWaGDou7vQrDystgdb9uszaBig70Nk4gsM
 jVO+ITHJ2JqgXXW5mSy2kufa3yriC/grzvSdpaML2ytuf5pIbIUWlR4NZvUUt3E4Z7Cg
 PWToOdczytLLznZc+VCqVMloNeuNcDZx/nAwpXEV8iUSp8Xp9cPPyFthgf/4nxvE5GFc
 4VLg==
X-Gm-Message-State: APuU4Z/+ln0VXtCpomFz94enb6aMBgKfU+gELFMJUB7X88nXS2d3X2Dk
 sEzw4M/iJiO0xXTo/+ZqoR6WQhPuTwNTo6T+EueLDF19lF2StPXLQL2oKkMpF/MpkjjjOXAggo5
 OOnC+eXapVNL+
X-Gm-Gg: AYBFou3E7PVO50SlsN2xZ46snZXU/QMYCYlnUjtiFlwUSXeBkigBTbYv3eg9LSa6vkB
 KSK4zRiYQmDehnVuv3bh3yQWCtyRCMSk4VjeAHCiSbDNZIDeV/bUNx+PYAT/zSq2u17G0ZH0rAO
 y/e79uE+f8pHmRdVse5JbQF5b5EbSJARu31SsQF39i6aJ3U1JHIRWnbPwBOCCdxM9c1ZCxxNTnm
 3MWyr62yY+lGuAzbprp+OOvEqZsgHb3l/uw/tCQV2xf771DFA+dBb4wT3pWH5/SfXFwm8r634mC
 ujLDUUvWxMmOGvF19TB3DkpLIBzUnLjMGAU10qYkLXFQJCmfXpP7qghXQMJk8BoWM/pPP4A+bJL
 c9KmT7u3HP1jh68hEvHgDMPjv/JXTTlO+RxWYdzfwR/oiuLlC7REftDNiFoAxDoK8LsacUOe8QW
 +DdKnYNczweCOXu4RVH4grOLniOD6Ika2iEYz6GpjFlPYZvwHn76ytMZKru7yPn2kkmuz82+GH9
 n/IYAgp9MIu2858rd/baW+6UMUL/mbKZJsVnUFW9VM9TL/2iv07VqnaSFfwKlDtXvOBTiDd8nth
 mHnXU/HTjS/P2LdEOzkOe7iN1ShrI1vc53oISaYOy5rThVHu/yezWUUDo/T0T//WnFaifP5JGtC
 DEeq7BAjJnlpK8ZaXHG4rx7XQXc/eldCO5jmQ5BJ6M9S7jkB0uoE/Sx7T6nOry2GEH6TssZcWK3
 5qG/4Dk8x3dLwL7XlxPix9jUy447WKxg==
X-Received: by 2002:a05:6830:7195:b0:846:9414:ded with SMTP id
 46e09a7af769-860dbe990b8mr129708a34.5.1794245390960; 
 Mon, 09 Nov 2026 09:29:50 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-860db8481d7sm200546a34.15.2026.11.09.09.29.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 09:29:50 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Massimo Pegorer <massimo.pegorer+oss@gmail.com>, 
 MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <20261108161752.2430291-1-marek.vasut+renesas@mailbox.org>
References: <20261108161752.2430291-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH v2] remoteproc: Hide REMOTEPROC options in REMOTEPROC
 conditional
Message-Id: <179424539029.2040456.14537922302756476572.b4-ty@konsulko.com>
Date: Mon, 09 Nov 2026 11:29:50 -0600
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, 08 Nov 2026 17:17:44 +0100, Marek Vasut wrote:

> Add conditional around REMOTEPROC menu entries, turn REMOTEPROC into
> configurable boolean, and update all defconfigs and Kconfigs which
> previously only selected REMOTEPROC driver to also select REMOTEPROC
> itself.
> 
> 

Applied to u-boot/main, thanks!

[1/1] remoteproc: Hide REMOTEPROC options in REMOTEPROC conditional
      commit: 0367da9846e7060b50eada6d5b1334627dcf0969
-- 
Tom


