Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D50ECA5FA1
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 22:42:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C713C60625;
	Mon, 28 Sep 2026 22:42:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JhZ7TKNqwN9E; Mon, 28 Sep 2026 22:42:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 0B4C0605ED
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790635346;
	b=qdFHdoOxGmu/np53ZYE7Kz14j3UpU2kbxyM5HGlSfVwHjDeaHjSlY0GH+FNBJwfNK0X3
	 dmKkbid+GkpYtH/fogRWOhTK8yJoid3FAG8AWUbYu9xpoX/IyyyhPPRh0DFwr8aXlKftN
	 UpQ7NpS9iPe7N3gyOnuPQEJ31VFnvFK3wIiITBaLKuQnVbYTIvfsn+O3fiR3nhCAOmcNI
	 Uqvk1vbSc8bATKZ81V4Vqgl20wRdSLjDLghmFVTKHMrp8Q+N4PGBCi86mYQl88GHYLGRf
	 5QQjJvQe7ImvSmvjqA8nhbl9HRdRgiBewKp7qSPIw1X4YobVgVLAKNrLNsorNdjmu2A==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790635346;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=k4bHYO0Aj5K9z4OG508MsV17aS86rGWAqZOFnrn40ig=;
	b=RnJ6Qhl6gaAoxWR71RAi9BBU4+psaWlKWtqNYQ0RxQHU1Gc34s9f2IjLfTkGdS8aGcfi
	 4w3lHb+wSGOSZFaSxM5bs32jqnebK4kF1vIySYwihJ/CK7q7yOuPOJ86kKbFznQENFkow
	 5OLit1ZzN4ShjAg3vLlxkARVVBxsce/azzKPQynhJws30quTMa9cqDBq6V5UYqWnci0Pm
	 bnxIqZezRu/9PJY0gHLa5101t0ur2zWdNsnWo99L4ZLc7tybp+3yZQ/d3Gk2q3/cTlQI3
	 9NtVJztzy0sJGa//ZHQUO+s7R0Dtv1o2HETeU63WL0NDzLb4g5pn4+92cMtIQKmxRmA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=LZsk9XrE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790635346;
	bh=k4bHYO0Aj5K9z4OG508MsV17aS86rGWAqZOFnrn40ig=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZQmJzW0pXW3gJ32tCSVf7kMr5DYG3ihlgxV3odl4qU7aq67etR4HsnoVkpCD/P+5n
	 +opFL4OQX/HVH7dp8xjAVhoSneHAvHl+dbvLQte6TfNTDZuYfoSexQHFiPA5WklQg+
	 4cjEPCM1/AUwCmXkqV3G/So6cIGcJVreXBw7gOhEzK9/DgmuzmXTohYBuV8yTn6es6
	 7Z6Eo8LWTg16OVDDgaGO3pP9Qf1a84IEhaRZO8teYqpUM0PtRaVptqI1tjVEC+V9mP
	 628PY+DyuLmcrdJVWiQ9E9MngQ+Omb9wUxmdBdpXDWDC2mKHv9f9/kaIhHQS0SPqL1
	 Nle/nybhJFCkQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0B4C0605ED;
	Mon, 28 Sep 2026 22:42:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 34CBB335
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 22:42:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 32117605ED
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 22:42:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dnKWIhKYFSvq for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 22:42:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 7BD4B605B7
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:3b::10"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790635344;
 b=Vrb8+2eNUvSqGe3qodg8ABgcBPbt2d9lVsgLOPfirvkpcSZ1CCN8ksBwWO79edLrFUgy
 BMYg6mTL4Q+6/p9PrR8fshseMmSlFWds3wPfA1P66gSIrwFy5RzJ2OpkKxaObkc0VB6cL
 huSvWFq2Za6yPajDlY3zVH22CcPK/HBoA9dSxnXH5iWWXsxBKxtlfv+QFoDAgn2C1jO1p
 U2JMJowz1UX9c5DEx7s8gYuTbdf/U66rjo3VCnPlPYlV8OA/tTM5s/ASeL2S90yuaQTQI
 YKyZ78pTfVYdzqtxw1bVK+taIS1p5FjyodlyBfRUqTI8l74ukkBny53oU3xAMzdpSKw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790635344;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=k4bHYO0Aj5K9z4OG508MsV17aS86rGWAqZOFnrn40ig=;
 b=UM5vFkMuH68Qad3Y5MlmSlgULJIbOwS22a05ATJlj3Brb2usB4wLibMfFP4K3mtIR+fI
 g/lIdTGvdkgQmE0VKzViV41pFz0ZpijtTFaJfki4o5Qwzr/J3YPK7R27r2dSPk8iDIOV7
 k48btmjjS/wYucYra4VB9NcvQ8AX8q8sWHUtOd91vVrSqIAuT0/paTmwZjvLZNkbNmVW+
 2q1mx65IMGuPfIOtYNLQiZDedjNDzdGzCWC1nlcXocR2wMgfOXNlDYdHE9QfvHjE+NztP
 0vWZMsdvKO1y/mRo4jWx0r/9G9GTiZG+T0cbSXSr++4YRof6TyTCe0v382eaLoh/cyQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=LZsk9XrE; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:3b::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:3b::10; helo=mail-pz2-x10.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=LZsk9XrE
Received: from mail-pz2-x10.google.com (mail-pz2-x10.google.com
 [IPv6:2607:f8b0:4864:3b::10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7BD4B605B7
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 22:42:23 +0000 (UTC)
Received: by mail-pz2-x10.google.com with SMTP id
 d2e1a72fcca58-85469b355ffso1507077b3a.1
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 15:42:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790635343; cv=none;
 d=google.com; s=arc-20260327;
 b=QemYNJld7FCzWvjFrYzX9OTPyuLd6BBIJIqNfsX/O1LuYEDG8H4oKR/IRmQszWNgB8
 Yz/0r+MkLpp0zD15Ufkb1h6RvcTVstnVXD8ZfVgndHwB3CaRFwyXW/+hgU0sg3F+MbVS
 yUru0KOLgx2gweHN4w4LrK8jb9JiKJwwSBNWxXOsqFb2w09ZwgTvDXnVDYETaAsGxOEv
 3o2W4ONuz5ye2C2h+1O4WVpzH6k58thXaZoqoggzmaxTQ0tZcU81Hv341qMoHwmzD0V4
 D6NsO9QpGA2ludq6De5pu6uIfjMPToOE0jvNnRteQ+3MjdkKAEFf5drbOWxG19ODugA3
 HM/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=k4bHYO0Aj5K9z4OG508MsV17aS86rGWAqZOFnrn40ig=;
 fh=dPyPOOefYxHYYotWLJJuhghs4AkMVFgOnj2kFkbXm/c=;
 b=jU0hgI51rt2BrqyMcWaTVE2PSJksVKow2Rqi420BZ/uwFGNbCDHSguH756ywHxdnw8
 XUSZvBkwOi+mFqETpdYqxeLZc/WVjazjP6sMPVPH6QePzyCJE++2v+HOjZXHxNCGkNlp
 GMrLMV6XMTEMORhqMGAdGMspx/Ma3jBbBILISLQLwGhwk6r1+IeVXRxr5NOC6gQLZeRa
 sTTIVhLuF98ju2MZrW5ds1HvWSZKHczlztsU7DS8ylDHf1ibfBvEVUG3TpKw8EtCQYnm
 3K2haQmiJbKDMekUk45Irp2fuTJ25krgSuZg0suAGWUt9Xe1tb+OomRKR8brzZG5h9xM
 GYDg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1790635343; x=1791240143;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=k4bHYO0Aj5K9z4OG508MsV17aS86rGWAqZOFnrn40ig=;
 b=LZsk9XrEafyyiBTSx7TVUhKyja2Amww2bhUZmLBl6AxFoRUmm/VSyLAt73M1S1JOQc
 IQGiH5PtOGzkTqHeXYnUY2Re3tfLbYUFyu0SmCNazxrSy6AiAHB3NYZwAUi8Xdk0pTkt
 HWiYrPltwhAw5tkDYsMdrvw82gYq575GT3AWk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790635343; x=1791240143;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=k4bHYO0Aj5K9z4OG508MsV17aS86rGWAqZOFnrn40ig=;
 b=IZoeym1owGicP3JbA8U00Q4z6q/tvhJPtaoUQKzfgqPamFyXxiViYBovoFWKHkD2dd
 ivW0aR0sSxe+9wMBkAyJVjsLHCryWVaVlcBafTAe3rTLUwmuxFR8+uykfT9TpXGVm2VQ
 RTqtNRygHwLxzffZLxsb1AO8h0P6bgbnVtwD1wv4BMnHfSoB2LPbmkBAz/Y9DkujOHkg
 1Mm/x7ZT7sOvO4QRVYEugYyGscPkz0HmMsTAySlRNBQZyfaxE7VNIE/+aol7uteiiv4+
 LOl+DuhoKIlxk7P0BqVriv3SAqU0p5t1QGn5Dvt/xduNi2gccpmUdGyktAA83zVwytbS
 fZnA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzcHRnK1PP0iV04d/H5k5B3buPGeKjpzFEy8cKGmzdIWTshf+5J3E0SZTCGH2XFMlslHpOJhX0=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mBGlnRXunxZoX0BSg8T2bwdBe9gfXwAeeG+dJjkR/8Uz2i2a9Q
 zOUiqHFFCHhz0qHnWLQ5uttUriXjPaJyHl4UujxTpk+1mTL4BA7qKnnIkZpa+CakU/f8F+HQwYA
 AFQeejX81yqoMIOrkwwMV8ZgMGq6VXmRY3m8D0R8o
X-Gm-Gg: AYBFou1CGHuOK3qYyTeUoUsIYeEl6SZ0fsNB7NxfaV3tQ2LMtLRxaKh/dARK49ng4iM
 4imCmBvq6/n3I1ridqtOVzZjryRwVQB/jCQC2GVQN+7Xdi3MYAhy5+d1o3PIwlbXt1ljOB4iN5N
 3pUBGFIYBobac6VBgEz8AYLVu8dUtAzHMnd1n9yxKZcpbJqK8pFxTtT4e7rv/I3Q3kgTd5QTaYD
 /OACky5e8b6+NXo3amlnNaiX1pqq6OU/ru0/Wq3NCL8gINJ5lpinAl5/n2O/xqTDMWqGri05FIM
 qnDqUlnKtx9S9CU+EhaDy8J7sRByIJNI6zdz4497HI+tkY/nfecjFCq50Q==
X-Received: by 2002:a05:6a21:2d93:b0:3d3:ad3c:49a7 with SMTP id
 adf61e73a8af0-3de0e74543cmr12193221637.21.1790635343311; Mon, 28 Sep 2026
 15:42:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260928064041.1432227-1-sumit.dhami@oss.qualcomm.com>
 <20260928064041.1432227-6-sumit.dhami@oss.qualcomm.com>
In-Reply-To: <20260928064041.1432227-6-sumit.dhami@oss.qualcomm.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 28 Sep 2026 16:41:33 -0600
X-Gm-Features: AclHuK-zYkHAY_z_GQXzGUHr7EQ3YhvA28xQH-XXfIK9XrOkXJnjfdrlvC44s70
Message-ID: <CAFLszTiW4X0OfrqvVcvkmiX_VvzfAS-VhSempZt5nw58p_NknQ@mail.gmail.com>
Subject: Re: [PATCH v1 5/8] cmd: gpt: report partition attributes via 'gpt
 setenv'
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
> cmd: gpt: report partition attributes via 'gpt setenv'
>
> 'gpt setenv' sets a series of gpt_partition_* environment variables
> describing a partition, but does not expose the GPT partition entry's
> attributes field.
>
> Set a new gpt_partition_attrs variable holding the full 64-bit
> attributes value as a hexadecimal string, when CONFIG_PARTITION_ATTR is
> enabled.
>
> Signed-off-by: Sumit Singh Dhami <sumit.dhami@oss.qualcomm.com>
>
> cmd/gpt.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)

> diff --git a/cmd/gpt.c b/cmd/gpt.c
> @@ -796,6 +797,16 @@ static int gpt_setenv_part_variables(struct disk_partition *pinfo, int i)
> +     if (CONFIG_IS_ENABLED(PARTITION_ATTR)) {
> +             char attrs_str[19];     /* "0x" + 16 hex digits + NUL */
> +
> +             snprintf(attrs_str, sizeof(attrs_str), "0x%016llx",
> +                     disk_partition_gpt_attr(pinfo));
> +             ret = env_set("gpt_partition_attrs", attrs_str);

The other hex variables set here (gpt_partition_addr,
gpt_partition_size, gpt_partition_entry) come from env_set_hex(), so
they have no 0x prefix and no zero padding. This one is formatted
differently, so scripts have to treat it specially. I suspect '%llx'
would be better so it matches the existing variables, unless there is
a reason for the prefix. What do you think?

> diff --git a/cmd/gpt.c b/cmd/gpt.c
> @@ -796,6 +797,16 @@ static int gpt_setenv_part_variables(struct disk_partition *pinfo, int i)
> +             ret = env_set("gpt_partition_attrs", attrs_str);
> +             if (ret)
> +                     goto fail;
> +     }

Since you are adding a new feature you need a test, and this patch is
the natural place since it exposes the value where a test can check
it. Please can you enable CONFIG_PARTITION_ATTR in
configs/sandbox_defconfig and extend test_gpt_setenv() in
test/py/tests/test_gpt.py to check gpt_partition_attrs for part1
(bootable) and part2? That also covers the read path in patch 3 and,
with a 'gpt write' using attrs=, the write path in patches 2 and 4,
which currently have none.

Regards,
Simon
