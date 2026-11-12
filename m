Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B236606A323
	for <u-boot@archiver.kernel.org>; Thu, 12 Nov 2026 18:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=V3CB8Bmb;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=jDg6KyhH
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5E078607BA;
	Thu, 12 Nov 2026 18:35:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DA8dpAkVDdk1; Thu, 12 Nov 2026 18:35:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8CC3E607F7
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794508552;
	b=bzKocsDGYRu52iFCpeFhhmE5qaxI0fY+JXS3eGBMXGZZzy1IIhABtLduui4QLVyxvkaP
	 +0cD7HqxYf74vRin17173rMutzsB7jkWaoTEvBpbystV0NY45/Y5wtptub1/qZAMg6Gnx
	 7hYQZAkum5mq4zM5kWsEKuPerhcBBospDEyA2Dp90aiUcSFG5vQ/Iz6InxzblUOWbY40T
	 f7lvEkOwj1ClTGFiJBQXgfFVrV/frViVPkD8vvZSZKBzl6COwASgZGtck0J6cf5yGP5gZ
	 6syVttx+iw22RUthkELQGFZFz+TIXhjiIgtG23Dp26iuWPwFhoB6JXOw+O8FwkgoJXg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794508552;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=QMRh8X3dVs5n3K+mGZCUtMA24qiJm9t+7COP0VdU6o8=;
	b=XVUN8TW3dgoyMj15TVQvvbKf9rJkCwHgmqls8Gvtbc3DXGqL2pqi8yhACXHb9yqLueL+
	 OpYkxqG/HgvR5yJruoIxX1Shxq+OpoVA7vtjJrrUtSf8IXUEC1MxQ1uRiONPo22Rg4AUw
	 ZI6iyix3hWv5sMHHoBsEH52E66Ufo2Qtt/t0jfrHJTp1mfVy/1S3ntNCMMIlqmF4EZ/Qc
	 SfSJi1VhVjEEnQ0TJ2WjqJUoG7eON2wq3JojbLTooFPU8BjIKhhNnRPhyY8xj9nGAAoDo
	 6YyGmRvVJuuAT3YQkfGSLRfNyAKLBCH2SB3+BurkAwEFECIyHSM+zEAf91Pvu/gAhig==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794508552;
	bh=QMRh8X3dVs5n3K+mGZCUtMA24qiJm9t+7COP0VdU6o8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=V3CB8BmbAo5OSIP1slStMA7PDgR3kBDax2ZQgthaqi4rTJ/A8/pHoLkNRjwv4JVAC
	 9a36gIDSZWOCdIX7VHtlN3t5JMEfbUcXdFuN4rTKRF9g2aiuIF6BehAoJ+//lcjGbR
	 N9Fy9ABp2Ow0apq9xQmD7ubo84WomBw/Vm/5ytTXegwqeka/w3oij8zhRp2uhVO+GM
	 fj3I6M4jKwe4WN4hJPl/Qa7cWOOZqG/pd5ajqvYF7be/KralywSXuA5PoiN1FESPRL
	 oy0mhaYNr0Wt3SrTaY6/G0uo4xYny1+txtOU+tLgoUu+6X/ZPTg0D1/E34lGhLrP5i
	 fmvt7OIOXSQOw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8CC3E607F7;
	Thu, 12 Nov 2026 18:35:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6E038E09
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 18:35:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5FF844049A
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 18:35:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Icwb_4wmPnKD for <u-boot@lists.u-boot-project.org>;
 Thu, 12 Nov 2026 18:35:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 8EB1D401E2
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2b; helo=mail-oo1-xc2b.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=jDg6KyhH
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8EB1D401E2
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 18:35:50 +0000 (UTC)
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-702dedeb70dso32455eaf.1
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 10:35:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1794508549; x=1795113349;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=QMRh8X3dVs5n3K+mGZCUtMA24qiJm9t+7COP0VdU6o8=;
 b=jDg6KyhHTjwh4lypIFXMetZoXUz1nA/iixFg3ZSamLkZFjI7QwSOTPD8sZtV1OppCq
 1sr0Yb53FJIXUEanIaBtSI0TSkPDgR/KRrSlkRxzs9aTzK8X87filCXEj/VOLeI1RB06
 x7xZIqtZOnKRyDCOLwUgAaQxVHnjoERRwosE0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794508549; x=1795113349;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QMRh8X3dVs5n3K+mGZCUtMA24qiJm9t+7COP0VdU6o8=;
 b=PcSntso603VXn6Bt8E4KWPb3sY+Xh0jw37ZBckC0xvS9mjMXbMvLkmSmmxyV6h+vYb
 MkDj6ODS/JZEzStGWcLBj1DzJQtKhuoem1lQUsQwwpy19hYavAJo8R2XqCUTe8J1Au3g
 /zl5RGoYs7FnpG8ja16l2IxwWCpXiC9pQ8KlrFKve9RiyLHM3ClpfD7TYcu4Y0jI52BK
 TK5feoVmNwveClv0cY6fdBt2oMPsOb59RfReRz+RCOj9ulEVipzDWcVBFcpdnvUdcDVA
 ch9mozGQMWCIwgTLM1P0tuIDz8adK9qMi689IWrM/kb9v7PmLEJwgbPB8gGk3nMPhZ3E
 wWew==
X-Forwarded-Encrypted: i=1;
 AL+hErG/h2VT9/K34T7RlKXZMasBk4VZgop1JeN2ycHQnEPT33Zfxr3W1WGd3rQKk44g/YAzox7rpPE=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+hc1JNejgkehJ3PZtLD7M2rFVdt2sW9t9aaEDH3dVMH9iFcIRO
 0bLnYioS83+Aze3aHsTs0MkwnJp0lWGWCeDj1BOO4Cl9n9+Maco2hAuQ4J58gk1ED9zB+vJGVAo
 2Xbq2DA4N6FNs
X-Gm-Gg: AYBFou0bvmlCDPV8dUyHSPO3zk9DyU82odaylW8EBoK2GJZyptyFfmIyUXJ/00w/oBn
 K9JdvSkvPGPtFiYmsEZNRYb9tHTG6QaPDLciY12QcwUe3BwZ/oNQGrRdCdBrLzMvH2MnVfypu97
 ryziizDVzrjjHm/gTFhGoBlVAEoC7TKRIkjoDEZiJgE1htzUS8pyqx/EmxyWW4FCwO7cnjlWa7X
 IixKyKVCMdHrjkaDNOZKlML9+GYwvbHXLA6bfONJB7c1QEySrQkYXfiPORZryE6NIBfRJSHY/GE
 CErIUrwpwWexIFM5UE6zRCzABAsfCvUFzNMX/7iBC1CJYiN8wFdPmM2v5oCVIjdmxoCwf5KHrkk
 pDLywBVQSl5MiyqAwB8/vP9RwUy8qXMiXlV22NMn48ORmk5wKkInYu4HckVGCX3/3afJi7MdrSq
 w/E0h6VqOYWio7JE/N0kMeMrQFLXXhiLJOdZ5PxZ6+H08XzCagT3mL7qgbDcEQncQiVZBQTuzG7
 pPkq19F8mjlR3hPzNDcSAUMZr9jeCXl4q7MiY3sTJWjSONuDIFiZA6FFTK+CMnCs9FeJepuvDv8
 f6//X3XA7DtLfahEJtr0l3YYfrBIuzd/eqcny94CGGsdNf6i0pje/DdmWDyn/XjNiWzvru+bYha
 ITOXECMtcm/TX4ZFGzGzKt/+n3smo5y4YmuXDLKe3L7Rw4lCvUv+8YiBDz5TtTz/3QarGme5Qpp
 /W/iyFB77iiabLExnHemDOgUunZDGGR1PNOtbKaV99XKHDYsBhp2wo
X-Received: by 2002:a05:6820:c3d5:b0:716:d70f:1c1c with SMTP id
 006d021491bc7-719179dba60mr3258133eaf.90.1794508548939; 
 Thu, 12 Nov 2026 10:35:48 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-56e21dff2fasm618798b6e.2.2026.11.12.10.35.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 10:35:48 -0800 (PST)
Date: Thu, 12 Nov 2026 12:35:46 -0600
From: Tom Rini <trini@konsulko.com>
To: Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: marek.vasut+usb@mailbox.org, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH] usb: host: ohci/ehci: halt the controller before booting
 an OS
Message-ID: <20261112183546.GG554944@bill-the-cat>
References: <20261112182838.2792025-1-jernej.skrabec@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="IbW2uNc9B1G8jZjN"
Content-Disposition: inline
In-Reply-To: <20261112182838.2792025-1-jernej.skrabec@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--IbW2uNc9B1G8jZjN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 12, 2026 at 07:28:38PM +0100, Jernej Skrabec wrote:

> Currently, OHCI is not stopped before OS starts booting. This means HCCA
> is still being written into during OS boot. This may cause all sorts of
> random and hard to catch errors, if same area is being used for some
> other needs.
>=20
> Mark OHCI and EHCI drivers with DM_FLAG_OS_PREPARE so remove hook stops
> both controllers during OS boot.
>=20
> Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> ---
>  drivers/usb/host/ehci-generic.c | 2 +-
>  drivers/usb/host/ohci-generic.c | 2 +-

I think per:
commit d610f703f937ebf7681e5cc36905586666e7ceb8
Author: Jacob Procee <sn125164@gmail.com>
Date:   Thu Oct 22 18:58:08 2026 +0200

    usb: xhci-dwc3: Add DM_FLAG_ACTIVE_DMA flag
   =20
    xhci-dwc3 is not removed before U-Boot hands over to the OS, so the
    controller keeps running after ExitBootServices or bootm. If a device
    was enumerated by "usb start" (for example by the default preboot
    command for USB keyboards), the controller keeps polling it.
   =20
    On Apple Silicon machines (tested on a MacBook Pro M1 Pro, J314s), a
    USB device that is connected while U-Boot runs is then not detected by
    Linux until it is unplugged and plugged back in. Running "usb stop"
    before booting avoids this.
   =20
    Add DM_FLAG_ACTIVE_DMA so the controller is removed, and its DMA
    stopped, before the handover.
   =20
    Signed-off-by: Jacob Procee <sn125164@gmail.com>
    Reviewed-by: Marek Vasut <marek.vasut+usb@mailbox.org>

We're preferring to use DM_FLAG_ACTIVE_DMA here instead.

--=20
Tom

--IbW2uNc9B1G8jZjN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCavYG9wAKCRAr4qD1Cr/k
CnVUAQCz3K/PEfB3Np5FN09HdfAjEbr6khMaixDTzC/LbV33egD/drTLQSU/WkaC
LQNKQjran+02hrt52rk7ram2l2iCQww=
=qoUT
-----END PGP SIGNATURE-----

--IbW2uNc9B1G8jZjN--
