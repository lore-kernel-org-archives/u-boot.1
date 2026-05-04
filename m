Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECE84FF886F
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 12:09:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F32E8465E;
	Mon,  4 May 2026 14:09:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YL0DhEBx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3986B84659; Mon,  4 May 2026 14:09:53 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50E1280F0E
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 14:09:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-ba8472c1613so725337166b.0
 for <u-boot@lists.denx.de>; Mon, 04 May 2026 05:09:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777896591; cv=none;
 d=google.com; s=arc-20240605;
 b=QoAgvVQ1IL7hJlAnxaSc0vnxfbl3toPeiHtnBpksFi2YdWKdwl1BgOhvFjrn8s8CTW
 t4GTskzflahzfHwJpg2A4ZnA0JU0R1tu3nsLSUzKnWKLygPpAMGaWqu+R5Kv20S9T1yh
 mFfPfdOITfAl25dP0j7LyVtISQYM4ZpV5SI+jtsN2k6Wr4taT7SIzWojw0+Qhiy5tvJa
 +RpWPcL+bK91FbGKN5FLR06Ddb3izS4s7cW5wOaT1RBIjd7oB5oP6SDORGscM5anP2jw
 /hNwPow7QK5l2e2C37jCERz4Bv1WvNx71zYa71x/ydgwuZzyfiy++60l9T+OVGj/d4nV
 EdHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ZhzCsm/gVWnUkz0HkuaEozC1e8RDXO0hjmu0pukUFMY=;
 fh=jmbcoFG2RPEOJsmPKSiakkV0VWJqP8RiS13G+yktnmU=;
 b=W/7mxrDCy3St2W6LkqQphXMYihH522CM/wgnZ3EV1rPKnnd30HPgpeQ5jV9xZLcrFr
 uurcE/iN8MwJTGswT9WDfO5NTIcE79cWJZdahpcsAc2XVv8WYKOcB0SX1K/HD7ogMMd9
 JTqZB09VUmAkFJNki5BwrRB338mDLZ2ENfHxlbZM8ofGPtOW2qpsflCZSSNcEsleSU3m
 GSFBlutZiE6KNHQdz0Sv6TBVDz2FLSoF+GtVvZrORXhgCb9qnNKdgUwR4OrxntgU8t+S
 fVbIbY/9xgCuxC2ZvYcZlTc+Gqa0X1WqSXSL8+9KIT+i7A0/mmVQ8hqC07zaBVdVPfd1
 UwNQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777896591; x=1778501391; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZhzCsm/gVWnUkz0HkuaEozC1e8RDXO0hjmu0pukUFMY=;
 b=YL0DhEBxtKDX1KjPQuFIrt72vC/zG6un7+qp9Y/qnF8Zlb62s8xrfYPKs5DvM2Naoq
 lXYyGRNeAXeR0GT6q7dnTkmN9yRttRCu5rVPXlEpT6sf807eCPHQ353e9H4RLzLds7zh
 MHj3+m2viM8WtZ5LDMr9FTMySa0RNrW1LMKCM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777896591; x=1778501391;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZhzCsm/gVWnUkz0HkuaEozC1e8RDXO0hjmu0pukUFMY=;
 b=bJrBxlTCfpbryAOWS6f7/i3szzoIX7K+tSO6PcTOX+Ml8+vBtzltcqsKwxH5r0rwix
 Wxxvrk/vpszDl0z0Zzab3edC1H0QLHIUO0DuvsA4IOlvKOlHcvCPvOEYFSDzAa8dsLJl
 xwmJd1tqAMHyIPGt6BS9MynpZHpJNFFeoGGrbm7gRl2JKsVpVmwgk/x8sAlBCS198uSU
 GPf/Fi7Nd5QpwyZvkCBDGhKCapBmWYSldLDxUzDXKIMv/oZ1Raa7y4r8oAK34uOjd4wX
 C4+iX9L2RTX+IGYAAglFooVHI3tpp4nf+obqZ0ccQf54YN+JmkNaWn+WcCXo2x/y8Pue
 DmhQ==
X-Gm-Message-State: AOJu0YwNx9gbQnFftHcX+63MLW/jcqeFJBJqFMewoiL0UEd0tFr/Z5n2
 Fvg1a1NzWLa9zIbtRHOKm4uXwP5sdn8qkS5Hak1GGj3BB2EXwcf5G7d2jTkgKwds1bODGf47+8+
 0pP1Qb+wh+4Q37ZqqCRa5+rJ1KIn0rfOLxFmz3EIg5UaGzsWPvLM=
X-Gm-Gg: AeBDieu+8ufcW5F35+mWm3kdpm2Li0DnyVZqlnq0bW2MXPuX6Fkww3cisgRzsIo6BHN
 oBBHMGVUyS6s0ztPsr7MuM7kfbcE5nlMuOHj6iFuS2AHkWtsEo6kK/TqYC2td0JjWSOn5Gkgk00
 UeDH9uelLRDIEDGdhTr3QeXXOGRlYS/+D920y+8NUPxG9s0INSkkVl0pm87dGmiq09lp4rVGrle
 q1JwTM8BqlJKsEebFkncc478szjJJlgcYEqkhuMrzbWF0hyNXEHL7SypQ8+Qq5kZNh/WCOCUbg0
 nIA29xi7f0h1mnfA
X-Received: by 2002:a17:907:9724:b0:bc3:96fd:389b with SMTP id
 a640c23a62f3a-bc396fd38b9mr12020966b.18.1777896590767; Mon, 04 May 2026
 05:09:50 -0700 (PDT)
MIME-Version: 1.0
References: <3eeec4427b9ce9bb4abac4e27414ea1cb687e45b.1777443726.git.michal.simek@amd.com>
In-Reply-To: <3eeec4427b9ce9bb4abac4e27414ea1cb687e45b.1777443726.git.michal.simek@amd.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 4 May 2026 06:09:38 -0600
X-Gm-Features: AVHnY4LKjadj2j-DqF2ADFd9q83CL9Z0sPnPUPxg62GjVfc3hKESm_lCe4Qo82w
Message-ID: <CAFLszTi=aPPOFRG9JEeK++JYr4ygG82RfgyKLDvXaa=YXA40wQ@mail.gmail.com>
Subject: Re: [PATCH] fdt: check fdt_pack() return value in
 fdtdec_apply_bloblist_dtos()
To: michal.simek@amd.com
Cc: u-boot@lists.denx.de, git@amd.com
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 2026-04-29T06:22:08, Michal Simek <michal.simek@amd.com> wrote:
> fdt: check fdt_pack() return value in fdtdec_apply_bloblist_dtos()
>
> The fdt_pack() function can return an error code, but its return value
> was not being checked. Add proper error handling to propagate any
> failure.
>
> Also fix typo in comment: 'Shink' -> 'Shrink'.
>
> Addresses-Coverity-ID: CID 645839: Error handling issues (CHECKED_RETURN)
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> Reviewed-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
>
> lib/fdtdec.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
