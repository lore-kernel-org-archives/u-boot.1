Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EEDB606A31C
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 17:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=fWiMnZmp;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fvgdawd+
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3518060693;
	Mon, 19 Oct 2026 17:29:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0pJioJwn9OoS; Mon, 19 Oct 2026 17:29:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9454F606E1
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792430994;
	b=he5wEH0q4PWp+156Yr14yemH+h1xw1NKZnzVRbL37Zduc4uz/LrSq5bGi1t+Pcn/wcwU
	 b+VCc5k0ntNS16HuaPkmP7raCvZr7GvDDlbWzVqXChjeoaYLab2zhnRXs9oGotfY1ZpsQ
	 BF8M6PJzckNYyAY06HnzenFFC4PWPdGTO+0kXnsMAeH50raP6S4NpT8ldEjn5HR5RrkhL
	 W1teB97nFuOK1Ys0kt638l0a7PLmtBoy733wt0xvwDrEfcfrehbjRCgoeWEOggGvJ8QyW
	 8iHp37a/rdDQTIPOnygyXoFwWknCERCUj9WR1uLKs8kvgRbd3aqUKdep74Ay+nvO7OA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792430994;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=gitSeJ5NIT5sCvo4zmQxGCVc3JFDYCKsaGs24w+qi5A=;
	b=gol25zSqsSYMHlv7fF2z5rERZV6acPnfevTAdOdxouVIZieMrWqKVGqKlrg8hrm4P4KB
	 /oQijQZwxr4Bp9tTEwTEbQg8aQhYr6ugqTHOY5OJct7qY7SU4D01lh8rPccEi6/HFPwiU
	 2XY0Ji0T3vGy0CszPKPmMAPy1mJetuxQjOqdlk/s2fXeU0zeT1Ti5pvN9swChJevZ/Uuv
	 WxryRW4bSo0/y2GFfsa1gmCEKhDhLFX7irb4pLBSD3/Zj3sHt5pMMnIPysGgD4olw6PBj
	 VymFrPwj4ylM4qin+8JT3oocdv3fp6CIy/9CynPUtlgE5rBQctqIvf5jhGzTAboDuuA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792430994;
	bh=gitSeJ5NIT5sCvo4zmQxGCVc3JFDYCKsaGs24w+qi5A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fWiMnZmppfh8kH6dUqWT8vilNITU2mUs7FSWsy+zTIKxqh7zmgocwlIqor8i4MP+G
	 qr9vtcVRzW3W0FYP/+kwoggw8HbAnr8PHbZRn8b+6msbPI2dcWYgJm7X+JKL3A8keG
	 U8+gbwCGsF5Q7yu4cqsIPm2biX01iXI7uwD+2LrVJlezh9wBPo+cOEhpt84jrWhSIo
	 QAyhKK8u5QUxwc7d18gKhobXFQCDCuabTloM9F/P6zTVQZDY3pNMJdYZOPzEa2f+fT
	 24TjFDC9ehNzaHnLU7JRu43qT5VBydqy7r+62FU5ptCDRx9t6tiKFcJw/kW07ifzaj
	 g6C+B8fHLnx7w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9454F606E1;
	Mon, 19 Oct 2026 17:29:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 319E11AB
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 16:56:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2241040669
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 16:56:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OWsU6H5UTmNv for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 16:56:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6C1004062E
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::e32"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792429010;
 b=i4r2Tmuzv9nYgKag6WxWBR+vpQQnG862qw0D1SWOKs+OgODoZvATdi0aV5NvNE1jR4r+
 t7YYGRMazF+c7Xrk4pOnbDSklAU38HcBiAodtZ5ax3tu5K62kYo2lbfAmzKfAbH9vREjD
 RRT1OG1H+/gJoGs+new4Z8/4fZgO9YG8VhGch9Uu9tauv5djpnCWDCobUBchQTRiypFA7
 Lz150svpdLFL1gdqUX6/f2pODE3YlP4aVtL4S0gYeRjLt7e4R6e05YkDhQ+GCcGGxYoJ7
 bI+CD/5zDBxUdLBM4s1JRFlXpqcfKXY4JhfNxnRvluMjjCxZNyrLZhueCJIdyEsIuvA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792429010;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
 bh=gitSeJ5NIT5sCvo4zmQxGCVc3JFDYCKsaGs24w+qi5A=;
 b=QIVpzP8JCsJj8Dqntt4HFprhsovzaEyotonXdA9BMzfzu+vfi/Sr9T3W0aOzR4oEXoM6
 5BaofjVXI9lJTPiHw6GkDArxw83YLzH8AbgUbdkFDxtFni4orWA+5Wj2akQ1ixivJt+tb
 16eLbVGtEGjSA7Y3asMQHtdk/zIkBTD7qnZtoWaLFoKbOImZByGU8XKMhA8PPE1/X6D2d
 lii6sHVbpU8iiIPAQ2V0qY8FaFEc1T+iSrfx2XZTKBzsXQ2P4PjBQkeI6NBefuDRK/6rS
 +CDm2TeNR9ogbNMcz3wrM9t+KWYlqpE0g0DJQ8AUy6rUOFFdDzZMXKh6jAdR3TtmvZg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=fvgdawd+; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::e32"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::e32; helo=mail-vs1-xe32.google.com;
 envelope-from=jpaulo.silvagoncalves@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=fvgdawd+
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com
 [IPv6:2607:f8b0:4864:20::e32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6C1004062E
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 16:56:49 +0000 (UTC)
Received: by mail-vs1-xe32.google.com with SMTP id
 ada2fe7eead31-7c33cc572e6so2215032137.1
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 09:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792429009; x=1793033809;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=gitSeJ5NIT5sCvo4zmQxGCVc3JFDYCKsaGs24w+qi5A=;
 b=fvgdawd+cg3pkPYiZuiETlGz+sIh3g1vnP+m489a5F+w3sy5sQX+AcCp9G+1Ep9oDL
 KUfEtRopwRChQd3YbII68+euvxHw6tUPLqtqNcvXnm+/t8on/2QsTG4B+BdL9En1Ylnk
 r+BsTKZLvfRbjInhs4/06USlhRNTpzV3Zg7PNW0UHqp8Xy9k8+1bG6K0y7Ducc1a7sAK
 ln36oBmdOfNaIKm8eUGHi3uEF4fcKBscRNHc6N20An9rBdWmvsGEj0C1b9KExVF0i7G+
 pbbCuWnQGK3m9RAa3FtgJFLdUm4PAJ80D4PD+YADHFSqaGzg381KGSOKjD14K6EVT1+o
 NgSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792429009; x=1793033809;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=gitSeJ5NIT5sCvo4zmQxGCVc3JFDYCKsaGs24w+qi5A=;
 b=wbJBMhLiPThB3ERUp6lhL4kfhwzuCquPk0fLhzqwFX0XmWrjkSROn02jQ98Yg+P1uE
 GW7b59BNdUBmZdIJhCzCpbknUKzBdpOW3KQLGVT0Oke7cuHAGbkkE8JWcZCidFrp+npT
 TVVKg53aqq8Gs2h846REMx0sk/uIfAC/BpYDNdf7NSSCRjzdypPWrB1Yi9uf23NUkYez
 LViKC4s709CRps3FKAHXoonYDSa85xuVSZhy1KJFv5OYDabVBdgcfVKkMEgDmJTVRmSI
 sR/N1mtAMlkWBKdr0Sa6BPQ35wosz5iBp4pNn7UwWhyanV8tFmE8DOJUhA+oN/D0FPqo
 +DJg==
X-Gm-Message-State: AFq9FYIH27GdJiI3WbIF2nn/1a/mZCoac4mMelsxFSZ2W/NdzqC9NJX9
 EgsND28oA72WuLxReo2BVIHaNk9WVbrYcTjJ7+F+NcEO7P/qZLCwxp4A
X-Gm-Gg: AYBFou2gCyX9AJihL5/EGTuL529pykDYF9LW4mcbyaJxtZRIX73ybBMOzeXNtG5u/sg
 qVwY8m9bJZFUy6IeiJ6bXGvWrilGEGmDg5wtqbYGrkR5T5RYvi3ZHUeOjHY1eondsINjF1nOhaC
 KAGUrRKBQEFjQ8L/eXQ0n+sHG5PzyAHjjf1TeKxbmMrACbQtht4erjHQZGui1jtiC2mWFmXPNxq
 wP46oy0VrIsEHn15O1kxPvJiEy054oyONFLSA+Jri933RUiM9uPw2upQZixLFzriU1XPRqml9Sc
 4B0V8bwm2Od1n1DmykVxjo9afKm4I/yEbiZihEEOfCb9UUf+0HFbOTC3mxBmfPoBiNAIUA4Uzlt
 5i2btjs2FE0krd9BZ7ojIR1HJctnameKN9Q320mJ+jf+Ebuhb60kXqIY7IkKVReXIB5QD6G2WaQ
 cuiTr8BUCFkpRrD0kNLTgJZf/cXPab3dfAOLOsm6P3PlFvNAXLiT8OVFLp7YrfFz8rHWarvBKuZ
 cACMm3gBaD1tCfkJuPCSo6V
X-Received: by 2002:a05:6102:3257:20b0:7cc:148f:c531 with SMTP id
 ada2fe7eead31-7cc181c2885mr2328811137.26.1792429008673; 
 Mon, 19 Oct 2026 09:56:48 -0700 (PDT)
Received: from jpg-duosnb ([2804:14c:490:135b:b225:aaff:fe93:9186])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-990bb355e82sm712353241.6.2026.10.19.09.56.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 09:56:46 -0700 (PDT)
Date: Mon, 19 Oct 2026 13:56:40 -0300
From: =?utf-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?=
 <jpaulo.silvagoncalves@gmail.com>
To: E Shattow <e@freeshell.de>
Cc: u-boot@lists.u-boot-project.org, Yao Zi <me@ziyao.cc>, 
 Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@kernel.org>, 
 Gui-Dong Han <hanguidong02@gmail.com>, Joshua Milas <josh.milas@gmail.com>, 
 Chen Wang <chen.wang@linux.dev>, Inochi Amaoto <inochiama@gmail.com>, 
 Lukasz Majewski <lukma@nabladev.com>, Peng Fan <peng.fan@nxp.com>,
 Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Hiago De Franco <hfranco@baylibre.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, Michal Simek <michal.simek@amd.com>,
 Yixun Lan <dlan@kernel.org>, Andrei Lalaev <andrey.lalaev@gmail.com>
Subject: Re: [PATCH 4/4] board: sophgo: Add support for Milk-V Duo S
Message-ID: <atZLoQ8_CTfvyBcP@jpg-duosnb>
References: <20261016-upstream-v1-milk-duo-s-v1-0-e4bf386eea2d@gmail.com>
 <20261016-upstream-v1-milk-duo-s-v1-4-e4bf386eea2d@gmail.com>
 <d61a5f4a-f7eb-496f-86b9-70aedcfe2e66@freeshell.de>
 <atYbKddK-LBPPBhZ@jpg-duosnb>
 <0622671a-d353-45c7-aca1-13a64e9fad64@freeshell.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0622671a-d353-45c7-aca1-13a64e9fad64@freeshell.de>
X-Mailman-Approved-At: Mon, 19 Oct 2026 17:29:52 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi E Shattow,

> Drop all my tags, I do not agree. Thanks -E

Understood. I will drop your Reviewed-by on PATCH 3/4 in v2.

To be clear, I did not mean to dismiss your review. In v2, I will
clarify the OpenSBI version requirement and improve the FSBL section of
the Milk-V Duo S documentation. If that works for everyone, I can then
apply the same changes to the other Sophgo boards in a follow-up series.

Best regards,
João Paulo Gonçalves 
