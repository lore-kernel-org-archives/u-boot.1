Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A4D6D2ECE9
	for <u-boot@archiver.kernel.org>; Tue, 20 Jan 2026 12:26:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 146EA839E2;
	Tue, 20 Jan 2026 13:26:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="T/8xc8oc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9414D83A8D; Tue, 20 Jan 2026 13:26:34 +0100 (CET)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C0C580B98
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 13:26:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-79028cb7f92so42820207b3.2
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 04:26:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768911991; cv=none;
 d=google.com; s=arc-20240605;
 b=epW9GJkPRnJ1IE42FxZiGJQ842CnHNatUgMuIG2Ofg7XkBxxDT0gqxNfd2H1aB1Pgd
 Q9TFuP/LfnW6A9eT943+QcuCrHj1UcKAv0gYJEqRZUfBdcT2UXnElETxMv0NUSljoBKn
 TozW/v38rSkZzIXNP179WL/eBHt+HtCFlPepAfKYWutcqqMjJXadyVlScMlcAZglodga
 dKzIwgDsaP+ajGNSLj3qXyyLZlQdPi4DMIEgm9E4qI3bRK7lDJCVNDKM5bd74cbhXLsF
 09YCXMsAQ9pKRxeG41OaTs3fJFVDG42Amvs2deCoCA3tbyPmZAijGoDoeKoqVdnzREyt
 /heQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=2qrDcnDSD7JCX+yu/7mj6MwmmxX1PkbsXP+16rAcwPY=;
 fh=s/hXJ48J50Vd6K1Y+3j7h4q6znQ5kpu6I1dzeFfBczI=;
 b=Ax+JOY4x+WQC+l31jbmkHUpHbs9eoOh+VZHzXVJ5mA3hP/z9hqLo04zfKq7czBP0tr
 Zv1Hjs4SBqodbCbXSLWXLMcp/mjTMzWDQzV3HzI6nZjKVF9R0Ddc4PYgsiiBOm5VmphC
 fyviMKDoUN4BMJTmpiCQfGbm92GREEkq2TvlEpziH4LMJ6Ztoc9gPw/qi+SrFtPDcuIj
 1/4HQWbmladw+q+N/Hr+slLcqaZAqTQaKsP757MM7VUq1KRwQWP0GSRXBnI6I6Ouonmt
 0+UOphWNXRqmHisulT9xPRev8uvDTLho09h22xAYslUvsshVBnV5eF8/1xyJY9khHivc
 i2eA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768911991; x=1769516791; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2qrDcnDSD7JCX+yu/7mj6MwmmxX1PkbsXP+16rAcwPY=;
 b=T/8xc8ocyWAsCJ/CVosmKnE6a7wtPiAoF0GUyzAoj9qJcx8yYQkz5VMtUJsN8MY997
 hE2zeYuScHx4/HRfygb5/6dNyWmB08hBxeCumo4XmA542qOUO8VbT3TvcF3R1GIvdRXk
 wiUs+ghELeWjFMYCzB2cx4Y+mjUTkxOOof/itFR7cyJch9hveWh8JTNp0dDjX+h0WXLK
 gh2DkvbhEpYuyayd5kDt6P/RFavZrSJBcG8UXacov7tNGd3rQqJ87wnwkjS8+zXZyXFn
 t3fHu/p3IboXQpozZCuNhmaY25j0xdzs0u3JQM04z56GdoJ+mh1UpvNM8cZXtD6yF0Ej
 z0XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768911991; x=1769516791;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2qrDcnDSD7JCX+yu/7mj6MwmmxX1PkbsXP+16rAcwPY=;
 b=cMV7dQooHl6DCtaV2gsGzXnfdNadANAMdN5ly+dgblpAsJa0xPOc4XzLLsSo4wf1il
 vOdz/fuAvXA5rGz0jTSbeoVD93c5P2T2LZb9KLvc5F33PyolYLoi7t4d6dLfTPuHYmbc
 rhVLJgIWxsYXPfXjTTQ6Fz1jj1ukZIN6kiWBQ3ywAh+1CfscV1eRUVO3CAtCu5upcOhX
 hdkcZvypPyQ2PLvUIDpOT/OClgInAyk8H2hzkVS9PjTzRtYyZ01pBisr2zvRu9E3byNn
 SlVCpKKMvBSSfTMcDeMdCXUCqkk+g1jbIyefgnWQbQEaozQfaGw4SzdjGrEAY5Qu+na5
 fUnQ==
X-Gm-Message-State: AOJu0Yyl2hCkRtCGV6RsW2nIrN5Ibs+loG9Ayls/QbElWLmLh2JH176w
 OuqBFrV4joJdsNEmRZg2k7oA/8CvAs2UJwqxsdPQPkSXAEYceeg7BJGYCLJIr2zLHir9UUIPvHI
 ro5s9vlq9+1BeiPCobAePjU+Sqb1uoppLLAEOtVO6ww==
X-Gm-Gg: AZuq6aKdRzfnDhDBSZ75vw2Oiv/gO47pdSf/hLBYWJItk6EA2bYw69e4/fBKfklztuq
 eDqWVBK28kjJc+FUOyIZPHZRFTucBr4PCo8p8876JfTN7XxFGNnrlOQMsRGGY+RBIPRZBhpW7zf
 Ook74HiNgZ1oJcUkpJT4EE9qwPO38AZLSbtljrbn8c8b6EkVcTTpSOm7BU7znyUZvom/+nziXCp
 0sdixrBeaQINIXmMHR5oMgkL9qVrAPhjEdlcJ2eRgM9MUBsRmdfulwjl+uOh2dteLqOgpL9vNkN
 eldHVTFl5ohxJtPSSTJMa8qgSb0MT3nvaPjHTpyoqSIuQRPT6WJ5O3sNrshIAGnh7zVi9Cz78PY
 IlVeJrc7VmeXZHYOfTSMTNqz2xDk95/JVvUNdwPFjnWxM1t2BsugGkHZMrCVwYJeoTq4f1OvXdx
 Y9Y2xtF7OWOXju3WxgczfJWr1Fp6PM+6Esnw8PG8W1ov6x4wwJpuhlgH1A7hGVsRMFC4qx3Wmg7
 smwxLZMsUEsdrd5FLc0eJjVT3QPW7CFX5g8F2jaAWG5APJIWW2hlh4ay3zP6cID4GeMDczloTdJ
 pv9PVK9n8C+qIRHm3bwmJlDTP4v1ce4mdy7b8iDQTP0=
X-Received: by 2002:a05:690c:48c2:b0:794:1447:1adc with SMTP id
 00721157ae682-79414472a93mr3117157b3.22.1768911990791; Tue, 20 Jan 2026
 04:26:30 -0800 (PST)
MIME-Version: 1.0
References: <20260119160746.1330877-1-kory.maincent@bootlin.com>
 <20260119160746.1330877-3-kory.maincent@bootlin.com>
In-Reply-To: <20260119160746.1330877-3-kory.maincent@bootlin.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 20 Jan 2026 14:25:54 +0200
X-Gm-Features: AZwV_QgGXzdvPwCPJmRlgPzmM-Z8--GPozT2NBtaWQSIvjX1z8XN3qk1129LC5k
Message-ID: <CAC_iWjKhd+F1TczjuYN9Q29PQdciihudnuiQ98V90Sq6UUJJ1A@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] fwu: Mark failed bank as invalid during rollback
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: u-boot@lists.denx.de, thomas.petazzoni@bootlin.com, 
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Padmarao Begari <padmarao.begari@amd.com>, 
 Michal Simek <michal.simek@amd.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Simon Glass <sjg@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On Mon, 19 Jan 2026 at 18:08, Kory Maincent <kory.maincent@bootlin.com> wrote:
>
> When boot_idx differs from active_idx at boot time, it indicates a
> rollback scenario where the firmware update failed and the system
> reverted to the previous working bank. In this case, mark the failed
> bank (active_idx) as invalid to prevent future boot attempts from that
> bank.
>
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> ---

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>  lib/fwu_updates/fwu.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/lib/fwu_updates/fwu.c b/lib/fwu_updates/fwu.c
> index 0f5ef2ba515..37c613014d1 100644
> --- a/lib/fwu_updates/fwu.c
> +++ b/lib/fwu_updates/fwu.c
> @@ -766,6 +766,12 @@ static int fwu_boottime_checks(void)
>         if (boot_idx != active_idx) {
>                 log_info("Boot idx %u is not matching active idx %u, changing active_idx\n",
>                          boot_idx, active_idx);
> +
> +               ret = fwu_state_machine_updates(FWU_BANK_INVALID, active_idx);
> +               if (ret)
> +                       log_err("Unable to set bank %u state as invalid",
> +                               active_idx);
> +
>                 ret = fwu_set_active_index(boot_idx);
>                 if (!ret)
>                         boottime_check = 1;
> --
> 2.43.0
>
