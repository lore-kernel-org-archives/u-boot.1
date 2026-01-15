Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A39C2D3CCB2
	for <u-boot@archiver.kernel.org>; Thu, 15 Jan 2026 06:10:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 719A5803F5;
	Thu, 15 Jan 2026 07:10:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="aCnKKoox";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2EA2B82C7F; Thu, 15 Jan 2026 07:10:52 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A73380077
 for <u-boot@lists.denx.de>; Thu, 15 Jan 2026 07:10:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 92ABE40D72;
 Thu, 15 Jan 2026 06:10:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E909C116D0;
 Thu, 15 Jan 2026 06:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1768457447;
 bh=N7TXPA+0MUKqPkAEdJUTsKjJB3JPBDf8ZH6pFjQy6Y8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=aCnKKooxz7GkfMGG0gqWRXcUftvgPI/ayJBjn57fpcEFWIYv3abbSUb52QlHBqEer
 z33lqP9zdgkk4pcNUOwje1HGDbDPDyvXaZvuIcrC/eGjNlpWrDn5C9VWM4I8+JiMh4
 bc5Fx+GtZWdb4P+RiD+ahkcBOHVHrPMEwfnDBViHbrVrUoSQjby0DlJ9Rmtd7OYIMx
 oAECvKB+l0kstrCb+gBdcOhHSeYIOUcCDeY8TuvjzmSrn7mJaHdAlEKoHeKnCgp9W0
 5P6PsU1C1yGux5lXbvDUFucqMVH5PaRxLLJNiaDJTrjBJ+7kLDds1EuT2/aJcAzCVh
 hZ/H/ybC4z4Kg==
Date: Thu, 15 Jan 2026 11:40:40 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Casey Connolly <casey.connolly@linaro.org>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, trini@konsulko.com,
 neil.armstrong@linaro.org, jorge.ramirez@oss.qualcomm.com,
 varadarajan.narayanan@oss.qualcomm.com, tonyh@qti.qualcomm.com,
 Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: Re: [PATCH 2/2] configs: Add generic qcom_tfa_optee_defconfig
Message-ID: <aWiE4LygCijxYOS2@sumit-xelite>
References: <20251229114312.668068-1-sumit.garg@kernel.org>
 <20251229114312.668068-2-sumit.garg@kernel.org>
 <c0bc6cab-6eee-40c2-b6f7-ff14d91906c5@linaro.org>
 <aWDgNIR4jcNcUZ6W@sumit-xelite>
 <c4cccc8f-639e-4806-992a-2e7c950c2c7b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4cccc8f-639e-4806-992a-2e7c950c2c7b@linaro.org>
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

On Wed, Jan 14, 2026 at 03:56:02PM +0100, Casey Connolly wrote:
> 
> 
> On 09/01/2026 12:02, Sumit Garg wrote:
> > On Thu, Jan 08, 2026 at 05:41:42PM +0100, Casey Connolly wrote:
> >>
> >>
> >> On 29/12/2025 12:43, Sumit Garg wrote:
> >>> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> >>>
> >>> Recently upstream TF-A/OP-TEE has started gaining support for Qcom
> >>> platforms. RB3Gen2 being the first one and more to come. U-Boot in
> >>> corresponding boot flow is packaged as a position independent executable.
> >>>
> >>> So, lets add a generic U-Boot defconfig for Qcom platforms to support
> >>> TF-A/OP-TEE based TrustZone stack. Build command:
> >>>
> >>> $ make qcom_tfa_optee_defconfig
> >>> $ make -j`nproc` DEVICE_TREE=qcom/qcs6490-rb3gen2
> >>
> >> This would be better suited as a config fragment rather than a new
> >> defconfig imo.
> > 
> > That's fine with me to add it as a config fragment.
> > 
> >>
> >> But more importantly, enabling OPTEE support in U-Boot doesn't imply
> >> that it will be used, just that it's supported.
> > 
> > There are real use-cases of OP-TEE in U-Boot for Qcom platforms like
> > secure EFI variables based on OP-TEE secure storage. Have a look here [1].
> > 
> > And sure there will be more such use-cases like fTPM, KASLR etc. can be
> > supported based on OP-TEE.
> 
> I was referring literally to the fact that CONFIG_OPTEE being enabled
> doesn't imply that OP-TEE is running, it's faulty logic to assume that's
> the case and add nodes to the DT.

I don't disagree here as having a runtime check is always a better
choice then a compile time config option. However, there isn't a common
info method from properietary firmware that says if QTEE is running
instead of OP-TEE.

> 
> I just checked and there is an SMC call that tells you the UUID for the
> trusted OS, referred to as OPTEE_SMC_CALL_GET_OS_UUID in U-Boot and
> OPTEE_ABI_CALL_GET_OS_UUID in OP-TEE. Presumably this identifies OP-TEE
> specifically.

Also, we don't know how the QTEE will react to this OP-TEE specific SMC
call given it's different variants running on legacy and the newer SoCs.
So I would suggest to better gate OP-TEE presence behind a compile time
check only.

> 
> My suggestion would be to make this SMC call if CONFIG_OPTEE is enabled
> in qcom_psci_fixup(), compare the UUID and add the node if it matches.

That's exactly the first SMC call that U-Boot and Linux OP-TEE driver
does to compare the UUID here [1] and bail out of the driver. I don't
see a value of a redundant invoke in the Qcom specific platform code.

[1] drivers/tee/optee/core.c:823:   if (!is_optee_api(pdata->invoke_fn))

-Sumit

> 
> > 
> > [1] lib/efi_loader/efi_variable_tee.c
> > 
> >>
> >> So I think the more appropriate patch here would be to just enable
> >> OP-TEE in qcom_defconfig (assuming the binary size isn't significantly
> >> affected).
> > 
> > The OP-TEE driver in U-Boot itself is probed based on DT and it's not
> > only specific to Qcom platforms but every other platform using OP-TEE.
> > 
> >>
> >> Considering the other patch is based on this assumption that if OP-TEE
> >> support is enabled then the board must be using it, a different approach
> >> is definitely needed.
> > 
> > Yeah that's true even with TF-A boot flow, there is possibility to boot
> > without OP-TEE as well. However, TF-A generally doesn't provide a
> > generic option to detect whether OP-TEE is running or not.
> > 
> >>
> >> When I was looking into this last year I remember discussing this same
> >> issue from the Linux side, there is a good argument to be made that
> >> OP-TEE support in Linux shouldn't be based on the devicetree -
> >> particularly in the Qualcomm case where whether or not OP-TEE is used is
> >> a simple software change, nothing to do with hardware.
> > 
> > Sadly it's true for every other silicon vendor too. But OP-TEE support
> > based on DT has become an ABI unless migration for OP-TEE support based
> > on FF-A comes into picture.
> > 
> >>
> >> So in general I'm not particularly keen on this approach, I think it
> >> /might/ be acceptable for U-Boot to have some fixup code to add the
> >> OP-TEE node if OP-TEE is in use with the idea of phasing that out in
> >> favour of runtime detection in the OS itself. I'd also expect that fixup
> >> code to go in the generic U-Boot DT fixup code that runs before we jump
> >> to the OS (like the EFI DT fixup function).
> > 
> > The EFI DT fixup code is already there based on U-Boot DT. Have a look
> > here:
> > 
> > boot/image-fdt.c:627:   fdt_ret = optee_copy_fdt_nodes(blob);
> > 
> > In general on Arm platforms there isn't any SMC bus to detect
> > dynamically if there is support for OP-TEE or not. That's why
> > platform bus was choosen for the U-Boot and Linux OP-TEE driver. It's
> > similar to how we have the SCM DT node for Qcom platforms.
> > 
> > FF-A bus tries to solve that problem to unify that approach for future
> > platform but U-Boot hasn't yet gained support for FF-A based OP-TEE
> > driver too.
> > 
> > Anyhow, this is the sanest way I can come up with to enable OP-TEE
> > support in a general way for all the Qcom platforms. This is aligned
> > with how OP-TEE support is detected for other silicon vendors too.
> > 
> > -Sumit
> > 
> >>
> >> Kind regards,
> >>
> >>>
> >>> For more information refer here:
> >>> https://trustedfirmware-a.readthedocs.io/en/latest/plat/qti/rb3gen2.html
> >>>
> >>> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> >>> ---
> >>>  configs/qcom_tfa_optee_defconfig | 7 +++++++
> >>>  1 file changed, 7 insertions(+)
> >>>  create mode 100644 configs/qcom_tfa_optee_defconfig
> >>>
> >>> diff --git a/configs/qcom_tfa_optee_defconfig b/configs/qcom_tfa_optee_defconfig
> >>> new file mode 100644
> >>> index 00000000000..c398521770f
> >>> --- /dev/null
> >>> +++ b/configs/qcom_tfa_optee_defconfig
> >>> @@ -0,0 +1,7 @@
> >>> +# Configuration for building a generic U-Boot image
> >>> +# with support for TF-A/OP-TEE based Arm TrustZone stack.
> >>> +
> >>> +#include "qcom_defconfig"
> >>> +
> >>> +CONFIG_TEE=y
> >>> +CONFIG_OPTEE=y
> >>
> >> -- 
> >> // Casey (she/her)
> >>
> 
> -- 
> // Casey (she/her)
> 
