Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6F73CA5FEC
	for <u-boot@archiver.kernel.org>; Sat,  3 Oct 2026 13:05:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7173E41409;
	Sat,  3 Oct 2026 13:05:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DbwNuioMk0uH; Sat,  3 Oct 2026 13:05:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org BC73D4142C
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791032741;
	b=GNW/996SjMewWQHeKDGuoeMd6BtgSvX9CUasemjg1RO+Dg//pFQjLdjYT4IQgH2ElcTe
	 kT7dL/OiaorgH1Qi70Efunw1RoPU3hDrCP6IMnEEL3vntWJfUTrt+CBLC2kX/N8MMUDmz
	 MD7eHV1H8GHZQnkHXDXbB+NCxXxr17kfRzPqy2rR5o8PaoBrI/GXzUdmZvEY2ZcagHrDc
	 ABb1HfxcIwzUGBrqRcty0t23CREIauDZUbIlSxjmESzK606ZfD1KTbNUh0pgPRtwv+IDx
	 fsIw7VoeWP8iXkSyXglIr3QWRcf4TWMWW2+yU/37IpWSp0VumyhTT+yLq/uRtKxyP6A==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791032741;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=mT4U6qNG0PTeYFivmd8gI19VZcS9Kgo7BjByJ5nynNc=;
	b=cKxLnIwXHJ72ueMWMtLCzwuCBhSkmxNjpdCOhREEawBgGQ2dSA9jhA3eSZUmgWge2zE5
	 Wwso1JuV70Fts0mii8kdVoKXKT9pbm9R+lUat8KCJedVPwFYsh+6tkFJvbVxXX85H3hS2
	 5ecuy/LSxTM2xLze1FEL61OAkuvs91EEKFXTek9Q8EPjSXu9r+wxXB5+B2UwIP3RCyftP
	 sUax/4fLCesLofekSRb8HFWz5ogR9b7rOM5RkWcZe2kJXU49e355LTSLBA++0WoKCInvA
	 dguf4sLjBd/pb7kfJ3FupLOUrO0sMY4qajvAxNnu08X0otCf2Ai6h6OlRIexSguzx+g==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791032741;
	bh=mT4U6qNG0PTeYFivmd8gI19VZcS9Kgo7BjByJ5nynNc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KrQzenafc1yo1JCskDTBhdasDBqLrsMQ/2uIfwp5Wxt34kVmis8Bnun4DG5cs5vye
	 BzjUFH5RV8tiimimyjqSSEfoumb62xrNOIG6cIYlKmV66INrO5UJ/g+e9xb3xJ+lyG
	 vl4DeXZg1a674oDMX5IE1yNWLf/nYX893QviokBciacdk43fmOv0Yt16JmwEv8cInj
	 /VubAWoCNV/uA8w6SDY7xF8o6A9bajrQotfYaR8X95Ft0aTF2oTYfvlo8apQllRn/9
	 ddgJEFp4kAG10EH0U4I4zO064NRw+tlmT8URKyQJ5iSCaEjbT/nE9cHGtSKurSW0s/
	 rbLlTCsD9TD/w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BC73D4142C;
	Sat,  3 Oct 2026 13:05:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 3045D1A6
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 13:05:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 15F55813C5
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 13:05:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8O8dGUHYOOOJ for <u-boot@lists.u-boot-project.org>;
 Sat,  3 Oct 2026 13:05:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org E9EA2813C3
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:33::10"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791032740;
 b=oNTeaMnoPLKp43JFV57uGOc57fjjdrwOAu8ffV8m94tYASU8dQFmiZgURTvw8w/iBNGR
 68BgCxiJagBMr9xNhiKc5alWQ+Oyosnq4/yZaNwjqJoCNKk4XiJFbVSaM81kcekqVi43y
 FNktVNcvtoB8LxPuwNM0A5FCzwtlkfHLUFkVMtS8MxOwlcQzub9QBGDifoy+SQm2wOcri
 IMdNeplgAefJm8PGKahiROx+Y5I/5oMxSjI9YjFVDJGJuOokpw+VcA6wmeQ7pwwzG8LQH
 Mwdb86rU/WIM2goZ21IwvRHUSryxKyr00ObGc2CxkGlSDGzQ7hvpu6RL3+kz0vrO/4w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791032740;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=mT4U6qNG0PTeYFivmd8gI19VZcS9Kgo7BjByJ5nynNc=;
 b=R0nHi5lKIVxPHfaT1Ym9GpA/6q6nG1rIEYTOL1L2mRZw+qhbNcPtlpMJSx+SeVxF1Pzz
 wGvtM6BACPF0qoDMoy/DuG/S7Un+s31YsFRoV+Oy4WmLoD+eEXPqyx+vcZUYyAoGw3z2T
 xWxbTGA6naqALeuEbBqpJSvRzTiSw1ZSwzvMLOsS6RSpNWg1H+GRnUkJrv9A42beqRMMO
 TzN8ripvot4FyaiNRdBE9B6LU08UlFk6iDFW4NktfC4+VdLtwdZ93BOa5gawH6ENcyk68
 aWt3eWvqfxkl/M6eBMqfB+S8OULZowQRUlReGt+R9k0pQ+0bjoPtylFMV4s82nAIxEw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=KPZQJswY; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:33::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:33::10; helo=mail-ed2-x10.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=KPZQJswY
Received: from mail-ed2-x10.google.com (mail-ed2-x10.google.com
 [IPv6:2a00:1450:4864:33::10])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E9EA2813C3
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 13:05:39 +0000 (UTC)
Received: by mail-ed2-x10.google.com with SMTP id
 4fb4d7f45d1cf-6a996c8adf3so535589a12.1
 for <u-boot@lists.u-boot-project.org>; Sat, 03 Oct 2026 06:05:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791032737; cv=none;
 d=google.com; s=arc-20260327;
 b=TMaxYpdklGGENdLlX3Ja3/NDIjgAj3J9GmsvgbYqbzQApJQeiTn4CBL9IyxkATzEYu
 15UspOOw0omqdSv/TTDCGicHzV97NV1sYqJfTTZS3PSz5ISQtapoGnQJ6aHWa2RQ50o2
 8Guq2mxfx140wCUmwEn2ajq/j1CHkGfwkihDm8Xygl3Ylu3HT+kXwkXdwBL9YotSqfa0
 eB9+rdDL/Z4+agHcwKjcNbA/ZQ7Wo1ORNNUVnNUaxgpQXfjUSkjpVX3B6jFjdGff4ISm
 bsve3wj+P3AXGOBJUoxWjw0wH8rx70Hij7PMN02P15uX0tlQF5pcidbXX26ixOCZpvpX
 uDWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=mT4U6qNG0PTeYFivmd8gI19VZcS9Kgo7BjByJ5nynNc=;
 fh=6vrxFiHTpMVqMrB7zhgLECcF+aCWJa85hfZ0R47mqGo=;
 b=ZI6cH/2IPT7cT6lA6InHHDS7paMRyt+EoIm4wdvDa5ppiJT1Z7PnVDboRbr2QedwOW
 /l4lW3QGANxhHqgrTWseAa0V2uWTMLw2Y0msNIhscu1xod7OIiq8jxNn7DRabLDPvf9c
 vDSHzi1K//h3TvgVP1ZB/bqtlO1DWt8N3ULLcaxZbw04MrBDJIQ+v3oDMtfAZCWURdDC
 jSbKgV8TNDm2U838UCBquu8Bkuy0EuhjU30NRIec/V/yiVQ4fUeRccXWRU80w1xYIj9K
 WjPIMn925P7TLy1L+y9G8fL0UOv4x5Q3rHTe2N++rNDyh7wKA3WuFnlX2xCmFGJl3dOY
 NDJA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1791032737; x=1791637537;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=mT4U6qNG0PTeYFivmd8gI19VZcS9Kgo7BjByJ5nynNc=;
 b=KPZQJswYqCyrwBy1KnyGXWnW1RyA20N+qOd9ORgS6CfhDPTlvAOODhvhePc0APJY4q
 ABYDtv+vlhEut5B/RnQSualn1kji9p9BONroP6PxKuJNdBNc+bH8mJNEwrfka/7GvemZ
 zzcJYNqi8frj0K3n9vd0RV+Ymn+S5MZO78r/c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791032737; x=1791637537;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=mT4U6qNG0PTeYFivmd8gI19VZcS9Kgo7BjByJ5nynNc=;
 b=CDSQ5TrfljCAJrwLCqVupR5ZhV6mM99/W99F6jw0TohupDkLb5HJg6/tDnWlRA43w0
 il5WPd0xJ/EK0PUNSXm/ZmFuURzR35xCptdj2eCN6TeCnWy2pamR0/b1Dwjv4X+KejpR
 s3sU+D/r/D4kfLPonVoqinPOkj0CxHGiLd8Qo5tKlqBWYfsLEzB0W6so/kqH4P6At+AO
 46YrzhLpn0AOis5VIQy0UK08XCjDOut85RltCGANM80gTRyNd3In6CE6rLsKYz2RD8Of
 kLIAov/2JqSaDLSVfylzoC4PYLMCoU2HbYPDgN2OUzbg9Q2r2TJzfH9x8ON3lVu/y444
 iDTw==
X-Gm-Message-State: AFq9FYJmXYCXGC6L8xUObRweyy+aSTiU72kxXn42Y8xeeTjyoFsTLUM0
 z7kuEt1EPyuM7WmdJfoDdWXkAcBrhb7dSNc5ykCkaFrTJoXHk6kHL/NgK9XjQOzlToAl3xYv7Od
 hUJoGRWkSpfqOzhtu52rlkUmMgXxI1znIHV/UaFaIq2mlpBs2PTJNJTfZ
X-Gm-Gg: AYBFou0WXIJBS8vOD093CQ5XfYsXXiMuCoxcRII5QrJzeApRrYu62m8uSe8BESm6+DU
 20AojNfWUZtei9mYfi+xA8sH5rxwRkHC10d1IznIJg50WRKnPwZ0KSM/YZ6PrMe8fXnaCNKEmfg
 nv9mJk1fVLrJm/M73bJkbbkxb9JnUyWNpeBOTsh4zY4YqxHPnOllQVGprBNbfU2ApWl3G8Djrpw
 95ar4I+hWRXAEK0J3vbYeKehOJrQAl/hwf1WZJZF8S4a0zU+hsO1zjOaVz1r7pFPCTglsb8bmT+
 emFiWgEK1TrFf+oRK2wDywyBWzT2mean7O0oNDVZV1NHQy32A5kHFGLy
X-Received: by 2002:a05:6402:324e:b0:6aa:f937:106d with SMTP id
 4fb4d7f45d1cf-6af9e35ba4amr3367431a12.36.1791032737279; Sat, 03 Oct 2026
 06:05:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260918-ufs-spl-boot-wlu-v2-0-8a63e372bb6e@flipper.net>
In-Reply-To: <20260918-ufs-spl-boot-wlu-v2-0-8a63e372bb6e@flipper.net>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 3 Oct 2026 14:05:17 +0100
X-Gm-Features: AclHuK8C5zgkRcK01HaF81lBVtKogRQLEkfrdr-E3OaE14e7zJjhIJmYwaPBsmc
Message-ID: <CAFLszTiYw4W0p9Gtfg-069nciH1Dp_N9ornnoq8q0c=aa3WzfA@mail.gmail.com>
Subject: Re: [v2,
 00/10] spl: ufs: Add support for loading U-Boot from boot W-LU
To: alchark@flipper.net
Cc: u-boot@lists.u-boot-project.org
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

Hi Alexey,

On 2026-09-18T06:35:41, Alexey Charkov <alchark@flipper.net> wrote:

> Given that the normal use of this mechanism is for symmetric A/B boot,
> real world scenarios will usually have both W-LU-A and W-LU-B provisioned
> with identical geometry, so the geometry for the boot W-LU can be inferred
> from the active boot LU, while its special 0xb0 LUN can still be used for
> reads and writes to have the device itself abstract away the actual
> request routing, even when the active boot LU is changed.

Just to check, what is the benefit of sending the reads through LUN
0xb0? Patch 8 already reads bBootLunEn and walks the unit descriptors
to find the real LU, so the host is doing the resolution anyway. SPL
could pass that LUN to scsi_get_blk_by_lun() from patch 5 and load
from an ordinary block device, with its own geometry.

That follows the A/B switch just the same, since as far as I can see
nothing in U-Boot writes bBootLunEn, so the active LU cannot change
between the scan and the load. It also avoids most of the SCSI-core
changes (the unit-attention retry, the W-LU list, the alias op and the
borrowed geometry in patches 1-4) along with patches 6 and 9. The
series would shrink to a UFS helper which reports the active boot LU,
the lookup and the SPL change.

If the W-LU must be used (e.g. for something the real LU cannot do),
please can you explain why in the cover letter? What do you think?

> This series adds support for loading the U-Boot proper from the boot W-LU,
> allowing to use the native A/B boot mechanism without the need to hardcode
> the "real" LUN in the SPL configuration.

The effect is wider than SPL, though. Patch 9 adds the boot W-LU to
the scan for every UFS controller, in U-Boot proper too, with no way
to turn it off. If the W-LU approach stays, I think this needs to be
opt-in; see my comments on that patch.

> CI passes all green:

The series adds new behaviour to the SCSI uclass but has no tests. I
have made suggestions on the individual patches.

Also, no board enables SPL_UFS_RAW_U_BOOT_USE_BOOT_WLUN, so nothing in
the tree exercises the new path. The only SPL_UFS_SUPPORT users are
rock-4d-rk3576 and nanopi-m5-rk3576. Is the plan to convert one of
those, or add a new board?

Some documentation would help as well, covering how the boot LUs need
to be provisioned (bBootLunID, bBootLunEn), since the only description
is in the Kconfig help.

> 2. The scan itself needs to learn to look beyond the normal LUN range when
>    the implementation supports W-LUs, as they are numbered above 0x80, and
>    "borrow" the geometry from the physical LU the W-LU is aliased to
>    (patches 3-5)

Patch 5 is the lookup helper used by the SPL loader, not part of the
scan, so it is not really described here. Similarly, patch 1 is mostly
a UFS-driver change rather than SCSI core. BTW I think you mean
'transient' rather than 'transitive' in item 1.

Regards,
Simon
