Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C769C5AD5A
	for <u-boot@archiver.kernel.org>; Sat, 15 Aug 2026 18:44:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2057940854;
	Sat, 15 Aug 2026 18:44:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uciK2DTyagGf; Sat, 15 Aug 2026 18:44:32 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 239544082F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786819472;
	bh=b4m3L0yaU40yTEsAflmpiTcHULWn4UPaJDLMEkOXa2Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dmdQRit0TSbZJdbX98oU/dQpCcqqpv50kPLLCEPtYZLhB0BhVuWDaWCJgVc6PEDWc
	 mTI/2IWRdjz7gsrA0B++URvzl0KX8fdg6jjQHHYsAbMaqQfidWjp3aLZdX2F0jhsIZ
	 8nCybu2vudQRYYxGIa7vW9gp915fU8FH7YXY8nCKDKIs6MerZnhIXg9JhVDN/050RR
	 HOUCjOZMfxHg8p97x03MP4dpWUGl2Wslpnqwm0QjP3YJV1OO0gLZFehgawN9pluRmn
	 xtI5LM0y3SQVY5mjQFTMJDYDaws6y8SNZ8gMbn3btvtEkM4Wf5GSayb6dcOjUiXK0n
	 loPt/+UUCJSQQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 239544082F;
	Sat, 15 Aug 2026 18:44:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5D9ED2BB
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 18:44:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4410260644
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 18:44:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h2EldzI5zmTW for <u-boot@lists.u-boot-project.org>;
 Sat, 15 Aug 2026 18:44:30 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52e; helo=mail-ed1-x52e.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 2D35A60641
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2D35A60641
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=FH303gHb
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2D35A60641
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 18:44:29 +0000 (UTC)
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-6a144c8eea2so3337641a12.0
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 11:44:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786819468; cv=none;
 d=google.com; s=arc-20260327;
 b=GQTrJN5Tc/4wSXupH6SrLH70eOjwm8eCjf0jX7OVkYIFi2mma29uCDxsiqdE9BPl/R
 kzIb8un/OAxn9Ep4vlmmlyeRu3w4mKz3pSdRchZ+hftuNSjJ0nySWTj0vFebcrddou7J
 CWuoOq8tOH7oLNL52aREmYh1wcVLYexyx2PRZnxjaJfOSMXJGnVkrrZHb5KtlpGH7o+k
 wzO9eQhZWq5izV2fYUPEDtZTavZyjNXIJ2WwgJGnas0kllYSyA/l/q5sEivPwe+Ypw77
 EJ3EYh7zLAe5LCqtuYv7w150yrOmh1a11qjNdEcnNFc/tKnfJ4IRZMxYLYpFSTU+gk2Y
 WQKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=b4m3L0yaU40yTEsAflmpiTcHULWn4UPaJDLMEkOXa2Q=;
 fh=lMu/IoIlTfGI1wvkQqdTjRQJTv1loZZGdihE0p1XJi0=;
 b=cwTnbXjsPgLKugm8XdqR3vLQ/QRzjtdwFNBK0UwbjusTuQVfkHXUp8ufzosEkuZsyl
 IF33TjsZDLrFF9zYQpO2pMCbluczD0fc6yLNeb62qk196OFraroR/KOgP/BBJYq2eR7R
 vAcc0F7l9gd7w1aU/60aGA38dXcjX03Acy8qeVVnmP0KP9iIOIzvpvbV9xFI6PQmkb/T
 pQ3hLQZcW38WzLQSNk8a52ZmbzP+ilmi7ctMOq8Mcn6usAgqdBrT+i8i5Qp+phGV9CUo
 o2smfQqKo7F0w1luBYY27k7d0ZVJ/+d6tv21PCn2zw1wU1klnHYPxGQE1Fsd9AUXTMEC
 iqig==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1786819468; x=1787424268;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=b4m3L0yaU40yTEsAflmpiTcHULWn4UPaJDLMEkOXa2Q=;
 b=FH303gHbhKqEQeCFifIowQOGK3QFj/dKQffF8YyM0bqn+dNFwZ975IXfLDkJpISnMz
 unFNSDkpXG//ulqoSBhMTWfSRTuf75eYjpc1vdZ0woXXMhhmEr9mJPwYirDJYdTj+VKv
 ccA81MUNyo4U8/UEiXkTfUKHS1Oo9PRWKpwQA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786819468; x=1787424268;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=b4m3L0yaU40yTEsAflmpiTcHULWn4UPaJDLMEkOXa2Q=;
 b=SY8tJJwOrSuaD9GAPOj9qTtbzG/MthZcWWm4BKxLxUWrshvvaILINCecIr+0h5P2tL
 2SXXiFj1VoBUb4RkRfAxZYM2bmjgZn7jJkHaQ6tj2Drc4EPqi6lYH534FRnvH2bhVJJ1
 ncNc5GY9V4NMJtjI+sYfx7dbGoENAXKpWab1dYckuQmdVRrR+RHSfSaA3gqHvroukani
 H/qldwOitMF3QXZyoThY/4I5Oq6vw+Sdb+KCRk1RfA/mNKrTCLAW4G0DCymWaB96rT+y
 SMwpvm5Pe6yuGnYs9uQx0hLJ5JBewXFAWjK7/KVFa+Afc1c3YxBZm0oje9U5DiVIsiii
 5O1A==
X-Gm-Message-State: AOJu0Yw/6yMJZ+HZ5BmhIfu0Uuq0uRuoWbCrs/abWnnyj3/rtKcGkaWU
 h6xzFxXjapuZ4m2DXNU8msZH6qeZ1xZAdgosKBI0gfVXRyRuPe7U1JF7pLRwVQzuxSkbSMlkqa0
 hFhJ8tzbCeBW3yc6jC2ljG+GcWOXPOQrPzkx2qnOc
X-Gm-Gg: AR+sD11r6Ng/Kq6LmCBaHwmIW1R+LgvdellEmQiuwqtsI0dHecFgnbU0w8GvMV91Rgs
 pXK1GQVWPLo4shWOxA/RVNCazBz4xOSFPeAjTyYwlvFAMQUcyIGs0BmRQpHRNUuGoGoK0NRc8Jf
 J7IWbmvFojsJQ5PBAHnoJUelzgD6t9Ml9uNBB8EFPlIPAwG+HXw/phFjOB8hE2PIlqNgzPrTp4x
 ZlMYekllMUbFi7skYlKLtrv4bQoBrVHGctp/hmU+yeHrF3Agco6Z3Ul5JYUcAkPU7EO+sZdz+RT
 zK7eOV5n+OLwnVZIhRxvE8rNxidwiRLdO3k9nCW7Q/o=
X-Received: by 2002:a05:6402:2381:b0:6a1:854:e75e with SMTP id
 4fb4d7f45d1cf-6a38a97fd22mr5703255a12.15.1786819468082; Sat, 15 Aug 2026
 11:44:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260728-ccaione-upstream-ebbr-v2-0-4efb529140d6@baylibre.com>
 <20260728-ccaione-upstream-ebbr-v2-3-4efb529140d6@baylibre.com>
In-Reply-To: <20260728-ccaione-upstream-ebbr-v2-3-4efb529140d6@baylibre.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 15 Aug 2026 12:44:16 -0600
X-Gm-Features: AcwNN1VNyx-GKiyyGLqm-G2mRmqoFt1Vo5qaPH0rFSwG6df9rqmkJD-DTTjHGDU
Message-ID: <CAFLszTiJ_ksiogKHWJBZKbGz+i57dNUBcbwRyaYMyuJaCq-VLg@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] bootmeth: efi: use the firmware-owned devicetree
To: ccaione@baylibre.com
Cc: u-boot@lists.u-boot-project.org, Ahmad Fatoum <a.fatoum@barebox.org>, 
 David Lechner <dlechner@baylibre.com>, Julien Masson <jmasson@baylibre.com>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Quentin Schulz <u-boot@0leil.net>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Johan Jonker <jbx6244@gmail.com>,
 Randolph Sapp <rs@ti.com>, Daniel Golle <daniel@makrotopia.org>, 
 James Hilliard <james.hilliard1@gmail.com>,
 Aristo Chen <aristo.chen@canonical.com>, 
 Peng Fan <peng.fan@nxp.com>, Vincent Jardin <vjardin@free.fr>
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Carlo,

On 2026-07-28T13:20:42, Carlo Caione <ccaione@baylibre.com> wrote:
> bootmeth: efi: use the firmware-owned devicetree
>
> When a firmware-owned devicetree source is configured, stage it at the
> same fdt_addr_r value used by the normal EFI bootmeth fallback and pass it
> through bflow->fdt_addr to efi_install_fdt().
>
> Use the shared helper in both disk and network paths. Only -ENOENT, meaning
> that no source is configured, permits the existing ESP, network or
> prior-stage fallback. Any failure after a source is configured ends that
> bootflow.
>
> The firmware-owned devicetree is complete and authoritative, so do not
> apply extension-board overlays on top of it; those combinations belong in
> the FIT.
>
> Signed-off-by: Carlo Caione <ccaione@baylibre.com>
>
> boot/bootmeth_efi.c | 45 +++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 39 insertions(+), 6 deletions(-)

> diff --git a/boot/bootmeth_efi.c b/boot/bootmeth_efi.c
> @@ -130,6 +131,22 @@ static int distro_efi_try_bootflow_files(struct udevice *dev,
> +     ret = efi_stage_firmware_fdt(fdt_addr, &fw_fdt_size,
> +                                  &bflow->fdt_fname);
> +     if (!ret) {
> +             bflow->fdt_size = fw_fdt_size;
> +             bflow->fdt_addr = fdt_addr;
> +             return 0;
> +     }

Just to check: distro_efi_try_bootflow_files() runs per candidate
bootflow, so on a machine with several block devices/partitions the
firmware FIT will be re-read, re-verified and re-assembled for every
scan. Since the source is fixed by the control DT, is there any reason
not to cache the assembled result across bootflows? It would also make
the fail-closed policy cheaper to enforce.

> diff --git a/boot/bootmeth_efi.c b/boot/bootmeth_efi.c
> @@ -279,10 +314,8 @@ static int distro_efi_read_bootflow_net(struct bootflow *bflow)
> -     fdt_addr_str = env_get("fdt_addr_r");
> -     if (!fdt_addr_str)
> +     if (!fdt_addr)
>               return log_msg_ret("fdt", -EINVAL);
> -     fdt_addr = hextoul(fdt_addr_str, NULL);

BTW this will reject a 0 address, but that seems fine as it should not
occur in practice.

Regards,
Simon
