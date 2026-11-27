Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D88606A6AD
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 07:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=VlWyKiit;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=aokc7c4e
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1F0B3408A8;
	Fri, 27 Nov 2026 07:44:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id avEEEH3QscyK; Fri, 27 Nov 2026 07:44:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 239BF408AC
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795765498;
	b=Dfyx7pAJPJVHrWmA/IRylZeviY+xs7/q9nHZ/2r9uigQd/RnvFcRLslG/oWMJT4kbYRO
	 o8JAW+mX9nGfcVSoJtlFtXCeh+mXiPGIcFE/NCtnQ9KwAREnmMxkqCUOOxGyB2OZBiMLX
	 P2FHgx5BC1XnyzLMxb7Tfi7PGEw00zCT9ex2b9IDtfdKwsVCpiLjjLGWvFK4bW/tvdlk2
	 Xhi0UIRYjatOgTpLd69WdwUVfcbxNvICrZqY3gqGGZqVFmGTcsz05ZT1YUdQNNRLoN36G
	 vWHtfAYkv6aRhS0Zjf5VqO9mHq/HF9Bo3B8AmoNtZwhL0KkaUSNTyts4oTzNpPwLeFw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795765498;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:
	 Organization:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=mzAXNoLbYfAUVxPi7hwhZKPCD19LHkzTT63XylOfcHE=;
	b=jH6PYx6KuHQGTW5mmhNQEzDJ2siV3/XcwSzCsYKN8SfvnUc8zAT9ttJNQm6tnYstxfpP
	 QCdjeWNseyxItatAB5a25B2VSZ1XXjHGBpARELXVZO8ezgdMBLtDXGrbhV1wH1Luxjmey
	 jsq0Q9j2AjVKyzteYgZ1mcNoCytG7wsDnPROWu/iJAKsdBrULEe4WXMCwkE7/Gx6wgKhL
	 j9ANGQ/dD/jwwduzZG9YcUbbcBlBuRY0I4tXCqwHwsEryiUNiNilPyqLBxYj8F8F3nqeH
	 Io3Q/4apxdukkPZotOZsC+cmHyyJyMI+4pQblCogEsE2FA9Gnr+rUnT+CTsIS3KzbVQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795765498;
	bh=mzAXNoLbYfAUVxPi7hwhZKPCD19LHkzTT63XylOfcHE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VlWyKiitF4C9I7iAFk93T+iTE6oz1uh1BJzI+SH1h0lEIi1gErpRRh76HDj05CrVi
	 68U0vYPBABxxWvgBSTbWzaBKLho3EUY2imxh59Bl27e/8zVl7fW3fDQfbcnNMVQOmu
	 s8+tIYx//ndIkv2xEcoYWXuhk+RtiqBuf0Ibatom3YtWmZtZqnmq50lV7DtVw6J6IQ
	 KysxRbCEWyZvMb3JKVR5nmQqrqQmnb+YjNza7y+tnwI0AprTZS3zYBxEa/dbiBc4Hp
	 u9QEf2vuhuH7ow7RalykzdXkglgkhzUIwNu5ywO5mNm9gOKb+sRCSzjx+ZxocOp7+h
	 JpDqxGj/knprQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 239BF408AC;
	Fri, 27 Nov 2026 07:44:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 897C03D9
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 07:44:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 79E298116C
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 07:44:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WBO2QxXjBO0T for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 07:44:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 15A4F81164
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=185.171.202.116
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.171.202.116;
 helo=smtpout-04.galae.net; envelope-from=richard.genoud@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=aokc7c4e
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 15A4F81164
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 07:44:53 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 2EEE8C62216;
 Fri, 27 Nov 2026 07:44:59 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 5C9336049C;
 Fri, 27 Nov 2026 07:44:50 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 15CB511E69112; Fri, 27 Nov 2026 08:44:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795765488; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=mzAXNoLbYfAUVxPi7hwhZKPCD19LHkzTT63XylOfcHE=;
 b=aokc7c4e5b3N5/Wya3ZsrW7jsbbEiS9oRRiGwHqz/z5cP7amSSOt49vhhwaDiYWCoXG8pj
 v5ANZddT2P7+QgcCWNibQJgrCMy7djZMTmRdm0PWSh3QS7o5c08knvgO61lGO04M9IhI7x
 8IST80waD7TghfLtcNL4dKpRBMLApEGPspt3nYbA6EctzUCyJpf+iFLL2aZRbLJilGj6DG
 Rhn3LnClsaNdaXWP5G4R4jPT8D6hl47Kt4DxJdsoXqx2LrxfXsPSQDTpSRNMPOTaxg3gNT
 LAXdovHtUyhsHlkb4QEY1pmqwAIimKnrc+sZlGGbI1EJ8RGwdniLY24rUHXOYQ==
Message-ID: <95c20d0c-21a6-4846-b769-91cee2996a51@bootlin.com>
Date: Fri, 27 Nov 2026 08:44:36 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/8] pinctrl: synaptics: Add sl2610 SoC family pinctrl
 driver
To: Linus Walleij <linusw@kernel.org>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Terry Zhou <terryzhou05@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>, Johan Jonker
 <jbx6244@gmail.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Michal Simek <michal.simek@amd.com>, Michael Srba <Michael.Srba@seznam.cz>,
 Chris Packham <judge.packham@gmail.com>, Adam Ford <aford173@gmail.com>,
 Marek Vasut <marex@nabladev.com>, Lukasz Majewski <lukma@nabladev.com>,
 Anshul Dalal <anshuld@ti.com>, Junhui Liu <junhui.liu@pigmoral.tech>,
 Peng Fan <peng.fan@nxp.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Billy Tsai <billy_tsai@aspeedtech.com>, David Lechner
 <dlechner@baylibre.com>, Mikhail Kshevetskiy
 <mikhail.kshevetskiy@iopsys.eu>, Torsten Duwe <duwe@suse.de>,
 Ryan Chen <ryan_chen@aspeedtech.com>, Guodong Xu <guodong@riscstar.com>,
 Yixun Lan <dlan@kernel.org>, Jisheng Zhang <jszhang@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20261123-sl2619_base-v2-0-9e3b28c77cda@bootlin.com>
 <20261123-sl2619_base-v2-6-9e3b28c77cda@bootlin.com>
 <CAD++jLmAwPAKSqsR05UqY8q+0Ln=+95eTtTkYbOWRrGFb2c3nQ@mail.gmail.com>
Content-Language: en-US, fr
From: Richard GENOUD <richard.genoud@bootlin.com>
Organization: Bootlin
In-Reply-To: <CAD++jLmAwPAKSqsR05UqY8q+0Ln=+95eTtTkYbOWRrGFb2c3nQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Le 26/11/2026 à 14:01, Linus Walleij a écrit :
> On Mon, Nov 23, 2026 at 3:23 PM Richard Genoud (Synaptics)
> <richard.genoud@bootlin.com> wrote:
> 
>> Add support for Synaptics SL2610 SoCs family pin controller.
> 
> Why does it seem to be two competing series floating for the same
> SoC? Could you and Jisheng coordinate yourselves.
Well, this series is for U-Boot, and Jisheng's series is for Linux

So I don't see any competition here right?

> 
>> It uses Generic Pinctrl framework and is compatible with the Linux
>> driver (same device tree).
>> Pin muxing and pin configuration are supported.
> 
> Send the pinctrl changes separately so I can merge them, unless
> there are build-time dependencies to other patches.
> 
> Yours,
> Linus Walleij

Regards,
Richard
