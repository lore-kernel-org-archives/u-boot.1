Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76D1CCA5FEC
	for <u-boot@archiver.kernel.org>; Sun,  4 Oct 2026 22:13:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0725980A90;
	Sun,  4 Oct 2026 22:13:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tWil03c-46W1; Sun,  4 Oct 2026 22:13:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 3CFD780AFE
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791151995;
	b=G75SVXwCLIhPHcUbHYwdJQdTl2WWFzOzJGJxgPbLRuhKIj2xEozsT0pMhys7wzcdsI/i
	 01nHcsO2D0Je2i6olyFYnBYOE1AlBUmbf1oVYovciOsjR1uizP8Zax++KVwtdBc7G9IDS
	 7jXyoxKKFUoSMsHRp5aIY7oRwu/TV1eg0WHOs/4PUp0VuYDBQO3eGaiHX8yQogoRmg7xp
	 hE+qkiUp61Wph8VNQgrz4CSgKypEJkUbMtqrcAUqWgU061CpW7hlqCDvdgB22uObCWMql
	 +iOpMBZpoCP09kiZn+UzDiuMvmrATEhOATIX2x8ea/OrGrrkkBd5WoLk8/xIhOMoLmQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791151995;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-Forward-Email-ID:X-Forward-Email-Sender:
	 X-Forward-Email-Version:X-Forward-Email-Website:X-Complaints-To:
	 X-Report-Abuse:X-Report-Abuse-To:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=h1SV0pjupb8AapjG3ytJxiiLFienG+dSwmyrokWgCUw=;
	b=lCvDGHeSAeKyL7l7eBp7g6N5/0WAOGNS18pe4AlXHPK5CbLiCgUi1BootBNX/QpCkGvE
	 RHyGp3RIsgcUhb8CLX6jYzfduOCb+U1odZLDUwKoYlPVj7Gf9H8bGkuN9leZK5vWnO8Uq
	 JPVy2/dkWUsxgC7fdGcoj6REZ7QpaxEdmBhTGT8tKiZWxocAzVfcJ+7F1PLd6Dj2pKyAS
	 TrhvbSdg6k3eL//b+SWLEgwws6jwX8x5dH8Ya3OzG4cN1AhFDJIRmMMuadTsAkToqorAg
	 HF0/jjHsbAurwCFUs8pGKYdk26Mb1MZN0G5yws/NIyDhjfhQ98yG5lYIlu/rQRCrjRQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791151995;
	bh=h1SV0pjupb8AapjG3ytJxiiLFienG+dSwmyrokWgCUw=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=e5+yNroAUEjlTqD+8ruRzm2F1Lk07pBbBObAYA81vDw/e+9PfbN2omO6H56Yx+Eip
	 afJJuBs7cl38WRZG2AfXiquoOgcmtj3cQnRHoMSuZnLfXvynoyEfBNnex+rhKA3azQ
	 f2yJFSavrkfGwZBClVtkqcSIt3gQWkU1NwfM9xNjybtd+s3/rLNBw3299hA/UmgE19
	 aha6pI96zb+BL3R7fMaCqfZtxQqNtGekbQWZr3ZnqR0h6iIheCzqY4edEMozN7Nm1w
	 ZUTDPv4Zp5k33rNr8mGVnL21xWjz2FYWvkLD7U7p+f34nW6zDggv8LJIC9bkrxjvHP
	 9wfmrDmUPIszw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3CFD780AFE;
	Sun,  4 Oct 2026 22:13:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id EE52F335
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 22:13:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D09F64007E
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 22:13:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dnAhbKFxsqqn for <u-boot@lists.u-boot-project.org>;
 Sun,  4 Oct 2026 22:13:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 0B78640004
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=121.127.44.73
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791151992;
 b=A6Rg5+S/xwMI5ZZjDaaRhZdtFwtHSedx/0c+xWEI46aJotaHb2MERmB3Bs09qLXmqzyQ
 tiKCkXHKf2S8Z6sDXKLoYtWT0fK3o2rdD+eKqP5850U/19JfiRNJ6DV2O/m6wvA+PdHo0
 AT0DioUSqINlHFAL4wcRavwARc+g81E0BV6e3FM0HcdJCFDQN4BezOc7juddErVSJeYEL
 5BKljUKvdbfADc2EwCbXj2H1xUD+D72vrtHlmAYcBYEQZgZQb99w3DKx1xfxUy+SsBKUN
 w7sq789rnaiKdPSXecuuQmuSUgzOZsJhDTof6dD6mJ78SDA7V/7CeKx60HR4SugQ2Gg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791151992;
 h=Received-SPF:DKIM-Signature:X-Forward-Email-ID:
 X-Forward-Email-Sender:X-Forward-Email-Version:
 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
 X-Report-Abuse-To:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 MIME-Version:Content-Transfer-Encoding;
 bh=h1SV0pjupb8AapjG3ytJxiiLFienG+dSwmyrokWgCUw=;
 b=EV7j9BR2qc4du183w8EHrLitDmYvPfAYG//EMFnJZq9D1gDNq8hRjQbkxUot6bvy9n71
 zVXFxd9oo+qWGcY7ooDXhQd2+DpUrym+2E9Ow25WqUyqgq9TXHcN9cXRr+ccf+q052iHG
 wFpgjwBF1HWUpl5CFr9DZyoNrA39d4AKR1Sg4trG0Z/sd78XpbD9nsJxipWwD5ASCe3JO
 pvCITUKqNB0YH60AZnkxHlpgxZO85ErmSlCRNnGHh3/Smz1s0oTJPM+hIJHlwjMtkPsFm
 Lc172cWhhM4+v754JwiLw/KVxO9p9dAK2SwH3NA8TFWJmrJj84rgbun9iQhfUGBEGjQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=kwiboo.se; 
 dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=pEGZZwBN; 
 arc=none smtp.remote-ip=121.127.44.73
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.73;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=8573=h3=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=pEGZZwBN
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0B78640004
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 22:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1791151990;
 bh=h1SV0pjupb8AapjG3ytJxiiLFienG+dSwmyrokWgCUw=;
 b=pEGZZwBNE8oCDYUC8033JuXMD3Bz19CoqGUA19T21a/ngvvGDlXgQnbOwDx2XuWkemTxkz+4Y
 jNGc7vXbZLrIrByeZj8atRMJAuqbQXPMKCLRg/OYoJSjbUNNfPpfZLaeYIKEc8B17dIjRSnmIsG
 t/hA3AIV+3VEN98geqqnFACFkO9lLsUI490o+1RiewRL1cV/ybQDnBpMIYkim2ONSfOWh6s4xsf
 SofcU/Rti5lhBF2dByKd6NplbfmGrc0Um85Sd7qfBLgk/epmZMwvuyOZFVeFsdWY0XlZu9zQ3TF
 KjxIql0TD5EdmAiYoI+wdvPyP3RZCfNBtjGcvEHxXiIg==
X-Forward-Email-ID: 6ac2cf75ab896cf9f2e427f5
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.18.1
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Jerome Forissier <jerome.forissier@arm.com>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 0/2] net: dwc_eth_qos_rockchip: Fix use of mii/mdio commands
Date: Sun,  4 Oct 2026 22:13:03 +0000
Message-ID: <20261004221306.67476-1-jonas@kwiboo.se>
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

This series fixes two reset control related issues with of the Rockchip
variant of the dwc_eth_qos.

First patch relaxes dependency on DM_RESET being enabled, reset driver
being fully implemented or resets being defined in DT, e.g. during SoC
bringup.

Second patch changes how reset controls are asserted/deasserted to allow
use of mii/mdio commands when network stack is in stopped state.

This has been tested on a few different Rockchip SoCs using dwc_eth_eos
driver without any noticeable effect, beside mii/mdio commands working.

Jonas Karlman (2):
  net: dwc_eth_qos_rockchip: Relax dependency on reset controls
  net: dwc_eth_qos_rockchip: Do not keep reset controls asserted

 drivers/net/dwc_eth_qos_rockchip.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

-- 
2.55.0

