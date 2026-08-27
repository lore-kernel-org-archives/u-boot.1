Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D590C5DF9D
	for <u-boot@archiver.kernel.org>; Thu, 27 Aug 2026 08:15:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E8A9D406C0;
	Thu, 27 Aug 2026 08:15:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tKx1zrnTDGVr; Thu, 27 Aug 2026 08:15:32 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787818532;
	bh=WYv6CeDPlGiGWWGEZnocBYIwLFqV6uk291juYKGhVLQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LnqywtyK82CIxPa6Ww8IyrEWi9z5STpxjUlJHn/IG4WzhERtZvn+GvgkFgntX5lgS
	 ax0ez+NixTePecEvtAZdWyRZOTuc5H6uHwIe6oJ4579FLsluzoVhCSzVylLMBnnmEm
	 Jef2/izAKExON+FpuLo5H72kunyN6WLuR2Rq981mrPKI9stWzsgkFcm5nLq7fFY/th
	 F19ZKAz9St615LtVgZsAWKCK3sz8KT0azrF3wN4PZU86EPXNSYJaYLaUHsSnyyavBC
	 Um60iDTqWDQ7g//lhKIjqu0mFqujMG/48kNlGDKVGHOMKB0kgAq9xw/x9wl8mfSvVv
	 cSwDbzkNNa1uA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5A3934069A;
	Thu, 27 Aug 2026 08:15:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id DE0037AA
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 08:15:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BF55E4027C
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 08:15:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Yaktg4JpbbSK for <u-boot@lists.u-boot-project.org>;
 Thu, 27 Aug 2026 08:15:30 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::632; helo=mail-ej1-x632.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=rUPZcIM0
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D7FB4402C5
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 08:15:29 +0000 (UTC)
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-c15d3cd51b2so293830666b.3
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 01:15:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787818527; cv=none;
 d=google.com; s=arc-20260327;
 b=ZrUa/wOlSVQo93pmH5xzQdVxw85pSwB4fMRM6oI5WGb2DICPyw8igQXFSV1Em+Zl5h
 egFERs/2p9QcAgZ5RCsLQ/Qfqh+Ith9n8yweJryg9mSM+iCZSau4ExNy0ILijlIZy4iL
 NZYAvPWBkNrhOY0WpuArU1xgNHDPIVCrXt4wZJWO+jmlOll4p7U2BQ0M8UeoO4xaCt7o
 LpgFxdjP4xejvh0vhcdNBkunFJqSKsPsLqErlRlGPWBWwqJPJlOZ9Fm4CTzgjzyIVoNb
 0X0O1W3S/+kcjvB7G/7GN6LfAWGUQi4QCTw+4Gf2rK7kMYRKqqHoB8/JR6QoPPISj28/
 Vn5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=WYv6CeDPlGiGWWGEZnocBYIwLFqV6uk291juYKGhVLQ=;
 fh=j//M4a/wx93vMKVQEAxvjggxlisEMeBn+vVvx9MVDeI=;
 b=ILsPHE4sKJ9Z0LBk5y27MsozXeNx8LFOKu2rAVbqRNX5w9QRkDc0OjTP9EP6yq7LFg
 iMFyKJNNihFWIk54fR/CEhV9PqWUwlcoozGYTdPk58Hn8WdinOZ26UkNsRxkNRwaO5Xw
 80bm7A7IFufsUQYdN0KH/j0AdCDutUQZU/gPfXk92Zl8j7Y7u+yCWNpM07vtPD2vTVed
 kpib59l98Q7I1IY2In3CflWNYAPEhXtqHCm713Udl4kS+CN2eHLO499g/KIXzkBWMwUZ
 aWvo1cy/wmYobNu0FrMgi5R6aEV3UQAZzOhBD28iIhj8slMpK9DiOecxy3PjFsgjPk1V
 +QEg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1787818527; x=1788423327;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=WYv6CeDPlGiGWWGEZnocBYIwLFqV6uk291juYKGhVLQ=;
 b=rUPZcIM0KdSRVMg5+haRPc+J9ON07XaQ6ya56zKb2LRCqH91Po5smH0fv2ybAyCHXM
 4UZ3rPF41wNBZbvgMDpvf3u1AzrDqfjomlGXAOdxDjfIOq8n4x1MwM7oDf5kG6wxyGFH
 2FDqz4Qfm+kXe6Lw+17z4cL2Ded/0JDx5xFEAVwojA08Y/aKWMruPmFYzyzKfAYgM1HZ
 SR58mNyUrqZaA/+NcBkA9tRDJbnazHKW2eYe/sH+lZBB37MXKp9Y84AahYAtb1BHQ4r9
 58gBcxaxNpkxIm+hKWGQGupF96kMZeDRR2YfhVjfG6l4+hxP0Emd2x7NSpG407wlQgTs
 dpUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787818527; x=1788423327;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WYv6CeDPlGiGWWGEZnocBYIwLFqV6uk291juYKGhVLQ=;
 b=AHhlWhes+GbH8n+iXrw/FfejgWNcM4fTW22uehUE+vgtuyDLaXK0SKNTFoRORk0/8u
 ny+MbZZTUrJHubVUPaoaI0Hkg5kVpXdoIhK6Sq6CmFXobGEWQOJSWUbyYtXawDur2huP
 9MkPMzCkAyDhRyS0XrUQIoD5tWIOykqiAADlifLpLRPmElF23r7c8fZDG4rRw074amxH
 gKIcyPiYW8fVEA3UAQ8MRAhaKEwQfvtNn/opA2fREFGSj/3FllLMgJH3XvCseOawQYvD
 mB5rsBJNs9Eb4SnegjRcnsuwDA5CZrAXd/tLBoLPx7Y0j6dXOAkFEmwB3bz7Q/UsKR+d
 yRgw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrG01/sYfhsVmPDcwgoDNDDuCSzTycNeC4a7fVxkWrHZStkc1rptIYsLEaHSgs//Fsyk1Z20WU=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lBba4UEmCsLybhZkw7KXHtTqcLm/2+te/XICRKuovyc1kNX5sw
 adilsQtBEU2TmeGj6DzoAyDrgtZ45MdiCYbKWbtTx/yr0trQ/TeOtVZaNiFiqXW9/qQG/Lc2uj5
 MY2QMRha50bErTaNOyrxj8I2/DPEjbqoFoNsznBF8vA==
X-Gm-Gg: AR+sD10h2rm63Y8EtrTG5jXl4uqBu3h+N7NlH7PEdoBrCUsYZAVBohR7KaZnc03iA6i
 JbaMbEP+R6NL5B+4DeZbIfLoKp0cxwGlk5Od0JINEMO22EEpNqzgoTkRkcbmO9yDzV9AjkcI01q
 zoLDqRsT+qsIu4y1+RcLir++FUpJcuv2vu4SFWmVV2HQ0k/k7Bskbg6oNRnaT7wZxZZIyFgudgo
 LQ9cz+S7C5BbeAG5JexVgq2crzsI7pwZ9pFOE0WgxcRbCGTZanUki+jYSoaomaplrnDtfCOAfsv
 Ph/bnYX6V1wHDWVJOhP5/dSiyrrVjvlfIZL5XD9WoxWjMhCE4xjZnw+FCR8ItYrkN4fslkK1Nj4
 Xog==
X-Received: by 2002:a17:907:c8c6:b0:c24:6985:d7a1 with SMTP id
 a640c23a62f3a-c250bbcdcb2mr1441731566b.7.1787818527161; Thu, 27 Aug 2026
 01:15:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260731-gpt-4k-v1-0-a3f1f16b53ae@flipper.net>
 <20260731-gpt-4k-v1-2-a3f1f16b53ae@flipper.net>
 <e71a191a-1388-461d-bc87-9131e1a4879f@canonical.com>
In-Reply-To: <e71a191a-1388-461d-bc87-9131e1a4879f@canonical.com>
From: Alexey Charkov <alchark@flipper.net>
Date: Thu, 27 Aug 2026 12:15:19 +0400
X-Gm-Features: AcwNN1X6T1Z6MwrX81RVAbvu5Ly7UesVZX86936fh0xv7syBZTYIIT6gaReEkJk
Message-ID: <CAKTNdwFebx34Bvz+Tpj=ay-uK7s6f=qcRXTgCpb=bRczw9x9KA@mail.gmail.com>
Subject: Re: [PATCH 2/6] disk: part_efi: Add missing endianness conversions
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Anton Burticica <mouse@ya.ru>, 
 Javier Martinez Canillas <javierm@redhat.com>, Simon Glass <sjg@chromium.org>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Andre Przywara <andre.przywara@arm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Jacobe Zang <jacobe.zang@wesion.com>, Jagan Teki <jagan@edgeble.ai>, 
 Heiko Stuebner <heiko.stuebner@cherry.de>, Jonas Karlman <jonas@kwiboo.se>, 
 Suniel Mahesh <sunil@amarulasolutions.com>, Klaus Goger <klaus.goger@cherry.de>,
 Tim Lunn <tim@feathertop.org>, u-boot@lists.u-boot-project.org, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
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

Hello Heinrich,

On Tue, Aug 25, 2026 at 11:03=E2=80=AFPM Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On 7/31/26 14:40, Alexey Charkov wrote:
> > Several GPT header fields are read without converting from
> > little-endian, which is wrong on big-endian hosts.
> >
> > gpt_fill_pte() takes my_lba and partition_entry_lba raw when working ou=
t
> > the region a partition must not overlap, so on a big-endian host both
> > bounds are byte-swapped garbage and the overlap check does not do
> > anything useful.
> >
> > gpt_verify_partitions() compares the loop counter against
> > num_partition_entries raw, so its "More partitions than allowed!" guard
> > never triggers.
> >
> > It also swaps gpt_part_size, which is already in host order, having bee=
n
> > computed from two le64_to_cpu() results a few lines above. Drop the
> > conversion rather than adding one.
> >
> > All of this is a no-op on little-endian targets.
> >
> > Signed-off-by: Alexey Charkov <alchark@flipper.net>
>
> This change is not covered by the test in patch 6/6 as it runs only on
> the sandbox.
>
> Please, ensure that the GPT tests are also executed on a big-endian
> systems, e.g malta64_defconfig which run in the CI via QEMU.
>
> Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

I've added malta64 based tests in my WIP v2 version and caught more of
the same :) Thanks for the suggestion!

Best regards,
Alexey
