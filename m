Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB932FF513E
	for <u-boot@archiver.kernel.org>; Tue,  7 Apr 2026 20:44:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33AFC840B0;
	Tue,  7 Apr 2026 22:44:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DcgRMVjV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1AE1784106; Tue,  7 Apr 2026 22:44:54 +0200 (CEST)
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com
 [IPv6:2607:f8b0:4864:20::a2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D68D4840AB
 for <u-boot@lists.denx.de>; Tue,  7 Apr 2026 22:44:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-vk1-xa2c.google.com with SMTP id
 71dfb90a1353d-56d36e7d8e6so3794312e0c.2
 for <u-boot@lists.denx.de>; Tue, 07 Apr 2026 13:44:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775594689; cv=none;
 d=google.com; s=arc-20240605;
 b=a6uVOqdJiqgdTncF9Hw4DfNQPXxp5T+q7AaonOiVC/RFCgIA6/STvdHjHjJJvN+Gzc
 C+WD0G2byBSjBm1JzlzKIrMyfeMK6AmJZHkxeT9xtfJBR8oyHiS8f1y5GZMtaf01oBn3
 36FV8ljDlcPHlOta6ZNu+DBzdulFB9g0i/DEnHuZj/NPVe9R2+e+nvcM88mJj6lAIIbI
 2FpoV3iMMtif9izrY9Flv+Jr9vmVneJbwpLEq5BHH1SRTr6vMiX7vNUtuLtVtTITgR2T
 DSzIC/V0Az+SOG5apcKYE0jcwjF+Ju2FT0vx8EOY8lirMhI7d+qELY/FsBUVSzlRC7KV
 EPIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=dqQqP4yDpQ94BNGS8Dhw8m4OCKqrvm7+US0vfUdwf54=;
 fh=CB7+Pwjur9XYB5geL34R5p8Ofb+2h/M2iZLcuXe+qeA=;
 b=fY4YaWbcuzBPF6QxwdCvcyzWm4U4EO2Ro22LXgRcECDBPp4V/uBUhFzi5r8kbrFrwU
 Z1KIUyfevyCAEVExzi3tRd8UhWLW2DkWWQx8YlI6kh/U9Z05DJ0wG3T3RY/FVKOSb818
 i7VGeDdwexfbnGh2C1ikKbtYt/Q0KfeJNuVVEXAwcnL5wGvLLTtei3Iu4biezUWYiCpx
 ZZI7lHCPIo0It9KRSMjUCbCL+mznVa5xqR/wnWv5kmnQQoPrWXSuIEvd0J/n+bf1D+sk
 ZnXMsiuaylu8lZIa7J2dpYAfbD04B8/H8MsuQ2sj2uAaB/SkHnJAVfmP7oLcLb75gDE1
 /Yuw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775594689; x=1776199489; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dqQqP4yDpQ94BNGS8Dhw8m4OCKqrvm7+US0vfUdwf54=;
 b=DcgRMVjV7TW86Xp/ZNwybJog16yefcxCOo0TgsBaA4ahIgjUhJmPHiFP8nFzHvn0xs
 uype0wkn/BlsFvaTyG+2tcoC9Am/9VUkGCF1oHGoY719U+zUR9tc5SoFupmvUG9KIl6Z
 VKycuMt0CybtCMCEzhYppllSR8zgAr07br/jLbwFO57eWzd01HVa61KuVuYtmZZVtIV9
 cUh14QBHn97nCo5QTyn34Ig0Er0aAs2hEhFXOQSJTTo8WbeGiliJi7IWElba4GEWGhmN
 QLyzZi4SBHxkoRaiFBtQNA6ZZxa7LiH7nTVvTmklEhf1qVqri8kFDxE7+JQrNKIABRlD
 SX0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775594689; x=1776199489;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dqQqP4yDpQ94BNGS8Dhw8m4OCKqrvm7+US0vfUdwf54=;
 b=nIYiTEV/ZECcQoAEireUjP1cZ0dViJMHuXXZvuiA5o0OyMj7cl7HGcLX/5KdZPW6gP
 pGpEvF3shr0zfzapyeTvelyq/SIENqs6oLv1gqyf2XkMTV2pYDHVPRjbMyukuOeId9sl
 /IbC4uKTC9SOVnSbtnlbjaSyXNjjOYnUI86+zXvAxCvovRnpY4GOCf2qGS8I7GdTNaaR
 hf0J1Yukru+LlDzprxM8OvAIKfBVtN25CPDjOdJo07IknjUjcd0ELrDJqaVLFJz4x2kx
 hPdcnLsIaYMFDyCBuPceAIPMXBOIwm4CAE9XumGmt0ZdYhBE6DeNniJVqNUB5AadNWvh
 U/pg==
X-Gm-Message-State: AOJu0YzLh9lzVFA55zTWWW/5nUd7slUFSJkN9rNB8YsWVqxDOBfk+M84
 OePRxGVsTTzVQZd1UREJKKY4mMzzit8F4QMz/0N8h9IfqEp0S6+tBNY27/oGnRaIoI9DRys7xH+
 h1BCN9VprPBcfqs8E3pYEmt7+7vCa9QE=
X-Gm-Gg: AeBDietXBoYrTLNDfZnAbcoaE0LyTTJtsZES8kgd3Z1CAl8mUuKSen8HZbIp4QXviNb
 LrYXa8QStjAilmF+C9fs61s6Wy3IPNCnUIJmR/tCjSrsrC3jw7aZHPy2m36R/StYW97YJo+IyDX
 aRQyAoyiyh6qqEaUUvWIf1rZPwXecLUUo+R4OOLq9WcUqMEjQgl59klFVDg0JMeeg6Azn61T/DI
 djg0vSwuH9CkOvZusGdnmJo8SMWOPz++iuqFUBhQKeyboaB0I85ws9YbsBxxvUfHVCVX1ZIDVAo
 rC3tmkES
X-Received: by 2002:a05:6122:e16f:b0:56d:9f2a:d6b1 with SMTP id
 71dfb90a1353d-56daba130b3mr7238613e0c.12.1775594688613; Tue, 07 Apr 2026
 13:44:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260406191215.GY41863@bill-the-cat>
In-Reply-To: <20260406191215.GY41863@bill-the-cat>
From: Raymond Mao <raymondmaoca@gmail.com>
Date: Tue, 7 Apr 2026 16:44:36 -0400
X-Gm-Features: AQROBzAsmVpS5Ww7eudCZxRbMfQPJhIpupF7L4AW8YF1Y3T4EgjZ98gi5NoVbK4
Message-ID: <CAMDkj5yKfRjfYye6O9rE-1-KepODQbhRstLgcKpD0jZ03g+5Uw@mail.gmail.com>
Subject: Re: New Defects reported by Coverity Scan for Das U-Boot
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Kory Maincent <kory.maincent@bootlin.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 Bo-Chen Chen <rex-bc.chen@mediatek.com>, David Lechner <dlechner@baylibre.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Tom,

On Mon, Apr 6, 2026 at 3:12=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote:
>
> Here's the latest report, now that I've merged next to master, locally
> at least.
>
> ---------- Forwarded message ---------
> From: <scan-admin@coverity.com>
> Date: Mon, Apr 6, 2026 at 12:40=E2=80=AFPM
> Subject: New Defects reported by Coverity Scan for Das U-Boot
> To: <tom.rini@gmail.com>
>
>
> Hi,
>
> Please find the latest report on new defect(s) introduced to *Das U-Boot*
> found with Coverity Scan.
>
>    - *New Defects Found:* 11
>    - 15 defect(s), reported by Coverity Scan earlier, were marked fixed i=
n
>    the recent build analyzed by Coverity Scan.
>    - *Defects Shown:* Showing 11 of 11 defect(s)
>
> Defect Details
>
> ** CID 645496:         (USE_AFTER_FREE)
> /tools/fwumdata_src/fwumdata.c: 94           in parse_config()
> /tools/fwumdata_src/fwumdata.c: 101           in parse_config()
>
>
> _________________________________________________________________________=
____________________
> *** CID 645496:           (USE_AFTER_FREE)
> /tools/fwumdata_src/fwumdata.c: 94             in parse_config()
> 88                          &devname,
> 89                          &devices[i].devoff,
> 90                          &devices[i].mdata_size,
> 91                          &devices[i].erase_size);
> 92
> 93              if (rc < 3) {
> >>>     CID 645496:           (USE_AFTER_FREE)
> >>>     Calling "free" frees pointer "devname" which has already been fre=
ed.
> 94                      free(devname);
> 95                      continue;
> 96              }
> 97
> 98              if (rc < 4)
> 99                      devices[i].erase_size =3D devices[i].mdata_size;
> /tools/fwumdata_src/fwumdata.c: 101             in parse_config()
> 95                      continue;
> 96              }
> 97
> 98              if (rc < 4)
> 99                      devices[i].erase_size =3D devices[i].mdata_size;
> 100
> >>>     CID 645496:           (USE_AFTER_FREE)
> >>>     Using freed pointer "devname".
> 101                     devices[i].devname =3D devname;
> 102                     i++;
> 103             }
> 104
> 105             free(line);
> 106             fclose(fp);
>
> ** CID 645495:       Uninitialized variables  (UNINIT)
> /fs/fat/fat.c: 175           in disk_rw()
>
>
> _________________________________________________________________________=
____________________
> *** CID 645495:         Uninitialized variables  (UNINIT)
> /fs/fat/fat.c: 175             in disk_rw()
> 169                     }
> 170             }
> 171     exit:
> 172             if (block)
> 173                     free(block);
> 174
> >>>     CID 645495:         Uninitialized variables  (UNINIT)
> >>>     Using uninitialized value "ret".
> 175             return (ret =3D=3D -1) ? -1 : nr_sect;
> 176     }
> 177
> 178     static int disk_read(__u32 sect, __u32 nr_sect, void *buf)
> 179     {
> 180             return disk_rw(sect, nr_sect, buf, true);
>
> ** CID 645494:       Integer handling issues  (BAD_SHIFT)
> /drivers/power/regulator/mt6359_regulator.c: 287           in
> mt6359_get_voltage_sel()
>
>
> _________________________________________________________________________=
____________________
> *** CID 645494:         Integer handling issues  (BAD_SHIFT)
> /drivers/power/regulator/mt6359_regulator.c: 287             in
> mt6359_get_voltage_sel()
> 281
> 282             selector =3D pmic_reg_read(dev->parent, info->desc.vsel_r=
eg);
> 283             if (selector < 0)
> 284                     return selector;
> 285
> 286             selector &=3D info->desc.vsel_mask;
> >>>     CID 645494:         Integer handling issues  (BAD_SHIFT)
> >>>     In expression "selector >>=3D generic_ffs(info->desc.vsel_mask) -=
 1", shifting by a negative amount has undefined behavior.  The shift amoun=
t, "generic_ffs(info->desc.vsel_mask) - 1", is -1.
> 287             selector >>=3D ffs(info->desc.vsel_mask) - 1;
> 288
> 289             return selector;
> 290     }
> 291
> 292     static int mt6359p_vemc_get_voltage_sel(struct udevice *dev,
> struct mt6359_regulator_info *info)
>
> ** CID 645493:       Control flow issues  (DEADCODE)
> /drivers/firmware/scmi/pinctrl.c: 206           in
> scmi_pinctrl_settings_get_one()
>
>
> _________________________________________________________________________=
____________________
> *** CID 645493:         Control flow issues  (DEADCODE)
> /drivers/firmware/scmi/pinctrl.c: 206             in
> scmi_pinctrl_settings_get_one()
> 200
> 201             msg.out_msg =3D (u8 *)out;
> 202             msg.out_msg_sz =3D out_sz;
> 203             in.id =3D selector;
> 204             in.attr =3D 0;
> 205             if (config_type =3D=3D SCMI_PINCTRL_CONFIG_SETTINGS_FUNCT=
ION)
> >>>     CID 645493:         Control flow issues  (DEADCODE)
> >>>     Execution cannot reach the expression "in.attr" inside this state=
ment: "in.attr =3D ({
>   ({
>     do  {...".
> 206                     in.attr =3D FIELD_PREP(GENMASK(19, 18), 2);
> 207             in.attr |=3D FIELD_PREP(GENMASK(17, 16), select_type);
> 208             if (config_type !=3D SCMI_PINCTRL_CONFIG_SETTINGS_FUNCTIO=
N)
> 209                     in.attr |=3D FIELD_PREP(GENMASK(7, 0), config_typ=
e);
> 210
> 211             ret =3D devm_scmi_process_msg(dev, &msg);
>
> ** CID 645492:         (BUFFER_SIZE)
> /drivers/fwu-mdata/raw_mtd.c: 173           in get_fwu_mdata_dev()
> /drivers/fwu-mdata/raw_mtd.c: 183           in get_fwu_mdata_dev()
>
>
> _________________________________________________________________________=
____________________
> *** CID 645492:           (BUFFER_SIZE)
> /drivers/fwu-mdata/raw_mtd.c: 173             in get_fwu_mdata_dev()
> 167             }
> 168
> 169             /* Get the offset of primary and secondary mdata */
> 170             ret =3D ofnode_read_string_index(dev_ofnode(dev),
> "mdata-parts", 0, &label);
> 171             if (ret)
> 172                     return ret;
> >>>     CID 645492:           (BUFFER_SIZE)
> >>>     Calling "strncpy" with a maximum size argument of 50 bytes on des=
tination array "mtd_priv->pri_label" of size 50 bytes might leave the desti=
nation string unterminated.
> 173             strncpy(mtd_priv->pri_label, label, 50);
> 174
> 175             ret =3D flash_partition_offset(mtd_dev, mtd_priv->pri_lab=
el, &offset);
> 176             if (ret <=3D 0)
> 177                     return ret;
> 178             mtd_priv->pri_offset =3D offset;
> /drivers/fwu-mdata/raw_mtd.c: 183             in get_fwu_mdata_dev()
> 177                     return ret;
> 178             mtd_priv->pri_offset =3D offset;
> 179
> 180             ret =3D ofnode_read_string_index(dev_ofnode(dev),
> "mdata-parts", 1, &label);
> 181             if (ret)
> 182                     return ret;
> >>>     CID 645492:           (BUFFER_SIZE)
> >>>     Calling "strncpy" with a maximum size argument of 50 bytes on des=
tination array "mtd_priv->sec_label" of size 50 bytes might leave the desti=
nation string unterminated.
> 183             strncpy(mtd_priv->sec_label, label, 50);
> 184
> 185             ret =3D flash_partition_offset(mtd_dev, mtd_priv->sec_lab=
el, &offset);
> 186             if (ret <=3D 0)
> 187                     return ret;
> 188             mtd_priv->sec_offset =3D offset;
>
> ** CID 645491:       Security best practices violations  (STRING_OVERFLOW=
)
> /drivers/fwu-mdata/raw_mtd.c: 244           in fwu_mtd_image_info_populat=
e()
>
>
> _________________________________________________________________________=
____________________
> *** CID 645491:         Security best practices violations  (STRING_OVERF=
LOW)
> /drivers/fwu-mdata/raw_mtd.c: 244             in fwu_mtd_image_info_popul=
ate()
> 238                             ofnode_read_u32(image, "size", &image_siz=
e);
> 239
> 240                             mtd_images[off_img].start =3D bank_offset=
 + image_offset;
> 241                             mtd_images[off_img].size =3D image_size;
> 242                             mtd_images[off_img].bank_num =3D bank_num=
;
> 243                             mtd_images[off_img].image_num =3D image_n=
um;
> >>>     CID 645491:         Security best practices violations  (STRING_O=
VERFLOW)
> >>>     You might overrun the 37-character fixed-size string "mtd_images[=
off_img].uuidbuf" by copying "uuid" without checking the length.
> 244                             strcpy(mtd_images[off_img].uuidbuf, uuid)=
;
> 245                             log_debug("\tImage%d: %s @0x%x\n\n",
> 246                                       image_num, uuid, bank_offset + =
image_offset);
> 247                             off_img++;
> 248                     }
> 249             }
>
> ** CID 645490:       Integer handling issues  (BAD_SHIFT)
> /drivers/power/regulator/mt6359_regulator.c: 245           in
> mt6359p_vemc_set_voltage_sel()
>
>
> _________________________________________________________________________=
____________________
> *** CID 645490:         Integer handling issues  (BAD_SHIFT)
> /drivers/power/regulator/mt6359_regulator.c: 245             in
> mt6359p_vemc_set_voltage_sel()
> 239
> 240     static int mt6359p_vemc_set_voltage_sel(struct udevice *dev,
> 241                                             struct mt6359_regulator_i=
nfo *info, unsigned int sel)
> 242     {
> 243             int ret;
> 244
> >>>     CID 645490:         Integer handling issues  (BAD_SHIFT)
> >>>     In expression "sel <<=3D generic_ffs(info->desc.vsel_mask) - 1", =
shifting by a negative amount has undefined behavior.  The shift amount, "g=
eneric_ffs(info->desc.vsel_mask) - 1", is -1.
> 245             sel <<=3D ffs(info->desc.vsel_mask) - 1;
> 246             ret =3D pmic_reg_write(dev->parent, MT6359P_TMA_KEY_ADDR,
> MT6359P_TMA_KEY);
> 247             if (ret)
> 248                     return ret;
> 249
> 250             ret =3D pmic_reg_read(dev->parent, MT6359P_VM_MODE_ADDR);
>
> ** CID 645489:       Integer handling issues  (BAD_SHIFT)
> /drivers/power/regulator/mt6359_regulator.c: 234           in
> mt6359_set_voltage_sel_regmap()
>
>
> _________________________________________________________________________=
____________________
> *** CID 645489:         Integer handling issues  (BAD_SHIFT)
> /drivers/power/regulator/mt6359_regulator.c: 234             in
> mt6359_set_voltage_sel_regmap()
> 228     };
> 229
> 230     static int mt6359_set_voltage_sel_regmap(struct udevice *dev,
> 231                                              struct mt6359_regulator_=
info *info,
> 232                                              unsigned int sel)
> 233     {
> >>>     CID 645489:         Integer handling issues  (BAD_SHIFT)
> >>>     In expression "sel <<=3D generic_ffs(info->desc.vsel_mask) - 1", =
shifting by a negative amount has undefined behavior.  The shift amount, "g=
eneric_ffs(info->desc.vsel_mask) - 1", is -1.
> 234             sel <<=3D ffs(info->desc.vsel_mask) - 1;
> 235
> 236             return pmic_clrsetbits(dev->parent, info->desc.vsel_reg,
> 237                                    info->desc.vsel_mask, sel);
> 238     }
> 239
>
> ** CID 645488:       Error handling issues  (CHECKED_RETURN)
> /tools/fwumdata_src/fwumdata.c: 189           in read_device()
>
>
> _________________________________________________________________________=
____________________
> *** CID 645488:         Error handling issues  (CHECKED_RETURN)
> /tools/fwumdata_src/fwumdata.c: 189             in read_device()
> 183     {
> 184             if (lseek(dev->fd, dev->devoff, SEEK_SET) < 0) {
> 185                     fprintf(stderr, "Seek failed: %s\n", strerror(err=
no));
> 186                     return -errno;
> 187             }
> 188
> >>>     CID 645488:         Error handling issues  (CHECKED_RETURN)
> >>>     "read(int, void *, size_t)" returns the number of bytes read, but=
 it is ignored.
> 189             if (read(dev->fd, buf, count) < 0) {
> 190                     fprintf(stderr, "Read failed: %s\n", strerror(err=
no));
> 191                     return -errno;
> 192             }
> 193
> 194             return 0;
>
> ** CID 645487:       Insecure data handling  (TAINTED_SCALAR)
> /lib/smbios.c: 1099           in smbios_write_type9_1slot()
>
>
> _________________________________________________________________________=
____________________
> *** CID 645487:         Insecure data handling  (TAINTED_SCALAR)
> /lib/smbios.c: 1099             in smbios_write_type9_1slot()
> 1093             * TODO:
> 1094             * peer_groups =3D <peer_grouping_count> * SMBIOS_TYPE9_P=
GROUP_SIZE
> 1095             */
> 1096            len +=3D pgroups_size;
> 1097
> 1098            t =3D map_sysmem(*current, len);
> >>>     CID 645487:         Insecure data handling  (TAINTED_SCALAR)
> >>>     Passing tainted expression "len" to "memset", which uses it as an=
 offset. [Note: The source code implementation of the function has been ove=
rridden by a builtin model.]

Fixed with patch at:
https://lore.kernel.org/u-boot/20260407204113.3102785-1-raymondmaoca@gmail.=
com/T/#u

Regards,
Raymond

> 1099            memset(t, 0, len);
> 1100
> 1101            fill_smbios_header(t, SMBIOS_SYSTEM_SLOTS, len, handle);
> 1102
> 1103            /* eos is at the end of the structure */
> 1104            eos_addr =3D (u8 *)t + len - sizeof(t->eos);
>
> ** CID 645486:       Integer handling issues  (BAD_SHIFT)
> /drivers/power/regulator/mt6359_regulator.c: 312           in
> mt6359p_vemc_get_voltage_sel()
>
>
> _________________________________________________________________________=
____________________
> *** CID 645486:         Integer handling issues  (BAD_SHIFT)
> /drivers/power/regulator/mt6359_regulator.c: 312             in
> mt6359p_vemc_get_voltage_sel()
> 306                     return -EINVAL;
> 307             }
> 308             if (selector < 0)
> 309                     return selector;
> 310
> 311             selector &=3D info->desc.vsel_mask;
> >>>     CID 645486:         Integer handling issues  (BAD_SHIFT)
> >>>     In expression "selector >>=3D generic_ffs(info->desc.vsel_mask) -=
 1", shifting by a negative amount has undefined behavior.  The shift amoun=
t, "generic_ffs(info->desc.vsel_mask) - 1", is -1.
> 312             selector >>=3D ffs(info->desc.vsel_mask) - 1;
> 313
> 314             return selector;
> 315     }
> 316
> 317     static int mt6359_get_enable(struct udevice *dev)
>
>
>
> View Defects in Coverity Scan
> <https://scan.coverity.com/projects/das-u-boot?tab=3Doverview>
>
> Best regards,
>
> The Coverity Scan Admin Team
>
> ----- End forwarded message -----
>
> --
> Tom
