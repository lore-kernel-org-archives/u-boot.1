Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 319ABC27C40
	for <u-boot@archiver.kernel.org>; Wed, 22 Nov 2023 20:57:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E8248764D;
	Wed, 22 Nov 2023 21:57:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=web.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=web.de header.i=th.thielemann@web.de header.b="Tck9iK60";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2757C8763E; Wed, 22 Nov 2023 21:57:32 +0100 (CET)
Received: from mout.web.de (mout.web.de [217.72.192.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12EAF875F3
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 21:57:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=web.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=th.thielemann@web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
 t=1700686649; x=1701291449; i=th.thielemann@web.de;
 bh=9vf/GPe2paWRUj3Vd4iNpfvvo+G+uVIWDZAYmFthT5Q=;
 h=X-UI-Sender-Class:From:Subject:Date:To;
 b=Tck9iK60HCbZimMWuvnRqIXvccZKCQWnSS/iUpR0XFN8W7c/UwJ5EwiXtU6D/gPB
 2SISQeUhaTjlYFadnAVtu30JqwVGf0j3mbGvQr8Ps2SY6ovE13jb9cwwy39hljhu2
 DBFc3PGEc63+EXB5SZHezNUS8o0W7/dKlik7/ZRxhoigUKI7o4RS7c1q3g/TtbEB5
 8P27fcUbEDN45zDJnQGlQUNcEzHIloIN/7sE3dcq/QX4zeV/e49zuFhpd04PgJxfB
 ZZ//IAs0KaI+MpSuBH3zUnHOdDX29FZwZfBAhYAVUvdZ+h7Cj3ezsalPqdxdG3tLe
 YvIUpuEg5oXjrpnPeA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from smtpclient.apple ([94.31.101.165]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MgzeZ-1rXpVk26px-00h3D2 for
 <u-boot@lists.denx.de>; Wed, 22 Nov 2023 21:57:29 +0100
From: Thomas Thielemann <th.thielemann@web.de>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6\))
Subject: How to use I2C in U-Boot SPL
Message-Id: <45DABC1E-1E63-47C5-BFBF-689EE01AAE48@web.de>
Date: Wed, 22 Nov 2023 21:57:18 +0100
To: u-boot@lists.denx.de
X-Mailer: Apple Mail (2.3731.700.6)
X-Provags-ID: V03:K1:daff7p5gAokuDOW6rgp3MTOiObSgD2Svqk7zeZH4ewrTGXJPmo6
 bp7rAVRSUCwAG70LueTWsMsk6yMgCdk0fM3un7skvqEAW2vTd9HGnnaQ6FYUc+b6aK9/m3Q
 U/m2Hm7uMhWLTWch40moU8SiKvEsXvywR3GVvf8BZUvnDgAMd3totXG77cexwYkw0/aJ/bS
 b1Kfe9591Tvtwmme+gupw==
UI-OutboundReport: notjunk:1;M01:P0:lLD5jpxpkPc=;/9WE39/2GfGTVDCrdKeKVQTnHFg
 R8yeLd61wixX/l42r4qGWGjzrrJ6MO/N0YaX2Pl1bCs+fT3y1GRg8KOd1/tIHNzE/Odvs2Opw
 hydcQs+zxJhdHLY2oEnox6zO3Gmro17hkbx0karyTo/WFUcc1tmix+3cDBvPZ6Zc8ReYHaj0q
 ZcPPB8wmLQiKvlGyAtCI2H81+7XYUGGAHkDF5pqQLKvPiDXH2akl1cnponGQP/xFlMZ5ahJlp
 M1H08zkXNbLAWHBuHMvf/Bp71psvuE6+4mmocBa9FNqI/PEUSNdTdll5hEiN3cp9F4rR61kuc
 am0cXKPDuBN+cjCfR6I9BxanDnR5OMBQP7ugPbJaO+Bf54Kdq3+t6PPlLRJm0k0V7wJKFlXyt
 ttzVtdiHyhnWLYqm7pu/tdDetmSROwV6hlJrVn82DY9Lnp7D3naW+dI3I6REp+ncsFumqECc/
 UJa4DNe2Qs/0PVIa+kx4TeBnZAcnOX+Ioh6z1XivLMPIuRCZbkXLW5dXtNGwWfYSmdHoIH7Ou
 AM+60R73lkNPCL3K5b8mlxjY63LywS7sN4IfdjulKn4BOjdNO1yLgIs9qdOHslFP37UNjcRD4
 BWcX3AUtuqdGwPiRKg18nvz3aMBRzvXhYSmqc2ibUc8NtNEpn+5o96X6pHPUVtf9JmGE1j5sh
 szH1zaqQYQF5v1EbItAMDAoU+i2gBbYe7F+rwS89gtjnZwXAv8KH/Z174CYD2Du+gx+sDq/+4
 y5u91+5E24Zqmqfmq0lHXUoV7/z+KCoUxkgtsP0okJ17Ye90aDvDPL42gv/sfQFymvcAEIXZ/
 gMI4rYjfl0CmrMmkQ8litoEXlPY8BDG/MrJw7TsSbQ2Z+JuAOq7ica/fkBIuOJHRIMhKZZZlU
 o4zFpkD+hz3FTVZiNEIarC0UKZj4LN4uocA5cAVGOm9D0pW0X67z7Heq3C3s09TqtC9FRE3NY
 7RrcmEOz0TXkbwbxUHhCJWajluU=
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hello U-Boot,

I was able to use the I2C commands from within U-Boot to control my I2C =
device:

Configured the Processor GPIOs for the I2C bus in device tree
Enabled the I2C bus in device tree
Added my device to the I2C bus in device tree
Wrote my script into a U-Boot variable
Run my script
Now I want to do the same from within the U-Boot SPL. I extended int =
board_early_init_f(void) in board.c for my hardware. The debug output is =
printed at run time. But the I2C device is not found.

How do I review whether the I2C bus is using the right GPIOs and whether =
my device is configured right?

static int i2c_get_dev(uint bus_num, uint dev_num, struct udevice =
**i2c_dev)
{
    int ret;

    if (!i2c_led_bus) {
        ret =3D uclass_get_device_by_seq(UCLASS_I2C, bus_num, =
&i2c_led_bus);
        if (ret) {
            printf("I2C bus %i not found (%d)\n", dev_num, ret);
            return -ENODEV;
        }
    }

    return i2c_get_chip(i2c_led_bus, dev_num, bus_num, i2c_dev);
}
#endif

static int i2c_enable_leds(void)
{
    log_info("i2c_enable_leds\n");
    const uint  bus_num =3D 1;    // i2c bus
    const uint  dev_num =3D 0x28;     // i2c chip address
    const uint  dev_addr =3D 0x00;    // write all bytes in one junk =
from start
    const uint  dev_addr_len =3D 1;
    int     ret;
    const uint  cmd_len =3D 29;       // cmd_len is the number of bytes.
    uchar   cmd[29] =3D {
        0x40, 0x3c, // init
        0x00, 0x00, 0x00, 0x00, 0x00, // unused
        0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, // set =
intensitiy to max
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, // unused
        0xff, 0x00, 0x00, // RGB LED
        0xff, 0x00, 0x00 // RGB LED
    };
#if CONFIG_IS_ENABLED(DM_I2C)
    struct udevice *i2c_dev;
    struct dm_i2c_chip *i2c_chip;
#endif

#if CONFIG_IS_ENABLED(DM_I2C)
    ret =3D i2c_get_dev(bus_num, dev_num, &i2c_dev);
    if (!ret)
        ret =3D i2c_set_chip_offset_len(i2c_dev, dev_addr_len);
    if (ret) {
        log_err("Failed to write to 0x28 (%d)\n", ret);
        return ret;
    }
    i2c_chip =3D dev_get_parent_plat(i2c_dev);
    if (!i2c_chip) {
        log_err("Failed to write to 0x28 (%d)\n", ret);
        return ret;
    }
#endif

#if CONFIG_IS_ENABLED(DM_I2C)
        i2c_chip->flags &=3D ~DM_I2C_CHIP_WR_ADDRESS;
        ret =3D dm_i2c_write(i2c_dev, dev_addr, cmd, cmd_len);
#else
        ret =3D i2c_write(dev_num, dev_addr, dev_addr_len, cmd, =
cmd_len);
#endif
        if (ret)
            log_err("Failed to write to 0x28 (%d)\n", ret);

    return 0;
}
int board_early_init_f(void)
{
    i2c_enable_leds();

    return 0;
}


Regards,
Thomas=
