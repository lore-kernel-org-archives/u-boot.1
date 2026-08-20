Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6166EC5DF81
	for <u-boot@archiver.kernel.org>; Thu, 20 Aug 2026 12:12:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1F97360782;
	Thu, 20 Aug 2026 12:12:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jvwitRv9mXu7; Thu, 20 Aug 2026 12:12:36 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787227956;
	bh=/FcQic8K9lRBPBgyBEE25Ogb8V8F7dKR4nmNenHdfL4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MPbSRClZb2EEsjruZJzwRZh7KKODYRD4VzSlppqaS6q6WxkjILPXAP4b3rbMg6Kfc
	 kOT6bmfXKQ/l5Wqs4QOSjhp0gQxbAXWaxWZ3QwNbxXfsvWtMYECfGeaKE1vwAkyua2
	 zUfNeM6ejYqSQ63C2harNv04TANo3RayND7nJw0s9MJZpEndxu3/rasE+98c6p9oVG
	 NAB7ZRvAMw97agJz/2i+xDAg9C+/MDdAZrcPic9q2cmVtWJKxP4oYICrHJMsKayUWy
	 jpOUxvrBtD9d1r9pBaa6xQqRIyWmeyi+edarXfJRifu116ojmMFsnf/5ngFm0Bhfzi
	 OB0St1n0aNJQA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4D9616077C;
	Thu, 20 Aug 2026 12:12:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 714D023F
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 12:12:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 63B3440291
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 12:12:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eTmn8GZ8Jpro for <u-boot@lists.u-boot-project.org>;
 Thu, 20 Aug 2026 12:12:34 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62e; helo=mail-ej1-x62e.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=NomiJw4B
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 646DF402A8
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 12:12:33 +0000 (UTC)
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-c2074710751so367574866b.1
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 05:12:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787227952; cv=none;
 d=google.com; s=arc-20260327;
 b=Nw7gDJ9vKvAMQme023yfTlre16zh0jQbsWIdq0W1kxGaQaf4VeDvO2R9xL6QTdBMfQ
 /kLQXH9YdOqkhcssCQUvIVMErt8k+n8spXXPNYAr9BDpLAxUm35LQ07MHCqZOsV87v+c
 WfCAQOH/zZhRALBKhOjFwN6OvNNnF2jdNKtrGmBbJRd0DwjVFa0pBUZVyY7IkLiIX9CE
 zylXSpbdY/SaLAHSAmXJAwbfln/ZrqUXlIBvHJBqcTwidR5zzPxbZjSj0eChgANvBKG4
 hjtfb26ruBPNl3w3/isCUzqI0mbxoOju9PwIk+d4lOG9teTST5Aa32+CjXjWc40DrRmS
 4Wjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=/FcQic8K9lRBPBgyBEE25Ogb8V8F7dKR4nmNenHdfL4=;
 fh=Bwjok4jWsPwFzEPPOJOguv26ANoKPtuv9PCfDq8ap3w=;
 b=BhyvaO8oQgjadhVOPSX6XnDKoO+U+Yb8oTzGKPv0utAD0cwZaMxHcFzm6qJclWjk3t
 bvXXxzDfEIvdSUs3N9AoGBeQDcTZQF2VFTlyu7JgZckLAK4ta3hPrT5TFkuNmQFGPac4
 2Tc9aZb2/BxQhVHuYP6w41DclEfq8e/y+AEtHlNBQeoCTWAMRtQeGEtL4Ty1Jx9KwE4g
 lviEsiuWA1/jR3H1M1SVxseg2Yd++601LDxM6E2GZ17Qg2tnKuG1QxBET4uo7OVGvkuj
 AKcrSsMB6zVbDGIFxdcxe/eU6Z9YFjWDf9MXbw1Nk87nXlVdpTeYuju3kzzNoFkHpu8S
 ASWw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1787227952; x=1787832752;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=/FcQic8K9lRBPBgyBEE25Ogb8V8F7dKR4nmNenHdfL4=;
 b=NomiJw4BIzBZZKzkYU0NL3p4ve7j9IUp0ZTTPNBdWzOHZo6tqb2LdGUqgTApoho9AI
 g37vvhoEi54gRf3LuCeRQsBeOJKBNuuGQqZQNOtQ/37xrLBtO45jtDlFFo71Bfp3GDGk
 kk42x5W9W8frUbdut3BKuQUKBtTMHU+sG+Q9A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787227952; x=1787832752;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=/FcQic8K9lRBPBgyBEE25Ogb8V8F7dKR4nmNenHdfL4=;
 b=UiE28MOvSY9Bi9w71wbbDGU0lwu/rrx4dyLEaljTEV4RGloCazXtsYzJwm+IIYZhcW
 nv8zXnsFEHGwNbuiCSheQz+tt6U4lACMGnU3JgNi1JMLd1YZioYd/SiheLNyNZ2dGLrS
 LptWcuzyNcTi1CJWrxjZkrrK8mo24ZchFenNZZUvceFIIuoGvJXXH5kwTcy5qqGCtIWE
 B3N5rHNUZogp2LlD1QSWpQB/UcIBankYEJi0ydm2CrpHSKGUdP9dfg2NwIBkEJ6qERwi
 2lSYI1HWDGwwNz4YrJDBSGf1d9utnhyWU7LdMyBwWQXSngnZ1AS77Dz7aZwCHHpfUX1L
 Bc5w==
X-Gm-Message-State: AOJu0YyxZg1uvoynFJyNEbzrdu+yO6spRKDWuKi/HCjObr5F9Xj+UtTn
 X7JFlODccM+5dr/L3p5DTOzBNrggdl8Oppev1nDmtP+JJvYLnGPviIxr5hQ4PjB244fXoIaj22V
 UShP0bG7Tk677j2FeGMgIlYSqOBtWnQV85UKmV9iP
X-Gm-Gg: AR+sD124r11KeHz1XC2XsgZai5MYhCr021Ibiyi1OmQhblXsdgGo0hdVGVIfViDdaTl
 BKyko/7VDn8jGIp6pMcwkXZ+6GClrcT0S3lkwoXPW1CEHUotAoefUjEbpNabJVhpgmPZuf2lcHK
 mIxlqNg4itWcQrwFN7afLyjIiNVtEijQi64usq+iu08jEVPLW0+4t/lGVkPyFyVMPK0jLtojZA8
 iqQeh4nqfxwOOI8qzYR3I1/7q4IWgKnSY8n/XecQrtgCGb+WVLalKjlMj3/Z0DgO/ZD3LUlWGq4
 m0LEbiAuKY71YPhqrzeKxdFTRJyBlipT1qQ8Z6oKCB4=
X-Received: by 2002:a17:907:c78c:b0:c12:83c9:d41 with SMTP id
 a640c23a62f3a-c242e22dbffmr961250666b.12.1787227951947; Thu, 20 Aug 2026
 05:12:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260811-b4-reset-edl-rebootmode-v1-0-2e15adc156a3@oss.qualcomm.com>
 <20260811-b4-reset-edl-rebootmode-v1-2-2e15adc156a3@oss.qualcomm.com>
In-Reply-To: <20260811-b4-reset-edl-rebootmode-v1-2-2e15adc156a3@oss.qualcomm.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 20 Aug 2026 06:12:17 -0600
X-Gm-Features: AcwNN1UMszJf_cSaYBKcjJEaO2b8pwAem4zwQ38W47t6_gBvkJaZq9PuWNktDM4
Message-ID: <CAFLszTh7HTabSZvFZWnQArLmW_SDQAR2AdDfB=F5LjY_+BVEBA@mail.gmail.com>
Subject: Re: [PATCH 2/8] reboot-mode: add trigger op and request/list helpers
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>, 
 u-boot-qcom@groups.io, Tom Rini <trini@konsulko.com>, 
 Casey Connolly <casey.connolly@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Johan Jonker <jbx6244@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Biswapriyo Nath <nathbappai@gmail.com>, Simon Glass <sjg@chromium.org>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>, Michal Simek <michal.simek@amd.com>, 
 Aristo Chen <aristo.chen@canonical.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Balaji,

On 2026-08-11T05:18:35, Balaji Selvanathan
<balaji.selvanathan@oss.qualcomm.com> wrote:
> reboot-mode: add trigger op and request/list helpers
>
> The reboot-mode framework so far only reads a value from a backing store
> on boot (get/set) and maps it to an environment variable. Triggering a
> reset into a specific mode on demand - e.g. rebooting a Qualcomm SoC into
> EDL via a PSCI SYSTEM_RESET2 vendor reset - needs a different approach.
>
> Add an trigger() op to struct reboot_mode_ops. It takes the
> decoded magic cells for a mode and resets the system immediately; on
> success it does not return. Backing-store drivers (nvmem, gpio, rtc)
> leave it NULL and are unaffected.

Nit: 'Add a trigger() op'.

>
> Add two uclass helpers built on top of it:
>
>   - reboot_mode_request(name) looks up a mode by name across all
>     UCLASS_REBOOT_MODE devices and, if the owning device can trigger,
>     resets into it. Returns -ENOENT if no triggerable mode matches.
>
>   - reboot_mode_list() enumerates every triggerable mode registered with
>     the framework, so a command can present the available modes to the
> [...]
>
> drivers/reboot-mode/reboot-mode-uclass.c | 48 ++++++++++++++++++++++++++++++++
>  include/reboot-mode/reboot-mode.h        | 40 ++++++++++++++++++++++++++
>  2 files changed, 88 insertions(+)

> diff --git a/drivers/reboot-mode/reboot-mode-uclass.c b/drivers/reboot-mode/reboot-mode-uclass.c
> @@ -54,6 +54,54 @@ int dm_reboot_mode_update(struct udevice *dev)
> +int reboot_mode_list(void)
> +{
> +     const struct reboot_mode_uclass_platdata *plat_data;
> +     struct reboot_mode_ops *ops;
> +     struct udevice *dev;
> +     int i;
> +
> +     printf("Available reset modes:\n");
> +
> +     uclass_foreach_dev_probe(UCLASS_REBOOT_MODE, dev) {
> +             ops = reboot_mode_get_ops(dev);
> +             if (!ops || !ops->trigger)
> +                     continue;
> +
> +             plat_data = dev_get_uclass_plat(dev);
> +             for (i = 0; i < plat_data->count; i++)
> +                     printf("  %s\n", plat_data->modes[i].mode_name);
> +     }
> +
> +     return 0;
> +}

We normally try to keep printing out of the uclass, unless it needs to
be in a shared place and called from other places (e.g. multiple
commands need it). Also 'reset -l' on a board with no triggerable
modes prints only the header, which looks odd. So can you move to cmd/
if possible?

> diff --git a/drivers/reboot-mode/reboot-mode-uclass.c b/drivers/reboot-mode/reboot-mode-uclass.c
> @@ -54,6 +54,54 @@ int dm_reboot_mode_update(struct udevice *dev)
> +             plat_data = dev_get_uclass_plat(dev);
> +             for (i = 0; i < plat_data->count; i++) {
> +                     if (strcmp(plat_data->modes[i].mode_name, name))
> +                             continue;
> +
> +                     /* Does not return on success. */
> +                     return ops->trigger(dev, plat_data->modes[i].magic,
> +                                         plat_data->modes[i].count);
> +             }

If trigger() ever does return 0 (buggy driver, or a future async
path), reboot_mode_request() hands 0 back to the caller and 'reset
-edl' silently falls through with no reset and no diagnostic. Please
either treat a 0 return as an error here, or document in the ops
kernel-doc that trigger() must return a -ve value if it fails to
reset. Also worth stating in the header what happens when two devices
declare the same mode name - first hit wins, I assume.

> diff --git a/include/reboot-mode/reboot-mode.h b/include/reboot-mode/reboot-mode.h
> @@ -46,6 +46,22 @@ struct reboot_mode_ops {
> +      * @dev:        Device to trigger
> +      * @magic:      Array of @count 32-bit magic cells describing the mode
> +      * @count:      Number of valid cells in @magic (1 to
> +      *              REBOOT_MODE_MAX_MAGIC)
> +      * Return: does not return on success; -ve on error
> +      */
> +     int (*trigger)(struct udevice *dev, const u32 *magic, int count);

count is stored as u8 in struct reboot_mode_mode but passed here as
int. Please make the op prototype uint to match, so a caller cannot
pass a negative value that the driver then has to defend against.

Regards,
Simon
