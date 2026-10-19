Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8A0ACCF2DA
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 08:58:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 947DE40737;
	Mon, 19 Oct 2026 08:58:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oKGEQ4KbEM3O; Mon, 19 Oct 2026 08:58:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B698140781
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792400281;
	b=NQL/ALvD5J8AkhxTS2Pv9GOWf4lwscA31IEAe62ZOpbAVvP793kQvSY1PKIsYlILhmMu
	 vPJvc9nCVAArchPMOgqOIcrE1q+D6tv7RwziU0MEMS8IwGvN0VmnrQ7KEa+cr4Chk3cyK
	 0VwPZo+sqV95nkOcRGIBGSDkWfAM9AHy7uUa5l5bmrHmPuWs5cbdbfY+CiIaB1AVTg8Qn
	 tEqHwRETD7/zozB+Ll0FlVcCSWoAOdp1NxsjIDIIQQy+dTK/p0zP1aboKPCHj3a/3RvOg
	 eluCc4uGjrgfnL6GK00AwXqjv1lhS+/Fl0151ywwBf5+WtiKqhYi8pypS1hCVsu2+Aw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792400281;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=BsXoQ0By6vpamLqYNc2r4+z18D5qTfQMxouxGdunDu0=;
	b=JfSd7pQwEtTOdknCwlM34ANEsfVd+pND+gn14uXGNAOiKxGbfNxm+WshtOOUFSNaanXf
	 AbEAUjjt19kiIwjOl5b94UjI04mTT9gSGiQA00ZNoJ5TxYt50iWwIpkSqu/aVnP51+xES
	 tTK2crIQo0n4ARglk4dulYcddAqyA1GhgiQF3DpHU6xKCjOILAT5AHPcqWg4OihlUn2Qg
	 Rsv299/CgG1vjJCVGAs8XPVJDWUgBWXvYoV5RuFvSMYdEPsRets7BwbVy7iPe5+ClLzWj
	 9wOO6ZXQoFTF1cSoKdY9gFgIW9ca8PyIWytuo9NC0Pn3pXqeFuTj6HP6ET5V1J5w7aw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792400281;
	bh=BsXoQ0By6vpamLqYNc2r4+z18D5qTfQMxouxGdunDu0=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YwzXcvfAbbuksSelIXaxDRRitQd9/wd3FxT1+R0YAEbSbTiEPq8nmDad30ArTJwhB
	 XF6an05trv+3UOdLuCHoeQWMtRBV29wAE9a+5WSQL16G7O51Zgjm86h/EDhG3425Os
	 aYs1sBMJeXpYBF7l0Oumm+xo06CVlwVxgdtOobguylqTPu71vKMaRme0hl3qXNUZPk
	 Fc7gYnjNyHPQILNVQ7Pt3f5cIGWaYZRsY3KhUIAKgQvt4qaCwEsEPS0tNcJCSuELAG
	 F9w/GeRatJTe/mcp4BVqunO1nHJoL2GqJ331Ads5cFjzMSnL/zVo1PYBqP23Il7WPe
	 pc/AVvtGVoUyw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B698140781;
	Mon, 19 Oct 2026 08:58:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8D372D7E
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 08:57:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6BFAD80F6E
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 08:57:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7RAyFiWTKVhj for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 08:57:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3C9BD80F67
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::533"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792400269;
 b=SlJJEGD64RKOuiosjUcTfETzKedNciC6SlkkhTu7NgRUY27JJFt8yGn6+ZxHIm17BDWW
 /FBht6xaPoWNgiiQOq0EpzfLjjftquu5BtiWiKKLxKrh3PeDSCE88LMM9PEKgT3mNXw7z
 Aw7Am+KM3hCemOqI/GAMCw/S2ZiRIkpefbnesJ5MRTYkXtXw9NIplwMO7PUMVCJWtXs+I
 mSEIaD9RkHuTturdI/SnVh/y1sEOEVddbWhRx4XzzC7eOFQb+npcXhFT+V1u/6PP3uzSe
 iiZBDN4JpgEdGgMNqKPku/H1cPmB+HxhxyLn7vh391geB/87RnG7PfrmLIM7oFMJ63w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792400269;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=BsXoQ0By6vpamLqYNc2r4+z18D5qTfQMxouxGdunDu0=;
 b=koEVVC6B1FDDL6v7/z7mMockEDB7ykk/2BQs7ObmJ3OXq7MGZhlZR9Dg84eRnzZqoSK5
 JGP8MWeZ4flG0TYF36rbUni0RyYiPL2B5bYVOQNYXeLWujBU6ITxVhE0klOXQJ/KX2zmv
 1783f1PuDyFI3U+8Rh0Bn9CZWW8txiUIdfE52qbN6TemsOUsX0Zcn8fRcttERFigbuVwk
 qdOxlMTzTYHRyEekWMsCWrwu4jou6K+BCJrxd+1vLBf8Dzif8kr2dSnQkp99PfxlH8qfc
 7nZPz0IDXQETc+ee78ToiFwn4vBYO5XV02XdtcC3jXkCI+OHyZjCflhpOZn6S2zS6cA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=KBJsZSnP; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::533"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::533; helo=mail-ed1-x533.google.com;
 envelope-from=glaroque@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=KBJsZSnP
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3C9BD80F67
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 08:57:48 +0000 (UTC)
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-6b1d8944cb0so2643491a12.3
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 01:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1792400267; x=1793005067;
 darn=lists.u-boot-project.org; 
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=BsXoQ0By6vpamLqYNc2r4+z18D5qTfQMxouxGdunDu0=;
 b=KBJsZSnPHJo5tZKxMMu0vbofzJh3bEzIso4xoRGvG4Sq65QU1+RUA6LOnKxB7BIt3h
 xKXvOE3jQvobYBh31I+B11cRAQZeywDu0FHRKHX8szmFlrDAoQ//NCqLdGrpF5zM8iDU
 Vl8mbq8z7OwTT1sFmqegc43VUKfunvzUsszgnARTfBH84UrtBUSPQUo45I2lpYjM5Abt
 GGED4eKwdyT1XH0KfEmjuSmE7fyGjCn2mBf+e0HKmgd0vrIg5g+pC1wQYIfdg3b+2XIM
 XvRHTwf4//ymmEYRvzXkogeS2+E72GN3a3w4IwoSBuSfxX9vfiDLNk5ym6PiP8nRf/Iu
 Z7Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792400267; x=1793005067;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BsXoQ0By6vpamLqYNc2r4+z18D5qTfQMxouxGdunDu0=;
 b=N6P+64WoST/UPyibt/0wb8HnXQ3Hop3nZKIdM1pOPdIchtrzHqV2gF6S5BZhvlu+hB
 z+lVSKJj0VrjAWi2+/OR/8HkBTT2wP5jUuaESfozaa1LL+3pv8Q+ObtORdi1vH3yJBCB
 +lVYOhp6SdPygmMGs386gCYostOG+9+LJoj26C5/zro5oWJ77ZwVvqpu+X4CN/HSPqUW
 JBmFdgYD1iMT4+JPvrHGv47rj6dSAz6dXqgH/G6EpWxTfZKBs9jKPmKxQiJzAoVXo7pI
 /cYMy9QsGhz8vutbtZinRzcA4HwIuhhziNLK17DNdVjaukX/B0w/F9JMx3f772UG+veF
 z0Gg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxg/Ww84naNRlDTmsph8kG1Ob7y7U6J25p1yf7YlKjTbNscw2n+ilohXk7AjBqUT/wYELgJClU=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIejgnXvgNU1l02XJ9icJMhvYjSOy0RmSTydTMGuir00DH9m+Sw
 LOVYJgVi1+bbEJU5nZPH5EMSCOEy73+k6NQfDMPGZFcg4v8aCUAgYgXqu+JXZuUqJkycicezv+Y
 Iwxbp
X-Gm-Gg: AYBFou2CgV7r8vl/MQbQw486amX7pAg4sFhZqRJahOTcO9EWHzqNREpIjHBydJCcmhz
 ZsMMG8Ue77u0OFerjVOTQgVRcE5r9jzoU6SyoW8H8ud3CyHqSorqbUnpBS4D121chFgTAcXaetq
 W7iCbEL4H9+vD+ZJfKenZ2ItUSrkCMYwSO9pADmOc0POmxeLJzpYE4MOczSD6ob3OZd1gCoi3RP
 eEbo/iBMlvWyCdvoUX0c7B+DWU9cnl7W81dT4OtzRUc6r6tYWKbvKtlk5MSsV0C4dcwv0Pnx+1O
 vLchnLH1EBMFCTeoO3+QzCmluIOs9HdVXkYe5T+s+SGv/2laV+6zF3NcsGFCxVSBL5S6JzxCcZZ
 bzCQARji2PXyowO0/vB2Xq6zVtgazwEwhykNug3ZLmKVa+53zp49Mt6H6J3c522uQQgVL+gwfnG
 IDhs1PwB3ziW9GX6X3XsN6V5/RKFtJ+VXL30DXuW6srZGxt0sUgbypu0MPm+mJ1qpLD6rHefyGV
 cLJJUlYf9bjLzNIgyMu
X-Received: by 2002:a17:907:fd8b:b0:c40:dead:7466 with SMTP id
 a640c23a62f3a-c419e538580mr449136266b.20.1792400266727; 
 Mon, 19 Oct 2026 01:57:46 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:e0a:e50:3860::e1d1:d182])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c408e328527sm338958366b.1.2026.10.19.01.57.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 01:57:45 -0700 (PDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 09/10] test/py: avb: Add sandbox AVB testing with
 dedicated mmc12 device
From: Guillaume La Roque <glaroque@baylibre.com>
To: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>, u-boot@lists.u-boot-project.org, 
 Jan Kehren <jan.kehren@emteria.com>, 
 Guillaume La Roque <glaroque@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>
In-Reply-To: <20261015-test-avb-fixes-v1-9-9e5b82644359@kernel.org>
References: <20261015-test-avb-fixes-v1-0-9e5b82644359@kernel.org>
 <20261015-test-avb-fixes-v1-9-9e5b82644359@kernel.org>
Date: Mon, 19 Oct 2026 10:57:27 +0200
Message-Id: <179240024784.806974.6018868191738535484.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792400257; l=683;
 i=glaroque@baylibre.com; s=20261019; h=from:subject:message-id;
 bh=jjbh/UloUVnIXUy0YDZzueX9zyCzR16Q2zuJqRUJDXs=;
 b=iitdJW4ryKS+f5SGdeyVn0/C+2O8tdaYVn4gAkvLd4USxHrAap3LSoKZvL+rbzZps+gF/bvsD
 sF/LAZR0OWLAtXKSCPid5S/bqpOf50gAj2XdncFR+/XMyY2SJoAA8j3
X-Developer-Key: i=glaroque@baylibre.com; a=ed25519;
 pk=nMpSg4NT6M6q143E089emouMc+MXpHO9CWmnEUfjhjI=
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

On Thu, 15 Oct 2026 15:54:59 +0200, Mattijs Korpershoek <mkorpershoek@kernel.org> wrote:
> Right now, sandbox runs the AVB tests using mmc1.img, which contains a
> fedora image.
> This does not really make sense. We should test on an mmc device which
> has a proper vbmeta partition instead.
> 
> Add a new mmc12 in sandbox which contains all required partitions for
> proper AVB testing.
> Use the mmc12 device in the avb tests only when running in sandbox.
> The mmc12 DT node gets enabled by the avb_device_id fixture if CMD_BIND
> is available.
> 
> [...]

Reviewed-by: Guillaume La Roque <glaroque@baylibre.com>

-- 
Guillaume La Roque <glaroque@baylibre.com>
