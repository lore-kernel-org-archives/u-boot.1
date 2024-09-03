Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A38C7CD3420
	for <u-boot@archiver.kernel.org>; Tue,  3 Sep 2024 11:00:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0F18888AA;
	Tue,  3 Sep 2024 13:00:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=smoch@web.de header.b="wtG5ze5U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3516988B68; Tue,  3 Sep 2024 13:00:24 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D3E48876E
 for <u-boot@lists.denx.de>; Tue,  3 Sep 2024 13:00:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=smoch@web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1725361209; x=1725966009; i=smoch@web.de;
 bh=Uf26nITwig3xBflU+pr3r4YjwHqrONNAU5Ym+H2+HKw=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=wtG5ze5U1GtjYmVP8lafxYsfv8guX/SJfCmAA0WOOWGfT1lud29JVjRaMJ6YxbWF
 EszoOLHtWKBOy8SDTyjm4ioR20HH+EYhqjKI3zwTNymUeY1RLVMPW9OjRbTH1LbJT
 HaKgDTOP4S2O152op1JoQ2fxLLhPIHmHttkslHk6JNqSkJaDIeZOBTc4+5UZZNt4i
 skQC49GJexsHGsTNTQk07gHpcReNYUr9jYvKNGERSuUl5TxOkTL/YlO5Q7cmD9O76
 focUp04RiWIq8AOYRjB9uUaJ4m1T98YxdZB5L3YATWdBC7OsG7sMOJ46I3amK+SXv
 OGX/1gGIrqDmrTMYUw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.1.40] ([77.191.123.194]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N4N98-1s1Y8l30b8-01488Z; Tue, 03
 Sep 2024 13:00:09 +0200
Message-ID: <8489a7f6-32ab-4908-818e-ee1119aa0bad@web.de>
Date: Tue, 3 Sep 2024 13:00:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/6] FUSB302 USB-C controller support
From: Soeren Moch <smoch@web.de>
To: Sebastian Reichel <sebastian.reichel@collabora.com>,
 Marek Vasut <marex@denx.de>, u-boot@lists.denx.de,
 Jonas Karlman <jonas@kwiboo.se>
Cc: Eugen Hristev <eugen.hristev@collabora.com>,
 Tim Harvey <tharvey@gateworks.com>, Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>
References: <20240830182330.49528-1-sebastian.reichel@collabora.com>
 <420b6d01-d081-4a6a-a9b7-219d8806099a@web.de>
Content-Language: en-US
In-Reply-To: <420b6d01-d081-4a6a-a9b7-219d8806099a@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:M7zBfNqIuOEV5yN84jiDR9uU7OpsCNs1y4u7y+DV2FpfqY6oIRK
 lmnnQcyWK0KNBYid9i17lYD1vekgm48qCQrT0Zsum+by7PDcUtJMV9rgLkgUvOnC/N+7nV6
 EGKCczabIlb+mooZTLThmY3fg0Ta6Hg3Q9yp6zLOiLxibEH9+Qd9gg4yUsLRGx11cY8d15l
 5KtqnTK+4Jj6/wZDfBrRQ==
UI-OutboundReport: notjunk:1;M01:P0:AVkbM06lsWU=;pP2MlSzQktcTncMXI8icbRrTqJe
 XkQ7nTnWjHdR+eTToqpAj42ev+Jbs1zoSl3UbJQJkX3mv3DXcaDNlD33Gu6swwxLMfgA3Xdvw
 6rcG2qDbipI6pS6cqA4V+qBIvj6aCftKEtfAN/XVz6NheDBlSTsPlY/B5dJiB01B/2c2rhzgj
 C2OKKFFkMyS2pgdfL2VE9e7UlI199Kf2BSic0OFNy1o4AeUcKvnj9K5jxmuQuArcFb6LRf5ZG
 QEad91GNnUuu1cYbPQW3mqwiLv1PzK+QKZF2Z5EYogtg7gpv4DiqN+XnNdUbiWX1Ty8gupsF/
 VTg0n9uY8nnhNFtQHbc+lS+CbvNDZ7gzIkyKMGSsyVq2ZLxLhoMk/C+6e90H5mjuzriF1tF6Y
 zN2inCwqRERO7nUN2O5Uc/2ntTAML6fMESMjxAOy346p/sdE/s16mKXVv6KsDMq+BaemGbsEW
 ADBNLCahAbREqJgUXx5WnhRc42+9ZoZi8ojs9irLUzbPx8pSjax52gPuUs6Bh7ajWGHTbYIX/
 X2uWfbK2gNN8y3Oaf0eV88JGp5TEo661fbLWCccdavKhfWOSzafobPg/RJTv9bXluqVzABONE
 PnBLu8wHnWaUBkYoxTPyWu3BvkQzWAtcrLcH9+gX7ByI62UFPF7l+JVtBs/Doi0qBelikoKu1
 NlB7878VvAzvcHthECEcIv2gkUsrICqIB4c7iTHcuLkQwV8FYTDREUXdTMYavHOKm/1EIrkqD
 mrkd7nQI/X/ecmapqTVCvpxfnspfWnZ634ibVaEApxFU0IISd9EelBR4Ga40dBWhLUiPViA8o
 ndbO2EbXTrUlBP0jBDUXMc4g==
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

Hi Sebastian,

On 31.08.24 15:36, Soeren Moch wrote:
[...]
> Unfortunately I see the same problem as in v3: boot loop when powering
> the board from my notebook (ThinkPad X1 Nano running Ubuntu 24.04.1 LTS)=
,
> see boot log below.
>
> Patch version v2 is still running totally fine in the exact same setup
> (patch series on top of u-boot 2024.07, same board, same cabling).
>
> Unfortunately I currently have no access to the miniPC (Zotac ZBOX CI620=
)
> I used as additional test platform before.
>
> The boot log is unfortunately not very helpful. If you provide an
> additional
> patch enabling more debug output, I'm happy to retest with that (v2
> and/or v4).

Here additional debug messages for the not working case (LOG_DEBUG enabled=
):

U-Boot 2024.07-00006-g65a73892d9-dirty (Sep 03 2024 - 12:22:42 +0200)

Model: Radxa ROCK 5 Model B
DRAM:=C2=A0 8 GiB
fusb302 usb-typec@22: set pd RX off
fusb302 usb-typec@22: vconn is already off
fusb302 usb-typec@22: TCPM: set polarity =3D 0
fusb302 usb-typec@22: pd header : sink, device
fusb302 usb-typec@22: TCPM: state change INVALID_STATE -> SNK_UNATTACHED
fusb302 usb-typec@22: TCPM: Start toggling
fusb302 usb-typec@22: TCPM: state change SNK_UNATTACHED -> TOGGLING
fusb302 usb-typec@22: get cc1 =3D open, cc2 =3D open
fusb302 usb-typec@22: TCPM: CC1: 0 -> 0, CC2: 0 -> 0 [state TOGGLING,
polarity 0, disconnected]
fusb302 usb-typec@22: IRQ: 0x80, a: 0x00, b: 0x00, status0: 0x83
fusb302 usb-typec@22: IRQ: VBUS_OK, vbus=3DOn
fusb302 usb-typec@22: IRQ: 0x01, a: 0x40, b: 0x00, status0: 0x82
fusb302 usb-typec@22: IRQ: TOGDONE
fusb302 usb-typec@22: get cc1 =3D rp-1.5, cc2 =3D open
fusb302 usb-typec@22: TCPM: CC1: 0 -> 4, CC2: 0 -> 0 [state TOGGLING,
polarity 0, connected]
fusb302 usb-typec@22: TCPM: state change TOGGLING -> SNK_ATTACH_WAIT
fusb302 usb-typec@22: TCPM: pending state change SNK_ATTACH_WAIT ->
SNK_DEBOUNCED @ 200 ms [rev1]
fusb302 usb-typec@22: detected cc1=3Drp-1.5, cc2=3Dopen
fusb302 usb-typec@22: IRQ: 0x51, a: 0x00, b: 0x00, status0: 0x92
fusb302 usb-typec@22: IRQ: BC_LVL, handler pending
fusb302 usb-typec@22: BC_LVL handler, status0 =3D 0x92
fusb302 usb-typec@22: IRQ: 0x51, a: 0x00, b: 0x00, status0: 0x92
fusb302 usb-typec@22: IRQ: BC_LVL, handler pending
fusb302 usb-typec@22: BC_LVL handler, status0 =3D 0x92
fusb302 usb-typec@22: IRQ: 0x51, a: 0x00, b: 0x00, status0: 0xc2
fusb302 usb-typec@22: IRQ: BC_LVL, handler pending
fusb302 usb-typec@22: BC_LVL handler, status0 =3D 0xd1
fusb302 usb-typec@22: cc1: rp-1.5 -> rp-def
fusb302 usb-typec@22: get cc1 =3D rp-def, cc2 =3D open
fusb302 usb-typec@22: TCPM: CC1: 4 -> 3, CC2: 0 -> 0 [state
SNK_ATTACH_WAIT, polarity 0, connected]
fusb302 usb-typec@22: IRQ: 0x51, a: 0x00, b: 0x00, status0: 0x92
fusb302 usb-typec@22: IRQ: BC_LVL, handler pending
fusb302 usb-typec@22: BC_LVL handler, status0 =3D 0x92
fusb302 usb-typec@22: cc1: rp-def -> rp-1.5
fusb302 usb-typec@22: get cc1 =3D rp-1.5, cc2 =3D open
fusb302 usb-typec@22: TCPM: CC1: 3 -> 4, CC2: 0 -> 0 [state
SNK_ATTACH_WAIT, polarity 0, connected]
fusb302 usb-typec@22: TCPM: state change SNK_ATTACH_WAIT ->
SNK_DEBOUNCED [delayed 200 ms]
fusb302 usb-typec@22: TCPM: state change SNK_DEBOUNCED -> SNK_ATTACHED
fusb302 usb-typec@22: TCPM: set polarity =3D 0
fusb302 usb-typec@22: pd header : sink, device
fusb302 usb-typec@22: TCPM: state change SNK_ATTACHED -> SNK_STARTUP
fusb302 usb-typec@22: TCPM: state change SNK_STARTUP -> SNK_DISCOVERY
fusb302 usb-typec@22: TCPM: set vbus =3D 0 charge =3D 1
fusb302 usb-typec@22: TCPM: state change SNK_DISCOVERY ->
SNK_WAIT_CAPABILITIES
fusb302 usb-typec@22: set pd RX on
fusb302 usb-typec@22: TCPM: pending state change SNK_WAIT_CAPABILITIES
-> SOFT_RESET_SEND @ 310 ms [rev3]
fusb302 usb-typec@22: IRQ: 0x51, a: 0x00, b: 0x01, status0: 0x92
fusb302 usb-typec@22: IRQ: BC_LVL, handler pending
fusb302 usb-typec@22: BC_LVL handler, status0 =3D 0x92
fusb302 usb-typec@22: IRQ: PD sent good CRC
fusb302 usb-typec@22: Received PD message (header=3D0x17a1 len=3D4)
fusb302 usb-typec@22: TCPM: PD RX, header: 0x17a1 [1]
fusb302 usb-typec@22: TCPM: state change SNK_WAIT_CAPABILITIES ->
SNK_NEGOTIATE_CAPABILITIES
fusb302 usb-typec@22: TCPM: cc=3D0 cc1=3D4 cc2=3D0 vbus=3D0 vconn=3Dsink p=
olarity=3D0
fusb302 usb-typec@22: TCPM: PD TX, header: 0x1082
fusb302 usb-typec@22: Send PD message (header=3D0x1082 len=3D4)
fusb302 usb-typec@22: IRQ: 0x41, a: 0x04, b: 0x00, status0: 0x92
fusb302 usb-typec@22: IRQ: BC_LVL, handler pending
fusb302 usb-typec@22: BC_LVL handler, status0 =3D 0x92
fusb302 usb-typec@22: IRQ: PD tx success
fusb302 usb-typec@22: Received PD message (header=3D0x161 len=3D0)
fusb302 usb-typec@22: TCPM: PD TX complete, status: 0
fusb302 usb-typec@22: IRQ: 0x51, a: 0x00, b: 0x01, status0: 0x92
fusb302 usb-typec@22: IRQ: BC_LVL, handler pending
fusb302 usb-typec@22: BC_LVL handler, status0 =3D 0x92
fusb302 usb-typec@22: IRQ: PD sent good CRC
fusb302 usb-typec@22: Received PD message (header=3D0x9a3 len=3D0)
fusb302 usb-typec@22: TCPM: PD RX, header: 0x9a3 [1]
fusb302 usb-typec@22: TCPM: state change SNK_NEGOTIATE_CAPABILITIES ->
SNK_TRANSITION_SINK
fusb302 usb-typec@22: IRQ: 0x51, a: 0x00, b: 0x01, status0: 0x93
fusb302 usb-typec@22: IRQ: BC_LVL, handler pending
fusb302 usb-typec@22: BC_LVL handler, status0 =3D 0x92
fusb302 usb-typec@22: IRQ: PD sent good CRC
fusb302 usb-typec@22: Received PD message (header=3D0xba6 len=3D0)
fusb302 usb-typec@22: TCPM: PD RX, header: 0xba6 [1]
fusb302 usb-typec@22: TCPM: state change SNK_TRANSITION_SINK -> SNK_READY
fusb302 usb-typec@22: IRQ: 0x01, a: 0x00, b: 0x00, status0: 0x92
fusb302 usb-typec@22: IRQ: BC_LVL, handler pending
fusb302 usb-typec@22: BC_LVL handler, status0 =3D 0x92
fusb302 usb-typec@22: IRQ: 0x51, a: 0x00, b: 0x01, status0: 0x92
fusb302 usb-typec@22: IRQ: BC_LVL, handler pending
fusb302 usb-typec@22: BC_LVL handler, status0 =3D 0x92
fusb302 usb-typec@22: IRQ: PD sent good CRC
fusb302 usb-typec@22: Received PD message (header=3D0x1daf len=3D4)
fusb302 usb-typec@22: TCPM: PD RX, header: 0x1daf [1]
fusb302 usb-typec@22: IRQ: 0x01, a: 0x00, b: 0x00, status0: 0x92
fusb302 usb-typec@22: IRQ: BC_LVL, handler pending
fusb302 usb-typec@22: BC_LVL handler, status0 =3D 0x92
fusb302 usb-typec@22: IRQ: 0x41, a: 0x00, b: 0x01, status0: 0x92
fusb302 usb-typec@22: IRQ: BC_LVL, handler pending
fusb302 usb-typec@22: BC_LVL handler, status0 =3D 0x92
fusb302 usb-typec@22: IRQ: PD sent good CRC
fusb302 usb-typec@22: Received PD message (header=3D0x1faf len=3D4)
fusb302 usb-typec@22: TCPM: PD RX, header: 0x1faf [1]
fusb302 usb-typec@22: IRQ: 0x51, a: 0x00, b: 0x00, status0: 0x92
fusb302 usb-typec@22: IRQ: BC_LVL, handler pending
fusb302 usb-typec@22: BC_LVL handler, status0 =3D 0x92
fusb302 usb-typec@22: IRQ: 0x01, a: 0x00, b: 0x00, status0: 0x93
fusb302 usb-typec@22: IRQ: BC_LVL, handler pending
fusb302 usb-typec@22: BC_LVL handler, status0 =3D 0x93
fusb302 usb-typec@22: cc1: rp-1.5 -> rp-3.0
fusb302 usb-typec@22: get cc1 =3D rp-3.0, cc2 =3D open
fusb302 usb-typec@22: TCPM: CC1: 4 -> 5, CC2: 0 -> 0 [state SNK_READY,
polarity 0, connected]
fusb302 usb-typec@22: IRQ: 0x01, a: 0x00, b: 0x00, status0: 0x92
fusb302 usb-typec@22: IRQ: BC_LVL, handler pending
fusb302 usb-typec@22: BC_LVL handler, status0 =3D 0x92
fusb302 usb-typec@22: cc1: rp-3.0 -> rp-1.5
fusb302 usb-typec@22: get cc1 =3D rp-1.5, cc2 =3D open
fusb302 usb-typec@22: TCPM: CC1: 5 -> 4, CC2: 0 -> 0 [state SNK_READY,
polarity 0, connected]
fusb302 usb-typec@22: IRQ: 0x51, a: 0x00, b: 0x01, status0: 0x92
fusb302 usb-typec@22: IRQ: BC_LVL, handler pending
fusb302 usb-typec@22: BC_LVL handler, status0 =3D 0x92
fusb302 usb-typec@22: IRQ: PD sent good CRC
fusb302 usb-typec@22: Received PD message (header=3D0x11af len=3D4)
fusb302 usb-typec@22: TCPM: PD RX, header: 0x11af [1]
fusb302 usb-typec@22: IRQ: 0x01, a: 0x00, b: 0x00, status0: 0x93
fusb302 usb-typec@22: IRQ: BC_LVL, handler pending
fusb302 usb-typec@22: BC_LVL handler, status0 =3D 0x93
fusb302 usb-typec@22: cc1: rp-1.5 -> rp-3.0
fusb302 usb-typec@22: get cc1 =3D rp-3.0, cc2 =3D open
fusb302 usb-typec@22: TCPM: CC1: 4 -> 5, CC2: 0 -> 0 [state SNK_READY,
polarity 0, connected]
fusb302 usb-typec@22: TCPM: PD transmit data failed: -110
fusb302 usb-typec@22: TCPM: state change SNK_READY -> SNK_WAIT_CAPABILITIE=
S
fusb302 usb-typec@22: set pd RX on
fusb302 usb-typec@22: TCPM: pending state change SNK_WAIT_CAPABILITIES
-> HARD_RESET_SEND @ 310 ms [rev3]
fusb302 usb-typec@22: TCPM: state change SNK_WAIT_CAPABILITIES ->
HARD_RESET_SEND [delayed 310 ms]
fusb302 usb-typec@22: TCPM: PD TX, type: 0x5
fusb302 usb-typec@22: IRQ: 0x41, a: 0x08, b: 0x00, status0: 0x93
fusb302 usb-typec@22: IRQ: BC_LVL, handler pending
fusb302 usb-typec@22: BC_LVL handler, status0 =3D 0x93
fusb302 usb-typec@22: IRQ: PD hardreset sent
fusb302 usb-typec@22: TCPM: PD TX complete, status: 0
fusb302 usb-typec@22: IRQ: 0x01, a: 0x00, b: 0x00, status0: 0x83
fusb302 usb-typec@22: IRQ: BC_LVL, handler pending
fusb302 usb-typec@22: BC_LVL handler, status0 =3D 0x83
<Reset>

HTH,
Soeren
