Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E028CCCA476
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 11:31:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CDD983FEC;
	Fri, 10 Oct 2025 13:31:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="f44FRWRY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1083183F91; Fri, 10 Oct 2025 13:31:27 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5D7C83FE6
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 13:31:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-63963066fb0so3904478a12.3
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 04:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1760095884; x=1760700684; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=94/jqGLzm7xZbaN/mP+bkKP5JsSk/r4u9qnWWhWqJ7c=;
 b=f44FRWRYSbmRzAqCK2lxvJmS0vZoychr0g0M9nAHqqYNmeA9yAucV+bO338P+eUsSa
 mOY9LOfO3fs3h1ZjNHdSN6aTamWMsqQrFZlqxQ3vNvFLYtpzNkI0TqAR8aOJI/FzI4Bm
 r4ixjRpdsk1e6q4kl9PcuHqJHUVccruOebPn0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760095884; x=1760700684;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=94/jqGLzm7xZbaN/mP+bkKP5JsSk/r4u9qnWWhWqJ7c=;
 b=QVS4KHrZWR07OouyWAgtKpf9QlZ3s8BJTT3NXNIwGhuINUaUCeqrWD9t0XKnYZNuu0
 BkZOsg6bUdgaqf+YmpkEXtcoOePEMYJ7QSvZ3qKQ/XAKrjbIcIjePNtP1ZVfaTx5Nf+y
 rREJwvwARqxSUrDMej7RwGOH7i5V6UkiD1I6MIs2q+pYguIbLDLK5ftpwT5Ai2gKVOWN
 cUE8AOg8xwTrDu+XEC1+BqX15iMwHdvJuta3DoEOku+JqsEurUiR9ziqTrZzN87HxaTn
 72TJi5Q2rfmoPIMt+GqHvOoLEFxYi+b+T3HvHkHXFPkHB5qgDixvFVE2VTsROLIYCskW
 DZuw==
X-Gm-Message-State: AOJu0YwhLeo/HWgxV73hNMeHihVGW6JBZGB+YyOqOSbsmf7bOuXFMXKK
 8UkT8BiW42WkQWR+v3efT34dIIbS/gV71WYU1aBwNQrK6/PzKLUvYklxvPfJ/+y208Gtn5/C/fq
 ufG6Uf4ybb1/gjbjtUaw9zWQbyVI6PM20KHbZO72F
X-Gm-Gg: ASbGnct05l1fIiF7f/ls4VCJPq1QBmiQQHimEsFxI97BgVR8/u2UILPmjaROp9JUJ0Z
 16fdty4RfbpKI07wa8Gj2dUmJQj/DuT5Z4ww8tXEm2Fy/I913OzMOb6caPFohzJ2sPFSmiJQLfa
 SwMESJ+bXAL+h8+aQZ/cYAnEcLxhi38Bgwk2bTJX7xqkpJi/DYn3DY8JP6jYZmvhwt2Bi3e0+0y
 v7pPH2xvpZZntDQzF+owg==
X-Google-Smtp-Source: AGHT+IFPSvp5gNrwuhf5z4O0SVtM5uA0pJlg9inKhoCDqfAu10HM24U+pwmPqAPlUAoe4haVsovq844ZU1+IrKlUJjY=
X-Received: by 2002:a05:6402:13d1:b0:634:ab80:d84b with SMTP id
 4fb4d7f45d1cf-639d5c5a3f8mr10266173a12.32.1760095884022; Fri, 10 Oct 2025
 04:31:24 -0700 (PDT)
MIME-Version: 1.0
References: <20251008-topic-interconnect-next-v2-0-c46e94dd328e@linaro.org>
 <20251008-topic-interconnect-next-v2-1-c46e94dd328e@linaro.org>
 <CAFLszTi3cNihLKOvJhrm1GLYdxQKvkv-66Fdr6m90+vvdUtMMg@mail.gmail.com>
 <d0e157af-c5e7-45ee-9f8f-6b9a523d5505@linaro.org>
 <CAFLszTgemVk0tSMpBiMfgnh4LGaVKnOpGWa0N8WwE2Spf+ZUWA@mail.gmail.com>
 <8324c7c6-dcfb-4fe8-a9d3-9ab19fdac36c@linaro.org>
 <CAFLszTi9omZ372BocVZ39nHbgofM5in=Nz4yvCXrHVEgoJPiQg@mail.gmail.com>
 <c6694467-8efb-404d-862d-4df62dd60db6@linaro.org>
 <bfd6fcbb-2c7b-4463-b0ba-ea0a01a09ecd@linaro.org>
In-Reply-To: <bfd6fcbb-2c7b-4463-b0ba-ea0a01a09ecd@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 10 Oct 2025 12:31:11 +0100
X-Gm-Features: AS18NWAE_9P6PNniZfd-f7_FiauAOtJM6s5nsTSVgyPUjsTiQ2b1Pqy8TpVIjEw
Message-ID: <CAFLszTjDt__zEwcy4jioy9vgY+Sv52Ryz0b95JtFTT76-BTT2Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] Introduce the Interconnect Subsystem
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Casey Connolly <casey.connolly@linaro.org>, Sumit Garg <sumit.garg@kernel.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, 
 Mario Six <mario.six@gdsys.cc>, u-boot-qcom@groups.io
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

Hi Neil,

On Thu, 9 Oct 2025 at 17:48, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>
> On 10/9/25 18:43, Neil Armstrong wrote:
> > On 10/9/25 14:28, Simon Glass wrote:
> >> Hi Neil,
> >>
> >> On Thu, 9 Oct 2025 at 05:54, Neil Armstrong <neil.armstrong@linaro.org> wrote:
> >>>
> >>> On 10/9/25 13:16, Simon Glass wrote:
> >>>> Hi Neil,
> >>>>
> >>>> On Thu, 9 Oct 2025 at 02:18, Neil Armstrong <neil.armstrong@linaro.org> wrote:
> >>>>>
> >>>>> Hi,
> >>>>>
> >>>>> On 10/9/25 02:25, Simon Glass wrote:
> >>>>>> Hi Neil,
> >>>>>>
> >>>>>> On Wed, 8 Oct 2025 at 09:31, Neil Armstrong <neil.armstrong@linaro.org> wrote:
> >>>>>>>
> >>>>>>> Let's introduce the Interconnect subsystem based on the Linux framework
> >>>>>>> which is used to vote for bandwidth across multiple SoC busses.
> >>>>>>>
> >>>>>>> Each bus endpoints are materialised as "nodes" which are linked together,
> >>>>>>> and the DT will specify a pair of nodes to enable and set a bandwidth
> >>>>>>> on the route between those endpoints.
> >>>>>>>
> >>>>>>> The hardware resources that provide those nodes and provides the way
> >>>>>>> to vote for the bandwidth are called "providers".
> >>>>>>>
> >>>>>>> The Interconnect uclass code is heavily based on the Linux one, with
> >>>>>>> some small differences:
> >>>>>>> - nodes are allocated as udevices instead of Linux idr_alloc()
> >>>>>>> - tag management is minimal, only normal xlate is supported
> >>>>>>> - dynamic IDs is not implemented
> >>>>>>> - getting nodes states at probe is not implemented
> >>>>>>> - providers are probed on demand while the nodes links are traversed
> >>>>>>> - nodes are populated on bind
> >>>>>>>
> >>>>>>> Fully tested with associated DM test suite.
> >>>>>>>
> >>>>>>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> >>>>>>> ---
> >>>>>>>     drivers/Kconfig                            |   2 +
> >>>>>>>     drivers/Makefile                           |   1 +
> >>>>>>>     drivers/interconnect/Kconfig               |  10 +
> >>>>>>>     drivers/interconnect/Makefile              |   6 +
> >>>>>>>     drivers/interconnect/interconnect-uclass.c | 548 +++++++++++++++++++++++++++++
> >>>>>>>     include/dm/uclass-id.h                     |   2 +
> >>>>>>>     include/interconnect-uclass.h              |  74 ++++
> >>>>>>>     include/interconnect.h                     |  81 +++++
> >>>>>>>     8 files changed, 724 insertions(+)
> >>>>>>
> >>>>>> 'interconnect' is such a long and vague word :-)
> >>>>>
> >>>>> I didn't chose the name => https://docs.kernel.org/driver-api/interconnect.html
> >>>>>
> >>>>> I don't see why we should take a different name in U-Boot.
> >>>>>
> >>>>> But I can definitely use "Generic System Interconnect" in the documentation
> >>>>> and commit messages if it's clearer.
> >>>>
> >>>> Yes, we should use the same name. Docs can help.
> >>>>
> >>>>>
> >>>>>>
> >>>>>> There seems to be a piece missing here. The uclass should have
> >>>>>> operations, so that it makes sense for different drivers to implement
> >>>>>> the methods. I see some there, but also a lot of direct calls from the
> >>>>>> test to sandbox. I see quite a few functions which lack a struct
> >>>>>> udevice * - I suspect I am missing something?
> >>>>>>
> >>>>>> We normally have a ..._get_ops() macro in the uclass header. Also we
> >>>>>> normally have stub functions which get the ops and call the function.
> >>>>>>
> >>>>>> I see code to remove children, but driver model does this
> >>>>>> automatically[1]. Same with bind(). If there is a bug in this, can you
> >>>>>> give a few details, or ideally a test case?
> >>>>>
> >>>>> All of this is present and well thought, I went into multiple designs:
> >>>>> - interconnect uclass provides ops -> interconnect_ops, icc_node doesn't
> >>>>>      provide any ops since they are just internal objects
> >>>>> - there's only a single direct call to the sandbox driver to get the
> >>>>>      setting resulting of the aggregate() & set() op calls, this is purely for
> >>>>>      validation of the calculations, the sandbox-interconnect-test only uses
> >>>>>      the public inteconnect.h API
> >>>>
> >>>> OK, I missed that.
> >>>>
> >>>>> - For the lack of udevice, it's because I did use the same interconnect API which
> >>>>>      return a "icc_path" private structure which contains a set of interconnect
> >>>>>      nodes which forms path across the different providers.
> >>>>
> >>>> We do a similar think with clk, although the function signature is
> >>>> different in U-Boot from Linux.
> >>>>
> >>>> I assume the caller would be a driver? If so, passing in a struct
> >>>> icc_path * might be more efficient than using malloc() each time.
> >>>
> >>> I'm not against that but the size of icc_path depends on it's size:
> >>>
> >>> +struct icc_path {
> >>> +       size_t num_nodes;
> >>> +       struct icc_req reqs[];
> >>> +};
> >>>
> >>> So we would still need to alloc the reqs anyway and expose the internals
> >>> with no benefits.
> >>
> >> Indeed. Sometimes in U-Boot we use fixed sizes to avoid realloc(), but
> >> I'm not sure if it makes sense here.
> >>
> >>>
> >>>>
> >>>>>
> >>>>>      Setting a bandwidth on a node is meaningless, same for interconnect providers,
> >>>>>      this is why we set a bandwidth on a set of nodes, which get aggregated with the
> >>>>>      other path votes from other devices.
> >>>>>
> >>>>>      The key here is the "nodes" which are subdevices of interconnect providers
> >>>>>      created at bind time, and gets referenced in icc_path objects.
> >>>>>
> >>>>>      I made sure we can't remove either interconnect devices or icc_node devices
> >>>>>      if they are still referenced in an active icc_path.
> >>>>
> >>>> OK
> >>>>
> >>>>>      This is the reason of the device_remove() & device_unbind() calls in the test
> >>>>>      to make sure we're not left with dangling pointers to non-existent icc_node
> >>>>>      and providers devices.
> >>>>
> >>>> The specific code is this:
> >>>>
> >>>> +       device_foreach_child(pos, dev) {
> >>>> +               debug("%s(pos=%s)\n", __func__, pos->name);
> >>>> +               ret = device_remove(pos, DM_REMOVE_NORMAL);
> >>>> +               if (ret)
> >>>> +                       return ret;
> >>>> +       }
> >>>>
> >>>> This is in the pre_remove() method. But if you just remove that code,
> >>>> doesn't driver model remove the children anyway?
> >>>
> >>> No it only removes the children from the same driver:
> >>> =============><=====================
> >>> int device_chld_remove(struct udevice *dev, struct driver *drv,
> >>>                         uint flags)
> >>> {
> >>>
> >>> <snip>
> >>>
> >>>          device_foreach_child_safe(pos, n, dev) {
> >>>                  int ret;
> >>>
> >>>                  if (drv && (pos->driver != drv))
> >>>                          continue;
> >>> =============><=====================
> >>> Same for unbind.
> >>>
> >>> Added in https://lists.denx.de/pipermail/u-boot/2018-June/332597.html with the bind/unbind command.
> >>
> >> Ick, that is a bug.
> >>
> >>>
> >>> So perhaps I'm doing something unintended here, I was
> >>> also expecting removing/unbinding a device would remove all the
> >>> childs whatever the uclass.
> >>
> >> Yes, it should be fixed.
> >
> > I guess it should be fixed and a test case added.
> >
> > Should I handle this ?
>
> Wait the code is right, but still it doesn't work properly.
>
> I'll investigate further to understand.

OK...I'm not sure what that patch was about, but if the command needs
to work that way you could create a new function, e.g.
device_remove_by_drv() which only removes things for particular
drivers?

Regards,
Simon
