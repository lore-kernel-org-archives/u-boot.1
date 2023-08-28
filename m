Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EC4CC83F12
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 21:49:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7BDD986482;
	Mon, 28 Aug 2023 23:49:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="sS+CGRn0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A03C8864A2; Mon, 28 Aug 2023 23:49:53 +0200 (CEST)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC57586481
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 23:49:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cfsworks@gmail.com
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-1c4c6717e61so2753316fac.1
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 14:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693259389; x=1693864189;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gj5V4WV97Q/HYBNljK+Ns946MAuYtgJhq5i8Q0fvJyY=;
 b=sS+CGRn0Rd+3RO2KX9BmBcI2AadqPyfSqa1VDned5lULV0Xsc5uG7+GMO8zOuIkWbZ
 1f1LbFbTP2ryj0HedN7bvJnkfaNlmMgn7x0OUmuIjQOP3Yp9RaE87DAK9jETcGXOCgvV
 4w6KxZy4Yl/S60QRgSRR3/HXA8DdZIYgSuXOttf5mHbhpOX0gxZ1TtpZreJi6HyonZka
 G4XmttSFCzDfp8sbIZSwaE+cQqfTYtwSwPVozTeLeGIjNEtdY+42G9qntI7xMgLrUTLN
 qJssELnmgrG2erkUmjCh6GNHNr9nOjTlDWqY2ZXTZV8VUyZ9dKgZxnN1nNLfRfZ8kpEr
 yd4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693259389; x=1693864189;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gj5V4WV97Q/HYBNljK+Ns946MAuYtgJhq5i8Q0fvJyY=;
 b=M1DBDDdEs3s1X0GIDvosbtVzlCPnahpOGs2mdCHVg8yO6z9N9bGdcsmQblU8Qy1XT4
 0vXDVVdwO7jsKsem9DUD/9O/cY+utvZcwzWmpXFCqVsEftnZo9IdcMgVps69Zkhchb4x
 bPXMXw5eSfgyE3nMDWJK4ByBuQsCwCj3nf3nRgJIqi5w1WSGGPUZpN+zDf2q2vclb4zB
 3kV2lEl7jv8kJDE8SI0rKYWVtLzNDDHXDCuHWnwTNZdoiuPrSXISeIF8rjbAwiXZgO9O
 QgtWR0Pn+6UTM098DZGn+ou4X9uRcvnTrxYn87tHhV74CEsFBRhKC0cWz8anT9kK3luV
 Tk1A==
X-Gm-Message-State: AOJu0YyWAOTnDAcI1OSFOtYm18uYQH1c7J7s5/eLCKTB00BXgC50I6nD
 MRmBfJliZc1YcJlZUfCHLI0=
X-Google-Smtp-Source: AGHT+IGjq9BNyYZKEaUSvWEUEykKUQzb/CES4wNtzvl99EqAKp1ESvEF9wA6iASuQp+I66mhFaqNbQ==
X-Received: by 2002:a05:6870:a44b:b0:1c0:d0e8:8ff9 with SMTP id
 n11-20020a056870a44b00b001c0d0e88ff9mr13992619oal.16.1693259389291; 
 Mon, 28 Aug 2023 14:49:49 -0700 (PDT)
Received: from ?IPV6:2001:470:42c4:101:e1d9:bca8:255c:b1c6?
 ([2001:470:42c4:101:e1d9:bca8:255c:b1c6])
 by smtp.gmail.com with ESMTPSA id
 o21-20020a056870e81500b001c03d1a519fsm4787227oan.39.2023.08.28.14.49.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Aug 2023 14:49:48 -0700 (PDT)
Message-ID: <297192f6-3635-e75c-98c6-43a04631ce2d@gmail.com>
Date: Mon, 28 Aug 2023 15:49:43 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] sunxi: psci: remove redundant initialization from
 psci_arch_init
Content-Language: en-US
To: Marc Zyngier <maz@kernel.org>
Cc: wens@csie.org, Andre Przywara <andre.przywara@arm.com>,
 u-boot@lists.denx.de, Jagan Teki <jagan@amarulasolutions.com>
References: <20230531201520.15479-1-CFSworks@gmail.com>
 <20230814213854.408962d5@slackpad.lan>
 <CAGb2v645V85s49DRrKw8-TcR5e697D4nVp3QnPGDET46H49dZQ@mail.gmail.com>
 <69909b61-f57e-fc91-43a5-0f4bd23609c9@gmail.com>
 <86cyzaf6ie.wl-maz@kernel.org>
From: Sam Edwards <cfsworks@gmail.com>
In-Reply-To: <86cyzaf6ie.wl-maz@kernel.org>
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

On 8/26/23 04:22, Marc Zyngier wrote:

Hi Marc!

> The GIC definitely has the NS bit routed to it. Otherwise, the secure
> configuration would just be an utter joke. Just try it.

Thank you for your response. I'd like to revisit my prior point about 
the distinction between the NS bit and AxPROT[1] bits in the context of 
monitor mode: in monitor mode, the NS bit does not determine the 
security state of the CPU core (monitor mode is always secure). But even 
then, the NS bit is still significant for other purposes, such as to 
bank accesses to certain CP15 registers -- and if I understand Chen-Yu 
correctly, some GIC registers also. That would require a special NS bit 
signal routed to the GIC so that it can distinguish between "secure, 
NS=0" and "secure, NS=1" accesses, which is why I asked if such a thing 
exists.

I understand that the GIC is designed to be aware of the security state 
(using the existing AxPROT[1] signals) so that it can protect the 
sensitive registers. And unless I misunderstand, this seems to be the 
point that you made here (my interpretation -- correct me if I'm wrong 
-- is that you are using "NS bit" as a metonym for "security state"). 
However I must clarify that my question was to seek further information 
from Chen-Yu about the possibility that NS is significant when accessing 
the GIC, even in monitor mode. Alternatively, his point might be merely 
highlighting that the GIC permits different types of access depending on 
the CPU's security state, which aligns with the viewpoint you've reiterated.

I apologize if my previous message didn't convey this context clearly 
enough. My goal was to unravel this nuanced aspect of the NS bit when in 
monitor mode, and to determine if NS needs to be getting set/cleared 
during GIC setup to maneuver around the banking, or if the value of the 
NS bit when in psci_arch_init() is truly of no consequence due to 
monitor mode.

> Well, history is unfortunately against you on that front. Running on
> the secure side definitely was a requirement when this code was
> initially written, as the AW BSP *required* to run on the secure side.
> 
> If that requirement is no more, great. But I don't think you can
> decide that unilaterally.

I have no idea when/if this requirement was changed. It might have never 
happened "formally": perhaps at some point, the SCR.NS=1 code got added 
after the call to psci_arch_init(), breaking (that version of) the AW 
BSP, and nobody ever complained or changed it back... so it stayed.

But we're starting to digress from what _this_ patch does. The intent 
here is only to remove two lines of code that (we're discussing to 
confirm) have no effect. I'm not touching the code that *actually* 
determines the world into which monitor mode exits.

Cheers,
Sam
