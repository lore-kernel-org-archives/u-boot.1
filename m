Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93584CD8C92
	for <u-boot@archiver.kernel.org>; Mon,  8 Jun 2026 13:06:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E55D884704;
	Mon,  8 Jun 2026 15:05:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sigma-star.at header.i=@sigma-star.at header.b="aIfmwPhr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38C1D84825; Mon,  8 Jun 2026 11:08:51 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 349CF807C4
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 11:08:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lorenz@sigma-star.at
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-45efa80e0afso3130712f8f.2
 for <u-boot@lists.denx.de>; Mon, 08 Jun 2026 02:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sigma-star.at; s=google; t=1780909729; x=1781514529; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=oq/+TmyzJR3yPIysryEaskqvVpUMIlIw+vw136nFsXw=;
 b=aIfmwPhrEz2tRMwWWbDVMsOHr1YBr2ADL0JWMF8ams8T2V3Mmx1JeSB9IDl9/FmuSG
 86eRaY2zKiqirDQAcv3QWBby5mbXIuY9Aq5PGkLfZmqemfwRs0f0zllq1Syi4JdlFgsg
 VwZcf0zucColkPkWwZIWFjmbep8ptqO6/mD259OW1R3/mTw+kPIsbJWcYKk+CSxa6bUg
 8/LKiWKp8FX0JERPVHdG9on452SFnAMj5L5o8W8dJTEOk7eBvq3lZWkYMwj5VPuJ6XyJ
 TexsRSBNDBbvvaZjS9wtWCvBg8nyTwmRHNnDaaMm8NzTkWCbqtvuILgxhpbaEwFVidgE
 jWtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780909729; x=1781514529;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oq/+TmyzJR3yPIysryEaskqvVpUMIlIw+vw136nFsXw=;
 b=CQ4y1T0dGRcHNTC44g5Kjy3sWt9YUL3AA5CmP3YBAVszRuxFa3FVyHo+2+Q66oAQ5R
 PVPnVz/6CndULtYBmoigcTeXOz8cetVUVEFlS8VMQBpB4Z9BFmkAF1cFvbxvPaebweiK
 D910DnBY+BPSUarxe19QnvoAwd+bQhR3fvf+XrQO+YYtH9pfMqLRL+JG6xKv16QFbVbN
 kJrnhkIfQbeOsO8Xr09elO+zljicqg80IbaXvP1z7xV5GV4zI3IMyZVbluK0HvZNjt9c
 +YlyWIsjNTXxk+pKQzzhWpEsUXKDo5TOC7S3ewyOz6xUlnevvw+OjYOyhK9A5JSFMEk3
 qc4Q==
X-Gm-Message-State: AOJu0YwBPEy6qiR/oxKtroOniB2/1gsC++Vx+r9JvhXpqY2v8xfSk0uc
 iNhyCenns1W0gWgdHCWMEs065ZWLLuvxJP96ajJUnL3YdVsguz4UtYg1Scwp9m7806lYXkJkdKQ
 tajqXlG7iAg==
X-Gm-Gg: Acq92OEF7Aure4lNaYHEiL8vcWoNgVeWEorDa5he4SOFXoBrRwq5wByqzE+Wuw2vgN8
 bNhoXDzudUrnb1a/0k6tzIF8JXOEameBjqbqGoCUyfB4seDn8u/7rKdlrb8k4qwEXCyH/b9wfee
 Gmy+qU+ssTENzP+nX4ROSrnOh8dLP0qgfcli77qIPO9U1/VPGAMH4bHQspwS8UoYOhF7O8ULBCQ
 mNVoO3MoVNC+Wb0JnCt0h4rzRMFH8/Ucv/s4u3gQrRD8/e0Sh1XG5kxomCeepx2zIb6U7pD9/Wq
 QCuyydBNRtsVmn0q5b5xLRaQBgB8GtLZYP5FSn3hjjsoHKUF62uTVdr0ZX+5fz6usLxtFPNsIOq
 TTdJfOUmZoIVkLikOJDTEiCKK+MMSFtO7cjbXgoy3EBpWsXxRfDiBeEyucwfAxtO/dHE4Sc0dOQ
 I5pwbDi3Kb+SVl7qZZrxbTCC6j46VXB75HV16NYcBSwg/kPsPHMXjrIPtC1lEdZVhJzkJIcCNqO
 Sb4BFf6RPbj63w=
X-Received: by 2002:a05:600c:8a0c:10b0:490:c682:e37d with SMTP id
 5b1f17b1804b1-490c682e39dmr107542145e9.32.1780909728568; 
 Mon, 08 Jun 2026 02:08:48 -0700 (PDT)
Received: from ?IPV6:2a04:9546:1c18:5b01:e4e2:7f5d:bdb1:1ff2?
 ([2a04:9546:1c18:5b01:e4e2:7f5d:bdb1:1ff2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490bc3918fcsm429965915e9.3.2026.06.08.02.08.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jun 2026 02:08:48 -0700 (PDT)
Message-ID: <322a63c7-0b63-4762-8968-f9112dd6863b@sigma-star.at>
Date: Mon, 8 Jun 2026 11:10:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/3] boot/fit: fix CVE-2021-27138 while keeping '@'
 node names
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 upstream+uboot@sigma-star.at, Arie Haenel <arie.haenel@intel.com>
References: <20260602074335.3965312-1-lorenz@sigma-star.at>
Content-Language: en-US
From: Lorenz Kofler <lorenz@sigma-star.at>
Autocrypt: addr=lorenz@sigma-star.at; keydata=
 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
 RN2HqQUYnIgKMEqcnsan22HO9tKGdaxTYmKdGQ==
In-Reply-To: <20260602074335.3965312-1-lorenz@sigma-star.at>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Mon, 08 Jun 2026 15:05:40 +0200
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

Hello!

Gentle ping :) Any feedback on this patch?

On 6/2/26 9:43 AM, Lorenz Kofler wrote:
> CVE-2021-27138 was fixed by rejecting any FIT node whose name contains '@'.
> That stops libfdt's unit-address matching from resolving a reference such
> as "kernel" to a node named "kernel@1".
> 
> Rejecting '@' outright, however, is a regression. We have a customer with
> signed FIT images deployed in the field that use '@' in node names, and
> with signature verification enabled those images are now rejected and fail
> to boot.
> 
> Such names are admittedly not ideal. The devicetree specification only
> allows a unit address when the node has a matching 'reg' property, and
> newer dtc versions warn about violations. New FIT images should therefore
> avoid such names, but existing deployed images still need to keep working.
> 
> This series fixes CVE-2021-27138 without that regression. The root cause is
> not the '@' character itself, but accepting a non-exact node-name match
> when resolving a FIT reference. Patch 1 hardens the lookups so the
> requested name and the resolved node name must match exactly: an inserted
> "kernel@1" can no longer stand in for the "kernel" node. Patches 2 and 3
> then drop the now-redundant blanket '@' rejection.
> 
> Review is welcome, especially on whether I missed any place that looks up a
> FIT node by name.
> 
> Lorenz Kofler (3):
>    boot/fit: require exact subnode matches for FIT references
>    boot/fit: stop rejecting '@' during image and config verification
>    boot/fit: stop rejecting '@' during FIT format checking
> 
>   boot/image-fit-sig.c        | 21 +-----------
>   boot/image-fit.c            | 65 +++----------------------------------
>   common/spl/spl_fit.c        |  4 +--
>   include/image.h             | 28 ++++++++++++++++
>   test/py/tests/test_vboot.py |  7 ++--
>   5 files changed, 39 insertions(+), 86 deletions(-)
> 

-- 
sigma star gmbh | Eduard-Bodem-Gasse 6, 6020 Innsbruck, Austria
UID/VAT Nr: ATU 66964118 | FN: 374287y

