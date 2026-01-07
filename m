Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AFEAD0D167
	for <u-boot@archiver.kernel.org>; Wed,  7 Jan 2026 19:03:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1F178405C;
	Wed,  7 Jan 2026 20:02:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Lcvv8wZR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 548008405C; Wed,  7 Jan 2026 20:02:54 +0100 (CET)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3EDA283A26
 for <u-boot@lists.denx.de>; Wed,  7 Jan 2026 20:02:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-b7277324204so384522866b.0
 for <u-boot@lists.denx.de>; Wed, 07 Jan 2026 11:02:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1767812572; x=1768417372; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wCG0xthFYOTPl0A2fbsiaxiaHzW/DW31ioMSy2g+DXk=;
 b=Lcvv8wZRpw5f5arSCVxWAloabOcPkmX6pKmL3avH5FNlbpVYgMXa/JZpoXunZRY3xG
 Ok7YOINF+0WmmUyrMowksLiJl7b4GWhcpiZEEHllOXaL5y+EZIcM/+IissqQYiPstB3E
 Gd+MRjAD3ESFrzn/u6uxNtiq2e16ZA5ZYiTzc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767812572; x=1768417372;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wCG0xthFYOTPl0A2fbsiaxiaHzW/DW31ioMSy2g+DXk=;
 b=WO3WryjOV/G0QgO2OEigqocxcv86Vqzoajx97hs1HU1U0Ji9lsG/0Ed74LmpDwtsWc
 od/VqZnQPBKD/T++k/SaFXd+gvPw0p7ep+3co85LCPo+6Plz5FxWEXHh7HN4QuDaZ1QP
 QxDpa8nPCl+7R4paGF/tW338s/912rXXamT/u9/ajCS0keA8dfGIdIMNnN5VH7rFOf8B
 9hRA4q9l4hbS1fVOHFGkgtSpgg+FtPJNzMBftYQ0oDiaP/iCXgQObuGd2aERMFTER0+A
 piwup76CaV2QPpWBrjYSvchVyxFr6D1qXrR7NKUDU08q8LssY/P/cjBvCNMeza6uRYx0
 1ZaQ==
X-Gm-Message-State: AOJu0Yw1rWEQU9wh028jTgnPydjg4YWiSU6MSA0nuLMBfGnAhGI9obXW
 K9CpFJnMcsZzBq9BCeevozScibrABhKEetbKcTU3lCrvynIIXt2LNG8pEK4+sRCetdb+KYIaHgz
 qdc2nF2N0gX09zM/12qe6h+Ku7AWVp2Xyr9PjP0RX
X-Gm-Gg: AY/fxX7lnyS3vFrynWcw1AlR3AAS3OxmRSsbwoF4QVs2GwEW/k1jTb7sXvtN5emqIAz
 8WIQ44Zott4RZsYwLrYkqLxm9gwGJfQ/FPCjpyUA0mFllhUJEAuphgdV2WpOfml08V5dDqQFXHS
 vGeNw6vixJ8LUJReaf/kZsUR+k9m2c8U/CXeg8W4IW/6QuASl62Q49bbLfGVfAVWprksgD/RCDe
 eow0bG7XieHoXabQAeJHMHVot5QwrXa269PwSfMK72Ypb2zqP/0LEfjpLl2jfC+jp9q+g==
X-Google-Smtp-Source: AGHT+IE3fU+A0sLrsH+7xL3XfeMc39nF22dIsp3N8OIrdIjkPclK7yyrXBQGi8Kb1+OmKin7Ut5e+0fBMq1wJOsigZw=
X-Received: by 2002:a17:907:2d0e:b0:b80:b7f:aa14 with SMTP id
 a640c23a62f3a-b84453a1272mr350251266b.32.1767812571634; Wed, 07 Jan 2026
 11:02:51 -0800 (PST)
MIME-Version: 1.0
References: <20260107003131.3064800-1-simon.glass@canonical.com>
 <20260107003131.3064800-6-simon.glass@canonical.com>
 <B1959B8B-8D25-499B-B1E8-02178F67A191@gmx.de>
In-Reply-To: <B1959B8B-8D25-499B-B1E8-02178F67A191@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 7 Jan 2026 12:02:39 -0700
X-Gm-Features: AQt7F2qTgEdT_rYI42Nl_Z635spb4xobZoAsy-oFmXPWDM0w_v0HuWlHQpBxQt8
Message-ID: <CAFLszTi-gRmj2YtHfG2F3u0feNMcC1+h5hwAvNTYJ+xC1JQnJA@mail.gmail.com>
Subject: Re: [PATCH 05/10] bootm: Do bootstage processing in bootm_final()
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <simon.glass@canonical.com>,
 Jerome Forissier <jerome.forissier@linaro.org>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
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

Hi Heinrich,

On Tue, 6 Jan 2026 at 20:58, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> Am 7. Januar 2026 01:31:22 MEZ schrieb Simon Glass <sjg@chromium.org>:
> >From: Simon Glass <sjg@chromium.org>
> >
> >Mark kernel start before booting. If enabled, show a bootstage report.
> >
> >Signed-off-by: Simon Glass <sjg@chromium.org>
> >Signed-off-by: Simon Glass <simon.glass@canonical.com>
> >---
> >
> > boot/bootm_final.c   | 6 ++++++
> > test/boot/bootflow.c | 2 +-
> > 2 files changed, 7 insertions(+), 1 deletion(-)
> >
> >diff --git a/boot/bootm_final.c b/boot/bootm_final.c
> >index 71661334e11..dd7cac55f1e 100644
> >--- a/boot/bootm_final.c
> >+++ b/boot/bootm_final.c
> >@@ -6,11 +6,17 @@
> >  */
> >
> > #include <bootm.h>
> >+#include <bootstage.h>
> > #include <dm/root.h>
> >
> > void bootm_final(enum bootm_final_t flags)
> > {
> >       printf("\nStarting kernel ...\n\n");
>
> This noisy message makes no sense for EFI booting. The kernel in not started in ExitBootServices().

Can you explain that a bit more? I believe that's exactly when the
kernel starts.

>
> Operating systems like Ubuntu tend to boot the kernel with argument "quiet" for aesthetic reasons. We should not disrupt this.

When I boot (with this patch) I see these messages on the serial console:
>>>
Scanning for bootflows in all bootdevs
Seq  Method       State   Uclass    Part  E  Name                      Filename
---  -----------  ------  --------  ----  -  ------------------------
----------------
Scanning global bootmeth 'efi_mgr':
  0  efi_mgr      ready   (none)       0     <NULL>
** Booting bootflow '<NULL>' with efi_mgr
      try_load_entry() Booting: Label: Ubuntu Device path:
/HD(1,GPT,eccaac1c-b634-441b-a788-ab0f959111af,0x800,0x165800)/\EFI\ubuntu\shimx64.efi

Starting kernel ...
<<<

So it is not silent today. The last line is the new one. Every other
boot method writes this line.

However, the video display is silent once grub has finished and I just
noticed that this patch draws some pixels on the display, as if the
EFI display is set to a different mode from what U-Boot expects. I
suppose this is understandable, as grub has run by then and has
probably changed the mode.

So I wonder what would be best here. We don't support dynamic video
sizing right now and I don't feel the urge to implement it just for
this. Perhaps with EFI we could disable the vidconsole when
exit-boot-services is called, on the basis that we cannot deal with
whatever has happened to the display in the interim?

Regards,
Simon

>
> Best regards
>
> Heinrich
>
> >
> >+      bootstage_mark_name(BOOTSTAGE_ID_BOOTM_HANDOFF, "start_kernel");
> >+
> >+      if (IS_ENABLED(CONFIG_BOOTSTAGE_REPORT))
> >+              bootstage_report();
> >+
> >       dm_remove_devices_active();
> > }
> >diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
> >index a56435d053f..80adc074070 100644
> >--- a/test/boot/bootflow.c
> >+++ b/test/boot/bootflow.c
> >@@ -1381,7 +1381,7 @@ static int bootflow_efi(struct unit_test_state *uts)
> >
> >       /* TODO: Why the \r ? */
> >       ut_assert_nextline("U-Boot test app for EFI_LOADER\r");
> >-      ut_assert_nextline("Exiting test app");
> >+      ut_assert_skip_to_line("Exiting test app");
> >       ut_assert_nextline("Boot failed (err=-14)");
> >
> >       ut_assert_console_end();
>

Regards,
Simon
