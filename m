Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA060C88E50
	for <u-boot@archiver.kernel.org>; Fri, 11 Sep 2026 14:49:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4A3D340848;
	Fri, 11 Sep 2026 14:49:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Jgkll0PQOmaS; Fri, 11 Sep 2026 14:49:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 57F864083D
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789138154;
	b=GxTgjhYZCJYmdPF5+OWzkZN4tr8wPoBGStscg+yr6v4ohkQnSonSrOswnYCVApuS2WBP
	 F9un9iWTEF7Ze3m7G3vGEk6cuA1s4kY1NtXTJVSEJne2ZKDBU1CEGxR8oKxSTIim+zoh0
	 tZ1fOqY+hJueZKsMPEvwUefqqHNajkq6Hc5j6yS89kOgYnXi3lWf4NVgYhA1ZNi/Vinbf
	 R6jFLE1utFcqGL5VHq6yzDS43sGL8jJdxxsIESfETROO3P2PjHxgTOUXoSOA6wBbZFnaL
	 uejvAWK0ddn4sGSLk6QhCMZ+/iulTXHiQZ114FLC9FdEtrNe9RHlc4+RXruniB+AARA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789138154;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=TwE5V5UWQYKaPaYF83O8+GieNIWFObObGdRbvLMQOX0=;
	b=VdFx2MNvgMJtgrUcJm7U+H3Diz6i27mQ2GlrWkKBWo/P2KYIkbK6atSdDD+9JMl1VBYj
	 eFcsNDadWHFR1kQsgBT8yF326w/J/5gpPq2SO4/mksKLVU/stSGIOtsasscEt+g4WCh/I
	 707EZ+EKUSLUeuMPjnHlLe/LyelG9J+7JAhUNwDTjzzNtPKihq6+X6werqqKzRIXb0HFP
	 Xxzf93EuFmItVDdrojRGUeIEY7bbzNaUTAL+Z7Q7l8SyjUsqttP1bGPgrE/hz0M18T+3b
	 IiIoRbydySjuCRY2rvc8lDG1jaKBi7h74x+w3y8TG3XvJMT8o/7USMi++MqzN7ChzGQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789138154;
	bh=TwE5V5UWQYKaPaYF83O8+GieNIWFObObGdRbvLMQOX0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0hLU4cWhCUwGQXFNfWvcWKkFxw0Iy/7oLgaIyK46D8azqjKauGPKBDzWsWeumVoSb
	 e9LwrH2Ugv6CkZ6Afg+k9nvM7hTIJbcsp8GM3I9KXcJXlfup/lzswkQwwsXW+/oNMN
	 cnhZL8XQUwpDJc/3e6PMjtnxaDKvBzhFhKxH5W3DzFBR9jJDpAd3prSJ38riFSrW99
	 Fm0hFAdmxowAsf99XudFEeL71Zj3a2pwnAg+jY0ihAfula7nY6w4na1mcuAyBjYKz9
	 HfW0GaB1/4QFtX/DdtPbVYg3NeAJPhHMyV5ALiJH07EN345cWBGBBWkozwA0NTLpNU
	 XoQj8SjSAmwhw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 57F864083D;
	Fri, 11 Sep 2026 14:49:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4E37C32F
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 14:49:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3FD8E6066B
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 14:49:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UxXe6DuAzXCT for <u-boot@lists.u-boot-project.org>;
 Fri, 11 Sep 2026 14:49:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 39E8F60635
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789138151;
 b=Nihe8XOSOjRN/B62AdqsY4p4pagp+0FX+9dYGNfZ2sqVctYH3qyuJAOZ5hIk+TH4iCJr
 /UTOj8bD4aFCiPNS2dQCs19T7WsuiRr/5DOxH4HCbUgx3REqR9t9rDydpTybXqWGWEGFb
 /0LeCkYGFyaHGWXDO0lvlGw/0pyzbHNThjDwolqYW5t/ApAIczwBGP7vT5ImhrKI/Re9w
 DW+2oLcxgVKxJLnzlbTjXHiJZIQvS1k2iSZ4Guj71uJtMeUjP9yJodHua6+NNpEXKrxzA
 s1ZVkqtUQ67gdi5/o59/xxzCHJkWj4/gkXRFIRlaW3NaNGvd42oihiPaB1Yl9fRvvrA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789138151;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 In-Reply-To:References:Date:Message-ID:MIME-Version:Content-Type;
 bh=TwE5V5UWQYKaPaYF83O8+GieNIWFObObGdRbvLMQOX0=;
 b=qSRjsLVb3h/Q4gayiTr1081ECwNkLklqLRuAZTc/bLblEXBQDLiZiRdbrmlkTMPYFNBf
 ph1OIIbUCEsuCxn7xKtgGTPHlVwlmiYoy45V1WwKkiFmydNq1/uhDAptwVOcTV/0JYY6y
 OY22sNNkXwPAIBwkJbHJhksyB9oPAVlZdJTd8Xa0HRljczmiFWeXXQ0UdKz2ySMXlkqkx
 FW5O/RhMIWbytFYV3BkL4Ti+P4087XaYp1xOwpHHndFYs6QKc+fZNjbnkv0oy4/8ssI0r
 CqJOHXEEus2jE7noc+xK3wFf2SVeTuxqLTax8FHiHFequzzkLrrAl0heWYxV95OucEw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b="GPV1wMi/"; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=GPV1wMi/
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 39E8F60635
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 14:49:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DEBB360202;
 Fri, 11 Sep 2026 14:49:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2826C1F000FF;
 Fri, 11 Sep 2026 14:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789138148;
 bh=TwE5V5UWQYKaPaYF83O8+GieNIWFObObGdRbvLMQOX0=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=GPV1wMi/0TPOsWb2KhAULuDwRt/Q8P6rL34/w+tcuXf/w2vgZ7fteYsfRrD69aDrR
 SFV0g4pWL4WAdsrVabB+wW5ab4EcSj2cl72yJ2TCt2PIQLoPijF+wfgQ7kjjsiMj39
 q9BdS7FeIxrPZcJ5R59bj4aDthM4mkv7DzQWeMKpw8VD3pIY3UmUYUNKkV9wwQj7Gi
 ieuvifOPM9MLLdAwO9a2B0yDYMOCw2PxnJC91zwB2ylfIaRtk/NRo3H7RML4M0tGFZ
 yos9LVwSR8fihv50oOOQ3Ryn32juHTsi0GEx9uVnCVTx+WBmDWsoUghuARA8CPM1PG
 3eAvTU8eSBCjg==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Carlo Caione <ccaione@baylibre.com>
Cc: u-boot@lists.u-boot-project.org, GSS_MTK_Uboot_upstream
 <GSS_MTK_Uboot_upstream@mediatek.com>, Suhrid Subramaniam
 <Suhrid.Subramaniam@mediatek.com>, =?utf-8?B?TWFjcGF1bCBMaW4gKOael+aZug==?=
 =?utf-8?B?5paMKQ==?=
 <Macpaul.Lin@mediatek.com>, =?utf-8?B?UGFibG8gU3VuICjlravmr5Pnv5Qp?=
 <pablo.sun@mediatek.com>,
 Arnaud Ferraris <arnaud.ferraris@collabora.com>, Tom Rini
 <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, Sam Day
 <me@samcday.com>, Quentin Schulz <quentin.schulz@cherry.de>, David Lechner
 <dlechner@baylibre.com>, Vitor Sato Eschholz <vsatoes@baylibre.com>,
 Lukasz Majewski <lukma@denx.de>, Marek Vasut
 <marek.vasut+usb@mailbox.org>, Peng Fan <peng.fan@nxp.com>, Jaehoon Chung
 <jh80.chung@samsung.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Julien Masson <jmasson@baylibre.com>, Alexey Charkov <alchark@gmail.com>,
 Adrian Freihofer <adrian.freihofer@siemens.com>, Francois Berder
 <fberder@outlook.fr>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Vincent Jardin
 <vjardin@free.fr>, Peter Robinson <pbrobinson@gmail.com>
Subject: Re: [PATCH v5 1/5] fastboot: factor out the USB session runner
In-Reply-To: <aqQCQWUtmHiW-Ifs@macbook.homenet.telecomitalia.it>
References: <20260906-ccaione-upstream-spl-fastboot-v5-0-023516e77321@baylibre.com>
 <20260906-ccaione-upstream-spl-fastboot-v5-1-023516e77321@baylibre.com>
 <xhkdbfqzg3r14.fsf@mkorpers-koolstof.csb>
 <aqQCQWUtmHiW-Ifs@macbook.homenet.telecomitalia.it>
Date: Fri, 11 Sep 2026 16:49:06 +0200
Message-ID: <xhkdb5x0b4zdp.fsf@mkorpers-koolstof.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On Fri, Sep 11, 2026 at 15:33, Carlo Caione <ccaione@baylibre.com> wrote:

> On Fri, Sep 11, 2026 at 14:34:47 +0100, Mattijs Korpershoek wrote:
>> Hi Carlo,
>> 
>> Thank you for the patch.
>> 
>> compared with v3, v5 introduced some new changes which I don't
>> understand.
>> 
>> Please see below.
>
> Yeah, sorry about that. I received an off-list review so the changes are
> probably result of fixing those comments.

When possible, can we please try to avoid off-list reviews (or do them before
sending things out publicly) ?
It makes following along various versions for series harder (at least to
me)

>
> [...]
>> > --- /dev/null
>> > +++ b/drivers/fastboot/fb_usb.c
>> > @@ -0,0 +1,66 @@
>> > +// SPDX-License-Identifier: GPL-2.0-or-later
>> 
>> Why is this GPL-2.0-or-later? In v3 it was GPL-2.0+ which is what's
>> present in cmd/fastboot.c
>
> There was a suggestion to move to GPL-2.0-or-later because GPL-2.0+ is
> currently deprecated see https://spdx.org/licenses/GPL-2.0+.html

Ah, I was not aware that GPL-2.0+ was deprecated. Thanks for letting me know.

I see it's still widely used in the U-Boot sources:

$ git grep --count GPL-2.0+ | wc -l
14298

$ git grep --count GPL-2.0-or-later | wc -l
2315

I agree that we should migrate to GPL-2.0-or-later but that's not in
scope for this series, in my opinion.
Therefore, can we please keep the (deprecated) GPL-2.0+ instead since we
are literally copying it over from cmd/fastboot.c ?

Thanks
Mattijs

>
>> > +/*
>> > + * Copyright 2026 BayLibre SAS
>> 
>> This was also not present in v3 and does not seem an appropriate
>> addition to me since we are just copying code around. Why should it have
>> a new copyright?
>
> Totally fair point, I'll remove this.
>
> Thanks!
>
> --
> Carlo Caione
