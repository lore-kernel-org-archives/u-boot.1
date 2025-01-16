Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C85CC02183
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 18:14:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7CCFC8069D;
	Thu, 16 Jan 2025 19:14:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Urvc3/uv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43EBF80703; Thu, 16 Jan 2025 19:14:21 +0100 (CET)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 654938022B
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 19:14:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2ee8e8e29f6so1865419a91.0
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 10:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737051257; x=1737656057; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=itIhGfKLjTj7V8y+C+ThmAooFAZDwHsLhpHeK9utAKg=;
 b=Urvc3/uvUNr90ECJr34dWhNYCnO5BrTZ7OqjCF0vxBAbrhpvrJnX1caZQ1BWmjhOkV
 8gIlEtLLXtCT0zf9g3uAnVED2zKuxoC7zv1sYAVdI8xPtXBvfGYtDvtMJjmYHBXZJ3xr
 Go/anL4wq5Zdfsa8rMFwWXsLZRHWjMRR8Q1Bw8NUjA69Jw3Wcqwt8KWJWB3FQFHrDX2+
 +o8UwY/whrPYAVYsyP+9ELmZG0SxdICEVUc8gkV+iOANZsVZFLXNL/HYfWh0NXF5kywX
 JQk5o57ef/GlF09XWF2C7WDc0fFV6Vav23FU7YNfrbhbZ8acZ457q5I2zXQk37SjnVXX
 9/kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737051257; x=1737656057;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=itIhGfKLjTj7V8y+C+ThmAooFAZDwHsLhpHeK9utAKg=;
 b=s7b0YF0F4BQdU7Y4ZfdpNOa+YVj+FEcLT+DFZ9Gbro/VceJgqeVGY0+VIJucYIxx+7
 AEjz0Fp6BZfagot16leYqP66zYtWtLNkoZDsUAfzjIZsR9P3dJc0g5RnLJXGJCNhOjiq
 wXiSG4P1H4JMYPyMHiEGnQxQwHCfvAI9QW8LCsKYrGY/IYJUGC53C/XMamLmW4zMqXJo
 cbS29kfK49K2jK0qcqtPH51uFJyrXdHGptMDA0yuRwKnGgrlu1gP9Y1vhwhUYgOu/uuH
 VlGZr7VlcsT7QkMoAnSaLzIsXsuYDLo7dPW2QIBugdB13s8UqnYG9uX2jU/TiWbYp8fq
 URoQ==
X-Gm-Message-State: AOJu0YwFkJfvn9Rs2nrw8ahF0b93OCjLvcsJhC+IWpYbuhv0HrYYjh8/
 qhf5pfKE/xxJrenR9LmXKrXosTHwZWeDsK0Gdndi6dkgUjQOKqmB7tDVci1LRoNS8BhhyaifLPc
 Wwc1wnvAoX4vaI6gq7NUBp6ePWebzI8UcrpJiVA==
X-Gm-Gg: ASbGnctRH2PcFzJ1OmzWSBCDWtUr+7QJg7eYNarnmp+q/BiVMIDQ31xRtf9MZ/TW+ZK
 BFtTVELIN0aLcBlSqoinrZh66fKjS14dcXSypah6SdaDjNW/48sf9Ue79bdRrvGU3a1fmDA==
X-Google-Smtp-Source: AGHT+IHEA5oDb9aiixOoxN6WjtkDfb4yNYRsn7Jo2/MjXVIbBuVAkQI5j7k8kksaC7xUtnuG6qLIMWf6yZUzbkbkNU0=
X-Received: by 2002:a17:90a:fc48:b0:2ee:b4bf:2d06 with SMTP id
 98e67ed59e1d1-2f548f6a5f4mr46607926a91.19.1737051256882; Thu, 16 Jan 2025
 10:14:16 -0800 (PST)
MIME-Version: 1.0
References: <20250115200144.951530-1-raymond.mao@linaro.org>
 <20250115200144.951530-3-raymond.mao@linaro.org>
 <CAC_iWjKgoNdON5u2GHjKT+HPwt9hd+JkD6k48VeMWoWoFLbmpQ@mail.gmail.com>
In-Reply-To: <CAC_iWjKgoNdON5u2GHjKT+HPwt9hd+JkD6k48VeMWoWoFLbmpQ@mail.gmail.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Thu, 16 Jan 2025 13:14:03 -0500
X-Gm-Features: AbW1kvZrH_0BOInxGUWV8DKD0u_lrhoB7_wPUfIo3h4TkjukzwJoyCh87Lk4hg8
Message-ID: <CAEfUkUKWscSz_hHkXWH9ehcThSKW4sBA3gAKz50oPuOfSsOD+Q@mail.gmail.com>
Subject: Re: [PATCH 2/6] tmp: add TPM2_PCR_Allocate command
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Tim Harvey <tharvey@gateworks.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Michal Simek <michal.simek@amd.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Ilias,

On Thu, 16 Jan 2025 at 07:37, Ilias Apalodimas <ilias.apalodimas@linaro.org>
wrote:

> Hi Raymond,
>
> On Wed, 15 Jan 2025 at 22:02, Raymond Mao <raymond.mao@linaro.org> wrote:
> >
> > TPM2_PCR_Allocate command is required to re-configurate
>
>
> reconfigure
>
> > a TPM device
> > to enable or disable algorithms in run-time, thus this patch introduces
> > the implementation of PCR allocate APIs and adds related cmd functions
> > for testing.
> >
> > To test the feature, ensure that TPM is started up.
> > Run pcr_allocate command to turn on/off an algorithm, multiple calls
> > are supported and all changes will be cached:
> > `tpm2 pcr_allocate <algorithm_name> <on|off>`
> > Run startup command with argument 'off' to shutdown the TPM.
> > `tpm2 startup TPM2_SU_CLEAR off`
> > Reboot the board via `reset` to activate the changes.
> >
> > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> > ---
> >  cmd/tpm-v2.c     |  94 +++++++++++++++++++++++++++++++++++
> >  include/tpm-v2.h |  29 +++++++++++
> >  lib/tpm-v2.c     | 124 +++++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 247 insertions(+)
> >
> > diff --git a/cmd/tpm-v2.c b/cmd/tpm-v2.c
> > index a6d57ee7c4..2302e8e94c 100644
> > --- a/cmd/tpm-v2.c
> > +++ b/cmd/tpm-v2.c
> > @@ -232,6 +232,86 @@ unmap_data:
> >         return report_return_code(rc);
> >  }
> >
> > +static u32 select_mask(u32 mask, enum tpm2_algorithms algo, bool select)
> > +{
> > +       size_t i;
> > +
> > +       for (i = 0; i < ARRAY_SIZE(hash_algo_list); i++) {
> > +               if (hash_algo_list[i].hash_alg != algo)
> > +                       continue;
> > +
> > +               if (select)
> > +                       mask |= hash_algo_list[i].hash_mask;
> > +               else
> > +                       mask &= ~hash_algo_list[i].hash_mask;
> > +
> > +               break;
> > +       }
> > +
> > +       return mask;
> > +}
> > +
> > +static int do_tpm2_pcrallocate(struct cmd_tbl *cmdtp, int flag, int
> argc,
> > +                              char *const argv[])
> > +{
> > +       struct udevice *dev;
> > +       int ret;
> > +       enum tpm2_algorithms algo;
> > +       const char *pw = (argc < 4) ? NULL : argv[3];
> > +       const ssize_t pw_sz = pw ? strlen(pw) : 0;
> > +       static struct tpml_pcr_selection pcr = { 0 };
> > +       u32 pcr_len = 0;
> > +       bool bon = false;
> > +       static u32 mask;
> > +       int i;
> > +
> > +       /* argv[1]: algorithm (bank), argv[2]: on/off */
> > +       if (argc < 3 || argc > 4)
> > +               return CMD_RET_USAGE;
> > +
> > +       if (!strcasecmp("on", argv[2]))
> > +               bon = true;
> > +       else if (strcasecmp("off", argv[2]))
> > +               return CMD_RET_USAGE;
> > +
> > +       algo = tpm2_name_to_algorithm(argv[1]);
> > +       if (algo == -EINVAL)
> > +               return CMD_RET_USAGE;
> > +
> > +       ret = get_tpm(&dev);
> > +       if (ret)
> > +               return ret;
> > +
> > +       if (!pcr.count) {
>
>
> Ins't this always true?
>
> Not really, pcr is a static variable to cache the latest configurations.
The command itself is designed to turn on/off one algorithm each time for
easy usage, and expects to be called multiple times when the user wants to
change more than one algorithm.
We just need to get the active bank at the first call when the command is
running multiple times.
Since tpm2_get_pcr_info() will not return the real actual active banks
after one PCR allocate command is sent until a reset occurs.


> > +               /*
> > +                * Get current in-use algorithms (banks), PCRs and mask
> via the
> > +                * first call
> > +                */
>
>
> in-use translates to active PCR banks. Isn't that function returning
> the hardware-supported banks?
>
> That returns the active ones only but not includes the inactive ones if
any.


>
> > +               ret = tpm2_get_pcr_info(dev, &pcr);
> > +               if (ret)
> > +                       return ret;
>
>
> So we have the TPM banks the hardware supports here. Does it make
> sense to check if the requested algorithm is supported and exit early?
> In theory, it doesn't matter because the hardware will reject the
> configuration later, but I'd like to have a comment about this.
>
> Ditto. It knows the active algorithms only but not includes the supported
but inactive ones.

Regards,
Raymond


> > +
> > +               for (i = 0; i < pcr.count; i++) {
> > +                       struct tpms_pcr_selection *sel =
> &pcr.selection[i];
> > +
> > +                       if (!tpm2_is_active_bank(sel))
> > +                               continue;
> > +
> > +                       mask = select_mask(mask, sel->hash, true);
> > +                       printf("Active bank[%d] with algo[%#x]\n", i,
> > +                              sel->hash);
> > +               }
> > +       }
> > +
> > +       mask = select_mask(mask, algo, bon);
> > +       ret = tpm2_pcr_config_algo(dev, mask, &pcr, &pcr_len);
> > +
> [...]
>
> Other than that this looks good to me
>
> Thanks
> /Ilias
>
