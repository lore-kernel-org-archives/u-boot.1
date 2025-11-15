Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7263ACEBF86
	for <u-boot@archiver.kernel.org>; Sun, 16 Nov 2025 00:20:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A80DF83A35;
	Sun, 16 Nov 2025 01:20:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="KbwS5XQ/";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="b4OpT6T1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E6AB83A3A; Sun, 16 Nov 2025 01:20:16 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41CBD83A48
 for <u-boot@lists.denx.de>; Sun, 16 Nov 2025 01:20:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4d8BNG0h7Cz9tKQ;
 Sun, 16 Nov 2025 01:20:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1763252414;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yMSSSnbJJcLetkOimsKLQUnyJgOZ7HSORoGkqpEolOk=;
 b=KbwS5XQ/zTs8dRduF9eLtLEXHUKBYW6IWLM1/g/Ghsu+g4R6CoqiiJXmeloyqVB9xc6oJ/
 5/XMwTpRbCwHFhE1LizgKgAw14WIgaXk02jdwIb+7OEIcJJCJ91leCkg8xzfrtEF9+y7H/
 K/mK35fJtrP63gKbS45qtW/RFsn1/Q+Jf2XaemNFAITB2Ieupnk8VzUID1615v6HDcTu7H
 LnfvuYroy0ElJ3P5NOm94LbgBMadSjC+++SMCH8HwAzU8cHjAZWUYC5+UTi+/RL5O0Y3i6
 wp8wRwKpZNsiYiC+agrd1WrGlNelt15iz8+GCD3O15yRiyetxM9bf9eeBaQ2Nw==
Message-ID: <c5300029-9bab-4a06-b426-ccc443d0928c@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1763252412;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yMSSSnbJJcLetkOimsKLQUnyJgOZ7HSORoGkqpEolOk=;
 b=b4OpT6T1p5vET0GtONzo+knNIMOaIK4cirLGwKYx8/kyTLl/lm6Vjb1M616ESX2Syek0xV
 BOSlYNSSpCnWF+PU8WJeYIp3+nM/P39irET6ORvshuqqeTfu3Dn/uNDEgMf22TPINVLhsr
 SpYiWbAaDtWK+kBJUL88+b1+vh0lvh62aRLhkM/LGw90lR/eHFiWtkgxXQD0Jx82oat+al
 f+Xog+8nsoW2yRXlhJzO/VVSBTUxiw5wqCC5XuwFd5zEcQNyd7ocZyojYvelQKiE85RQsS
 J6ip1tEnQV9jyKCOuUQl1Yk4JNfiLozVxubFnpM2df5008gw2EyH+4evdDoRFg==
Date: Sat, 15 Nov 2025 18:19:53 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] boot: Assure FDT is always at 8-byte aligned address
To: Simon Glass <sjg@chromium.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 Wolfgang Wallner <wolfgang.wallner@br-automation.com>
References: <20251113115516.947835-1-marek.vasut+renesas@mailbox.org>
 <CAFLszTg0ByjUGgX4MSbU=i0oG7fuidM4J0J128ER6Aq+r6HW9A@mail.gmail.com>
 <81115588-50c7-4ecc-975e-13994101955f@mailbox.org>
 <CAFLszThNLoS7j0pe_8G93dHtX91j331DCBiUgWpUPXi4Oi2-9w@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <CAFLszThNLoS7j0pe_8G93dHtX91j331DCBiUgWpUPXi4Oi2-9w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 022e93829e6f275a927
X-MBO-RS-META: i3imuhpku6q5yonjgjsrgs1nrsizsw3n
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

On 11/13/25 11:46 PM, Simon Glass wrote:

Hello Simon,

>>> The problem should be fixed higher up, in its callers, etc. For one
>>> thing, the caller knows whether it is a DT or not, so putting this
>>> logic here is messy. See boot_get_fdt_fit()
>>
>> This is triggered by a fitImage with DT embedded in that fitImage as
>> non-external-data. That DT is at 4-byte aligned address, so how can the
>> caller deal with it ? The caller gets a fitImage, which itself is at
>> 8-byte aligned address, but the DT in it is not at 8-byte aligned
>> address, so that DT has to be relocated somehow and that happens here.
> 
> OK, but don't put the code in here...see boot_get_fdt_fit(). But even
> then, why does it matter where the FDT is?

The FDT has to be at 8-byte aligned offset.

> We are going to use
> fdt_openinto() at some point and put it elsewhere, right, so we can do
> pre-boot fixups?

Look at the fit load code, cca. 10 lines below, it checks the FDT for 
validity using fdt_check_header() . At that point, the FDT must be at 
8-byte aligned address already:

2294         } else if (load_op != FIT_LOAD_IGNORED && image_type == 
IH_TYPE_FLATDT &&
2295                    ((uintptr_t)buf & 7)) {
2296                 loadbuf = memalign(8, len);
2297                 load = map_to_sysmem(loadbuf);
2298                 memcpy(loadbuf, buf, len);

...

2309         /* verify that image data is a proper FDT blob */
2310         if (load_op != FIT_LOAD_IGNORED && image_type == 
IH_TYPE_FLATDT &&
2311             fdt_check_header(loadbuf)) { <----------------- this
2312                 puts("Subimage data is not a FDT\n");
2313                 return -ENOEXEC;
2314         }

> Perhaps we should deprecate FITs with internal data, too?
We cannot break compatibility and stop supporting old fitImage, so this 
is irrelevant here.
