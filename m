Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DCF7C55175
	for <u-boot@archiver.kernel.org>; Sun,  2 Aug 2026 15:07:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1504A4061B;
	Sun,  2 Aug 2026 15:07:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8jje-ND3uAme; Sun,  2 Aug 2026 15:06:59 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5936D4059F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785683219;
	bh=cH02gI7V66i3rrcTARyjf2VCyOeTys3E70uIYmts7c4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WobXyCsjEeX8jqIYj3jTySr5/B3fBC0LA6fDqvnjngp806d87+PX27PUsqAUA7Xni
	 B77lN5x0BBleen+zpOW5qhxopiPlirYzhBuOuL7H6aTAk/Fl/epZlwIipzB9AXBQYD
	 jKXN+277Ihk8b/nSYEFTh1+Aj3j7loiUmsEnVV2n6Jtnj/vTI8m8RhMQ91qK0R9OGu
	 t/dJtvZ7QLQJqks+GqORxP9FBT/Uxhu79h6pTLftSxVFVc1Nkv69PayuhNSg8oHdo8
	 EynMIY5z92+UunpQkHisySprwhymSa3EbsU6I4UvTiafNKR7IgXUp7ZU4dgnR4FAjf
	 irXPRpNJW0mtA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5936D4059F;
	Sun,  2 Aug 2026 15:06:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id BB381109F
 for <u-boot@lists.u-boot-project.org>; Sun,  2 Aug 2026 15:06:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AD44D80C71
 for <u-boot@lists.u-boot-project.org>; Sun,  2 Aug 2026 15:06:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WqhXPzLqAzQs for <u-boot@lists.u-boot-project.org>;
 Sun,  2 Aug 2026 15:06:57 +0000 (UTC)
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org D671880C70
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D671880C70
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D671880C70
 for <u-boot@lists.u-boot-project.org>; Sun,  2 Aug 2026 15:06:53 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id E84C7805D7; Sun,  2 Aug 2026 17:06:50 +0200 (CEST)
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7311B80087
 for <u-boot@lists.denx.de>; Sun,  2 Aug 2026 17:06:48 +0200 (CEST)
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-6ac83a09781so1368903eaf.1
 for <u-boot@lists.denx.de>; Sun, 02 Aug 2026 08:06:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785683207; x=1786288007;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cH02gI7V66i3rrcTARyjf2VCyOeTys3E70uIYmts7c4=;
 b=Y/mlSNSfReuv/G4GJICHk2ztC+s0d7xIYHe1IVUpukDzqOhlcgAWoX7wfgehPntf7N
 sf3OtnIEgBKfU/v31+28B8EQN+tXP0Z4DkgntKmQiiIRQdZSaMZI3v2FvXH46hRbO1Ic
 AFZ0RaEB6aEnBPwfJXM6dBJYBPOlnNtcrBBqp7rdIZUBsKnNuvyHtIrvV9rU1SVcF16d
 0Uqi/LT6yUZSF1vJJS1xH6Er8Tl902l60LjzECs3qEgmtxZ8jEmT1nzC5Ij6GRM2qtES
 NEzp8J3ZQ6YUuF/Lww341fyGi6ZC1OZXBXpbesjgC8/J4zyJfsiW4lIN6d9QOfvo7yVF
 jQ/A==
X-Forwarded-Encrypted: i=1;
 AHgh+RoOg5ooov18/KT3wZiV+nZ0uiUtt/QkpFWPksaA85wo0XpNqQmPrt7qN+IAVBgwKzHexZt0Q8g=@lists.denx.de
X-Gm-Message-State: AOJu0Yzp/JOY64879JBi40sFNqnOpzdrByl6mv7qMqzLVDFX6foUk7BJ
 4dceVI6uNrYUVRxkoWRvGhyUuQp3Dsd6CYhcty6Hq9dm4jYVQ1o/NHLQxE4JimZ+GMs=
X-Gm-Gg: AR+sD13fi1+JaBideuFGAkZL8gzqhuufOyzkE36m9Sm0KExXjAtWRtd7bJN2q0CnNff
 Bpz9a+SaapvUwNkY3P5ivyGjK+oAv66OHza2nCCXi8RqdC3hO7nF8Tgr9hRdBg+kgngoWy2q/23
 M2j0RxHsZnrZG/vJi6s8iJSDJM0ReurAnxPblS4Fw44gAL76u0a3cSfoJi+5kDHsLupoS4ObVOR
 q5XJKeigEiXWbY3MS70sC7jdmUDb2+/zMZhyAnKx+2Jjln5uqCEB8mqOT4cL2/cezrt8YD3M8B5
 B+bMeMQtwBCeHCtEeZZ7aEJmu/AdV/7k/fPrj9FeViLbNJw/84JWYSZ9DUXhbW2kDs0E08TfFBo
 jM4a2H7aRiPtdM9ptCzGWGyC1aA6EWMO+cERx8REI6qoEHe/iZsvxP3wFuPWLnjffioSufYBZqH
 t3Sz846byz0OJG3pc7tb9XUPR9Rv4vmxR5vYIOx+yjcYNoJyd5zCf7oe1O8v1M4CAaYn55wZxqQ
 2CYdlNiipYZYZQYlJJyo/HdmoTFR8K9tQr5cfY=
X-Received: by 2002:a05:6820:858e:10b0:6ae:3984:1bd with SMTP id
 006d021491bc7-6ae398404b2mr8383564eaf.2.1785683207032; 
 Sun, 02 Aug 2026 08:06:47 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:5487:2b6e:1057:d3d3?
 ([2600:8803:e7e4:500:5487:2b6e:1057:d3d3])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-458fbec4bbesm6175064fac.15.2026.08.02.08.06.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 02 Aug 2026 08:06:45 -0700 (PDT)
Message-ID: <a5ef6e24-cf8a-4463-aea0-8533de3d7521@baylibre.com>
Date: Sun, 2 Aug 2026 10:06:43 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] usb: mtu3: wait for TX FIFO to drain before disconnect
To: Carlo Caione <ccaione@baylibre.com>, Marek Vasut <marek.vasut@mailbox.org>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Bin Meng <bmeng.cn@gmail.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>,
 u-boot@lists.denx.de
Cc: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Julien Stephan <jstephan@baylibre.com>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Vitor Sato Eschholz <vsatoes@baylibre.com>
References: <20260720-ccaione-upstream-mtu3-tx-fifo-drain-v3-1-45c0e072b64a@baylibre.com>
 <DKDEITT18XJS.18WZM0Q9PGROO@baylibre.com>
 <4de93606-a4c1-4b69-bfc9-328c2aa29c4b@mailbox.org>
 <DKE9GVL7TX0W.2VF1JM6SOE2I1@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <DKE9GVL7TX0W.2VF1JM6SOE2I1@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1785683207; x=1786288007; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cH02gI7V66i3rrcTARyjf2VCyOeTys3E70uIYmts7c4=;
 b=FdslAG0VqmrQthCSClcRKWEr3r1zvUyor0urwWZUrSkI+2LaYGa2XY33maMc3SDcjT
 fgJOXmsMvJLX+4fKz8biRbkHCnSec3m6/MPttI6R1tGbkJdgu0C9ReS56JwX3/IX8Wb5
 HOLbiprMPgFaywjoviklUyjEVfz5JZ5gqRGU0twCwSr67GipCFBzeRxZSxXGzlT5fHXd
 m4G4VoJvLDvnRbZD9Yw7AFQpPd00hldYXtc2m8CfRqXRYve31sVKGeYT5eYVitKV6sOP
 mOf/nzCG0PxwTAsbixhUL50v6ZQJtD3Gqn2qbXB1tSfypYZM+bWZaO6F3qlTyPJhjWEw
 wMCw==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 spf=fail smtp.mailfrom=baylibre.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=FdslAG0V
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dlechner@baylibre.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 secure) header.d=baylibre.com header.i=@baylibre.com header.b="FdslAG0V"; 
 dkim-atps=neutral
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

On 8/2/26 1:57 AM, Carlo Caione wrote:
> On Sat Aug 1, 2026 at 11:52 AM CEST, Marek Vasut wrote:
>> On 8/1/26 8:42 AM, Carlo Caione wrote:
> 
>>> Hi Marek,
>>> can you PTAL? Thanks,
>>
>> What does this mean ?
> 
> Please Take A Look? :)
> 
> Cheers,
> 
> --
> Carlo Caione

The question I had is that this patch (v3) is assigned to marex in patchwork
and is marked as "Superseded" [1], but there is no v4 that I saw that would
superseded it, so maybe it was marked that way by mistake? I just wanted
to make sure this patch didn't get forgotten because of that. (And I assume
Marek will pick up this and the other mtu3 series from Carlo in due time
rather than me picking them up via the MediaTek tree.)

[1]: https://patchwork.ozlabs.org/project/uboot/patch/20260720-ccaione-upstream-mtu3-tx-fifo-drain-v3-1-45c0e072b64a@baylibre.com/
