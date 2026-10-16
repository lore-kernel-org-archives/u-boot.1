Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D505CC6B38
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 14:34:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3AFEC406E2;
	Fri, 16 Oct 2026 14:34:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Fc9-xxuNF94r; Fri, 16 Oct 2026 14:34:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 72E4E4076E
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792161260;
	b=qRkQiNe+wUVv3/NihQDXvtHqzrMgHVeAChO9OXNRlc97zxZvAjMubYot1lIGUJvxoWu+
	 ctU7ECxmNVO2qQ9j/vE6JRLsefqbmFOByGQQDoWcjIhh003AK6feU1AtkZW5Vx+9eqFz4
	 Fl1nZx1jwhWPJr8mhWoGgBPM6+Q0izwxTqdNrkSTR9Fg9dDbi/K81F3a759J12rbNWCvB
	 LDx4CKcxHxxHa8tN8KkDJJ7QR6PZ1bwyUm7FP5QK169Zpj6AhX6IVDL3i4jOZiCjlfjg5
	 0QEYfjsSCGl9dte/LLDoFz6VupKsXfK01rB1h8BPt2FiAVu7cawjJb8cty4GvOiQ4fQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792161260;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=pLA1znl9TO0vRAk513XefX25kplR2Iu1ShUIG6hnbGw=;
	b=iIBa3fHS3zv8hRNqlL/lyCdyVeJggnO6nHmktmAQxE6gssEj7YYyP2dbUJPbvvXBmmBs
	 O9B4Pxq9215UMWgN/v1+J/kTKu17IeSWXaR6Efbx4WqOggavbQoJvvJVo3D2VE/B6p9MC
	 27qOSpCbi+01G1u3zxA1AdM8EvhfB0jpB3yyulgq+Rp5Wk21W/szc1pyos88GCe1MIonk
	 ziyolt44FSv8qAiBX70eXqpmTRyMgR0wC1ITQs7xfy73NuvL9wuX+dua6pmD/DOw+KINI
	 o8pHqfXffJe832Wi5PaC3M53eygpjE/EsyMPELFXnnxfc6yavpgmghZ+DfrcYVqS0EA==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792161260;
	bh=pLA1znl9TO0vRAk513XefX25kplR2Iu1ShUIG6hnbGw=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Pt7OqvlzzaCln2UL0E+kvdy6YGmJzl2NVdW3yVZ7uJbPz8eyORW1CKxSNOc68kxlN
	 0lUSheGrFFnfh1PS4miNAMrNyBgaxDPlvbyB00fRmV4y1Kt2HzMV7i9gpacWcovlSE
	 DRHs1ggOyyagDnNL7tvcem9bXDYJSnol+KMItPbML/D9VOzJSpIY2p8Eh5BoADx/L/
	 N4nsrgQVvnDKnCuSPeYjyO5Zm8PdnpQ1o9OVdW3l4IL7gcRMeLKFSekCsyVrxaLt31
	 GrV8mEvcV7hujVRwCyX/V9+wHv3pD5OoZrViRh5Qwo+rTPZXG/tIc41hOc0FW7BHMU
	 VG5GcdnPlrynQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 72E4E4076E;
	Fri, 16 Oct 2026 14:34:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8CFC0362
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 14:34:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8A9CA60AD8
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 14:34:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JpVRn9UdiQ6s for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 14:34:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org DD73460AD7
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::52f"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792161258;
 b=HXITDJLGjYuDQViBpjgUA3wYcwrUQ9vS/eG8e6txYUEge+ig3fAjSH8XZI+9+ctR+bV4
 OuPftQ8gpVzM7/xFaF9VH5ctrHS/chRg6Jmsf2/y33kJFB/DTfFxTrg3ba5xqxqQrua3U
 uNLzyDZtu1gK1v+hHZehRXIh/ueoM8BsbG2/utTZgdBV1pa2djQAdzXmq9Expgz1pevIL
 TsX99GsNd+lpB6b7Bcw3OcqSD5Oq/KvukJWYHbXnm2rCm/UGlHr0qtvfKQj3RCXU/KptP
 tDkNOhBmX8Avu2cNk5rVFMTb2evZ3t8JmWZRoMoJmymSwifgbUmV4G1R671KM+HmF7g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792161258;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=pLA1znl9TO0vRAk513XefX25kplR2Iu1ShUIG6hnbGw=;
 b=XjctJFF4OO5GcRmu9novZPRosThxOz3TZv1EddQ1O7qpzw3oxmPZCiPGn+pqjTJLP8F8
 7E1fC5xQ0q58Mavl+uPoegfsWuhVcRlPyd6PtYj3cK25KWlMSJHNN2LDkE7qvocxzWoY7
 ku57+JH1sK3ZySupSlnORlDLGAXCThR90in9GciCvKz8Uz+y9/hFg7h879Q5lMCCMCyZd
 iR7O2KPFvr7cczokMEQvog54+0zUUXb+y+pmWAk1NqFW4+XFB55U1RR/cq7uloulhrAtn
 Wwcn9JKcIKW+2FD0B3uIhPL2MmvdMwYSjTnvtT9ZozehZ9lwF8gNq9Bm7Wq/jHYcMAA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=UHjb5xoA; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::52f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::52f; helo=mail-pg1-x52f.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=UHjb5xoA
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com
 [IPv6:2607:f8b0:4864:20::52f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DD73460AD7
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 14:34:17 +0000 (UTC)
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-cd5cd8d89a7so11730a12.1
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 07:34:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792161256; cv=none;
 d=google.com; s=arc-20260327;
 b=C7zenWTL6qiYl1dzt2TqZhuZjBV+XqrIlC6KAbac2iyOjRJZoQf9ftHCXYDzVCuTUx
 BlEpAknQ+CBofD01099RdmKGFcbcU2ex4JV+4OTdJe8P1vgU5oBtcJwh7kT3FdsfCWLy
 sLz4yhgYnSN6NyaMH4Kc3Ta026aWo30y0mCInYKUW4jqZ9EfVcTnSX4NBxRbTpMm8xK2
 vu6noiS3oKcIHgweFejz3JraTCh4yYdd6IyOgBGfW7fDkwObBDo+AeT6tpU3tOb8h7lV
 wSqaU0Qa/7KKRS8Y2DkjmZuAK15o7EPexKp3jCx8q2rPN5VVfibNgrfN1G74ncZK2lLp
 I/kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=pLA1znl9TO0vRAk513XefX25kplR2Iu1ShUIG6hnbGw=;
 fh=cC+VSyQ9vECMxTl2USSTVlNN20vTibmKCymGAzgBEUg=;
 b=iCQIasUB/HEn8DXyBJySXMVa/es3z+5JGK0GQvB2xnPd7XE7EMZfAZTLZCK6EShIZT
 6zuNheF7pv5vp4DhIM707EqX1bsJZzY58ETTbaPv9KlAhRIs6xJGXxPFbiYH5gurKAsA
 xBf0xNQeHqNFYr15e1y1U+On8ssVgz4ce3paHqy+3kJwXjBOe6O2rQtB+nU5UPB8Jaos
 6QZ2nTJGmn4/EVFv51fS0ibbRu9fiZ83PXA0Chg2cVGfZWeIg6o5ouI7zxi+Fb/d139X
 TiJB6mUBhMVbuEge798eENS9DlT73E+w60pzaJ7oRjm/aaWCUJ2Eae4tttye0XbBTPfT
 lidg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792161256; x=1792766056;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=pLA1znl9TO0vRAk513XefX25kplR2Iu1ShUIG6hnbGw=;
 b=UHjb5xoAI1egGy2bBaELPvaMSwhBcWtQbtjNPHUhNvmsGSpq+Vm0163QRLwfud58hD
 w14wqyt6o5VXUPNpjymn78fEI24D3IZE9qwtkHcDnxxrzY/z6TwMPVjjECcXQzyeTrhB
 RfW5RS9bQQV+/H1Rtkp8jGxLzApLfGvRfyT3k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792161256; x=1792766056;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=pLA1znl9TO0vRAk513XefX25kplR2Iu1ShUIG6hnbGw=;
 b=jgg02EUkNaCEvmsE7cUJFGl3Ub82iucx5lArLobVlBeQLQOnzIw5bzEksUAM5vsYGk
 KaYYwnRvmChLxWjpYBWU5scEeq5CNFDEeomeQ/Ji9P/Z4qXiCEnXkbti/FMA/xUjX5vF
 elT1a4pYD5emDBXtzanIp5DrHKl0/MAjnPSpMjJ2ijoHhk7yxq6y+HaZDrqmugsIuklk
 9dWPKHEYh9JDLYbxNWo8VatIlbIB7hFadTXQzdIoDZlINFfinFn547q9ePff42btpF2x
 q3o05uS+eb5Ge6jHOqdEt+i820iAzbv3hMNTjpD+qlDhqtBPB2pCMBtO424BR8ce/o0R
 OX9g==
X-Gm-Message-State: AFq9FYLCb37lyUYXNPXKfBjJBScGmYDjXJmayD+0/0ImpWPAiKlTz3M4
 hCJhV51XS2sOsaGOucUpyS/jLCVTnxkobkGWpCdDizu0NrbSeclmV6CCYOccP5rXtVXh/SwcANZ
 2/zI5GDGSUk4Erk3GuLkzHdahkleHSVAGj9M6+eBQ
X-Gm-Gg: AYBFou1817z1gvF67+682Lmt1WiYMS95c1s6cbLknYBu/5v1ooVi5c/IzguOiwDXnca
 BzMIFa+8SflDlfnMs7ntoN0lEjtr4iQbas9RBBJnc/ynhl4z7zXeRuFCfPxPADqGvMCfK66fXLm
 nLytu9DsMk3xRnt112K7eI6osUlHJVb96jNM2mC90BXVdgKqCca5q4U/WxRNSG7jGkN/JcI4L7L
 1TXv/V3+U2v0d4V3S2+X3zMPrHQfs0CEPJtYtMOq7xm0LR/zp1rufPA8ZkDFK+4fAf4lqsCrnT5
 7iBjTPV8wzwrr6PBnP4lYbcXABO1cqoblhxfMbagJmuS74W4rlTrEw==
X-Received: by 2002:a17:90b:1d4c:b0:3a8:cb54:e132 with SMTP id
 98e67ed59e1d1-3acef148617mr21194a91.49.1792161256561; Fri, 16 Oct 2026
 07:34:16 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 16 Oct 2026 07:34:13 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 16 Oct 2026 05:59:24 -0700
MIME-Version: 1.0
In-Reply-To: <20261015111328.1269775-3-bin.meng@processmission.com>
References: <20261015111328.1269775-1-bin.meng@processmission.com>
 <20261015111328.1269775-3-bin.meng@processmission.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 16 Oct 2026 07:34:13 -0700
X-Gm-Features: AclHuK-DVBiUj_ng_QBahJRZXnA2U6yl0FoPL6Z-HjtGKUcqtsr1yszG3WoS6fg
Message-ID: <CAFLszTiwcfB9FXvMLhwoTtqG9oPG6jF_eVuWEWJMmuTyAn23eQ@mail.gmail.com>
Subject: Re: [PATCH 2/8] virtio: pci: Fix legacy private data lookup when
 deleting queues
To: bin.meng@processmission.com
Cc: U-Boot Mailing List <u-boot@lists.u-boot-project.org>,
 Bin Meng <bmeng.cn@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
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

On 2026-10-15T11:13:15, Bin Meng <bin.meng@processmission.com> wrote:
> virtio: pci: Fix legacy private data lookup when deleting queues
>
> The virtqueue's vdev points to the functional device, while the PCI I/O
> register mapping belongs to its parent transport. The current lookup
> therefore treats the functional driver's private data as transport data
> and uses a queue pointer as the register base.
>
> Queue deletion can overwrite the queue's list links and crash when
> unlinking it. Fetch the parent transport's private data instead.
>
> Fixes: 4135e10732a0 ("virtio: Add virtio over pci transport driver")
> Signed-off-by: Bin Meng <bin.meng@processmission.com>
>
> drivers/virtio/virtio_pci_legacy.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
