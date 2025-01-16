Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3042FC02183
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 18:20:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 87D388033D;
	Thu, 16 Jan 2025 19:20:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="t8vVMK3f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B632E8069D; Thu, 16 Jan 2025 19:20:30 +0100 (CET)
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com
 [IPv6:2607:f8b0:4864:20::b33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 652D48022B
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 19:20:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-e46ebe19489so1888889276.2
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 10:20:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737051627; x=1737656427; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=exX8gtIzcx+cQ0Z1YbgrOhFyH98ZcmIk0qtSVHNXOOQ=;
 b=t8vVMK3fyPxlaWYZ1+tfI7ttHIXQLT2Z1pM8JEXF7MuOlfM8RqSV428cpAyp0NJZ9J
 woUdJ05W0+EPhmiKUsgMi7XzJJah3SjSmgbrfmcT+nYSNdyROC2XyBB3ez67y/rx9j/P
 hONyk+Ky09tr28UenFQ9oBL4PgAbOYOfro1j9uOGb3bZa5CGhfOVl3w75TOBaRwohCp8
 hu/hVRMu3rwEoWs644B8MyDRgnESY3nEORwwmrXq8DOpkF33iAKIcq50qhSthiUZ07uh
 ON3K8sSbw6GOXqgnv94Hv8h/bPvaI7TwB+s7QDe3HgVPJNpZAPNjU+uNYIrmtDp5KkPE
 wIig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737051627; x=1737656427;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=exX8gtIzcx+cQ0Z1YbgrOhFyH98ZcmIk0qtSVHNXOOQ=;
 b=c6UikWYYd2ljp0VG4WFRE/tOntX6NliY/59XpD1fE/zbde9FPLhT+ntssL/4jEZl5V
 LqIarMn6R2mjpIVI2h9ZEGWRJDZ2yYIxqL0JDeLmIhEBaQf0gGs2aPzNkrl1DtyGuUZu
 oBMi/27i/yo2NZlpKRTp0KuFmJ4YhSsjPQcHM9U1AnVYuEwFs8s7axtiQ9S6kFMNQAUp
 FU0U+Ei6F1WJYsu2RSYTq+DDyPwT3SCp6ultsa026bjP8mUfBaaio+G9UgMdBWQ2MkWO
 c2AHV2XpyrQOg+/cX2RYYtMgKVwVhFuntxFu27NF9efGbODmzbvpJAb7L4Bj/DhrlJMV
 jSFw==
X-Gm-Message-State: AOJu0YzzrDR/9/oB9BvACfGh+rX8NQIc/zHfO0ma18gM0CusUfmZ7NeR
 pWUqSGQ2gn6KBpysHGNHnuHh1Mxjs+wX2Lo5MQF8xjip5UoToV88w28/IMbsZV986tjsxyC4470
 P8Y2/NpJbE+eocJbyWaqC4kDB0veBYIQ2CaxG2g==
X-Gm-Gg: ASbGncvFbMcNLkPWy3JZXzOOcpZAmKN7MLy/07c9BOemSy56AS8EH6brL6ZZ/0WQt9n
 MobPBH3BMVAy0rG7MiutCP8m038zhAlAGJa+VTQ==
X-Google-Smtp-Source: AGHT+IH2fbI4yzr7wL/a5iO+kFxgjd1cTRQ7pOGynzu9kxXAf397zqRSebcgciR021g3oM21WVGtZIS8otkIgUJ/BTE=
X-Received: by 2002:a05:690c:6a85:b0:6ef:6e34:6561 with SMTP id
 00721157ae682-6f5312dd8c2mr313060687b3.32.1737051627101; Thu, 16 Jan 2025
 10:20:27 -0800 (PST)
MIME-Version: 1.0
References: <20250115200144.951530-1-raymond.mao@linaro.org>
 <20250115200144.951530-3-raymond.mao@linaro.org>
 <CAC_iWjKgoNdON5u2GHjKT+HPwt9hd+JkD6k48VeMWoWoFLbmpQ@mail.gmail.com>
 <CAEfUkUKWscSz_hHkXWH9ehcThSKW4sBA3gAKz50oPuOfSsOD+Q@mail.gmail.com>
In-Reply-To: <CAEfUkUKWscSz_hHkXWH9ehcThSKW4sBA3gAKz50oPuOfSsOD+Q@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 16 Jan 2025 20:19:51 +0200
X-Gm-Features: AbW1kvbVPOhYwpUMVu-ULEbgNW300CwM_6ubvDiS052igcknMz_b9q0r5GR4980
Message-ID: <CAC_iWjLJ6OcB2QnR2DUFB4FzBTz123eptF3xWGSVSd1n5=9AfA@mail.gmail.com>
Subject: Re: [PATCH 2/6] tmp: add TPM2_PCR_Allocate command
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Tim Harvey <tharvey@gateworks.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Michal Simek <michal.simek@amd.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>
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

On Thu, 16 Jan 2025 at 20:14, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Hi Ilias,
>
> On Thu, 16 Jan 2025 at 07:37, Ilias Apalodimas <ilias.apalodimas@linaro.org> wrote:
>>
>> Hi Raymond,
>>
>> On Wed, 15 Jan 2025 at 22:02, Raymond Mao <raymond.mao@linaro.org> wrote:
>> >
>> > TPM2_PCR_Allocate command is required to re-configurate
>>
>>
>> reconfigure
>>
>> > a TPM device
>> > to enable or disable algorithms in run-time, thus this patch introduces
>> > the implementation of PCR allocate APIs and adds related cmd functions
>> > for testing.
>> >
>> > To test the feature, ensure that TPM is started up.
>> > Run pcr_allocate command to turn on/off an algorithm, multiple calls
>> > are supported and all changes will be cached:
>> > `tpm2 pcr_allocate <algorithm_name> <on|off>`
>> > Run startup command with argument 'off' to shutdown the TPM.
>> > `tpm2 startup TPM2_SU_CLEAR off`
>> > Reboot the board via `reset` to activate the changes.
>> >
>> > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
>> > ---
>> >  cmd/tpm-v2.c     |  94 +++++++++++++++++++++++++++++++++++
>> >  include/tpm-v2.h |  29 +++++++++++
>> >  lib/tpm-v2.c     | 124 +++++++++++++++++++++++++++++++++++++++++++++++
>> >  3 files changed, 247 insertions(+)
>> >
>> > diff --git a/cmd/tpm-v2.c b/cmd/tpm-v2.c
>> > index a6d57ee7c4..2302e8e94c 100644
>> > --- a/cmd/tpm-v2.c
>> > +++ b/cmd/tpm-v2.c
>> > @@ -232,6 +232,86 @@ unmap_data:
>> >         return report_return_code(rc);
>> >  }
>> >
>> > +static u32 select_mask(u32 mask, enum tpm2_algorithms algo, bool select)
>> > +{
>> > +       size_t i;
>> > +
>> > +       for (i = 0; i < ARRAY_SIZE(hash_algo_list); i++) {
>> > +               if (hash_algo_list[i].hash_alg != algo)
>> > +                       continue;
>> > +
>> > +               if (select)
>> > +                       mask |= hash_algo_list[i].hash_mask;
>> > +               else
>> > +                       mask &= ~hash_algo_list[i].hash_mask;
>> > +
>> > +               break;
>> > +       }
>> > +
>> > +       return mask;
>> > +}
>> > +
>> > +static int do_tpm2_pcrallocate(struct cmd_tbl *cmdtp, int flag, int argc,
>> > +                              char *const argv[])
>> > +{
>> > +       struct udevice *dev;
>> > +       int ret;
>> > +       enum tpm2_algorithms algo;
>> > +       const char *pw = (argc < 4) ? NULL : argv[3];
>> > +       const ssize_t pw_sz = pw ? strlen(pw) : 0;
>> > +       static struct tpml_pcr_selection pcr = { 0 };
>> > +       u32 pcr_len = 0;
>> > +       bool bon = false;
>> > +       static u32 mask;
>> > +       int i;
>> > +
>> > +       /* argv[1]: algorithm (bank), argv[2]: on/off */
>> > +       if (argc < 3 || argc > 4)
>> > +               return CMD_RET_USAGE;
>> > +
>> > +       if (!strcasecmp("on", argv[2]))
>> > +               bon = true;
>> > +       else if (strcasecmp("off", argv[2]))
>> > +               return CMD_RET_USAGE;
>> > +
>> > +       algo = tpm2_name_to_algorithm(argv[1]);
>> > +       if (algo == -EINVAL)
>> > +               return CMD_RET_USAGE;
>> > +
>> > +       ret = get_tpm(&dev);
>> > +       if (ret)
>> > +               return ret;
>> > +
>> > +       if (!pcr.count) {
>>
>>
>> Ins't this always true?
>>
> Not really, pcr is a static variable to cache the latest configurations.
> The command itself is designed to turn on/off one algorithm each time for easy usage, and expects to be called multiple times when the user wants to change more than one algorithm.
> We just need to get the active bank at the first call when the command is running multiple times.
> Since tpm2_get_pcr_info() will not return the real actual active banks after one PCR allocate command is sent until a reset occurs.

I completely ignored the static in that variable.

>
>>
>> > +               /*
>> > +                * Get current in-use algorithms (banks), PCRs and mask via the
>> > +                * first call
>> > +                */
>>
>>
>> in-use translates to active PCR banks. Isn't that function returning
>> the hardware-supported banks?
>>
> That returns the active ones only but not includes the inactive ones if any.

It returns the hardware available PCR banks regardless of them being
active or not

/Ilias
>
>>
>>
>> > +               ret = tpm2_get_pcr_info(dev, &pcr);
>> > +               if (ret)
>> > +                       return ret;
>>
>>
>> So we have the TPM banks the hardware supports here. Does it make
>> sense to check if the requested algorithm is supported and exit early?
>> In theory, it doesn't matter because the hardware will reject the
>> configuration later, but I'd like to have a comment about this.
>>
> Ditto. It knows the active algorithms only but not includes the supported but inactive ones.
>
> Regards,
> Raymond
>
>>
>> > +
>> > +               for (i = 0; i < pcr.count; i++) {
>> > +                       struct tpms_pcr_selection *sel = &pcr.selection[i];
>> > +
>> > +                       if (!tpm2_is_active_bank(sel))
>> > +                               continue;
>> > +
>> > +                       mask = select_mask(mask, sel->hash, true);
>> > +                       printf("Active bank[%d] with algo[%#x]\n", i,
>> > +                              sel->hash);
>> > +               }
>> > +       }
>> > +
>> > +       mask = select_mask(mask, algo, bon);
>> > +       ret = tpm2_pcr_config_algo(dev, mask, &pcr, &pcr_len);
>> > +
>> [...]
>>
>> Other than that this looks good to me
>>
>> Thanks
>> /Ilias
