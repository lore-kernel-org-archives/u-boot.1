Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4AD606A32C
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 12:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=q9uw4SDB;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Az55cxOC
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 97ECB81705;
	Sat,  7 Nov 2026 12:51:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id L5a_mSpI0hBC; Sat,  7 Nov 2026 12:51:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4EDA181676
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794055860;
	b=CpfzW0Q6D+5EtNNxjfRQVKLvvaGO00an5wKVm9y8wG0qdHWldSAanMdXEKpjnAtE1yHH
	 IlZNltX/hSlZTFuZqRaK+tcfyj8AuO7Q8ilogIzfPxdTQBu7+3dm9nk4Qvx2HS3pwc96j
	 EKl0VMFypJ4sja9Fn8eT5MLwi4bQf+Ml9MdADX0Q99YmyrP43g7s0cSYYcjDJQ9UffRMw
	 me+UPdQ/ogk6NjIAosea2UujqrJP2RkyT53drHmIgF4HVBLiYRVrmi/t+RglyqZg/cKb4
	 2lWbKxDbRlLa/030cAvXUGsHcg36psyqGGCKOmQ2XN0SWedxFQHj2ylI7eSAsBZSYQA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794055860;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ctkrd/+O8hlsb+vEe+PHK4LgaXPq/7vbGgztmJ9wDx4=;
	b=Ub1rK+MUM7OT44NeNqRLyXVT64HL8i6xePi5G1bmAei4uslg84lVStZQRWrP8KnXo05R
	 fHg/6qBta+t0JUoHc37tw/VXg69hupv0QsJJSS0EfX0H0B52hYTi2Hg6ICFYQIwwj7Qgj
	 B017PNsYuXr1CfQzzHmHojMBHT1TbJYkdo3xC7GW5SzKHPtIVHb8V7yRGM9jg5ZRfc3U2
	 q6RR8TS+fHWiF9njkqXJybR00qVhMChxCsbvATd3NIPpu/C4pTRGws05MV0ZLujORZDGB
	 RQcsgYWOqkeYGN3ejmwSIzT5Exgjkv8wRcCNFv9R8ndL+rKfRC6k9pD6ImH2S2mjo3Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794055859;
	bh=ctkrd/+O8hlsb+vEe+PHK4LgaXPq/7vbGgztmJ9wDx4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=q9uw4SDBU9MUoQJ3lqT05G9r6CexD8NRjldW157dh0idYHKOSVl0Bt9NUNqnwoEuK
	 Bl7TtOmZRcLWLrKug7G0ScULtEgZWyU6R40dbDOwkFkRA81FVxtNdtGUpLu4kv/hqe
	 wjAjqD3mNF0G5nU10rKYp3k3V8kd0KvoVYmpx8sld2UYVAWKdbGDw09Zcd5nuK8cTy
	 xnlmOR2UGHqFSLvvFb4kgORRsjaZlyZGbIlVOmWsxFxVqw/N/MOrFlr7frgWwFnA8E
	 Gl3fDbNzCEOmve6r5VMbAtJjTQrLu0k+BmNqR9gk6BbVH/Cw04X3+pESrGpQmQHw2B
	 khOcTM3zBK7yg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4EDA181676;
	Sat,  7 Nov 2026 12:50:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 236522E5
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 08:35:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 14BF140081
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 08:35:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DGhTOnCF-Owr for <u-boot@lists.u-boot-project.org>;
 Sat,  7 Nov 2026 08:35:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 0355A4005F
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::52a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52a; helo=mail-ed1-x52a.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=Az55cxOC
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0355A4005F
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 08:35:45 +0000 (UTC)
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-6b58c577e9dso254320a12.0
 for <u-boot@lists.u-boot-project.org>; Sat, 07 Nov 2026 00:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794040544; x=1794645344;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ctkrd/+O8hlsb+vEe+PHK4LgaXPq/7vbGgztmJ9wDx4=;
 b=Az55cxOCu4Yr1gLNudilu+ZIa6DmXGYz5I95yCEiLC7lyBePO6G2BYgLPhKpTd1rlc
 kEzd4bMv9Sf7p6nmyTC5+h6ABWZPuXK1fwju7O0bF7sA2WdhHJkLmGy3uNmJcCDZxIMs
 c5bZgClljjJtaNKoqq9seTeaJhsCNcPMdpHn7rtUOB3fd5CO5HyjUD47HELR4BHL+VB5
 hEVLgOjiiE7D2Ep9aAuSsPSdHJ0ryRngbO67V7tbdGoHV9NWDYraYKwrbslH8/2tQmH3
 MlX90WT2eWNm1Qj+WjI+mubHYvf7bmqjfJvyuwWkHv5xTme28uZi21SFjAmMDJUufGfr
 ksSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794040544; x=1794645344;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ctkrd/+O8hlsb+vEe+PHK4LgaXPq/7vbGgztmJ9wDx4=;
 b=nte0spVDL2XssWBnMP0eAHmMs6ld3BRI24L9f+kaao6dfujZX0bZS/6Hh7dY47vfOK
 tUPv+Ydi+Zv+HGSk/6Mu9VlUUk8Rp2rZ0XYDH4S2RRwDvUvXb1WnHYslBT8wFaXT0ywy
 EBHU/i+BKhJDhBwV9NVEEX4W+66eL+xcoJY2Vt371JVlYYGQjtuEEGNf5eKOSFIaVHH3
 76VG1pQEXafMPY1/9ravp15+34irtzoynB+nsnH8jopRJgoOovuxTgV5qqACtEGLADuB
 2im4wi+uNBXMXuosdqe6pdr+hrIWLLGriP2BhjCmYmxoQ5OMkXbMt/dheCMSLSIcVip0
 hnRA==
X-Forwarded-Encrypted: i=1;
 AL+hErGDDJEhKSE7/5ldHW2yB/glT96dBkGEvq1SoRFd3A5tYf2rbk/vwdH0YgRrCJp7XoadOOA+PO0=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/6CzRf1dMqquf0qd7ztcSpYVQF7skcnogkfpE1Ytam6B4YBTMa
 QLXSrXDJesZ3Doh16CJG6CRJ/ILGFk7GP3wDSz4vX4UXaDcEv2LpaAE3TxQ87f/+P1R5Foyb6Ts
 8+g4tGbD8TuZf7BI+8Ej/NR5udtm5zJsCSAjU1ZZytw==
X-Gm-Gg: AYBFou2vk50UlFDvhhu11HlFcO/8kLFMDtwypvjwELeYc3upYRVwZst/UVKxTGmRe8v
 IZ1HF+Ofk7Oyuko3t05oAPLsvtOOeC6cCBm9Z7nHdPwxP+rVwVCjZ0LVCMZjXgSzeHcOWyyCK1m
 GWm/d74ykN2w31F4xH9oUgSJdg2nLmR0CaBKlE6812uUkdUCXZmhMnb6Wi7BgQwUBA0i6trjIj1
 zk8t5RTtdWoCT+Focbihb+HZB6YF1VnT77c1/HgjGsM4ua7Hf297r6i0JVsIk0KKzxu9ObWYxTs
 l3Dq7gwLUQolJSWn2/MOBLFT2QzuvW/ZG6GOkT5LEi79OC1+/hJ77xYwBdm1PR4ipd8rjnToF20
 E2Y9DoiZFDpnQI+q+xrGVigWchU3v2RgCQiQ=
X-Received: by 2002:a05:6402:1611:b0:6b5:4c87:3698 with SMTP id
 4fb4d7f45d1cf-6b597474d2fmr3496230a12.0.1794040543977; Sat, 07 Nov 2026
 00:35:43 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261028141554.3073545-1-anders.roxell@linaro.org>
 <b464c545-c1f4-461f-8f17-48854bd70825@cherry.de> <aunlk5FaVe_jcpSr@monster>
 <ca7b3725-cabd-4064-95dd-46c3eaa325f0@cherry.de>
 <548adaa3-9d2f-4fa2-8fdf-7c537c4d153b@cherry.de>
 <CAKTNdwGTdBfOp+km6Wpp2reV2Nt6hoa1Tvfj8tBC4+uU+h3bJA@mail.gmail.com>
In-Reply-To: <CAKTNdwGTdBfOp+km6Wpp2reV2Nt6hoa1Tvfj8tBC4+uU+h3bJA@mail.gmail.com>
From: Anders Roxell <anders.roxell@linaro.org>
Date: Sat, 7 Nov 2026 09:35:33 +0100
X-Gm-Features: AclHuK-baUe1cIrujOx10Z1uT13iVAR91BvkmvYEY3CWjwOXKUPh2k2OCRlV7Yw
Message-ID: <CADYN=9Km9iWXbQsHYx2BM7E4rX-gWbBntoyg-A+YYEnkCBrRRQ@mail.gmail.com>
Subject: Re: [PATCH v10 00/30] usb: dwc3: part 2, make the resynced code work
To: Alexey Charkov <alchark@flipper.net>
Cc: Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.u-boot-project.org,
 marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org, 
 michal.simek@amd.com, lukma@nabladev.com, jerome.forissier@arm.com, 
 dlechner@baylibre.com, anshuld@ti.com, sjg@chromium.org, 
 Thinh.Nguyen@synopsys.com, mkorpershoek@kernel.org, love.kumar@amd.com, 
 s-vadapalli@ti.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sat, 07 Nov 2026 12:49:49 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 6 Nov 2026 at 17:04, Alexey Charkov <alchark@flipper.net> wrote:
>
> Hi Quentin, Anders,
>
> On Fri, Nov 6, 2026 at 2:57=E2=80=AFPM Quentin Schulz <quentin.schulz@che=
rry.de> wrote:
> >
> > Hi Anders,
> >
> > On 11/4/26 6:51 PM, Quentin Schulz wrote:
> > > Hi Anders,
> > >
> > > On 11/3/26 2:45 PM, Anders Roxell wrote:
> > >> On 2026-10-30 15:28, Quentin Schulz wrote:
> > >>> Hi Andrew,
> > >>>
> > >>> On 10/28/26 3:15 PM, Anders Roxell wrote:
> > >>>> Hi,
> > >>>>
> > >>

[ ... ]

> > Not having access to any RK3528 device with a DWC3 (MangoPi 28k, NanoPi
> > R28S, NanoPi Zero 2, Radxa E20C, Radxa Rock 2A/2F), or to any RK3576
> > device with a DWC3 (Anbernic RG Vita Pro, ArmSom Sige5, Khadas Edge 2L,
> > NanoPi M5/R76S, Radxa Rock 4D), I cannot test those. I'm assuming Alexe=
y
> > may be able to help for the RK3576 with the FlipperOne device (or other=
s
> > since he has quite the collection of RK3576 boards IIRC). For RK3528,
> > maybe Jonas can help.
>
> I gave the v11 (from GitHub) a spin on a couple of my RK3576 boards: a
> Flipper One and an RK3576 EVB1 board connected to each other via a
> full-function Type-C cable, using the dual-role controller on each,
> and alternating roles for testing.
>
> I found no regressions vs. main, and in one case v11 worked where main
> didn't, so please consider the combined series as a whole:
>
> Tested-by: Alexey Charkov <alchark@flipper.net> # Rockchip RK3576

Thanks for testing on RK3576, Alexey. I added your tag to the v11 cover let=
ter.

Cheers,
Anders
