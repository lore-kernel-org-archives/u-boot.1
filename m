Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F757606A330
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 21:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=x4W3mHQV;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CtdrgRM5
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 35B4980E33;
	Mon,  9 Nov 2026 21:15:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id f7UqexjVugmH; Mon,  9 Nov 2026 21:15:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5B86180E36
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794258901;
	b=hz1rmQRwL0BfgwychmuRXY5hJCZFw41Q8fNaqwoV4xdJf9o2Op3ceeHTzFAtNKMz0qQA
	 udQ8IiX4bucQio5aPbjtyr/4LeLCEDEepLPSxsnSRQ1Y0Xju89XhWOfs/UbsTUiJBU8aA
	 hvJ8Hct+yNWE4y1spkEPovvi/eA9Wy1SaJ3QGWpa38ylmfZxgQCb820394+Z3Q6L4LXhm
	 nocan3WwcodQf/cCTIwPj064zTpA2YisGyNrKttnTkFjPURl7p18H0OVWf8tV/ivcVz7W
	 6YCNF0m5ALs0RJK0Lr/uTLMl2dn4/20VS7qw/Gu4GGBnyAjOVLV4VMFV+zrQPNcUqTQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794258901;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:In-Reply-To:References:MIME-Version:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Af/checyEZctoIvIkK4hqKD8A6nA2HlOstccGPDsdig=;
	b=eHM7dozahrfTIEyLMDUj2GIx07uCZWXUfBQWCk5zDQXJ7+ETpTlj3jWGx7v81CQyHgvV
	 opjo7BygZz+iS8ibWP5yowPvVtRYActUSqa9NlJplrmUcLjwz/71l9bMVmAGgS4wb9bem
	 HP7AlhGfe/WsLAHDANB1/hKnpbHZjjiDS8gY1y/xyAexwedjyv+unhxg/4zQ4TNIulmSF
	 b+7TAZf9A1DMiUEq0qj/uR0NsfqI3tLeltk8El/N5OcuxUA0X2BGWeQwbvAHa/Hbg7xMA
	 wsJoMd05WNvB7hTNoVc2Ek6MEiGnwfBSuhhb9Q9fEKTrizoPXIKHebwLo38yCSBEvIA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794258901;
	bh=Af/checyEZctoIvIkK4hqKD8A6nA2HlOstccGPDsdig=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=x4W3mHQVH0v75bq241WH4Gh6GSYu+XzyVffcMhs3335EnVU814CNXT5Q5jlE/LZOm
	 WL5KLsWe/w0y20/VtDDidojgBU8h+C61ST2TN7VwbM2AfdX4YZnO39CVXNAOL3U2Af
	 mE39uy4Zt3MG7usyhE4yiNCnKNgkKqb+QvbPAmVMQaOYJxjlN20P57dEH2VD8nspLk
	 ZF3Wj7z5nA+UD+O7N6fqxtvFMnyJNx/GzdduBjNtDNYJWbU+lnPbXDOb+vl3Axt83I
	 MVGhSnO3dAzCg/7dzpBXFS6RYAsn4JtKxr/VGLD7gPInmEpnRKftFBuR5RF3Vdw0QZ
	 gBnXLLMo+4YWQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5B86180E36;
	Mon,  9 Nov 2026 21:15:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id ADA673AD
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 21:15:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9F27D402F4
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 21:15:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CH2Wd384fdMs for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 21:15:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org AABC6402EE
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::22d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::22d; helo=mail-oi1-x22d.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=CtdrgRM5
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AABC6402EE
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 21:14:59 +0000 (UTC)
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-539a57a0b1fso496836b6e.2
 for <u-boot@lists.u-boot-project.org>; Mon, 09 Nov 2026 13:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794258898; x=1794863698;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Af/checyEZctoIvIkK4hqKD8A6nA2HlOstccGPDsdig=;
 b=CtdrgRM5WHHURz4bhIBgNJ60QbrkP8lAsmeNT9BrakqMu4zYfLoDfkb//gMh9B1bCj
 xILZnKKU9N9UPO+yPoE3pPcFZVj4nrni3CewBUBIrb9EQ5gBvGFcF8ZQzDqFuKkBLx8j
 LMsovu+CDb5NjDKjBoZ8MkUqpuHhc01JN9BsZoegkFpBhiWJeQrQ1qNAIfTer5R8P8Th
 PqLUivxM+zs51kW68p48pV53vuAlJs08ACddf85Y7MQbF97JoNHYGW0kHK26Z+EJK6Zj
 fd0Df0SzHckCrLr6yse0Uls+OBAWa3gZntJZq1xaChahW0RVflXt+RDJLiWQdFwOduTT
 k0hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794258898; x=1794863698;
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Af/checyEZctoIvIkK4hqKD8A6nA2HlOstccGPDsdig=;
 b=HQHsMs+VG/KcYIZYVHRBzewKYKND64e6k8FV8/C5QqMiT2s0vsJMizwr5E9evnPcGE
 DQm2gv40nzMYb3AuI3lym9M5MuEthFSAs5EStzU6CJG39sSID4uQJeS6+dxhiEwGWpkt
 FSzmjxknlNP0s9xpHNMHcgfTjVgoHv7MDTYzjC2yUYKZrbQJWIUjQgBhNfkTJdNK4SDL
 JgiWu6p0dsMwu0x3yKQXqLMUlkS7z+gKye4kPDBDLkVsaR8clBm/a62H5imNRYUhrC1t
 4pjkC0Yunn019+kMf26IAxON75fS/LxdQ77dKjcbfAvc5GVwLRbHO0ZbvUu2oZ3+Us+8
 Zkww==
X-Gm-Message-State: APuU4Z/bfFqq4SuEhbCbCN6Z4GnCUR6eV5tnIj5Z3bY6vjHwW/3VeYYi
 o99iX6VQB9squKwqMXbTDRy8uY/9avyPnyRLiEVZlY+ZevTPWVPgyCZ2PUpbhEldAnXN9mw0WRf
 MlRefRXGAD5/f4UPxKBoTwyb6ZZdJDaVpisuBxSk=
X-Gm-Gg: AYBFou3iCrRD+U1QVtYRk32fVttLPnUtA4rViQ9EatveFJWgFOapeDabqx41n7aGcMP
 ppjBjIVTZLvXhUO2K7WHwS4/pu31bDvuU0ZkHwsrvdelpcDSUkWAdJBs/jNoMVbdA/oGaklEylb
 vIpT7QTosErUzCH9XhQ2JJ1ihBIG2D9HyoFO1V7My52o6dyohbGmYNy1XsRj2b7PwYKamg7iW3V
 oCzBMruGUD3jlbFi5vNm+52Gyl7e04KnEA0E5nRpSxkVCVVsx8g6iyvk79Mio4JsiFa8tMRFlT3
 1DiyPBgolvo0xwF1/DfEvTH486aID904D3TKF2hUr6U0S+ERHUyHuLkJ2FC/0B1WYUO6RXWEP9f
 5STuwxKI6/rh8Z0isTcdnpuk+wjF3zhDlwgtIUg==
X-Received: by 2002:a05:6808:1204:b0:53c:5052:ea07 with SMTP id
 5614622812f47-5683c7b6cedmr742227b6e.5.1794258898087; Mon, 09 Nov 2026
 13:14:58 -0800 (PST)
Received: from 1077388689865 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 9 Nov 2026 15:14:57 -0600
From: Ana Bobillo <anabobillo3@gmail.com>
In-Reply-To: <3369ea11-628e-4e70-82b1-9a42afd54598@gmail.com>
References: <4bdba9dc-0c21-4e33-8f20-2c0a7ebba0d6@gmail.com>
 <3369ea11-628e-4e70-82b1-9a42afd54598@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Date: Mon, 9 Nov 2026 15:14:57 -0600
X-Gm-Features: AclHuK89C0Lw3sBmJv25vzWY8NCNEr79nGD-9HB4Ko5iv6IKx8urJ3UxWxvFKGI
Message-ID: <CAJnxHshhuZozN=UmrhQmWHeMndqVtbKgf6fRvh3-HQNMmFqWOQ@mail.gmail.com>
Subject: Re: [PATCH 6/6] usb: gadget: f_sdp: refuse unauthenticated loads on a
 closed part
To: u-boot@lists.u-boot-project.org
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Lukasz Majewski <lukma@nabladev.com>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>, Tom Rini <trini@konsulko.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 Ye Li <ye.li@nxp.com>, Francesco Dolcini <francesco.dolcini@toradex.com>
Content-Type: text/plain; charset="UTF-8"
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
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On my video series, Tom noted that a Fixes tag isn't appropriate for
populating newly added fields, and asked me to check my other series
as well:
https://lists.u-boot-project.org/pipermail/u-boot/2026-November/639710.html

This patch acts only through sdp_is_closed(), the hook that 5/6 adds,
so its two Fixes tags should go. Could they be dropped when the series
is applied? If a v2 is needed, I will drop them there. Patches 1/6 to
3/6 keep theirs, as they fix the named commits' own code.

Thanks,
Ana
