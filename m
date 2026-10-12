Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D261CA9EC5
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 14:11:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4C0A180BDD;
	Mon, 12 Oct 2026 14:11:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BYZ81TfJdwdK; Mon, 12 Oct 2026 14:11:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8F3CE80C70
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791814268;
	b=Q2oCN5W7UGNMTFdHWQWlFhZQcGB3cQG5F4tP4DiyOhGV5gcM9OXiCU+YIEYC6Bi5nW12
	 ARxiUjqosrUUuqLDifPPqg5U5OdPFau7ykfTPTW3cmOzF28VoyZjtKYOgyoEVHnVrcy5p
	 e0jMXW/uAqMrvynuPeW0c7b640qwdCeaEHBDgW3Z0ov0iWIN4FUZxr/EjxJGX8ykDygIM
	 Y38fhHDHSWiePOlE8/JEh1gYRNktFOeh/iDaIqHSDKwd9j+CLLxYnlqvbdTkFdv2LTqwV
	 xFohtlFdZbuWHOMwi9jKK21GbK4L0ohocmY6lsi0zxbCA2bgqqcJexMen/Jr3hL56HA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791814268;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=8KBjwP3GSmb/rlJqiaDx5/HC+QftDBONM0/vicQJIEI=;
	b=FaiBhbuQkL1+AYTfk4FPtnwwdD+25/wCknoxvSZCvh/2PwMiWfhI3Wn/ushbvWFMKLOG
	 +zaGs53GhMQCXIw6IzxjnXUDKd0+7Ey60jroD6j7N/ZJl68F7rC4JCLrosuqiKEjM9JOd
	 xedY08sahPEq2HnTeYOwC2zXy00XnvbcTw1WSa5MkXdUOVdxJWa9NPDdPdJggSVoIqUby
	 LoiGDrzWndqCmYYq+CIGKzDnUUBbVp4D6UKAvV5ltDILV1k0pz7S8Z/l/YoG1WEzRqhOj
	 zxXtqaQbK1yjCA0qXRQBn4FBZeQKxifUEuf0bK5FfQkf6YjpWoYSHhhZEPq0jjkRAbA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791814268;
	bh=8KBjwP3GSmb/rlJqiaDx5/HC+QftDBONM0/vicQJIEI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BSLu9md+tCkzhijsRzZPmBg0gN8zSOh/1tfA4tmRrl/NuU40hggfI/x2pGbRlasTS
	 MGPU2yrme3hzwCVbosm/YeSvPGVzx9NE6oR0MXVfypRN2FNOgQpyS5AS4w7kos9abN
	 +uvwF3ifes6/ER7xc1BNN+wipyl5fiwRQGJ5UrdajMfFgV/KxoMO+NXyTK2EFe/5o0
	 XT80dKUQrvzSzcHiqKyhKegMtvARkXFnJFwR/n62Gmr8Kpt+1XtoYNV0JtvdVOFGAt
	 GIrQtllm0Rg6FjVbQZz4d9YcHLKJvSVybHS2OnYkps0FKrk5ERfDI70TNk11BMmI4u
	 NzdQCsqMmXc3A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8F3CE80C70;
	Mon, 12 Oct 2026 14:11:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1BFAA156
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 14:11:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0DE0360643
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 14:11:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id au3wOJicFq57 for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 14:11:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 472D660664
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::102e"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791814266;
 b=gg9m+qpQ7JInIxS/9dq957w38Hx8ff1BhVaQJg1eQFyMzkGJCQHrulnChQnoXtlBIH/r
 U7NGxbc6/3+IRaJpkCAXF255mBx9T0IFvjp4LkpvbQrgILsi8IUvNNEnEqG2b7fep58IK
 3MJkjo8C2ZT9sDf5vql0yPhfwHKmDiheIo09cWftGSZIE1Hk1u8ZMoH0JVXJQmrLDIU8n
 fWOnKkIE4z+crRiRxTDe5pguhjuM3163yhwuxO9/LKhqjsczYQNcvBhGBHXTCWolnGvTU
 A1tELgGchEJzNzAv27dJ+WWxjoJEIpjD/KcT7I1QC4FexFq7AjRqkNbTSM4IhxXV2oQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791814266;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=8KBjwP3GSmb/rlJqiaDx5/HC+QftDBONM0/vicQJIEI=;
 b=HxXQJh6Fiy2vRNDVlqxo7Pf5xbicYI27NPiFYBh1iTMQCadczSdBrZ/TBuhrLoung2n0
 CAlCT4Z5bkc7br6ISvmO/wu/HwrysKTt6OAbO13PSWVKbrm+nkR1TqtZgFeXzo9n98s90
 02UYyqO7tKo3+FEoClDnjdb42F+S5CoyKOIeyp3KIxbJchCfc4pDuXd6ru0Z2UEB/52V1
 87OqBPQK6IJJDer4fLT4DqVz01Q/WoE4Go7zKEZ9KGsxSf15yDzG0PshdeJmdkKGNtGtP
 dmSasutJwwQmB8uMZ4s69hK9vXSQN5fcPxXKwpG4E/BrvDuTiEYWLh5Oq+WKgyHuiuQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b="D1W/vRLR"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::102e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::102e; helo=mail-pj1-x102e.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=D1W/vRLR
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 472D660664
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 14:11:03 +0000 (UTC)
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-39647aa9d52so1106926a91.0
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 07:11:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791814263; cv=none;
 d=google.com; s=arc-20260327;
 b=f85EwTsMvkv6AoDniGUMGhSYy9QVkqd6fenoqULQIrqR8fu/7yjjQc9hPDfiIeY//N
 3e0/P8ORGqUKLuJzV7NPATLEAq0x1h1V0sxLZ9NTu9q9acoVFyBimAcY7Bb661bbPlAJ
 0ZSJQfUnRWW+HGj8YGqodbXjWZy2k95Xu5068YMXTyuv+o5yNPzSxMV/nNOB37+gpASn
 WcMoTMuIt4U0DSI7GG4vOb+hK8fjvtyKAmMuJxI2fNm5g4Wjd+0SCPqHHiQ7jtwp2gSI
 y+6zdVvtV/6QwTiXLo1ke2/p3SUj8jIelfggFn+7OWzmDPMjJwAD33iOtAhrG3CKAfuj
 hS1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=8KBjwP3GSmb/rlJqiaDx5/HC+QftDBONM0/vicQJIEI=;
 fh=iaJIqh1K5C1E7f4X1xFh1xEYlEQukaBy1UciJwMQPqo=;
 b=pXM84aSUAmLZIVAsoi5upOMM/qtz7uP6kWcZV00SqUo8955ud3rhP2np7YA3sJF1iQ
 GdSUoHkLC2DLPK0dWG1RjHznOTfSXr6s98ReL5KWrbDbbTILp5r/su89Q6kAnkws+vuF
 3UR5eurNOWhg2f3oZH2lkH4WG3eRlLlTddBsuC1SArW89mH35UMneNsWuJK9f3Rg2uFr
 3wK2zwV6PvMoOIbp6jrSMTJ0ErWhV2RaON3iGIyJIRENjXXKNW8r/uu5RcoETMgP1mQL
 OGqiIak+R93Q16Bsx35yltaBYIe5csRXYKQxz9B7yp8300bb7G2zfGSKxQln3NfWJDzz
 W1qg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1791814263; x=1792419063;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=8KBjwP3GSmb/rlJqiaDx5/HC+QftDBONM0/vicQJIEI=;
 b=D1W/vRLRMrBUadp5aUTd73C4PIdpFdoZy/FrcY1pgk43zHqxtWNEB47LJh2sYrmKqv
 37t2u6ZOHqlIJ48X4iVyfvSCTleGDJiZw7lDm3WQ/b39fVQOVD6b9yrt/9uLYv0cJ7Xv
 VCygitlyyFvrGAnylv7KSJdRl/3SvmiSammAQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791814263; x=1792419063;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=8KBjwP3GSmb/rlJqiaDx5/HC+QftDBONM0/vicQJIEI=;
 b=uq4oaVjN02w+UFA2azAcHO+3anjHZ7tc46XYGrXh+GmzOf8ySvZ6GKgsm8c7kaIw14
 1XhaPInuFSDz7l/+JQFbcfWHPA5EtAjbT1/bottNj2haWLk6j4SbU56nRiFCqfB8XHKs
 3+zWWiQi7wE7V2KJme0f70u4svDlXzkaIzyszT+TbJR6SU4kf53tLRelVGcVnprOVJhx
 NV5/A6VEINNADbXtrP38wKxTpZ5MDAMreKpiKaOUYHA6UJP+8zbdoRcoD2Ip3Udwov9X
 QeF5vUntQLmSnh9if2pbVUifp+s9SFOIESILM4e3RfDCrhiGIX7snIdybB0mUt9fiWZm
 3wxA==
X-Gm-Message-State: AFq9FYLAyrqPXIHtoGaLTXs9zw3uou7etvinicz8ojwzA2yTwbm4hXax
 PItt2LcjsNwNrPezfBKFAISstZOFKiR6IJx5EyCc+xWfr8wbMySjXAtYoHwV/d8860LMjQR7T0D
 XURQsKlTj/JDy/e8jJ4Ifwt2Ni7UaPC7CG+R4bYsy
X-Gm-Gg: AYBFou0q7lKWDjfJk6XTik78Of+j+ZpPga5lKfJB8ImxYcr1tqR3Kmwy1pFVr2l0+KL
 2P3jce+yJvxKWZ6E4rld/F9EUT8lxqddRM2Jwg6kQZGs0kFXCqF2YM3BjuMIv5II9RMOMFgfP++
 8H/oRxy2agTC/Zt49ILfHNTqXf12e8IlkbpSYcgEVqV8woKyH1fxMG7NYBy37lTfFszWUksMAEJ
 BkfmNcc374CGsMc0x2x+WRpp5CDp27yq9GI1/g7920Aiui9VFBDQG85z6n409AuXBB8p0z9ql8W
 6n9m1Mdqxj6BNjkySXg+O1n6r5mMb1YcMK6RE9HUMDySRxr6RBA9p7s=
X-Received: by 2002:a17:90b:498f:b0:3ab:d26b:c2df with SMTP id
 98e67ed59e1d1-3abd26bc4e0mr2139523a91.27.1791814262276; Mon, 12 Oct 2026
 07:11:02 -0700 (PDT)
MIME-Version: 1.0
References: <20261011152235.8842-1-aristo.chen@canonical.com>
 <20261011152235.8842-5-aristo.chen@canonical.com>
In-Reply-To: <20261011152235.8842-5-aristo.chen@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 12 Oct 2026 15:10:38 +0100
X-Gm-Features: AclHuK-P99PTRRtiX8S1fV7qd79M8NyJxME4W2T4Knl-1d5Qde8n7L8mB1rKFAk
Message-ID: <CAFLszThp_+fBpUGh9W6n7PLvNazA22emmxJ8Q97gO_k3Qk3TJw@mail.gmail.com>
Subject: Re: [PATCH v1 4/5] tools: mkimage: bound external data reads in
 fit_import_data()
To: Aristo Chen <aristo.chen@canonical.com>
Cc: U-Boot Mailing List <u-boot@lists.u-boot-project.org>,
 Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Anton Ivanov <anton@binarly.io>,
 pranavkasthuri@gmail.com, James Hilliard <james.hilliard1@gmail.com>
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

On 2026-10-11T15:21:13, Aristo Chen <aristo.chen@canonical.com> wrote:
> tools: mkimage: bound external data reads in fit_import_data()
>
> fit_import_data() reads each image's external data from the mapped FIT
> file at the offset and size the FIT itself declares, without checking
> that the region lies inside the file. A data-offset or data-position
> pointing past the end of the file, or a size reaching beyond it, makes
> mkimage read outside the mapping, crashing on re-process or silently
> importing unrelated memory as image data. An authored .its that
> declares external data properties hits the same path, since dtc
> produces no payload beyond the device tree.
>
> Read the properties through fit_image_get_data_position(),
> fit_image_get_data_offset() and fit_image_get_data_size(), which return
> u32 since commit c4d81d062790 ("image-fit: Use unsigned types for
> external data properties"), so a value of 0xffffffff is no longer
> mistaken for a missing property. They fail for a property that is not
> exactly one cell, and the import then skips the image as if the
> property were missing, as it already did for a shorter one. Compute the
> file offset in 64 bits and require the whole region to lie within the
> mapped file before importing it, with an error naming the image and the
> offending values. An empty region reads nothing, so it is not checked:
> mkimage -E -p places one past the end of the file when every image is
> empty, and such a FIT must still re-process.
>
> Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
>
> tools/fit_image.c | 41 +++++++++++++++++++++++++++++------------
>  1 file changed, 29 insertions(+), 12 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
