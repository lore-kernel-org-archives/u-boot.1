Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7497E606A31A
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 12:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=R73dMJ7T;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=RYW5E/ci
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 52CC3409ED;
	Thu, 22 Oct 2026 12:56:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CaiJMIIv9Qld; Thu, 22 Oct 2026 12:56:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5C6E1409E7
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792673773;
	b=VKUslNMYGp/jT6wUCkOnmOJvLYLath1tsljkeTYJZ0h0GDUD/s/OKmc71/MtuYBS6JWd
	 n/2SgG3WTjBGAe8H1EIk3wnzVbry/BHU2HAq3VMhI+EBxsSk6TLMKGmlNfAF88e5tebEW
	 1RLedGnEpwkFUPEUNaGx2IVQP3jJtBdOqzouFBJ7N7iyV1fPBjkQ6KYeTdex6UEmVS0X/
	 vEGSUywA8G880YR8XlrSNq3FoyOvsVpOFvYovz8Ln/as2ZfmXSvzTksMUiYNnWH++2Yhf
	 z8q90GvG37ZV/5L6eVmDZW11Nj4oRrYLU8vMHsXWpVORe8QRo5BwradR8cNvvCpVd6Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792673773;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=yROv6GKBuM2oalzjhgFkFKARAFqMUfP+ii7aC8Mp2CY=;
	b=dIlLZAsdbFVRoTVUaWBfpHSYcaWw97pdEJpSl9H+f8qn3YWhQ32jMd/3S0BBUeVut2mE
	 MXG1SPx/ZVzUDhN7UubkBgFQgEuJ8wFWptUvGhDT9RKWF2gJXwn07+kRj5N6jU84c2p7F
	 7VqMH2RcEPywCavUV2nUil6/H5y7Lceq5fJr4EZ+In/7AQWEeQ1S91KIQnZV6rGN2JRrv
	 54Fhqgb4UFfw5FBXuTfQrMx1Adi5WUd8lyYPxvwgJWrRqmeGJmC6VD8x+CJ1/lX0XKetn
	 Y4Q9J7mByl3flOKsnEl543LP78G9awOsoY8OMbtsxXEpcoRrlK8yKCzz5QcP52MOFTg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792673773;
	bh=yROv6GKBuM2oalzjhgFkFKARAFqMUfP+ii7aC8Mp2CY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=R73dMJ7TK4VFzLwognbBrCLjy16BgmkB13m87jL2clIY9o/VlgAwFkV4hNA2bBuY3
	 K+7zMA0PKRCRl0g5al5+CpTrtN3VdTRkDfCC/S7lF2ERnmljEC8xAimRIFhedUA24x
	 SCOf27DJoAx5NEDw6jwbqIKATShq3nGGAcA6zHFUiDC4xK6a1T29x+OR625f/kmSe7
	 JxyWXVPmW8zlNEhlbqBY1RPjtMalqAmpL7dPExIoNhlnrAqPgN4c2XsGq2Ho+0uC3y
	 7+QD6qi6A9kJmlIA4oyK4MhYsX0l5l442Fltf+gB0wdOvr1RPYj+oQgOBhgl3lKwVj
	 wVmqWCL5Oe4sQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5C6E1409E7;
	Thu, 22 Oct 2026 12:56:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 597E83C1
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 12:56:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4B8A2608AB
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 12:56:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FAYeY4YjsfzK for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 12:56:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 86B9E6069C
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=80.241.56.152
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792673770;
 b=md6QdvlWzTr9NT7Jd0H/TuyNpc27mb/CKWh3zHJwvo2nLm3ubRdZaLdcTlniE/BDVaam
 sTwIim31JpobsU4xBrUvHUbvGjE1TabVmjDUgugxTOoXp1StDgxXKkcda9euN/bgsqjLL
 vKZRYmW7wJqCW/qSrzUbHzL7ehJYMqBAoPO5hIBH4FzvYwZF3o1DKRZq+BFDIjlbhhkp8
 OX/VAtaP1GMsrPf75VAVY/Dt0bwwJV5UdqZtq1vQ1PMg8GXmvqaCsW4Sct3bStKPtDmzr
 nsqcg+QnLE5iUJ1zHZoWu132m3i9kAYgNYH0hyORFPKXsCs5Bh+IlvzhlUZeRwT43Lw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792673770;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID;
 bh=yROv6GKBuM2oalzjhgFkFKARAFqMUfP+ii7aC8Mp2CY=;
 b=hCwW/+1GBRk9nn7jqcZpQZeUjtWbCGlZTSc6Yvi5Zf1rc6KtGVVgql92H2Ltf0EACHI4
 VYI2jrI+4NAjuJ4gNav4OUJp3e7XEKXHbj+dD1UnNPbLkvh2yPqQzoQ6HNTGg219PCMoD
 q2G6cFF21DOdLeKwUhPN/oamJM7HCzPjFrkG2mW93NlyBGrCnwWcC2W/zZUfQkDqnTpcA
 34g2Hl05BI++DuKQYzsfIKYttbhtMe/Bpf2U3tRsnyIZxqBVyPlnwHc9pp2olNw0XjYhl
 riqEBsrbjnBFYI3EBdEPiWJs25Af86qQjz2eM+LE9Gx66ZcZFbrFn/grNTTjmDA0QCQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=mailbox.org;
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b="RYW5E/ci"; 
 arc=none smtp.remote-ip=80.241.56.152
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.152;
 helo=mout-p-102.mailbox.org; envelope-from=marek.vasut@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=RYW5E/ci
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 86B9E6069C
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 12:56:10 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4j9R3W0B0PzKnDD;
 Thu, 22 Oct 2026 14:56:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1792673767;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yROv6GKBuM2oalzjhgFkFKARAFqMUfP+ii7aC8Mp2CY=;
 b=RYW5E/ciXu6hys76C5quYDKSye3jfLv1jK8vUTQrrEvEO4+vCJmPfAh4v9p0plPd+kprS+
 6WRGAfUbgnuAhyUGncrQnpguTaWIs9FSs+CkeDNYo7dQSCFUMXeIAakoE0Fw8kunXTjmue
 rBkInkkbLtG1yq+9au0Vj6LDjMrG1cURXL4GSRrJG8p3wQe2KKfhThmDD4/Ucyx+Er0BYH
 OLgLfQwWekA9i6QnbeHQUIUR2xPKtSTWqo5N6ebvZm1vz/sJ8msW13Lw4bPC0alXx1ETlM
 IvmLMHJvoQvyxWea4K0oSQpYJZ0A+X7vFwN7uSge0X+NtR9qs2WKoQV/k3SHZg==
Message-ID: <84d1c7ca-39b2-4f87-859e-ecee9051dafe@mailbox.org>
Date: Thu, 22 Oct 2026 14:52:34 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 08/10] usb: ehci-vf: take the register bases from the
 device tree
To: Mehmet Fide <mehmet.fide@gmail.com>,
 Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@gmail.com>,
 Stefan Agner <stefan@agner.ch>, Francesco Dolcini <francesco@dolcini.it>,
 u-boot@lists.u-boot-project.org, mehmet.fide@screeningeagle.com
References: <20261022122027.3571290-1-mehmet.fide@gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20261022122027.3571290-1-mehmet.fide@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: k6zpeqibyhuz915qyzw636rehijy69b7
X-MBO-RS-ID: 79513605bef891e4652
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/22/26 2:20 PM, Mehmet Fide wrote:
> Hi Marek,
> 
> On 2026-10-22, Marek Vasut wrote:
>> Mehmet, would it be possible to parse fsl,usbphy = <&usbphy0>; DT
>> property to arrive at the PHY node instead ?
> 
> Our mails crossed. 8/10 reaches the PHY node through fsl,usbphy already
> (dev_read_phandle_with_args()); the alias only gave the index.
> 
>> I think you might still need the portnr sequence number, or could you
>> get rid of that too ? (I would be fine with a follow up series too) ?
> 
> v9 needs it only to pick PLL3 or PLL7, and reads it from the clock of
> the PHY (VF610_CLK_USBPHY0 or VF610_CLK_USBPHY1), as in my reply to
> Krzysztof. Dropping it altogether means enabling that clock through a
> clock driver, which U-Boot does not have for the VF610 yet; I would do
> that in a follow-up series, together with dropping the
> board_ehci_hcd_init() call no Vybrid board implements.
I am fine with minimizing the dependency and resolving it altogether in 
a follow up series. Thanks !
