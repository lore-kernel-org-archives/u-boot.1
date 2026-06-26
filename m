Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F194CD4F26
	for <u-boot@archiver.kernel.org>; Fri, 26 Jun 2026 10:42:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 153438496E;
	Fri, 26 Jun 2026 12:42:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BJDIoRhv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F18A1849D2; Fri, 26 Jun 2026 12:42:05 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 087E18460E
 for <u-boot@lists.denx.de>; Fri, 26 Jun 2026 12:42:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-695f6438518so1116180a12.0
 for <u-boot@lists.denx.de>; Fri, 26 Jun 2026 03:42:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782470523; cv=none;
 d=google.com; s=arc-20260327;
 b=SjCpYGDOLg472A25B+3SjT6NuA9QLdrdxDs7TjAUGUZ8yyvw/C7GsDa7vwkx+EtXZY
 +jWnUaNgJ4QTsuKTJz+R5V6cG7t+IobKy7hx/5aNtEow3oERPWRARmS7c6VwcCgEBfmU
 zZVoaEXl0oORLdd8cpuR1thhYOTqpaAjjINs+OMPGjgxKIlycSUXbq/HXWaNNDFKKPlN
 6lS7bdc8hfG1nGhftUdHEbskbYXItpI9i2RxyUuO5kqjPrgCBXeJT8CmW79nL2U8dcAJ
 NsBRseH3tn4ydq4kUzFVnMvuRbHeU86MHB2gUw1DpT7ZWo5PMRffHTj3ZN5SACdtkkwK
 RHdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=WLlzMiBMzM+SIQnlLXFOP9Tfmr3mzlBKGLof3UkINq4=;
 fh=nyKLZbC5pO9EO6FCB5YQSf7kr334RAPXhBSMuZ9b11E=;
 b=ECUtGLgVIWgOqoUAFJlK3WqOJZSsUDcekRCRkBD+KB7Ns0TMqKIKmvxU92OiLGrWdU
 dsPNUfDP0Pk6u5z7g8/+5VRRE4vlCnuQO8j6fngQgvEA/ySGOWRdAc9R7tBwi48quvWM
 30Ee/o6+pSMx0aikU9Z3HRnpt8va14xNTUR6gWNvwCcCAls92riHT4nl5rE3dhaeQhtn
 T0Z5yQy4fhlIR2VCW6JRTVjwEkYx7mKVA9TECKDRZOLf18MJ5fE6CbzDdpgXpWzmRDKz
 nG03QLDr4FC0Ul/AV4uYUQ03uULoLmghArDlU5oZdmq6ZK6Z9t2o/NpAWZVORf2GkFVO
 ggbQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782470523; x=1783075323; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WLlzMiBMzM+SIQnlLXFOP9Tfmr3mzlBKGLof3UkINq4=;
 b=BJDIoRhvdrnCl84VBuzhggrh2UT1mjp9UEcKbzaG7gk+pyLBU7SQh5YPH8yFxfhnfw
 7x+xB7QpfdXH8Zfh4ErV8wUWoqW8bTKjtjNR4nZwoSkVFAn2GTWK5bEc5PpicjrJ9gMn
 xl7vAZYoVOhUp7ACHzzAR/cMbv75lCRGuGqbQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782470523; x=1783075323;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WLlzMiBMzM+SIQnlLXFOP9Tfmr3mzlBKGLof3UkINq4=;
 b=rP9YZmCKS9xlMAWa/nxsnlJ77VlOykUqH3TUTseUUtrUaZrkqoZCAvuuHNJsHB2S2Q
 3pZExONhF1jSR/MkfXN5ZRgt2TKC5B2aTywabCgASzmr3dI4zSry1uRiRHdkzmcmwzlF
 A7eUWkuVLUq7ra4b9xjSStztw+SXTpKQRtXZQo4O/rxSrj2FzIRLjUS7Xm72RpT8B1Os
 jTsCZ10m20uXMkJi/LjZkPAr6Mb8T79NRFM6IcEh57uEgzBwVMwcDaTgMwBC6N6eX821
 LUK0UGlEB43FYbhyAR4oqqX/PGta+rF8tH9BtHYhmjMSKu57IDrPR6UjNOeF9aJu61m+
 CtLw==
X-Gm-Message-State: AOJu0YysgiMIlcrSridtzBytRDa+RQrcjDKZCY0g9iMcXV2sWcfeJvVj
 ADU0++jZ95N2Gtg/ensCJSK01yCuXWD/BqONpCw+kC/LHLZlf6/wkio/WNSrsbLwISoSqn1Tqmh
 Hofrd7OEWo5ptZEgHkfJiJu8/c118mxn7wXtCRIlH
X-Gm-Gg: AfdE7clet6DI/rZwodQc6jjOVRKhGRUL+oR/iV2zj1NWJvcjJg/gz4z6lNaK0iCKf6h
 2tgPC5k95Z6ErmTqJfEcL5bsxDNwmcczhquZIBif95oZI3sFK5RI78TuyuRvGSPYsLR8mTXdKe6
 jPaMBjsD+awrD1HoSB86L1NWuM6CK3uAuaB/+/HvjDOc7LRrDFY1Bh8mjfCpfb+wLfdEcqW4dri
 xU1T60GUa4+Q3ZkNZxvjOhu+nH6BL9Oh43MYRVrZdpfHhS9o5cg3SpoF02urtrHec1Xs6NdLw==
X-Received: by 2002:a05:6402:a295:10b0:698:1504:e3de with SMTP id
 4fb4d7f45d1cf-6981504e4dcmr1196491a12.29.1782470523527; Fri, 26 Jun 2026
 03:42:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260606-pm8916-pon-v1-0-170c9cbe5099@samcday.com>
 <20260606-pm8916-pon-v1-9-170c9cbe5099@samcday.com>
In-Reply-To: <20260606-pm8916-pon-v1-9-170c9cbe5099@samcday.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 26 Jun 2026 11:41:51 +0100
X-Gm-Features: AVVi8CfL_OTkqi_HtI-IkXfcLsrsm6HMK8a4NDjP9ZSgnPCNkypAhsHsaMCuE2I
Message-ID: <CAFLszTgmmECLO=U_p1dThz2RmUraE7GUujrn1nXF-zZOHCKUjw@mail.gmail.com>
Subject: Re: [PATCH 09/11] reboot-mode: reboot method activation support
To: me@samcday.com
Cc: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io, 
 Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>, 
 Peng Fan <peng.fan@nxp.com>, Leo Yu-Chi Liang <ycliang@andestech.com>,
 Anshul Dalal <anshuld@ti.com>, 
 Kever Yang <kever.yang@rock-chips.com>, Neha Malcom Francis <n-francis@ti.com>,
 Justin Klaassen <justin@tidylabs.net>,
 Jamie Gibbons <jamie.gibbons@microchip.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Luca Weiss <luca.weiss@fairphone.com>, 
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Sughosh Ganu <sughosh.ganu@arm.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 George Chan <gchan9527@gmail.com>, 
 Antony Kurniawan Soemardi <linux@smankusors.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Peter Robinson <pbrobinson@gmail.com>,
 "Ariel D'Alessandro" <ariel.dalessandro@collabora.com>, 
 Dmitrii Merkurev <dimorinny@google.com>
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

Hi Sam,

On 2026-06-06T08:47:32, Sam Day via B4 Relay
<devnull+me.samcday.com@kernel.org> wrote:
> reboot-mode: reboot method activation support
>
> Until now, the reboot-mode uclass didn't wire up a producer path to
> allow arbitrary changes to the reboot mode. The current impl only uses
> reboot_mode_ops->set to clear the reboot mode once it has been read at
> boot-time.
>
> The public API is expanded with a dm_reboot_mode_activate method, which
> will instruct the given device to activate a particular reboot mode.
>
> The first producer, fastboot reboot, will be introduced in the next
> commit.
>
> Signed-off-by: Sam Day <me@samcday.com>
>
> drivers/reboot-mode/reboot-mode-uclass.c | 18 ++++++++++++++++++
>  include/reboot-mode/reboot-mode.h        | 12 ++++++++++++
>  2 files changed, 30 insertions(+)

> diff --git a/include/reboot-mode/reboot-mode.h b/include/reboot-mode/reboot-mode.h
> @@ -53,4 +53,16 @@ struct reboot_mode_ops {
> + * dm_reboot_mode_activate() - activate a reboot mode by name
> + *
> + * This will read the given @dev plat_data for a named mode, and write the
> + * magic value for that mode to the device.
> + *
> + * @dev Device to write reboot magic to
> + * @mode name of the mode to lookup for magic value
> + * Return: 0 on success, -ve on error
> + */
> +int dm_reboot_mode_activate(struct udevice *dev, const char *mode);

Please follow the kernel-doc style used by dm_reboot_mode_update()
just above - @dev: and @mode: with a colon and tab, sentence-cased
descriptions, and 'Return: 0 if OK, -ve on error' to match the rest of
the file.

> diff --git a/drivers/reboot-mode/reboot-mode-uclass.c b/drivers/reboot-mode/reboot-mode-uclass.c
> @@ -9,6 +9,24 @@
> +int dm_reboot_mode_activate(struct udevice *dev, const char *mode)
> +{
> +     struct reboot_mode_ops *ops = reboot_mode_get_ops(dev);
> +     int i;
> +     const struct reboot_mode_uclass_platdata *plat_data =
> +             dev_get_uclass_plat(dev);

Nit: please group the variable declarations - put plat_data next to
ops, with int i at the end, matching dm_reboot_mode_update() style.

Regards,
Simon
