Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25554C79FAD
	for <u-boot@archiver.kernel.org>; Wed,  9 Sep 2026 09:10:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4CAED80D6F;
	Wed,  9 Sep 2026 09:10:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jomY9WkXtoQ6; Wed,  9 Sep 2026 09:10:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 8CE5680D58
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788945047;
	b=sUrZEbxssh6+nwM4BOjHsVdzxrcO/hLRIINvnyZdQhuIQlNmlJCCZeNdlKmFVi350TWs
	 lGKoz6yhyt6rJHRf+NHz6qjsV/g5IfXbaoFilYkCQ7NZt3jPbNiNu89fN7/tOy8fZ0qR1
	 SRYeitZ7B5Ka9pvZZecM9r73AX/O570VlFh2ZUinLCQGupHaa0BJia+YQPxJXy924kJHz
	 TkQt67T7C0uEpInxabD+iP3cbjz+1wIm7545UiqubRzHpZ+yWjaiNZGunihxO8FbBNPbA
	 scAqh7aBnhPQ5RSuwEABwGI50tWDBEnlXL1rDlZmOr+XOU2+U6ehL/YuO+FkwdAmtqQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788945047;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=rXI6kkenP5h4dmltXu4Pv/kEUZHQ78xklV9swBC/TwM=;
	b=pNY8Jl4pK+Ur5rj2FzZFgX6v2juOpvPLeqVBwNUk0Qyuh2Xu8GUEbcFdvveUQgtUZ3UX
	 qFoBB3c2F23ysjntZE3C8GJdlPPw+QDCQki3/tT6pBeP3T5hww/KcLf6lNsA7qYLdBhkf
	 3zddTBoKnPMey7LPKSVT3M6LmGcv8Jbf05gYd5zpMMblrR8/wGAZp0iW4arijcKUOEe1M
	 m4GSpESrCh+NLUXsAJrkXU6yK13ZPhgfAbav5XKz2gV48NGp+7LkRuYCtOhs9SEcf/8i3
	 K1aNTvYuePipYsb472xE/MhNh7Dfl0End6q42S78Cg3ezgnDJHhPiqL1eCAuzSj2dlg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z1axxa2w;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788945047;
	bh=rXI6kkenP5h4dmltXu4Pv/kEUZHQ78xklV9swBC/TwM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wLQIXC7XinbkuilWr7HtqmbAnBQB7/w4vdclMnoei5ZBMGmcF80tJ3nS/JhysUpsF
	 FQtJrsSGWzQypzvBH0tSvGQyPTsUR2drIrEQGnPkuXe9EVtP/Nh4b++SOeFRCrt7ZG
	 1Br/aP9HVESKRavguADhNNxPbbXQJOqrIU13Y/fEFMGfe/AaqcUE30FFns8LAOeU2t
	 KY98vF/sOXjvSKbGljlHYi5F1klML/ww6eo9PdFe9ROR+RK2NBeYPQP/AHR+qla+et
	 qv5hl7Et63zBvGVuMjfbAWy88uAZaWaIf50pNDBqHXJf3LXbd6OBtiBca1UEGZY6/E
	 Q8u4az8cFK03w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8CE5680D58;
	Wed,  9 Sep 2026 09:10:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 501DC29B
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 09:10:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3FEF780D58
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 09:10:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BvIvDYvBtz8p for <u-boot@lists.u-boot-project.org>;
 Wed,  9 Sep 2026 09:10:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 81F3080CDE
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788945045;
 b=OAKf46iGZHqbxJtFVPf3E1pX/lVwQ8xKnmeI2IFFkqBcrD0FSdbvBSXTjorggJLTNvfv
 cgdntggqddL9pCjQQrXkHEB7RzGqNo2HkSPJVxbwiQDmM/r5H6lT+yF4+6exMVaLqvBia
 Rg6AdTz657dzrGAHeQ3QdVNHWwFqF4LaBZIQoezk3cnBBnDlTh9eZO2Vz83m1A1QiTAoc
 WLfRTSyzml55seIUiyg7qbwdcTyzORN1JeQonqak9j00Io5p8/gffR44GxjQ2HyAgY0u4
 KFfroP2FOJTnCTOMFUDiWmLLNahpmSPguSOglPEm3XRsSE96p38BraGTVGJQFhkK0MA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788945045;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 In-Reply-To:References:Date:Message-ID:MIME-Version:Content-Type;
 bh=rXI6kkenP5h4dmltXu4Pv/kEUZHQ78xklV9swBC/TwM=;
 b=pbRoHzsAbqRjXbPeUw/urictKdiOGNvBT6UZHzizHbX4VzR0tSKTV80648ixSdtSvEf8
 gBXMsx43HXywARdGacOhWM+Sua+1/rkanIFUlfGaDdOYzRMMnicZrwNJIpoaxlMigGFjb
 OKNDZgm9ba5p3/3+qeCVCNX/6NLB9BMQ1zzN10Pl5GoL8MdgiiWzdwGYzd0ixYRX5N8yz
 AsgBpiupSR9+b9xipTaxtAdtsqGBn+QBfvgVLqN0iar37WdoOnQIR6h+OfpdVb89briMX
 VnReNT0g+s+ULUtgbZ4EV51HzZQLMhfZdnk/wVA27e5smbI+XLVOAj+26bQ7YHEhdKg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Z1axxa2w; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=Z1axxa2w
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 81F3080CDE
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 09:10:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id F1446417C7;
 Wed,  9 Sep 2026 09:10:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4620B1F00A3A;
 Wed,  9 Sep 2026 09:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788945044;
 bh=rXI6kkenP5h4dmltXu4Pv/kEUZHQ78xklV9swBC/TwM=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=Z1axxa2w9nFsNNsainYC/OFtuUr6QONrdpCIhWMAKRzXSHqcquNN40WBvGwu2xweR
 0umg39aORNcpALuw+up8uuZ176HYfssCYGTnuj92nZ8jG1qDMul3ldBBLPtewgHDjw
 21xaF8Ahp6/hN1WHEDXpr7iVhWkqujVpymxEpsZg0XXjsxukUdhI5g3HMNvCO6eZCO
 LD+s3S9Z2pmnRG++Go4v605v8kSPhQc4W3Oaq37j6EhnubnL0QDrHyLCAsjYu0IILt
 sNBJm/FUI/fV5ERizrJuuxzdACNORUOhXHDkKqff/T4x8iLgqrubbSLBEnwmW5jbrl
 CVPc67kmRmfJQ==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Thinh Nguyen
 <Thinh.Nguyen@synopsys.com>, Dan Tran <Dan.Tran1@synopsys.com>, Lukasz
 Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>, Marek Vasut
 <marek.vasut+usb@mailbox.org>
Cc: Tejas Narendra Joglekar <Tejas.Joglekar@synopsys.com>,
 "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>
Subject: Re: [PATCH v3 2/2] usb: gadget: dfu: add SuperSpeed descriptor support
In-Reply-To: <bd88dea53446158d6f1bdd63b0f76fc1e1b62ee0.1788488867.git.Thinh.Nguyen@synopsys.com>
References: <cover.1788488867.git.Thinh.Nguyen@synopsys.com>
 <bd88dea53446158d6f1bdd63b0f76fc1e1b62ee0.1788488867.git.Thinh.Nguyen@synopsys.com>
Date: Wed, 09 Sep 2026 11:10:41 +0200
Message-ID: <87tsny6b8u.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Thinh,

Thank you for the patch.

On Fri, Sep 04, 2026 at 02:29, Thinh Nguyen <Thinh.Nguyen@synopsys.com> wrote:

> From: Dan Tran <trandan@synopsys.com>
>
> Populate ss_descriptors to support SuperSpeed connections. DFU is
> control-only so no separate SS descriptor set is needed; reuse the
> same descriptors across all speeds.
>
> Signed-off-by: Dan Tran <trandan@synopsys.com>
> Signed-off-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
>  Changes in v3:
>  - Remove the superspeed descriptor assignment from `dfu_bind`.
>
>  Changes in v2:
>  - Removed internal Reviewed-by tags
>
>  drivers/usb/gadget/f_dfu.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/usb/gadget/f_dfu.c b/drivers/usb/gadget/f_dfu.c
> index ca8b36e077bc..b1bdb865d3d7 100644
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
> @@ -826,6 +828,7 @@ static int dfu_bind_config(struct usb_configuration *c)
>  	f_dfu->usb_function.name = "dfu";
>  	f_dfu->usb_function.hs_descriptors = dfu_runtime_descs;
>  	f_dfu->usb_function.descriptors = dfu_runtime_descs;
> +	f_dfu->usb_function.ss_descriptors = dfu_runtime_descs;
>  	f_dfu->usb_function.bind = dfu_bind;
>  	f_dfu->usb_function.unbind = dfu_unbind;
>  	f_dfu->usb_function.set_alt = dfu_set_alt;
> -- 
> 2.53.0
