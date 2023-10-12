Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90A46CDB47E
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 09:51:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C23286DC5;
	Thu, 12 Oct 2023 11:51:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="jSoQat8W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E49286D62; Thu, 12 Oct 2023 11:51:24 +0200 (CEST)
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0F0C86D1F
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 11:51:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chris.obbard@collabora.com
Received: from [IPv6:2a00:23c8:b70a:ae01:ba8c:b93a:20b1:6864] (unknown
 [IPv6:2a00:23c8:b70a:ae01:ba8c:b93a:20b1:6864])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: obbardc)
 by madras.collabora.co.uk (Postfix) with ESMTPSA id EF0F06607337;
 Thu, 12 Oct 2023 10:51:20 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1697104281;
 bh=BNaoq3+hOwTdeVWh1t7KC1ffC7IoBpSdV6OUOpwx9+c=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
 b=jSoQat8W4RXtk1c/jyu+/chgMGIHTkHPyiiiL+lPnt5uKOWvJ/t2pWn8x8riHGxvv
 Vas7CWSOZk8wVqUSVEYCBCq97NFVmjv2ftUuIISLblnLJwSnAodpT+8zsqxjKzJ//1
 fjkSCCPUNybg92IDpVmIWR6ZbeL4YVlO224aA2fzMD4JcIDdRL+QSQdQgbSj3ow2jg
 i8MrJk96sax736i8joEesm2WnjF45hBvMtt9OZewPU/jjJKmW07Oe41VjMVk3aS3ax
 UHED0JzUdMbZQvuFBWwmDXviiBvsXvEG0IBqnifU2y2gfE23tuDAUaWBrevTjFIVB3
 xjTRAlgFDuyZw==
Message-ID: <bf74c779670c2dc249278b5a52620d7fcebafe98.camel@collabora.com>
Subject: Re: [PATCH 1/5] board: rockchip: Add Pine64 Quartz64-A Board
From: Christopher Obbard <chris.obbard@collabora.com>
To: Jonas Karlman <jonas@kwiboo.se>, Nicolas Frattaroli
 <frattaroli.nicolas@gmail.com>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, u-boot@lists.denx.de
Date: Thu, 12 Oct 2023 10:51:18 +0100
In-Reply-To: <c6acb79a-aa4c-f6e0-648e-7890e75ff714@kwiboo.se>
References: <20230723145504.2967971-1-jonas@kwiboo.se>
 <20230723145504.2967971-2-jonas@kwiboo.se>
 <1e3634df-593c-506d-5254-332c44ca7c4d@kwiboo.se>
 <9ba7a208113eed26c61d3373f1659b866c1f8c85.camel@collabora.com>
 <c6acb79a-aa4c-f6e0-648e-7890e75ff714@kwiboo.se>
Autocrypt: addr=chris.obbard@collabora.com; prefer-encrypt=mutual;
 keydata=mQINBF7k5dIBEACmD3CqXJiJOtLEjilK2ghCO47y9Fl8+jc8yQPNsp4rMZuzlryL3vLseG0DpR3XE0bK0ojRLhUAqw13epLR5/nWp5ehm8kcy8WyDMBco9DaEyoElKCfelMvTtwmYkJXj8Z831nzzyh1CocFoFStL8HyLHc2/iU1wjczkL0t5hC9KvukV3koQTc9w03sNHeZyZedZIwR/r83k1myJXJsOPXZbmI2KGKq5QV4kTqgQJw3OkSVIQ9Mz2zVZNLKedWr2syrHFgojb7WX5iXbMUgJ8/Ikdttou0B/2xfgKNyKFe0DsbgkcEsJTIsx+C/Ju0+ycEk/7dW69oQLJo0j1oBP+8QfAeAT+M5C0uHC87KAmmy83Sh0xMGAVpcH2lLrE+5SjV3rnB+x/R4B/x7+1uYB5n7MU4/W2lYuAe1hfLtqDbEOyqLzC0FvFiZoDKxexQzcGpSW/LliBEvjjA/LXWADaM+mZezzLSjDwsGVohQrP0ZWOZ1NtC0e1sEt870fa4f+YkZeVHJRDInTcecw6c2QpNH4TzcTMD7bW9YZVqNiT5t9z+BzjJk3LtdrYPQ1SSpov7TB3LVKLIZDxgSlrur0dIklFFYPIx1KStCzqbvOEvlz03iZX4+tqZauNTkVhCoDLG+Z4w3OQdmR/uNqXqsbI04+kM3tOcVnXsosSW6E0TAJQARAQABtCZDaHJpc3RvcGhlciBPYmJhcmQgPG9iYmFyZGNAZ21haWwuY29tPokCUQQTAQgAOwIbAwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgAIZARYhBPGL3ItsJfkKoj1RdGNNxPBocEb4BQJe+22mAAoJEGNNxPBocEb4iUIP+wWXh7bqqLWWo1uYYzMZN9WSnhC1qiD8RyK18DvN8UEOINmvuX2beZjVftZYLyp55bT09VZXY0s4hFVr3PbqIYnkDmXGGnG/fHtmHm4QLNozNRJNXlf+gRvA+
 D2Zc41viquXrwrJEqrfz+g2rlO17jETQCJe5HWcvj3R1nps5MvymQ29KzmfYvMBmDYcYOVSSrqkItIFb9wppHHy8f1+sLM4pjb26OS1MUv02lRaptsV0wB3uVCNpZ8dS1aJdEYlLzKujKdVUG64ktwxboBbLSxa98J3oroHPBJbLPD+OjB9YUa3rkBIqf5JyrPPeQVzmU7rPb43o1vwWEGK1fj0N1riOWTb+v+xD00R+WBNSLYEouB+rd4d1+adBQY7DERemqQG9WlY2HHHbgcpK5SRYffwof3GL2Dgqd+K3KS+3uqenQByPGf5sXjuvo/uoI2TPoW5vYhApozM8voUycL7HA9f8MTZ7YCbPDHBfmioYiJN4y0EuO2JJ34jMZhySjft2JQ839yZP/iIwY3o6Y/ep97VDQqH8WrqfnnAKzw6WcJJ+5O088CANfI9xFsC5P8oPyBx2Ne3/zN/Bmv+3bLpcTPYyqfxZb3MIKAZXzxFU6Gn2MpNcQfMdwpJvd3NpMI7OAvhzgtW0aRe1Mj3m0gugbbOLiBw0SGPTgNwM4T7A2dltC9DaHJpc3RvcGhlciBPYmJhcmQgPGNocmlzLm9iYmFyZEBjb2xsYWJvcmEuY29tPokCTgQTAQgAOAIbAwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBPGL3ItsJfkKoj1RdGNNxPBocEb4BQJe+22uAAoJEGNNxPBocEb4JYwP+gMIrabuXS5llUz8yvICgusThLej0VSEWWF6BkiJdsaid1IbkbStYITE/jb834VdhjEHOT0A1SNVB6Yx38l9VNryyJkPZ38fELSUTI9FVLIfO3CP2qgJisoGh2LozSu9d+50hFIF0E9xQZCqcR7kS6j2xp14BiCoD94HCW9Z5r6gA57vFBupGwlcGxA5Z4MfFulpFaDry0R6ICksHe07vY49opWSXhSdhtv+apzaMC7r+5zJKBf1G4kNrKkauUiehgUB9f
 xyA7CXuvB5KtZKILhv8bxyjB66u0REaigEUIBMtD2yE3Z7jXj8H42BV28/l7STNY5CoXaqSpKG82mpLPWiZ3kOd6vKT2q71LnSkk1qcQ3H9QwOTA1yCZk/GwH772nxajA5mfqets+6tAUj5Baj1Zp0MYmoquV2On9W5+0SSc/ei4NsTLj4IO9klPoHFmpd82HwthpkpCVvNKmp6cJdWIOfaIm6q71jPSnWW/YlqNnJ0T3OjwmOrJ1KXagJt1YJfGTlqRgNNrQ3x2gLJH+2upy5ZafgcZ8dZOl/P5MTVSoe5z3a5YPRBz8/hO2luFCLcOlah06ei/N0ZQfNBhzTD+FTn0Q0UB+FUkSb7D+BqBVfOConVQ+MTc51v2RGsIWIhiYo3czhdUPXr4R2Ba8WSvD54VYY1i0CKmfMHG8etCdDaHJpc3RvcGhlciBPYmJhcmQgPGNocmlzQDY0c3R1ZGlvLmNvbT6JAk4EEwEIADgCGwMFCwkIBwMFFQoJCAsFFgIDAQACHgECF4AWIQTxi9yLbCX5CqI9UXRjTcTwaHBG+AUCXvttrgAKCRBjTcTwaHBG+DemD/0RST9WJd1AYk4oq2ZwB9L/X6U9vi9Hcrm/FZDHLJ+kycin0D97hogOXU6YilI+2rV3Wkw6ugu9kxtxY/nFnlCvX80c4UDMca+wZgjFTqbesXSFyjgverZa6APZseiAY4sSWEp8lfKSbb+o5T12urdDPd9k9ok0so4c8O8TOEp2SANEibzb5wl6h3Mv40firL/mwyAFIR0c6UircPG4Skjj5h+dlAf/xA9DlgIGSPFZSD9ZLB+1JeEDMwdwJxHAVkSpAfPEWCcXEb58K0hnbGWasFUe9FugqvhezrxyJ14sVrvoWNKFbTmqamNqZQFuMRsCrNUqZaIvtu7Lz87sMxBfoVESSIDfJngWxBadTuIm5wXjCiAJHbqUclzTbF7GIQ8/JSzFrzOtv/lx+0mGAjXfsU6FTqU
 OJ25iFzQmr2gYRcc28uu1HfnfXHFgaX344gGg8x3BTySIprJ17ie8VCHHAKmAatcNs96KLCHhre/3AYj15GkkllBuKBRUQdxcTlenvuU2XTl7PGCOa2OhPL8SzTfCof0NFl8kzOeHelFjcWu6gPTB0Z2Lc5tSWGUkzmzUfrQxYUpPGDsXDfNRPN7bCAR9BX1nzqh4CHR+cLSADI5ny96y4SUxdv/i19IoMUewPr9LTVhdJqo3rw1FvAxNYtoYytrVEvyv3zVBxqev+bkCDQRe5OXSARAAs9cI1CeIzb2rtAvIRS4hRKwMdt9ZT/1cdzVFo2IEthRsBs5NuV7s1cwXBXji5rcC/9SbEgGx7h93JJ5h1FjFuqKAgDEMZDu6jSUdbbGbIWWLe9rKETSIqmVSAjSxNg7pR0lFMTcOEkEKTJWkwP32au1WBmTiUZBwaurx+VvQypFpL6zAdnPVL0ajVLWmVeiRWDvPUIDpslMmAQX0ZY0OLG+Z8U55h3qOdXupjBdEXscDoFJNsCw3xLKnhc02Sf8pO6b4Gh3aj7UE6xqFH2Rc9B9KBLy6gxdZuqACz0tAsadYfOA9iJxxCsURchiRmdW66zAFfztYRItLZI7O8TCBKCm9OasxQ+KawbdVw1sn24h5kKpZ1+qRep5c1suSkHnnodhRlyVulRXQ7pA4fTaAez2UV/Qa556ov0/viaYhqUuCooQ82nDXyv2eulhVGWUuDtDpmyn3R6XesUwskmtgia4oWijOUpPGIYpjN6DvhhchTYB2UyAlMcCFAb4mtTpsT/qLb9NOTCuBMenaYr6Q52T9MQPagdgOSIv6p3gjsSoxLge1oGkNW9IZ6g+vNoKzQ87AfHsATZW8MJBsd5sabwlAhEDMAul9dNW0rlF7zdI2wr+OPMvruQ0PmPusPJ8H7x6Tbw1hgxapP8ZrEzoRLBqywDtdXQsbGByd2sc2z50AEQEAAYkCNgQYAQgAIAIbDBYhBPGL
 3ItsJfkKoj1RdGNNxPBocEb4BQJe+223AAoJEGNNxPBocEb433UP/1ypX5gavjPU0rewv7SKxG4hOMiIzFjz4VouLgUcA/Q65Eq9PIIKgNBYpf4NKSf43OQO+ie1iuwe2l22lRg0ISba+1YZjLix00JnoUOaSBy7vQ+zFXIJxPGCB/7lzcs2V162nNTrQor+O8kpU/Bihr2C1rH0Eru6BHu0nQwky5+14b3LsD5V9mjY0ASVcV5/lBRFjRMcfgqTLCO9YGoSVwrb1+xn6MdMIDgqL6Om5SmPx2g+quF9WZ1ElmJkDIY97lmihdxsWccynwSeF7KnSPnsah1h8WCchBQezMucSA6rbY51oO/DK1rqSeLAhM5JOG3MRWcI8jm9k+wHwU1Ct/Hxnt0kr5t+Rbnvog3cAbnmS0d8oLMOYAPaqgRkH72hPHclxzL5xfAgZ0K5/EXBCpZShbVWk4FoxYKOaoyok3ThEufkOHTyL3CBjHoXqlXLe3e+8oDQ6mmZKSjdG1yVHUdOw14cYynCxZU3PAKNihjk6ElnWnrrg/RXh7aoZUNGCFRtvSfmN5fftY7WdHM6B40BQ4mcS6G0agaFHQOTexwyAq511pgynCsRn7ZhaQLFJU7eoyquh9N0J4vrqWDq7VVnJAEyw1tOZEqWbvJrIVfsvgKnD3eIkGbZV39lkB4mEp8I5Z5RQja1kWwqpkjLT8iAaLyh53MmQJ9yxJztCSoU
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0-1 
MIME-Version: 1.0
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

Hi Jonas,

Sorry for the late response, I've been meaning to test this for a while but=
 not got around to it.

On Thu, 2023-08-17 at 23:56 +0000, Jonas Karlman wrote:
> Hi Christopher,
>=20
> On 2023-08-08 16:25, Christopher Obbard wrote:
> > Hi Jonas,
> >=20
> > On Sun, 2023-07-23 at 15:04 +0000, Jonas Karlman wrote:
> > > On 2023-07-23 16:55, Jonas Karlman wrote:
> > > > The Pine64 Quartz64 Model A is a single-board computer based on the
> > > > Rockchip RK3566 SoC. The board features USB3, SATA, PCIe, HDMI, USB=
2.0,
> > > > CSI, DSI, eDP, eMMC, SD, and an e-paper parallel port, as well as a
> > > > 20 pin GPIO header.
> > > >=20
> > > > Features tested on a Quartz64-A 8GB v2.0 2021-04-27:
> > > > - SD-card boot
> > > > - eMMC boot
> > > > - PCIe/NVMe/AHCI
> > > > - USB host
> > > >=20
> > > > Device tree is imported from linux v6.4.
> > > >=20
> > > > Co-developed-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
> > > > Signed-off-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
> > > > Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> > > > ---
> > >=20
> > > [...]
> > >=20
> > > Boot log with ROCKCHIP_TPL=3Drk3566_ddr_1056MHz_v1.17.bin and
> > > BL31=3Drk3568_bl31_v1.43.elf:
> > >=20
> > > [...]
> > >=20
> > > U-Boot 2023.07 (Jul 23 2023 - 12:42:18 +0000)
> > >=20
> > > Model: Pine64 RK3566 Quartz64-A Board
> > > DRAM:=C2=A0 8 GiB (effective 7.7 GiB)
> > > PMIC:=C2=A0 RK8170 (on=3D0x10, off=3D0x00)
> > > Core:=C2=A0 321 devices, 27 uclasses, devicetree: separate
> > > MMC:=C2=A0=C2=A0 rockchip_sdhci_probe clk set rate fail!
> > > mmc@fe2b0000: 1, mmc@fe2c0000: 2, mmc@fe310000: 0
> > > Loading Environment from nowhere... OK
> > > In:=C2=A0=C2=A0=C2=A0 serial@fe660000
> > > Out:=C2=A0=C2=A0 serial@fe660000
> > > Err:=C2=A0=C2=A0 serial@fe660000
> > > Model: Pine64 RK3566 Quartz64-A Board
> > > Net:=C2=A0=C2=A0 No ethernet found.
> > >=20
> > > Hit any key to stop autoboot:=C2=A0 0
> > > =3D>
> >=20
> >=20
> > I just tried booting U-Boot v2023.10-rc2 with ROCKCHIP_TPL=3Drk3566_ddr=
_1056MHz_v1.17.bin and BL31=3Drk3568_bl31_v1.43.elf, on my Quartz64-A but i=
t fails during
> > loading of some parts. I removed the output of the RK TPL from my logs =
as there were no errors.
>=20
> Try with latest rk3566_ddr_1056MHz_v1.18.bin and see if that makes any
> difference.

No difference.

I've also checked, there is no other maskrom bootable media such as SPI fla=
sh connected to the board.

>=20
> > This is when booting from eMMC.
>=20
> Does it boot with SD-card or other eMMC modules?

Booting from SD card (without eMMC connected), everything works fine.

>=20

> > I also tried building your branch from https://github.com/Kwiboo/u-boot=
-rockchip/tree/rk3568-2023.10=C2=A0and=20
>=20
> Please try with a GitHub actions built u-boot-rockchip.bin based on my
> rk3568-2023.07.02 branch at
> https://github.com/Kwiboo/u-boot-build/actions/runs/5777761235

With that exact artifact, flashed with:

> rkdeveloptool db rk356x_spl_loader_v1.18.113.bin
> rkdeveloptool ef
> rkdeveloptool wl 64 u-boot-rockchip.bin
> rkdeveloptool rd

it fails to boot with with:

> DDR V1.18 f366f69a7d typ 23/07/17-15:48:58
> ln
> LP4/4x derate en, other dram:1x trefi
> SRX
> ddrconfig:7
> LPDDR4X, 324MHz
> BW=3D32 Col=3D10 Bk=3D8 CS0 Row=3D17 CS1 Row=3D17 CS=3D2 Die BW=3D8 Size=
=3D8192MB
>=20
> change to: 324MHz
> clk skew:0x60
>=20
> change to: 528MHz
> clk skew:0x58
>=20
> change to: 780MHz
> clk skew:0x58
>=20
> change to: 1056MHz(final freq)
> clk skew:0x32
> out
>=20
> U-Boot SPL 2023.07.02-g09919887 (Aug 06 2023 - 16:59:31 +0000)
> Trying to boot from MMC1
> spl: mmc init failed with error: -70
> Trying to boot from MMC2
> Card did not respond to voltage select! : -110
> spl: mmc init failed with error: -95
> Trying to boot from MMC1
> mmc fail to send stop cmd
> mmc_load_image_raw_sector: mmc block read error
> SPL: failed to boot from all boot devices
> ### ERROR ### Please RESET the board ###

I also tried a second eMMC, but it also failed to boot with the same "mmc b=
lock read error" message.


>=20
> What happens if you write u-boot-rockchip.bin to eMMC module usinga USB a=
dapter:
>=20
> =C2=A0 dd if=3Du-boot-rockchip.bin of=3D/dev/<device> bs=3D32k seek=3D1 c=
onv=3Dfsync
>=20
> or using U-Boot cmd when booted from a SD-card?
>=20
> =C2=A0 # Read u-boot-rockchip.bin from first partition of a SD card
> =C2=A0 load mmc 1:1 10000000 u-boot-rockchip.bin
>=20
> =C2=A0 # Change to eMMC
> =C2=A0 mmc dev 0
>=20
> =C2=A0 # Write 10 MiB (0x5000 blocks) at sector 64 (0x40)
> =C2=A0 mmc write $fileaddr 40 5000
>=20
> Does that make any difference?

I don't think I have an eMMC writer for Pine64 eMMCs, I will try to get hol=
d of one this week.
But it fails to write to the eMMC with:

> =3D> load mmc 1:2 10000000 u-boot-rockchip.bin
> 9510400 bytes read in 791 ms (11.5 MiB/s)
>=20
> =3D> mmc dev 0
> switch to partitions #0, OK
> mmc0(part 0) is current device
>=20
>=20
> =3D> mmc write $fileaddr 40 5000
> MMC write: dev # 0, block # 64, count 20480 ... mmc write failed
> 0 blocks written: ERROR
>=20
> =3D> mmc info
> Device: mmc@fe310000
> Manufacturer ID: 45
> OEM: 0
> Name: DF4016=20
> Bus Speed: 52000000
> Mode: MMC DDR52 (52MHz)
> Rd Block Len: 512
> MMC version 5.1
> High Capacity: Yes
> Capacity: 14.7 GiB
> Bus Width: 8-bit DDR
> Erase Group Size: 512 KiB
> HC WP Group Size: 8 MiB
> User Capacity: 14.7 GiB WRREL
> Boot Capacity: 4 MiB ENH
> RPMB Capacity: 4 MiB ENH

I think this points to some issue with the mmc driver in U-Boot, or possibl=
y some issue with my board. But I find that hard to believe because the Roc=
kchip usbloader seems to write to the eMMC just
fine ?

>=20
> >=20
> > Boot log (v2023.10-rc2):
> >=20
> > U-Boot SPL 2023.10-rc2 (Aug 08 2023 - 14:02:34 +0100)
> > rockchip_sdhci_probe clk set rate fail!
> > Trying to boot from MMC1
> > spl: mmc init failed with error: -110
> > Trying to boot from MMC2
> > Card did not respond to voltage select! : -110
> > spl: mmc init failed with error: -95
> > Trying to boot from MMC1
>=20
> Strange that second try of eMMC (MMC1) gets little bit longer.
>=20
> > ## Checking hash(es) for config config-1 ... OK
> > ## Checking hash(es) for Image atf-1 ... sha256+ OK
> > spl_load_simple_fit: can't load image loadables index 0 (ret =3D -5)
> > mmc_load_image_raw_sector: mmc block read error
> > SPL: failed to boot from all boot devices
> > ### ERROR ### Please RESET the board ###
> >=20
> >=20
> > Boot log (your branch):
> >=20
> > U-Boot SPL 2023.10-rc1-00368-g16cb31d427 (Aug 08 2023 - 15:17:35 +0100)
> > Trying to boot from MMC1
> > spl: mmc init failed with error: -70
> > Trying to boot from MMC2
> > Card did not respond to voltage select! : -110
> > spl: mmc init failed with error: -95
> > Trying to boot from MMC1
> > ## Checking hash(es) for config config-1 ... OK
> > mmc_load_image_raw_sector: mmc block read error
> > SPL: failed to boot from all boot devices
> > ### ERROR ### Please RESET the board ###
>=20
> I have not been able to reproduce this kind of issue on any of my two
> Quartz64-A boards, tested with different eMMC modules.
>=20
> Does your eMMC module have some compatibility issue?
> Do you have any more details on the eMMC module you have tested with?

I have two eMMCs, one from FORESEE which came with a Pine64 and one marked =
SanDisk (which I posted the mmc info for above).

My hardware is marked Quartz64-RK3399-V2.0 2021-04-27
Maybe there is some difference with your board?

I will also try an image with vendor u-boot as a next step.

> There was also some clk and pinctrl changes recently merged into master
> branch, but they was probably included in the build from my branch based
> on the lack of "rockchip_sdhci_probe clk set rate fail!" message.

I tried with your build, but I will investigate more with master.


Thanks!

Chris

