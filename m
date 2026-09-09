Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18141C79FAD
	for <u-boot@archiver.kernel.org>; Wed,  9 Sep 2026 09:03:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 453BE80D58;
	Wed,  9 Sep 2026 09:03:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ci8R9_LuXD0T; Wed,  9 Sep 2026 09:03:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 443AF80B86
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788944597;
	b=V+JRGTpcT6AI9ImHUR1MkH+DaIfvmk3XjF78AFhiTyTX0zO7YTnzu/aEI+ZtvtYmwMDu
	 BJ3SmQsBEFI7GqrCU73ZTXyERWxvwyGRu8YEY9J04NGxFnzhC8kF3ZvKXOdAtM5+bWgDR
	 QT3appIz5EMwbdf7ZMMoIrFjdrOqKCoBI/VSMOeN4dFP1o9X+Ff5aO1b2kjr5Z3tkCLzM
	 2/JY81805xhDginuLfRDxgIUvIYh59qahrMRDleLIisSk1lmX3VXTgaqlGl2hNpYA3E8Q
	 5O5UlT1lp8AxWgj30p8rq+BmbhYvLsUWakxa6LVS/ZFTPSUuiy7BxbAB0rv5GmMSAiA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788944597;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=Tgwd7LN3O7d0zEaruMLpfxmRIXzxdEVZsYD5AzQkd/s=;
	b=Db7piarJEmkJbF2diFIGq8rzHaCk32R/637vZ4OYvHxM9Zy7yfGw5/pqDa1F0Vn/Npby
	 SZQ1ypQyfl+nwZm+DJl9u6MKI/AKOpvcmzEMjF/d2nTg8OIhi7krGQvGLhTRsl3dB7OmP
	 5LEE4ekG5i0qE92G5TL6MH8RRPx8oJpWu4TBwpoS/LgLpWIy/kkEu0Yd58nH3BkJ1yk7Y
	 ScKItcTE5Qz6UPNOTW/sMTLhyGuQLkq93XKLfpDrsbErr42LNib2Pg6GcjdRaC4ByWVFO
	 EoW36PdROORR4DgaGrMjTFRQcqo2qGTbaBuDts2ijTcu+UuyAQaZQA6U4YRyy9Bat7w==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788944597;
	bh=Tgwd7LN3O7d0zEaruMLpfxmRIXzxdEVZsYD5AzQkd/s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=G3uh4MZNkDjy+jfXyJXDehRfeX1/BWagPYD+3NEp3iJvfPPa8sTfHsKBOl1yGZnKR
	 NzMo+q6VMMmbsM+YcrUO4tsxzYHHT7irEj3QEXsQmAuwEWVD3hA8JX9iw8k7SEY1an
	 G3MTDcWFz29UnSDl4MLwpOObuMd8XXCkp0/a8qJUUpHoBeuNzt7OC+ftPStYpe5E7x
	 aitCq99V6F7teo/AtfEYsW7trTPics7oQGxlRvyu90fIIcQmt04hXOQ1cuv0xt/oP1
	 QaJ8DgDHHvE9WB+Kd4V9qKc6Z66QLACXjHKWX9ebAhn+1P+llDiSza9tR72sB0ikyg
	 LE37s8awrwnJw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 443AF80B86;
	Wed,  9 Sep 2026 09:03:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 3C4AA49D
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 09:03:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2E9CE40055
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 09:03:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FAmH5w5EpOv4 for <u-boot@lists.u-boot-project.org>;
 Wed,  9 Sep 2026 09:03:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 6E352400AA
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788944595;
 b=kg/7wGI+7uoXEcP/hLXf0yQy/Rlbw024VYHPnhrb+MhXo0cjg4hnfzXUMsYEn5EHM4ZR
 4YltUzcssphsbB1wSsyrEYk867y3F2ujeVDxhFbg+DZ9B+kD8SyjOcOAlwIsmrA2Xie+W
 vhR4I7sg06+r3zIeHrUyycQF8R/Nudl/DkMORRGJ7gn+g5rNf6Hack22LawbwhASHqZlN
 O5Cx136JEv1BQp+y3fhKn1+FHw1e+dagKqb+sYIZAxOigKun5CDhYgiqpUNhZEj1EXl3+
 udi0rEKNAbipxJJoQ7osXDELGG4Pgxi9A+me2lmC5QMWwaswHiDOMu1ERTc/ARxThxg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788944595;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=Tgwd7LN3O7d0zEaruMLpfxmRIXzxdEVZsYD5AzQkd/s=;
 b=hdqFHB7wNjaiiJSVSLgNZHX9D+BLOsivqReNZGowpb2VxfGktNbyj9Q3bFJ1uYuqs4wA
 V12wd/0UkX+vYNR3EYJK5H12IDYrSFUn/AzuYKvI6danAuJ34G7rK3eUN4UvcUZteOl4U
 71WDmUqdGaeidFVi7Xky7L4wegosj6TdWko5YlKUHmrsJ3DVsu9yV9Pp4jLX2PkEBpNMj
 lo/sya0jKJq+ouk1LZyqlv+ndD/vnZxt95k9vt179QjccoKOHPIS2QxSprdPdb1zXbFP4
 g4v4wPQ7QXIAxLTNEy8dfJJFT7q1EAn3bQI+EO0uCZx82M5Q9Hmr6KzrtRL02ATuc8Q==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b="FxCJ/4gH"; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=FxCJ/4gH
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6E352400AA
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 09:03:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 224DA41E4A;
 Wed,  9 Sep 2026 09:03:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F6F01F00A3D;
 Wed,  9 Sep 2026 09:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788944594;
 bh=Tgwd7LN3O7d0zEaruMLpfxmRIXzxdEVZsYD5AzQkd/s=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date;
 b=FxCJ/4gHnBUhMy7ecB2Xvftxk6+TpNFCf1LdB/bEscGnK3mqzbCGreDpsq0u7IQAC
 jJnqBIBGCzAORJXpuiKgRthoDtBRhnOGChOBV54kSSt7lylM5xy9MDCpWPPC0Bd0bh
 m5WJh688vy5sUAmY64o4GoAMsKWCtzB9koCaTkvIOB7VINFL6phzGS8HpxhSe/99Gr
 n/LzsFT+j+ULt3lzn89EDYGJJ1/JLA5QbSlTNn0h7Oy/ckaMpfK2walywrM2cS5OGz
 Bd1i3VBw5tABSElJy2RSK57QWNC60JrgQUSbjw5gYaLO+5ZADVzg2pJP2HgZDak8S2
 Fr16ld2kYnIJg==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: u-boot@lists.u-boot-project.org, Ralph Siemsen <ralph.siemsen@linaro.org>
Cc: Lukasz Majewski <lukma@denx.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Tom Rini <trini@konsulko.com>
In-Reply-To: <20260908-rzn1-2026-10-mtd-v2-1-6a99d054d61a@linaro.org>
References: <20260908-rzn1-2026-10-mtd-v2-1-6a99d054d61a@linaro.org>
Subject: Re: [PATCH v2] dfu: mtd: probe before get_mtd_device_nm()
Message-Id: <178894459101.128548.560945898383071183.b4-ty@b4>
Date: Wed, 09 Sep 2026 11:03:11 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0
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

On Tue, 08 Sep 2026 11:03:03 -0400, Ralph Siemsen wrote:
> Parsing of dfu_alt_info depends on matching MTD device names, so it is
> necessary for all MTD devices to be probed first.
> 
> This fixes a failure of the "dfu usb" command that occurs when:
> - dfu_alt_info contains SF devices listed as via MTD
> - there is no persistent environment stored in SF
> - "sf probe" has not been executed prior to "dfu usb"
> 
> [...]

Thanks, Applied to https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu (u-boot-dfu)

[1/1] dfu: mtd: probe before get_mtd_device_nm()
      https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/commit/355d2c0412a46f073f261f9e9b9b5625c27b0272

--
Mattijs
