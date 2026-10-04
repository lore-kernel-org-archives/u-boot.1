Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 993AECA5FCE
	for <u-boot@archiver.kernel.org>; Sun,  4 Oct 2026 19:59:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 486E5605D0;
	Sun,  4 Oct 2026 19:59:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZaLNE4KF2wLZ; Sun,  4 Oct 2026 19:59:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 62BD360614
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791143944;
	b=mVaRzRuClD1PchEnFOJFe5soYKroTAsXsC/h6+ccbf+GPIQqvNDop3PJWE/qV3l16N23
	 ctj+YMDEH6k9A2s6hBOlClrTdhZmlRD/jC3hrIcXwCwND913cfxjdtBOLpONXyUaWmZxg
	 yzDbxph5MeRw/lHmCVXPyP1/7o3oreHIo375iJ0ewlji1EJF69VqmLgd/nCiMOXdiF2YU
	 sqkDkXhJ8250+ghTsrg4gkP//3yOpGGcHKkR9uBxdilyH/ls+M7jAJ0ORny7LYX0mEuhW
	 KIDAuywu9pWBjmbf9mkhhlqTbniiVG7VSnoYdnQJW948NDYb+YcMQnEQuGpa31WJVDQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791143944;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-Forward-Email-ID:X-Forward-Email-Sender:
	 X-Forward-Email-Version:X-Forward-Email-Website:X-Complaints-To:
	 X-Report-Abuse:X-Report-Abuse-To:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=j4baLdqXTQsMO1o5/F3NXOIGcLf2oYZD6uJqAVY8x2Q=;
	b=EbzJbYOFZ9xU/J5lhPyGR9gIV5Alo39KTunmW8C+Y9sd6xUGhD8Uwh+JM/Z/nrrUTo0d
	 tR4WedR7n7WLlTIrvLIaLg8XXf5UB7ruw6a+pxFgZptq7jbVaaBEta237HMMWd4eD9YSz
	 5DXamiFr6ym2/RPevwjQ9m2RJSEDGRziWpeK1SJHFwBmnPbUMR9no67sS0bc4NrTn5nJq
	 NjWc4Iyc9WtKRuw8cYthxhxuTyBf+w/6kQmiWAwJPyb2ENDDygf1MhU5L/mokc7Ypauhg
	 OgdYYClaItIAnL0Nf6SWM2S+t8pHZDGSg2I35kx9Qlbv2k3bql+SLjIKfe88DXIo01A==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791143944;
	bh=j4baLdqXTQsMO1o5/F3NXOIGcLf2oYZD6uJqAVY8x2Q=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=x8EmcY9wQoj7WIlNCXdDfi64fBaUx1uahejZOpbjgns34wQR0vhCAXGaU8m0KJPZp
	 gX9wYe/cNWzAxEFwbACfgXopvJUuhf513Uj4vnPr4sgxWsFoV5e7JRKaK67S1dBDsn
	 RM5zsVB1ssC1dhkr95TRlrOfzgJugmN0j0nNOabAdkgKDWPYLc0vleJeI+3TpJHL98
	 OYqsxb2/NQLgatWMUGE/KeM0y0V5XWF8P2AaGg6PFAUJ/IIgt08wOhyIj001sge1eE
	 +0FMums/+JSOQZAVGwv4Fqax6wZaI+zzhP/+BjCnfaywP3oAD/7PMKlR8If6slX94A
	 GSSh1Y/EBMqfA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 62BD360614;
	Sun,  4 Oct 2026 19:59:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 840DA32F
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 19:59:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 69AFD40075
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 19:59:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tyqoPyTVXzFP for <u-boot@lists.u-boot-project.org>;
 Sun,  4 Oct 2026 19:59:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 9F3074002B
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=121.127.44.73
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791143942;
 b=JjxRxn+uunCc8RO5hzHR6SSuEuPga/Zof8Mg7cmHdUnDoFZsuginajm5F3RkOzXxN5Rp
 ekMgRVnaGd6FdBc6R4Dqei4YVfgnjN1Euqh+LkK5vgjTDnQiPHUA/Z665iRIJ1y0UbT+U
 /l3z/awmLtEzrOugnFkyQKMkKdqu0YihBTChsUYeM3sgmikLxfki2aYzLu707zuHdzVaj
 8+gnlHQ4JAIoLAEmzO5b/FRsD6A7i8CUCPI4QvouBQaC0iZAtrRtiA5Jmo20VC+onknUe
 DOti6Qx9Epu4AZotTbi+nFvIjdypFRpeHY/ihj5ks6jQsV3tX5uM1l3xoQZWzceGZ7w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791143942;
 h=Received-SPF:DKIM-Signature:X-Forward-Email-ID:
 X-Forward-Email-Sender:X-Forward-Email-Version:
 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
 X-Report-Abuse-To:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 MIME-Version:Content-Transfer-Encoding;
 bh=j4baLdqXTQsMO1o5/F3NXOIGcLf2oYZD6uJqAVY8x2Q=;
 b=l1raBY3a7HLQ2Pe/gCIABrM1lCZw3aOTasrVPxD9TNZXASe4HVNY8mYzrVQFfFlCjeu9
 CgT5Uvz6O+TvxTv87BGk5DMeK7gmas1K6sOPS5F9sVHI2lQ7R92hFpj+elSh0CQs5sb33
 PV83M5656q67RbmmCU17qMiT9mpHTm6LegMqEbPwHClibLMWVNW/IrTI7Om4Pv5r8e6nU
 10VaTqBQ16X1y3q3Wu1+4+F6aESyfAqcNH2FxZ/rGKJgUwVxAVludDUfW247pJe9f0CpQ
 /UHctMUbALu6ZsX62Lj3fSzGLg1JvERwDMdqJaGHCrcsZlyWeFKJy+q/lnZrDdIExKg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=kwiboo.se; 
 dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=TbBjjUMq; 
 arc=none smtp.remote-ip=121.127.44.73
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.73;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=8573=h3=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=TbBjjUMq
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9F3074002B
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 19:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1791143939;
 bh=j4baLdqXTQsMO1o5/F3NXOIGcLf2oYZD6uJqAVY8x2Q=;
 b=TbBjjUMq6rZHhQtPR5dGcV5l3KfylcujZ9bDOQ1zuvH2XHNM+GNV/o8U8QmcYneDJL9zA8JIU
 ww9j1zdZTAqPDLrhp5InFfIieXOwkzSuMURd3G0LalK1F6Ir1RgWg9YJHxCmMiX1gpmjFD+NvB9
 KBIraRd5oJCQ4V1EWo7Irg8MpVe+wfHAZpkuV9AjeSQarTpUaIn6rrI2TPZjYHpNEdluPrYW9vN
 MyBZWFLSZlVdWz5MPyfZJFTuQLAELYnSbYXkBLpZ2GyA3qsa4bYuYE/BFfZyWuTdN5L4JX1LY+1
 8A291U/J97hFKsp4QquhA98EdV8/MoneBT7/PJ4Y19PA==
X-Forward-Email-ID: 6ac2b001550bbe43c208e088
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.18.1
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 0/2] rockchip: mkimage: Update init code size limit for
 PX30/RK3326/RK3328
Date: Sun,  4 Oct 2026 19:58:50 +0000
Message-ID: <20261004195853.59863-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

mkimage is enforcing a smaller init code size limit than what BootROM
can handle on PX30/RK3326 and RK3328.

- PX30/RK3326 is limited to 10 KiB when 12 KiB is supported.
- RK3328 is limited to 30 KiB when 32 KiB is supported.

This series updates mkimage to allow using max possible init code size
supported on the affected SoCs.

Due to end of SRAM typically being used as TPL_STACK, use of the fully
supported init code size is not always possible using current defconfig.
However, if stack and malloc area is placed in e.g. PMU SRAM or in the
BootROM reserved area the init code could use all available space.

BootROM on RK3288 can support up to 80 KiB init code size when loaded
over USB, however only 32 KiB is supported when loaded from MMC.
So current limit of 32 KiB have been left unchanged for RK3288.

Jonas Karlman (2):
  rockchip: mkimage: Update init code size limit for PX30/RK3326
  rockchip: mkimage: Update init code size limit for RK3328

 tools/rkcommon.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.55.0

