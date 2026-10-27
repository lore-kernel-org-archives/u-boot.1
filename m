Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E9F606A31A
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 13:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=kD6xJsSc;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=oBBgG4Jd
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0505840608;
	Tue, 27 Oct 2026 13:28:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eJxnaQOhjLar; Tue, 27 Oct 2026 13:28:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 29B1C40609
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793107691;
	b=NORXRabSGP6IA8l9J/agVa4JYKFZiUIimtCUjZDjmtdlsBLeYg63eJxq5uwnXrXuD3H9
	 qgx/yhjqB7/guCl7UVH4+Lu0XBHt/Yjk9ZBBcFwvGXSl1/zmzwwB3V6wUQ66kAba2+Rpu
	 qD1kj5uypE2ssbErbO2/7t0RrS5b2Peax0UqcL6mA083h+Ak/KAfJrz7Stlv+lHnKX2K9
	 KPJCJEgUHND48sqisNxSjDlkBrQOEEgsq9i0p24IA076Xw3Jl5aStEfjKM0rJCTS7CvAT
	 ajvZGruTAiiQKDEiv5ZOQFThTjmIzjB/pYwRWX/8RHHlDRQo918VGvDcgQd8Jtv/NYg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793107691;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=RnYy/m8rt1l7wOC+hxzQdmSaOPQCFjrQhnlvk7Res/M=;
	b=na5X0tfnh9wTn9A3yaDxGBGLHqJeogPEHD1s87swbuRhv3y2IdUSiYXv/M/EwPOpbBdE
	 B4fhLT8u8RrHGV0m4nXWprHwRqEAna+/yTP2PjDs3CZn6OK6fGXs1P9e4Db6t+IC/ZH9T
	 dY14Ra9sOMKROjblmTozp8DHn2tOaoq+Cm2K7YgO1BMr9UDtjftYHlcmLYeauc8nj7bqu
	 cGlL2On6JIK9xw9ZJamvLyUA467Qv45gy8bC4Uxqi1tXCSd5k8I7i/LwmUwjvIhfIX+D8
	 z8bY8yu04xQCwAPN9RNi5v5luiAOCUd2LVYdHWtUo/aYJOGHITedPEtcrXNgp7jB0vA==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793107691;
	bh=RnYy/m8rt1l7wOC+hxzQdmSaOPQCFjrQhnlvk7Res/M=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kD6xJsScL+Y9RmfdrCXJbkJG5tAYqQUHmP1F6wi1T5HntQQ4EzafVPUw9gZ9uPEcS
	 PCQ82EFhz/F0ycVkR1Xscv3Vz5MoYcsImuqjTQQpuzDEK3JfXmtQ+sT7H9jsfK6D/1
	 FY0nFeLVEMjNELokV8/++DPPR7Ux+Ig+oYlKpUeYwCqRm/oA/v7MNmZYc0cnKpb6pW
	 GTK8XhEq+rQtD85WjFumQV2FpIEMHs3BZ9B5hQenvj4zdyvZlrBsNPurSB2o+ro69g
	 3VGwQ9/3eHLf1xWbCBiwvWcoTEDVWchn8J4TAFU3qyblIDXGZXbKn5qKRVPVlZUrGm
	 Kfm1Oh3qkLlzg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 29B1C40609;
	Tue, 27 Oct 2026 13:28:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 11CE42F5
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 13:28:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 03AFF40261
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 13:28:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EutvDahLHC5R for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 13:28:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org EB2C64007E
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::536"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793107689;
 b=Z8jYAO6d1I7Pbjo4JWbYjbwLmEDK29+ZWquk653kXQrStxCYkDDyANTmroEafF8zM7Gr
 57E4O0ZliPowzocDxc9nwT+uK6wBjEBa6E4QrrjwjztaqgEVpN/+S9E5VmI7F2+68JuYG
 OmXa6bHKLm2gxcOJJLd4TdFvcXE8JC3E0QwmJG+X/haoWaCxsxTbIotChtrA86ga6PVFq
 08KKXnDduXGg+4ugVyB9pfLy88cKI0CbXmjLXvwD/VqKukH/OtvmbZ2e+zo/lejc7mtZG
 ZxfWnlt1HIm9dFneUOLZurDgcbR8hEbgf/dn+ov+8ijrKcwmucPqJ9/l9MaSGOPbmIA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793107689;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=RnYy/m8rt1l7wOC+hxzQdmSaOPQCFjrQhnlvk7Res/M=;
 b=r4Iijg6MqWLFjWWSFds4RactJSD0jqCCFLC7pCp7HOdDPPRMqnL3opyiyIc0LdG/oGOO
 FAK+St7QQAYp9zUiZ5fSIvByaOUFgcgXnp41A/glmSvYsgEBU41XAwXBNVO8oJ9ze3UoQ
 DBCR8c3ArXXefovnK+r8W4WTRNyFfr1HvIL8N9ziUrXVgGTZpgdNEJRTNWlE3IAWdDbsT
 3x2+db92+EuJyZPU07UUgCpompGnpv1bQ/oR6YEG925IiS0MVYt8Bf+2o4q8AFVKfq9zG
 8HM1nE9pc/lEWwFnF3aE7dvN/3lOvPl79Oh2vy9OclK0zxhy0g05mgRr8iRiT2i4hUg==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=oBBgG4Jd; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::536"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::536; helo=mail-ed1-x536.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=oBBgG4Jd
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EB2C64007E
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 13:28:08 +0000 (UTC)
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-6b3dc272dcfso5518555a12.3
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 06:28:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793107686; cv=none;
 d=google.com; s=arc-20260327;
 b=idRsgJNsKIE0TwaAtDrFVyamPeOUQF+KqVRyHdz2Ua8G07ouRicVlXoXgGYXun15s0
 dBkBxJKbYrk/+kqY8UmCE7v84UhUu6OYONc4woSrE8z3Mv6bbjVhA4HMxYMTib6+smzr
 csxMb2rRGmiDp0NB14WoaMa/CWIeQKdVyXCStg6sGF/mZK2FkqYXwbfIxpQWwcQbb0a8
 99NAb5hlD82tw9B7YnG1jRAv2iM0wHnNFrPh+Fjo271U8NyuOK6URCA3mv56mEmR7m5D
 5gVCFJZtov7OxKIoFCx5Tm1vHYOojRhWY4hEg47JjASt/ncNrexEX+BP7PXWeEdc5Ksz
 Whfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=RnYy/m8rt1l7wOC+hxzQdmSaOPQCFjrQhnlvk7Res/M=;
 fh=oDgJ20+auW6yONRFUW3GmLDBUw9s8kSlK/dPa+khJYs=;
 b=fXvgCxmKsCuJsA6djeEzUBduYggmQbHOLiLFYAn3NwOipb0TsaEv+HkiRjB+k7q928
 qBh4m8OCwzGZgQ2V+nXVlBDT8btgGK0zIhA9GM15iQfaKOlHw0FeFteCvSGP7kWaxDud
 T9y1GZKQgwb396Tx26p/tu7lxR6BkcpYPcruMQmaj9iQITg0sOGmMVFPm4/rF4AlRXt8
 /kHsJYUua6cwAtRVCScQN2RWpBXb7Ua8oCkloDl27o4jC9XvVFMi1C5kHoQOTTFuySqu
 WpxTFDJ2BgAtcvRk1cqED5XcJWZlm5/VfhKaIyFd76zut/G5F2TFDa5sBQCfTnC4kIby
 E0Gg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793107686; x=1793712486;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=RnYy/m8rt1l7wOC+hxzQdmSaOPQCFjrQhnlvk7Res/M=;
 b=oBBgG4Jd/1/VHKo+byB2T5TqleNYYMbC/wWRrANKOTXjFKmRSoeqGzLD0V99aPEorU
 GmXxG+IxlbBmShIMDgOq9hxJb4kP7/tZgR8K7fxVrbboigPvjdn8X3Vz8gNJQXkfiuer
 4tFhS14NE8CR3/zs6UwIoE+LTZU9ic3gpoytc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793107686; x=1793712486;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=RnYy/m8rt1l7wOC+hxzQdmSaOPQCFjrQhnlvk7Res/M=;
 b=TIdKrhDksDIewgeC/xMCTPi9eXB6H7g2lWxFGULbSfjyEHTE5qgC8rzIKCsjH2Vzzj
 ZV32sm2xGmHM65JZuOxqPWF6TwNs/3RHUuMjsAiU1/AzaonItwZgGPwswOrGR5HmXKQS
 yaWR7xGbkXPdD65/kyyt36OTWHx5tAz4BT8RKppW1FKVuXWuzh/xuQb9Lc0mYAA3rasY
 beNICxLcbA31Wl50W+5DcP8tWJLVyMXXNfeLLm1xgJNSTeRmDuPmpdTLUJ+7zvsqy8GQ
 pRN0NY10roiqrvuNy2uDJy0Q46iBQZRITOtxUQL+s4Yn4tx4bttMyzZbMz7nU82e9lMB
 c69Q==
X-Gm-Message-State: AFq9FYJDi89ZEGcoN7dtxmU88RzplR0IgfIgzILJHM77/WqhRvrKw+Sh
 semZE8tWao/EHi7eXehrOCk4e1T+HUgaT17QNPJnPALt4SPbiqTedat9shqpZ3XmW/TaZEbUfVU
 c8GkTL28FqvcGXliSoS2LVjCflzpMiugVGm67zzXN
X-Gm-Gg: AYBFou094ZZKP/o7aNlpV0MilxvssKAJ5dSgu8f3RjLkjfWJOPYNuD6xV5qBwlmkmpK
 oPvLwZyYr5F7hT+YhKNncEs6tSBja799ZvVdwZAoaFGwA/v/2rtBwZuPM66ZNmhqLQ6PO46tUQf
 HrPIcz9fQPaDUudd1KmPmP9Wyg+aSDyBedQ79L8wSvFfEgR7q4pBBIo2EFr5OvyBcgGNXH8kwXT
 w6Tv6kBw7qJ+O5HgUnSw35TPXYYY/1BwunnPR3K5WQvaIxSIfCo/RYP043tFM+3FTxbescpXBd+
 tQkpwGGS/L6apgjYf8aeDM51gZy2hnjc06PTJ/s+4920weD+Z0l3d0V1XUQ1+OwxTTqngilphYn
 DL+fI49fCtoTBt3EH17Nln6gyXoeQslxop5Q=
X-Received: by 2002:a05:6402:2742:b0:6b4:43e6:6b28 with SMTP id
 4fb4d7f45d1cf-6b443e66c5emr11045032a12.35.1793107686229; Tue, 27 Oct 2026
 06:28:06 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 27 Oct 2026 06:28:05 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 27 Oct 2026 06:21:26 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261026030925.1002846-1-oss.patchbox@gmail.com>
References: <20261026030925.1002846-1-oss.patchbox@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 27 Oct 2026 06:28:05 -0700
X-Gm-Features: AclHuK9Jl-NQoaAHkBBTY0k4U0L7VaJZYwk48XT4ev9JHt2vNbLEbM3ja6wDaas
Message-ID: <CAFLszTivp4YSez0u=AfLjcY7oGVan2_1yL-T4d1woRos2K49jA@mail.gmail.com>
Subject: Re: [PATCH] dm: core: Unlink the device when bind fails without
 DM_DEVICE_REMOVE
To: oss.patchbox@gmail.com
Cc: u-boot@lists.u-boot-project.org, sjg@chromium.org, trini@konsulko.com, 
 peng.fan@nxp.com
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
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Yuho,

On 2026-10-26T03:09:22, Yuho Choi <oss.patchbox@gmail.com> wrote:
> dm: core: Unlink the device when bind fails without DM_DEVICE_REMOVE
>
> device_bind_common() adds the new device to its parent's list of
> children and to its uclass before it calls the bind methods. If one of
> them fails, the error path takes the device off both lists again, but
> only when DM_DEVICE_REMOVE is enabled. The free(dev) at the end of the
> error path is unconditional, so without DM_DEVICE_REMOVE the freed
> device stays on both lists.
>
> DM_DEVICE_REMOVE is disabled by default in SPL, and a failing bind is
> not unusual there: lists_bind_fdt() takes -ENODEV from a bind method as
> the driver refusing the node and goes on with the next driver. For
> example cadence_ttc_bind() refuses TTC nodes that have a #pwm-cells
> property so that the PWM driver binds them instead. Any later walk of
> the parent's children or of the uclass then finds a device that was
> freed. With the simple malloc() the memory is not reused, but the
> refused device can still be found and probed through its uclass; with
> a full malloc() the memory is handed out again.
>
> Taking the device off the two lists only needs two list_del() calls, so
> [...]
>
>  drivers/core/device.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

> diff --git a/drivers/core/device.c b/drivers/core/device.c
> @@ -206,10 +206,13 @@ fail_bind:
>  			dm_warn("Failed to unbind dev '%s' on error path\n",
>  				dev->name);
>  		}
> +	} else {
> +		/* dev is freed below, so it must not stay in the uclass */
> +		list_del(&dev->uclass_node);
>  	}

uclass_unbind_device() only does list_del(&dev->uclass_node), so both
branches now do the same thing. Please can you move
uclass_unbind_device() out of the #if in uclass.c (and drop the inline
stub in uclass-internal.h which returns 0 without doing anything),
then call it here unconditionally? That avoids the else and keeps the
uclass list handling in uclass.c. What do you think?

Regards,
Simon
