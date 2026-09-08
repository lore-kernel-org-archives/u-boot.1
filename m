Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4526C79FA0
	for <u-boot@archiver.kernel.org>; Tue,  8 Sep 2026 07:30:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BD65B808AF;
	Tue,  8 Sep 2026 07:30:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5v4hijiLm9CY; Tue,  8 Sep 2026 07:30:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 14761808A2
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788852651;
	b=j9qobWjmYD+mUmcN2Ffz7fT8CgkXZ9+BTth+JTFqHJOtdqGzQfHK3TthWDVVMfXdWGn3
	 qwcn3TcbxzqNkGZUrM+B30Tbo69Eg41754ZTRDdzwPnESi6ASr7lGPDCUwiLYxBizMoA4
	 QRDjx1LhluLknjFK8aXKlB7ru/eT5VkvJPQSa5wN6vcKowWcl1tAfg1lvbCFpZG4hXB5j
	 wEC3iAd6L/MJ1P7CHTsGPhvU5HaKUJKMga3QnOKg6uuu1LfnZ0EDidfvhs7vvFrTgVgoA
	 fxvfaxqBPHu3+XOa7CRNVAaZx34uVN4Dl2ZBC0Au0dY5QsijFQ9FXpaePWPoV8XX1uw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788852651;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=pEvTDYg6HIa43nFw2OBBZ7nOIwCJXD8+tK726psR1KQ=;
	b=VnqUfGyVXrW9HXHAWb4EsFiRcNwrG9xEw5AKyVhVSC5d0FvcTlo8hE+iJlqdNAE2jQ6e
	 xHwLS2kWrMjk0Rcv87cs1FsVnkPrIsGR3hDCSz5MepOVn1BBrVv6QFHgqgMvYaOzOry1g
	 Me/kS5xkuf4Pht7owjOZ2LLs0iB5IrYt+Y3Re3rZ41YETA/CFy4bV5Ri0B952bEu5CnjS
	 t/l7Ejxidq6BvImhp/vver5MOO9y/tUqeYYiikh4vnMqP4VT8vngJ6pLa749I5vs119S9
	 9JUlYYIfHUJ2C1xnPb4MsyvJYgU96baQwnZXeytdN5G9xhCpXWOfZvq2lWc2EFyOYgA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kZCzQR7Z;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788852651;
	bh=pEvTDYg6HIa43nFw2OBBZ7nOIwCJXD8+tK726psR1KQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=T2JXrtgiIf9OeulkEQLU9rVlBR7kCodYYZeEdThV33cZ9BLUcH6KXj9318qJTvY6t
	 2EzoL9wZKLiG4bTygXAgLDmdFfq8Haa/vV5dJNZdLo+i6WDw14WNe/ZIQpt2kEj5uT
	 BPdMYaO1I9aXkrTXe3NMjiuUwVs+CoKiguQEWQEnrtibmH5HH63DWXsa5poEq1KWSS
	 kCsFPuNKatidRyp1+SKjPhtaU7ePJ7PysUmTuz0WyxkyLoMcEwHAaPcffBiahX0kbC
	 pWxVjb2+9l0VnLr8RZM3Uzj446CW1Aatz7RPTJKSmTcFNz/nDZH/OnEbccNpCIDpyN
	 2slNRXbikIN7g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 14761808A2;
	Tue,  8 Sep 2026 07:30:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id CE13649D
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 07:30:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BB844808A2
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 07:30:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lhooXFtNTBxW for <u-boot@lists.u-boot-project.org>;
 Tue,  8 Sep 2026 07:30:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org AF4D48088A
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::f36"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788852649;
 b=EkBF3x2ULLqJZFE8fuJq4h/bbY93I/qZicsOckQDHd0FQ0U3EcJ07K5FgrE6hfLulwSt
 T/LFSlBHNfLcXHX9wAOFbQN6aNG53IFdsqyzV/iVd7j/Nsvccqe5iL2V8DvUkksATm6wP
 KrK0yfEYBtmM7rqlA9cP7/Ehz5FB0gUUcfhSjJIFS4ZtSE+V7EIVKoEIYcOhB3Vz1eB82
 PCGRceCgbH37h6gynd6NE02sLFd6Jr9kBLyNnpph9SLtJac4u3NfnJ3dzLfs1XS2AuulR
 JP/MmgISEbaYvPaVIWHO1waWv9pzhOhDhMNxsjmJkAPn3EQDMx39JJIK1jm0ZXAF+lw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788852649;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=pEvTDYg6HIa43nFw2OBBZ7nOIwCJXD8+tK726psR1KQ=;
 b=i/bMF3zO7f7Vohv+xkIHVNteZGeuE/Zo6gKH/uGqVyj+mEjmDA+S3qq8+rybtemwW9Vg
 o6YD7k2IZrhnQKtKXyrkOleZnZFnBSL9MDl+/mWb0t+JHPJflnlvgBum9jkf9yw2j3L/S
 L1ShtrcsKL/h7GX4VflG4OJyMe9Fl6Ov5en6uLhk7KpUv5d+srCSHdp1GgexxqNvkW4d3
 cAcO62qi3ingsGtC+xdzRb2FAQdapxuxPMYMm3inHK3Cs2pj9Wbco0wVLqHEuJG/xL75X
 yZP7Uz0osv0Ey6FeogRL7rbUxjK0WZrmPudHNTRP0X5x6xyY4sIoAOrJPplkQoor8AA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=kZCzQR7Z; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::f36"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::f36; helo=mail-qv1-xf36.google.com;
 envelope-from=pbrobinson@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=kZCzQR7Z
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AF4D48088A
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 07:30:48 +0000 (UTC)
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-91053c27a91so18277846d6.2
 for <u-boot@lists.u-boot-project.org>; Tue, 08 Sep 2026 00:30:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788852647; cv=none;
 d=google.com; s=arc-20260327;
 b=c4GxJx/Yq4J4a3AL0Nd2Abv+5R2g6YZSm0R4BrulCxPGH9lcycAs2fAe654qYi8TKX
 Le2P+aX+sxxS5anB6I2lxthj+RTiKk+0gsjUgTw9gUFmuGywqQLAzZ6qvkhqKLPoibCn
 utVAEDPFZjjIuKF5gfK1sf/rrFnmlWZWVJB8cMhmCqyr3HBdnLtYsDEa3kC6za9hwHiw
 CPq9Q0EP5HvQkNXT1JfWmw/z4Eu39eGAC/wcKy7spHoTkH4CedxGEpfB5f8eT55ACtse
 7W9LchRh/bbRnDEXGE6DsJzKuT1n0G6LLKotdTI8sr/aLqxpf0B1GgGD/q3FetJHtxCL
 ndYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=pEvTDYg6HIa43nFw2OBBZ7nOIwCJXD8+tK726psR1KQ=;
 fh=g8F/nrGY1WxORlIxkdPAOiDKL+wSbHvbz5mo9X5wams=;
 b=i1VjyGofRohoWdJyjr4kUeHkSoIbvO/1IAwK/r7xFJW/XP7rfDOju4Q5q2VjpXaQZH
 BFTkFavIMNh17AgKrOq38pdfYfnmrLaBx17zMcmbGRURC99d8nMLAxMflA/MXEnWTJdB
 phzdZ1jLQ96wm0NeR4N9IZlGk8BMqEg0yo4+YslAQgL9kGxBrD+6LWMKhiyPWMakc6CM
 T5OmhJPOe29dCLoHZFtsqt8nfQOOhxA7rHuLYVy9KBOsAUdTTCIZmW/joInhThbJtF4p
 Eg2KGpAX6dDB3YODLcIBL+lQLWf6YPhudtWmk/iWRdIwzNmgl3Sm9zwbobvYnXC3vHRY
 PEFg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788852647; x=1789457447;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=pEvTDYg6HIa43nFw2OBBZ7nOIwCJXD8+tK726psR1KQ=;
 b=kZCzQR7ZJnOGDU+NrjLon2LNicL7TPyuoIrjRKn4dD1j9S4er3HBt2YmGqjaBezRbD
 PLijwhSVgaMfWifexsCBfMIwhkvzoTR9QKy5Z5zFTrryDfdsF0g/z7I7VQzzKVC8UGpR
 RSxQGZbF/lTb27VZDuoXqjwiEe8E1pZ5JlL91xHsxOh8F3W7w8fmIE/jmgb93qNrfnBF
 LpsKFissMu6zoDahj2D7AsaUnHhE0UeNex/gAv+UJhwqC2RPtnrwVMtKuAqJR9541zM7
 x5NMIMRqBeF/ZigTFbOY/HJvcXahJqcljdF90i9sjqG46117ZrbatEUERqAj6HgWVwiD
 0A6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788852647; x=1789457447;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=pEvTDYg6HIa43nFw2OBBZ7nOIwCJXD8+tK726psR1KQ=;
 b=N33me9EURuz6Ih1gwq5J06JQ0mGxUV/zgBayN1cR9a08Z+q0ZBI/XI7G2USPhwNkPh
 GZVV7PMdq5zswIZ/i0BEV35VhHx0p5jbRCinYXnN20kYQn+sO0op6NcMGkD4I68jkXhe
 JfpFSXHkKdG8WNcUPqzeQv/ETHeu4uPSw9+N4YaCxEXHxPmoZ5apuGEN1Ypu0zqU+Mkj
 vMHiiL8QoDP9KzFGlJ0F69BH5Xkq+60fit/0AxPzWRv83Xy68Da9bN409fJF6N4hbYAm
 FfM0IrMW0PgJRpBZVb036ON2IOfRbEnbfCK0gbcL1dlTFQLhicAsPbTYpRAJPyUyYrcY
 E+6g==
X-Forwarded-Encrypted: i=1;
 AKwUvBxvPQ5begn10boo5XXKPp/r/OBXPLFZHkQ0h3vpzh8hFi/AfINMA29uDscvbr1N2gXX8UFRK8M=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++m9QyKJAYbnd5+OlVgHHk8NIasHTZXl83UhvRohvs7EthF2QTSX
 bkg7/YJWr89agDfRCK25hTR68nEjg8CYvjxdbQd8POQJHMg3aR3iqdAdbGaAmEPDrwu//w3bnSW
 OxRK5FYWguakoFtGpvdm7oqUeVKlhWzo=
X-Gm-Gg: AYBFou3GpmiNRkNJsvrQKAkHNsR3KmpUeuRT2w5Eu+I3UuM7PdDysdSmdvY6OPyEHaK
 9jZz/7KZsK5CVrmCayKeZmuQhb7D+QwmHvrKrJspdp310NNA7spkpAc8bhS5slsRHqcgnSbYZ69
 MxpKtNbRlaLuYIeEksTq+Cc4B4LEks7tdKKidc/v8RagVU1U02HMbUsfN0HqjPjNFC+JhcTfwab
 /HNsgwHLV9HAsmxuOZDJKCNIZeGyPEk9CAronQ2UQY3pxXIqaJ3kzzrRO0bVEiBPswmfB+isYiV
 vhZp5qbwYeAzhEpVhhKJTSVE2MnsJBV++dUhOOFhH6Qhy5oDJ7VVgcGh/8uXFSNKOa9hbXg5dHY
 tYaTpcCu9KB5sX8NRwLWLwoJ5RnFmzX7Yof5EuRS4G9pD/qlrabvWhe/w9iCE2aOP+82b2fRWo5
 Q4Zevh5TQb/b3bgIMez+QkMDGw0OIHWE/R6lQNKvI=
X-Received: by 2002:a05:6214:398d:b0:90e:963d:4c9a with SMTP id
 6a1803df08f44-9103f0b5642mr359827136d6.24.1788852646410; Tue, 08 Sep 2026
 00:30:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260807140119.324858-1-jorge.ramirez@oss.qualcomm.com>
 <aoMc8FDcE0bYGZch@trex> <aohaajBy5e6A4gFL@trex> <ao_89VbNNE1QTX6a@trex>
 <ap5i9edBJ7sNVmax@trex> <61fd743d-c722-42b8-a754-175715a4bcbe@ti.com>
 <ap54m53aTMXhIso3@trux> <20260907161339.GX1764417@bill-the-cat>
 <ap8NlN6n2lOWTUW4@trex>
In-Reply-To: <ap8NlN6n2lOWTUW4@trex>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Tue, 8 Sep 2026 08:30:33 +0100
X-Gm-Features: AcwNN1Vw1Zhz-2xb6WdhQRLs6h1Z97arvENBntRvH-HqZEardfvolbMkBxDv_vg
Message-ID: <CALeDE9POerFRGcKWyezOv=RRYf8C-ii5Loh5CX1ruvQaQswrVA@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] ufs: rpmb: route OP-TEE RPMB secure storage over
 UFS
To: Jorge Ramirez <jorge.ramirez@oss.qualcomm.com>
Cc: Tom Rini <trini@konsulko.com>, Neha Malcom Francis <n-francis@ti.com>,
 jens.wiklander@linaro.org, 
 ilias.apalodimas@linaro.org, peng.fan@nxp.com, jh80.chung@samsung.com, 
 neil.armstrong@linaro.org, bhupesh.linux@gmail.com, xypron.glpk@gmx.de, 
 marek.vasut+renesas@mailbox.org, igor.belwon@mentallysanemainliners.org, 
 shawn.lin@rock-chips.com, tuyen.dang.xa@renesas.com, 
 yoshihiro.shimoda.uh@renesas.com, padmarao.begari@amd.com, 
 macpaul.lin@mediatek.com, jstephan@baylibre.com, 
 hayashi.kunihiko@socionext.com, j-mcarthur@ti.com, venkyada@qti.qualcomm.com, 
 dlechner@baylibre.com, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
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

> > > still I can see it on patchworks with Neil being the gatekeeper.
> >
> > Is your tree out of date? That's not what it shows here, we updated that
> > a while ago.
>
> not as long as this series apparently.. plus maintainers were in copy
> and actively reviewing v1/v2/v3
>
> but yeah, These patches were developed on top of "ece349ade29 Prepare
> v2026.07" when the development started (so before the list was
> updated).

Also note the key development branch is now called main not master.

> anyway, so what is the next step. resend posting as v5 on top of
> v2026.10-x ?

Like the kernel probably the latest -rc1 or -next depending on dependencies.
