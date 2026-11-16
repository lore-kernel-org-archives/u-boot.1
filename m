Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D66606A32A
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 20:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=KJhloRU3;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SKOYHDoD
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1F80D810E5;
	Mon, 16 Nov 2026 20:45:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AFoQXhj89kls; Mon, 16 Nov 2026 20:45:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0E718810DB
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794861954;
	b=NsFtGf0xvlskxDRdH79bElotfD8yo0avJl1uTBVaAExqM2W8SolKDNrB5hJ86WwhxKVE
	 u18kikUOK/HD89Y4zoR5xeEUahNrMIn6nrQt0O3gRQYXL8sITB6GfCLmr1Yy4Yr3VklkO
	 pfH3wtPwvPQr3TiItZKCYgTABy2FStmZ1rsRBbSGx0vroVbTiiUCwn8Q/vU//R+HP7LTi
	 u4+xdgDGtk48KCwNWzQkjJe9ZTxmKnJmJD6h+xdbWwYxPNTtGGcu2+Ciy1vJ9lfrusupq
	 hJBuBCZ+bdLDBIISqSIP8nJQQaoC51LJ9rDA9ectQs1TR4Dnjos5Kik5y4phsg0zvzQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794861954;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=l4jQ361zjIhb3uWxmsidVqdzM/z0KMg3sLZaYQyvC78=;
	b=iF0E02H1UOOy8nhf4ijwWCqypYWoyTxapyAuu129ws+29AOtUB9oIkcJ9qiU8YHWzqcT
	 231QyPPRI8+INNPesbw/v5At6u77L6qDrbO+YamY2+AxGmioU1qJVJtXpxnVJBxz0rPwq
	 PFqLlr/v6+ibu1G6pZ6LPlZCxkU0D63f9Dmz3bMqSaUZ1EH2Z3LKHhdSKhjT0W9fBivrF
	 zjAyjwY5bmGx7eo+ScOir0BhPUH1MJofW4kn4UIIRTwIge0mDotShEzUJtdmiB/sL1l1U
	 5+g5B/sOzRYD/tcEy4CJjSYMVS6/fBD6vrAkKHNS2cMm4n0jGe8ylUktnt1gqnfFRnw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794861954;
	bh=l4jQ361zjIhb3uWxmsidVqdzM/z0KMg3sLZaYQyvC78=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KJhloRU3G/dGF1FPwkUapIVEMBZa70Uxm0iRdha+gfNCbtM2Y3a7/QM8bXxbZEUSG
	 4/p3RcRSS8tOFa4TQhBSFjtIJ8fbUbacxC5m5Cy0j7Oii8xm97LG4DQ4JT9IHUXG0F
	 W0GLl2MEA6klKwU48Fy45eV+djhyWttltvhNeqgUNoflv8ibs7pE2KiAjDvYgQoERF
	 N4s0MEfzoy+wMMn6GIwkeZxVU/x483nPNDk3JUabuVMXrN5rrcyNTpZoWPracmHQTB
	 KwFOFavi63cDF2FmbWnXqjqdt5iWqb6oNN8ybihcu45M36dufxG2Vj8xCAuL6ZwsG7
	 obwisTprraR6Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0E718810DB;
	Mon, 16 Nov 2026 20:45:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id D7D6B28C
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 20:45:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BD8CC40670
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 20:45:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LT6DL-kPtAnb for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 20:45:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E2BC040644
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::434"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::434; helo=mail-wr1-x434.google.com;
 envelope-from=jernej.skrabec@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=SKOYHDoD
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E2BC040644
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 20:45:42 +0000 (UTC)
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-4a3e706b5dfso8051f8f.2
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 12:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794861941; x=1795466741;
 darn=lists.u-boot-project.org; 
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=l4jQ361zjIhb3uWxmsidVqdzM/z0KMg3sLZaYQyvC78=;
 b=SKOYHDoDT5DxEuv/temOHoWkspiPdXZ2b0NaAlcy5oluPKvThJD9Xf6wypSrZjlXKQ
 vAnLBHIYMJNNROwz2QzFCLc2y8mLegwU8dXHonodHgnyqmK6MztuJTGF5Czxwx6PZXp5
 HKr5+G/SOCgQQhPmzP0IDBjFw+AqVkwL93LXO1HoUSeuRLexZRfl/FGCBLMpnd9IwUjq
 p6/K9kw75oRtMn3h4Xu0mpgtXSxAYfn5mGV2BNAQ7DqPA4GSBeLdhwon0YIW+sptTVnD
 WHaynlt4WXYBusLOJCKbdvhcvfBwA+PWHyeqERHvCuSsMN9H75CJIDLP5sinvqb3YoT9
 /5Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794861941; x=1795466741;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=l4jQ361zjIhb3uWxmsidVqdzM/z0KMg3sLZaYQyvC78=;
 b=I4gV85oCcNkHJyEhDG+dRJV9lr6z82VL1HxMjSwA3E6HJmyS7khe+kHlJhF03q8zNl
 Z6a8H1tywD7ITDE/08/4qT5YX6hlfzkNidWhOOzooD1J8WfM3zTLvp/OW+TsCf9l4wN/
 2yeBWm/4B7MRebMWk4zHy94jj0AmihWrJDWa1HYaiCn6ZgGHuuWW+3bvCKejJAuyh4qD
 thlHxSk8jcGjNNiTA/RI3ILyOnI1xijIxY0XwuL8a2HwmsKXh/6eQwifJ5qW9/Usb6iP
 Gj7ZsY8MzmYzeoMHBLlQnf+NShNGW8uQN2taMc8gGDpGdle53/59oCI8pv7QR1Qj7/NO
 6Shg==
X-Forwarded-Encrypted: i=1;
 AL+hErEH9Csxp78RHTvWPtDkKXeOZ95l+t0VcfQAyuxBqxCMH31ns4ItWejapII8ReqfnzbiefS6LjU=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8upKRud+4sWeURU9ZMuiL+hznl3vqrXl5jp7FbNrEJX7KCwt2C
 nE15yVwq94xu2/AWU65+ImvCVbw1AEDcFMv5WmA/os+5B0e+66MRoJxE
X-Gm-Gg: AZFdTZeL7rs+WEC9slByBmeGVLq65oZ/ls1wPYvdItDI3c53uxFm94Tk4LcjPsHezKy
 D9bRIWTNnaZkt+gb04Q+K/Cf2ufMhhardKw0fBy3LTS6fCU1/oOz0WGluElb6Fe3FQSN746D4v3
 vO6QA0nthUvLXBeCvjfwaTQGWDjweG+z9KfYX/569T6DXDjucZJF6Ywe/5S38CQyjuqkZjegyru
 nWOS4TyOrG2nbn5sc3PKKHZzmAEeE2Q57SsGhycltgumAWgNj/VRzHc49OyFl36oFkytx3stHDL
 ltAQDC61PllyR2YAJkFpw6Vftg6jB3QfwUkYyMTZvF1SAUbiNWawWEhP/QBwIP4wGte0f4pEiGq
 RXwjqUBHwLpC/+ddlIQb/4XdNjVEMiLW8EGrb2eMLDCO2oG6u0zZRJC1Lext/xrR44ox8lx4Mnf
 6/tgU3OQfasx3rY7nfSKCaUlMFCbAzCLpekjyViAMvnpnNT9v3ZI+n0MKf7RBP1S0STT+rqbfuf
 47XWnQr19Ekc6ulfRs/AqQJtPWMa10wo4ST7h4mitIb9kJ5SV9njXeayLvFEa4sd0UDUXpcYR7y
 7IQehD9CnyRdh3vXw7NMrMYBliXKnKlyYndgzvMbFb1Kr79gqc/KrqsHqPIvJ8Nl8/SMO6iHxIf
 A+0bZ5in1utNJAtl70KMNQo67an6Ekg1AN4Eb1W1QGXjkpv0rnbaAJUtt2tSB7pW9+hNcNcCvpQ
 JUWpOjIAxF75+gIngaN65g6ABkHplSk/cWMyBW0WANSs4igdRfNlIwUY2VYX4iLriipyoeppgTP
 wZlhuHR7RQLAHBnndiZM0RD1NlGkuiPfDkwLJoeByztDzFmN9gIvDbWhWSzBFIJ0Cl3
X-Received: by 2002:a05:6000:2486:b0:49d:7e8c:e89c with SMTP id
 ffacd0b85a97d-4a39faec2f5mr734553f8f.42.1794861940508; 
 Mon, 16 Nov 2026 12:45:40 -0800 (PST)
Received: from jernej-laptop.localnet (95-143-148-21.dynamic.telemach.net.
 [95.143.148.21]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c7da37b19sm24810923f8f.5.2026.11.16.12.45.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 12:45:40 -0800 (PST)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: marek.vasut+usb@mailbox.org, Marek Vasut <marek.vasut@mailbox.org>
Cc: trini@konsulko.com, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v2] usb: host: ohci/ehci: halt the controller before
 booting an OS
Date: Mon, 16 Nov 2026 21:45:38 +0100
Message-ID: <25xogLBYTTCP3ofXGfm-4g@gmail.com>
In-Reply-To: <8bd76ab3-de28-4acc-90e0-2de45fc948f3@mailbox.org>
References: <20261116155320.34570-1-jernej.skrabec@gmail.com>
 <8bd76ab3-de28-4acc-90e0-2de45fc948f3@mailbox.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Dne ponedeljek, 16. november 2026 ob 18:54:05 Srednjeevropski standardni =
=C4=8Das je Marek Vasut napisal(a):
> On 11/16/26 4:53 PM, Jernej Skrabec wrote:
> > Currently, OHCI is not stopped before OS starts booting. This means HCCA
> > is still being written into during OS boot. This may cause all sorts of
> > random and hard to catch errors, if same area is being used for some
> > other needs.
> >=20
> > Mark OHCI and EHCI drivers with DM_FLAG_ACTIVE_DMA so remove hook stops
> > both controllers before handing over to the OS, same as xhci-dwc3.
> >=20
> > Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> This just landed in u-boot/main f8ae7682494c ("usb: stop generic OHCI=20
> and EHCI at OS handoff"), is this implementation any different ? Can you=
=20
> please have a look ? Thank you !
>=20

That one is same as mine. You can disregard mine.

Best regards,
Jernej



