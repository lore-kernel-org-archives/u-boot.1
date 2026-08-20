Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0327FC5DF81
	for <u-boot@archiver.kernel.org>; Thu, 20 Aug 2026 17:00:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A5E0460862;
	Thu, 20 Aug 2026 17:00:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zFfT1EhON_zt; Thu, 20 Aug 2026 17:00:47 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787245247;
	bh=9s8E3WJ+seFqDMpFaJQ+7Dt9boIMRpxxDWMCu3LUqzA=;
	h=Date:To:From:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vMfMgvK0mM61Akgf0TLlLbtJAkDR1HdbzI8r7z5hV25fTEp6gPCellTfWbKOpkI2Q
	 ZJjpKsYmgZlCywqpAho6jF747IiUDkn3vZZZhoOCXFgCon2c5QpQPkBdznroWEDKlN
	 lBxUG1kH43+hjQz8TUt8yaBo7cPHibVsFzw5CqaJBuez2u/E/7RNGHB40qwWxrmQdL
	 wN50whw5VqlJv0zjzUpj10nP0srSZksC9d009jfJd0jcE2beZRopK5O3ZjYHHmap+l
	 9qhfycE5kPMSd0ARTnxT6g2Kk2+T45Z5Ih1SCFS47MnhmYXmhIK09XKoWzpIPprjvU
	 UfmhhfuGVbfRw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0FAF460871;
	Thu, 20 Aug 2026 17:00:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4AEC9279
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 17:00:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3C6F460862
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 17:00:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AIHDQg-XcScM for <u-boot@lists.u-boot-project.org>;
 Thu, 20 Aug 2026 17:00:44 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=79.135.106.118;
 helo=mail-106118.protonmail.ch; envelope-from=munzzyy1@proton.me;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=proton.me
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256
 header.s=7kgw5qd2mrgyjlc7k5isnxspuq.protonmail header.b=dg/YqlWz
Received: from mail-106118.protonmail.ch (mail-106118.protonmail.ch
 [79.135.106.118])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A82CA6084A
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 17:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=7kgw5qd2mrgyjlc7k5isnxspuq.protonmail; t=1787245241; x=1787504441;
 bh=9s8E3WJ+seFqDMpFaJQ+7Dt9boIMRpxxDWMCu3LUqzA=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=dg/YqlWzAIa5IKgzbROjnLK0koZgbg6IY4XlQEyM5wHlpOrtVN5BSDAhXEr5K8brG
 KqUF4ITDGVXVV0ovCS7Trnk+E53bk8LzgeTVuYB3sgD6FBqTsS9r1t/NinwrixgPz6
 oECvsgQc412dp9VjLCk/wivFadz1AH0ka6G2Tfqudzl9veMoXMO1vN3NaatjidmPCh
 wQr0QaV0XIQRRVDnkcaslY5XLZfOUbve3AINpbzEwNit5kyu5PMmB9ojvLqWY32KWF
 ppQOGqGL0tnrHwO4nBAiPSjWSfO/ga/ik72dvCeIcyBupEchUPQ2lq1Uf+XCb0ZI01
 7WBarmK9YBLNA==
Date: Thu, 20 Aug 2026 17:00:37 +0000
To: Quentin Schulz <quentin.schulz@cherry.de>
From: Cole Munz <Munzzyy1@proton.me>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>, Alexey Charkov <alchark@flipper.net>
Subject: Re: [PATCH v2 2/2] spi: rockchip: skip the unused FIFO direction on a
 one-wire device
Message-ID: <20260820170026.117260-1-Munzzyy1@proton.me>
In-Reply-To: <3a8bdd54-3ebc-4659-928b-ea2f88cc22c3@cherry.de>
References: <cover.1787238071.git.Munzzyy1@proton.me>
 <9ddf5b446d236c42e39aef5c7dae9bc359dff694.1787238071.git.Munzzyy1@proton.me>
 <3a8bdd54-3ebc-4659-928b-ea2f88cc22c3@cherry.de>
Feedback-ID: 209578162:user:proton
X-Pm-Message-ID: 0664f5e23308b1ccde49f86f16b3d619dc2e5eef
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Hi Quentin,

On 8/20/26 5:57 PM, Quentin Schulz wrote:
> I got confused by the wording here. Can I suggest:
>
> /* When RX wire is not routed, the RX FIFO can never fill, so waiting on
> it would hang. */
>
> I don't understand the context for the second sentence though, we are
> always waiting until not busy, if there's something to transmit, it
> doesn't have anything to do with the RX path does it? What am I missing
> here?

The RX drain was doing double duty in TMOD_TR. Byte N only shows up in
the RX FIFO after byte N has gone out on the wire. Draining toread
bytes is therefore also what made the loop wait for the transfer
itself. With toread forced to zero the loop exits as soon as the last
byte lands in the TX FIFO, which says nothing about the wire. From
there the wait_till_not_busy() below is the only wait left. That is
what the sentence tried to point at.

You're right that it explained none of that. v3 takes your first
sentence and adds the pacing part:

=09When the RX wire is not routed, the RX FIFO never fills,
=09so waiting on it would hang. Draining it was also what
=09paced this loop against the wire, so the transmit-only
=09path relies on the wait_till_not_busy() below for
=09completion instead.

The test trim from your other mail is in v3 too. Thanks for both
reviews.

Cheers,
Cole

