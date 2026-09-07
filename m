Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55856C79F89
	for <u-boot@archiver.kernel.org>; Mon,  7 Sep 2026 12:07:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 98332606A0;
	Mon,  7 Sep 2026 12:07:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9tQTEKoTHXe2; Mon,  7 Sep 2026 12:07:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org BB8E360692
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788782853;
	b=pCwjDnP2SC23tQb9jtgqES1pZNLrE/GRtrxy4EH28MvmP0jf2eWs/EJdvUukycPprs54
	 ydli5o6TUE8YAO2aJzwCyx3mqY51Scud5bVHDsNf7q107PbrDSq0h3k3BHF/D5k1LkxJU
	 CD75yK/LpNODo+EY4EIg1S0HowslF9xjMMWGm2t8vPmcBRRi8eKJzC3p9p8PcCwSmsWkb
	 2tsCuy9zPXnUejtX+GXcRSAlsujqDQRnPmKxpy7Is90dpL9TNyLp78DlpfVdj8G8/yQSf
	 04AxG4t0DOmITKp0IOZ608JVdz2unsZDAATQzgChVLOjCSfSXVxeXRVDvb5p/4JjQ5w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788782853;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=kPF5O/x5zqaYmRpUYFW3MFZ5fsa31g5c5qQPNgGIuxM=;
	b=EGi/q2g9IPdL4PWfJdbdyhfL0X/eAwWfIuAl8l2imMojs59cJoQ8Z88G5d9y6BuboG0U
	 4GDKzmnsHGQ2KQMDAGlPWNliWz6BuSzZtUiEyaboUzJA/zsvBbmUMU6Amvzu7XjGyJ8Ch
	 gsjzcfbeq6+uiuc7RVJhMXIhrDaNLnB/K2+1iqG1TB189weWoC9bJhduKSGpt/rIvz9Cw
	 9gxLXu3WlNrnVzO+c5SKzpOeqIPsonFpMSR2eGFt2Hes7Bee8/Ogpsr9jjLJaDfpoCXR/
	 6RivfR3SeE21ugqs0GNiJsl34CNn9AUUcQUvDiSyle5y/JkiBedUj2FI8OPDqnzWKPw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788782853;
	bh=kPF5O/x5zqaYmRpUYFW3MFZ5fsa31g5c5qQPNgGIuxM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HAt26k9LIRGfcDywcThzyykaXp29Uz32wJwMYBQn3ejUy4stiNrHPiZyVVUTb5UAR
	 krIHxCPw0xF13sYEpNpnP0ydM3ZcDFsRY3S/qH7woBScHO3WpJxF3AfP3WGha2/oNR
	 nRFcEfaw4wafzpEfyYOqTLIAGdXxypeZMn62nU/w38kZqOf7X91u/m4HLuRvov6hss
	 8Bh3HFJyeW6oCnWjGNBrIGW+qPtN4zQsPBcRDRWdCqG+35KdUCmaePI1fm0TYW82Ry
	 FJX8wL8i9sahN1LQzE+rg4AhNyrm5vln+8ZIyH3w+E4FpZ5GscL30mA+tqb2Xeh2Pz
	 OxuaQDcUfd6IQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BB8E360692;
	Mon,  7 Sep 2026 12:07:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4BEC6A48
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 12:07:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3D8DD40105
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 12:07:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BWXk1cPfbXgw for <u-boot@lists.u-boot-project.org>;
 Mon,  7 Sep 2026 12:07:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 5821240103
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788782851;
 b=cddevmj+jd8gXVVYJGicbNJyQ0C0BQ5IdSG8EAZkfrt5RBEOpE7AhoJZC1nBgh8hMzIL
 vRu4FhjB0rC7PzYCWKTsSuW46HiNujhIHWUbN7Dji04pIYacCJHHZhqF65NbF6N6T0am5
 cbX4HoZACkQzsWvG3am7d9oG0vR6gE6tjDdFC5n53FnViEJEnzkdHie6uJk4H11EKXGc9
 6FyCSsp35fzXKZuZAhIaG/St6EP1Mi7sQm0gJSeoQIsxTW2x9Bs1S+kY+IyGX5JlrEUfq
 2XfphoXSICMWr5/excivPXEEnV+Gug7GJM0rQ48ap7aC8vfiLD9qJq4a6qsvrTaUKlg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788782851;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 In-Reply-To:References:Date:Message-ID:MIME-Version:Content-Type;
 bh=kPF5O/x5zqaYmRpUYFW3MFZ5fsa31g5c5qQPNgGIuxM=;
 b=E4D9duxW413g2ZYMMjDW1TtP66MOAZbYVk8G7kXRs13xjiOZVOrCX92jkGoak6E0m003
 aI1t0VXTqxxLFR6AU1L3+OEB1lmU3q9kbupV5w+uEbdmBrrsHuEYECXV0H0I5geHyL82A
 MOSxwP4kVqrkIh8jTFesFRJaMz04inK4dEBP8Z4bronuSMqPOUB05LS3I3+QF11yrpR0F
 PBaWXke1dNWUx2o7uLXqAISFBCdIzQoBqygb7tWdtiww4Bc2enodcD5phM63j4j6gYAIr
 IaBEQS3ZPggrTW1lqpOU177W7SurXQ+Iw2ZsB5xHa8RZMiDRStl0MTmWTBT4oiFmyZg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=VQpdXoFN; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=VQpdXoFN
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5821240103
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 12:07:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5CA5E60D8B;
 Mon,  7 Sep 2026 12:07:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EBB51F00A3A;
 Mon,  7 Sep 2026 12:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788782849;
 bh=kPF5O/x5zqaYmRpUYFW3MFZ5fsa31g5c5qQPNgGIuxM=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=VQpdXoFN2uOWwIOOnFnPDaod82FVutDHTN+VENgB94q3zAYwlSUdwwzcAX/2WVHWD
 J9DvOwh+PUahO9o7x+2soR+1Vu9n694Ru72ZT552/8XapYhspZAHSVnRBooafXd3Se
 yyeL9ymIup6GxMhCpD0JepIGXulKMZfeihwqlVuyhMczU+2SomBcDhlqQYw81Zac+C
 ybb6uWP7q/ajtaPlmaU4yXEEnRF1vNulLlOvbJxS3FWLUR4X+hbEl2A72nPg0JDe4c
 d6Ym4SfPS/mwrz0VYqj0mChZ4j+92PBCgOSm/uvrZQpzHwqQC5EGD0QADyT53qMWak
 6BJmUzPnT8AWw==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Rasmus Villemoes <ravi@prevas.dk>, u-boot@lists.u-boot-project.org
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Tom Rini <trini@konsulko.com>, Rasmus
 Villemoes <ravi@prevas.dk>
Subject: Re: [PATCH v2 2/4] optee_ta_avb.h: add
 TA_AVB_CMD_READ_PERSIST_VALUE2 define
In-Reply-To: <20260903212215.2331118-3-ravi@prevas.dk>
References: <20260903212215.2331118-1-ravi@prevas.dk>
 <20260903212215.2331118-3-ravi@prevas.dk>
Date: Mon, 07 Sep 2026 14:07:26 +0200
Message-ID: <87a4pttgch.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Rasmus,

Thank you for the patch.

On Thu, Sep 03, 2026 at 23:22, Rasmus Villemoes <ravi@prevas.dk> wrote:

> Add the new TA_AVB_CMD_READ_PERSIST_VALUE2 definition, and synchronize
> the comment for the existing TA_AVB_CMD_READ_PERSIST_VALUE with
> optee-os' ta/avb/include/ta_avb.h.
>
> Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>

I see that this is not yet merged here:
https://github.com/OP-TEE/optee_os/pull/7959

I hope there won't be any other changes in optee_os, otherwise we will
have to re-update here again.

In any case, looks good:

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
>  include/tee/optee_ta_avb.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/include/tee/optee_ta_avb.h b/include/tee/optee_ta_avb.h
> index 949875a64cb..d8db6d257bc 100644
> --- a/include/tee/optee_ta_avb.h
> +++ b/include/tee/optee_ta_avb.h
> @@ -47,6 +47,7 @@
>  
>  /*
>   * Reads a persistent value corresponding to the given name.
> + * Only reads as much of the value as will fit in the provided buffer.
>   *
>   * in	params[0].u.memref:	persistent value name
>   * out	params[1].u.memref:	read persistent value buffer
> @@ -61,4 +62,15 @@
>   */
>  #define TA_AVB_CMD_WRITE_PERSIST_VALUE	5
>  
> +/*
> + * Reads a persistent value corresponding to the given name.
> + * If the provided buffer is smaller than the value, returns
> + * TEE_ERROR_SHORT_BUFFER and sets the output buffer size to the true
> + * size of the value.
> + *
> + * in	params[0].memref:	persistent value name
> + * out	params[1].memref:	read persistent value buffer
> + */
> +#define TA_AVB_CMD_READ_PERSIST_VALUE2	6
> +
>  #endif /* __TA_AVB_H */
> -- 
> 2.55.0
