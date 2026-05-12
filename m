Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34E90CD4851
	for <u-boot@archiver.kernel.org>; Tue, 12 May 2026 10:53:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A2D080398;
	Tue, 12 May 2026 12:53:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="x2DXwWRU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5953803C6; Tue, 12 May 2026 12:53:39 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B195801A9
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 12:53:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-488a9033b2cso49309425e9.2
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 03:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778583217; x=1779188017; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3S7wT2ttyW76vGyVHy+kC9s7pQ95SI4e8B2FQ+GDLO4=;
 b=x2DXwWRUpxKu8KOoNF110hQciy1EDgP1rEi9ft1f5yvmnCiZZBgJ9BIskcpBcke76z
 cugsA2XGH9j0o7N5zzp+/GAMpSGWlkNrb3avUWUMhesgFy2hH+cU0j/+/aqVHJZQjDI0
 RnodypCzNokdShQ8qxh+/53YSPfcr3uZWB3/wKnsUl/ohT407r8XJ550eOqeMN0e/uKb
 EtYB3yB3KDC5XYVAUIRHBB4cy0tlCxW70GrsyBhu9lU1rZkq5rVMk/t8w0YVynX/9XpX
 Om9G8ssRZSGOMPKi3+GlFWcavqxqphSurySVLM+hFciEJxjj209BpERnaHAMWnuM2Mws
 Vpmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778583217; x=1779188017;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3S7wT2ttyW76vGyVHy+kC9s7pQ95SI4e8B2FQ+GDLO4=;
 b=CQkL2RG6CEQO+8JjwRtAYX68QYVU5pjRuaFDFqMsXODgQZHCPnFSSbBbMmokl/bmhe
 MXI9idRwoxwqLCuOw+y6n78/DF2Fex+jcP8N6xsV17LCu0QxSyLmcv+SwPZdxKkWYb9q
 hD089IQcjsTL1EnGPo08bjwEN2hQbQL5o2H+rhBeFBy4oTSjLzJKVNHeZFXmwyCVEV/n
 e5Xsy6Q5L/FTT7V3jmWS8Nbpqbdgf3YWryoWXXRIp69eqwyKqgj+0cE+eY31q5gYyCHZ
 1gDtogpVgkwffGSFWPaz0OoUiiMOPH199fd0beJGjOT7kuUu8r1rY0i3sKLxF/5bFvRV
 WI6Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ8EPezc8FtHgJQavQHiyZBMAHWHbEhqZoUKeh+SZj4AfZ+WOL1yAGMv+UuWncF/FIb8Moy5g0I=@lists.denx.de
X-Gm-Message-State: AOJu0YxXpJeMvfTTLRk61qXIhXXoaURnpv5NjrloYTI/aSfycPi5uA3+
 KuOsq4PAnWi+fhtAP5lIydi67XxxPa+EsX14LkDX2rHqFTNOEIBVAbfXCmyxNDRSacg=
X-Gm-Gg: Acq92OGfxWGjBMuDggQmh0qxESxLdGO6WH0FxSVib6NM8YmZGGdfEsM1LLwbbDCPOqs
 4EhiRlhRRz7wJqaXWUBiEt6D6dPtiH6Nmp0OtJx4YsMXR/kZ+eh9WzIr7cvuWFdPHydydr2lWdd
 AQ6E0/y0qFTKHGr5i4kryjAIW6i26jxAiRN/rdRHj5K9gfwHjvyUAB/8YSG+BJ82fwTJ2OUHnCL
 trP3Fs3ezr/y2f2sO0QBTfglsN7KTjTWmPHAaB3HueqlltaEmU1foozFsF/pCCjGZps4KZ1666V
 or9J4bimNfqb5mZgyBeSJFmmrM8GLgKD9nlJyISsyQydBsMQHzb8FB1vBlYeE2/sfkizPLVi1ef
 Qq6N811XUl5osEU+Ry7zcOpDznd9ILCWBF6lrgrSlG3C/GF/pO+RmaHCZ+CzGuchH84yYYFfY3x
 VDY89q3x6xdJQqoqUra/9MlAUeQIqGpuixKesrwk87zM74IVbqz58Brkytwl4MGHDd8Q==
X-Received: by 2002:a05:600c:8214:b0:48a:6268:18a9 with SMTP id
 5b1f17b1804b1-48e706b262amr222225725e9.13.1778583216700; 
 Tue, 12 May 2026 03:53:36 -0700 (PDT)
Received: from [192.168.1.36] (p4fc3dd86.dip0.t-ipconnect.de. [79.195.221.134])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e906a95dfsm41634765e9.5.2026.05.12.03.53.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 May 2026 03:53:36 -0700 (PDT)
Message-ID: <db04b031-2411-470e-aeeb-68b261b98c4a@linaro.org>
Date: Tue, 12 May 2026 12:53:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 09/11] mach-snapdragon: add board_spl.c and split out
 common code
Content-Language: en-US
To: Sumit Garg <sumit.garg@kernel.org>
Cc: Michael Srba <Michael.Srba@seznam.cz>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Peng Fan <peng.fan@nxp.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Jerome Forissier <jerome.forissier@arm.com>, Heiko Schocher
 <hs@nabladev.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Lukasz Majewski <lukma@denx.de>, Neil Armstrong <neil.armstrong@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>
References: <20260508-qcom_spl-v7-0-7d0e22aaaa8f@seznam.cz>
 <20260508-qcom_spl-v7-9-7d0e22aaaa8f@seznam.cz>
 <d965e291-51eb-4120-8740-1f14d739bc5c@linaro.org>
 <6bc4f999-b37f-4961-9bed-17d45e1b77ac@seznam.cz>
 <85e696ff-e66c-4cd3-92d7-61edfe6493ab@linaro.org>
 <agK1zQWeFmaEfs-J@sumit-xelite>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <agK1zQWeFmaEfs-J@sumit-xelite>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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



On 12/05/2026 07:08, Sumit Garg wrote:
> + Varda
> 
> Hi Casey,
> 
> On Mon, May 11, 2026 at 04:00:46PM +0200, Casey Connolly wrote:
>>
>>
>> On 11/05/2026 15:55, Michael Srba wrote:
>>>
>>>
>>> On 5/11/26 15:33, Casey Connolly wrote:
>>>> Hi Michael,
>>>>
>>>> On 08/05/2026 23:45, michael.srba@seznam.cz wrote:
>>>>> From: Michael Srba <Michael.Srba@seznam.cz>
>>>>>
>>>>> Code in board.c will now only be compiled into U-Boot proper,
>>>>> and the new board_spl.c will only be built into SPL.
>>>>> Code in board_common.c is common to both phases.
>>>>>
>>>>> Also split out mem_map.c, which is currently common to both
>>>>> phases since it seems to not cause issues in SPL. In the future
>>>>> it should probably behave differenly in SPL, especially if dram
>>>>> initialization is supported.
>>>> Sorry to be a pest with this one, could you rebase this on the SMEM
>>>> series since it also pulls out all the memory mapping stuff.
>>>>
>>>> Since the only thing you left in board_common.c is the board_usb_init(),
>>>> it seems like it's only actually used in db410c at least according to a
>>>> quick grep. Could you just move it over to board/qualcomm/
>>>> dragonboard410c?
>>>>
>>>> Along with the other changes maybe most of the contents of board_spl.c
>>>> should go into some board/qualcomm/sdm845-spl/board.c file or something?
>>> but there's nothing sdm845-specific about it? SPL won't ever be passed
>>> dt by a previous stage, empty board-init is a sensible default even
>>> if someone wants to override it in specific cases, reset-cpu is a stub and
>>> if qcom wants to implement it there's no good reason to use PSCI for that
>>> so it can be universal (though an ifdef for the non-typical case
>>> of late-in-the-chain SPL would probably still be cleaner than multiple
>>> separate board.c files), and fully implemented spl_boot_device should check
>>> what medium the BROM booted from (or at least if it was EDL, which is
>>> in a hw register, not sure if emmc vs ufs vs sdcard vs spi needs awareness
>>> of data passed from PBL), so again can be perfectly shared.
>>> If DFU is not enabled in config then the USB boot branch can even
>>> be ifdef'd away at compile time.
>>
>> Alright, I'm a bit unsure how Qualcomm want to base their stuff on top
>> so I'll defer to you and we can keep this as-is. fwiw the "sdm845-spl"
>> naming is just arbitrary, if you can pick a better name please do.
>>
>> Sumit: any thoughts on how to align these approaches and keep it all
>> maintainable?
> 
> Yeah I earlier asked Michael and Varda to converge on common Qcom SPL
> architecture which can be used across SoCs.
> 
> Basically how I think the way forward here would be to have a common
> Qcom SPL architecture which would then have the platform specific hooks
> for functionality currently supported by that platform. Once more
> platforms try to use the same functionality then we can migrate that to
> common code.
> 
> Looking at Michael's series, I think it's mostly doing the base
> infrastructure SPL setup without much boot functionality added. So we
> should be able to merge that once it's rebased on your SMEM patch-set.
> Then Varda should be able to rebase the IPQ series on top of it. I think
> the QCLIB blob loading for DRAM setup can be a platform specific hook in
> the common SPL code overriden for IPQ platform for now.

Sounds sensible to me!

> 
> Michael, Varda,
> 
> Let us know if there are any concerns to approach mentioned above.
> 
> -Sumit

-- 
// Casey (she/her)

