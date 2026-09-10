Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 397D2C79F9F
	for <u-boot@archiver.kernel.org>; Thu, 10 Sep 2026 17:03:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BA42E4043C;
	Thu, 10 Sep 2026 17:03:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GZhrSi7pevm8; Thu, 10 Sep 2026 17:03:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org D930A402D6
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789059804;
	b=ZvayL+f4a/MsfDs+gpyLbGr53MMELb8W7nAgS1tePWxZxNz3K6AixQImmMNByYcX/x8n
	 q4OCgZXK0vQ6YSyBR+BVOu57VGrjTggMplcM/Tr4n+7m+9xpyLlvCG18/RAZAJ5n1Fn8Z
	 hAeozYjrc0GqNh6sbYy+UB5kRRBgNS8HB9LWFM7wrPPxiTyb7fE9QxxVR6llIKR0knrpB
	 afkMGjtOrAQ7nuoJUZ5BdpRzRlsaYqOCsMrAZDcM6QWCPpetX2Pz3SPJYFxcEqC3waKFG
	 O/8EtobYe4gBG+tL0nVbNUMJFX0+Jrr9Y7lS+FF4rc6B4UVO46GGaP8OSgzbIoCP+3w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789059804;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=RH5gOBq+ihvIVvWDFJfrfK48eJC1HPJTGIlYAKE2xTY=;
	b=FiU2DG4jWrNn5YmCVORfRFK0A8MKrXo1s8Xok0asQOhoy3Lr0QztkOCd6h1ukdrHHiSJ
	 E/lBePVW6soJWrP2mr215L3UyhknDK2lzWDsOqaBSQ1YF7bwVKs+QR9KA2w7D9ge67wGl
	 MEHILr6UG9k7+G+qpXWLx5uTg1qvVZyvk1OpuupBxApKsX5c745V761qr7R1zxO1rcFZV
	 avB5zLwDsbdBr8O0Hhp4b6XcRwT15XS9Q3uYP8Kna+JrSvrdA30r9/BTDo33pd7miKhzq
	 gO5PWx8Bfds51WjQwXxnqxVxJGwlIVfMalXIBfrBwkFOx36qZG1KOmqPrPmvHFmG+bg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789059804;
	bh=RH5gOBq+ihvIVvWDFJfrfK48eJC1HPJTGIlYAKE2xTY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=M6OkgswajM0HKDvLiaZmkX2LtBwMUu5P4D7fuTX4LSBXoQp8FBOHAXOtsJiuXpV9h
	 FdHGeqU469VEIF2Mkm3hZO79ZpAe35kCN/1ad1Zz2HEpmop+Hob3KCizu20/npA/Pc
	 88OmCuRpn4hb5iWrbv3lWWdm16hI+/bBMurwMR01qyPXgiDDfkKQLkRc2AJp1eUTxM
	 jWGCUZbEUHyN3qHyZtbcauzDuOafAoCCOJGXCe3GLKrLqIasA6B1mKOJBU2AyyXHf+
	 LefXjIGz0dkXPaGfZJRxuRyGlwImxOHvr2StwsljnVY6KPUnFtDyg09057CRssfhaJ
	 CyfoJ8ej3DcHA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D930A402D6;
	Thu, 10 Sep 2026 17:03:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 64FA049D
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 15:06:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 62326810C4
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 15:06:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id D-hHjDGZgz5N for <u-boot@lists.u-boot-project.org>;
 Thu, 10 Sep 2026 15:06:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 52713810BF
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::635"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789052794;
 b=UOP91eql2ijQoQul5Axj5SVtr8HDTMLPPTYwK5T1jbG2VykhEg6Ty7eWNZn0ERg4GfaD
 mgVK2N75lOPJrNi/XE8bTVdNoOUnm5NDCbPAbgUr6uKu4hPc7ZpozTtirobo/osQCqFEE
 Sy5SA4ILqpPLmDfQFjEu3J4/+HfK31D01NXH2zz4SrcoSqkDOVJjPsX/I0265kYj9ARza
 AyjPKY40PPvBdbMhPG5BbXC9eZEhYgDeIu292sQ6oyzSN+45jFmSZir5yQPjxA0+wVyo1
 01IDwV0iS4COpiLpfRE1Jb0SGIFZgYkcGtNyoIhLRW9y6Bc/oxP03+R6rxhZB/ig0Og==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789052794;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=RH5gOBq+ihvIVvWDFJfrfK48eJC1HPJTGIlYAKE2xTY=;
 b=ap4ZQBHsXmQ8f3KxLPJHJltrIhTu0v3xz6sCwLYloDMp6iSkBnZDvw9usIWAg5Wnypu7
 ip+ykO4aOqEu21Ynn2fMmmgXssAC6sqto4ofH0lT4CrEh/Bf/5gK+ht5hQjKDGMffyTS8
 3XJKmx+MEo0MkH1AIh8pgIAM7xXb0DcMc0WQfbia7EU5GRbdryIMy5aKI+FYFqXRxmdr9
 4mOzQb6YVkqDHGYJ6wyt1MwIL7+fm+hWSLCEpFmxSB/z2+9U3M4qmtVaeog2Og3diZlHC
 mSqOuBm/CxALC5MqCjrp9YEuOxGj+yHX2Ulu5mi2OtAkQ+yatFUPKvqw12yRvz7m0Hw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=d+T+jZlU; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::635"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::635; helo=mail-ej1-x635.google.com;
 envelope-from=andrey.lalaev@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=d+T+jZlU
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 52713810BF
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 15:06:32 +0000 (UTC)
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-c2946dc8dbfso166569666b.0
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 08:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789052791; x=1789657591;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=RH5gOBq+ihvIVvWDFJfrfK48eJC1HPJTGIlYAKE2xTY=;
 b=d+T+jZlUxssTr4S7kUM+qebXc5gTkpwHMRSFKGcvyUTi2xDuIH/1gCmo0x+xCeJQta
 RSGl0NvlO28evfHg3Fcme91bNHK24vJEv4r50qi9FWGACk7bsjWYDn5CB9evc9RPo63z
 8r0EDJvhdtFsj1WCfoxMw+BVEkBCrXgLvQdyEKKfNaXLCd8li1xJvIEt9UkUulbHfwjI
 XhLPh9VnuIjfWAHWosM1Lm+wWQh9hoNWU46nV4w67yY18KS00saWs34FgiVwSVbhV7A0
 8hBAhXxIg3fuH/OuoGOGPi4TJTzxpmqvFr89kIbB1wEIWxR3tHsVSLV2s02c9pw4cIqG
 WaEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789052791; x=1789657591;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RH5gOBq+ihvIVvWDFJfrfK48eJC1HPJTGIlYAKE2xTY=;
 b=W7mjj4PvfXOC66GVgmUDOsdXudvZdbQzzmSlMVwJGveXzFYI7+EiVaZwRBVjOiDp0r
 UJrSWvSgVg7Sc9hDe5dCfYGm/7+ONXR7SSJdkcRm/64rHj5FJQ/OtNhKk1BRfCkoHjks
 CoqR1u6rAJea9CX+m4QSxd2Frr7k7pwlH0TGEVSy5+tNl9Fa5WC/dDJ7Ou/gAJhh98MZ
 L2ckIkqVSUvxNJnEo9QD2ajOAY7XGLgVjae58xooqvzroVBPdaCBONJUurVS7Rc+yCF7
 eLlXPg+GyjtYJBG+6cmxYkyhcKCSma7e7IE40he8PuGnmKf0l+xLLgAovc9yijxvxwFN
 PBeQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzr0VEfJFgm13nvX4u1rXaO9AYx3KlKx0oPtvCnvhVXhN9WrotIer9oLAo3DcaWecBtAVJdTaA=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++n08gxN8PYGO+hG4tm+6L2MM9VM90OaUupv1zFpDNabxk8KWVi1
 e1GSQs4EFSrebXnqa5f0SZVMsXa1/ou7Y+IUGTj6NFp3SxhS0KHTNEn/
X-Gm-Gg: AYBFou0cGF8FvlNamU2Y2J1wtKcGyZLNAo7RRkEzGUA15xxK8mWxQab+kJ/eEoQUY5H
 UrCob4yjrfH/9oQn1Ub4o01kKPzMFgIbL/yjvM0+tEyaTBVkYj51MZPW+3g5jcsrhyYaQr5At6Y
 cJeWUTTu8HRrT6JB5411a7B1PxH8DBioT0Z0YxA4C0B27mcaEOq8pCJjJhpkbvw1+P227wAKBiT
 Rw7G4od1Hyp1SYCL2ISPi6DEgN7El61doKpLPYRZgHIbkP+btQMY4l7dtM4WTfVhjtAvEIU22rn
 BN0oqv0I6DLS6KGQwhGRB4WxhcM2t41bNmU/l8QGGpsDA4tQgAcu9otiBxOn1yrkqzCDcmLtonz
 Ic6VG1iZXMHMSXUpfMSQnvWE7RnspkjNeMRtt4OuwCho/WWgDQiNlHcShAp3DNMrsR1GDvTfGtd
 2wcZmol66ypaJtZGh+FJEtBPtvwfB/63tAP+EdluaeRD8jdBFabHakkvv3/dPGum8MVzVsMoFQd
 D4t/brfZFuoteP1BvD7DHxxmn3WE2U68YVmmGbvz7L9A7lxC6gIVv1Dqa+8/3I33wu26uFZ4hIJ
 qeW4nq1caJ5zPFBhmpOMt5Oor1+EnzflFg6RjgXXRpRGznAZth5NuQUi6eCiY/rn4mTGDQ/B8RI
 Dw0E=
X-Received: by 2002:a17:907:9445:b0:c29:5340:1837 with SMTP id
 a640c23a62f3a-c29534022c9mr138059766b.16.1789052790488; 
 Thu, 10 Sep 2026 08:06:30 -0700 (PDT)
Received: from ?IPV6:2a02:8388:e6ca:5780:d844:e1bb:e288:3473?
 (2a02-8388-e6ca-5780-d844-e1bb-e288-3473.cable.dynamic.v6.surfer.at.
 [2a02:8388:e6ca:5780:d844:e1bb:e288:3473])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c260d4a98efsm950250766b.14.2026.09.10.08.06.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Sep 2026 08:06:29 -0700 (PDT)
Message-ID: <18136f4d-ed86-4990-8f9c-8d508652f26a@gmail.com>
Date: Thu, 10 Sep 2026 17:06:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mmc: cv1800b_sdhci: configure SDHCI PHY
To: Hiago De Franco <hfranco@baylibre.com>
Cc: Leo Yu-Chi Liang <ycliang@andestech.com>,
 Kongyang Liu <seashell11234455@gmail.com>, u-boot@lists.u-boot-project.org,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>, Yao Zi <me@ziyao.cc>
References: <20260909-milkv-duo-sdhci-configure-v2-1-be146dd85187@gmail.com>
 <aqG8pz6wExm1Yjma@hiagonb>
Content-Language: en-GB
From: Andrei Lalaev <andrey.lalaev@gmail.com>
In-Reply-To: <aqG8pz6wExm1Yjma@hiagonb>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Thu, 10 Sep 2026 17:03:23 +0000
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

Hi Hiago,

On 09.09.26 22:18, Hiago De Franco wrote:
> Hi Andrei,
> 
> On Wed, Sep 09, 2026 at 05:21:12PM +0200, Andrei Lalaev wrote:
>> Some samples of the Milk-V Duo and Duo 256M have issues with SD card
>> communication. As a result, the SD card is not detected, or the correct
>> mode is not selected.
>>
>> Configure SDHCI PHY in the same way as in downstream, to ensure
>> that the PHY is initialized properly.
> 
> Thanks for the v2 patch.
> 
> I tested this locally with my Milk-V Duo 256MB, same tests as before, and
> it works without issues. So:
> 
> Tested-by: Hiago De Franco <hfranco@baylibre.com> # Milk-V Duo 256M

Thank you for the tag :)

> My only minor comment would be related to the 'CV18XX_*' defines, the
> others do not see to have this prefix, so I would drop them and keep it
> like 'SDHCI_MSHC_CTRL'.

To be honest, I would rename the other defines as they are not generic SDHCI,
but CV1800B-specific, so I think it makes sense to prepend CV18XX.
No strong opinion, though.

> However, as usual, I also asked and AI agent (Claude Sonnet 5 - high, in
> this case) to review this patch and looks like it found something
> useful:
> 
> ```
> This always sets PHY_TX_BPS and writes TX_SRC_INVERT | RX_SRC_INVERT,
> and it only runs once, from probe(). Sophgo's own driver treats this
> as mode-dependent, not a fixed value - cvi_general_reset() in their
> tree branches on the live SDHCI_HOST_CONTROL2 UHS bits:
> 
>     if SDR104:
>         PHY_CONFIG    &= ~BIT(0)                 /* TX_BPS off */
>         PHY_TX_RX_DLY  = 0x00000100              /* TX_SRC_INVERT only, tap=0 */
>     else:
>         PHY_CONFIG    |= BIT(0)                  /* TX_BPS on */
>         PHY_TX_RX_DLY  = 0x01000100              /* TX_SRC_INVERT | RX_SRC_INVERT */
> 
> and it does this on every reset, not once. With this patch, a board
> that actually negotiates SDR104 (LicheeRV Nano, or any cv1800b board
> without no-1-8-v in the DT) would go into the tuning sweep with
> TX_BPS stuck on - cv1800b_execute_tuning() never touches offset 0x24c.
> 
> I don't think this affects Duo or Duo 256M today - both set no-1-8-v,
> so they stay in HS and only ever want the else-branch values, which is
> exactly what's tested above. But since cv1800b_sdhci.c is shared with
> LicheeRV Nano, it seemed worth flagging rather than silently baking in
> a value that's only correct for one mode."
> ```
> 
> I can't test this since I do not have other boards apart from Milk-V duo
> with me, maybe you can take a look at this review to check if it is
> valid or not?

I don't have a LicheeRC Nano either, but both DTSes have 'no-1-8-v' property:
  - arch/riscv/dts/sg2002-licheerv-nano-b.dts +38
  - dts/upstream/src/riscv/sophgo/sg2002-licheerv-nano-b.dts +85

So it shouldn't break the board.

That said, since I'd prefer not to introduce changes I can't test
myself (like SDR104 mode), we can do something like this instead:

```
diff --git a/drivers/mmc/cv1800b_sdhci.c b/drivers/mmc/cv1800b_sdhci.c
index b756649f90f3..2512352383b2 100644
--- a/drivers/mmc/cv1800b_sdhci.c
+++ b/drivers/mmc/cv1800b_sdhci.c
@@ -8,11 +8,17 @@
 #include <sdhci.h>
 #include <linux/delay.h>
 
+#define SDHCI_MSHC_CTRL      0x200
+#define SDHCI_PHY_CONFIG     0x24c
 #define SDHCI_PHY_TX_RX_DLY  0x240
 #define MMC_MAX_CLOCK        375000000
 #define TUNE_MAX_PHCODE      128
 
 #define PHY_TX_SRC_INVERT  BIT(8)
+#define PHY_RX_SRC_INVERT  BIT(24)
+
+#define PHY_LATANCY_1T BIT(1)
+#define PHY_TX_BPS BIT(0)
 
 struct cv1800b_sdhci_plat {
 	struct mmc_config cfg;
@@ -64,10 +70,34 @@ static int cv1800b_execute_tuning(struct mmc *mmc, u8 opcode)
 }
 #endif
 
+static int cv1800b_set_ios_post(struct sdhci_host *host)
+{
+	struct mmc *mmc = host->mmc;
+	u32 val;
+
+	if (mmc->selected_mode != MMC_LEGACY && mmc->selected_mode != MMC_HS &&
+	    mmc->selected_mode != SD_HS)
+		return 0;
+
+	val = sdhci_readl(host, SDHCI_MSHC_CTRL);
+	val |= PHY_LATANCY_1T;
+	sdhci_writel(host, val, SDHCI_MSHC_CTRL);
+
+	val = sdhci_readl(host, SDHCI_PHY_CONFIG);
+	val |= PHY_TX_BPS;
+	sdhci_writel(host, val, SDHCI_PHY_CONFIG);
+
+	val = PHY_TX_SRC_INVERT | PHY_RX_SRC_INVERT;
+	sdhci_writel(host, val, SDHCI_PHY_TX_RX_DLY);
+
+	return 0;
+}
+
 const struct sdhci_ops cv1800b_sdhci_sd_ops = {
 #if CONFIG_IS_ENABLED(MMC_SUPPORTS_TUNING)
 	.platform_execute_tuning = cv1800b_execute_tuning,
 #endif
+	.set_ios_post = cv1800b_set_ios_post,
 };
 
 static int cv1800b_sdhci_bind(struct udevice *dev)
```


> According to the agent, a possible fix would be:
> ...
> 
> Regards,


-- 
Best regards,
Andrei Lalaev
