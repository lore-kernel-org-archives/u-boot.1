Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B628C3DA7A
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 19:59:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3CF3140816;
	Wed, 14 Oct 2026 19:59:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ugW48uZYxONn; Wed, 14 Oct 2026 19:59:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 51D1040805
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792007995;
	b=aaORQwmr2nKbHKRS1QxuEQXX2BfjVxQpePFKByxV+h76UeL/OUms5gQquMly3LJIauBk
	 bLjNgVE14OUE1u5EIxc03p84y6mhKYdtdsstREEVsgCHVmzhV4/jxHfUFGuW1Pc2Yjur2
	 LRYYNiEtDrWJuyWsGKA5RY9NSz1Oo+h/JyqLfEBvzr+4XODdLrsTdNbUgRszETrA3dzAG
	 QLiEF582zKvunOwOndrSzTTOV/0X0mPPjVHg91tWCWhEsZYc58xz6zFp5R5d2bL1D0JUi
	 OtvDMzOYyl9DXYlacuwiSmBkdGS9cgRzHAL3jL+WenOsNai7vL5oZ7LXjVV2+HZ5zNA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792007995;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:In-Reply-To:
	 References:Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ET1J3iDbI3Dh7rOAU2Ieg/7TAPHWWXxVgUY/5BmJWQ0=;
	b=R1h0hxfP4jnDrypmAcBsuancx5qwCRlq3POEKqaN+OCYtMsuANNf8XS6e6p2AMUlOqdd
	 8wdaE8P9OeNtOnVkea6QtqSWA8key7B6lUKsWIz9L2/7LXd6RIGsuunFXhHuyElb+nMwP
	 carBNAXln5gekW+pKHcO0TEzPd0V/dgsdkooa5pj+42Jmlxhy9HYPvIzh9Cg+EpOHD322
	 pqfy1cxuF0FN4zb7IpMC+gJxhLXs5etAmn3IAu6CsNQznFqGfl4cKyyLrqwf5uqNYpbES
	 haapZUQ/Obtyxn6BvQw74xqfYTQj0eOzsOxj3npPm2Dc7fbBFnrURy4o6Ij313Lb71w==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792007995;
	bh=ET1J3iDbI3Dh7rOAU2Ieg/7TAPHWWXxVgUY/5BmJWQ0=;
	h=Date:To:From:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bafEjj9Whps2bB0PJ2u1vsfpvzU21664rIfRtSpFrybp6V32uiEbjGKLF74X7os7d
	 eMy5/LGyg4sHkfGVlMY7LDpqgMHyzZrKyfDyudHlqcQHZaiklTdecfC9e2uCZnrFaF
	 iYwEtG6r/UHFM0Fp0iB76i9AEwyA5BydePOuK+Fcb29xphiUL8+aaxkHJgf3Cy/pA1
	 SXHYIIlv7muz3+rymbb5gmlwd3WJ4UUgYC1XYzGVc7Urug75/FSzxFR9vWxj87Mh9S
	 amUGMEnlPMS45Ch7dPb/lvde/DD/lBkw59UfW2hb5AIG0+/2N3zj/TpF4mqqMukoyb
	 C6bTwzwOUsMmg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 51D1040805;
	Wed, 14 Oct 2026 19:59:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2A0574DD
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 19:59:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 281794019A
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 19:59:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RPcFag8QPO6o for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 19:59:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 728574009D
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=79.135.106.28
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792007992;
 b=NNBYC7FyPkyAVpItuYRAZgk4YQnvdp4+4PzzAz8pUXDfi1J6XtYtPUoooqW7c7iJrCVA
 2sNKCp/z6azhsRaKXFJx+0IFjqRFN0Vpb3tUdYk8BQ8GMwxiFYl79Mqd56CTjiEiZCj2S
 Ye3m1GAfHL43zQVmz7VpkTlg5OHyuqHTBubzSQ5lKl0jms0JIF+2ljxGgCeZ4VzaGu4/f
 7sqX8S1J+FiCRh+voBIsAyesF7/Mq7MWSXfAHKq5iQZ/bPGn9yYR7QQR5xd+/32An59CZ
 DTm20HYuN/D5HpmW/QTnDTuJuRrGHgjitUPIvY803ZhsXWPMaouUd8wkXr+zQf4CD2w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792007992;
 h=Received-SPF:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
 Content-Type:Content-Transfer-Encoding;
 bh=ET1J3iDbI3Dh7rOAU2Ieg/7TAPHWWXxVgUY/5BmJWQ0=;
 b=Lhc8mvXKACULCjA44ILueNu89hMu03Y9gjolgqdkGlifQAuqwgWwzxExd5k+V5N5kAmP
 pUq8Bpel1YBlnexZcglk9m1j4M2vD5ZEwSJFX/1K2TAbdc0D6cWFPbIl9tiY8XCwPQTQC
 8nQQ2KralSDQfVdE8Nj2EUGMqXwxso9n2VkAlAt1qp9Ck6YWCJX4GYzEpC1Ym9QWnjlZ3
 5AZKr0d6sbnU+NHdMIYTK5Ya3Ifef6y2QGOHsdXW3DYi1DgudJsBzThTPbUqDywDDGYj4
 1lD5dAxjI5uEr7Lvxs0Pfq/FCUzSbXCSu1hDLE7GK0xbDBXDmr27+NuxggNFk8HLBwQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=protonmail.com;
 dkim=pass header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256
 header.s=protonmail3 header.b=g2kbsoVz; 
 arc=none smtp.remote-ip=79.135.106.28
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=79.135.106.28;
 helo=mail-10628.protonmail.ch; envelope-from=davewk225@protonmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=protonmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=protonmail.com header.i=@protonmail.com
 header.a=rsa-sha256 header.s=protonmail3 header.b=g2kbsoVz
Received: from mail-10628.protonmail.ch (mail-10628.protonmail.ch
 [79.135.106.28])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 728574009D
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 19:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1792007989; x=1792267189;
 bh=ET1J3iDbI3Dh7rOAU2Ieg/7TAPHWWXxVgUY/5BmJWQ0=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=g2kbsoVzaiU4RgSs5b7SAWSpfx6tkwwvgsXI7qaxFBFFKVOCRGqF/krAU5wpAOb8P
 0pG45D1UqZK2cY668qJV2ylceFgEi3H8vqRjxPyTRYf8EfGomoWdbwjWvkW7CWe4gs
 D84ykoLJ+YoN7F5013OQImsJuM+sLAwelbTFmEWhvGTMzt0iGykKnBAceH9nhI1RZX
 EVPBIar+5M3ejDQS5CO3KjUtlfetjbbDRw2rQFshUdRvAlyoJup3QVe3bWNISHeNzU
 c4Wl5CJkG0riolXe18K0MqSFHX5zaWonfrlTzyo7Si6uoufHYugkjSUsZ00QuNU5de
 yGsKE8q0DC8DQ==
Date: Wed, 14 Oct 2026 19:59:44 +0000
To: Yixun Lan <dlan@kernel.org>
From: Dave Klotz <DaveWK225@protonmail.com>
Cc: Marek Vasut <marek.vasut+usb@mailbox.org>, u-boot@lists.u-boot-project.org,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 u-boot-spacemit@groups.io
Subject: Re: [PATCH v2 2/2] usb: dwc3: generic: add SpacemiT K1 support
Message-ID: <20261014T154006-0400.uboot-k1-usb-v2-0002-vbus-reply.DaveWK225@protonmail.com>
In-Reply-To: <20261012122725-GKI26088@kernel.org>
References: <20261006T002406-0400.uboot-k1-usb-cover.DaveWK225@protonmail.com>
 <20261006T020608-0400.uboot-k1-usb-v2-cover.DaveWK225@protonmail.com>
 <20261006T020608-0400.uboot-k1-usb-v2-0002.DaveWK225@protonmail.com>
 <20261012122725-GKI26088@kernel.org>
Feedback-ID: 100562830:user:proton
X-Pm-Message-ID: 5d5dbcd170a2e60b1187a9616d7a221999b478de
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Hi Yixun,

On Mon, Oct 12, 2026 at 12:27 UTC, Yixun Lan wrote:
> https://github.com/torvalds/linux/commit/764c2e6e60bf17910d84e7179fee1412=
9e053b96
> "usb: dwc3: Add optional VBUS regulator support to SpacemiT K1"
>
> Can you check above (for board OrangePi R2S), see if need to implement
> similar support in U-Boot? I'd accept this patch if the regulator is
> enabled by default, can leave us to improve later..

On the R2S the USB 3 port's VBUS is switched. The DT describes it as
vcc5v0_usb, a fixed regulator enabled by GPIO 126 (active high), with
no regulator-always-on or regulator-boot-on, and &usb_dwc3 has
vbus-supply =3D <&vcc5v0_usb>. U-Boot's dts/upstream copy of
k1-orangepi-r2s.dts has the same. So as far as the DT is concerned it
is not on by default. I don't have a schematic, so I can't say what
the pin does out of reset.

U-Boot doesn't need an equivalent of 764c2e6e, though.
dwc3_generic_host_probe() already gets "vbus-supply" and calls
regulator_set_enable_if_allowed() before xhci_register(), and
dwc3_generic_host_remove() turns it off again. With rk_ops the host
child is bound to the usb@c0a00000 node itself, so it finds the
property. A board without vbus-supply is unaffected, as with Linux's
optional regulator. The board needs CONFIG_DM_REGULATOR_FIXED,
which v3 enables in spacemit_k1_defconfig along with the USB host
options; DM_REGULATOR and SPACEMIT_GPIO are already there.

My v2 tests on the R2S ran that way: the firmware had
CONFIG_DM_REGULATOR_FIXED=3Dy and the upstream R2S DT, and USB storage
enumerated and read at 5 Gb/s. I didn't log the regulator enable
itself. Under FreeBSD on the same board, the port only saw a device
once GPIO 126 was driven high, so I'd expect U-Boot to depend on it
as well.

So 2/2 doesn't need a change for VBUS. v3 will carry Marek's tag, your
1/2 comments, and a new patch enabling USB host in spacemit_k1_defconfig.

Thanks,
Dave

