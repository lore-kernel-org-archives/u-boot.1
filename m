Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8DA1C55ABF
	for <u-boot@archiver.kernel.org>; Thu,  6 Aug 2026 12:58:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5CFE160784;
	Thu,  6 Aug 2026 12:58:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0-Bp7h_JJJF1; Thu,  6 Aug 2026 12:58:22 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 99EE66072E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786021102;
	bh=NuCuungjFcxJ5xg7CUYWrGtE7a5kvD07rKfwfjqkULk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FhjV2ZPti2ARam4L601dAJcxQNSFgHKFKKa1vW5sBS7DaeIKnMAhmcYhkcqUka5OF
	 ojkaaH2AEfdAobP5FK78bAxhLQB5w3L7wdWe/0dh1r0iiOZcV782Wpx+IWVp/mz+U7
	 aX83weinSsjcCS+dUd5xeNTLfD+l/RxnxZ2gOZW13mltIVK3zbbMCaEIWhVF+xalh8
	 3n1ZpPyuTnsQd8DjTXVcVvbB/cXhK6m/X5j3Bvv0KEZev1NzLe1wXXfT4i+2dkw6ZS
	 /wFHKzy3maazjSaUBeQ6gpdRa2w8rjLMEE+rHA+OPxe7/7c65qBfz/aqQTpCYOEtbD
	 cJ229z4oQmxMw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 99EE66072E;
	Thu,  6 Aug 2026 12:58:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 795C1397
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 12:58:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5F4436072E
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 12:58:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4b2M6v8wmRrZ for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 12:58:19 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52d; helo=mail-ed1-x52d.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 3FCF3606FF
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3FCF3606FF
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3FCF3606FF
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 12:58:19 +0000 (UTC)
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-6a1b51723a9so164538a12.1
 for <u-boot@lists.u-boot-project.org>; Thu, 06 Aug 2026 05:58:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786021097; cv=none;
 d=google.com; s=arc-20260327;
 b=RsTdnbyf3gCtV4iV86N59HAF36RC4s+2n65CL5RK0yxlfofAfIK/b/2kcDP5dr1dCb
 cabMJYCXRGPSMb2RP242/hEXdZIzLEoxPkvehfMQJLGKMemrkqHA20G3o1HEkLmVnjDd
 TeKhItzPiEnwtyxe/o89eccvpM59RaULJmzoLRqlkMy4kJhsYl5uI3kWgkA4NNrsb49y
 umaqzSutuGXFIGxGjGT+KYtbfJp63bKAKUbF/hGQaEwIy6qcMoS/NJzdwcvWV0YbBSYt
 TbIWLreDa0/rXCbOG29dCnRyGb39o8PJqcoH7gIzqLJt2tSwZ+tMYD1mp88YZCENkHAh
 VytQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=NuCuungjFcxJ5xg7CUYWrGtE7a5kvD07rKfwfjqkULk=;
 fh=NSlj64oTSSmoJywS1IxxdjWBErayqFIKpVH7lrzP0mg=;
 b=msjw5+2cAKvs0c+vxygg0wTS5luYsp1ApKpVELSia4Y0/3WRk/EGudao0uX+o2XSGL
 TYkdNItpfZpOTa24rfT0YUgYZ0GV+HcvGBNHjexlAyzGiHfgofEQQXTlePU8BJEmNr+q
 CKDKzUAFhBEoPkeibgvNEsOEOxdDm5CC4Duv+FcH8DX14xM3s3yyQSNI1pKIYmSL7TyV
 mzqzI0RH4LXn2at/DA6B/QjSwijGaoQdIIpWSVlI2efaYE6zua8Ilrm0wcpw8EOxFFHS
 REyyfePhqorwqG7P7+HJl4kguR4QfiTtfCNhKsWqZOglt4Je+iW9xuGacIW+83FCrhEH
 ISjw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786021097; x=1786625897;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=NuCuungjFcxJ5xg7CUYWrGtE7a5kvD07rKfwfjqkULk=;
 b=L0va6ke20Gc9EJHJTl4QXjL5RMINiBpgcsEv+VIHa9Y6wqQ4phTNmZPyLRXuAvgPCe
 ChiHsvZYeEPTPmZ1c/m8b4ncshUza8yjhgTG6RpIrWi2o4FwLQPDIsQs+tmSFy3aY4nX
 7G78R7YUFUA1hjlO3yoi7Kz1brQ8CvPXtTkRB+y5Solf9MgV5fLic7SLEUlGyKEgsFSj
 0/8MTfsRA/h+1j9e+htel9edcZa+rXqQlJXyFZTgluktsNaX8nPFbww+lvXHVF8AiCil
 bsp9ueR1q4mkFy3hm4zqU0nWDjfs9ZXdL5zzHYxH8MxGHNQSGJiRW6Hf2UtRzjAwVANC
 XJlQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpeHgCCEolVZA5iGT2POMuQs7opqPdqB+pQOeBKeN4Jvt4soffux3DJh+Kp56H2rQXHaXWX+yQ=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YxZEzn/KSwW+yyEENn8EhN7wH4r9eqRKxIKBMlZM28bJ7OKoRxY
 3Shru4V80OboCc7c/LwgqdiT+MJOAUpjaMs4UiBLmQmwF6Qg1n+j2JP1lNHZ6x1LZXLc2M2JEBo
 9lilGLbN4k8tu6zKFW5tr1f2ibV4C6FoI/KGSNt2Zpq7kqFiGCiczgw==
X-Gm-Gg: AR+sD11GkE82nUIqZOLI1+MbsJhb2xZiQvTuBRUiQBd9vprD3Yi08XxWbu/47+gxtHk
 5GzRP0CdO+/BJ280HEfykYmstRybSn5xpwzzH4cH1Z/o4ho4dT5CqlsI+g+L+UsC1iorkgsnqT3
 JbDXi1gsBeqZ5DTqVie2+59zvOxF/TGO1IIQgCDISAS+RpWW5KUHG0Wsf94y86zew5xMPsiFmQU
 01J0XX2aNUY/IBKY/RxOsWqp1E3HCKrUKBfjtqVEop/uxKf1XxhOerSSU1zdZzcQwoW4knNR54E
 R98pwQ8ll5LZtkX0+E5w6FsapHHUUwt80QdJjA8L2VxoDLDuVgv1rA==
X-Received: by 2002:a05:6402:548b:b0:69f:acaf:9611 with SMTP id
 4fb4d7f45d1cf-6a14f13c316mr7636577a12.10.1786021096704; Thu, 06 Aug 2026
 05:58:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260730034316.26353-1-jayaramudu.desapogu@amd.com>
In-Reply-To: <20260730034316.26353-1-jayaramudu.desapogu@amd.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 6 Aug 2026 06:58:04 -0600
X-Gm-Features: AUfX_mzKXSVEANo_3FYPcacTODFru4FJVXjnRgf9zh37OPkpiM2WzBfJk6qK4MM
Message-ID: <CAFLszTgw7iG3uzrUfOO7vnMJ-7fD40rpzBKxndmYVmpJYu9Szw@mail.gmail.com>
Subject: Re: [PATCH v5] serial: coreboot: Accept DBG2 subtype 0x12
To: Desapogu Jayaramudu <jayaramudu.desapogu@amd.com>
Cc: trini@konsulko.com, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1786021097; x=1786625897;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NuCuungjFcxJ5xg7CUYWrGtE7a5kvD07rKfwfjqkULk=;
 b=BTeBZhiQwy6SpyxY3tS7mc2YMYOOqNauzsLkotE6Kiaj7N+1o3JB3nChCLeNQMrWmn
 pF8ZAYQhjqGV9RwKJ3j+4s9RlOa7QouBFX67oeR20ebDCD5l69G4WNkV0az8f5pQVoNU
 KYiexh4KA8M8Mo8AuF2zR8TGXzRXYzgR92Rx0=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=BTeBZhiQ
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

Hi Desapogu,

On Wed, 29 Jul 2026 at 21:43, Desapogu Jayaramudu
<jayaramudu.desapogu@amd.com> wrote:
>
> U-Boot running as a coreboot payload obtains serial console
> information either from the coreboot table or from the ACPI DBG2
> table.
>
> When serial console support is disabled in coreboot, the coreboot
> table does not contain serial information. In this case U-Boot falls
> back to parsing the DBG2 table.
>
> Some AMD platforms or any other platforms that uses memory-mapped I/O
> advertise the debug UART using DBG2 subtype 0x0012 ("16550-compatible
> with parameters defined in Generic Address Structure"). U-Boot
> currently accepts only subtype 0x0000, causing DBG2 UART detection to
> fail and leaving no console output.
>
> Accept subtype 0x0012 as well and keep the existing handling logic.
>
> Signed-off-by: Desapogu Jayaramudu <jayaramudu.desapogu@amd.com>
> ---
> v5:
> - removed whitespce
>
>  drivers/serial/serial_coreboot.c | 3 ++-
>  include/acpi/acpi_table.h        | 1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/serial/serial_coreboot.c b/drivers/serial/serial_coreboot.c
> index b1f69f6998cfa1..89da11ffa5241e 100644
> --- a/drivers/serial/serial_coreboot.c
> +++ b/drivers/serial/serial_coreboot.c
> @@ -59,7 +59,8 @@ static int read_dbg2(struct ns16550_plat *plat)
>                 log_debug("Not a serial port\n");
>                 return -EPROTOTYPE;
>         }
> -       if (dbg->port_subtype != ACPI_DBG2_16550_COMPATIBLE) {
> +       if (dbg->port_subtype != ACPI_DBG2_16550_COMPATIBLE &&
> +           dbg->port_subtype != ACPI_DBG2_16550_WITH_GAS) {
>                 log_debug("Incompatible serial port\n");
>                 return -EPROTOTYPE;
>         }
> diff --git a/include/acpi/acpi_table.h b/include/acpi/acpi_table.h
> index 4895366a6188ec..ac50ea10312e28 100644
> --- a/include/acpi/acpi_table.h
> +++ b/include/acpi/acpi_table.h
> @@ -674,6 +674,7 @@ struct __packed acpi_dmar {
>  #define ACPI_DBG2_ARM_SBSA_GENERIC     0x000E
>  #define ACPI_DBG2_ARM_DCC              0x000F
>  #define ACPI_DBG2_BCM2835              0x0010
> +#define ACPI_DBG2_16550_WITH_GAS       0x0012 /* 16550-compatible UART with GAS */
>
>  #define ACPI_DBG2_1394_STANDARD                0x0000
>
> --
> 2.43.0
>

I added my review tag to v4 - the idea is that you collect that tag
and send it out with the next version, unless you make major changes
etc. Here it is again:

Reviewed-by: Simon Glass <sjg@chromium.org>

Note that you don't need to send a v6 with this tag, since patchwork
will pick it up - you only need to collect the tag (e.g. manually, or
with 'patman series gather') when you need to send a new version with
changes. You probably already know this, sorry if so :-)

Regards,
Simon
