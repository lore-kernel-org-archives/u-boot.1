Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12655C27C4F
	for <u-boot@archiver.kernel.org>; Wed, 26 Jun 2024 15:58:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B4AF87F33;
	Wed, 26 Jun 2024 17:58:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="pcHyySUF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C91C387E49; Wed, 26 Jun 2024 17:58:38 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2BF9087F33
 for <u-boot@lists.denx.de>; Wed, 26 Jun 2024 17:58:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-57d1782679fso623906a12.0
 for <u-boot@lists.denx.de>; Wed, 26 Jun 2024 08:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719417514; x=1720022314; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OCNIF0vWNmJeEd1W13vqeWqb+2OouC3NAXhXDnb+mHI=;
 b=pcHyySUFqXoBuWFDzp3s862Wwr5+lTApFCHWsFAZUN5sfBZnA8GiwgB6CUTKFf/70p
 Dja4qAJPuu/I+gYnGB00Evzdwx0+V8lcngsfWHwmEUP28thu/xpwh5tpCx9tBxgf7cnO
 9GJMxoxv/aZj7tuXTyaYkkhQh91cJ2dqTbzj5wqVzKNKGzEplq7V92FFmAzzeX5cKRJB
 zJqoT8KQ/JXNQKbBfWlF80SzvNF6Rmh+SCQ5qBOJM5CgPDXinggvp7flrd2tfcnPoC53
 t74D4RLcjV1HA4xGyGyXD7Gv04gMW5fDXyoBIhp8zmIF6oTywApXTzxpp6S/IhQIbcye
 KUAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719417514; x=1720022314;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OCNIF0vWNmJeEd1W13vqeWqb+2OouC3NAXhXDnb+mHI=;
 b=uBjDdpgKJu7asXfT7ds1RgseTsze3irnfyJhm34V9ngksTd7bQhXlJKnr65puRAY8k
 KCr71BnGcx5s2O3UCxl/unEE1TcyUMh1A6KQtmcAIHhyl+3FWPeeaV0yqZFV8OF+iUDO
 7rTBxGgGm4F/1CrRKeuDiz6RbxrypoUBLyky0zvawvhn+YxKNGx4gSomAjLUnPa8z1HX
 85Hoo1ZLRwFFNvaXStkEbxRnut1R8uLsG1bCCiQG2bjPJfNPpLj0BWO5w91JSvhKdoki
 /G0PdLQ+R5vJUwk0ES94uaoTrp4X95m39nPiv0ic5fpAJlDOLaw2AOtDLddg25HOnpzw
 MRGg==
X-Gm-Message-State: AOJu0YwL/7Id75ORLJoZD93sP/v8HCxhf6ZJfAFhdmlTUZ75rea5k6HO
 P0MYK1vfrXkNQRslaLilHErMwu8m4eXO/M33UPbdwMtdpp+0ppdgDuUvTekPHLI=
X-Google-Smtp-Source: AGHT+IExXOFEwtdE5KEhbAHcaP7YHpTcRUS+hj1gh1uuCjlKdOE4HMT0+c3BNoTzVapn7a4aWMMbeg==
X-Received: by 2002:a50:d7cc:0:b0:57a:1e0a:379f with SMTP id
 4fb4d7f45d1cf-57d4bd6a2ddmr6388326a12.16.1719417514203; 
 Wed, 26 Jun 2024 08:58:34 -0700 (PDT)
Received: from ?IPV6:2a02:8109:aa0d:be00::18f8? ([2a02:8109:aa0d:be00::18f8])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57d3042d10csm7458147a12.40.2024.06.26.08.58.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Jun 2024 08:58:33 -0700 (PDT)
Message-ID: <5500bc65-82cc-418a-8836-b90e923ce4bb@linaro.org>
Date: Wed, 26 Jun 2024 17:58:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/4] Add fdt_kaslrseed function to add kaslr-seed to
 chosen node
To: Tim Harvey <tharvey@gateworks.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Devarsh Thakkar <devarsht@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, Marek Vasut <marex@denx.de>,
 Michal Simek <michal.simek@amd.com>, Andy Yan <andy.yan@rock-chips.com>,
 Akash Gajjar <gajjar04akash@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Chris Morgan <macromorgan@hotmail.com>
References: <20240618210609.1744727-1-tharvey@gateworks.com>
 <20240618210609.1744727-2-tharvey@gateworks.com>
 <7c12b0ac-5785-4199-9faf-5661b8809137@linaro.org>
 <CAJ+vNU2LN9PTbEanEbHGgHG6qGL2jV8fDy8K-1W9Am1VbPyOsA@mail.gmail.com>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <CAJ+vNU2LN9PTbEanEbHGgHG6qGL2jV8fDy8K-1W9Am1VbPyOsA@mail.gmail.com>
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



On 24/06/2024 17:47, Tim Harvey wrote:
> On Thu, Jun 20, 2024 at 6:58 AM Caleb Connolly
> <caleb.connolly@linaro.org> wrote:
>>
>> Hi Tim,
>>
>> On 18/06/2024 23:06, Tim Harvey wrote:
>>> If RANDOMIZE_BASE is enabled in the Linux kernel instructing it to
>>> randomize the virtual address at which the kernel image is loaded, it
>>> expects entropy to be provided by the bootloader by populating
>>> /chosen/kaslr-seed with a 64-bit value from source of entropy at boot.
>>>
>>> Add a fdt_kaslrseed function to accommodate this allowing an existing
>>> node to be overwritten if present. For now use the first rng device
>>> but it would be good to enhance this in the future to allow some sort
>>> of selection or policy in choosing the rng device used.
>>>
>>> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
>>> Reviewed-by: Simon Glass <sjg@chromium.org>
>>> Cc: Michal Simek <michal.simek@amd.com>
>>> Cc: Andy Yan <andy.yan@rock-chips.com>
>>> Cc: Akash Gajjar <gajjar04akash@gmail.com>
>>> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>>> Cc: Simon Glass <sjg@chromium.org>
>>> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
>>> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
>>> Cc: Devarsh Thakkar <devarsht@ti.com>
>>> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
>>> Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>
>>> Cc: Marek Vasut <marex@denx.de>
>>> Cc: Tom Rini <trini@konsulko.com>
>>> Cc: Chris Morgan <macromorgan@hotmail.com>
>>> ---
>>> v6:
>>>    - collected tags
>>> v5:
>>>    - move function to boot/fdt_support.c
>>>    - remove ability to select rng index and note in the commit log
>>>      something like this as a future enhancement.
>>>    - fixed typo in commit message s/it's/its/
>>>    - use cmd_process_error per Michal's suggestion
>>> v4:
>>>    - add missing /n to notice in kaslrseed cmd
>>>    - combine ints in declaration
>>>    - remove unused vars from board/xilinx/common/board.c ft_board_setup
>>> v3:
>>>    - skip if CONFIG_MEASURED_BOOT
>>>    - fix skip for CONFIG_ARMV8_SEC_FIRMWARE_SUPPORT
>>>    - pass in rng index and bool to specify overwrite
>>>    - remove duplicate error strings printed outside of fdt_kaslrseed
>>>    - added note to commit log about how EFI STUB weeds out kalsr-seed
>>> v2:
>>>    - fix typo in commit msg
>>>    - use stack for seed to avoid unecessary malloc/free
>>>    - move to a library function and deduplicate code by using it
>>>      elsewhere
>>> ---
>>>    boot/fdt_support.c    | 44 +++++++++++++++++++++++++++++++++++++++++++
>>>    include/fdt_support.h | 10 ++++++++++
>>>    2 files changed, 54 insertions(+)
>>>
>>> diff --git a/boot/fdt_support.c b/boot/fdt_support.c
>>> index 2bd80a9dfb18..b1b2679dea0c 100644
>>> --- a/boot/fdt_support.c
>>> +++ b/boot/fdt_support.c
>>> @@ -7,12 +7,15 @@
>>>     */
>>>
>>>    #include <common.h>
>>> +#include <dm.h>
>>>    #include <abuf.h>
>>>    #include <env.h>
>>>    #include <log.h>
>>>    #include <mapmem.h>
>>>    #include <net.h>
>>> +#include <rng.h>
>>>    #include <stdio_dev.h>
>>> +#include <dm/device_compat.h>
>>>    #include <dm/ofnode.h>
>>>    #include <linux/ctype.h>
>>>    #include <linux/types.h>
>>> @@ -274,6 +277,47 @@ int fdt_initrd(void *fdt, ulong initrd_start, ulong initrd_end)
>>>        return 0;
>>>    }
>>>
>>> +int fdt_kaslrseed(void *fdt, bool overwrite)
>>> +{
>>> +     int len, err, nodeoffset;
>>> +     struct udevice *dev;
>>> +     const u64 *orig;
>>> +     u64 data = 0;
>>> +
>>> +     err = fdt_check_header(fdt);
>>> +     if (err < 0)
>>> +             return err;
>>
>> All the paths that call fdt_kaslrseed() call fdt_check_header()
>> beforehand, I think it's safe to drop this.
> 
> Hi Caleb,
> 
> The do_kaslr_seed path does not check for this and instead passes
> working_fdt - perhaps your point is still valid if working_fdt is
> guaranteed to always be a valid fdt?
> 
>>> +
>>> +     /* find or create "/chosen" node. */
>>> +     nodeoffset = fdt_find_or_add_subnode(fdt, 0, "chosen");
>>> +     if (nodeoffset < 0)
>>> +             return nodeoffset;
>>
>> Arguably, this shouldn't be the responsibility of this function, maybe
>> it would be better to error our here?
> 
> I'm not sure what your point is here... it is erroring out.

Hi Tim,

On a re-read, I'm honestly not sure what I was getting at here. I was 
under the impression that were were doing fdt_check_header() multiple 
times on the same fdt, but if that's not the case then this is of course 
fine.

Regarding the chosen node, clearly something went amiss between brain 
and keyboard there.

Sorry if I delayed this patch series! Looking forward to having it in.

Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>

Thanks and regards,
> 
> Best Regards,
> 
> Tim
> 
>>> +
>>> +     /* return without error if we are not overwriting and existing non-zero node */
>>> +     orig = fdt_getprop(fdt, nodeoffset, "kaslr-seed", &len);
>>> +     if (orig && len == sizeof(*orig))
>>> +             data = fdt64_to_cpu(*orig);
>>> +     if (data && !overwrite) {
>>> +             debug("not overwriting existing kaslr-seed\n");
>>> +             return 0;
>>> +     }
>>> +     err = uclass_get_device(UCLASS_RNG, 0, &dev);
>>> +     if (err) {
>>> +             printf("No RNG device\n");
>>> +             return err;
>>> +     }
>>> +     err = dm_rng_read(dev, &data, sizeof(data));
>>> +     if (err) {
>>> +             dev_err(dev, "dm_rng_read failed: %d\n", err);
>>> +             return err;
>>> +     }
>>> +     err = fdt_setprop(fdt, nodeoffset, "kaslr-seed", &data, sizeof(data));
>>> +     if (err < 0)
>>> +             printf("WARNING: could not set kaslr-seed %s.\n", fdt_strerror(err));
>>> +
>>> +     return err;
>>> +}
>>> +
>>>    /**
>>>     * board_fdt_chosen_bootargs - boards may override this function to use
>>>     *                             alternative kernel command line arguments
>>> diff --git a/include/fdt_support.h b/include/fdt_support.h
>>> index 4b71b8948d99..741e2360c224 100644
>>> --- a/include/fdt_support.h
>>> +++ b/include/fdt_support.h
>>> @@ -463,4 +463,14 @@ void fdt_fixup_board_enet(void *blob);
>>>    #ifdef CONFIG_CMD_PSTORE
>>>    void fdt_fixup_pstore(void *blob);
>>>    #endif
>>> +
>>> +/**
>>> + * fdt_kaslrseed() - create a 'kaslr-seed' node in chosen
>>> + *
>>> + * @blob:    fdt blob
>>> + * @overwrite:       do not overwrite existing non-zero node unless true
>>> + * Return:   0 if OK, -ve on error
>>> + */
>>> +int fdt_kaslrseed(void *blob, bool overwrite);
>>> +
>>>    #endif /* ifndef __FDT_SUPPORT_H */
>>
>> --
>> // Caleb (they/them)

-- 
// Caleb (they/them)
