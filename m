Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F4BACA5FA1
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 22:41:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3344F606F4;
	Mon, 28 Sep 2026 22:41:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jxYJC_UStzmp; Mon, 28 Sep 2026 22:41:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org BD69E60625
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790635295;
	b=WuPTnUIii47wxsRD1F5uXhXhyFo/JqD94mhuGZFp1Qyq4tM7xk0Z3zuLI3HZKP8yPezi
	 kJ/jR2VH9aKEGN5M4sPqaCzoSmV7dqaxtKfDkZmOBWZ25hx1bp+Vmderwdh8rGwjmpGXY
	 r2kBst1gYuzgrZHcBAFwuIeb9f5U+zrevjPYT0YM7miBnbFdqkBL+vVtscEQEyGzn1etm
	 KlqGiES/WfVT/FB+WvAjj+3cAqW3MdQk8EyNdy2xRPctfKgB+RHL15Yd7AovISa25sHC2
	 ZYkmU0QxC/RkhHjgVvxkOxbaeUNKSJ4F+3K77wfzEUDncV5ja4ycDhUmDP+YxtSAXfw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790635295;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=o1kZ66FH58wFYcYA/yy1paksf8rPlQYg454q45i7gKE=;
	b=XX2U2HRacojiNZtpkvT84fqsRJwWlX65ZXDlI6cXDfBzaIjiIa34DjCduoywl7jsu5ko
	 mRc17bQLhQFmlxcKKGowjqLtQnNdQYrtvTvENm5kjkCpf+oYWky/DtUZx7MqYdhdfwZ4+
	 yZaAgMGuxUgulqD9H4j35R+J9IIqvJdRzFg25rzGcEqH2VucyuO6kKojWOVKGVu1rklg6
	 NnPNjZOPZcyNzgmm8WoJs+iVMitaUPnYdm/uGu1/yQAQJmLybpuIxdTBe2xYzrSKBJuYO
	 EzaHMSm3zyTO7z2cBqrbNp9HCH2GTw5CCMoDls9nUrygIEU/O2dsVP2ncXpu0sRbYZA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790635295;
	bh=o1kZ66FH58wFYcYA/yy1paksf8rPlQYg454q45i7gKE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UbUBsYMEHxgoMJQgj9aavsOankO/pJsvCyMyjzEtYe2ofYsllkeHCWw9+oLDh4f9U
	 PmSETvyrO9kJirJngq8a1iNfsTPYm7CZzgC7JTNQHJ7NfTvKoGVJdTtWkjes41iNwG
	 qo1n+oxDhh3seI8Pv9GAtXxredNrmC1h7JMmFOnPdgl3KO1maCZlHeUc6fo704Gx/H
	 cb+sHSyGMwS7WLH9UfvbKK3CvObeu381L5Z2nQ2kE0LuKFW4yx66iC9rF6XZlTAlTY
	 fHCumul5Xsc/QBmOSnH3mg+XdfCjyZPi7ttYNyU/elste2lJIfh7qa4gVtgKoNq8Dw
	 GZ5766ZNEnlRQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BD69E60625;
	Mon, 28 Sep 2026 22:41:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id C8B3532A
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 22:41:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A896780BF4
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 22:41:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TFGDGwLpXvop for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 22:41:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 3A1B380BE5
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:33::f"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790635289;
 b=F/8KDhNkHqsWuhgnReCq4OcLbXBYpKDrgFEBACfoSkS1R/mfZBvDbl8PJPcwbifE1A7a
 FGnCnaLKZTZA5545hSvrMclnozrbNAXMHTZS5zdjXLPpGztgckUMw8vvCGw5/w0UP2PJA
 zd6qz3gBUx2AvkDianVy4tFKt9fL0Apmq/yfdhpOsCdF2UIrrwjXGIIJprkXIWbXw0ZXU
 ANhhDjMs4e9idCx3vpfTtY18IykBw5kHhf3vv8GdhChG0iiNuLrDxkqRFOw2DT4K6BBRI
 90mYWyscifEOxjqMe2JTC9toaiSOp0tOOx+PkCbp/qdOj3SxO8/ejpEraGbruR7egfg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790635289;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=o1kZ66FH58wFYcYA/yy1paksf8rPlQYg454q45i7gKE=;
 b=o1z7rYzwXZ+yO+Rt5K29qs0CUtG4DNqa8nyPDj0WxpLOxa0xOkonpMdjJ6H2TraYvU6x
 fPDm/cEjajxDKgWRBsRv/kT+zOcrHWyraT/0JssyZcb6P7DtUw6Qnv8923KMn96zVR9Yx
 ENaxUGHEHy6TD/jxBbJHbpNxnzIBKc82UaWUjRfOo6roBfKPXb43zBqOq885cGtLo6giL
 Q4lQRhf4ncOoV7Gn+rYgOaxnCUzpLKKPEbJBLC7ZXHBbosLakrVwvNCAca2ke0QgSkzC9
 s8bYAY0H8lz5Ks8+/f8hVFZz8gQxSVZIcHVwSWcKMHq0ByrOj9z91Yqzeehf3Shkf0Q==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=k9abp9G3; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:33::f"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:33::f;
 helo=mail-ed2-x0f.google.com; envelope-from=sjg@chromium.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=k9abp9G3
Received: from mail-ed2-x0f.google.com (mail-ed2-x0f.google.com
 [IPv6:2a00:1450:4864:33::f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3A1B380BE5
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 22:41:28 +0000 (UTC)
Received: by mail-ed2-x0f.google.com with SMTP id
 4fb4d7f45d1cf-6aa1d00daaaso6198629a12.1
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 15:41:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790635287; cv=none;
 d=google.com; s=arc-20260327;
 b=kdIZiIRyrqlqK0XA+DRt3PurGxM65o/0kDg+qI4ZQJmeCR+W5wUEAGUZhg2x51a36q
 33KQrQeUGqkBMflyyhVAOkc/NDyZ6z10M5yrWJfZHkg1Q89SCpDh9LRXHPe1AJM1MFfm
 qYg8tgQBTvJhqylzYC5S1H/mY04u1c63IBmql/AKkv82WbJGgED+7hxer17+SiyBG8Zq
 90pAGwfsJCVKQeSDvYvAJVsXftJsM1ZozHR8nEY2TuCrxinuEC7FWRzAhgZgIBOewRE5
 g1nMFpPLBAdhIdatmmutNGOI4loSmnX3kgqcx5rpb4D7cpLBiYyybnUc09tRxSAArxLE
 6f7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=o1kZ66FH58wFYcYA/yy1paksf8rPlQYg454q45i7gKE=;
 fh=hco1ohzOnzt7GJfj6TJD96K5wA9rhEu07BSOFaxfEoU=;
 b=qdSOn7Lxa5JmWiyq+H+mjoAUOaXnMtPk5YfzKUm57lu/L8QtO40Nsz8eD8ruCUcLOC
 vH04EM5ZVbDfjathwDXhKIUT/sa6xF+Rm9DFGC9pvf2sA/H7XIH8ieXun7XtC10sFuMM
 MeiYvMKqqgOHUS4QgapyJZlXPBCMecqAFjBrsMK25rAFFWLFE5GazjnlldgirVMBhQ5L
 HV8o45fTpNi4qaqV+rZhvKv3vkRH/iTnOc2ryXkrKqZCEt17EgshIQ55SOuyp4q6kDkg
 upDFTtzX0Z5wm2Pff2GuwMrG66xGl/uiwR48WZnBrhL/0FXbW7HgsgYTxu3B0vbWI/Ii
 EKPQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1790635287; x=1791240087;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=o1kZ66FH58wFYcYA/yy1paksf8rPlQYg454q45i7gKE=;
 b=k9abp9G348SjkB8a8g8lUOrW+reyNWAhi2YaWFdrp9EUr1M+rR7JNoV7EF9/go8rwL
 Kxj3q/zCiVD6i0rAngacYCDcHre7CXrIqYyMqMDX6FRJwLsb8zNoW1YATsDOZoGwCUzN
 zxDc6hhyHoZewJ7khlbMqq0HuXZrMe9Rw28Gs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790635287; x=1791240087;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=o1kZ66FH58wFYcYA/yy1paksf8rPlQYg454q45i7gKE=;
 b=tIr7V9XAIH9XTE5/niT2g39Gcexxz7QO2o7IbB9lzEEtes+s753wdXtxC/u8gHOzPE
 VEJ2St/34R41OgTWPgvP4PnT7dAq0r5VrU1c0MOy7K06c6XYHF8ymYqF4vG1eQGLaL/M
 BZy6gqnvifsTC/RcNK23mKu3sdng4kcs8lC1bbQwt4eO49TjatmfujuqVYbSdTlrMU1G
 tpYYwshfzlAhEBkju1I+uuAmPcOrLKM8XjiNer3z3hH1VErsTNwKu37OM5/R0Xv3LBnY
 VoeEevYyw9AOhN3gNYCGdGZ3cg0/sPZaaRq0t/z1P+gS1myXLSYvryM21H6Yxtcm8Ku1
 /BxQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBympZCjqDY7i3ok3UYrO7ysd2aIoTheS2/a0bD6PERARMPREZoF7axWowhAJK+10sh96N+02uo=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIlMpQKdtrCxsy2wBn7RzoHwaDoKYf2qwyul5I2Juqn5CxCuE6a
 NB1dewsow4XX8QpnL6TjGAYuF27YUbwX9qQloX0l2eIEBeHM46ASbRyKSShDPY7mGJdlzm1DDF8
 ytT5ypgjrl1sPXGLqMZ95+TBqWYAmYUphvAfRzr3E
X-Gm-Gg: AYBFou0jLgreBPfVPCdJhsl/iznC+GkXAC+tmsPJo6umyHURBhT8yhsqoF9daejgiuW
 8ELcwmKt6+EUOOQQFZ6WJoIA1/yZkp2K232jhb7SbTP93/EL21pxKHBzWyzSuqnKPLPH9/IzDrA
 mFRJsr32U5pbVLXzXdSyG+4pJY3E4sVE2t9ad1897ET+GMusVUvh5+Qitjj7++gX/E0ZVVlWcai
 DNRS473cm7zA1cXze9Zp2aXjafJM26skw6e+8F58428YK0z2OqnnqJ7rIIk7rv1uYl6mxmg+2Z3
 ck0rUUu4jm6L7l4PotocuWaR+MnZ7B/knY0LBptCvAAvzzWKG1cBeHWXjQQo0ew0GeK3
X-Received: by 2002:a05:6402:a295:10b0:6aa:f11d:b640 with SMTP id
 4fb4d7f45d1cf-6aaf11db828mr5440735a12.35.1790635286698; Mon, 28 Sep 2026
 15:41:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260928064041.1432227-1-sumit.dhami@oss.qualcomm.com>
 <20260928064041.1432227-3-sumit.dhami@oss.qualcomm.com>
In-Reply-To: <20260928064041.1432227-3-sumit.dhami@oss.qualcomm.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 28 Sep 2026 16:41:07 -0600
X-Gm-Features: AclHuK8cwe64GHFkrQ0UabzH2he5f5aU0r1cZBDRPRwj9cRt_3lUV609quz7DAY
Message-ID: <CAFLszTgFsfJE6jR7=Ldr2ikz1G=AYk1u1Lck1FA4CLd1zzqVrg@mail.gmail.com>
Subject: Re: [PATCH v1 2/8] disk: part_efi: support writing full 64-bit GPT
 partition attributes
To: sumit.dhami@oss.qualcomm.com
Cc: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, mkorpershoek@kernel.org, lukma@denx.de,
 marex@denx.de, balaji.selvanathan@oss.qualcomm.com, jbx6244@gmail.com, 
 vandhiadevan.karunamoorthy@oss.qualcomm.com, 
 dario.binacchi@amarulasolutions.com, sjg@chromium.org, pbrobinson@gmail.com, 
 quentin.schulz@cherry.de, varadarajan.narayanan@oss.qualcomm.com, 
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
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

Hi Sumit,

On 2026-09-28T06:40:33, Sumit Singh Dhami <sumit.dhami@oss.qualcomm.com> wrote:
> disk: part_efi: support writing full 64-bit GPT partition attributes
>
> Currently gpt_fill_pte() always zeroes the GPT partition entry's
> 64-bit attributes field, and only ever sets the legacy BIOS bootable
> bit.
>
> Add a new CONFIG_PARTITION_ATTR option that, when enabled, adds new
> fields to struct disk_partition along with their accessors to support
> writing full 64-bit attributes.
>
> Signed-off-by: Sumit Singh Dhami <sumit.dhami@oss.qualcomm.com>
>
> disk/Kconfig    |  8 ++++++++
>  disk/part_efi.c |  9 +++++++--
>  include/part.h  | 30 ++++++++++++++++++++++++++++++
>  3 files changed, 45 insertions(+), 2 deletions(-)

> diff --git a/include/part.h b/include/part.h
> @@ -76,6 +76,10 @@ struct disk_partition {
> +#if CONFIG_IS_ENABLED(PARTITION_ATTR)
> +     u64 gpt_attr;           /* raw 64-bit GPT partition attributes, if attrs= was given */
> +     bool gpt_attr_valid;    /* true if attrs= was present in the partitions list */
> +#endif

I don't think gpt_attr_valid is needed. Every caller of gpt_restore()
zero-initialises the partition array (calloc() in set_gpt_info(),
designated initialisers in the tests), so when attrs is not given
gpt_attr is 0 and the memset() in gpt_fill_pte() gives the same result
as assigning it. Patch 5 also uses disk_partition_gpt_attr() without
checking the flag. Please can you drop the bool and the _valid
accessor, so the write path becomes a single assignment?

Also the comments refer to attrs= which is 'gpt write' syntax; this
struct is used by all the partition drivers, so please describe the
field in terms of the GPT entry.

> diff --git a/disk/part_efi.c b/disk/part_efi.c
> @@ -531,8 +531,13 @@ int gpt_fill_pte(struct blk_desc *desc,
> +             if (CONFIG_IS_ENABLED(PARTITION_ATTR) &&
> +                 disk_partition_gpt_attr_valid(&partitions[i]))
> +                     gpt_e[i].attributes.raw =
> +                             disk_partition_gpt_attr(&partitions[i]);

The CONFIG_IS_ENABLED() check is redundant since the accessor already
returns false when the option is disabled. Also raw is a little-endian
on-disk value, so this should use cpu_to_le64() (and le64_to_cpu() on
the read side in patch 3), even though the existing bitfield code
doesn't get this right either.

Regards,
Simon
