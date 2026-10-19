Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FF90CCF2DB
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 13:33:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D3B7580C84;
	Mon, 19 Oct 2026 13:33:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Mh9COuQ3myN0; Mon, 19 Oct 2026 13:33:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2567180C45
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792416825;
	b=PtvcKWcg3hQ49DOIhLl1xETOEHXgd/PNTl09oqDs9vTE+HPPs/7V62M/bMl9CBRCTBii
	 Lgx1DzMPNpH2qn2PXqylCkr1RZSsPSLXkOOH9T7f+GNNVx07gSO9D33djeeapTL6JCOgf
	 oJX4OgRL/qJw+luGkApF8UssXWCZ+3uQk9vEcKUpxhjdslZudaJV67ytKeOCJFylZllIX
	 jz56mB0cm4xdliAbztyh8qnJaT7uQxI0sE7zNBNCFIYGRP7kj3Uri0qcvJNyJgNnOBXqr
	 EDQ2JHciKg3i76vPB+CGTWixP/XMk9Q0Pn8ryboRLatLgU0yLB8mUvu3j/udwG4Wp/Q==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792416825;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=j5O+/9KsSb6InelgmBN4/p/cq+kAn9HiTk5gJ2OGG44=;
	b=pS8cfvkhCf/8jkM0DQNgD/4sPNTgKSrGNYtsIrsnLnH0NVqMAUA4cqdl6fGprXRHug1A
	 pBZbUE4i5ZM0BppMYAGsz+6mYUvo1XnsrirAL9/+SctyhNOwARFeplolly1m5msg8Dp2/
	 f3At3DLTthdQzXyALW2XGLdJrpGITW+iuwB96cpkp/cWsHg8lObs1X40sMBNAQMuOP7XR
	 5FeSRohtMH59mnjBzW/O1vPZ7+9874nTY0c80q3ykpCBXHgQMAxhhNswUO76YFqU+8HVW
	 C1X+LlMJWqbSj36zaQ1zXJse4nbSyBbEqw1TsRTYHTGctSjiVDuEth7Na1K4Dwwe3Tg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792416825;
	bh=j5O+/9KsSb6InelgmBN4/p/cq+kAn9HiTk5gJ2OGG44=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ninfOWabahYUc2x9Q2aXnc4RSynfCtkTeKBkBeM+/PzerMKU7luNrl045riF16WMZ
	 zNCB9xAD20iy3/OBcbGHS4GXpHbZ7FFxuOtgxO78Znb/F/rjpOEvKZcF8ejYHQ7KnF
	 b2u0otcNzT/nSkyIPOSMSDfXZbvn4o0AiV4aUOqr6JD08Y/qWHBpXxYjt+rL6JgWGv
	 kqu1Btct7QC/HZ3ZptmFLZNWlCwYSZXkb4isrFihzF3GMI3YR1FDeucUJg6yGlqM7D
	 ye2tGeyGECBXeidRlGv39h32t5L7pxvULa0j8ap7nztRoMT+4w4KJ22UhqzvTWevVr
	 X/CyZOqLbvEWg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2567180C45;
	Mon, 19 Oct 2026 13:33:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 871341AB
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 13:33:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 503824052F
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 13:33:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RDH8J1Z9Eclz for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 13:33:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 54066405B9
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::530"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792416822;
 b=NF7dD0RGU0UcwCtRn+l5/kJBMfCYJ8PAKcGp07FDB/S+e26ZVOWWqYrUBLuH3s3fMJfV
 8AtMLUoGgxGSAeVcuQj8uhzfyM35bCbTLZFwiT5H2cJABDMRF0b6jgnwFmzfJXyNKT8T4
 STcoeBjOeASZ72aQCib58720PPzrSvLj2/YcgKcWyyLZkMR4adrPj8urdRzDf5wF2aiTR
 axxEX9Pm2Lfz34lYGM6mArMrO0Sn5vI/nnTXi91OaXFOH+POKa4ae7eQjuDQCrlnm3DOQ
 ZoRJ5wDrOtJbyIEDhLFJ5WOPyeqS7br/Jdullp2nQoPPpjxrDRQISyTTCqEG+50oV+A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792416822;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=j5O+/9KsSb6InelgmBN4/p/cq+kAn9HiTk5gJ2OGG44=;
 b=JWDkBp2hwAJJkSYT3mCzyLFaYI/nj3kLVB4FZhEiDaaHjqRxk8IGsNQq7PTMFZE02g52
 F8vFdghtAfJ05D/WmWGAAPqWu7pQW4qvHwmd+E2pB/hkaXm6W8z+0mcqGUf9TZ1lXPaL/
 ocFqzo8qH84A7/9KrMNo1anzOULFW4gX3HfAJ56vQcVZG81TzDNjbQ8VE5NHwh0qR+60F
 4zp6Kvs2bXUnt9TGDdbypw6EwO9fGzHLipp5uE2FljwBNlfwdtTqEqTixNt5yGkkNkuGg
 s390bsQ11QvHOz2DdKw0bVAxGaiTcCQiIQ29TfHhgZWY21c5nyaPh86GeQ52D9dsbew==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b="K5BBJt9/"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::530"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::530; helo=mail-ed1-x530.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=K5BBJt9/
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 54066405B9
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 13:33:42 +0000 (UTC)
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-6a0a4aa99bdso2388531a12.1
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 06:33:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792416820; cv=none;
 d=google.com; s=arc-20260327;
 b=iUAk9YDvV3KWvv2APKA8K5URERx9R5GcnXJ3rmReqj+ecJEHiF+D7ScT69JTib0iqq
 N9iLXRB+h9X3f/Rgtph2HtiGdFV8+GFaMKp0c6g7JHva2EY0O1H1jl5WMjhMuXFCGDJS
 jemYw1PwRiDVgsu/NwAXKqthauVSTxj6OxR54qKKoD0RahzhOHPpE6dzYp6ssjfSKCI8
 QpdBuhQTgPkImMEtxrcicQdO3wbw3fNqQeKVFotHSdzPgLoXJsmfJb3Jqu6rqXinWdrY
 An3lmwT03ROTEpYSoC91JWlHQMYZ3a0+YRhuPgzterkAEnlu3BsdApakjrdmIRIx0CAS
 Je4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=j5O+/9KsSb6InelgmBN4/p/cq+kAn9HiTk5gJ2OGG44=;
 fh=i2tQHTfbjxCsmvhnoxB9qnRhfzM8iCx7s7bfzE6Yn9Q=;
 b=NSlzh8yuHodj5x4H94pPlAx9+QgYu900yKtBhYKrdkixxSWjPA49+0dr4gV7n4Hkkc
 jEFXkl8cdq62xqMTO6OD0LBXjepqmbB6PCB5i2pYgTHx6rP6fGFlmx4dlO5TWCfU4Ti/
 cB8vRvOT312EF4zvsvz/KsKUQM/cqhTj9deFC5aFSPZeW0zpbfhKzzYJ9IeAuNq1lhEP
 L9NRS26wPQGqR7fq7DQN03LDp3gEATrJH5xg0KUY7eC1Z8RoI5FhD6JlyAk6pJFOssid
 YipRnCk2HFV5KQnV6mzAAJJYIUYDFoyYmYMQ46gRXql6ALTDCVx0BD79tDIE0Yh/EgIl
 vcQg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792416820; x=1793021620;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=j5O+/9KsSb6InelgmBN4/p/cq+kAn9HiTk5gJ2OGG44=;
 b=K5BBJt9/aTMiOhKwbqb5dZLX62p117nFIsFoSzoHJiQGA9WBEicaBKNp9nS149ahTq
 gD0R+xFPQBqbXcHqzl71hTZsf8GbtuWxcEhS+Tfh7OoSSbAMBBm91tbwQOSxWgl2aLBF
 i69Kjqtit0pz//p6GakifTUR89C8K7byIFB2w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792416820; x=1793021620;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=j5O+/9KsSb6InelgmBN4/p/cq+kAn9HiTk5gJ2OGG44=;
 b=e22Ul7G3eVrsngJaMT9tgKIuU/86oIknA5bdyxijgVOqniJgAHs+V3bvdlfLmdwsGo
 8BLObJWKtlgoWbSI5x5MoYnxy97ROcqBavwv3aFXf7xpeoM9EtWhz7GTPgD3fsDlWog3
 FEUXNNr2v2BiqOlmeI76pShV57O23KTe1RZoyt98+hm0HY2PVJhp/RTyLvXivIisLd7z
 vUX2zMo2X0xxY35DqojWDmZg3C8/qP0bwAbkEzQYBI60g4BA3Gj3unxY3S9YBSVCeC1C
 03ECqBNvXckWF1zbTOvzQgtA9FrB0NSLXfJDbf511hyEEChQZuUu+me4seH2w75ic3cl
 Tz6w==
X-Gm-Message-State: AFq9FYIDzqnLAzcDyUa5RMUAJJUE2hD4P4uFKzWgcbfQJ8ufE1Af40UY
 23LT/04bgQIG9McBQsP7rSaC1wqyM1s8xSCi6Hsi1c0F3YVdkEnUcfr04he/5Z3b0EJuhIJ3Zge
 f4sScptjAgEBW1Us94dQ79dCX857CjBBE3h/aeBiL
X-Gm-Gg: AYBFou3uouHKT2XHfE/RQ4YRSOveyiFFQYT185EgTM5ZNyiLmHY0QYHr/HWYzRoVA7l
 YeS9ldKzdEb6wXsrfXhQqTSUNiNJHKnpCSWqgNFeeBbGg8ph/G8rY0DX0FXDfMo4jua5dOrmy4B
 p/uii2cy2fheQbHJuySAgLyDpNWUlsTcw3WPA8DLD0SSIfsICalQwGAqyw5/94yr4tKP275SZ69
 vPQfdGrFam64PwgvxhS8XSoVwXB9ATzmBzSd+rudc26sFz8QjBOOE5Hk6o9c1WiLWwPhr/X2FKD
 Y9KsSqNWX7PCQmRc93Yv2k39xYf5ODja+PeyseO7D2E08I2eNHw3UQ==
X-Received: by 2002:a05:6402:234a:b0:6b3:dd6e:3dca with SMTP id
 4fb4d7f45d1cf-6b3dd6e3f3fmr776441a12.28.1792416820045; Mon, 19 Oct 2026
 06:33:40 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 06:33:38 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 04:38:00 -0700
MIME-Version: 1.0
In-Reply-To: <20261016-ccaione-upstream-fdt-fit-v1-3-f6286ef82364@baylibre.com>
References: <20261016-ccaione-upstream-fdt-fit-v1-0-f6286ef82364@baylibre.com>
 <20261016-ccaione-upstream-fdt-fit-v1-3-f6286ef82364@baylibre.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 19 Oct 2026 06:33:38 -0700
X-Gm-Features: AclHuK9IsevAYn3vJ516ZUiMPTJ2U_hzn8zclkfK-cb9d_pIt7rYS1FVgUntDRU
Message-ID: <CAFLszTjkGkiSNeTTvw=eSAmVguO8A37X5CjsJRbGZ1ZQVWE9vw@mail.gmail.com>
Subject: Re: [PATCH 3/5] boot: fit: let callers choose where to place the
 devicetree
To: ccaione@baylibre.com
Cc: u-boot@lists.u-boot-project.org, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>, E Shattow <e@freeshell.de>, 
 David Lechner <dlechner@baylibre.com>, Ahmad Fatoum <a.fatoum@barebox.org>, 
 Julien Masson <jmasson@baylibre.com>,
 Vitor Sato Eschholz <vsatoes@baylibre.com>, Randolph Sapp <rs@ti.com>, 
 Anton Ivanov <anton@binarly.io>, Daniel Golle <daniel@makrotopia.org>, 
 Aristo Chen <aristo.chen@canonical.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Jerome Forissier <jerome.forissier@arm.com>, Johan Jonker <jbx6244@gmail.com>, 
 James Hilliard <james.hilliard1@gmail.com>, Vincent Jardin <vjardin@free.fr>, 
 Peter Robinson <pbrobinson@gmail.com>
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

Hi Carlo,

On 2026-10-16T08:36:59, Carlo Caione <ccaione@baylibre.com> wrote:
> boot: fit: let callers choose where to place the devicetree
>
> If a FIT specifies a load address, the loader writes the base
> devicetree there before processing overlays. A caller which wants
> to prepare the tree at an address of its own cannot prevent this
> early write, even if an overlay later fails.
>
> Allow callers to prepare the devicetree without writing to addresses
> specified by the FIT. Alignment and decompression still take place,
> so the result is ready to use. Keep the existing bootm behavior.
>
> Signed-off-by: Carlo Caione <ccaione@baylibre.com>
>
>  boot/image-fdt.c | 3 ++-
>  boot/image-fit.c | 8 +++++---
>  include/image.h  | 7 ++++++-
>  3 files changed, 13 insertions(+), 5 deletions(-)

> diff --git a/include/image.h b/include/image.h
> @@ -719,6 +720,9 @@ int boot_get_setup_fit(struct bootm_headers *images, uint8_t arch,
>   *			name (e.g. "conf-1") or NULL to use the default. On
>   *			exit points to the selected configuration name.
>   * @param arch		Expected architecture (IH_ARCH_...)
> + * @param load_op	How to handle the base image's load address;
> + *			FIT_LOAD_PREPARE ignores it but still aligns/decompresses
> + *			the image as needed

Please mention that load_op only governs the base image, since
overlays are always loaded with FIT_LOAD_IGNORED, and point at the
enum for the other valid values.

Regards,
Simon
