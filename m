Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE90DC3DA49
	for <u-boot@archiver.kernel.org>; Tue, 16 Jul 2024 08:36:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3BBD988971;
	Tue, 16 Jul 2024 10:36:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="V1N67FMq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F020288365; Tue, 16 Jul 2024 10:36:06 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6382588971
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 10:36:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a77d876273dso317747566b.0
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 01:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721118963; x=1721723763; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JLlxhsUT/cFWUbn7H0vLlGehajgcdkxTkpGXVNUIdcg=;
 b=V1N67FMqerKHH/ce+p+Kqq7mgzKL0SqGBzieA0sgX5Wg/p0WOjCWi5bF8//ukpD3gP
 IfWHBVcBncE8JPfOz13RGOYgF1DI/DoVwBdsNGBntu5dS+qd5k0k31i0VH40Ca4qDNmp
 1XxmoECPY+vO1rG5G308jyqCENFWlQI2jv4Je5G1Y1EymmkfKdwXDFp+Z0+8pDXSp7rM
 RIkq6p0ESKK938MGxgP2XJhim2usMW7+vMuQli9FwPfzaBMHaYJYWqqZP3we0rL+xvzZ
 5XM5R/q5C7VpfE25Mav7TvNKN1AXcW95bKAagAC+MRkeB5i/8ct+iTqipdKUF/o9x3nJ
 KT6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721118963; x=1721723763;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JLlxhsUT/cFWUbn7H0vLlGehajgcdkxTkpGXVNUIdcg=;
 b=FfuQYwb2G0WesYw4cWc+rfs418G/8s0r9mwwvT05Ut8MuQpd9llblGwpPaRM1a2oFi
 6UYVNBcbLuTYB0tcyywJjgXjkSgDubUo6uHMHUweFSpiTH16q+sDCVvMmQmgDOwxqeYs
 kWLn/rNpo5i4T9KPdrmdFk11pfZ1X37DOZwKgazV7BFYA9FD/5oGN0Zz3uxXrCwWHUgF
 OvfTWyEdFnlLL/jEcLGcpqN+sSszp1ZhgtY7ORIqubTUqEF9RPApMk4uXvE2E+3XcddW
 KT87UPLVeA4BiQhtXr5rRfrKu81Td5AKBrMJmUaK88QAhBFpejShNhqlUhQztS/pIFJm
 swIA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXkk1QPiEjiaST5A0uAid0vZZGeQOpK4WFD6ouCPWPVA3+eA62YRDVqrGZvWuks8T+1OjEDPvN5t3F+7sYj6/N+Kh93Fg==
X-Gm-Message-State: AOJu0YzO9sUPD7qerLRYM1oCDWCM4m0gSlVZ8fLi7NgpuNXUkurKBgHh
 gDI3kI01CmTqJH+bWGTFMPtDqzq3Met8XJz70RUm/Ur4AjzZrAAMBk/gPx+CbSdsve+UMlzrkjT
 PTJt304tMrfMQTij7+nk2MCcGxzLAAULcpA1wr8GJDFaWMXme
X-Google-Smtp-Source: AGHT+IE5BLV6AChfIzqbHR3m/yaRGKl4HuSnd8VKrH/Cb3/HMkS9yOT2NkcyakLkiuQUfyLZd1EbVYvOtM3IHI/RczI=
X-Received: by 2002:a50:d71b:0:b0:58b:f46f:ae45 with SMTP id
 4fb4d7f45d1cf-59eeec2ed32mr1049257a12.23.1721118962695; Tue, 16 Jul 2024
 01:36:02 -0700 (PDT)
MIME-Version: 1.0
References: <20240704073544.670249-1-sughosh.ganu@linaro.org>
 <20240704073544.670249-42-sughosh.ganu@linaro.org>
 <CAFLszTiXtfFh3K8Ft1nTzBizSitk_dyK7n0BsRccNNe6TimFoQ@mail.gmail.com>
 <CADg8p97fwAvebfrANXwWc7At78wU59XXymTFWCvuaFHMGj+9zg@mail.gmail.com>
 <CAFLszTiAHSgkGjV6PWOu2nisKc678rpxBvQKuOZeisqCmeAXSA@mail.gmail.com>
 <20240715190534.GA561963@bill-the-cat>
 <CADg8p972kWS9DY_xmNm2uBAz5-y_LtSy0dq2eRTf5dJMCranCw@mail.gmail.com>
 <CAFLszTiPfY2d7+NoCaKAMZsAC5yHL=qsm9WHgr0fRxiAiOj3KA@mail.gmail.com>
In-Reply-To: <CAFLszTiPfY2d7+NoCaKAMZsAC5yHL=qsm9WHgr0fRxiAiOj3KA@mail.gmail.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Tue, 16 Jul 2024 14:05:51 +0530
Message-ID: <CADg8p946uwj_2oufrHXm=0mYTzeNEtqf5ehdHuydD-KKX9dAxw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 41/48] efi_memory: add an event handler to update
 memory map
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Marek Vasut <marex@denx.de>, Mark Kettenis <mark.kettenis@xs4all.nl>, 
 Fabio Estevam <festevam@gmail.com>, Michal Simek <michal.simek@amd.com>
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

hi Simon,

On Tue, 16 Jul 2024 at 12:40, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Sughosh,
>
> On Tue, 16 Jul 2024 at 07:25, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> >
> > On Tue, 16 Jul 2024 at 00:35, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Mon, Jul 15, 2024 at 12:39:32PM +0100, Simon Glass wrote:
> > > > Hi Sughosh,
> > > >
> > > > On Mon, 15 Jul 2024 at 10:39, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > > > >
> > > > > hi Simon,
> > > > >
> > > > > On Sat, 13 Jul 2024 at 20:46, Simon Glass <sjg@chromium.org> wrote:
> > > > > >
> > > > > > Hi Sughosh,
> > > > > >
> > > > > > On Thu, 4 Jul 2024 at 08:38, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > > > > > >
> > > > > > > There are events that would be used to notify other interested modules
> > > > > > > of any changes in available and occupied memory. This would happen
> > > > > > > when a module allocates or reserves memory, or frees up memory. These
> > > > > > > changes in memory map should be notified to other interested modules
> > > > > > > so that the allocated memory does not get overwritten. Add an event
> > > > > > > handler in the EFI memory module to update the EFI memory map
> > > > > > > accordingly when such changes happen. As a consequence, any subsequent
> > > > > > > memory request would honour the updated memory map and only available
> > > > > > > memory would be allocated from.
> > > > > > >
> > > > > > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > > > > > ---
> > > > > > > Changes since V1:
> > > > > > > * Handle the addition of memory to the LMB memory map.
> > > > > > > * Pass the overlap_only_ram parameter to the efi_add_memory_map_pg()
> > > > > > >   based on the type of operation.
> > > > > > >
> > > > > > >  lib/efi_loader/Kconfig      |  1 +
> > > > > > >  lib/efi_loader/efi_memory.c | 34 ++++++++++++++++++++++++++++++++++
> > > > > > >  2 files changed, 35 insertions(+)
> > > > > > >
> > > > > >
> > > > > > This is getting complicated and I don't believe it is needed.
> > > > > >
> > > > > > EFI should not be allocating memory 'in free space' until it starts
> > > > > > up. For the very few (if any) cases where it does, it can do an lmb
> > > > > > allocation.
> > > > >
> > > > > EFI memory module is not allocating memory at all now. This patch is
> > > > > adding an event handler for updating the EFI memory map, whenever the
> > > > > LMB memory map changes. All the EFI allocations are now being routed
> > > > > through the LMB API's.
> > > >
> > > > OK
> > > >
> > > > >
> > > > > >
> > > > > > As to the lmb allocations themselves, EFI can simply call look through
> > > > > > the lmb list and call efi_add_memory_map_pg() for each entry, when it
> > > > > > is ready to boot. There is no need to do it earlier.
> > > > >
> > > > > So in this case, I believe that rather than adding code in multiple
> > > > > places where the EFI memory module would have to get the LMB map and
> > > > > then update it's own, I think it is easier to update the EFI memory
> > > > > map as and when the LMB map gets updated. Else, we have a scenario
> > > > > where the EFI memory map would have to be updated as part of the EFI
> > > > > memory map dump function, as well as before the EFI boot. Any new code
> > > > > that would be subsequently introduced that might have a similar
> > > > > requirement would then be needed to keep this point in mind(to get the
> > > > > memory map from LMB).
> > > >
> > > > That doesn't hold water in my eyes. I actually like the idea of the
> > > > EFI memory map being set up before booting. It should be done in a
> > > > single function called from one place, just before booting. Well, I
> > > > suppose it could be called from the memory-map-dump function too. But
> > > > it should be pretty simple...just add some pre-defined things and then
> > > > add the lmb records. You can even write a unit test for it.
> > > >
> > > > >
> > > > > This is not an OS file-system kind of an operation where performance
> > > > > is critical, nor is this event(LMB memory map update) going to happen
> > > > > very frequently. So I believe that it would be better to keep the EFI
> > > > > memory map updated along with the LMB one.
> > > >
> > > > I really don't like that idea at all. One table is enough for use by
> > > > U-Boot. The EFI one is needed for booting. Keeping them in sync as
> > > > U-Boot is running is not necessary, just invites bugs and makes the
> > > > whole thing harder to test.
> > >
> > > Doesn't that ignore the issue of EFI being re-entrant to us? Or no,
> > > because you're suggesting we only update the EFI map before entering the
> > > EFI loader, not strictly "booting the OS"? In which case, maybe that
> > > does end up being both cleaner and smaller? I'm not sure.
> >
> > And that is my concern here about having to update the EFI map at
> > multiple call points, instead of keeping it updated -- I feel this is
> > more prone to being buggy. And to add to this, there might be code
> > paths added subsequently which might need an updated EFI map where
> > this gets missed. The only downside to the current design is that it
> > might be slower since the EFI map gets updated on every change to the
> > LMB map. But I am not sure if the LMB map changes are going to be that
> > frequent.
>
> I think it is worth exploring doing the conversion from lmb to EFI
> once, in one place. We have this syncing problem, to some extent, with
> partitions, which automatically update an EFI table when they are
> bound. The design of EFI was somewhat confusing from the start, in
> that it created its own tables to avoid relying on driver model. We
> are still paying the cost of that design decision. If we are saying
> that lmb holds the allocations, then it should be in lmb. The EFI ones
> should just be a slave to that, in that it should be possible to throw
> away the EFI ones and regenerate them from lmb.

So if we talk specifically about maintaining the EFI memory map, what
this patch does is exactly on the lines that you are referring to --
the memory map is being maintained by lmb, and simply notified to the
EFI memory module. The EFI memory map, when it comes to ram memory, is
indeed being made dependent on lmb. I think the only question is, how
does EFI get this information from lmb. This patch is notifying the
EFI memory module as and when the change happens in the lmb memory
map. I think what you are suggesting is that this information should
be obtained on a need basis? And I have listed possible issues that
could crop up with that approach.

-sughosh

>
> Of course that isn't quite where we are today, but I bet it is close.
>
> Regards,
> Simon
