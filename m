Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE87BCA5FA1
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 17:05:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 783B1606EC;
	Mon, 28 Sep 2026 17:05:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LvCOhjv-8mVg; Mon, 28 Sep 2026 17:05:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 4B356606F8
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790615110;
	b=oT0Maw2w8Oec4s0sTwC6ktsv5hZv8iQDee/r9ggC9e1eWQHGIXDP6nr5zsX8Cp7gSIoq
	 KDaztTqWETwqfGtrCf2RbKgJ3VseUTEAC19hFXPrBAzlrp12ERaVlGNJ/oKR0lQCbspHK
	 IFWQEN1pqBolea9IPTnFC/cLcRkcx2C6I3saV+KVDfMF4hx7aRzPaGOL0ozowLTWRObxk
	 kKb6d2jcfReERfn6B8FsHkNbHccP4E8Sg+cokWIrmfcYZzQkZ98manlohyi0S+Noai8Oq
	 hfXGC8YLvb14eRtCyn+yopBOfL/6vU/7lthNLdm51pXBXBcWAStJjjia05xiOJknoqw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790615110;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=2pQfGNLElZruUlbAUWld9/fAn1Ovq3vaUe1eHpg0rNA=;
	b=c4AxI2OXg+yM7upkpPKU+22Rth2ABVSHk3r9SUnEai+Rsp68wJ89iC0Og5iftadzkH6V
	 S3VaGY8M2NgZGeB1jNIPxVEw2CANjOCE+2qL3KUUdVSvR19lQVBPmpzaLVGQlH+/LKN0m
	 Kk9SiPpcIDhvElAa+VqyTofFhN0p/n4Fz+s7WGXGHiRw51QHlXBSvkj6X1rOyjqYBTq9h
	 vI6MCV6VzkdcFNArcnnU7ISJomQGPeh5VUV7SkSlDrJQX8dHIDq91BIEpSJafC78F41DQ
	 +esS2mq4gxkfGgW8sTxgt6NBqXfs3ApH1pTiZS076Kb2ylPnkoD5CJeixNxMmr7kdgw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; dmarc=pass header.from=flipper.net;
	dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=IdxLR2io;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790615110;
	bh=2pQfGNLElZruUlbAUWld9/fAn1Ovq3vaUe1eHpg0rNA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=S9c0ZvA/S9zOzhVaM5fhfy6TMtNWU4GsxIMyJE959bC5P0hJMSbEZFk8D9n3Yz8VD
	 oiIxwLEB+tt0zCtJ4w+R5MooydSC2SHz3ueqQ3fDBKtjxWavz8SKxk7rXjkEzMdAEz
	 IWveZXi5HUCqKTWsgL+uURyXuRTcRiz1rfkkHdWev3ihy1JgLOglgfLGJM4D7PG0Y/
	 nRt4P419hX1eF/cQptV+O80gtF1WM0y/GNZdy9X1ZCbTYr8MC3ihTvnQlrYh/dwBEZ
	 VTPEZT/XefeeW1pcgIucWM+qAChuGxg0ZWhtpIqw1fvs96IHuNhBZFpvQ+phjVzEL9
	 hAzD/B8Uhwx6w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4B356606F8;
	Mon, 28 Sep 2026 17:05:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 683793A0
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 16:44:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 58EF960615
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 16:44:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9pj5-ooYomrE for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 16:44:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org F1855605FC
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:34::f"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790613890;
 b=bQS67WVhHrmEiKkN2D8ITdlE1P5gDmYVcUD/okKqz23Bvi9eo1E0R1DE6Jz9S7JsuHvV
 fWwLdXvx6VD16Opi6tip1BlrngkHKwENhZKL6dCE57LiadFpYOv9Vk4EOPaF2YoS0AUoi
 oDEIHFzHLXQcnUcF0rzpQ7HDzNC7nkEQH0mJhwxf2hakrq2znBDMgc/3ZwdVpoVb90+ar
 7VVFiD21GyLPz2ZPPQAmPIF63jMCVb10KgmviqEXqkBSbU6LNTqe674peFi6H3Odilzgi
 Pl4KiL5tzXrQynQP8nS5Q/0op7aCmvE4kjWozhkF+Ol4h89WCWgcxVvijTFDiYLjxYA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790613890;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=2pQfGNLElZruUlbAUWld9/fAn1Ovq3vaUe1eHpg0rNA=;
 b=MwsOeIqm+ddVdKTRZ/PUTDKVLP1HfQidyQmRVkpuD5tEQB20241vVQ7S4l05uWuncLvJ
 zHn6SwukW8tZkuv9t7ygmA2KQ0iwmJb+1uC3+gWsRMZcFuNz6vPXecF94MT6btKHFTr9f
 H8FKA4bAfiedBaw7RLjAydm1V3sYPJdk2fzzPKIDl+RAaXwTP4gzEirfXIDysftS8D7XM
 oXUYR9wBEkLxOIoKLkGtj9eF0qkKXewIdi6Bk/CZM24emaYuCHCqEZD8hnm2MHFDcnWSW
 jcZQFi8E1H7S8l00eAjUNntKM+hjYBzzodkPj822dkOXPN4mMPRZf7/lWWWQZchZm7w==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=flipper.net; 
 dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=IdxLR2io; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:34::f"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:34::f;
 helo=mail-ej2-x0f.google.com; envelope-from=alchark@flipper.net;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=IdxLR2io
Received: from mail-ej2-x0f.google.com (mail-ej2-x0f.google.com
 [IPv6:2a00:1450:4864:34::f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F1855605FC
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 16:44:49 +0000 (UTC)
Received: by mail-ej2-x0f.google.com with SMTP id
 a640c23a62f3a-c2a9edfc851so407243266b.0
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 09:44:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790613887; cv=none;
 d=google.com; s=arc-20260327;
 b=TowxF72cz6wBvemQ98i2OWNMUCGyQ+mh1VXUxNaNjpCmnJv7WHnr5hhpAJXlWdJP1L
 udCbNOq7X+s/khAPqXs2M1Q0MMix+sfEjDrH8wceV2P90VI8g9sSapfUGwIopIr6srzO
 JNLUYh9hed2Aym2ZxH9f1g9PQkurcV3wp53fBdkMm7EBjJXw2iH89Ori+5SlysbGGxn1
 O9pUTdQ7wGaFSrMPK+v8n0kszn1M6mfkOG48OUnzM/RS/62q9TICqK8g4QVJmznynSbk
 QH3+5NofW20M7MXiWnFYC4N08zAdrJuexTo5NTgWzNzlTg68/RbY9j113w+aeqsvgIBG
 bxiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=2pQfGNLElZruUlbAUWld9/fAn1Ovq3vaUe1eHpg0rNA=;
 fh=X0PN9lBUC28xruMLlb/E9GWPFyBweSpvg8ZgHdQS2Mc=;
 b=ARk0L0htqH3VR5lCDrqYY+yQFhhlWe1P0f/LYHXt65wo6w1ewhw82w4S0xzEQpybeP
 ncse35rwLQBapUO08LpuALOVVAGlQwu3g6LPnz4bJdZLIeWMKxPXvzAHQCTyjQlFOh9l
 YMdqcxX9pbEcOERY1zVZ8QYtft333hkUKOoMxJpr2SUiQAts4ZfFK1HNOc6zbmmjY/N7
 RqSdV2vVWUenhLDNAkcUytzXkYXHzCpL4nwaanf9qYXZF91tyvO8UX+iPm+Kv/Ad4RDX
 ZtUUfJiEvhzNUVfHfz/rX6oYynTH65XiTgFgVOYKw74h+3M5OnQ1vjV7cWS+jY82Hl9W
 IEgw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1790613887; x=1791218687;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2pQfGNLElZruUlbAUWld9/fAn1Ovq3vaUe1eHpg0rNA=;
 b=IdxLR2io2ujKxzpsyQ2d9A0IhtKL6hCaXw6T9sJJOm8A9GL9EVKOzmIhFvq3XK2OQf
 LbwsqN2ydl/Q3JxEEPqzisgql7YBoLyIT82ZsVPK4LezX7vqWGaB8g4BEl1qOlytHTxK
 VUDB5NvDRVUp3JzWhEviwJBXkHaf9RZLZCDEzUlmdnq89CaVGG0bBjEWgu+OJULyhy0e
 tj3mxagrDOY89XnLVGIrlcKQtDiin9bIoT+iHbZwj2z+0IexWmX1ihUJ3fG0eoqflAJ/
 ff5Fe14sbmbMNnd+3R2n6+4+gkWjTv3KgjOu3sMgc9YhvDdDw5dkLm9nk6GN7CVK0GZH
 vC+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790613887; x=1791218687;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2pQfGNLElZruUlbAUWld9/fAn1Ovq3vaUe1eHpg0rNA=;
 b=Vmo3OGhOwq+A5VArCVlTuakuGSWLdYu0z7qwngbrZs3TVfOCc+AlPEkewmKeYNh1F0
 4aVemRDmkO7nV6m+ejEfKBDiLH0CLqgnJAbAQWv868sTUwYQQGfS+n3Mg2bbbE39ZeWe
 tzGR7FMeRaoBRLR0rJEHMnneCdrXq0/KF7M6sbB4Ne1ZkNShzP0ELs3iu68fuD9ivV7v
 MyWFDhoBT5HUnUfi406MewSQgm8brk27F5TRveURCLWb9jca5dp2JP35/Pl8jHQBJR8p
 WtXTOeLFJTmYcnBIXUOCienpisNW6vGdetZiTSlYAmlHME/EqetllwFoDDAxHS7DLo2Y
 qB7g==
X-Gm-Message-State: AFuF++mPM8onjCU5XQAFbS0i9RkiJptJghYFFIlDNRhpXxU9Z+mKYd09
 qsymVgs39yAOKvjZ6YSrylu6sugmtxgjaLeWzNTTe2FWzzEBQBxY1dfqMFVmzut0+KOnt6+HQ5/
 l3yZfLCpCJj0Tdfop7LiLxHMWRuUNN9VD0qMpNyfOKw==
X-Gm-Gg: AYBFou0RXScU6Qpt10RvLhmZOEDOyh2mdzwvVxFVXNILYC3q6r+Hxj1rDOdYrDDq8fx
 hgUzwMczeJ5vlJwnPoVih3f7V1ajz0uAhRvMZRI4qPkb/tYil8uIQXW4QJNfe7QCrpxlKjh1OwD
 FucWW7l0zAQ1I789R5JEypDBI93z0ylE+hawRBdtJf7kaTKDPVzXD+JvQwUTwRmfNAXn7JVuvl5
 KWtTMXPCVRs20mI8mjv0oOWJ8prAm3gj/Xr7UcVX3N3RSVbwCK2N1nojkTszAKGga/HZrwWp9kr
 Gpbgn4+o6z2YNzHnMyfu6J43B/ZLrYmulGfR2NH3K8AcBDjP63SM6l1S0rNPUdongrcLDE+u4YY
 7YEVpuAN2h+Y0
X-Received: by 2002:a17:907:9342:b0:c26:19de:9ad5 with SMTP id
 a640c23a62f3a-c2aea09c1ebmr867857666b.45.1790613887076; Mon, 28 Sep 2026
 09:44:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260731-atf-falcon-v2-0-acb97c172993@flipper.net>
 <20260731-atf-falcon-v2-6-acb97c172993@flipper.net>
 <00e2291d-7fc5-4ea1-abb2-9b9100a2b680@cherry.de>
 <CAKTNdwFMCK2frVyrmYWe67k6WgjA7pmJn-SbU+_9NtceHqHERw@mail.gmail.com>
 <6ea99943-eb9d-43a8-a238-edbc1b9c767d@cherry.de>
In-Reply-To: <6ea99943-eb9d-43a8-a238-edbc1b9c767d@cherry.de>
From: Alexey Charkov <alchark@flipper.net>
Date: Mon, 28 Sep 2026 20:44:34 +0400
X-Gm-Features: AclHuK8mtXZ36IawKZnYphSkFPwqtefcQcREeenJwCLKxLbaTvZIzyekYbwjVic
Message-ID: <CAKTNdwELO46dZ1Cy+-wpBbQNsP9XJyTgCjBYLQpE39YJ3XP0wg@mail.gmail.com>
Subject: Re: [PATCH v2 06/10] binman: Add support for pre-patching FDTs in a
 FIT with a /chosen node
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Anshul Dalal <anshuld@ti.com>,
 Peng Fan <peng.fan@nxp.com>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Andre Przywara <andre.przywara@arm.com>, 
 Andrew Davis <afd@ti.com>, Hrushikesh Salunke <h-salunke@ti.com>,
 Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Ronald Wahl <ronald.wahl@legrand.com>,
 Richard Genoud <richard.genoud@bootlin.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Johan Jonker <jbx6244@gmail.com>, Daniel Golle <daniel@makrotopia.org>,
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Tony Dinh <mibodhi@gmail.com>, 
 James Hilliard <james.hilliard1@gmail.com>, Quentin Schulz <u-boot@0leil.net>, 
 =?UTF-8?Q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 28 Sep 2026 17:04:44 +0000
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

On Mon, Sep 28, 2026 at 7:53=E2=80=AFPM Quentin Schulz <quentin.schulz@cher=
ry.de> wrote:
>
>
>
> On 9/28/26 4:03 PM, Alexey Charkov wrote:
> > Hi Quentin,
> >
> > On Mon, Sep 28, 2026 at 5:26=E2=80=AFPM Quentin Schulz <quentin.schulz@=
cherry.de> wrote:
> >>
> >> Hi Alexey,
> >>
> >> On 7/31/26 7:10 PM, Alexey Charkov wrote:
> >>> When a generated FIT is used to boot Linux directly, bypassing U-Boot
> >>> proper (Falcon mode), there is no runtime code to discover the kernel
> >>> command line and (optional) initrd location and include them in a FDT=
.
> >>>
> >>> To facilitate easier preparation of a ready-to-boot FIT, add support =
for
> >>> pre-patching the FDTs in a FIT with a preconfigured /chosen node incl=
uding
> >>> the bootargs and initrd location.
> >>>
> >>
> >> This sounds wrong to me. Why should we hardcode those at build time? W=
e
> >> already do DT fixups in U-Boot proper *at runtime*, so we should
> >> probably do the same in xPL when booting in Falcon mode instead of
> >> hardcoding stuff. Since you're aware of this, I'm guessing you decided
> >> against, but you don't tell us why. I'm a bit worried going with the
> >> suggested implementation means we'll eventually have a binman node
> >> property for each DT node/property we want to write/override.
> >
> > The "regular" Falcon way of doing things (i.e. the one not involving
> > TF-A) has so far been: "capture what U-Boot patches into the args to
> > be passed to the kernel, package it into a fixed binary, and boot only
> > that". No runtime fixups. So I more or less followed that pattern, but
> > tried to make it a bit more accessible by eliminating the "capture
> > something at runtime and save it somehow somewhere" step, which I find
> > unnecessarily painful.
> >
> > Maybe runtime fixups could be brought into xPL, but they are
> > excruciatingly slow, whereas speed is the main reason for wanting
> > Falcon mode boot in the first place. Right now with Falcon mode on
> > RK3576 I'm getting 2.5 seconds from applying power to _userspace_
> > (i.e. full graphical UI drawn on the screen), whereas the best I could
> > get with U-Boot is just over 3s to its boot menu, much of that time
> > spent going over the flat devicetree before relocation in O(n^2)
> > passes. And those 3s are after stripping the massive pinctrl node with
> > hundreds of its always-present children from the pre-relocation DT,
> > which alone saves ~0.4s.
> >
>
> Are they always present, even with /omit-if-no-ref/ instruction? Or
> maybe you're building the device trees with -@? Trying to figure out if
> somehow we have a bug in dtc (or in our scripts making use of it).

The problem is that there are a lot of `status =3D "disabled";` device
nodes referencing pinctrl nodes, which keep dtc from dropping them
altogether, so a lot of unused pin configs end up in the binary -
enough to be noticeable in boot time.

> Don't we have FDT and DM in SPL anyway as that's how we probe drivers in
> that stage (not counting the few SPL-only boards we have)?

SPL's DTB is tiny due to bootph-* markup (it was just 27 nodes last
time I counted for my RK3576 use case). Making SPL parse the whole
OS-oriented device tree, along with all the relocations required to
insert stuff at runtime, will hurt.

> I don't have anything better to suggest, I'm just really worried about
> the potential ballooning of properties we need to mirror in binman.
>
> >>> Signed-off-by: Alexey Charkov <alchark@flipper.net>
> >>> ---
> >>>    tools/binman/entry.py     |   8 ++++
> >>>    tools/binman/etype/fit.py | 103 ++++++++++++++++++++++++++++++++++=
++++++++++++
> >>>    2 files changed, 111 insertions(+)
> >>>
> >>> diff --git a/tools/binman/entry.py b/tools/binman/entry.py
> >>> index ce7ef28e94b1..e0dea8bf3a49 100644
> >>> --- a/tools/binman/entry.py
> >>> +++ b/tools/binman/entry.py
> >>> @@ -636,6 +636,14 @@ class Entry(object):
> >>>            self.Detail('GetData: size %s' % to_hex_size(self.data))
> >>>            return self.data
> >>>
> >>> +    def GetNode(self):
> >>> +        """Get the devicetree node which describes this entry
> >>> +
> >>> +        Returns:
> >>> +            Node: Node for this entry
> >>> +        """
> >>> +        return self._node
> >>> +
> >>>        def GetPaddedData(self, data=3DNone):
> >>>            """Get the data for an entry including any padding
> >>>
> >>> diff --git a/tools/binman/etype/fit.py b/tools/binman/etype/fit.py
> >>> index 32caa03a7e16..750ff5b47ed5 100644
> >>> --- a/tools/binman/etype/fit.py
> >>> +++ b/tools/binman/etype/fit.py
> >>> @@ -304,6 +304,40 @@ class Entry_fit(Entry_section):
> >>>
> >>>        See :ref:`fdtgrep_filter` for more information.
> >>>
> >>> +    Patching /chosen into the generated device trees
> >>> +    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >>> +
> >>> +    When the OS is booted directly from this FIT (e.g. Falcon mode) =
U-Boot
> >>> +    proper never runs, so its usual runtime /chosen fixups do not ha=
ppen. Two
> >>> +    optional properties on the `@fdt-SEQ` node make binman patch eac=
h generated
> >>> +    device tree at build time:
> >>> +
> >>> +    fit,bootargs
> >>> +        A string written to /chosen/bootargs of every generated devi=
ce tree
> >>> +        (any existing value is overwritten). Typically set to `CONFI=
G_BOOTARGS`
> >>> +        via the preprocessed devicetree source.
> >>> +
> >>> +    fit,initrd
> >>> +        The image name of a loadable (e.g. "ramdisk") to use as the =
initramfs.
> >>> +        Its `load` address and packed size are written to
> >>> +        /chosen/linux,initrd-start and /chosen/linux,initrd-end (at =
the width of
> >>> +        the device tree's root #address-cells) and reserved in the F=
DT
> >>> +        memory-reservation map, mirroring fdt_initrd(). If the refer=
enced image
> >>> +        is absent or empty (e.g. an optional initramfs that was not =
supplied)
> >>> +        the initrd properties are omitted.
> >>> +
> >>
> >> This sounds wrong, why would the FDT image node need to know about whi=
ch
> >> ramdisk may be used? Shouldn't we rather have a ramdisk property in a
> >> configuration node, and then patch the FDT based on that information?
> >
> > Falcon mode boot where these are useful is for a fixed-configuration
> > boot flow anyway, where one wouldn't have a way to select among
>
> How do you plan on doing A/B with Falcon boot? How do you know from
> which partition the kernel you booted originated so you don't upgrade on
> the currently booted partition? There must be some way for U-Boot SPL to
> tell the kernel at runtime where it came from?

I don't currently do A/B with Falcon; instead, I rely on the fallback
to U-Boot, and U-Boot in turn loads from a UFS boot W-LU (which is A/B
native). Making A/B work with Falcon would be a nice follow-up, but I
believe it will require some external metadata to choose the active
boot source anyway - and then the same external metadata can be used
for the upgrade. Such as the UFS device attributes, or whatever people
use for RAUC and such.

> > several ramdisks to go with the kernel image. So putting this
> > information directly where the user (i.e. the kernel) will find it
> > cuts out intermediate steps, which in turn improves speed and reduces
> > complexity.
>
> You already have:
>
> fit,firmware =3D "atf-1", "kernel", "ramdisk";
> fdt =3D "fdt-SEQ";
>
> in the configuration node. So simply have binman derive from
> fit,firmware which node is included of type "ramdisk" and fixup the
> device trees in fdt-SEQ based on that info? Less user-prone IMO.

Ah, I thought you were referring to runtime FDT fixups based on the
selected configuration. Patching it in using binman based on the
configuration node contents should work, too, but what's the practical
benefit? It would still use the same ramdisk node, just written in a
different place - or am I missing something?

Best regards,
Alexey
