Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C31ADCA5FF5
	for <u-boot@archiver.kernel.org>; Mon,  5 Oct 2026 21:54:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 770526065C;
	Mon,  5 Oct 2026 21:54:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5yDM8XsObyTv; Mon,  5 Oct 2026 21:54:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org D8F3560666
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791237249;
	b=hr9W070+SG6o8YEVCQEh341/VJlEsVIVkicDjgGmSuqxTuS9BpnPWzdM8hvS0YAEoVA9
	 Arl2WLutCsKGSbPJ24GsTIBdcoHDrsCTKlUsiLyNVjzC0WintnMpbrmVwA7DBgpY83MrQ
	 jvgbxBAOB7l4GPMjCNeihi02TLYU2SQ1gt1cqZZHTQ6cxxktc2Vy0toufTpvb5/NDmzLe
	 NmCuFD7NvJRag30psoU5WZFwL5vTdydtQINNuksDd17+8jLtkaWbl0A0rDSXMyXmq7shd
	 5xTMcQroz+L5EHmcpY3sqz6+Nqh6ECKj6JKc4AG+HObASMyN1kHA1olvoJ3Oxt10PEA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791237249;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=mztOV0UZaLR0BpVHcA/yAxxcUECAE+xua9HJLFbXIpM=;
	b=egBGcz/tX10SVLFRikh9rAyP0Lo/kJ46kOOxPVEi4+pl9ZsrPvV2CbhzV2gzszwSPe6U
	 yFWQpba7atEvarrrPuSldnO7PlttXqK2bJJy13yJOedxYo1zUpIn3wiumFQyEHEc5Hsvo
	 T8Ka0y1zbSlmsmdOWjHVIT0q3vBW7HukfZWqv5fyqFwILe0MZHm9QQx+oaUcojKSPAt4Y
	 B73x82VB++pwfubVueepfJaI8Fv3Of8XciioOnt7yq7aux0PqQR+sFIPmWK1BVDqYw3V8
	 hRzszUWJZHi8rdziQ6F3vWkaidcwtQtlWlOow88/yf6sUEKSQROJhgFkeVLtlKNHwoA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=jT3ddP9b;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791237249;
	bh=mztOV0UZaLR0BpVHcA/yAxxcUECAE+xua9HJLFbXIpM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dGRah7ZgtW+xm9I8gYIzfeFaUXihfouiZ70TLMa6SOfvC1pzMGuS2UeT3oNP08BzQ
	 0Bo1xI7Q6ILI8BAUHcxCz2hSq/nXxUPHqWKw77svD9lYCMqxH9ncX+df5rwYL17z0n
	 x+J2ouyFgQa9a9L7RhJuY1nO314jCu3vP1dOmbNd4sSBWyTVmUNhphGX7/9JNPJKrq
	 5Ijh7lPN60YE7vqLwGdeby47Nn8OsniP2rlSQH03uFUdJHCkI9FJaxcJFxHlqBpzg8
	 M4IsohWutzxa1eeJ0Pgj5ElQBLJWPpicEFt0tjck65cQpL2R4RFTBA8baMS7XgYg0K
	 yUN0sO7/qeCuA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D8F3560666;
	Mon,  5 Oct 2026 21:54:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2E401338
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 21:35:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2004B60709
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 21:35:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rQSpUyFayW7R for <u-boot@lists.u-boot-project.org>;
 Mon,  5 Oct 2026 21:35:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 4C4496069E
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:32::d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791236156;
 b=l6B9HxQX8R9TuTlqqsAVAz+0pV9RkIX8P1tzi+3qcL5JrKuPnKFX3cp27ZQKcxHWfOAx
 RLlMQg0OsDazPrd/hqI6La3+IKMyfZD4Rt7vqRpz2ujOTXpcacCxoFHqzRrqP0x8H77Ky
 1WBERyeISHKJ93ANK5Zq4FYyMIZAIrRIF4TjswZEkyJ9ZGspUwit6oy9AGR2Iw8n1QkSk
 gHKTutf3N/a0d5vHjDbWtB6ymDv1Mg8FhUbA2h9+qv5fYwLv9tbWoXgOPrYNykrfsJY2R
 VIKXfik4E1TQND2o+Of6lvbktRa+5qUeLtPcFkz7x2pec1aA7bmmXFaRkZt2+iJVpBA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791236156;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=mztOV0UZaLR0BpVHcA/yAxxcUECAE+xua9HJLFbXIpM=;
 b=gn8dGrdkvcopEuizfQ5GPssfPkgseM8OHtDMIgwIjtDgFYnspME17ad4ciH7oBjzgZ5i
 y6osJP7+8e3lhHu4h/f93IEHc49v0QmQuoxdvFnVxq6Sj3EMZb1ICTW4WsHe+pvOjWk0a
 KAxTIwG+hQqXSkwRCqZVtSrjmJjJhn/IpvKRrTib5EI7gASamOIcyqGTtEXyTP8Pqm8hW
 7HHrEm7Fd/cDldwEexYR6ZZsUCh7MrOk70dulamKSq/jWVOD4r138ERlE1rv2nr83H6eY
 er0iF25JJj0u6GYgXcwLifZjrLOXn+j1ZR2r+y6T1YNGi0MsM7q/lPaCUKpZkhROKjA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=jT3ddP9b; 
 arc=none smtp.remote-ip="2607:f8b0:4864:32::d"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:32::d;
 helo=mail-oi2-x0d.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=jT3ddP9b
Received: from mail-oi2-x0d.google.com (mail-oi2-x0d.google.com
 [IPv6:2607:f8b0:4864:32::d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4C4496069E
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 21:35:55 +0000 (UTC)
Received: by mail-oi2-x0d.google.com with SMTP id
 5614622812f47-4f3312ca9f6so666936b6e.1
 for <u-boot@lists.u-boot-project.org>; Mon, 05 Oct 2026 14:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1791236155; x=1791840955;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mztOV0UZaLR0BpVHcA/yAxxcUECAE+xua9HJLFbXIpM=;
 b=jT3ddP9bqqG2zBQUMrnK57nESI4GPyt0/2sQY/fqp6nDC76aDqYq6sMEKUNqY0Ti0l
 UjcTwQnoi1WS3PnoAWHU1ktcADn2QxfDxYtcOgylsifagA4jq8k2fALdXIZ3MtqZLmNC
 6a83zFDqHhZcL2ocSy9zOnq1jeXto9dX9zlno=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791236155; x=1791840955;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mztOV0UZaLR0BpVHcA/yAxxcUECAE+xua9HJLFbXIpM=;
 b=0lQp0yVtiossyvCc8lVMicdsFIs5tVBhMd2rQXKlua49lt3+GthrTvdRadO01sgGgY
 ZBycrQU8c6rrVrPLnvwBV7+rpRLBJ+jhJ7bQyYqpXOYnMVw2ieJnch5lyShYtRv7tVSU
 ZDYfKRSHl96i2sv158T/XhVI4NT9krmb7whMHrpN8q0hILjkrkE4g5qFwhXjhVjN0crS
 GsZPnnZpGbOWDtxMHTmJw1VDeffRLyHcLCW0nBqP5Syo+kcIHKKiyi34I4JEF3tDqrDA
 Opg5nQjR9/yw7SqOA+m0g1dHO6Cy5VO1s9MX6aYE4C23wQyROVHiwYuo9eZbDVyTv76a
 G89w==
X-Gm-Message-State: AFuF++mYxH67+HcxbZRDZwxrQ4hT1UTBVYy7B+Sm5DR+93VSmZgXPvYE
 3Nsv7x/mwrkhNrVdFr1TzGp3PJHsmEG0WAnv6/+kBKK1Gl9blNaVkXZmJP2Cp55hutVJIjBkPME
 bmSPHTU7tpzmi
X-Gm-Gg: AYBFou1r/cGbWdYt/xS7Jd1lDxThUswbohn/RoFKwXqSwfstU/U6Z2rq2+ON28BtDcT
 7vle9OX697PKKERGwM43AHADlDbv7M/I2i0FSJibJrChyhqI5w964L/3CH4VpiXkJe+2mOZHiU/
 qMDJx5Ls5Wf5POKjn0IyQyM2wv1N/ldtIhFMvpSxP5sc41ptQrOGF/fSNey2e/EITXq1sLeG7qE
 l7t3c05b3o1kW+NOi9r/qz+vXow6TXVhQiLw3gD562d6+I36N/C9UgWAIu9GkhNA10qFFKhNbcr
 HK/TgX+uDE3b6kwwvA3UEuDHTgnFkpJr3B4iM8KeE0gyiIWhTGEHG/t7/eG0tDVGqFH0gOVXWl4
 upGT9vXTYGAEniFezuoTI13JYCE19j7XsflHFlZQq3UpcTc9n3e8Xwcz03SlpPGppejAVGEn4Qc
 MDeX27+wlAAq4i75nGb60u/3OxrCEVt6kSgieTrnx8WoEN81QyzAoe37fwYs/8yRp4Yaz7+tFfT
 tvE+eIBHQL6EaBNenJAMBPkh7bAgtcAYSzkIg9uphJObXpNckp/ikq058M98VR43f3QZhsoC+0+
 +NEYmOCMe6bxkSFyQw==
X-Received: by 2002:a05:6808:15a1:b0:496:976:acad with SMTP id
 5614622812f47-4faab474739mr723615b6e.1.1791236154865; 
 Mon, 05 Oct 2026 14:35:54 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4facac74b4fsm657289b6e.8.2026.10.05.14.35.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 14:35:54 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Stefan Roese <stefan.roese@mailbox.org>
Cc: u-boot@lists.u-boot-project.org
In-Reply-To: <20261005112434.728573-1-stefan.roese@mailbox.org>
References: <20261005112434.728573-1-stefan.roese@mailbox.org>
Subject: Re: Please pull u-boot-watchdog/next
Message-Id: <179123615395.1385963.6165694549559366955.b4-ty@konsulko.com>
Date: Mon, 05 Oct 2026 15:35:53 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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
Errors-To: u-boot-bounces@lists.u-boot-project.org

On Mon, 5 Oct 2026 13:24:33 +0200, Stefan Roese wrote:

> please pull the following watchdog changes for the next branch:
> 
> - watchdog: wdt-uclass: rename str to svc_str in wdt_start() (Juuso)
> - watchdog: wdt-uclass: report effective timeout in start print (Juuso)
> - watchdog: sbsa_gwdt: set max_timeout_ms in probe (Juuso)
> - watchdog: octeontx_wdt: set max_timeout_ms in probe (Juuso)
> - watchdog: sandbox_wdt: set max_timeout_ms in probe (Juuso)
> - test: wdt: add a test for max_timeout_ms (Juuso)
> - wdt: unregister the cyclic when the device is removed (Yuri)
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom


