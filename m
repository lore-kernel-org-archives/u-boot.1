Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2E4010BA425
	for <u-boot@archiver.kernel.org>; Sat, 28 Mar 2026 07:12:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3982083D17;
	Sat, 28 Mar 2026 08:12:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LJ+0/YHu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2669D83D71; Sat, 28 Mar 2026 08:12:26 +0100 (CET)
Received: from mail-yx1-xb12e.google.com (mail-yx1-xb12e.google.com
 [IPv6:2607:f8b0:4864:20::b12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F11F83C14
 for <u-boot@lists.denx.de>; Sat, 28 Mar 2026 08:12:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-6500040ef83so1025885d50.2
 for <u-boot@lists.denx.de>; Sat, 28 Mar 2026 00:12:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774681942; cv=none;
 d=google.com; s=arc-20240605;
 b=KI3XdwB8lKmYbRsmOw3I58UpUjrE81jmnQo7qEZwYe/d3quWF0RMRVkJd5zZKBMCDj
 LreAr5AwVpBXNTSWxTOxD+XeZidlka87h1cIfH4k7ys38nNejmTL/C/iDbsK3NCRZhxk
 q5yNVBo72nC5UhKn6R5sH9UFlxW8oR21HQiFLyQTvofh0YI/4mEBmfQaDnlfy7ZCNjRE
 NaUwSFtP1P0zctxYI4m5lFkirNfPJ44H/kLbQby6f03Nno1EevW0C2nMo08EaLuDrJqH
 kMj8lKJkGbT+HUa1PMQqCW4Am1ASi5becR0rpPiT/xXEh90YxDeBmYMM0BYG6ALFWbxf
 X4tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ZnYyIYPdM4kSG1xNy++eCDM2yUVvQWKaau9bRKSNblw=;
 fh=a6CtZosfjk3VNVaCJ3HvSWRqpwABV+7lvARsKon65Yk=;
 b=Rp2KtUc6B5JeCf0zq55LI4+Eg/Kj7rw9mnzAC10Mjf9zRgI6ZYbk4gqakj7XEK0ZQS
 SacJPptbF0xkznJwJZnohq4e0uEwWnbtXlxWaL4oosnt9t6hCMYSkhjzDHYpWHup3bqc
 7rmzUJ6qMLrJ4bx8goAejT4mVNAyV1FCK6ehd5u74e33pvqm70CV1uQ+BsHEgJPLYiY5
 98peK7RtSNJto93JH+mmaZhtVIv22BLRMV8vvXC9M5pHIWDCx0t94+aAWV8I4WlDiVp6
 6DtR74Tm/M7ax5KdaiAfFYXIAwSsbIdQXUenXo33PZsNWAztX0D3PDX4mwpFEBDI5mUs
 EmqA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774681942; x=1775286742; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZnYyIYPdM4kSG1xNy++eCDM2yUVvQWKaau9bRKSNblw=;
 b=LJ+0/YHuG8sY/QH3wFZ5p4grn6RyCb3TXVXxdXd39UXjq2OoP5hE09C4X865d2P/tL
 e8hJqq/ZFYCbbgrJNHOvW7hg+ICmi7g2bUUimKLKyvziA1yFf6h4HjZtqHVg1pEbiFFc
 gisKWg6/12xPHE33saFU5Z9Y3g71aHqv6qQNJwaK9r4NYDcvedGFFT2Z+4BgTHespJg9
 feBz6XTx8D2fdNG9pUZEaBv2dftQ9x5DsrcNllH9tJofEWHax662+KYzxeo4S7I5QbyO
 5X76RKr4RaXcuqkZGkV0M7VM1Clrb70rlt2xF0SR45Gxvt02+txEo5lkrr55M+KsuYgt
 h2Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774681942; x=1775286742;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZnYyIYPdM4kSG1xNy++eCDM2yUVvQWKaau9bRKSNblw=;
 b=UHmbwerXU4GX+Qa0CvwTzAyDnHyLP+vR8BgTQDmJQNHLBjfTVXqXSGWyMkL6JlVlcD
 wf6/y2De2ojJzcJ8KZIywcCM3MIxsXv1garWpDoMqjmPUbZpeAW/XIZSclRxkeu9/Gk8
 T0s3NZz+1gVAIydHXCFbyA72Ax/KRCI1U4DoEAOZP8HBPuZuTLYn+XXFKIPyU7B0zG6/
 Rrnr9G35JOa9rSipcmmkvX78ndPdUkIzcwr0ug8CRc7hnD2Mee/7fML1eT8jx6R8MLcq
 pmJRs2RBJKumLA4FgAahpXBE4BIAIp0zxg3cz9Jrh2iyeyRIidpvyp2N6fPmvCbEDjFv
 v4ng==
X-Forwarded-Encrypted: i=1;
 AJvYcCXcUPm3ayl2plUKhP0+xBfkrvPZZr+E6wcmqyyyuRaTeO3Rqohl4q3FVQM9Ej4QHzX5JaGnxtI=@lists.denx.de
X-Gm-Message-State: AOJu0YzNSpM1fo5G5TkH5ro4SYCr/KByj5TDe/myvZ/Xm+TBzQHUTLnH
 iJlpmNThjSezdY2zCciwZTnD44Uw56Yaj1G2TjsfNHUpIwoKxbPuYzOnYnMyU6o2Dcgh7oxEDQu
 4ZFVySZmvQjR8N7l3Ast7jnQKRFJoNEUieQKTIfUxMw==
X-Gm-Gg: ATEYQzy+GUmj+OFlbM8ycd/y552GhUoiWzXxObkr7WWaIhtZAmT6xbV9H3G/HCk2GWX
 lyn5Eaufbd8onVRhskjlh0WWGDGXKgjIsqgm+f/olhYjy0TTL5We8XGi1/95B9X64mCf48mLUf1
 +hgFuYKKXKNG/LEzLoJZjCEfaxWbNnoe17j3JwE+Z+W40ROGjVdQ2J517OG9ndg9KINgSVDGXCl
 Cq28XKDb84u0ghDLmT1dU7UGq2znmtChUJUTRPPWv5jdaN9Cel9kwrT0pK7KaEtbe4Ug8/+HvHy
 TEH16TX4xE6z+zfaP/qio16JddSg11pQwWjjIXPuliWhZcCxrFI/b0uukWWAN9H+07Qrq5k+6rL
 FV+kL5dlokNhv4IS99BZ1Ig0NTCD4Qp6GF2mZBL1KAq5zfZ1oqinLCwiw72upP/n5NErRxshInp
 FUPfeelv4kOCwiGaYcHTA0RhrsHLAUbYwjISmuKzInwZ2oMKB1Ap8mLxd5VkVT9DJk/3eF70PTO
 QrcPDzJsqRm25fRd+mkXiIEb5LuJwsZjFGbTgteDcZQVdN+RDRIQ3JzQC5fKn6l9m+MfPxKtJyG
 TCTBZMxCyuiVtna0Zbn7FyzbzoZnheo/clMl0BswaII=
X-Received: by 2002:a53:d017:0:b0:649:97d9:cf1f with SMTP id
 956f58d0204a3-64ff73ad134mr5052701d50.44.1774681942319; Sat, 28 Mar 2026
 00:12:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260326115111.1631261-1-ilias.apalodimas@linaro.org>
 <20260326115111.1631261-4-ilias.apalodimas@linaro.org>
 <6f6f1fc8-56c5-405b-915f-269d789b43e3@mailbox.org>
 <CAC_iWjK5-5Nn8+-OOQWuPSDwd6ckHyPY2Na-7eGO2tc_1XsLxg@mail.gmail.com>
 <edbe864b-2c76-4ac2-8a1e-69f527f1316e@mailbox.org>
In-Reply-To: <edbe864b-2c76-4ac2-8a1e-69f527f1316e@mailbox.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Sat, 28 Mar 2026 09:11:46 +0200
X-Gm-Features: AQROBzAfeOOq02XxBbNh22okBP7muwr1gCLReItuxNRYmzcieXUrz8lq4OkCyTo
Message-ID: <CAC_iWjKGzbbf1du3K9QuGYjkDrscAUKxMsOTcLvC1A4L7UTvxQ@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] common: Allow relocations on the top of the last
 bank
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: marek.vasut+renesas@mailbox.org, trini@konsulko.com, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

On Sat, 28 Mar 2026 at 08:44, Marek Vasut <marek.vasut@mailbox.org> wrote:
>
> On 3/27/26 1:23 PM, Ilias Apalodimas wrote:
>
> Hello Ilias,
>
> >>> Add a Kconfig option and allow the common code to relocate U-Boot
> >>> to the top of the last discovered bank.
> >>
> >> The commit message should really clarify the current pitfalls of
> >> enabling this symbol, including the part where ethernet transfers above
> >> 4 GiB used to work because of the packet buffer built into U-Boot, and
> >> they will break because the buffer is now relocated above 4 GiB too.
> >
> > Shall I just add your note from the RFC with a few adjustments? I.e
> >
> > NOTE: This currently might break platforms. If the ethernet
> >        controller cannot DMA above 4 GiB, and once U-Boot does
> >        get relocated above 4 GiB, the packet buffer which is built
> >        into the U-Boot binary is also relocated above 4 GiB.
>
> This patch should not be applied in the first place, this DOES break
> things. I think when this patch is safe to be applied, the note will not
> be needed.

The patch obviously will not get applied. I was referring to the note
in the commit message only.
I'll just add it with slight changes in the commit

>
> [...]
> >>> +++ b/common/board_f.c
> >>> @@ -321,6 +321,8 @@ __weak phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
> >>>                 */
> >>>                return 0;
> >>>    #endif
> >>> +     if (IS_ENABLED(CONFIG_RELOCATE_LAST_BANK))
> >>> +             fdtdec_setup_mem_ram_top();
> >> Return value may need checking ?
> >
> > sure, but should we panic ? Or print a message and silently keep the
> > old reloc address?
> Print a message and relocate below 4 GiB , for maximum compatibility maybe ?

Yea that's what I currently have on my local branch

Cheers
/Ilias
