Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24BC0C5DF9D
	for <u-boot@archiver.kernel.org>; Thu, 27 Aug 2026 08:13:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2308180DC1;
	Thu, 27 Aug 2026 08:13:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id k31bij6RX1II; Thu, 27 Aug 2026 08:13:33 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787818413;
	bh=S6W0GjvOLsje77xp4P+jRBvs7bZK++S21u0CgVMr8VE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UEbTM2iMnyOKbsvX94m/fR6OFAcUOA7HfSVrzK7BKV0VVutKGGoWWHATzEmIhp5YF
	 EbQ+pDFuCCMaTU13AgeMEKEng9xVbZWuPL1coVua1tIeSeDXDbSlccniK2xA0CQVvB
	 IdomHW0xBwcOWGzEXKGqIunDzRiVTizPWN5b3xGRP+bgIGLJyIxcZlscvG0QSgzhcp
	 G/uCYUlMZS80hTczFI//6n/ijMbidptDB3ISKPX5rMKe1atxYRHs5WSS7CBEiNK+dp
	 w9b+JZaKt4jricxe2N/Ahtfs7morwxjwifBhGOvyu+g1rEt/w3QnoEQeX6/z1ENHkt
	 UZKvZXyYh/sWw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id EB97A80C84;
	Thu, 27 Aug 2026 08:13:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 882A93A4
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 08:13:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 68F29406BC
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 08:13:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CfrnhnydiVb5 for <u-boot@lists.u-boot-project.org>;
 Thu, 27 Aug 2026 08:13:30 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::533; helo=mail-ed1-x533.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=yp/bW4C5
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3676F4069A
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 08:13:28 +0000 (UTC)
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-6a3e145e1bfso467789a12.1
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 01:13:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787818407; cv=none;
 d=google.com; s=arc-20260327;
 b=ZxKPZnc/ix0GPhSLfu6FoHv9tXMJDzvKr4AdHu3I7U3DdxXi8T6SbSYOcCs56nNHCl
 UNrRs9shzh0FL+gmyZHA+rduCpG1QtP6vKfFR9N2wO00iWXsX3u+l44PSwhXB80fs5t8
 7wg0CxxMWatxapdoQG+OF0OOtVEREkiDnUdMHSs0mCluZPQEIQjLpjOnnLdlfbESFF+q
 v7UzPrnUeunX+oDFhzVc7Rw3OF9zAHjTf7t+oHiz2LInn/4/sJbc2P4lIg46CRk1js3k
 jivDTqm+gefzMdKMySQ9/z0F2AglowEv6JXTSip4B0cc1DIHAJ2SesvxgrlqnzSnKAPm
 sX+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=S6W0GjvOLsje77xp4P+jRBvs7bZK++S21u0CgVMr8VE=;
 fh=evkcmTNAyIb9LvpjeekKM5nvyZFiyByn53Ds1pEzDUE=;
 b=R81j7SzTnG66Zg3MNnWrOsPPrmIBS76rcEhPumohg/IIQM5xzujpfkQohzxJZ3aznZ
 0KuFWGQzhOuoy+lwedqrdhVElV+QgLbpbTx4B6l2r0TVQYEXEG9wb0FycZlhaGRjUQsY
 rhYxdEvs5mDs5Kui4OUVDBGZZg3bstYSeqyLX1dhipim8prCjcoDVCbEizlKUazTbG2p
 /rGBrQl2KNfJG4xIZTFz74am4wypkSO+PbumaHEKTDvWwEjRvvS5oOjJqSFJrk1Ook80
 2eTYQxkmSkWGNMFMyl0v9IZ7DNoE6fd2Xc48O/LMhCRbCs5OvcLb3RN248oB3hosm5v6
 sA8g==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1787818407; x=1788423207;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=S6W0GjvOLsje77xp4P+jRBvs7bZK++S21u0CgVMr8VE=;
 b=yp/bW4C5I1Ah3Al+lLsWr7/QAUv6F0MoHsi1HGw2kz2wR8rmYO5/i1E87VepL6yiNp
 6P4NR9OuGpxuUvhy7Q2dYnJIzKDQ3i1W6csQYMliO5PVsHaNxSpPMPobIrawtqYQsl5P
 FeiClSWJWk8aloI/5W6eerTadCm6YjMcoSEABRcj3xBFi+8gqrKv58yzY+UM4hnmVCki
 n/ErdmCxsKrRhC+9H9UqnxExqhgpAXLOfTvfc8RM9K7u3WjU74bFtRldZiN4aU9CBeGS
 CaE+c0S1vjfvfBEDLIfWs+ijUvSn3Hmu/eIZMGzXY+I3FhwzZCnF8LtegVcdDRE7Cv2T
 ezPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787818407; x=1788423207;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=S6W0GjvOLsje77xp4P+jRBvs7bZK++S21u0CgVMr8VE=;
 b=LtVhU8qR9oeWuq6R/t6KCuJQ4Xe8spxqm1Hay2EQK0N1/MGOo/S2Y2WThIbJoOgPSt
 pHiVni/gbTpIYvPQcI85rOt7UIlPnH2MQQ8yZlvmTVlGwp1xf9K3pk2nYQQPncR6gT0T
 tsdDdl1/BzOkBza+z3jQcJ2Aa20OUZJ/RBEEvGUz0neg4HcA6L3Q3B52vMnjH12NEaFe
 l/DS6i339fN96Oz17gay2u6ahnuW2VCNfHXltSxzT6fgkaV0i7X0RtcRyeQ3pc2E45gr
 +T5H36IwWa7AVxcsi4rDY6B57NzO92qvA99JKzy7i9Btap7s8svKKYaKd3/hNQ0MMD6t
 9FOA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr4xqVAMpzyrpzzNCMPUqejKVpQkw2gtZ5W19nCXU1YnKGV4BhsKrP3MmHQ2L7oweKDLKk8MEw=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mISHNjQzSMqHbXRnx756eaiBMPPdEfBW5pHnYIrG88KGmWxJSh
 RqIPATZsi6RI8JM2AFglZ/fQLg1rTD7A74/lnG3XI9oSicPXqv1P7jDVMcdhwckNDFN7RJcHpGb
 bwTfCU9UVVtfmYcCtuWbsbUEVQWefRODZAmqQ5h/NKg==
X-Gm-Gg: AR+sD10GtbHEgXcPqTRYTKvr9GZ9Yg9fD/+BGZJKRDmHdW7Q+KKVSbYXbDfiERDuo7M
 bTVoS/4g5V9dUZN/JVSb63vtirkkCaOqECLNrd/PrmZHvYyzps2nC6tG96sB7KAK6xhh/ot+3WH
 2JmaGi1xkqXAHKKjxFnU9RGjogALRQrlWK1fVXyx2J5ynFB13h6dvGdqPk55edLPD2Qcx17I5vD
 92i4blqOlWLVi3hA7SsOLjNu9sWmD7OXc3Y1dxk04Q0shnLIU6MA34v9IBD9YV7i6m5qJaj5u3l
 MFqzj5t6C+gmg/sT9PNoXCUBcsEIpC2ixPqR6nIKdLJGwBe2EYBoZAIAq1yZ/Jo8pHuCtcuKOav
 AMXL08ocUAyQ=
X-Received: by 2002:a17:907:6093:b0:c08:417e:3696 with SMTP id
 a640c23a62f3a-c250c318ec5mr1300892366b.20.1787818406586; Thu, 27 Aug 2026
 01:13:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260731-gpt-4k-v1-0-a3f1f16b53ae@flipper.net>
 <20260731-gpt-4k-v1-1-a3f1f16b53ae@flipper.net>
 <73745748-eeb0-4dd8-ba15-6c220037b330@canonical.com>
In-Reply-To: <73745748-eeb0-4dd8-ba15-6c220037b330@canonical.com>
From: Alexey Charkov <alchark@flipper.net>
Date: Thu, 27 Aug 2026 12:13:17 +0400
X-Gm-Features: AcwNN1U9XoTPFf9PGCyGqmVBLxPrClqlSh5_ah1scwQ7AXlDqnf_-MxlXTMxWK8
Message-ID: <CAKTNdwHh-MKxHYDjWNgC97Th-4BwbrPoB4irAdBbA7QMa9fBjQ@mail.gmail.com>
Subject: Re: [PATCH 1/6] disk: part_efi: Size the partition entry array from
 the block size
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

On Tue, Aug 25, 2026 at 10:47=E2=80=AFPM Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On 7/31/26 14:40, Alexey Charkov wrote:
> > gpt_fill_header() computes last_usable_lba and first_usable_lba from
> > hardcoded block counts that silently assumes 512-byte sectors and the
>
> Hello Alexey,
>
> Thank you for fixing this issue.
>
> Nits:
>
> %s/assumes/assume/

Ack

> > default number of partition entries.
>  > > The partition entry array holds GPT_ENTRY_NUMBERS entries of 128 byt=
es
> > each, so the number of blocks it needs depends on both the entry count
>
> The size of the partition table entries is not fixed to 128 bytes.
> Instead it is 128 * 2 ** n with n >=3D 0. The size is stored in field
> SizeOfPartitionEntry of the partition table header.
>
> You already consider this value in gpt_pte_blocks(). It is just the
> commit message that is misleading.

Ack

> > and the block size. write_gpt_table() derives that count correctly and
> > writes the backup array at last_usable_lba + 1, so whenever the two
> > disagree the backup array no longer immediately precedes the backup GPT
>
> It remains unclear which two values might "disagree".

Will reword in v2, thank you for looking into this!

Best regards,
Alexey
