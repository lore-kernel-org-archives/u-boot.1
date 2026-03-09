Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E08B1FCA193
	for <u-boot@archiver.kernel.org>; Mon,  9 Mar 2026 21:23:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5194D83A8C;
	Mon,  9 Mar 2026 22:23:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tr+TwXUZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B42183F20; Mon,  9 Mar 2026 22:23:38 +0100 (CET)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2BF6083952
 for <u-boot@lists.denx.de>; Mon,  9 Mar 2026 22:23:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7d4c383f2fcso8747653a34.0
 for <u-boot@lists.denx.de>; Mon, 09 Mar 2026 14:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773091414; x=1773696214; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ttMlNV9ur382IZEn5HMq6DCjRslfnNUza4hwX5uzK+Q=;
 b=tr+TwXUZNOs7z1vI6thGFhtOnSXs8J5MUWLSiZsm6d+Q1SuwG5d6JgmiBh47gDDUAe
 sjZ/ZCGCb1j0Jz3kNbaOMjXGFFj/ZvaQjCXC4OBq5rNzfiooDmedghOZJlAOEotKyoNQ
 oFJzrGT+6yN/vMN8u2j+mXIDjGKnmUCGuycJQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773091414; x=1773696214;
 h=content-disposition:mime-version:message-id:subject:to:from:date
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ttMlNV9ur382IZEn5HMq6DCjRslfnNUza4hwX5uzK+Q=;
 b=XtlOKbTHuTwTysYdRVI2WLgwhPsVzGXHkqwxidtVyZmbSgGXew6Sq3wWp6xD+JmAZ5
 MWUr7hexZgHaisHz9uziapiRIymVuq1WtYwSLRtnVzuDCw99lJsZtr5ZbCqEtlcUZOXM
 C4J1zkFI1XKgv4Z7seWBc2tGYBUujcWEa7w79TyiW4nSJc7bUxQpPgO7cnSkhl1iZpkZ
 Wofl+zOo6OcuHkjoKOoZwPBzR5rWlqsYieE3sDuSCvV8ML3ODqIXsk5vIKQUtxuDQpCE
 I7uXI8IvuHKJZcXwV4Skt1OjreUYiEnGmVt9fzOD0Q+6c8OwHrth3LFCe2rPqUHXJ3Mc
 C6rQ==
X-Gm-Message-State: AOJu0YxA2hkmpJpdwWlj4zdT068nSzQAyORILfpcNtEyuliPirhqBJFu
 OlBaEbB8AtzA7CU8/cNU96SN/xwFnQ6LbXpGJ1ew5u3P/V9jSj6mZn0ojFmBHrUEFI60hpw3KWQ
 KAvVrUDc=
X-Gm-Gg: ATEYQzyff919ix6kOfC45gEOvWbxLuVMCQvU8AdRxCEXHUo31RqtUHFzFcMr5oKCi88
 XIRDLLU9edNpdsJ52Wn9+djqf383PqQa8xhE0dIh+pw9Ppwbjp06Ul2d8FWgknDnhaHhC4uc9Sx
 5gWDev4ZAdfX1ZUjTt9OHlIdhr7EaN4rxB4I4WQJ2W9fUWghNAvyzBlLyeyvcsyzf9WlVipdIe2
 kRJZePbbOdUX6UuETCCl2DIybq5lsvgQb421dnzE/1t9JVEOvPUkF5/iyyrhbxfipAnVPDqHAGN
 sqo2QqHXa2E+tN4A4YHfhFU95fLR1xHgddxniL5kuDV1I12JCmNbITjCI7tJ/i47+nSS6B7IjUL
 ynsgJz2GS9KjxooyyJRVSKOnPfSgjPT9KylyBUsYhPauxmqmL5HszgT5YBWC73XowJ4QSCgOhmK
 FzCI9ovjrVRAo/xdqbV+5vAIYpg4bpy+3WODFcN4Kag7vEVHojko50iXlYI7DIgqEOQPY+Cce+I
 3N9PY3Q+zE6UFpbsP8ok+h6NNHnEBlfIoOupj4w93CwD8TYt2sPLvXu
X-Received: by 2002:a05:6830:4121:b0:7d5:60a:8e09 with SMTP id
 46e09a7af769-7d726f57503mr9239434a34.9.1773091413843; 
 Mon, 09 Mar 2026 14:23:33 -0700 (PDT)
Received: from bill-the-cat (fixed-187-191-8-235.totalplay.net.
 [187.191.8.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d74cbe7f8dsm2424185a34.8.2026.03.09.14.23.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 14:23:33 -0700 (PDT)
Date: Mon, 9 Mar 2026 15:23:31 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Raphael Gallais-Pou <rgallaispou@gmail.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>
Subject: Fwd: New Defects reported by Coverity Scan for Das U-Boot
Message-ID: <20260309212331.GF1388590@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="MihG4kppl3vYr9U7"
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


--MihG4kppl3vYr9U7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey all,

Unfortunately for such a small set of changes (rc3 to rc4) a lot of new
Coverity scan issues have popped up. Please let me know if these appear
to be real issues or something that we can mark as intentional / false
positive. Thanks!

---------- Forwarded message ---------
=46rom: <scan-admin@coverity.com>
Date: Mon, Mar 9, 2026, 2:11=E2=80=AFPM
Subject: New Defects reported by Coverity Scan for Das U-Boot
To: <tom.rini@gmail.com>


Hi,

Please find the latest report on new defect(s) introduced to *Das U-Boot*
found with Coverity Scan.

   - *New Defects Found:* 4
   - *Defects Shown:* Showing 4 of 4 defect(s)

Defect Details


** CID 644836:       Error handling issues  (CHECKED_RETURN)
/drivers/video/stm32/stm32_dsi.c: 497           in stm32_dsi_probe()


___________________________________________________________________________=
__________________
*** CID 644836:         Error handling issues  (CHECKED_RETURN)
/drivers/video/stm32/stm32_dsi.c: 497             in stm32_dsi_probe()
491     	priv->hw_version =3D dsi_read(plat->base, DSI_VERSION) & VERSION;
492     	if (priv->hw_version !=3D HWVER_130 &&
493     	    priv->hw_version !=3D HWVER_131) {
494     		dev_err(dev, "DSI version 0x%x not supported\n", priv->hw_version=
);
495     		dev_dbg(dev, "remove and unbind all DSI child\n");
496     		device_chld_remove(dev, NULL, DM_REMOVE_NORMAL);
>>>     CID 644836:         Error handling issues  (CHECKED_RETURN)
>>>     Calling "device_chld_unbind" without checking return value (as is d=
one elsewhere 6 out of 7 times).
497     		device_chld_unbind(dev, NULL);
498     		ret =3D -ENODEV;
499     		goto err_clk;
500     	}
501
502     	return 0;

** CID 644835:         (TAINTED_SCALAR)
/common/menu.c: 589           in bootmenu_loop()
/common/menu.c: 589           in bootmenu_loop()


___________________________________________________________________________=
__________________
*** CID 644835:           (TAINTED_SCALAR)
/common/menu.c: 589             in bootmenu_loop()
583     			c =3D cli_ch_process(cch, c);
584     		}
585     	}
586
587     	key =3D bootmenu_conv_key(c);
588
>>>     CID 644835:           (TAINTED_SCALAR)
>>>     Using tainted variable "(int)(unsigned char)c" as an index into an =
array "_ctype".
589     	if (key =3D=3D BKEY_NONE && isalnum(c)) {
590     		key =3D BKEY_SHORTCUT;
591     		cch->shortcut_key =3D bootmenu_conv_shortcut_key(menu, c);
592     	}
593
594     	return key;
/common/menu.c: 589             in bootmenu_loop()
583     			c =3D cli_ch_process(cch, c);
584     		}
585     	}
586
587     	key =3D bootmenu_conv_key(c);
588
>>>     CID 644835:           (TAINTED_SCALAR)
>>>     Using tainted variable "(int)(unsigned char)c" as an index into an =
array "_ctype".
589     	if (key =3D=3D BKEY_NONE && isalnum(c)) {
590     		key =3D BKEY_SHORTCUT;
591     		cch->shortcut_key =3D bootmenu_conv_shortcut_key(menu, c);
592     	}
593
594     	return key;

** CID 644834:       Error handling issues  (CHECKED_RETURN)
/drivers/video/stm32/stm32_dsi.c: 496           in stm32_dsi_probe()


___________________________________________________________________________=
__________________
*** CID 644834:         Error handling issues  (CHECKED_RETURN)
/drivers/video/stm32/stm32_dsi.c: 496             in stm32_dsi_probe()
490     	/* check hardware version */
491     	priv->hw_version =3D dsi_read(plat->base, DSI_VERSION) & VERSION;
492     	if (priv->hw_version !=3D HWVER_130 &&
493     	    priv->hw_version !=3D HWVER_131) {
494     		dev_err(dev, "DSI version 0x%x not supported\n", priv->hw_version=
);
495     		dev_dbg(dev, "remove and unbind all DSI child\n");
>>>     CID 644834:         Error handling issues  (CHECKED_RETURN)
>>>     Calling "device_chld_remove" without checking return value (as is d=
one elsewhere 4 out of 5 times).
496     		device_chld_remove(dev, NULL, DM_REMOVE_NORMAL);
497     		device_chld_unbind(dev, NULL);
498     		ret =3D -ENODEV;
499     		goto err_clk;
500     	}
501

** CID 644833:       Memory - illegal accesses  (NEGATIVE_RETURNS)
/common/menu.c: 589           in bootmenu_loop()


___________________________________________________________________________=
__________________
*** CID 644833:         Memory - illegal accesses  (NEGATIVE_RETURNS)
/common/menu.c: 589             in bootmenu_loop()
583     			c =3D cli_ch_process(cch, c);
584     		}
585     	}
586
587     	key =3D bootmenu_conv_key(c);
588
>>>     CID 644833:         Memory - illegal accesses  (NEGATIVE_RETURNS)
>>>     Using variable "c" as an index to array "_ctype".
589     	if (key =3D=3D BKEY_NONE && isalnum(c)) {
590     		key =3D BKEY_SHORTCUT;
591     		cch->shortcut_key =3D bootmenu_conv_shortcut_key(menu, c);
592     	}
593
594     	return key;



View Defects in Coverity Scan
<https://scan.coverity.com/projects/das-u-boot?tab=3Doverview>

Best regards,

The Coverity Scan Admin Team

----- End forwarded message -----

--=20
Tom

--MihG4kppl3vYr9U7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaa86TAAKCRAr4qD1Cr/k
CrX5APwKNeeZm9LQQv2acb5K7jlV4ezFWd5RxJBoHR+ON2VhZgEAyW5+42l/JyLu
LO/SMBkkIAgtKWZpVngOSVQXKfMk6QU=
=8tgs
-----END PGP SIGNATURE-----

--MihG4kppl3vYr9U7--
