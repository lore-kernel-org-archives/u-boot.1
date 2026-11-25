Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9AA3606A31E
	for <u-boot@archiver.kernel.org>; Wed, 25 Nov 2026 09:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Xgce3EK2;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=hPoSE1Xn
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 38D4640654;
	Wed, 25 Nov 2026 09:57:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id csolTTfyy8kG; Wed, 25 Nov 2026 09:57:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 37258405AE
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795600670;
	b=h3m5VNwP0b1zI9ffNxKXbLy68keJZSPEv8/QMrYSVNDmaAAy48YNGh01dkdOgqrD4V7X
	 V49iz9u/CgxZBYjJoCl3GCV0ohEtA0goIRU/DMlqB3BG9A641jktK4iFIoUzqQywpHOM3
	 u8AUoh7bw+Obr5JuhhYehs9uE3olMI3Iyx6fv7tg6VaoT7hNl91CL4oryRz1sngFACSSq
	 cMT4Y/EbEGJIn0BLThk6ebUhGLm9YDj9IElOJj+waAKy0wTC3W641UUVvM0HLxNmBY0CH
	 a2SO5xXrgnbW+Vy/A19zPPDdP8x0NYu5H/4as5WWSOSLlsXfSpHHJhmTsJkAGKCyCeQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795600670;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Ik1kq3MSVE36jfo1lvjoLBw8++HPEBqQofZ9rDLiyFk=;
	b=pNYE0OX2RxrD5fqBVvcibQb6ukZvYA56+ex83N0Q4dMlHAWblu72Vdz8ScsNvN+Pmp1m
	 7wJbSnht7uis/+TGCotEqPKI8H6BaEOch5FxApuvVoT2kNEbXKi14wNCH6Nmxe6r3RI6F
	 rUtCVTL4PS+rJjVqoaGwrYbeV0hdI3/hl7qqBu9/jAvZFcsN4jhlHVbF8zk09NUn0OryG
	 U0gGziUoZ4isbmLnOOlZylux5Hv8Kn+QJcpRyqxls79Ka/3WDlWHn1M16IkwgTUK45Hx+
	 Qdmdv2VSxAm8ahJAWG/J/UT02V+6xYb/hdOaOz8B5wbS0H0P+WVpQY3smS+tjUZ6KLA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795600670;
	bh=Ik1kq3MSVE36jfo1lvjoLBw8++HPEBqQofZ9rDLiyFk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Xgce3EK2+Xgc93iMaIdB8Fles5DvwfkgBaF//UBU9EW6c1Acbrlk2bGhQJcFCfJLz
	 /Pkcv6JJoKigePUq9pP5HgGLJZAXT6EjRpK4XyOsyABqbGQIx/bJVC30PGHvP+oGKO
	 6A5XgwPcag19wk+LexBBhWhcGwsNmhH+xYnSmsmV+VHCPawuQnq+5h1KgSHD73Vmk3
	 0Z/03mOzKKRtCxm0F+UcQBEN2l4d2KZCyspR0Q6x6cZOYPg0nd7JAUs1tdlwxp1cYR
	 5V4xTvuHdW7jL1X8NDiGdG4KUwgG/YiV9YxzyuyyuvCVaileL7UOyIf862XxL0zZUv
	 YJFZMIPC+UqQA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 37258405AE;
	Wed, 25 Nov 2026 09:57:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 09564311
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 09:57:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EF4F5606D0
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 09:57:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ms3oobfsCw_R for <u-boot@lists.u-boot-project.org>;
 Wed, 25 Nov 2026 09:57:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org CE2A9605E8
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::b130"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::b130; helo=mail-yx1-xb130.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=hPoSE1Xn
Received: from mail-yx1-xb130.google.com (mail-yx1-xb130.google.com
 [IPv6:2607:f8b0:4864:20::b130])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CE2A9605E8
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 09:57:47 +0000 (UTC)
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-67c6a0abc2eso5803039d50.0
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 01:57:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795600666; x=1796205466;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Ik1kq3MSVE36jfo1lvjoLBw8++HPEBqQofZ9rDLiyFk=;
 b=hPoSE1Xn0o/oYbit16sXpYNYQinXwhKUEZkWa066aMbCKUnB77MC8N7921MJQ+wryP
 JZ0tMqrrlR/BK2fDVwjvhJRab6pRS4kPILpuv7Sp61P7NArxQCadzOfHn6KTkEVPKac3
 wSvSVjT8lWEckE+WNCNC42yqq//guSLMTyA02h2EHHvDAm0XF5qROUKTcAX+8FLFRTYt
 4/hprsk3I1xywrdLc8ie8+dhyLNE19K8a+4sfemZk1Ay47lsQXNpZD7ySea7qNQExD40
 8yYFObXARg8JzA4gupXsX/MjwnyAwTwOWjw362/Zm1sS+X9cMauEGH4iBNqUCnMX1LzT
 /4OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795600666; x=1796205466;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Ik1kq3MSVE36jfo1lvjoLBw8++HPEBqQofZ9rDLiyFk=;
 b=KBajN6ZZz6ADQUMduZK9D/wR/HJ3kmuEW9gcf0hpRFI3GNuMcCOBTjcMA0dfeWlhja
 fvja/e5C2KSQePFxnkVYl3Kp85eeMNjTFkctq2yLo1kUeQYadfNkzpglKZV5TEAn6K76
 KMP2dyXmSsxDBciCalnFzhbqlqAl50t2pJSJs5M9ZBEj9JicvIo5//T/x1Td3xwE9MdW
 x9LakWbVlAfxSzvic2F0AgvbaPiuZjJPlia2iqQTl2vQYGZl4JE39Om2+j4hlY2YyRoa
 /8msYDwX/H8AEStmSaWbB1dTOlOuPq3UqAKoyfS6ZG0IPvxXvhOhukGHOVkwZnPtO3Fg
 ADlA==
X-Gm-Message-State: APuU4Z+KhnA3XDZRQw3PHclklKfQ81SpCE3fG/STYmpFdZJXqrp8sHB4
 yCCBa+rY2l9nn9+uahJBh4bgBJ/OvcsfR0/BpzgWyOns5vXVcY5eKooRalxSTKrFhgVzXE122DK
 An4wvFWiosFw2rMR0a6srhPXu7vFO/ZGz3eppGd60Xw==
X-Gm-Gg: AZFdTZfBiI7CwEpyLsms+hSA7S4wvn46Xw12HEpRl9wtpfe5K7Zvgff9u9LvwtKMEOW
 MntSN78b0Ofa8LlyCmw6qosJL4tmI5waA/U4pSKCo+JTF4b4wJAZyWavvvi+81p03hzfz8KF31G
 X3Sthw+oFIcVsR1ysWB2LLfFG0dm4zo7Cx/d+oTfMTL5RGTyDBQ21rdxfG9fQFZbUGGjc74oVPA
 F0Zcn6l/cykpDAeI8ZA4Gybe3QbEX7P+pgHXLHaOnyUefJ93ztwEBroEX6O/hRCPguEn1oaODTt
 ccx90ac+xzKr339+tI3Kn6cav2QWdxO48geWDP6s9dFh1C6X4rl/cMoDF0wCPnUCWN0mT/BaIHe
 jlR6+HFS+gxVqQCFiqAYj8yH5Zdfgyd38e7UCymuurQ7siNZywkiMN6nAkPxKToF2/jvSHTpn1W
 aQPwo0iRx5a7Q16BdINa1W63tgSU/RvNFzwenBVAVoOBotnc4/1FsdOkj7Sur5FAOj6EMwsmhYf
 im4LAF3pTwI/WyGpYnOHEsR5b0XEOWNFlfAhqJRvv6W88dc0FXaETtbinEz6heA9/WcdF+azE2O
 UlvI5/XqGYaumz/mJLOoPJx6BncLsVCRfrDYSGE9Gn9XeNIom7Jrbs8vRSRqQYyc+17tIE74Bwq
 92l8UQX58fJTrXt6lVxC1Qw5kGNMHYkCiVtPyMPKa1wjr7POmJhJmWK4jmT0grnxx5l0r9d1Ptw
 c6uUSvLL3On9vSRzk6PnflL0/VChwIfrFWDJ7/qPHVGSV3srnImZAz53hhD8+XpiVgm56hIrzlT
 Q5tkvzJEy0Q5YfT5E7X
X-Received: by 2002:a05:690e:169f:b0:67d:bff8:c40b with SMTP id
 956f58d0204a3-67df4486165mr5992483d50.64.1795600665870; Wed, 25 Nov 2026
 01:57:45 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261125070629.4108935-1-padmarao.begari@amd.com>
In-Reply-To: <20261125070629.4108935-1-padmarao.begari@amd.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 25 Nov 2026 11:57:09 +0200
X-Gm-Features: Aa3M54ogxOa_mQKcNngt2GhsvPM_O-283U5Tpp4seowBE1cctyG0Q8mlBFm3gYo
Message-ID: <CAC_iWjKVhVJWkRDGTEpgPPM2U9YetD_cLu=meZKR0d4++kxYFw@mail.gmail.com>
Subject: Re: [PATCH v2] rng: tpm_rng: start TPM when probing the RNG device
To: Padmarao Begari <padmarao.begari@amd.com>
Cc: u-boot@lists.u-boot-project.org, michal.simek@amd.com, git@amd.com, 
 Sughosh Ganu <sughosh.ganu@arm.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 25 Nov 2026 at 09:06, Padmarao Begari <padmarao.begari@amd.com> wrote:
>
> The tpm-rng device is bound as a child of the TPM device from the TPM
> uclass post_probe hook, so its existence only guarantees that the TPM
> driver has been probed. The TPM itself is not started until some other
> user calls tpm_auto_start(), e.g. the EFI TCG2 protocol or the
> 'tpm2 autostart' command.
>
> On boot paths that do not do that, such as booti/bootm where
> fdt_chosen() calls fdt_kaslrseed(), the RNG read is sent to a TPM that
> has not been started and fails:
>
>   tpm-rng tpm-rng: dm_rng_read failed: -1
>
> Fix this by starting the parent TPM from the tpm-rng probe callback.
> The RNG device is probed on first use, so the TPM is only started when
> its RNG is actually needed, and only once rather than on every read.
>
> Fixes: e67ffb5aa5ab ("tpm: rng: Add driver model interface for TPM RNG device")
> Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
> ---

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

> Changes in v2:
> - Start the TPM once from the tpm-rng probe callback instead of on
>   every read, as suggested by Ilias. tpm_auto_start() runs a full
>   TPM self-test, which should not be repeated for each RNG read.
> - Update the subject to match the new approach.
> - Reword the commit message. The TPM does not fail to probe, as I
>   wrongly said in my v1 reply: tpm-rng is only bound after a
>   successful TPM probe. The problem is that nothing starts the TPM on
>   non-EFI boot paths such as booti/bootm (fdt_chosen() ->
>   fdt_kaslrseed()). With EFI_TCG2_PROTOCOL, efi_tcg2_register()
>   already starts the TPM before the FDT is installed.
> - Drop the systemd-boot and fdt_fixup_kaslr references.
>
> v1: https://lore.kernel.org/all/20260609101039.584994-1-padmarao.begari@amd.com/
> ---
>  drivers/rng/tpm_rng.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/drivers/rng/tpm_rng.c b/drivers/rng/tpm_rng.c
> index 1a5e9e2e4b4..a03d6539fbd 100644
> --- a/drivers/rng/tpm_rng.c
> +++ b/drivers/rng/tpm_rng.c
> @@ -4,6 +4,7 @@
>   */
>
>  #include <dm.h>
> +#include <log.h>
>  #include <rng.h>
>  #include <tpm_api.h>
>
> @@ -12,6 +13,21 @@ static int rng_tpm_random_read(struct udevice *dev, void *data, size_t count)
>         return tpm_get_random(dev_get_parent(dev), data, count);
>  }
>
> +static int rng_tpm_probe(struct udevice *dev)
> +{
> +       u32 rc;
> +
> +       /*
> +        * The parent TPM may be probed but not yet opened and started,
> +        * which is needed before it can service TPM2_GetRandom.
> +        */
> +       rc = tpm_auto_start(dev_get_parent(dev));
> +       if (rc)
> +               return log_msg_ret("start", -EIO);
> +
> +       return 0;
> +}
> +
>  static const struct dm_rng_ops tpm_rng_ops = {
>         .read = rng_tpm_random_read,
>  };
> @@ -20,4 +36,5 @@ U_BOOT_DRIVER(tpm_rng) = {
>         .name   = "tpm-rng",
>         .id     = UCLASS_RNG,
>         .ops    = &tpm_rng_ops,
> +       .probe  = rng_tpm_probe,
>  };
> --
> 2.34.1
>
