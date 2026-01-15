Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97C45D44C48
	for <u-boot@archiver.kernel.org>; Thu, 15 Jan 2026 13:27:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0BC7F80325;
	Thu, 15 Jan 2026 14:27:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Z1XTbxGZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F84B82BF2; Thu, 15 Jan 2026 14:27:20 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CBF2380077
 for <u-boot@lists.denx.de>; Thu, 15 Jan 2026 14:27:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 6C40A60195;
 Thu, 15 Jan 2026 13:27:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46DF5C116D0;
 Thu, 15 Jan 2026 13:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1768483636;
 bh=ALLZJTGfFJfgfuX2H4CZZLui5dYp0D0Zl9Xb9ldGGH8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Z1XTbxGZ23N4DgGQjn5sLPky5uxRj1whs5LHVc6gauGMrcSkJg2FHpcz0UmZSrT7R
 Y7Gz9C9Q8afPKMm5Zzt8hmxzu7nu23rScoGzUpa+sg9QGgAig9tuaXWSKxmh/QsYIc
 HY0E27sK4q3mi2Jdl9ciruuvmWg3OVXAd7o+EkHZgsbtDtisDhdqBvK7wQqcTF/Mq4
 ehNg2SPzl5Z5JRpywmGXo+ly4EN0cYppaKC+2CM/7y/GTHLboVsifD6W0wMg1ay/mF
 pBebvbzIfkjkWQRLvs0IwUEDaAacuI1ywTwo9HzVEfUPytCbFXmWYdgkgJ5E347md4
 79HJQYFCdSX6A==
Date: Thu, 15 Jan 2026 18:57:08 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: jens.wiklander@linaro.org, Casey Connolly <casey.connolly@linaro.org>,
 u-boot-qcom@groups.io, u-boot@lists.denx.de, trini@konsulko.com,
 jorge.ramirez@oss.qualcomm.com,
 varadarajan.narayanan@oss.qualcomm.com, tonyh@qti.qualcomm.com,
 Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: Re: [PATCH 2/2] configs: Add generic qcom_tfa_optee_defconfig
Message-ID: <aWjrLF9DUPTaSA1c@sumit-xelite>
References: <20251229114312.668068-1-sumit.garg@kernel.org>
 <20251229114312.668068-2-sumit.garg@kernel.org>
 <c0bc6cab-6eee-40c2-b6f7-ff14d91906c5@linaro.org>
 <aWDgNIR4jcNcUZ6W@sumit-xelite>
 <c4cccc8f-639e-4806-992a-2e7c950c2c7b@linaro.org>
 <aWiE4LygCijxYOS2@sumit-xelite>
 <d2f7ed00-0c4f-4587-8dad-e1aaf1177204@linaro.org>
 <aWjc04IqdiZPR1e4@sumit-xelite>
 <1d162515-9bf3-4bf4-90fe-6d2cc37cacfc@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d162515-9bf3-4bf4-90fe-6d2cc37cacfc@linaro.org>
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

On Thu, Jan 15, 2026 at 02:03:29PM +0100, Neil Armstrong wrote:
> On 1/15/26 13:25, Sumit Garg wrote:
> > + Jens (OP-TEE driver author in U-Boot)
> > 
> > On Thu, Jan 15, 2026 at 11:49:49AM +0100, neil.armstrong@linaro.org wrote:
> > > On 1/15/26 07:10, Sumit Garg wrote:
> > > > On Wed, Jan 14, 2026 at 03:56:02PM +0100, Casey Connolly wrote:
> > > > > 
> > > > > 
> > > > > On 09/01/2026 12:02, Sumit Garg wrote:
> > > > > > On Thu, Jan 08, 2026 at 05:41:42PM +0100, Casey Connolly wrote:
> > > > > > > 
> > > > > > > 
> > > > > > > On 29/12/2025 12:43, Sumit Garg wrote:
> > > > > > > > From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> > > > > > > > 
> > > > > > > > Recently upstream TF-A/OP-TEE has started gaining support for Qcom
> > > > > > > > platforms. RB3Gen2 being the first one and more to come. U-Boot in
> > > > > > > > corresponding boot flow is packaged as a position independent executable.
> > > > > > > > 
> > > > > > > > So, lets add a generic U-Boot defconfig for Qcom platforms to support
> > > > > > > > TF-A/OP-TEE based TrustZone stack. Build command:
> > > > > > > > 
> > > > > > > > $ make qcom_tfa_optee_defconfig
> > > > > > > > $ make -j`nproc` DEVICE_TREE=qcom/qcs6490-rb3gen2
> > > > > > > 
> > > > > > > This would be better suited as a config fragment rather than a new
> > > > > > > defconfig imo.
> > > > > > 
> > > > > > That's fine with me to add it as a config fragment.
> > > > > > 
> > > > > > > 
> > > > > > > But more importantly, enabling OPTEE support in U-Boot doesn't imply
> > > > > > > that it will be used, just that it's supported.
> > > > > > 
> > > > > > There are real use-cases of OP-TEE in U-Boot for Qcom platforms like
> > > > > > secure EFI variables based on OP-TEE secure storage. Have a look here [1].
> > > > > > 
> > > > > > And sure there will be more such use-cases like fTPM, KASLR etc. can be
> > > > > > supported based on OP-TEE.
> > > > > 
> > > > > I was referring literally to the fact that CONFIG_OPTEE being enabled
> > > > > doesn't imply that OP-TEE is running, it's faulty logic to assume that's
> > > > > the case and add nodes to the DT.
> > > > 
> > > > I don't disagree here as having a runtime check is always a better
> > > > choice then a compile time config option. However, there isn't a common
> > > > info method from properietary firmware that says if QTEE is running
> > > > instead of OP-TEE.
> > > > 
> > > > > 
> > > > > I just checked and there is an SMC call that tells you the UUID for the
> > > > > trusted OS, referred to as OPTEE_SMC_CALL_GET_OS_UUID in U-Boot and
> > > > > OPTEE_ABI_CALL_GET_OS_UUID in OP-TEE. Presumably this identifies OP-TEE
> > > > > specifically.
> > > > 
> > > > Also, we don't know how the QTEE will react to this OP-TEE specific SMC
> > > > call given it's different variants running on legacy and the newer SoCs.
> > > > So I would suggest to better gate OP-TEE presence behind a compile time
> > > > check only.
> > > 
> > > So you say it's fine to add the optee node, and the driver will bail out if
> > > OPTEE is not present, but it's not good to call OPTEE_SMC_CALL_GET_OS_UUID
> > > in the fixup code to enable OPTEE only if present ?
> > > 
> > > It's literally the same, my point in https://lore.kernel.org/all/b60d5ee7-fa27-4dc1-8a09-964912ec5654@linaro.org/
> > > was exactly that, just call OPTEE_SMC_CALL_GET_OS_UUID and add the OPTEE
> > > node only if present _AND_ if CONFIG_OPTEE is enabled.
> > > 
> > > Move the CONFIG_OPTEE enable in a fragment and we're done, you will only
> > > select OPTEE explicitly on desired platforms, and won't run the naughty
> > > OPTEE_SMC_CALL_GET_OS_UUID on old crappy platforms.
> > 
> > I am still trying to understand what benefit does invoking
> > OPTEE_SMC_CALL_GET_OS_UUID from platform code provides us. Surely it
> > can't be used to detect OP-TEE not present when QTEE is running due to
> > unknown behaviour with QTEE.
> 
> Sorry but what exactly do you expect that will happen if you enable the OPTEE
> driver when running with QTEE ?

The OP-TEE SMC calls are not at all supported with QTEE, so the expected
behaviour is undefined. IOW, the OP-TEE SMC ABI is not compatible with
QTEE. However, it's going to be hit and trial method to see what QTEE
responds to OP-TEE SMC calls. So it's not a reliable source of
information we can use to detect which TEE is present or not.

-Sumit

> 
> > 
> > Jens,
> > 
> > Will it be fine with you to expose is_optee_api() from the OP-TEE driver
> > for the platform code to invoke it independently? Just for the sake of this
> > discussion in case people still insist on it being the right thing to do.
> > 
> > -Sumit
> > 
> > > 
> > > Neil
> > > 
> > > > 
> > > > > 
> > > > > My suggestion would be to make this SMC call if CONFIG_OPTEE is enabled
> > > > > in qcom_psci_fixup(), compare the UUID and add the node if it matches.
> > > > 
> > > > That's exactly the first SMC call that U-Boot and Linux OP-TEE driver
> > > > does to compare the UUID here [1] and bail out of the driver. I don't
> > > > see a value of a redundant invoke in the Qcom specific platform code.
> > > > 
> > > > [1] drivers/tee/optee/core.c:823:   if (!is_optee_api(pdata->invoke_fn))
> > > > 
> > > > -Sumit
> > > > 
> > > > > 
> > > > > > 
> > > > > > [1] lib/efi_loader/efi_variable_tee.c
> > > > > > 
> > > > > > > 
> > > > > > > So I think the more appropriate patch here would be to just enable
> > > > > > > OP-TEE in qcom_defconfig (assuming the binary size isn't significantly
> > > > > > > affected).
> > > > > > 
> > > > > > The OP-TEE driver in U-Boot itself is probed based on DT and it's not
> > > > > > only specific to Qcom platforms but every other platform using OP-TEE.
> > > > > > 
> > > > > > > 
> > > > > > > Considering the other patch is based on this assumption that if OP-TEE
> > > > > > > support is enabled then the board must be using it, a different approach
> > > > > > > is definitely needed.
> > > > > > 
> > > > > > Yeah that's true even with TF-A boot flow, there is possibility to boot
> > > > > > without OP-TEE as well. However, TF-A generally doesn't provide a
> > > > > > generic option to detect whether OP-TEE is running or not.
> > > > > > 
> > > > > > > 
> > > > > > > When I was looking into this last year I remember discussing this same
> > > > > > > issue from the Linux side, there is a good argument to be made that
> > > > > > > OP-TEE support in Linux shouldn't be based on the devicetree -
> > > > > > > particularly in the Qualcomm case where whether or not OP-TEE is used is
> > > > > > > a simple software change, nothing to do with hardware.
> > > > > > 
> > > > > > Sadly it's true for every other silicon vendor too. But OP-TEE support
> > > > > > based on DT has become an ABI unless migration for OP-TEE support based
> > > > > > on FF-A comes into picture.
> > > > > > 
> > > > > > > 
> > > > > > > So in general I'm not particularly keen on this approach, I think it
> > > > > > > /might/ be acceptable for U-Boot to have some fixup code to add the
> > > > > > > OP-TEE node if OP-TEE is in use with the idea of phasing that out in
> > > > > > > favour of runtime detection in the OS itself. I'd also expect that fixup
> > > > > > > code to go in the generic U-Boot DT fixup code that runs before we jump
> > > > > > > to the OS (like the EFI DT fixup function).
> > > > > > 
> > > > > > The EFI DT fixup code is already there based on U-Boot DT. Have a look
> > > > > > here:
> > > > > > 
> > > > > > boot/image-fdt.c:627:   fdt_ret = optee_copy_fdt_nodes(blob);
> > > > > > 
> > > > > > In general on Arm platforms there isn't any SMC bus to detect
> > > > > > dynamically if there is support for OP-TEE or not. That's why
> > > > > > platform bus was choosen for the U-Boot and Linux OP-TEE driver. It's
> > > > > > similar to how we have the SCM DT node for Qcom platforms.
> > > > > > 
> > > > > > FF-A bus tries to solve that problem to unify that approach for future
> > > > > > platform but U-Boot hasn't yet gained support for FF-A based OP-TEE
> > > > > > driver too.
> > > > > > 
> > > > > > Anyhow, this is the sanest way I can come up with to enable OP-TEE
> > > > > > support in a general way for all the Qcom platforms. This is aligned
> > > > > > with how OP-TEE support is detected for other silicon vendors too.
> > > > > > 
> > > > > > -Sumit
> > > > > > 
> > > > > > > 
> > > > > > > Kind regards,
> > > > > > > 
> > > > > > > > 
> > > > > > > > For more information refer here:
> > > > > > > > https://trustedfirmware-a.readthedocs.io/en/latest/plat/qti/rb3gen2.html
> > > > > > > > 
> > > > > > > > Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> > > > > > > > ---
> > > > > > > >    configs/qcom_tfa_optee_defconfig | 7 +++++++
> > > > > > > >    1 file changed, 7 insertions(+)
> > > > > > > >    create mode 100644 configs/qcom_tfa_optee_defconfig
> > > > > > > > 
> > > > > > > > diff --git a/configs/qcom_tfa_optee_defconfig b/configs/qcom_tfa_optee_defconfig
> > > > > > > > new file mode 100644
> > > > > > > > index 00000000000..c398521770f
> > > > > > > > --- /dev/null
> > > > > > > > +++ b/configs/qcom_tfa_optee_defconfig
> > > > > > > > @@ -0,0 +1,7 @@
> > > > > > > > +# Configuration for building a generic U-Boot image
> > > > > > > > +# with support for TF-A/OP-TEE based Arm TrustZone stack.
> > > > > > > > +
> > > > > > > > +#include "qcom_defconfig"
> > > > > > > > +
> > > > > > > > +CONFIG_TEE=y
> > > > > > > > +CONFIG_OPTEE=y
> > > > > > > 
> > > > > > > -- 
> > > > > > > // Casey (she/her)
> > > > > > > 
> > > > > 
> > > > > -- 
> > > > > // Casey (she/her)
> > > > > 
> > > 
> 
