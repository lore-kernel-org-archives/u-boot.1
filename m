Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E98E9C88E4C
	for <u-boot@archiver.kernel.org>; Fri, 11 Sep 2026 09:26:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8951A40B26;
	Fri, 11 Sep 2026 09:26:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id A6g40dTrZ9Ex; Fri, 11 Sep 2026 09:26:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org A9AA540B05
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789118764;
	b=Rel7JnarfQbNo+BT96pKWTWMHEWzzeQByTv3T/ZaJdL3/YK3NbWw7Y///u+kHNGupyom
	 I3Z3E6DT/wB4Zi2DkJEkiUCeMRzB+KmC+QJr7GXbmloPzMOuUg5iSRZKJ82AEaBhCtX7j
	 JCN+g6yGgvk1oMAS0WTLEMDfQixmOUJhQDu83tZD+b7XzWF0EYJrpHGvn3RXNCFcRbF5u
	 EwPqwb0iOegxUc6s+4/EgQYy0khmkuBogEzxhq+G/3R0UArdTU5DotNdtYteGWrdj8T07
	 NeN7QBdxkom4YYeitxAMbYp422xJdk4D1TRoUyOSwJNPH2LcKFrV4Dyhnh/CA/PitDA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789118764;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=44DUQSr023KQZ/cs4J3nnnlMRoLUNFC1i4h8xVauzYM=;
	b=ajb1PIkfbP+RaMEil/CRuyS7/4mQiUiaAl8euLX9OIj6H0zqsTMXmoSdthQTpsyQqvPe
	 yOPoZ9XmPS8ybIvvRT3zuzei97nHyTDqIlJf/A5F8CgQVdieOWAXz3zxDOyJRmG0oAHwz
	 u8L4INU7ZxjxWP/AwbyFKT13SFCSE8x2cdmreO+7kNHKrU4FYmVwfJ7JUjPees7r2WUhB
	 0TD+RL96f2d3aL9zOQ33lrPE6//J9/PyN8pRuIXzEBJ1tObHw+iNwd8XQCdPkFHeBiOP4
	 eukXoGlJxPptjNFKem9LRbJ29ifKKIbWr16oG8Hws+0QE5WpAWj004ZfRhGayXWUJmg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789118764;
	bh=44DUQSr023KQZ/cs4J3nnnlMRoLUNFC1i4h8xVauzYM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QuvsTCHE//y3JvROkc7Xv7T3kJnhxdfHMJSZDdIQ5alAKEhxTPgIAco/FONVOV1vc
	 srHoQ9Ni7D3lUGzNRaEtEEbcT+34TIIdPQ/HLJvEzJ26X6wsi8HjqNAKRDEGLgsZNV
	 59Fepo9oa6x7zbvwCjDZi7HOR08eq900489PupDJ4gwSbx2BCaF20D042bNBFjTDnr
	 mQj2mdQwTuJ1jBFmwLgaIWbu8YLgV+JJG9AyxsbldB2KJSFybyu7nIjezaUOWBamcY
	 QJUpyEVvYmsxmzpvPMxlvuietTbRsIsZkmGu7UB40orNccC+Ll+EJRsLDINq28hwvT
	 KxLv0XiL++7Vg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A9AA540B05;
	Fri, 11 Sep 2026 09:26:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5A11F49D
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 09:26:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 37CAD60807
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 09:26:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pGPRhMZdjwvu for <u-boot@lists.u-boot-project.org>;
 Fri, 11 Sep 2026 09:26:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 74C4D607E8
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789118762;
 b=bfCWLCu79Thd6qFrqYCN97wPXV+wu0Ya6LnZHqTVBa43RZEEYlMbNZppfw6UkwofXZsP
 vB1amAY0DIOONAtn4dhESKzqvl5tUEKdthl/s1llKqzawaxdOEcuGtq9OIfcMBMa8L03B
 Hms6K+V7n2bsYjTaHtbwb/tD2pvySIcplgBtKtBxM4qkAM/xpt9j9dvBF2BEhFaBt8Pkx
 4BAPBQPsNAAkoX5WXaVeXnlp8fDCe0gtZFYycBCxzsD1YJE6ynDweggaFEwbY4QAKLDca
 OjFqXNBRPNEVCu9te1D0VxLO/bhs3ImCi2bbj0bEBufA0H1J+BrWuf3pa64NbItjS+g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789118762;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=44DUQSr023KQZ/cs4J3nnnlMRoLUNFC1i4h8xVauzYM=;
 b=JpvGXbnAWSTBUhNI7De4U/ixNM5sqg41n6VX4ulIzAccJaLeQEVJl26eoT9L81puRunG
 C4MZHnJxFDlsAoIDDku5AKPEBFJ1tExJwaZm+UOrR3uFuplggaLN7qjoAkADmR2yOZIjY
 0WaEuiGJg07O3GjFkiBefsRrX8GPCnFSYS+VS9wZLG93iN0TFVWhDo6Ahbu4vedKxAI5w
 o8uL+IPktBL2L6wRiOM2K2ElY1d63a/yJUvMfDBLOR6xAeOBHTDFWbYn2KAyNI8vpx8Gx
 qQkpLISBi8UXLxcUBOqhyl9a1zfqy2bHHQFPa+ikZEkLVXE/2DUr1D9OAuIWlqM5odg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Ft9ZhSNB; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Ft9ZhSNB
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 74C4D607E8
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 09:26:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1886E41413;
 Fri, 11 Sep 2026 09:26:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7812A1F000FF;
 Fri, 11 Sep 2026 09:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789118760;
 bh=44DUQSr023KQZ/cs4J3nnnlMRoLUNFC1i4h8xVauzYM=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date;
 b=Ft9ZhSNBzpRxYSfsZNUgKET+xFDSUequK8XwRli6uXjSrhheyMsdZPbzDuweQDu1W
 sPJNXeSNNcDY927i2wN09Z/+DFRogsgMOGuagQOHHGx4SZAJY0wjixAkV2gFFUF0At
 /4o9RC2jJDoRQAcQiCCWeCXYyFOrDP6Avj7EvEVrQX6FE6RPCFgcHn0TSON8hzcjMx
 gXjCIwbQ5nErtrvVR87XD5ry00IqGrGa1YV6sP9Aa7SfMzsRjV/InfsIJ/B8s7gs/q
 B3J+N+ZVRyPfQy23kPRVPS7cTQLNhKe7vfdYtq4buOCSoJ2tObQZHyf4zU2bBS0kJN
 tEvtreAfTwEBg==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Dan Tran <Dan.Tran1@synopsys.com>, Lukasz Majewski <lukma@denx.de>, 
 Tom Rini <trini@konsulko.com>, Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: Tejas Narendra Joglekar <Tejas.Joglekar@synopsys.com>, 
 u-boot@lists.u-boot-project.org, 
 Patrice Chotard <patrice.chotard@foss.st.com>
In-Reply-To: <cover.1788488867.git.Thinh.Nguyen@synopsys.com>
References: <cover.1788488867.git.Thinh.Nguyen@synopsys.com>
Subject: Re: [PATCH v3 0/2] usb: gadget: add SuperSpeed descriptor support
Message-Id: <178911875744.102286.17132958660285497598.b4-ty@kernel.org>
Date: Fri, 11 Sep 2026 11:25:57 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

Hi,

On Fri, 04 Sep 2026 02:29:22 +0000, Thinh Nguyen wrote:
> This series adds SuperSpeed descriptor support for the mass_storage and DFU
> gadget functions so they can operate correctly at SuperSpeed.
> 
> 
> Dan Tran (2):
>   usb: gadget: mass_storage: add SuperSpeed descriptor support
>   usb: gadget: dfu: add SuperSpeed descriptor support
> 
> [...]

Thanks, Applied to https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu (u-boot-dfu-next)

[1/2] usb: gadget: mass_storage: add SuperSpeed descriptor support
      https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/commit/bc6f3f4b3882fec3eb21457ccaed993b40743725
[2/2] usb: gadget: dfu: add SuperSpeed descriptor support
      https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/commit/6e3f574e576585b0250ac387475d59e581bb5d9f

--
Mattijs
