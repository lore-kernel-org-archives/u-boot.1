Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A94CCA5FC1
	for <u-boot@archiver.kernel.org>; Sat,  3 Oct 2026 04:38:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0A8F640764;
	Sat,  3 Oct 2026 04:38:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Hj4ZUqnshw3y; Sat,  3 Oct 2026 04:38:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 98A1B40729
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791002325;
	b=MDE2WCL2mCkVCaOvpi6j2plxFZeoLco2eQKh05ZzVqkUffN06pplwJNT58WLIy8Y7kkM
	 b/MH+t6NoMTq56iIRZXXgVitR+xl/mOCrkDr5L0RduYDNponmkMJJ7llyWLL2ptFErIUy
	 +vpU2d6pRCyjfSB7tPCD1pi5mBVNf4OzFcMbX2QyyJAdrKr3J3PSF3rJuQEuOEMDZE/hE
	 5MC0NUhcqUtnR41SAH6Ho5ZQBULKHHoI+6dKpZ85zBFIkQ+nMoumkL0t0pSn/XPB9Nylt
	 c8DJhaCUSEw6qXDC1d0k+oBsnFwzzris6ok+WiB5+wY07d6rxocnJ+dljmmnMYolngg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791002325;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Vlf1yhl9WkWNYMLbU9b2WWrzMBqHWdBbdmre65CngmM=;
	b=AfzMJgsKsUWEXS0BnINYoD6cULGZgDgC69ONdUl6+qurEKJkIFNVJn84M0pQWxoL1zv1
	 N2YpKqsGO2LvKjcpyLl14SJwjuocOBp/oJFuAN6oFq0WBzc2Fyq7XA+pKks6esH8ckTfV
	 JoawRZVOP5wRub9kiOgK1NIedihehrZnpTjOo+Kai4YxiMqgLAnf/42JiV8gaE1QS81FO
	 Z93/JAxeEPe14sl16lJVytCum5+CLSnvV/pcRYTyRxxtpYFfWAGnh5O1BAE4APodE40QX
	 jEWFoWuLLMCaH4w+eYEdrXU//RY/lQejN38/e0+q/Bfw6j4dRq8PfN/G672agYT3RIA==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=aJjCNk8x;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791002325;
	bh=Vlf1yhl9WkWNYMLbU9b2WWrzMBqHWdBbdmre65CngmM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gKgayMmsWp+xzimlxFvufD8HB/k8iBW7++V6dGD6DxT2nGL/ZUgF4oOrFb8saxn8y
	 SDt0nbYY9LRYiBc7gVZy68OIktKFE0FsqFcVwgZ8vn9AaUSIJ/QjjBYb/o0ZZ0ZXEB
	 Zpy3ygiZYkBGKu4VSd9ZmVU+iifwQUI0D3H1jxYKRALfY/+7gpG317n+j4eqRLTLXZ
	 c00xHXy1piujZZDbULKHKotW8X7yTjGtKDAP317aUxp1gOjGrS0vsEQ+yqFEw75ihj
	 Un+94QhY0kjyBtGMG6dSUWqiy/J8brKzLARpFLXHLpDRWfem67VgHNuwajbH1Q3DmL
	 oVGiGuStK3A7g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 98A1B40729;
	Sat,  3 Oct 2026 04:38:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 69AEB32F
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 04:38:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5B4DF40729
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 04:38:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fhTRBEnhEqAF for <u-boot@lists.u-boot-project.org>;
 Sat,  3 Oct 2026 04:38:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 48A1040728
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:34::f"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791002323;
 b=WgQVe3/70ZFvLgTbZbbgis3xUz84smSRNfUfdoKV04vcyu7wWrw+tbjgFvbtMmD5lXNe
 RDelxopFFYL08NBm3Rre+MtYCX+iiboAcg6CfPnwWEJ0p3KPbJNq6fNyY2Hxw5tEyAuiR
 mnZjmxf02r69y4t4EzHBpA7yuYHiD4zOHNxQaviTZeRVoTelQBgHtKPCYR+8fx+pXTIAH
 GfPMbN3q6fCTyEHP4FSh63ryjBZmRewgiI/GkO7lqgP+Ekj8pgqHOuZZoNqqQ9ojZ7GWi
 Wzl9w8dSJuIoZajUmVEolDbyjYLP/pFU4ijTXJTbiAv9Y78CpFIlUbWqW4RIB6Nij0Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791002323;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=Vlf1yhl9WkWNYMLbU9b2WWrzMBqHWdBbdmre65CngmM=;
 b=AGmy9xLue8L7UNid3Os6uSN7aRPhkGlH03IgcjRwaVtSan3ZADecCwsxF22Y6HHaewXs
 c7mhtgMvXlk9ZUUVi33ccmiVMTf5e1hwyCUScVNkVGGNVl+mzwSG3PXcvVLYqbWA1RITZ
 cDD11147rApbVeeDkwLLy+qeFAnOmSHkhOjaz9STl8LZE3oeLe+f8UkY4VGBexaTfKZyU
 OD5fFFKPnexQu5z/7/tvLbYwDu3hvG3VyJiyBvnETXM9OSjGGupX+sgFz1PnVVlvvdTX2
 nWHU09Qk5e2t2T3WU1ltshKkB1mPsblX+CZ5o3vkJckTVmKUNHKBu6MHaPy0ZtDb1jQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=aJjCNk8x; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:34::f"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:34::f;
 helo=mail-ej2-x0f.google.com; envelope-from=sjg@chromium.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=aJjCNk8x
Received: from mail-ej2-x0f.google.com (mail-ej2-x0f.google.com
 [IPv6:2a00:1450:4864:34::f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 48A1040728
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 04:38:42 +0000 (UTC)
Received: by mail-ej2-x0f.google.com with SMTP id
 a640c23a62f3a-c2e1b09e0c7so61317066b.1
 for <u-boot@lists.u-boot-project.org>; Fri, 02 Oct 2026 21:38:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791002321; cv=none;
 d=google.com; s=arc-20260327;
 b=PZaz0M6VtkYkyy0SxQ/+Ag2eYH4jS+jxUM2+/vI4laxqVb6Iw0mNE8NBnPGOEPVRVx
 lpv/vGErJNL8utGOgAYjiogfzS/njVs/bRKYkP0L/a8kaFNhcij0UuYD2GiS75NKlb8S
 7w3zw1Rjl/einiFa90Rr5ZTc35VV4vhx5ny+dFuAjqTjNfXrekh6L40/NsWAN/tkzBJH
 U2/2bCgjU2OszNKUz3F8hMFyTwvR9+3mgUFEN7ZEVr1tpQdFjeYS+pUKgeYSH65beUgT
 cLymiCaiT9ljWRR4Gk2lbreNMasTsDjRah2QI86d3YtXHz6+DlsH1wzHdeVR9Lz4flz+
 wf0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Vlf1yhl9WkWNYMLbU9b2WWrzMBqHWdBbdmre65CngmM=;
 fh=gfhgsB5kmREgBC8popE1L/sKuos7PQJXqWzBBz+Q3JM=;
 b=dBffZKGtPq9YKYzRoNi6oaTMjitZtwSosVfBK609K2WBv3ML0ZzvK9jWd8JVqJ9vYS
 j/EhWaw0LuInntDJSAe5XQD/rwX4wQ7eNuF4z0K0fXAMViru7d0J2AT3NxgcAlfVcEpn
 dddDGgRfv4FHbiNJAUL1rvQd0MNdOfIbljk8K7qsuGapRXJagk9REu4hUk6tE+1GURr3
 3pgxjI4cLLIbEOjswSV/pvTTk4nMj+cGuSWDS6iJf/mZhFngBNJixi4zw4PO1rQTdwu8
 lPLHlEga/azVMsGCsQT5+gEJC60njbvxOKNadZNE+af3hqCUirzzdyM+8s3+2o/JnDOx
 sHGQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1791002321; x=1791607121;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Vlf1yhl9WkWNYMLbU9b2WWrzMBqHWdBbdmre65CngmM=;
 b=aJjCNk8xzLnSuoyEOYyQUN67My/WtevWNNbXQCKTFvYCQBbQB5bFhpAyXej7YGlPz4
 icx724QxbDiC6sEJkoiYI89+uKsq3b5eMtudG87JbcP4aDREeKrq3x/NIHDLe1SpYN5E
 0eDtSSYo5LrgsTWGqmOxCWzfe3OyYvoyDvISs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791002321; x=1791607121;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Vlf1yhl9WkWNYMLbU9b2WWrzMBqHWdBbdmre65CngmM=;
 b=ITutAIsKrfDhodXPBuxDyxGAh04exD83rsM89iinfwh0c+3NxpCCJJGkKksJpPSFq+
 7sM1T8PlZtsSCvsns2buSa7pyOV0ctGNjGPRGETo9Jx3i1yjWjrD/oP0EABMQbbw1jyS
 9Reho9H8QrM4rTq4J0CCsaveTh6gqmp/NX/qg+mjKGLpMpJNfdQzaOBel4gVh6Xe1eqg
 8U4SdojPksAEzmtDdoX3DDs8s4oAcGzy0+QmZqAiCH29SeU5482ChhLrRXBRoWX2VttN
 NwNcnTe+3qujXs245XewMYZoctWl5s6EO6ovI7Ow8Fsk/HM1646cdyfN/S1Nx9ILcLs4
 GeEA==
X-Gm-Message-State: AFq9FYI5ShHjfaiQxHqZHW7KOCEgc4H3iVYJFThg+py1qvgu1BlzGJC5
 HmesOtNCLeOqs/Dbipd005jydsweoRO0gXBMk6jUEcntXTazeV9iblR2PXv40Ilwv1csQ1vGR42
 pSbRltOithUZs2KtxO9VOIcmBW6qjiN8oPuTGKAKu
X-Gm-Gg: AYBFou0SFghbJPn63G3XfNTJTIhUZhu7v+j8afhI6hWbF3qXwVV1sHAAtBBawBozDoC
 qcFAPJEZvVZxQ9aX8V2Jmk4dUqzOr83vrrweDK3aNYuS2EZQnO4w2B675x8iyqYbfmVsHBjOd7h
 GaD3TV/RZgTADtIy/ZhuxjhaA2frcIiArdVkd6o5+ep80/OAxNRfn+bKEd9Us9ELMADV1X9CH1S
 dNn30LPab/+nZ03eXRmln59RvTWeUH+VIBVmM/HEqJJzyxbxcYiaBtOvfLwq43pc2CzpeR71sh+
 uWcaOvwZagOOVjV5YRZf+/3SD0gLw/Ua17GR8eBZiIbA/25c6tnZ+nIm
X-Received: by 2002:a17:907:9612:b0:c29:d31f:7d73 with SMTP id
 a640c23a62f3a-c2e4ad7a260mr382705566b.9.1791002321066; Fri, 02 Oct 2026
 21:38:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260918-gpt-4k-v2-0-daefa4792e9f@flipper.net>
 <20260918-gpt-4k-v2-5-daefa4792e9f@flipper.net>
In-Reply-To: <20260918-gpt-4k-v2-5-daefa4792e9f@flipper.net>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 3 Oct 2026 05:38:29 +0100
X-Gm-Features: AclHuK_Zo9yVMm7m5nzTi84nECc0fvpjscFFF2A1aRqErN9TmFuQl6IVhlA4uOA
Message-ID: <CAFLszTiMEGG1EQCc_KgkMx=ff0zL7U0t34i_JjgK_u0qJvg72w@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] configs: malta64: Enable EFI_PARTITION and BLKMAP
 for big-endian tests
To: alchark@flipper.net
Cc: u-boot@lists.u-boot-project.org, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Denis Mukhin <dmukhin@ford.com>,
 Simon Glass <sjg@chromium.org>, Paul Burton <paulburton@kernel.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
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

On 2026-09-18T12:13:49, Alexey Charkov <alchark@flipper.net> wrote:
> configs: malta64: Enable EFI_PARTITION and BLKMAP for big-endian tests
>
> disk/part_efi.c has no big-endian coverage in CI, which is how its
> little-endian assumptions went unnoticed. The GPT tests in
> test/py/tests/test_gpt.py are restricted to sandbox because they rely on
> 'host bind', and test/dm/part.c is sandbox-only because UT_DM depends on
> SANDBOX.
>
> The two tests in test/lib/part_efi.c need neither. One works on a
> synthetic descriptor and the other on a memory-backed blkmap device, and
> test/lib/ is built for every board that enables CONFIG_UNIT_TEST. malta64
> already sets that and already runs the full pytest suite in CI as the
> qemu_malta64 job, so enabling EFI_PARTITION and BLKMAP is enough to have
> both tests built and executed on a big-endian target. The subtests are
> collected from u-boot.sym automatically, so CI needs no change.
>
> Pick malta64 rather than malta because the width matters. hdr_start and
> pte_start in gpt_fill_pte() are size_t, so on a 32-bit big-endian target
> an unconverted __le64 truncates to zero and the partition overlap check
> still happens to reject an overlap. On MIPS64 the same value stays large,
> the check accepts a partition that overlaps the entry array, and the test
> notices.
>
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
>
> configs/malta64_defconfig | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
