Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC371EF99DF
	for <u-boot@archiver.kernel.org>; Fri, 13 Feb 2026 22:09:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1377583015;
	Fri, 13 Feb 2026 23:09:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="DZ7SfGVx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF45683AA9; Fri, 13 Feb 2026 23:09:33 +0100 (CET)
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com
 [IPv6:2607:f8b0:4864:20::343])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37DF280B98
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 23:09:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x343.google.com with SMTP id
 46e09a7af769-7d1959ba05cso592208a34.2
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 14:09:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1771020570; x=1771625370; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=opAL71r5n3DwhiigD2ykNmc9/KYc8RBf4OWHczd2mf0=;
 b=DZ7SfGVx16YJ3iccTwJILWt34bM9ADbl61I2S3n3RS3hcIMCsKFE3FINm1JFnuploD
 Zy9/VBGBgZis2vn9sMDgcVAJI0ThagVw9hK62VLLNqR7dib8fBveL5rBK0djhA5HTYKV
 mxqTbKLI3zBLKFRDrkfuo+PRjZFZRTV+ch8Go=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771020570; x=1771625370;
 h=content-disposition:mime-version:message-id:subject:to:from:date
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=opAL71r5n3DwhiigD2ykNmc9/KYc8RBf4OWHczd2mf0=;
 b=VPY68MTEW3L9K/os6fyoLOyyyxbaJ8mSJP3ytBK3JqPoyrqytkPY8y78qrWNh2bhH0
 z37xzP3CNxxjZ+IOgV26G9OazLnXJErbdUfQUFyn/KTWhU0US991fPxq0BKq4yBkqE82
 wRtXiXv1ShPmgBht3qx8bSLrDZhfs262bQi/t9hInrCwCz/h+Ptzzu7RAzG4jKFB4zZs
 oNvtE8OQgswGQNjwSJ2GvTQAMEBfAWGp3Tg1NIQ6qdmYY1MMIDkEIH4a2pW7jApSLsqF
 Opyk661DnRtgoDfT04ljB0yI2dkkiq/WUWSBKg/Ujl9zGhWvXDZshSmXz7hClMpoaIyD
 fahw==
X-Gm-Message-State: AOJu0YwNQwC07ivlSFRJMIkInngpky8YT79J7f9GZPCROJZU011vhSfd
 A5PvsbxenXnfnRrCsb4Kbavfiv9vV5z1de2uKJHriSN8VujEHjAk7UOWbyQGYIFVVGo7vOumnm/
 Go8SeJ1Q=
X-Gm-Gg: AZuq6aJRXCu4WxhfO80XKiF44ajaWHPhz29H6JZ04LV/2+x4CKYZsq8rq2SK6HqdekA
 XnaEyOXMTwUWiqpHHTTw9FfWiAnsfA9Hlci0b+rYX9T0Duj6AtwWaZ6xlho6yRY6gWLOLKjHeV/
 LSaezlQn/mWPXVOIoPGlGNCqFZ4rNn3Eoy2z26+atdzf3OB2OnYZCqpM35J649acEnkGaEBFWAr
 PUvQZgB7yjmCKcyLblKkrQTsqQVEJEVQ5pda5xu6+zjdekUAX0KWw8ED9OHBeIRkTznjmcm3PVZ
 qHIwJKSyp8SZNua+7diYur2zAnkrud/qtIFH+3KfcieNGLv0tzgy6flWTaTJjVxj1bTPoRD2Bhg
 BOnwcVMvwgojpbVPYy60xOxkd3wRrcr3ZClHdgbWt8AQeTakPDVIv/YHnBCWn8XNwdCoBOSghL/
 kiE3ChynuYZdxHAXTY++FM1pYHR7MIjt9Z/ARJDTo+qMA4H551TaKvc94XHgQR732j+3wOhomXr
 +Mb4JI7ApM+xTlfEC0hBlTfGuZ6KlichZVJUUI6Gp3JpC3kZFc=
X-Received: by 2002:a05:6830:4988:b0:7d4:aa58:2bef with SMTP id
 46e09a7af769-7d4c4b313f6mr2091921a34.34.1771020569839; 
 Fri, 13 Feb 2026 14:09:29 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d4b99c978csm3916263a34.28.2026.02.13.14.09.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Feb 2026 14:09:29 -0800 (PST)
Date: Fri, 13 Feb 2026 16:09:27 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Chris Morgan <macromorgan@hotmail.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Subject: Fwd: New Defects reported by Coverity Scan for Das U-Boot
Message-ID: <20260213220927.GN2747538@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="F6s/T6MOAaXCJOZa"
Content-Disposition: inline
X-Clacks-Overhead: GNU Terry Pratchett
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


--F6s/T6MOAaXCJOZa
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Latest Coverity Scan report, now that it's back up and so a little out
of sync with the usual schedule.

---------- Forwarded message ---------
=46rom: <scan-admin@coverity.com>
Date: Fri, Feb 13, 2026 at 4:03=E2=80=AFPM
Subject: New Defects reported by Coverity Scan for Das U-Boot
To: <tom.rini@gmail.com>


Hi,

Please find the latest report on new defect(s) introduced to *Das U-Boot*
found with Coverity Scan.

   - *New Defects Found:* 1
   - 2 defect(s), reported by Coverity Scan earlier, were marked fixed in
   the recent build analyzed by Coverity Scan.
   - *Defects Shown:* Showing 1 of 1 defect(s)

Defect Details

** CID 328330:       Integer handling issues  (NO_EFFECT)
/drivers/usb/dwc3/core.c: 106           in dwc3_core_soft_reset()


___________________________________________________________________________=
__________________
*** CID 328330:         Integer handling issues  (NO_EFFECT)
/drivers/usb/dwc3/core.c: 106             in dwc3_core_soft_reset()
100     done:
101     	/*
102     	 * For DWC_usb31 controller 1.80a and prior, once DCTL.CSFRST bit
103     	 * is cleared, we must wait at least 50ms before accessing the PHY
104     	 * domain (synchronization delay).
105     	 */
>>>     CID 328330:         Integer handling issues  (NO_EFFECT)
>>>     This greater-than-or-equal-to-zero comparison of an unsigned value =
is always true. "dwc->revision >=3D 0U".
106     	if (DWC3_VER_IS_WITHIN(DWC31, ANY, 180A))
107     		mdelay(50);
108
109     	return 0;
110     }
111


View Defects in Coverity Scan
<https://scan.coverity.com/projects/das-u-boot?tab=3Doverview>

Best regards,

The Coverity Scan Admin Team

----- End forwarded message -----

--=20
Tom

--F6s/T6MOAaXCJOZa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaY+hEwAKCRAr4qD1Cr/k
CkyTAQC9zBQ+334H2+fOfidsozanW9CGGWhejhluZWWSH2xUfgD+JBd13Zm27+M5
3mJdvtAZOr1hlbMMVmh7WQuLDigs1wA=
=DQTi
-----END PGP SIGNATURE-----

--F6s/T6MOAaXCJOZa--
