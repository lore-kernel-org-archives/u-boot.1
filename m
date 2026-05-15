Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 675BDCD343F
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 22:06:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 88AE084713;
	Sat, 16 May 2026 00:06:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dc/JX5ZE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79E678487C; Sat, 16 May 2026 00:06:44 +0200 (CEST)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com
 [IPv6:2607:f8b0:4864:20::72d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E4E8F846DE
 for <u-boot@lists.denx.de>; Sat, 16 May 2026 00:06:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-91171bc5a7aso5735285a.3
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 15:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778882800; x=1779487600; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9Bu5aq514U/lyIhC4o5GwfHVFr3MHXRIc5JGPulDdZ4=;
 b=dc/JX5ZE7euKpcdSibKnXAvEt/k2ZKnK8kN2r3F3j2ls9imQcrhpgX9L6WxJcaKGIn
 b4B4PetdD0sWEub5X4INjFvTNaT+OyND9sAxmwyangzdD9HGX7NQc1j6eAayFQs+APSc
 Ds6/cXh3KeF8bev9YwEjmUO0+rynWpUgz961mfLfYO5nfGVWAhNQfCS8CvhbjGFBrmP+
 0gCZVcDtspP8GKHReipykapJLEHg1oPxEiWSbJw8G0etiu6kjIYhE+zMiajL3S5zYKub
 ubg6yoQlkZt/xeMxI3dX22dKlRWQh2r+BnVqu/BwEub9xKj23GaHNNKG4jHYbnJ3oq2B
 8PDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778882800; x=1779487600;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9Bu5aq514U/lyIhC4o5GwfHVFr3MHXRIc5JGPulDdZ4=;
 b=CJiImCg95KNy9gv2HFJqBeJuqi3YIyxCWbJC4gg0/uk86sQ+Bi1dTQBhruhHISFwoc
 z6aS/HFZPpXMEZvpmGE2WNxzEc2sPTiz5Go77/MGYWSqv4b3nM8t3f+6VoOQcjXs2viP
 ur4I+MgkGyo4Z95W6q89iYb/Q2t6sljMWRnlodFSbuGLMGGJoGCQlaHaQ77lC1iqtESf
 OX/iLG+i8CS9TDazr3vp6of/Q4lwUfFX0pRiJkFmILa54QRa+nh/xJmSTtjTZ+/RsWIN
 S21fMrHtPa6SF/busWAAafNlyb+/7vCAMMyivVF9KyaZLTQDt6BqX0zf7m1Kylx9d2ZZ
 n0uA==
X-Gm-Message-State: AOJu0Yx52DhCgDPK8J9rQ5A4d6bZNYWUDGNx7Xkx/F3VbesFm4gMJ4K1
 fB6VDaQHuslfulxsM3QxCVyJapwrXOVjVHCEebXPmRusF6n7g+K3qtYT
X-Gm-Gg: Acq92OEveFgcXdwhgFs3FQR8dFjL4iWUvhzJPV7BqRhM4QTtYqu+11j+dy4r1gilxj9
 RlnEx52f6FCYNSIt4r7ZGDPE4V7sehRkqLBiQ/V2ePN/xeO/gNlGcVePus1cUiewnqLrKDWu4mf
 empjzeAZnB2uthYFKHeJEcZ3RlIbmOtoR7gQ39m2Vt6rJl0xSfwMx30x51P2wfPBhO40WoPS5u9
 IUrePKUMSVcZU+w2ymDIHc4la/elqMjMPrIzuW4D1M89WjjngrKDeM9fuuOSmHnIoe6iHPbEyer
 5OfDqjB/ofyAwoBtTOw0fO3lApTgqSgaMXpHopZL76aiErbfo2i7Cz1yShRdcTRKILkzIpj+YDn
 q79hMRT+lXcgwdGPZ9MQtWO9K7sJXBe7zHnCP32rxKh/0V35MTDdBfnPZpC6iuSB5/G8roZemJl
 ZrFyMT0En/r8x/NfZEcU/MSmcZegfIU1fIEDiXz9pIJnPuhx+ZAKDqdoFppBLL13RvXIKk0ILGA
 RWIpQ==
X-Received: by 2002:a05:620a:268f:b0:912:54d8:1d95 with SMTP id
 af79cd13be357-91254d81fc7mr400073785a.3.1778882799800; 
 Fri, 15 May 2026 15:06:39 -0700 (PDT)
Received: from ?IPV6:2600:4040:4477:d400:2d8:61ff:fe7c:5d59?
 ([2600:4040:4477:d400:2d8:61ff:fe7c:5d59])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-910bae24879sm721264085a.18.2026.05.15.15.06.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 May 2026 15:06:39 -0700 (PDT)
Message-ID: <aa023095-2b32-070f-ff43-1f6922918b51@gmail.com>
Date: Fri, 15 May 2026 18:06:38 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC PATCH 00/11] Tidy command option parsing and use it a bit
Content-Language: en-US
From: Sean Anderson <seanga2@gmail.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>,
 =?UTF-8?Q?Beno=c3=aet_Th=c3=a9baudeau?= <benoit.thebaudeau@advansee.com>,
 Casey Connolly <casey.connolly@linaro.org>, Daniel Palmer
 <daniel@thingy.jp>, Heiko Schocher <hs@nabladev.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michal Simek <michal.simek@amd.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Yao Zi <me@ziyao.cc>
References: <20260515203311.2555651-1-sjg@chromium.org>
 <20260515214305.GL1858239@bill-the-cat>
 <15041974-8838-56b6-b9d5-250383ed2625@gmail.com>
In-Reply-To: <15041974-8838-56b6-b9d5-250383ed2625@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 5/15/26 17:59, Sean Anderson wrote:
> On 5/15/26 17:43, Tom Rini wrote:
>> On Fri, May 15, 2026 at 02:32:51PM -0600, Simon Glass wrote:
>>
>>> We have had getopt() for over five years but it is not much used. It is
>>> much easier to understand arg-parsing using getopt() and it avoids
>>> common errors. As the named maintainer I decided to look at how to make
>>> more use of it.
>>>
>>> So this series explores the impact of converting a few commands to use
>>> getopt() instead of ad-hoc parsing. It updates getopt() to handle flags
>>> anywhere in the cmdline and provides a few helpers to reduce
>>> boilerplate.
>>>
>>> The chosen commands are:
>>>
>>> - echo: very simple with no flags
>>> - hash: fairly simple with just one flag
>>> - env grep/export/import - fuller examples
>>>
>>> The series also adds a recommendation to use getopt() for new commands.
>>>
>>> To try to reduce the code-size increase, a lower-case function is added
>>> and called from a few places. The difference is fairly marginal.
>>>
>>> Overall, the result is not pretty (see below) with about a 1.1K size
>>> increase on arm64:
>>
>> I think that means this is a no-go, and you need to work out what might
>> lead to a much smaller growth here.
>>
> 
> Unfortunately, the only way to get a size reduction is to convert as many
> commands as possible.
> 
> --Sean

And to expand on this, you really only get a reduction for any given command
when there are several options being parsed already like in the nvedit stuff.
Since most U-Boot commands don't use options it will be difficult to get a
reduction even when converting most commands on a board.

That's why I used it for new commands where no one could complain that
I grew their board.

I think it would be nice for all u-boot commands to have proper option support
like in barebox, but it's a lot of effort.

--Sean
