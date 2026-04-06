Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10F23F46C72
	for <u-boot@archiver.kernel.org>; Mon,  6 Apr 2026 19:12:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3449083936;
	Mon,  6 Apr 2026 21:12:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dHKrIGOj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A4C6F83C2B; Mon,  6 Apr 2026 21:12:24 +0200 (CEST)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64BAC8352B
 for <u-boot@lists.denx.de>; Mon,  6 Apr 2026 21:12:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-6825009f4f5so1308537eaf.3
 for <u-boot@lists.denx.de>; Mon, 06 Apr 2026 12:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1775502739; x=1776107539; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=py1FpFOgzViLkgBS04Wl3KB8oVBcedxmottJtlt+KYU=;
 b=dHKrIGOjEbX7C1USRFcuxoMfFquWCe/TSP+rYE6MEOgLFSw8AZOiyjY3vOgUp3oswk
 ZrqMJF3+Fa9Z84/qLTfKx/GxWd/aPd5aJcfGv2OdkzYsBPhwo3+UKVEVQKRuo51fdNwH
 gNPGrXPIHS+eT8F075mogFmtDd08+PQMCsB/k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775502739; x=1776107539;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=py1FpFOgzViLkgBS04Wl3KB8oVBcedxmottJtlt+KYU=;
 b=PO8IAPVvMTxlpvMXbyw1drTi9bXqlW0yf5r/VmC4AB6s+1q+8sr9gC7nHFFDc0jDWU
 e/LaGRC4GgKCI9B+wKmDEysBSsZnIHiR86O8hMYrOYRaYJQDtbmc8AfPp9v0grCE6gZK
 ks0AC+vjyCVPGijE0H81Spvg4Ppjat0cfvrX04Ay3wuSk07Tuj247UcTK4oU/2adHaQj
 qmCFwbRRwni3EVp/p4tYN1xgT/QKFGqJHDEEAarCGYC74PPexS27QDh32cRTFUg+qWk8
 CRnM94H4BifgM2oLj6c4HBOejV/LNZpDCyymkOz9my0h8jFZi3jj9Qnn+fZLBWPr3eHi
 iJWQ==
X-Gm-Message-State: AOJu0YyRLHy+3jEFrlLb6RXDq7+Zj0qqRX2HqmkJD9twiKRzC5pArJg2
 Z0ru3pdWuQ3Qgi0AjCkJh9PtitjWE8OgIdnGpnP+xkY4ajcwMB7RKyiWie/pI9/w7bzNaLMsiZA
 bw+qDyqQ=
X-Gm-Gg: AeBDievRXrckbWOCmBB0hMdMxSeTp6MMKOBa6rNt+o5c9EFryd3vPGqLj4WOM92hm03
 5y862xNGafY+w472AxP15rXFVH0s42gwYBnDbJXrGTeEgDAxQuz5MHCG8hl34w0dXxoyoK3p2oM
 1X7l92dmuPJawVXoaRbdhsT2uljdJ+flM0ubeuLKz28xtVXdHzyz4h/VdEFJqZ/F6t0090mUTQi
 zdbUDQPx6yWoYkqzt6PIw9uU5N1zkbtEjwidmQjM4BjtSNypmBvSef7ts6JNP1PlgfS4O0YJ6pm
 tbWxS1zeRJFE6aA7xPrMrWs2haqXcjf6QOen3u2RAJcBJ5okaOZVlZG4z78eHXEuBruWHaLsYVm
 lDAuTvf6B0I9eHaC0QwNNuN1fE4xyOyf4r9tX5sOtBQFLPgzOpLYuRlg/YDwVGnFvVzNMhOJMlQ
 OS6zngEe6AqOJcN3Eb+Jlx+5ckCiXHo+YjOT3J85ivyvFkrZbtDu/VNfhBMmnY5P/9xOoUi8kf1
 Bozl+xg/KJNvdiMtH3hBdcjSp6uBSPbw+CbzYtKexd5lwLU
X-Received: by 2002:a05:6820:2007:b0:67e:f8c:6bcc with SMTP id
 006d021491bc7-6821ef8063emr7780083eaf.19.1775502738866; 
 Mon, 06 Apr 2026 12:12:18 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-422eb25a55asm12509758fac.10.2026.04.06.12.12.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 12:12:18 -0700 (PDT)
Date: Mon, 6 Apr 2026 13:12:15 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Kory Maincent <kory.maincent@bootlin.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Bo-Chen Chen <rex-bc.chen@mediatek.com>,
 David Lechner <dlechner@baylibre.com>,
 Raymond Mao <raymondmaoca@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Fwd: New Defects reported by Coverity Scan for Das U-Boot
Message-ID: <20260406191215.GY41863@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="MJExdqXX5r8sVWzt"
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


--MJExdqXX5r8sVWzt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Here's the latest report, now that I've merged next to master, locally
at least.

---------- Forwarded message ---------
=46rom: <scan-admin@coverity.com>
Date: Mon, Apr 6, 2026 at 12:40=E2=80=AFPM
Subject: New Defects reported by Coverity Scan for Das U-Boot
To: <tom.rini@gmail.com>


Hi,

Please find the latest report on new defect(s) introduced to *Das U-Boot*
found with Coverity Scan.

   - *New Defects Found:* 11
   - 15 defect(s), reported by Coverity Scan earlier, were marked fixed in
   the recent build analyzed by Coverity Scan.
   - *Defects Shown:* Showing 11 of 11 defect(s)

Defect Details

** CID 645496:         (USE_AFTER_FREE)
/tools/fwumdata_src/fwumdata.c: 94           in parse_config()
/tools/fwumdata_src/fwumdata.c: 101           in parse_config()


___________________________________________________________________________=
__________________
*** CID 645496:           (USE_AFTER_FREE)
/tools/fwumdata_src/fwumdata.c: 94             in parse_config()
88     			    &devname,
89     			    &devices[i].devoff,
90     			    &devices[i].mdata_size,
91     			    &devices[i].erase_size);
92
93     		if (rc < 3) {
>>>     CID 645496:           (USE_AFTER_FREE)
>>>     Calling "free" frees pointer "devname" which has already been freed.
94     			free(devname);
95     			continue;
96     		}
97
98     		if (rc < 4)
99     			devices[i].erase_size =3D devices[i].mdata_size;
/tools/fwumdata_src/fwumdata.c: 101             in parse_config()
95     			continue;
96     		}
97
98     		if (rc < 4)
99     			devices[i].erase_size =3D devices[i].mdata_size;
100
>>>     CID 645496:           (USE_AFTER_FREE)
>>>     Using freed pointer "devname".
101     		devices[i].devname =3D devname;
102     		i++;
103     	}
104
105     	free(line);
106     	fclose(fp);

** CID 645495:       Uninitialized variables  (UNINIT)
/fs/fat/fat.c: 175           in disk_rw()


___________________________________________________________________________=
__________________
*** CID 645495:         Uninitialized variables  (UNINIT)
/fs/fat/fat.c: 175             in disk_rw()
169     		}
170     	}
171     exit:
172     	if (block)
173     		free(block);
174
>>>     CID 645495:         Uninitialized variables  (UNINIT)
>>>     Using uninitialized value "ret".
175     	return (ret =3D=3D -1) ? -1 : nr_sect;
176     }
177
178     static int disk_read(__u32 sect, __u32 nr_sect, void *buf)
179     {
180     	return disk_rw(sect, nr_sect, buf, true);

** CID 645494:       Integer handling issues  (BAD_SHIFT)
/drivers/power/regulator/mt6359_regulator.c: 287           in
mt6359_get_voltage_sel()


___________________________________________________________________________=
__________________
*** CID 645494:         Integer handling issues  (BAD_SHIFT)
/drivers/power/regulator/mt6359_regulator.c: 287             in
mt6359_get_voltage_sel()
281
282     	selector =3D pmic_reg_read(dev->parent, info->desc.vsel_reg);
283     	if (selector < 0)
284     		return selector;
285
286     	selector &=3D info->desc.vsel_mask;
>>>     CID 645494:         Integer handling issues  (BAD_SHIFT)
>>>     In expression "selector >>=3D generic_ffs(info->desc.vsel_mask) - 1=
", shifting by a negative amount has undefined behavior.  The shift amount,=
 "generic_ffs(info->desc.vsel_mask) - 1", is -1.
287     	selector >>=3D ffs(info->desc.vsel_mask) - 1;
288
289     	return selector;
290     }
291
292     static int mt6359p_vemc_get_voltage_sel(struct udevice *dev,
struct mt6359_regulator_info *info)

** CID 645493:       Control flow issues  (DEADCODE)
/drivers/firmware/scmi/pinctrl.c: 206           in
scmi_pinctrl_settings_get_one()


___________________________________________________________________________=
__________________
*** CID 645493:         Control flow issues  (DEADCODE)
/drivers/firmware/scmi/pinctrl.c: 206             in
scmi_pinctrl_settings_get_one()
200
201     	msg.out_msg =3D (u8 *)out;
202     	msg.out_msg_sz =3D out_sz;
203     	in.id =3D selector;
204     	in.attr =3D 0;
205     	if (config_type =3D=3D SCMI_PINCTRL_CONFIG_SETTINGS_FUNCTION)
>>>     CID 645493:         Control flow issues  (DEADCODE)
>>>     Execution cannot reach the expression "in.attr" inside this stateme=
nt: "in.attr =3D ({
  ({
    do  {...".
206     		in.attr =3D FIELD_PREP(GENMASK(19, 18), 2);
207     	in.attr |=3D FIELD_PREP(GENMASK(17, 16), select_type);
208     	if (config_type !=3D SCMI_PINCTRL_CONFIG_SETTINGS_FUNCTION)
209     		in.attr |=3D FIELD_PREP(GENMASK(7, 0), config_type);
210
211     	ret =3D devm_scmi_process_msg(dev, &msg);

** CID 645492:         (BUFFER_SIZE)
/drivers/fwu-mdata/raw_mtd.c: 173           in get_fwu_mdata_dev()
/drivers/fwu-mdata/raw_mtd.c: 183           in get_fwu_mdata_dev()


___________________________________________________________________________=
__________________
*** CID 645492:           (BUFFER_SIZE)
/drivers/fwu-mdata/raw_mtd.c: 173             in get_fwu_mdata_dev()
167     	}
168
169     	/* Get the offset of primary and secondary mdata */
170     	ret =3D ofnode_read_string_index(dev_ofnode(dev),
"mdata-parts", 0, &label);
171     	if (ret)
172     		return ret;
>>>     CID 645492:           (BUFFER_SIZE)
>>>     Calling "strncpy" with a maximum size argument of 50 bytes on desti=
nation array "mtd_priv->pri_label" of size 50 bytes might leave the destina=
tion string unterminated.
173     	strncpy(mtd_priv->pri_label, label, 50);
174
175     	ret =3D flash_partition_offset(mtd_dev, mtd_priv->pri_label, &offs=
et);
176     	if (ret <=3D 0)
177     		return ret;
178     	mtd_priv->pri_offset =3D offset;
/drivers/fwu-mdata/raw_mtd.c: 183             in get_fwu_mdata_dev()
177     		return ret;
178     	mtd_priv->pri_offset =3D offset;
179
180     	ret =3D ofnode_read_string_index(dev_ofnode(dev),
"mdata-parts", 1, &label);
181     	if (ret)
182     		return ret;
>>>     CID 645492:           (BUFFER_SIZE)
>>>     Calling "strncpy" with a maximum size argument of 50 bytes on desti=
nation array "mtd_priv->sec_label" of size 50 bytes might leave the destina=
tion string unterminated.
183     	strncpy(mtd_priv->sec_label, label, 50);
184
185     	ret =3D flash_partition_offset(mtd_dev, mtd_priv->sec_label, &offs=
et);
186     	if (ret <=3D 0)
187     		return ret;
188     	mtd_priv->sec_offset =3D offset;

** CID 645491:       Security best practices violations  (STRING_OVERFLOW)
/drivers/fwu-mdata/raw_mtd.c: 244           in fwu_mtd_image_info_populate()


___________________________________________________________________________=
__________________
*** CID 645491:         Security best practices violations  (STRING_OVERFLO=
W)
/drivers/fwu-mdata/raw_mtd.c: 244             in fwu_mtd_image_info_populat=
e()
238     			ofnode_read_u32(image, "size", &image_size);
239
240     			mtd_images[off_img].start =3D bank_offset + image_offset;
241     			mtd_images[off_img].size =3D image_size;
242     			mtd_images[off_img].bank_num =3D bank_num;
243     			mtd_images[off_img].image_num =3D image_num;
>>>     CID 645491:         Security best practices violations  (STRING_OVE=
RFLOW)
>>>     You might overrun the 37-character fixed-size string "mtd_images[of=
f_img].uuidbuf" by copying "uuid" without checking the length.
244     			strcpy(mtd_images[off_img].uuidbuf, uuid);
245     			log_debug("\tImage%d: %s @0x%x\n\n",
246     				  image_num, uuid, bank_offset + image_offset);
247     			off_img++;
248     		}
249     	}

** CID 645490:       Integer handling issues  (BAD_SHIFT)
/drivers/power/regulator/mt6359_regulator.c: 245           in
mt6359p_vemc_set_voltage_sel()


___________________________________________________________________________=
__________________
*** CID 645490:         Integer handling issues  (BAD_SHIFT)
/drivers/power/regulator/mt6359_regulator.c: 245             in
mt6359p_vemc_set_voltage_sel()
239
240     static int mt6359p_vemc_set_voltage_sel(struct udevice *dev,
241     					struct mt6359_regulator_info *info, unsigned int sel)
242     {
243     	int ret;
244
>>>     CID 645490:         Integer handling issues  (BAD_SHIFT)
>>>     In expression "sel <<=3D generic_ffs(info->desc.vsel_mask) - 1", sh=
ifting by a negative amount has undefined behavior.  The shift amount, "gen=
eric_ffs(info->desc.vsel_mask) - 1", is -1.
245     	sel <<=3D ffs(info->desc.vsel_mask) - 1;
246     	ret =3D pmic_reg_write(dev->parent, MT6359P_TMA_KEY_ADDR,
MT6359P_TMA_KEY);
247     	if (ret)
248     		return ret;
249
250     	ret =3D pmic_reg_read(dev->parent, MT6359P_VM_MODE_ADDR);

** CID 645489:       Integer handling issues  (BAD_SHIFT)
/drivers/power/regulator/mt6359_regulator.c: 234           in
mt6359_set_voltage_sel_regmap()


___________________________________________________________________________=
__________________
*** CID 645489:         Integer handling issues  (BAD_SHIFT)
/drivers/power/regulator/mt6359_regulator.c: 234             in
mt6359_set_voltage_sel_regmap()
228     };
229
230     static int mt6359_set_voltage_sel_regmap(struct udevice *dev,
231     					 struct mt6359_regulator_info *info,
232     					 unsigned int sel)
233     {
>>>     CID 645489:         Integer handling issues  (BAD_SHIFT)
>>>     In expression "sel <<=3D generic_ffs(info->desc.vsel_mask) - 1", sh=
ifting by a negative amount has undefined behavior.  The shift amount, "gen=
eric_ffs(info->desc.vsel_mask) - 1", is -1.
234     	sel <<=3D ffs(info->desc.vsel_mask) - 1;
235
236     	return pmic_clrsetbits(dev->parent, info->desc.vsel_reg,
237     			       info->desc.vsel_mask, sel);
238     }
239

** CID 645488:       Error handling issues  (CHECKED_RETURN)
/tools/fwumdata_src/fwumdata.c: 189           in read_device()


___________________________________________________________________________=
__________________
*** CID 645488:         Error handling issues  (CHECKED_RETURN)
/tools/fwumdata_src/fwumdata.c: 189             in read_device()
183     {
184     	if (lseek(dev->fd, dev->devoff, SEEK_SET) < 0) {
185     		fprintf(stderr, "Seek failed: %s\n", strerror(errno));
186     		return -errno;
187     	}
188
>>>     CID 645488:         Error handling issues  (CHECKED_RETURN)
>>>     "read(int, void *, size_t)" returns the number of bytes read, but i=
t is ignored.
189     	if (read(dev->fd, buf, count) < 0) {
190     		fprintf(stderr, "Read failed: %s\n", strerror(errno));
191     		return -errno;
192     	}
193
194     	return 0;

** CID 645487:       Insecure data handling  (TAINTED_SCALAR)
/lib/smbios.c: 1099           in smbios_write_type9_1slot()


___________________________________________________________________________=
__________________
*** CID 645487:         Insecure data handling  (TAINTED_SCALAR)
/lib/smbios.c: 1099             in smbios_write_type9_1slot()
1093     	 * TODO:
1094     	 * peer_groups =3D <peer_grouping_count> * SMBIOS_TYPE9_PGROUP_SI=
ZE
1095     	 */
1096     	len +=3D pgroups_size;
1097
1098     	t =3D map_sysmem(*current, len);
>>>     CID 645487:         Insecure data handling  (TAINTED_SCALAR)
>>>     Passing tainted expression "len" to "memset", which uses it as an o=
ffset. [Note: The source code implementation of the function has been overr=
idden by a builtin model.]
1099     	memset(t, 0, len);
1100
1101     	fill_smbios_header(t, SMBIOS_SYSTEM_SLOTS, len, handle);
1102
1103     	/* eos is at the end of the structure */
1104     	eos_addr =3D (u8 *)t + len - sizeof(t->eos);

** CID 645486:       Integer handling issues  (BAD_SHIFT)
/drivers/power/regulator/mt6359_regulator.c: 312           in
mt6359p_vemc_get_voltage_sel()


___________________________________________________________________________=
__________________
*** CID 645486:         Integer handling issues  (BAD_SHIFT)
/drivers/power/regulator/mt6359_regulator.c: 312             in
mt6359p_vemc_get_voltage_sel()
306     		return -EINVAL;
307     	}
308     	if (selector < 0)
309     		return selector;
310
311     	selector &=3D info->desc.vsel_mask;
>>>     CID 645486:         Integer handling issues  (BAD_SHIFT)
>>>     In expression "selector >>=3D generic_ffs(info->desc.vsel_mask) - 1=
", shifting by a negative amount has undefined behavior.  The shift amount,=
 "generic_ffs(info->desc.vsel_mask) - 1", is -1.
312     	selector >>=3D ffs(info->desc.vsel_mask) - 1;
313
314     	return selector;
315     }
316
317     static int mt6359_get_enable(struct udevice *dev)



View Defects in Coverity Scan
<https://scan.coverity.com/projects/das-u-boot?tab=3Doverview>

Best regards,

The Coverity Scan Admin Team

----- End forwarded message -----

--=20
Tom

--MJExdqXX5r8sVWzt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCadQFjAAKCRAr4qD1Cr/k
ClI3AP0Y/73BHAGt70JsF+93T0DFWJ0jhNhtz3YqUOgcRTe0sQEAlVfkPkKQZFHm
LA4dPoqR3eQl0KmebpLRHfFNoNfWpgc=
=lknq
-----END PGP SIGNATURE-----

--MJExdqXX5r8sVWzt--
