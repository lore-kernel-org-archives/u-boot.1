Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38F29C79F85
	for <u-boot@archiver.kernel.org>; Sun,  6 Sep 2026 13:00:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BBD2880D23;
	Sun,  6 Sep 2026 13:00:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vYJeT5FLBDec; Sun,  6 Sep 2026 13:00:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 8D96980D1D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788699609;
	b=ckE3N6f9yx/JEhaPOmPtJTdf75JoVU2Pvif0lt0u+RT6dVVrdsnndi8EXvWIZD7NV+k9
	 4hBWKmlbbagtAetdvRF98gP/3iNdNSX5kjGeVbJxTJ5Bhtt5X770h/nGXFeDKdg0Fuf2R
	 plvCPv+95pOnx7ro05v2y/jstJzuEMT7IpZemVvV/WTBAb2nWhCGjN7YZoaIW82wshtxj
	 UAuQ4T+qteil4zh+/HwMAW2N/Fs7cCa+RX02MAJaHHr+ZhLkSMa2sevLdd1qW5L+YdHxx
	 GcA1XhlyWljG85PlVjwtwepwx3MifsbLkvaRRr/x1TkUdroDVSiLYX0zpK7+V3CWemw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788699609;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=FOWMMucUw7/d/jgUqTRy0LIjXYOcktuM2cgwlU9L0r0=;
	b=PTHp2lUERSloA+7i9P7kLI4RFPPw7T3xhU6p2TlD9aehefdzhiWRRfPZ0AraSwT9bvG/
	 pp33Yr0LmP1SW4eAFPuApTKapFR6T8Kv5gE3wwv3YDgdHRTsNk2CMjf9Xq6p48Ll9m1/V
	 NmQ/hV6DGlai6PEbd+ptY7ZpoCn5B2wCfeGb28XSiIeVYCpvnwEFSBy9W0zcTNJUfVa8n
	 mq74kIoo2M6P3vdiuKuhRKExAUp7LeXuPweLFSoatMzP/sae6Tcy+ZhJW5Zol3pi+bTaq
	 WhXaxjOfKAiJ30G2jQrw54dp4duH/7pObywtTVGZO4SVjISJ/9RDqeQpx9pu7POIPnA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788699609;
	bh=FOWMMucUw7/d/jgUqTRy0LIjXYOcktuM2cgwlU9L0r0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Sdu3yMG8qQ3vY26f1sCms2+gQiy0tztRziYcRCQbxUmJYmRvOsYiNtq8mDxbi8Qkk
	 KYxxkp9+fG79xOPzKoyZPDUvQXDbubdUCqMWtJBCXEf4U/U5GpplFGFa8lvKpt2z8t
	 EPPguaRVlBOuRpQAD6QTBKiluAEfYEyTe27BqSAyTr66jy9wv6P1xviA/ajC37n3la
	 tH5dhEK4PONeuvBDDX/JeTPSCXKyo+Zze9D4kXFM+E0U7X6ocsg1hB9kibGKehquQd
	 i+CTpCm6ZIwwU6uxPdfe9HEpGUbOSJNYyiKHciuVhacHWJHkCJst2SsTVIfHkE4ALe
	 c2Vupuwabe8Sg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8D96980D1D;
	Sun,  6 Sep 2026 13:00:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 216F62C7
 for <u-boot@lists.u-boot-project.org>; Sun,  6 Sep 2026 13:00:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 05E1D60656
 for <u-boot@lists.u-boot-project.org>; Sun,  6 Sep 2026 13:00:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jsTm4h4Hd1Cg for <u-boot@lists.u-boot-project.org>;
 Sun,  6 Sep 2026 13:00:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 0ECEF6064A
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788699607;
 b=BeRjy6rIgwkiXfG3LsKresBL6xOi6YK0aC73pnySNS5br/ooK80Ne/DvjVU1pMSWFLN4
 Vy5opLMs7r/5hvMmOphp7qA3+qIUtYucg4wp1522uaYaBcohnMLTQ5UmdEQNXco/KwbhH
 xKX5H2HBX8ILdWVBhl6ZEc5FiBhYjoO+Ba3XX9lFXajFD1Ihm9E5ZrOwYP23gTs7m6ARZ
 HTeJa+BNLxXvBF/qi0LGKMB4imDdKgyvV4PjPC1j1D+NHPiRZ2Dja/b+mLdpOHWM2nNuB
 VRCCv74ua15ncq+C0jqck6o8dLMEDivdjqRdUMpe/l5a4G6KyQW126QIoQLoGqPoYUg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788699607;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
 bh=FOWMMucUw7/d/jgUqTRy0LIjXYOcktuM2cgwlU9L0r0=;
 b=nH84wwN96piOge1C9uRkjPS/7Fjpi7U+xqFiFc5quPNYBRAvullPj8uXmJoWhINruQAw
 g9P62H5pc2ArWEdcpmFnVwdgwwbia3pcna1YOza4PuLcNOP1AIZoFMWy3c2WLy04Psyau
 7pOMMI4jTWCEZlkJMt8GjXVw8HqClg0jh/PdTvdt/kvnlblI7rBhYEs7d75Of4Hkd1qVC
 11cjusSqboVXcMxO3kHyE35X95A+beHUuWnL23B3zH6AGUCK04RAlb3PgVZb+FlIxe7dd
 51YlvzmYbLHkhDRRBLYUQ8trH2kRxFvYsO0IHsCg1coqH5kXyD9dA9YIyST1h3+/A9w==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=ekrIcEnr; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=ekrIcEnr
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0ECEF6064A
 for <u-boot@lists.u-boot-project.org>; Sun,  6 Sep 2026 13:00:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id EDA03601DB;
 Sun,  6 Sep 2026 13:00:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A12DF1F00A3E;
 Sun,  6 Sep 2026 13:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788699604;
 bh=FOWMMucUw7/d/jgUqTRy0LIjXYOcktuM2cgwlU9L0r0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=ekrIcEnrKPnHp9yX5N55wEjnpEu4S0KE0wOeEEDWfqWtGUjcoFmvGw0gUAEdYlUux
 mapzQb4fxAdOSJxR9xhO5LdTOfqHPefdCC0Kadkn9j66EOlIamHE6Vc8Z75uX95n4F
 fqFoSf64l+fV/ntCrmjCMXhm9URHwiBZbLe964wqQnyTfa2YjUD0wT2/jejeXQOLAX
 DaspHPyrN3Kmo8erLgTPNaIrgmuiu6ffG+S/JQrYpEAQdOyG5cuD9tJaG1++leBott
 1lwNd0ZUpaj4cjR0ivvOpT+6Zvnbx55VGnHcq93PIOKbiSK8UiFF466MKYc65o85sc
 nyncTwjW1dH6w==
Date: Sun, 6 Sep 2026 13:00:00 +0000
From: Yixun Lan <dlan@kernel.org>
To: Eric Chung <eric.chung@riscstar.com>
Cc: Tim Ouyang <tim609@andestech.com>, u-boot-spacemit@groups.io,
 u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Leo Liang <leo.liang@sifive.com>, Yao Zi <me@ziyao.cc>,
 Wei Fu <wefu@redhat.com>, Huan Zhou <pericycle.cc@gmail.com>,
 Guodong Xu <guodong@riscstar.com>,
 Raymond Mao <raymond.mao@riscstar.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Anshul Dalal <anshuld@ti.com>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Johan Jonker <jbx6244@gmail.com>, Sumit Garg <sumit.garg@kernel.org>,
 Iker Pedrosa <ikerpedrosam@gmail.com>,
 Alex Elder <elder@riscstar.com>, Andre Heider <a.heider@gmail.com>,
 Trevor Gamblin <tgamblin@baylibre.com>, oyst.lnx@gmail.com
Subject: Re: [PATCH v10 01/17] spacemit: k1: select boot device via config
 registers
Message-ID: <20260906130000-GKA2330@kernel.org>
References: <20260824-m4-v10-0-5e0adcb1edb9@riscstar.com>
 <20260824-m4-v10-1-5e0adcb1edb9@riscstar.com>
 <avkysazihbgjh2vsdad4mgw26zhj6y3pdtjbdrwghm5qko4ccg@mggxixrzezuo>
 <CAH22mJyZR5y6AUt+DvB-K9fCR=S1PFo3F0EqvV_9_WJike+tQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH22mJyZR5y6AUt+DvB-K9fCR=S1PFo3F0EqvV_9_WJike+tQg@mail.gmail.com>
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

Hi Eric and Tim,

On 16:15 Sun 06 Sep     , Eric Chung wrote:
> On Wed, Sep 2, 2026 at 4:52 PM Tim Ouyang <tim609@andestech.com> wrote:
> >
> > On Mon, Aug 24, 2026 at 04:50:36PM +0800, Eric Chung wrote:
> > > Add logic to determine the current boot device by reading the
> > > SoC's configuration registers, rather than using a hardcoded
> > > default.
> > >
> > > Signed-off-by: Eric Chung <eric.chung@riscstar.com>
> > > Reviewed-by: Yao Zi <me@ziyao.cc>

..

> >
> > Hi Eric,
> >
> > I previously said that I found no obvious issues, but after taking
> > another look, I noticed that read_boot_mode() is called twice: first
> > from board_init_f() and later from spl_boot_device().
> >
> > The first call returns a BOOT_DEVICE_* value, which board_init_f()
> > writes back to BOOT_DEV_FLAG_REG. The second call then incorrectly
> > interprets that value as a BOOT_MODE_* value.
> >
> > For example, BOOT_DEVICE_SPI is written as 8, which does not match
> > BOOT_MODE_SPI (0x55d), so the second call falls back to MMC1.
> >
> > Please keep the BOOT_MODE_* and BOOT_DEVICE_* encodings separate.
> > Sorry for missing this in my initial review.
> > --
> > Best regards,
> > Tim Ouyang
> 
> Hi Tim,
> 
> Thanks for catching this issue. I've fixed it and submitted a new
> version. Please review and merge the new version.
> 
with spacemit custodian tree created [1], I think it's more proper
to route patches via there, I will review the patch in next few days
and setup CI to test..

[1] https://git.u-boot-project.org/u-boot/custodians/u-boot-spacemit

-- 
Yixun Lan (dlan)
