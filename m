Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A58606A31A
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 14:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=fzxw08HF;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=huxMyIGw
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6F32B811D1;
	Thu, 22 Oct 2026 14:39:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ge7to-3_BXGR; Thu, 22 Oct 2026 14:39:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3D9A0811F8
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792679967;
	b=Zx7Lz20YfhcHSw59fH54UaKxUhx20ivfFSU8lfZLABe1v3lDvI/CtjYj0zF1m8nN/UhC
	 5od1B5lqF09qJKoqaTTvnBG2be+zHPBVoHjFfzQf28YoCbBdBmBKwKo33BLkebTjac3DX
	 gUcDJLY7MswX9NMzVa3KW2KbUXVbrAu/eFrpeutdv9w1Z8z1mhswZ8UjaRwo4cT4OnMX+
	 GA88jC/nDedVx/wSGpT6Y+lh3i7eTMMR737DtarCAC0qO/tSwcGiKcK5CrLqnqfn6i59k
	 3M3EtQj/KVmLlrGzJbnmfKj6/4E/nTnJxkYzIPpB/K6FwHoZPElnDUgaxTy/Slt6naA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792679967;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=W+oJDpAeNtypUFLUfsWb3mbKb/Hmsp1MzuGVwu134YQ=;
	b=OYCZCmzvuFDUzfMvbgvVVdEFp81f3uvJUdDfJtUlY6z1I7hCt1DulgT6cnbF2JCIO6ig
	 2Kz7W/M8W37YVYwa44/243vHcv5seCQzSegMCwGvNy2nKTTjofyn2kESA4Ph6da9oNu8S
	 0hPirIj4GkLho7OIAjvn001lrPqBLjlcQJGx0N8tSi8rf1Fv4AdTc2q1+5usPVE8pSceM
	 OY0Od2NhCZA1M03eV1CAMVsGGYDY7DQOz7epR7ZiUuekjxjWR3YVVd//EiMFw6PaVRaJq
	 B7exeX9R7veL3q2g40a1byuYRkVE2yPdYrUbzLhElmPHKZNCGu0k1UmUcw7ATvupK2g==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792679967;
	bh=W+oJDpAeNtypUFLUfsWb3mbKb/Hmsp1MzuGVwu134YQ=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fzxw08HFEpBS0BssuBqPU9LcOrVaXkp/apVO46/mQP4Ezz5HsUDkLsbYbu+uRDR8s
	 Jad2s//bUgfVNx1hj/If0lq/GZNqrUorlYuN7zqmlBLb2DteaSIOKVwe7jBcMbYwuZ
	 HkYPLEeu33nb8K/BhR8Rb0SHuh1BWa5QM+z/Wte1ZSyhKdGR4+JsrlsgC48BhFMOQ0
	 2EnVusyABS52df/AdHgzMWWHAhjZgxy04v34EV0oZWsTzqD8+uIkJAfki4fJdol2fl
	 AteqPvAUnxaDVy6tLKGXJ9UUfskzwF4Ty7yv0/41M8/izQIY9C/qvVUEDbSMNdpNI7
	 VcXtpNr+rT0kw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3D9A0811F8;
	Thu, 22 Oct 2026 14:39:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 78B583AF
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 14:39:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5F23140076
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 14:39:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id F4vh5YCAiwiY for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 14:39:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 0EC1D40024
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::433"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792679963;
 b=EzEvQeqXqmii9ueVrg79lpMUKd6837imEIQvSJsyLrdszvd+jRcNg5DJXC2Z+1MGv3cj
 7wqpGL4/gp9Yedj4EZCxjmaUsfoEpZNWxSOdYFsNUTJjsE6k2rhcbmgUi/iMn0a7Z5WXH
 YOmMMqiCKVVqNRFKjRP6GeUKpVxnrVyT3dO6yixjWC1V0RGeQiBUpTn3VGrO4V0IcwAEh
 +NZshBULGD7dNX85QbBc4iu2k5EfkiAs8xEmIT0wl4TP5X/wZBeUlnAgS7b2ox4kXvE2L
 vJ52/M09LXdsXh6Pgglbv49EGusdFQ6vwVbmcLJU3CC4k8zV+DGVvEzfiElRe7EQ/iA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792679963;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=W+oJDpAeNtypUFLUfsWb3mbKb/Hmsp1MzuGVwu134YQ=;
 b=YDZjHFKe5OGZpMe24RMpjvYAlVI5dQmDmIjcak+hZXUJmZMgg0JaSbKZafO/mhjZqcQ/
 t9RMupZ/GPXqJHDWLQWXpE/xsnjjCmBs3rmOsq8D0d9TBN7dx/Dx94oKY4AuS1LvWxs+/
 oJChWnWBb8o3NDmjBO0D39CnOMekINaYkTmNHC3xy60WVERq0oh6DfmfPYUNZ0Br7lx2Z
 LztVzeq+ajbYlm2ej0ieAANG+ZB6ucr33HfUeJ/sRXNdDWaL8fqwTMRl/jWNU9qL3Z0Gh
 sCWTqXBumQhB47+E7SZI0Dfv2Cp4OsIGzu+sx/jDCOaa0E7KYKAPeqwTyd12XLEY5Uw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=huxMyIGw; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::433"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::433; helo=mail-wr1-x433.google.com;
 envelope-from=glaroque@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=huxMyIGw
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0EC1D40024
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 14:39:22 +0000 (UTC)
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-48df4e9d2d4so1195137f8f.3
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 07:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1792679961; x=1793284761;
 darn=lists.u-boot-project.org; 
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=W+oJDpAeNtypUFLUfsWb3mbKb/Hmsp1MzuGVwu134YQ=;
 b=huxMyIGw17mdAY79M0bDfODFFijwT7GyZHEM5OMZej4kIWMCIHaP7WAw6RBCteu2bR
 A0U7yYX0wJmdJp2S4JtwNlZIIj3slVWItTGtW+fP0IfAfjz3dtVm6NY+tiVAx+lnUyey
 HGPKuFhVDbaZxD0JONvm2a0PE7qSgCVhGEGtVPUnosr0ebMyW3vD/xqDLywXuCOoKm5c
 udapg44iiBV92oItLiB1WjLqUr7sVakO38CvvYUdhHmu2XvXIeGzzy35w/ybDevIUEuE
 H6xsOdqfdw5hcYH+H8k4G3Pdl7ZY6Ch+5FXZBiHduh9jVo0m1B2CqiVcctiAz66uU0aI
 TmAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792679961; x=1793284761;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=W+oJDpAeNtypUFLUfsWb3mbKb/Hmsp1MzuGVwu134YQ=;
 b=VfW5bgpewjqkciY6238TqbvX6Sj0U0eVaVLNeRmlkOkK4R5GQU+f0jmpcXhd4Dxpw6
 8cljVA8JPUzGQJtdk+l5gK91uh9QS/xYncVE7W/WU+Wzv4hVryBU0owq0EzN9Yan2sp1
 D6wUFsAv23ItcBosCC+HoDe990CMtYNoYR8S3Syx1D8wdtnG71OW8NI9GW/kyybeJ/C4
 3qnPqGG8dwU1Rq0uWxx5ZgXsj01YuCmppTxo9x9D0LeWdPkcrReZzrtau2ZAdUP8kt3r
 Uy8gnVOqs3T8jk9acfHux2RjodSdG3uqn4zfUiU8HQVQk0CyRfotyn+2GqtpGNY3jwUN
 RNBw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzLj0fH+EZnj9UCWqirEl/5EJeBg64rD0nfeC9dA0kgTjRp+SnleoAhbkvLwTjHJ83KYeyrJ44=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKvVH8YeCbwIVIjmVrO3sfbLpWiU4kUDO9/807WNY/hKJmP+SeD
 34b2Gx008gATxaVuFSaFygNuhoJhvwtmcJ9bETkGUAVJWbJOO4ENv8tbD6TL/cfE9wc=
X-Gm-Gg: AYBFou0y03qmN0UXqmqucuLTwf/KfCjiVxrk69lCfevrdWCxix/baYZZ3lK13niAf0s
 S+XIc0PnTuDBTO8pc63ag4kTZ/MKDlqRd5rQFKceJRpg/ctiLcxAhPrUOaDAbcWRT6wOcH59n+w
 8xCTbiiCNu1aU6ujybVMZi9+u3/yPF+FLGgLPVTu7KyHG3evDksiymxzQHeqzHgdxQZkNWhi9ze
 Q5rnhFqk744k/kQKKiFCnHdhaonM5QAFp54L5m1I477Ro/2+b6NiOfiCBEa7PFSy8bQzCGFNJG1
 v/7+SxovieiBjRZdTfxHIdr//EalxTgW8fi2UEcPnIIW766HWnOmXMfVZohPpQ5phbu4br+Rl7j
 DZNRF0lmPeQGVXMHJUDcyr2/uHMiQYGQMWR3kM3Kyp+IhAzO4a6uBQpHsruByctUfBUq48mkmzZ
 0UlPhtYqNfcxDDYanTlbByijnkwXo8MtqjIL6qYE576cmLNL+UKxW6XQ4T1XTpKespsDApEZ0Pu
 jMWITU+sQx1GFyFsC06KTognr+e7964IjL+He847ZFMnJ504Uxzt32GJLNyZEXz0tyIdoCWyfHl
 0w==
X-Received: by 2002:a05:6000:bc5:b0:48e:cd3:64f9 with SMTP id
 ffacd0b85a97d-48e264e6f3amr9086924f8f.55.1792679960786; 
 Thu, 22 Oct 2026 07:39:20 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:e0a:e50:3860::e1d1:d182])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e25828e3bsm12415852f8f.31.2026.10.22.07.39.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 07:39:20 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 4/5] fastboot: add flashing
 lock/unlock/get_unlock_ability
From: Guillaume La Roque <glaroque@baylibre.com>
To: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, 
 Shahriyar Jalayeri <shahriyar@byteray.co.uk>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Pengpeng Hou <pengpeng@iscas.ac.cn>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ahmad Fatoum <a.fatoum@pengutronix.de>, 
 Guillaume La Roque <glaroque@baylibre.com>, 
 Jan Kehren <jan.kehren@emteria.com>
In-Reply-To: <20261020-upstream-avb_lock_unlock_b4-v3-4-e280795a98cc@oss.qualcomm.com>
References: <20261020-upstream-avb_lock_unlock_b4-v3-0-e280795a98cc@oss.qualcomm.com>
 <20261020-upstream-avb_lock_unlock_b4-v3-4-e280795a98cc@oss.qualcomm.com>
Date: Thu, 22 Oct 2026 16:39:12 +0200
Message-Id: <179267995216.3508122.10818786337323706426.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792679958; l=2208;
 i=glaroque@baylibre.com; s=20261019; h=from:subject:message-id;
 bh=fr99r+r1bCODc/FG/ryIRyvCcGOyaaScIyLa3DPyj4k=;
 b=vE/yqtUr82lHl1ruxmVhcuLx/bIa8edvwwahP3XmlSE8WMyLbhjKZWcFhXoIRj+nidQH1QMNV
 StFj1Kgr/IWAnsUQp5cvIBRE9WEOdJhBmmJBqfI5eOS7DAyjhaBVLZ1
X-Developer-Key: i=glaroque@baylibre.com; a=ed25519;
 pk=nMpSg4NT6M6q143E089emouMc+MXpHO9CWmnEUfjhjI=
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 20 Oct 2026 17:38:11 +0200, Igor Opaniuk <igor.opaniuk@oss.qualcomm.com> wrote:

Hi Igor,

lock state was not done in "fastboot boot" command , i don't really know
if it's needed but in security point of view it could be good to do the
check too, but as you wnat for this part.
same for some other comamnde "oem run"/"oem format"/"oen partconf/"oem
bootbus"/"UCmd/ACmd" probably more.

>
> diff --git a/drivers/fastboot/fb_command.c b/drivers/fastboot/fb_command.c
> index 18d86988f4c9..9d3127ee7a4d 100644
> --- a/drivers/fastboot/fb_command.c
> +++ b/drivers/fastboot/fb_command.c
> @@ -589,3 +627,230 @@ static void __maybe_unused oem_board(char *cmd_parameter, char *response)
> [ ... skip 136 lines ... ]
> +	if (!strncmp(response, "FAIL", 4))
> +		return -1;
> +
> +	/* metadata is optional on older layouts */
> +	erase_partition("metadata", response);
> +

no check on metadat erase ?

> +	return 0;
> +}
> +
> +/**
> + * flashing_unlock_allowed() - evaluate Android's "OEM unlocking" setting
> + *
> + * Android keeps the developer option "OEM unlocking" in the last byte of
> + * the frp (persistent data block) partition: 1 when the user allowed the
> + * bootloader to be unlocked. Back ends without a partition table (nand,
> + * spi) and devices without an frp partition have no such setting, so
> + * unlocking stays possible; a partition that cannot be read refuses it.
> + *

understand you comment but in android source code does the opposite.
https://android.googlesource.com/platform/frameworks/base/+/refs/tags/android-17.0.0_r1/services/core/java/com/android/server/pdb/PersistentDataBlockService.java#790

you dont check if frp was corrupted.
https://android.googlesource.com/platform/frameworks/base/+/refs/tags/android-17.0.0_r1/services/core/java/com/android/server/pdb/PersistentDataBlockService.java#440

> [ ... skip 38 lines ... ]
> +
> +	if (flashing_set_lock(true, response))
> +		return;
> +
> +	fastboot_okay(NULL, response);
> +}

you don't check lock status before so if device already lock you erase
userdata for nothing , is it behavior you want to have ?

-- 
Guillaume La Roque <glaroque@baylibre.com>
