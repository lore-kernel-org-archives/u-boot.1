Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87751CEFD04
	for <u-boot@archiver.kernel.org>; Tue,  6 Jan 2026 20:36:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12E3183F01;
	Tue,  6 Jan 2026 21:36:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fwoormm1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16C8783FDA; Tue,  6 Jan 2026 21:36:09 +0100 (CET)
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com
 [IPv6:2607:f8b0:4864:20::344])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF16A83D9F
 for <u-boot@lists.denx.de>; Tue,  6 Jan 2026 21:36:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x344.google.com with SMTP id
 46e09a7af769-7c7503c73b4so732428a34.3
 for <u-boot@lists.denx.de>; Tue, 06 Jan 2026 12:36:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1767731764; x=1768336564; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Yvzi8ODInVb/cFBJkIyYaJeNgz1otjfwJzxDWe4zeQM=;
 b=fwoormm1/dnUNBM1gN3VJOMRE9+yfk9s917S4hLTzE4Il52yh8ExWzdPhlt2h2tBo3
 3IPQnSJma5053zisSloSiT6Ub5cbtgXbxXxo7e3oHdi6uSJmFjEfQVUk7QN9W9jav2ZE
 iGPbSqkP45RWHU2In9zfTeV55PusxF5EEZJik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767731764; x=1768336564;
 h=content-disposition:mime-version:message-id:subject:to:from:date
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Yvzi8ODInVb/cFBJkIyYaJeNgz1otjfwJzxDWe4zeQM=;
 b=phT27Jc//rbEekKLllfs4nlfzgOR6ezIkuFuyfr1yZn30Kai9XPR465+yN5WMitd6M
 VhyHwTh15tEWUh6Q8tzS7th+ZqmaF+iaZ9zgoaC764iSlQ8NMncbrIi+pZwo5X93fCvK
 /xXQYV4ZKSbt9iMU+8P2rBviVP/OZy56wGNjoM1n6mF59SrEbmYx0M3yCkZhnXckoWKu
 DYx5Q3XY2clJjfhlHAF3Wod/gdnfFodfhG0yyETAu2L0u9RiGDf/7UtVAn13KZTDhJxm
 Axycu+mnmBjfleQjAJunLF5Y8nBxfdf+dtxhh93GRkaBNu8lzCb6veMiWv9IkwIEUv5m
 jx1g==
X-Gm-Message-State: AOJu0Yyit5WHZdqXwXRBKQPNdYBn3CYpdJ5ZDE/1ZBTmOcPDhOyv+3g3
 di1XukROMUeVC/HMf7Ag7fc2RQsBSMeuVGkSgV+MRx24xHTiaGS2ofjDGH6oMh9vM6OOS2dx6DZ
 /cupHsNY=
X-Gm-Gg: AY/fxX7HY8BizVsvuCvkN5cO4Jvb8Vqw4AxdVUxuv7jYOGJdmO9c9V7yOkz2m6ryszo
 7Jti2ISl65tTkpoFXRo+pspeGlssO3PzsIuO+yP+sGLlLq+ioGRFtcCH/xpffwgRC7/2kmHqbkV
 xYcZLQszOYOBKzHXjyJFzaWuiT6GsHL1Pc0/+dSBSahrVDuEn4sAuvgWHMhpASydA3Fe8GkVSg/
 LUUhoKx3lqr7oFhb///zkRfXLtJsp4uyFZ4K7H6PgXno8fxjx1LCUx5kW0bIDx3WaLraNXr2gVR
 X32iMzCM7laLSejyAy9BiA/vnS87d0nxhYhCrdqPa7WvYFdjttrkS09JeJaIbnHTs7AEZqZ6gnu
 dkq9xNzahRpV6fKEVhzItadevQVIF1qHDQ8WKonvhpm78AKZSoIe5HxjBKvE6EtLYVu7nVy+C5h
 Jl5CziA+ckvsboSql5jddYe9GuQIU5Sl+Ik/r+MCTbp/SssOOvPXhGSxsrYcInOKbrGRBWwBZ9N
 /S2HnOsmbYqN7M6qYTfweGuM8pqS7HtDxQ0H8Q=
X-Google-Smtp-Source: AGHT+IFtsOQL9hAGyvT9UyJVGf0ZuY4CoP94wUxGCAirlChhDnsF7fIwGdEl355QAnCTOtCnVtwLQg==
X-Received: by 2002:a05:6830:2406:b0:7c7:5e52:456b with SMTP id
 46e09a7af769-7ce5091eaf8mr296808a34.16.1767731764234; 
 Tue, 06 Jan 2026 12:36:04 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7ce478ee668sm2152369a34.29.2026.01.06.12.36.03
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jan 2026 12:36:03 -0800 (PST)
Date: Tue, 6 Jan 2026 14:36:01 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: Fwd: New Defects reported by Coverity Scan for Das U-Boot
Message-ID: <20260106203601.GK3416603@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="E7Cxfj7oQQEB+gv7"
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


--E7Cxfj7oQQEB+gv7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey all,

This is really just to say that I've now been able to switch Coverity
scan over from "sandbox_defconfig" to "allyesconfig" (which is now also
in CI), so we have a lot more code being scanned. If you have access to
the dashboard already, and areas of interest, it's worth looking again
now. If you're already a project contributor and want to look for things
to work on, please let me know before asking for access to the
dashboard.

I am hopeful this will inspire people to make sure their code builds on
sandbox (and so allyesconfig) so that it can get further static checking
done to it, regularly.

And as a final funny to me note, while this email says 278 issues, the
other email (which just has high level info and I don't bother
forwarding) says 442 issues found.

---------- Forwarded message ---------
=46rom: <scan-admin@coverity.com>
Date: Tue, Jan 6, 2026 at 2:18=E2=80=AFPM
Subject: New Defects reported by Coverity Scan for Das U-Boot
To: <tom.rini@gmail.com>


Hi,

Please find the latest report on new defect(s) introduced to *Das U-Boot*
found with Coverity Scan.

   - *New Defects Found:* 278
   - 49 defect(s), reported by Coverity Scan earlier, were marked fixed in
   the recent build analyzed by Coverity Scan.
   - *Defects Shown:* Showing 20 of 278 defect(s)

Defect Details

** CID 640717:       Control flow issues  (DEADCODE)
/drivers/sysinfo/gazerbeam.c: 125           in _read_sysinfo_variant_data()


___________________________________________________________________________=
__________________
*** CID 640717:         Control flow issues  (DEADCODE)
/drivers/sysinfo/gazerbeam.c: 125             in _read_sysinfo_variant_data=
()
119     		      dev->name, con);
120     		return con;
121     	}
122
123     	priv->variant =3D con ? VAR_CON : VAR_CPU;
124
>>>     CID 640717:         Control flow issues  (DEADCODE)
>>>     Execution cannot reach the expression "0" inside this statement: "p=
riv->multichannel =3D (mc4 ?...".
125     	priv->multichannel =3D mc4 ? 4 : (mc2 ? 2 : (sc ? 1 : 0));
126
127     	return 0;
128     }
129
130     /**

** CID 640716:       Incorrect expression  (SIZEOF_MISMATCH)
/drivers/rng/iproc_rng200.c: 158           in iproc_rng200_of_to_plat()


___________________________________________________________________________=
__________________
*** CID 640716:         Incorrect expression  (SIZEOF_MISMATCH)
/drivers/rng/iproc_rng200.c: 158             in iproc_rng200_of_to_plat()
152     }
153
154     static int iproc_rng200_of_to_plat(struct udevice *dev)
155     {
156     	struct iproc_rng200_plat *pdata =3D dev_get_plat(dev);
157
>>>     CID 640716:         Incorrect expression  (SIZEOF_MISMATCH)
>>>     Passing argument "8UL /* sizeof (void *) */" to function "devfdt_ma=
p_physmem" which returns a value of type "void *" is suspicious.
158     	pdata->base =3D devfdt_map_physmem(dev, sizeof(void *));
159     	if (!pdata->base)
160     		return -ENODEV;
161
162     	return 0;
163     }

** CID 640715:         (TAINTED_SCALAR)


___________________________________________________________________________=
__________________
*** CID 640715:           (TAINTED_SCALAR)
/drivers/gpio/74x164_gpio.c: 145             in gen_74x164_probe()
139
140     	/*
141     	 * See Linux kernel:
142     	 * Documentation/devicetree/bindings/gpio/gpio-74x164.txt
143     	 */
144     	priv->nregs =3D fdtdec_get_int(fdt, node, "registers-number", 1);
>>>     CID 640715:           (TAINTED_SCALAR)
>>>     Passing tainted expression "priv->nregs" to "dlcalloc", which uses =
it as an offset.
145     	priv->buffer =3D calloc(priv->nregs, sizeof(u8));
146     	if (!priv->buffer) {
147     		ret =3D -ENOMEM;
148     		goto free_str;
149     	}
150
/drivers/gpio/74x164_gpio.c: 151             in gen_74x164_probe()
145     	priv->buffer =3D calloc(priv->nregs, sizeof(u8));
146     	if (!priv->buffer) {
147     		ret =3D -ENOMEM;
148     		goto free_str;
149     	}
150
>>>     CID 640715:           (TAINTED_SCALAR)
>>>     Passing tainted expression "priv->nregs" to "fdtdec_get_byte_array"=
, which uses it as an offset.
151     	ret =3D fdtdec_get_byte_array(fdt, node, "registers-default",
152     				    priv->buffer, priv->nregs);
153     	if (ret)
154     		dev_dbg(dev, "No registers-default property\n");
155
156     	ret =3D gpio_request_by_name(dev, "oe-gpios", 0, &priv->oe,

** CID 640714:       Control flow issues  (DEADCODE)
/drivers/net/ftgmac100.c: 400           in ftgmac100_start()


___________________________________________________________________________=
__________________
*** CID 640714:         Control flow issues  (DEADCODE)
/drivers/net/ftgmac100.c: 400             in ftgmac100_start()
394     	/* Configure TX/RX decsriptor size
395     	 * This size is calculated based on cache line.
396     	 */
397     	desc_size =3D ARCH_DMA_MINALIGN / FTGMAC100_DESC_UNIT;
398     	/* The descriptor size is at least 2 descriptor units. */
399     	if (desc_size < 2)
>>>     CID 640714:         Control flow issues  (DEADCODE)
>>>     Execution cannot reach this statement: "desc_size =3D 2U;".
400     		desc_size =3D 2;
401     	dblac =3D readl(&ftgmac100->dblac) & ~GENMASK(19, 12);
402     	dblac |=3D FTGMAC100_DBLAC_RXDES_SIZE(desc_size) |
FTGMAC100_DBLAC_TXDES_SIZE(desc_size);
403     	writel(dblac, &ftgmac100->dblac);
404
405     	/* poll receive descriptor automatically */

** CID 640713:       Integer handling issues  (CONSTANT_EXPRESSION_RESULT)
/drivers/serial/serial_sifive.c: 121           in sifive_serial_setbrg()


___________________________________________________________________________=
__________________
*** CID 640713:         Integer handling issues  (CONSTANT_EXPRESSION_RESUL=
T)
/drivers/serial/serial_sifive.c: 121             in sifive_serial_setbrg()
115     		if (IS_ERR_VALUE(ret)) {
116     			debug("SiFive UART clock not defined\n");
117     			return 0;
118     		}
119     	} else {
120     		clock =3D clk_get_rate(&clk);
>>>     CID 640713:         Integer handling issues  (CONSTANT_EXPRESSION_R=
ESULT)
>>>     "clock >=3D 18446744073709547521UL /* (unsigned long)-4095 */" is a=
lways false regardless of the values of its operands. This occurs as the lo=
gical operand of "!".
121     		if (IS_ERR_VALUE(clock)) {
122     			debug("SiFive UART clock get rate failed\n");
123     			return 0;
124     		}
125     	}
126     	plat->clock =3D clock;

** CID 640712:         (BAD_SHIFT)
/drivers/pci/pcie_cdns_ti.c: 582           in pcie_cdns_ti_bar_ib_config()
/drivers/pci/pcie_cdns_ti.c: 585           in pcie_cdns_ti_bar_ib_config()
/drivers/pci/pcie_cdns_ti.c: 570           in pcie_cdns_ti_bar_ib_config()
/drivers/pci/pcie_cdns_ti.c: 577           in pcie_cdns_ti_bar_ib_config()
/drivers/pci/pcie_cdns_ti.c: 570           in pcie_cdns_ti_bar_ib_config()
/drivers/pci/pcie_cdns_ti.c: 578           in pcie_cdns_ti_bar_ib_config()
/drivers/pci/pcie_cdns_ti.c: 581           in pcie_cdns_ti_bar_ib_config()
/drivers/pci/pcie_cdns_ti.c: 570           in pcie_cdns_ti_bar_ib_config()
/drivers/pci/pcie_cdns_ti.c: 570           in pcie_cdns_ti_bar_ib_config()
/drivers/pci/pcie_cdns_ti.c: 570           in pcie_cdns_ti_bar_ib_config()


___________________________________________________________________________=
__________________
*** CID 640712:           (BAD_SHIFT)
/drivers/pci/pcie_cdns_ti.c: 582             in pcie_cdns_ti_bar_ib_config()
576     		if (!(flags & IORESOURCE_PREFETCH))
577     			value |=3D LM_RC_BAR_CFG_CTRL_MEM_64BITS(bar);
578     		value |=3D LM_RC_BAR_CFG_CTRL_PREF_MEM_64BITS(bar);
579     	} else {
580     		if (!(flags & IORESOURCE_PREFETCH))
581     			value |=3D LM_RC_BAR_CFG_CTRL_MEM_32BITS(bar);
>>>     CID 640712:           (BAD_SHIFT)
>>>     In expression "5 << bar * 8 + 6", shifting by a negative amount has=
 undefined behavior.  The shift amount, "bar * 8 + 6", is as little as -2.
582     		value |=3D LM_RC_BAR_CFG_CTRL_PREF_MEM_32BITS(bar);
583     	}
584
585     	value |=3D LM_RC_BAR_CFG_APERTURE(bar, aperture);
586     	pcie_cdns_ti_writel(pcie, CDNS_PCIE_LM_RC_BAR_CFG, value);
587
/drivers/pci/pcie_cdns_ti.c: 585             in pcie_cdns_ti_bar_ib_config()
579     	} else {
580     		if (!(flags & IORESOURCE_PREFETCH))
581     			value |=3D LM_RC_BAR_CFG_CTRL_MEM_32BITS(bar);
582     		value |=3D LM_RC_BAR_CFG_CTRL_PREF_MEM_32BITS(bar);
583     	}
584
>>>     CID 640712:           (BAD_SHIFT)
>>>     In expression "aperture - 2U << bar * 8", shifting by a negative am=
ount has undefined behavior.  The shift amount, "bar * 8", is as little as =
-8.
585     	value |=3D LM_RC_BAR_CFG_APERTURE(bar, aperture);
586     	pcie_cdns_ti_writel(pcie, CDNS_PCIE_LM_RC_BAR_CFG, value);
587
588     	return 0;
589     }
590
/drivers/pci/pcie_cdns_ti.c: 570             in pcie_cdns_ti_bar_ib_config()
564     	pcie_cdns_ti_writel(pcie, CDNS_PCIE_AT_IB_RP_BAR_ADDR1(bar), addr1=
);
565
566     	if (bar =3D=3D RP_NO_BAR)
567     		return 0;
568
569     	value =3D pcie_cdns_ti_readl(pcie, CDNS_PCIE_LM_RC_BAR_CFG);
>>>     CID 640712:           (BAD_SHIFT)
>>>     In expression "bar_aperture_mask[bar] + 2 - 2 << bar * 8", shifting=
 by a negative amount has undefined behavior.  The shift amount, "bar * 8",=
 is as little as -8.
570     	value &=3D ~(LM_RC_BAR_CFG_CTRL_MEM_64BITS(bar) |
571     		   LM_RC_BAR_CFG_CTRL_PREF_MEM_64BITS(bar) |
572     		   LM_RC_BAR_CFG_CTRL_MEM_32BITS(bar) |
573     		   LM_RC_BAR_CFG_CTRL_PREF_MEM_32BITS(bar) |
574     		   LM_RC_BAR_CFG_APERTURE(bar, bar_aperture_mask[bar] + 2));
575     	if (size + cpu_addr >=3D SZ_4G) {
/drivers/pci/pcie_cdns_ti.c: 577             in pcie_cdns_ti_bar_ib_config()
571     		   LM_RC_BAR_CFG_CTRL_PREF_MEM_64BITS(bar) |
572     		   LM_RC_BAR_CFG_CTRL_MEM_32BITS(bar) |
573     		   LM_RC_BAR_CFG_CTRL_PREF_MEM_32BITS(bar) |
574     		   LM_RC_BAR_CFG_APERTURE(bar, bar_aperture_mask[bar] + 2));
575     	if (size + cpu_addr >=3D SZ_4G) {
576     		if (!(flags & IORESOURCE_PREFETCH))
>>>     CID 640712:           (BAD_SHIFT)
>>>     In expression "6 << bar * 8 + 6", shifting by a negative amount has=
 undefined behavior.  The shift amount, "bar * 8 + 6", is as little as -2.
577     			value |=3D LM_RC_BAR_CFG_CTRL_MEM_64BITS(bar);
578     		value |=3D LM_RC_BAR_CFG_CTRL_PREF_MEM_64BITS(bar);
579     	} else {
580     		if (!(flags & IORESOURCE_PREFETCH))
581     			value |=3D LM_RC_BAR_CFG_CTRL_MEM_32BITS(bar);
582     		value |=3D LM_RC_BAR_CFG_CTRL_PREF_MEM_32BITS(bar);
/drivers/pci/pcie_cdns_ti.c: 570             in pcie_cdns_ti_bar_ib_config()
564     	pcie_cdns_ti_writel(pcie, CDNS_PCIE_AT_IB_RP_BAR_ADDR1(bar), addr1=
);
565
566     	if (bar =3D=3D RP_NO_BAR)
567     		return 0;
568
569     	value =3D pcie_cdns_ti_readl(pcie, CDNS_PCIE_LM_RC_BAR_CFG);
>>>     CID 640712:           (BAD_SHIFT)
>>>     In expression "7 << bar * 8 + 6", shifting by a negative amount has=
 undefined behavior.  The shift amount, "bar * 8 + 6", is as little as -2.
570     	value &=3D ~(LM_RC_BAR_CFG_CTRL_MEM_64BITS(bar) |
571     		   LM_RC_BAR_CFG_CTRL_PREF_MEM_64BITS(bar) |
572     		   LM_RC_BAR_CFG_CTRL_MEM_32BITS(bar) |
573     		   LM_RC_BAR_CFG_CTRL_PREF_MEM_32BITS(bar) |
574     		   LM_RC_BAR_CFG_APERTURE(bar, bar_aperture_mask[bar] + 2));
575     	if (size + cpu_addr >=3D SZ_4G) {
/drivers/pci/pcie_cdns_ti.c: 578             in pcie_cdns_ti_bar_ib_config()
572     		   LM_RC_BAR_CFG_CTRL_MEM_32BITS(bar) |
573     		   LM_RC_BAR_CFG_CTRL_PREF_MEM_32BITS(bar) |
574     		   LM_RC_BAR_CFG_APERTURE(bar, bar_aperture_mask[bar] + 2));
575     	if (size + cpu_addr >=3D SZ_4G) {
576     		if (!(flags & IORESOURCE_PREFETCH))
577     			value |=3D LM_RC_BAR_CFG_CTRL_MEM_64BITS(bar);
>>>     CID 640712:           (BAD_SHIFT)
>>>     In expression "7 << bar * 8 + 6", shifting by a negative amount has=
 undefined behavior.  The shift amount, "bar * 8 + 6", is as little as -2.
578     		value |=3D LM_RC_BAR_CFG_CTRL_PREF_MEM_64BITS(bar);
579     	} else {
580     		if (!(flags & IORESOURCE_PREFETCH))
581     			value |=3D LM_RC_BAR_CFG_CTRL_MEM_32BITS(bar);
582     		value |=3D LM_RC_BAR_CFG_CTRL_PREF_MEM_32BITS(bar);
583     	}
/drivers/pci/pcie_cdns_ti.c: 581             in pcie_cdns_ti_bar_ib_config()
575     	if (size + cpu_addr >=3D SZ_4G) {
576     		if (!(flags & IORESOURCE_PREFETCH))
577     			value |=3D LM_RC_BAR_CFG_CTRL_MEM_64BITS(bar);
578     		value |=3D LM_RC_BAR_CFG_CTRL_PREF_MEM_64BITS(bar);
579     	} else {
580     		if (!(flags & IORESOURCE_PREFETCH))
>>>     CID 640712:           (BAD_SHIFT)
>>>     In expression "4 << bar * 8 + 6", shifting by a negative amount has=
 undefined behavior.  The shift amount, "bar * 8 + 6", is as little as -2.
581     			value |=3D LM_RC_BAR_CFG_CTRL_MEM_32BITS(bar);
582     		value |=3D LM_RC_BAR_CFG_CTRL_PREF_MEM_32BITS(bar);
583     	}
584
585     	value |=3D LM_RC_BAR_CFG_APERTURE(bar, aperture);
586     	pcie_cdns_ti_writel(pcie, CDNS_PCIE_LM_RC_BAR_CFG, value);
/drivers/pci/pcie_cdns_ti.c: 570             in pcie_cdns_ti_bar_ib_config()
564     	pcie_cdns_ti_writel(pcie, CDNS_PCIE_AT_IB_RP_BAR_ADDR1(bar), addr1=
);
565
566     	if (bar =3D=3D RP_NO_BAR)
567     		return 0;
568
569     	value =3D pcie_cdns_ti_readl(pcie, CDNS_PCIE_LM_RC_BAR_CFG);
>>>     CID 640712:           (BAD_SHIFT)
>>>     In expression "5 << bar * 8 + 6", shifting by a negative amount has=
 undefined behavior.  The shift amount, "bar * 8 + 6", is as little as -2.
570     	value &=3D ~(LM_RC_BAR_CFG_CTRL_MEM_64BITS(bar) |
571     		   LM_RC_BAR_CFG_CTRL_PREF_MEM_64BITS(bar) |
572     		   LM_RC_BAR_CFG_CTRL_MEM_32BITS(bar) |
573     		   LM_RC_BAR_CFG_CTRL_PREF_MEM_32BITS(bar) |
574     		   LM_RC_BAR_CFG_APERTURE(bar, bar_aperture_mask[bar] + 2));
575     	if (size + cpu_addr >=3D SZ_4G) {
/drivers/pci/pcie_cdns_ti.c: 570             in pcie_cdns_ti_bar_ib_config()
564     	pcie_cdns_ti_writel(pcie, CDNS_PCIE_AT_IB_RP_BAR_ADDR1(bar), addr1=
);
565
566     	if (bar =3D=3D RP_NO_BAR)
567     		return 0;
568
569     	value =3D pcie_cdns_ti_readl(pcie, CDNS_PCIE_LM_RC_BAR_CFG);
>>>     CID 640712:           (BAD_SHIFT)
>>>     In expression "4 << bar * 8 + 6", shifting by a negative amount has=
 undefined behavior.  The shift amount, "bar * 8 + 6", is as little as -2.
570     	value &=3D ~(LM_RC_BAR_CFG_CTRL_MEM_64BITS(bar) |
571     		   LM_RC_BAR_CFG_CTRL_PREF_MEM_64BITS(bar) |
572     		   LM_RC_BAR_CFG_CTRL_MEM_32BITS(bar) |
573     		   LM_RC_BAR_CFG_CTRL_PREF_MEM_32BITS(bar) |
574     		   LM_RC_BAR_CFG_APERTURE(bar, bar_aperture_mask[bar] + 2));
575     	if (size + cpu_addr >=3D SZ_4G) {
/drivers/pci/pcie_cdns_ti.c: 570             in pcie_cdns_ti_bar_ib_config()
564     	pcie_cdns_ti_writel(pcie, CDNS_PCIE_AT_IB_RP_BAR_ADDR1(bar), addr1=
);
565
566     	if (bar =3D=3D RP_NO_BAR)
567     		return 0;
568
569     	value =3D pcie_cdns_ti_readl(pcie, CDNS_PCIE_LM_RC_BAR_CFG);
>>>     CID 640712:           (BAD_SHIFT)
>>>     In expression "6 << bar * 8 + 6", shifting by a negative amount has=
 undefined behavior.  The shift amount, "bar * 8 + 6", is as little as -2.
570     	value &=3D ~(LM_RC_BAR_CFG_CTRL_MEM_64BITS(bar) |
571     		   LM_RC_BAR_CFG_CTRL_PREF_MEM_64BITS(bar) |
572     		   LM_RC_BAR_CFG_CTRL_MEM_32BITS(bar) |
573     		   LM_RC_BAR_CFG_CTRL_PREF_MEM_32BITS(bar) |
574     		   LM_RC_BAR_CFG_APERTURE(bar, bar_aperture_mask[bar] + 2));
575     	if (size + cpu_addr >=3D SZ_4G) {

** CID 640711:       Memory - corruptions  (OVERRUN)


___________________________________________________________________________=
__________________
*** CID 640711:         Memory - corruptions  (OVERRUN)
/cmd/ubi.c: 806             in do_ubi()
800     		if (!size) {
801     			size =3D (int64_t)ubi->avail_pebs * ubi->leb_size;
802     			printf("No size specified -> Using max size (%lld)\n", size);
803     		}
804     		/* E.g., create volume */
805     		if (argc =3D=3D 3) {
>>>     CID 640711:         Memory - corruptions  (OVERRUN)
>>>     Overrunning callee's array of size 129 by passing argument "id" (wh=
ich evaluates to 256) in call to "ubi_create_vol".
806     			return ubi_create_vol(argv[2], size, dynamic, id,
807     					      skipcheck);
808     		}
809     	}
810
811     	if (strncmp(argv[1], "remove", 6) =3D=3D 0) {

** CID 640710:       Insecure data handling  (TAINTED_SCALAR)
/cmd/tpm-v1.c: 641           in do_tpm_list()


___________________________________________________________________________=
__________________
*** CID 640710:         Insecure data handling  (TAINTED_SCALAR)
/cmd/tpm-v1.c: 641             in do_tpm_list()
635     	ptr =3D buf + 2;
636
637     	printf("Resources of type %s (%02x):\n", argv[1], type);
638     	if (!res_count) {
639     		puts("None\n");
640     	} else {
>>>     CID 640710:         Insecure data handling  (TAINTED_SCALAR)
>>>     Using tainted variable "res_count" as a loop boundary.
641     		for (i =3D 0; i < res_count; ++i, ptr +=3D 4)
642     			printf("Index %d: %08x\n", i, get_unaligned_be32(ptr));
643     	}
644
645     	return 0;
646     }

** CID 640709:       Integer handling issues  (INTEGER_OVERFLOW)
/drivers/mfd/atmel-smc.c: 156           in atmel_smc_cs_conf_set_setup()


___________________________________________________________________________=
__________________
*** CID 640709:         Integer handling issues  (INTEGER_OVERFLOW)
/drivers/mfd/atmel-smc.c: 156             in atmel_smc_cs_conf_set_setup()
150     	 * The formula described in atmel datasheets (section "SMC Setup
151     	 * Register"):
152     	 *
153     	 * ncycles =3D (128 * xx_SETUP[5]) + xx_SETUP[4:0]
154     	 */
155     	ret =3D atmel_smc_cs_encode_ncycles(ncycles, 5, 1, 128, &val);
>>>     CID 640709:         Integer handling issues  (INTEGER_OVERFLOW)
>>>     Expression "0xffffffffffffffffUL << shift", where "shift" is known =
to be equal to 24, overflows the type of "0xffffffffffffffffUL << shift", w=
hich is type "unsigned long".
156     	conf->setup &=3D ~GENMASK(shift + 7, shift);
157     	conf->setup |=3D val << shift;
158
159     	return ret;
160     }
161     EXPORT_SYMBOL_GPL(atmel_smc_cs_conf_set_setup);

** CID 640708:       Code maintainability issues  (UNUSED_VALUE)
/drivers/video/tidss/tidss_oldi.c: 192           in get_parent_dss_vp()


___________________________________________________________________________=
__________________
*** CID 640708:         Code maintainability issues  (UNUSED_VALUE)
/drivers/video/tidss/tidss_oldi.c: 192             in get_parent_dss_vp()
186     	int ret;
187
188     	ep =3D ofnode_graph_get_endpoint_by_regs(oldi_tx, 0, -1);
189     	if (ofnode_valid(ep)) {
190     		dss_port =3D ofnode_graph_get_remote_port(ep);
191     		if (!ofnode_valid(dss_port))
>>>     CID 640708:         Code maintainability issues  (UNUSED_VALUE)
>>>     Assigning value "-19" to "ret" here, but that stored value is overw=
ritten before it can be used.
192     			ret =3D -ENODEV;
193
194     		ret =3D ofnode_read_u32(dss_port, "reg", parent_vp);
195     		if (ret)
196     			return -ENODEV;
197     		return 0;

** CID 640707:       Control flow issues  (DEADCODE)
/drivers/power/regulator/max77663_regulator.c: 302           in
max77663_ldo_val()


___________________________________________________________________________=
__________________
*** CID 640707:         Control flow issues  (DEADCODE)
/drivers/power/regulator/max77663_regulator.c: 302             in
max77663_ldo_val()
296
297     	if (op =3D=3D PMIC_OP_GET) {
298     		*uV =3D 0;
299
300     		ret =3D max77663_ldo_hex2volt(idx, val & LDO_VOLT_MASK);
301     		if (ret < 0)
>>>     CID 640707:         Control flow issues  (DEADCODE)
>>>     Execution cannot reach this statement: "return ret;".
302     			return ret;
303
304     		*uV =3D ret;
305     		return 0;
306     	}
307

** CID 640706:         (CHECKED_RETURN)
/drivers/gpio/gpio-aspeed.c: 277           in aspeed_gpio_probe()
/drivers/gpio/gpio-aspeed-g7.c: 133           in aspeed_gpio_probe()


___________________________________________________________________________=
__________________
*** CID 640706:           (CHECKED_RETURN)
/drivers/gpio/gpio-aspeed.c: 277             in aspeed_gpio_probe()
271     static int aspeed_gpio_probe(struct udevice *dev)
272     {
273     	struct gpio_dev_priv *uc_priv =3D dev_get_uclass_priv(dev);
274     	struct aspeed_gpio_priv *priv =3D dev_get_priv(dev);
275
276     	uc_priv->bank_name =3D dev->name;
>>>     CID 640706:           (CHECKED_RETURN)
>>>     Calling "ofnode_read_u32" without checking return value (as is done=
 elsewhere 101 out of 125 times).
277     	ofnode_read_u32(dev_ofnode(dev), "ngpios", &uc_priv->gpio_count);
278     	priv->regs =3D devfdt_get_addr_ptr(dev);
279
280     	return 0;
281     }
282
/drivers/gpio/gpio-aspeed-g7.c: 133             in aspeed_gpio_probe()
127     static int aspeed_gpio_probe(struct udevice *dev)
128     {
129     	struct gpio_dev_priv *uc_priv =3D dev_get_uclass_priv(dev);
130     	struct aspeed_gpio_priv *priv =3D dev_get_priv(dev);
131
132     	uc_priv->bank_name =3D dev->name;
>>>     CID 640706:           (CHECKED_RETURN)
>>>     Calling "ofnode_read_u32" without checking return value (as is done=
 elsewhere 101 out of 125 times).
133     	ofnode_read_u32(dev_ofnode(dev), "ngpios", &uc_priv->gpio_count);
134     	priv->regs =3D devfdt_get_addr_ptr(dev);
135
136     	return 0;
137     }
138

** CID 640705:       Insecure data handling  (TAINTED_SCALAR)
/lib/tpm-v1.c: 863           in tpm1_find_key_sha1()


___________________________________________________________________________=
__________________
*** CID 640705:         Insecure data handling  (TAINTED_SCALAR)
/lib/tpm-v1.c: 863             in tpm1_find_key_sha1()
857     	err =3D tpm1_get_capability(dev, TPM_CAP_HANDLE, TPM_RT_KEY, buf,
858     				 sizeof(buf));
859     	if (err)
860     		return -1;
861     	key_count =3D get_unaligned_be16(buf);
862     	ptr =3D buf + 2;
>>>     CID 640705:         Insecure data handling  (TAINTED_SCALAR)
>>>     Using tainted variable "key_count" as a loop boundary.
863     	for (i =3D 0; i < key_count; ++i, ptr +=3D 4)
864     		key_handles[i] =3D get_unaligned_be32(ptr);
865
866     	/* now search a(/ the) key which we can access with the given auth=
 */
867     	for (i =3D 0; i < key_count; ++i) {
868     		buf_len =3D sizeof(buf);

** CID 640704:       Uninitialized variables  (UNINIT)
/drivers/mmc/sdhci-cadence6.c: 199           in sdhci_cdns6_reset_phy_dll()


___________________________________________________________________________=
__________________
*** CID 640704:         Uninitialized variables  (UNINIT)
/drivers/mmc/sdhci-cadence6.c: 199             in sdhci_cdns6_reset_phy_dll=
()
193     	/* After reset, wait until HRS09.PHY_INIT_COMPLETE is set to
1 within 3000us*/
194     	if (!reset) {
195     		ret =3D readl_poll_timeout(reg, tmp, (tmp &
SDHCI_CDNS_HRS09_PHY_INIT_COMPLETE),
196     					 3000);
197     	}
198
>>>     CID 640704:         Uninitialized variables  (UNINIT)
>>>     Using uninitialized value "ret".
199     	return ret;
200     }
201
202     int sdhci_cdns6_phy_adj(struct udevice *dev, struct
sdhci_cdns_plat *plat, u32 mode)
203     {
204     	struct sdhci_cdns6_phy_cfg *sdhci_cdns6_phy_cfgs;

** CID 640703:       Integer handling issues  (INTEGER_OVERFLOW)
/test/dm/test-fdt.c: 667           in dm_test_fdt_remap_addr_index_flat()


___________________________________________________________________________=
__________________
*** CID 640703:         Integer handling issues  (INTEGER_OVERFLOW)
/test/dm/test-fdt.c: 667             in dm_test_fdt_remap_addr_index_flat()
661     	fdt_size_t size;
662     	void *paddr;
663
664     	ut_assertok(uclass_find_device_by_seq(UCLASS_TEST_DUMMY, 0, &dev));
665
666     	addr =3D devfdt_get_addr_size_index(dev, 0, &size);
>>>     CID 640703:         Integer handling issues  (INTEGER_OVERFLOW)
>>>     Expression "_val2", where "addr" is known to be equal to 1844674407=
3709551615, overflows the type of "_val2", which is type "unsigned int".
667     	ut_asserteq(0x8000, addr);
668     	ut_asserteq(0x1000, size);
669
670     	paddr =3D map_physmem(addr, 0, MAP_NOCACHE);
671     	ut_assertnonnull(paddr);
672     	ut_asserteq_ptr(paddr, devfdt_remap_addr_index(dev, 0));

** CID 640702:       Uninitialized variables  (UNINIT)
/drivers/video/imx/ldb.c: 85           in imx_ldb_of_to_plat()


___________________________________________________________________________=
__________________
*** CID 640702:         Uninitialized variables  (UNINIT)
/drivers/video/imx/ldb.c: 85             in imx_ldb_of_to_plat()
79
80     	uclass_get_device_by_endpoint(UCLASS_PANEL, dev, 1, -1, &priv->lvds=
1);
81     	uclass_get_device_by_endpoint(UCLASS_PANEL, dev, 2, -1, &priv->lvds=
2);
82     	if (!priv->lvds1 && !priv->lvds2) {
83     		debug("ldb: No remote panel for '%s' (ret=3D%d)\n",
84     		      dev_read_name(dev), ret);
>>>     CID 640702:         Uninitialized variables  (UNINIT)
>>>     Using uninitialized value "ret".
85     		return ret;
86     	}
87
88     	return 0;
89     }
90

** CID 640701:       Uninitialized variables  (UNINIT)
/drivers/spi/xilinx_spi.c: 377           in xilinx_spi_mem_exec_op()


___________________________________________________________________________=
__________________
*** CID 640701:         Uninitialized variables  (UNINIT)
/drivers/spi/xilinx_spi.c: 377             in xilinx_spi_mem_exec_op()
371     		if (ret)
372     			goto done;
373     	}
374     done:
375     	spi_cs_deactivate(spi->dev);
376
>>>     CID 640701:         Uninitialized variables  (UNINIT)
>>>     Using uninitialized value "ret".
377     	return ret;
378     }
379
380     static int xilinx_qspi_check_buswidth(struct spi_slave *slave, u8 w=
idth)
381     {
382     	u32 mode =3D slave->mode;

** CID 640700:       Integer handling issues  (BAD_SHIFT)
/drivers/net/phy/xilinx_gmii2rgmii.c: 43           in xilinxgmiitorgmii_con=
fig()


___________________________________________________________________________=
__________________
*** CID 640700:         Integer handling issues  (BAD_SHIFT)
/drivers/net/phy/xilinx_gmii2rgmii.c: 43             in
xilinxgmiitorgmii_config()
37     	ret =3D ofnode_parse_phandle_with_args(node, "phy-handle",
38     					     NULL, 0, 0, &phandle);
39     	if (ret)
40     		return ret;
41
42     	ext_phyaddr =3D ofnode_read_u32_default(phandle.node, "reg", -1);
>>>     CID 640700:         Integer handling issues  (BAD_SHIFT)
>>>     In expression "1 << ext_phyaddr", shifting by a negative amount has=
 undefined behavior.  The shift amount, "ext_phyaddr", is -1.
43     	ext_phydev =3D phy_find_by_mask(phydev->bus,
44     				      1 << ext_phyaddr);
45     	if (!ext_phydev) {
46     		printf("%s, No external phy device found\n", __func__);
47     		return -EINVAL;
48     	}

** CID 640699:       Control flow issues  (DEADCODE)
/drivers/spi/atcspi200_spi.c: 262           in __atcspi200_spi_xfer()


___________________________________________________________________________=
__________________
*** CID 640699:         Control flow issues  (DEADCODE)
/drivers/spi/atcspi200_spi.c: 262             in __atcspi200_spi_xfer()
256
257     				if ((event & RXFVE_MASK) && (data_in)) {
258     					rf_cnt =3D ((event & RXFVE_MASK)>> RXFVE_OFFSET);
259     					if (rf_cnt >=3D CHUNK_SIZE)
260     						rx_bytes =3D CHUNK_SIZE;
261     					else if (num_blks =3D=3D 1 && rf_cnt =3D=3D num_bytes)
>>>     CID 640699:         Control flow issues  (DEADCODE)
>>>     Execution cannot reach this statement: "rx_bytes =3D num_bytes;".
262     						rx_bytes =3D num_bytes;
263     					else
264     						continue;
265
266     					if (__nspi_espi_rx(ns, din, rx_bytes) =3D=3D rx_bytes) {
267     						num_blks -=3D CHUNK_SIZE;

** CID 640698:       Insecure data handling  (TAINTED_SCALAR)


___________________________________________________________________________=
__________________
*** CID 640698:         Insecure data handling  (TAINTED_SCALAR)
/drivers/net/bnxt/bnxt.c: 446             in bnxt_hwrm_ver_get()
440     	req =3D (struct hwrm_ver_get_input *)bp->hwrm_addr_req;
441     	resp =3D (struct hwrm_ver_get_output *)bp->hwrm_addr_resp;
442     	hwrm_init(bp, (void *)req, (u16)HWRM_VER_GET, cmd_len);
443     	req->hwrm_intf_maj =3D HWRM_VERSION_MAJOR;
444     	req->hwrm_intf_min =3D HWRM_VERSION_MINOR;
445     	req->hwrm_intf_upd =3D HWRM_VERSION_UPDATE;
>>>     CID 640698:         Insecure data handling  (TAINTED_SCALAR)
>>>     Passing tainted expression "*bp->hwrm_addr_resp" to "wait_resp", wh=
ich uses it as an offset.
446     	rc =3D wait_resp(bp, HWRM_CMD_DEFAULT_TIMEOUT, cmd_len, __func__);
447     	if (rc)
448     		return STATUS_FAILURE;
449
450     	bp->hwrm_spec_code =3D
451     		resp->hwrm_intf_maj_8b << 16 |



View Defects in Coverity Scan
<https://scan.coverity.com/projects/das-u-boot?tab=3Doverview>

Best regards,

The Coverity Scan Admin Team

----- End forwarded message -----

--=20
Tom

--E7Cxfj7oQQEB+gv7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaV1yLgAKCRAr4qD1Cr/k
CharAP9v18jiZEajzJ1bSLC7zszYBmQ7EeT4Rw+D2E1uPVjp4AD/ZhH46QXb90X/
zlr0t7aAPEHjdrdf6t3RFoEDjSDTIgI=
=nJDM
-----END PGP SIGNATURE-----

--E7Cxfj7oQQEB+gv7--
