Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10978C55ABF
	for <u-boot@archiver.kernel.org>; Wed,  5 Aug 2026 20:03:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id ABF144081A;
	Wed,  5 Aug 2026 20:03:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NvUv1SgX6t0y; Wed,  5 Aug 2026 20:03:32 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9F7C1407CA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785960212;
	bh=5OqGdifjN0X/8DrFO6Exs5+PnNDbBwEoSn0K30bviMY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PGX9pWChwV9zfu8KQG3+QReZY8Enir3y9Ht6Y6vA0YATyEIUmLVg76j/bXd9bejkt
	 1ZCuKCmqSf/5tckFwIqhMlRZu8p6iLDS03034TPNAc+Hi2Qj3pmGzwVjqqpacRs3Yk
	 xWDgPzW5Rh5kP7bdSw72K+fylhcAgRgU6wQkYj60yuJqozhIBykvWP6D3993g0bTG3
	 5m9sXxo4ny7xTHxAQ0Nnj689L5jx7PfM0OXEmUXx1hVtHctNzuXiVUCr9AdlrA10/O
	 MRt243pi8rHfTmhGr4l/ShvZAMvKx/YJ+ZKS+zJAsriozdsLh/lE3glq7pYO13Mrox
	 2gaaw4PsX0XKA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9F7C1407CA;
	Wed,  5 Aug 2026 20:03:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 41C4A2A8
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 20:03:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 33D6C607D9
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 20:03:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uhkT7480nHuw for <u-boot@lists.u-boot-project.org>;
 Wed,  5 Aug 2026 20:03:30 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::335; helo=mail-ot1-x335.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org EE798607D8
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EE798607D8
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EE798607D8
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 20:03:28 +0000 (UTC)
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7ec49608332so775030a34.3
 for <u-boot@lists.u-boot-project.org>; Wed, 05 Aug 2026 13:03:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785960207; x=1786565007;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5OqGdifjN0X/8DrFO6Exs5+PnNDbBwEoSn0K30bviMY=;
 b=rwJE0A674XH2wwsWMSts3VNIeqhmktMjC6vTBp36Pf46uMuE/XGaFSYvwMgqB/JNos
 Z/Ju92VGSK+H/wJzTzjBHdY3fRqmdXXdGKWc4tLDKcCJ6ySGqavRfkj7TuZA1LIDJxWC
 WbeJjy1onPvT1/G28A9UOlLwLS/hxYKJB0zmCx6G+dwZDKAnJP9vgs023rcSJ+GnyP83
 eOOZfKCgwnUzJ/XKXByQLpisDnoOBweduKfAIepFgRK+DNstRj2J3KI6ayE9TgmL79ax
 /Uv+uukIYOgYzsYjlez3z4XkOZxq8DjImcPQE8nMPhEvhaJsqgYaFA2vnMnVEP9FLbQh
 raIA==
X-Gm-Message-State: AOJu0YwGyZcJFh41z1Nfs0BF2kCTdi/npO6j/8xKFhqbQ4GQ6pBF9MM5
 TDBPu3vGA500tOptdvtpKZux77/9sea8gjQUxKTMJFZvFs0/VrKX1CpI7mam8CWCQzEwSdVSVNE
 VKydXNgI=
X-Gm-Gg: AR+sD10e7baQfPnfbObQBD3zEz/taQqyFQ9u0ILhyLIsi2Z7yOnehXSPkbvTjn3uli4
 eoRghHwbYXeesIZFvlf4yO0jUzH8F66d3fRhyqKBpdzfqamrkLELxoGJHpK382SOMMMih8GLPsK
 llsDw1ksm10avYWjfXpS9T5Dx3nJfDwtSxFFh/v/y+LM7IsDraLkE8gB1mSQXotvi+PY05eV1Xl
 nxZI52Vj0b5U+Lkx2D6cHffBIpVPk1RjpKB+tLRj+4tmqrYkS5dA1iTiS5rsyW5iZJ9V5pTWOKy
 hqwJvpRrrXDxriFVU3/Gou3nV9lvLeNJL5EtjS0mmS2zD5hKeYXf9kRM/ZlVHrYXVtFjeBCoS36
 incSjO/CXiMF0/tbdM5IB1aNrorKsYZXbTVSam5pc0sEl+nCNk9ujyHIe+ocQYu2rRwDqkK/skx
 wgrSQaqH/lDOGis/Hd5BGr0yiU831iP+Fr+tZ4KYlMnj5v2BdmA/vcPEbg/f5rqRXvqAf+90B51
 Al6Aq+dnt5A+eYuI8mTH8dnUYRsStsEL1gMreZuyxVXX6eb/g==
X-Received: by 2002:a05:6830:828e:b0:7dc:c4ae:a689 with SMTP id
 46e09a7af769-7f1e5c13d47mr6360158a34.2.1785960207586; 
 Wed, 05 Aug 2026 13:03:27 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:ebef:9550:d591:36ac?
 ([2600:8803:e7e4:500:ebef:9550:d591:36ac])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f1df33da38sm3330876a34.7.2026.08.05.13.03.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Aug 2026 13:03:26 -0700 (PDT)
Message-ID: <35d9c43d-8d9c-4dd0-889c-7ee24fd81a7e@baylibre.com>
Date: Wed, 5 Aug 2026 15:03:23 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] Please pull mediatek-for-main-2026-08-05 into main
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, GSS_MTK_Uboot_upstream@mediatek.com,
 Julien Stephan <jstephan@baylibre.com>, Carlo Caione <ccaione@baylibre.com>
References: <20260805195116.2512286-1-dlechner@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260805195116.2512286-1-dlechner@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1785960207; x=1786565007;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5OqGdifjN0X/8DrFO6Exs5+PnNDbBwEoSn0K30bviMY=;
 b=j33B1E1PUPXMCHk7UYFcvCUWqEuhTe5bWIUaYNHa3WAchDyDNm32UWtTFylZ7vdCvU
 ASdeZRjboJ0muxQi7SKIJyrLwGujNygvhIG9hQ+wDhMiE3ldPbOO92UKEwRRjf9uC7S5
 duUFd+NBbjbZjy7e8RZsTmBsZF6s5JBl6Sgjos6az87sYbFHck8jacz5NBUslbMITm5w
 LCAJ0FagaQHhYjpzfRPG3RWqbtl7ht7ncg3WL66MDZgy4TqdO64pn70ybFRmsGx75eZv
 C9VZkR69UWZxoIVmVhNqePGHH/jbA/FIJUkMyY3CAJJkNYcg9XgEHhVjjCOm/2GHJ946
 tGrQ==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=j33B1E1P
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 8/5/26 2:50 PM, David Lechner wrote:
> The following changes since commit baa64b2f892890f00a377eac4a3e685472bb56b5:
> 
>   Merge tag 'efi-2026-10-rc2-2' of https://git.u-boot-project.org/u-boot/custodians/u-boot-efi (2026-07-31 08:55:30 -0600)
> 
> are available in the Git repository at:
> 
>   https://git.u-boot-project.org/u-boot/custodians/u-boot-mediatek.git tags/mediatek-for-main-2026-08-05
> 
> for you to fetch changes up to 164113e995822052aaac44b34b238f595596c264:
> 
>   clk: mediatek: mt8188: fix top0 gate polarity (2026-08-05 14:46:59 -0500)
> 
> ----------------------------------------------------------------
> * Clock fix for MT8188 (Genio 700/520)
> * SPL support preparatory patch for MT8188.
> * Compile error fix for when enabling LWIP network stack on some MediaTek targets.
> 
> ----------------------------------------------------------------
> Carlo Caione (1):
>       arm: mediatek: use phase-aware PSCI reset on MT8188
> 
> David Lechner (1):
>       cmd: ufetch: fix compiling with no CONFIG_SYS_CONFIG_NAME
> 
> Julien Stephan (1):
>       clk: mediatek: mt8188: fix top0 gate polarity
> 
>  arch/arm/mach-mediatek/mt8188/init.c | 2 +-
>  cmd/ufetch.c                         | 4 ++++
>  drivers/clk/mediatek/clk-mt8188.c    | 4 ++--
>  3 files changed, 7 insertions(+), 3 deletions(-)

Oops, I accidentally dropped some patches I had queued. Ignore this one
and wait for v2.
