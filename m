Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33114FF885A
	for <u-boot@archiver.kernel.org>; Fri,  1 May 2026 06:42:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65AF6839D5;
	Fri,  1 May 2026 08:42:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bX6uTbH0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7801583A91; Fri,  1 May 2026 08:42:27 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6972E81E18
 for <u-boot@lists.denx.de>; Fri,  1 May 2026 08:42:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id C4B7343E51;
 Fri,  1 May 2026 06:42:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34F1FC2BCB7;
 Fri,  1 May 2026 06:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777617743;
 bh=YCvQrwQonDR+N5uSrkhKi0TLiVVFQ+Fa8mI5mYnUhjY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=bX6uTbH0jg6El836r6xHGZokt8i5qvAQG6JTvCG9kNJl5/j6LBLHBNZRjwmE8F6+b
 h2UgqWy2ATuydNaHlUyTrrUKepOMdO6oDMxLyYT5u51gFXjY80YARyX1n4mujhhpaK
 T0cQLU71+6KtAaY0hPCFNwMcESRyKe4xb8S+QMUo8tJAUf100tjDMX49JXO6uz/FaA
 s8l3GUWtltdlCFNjcF2xc7jSlJiVbTBu5F5LHs1A8+P9hG84EJdg9a7ENTYe61Mgp5
 9GbdDIjXeIDMBrxww9Oog5ylQUDXGgRmuhSJaH78wufwl4mJ1sETs1MoO9fuQz2sbp
 YRrnzoUbWm4uA==
Date: Fri, 1 May 2026 12:12:17 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, trini@konsulko.com,
 quic_varada@quicinc.com, balaji.selvanathan@oss.qualcomm.com,
 dlechner@baylibre.com, u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: Re: [PATCH v1 1/1] configs: Rename qcs9100 defconfig to lemans
 defconfig
Message-ID: <afRLSaxbyo8D2yFq@sumit-xelite>
References: <20260417093924.3357296-1-aswin.murugan@oss.qualcomm.com>
 <20260417093924.3357296-2-aswin.murugan@oss.qualcomm.com>
 <0697f98e-a0c5-4d81-873d-1e545ceeb6d0@gmx.de>
 <ff78baf2-7be6-492c-8a54-1e557cb022ef@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ff78baf2-7be6-492c-8a54-1e557cb022ef@oss.qualcomm.com>
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

On Fri, Apr 17, 2026 at 03:50:47PM +0530, Aswin Murugan wrote:
> 
> On 4/17/2026 3:20 PM, Heinrich Schuchardt wrote:
> > On 4/17/26 11:39, Aswin Murugan wrote:
> > > Rename qcom_qcs9100_defconfig to qcom_lemans_defconfig
> > > and update the defconfig to select lemans-evk DTS instead
> > > of qcs9100-ride-r3.
> > > 
> > > Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
> > 
> > Why do you want to delete qcom_qcs9100_defconfig instead of simply
> > creating a new defconfig for the different board?
> > 
> > Best regards
> > 
> > Heinrich
> > 
> > > ---
> > >   configs/{qcom_qcs9100_defconfig => qcom_lemans_defconfig} | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > >   rename configs/{qcom_qcs9100_defconfig => qcom_lemans_defconfig} (91%)
> > > 
> > > diff --git a/configs/qcom_qcs9100_defconfig
> > > b/configs/qcom_lemans_defconfig
> > > similarity index 91%
> > > rename from configs/qcom_qcs9100_defconfig
> > > rename to configs/qcom_lemans_defconfig
> > > index 082106157bb..ad40d5206c0 100644
> > > --- a/configs/qcom_qcs9100_defconfig
> > > +++ b/configs/qcom_lemans_defconfig
> > > @@ -9,7 +9,7 @@
> > >   CONFIG_TEXT_BASE=0xaf000000
> > >   CONFIG_REMAKE_ELF=y
> > >   CONFIG_FASTBOOT_BUF_ADDR=0xdb300000
> > > -CONFIG_DEFAULT_DEVICE_TREE="qcom/qcs9100-ride-r3"
> > > +CONFIG_DEFAULT_DEVICE_TREE="qcom/lemans-evk"
> > >   CONFIG_ENV_IS_IN_SCSI=y
> > > CONFIG_ENV_SCSI_PART_UUID="71cb9cd0-acf1-b6cb-ad91-be9572fe11a9"
> > >   # CONFIG_ENV_IS_DEFAULT is not set
> > 
> Hi Heinrich,
> 
> Lemans EVK is an open evaluation board based on the QCS9100 SoC and is
> intended to be the default reference platform for the QCS9100 family.
> Renaming the existing defconfig
> 
> aligns with the naming of SoC & avoids maintaining two identical defconfigs
> for same SoC.
> 

Please capture this reasoning as part of the commit message.

-Sumit
