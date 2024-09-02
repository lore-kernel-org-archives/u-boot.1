Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3932CD342A
	for <u-boot@archiver.kernel.org>; Mon,  2 Sep 2024 13:07:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 442CC87DC7;
	Mon,  2 Sep 2024 15:07:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="We8qTsgb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA3EA88C01; Mon,  2 Sep 2024 15:07:57 +0200 (CEST)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0D0C87873
 for <u-boot@lists.denx.de>; Mon,  2 Sep 2024 15:07:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-53345dcd377so5766949e87.2
 for <u-boot@lists.denx.de>; Mon, 02 Sep 2024 06:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725282475; x=1725887275; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vMKhsFnJMv0d6rS8N8pfpd9dv6v30Tau2F9mUcrNSqU=;
 b=We8qTsgby6+p2611uU1rnXEHLI24slvAqSzFtg6Vuu9MaLm2tJ8FQC8D9i4tz50qsf
 LwKqw+rvlYk0gV0E/iZ4QcAzTiNG8C74G/6BgMgAf0Zn/S2q5CogYt/QNX46bdFIiJ+9
 /CrIC2E/DEsG0OG/+SP3sCDmhD5EgbN/qPFYU4DG/soBiJgygQJz0iWuModee/ECu5D3
 ECTiYqNjDETeKEOINxg+uhA6MkOUiTi7AIpKLllaypcgOQiLY+f8+TkQUuu4OvDUXOvZ
 EfFX4rpiTQMkzpjdutsREA3syk0lsBASXC/H4+m+E9rix7HJn8AcptstZYuYHpffkNmq
 ACxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725282475; x=1725887275;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vMKhsFnJMv0d6rS8N8pfpd9dv6v30Tau2F9mUcrNSqU=;
 b=nXqbbTJ217Sf6Uq8CDw9KimZt2tGBAVQTmZ7AtoxlL3hQMtYtS/cmPq3e+V4d3oVBR
 dQ5HTM9QIMN+kW9oA+kRFUK3T1CxfNuBWkppwtCfJOf0dvhofmqe9jgkOVcPPxcLmdM9
 N9dg+vXPXbxQNySJ8YMgibNQLzuTmHouWbsZa9YhAbT3Fs8eY2Qp+5CvIbY28kZeb7qI
 k4FFckP7kXZkxy4OZYnUwgu6/tmwrAx+sGZSaFf+tXFQ+IpBEWIBfJqgDOCp3ERppbJv
 ebZIQ5eeKUdDrlUUTRnHrrTWRsOSwbuQ/as6EErhiRDxbIuz40dDcJBUNjM2TehlhusD
 0Nyw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7Di2nyPjDzGJ/ngLcL14dK4PInR7dxTYVA6mhRzq0MQFBHiU2kcuV03EPMdDuWFfyb2TtXKo=@lists.denx.de
X-Gm-Message-State: AOJu0YwfjxAPTNJ7LtIcHRhgPOkPuIHH6YGUk2C+2qCCrYkwWrNWlsth
 6oWgHvHOqwFb66VfQ40rC81poAFavXuKMA/E6oHNGtg0FSdNN0wwxGdJyycYBFM=
X-Google-Smtp-Source: AGHT+IGHOA6rxFeszRBJSm/9sCYwC9mT25LhFvl8l9TFCdc8Qj7EqsZDWPraL7Zp+CFWLxrnmsLleQ==
X-Received: by 2002:a05:6512:3095:b0:533:4b38:3983 with SMTP id
 2adb3069b0e04-53546b037c6mr6773946e87.20.1725282474549; 
 Mon, 02 Sep 2024 06:07:54 -0700 (PDT)
Received: from ?IPV6:2a02:8109:aa0d:be00::a253? ([2a02:8109:aa0d:be00::a253])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8989196876sm554929166b.110.2024.09.02.06.07.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Sep 2024 06:07:54 -0700 (PDT)
Message-ID: <96798312-858e-40e9-b174-a850da8de6e9@linaro.org>
Date: Mon, 2 Sep 2024 15:07:44 +0200
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH] cmd: fdt: use U-Boot's FDT by default
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>
Cc: E Shattow <lucent@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20240831164639.2298097-1-caleb.connolly@linaro.org>
 <CANV2PTM+wevfK7w15j-=a2oakPMMXpTdr7ntzBfkc3jbbv+veg@mail.gmail.com>
 <feff5299-6378-4de9-867d-808c23625af4@linaro.org>
 <CAFLszTiZ75zK2L8=5E9dXOHXqEybh7O=OsQiW5hkJ9xoPiWT4Q@mail.gmail.com>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <CAFLszTiZ75zK2L8=5E9dXOHXqEybh7O=OsQiW5hkJ9xoPiWT4Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
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

Hi Simon,

On 01/09/2024 21:10, Simon Glass wrote:
> Hi Caleb,
> 
> On Sun, 1 Sept 2024 at 08:21, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>>
>> Hi,
>>
>> On 31/08/2024 23:22, E Shattow wrote:
>>> Hi Caleb, the problem here is hidden conditional behavior.
>>>
>>> On Sat, Aug 31, 2024 at 9:56 AM Caleb Connolly
>>> <caleb.connolly@linaro.org> wrote:
>>>>
>>>> When using the FDT command to inspect an arbitrary FDT in memory, it
>>>> will always be necessary to explicitly set the FDT address. However it
>>>> is also quite likely that the command is being used to inspect U-Boot's
>>>> own FDT. Simplify that common workflow of running "fdt addr -c" to get
>>>> the control address and set it by just making $fdtcontroladdr the
>>>> default FDT if there isn't one.
>>>>
>>>> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
>>>> ---
>>>>   cmd/fdt.c | 9 +++++++++
>>>>   1 file changed, 9 insertions(+)
>>>>
>>>> diff --git a/cmd/fdt.c b/cmd/fdt.c
>>>> index d16b141ce32d..8909706e2483 100644
>>>> --- a/cmd/fdt.c
>>>> +++ b/cmd/fdt.c
>>>> @@ -276,8 +276,17 @@ static int do_fdt(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>>>>
>>>>                  return CMD_RET_SUCCESS;
>>>>          }
>>>>
>>>> +       /* Try using U-Boot's FDT by default */
>>>> +       if (!working_fdt) {
>>>> +               struct fdt_header *addr;
>>>> +
>>>> +               addr = (void *)env_get_hex("fdtcontroladdr", 0);
>>>> +               if (addr && fdt_check_header(&addr))
>>>> +                       set_working_fdt_addr((phys_addr_t)addr);
>>>> +       }
>>>> +
>>>>          if (!working_fdt) {
>>>>                  puts("No FDT memory address configured. Please configure\n"
>>>>                       "the FDT address via \"fdt addr <address>\" command.\n"
>>>>                       "Aborting!\n");
>>>> --
>>>> 2.46.0
>>>>
>>>
>>> The use of `fdt` command in the default action might be depended on by
>>> some userspace script as a success/fail result. I don't imagine what
>>> that might possibly be, just that the logic of scripts in u-boot
>>> depend on that pattern of use.
>>
>> I'm not sure what the rule is about breaking changes in the CLI, I do
>> think this is not a realistic concern here though. Maybe Tom or Simon
>> can weigh in?
>>>
>>> Secondly there would need to be a warning to the user that some hidden
>>> conditional action is being applied? i.e. "No valid FDT address is
>>> configured to $fdt_addr_r or $fdt_addr so now configuring to use
>>> $fdtcontroladdr instead." or however you would phrase that.
>>
>> Since I call set_working_fdt_addr() it prints a message telling you that
>> the fdt address was set on the first call.
>>>
>>> Otherwise I agree improvement to the fdt is welcome and my memory of
>>> first using this command is that it has not-sensible defaults but I
>>> then assumed it was designed this way because of possible use in
>>> U-Boot scripts.
> 
> Definitely a useful feature, but how about adding a flag which sets
> the working fdt to the control one? That would make it less painful
> than using -c, and will keep existing cases running.

Surely we have to /have/ some usecases to justify this??
> 
> Also note that test/cmd/fdt.c and doc/usage/cmd/fdt.rst need an update for this.

For sure
> 
> Regards,
> Simon

-- 
// Caleb (they/them)
