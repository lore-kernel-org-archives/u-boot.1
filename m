Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55D5ECA6002
	for <u-boot@archiver.kernel.org>; Wed,  7 Oct 2026 17:49:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E6E5D60DB0;
	Wed,  7 Oct 2026 17:49:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5WYZ4H8CzX4x; Wed,  7 Oct 2026 17:49:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org B813760D4E
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791395363;
	b=eCT+dSW8gEy75G5/+BKrJ8osLF5HVnzNw08XbMZDLoE4F8ZrbtvKIH1oyJeUzj9/Tv+f
	 mAYsLw/tDzFYycWbx/DWPkMC6oWzu7dCN78M3Yyvh0qzl/hkUmP1n/M2oeLzjnHf/JcIO
	 +pyLixgVA0u/ZBQGzV6NX5v5OdIVF9t7gMy0cnCdw3tjLmXNP3ssjea6AHwlTwMgQuMFi
	 9UDU8pbsRcPzm9N14S5U5xOtMojQEwQ4obNe474DtwFkPO1OVip+wzLl4fIg8WGJMsTSw
	 tHjgc5n5+xjGF4W9SqEBxmE0P8RMSfUymWVzgxmFR3YpzChJTdR+vtxLt2qqxe5t+yw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791395363;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:In-Reply-To:
	 References:Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=9g/glFx+gQUf9ZC5Ba1ovrEqoJ0GUuDXyfdFcHaN4Xs=;
	b=hS6MIQpiY99AqNeoPr1pokqqsUktxkEhkerQ26ozdPwNsDwSR7fPG7I7jzPERP42tvfr
	 +0npycN00csfgQfeE/KiroYdQCCVk10ZRadDNwfdQlhfyI36Foa3XAEk9hZ4g43BXfLVY
	 HPOnB/051StDdy2DOYHdg+qaBgwV6ILTvtVmGS4typKipV1Utnsk93/6GegYYJsHFoEqf
	 JdNry4DPG9sdgrXfMt2watpoH6RxlNDb4VNHKjG7hxYKPpwtHI2KSN3KYyW6DANpy8Csw
	 /cryXZX8AJDq46pfbysOzuox5mucqujBnUmnCzcbkQivGQlQfIUSN35hdS0sH0FGYow==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791395363;
	bh=9g/glFx+gQUf9ZC5Ba1ovrEqoJ0GUuDXyfdFcHaN4Xs=;
	h=Date:To:From:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0PoS4YPNGXX3t6qiI8AvfTl2f/epYzDCdTXWKQErKUPoZhOWIgSHyHwG4Em9Lhlbg
	 QmNMYj5zU7nY6GkvsI2MDRc492E+pZ4KAOWBbSS4fEC1xIdt3liMQrn8W6GFIjnBo3
	 KcZfXBDjZeuGuN+1fk0H45wpga/DU3ngfjDMISfc+nPeIsXJfNlnmRK+KCYZBcaLco
	 jx3xqs2PfBxyZGCGfE7/tn7NoTb4W3Y2FZ9pgZW7FJIeep8iC1ZsI1sHBupJz479fm
	 P05wGsKhZEZlh6QOzLdk0mtky/MEnyc4d4i5dvesUve0XfGgcZGO+VMvCqtun/4RTQ
	 eEPEAkRjN0wjQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B813760D4E;
	Wed,  7 Oct 2026 17:49:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2329222B
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 17:23:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0722C40E3A
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 17:23:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EyGT3Shiqrxn for <u-boot@lists.u-boot-project.org>;
 Wed,  7 Oct 2026 17:23:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org B74C340C03
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=185.70.43.21
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791393778;
 b=JICzlh8ke8OdlUxKK0W/eBVdHsnaM1vKsV+YaAry3IUtPNFk85EyE8u6jvO1pVe0pZpx
 s6MAahjMBnw1xlQOXnGyamwZfXquP8Jdb6JUdpXrXHBy3oZy+TadCX7xmedyOi7bICJUe
 oOZq69pIEsusi7pNMESIPEypKhVbamzPxBt0IjmgFgpN7LPdFRQ8RwTI+V8+N4hkmVEra
 joV6tWZPJLFCOlg6N976PKhFnvhphBL9jfBmwDF46KFyRUwAQTNFohOYOq0XryrYa8jqn
 48cNmLqoNjhGd2YIXz1dGQc/dFBLvKDvLMGd0iexX/Lts4z/GDzJJOaMQ0oWVJtRARA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791393778;
 h=Received-SPF:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
 Content-Type:Content-Transfer-Encoding;
 bh=9g/glFx+gQUf9ZC5Ba1ovrEqoJ0GUuDXyfdFcHaN4Xs=;
 b=UGGTSt/Tx7x8iIaxjKxCn60W/DqA31bL/6VtfDIyvZIA5O2YRmii3AxDZs7IDnx91Kk9
 xj8ttD3NBI6BpRNa5CylyKS9Vfw937OldwONzTqTCd7XWn8tddTW9i1BgxwY4dCvnRtQm
 /NxUY7QbvzFpzJRiSkWAlABKuyfgUpoVtHXoox1sGn766lFSqva8UK+3qNdw7e4H81SOq
 QfIMVeP4p1Alg+GIZaue//kOI1tYyHo2bBYJYc3YpCKxuawQ1jSuld024e78sd7xCgW2A
 1M9GdzO0pv3VxtRbXAmlFvDcsas2aTolzAHr3hV+FggvyU/6hhW2OmlwgbzD8bzeG5w==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=proton.me; 
 dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256
 header.s=protonmail2 header.b=ZjsBUwwf; 
 arc=none smtp.remote-ip=185.70.43.21
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.70.43.21;
 helo=mail-4321.protonmail.ch; envelope-from=munzzyy1@proton.me;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=proton.me
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256
 header.s=protonmail2 header.b=ZjsBUwwf
Received: from mail-4321.protonmail.ch (mail-4321.protonmail.ch [185.70.43.21])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B74C340C03
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 17:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail2; t=1791393372; x=1791652572;
 bh=9g/glFx+gQUf9ZC5Ba1ovrEqoJ0GUuDXyfdFcHaN4Xs=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=ZjsBUwwfHlestCtGw/19CTaLtxL6TwHVy6W/CE53z3X78fW7dOrPdGs2F5oWtYB5D
 q1LT/DjtiEh+4uYVAOMSbN5mysB8PCeZlDSUqEonuJWHx0GRxxnSTbXJNGgl5JNuXA
 pn5l5f1EBJKiIPfqixETtf0YQSyTjWDgVXw5jJEl40h4Q0Ywdlx2c4CzD5PYhPnk3x
 BoDGuqa+jh+XBuEw0YvIqnNoOVXQckiMFW9PbYSveh2QgIJ4s2RB7df64F/G1hGYlr
 DbScCOGaKWbctvemTU0/MQSEv+dB4UQZAdKP5W0nKu1hwP+hGAtiYxNW3tIpQ5K6rR
 tB8ME3IcbZ46A==
Date: Wed, 07 Oct 2026 17:16:06 +0000
To: Simon Glass <sjg@chromium.org>
From: Cole Munz <Munzzyy1@proton.me>
Cc: Alexey Charkov <alchark@flipper.net>, u-boot@lists.u-boot-project.org,
 Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Vincent Jardin <vjardin@free.fr>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Michael Srba <Michael.Srba@seznam.cz>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Daniel Golle <daniel@makrotopia.org>, Francesco Valla <francesco@valla.it>,
 Anton Ivanov <anton@binarly.io>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 James Hilliard <james.hilliard1@gmail.com>, Quentin Schulz <u-boot@0leil.net>,
 Kever Yang <kever.yang@rock-chips.com>, Johan Jonker <jbx6244@gmail.com>,
 Aristo Chen <aristo.chen@canonical.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Joao Marcos Costa <joaomarcos.costa@bootlin.com>
Subject: Re: [PATCH v2 09/11] sandbox: spl: Enable zstd
Message-ID: <20261007171551.279289-1-Munzzyy1@proton.me>
In-Reply-To: <CAFLszTjYA8J4V1mEOAe9_0Wdv66y4iawoZWfbaOPMPteNXooyw@mail.gmail.com>
References: <20260918-spl-fit-compression-v2-0-28e946f57357@flipper.net>
 <20260918-spl-fit-compression-v2-9-28e946f57357@flipper.net>
 <CAFLszTjYA8J4V1mEOAe9_0Wdv66y4iawoZWfbaOPMPteNXooyw@mail.gmail.com>
Feedback-ID: 209578162:user:proton
X-Pm-Message-ID: d266cceeb8543b69362e7cb51a3d017e2d63aabf
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

Hi Simon,

On Sat, 3 Oct 2026 at 14:41, Simon Glass <sjg@chromium.org> wrote:
> FIT_INTERNAL_ZSTD and FIT_EXTERNAL_ZSTD cases with a canned blob

I sent that pair on 21 September on top of this v2, plus a gzip pair:
https://patch.msgid.link/cover.1790017078.git.Munzzyy1@proton.me

The blob is picked by name in do_spl_test_load() and the zstd cases
check CONFIG_SPL_ZSTD on their own. NOR only so far. I can add the SPI,
NAND and net lines in a resend, or Alexey can fold it all into v3.

Cole

