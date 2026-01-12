Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98B6DC9EC8B
	for <u-boot@archiver.kernel.org>; Mon, 12 Jan 2026 13:09:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 779018391B;
	Mon, 12 Jan 2026 14:09:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=streamunlimited.com header.i=@streamunlimited.com header.b="gXs7XXaz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B679683CB9; Mon, 12 Jan 2026 09:39:08 +0100 (CET)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 702BA83C14
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 09:39:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=streamunlimited.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peter.suti@streamunlimited.com
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-42fb5810d39so3125178f8f.2
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 00:39:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=streamunlimited.com; s=google; t=1768207145; x=1768811945; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aGaOr0vQuS+oz/mLv1dbEORvswycSFN9TX0OX+KFO5Y=;
 b=gXs7XXazvk/e+uNAE/eTX7TVzcQnfebIOz7c15gNAUzzqb0RuC/ZBzvQpRze3WTQ5O
 lzd9up6DZ8gw85gI0o8xnvJXyuuYS0qZ12dHq+p7nLdLcZHX0+jtQ0Acyvht+duRe3E6
 Od+D+T92g5RbOTlZiISRdauL05mMEgyj1VdEM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768207145; x=1768811945;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aGaOr0vQuS+oz/mLv1dbEORvswycSFN9TX0OX+KFO5Y=;
 b=AXjhul+5UTGJTSWwcSczZw7L+Zft9hWidClezupKNAPZgoWSmfwUKEhj/saRIy+S2p
 uB9W10yRvwDwN+icuumIe2om+KJh2OZO/CvDPVk1KRvFQh0AdxStnQXg6qYMycq5gMEa
 K2dywJ5nwt9DeCHracjAq1X2wdrQsGKl/Za4kn2j2+6bNV7RfPnsRzZQm9sOcoWN2xiB
 69FcN74Qetnux+CYMkOoccev9tgrQ6jWRFR5S3Chr5jguNT7O2eG9fetru33ZEaRkx4l
 OgSbCitevz9qc1N30Zr7Xx6LGCZqwt7etaVkngmfbOliFBFSQMrjkj71PoET/scFRVAo
 nMeg==
X-Gm-Message-State: AOJu0YzhUM2cHkYR010jV6oN+W3vlAz6S0QEx6XBCw9fCiKfXGSiQsKe
 UbVcUejNgY5SusfAPTKM2bqO3nbiXWH492AAn3HLUujxYM013etyBIRI7bnpIM0rD80=
X-Gm-Gg: AY/fxX6scfz4JOTbh9YxYvM9n4RXJknnM8OBs6094mGoaJEAMtYx3bp6TvBckzd0mFD
 1sgVACEcdKnWMAYEbzBMNUmRee2moF6xzrrcfFEZuLlLH27EGjfe06gNn7uC75MtrcNMOCy/RRX
 PtIPfjLoP9dJLPRX3eu7+fY6JEOvUpwzhaohyLWHzdgJ3XMrXdvCAcVPNqTGbja3Pu2Dt3mUoUo
 DGIR33ZwHGtELoESfhDHCf6rVAQfPstQsMzyMm4IP+k2ewaLJhTklQ8VieV1+vh/LGDAdck/M64
 k7ax/DHrB0dtYSvmqX2glUB7Fl3H5rw8fJRucIj9bnMDiNy3lY03i0ReiJrDIZdBuP0uaV8qSRn
 9jsXZHMdNdohURVyZNCpDFBWwrR/HMN5mSpitd5N/iOLma8fiyMuf5CwC4hIe8CbnH0aXrj00LN
 7RTlvzcoFv2hZyA8y/ZdQXxKMDB+1W1mVSnd/a+iVWrGaTTt4=
X-Google-Smtp-Source: AGHT+IFcYYlvzT8KRy4+XNSxAKhYJROJBLtd7LJc/ajxhFBd5RLaMWePiBZfFJhlpJwEIyHkB6sD/w==
X-Received: by 2002:a05:6000:188e:b0:430:f2ee:b220 with SMTP id
 ffacd0b85a97d-432c3632beemr22331456f8f.19.1768207144831; 
 Mon, 12 Jan 2026 00:39:04 -0800 (PST)
Received: from [10.1.14.153] (vpn.streamunlimited.com. [91.114.0.140])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd0e16f4sm38261129f8f.11.2026.01.12.00.39.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Jan 2026 00:39:04 -0800 (PST)
Message-ID: <904e3bc9-815a-45d6-b05b-df297e2f4940@streamunlimited.com>
Date: Mon, 12 Jan 2026 09:39:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] cmd: mtd: fix default length calculation when offset
 is specified
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc: u-boot@lists.denx.de, =?UTF-8?Q?Radek_Dost=C3=A1l?=
 <radek.dostal@streamunlimited.com>, Tom Rini <trini@konsulko.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Andrew Goodbody <andrew.goodbody@linaro.org>
References: <cover.1765892031.git.peter.suti@streamunlimited.com>
 <d34e03afc6c5bba074bae1684ca1f74159735210.1765892031.git.peter.suti@streamunlimited.com>
 <CAOf5uwmZEeQv5uLGOsdFbaJacA-SJV+696VgF7354=-+y=CA0g@mail.gmail.com>
Content-Language: en-US
From: Peter Suti <peter.suti@streamunlimited.com>
In-Reply-To: <CAOf5uwmZEeQv5uLGOsdFbaJacA-SJV+696VgF7354=-+y=CA0g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 12 Jan 2026 14:09:41 +0100
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

Hi Michael,

On 12/20/25 09:42, Michael Nazzareno Trimarchi wrote:
> On Tue, Dec 16, 2025 at 2:41 PM Peter Suti
> <peter.suti@streamunlimited.com> wrote:
>> ---
>>   cmd/mtd.c | 10 +++++++++-
>>   1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/cmd/mtd.c b/cmd/mtd.c
>> index 1d1845bce44..9f6e3226c15 100644
>> --- a/cmd/mtd.c
>> +++ b/cmd/mtd.c
>> @@ -519,7 +519,15 @@ static int do_mtd_io(struct cmd_tbl *cmdtp, int flag, int argc,
>>                  goto out_put_mtd;
>>          }
>>
>> -       default_len = dump ? mtd->writesize : mtd->size;
>> +       if (dump) {
>> +               default_len = mtd->writesize;
>> +       } else {
>> +               if (start_off < mtd->size)
>> +                       default_len = mtd->size - start_off;
>> +               else
>> +                       default_len = 0;
> Should it fail if the requested offset is bigger than mtd->size
>
> Michael

I think that would make more sense, yes. I'll send V2 with that fix.

Best Regards, Peter

