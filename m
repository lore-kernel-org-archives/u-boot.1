Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5952AC531CB
	for <u-boot@archiver.kernel.org>; Thu, 23 Jul 2026 12:36:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 08ECE60902;
	Thu, 23 Jul 2026 12:36:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id u_OW7vvuIL_4; Thu, 23 Jul 2026 12:36:39 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5C722608C2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784810199;
	bh=agh1FWyZoFL4UqVaDnUj6/j7k7kFxz26Jbo5lPTSsNE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jfmJUsG9D7hZRqOhg4xU3CGgxzBReJz6IqtkzUA8dwSlmgtj2HiCI14q4EEa4lsax
	 CZB6kDPC4HCnrFXJzROWLKLelKjLClU2oS/3X3LW/nJm9QnOy3WbC9JyUJSOE3Oc1u
	 YmPN2Vn/m6lWnTYhjBQfkhQA8vLLWYQMei8V3VUFgpZGYihx9WRtsUE6/o7H3W71kp
	 PfbeKlHtZa/vTtmt70FtxKCabK3ZrWoBSyWvEn07bXEyJ8IqqbCrgJggwF/OvCdc+j
	 AAqWSAf0RmRJvcX4x701y2SdiZ80OT6CV3Ib3GuJBmvXzWSWnfYqjoynIh8M8r9BHm
	 Bh+XyMmGmiE0Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5C722608C2;
	Thu, 23 Jul 2026 12:36:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 29A91347
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 12:36:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1A2DE4077E
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 12:36:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id szokJ73tNDyZ for <u-boot@lists.u-boot-project.org>;
 Thu, 23 Jul 2026 12:36:37 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org CFE2040737
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CFE2040737
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CFE2040737
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 12:36:36 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BBA2803F6; Thu, 23 Jul 2026 14:36:35 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D3A5880117
 for <u-boot@lists.denx.de>; Thu, 23 Jul 2026 14:36:32 +0200 (CEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6D7554129B;
 Thu, 23 Jul 2026 12:36:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C52A11F000E9;
 Thu, 23 Jul 2026 12:36:30 +0000 (UTC)
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Thinh Nguyen
 <Thinh.Nguyen@synopsys.com>, Dan Tran <Dan.Tran1@synopsys.com>, Marek
 Vasut <marex@denx.de>, Lukasz Majewski <lukma@denx.de>, Tom Rini
 <trini@konsulko.com>, Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Tejas Narendra Joglekar <Tejas.Joglekar@synopsys.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH v2 2/2] usb: gadget: dfu: add SuperSpeed descriptor support
In-Reply-To: <a6c2533e5d59c5bcb1199fc0b939e6a7a5ee2382.1783620779.git.Thinh.Nguyen@synopsys.com>
References: <cover.1783620779.git.Thinh.Nguyen@synopsys.com>
 <a6c2533e5d59c5bcb1199fc0b939e6a7a5ee2382.1783620779.git.Thinh.Nguyen@synopsys.com>
Date: Thu, 23 Jul 2026 14:36:28 +0200
Message-ID: <87ecgt992r.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1784810191;
 bh=agh1FWyZoFL4UqVaDnUj6/j7k7kFxz26Jbo5lPTSsNE=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=GA+wOj39MiDHI65ZwGtB0yfeRPubjViUP7YgNoc0NinJeLc9M9x7tQtnY4LA9W7U8
 Oobj4DoGNRpiscoa0WbK3gy1nJZHPSbpDfrl2LXGqcjNdu4nyvyOd4Y22IPxE6zNOx
 JaD3BQ7IMlf0kecSKgb6rIUxCRgSyPPzZHFqXn1T6t0jzrGptMKRhSCIc0ylgZo9QP
 E+a3khIWYKEFXTMIV7vRfbEl1VdOhk00cz39uBVIt/Ban0arHn/uPlynHuYgDYcRTr
 fEtH73BphL+ra+CUHz5xPEO1A21Wnub5sTNxxuTvcLJVbgGK1YPapGQiavUjahUwSv
 z6uG0ykCZ7Fyw==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=GA+wOj39
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=mkorpershoek@kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="GA+wOj39"; 
 dkim-atps=neutral
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Thinh,

Thank you for the patch.

On Thu, Jul 09, 2026 at 18:19, Thinh Nguyen <Thinh.Nguyen@synopsys.com> wrote:

> From: Dan Tran <trandan@synopsys.com>
>
> Populate ss_descriptors to support SuperSpeed connections. DFU is
> control-only so no separate SS descriptor set is needed; reuse the
> same descriptors across all speeds.
>
> Signed-off-by: Dan Tran <trandan@synopsys.com>
> Signed-off-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
> ---
>  Changes in v2:
>  - Removed internal Reviewed-by tags
>
>  drivers/usb/gadget/f_dfu.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/usb/gadget/f_dfu.c b/drivers/usb/gadget/f_dfu.c
> index ca8b36e077bc..68d2ec7ebbe8 100644
> --- a/drivers/usb/gadget/f_dfu.c
> +++ b/drivers/usb/gadget/f_dfu.c
> @@ -227,6 +227,7 @@ static inline void to_dfu_mode(struct f_dfu *f_dfu)
>  	f_dfu->usb_function.strings = dfu_strings;
>  	f_dfu->usb_function.hs_descriptors = f_dfu->function;
>  	f_dfu->usb_function.descriptors = f_dfu->function;
> +	f_dfu->usb_function.ss_descriptors = f_dfu->function;
>  	f_dfu->dfu_state = DFU_STATE_dfuIDLE;
>  }
>  
> @@ -235,6 +236,7 @@ static inline void to_runtime_mode(struct f_dfu *f_dfu)
>  	f_dfu->usb_function.strings = NULL;
>  	f_dfu->usb_function.hs_descriptors = dfu_runtime_descs;
>  	f_dfu->usb_function.descriptors = dfu_runtime_descs;
> +	f_dfu->usb_function.ss_descriptors = dfu_runtime_descs;
>  }
>  
>  static int handle_upload(struct usb_request *req, u16 len)
> @@ -752,6 +754,9 @@ static int dfu_bind(struct usb_configuration *c, struct usb_function *f)
>  	if (s)
>  		g_dnl_set_serialnumber((char *)s);
>  
> +	if (gadget_is_superspeed(cdev->gadget))
> +		f_dfu->usb_function.ss_descriptors = f_dfu->function;
> +

Can you explain why this conditional is needed? I don't see something
similar for high speed so this is confusing me.

>  error:
>  	return rv;
>  }
> @@ -826,6 +831,7 @@ static int dfu_bind_config(struct usb_configuration *c)
>  	f_dfu->usb_function.name = "dfu";
>  	f_dfu->usb_function.hs_descriptors = dfu_runtime_descs;
>  	f_dfu->usb_function.descriptors = dfu_runtime_descs;
> +	f_dfu->usb_function.ss_descriptors = dfu_runtime_descs;
>  	f_dfu->usb_function.bind = dfu_bind;
>  	f_dfu->usb_function.unbind = dfu_unbind;
>  	f_dfu->usb_function.set_alt = dfu_set_alt;
> -- 
> 2.53.0
