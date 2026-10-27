Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E30606A31A
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 06:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=do3DCu37;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VSRlZg+B
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D70B2808C0;
	Tue, 27 Oct 2026 06:08:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id brfrMyS2Y4s7; Tue, 27 Oct 2026 06:08:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1B00880880
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793081323;
	b=mciyRsJlaPNaEXE7iZfNV2+dTmQBumKmb+/xqguPdSv3hyvNVfSWKE2/SYd7aJZ7s1eO
	 o6HBznbq9I/Af+fGbVNwJtNihmlT3PIgbOd6rYaN/51RKazvdSHhUlWLrND7hTX8Gc6UO
	 pQsE6fgxaxfg6QTPhNv8y7Czc36987kUPJ/nOfN4NL8LeRd3BJgGqZ38Oe4c6xxq8SAmP
	 5nqlF77n0pfgc9rqGBrkMHsiZFtNBEX0FTZvuEaA1kJHoxyouwSeD4Gp0X1frtsaUO5Aq
	 UsrSoicxGGDqt2z/igSCVSxONjf4JMh8rgn/ysrC9Zn9Tw4jOZV0cE+HVhaNWgZZEdw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793081323;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=3ECNc2wvRWpdCR698RV+4euXXC9nlZgMK9hxQoNKpe4=;
	b=qUCrQpeB6n2ryYvLXvY0s1P0D76+i62tLGnV8FfRtLDawEquR+DA0AhJrt5GOUiWu+Z1
	 a5t1C8wL6bVQ9JiHr26Q+dgbXk2sgROdca0iHPp8i1W7BMYGZNwzlkpoc9BKwazOBlMhr
	 vcur+4XJ20BaMF+FLS1ynoEdoBJCho9Lbp3quYX4P/aD3q9ywrg73N9YO9GPRVRHXQBuD
	 0QkjPAI6oa/fLpB7q1R06tVW41FVWZEkDWJf3LpElp5NMbASb5QnF6gGl4awQwVBWSR9c
	 CKb5XUm4ZL82FXGtai09GyPs+WCO3lACNuaY4BoHvO1qE7lDzosrUjl+SSg8eJfWC4w==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793081323;
	bh=3ECNc2wvRWpdCR698RV+4euXXC9nlZgMK9hxQoNKpe4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=do3DCu376yrL3lIoKRuwRSaG4nYnj+Im5oBHVPwG+ecZAwSqvH2+UtkqetMhZnm48
	 FIF9+JGY3Qyd1y92yAnCHnzqCZ/VeT5zOV8rU2hnKhn111u1ff8mMGnBEeUwYeS4bN
	 SqJbjN2lOEyzFcImJlOFWW0L2b9Q6bVM1q3PdX4NxbopctPoz0fu0BC+ECHo0oABHG
	 7DSmEs8vFl0l+bTYukhSLuV2S/FMt12xL4qKqHIGW8QxQgp8SGWqWCOkoP4ghDQfjT
	 DdHG0XFsW9ItQwaMz9hh+jWu7UFpn/I+4pNnoSQewRa5kyfgXnXvthUERtdVDK1c9J
	 w7DNSeb8w9gug==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1B00880880;
	Tue, 27 Oct 2026 06:08:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 801BF279
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 06:08:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 71BBB4057D
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 06:08:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0mYIkJ8Pae-2 for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 06:08:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D1C014057C
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::102a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793081321;
 b=s0c6vXeR6I+Iv5OHcyknfLfJ4/edVAkUr/AJomdZEpIKK7ddM+boGNIUEY5fkhSd5/RB
 5qb3lEN2GLxPibj5tGCJqWDzUWVlH8yMRHZZtE7hHfxWpxSUuq4szZ8RCF4GnoEKAqcoW
 b3Swu/lqhbXnW7bzx+kjNVRovrzypLcPstHztrfagZhaNlNkBM8W0af63cFUKGZNI4HP4
 EvjgHrhqJ0whPSLpkDQ8kYDHKwvj0IKHI5jlH0UadiPy+mYlnUK1/hFhEdbQpji4rSLRK
 yBw75jLh7G52NUCymc/7vNd3QrCkLKhU/dzJymxuI4+BvRmoAM25Rz6PFHKa2Nnt7qA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793081321;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=3ECNc2wvRWpdCR698RV+4euXXC9nlZgMK9hxQoNKpe4=;
 b=KS8hb7XVmZ0cTFNjCqMUZXTjGRjprvDTquw7oFv8pNqkpNIJ2lruQU2KG5LO2kzCOHLY
 39H/RYmtZQLH2T1bbQcNXsM/HQ+YYnm2d2EsOiE9h/h/m6zoIrGjKVXinVZvDw2viOkFP
 s9rdgRBT5G03OnoM85f3i32WzSlh8Rwy0qDiNa9nS4aAmq83+j9w3+uetkz+tgl1gX3t/
 YmqdF+pLgr2FOl+WQV88B4t7m2SC+itjoAljNbx3NiNxoUAgZ93PV9j3GMt2MMIXGBxuQ
 L0WmKdZ9iIQmcSGJnkryMalc8+acNHmRgf3sROL7554m+EmIP4gOSUJ51LMEryFroXw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=VSRlZg+B; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::102a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::102a; helo=mail-pj1-x102a.google.com;
 envelope-from=visitorckw@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=VSRlZg+B
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D1C014057C
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 06:08:40 +0000 (UTC)
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-3ab41538192so2772267a91.0
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 23:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793081320; x=1793686120;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3ECNc2wvRWpdCR698RV+4euXXC9nlZgMK9hxQoNKpe4=;
 b=VSRlZg+BlyaLoKRCMMH+IRTbTDl0RCNWx4IKc3uaGPdiVGak7EZ+yYHRPJLmjZhFZw
 lcDV8sqDjLpwPTMMDmacveZ02XmogyWzLp7oIQoNgwvMCsPY2+TxjuA+a/9SKnyJOZoC
 9kpOzQmGbgWp22pB4M/y0fzqd94DZqBR0P5vq594Hee0Knr4kghNjRp+0AlZviatBQQx
 L10CsWsSzJQxnSKUv2ZeBar87Lmyi55uhhayftZmSXTdszyyqGImZoLucq+aXG8uW6vc
 pUqtvnAraz+S54gyFdQREvwUWApL1XtCrfIxy5/vHkIU1TBRumwLUE4xXCDyPj55Gwmy
 m0+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793081320; x=1793686120;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3ECNc2wvRWpdCR698RV+4euXXC9nlZgMK9hxQoNKpe4=;
 b=WAjm7oVjxita2RmCQ0guRnJu04Vqy9PS34R/fPFFixAULAAMtFIbBaKJlniWg7oO0U
 po6hIX2LgN/PLoDpgYEFoa8awbN5RH49OUxi70EAtXD7HVot3n2S9QUWw56+t4gAXLk/
 /sEliZ3WSxbPv2mOHnIKqF0k3qlFgLXODAcTRo6hAJ9X4ep5W98T1bZ+p7dd5O/F5Sy6
 NeBVYOQop9hMtGUm5JkhIhuwh8WC2JGqihvmg5Ow74ueQL9EO9z9s02tAv8b9bJGTfvV
 /hGWN8VjXAeBKYM5pcj8HaFbjSHBI+Tz31ZmPvg2A/Ez2MNQhoKfzcFbtWcnrKmkhnen
 AH5g==
X-Gm-Message-State: AFq9FYLKrDV4zd47Vr7JKyFQvJkGaavyWc6ZcoUVnu2FRehHBbHbgMhX
 s+qsw/QtKaRwBsd8XzpA11F4gUWt2f5BuCPlJsAWxrC3dPte1zfltakjW6pUjw==
X-Gm-Gg: AYBFou1YLQpViFD18kaNt73lupkitaOihi+Rl+D6n2jbdRGW/6wWFNCsmECrWK9MvKw
 qkNJjgZ7QSbKxXnk4ohJCQyh/WPzAr7E3x28b/5nABun+0Qub+8OSBX7I3YEl/x+MC12eCzIwy+
 3GOhzQqjjxtEXQIUucWmW+2C6fBrk5cuCBeWBysjSbLpxn5sU6HwoOnv6JiMCGJmc1l6pIWtB05
 qhmPz1ETMJS17csh1qjEmWCMDr8YcJDovJWkUujdQv3ActTVVNjYnskKDqpzY2n4x/yeaxB/xIr
 zYw8YJ8XeqZz3OZlEx2Kpy2jhTKZ+rYtQwz1oaymco3fFM3D5+xo6PNHaJrUAbMPaPrxDfxf7FP
 6UMzkMHFt7h/7grV568X9/Ut1K/VNCjIdxP7Y2eiRL9zkqmMXr5Ck8tahKs9j0zsuy03yD5UXPY
 QS0MuC54z8sj+Y2u7mH+DZkx3lu+placL/lWSxhiTsgVl8+lPxx12IobEXkBHkdxGzfHdQRcZwP
 fuXnLtW3VeQfc7X6c+d4mCQrIKscvbumZccQjY7FEvUdpfcUGTx9MbT2VNgIvM252GWxIhbHP/o
 a8jCDjgr1GVetTyRXBV7Be3oUiAh2YXmtCY=
X-Received: by 2002:a17:90b:1d50:b0:3ac:9176:e83c with SMTP id
 98e67ed59e1d1-3adead50e0fmr7515994a91.12.1793081319838; 
 Mon, 26 Oct 2026 23:08:39 -0700 (PDT)
Received: from google.com ([2a00:79e0:2039:4:1f3b:75d3:73bb:cec])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae406361e2sm2085347a91.8.2026.10.26.23.08.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 23:08:39 -0700 (PDT)
Date: Tue, 27 Oct 2026 14:08:35 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
Cc: u-boot@lists.u-boot-project.org, bmeng.cn@gmail.com, trini@konsulko.com,
 sjg@chromium.org, xypron.glpk@gmx.de,
 Bin Meng <bin.meng@processmission.com>
Subject: Re: [PATCH v4 2/5] doc: virtio: List the supported device types
Message-ID: <auA_493TQ5ZJCxvv@google.com>
References: <20261021110706.2947351-1-alan.tseng.cs@gmail.com>
 <20261021110706.2947351-3-alan.tseng.cs@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261021110706.2947351-3-alan.tseng.cs@gmail.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 21, 2026 at 07:07:03PM +0800, Hung-Chun Tseng wrote:
> The list of supported device types still only named network and block
> devices. Turn it into a bulleted list, which is easier to extend, and
> add the entropy, 9P and RTC devices. Also note that the virtio RTC
> device needs QEMU v11.1.0 or later.
> 
> Signed-off-by: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
> Reviewed-by: Bin Meng <bin.meng@processmission.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> ---
> (no changes since v3)
> 
> Changes in v3:
> - Retitle from "doc: virtio: Mention the RTC device", as the patch
>   lists other devices too (Kuan-Wei)
> - Turn the list of devices into a bulleted list (Kuan-Wei)
> - Keep the Reviewed-by tags of Bin and Simon, as only the layout changed
> 
>  doc/develop/driver-model/virtio.rst | 10 +++++++++-

Later in this same file under Development Flow still states:

"At present only VirtIO network card (device ID 1) and block device
(device ID 2) are supported."

Let's update that section as well.

Regards,
Kuan-Wei

>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/doc/develop/driver-model/virtio.rst b/doc/develop/driver-model/virtio.rst
> index e5da9f430..7b2f31b3d 100644
> --- a/doc/develop/driver-model/virtio.rst
> +++ b/doc/develop/driver-model/virtio.rst
> @@ -28,7 +28,13 @@ queues configuration and buffer transfers are nearly identical. Both MMIO
>  and PCI transport options are supported in U-Boot.
>  
>  The VirtIO spec defines a lots of VirtIO device types, however at present only
> -network and block device, the most two commonly used devices, are supported.
> +the following devices are supported.
> +
> +  - network
> +  - block
> +  - entropy (rng)
> +  - 9P transport
> +  - RTC
>  
>  The following QEMU targets are supported.
>  
> @@ -72,6 +78,8 @@ Requirements
>  ------------
>  It is required that QEMU v2.5.0+ should be used to test U-Boot VirtIO support
>  on QEMU ARM and x86, and v2.12.0+ on QEMU RISC-V.
> +The VirtIO RTC device (``-device virtio-rtc-pci`` or
> +``-device virtio-rtc-device``) requires QEMU v11.1.0+.
>  
>  Testing
>  -------
> -- 
> 2.43.0
> 
