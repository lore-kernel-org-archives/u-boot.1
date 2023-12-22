Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30465C41535
	for <u-boot@archiver.kernel.org>; Fri, 22 Dec 2023 13:43:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E475877F1;
	Fri, 22 Dec 2023 14:43:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="BLDFHJbC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9FACC86FF7; Fri, 22 Dec 2023 14:43:29 +0100 (CET)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D20B8775F
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 14:43:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-6dbb650ad59so1137006a34.0
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 05:43:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703252601; x=1703857401; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8xu+dlv+rL1SESGMvkuAJadS/EOjK/fDw8+C9ZtA5TQ=;
 b=BLDFHJbCqyVFaSg+TCrmMDLzoMQJW40p7j7KHDMJQElGgCBQKhiKsmOABnkFno6ElQ
 BgSlUiSQ1gtWxG/p9efd8dQ7SX6C+P0+v9kriplJSHt6KuAyX45th6p+Diyh8HBMJnM5
 n/+UWNTuBIkwSs2HexYHIxWTVOQ57PBCoiTkGcDwR//QXchb1uOe+pfUQGErvPK2VFtu
 P1RDzOS45vWCLCo9rp23J8p9U2crY5z2OrFLJhTB38qimVjFD7SIOFmxxr5y6FYkYvLm
 rf96VritNbNB5EXC4rl6a+OSk+mgSFMee4y/PZ58fFdNP6BPy4dIVS8AoTQTVY+7uAUq
 lb7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703252601; x=1703857401;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8xu+dlv+rL1SESGMvkuAJadS/EOjK/fDw8+C9ZtA5TQ=;
 b=MA4u86okb0/rbD0HYt1ELbwAGQ06ZqBStCoA6S3VKq8VbGcoWuhttfE8ktDXzSKctx
 sODHgKX1SmEABWe6QoE/STZ4W5RzHsJBvmRn090+1g7zoY+jv2joWrTGqf4myhAYWdB/
 3JL9p5Wni1zJdnQVzQ2alCRkHQlKmtC4z9laFTgt7Iqm5kBBC7wPHa3I+q+7fQAbt64p
 Tj6YJ/h+YWQH7wFATwSD/AKV6z3P9Q4uVEoMdaiZ8WxKNqPYDiag+URJW08dvNsLh+YF
 MxzLrkbOObPdVVtUw35D4PmMqqcsUdVsycx7PwoWQMi3gKPei4W/GDJLwHU5vlnqI4VC
 G4pQ==
X-Gm-Message-State: AOJu0YyQ5gTQNbugxDilPI+PFeLev+yXxJXXM+XKjXSgp44ARn3+AbxQ
 Jn7K0OUL2G3YY52KDWyp62JmJArJx1jpmEfLvXqAxrNd5eyn5A==
X-Google-Smtp-Source: AGHT+IFaQ6yTlQEdMv96jme5/w/nrNAA8zEDuGzKCS3A87OL+eF0tZHbXMIUbH2rfEIqQ9GRCVHewHCyGAwCo8+U9pc=
X-Received: by 2002:a9d:6f85:0:b0:6d9:f512:54e2 with SMTP id
 h5-20020a9d6f85000000b006d9f51254e2mr1033241otq.48.1703252600885; Fri, 22 Dec
 2023 05:43:20 -0800 (PST)
MIME-Version: 1.0
References: <20231222061208.3009970-1-sumit.garg@linaro.org>
 <02fdfc4b-113b-409f-8aaf-8f4a04822706@linaro.org>
In-Reply-To: <02fdfc4b-113b-409f-8aaf-8f4a04822706@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Fri, 22 Dec 2023 19:13:09 +0530
Message-ID: <CAFA6WYM8EVY-D_Kptggsvxq0ZrFdP0gQ3y4UEbM+vLu0F8tLjw@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] An effort to bring DT bindings compliance within
 U-Boot
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
 u-boot-custodians@lists.denx.de, trini@konsulko.com, sjg@chromium.org, 
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor@kernel.org, 
 neil.armstrong@linaro.org, caleb.connolly@linaro.org, ff@shokubai.tech, 
 daniel.thompson@linaro.org, dgilmore@fedoraproject.org, pbrobinson@gmail.com, 
 ilias.apalodimas@linaro.org, maxim.uvarov@linaro.org, b.galvani@gmail.com, 
 xypron.glpk@gmx.de, michal.simek@amd.com, seanga2@gmail.com, 
 rasmus.villemoes@prevas.dk, peng.fan@nxp.com, jh80.chung@samsung.com, 
 rfried.dev@gmail.com, marex@denx.de
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

On Fri, 22 Dec 2023 at 13:48, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 22/12/2023 07:12, Sumit Garg wrote:
> > Changes in v2:
> > --------------
> > - Patch #1: excluded gitab CI config check and added commit description.
> > - Patch #3: s/UBOOT_DTSI_LOC/u_boot_dtsi_loc/
> > - Patch #4: s/DEVICE_TREE_LOC/dt_dir/ and s/U-boot/U-Boot/
> > - Patch #5: s/U-boot/U-Boot/
> > - Patch #6 and #7: Picked up review tags
> >
> > Prerequisite
> > ------------
> >
> > This patch series requires devicetree-rebasing git repo to be added as a
> > subtree to the main U-Boot repo via:
> >
> > $ git subtree add --prefix devicetree-rebasing \
> >       git://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git \
> >       v6.6-dts --squash
> >
> > Background
> > ----------
> >
> > This effort started while I was reviewing patch series corresponding to
> > Qcom platforms [1] which was about to import modified devicetree source
> > files from Linux kernel. I suppose keeping devicetree files sync with
> > Linux kernel without any DT bindings schema validation has been a pain
> > for U-Boot SoC/platform maintainers. There has been past discussions
> > about a single DT repo but that hasn't come up and Linux kernel remained
> > the place where DT source files as well as bindings are placed and
> > maintained.
>
> Thanks for doing this.
>
> I really suggest to store information that kernel DTS is directly
> re-used, thus DTS backward and forward compatibility matters, also in
> Linux kernel sources. The point is that sub-arch maintainers should be
> aware of it. I don't think that as DT maintainers we can efficiently
> keep an eye on it. Maybe create a subsystem profile and include it to
> maintainer entries of such affected platforms?
>

From U-Boot point of view, currently we have the config option:
"CONFIG_OF_UPSTREAM=y" per platform which means directly re-use of
kernel DTS. So U-Boot sub-arch maintainers should be aware of
platforms which get converted to re-use kernel DTS.

I suppose we have to relay information to kernel sub-arch maintainers
who aren't the same as maintaining U-Boot counterparts. How about
adding U-Boot ML to CC for whichever DT change gets submitted in the
kernel? Otherwise adding U-Boot sub-arch maintainers as reviewers for
corresponding kernel DT changes works too if that's acceptable.

-Sumit

> Best regards,
> Krzysztof
>
> Best regards,
> Krzysztof
>
