Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F9D606A31A
	for <u-boot@archiver.kernel.org>; Sun, 25 Oct 2026 19:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Kyg0g1hI;
	dkim=pass (2048-bit key, unprotected) header.d=iro.umontreal.ca header.i=@iro.umontreal.ca header.a=rsa-sha256 header.s=mail header.b=GsHwrwUM
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 05B0180A56;
	Sun, 25 Oct 2026 19:37:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yGfxbyeUy7Z4; Sun, 25 Oct 2026 19:37:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 33B8C80A4A
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792957067;
	b=MCz7V/I+MQysosjZwAPDSO0Ne4UVVSJoArYOo59vUr2SulpKjsdevBg1Xm4mgSSTbrwa
	 OtYawkZFkAt1WbsHuzlk8yKh9o2lRS9mMTUwJoDs66ZKfKYa+Q46mHQnZ4Tv2/pFSu6zs
	 beZjzjrksDhLbNBQfXooI81MPnAutMp0cYanMxPVIK9lzTRCXCI4cfqEoxGPB39T50ydK
	 I4VeJNa4gHBguZHHpO7YfNofAtTCkDpPIDJApqixHyN2kVxQ7ZvvuGiikCnL6eOddn6Pf
	 /H4Pe4vXFbQRhCNUOzdlWSQGkd0zLEd4FJsMmPIQT8WhnXtIT39vIoe3UXSe66kVcSg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792957067;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 In-Reply-To:Message-ID:References:Date:User-Agent:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-SPAM-INFO:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=oSm/RjrMPTReDBahDnXGrIzLR5/wpV4Sdpy0DJsK8o8=;
	b=mHwinLnjCTyJQpjkHuMZtPb7LCy81F0pbjSv1PJgujRyuXg/3Mg1qD5qmBPBYn8SBiS3
	 qcfA+0q9ZP4W27H/rXWupMMWOFiIyY0jeTRWyPati4MhxVTt8rZcEP+5EIzsPXxZPT2SB
	 7/oYqOK+K6WriIkOK65AfjF7wSQ7zqcWxoWcJ3+dJflyVSHwfu40/okrOm1n8jCaeN6Z7
	 lxEGvzw3Fg4jwj8jpN8XbGyXRRk6yWh7k2G1OgsdziZ412UIP9JBMTTmCpsuw1P8VQBg2
	 ZW/dElzVu5lBK+b6rPymGOm6PHqaxcCxE3cahpZf7RtJMn/i5YWw03XqaRIKkzqT1iA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792957067;
	bh=oSm/RjrMPTReDBahDnXGrIzLR5/wpV4Sdpy0DJsK8o8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Kyg0g1hIiDZVSscuBWdLhe8PsNex1FCP9mQLiw2OJ21/k8alJG8fypFxKC/dBe0hc
	 sGRWxQZ/USm3MkqYinyId+4KZ6suSxZWKnO7y1grIziCtfmIEhtGztARAkmQpeBVOX
	 ycorC5CuBHitph+bBLb+OoyR/8aEzavogWFZ1y8pSCa64CxD26IBUI1AOjftzv7FzD
	 lepRoGzrv3iA9yDXR1jlMu2BaU7homQUGdzViMvmxLE8L06wLY3zG96xdzWFfN3jTb
	 V3yS0fSZHCXkGJYJGLES+68HizpocU/NdpjxGzUOx7W89iURwa2pPHUe8q5nUd0wiA
	 rHSUJTvfSM55Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 33B8C80A4A;
	Sun, 25 Oct 2026 19:37:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 9FC063AF
 for <u-boot@lists.u-boot-project.org>; Sun, 25 Oct 2026 14:20:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 85DD540C70
 for <u-boot@lists.u-boot-project.org>; Sun, 25 Oct 2026 14:20:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NaxZUJRv_d0B for <u-boot@lists.u-boot-project.org>;
 Sun, 25 Oct 2026 14:20:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org AD39240B1B
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=132.204.25.50
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792938007;
 b=Bzp84S2Fd3pt2KAL6sUJkIwdAolu4bSZVpweGeKwtQnULHPWXz2EUan9pGTp25MD7tC8
 Fdt9ruzPdgxA1fqghKnzzQhpsB8v/ruVPLj5gjh3T+qLdA5tJvXAYPIvV0dQvUG3jESUn
 M8XmMckr+1RoruKw+dALpujhHPHxAAMr5dnyRwzWje49Xp3csglGxBtSdu9atutNjQZTV
 Cxa9PfRZG1nixYof716BFRvK/+ltYr/FTFGOUYBSasqnNeUJvnKxQtwt4Aqh26hD6Zay6
 6HGplS0fUV/sjQto0nBGqygibpgnZ8FCDnhP+jS02dfQtR67loKFb73j4CSngrguxug==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792938007;
 h=X-Greylist:Received-SPF:Received:DKIM-Signature:Received:Received:
 From:To:Cc:Subject:In-Reply-To:Message-ID:References:Date:User-Agent:
 MIME-Version:Content-Type:Content-Transfer-Encoding:X-SPAM-INFO:
 X-SPAM-LEVEL;
 bh=oSm/RjrMPTReDBahDnXGrIzLR5/wpV4Sdpy0DJsK8o8=;
 b=pmEYeLZGRlxnNxjIcB4lNKFfj1dtgAB+z0pDCTX/bhOUkUvvK/5e+fe3GlBbq2Ovb0Q1
 ZS/DM99T8ZHcLIxWGZvwCRcs/bppudWkUSquwyZOdSm6VIYKprtPxkW4WJ7THUDEJz8pn
 VXN0oVJfHsjh0iAhqPQj23dUHHElTxcGFTrtEDHvWyKUGaFh1rPcX8yZvqU+E0e4nz9Bl
 frkHsR1br8To0urJ4J6QCjkRv6bsE7BHBNHmjMN8ymsMrRCsq/siY7l3QHzusTHOyr86e
 p5uarV8Q7ampmv32Nef+dLANBanYpscaySEnUKR/nYg0sxaaiDo2VNoYUg7aI3wiXlA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=iro.umontreal.ca;
 dkim=pass header.d=iro.umontreal.ca header.i=@iro.umontreal.ca
 header.a=rsa-sha256 header.s=mail header.b=GsHwrwUM; 
 arc=none smtp.remote-ip=132.204.25.50
X-Greylist: delayed 587 seconds by postgrey-1.37 at util1.osuosl.org;
 Sun, 25 Oct 2026 14:20:06 UTC
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=iro.umontreal.ca
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=iro.umontreal.ca header.i=@iro.umontreal.ca
 header.a=rsa-sha256 header.s=mail header.b=GsHwrwUM
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=132.204.25.50;
 helo=mailscanner.iro.umontreal.ca; envelope-from=monnier@iro.umontreal.ca;
 receiver=<UNKNOWN> 
Received: from mailscanner.iro.umontreal.ca (mailscanner.iro.umontreal.ca
 [132.204.25.50])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AD39240B1B
 for <u-boot@lists.u-boot-project.org>; Sun, 25 Oct 2026 14:20:06 +0000 (UTC)
Received: from pmg1.iro.umontreal.ca (localhost.localdomain [127.0.0.1])
 by pmg1.iro.umontreal.ca (Proxmox) with ESMTP id 0B6FF1000AA;
 Sun, 25 Oct 2026 10:10:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=iro.umontreal.ca;
 s=mail; t=1792937413;
 bh=iFxQirg67hy873pb6K6U14tvEn+VtzRi6dp/mTg72m4=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=GsHwrwUMiPWKUB9LTxQfQ2JydwzuhhHTEKG5zYvE2N2ajPkjSIgt11oPfiqF5q593
 kOETbB2YO4uKJaYYg1meCtTGlX2qVoU5YJ2lsNh4rb/Nzgtx08GK6l3UMhjjqkB0bQ
 dTgKvNYt3JJ5Hy4o0wxmRQQA+hk3QhRue+mjnExJ/BNB4JXYTD/YzmS76JmBTvAODY
 0unWbCvDM7RbtDdpyJX3EBUHiIX7rb1uT6++4qekcqCBYF0Kgm9DF5xN9uayVoCqg/
 oznvid1zPMVoPfeTVIXhpnOWS3HcIvE3JP0OXmBNCgFzg8BOKjb4ImslMW4q++WdIJ
 vWKhC+BjYyZCQ==
Received: from mail01.iro.umontreal.ca (unknown [172.31.2.1])
 by pmg1.iro.umontreal.ca (Proxmox) with ESMTP id D7AB7100072;
 Sun, 25 Oct 2026 10:10:13 -0400 (EDT)
Received: from pastel (104-195-217-152.cpe.teksavvy.com [104.195.217.152])
 by mail01.iro.umontreal.ca (Postfix) with ESMTPSA id 7685E12045A;
 Sun, 25 Oct 2026 10:10:13 -0400 (EDT)
From: Stefan Monnier <monnier@iro.umontreal.ca>
To: E Shattow <e@freeshell.de>
Cc: Marek Vasut <marex@nabladev.com>,  Alexander Koch <akoch@initse.com>,
 David Lechner <dlechner@baylibre.com>,  Flaviu Nistor
 <flaviu.nistor@gmail.com>,  Miquel Raynal <miquel.raynal@bootlin.com>,
 Takahiro Kuwano <takahiro.kuwano@infineon.com>,  Tom Rini
 <trini@konsulko.com>,  Tudor Ambarus <tudor.ambarus@linaro.org>,  Vignesh
 R <vigneshr@ti.com>,  u-boot@lists.u-boot-project.org
Subject: Re: [PATCH] mtd: spi-nor: Indent SF: just like other boot time
 messages
In-Reply-To: <0c4fb416-62e8-4ed1-b7f0-a8021092db59@freeshell.de>
Message-ID: <jwvqzhdho45.fsf-monnier+Inbox@gnu.org>
References: <20260611224544.210172-1-marex@nabladev.com>
 <jwv8q3ni16j.fsf-monnier+gmane.comp.boot-loaders.u-boot@gnu.org>
 <099f49b0-2704-4ceb-a730-92107bd09643@nabladev.com>
 <0c4fb416-62e8-4ed1-b7f0-a8021092db59@freeshell.de>
Date: Sun, 25 Oct 2026 10:10:04 -0400
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
X-SPAM-INFO: Spam detection results:  0
 ALL_TRUSTED                -1 Passed through trusted hosts only via SMTP
 AWL 0.127 Adjusted score from AWL reputation of From: address
 BAYES_00                 -1.9 Bayes spam probability is 0 to 1%
 DKIM_SIGNED               0.1 Message has a DKIM or DK signature,
 not necessarily valid
 DKIM_VALID -0.1 Message has at least one valid DKIM or DK signature
 DKIM_VALID_AU -0.1 Message has a valid DKIM or DK signature from author's
 domain
 DKIM_VALID_EF -0.1 Message has a valid DKIM or DK signature from envelope-from
 domain
X-Mailman-Approved-At: Sun, 25 Oct 2026 19:37:46 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

E Shattow [2026-10-25 06:29:43] wrote:

> On 10/24/26 11:05, Marek Vasut wrote:
>> On 10/24/26 5:14 PM, Stefan Monnier wrote:
>>>> to the fixed indent:
>>>>
>>>> "
>>>> DRAM:=A0 3.5 GiB
>>>> Core:=A0 310 devices, 34 uclasses, devicetree: separate
>>>> SF:=A0=A0=A0 Detected w25q128jw with page size 256 Bytes, erase size
>>>> 4 KiB, total 16 MiB
>>>> =A0=A0=A0=A0 ^^^
>>>
>>> I'm probably not the targeted audience, but FWIW, I find the meaning of
>>> "SF" non-obvious, so maybe instead of adding spaces, we could use those
>>> 3 extra characters to come up with a slightly more
>>> self-explanatory abbreviation?
>> SF is SPI Flash , it is used all over the code base.

Yes, that's indeed how I figured what it meant, but it would be better
if users could figure that out without having to consult the source code.

> I also find the meaning of "SF" non-obvious, and nothing better comes to
> mind to abbreviate it. You cannot get to "sf" command from "spi flash"
> or "flash" commands. If the probe message would say "SPI [NOR|NAND]
> Flash detected ...." or "SPI: [NOR|NAND] Flash detected ..." it would

How 'bout

    SPI:   16MB flash (w25q128jw) with page size 256 Bytes, erase size 4 KiB


=3D=3D=3D Stefan

