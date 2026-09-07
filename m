Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4441BC79FA0
	for <u-boot@archiver.kernel.org>; Mon,  7 Sep 2026 19:36:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DC2A580987;
	Mon,  7 Sep 2026 19:36:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id N7nFyeVnJ05m; Mon,  7 Sep 2026 19:36:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 6ECBA80981
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788809776;
	b=f3nZJlvFzCGam8kxKRttnxwseZzP5VuXvhqdPTeeEvVtwtp99O2ejfsZrmml3ri3yd7j
	 O2gTqKUyhvGqBoUokSQwvIZbCiQ1+djOFPDuzNLQquSdmxtHCfdlq2ZDt9FAATnio7G73
	 jFwstR6CFJOxbvCyZ7aMeQjt56U/dlHps/5EGqttIx7CKpMv8xeNshX27ONa2IEUmKGHi
	 8PKxKZfT2IALtrX0RMxbDx+KXc7o7qApkns5XIcui9zK+KPIeq3rYuSEiEg6jY/ieoAfE
	 0+mt1SL8HahKCMjpATs4mYBhdr2Fxq6e4zFFiF5rrqY5QyIKc2yPdBPpDmALugdAhig==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788809776;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=nEzUqHyebtW8SO+4VnM/Ew4e7bHzQ5WF89eI1h2UlPI=;
	b=JoObR+e8/xMjWTsB0t+FG4YeaTUcz5ITUFbQszI1Wc0CqDw3jeOo9OfbPHyZ8ZzzvKVv
	 Tu0E560b+7cgEV0ODT0ik0R0EYI4dtytatbeoL60stnCHYW4xOeegwA3L1gkGFaBQc2WW
	 hOncKyOuL4KSIqd1zOsHnXy6L3z/OK4hFqSWUc9BGqLcaE3fC+7bChVavXq2UsDXaI/Gb
	 AQpQfnK9C+lnhYDUX9lekVQOoxd8Nj0YtOcJoo8mj6BBj9rqR2G7VYj5Gj9bMv/E1TgqD
	 YZ9Pz+dOPBsfbs9/C/xPuUgi3Tezxar/HHDQ1q5+dy7Op3DgZrAIdXhPdY69WzVNymQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788809776;
	bh=nEzUqHyebtW8SO+4VnM/Ew4e7bHzQ5WF89eI1h2UlPI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bCToNycFQlHeCheXMZ+GJs3+iDwM//4D0n9VAZ1VkigpmD/Yyf7y0Yr9LbZb0ZxLf
	 3bzJAGTrT3Z7Ad2bXYTGhs7KsfupXcFFGjeu4LsXvuksaXFsl2YmniaOjfPoxEm5aP
	 uxOXsBmx/iclFth9EoQVug8+UZ8qRIQvBe7tBbDLWrn1H6D9olxyOkopINoKurr4qB
	 6RgpAIOjD1+9o2ICU/nL+wYQ1W+n05ET3K9BEtYh6nYZtyGPcJ9XP5Z9xvWs+KS1Rw
	 NaQs+Wnk0r3zydM8nydwRINlPmZ7Vc4JvX5BBlqaAyt1pcj8axXB5kxd7UPaIXOjTH
	 f4kEyDqMJnFAw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6ECBA80981;
	Mon,  7 Sep 2026 19:36:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 83BE1A48
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 19:36:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 612DC6060D
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 19:36:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DtV-Md89Zu33 for <u-boot@lists.u-boot-project.org>;
 Mon,  7 Sep 2026 19:36:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 2E753605F5
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:30::"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788809773;
 b=AA0lyN/UE3Ft5JdL42g5aPymE2F/GweJ5MyFUf/Oa43ID7o3hynRkU8B/UVhswgcyMvc
 Ymc0YrmFb9RPfetGrOQzO8bENfxwG5OJ7rVL5+d/fvQUYPOUZ7Myxw1Cud0DOxW+YuEj6
 QdORPkq7JkFK8iC8xcBaKf966XHMSdYWjfnwMyBKotbGVlVf3KTEjp2q6vzyvJudLhiUZ
 qPSSJeafJSRscXhHPF8KmwNUor241I+xtZz32NhxGavpJMzHeo+UXHW51mbYGW5te901q
 HIwlGAU1ciGlkeqmbM8prq1DGkbYYEj4rMBmoOoTzs9NZxG22PbmRLMRK6J13bpOaOA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788809773;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=nEzUqHyebtW8SO+4VnM/Ew4e7bHzQ5WF89eI1h2UlPI=;
 b=cu6vIZlllDVRhO9geAvKawSjPh1zxSvrjp1Z3KSr2iTVB3kfykkQ/9KHqGdjAVcGtoWI
 our/nNjxau3GktyqvBn5AtOCky9GLu2nUoKM6AN5ujGnt967KRshfhfpk+WW1D9lItalB
 nmuanPWg4EjQBK7QXUfulMo6uUubS6mWNm8WdaFgJy6ZssyDcIS8g6ef+8M3vIvWliRwM
 Nq7U21tTrOVVbFQ715cq0eFHQA8GxMM1xIcfncRWOrEgl2vaHded/3wjdBEDAB/VuwCl5
 fVL1FRp+vLnV6UZzfT3+Mwuj2BS9BaW2K3W16/w0k7qr7TgACY1HSLHr8gwX9CyJcXQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=azn8ckD7; 
 arc=none smtp.remote-ip="2607:f8b0:4864:30::"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:30::;
 helo=mail-oa2-x00.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=azn8ckD7
Received: from mail-oa2-x00.google.com (mail-oa2-x00.google.com
 [IPv6:2607:f8b0:4864:30::])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2E753605F5
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 19:36:12 +0000 (UTC)
Received: by mail-oa2-x00.google.com with SMTP id
 586e51a60fabf-4489b7aa0e7so1153252fac.1
 for <u-boot@lists.u-boot-project.org>; Mon, 07 Sep 2026 12:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1788809772; x=1789414572;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nEzUqHyebtW8SO+4VnM/Ew4e7bHzQ5WF89eI1h2UlPI=;
 b=azn8ckD7BNi1OWBUXz0eHqhhB/9Z28yG+3nbl1w5Nj2C9EiYPBbB72PMAyXzy24eik
 2sw77G7ZZtvR536wd40jjeKcJFtWyJwWEdm50Gpm74F8uVJwJO35SqvZ6Ich69SFcY6R
 hKoZEZWR/FmZ/CPeLHQA73Hl3qtD5WgNCnEk8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788809772; x=1789414572;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nEzUqHyebtW8SO+4VnM/Ew4e7bHzQ5WF89eI1h2UlPI=;
 b=YVmaBsAGOsyr7yaKUT3SC2DmGhZYD1bBPxABwlzJm/vwUX/9agsCpWJjXr9m1JUule
 D/RU38PVKGlHz9t+p6sGbhTHjuScP5rzV/KiiOAm1OQsIpWbOUfQKNxiXYEOPwjLGfux
 8LheslxTXSb+ZmYrSd+1denrgyLsVpV9y/DyC7hQODgv7UNCrjuuf0P4KbxbRNIs1z16
 Y73PpYLmOcTIw6+2m7gaObrqaRtft9FNiLalQynj6fYow/u3qwn6yFwDYIBpXixhHZjv
 UsXj9EFESWfI9C/q0qmm4q9hnC4l4z68okdi+Dx5IDtLtAf2m2fzBWgGTYQwLS4neknP
 TneA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwArmuGnNmjbr59WxC82tqERIL2GnnwZDqEYQBiin5hR0mVzpEVv2d/vMQXGV3TE5sz4uPNeDg=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kYDOz1SwNXE7c+lVj5mrY6LLA8VgpqZBnslBYZRVLNk9PZZ1Xc
 OOs0ShMDxYTYjxv08C8CrMsNN+ae8W7CGSIIjmMtbMkfphqbNwC4I0Sx6N4gkjY0qhA=
X-Gm-Gg: AYBFou0MpCm9tVbe7AuhFLmKfr4ztxCtp758A+q7rXjJCK/HapR1kcNq0Ko5yRxXcti
 NBsfG6CkeA9AXrSx9BdkmxrmMXHmJLqBINP6W9qGKEciz+OoImZQMBtPZ7wVGlE2RxJTcTPczmu
 7t4jqbiXkSclgrMig0yKYiK+9xPAXrl91SiZ/4pWeORiTsIc/7DAxvcMSXQ9jkxI55K/JevpA85
 uUFL5cjHajjJFPr667yFKB8BtoXhYYz886IRhSOhOnbZNbqoz4Y7OAHWR9+/M6OUVj7wyH2e16/
 BeelKf+1rARk6uCY0FA3a8Op6jv0qtBtfv5yVvVz7IpVzHIMmhZd9adoamjLNSoqdkrVB2SU67p
 Rue3B65PZm7CHM9NCZPKlSjCihqGNy/uMtvyL5GaZ2qSviBTNu91EFhbn8hyJ2Xz/BaXmrrX0uJ
 NBZ8ekH12FbfarlrQODsbhINggzeBgf+1vTb9BB8hY/DKiQLUFFXB+67E3lvQHE+w+aB7lqDKjU
 yFYK/UpVj5uoy8+cWXm3HcWQEoGLgW4nn71wjROUYSGSLU4K6A9K9M29MbtnZNqv6Riw5T5onOx
 A9s9XD/TKQ==
X-Received: by 2002:a05:6871:553:b0:475:a112:126f with SMTP id
 586e51a60fabf-475a1124d24mr13209935fac.28.1788809771826; 
 Mon, 07 Sep 2026 12:36:11 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4791a0ffb4dsm2938528fac.16.2026.09.07.12.36.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 12:36:11 -0700 (PDT)
Date: Mon, 7 Sep 2026 13:36:08 -0600
From: Tom Rini <trini@konsulko.com>
To: Jorge Ramirez <jorge.ramirez@oss.qualcomm.com>
Cc: Neha Malcom Francis <n-francis@ti.com>, jens.wiklander@linaro.org,
 ilias.apalodimas@linaro.org, peng.fan@nxp.com,
 jh80.chung@samsung.com, neil.armstrong@linaro.org,
 bhupesh.linux@gmail.com, xypron.glpk@gmx.de,
 marek.vasut+renesas@mailbox.org,
 igor.belwon@mentallysanemainliners.org, shawn.lin@rock-chips.com,
 tuyen.dang.xa@renesas.com, yoshihiro.shimoda.uh@renesas.com,
 padmarao.begari@amd.com, macpaul.lin@mediatek.com,
 jstephan@baylibre.com, hayashi.kunihiko@socionext.com,
 j-mcarthur@ti.com, venkyada@qti.qualcomm.com, dlechner@baylibre.com,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v4 0/5] ufs: rpmb: route OP-TEE RPMB secure storage over
 UFS
Message-ID: <20260907193608.GZ1764417@bill-the-cat>
References: <20260807140119.324858-1-jorge.ramirez@oss.qualcomm.com>
 <aoMc8FDcE0bYGZch@trex> <aohaajBy5e6A4gFL@trex>
 <ao_89VbNNE1QTX6a@trex> <ap5i9edBJ7sNVmax@trex>
 <61fd743d-c722-42b8-a754-175715a4bcbe@ti.com>
 <ap54m53aTMXhIso3@trux> <20260907161339.GX1764417@bill-the-cat>
 <ap8NlN6n2lOWTUW4@trex>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="shFL4SxqFwA2Uaag"
Content-Disposition: inline
In-Reply-To: <ap8NlN6n2lOWTUW4@trex>
X-Clacks-Overhead: GNU Terry Pratchett
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


--shFL4SxqFwA2Uaag
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 07, 2026 at 09:16:36PM +0200, Jorge Ramirez wrote:
> On 07/09/26 10:13:39, Tom Rini wrote:
> > On Mon, Sep 07, 2026 at 10:40:59AM +0200, Jorge Ramirez wrote:
> > > On 07/09/26 12:47:39, Neha Malcom Francis wrote:
> > > > Hi Jorge
> > > >
> > > > On 07/09/26 12:38, Jorge Ramirez wrote:
> > > > > On 27/08/26 11:01:41, Jorge Ramirez wrote:
> > > > >> On 21/08/26 16:02:18, Jorge Ramirez wrote:
> > > > >>> On 17/08/26 16:38:40, Jorge Ramirez wrote:
> > > > >>>> On 07/08/26 16:01:05, Jorge Ramirez-Ortiz wrote:
> > > > >>>>> OP-TEE secure storage (CFG_RPMB_FS) relies on an RPMB partiti=
on, but
> > > > >>>>> U-Boot's OP-TEE RPMB supplicant only speaks the legacy single=
-command
> > > > >>>>> interface, which is bound to eMMC. SoCs that are UFS-only and=
 have no
> > > > >>>>> eMMC (for example the Qualcomm SA8775P) therefore cannot back=
 OP-TEE
> > > > >>>>> secure storage from U-Boot today. This series adds that suppo=
rt.
> > > > >>>>>
> > > > >>>>> It introduces the transport-agnostic OP-TEE RPMB "subsystem" =
interface
> > > > >>>>> (PROBE_RESET / PROBE_NEXT / FRAMES), where the normal world e=
numerates
> > > > >>>>> the RPMB device and reports its kind, size and CID, then carr=
ies the
> > > > >>>>> signed frames. The legacy eMMC supplicant is preserved unchan=
ged, only
> > > > >>>>> renamed to rpmb_emmc.c, with the new UFS backend added as a s=
eparate
> > > > >>>>> rpmb_ufs.c; the two are mutually exclusive via Kconfig (SUPPO=
RT_UFS_RPMB
> > > > >>>>> depends on !SUPPORT_EMMC_RPMB) because the OP-TEE supplicant =
handles a
> > > > >>>>> single RPMB transport. The subsystem interface is UFS-only fo=
r now; eMMC
> > > > >>>>> can be migrated onto it later as the legacy path is retired.
> > > > >>>>>
> > > > >>>>> On top of that it adds a UFS RPMB transport that moves JEDEC =
RPMB frames
> > > > >>>>> to and from the RPMB Well-Known LUN using SCSI SECURITY PROTO=
COL IN/OUT.
> > > > >>>>> The per-region 16-byte CID is derived by BLAKE2b-hashing the =
exact
> > > > >>>>> device-id string the Linux kernel builds (ufshcd_create_devic=
e_id()
> > > > >>>>> plus a "-R<region>" suffix), so OP-TEE derives an RPMB key th=
at matches
> > > > >>>>> the one Linux would use.
> > > > >>>>>
> > > > >>>>> The first patch is a standalone UFS descriptor fix the RPMB p=
ath depends
> > > > >>>>> on (UTF-16BE string decoding); the transport patches also inc=
lude a
> > > > >>>>> power-on UNIT ATTENTION retry and a DMA-alignment bounce for =
the RPMB
> > > > >>>>> WLUN.
> > > > >>>>>
> > > > >>>>> Note: reading UFS descriptors reliably also requires the desc=
riptor
> > > > >>>>> data-segment cache-invalidation fix, which has already been p=
osted and
> > > > >>>>> merged separately, so this series is based on top of it.
> > > > >>>>>
> > > > >>>>> Tested on the Qualcomm IQ-9075-EVK (SA8775P): OP-TEE with CFG=
_RPMB_FS
> > > > >>>>> programs the RPMB key through U-Boot and reads/writes secure-=
storage
> > > > >>>>> objects, with the derived CID matching the Linux UFS device_i=
d ABI.
> > > > >>>>>
> > > > >>>>> Dependencies:
> > > > >>>>> Linux kernel:
> > > > >>>>>  https://lore.kernel.org/linux-scsi/20260716083728.2226422-1-=
jorge.ramirez@oss.qualcomm.com/
> > > > >>>>> Op-tee
> > > > >>>>>  https://github.com/OP-TEE/optee_os/pull/7881
> > > > >>>>>
> > > > >>>>> v4:
> > > > >>>>>  - ufs: decode string descriptors: dropped the in-place
> > > > >>>>>    ufshcd_str_desc_to_cpu() byte-swap helper; instead added a=
n endian
> > > > >>>>>    argument to utf16_to_utf8() (UTF16_HOST/LITTLE/BIG_ENDIAN)=
 and decode
> > > > >>>>>    with UTF16_BIG_ENDIAN, mirroring the kernel's utf16s_to_ut=
f8s().
> > > > >>>>>    Existing EFI callers pass UTF16_HOST_ENDIAN.
> > > > >>>>>  - ufs: RPMB transport: build the SECURITY PROTOCOL CDB with
> > > > >>>>>    put_unaligned_be16()/put_unaligned_be32(); drop the
> > > > >>>>>    rpmb_frame_request() helper in favour of get_unaligned_be1=
6(); move
> > > > >>>>>    ufs_rpmb_read_geometry() to the patch that first uses it s=
o it is not
> > > > >>>>>    an unused static function during git bisect.
> > > > >>>>>  - ufs: per-region CID/size: reject an out-of-range device-re=
ported
> > > > >>>>>    logical block size before shifting and split the size comp=
utation into
> > > > >>>>>    separate statements for readability; order <u-boot/...> af=
ter
> > > > >>>>>    <linux/...>; note that the serial hex encoding matches the=
 kernel
> > > > >>>>>    device-id ABI.
> > > > >>>>>
> > > > >>>>
> > > > >>>> any further comments, is it ok to merge?
> > > > >>>>
> > > > >>>
> > > > >>> EOW reminder - this has been pending for a long while
> > > > >>
> > > > >>
> > > > >> anyone care to comment please?
> > > > >
> > > > >
> > > > > kernel changes accepted and op-tee changes merged.
> > > > > Just this one pending with no comments for nearly a month.
> > > > >
> > > > > maybe we can merge?
> > > > >
> > > > > thanks
> > > > > Jorge
> > > > >
> > > > >
> > > > >
> > > >
> > > > Looks like you're sending to the old mailing list instead of
> > > > u-boot@lists.u-boot-project.org
> > > >
> > >=20
> > > hi Neah,
> > >=20
> > > ah interesting, maybe that explains it depending on people'w workflow=
s: I see it hasnt landed on u-boot lore's.
> > >=20
> > > I just run get_maintainers.pl and the recommended list is
> > >=20
> > > jramirez@trex:u-boot (ufs-rpmb.v4 $) $ ./scripts/get_maintainer.pl dr=
ivers/tee/optee/Makefile
> > > Jens Wiklander <jens.wiklander@linaro.org> (maintainer:TEE)
> > > Ilias Apalodimas <ilias.apalodimas@linaro.org> (maintainer:TEE,commit=
_signer:2/3=3D67%)
> > > Tom Rini <trini@konsulko.com> (maintainer:THE REST,authored:1/3=3D33%=
,added_lines:1/3=3D33%,removed_lines:1/2=3D50%)
> > > Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com> (commit_signer:2=
/3=3D67%,authored:2/3=3D67%,added_lines:2/3=3D67%,removed_lines:1/2=3D50%)
> > > u-boot@lists.denx.de (open list)...
> > >=20
> > > still I can see it on patchworks with Neil being the gatekeeper.
> >=20
> > Is your tree out of date? That's not what it shows here, we updated that
> > a while ago.
>=20
> not as long as this series apparently.. plus maintainers were in copy
> and actively reviewing v1/v2/v3
>=20
> but yeah, These patches were developed on top of "ece349ade29 Prepare
> v2026.07" when the development started (so before the list was
> updated).=20
>=20
> anyway, so what is the next step. resend posting as v5 on top of
> v2026.10-x ?

Does v4 apply cleanly to the current next branch?

--=20
Tom

--shFL4SxqFwA2Uaag
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCap8SIAAKCRAr4qD1Cr/k
Cv7PAQCyELZm7Ctw0bxj8KbTAXvHuiuTNbb0dHzBp979STyLWgD+LobvjrrfiMhI
dEKU+p4F0Wm1fwaNLnsm3Upx0YUa2wA=
=92Oj
-----END PGP SIGNATURE-----

--shFL4SxqFwA2Uaag--
