Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A530C54FC6
	for <u-boot@archiver.kernel.org>; Sun,  1 Sep 2024 14:21:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71F918873C;
	Sun,  1 Sep 2024 16:21:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GIw5Ed23";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 04C1A889F8; Sun,  1 Sep 2024 16:21:46 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8B778873C
 for <u-boot@lists.denx.de>; Sun,  1 Sep 2024 16:21:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a86883231b4so392438266b.3
 for <u-boot@lists.denx.de>; Sun, 01 Sep 2024 07:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725200503; x=1725805303; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dcI2kzHNA/wBW68m3Cwd4AipmdJ6JvN80lQy/IzMc4I=;
 b=GIw5Ed23xNHdOAXVQpIlK3Mj59+ioytK/KInV36z15JD2kf0ixpUqx1QiX8KO1i0jm
 TEGBkMvdtodk3x1DeL+rd2LViBcGq0880mGQhiTdA8N0gXECiHFJTdM7t9Ck0Pyek5bW
 OOJcOatlmIT++frI5pt7GeOUMA9CLLjDo7Op4CGPhlwQsiyIC9A6lBxglOFYbOOsJOMV
 GTpwsNhezwPQciO8NT9gNTnlWur1EMVj56EF9yugK0gTuBOw5EjlS69Ip5HzxmEeEkpD
 3wmtebCBtBrmvoNVIQ20FOemUq2NNcSeKymIsQtsoMpnOcsOY12ZJ5DUgSLgENdWdVUs
 ykwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725200503; x=1725805303;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dcI2kzHNA/wBW68m3Cwd4AipmdJ6JvN80lQy/IzMc4I=;
 b=OXC1hAZE9kaQYMbaMgjDm/y12XM6EvythG0IgafYDGXRtrgMmNuxUmP/zVUwbVytIT
 QCCT/4o3f0TtN/oWung22uO8T87jm26PXpD09ijpQO8YAbrk2C6IHeU1qOqzcoCTqckz
 ycrXdQOTYEhuYHjcF6SzcqxF94jMzK8BCqUY7o85LW1TFDVepR1PV25lrrZ5/B/xAZl0
 9c+FmcVSIiOtDEhQNN5mJPwxiq0wsZa0YVEYSS5PFMT20AmNiqcbV8+mnA+fq8IQvA8+
 E8/83m/bbsSGgLce/IJEDlDm29rXJXOm+NDOpUGt6rNf8oJ1rTvdBqVGoHvWou9fH5pL
 gxNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvPVonoTiF6QGjh1irMkCJ9NrTYafxXn+/DFvVPICi83VL32v9oJXzx+1sv+G7nd3El929TDA=@lists.denx.de
X-Gm-Message-State: AOJu0YxL6DelBidJiv7Fbm27VIMoI2P+lz/xDJAejrfz8kG7JoINk/fl
 jfsUP4c2iDEYBPN2UuUBBugHr1bgKfIRNBw9sWuu6shD5N2wA+CYpp8C5vArvCI=
X-Google-Smtp-Source: AGHT+IHQnkDmrtEf/SmyrmYrfFT3tglYUuMt3vEdUNaZqjx53SWPXPAT76ibE9WnPDLkDyxeY4z60Q==
X-Received: by 2002:a17:907:d08:b0:a86:8f32:3a68 with SMTP id
 a640c23a62f3a-a89d879c0femr279952666b.37.1725200503091; 
 Sun, 01 Sep 2024 07:21:43 -0700 (PDT)
Received: from ?IPV6:2a02:2455:812b:6300:9265:84ff:fec9:103a?
 ([2a02:2455:812b:6300:9265:84ff:fec9:103a])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a89890229b5sm446715066b.51.2024.09.01.07.21.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Sep 2024 07:21:42 -0700 (PDT)
Message-ID: <feff5299-6378-4de9-867d-808c23625af4@linaro.org>
Date: Sun, 1 Sep 2024 15:21:41 +0100
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH] cmd: fdt: use U-Boot's FDT by default
To: E Shattow <lucent@gmail.com>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20240831164639.2298097-1-caleb.connolly@linaro.org>
 <CANV2PTM+wevfK7w15j-=a2oakPMMXpTdr7ntzBfkc3jbbv+veg@mail.gmail.com>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <CANV2PTM+wevfK7w15j-=a2oakPMMXpTdr7ntzBfkc3jbbv+veg@mail.gmail.com>
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

Hi,

On 31/08/2024 23:22, E Shattow wrote:
> Hi Caleb, the problem here is hidden conditional behavior.
> 
> On Sat, Aug 31, 2024 at 9:56 AM Caleb Connolly
> <caleb.connolly@linaro.org> wrote:
>>
>> When using the FDT command to inspect an arbitrary FDT in memory, it
>> will always be necessary to explicitly set the FDT address. However it
>> is also quite likely that the command is being used to inspect U-Boot's
>> own FDT. Simplify that common workflow of running "fdt addr -c" to get
>> the control address and set it by just making $fdtcontroladdr the
>> default FDT if there isn't one.
>>
>> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
>> ---
>>   cmd/fdt.c | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/cmd/fdt.c b/cmd/fdt.c
>> index d16b141ce32d..8909706e2483 100644
>> --- a/cmd/fdt.c
>> +++ b/cmd/fdt.c
>> @@ -276,8 +276,17 @@ static int do_fdt(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>>
>>                  return CMD_RET_SUCCESS;
>>          }
>>
>> +       /* Try using U-Boot's FDT by default */
>> +       if (!working_fdt) {
>> +               struct fdt_header *addr;
>> +
>> +               addr = (void *)env_get_hex("fdtcontroladdr", 0);
>> +               if (addr && fdt_check_header(&addr))
>> +                       set_working_fdt_addr((phys_addr_t)addr);
>> +       }
>> +
>>          if (!working_fdt) {
>>                  puts("No FDT memory address configured. Please configure\n"
>>                       "the FDT address via \"fdt addr <address>\" command.\n"
>>                       "Aborting!\n");
>> --
>> 2.46.0
>>
> 
> The use of `fdt` command in the default action might be depended on by
> some userspace script as a success/fail result. I don't imagine what
> that might possibly be, just that the logic of scripts in u-boot
> depend on that pattern of use.

I'm not sure what the rule is about breaking changes in the CLI, I do 
think this is not a realistic concern here though. Maybe Tom or Simon 
can weigh in?
> 
> Secondly there would need to be a warning to the user that some hidden
> conditional action is being applied? i.e. "No valid FDT address is
> configured to $fdt_addr_r or $fdt_addr so now configuring to use
> $fdtcontroladdr instead." or however you would phrase that.

Since I call set_working_fdt_addr() it prints a message telling you that 
the fdt address was set on the first call.
> 
> Otherwise I agree improvement to the fdt is welcome and my memory of
> first using this command is that it has not-sensible defaults but I
> then assumed it was designed this way because of possible use in
> U-Boot scripts.

Thanks.
> 
> -E

-- 
// Caleb (they/them)
