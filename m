Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D724D10F9940
	for <u-boot@archiver.kernel.org>; Wed,  8 Apr 2026 14:18:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E6A784105;
	Wed,  8 Apr 2026 16:18:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=kernel-space.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=kernel-space.org header.i=@kernel-space.org header.b="kjWrCaDt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C787E84105; Wed,  8 Apr 2026 16:18:38 +0200 (CEST)
Received: from mail.kernel-space.org (unknown
 [IPv6:2a03:4000:b:d08:14a9:1bff:fedc:75ad])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83A3B840AB
 for <u-boot@lists.denx.de>; Wed,  8 Apr 2026 16:18:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=kernel-space.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=angelo@kernel-space.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel-space.org;
 s=s1; t=1775657915;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xPNVzg1wYJaoSHgbjsUSfONU8f4lAQdOPKjljDO4l7g=;
 b=kjWrCaDt3EWxyR2n+lofRxcBow9LvOdv1IwGhV023f0YCq0yDzYGwy9oslZ+rEAR9TMZ1/
 8ywDdoL+vmRLHFqMY4EOUseJS1+X3ng8QT5GdSQg8rC4wG1OJc+XaV8xy0WcBjH+Nn4eZx
 W8RL9BbDEZ/HtaI8nQ8eCJG1vZsD6LI=
Received: from [IPV6:2a07:7e81:7daa:0:62cf:84ff:feee:627] (<unknown>
 [2a07:7e81:7daa:0:62cf:84ff:feee:627])
 by oreshnik (OpenSMTPD) with ESMTPSA id 2c7f5ba8
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Wed, 8 Apr 2026 14:18:35 +0000 (UTC)
Message-ID: <949eaa9b-f46b-40d7-a5be-c13450fe754e@kernel-space.org>
Date: Wed, 8 Apr 2026 16:18:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] m68k: Fix writew(), writel(), readw(), readl()
 endianness
To: Daniel Palmer <daniel@thingy.jp>
Cc: visitorckw@gmail.com, bmeng.cn@gmail.com, u-boot@lists.denx.de
References: <20260406142411.2992618-1-daniel@thingy.jp>
 <20260406142411.2992618-3-daniel@thingy.jp>
 <c300ac4f-f38a-4a0d-bed9-65588b3308d8@kernel-space.org>
 <CAFr9PXk-fJ_kbqd08LHtCdNfid=MVAr8yEj25o_yJghh7qRB=A@mail.gmail.com>
 <3c748627-9273-4ab2-9d13-56869dcf613b@kernel-space.org>
 <CAFr9PXmj2_0g6BkHLAeuNfo8M-CCnjtozfrB6unJ+QvQxYmy3A@mail.gmail.com>
Content-Language: en-US, it
From: Angelo Dureghello <angelo@kernel-space.org>
In-Reply-To: <CAFr9PXmj2_0g6BkHLAeuNfo8M-CCnjtozfrB6unJ+QvQxYmy3A@mail.gmail.com>
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

Hi Daniel,

On 4/8/26 15:40, Daniel Palmer wrote:
> Hi Angelo,
> 
> On Wed, 8 Apr 2026 at 22:26, Angelo Dureghello <angelo@kernel-space.org> wrote:
>> yes, thanks, please try to find a solution protecting coldfire for now.
> 
> So for now I have put #ifdefs in so coldfire retains its current behaviour.
> 
>> I will try to understand better why Linux operates differently from u-boot,
>> i think pci was involved here but actually i don't remember, need to
>> study this deeper.
> 
> I thought maybe this change in m68k might be recent but in Linux it
> seems to have been there since the import into git 22 years ago.
> 
> In the linux docs (https://docs.kernel.org/driver-api/device-io.html)
> it says this:
> 
> Note: On some architectures, the normal readl()/writel() functions
> traditionally assume that devices are the same endianness as the CPU,
> while using a hardware byte-reverse on the PCI bus when running a
> big-endian kernel. Drivers that use readl()/writel() this way are
> generally not portable, but tend to be limited to a particular SoC.
> 
> So I think maybe coldfire got a "reads native endian, no swap"
> readl()/writel() and then when PCI support was added a hack was
> needed. But somehow normal m68k got it the other way around. <shrug>

mmm, so from a fast look:

apart for M5235EVB_defconfig:CONFIG_CMD_PCI=y  
but this board has no PCI bus, so it should be some config copy/paste,  

there is no other board using pci for coldfire, maybe either no pci driver
working (NXP driver may work ?) or tested for them, so there was never
any need for swapping LE for pci. But just an assumption, i can be totally 
wrong since some nxp board has been removed and some coldfire have pci.

So this part 

#if !defined(__BIG_ENDIAN)
#define readw(addr)		(*(volatile u16 *) (addr))
#define readl(addr)		(*(volatile u32 *) (addr))
#define writew(b,addr)		((*(volatile u16 *) (addr)) = (b))
#define writel(b,addr)		((*(volatile u32 *) (addr)) = (b))
#else

is probably non functional from a pci driver since still "be" r/w. Should
be replaced with _le stuff. But should go deeper when i have some time.

> 
> Anyhow, sorry again for breaking your board.
> 

as i said, no problem. We tested it before, that's ok.


> Cheers,
> 
> Daniel

Regards,
-- Angelo

