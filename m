Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C42606A326
	for <u-boot@archiver.kernel.org>; Tue, 24 Nov 2026 13:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=BlHnCH3X;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=LeLn8ygR
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5481080FD8;
	Tue, 24 Nov 2026 13:10:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vi3BsysZSqpD; Tue, 24 Nov 2026 13:10:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7952A80F38
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795525855;
	b=Wx0V6nU+JNW14RBYq2FzpQb+1qBTDjLLzN93A3XmBnGXsafvorNc5fpIWcasQXeLYR1D
	 58hLR55Blrt+46MHgNdcJcUon2efez1ff0F4FMAJaKVI83WxZDk7WGayC82bWePs5nWMO
	 dLBHhPpVFlUIHVwM6gJ+ph8YOU1ZYoBpHZJZmuDFu7rXLkTgQvrEvQVTsWAZcmWqxK32i
	 UFc042QIk+IWEr6pFFKXFJTl17/qNXY7inDaMw6Bkw6d5g6uaAw83lMC0Mt7x1xPmV2o3
	 lAGFyMoBWeWqkkeK0VRKNFeTIA9kGQhJub5I536/IDyN+3Say9hiKjVaRSqcb332oUQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795525855;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=nsxRxadKKRVaGllUPFydh2gHp8EKFKSYrC03w/MGvWM=;
	b=EeK0iOZNEcIpCEtf4s36QU4EKwD96slhPprzB3atcJvOHCxEqqWV6aS/yHYGwFOfHJSY
	 n8nxxpVcFlcShFEHYTS+yv01ew2Au32kvF8KFmMSMbIsiWw6S2M/Xjz5MYZpSL/Bu6Rz9
	 LGL+Jwi2kpC5Le8fYPb4Uu8MBRKpBsQ/atoSVUrAoFhyIyDqeoh5BggzDYuU4nlREWyO7
	 jwpCytO9J1Em9QSGOGFTzgYxGuxRBlKMvR/Tdmigm3yMeifS6m1S85l1L9XZ3awJBHMiT
	 lKP3+AdrbHq4U8ra2v/0slNX6PE4CYnVj81GbwKxTyhe+BaqsF9P5U1DSLCniEG2Svg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795525855;
	bh=nsxRxadKKRVaGllUPFydh2gHp8EKFKSYrC03w/MGvWM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BlHnCH3XIfZNcWbczLrDJKvtzWQDqz4aFRHI7CmUVc10fMmZD6lNRLcdNQ4mefc7Y
	 v+OH7seTrZqsSNsNzXl4OiEtX0LkqCpt+1GAdFmV3TkKjCEh1rGBri5hf/1CTp4Av2
	 5Jub7Qbq3zHlqYUcqnb6DhmUx0g2imUPfzy/qoIVit2i8/FKyrL/CqGE/j+zufCVWS
	 uf7F/IPROSWipu+55zGBDKtD+8vPgMzPY9U+pZs4ScUrkenMsAqY4PiosbdGC7c7PB
	 gYfVi5eDC1UR3sgBK3/OaP+BU/T/diwTSlJK7XSiy/rSd/wIX5eju7AbM6n/0bh7Bp
	 rn5Z/ffHdBzAQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7952A80F38;
	Tue, 24 Nov 2026 13:10:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id B3C4D79D
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 13:10:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9ADD040116
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 13:10:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id opgVFIm-I_6E for <u-boot@lists.u-boot-project.org>;
 Tue, 24 Nov 2026 13:10:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 9373E400AC
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::b136"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::b136; helo=mail-yx1-xb136.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=LeLn8ygR
Received: from mail-yx1-xb136.google.com (mail-yx1-xb136.google.com
 [IPv6:2607:f8b0:4864:20::b136])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9373E400AC
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 13:10:52 +0000 (UTC)
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-6798eb0d190so3699368d50.3
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 05:10:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795525851; x=1796130651;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nsxRxadKKRVaGllUPFydh2gHp8EKFKSYrC03w/MGvWM=;
 b=LeLn8ygRKY7DcQF/rpXQoy1GJmtvrRdj910tpqvsqd/pVqg0jmeZFy3HMXfSowgeuS
 kFZE5aStbDdEBU8KP9WMn2bufwYt3XAQmXQwfP8jcfTeYVgrrG5ucaowYBHSddkR/ivi
 zPvnTNVJmqh6kIOjHiB8OQ5WD75PMEq2CfkLOE04Mkzn2T0n0Mcn3gMJRybfZUplp+hd
 291L58vfpUnOWKSeqIHPNfsxCbENjnVJWp3V8PhR4xbDWzxGVdDPIVNaP3f8i+zDruTK
 EKHbnfoOR+h+Q6hr4+lvewiVUclKv7VaAcU7b4bw9AYEfYCrHDcXm/s1vOnlvM02RG1J
 nhaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795525851; x=1796130651;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=nsxRxadKKRVaGllUPFydh2gHp8EKFKSYrC03w/MGvWM=;
 b=FKT/mEAyohsD5ocRt4c8+m2O2tlrQinaPqKom/J+4IddnuOsoN6jujlpzPLfx7EyaW
 DQHdvSUzOhkjVbXrGFdyleKbhRU16BYBrODD2SBANF6fLPE2LRa/QAwN4UuL4//OJxyr
 n8vvIrNQ/z1OpdMC7hGu/FGzkBewy7tFY+k8zpBBeo7cXPpL86aBvVr0xw1eN6jGgMMT
 15xcy0wgsn81uOm6mnrDUe+aGd9uHOHBqFd81XhXvK7A9ztyVQcQ1icT9izySQKihHNg
 8q/Uw85peTdwJSr3DaZHWtNJZd1liH/2Em/P0l2M67WrJFA7L7PQgivvRjkXs6emt7I1
 qkRQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGdgYAppewUg1QtGLugKlmav/N0VAZk4xduT87Htu6XPO3vP7kHPom80/lC7WZiZGkI9iFi2Qo=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/ag3zBcxLsnKk9ilnU9Z8ci4fZQHe1b6OQDqqvySBhrYP4Pwp4
 tRRXJvPUUrV16m5oQR/qsvDLT0hqSWQm3Uh7zfWmnwk/53cUirnQWVyq3MNl3sUpd7waoiguueq
 JNrhElnTAU/GhMDTzDdUXfwaHAGUQav104ca9JW4Nn9jrrvyrOh/z0gvIOQ==
X-Gm-Gg: AZFdTZfy5UNtLkqFRqU+znyVwawcf5hOnJNAqdOh4jEJigCdPiguP8V+EzZ1CdA+aOl
 YBLbszs2wf2DMQPMtP+SjxqUlLlg+H133AaOB0Pzgfm40Mz0my4O0RnHd1gS7s1ZNvo0V00X4Tg
 5xaa58xMk6khWykfnZVjDih82ItmfwdUw5w7ERJ1UKkONa6XwcKG4nX+5saB7/hZCDWjXPGDbIu
 xIKpONvexsFu74Bz08bNWncX0F3J7OfzDpzswXUnsy8z8We1FoPvIZEKZmON84rnqOBxBC6KQHh
 OIzIED9IYTyRlFiXiBvfwJhDJ2xozoc3dDfVklDA9vSo5HckdFN64DnvkQgh5k2Mx+xBeOBOhG9
 IuBCh86R4egFwfB+Y8jER9dmd4UvlblqPy4edd8QTUndFEFV+gGnI5WwR3pLhukuv2Re/Dn9Cro
 swCQfsXA3fRByZZBtoz9OBNIqBRz71JRsF2BbA3rEiCkuSfdsIglQG3gfYezahhSyXIyuhUfWiO
 hLCIcv7MY5Y57XvFLQpdaTbi9NVk5H9bhALLrjmb/skrAsxKyzStT4WZ8Otd2cqROZfY7vQ66Lp
 xBNjTf6S0b3ia9C/ViBYY0IHbk7FdR2vWOWFGKiZhFqw+vIrVoelkpCF7pBTCvwJgFZ9F4P1vU/
 i8wjGMCoEIhVz40ByHZobIkcmOPEsQfqvFw/zdvwDmI5pqE3yc3eLP/oQNY01MM1PtUGvQjY7xb
 zOJQrItpu1SkfrQyiaPw2zy0tEkDXG1GNtsdamKjWBiDkLncsJ29Z8NyqXZyLIBmBHOayyYPs=
X-Received: by 2002:a05:690e:444:b0:67d:ea44:ef04 with SMTP id
 956f58d0204a3-67df44871e7mr4692066d50.94.1795525851238; Tue, 24 Nov 2026
 05:10:51 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261103-spl-bloblist-pass-regs-v1-0-bbbbb7e65fdd@baylibre.com>
 <20261103-spl-bloblist-pass-regs-v1-1-bbbbb7e65fdd@baylibre.com>
In-Reply-To: <20261103-spl-bloblist-pass-regs-v1-1-bbbbb7e65fdd@baylibre.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 24 Nov 2026 15:10:14 +0200
X-Gm-Features: Aa3M54qpk2s6S5WlQK-88xIQM_4eNg4bJ2b67r9y3L3NPg9v8wJ9kIzTqkzSOLU
Message-ID: <CAC_iWj+9--zdYHX-omvQ9LapuSHG-uv0REnCEoEzukbkDC6viw@mail.gmail.com>
Subject: Re: [PATCH 1/4] bloblist: add bloblist_get_reg_conv()
To: David Lechner <dlechner@baylibre.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Julien Stephan <jstephan@baylibre.com>, Carlo Caione <ccaione@baylibre.com>
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

On Tue, 3 Nov 2026 at 23:26, David Lechner <dlechner@baylibre.com> wrote:
>
> Add bloblist_get_reg_conv() to get the register values for passing the
> bloblist on according to the Firmware Handoff spec: the FDT address, the
> signature and register conventions version, and the transfer list
> address. It is the counterpart of bloblist_check_reg_conv(), which checks
> these values when a bloblist is received, and shares its signature
> calculation.
>
> This allows U-Boot to pass its bloblist to the next stage in registers
> instead of at a fixed address in memory.
>
> Add a test that passes the values from bloblist_get_reg_conv() to
> bloblist_check_reg_conv().
>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>  common/bloblist.c      | 36 +++++++++++++++++++++++++-----------
>  include/bloblist.h     | 16 ++++++++++++++++
>  test/common/bloblist.c | 24 ++++++++++++++++++++++++
>  3 files changed, 65 insertions(+), 11 deletions(-)
>
> diff --git a/common/bloblist.c b/common/bloblist.c
> index 846c8047f74..4269a49ef99 100644
> --- a/common/bloblist.c
> +++ b/common/bloblist.c
> @@ -664,22 +664,36 @@ int bloblist_init(void)
>         return 0;
>  }
>
> -int bloblist_check_reg_conv(ulong rfdt, ulong rzero, ulong rsig, ulong xlist)
> +static ulong bloblist_reg_conv_sig(void)
>  {
>         u64 version = BLOBLIST_REGCONV_VER;
> -       ulong sigval;
> -       int ret;
>
>         if ((IS_ENABLED(CONFIG_64BIT) && !IS_ENABLED(CONFIG_SPL_BUILD)) ||
> -                       (IS_ENABLED(CONFIG_SPL_64BIT) && IS_ENABLED(CONFIG_SPL_BUILD))) {
> -               sigval = ((BLOBLIST_MAGIC & ((1ULL << BLOBLIST_REGCONV_SHIFT_64) - 1)) |
> -                        ((version  & BLOBLIST_REGCONV_MASK) << BLOBLIST_REGCONV_SHIFT_64));
> -       } else {
> -               sigval = ((BLOBLIST_MAGIC & ((1UL << BLOBLIST_REGCONV_SHIFT_32) - 1)) |
> -                        ((version  & BLOBLIST_REGCONV_MASK) << BLOBLIST_REGCONV_SHIFT_32));
> -       }
> +                       (IS_ENABLED(CONFIG_SPL_64BIT) && IS_ENABLED(CONFIG_SPL_BUILD)))
> +               return ((BLOBLIST_MAGIC & ((1ULL << BLOBLIST_REGCONV_SHIFT_64) - 1)) |
> +                       ((version  & BLOBLIST_REGCONV_MASK) << BLOBLIST_REGCONV_SHIFT_64));
> +
> +       return ((BLOBLIST_MAGIC & ((1UL << BLOBLIST_REGCONV_SHIFT_32) - 1)) |
> +               ((version  & BLOBLIST_REGCONV_MASK) << BLOBLIST_REGCONV_SHIFT_32));
> +}
> +
> +int bloblist_get_reg_conv(ulong *rfdt, ulong *rsig, ulong *xlist)
> +{
> +       if (!gd->bloblist)
> +               return -ENOENT;
> +
> +       *rfdt = (ulong)bloblist_find(BLOBLISTT_CONTROL_FDT, 0);
> +       *rsig = bloblist_reg_conv_sig();
> +       *xlist = bloblist_get_base();
> +
> +       return 0;
> +}
> +
> +int bloblist_check_reg_conv(ulong rfdt, ulong rzero, ulong rsig, ulong xlist)
> +{
> +       int ret;
>
> -       if (rzero || rsig != sigval)
> +       if (rzero || rsig != bloblist_reg_conv_sig())
>                 return -EIO;
>
>         ret = bloblist_check(xlist, 0);
> diff --git a/include/bloblist.h b/include/bloblist.h
> index fcd290eeb16..cdb5764cf55 100644
> --- a/include/bloblist.h
> +++ b/include/bloblist.h
> @@ -536,6 +536,22 @@ int bloblist_init(void);
>   */
>  int bloblist_check_reg_conv(ulong rfdt, ulong rzero, ulong rsig, ulong xlist);
>
> +/**
> + * bloblist_get_reg_conv() - Get the register values for passing the bloblist
> + *                          according to the Firmware Handoff spec.
> + *
> + * This is the counterpart of bloblist_check_reg_conv(). The register that
> + * must be zero is not returned. Call bloblist_finish() before passing the
> + * bloblist on.
> + *
> + * @rfdt:  Returns the FDT base address, or 0 if there is no control FDT in
> + *        the bloblist.
> + * @rsig:  Returns the signature and register conventions version.
> + * @xlist: Returns the transfer list base address.
> + * Return: 0 if OK, -ENOENT if there is no bloblist.
> + */
> +int bloblist_get_reg_conv(ulong *rfdt, ulong *rsig, ulong *xlist);
> +
>  /**
>   * xferlist_from_boot_arg() - Get bloblist from the boot args.
>   *
> diff --git a/test/common/bloblist.c b/test/common/bloblist.c
> index 797bde27025..23def33ab6f 100644
> --- a/test/common/bloblist.c
> +++ b/test/common/bloblist.c
> @@ -605,3 +605,27 @@ static int bloblist_test_blob_maxsize(struct unit_test_state *uts)
>         return 0;
>  }
>  BLOBLIST_TEST(bloblist_test_blob_maxsize, UFT_BLOBLIST);
> +
> +/* Test that the register values for passing a bloblist pass the check */
> +static int bloblist_test_reg_conv(struct unit_test_state *uts)
> +{
> +       ulong rfdt, rsig, xlist;
> +       void *fdt;
> +
> +       clear_bloblist();
> +       ut_assertok(bloblist_new(TEST_ADDR, TEST_BLOBLIST_SIZE, 0, 0));
> +       fdt = bloblist_add(BLOBLISTT_CONTROL_FDT, TEST_SIZE, 0);
> +       ut_assertnonnull(fdt);
> +       ut_assertok(bloblist_finish());
> +
> +       ut_assertok(bloblist_get_reg_conv(&rfdt, &rsig, &xlist));
> +       ut_asserteq((ulong)fdt, rfdt);
> +       ut_asserteq(TEST_ADDR, xlist);
> +       ut_assertok(bloblist_check_reg_conv(rfdt, 0, rsig, xlist));
> +
> +       ut_asserteq(-EIO, bloblist_check_reg_conv(rfdt, 1, rsig, xlist));
> +       ut_asserteq(-EIO, bloblist_check_reg_conv(rfdt, 0, rsig + 1, xlist));
> +
> +       return 0;
> +}
> +BLOBLIST_TEST(bloblist_test_reg_conv, UFT_BLOBLIST);
>
> --
> 2.53.0
>
