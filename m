Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F90606A326
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 20:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=hWgYVDjD;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=lGG7qb1M
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7BB5D605E8;
	Mon,  2 Nov 2026 20:55:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id K-f4s-u-EiGW; Mon,  2 Nov 2026 20:55:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A9E35605F8
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793652956;
	b=Dr85s82r0lEdKoypMRi2nAq4ykWFg8TINsQhIiyeSiupNMASzlMQOCgg9oVuv8Syi6xg
	 UdwyJCtG46R3T1EYNzVbB61fAc1h/Sz27OmAP10SAcygJ/NjJsIE5cbuWj3GhPoNZutJ8
	 eIo8Ob303LqPaoFfJ4iy6kiHwNAWGghlQHlR4LcMESUJ9DPDEIOf4LaFQf6kmH8MQ9ZwY
	 6XTD2J81esR8o4muVjKXGjhDmWCGyBsv4GqzHnmqABVt4/vzU6oiRe7JEVUlj2i5SnILY
	 g/+tUAYkS6MF5INwfeytuM9aWLLhkIfEYSWcFRW1X/Mze3IvuxikiKoSCJR5TzYnxaA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793652956;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=cHZ6lN713rjxkImstrCz/ye3b+Gvjy5uwXWwqK0eQuI=;
	b=jtWJu3WGWmaLU1viU02HKalOpd6/ajqOaQSIL0NFo07yeqIqd9d1fWrTkAhqQn/M7u9V
	 PyTeMtudWHbaCx+LzZuEP0aGb2CxQIaNVkS6tpptRZW+cQgSjdWeJDlph/zaLVomkWeax
	 YUvGTrZYk+QphBUQsmorWNjNPoIWNvZtyZR1ytpJZjxsZUPguJnS30DsFRSKwSpp9nNFl
	 Z+NKeUd5V/NvsjyhXa7cPDyEuUV+5yPswpPhaTbfssKQg+w2z1t2UnpKsTnC7opMNG3op
	 +S0BR+aqrlIq02lN+f3mT/m5y+XoYIWO+ZoXEIb100UnKABDS3pMFqfSgkeoSqq5rlQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793652956;
	bh=cHZ6lN713rjxkImstrCz/ye3b+Gvjy5uwXWwqK0eQuI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hWgYVDjDIOgJIZxdB8sNOFwH8KGv6OfJsD84bRsxEEH5PdFvuYlN5Iu0TxBHZqgOr
	 UMI6da3rnkEyo8wVOI8y5fXp5DwOsncoqQrgOOZiOmgTy34PelACjAZw0uvFgsUupt
	 Trm85tKO6C0zhksZbN4Kfj7gBpi+ZDbdBOtqZMKWrmLw6Gqo9aqXbj935LgF59j5d6
	 DXmZtUWtkC2C6cJWsheb++5jvOb5VoRJdNnxKBccWlkoJa+8nUh51YAKM6UWc7ak0n
	 M9lVHr0dctKbUrcQznL5oBRh5U7S2wElxWh3TIsdiZ2Y5Sd0c1m/15Zx02AjxLpISd
	 cXRGOCXc11N4A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A9E35605F8;
	Mon,  2 Nov 2026 20:55:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id A836E4BC
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 20:55:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8D56640573
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 20:55:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RP6CgYpdaKvI for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 20:55:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3FCEB404E0
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::33"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793652954;
 b=gsqskOzJ0jHgovQuyKymOc6ihohBy81FbguMIxVCv12h+CVxX3+wU8KtV4LGwaRJVTRP
 58R80nZowKB6/PiMrravXRnaTtjWT8yzwH1nxRZhYx6x+193y4YEYZKifUic0kF+fM3dk
 GVb5bIMck93h8+O8/jlZ8cnNC6Tqgu4g62QNQtiET29rbC+GZYH2rJ9AxQ5UIqoBPl5b9
 WjgUCJmC4iiCAoWshEvRhrwsCNCthMMY6OmncG0tabcuNvk6FWtz4SH/yy8bBOEhObZU1
 trqY7zmlEPVGyC/ysHGiAWrxEJRPydHcqXr98wRhlsoxTxJ3lDeUY+14/Y6J06mINew==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793652954;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=cHZ6lN713rjxkImstrCz/ye3b+Gvjy5uwXWwqK0eQuI=;
 b=K/HTBMVLgHLx8HGQS7oZNtGIHfAX+gEa11inJj/s5VEDpreuutp0IfW+Jb5kf81robbK
 RwE4NS8qGzYT3eBn+NAYV102vy+mZY160bLw7WaLszG2zXU0q90NJ17YTFveYd+HsG5d0
 o/2CxDs6udT368AfQzbMQboJ4yPDWPpyG5eyDPQFvI8LnH9OM9r/080O60m31YGPhUfep
 ReAg55pCRQ6GRL9mVjGKg6tYInFTFgvfHOvXbdzUYLhbv6PHA7SFvbCsm7Suy18u8eWiD
 j4vT/oL4un5o/VKo0guTON7X3I0kSDvnGUf7S7snGQThK4Q8rSgXEwMpUoa/khcUmzA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=lGG7qb1M; 
 arc=none smtp.remote-ip="2001:4860:4864:20::33"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::33; helo=mail-oa1-x33.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=lGG7qb1M
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3FCEB404E0
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 20:55:51 +0000 (UTC)
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-47b47de8b4cso1985607fac.3
 for <u-boot@lists.u-boot-project.org>; Mon, 02 Nov 2026 12:55:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793652950; x=1794257750;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=cHZ6lN713rjxkImstrCz/ye3b+Gvjy5uwXWwqK0eQuI=;
 b=lGG7qb1MbtwftFjDAH6AoaFyWykRAJEHDZjcNEju/7EbWZOfI0D98qkx0jT2vP9XWR
 yh5R343NUbf3sO6I/Rp5fyh4qvBNWjRZIqTXYVJQTzLYNGsdR4Gm0qVVLqUYHkSZ/K0e
 SiUglzRrVZr1mgJ+VVt2flh8/DrPlr66d599tQgLrqWPQoClDF40fdWMlcZhxV8OeV3q
 dcfp6A6qvJnWluERVrkMGQR1tCuno3gOuR6VZW1Zqq1TtgcSVuiMRb5utOmcwDNqZZ/M
 yXxOQlAKzggTS7/Nm7itPMIxjTx6PWfuKXFDwhExl/lJ0EFcsZzpKVBqrvZuc1N+x9Kt
 A+Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793652950; x=1794257750;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cHZ6lN713rjxkImstrCz/ye3b+Gvjy5uwXWwqK0eQuI=;
 b=MQHE8r1BtgFuBSsjSOVXoFApMpy8mBSexie4oSEt+ZWNc8jE/ZeEAL6mU3+GQIlp/R
 1yTze+U2q7GpJuTsIFt48OqGDM6WigilvBm9/gr0h2CukJ0YxHctK7urtBnsbh6G5l0s
 z/+edRPfCuhJvGhhBp0TMQSimEkGYiigz1g8pumDIkLq/QPXIJHbkSrMusv49TWgYAtO
 zgbibMPJ3M4l/WQgVe+OtL2RCmRYGAIF4OgzsqEoRJajrSumlRRd8Dp+EXcKbz5AfrQQ
 G83WW+MZhLv1VKNgSFL2Hsh7nmQEP4NeoNzz58h23bCT9sU5ujx4oW14vZira5Hcp8aS
 tOpQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByzaQhUbIwMBZjBL+p/1iZpzPFpWb2DmrLApbxO+A8LTkghBErTg4Gm87Wi4ElOAgSwFxfA3FA=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKj/yAgFMkWMUGtvPWG6MZAMs5j2hKZ4ej0WN89NI1OHQa2tF/X
 i+hTjTM3hHH7xCcRhO9lIwB8vYy4cmTQkub+nGQCsVnYJ0zxdgUN3lTQm+Q3SgiuAsY=
X-Gm-Gg: AYBFou1fi5PVZ8DQS6WVz4Sv0EcquyvwofW6VnqOijgUgRmth5bEGVbj4kaHEsq7Xuk
 7o7WIUWk0sFhVjXlo/Hzh62y0JxOlFI6NLvmta2um3sHzzlhrsHOpWok1mEcFP0jqc85PlyykKx
 kOHVlH8NXgK8KAW2BHIrwK3/A6jGpjEkX81I5Szvq3nQUpDyw8o6ayT4keyXQbOA6SygwNyjDVt
 eCvvvcaTI19g/B44E4ZemJZU0NUUWt35t47fckJU6+EN/gT5gM0jio09EUsEUqmWrcGP3Cf1KJ6
 keVvwpnP+qkfle4RbbpC09pyR7Hf0gAY2tfXyIwyB1Pc8Yt1LGoLXbcYnPFPLi8gBd37VmoyK51
 1ip63GILi4MlqdYE4+umBI74PhPzrqfSsKXZHIaDvzhvDZhCL9KuYIX38wRbgO8zbbGx0V24fFm
 voB95XEO3JeB+EDvkZz0kn4xD5JLc5KUdPmGu9hzr9qqJQbP+nYOlj4p2L++RZXgrjhBUnIjOX4
 CnCIRGR6hODDNGo5tR+PZzf2zHew82JG6O0mEbpLG5ODJ/mdHnT+LT0c8bZIhV1tHles4aJ4M0T
 z9/qR9mrrtECbC0UNaj1M2a5Dr5vb5kQYPKR6bZyf79lDJr8ddJs52ZrucIPqhRxlmzx8H80UJg
 Djw==
X-Received: by 2002:a05:6870:d14a:b0:48f:e25e:e203 with SMTP id
 586e51a60fabf-4a9077e829dmr7391056fac.52.1793652950407; 
 Mon, 02 Nov 2026 12:55:50 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:1432:12c3:1aa3:969f?
 ([2600:8803:e7e4:500:1432:12c3:1aa3:969f])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a92167984dsm7790148fac.1.2026.11.02.12.55.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Nov 2026 12:55:49 -0800 (PST)
Message-ID: <41747740-bb32-4287-b59f-c6c59d5fe1d6@baylibre.com>
Date: Mon, 2 Nov 2026 14:55:48 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] doc: board: mediatek: document Genio 520 and 720 boot
To: Carlo Caione <ccaione@baylibre.com>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Julien Stephan <jstephan@baylibre.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Macpaul Lin <macpaul.lin@mediatek.com>,
 Chris-QJ Chen <chris-qj.chen@mediatek.com>, u-boot@lists.u-boot-project.org
References: <20261023-mtk-genio-720-spl-v1-0-f2c0ee094fd0@baylibre.com>
 <20261023-mtk-genio-720-spl-v1-7-f2c0ee094fd0@baylibre.com>
 <at8kDWMc8mmUKmeT@macbook.homenet.telecomitalia.it>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <at8kDWMc8mmUKmeT@macbook.homenet.telecomitalia.it>
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/26/26 5:10 AM, Carlo Caione wrote:
> On Fri, Oct 23, 2026 at 19:09:13 +0100, David Lechner wrote:
>> Add a board page for the Genio 520 and Genio 720 EVKs. It describes
>> how to build U-Boot proper as BL33 for the platform's own BL2, and the
>> DRAM description that the earlier boot stage passes in a transfer list.
>>
>> It also describes the optional U-Boot SPL boot chain. This covers the
>> DDR-loader handoff contract, the MT8189 image layout and the eMMC
>> BootROM size limit, as well as the build and install steps.
> 
> [...]
> 
>> +U-Boot proper applies the overlay to its devicetree and passes the reserved
>> +regions on to the OS. The transfer list is passed to U-Boot in ``x0`` to
>> +``x3``, following the register convention of the Firmware Handoff
>> +specification. Without a transfer list, U-Boot uses the ``memory`` node of its
>> +own devicetree, which describes 8 GiB of DRAM.
> 
> I'm confused how the DRAM reservations propagated when the OS boots with
> a separate DTB.
> 
> As far as I can see, the firmware overlay is applied only to U-Boot’s
> control DT. The normal OS DT fixups update the memory banks, but do
> not copy these additional reserved-memory nodes. This also applies with
> OF_UPSTREAM: the control DT and the DTB passed to Linux can still be
> separate trees.
> 
> If the distro supplies a DTB without these reservations, Linux could
> therefore use the DRAM-controller tracking buffers, even though U-Boot
> correctly reserves them.
> 
> Am I missing an existing fixup that handles this? Otherwise, I think we
> need to propagate these reservations into the OS DT before booting. The
> documentation currently says they are passed to the OS, but that appears
> to depend on which DTB is used.

Oops, there is another series I am working on that I haven't sent out yet
that does this. It implements ft_system_setup() to copy the no-map regions
from the U-Boot devicetree to the kernel devicetree (similar to how
optee_copy_fdt_nodes() does it for optee nodes).

> 
> Cheers!
> 
> --
> Carlo Caione

