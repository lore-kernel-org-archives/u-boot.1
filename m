Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40F39C54E41
	for <u-boot@archiver.kernel.org>; Tue,  5 Mar 2024 13:15:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7F3E88009;
	Tue,  5 Mar 2024 14:15:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="q1t95XmO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD7C788009; Tue,  5 Mar 2024 14:15:19 +0100 (CET)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A6F588016
 for <u-boot@lists.denx.de>; Tue,  5 Mar 2024 14:15:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-608342633b8so7431647b3.1
 for <u-boot@lists.denx.de>; Tue, 05 Mar 2024 05:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709644510; x=1710249310; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8eq13me9D0mT3pdn+HJ78Y033XhwtevLa9pKlcKglx0=;
 b=q1t95XmO1uiLBuISmG2NXbYxLpXJIysxCGN0Rlem1X10Aqhp6V4KVD4ZC/IIjpgCta
 hUbMbYC1jsE184OG72jNHBbl5zGnJZGIXak/TfgYRBvA/DnegIkKoXDFXX1GCv3Dsimk
 CK71pEBLnTZnnIAinAy/Idvp2cj2234KTFeOEJgmfGGMEQwKA+Or/OcNxH57nu8eWQLX
 1jz0R5rI7m8oWPoA7qOfLJ4h+vG2dclyv8W4ukbyhPAeRoYx59idI8xqwT/3kYSFGFGf
 Pl9EvoT/u1lZgnJDdH1cIKX/nlyz5xQBn4j9Jyb/WJrs4QYN+NkBZvvmKbSDGskMH7zh
 1X0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709644510; x=1710249310;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8eq13me9D0mT3pdn+HJ78Y033XhwtevLa9pKlcKglx0=;
 b=E1Pb/3/pYs6qx1jXyabRQo31rTTuYGQdveXxqzaTQ7m2n5EHXOAKQmeH04vjskQvdb
 8wj2HCFCeHubu1ZjZ3aNoHbd2omhPP6PJg/9ID0omwcWE90ucd0eAkodLJaNQsZOrdu6
 shZ1iFo5pQ+h9VQLWL2h9s3UTvmiASG2Kcx5isOaQQJxCrk7zIV4tnSDBcxoFgpcd/ud
 ZZA++fM1VIP7zyQqrZsBKqVC6Y4BGJ/fulkoQsdmQoxcwod8ZmJXWWAQ5ar3vRBJaZDT
 iLCJ2sxBMfVHI4Xld2P3AjiALwhuyZYwniRPPHi0GVxgBUm9CBh/9F1Wxx51VLoU6aq6
 2vRw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0uLwD482CURYSPxSX4gVn63AAj9pdcDB6c4G7DPCOACk0dVklGX53QcspnmfUUewjTp5xYIAVQDLDHo3vQHXl/hQGWQ==
X-Gm-Message-State: AOJu0Yz+9Ecuhyt9L1CPEj0hVL09ctHefoy41PlLdf+DB9eXVJe3ib61
 DAnZjgyAxGCis3MjbdM/3WJd7ItmH+I9TL2uggivRnUnl8cNhcMjDMPdOi3f8JPFaXCoytqnnGB
 C6MWwvBN35o7f343/YuuajEQHweg1Bbwj1h7s9w==
X-Google-Smtp-Source: AGHT+IGpmcRKLyaEcw5hNNT7SJqVPPNVAYEJT86r3u7snoLb0aAl1p2KObnxrsncTIS2uy0D9ZVg3t2hpA/sh0Bkh+Q=
X-Received: by 2002:a5b:34a:0:b0:dcc:8e02:a6b6 with SMTP id
 q10-20020a5b034a000000b00dcc8e02a6b6mr9884996ybp.2.1709644510384; Tue, 05 Mar
 2024 05:15:10 -0800 (PST)
MIME-Version: 1.0
References: <20240304-b4-upstream-dt-headers-v1-0-b7ff41925f92@linaro.org>
 <20240304-b4-upstream-dt-headers-v1-26-b7ff41925f92@linaro.org>
 <CAFA6WYM6sTEdw+VphKidUqjQW61eW8ZVq+oO35CJVM=5wPoniA@mail.gmail.com>
 <3e17d3e4-e2e1-45ff-9d62-44bf5a8991df@linaro.org>
In-Reply-To: <3e17d3e4-e2e1-45ff-9d62-44bf5a8991df@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Tue, 5 Mar 2024 18:44:59 +0530
Message-ID: <CAFA6WYNHkU2xp+6_+K0JoOpVrAP3ryS2zs+Q2L6Wb+TTVL+mWg@mail.gmail.com>
Subject: Re: [PATCH RFC 26/26] dts: support building all dtb files for a
 specific vendor
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Jagan Teki <jagan@amarulasolutions.com>, 
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Sam Protsenko <semen.protsenko@linaro.org>, 
 Matthias Brugger <mbrugger@suse.com>, Peter Robinson <pbrobinson@gmail.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>, 
 Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>, 
 Michal Simek <michal.simek@amd.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Ryder Lee <ryder.lee@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Eugen Hristev <eugen.hristev@collabora.com>, 
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, 
 Ryan Chen <ryan_chen@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, 
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>, 
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Dai Okamura <okamura.dai@socionext.com>, 
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, u-boot@lists.denx.de, 
 u-boot-amlogic@groups.io, uboot-stm32@st-md-mailman.stormreply.com, 
 uboot-snps-arc@synopsys.com
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Tue, 05 Mar 2024 14:15:37 +0100
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

On Tue, 5 Mar 2024 at 18:21, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
>
>
> On 05/03/2024 12:35, Sumit Garg wrote:
> > Hi Caleb,
> >
> > On Mon, 4 Mar 2024 at 22:22, Caleb Connolly <caleb.connolly@linaro.org> wrote:
> >>
> >> This adjusts OF_UPSTREAM to behave more like the kernel by allowing for
> >> all the devicetree files for a given vendor to be compiled. This is
> >> useful for Qualcomm in particular as most boards are supported by a
> >> single U-Boot build just provided with a different DT.
> >>
> >> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> >> ---
> >>  dts/Kconfig          | 24 ++++++++++++++++++++++++
> >>  scripts/Makefile.dts | 17 ++++++++++++++++-
> >>  2 files changed, 40 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/dts/Kconfig b/dts/Kconfig
> >> index b9b6367154ef..67d9dc489856 100644
> >> --- a/dts/Kconfig
> >> +++ b/dts/Kconfig
> >> @@ -100,8 +100,32 @@ config OF_UPSTREAM
> >>           However, newer boards whose devicetree source files haven't landed in
> >>           the dts/upstream subtree, they can override this option to have the
> >>           DT build from existing U-Boot tree location instead.
> >>
> >> +config OF_UPSTREAM_BUILD_VENDOR
> >> +       bool "Build all devicetree files for a particular vendor"
> >> +       depends on OF_UPSTREAM
> >> +       help
> >> +         Enable building all devicetree files for a particular vendor. This
> >
> > Do we really want to build all the DTBs even if many of those aren't
> > supported by U-Boot at all? I would have rather added Makefile targets
> > for boards which really supports a single defconfig eg.
> > qcom_defconfig.
>
> Yes, for the 4 Qualcomm SoCs currently supported there are 51 dts
> targets that ought to be able to run U-Boot to some extent

Have you tested U-Boot on all of them? IMO, it would be good to make
people aware about supported boards via listing their DTs at least.

>
> $ ls -l dts/upstream/src/arm6/qcom/{msm8916,sdm845,msm8996,qcs404}*.dts\
>         | wc -l
> 51
>

qcom_defconfig currently only supports sdm845 and qcs404.

> What do you mean by a "makefile target"? Like copying
> arch/arm64/boot/dts/qcom/Makefile from Linux? I guess my concern here
> would be keeping it in sync, and introducing additional busywork when
> porting.

See following diff:

diff --git a/dts/upstream/src/arm64/Makefile b/dts/upstream/src/arm64/Makefile
index 9a8f6aa35846..ecc15021cb08 100644
--- a/dts/upstream/src/arm64/Makefile
+++ b/dts/upstream/src/arm64/Makefile
@@ -2,6 +2,10 @@

 include $(srctree)/scripts/Makefile.dts

+dtb-$(CONFIG_ARCH_SNAPDRAGON) += qcom/sdm845-db845c.dtb \
+       qcom/sdm845-samsung-starqltechn.dtb \
+       qcom/qcs404-evb-4000.dtb
+
 targets += $(dtb-y)

>
> We do have a lot of Qualcomm DTS files, it takes maybe 10 seconds to
> compile them all on my machine, but that's only once. With incremental
> builds this becomes largely irrelevant.

Maybe someone cares about build time too but that's not my primary
concern. We shouldn't be giving the false impression that all the DTs
present in the vendor directory are supported by U-Boot.

-Sumit
