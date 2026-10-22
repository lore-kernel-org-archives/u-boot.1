Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1AB5606A31B
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 16:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=kHurfK/x;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ncwpKG4Z
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CE79F608A8;
	Thu, 22 Oct 2026 16:24:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id D9t2PejwHvua; Thu, 22 Oct 2026 16:24:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4327C60816
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792686252;
	b=UXY7/H7FvbvDv5Qi5jCiVJ68Hddu3lm6gCmgW+ean9c8uF2QaYSAfeDI2wdx+Fftk7MP
	 fRfd6fNWQ7yk9mNIZ7CBBLz1+pJVLRyss05xej/WuAo6LoA/MSLAIP30QkC3qLhKdMcAk
	 wFWcWTSNW2T/wgrMvu0+5lPOeGPQWx67iVFXkSZTd+RKlEA7fg17F/6SElf1P1VfYA2YF
	 E2V+15pMtHGQrn+oBtYCMcyKQp3ivLo7Mk56W7BlJ9aXBHrC/7AFw6jSXlwqkUIeUZx4I
	 0evyrkOOzMaAID7Fcju7BYZG4mRC7zX6k8icWQLD3+LcR2HSYwcPZkTpzafbX/Rzgug==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792686252;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=RB3+1te3vYk+T0MU1ZIr4OwnlMoZKKWBUeJRUMUOdqo=;
	b=QSyXtOeQabg8vptjQaCAEtaHptTezc1F+0vn8k+i+eOLTjgPoTJMlTuRJZPo9o1Jl9Qe
	 0fNdxRwLbDczg1JvFznZPbDYhSld8DNexyfrDoR1epLElLqCr8kkUdoHbMpY+zjS8jUYi
	 9xAt5aWWmqj1bzoStQd9cR/BtZyElI3dUzn4mRhbdb3pQcTY6gkqHaqhhtqq0Czei/CyB
	 dJICINKMLUz8wn/R6MKNY1bb7PdqYfmgAXwq4F3WGesFUKTlIGiXDdB+LtweT8zfSjTVz
	 qloWlWSC2CpGydk9wnr+ZEm//bUE+UYWOf7oglwpYnTxLlWO/JcvODGQxInM0msFRSA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792686252;
	bh=RB3+1te3vYk+T0MU1ZIr4OwnlMoZKKWBUeJRUMUOdqo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kHurfK/xOjZuw5P6E3/FnvtTwa3joXXCfOjNx38sWf3fgLuY12V2nwjc5txDfTDaI
	 6tj3KiPCcn5vf7VnbT2njyohWFbiUaDSVYZ+2AB3KIj5DEr1Dn4QByYOqTEFrneiFx
	 IqyGEkYHDYW095CBH3/ZzVOfq0fHa0IkRcp+k6MDZWoeUzRX/uaWWxYVFG0Us0uzeD
	 XHyHkwbwwUaB3qbHSTvJD4o3ZfAp2Q78on/6Ph2FJ4pOeWxFBXhqZVDlLKqcNSlwOE
	 d/FdDIkSTmCbiN833k0J76loeGx2/QVPqIXbeWtSgw81ezmN+zGEZetFCXbvtbOGNJ
	 lFvTb90PHOoPA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4327C60816;
	Thu, 22 Oct 2026 16:24:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 0812895C
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 16:11:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EDF5C8119B
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 16:11:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id S812dQwNe43K for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 16:11:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9FDDA8099D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::a30"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792685499;
 b=QIXHzSMz6HrWlssCjt1GVVofMUVXOYMi4Uf6KpgHE5JQtutAKWfWIf13KbAcZ+6Vt0t8
 ftAsYz+AttTcvgCR6bsxN4keBehZcurTzDaPKomeiy1/mY4K3gsPBsPvnvCA2aCmO3B/K
 iryMlMTvSk1jdsu7fX/EHQ9+tmdjBOrQO7LO81uegNVuDuYbQD1Z8C2sTb2lGgEAW3hhU
 PCOZFzY2kQBCl1YE7uxUygoZfLAjySZveDY95rXIj0OvSuE8h+I9Pqj38q4bYkwIepPeq
 KCWedHjg2RR/oEKTUTGciztGptn2j3OcYnJerUz3aKZG/IjdxDzw2YKOWXFy+zwFIqw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792685499;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=RB3+1te3vYk+T0MU1ZIr4OwnlMoZKKWBUeJRUMUOdqo=;
 b=CytUJHAbK6J0+GjD/aNvREv76U4BP/2Lc5U3LUMvtmc3daIpZdl3PKpoNcGRy6U4yHDh
 zKiHLo4UMufDsIxvqpwbI4q90j4VXD9UUdGikU8rZ9u/Y8EkFi5T43YLAUrZ/VNJAn3z8
 UOE5tLn3Gy/SznYIQNr4yuBicXUPxGmLI3AyFTuPzNNKjUgQJYmCxfD3rs2oC2cb1+h1A
 uOjue5d1bZmtOEDGHUmiRcqlFIa4l1aJ8BOz9NYHxC7gL1fFohl+V47MVdR9MWY8d+MBX
 0jR7aAsX6kMUggwhUmJUfFbr+63qspcbzzM6GS3knENIaMhskmJ9ILfqvc7/cTVZoog==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=ncwpKG4Z; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::a30"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::a30; helo=mail-vk1-xa30.google.com;
 envelope-from=filipescu.cristian@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=ncwpKG4Z
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com
 [IPv6:2607:f8b0:4864:20::a30])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9FDDA8099D
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 16:11:39 +0000 (UTC)
Received: by mail-vk1-xa30.google.com with SMTP id
 71dfb90a1353d-5eac4855401so29898e0c.1
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 09:11:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792685498; cv=none;
 d=google.com; s=arc-20260327;
 b=Ylqo9Vqj8weRL55GTzrU7Wl1UIs72+kPmwG/FkBczti/zBnYqr7p5N5zUan2f3RPCu
 OCQhxzHO3tG3OZfqHcjf3BUj1WZO3olbqDuP81HZwMxyC0veroCRT4aP+mGf1MBqqBcK
 29yXPinxQlJ7NHjP0jUGDh+PjjtUdccHJRAx6tq+Ily8diDLpuY3Y0uy71s7gDp49tVe
 bkLBgmxOQhZ8mZbGjLpWNhu9YNR4SI/rYLzWZLtd8IiFo8Zxw0wfuDj8/961XDJDCLgb
 U1IBx3qstAc4jak5+lbAfxUNZEOuzJ/Fh6a09PguGdOHmBrGY8a+7UhYP6m3lU0zxFXn
 QQeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=RB3+1te3vYk+T0MU1ZIr4OwnlMoZKKWBUeJRUMUOdqo=;
 fh=5mzZXRh12SwjxXXpGlHz/wL1CSZFTtxdNcYc99xe7vE=;
 b=NOOcCBw7Zw6J7SHckXGTLxmOthwrRF3kzeLNAhJQqcl+dvinp7NHe7ZkV6sG2Rv+6Q
 Vg65eGRTmCWgveTjpw0n0CnKQjjAG7d8HdCHCh8XEGg/ptK1/VpZPpOSwg+RNmVTwLSo
 qY3XXGCFTihmvEdZ6t8lStLHPjFUFC1uDZLGWK+GjvKq/eI9cdUxCSQWbitcEe+Lk+RX
 aceom5qfeY5xkpD6Clu12CL9GWoKqDu73O+UoqsOLnDihTanbSgjWOvSaq3px2HmUqgh
 IX6j87eKWyNgx8JVAx+wHqcs1xLyJo1VjqibBdJQ74TdZhhElrZD7LIrXBT2Mon6OWlE
 SHjg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792685498; x=1793290298;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=RB3+1te3vYk+T0MU1ZIr4OwnlMoZKKWBUeJRUMUOdqo=;
 b=ncwpKG4ZBKhN/t5SkHCBTBHawCwKLMrEe3ZL0DW0fG2Ju1b+o1DR5+7HurI2luOwAf
 88VYE0u9xO+9Vyosvxi7KVyoA/QcGA61hbo6/DnIub/kY0YFVIaU1kxdi/v0m0PxOeYE
 S8ecqzQdx8vee+hU8okpO1WspMsQuwDcBSCpZxA0RQEeyaH4UktgdhF4RImja9AZb/pI
 V9pERY9QNopQx41SqvUplwDDlB1Nn2nhrWRZHKNI1mFzhmAQv4hcYIsTOGApM9OnfqR6
 TBnr5gY/I1MpWdCLusMCV9EIASG6w9dpausHXMpsziG9QxkPoLeksDeEDoS95NJF8C5u
 l4pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792685498; x=1793290298;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RB3+1te3vYk+T0MU1ZIr4OwnlMoZKKWBUeJRUMUOdqo=;
 b=v/8JvhTKtT8wDu6FVBGG16RgiMuq/Xh5AygElBf2JZmyuTs7MxSpmjfDOQYggbygaO
 FfrBKin0G5IqLiI0c8nNYMP4RjqPv5O9mLnUblBHCPVGnl2EuJ+cqGtE7piJcdUDXLrt
 RcUqv9WYBtSbEq6U9nZvbeI+/Guxg86gj4mSncfQSAEIcbSlihHtav0DBZpAirxl2Nwh
 Ai7+L7DISAvlZZ2/LcHXGzdADpuMNofW0SBwPovKcDiF7MSa+dMYyRmIp7hmK/LZoF25
 oFHct1Eu6K2JASmP9yQnaZuj/z2nGhCxOKvx66K4r+rtUKtCp2B5A1+kb3pCfeZPFZSH
 J9eQ==
X-Gm-Message-State: AFq9FYLi10W3oGibianZF+xPxTVT5VpF3PdrzIjKdeQ6t1gYinMJCODG
 RVBiQac2UzAN8UH6nvvqIIowTq65eCCFC/9aiiQsjZDxEiRpmsvWGUvhRF6LKzkGRkIjzb3tRvF
 i6zvv327fXlgD7xs8mu1kOJmazYBWbbA=
X-Gm-Gg: AYBFou3iFll+u8T8Zb4DpteNE3W0fw7dIS8pNxmr80broIlb9fNYp2qoPH18dfIKYbs
 J2RLppCSHoU5wj1GVXH0mFMxWGIi3qZNITrhXrD6r3kVCTx2iuk2HJhJq7PUmsGEIpfX7Ho53Rl
 BTgECqSnWF6sq6/GqwbLM7FtKUrcmW7ec6uYCtMUVIQsRlsg7MLYPNV7Mjxgz5uOV+zkSJIUCQL
 LgzVPdfypkZPAvhE1hD36cas6Sjz04wdPt0hfs7B0MQrxpYph6qoF5UgePzKtFLPY5rgtndOONX
 DrBj4OJErCBUEnGJ3v3bRYj3p+RzRMdXC9+YTxQaaMYCpwAcGIylUI8f2ZUuS9Rfu7oO2yic5hB
 od+8BZR6n6A2JSCpRKaworCA95QwCtRd1lKtjfM0GCy1dYASnjhM/Y0kcEgeb0Nbv6NnpmQ==
X-Received: by 2002:a05:6122:46a9:b0:5e1:c1c8:9ff9 with SMTP id
 71dfb90a1353d-5eaebbf8028mr2771080e0c.2.1792685497993; Thu, 22 Oct 2026
 09:11:37 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261022-sunxi-orangepi-3-lts-v2-0-46b9df5f9e43@gmail.com>
 <175a7f33-a567-4c6f-b509-3b796e09f879@arm.com>
In-Reply-To: <175a7f33-a567-4c6f-b509-3b796e09f879@arm.com>
From: Cristian Filipescu <filipescu.cristian@gmail.com>
Date: Thu, 22 Oct 2026 09:11:27 -0700
X-Gm-Features: AclHuK-43S2AxVsVibB8JHOxYdzudPdjwHmdj16kKvSQMIs-KwxWGZiQISPm8BE
Message-ID: <CAH87RzTqxM8H3UqBC4e3-8xQzJ-_dz75F-waC8bkrv=LMcwbpg@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] sunxi: Add Orange Pi 3 LTS support
To: Andre Przywara <andre.przywara@arm.com>
Cc: u-boot@lists.u-boot-project.org, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Hans de Goede <hdegoede@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 22 Oct 2026 16:24:10 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Andre,

Thanks for reviewing, and apologies for reposting so quickly. It's my
first patch submitted, and I leaned more than I should on the LLM
without doing my due diligence.

I will hold off on submitting any more versions to this one until the
DTS makes it in the kernel.

On Thu, Oct 22, 2026 at 4:48=E2=80=AFAM Andre Przywara <andre.przywara@arm.=
com> wrote:
>
> Hi Cristian,
>
> please try to avoid unsolicited new version posts, in particular shortly
> after the previous version.
> It's not like maintainers and reviewers twiddling their thumbs waiting
> for new patches, so please give everybody enough time to have a look.
> I'd say a few days at least.
> If you find issues in your own patches, please reply on the list,
> pointing this out. And then still wait for proper reviews before repostin=
g.
>
> On 10/22/26 07:55, Cristian Filipescu via B4 Relay wrote:
> > Add a device tree and a separate defconfig for the Orange Pi 3 LTS. The
> > LTS has an H6, 2 GiB LPDDR3, 8 GiB eMMC and a Motorcomm YT8531C Etherne=
t
> > PHY, with power and reset wiring different from the original Orange Pi =
3.
> >
> > The device tree is based on Jernej Skrabec's Linux submission:
> > https://lore.kernel.org/linux-sunxi/20250413134318.66681-3-jernej.skrab=
ec@gmail.com/
>
> Which had comments, so have those been addressed?

The Linux series is also posted. Several April review fixes are
included; however, the LED drive strength and faster eMMC modesI
haven't investigated yet. Looking at it now.

this is the high-level of the fixes:
- use hyphens in oscillator node/output names: ADDRESSED
- use CLK_OSC32K_FANOUT: ADDRESSED
- add input supplies for GMAC/Wi-Fi regulators: ADDRESSED
- Keep BLDO3 always on: ADDRESSED
- document DCDCA/DCDCB polyphase arrangement: ADDRESSED
- correct Ethernet delay configuration: ADDRESSED; Andrew=E2=80=99s suggest=
ed
settings passed the DHCP/ping tests
- explicit LED drive strength: STILL OPEN
- enable faster eMMC modes, including HS200: STILL OPEN

Following your defconfig reply, I=E2=80=99ll remove the custom LED handoff
code and return to the existing SPL power LED configuration.

> > It lives under arch/arm/dts until the board description is merged into
>
> Please don't do this. If there is a mainline DTS pending, move that into
> dts/upstream anyway, that way we don't have two versions of patches to
> deal with. We don't take non-mainline DTs anyway, so the support has to
> wait until the .dts ended up in a tagged mainline Linux release, then we
> can cherry-pick that DT patch. Compare U-Boot commit 4112b26537cf04 for
> an example.
> For the sake of getting the (defconfig) patch out, and allow people to
> play with that, it's fine to post, but in a setup that matches the final
> submission.

I=E2=80=99ll use dts/upstream and make the Linux dependency explicit.

>
> > Linux and reaches dts/upstream. The current dts/upstream H6 SoC and OPP
> > includes are reused. The original authorship and sign-off are retained.
> >
> > Clock naming, regulator supply chaining and BLDO3 always-on corrections
> > from the earlier review are included. Ethernet uses the Motorcomm drive=
r
> > with rgmii-id, zero MAC delays and explicit 1950 ps RX/TX PHY delays, a=
s
> > proposed during the Linux review. This configuration has been tested on
> > the board with DHCP and ICMP.
>
> That level of detail here and below smells like an LLM having been
> unleashed. I don't think it's necessary wasting people's time with
> details that are also shown in the diff.
> If there is something surprising, it's worth mentioning here, but in
> general I would expect a simple defconfig and .dts post to not cause
> much problems.
>
> Cheers,
> Andre
>
> > Validation (including the earlier board build):
> > - Cross-build the revised orangepi_3_lts_defconfig with GCC 14.2.0 and
> >    TF-A v2.13.0 (sun50i_h6, DEBUG=3D1). Cross-build the original
> >    orangepi_3_defconfig too; its handoff hook remains an empty return.
> > - Verify the LTS DT model, Ethernet configuration and final combined FI=
T.
> > - Match the new defconfig to savedefconfig output.
> > - Check both patches with checkpatch.pl --strict, excluding only the
> >    FILE_PATH_CHANGES warning: board/sunxi/MAINTAINERS is updated, but
> >    checkpatch recognises only a top-level MAINTAINERS change.
> >
> > The GPIO LEDs are enabled in main U-Boot, with green PL7 on and red
> > PL4 off. The early SPL LED is disabled. At the OS handoff immediately
> > after "Starting kernel ...", the LTS-specific board_quiesce_devices()
> > hook switches green off and red on. Linux's LED defaults retain those
> > states; diagnostic userspace clears both before starting the shell.
> > Cristian confirmed this sequence on the corrected 60d788d7056c build:
> > green in main U-Boot, red at the kernel handoff, both off in the shell.
> >
> > On-board testing of the pre-LED-change U-Boot 2026.10-gc8f95275fc8f:
> > - Reaches the console and reports 2 GiB RAM.
> > - Enumerates SD at 50 MHz/4-bit and eMMC at 52 MHz/8-bit.
> > - Obtains a DHCP lease and pings two LAN hosts successfully. The contro=
l
> >    device tree confirms phy-mode =3D "rgmii-id".
> > - Enumerates EHCI, OHCI and XHCI root hubs. External USB peripherals ha=
ve
> >    not been tested.
> >
> > The submitted v1 (11d60b7149e6) also loaded a mainline Linux Image, DTB
> > and initramfs from SD and reached a RAM shell with four CPUs and 2 GiB
> > RAM. Its test-kernel configuration caused a PMIC I2C failure; Linux
> > peripheral validation remained pending in that first test.
> >
> > The v2 build (f5a667df5ada) now boots Linux with CONFIG_MODULES=3Dy int=
o
> > the RAM shell. Linux initializes the AXP806, enumerates SD and eMMC,
> > registers eth0 and all USB host root hubs. The YT8531 PHY links at
> > 1 Gbps/full duplex; DHCP, DNS and an IPv6 Internet ping passed on that
> > build. Two direct 8 MiB reads from each of SD and eMMC compared
> > identical under Linux. Two cold starts with LED, shell and Ethernet
> > checks were confirmed on the final build. Both LEDs were confirmed off
> > in the diagnostic shell. Sustained transfer, external USB peripherals
> > and HDMI remain untested.
> > The local test builds omit optional Crust firmware; suspend is not test=
ed.
> >
> > Signed-off-by: Cristian Filipescu <filipescu.cristian@gmail.com>
> > ---
> > Changes in v2:
> > - Enable GPIO LEDs in main U-Boot; drop early SPL status activation.
> > - Add board-specific U-Boot DT overrides: green on, red off.
> > - Set shared Linux defaults to retain green off and red on.
> > - Switch green off and red on in the LTS OS handoff hook at Starting ke=
rnel.
> > - Retain the original two-patch DTS/defconfig series structure.
> > - Link to v1: https://patch.msgid.link/20261021-sunxi-orangepi-3-lts-v1=
-0-19a3df928d8e@gmail.com
> >
> > To: u-boot@lists.u-boot-project.org
> > Cc: Tom Rini <trini@konsulko.com>
> > Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > Cc: Cristian Filipescu <filipescu.cristian@gmail.com>
> > Cc: Andre Przywara <andre.przywara@arm.com>
> > Cc: Hans de Goede <hdegoede@redhat.com>
> > Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
> >
> > ---
> > Cristian Filipescu (1):
> >        sunxi: Add Orange Pi 3 LTS defconfig
> >
> > Jernej Skrabec (1):
> >        arm: dts: sunxi: Add Orange Pi 3 LTS device tree
> >
> >   arch/arm/dts/Makefile                             |   1 +
> >   arch/arm/dts/sun50i-h6-orangepi-3-lts-u-boot.dtsi |  11 +
> >   arch/arm/dts/sun50i-h6-orangepi-3-lts.dts         | 362 +++++++++++++=
+++++++++
> >   board/sunxi/MAINTAINERS                           |   7 +
> >   board/sunxi/board.c                               |  19 ++
> >   configs/orangepi_3_lts_defconfig                  |  19 ++
> >   6 files changed, 419 insertions(+)
> > ---
> > base-commit: 62c9805d8d57cad407f0295879cc9a6182da464a
> > change-id: 20261021-sunxi-orangepi-3-lts-2fa76de6f361
> >
> > Best regards,
> > --
> > Cristian Filipescu <filipescu.cristian@gmail.com>
>
