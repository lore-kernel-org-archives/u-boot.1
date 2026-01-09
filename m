Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0367AD1680F
	for <u-boot@archiver.kernel.org>; Fri,  9 Jan 2026 11:02:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 626AE83CDF;
	Fri,  9 Jan 2026 12:02:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QYZ3PJyn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19E2C83E7F; Fri,  9 Jan 2026 12:02:25 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D32583759
 for <u-boot@lists.denx.de>; Fri,  9 Jan 2026 12:02:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id D59B044287;
 Fri,  9 Jan 2026 11:02:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6DB5C4CEF1;
 Fri,  9 Jan 2026 11:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1767956539;
 bh=P0OH8LypfzqPoaqrjHpxRWUh7/A+ppEttOlJ/VLJPnI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=QYZ3PJynYmXK8FVQE7d358PJaNY48ulalAp3wrep3r+aEtLYlpHMk+aoXDYMITbCX
 pHAMEZ63gqbQZeNR4rsHLSKlSQy5RqGmvO0ftclB+DW3yvfwnqc47LyufMw4+F5D5V
 QyUfcVeaMJzvjSsAIPD/oP6GG7YZJ+yzMzltsVwlhdGAFfN29NWbKgyX1wlyQqdNLW
 Ty4JxcDcZLi3qLpUQFp3+ayUZIqY4MOe21/eOZGkgjpM3NS5bb9qk7n8aFbt7pMWT9
 VFlrVI/kb8Qb8HSlOf8rVu9CLBPF+gdRJldpatK5ErdrMzCop3Z9V8QCaQf4b7jqN+
 qXTC4YxL0n5xQ==
Date: Fri, 9 Jan 2026 16:32:12 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Casey Connolly <casey.connolly@linaro.org>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, trini@konsulko.com,
 neil.armstrong@linaro.org, jorge.ramirez@oss.qualcomm.com,
 varadarajan.narayanan@oss.qualcomm.com, tonyh@qti.qualcomm.com,
 Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: Re: [PATCH 2/2] configs: Add generic qcom_tfa_optee_defconfig
Message-ID: <aWDgNIR4jcNcUZ6W@sumit-xelite>
References: <20251229114312.668068-1-sumit.garg@kernel.org>
 <20251229114312.668068-2-sumit.garg@kernel.org>
 <c0bc6cab-6eee-40c2-b6f7-ff14d91906c5@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0bc6cab-6eee-40c2-b6f7-ff14d91906c5@linaro.org>
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

On Thu, Jan 08, 2026 at 05:41:42PM +0100, Casey Connolly wrote:
> 
> 
> On 29/12/2025 12:43, Sumit Garg wrote:
> > From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> > 
> > Recently upstream TF-A/OP-TEE has started gaining support for Qcom
> > platforms. RB3Gen2 being the first one and more to come. U-Boot in
> > corresponding boot flow is packaged as a position independent executable.
> > 
> > So, lets add a generic U-Boot defconfig for Qcom platforms to support
> > TF-A/OP-TEE based TrustZone stack. Build command:
> > 
> > $ make qcom_tfa_optee_defconfig
> > $ make -j`nproc` DEVICE_TREE=qcom/qcs6490-rb3gen2
> 
> This would be better suited as a config fragment rather than a new
> defconfig imo.

That's fine with me to add it as a config fragment.

> 
> But more importantly, enabling OPTEE support in U-Boot doesn't imply
> that it will be used, just that it's supported.

There are real use-cases of OP-TEE in U-Boot for Qcom platforms like
secure EFI variables based on OP-TEE secure storage. Have a look here [1].

And sure there will be more such use-cases like fTPM, KASLR etc. can be
supported based on OP-TEE.

[1] lib/efi_loader/efi_variable_tee.c

> 
> So I think the more appropriate patch here would be to just enable
> OP-TEE in qcom_defconfig (assuming the binary size isn't significantly
> affected).

The OP-TEE driver in U-Boot itself is probed based on DT and it's not
only specific to Qcom platforms but every other platform using OP-TEE.

> 
> Considering the other patch is based on this assumption that if OP-TEE
> support is enabled then the board must be using it, a different approach
> is definitely needed.

Yeah that's true even with TF-A boot flow, there is possibility to boot
without OP-TEE as well. However, TF-A generally doesn't provide a
generic option to detect whether OP-TEE is running or not.

> 
> When I was looking into this last year I remember discussing this same
> issue from the Linux side, there is a good argument to be made that
> OP-TEE support in Linux shouldn't be based on the devicetree -
> particularly in the Qualcomm case where whether or not OP-TEE is used is
> a simple software change, nothing to do with hardware.

Sadly it's true for every other silicon vendor too. But OP-TEE support
based on DT has become an ABI unless migration for OP-TEE support based
on FF-A comes into picture.

> 
> So in general I'm not particularly keen on this approach, I think it
> /might/ be acceptable for U-Boot to have some fixup code to add the
> OP-TEE node if OP-TEE is in use with the idea of phasing that out in
> favour of runtime detection in the OS itself. I'd also expect that fixup
> code to go in the generic U-Boot DT fixup code that runs before we jump
> to the OS (like the EFI DT fixup function).

The EFI DT fixup code is already there based on U-Boot DT. Have a look
here:

boot/image-fdt.c:627:   fdt_ret = optee_copy_fdt_nodes(blob);

In general on Arm platforms there isn't any SMC bus to detect
dynamically if there is support for OP-TEE or not. That's why
platform bus was choosen for the U-Boot and Linux OP-TEE driver. It's
similar to how we have the SCM DT node for Qcom platforms.

FF-A bus tries to solve that problem to unify that approach for future
platform but U-Boot hasn't yet gained support for FF-A based OP-TEE
driver too.

Anyhow, this is the sanest way I can come up with to enable OP-TEE
support in a general way for all the Qcom platforms. This is aligned
with how OP-TEE support is detected for other silicon vendors too.

-Sumit

> 
> Kind regards,
> 
> > 
> > For more information refer here:
> > https://trustedfirmware-a.readthedocs.io/en/latest/plat/qti/rb3gen2.html
> > 
> > Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> > ---
> >  configs/qcom_tfa_optee_defconfig | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >  create mode 100644 configs/qcom_tfa_optee_defconfig
> > 
> > diff --git a/configs/qcom_tfa_optee_defconfig b/configs/qcom_tfa_optee_defconfig
> > new file mode 100644
> > index 00000000000..c398521770f
> > --- /dev/null
> > +++ b/configs/qcom_tfa_optee_defconfig
> > @@ -0,0 +1,7 @@
> > +# Configuration for building a generic U-Boot image
> > +# with support for TF-A/OP-TEE based Arm TrustZone stack.
> > +
> > +#include "qcom_defconfig"
> > +
> > +CONFIG_TEE=y
> > +CONFIG_OPTEE=y
> 
> -- 
> // Casey (she/her)
> 
