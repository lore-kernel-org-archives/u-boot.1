Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7DB0C53219
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 11:37:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7663260866;
	Tue, 28 Jul 2026 11:37:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yVmsRQQvRE97; Tue, 28 Jul 2026 11:37:55 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C9A5C607E3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785238674;
	bh=IBgWDEB0bdcyvxSU2cjT0fc3MY/NWJ+8VzaT0qRYf94=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SEygmyvr4SgGk1Dy3VvddE7xYAOUhK/b60ApgynHYBvNZaYdIPsl3QmmB5d29WDAS
	 xCdfE9DSzt6AkeLdid6Lxc6fBRB10fr/wNRAS3t0z+YNbg5M5kdEtA5h2NlXjC9yQB
	 QJINiaEPJ5RvKUHxnKa5L8kKB9onxVI3pCyUDGEqMpR0ba3AJpVI12UFYXtr4MTjg2
	 R7yiYfb+Rd6nNXt2Av28rtHlVZ3roROM0UKEXEd9j9lNXb1mkw774QE529E276Z1Bf
	 wKfKXOXfVVPrQmNzhbNKlJplEflsdiPqamu4/Swu8N00lIhOqobSvukeWJEO0jhF3P
	 PTRdtKAJDNLJQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C9A5C607E3;
	Tue, 28 Jul 2026 11:37:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 0F6782E5
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:37:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E9DBB402D8
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:37:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jlQhq2qt7NS9 for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 11:37:53 +0000 (UTC)
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 62EC2400D3
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 62EC2400D3
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 62EC2400D3
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:37:52 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC3478494B; Tue, 28 Jul 2026 13:37:50 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CAD6682991
 for <u-boot@lists.denx.de>; Tue, 28 Jul 2026 13:37:48 +0200 (CEST)
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-698aa7ba320so1818905a12.1
 for <u-boot@lists.denx.de>; Tue, 28 Jul 2026 04:37:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785238668; cv=none;
 d=google.com; s=arc-20260327;
 b=cXg1lmRowrxx5F7H/WMDVbqU4xgtX+k34vRziDnK3tlBIQlYNiHuPcXmfNXv/MbrFK
 wF9xLXauzOMEKHQk8nerE/ZG8wv9XO+Qk7blT79TEwTkY9Gq7CM/+6WmcSdqvZjM3z2s
 lKO67y3f574ajkT+NbyjaBcFRBVn0RoCHfK7lFMbXCy1orYcApMdxoh+YcEo23iaH2wr
 pEhi63i6ykSTNLCfGcqpiG+s8AktzsoCeVU3gCYOKUi2rHAk8NSDP52/FlCyB428buP5
 nSNaNncsy/+YEgCFIvS/NUqLdSFVyNnnxT947Qxnbwbfb1p57gVqil3pPmDFdqwSW8wi
 lB6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=IBgWDEB0bdcyvxSU2cjT0fc3MY/NWJ+8VzaT0qRYf94=;
 fh=runy5GsEaBbwYs4tLCkIDKGakFI3WhxP+HVdMM9V8MU=;
 b=X+mQmsxnbE3pQOxURt8Fiiu9punYslRcaOemDSUKE/Gd8+UWIogRZ5T23VHj1/xQyO
 IrkTVm5i/glQWaQuKFV+frzNSqPSLkB6Gpsto+Ry0NctDQ/DZfwcB95pq9AkVyG48vrR
 UT96CshNANHnKCk5jK3pMyNushG7wjgNWpngB2SVWYP6yImNOUKZQwAK4TpUJhC6Fhr5
 Ib9FjnMzqMUXef4z0SOhgeuCfwDIS1XQZdple4cLP2MoEyEKAWPgSkkYYaweC871RVhX
 SFmZcLYTKxtw8mVmXnuhRC4fgTufgoc2K8rXO0CBJduv2+NrACl7ORm3X8t3d/48+z1X
 8hqw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785238668; x=1785843468;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=IBgWDEB0bdcyvxSU2cjT0fc3MY/NWJ+8VzaT0qRYf94=;
 b=L1v7aQFm8UgXg2z0O/gl2uSV6KYq33nXxDofbQ5Q/0KjLOXtC0bVWC1HS39+3Oc+3M
 j/a695LrOb3Ys02+YrKHRqLT2OaaAUkp4/pj4LBg9+2aryouxBoPkbEkWusw+k4pJnvw
 q85p0bJDY/4gi9FASzYodsEkS9OBtvknNfi9Y/jq2scIfv3HHVevOZiUwWiYaRbzz4g2
 W16myr7l2KKgdPFgejf56b/4VXKzwgMPp/gFDHmy0GtNsmMiXE5RBj3dUtGgZn23OBdw
 uXGN0MGVa/fI+/wvWjjMkihW+eqFeGGJQOKpIg2g5Rh6baSei/Fm/uTy9p/PwbLFdA6t
 /cYw==
X-Gm-Message-State: AOJu0YzQFJB2qrpUtIQjYQTDBxvgCvntrewUpckcOsZcv1RB+LsZDich
 y0uOrFUsnR8HO714bjPq+QrlcXTCAVeQB7jFscO99NP85kiEqhTUrSsA1BB4IZiUjQv5rPYbUgm
 vqFv7piTwhVSuPObcqMfhDgpAEE3+Xj1G6XSt8zY3
X-Gm-Gg: AR+sD10o3aV8HBAN6zf+77kUU5vqgFtlk5E9Np97orVsd/JtquEwX8vLPscjGsd0T+x
 Y0QkhsdVTLdu5Fud7RuTxl6W2+x0IZkNYdExo2BwLJCEcKoac3lzHzb8tSfM1jjXpbhBd1eH5C0
 PF5IReHUEJugRlrs8teH8QwkNkQsBk4L2YkYpRfoywKa6psvNLRNY6L5s4E1FSrRI+8zzMqTKHp
 uIUaq+NnMUvW8WPhi98yB8hwmNbpsE7YnVmwJrYnW2b0CY3tt3h0KYjBuIN
X-Received: by 2002:a05:6402:52ca:b0:698:a9fe:2eb3 with SMTP id
 4fb4d7f45d1cf-6a034a58ab5mr1008363a12.9.1785238668194; Tue, 28 Jul 2026
 04:37:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260716223401.378989-1-dmukhin@ford.com>
 <20260716223401.378989-5-dmukhin@ford.com>
In-Reply-To: <20260716223401.378989-5-dmukhin@ford.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 28 Jul 2026 05:37:36 -0600
X-Gm-Features: AUfX_mykuO9IhoJarNdyUQFxCzAUEGrSRY28kLH0Iq0laJbQ_SUrk5fpmnnxQWY
Message-ID: <CAFLszTh-OY+3HUuWdZift=B2MCPXm5Q8i4VCQHy+2j+tDNu76g@mail.gmail.com>
Subject: Re: [PATCH v3 4/7] cmd: Add flush support for all blk devices
To: dmukhin@ford.com
Cc: u-boot@lists.denx.de, neil.armstrong@linaro.org, seanga2@gmail.com, 
 sjg@chromium.org, trini@konsulko.com
Content-Type: text/plain; charset="UTF-8"
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785238668; x=1785843468; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IBgWDEB0bdcyvxSU2cjT0fc3MY/NWJ+8VzaT0qRYf94=;
 b=X26h6pj0jpqTiodLyrG3bMT0+W3CejtgXiu1mEgywb8E333L7ZG2FE1gU0fXRY0i+y
 InQALmuowaGyox9shHw4xkWbWV155h4ewklmJwjkH7eqD9R3w5G1cIJ/1eC0TWSCOkqo
 gAOd7a+4fGRR38ossq2MOI+ODwpOXbpjm3oHQ=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 spf=fail smtp.mailfrom=chromium.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=X26h6pj0
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=sjg@chromium.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=chromium.org header.i=@chromium.org header.b="X26h6pj0";
 dkim-atps=neutral
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

Hi Denis,

On 2026-07-16T22:33:54, None <dmukhin@ford.com> wrote:
> cmd: Add flush support for all blk devices
>
> Introduce `flush` subcommand for all blk devices to allow committing
> dirty data explicitly to the given block device.
>
> Signed-off-by: Denis Mukhin <dmukhin@ford.com>
>
> cmd/blk_common.c | 17 +++++++++++++++++
>  cmd/blkmap.c     |  2 ++
>  cmd/ide.c        |  1 +
>  cmd/nvme.c       |  1 +
>  cmd/pvblock.c    |  1 +
>  cmd/sata.c       |  1 +
>  cmd/scsi.c       |  1 +
>  cmd/usb.c        |  1 +
>  cmd/virtio.c     |  1 +
>  9 files changed, 26 insertions(+)

> Introduce `flush` subcommand for all blk devices to allow committing
> dirty data explicitly to the given block device.

Since you are adding a new subcommand you may need a test for it, e.g. a
console test using run_command() and ut_assert_nextline() in test/dm/blk.c
or similar. Patch 7 covers blk_dflush() but nothing exercises the command
path in blk_common_cmd().

> diff --git a/cmd/blk_common.c b/cmd/blk_common.c
> @@ -37,6 +37,23 @@ int blk_common_cmd(int argc, char *const argv[], enum uclass_id uclass_id,
> +                     ret = blk_dflush(desc);
> +                     if (ret) {
> +                             printf("\nfailed to flush device %d (%s): %d\n",
> +                                        *cur_devnump, if_name, ret);
> +                             return CMD_RET_FAILURE;
> +                     }
> +                     printf("\nsuccess!\n");

Please can you drop the 'success!' message, or at least match the other
subcommands (the read/write handlers print '... OK')? U-Boot commands are
generally quiet on success and the return code is already available. Also
the continuation line mixes tabs and spaces rather than aligning with the
open parenthesis.

With those:

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
